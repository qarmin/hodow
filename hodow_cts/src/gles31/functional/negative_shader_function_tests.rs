// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fNegativeShaderFunctionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2016 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Every case here has the same shape -
// "for each supported shader stage, build a shader the spec rejects and check the driver
// rejects it" - so that loop lives in `per_shader` once instead of being spelled out in
// all 69 of them. The `genShaderSource*` overloads that only default an argument are one
// function with that argument here.

use DataType::*;

use crate::gles31::functional::negative_test_shared::{FunctionContainer, NegativeTestContext};
use crate::glu::{DataType, ShaderType};
use crate::tcu::TestError;

/// `s_floatTypes`
const FLOAT_TYPES: [DataType; 4] = [Float, FloatVec2, FloatVec3, FloatVec4];

/// `s_intTypes`
const INT_TYPES: [DataType; 4] = [Int, IntVec2, IntVec3, IntVec4];

/// `s_uintTypes`
const UINT_TYPES: [DataType; 4] = [Uint, UintVec2, UintVec3, UintVec4];

/// `s_nonScalarIntTypes` - every type a scalar `int` argument must not be, which is
/// deliberately not the same list as "not an int" (it drops `int` itself and keeps `uint`).
const NON_SCALAR_INT_TYPES: [DataType; 11] = [
    Float, FloatVec2, FloatVec3, FloatVec4, IntVec2, IntVec3, IntVec4, Uint, UintVec2, UintVec3, UintVec4,
];

/// `s_shaders`
const SHADERS: [ShaderType; 6] = [
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];

/// `s_samplerTypes`
const SAMPLER_TYPES: [DataType; 28] = [
    Sampler2D,
    IntSampler2D,
    UintSampler2D,
    Sampler3D,
    IntSampler3D,
    UintSampler3D,
    SamplerCube,
    IntSamplerCube,
    UintSamplerCube,
    Sampler2DArray,
    IntSampler2DArray,
    UintSampler2DArray,
    SamplerCubeShadow,
    Sampler2DShadow,
    Sampler2DArrayShadow,
    SamplerCubeArray,
    IntSamplerCubeArray,
    UintSamplerCubeArray,
    SamplerCubeArrayShadow,
    Sampler2DMultisample,
    IntSampler2DMultisample,
    UintSampler2DMultisample,
    SamplerBuffer,
    IntSamplerBuffer,
    UintSamplerBuffer,
    Sampler2DMultisampleArray,
    IntSampler2DMultisampleArray,
    UintSampler2DMultisampleArray,
];

/// `declareAndInitializeShaderVariable`
fn declare_and_init(data_type: DataType, var_name: &str) -> String {
    let name = data_type.name();
    let args = match data_type {
        Float => "(1.0)",
        FloatVec2 => "(1.0, 1.0)",
        FloatVec3 => "(1.0, 1.0, 1.0)",
        FloatVec4 => "(1.0, 1.0, 1.0, 1.0)",
        Int => "(1)",
        IntVec2 => "(1, 1)",
        IntVec3 => "(1, 1, 1)",
        IntVec4 => "(1, 1, 1, 1)",
        Uint => "(1u)",
        UintVec2 => "(1u, 1u)",
        UintVec3 => "(1u, 1u, 1u)",
        UintVec4 => "(1u, 1u, 1u, 1u)",
        other => unreachable!("unsupported data type {other:?}"),
    };
    format!("{name} {var_name} = {name}{args};\n")
}

/// `declareShaderUniform`
fn declare_uniform(data_type: DataType, var_name: &str) -> String {
    format!("highp uniform {} {var_name};\n", data_type.name())
}

/// `declareShaderInput`
fn declare_input(data_type: DataType, var_name: &str) -> String {
    format!("in highp {} {var_name};\n", data_type.name())
}

/// `declareBuffer`
fn declare_buffer(data_type: DataType, var_name: &str) -> String {
    format!("buffer SSBO {{\n    {} {var_name};\n}};\n", data_type.name())
}

/// `declareShaderArrayVariable` - \note every element is initialized with the same two
/// zeros whatever the type is, which only happens to be right for the `ivec2` offset
/// arrays this is called with.
fn declare_array_variable(data_type: DataType, var_name: &str, array_size: i32) -> String {
    let name = data_type.name();
    let mut source = format!("{name} {var_name}[{array_size}] = {name}[](");
    for ndx in 0..array_size {
        source += &format!("{name}(0, 0){}", if ndx < array_size - 1 { ", " } else { "" });
    }
    source + ");"
}

/// `getShaderExtensionDeclaration`
fn extension_declaration(extension: &str) -> String {
    if extension.is_empty() {
        String::new()
    } else {
        format!("#extension {extension} : enable\n")
    }
}

/// `getDataTypeExtension`
fn data_type_extension(data_type: DataType) -> &'static str {
    match data_type {
        SamplerCubeArray | SamplerCubeArrayShadow | IntSamplerCubeArray | UintSamplerCubeArray => {
            "GL_EXT_texture_cube_map_array"
        }
        SamplerBuffer | IntSamplerBuffer | UintSamplerBuffer => "GL_EXT_texture_buffer",
        Sampler2DMultisampleArray | IntSampler2DMultisampleArray | UintSampler2DMultisampleArray => {
            "GL_OES_texture_storage_multisample_2d_array"
        }
        _ => "",
    }
}

/// `getShaderInitialization` - the stage's own extension directive (below ES 3.2 only)
/// plus whatever layout qualifier makes that stage legal on its own.
fn shader_initialization(ctx: &NegativeTestContext<'_>, shader_type: ShaderType) -> String {
    let mut source = String::new();

    if !ctx.context_supports(3, 2) {
        source += match shader_type {
            ShaderType::Geometry => "#extension GL_EXT_geometry_shader : enable\n",
            ShaderType::TessControl | ShaderType::TessEvaluation => "#extension GL_EXT_tessellation_shader : enable\n",
            _ => "",
        };
    }

    source += match shader_type {
        ShaderType::Geometry => "layout(max_vertices = 5) out;\n",
        ShaderType::TessControl => "layout(vertices = 3) out;\n",
        ShaderType::TessEvaluation => "layout(triangles, equal_spacing, cw) in;\n",
        _ => "",
    };

    source
}

/// The `#version` + stage preamble every generator starts with.
fn preamble(ctx: &NegativeTestContext<'_>, shader_type: ShaderType) -> String {
    format!(
        "{}\n{}",
        ctx.glsl_version_decl(),
        shader_initialization(ctx, shader_type)
    )
}

/// The loop every case in this file is built out of: one section, then one sub-section per
/// shader stage the context actually has.
fn per_shader(
    ctx: &mut NegativeTestContext<'_>,
    section: &str,
    mut body: impl FnMut(&mut NegativeTestContext<'_>, ShaderType),
) {
    ctx.begin_section(section);
    for shader_type in SHADERS {
        if ctx.is_shader_supported(shader_type) {
            ctx.begin_section(&format!("Verify shader: {}", shader_type.as_str()));
            body(ctx, shader_type);
            ctx.end_section();
        }
    }
    ctx.end_section();
}

// bitfieldExtract

/// `genShaderSourceBitfieldExtract`
fn gen_bitfield_extract(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    value: DataType,
    offset: DataType,
    bits: DataType,
) -> String {
    format!(
        "{}void main(void)\n{{\n    {}    {}    {}    bitfieldExtract(value, offset, bits);\n}}\n",
        preamble(ctx, shader_type),
        declare_and_init(value, "value"),
        declare_and_init(offset, "offset"),
        declare_and_init(bits, "bits"),
    )
}

fn bitfield_extract_invalid_value_type(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "bitfieldExtract: Invalid value type.", |ctx, shader_type| {
        for value in FLOAT_TYPES {
            let source = gen_bitfield_extract(ctx, shader_type, value, Int, Int);
            ctx.verify_shader_does_not_compile(shader_type, &source);
        }
    });
    Ok(())
}

fn bitfield_extract_invalid_offset_type(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "bitfieldExtract: Invalid offset type.", |ctx, shader_type| {
        for ndx in 0..INT_TYPES.len() {
            for offset in NON_SCALAR_INT_TYPES {
                for value in [INT_TYPES[ndx], UINT_TYPES[ndx]] {
                    let source = gen_bitfield_extract(ctx, shader_type, value, offset, Int);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
            }
        }
    });
    Ok(())
}

fn bitfield_extract_invalid_bits_type(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "bitfieldExtract: Invalid bits type.", |ctx, shader_type| {
        for ndx in 0..INT_TYPES.len() {
            for bits in NON_SCALAR_INT_TYPES {
                for value in [INT_TYPES[ndx], UINT_TYPES[ndx]] {
                    let source = gen_bitfield_extract(ctx, shader_type, value, Int, bits);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
            }
        }
    });
    Ok(())
}

// bitfieldInsert

/// `genShaderSourceBitfieldInsert`
fn gen_bitfield_insert(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    base: DataType,
    insert: DataType,
    offset: DataType,
    bits: DataType,
) -> String {
    format!(
        "{}void main(void)\n{{\n    {}    {}    {}    {}    bitfieldInsert(base, insert, offset, bits);\n}}\n",
        preamble(ctx, shader_type),
        declare_and_init(base, "base"),
        declare_and_init(insert, "insert"),
        declare_and_init(offset, "offset"),
        declare_and_init(bits, "bits"),
    )
}

fn bitfield_insert_invalid_base_type(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "bitfieldInsert: Invalid base type.", |ctx, shader_type| {
        for ndx in 0..FLOAT_TYPES.len() {
            for insert in [INT_TYPES[ndx], UINT_TYPES[ndx]] {
                let source = gen_bitfield_insert(ctx, shader_type, FLOAT_TYPES[ndx], insert, Int, Int);
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        }
    });
    Ok(())
}

fn bitfield_insert_invalid_insert_type(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "bitfieldInsert: Invalid insert type.", |ctx, shader_type| {
        for ndx in 0..INT_TYPES.len() {
            for base in [INT_TYPES[ndx], UINT_TYPES[ndx]] {
                let source = gen_bitfield_insert(ctx, shader_type, base, FLOAT_TYPES[ndx], Int, Int);
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }

            for ndx2 in 0..INT_TYPES.len() {
                if ndx == ndx2 {
                    continue;
                }
                for (base, insert) in [(INT_TYPES[ndx], INT_TYPES[ndx2]), (UINT_TYPES[ndx], UINT_TYPES[ndx2])] {
                    let source = gen_bitfield_insert(ctx, shader_type, base, insert, Int, Int);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
            }
        }
    });
    Ok(())
}

fn bitfield_insert_invalid_offset_type(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "bitfieldInsert: Invalid offset type.", |ctx, shader_type| {
        for ndx in 0..INT_TYPES.len() {
            for offset in NON_SCALAR_INT_TYPES {
                for base in [INT_TYPES[ndx], UINT_TYPES[ndx]] {
                    let source = gen_bitfield_insert(ctx, shader_type, base, base, offset, Int);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
            }
        }
    });
    Ok(())
}

fn bitfield_insert_invalid_bits_type(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "bitfieldInsert: Invalid bits type.", |ctx, shader_type| {
        for ndx in 0..INT_TYPES.len() {
            for bits in NON_SCALAR_INT_TYPES {
                for base in [INT_TYPES[ndx], UINT_TYPES[ndx]] {
                    let source = gen_bitfield_insert(ctx, shader_type, base, base, Int, bits);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
            }
        }
    });
    Ok(())
}

// bitfieldReverse, bitCount, findMSB, findLSB

/// `genShaderSourceReverseCountFind`
fn gen_reverse_count_find(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    function: &str,
    base: DataType,
) -> String {
    format!(
        "{}void main(void)\n{{\n    {}    {function}(value);\n}}\n",
        preamble(ctx, shader_type),
        declare_and_init(base, "value"),
    )
}

/// The four cases above differ only in the function they call.
fn reverse_count_find(ctx: &mut NegativeTestContext<'_>, function: &'static str) -> Result<(), TestError> {
    per_shader(ctx, &format!("{function}: Invalid value type."), |ctx, shader_type| {
        for value in FLOAT_TYPES {
            let source = gen_reverse_count_find(ctx, shader_type, function, value);
            ctx.verify_shader_does_not_compile(shader_type, &source);
        }
    });
    Ok(())
}

fn bitfield_reverse(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    reverse_count_find(ctx, "bitfieldReverse")
}

fn bit_count(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    reverse_count_find(ctx, "bitCount")
}

fn find_msb(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    reverse_count_find(ctx, "findMSB")
}

fn find_lsb(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    reverse_count_find(ctx, "findLSB")
}

// uaddCarry, usubBorrow, umulExtended, imulExtended

/// Which argument of a three- or four-argument call the case is feeding the wrong type.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Slot {
    X,
    Y,
    Third,
    Fourth,
}

/// `genShaderSourceAddCarrySubBorrow` - the third argument is `carry` or `borrow` after
/// the function it belongs to.
fn gen_add_carry_sub_borrow(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    function: &str,
    third_name: &str,
    types: [DataType; 3],
) -> String {
    format!(
        "{}void main(void)\n{{\n    {}    {}    {}    {function}(x, y, {third_name});\n}}\n",
        preamble(ctx, shader_type),
        declare_and_init(types[0], "x"),
        declare_and_init(types[1], "y"),
        declare_and_init(types[2], third_name),
    )
}

/// `genShaderSourceMulExtended`
fn gen_mul_extended(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    function: &str,
    types: [DataType; 4],
) -> String {
    format!(
        "{}void main(void)\n{{\n    {}    {}    {}    {}    {function}(x, y, msb, lsb);\n}}\n",
        preamble(ctx, shader_type),
        declare_and_init(types[0], "x"),
        declare_and_init(types[1], "y"),
        declare_and_init(types[2], "msb"),
        declare_and_init(types[3], "lsb"),
    )
}

/// The three wrong types every one of these 14 cases tries in the slot under test, given
/// the argument type the call actually wants: the float of that width, the signed-or-
/// unsigned counterpart, and every *other* width of the wanted type.
fn wrong_types(ndx: usize, wanted: [DataType; 4], counterpart: [DataType; 4]) -> Vec<DataType> {
    let mut types = vec![FLOAT_TYPES[ndx], counterpart[ndx]];
    types.extend((0..wanted.len()).filter(|&n| n != ndx).map(|n| wanted[n]));
    types
}

/// `uadd_carry_*` / `usub_borrow_*` - both take `uint`, so the counterpart is `int`.
fn add_carry_sub_borrow(
    ctx: &mut NegativeTestContext<'_>,
    function: &'static str,
    third_name: &'static str,
    slot: Slot,
) -> Result<(), TestError> {
    let section = format!(
        "{function}: Invalid {} type.",
        if slot == Slot::X {
            "x"
        } else if slot == Slot::Y {
            "y"
        } else {
            third_name
        }
    );
    per_shader(ctx, &section, |ctx, shader_type| {
        for (ndx, &wanted) in UINT_TYPES.iter().enumerate() {
            for wrong in wrong_types(ndx, UINT_TYPES, INT_TYPES) {
                let mut types = [wanted; 3];
                types[match slot {
                    Slot::X => 0,
                    Slot::Y => 1,
                    _ => 2,
                }] = wrong;
                let source = gen_add_carry_sub_borrow(ctx, shader_type, function, third_name, types);
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        }
    });
    Ok(())
}

/// `umul_extended_*` / `imul_extended_*` - `wanted` is `uint` for the first and `int` for
/// the second, and the counterpart is the other one.
fn mul_extended(
    ctx: &mut NegativeTestContext<'_>,
    function: &'static str,
    slot: Slot,
    wanted: [DataType; 4],
    counterpart: [DataType; 4],
) -> Result<(), TestError> {
    let arg = match slot {
        Slot::X => "x",
        Slot::Y => "y",
        Slot::Third => "msb",
        Slot::Fourth => "lsb",
    };
    per_shader(ctx, &format!("{function}: Invalid {arg} type."), |ctx, shader_type| {
        for ndx in 0..wanted.len() {
            for wrong in wrong_types(ndx, wanted, counterpart) {
                let mut types = [wanted[ndx]; 4];
                types[match slot {
                    Slot::X => 0,
                    Slot::Y => 1,
                    Slot::Third => 2,
                    Slot::Fourth => 3,
                }] = wrong;
                let source = gen_mul_extended(ctx, shader_type, function, types);
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        }
    });
    Ok(())
}

fn uadd_carry_invalid_x(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    add_carry_sub_borrow(ctx, "uaddCarry", "carry", Slot::X)
}

fn uadd_carry_invalid_y(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    add_carry_sub_borrow(ctx, "uaddCarry", "carry", Slot::Y)
}

fn uadd_carry_invalid_carry(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    add_carry_sub_borrow(ctx, "uaddCarry", "carry", Slot::Third)
}

fn usub_borrow_invalid_x(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    add_carry_sub_borrow(ctx, "usubBorrow", "borrow", Slot::X)
}

fn usub_borrow_invalid_y(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    add_carry_sub_borrow(ctx, "usubBorrow", "borrow", Slot::Y)
}

fn usub_borrow_invalid_borrow(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    add_carry_sub_borrow(ctx, "usubBorrow", "borrow", Slot::Third)
}

fn umul_extended_invalid_x(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    mul_extended(ctx, "umulExtended", Slot::X, UINT_TYPES, INT_TYPES)
}

fn umul_extended_invalid_y(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    mul_extended(ctx, "umulExtended", Slot::Y, UINT_TYPES, INT_TYPES)
}

fn umul_extended_invalid_msb(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    mul_extended(ctx, "umulExtended", Slot::Third, UINT_TYPES, INT_TYPES)
}

fn umul_extended_invalid_lsb(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    mul_extended(ctx, "umulExtended", Slot::Fourth, UINT_TYPES, INT_TYPES)
}

fn imul_extended_invalid_x(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    mul_extended(ctx, "imulExtended", Slot::X, INT_TYPES, UINT_TYPES)
}

fn imul_extended_invalid_y(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    mul_extended(ctx, "imulExtended", Slot::Y, INT_TYPES, UINT_TYPES)
}

fn imul_extended_invalid_msb(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    mul_extended(ctx, "imulExtended", Slot::Third, INT_TYPES, UINT_TYPES)
}

fn imul_extended_invalid_lsb(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    mul_extended(ctx, "imulExtended", Slot::Fourth, INT_TYPES, UINT_TYPES)
}

// frexp, ldexp

/// `genShaderSourceFrexpLdexp`
fn gen_frexp_ldexp(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    function: &str,
    x: DataType,
    exp: DataType,
) -> String {
    format!(
        "{}void main(void)\n{{\n    {}    {}    {function}(x, exp);\n}}\n",
        preamble(ctx, shader_type),
        declare_and_init(x, "x"),
        declare_and_init(exp, "exp"),
    )
}

/// The `x` argument wants a float and the `exp` one an int, so the wrong types for each
/// are the other two lists.
fn frexp_ldexp(ctx: &mut NegativeTestContext<'_>, function: &'static str, slot: Slot) -> Result<(), TestError> {
    let arg = if slot == Slot::X { "x" } else { "exp" };
    per_shader(ctx, &format!("{function}: Invalid {arg} type."), |ctx, shader_type| {
        for ndx in 0..FLOAT_TYPES.len() {
            let pairs = if slot == Slot::X {
                [(INT_TYPES[ndx], INT_TYPES[ndx]), (UINT_TYPES[ndx], INT_TYPES[ndx])]
            } else {
                [
                    (FLOAT_TYPES[ndx], UINT_TYPES[ndx]),
                    (FLOAT_TYPES[ndx], FLOAT_TYPES[ndx]),
                ]
            };
            for (x, exp) in pairs {
                let source = gen_frexp_ldexp(ctx, shader_type, function, x, exp);
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        }
    });
    Ok(())
}

fn frexp_invalid_x(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    frexp_ldexp(ctx, "frexp", Slot::X)
}

fn frexp_invalid_exp(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    frexp_ldexp(ctx, "frexp", Slot::Y)
}

fn ldexp_invalid_x(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    frexp_ldexp(ctx, "ldexp", Slot::X)
}

fn ldexp_invalid_exp(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    frexp_ldexp(ctx, "ldexp", Slot::Y)
}

// packUnorm4x8, packSnorm4x8, unpackSnorm4x8, unpackUnorm4x8

/// `genShaderSourcePackUnpackNorm4x8` - the two pack functions take a `mediump vec4` named
/// `v`, the two unpack ones a `highp uint` named `p`.
fn gen_pack_unpack_norm_4x8(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    function: &str,
    precision: &str,
    var_name: &str,
    data_type: DataType,
) -> String {
    format!(
        "{}void main(void)\n{{\n    {precision} {}    {function}({var_name});\n}}\n",
        preamble(ctx, shader_type),
        declare_and_init(data_type, var_name),
    )
}

fn pack_norm_4x8(ctx: &mut NegativeTestContext<'_>, function: &'static str) -> Result<(), TestError> {
    per_shader(ctx, &format!("{function}: Invalid v type."), |ctx, shader_type| {
        for float_type in FLOAT_TYPES {
            if float_type == FloatVec4 {
                continue;
            }
            let source = gen_pack_unpack_norm_4x8(ctx, shader_type, function, "mediump", "v", float_type);
            ctx.verify_shader_does_not_compile(shader_type, &source);
        }

        for ndx in 0..INT_TYPES.len() {
            for data_type in [INT_TYPES[ndx], UINT_TYPES[ndx]] {
                let source = gen_pack_unpack_norm_4x8(ctx, shader_type, function, "mediump", "v", data_type);
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        }
    });
    Ok(())
}

fn unpack_norm_4x8(ctx: &mut NegativeTestContext<'_>, function: &'static str) -> Result<(), TestError> {
    per_shader(ctx, &format!("{function}: Invalid v type."), |ctx, shader_type| {
        for uint_type in UINT_TYPES {
            if uint_type == Uint {
                continue;
            }
            let source = gen_pack_unpack_norm_4x8(ctx, shader_type, function, "highp", "p", uint_type);
            ctx.verify_shader_does_not_compile(shader_type, &source);
        }

        for ndx in 0..INT_TYPES.len() {
            for data_type in [INT_TYPES[ndx], FLOAT_TYPES[ndx]] {
                let source = gen_pack_unpack_norm_4x8(ctx, shader_type, function, "highp", "p", data_type);
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        }
    });
    Ok(())
}

fn pack_unorm_4x8(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    pack_norm_4x8(ctx, "packUnorm4x8")
}

fn pack_snorm_4x8(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    pack_norm_4x8(ctx, "packSnorm4x8")
}

fn unpack_snorm_4x8(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    unpack_norm_4x8(ctx, "unpackSnorm4x8")
}

fn unpack_unorm_4x8(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    unpack_norm_4x8(ctx, "unpackUnorm4x8")
}

// The sampler-taking generators. Each declares its sampler as a uniform, with whatever
// extension declaration that sampler type needs.

/// `checkSupport` - upstream also accepts desktop GL 4.5, which this port never runs on.
fn check_support(ctx: &NegativeTestContext<'_>) -> bool {
    ctx.context_supports(3, 2)
}

/// The preamble a generator that declares a sampler uniform starts with.
fn sampler_preamble(ctx: &NegativeTestContext<'_>, shader_type: ShaderType, sampler: DataType) -> String {
    format!(
        "{}\n{}{}{}void main(void)\n{{\n",
        ctx.glsl_version_decl(),
        extension_declaration(data_type_extension(sampler)),
        shader_initialization(ctx, shader_type),
        declare_uniform(sampler, "sampler"),
    )
}

/// `genShaderSourceTextureSize_sampler` - the multisample and buffer samplers are the ones
/// whose `textureSize` takes no lod, so passing one is what makes those shaders illegal.
fn gen_texture_size_sampler(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    sampler: DataType,
    lod: DataType,
) -> String {
    let call = match sampler {
        Sampler2D
        | IntSampler2D
        | UintSampler2D
        | Sampler3D
        | IntSampler3D
        | UintSampler3D
        | SamplerCube
        | IntSamplerCube
        | UintSamplerCube
        | Sampler2DArray
        | IntSampler2DArray
        | UintSampler2DArray
        | SamplerCubeShadow
        | Sampler2DShadow
        | Sampler2DArrayShadow
        | SamplerCubeArray
        | IntSamplerCubeArray
        | UintSamplerCubeArray
        | SamplerCubeArrayShadow => "    textureSize(sampler);\n".to_string(),

        Sampler2DMultisample
        | IntSampler2DMultisample
        | UintSampler2DMultisample
        | SamplerBuffer
        | IntSamplerBuffer
        | UintSamplerBuffer
        | Sampler2DMultisampleArray
        | IntSampler2DMultisampleArray
        | UintSampler2DMultisampleArray => {
            format!("    {}    textureSize(sampler, lod);\n", declare_and_init(lod, "lod"))
        }

        other => unreachable!("unsupported data type {other:?}"),
    };
    format!("{}{call}}}\n", sampler_preamble(ctx, shader_type, sampler))
}

/// `genShaderSourceTextureSize_lod`
fn gen_texture_size_lod(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    sampler: DataType,
    lod: DataType,
) -> String {
    format!(
        "{}    {}    textureSize(sampler, lod);\n}}\n",
        sampler_preamble(ctx, shader_type, sampler),
        declare_and_init(lod, "lod"),
    )
}

/// `genShaderSourceTexture` - \note the P variable is named `lod` upstream.
fn gen_texture(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    sampler: DataType,
    p: DataType,
    third: Option<DataType>,
) -> String {
    let tail = match third {
        None => "    texture(sampler, lod);\n".to_string(),
        Some(third) => format!(
            "    highp {}    texture(sampler, lod, thirdArgument);\n",
            declare_and_init(third, "thirdArgument")
        ),
    };
    format!(
        "{}    highp {}{tail}}}\n",
        sampler_preamble(ctx, shader_type, sampler),
        declare_and_init(p, "lod"),
    )
}

/// `genShaderSourceTextureLod`
fn gen_texture_lod(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    sampler: DataType,
    p: DataType,
    lod: DataType,
) -> String {
    format!(
        "{}    {}    {}    textureLod(sampler, P, lod);\n}}\n",
        sampler_preamble(ctx, shader_type, sampler),
        declare_and_init(p, "P"),
        declare_and_init(lod, "lod"),
    )
}

/// `genShaderSourceTexelFetch` - the buffer samplers take no sample index, the multisample
/// ones do, so whether the third argument is there follows the sampler, not the caller.
fn gen_texel_fetch(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    sampler: DataType,
    p: DataType,
    sample: Option<DataType>,
) -> String {
    let tail = match sampler {
        Sampler2DMultisample
        | IntSampler2DMultisample
        | UintSampler2DMultisample
        | Sampler2DMultisampleArray
        | IntSampler2DMultisampleArray
        | UintSampler2DMultisampleArray => {
            let sample = sample.expect("a multisample texelFetch needs a sample index");
            format!(
                "    {}    texelFetch(sampler, P, varSample);\n",
                declare_and_init(sample, "varSample")
            )
        }
        SamplerBuffer | IntSamplerBuffer | UintSamplerBuffer => "    texelFetch(sampler, P);\n".to_string(),
        other => unreachable!("unsupported data type {other:?}"),
    };
    format!(
        "{}    {}{tail}}}\n",
        sampler_preamble(ctx, shader_type, sampler),
        declare_and_init(p, "P")
    )
}

/// `genShaderSourceGeometry`
fn gen_geometry(ctx: &NegativeTestContext<'_>, shader_type: ShaderType, function: &str) -> String {
    format!(
        "{}void main(void)\n{{\n    {function}();\n}}\n",
        preamble(ctx, shader_type)
    )
}

/// `genShaderSourceTextureGrad`
fn gen_texture_grad(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    sampler: DataType,
    p: DataType,
    dpdx: DataType,
    dpdy: DataType,
) -> String {
    format!(
        "{}    mediump {}    mediump {}    mediump {}    textureGrad(sampler, P, dPdx, dPdy);\n}}\n",
        sampler_preamble(ctx, shader_type, sampler),
        declare_and_init(p, "P"),
        declare_and_init(dpdx, "dPdx"),
        declare_and_init(dpdy, "dPdy"),
    )
}

/// `genShaderSourceTextureGather`
fn gen_texture_gather(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    sampler: DataType,
    p: DataType,
    third: Option<DataType>,
) -> String {
    let tail = match third {
        Some(third) => format!(
            "    mediump {}    textureGather(sampler, P, arg3);\n",
            declare_and_init(third, "arg3")
        ),
        None => "    textureGather(sampler, P);\n".to_string(),
    };
    format!(
        "{}    mediump {}{tail}}}\n",
        sampler_preamble(ctx, shader_type, sampler),
        declare_and_init(p, "P"),
    )
}

/// `FunctionTextureGatherOffsetModes` - which of the two `textureGatherOffset(s)`
/// overloads the shader calls, i.e. whether the fourth argument is a component index or a
/// shadow reference value.
#[derive(Clone, Copy, PartialEq, Eq)]
enum GatherOffsetMode {
    Comp,
    RefZ,
}

/// `genShaderSourceTextureGatherOffset` - \note this one declares the sampler uniform
/// *without* an extension declaration, unlike every other sampler-taking generator here.
fn gen_texture_gather_offset(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    mode: GatherOffsetMode,
    sampler: DataType,
    p: DataType,
    offset: DataType,
    fourth: Option<DataType>,
) -> String {
    let tail = match (mode, fourth) {
        (GatherOffsetMode::Comp, Some(fourth)) => format!(
            "    mediump {}    textureGatherOffset(sampler, P, offset, comp);\n",
            declare_and_init(fourth, "comp")
        ),
        (GatherOffsetMode::Comp, None) => "    textureGatherOffset(sampler, P, offset);\n".to_string(),
        (GatherOffsetMode::RefZ, fourth) => format!(
            "    mediump {}    textureGatherOffset(sampler, P, refZ, offset);\n",
            declare_and_init(fourth.expect("the refZ overload always has a fourth argument"), "refZ")
        ),
    };
    format!(
        "{}\n{}{}void main(void)\n{{\n    mediump {}    mediump {}{tail}}}\n",
        ctx.glsl_version_decl(),
        shader_initialization(ctx, shader_type),
        declare_uniform(sampler, "sampler"),
        declare_and_init(p, "P"),
        declare_and_init(offset, "offset"),
    )
}

/// `TextureGatherOffsetsTestSpec`
struct GatherOffsetsSpec {
    mode: GatherOffsetMode,
    sampler: DataType,
    p: DataType,
    offsets: DataType,
    fourth: Option<DataType>,
    offset_is_const: bool,
    offset_array_size: i32,
}

/// `genShaderSourceTextureGatherOffsets`
fn gen_texture_gather_offsets(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    spec: &GatherOffsetsSpec,
) -> String {
    let tail = match (spec.mode, spec.fourth) {
        (GatherOffsetMode::Comp, Some(fourth)) => format!(
            "    mediump {}    textureGatherOffsets(sampler, P, offsets, comp);\n",
            declare_and_init(fourth, "comp")
        ),
        (GatherOffsetMode::Comp, None) => "    textureGatherOffsets(sampler, P, offsets);\n".to_string(),
        (GatherOffsetMode::RefZ, fourth) => format!(
            "    mediump {}    textureGatherOffsets(sampler, P, refZ, offsets);\n",
            declare_and_init(fourth.expect("the refZ overload always has a fourth argument"), "refZ")
        ),
    };
    format!(
        "{}\n{}{}void main(void)\n{{\n    mediump {}    mediump {}{}\n{tail}}}\n",
        ctx.glsl_version_decl(),
        shader_initialization(ctx, shader_type),
        declare_uniform(spec.sampler, "sampler"),
        declare_and_init(spec.p, "P"),
        if spec.offset_is_const { "const " } else { "" },
        declare_array_variable(spec.offsets, "offsets", spec.offset_array_size),
    )
}

/// `genShaderSourceAtomicOperations`
fn gen_atomic(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    function: &str,
    mem: DataType,
    data: DataType,
    compare: Option<DataType>,
) -> String {
    let tail = match compare {
        None => format!("    {function}(mem, data);\n"),
        Some(compare) => format!(
            "    mediump {}    atomicCompSwap(mem, compare, data);\n",
            declare_and_init(compare, "compare")
        ),
    };
    format!(
        "{}\n{}{}void main()\n{{\n    mediump {}{tail}}}\n",
        ctx.glsl_version_decl(),
        shader_initialization(ctx, shader_type),
        declare_buffer(mem, "mem"),
        declare_and_init(data, "data"),
    )
}

/// `genShaderSourceInterpolateAt` - \note the extension declaration comes *after* the
/// stage's own layout qualifier here, unlike everywhere else in this file.
fn gen_interpolate_at(
    ctx: &NegativeTestContext<'_>,
    shader_type: ShaderType,
    function: &str,
    interpolant: DataType,
    second: Option<(&str, DataType)>,
) -> String {
    let tail = match second {
        None => format!("    {function}(interpolant);\n"),
        Some((name, data_type)) => format!(
            "    mediump {}    {function}(interpolant, {name});\n",
            declare_and_init(data_type, name)
        ),
    };
    format!(
        "{}\n{}{}{}void main()\n{{\n{tail}}}\n",
        ctx.glsl_version_decl(),
        shader_initialization(ctx, shader_type),
        if check_support(ctx) {
            String::new()
        } else {
            extension_declaration("GL_OES_shader_multisample_interpolation")
        },
        declare_input(interpolant, "interpolant"),
    )
}

/// `genShaderSourceFma` - \note upstream leaves out the newline after the `fma` call.
fn gen_fma(ctx: &NegativeTestContext<'_>, shader_type: ShaderType, a: DataType, b: DataType, c: DataType) -> String {
    format!(
        "{}void main(void)\n{{\n    mediump {}    mediump {}    mediump {}    fma(a, b, c);}}\n",
        preamble(ctx, shader_type),
        declare_and_init(a, "a"),
        declare_and_init(b, "b"),
        declare_and_init(c, "c"),
    )
}

// The remaining cases. Their bodies are long, flat call sequences with no structure beyond
// the odd guard, so they follow upstream's order call for call.

fn texture_size_invalid_sampler(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(
        ctx,
        "textureSize: Invalid sampler type - some overloads take two arguments while others take only one.",
        |ctx, shader_type| {
            for sampler in SAMPLER_TYPES {
                if check_support(ctx) || ctx.is_extension_supported(data_type_extension(sampler)) {
                    ctx.begin_section(&format!("Verify sampler data type: {}", sampler.name()));
                    let source = gen_texture_size_sampler(ctx, shader_type, sampler, Int);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    ctx.end_section();
                }
            }
        },
    );
    Ok(())
}

fn texture_size_invalid_lod(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureSize: Invalid lod type.", |ctx, shader_type| {
        for sampler in SAMPLER_TYPES {
            if check_support(ctx) || ctx.is_extension_supported(data_type_extension(sampler)) {
                // \note upstream's section text is missing a separator before the type name.
                ctx.begin_section(&format!("Verify sampler/lod data type{}", sampler.name()));
                for lod in NON_SCALAR_INT_TYPES {
                    if lod == Int {
                        continue;
                    }
                    let source = gen_texture_size_lod(ctx, shader_type, sampler, lod);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                ctx.end_section();
            }
        }
    });
    Ok(())
}

fn texture_invalid_p(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "texture: Invalid P type.", |ctx, shader_type| {
        for ndx in 0..FLOAT_TYPES.len() {
            // SAMPLER_2D
            if FLOAT_TYPES[ndx] != FloatVec2 {
                let source = gen_texture(ctx, shader_type, Sampler2D, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, Sampler2D, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSampler2D, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSampler2D, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSampler2D, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSampler2D, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, Sampler2D, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2D, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2D, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2D, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2D, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2D, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2D, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2D, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2D, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2D, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2D, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2D, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_3D
            if FLOAT_TYPES[ndx] != FloatVec3 {
                let source = gen_texture(ctx, shader_type, Sampler3D, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, Sampler3D, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSampler3D, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSampler3D, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSampler3D, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSampler3D, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, Sampler3D, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler3D, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler3D, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler3D, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler3D, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler3D, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler3D, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler3D, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler3D, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler3D, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler3D, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler3D, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_CUBE
            if FLOAT_TYPES[ndx] != FloatVec3 {
                let source = gen_texture(ctx, shader_type, SamplerCube, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, SamplerCube, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSamplerCube, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSamplerCube, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSamplerCube, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSamplerCube, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, SamplerCube, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, SamplerCube, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSamplerCube, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSamplerCube, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSamplerCube, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSamplerCube, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, SamplerCube, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, SamplerCube, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSamplerCube, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSamplerCube, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSamplerCube, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSamplerCube, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_2D_ARRAY
            if FLOAT_TYPES[ndx] != FloatVec3 {
                let source = gen_texture(ctx, shader_type, Sampler2DArray, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, Sampler2DArray, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSampler2DArray, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSampler2DArray, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSampler2DArray, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSampler2DArray, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, Sampler2DArray, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DArray, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2DArray, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2DArray, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2DArray, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2DArray, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DArray, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DArray, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2DArray, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2DArray, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2DArray, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2DArray, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_2D_SHADOW
            if FLOAT_TYPES[ndx] != FloatVec3 {
                let source = gen_texture(ctx, shader_type, Sampler2DShadow, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, Sampler2DShadow, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, Sampler2DShadow, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DShadow, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DShadow, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DShadow, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_CUBE_SHADOW
            if FLOAT_TYPES[ndx] != FloatVec4 {
                let source = gen_texture(ctx, shader_type, SamplerCubeShadow, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, SamplerCubeShadow, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, SamplerCubeShadow, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, SamplerCubeShadow, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, SamplerCubeShadow, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, SamplerCubeShadow, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_2D_ARRAY_SHADOW
            if FLOAT_TYPES[ndx] != FloatVec4 {
                let source = gen_texture(ctx, shader_type, Sampler2DArrayShadow, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, Sampler2DArrayShadow, FLOAT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, Sampler2DArrayShadow, INT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DArrayShadow, INT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DArrayShadow, UINT_TYPES[ndx], None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DArrayShadow, UINT_TYPES[ndx], Some(Float));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_CUBE_ARRAY
            if check_support(ctx) || ctx.is_extension_supported(data_type_extension(SamplerCubeArray)) {
                if FLOAT_TYPES[ndx] != FloatVec4 {
                    let source = gen_texture(ctx, shader_type, SamplerCubeArray, FLOAT_TYPES[ndx], None);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture(ctx, shader_type, SamplerCubeArray, FLOAT_TYPES[ndx], Some(Float));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture(ctx, shader_type, IntSamplerCubeArray, FLOAT_TYPES[ndx], None);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture(ctx, shader_type, IntSamplerCubeArray, FLOAT_TYPES[ndx], Some(Float));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture(ctx, shader_type, UintSamplerCubeArray, FLOAT_TYPES[ndx], None);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture(ctx, shader_type, UintSamplerCubeArray, FLOAT_TYPES[ndx], Some(Float));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                let source = gen_texture(ctx, shader_type, SamplerCubeArray, INT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, SamplerCubeArray, INT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSamplerCubeArray, INT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSamplerCubeArray, INT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSamplerCubeArray, INT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSamplerCubeArray, INT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, SamplerCubeArray, UINT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, SamplerCubeArray, UINT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSamplerCubeArray, UINT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSamplerCubeArray, UINT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSamplerCubeArray, UINT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSamplerCubeArray, UINT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            // SAMPLER_CUBE_ARRAY_SHADOW
            if check_support(ctx) || ctx.is_extension_supported(data_type_extension(SamplerCubeArrayShadow)) {
                if FLOAT_TYPES[ndx] != FloatVec4 {
                    let source = gen_texture(ctx, shader_type, SamplerCubeArrayShadow, FLOAT_TYPES[ndx], Some(Float));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                let source = gen_texture(ctx, shader_type, SamplerCubeArrayShadow, INT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, SamplerCubeArrayShadow, UINT_TYPES[ndx], Some(Float));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        }
    });
    Ok(())
}

fn texture_invalid_bias_or_compare(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "texture: Invalid bias/compare type.", |ctx, shader_type| {
        for ndx in 0..FLOAT_TYPES.len() {
            // SAMPLER_2D
            if FLOAT_TYPES[ndx] != Float {
                let source = gen_texture(ctx, shader_type, Sampler2D, FloatVec2, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSampler2D, FloatVec2, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSampler2D, FloatVec2, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, Sampler2D, FloatVec2, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2D, FloatVec2, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2D, FloatVec2, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2D, FloatVec2, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2D, FloatVec2, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2D, FloatVec2, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_3D
            if FLOAT_TYPES[ndx] != Float {
                let source = gen_texture(ctx, shader_type, Sampler3D, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSampler3D, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSampler3D, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, Sampler3D, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler3D, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler3D, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler3D, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler3D, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler3D, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_CUBE
            if FLOAT_TYPES[ndx] != Float {
                let source = gen_texture(ctx, shader_type, SamplerCube, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSamplerCube, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSamplerCube, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, SamplerCube, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, SamplerCube, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSamplerCube, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSamplerCube, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSamplerCube, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSamplerCube, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_2D_ARRAY
            if FLOAT_TYPES[ndx] != Float {
                let source = gen_texture(ctx, shader_type, Sampler2DArray, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSampler2DArray, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSampler2DArray, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, Sampler2DArray, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DArray, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2DArray, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, IntSampler2DArray, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2DArray, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, UintSampler2DArray, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_2D_SHADOW
            if FLOAT_TYPES[ndx] != Float {
                let source = gen_texture(ctx, shader_type, Sampler2DShadow, FloatVec3, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, Sampler2DShadow, FloatVec3, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, Sampler2DShadow, FloatVec3, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_CUBE_SHADOW
            if FLOAT_TYPES[ndx] != Float {
                let source = gen_texture(ctx, shader_type, SamplerCubeShadow, FloatVec4, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            let source = gen_texture(ctx, shader_type, SamplerCubeShadow, FloatVec4, Some(INT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_texture(ctx, shader_type, SamplerCubeShadow, FloatVec4, Some(UINT_TYPES[ndx]));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            // SAMPLER_CUBE_ARRAY
            if check_support(ctx) || ctx.is_extension_supported(data_type_extension(SamplerCubeArray)) {
                if FLOAT_TYPES[ndx] != Float {
                    let source = gen_texture(ctx, shader_type, SamplerCubeArray, FloatVec4, Some(FLOAT_TYPES[ndx]));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture(ctx, shader_type, IntSamplerCubeArray, FloatVec4, Some(FLOAT_TYPES[ndx]));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture(
                        ctx,
                        shader_type,
                        UintSamplerCubeArray,
                        FloatVec4,
                        Some(FLOAT_TYPES[ndx]),
                    );
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                let source = gen_texture(ctx, shader_type, SamplerCubeArray, FloatVec4, Some(INT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, SamplerCubeArray, FloatVec4, Some(UINT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSamplerCubeArray, FloatVec4, Some(INT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, IntSamplerCubeArray, FloatVec4, Some(UINT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSamplerCubeArray, FloatVec4, Some(INT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(ctx, shader_type, UintSamplerCubeArray, FloatVec4, Some(UINT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
            // SAMPLER_CUBE_ARRAY_SHADOW
            if check_support(ctx) || ctx.is_extension_supported(data_type_extension(SamplerCubeArrayShadow)) {
                if FLOAT_TYPES[ndx] != Float {
                    let source = gen_texture(
                        ctx,
                        shader_type,
                        SamplerCubeArrayShadow,
                        FloatVec4,
                        Some(FLOAT_TYPES[ndx]),
                    );
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                let source = gen_texture(
                    ctx,
                    shader_type,
                    SamplerCubeArrayShadow,
                    FloatVec4,
                    Some(INT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture(
                    ctx,
                    shader_type,
                    SamplerCubeArrayShadow,
                    FloatVec4,
                    Some(UINT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        }
    });
    Ok(())
}

fn texture_lod_invalid_p(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if check_support(ctx) || ctx.is_extension_supported(data_type_extension(SamplerCubeArray)) {
        per_shader(ctx, "textureLod: Invalid P type.", |ctx, shader_type| {
            for ndx in 0..FLOAT_TYPES.len() {
                if FLOAT_TYPES[ndx] != FloatVec4 {
                    let source = gen_texture_lod(ctx, shader_type, SamplerCubeArray, FLOAT_TYPES[ndx], Float);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture_lod(ctx, shader_type, IntSamplerCubeArray, FLOAT_TYPES[ndx], Float);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture_lod(ctx, shader_type, UintSamplerCubeArray, FLOAT_TYPES[ndx], Float);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                let source = gen_texture_lod(ctx, shader_type, SamplerCubeArray, INT_TYPES[ndx], Float);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, IntSamplerCubeArray, INT_TYPES[ndx], Float);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, UintSamplerCubeArray, INT_TYPES[ndx], Float);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, SamplerCubeArray, UINT_TYPES[ndx], Float);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, IntSamplerCubeArray, UINT_TYPES[ndx], Float);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, UintSamplerCubeArray, UINT_TYPES[ndx], Float);
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        });
    }
    Ok(())
}

fn texture_lod_invalid_lod(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if check_support(ctx) || ctx.is_extension_supported(data_type_extension(SamplerCubeArray)) {
        per_shader(ctx, "textureLod: Invalid lod type.", |ctx, shader_type| {
            for ndx in 0..FLOAT_TYPES.len() {
                if FLOAT_TYPES[ndx] != Float {
                    let source = gen_texture_lod(ctx, shader_type, SamplerCubeArray, Float, FLOAT_TYPES[ndx]);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture_lod(ctx, shader_type, IntSamplerCubeArray, Float, FLOAT_TYPES[ndx]);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texture_lod(ctx, shader_type, UintSamplerCubeArray, Float, FLOAT_TYPES[ndx]);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                let source = gen_texture_lod(ctx, shader_type, SamplerCubeArray, FloatVec4, INT_TYPES[ndx]);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, IntSamplerCubeArray, FloatVec4, INT_TYPES[ndx]);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, UintSamplerCubeArray, FloatVec4, INT_TYPES[ndx]);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, SamplerCubeArray, FloatVec4, UINT_TYPES[ndx]);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, IntSamplerCubeArray, FloatVec4, UINT_TYPES[ndx]);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texture_lod(ctx, shader_type, UintSamplerCubeArray, FloatVec4, UINT_TYPES[ndx]);
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        });
    }
    Ok(())
}

fn texel_fetch_invalid_p(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if check_support(ctx) || ctx.is_extension_supported(data_type_extension(SamplerCubeArray)) {
        per_shader(ctx, "texelFetch: Invalid P type.", |ctx, shader_type| {
            for ndx in 0..FLOAT_TYPES.len() {
                // SAMPLER_2D_MULTISAMPLE
                let source = gen_texel_fetch(ctx, shader_type, Sampler2DMultisample, FLOAT_TYPES[ndx], Some(Int));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(ctx, shader_type, IntSampler2DMultisample, FLOAT_TYPES[ndx], Some(Int));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(ctx, shader_type, UintSampler2DMultisample, FLOAT_TYPES[ndx], Some(Int));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                if INT_TYPES[ndx] != IntVec2 {
                    let source = gen_texel_fetch(ctx, shader_type, Sampler2DMultisample, INT_TYPES[ndx], Some(Int));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texel_fetch(ctx, shader_type, IntSampler2DMultisample, INT_TYPES[ndx], Some(Int));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texel_fetch(ctx, shader_type, UintSampler2DMultisample, INT_TYPES[ndx], Some(Int));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                let source = gen_texel_fetch(ctx, shader_type, Sampler2DMultisample, UINT_TYPES[ndx], Some(Int));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(ctx, shader_type, IntSampler2DMultisample, UINT_TYPES[ndx], Some(Int));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(ctx, shader_type, UintSampler2DMultisample, UINT_TYPES[ndx], Some(Int));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                // SAMPLER_BUFFER
                let source = gen_texel_fetch(ctx, shader_type, SamplerBuffer, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(ctx, shader_type, IntSamplerBuffer, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(ctx, shader_type, UintSamplerBuffer, FLOAT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                if INT_TYPES[ndx] != Int {
                    let source = gen_texel_fetch(ctx, shader_type, SamplerBuffer, INT_TYPES[ndx], None);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texel_fetch(ctx, shader_type, IntSamplerBuffer, INT_TYPES[ndx], None);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texel_fetch(ctx, shader_type, UintSamplerBuffer, INT_TYPES[ndx], None);
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                let source = gen_texel_fetch(ctx, shader_type, SamplerBuffer, UINT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(ctx, shader_type, IntSamplerBuffer, UINT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(ctx, shader_type, UintSamplerBuffer, UINT_TYPES[ndx], None);
                ctx.verify_shader_does_not_compile(shader_type, &source);
                // SAMPLER_2D_MULTISAMPLE_ARRAY
                let source = gen_texel_fetch(ctx, shader_type, Sampler2DMultisampleArray, FLOAT_TYPES[ndx], Some(Int));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    IntSampler2DMultisampleArray,
                    FLOAT_TYPES[ndx],
                    Some(Int),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    UintSampler2DMultisampleArray,
                    FLOAT_TYPES[ndx],
                    Some(Int),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                if INT_TYPES[ndx] != IntVec3 {
                    let source =
                        gen_texel_fetch(ctx, shader_type, Sampler2DMultisampleArray, INT_TYPES[ndx], Some(Int));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texel_fetch(
                        ctx,
                        shader_type,
                        IntSampler2DMultisampleArray,
                        INT_TYPES[ndx],
                        Some(Int),
                    );
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texel_fetch(
                        ctx,
                        shader_type,
                        UintSampler2DMultisampleArray,
                        INT_TYPES[ndx],
                        Some(Int),
                    );
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                let source = gen_texel_fetch(ctx, shader_type, Sampler2DMultisampleArray, UINT_TYPES[ndx], Some(Int));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    IntSampler2DMultisampleArray,
                    UINT_TYPES[ndx],
                    Some(Int),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    UintSampler2DMultisampleArray,
                    UINT_TYPES[ndx],
                    Some(Int),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        });
    }
    Ok(())
}

fn texel_fetch_invalid_sample(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if check_support(ctx) || ctx.is_extension_supported(data_type_extension(SamplerCubeArray)) {
        per_shader(ctx, "texelFetch: Invalid sample type.", |ctx, shader_type| {
            for ndx in 0..FLOAT_TYPES.len() {
                // SAMPLER_2D_MULTISAMPLE
                let source = gen_texel_fetch(ctx, shader_type, Sampler2DMultisample, IntVec2, Some(FLOAT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    IntSampler2DMultisample,
                    IntVec2,
                    Some(FLOAT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    UintSampler2DMultisample,
                    IntVec2,
                    Some(FLOAT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                // SAMPLER_2D_MULTISAMPLE_ARRAY
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    Sampler2DMultisampleArray,
                    IntVec3,
                    Some(FLOAT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    IntSampler2DMultisampleArray,
                    IntVec3,
                    Some(FLOAT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    UintSampler2DMultisampleArray,
                    IntVec3,
                    Some(FLOAT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                if INT_TYPES[ndx] != Int {
                    // SAMPLER_2D_MULTISAMPLE
                    let source = gen_texel_fetch(ctx, shader_type, Sampler2DMultisample, IntVec2, Some(INT_TYPES[ndx]));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source =
                        gen_texel_fetch(ctx, shader_type, IntSampler2DMultisample, IntVec2, Some(INT_TYPES[ndx]));
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texel_fetch(
                        ctx,
                        shader_type,
                        UintSampler2DMultisample,
                        IntVec2,
                        Some(INT_TYPES[ndx]),
                    );
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    // SAMPLER_2D_MULTISAMPLE_ARRAY
                    let source = gen_texel_fetch(
                        ctx,
                        shader_type,
                        Sampler2DMultisampleArray,
                        IntVec3,
                        Some(INT_TYPES[ndx]),
                    );
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texel_fetch(
                        ctx,
                        shader_type,
                        IntSampler2DMultisampleArray,
                        IntVec3,
                        Some(INT_TYPES[ndx]),
                    );
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                    let source = gen_texel_fetch(
                        ctx,
                        shader_type,
                        UintSampler2DMultisampleArray,
                        IntVec3,
                        Some(INT_TYPES[ndx]),
                    );
                    ctx.verify_shader_does_not_compile(shader_type, &source);
                }
                // SAMPLER_2D_MULTISAMPLE
                let source = gen_texel_fetch(ctx, shader_type, Sampler2DMultisample, IntVec2, Some(UINT_TYPES[ndx]));
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    IntSampler2DMultisample,
                    IntVec2,
                    Some(UINT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    UintSampler2DMultisample,
                    IntVec2,
                    Some(UINT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                // SAMPLER_2D_MULTISAMPLE_ARRAY
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    Sampler2DMultisampleArray,
                    IntVec3,
                    Some(UINT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    IntSampler2DMultisampleArray,
                    IntVec3,
                    Some(UINT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
                let source = gen_texel_fetch(
                    ctx,
                    shader_type,
                    UintSampler2DMultisampleArray,
                    IntVec3,
                    Some(UINT_TYPES[ndx]),
                );
                ctx.verify_shader_does_not_compile(shader_type, &source);
            }
        });
    }
    Ok(())
}

fn texture_grad(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !(ctx.is_extension_supported("GL_EXT_texture_cube_map_array") || check_support(ctx)) {
        return Err(TestError::NotSupported(
            "Test requires support for GL_EXT_texture_cube_map_array or version 3.2.".to_string(),
        ));
    }

    per_shader(ctx, "textureGrad.", |ctx, shader_type| {
        let source = gen_texture_grad(ctx, shader_type, SamplerCubeArray, Float, FloatVec3, FloatVec3);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_grad(ctx, shader_type, SamplerCubeArray, FloatVec4, Float, FloatVec3);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_grad(ctx, shader_type, SamplerCubeArray, FloatVec4, FloatVec3, Float);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_grad(ctx, shader_type, IntSamplerCubeArray, Float, FloatVec3, FloatVec3);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_grad(ctx, shader_type, IntSamplerCubeArray, FloatVec4, Float, FloatVec3);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_grad(ctx, shader_type, IntSamplerCubeArray, FloatVec4, FloatVec3, Float);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_grad(ctx, shader_type, UintSamplerCubeArray, Float, FloatVec3, FloatVec3);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_grad(ctx, shader_type, UintSamplerCubeArray, FloatVec4, Float, FloatVec3);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_grad(ctx, shader_type, UintSamplerCubeArray, FloatVec4, FloatVec3, Float);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_sampler_2d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGrad - sampler2D", |ctx, shader_type| {
        let source = gen_texture_gather(ctx, shader_type, Sampler2D, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler2D, FloatVec2, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler2D, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSampler2D, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSampler2D, FloatVec2, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSampler2D, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler2D, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler2D, FloatVec2, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler2D, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler3D, FloatVec2, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler3D, FloatVec2, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_sampler_2d_array(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGrad - sampler2DArray", |ctx, shader_type| {
        let source = gen_texture_gather(ctx, shader_type, Sampler2DArray, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler2DArray, FloatVec3, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler2DArray, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSampler2DArray, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSampler2DArray, FloatVec3, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSampler2DArray, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler2DArray, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler2DArray, FloatVec3, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler2DArray, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler3D, FloatVec3, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler3D, FloatVec3, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_sampler_cube(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGrad - samplerCube", |ctx, shader_type| {
        let source = gen_texture_gather(ctx, shader_type, SamplerCube, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, SamplerCube, FloatVec3, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, SamplerCube, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSamplerCube, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSamplerCube, FloatVec3, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSamplerCube, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSamplerCube, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSamplerCube, FloatVec3, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSamplerCube, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler3D, FloatVec3, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSampler3D, FloatVec3, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_sampler_2d_shadow(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGrad - sampler2DShadow", |ctx, shader_type| {
        let source = gen_texture_gather(ctx, shader_type, Sampler2DShadow, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler2DShadow, FloatVec2, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler2DShadow, Float, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler3D, FloatVec2, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_sampler_2d_array_shadow(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGrad - sampler2DArrayShadow", |ctx, shader_type| {
        let source = gen_texture_gather(ctx, shader_type, Sampler2DArrayShadow, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler2DArrayShadow, FloatVec3, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler2DArrayShadow, Float, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler3D, FloatVec3, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_sampler_cube_shadow(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGrad - samplerCubeShadow", |ctx, shader_type| {
        let source = gen_texture_gather(ctx, shader_type, SamplerCubeShadow, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, SamplerCubeShadow, FloatVec3, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, SamplerCubeShadow, Float, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler3D, FloatVec3, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_sampler_cube_array(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !(check_support(ctx) || ctx.is_extension_supported("GL_EXT_texture_cube_map_array")) {
        return Err(TestError::NotSupported(
            "Test requires extension GL_EXT_texture_cube_map_array or context version 3.2 or higher.".to_string(),
        ));
    }

    per_shader(ctx, "textureGrad - samplerCubeArray", |ctx, shader_type| {
        let source = gen_texture_gather(ctx, shader_type, SamplerCubeArray, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, SamplerCubeArray, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, SamplerCubeArray, FloatVec4, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSamplerCubeArray, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSamplerCubeArray, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, IntSamplerCubeArray, FloatVec4, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSamplerCubeArray, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSamplerCubeArray, Float, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, UintSamplerCubeArray, FloatVec4, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler3D, FloatVec4, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_sampler_cube_array_shadow(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !(check_support(ctx) || ctx.is_extension_supported("GL_EXT_texture_cube_map_array")) {
        return Err(TestError::NotSupported(
            "Test requires extension GL_EXT_texture_cube_map_array or context version 3.2 or higher.".to_string(),
        ));
    }

    per_shader(ctx, "textureGrad - samplerCubeArrayShadow", |ctx, shader_type| {
        let source = gen_texture_gather(ctx, shader_type, SamplerCubeArrayShadow, Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, SamplerCubeArrayShadow, Float, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, SamplerCubeArrayShadow, FloatVec4, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather(ctx, shader_type, Sampler3D, FloatVec4, Some(Float));
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_offset_sampler_2d(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGatherOffset - sampler2D", |ctx, shader_type| {
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2D,
            Float,
            IntVec2,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2D,
            FloatVec2,
            Int,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2D,
            Float,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2D,
            FloatVec2,
            Int,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2D,
            FloatVec2,
            IntVec2,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2D,
            Float,
            IntVec2,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2D,
            FloatVec2,
            Int,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2D,
            Float,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2D,
            FloatVec2,
            Int,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2D,
            FloatVec2,
            IntVec2,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2D,
            Float,
            IntVec2,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2D,
            FloatVec2,
            Int,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2D,
            Float,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2D,
            FloatVec2,
            Int,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2D,
            FloatVec2,
            IntVec2,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler3D,
            FloatVec2,
            IntVec2,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler3D,
            FloatVec2,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_offset_sampler_2d_array(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGatherOffset - sampler2DArray", |ctx, shader_type| {
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2DArray,
            Float,
            IntVec2,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2DArray,
            FloatVec3,
            Int,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2DArray,
            Float,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2DArray,
            FloatVec3,
            Int,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            Sampler2DArray,
            FloatVec3,
            Int,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2DArray,
            Float,
            IntVec2,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2DArray,
            FloatVec3,
            Int,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2DArray,
            Float,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2DArray,
            FloatVec3,
            Int,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            IntSampler2DArray,
            FloatVec3,
            Int,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2DArray,
            Float,
            IntVec2,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2DArray,
            FloatVec3,
            Int,
            None,
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2DArray,
            Float,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2DArray,
            FloatVec3,
            Int,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler2DArray,
            FloatVec3,
            Int,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::Comp,
            UintSampler3D,
            FloatVec3,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_offset_sampler_2d_shadow(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGatherOffset - sampler2DShadow", |ctx, shader_type| {
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::RefZ,
            Sampler2DShadow,
            Float,
            IntVec2,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::RefZ,
            Sampler2DShadow,
            FloatVec2,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::RefZ,
            Sampler2DShadow,
            FloatVec2,
            Int,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::RefZ,
            Sampler3D,
            FloatVec2,
            IntVec2,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn texture_gather_offset_sampler_2d_array_shadow(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "textureGatherOffset - sampler2DShadow", |ctx, shader_type| {
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::RefZ,
            Sampler2DArrayShadow,
            Float,
            IntVec2,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::RefZ,
            Sampler2DArrayShadow,
            FloatVec3,
            IntVec2,
            Some(Int),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::RefZ,
            Sampler2DArrayShadow,
            FloatVec3,
            Int,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_texture_gather_offset(
            ctx,
            shader_type,
            GatherOffsetMode::RefZ,
            Sampler3D,
            FloatVec3,
            IntVec2,
            Some(Float),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn atomic_add(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "atomicAdd", |ctx, shader_type| {
        let source = gen_atomic(ctx, shader_type, "atomicAdd", Uint, Int, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_atomic(ctx, shader_type, "atomicAdd", Int, Uint, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn atomic_min(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "atomicMin", |ctx, shader_type| {
        let source = gen_atomic(ctx, shader_type, "atomicMin", Uint, Int, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_atomic(ctx, shader_type, "atomicMin", Int, Uint, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn atomic_max(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "atomicMax", |ctx, shader_type| {
        let source = gen_atomic(ctx, shader_type, "atomicMax", Uint, Int, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_atomic(ctx, shader_type, "atomicMax", Int, Uint, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn atomic_and(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "atomicAnd", |ctx, shader_type| {
        let source = gen_atomic(ctx, shader_type, "atomicAnd", Uint, Int, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_atomic(ctx, shader_type, "atomicAnd", Int, Uint, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn atomic_or(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "atomicOr", |ctx, shader_type| {
        let source = gen_atomic(ctx, shader_type, "atomicOr", Uint, Int, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_atomic(ctx, shader_type, "atomicOr", Int, Uint, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn atomic_xor(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "atomicXor", |ctx, shader_type| {
        let source = gen_atomic(ctx, shader_type, "atomicXor", Uint, Int, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_atomic(ctx, shader_type, "atomicXor", Int, Uint, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn atomic_exchange(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "atomicExchange", |ctx, shader_type| {
        let source = gen_atomic(ctx, shader_type, "atomicExchange", Uint, Int, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_atomic(ctx, shader_type, "atomicExchange", Int, Uint, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn atomic_comp_swap(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    per_shader(ctx, "atomicCompSwap", |ctx, shader_type| {
        let source = gen_atomic(ctx, shader_type, "atomicCompSwap", Uint, Int, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_atomic(ctx, shader_type, "atomicCompSwap", Int, Uint, Some(Int));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_atomic(ctx, shader_type, "atomicCompSwap", Int, Int, Some(Uint));
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn interpolate_at_centroid(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !(check_support(ctx) || ctx.is_extension_supported("GL_OES_shader_multisample_interpolation")) {
        return Err(TestError::NotSupported(
            "This test requires a context version 3.2 or higher.".to_string(),
        ));
    }

    per_shader(ctx, "interpolateAtCentroid", |ctx, shader_type| {
        if shader_type == ShaderType::Fragment {
            let source = gen_interpolate_at(ctx, shader_type, "interpolateAtCentroid", Int, None);
            ctx.verify_shader_does_not_compile(shader_type, &source);
        }
        let source = gen_interpolate_at(ctx, shader_type, "interpolateAtCentroid", Float, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_interpolate_at(ctx, shader_type, "interpolateAtCentroid", FloatVec2, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_interpolate_at(ctx, shader_type, "interpolateAtCentroid", FloatVec3, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_interpolate_at(ctx, shader_type, "interpolateAtCentroid", FloatVec4, None);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn interpolate_at_sample(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !(check_support(ctx) || ctx.is_extension_supported("GL_OES_shader_multisample_interpolation")) {
        return Err(TestError::NotSupported(
            "This test requires a context version 3.2 or higher.".to_string(),
        ));
    }

    per_shader(ctx, "interpolateAtSample", |ctx, shader_type| {
        if shader_type == ShaderType::Fragment {
            let source = gen_interpolate_at(ctx, shader_type, "interpolateAtSample", Int, Some(("sample", Int)));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_interpolate_at(ctx, shader_type, "interpolateAtSample", Float, Some(("sample", Float)));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_interpolate_at(
                ctx,
                shader_type,
                "interpolateAtSample",
                FloatVec2,
                Some(("sample", Float)),
            );
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_interpolate_at(
                ctx,
                shader_type,
                "interpolateAtSample",
                FloatVec3,
                Some(("sample", Float)),
            );
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_interpolate_at(
                ctx,
                shader_type,
                "interpolateAtSample",
                FloatVec4,
                Some(("sample", Float)),
            );
            ctx.verify_shader_does_not_compile(shader_type, &source);
        }
        let source = gen_interpolate_at(ctx, shader_type, "interpolateAtSample", Float, Some(("sample", Int)));
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_interpolate_at(
            ctx,
            shader_type,
            "interpolateAtSample",
            FloatVec2,
            Some(("sample", Int)),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_interpolate_at(
            ctx,
            shader_type,
            "interpolateAtSample",
            FloatVec3,
            Some(("sample", Int)),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_interpolate_at(
            ctx,
            shader_type,
            "interpolateAtSample",
            FloatVec4,
            Some(("sample", Int)),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn interpolate_at_offset(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !(check_support(ctx) || ctx.is_extension_supported("GL_OES_shader_multisample_interpolation")) {
        return Err(TestError::NotSupported(
            "This test requires a context version 3.2 or higher.".to_string(),
        ));
    }

    per_shader(ctx, "interpolateAtOffset", |ctx, shader_type| {
        if shader_type == ShaderType::Fragment {
            let source = gen_interpolate_at(
                ctx,
                shader_type,
                "interpolateAtOffset",
                Int,
                Some(("offset", FloatVec2)),
            );
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_interpolate_at(ctx, shader_type, "interpolateAtOffset", Float, Some(("offset", Float)));
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_interpolate_at(
                ctx,
                shader_type,
                "interpolateAtOffset",
                FloatVec2,
                Some(("offset", Float)),
            );
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_interpolate_at(
                ctx,
                shader_type,
                "interpolateAtOffset",
                FloatVec3,
                Some(("offset", Float)),
            );
            ctx.verify_shader_does_not_compile(shader_type, &source);
            let source = gen_interpolate_at(
                ctx,
                shader_type,
                "interpolateAtOffset",
                FloatVec4,
                Some(("offset", Float)),
            );
            ctx.verify_shader_does_not_compile(shader_type, &source);
        }
        let source = gen_interpolate_at(
            ctx,
            shader_type,
            "interpolateAtOffset",
            Float,
            Some(("offset", FloatVec2)),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_interpolate_at(
            ctx,
            shader_type,
            "interpolateAtOffset",
            FloatVec2,
            Some(("offset", FloatVec2)),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_interpolate_at(
            ctx,
            shader_type,
            "interpolateAtOffset",
            FloatVec3,
            Some(("offset", FloatVec2)),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_interpolate_at(
            ctx,
            shader_type,
            "interpolateAtOffset",
            FloatVec4,
            Some(("offset", FloatVec2)),
        );
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

fn fma(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !(check_support(ctx) || ctx.is_extension_supported("GL_EXT_gpu_shader5")) {
        return Err(TestError::NotSupported(
            "This test requires a context version 3.2 or higher.".to_string(),
        ));
    }

    per_shader(ctx, "fma", |ctx, shader_type| {
        let source = gen_fma(ctx, shader_type, Float, Float, Int);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_fma(ctx, shader_type, Float, Int, Float);
        ctx.verify_shader_does_not_compile(shader_type, &source);
        let source = gen_fma(ctx, shader_type, Int, Float, Float);
        ctx.verify_shader_does_not_compile(shader_type, &source);
    });
    Ok(())
}

// EmitVertex, EndPrimitive - the one pair whose per-stage loop skips a stage instead of
// building something illegal for it.

fn geometry_only(ctx: &mut NegativeTestContext<'_>, section: &str, function: &'static str) -> Result<(), TestError> {
    ctx.begin_section(section);
    for shader_type in SHADERS {
        if ctx.is_shader_supported(shader_type) {
            if shader_type == ShaderType::Geometry {
                continue;
            }
            ctx.begin_section(&format!("Verify shader: {}", shader_type.as_str()));
            let source = gen_geometry(ctx, shader_type, function);
            ctx.verify_shader_does_not_compile(shader_type, &source);
            ctx.end_section();
        }
    }
    ctx.end_section();
    Ok(())
}

fn emit_vertex(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    geometry_only(ctx, "EmitVertex.", "EmitVertex")
}

fn end_primitive(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    // \note upstream's section text misspells it.
    geometry_only(ctx, "EndPrimitieve.", "EndPrimitive")
}

// textureGatherOffsets - the one case driven by a spec table rather than a call sequence.

/// `testSpecs`
const GATHER_OFFSETS_SPECS: &[GatherOffsetsSpec] = &[
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2D,
        p: FloatVec2,
        offsets: IntVec2,
        fourth: None,
        offset_is_const: false,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2D,
        p: FloatVec2,
        offsets: IntVec2,
        fourth: None,
        offset_is_const: true,
        offset_array_size: 3,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2D,
        p: Float,
        offsets: IntVec2,
        fourth: None,
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2D,
        p: FloatVec2,
        offsets: Int,
        fourth: None,
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2D,
        p: FloatVec2,
        offsets: IntVec2,
        fourth: Some(Int),
        offset_is_const: false,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2D,
        p: FloatVec2,
        offsets: IntVec2,
        fourth: Some(Float),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2D,
        p: FloatVec2,
        offsets: IntVec2,
        fourth: Some(Int),
        offset_is_const: true,
        offset_array_size: 3,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2D,
        p: Float,
        offsets: IntVec2,
        fourth: Some(Int),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2D,
        p: FloatVec2,
        offsets: Int,
        fourth: Some(Int),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2DArray,
        p: FloatVec3,
        offsets: IntVec2,
        fourth: None,
        offset_is_const: false,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2DArray,
        p: FloatVec3,
        offsets: IntVec2,
        fourth: None,
        offset_is_const: true,
        offset_array_size: 3,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2DArray,
        p: Float,
        offsets: IntVec2,
        fourth: None,
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2DArray,
        p: FloatVec3,
        offsets: Int,
        fourth: None,
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2DArray,
        p: FloatVec3,
        offsets: IntVec2,
        fourth: Some(Int),
        offset_is_const: false,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2DArray,
        p: FloatVec3,
        offsets: IntVec2,
        fourth: Some(Float),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2DArray,
        p: FloatVec3,
        offsets: IntVec2,
        fourth: Some(Int),
        offset_is_const: true,
        offset_array_size: 3,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2DArray,
        p: Float,
        offsets: IntVec2,
        fourth: Some(Int),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::Comp,
        sampler: Sampler2DArray,
        p: FloatVec3,
        offsets: Int,
        fourth: Some(Int),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DShadow,
        p: FloatVec2,
        offsets: IntVec2,
        fourth: Some(Float),
        offset_is_const: false,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DShadow,
        p: FloatVec2,
        offsets: IntVec2,
        fourth: Some(Float),
        offset_is_const: true,
        offset_array_size: 3,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DShadow,
        p: Float,
        offsets: IntVec2,
        fourth: Some(Float),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DShadow,
        p: FloatVec2,
        offsets: Int,
        fourth: Some(Float),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DShadow,
        p: FloatVec2,
        offsets: IntVec2,
        fourth: Some(Int),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DArrayShadow,
        p: FloatVec3,
        offsets: IntVec2,
        fourth: Some(Float),
        offset_is_const: false,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DArrayShadow,
        p: FloatVec3,
        offsets: IntVec2,
        fourth: Some(Float),
        offset_is_const: true,
        offset_array_size: 3,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DArrayShadow,
        p: Float,
        offsets: IntVec2,
        fourth: Some(Float),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DArrayShadow,
        p: FloatVec3,
        offsets: Int,
        fourth: Some(Float),
        offset_is_const: true,
        offset_array_size: 4,
    },
    GatherOffsetsSpec {
        mode: GatherOffsetMode::RefZ,
        sampler: Sampler2DArrayShadow,
        p: FloatVec3,
        offsets: IntVec2,
        fourth: Some(Int),
        offset_is_const: true,
        offset_array_size: 4,
    },
];

fn texture_gather_offsets(ctx: &mut NegativeTestContext<'_>) -> Result<(), TestError> {
    if !(check_support(ctx) || ctx.is_extension_supported("GL_EXT_gpu_shader5")) {
        return Err(TestError::NotSupported(
            "This test requires a context version 3.2 or higher.".to_string(),
        ));
    }

    per_shader(ctx, "textureGatherOffsets", |ctx, shader_type| {
        for spec in GATHER_OFFSETS_SPECS {
            let source = gen_texture_gather_offsets(ctx, shader_type, spec);
            ctx.verify_shader_does_not_compile(shader_type, &source);
        }
    });
    Ok(())
}

/// `getNegativeShaderFunctionTestFunctions`
pub static FUNCTIONS: &[FunctionContainer] = &[
    FunctionContainer {
        function: bitfield_extract_invalid_value_type,
        name: "bitfield_extract_invalid_value_type",
    },
    FunctionContainer {
        function: bitfield_extract_invalid_offset_type,
        name: "bitfield_extract_invalid_offset_type",
    },
    FunctionContainer {
        function: bitfield_extract_invalid_bits_type,
        name: "bitfield_extract_invalid_bits_type",
    },
    FunctionContainer {
        function: bitfield_insert_invalid_base_type,
        name: "bitfield_insert_invalid_base_type",
    },
    FunctionContainer {
        function: bitfield_insert_invalid_insert_type,
        name: "bitfield_insert_invalid_insert_type",
    },
    FunctionContainer {
        function: bitfield_insert_invalid_offset_type,
        name: "bitfield_insert_invalid_offset_type",
    },
    FunctionContainer {
        function: bitfield_insert_invalid_bits_type,
        name: "bitfield_insert_invalid_bits_type",
    },
    FunctionContainer {
        function: bitfield_reverse,
        name: "bitfield_reverse",
    },
    FunctionContainer {
        function: bit_count,
        name: "bit_count",
    },
    FunctionContainer {
        function: find_msb,
        name: "find_msb",
    },
    FunctionContainer {
        function: find_lsb,
        name: "find_lsb",
    },
    FunctionContainer {
        function: uadd_carry_invalid_x,
        name: "uadd_carry_invalid_x",
    },
    FunctionContainer {
        function: uadd_carry_invalid_y,
        name: "uadd_carry_invalid_y",
    },
    FunctionContainer {
        function: uadd_carry_invalid_carry,
        name: "uadd_carry_invalid_carry",
    },
    FunctionContainer {
        function: usub_borrow_invalid_x,
        name: "usub_borrow_invalid_x",
    },
    FunctionContainer {
        function: usub_borrow_invalid_y,
        name: "usub_borrow_invalid_y",
    },
    FunctionContainer {
        function: usub_borrow_invalid_borrow,
        name: "usub_borrow_invalid_borrow",
    },
    FunctionContainer {
        function: umul_extended_invalid_x,
        name: "umul_extended_invalid_x",
    },
    FunctionContainer {
        function: umul_extended_invalid_y,
        name: "umul_extended_invalid_y",
    },
    FunctionContainer {
        function: umul_extended_invalid_msb,
        name: "umul_extended_invalid_msb",
    },
    FunctionContainer {
        function: umul_extended_invalid_lsb,
        name: "umul_extended_invalid_lsb",
    },
    FunctionContainer {
        function: imul_extended_invalid_x,
        name: "imul_extended_invalid_x",
    },
    FunctionContainer {
        function: imul_extended_invalid_y,
        name: "imul_extended_invalid_y",
    },
    FunctionContainer {
        function: imul_extended_invalid_msb,
        name: "imul_extended_invalid_msb",
    },
    FunctionContainer {
        function: imul_extended_invalid_lsb,
        name: "imul_extended_invalid_lsb",
    },
    FunctionContainer {
        function: frexp_invalid_x,
        name: "frexp_invalid_x",
    },
    FunctionContainer {
        function: frexp_invalid_exp,
        name: "frexp_invalid_exp",
    },
    FunctionContainer {
        function: ldexp_invalid_x,
        name: "ldexp_invalid_x",
    },
    FunctionContainer {
        function: ldexp_invalid_exp,
        name: "ldexp_invalid_exp",
    },
    FunctionContainer {
        function: pack_unorm_4x8,
        name: "pack_unorm_4x8",
    },
    FunctionContainer {
        function: pack_snorm_4x8,
        name: "pack_snorm_4x8",
    },
    FunctionContainer {
        function: unpack_snorm_4x8,
        name: "unpack_snorm_4x8",
    },
    FunctionContainer {
        function: unpack_unorm_4x8,
        name: "unpack_unorm_4x8",
    },
    FunctionContainer {
        function: texture_size_invalid_sampler,
        name: "texture_size_invalid_sampler",
    },
    FunctionContainer {
        function: texture_size_invalid_lod,
        name: "texture_size_invalid_lod",
    },
    FunctionContainer {
        function: texture_invalid_p,
        name: "texture_invalid_p",
    },
    FunctionContainer {
        function: texture_invalid_bias_or_compare,
        name: "texture_invalid_bias_or_compare",
    },
    FunctionContainer {
        function: texture_lod_invalid_p,
        name: "texture_lod_invalid_p",
    },
    FunctionContainer {
        function: texture_lod_invalid_lod,
        name: "texture_lod_invalid_lod",
    },
    FunctionContainer {
        function: texel_fetch_invalid_p,
        name: "texel_fetch_invalid_p",
    },
    FunctionContainer {
        function: texel_fetch_invalid_sample,
        name: "texel_fetch_invalid_sample",
    },
    FunctionContainer {
        function: emit_vertex,
        name: "emit_vertex",
    },
    FunctionContainer {
        function: end_primitive,
        name: "end_primitive",
    },
    FunctionContainer {
        function: texture_grad,
        name: "texture_grad",
    },
    FunctionContainer {
        function: texture_gather_sampler_2d,
        name: "texture_gather_sampler_2d",
    },
    FunctionContainer {
        function: texture_gather_sampler_2d_array,
        name: "texture_gather_sampler_2d_array",
    },
    FunctionContainer {
        function: texture_gather_sampler_cube,
        name: "texture_gather_sampler_cube",
    },
    FunctionContainer {
        function: texture_gather_sampler_2d_shadow,
        name: "texture_gather_sampler_2d_shadow",
    },
    FunctionContainer {
        function: texture_gather_sampler_2d_array_shadow,
        name: "texture_gather_sampler_2d_array_shadow",
    },
    FunctionContainer {
        function: texture_gather_sampler_cube_shadow,
        name: "texture_gather_sampler_cube_shadow",
    },
    FunctionContainer {
        function: texture_gather_sampler_cube_array,
        name: "texture_gather_sampler_cube_array",
    },
    FunctionContainer {
        function: texture_gather_sampler_cube_array_shadow,
        name: "texture_gather_sampler_cube_array_shadow",
    },
    FunctionContainer {
        function: texture_gather_offset_sampler_2d,
        name: "texture_gather_offset_sampler_2d",
    },
    FunctionContainer {
        function: texture_gather_offset_sampler_2d_array,
        name: "texture_gather_offset_sampler_2d_array",
    },
    FunctionContainer {
        function: texture_gather_offset_sampler_2d_shadow,
        name: "texture_gather_offset_sampler_2d_shadow",
    },
    FunctionContainer {
        function: texture_gather_offset_sampler_2d_array_shadow,
        name: "texture_gather_offset_sampler_2d_array_shadow",
    },
    FunctionContainer {
        function: texture_gather_offsets,
        name: "texture_gather_offsets",
    },
    FunctionContainer {
        function: atomic_add,
        name: "atomic_add",
    },
    FunctionContainer {
        function: atomic_min,
        name: "atomic_min",
    },
    FunctionContainer {
        function: atomic_max,
        name: "atomic_max",
    },
    FunctionContainer {
        function: atomic_and,
        name: "atomic_and",
    },
    FunctionContainer {
        function: atomic_or,
        name: "atomic_or",
    },
    FunctionContainer {
        function: atomic_xor,
        name: "atomic_xor",
    },
    FunctionContainer {
        function: atomic_exchange,
        name: "atomic_exchange",
    },
    FunctionContainer {
        function: atomic_comp_swap,
        name: "atomic_comp_swap",
    },
    FunctionContainer {
        function: interpolate_at_centroid,
        name: "interpolate_at_centroid",
    },
    FunctionContainer {
        function: interpolate_at_sample,
        name: "interpolate_at_sample",
    },
    FunctionContainer {
        function: interpolate_at_offset,
        name: "interpolate_at_offset",
    },
    FunctionContainer {
        function: fma,
        name: "fma",
    },
];
