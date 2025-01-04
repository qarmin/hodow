#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Ahead-of-time parser for the Khronos GL CTS shader-library `.test` files.

Upstream (`external/openglcts/modules/common/glcShaderLibrary.cpp`) parses these at run time out of a data archive. This runs the same parse ahead of time and emits the case tree as Rust
statics under `src/generated/khr_shader_library/`, built from the types in `src/khr_gl/shader_library/mod.rs`.

It is NOT `gen_shader_library.py`: the ES library (`framework/opengl/gluShaderLibrary.cpp`) is a different, newer parser with more keywords, and the desktop `ShaderCase` it feeds is an older
design. Everything here mirrors `deqp::sl::ShaderParser` of the Khronos copy, including its quirks (the default GLSL version is ES 1.00, a `both` source expands into `_vertex` and `_fragment`
cases, a `version` that is not in its list is an error). An unrecognised construct raises rather than being dropped.

Usage:
    python3 hodow_cts/scripts/gen_khr_shader_library.py [--cts-dir ../tmp/glcts-src] [--check]
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
OUT_DIR = CRATE_DIR / "src" / "generated" / "khr_shader_library"
INDEX_PATH = CRATE_DIR / "src" / "generated" / "khr_shader_library.rs"

# The files the desktop packages load through `ShaderLibraryGroup` (gl3cTestPackages.cpp, gl4cTestPackages.cpp), under `external/openglcts/data/gl_cts/data/`. `gl42-compat` belongs to the
# KHR-GL42-COMPAT package, which hodow_cts has no root for.
FILES = [
    "gl30/declarations.test",
    "gl33/arrays.test",
    "gl33/declarations.test",
    "gl33/preprocessor.test",
    "gl42/declarations.test",
    "gl44/preprocessor.test",
]

NAMED = {
    "true": "TRUE", "false": "FALSE", "desc": "DESC", "expect": "EXPECT", "group": "GROUP", "case": "CASE", "end": "END", "values": "VALUES", "both": "BOTH", "vertex": "VERTEX",
    "fragment": "FRAGMENT", "uniform": "UNIFORM", "input": "INPUT", "output": "OUTPUT", "version": "VERSION",
}
DATA_TYPES = {
    "float": "Float", "vec2": "FloatVec2", "vec3": "FloatVec3", "vec4": "FloatVec4", "mat2": "FloatMat2", "mat2x3": "FloatMat2x3", "mat2x4": "FloatMat2x4", "mat3x2": "FloatMat3x2",
    "mat3": "FloatMat3", "mat3x4": "FloatMat3x4", "mat4x2": "FloatMat4x2", "mat4x3": "FloatMat4x3", "mat4": "FloatMat4", "int": "Int", "ivec2": "IntVec2", "ivec3": "IntVec3",
    "ivec4": "IntVec4", "uint": "Uint", "uvec2": "UintVec2", "uvec3": "UintVec3", "uvec4": "UintVec4", "bool": "Bool", "bvec2": "BoolVec2", "bvec3": "BoolVec3", "bvec4": "BoolVec4",
}
for _name in DATA_TYPES:
    NAMED[_name] = "TYPE:" + DATA_TYPES[_name]
SCALAR_SIZE = {"Float": 1, "FloatVec2": 2, "FloatVec3": 3, "FloatVec4": 4, "Int": 1, "IntVec2": 2, "IntVec3": 3, "IntVec4": 4, "Uint": 1, "UintVec2": 2, "UintVec3": 3, "UintVec4": 4,
               "Bool": 1, "BoolVec2": 2, "BoolVec3": 3, "BoolVec4": 4, "FloatMat2": 4, "FloatMat2x3": 6, "FloatMat2x4": 8, "FloatMat3x2": 6, "FloatMat3": 9, "FloatMat3x4": 12,
               "FloatMat4x2": 8, "FloatMat4x3": 12, "FloatMat4": 16}
SIMPLE = {"=": "ASSIGN", "+": "PLUS", "-": "MINUS", ",": "COMMA", "|": "VERTICAL_BAR", ";": "SEMI_COLON", "(": "LEFT_PAREN", ")": "RIGHT_PAREN", "[": "LEFT_BRACKET", "]": "RIGHT_BRACKET",
          "{": "LEFT_BRACE", "}": "RIGHT_BRACE"}

# `parseShaderCase`'s version ladder, as the `GlslVersion` variant each maps to.
VERSIONS = {(100, "es"): "Es100", (300, "es"): "Es300", (310, "es"): "Es310", (130, ""): "Glsl130", (140, ""): "Glsl140", (150, ""): "Glsl150", (330, ""): "Glsl330", (400, ""): "Glsl400",
            (410, ""): "Glsl410", (420, ""): "Glsl420", (430, ""): "Glsl430", (440, ""): "Glsl440", (450, ""): "Glsl450"}


def is_ws(c): return c in " \t\r\n"
def is_eol(c): return c in "\r\n"
def is_alpha(c): return c.isascii() and c.isalpha()
def is_num(c): return "0" <= c <= "9"
def is_case_name_char(c): return is_alpha(c) or is_num(c) or c in "_-."


class ParseError(Exception):
    pass


class Value:
    def __init__(self):
        self.storage = ""
        self.data_type = ""
        self.name = ""
        self.array_length = 1
        self.elements: list = []  # ("f", float) / ("i", int)


class Parser:
    def __init__(self, path: Path):
        self.path = path
        # Latin-1 so that every byte is one character: upstream parses bytes, and one source contains a stray 0xA4 that is not UTF-8.
        self.src = path.read_bytes().decode("latin-1")
        self.pos = 0
        self.token = "INVALID"
        self.text = ""
        self.advance()

    def error(self, message: str):
        line = self.src.count("\n", 0, self.pos) + 1
        raise ParseError(f"{self.path.name}:{line}: {message} near '{self.src[self.pos:self.pos + 40]}'")

    def advance(self):
        self.pos += len(self.text)
        self.token, self.text = "INVALID", ""
        s = self.src
        while True:
            while self.pos < len(s) and is_ws(s[self.pos]):
                self.pos += 1
            if self.pos < len(s) and s[self.pos] == "#":
                while self.pos < len(s) and not is_eol(s[self.pos]):
                    self.pos += 1
            else:
                break
        if self.pos >= len(s):
            self.token, self.text = "EOF", ""
            return
        c = s[self.pos]
        if is_alpha(c):
            end = self.pos + 1
            while end < len(s) and is_case_name_char(s[end]):
                end += 1
            self.text = s[self.pos:end]
            self.token = NAMED.get(self.text, "IDENTIFIER")
        elif is_num(c):
            p = self.pos
            while p < len(s) and is_num(s[p]):
                p += 1
            if p < len(s) and s[p] == ".":
                p += 1
                while p < len(s) and is_num(s[p]):
                    p += 1
                if p < len(s) and s[p] in "eE":
                    p += 1
                    if s[p] in "+-":
                        p += 1
                    while is_num(s[p]):
                        p += 1
                self.token = "FLOAT_LITERAL"
            else:
                self.token = "INT_LITERAL"
            self.text = s[self.pos:p]
        elif c == '"' and s[self.pos + 1:self.pos + 2] == '"':
            p = self.pos + 2
            while not (s[p] == '"' and s[p + 1] == '"'):
                p += 2 if s[p] == "\\" else 1
            p += 2
            self.token, self.text = "SHADER_SOURCE", s[self.pos:p]
        elif c in "\"'":
            p = self.pos + 1
            while s[p] != c:
                p += 2 if s[p] == "\\" else 1
            p += 1
            self.token, self.text = "STRING", s[self.pos:p]
        elif c in SIMPLE:
            self.token, self.text = SIMPLE[c], c
        else:
            self.token, self.text = "INVALID", c

    def eat(self, token: str):
        if self.token != token:
            self.error(f"unexpected token '{self.text}', expecting '{token}'")
        self.advance()

    @staticmethod
    def string_literal(text: str) -> str:
        end_char, out, i = text[0], [], 1
        while i < len(text) and text[i] != end_char:
            if text[i] == "\\":
                out.append({"n": "\n", "t": "\t"}.get(text[i + 1], text[i + 1]))
                i += 2
            else:
                out.append(text[i])
                i += 1
        return "".join(out)

    @staticmethod
    def remove_extra_indentation(source: str) -> str:
        indent = 0
        for ch in source:
            if not is_ws(ch):
                break
            indent += 4 if ch == "\t" else 1
        out, at_start, omitted, i = [], True, 0, 0
        while i < len(source):
            c = source[i]
            if at_start and omitted < indent and c in " \t":
                omitted += 4 if c == "\t" else 1
            elif is_eol(c):
                if c == "\r" and source[i + 1:i + 2] == "\n":
                    i += 1
                    out.append("\n")
                else:
                    out.append(c)
                at_start, omitted = True, 0
            else:
                out.append(c)
                at_start = False
            i += 1
        return "".join(out)

    def shader_source(self, text: str) -> str:
        p = 2
        out = []
        while text[p] == " ":
            p += 1
        while is_eol(text[p]):
            p += 1
        while not (text[p] == '"' and text[p + 1] == '"'):
            if text[p] == "\\":
                out.append({"n": "\n", "t": "\t"}.get(text[p + 1], text[p + 1]))
                p += 2
            else:
                out.append(text[p])
                p += 1
        return self.remove_extra_indentation("".join(out))

    def value_element(self, data_type: str, value: Value):
        scalar = "Float" if data_type.startswith("Float") else "Int" if data_type.startswith(("Int", "Uint")) else "Bool"
        size = SCALAR_SIZE[data_type]
        if size > 1:
            if not self.token.startswith("TYPE:"):
                self.error("expecting a constructor")
            self.advance()
            self.eat("LEFT_PAREN")
        for ndx in range(size):
            if scalar == "Float":
                sign = 1.0
                if self.token == "MINUS":
                    sign = -1.0
                    self.advance()
                if self.token != "FLOAT_LITERAL":
                    self.error("expecting a float literal")
                value.elements.append(("f", sign * float(self.text)))
                self.advance()
            elif scalar == "Int":
                sign = 1
                if self.token == "MINUS":
                    sign = -1
                    self.advance()
                if self.token != "INT_LITERAL":
                    self.error("expecting an int literal")
                value.elements.append(("i", sign * int(self.text, 0)))
                self.advance()
            else:
                if self.token not in ("TRUE", "FALSE"):
                    self.error(f"unexpected token, expecting bool: {self.text}")
                value.elements.append(("i", 1 if self.token == "TRUE" else 0))
                self.advance()
            if ndx != size - 1:
                self.eat("COMMA")
        if size > 1:
            self.eat("RIGHT_PAREN")

    def value(self, block: list):
        v = Value()
        if self.token not in ("UNIFORM", "INPUT", "OUTPUT"):
            self.error("unexpected token encountered when parsing value classifier")
        v.storage = self.token.capitalize()
        self.advance()
        if not self.token.startswith("TYPE:"):
            self.error(f"unexpected token when parsing value data type: {self.text}")
        v.data_type = self.token[5:]
        self.advance()
        if self.token == "IDENTIFIER":
            v.name = self.text
        elif self.token == "STRING":
            v.name = self.string_literal(self.text)
        else:
            self.error(f"unexpected token when parsing value name: {self.text}")
        self.advance()
        self.eat("ASSIGN")
        if self.token == "LEFT_BRACKET":
            self.advance()
            v.array_length = 0
            while True:
                self.value_element(v.data_type, v)
                v.array_length += 1
                if self.token == "RIGHT_BRACKET":
                    break
                if self.token == "VERTICAL_BAR":
                    self.advance()
                    continue
                self.error(f"unexpected token in value element array: {self.text}")
            self.advance()
        else:
            self.value_element(v.data_type, v)
            v.array_length = 1
        self.eat("SEMI_COLON")
        block.append(v)

    def value_block(self) -> dict:
        self.eat("VALUES")
        self.eat("LEFT_BRACE")
        values: list = []
        while True:
            if self.token in ("UNIFORM", "INPUT", "OUTPUT"):
                self.value(values)
            elif self.token == "RIGHT_BRACE":
                break
            else:
                self.error(f"unexpected token when parsing a value block: {self.text}")
        self.eat("RIGHT_BRACE")
        array_length = 1
        for v in values:
            if v.array_length > 1:
                assert array_length in (1, v.array_length)
                array_length = v.array_length
        return {"array_length": array_length, "values": values}

    def case(self, out: list):
        self.eat("CASE")
        name = self.text
        self.advance()
        blocks, version, expect = [], "Es100", "Pass"
        both = vertex = fragment = ""
        has = {"both": False, "vertex": False, "fragment": False}
        while True:
            if self.token == "END":
                break
            elif self.token == "DESC":
                self.advance()
                if self.token != "STRING":
                    self.error("expecting a string")
                self.advance()
            elif self.token == "EXPECT":
                self.advance()
                if self.token != "IDENTIFIER":
                    self.error("expecting an identifier")
                expect = {"pass": "Pass", "compile_fail": "CompileFail", "link_fail": "LinkFail"}.get(self.text)
                if expect is None:
                    self.error(f"invalid expected result value: {self.text}")
                self.advance()
            elif self.token == "VALUES":
                blocks.append(self.value_block())
            elif self.token in ("BOTH", "VERTEX", "FRAGMENT"):
                kind = self.token.lower()
                self.advance()
                if self.token != "SHADER_SOURCE":
                    self.error("expecting shader source")
                source = self.shader_source(self.text)
                self.advance()
                has[kind] = True
                if kind == "both":
                    both = source
                elif kind == "vertex":
                    vertex = source
                else:
                    fragment = source
            elif self.token == "VERSION":
                self.advance()
                if self.token != "INT_LITERAL":
                    self.error("expecting a version number")
                number = int(self.text, 0)
                self.advance()
                postfix = ""
                if self.token == "IDENTIFIER":
                    postfix = self.text
                    self.advance()
                # `versionNum == 130` etc. ignore the postfix upstream; only the ES ones test it.
                found = VERSIONS.get((number, postfix if number < 130 else ""))
                if found is None:
                    self.error("Unknown GLSL version")
                version = found
            else:
                self.error(f"unexpected token while parsing shader case: {self.text}")
        self.eat("END")
        # `bothSource.length() > 0` decides, not whether the keyword appeared.
        if len(both) > 0:
            out.append(("case", name + "_vertex", expect, version, blocks, both, None))
            out.append(("case", name + "_fragment", expect, version, blocks, None, both))
        else:
            # `vertexSource.c_str()` is never null upstream: an absent stage is an empty string, which the constructor treats as present.
            out.append(("case", name, expect, version, blocks, vertex, fragment))

    def group(self, out: list):
        self.eat("GROUP")
        name = self.text
        self.advance()
        if self.token != "STRING":
            self.error("expecting a description")
        self.advance()
        children: list = []
        while True:
            if self.token == "END":
                break
            elif self.token == "GROUP":
                self.group(children)
            elif self.token == "CASE":
                self.case(children)
            else:
                self.error(f"unexpected token while parsing shader group: {self.text}")
        self.eat("END")
        out.append(("group", name, children))

    def parse(self) -> list:
        nodes: list = []
        while True:
            if self.token == "CASE":
                self.case(nodes)
            elif self.token == "GROUP":
                self.group(nodes)
            elif self.token == "EOF":
                break
            else:
                self.error(f"invalid token encountered at main level: '{self.text}'")
        return nodes


def rust_bytes(s: str) -> str:
    """A byte-string literal for a source read as Latin-1, escaping everything that is not printable ASCII so the file stays readable and the byte survives."""
    out = []
    for ch in s:
        c = ord(ch)
        if ch == "\\":
            out.append("\\\\")
        elif ch == '"':
            out.append('\\"')
        elif ch == "\n":
            out.append("\\n")
        elif ch == "\t":
            out.append("\\t")
        elif 0x20 <= c < 0x7F:
            out.append(ch)
        else:
            out.append(f"\\x{c:02x}")
    return 'b"' + "".join(out) + '"'


def rust_string(s: str) -> str:
    hashes = 1
    while '"' + "#" * hashes in s:
        hashes += 1
    return f'r{"#" * hashes}"{s}"{"#" * hashes}'


def rust_float(x: float) -> str:
    text = repr(float(x))
    return text if ("." in text or "e" in text or "inf" in text or "nan" in text) else text + ".0"


class Emitter:
    def __init__(self, module: str, relative: str):
        self.module, self.relative = module, relative
        self.sources: list[str] = []
        self.source_index: dict[str, int] = {}
        self.statics: list[str] = []
        self.num_cases = 0

    def source(self, text: str | None) -> str:
        if text is None:
            return "None"
        if text not in self.source_index:
            self.source_index[text] = len(self.sources)
            self.sources.append(text)
        return f"Some(S{self.source_index[text]})"

    def value(self, v: Value) -> str:
        elements = ", ".join(f"Element::Float({rust_float(x)})" if kind == "f" else f"Element::Int({x})" for kind, x in v.elements)
        return (f"Value {{ storage: Storage::{v.storage}, name: {rust_string(v.name)}, data_type: DataType::{v.data_type}, array_length: {v.array_length}, "
                f"elements: &[{elements}] }}")

    def node(self, node, indent: str) -> str:
        if node[0] == "group":
            _, name, children = node
            inner = "\n".join(self.node(child, indent + "    ") for child in children)
            return f"{indent}Node::Group(&Group {{ name: {rust_string(name)}, children: &[\n{inner}\n{indent}] }}),"
        _, name, expect, version, blocks, vertex, fragment = node
        self.num_cases += 1
        block_text = ", ".join(
            "ValueBlock { array_length: %d, values: &[%s] }" % (b["array_length"], ", ".join(self.value(v) for v in b["values"])) for b in blocks)
        return (f"{indent}Node::Case(&Case {{ name: {rust_string(name)}, spec: CaseSpec {{ expect_result: ExpectResult::{expect}, target_version: GlslVersion::{version}, "
                f"value_blocks: &[{block_text}], vertex_source: {self.source(vertex)}, fragment_source: {self.source(fragment)} }} }}),")

    def finish(self, nodes) -> str:
        body = "\n".join(self.node(n, "        ") for n in nodes)
        header = [
            "// @generated by hodow_cts/scripts/gen_khr_shader_library.py - do not hand-edit.",
            "//",
            f"// Parsed from VK-GL-CTS `external/openglcts/data/gl_cts/data/{self.relative}`.",
            "// Upstream revision: see hodow_cts/upstream/COMMIT.",
            "//",
            "// Copyright (c) 2016 The Khronos Group Inc.",
            "// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).",
            "",
            "#![allow(unused_imports)]",
            "",
            "use crate::glu::shader_util::DataType;",
            "use crate::glu::GlslVersion;",
            "use crate::khr_gl::shader_library::{Case, CaseSpec, Element, ExpectResult, Group, Node, Storage, Value, ValueBlock};",
            "",
        ]
        consts = [f"const S{i}: &[u8] = {rust_bytes(text)};" for i, text in enumerate(self.sources)]
        root = f"pub static ROOT: Group = Group {{ name: \"\", children: &[\n{body}\n] }};\n"
        return "\n".join(header + consts + ["", root])


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cts-dir", default=str(CRATE_DIR.parent / "tmp" / "glcts-src"))
    ap.add_argument("--check", action="store_true", help="fail if the committed output is stale")
    args = ap.parse_args()

    data_dir = Path(args.cts_dir) / "external" / "openglcts" / "data" / "gl_cts" / "data"
    if not data_dir.is_dir():
        print(f"error: no shader-library data at {data_dir} (a checkout at the pinned commit, see `just glcts-build`)", file=sys.stderr)
        return 1

    generated: dict[Path, str] = {}
    index = [
        "// @generated by hodow_cts/scripts/gen_khr_shader_library.py - do not hand-edit.",
        "//",
        "// One module per Khronos GL CTS shader-library `.test` file. Each exposes a `ROOT` group that `khr_gl::shader_library::create_group` turns into a case tree.",
        "",
    ]
    total = 0
    for relative in FILES:
        module = relative.replace("/", "_").removesuffix(".test")
        try:
            nodes = Parser(data_dir / relative).parse()
        except ParseError as e:
            print(f"error: {e}", file=sys.stderr)
            return 1
        emitter = Emitter(module, relative)
        generated[OUT_DIR / f"{module}.rs"] = emitter.finish(nodes)
        index += [f"/// `{relative}` - {emitter.num_cases} cases.", f"pub mod {module};", ""]
        total += emitter.num_cases
    generated[INDEX_PATH] = "\n".join(index)

    if args.check:
        stale = [p for p, text in generated.items() if not p.exists() or p.read_text() != text]
        for path in sorted(OUT_DIR.glob("*.rs")) if OUT_DIR.is_dir() else []:
            if path not in generated:
                stale.append(path)
        if stale:
            print("error: generated khr shader library is stale; re-run gen_khr_shader_library.py", file=sys.stderr)
            for path in stale:
                print(f"  {path.relative_to(CRATE_DIR)}", file=sys.stderr)
            return 1
        print(f"generated khr shader library is up to date ({total} cases)")
        return 0

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for path, text in generated.items():
        path.write_text(text)
    print(f"wrote {len(generated)} file(s), {total} cases")
    return 0


if __name__ == "__main__":
    sys.exit(main())
