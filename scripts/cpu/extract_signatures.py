#!/usr/bin/env python3
"""
Extracts public intrinsic function signatures from all architecture source
files, joining multi-line signatures into a single line.

Output format:
  arch/path/to/file.rs
  LINENUM:pub [unsafe] fn function_name(a: T, b: T) -> T {

Reads stdarch straight out of the pinned toolchain's `rust-src` component, so the extraction
always matches the compiler the project builds with and there is nothing to copy by hand.
`--src` overrides that, for extracting from a different stdarch than the toolchain ships.

Usage:
  python3 scripts/cpu/extract_signatures.py [--archs x86 arm ...]
  python3 scripts/cpu/extract_signatures.py [--out custom_output.txt]
  python3 scripts/cpu/extract_signatures.py [--src path/to/core_arch/src]

Without --archs: processes every architecture in ARCHITECTURES.
"""

import re
import sys
import argparse
import subprocess
from pathlib import Path

STDARCH_SUBPATH = Path("lib/rustlib/src/rust/library/stdarch/crates/core_arch/src")


def default_src(toolchain: str | None) -> Path:
    """stdarch inside the active (or given) toolchain's sysroot."""
    cmd = ["rustc", "--print", "sysroot"] + ([] if toolchain is None else [])
    if toolchain:
        cmd = ["rustc", f"+{toolchain}", "--print", "sysroot"]
    sysroot = subprocess.run(cmd, capture_output=True, text=True, check=True).stdout.strip()
    return Path(sysroot) / STDARCH_SUBPATH

# Architecture directories to scan
ARCHITECTURES = [
    "x86", "x86_64", "arm", "aarch64",
    "riscv32", "riscv64", "riscv_shared",
    "arm_shared", "loongarch32", "loongarch64", "loongarch_shared",
    "mips", "nvptx", "powerpc", "powerpc64", "s390x", "wasm32"
]

# Files to skip (not intrinsic modules). NOTE: `generated.rs` was here too until this was
# found to be silently dropping every NEON intrinsic in existence - stdarch's real x86/x86_64
# bodies live in per-extension files (avx2.rs, sse2.rs, ...) so the name never matched there,
# but arm_shared/neon/, aarch64/neon/ literally name their generated body file `generated.rs`.
SKIP_FILES = {"mod.rs", "macros.rs", "test.rs", "test_support.rs"}

# Directories to skip entirely - none currently. aarch64/sve and aarch64/sve2 (scalable-vector
# types, svfloat32_t/svbool_t/...) are handled by a dedicated value-construction path in
# generate_tests.py (broadcast via svdup_n_*, extract via svlastb_*/svptest_any - see
# CLAUDE.md's "Non-x86 architectures" section) rather than the fixed-size-array model every
# other vector type uses, since the hardware vector length is runtime-determined.
SKIP_DIRS: set[str] = set()


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


_HARD_ARCH_GATE_RE = re.compile(r'^#\[cfg\(target_arch\s*=\s*"(arm|aarch64)"\)\]$')
_PLAIN_TF_RE = re.compile(r'^#\[target_feature\(enable\s*=\s*"([^"]+)"\)\]$')
_ARM_ONLY_TF_RE = re.compile(r'^#\[cfg_attr\(target_arch\s*=\s*"arm",\s*target_feature\(enable\s*=\s*"([^"]+)"\)\)\]$')


def find_target_features(lines: list[str], fn_idx: int) -> tuple[list[str], list[str]]:
    """The features the function actually needs, straight from its own attributes: the
    unconditional `#[target_feature(enable = "...")]` set, and separately the extra one
    `#[cfg_attr(target_arch = "arm", ...)]` adds on 32-bit ARM only.

    Bucketing by source file alone is what put `__crc32b` (which needs `crc`) and
    `vaesdq_u8` (`aes`) into the `neon` group, where a NEON-only CPU ran them and took a
    SIGILL. Same backward walk as find_hard_arch_gate, for the same multi-line reason."""
    base: list[str] = []
    arm_only: list[str] = []
    depth = 0
    j = fn_idx - 1
    while j >= 0:
        stripped = lines[j].strip()
        if not stripped:
            j -= 1
            continue
        depth += stripped.count(")") - stripped.count("(")
        if depth <= 0:
            if m := _PLAIN_TF_RE.match(stripped):
                base = m.group(1).split(",") + base
            elif m := _ARM_ONLY_TF_RE.match(stripped):
                arm_only = m.group(1).split(",") + arm_only
            elif not stripped.startswith("#["):
                break
        j -= 1
    return base, arm_only


def find_hard_arch_gate(lines: list[str], fn_idx: int) -> str | None:
    """Look at the attribute lines directly above `fn_idx` for a bare, single-target
    `#[cfg(target_arch = "arm")]`/`#[cfg(target_arch = "aarch64")]` - a real compile-time
    exclusion (the function doesn't exist at all on the other arch), as opposed to a
    `cfg_attr(not(target_arch = ...), stable(...))`-style stability split, which doesn't
    exclude anything. Matters only for `arm_shared/` sources, compiled unconditionally for
    both arm and aarch64 (see hodow_core's auto_generated/mod.rs `cfg(any(arm, aarch64))`).

    Walks backward tracking paren balance, not just "does this line start with #[" -
    stdarch often wraps a single logical attribute (`cfg_attr(\\n ...,\\n ...\\n)]`) across
    several physical lines, and a naive single-line check stops at the first continuation
    line (e.g. a lone `)]`), missing a real `#[cfg(target_arch = ...)]` sitting further up."""
    depth = 0
    j = fn_idx - 1
    while j >= 0:
        stripped = lines[j].strip()
        if not stripped:
            j -= 1
            continue
        depth += stripped.count(")") - stripped.count("(")
        if depth <= 0 and _HARD_ARCH_GATE_RE.match(stripped):
            return _HARD_ARCH_GATE_RE.match(stripped).group(1)
        if depth <= 0 and not stripped.startswith("#["):
            break  # walked past the attribute run into unrelated code
        j -= 1
    return None


def extract_file(path: Path, rel_prefix: str) -> list[tuple[int, str, str | None, tuple[list[str], list[str]]]]:
    """
    Returns list of (1-based line number, collapsed signature string, arch-only constraint)
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
            arch_only = find_hard_arch_gate(lines, i)
            features = find_target_features(lines, i)
            result = collapse_signature(lines, i)
            if result is not None:
                sig, end = result
                results.append((i + 1, sig, arch_only, features))  # 1-based
                i = end + 1
                continue
        i += 1

    return results


def process_dir(src_dir: Path, rel_prefix: str,
                only_stems: set[str] | None) -> dict[str, list[tuple[int, str, str | None, tuple[list[str], list[str]]]]]:
    """Process a directory and its subdirectories for .rs files."""
    out: dict[str, list[tuple[int, str, str | None, tuple[list[str], list[str]]]]] = {}

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
        if subdir.is_dir() and subdir.name not in SKIP_FILES and subdir.name not in SKIP_DIRS:
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
        help="Write output to this file. Default: data/cpu/signatures.txt",
    )
    parser.add_argument(
        "--src", metavar="DIR",
        help="stdarch core_arch/src to read. Default: the toolchain's own, via `rustc --print sysroot`.",
    )
    parser.add_argument(
        "--toolchain", metavar="NAME",
        help="Toolchain to take stdarch from (e.g. nightly-2026-08-21). Default: the active one.",
    )
    args = parser.parse_args()

    if args.src:
        archs_dir = Path(args.src)
    else:
        archs_dir = default_src(args.toolchain)
        if not archs_dir.is_dir():
            parser.error(
                f"{archs_dir} not found - the toolchain has no `rust-src` component.\n"
                f"Install it with: rustup component add rust-src"
                + (f" --toolchain {args.toolchain}" if args.toolchain else "")
            )
    print(f"Reading stdarch from {archs_dir}", file=sys.stderr)

    only_stems: set[str] | None = None
    if args.files:
        only_stems = {Path(f).stem for f in args.files}

    # Determine which architectures to process
    archs_to_process = args.archs if args.archs else ARCHITECTURES

    sections: dict[str, list[tuple[int, str, str | None]]] = {}

    for arch in archs_to_process:
        arch_dir = archs_dir / arch
        if not arch_dir.exists() or not arch_dir.is_dir():
            print(f"Warning: Architecture directory {arch_dir} not found, skipping", file=sys.stderr)
            continue

        sections.update(process_dir(arch_dir, f"{arch}", only_stems))

    lines_out: list[str] = []
    for file_key, sigs in sorted(sections.items()):
        lines_out.append(file_key)
        for lineno, sig, arch_only, (base, arm_only) in sigs:
            marker = f"@{arch_only}" if arch_only else ""
            # `%base` / `%base^arm-only` - the function's own target_feature attributes, see
            # find_target_features. Omitted entirely when it has none, so the vast majority of
            # lines (and every pre-existing x86 one) keep their previous shape.
            if base or arm_only:
                marker += "%" + "+".join(base) + (("^" + "+".join(arm_only)) if arm_only else "")
            lines_out.append(f"{lineno}{marker}:{sig}")
        lines_out.append("")

    output = "\n".join(lines_out)

    # Default output path
    out_path = Path(args.out) if args.out else Path("data/cpu/signatures.txt")

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(output)

    total = sum(len(v) for v in sections.values())
    print(f"Wrote {total} signatures from {len(sections)} files → {out_path}")


if __name__ == "__main__":
    main()
