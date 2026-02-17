#!/usr/bin/env python3
"""
convert_literals.py

Recursively scan files and replace hexadecimal (0x...) and binary (0b...) integer
literals with decimal equivalents, preserving any type suffixes (like u8, u32, i64).

Usage:
    python3 scripts/convert_literals.py [path] [--ext .rs .c ...] [--dry-run] [--backup]

Defaults:
    path: current directory (.)
    ext: .rs .c .h .cpp .hpp .cc .py .txt .md .toml
    dry-run: True by default
    backup: create .bak files when modifying

Notes:
- This script performs simple textual replacements using regex and does not
  parse language syntax. It aims to convert standalone numeric literals like
  `0xFF`, `0b1011u8`, `0x1A_u32` into decimal forms like `255`, `11u8`, `26u32`.
- It will not attempt to avoid replacements inside string literals or comments.
  Use with care and review diffs or run with --dry-run first.

"""

import argparse
import os
import re
import sys
from pathlib import Path

HEX_BIN_RE = re.compile(r'(?<![\w])(?P<prefix>0x|0b)(?P<body>[0-9A-Fa-f_]+)(?P<suffix>[uUiIfF0-9a-zA-Z_]*)')

DEFAULT_EXTS = ['.rs', '.c', '.h', '.cpp', '.hpp', '.cc', '.py', '.txt', '.md', '.toml']


def convert_literal(match: re.Match) -> str:
    prefix = match.group('prefix')
    body = match.group('body')
    suffix = match.group('suffix') or ''
    body_norm = body.replace('_', '')
    try:
        if prefix == '0x':
            value = int(body_norm, 16)
        else:
            value = int(body_norm, 2)
    except Exception:
        # If parsing fails, return original text unchanged
        return match.group(0)
    return str(value) + suffix


def process_file(path: Path, dry_run: bool = True, backup: bool = True) -> int:
    """Process a single file; return number of replacements made."""
    try:
        text = path.read_text(encoding='utf-8')
    except Exception:
        # try with latin1 fallback
        try:
            text = path.read_text(encoding='latin-1')
        except Exception:
            return 0

    new_text, count = HEX_BIN_RE.subn(convert_literal, text)
    if count > 0:
        if dry_run:
            print(f"[DRY] {path}: {count} replacements")
        else:
            if backup:
                bak = path.with_suffix(path.suffix + '.bak')
                bak.write_text(text, encoding='utf-8', errors='ignore')
            path.write_text(new_text, encoding='utf-8')
            print(f"[OK]  {path}: {count} replacements (written)")
    return count


def should_process(file_path: Path, exts) -> bool:
    if file_path.suffix in exts:
        return True
    # also process files without extension but under src/
    if file_path.suffix == '' and 'src' in file_path.parts:
        return True
    return False


def main():
    parser = argparse.ArgumentParser(description='Convert 0x/0b literals to decimal across files')
    parser.add_argument('path', nargs='?', default='.', help='Root path to scan')
    parser.add_argument('--ext', nargs='*', default=DEFAULT_EXTS, help='File extensions to process')
    parser.add_argument('--dry-run', action='store_true', default=True, help='Only show replacements')
    parser.add_argument('--no-dry-run', dest='dry_run', action='store_false', help='Actually write changes')
    parser.add_argument('--no-backup', dest='backup', action='store_false', help='Do not create .bak backup files')
    parser.add_argument('--max-files', type=int, default=0, help='Limit number of files processed (0 = no limit)')
    args = parser.parse_args()

    root = Path(args.path)
    exts = set(args.ext)
    total_repl = 0
    files_processed = 0

    for dirpath, dirnames, filenames in os.walk(root):
        # skip target directory
        if 'target' in dirpath.split(os.sep):
            continue
        for fn in filenames:
            fp = Path(dirpath) / fn
            if not should_process(fp, exts):
                continue
            repl = process_file(fp, dry_run=args.dry_run, backup=args.backup)
            if repl > 0:
                total_repl += repl
            files_processed += 1
            if args.max_files and files_processed >= args.max_files:
                break
        if args.max_files and files_processed >= args.max_files:
            break

    print('\nSummary:')
    print(f'Files scanned: {files_processed}')
    print(f'Total replacements: {total_repl}')

    if total_repl > 0 and args.dry_run:
        print('\nRun with --no-dry-run to apply changes (and --no-backup to skip backups)')


if __name__ == '__main__':
    main()
