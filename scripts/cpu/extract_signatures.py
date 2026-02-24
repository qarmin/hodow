#!/usr/bin/env python3
"""
Extracts public intrinsic function signatures from all architecture source
files, joining multi-line signatures into a single line.

Output format:
  arch/path/to/file.rs
  LINENUM:pub [unsafe] fn function_name(a: T, b: T) -> T {

Usage:
  python3 scripts/cpu/extract_signatures.py [--archs x86 arm ...]
  python3 scripts/cpu/extract_signatures.py [--out custom_output.txt]

Without --archs: processes all architectures found in ARCHS_DIR.
"""

import re
import sys
import argparse
from pathlib import Path

# Folder needs to be copied from stdlib -> library/stdarch/crates/core_arch/src
ARCHS_DIR = Path("archs")

# Architecture directories to scan
ARCHITECTURES = [
    "x86", "x86_64", "arm", "aarch64",
    "riscv32", "riscv64", "riscv_shared",
    "arm_shared", "loongarch32", "loongarch64", "loongarch_shared",
    "mips", "nvptx", "powerpc", "powerpc64", "s390x", "wasm32"
]

# Files to skip (not intrinsic modules)
SKIP_FILES = {"mod.rs", "macros.rs", "test.rs", "test_support.rs", "generated.rs"}


def collapse_signature(lines: list[str], start: int) -> tuple[str, int] | None:
    """
    Starting at `start` (a line beginning with `pub [unsafe] fn _mm...`),
    collect lines until the signature closing `) -> RetType {` or `) {`
    and return (collapsed_one_liner, last_line_index).
    Returns None if the pattern doesn't close properly.
    """
    collected = []
    i = start
    while i < len(lines):
        raw = lines[i].rstrip()
        collected.append(raw.strip())
        # Signature is complete when we see `{` after the closing `)`
        joined = " ".join(collected)
        # The opening paren may be on the first line or a later one
        # We're done when:
        #  - there's a `{` at the end (body starts)
        #  - AND we've seen the closing `)` somewhere
        if "{" in joined and ")" in joined:
            sig = re.sub(r"\s+", " ", joined).strip()
            # Clean up spaces inside parens from multi-line joins
            sig = re.sub(r"\(\s+", "(", sig)
            sig = re.sub(r",\s*\)", ")", sig)   # trailing comma before )
            sig = re.sub(r"\s+\)", ")", sig)
            if not sig.endswith("{"):
                sig = sig.rstrip(";").rstrip() + " {"
            return sig, i
        i += 1
    return None


def extract_file(path: Path, rel_prefix: str) -> list[tuple[int, str]]:
    """
    Returns list of (1-based line number, collapsed signature string)
    for every public intrinsic function in `path`.
    """
    text = path.read_text(encoding="utf-8", errors="replace")
    lines = text.splitlines()
    results = []

    # Match any public function (not limited to specific prefixes)
    fn_re = re.compile(r"^pub\s+(unsafe\s+)?fn\s+(\w+)")

    i = 0
    while i < len(lines):
        m = fn_re.match(lines[i].strip())
        if m:
            result = collapse_signature(lines, i)
            if result is not None:
                sig, end = result
                results.append((i + 1, sig))  # 1-based
                i = end + 1
                continue
        i += 1

    return results


def process_dir(src_dir: Path, rel_prefix: str,
                only_stems: set[str] | None) -> dict[str, list[tuple[int, str]]]:
    """Process a directory and its subdirectories for .rs files."""
    out: dict[str, list[tuple[int, str]]] = {}

    # Process .rs files directly in this directory
    for rs in sorted(src_dir.glob("*.rs")):
        if rs.name in SKIP_FILES:
            continue
        if only_stems and rs.stem not in only_stems:
            continue
        sigs = extract_file(rs, rel_prefix)
        if sigs:
            key = f"{rel_prefix}/{rs.name}"
            out[key] = sigs

    # Process subdirectories (like aarch64/neon/)
    for subdir in sorted(src_dir.iterdir()):
        if subdir.is_dir() and subdir.name not in SKIP_FILES:
            for rs in sorted(subdir.glob("*.rs")):
                if rs.name in SKIP_FILES:
                    continue
                if only_stems and rs.stem not in only_stems:
                    continue
                sigs = extract_file(rs, rel_prefix)
                if sigs:
                    key = f"{rel_prefix}/{subdir.name}/{rs.name}"
                    out[key] = sigs

    return out


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--archs", nargs="*", metavar="ARCH",
        help="Specific architectures to extract (e.g. x86 arm aarch64). Default: all.",
    )
    parser.add_argument(
        "--files", nargs="*", metavar="FILE",
        help="Specific filenames (e.g. avx2.rs sse2.rs neon.rs) to extract. Default: all files.",
    )
    parser.add_argument(
        "--out", metavar="PATH",
        help="Write output to this file. Default: hodow_core/src/cpu/signatures.txt",
    )
    args = parser.parse_args()

    only_stems: set[str] | None = None
    if args.files:
        only_stems = {Path(f).stem for f in args.files}

    # Determine which architectures to process
    archs_to_process = args.archs if args.archs else ARCHITECTURES

    sections: dict[str, list[tuple[int, str]]] = {}

    for arch in archs_to_process:
        arch_dir = ARCHS_DIR / arch
        if not arch_dir.exists() or not arch_dir.is_dir():
            print(f"Warning: Architecture directory {arch_dir} not found, skipping", file=sys.stderr)
            continue

        sections.update(process_dir(arch_dir, f"{arch}", only_stems))

    lines_out: list[str] = []
    for file_key, sigs in sorted(sections.items()):
        lines_out.append(file_key)
        for lineno, sig in sigs:
            lines_out.append(f"{lineno}:{sig}")
        lines_out.append("")

    output = "\n".join(lines_out)

    # Default output path
    out_path = Path(args.out) if args.out else Path("hodow_core/src/cpu/signatures.txt")

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(output)

    total = sum(len(v) for v in sections.values())
    print(f"Wrote {total} signatures from {len(sections)} files → {out_path}")


if __name__ == "__main__":
    main()
