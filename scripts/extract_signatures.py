#!/usr/bin/env python3
"""
Extracts public intrinsic function signatures from stdarch x86/x86_64 source
files, joining multi-line signatures into a single line.

Output format matches signatures.txt:
  path/to/file.rs
  LINENUM:pub [unsafe] fn _mm_xxx(a: T, b: T) -> T {

Usage:
  python3 scripts/extract_signatures.py [--files avx2.rs sse.rs ...]

Without --files: processes all x86 + x86_64 source files found in STDARCH_DIR.
"""

import re
import sys
import argparse
from pathlib import Path

STDARCH_DIR = Path(
    "TODO"
)

X86_DIR    = STDARCH_DIR / "x86"
X86_64_DIR = STDARCH_DIR / "x86_64"

# Only emit functions whose names start with these prefixes
INTRINSIC_PREFIXES = ("_mm",)

# Files to skip (not intrinsic modules)
SKIP_FILES = {"mod.rs", "macros.rs", "test.rs"}


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

    fn_re = re.compile(r"^pub\s+(unsafe\s+)?fn\s+(_mm\w+)")

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
    out: dict[str, list[tuple[int, str]]] = {}
    for rs in sorted(src_dir.glob("*.rs")):
        if rs.name in SKIP_FILES:
            continue
        if only_stems and rs.stem not in only_stems:
            continue
        sigs = extract_file(rs, rel_prefix)
        if sigs:
            key = f"{rel_prefix}/{rs.name}"
            out[key] = sigs
    return out


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--files", nargs="*", metavar="FILE",
        help="Specific filenames (e.g. avx2.rs sse2.rs) to extract; "
             "searches both x86/ and x86_64/. Default: all files.",
    )
    parser.add_argument(
        "--out", metavar="PATH",
        help="Write output to this file instead of stdout.",
    )
    args = parser.parse_args()

    only_stems: set[str] | None = None
    if args.files:
        only_stems = {Path(f).stem for f in args.files}

    sections: dict[str, list[tuple[int, str]]] = {}
    sections.update(process_dir(X86_DIR,    "src/x86",    only_stems))
    sections.update(process_dir(X86_64_DIR, "src/x86_64", only_stems))

    lines_out: list[str] = []
    for file_key, sigs in sections.items():
        lines_out.append(file_key)
        for lineno, sig in sigs:
            lines_out.append(f"{lineno}:{sig}")
        lines_out.append("")

    output = "\n".join(lines_out)

    if args.out:
        Path(args.out).write_text(output)
        total = sum(len(v) for v in sections.values())
        print(f"Wrote {total} signatures from {len(sections)} files → {args.out}")
    else:
        print(output)


if __name__ == "__main__":
    main()
