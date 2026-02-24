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

# Types without helpers in values.rs — functions using these are skipped entirely
UNSTABLE_TYPES = {
    "bf16", "f16",
    "__m128h", "__m256h", "__m512h",
    "__m128bh_avx", "__m256bh_avx",  # extra aliases that may appear
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
    "hints",    # ARM hints, no detection available
    "sat",      # ARM saturation, no detection available
    "dsp",      # ARM DSP, no detection available
    "simd32",   # ARM SIMD32, no detection available
    "mte",      # ARM MTE, no detection available
    "prefetch", # Architecture-specific, no generic detection
    "packed",   # NVPTX specific
    "msa",      # MIPS MSA
    "altivec",  # PowerPC
    "vsx",      # PowerPC
    "vector",   # s390x
    "zk",       # RISC-V
    "zb",       # RISC-V
    "p",        # RISC-V
    "simd128",  # WASM
    "relaxed_simd", # WASM
    "atomic",   # WASM
    "memory",   # WASM
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
    "usize": "rand::random::<usize>()",
    "bool":  "rand::random::<bool>()",
    "u128":  "rand::random::<u128>()",
    "Ordering": "core::sync::atomic::Ordering::Relaxed",
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
}

# Primitive return types handled via check_int_equality
INT_RETURNS = {
    "i8", "i16", "i32", "i64",
    "u8", "u16", "u32", "u64",
    "__mmask8", "__mmask16", "__mmask32", "__mmask64",
}


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
        m = re.match(r"^\d+:(pub\s+(?:unsafe\s+)?fn\s+.+)", line)
        if not m:
            continue
        sig = parse_sig(m.group(1))
        if sig is None:
            continue

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
    return (            has_ptr(params) or
            name in NO_FUZZ_FUNCTIONS)


def skip_miri(name: str) -> bool:
    """Check if function should be skipped in Miri (cfg(not(miri)))."""
    return name in NO_MIRI_FUNCTIONS


def const_val(cg_name: str) -> str:
    """Return a safe literal for a const generic parameter."""
    upper = cg_name.upper()
    if upper == "SCALE":
        return "1"    # gather/scatter: must be 1, 2, 4, or 8
    if upper == "SAE":
        return "8"    # static_assert_sae!: must be 4 or 8
    if upper == "ROUNDING":
        return "8"    # static_assert_rounding!: must be 4, 8, 9, 10, or 11
    return "0"


def const_suffix(cg: list) -> str:
    return f"::<{', '.join(const_val(n) for n, _ in cg)}>" if cg else ""


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


def emit_check(lines: list[str], call: str, ret: str, expected: str | None = None) -> None:
    """Append lines that call `call` and check its result."""
    if expected is not None:
        # User-supplied expected value: emit check based on return type
        if ret in UNPACK_INFO:
            fn, _, _ = UNPACK_INFO[ret]
            lines.append(f"        let result = {fn}({call});")
            adj_expected = _adjust_expected_for_ret(expected, ret)
            # choose float-array vs generic-array comparator
            elem = _elem_type_for_unpack(ret)
            if elem in ("f32", "f64"):
                lines.append(f"        check_float_array_equality(&result, &{adj_expected})?;")
            else:
                lines.append(f"        check_array_equality(&result, &{adj_expected})?;")
        elif ret in INT_RETURNS:
            lines.append(f"        let result = {call};")
            lines.append(f"        check_int_equality(result as i32, {expected})?;")
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
            lines.append(f"        check_float_array_equality(&result, &[{zero}; {size}])?;")
        else:
            lines.append(f"        check_array_equality(&result, &[{zero}; {size}])?;")
    elif ret in INT_RETURNS:
        lines.append(f"        let result = {call};")
        lines.append(f"        check_int_equality(result as i32, 0)?;")
    elif ret in ("()", ""):
        lines.append(f"        {call};")
    else:
        # f16, bf16, __m128h, etc. – compile but don't check
        lines.append(f"        let _result = {call};")


def test_name(func_name: str) -> str:
    """test_ + strip leading underscores: _mm_add → test_mm_add"""
    return "test_" + func_name.lstrip("_")


def gen_fn(sig: dict, expected_values: dict[str, str] | None = None) -> str:
    name = sig["name"]
    test = test_name(name)
    expected = (expected_values or {}).get(test)
    params: list = sig["params"] or []
    ret: str = sig["return_type"] or "()"
    cg: list = sig["const_generics"]
    complete: bool = sig["is_complete"]
    cs = const_suffix(cg)
    no_fuzz = skip_fuzz(name, params)

    lines = []

    lines.append(f"pub(super) fn {test}() -> Result<(), String> {{")
    lines.append("    unsafe {")

    is_gather = any(p in name.lower() for p in ("gather", "scatter"))
    ctr = [1]  # sequential counter, reset per-function for stable inputs

    if not complete:
        lines.append(f"        todo!(\"{name}\")")
    elif has_ptr(params):
        # Build local buffers for pointer and reference arguments
        # Gather/scatter: large array (safe for any valid offset) + zeroed SIMD offsets
        array_size = 64 if is_gather else 1
        call_args: list[str] = []
        for pname, ptype in params:
            ref_inner = inner_ref_type(ptype)
            if "*const" in ptype:
                inner = ptype.replace("*const", "").strip()
                init = seq_init(inner, ctr)
                lines.append(f"        let ptr_{pname} = [{init}; {array_size}];")
                call_args.append(f"ptr_{pname}.as_ptr()")
            elif "*mut" in ptype:
                inner = ptype.replace("*mut", "").strip()
                init = seq_init(inner, ctr)
                lines.append(f"        let mut ptr_{pname} = [{init}; {array_size}];")
                call_args.append(f"ptr_{pname}.as_mut_ptr()")
            elif ref_inner is not None:
                # &T or &mut T — create a local variable
                init = seq_init(ref_inner, ctr)
                is_mut = ptype.strip().startswith("&mut")
                mut_kw = "mut " if is_mut else ""
                lines.append(f"        let {mut_kw}ref_{pname} = {init};")
                ref_kw = "&mut " if is_mut else "&"
                call_args.append(f"{ref_kw}ref_{pname}")
            else:
                # Gather/scatter: zeroed SIMD for index/offset params (all read from base+0)
                if is_gather:
                    init = ZERO_SIMD_INITS.get(ptype, FIXED_INITS.get(ptype, f"0 /* {ptype} */"))
                else:
                    init = seq_init(ptype, ctr)
                lines.append(f"        let {pname} = {init};")
                call_args.append(pname)
        call = f"{name}{cs}({', '.join(call_args)})"
        emit_check(lines, call, ret, expected)
    else:
        call_args = [seq_init(pt, ctr) for _, pt in params]
        call = f"{name}{cs}({', '.join(call_args)})"
        emit_check(lines, call, ret, expected)

    # Fuzzing block (still inside the single unsafe {})
    if not no_fuzz and complete:
        lines.append("")
        lines.append("        if crate::get_fuzzing() {")
        lines.append("            log::info!(\"Starting fuzzing\");")
        lines.append("            let total_iters = crate::cpu::get_iterations();")
        lines.append("            for i in 0..total_iters {")
        lines.append("                if i % 1000 == 0 && crate::cpu::should_stop() {")
        lines.append("                    log::info!(\"Fuzzing stopped at iteration {}\", i);")
        lines.append("                    break;")
        lines.append("                }")

        fuzz_args = [arg_expr(pt, random=True) for _, pt in params
                     if "*" not in pt and not pt.startswith("&")]
        fuzz_call = f"{name}{cs}({', '.join(fuzz_args)})"
        lines.append(f"                let _ = {fuzz_call};")
        lines.append("            }")
        lines.append("        }")

    lines += ["    }", "    Ok(())", "}"]
    return "\n".join(lines)


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

    # Map architecture names to their std::arch module names
    arch_map = {
        "x86_64": "std::arch::x86_64",
        "arm": "std::arch::arm",
        "aarch64": "std::arch::aarch64",
        "riscv32": "std::arch::riscv32",
        "riscv64": "std::arch::riscv64",
        "riscv_shared": "std::arch::riscv64",  # Use riscv64 as fallback
        "arm_shared": "std::arch::arm",  # Use arm as fallback
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


def get_common_helper(arch: str) -> str:
    """Return the path to common helper module for architecture."""
    if arch in ("x86", "x86_64"):
        return "crate::cpu::common::x86"
    elif arch in ("arm", "aarch64", "arm_shared"):
        return "crate::cpu::common::arm"
    # For other architectures, use a fallback (they'll need helpers created)
    return "crate::cpu::common::arm"  # Generic fallback


def gen_part(funcs: list[dict], arch: str, ext: str, expected_values: dict[str, str] | None = None) -> str:
    arch_import = get_arch_import(arch)
    common_helper = get_common_helper(arch)

    header = [
        arch_import,
        "",
        "#[allow(unused_imports)]",
        f"use {common_helper}::*;",
        "#[allow(unused_imports)]",
        "use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};",
        "",
    ]
    bodies = [gen_fn(sig, expected_values) for sig in funcs]
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
        tname = test_name(sig["name"])
        lines.append(f"            (&{tname}, \"{tname}\"),")
    lines += ["        ]", "    }", "}"]
    return "\n".join(lines) + "\n"


def get_target_arch_cfg(arch: str) -> str:
    """Return the target_arch cfg expression for the given architecture."""
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
        # nvptx is not a standard rust target_arch, skip it
        return 'all() /* nvptx not supported */'
    return f"target_arch = \"{arch}\""


def gen_mod_rs_for_arch(exts: list[tuple[str, str]]) -> str:
    """Generate mod.rs for a single architecture directory."""
    lines = []
    for ext, feature in exts:
        # Only add cfg if feature is supported
        if feature and feature not in UNSUPPORTED_FEATURES:
            lines.append(f"#[cfg(target_feature = \"{feature}\")]")
        lines.append(f"pub mod {ext};")
        # Add blank line only if we added cfg
        if feature and feature not in UNSUPPORTED_FEATURES:
            lines.append("")
    return "\n".join(lines)


def gen_root_mod_rs(archs: list[str]) -> str:
    """Generate root mod.rs for auto_generated/ directory."""
    lines = []
    for arch in sorted(archs):
        cfg = get_target_arch_cfg(arch)
        lines.append(f"#[cfg({cfg})]")
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

    if arch in ("x86", "x86_64"):
        return f'std::arch::is_x86_feature_detected!("{feature}")'
    # For other architectures, we'll need to add detection when available
    # For now, return a placeholder that always returns false
    return "false /* feature detection not yet implemented */"


def gen_registry_rs(all_data: dict[str, dict[str, list[dict]]]) -> str:
    """Generate registry.rs with count_available_features, test_all_extensions, and available_modes."""
    lines = [
        "#![allow(unused_imports)]",
        "#![allow(unreachable_code)]",
        "",
        "use crate::cpu::{ExtensionTest, FeatureStats, TestStatistics, ProgressCallback};",
        "use crate::cpu::{reset_stop_flag, should_stop};",
        "",
        "/// Count how many CPU features/extensions are available on this machine",
        "pub fn count_available_features() -> usize {",
        "    let mut count = 0;",
        "",
    ]

    # Group by architecture
    for arch in sorted(all_data.keys()):
        arch_cfg = get_target_arch_cfg(arch)
        lines.append(f"    #[cfg({arch_cfg})]")
        lines.append("    {")

        for ext, funcs in sorted(all_data[arch].items()):
            # Skip extensions that shouldn't be generated
            if ext in SKIP_EXTENSIONS:
                continue
            if not funcs:
                continue

            feature = ext_to_feature(ext)
            # Only add cfg if feature is supported
            if feature not in UNSUPPORTED_FEATURES:
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
        "pub fn available_modes() -> Vec<&'static str> {",
        "    let mut modes = Vec::new();",
        "",
    ]

    # Generate available_modes
    for arch in sorted(all_data.keys()):
        arch_cfg = get_target_arch_cfg(arch)
        lines.append(f"    #[cfg({arch_cfg})]")
        lines.append("    {")

        for ext, funcs in sorted(all_data[arch].items()):
            # Skip extensions that shouldn't be generated
            if ext in SKIP_EXTENSIONS:
                continue
            if not funcs:
                continue

            feature = ext_to_feature(ext)
            # Only add cfg if feature is supported
            if feature not in UNSUPPORTED_FEATURES:
                lines.append(f"        #[cfg(target_feature = \"{feature}\")]")
            detect_fn = get_feature_detect_fn(arch, feature)
            lines.append(f"        if {detect_fn} {{")
            lines.append(f'            modes.push("{feature}");')
            lines.append("        }")

        lines.append("    }")
        lines.append("")

    lines += [
        "    modes",
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
        lines.append(f"    #[cfg({arch_cfg})]")
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
            if feature not in UNSUPPORTED_FEATURES:
                lines.append(f"        #[cfg(target_feature = \"{feature}\")]")
                lines.append("        {")

            detect_fn = get_feature_detect_fn(arch, feature)
            lines.append(f"            if {detect_fn} {{")
            lines.append("                if should_stop() {")
            lines.append("                    return Ok(TestStatistics { features, was_cancelled: true });")
            lines.append("                }")
            lines.append(f"                let (r, s, e) = crate::cpu::auto_generated::{arch}::{ext}::{struct}::test_with_progress(")
            lines.append("                    total_features,")
            lines.append("                    completed_features,")
            lines.append(f"                    crate::cpu::auto_generated::{arch}::{ext}::{struct}::get_tests().len(),")
            lines.append("                    progress_callback,")
            lines.append("                )?;")
            lines.append("                features.push(FeatureStats {")
            lines.append(f"                    feature_name: crate::cpu::auto_generated::{arch}::{ext}::{struct}::get_name(),")
            lines.append("                    tests_run: r,")
            lines.append("                    tests_skipped: s,")
            lines.append("                    tests_errored: e,")
            lines.append("                });")
            lines.append("                completed_features += 1;")
            lines.append("            }")
            # Close the cfg block if we opened it
            if feature not in UNSUPPORTED_FEATURES:
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
        lines.append(f"    #[cfg({arch_cfg})]")
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
            if feature not in UNSUPPORTED_FEATURES:
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
    ]

    return "\n".join(lines) + "\n"


def main() -> None:
    global IGNORED_FUNCTIONS
    base = Path.cwd()

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
                      and (arch != "x86" or s["name"] not in X86_INCOMPATIBLE_FUNCTIONS)]
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
        (arch_out / "mod.rs").write_text(gen_mod_rs_for_arch(generated_exts))
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
