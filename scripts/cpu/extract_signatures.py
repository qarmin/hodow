#!/usr/bin/env python3
"""
Extracts public intrinsic function signatures from all architecture source
files, joining multi-line signatures into a single line.

Output format:
  arch/path/to/file.rs
  LINENUM[@arch][%features][!const-ranges]:pub [unsafe] fn function_name(a: T, b: T) -> T {

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
from typing import NamedTuple

STDARCH_SUBPATH = Path("lib/rustlib/src/rust/library/stdarch/crates/core_arch/src")
# std_detect lives outside stdarch's own crates/ directory in the same rust-src tree.
STD_DETECT_SUBPATH = Path("lib/rustlib/src/rust/library/std_detect/src/detect/arch")
DETECTABLE_FEATURES_FILE = Path("data/cpu/detectable_features.txt")


def sysroot(toolchain: str | None) -> Path:
    cmd = ["rustc", "--print", "sysroot"] if toolchain is None else ["rustc", f"+{toolchain}", "--print", "sysroot"]
    return Path(subprocess.run(cmd, capture_output=True, text=True, check=True).stdout.strip())


def default_src(toolchain: str | None) -> Path:
    """stdarch inside the active (or given) toolchain's sysroot."""
    return sysroot(toolchain) / STDARCH_SUBPATH

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


# ---------------------------------------------------------------------------
# Const-generic value constraints, read out of the function's own body
#
# Every intrinsic taking a const generic states its valid range itself, right at the top of
# its body (`static_assert_uimm_bits!(IMM8, 8)`, `static_assert_range!(IMM_FACTOR, 1..=16)`,
# `static_assert!(N >= 1 && N <= 8)`, ...) - 4000+ of them across stdarch. Reading those is
# what lets generate_tests.py pick a *valid* immediate for any function, and enumerate the
# immediate axis over the range the hardware actually accepts, instead of guessing from the
# const generic's name and hand-maintaining an exception per naming convention.
# ---------------------------------------------------------------------------

# Macro forms whose valid set is fixed by the macro itself (x86/macros.rs), taking only the
# const generic's name. Kept as inclusive ranges, same shape as everything else here.
FIXED_SET_MACROS: dict[str, list[tuple[int, int]]] = {
    "static_assert_sae": [(4, 4), (8, 8)],
    "static_assert_rounding": [(4, 4), (8, 11)],
    "static_assert_mantissas_sae": [(4, 4), (8, 8), (12, 12)],
    "static_assert_round_mode": [(0, 4)],
    # ($imm & 7) < 5 && ($imm & !15) == 0
    "static_assert_extended_rounding": [(0, 4), (8, 12)],
    "static_assert_imm8_scale": [(1, 1), (2, 2), (4, 4), (8, 8)],
}

# The macro kinds above whose value is a rounding-control field rather than a magnitude, so
# the generator prefers 8 (round-to-nearest | no-exception) over the numerically smallest
# valid value. Written into the marker so generate_tests.py does not have to re-derive it.
ROUNDING_KIND_MACROS = {
    "static_assert_sae", "static_assert_rounding", "static_assert_mantissas_sae",
    "static_assert_round_mode", "static_assert_extended_rounding",
}

_STATIC_ASSERT_RE = re.compile(r"\bstatic_assert(_\w+)?!\(")
# Candidate domain for evaluating a free-form `static_assert!` predicate. Upper bound covers
# the largest literal any of them mentions (IMM_ROTATION == 270); the lower bound is 0 because
# a bare `N < 8` bounds only one side and nothing here takes a negative immediate except the
# `simm_bits`/`range` forms, which are parsed directly rather than evaluated.
_EXPR_DOMAIN = range(0, 1025)
_IDENT_RE = re.compile(r"[A-Za-z_][A-Za-z_0-9]*")


def _norm_ranges(ranges: list[tuple[int, int]]) -> list[tuple[int, int]]:
    """Sort, drop empties and merge touching/overlapping ranges."""
    out: list[tuple[int, int]] = []
    for lo, hi in sorted(r for r in ranges if r[0] <= r[1]):
        if out and lo <= out[-1][1] + 1:
            out[-1] = (out[-1][0], max(out[-1][1], hi))
        else:
            out.append((lo, hi))
    return out


def _intersect_ranges(a: list[tuple[int, int]], b: list[tuple[int, int]]) -> list[tuple[int, int]]:
    return _norm_ranges([(max(x[0], y[0]), min(x[1], y[1])) for x in a for y in b])


def format_ranges(ranges: list[tuple[int, int]]) -> str:
    """`0-255`, `4|8`, `0-4|8-12` - compact enough to sit inline in signatures.txt."""
    return "|".join(str(lo) if lo == hi else f"{lo}-{hi}" for lo, hi in ranges)


def _values_from_ranges(ranges: list[tuple[int, int]]) -> list[tuple[int, int]]:
    return ranges


def _ranges_from_expr(expr: str, name: str) -> list[tuple[int, int]] | None:
    """Valid values of `name` under a free-form `static_assert!` predicate, by evaluating it.

    Evaluating beats parsing each shape: the same handful of lines covers `N >= 1 && N <= 8`,
    `IMM_ROTATION == 90 || IMM_ROTATION == 270`, `IMM_S11 % 2 == 0` and `(IMM & 7) < 5` alike.
    Returns None when the predicate mentions anything other than `name` (a cross-parameter
    assert like SSE4A's `LEN + IDX <= 64` has no per-parameter answer) or fails to evaluate."""
    py = expr
    # `matches!(X, 1..=32)` is the one non-operator form used.
    py = re.sub(r"matches!\(\s*(\w+)\s*,\s*(-?\d+)\s*\.\.=\s*(-?\d+)\s*\)", r"(\2 <= \1 <= \3)", py)
    py = py.replace("&&", " and ").replace("||", " or ")
    py = re.sub(r"!(?=\d|\()", "~", py)  # Rust's bitwise-not on an integer
    if "!" in py.replace("!=", ""):
        return None
    idents = {i for i in _IDENT_RE.findall(py) if i not in ("and", "or")}
    if idents != {name}:
        return None
    try:
        code = compile(py, "<static_assert>", "eval")
        ok = [v for v in _EXPR_DOMAIN if eval(code, {"__builtins__": {}}, {name: v})]  # noqa: S307
    except Exception:
        return None
    if not ok:
        return None
    return _norm_ranges([(v, v) for v in ok])


def _split_macro_args(text: str, start: int) -> tuple[list[str], int] | None:
    """Arguments of a macro call whose `(` is at `start`, plus the index just past its `)`."""
    depth = 0
    args: list[str] = []
    current = ""
    for i in range(start, len(text)):
        ch = text[i]
        if ch == "(":
            depth += 1
            if depth == 1:
                continue
        elif ch == ")":
            depth -= 1
            if depth == 0:
                args.append(current)
                return [a.strip() for a in args], i + 1
        elif ch == "," and depth == 1:
            args.append(current)
            current = ""
            continue
        current += ch
    return None


def find_const_constraints(lines: list[str], body_start: int) -> dict[str, tuple[list[tuple[int, int]], bool]]:
    """{const generic name: (valid ranges, is_rounding_kind)} from the function's own body.

    The body is everything from `body_start` up to the closing brace in column 0 - stdarch is
    rustfmt-formatted, so a top-level `}` is unambiguous and far cheaper than tracking brace
    depth through strings and comments."""
    body: list[str] = []
    for i in range(body_start, len(lines)):
        if lines[i].startswith("}"):
            break
        body.append(lines[i])
    text = "\n".join(body)
    if "static_assert" not in text or "$" in text:
        return {}

    found: dict[str, tuple[list[tuple[int, int]], bool]] = {}

    def record(name: str, ranges: list[tuple[int, int]] | None, rounding: bool) -> None:
        if not ranges:
            return
        if name in found:
            merged = _intersect_ranges(found[name][0], ranges)
            if not merged:
                return  # contradictory asserts - leave the earlier one alone
            found[name] = (merged, found[name][1] or rounding)
        else:
            found[name] = (ranges, rounding)

    for m in _STATIC_ASSERT_RE.finditer(text):
        macro = "static_assert" + (m.group(1) or "")
        parsed = _split_macro_args(text, m.end() - 1)
        if parsed is None:
            continue
        args, _ = parsed
        if macro in FIXED_SET_MACROS:
            if len(args) == 1 and args[0].isidentifier():
                record(args[0], FIXED_SET_MACROS[macro], macro in ROUNDING_KIND_MACROS)
        elif macro in ("static_assert_uimm_bits", "static_assert_simm_bits"):
            if len(args) == 2 and args[0].isidentifier() and args[1].isdigit():
                bits = int(args[1])
                if macro == "static_assert_uimm_bits":
                    record(args[0], [(0, (1 << bits) - 1)], False)
                else:
                    record(args[0], [(-(1 << (bits - 1)), (1 << (bits - 1)) - 1)], False)
        elif macro == "static_assert_range":
            rm = re.match(r"^(-?\d+)\s*\.\.=\s*(-?\d+)$", args[1]) if len(args) == 2 else None
            if rm and args[0].isidentifier():
                record(args[0], [(int(rm.group(1)), int(rm.group(2)))], False)
        elif macro == "static_assert":
            expr = args[0]
            names = {i for i in _IDENT_RE.findall(expr) if i.isupper() or "_" in i}
            for name in names:
                record(name, _ranges_from_expr(expr, name), False)

    return found


def format_const_constraints(constraints: dict[str, tuple[list[tuple[int, int]], bool]],
                             lane_indices: set[str] = frozenset()) -> str:
    """`IMM8=0-255,SAE=4|8~r,LANE=0-3~l` - `~r` marks a rounding-control field (see
    ROUNDING_KIND_MACROS), `~l` one that indexes a vector lane (see find_lane_index_consts)."""
    return ",".join(
        f"{name}={format_ranges(ranges)}" + ("~r" if rounding else "") + ("~l" if name in lane_indices else "")
        for name, (ranges, rounding) in sorted(constraints.items())
    )


# `simd_extract!(v, IMM5 as u32)` - the const generic used *directly* as a vector lane index,
# so its real upper bound is the vector's lane count and not whatever the function's own
# `static_assert` says. Those two disagree upstream: `vgetq_lane_u64<IMM5>` takes a
# two-lane uint64x2_t but asserts `static_assert_uimm_bits!(IMM5, 2)`, i.e. 0..=3, and
# instantiating it with 3 gets past the assert only to fail monomorphization with "SIMD index
# #1 is out of bounds (limit 2)". Matching the index argument exactly (not an expression
# containing the name) is deliberate: `_mm_shuffle_ps`'s IMM8 is four 2-bit selectors packed
# into 0..=255 and appears as `(IMM8 >> 2) & 0b11`, which is not a lane index and must not be
# clamped to the lane count.
_LANE_INDEX_RE = re.compile(r"\bsimd_(?:extract|insert)!\(\s*[^,()]*(?:\([^()]*\))?[^,()]*,\s*(\w+)(?:\s+as\s+\w+)?\s*[,)]")


def find_lane_index_consts(lines: list[str], body_start: int, names: list[str]) -> set[str]:
    body = []
    for i in range(body_start, len(lines)):
        if lines[i].startswith("}"):
            break
        body.append(lines[i])
    found = set(_LANE_INDEX_RE.findall("\n".join(body)))
    return {n for n in names if n in found}


def const_generic_names(sig_text: str) -> list[str]:
    return re.findall(r"const\s+(\w+)\s*:", sig_text)


def find_const_delegations(lines: list[str], body_start: int, names: list[str]) -> dict[str, list[str]]:
    """{const generic: functions this one forwards it to}, e.g. `vfmss_lane_f32` is just
    `vfmas_lane_f32::<LANE>(a, -b, c)` - the range assert lives in the callee, one level down.
    189 functions (mostly SVE `_x`/`_z` predication variants and NEON `_lane` wrappers) state
    their valid range only that way; resolve_delegated_constraints follows the chain."""
    body = []
    for i in range(body_start, len(lines)):
        if lines[i].startswith("}"):
            break
        body.append(lines[i])
    text = "\n".join(body)
    out: dict[str, list[str]] = {}
    for callee, args in re.findall(r"\b(\w+)::<([^>]*)>", text):
        for name in names:
            if re.search(rf"\b{re.escape(name)}\b", args):
                out.setdefault(name, []).append(callee)
    return out


# `#[cfg_attr(test, assert_instr(asrd, IMM2 = 1))]` - upstream's own instruction-selection test
# instantiates the function with this value, so it is valid by construction even when no range
# is stated anywhere. A last-resort single value: enough to call the function, not enough to
# enumerate an immediate axis over.
_ASSERT_INSTR_ARG_RE = re.compile(r"\b([A-Z][A-Z_0-9]*)\s*=\s*(-?\d+)")


def find_assert_instr_examples(lines: list[str], fn_idx: int) -> dict[str, int]:
    out: dict[str, int] = {}
    j = fn_idx - 1
    while j >= 0:
        stripped = lines[j].strip()
        if not stripped:
            j -= 1
            continue
        if not stripped.startswith("#[") and not stripped.startswith(")"):
            break
        if "assert_instr(" in stripped:
            for name, value in _ASSERT_INSTR_ARG_RE.findall(stripped):
                out.setdefault(name, int(value))
        j -= 1
    return out


def resolve_delegated_constraints(sections: dict[str, list["Sig"]]) -> tuple[int, int]:
    """Fill in every const generic left without a range, from the function it forwards to (or,
    failing that, from its own `assert_instr` example). Returns (delegated, examples) counts."""
    by_name: dict[str, Sig] = {}
    for sigs in sections.values():
        for s in sigs:
            m = re.search(r"fn\s+(\w+)", s.text)
            if m:
                by_name.setdefault(m.group(1), s)

    def lookup(fn_name: str, const_name: str, depth: int) -> tuple[list[tuple[int, int]], bool] | None:
        if depth > 4 or fn_name not in by_name:
            return None
        target = by_name[fn_name]
        if const_name in target.consts:
            return target.consts[const_name]
        for callee in target.delegations.get(const_name, []):
            found = lookup(callee, const_name, depth + 1)
            if found:
                return found
        return None

    delegated = examples = 0
    for sigs in sections.values():
        for s in sigs:
            for name in const_generic_names(s.text):
                if name in s.consts:
                    continue
                for callee in s.delegations.get(name, []):
                    found = lookup(callee, name, 1)
                    if found:
                        s.consts[name] = found
                        delegated += 1
                        break
                else:
                    if name in s.examples:
                        v = s.examples[name]
                        s.consts[name] = ([(v, v)], False)
                        examples += 1
    return delegated, examples


class Sig(NamedTuple):
    lineno: int                              # 1-based
    text: str                                # collapsed one-line signature
    arch_only: str | None                    # hard `#[cfg(target_arch = ...)]` gate, if any
    features: tuple[list[str], list[str]]    # (unconditional, arm-only) target_feature sets
    consts: dict[str, tuple[list[tuple[int, int]], bool]]  # const generic → (ranges, rounding?)
    delegations: dict[str, list[str]]        # const generic → functions it is forwarded to
    examples: dict[str, int]                 # const generic → `assert_instr` example value
    lane_indices: set[str]                   # const generics used directly as a lane index


def extract_file(path: Path, rel_prefix: str) -> list[Sig]:
    """Every public intrinsic function in `path`, as a `Sig`."""
    text = path.read_text(encoding="utf-8", errors="replace")
    lines = text.splitlines()
    results: list[Sig] = []

    # Match any public function (not limited to specific prefixes). `const` has to be part of
    # this: upstream has been const-stabilizing intrinsics, and `pub const fn` covers 3300+ x86
    # functions (`_mm_add_epi32`, `_mm_srli_epi32`, most of SSE/AVX arithmetic) that silently
    # stopped being extracted - and so stopped being tested - the moment they gained the keyword.
    fn_re = re.compile(r"^pub\s+(?:const\s+)?(?:unsafe\s+)?fn\s+(\w+)")

    i = 0
    while i < len(lines):
        m = fn_re.match(lines[i].strip())
        if m:
            arch_only = find_hard_arch_gate(lines, i)
            features = find_target_features(lines, i)
            result = collapse_signature(lines, i)
            if result is not None:
                sig, end = result
                consts: dict[str, tuple[list[tuple[int, int]], bool]] = {}
                delegations: dict[str, list[str]] = {}
                examples: dict[str, int] = {}
                lane_indices: set[str] = set()
                # Not a `"<const " in sig` substring test: collapse_signature joins a
                # multi-line generic list with spaces (`fn _mm512_getmant_round_ps< const
                # NORM: ...`), and those are exactly the functions with the most const
                # generics to find a range for.
                names = const_generic_names(sig)
                if names:
                    consts = find_const_constraints(lines, end + 1)
                    lane_indices = find_lane_index_consts(lines, end + 1, names)
                    missing = [n for n in names if n not in consts]
                    if missing:
                        delegations = find_const_delegations(lines, end + 1, missing)
                        examples = find_assert_instr_examples(lines, i)
                results.append(Sig(i + 1, sig, arch_only, features, consts, delegations, examples, lane_indices))
                i = end + 1
                continue
        i += 1

    return results


def process_dir(src_dir: Path, rel_prefix: str, only_stems: set[str] | None) -> dict[str, list[Sig]]:
    """Process a directory and its subdirectories for .rs files."""
    out: dict[str, list[Sig]] = {}

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


_FEATURE_DECL_RE = re.compile(r'@FEATURE:.*?\]\s*\w+\s*:\s*"([^"]+)"')

DETECTABLE_HEADER = """\
# Every string `is_<arch>_feature_detected!` accepts, per architecture.
#
# Generated by scripts/cpu/extract_signatures.py from the pinned toolchain's own std_detect
# (library/std_detect/src/detect/arch/<arch>.rs, the `@FEATURE:` declarations) - the exact
# table the macro matches against, so this can never drift from the compiler being built with.
# Do not hand-edit: re-run `just gen-cpu-tests`.
#
# generate_tests.py reads this to decide whether a feature a function needs beyond its group's
# own can be checked at runtime at all. A function requiring one that is absent here (32-bit
# ARM's `fp16`/`vfp4`, say) has no check available, so its group reports "no detection" rather
# than running the function and taking a SIGILL.
"""


def write_detectable_features(detect_dir: Path, out_path: Path) -> None:
    """`arch: f1 f2 ...` per architecture, straight out of std_detect's own feature tables."""
    if not detect_dir.is_dir():
        print(f"Warning: {detect_dir} not found, leaving {out_path} alone", file=sys.stderr)
        return
    lines: list[str] = []
    for src in sorted(detect_dir.glob("*.rs")):
        if src.stem == "mod":
            continue
        features = sorted(set(_FEATURE_DECL_RE.findall(src.read_text(encoding="utf-8", errors="replace"))))
        if features:
            lines.append(f"{src.stem}: {' '.join(features)}")
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(DETECTABLE_HEADER + "\n" + "\n".join(lines) + "\n")


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
        help="Toolchain to take stdarch from (e.g. nightly-2026-09-11). Default: the active one.",
    )
    parser.add_argument(
        "--detect-out", metavar="PATH",
        help=f"Write the runtime-detectable feature strings here. Default: {DETECTABLE_FEATURES_FILE}",
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

    sections: dict[str, list[Sig]] = {}

    for arch in archs_to_process:
        arch_dir = archs_dir / arch
        if not arch_dir.exists() or not arch_dir.is_dir():
            print(f"Warning: Architecture directory {arch_dir} not found, skipping", file=sys.stderr)
            continue

        sections.update(process_dir(arch_dir, f"{arch}", only_stems))

    delegated, examples = resolve_delegated_constraints(sections)
    print(f"Const-generic ranges: {delegated} resolved through a delegating call, "
          f"{examples} taken from an assert_instr example", file=sys.stderr)

    # Which compiler's stdarch this is. Ends up in `hodow coverage`'s header, so a report
    # pasted into a bug always says what it was measured against.
    version = subprocess.run(["rustc", *([f"+{args.toolchain}"] if args.toolchain else []), "--version"],
                             capture_output=True, text=True).stdout.strip()
    lines_out: list[str] = [f"# stdarch: {version or 'unknown'}", ""]
    with_consts = 0
    for file_key, sigs in sorted(sections.items()):
        lines_out.append(file_key)
        for s in sigs:
            base, arm_only = s.features
            marker = f"@{s.arch_only}" if s.arch_only else ""
            # `%base` / `%base^arm-only` - the function's own target_feature attributes, see
            # find_target_features. Omitted entirely when it has none, so the vast majority of
            # lines (and every pre-existing x86 one) keep their previous shape.
            if base or arm_only:
                marker += "%" + "+".join(base) + (("^" + "+".join(arm_only)) if arm_only else "")
            # `!NAME=ranges` - the valid values of each const generic, from the function's own
            # static_assert (see find_const_constraints). Absent for functions with none.
            if s.consts:
                marker += "!" + format_const_constraints(s.consts, s.lane_indices)
                with_consts += 1
            lines_out.append(f"{s.lineno}{marker}:{s.text}")
        lines_out.append("")

    output = "\n".join(lines_out)

    # Default output path
    out_path = Path(args.out) if args.out else Path("data/cpu/signatures.txt")

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(output)

    total = sum(len(v) for v in sections.values())
    print(f"Wrote {total} signatures ({with_consts} with const-generic ranges) "
          f"from {len(sections)} files → {out_path}")

    if not args.src and not args.archs and not args.files:
        # Only a full extraction can rewrite this file - a partial one would drop
        # architectures it never looked at.
        detect_path = Path(args.detect_out) if args.detect_out else DETECTABLE_FEATURES_FILE
        write_detectable_features(sysroot(args.toolchain) / STD_DETECT_SUBPATH, detect_path)
        print(f"Wrote runtime-detectable feature strings → {detect_path}")


if __name__ == "__main__":
    main()
