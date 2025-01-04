#!/usr/bin/env python3
"""
Generates Rust SIMD test stubs for all architectures from signatures.txt.
Outputs to hodow_cpu/src/cpu/auto_generated/<arch>/
"""

import re
import sys
import tomllib
from pathlib import Path
from collections import defaultdict
from typing import NamedTuple

OUTPUT_DIR = Path("hodow_cpu/src/cpu/auto_generated")
# Every hand-maintained input and captured output of the CPU generators lives here.
DATA_DIR = Path("data/cpu")
# One file per (arch, extension), so a recapture touches only what it recaptured.
EXPECTED_DIR = DATA_DIR / "expected"
SIGNATURES_FILE = DATA_DIR / "signatures.txt"
# The one hand-maintained per-function policy file: exclusions, forced argument values,
# partial result checks. See its own header for the schema.
POLICY_FILE = DATA_DIR / "function_policy.toml"
# Which strings `is_<arch>_feature_detected!` accepts, extracted from the toolchain's own
# std_detect by extract_signatures.py. Read here to decide whether a feature a function needs
# beyond its group's own can be checked at runtime at all.
DETECTABLE_FEATURES_FILE = DATA_DIR / "detectable_features.txt"
# Functions that fail *only* under Miri (foreign-function / inline-asm limitations) but
# run fine on real hardware. They are generated and executed natively, but skipped when
# the test binary is run under Miri via a `cfg!(miri)` guard.
MIRI_ONLY_FILE = DATA_DIR / "miri_only_functions.txt"

# Populated from MIRI_ONLY_FILE in main().
MIRI_SKIP_FUNCTIONS: set[str] = set()


class Policy:
    """data/cpu/function_policy.toml, parsed. Every field is per-function; anything the
    generator can derive from stdarch itself is deliberately NOT here."""

    def __init__(self, raw: dict) -> None:
        self.excluded: dict[str, tuple[str, str]] = {}          # name -> (category, reason)
        self.categories: dict[str, str] = {}                    # category -> reason
        self.no_fuzz: set[str] = set()
        self.skip_result_check: set[str] = set()
        self.skip_output_check: set[str] = set()
        self.no_value_scenarios: set[str] = set()
        self.check_lanes: dict[str, int] = {}
        self.param_overrides: dict[tuple[str, str], str] = {}
        self.const_overrides: dict[tuple[str, str], str] = {}
        self.reasons: dict[str, str] = {}

        for block in raw.get("exclude", []):
            category, reason = block["category"], block["reason"]
            self.categories[category] = reason
            for name in block["functions"]:
                self.excluded[name] = (category, reason)

        known = {"reason", "params", "consts", "no_fuzz", "skip_result_check",
                 "skip_output_check", "check_lanes", "no_value_scenarios"}
        for name, entry in raw.get("function", {}).items():
            unknown = set(entry) - known
            if unknown:
                raise SystemExit(f"{POLICY_FILE}: [function.{name}] has unknown key(s) {sorted(unknown)}")
            if "reason" not in entry:
                raise SystemExit(f"{POLICY_FILE}: [function.{name}] has no `reason`")
            self.reasons[name] = entry["reason"]
            if entry.get("no_fuzz"):
                self.no_fuzz.add(name)
            if entry.get("skip_result_check"):
                self.skip_result_check.add(name)
            if entry.get("skip_output_check"):
                self.skip_output_check.add(name)
            if entry.get("no_value_scenarios"):
                self.no_value_scenarios.add(name)
            if "check_lanes" in entry:
                self.check_lanes[name] = int(entry["check_lanes"])
            for param, value in entry.get("params", {}).items():
                self.param_overrides[(name, param)] = value
            for const, value in entry.get("consts", {}).items():
                self.const_overrides[(name, const)] = str(value)

    def all_named_functions(self) -> set[str]:
        return set(self.excluded) | set(self.reasons)

    @classmethod
    def load(cls, path: Path = POLICY_FILE) -> "Policy":
        if not path.exists():
            return cls({})
        with open(path, "rb") as f:
            return cls(tomllib.load(f))


# Loaded at import, not in main(): capture_expected.py and capture_expected_cross.py import
# this module for test_group_map()/load_expected_values() without ever calling main(), and a
# policy-less default would give them a different scenario list than the generator produced.
POLICY = Policy.load()


def load_detectable_features(path: Path = DETECTABLE_FEATURES_FILE) -> dict[str, set[str]]:
    """{std_detect arch: {feature strings}} from data/cpu/detectable_features.txt."""
    out: dict[str, set[str]] = {}
    if not path.exists():
        return out
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#") or ":" not in line:
            continue
        arch, _, features = line.partition(":")
        out[arch.strip()] = set(features.split())
    return out


DETECTABLE_FEATURES: dict[str, set[str]] = load_detectable_features()

# Deprecated intrinsics — excluded entirely from test generation
DEPRECATED_FUNCTIONS = {
    "_mm_getcsr", "_mm_setcsr",   # deprecated: use inline assembly instead
    "_mm_pause",                   # deprecated: use core::hint::spin_loop()
}

# x86-only functions with incompatible signatures on x86_64
# These will be skipped when x86 module is compiled for x86_64
X86_INCOMPATIBLE_FUNCTIONS = {
    "__readeflags",    # x86: u32, x86_64: u64
    "__writeeflags",   # x86: u32, x86_64: u64
}

# SVE/SVE2 functions whose CORRECT result is itself a function of the hardware's vector
# length (queried at runtime via svcntb/svlen/..., never a fixed compile-time constant -
# see CLAUDE.md's "Non-x86 architectures" section) - unlike ordinary element-wise SVE ops,
# broadcasting the same scalar input on every hardware VL does NOT give the same output
# here, so a single captured "expected" value can never be valid across different real
# chips (found empirically: forcing qemu to a different VL via `-cpu max,sve-max-vq=N`
# turned 0 failures into 147, every one of them in this exact family).
# - svcnt[bhwdp](_pat)?  - "how many bytes/halfwords/words/doublewords/active-predicate-
#   bits fit in a register" - the query *is* the vector length.
# - svq(inc|dec)[bhwdp]  - "increment/decrement by N times the (active) element count".
# - svindex               - fills a vector with the sequence 0,1,2,...,N-1; the *last*
#   element (what this generator's extraction reads) is exactly N-1.
# - svaddv                - sums every active lane; with N identical input lanes the sum
#   scales with N (unlike svmaxv/svminv, invariant for identical lanes - hence absent here).
# - svlen                 - the element count itself, by definition.
# - svdupq_lane           - replicates one 128-bit quadword across the register; which
#   quadword count exists (and so what the trailing one holds) depends on VL too.
SVE_VL_DEPENDENT_RE = re.compile(r"^sv(cnt[bhwdp](_pat)?|q(inc|dec)[bhwdp]|index|addv|len|dupq_lane)")

# Types without helpers in values.rs — functions using these are skipped entirely
UNSTABLE_TYPES = {
    "bf16", "f16", "bfloat16_t",
    "__m128h", "__m256h", "__m512h",
    "__m128bh_avx", "__m256bh_avx",  # extra aliases that may appear
    # NEON f16-lane vectors: no create_/unpack_ helper without a stable `f16` scalar type
    # to build the backing array from (bare "f16" is excluded above, but that check is a
    # substring match against the *whole* type name, and "f16" is never a substring of
    # "float16x4_t" - needs its own explicit entry).
    "float16x4_t", "float16x8_t",
    # NEON multi-register tuple types (vld2/vld3/vld4/vst2/vst3/vst4, "load/store N
    # registers at once") - each is just N copies of an already-supported base type
    # (int8x16x2_t is two int8x16_t), deliberately deferred rather than building tuple
    # construction/unpacking on top of the base-type helpers; see CLAUDE.md.
    "float16x4x2_t", "float16x4x3_t", "float16x4x4_t", "float16x8x2_t", "float16x8x3_t", "float16x8x4_t",
    "float32x2x2_t", "float32x2x3_t", "float32x2x4_t", "float32x4x2_t", "float32x4x3_t", "float32x4x4_t",
    "float64x1x2_t", "float64x1x3_t", "float64x1x4_t", "float64x2x2_t", "float64x2x3_t", "float64x2x4_t",
    "int16x4x2_t", "int16x4x3_t", "int16x4x4_t", "int16x8x2_t", "int16x8x3_t", "int16x8x4_t",
    "int32x2x2_t", "int32x2x3_t", "int32x2x4_t", "int32x4x2_t", "int32x4x3_t", "int32x4x4_t",
    "int64x1x2_t", "int64x1x3_t", "int64x1x4_t", "int64x2x2_t", "int64x2x3_t", "int64x2x4_t",
    "int8x16x2_t", "int8x16x3_t", "int8x16x4_t", "int8x8x2_t", "int8x8x3_t", "int8x8x4_t",
    "poly16x4x2_t", "poly16x4x3_t", "poly16x4x4_t", "poly16x8x2_t", "poly16x8x3_t", "poly16x8x4_t",
    "poly64x1x2_t", "poly64x1x3_t", "poly64x1x4_t", "poly64x2x2_t", "poly64x2x3_t", "poly64x2x4_t",
    "poly8x16x2_t", "poly8x16x3_t", "poly8x16x4_t", "poly8x8x2_t", "poly8x8x3_t", "poly8x8x4_t",
    "uint16x4x2_t", "uint16x4x3_t", "uint16x4x4_t", "uint16x8x2_t", "uint16x8x3_t", "uint16x8x4_t",
    "uint32x2x2_t", "uint32x2x3_t", "uint32x2x4_t", "uint32x4x2_t", "uint32x4x3_t", "uint32x4x4_t",
    "uint64x1x2_t", "uint64x1x3_t", "uint64x1x4_t", "uint64x2x2_t", "uint64x2x3_t", "uint64x2x4_t",
    "uint8x16x2_t", "uint8x16x3_t", "uint8x16x4_t", "uint8x8x2_t", "uint8x8x3_t", "uint8x8x4_t",
    # SVE multi-vector tuple types (svld2/svld3/svld4-style "load N vectors at once") -
    # same deferral as the NEON tuple types above: each is just N copies of an
    # already-supported base type, not built here.
    "svfloat32x2_t", "svfloat32x3_t", "svfloat32x4_t", "svfloat64x2_t", "svfloat64x3_t",
    "svfloat64x4_t", "svint16x2_t", "svint16x3_t", "svint16x4_t", "svint32x2_t",
    "svint32x3_t", "svint32x4_t", "svint64x2_t", "svint64x3_t", "svint64x4_t",
    "svint8x2_t", "svint8x3_t", "svint8x4_t", "svuint16x2_t", "svuint16x3_t",
    "svuint16x4_t", "svuint32x2_t", "svuint32x3_t", "svuint32x4_t", "svuint64x2_t",
    "svuint64x3_t", "svuint64x4_t", "svuint8x2_t", "svuint8x3_t", "svuint8x4_t",
}

# Extension stem → Rust target_feature string (only where they differ)
FEATURE_FLAGS = {
    "sse41": "sse4.1",
    "sse42": "sse4.2",
    "bmi":   "bmi1",   # x86_64/bmi.rs is bmi1 intrinsics
    "test":  "sse2",   # x86/test.rs contains SSE2-level helpers
    # Rebucketed NEON groups (see rebucket_neon_by_feature) whose detection string is not a
    # valid Rust module name, so the module got the underscored spelling.
    "sve2_aes":     "sve2-aes",
    "sve2_bitperm": "sve2-bitperm",
    "sve2_sha3":    "sve2-sha3",
    "sve2_sm4":     "sve2-sm4",
    "fp_armv8":     "fp-armv8",
}

# Which strings each `is_<arch>_feature_detected!` knows is no longer written down here: it is
# read from data/cpu/detectable_features.txt (DETECTABLE_FEATURES), extracted from the
# toolchain's own std_detect. Everything 32-bit ARM cannot check - fp16, vfp4, fp-armv8 and
# every aarch64-only extension - makes its group report "not detectable" there and be skipped
# rather than run into a SIGILL.

# The arm-only extras from rebucket_neon_by_feature. On aarch64 these functions are plain NEON
# (the requirement comes from a `cfg_attr(target_arch = "arm", ...)`), and neither name is an
# `is_aarch64_feature_detected!` string, so that is what the group checks there.
NEON_AARCH64_PLAIN_FEATURES = {"vfp4", "fp-armv8"}

# Base target_features that say nothing about which group a NEON function belongs in: `neon`
# itself, and the architecture-revision markers stdarch attaches on 32-bit ARM. `v7` is the
# baseline of the armv7 target this project builds for, and `v8` alone never gated anything
# that actually crashed - only the concrete extensions below it do.
NEON_BASELINE_FEATURES = {"neon", "v7", "v8"}

# Features that don't have runtime detection or aren't proper target_feature
# These will always return false for feature detection
UNSUPPORTED_FEATURES = {
    "abm",      # Use lzcnt/popcnt instead
    "amx",      # Requires unstable x86_amx_intrinsics feature (nightly only)
    "bswap",    # Not a real target feature
    "bt",       # Not a real target feature
    "eflags",   # Not a real target feature
    "cpuid",    # Not a real target feature
    "rdtsc",    # Not a real target feature
    "test",     # Not a real target feature
    "hints",    # ARM hints - the *intrinsics* need unstable stdarch_arm_hints (SKIP_EXTENSIONS),
                # not just detection; revisit together if that's ever added
    "sat",      # ARM saturation - same, needs unstable stdarch_arm_sat (SKIP_EXTENSIONS)
    "dsp",      # ARM DSP - same, needs unstable stdarch_arm_neon_intrinsics (SKIP_EXTENSIONS)
    "simd32",   # ARM SIMD32 - same, needs unstable stdarch_arm_neon_intrinsics (SKIP_EXTENSIONS)
    "packed",   # NVPTX specific
    "msa",      # MIPS MSA
    "altivec",  # PowerPC
    "vsx",      # PowerPC
    "vector",   # s390x
    "zb",       # RISC-V - "zb" isn't a real is_riscv_feature_detected! string (it's split into
                # zba/zbb/zbc/zbs sub-extensions there); left unmapped rather than guessing which
    "simd128",  # WASM
    "relaxed_simd", # WASM
    "atomic",   # WASM
    "memory",   # WASM
}

# Features with no is_<arch>_feature_detected! string at all (confirmed by compile-probing
# every candidate name), because they aren't an optional CPU capability to begin with - the
# instructions are mandatory baseline ISA on every target Rust actually supports for that
# architecture. Detected as always-true instead of routing through UNSUPPORTED_FEATURES'
# always-false, so their (already-generated) tests actually run rather than being silently
# skipped forever.
BASELINE_ALWAYS_TRUE_FEATURES = {
    "prefetch",  # aarch64: PRFM is base AArch64 ISA, not a detectable optional feature
}

# Extensions that should be completely skipped (not generated at all), with the reason
# `hodow coverage` reports for every function they take out of the binary.
SKIP_EXTENSIONS: dict[str, str] = {
    "amx": "intrinsics need the unstable x86_amx_intrinsics feature",
    # TSX: both the intrinsics (stdarch_x86_rtm) and `#[target_feature(enable = "rtm")]`
    # (rtm_target_feature) are unstable, and the x86 build must stay stable-compatible
    # (`just install`/`install-all` run plain `cargo install`). Reachable before only via a
    # target-cpu=native build on a machine with TSX still enabled in microcode.
    "rtm": "intrinsics and target feature are both unstable; the x86 build must stay stable-compatible",
    # The three below became visible only when the extractor learned to see `pub const fn`
    # (upstream const-stabilized most of x86); each still needs a nightly feature gate, and
    # the x86 build has to keep compiling on stable, same as `rtm` above.
    "clflushopt": "needs the unstable clflushopt_target_feature and simd_x86_clflushopt features",
    "movrs": "needs the unstable movrs_target_feature feature",
    "avx512vp2intersect": "intrinsics need the unstable stdarch_x86_avx512vp2intersect feature",
    "dsp": "ARM DSP intrinsics need the unstable stdarch_arm_neon_intrinsics feature",
    "hints": "ARM hint intrinsics need the unstable stdarch_arm_hints feature",
    "sat": "ARM saturating intrinsics need the unstable stdarch_arm_sat feature",
    "simd32": "ARM SIMD32 intrinsics need the unstable stdarch_arm_neon_intrinsics feature",
}

# SIMD type → random creator from values.rs
RANDOM_CREATORS: dict[str, str] = {
    "__m128":    "create_random__m128()",
    "__m128d":   "create_random__m128d()",
    "__m128i":   "create_random__m128i()",
    "__m128bh":  "create_random__m128bh()",
    "__m256":    "create_random__m256()",
    "__m256d":   "create_random__m256d()",
    "__m256i":   "create_random__m256i()",
    "__m256bh":  "create_random__m256bh()",
    "__m512":    "create_random__m512()",
    "__m512d":   "create_random__m512d()",
    "__m512i":   "create_random__m512i()",
    "__m512bh":  "create_random__m512bh()",
    "__mmask8":  "create_random__mmask8()",
    "__mmask16": "create_random__mmask16()",
    "__mmask32": "create_random__mmask32()",
    "__mmask64": "create_random__mmask64()",
    "i8":    "rand::random::<i8>()",
    "i16":   "rand::random::<i16>()",
    "i32":   "rand::random::<i32>()",
    "i64":   "rand::random::<i64>()",
    "u8":    "rand::random::<u8>()",
    "u16":   "rand::random::<u16>()",
    "u32":   "rand::random::<u32>()",
    "u64":   "rand::random::<u64>()",
    "f32":   "rand::random::<f32>()",
    "f64":   "rand::random::<f64>()",
    # rand 0.10's blanket `Distribution` impl deliberately excludes usize/isize (platform-
    # width-dependent, so not portable) - go through a fixed-width type instead. Fuzzing
    # only wants "some pseudorandom value", so the truncation on a 32-bit target is harmless.
    "usize": "rand::random::<u64>() as usize",
    "bool":  "rand::random::<bool>()",
    "u128":  "rand::random::<u128>()",
    "Ordering": "core::sync::atomic::Ordering::Relaxed",
    # NEON base vector types (common/arm.rs helpers) - p8/p16/p64/p128 are stdarch-internal
    # aliases (pub(crate) type p64 = u64, ...) for the polynomial-multiply scalar types, so
    # an ordinary integer literal of the aliased width type-checks fine in their place.
    "int8x8_t": "create_random_int8x8_t()",
    "int8x16_t": "create_random_int8x16_t()",
    "int16x4_t": "create_random_int16x4_t()",
    "int16x8_t": "create_random_int16x8_t()",
    "int32x2_t": "create_random_int32x2_t()",
    "int32x4_t": "create_random_int32x4_t()",
    "int64x1_t": "create_random_int64x1_t()",
    "int64x2_t": "create_random_int64x2_t()",
    "uint8x8_t": "create_random_uint8x8_t()",
    "uint8x16_t": "create_random_uint8x16_t()",
    "uint16x4_t": "create_random_uint16x4_t()",
    "uint16x8_t": "create_random_uint16x8_t()",
    "uint32x2_t": "create_random_uint32x2_t()",
    "uint32x4_t": "create_random_uint32x4_t()",
    "uint64x1_t": "create_random_uint64x1_t()",
    "uint64x2_t": "create_random_uint64x2_t()",
    "float32x2_t": "create_random_float32x2_t()",
    "float32x4_t": "create_random_float32x4_t()",
    "float64x1_t": "create_random_float64x1_t()",
    "float64x2_t": "create_random_float64x2_t()",
    "poly8x8_t": "create_random_poly8x8_t()",
    "poly8x16_t": "create_random_poly8x16_t()",
    "poly16x4_t": "create_random_poly16x4_t()",
    "poly16x8_t": "create_random_poly16x8_t()",
    "poly64x1_t": "create_random_poly64x1_t()",
    "poly64x2_t": "create_random_poly64x2_t()",
    "p8": "rand::random::<u8>()", "p16": "rand::random::<u16>()",
    "p64": "rand::random::<u64>()", "p128": "rand::random::<u128>()",
    "svint8_t": "create_random_svint8_t()",
    "svuint8_t": "create_random_svuint8_t()",
    "svint16_t": "create_random_svint16_t()",
    "svuint16_t": "create_random_svuint16_t()",
    "svint32_t": "create_random_svint32_t()",
    "svuint32_t": "create_random_svuint32_t()",
    "svint64_t": "create_random_svint64_t()",
    "svuint64_t": "create_random_svuint64_t()",
    "svfloat32_t": "create_random_svfloat32_t()",
    "svfloat64_t": "create_random_svfloat64_t()",
    # svbool_t stays the fixed all-active predicate even when fuzzing - randomizing which
    # lanes are active would break the uniform-broadcast-in/uniform-out invariant every SVE
    # value/return check here depends on (see CLAUDE.md's "Non-x86 architectures" section).
    "svbool_t": "create_svbool_t()",
}

# SIMD type → fixed initializer (simple, deterministic values)
FIXED_INITS: dict[str, str] = {
    "__m128":    "create__m128_from([1.0, 2.0, 3.0, 4.0])",
    "__m128d":   "create__m128d_from([1.0, 2.0])",
    "__m128i":   "create__m128i_from_i32_array([1, 2, 3, 4])",
    "__m128bh":  "create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])",
    "__m256":    "create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0])",
    "__m256d":   "create__m256d_from([1.0, 2.0, 3.0, 4.0])",
    "__m256i":   "create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])",
    "__m256bh":  "create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])",
    "__m512":    "create__m512_from([" + ", ".join(f"{i+1}.0" for i in range(16)) + "])",
    "__m512d":   "create__m512d_from([" + ", ".join(f"{i+1}.0" for i in range(8)) + "])",
    "__m512i":   "create__m512i_from_i32_array([" + ", ".join(str(i+1) for i in range(16)) + "])",
    "__m512bh":  "create__m512bh_from([" + ", ".join(str(i % 20 + 1) for i in range(32)) + "])",
    "__mmask8":  "create__mmask8_from(0b01010101)",
    "__mmask16": "create__mmask16_from(0b0101010101010101)",
    "__mmask32": "create__mmask32_from(0x55555555u32)",
    "__mmask64": "create__mmask64_from(0x5555555555555555u64)",
    "i8":    "1i8",
    "i16":   "1i16",
    "i32":   "1i32",
    "i64":   "1i64",
    "u8":    "1u8",
    "u16":   "1u16",
    "u32":   "1u32",
    "u64":   "1u64",
    "f32":   "1.0f32",
    "f64":   "1.0f64",
    "usize": "0usize",
    "bool":  "true",
    "u128":  "1u128",
    "Ordering": "core::sync::atomic::Ordering::Relaxed",
    "int8x8_t": "create_int8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])",
    "int8x16_t": "create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])",
    "int16x4_t": "create_int16x4_t_from([1, 2, 3, 4])",
    "int16x8_t": "create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])",
    "int32x2_t": "create_int32x2_t_from([1, 2])",
    "int32x4_t": "create_int32x4_t_from([1, 2, 3, 4])",
    "int64x1_t": "create_int64x1_t_from([1])",
    "int64x2_t": "create_int64x2_t_from([1, 2])",
    "uint8x8_t": "create_uint8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])",
    "uint8x16_t": "create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])",
    "uint16x4_t": "create_uint16x4_t_from([1, 2, 3, 4])",
    "uint16x8_t": "create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])",
    "uint32x2_t": "create_uint32x2_t_from([1, 2])",
    "uint32x4_t": "create_uint32x4_t_from([1, 2, 3, 4])",
    "uint64x1_t": "create_uint64x1_t_from([1])",
    "uint64x2_t": "create_uint64x2_t_from([1, 2])",
    "float32x2_t": "create_float32x2_t_from([1.0, 2.0])",
    "float32x4_t": "create_float32x4_t_from([1.0, 2.0, 3.0, 4.0])",
    "float64x1_t": "create_float64x1_t_from([1.0])",
    "float64x2_t": "create_float64x2_t_from([1.0, 2.0])",
    "poly8x8_t": "create_poly8x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])",
    "poly8x16_t": "create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])",
    "poly16x4_t": "create_poly16x4_t_from([1, 2, 3, 4])",
    "poly16x8_t": "create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8])",
    "poly64x1_t": "create_poly64x1_t_from([1])",
    "poly64x2_t": "create_poly64x2_t_from([1, 2])",
    "p8": "1u8", "p16": "1u16", "p64": "1u64", "p128": "1u128",
    "svint8_t": "create_svint8_t_from(3i8)",
    "svuint8_t": "create_svuint8_t_from(3u8)",
    "svint16_t": "create_svint16_t_from(3i16)",
    "svuint16_t": "create_svuint16_t_from(3u16)",
    "svint32_t": "create_svint32_t_from(3i32)",
    "svuint32_t": "create_svuint32_t_from(3u32)",
    "svint64_t": "create_svint64_t_from(3i64)",
    "svuint64_t": "create_svuint64_t_from(3u64)",
    "svfloat32_t": "create_svfloat32_t_from(3.0f32)",
    "svfloat64_t": "create_svfloat64_t_from(3.0f64)",
    "svbool_t": "create_svbool_t()",
}

# Byte size of a pointee type, used to size pointer buffers large enough to hold a
# full SIMD register. Intrinsics like `_mm512_loadu_epi8(*const i8)` read a whole
# 512-bit vector through a pointer to a *small* element, so a 1-element buffer is an
# out-of-bounds read. Sizing to at least a 512-bit register (64 bytes) is always safe.
PTR_ELEM_BYTES: dict[str, int] = {
    "i8": 1, "u8": 1, "i16": 2, "u16": 2, "i32": 4, "u32": 4, "f32": 4,
    "i64": 8, "u64": 8, "f64": 8, "usize": 8, "isize": 8, "u128": 16, "i128": 16,
    "__m128": 16, "__m128d": 16, "__m128i": 16, "__m128bh": 16,
    "__m256": 32, "__m256d": 32, "__m256i": 32, "__m256bh": 32,
    "__m512": 64, "__m512d": 64, "__m512i": 64, "__m512bh": 64,
    "__mmask8": 1, "__mmask16": 2, "__mmask32": 4, "__mmask64": 8,
}

# Largest SIMD register width in bytes (AVX-512).
MAX_SIMD_BYTES = 64


HW_RNG_STEP_RE = re.compile(r"_rd(rand|seed)\d+_step")


def hw_rng_retry(name: str, call: str) -> str:
    """RDRAND/RDSEED report "no entropy ready" by returning 0 and the SDM says to retry. RDSEED drains
    quickly (the pool is shared by every thread and by the OS itself), so a single attempt that must
    return 1 is flaky on a busy machine. Intel advises 10 tries for RDRAND; RDSEED gets more, with a pause."""
    tries = 10 if "rand" in name else 1000
    return f"retry_hw_rng({tries}, || {call})"


def is_state_save(name: str) -> bool:
    """xsave/fxsave/xrstor/fxrstor write the full processor state region (>= 512 bytes, up to
    a few KiB) through a `*mut u8`, far larger than a SIMD register - so their buffer is sized
    differently, and what lands in it is machine state rather than a result to check."""
    return "xsave" in name.lower() or "xrstor" in name.lower()


def ptr_array_size(inner: str) -> int:
    """Number of `inner`-typed elements needed for a buffer that can back any load/store
    up to a 512-bit vector. Defaults to a full 64-byte register for unknown pointees."""
    b = PTR_ELEM_BYTES.get(inner.strip(), 1)
    return max(1, -(-MAX_SIMD_BYTES // b))  # ceil(64 / b)


# Lane type a `*mut`/`&mut` output is read back as. A store writes its result to memory
# instead of returning it, so without reading that memory back the test asserts nothing at
# all - `_mm_stream_si64` and every `vst1_*`/`_mm_store*` was a `Verdict::Unverified(None)`
# for exactly that reason. A vector pointee is read through the same generic lane view a
# vector *return* is unpacked into (`*mut __m128i` -> 16 x i32), so captured values read the
# same way on both paths. `p8`/`p16`/`p64` are stdarch's poly aliases of the unsigned
# integer of that width; a mask alias is the same.
OUT_LANE_TYPE: dict[str, str] = {
    "i8": "i8", "i16": "i16", "i32": "i32", "i64": "i64", "isize": "isize",
    "u8": "u8", "u16": "u16", "u32": "u32", "u64": "u64", "usize": "usize",
    "i128": "i128", "u128": "u128",
    "f32": "f32", "f64": "f64",
    "p8": "u8", "p16": "u16", "p64": "u64", "p128": "u128",
    "__mmask8": "u8", "__mmask16": "u16", "__mmask32": "u32", "__mmask64": "u64",
    "__m128i": "i32", "__m256i": "i32", "__m512i": "i32",
    "__m128": "f32", "__m256": "f32", "__m512": "f32",
    "__m128d": "f64", "__m256d": "f64", "__m512d": "f64",
}

LANE_BYTES: dict[str, int] = {
    "i8": 1, "u8": 1, "i16": 2, "u16": 2, "i32": 4, "u32": 4, "f32": 4,
    "i64": 8, "u64": 8, "f64": 8, "isize": 8, "usize": 8, "i128": 16, "u128": 16,
}


# Zeroed SIMD inits — used for gather/scatter offset/index params to avoid OOB reads
ZERO_SIMD_INITS: dict[str, str] = {
    "__m128i": "create__m128i_from_i32_array([0, 0, 0, 0])",
    "__m256i": "create__m256i_from_i32_array([0, 0, 0, 0, 0, 0, 0, 0])",
    "__m512i": "create__m512i_from_i32_array([" + ", ".join("0" for _ in range(16)) + "])",
}

# Sequential init table: ptype → (elem_count, formatter(vals) → str)
# Types not listed fall back to FIXED_INITS (masks, bool, usize).
def _f(name: str, vals: list[int], float_: bool) -> str:
    elems = ", ".join(f"{v}.0" if float_ else str(v) for v in vals)
    return f"{name}([{elems}])"

SEQ_TYPES: dict[str, tuple[int, object]] = {
    "__m128":   (4,  lambda v: _f("create__m128_from",             v, True)),
    "__m128d":  (2,  lambda v: _f("create__m128d_from",            v, True)),
    "__m128i":  (4,  lambda v: _f("create__m128i_from_i32_array",  v, False)),
    "__m128bh": (8,  lambda v: _f("create__m128bh_from",           v, False)),
    "__m256":   (8,  lambda v: _f("create__m256_from",             v, True)),
    "__m256d":  (4,  lambda v: _f("create__m256d_from",            v, True)),
    "__m256i":  (8,  lambda v: _f("create__m256i_from_i32_array",  v, False)),
    "__m256bh": (16, lambda v: _f("create__m256bh_from",           v, False)),
    "__m512":   (16, lambda v: _f("create__m512_from",             v, True)),
    "__m512d":  (8,  lambda v: _f("create__m512d_from",            v, True)),
    "__m512i":  (16, lambda v: _f("create__m512i_from_i32_array",  v, False)),
    "__m512bh": (32, lambda v: _f("create__m512bh_from",           v, False)),
    "i8":   (1, lambda v: f"{v[0]}i8"),
    "i16":  (1, lambda v: f"{v[0]}i16"),
    "i32":  (1, lambda v: f"{v[0]}i32"),
    "i64":  (1, lambda v: f"{v[0]}i64"),
    "u8":   (1, lambda v: f"{v[0]}u8"),
    "u16":  (1, lambda v: f"{v[0]}u16"),
    "u32":  (1, lambda v: f"{v[0]}u32"),
    "u64":  (1, lambda v: f"{v[0]}u64"),
    "f32":  (1, lambda v: f"{v[0]}.0f32"),
    "f64":  (1, lambda v: f"{v[0]}.0f64"),
    "int8x8_t": (8, lambda v: _f("create_int8x8_t_from", v, False)),
    "int8x16_t": (16, lambda v: _f("create_int8x16_t_from", v, False)),
    "int16x4_t": (4, lambda v: _f("create_int16x4_t_from", v, False)),
    "int16x8_t": (8, lambda v: _f("create_int16x8_t_from", v, False)),
    "int32x2_t": (2, lambda v: _f("create_int32x2_t_from", v, False)),
    "int32x4_t": (4, lambda v: _f("create_int32x4_t_from", v, False)),
    "int64x1_t": (1, lambda v: _f("create_int64x1_t_from", v, False)),
    "int64x2_t": (2, lambda v: _f("create_int64x2_t_from", v, False)),
    "uint8x8_t": (8, lambda v: _f("create_uint8x8_t_from", v, False)),
    "uint8x16_t": (16, lambda v: _f("create_uint8x16_t_from", v, False)),
    "uint16x4_t": (4, lambda v: _f("create_uint16x4_t_from", v, False)),
    "uint16x8_t": (8, lambda v: _f("create_uint16x8_t_from", v, False)),
    "uint32x2_t": (2, lambda v: _f("create_uint32x2_t_from", v, False)),
    "uint32x4_t": (4, lambda v: _f("create_uint32x4_t_from", v, False)),
    "uint64x1_t": (1, lambda v: _f("create_uint64x1_t_from", v, False)),
    "uint64x2_t": (2, lambda v: _f("create_uint64x2_t_from", v, False)),
    "float32x2_t": (2, lambda v: _f("create_float32x2_t_from", v, True)),
    "float32x4_t": (4, lambda v: _f("create_float32x4_t_from", v, True)),
    "float64x1_t": (1, lambda v: _f("create_float64x1_t_from", v, True)),
    "float64x2_t": (2, lambda v: _f("create_float64x2_t_from", v, True)),
    "poly8x8_t": (8, lambda v: _f("create_poly8x8_t_from", v, False)),
    "poly8x16_t": (16, lambda v: _f("create_poly8x16_t_from", v, False)),
    "poly16x4_t": (4, lambda v: _f("create_poly16x4_t_from", v, False)),
    "poly16x8_t": (8, lambda v: _f("create_poly16x8_t_from", v, False)),
    "poly64x1_t": (1, lambda v: _f("create_poly64x1_t_from", v, False)),
    "poly64x2_t": (2, lambda v: _f("create_poly64x2_t_from", v, False)),
    "p8": (1, lambda v: f"{v[0]}u8"), "p16": (1, lambda v: f"{v[0]}u16"),
    "p64": (1, lambda v: f"{v[0]}u64"), "p128": (1, lambda v: f"{v[0]}u128"),
    "svint8_t": (1, lambda v: f"create_svint8_t_from({v[0]}i8)"),
    "svuint8_t": (1, lambda v: f"create_svuint8_t_from({v[0]}u8)"),
    "svint16_t": (1, lambda v: f"create_svint16_t_from({v[0]}i16)"),
    "svuint16_t": (1, lambda v: f"create_svuint16_t_from({v[0]}u16)"),
    "svint32_t": (1, lambda v: f"create_svint32_t_from({v[0]}i32)"),
    "svuint32_t": (1, lambda v: f"create_svuint32_t_from({v[0]}u32)"),
    "svint64_t": (1, lambda v: f"create_svint64_t_from({v[0]}i64)"),
    "svuint64_t": (1, lambda v: f"create_svuint64_t_from({v[0]}u64)"),
    "svfloat32_t": (1, lambda v: f"create_svfloat32_t_from({v[0]}.0f32)"),
    "svfloat64_t": (1, lambda v: f"create_svfloat64_t_from({v[0]}.0f64)"),
    "svbool_t": (1, lambda v: "create_svbool_t()"),
}


def seq_init(ptype: str, ctr: list[int]) -> str:
    """Return a fixed init expression with sequentially increasing values.
    `ctr` is a single-element list used as a mutable int counter."""
    if ptype not in SEQ_TYPES:
        return FIXED_INITS.get(ptype, f"0 /* {ptype} */")
    n, fmt = SEQ_TYPES[ptype]
    vals = list(range(ctr[0], ctr[0] + n))
    ctr[0] += n
    return fmt(vals)

# Return type → (unpack function, element count, zero literal)
UNPACK_INFO: dict[str, tuple[str, int, str]] = {
    "__m128":  ("unpack__m128_to_f32_array",  4,  "0.0f32"),
    "__m128d": ("unpack__m128d_to_f64_array", 2,  "0.0f64"),
    "__m128i": ("unpack__m128i_to_i32_array", 4,  "0i32"),
    "__m256":  ("unpack__m256_to_f32_array",  8,  "0.0f32"),
    "__m256d": ("unpack__m256d_to_f64_array", 4,  "0.0f64"),
    "__m256i": ("unpack__m256i_to_i32_array", 8,  "0i32"),
    "__m512":  ("unpack__m512_to_f32_array",  16, "0.0f32"),
    "__m512d": ("unpack__m512d_to_f64_array", 8,  "0.0f64"),
    "__m512i": ("unpack__m512i_to_i32_array", 16, "0i32"),
    "int8x8_t": ("unpack_int8x8_t_to_i8_array", 8, "0i8"),
    "int8x16_t": ("unpack_int8x16_t_to_i8_array", 16, "0i8"),
    "int16x4_t": ("unpack_int16x4_t_to_i16_array", 4, "0i16"),
    "int16x8_t": ("unpack_int16x8_t_to_i16_array", 8, "0i16"),
    "int32x2_t": ("unpack_int32x2_t_to_i32_array", 2, "0i32"),
    "int32x4_t": ("unpack_int32x4_t_to_i32_array", 4, "0i32"),
    "int64x1_t": ("unpack_int64x1_t_to_i64_array", 1, "0i64"),
    "int64x2_t": ("unpack_int64x2_t_to_i64_array", 2, "0i64"),
    "uint8x8_t": ("unpack_uint8x8_t_to_u8_array", 8, "0u8"),
    "uint8x16_t": ("unpack_uint8x16_t_to_u8_array", 16, "0u8"),
    "uint16x4_t": ("unpack_uint16x4_t_to_u16_array", 4, "0u16"),
    "uint16x8_t": ("unpack_uint16x8_t_to_u16_array", 8, "0u16"),
    "uint32x2_t": ("unpack_uint32x2_t_to_u32_array", 2, "0u32"),
    "uint32x4_t": ("unpack_uint32x4_t_to_u32_array", 4, "0u32"),
    "uint64x1_t": ("unpack_uint64x1_t_to_u64_array", 1, "0u64"),
    "uint64x2_t": ("unpack_uint64x2_t_to_u64_array", 2, "0u64"),
    "float32x2_t": ("unpack_float32x2_t_to_f32_array", 2, "0.0f32"),
    "float32x4_t": ("unpack_float32x4_t_to_f32_array", 4, "0.0f32"),
    "float64x1_t": ("unpack_float64x1_t_to_f64_array", 1, "0.0f64"),
    "float64x2_t": ("unpack_float64x2_t_to_f64_array", 2, "0.0f64"),
    "poly8x8_t": ("unpack_poly8x8_t_to_u8_array", 8, "0u8"),
    "poly8x16_t": ("unpack_poly8x16_t_to_u8_array", 16, "0u8"),
    "poly16x4_t": ("unpack_poly16x4_t_to_u16_array", 4, "0u16"),
    "poly16x8_t": ("unpack_poly16x8_t_to_u16_array", 8, "0u16"),
    "poly64x1_t": ("unpack_poly64x1_t_to_u64_array", 1, "0u64"),
    "poly64x2_t": ("unpack_poly64x2_t_to_u64_array", 2, "0u64"),
    # SVE base types unpack to a single scalar (svlastb_*/svptest_any - see
    # CLAUDE.md's "Non-x86 architectures" section for why: the real vector length is
    # runtime-determined, so a fixed-size array can't represent it; the array-of-1 shape
    # here just lets these reuse check_array_equality/check_float_array_equality unchanged.
    "svint8_t": ("unpack_svint8_t_to_i8_array", 1, "0i8"),
    "svuint8_t": ("unpack_svuint8_t_to_u8_array", 1, "0u8"),
    "svint16_t": ("unpack_svint16_t_to_i16_array", 1, "0i16"),
    "svuint16_t": ("unpack_svuint16_t_to_u16_array", 1, "0u16"),
    "svint32_t": ("unpack_svint32_t_to_i32_array", 1, "0i32"),
    "svuint32_t": ("unpack_svuint32_t_to_u32_array", 1, "0u32"),
    "svint64_t": ("unpack_svint64_t_to_i64_array", 1, "0i64"),
    "svuint64_t": ("unpack_svuint64_t_to_u64_array", 1, "0u64"),
    "svfloat32_t": ("unpack_svfloat32_t_to_f32_array", 1, "0.0f32"),
    "svfloat64_t": ("unpack_svfloat64_t_to_f64_array", 1, "0.0f64"),
    "svbool_t": ("unpack_svbool_t_to_i32_array", 1, "0i32"),
    # bf16 vectors, compared as raw 16-bit lane patterns - see the unpack helpers in
    # common/x86.rs for why that rather than a float view.
    "__m128bh": ("unpack__m128bh_to_u16_array", 8, "0u16"),
    "__m256bh": ("unpack__m256bh_to_u16_array", 16, "0u16"),
    "__m512bh": ("unpack__m512bh_to_u16_array", 32, "0u16"),
}

# Scalar return types compared by exact equality (check_int_equality is generic over
# PartialEq + Debug, so `bool` and the poly aliases ride along with the integers). Every type
# here has to Debug-print as something that re-parses as a Rust literal of the same type,
# since that printed form is what capture_expected.py files as the expected value.
INT_RETURNS = {
    "i8", "i16", "i32", "i64", "i128", "isize",
    "u8", "u16", "u32", "u64", "u128", "usize",
    "__mmask8", "__mmask16", "__mmask32", "__mmask64",
    # stdarch's poly aliases of the unsigned integer of the same width. NEON's scalar lane
    # reads (`vgetq_lane_p64`, `vdupb_lane_p8`) return these and were checking nothing.
    "p8", "p16", "p64", "p128",
    "bool",
}

# Scalar float returns. `_mm_cvtss_f32`, `_mm512_reduce_add_ps` and NEON's `vabdd_f64` are
# not vectors and so never reached UNPACK_INFO, and are not integers either - they fell
# through to the "compile but don't check" arm and reported Unverified on every machine.
FLOAT_RETURNS = {"f32", "f64"}


# ---------------------------------------------------------------------------
# Multi-scenario expansion (every x86/x86_64 function, except gather/scatter).
#
# Every function used to get exactly one deterministic scenario (ascending
# 1,2,3,4... via seq_init) and const-generic/immediate params were pinned to a
# single fixed value (const_val, almost always 0). That means most intrinsics
# barely exercised real behavior beyond "doesn't crash", and nothing checked
# overflow/NaN/boundary behavior. This section adds, for every in-scope
# function, several additional named scenarios: normal-but-different-shaped
# inputs, boundary values (uniform-per-lane and mixed-per-lane), an asymmetric
# MIN/MAX pair between the first two operands, and immediate-value variants -
# as an axis independent from the value axis. A function with no vector-typed
# parameter (_build_value_scenarios' `widthed` list empty - RDRAND, XSAVE,
# XGETBV, ...) or no single const generic (_build_immediate_scenarios) simply
# gets no extra scenarios either way, pilot-scope or not.
#
# Started as a narrow SSE2/AVX2-only pilot, then a PILOT_NAME_REGEX matching
# arithmetic/shift/compare/blend/min/max by name, now every x86/x86_64
# function except gather/
# scatter, which stay excluded on purpose: their vector-typed parameter isn't
# a value to vary, it's an index multiplied by a scale and added to a base
# pointer (e.g. `_mm_i32gather_epi32::<SCALE>(slice: *const i32, offsets:
# __m128i)`), so a boundary_max/allones override would turn it into a genuine
# out-of-bounds memory read - the one category _build_value_scenarios can't
# tell apart from a normal SIMD value parameter by type alone. Gather/scatter
# keep their current single, fixed, safely-in-bounds-offset scenario.
# Shuffle/permute/insert are fine to include - their vector "index" arguments
# are in-register lane selectors, masked by hardware, never a memory address,
# regardless of how extreme the value is.
# ---------------------------------------------------------------------------


def in_pilot_scope(arch: str, ext: str, func_name: str) -> bool:
    # gather/scatter: excluded by substring rather than by a function_policy.toml entry -
    # there are ~120 of them and the reason is identical for all (the vector parameter is a
    # per-lane memory index multiplied by a compile-time scale, so an extreme override is an
    # out-of-bounds read). Everything else that would assemble an invalid/undefined argument
    # combination from an "extreme value" override gets `no_value_scenarios` in that file
    # instead, with its own reason.
    if arch in ("arm", "arm_shared", "aarch64"):
        # NEON only: SVE builds its values by broadcasting one scalar into a runtime-width
        # vector (svdup_n_*) and reads one back with svlastb, a different model from the
        # per-lane arrays every scenario builder here works with.
        return ext == "neon" and func_name not in POLICY.no_value_scenarios
    return (
        arch in ("x86", "x86_64")
        and "gather" not in func_name.lower()
        and "scatter" not in func_name.lower()
        and func_name not in POLICY.no_value_scenarios
    )


# Function-name suffix → actual per-lane element type. __m128i/__m256i/__m512i
# etc. are otherwise always treated as i32/f32/f64 lanes regardless of the
# intrinsic's real width (harmless for one ascending-sequence scenario, but
# wrong for a boundary scenario: "all lanes = i8::MIN" built through an i32
# view would produce a different, meaningless bit pattern).
ELEM_SUFFIX_MAP: list[tuple[str, str]] = [
    (r"epi8\b|_pi8\b", "i8"), (r"epu8\b|_pu8\b", "u8"),
    (r"epi16\b|_pi16\b", "i16"), (r"epu16\b", "u16"),
    (r"epi32\b|_pi32\b", "i32"), (r"epu32\b", "u32"),
    (r"epi64\b", "i64"), (r"epu64\b", "u64"),
    (r"_ps\b|_ss\b", "f32"), (r"_pd\b|_sd\b", "f64"),
]
_VEC_TYPE_DEFAULT_ELEM = {
    "__m128i": "i32", "__m256i": "i32", "__m512i": "i32",
    "__m128": "f32", "__m256": "f32", "__m512": "f32",
    "__m128d": "f64", "__m256d": "f64", "__m512d": "f64",
}


def detect_elem_type(func_name: str, ptype: str) -> str:
    """Resolve the real per-lane scalar type a vector parameter is operated on as,
    from the intrinsic's name. Falls back to today's generic default (i32/f32/f64)
    for names this doesn't recognize, preserving existing behavior."""
    # A NEON type carries its own lane type, so the name-suffix guessing below is not just
    # unnecessary there but actively wrong: `vaddq_s8`'s `_s8` and `int8x16_t` agree, but
    # `vreinterpretq_u32_s8` takes an int8x16_t while its name ends in the *result* type.
    neon = _NEON_ELEM_BY_TYPE.get(ptype)
    if neon is not None:
        return neon
    for pattern, elem in ELEM_SUFFIX_MAP:
        if re.search(pattern, func_name):
            return elem
    return _VEC_TYPE_DEFAULT_ELEM.get(ptype, "i32")


# (vector_type, elem_type) -> (creator_fn, creator_container_elem, unpacker_fn, lane_count)
# `creator_container_elem` differs from `elem_type` only where values.rs has no dedicated
# creator for that exact width/signedness (e.g. no create__m128i_from_u8_array) — in that
# case we build the array in the nearest same-width container and reinterpret-cast each
# literal, which is exactly what the intrinsic's own bit-reinterpretation already relies on.
WIDTH_AWARE_VEC_INFO: dict[tuple[str, str], tuple[str, str, str, int]] = {
    ("__m128i", "i8"):  ("create__m128i_from_i8_array",  "i8",  "unpack__m128i_to_i8_array",  16),
    ("__m128i", "u8"):  ("create__m128i_from_i8_array",  "i8",  "unpack__m128i_to_u8_array",  16),
    ("__m128i", "i16"): ("create__m128i_from_i16_array", "i16", "unpack__m128i_to_i16_array", 8),
    ("__m128i", "u16"): ("create__m128i_from_u16_array", "u16", "unpack__m128i_to_u16_array", 8),
    ("__m128i", "i32"): ("create__m128i_from_i32_array", "i32", "unpack__m128i_to_i32_array", 4),
    ("__m128i", "u32"): ("create__m128i_from_u32_array", "u32", "unpack__m128i_to_u32_array", 4),
    ("__m128i", "i64"): ("create__m128i_from_i64_array", "i64", "unpack__m128i_to_i64_array", 2),
    ("__m128i", "u64"): ("create__m128i_from_i64_array", "i64", "unpack__m128i_to_u64_array", 2),
    ("__m256i", "i8"):  ("create__m256i_from_i8_array",  "i8",  "unpack__m256i_to_i8_array",  32),
    ("__m256i", "u8"):  ("create__m256i_from_u8_array",  "u8",  "unpack__m256i_to_u8_array",  32),
    ("__m256i", "i16"): ("create__m256i_from_i16_array", "i16", "unpack__m256i_to_i16_array", 16),
    ("__m256i", "u16"): ("create__m256i_from_u16_array", "u16", "unpack__m256i_to_u16_array", 16),
    ("__m256i", "i32"): ("create__m256i_from_i32_array", "i32", "unpack__m256i_to_i32_array", 8),
    ("__m256i", "u32"): ("create__m256i_from_u32_array", "u32", "unpack__m256i_to_u32_array", 8),
    ("__m256i", "i64"): ("create__m256i_from",           "i64", "unpack__m256i_to_i64_array", 4),
    ("__m256i", "u64"): ("create__m256i_from",           "i64", "unpack__m256i_to_u64_array", 4),
    ("__m512i", "i8"):  ("create__m512i_from_i8_array",  "i8",  "unpack__m512i_to_i8_array",  64),
    ("__m512i", "u8"):  ("create__m512i_from_u8_array",  "u8",  "unpack__m512i_to_u8_array",  64),
    ("__m512i", "i16"): ("create__m512i_from_i16_array", "i16", "unpack__m512i_to_i16_array", 32),
    ("__m512i", "u16"): ("create__m512i_from_u16_array", "u16", "unpack__m512i_to_u16_array", 32),
    ("__m512i", "i32"): ("create__m512i_from_i32_array", "i32", "unpack__m512i_to_i32_array", 16),
    ("__m512i", "u32"): ("create__m512i_from_u32_array", "u32", "unpack__m512i_to_u32_array", 16),
    ("__m512i", "i64"): ("create__m512i_from",           "i64", "unpack__m512i_to_i64_array", 8),
    ("__m512i", "u64"): ("create__m512i_from",           "i64", "unpack__m512i_to_u64_array", 8),
    ("__m128",  "f32"): ("create__m128_from",  "f32", "unpack__m128_to_f32_array",  4),
    ("__m256",  "f32"): ("create__m256_from",  "f32", "unpack__m256_to_f32_array",  8),
    ("__m512",  "f32"): ("create__m512_from",  "f32", "unpack__m512_to_f32_array",  16),
    ("__m128d", "f64"): ("create__m128d_from", "f64", "unpack__m128d_to_f64_array", 2),
    ("__m256d", "f64"): ("create__m256d_from", "f64", "unpack__m256d_to_f64_array", 4),
    ("__m512d", "f64"): ("create__m512d_from", "f64", "unpack__m512d_to_f64_array", 8),
}


def _neon_width_info() -> dict[tuple[str, str], tuple[str, str, str, int]]:
    """The same table for NEON, derived rather than written out.

    A NEON type name states its own lane type and count (`int8x8_t` is eight i8), unlike
    `__m128i`, which says nothing and forces the name-suffix guessing above. `common/arm.rs`
    names its helpers regularly off the type, so every entry follows from the name and there is
    nothing to keep in sync by hand as types are added.

    Poly lanes are bit containers with no arithmetic of their own; they are built and read back
    through the unsigned integer of the same width, which is what arm.rs already does."""
    kinds = {"int": "i", "uint": "u", "float": "f", "poly": "u"}
    out: dict[tuple[str, str], tuple[str, str, str, int]] = {}
    for base, prefix in kinds.items():
        for bits in (8, 16, 32, 64):
            if base == "float" and bits < 32:
                continue  # f16 lanes are excluded from generation entirely (UNSTABLE_TYPES)
            if base == "poly" and bits == 32:
                continue  # there is no poly32 NEON type
            for lanes in (1, 2, 4, 8, 16):
                if bits * lanes not in (64, 128):
                    continue
                ty = f"{base}{bits}x{lanes}_t"
                elem = f"{prefix}{bits}"
                out[(ty, elem)] = (f"create_{ty}_from", elem, f"unpack_{ty}_to_{elem}_array", lanes)
    return out


WIDTH_AWARE_VEC_INFO.update(_neon_width_info())

# Every NEON vector type, for the value-axis eligibility check - the counterpart of
# `_WIDTHED_VEC_TYPES` for x86.
NEON_VEC_TYPES = {ty for ty, _ in _neon_width_info()}
_NEON_ELEM_BY_TYPE = {ty: elem for ty, elem in _neon_width_info()}


def _fallback_unpack_elem(ret: str) -> str | None:
    """Lane type of the array a non-width-aware unpack produces, or None if unknown.

    `_elem_type_for_unpack` only knows the x86 vector types, so every NEON float return fell
    through to the integer comparator - and `NaN == NaN` is false, which no captured value can
    ever satisfy. Returns None rather than a default so the x86 path keeps behaving exactly as
    it did for returns neither table knows."""
    return _NEON_ELEM_BY_TYPE.get(ret) or _elem_type_for_unpack(ret)


def _typed_lit(elem: str, kind: str) -> str:
    """A self-typed Rust literal expression of type `elem` for one of a small set of
    semantic value 'kinds' shared by every boundary/normal scenario builder below."""
    if elem in ("f32", "f64"):
        return {
            "min": f"{elem}::MIN", "max": f"{elem}::MAX", "zero": "0.0",
            "allones": f"{elem}::NAN", "pos_inf": f"{elem}::INFINITY",
            "neg_inf": f"{elem}::NEG_INFINITY", "neg_zero": "-0.0",
            "denormal": f"{elem}::MIN_POSITIVE / 2.0",
            "min_positive": f"{elem}::MIN_POSITIVE",
        }[kind]
    if kind == "min":
        return f"{elem}::MIN"
    if kind == "max":
        return f"{elem}::MAX"
    if kind == "zero":
        return "0"
    if kind == "allones":
        # Bit pattern of all-1s: MAX for unsigned (wraps), -1 for signed.
        return f"{elem}::MAX" if elem.startswith("u") else "-1"
    raise ValueError(f"unknown literal kind {kind!r}")


def lane_lit(elem: str, container: str, kind: str) -> str:
    """A literal of `kind` (typed as `elem`'s domain), reinterpreted into `container`'s
    type when the creator function needs a different (but bit-compatible) container."""
    val = _typed_lit(elem, kind)
    if container == elem:
        return val
    # Bare numeric literals (e.g. "0", "-1") need an explicit type before the cast, or
    # rustc's literal-fallback inference can try to type them directly as the (narrower)
    # `container`, tripping the overflowing-literal lint. Already-qualified constants
    # (e.g. "u8::MAX") are unambiguous as-is. Suffix with `elem` itself (not a fixed
    # "i32") since a wrapped/computed value can legitimately need the full width of a
    # 64-bit type - "i32" would itself overflow for e.g. a u64 value near u64::MAX.
    if "::" not in val and elem not in ("f32", "f64"):
        val = f"{val}{elem}"
    return f"(({val}) as {container})"


# `arm_shared` is one source bucket compiled for two architectures, and they answer a denormal
# input differently: ARMv7 NEON flushes denormals to zero unconditionally (FTZ is architectural
# there, not an FPCR setting), AArch64 ASIMD does not. `vrecpeq_f32(f32::MIN_POSITIVE / 2.0)`
# is `inf` on armv7 (the input becomes 0) and `1.698e38` on aarch64; `vmulq_lane_f32` with the
# same input against `inf` is `NaN` on one and `inf` on the other. Both are correct on their own
# architecture, and `data/cpu/expected/arm_shared/neon.txt` has room for only one of them - so
# the mixed-float cycle uses the smallest *normal* value there instead. Denormals stay in the
# cycle everywhere the file belongs to a single architecture (x86, aarch64's own NEON, SVE).
_MIXED_FLOAT_CYCLE = ["pos_inf", "neg_inf", "neg_zero", "denormal"]
_MIXED_FLOAT_CYCLE_DUAL_ARCH = ["pos_inf", "neg_inf", "neg_zero", "min_positive"]


def boundary_lane_values(elem: str, container: str, lane_count: int, kind: str,
                         arch: str | None = None) -> list[str]:
    """5 uniform-per-lane boundary scenarios share this: every lane gets the same
    literal, except 'mixed' which rotates a small set of interesting values."""
    if kind != "mixed":
        return [lane_lit(elem, container, kind)] * lane_count
    if elem in ("f32", "f64"):
        cycle = _MIXED_FLOAT_CYCLE_DUAL_ARCH if arch == "arm_shared" else _MIXED_FLOAT_CYCLE
    else:
        cycle = ["min", "max", "zero", "allones"]
    return [lane_lit(elem, container, cycle[i % len(cycle)]) for i in range(lane_count)]


def normal_lane_values(elem: str, container: str, lane_count: int, scenario: str, offset: int) -> list[str]:
    """3 'normal' scenarios (non-boundary, non-graniczny), independent of the ascending
    seq_init counter used by the base 'normal1' scenario. Values are computed and wrapped
    to the element's representable range in Python (not via a runtime Rust `+`), so the
    generated literals never trip Rust's compile-time overflow check on narrow int types."""
    is_float = elem in ("f32", "f64")
    is_unsigned = not is_float and elem.startswith("u")
    bits = 0 if is_float else int(elem[1:])
    vals: list[str] = []

    def wrap_int(n: int) -> int:
        if is_unsigned:
            return n % (1 << bits)
        lo, hi = -(1 << (bits - 1)), (1 << (bits - 1)) - 1
        span = hi - lo + 1
        return ((n - lo) % span) + lo

    for i in range(lane_count):
        if scenario == "normal2":
            if is_float:
                base = [0.0, -1.0, 2.0, -3.0, 4.0, -5.0, 6.0, -7.0]
                vals.append(f"{base[i % len(base)] + offset}{elem}")
            else:
                base = [0, -1, 2, -3, 4, -5, 6, -7]
                vals.append(str(wrap_int(base[i % len(base)] + offset)))
        elif scenario == "normal3":
            if is_float:
                vals.append(f"{float((i + 1) * 100 + offset)}{elem}")
            else:
                vals.append(str(wrap_int((i + 1) * 100 + offset)))
        else:
            raise ValueError(scenario)
    if container == elem:
        return vals
    # Disambiguate the bare integer literal's own type before casting (otherwise rustc's
    # literal-fallback inference can try to type it directly as `container`, tripping the
    # overflowing-literal lint for values outside that narrower type's range). Suffix with
    # `elem` itself, not a fixed "i32" - values are already wrapped into elem's own valid
    # range above, but a fixed narrower suffix (e.g. "i32" for a u64 elem) can itself be
    # too small to hold them.
    suffix = "" if is_float else elem
    return [f"(({v}{suffix}) as {container})" for v in vals]


# ---------------------------------------------------------------------------
# Parsing
# ---------------------------------------------------------------------------

def source_to_ext(src_path: str) -> tuple[str, str]:
    """Derive (arch, module) from source path like 'x86/sse.rs' or 'arm/neon.rs'.
    Returns (architecture, extension_name)."""
    parts = src_path.split("/")
    if len(parts) >= 2:
        arch = parts[0]
        ext = Path(parts[-1]).stem
        # stdarch names the real intrinsic body file `generated.rs` inside a per-extension
        # subdirectory (aarch64/neon/generated.rs, arm_shared/neon/generated.rs, ...) - the
        # stem alone is a generic, colliding name, so fall back to the subdirectory name.
        if ext == "generated" and len(parts) >= 3:
            ext = parts[-2]
        return (arch, ext)
    # Fallback for unexpected formats
    return ("unknown", Path(src_path).stem)


def ext_to_feature(ext: str) -> str:
    return FEATURE_FLAGS.get(ext, ext.lower())


def ext_cargo_feature(arch: str, ext: str) -> str | None:
    """Cargo feature of hodow_cpu that compiles this extension in, or None when it is always
    compiled. AVX-512 is ~80% of the x86 suite, so a build can leave it out."""
    if arch in ("x86", "x86_64") and ext.startswith("avx512"):
        return "avx512"
    return None


def ext_gate(arch: str, ext: str, indent: str) -> list[str]:
    feature = ext_cargo_feature(arch, ext)
    return [f'{indent}#[cfg(feature = "{feature}")]'] if feature else []


def ext_to_struct(ext: str) -> str:
    return ext.upper()


def parse_sig(raw: str) -> dict | None:
    """
    Parse a single signature line such as:
      pub fn _mm_add_epi32(a: __m128i, b: __m128i) -> __m128i {
      pub fn _mm_blend_epi32<const IMM4: i32>(a: __m128i, b: __m128i) -> __m128i {
      pub unsafe fn _mm_loadu_si128(mem_addr: *const __m128i) -> __m128i {
      pub unsafe fn _mm_loadiwkey(      ← incomplete, multi-line signature
    Returns None if not a function line.
    """
    line = raw.strip()
    if not line or "fn " not in line:
        return None

    is_unsafe = "unsafe fn" in line

    name_m = re.search(r"fn\s+(\w+)", line)
    if not name_m:
        return None
    func_name = name_m.group(1)

    # Const generics  e.g. <const IMM8: i32>
    const_generics = []
    cg_m = re.search(r"fn\s+\w+<([^>]+)>", line)
    if cg_m:
        const_generics = re.findall(r"const\s+(\w+):\s*(\w+)", cg_m.group(1))

    # Detect incomplete multi-line signature (no closing paren on this line)
    if ")" not in line:
        return {"name": func_name, "params": None, "return_type": None,
                "const_generics": const_generics, "is_unsafe": is_unsafe,
                "is_complete": False}

    # Extract parameter list
    paren_m = re.search(r"\(([^)]*)\)", line)
    params_str = paren_m.group(1).strip() if paren_m else ""

    # Return type
    ret_m = re.search(r"\)\s*->\s*([\w:*<>&\[\]_; ]+?)(?:\s*\{|$)", line)
    return_type = ret_m.group(1).strip() if ret_m else "()"

    params = []
    for part in params_str.split(","):
        part = part.strip()
        if not part:
            continue
        colon = part.rfind(":")
        if colon == -1:
            continue
        pname = part[:colon].strip().lstrip("&").strip()
        ptype = part[colon + 1:].strip()
        params.append((pname, ptype))

    return {"name": func_name, "params": params, "return_type": return_type,
            "const_generics": const_generics, "is_unsafe": is_unsafe,
            "is_complete": True}


def parse_signatures(path: Path) -> dict[tuple[str, str], list[dict]]:
    """Parse signatures.txt → {(arch, ext): [sig, ...]}"""
    result: dict[tuple[str, str], list[dict]] = defaultdict(list)
    current_key: tuple[str, str] | None = None
    seen: set[tuple[str, str, str]] = set()  # (arch, ext, func_name)

    for line in path.read_text().splitlines():
        line = line.rstrip()
        if not line:
            continue
        # Line like "x86/sse.rs" or "arm/neon.rs" or "aarch64/neon/generated.rs"
        if not line.startswith(" ") and "/" in line and line.endswith(".rs"):
            arch, ext = source_to_ext(line)
            current_key = (arch, ext)
            continue
        if current_key is None:
            continue
        m = re.match(r"^\d+(?:@(\w+))?(?:%([^:!]*))?(?:!([^:]*))?:"
                     r"(pub\s+(?:const\s+)?(?:unsafe\s+)?fn\s+.+)", line)
        if not m:
            continue
        sig = parse_sig(m.group(4))
        if sig is None:
            continue
        # The function's own `#[target_feature]` set, `base^arm-only` (extract_signatures.py's
        # find_target_features). Absent for anything extracted before that was captured.
        base, _, arm_only = (m.group(2) or "").partition("^")
        sig["features"] = [f for f in base.split("+") if f]
        sig["arm_features"] = [f for f in arm_only.split("+") if f]
        # Valid values of each const generic, read out of the function's own static_assert
        # upstream (extract_signatures.py's find_const_constraints).
        sig["const_ranges"] = parse_const_marker(m.group(3))
        # Set only for arm_shared entries hard-gated to a single target_arch upstream
        # (see extract_signatures.py's find_hard_arch_gate) - the generated wrapper test
        # must carry the same #[cfg(target_arch = ...)], since arm_shared is compiled
        # unconditionally for both arm and aarch64.
        sig["arch_only"] = m.group(1)

        arch, ext = current_key
        key = (arch, ext, sig["name"])
        if key in seen:
            continue
        seen.add(key)
        result[current_key].append(sig)

    grouped = rebucket_neon_by_feature(result)
    index_functions(grouped)
    return grouped


# {arch: {function name: sig}} and {(arch, function name): extension}, filled by
# parse_signatures. The consistency properties (see "Property tests" below) are the only thing
# that needs to look a *different* function up while generating one - `_mm512_mask_add_epi32`
# is checked against `_mm512_add_epi32`, which lives in the same arch but not necessarily the
# same extension.
FUNCTIONS_BY_ARCH: dict[str, dict[str, dict]] = defaultdict(dict)
EXT_OF_FUNCTION: dict[tuple[str, str], str] = {}


def index_functions(grouped: dict[tuple[str, str], list[dict]]) -> None:
    FUNCTIONS_BY_ARCH.clear()
    EXT_OF_FUNCTION.clear()
    for (arch, ext), funcs in grouped.items():
        for sig in funcs:
            FUNCTIONS_BY_ARCH[arch][sig["name"]] = sig
            EXT_OF_FUNCTION[(arch, sig["name"])] = ext


def rebucket_neon_by_feature(data: dict[tuple[str, str], list[dict]]) -> dict[tuple[str, str], list[dict]]:
    """Move functions out of a `neon` group into a group named after the feature they really
    need, so the runtime gate checks that feature instead of NEON.

    stdarch keeps CRC32, the crypto intrinsics, dot-product, i8mm and everything else in the
    same `neon/generated.rs`, and bucketing by source file alone put all of them behind
    `is_*_feature_detected!("neon")`. On a NEON-only chip that is not a skip, it is a SIGILL:
    61 of them on an i.MX ARMv7 board (crc32/vaes/vsha/vdot/vmmla plus the vfma/vmaxnm/vrndn
    group below). Scoped to `neon` on purpose - every other extension already comes from a
    file named after its own feature, and moving an x86 function would rename its tests and
    invalidate its captured expected values for nothing.

    Two shapes, both handled here:
      - an extra *base* feature (`"neon,dotprod"`, `"crc"`, `"aes"`, ...) - required on every
        architecture, and detectable on both arm and aarch64;
      - an arm-only extra (`cfg_attr(target_arch = "arm", target_feature(enable = "vfp4"))`)
        where the function is plain NEON on aarch64. Those get their own group too, whose
        detect helper answers `is_aarch64_feature_detected!("neon")` on aarch64 and `false` on
        arm, where no runtime check for `vfp4`/`fp-armv8` exists."""
    out: dict[tuple[str, str], list[dict]] = defaultdict(list)
    for (arch, ext), funcs in data.items():
        if ext != "neon":
            out[(arch, ext)].extend(funcs)
            continue
        for sig in funcs:
            extra = [f for f in sig.get("features", []) if f not in NEON_BASELINE_FEATURES]
            if not extra:
                extra = [f for f in sig.get("arm_features", []) if f not in NEON_BASELINE_FEATURES]
            target = extra[0].replace("-", "_") if extra else ext
            out[(arch, target)].append(sig)
    return out


# ---------------------------------------------------------------------------
# Code generation
# ---------------------------------------------------------------------------

def has_ptr(params: list | None) -> bool:
    return bool(params and any("*" in pt or pt.startswith("&") for _, pt in params))


def has_unstable_type(params: list | None, ret: str) -> bool:
    """True if the function uses types not yet available in stable values.rs."""
    all_types = ([pt for _, pt in params] if params else []) + [ret]
    return any(
        any(u in t for u in UNSTABLE_TYPES)
        for t in all_types
    )


def skip_fuzz(name: str, params: list | None) -> bool:
    return has_ptr(params) or name in POLICY.no_fuzz


# ---------------------------------------------------------------------------
# Const generics: which literal to pass, and which others are worth a scenario.
#
# Both answers come from the function's own `static_assert!` upstream, carried in
# signatures.txt's `!NAME=ranges` marker (extract_signatures.py). Nothing here guesses from
# the const generic's name any more: a name told you almost nothing (NEON's `N` is a lane
# index in `vdup_lane_f64` and a shift magnitude in `vshr_n_s8`; `IMM2` is a 1..=N shift in
# SVE and an unrestricted 0..=3 selector in NEON's SM3 intrinsics), which is why each of those
# collisions previously needed its own hand-written exception here.
# ---------------------------------------------------------------------------

# A rounding-control field's numerically smallest valid value (4 = round-down) is a worse
# default than 8 (round-to-nearest, no exception), which is what these intrinsics mean by
# "no particular rounding requested" and what every captured expected value was taken with.
ROUNDING_PREFERRED = 8


class ConstConstraint(NamedTuple):
    ranges: list[tuple[int, int]]
    rounding: bool      # a rounding-control field, where 8 beats the smallest valid value
    lane_index: bool    # indexes a vector lane, so the lane count bounds it too


def parse_const_marker(marker: str | None) -> dict[str, ConstConstraint]:
    """`IMM8=0-255,SAE=4|8~r,LANE=0-3~l` → {name: ConstConstraint}."""
    out: dict[str, ConstConstraint] = {}
    for entry in (marker or "").split(","):
        if "=" not in entry:
            continue
        name, _, spec = entry.partition("=")
        lane_index = spec.endswith("~l")
        spec = spec.removesuffix("~l")
        rounding = spec.endswith("~r")
        spec = spec.removesuffix("~r")
        ranges: list[tuple[int, int]] = []
        for part in spec.split("|"):
            m = re.fullmatch(r"(-?\d+)-(-?\d+)", part) or re.fullmatch(r"(-?\d+)", part)
            if m is None:
                continue
            ranges.append((int(m.group(1)), int(m.group(m.lastindex))))
        if ranges:
            out[name] = ConstConstraint(ranges, rounding, lane_index)
    return out


def _in_ranges(value: int, ranges: list[tuple[int, int]]) -> bool:
    return any(lo <= value <= hi for lo, hi in ranges)


def const_val(cg_name: str, func_name: str = "", cg_type: str = "",
              constraint: ConstConstraint | None = None) -> str:
    """The literal a const generic is instantiated with in the base ('normal1') scenario."""
    if cg_type == "svpattern":
        # SVE predicate-pattern enum, not an integer - SV_ALL activates every element,
        # valid for every svpattern-typed const generic regardless of what it governs.
        # Braces are required here (unlike a bare integer literal): a path const-generic
        # argument needs `{ }` to disambiguate it from a type argument.
        return "{ svpattern::SV_ALL }"
    override = POLICY.const_overrides.get((func_name, cg_name))
    if override is not None:
        return override
    if constraint is None:
        # No static_assert anywhere in the function or in whatever it delegates to, so
        # nothing constrains the value: 0 is in range for an unconstrained integer.
        return "0"
    ranges = constraint.ranges
    for preferred in ((ROUNDING_PREFERRED, 0) if constraint.rounding else (0,)):
        if _in_ranges(preferred, ranges):
            return str(preferred)
    return str(ranges[0][0])


def const_suffix(cg: list, func_name: str = "", const_ranges: dict | None = None) -> str:
    ranges = const_ranges or {}
    return f"::<{', '.join(const_val(n, func_name, t, ranges.get(n)) for n, t in cg)}>" if cg else ""


# How many extra immediate scenarios one const generic is worth. The catalog below can offer
# more (a 0..=255 shift immediate has plenty of interesting values); this caps what any single
# function contributes, so widening the axis to a whole architecture does not multiply the
# suite by the largest range in it.
MAX_IMMEDIATE_SCENARIOS = 4


def immediate_catalog(constraint: ConstConstraint, elem_type: str, lane_count: int | None,
                      base_value: str, width_bound: int | None = None) -> list[tuple[str, str]]:
    """Immediate-axis scenarios for a const-generic parameter: (suffix, literal) pairs.
    Independent from the value axis (see gen_scenarios) - runtime args stay at 'normal1'
    while these vary the immediate, so the two axes are additive, not multiplied.

    Every value comes from the range the function itself asserts, so each is valid by
    construction: no `static_assert` can fire, whatever the architecture. That is what makes
    this axis safe to apply outside x86 - hand-picked x86-shaped literals produced 220
    `E0080: assertion failed` the one time NEON was tried with them."""
    ranges = constraint.ranges
    if constraint.lane_index and lane_count is not None:
        # A lane index is bounded by the vector, which the function's own assert does not
        # always say: `vgetq_lane_u64<IMM5>` takes a two-lane uint64x2_t and asserts 0..=3, so
        # instantiating it with 3 passes the assert and then fails monomorphization with "SIMD
        # index #1 is out of bounds (limit 2)". Upstream's assert is wrong there; clamping is
        # a no-op wherever it is right.
        ranges = [(lo, min(hi, lane_count - 1)) for lo, hi in ranges if lo <= lane_count - 1]
        if not ranges:
            return []
    if width_bound is not None:
        # Same shape of upstream mistake one step further out: `vcvts_n_f32_s32` converts a
        # 32-bit scalar (`llvm.aarch64.neon.vcvtfxs2fp.f32.i32`) and SCVTF takes at most 32
        # fractional bits there, but stdarch asserts `N >= 1 && N <= 64` - the 64-bit
        # sibling's bound, copied. 64 passes the assert and reaches instruction selection,
        # where it is not an error message but `rustc-LLVM ERROR: Cannot select`, which takes
        # the whole aarch64 build down. Clamping is a no-op wherever the assert is right.
        ranges = [(lo, min(hi, width_bound)) for lo, hi in ranges if lo <= width_bound]
        if not ranges:
            return []
    lo, hi = ranges[0][0], ranges[-1][1]
    lane_bits = {"i8": 8, "u8": 8, "i16": 16, "u16": 16,
                 "i32": 32, "u32": 32, "i64": 64, "u64": 64}.get(elem_type, 32)
    # Lowest and highest accepted value, one step in from the bottom, the lane width and one
    # below it (a shift/rotate/lane-index immediate's real boundary is the element width,
    # which the range alone does not say - `_mm_srli_epi32`'s immediate is 0..=255 while
    # anything >= 32 means "shift everything out"), and the midpoint for a wide range.
    candidates = [lo, lo + 1, hi, lane_bits - 1, lane_bits, (lo + hi) // 2]
    out: list[tuple[str, str]] = []
    seen = {int(base_value)} if base_value.lstrip("-").isdigit() else set()
    for value in candidates:
        if value in seen or not _in_ranges(value, ranges):
            continue
        seen.add(value)
        suffix = f"imm_{value}" if value >= 0 else f"imm_m{-value}"
        out.append((suffix, str(value)))
        if len(out) == MAX_IMMEDIATE_SCENARIOS:
            break
    return out


def inner_ref_type(ptype: str) -> str | None:
    """If ptype is '&T' or '&mut T', return T. Else None."""
    pt = ptype.strip()
    if pt.startswith("&mut "):
        return pt[5:].strip()
    if pt.startswith("&"):
        return pt[1:].strip()
    return None


def arg_expr(ptype: str, *, random: bool) -> str:
    """Expression to pass for a parameter of the given type."""
    pt = ptype.strip()
    if "*" in pt:
        return "__ptr__"  # placeholder; handled by caller
    if pt.startswith("&"):
        return "__ref__"  # placeholder; handled by caller
    table = RANDOM_CREATORS if random else FIXED_INITS
    return table.get(pt, f"0 /* {pt} */")


EXPECTED_HEADER = """\
# Expected values captured from real hardware for this extension's generated tests.
# Format: test_name - rust_expr
#
# One file per (architecture, extension) - written by scripts/cpu/capture_expected.py and
# capture_expected_cross.py, read by generate_tests.py. Do not hand-edit: recapture instead.
# A qemu-derived value is not a real-silicon one; see CLAUDE.md's "Non-x86 architectures".
"""


def expected_file(arch: str, ext: str) -> Path:
    return EXPECTED_DIR / arch / f"{ext}.txt"


def load_expected_values(directory: Path = EXPECTED_DIR) -> dict[str, str]:
    """Merge every `<arch>/<ext>.txt` under `directory` into {test_name: rust_expr}."""
    result: dict[str, str] = {}
    if not directory.is_dir():
        return result
    for path in sorted(directory.rglob("*.txt")):
        for line in path.read_text().splitlines():
            line = line.strip()
            if not line or line.startswith("#") or " - " not in line:
                continue
            name, _, value = line.partition(" - ")
            result[name.strip()] = value.strip()
    return result


def write_expected_values(groups: dict[tuple[str, str], dict[str, str]]) -> list[Path]:
    """Write one file per (arch, ext); returns the paths touched."""
    written = []
    for (arch, ext), entries in sorted(groups.items()):
        path = expected_file(arch, ext)
        path.parent.mkdir(parents=True, exist_ok=True)
        body = "".join(f"{name} - {entries[name]}\n" for name in sorted(entries))
        path.write_text(EXPECTED_HEADER + "\n" + body)
        written.append(path)
    return written


def test_group_map(sigs_file: Path = SIGNATURES_FILE) -> dict[str, tuple[str, str]]:
    """{test_name: (arch, extension)} for every test the generator would emit.

    Capture scripts only ever see test *names* in a log, but have to write each value into
    its extension's file. Rebuilding the map from the same parse + scenario expansion the
    generator uses keeps the two from disagreeing - a name is never guessed by splitting it
    on underscores, which is ambiguous anyway (`arm_shared`, `fp_armv8`)."""
    out: dict[str, tuple[str, str]] = {}
    for (arch, ext), funcs in parse_signatures(sigs_file).items():
        for sig in funcs:
            names = list_scenario_names(sig, arch, ext)
            for name in names:
                out[name] = (arch, ext)
    return out


def expected_shape(sig: dict) -> str | None:
    """'tuple' / 'array' / 'scalar' - the shape of the value `emit_check` will compare for
    this function, or None when it compares nothing at all."""
    name = sig["name"]
    ret = (sig["return_type"] or "()").strip()
    shapes = []
    if name not in POLICY.skip_result_check:
        if ret in UNPACK_INFO:
            shapes.append("array")
        elif ret in INT_RETURNS or ret in FLOAT_RETURNS:
            shapes.append("scalar")
    for _pname, kind, _lane, _count in out_readbacks(name, sig["params"], is_state_save(name)):
        shapes.append("array" if kind == "buffer" else "scalar")
    if not shapes:
        return None
    return "tuple" if len(shapes) > 1 else shapes[0]


def drop_shape_mismatched_expected(all_sigs: dict, expected_values: dict[str, str]) -> list[str]:
    """Forget any captured value whose shape no longer matches what the generator emits, and
    return the names so the caller can say so.

    Widening what a test checks changes that shape: a store's destination buffer read back
    turns a test that compared nothing into one comparing an array, and a function that both
    returns a value and writes one turns into a tuple of the two. Re-emitting the old scalar
    against the new shape is not a wrong expectation, it is `error[E0609]: no field 0 on type
    [{integer}; 4]` - a build failure in a generated file, which is a bad way to learn that a
    capture is stale. Treating it as uncaptured makes the test report `Unverified` until the
    next capture run refills it, which is what every other missing value already does."""
    dropped = []
    for (arch, ext), funcs in all_sigs.items():
        for sig in funcs:
            want = expected_shape(sig)
            for test in list_scenario_names(sig, arch, ext):
                value = expected_values.get(test)
                if value is None:
                    continue
                if is_property_test(test):
                    # Its oracle is another intrinsic, not a file. A value here can only have
                    # come from a capture run scraping a genuine failure, where recording it
                    # would turn the failure into the expectation.
                    del expected_values[test]
                    dropped.append(test)
                    continue
                got = "tuple" if value.startswith("(") else "array" if value.startswith("[") else "scalar"
                if want != got:
                    del expected_values[test]
                    dropped.append(test)
    return dropped


def _elem_type_for_unpack(ret: str) -> str | None:
    """Return element type for unpacked return types: 'f32', 'f64', or 'i32'."""
    # Map known returns to element types
    mapping = {
        "__m128": "f32",
        "__m256": "f32",
        "__m512": "f32",
        "__m128d": "f64",
        "__m256d": "f64",
        "__m512d": "f64",
        "__m128i": "i32",
        "__m256i": "i32",
        "__m512i": "i32",
        "svfloat32_t": "f32",
        "svfloat64_t": "f64",
    }
    return mapping.get(ret)


def _adjust_expected_for_ret(expected: str, ret: str) -> str:
    """Adjust expected literal text so its element literals match the element type for `ret`."""
    return _adjust_expected_for_elem(expected, _fallback_unpack_elem(ret))


def _adjust_expected_for_elem(expected: str, elem: str | None) -> str:
    """Adjust expected literal text so its element literals match `elem`.

    Currently this handles converting float-special tokens (NaN/inf) and common f32/f64 prefixes.
    """
    if not elem or expected is None:
        return expected

    s = expected
    # If elements are f64 but expected contains f32::NAN / f32::INFINITY, convert them to f64::...
    if elem == "f64":
        s = re.sub(r"\bf32::(NAN|INFINITY|NEG_INFINITY)\b(?:\.into\(\))?", r"f64::\1", s)
        # If there are explicit f32 suffixes like 1.0f32, convert to f64 suffix
        s = re.sub(r"(\d+\.\d+|\d+)f32\b", lambda m: m.group(1) + "f64", s)
        # Remove unnecessary `.into()` after numeric literals (e.g. f32::NAN.into())
        s = re.sub(r"(f64::(?:NAN|INFINITY|NEG_INFINITY))\.into\(\)", r"\1", s)
    elif elem == "f32":
        # Convert f64::NAN -> f32::NAN when necessary
        s = re.sub(r"\bf64::(NAN|INFINITY|NEG_INFINITY)\b(?:\.into\(\))?", r"f32::\1", s)
        s = re.sub(r"(\d+\.\d+|\d+)f64\b", lambda m: m.group(1) + "f32", s)
        s = re.sub(r"(f32::(?:NAN|INFINITY|NEG_INFINITY))\.into\(\)", r"\1", s)
    # For integer arrays, strip floating suffixes if present
    elif elem == "i32":
        s = re.sub(r"(\d+)f32\b", lambda m: m.group(1), s)
        s = re.sub(r"(\d+)f64\b", lambda m: m.group(1), s)
        # remove any ::NAN etc if they accidentally got here
        s = re.sub(r"\b(?:f32|f64)::(NAN|INFINITY|NEG_INFINITY)\b", "0", s)
    return s


def _checked(check_call: str, call: str) -> str:
    """Wraps a `check_*_equality(...)` call (no trailing `?`) so a failure's error also
    reports the exact call - including every input literal - that produced it. The check
    functions themselves only ever see the computed result and expected value; without
    this, a failing test's message shows two outputs (Got/expected) with no way to tell
    what input produced them."""
    plain = call.replace("\\", "\\\\").replace('"', '\\"')
    return f'{check_call}.map_err(|e| crate::cpu::with_call(e, "{plain}"))?;'


# The two `Verdict`s a test with no captured expected value can end on. The `{:?}` here has
# to stay byte-identical to what `common::check_*` puts in a mismatch message, since
# capture_expected.py parses both into the same `data/cpu/expected/<arch>/<ext>.txt` entry.
UNVERIFIED_VALUE = 'Verdict::Unverified(Some(format!("{result:?}")))'
UNVERIFIED_NOTHING = "Verdict::Unverified(None)"


def out_readbacks(name: str, params: list | None, state_save: bool) -> list[tuple[str, str, str, int]]:
    """(param, kind, lane type, lane count) for every parameter whose written-back memory is
    a function of this call's arguments - i.e. every output this test can actually check.

    A store intrinsic returns `()` and puts its whole result in memory, so without reading
    that memory back the generated test asserts *nothing*: it used to build the destination
    buffer, call through it and drop the buffer unread, ending on `Verdict::Unverified(None)`.
    That was 2164 of the suite's tests, `_mm_stream_si64` and every `_mm_store*`/`vst1_*`
    among them.

    Only the first `MAX_SIMD_BYTES` of a buffer are read back, whatever its declared length:
    that is the widest a single instruction can write, and gather/scatter buffers are sized
    for an index range rather than a register. The untouched tail keeps its `seq_init` fill,
    which is deterministic too - so comparing the whole window also catches a store that
    writes *past* the lanes it should, not just one that writes the wrong values.

    An output that is not a function of the arguments yields nothing here and the test stays
    unverified: `state_save` covers the XSAVE/FXSAVE region (processor state, different on
    every machine and every call), `skip_output_check` in function_policy.toml covers the
    hand-known rest (RDRAND/RDSEED randomness, RDTSCP's TSC_AUX, Key Locker handles wrapped
    with a per-boot internal key)."""
    if state_save or name in POLICY.skip_output_check:
        return []
    reads: list[tuple[str, str, str, int]] = []
    for pname, ptype in params or []:
        if "*mut" in ptype:
            lane = OUT_LANE_TYPE.get(ptype.replace("*mut", "").strip())
            if lane is None:
                continue
            reads.append((pname, "buffer", lane, max(1, MAX_SIMD_BYTES // LANE_BYTES[lane])))
        elif ptype.strip().startswith("&mut"):
            lane = OUT_LANE_TYPE.get(inner_ref_type(ptype) or "")
            if lane is None:
                continue
            reads.append((pname, "scalar", lane, 1))
    return reads


def _emit_readback(lines: list[str], pname: str, kind: str, lane: str, count: int, binding: str) -> None:
    """One output parameter, read back into `binding` after the call.

    `black_box` is not decoration: at any optimisation level above the debug build the
    expected values are captured in, LLVM knows what a store intrinsic does and may forward
    the stored value straight to this read - and then delete the store, leaving a test that
    passes without the instruction under test ever executing. Making the destination opaque
    between the two is what keeps the load coming from memory."""
    var = ("ptr_" if kind == "buffer" else "ref_") + pname
    lines.append(f"        let _ = core::hint::black_box(&mut {var});")
    if kind == "buffer":
        lines.append(f"        let {binding} = core::ptr::read({var}.0.as_ptr().cast::<[{lane}; {count}]>());")
    else:
        lines.append(f"        let {binding} = {var};")


def emit_check(lines: list[str], call: str, ret: str, expected: str | None = None,
               width_override: tuple[str, str, int] | None = None, skip_check: bool = False,
               check_lanes: int | None = None, out_reads: list[tuple[str, str, str, int]] | None = None) -> str:
    """Append lines that call `call` and check everything it produced; return the `Verdict`
    the test ends on.

    A test with no `expected` compares against nothing at all and reports
    `Verdict::Unverified` instead of the zero placeholder it used to assert against - that
    placeholder was not a check in either direction (see `Verdict`'s own doc comment), and the
    observed value it carries is what `capture_expected.py` turns into a real expectation.

    An intrinsic can produce a value two ways, and both are checked: the return value, and
    the memory it wrote through an output pointer (`out_reads`, see `out_readbacks`). A
    function with both - `_addcarry_u32` returns the carry and writes the sum, `_mulx_u32`
    returns the low half and writes the high one - is compared as a tuple of the two, so one
    captured entry per test still covers all of it. Its components keep their own
    comparators, since a float buffer needs the tolerant one.

    `skip_check`, when true (`skip_result_check` in function_policy.toml), drops the *return*
    into the same "compile but don't check" arm `CpuidResult`/`__m128h`/etc. already fall into
    regardless of `ret`/`expected` - the return value is a real machine-identity fact, not a
    function of the call's fixed arguments, so no single captured constant can ever be valid
    everywhere. It says nothing about the function's memory output: `skip_output_check` is
    the separate key for that, so `_rdrand16_step` can keep checking its status return while
    ignoring the random value it stores.

    `check_lanes`, when given (`check_lanes` in function_policy.toml), compares only the leading N lanes
    of the unpacked array - the rest are architecturally unspecified, not merely uncaptured,
    so comparing them against one machine's captured value is a guaranteed false positive
    somewhere else, the same shape of bug `skip_result_check` fixes for a whole-value return.

    `width_override`, if given as (unpacker_fn, container_elem, lane_count), replaces the
    generic UNPACK_INFO-driven unpack for a vector return — used for pilot-scope functions
    so e.g. an `_epi8`-returning `__m128i` is unpacked per real 8-bit lane instead of the
    generic (still bit-correct, but far less readable) 4-lane i32 view every other function
    still uses."""
    out_reads = out_reads or []
    lanes = f"[..{check_lanes}]" if check_lanes is not None else ""

    # How the return value participates: (unpack fn or None, comparator, lane type).
    ret_src: tuple[str | None, str, str | None] | None = None
    if skip_check:
        ret_src = None
    elif width_override is not None and ret in UNPACK_INFO:
        fn, container, _size = width_override
        ret_src = (fn, "array_float" if container in ("f32", "f64") else "array_int", container)
    elif ret in UNPACK_INFO:
        elem = _fallback_unpack_elem(ret)
        ret_src = (UNPACK_INFO[ret][0], "array_float" if elem in ("f32", "f64") else "array_int", elem)
    elif ret in INT_RETURNS:
        # No `as i32`: a u64/__mmask64 result compared through an i32 threw away its top half,
        # so every AVX-512 byte-granularity mask was only ever checked over lanes 0..31.
        ret_src = (None, "scalar_int", ret)
    elif ret in FLOAT_RETURNS:
        ret_src = (None, "scalar_float", ret)

    sources: list[tuple[str, str, str | None]] = []  # (value expression, comparator, lane type)
    single = (1 if ret_src is not None else 0) + len(out_reads) == 1

    if ret_src is None:
        # Nothing to compare against, but the call still has to happen: `Unverified(None)`
        # claims the instruction ran, and that is the whole value such a test has left. A
        # discarded return is exactly what lets LLVM delete a side-effect-free intrinsic, so
        # black_box makes the claim structural instead of a property of how the intrinsics
        # that currently land here happen to be modelled. A `()` return has no value to hold
        # on to, and every intrinsic with one writes memory or is inline asm.
        lines.append(f"        {call};" if ret in ("()", "")
                     else f"        let _result = core::hint::black_box({call});")
    else:
        unpack, cmp_kind, elem = ret_src
        binding = "result" if single else "ret_value"
        lines.append(f"        let {binding} = {f'{unpack}({call})' if unpack else call};")
        sources.append((binding, cmp_kind, elem))

    for pname, kind, lane, count in out_reads:
        binding = "result" if single else f"out_{pname}"
        _emit_readback(lines, pname, kind, lane, count, binding)
        shape = "scalar" if kind == "scalar" else "array"
        sources.append((binding, f"{shape}_{'float' if lane in ('f32', 'f64') else 'int'}", lane))

    if not sources:
        return UNVERIFIED_NOTHING
    if len(sources) > 1:
        lines.append(f"        let result = ({', '.join(s[0] for s in sources)});")
    if expected is None:
        return UNVERIFIED_VALUE

    # One captured entry per test: a single source compares directly, several compare
    # component-wise against one tuple literal. Only a homogeneous tuple gets the float-token
    # adjustment - it rewrites the whole string, so a mixed one would corrupt the int half.
    elems = {s[2] for s in sources}
    adj = _adjust_expected_for_elem(expected, next(iter(elems)) if len(elems) == 1 else None)
    if len(sources) == 1:
        _emit_compare(lines, call, sources[0][1], "result", adj, lanes)
    else:
        lines.append(f"        let expected = {adj};")
        for i, (_binding, cmp_kind, _elem) in enumerate(sources):
            _emit_compare(lines, call, cmp_kind, f"result.{i}", f"expected.{i}", "")
    return "Verdict::Checked"


def _emit_compare(lines: list[str], call: str, cmp_kind: str, got: str, want: str, lanes: str) -> None:
    """One `check_*_equality` line. The shape half of `cmp_kind` picks between a scalar and an
    array comparator, the element half between the exact one and the float-tolerant one that
    also treats NaN as equal to NaN."""
    check = {
        "scalar_int": f"check_int_equality({got}, {want})",
        "scalar_float": f"check_float_equality({got}, {want})",
        "array_int": f"check_array_equality(&{got}{lanes}, &{want}{lanes})",
        "array_float": f"check_float_array_equality(&{got}{lanes}, &{want}{lanes})",
    }[cmp_kind]
    lines.append("        " + _checked(check, call))


def test_name(func_name: str, arch: str, ext: str) -> str:
    """test_<arch>_<ext>_ + strip leading underscores, e.g. (x86, sse4a, _mm_add) →
    test_x86_sse4a_mm_add. The arch/ext prefix makes which CPU feature a failing test
    belongs to legible from the bare test name alone (e.g. in a log line), without having
    to cross-reference the surrounding ExtensionTest grouping."""
    return f"test_{arch}_{ext}_" + func_name.lstrip("_")


def extra_feature_guard_lines(arch: str | None, ext: str | None, sig: dict) -> list[str]:
    """A function's own captured `#[target_feature]` set (`sig["features"]`, from
    extract_signatures.py's find_target_features) can require MORE than the group's single
    base feature that gates the whole group before any of its tests run. `_xsavec` lives in
    the "xsave" group (so the pre-group check only ever tests
    `is_x86_feature_detected!("xsave")`), but the function itself is
    `#[target_feature(enable = "xsave,xsavec")]` - XSAVEC is a separate, optional CPUID bit
    an XSAVE-only CPU need not have. Calling it there is a genuine #UD -> SIGILL, not codegen
    UB - reproduced on an AMD GX-420GI (Jaguar/Puma), which has XSAVE but not XSAVEC/XSAVEOPT.
    `target_feature_attr` already emits the full compound string on the function's own
    `#[target_feature(enable = ...)]` attribute (so codegen is always correct for whichever
    machine actually reaches it); this adds the runtime gate the group-level check alone
    does not provide, for every feature beyond the group's own.

    Applies to every architecture whose detection strings are known: `extra_features` only
    returns a feature that `is_<arch>_feature_detected!` actually accepts, checked against the
    table extract_signatures.py pulls out of the toolchain's own std_detect, so this can no
    longer emit a check that fails to compile. aarch64's SVE compound cases (`sve+f64mm`,
    `sve2+sve2-aes`) are the reason - they have exactly the `_xsavec` shape and were
    previously left ungated for want of a way to confirm the string was valid."""
    if ext is None or arch is None:
        return []
    extra = extra_features(arch, ext, sig)
    if not extra:
        return []
    # get_feature_detect_fn, not a raw is_x86_feature_detected!("{f}") format - "kl"/"widekl"
    # need keylocker_usable() instead (see its own note: the plain macro reports Key Locker
    # present off CPUID alone, not off CR4.KL/AESKLE actually being enabled), and reusing the
    # same dispatch here keeps this guard from silently reintroducing that exact bug for any
    # function whose extra feature happens to be one of those two.
    checks = " && ".join(get_feature_detect_fn(arch, f) for f in extra)
    missing = "+".join(extra)
    # Skipped, not passed: the body below never runs, and counting that as a pass is how an
    # XSAVE-only CPU used to report a clean `test_x86_xsave_xsavec`.
    return [f"        if !({checks}) {{", f'            return Ok(Verdict::Skipped("{missing} not present"));', "        }"]


# The std_detect table (data/cpu/detectable_features.txt) each architecture's own feature
# strings live in. `arm_shared` is compiled for both arm and aarch64, so a feature it needs
# has to be checkable on both - see gen_arm_shared_detect_helpers for how that is dispatched.
DETECT_TABLE_FOR_ARCH: dict[str, tuple[str, ...]] = {
    "x86": ("x86",), "x86_64": ("x86",),
    "aarch64": ("aarch64",), "arm": ("arm",), "arm_shared": ("arm", "aarch64"),
}


def extra_features(arch: str, ext: str, sig: dict) -> list[str]:
    """Features a function needs beyond its group's own, limited to ones that can actually be
    checked at runtime here. An undetectable extra feature yields nothing rather than a guess:
    the group-level check stays the only gate, exactly as before this existed."""
    tables = DETECT_TABLE_FOR_ARCH.get(arch)
    if tables is None:
        return []
    base_feature = ext_to_feature(ext)
    detectable = set.intersection(*(DETECTABLE_FEATURES.get(t, set()) for t in tables)) if tables else set()
    return sorted({
        f for f in sig.get("features", [])
        if f and f != base_feature and f not in NEON_BASELINE_FEATURES and f in detectable
    })


def gen_fn_body(sig: dict, expected: str | None, param_overrides: dict[str, str] | None = None,
                 cg_override: str | None = None, elem_type: str | None = None,
                 arch: str | None = None, ext: str | None = None) -> list[str]:
    """Core per-scenario body (everything between the fn signature and its closing brace).
    With no overrides and no `elem_type` this reproduces exactly the single deterministic
    scenario every function got before scenario expansion existed — byte-identical output,
    so functions outside the pilot scope are completely unaffected by this refactor.

    `elem_type`, when given (pilot-scope functions only), also makes the RETURN value
    unpack per its real lane width (e.g. `_epi8` -> 16 `i8` lanes) instead of the generic
    4-lane `i32`/`f32`/`f64` view every function used before — the same fix in spirit as
    the width-aware INPUT construction, so captured expected values stay readable."""
    name = sig["name"]
    params: list = sig["params"] or []
    ret: str = sig["return_type"] or "()"
    cg: list = sig["const_generics"]
    complete: bool = sig["is_complete"]
    cs = f"::<{cg_override}>" if cg_override is not None else const_suffix(cg, name, sig.get("const_ranges"))
    no_fuzz = skip_fuzz(name, params)
    overrides = param_overrides or {}
    width_override = None
    if elem_type is not None:
        entry = WIDTH_AWARE_VEC_INFO.get((ret, elem_type))
        if entry is not None:
            _creator, container, unpacker, lanes = entry
            width_override = (unpacker, container, lanes)

    lines: list[str] = []
    # Some intrinsics work on real hardware but cannot be executed under Miri (it can't
    # call the LLVM foreign function / inline asm). Skip only under Miri; still run natively.
    if name in MIRI_SKIP_FUNCTIONS:
        lines.append("        if cfg!(miri) {")
        lines.append('            return Ok(Verdict::Skipped("miri cannot execute this intrinsic"));')
        lines.append("        }")
    lines += extra_feature_guard_lines(arch, ext, sig)
    lines.append("    unsafe {")

    is_gather = any(p in name.lower() for p in ("gather", "scatter"))
    state_save = is_state_save(name)
    ctr = [1]  # sequential counter, reset per-function for stable inputs

    verdict = UNVERIFIED_NOTHING
    if not complete:
        lines.append(f"        todo!(\"{name}\")")
    elif has_ptr(params):
        # Build local buffers for pointer and reference arguments.
        # Gather/scatter: large array (safe for any valid offset) + zeroed SIMD offsets.
        # Otherwise: size each buffer to hold a full SIMD register so wide loads/stores
        # through a small-element pointer (e.g. loadu_epi8) never read/write out of bounds.
        call_args: list[str] = []
        for pname, ptype in params:
            ref_inner = inner_ref_type(ptype)
            if "*const" in ptype:
                inner = ptype.replace("*const", "").strip()
                array_size = 4096 if state_save else (64 if is_gather else ptr_array_size(inner))
                init = overrides[pname] if pname in overrides else seq_init(inner, ctr)
                lines.append(f"        let ptr_{pname} = crate::cpu::common::Aligned64([{init}; {array_size}]);")
                call_args.append(f"ptr_{pname}.0.as_ptr()")
            elif "*mut" in ptype:
                inner = ptype.replace("*mut", "").strip()
                array_size = 4096 if state_save else (64 if is_gather else ptr_array_size(inner))
                init = overrides[pname] if pname in overrides else seq_init(inner, ctr)
                lines.append(f"        let mut ptr_{pname} = crate::cpu::common::Aligned64([{init}; {array_size}]);")
                call_args.append(f"ptr_{pname}.0.as_mut_ptr()")
            elif ref_inner is not None:
                # &T or &mut T — create a local variable
                init = overrides[pname] if pname in overrides else seq_init(ref_inner, ctr)
                is_mut = ptype.strip().startswith("&mut")
                mut_kw = "mut " if is_mut else ""
                lines.append(f"        let {mut_kw}ref_{pname} = {init};")
                ref_kw = "&mut " if is_mut else "&"
                call_args.append(f"{ref_kw}ref_{pname}")
            else:
                if pname in overrides:
                    init = overrides[pname]
                elif (name, pname) in POLICY.param_overrides:
                    init = POLICY.param_overrides[(name, pname)]
                elif is_gather:
                    # Gather/scatter: zeroed SIMD for index/offset params (all read from base+0)
                    init = ZERO_SIMD_INITS.get(ptype, FIXED_INITS.get(ptype, f"0 /* {ptype} */"))
                else:
                    init = seq_init(ptype, ctr)
                lines.append(f"        let {pname} = {init};")
                call_args.append(pname)
        call = f"{name}{cs}({', '.join(call_args)})"
        if HW_RNG_STEP_RE.fullmatch(name):
            call = hw_rng_retry(name, call)
        verdict = emit_check(lines, call, ret, expected, width_override, name in POLICY.skip_result_check,
                             POLICY.check_lanes.get(name), out_readbacks(name, params, state_save))
    else:
        call_args = [
            overrides[pname] if pname in overrides
            else POLICY.param_overrides.get((name, pname)) or seq_init(pt, ctr)
            for pname, pt in params
        ]
        call = f"{name}{cs}({', '.join(call_args)})"
        verdict = emit_check(lines, call, ret, expected, width_override, name in POLICY.skip_result_check,
                             POLICY.check_lanes.get(name))

    # Fuzzing block (still inside the single unsafe {})
    if not no_fuzz and complete:
        lines.append("")
        lines.append("        crate::cpu::fuzz(&mut || {")
        fuzz_args = [arg_expr(pt, random=True) for _, pt in params
                     if "*" not in pt and not pt.startswith("&")]
        fuzz_call = f"{name}{cs}({', '.join(fuzz_args)})"
        if ret in ("()", ""):
            lines.append(f"            {fuzz_call};")
        else:
            lines.append(f"            let _ = {fuzz_call};")
        lines.append("        });")

    # Inside the unsafe block, which is the fn's tail expression: an unverified verdict names
    # `result`, and that binding does not outlive the block.
    lines.append(f"        Ok({verdict})")
    lines.append("    }")
    return lines


def arch_only_cfg_line(sig: dict) -> list[str]:
    """`arm_shared` is compiled unconditionally for both arm and aarch64 - a signature
    hard-gated upstream to a single one of them (see extract_signatures.py's
    find_hard_arch_gate) needs the same `#[cfg(target_arch = ...)]` on the generated
    wrapper, or it fails to compile on the other target."""
    arch_only = sig.get("arch_only")
    return [f'#[cfg(target_arch = "{arch_only}")]'] if arch_only else []


def target_feature_attr(arch: str, ext: str, feature: str) -> str | None:
    """The `#[target_feature(enable = ...)]` a generated test wrapper must carry, or None.

    Enabling the extension per function instead of crate-wide (`-C target-cpu=native`) is
    what makes the binary universal: LLVM may only emit the extension's instructions inside
    these wrappers, which the registry reaches only behind a runtime detection check. A
    crate-wide `-C target-feature=+...` would let it put them anywhere, including code that
    runs before any detection. It also stops `is_x86_feature_detected!` from short-circuiting
    on `cfg!(target_feature = ...)` - see keylocker_usable for what that hid."""
    if arch == "aarch64" and ext in ("sve", "sve2"):
        # SVE's scalable-vector types need this on ANY function whose signature or locals
        # touch one - a hard ABI requirement, not the codegen-scoping role it plays on x86.
        return '#[target_feature(enable = "sve")]'
    if arch not in ("x86", "x86_64"):
        return None
    if feature in UNSUPPORTED_FEATURES or feature in BASELINE_ALWAYS_TRUE_FEATURES:
        return None
    return f'#[target_feature(enable = "{feature}")]'


def emit_test_fn(cfg_lines: list[str], test: str, body: list[str], tf_attr: str | None) -> str:
    """A `#[target_feature]` function does not coerce to the registry's safe `fn()` pointer,
    so the attribute goes on an inner `_impl` and the registry-visible symbol stays a plain
    safe wrapper that only calls it through one unsafe block."""
    if tf_attr is None:
        return "\n".join(cfg_lines + [f"pub(super) fn {test}() -> Result<Verdict, String> {{"] + body + ["}"])
    impl_name = f"{test}_impl"
    lines = cfg_lines + [tf_attr, f"fn {impl_name}() -> Result<Verdict, String> {{"] + body + ["}", ""]
    lines += cfg_lines + [
        f"pub(super) fn {test}() -> Result<Verdict, String> {{",
        f"    unsafe {{ {impl_name}() }}",
        "}",
    ]
    return "\n".join(lines)


def gen_fn(sig: dict, arch: str, ext: str, expected_values: dict[str, str] | None = None) -> str:
    test = test_name(sig["name"], arch, ext)
    expected = (expected_values or {}).get(test)
    return emit_test_fn(arch_only_cfg_line(sig), test, gen_fn_body(sig, expected, arch=arch, ext=ext),
                        target_feature_attr(arch, ext, ext_to_feature(ext)))


# Vector types with a WIDTH_AWARE_VEC_INFO entry (any element type) — used to find the
# value-axis-eligible parameters of a pilot-scope function.
_WIDTHED_VEC_TYPES = {"__m128i", "__m256i", "__m512i", "__m128", "__m256", "__m512", "__m128d", "__m256d", "__m512d"} | NEON_VEC_TYPES


def _value_params(sig: dict) -> list[tuple[int, str, str]]:
    """(index, name, type) of non-pointer/non-reference parameters, in declaration order."""
    params = sig["params"] or []
    return [(i, pname, ptype.strip()) for i, (pname, ptype) in enumerate(params)
            if "*" not in ptype and not ptype.strip().startswith("&")]


def sig_elem_type(sig: dict) -> str:
    """The per-lane element type used consistently across EVERY scenario (including
    normal1) of a pilot-scope function — detected from its first vector value-parameter,
    or its return type for functions that take no vector param (e.g. pure predicates)."""
    widthed = [(i, pname, ptype) for i, pname, ptype in _value_params(sig) if ptype in _WIDTHED_VEC_TYPES]
    if widthed:
        return detect_elem_type(sig["name"], widthed[0][2])
    ret = (sig["return_type"] or "()").strip()
    if ret in _VEC_TYPE_DEFAULT_ELEM:
        return detect_elem_type(sig["name"], ret)
    return "i32"


def sig_lane_count(sig: dict, elem: str) -> int | None:
    """Lane count of the vector a lane-index const generic indexes: the first vector-typed
    parameter's, or the return type's for the `vget_lane`-style ones that take a vector and
    return a scalar. None when nothing in the signature is a vector this generator sizes."""
    for _i, _pname, ptype in _value_params(sig):
        entry = WIDTH_AWARE_VEC_INFO.get((ptype, elem)) or WIDTH_AWARE_VEC_INFO.get((ptype, _NEON_ELEM_BY_TYPE.get(ptype, "")))
        if entry is not None:
            return entry[3]
    ret = (sig["return_type"] or "()").strip()
    entry = WIDTH_AWARE_VEC_INFO.get((ret, elem))
    return entry[3] if entry is not None else None


def _build_value_scenarios(sig: dict, arch: str | None = None) -> list[tuple[str, dict[str, str]]]:
    """(suffix, param_overrides) pairs for the value axis: 2 extra 'normal' scenarios,
    5 uniform/mixed boundary scenarios, and (for 2+ value params) 2 asymmetric MIN/MAX
    pairs between the first two value params. 'normal1' itself is the no-override base
    scenario and is not produced here."""
    widthed = [(i, pname, ptype) for i, pname, ptype in _value_params(sig) if ptype in _WIDTHED_VEC_TYPES]
    if not widthed:
        return []

    elem = sig_elem_type(sig)
    # sig_elem_type detects elem from the function *name* (e.g. a "_pd" suffix means
    # f64), which can disagree with a widthed param's actual register type when that
    # param isn't really a value to vary - a mask argument like `_mm_maskload_pd`'s
    # `mask: __m128i` next to an f64-suffixed name, for instance. Drop any param whose
    # (ptype, elem) pair WIDTH_AWARE_VEC_INFO has no entry for, rather than KeyError.
    widthed = [w for w in widthed if (w[2], elem) in WIDTH_AWARE_VEC_INFO]
    if not widthed:
        return []

    scenarios: list[tuple[str, dict[str, str]]] = []

    def overrides_for(lane_fn) -> dict[str, str]:
        ov = {}
        for pos, (_idx, pname, ptype) in enumerate(widthed):
            creator, container, _unpacker, lanes = WIDTH_AWARE_VEC_INFO[(ptype, elem)]
            ov[pname] = f"{creator}([{', '.join(lane_fn(pos, lanes, container))}])"
        return ov

    scenarios.append(("normal2", overrides_for(lambda pos, lanes, container: normal_lane_values(elem, container, lanes, "normal2", pos * 10))))
    scenarios.append(("normal3", overrides_for(lambda pos, lanes, container: normal_lane_values(elem, container, lanes, "normal3", pos * 10))))
    for kind, suffix in (("min", "boundary_min"), ("max", "boundary_max"), ("zero", "boundary_zero"),
                         ("allones", "boundary_allones"), ("mixed", "boundary_mixed")):
        scenarios.append((suffix, overrides_for(lambda pos, lanes, container, kind=kind: boundary_lane_values(elem, container, lanes, kind, arch))))

    if len(widthed) >= 2:
        _idx0, pname0, ptype0 = widthed[0]
        _idx1, pname1, ptype1 = widthed[1]
        creator0, container0, _u0, lanes0 = WIDTH_AWARE_VEC_INFO[(ptype0, elem)]
        creator1, container1, _u1, lanes1 = WIDTH_AWARE_VEC_INFO[(ptype1, elem)]
        for suffix, (kind0, kind1) in (("asym_min_max", ("min", "max")), ("asym_max_min", ("max", "min"))):
            ov = {
                pname0: f"{creator0}([{', '.join(boundary_lane_values(elem, container0, lanes0, kind0, arch))}])",
                pname1: f"{creator1}([{', '.join(boundary_lane_values(elem, container1, lanes1, kind1, arch))}])",
            }
            scenarios.append((suffix, ov))
    return scenarios


# Where the immediate axis applies. Independent of `in_pilot_scope` (the *value* axis): varying
# a const generic does not touch how values are built, so SVE gets it despite its completely
# different broadcast-and-extract value model. Limited to the architectures whose expected
# values can actually be captured here (real hardware or qemu-user) - an architecture with no
# way to capture would only gain tests that report Verdict::Unverified forever.
IMMEDIATE_AXIS_ARCHS = {"x86", "x86_64", "arm", "arm_shared", "aarch64"}


def immediate_axis_applies(arch: str, func_name: str) -> bool:
    # gather/scatter are excluded for the same reason as on the value axis, one step removed:
    # their immediate is the SCALE multiplying a per-lane index into a base pointer, so varying
    # it walks off the buffer.
    lowered = func_name.lower()
    return arch in IMMEDIATE_AXIS_ARCHS and "gather" not in lowered and "scatter" not in lowered


_SCALAR_BITS = {"i8": 8, "u8": 8, "p8": 8, "i16": 16, "u16": 16, "p16": 16,
                "i32": 32, "u32": 32, "f32": 32, "i64": 64, "u64": 64, "p64": 64, "f64": 64}


def scalar_immediate_bound(sig: dict, arch: str) -> int | None:
    """Width of the scalar a NEON `_n_` intrinsic operates on, when that is all it operates
    on - the real ceiling for its shift or fixed-point-bits immediate.

    Only the scalar forms need this. A vector one states its lane width in its own parameter
    type (`int32x2_t`), which `sig_elem_type` already reads; `vcvts_n_f32_s32(a: i32)` states
    nothing a lane table can see, so nothing capped its immediate against the operand."""
    if arch not in ("arm", "arm_shared", "aarch64"):
        return None
    name = sig["name"]
    if "_n_" not in name and not name.endswith("_n"):
        return None
    params = [ptype for _i, _pname, ptype in _value_params(sig)]
    if any(p in NEON_VEC_TYPES for p in params):
        return None
    for ptype in params:
        bits = _SCALAR_BITS.get(ptype)
        if bits is not None:
            return bits
    return _SCALAR_BITS.get((sig["return_type"] or "").strip())


def _build_immediate_scenarios(sig: dict, arch: str) -> list[tuple[str, str]]:
    """(suffix, literal) pairs for the immediate axis. Runtime values stay at 'normal1'
    (empty param_overrides) here — this axis is additive with the value axis, not a
    cartesian product with it (see expand_scenarios)."""
    cg: list = sig["const_generics"]
    if not immediate_axis_applies(arch, sig["name"]) or len(cg) != 1:
        # A function with several immediates would need the axis to be a product over them,
        # and one with none has no axis at all; both keep their single pinned scenario.
        return []
    cg_name, cg_type = cg[0]
    constraint = sig.get("const_ranges", {}).get(cg_name)
    if constraint is None or cg_type == "svpattern":
        # Nothing states this immediate's valid range (or it is an enum, not an integer), so
        # there is no value here that is safe to vary to.
        return []
    base = const_val(cg_name, sig["name"], cg_type, constraint)
    elem = sig_elem_type(sig)
    return immediate_catalog(constraint, elem, sig_lane_count(sig, elem), base,
                             scalar_immediate_bound(sig, arch))


def expand_scenarios(sig: dict, arch: str, ext: str) -> list[tuple[str, dict[str, str], str | None]]:
    """All scenarios for one signature as (suffix, param_overrides, cg_override). 'normal1'
    (suffix='', no overrides) is always first, so it renders under exactly today's function
    name - a function in neither axis's scope therefore renders exactly as it always did.

    The two axes are gated separately: the value axis needs a per-lane array model
    (`in_pilot_scope`), the immediate one only needs a known valid range."""
    scenarios: list[tuple[str, dict[str, str], str | None]] = [("", {}, None)]
    if in_pilot_scope(arch, ext, sig["name"]):
        for suffix, overrides in _build_value_scenarios(sig, arch):
            scenarios.append((suffix, overrides, None))
    for suffix, literal in _build_immediate_scenarios(sig, arch):
        scenarios.append((suffix, {}, literal))
    return scenarios


# ---------------------------------------------------------------------------
# Property tests: checks whose expected value comes from the instruction set itself
#
# Every other test here compares against a value captured on real hardware, which makes the
# machine under test its own oracle: 45897 of the x86 expectations in data/cpu/expected/ were
# taken on this project's one Ryzen 9 7900, so a result that is wrong *there* was recorded as
# correct. These compare an intrinsic against a different intrinsic on the same chip instead,
# using a relation the instruction set defines:
#
#   vs_unmasked  - `_mm512_mask_add_epi32(src, k, a, b)` is `_mm512_add_epi32(a, b)` blended
#                  over `src` by `k`, lane by lane (`_maskz_` blends over zero).
#   vs_unmasked  - a masked compare returning a mask is `k1 & <the unmasked compare>`.
#   vs_narrow    - the low half of a 256/512-bit lanewise op is the same op at half the width.
#   prop_*       - algebraic identities: commutativity, `xor(a,a) == 0`, `and(a,a) == a`,
#                  `add(a, 0) == a`.
#
# What this buys beyond more tests: **no captured value is involved**, so these are real
# checks the first time the binary runs on a machine nobody has ever captured on - a new
# board goes from "7000 Unverified" to "7000 Unverified plus 3000 genuine comparisons". They
# also target exactly the divergences an emulator or a part with AVX-512 fused off gets
# wrong. What it does not buy: both sides run on the same silicon, so a bug that affects the
# masked and unmasked form identically passes. These complement captured values, not replace
# them.
#
# x86/x86_64 only for now - the shapes (`__mmaskN`, `_mm256_`/`_mm512_` prefixes) are x86's.
# ---------------------------------------------------------------------------

PROPERTY_SUFFIXES = ("vs_unmasked", "vs_narrow", "prop_commutative", "prop_self_zero",
                     "prop_idempotent", "prop_identity")

_MASK_TYPE_RE = re.compile(r"^__mmask(\d+)$")

# Wide vector type -> the type one register width down.
_NARROWER_VEC = {
    "__m512i": "__m256i", "__m256i": "__m128i",
    "__m512": "__m256", "__m256": "__m128",
    "__m512d": "__m256d", "__m256d": "__m128d",
}

# Families whose 256/512-bit form is defined lane-by-lane (or per 128-bit lane), so its low
# half must equal the same operation one width down. Anything that moves data across 128-bit
# lanes - permute, broadcast, insert/extract, width-changing converts - is deliberately absent:
# for those the relation is simply false, and an automatic rule cannot tell the two apart.
_LANEWISE_FAMILY_RE = re.compile(
    r"_(add|adds|sub|subs|mul|mullo|mulhi|mulhrs|madd|maddubs|and|andnot|or|xor|min|max|abs|avg"
    r"|sqrt|rcp|rsqrt|sign|cmpeq|cmpgt|cmplt|unpacklo|unpackhi|packs|packus|alignr|hadd|hsub"
    r"|hadds|hsubs|sad|blend|fmadd|fmsub|fnmadd|fnmsub|fmaddsub|fmsubadd|addsub"
    r"|slli|srli|srai|sll|srl|sra|sllv|srlv|srav)_")

# Two-operand lanewise op -> the identities that hold for it. Float min/max are commutative
# only because every input built here is an ordinary positive value: on x86 they return the
# second operand for a NaN or a signed-zero tie, which a boundary scenario would hit.
_ALGEBRAIC_PROPERTIES: dict[str, tuple[str, ...]] = {
    "add": ("prop_commutative", "prop_identity"),
    "adds": ("prop_commutative",),
    "avg": ("prop_commutative",),
    "mullo": ("prop_commutative",),
    "and": ("prop_commutative", "prop_idempotent"),
    "or": ("prop_commutative", "prop_idempotent", "prop_identity"),
    "xor": ("prop_commutative", "prop_self_zero"),
    "min": ("prop_commutative", "prop_idempotent"),
    "max": ("prop_commutative", "prop_idempotent"),
    "sub": ("prop_self_zero",),
    "andnot": ("prop_self_zero",),
}
_ALGEBRAIC_NAME_RE = re.compile(r"_(" + "|".join(_ALGEBRAIC_PROPERTIES) + r")_")


class Property(NamedTuple):
    """One generated property test: what to call it, its body, and the extra CPU feature it
    needs because the intrinsic it compares against belongs to another extension."""
    suffix: str
    lines: list[str]
    extra_feature: str | None


def is_property_test(name: str) -> bool:
    """A property test asserts a relation, never a captured constant - so a value recorded for
    one (by a capture run scraping a failure line) is meaningless and must not reach
    data/cpu/expected/."""
    return any(name.endswith("_" + s) for s in PROPERTY_SUFFIXES)


def _param_types(sig: dict) -> list[str]:
    return [ptype.strip() for _pname, ptype in (sig["params"] or [])]


def _lane_view(vec_type: str, elem: str) -> tuple[str, str, str, int] | None:
    return WIDTH_AWARE_VEC_INFO.get((vec_type, elem))


def _unpacked_elem(unpacker: str) -> str:
    """The element type an `unpack_*_to_<elem>_array` helper hands back.

    Not the same as the view's `container`, which is what its *creator* takes: the unsigned
    64-bit views build through `create__m512i_from([i64; 8])` and read back `[u64; 8]`, so a
    comparison written against `container` there is a type error."""
    m = re.search(r"_to_(\w+)_array$", unpacker)
    return m.group(1) if m else "i32"


def _mask_lane_view(sig: dict, ret: str, mask_bits: int) -> tuple[str, tuple[str, str, str, int]] | None:
    """The per-lane view of `ret` whose lane count the mask can address.

    An AVX-512 mask is never narrower than 8 bits, so a 2-lane `__m128d` masked by a
    `__mmask8` is normal and the top 6 bits are simply ignored. The other direction is a
    mis-detected element type - 16 i32 lanes against a `__mmask8` means the intrinsic really
    works on 64-bit lanes - and there the mask width is the more reliable of the two.

    Which leaves the genuinely ambiguous case: a `__mmask8` says only "at most 8 lanes", so
    the lane count has to come from the name, and `sig_elem_type` *defaults* to i32 when the
    name does not state one. `_mm256_broadcast_i64x2` names its lane group rather than its
    lane, and blending it as 8 i32 lanes instead of 4 i64 ones is a failure this test would
    report against a perfectly good CPU. A wider mask is exact, so only this case needs the
    name to have said something."""
    if mask_bits <= 8 and not any(re.search(pat, sig["name"]) for pat, _elem in ELEM_SUFFIX_MAP):
        return None
    elem = sig_elem_type(sig)
    entry = _lane_view(ret, elem)
    if entry is not None and entry[3] <= mask_bits:
        return elem, entry
    wanted_float = elem in ("f32", "f64")
    candidates = [(e, v) for (r, e), v in WIDTH_AWARE_VEC_INFO.items() if r == ret and v[3] == mask_bits]
    for e, v in candidates:
        if (e in ("f32", "f64")) == wanted_float:
            return e, v
    return candidates[0] if candidates else None


# An `_ss`/`_sd`/`_sh` intrinsic computes on element 0 only and copies the rest of the vector
# from its *first operand* - so `add_ss(a, b)` and `add_ss(b, a)` differ above lane 0, and a
# masked scalar form leaves the upper lanes as `a` had them rather than as `src` had them.
# Every relation below is about whole-vector behaviour and none of them hold for these.
_SCALAR_FORM_RE = re.compile(r"_(ss|sd|sh)$")

# Operations whose result lanes are not the width their name says: the mask addresses the
# *result*, and a name-derived lane count is simply wrong for them. `_mm_mul_epi32` reads four
# 32-bit lanes and writes two 64-bit ones, `madd` adds pairs, `packs`/`packus` halve the width,
# and every `cvt` is a conversion. `mullo`/`mulhi` keep their width and are not in this.
_WIDTH_CHANGING_RE = re.compile(r"cvt|_(madd|maddubs|packs|packus|sad|dpbusds?|dpwssds?)_"
                                r"|_mul_ep[iu]32\b")


def _same_const_suffix(sig: dict, other: dict) -> str | None:
    """The const-generic suffix to give *both* calls, or None when they cannot share one.

    Each function's own literal comes from its own asserted range, and the two need not agree -
    `_mm512_mask_alignr_epi8` was being compared against `_mm512_alignr_epi8::<1>` while
    itself passing `::<0>`, which is not a property failing but two different operations."""
    cg = sig["const_generics"]
    if not cg:
        return ""
    ranges, other_ranges = sig.get("const_ranges") or {}, other.get("const_ranges") or {}
    values = []
    for (cname, ctype), (other_name, _t) in zip(cg, other["const_generics"]):
        value = const_val(cname, sig["name"], ctype, ranges.get(cname))
        other_constraint = other_ranges.get(other_name)
        if other_constraint is not None:
            if not value.lstrip("-").isdigit() or not _in_ranges(int(value), other_constraint.ranges):
                return None
        elif value != const_val(other_name, other["name"], ctype, None):
            return None
        values.append(value)
    return f"::<{', '.join(values)}>"


def _sibling(arch: str, ext: str, name: str) -> tuple[dict, str | None] | None:
    """(sig, extra feature) for a function this one is compared against, or None if it is not
    generated here. The feature is None when it lives in the same extension, and otherwise the
    one the generated test has to enable and check on top of its own."""
    sig = FUNCTIONS_BY_ARCH.get(arch, {}).get(name)
    if sig is None or sig["name"] in POLICY.excluded or not sig["is_complete"]:
        return None
    other_ext = EXT_OF_FUNCTION.get((arch, name))
    if other_ext is None or other_ext == ext:
        return sig, None
    feature = ext_to_feature(other_ext)
    if feature in UNSUPPORTED_FEATURES or feature not in DETECTABLE_FEATURES.get("x86", set()):
        return None
    return sig, feature


# A `__m512i` viewed as 8-bit lanes is 64 of them, and a three-operand intrinsic would run the
# ascending sequence to 192 - past `i8::MAX`, which is a build error rather than a bad test.
# Wrapping keeps every literal in range while staying a pure function of the lane index, which
# is what makes the narrow call of a cross-width check see the wide call's own low lanes.
_SEQ_WRAP = {"i8": 100, "u8": 100}


def _seq_lanes(count: int, container: str, start: int) -> list[str]:
    """`count` ascending literals of `container`, so the wide and narrow calls of a cross-width
    check are handed the *same* leading values."""
    wrap = _SEQ_WRAP.get(container)
    values = [1 + (start - 1 + i) % wrap if wrap else start + i for i in range(count)]
    if container in ("f32", "f64"):
        return [f"{v}.0{container}" for v in values]
    return [f"{v}{container}" for v in values]


def _compare_lines(call_desc: str, got: str, want: str, is_float: bool) -> list[str]:
    fn = "check_float_array_equality" if is_float else "check_array_equality"
    return ["        " + _checked(f"{fn}(&{got}, &{want})", call_desc)]


def _mask_property(sig: dict, arch: str, ext: str) -> Property | None:
    """`_mask_`/`_maskz_` form vs its unmasked sibling, blended by the mask."""
    name = sig["name"]
    tag = "_mask_" if "_mask_" in name else "_maskz_" if "_maskz_" in name else None
    if tag is None:
        return None
    found = _sibling(arch, ext, name.replace(tag, "_", 1))
    if found is None:
        return None
    plain, extra_feature = found
    ret = (sig["return_type"] or "").strip()
    if ret != (plain["return_type"] or "").strip() or ret not in _VEC_TYPE_DEFAULT_ELEM:
        return None
    mp, pp = _param_types(sig), _param_types(plain)
    offset = 2 if tag == "_mask_" else 1
    if len(mp) != len(pp) + offset or mp[offset:] != pp:
        return None
    if tag == "_mask_" and mp[0] != ret:
        return None
    m = _MASK_TYPE_RE.match(mp[offset - 1])
    if not m or len(sig["const_generics"]) != len(plain["const_generics"]):
        return None
    if _WIDTH_CHANGING_RE.search(name):
        return None
    view = _mask_lane_view(sig, ret, int(m.group(1)))
    if view is None:
        return None
    cs = _same_const_suffix(sig, plain)
    if cs is None:
        return None
    elem, (_creator, _container, unpacker, lanes) = view
    lane_type = _unpacked_elem(unpacker)

    names = [pname for pname, _ in sig["params"]]
    ctr = [1]
    lines = ["    unsafe {"]
    # Tail arguments first, so both calls are handed identical values.
    for pname, ptype in list(zip(names, mp))[offset:]:
        lines.append(f"        let {pname} = {seq_init(ptype, ctr)};")
    if tag == "_mask_":
        lines.append(f"        let {names[0]} = {seq_init(ret, ctr)};")
    mask_name = names[offset - 1]
    lines.append(f"        let {mask_name} = {FIXED_INITS[mp[offset - 1]]};")

    masked_call = f"{name}{cs}({', '.join(names)})"
    plain_call = f"{plain['name']}{cs}({', '.join(names[offset:])})"
    lines.append(f"        let masked = {unpacker}({masked_call});")
    lines.append(f"        let plain = {unpacker}({plain_call});")
    if tag == "_mask_":
        lines.append(f"        let src_lanes = {unpacker}({names[0]});")
        fallback = "src_lanes[i]"
    else:
        fallback = _typed_lit(lane_type, "zero")
    lines.append(f"        let expected: [{lane_type}; {lanes}] = core::array::from_fn(|i| "
                 f"if ({mask_name} >> i) & 1 == 1 {{ plain[i] }} else {{ {fallback} }});")
    lines += _compare_lines(f"{masked_call} vs {plain_call}", "masked", "expected",
                            elem in ("f32", "f64"))
    lines.append("        Ok(Verdict::Checked)")
    lines.append("    }")
    return Property("vs_unmasked", lines, extra_feature)


def _mask_compare_property(sig: dict, arch: str, ext: str) -> Property | None:
    """A masked compare returns `k1 & <the unmasked compare>` - the mask argument only ever
    removes lanes from the answer, it never adds one."""
    name = sig["name"]
    if "_mask_" not in name:
        return None
    ret = (sig["return_type"] or "").strip()
    if not _MASK_TYPE_RE.match(ret):
        return None
    found = _sibling(arch, ext, name.replace("_mask_", "_", 1))
    if found is None:
        return None
    plain, extra_feature = found
    if (plain["return_type"] or "").strip() != ret:
        return None
    mp, pp = _param_types(sig), _param_types(plain)
    if len(mp) != len(pp) + 1 or mp[1:] != pp or not _MASK_TYPE_RE.match(mp[0]):
        return None
    if len(sig["const_generics"]) != len(plain["const_generics"]):
        return None
    cs = _same_const_suffix(sig, plain)
    if cs is None:
        return None

    names = [pname for pname, _ in sig["params"]]
    ctr = [1]
    lines = ["    unsafe {"]
    for pname, ptype in list(zip(names, mp))[1:]:
        lines.append(f"        let {pname} = {seq_init(ptype, ctr)};")
    lines.append(f"        let {names[0]} = {FIXED_INITS[mp[0]]};")
    masked_call = f"{name}{cs}({', '.join(names)})"
    plain_call = f"{plain['name']}{cs}({', '.join(names[1:])})"
    lines.append(f"        let masked = {masked_call};")
    lines.append(f"        let plain = {plain_call};")
    lines.append("        " + _checked(f"check_int_equality(masked, {names[0]} & plain)",
                                       f"{masked_call} vs {plain_call}"))
    lines.append("        Ok(Verdict::Checked)")
    lines.append("    }")
    return Property("vs_unmasked", lines, extra_feature)


def _narrow_property(sig: dict, arch: str, ext: str) -> Property | None:
    """The low half of a lanewise 256/512-bit op against the same op one width down."""
    name = sig["name"]
    m = re.match(r"^_mm(512|256)_(.+)$", name)
    if not m or "_mask" in name or not _LANEWISE_FAMILY_RE.search(name):
        return None
    ret = (sig["return_type"] or "").strip()
    narrow_ret = _NARROWER_VEC.get(ret)
    if narrow_ret is None:
        return None
    pts = _param_types(sig)
    if not pts or any(p != ret for p in pts):
        return None
    found = _sibling(arch, ext, ("_mm256_" if m.group(1) == "512" else "_mm_") + m.group(2))
    if found is None:
        return None
    narrow, extra_feature = found
    npts = _param_types(narrow)
    if (narrow["return_type"] or "").strip() != narrow_ret or len(npts) != len(pts):
        return None
    if any(p != narrow_ret for p in npts) or len(sig["const_generics"]) != len(narrow["const_generics"]):
        return None
    cs = _same_const_suffix(sig, narrow)
    if cs is None:
        return None

    elem = sig_elem_type(sig)
    wide_view, narrow_view = _lane_view(ret, elem), _lane_view(narrow_ret, elem)
    if wide_view is None or narrow_view is None:
        return None
    w_creator, w_container, w_unpack, w_lanes = wide_view
    n_creator, n_container, n_unpack, n_lanes = narrow_view
    if _unpacked_elem(w_unpack) != _unpacked_elem(n_unpack):
        return None

    lines = ["    unsafe {"]
    wide_args, narrow_args = [], []
    for i, (pname, _ptype) in enumerate(sig["params"]):
        # The two views can disagree on the type their *creator* takes (`__m256i`'s u8 view
        # builds from [u8; 32], `__m128i`'s from [i8; 16]), so each gets its own literals over
        # the same numbers - which is what makes the narrow call see the wide call's low lanes.
        start = 1 + i * w_lanes
        wide_lanes = _seq_lanes(w_lanes, w_container, start)
        narrow_lanes = _seq_lanes(n_lanes, n_container, start)
        lines.append(f"        let {pname}_wide = {w_creator}([{', '.join(wide_lanes)}]);")
        lines.append(f"        let {pname}_narrow = {n_creator}([{', '.join(narrow_lanes)}]);")
        wide_args.append(f"{pname}_wide")
        narrow_args.append(f"{pname}_narrow")
    wide_call = f"{name}{cs}({', '.join(wide_args)})"
    narrow_call = f"{narrow['name']}{cs}({', '.join(narrow_args)})"
    lines.append(f"        let wide = {w_unpack}({wide_call});")
    lines.append(f"        let narrow = {n_unpack}({narrow_call});")
    lines += _compare_lines(f"{wide_call} vs {narrow_call}", f"wide[..{n_lanes}]", "narrow",
                            elem in ("f32", "f64"))
    lines.append("        Ok(Verdict::Checked)")
    lines.append("    }")
    return Property("vs_narrow", lines, extra_feature)


def _algebraic_properties(sig: dict, arch: str, ext: str) -> list[Property]:
    """Identities that hold for a two-operand lanewise op whatever the machine."""
    name = sig["name"]
    if "_mask" in name:
        return []
    m = _ALGEBRAIC_NAME_RE.search(name)
    ret = (sig["return_type"] or "").strip()
    pts = _param_types(sig)
    if not m or ret not in _VEC_TYPE_DEFAULT_ELEM or len(pts) != 2 or any(p != ret for p in pts):
        return []
    if sig["const_generics"]:
        return []
    elem = sig_elem_type(sig)
    view = _lane_view(ret, elem)
    if view is None:
        return []
    creator, container, unpack, lanes = view
    is_float = elem in ("f32", "f64")
    a_lanes = ", ".join(_seq_lanes(lanes, container, 1))
    b_lanes = ", ".join(_seq_lanes(lanes, container, 1 + lanes))
    zero = ", ".join([_typed_lit(container, "zero")] * lanes)

    def build(suffix: str, setup: list[str], call_a: str, call_b: str) -> Property:
        lines = ["    unsafe {"] + [f"        {s}" for s in setup]
        lines.append(f"        let lhs = {unpack}({call_a});")
        lines.append(f"        let rhs = {unpack}({call_b});")
        lines += _compare_lines(f"{call_a} vs {call_b}", "lhs", "rhs", is_float)
        lines += ["        Ok(Verdict::Checked)", "    }"]
        return Property(suffix, lines, None)

    out = []
    for prop in _ALGEBRAIC_PROPERTIES[m.group(1)]:
        setup = [f"let a = {creator}([{a_lanes}]);"]
        if prop == "prop_commutative":
            setup.append(f"let b = {creator}([{b_lanes}]);")
            out.append(build(prop, setup, f"{name}(a, b)", f"{name}(b, a)"))
        elif prop == "prop_idempotent":
            # f(a, a) == a: compared through the same unpack, so `a` needs no second form.
            lines = ["    unsafe {"] + [f"        {s}" for s in setup]
            lines.append(f"        let lhs = {unpack}({name}(a, a));")
            lines.append(f"        let rhs = {unpack}(a);")
            lines += _compare_lines(f"{name}(a, a) vs a", "lhs", "rhs", is_float)
            lines += ["        Ok(Verdict::Checked)", "    }"]
            out.append(Property(prop, lines, None))
        elif prop == "prop_self_zero":
            setup.append(f"let zero = {creator}([{zero}]);")
            out.append(build(prop, setup, f"{name}(a, a)", "zero"))
        elif prop == "prop_identity":
            setup.append(f"let zero = {creator}([{zero}]);")
            lines = ["    unsafe {"] + [f"        {s}" for s in setup]
            lines.append(f"        let lhs = {unpack}({name}(a, zero));")
            lines.append(f"        let rhs = {unpack}(a);")
            lines += _compare_lines(f"{name}(a, zero) vs a", "lhs", "rhs", is_float)
            lines += ["        Ok(Verdict::Checked)", "    }"]
            out.append(Property(prop, lines, None))
    return out


def property_tests(sig: dict, arch: str, ext: str) -> list[Property]:
    """Every property test for one signature. x86 only, and never for a function with a
    pointer parameter - those build buffers rather than values."""
    if arch not in ("x86", "x86_64") or has_ptr(sig["params"]) or not sig["is_complete"]:
        return []
    if _SCALAR_FORM_RE.search(sig["name"]):
        return []
    if has_unstable_type(sig["params"], sig["return_type"] or "()"):
        return []
    out = [p for p in (_mask_property(sig, arch, ext),
                       _mask_compare_property(sig, arch, ext),
                       _narrow_property(sig, arch, ext)) if p is not None]
    return out + _algebraic_properties(sig, arch, ext)


def list_scenario_names(sig: dict, arch: str, ext: str) -> list[str]:
    base = test_name(sig["name"], arch, ext)
    names = [base + (f"_{suffix}" if suffix else "") for suffix, _, _ in expand_scenarios(sig, arch, ext)]
    return names + [f"{base}_{p.suffix}" for p in property_tests(sig, arch, ext)]


def gen_scenarios(sig: dict, arch: str, ext: str, expected_values: dict[str, str] | None = None) -> str:
    """Source for every scenario function of one base signature, joined the same way multiple
    gen_fn() outputs are joined by gen_part. With neither axis in scope this emits exactly one
    function, byte-identical to gen_fn's - the width-aware return unpack belongs to the value
    axis, so a function that only has immediate scenarios keeps the generic view its captured
    values were taken under."""
    base = test_name(sig["name"], arch, ext)
    elem = sig_elem_type(sig) if in_pilot_scope(arch, ext, sig["name"]) else None
    own_feature = ext_to_feature(ext)
    tf_attr = target_feature_attr(arch, ext, own_feature)
    bodies = []
    for suffix, overrides, cg_override in expand_scenarios(sig, arch, ext):
        tname = base + (f"_{suffix}" if suffix else "")
        expected = (expected_values or {}).get(tname)
        body = gen_fn_body(sig, expected, overrides or None, cg_override, elem, arch=arch, ext=ext)
        bodies.append(emit_test_fn(arch_only_cfg_line(sig), tname, body, tf_attr))
    for prop in property_tests(sig, arch, ext):
        bodies.append(emit_test_fn(arch_only_cfg_line(sig), f"{base}_{prop.suffix}",
                                   property_body(prop, arch, own_feature),
                                   property_target_feature(arch, ext, own_feature, prop)))
    return "\n\n".join(bodies)


def property_target_feature(arch: str, ext: str, own_feature: str, prop: Property) -> str | None:
    """A property test calls two intrinsics, and the second can belong to another extension
    (`_mm256_add_epi32` is AVX2, `_mm_add_epi32` is SSE2), so the wrapper has to enable both
    or the call does not compile."""
    attr = target_feature_attr(arch, ext, own_feature)
    if prop.extra_feature is None or attr is None:
        return attr
    enabled = attr.split('"')[1]
    if prop.extra_feature in enabled.split(","):
        return attr
    return f'#[target_feature(enable = "{enabled},{prop.extra_feature}")]'


def property_body(prop: Property, arch: str, own_feature: str) -> list[str]:
    """`extra_feature` is enabled at compile time by the attribute above, so it also needs the
    runtime gate the group check does not provide - the same shape as
    `extra_feature_guard_lines`, and the same failure without it: a CPU with AVX-512 but no
    AVX2 would execute an instruction it does not have."""
    if prop.extra_feature is None or prop.extra_feature == own_feature:
        return prop.lines
    guard = [
        f"        if !({get_feature_detect_fn(arch, prop.extra_feature)}) {{",
        f'            return Ok(Verdict::Skipped("{prop.extra_feature} not present"));',
        "        }",
    ]
    return guard + prop.lines


def get_arch_import(arch: str) -> str:
    """Return the appropriate arch import for the given architecture.

    For x86, returns conditional imports that use x86_64 when compiled for x86_64.
    """
    # Special case for x86: use x86_64 intrinsics on x86_64 targets
    if arch == "x86":
        return (
            '#[cfg(target_arch = "x86")]\n'
            'use std::arch::x86::*;\n'
            '#[cfg(target_arch = "x86_64")]\n'
            'use std::arch::x86_64::*;'
        )

    # arm_shared is compiled unconditionally for both arm and aarch64 (see
    # auto_generated/mod.rs's `cfg(any(target_arch = "arm", target_arch = "aarch64"))`) -
    # `std::arch::arm` doesn't exist at all on an aarch64 build and vice versa, so the
    # import itself must be arch-conditional, not just the functions it brings into scope.
    if arch == "arm_shared":
        return (
            '#[cfg(target_arch = "arm")]\n'
            'use std::arch::arm::*;\n'
            '#[cfg(target_arch = "aarch64")]\n'
            'use std::arch::aarch64::*;'
        )

    # Map architecture names to their std::arch module names
    arch_map = {
        "x86_64": "std::arch::x86_64",
        "arm": "std::arch::arm",
        "aarch64": "std::arch::aarch64",
        "riscv32": "std::arch::riscv32",
        "riscv64": "std::arch::riscv64",
        "riscv_shared": "std::arch::riscv64",  # Use riscv64 as fallback
        "loongarch32": "std::arch::loongarch32",
        "loongarch64": "std::arch::loongarch64",
        "loongarch_shared": "std::arch::loongarch64",
        "mips": "std::arch::mips",
        "nvptx": "std::arch::nvptx",
        "powerpc": "std::arch::powerpc",
        "powerpc64": "std::arch::powerpc64",
        "s390x": "std::arch::s390x",
        "wasm32": "std::arch::wasm32",
    }
    module = arch_map.get(arch, f"std::arch::{arch}")
    return f"use {module}::*;"


def get_common_helpers(arch: str) -> list[str]:
    """Return the path(s) to the common helper module(s) for architecture (possibly empty -
    hodow_cpu/src/cpu/common.rs only declares `x86`, cfg-gated to x86/x86_64, `arm`,
    cfg-gated to arm/aarch64, and `sve`, cfg-gated to aarch64 only (SVE has no arm32 form at
    all) - riscv*/mips/powerpc/... have no module to import at all, not even a generic
    fallback one, since these modules are only *present* on a matching build in the first
    place). `aarch64` gets both `arm` (shared NEON helpers) and `sve`."""
    if arch in ("x86", "x86_64"):
        return ["crate::cpu::common::x86"]
    elif arch in ("arm", "arm_shared"):
        return ["crate::cpu::common::arm"]
    elif arch == "aarch64":
        return ["crate::cpu::common::arm", "crate::cpu::common::sve"]
    return []


# Leading name segments that say which register width or masking form an intrinsic is, not
# what it does - dropped when deciding which module a test goes in. An extension's own name
# goes too (`lasx_xvadd_b` in `lasx`, `__msa_add_a_b` in `msa`), or every one of its functions
# would land in a single module named after the extension.
_MODULE_NOISE_SEGMENTS = {"mm", "mm256", "mm512", "mask", "maskz", "mask3", "vec", "v"}

# Module names cannot be raw Rust keywords (`_mm_move_ss` -> `move`).
_RUST_KEYWORDS = {
    "as", "async", "await", "break", "const", "continue", "crate", "do", "dyn", "else", "enum",
    "extern", "false", "final", "fn", "for", "gen", "if", "impl", "in", "let", "loop", "macro",
    "match", "mod", "move", "mut", "override", "priv", "pub", "ref", "return", "self", "static",
    "struct", "super", "trait", "true", "try", "type", "typeof", "union", "unsafe", "unsized",
    "use", "virtual", "where", "while", "yield", "box", "abstract", "become",
}


def module_for(func_name: str, ext: str) -> str:
    """Which module inside `<arch>/<ext>/` a function's tests are written to.

    Derived from the function's own name - `_mm512_mask_add_epi32` and `_mm_add_ps` both go to
    `add.rs` - so a function's file never depends on how many functions were generated before
    it. The `partN.rs` chunking this replaces was purely positional: inserting one intrinsic
    upstream shifted every later function across part boundaries, so a one-function change
    rewrote every part file of that extension and the diff said nothing about what changed.
    Splitting at all is still worth it - x86::AVX512F alone is 37 MB of generated Rust, and
    GitHub starts warning at 50 MB for a single file."""
    s = func_name.lstrip("_")
    while "_" in s:
        head, _, tail = s.partition("_")
        if head in _MODULE_NOISE_SEGMENTS or head == ext:
            s = tail
        else:
            break
    key = s.split("_")[0] or "misc"
    if not re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", key):
        key = f"op_{key}"
    return f"{key}_" if key in _RUST_KEYWORDS else key


def gen_module_header(arch: str) -> list[str]:
    """The imports every generated test module opens with."""
    header = [get_arch_import(arch), ""]
    for helper in get_common_helpers(arch):
        header += ["#[allow(unused_imports)]", f"use {helper}::*;"]
    return header + [
        "#[allow(unused_imports)]",
        "use crate::cpu::common::{check_array_equality, check_float_array_equality, "
        "check_float_equality, check_int_equality};",
        "#[allow(unused_imports)]",
        "use crate::cpu::Verdict;",
        "",
    ]


def gen_part(funcs: list[dict], arch: str, ext: str, expected_values: dict[str, str] | None = None) -> str:
    bodies = [
        gen_scenarios(sig, arch, ext, expected_values)
        for sig in funcs
    ]
    return "\n".join(gen_module_header(arch)) + "\n" + "\n\n".join(bodies) + "\n"


def gen_ext_rs(arch: str, ext: str, funcs: list[dict], modules: list[str],
               inline_bodies: str | None = None) -> str:
    """`<arch>/<ext>.rs`: the registry entry for the extension, over either a list of
    submodules or - when the extension has only one operation family, so a directory holding
    a single file would be pure ceremony - the test bodies themselves."""
    struct = ext_to_struct(ext)
    lines: list[str] = []
    if inline_bodies is not None:
        lines.append(inline_bodies)
    for name in modules:
        if name == ext:
            # `xsave/xsave.rs` is the XSAVE extension's XSAVE-operation module sitting next to
            # its XSAVEC and XGETBV ones - the repetition is what the naming scheme is for.
            lines.append("#[allow(clippy::module_inception)]")
        lines.append(f"mod {name};")
    if modules:
        lines.append("")
        for name in modules:
            lines.append(f"use crate::cpu::auto_generated::{arch}::{ext}::{name}::*;")
    lines += [
        "",
        "use crate::cpu::{ExtensionTest, TestFunction};",
        "",
        # An extension whose name has an underscore (fp_armv8, sve2_aes) upper-cases into
        # something that is not camel case; the name has to keep matching the module.
        "#[allow(non_camel_case_types)]",
        f"pub struct {struct};",
        "",
        f"impl ExtensionTest for {struct} {{",
        "    fn get_name() -> &'static str {",
        f"        \"{arch}::{struct}\"",
        "    }",
        "",
        "    fn get_tests() -> &'static [(TestFunction, &'static str)] {",
        "        &[",
    ]
    for sig in funcs:
        cfg = arch_only_cfg_line(sig)
        for tname in list_scenario_names(sig, arch, ext):
            lines += [f"            {c}" for c in cfg]
            lines.append(f"            ({tname}, \"{tname}\"),")
    lines += ["        ]", "    }", "}"]
    return "\n".join(lines) + "\n"


def get_target_arch_cfg(arch: str) -> str | None:
    """Return the target_arch cfg expression for the given architecture, or None if the
    architecture has no real target_arch to gate on (always compiled)."""
    if arch == "x86":
        # x86 intrinsics work on both x86 and x86_64 (backward compatibility)
        return 'any(target_arch = "x86", target_arch = "x86_64")'
    elif arch == "riscv_shared":
        # riscv_shared works for both riscv32 and riscv64
        return 'any(target_arch = "riscv32", target_arch = "riscv64")'
    elif arch == "loongarch_shared":
        # loongarch_shared works for both 32 and 64 bit variants
        return 'any(target_arch = "loongarch32", target_arch = "loongarch64")'
    elif arch == "arm_shared":
        # arm_shared works for both arm and aarch64
        return 'any(target_arch = "arm", target_arch = "aarch64")'
    elif arch == "nvptx":
        # nvptx is not a standard rust target_arch, so there is nothing to gate on
        return None
    return f"target_arch = \"{arch}\""


def emit_arch_cfg(lines: list[str], arch_cfg: str | None, indent: str = "") -> None:
    """Append either a `#[cfg(...)]` attribute line or, if the architecture has no real
    target_arch (e.g. nvptx), an explanatory comment instead."""
    if arch_cfg is None:
        lines.append(f"{indent}// nvptx is not a standard rust target_arch, so this is always compiled")
    else:
        lines.append(f"{indent}#[cfg({arch_cfg})]")


def gen_mod_rs_for_arch(arch: str, exts: list[tuple[str, str]]) -> str:
    """Generate mod.rs for a single architecture directory.

    Every extension is compiled in unconditionally, on every architecture: each test wrapper
    carries its own `#[target_feature]` (see target_feature_attr), so nothing here depends on
    how the crate as a whole was built, and what actually runs is decided at runtime by
    get_feature_detect_fn."""
    lines = []
    for ext, _feature in exts:
        lines += ext_gate(arch, ext, "")
        lines.append(f"pub mod {ext};")
    return "\n".join(lines)


def gen_root_mod_rs(archs: list[str]) -> str:
    """Generate root mod.rs for auto_generated/ directory."""
    lines = []
    for arch in sorted(archs):
        emit_arch_cfg(lines, get_target_arch_cfg(arch))
        lines.append(f"pub mod {arch};")
        lines.append("")

    # Add registry module
    lines.append("pub mod registry;")
    # ... and the coverage table, which is not gated on any target_arch: it reports on every
    # architecture stdarch has, including the ones this build could never run.
    lines.append("pub mod coverage;")

    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def get_feature_detect_fn(arch: str, feature: str) -> str:
    """Return the runtime feature detection code for the given architecture and feature."""
    # Check if feature is unsupported (no runtime detection available)
    if feature in UNSUPPORTED_FEATURES:
        return "false /* no runtime detection available */"

    if feature in BASELINE_ALWAYS_TRUE_FEATURES:
        return "true /* baseline ISA, not an optional feature - see BASELINE_ALWAYS_TRUE_FEATURES */"

    if arch in ("x86", "x86_64"):
        if feature in ("kl", "widekl"):
            # See keylocker_usable - the macro's cfg!(target_feature) short-circuit makes
            # -C target-cpu=native report Key Locker as present when the OS never enabled it.
            return "crate::cpu::common::x86::keylocker_usable()"
        return f'std::arch::is_x86_feature_detected!("{feature}")'
    if arch == "aarch64":
        # Stable since well before this project's MSRV - no unstable feature gate needed,
        # unlike the MTE/prefetch *intrinsics* themselves (see lib.rs's cfg_attr).
        return f'std::arch::is_aarch64_feature_detected!("{feature}")'
    if arch == "arm":
        # Unstable (stdarch_arm_feature_detection) - see lib.rs's cfg_attr; this is only the
        # detection macro, separate from stdarch_arm_neon_intrinsics/_hints/_sat gating the
        # intrinsics of dsp/hints/sat/simd32 themselves (SKIP_EXTENSIONS, not reached here).
        return f'std::arch::is_arm_feature_detected!("{feature}")'
    if arch == "arm_shared":
        # See gen_arm_shared_detect_helpers - neither detection macro compiles standalone
        # on the "wrong" one of arm/aarch64, so this dispatches to a per-feature helper
        # that's internally cfg-split instead of emitting either macro call directly here.
        return f"{arm_shared_detect_name(feature)}()"
    if arch in ("riscv32", "riscv64", "riscv_shared"):
        # Unstable (stdarch_riscv_feature_detection) - see lib.rs's cfg_attr.
        return f'std::arch::is_riscv_feature_detected!("{feature}")'
    # For other architectures, we'll need to add detection when available
    # For now, return a placeholder that always returns false
    return "false /* feature detection not yet implemented */"


def arm_shared_detect_name(feature: str) -> str:
    """Helper name for `feature` - a target_feature string can contain `-` (`fp-armv8`)."""
    return f"detect_arm_shared_{feature.replace('-', '_')}"


def gen_arm_shared_detect_helpers(all_data: dict[str, dict[str, list[dict]]]) -> list[str]:
    """`arm_shared` is compiled unconditionally for both arm and aarch64 (see
    get_target_arch_cfg) - but `is_arm_feature_detected!`/`is_aarch64_feature_detected!`
    each only compile under their OWN target_arch (a plain `cfg!()` runtime check isn't
    enough, confirmed against rustc directly: the macro itself refuses to expand on the
    "wrong" arch). One small dispatch function per feature, cfg-split internally, lets
    get_feature_detect_fn hand back a single always-valid call for the arm_shared case.

    Covers both the per-group features and any extra one a single function needs on top of its
    group's (extra_feature_guard_lines calls the same dispatch), or that guard would reference
    a helper that was never emitted."""
    features = sorted({
        ext_to_feature(ext)
        for ext, funcs in all_data.get("arm_shared", {}).items()
        if ext not in SKIP_EXTENSIONS and funcs
    } | {
        f
        for ext, funcs in all_data.get("arm_shared", {}).items() if ext not in SKIP_EXTENSIONS
        for sig in funcs
        for f in extra_features("arm_shared", ext, sig)
    })
    lines: list[str] = []
    for feature in features:
        lines += [
            "#[cfg(any(target_arch = \"arm\", target_arch = \"aarch64\"))]",
            f"fn {arm_shared_detect_name(feature)}() -> bool {{",
            "    #[cfg(target_arch = \"arm\")]",
            (f"    {{ return std::arch::is_arm_feature_detected!(\"{feature}\"); }}"
             if feature in DETECTABLE_FEATURES.get("arm", set())
             else f"    {{ return false; /* no is_arm_feature_detected! string for \"{feature}\" */ }}"),
            "    #[cfg(target_arch = \"aarch64\")]",
            (f"    {{ return std::arch::is_aarch64_feature_detected!(\"neon\"); /* plain NEON here; \"{feature}\" is a 32-bit ARM requirement */ }}"
             if feature in NEON_AARCH64_PLAIN_FEATURES
             else f"    {{ return std::arch::is_aarch64_feature_detected!(\"{feature}\"); }}"),
            "}",
            "",
        ]
    return lines


def gen_registry_rs(all_data: dict[str, dict[str, list[dict]]]) -> str:
    """Generate registry.rs with count_available_features, test_all_extensions, and available_modes."""
    lines = [
        "#![allow(unused_imports)]",
        "#![allow(unreachable_code)]",
        "",
        "use crate::cpu::{ExtensionStatus, ExtensionTest, FeatureStats, TestStatistics, ProgressCallback, TestFunction};",
        "use crate::cpu::{reset_stop_flag, should_stop, should_skip_feature};",
        "",
    ]
    lines += gen_arm_shared_detect_helpers(all_data)
    lines += [
        "/// Count how many CPU features/extensions are available on this machine",
        "pub fn count_available_features() -> usize {",
        "    let mut count = 0;",
        "",
    ]

    # Group by architecture
    for arch in sorted(all_data.keys()):
        arch_cfg = get_target_arch_cfg(arch)
        emit_arch_cfg(lines, arch_cfg, "    ")
        lines.append("    {")

        for ext, funcs in sorted(all_data[arch].items()):
            # Skip extensions that shouldn't be generated
            if ext in SKIP_EXTENSIONS:
                continue
            if not funcs:
                continue

            feature = ext_to_feature(ext)
            detect_fn = get_feature_detect_fn(arch, feature)
            lines += ext_gate(arch, ext, "        ")
            lines.append(f"        if {detect_fn} {{")
            lines.append("            count += 1;")
            lines.append("        }")
            lines.append("")

        lines.append("    }")
        lines.append("")

    lines += [
        "    count",
        "}",
        "",
        "/// Get list of available CPU features/extensions on this machine",
        "/// Returns a sorted, deduplicated list with architecture prefixes",
        "pub fn available_modes() -> Vec<String> {",
        "    use std::collections::BTreeSet;",
        "    let mut modes = BTreeSet::new();",
        "",
    ]

    # Generate available_modes
    for arch in sorted(all_data.keys()):
        arch_cfg = get_target_arch_cfg(arch)
        # Simplify arch name for display
        arch_display = arch.replace("_shared", "")
        emit_arch_cfg(lines, arch_cfg, "    ")
        lines.append("    {")

        for ext, funcs in sorted(all_data[arch].items()):
            # Skip extensions that shouldn't be generated
            if ext in SKIP_EXTENSIONS:
                continue
            if not funcs:
                continue

            feature = ext_to_feature(ext)
            detect_fn = get_feature_detect_fn(arch, feature)
            lines += ext_gate(arch, ext, "        ")
            lines.append(f"        if {detect_fn} {{")
            lines.append(f'            modes.insert(format!("{{}}:{{}}", "{arch_display}", "{feature}"));')
            lines.append("        }")

        lines.append("    }")
        lines.append("")

    lines += [
        "    modes.into_iter().collect()",
        "}",
        "",
        "/// Test all available CPU extensions with progress callback",
        "pub fn test_all_extensions(progress_callback: Option<&ProgressCallback>) -> Result<TestStatistics, String> {",
        "    reset_stop_flag();",
        "",
        "    let total_features = count_available_features();",
        "    let mut completed_features = 0;",
        "    let mut features = Vec::new();",
        "",
    ]

    # Generate test_all_extensions
    for arch in sorted(all_data.keys()):
        arch_cfg = get_target_arch_cfg(arch)
        emit_arch_cfg(lines, arch_cfg, "    ")
        lines.append("    {")

        for ext, funcs in sorted(all_data[arch].items()):
            # Skip extensions that shouldn't be generated
            if ext in SKIP_EXTENSIONS:
                continue
            if not funcs:
                continue

            feature = ext_to_feature(ext)
            struct = ext_to_struct(ext)

            detect_fn = get_feature_detect_fn(arch, feature)
            lines += ext_gate(arch, ext, "            ")
            lines.append(f"            if {detect_fn} && !should_skip_feature(\"{ext}\") {{")
            lines.append("                    if should_stop() {")
            lines.append("                        return Ok(TestStatistics { features, was_cancelled: true });")
            lines.append("                    }")
            lines.append(f"                    features.push(crate::cpu::auto_generated::{arch}::{ext}::{struct}::test_with_progress(")
            lines.append("                    total_features,")
            lines.append("                    completed_features,")
            lines.append(f"                    crate::cpu::auto_generated::{arch}::{ext}::{struct}::get_tests().len(),")
            lines.append("                    progress_callback,")
            lines.append("                    )?);")
            lines.append("                    completed_features += 1;")
            lines.append("            }")
            lines.append("")

        lines.append("    }")
        lines.append("")

    lines += [
        "    Ok(TestStatistics {",
        "        features,",
        "        was_cancelled: false,",
        "    })",
        "}",
        "",
        "/// List all available test functions across all extensions",
        "pub fn list_all_functions() -> Vec<String> {",
        "    let mut functions = Vec::new();",
        "",
    ]

    # Generate list_all_functions
    for arch in sorted(all_data.keys()):
        arch_cfg = get_target_arch_cfg(arch)
        emit_arch_cfg(lines, arch_cfg, "    ")
        lines.append("    {")

        for ext, funcs in sorted(all_data[arch].items()):
            # Skip extensions that shouldn't be generated
            if ext in SKIP_EXTENSIONS:
                continue
            if not funcs:
                continue

            feature = ext_to_feature(ext)
            struct = ext_to_struct(ext)

            lines += ext_gate(arch, ext, "        ")
            lines.append("        {")
            lines.append(f"            for (_, name) in crate::cpu::auto_generated::{arch}::{ext}::{struct}::get_tests() {{")
            lines.append("                functions.push(name.to_string());")
            lines.append("            }")
            lines.append("        }")
            lines.append("")

        lines.append("    }")
        lines.append("")

    lines += [
        "    functions",
        "}",
        "",
        "/// Every extension this binary was built with, whether or not this machine has it -",
        "/// the whole suite is always compiled in (see target_feature_attr in the generator),",
        "/// so this is the only place the difference is visible.",
        "pub fn extension_status() -> Vec<ExtensionStatus> {",
        "    #[allow(unused_mut)]",
        "    let mut exts: Vec<ExtensionStatus> = Vec::new();",
        "",
    ]

    for arch in sorted(all_data.keys()):
        emit_arch_cfg(lines, get_target_arch_cfg(arch), "    ")
        lines.append("    {")
        for ext, funcs in sorted(all_data[arch].items()):
            if ext in SKIP_EXTENSIONS or not funcs:
                continue
            struct = ext_to_struct(ext)
            detect_fn = get_feature_detect_fn(arch, ext_to_feature(ext))
            # get_feature_detect_fn falls back to a literal `false` when the extension has no
            # detection string at all - that is "can never run", not "this CPU lacks it".
            detectable = "false" if detect_fn.startswith("false") else "true"
            path = f"crate::cpu::auto_generated::{arch}::{ext}::{struct}"
            lines += ext_gate(arch, ext, "        ")
            lines.append(f"        exts.push(ExtensionStatus {{ arch: \"{arch}\", ext: \"{ext}\",")
            lines.append(f"            test_count: {path}::get_tests().len(),")
            lines.append(f"            supported: {detect_fn}, detectable: {detectable}, compiled_out: false }});")
            if ext_cargo_feature(arch, ext):
                lines.append(f'        #[cfg(not(feature = "{ext_cargo_feature(arch, ext)}"))]')
                lines.append(f"        exts.push(ExtensionStatus {{ arch: \"{arch}\", ext: \"{ext}\",")
                lines.append(f"            test_count: 0, supported: {detect_fn}, detectable: {detectable}, compiled_out: true }});")
        lines.append("    }")
        lines.append("")

    lines += [
        "    exts",
        "}",
        "",
        "/// Flat list of (test_name, feature, test_fn) for every feature detected at runtime",
        "/// on this machine, in the canonical execution order. Used by the isolated subprocess",
        "/// runner (so a crashing/hanging test can be attributed and skipped instead of",
        "/// aborting the run) and by the stress runner. `feature` is the extension name (e.g.",
        "/// \"sse2\", \"avx2\") a caller can filter on without re-detecting it per test.",
        "pub fn all_tests() -> Vec<(&'static str, &'static str, TestFunction)> {",
        "    let mut tests: Vec<(&'static str, &'static str, TestFunction)> = Vec::new();",
        "",
    ]

    for arch in sorted(all_data.keys()):
        arch_cfg = get_target_arch_cfg(arch)
        emit_arch_cfg(lines, arch_cfg, "    ")
        lines.append("    {")

        for ext, funcs in sorted(all_data[arch].items()):
            if ext in SKIP_EXTENSIONS:
                continue
            if not funcs:
                continue

            feature = ext_to_feature(ext)
            struct = ext_to_struct(ext)

            detect_fn = get_feature_detect_fn(arch, feature)
            lines += ext_gate(arch, ext, "        ")
            lines.append(f"        if {detect_fn} {{")
            lines.append(f"            for &(f, n) in crate::cpu::auto_generated::{arch}::{ext}::{struct}::get_tests() {{")
            lines.append(f"                tests.push((n, \"{ext}\", f));")
            lines.append("            }")
            lines.append("        }")
            lines.append("")

        lines.append("    }")
        lines.append("")

    lines += [
        "    tests",
        "}",
    ]

    return "\n".join(lines) + "\n"


# ---------------------------------------------------------------------------
# Why a function does not end up in the binary
#
# Deciding this in one place, as a (reason, detail) pair rather than a boolean filter, is what
# lets `hodow coverage` say "2131 functions use a type with no value helper" instead of
# only "2131 were skipped". The slugs are what the CLI groups by; the details are what a
# `-v` listing prints next to each function name.
# ---------------------------------------------------------------------------

DROP_REASONS: dict[str, str] = {
    "unstable-type": "uses a type with no value helper in common/ (f16/bf16 lanes, multi-register tuples)",
    "incomplete-signature": "signature could not be parsed out of stdarch in full",
    "skipped-extension": "whole extension is not generated (unstable intrinsics or target feature)",
    "deprecated": "deprecated upstream in favour of a non-intrinsic API",
    "x86-incompatible": "x86-only shape that does not compile for x86_64 (differing operand width)",
    "sve-pointer": "SVE load/store: sizing a buffer for a runtime-width vector is not designed yet",
    "sve-gather-scatter": "SVE gather/scatter/prefetch: the address operand is a vector of per-lane pointers",
    "sve-vector-length-dependent": "correct result depends on the hardware vector length, so no captured value can be valid",
}


def drop_reason(sig: dict, arch: str, ext: str) -> tuple[str, str] | None:
    """(reason slug, detail) for a function that will not be generated, or None if it will."""
    name = sig["name"]
    if ext in SKIP_EXTENSIONS:
        return ("skipped-extension", SKIP_EXTENSIONS[ext])
    if name in POLICY.excluded:
        category, reason = POLICY.excluded[name]
        return (f"excluded:{category}", reason)
    if not sig["is_complete"]:
        return ("incomplete-signature", DROP_REASONS["incomplete-signature"])
    if has_unstable_type(sig["params"], sig["return_type"] or "()"):
        types = [pt for _, pt in (sig["params"] or [])] + [sig["return_type"] or "()"]
        offending = next((t for t in types if any(u in t for u in UNSTABLE_TYPES)), "")
        return ("unstable-type", f"{DROP_REASONS['unstable-type']}: {offending}")
    if name in DEPRECATED_FUNCTIONS:
        return ("deprecated", DROP_REASONS["deprecated"])
    if arch == "x86" and name in X86_INCOMPATIBLE_FUNCTIONS:
        return ("x86-incompatible", DROP_REASONS["x86-incompatible"])
    if ext in ("sve", "sve2"):
        if has_ptr(sig["params"]):
            return ("sve-pointer", DROP_REASONS["sve-pointer"])
        # Gather/scatter/prefetch: the "pointer" is a vector of per-lane base addresses
        # (svuint32_t/svuint64_t), not a *const/*mut has_ptr can see - same out-of-bounds
        # hazard as x86 gather/scatter, plus svprfop-typed prefetch-kind const generics this
        # generator has no literal for (name-matched, verified against every real
        # `const OP: svprfop` signature in stdarch).
        if re.search(r"prf|gather|scatter", name):
            return ("sve-gather-scatter", DROP_REASONS["sve-gather-scatter"])
        if SVE_VL_DEPENDENT_RE.match(name):
            return ("sve-vector-length-dependent", DROP_REASONS["sve-vector-length-dependent"])
    return None


def warn_stale_policy_entries(all_sigs: dict[tuple[str, str], list[dict]]) -> None:
    """Every hand-written policy entry that matches no function upstream any more.

    An intrinsic renamed or removed upstream leaves its entry behind, silently doing nothing -
    and a silently dead exclusion is indistinguishable from one still holding a crash back."""
    known = {sig["name"] for funcs in all_sigs.values() for sig in funcs}
    stale = sorted(POLICY.all_named_functions() - known)
    if stale:
        print(f"warning: {len(stale)} entry(ies) in {POLICY_FILE} match no function in "
              f"{SIGNATURES_FILE} and do nothing:", file=sys.stderr)
        for name in stale:
            print(f"  {name}", file=sys.stderr)


def warn_unconstrained_const_generics(stable: list[dict], arch: str, ext: str) -> list[str]:
    """Const generics no `static_assert` upstream pins down, so the generated call falls back
    to 0 and only `cargo build` (not `cargo check` - this fails at const evaluation, i.e. at
    codegen) would say whether that is in range. Worth a warning rather than a surprise."""
    out = []
    for sig in stable:
        ranges = sig.get("const_ranges", {})
        for cg_name, cg_type in sig["const_generics"]:
            if cg_type != "svpattern" and cg_name not in ranges and (sig["name"], cg_name) not in POLICY.const_overrides:
                out.append(f"{arch}::{ext} {sig['name']}<{cg_name}>")
    return out


UNMATCHED_HEADER = """\
# Values whose test no longer exists: the intrinsic is gone from signatures.txt (an older
# stdarch extraction had it) or its test was renamed. Kept, not deleted - generate_tests.py
# reads every .txt under this directory, so if the function ever comes back so does its
# captured value, and `--prune-expected` moves it back into its extension's own file.
"""


def report_orphan_expected(expected_values: dict[str, str], generated_tests: set[str], prune: bool) -> None:
    """File every captured value where it belongs: under its extension if the test exists,
    in `_unmatched.txt` if it does not (a rename, a scenario that stopped being generated, an
    intrinsic dropped upstream). Without this a value silently sits in the wrong file forever -
    nothing else ever revisits a line in data/cpu/expected/."""
    orphans = sorted(set(expected_values) - generated_tests)
    group_map = test_group_map()
    misfiled = {
        name for name in expected_values
        if name in generated_tests and group_map.get(name) is not None
    }
    unmatched_path = EXPECTED_DIR / "_unmatched.txt"
    already_unmatched = {name for name, _ in (
        line.partition(" - ")[::2] for line in
        (unmatched_path.read_text().splitlines() if unmatched_path.exists() else [])
        if " - " in line and not line.startswith("#")
    )}
    # Orphans already sitting in _unmatched.txt are where they belong; only the ones still
    # filed under an extension, and values that match a test again, need re-filing.
    stray = [name for name in orphans if name not in already_unmatched]
    recovered = already_unmatched & misfiled
    if not stray and not recovered:
        return
    if not prune:
        print(f"note: {len(stray)} captured expected value(s) match no generated test "
              f"(e.g. {', '.join(stray[:3]) or 'none'}) and {len(recovered)} in _unmatched.txt "
              f"match one again. Re-run with --prune-expected to re-file them.", file=sys.stderr)
        return

    groups: dict[tuple[str, str], dict[str, str]] = defaultdict(dict)
    for name, value in expected_values.items():
        if (key := group_map.get(name)) is not None and name in generated_tests:
            groups[key][name] = value
    # Rewrite every existing per-extension file, including ones that end up empty, or a value
    # deleted here would survive in the file it used to live in.
    for path in sorted(EXPECTED_DIR.rglob("*.txt")):
        if path != unmatched_path:
            groups.setdefault((path.parent.name, path.stem), {})
    write_expected_values(groups)
    body = "".join(f"{name} - {expected_values[name]}\n" for name in orphans)
    unmatched_path.write_text(UNMATCHED_HEADER + "\n" + body)
    print(f"Re-filed expected values: {len(stray)} moved to _unmatched.txt, "
          f"{len(recovered)} recovered from it.", file=sys.stderr)


def remove_stale_modules(arch_out: Path, generated: set[str]) -> None:
    """Delete the files of an extension that is no longer generated.

    An extension that moves into SKIP_EXTENSIONS (or disappears upstream) otherwise leaves its
    `<ext>.rs` and `<ext>/part*.rs` behind, still compiled by nothing and still looking current
    - and an orphan that no longer compiles only surfaces when someone deletes mod.rs by hand."""
    for entry in sorted(arch_out.iterdir()):
        if entry.name == "mod.rs":
            continue
        if entry.is_dir() and entry.name not in generated:
            for f in entry.glob("*.rs"):
                f.unlink()
            entry.rmdir()
        elif entry.is_file() and entry.suffix == ".rs" and entry.stem not in generated:
            entry.unlink()


class ExtCoverage(NamedTuple):
    arch: str
    ext: str
    discovered: int                         # functions stdarch declares in this group
    generated: int                          # of those, ones a test was emitted for
    tests: int                              # test functions emitted (scenarios included)
    dropped: list[tuple[str, str, str]]     # (function, reason slug, detail)


def rust_str(s: str) -> str:
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", " ").strip() + '"'


def signatures_source(path: Path = SIGNATURES_FILE) -> str:
    """The `# stdarch: rustc 1.x-nightly (... date)` line extract_signatures.py stamps on
    signatures.txt, so a coverage report says which compiler's intrinsic set it counted."""
    if not path.exists():
        return "unknown"
    for line in path.read_text().splitlines()[:5]:
        if line.startswith("# stdarch:"):
            return line.removeprefix("# stdarch:").strip()
    return "unknown"


def reason_descriptions(coverage: list[ExtCoverage]) -> list[tuple[str, str]]:
    """One generic description per reason slug, for the summary. The per-function `detail` is
    more specific than the group deserves - "uses a type with no value helper: poly64x1x2_t"
    reads as if that one type were the whole story when it stands for 2351 functions."""
    out = dict(DROP_REASONS)
    for category, reason in POLICY.categories.items():
        out[f"excluded:{category}"] = reason
    return sorted((slug, out.get(slug, "")) for slug in {r for c in coverage for _n, r, _d in c.dropped})


def gen_coverage_rs(coverage: list[ExtCoverage]) -> str:
    """A static table of what became a test and what did not, compiled into the binary.

    `hodow coverage` is the reader. It has to be compiled in rather than read from
    data/cpu/ at run time: the whole point is to answer the question on the machine under
    test - a board with the binary scp'd onto it and no checkout anywhere near it."""
    lines = [
        "//! What stdarch declares versus what this binary can test, per extension.",
        "//!",
        "//! Generated by scripts/cpu/generate_tests.py - do not edit. Every architecture is",
        "//! included, not just the one being compiled for: the interesting question is often",
        "//! about a target you are not on (\"how much of ARM32 NEON would this cover?\").",
        "",
        "use crate::cpu::{DroppedFunction, ExtensionCoverage};",
        "",
        "/// Which compiler's stdarch these counts were taken from.",
        "pub fn coverage_source() -> &'static str {",
        f"    {rust_str(signatures_source())}",
        "}",
        "",
        "/// What each `DroppedFunction::reason` slug means, for a summary that groups by it.",
        "pub fn drop_reasons() -> &'static [(&'static str, &'static str)] {",
        "    &[",
    ] + [
        f"        ({rust_str(slug)}, {rust_str(text)}),"
        for slug, text in reason_descriptions(coverage)
    ] + [
        "    ]",
        "}",
        "",
        "pub fn coverage() -> &'static [ExtensionCoverage] {",
        "    &[",
    ]
    for c in sorted(coverage, key=lambda c: (c.arch, c.ext)):
        lines.append("        ExtensionCoverage {")
        lines.append(f"            arch: {rust_str(c.arch)}, ext: {rust_str(c.ext)},")
        lines.append(f"            discovered: {c.discovered}, generated: {c.generated}, tests: {c.tests},")
        if not c.dropped:
            lines.append("            dropped: &[],")
        else:
            lines.append("            dropped: &[")
            for name, reason, detail in sorted(c.dropped):
                lines.append(f"                DroppedFunction {{ name: {rust_str(name)}, "
                             f"reason: {rust_str(reason)}, detail: {rust_str(detail)} }},")
            lines.append("            ],")
        lines.append("        },")
    lines += ["    ]", "}", ""]
    return "\n".join(lines)


def main() -> None:
    global MIRI_SKIP_FUNCTIONS
    base = Path.cwd()
    prune_expected = "--prune-expected" in sys.argv

    if MIRI_ONLY_FILE.exists():
        with open(MIRI_ONLY_FILE) as f:
            MIRI_SKIP_FUNCTIONS = {line.strip() for line in f if line.strip() and not line.startswith("#")}


    # Parse signatures grouped by (arch, ext)
    sigs_file = base / SIGNATURES_FILE
    if not sigs_file.exists():
        print(f"Error: {sigs_file} not found. Run extract_signatures.py first.")
        return

    all_sigs = parse_signatures(sigs_file)
    expected_values = load_expected_values(base / EXPECTED_DIR)
    warn_stale_policy_entries(all_sigs)
    reshaped = drop_shape_mismatched_expected(all_sigs, expected_values)
    if reshaped:
        print(f"Note: {len(reshaped)} captured value(s) no longer match the shape their test now "
              f"compares, and are ignored until recaptured (e.g. {', '.join(sorted(reshaped)[:3])})")

    out = base / OUTPUT_DIR
    out.mkdir(parents=True, exist_ok=True)

    # Group by architecture
    by_arch: dict[str, dict[str, list[dict]]] = defaultdict(lambda: defaultdict(list))
    for (arch, ext), funcs in all_sigs.items():
        by_arch[arch][ext] = funcs

    # Stats: (arch::ext, total, generated, modules, no_fuzz, skipped)
    rows: list[tuple[str, int, int, int, int, int]] = []
    coverage: list[ExtCoverage] = []
    generated_tests: set[str] = set()
    unconstrained: list[str] = []

    generated_archs: set[str] = set()

    for arch in sorted(by_arch.keys()):
        arch_out = out / arch
        arch_out.mkdir(exist_ok=True)

        generated_exts: list[tuple[str, str]] = []

        for ext in sorted(by_arch[arch].keys()):
            all_funcs = by_arch[arch][ext]
            if not all_funcs:
                continue

            stable: list[dict] = []
            dropped: list[tuple[str, str, str]] = []   # (function, reason slug, detail)
            for sig in all_funcs:
                reason = drop_reason(sig, arch, ext)
                if reason is None:
                    stable.append(sig)
                else:
                    dropped.append((sig["name"], reason[0], reason[1]))

            test_names = [
                name for sig in stable
                for name in list_scenario_names(sig, arch, ext)
            ]
            generated_tests.update(test_names)
            coverage.append(ExtCoverage(arch, ext, len(all_funcs), len(stable), len(test_names), dropped))

            # Skip extensions that shouldn't be generated
            if ext in SKIP_EXTENSIONS:
                continue

            unconstrained += warn_unconstrained_const_generics(stable, arch, ext)
            skipped_count = len(all_funcs) - len(stable)

            feature = ext_to_feature(ext)
            generated_exts.append((ext, feature))

            full_name = f"{arch}::{ext}"

            by_module: dict[str, list[dict]] = defaultdict(list)
            for sig in stable:
                by_module[module_for(sig["name"], ext)].append(sig)
            # One operation family needs no directory: its single file would say nothing the
            # extension's own name does not, and clippy's module_inception fires on
            # `bswap/bswap.rs`. The bodies go straight into `<ext>.rs` next to the registry.
            if len(by_module) == 1:
                by_module = {}

            # Anything left from a previous run under a name no longer generated - the whole
            # `partN.rs` scheme included - stops being compiled but keeps looking current, so
            # it goes rather than lingering as a misleading copy. An extension that now
            # generates nothing at all (every function excluded, or one family inlined above)
            # needs this too: that used to leave its whole directory of orphans behind.
            parts_dir = arch_out / ext
            if parts_dir.is_dir():
                for old in parts_dir.glob("*.rs"):
                    if old.stem not in by_module:
                        old.unlink()
                if not by_module:
                    parts_dir.rmdir()

            if not stable:
                # Generate empty module
                (arch_out / f"{ext}.rs").write_text(gen_ext_rs(arch, ext, [], []))
                rows.append((full_name, len(all_funcs), 0, 0, 0, skipped_count))
            else:
                if not by_module:
                    inline = gen_part(stable, arch, ext, expected_values)
                    (arch_out / f"{ext}.rs").write_text(gen_ext_rs(arch, ext, stable, [], inline))
                else:
                    parts_dir.mkdir(exist_ok=True)
                    for name, chunk in by_module.items():
                        (parts_dir / f"{name}.rs").write_text(gen_part(chunk, arch, ext, expected_values))
                    (arch_out / f"{ext}.rs").write_text(
                        gen_ext_rs(arch, ext, stable, sorted(by_module)))

                no_fuzz_count = sum(1 for s in stable if skip_fuzz(s["name"], s["params"]))
                rows.append((full_name, len(all_funcs), len(stable), max(1, len(by_module)),
                             no_fuzz_count, skipped_count))

        # Generate arch-specific mod.rs
        (arch_out / "mod.rs").write_text(gen_mod_rs_for_arch(arch, generated_exts))
        generated_archs.add(arch)
        remove_stale_modules(arch_out, {ext for ext, _feature in generated_exts})

    # Generate root mod.rs
    (out / "mod.rs").write_text(gen_root_mod_rs(list(generated_archs)))

    # Generate registry.rs
    (out / "registry.rs").write_text(gen_registry_rs(by_arch))

    # Generate coverage.rs (what `hodow coverage` reports)
    (out / "coverage.rs").write_text(gen_coverage_rs(coverage))

    report_orphan_expected(expected_values, generated_tests, prune_expected)
    if unconstrained:
        print(f"note: {len(unconstrained)} const generic(s) have no range stated upstream, so the "
              f"generated call passes 0 - only `cargo build` can confirm that is valid:", file=sys.stderr)
        for entry in unconstrained[:20]:
            print(f"  {entry}", file=sys.stderr)

    # Pretty table
    col = dict(ext=30, total=6, gen=5, parts=7, nofuzz=7, skipped=7)
    sep = "  "
    header = (f"{'arch::extension':<{col['ext']}}{sep}"
              f"{'total':>{col['total']}}{sep}"
              f"{'gen':>{col['gen']}}{sep}"
              f"{'modules':>{col['parts']}}{sep}"
              f"{'no-fuzz':>{col['nofuzz']}}{sep}"
              f"{'skipped':>{col['skipped']}}")
    rule = "-" * len(header)
    print(rule)
    print(header)
    print(rule)
    for ext, total, gen, parts, nofuzz, unstable in sorted(rows, key=lambda r: r[1], reverse=True):
        print(f"{ext:<{col['ext']}}{sep}"
              f"{total:>{col['total']}}{sep}"
              f"{gen:>{col['gen']}}{sep}"
              f"{parts:>{col['parts']}}{sep}"
              f"{nofuzz:>{col['nofuzz']}}{sep}"
              f"{unstable:>{col['skipped']}}")
    print(rule)
    totals = (sum(r[1] for r in rows), sum(r[2] for r in rows),
              sum(r[3] for r in rows), sum(r[4] for r in rows),
              sum(r[5] for r in rows))
    print(f"{'TOTAL':<{col['ext']}}{sep}"
          f"{totals[0]:>{col['total']}}{sep}"
          f"{totals[1]:>{col['gen']}}{sep}"
          f"{totals[2]:>{col['parts']}}{sep}"
          f"{totals[3]:>{col['nofuzz']}}{sep}"
          f"{totals[4]:>{col['skipped']}}")
    print(rule)
    print(f"\nDone → {out}  ({len(generated_archs)} architectures, {len(rows)} extensions, "
          f"{len(generated_tests)} tests)")

    by_reason: dict[str, int] = defaultdict(int)
    for c in coverage:
        for _name, reason, _detail in c.dropped:
            by_reason[reason] += 1
    if by_reason:
        total_dropped = sum(by_reason.values())
        print(f"\nNot generated: {total_dropped} function(s) "
              f"(`hodow coverage -v` lists them on the machine under test)")
        for reason, count in sorted(by_reason.items(), key=lambda kv: -kv[1]):
            print(f"  {reason:<34} {count:>6}")


if __name__ == "__main__":
    main()
