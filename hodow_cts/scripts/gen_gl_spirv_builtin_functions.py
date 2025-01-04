#!/usr/bin/env python3
"""Generates the modules of KHR-GL4x.gl_spirv.spirv_glsl_to_spirv_builtin_functions_test.

Upstream builds every shader of SpirvGlslToSpirVBuiltInFunctionsTest::init with glslang at run time, disassembles it and checks
the GLSL built-in -> SPIR-V instruction mappings (spirvUtils::verifyMappings). Here glslang and SPIRV-Tools are developer
tools only, so this script reads the shader list straight out of the upstream C++ (the literals, the replaceToken variants,
the mapping table), compiles each shader with glslangValidator, verifies the mappings on the spirv-dis output exactly as
upstream does, and writes
  shaders/gl_spirv/builtin_functions/<NN>.<ext>        the GLSL (the run-time GLSL half of the test compiles it)
  shaders/gl_spirv/builtin_functions/<NN>_<ext>.spv    the module
  src/khr_gl/gl_spirv_builtin_functions_table.rs       the table the test iterates
Usage: python3 hodow_cts/scripts/gen_gl_spirv_builtin_functions.py [--upstream <gl4cGlSpirvTests.cpp>] [--check]
"""
import argparse
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT_DIR = ROOT / "shaders" / "gl_spirv" / "builtin_functions"
TABLE = ROOT / "src" / "khr_gl" / "gl_spirv_builtin_functions_table.rs"
DEFAULT_CPP = ROOT.parent / "tmp" / "glcts-src" / "external" / "openglcts" / "modules" / "gl" / "gl4cGlSpirvTests.cpp"

KINDS = {
    "Compute": ("comp", "Compute"),
    "Fragment": ("frag", "Fragment"),
    "Geometry": ("geom", "Geometry"),
    "TessellationControl": ("tesc", "TessControl"),
    "Vertex": ("vert", "Vertex"),
    "TessellationEvaluation": ("tese", "TessEvaluation"),
}
LITERAL = re.compile(r'"((?:[^"\\]|\\.)*)"')


def unescape(text):
    return re.sub(r'\\(.)', lambda m: {"n": "\n", "t": "\t", '"': '"', "\\": "\\"}[m.group(1)], text)


def statements(body):
    """Splits C++ text at `;` outside string literals, dropping `//` comments."""
    out, cur, i, in_str = [], [], 0, False
    while i < len(body):
        c = body[i]
        if in_str:
            cur.append(c)
            if c == "\\":
                cur.append(body[i + 1])
                i += 1
            elif c == '"':
                in_str = False
        elif c == '"':
            in_str = True
            cur.append(c)
        elif body.startswith("//", i):
            while i < len(body) and body[i] != "\n":
                i += 1
        elif c == ";":
            out.append("".join(cur).strip())
            cur = []
        else:
            cur.append(c)
        i += 1
    return out


def literals_value(text):
    return "".join(unescape(m) for m in LITERAL.findall(text))


def function_body(cpp, signature):
    start = cpp.index(signature)
    open_brace = cpp.index("{", start)
    depth, i, in_str = 0, open_brace, False
    while True:
        c = cpp[i]
        if in_str:
            if c == "\\":
                i += 1
            elif c == '"':
                in_str = False
        elif c == '"':
            in_str = True
        elif c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return cpp[open_brace + 1:i]
        i += 1


def parse_init(cpp):
    body = function_body(cpp, "void SpirvGlslToSpirVBuiltInFunctionsTest::init()")
    variables, sources = {}, []

    def value(expr):
        expr = expr.strip()
        return variables[expr] if expr in variables else literals_value(expr)

    for stmt in statements(body):
        m = re.match(r"m_sources\.push_back\(\s*(\w+)Source\((.*)\)\s*\)$", stmt, re.S)
        if m:
            sources.append((m.group(1), value(m.group(2))))
            continue
        m = re.match(r'commonUtils::replaceToken\(\s*("(?:[^"\\]|\\.)*")\s*,\s*("(?:[^"\\]|\\.)*")\s*,\s*(\w+)\s*\)$', stmt, re.S)
        if m:
            variables[m.group(3)] = variables[m.group(3)].replace(literals_value(m.group(1)), literals_value(m.group(2)))
            continue
        m = re.match(r"(?:const\s+)?(?:std::string\s+)?(\w+)\s*=\s*(.*)$", stmt, re.S)
        if m and not stmt.startswith("spirvUtils"):
            variables[m.group(1)] = value(m.group(2))
    return variables["m_commonVertex"], variables["m_commonTessEval"], sources


def parse_mappings(cpp):
    body = function_body(cpp, "void SpirvGlslToSpirVBuiltInFunctionsTest::initMappings()")
    body = re.sub(r"//[^\n]*", "", body)
    mappings = {}
    for name, spirv in re.findall(r'm_mappings\["(\w+)"\]\.push_back\("([^"]*)"\);', body):
        mappings.setdefault(f" {name}(", []).append(spirv)
    return mappings


def verify_mappings(glsl, spirv_text, mappings):
    lines = [line.split(" ") for line in spirv_text.split("\n")]
    for glsl_code, variants in mappings.items():
        glsl_count = glsl.count(glsl_code)
        if glsl_count == 0:
            continue
        spirv_count = 0
        for variant in variants:
            codes = variant.split(" ")
            spirv_count += sum(1 for line in lines if all(code in line for code in codes))
        if glsl_count != spirv_count:
            return f"{glsl_code!r}: GLSL {glsl_count}, SPIR-V {spirv_count}"
    return None


def compile_shader(source, ext, out):
    with tempfile.TemporaryDirectory() as tmp:
        src = Path(tmp) / f"s.{ext}"
        src.write_text(source)
        result = subprocess.run(["glslangValidator", "-G", "--target-env", "spirv1.0", "-S", ext, str(src), "-o", str(out)], capture_output=True, text=True)
        if result.returncode != 0:
            sys.exit(f"glslangValidator failed:\n{result.stdout}\n{source}")
    subprocess.run(["spirv-val", "--target-env", "opengl4.5", str(out)], check=True)


def disassemble(module):
    return subprocess.run(["spirv-dis", "--no-header", "--raw-id", str(module)], check=True, capture_output=True, text=True).stdout


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--upstream", type=Path, default=DEFAULT_CPP)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    cpp = args.upstream.read_text()
    common_vertex, common_tess_eval, sources = parse_init(cpp)
    mappings = parse_mappings(cpp)

    files = {"common.vert": ("vert", common_vertex), "common.tese": ("tese", common_tess_eval)}
    table = []
    for index, (kind, source) in enumerate(sources):
        ext, stage = KINDS[kind]
        name = f"{index:02}.{ext}"
        files[name] = (ext, source)
        table.append((name, stage, ext))

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    stale = False
    for name, (ext, source) in files.items():
        stem = name.rsplit(".", 1)[0]
        glsl_path = OUT_DIR / name
        spv_path = OUT_DIR / f"{stem}_{ext}.spv"
        with tempfile.TemporaryDirectory() as tmp:
            fresh = Path(tmp) / "m.spv"
            compile_shader(source, ext, fresh)
            if not name.startswith("common"):
                problem = verify_mappings(source, disassemble(fresh), mappings)
                if problem:
                    sys.exit(f"{name}: mappings for shader failed: {problem}")
            if args.check:
                if not glsl_path.exists() or glsl_path.read_text() != source or not spv_path.exists() or spv_path.read_bytes() != fresh.read_bytes():
                    print(f"stale: {name}", file=sys.stderr)
                    stale = True
            else:
                glsl_path.write_text(source)
                spv_path.write_bytes(fresh.read_bytes())

    lines = [
        "// Generated by hodow_cts/scripts/gen_gl_spirv_builtin_functions.py - do not edit.",
        "",
        "pub(super) struct BuiltinShader {",
        "    pub stage: ShaderType,",
        "    pub glsl: &'static str,",
        "    pub spirv: &'static [u8],",
        "}",
        "",
        'pub(super) const COMMON_VERTEX_GLSL: &str = include_str!("../../shaders/gl_spirv/builtin_functions/common.vert");',
        'pub(super) const COMMON_VERTEX_SPIRV: &[u8] = include_bytes!("../../shaders/gl_spirv/builtin_functions/common_vert.spv");',
        'pub(super) const COMMON_TESS_EVALUATION_GLSL: &str = include_str!("../../shaders/gl_spirv/builtin_functions/common.tese");',
        'pub(super) const COMMON_TESS_EVALUATION_SPIRV: &[u8] = include_bytes!("../../shaders/gl_spirv/builtin_functions/common_tese.spv");',
        "",
        "pub(super) const BUILTIN_SHADERS: &[BuiltinShader] = &[",
    ]
    for name, stage, ext in table:
        stem = name.rsplit(".", 1)[0]
        lines.append(
            f'    BuiltinShader {{ stage: ShaderType::{stage}, glsl: include_str!("../../shaders/gl_spirv/builtin_functions/{name}"), '
            f'spirv: include_bytes!("../../shaders/gl_spirv/builtin_functions/{stem}_{ext}.spv") }},'
        )
    lines.append("];")
    text = lines[0] + "\n\nuse crate::glu::ShaderType;\n" + "\n".join(lines[1:]) + "\n"
    if args.check:
        if not TABLE.exists() or TABLE.read_text() != text:
            print(f"stale: {TABLE}", file=sys.stderr)
            stale = True
        sys.exit(1 if stale else 0)
    TABLE.write_text(text)
    print(f"wrote {len(table)} shaders and {TABLE.name}")


if __name__ == "__main__":
    main()
