#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Ahead-of-time parser for VK-GL-CTS's shader-library `.test` DSL.

Upstream (`framework/opengl/gluShaderLibrary.cpp`) parses these files at *run time* out of a
data archive. hodow_cts must not depend on data files it has to find on disk, so this script
runs the same parse ahead of time and emits the case tree as Rust statics under
`src/generated/shader_library/`, built from the spec types in `src/gls/shader_library.rs`.

Everything here mirrors `glu::sl::ShaderParser` directly, including the tokenizer's quirks
(`isCaseNameChar` letting a case name carry `.`/`-`, the `""` ... `""` shader-source literal,
`removeExtraIndentation`, the `both` source expanding into a `_vertex` and a `_fragment`
case). An unrecognised construct raises rather than being silently dropped - a `.test` file
that grows a new keyword upstream must fail here, not lose cases quietly.

Usage:
    python3 hodow_cts/scripts/gen_shader_library.py [--cts-dir ../tmp/VK-GL-CTS] [--check]
"""

from __future__ import annotations

import argparse
import struct
import sys
from pathlib import Path

# ---------------------------------------------------------------------------
# Tokenizer - `ShaderParser::advanceToken`
# ---------------------------------------------------------------------------

NAMED = {
    "true": "TRUE",
    "false": "FALSE",
    "desc": "DESC",
    "expect": "EXPECT",
    "group": "GROUP",
    "case": "CASE",
    "end": "END",
    "output_color": "OUTPUT_COLOR",
    "format": "FORMAT",
    "values": "VALUES",
    "both": "BOTH",
    "vertex": "VERTEX",
    "fragment": "FRAGMENT",
    "uniform": "UNIFORM",
    "input": "INPUT",
    "output": "OUTPUT",
    "float": "FLOAT",
    "vec2": "FLOAT_VEC2",
    "vec3": "FLOAT_VEC3",
    "vec4": "FLOAT_VEC4",
    "mat2": "FLOAT_MAT2",
    "mat2x3": "FLOAT_MAT2X3",
    "mat2x4": "FLOAT_MAT2X4",
    "mat3x2": "FLOAT_MAT3X2",
    "mat3": "FLOAT_MAT3",
    "mat3x4": "FLOAT_MAT3X4",
    "mat4x2": "FLOAT_MAT4X2",
    "mat4x3": "FLOAT_MAT4X3",
    "mat4": "FLOAT_MAT4",
    "int": "INT",
    "ivec2": "INT_VEC2",
    "ivec3": "INT_VEC3",
    "ivec4": "INT_VEC4",
    "uint": "UINT",
    "uvec2": "UINT_VEC2",
    "uvec3": "UINT_VEC3",
    "uvec4": "UINT_VEC4",
    "bool": "BOOL",
    "bvec2": "BOOL_VEC2",
    "bvec3": "BOOL_VEC3",
    "bvec4": "BOOL_VEC4",
    "version": "VERSION",
    "tessellation_control": "TESSELLATION_CONTROL",
    "tessellation_evaluation": "TESSELLATION_EVALUATION",
    "geometry": "GEOMETRY",
    "require": "REQUIRE",
    "in": "IN",
    "import": "IMPORT",
    "pipeline_program": "PIPELINE_PROGRAM",
    "active_stages": "ACTIVE_STAGES",
}

SIMPLE = [
    ("=", "ASSIGN"),
    ("+", "PLUS"),
    ("-", "MINUS"),
    (",", "COMMA"),
    ("|", "VERTICAL_BAR"),
    (";", "SEMI_COLON"),
    ("(", "LEFT_PAREN"),
    (")", "RIGHT_PAREN"),
    ("[", "LEFT_BRACKET"),
    ("]", "RIGHT_BRACKET"),
    ("{", "LEFT_BRACE"),
    ("}", "RIGHT_BRACE"),
    (">", "GREATER"),
]

SHADER_SOURCE_TOKENS = {
    "VERTEX": "Vertex",
    "FRAGMENT": "Fragment",
    "GEOMETRY": "Geometry",
    "TESSELLATION_CONTROL": "TessControl",
    "TESSELLATION_EVALUATION": "TessEvaluation",
}

# `glu::ShaderType`, whose ordinal is what the stage bitmask shifts by.
STAGE_BIT = {
    "Vertex": 1 << 0,
    "Fragment": 1 << 1,
    "Geometry": 1 << 2,
    "TessControl": 1 << 3,
    "TessEvaluation": 1 << 4,
}

ALL_STAGES = 0xFFFFFFFF


def is_whitespace(c: str) -> bool:
    return c in " \t\r\n"


def is_eol(c: str) -> bool:
    return c in "\r\n"


def is_case_name_char(c: str) -> bool:
    return c.isascii() and (c.isalnum() or c in "_-.")


def is_alpha(c: str) -> bool:
    return c.isascii() and c.isalpha()


def is_numeric(c: str) -> bool:
    return c.isascii() and c.isdigit()


class ParseError(Exception):
    pass


class Tokenizer:
    def __init__(self, src: str, filename: str):
        self.src = src
        self.filename = filename
        self.pos = 0
        self.token = "INVALID"
        self.text = ""
        self.advance()

    def error(self, msg: str):
        raise ParseError(f"{self.filename}: {msg} near {self.src[self.pos:self.pos + 60]!r}")

    def _at(self, off: int = 0) -> str:
        i = self.pos + off
        return self.src[i] if i < len(self.src) else "\0"

    def advance(self, assumed: str | None = None):
        if assumed is not None:
            self.assume(assumed)

        self.pos += len(self.text)
        self.token = "INVALID"
        self.text = ""

        while True:
            while self.pos < len(self.src) and is_whitespace(self.src[self.pos]):
                self.pos += 1
            if self._at() == "#":
                while self.pos < len(self.src) and not is_eol(self.src[self.pos]):
                    self.pos += 1
            else:
                break

        if self.pos >= len(self.src):
            self.token = "EOF"
            self.text = ""
            return

        c = self.src[self.pos]

        if is_alpha(c):
            end = self.pos + 1
            while end < len(self.src) and is_case_name_char(self.src[end]):
                end += 1
            self.text = self.src[self.pos:end]
            self.token = NAMED.get(self.text, "IDENTIFIER")
        elif is_numeric(c):
            p = self.pos
            while p < len(self.src) and is_numeric(self.src[p]):
                p += 1
            if p < len(self.src) and self.src[p] == ".":
                p += 1
                while p < len(self.src) and is_numeric(self.src[p]):
                    p += 1
                if p < len(self.src) and self.src[p] in "eE":
                    p += 1
                    if p < len(self.src) and self.src[p] in "+-":
                        p += 1
                    while p < len(self.src) and is_numeric(self.src[p]):
                        p += 1
                self.token = "FLOAT_LITERAL"
            else:
                self.token = "INT_LITERAL"
            self.text = self.src[self.pos:p]
        elif c == '"' and self._at(1) == '"':
            p = self.pos + 2
            while not (self.src[p] == '"' and p + 1 < len(self.src) and self.src[p + 1] == '"'):
                p += 2 if self.src[p] == "\\" else 1
            p += 2
            self.token = "SHADER_SOURCE"
            self.text = self.src[self.pos:p]
        elif c in "\"'":
            p = self.pos + 1
            while self.src[p] != c:
                p += 2 if self.src[p] == "\\" else 1
            p += 1
            self.token = "STRING"
            self.text = self.src[self.pos:p]
        else:
            for text, token in SIMPLE:
                if self.src.startswith(text, self.pos):
                    self.token = token
                    self.text = text
                    return
            self.error(f"invalid token {c!r}")

    def assume(self, token: str):
        if self.token != token:
            self.error(f"unexpected token {self.text!r}, expecting {token}")


def parse_string_literal(text: str) -> str:
    end_char = text[0]
    out = []
    p = 1
    while p < len(text) and text[p] != end_char:
        if text[p] == "\\":
            nxt = text[p + 1]
            out.append({"n": "\n", "t": "\t"}.get(nxt, nxt))
            p += 2
        else:
            out.append(text[p])
            p += 1
    return "".join(out)


def remove_extra_indentation(source: str) -> str:
    num_indent_chars = 0
    for c in source:
        if not is_whitespace(c):
            break
        num_indent_chars += 4 if c == "\t" else 1

    out = []
    at_line_start = True
    omitted = 0
    pos = 0
    while pos < len(source):
        c = source[pos]
        if at_line_start and omitted < num_indent_chars and c in " \t":
            omitted += 4 if c == "\t" else 1
        elif is_eol(c):
            if c == "\r" and pos + 1 < len(source) and source[pos + 1] == "\n":
                pos += 1
            out.append("\n" if c == "\r" else c)
            at_line_start = True
            omitted = 0
        else:
            out.append(c)
            at_line_start = False
        pos += 1

    return "".join(out)


def parse_shader_source(text: str) -> str:
    p = 2
    while p < len(text) and text[p] == " ":
        p += 1
    if text[p] == "\r":
        p += 1
    if text[p] == "\n":
        p += 1

    out = []
    while not (text[p] == '"' and text[p + 1] == '"'):
        if text[p] == "\\":
            nxt = text[p + 1]
            out.append({"n": "\n", "t": "\t"}.get(nxt, nxt))
            p += 2
        else:
            out.append(text[p])
            p += 1

    return remove_extra_indentation("".join(out))


# ---------------------------------------------------------------------------
# Data types - `glu::DataType`
# ---------------------------------------------------------------------------

# token -> (Rust DataType variant, scalar type, scalar size)
DATA_TYPES = {
    "FLOAT": ("Float", "float", 1),
    "FLOAT_VEC2": ("FloatVec2", "float", 2),
    "FLOAT_VEC3": ("FloatVec3", "float", 3),
    "FLOAT_VEC4": ("FloatVec4", "float", 4),
    "FLOAT_MAT2": ("FloatMat2", "float", 4),
    "FLOAT_MAT2X3": ("FloatMat2x3", "float", 6),
    "FLOAT_MAT2X4": ("FloatMat2x4", "float", 8),
    "FLOAT_MAT3X2": ("FloatMat3x2", "float", 6),
    "FLOAT_MAT3": ("FloatMat3", "float", 9),
    "FLOAT_MAT3X4": ("FloatMat3x4", "float", 12),
    "FLOAT_MAT4X2": ("FloatMat4x2", "float", 8),
    "FLOAT_MAT4X3": ("FloatMat4x3", "float", 12),
    "FLOAT_MAT4": ("FloatMat4", "float", 16),
    "INT": ("Int", "int", 1),
    "INT_VEC2": ("IntVec2", "int", 2),
    "INT_VEC3": ("IntVec3", "int", 3),
    "INT_VEC4": ("IntVec4", "int", 4),
    "UINT": ("Uint", "int", 1),
    "UINT_VEC2": ("UintVec2", "int", 2),
    "UINT_VEC3": ("UintVec3", "int", 3),
    "UINT_VEC4": ("UintVec4", "int", 4),
    "BOOL": ("Bool", "bool", 1),
    "BOOL_VEC2": ("BoolVec2", "bool", 2),
    "BOOL_VEC3": ("BoolVec3", "bool", 3),
    "BOOL_VEC4": ("BoolVec4", "bool", 4),
}

EXPECT_RESULTS = {
    "pass": "Pass",
    "compile_fail": "CompileFail",
    "link_fail": "LinkFail",
    "compile_or_link_fail": "CompileLinkFail",
    "validation_fail": "ValidationFail",
    "build_successful": "BuildSuccessful",
}

GLSL_VERSIONS = {
    (100, "es"): "Es100",
    (300, "es"): "Es300",
    (310, "es"): "Es310",
    (320, "es"): "Es320",
}

# `ShaderParser::getGLEnumFromName` - the whole table.
LIMIT_ENUMS = {
    "GL_MAX_VERTEX_IMAGE_UNIFORMS",
    "GL_MAX_VERTEX_ATOMIC_COUNTERS",
    "GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS",
    "GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS",
}

# `glu::sl::CapabilityFlag`, the requirements that are a flag rather than a limit.
CAPABILITY_FLAGS = {
    "full_glsl_es_100_support": "FullGlslEs100Support",
    "only_glsl_es_100_support": "OnlyGlslEs100Support",
    "exactly_one_draw_buffer": "ExactlyOneDrawBuffer",
}


# ---------------------------------------------------------------------------
# Parsed model
# ---------------------------------------------------------------------------


class Value:
    __slots__ = ("data_type", "name", "elements")

    def __init__(self, data_type: str, name: str):
        self.data_type = data_type
        self.name = name
        self.elements: list = []


class ProgramSpec:
    __slots__ = ("sources", "required_extensions", "active_stages", "separable")

    def __init__(self):
        self.sources: list[tuple[str, str]] = []
        self.required_extensions: list[tuple[list[str], int]] = []
        self.active_stages = 0
        self.separable = False


class CaseSpec:
    __slots__ = ("case_type", "expect_result", "target_version", "required_caps", "values", "programs", "output_type", "output_format")

    def __init__(self):
        self.case_type = "Complete"
        self.expect_result = "Pass"
        # Only the Vulkan runner reads these (see gen_vk_shader_library.py); the GLES emitter ignores them.
        self.output_type = "Result"
        self.output_format = None
        self.target_version = "Es100"
        self.required_caps: list[tuple[str, int]] = []
        self.values: dict[str, list[Value]] = {"inputs": [], "outputs": [], "uniforms": []}
        self.programs: list[ProgramSpec] = []


class Case:
    __slots__ = ("name", "spec")

    def __init__(self, name: str, spec: CaseSpec):
        self.name = name
        self.spec = spec


class Group:
    __slots__ = ("name", "children")

    def __init__(self, name: str):
        self.name = name
        self.children: list = []


# ---------------------------------------------------------------------------
# Parser - `ShaderParser`
# ---------------------------------------------------------------------------


class Parser:
    def __init__(self, path: Path, vulkan: bool = False):
        self.path = path
        # The Vulkan shader library (vktShaderLibrary.cpp) differs from the GLES one in three ways: its case factory
        # `supportsComputeOnlyCase()`, so a 'both' source also makes a `_compute` case; `output_color <type>` cases exist; and
        # the 440 files say `version 440 core`.
        self.vulkan = vulkan
        self.tk = Tokenizer(path.read_text(encoding="utf-8"), str(path))

    def parse(self) -> list:
        nodes = []
        while True:
            if self.tk.token == "CASE":
                self.parse_case(nodes)
            elif self.tk.token == "GROUP":
                self.parse_group(nodes)
            elif self.tk.token == "IMPORT":
                self.parse_import(nodes)
            elif self.tk.token == "EOF":
                break
            else:
                self.tk.error(f"invalid token at main level: {self.tk.text!r}")
        return nodes

    def parse_import(self, nodes: list):
        self.tk.advance("IMPORT")
        self.tk.assume("STRING")
        name = parse_string_literal(self.tk.text)
        self.tk.advance("STRING")
        nodes.extend(Parser(self.path.parent / name, self.vulkan).parse())

    def parse_group(self, nodes: list):
        self.tk.advance("GROUP")
        name = self.tk.text
        self.tk.advance()
        self.tk.assume("STRING")
        self.tk.advance("STRING")

        group = Group(name)
        while True:
            if self.tk.token == "END":
                break
            if self.tk.token == "GROUP":
                self.parse_group(group.children)
            elif self.tk.token == "CASE":
                self.parse_case(group.children)
            elif self.tk.token == "IMPORT":
                self.parse_import(group.children)
            else:
                self.tk.error(f"unexpected token while parsing shader group: {self.tk.text!r}")
        self.tk.advance("END")
        nodes.append(group)

    def parse_value_element(self, token: str, value: Value):
        _, scalar_type, scalar_size = DATA_TYPES[token]

        if scalar_size > 1:
            self.tk.assume(token)
            self.tk.advance()
            self.tk.advance("LEFT_PAREN")

        for ndx in range(scalar_size):
            if scalar_type == "float":
                sign = 1.0
                if self.tk.token == "MINUS":
                    sign = -1.0
                    self.tk.advance()
                self.tk.assume("FLOAT_LITERAL")
                value.elements.append(sign * float(self.tk.text))
                self.tk.advance("FLOAT_LITERAL")
            elif scalar_type == "int":
                sign = 1
                if self.tk.token == "MINUS":
                    sign = -1
                    self.tk.advance()
                self.tk.assume("INT_LITERAL")
                value.elements.append(sign * int(self.tk.text))
                self.tk.advance("INT_LITERAL")
            else:
                if self.tk.token not in ("TRUE", "FALSE"):
                    self.tk.error(f"unexpected token, expecting bool: {self.tk.text!r}")
                value.elements.append(1 if self.tk.token == "TRUE" else 0)
                self.tk.advance()

            if ndx != scalar_size - 1:
                self.tk.advance("COMMA")

        if scalar_size > 1:
            self.tk.advance("RIGHT_PAREN")

    def parse_value(self, values: dict):
        dst = {"UNIFORM": "uniforms", "INPUT": "inputs", "OUTPUT": "outputs"}.get(self.tk.token)
        if dst is None:
            self.tk.error("unexpected token encountered when parsing value classifier")
        self.tk.advance()

        type_token = self.tk.token
        if type_token not in DATA_TYPES:
            self.tk.error(f"unexpected token when parsing value data type: {self.tk.text!r}")
        self.tk.advance()

        if self.tk.token == "IDENTIFIER":
            name = self.tk.text
        elif self.tk.token == "STRING":
            name = parse_string_literal(self.tk.text)
        else:
            self.tk.error(f"unexpected token when parsing value name: {self.tk.text!r}")
        self.tk.advance()
        self.tk.advance("ASSIGN")

        value = Value(DATA_TYPES[type_token][0], name)
        values[dst].append(value)

        if self.tk.token == "LEFT_BRACKET":
            self.tk.advance("LEFT_BRACKET")
            while True:
                self.parse_value_element(type_token, value)
                if self.tk.token == "RIGHT_BRACKET":
                    break
                if self.tk.token == "VERTICAL_BAR":
                    self.tk.advance()
                    continue
                self.tk.error(f"unexpected token in value element array: {self.tk.text!r}")
            self.tk.advance("RIGHT_BRACKET")
        else:
            self.parse_value_element(type_token, value)

        self.tk.advance("SEMI_COLON")

    def parse_value_block(self, values: dict):
        self.tk.advance("VALUES")
        self.tk.advance("LEFT_BRACE")
        while True:
            if self.tk.token in ("UNIFORM", "INPUT", "OUTPUT"):
                self.parse_value(values)
            elif self.tk.token == "RIGHT_BRACE":
                break
            else:
                self.tk.error(f"unexpected token when parsing a value block: {self.tk.text!r}")
        self.tk.advance("RIGHT_BRACE")

    def stage_literal_flag(self) -> int:
        stage = SHADER_SOURCE_TOKENS.get(self.tk.token)
        if stage is None:
            self.tk.error(f"invalid shader stage name, got {self.tk.text!r}")
        return STAGE_BIT[stage]

    def parse_shader_stage_list(self) -> int:
        self.tk.assume("LEFT_BRACE")
        self.tk.advance()
        mask = self.stage_literal_flag()
        self.tk.advance()

        while True:
            if self.tk.token == "RIGHT_BRACE":
                break
            if self.tk.token == "COMMA":
                self.tk.advance()
                flag = self.stage_literal_flag()
                if flag & mask:
                    self.tk.error(f"stage already set in the shader stage set: {self.tk.text!r}")
                mask |= flag
                self.tk.advance()
            else:
                self.tk.error(f"invalid shader stage set token: {self.tk.text!r}")
        self.tk.advance("RIGHT_BRACE")
        return mask

    def parse_requirement(self, required_caps: list, required_exts: list):
        self.tk.advance()
        self.tk.assume("IDENTIFIER")

        if self.tk.text == "extension":
            alternatives = []
            stages = ALL_STAGES

            self.tk.advance()
            self.tk.assume("LEFT_BRACE")
            self.tk.advance()
            self.tk.assume("STRING")
            alternatives.append(parse_string_literal(self.tk.text))
            self.tk.advance()

            while True:
                if self.tk.token == "RIGHT_BRACE":
                    break
                if self.tk.token == "VERTICAL_BAR":
                    self.tk.advance()
                    self.tk.assume("STRING")
                    alternatives.append(parse_string_literal(self.tk.text))
                    self.tk.advance()
                else:
                    self.tk.error(f"invalid extension list token: {self.tk.text!r}")
            self.tk.advance("RIGHT_BRACE")

            if self.tk.token == "IN":
                self.tk.advance()
                stages = self.parse_shader_stage_list()

            required_exts.append((alternatives, stages))
        elif self.tk.text == "limit":
            self.tk.advance()
            self.tk.assume("STRING")
            limit_enum = parse_string_literal(self.tk.text)
            if limit_enum not in LIMIT_ENUMS:
                self.tk.error(f"unknown enum name, got {limit_enum}")
            self.tk.advance()
            self.tk.assume("GREATER")
            self.tk.advance()
            self.tk.assume("INT_LITERAL")
            limit_value = int(self.tk.text)
            self.tk.advance()
            required_caps.append(("Limit", limit_enum, limit_value))
        elif self.tk.text in CAPABILITY_FLAGS:
            required_caps.append((CAPABILITY_FLAGS[self.tk.text],))
            self.tk.advance()
        else:
            self.tk.error(f"invalid requirement value: {self.tk.text!r}")

    def parse_expect_result(self) -> str:
        self.tk.assume("IDENTIFIER")
        result = EXPECT_RESULTS.get(self.tk.text)
        if result is None:
            self.tk.error(f"invalid expected result value: {self.tk.text!r}")
        self.tk.advance()
        return result

    def parse_glsl_version(self) -> str:
        self.tk.assume("INT_LITERAL")
        version_num = int(self.tk.text)
        self.tk.advance()
        postfix = ""
        if self.tk.token == "IDENTIFIER":
            postfix = self.tk.text
            self.tk.advance()
        version = GLSL_VERSIONS.get((version_num, postfix))
        if version is None and self.vulkan and (version_num, postfix) == (440, "core"):
            version = "Glsl440"
        if version is None:
            self.tk.error(f"unsupported GLSL version {version_num} {postfix}")
        return version

    def parse_pipeline_program(self) -> ProgramSpec:
        program = ProgramSpec()
        self.tk.advance("PIPELINE_PROGRAM")

        while True:
            if self.tk.token == "END":
                break
            if self.tk.token == "ACTIVE_STAGES":
                self.tk.advance()
                program.active_stages = self.parse_shader_stage_list()
            elif self.tk.token == "REQUIRE":
                unused_caps: list = []
                before = len(program.required_extensions)
                self.parse_requirement(unused_caps, program.required_extensions)
                if before == len(program.required_extensions):
                    self.tk.error("only extension requirements are allowed inside pipeline program")
            elif self.tk.token in SHADER_SOURCE_TOKENS:
                stage = SHADER_SOURCE_TOKENS[self.tk.token]
                self.tk.advance()
                self.tk.assume("SHADER_SOURCE")
                program.sources.append((stage, parse_shader_source(self.tk.text)))
                self.tk.advance()
            else:
                self.tk.error(f"invalid pipeline program value: {self.tk.text!r}")

        self.tk.advance("END")
        if program.active_stages == 0:
            self.tk.error("program pipeline object must have active stages")
        return program

    def parse_case(self, nodes: list):
        self.tk.advance("CASE")
        case_name = self.tk.text
        self.tk.advance()

        version = "Es100"
        expect_result = "Pass"
        both_source = None
        output_type = "Result"
        output_format = None
        stage_sources: list[tuple[str, str]] = []
        values: dict[str, list[Value]] = {"inputs": [], "outputs": [], "uniforms": []}
        value_block_seen = False
        required_caps: list = []
        required_exts: list = []
        pipeline_programs: list[ProgramSpec] = []

        while True:
            if self.tk.token == "END":
                break
            if self.tk.token == "DESC":
                self.tk.advance()
                self.tk.assume("STRING")
                self.tk.advance()
            elif self.tk.token == "EXPECT":
                self.tk.advance()
                expect_result = self.parse_expect_result()
            elif self.tk.token == "OUTPUT_COLOR":
                if not self.vulkan:
                    self.tk.error("output_color is not supported by hodow_cts's shader-library case")
                self.tk.advance()
                if self.tk.token not in DATA_TYPES:
                    self.tk.error(f"unexpected token when parsing output format: {self.tk.text!r}")
                output_format = self.tk.token
                output_type = "Color"
                self.tk.advance()
            elif self.tk.token == "VALUES":
                if value_block_seen:
                    self.tk.error("multiple value blocks")
                self.parse_value_block(values)
                value_block_seen = True
            elif self.tk.token == "BOTH" or self.tk.token in SHADER_SOURCE_TOKENS:
                token = self.tk.token
                self.tk.advance()
                self.tk.assume("SHADER_SOURCE")
                source = parse_shader_source(self.tk.text)
                self.tk.advance()
                if token == "BOTH":
                    if both_source is not None:
                        self.tk.error("multiple 'both' blocks")
                    both_source = source
                else:
                    stage_sources.append((SHADER_SOURCE_TOKENS[token], source))
            elif self.tk.token == "VERSION":
                self.tk.advance()
                version = self.parse_glsl_version()
            elif self.tk.token == "REQUIRE":
                self.parse_requirement(required_caps, required_exts)
            elif self.tk.token == "PIPELINE_PROGRAM":
                program = self.parse_pipeline_program()
                program.separable = True
                pipeline_programs.append(program)
            else:
                self.tk.error(f"unexpected token while parsing shader case: {self.tk.text!r}")

        self.tk.advance("END")

        def make_spec(case_type: str, programs: list[ProgramSpec]) -> CaseSpec:
            spec = CaseSpec()
            spec.case_type = case_type
            spec.expect_result = expect_result
            spec.target_version = version
            spec.required_caps = required_caps
            spec.values = values
            spec.programs = programs
            if case_type == "Complete" and len(programs) == 1:
                spec.output_type = output_type
                spec.output_format = output_format
            return spec

        if both_source is not None:
            if stage_sources or pipeline_programs:
                self.tk.error("'both' cannot be mixed with other shader stages")

            for suffix, case_type, stage in (
                ("_vertex", "VertexOnly", "Vertex"),
                ("_fragment", "FragmentOnly", "Fragment"),
            ):
                program = ProgramSpec()
                program.sources = [(stage, both_source)]
                program.required_extensions = required_exts
                nodes.append(Case(case_name + suffix, make_spec(case_type, [program])))

            if self.vulkan:
                program = ProgramSpec()
                program.sources = [("Vertex", both_source)]
                program.required_extensions = required_exts
                nodes.append(Case(case_name + "_compute", make_spec("ComputeOnly", [program])))
        elif not pipeline_programs:
            program = ProgramSpec()
            program.sources = stage_sources
            program.required_extensions = required_exts
            nodes.append(Case(case_name, make_spec("Complete", [program])))
        else:
            if stage_sources:
                self.tk.error("pipeline programs cannot be mixed with complete programs")
            if required_exts:
                self.tk.error("global extension requirements cannot be mixed with pipeline programs")
            nodes.append(Case(case_name, make_spec("Complete", pipeline_programs)))


# ---------------------------------------------------------------------------
# Rust emission
# ---------------------------------------------------------------------------


def f32_literal(value: float) -> str:
    """The shortest decimal that parses back to the same `f32`.

    `repr` would give the shortest decimal for the *double* holding it, which is a good deal
    longer (`0.3f32` prints as `0.30000001192092896`) and trips clippy's
    `excessive_precision`.
    """
    exact = struct.unpack("<f", struct.pack("<f", value))[0]
    for precision in range(1, 18):
        text = f"{exact:.{precision}g}"
        if struct.unpack("<f", struct.pack("<f", float(text)))[0] == exact:
            break
    return text if ("." in text or "e" in text) else text + ".0"


def i32_literal(value: int) -> str:
    # `parseIntLiteral` is `atoi`, so anything outside i32 would already be undefined upstream.
    if not -(2 ** 31) <= value < 2 ** 31:
        raise ParseError(f"integer literal {value} does not fit an i32")
    return str(value)


def rust_string(text: str) -> str:
    """A raw string when the text allows one, since a shader reads far better that way."""
    if "\r" not in text and "\0" not in text:
        hashes = 1
        while ('"' + "#" * hashes) in text:
            hashes += 1
        if not text.endswith('"'):
            h = "#" * hashes
            return f'r{h}"{text}"{h}'

    escaped = text.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t")
    return f'"{escaped}"'


def emit_capability(cap: tuple) -> str:
    if cap[0] == "Limit":
        _, enum, value = cap
        return (
            f"RequiredCapability::Limit {{ pname: glw::{enum}, reference_value: {value}, "
            f"pname_str: {rust_string(enum)} }}"
        )
    return f"RequiredCapability::{cap[0]}"


class Emitter:
    def __init__(self, module: str, source_path: str):
        self.module = module
        self.source_path = source_path
        self.strings: dict[str, str] = {}
        self.string_lines: list[str] = []
        self.body: list[str] = []
        self.next_id = 0
        self.num_cases = 0

    def intern(self, text: str) -> str:
        name = self.strings.get(text)
        if name is None:
            name = f"S{len(self.strings)}"
            self.strings[text] = name
            self.string_lines.append(f"const {name}: &str = {rust_string(text)};")
        return name

    def fresh(self, prefix: str) -> str:
        self.next_id += 1
        return f"{prefix}{self.next_id}"

    def emit_values(self, values: list[Value]) -> str:
        if not values:
            return "&[]"
        parts = []
        for value in values:
            if isinstance(value.elements[0], float):
                elems = "Elements::Float(&[" + ", ".join(f32_literal(e) for e in value.elements) + "])"
            else:
                elems = "Elements::Int(&[" + ", ".join(i32_literal(e) for e in value.elements) + "])"
            parts.append(
                f"Value {{ data_type: DataType::{value.data_type}, name: {rust_string(value.name)}, elements: {elems} }}"
            )
        return "&[" + ", ".join(parts) + "]"

    def emit_program(self, program: ProgramSpec) -> str:
        sources = ", ".join(f"(ShaderType::{stage}, {self.intern(src)})" for stage, src in program.sources)
        if program.required_extensions:
            exts = ", ".join(
                "RequiredExtension { alternatives: &["
                + ", ".join(rust_string(alt) for alt in alternatives)
                + f"], effective_stages: {stages:#x} }}"
                for alternatives, stages in program.required_extensions
            )
            exts = "&[" + exts + "]"
        else:
            exts = "&[]"
        return (
            f"ProgramSpec {{ sources: &[{sources}], required_extensions: {exts}, "
            f"active_stages: {program.active_stages:#x}, separable: {str(program.separable).lower()} }}"
        )

    def emit_case(self, case: Case) -> str:
        self.num_cases += 1
        name = self.fresh("C")
        spec = case.spec

        if spec.required_caps:
            caps = "&[" + ", ".join(emit_capability(cap) for cap in spec.required_caps) + "]"
        else:
            caps = "&[]"

        programs = "&[" + ", ".join(self.emit_program(p) for p in spec.programs) + "]"

        self.body.append(
            f"static {name}: Case = Case {{\n"
            f"    name: {rust_string(case.name)},\n"
            f"    spec: CaseSpec {{\n"
            f"        case_type: CaseType::{spec.case_type},\n"
            f"        expect_result: ExpectResult::{spec.expect_result},\n"
            f"        target_version: GlslVersion::{spec.target_version},\n"
            f"        required_caps: {caps},\n"
            f"        values: ValueBlock {{\n"
            f"            inputs: {self.emit_values(spec.values['inputs'])},\n"
            f"            outputs: {self.emit_values(spec.values['outputs'])},\n"
            f"            uniforms: {self.emit_values(spec.values['uniforms'])},\n"
            f"        }},\n"
            f"        programs: {programs},\n"
            f"    }},\n"
            f"}};\n"
        )
        return name

    def emit_group(self, group: Group) -> str:
        children = [self.emit_node(child) for child in group.children]
        name = self.fresh("G")
        entries = ",\n    ".join(children)
        self.body.append(f"static {name}_CHILDREN: [Node; {len(children)}] = [\n    {entries},\n];\n")
        self.body.append(f"static {name}: Group = Group {{ name: {rust_string(group.name)}, children: &{name}_CHILDREN }};\n")
        return f"Node::Group(&{name})"

    def emit_node(self, node) -> str:
        if isinstance(node, Group):
            return self.emit_group(node)
        return f"Node::Case(&{self.emit_case(node)})"

    def finish(self, nodes: list, root_name: str) -> str:
        children = [self.emit_node(node) for node in nodes]
        entries = ",\n    ".join(children)
        self.body.append(f"static ROOT_CHILDREN: [Node; {len(children)}] = [\n    {entries},\n];\n")

        out = [
            "// @generated by hodow_cts/scripts/gen_shader_library.py - do not hand-edit.",
            "//",
            f"// Parsed from VK-GL-CTS `{self.source_path}` (plus whatever it imports).",
            "// Upstream revision: see hodow_cts/upstream/COMMIT.",
            "//",
            "// Copyright 2014 The Android Open Source Project",
            "// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).",
            "",
            "#![allow(unused_imports)]",
            "",
            "use crate::gls::shader_library::{Case, CaseSpec, CaseType, Elements, ExpectResult, Group, Node, ProgramSpec, RequiredCapability, RequiredExtension, Value, ValueBlock};",
            "use crate::glu::shader_util::DataType;",
            "use crate::glu::{GlslVersion, ShaderType};",
            "use crate::glw;",
            "",
        ]
        out.extend(self.string_lines)
        out.append("")
        out.extend(self.body)
        out.append(f"pub static ROOT: Group = Group {{ name: {rust_string(root_name)}, children: &ROOT_CHILDREN }};")
        out.append("")
        return "\n".join(out)


# ---------------------------------------------------------------------------
# Driver
# ---------------------------------------------------------------------------

REPO_ROOT = Path(__file__).resolve().parent.parent
OUT_DIR = REPO_ROOT / "src" / "generated" / "shader_library"
INDEX_PATH = REPO_ROOT / "src" / "generated" / "shader_library.rs"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--cts-dir", default=str(REPO_ROOT.parent / "tmp" / "VK-GL-CTS"))
    ap.add_argument("--check", action="store_true", help="fail if the committed output is stale")
    args = ap.parse_args()

    data_dir = Path(args.cts_dir) / "data"
    if not data_dir.is_dir():
        print(f"error: no shader-library data at {data_dir}", file=sys.stderr)
        return 1

    # The ES 2.0 and ES 3.0 modules keep one flat directory each; the ES 3.1 module keeps
    # one per GLSL version, since its groups run the same case list against both.
    roots = [
        ("gles2", data_dir / "gles2" / "shaders"),
        ("gles3", data_dir / "gles3" / "shaders"),
        ("es31", data_dir / "gles31" / "shaders" / "es31"),
        ("es32", data_dir / "gles31" / "shaders" / "es32"),
    ]

    files = []
    for api, root in roots:
        if not root.is_dir():
            print(f"error: no shader-library data at {root}", file=sys.stderr)
            return 1
        for path in sorted(root.glob("*.test")):
            files.append((f"{api}_{path.stem}", api, path))

    generated: dict[Path, str] = {}
    index_entries = []
    total_cases = 0

    for module, api, path in files:
        nodes = Parser(path).parse()
        relative = path.relative_to(Path(args.cts_dir)).as_posix()
        emitter = Emitter(module, relative)
        text = emitter.finish(nodes, api)
        generated[OUT_DIR / f"{module}.rs"] = text
        index_entries.append((module, relative, emitter.num_cases))
        total_cases += emitter.num_cases

    index = [
        "// @generated by hodow_cts/scripts/gen_shader_library.py - do not hand-edit.",
        "//",
        "// One module per upstream `.test` shader-library file. Each exposes a `ROOT` group",
        "// that `gls::shader_library::create_group` turns into a case tree.",
        "",
    ]
    for module, relative, num_cases in index_entries:
        index.append(f"/// `{relative}` - {num_cases} cases.")
        index.append(f"pub mod {module};")
        index.append("")
    index_text = "\n".join(index)
    generated[INDEX_PATH] = index_text

    if args.check:
        stale = [p for p, text in generated.items() if not p.exists() or p.read_text() != text]
        for path in sorted(OUT_DIR.glob("*.rs")) if OUT_DIR.is_dir() else []:
            if path not in generated:
                stale.append(path)
        if stale:
            for path in stale:
                print(f"stale: {path.relative_to(REPO_ROOT)}", file=sys.stderr)
            return 1
        print(f"shader library up to date ({total_cases} cases in {len(files)} modules)")
        return 0

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for path in OUT_DIR.glob("*.rs"):
        if path not in generated:
            path.unlink()
    for path, text in generated.items():
        path.write_text(text)

    print(f"wrote {len(files)} modules, {total_cases} cases")
    return 0


if __name__ == "__main__":
    sys.exit(main())
