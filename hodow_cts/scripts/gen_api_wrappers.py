#!/usr/bin/env python3
"""Generate the GL and EGL entry-point wrappers from VK-GL-CTS's own .inl files.

Upstream generates `framework/opengl/wrapper/glw*.inl` and
`framework/egl/wrapper/eglw*.inl` from the Khronos registry XML (gl.xml, egl.xml) and
commits the result. This reads those committed .inl files - the same inputs its C++
compiles - and emits the Rust equivalents:

    src/generated/glw.rs    types, GL_* constants, glw::Functions and its loaders
    src/generated/eglw.rs   the same for EGL

Reading the .inl rather than the XML is deliberate. It is the set of entry points
upstream actually declares, per API version, already filtered; and if a re-sync moves
upstream to a newer registry, this follows in one step with everything else.

Nothing about this is a build dependency: the output is committed and a plain
`cargo build` never runs it. It is only needed when re-syncing with upstream.

Usage:
    python3 hodow_cts/scripts/gen_api_wrappers.py [--cts-dir tmp/VK-GL-CTS] [--check]
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
GENERATED_DIR = CRATE_DIR / "src" / "generated"

# Rust keywords that turn up as parameter names in the registry.
RUST_KEYWORDS = {"type", "ref", "box", "fn", "in", "match", "struct", "as", "if", "loop", "mut", "const", "move", "impl", "where", "self"}

# The base typedefs, transcribed from glwTypes.inl / eglwTypes.inl. Kept as a table
# rather than parsed: those two files are the only hand-written .inl upstream has, and
# a #if picks GLintptr's width. `verify_typedefs` fails if upstream grows one this does
# not know about, so the table cannot silently fall behind.
GL_TYPES: dict[str, str] = {
    "GLbyte": "i8",
    "GLshort": "i16",
    "GLint": "i32",
    "GLint64": "i64",
    "GLubyte": "u8",
    "GLushort": "u16",
    "GLuint": "u32",
    "GLuint64": "u64",
    "GLhalf": "u16",
    "GLfloat": "f32",
    "GLclampf": "f32",
    "GLdouble": "f64",
    "GLclampd": "f64",
    "GLchar": "c_char",
    "GLboolean": "u8",
    "GLenum": "u32",
    "GLbitfield": "u32",
    "GLsizei": "i32",
    "GLfixed": "i32",
    # `signed long int` on every target this builds for, which is isize either way.
    "GLintptr": "isize",
    "GLsizeiptr": "isize",
    "GLsync": "*mut c_void",
    "GLeglImageOES": "*mut c_void",
}

EGL_TYPES: dict[str, str] = {
    "EGLint": "i32",
    "EGLenum": "u32",
    "EGLBoolean": "u32",
    "EGLAttrib": "isize",
    "EGLTime": "u64",
    "EGLDisplay": "*mut c_void",
    "EGLConfig": "*mut c_void",
    "EGLSurface": "*mut c_void",
    "EGLContext": "*mut c_void",
    "EGLImage": "*mut c_void",
    "EGLClientBuffer": "*mut c_void",
    "EGLSync": "*mut c_void",
    "EGLNativeDisplayType": "*mut c_void",
    "EGLNativeWindowType": "*mut c_void",
    "EGLNativePixmapType": "*mut c_void",
    "EGLImageKHR": "EGLImage",
    "EGLSyncKHR": "EGLSync",
    "EGLTimeKHR": "EGLTime",
}

# Function-pointer typedefs, which cannot be expressed by the table above.
GL_FN_TYPES = {
    "GLDEBUGPROC": 'Option<unsafe extern "C" fn(source: GLenum, gltype: GLenum, id: GLuint, severity: GLenum, length: GLsizei, message: *const GLchar, user_param: *const c_void)>',
}
EGL_FN_TYPES = {
    "__eglMustCastToProperFunctionPointerType": 'Option<unsafe extern "C" fn()>',
}

# `void` under another name: mapped by rust_type directly, since a bare one is a Rust
# `()` return while a pointer to one is `c_void`.
VOID_ALIASES = {"GLvoid"}

# Plain C types a signature can name directly - `eglQueryString` returns `const char *`.
# Mapped but never emitted as an alias, unlike the tables above.
C_PRIMITIVES = {"char": "c_char"}

TYPEDEF_RE = re.compile(r"^\s*typedef\s+(?P<base>.+?)\s+(?P<name>[A-Za-z_][A-Za-z0-9_]*)\s*;", re.MULTILINE)
FUNC_TYPEDEF_RE = re.compile(
    r"typedef\s+\w+_APICALL\s+(?P<ret>[\w\s\*]*?)\s*\(\s*\w+_APIENTRY\s*\*\s*(?P<name>\w+?)Func\s*\)\s*\((?P<params>[^)]*)\)\s*;",
    re.MULTILINE,
)
ENUM_RE = re.compile(r"^#define\s+(?P<name>[A-Za-z_][A-Za-z0-9_]*)\s+(?P<value>\S.*?)\s*$", re.MULTILINE)
INIT_RE = re.compile(r'^\s*\w+->\w+\s*=\s*\(\s*(?P<fn>\w+?)Func\s*\)\s*\w+->get\("(?P<symbol>\w+)"\)\s*;')
# The extension init files wrap each block in a check against the driver's extension
# string list, and load the suffixed symbol (glBlendBarrierKHR) into the core field.
EXT_GUARD_RE = re.compile(r'^\s*if \(de::contains\(extSet, "(?P<extension>[\w]+)"\)\)')


class Api:
    """Everything that differs between the GL and the EGL wrapper."""

    def __init__(self, name: str, prefix: str, wrapper_dir: Path, types: dict[str, str], fn_types: dict[str, str], loaders: dict[str, str]):
        self.name = name
        self.prefix = prefix
        self.wrapper_dir = wrapper_dir
        self.types = types
        self.fn_types = fn_types
        self.loaders = loaders


def camel_to_snake(name: str) -> str:
    """glTexImage2D -> tex_image_2d, eglGetPlatformDisplayEXT -> get_platform_display_ext.

    A digit run starts a new word (`Image2D` -> `image_2d`) and a run of capitals stays
    one (`...EXT` -> `_ext`), which keeps every name recognisable from its GL spelling.
    """
    out: list[str] = []
    for i, ch in enumerate(name):
        prev = name[i - 1] if i else ""
        if ch.isupper() and prev and (prev.islower() or (prev.isupper() and i + 1 < len(name) and name[i + 1].islower())):
            out.append("_")
        elif ch.isdigit() and prev and prev.isalpha():
            out.append("_")
        out.append(ch.lower())
    return "".join(out).strip("_")


def rust_ident(name: str) -> str:
    name = camel_to_snake(name) if name else "arg"
    return f"{name}_" if name in RUST_KEYWORDS else name


def rust_type(ctype: str, api: Api, *, is_return: bool) -> str:
    """Maps one C declaration's type onto Rust, pointers included."""
    tokens = ctype.replace("*", " * ").split()
    leading_const = False
    base: str | None = None
    rest: list[str] = []

    for token in tokens:
        if token == "const":
            if base is None:
                leading_const = True
            else:
                rest.append("const")
        elif token == "*":
            rest.append("*")
        elif token in ("struct", "unsigned", "signed"):
            continue
        else:
            base = token

    if base is None:
        raise SystemExit(f"cannot parse type {ctype!r}")

    pointers = rest.count("*")

    if base in ("void", "GLvoid"):
        if pointers == 0:
            return "()" if is_return else "()"
        inner = "c_void"
    elif base in api.fn_types:
        if pointers:
            raise SystemExit(f"pointer to function type not supported: {ctype!r}")
        return base
    elif base in api.types:
        inner = base
    elif base in C_PRIMITIVES:
        inner = C_PRIMITIVES[base]
    else:
        raise SystemExit(f"unmapped {api.name} type {base!r} in {ctype!r}")

    result = inner
    pending_const = leading_const
    for token in rest:
        if token == "*":
            result = f"*const {result}" if pending_const else f"*mut {result}"
            pending_const = False
        elif token == "const":
            pending_const = True
    return result


def parse_params(text: str, api: Api) -> list[tuple[str, str]]:
    text = text.strip()
    if text in ("", "void"):
        return []
    params: list[tuple[str, str]] = []
    for index, raw in enumerate(text.split(",")):
        raw = raw.strip()
        m = re.match(r"^(?P<type>.*?)(?P<name>[A-Za-z_][A-Za-z0-9_]*)$", raw)
        if m and m.group("type").strip():
            ctype, name = m.group("type"), m.group("name")
        else:
            ctype, name = raw, f"arg{index}"
        params.append((rust_ident(name), rust_type(ctype, api, is_return=False)))
    return params


def parse_functions(api: Api) -> dict[str, tuple[str, list[tuple[str, str]]]]:
    text = (api.wrapper_dir / f"{api.prefix}FunctionTypes.inl").read_text()
    functions: dict[str, tuple[str, list[tuple[str, str]]]] = {}
    for m in FUNC_TYPEDEF_RE.finditer(text):
        name = m.group("name")
        ret = rust_type(m.group("ret"), api, is_return=True)
        functions[name] = (ret, parse_params(m.group("params"), api))
    if not functions:
        raise SystemExit(f"parsed no functions out of {api.prefix}FunctionTypes.inl")
    return functions


def parse_enums(api: Api) -> list[tuple[str, str, str]]:
    """Returns (name, rust type, rust literal)."""
    text = (api.wrapper_dir / f"{api.prefix}Enums.inl").read_text()
    out: list[tuple[str, str, str]] = []
    seen: set[str] = set()
    for m in ENUM_RE.finditer(text):
        name, value = m.group("name"), m.group("value").strip()
        if name in seen:
            continue
        seen.add(name)

        cast = re.match(r"^\(\(\s*\w+::(?P<type>\w+)\s*\)\s*(?P<value>-?\w+)\s*\)$", value)
        if cast:
            ctype, literal = cast.group("type"), cast.group("value")
            # EGLImageKHR aliases EGLImage aliases *mut c_void, so follow the chain.
            resolved = ctype
            while resolved in api.types and api.types[resolved] in api.types:
                resolved = api.types[resolved]
            if api.types.get(resolved, "").startswith("*"):
                # EGL_NO_CONTEXT and friends: a null handle, not a number.
                if literal != "0":
                    raise SystemExit(f"{name}: unexpected handle value {literal}")
                out.append((name, ctype, "std::ptr::null_mut()"))
            else:
                out.append((name, ctype, literal))
            continue

        plain = re.match(r"^(?P<value>0[xX][0-9A-Fa-f]+|\d+)(?P<suffix>[uUlL]*)$", value)
        if not plain:
            raise SystemExit(f"{name}: cannot parse value {value!r}")
        number = int(plain.group("value"), 0)
        out.append((name, "u64" if number > 0xFFFFFFFF else "u32", plain.group("value")))
    return out


def parse_loader(api: Api, filename: str) -> list[tuple[str, str, str | None]]:
    """Returns (typedef name, symbol to look up, extension that must be present)."""
    entries: list[tuple[str, str, str | None]] = []
    extension: str | None = None
    for line in (api.wrapper_dir / filename).read_text().splitlines():
        guard = EXT_GUARD_RE.match(line)
        if guard:
            extension = guard.group("extension")
            continue
        if line.strip() == "}":
            extension = None
            continue
        m = INIT_RE.match(line)
        if m:
            entries.append((m.group("fn"), m.group("symbol"), extension))
    if not entries:
        raise SystemExit(f"parsed no entry points out of {filename}")
    return entries


def verify_typedefs(api: Api) -> None:
    """Fails if upstream's hand-written types .inl has grown a type this does not map."""
    text = (api.wrapper_dir / f"{api.prefix}Types.inl").read_text()
    known = set(api.types) | set(api.fn_types) | VOID_ALIASES
    for m in TYPEDEF_RE.finditer(text):
        name = m.group("name")
        if name not in known:
            raise SystemExit(f"{api.prefix}Types.inl declares {name!r}, which gen_api_wrappers.py does not map - add it to the table")


def emit(api: Api, upstream_revision: str) -> str:
    verify_typedefs(api)
    functions = parse_functions(api)
    enums = parse_enums(api)

    lines: list[str] = []
    w = lines.append

    w(f"// @generated by hodow_cts/scripts/gen_api_wrappers.py from VK-GL-CTS {api.prefix}*.inl - do not hand-edit.")
    w("//")
    w("// Regenerate with:")
    w("//     python3 hodow_cts/scripts/gen_api_wrappers.py --cts-dir <VK-GL-CTS checkout>")
    w("//")
    w(f"// Upstream revision: {upstream_revision}")
    w("//")
    w("// SPDX-License-Identifier: Apache-2.0")
    w("// Derived from VK-GL-CTS, Copyright (c) The Khronos Group Inc. and others.")
    w("")
    w("#![allow(clippy::too_many_arguments, clippy::missing_safety_doc, non_snake_case, non_camel_case_types, non_upper_case_globals)]")
    w("")
    if any(extension for loader in api.loaders.values() for _, _, extension in parse_loader(api, loader)):
        w("use std::collections::BTreeSet;")
    w("use std::ffi::{c_char, c_void};")
    w("")
    w("// Base types, transcribed from upstream's hand-written types .inl.")
    for name, mapped in api.types.items():
        w(f"pub type {name} = {mapped};")
    for name, mapped in api.fn_types.items():
        w(f"pub type {name} = {mapped};")
    w("")
    w("// Enumerants. Every one the registry declares is here, whatever API version it")
    w("// belongs to, because a test that queries an unsupported enum still has to name it.")
    for name, ctype, literal in enums:
        w(f"pub const {name}: {ctype} = {literal};")
    w("")
    w("// One function-pointer type per entry point.")
    for name in sorted(functions):
        ret, params = functions[name]
        args = ", ".join(f"{pname}: {ptype}" for pname, ptype in params)
        suffix = "" if ret == "()" else f" -> {ret}"
        w(f'pub type Pfn{name[0].upper()}{name[1:]} = unsafe extern "C" fn({args}){suffix};')
    w("")

    w("/// The loaded entry-point table - upstream's `glw::Functions` / `eglw::Library`.")
    w("///")
    w("/// A field is `None` when the driver does not export that entry point, which is")
    w("/// the normal state for most of them: this one table covers every API version and")
    w("/// extension the registry declares, and a loader fills in only its own set.")
    w("///")
    w("/// Each field has a same-named method that calls it, so a call site reads")
    w("/// `gl.bind_buffer(...)` exactly as the C++ reads `gl.bindBuffer(...)`. The method")
    w("/// panics if the entry point was never loaded - that is a bug in the port (a test")
    w("/// that did not check for the extension it needs), not a driver defect, and it has")
    w("/// to be loud rather than a null call.")
    w("#[derive(Default)]")
    w("pub struct Functions {")
    for name in sorted(functions):
        w(f"    pub {rust_ident(name[len(api.name):])}: Option<Pfn{name[0].upper()}{name[1:]}>,")
    w("}")
    w("")

    w("impl Functions {")
    for loader_name, filename in api.loaders.items():
        wanted = parse_loader(api, filename)
        missing = [n for n, _, _ in wanted if n not in functions]
        if missing:
            raise SystemExit(f"{filename} loads {missing[:3]}, which have no typedef")
        guarded = any(extension for _, _, extension in wanted)
        w(f"    /// Upstream `{filename}`.")
        if guarded:
            w("    ///")
            w("    /// Each block is gated on the extension string upstream gates it on, so an")
            w("    /// entry point only becomes callable once the driver has advertised it.")
            w(f"    pub fn {loader_name}(&mut self, extensions: &BTreeSet<String>, get: &mut dyn FnMut(&str) -> *const c_void) {{")
        else:
            w(f"    pub fn {loader_name}(&mut self, get: &mut dyn FnMut(&str) -> *const c_void) {{")
        current: str | None = None
        for name, symbol, extension in wanted:
            if extension != current:
                if current is not None:
                    w("        }")
                if extension is not None:
                    w(f'        if extensions.contains("{extension}") {{')
                current = extension
            indent = "        " if current is None else "            "
            field = rust_ident(name[len(api.name):])
            w(f'{indent}self.{field} = unsafe {{ cast(get("{symbol}")) }};')
        if current is not None:
            w("        }")
        w("    }")
        w("")

    for name in sorted(functions):
        ret, params = functions[name]
        field = rust_ident(name[len(api.name):])
        args = ", ".join(f"{pname}: {ptype}" for pname, ptype in params)
        call = ", ".join(pname for pname, _ in params)
        suffix = "" if ret == "()" else f" -> {ret}"
        w(f"    /// `{name}`")
        w("    #[inline]")
        w(f"    pub unsafe fn {field}(&self, {args}){suffix} {{".replace("(&self, )", "(&self)"))
        w(f'        unsafe {{ need(self.{field}, "{name}")({call}) }}')
        w("    }")
        w("")
    w("}")
    w("")

    w("/// Turns a `dlsym`/`eglGetProcAddress` result into an optional entry point.")
    w("///")
    w("/// # Safety")
    w("/// `p` must be null or a pointer to a function with `F`'s signature.")
    w("#[inline]")
    w("unsafe fn cast<F>(p: *const c_void) -> Option<F> {")
    w("    if p.is_null() {")
    w("        None")
    w("    } else {")
    w("        // transmute_copy, not transmute: the compiler cannot see that a thin")
    w("        // pointer and a bare `extern fn` pointer are the same size.")
    w("        Some(unsafe { std::mem::transmute_copy(&p) })")
    w("    }")
    w("}")
    w("")
    w("#[inline]")
    w("fn need<F>(f: Option<F>, name: &'static str) -> F {")
    w(f'    f.unwrap_or_else(|| panic!("{api.name}: entry point {{name}} is not loaded - the test did not check for what it needs"))')
    w("}")

    return "\n".join(lines) + "\n"


def rustfmt(text: str) -> str:
    result = subprocess.run(
        ["rustfmt", "--edition", "2024", "--config", "max_width=180", "--emit", "stdout", "--quiet"],
        input=text,
        capture_output=True,
        text=True,
        cwd=CRATE_DIR,
    )
    if result.returncode != 0:
        print(f"warning: rustfmt failed, emitting unformatted output:\n{result.stderr}", file=sys.stderr)
        return text
    return result.stdout


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cts-dir", type=Path, default=CRATE_DIR.parent / "tmp" / "VK-GL-CTS", help="VK-GL-CTS checkout to read the .inl files from")
    ap.add_argument("--check", action="store_true", help="fail if the generated output would change")
    args = ap.parse_args()

    if not (args.cts_dir / "framework" / "opengl" / "wrapper").is_dir():
        print(f"error: {args.cts_dir} does not look like a VK-GL-CTS checkout", file=sys.stderr)
        return 1

    revision = (CRATE_DIR / "upstream" / "COMMIT").read_text().strip()

    apis = [
        Api(
            name="gl",
            prefix="glw",
            wrapper_dir=args.cts_dir / "framework" / "opengl" / "wrapper",
            types=GL_TYPES,
            fn_types=GL_FN_TYPES,
            loaders={
                "load_es20": "glwInitES20.inl",
                "load_es30": "glwInitES30.inl",
                "load_es31": "glwInitES31.inl",
                "load_es32": "glwInitES32.inl",
                "load_ext_es": "glwInitExtES.inl",
                "load_ext_gl": "glwInitExtGL.inl",
            },
        ),
        Api(
            name="egl",
            prefix="eglw",
            wrapper_dir=args.cts_dir / "framework" / "egl" / "wrapper",
            types=EGL_TYPES,
            fn_types=EGL_FN_TYPES,
            loaders={
                "load_core": "eglwInitCore.inl",
                "load_extensions": "eglwInitExtensions.inl",
            },
        ),
    ]

    files = {GENERATED_DIR / f"{api.prefix}.rs": rustfmt(emit(api, revision)) for api in apis}

    if args.check:
        stale = [p for p, text in files.items() if not p.exists() or p.read_text() != text]
        if stale:
            print("error: generated API wrappers are stale; re-run gen_api_wrappers.py", file=sys.stderr)
            for path in stale:
                print(f"  {path.relative_to(CRATE_DIR)}", file=sys.stderr)
            return 1
        print("generated API wrappers are up to date")
        return 0

    for path, text in files.items():
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text)
        print(f"wrote {path.relative_to(CRATE_DIR)} ({len(text.splitlines())} lines)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
