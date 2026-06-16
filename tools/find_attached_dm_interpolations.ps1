#!/usr/bin/env pwsh
<#
.SYNOPSIS
Finds DM string interpolations like `texto[algo]` or `[algo]texto` that are
probably missing spaces, with optional in-place fixes.

.DESCRIPTION
Scans `.dm` files under the configured roots, skips common non-gameplay
directories, and reports string literals that look like human-facing text with
 attached `[...]` interpolation tokens.

By default the script only reports matches. Pass `-Apply` to rewrite the string
literals in place.

.PARAMETER Apply
Rewrites matching string literals in place.

.PARAMETER IncludeRoots
Top-level roots to scan.

.PARAMETER ExcludePatterns
Wildcard path fragments to skip.

.EXAMPLE
.\tools\find_attached_dm_interpolations.ps1

.EXAMPLE
.\tools\find_attached_dm_interpolations.ps1 -Apply

.EXAMPLE
.\tools\find_attached_dm_interpolations.ps1 -IncludeRoots code,modular_zubbers
#>

param(
	[switch]$Apply,
	[string[]]$IncludeRoots = @('code', 'modular_zubbers', 'modular_skyrat'),
	[string[]]$ExcludePatterns = @(
		'.github',
		'tools',
		'tgui',
		'_maps',
		'maps',
		'code\__HELPERS',
		'code\__DEFINES',
		'modular_zubbers\tools',
		'modular_skyrat\modules\admin'
	)
)

$ErrorActionPreference = 'Stop'

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$workspaceRoot = Split-Path -Parent $scriptRoot
$beforePattern = '([\p{L}\p{Nd}_])(\[[^\]\r\n]+\])'
$afterPattern = '(\[[^\]\r\n]+\])([\p{L}\p{Nd}_])'
$combinedPattern = '(?<before>[\p{L}\p{Nd}_]\[[^\]\r\n]+\])|(?<after>\[[^\]\r\n]+\][\p{L}\p{Nd}_])'
$stringPattern = '"(?:[^"\\]|\\.)*"'
$messageContextPattern = '(to_chat|visible_message|show_message|balloon_alert|audible_message|span_[a-z_]+|examine_list\s*\+=|desc\s*=|name\s*=|message\s*=)'
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Test-Utf8Bytes {
	param([byte[]]$Bytes)

	try {
		$null = $utf8NoBom.GetString($Bytes)
		$roundTrip = $utf8NoBom.GetBytes($utf8NoBom.GetString($Bytes))
		if ($roundTrip.Length -ne $Bytes.Length) {
			return $false
		}

		for ($i = 0; $i -lt $Bytes.Length; $i++) {
			if ($Bytes[$i] -ne $roundTrip[$i]) {
				return $false
			}
		}

		return $true
	}
	catch {
		return $false
	}
}

function Get-FileTextWithEncoding {
	param([string]$Path)

	$bytes = [System.IO.File]::ReadAllBytes($Path)
	$encoding = $null
	$preambleLength = 0

	if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
		$encoding = [System.Text.Encoding]::UTF8
		$preambleLength = 3
	} elseif ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE) {
		$encoding = [System.Text.Encoding]::Unicode
		$preambleLength = 2
	} elseif ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFE -and $bytes[1] -eq 0xFF) {
		$encoding = [System.Text.Encoding]::BigEndianUnicode
		$preambleLength = 2
	} elseif (Test-Utf8Bytes $bytes) {
		$encoding = $utf8NoBom
	} else {
		$encoding = [System.Text.Encoding]::Default
	}

	$contentBytes =
		if ($preambleLength -gt 0) {
			$bytes[$preambleLength..($bytes.Length - 1)]
		} else {
			$bytes
		}

	$content = $encoding.GetString($contentBytes)
	$content = $content -replace "`r`r`n", "`r`n"

	return @{
		Content = $content
		Encoding = $encoding
		HasBom = ($preambleLength -gt 0)
	}
}

function Write-FileTextPreservingEncoding {
	param(
		[string]$Path,
		[string]$Content,
		[System.Text.Encoding]$Encoding,
		[bool]$HasBom
	)

	$bytes = $Encoding.GetBytes($Content)
	if ($HasBom) {
		$preamble = $Encoding.GetPreamble()
		if ($preamble.Length -gt 0) {
			$bytesWithBom = New-Object byte[] ($preamble.Length + $bytes.Length)
			[System.Buffer]::BlockCopy($preamble, 0, $bytesWithBom, 0, $preamble.Length)
			[System.Buffer]::BlockCopy($bytes, 0, $bytesWithBom, $preamble.Length, $bytes.Length)
			$bytes = $bytesWithBom
		}
	}

	[System.IO.File]::WriteAllBytes($Path, $bytes)
}

function Test-ExcludedPath {
	param([string]$FullPath)

	$relativePath = $FullPath.Replace($workspaceRoot, '').TrimStart('\', '/')
	foreach ($pattern in $ExcludePatterns) {
		if ($relativePath -like "*$pattern*") {
			return $true
		}
	}

	return $false
}

function Test-HumanFacingString {
	param([string]$Value)

	if ($Value -notmatch $combinedPattern) {
		return $false
	}

	if ($Value -notmatch '[\s\.,!?:;()]') {
		return $false
	}

	if ($Value -match '^[A-Za-z0-9_\-\[\]\(\)\?:]+$') {
		return $false
	}

	return $true
}

function Repair-StringLiteral {
	param([string]$Value)

	$updated = $Value
	$updated = [regex]::Replace($updated, $beforePattern, '$1 $2')
	$updated = [regex]::Replace($updated, $afterPattern, '$1 $2')
	return $updated
}

function Format-Preview {
	param(
		[string]$Before,
		[string]$After
	)

	if ($Before -eq $After) {
		return $Before
	}

	return "$Before -> $After"
}

$files = foreach ($root in $IncludeRoots) {
	$resolvedRoot = Join-Path $workspaceRoot $root
	if (Test-Path $resolvedRoot) {
		Get-ChildItem -Path $resolvedRoot -Recurse -File -Filter *.dm
	}
}

$files = $files | Where-Object { -not (Test-ExcludedPath $_.FullName) }

$totalMatches = 0
$changedFiles = 0

foreach ($file in $files) {
	$fileData = Get-FileTextWithEncoding $file.FullName
	$originalContent = $fileData.Content
	$lineEnding = if ($originalContent -match "`r`n") { "`r`n" } else { "`n" }
	$lines = $originalContent -split '\r?\n', 0
	$fileChanged = $false

	for ($index = 0; $index -lt $lines.Count; $index++) {
		$lineNumber = $index + 1
		$line = $lines[$index]

		if ($line -notmatch $messageContextPattern) {
			continue
		}

		$stringMatches = [regex]::Matches($line, $stringPattern)
		if ($stringMatches.Count -eq 0) {
			continue
		}

		$updatedLine = $line
		$offset = 0

		foreach ($stringMatch in $stringMatches) {
			$stringLiteral = $stringMatch.Value
			$stringValue = $stringLiteral.Substring(1, $stringLiteral.Length - 2)

			if (-not (Test-HumanFacingString $stringValue)) {
				continue
			}

			$repairedValue = Repair-StringLiteral $stringValue
			if ($repairedValue -eq $stringValue) {
				continue
			}

			$totalMatches++
			$relativePath = $file.FullName.Replace($workspaceRoot, '').TrimStart('\', '/')
			Write-Host "$relativePath`:$lineNumber" -ForegroundColor Cyan
			Write-Host ("  " + (Format-Preview -Before $stringValue -After $repairedValue)) -ForegroundColor Yellow

			if ($Apply) {
				$replacement = '"' + $repairedValue + '"'
				$start = $stringMatch.Index + $offset
				$length = $stringMatch.Length
				$updatedLine = $updatedLine.Remove($start, $length).Insert($start, $replacement)
				$offset += $replacement.Length - $length
				$fileChanged = $true
			}
		}

		if ($Apply -and $fileChanged) {
			$lines[$index] = $updatedLine
		}
	}

	if ($Apply -and $fileChanged) {
		$newContent = [string]::Join($lineEnding, $lines)
		Write-FileTextPreservingEncoding -Path $file.FullName -Content $newContent -Encoding $fileData.Encoding -HasBom $fileData.HasBom
		$changedFiles++
	}
}

Write-Host ''
Write-Host "Matches found: $totalMatches" -ForegroundColor Green

if ($Apply) {
	Write-Host "Files changed: $changedFiles" -ForegroundColor Green
} else {
	Write-Host 'Dry run only. Re-run with -Apply to write changes.' -ForegroundColor DarkYellow
}
