#!/usr/bin/env python3
"""
Uses git diff to find files with suspicious amounts of added/removed lines.
This typically indicates corruption or translator issues.
Files with 100+ lines added AND 100+ lines removed in the same file are flagged.
"""

import subprocess
import sys
import re
from pathlib import Path


def run_git_command(cmd, cwd=None):
    """Run a git command and return output."""
    try:
        result = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True, shell=True)
        return result.stdout.strip(), result.returncode
    except Exception as e:
        print(f"Error running command: {e}")
        return "", 1


def find_corrupted_files_via_git(repo_root=None, threshold=100, file_patterns=None, dry_run=True):
    """
    Find files with suspicious line changes using git diff.
    Looks for files with many lines added AND removed (corruption indicator).
    """

    if file_patterns is None:
        file_patterns = ['*.dm', '*.tsx', '*.ts']

    corrupted_files = []

    # Build the file pattern part of the command
    pattern_args = ' '.join([f"'{p}'" for p in file_patterns])

    # Get diff stats for files
    cmd = f"git diff --stat HEAD -- {pattern_args}"
    print(f"Running: {cmd}\n")

    output, code = run_git_command(cmd, cwd=repo_root)

    if code != 0:
        print(f"Git command failed: {code}")
        print(output)
        return []

    # Parse diff output: lines look like "filename | 150 ++++-----"
    # We want to find lines with both significant additions and deletions
    for line in output.split('\n'):
        if not line.strip():
            continue

        # Pattern: "path/to/file | 250 ++++++++++-----"
        match = re.match(r'^(.+?)\s+\|\s+(\d+)\s+(.*)$', line)
        if not match:
            continue

        filepath = match.group(1).strip()
        changes = match.group(3).strip()

        # Count + and - signs
        additions = changes.count('+')
        deletions = changes.count('-')

        # Flag files with both significant additions AND deletions
        if additions >= threshold and deletions >= threshold:
            corrupted_files.append((filepath, additions, deletions))
            print(f"SUSPICIOUS: {filepath}")
            print(f"  Additions: {additions}, Deletions: {deletions}")

    return corrupted_files


def revert_files(files, repo_root=None, dry_run=True):
    """Revert files to HEAD state."""

    if not files:
        print("No files to revert.")
        return 0

    print(f"\n{'Would revert' if dry_run else 'Reverting'} {len(files)} file(s):")

    for filepath, _, _ in files:
        print(f"  {filepath}")

        if not dry_run:
            cmd = f'git checkout HEAD -- "{filepath}"'
            output, code = run_git_command(cmd, cwd=repo_root)
            if code == 0:
                print(f"    ✓ Reverted")
            else:
                print(f"    ✗ Failed: {output}")

    return len(files)


def main():
    repo_root = sys.argv[1] if len(sys.argv) > 1 else None
    action = sys.argv[2].lower() if len(sys.argv) > 2 else 'dryrun'
    threshold = int(sys.argv[3]) if len(sys.argv) > 3 else 100

    dry_run = action != 'run'

    print(f"Repository: {repo_root or 'current directory'}")
    print(f"Mode: {'DRY RUN' if dry_run else 'ACTUAL RUN'}")
    print(f"Threshold: {threshold}+ lines added/removed\n")
    print("=" * 60 + "\n")

    # For .dm files
    corrupted_files = find_corrupted_files_via_git(repo_root, threshold, ['*.dm'], dry_run)

    if corrupted_files:
        print(f"\nFound {len(corrupted_files)} suspicious .dm file(s)\n")

        if action == 'run':
            revert_files(corrupted_files, repo_root, dry_run=False)
        else:
            print("To revert these files, run with 'run' argument:")
            repo_path = repo_root or '.'
            print(f"python find_and_fix_corrupted_files.py \"{repo_path}\" run {threshold}")
    else:
        print("No suspicious files found.")


if __name__ == '__main__':
    sys.exit(main())
