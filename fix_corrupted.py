#!/usr/bin/env python3
import argparse
import subprocess
import sys
from pathlib import Path

EXTENSIONS = [".dm", ".tsx", ".ts"]
DEFAULT_THRESHOLD = 100


def run_git_diff_numstat(root: Path) -> list[str]:
    cmd = ["git", "diff", "--numstat", "--"] + [f"*{ext}" for ext in EXTENSIONS]
    result = subprocess.run(cmd, cwd=root, capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(
            f"git diff failed: {result.stderr.strip() or result.stdout.strip()}"
        )
    lines = [line for line in result.stdout.splitlines() if not line.startswith("warning:")]
    return lines


def parse_numstat_line(line: str) -> tuple[int, int, str] | None:
    parts = line.split("\t")
    if len(parts) < 3:
        return None
    try:
        adds = int(parts[0])
        dels = int(parts[1])
    except ValueError:
        return None
    path = parts[2].strip()
    return adds, dels, path


def find_suspicious_files(lines: list[str], threshold: int) -> list[tuple[str, int, int]]:
    suspicious = []
    for line in lines:
        parsed = parse_numstat_line(line)
        if not parsed:
            continue
        adds, dels, path = parsed
        if adds == 0 and dels == 0:
            continue
        if adds >= threshold and dels >= threshold:
            suspicious.append((path, adds, dels))
    return suspicious


def revert_files(root: Path, files: list[str]) -> int:
    failures = 0
    for path in files:
        result = subprocess.run(["git", "checkout", "HEAD", "--", path], cwd=root)
        if result.returncode == 0:
            print(f"  OK: {path}")
        else:
            print(f"  FAILED: {path}")
            failures += 1
    return failures


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Find suspicious git-modified files and optionally revert them."
    )
    parser.add_argument(
        "-t", "--threshold",
        type=int,
        default=DEFAULT_THRESHOLD,
        help=f"Minimum added and deleted lines to mark a file suspicious (default {DEFAULT_THRESHOLD}).",
    )
    parser.add_argument(
        "-r", "--run",
        action="store_true",
        help="Actually revert suspicious files instead of doing a dry run.",
    )
    args = parser.parse_args()

    root = Path.cwd()
    print(f"Searching for corrupted files (threshold: {args.threshold}+")
    print(f"Mode: {'REVERT' if args.run else 'DRY RUN'}\n")

    try:
        lines = run_git_diff_numstat(root)
    except RuntimeError as exc:
        print(str(exc), file=sys.stderr)
        return 1

    print(f"Checking {len(lines)} files...\n")
    suspicious = find_suspicious_files(lines, args.threshold)

    if not suspicious:
        print("✓ No suspicious files found.")
        return 0

    print(f"Found {len(suspicious)} file(s) to fix\n")
    for path, adds, dels in suspicious:
        print(f"SUSPICIOUS: {path}")
        print(f"  +{adds}, -{dels}\n")

    if args.run:
        print("Reverting files...")
        failures = revert_files(root, [path for path, *_ in suspicious])
        print("\nDone!")
        return failures

    print("Files to revert:")
    for path, *_ in suspicious:
        print(f"  - {path}")
    print("\nTo actually revert, run:")
    print(f"  python fix_corrupted.py --threshold {args.threshold} --run")
    return len(suspicious)


if __name__ == "__main__":
    raise SystemExit(main())
