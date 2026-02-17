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

Enhancement: Also strip common Rust numeric type suffixes such as `f32`, `f64`,
`u8`, `u16`, `u32`, `u64`, `i8`, etc., converting `6.0f32` -> `6.0`, `2u8` -> `2`.

"""

import argparse
import os
import re
import sys
from pathlib import Path

# Match hex and binary literals with optional suffix
HEX_BIN_RE = re.compile(r'(?<![\w])(?P<prefix>0x|0b)(?P<body>[0-9A-Fa-f_]+)(?P<suffix>[uUiIfF0-9a-zA-Z_]*)')

# Recognize common integer and float suffixes to remove
INT_SUFFIX_RE = re.compile(r'^(?:u(?:8|16|32|64|128)?|i(?:8|16|32|64|128)?|usize|isize)$', re.IGNORECASE)
FLOAT_SUFFIX_RE = re.compile(r'^(?:f(?:32|64))$', re.IGNORECASE)

# Regexes to strip suffixes from decimal literals (e.g., 6.0f32 -> 6.0, 2u8 -> 2)
DEC_FLOAT_SUFFIX_RE = re.compile(r'(?<![\w.])(?P<num>\d+\.\d+(?:[eE][+-]?\d+)?)(?P<suffix>f32|f64)\b')
DEC_INT_SUFFIX_RE = re.compile(r'(?<![\w.])(?P<num>\d+)(?P<suffix>u(?:8|16|32|64|128)?|i(?:8|16|32|64|128)?|usize|isize)\b', re.IGNORECASE)

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

    # If suffix is a known integer or float suffix, drop it (user requested)
    if suffix:
        s = suffix.strip()
        # Often suffixes are exactly like 'u8' or 'f32' possibly with mixed case
        if INT_SUFFIX_RE.match(s) or FLOAT_SUFFIX_RE.match(s):
            suffix = ''
        else:
            # Otherwise keep suffix as-is
            suffix = s

    return str(value) + suffix


def strip_decimal_suffixes(text: str) -> (str, int):
    """Strip f32/f64 and integer suffixes from decimal literals. Returns new text and count."""
    new_text, count1 = DEC_FLOAT_SUFFIX_RE.subn(lambda m: m.group('num'), text)
    new_text, count2 = DEC_INT_SUFFIX_RE.subn(lambda m: m.group('num'), new_text)
    return new_text, (count1 + count2)


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

    # 1) Convert hex/bin literals to decimal and drop known suffixes if present
    new_text, count_hexbin = HEX_BIN_RE.subn(convert_literal, text)

    # 2) Strip decimal suffixes like 6.0f32 -> 6.0 and integer suffixes 2u8 -> 2
    new_text_after_strip, count_strip = strip_decimal_suffixes(new_text)

    total_count = count_hexbin + count_strip

    if total_count > 0:
        if dry_run:
            print(f"[DRY] {path}: {total_count} replacements ({count_hexbin} hex/bin, {count_strip} suffixes)")
        else:
            if backup:
                bak = path.with_suffix(path.suffix + '.bak')
                bak.write_text(text, encoding='utf-8', errors='ignore')
            path.write_text(new_text_after_strip, encoding='utf-8')
            print(f"[OK]  {path}: {total_count} replacements (written)")
    return total_count


def should_process(file_path: Path, exts) -> bool:
    if file_path.suffix in exts:
        return True
    # also process files without extension but under src/
    if file_path.suffix == '' and 'src' in file_path.parts:
        return True
    return False


def main():
    parser = argparse.ArgumentParser(description='Convert 0x/0b literals to decimal across files and strip type suffixes')
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
