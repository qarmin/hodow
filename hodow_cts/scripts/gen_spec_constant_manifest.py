#!/usr/bin/env python3
"""Writes shaders/manifest/pipeline_spec_constant.toml.

A port of the case tables of vktPipelineSpecConstantTests.cpp: `createDefaultValueTests`, `createBasicSpecializationTests`,
`createWorkGroupSizeTests`, `createBuiltInOverrideTests`, `createExpressionTests` and `createCompositeTests` (with the
`composite_case_internal` generators), expanded for every shader stage they are registered under. The GLSL a case contributes
(specialization constant declarations, SSBO members, global and main code) is written down once, here, and substituted by
the stage templates under shaders/src/pipeline/spec_constant/; what the host needs (the constants' IDs, sizes and values, the
expected values, the required features) rides along as the `params` the Rust side parses. A case name is its test path with the
groups joined by `__`, which is how the Rust side builds the group tree and looks a case up.

Not in the manifest: `unaligned_spec_constant` and `same_id`, which build their own compute shaders and pipelines.
"""

import json
import struct
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "shaders" / "manifest" / "pipeline_spec_constant.toml"
TEMPLATES = "pipeline/spec_constant"

PACK = {"i8": "<b", "u8": "<B", "i16": "<h", "u16": "<H", "i32": "<i", "u32": "<I", "i64": "<q", "u64": "<Q", "f16": "<e", "f32": "<f", "f64": "<d", "b32": "<I"}


def value_bytes(kind, number):
    """`makeValue*` - the bytes of a `GenericValue`, without the zero padding."""
    if kind == "b32":
        number = 1 if number else 0
    return struct.pack(PACK[kind], number)


class SpecConstant:
    def __init__(self, spec_id, decl, size=0, value=None, force_use=False):
        self.spec_id = spec_id
        self.decl = decl
        self.size = size
        self.value = value
        self.force_use = force_use

    def declaration(self):
        return self.decl.replace("${ID}", str(self.spec_id), 1)

    def encoded(self):
        data = value_bytes(*self.value) if self.value is not None else b""
        assert len(data) <= 8 and (self.size == 0 or len(data) >= self.size), (self.decl, self.size, data)
        return "%d,%d,%d,%s" % (self.spec_id, self.size, 1 if self.force_use else 0, data[: self.size].hex())


def sc(spec_id, decl, size=0, value=None, force_use=False):
    return SpecConstant(spec_id, decl, size, value, force_use)


def ov(size, offset, value):
    """`OffsetValue`"""
    data = value_bytes(*value)
    assert len(data) >= size, (size, value)
    return "%d,%d,%s" % (size, offset, data[:size].hex())


class Case:
    def __init__(self, name, specs, ssbo_size, ssbo, glob, main, expected, requirements=(), pack_data=False):
        self.name = name
        self.specs = specs
        self.ssbo_size = ssbo_size
        self.ssbo = ssbo
        self.glob = glob
        self.main = main
        self.expected = expected
        self.requirements = requirements
        self.pack_data = pack_data


def case(name, specs, ssbo_size, ssbo, glob, main, expected, requirements=(), pack_data=False):
    return Case(name, specs, ssbo_size, ssbo, glob, main, expected, requirements, pack_data)


def v(kind, number):
    return (kind, number)


I8, I16, I64, F16, F64 = "int8", "int16", "int64", "float16", "float64"

# ----- default_value -----

DEFAULT_VALUE = [
    case("bool",
         [sc(1, "layout(constant_id = ${ID}) const bool sc0 = true;"), sc(2, "layout(constant_id = ${ID}) const bool sc1 = false;")],
         8, "    bool r0;\n    bool r1;\n", "", "    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n",
         [ov(4, 0, v("b32", True)), ov(4, 4, v("b32", False))]),
    case("int8",
         [sc(1, "layout(constant_id = ${ID}) const int8_t sc0 = int8_t(1);"), sc(2, "layout(constant_id = ${ID}) const int8_t sc1 = int8_t(-2);")],
         2, "    int8_t r0;\n    int8_t r1;\n", "", "    int8_t aux = sc0 + sc1;\n    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n",
         [ov(1, 0, v("i8", 1)), ov(1, 1, v("i8", -2))], [I8]),
    case("uint8",
         [sc(1, "layout(constant_id = ${ID}) const uint8_t sc0 = int8_t(15);"), sc(2, "layout(constant_id = ${ID}) const uint8_t sc1 = int8_t(43);")],
         2, "    uint8_t r0;\n    uint8_t r1;\n", "", "    uint8_t aux = sc0 + sc1;\n    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n",
         [ov(1, 0, v("u8", 15)), ov(1, 1, v("u8", 43))], [I8]),
    case("int16",
         [sc(1, "layout(constant_id = ${ID}) const int16_t sc0 = 20000s;", 2, v("i16", 32000)), sc(2, "layout(constant_id = ${ID}) const int16_t sc1 = -20000s;")],
         4, "    int16_t r0;\n    int16_t r1;\n", "", "    int16_t aux = sc0 + sc1;\n    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n",
         [ov(2, 0, v("i16", 32000)), ov(2, 2, v("i16", -20000))], [I16]),
    case("uint16",
         [sc(1, "layout(constant_id = ${ID}) const uint16_t sc0 = 64000us;"), sc(2, "layout(constant_id = ${ID}) const uint16_t sc1 = 51829us;")],
         4, "    uint16_t r0;\n    uint16_t r1;\n", "", "    uint16_t aux = sc0 + sc1;\n    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n",
         [ov(2, 0, v("u16", 64000)), ov(2, 2, v("u16", 51829))], [I16]),
    case("int",
         [sc(1, "layout(constant_id = ${ID}) const int sc0 = -3;"), sc(2, "layout(constant_id = ${ID}) const int sc1 = 17;")],
         8, "    int r0;\n    int r1;\n", "", "    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n",
         [ov(4, 0, v("i32", -3)), ov(4, 4, v("i32", 17))]),
    case("uint",
         [sc(1, "layout(constant_id = ${ID}) const uint sc0 = 42u;")],
         4, "    uint r0;\n", "", "    sb_out.r0 = sc0;\n",
         [ov(4, 0, v("u32", 42))]),
    case("int64",
         [sc(1, "layout(constant_id = ${ID}) const int64_t sc0 = 9141386509785772560l;"), sc(2, "layout(constant_id = ${ID}) const int64_t sc1 = -9141386509785772560l;")],
         16, "    int64_t r0;\n    int64_t r1;\n", "", "    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n",
         [ov(8, 0, v("i64", 9141386509785772560)), ov(8, 8, v("i64", -9141386509785772560))], [I64]),
    case("uint64",
         [sc(1, "layout(constant_id = ${ID}) const uint64_t sc0 = 18364758544493064720ul;"), sc(2, "layout(constant_id = ${ID}) const uint64_t sc1 = 17298946664678735070ul;")],
         16, "    uint64_t r0;\n    uint64_t r1;\n", "", "    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n",
         [ov(8, 0, v("u64", 18364758544493064720)), ov(8, 8, v("u64", 17298946664678735070))], [I64]),
    case("float16",
         [sc(1, "layout(constant_id = ${ID}) const float16_t sc0 = 7.5hf;"), sc(2, "layout(constant_id = ${ID}) const float16_t sc1 = 1.125hf;")],
         4, "    float16_t r0;\n    float16_t r1;\n", "", "    float16_t aux = sc0 + sc1;\n    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n",
         [ov(2, 0, v("f16", 7.5)), ov(2, 2, v("f16", 1.125))], [F16]),
    case("float",
         [sc(1, "layout(constant_id = ${ID}) const float sc0 = 7.5;")],
         4, "    float r0;\n", "", "    sb_out.r0 = sc0;\n",
         [ov(4, 0, v("f32", 7.5))]),
    case("double",
         [sc(1, "layout(constant_id = ${ID}) const double sc0 = 2.75LF;")],
         8, "    double r0;\n", "", "    sb_out.r0 = sc0;\n",
         [ov(8, 0, v("f64", 2.75))], [F64]),
]

# ----- basic -----

MAIN2 = "    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n"
MAIN3 = "    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n    sb_out.r2 = sc2;\n"

BASIC = [
    case("bool",
         [sc(1, "layout(constant_id = ${ID}) const bool sc0 = true;", 4, v("b32", True)),
          sc(2, "layout(constant_id = ${ID}) const bool sc1 = false;", 4, v("b32", False)),
          sc(3, "layout(constant_id = ${ID}) const bool sc2 = true;", 4, v("b32", False)),
          sc(4, "layout(constant_id = ${ID}) const bool sc3 = false;", 4, v("b32", True))],
         16, "    bool r0;\n    bool r1;\n    bool r2;\n    bool r3;\n", "",
         "    sb_out.r0 = sc0;\n    sb_out.r1 = sc1;\n    sb_out.r2 = sc2;\n    sb_out.r3 = sc3;\n",
         [ov(4, 0, v("b32", True)), ov(4, 4, v("b32", False)), ov(4, 8, v("b32", False)), ov(4, 12, v("b32", True))]),
    case("int8",
         [sc(1, "layout(constant_id = ${ID}) const int8_t sc0 = int8_t(1);", 1, v("i8", 127)), sc(2, "layout(constant_id = ${ID}) const int8_t sc1 = int8_t(-2);")],
         2, "    int8_t r0;\n    int8_t r1;\n", "", "    int8_t aux = sc0 + sc1;\n" + MAIN2,
         [ov(1, 0, v("i8", 127)), ov(1, 1, v("i8", -2))], [I8]),
    case("int8_2",
         [sc(1, "layout(constant_id = ${ID}) const int8_t sc0 = int8_t(123);", 1, v("i8", 65)), sc(2, "layout(constant_id = ${ID}) const int8_t sc1 = int8_t(-33);", 1, v("i8", -128))],
         2, "    int8_t r0;\n    int8_t r1;\n", "", "    int8_t aux = sc0 + sc1;\n" + MAIN2,
         [ov(1, 0, v("i8", 65)), ov(1, 1, v("i8", -128))], [I8]),
    case("uint8",
         [sc(1, "layout(constant_id = ${ID}) const uint8_t sc0 = int8_t(15);", 1, v("u8", 254)), sc(2, "layout(constant_id = ${ID}) const uint8_t sc1 = int8_t(43);")],
         2, "    uint8_t r0;\n    uint8_t r1;\n", "", "    uint8_t aux = sc0 + sc1;\n" + MAIN2,
         [ov(1, 0, v("u8", 254)), ov(1, 1, v("u8", 43))], [I8]),
    case("uint8_2",
         [sc(1, "layout(constant_id = ${ID}) const uint8_t sc0 = int8_t(99);", 1, v("u8", 254)), sc(2, "layout(constant_id = ${ID}) const uint8_t sc1 = int8_t(81);", 1, v("u8", 255))],
         2, "    uint8_t r0;\n    uint8_t r1;\n", "", "    uint8_t aux = sc0 + sc1;\n" + MAIN2,
         [ov(1, 0, v("u8", 254)), ov(1, 1, v("u8", 255))], [I8]),
    case("int16",
         [sc(1, "layout(constant_id = ${ID}) const int16_t sc0 = 20000s;", 2, v("i16", 32000)), sc(2, "layout(constant_id = ${ID}) const int16_t sc1 = -20000s;")],
         4, "    int16_t r0;\n    int16_t r1;\n", "", "    int16_t aux = sc0 + sc1;\n" + MAIN2,
         [ov(2, 0, v("i16", 32000)), ov(2, 2, v("i16", -20000))], [I16]),
    case("int16_2",
         [sc(1, "layout(constant_id = ${ID}) const int16_t sc0 = 20000s;", 2, v("i16", 32000)), sc(2, "layout(constant_id = ${ID}) const int16_t sc1 = -20000s;", 2, v("i16", -21000))],
         4, "    int16_t r0;\n    int16_t r1;\n", "", "    int16_t aux = sc0 + sc1;\n" + MAIN2,
         [ov(2, 0, v("i16", 32000)), ov(2, 2, v("i16", -21000))], [I16]),
    case("uint16",
         [sc(1, "layout(constant_id = ${ID}) const uint16_t sc0 = 64000us;", 2, v("u16", 65000)), sc(2, "layout(constant_id = ${ID}) const uint16_t sc1 = 51829us;")],
         4, "    uint16_t r0;\n    uint16_t r1;\n", "", "    uint16_t aux = sc0 + sc1;\n" + MAIN2,
         [ov(2, 0, v("u16", 65000)), ov(2, 2, v("u16", 51829))], [I16]),
    case("uint16_2",
         [sc(1, "layout(constant_id = ${ID}) const uint16_t sc0 = 64000us;", 2, v("u16", 65000)), sc(2, "layout(constant_id = ${ID}) const uint16_t sc1 = 51829us;", 2, v("u16", 63000))],
         4, "    uint16_t r0;\n    uint16_t r1;\n", "", "    uint16_t aux = sc0 + sc1;\n" + MAIN2,
         [ov(2, 0, v("u16", 65000)), ov(2, 2, v("u16", 63000))], [I16]),
    case("int",
         [sc(1, "layout(constant_id = ${ID}) const int sc0 = -3;", 4, v("i32", 33)),
          sc(2, "layout(constant_id = ${ID}) const int sc1 = 91;"),
          sc(3, "layout(constant_id = ${ID}) const int sc2 = 17;", 4, v("i32", -15))],
         12, "    int r0;\n    int r1;\n    int r2;\n", "", MAIN3,
         [ov(4, 0, v("i32", 33)), ov(4, 4, v("i32", 91)), ov(4, 8, v("i32", -15))]),
    case("uint",
         [sc(1, "layout(constant_id = ${ID}) const uint sc0 = 42u;", 4, v("u32", 97)), sc(2, "layout(constant_id = ${ID}) const uint sc1 = 7u;")],
         8, "    uint r0;\n    uint r1;\n", "", MAIN2,
         [ov(4, 0, v("u32", 97)), ov(4, 4, v("u32", 7))]),
    case("uint_2",
         [sc(1, "layout(constant_id = ${ID}) const uint sc0 = 305419896u;", 4, v("u32", 1985229328)),
          sc(2, "layout(constant_id = ${ID}) const uint sc1 = 591751049u;"),
          sc(3, "layout(constant_id = ${ID}) const uint sc2 = 878082202u;", 4, v("u32", 1698898186))],
         12, "    uint r0;\n    uint r1;\n    uint r2;\n", "", MAIN3,
         [ov(4, 0, v("u32", 1985229328)), ov(4, 4, v("u32", 591751049)), ov(4, 8, v("u32", 1698898186))]),
    case("int64",
         [sc(1, "layout(constant_id = ${ID}) const int64_t sc0 = 9141386509785772560l;", 8, v("i64", 9137147825770275585)),
          sc(2, "layout(constant_id = ${ID}) const int64_t sc1 = -9141386509785772560l;")],
         16, "    int64_t r0;\n    int64_t r1;\n", "", MAIN2,
         [ov(8, 0, v("i64", 9137147825770275585)), ov(8, 8, v("i64", -9141386509785772560))], [I64]),
    case("int64_2",
         [sc(1, "layout(constant_id = ${ID}) const int64_t sc0 = 9141386509785772560l;", 8, v("i64", 9137147825770275585)),
          sc(2, "layout(constant_id = ${ID}) const int64_t sc1 = -9141386509785772560l;", 8, v("i64", -9137164382869201665))],
         16, "    int64_t r0;\n    int64_t r1;\n", "", MAIN2,
         [ov(8, 0, v("i64", 9137147825770275585)), ov(8, 8, v("i64", -9137164382869201665))], [I64]),
    case("uint64",
         [sc(1, "layout(constant_id = ${ID}) const uint64_t sc0 = 18364758544493064720ul;", 8, v("u64", 17279655951921914625)),
          sc(2, "layout(constant_id = ${ID}) const uint64_t sc1 = 17298946664678735070ul;")],
         16, "    uint64_t r0;\n    uint64_t r1;\n", "", MAIN2,
         [ov(8, 0, v("u64", 17279655951921914625)), ov(8, 8, v("u64", 17298946664678735070))], [I64]),
    case("uint64_2",
         [sc(1, "layout(constant_id = ${ID}) const uint64_t sc0 = 18364758544493064720ul;", 8, v("u64", 17279655951921914625)),
          sc(2, "layout(constant_id = ${ID}) const uint64_t sc1 = 17298946664678735070ul;", 8, v("u64", 17270123250533606145))],
         16, "    uint64_t r0;\n    uint64_t r1;\n", "", MAIN2,
         [ov(8, 0, v("u64", 17279655951921914625)), ov(8, 8, v("u64", 17270123250533606145))], [I64]),
    # We create some floating point values below as unsigned integers to make sure all bytes are set to different values, avoiding special patterns and denormals.
    case("float16",
         [sc(1, "layout(constant_id = ${ID}) const float16_t sc0 = 7.5hf;", 2, v("f16", 15.75)), sc(2, "layout(constant_id = ${ID}) const float16_t sc1 = 1.125hf;")],
         4, "    float16_t r0;\n    float16_t r1;\n", "", "    float16_t aux = sc0 + sc1;\n" + MAIN2,
         [ov(2, 0, v("f16", 15.75)), ov(2, 2, v("f16", 1.125))], [F16]),
    case("float16_2",
         [sc(1, "layout(constant_id = ${ID}) const float16_t sc0 = 7.5hf;", 2, v("u16", 0x0123)),
          sc(2, "layout(constant_id = ${ID}) const float16_t sc1 = 1.125hf;"),
          sc(3, "layout(constant_id = ${ID}) const float16_t sc2 = 1.125hf;", 2, v("u16", 0xFEDC))],
         6, "    float16_t r0;\n    float16_t r1;\n    float16_t r2;\n", "", "    float16_t aux = sc0 + sc1;\n" + MAIN3,
         [ov(2, 0, v("u16", 0x0123)), ov(2, 2, v("f16", 1.125)), ov(2, 4, v("u16", 0xFEDC))], [F16]),
    case("float",
         [sc(1, "layout(constant_id = ${ID}) const float sc0 = 7.5;", 4, v("f32", 15.75)), sc(2, "layout(constant_id = ${ID}) const float sc1 = 1.125;")],
         8, "    float r0;\n    float r1;\n", "", MAIN2,
         [ov(4, 0, v("f32", 15.75)), ov(4, 4, v("f32", 1.125))]),
    case("float_2",
         [sc(1, "layout(constant_id = ${ID}) const float sc0 = 7.5;", 4, v("u32", 0x01234567)),
          sc(2, "layout(constant_id = ${ID}) const float sc1 = 1.125;"),
          sc(3, "layout(constant_id = ${ID}) const float sc2 = 1.125;", 4, v("u32", 0xfedcba98))],
         12, "    float r0;\n    float r1;\n    float r2;\n", "", MAIN3,
         [ov(4, 0, v("u32", 0x01234567)), ov(4, 4, v("f32", 1.125)), ov(4, 8, v("u32", 0xfedcba98))]),
    case("double",
         [sc(1, "layout(constant_id = ${ID}) const double sc0 = 2.75LF;", 8, v("u64", 0xFEDCBA9876543210)), sc(2, "layout(constant_id = ${ID}) const double sc1 = 9.25LF;")],
         16, "    double r0;\n    double r1;\n", "", MAIN2,
         [ov(8, 0, v("u64", 0xFEDCBA9876543210)), ov(8, 8, v("f64", 9.25))], [F64]),
    case("double_2",
         [sc(1, "layout(constant_id = ${ID}) const double sc0 = 2.75LF;", 8, v("u64", 0xFEDCBA9876543210)),
          sc(2, "layout(constant_id = ${ID}) const double sc1 = 9.25LF;", 8, v("u64", 0xEFCDAB8967452301))],
         16, "    double r0;\n    double r1;\n", "", MAIN2,
         [ov(8, 0, v("u64", 0xFEDCBA9876543210)), ov(8, 8, v("u64", 0xEFCDAB8967452301))], [F64]),
    case("mixed",
         [sc(1, "layout(constant_id = ${ID}) const uint8_t  sc0 = uint8_t  (0);", 1, v("u8", 0x98)),
          sc(2, "layout(constant_id = ${ID}) const uint16_t sc1 = uint16_t (0);", 2, v("u16", 0x9876)),
          sc(3, "layout(constant_id = ${ID}) const uint     sc2 = uint     (0);", 4, v("u32", 0xba987654)),
          sc(4, "layout(constant_id = ${ID}) const uint64_t sc3 = uint64_t (0);", 8, v("u64", 0xfedcba9876543210))],
         8 + 4 + 2 + 1, "    uint64_t r0;\n    uint     r1;\n    uint16_t r2;\n    uint8_t  r3;\n", "",
         "    uint64_t i0 = sc3;\n    uint     i1 = sc2;\n    uint16_t i2 = sc1;\n    uint8_t  i3 = sc0;\n    sb_out.r0 = i0;\n    sb_out.r1 = i1;\n    sb_out.r2 = i2;\n    sb_out.r3 = i3;\n",
         [ov(8, 0, v("u64", 0xfedcba9876543210)), ov(4, 8, v("u32", 0xba987654)), ov(2, 12, v("u16", 0x9876)), ov(1, 14, v("u8", 0x98))], [I8, I16, I64]),
    case("mixed_reversed",
         [sc(1, "layout(constant_id = ${ID}) const uint64_t sc3 = uint64_t (0);", 8, v("u64", 0xfedcba9876543210)),
          sc(2, "layout(constant_id = ${ID}) const uint     sc2 = uint     (0);", 4, v("u32", 0xba987654)),
          sc(3, "layout(constant_id = ${ID}) const uint16_t sc1 = uint16_t (0);", 2, v("u16", 0x9876)),
          sc(4, "layout(constant_id = ${ID}) const uint8_t  sc0 = uint8_t  (0);", 1, v("u8", 0x98))],
         8 + 4 + 2 + 1, "    uint64_t r0;\n    uint     r1;\n    uint16_t r2;\n    uint8_t  r3;\n", "",
         "    uint64_t i0 = sc3;\n    uint     i1 = sc2;\n    uint16_t i2 = sc1;\n    uint8_t  i3 = sc0;\n    sb_out.r0 = i0;\n    sb_out.r1 = i1;\n    sb_out.r2 = i2;\n    sb_out.r3 = i3;\n",
         [ov(8, 0, v("u64", 0xfedcba9876543210)), ov(4, 8, v("u32", 0xba987654)), ov(2, 12, v("u16", 0x9876)), ov(1, 14, v("u8", 0x98))], [I8, I16, I64]),
]

# `defsUnusedCases`: they carry their own packData and are registered once, as listed
BASIC_UNUSED = [
    case("unused_single",
         [sc(0, "", 0, None, True)],
         4, "    int r0;\n", "", "    sb_out.r0 = 77;\n",
         [ov(4, 0, v("i32", 77))], (), False),
    case("unused_single_packed",
         [sc(0, "", 0, None, True), sc(1, "layout(constant_id = ${ID}) const int sc1 = 0;", 4, v("i32", 100))],
         4, "    int r1;\n", "", "    sb_out.r1 = sc1;\n",
         [ov(4, 0, v("i32", 100))], (), True),
    case("unused_multiple",
         [sc(7, "layout(constant_id = ${ID}) const int sc0 = 0;", 4, v("i32", -999)), sc(1, "", 0, None, True),
          sc(17, "layout(constant_id = ${ID}) const int sc1 = 0;", 4, v("i32", 999)), sc(3, "", 0, None, True)],
         8, "    int r0;\n    int r1;\n", "", MAIN2,
         [ov(4, 0, v("i32", -999)), ov(4, 4, v("i32", 999))], (), False),
    case("unused_multiple_packed",
         [sc(7, "layout(constant_id = ${ID}) const int sc0 = 0;", 4, v("i32", -999)), sc(1, "", 0, None, True), sc(3, "", 0, None, True),
          sc(17, "layout(constant_id = ${ID}) const int sc1 = 0;", 4, v("i32", 999))],
         8, "    int r0;\n    int r1;\n", "", MAIN2,
         [ov(4, 0, v("i32", -999)), ov(4, 4, v("i32", 999))], (), True),
]

# ----- local_size (compute only) -----

LS_SSBO = "    uvec3 workGroupSize;\n    uint  checksum;\n"
LS_GLOBAL = "shared uint count;\n"
LS_MAIN = ("    count = 0u;\n\n    groupMemoryBarrier();\n    barrier();\n\n    atomicAdd(count, 1u);\n\n"
           "    groupMemoryBarrier();\n    barrier();\n\n    sb_out.workGroupSize = gl_WorkGroupSize;\n    sb_out.checksum      = count;\n")


def ls_case(name, specs, sizes, checksum):
    sx, sy, sz = sizes
    return case(name, specs, 16, LS_SSBO, LS_GLOBAL, LS_MAIN,
                [ov(4, 0, v("u32", sx)), ov(4, 4, v("u32", sy)), ov(4, 8, v("u32", sz)), ov(4, 12, v("u32", checksum))])


def ls(axis, spec_id, value):
    return sc(spec_id, "layout(local_size_%s_id = ${ID}) in;" % axis, 4, v("u32", value))


LOCAL_SIZE = [
    ls_case("x", [ls("x", 1, 7)], (7, 1, 1), 7),
    ls_case("y", [ls("y", 1, 5)], (1, 5, 1), 5),
    ls_case("z", [ls("z", 1, 3)], (1, 1, 3), 3),
    ls_case("xy", [ls("x", 1, 6), ls("y", 2, 4)], (6, 4, 1), 6 * 4),
    ls_case("xz", [ls("x", 1, 3), ls("z", 2, 9)], (3, 1, 9), 3 * 9),
    ls_case("yz", [ls("y", 1, 2), ls("z", 2, 5)], (1, 2, 5), 2 * 5),
    ls_case("xyz", [ls("x", 1, 3), ls("y", 2, 5), ls("z", 3, 7)], (3, 5, 7), 3 * 5 * 7),
]

# ----- builtin -----

BUILTIN = [
    case("default",
         [sc(1, "layout(constant_id = ${ID}) gl_MaxImageUnits;")],
         4, "    bool ok;\n", "", "    sb_out.ok = (gl_MaxImageUnits >= 8);\n",  # implementation defined, 8 is the minimum
         [ov(4, 0, v("b32", True))]),
    case("specialized",
         [sc(1, "layout(constant_id = ${ID}) gl_MaxImageUnits;", 4, v("i32", 12))],
         4, "    int maxImageUnits;\n", "", "    sb_out.maxImageUnits = gl_MaxImageUnits;\n",
         [ov(4, 0, v("i32", 12))]),
]

# ----- expression -----

EXPRESSION = [
    case("spec_const_expression",
         [sc(1, "layout(constant_id = ${ID}) const int sc0 = 2;"), sc(2, "layout(constant_id = ${ID}) const int sc1 = 3;", 4, v("i32", 5))],
         4, "    int result;\n",
         "const int expr0 = sc0 + 1;\nconst int expr1 = sc0 + sc1;\n",
         "    sb_out.result = expr0 + expr1;\n",
         [ov(4, 0, v("i32", 10))]),
    case("array_size",
         [sc(1, "layout(constant_id = ${ID}) const int sc0 = 1;"), sc(2, "layout(constant_id = ${ID}) const int sc1 = 2;", 4, v("i32", 3))],
         16, "    int r0;\n    int r1[3];\n", "",
         "    int a0[sc0];\n    int a1[sc1];\n\n    for (int i = 0; i < sc0; ++i)\n        a0[i] = sc0 - i;\n    for (int i = 0; i < sc1; ++i)\n        a1[i] = sc1 - i;\n\n"
         "    sb_out.r0 = a0[0];\n    for (int i = 0; i < sc1; ++i)\n         sb_out.r1[i] = a1[i];\n",
         [ov(4, 0, v("i32", 1)), ov(4, 4, v("i32", 3)), ov(4, 8, v("i32", 2)), ov(4, 12, v("i32", 1))]),
    case("array_size_expression",
         [sc(1, "layout(constant_id = ${ID}) const int sc0 = 3;"), sc(2, "layout(constant_id = ${ID}) const int sc1 = 5;", 4, v("i32", 7))],
         8, "    int r0;\n    int r1;\n", "",
         "    int a0[sc0 + 3];\n    int a1[sc0 + sc1];\n\n    const int size0 = sc0 + 3;\n    const int size1 = sc0 + sc1;\n\n"
         "    for (int i = 0; i < size0; ++i)\n        a0[i] = 3 - i;\n    for (int i = 0; i < size1; ++i)\n        a1[i] = 5 - i;\n\n"
         "    sb_out.r0 = a0[size0 - 1];\n    sb_out.r1 = a1[size1 - 1];\n",
         [ov(4, 0, v("i32", -2)), ov(4, 4, v("i32", -4))]),
    case("array_size_spec_const_expression",
         [sc(1, "layout(constant_id = ${ID}) const int sc0 = 3;"), sc(2, "layout(constant_id = ${ID}) const int sc1 = 5;", 4, v("i32", 7))],
         8, "    int r0;\n    int r1;\n", "",
         "    const int size0 = sc0 + 3;\n    const int size1 = sc0 + sc1;\n\n    int a0[size0];\n    int a1[size1];\n\n"
         "    for (int i = 0; i < size0; ++i)\n        a0[i] = 3 - i;\n    for (int i = 0; i < size1; ++i)\n        a1[i] = 5 - i;\n\n"
         "    sb_out.r0 = a0[size0 - 1];\n    sb_out.r1 = a1[size1 - 1];\n",
         [ov(4, 0, v("i32", -2)), ov(4, 4, v("i32", -4))]),
    case("array_size_length",
         [sc(1, "layout(constant_id = ${ID}) const int sc0 = 1;"), sc(2, "layout(constant_id = ${ID}) const int sc1 = 2;", 4, v("i32", 4))],
         8, "    int r0;\n    int r1;\n", "",
         "    int a0[sc0];\n    int a1[sc1];\n\n    sb_out.r0 = a0.length();\n    sb_out.r1 = a1.length();\n",
         [ov(4, 0, v("i32", 1)), ov(4, 4, v("i32", 4))]),
    case("array_size_pass_to_function",
         [sc(1, "layout(constant_id = ${ID}) const int sc0 = 3;"), sc(2, "layout(constant_id = ${ID}) const int sc1 = 1;", 4, v("i32", 3))],
         4, "    int result;\n",
         "int sumArrays (int a0[sc0], int a1[sc1])\n{\n    int sum = 0;\n    for (int i = 0; (i < sc0) && (i < sc1); ++i)\n        sum += a0[i] + a1[i];\n    return sum;\n}\n",
         "    int a0[sc0];\n    int a1[sc1];\n\n    for (int i = 0; i < sc0; ++i)\n        a0[i] = i + 1;\n    for (int i = 0; i < sc1; ++i)\n        a1[i] = i + 2;\n\n"
         "    sb_out.result = sumArrays(a0, a1);\n",
         [ov(4, 0, v("i32", 15))]),
]

# ----- composite -----

SCALARS = {"float": ("float", 4), "double": ("double", 8), "int": ("int", 4), "uint": ("uint", 4), "bool": ("bool", 4)}
VEC_PREFIX = {"float": "", "double": "d", "int": "i", "uint": "u", "bool": "b"}


class DataType:
    """The parts of a `glu::DataType` the composite cases use."""

    def __init__(self, name, scalar, cols, rows):
        self.name = name
        self.scalar = scalar  # float/double/int/uint/bool
        self.cols = cols  # matrix columns, or the vector component count; 1 for scalars
        self.rows = rows  # matrix rows, 0 for vectors and scalars
        self.is_matrix = rows > 0
        self.is_vector = rows == 0 and cols > 1
        self.is_scalar = cols == 1 and rows == 0

    def scalar_size(self):
        return self.cols * max(self.rows, 1)

    def scalar_bytes(self):
        return SCALARS[self.scalar][1]


def make_vec(scalar, n):
    return DataType("%svec%d" % (VEC_PREFIX[scalar], n), scalar, n, 0)


def make_mat(scalar, c, r):
    prefix = "d" if scalar == "double" else ""
    name = "%smat%d" % (prefix, c) if c == r else "%smat%dx%d" % (prefix, c, r)
    return DataType(name, scalar, c, r)


def make_scalar(scalar):
    return DataType(scalar, scalar, 1, 0)


MAT_SHAPES = [(2, 2), (2, 3), (2, 4), (3, 2), (3, 3), (3, 4), (4, 2), (4, 3), (4, 4)]
VECTOR_TYPES = [make_vec(s, n) for s in ("float", "double", "bool", "int", "uint") for n in (2, 3, 4)]
MATRIX_TYPES = [make_mat(s, c, r) for s in ("float", "double") for c, r in MAT_SHAPES]
ALL_TYPES = (
    [make_scalar("float")] + [make_vec("float", n) for n in (2, 3, 4)] + [make_mat("float", c, r) for c, r in MAT_SHAPES]
    + [make_scalar("double")] + [make_vec("double", n) for n in (2, 3, 4)] + [make_mat("double", c, r) for c, r in MAT_SHAPES]
    + [make_scalar("int")] + [make_vec("int", n) for n in (2, 3, 4)]
    + [make_scalar("uint")] + [make_vec("uint", n) for n in (2, 3, 4)]
    + [make_scalar("bool")] + [make_vec("bool", n) for n in (2, 3, 4)]
)


def make_value(scalar, spec_value):
    if scalar == "double":
        return ("f64", float(spec_value))
    if scalar == "float":
        return ("f32", float(spec_value))
    return ("i32", spec_value)


def initializer_list(ty, cast, idx_begin, idx_end, spec_name, spec_ndx):
    items = []
    for i in range(idx_begin, idx_end):
        i_val = spec_name if i == spec_ndx else ("true" if ty.scalar == "bool" else str(i + 1))
        items.append("%s(%s)" % (ty.name, i_val) if cast else i_val)
    return ", ".join(items)


def array_constructor(elem, size1, size2, spec_name, spec_ndx):
    do_cast = not elem.is_scalar
    if size2 > 0:
        padding = " " * 36
        parts = []
        idx_begin, idx_end = 0, size2
        for iter_ndx in range(size1):
            text = "%s[%d](" % (elem.name, size2) + initializer_list(elem, do_cast, idx_begin, idx_end, spec_name, spec_ndx) + ")"
            parts.append(("" if iter_ndx == 0 else ",\n" + padding) + text)
            idx_begin += size2
            idx_end += size2
        return "".join(parts)
    return initializer_list(elem, do_cast, 0, size1, spec_name, spec_ndx)


def expected_values(spec_value, scalar, num_combinations):
    out = []
    size = SCALARS[scalar][1]
    for comb in range(num_combinations):
        total = 0
        for i in range(num_combinations):
            total += spec_value if i == comb else (1 if scalar == "bool" else i + 1)
        out.append(ov(size, size * comb, make_value(scalar, total)))
    return out


def first_element_subscript(ty):
    return "[0][0]" if ty.is_matrix else ("[0]" if ty.is_vector else "")


def checksum_code(elem, var_name, accum_type, size1, size2, num_combinations):
    out = []
    for comb in range(num_combinations):
        out.append("    %s sum_%s%d = %s(0);\n" % (accum_type, var_name, comb, accum_type))
    if size2 > 0:
        out.append("\n    for (int i = 0; i < %d; ++i)\n    for (int j = 0; j < %d; ++j)\n    {\n" % (size1, size2))
        for comb in range(num_combinations):
            out.append("        sum_%s%d += %s(%s%d[i][j]%s);\n" % (var_name, comb, accum_type, var_name, comb, first_element_subscript(elem)))
    else:
        out.append("\n    for (int i = 0; i < %d; ++i)\n    {\n" % size1)
        for comb in range(num_combinations):
            out.append("        sum_%s%d += %s(%s%d[i]%s);\n" % (var_name, comb, accum_type, var_name, comb, first_element_subscript(elem)))
    out.append("    }\n\n")
    for comb in range(num_combinations):
        out.append("    sb_out.result[%d] = sum_%s%d;\n" % (comb, var_name, comb))
    return "".join(out)


def make_spec_constant(spec_name, spec_id, scalar, spec_value):
    type_name = SCALARS[scalar][0]
    return sc(spec_id, "layout(constant_id = ${ID}) const %s %s = %s(1);" % (type_name, spec_name, type_name), SCALARS[scalar][1], make_value(scalar, spec_value))


def requirement_of(scalar):
    return [F64] if scalar == "double" else []


def matrix_vector_case(ty):
    var_name = "m" if ty.is_matrix else "v"
    num_combinations = ty.scalar_size()
    is_const = ty.scalar not in ("float", "double")

    glob = ""
    for comb in range(num_combinations):
        glob += "%s%s %s%d = %s(%s);\n" % ("const " if is_const else "", ty.name, var_name, comb, ty.name, initializer_list(ty, False, 0, num_combinations, "sc0", comb))

    is_bool = ty.scalar == "bool"
    spec_value = 0 if is_bool else 42
    accum_type = "int" if is_bool else ty.scalar
    size1 = ty.cols
    size2 = ty.rows if ty.is_matrix else 0
    scalar_type = make_scalar(ty.scalar)

    return case(ty.name, [make_spec_constant("sc0", 1, ty.scalar, spec_value)], ty.scalar_bytes() * num_combinations,
                "    %s result[%d];\n" % (accum_type, num_combinations), glob,
                checksum_code(scalar_type, var_name, accum_type, size1, size2, num_combinations),
                expected_values(spec_value, ty.scalar, num_combinations), requirement_of(ty.scalar))


def array_case(elem, size1, size2=0):
    is_array_of_array = size2 > 0
    var_name = "a"
    array_size_decl = "[%d]" % size1 + ("[%d]" % size2 if is_array_of_array else "")
    num_combinations = size1 * size2 if is_array_of_array else size1

    glob = ""
    for comb in range(num_combinations):
        glob += "%s %s%d%s = %s%s(%s);\n" % (elem.name, var_name, comb, array_size_decl, elem.name, array_size_decl, array_constructor(elem, size1, size2, "sc0", comb))

    is_bool = elem.scalar == "bool"
    spec_value = 0 if is_bool else 19
    case_name = ("array_" if is_array_of_array else "") + elem.name
    accum_type = "int" if is_bool else elem.scalar

    return case(case_name, [make_spec_constant("sc0", 1, elem.scalar, spec_value)], elem.scalar_bytes() * num_combinations,
                "    %s result[%d];\n" % (accum_type, num_combinations), glob,
                checksum_code(elem, var_name, accum_type, size1, size2, num_combinations),
                expected_values(spec_value, elem.scalar, num_combinations), requirement_of(elem.scalar))


def struct_case(member):
    glob = ("struct Data {\n    int   i;\n    float f;\n    bool  b;\n    %s sc;\n    uint  ui;\n};\n\nData s0 = Data(3, 2.0, true, %s(sc0), 8u);\n" % (member.name, member.name))

    is_bool = member.scalar == "bool"
    spec_value = 0 if is_bool else 23
    checksum = 3 + 2 + 1 + spec_value + 8  # matches the shader code
    accum_type = "int" if is_bool else member.scalar
    accum_bytes = SCALARS[accum_type][1]

    main = ("    %s sum_s0 = %s(0);\n\n    sum_s0 += %s(s0.i);\n    sum_s0 += %s(s0.f);\n    sum_s0 += %s(s0.b);\n    sum_s0 += %s(s0.sc%s);\n    sum_s0 += %s(s0.ui);\n\n    sb_out.result = sum_s0;\n"
            % (accum_type, accum_type, accum_type, accum_type, accum_type, accum_type, first_element_subscript(member), accum_type))

    return case(member.name, [make_spec_constant("sc0", 1, member.scalar, spec_value)], accum_bytes, "    %s result;\n" % accum_type, glob, main,
                [ov(member.scalar_bytes(), 0, make_value(member.scalar, checksum))], requirement_of(member.scalar))


def special_array_of_struct():
    checksum = (3 + 2 + 1) + (1 + 5 + 1) + (1 + 2 + 0)
    return case("struct",
                [sc(1, "layout(constant_id = ${ID}) const int   sc0 = 1;", 4, v("i32", 3)),
                 sc(2, "layout(constant_id = ${ID}) const float sc1 = 1.0;", 4, v("f32", 5.0)),
                 sc(3, "layout(constant_id = ${ID}) const bool  sc2 = true;", 4, v("b32", False))],
                4, "    int result;\n",
                "struct Data {\n    int   x;\n    float y;\n    bool  z;\n};\n\nData a0[3] = Data[3](Data(sc0, 2.0, true), Data(1, sc1, true), Data(1, 2.0, sc2));\n",
                "    int sum_a0 = 0;\n\n    for (int i = 0; i < 3; ++i)\n        sum_a0 += int(a0[i].x) + int(a0[i].y) + int(a0[i].z);\n\n    sb_out.result = sum_a0;\n",
                [ov(4, 0, v("i32", checksum))])


def special_struct_with_array():
    checksum = 1 + 2 + 31 + 4 + 0
    return case("array",
                [sc(1, "layout(constant_id = ${ID}) const float sc0 = 1.0;", 4, v("f32", 31.0))],
                4, "    float result;\n",
                "struct Data {\n    int  i;\n    vec3 sc[3];\n    bool b;\n};\n\nData s0 = Data(1, vec3[3](vec3(2.0), vec3(sc0), vec3(4.0)), false);\n",
                "    float sum_s0 = 0;\n\n    sum_s0 += float(s0.i);\n    sum_s0 += float(s0.sc[0][0]);\n    sum_s0 += float(s0.sc[1][0]);\n    sum_s0 += float(s0.sc[2][0]);\n    sum_s0 += float(s0.b);\n\n    sb_out.result = sum_s0;\n",
                [ov(4, 0, v("f32", float(checksum)))])


def special_struct_of_struct():
    checksum = 1 + 2 + 11 + 4 + 1
    return case("struct",
                [sc(1, "layout(constant_id = ${ID}) const int sc0 = 1;", 4, v("i32", 11))],
                4, "    int result;\n",
                "struct Nested {\n    vec2  v;\n    int   sc;\n    float f;\n};\n\nstruct Data {\n    uint   ui;\n    Nested s;\n    bool   b;\n};\n\nData s0 = Data(1u, Nested(vec2(2.0), sc0, 4.0), true);\n",
                "    int sum_s0 = 0;\n\n    sum_s0 += int(s0.ui);\n    sum_s0 += int(s0.s.v[0]);\n    sum_s0 += int(s0.s.sc);\n    sum_s0 += int(s0.s.f);\n    sum_s0 += int(s0.b);\n\n    sb_out.result = sum_s0;\n",
                [ov(4, 0, v("i32", checksum))])


COMPOSITE = []  # (subgroup, case)
for ty in VECTOR_TYPES:
    COMPOSITE.append(("vector", matrix_vector_case(ty)))
for ty in MATRIX_TYPES:
    COMPOSITE.append(("matrix", matrix_vector_case(ty)))
for ty in ALL_TYPES:
    COMPOSITE.append(("array", array_case(ty, 3)))
for ty in ALL_TYPES:
    COMPOSITE.append(("array", array_case(ty, 3, 2)))
COMPOSITE.append(("array", special_array_of_struct()))
for ty in ALL_TYPES:
    COMPOSITE.append(("struct", struct_case(ty)))
COMPOSITE.append(("struct", special_struct_with_array()))
COMPOSITE.append(("struct", special_struct_of_struct()))

# ----- emission -----

EXTENSIONS = {
    I64: "#extension GL_EXT_shader_explicit_arithmetic_types_int64 : require\n",
    I16: "#extension GL_EXT_shader_explicit_arithmetic_types_int16 : require\n",
    I8: "#extension GL_EXT_shader_explicit_arithmetic_types_int8 : require\n",
    F16: "#extension GL_EXT_shader_explicit_arithmetic_types_float16 : require\n",
}

# stage -> (spec stage program name, [(program name, template, plain?)])
STAGES = {
    "vertex": [("vert", "spec.vert", "vert"), ("frag", "plain.frag", "frag")],
    "fragment": [("vert", "plain.vert", "vert"), ("frag", "spec.frag", "frag")],
    "tess_control": [("vert", "plain.vert", "vert"), ("frag", "plain.frag", "frag"), ("tesc", "spec.tesc", "tesc"), ("tese", "plain.tese", "tese")],
    "tess_eval": [("vert", "plain.vert", "vert"), ("frag", "plain.frag", "frag"), ("tesc", "plain.tesc", "tesc"), ("tese", "spec.tese", "tese")],
    "geometry": [("vert", "plain.vert", "vert"), ("frag", "plain.frag", "frag"), ("geom", "spec.geom", "geom")],
    "compute": [("comp", "spec.comp", "comp")],
}


def py_literal(text):
    """A Python string literal, as the TOML string `derived` evaluates."""
    return json.dumps(repr(text))


def emit_case(out, path, stage, c):
    name = "__".join(path + [c.name])
    const = "SPEC_" + "_".join(path + [c.name]).upper()
    extensions = "".join(EXTENSIONS[r] for r in (I64, I16, I8, F16) if r in c.requirements)
    spec_block = "".join(s.declaration() + "\n" for s in c.specs) + "\n"
    ssbo_block = "layout (set = 0, binding = 0, std430) writeonly buffer Output {\n" + c.ssbo + "} sb_out;\n\n"
    global_block = c.glob + "\n"

    programs = ", ".join('{ name = "%s", template = "%s/%s", stage = "%s" }' % (pname, TEMPLATES, tmpl, st) for pname, tmpl, st in STAGES[stage])
    out.append("[[case]]")
    out.append("name = %s" % json.dumps(name))
    out.append("rust_const = %s" % json.dumps(const))
    out.append('rust_type = "SpecConstantPrograms"')
    out.append("programs = [ %s ]" % programs)
    out.append("params = { stage = { type = \"str\", value = %s }, spec_constants = { type = \"str\", value = %s }, ssbo_size = { type = \"u32\", value = %d }, expected = { type = \"str\", value = %s }, requirements = { type = \"str\", value = %s }, pack_data = { type = \"bool\", value = %s } }"
               % (json.dumps(stage), json.dumps(";".join(s.encoded() for s in c.specs)), c.ssbo_size, json.dumps(";".join(c.expected)), json.dumps(",".join(c.requirements)), "true" if c.pack_data else "false"))
    out.append("derived = { extensions = %s, spec_block = %s, ssbo_block = %s, global_block = %s, main_code = %s }"
               % (py_literal(extensions), py_literal(spec_block), py_literal(ssbo_block), py_literal(global_block), py_literal(c.main)))
    out.append("")


def packed_variants(cases):
    """`for (int i = 0; i < 2; ++i)` over the table: every case, then every case again with packData and `_packed` appended."""
    out = list(cases)
    for c in cases:
        out.append(Case(c.name + "_packed", c.specs, c.ssbo_size, c.ssbo, c.glob, c.main, c.expected, c.requirements, True))
    return out


def stage_cases(stage, compute):
    prefix = [stage] if compute else ["graphics", stage]
    entries = []
    for c in packed_variants(DEFAULT_VALUE):
        entries.append((prefix + ["default_value"], c))
    for c in packed_variants(BASIC) + BASIC_UNUSED:
        entries.append((prefix + ["basic"], c))
    for c in BUILTIN:
        entries.append((prefix + ["builtin"], c))
    for c in EXPRESSION:
        entries.append((prefix + ["expression"], c))
    for group, c in COMPOSITE:
        entries.append((prefix + ["composite", group], c))
    if compute:
        for c in LOCAL_SIZE:
            entries.append((prefix + ["local_size"], c))
    return entries


def main():
    out = [
        "# Shader manifest for dEQP-VK.pipeline.monolithic.spec_constant.* (vktPipelineSpecConstantTests.cpp)",
        "#",
        "# @generated by hodow_cts/scripts/gen_spec_constant_manifest.py - do not hand-edit; see the script for what each case is.",
        "",
        'upstream_source = "external/vulkancts/modules/vulkan/pipeline/vktPipelineSpecConstantTests.cpp"',
        'rust_module = "pipeline/spec_constant_tests"',
        'spirv_version = "spirv1.3"',
        "",
    ]
    for stage in ("vertex", "fragment", "tess_control", "tess_eval", "geometry", "compute"):
        for path, c in stage_cases(stage, stage == "compute"):
            emit_case(out, path, stage, c)
    OUT.write_text("\n".join(out))
    print("wrote", OUT, "with", sum(1 for line in out if line == "[[case]]"), "cases")


if __name__ == "__main__":
    main()
