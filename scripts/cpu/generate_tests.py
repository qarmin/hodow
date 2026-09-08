#!/usr/bin/env python3
"""
Generates Rust SIMD test stubs for all architectures from signatures.txt.
Outputs to hodow_core/src/cpu/auto_generated/<arch>/
"""

import re
from pathlib import Path
from collections import defaultdict

FUNCTIONS_PER_PART = 50
OUTPUT_DIR = Path("hodow_core/src/cpu/auto_generated")
SIGNATURES_FILE = Path("hodow_core/src/cpu/signatures.txt")
FUNCTIONS_FILE = Path("scripts/cpu/excluded_functions.txt")
# Functions that fail *only* under Miri (foreign-function / inline-asm limitations) but
# run fine on real hardware. They are generated and executed natively, but skipped when
# the test binary is run under Miri via a `cfg!(miri)` guard.
MIRI_ONLY_FILE = Path("scripts/cpu/miri_only_functions.txt")
# Functions kept out of pilot-scope value-axis scenario expansion because a vector-typed
# parameter is really a control field, not a value - see the file's own header comment.
UB_ON_VALUE_SCENARIOS_FILE = Path("scripts/cpu/ub_on_value_scenarios.txt")

# Populated from MIRI_ONLY_FILE in main().
MIRI_SKIP_FUNCTIONS: set[str] = set()
# Populated from UB_ON_VALUE_SCENARIOS_FILE in main().
UB_ON_VALUE_SCENARIOS: set[str] = set()


# Ignored functions - that will not be tested
IGNORED_FUNCTIONS: set[str] = {
    # AMX functions - require unstable x86_amx_intrinsics feature (nightly only)
    "_tile_loadconfig", "_tile_storeconfig", "_tile_loadd", "_tile_release",
    "_tile_stored", "_tile_stream_loadd", "_tile_zero", "_tile_dpbf16ps",
    "_tile_dpbssd", "_tile_dpbsud", "_tile_dpbusd", "_tile_dpbuud",
    "_tile_dpfp16ps", "_tile_cmmimfp16ps", "_tile_cmmrlfp16ps", "_tile_dpbf8ps",
    "_tile_dpbhf8ps", "_tile_dphbf8ps", "_tile_dphf8ps", "_tile_loaddrs",
    "_tile_stream_loaddrs", "_tile_mmultf32ps", "_tile_cvtrowd2ps",
    "_tile_cvtrowps2phh", "_tile_cvtrowps2phl", "_tile_movrow",
}

# Functions with memory access errors - skip in fuzzer (#[cfg(not(fuzzing))])
NO_FUZZ_FUNCTIONS: set[str] = {

}


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
    "bf16", "f16",
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
}

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

# Extensions that should be completely skipped (not generated at all)
SKIP_EXTENSIONS = {
    "amx",    # Requires unstable x86_amx_intrinsics feature
    "dsp",    # ARM DSP — requires unstable stdarch_arm_neon_intrinsics
    "hints",  # ARM hints — requires unstable stdarch_arm_hints
    "sat",    # ARM SAT — requires unstable stdarch_arm_sat
    "simd32", # ARM SIMD32 — requires unstable stdarch_arm_neon_intrinsics
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


def ptr_array_size(inner: str) -> int:
    """Number of `inner`-typed elements needed for a buffer that can back any load/store
    up to a 512-bit vector. Defaults to a full 64-byte register for unknown pointees."""
    b = PTR_ELEM_BYTES.get(inner.strip(), 1)
    return max(1, -(-MAX_SIMD_BYTES // b))  # ceil(64 / b)


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
}

# Primitive return types handled via check_int_equality
INT_RETURNS = {
    "i8", "i16", "i32", "i64",
    "u8", "u16", "u32", "u64",
    "__mmask8", "__mmask16", "__mmask32", "__mmask64",
}


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
# function - see git history for both earlier versions - except gather/
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
    # gather/scatter: excluded by substring, not by UB_ON_VALUE_SCENARIOS_FILE entry -
    # there are ~120 of them and the reason is identical for all (see the file's header
    # comment). Everything else that would assemble an invalid/undefined argument
    # combination from an "extreme value" override goes in that file instead, one
    # function per line with its own reason - expected to grow well past this handful.
    return (
        arch in ("x86", "x86_64")
        and "gather" not in func_name.lower()
        and "scatter" not in func_name.lower()
        and func_name not in UB_ON_VALUE_SCENARIOS
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


def _typed_lit(elem: str, kind: str) -> str:
    """A self-typed Rust literal expression of type `elem` for one of a small set of
    semantic value 'kinds' shared by every boundary/normal scenario builder below."""
    if elem in ("f32", "f64"):
        return {
            "min": f"{elem}::MIN", "max": f"{elem}::MAX", "zero": "0.0",
            "allones": f"{elem}::NAN", "pos_inf": f"{elem}::INFINITY",
            "neg_inf": f"{elem}::NEG_INFINITY", "neg_zero": "-0.0",
            "denormal": f"{elem}::MIN_POSITIVE / 2.0",
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


def boundary_lane_values(elem: str, container: str, lane_count: int, kind: str) -> list[str]:
    """5 uniform-per-lane boundary scenarios share this: every lane gets the same
    literal, except 'mixed' which rotates a small set of interesting values."""
    if kind != "mixed":
        return [lane_lit(elem, container, kind)] * lane_count
    if elem in ("f32", "f64"):
        cycle = ["pos_inf", "neg_inf", "neg_zero", "denormal"]
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
        m = re.match(r"^\d+(?:@(\w+))?:(pub\s+(?:unsafe\s+)?fn\s+.+)", line)
        if not m:
            continue
        sig = parse_sig(m.group(2))
        if sig is None:
            continue
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

    return result


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
    return has_ptr(params) or name in NO_FUZZ_FUNCTIONS


def const_val(cg_name: str, func_name: str = "", cg_type: str = "") -> str:
    """Return a safe literal for a const generic parameter."""
    if cg_type == "svpattern":
        # SVE predicate-pattern enum, not an integer - SV_ALL activates every element,
        # valid for every svpattern-typed const generic regardless of what it governs.
        # Braces are required here (unlike a bare integer literal): a path const-generic
        # argument needs `{ }` to disambiguate it from a type argument.
        return "{ svpattern::SV_ALL }"
    upper = cg_name.upper()
    if upper == "SCALE":
        return "1"    # gather/scatter: must be 1, 2, 4, or 8
    if upper == "SAE":
        return "8"    # static_assert_sae!: must be 4 or 8
    if upper == "ROUNDING":
        return "8"    # static_assert_rounding!: must be 4, 8, 9, 10, or 11
    if func_name.startswith("sv") and (upper == "IMM_FACTOR" or upper in ("IMM2", "IMM3")):
        # SVE svqdec*/svqinc*-style: static_assert_range!(IMM_FACTOR, 1..=16), and
        # svasrd_n_*-style IMM2 (shift amount, also range 1..=N for varying N depending on
        # element width) - 1 is always in range regardless of which. Gated to SVE's own
        # "sv"-prefixed naming convention: aarch64/neon's unrelated SM3 crypto functions
        # (vsm3tt1aq_u32 etc.) also happen to name a const generic "IMM2", but theirs has
        # no range restriction at all and its already-captured expected value assumes the
        # blanket default of 0 - do not disturb that one.
        return "1"
    if upper == "IMM_ROTATION":
        return "90"   # SVE FCMA-style: static_assert!(IMM_ROTATION == 90 || == 270) (some
                       # variants also allow 0/180, so 90 is the one value valid everywhere)
    if upper == "N" and re.search(r"_n_|_n$", func_name):
        # NEON's own naming convention: an "_n_"/"_n" infix/suffix specifically marks an
        # immediate *magnitude* operand (fixed-point convert vcvt_n_*, shift vshr_n_*/
        # vsli_n_*/...) - almost every one asserts `N >= 1`. A same-named "N" elsewhere
        # (e.g. vdup_lane_f64's single-lane index, asserting `N == 0`) is a lane index in
        # disguise, not a magnitude - excluded by requiring the "_n_"/"_n" name pattern too.
        return "1"
    return "0"


def const_suffix(cg: list, func_name: str = "") -> str:
    return f"::<{', '.join(const_val(n, func_name, t) for n, t in cg)}>" if cg else ""


def immediate_catalog(func_name: str, cg_name: str, elem_type: str) -> list[tuple[str, str]]:
    """Immediate-axis scenarios for a const-generic parameter: (suffix, literal) pairs.
    Independent from the value axis (see gen_scenarios) — runtime args stay at 'normal1'
    while these vary the immediate, so the two axes are additive, not multiplied."""
    upper = cg_name.upper()
    if upper in ("SCALE", "SAE", "ROUNDING"):
        return []  # required literal, no interesting variation to add
    lane_bits = {"i8": 8, "u8": 8, "i16": 16, "u16": 16,
                 "i32": 32, "u32": 32, "i64": 64, "u64": 64}.get(elem_type, 32)
    if re.search(r"srli|slli|srai|sll|srl|sra|bslli|bsrli", func_name):
        w = lane_bits
        return [("imm_0", "0"), ("imm_1", "1"), ("imm_width_m1", str(w - 1)), ("imm_width", str(w))]
    if re.search(r"\bcmp_(ps|pd|sd|ss)", func_name):
        return [("imm_eq", "0"), ("imm_lt", "1"), ("imm_le", "2"), ("imm_neq", "4"), ("imm_ge", "13")]
    if re.search(r"blend", func_name):
        # Immediates here are unsigned bitmasks checked at compile time via
        # static_assert_uimm_bits!(NAME, N) — derive N from the const-generic's own
        # name (IMM4 -> 4 bits, IMM8 -> 8 bits, ...) so "all bits set"/"alternating"
        # literals never exceed the function's actual valid range.
        bits_m = re.search(r"IMM(\d+)", upper)
        max_bits = int(bits_m.group(1)) if bits_m else 8
        allones = (1 << max_bits) - 1
        alt = sum(1 << i for i in range(max_bits) if i % 2 == 0)
        return [("imm_0", "0"), ("imm_allones", str(allones)), ("imm_alt", str(alt))]
    # Generic fallback (shuffle/permute/insert-lane style immediates outside the
    # pilot's regex today): stick to small non-negative literals only, since we don't
    # know whether the target's static_assert_uimm_bits! would reject a negative value.
    return [("imm_0", "0"), ("imm_1", "1")]


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


def load_expected_values(path: Path) -> dict[str, str]:
    """Parse expected_cpu_values.txt: 'test_name - rust_expr' → {test_name: rust_expr}"""
    if not path.exists():
        return {}
    result: dict[str, str] = {}
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        if " - " not in line:
            continue
        name, _, value = line.partition(" - ")
        result[name.strip()] = value.strip()
    return result


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
    """Adjust expected literal text so its element literals match the element type for `ret`.

    Currently this handles converting float-special tokens (NaN/inf) and common f32/f64 prefixes.
    """
    elem = _elem_type_for_unpack(ret)
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


def rust_str_lit(s: str) -> str:
    """Escape `s` for embedding as the body of a Rust `format!("...")` string literal - the
    only current caller (`_checked`) always uses it inside one, so `{`/`}` (from SVE's
    `{ svpattern::SV_ALL }` braced const-generic argument) need `{{`/`}}` doubling too, not
    just quote/backslash escaping."""
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("{", "{{").replace("}", "}}")


def _checked(check_call: str, call: str) -> str:
    """Wraps a `check_*_equality(...)` call (no trailing `?`) so a failure's error also
    reports the exact call - including every input literal - that produced it. The check
    functions themselves only ever see the computed result and expected value; without
    this, a failing test's message shows two outputs (Got/expected) with no way to tell
    what input produced them."""
    return f'{check_call}.map_err(|e| format!("{{e}} | call: {rust_str_lit(call)}"))?;'


def emit_check(lines: list[str], call: str, ret: str, expected: str | None = None,
               width_override: tuple[str, str, int] | None = None) -> None:
    """Append lines that call `call` and check its result.

    `width_override`, if given as (unpacker_fn, container_elem, lane_count), replaces the
    generic UNPACK_INFO-driven unpack for a vector return — used for pilot-scope functions
    so e.g. an `_epi8`-returning `__m128i` is unpacked per real 8-bit lane instead of the
    generic (still bit-correct, but far less readable) 4-lane i32 view every other function
    still uses."""
    if width_override is not None and ret in UNPACK_INFO:
        fn, container, size = width_override
        is_float = container in ("f32", "f64")
        zero = "0.0" if is_float else "0"
        lines.append(f"        let result = {fn}({call});")
        if expected is not None:
            adj_expected = _adjust_expected_for_ret(expected, ret)
            if is_float:
                lines.append("        " + _checked(f"check_float_array_equality(&result, &{adj_expected})", call))
            else:
                lines.append("        " + _checked(f"check_array_equality(&result, &{adj_expected})", call))
        elif is_float:
            lines.append("        " + _checked(f"check_float_array_equality(&result, &[{zero}; {size}])", call))
        else:
            lines.append("        " + _checked(f"check_array_equality(&result, &[{zero}; {size}])", call))
    elif expected is not None:
        # User-supplied expected value: emit check based on return type
        if ret in UNPACK_INFO:
            fn, _, _ = UNPACK_INFO[ret]
            lines.append(f"        let result = {fn}({call});")
            adj_expected = _adjust_expected_for_ret(expected, ret)
            # choose float-array vs generic-array comparator
            elem = _elem_type_for_unpack(ret)
            if elem in ("f32", "f64"):
                lines.append("        " + _checked(f"check_float_array_equality(&result, &{adj_expected})", call))
            else:
                lines.append("        " + _checked(f"check_array_equality(&result, &{adj_expected})", call))
        elif ret in INT_RETURNS:
            lines.append(f"        let result = {call};")
            lines.append("        " + _checked(f"check_int_equality(result as i32, {expected})", call))
        elif ret in ("()", ""):
            lines.append(f"        {call};")
        else:
            lines.append(f"        let _result = {call};")
    elif ret in UNPACK_INFO:
        fn, size, zero = UNPACK_INFO[ret]
        lines.append(f"        let result = {fn}({call});")
        # choose comparator based on element type
        elem = _elem_type_for_unpack(ret)
        if elem in ("f32", "f64"):
            lines.append("        " + _checked(f"check_float_array_equality(&result, &[{zero}; {size}])", call))
        else:
            lines.append("        " + _checked(f"check_array_equality(&result, &[{zero}; {size}])", call))
    elif ret in INT_RETURNS:
        lines.append(f"        let result = {call};")
        lines.append("        " + _checked("check_int_equality(result as i32, 0)", call))
    elif ret in ("()", ""):
        lines.append(f"        {call};")
    else:
        # f16, bf16, __m128h, etc. – compile but don't check
        lines.append(f"        let _result = {call};")


def test_name(func_name: str, arch: str, ext: str) -> str:
    """test_<arch>_<ext>_ + strip leading underscores, e.g. (x86, sse4a, _mm_add) →
    test_x86_sse4a_mm_add. The arch/ext prefix makes which CPU feature a failing test
    belongs to legible from the bare test name alone (e.g. in a log line), without having
    to cross-reference the surrounding ExtensionTest grouping."""
    return f"test_{arch}_{ext}_" + func_name.lstrip("_")


def gen_fn_body(sig: dict, expected: str | None, param_overrides: dict[str, str] | None = None,
                 cg_override: str | None = None, elem_type: str | None = None) -> list[str]:
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
    cs = f"::<{cg_override}>" if cg_override is not None else const_suffix(cg, name)
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
        lines.append("            return Ok(());")
        lines.append("        }")
    lines.append("    unsafe {")

    is_gather = any(p in name.lower() for p in ("gather", "scatter"))
    # xsave/fxsave/xrstor/fxrstor write the full processor state region (>= 512 bytes,
    # up to a few KiB) through a `*mut u8`, far larger than a SIMD register.
    is_state_save = "xsave" in name.lower() or "xrstor" in name.lower()
    ctr = [1]  # sequential counter, reset per-function for stable inputs

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
                array_size = 4096 if is_state_save else (64 if is_gather else ptr_array_size(inner))
                init = overrides[pname] if pname in overrides else seq_init(inner, ctr)
                lines.append(f"        let ptr_{pname} = crate::cpu::common::Aligned64([{init}; {array_size}]);")
                call_args.append(f"ptr_{pname}.0.as_ptr()")
            elif "*mut" in ptype:
                inner = ptype.replace("*mut", "").strip()
                array_size = 4096 if is_state_save else (64 if is_gather else ptr_array_size(inner))
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
                elif is_gather:
                    # Gather/scatter: zeroed SIMD for index/offset params (all read from base+0)
                    init = ZERO_SIMD_INITS.get(ptype, FIXED_INITS.get(ptype, f"0 /* {ptype} */"))
                else:
                    init = seq_init(ptype, ctr)
                lines.append(f"        let {pname} = {init};")
                call_args.append(pname)
        call = f"{name}{cs}({', '.join(call_args)})"
        emit_check(lines, call, ret, expected, width_override)
    else:
        call_args = [overrides[pname] if pname in overrides else seq_init(pt, ctr) for pname, pt in params]
        call = f"{name}{cs}({', '.join(call_args)})"
        emit_check(lines, call, ret, expected, width_override)

    # Fuzzing block (still inside the single unsafe {})
    if not no_fuzz and complete:
        lines.append("")
        lines.append("        let total_iters = crate::cpu::get_iterations();")
        lines.append("        if crate::get_fuzzing() && total_iters > 0 {")
        lines.append("            log::info!(\"Starting fuzzing\");")
        lines.append("            for i in 0..total_iters {")
        lines.append("                if i % 1000 == 0 && crate::cpu::should_stop() {")
        lines.append("                    log::info!(\"Fuzzing stopped at iteration {}\", i);")
        lines.append("                    break;")
        lines.append("                }")

        fuzz_args = [arg_expr(pt, random=True) for _, pt in params
                     if "*" not in pt and not pt.startswith("&")]
        fuzz_call = f"{name}{cs}({', '.join(fuzz_args)})"
        if ret in ("()", ""):
            lines.append(f"                {fuzz_call};")
        else:
            lines.append(f"                let _ = {fuzz_call};")
        lines.append("            }")
        lines.append("        }")

    lines.append("    }")
    return lines


def arch_only_cfg_line(sig: dict) -> list[str]:
    """`arm_shared` is compiled unconditionally for both arm and aarch64 - a signature
    hard-gated upstream to a single one of them (see extract_signatures.py's
    find_hard_arch_gate) needs the same `#[cfg(target_arch = ...)]` on the generated
    wrapper, or it fails to compile on the other target."""
    arch_only = sig.get("arch_only")
    return [f'#[cfg(target_arch = "{arch_only}")]'] if arch_only else []


def gen_fn(sig: dict, arch: str, ext: str, expected_values: dict[str, str] | None = None) -> str:
    test = test_name(sig["name"], arch, ext)
    expected = (expected_values or {}).get(test)
    lines = arch_only_cfg_line(sig)
    body = gen_fn_body(sig, expected)
    if arch == "aarch64" and ext in ("sve", "sve2"):
        # SVE's scalable-vector types need #[target_feature(enable = "sve")] on ANY function
        # whose signature or locals touch one (a hard ABI requirement, not an optimization
        # hint like on x86/NEON) - but a #[target_feature] function no longer implements
        # `Fn`, which breaks `&'static TestFunction = &dyn Fn() -> Result<...>` in the
        # registry. Splitting into a target_feature-carrying inner fn plus a plain safe
        # outer wrapper (calling it through one unsafe block, itself untouched by any
        # scalable type) keeps the registry-visible symbol Fn-compatible. Verified directly
        # against rustc - this is the only shape found that both compiles and registers.
        impl_name = f"{test}_impl"
        lines.append('#[target_feature(enable = "sve")]')
        lines.append(f"fn {impl_name}() -> Result<(), String> {{")
        lines += body
        lines += ["    Ok(())", "}", ""]
        lines.append(f"pub(super) fn {test}() -> Result<(), String> {{")
        lines.append(f"    unsafe {{ {impl_name}() }}")
        lines.append("}")
        return "\n".join(lines)
    lines.append(f"pub(super) fn {test}() -> Result<(), String> {{")
    lines += body
    lines += ["    Ok(())", "}"]
    return "\n".join(lines)


# Vector types with a WIDTH_AWARE_VEC_INFO entry (any element type) — used to find the
# value-axis-eligible parameters of a pilot-scope function.
_WIDTHED_VEC_TYPES = {"__m128i", "__m256i", "__m512i", "__m128", "__m256", "__m512", "__m128d", "__m256d", "__m512d"}


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


def _build_value_scenarios(sig: dict) -> list[tuple[str, dict[str, str]]]:
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
        scenarios.append((suffix, overrides_for(lambda pos, lanes, container, kind=kind: boundary_lane_values(elem, container, lanes, kind))))

    if len(widthed) >= 2:
        _idx0, pname0, ptype0 = widthed[0]
        _idx1, pname1, ptype1 = widthed[1]
        creator0, container0, _u0, lanes0 = WIDTH_AWARE_VEC_INFO[(ptype0, elem)]
        creator1, container1, _u1, lanes1 = WIDTH_AWARE_VEC_INFO[(ptype1, elem)]
        for suffix, (kind0, kind1) in (("asym_min_max", ("min", "max")), ("asym_max_min", ("max", "min"))):
            ov = {
                pname0: f"{creator0}([{', '.join(boundary_lane_values(elem, container0, lanes0, kind0))}])",
                pname1: f"{creator1}([{', '.join(boundary_lane_values(elem, container1, lanes1, kind1))}])",
            }
            scenarios.append((suffix, ov))
    return scenarios


def _build_immediate_scenarios(sig: dict) -> list[tuple[str, str]]:
    """(suffix, literal) pairs for the immediate axis. Runtime values stay at 'normal1'
    (empty param_overrides) here — this axis is additive with the value axis, not a
    cartesian product with it (see expand_scenarios)."""
    cg: list = sig["const_generics"]
    if len(cg) != 1:
        # Pilot-scope functions have at most one const generic; multi-cg functions
        # (none in scope today) keep their single default-pinned scenario only.
        return []
    cg_name, _cg_type = cg[0]
    return immediate_catalog(sig["name"], cg_name, sig_elem_type(sig))


def expand_scenarios(sig: dict) -> list[tuple[str, dict[str, str], str | None]]:
    """All scenarios for a pilot-scope function as (suffix, param_overrides, cg_override).
    'normal1' (suffix='', no overrides) is always first, so it renders under exactly
    today's function name."""
    scenarios: list[tuple[str, dict[str, str], str | None]] = [("", {}, None)]
    for suffix, overrides in _build_value_scenarios(sig):
        scenarios.append((suffix, overrides, None))
    for suffix, literal in _build_immediate_scenarios(sig):
        scenarios.append((suffix, {}, literal))
    return scenarios


def list_scenario_names(sig: dict, arch: str, ext: str) -> list[str]:
    base = test_name(sig["name"], arch, ext)
    return [base + (f"_{suffix}" if suffix else "") for suffix, _, _ in expand_scenarios(sig)]


def gen_scenarios(sig: dict, arch: str, ext: str, expected_values: dict[str, str] | None = None) -> str:
    """Source for every scenario function of one pilot-scope base signature, joined the
    same way multiple gen_fn() outputs are joined by gen_part."""
    base = test_name(sig["name"], arch, ext)
    elem = sig_elem_type(sig)
    bodies = []
    for suffix, overrides, cg_override in expand_scenarios(sig):
        tname = base + (f"_{suffix}" if suffix else "")
        expected = (expected_values or {}).get(tname)
        lines = arch_only_cfg_line(sig)
        lines.append(f"pub(super) fn {tname}() -> Result<(), String> {{")
        lines += gen_fn_body(sig, expected, overrides or None, cg_override, elem)
        lines += ["    Ok(())", "}"]
        bodies.append("\n".join(lines))
    return "\n\n".join(bodies)


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
    hodow_core/src/cpu/common.rs only declares `x86`, cfg-gated to x86/x86_64, `arm`,
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


def gen_part(funcs: list[dict], arch: str, ext: str, expected_values: dict[str, str] | None = None) -> str:
    arch_import = get_arch_import(arch)
    common_helpers = get_common_helpers(arch)

    header = [arch_import, ""]
    for helper in common_helpers:
        header += ["#[allow(unused_imports)]", f"use {helper}::*;"]
    header += [
        "#[allow(unused_imports)]",
        "use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};",
        "",
    ]
    bodies = [
        gen_scenarios(sig, arch, ext, expected_values) if in_pilot_scope(arch, ext, sig["name"]) else gen_fn(sig, arch, ext, expected_values)
        for sig in funcs
    ]
    return "\n".join(header) + "\n" + "\n\n".join(bodies) + "\n"


def gen_ext_rs(arch: str, ext: str, funcs: list[dict], n_parts: int) -> str:
    struct = ext_to_struct(ext)
    lines = []
    for i in range(1, n_parts + 1):
        lines.append(f"mod part{i};")
    lines.append("")
    for i in range(1, n_parts + 1):
        lines.append(f"use crate::cpu::auto_generated::{arch}::{ext}::part{i}::*;")
    lines += [
        "",
        "use crate::cpu::{ExtensionTest, TestFunction};",
        "",
        f"pub struct {struct};",
        "",
        f"impl ExtensionTest for {struct} {{",
        "    fn get_name() -> &'static str {",
        f"        \"{arch}::{struct}\"",
        "    }",
        "",
        "    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {",
        "        &[",
    ]
    for sig in funcs:
        cfg = arch_only_cfg_line(sig)
        if in_pilot_scope(arch, ext, sig["name"]):
            for tname in list_scenario_names(sig, arch, ext):
                lines += [f"            {c}" for c in cfg]
                lines.append(f"            (&{tname}, \"{tname}\"),")
        else:
            tname = test_name(sig["name"], arch, ext)
            lines += [f"            {c}" for c in cfg]
            lines.append(f"            (&{tname}, \"{tname}\"),")
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

    The `#[cfg(target_feature = ...)]` gate is x86/x86_64-only on purpose: there, it means
    "only include this extension's code at all if the crate itself was built with that
    target feature" (e.g. `-C target-feature=+avx512f`, same as `target-cpu=native` -
    every x86 test also has its own runtime `is_x86_feature_detected!` check, so this is a
    second, coarser, opt-in gate on top, not a correctness requirement). For every other
    architecture this project generates for, the feature name either isn't a real
    `-C target-feature` string at all (aarch64's "prefetch" - PRFM is baseline ISA, not an
    optional target feature; see BASELINE_ALWAYS_TRUE_FEATURES) or would just mean "nobody
    ever passes `-C target-feature=+X` for this architecture in practice", either way
    permanently and silently compiling the extension's module out - runtime-only detection
    (get_feature_detect_fn) is both correct and sufficient there, so this gate is skipped."""
    x86_only = arch in ("x86", "x86_64")
    lines = []
    for ext, feature in exts:
        # Only add cfg if feature is supported
        if x86_only and feature and feature not in UNSUPPORTED_FEATURES:
            lines.append(f"#[cfg(target_feature = \"{feature}\")]")
        lines.append(f"pub mod {ext};")
        # Add blank line only if we added cfg
        if x86_only and feature and feature not in UNSUPPORTED_FEATURES:
            lines.append("")
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
        return f"detect_arm_shared_{feature}()"
    if arch in ("riscv32", "riscv64", "riscv_shared"):
        # Unstable (stdarch_riscv_feature_detection) - see lib.rs's cfg_attr.
        return f'std::arch::is_riscv_feature_detected!("{feature}")'
    # For other architectures, we'll need to add detection when available
    # For now, return a placeholder that always returns false
    return "false /* feature detection not yet implemented */"


def gen_arm_shared_detect_helpers(all_data: dict[str, dict[str, list[dict]]]) -> list[str]:
    """`arm_shared` is compiled unconditionally for both arm and aarch64 (see
    get_target_arch_cfg) - but `is_arm_feature_detected!`/`is_aarch64_feature_detected!`
    each only compile under their OWN target_arch (a plain `cfg!()` runtime check isn't
    enough, confirmed against rustc directly: the macro itself refuses to expand on the
    "wrong" arch). One small dispatch function per feature, cfg-split internally, lets
    get_feature_detect_fn hand back a single always-valid call for the arm_shared case."""
    features = sorted({
        ext_to_feature(ext)
        for ext, funcs in all_data.get("arm_shared", {}).items()
        if ext not in SKIP_EXTENSIONS and funcs
    })
    lines: list[str] = []
    for feature in features:
        lines += [
            "#[cfg(any(target_arch = \"arm\", target_arch = \"aarch64\"))]",
            f"fn detect_arm_shared_{feature}() -> bool {{",
            "    #[cfg(target_arch = \"arm\")]",
            f"    {{ return std::arch::is_arm_feature_detected!(\"{feature}\"); }}",
            "    #[cfg(target_arch = \"aarch64\")]",
            f"    {{ return std::arch::is_aarch64_feature_detected!(\"{feature}\"); }}",
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
        "use crate::cpu::{ExtensionTest, FeatureStats, TestStatistics, ProgressCallback, TestFunction};",
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
            # Only add cfg if feature is supported
            if arch in ("x86", "x86_64") and feature not in UNSUPPORTED_FEATURES:
                lines.append(f"        #[cfg(target_feature = \"{feature}\")]")
            detect_fn = get_feature_detect_fn(arch, feature)
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
            # Only add cfg if feature is supported
            if arch in ("x86", "x86_64") and feature not in UNSUPPORTED_FEATURES:
                lines.append(f"        #[cfg(target_feature = \"{feature}\")]")
            detect_fn = get_feature_detect_fn(arch, feature)
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

            # Only add cfg if feature is supported
            if arch in ("x86", "x86_64") and feature not in UNSUPPORTED_FEATURES:
                lines.append(f"        #[cfg(target_feature = \"{feature}\")]")
                lines.append("        {")

            detect_fn = get_feature_detect_fn(arch, feature)
            lines.append(f"            if {detect_fn} && !should_skip_feature(\"{ext}\") {{")
            lines.append("                    if should_stop() {")
            lines.append("                        return Ok(TestStatistics { features, was_cancelled: true });")
            lines.append("                    }")
            lines.append(f"                    let (r, s, e) = crate::cpu::auto_generated::{arch}::{ext}::{struct}::test_with_progress(")
            lines.append("                    total_features,")
            lines.append("                    completed_features,")
            lines.append(f"                    crate::cpu::auto_generated::{arch}::{ext}::{struct}::get_tests().len(),")
            lines.append("                    progress_callback,")
            lines.append("                    )?;")
            lines.append("                    features.push(FeatureStats {")
            lines.append(f"                        feature_name: crate::cpu::auto_generated::{arch}::{ext}::{struct}::get_name(),")
            lines.append("                        tests_run: r,")
            lines.append("                        tests_skipped: s,")
            lines.append("                        tests_errored: e,")
            lines.append("                    });")
            lines.append("                    completed_features += 1;")
            lines.append("            }")
            # Close the cfg block if we opened it
            if arch in ("x86", "x86_64") and feature not in UNSUPPORTED_FEATURES:
                lines.append("        }")
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

            # Only add cfg if feature is supported
            if arch in ("x86", "x86_64") and feature not in UNSUPPORTED_FEATURES:
                lines.append(f"        #[cfg(target_feature = \"{feature}\")]")
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
        "/// Flat list of (test_name, feature, test_fn) for every feature detected at runtime",
        "/// on this machine, in the canonical execution order. Used by the isolated subprocess",
        "/// runner (so a crashing/hanging test can be attributed and skipped instead of",
        "/// aborting the run) and by the stress runner. `feature` is the extension name (e.g.",
        "/// \"sse2\", \"avx2\") a caller can filter on without re-detecting it per test.",
        "pub fn all_tests() -> Vec<(&'static str, &'static str, &'static TestFunction)> {",
        "    let mut tests: Vec<(&'static str, &'static str, &'static TestFunction)> = Vec::new();",
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

            if arch in ("x86", "x86_64") and feature not in UNSUPPORTED_FEATURES:
                lines.append(f"        #[cfg(target_feature = \"{feature}\")]")
            detect_fn = get_feature_detect_fn(arch, feature)
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


def main() -> None:
    global IGNORED_FUNCTIONS, MIRI_SKIP_FUNCTIONS, UB_ON_VALUE_SCENARIOS
    base = Path.cwd()

    if MIRI_ONLY_FILE.exists():
        with open(MIRI_ONLY_FILE) as f:
            MIRI_SKIP_FUNCTIONS = {line.strip() for line in f if line.strip() and not line.startswith("#")}

    if UB_ON_VALUE_SCENARIOS_FILE.exists():
        with open(UB_ON_VALUE_SCENARIOS_FILE) as f:
            UB_ON_VALUE_SCENARIOS = {line.strip() for line in f if line.strip() and not line.startswith("#")}

    if FUNCTIONS_FILE.exists():
        with open(FUNCTIONS_FILE) as f:
            IGNORED_FUNCTIONS = {line.strip() for line in f if line.strip() and not line.startswith("#")}
    else:
        IGNORED_FUNCTIONS = set()

    # Parse signatures grouped by (arch, ext)
    sigs_file = base / SIGNATURES_FILE
    if not sigs_file.exists():
        print(f"Error: {sigs_file} not found. Run extract_signatures.py first.")
        return

    all_sigs = parse_signatures(sigs_file)
    expected_values = load_expected_values(base / "expected_cpu_values.txt")

    out = base / OUTPUT_DIR
    out.mkdir(parents=True, exist_ok=True)

    # Group by architecture
    by_arch: dict[str, dict[str, list[dict]]] = defaultdict(lambda: defaultdict(list))
    for (arch, ext), funcs in all_sigs.items():
        by_arch[arch][ext] = funcs

    # Stats: (arch::ext, total, generated, parts, no_fuzz, skipped)
    rows: list[tuple[str, int, int, int, int, int]] = []

    generated_archs: set[str] = set()

    for arch in sorted(by_arch.keys()):
        arch_out = out / arch
        arch_out.mkdir(exist_ok=True)

        generated_exts: list[tuple[str, str]] = []

        for ext in sorted(by_arch[arch].keys()):
            # Skip extensions that shouldn't be generated
            if ext in SKIP_EXTENSIONS:
                continue

            all_funcs = by_arch[arch][ext]
            if not all_funcs:
                continue

            # Filter stable functions
            stable = [s for s in all_funcs
                      if s["is_complete"]
                      and not has_unstable_type(s["params"], s["return_type"] or "()")
                      and s["name"] not in DEPRECATED_FUNCTIONS
                      and s["name"] not in IGNORED_FUNCTIONS
                      and (arch != "x86" or s["name"] not in X86_INCOMPATIBLE_FUNCTIONS)
                      and not (ext in ("sve", "sve2") and (
                          has_ptr(s["params"])
                          # Gather/scatter/prefetch: the "pointer" is a vector of per-lane
                          # base addresses (svuint32_t/svuint64_t), not a *const/*mut has_ptr
                          # can see - same out-of-bounds hazard as x86 gather/scatter, plus
                          # svprfop-typed prefetch-kind const generics this generator has no
                          # literal for (all such functions are named-matched here, verified
                          # against every real `const OP: svprfop` signature in stdarch).
                          or re.search(r"prf|gather|scatter", s["name"])
                          or SVE_VL_DEPENDENT_RE.match(s["name"])
                      ))]
            skipped_count = len(all_funcs) - len(stable)

            feature = ext_to_feature(ext)
            generated_exts.append((ext, feature))

            full_name = f"{arch}::{ext}"

            if not stable:
                # Generate empty module
                (arch_out / f"{ext}.rs").write_text(gen_ext_rs(arch, ext, [], 0))
                rows.append((full_name, len(all_funcs), 0, 0, 0, skipped_count))
            else:
                parts = [stable[i:i + FUNCTIONS_PER_PART]
                         for i in range(0, len(stable), FUNCTIONS_PER_PART)]

                parts_dir = arch_out / ext
                parts_dir.mkdir(exist_ok=True)

                # Remove stale part files
                for old in parts_dir.glob("part*.rs"):
                    m = re.match(r"part(\d+)\.rs$", old.name)
                    if m and int(m.group(1)) > len(parts):
                        old.unlink()

                for idx, chunk in enumerate(parts, 1):
                    (parts_dir / f"part{idx}.rs").write_text(gen_part(chunk, arch, ext, expected_values))

                (arch_out / f"{ext}.rs").write_text(gen_ext_rs(arch, ext, stable, len(parts)))

                no_fuzz_count = sum(1 for s in stable if skip_fuzz(s["name"], s["params"]))
                rows.append((full_name, len(all_funcs), len(stable), len(parts),
                             no_fuzz_count, skipped_count))

        # Generate arch-specific mod.rs
        (arch_out / "mod.rs").write_text(gen_mod_rs_for_arch(arch, generated_exts))
        generated_archs.add(arch)

    # Generate root mod.rs
    (out / "mod.rs").write_text(gen_root_mod_rs(list(generated_archs)))

    # Generate registry.rs
    (out / "registry.rs").write_text(gen_registry_rs(by_arch))

    # Pretty table
    col = dict(ext=30, total=6, gen=5, parts=5, nofuzz=7, skipped=7)
    sep = "  "
    header = (f"{'arch::extension':<{col['ext']}}{sep}"
              f"{'total':>{col['total']}}{sep}"
              f"{'gen':>{col['gen']}}{sep}"
              f"{'parts':>{col['parts']}}{sep}"
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
    print(f"\nDone → {out}  ({len(generated_archs)} architectures, {len(rows)} extensions)")


if __name__ == "__main__":
    main()
