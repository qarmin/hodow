#!/usr/bin/env python3
"""
Generates Rust SIMD test stubs from TODO.txt and TODO_AVX.txt.
Outputs to src/cpu/auto_generated/
"""

import re
from pathlib import Path
from collections import defaultdict

FUNCTIONS_PER_PART = 30
OUTPUT_DIR = Path("src/cpu/auto_generated")

# Function name patterns for which fuzzing is disabled
NO_FUZZ_PATTERNS = [
    "gather",   # memory scatter/gather with random indices causes segfault
    "scatter",
]

# Extension stem → Rust target_feature string (only where they differ)
FEATURE_FLAGS = {
    "sse41": "sse4.1",
    "sse42": "sse4.2",
    "bmi":   "bmi1",   # x86_64/bmi.rs is bmi1 intrinsics
    "test":  "sse2",   # x86/test.rs contains SSE2-level helpers
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
}

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

def source_to_ext(src_path: str) -> str:
    """Derive module name from TODO source path (strips directory, drops .rs)."""
    return Path(src_path).stem


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


def parse_todo(path: Path) -> dict[str, list[dict]]:
    """Parse a TODO file → {ext: [sig, ...]}"""
    result: dict[str, list[dict]] = defaultdict(list)
    current_ext: str | None = None
    seen: set[tuple[str, str]] = set()

    for line in path.read_text().splitlines():
        line = line.rstrip()
        if not line:
            continue
        if re.match(r"^src/", line):
            current_ext = source_to_ext(line)
            continue
        if current_ext is None:
            continue
        m = re.match(r"^\d+:(pub\s+(?:unsafe\s+)?fn\s+.+)", line)
        if not m:
            continue
        sig = parse_sig(m.group(1))
        if sig is None:
            continue
        key = (current_ext, sig["name"])
        if key in seen:
            continue
        seen.add(key)
        result[current_ext].append(sig)

    return result


# ---------------------------------------------------------------------------
# Code generation
# ---------------------------------------------------------------------------

def has_ptr(params: list | None) -> bool:
    return bool(params and any("*" in pt for _, pt in params))


def skip_fuzz(name: str, params: list | None) -> bool:
    lower = name.lower()
    return any(p in lower for p in NO_FUZZ_PATTERNS) or has_ptr(params)


def const_suffix(cg: list) -> str:
    return f"::<{', '.join('0' for _ in cg)}>" if cg else ""


def arg_expr(ptype: str, *, random: bool) -> str:
    """Expression to pass for a parameter of the given type."""
    pt = ptype.strip()
    if "*" in pt:
        return "__ptr__"  # placeholder; handled by caller
    table = RANDOM_CREATORS if random else FIXED_INITS
    return table.get(pt, f"0 /* {pt} */")


def emit_check(lines: list[str], call: str, ret: str) -> None:
    """Append lines that call `call` and check its result."""
    if ret in UNPACK_INFO:
        fn, size, zero = UNPACK_INFO[ret]
        lines.append(f"        let result = {fn}({call});")
        lines.append(f"        check_array_equality(&result, &[{zero}; {size}])?;")
    elif ret in INT_RETURNS:
        lines.append(f"        let result = {call};")
        lines.append(f"        check_int_equality(result as i32, 0)?;")
    elif ret in ("()", ""):
        lines.append(f"        {call};")
    else:
        # f16, bf16, __m128h, etc. – compile but don't check (stub)
        lines.append(f"        let _result = {call};")


def test_name(func_name: str) -> str:
    """test_ + strip leading underscores: _mm_add → test_mm_add"""
    return "test_" + func_name.lstrip("_")


def gen_fn(sig: dict) -> str:
    name = sig["name"]
    test = test_name(name)
    params: list = sig["params"] or []
    ret: str = sig["return_type"] or "()"
    cg: list = sig["const_generics"]
    complete: bool = sig["is_complete"]
    cs = const_suffix(cg)
    no_fuzz = skip_fuzz(name, params)

    lines = [f"pub(super) fn {test}() -> Result<(), String> {{", "    unsafe {"]

    if not complete:
        lines.append(f"        todo!(\"{name}\")")
    elif has_ptr(params):
        # Build local buffers for pointer arguments
        call_args: list[str] = []
        for pname, ptype in params:
            if "*const" in ptype:
                inner = ptype.replace("*const", "").strip()
                init = FIXED_INITS.get(inner, f"0 /* {inner} */")
                lines.append(f"        let ptr_{pname} = [{init}; 1];")
                call_args.append(f"ptr_{pname}.as_ptr()")
            elif "*mut" in ptype:
                inner = ptype.replace("*mut", "").strip()
                init = FIXED_INITS.get(inner, f"0 /* {inner} */")
                lines.append(f"        let mut ptr_{pname} = [{init}; 1];")
                call_args.append(f"ptr_{pname}.as_mut_ptr()")
            else:
                init = FIXED_INITS.get(ptype, "0")
                lines.append(f"        let {pname} = {init};")
                call_args.append(pname)
        call = f"{name}{cs}({', '.join(call_args)})"
        emit_check(lines, call, ret)
    else:
        call_args = [arg_expr(pt, random=False) for _, pt in params]
        call = f"{name}{cs}({', '.join(call_args)})"
        emit_check(lines, call, ret)

    # Fuzzing block (still inside the single unsafe {})
    if not no_fuzz and complete:
        lines.append("")
        lines.append("        if crate::get_fuzzing() {")
        lines.append("            log::info!(\"Starting fuzzing\");")
        lines.append("            for _ in 0..crate::cpu::get_iterations() {")
        fuzz_args = [arg_expr(pt, random=True) for _, pt in params if "*" not in pt]
        fuzz_call = f"{name}{cs}({', '.join(fuzz_args)})"
        lines.append(f"                let _ = {fuzz_call};")
        lines.append("            }")
        lines.append("        }")

    lines += ["    }", "    Ok(())", "}"]
    return "\n".join(lines)


def gen_part(funcs: list[dict]) -> str:
    header = [
        "use std::arch::x86_64::*;",
        "",
        "use crate::cpu::common::values::*;",
        "use crate::cpu::common::{check_array_equality, check_int_equality};",
        "",
    ]
    bodies = [gen_fn(sig) for sig in funcs]
    return "\n".join(header) + "\n" + "\n\n".join(bodies) + "\n"


def gen_ext_rs(ext: str, funcs: list[dict], n_parts: int) -> str:
    struct = ext_to_struct(ext)
    lines = []
    for i in range(1, n_parts + 1):
        lines.append(f"mod part{i};")
    lines.append("")
    for i in range(1, n_parts + 1):
        lines.append(f"use crate::cpu::auto_generated::{ext}::part{i}::*;")
    lines += [
        "",
        "use crate::cpu::{ExtensionTest, TestFunction};",
        "",
        f"pub struct {struct};",
        "",
        f"impl ExtensionTest for {struct} {{",
        "    fn get_name() -> &'static str {",
        f"        \"{struct}\"",
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


def gen_mod_rs(exts: list[tuple[str, str]]) -> str:
    lines = []
    for ext, feature in exts:
        arch = "any(target_arch = \"x86\", target_arch = \"x86_64\")"
        lines.append(f"#[cfg(all({arch}, target_feature = \"{feature}\"))]")
        lines.append(f"pub mod {ext};")
        lines.append("")
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    base = Path(__file__).parent.parent

    merged: dict[str, list[dict]] = defaultdict(list)
    seen: set[tuple[str, str]] = set()

    for fname in ("TODO.txt", "TODO_AVX.txt"):
        todo = base / fname
        if not todo.exists():
            print(f"Warning: {todo} not found, skipping")
            continue
        for ext, sigs in parse_todo(todo).items():
            for sig in sigs:
                key = (ext, sig["name"])
                if key not in seen:
                    seen.add(key)
                    merged[ext].append(sig)

    out = base / OUTPUT_DIR
    out.mkdir(parents=True, exist_ok=True)

    generated: list[tuple[str, str]] = []

    for ext in sorted(merged):
        funcs = merged[ext]
        if not funcs:
            continue

        feature = ext_to_feature(ext)
        generated.append((ext, feature))

        parts = [funcs[i:i + FUNCTIONS_PER_PART]
                 for i in range(0, len(funcs), FUNCTIONS_PER_PART)]

        parts_dir = out / ext
        parts_dir.mkdir(exist_ok=True)

        for idx, chunk in enumerate(parts, 1):
            (parts_dir / f"part{idx}.rs").write_text(gen_part(chunk))

        (out / f"{ext}.rs").write_text(gen_ext_rs(ext, funcs, len(parts)))

        incomplete = sum(1 for s in funcs if not s["is_complete"])
        no_fuzz_count = sum(1 for s in funcs
                            if skip_fuzz(s["name"], s["params"]))
        print(f"  {ext:25s}  {len(funcs):4d} funcs  "
              f"{len(parts):2d} parts  "
              f"{incomplete:3d} incomplete  "
              f"{no_fuzz_count:3d} no-fuzz")

    (out / "mod.rs").write_text(gen_mod_rs(generated))
    print(f"\nDone → {out}  ({len(generated)} extensions)")


if __name__ == "__main__":
    main()
