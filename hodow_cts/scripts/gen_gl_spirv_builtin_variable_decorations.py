#!/usr/bin/env python3
"""Generates the modules of KHR-GL4x.gl_spirv.spirv_validation_builtin_variable_decorations_test.

Upstream (SpirvValidationBuiltInVariableDecorationsTest::init) builds the shaders of every validation from templates, compiles them
with glslang at run time and checks the BuiltIn decorations in the disassembly (verifyMappings, anyOf). The templates, the
replaceToken substitutions, the validation records and the mapping table are read out of the upstream C++ here, every stage is
compiled with glslangValidator, the mappings are verified on the spirv-dis output, and
  shaders/gl_spirv/builtin_variable_decorations/<V><S>.<ext>, <V><S>_<ext>.spv   (V validation index, S stage index)
  src/khr_gl/gl_spirv_builtin_variable_decorations_table.rs
are written.
Usage: python3 hodow_cts/scripts/gen_gl_spirv_builtin_variable_decorations.py [--upstream <gl4cGlSpirvTests.cpp>] [--check]
"""
import argparse
import importlib.util
import re
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT_DIR = ROOT / "shaders" / "gl_spirv" / "builtin_variable_decorations"
TABLE = ROOT / "src" / "khr_gl" / "gl_spirv_builtin_variable_decorations_table.rs"

spec = importlib.util.spec_from_file_location("builtin_gen", Path(__file__).with_name("gen_gl_spirv_builtin_functions.py"))
base = importlib.util.module_from_spec(spec)
spec.loader.exec_module(base)

FUNCTIONS = {
    "validComputeFunc": "Compute",
    "validPerVertexFragFunc": "PerVertexFrag",
    "validPerVertexPointFunc": "PerVertexPoint",
    "validTesselationGeometryFunc": "TessellationGeometry",
    "validMultiSamplingFunc": "MultiSampling",
}
STRING = r'"(?:[^"\\]|\\.)*"'


def parse(cpp):
    body = base.function_body(cpp, "void SpirvValidationBuiltInVariableDecorationsTest::init()")
    variables, validations, current, mappings, order = {}, {}, [], {}, []

    def value(expr):
        expr = expr.strip()
        m = re.fullmatch(r"(\w+)\.c_str\(\)", expr)
        if m:
            return variables[m.group(1)]
        return variables[expr] if expr in variables else base.literals_value(expr)

    for stmt in base.statements(body):
        m = re.match(r"ValidationStruct\s+(\w+)\(&\w+::(\w+)\)$", stmt)
        if m:
            validations[m.group(1)] = {"func": FUNCTIONS[m.group(2)], "shaders": [], "outputs": []}
            continue
        m = re.match(r"(\w+)\.shaders\.push_back\((\w+)Source\((.*)\)\)$", stmt, re.S)
        if m:
            validations[m.group(1)]["shaders"].append((m.group(2), value(m.group(3))))
            continue
        m = re.match(r"(\w+)\.outputs\.push_back\(ValidationOutputStruct\(([^)]*)\)\)$", stmt)
        if m:
            args = [int(a, 0) for a in m.group(2).split(",")]
            x, y, z, color = (args[0], args[1], 0, args[2]) if len(args) == 3 else args
            validations[m.group(1)]["outputs"].append((x, y, z, color))
            continue
        m = re.match(r"m_validations\.push_back\((\w+)\)$", stmt)
        if m:
            order.append(validations[m.group(1)])
            continue
        m = re.match(rf'commonUtils::replaceToken\(\s*({STRING})\s*,\s*({STRING}|\w+\.c_str\(\))\s*,\s*(\w+)\s*\)$', stmt, re.S)
        if m:
            variables[m.group(3)] = variables[m.group(3)].replace(base.literals_value(m.group(1)), value(m.group(2)))
            continue
        m = re.match(r'm_mappings\["(\w+)"\]\.push_back\("([^"]*)"\)$', stmt)
        if m:
            mappings.setdefault(m.group(1), []).append(m.group(2))
            continue
        m = re.match(r"(?:const\s+)?(?:std::string\s+)?(\w+)\s*=\s*(.*)$", stmt, re.S)
        if m and not stmt.startswith("spirvUtils"):
            variables[m.group(1)] = value(m.group(2))
    return order, mappings


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--upstream", type=Path, default=base.DEFAULT_CPP)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    validations, mappings = parse(args.upstream.read_text())
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    stale = False
    rows = []
    for v, validation in enumerate(validations):
        stages = []
        for s, (kind, source) in enumerate(validation["shaders"]):
            ext, stage = base.KINDS[kind]
            stem = f"{v}{s}"
            glsl_path, spv_path = OUT_DIR / f"{stem}.{ext}", OUT_DIR / f"{stem}_{ext}.spv"
            with tempfile.TemporaryDirectory() as tmp:
                fresh = Path(tmp) / "m.spv"
                base.compile_shader(source, ext, fresh)
                glsl_hit = {key: vals for key, vals in mappings.items()}
                text = base.disassemble(fresh)
                for key, variants in glsl_hit.items():
                    if key in source and not any(all(code in line.split(" ") for code in variant.split(" ")) for variant in variants for line in text.split("\n")):
                        sys.exit(f"validation {v} stage {s}: mappings for shader failed: {key}")
                if args.check:
                    if not glsl_path.exists() or glsl_path.read_text() != source or not spv_path.exists() or spv_path.read_bytes() != fresh.read_bytes():
                        print(f"stale: {stem}", file=sys.stderr)
                        stale = True
                else:
                    glsl_path.write_text(source)
                    spv_path.write_bytes(fresh.read_bytes())
            stages.append(
                f'            ValidationStage {{ stage: ShaderType::{stage}, glsl: include_str!("../../shaders/gl_spirv/builtin_variable_decorations/{stem}.{ext}"), '
                f'spirv: include_bytes!("../../shaders/gl_spirv/builtin_variable_decorations/{stem}_{ext}.spv") }},'
            )
        outputs = "".join(f"            ValidationOutput {{ x: {x}, y: {y}, z: {z}, value: 0x{color:08X} }},\n" for x, y, z, color in validation["outputs"])
        rows.append(
            f"    Validation {{\n        function: ValidationFunction::{validation['func']},\n        stages: &[\n" + "\n".join(stages) +
            f"\n        ],\n        outputs: &[\n{outputs}        ],\n    }},"
        )

    text = (
        "// Generated by hodow_cts/scripts/gen_gl_spirv_builtin_variable_decorations.py - do not edit.\n\n"
        "use crate::glu::ShaderType;\n\n"
        "pub(super) enum ValidationFunction {\n    Compute,\n    PerVertexFrag,\n    PerVertexPoint,\n    TessellationGeometry,\n    MultiSampling,\n}\n\n"
        "pub(super) struct ValidationStage {\n    pub stage: ShaderType,\n    pub glsl: &'static str,\n    pub spirv: &'static [u8],\n}\n\n"
        "pub(super) struct ValidationOutput {\n    pub x: u32,\n    pub y: u32,\n    pub z: u32,\n    pub value: u32,\n}\n\n"
        "pub(super) struct Validation {\n    pub function: ValidationFunction,\n    pub stages: &'static [ValidationStage],\n    pub outputs: &'static [ValidationOutput],\n}\n\n"
        "pub(super) const VALIDATIONS: &[Validation] = &[\n" + "\n".join(rows) + "\n];\n"
    )
    if args.check:
        if not TABLE.exists() or TABLE.read_text() != text:
            print(f"stale: {TABLE}", file=sys.stderr)
            stale = True
        sys.exit(1 if stale else 0)
    TABLE.write_text(text)
    print(f"wrote {len(validations)} validations and {TABLE.name}")


if __name__ == "__main__":
    main()
