// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cSparseTexture2Tests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The C++ class chain (`SparseTexture2CommitmentTestCase` <- `UncommittedRegionsAccessTestCase`, `SparseTexture2LookupTestCase`) is a `Commitment` (see `sparse_texture_tests.rs`, `v2` flag) plus free functions here, and the `SparseTextureClamp*` subclasses of the lookup case are `LookupKind`s whose overrides live in `sparse_texture_clamp_tests.rs`. `UncommittedDepthStencil` and its helpers are not ported: upstream's `iterate` never calls them. The `std::stringstream mLog` is a `String` that is logged when the case fails.
//
// Written without compiling.

#![allow(clippy::too_many_arguments)]

use super::sparse_texture_tests::{
    Commitment, SPARSE_TEXTURE_COMMITMENT_FORMATS, SPARSE_TEXTURE_COMMITMENT_TARGETS, TextureState,
    check_sparse_texture_support, fail_with_log, get_texture_level_size, get_texture_page_sizes,
    sparse_texture_allocation, texture_bind, texture_delete, texture_generate, texture_storage, texture_sub_image,
    texture_target_string,
};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus, TextureChannelClass};

macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals or buffers of the right size.
        unsafe { $call }
    };
}

pub(super) const ST2_COMPUTE_TEXTURE_FILL: &str = "#version 430 core\n\
\n\
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
\n\
layout (location = 1) writeonly uniform highp <INPUT_TYPE> uni_image;\n\
\n\
void main()\n\
{\n\
    <POINT_TYPE> point = <POINT_TYPE>(<POINT_DEF>);\n\
    memoryBarrier();\n\
    <RETURN_TYPE> color = <RETURN_TYPE><RESULT_EXPECTED>;\n\
    imageStore(uni_image, point<SAMPLE_DEF>, color);\n\
}\n";

const ST2_COMPUTE_TEXTURE_VERIFY: &str = "#version 430 core\n\
\n\
#extension GL_ARB_sparse_texture2 : enable\n\
\n\
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
\n\
layout (location = 1, r8ui) writeonly uniform <OUTPUT_TYPE> uni_out_image;\n\
layout (location = 2, <FORMAT>) readonly uniform <INPUT_TYPE> uni_in_image;\n\
\n\
void main()\n\
{\n\
    <POINT_TYPE> point = <POINT_TYPE>(<POINT_DEF>);\n\
    memoryBarrier();\n\
    highp <RETURN_TYPE> color,\n\
                        expected,\n\
                        epsilon;\n\
    color = imageLoad(uni_in_image, point<SAMPLE_DEF>);\n\
    expected = <RETURN_TYPE><RESULT_EXPECTED>;\n\
    epsilon = <RETURN_TYPE>(<EPSILON>);\n\
\n\
    if (all(lessThanEqual(color, expected + epsilon)) &&\n\
        all(greaterThanEqual(color, expected - epsilon)))\n\
    {\n\
        imageStore(uni_out_image, point, uvec4(255));\n\
    }\n\
    else {\n\
        imageStore(uni_out_image, point, uvec4(0));\n\
    }\n\
}\n";

const ST2_COMPUTE_ATOMIC_VERIFY: &str = "#version 430 core\n\
\n\
#extension GL_ARB_sparse_texture2 : enable\n\
\n\
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
\n\
layout (location = 1, r8ui) writeonly uniform <OUTPUT_TYPE> uni_out_image;\n\
layout (location = 2, <FORMAT>) uniform <INPUT_TYPE> uni_in_image;\n\
\n\
layout (location = 3) uniform int widthCommitted;\n\
\n\
void main()\n\
{\n\
    <POINT_TYPE> point,\n\
                 offset;\n\
    point = <POINT_TYPE>(<POINT_DEF>);\n\
    offset = <POINT_TYPE>(0);\n\
    offset.x = widthCommitted;\n\
    memoryBarrier();\n\
    if (point.x >= widthCommitted) {\n\
        uint index = ((point.x - widthCommitted) + point.y * 8) % 8;\n\
        <DATA_TYPE> value = 127;\n\
        if (index == 0)\n\
            value = imageAtomicExchange(uni_in_image, point<SAMPLE_DEF>,\n\
                                        <DATA_TYPE>(0x0F));\n\
        else if (index == 1)\n\
            value = imageAtomicCompSwap(uni_in_image, point<SAMPLE_DEF>,\n\
                                        <DATA_TYPE>(0), <DATA_TYPE>(0x0F));\n\
        else if (index == 2)\n\
            value = imageAtomicAdd(uni_in_image, point<SAMPLE_DEF>,\n\
                                   <DATA_TYPE>(0x0F));\n\
        else if (index == 3)\n\
            value = imageAtomicAnd(uni_in_image, point<SAMPLE_DEF>,\n\
                                   <DATA_TYPE>(0x0F));\n\
        else if (index == 4)\n\
            value = imageAtomicOr(uni_in_image, point<SAMPLE_DEF>,\n\
                                  <DATA_TYPE>(0x0F));\n\
        else if (index == 5)\n\
            value = imageAtomicXor(uni_in_image, point<SAMPLE_DEF>,\n\
                                   <DATA_TYPE>(0x0F));\n\
        else if (index == 6)\n\
            value = imageAtomicMin(uni_in_image, point<SAMPLE_DEF>,\n\
                                   <DATA_TYPE>(0x0F));\n\
        else if (index == 7)\n\
            value = imageAtomicMax(uni_in_image, point<SAMPLE_DEF>,\n\
                                   <DATA_TYPE>(0x0F));\n\
\n\
        <RETURN_TYPE> color = imageLoad(uni_in_image, point<SAMPLE_DEF>);\n\
\n\
        if (value == 0)\n\
            imageStore(uni_out_image, point - offset, uvec4(0));\n\
        else\n\
            imageStore(uni_out_image, point - offset, uvec4(value));\n\
\n\
        if (color.r == 0)\n\
            imageStore(uni_out_image, point, uvec4(0));\n\
        else\n\
            imageStore(uni_out_image, point, uvec4(1));\n\
    }\n\
}\n";

const ST2_COMPUTE_EXTENSION_CHECK: &str = "#version 450 core\n\
\n\
#extension <EXTENSION> : require\n\
\n\
#ifndef <EXTENSION>\n\
  #error <EXTENSION> not defined\n\
#else\n\
  #if (<EXTENSION> != 1)\n\
    #error <EXTENSION> wrong value\n\
  #endif\n\
#endif // <EXTENSION>\n\
\n\
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
\n\
void main()\n\
{\n\
}\n";

const ST2_COMPUTE_LOOKUP_VERIFY: &str = "#version 450 core\n\
\n\
#extension GL_ARB_sparse_texture2 : enable\n\
#extension GL_ARB_sparse_texture_clamp : enable\n\
\n\
layout (local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\n\
\n\
layout (location = 1, r8ui) writeonly uniform <OUTPUT_TYPE> uni_out;\n\
layout (location = 2<FORMAT_DEF>) uniform <INPUT_TYPE> uni_in;\n\
layout (location = 3) uniform int widthCommitted;\n\
\n\
void main()\n\
{\n\
    <POINT_TYPE> point = <POINT_TYPE>(<POINT_DEF>);\n\
    <ICOORD_TYPE> texSize = <ICOORD_TYPE>(<SIZE_DEF>);\n\
    <ICOORD_TYPE> icoord = <ICOORD_TYPE>(<COORD_DEF>);\n\
    <COORD_TYPE> coord = <COORD_TYPE>(<COORD_DEF>) / <COORD_TYPE>(texSize);\n\
    <RETURN_TYPE> retValue,\n\
                  expValue,\n\
                  epsilon;\n\
    retValue = <RETURN_TYPE>(0);\n\
    expValue = <RETURN_TYPE><RESULT_EXPECTED>;\n\
    epsilon = <RETURN_TYPE>(<EPSILON>);\n\
\n\
<CUBE_MAP_COORD_DEF>\n\
<OFFSET_ARRAY_DEF>\n\
\n\
    ivec2 corner1 = ivec2(1, 1);\n\
    ivec2 corner2 = ivec2(texSize.x - 1, texSize.y - 1);\n\
\n\
    int code = <FUNCTION>(uni_in,\n\
                          <POINT_COORD><SAMPLE_DEF><ARGUMENTS>,\n\
                          retValue<COMPONENT_DEF>);\n\
    memoryBarrier();\n\
\n\
    imageStore(uni_out, point, uvec4(255));\n\
\n\
    if (point.x > corner1.x && point.y > corner1.y &&\n\
        point.x < corner2.x && point.y < corner2.y &&\n\
        point.x < widthCommitted - 1)\n\
    {\n\
        if (!sparseTexelsResidentARB(code) ||\n\
            any(greaterThan(retValue, expValue + epsilon)) ||\n\
            any(lessThan(retValue, expValue - epsilon)))\n\
        {\n\
            imageStore(uni_out, point, uvec4(0));\n\
        }\n\
    }\n\
\n\
    if (point.x > corner1.x && point.y > corner1.y &&\n\
        point.x < corner2.x && point.y < corner2.y &&\n\
        point.x >= widthCommitted + 1)\n\
    {\n\
        if (sparseTexelsResidentARB(code))\n\
        {\n\
            imageStore(uni_out, point, uvec4(0));\n\
        }\n\
    }\n\
}\n";

/// `replaceToken`
pub(super) fn replace_token(token: &str, text: &str, string: &mut String) {
    *string = string.replace(token, text);
}

pub(super) fn gl_bool(value: bool) -> glw::GLboolean {
    if value { glw::TRUE } else { glw::FALSE }
}

/// `std::set<GLint> allowedTargets` and the name/arguments of `FunctionToken`.
#[derive(Clone)]
pub(super) struct FunctionToken {
    pub name: &'static str,
    pub arguments: &'static str,
    pub allowed_targets: Vec<GLenum>,
}

pub(super) fn function_token(name: &'static str, arguments: &'static str, allowed_targets: &[GLenum]) -> FunctionToken {
    FunctionToken {
        name,
        arguments,
        allowed_targets: allowed_targets.to_vec(),
    }
}

/// `SparseTexture2CommitmentTestCase::TokenStrings`
#[derive(Clone, Default)]
pub(super) struct TokenStrings {
    pub format: String,
    pub point_type: String,
    pub point_def: String,
    pub output_type: String,
    pub input_type: String,
    pub return_type: String,
    pub result_expected: String,
    pub result_default: String,
    pub epsilon: String,
    pub sample_def: String,
}

/// `SparseTexture2LookupTestCase::TokenStringsExt`, flattened (upstream derives from `TokenStrings`).
#[derive(Clone, Default)]
pub(super) struct TokenStringsExt {
    pub format: String,
    pub point_type: String,
    pub point_def: String,
    pub output_type: String,
    pub input_type: String,
    pub return_type: String,
    pub result_expected: String,
    #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
    pub result_default: String,
    pub epsilon: String,
    pub sample_def: String,
    pub format_def: String,
    pub size_def: String,
    pub lod: String,
    pub lod_def: String,
    pub coord_type: String,
    pub i_coord_type: String,
    pub coord_def: String,
    pub cube_map_coord_def: String,
    pub ref_z_def: String,
    pub cube_map_array_ref_z_def: String,
    pub offset_dim: String,
    pub offset_type: String,
    pub n_offset_type: String,
    pub component_def: String,
    pub offset_array_def: String,
    pub point_coord: String,
}

/// Which of the lookup test case classes runs: `SparseTexture2LookupTestCase` or one of its two `SparseTextureClamp` subclasses.
#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum LookupKind {
    Lookup,
    ClampResidency,
    #[expect(dead_code, reason = "upstream's enumerator, never constructed by this port")]
    ClampColor,
}

/// `(format, resultExpected, resultDefault, prefix)` of the `if (format == ...)` chain of `createShaderTokens`.
fn format_tokens(format: GLenum) -> Option<(&'static str, &'static str, &'static str, &'static str)> {
    let tokens = match format {
        glw::GL_R8 => ("r8", "(1, 0, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_R8_SNORM => ("r8_snorm", "(1, 0, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_R16 => ("r16", "(1, 0, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_R16_SNORM => ("r16_snorm", "(1, 0, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_RG8 => ("rg8", "(1, 1, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_RG8_SNORM => ("rg8_snorm", "(1, 1, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_RG16 => ("rg16", "(1, 1, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_RG16_SNORM => ("rg16_snorm", "(1, 1, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_RGBA8 => ("rgba8", "(1, 1, 1, 1)", "(0, 0, 0, 0)", ""),
        glw::GL_RGBA8_SNORM => ("rgba8_snorm", "(1, 1, 1, 1)", "(0, 0, 0, 0)", ""),
        glw::GL_RGB10_A2 => ("rgb10_a2", "(1, 1, 1, 1)", "(0, 0, 0, 0)", ""),
        glw::GL_RGB10_A2UI => ("rgb10_a2ui", "(1, 1, 1, 1)", "(0, 0, 0, 0)", "u"),
        glw::GL_RGBA16 => ("rgba16", "(1, 1, 1, 1)", "(0, 0, 0, 0)", ""),
        glw::GL_RGBA16_SNORM => ("rgba16_snorm", "(1, 1, 1, 1)", "(0, 0, 0, 0)", ""),
        glw::GL_R16F => ("r16f", "(1, 0, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_RG16F => ("rg16f", "(1, 1, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_RGBA16F => ("rgba16f", "(1, 1, 1, 1)", "(0, 0, 0, 0)", ""),
        glw::GL_R32F => ("r32f", "(1, 0, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_RG32F => ("rg32f", "(1, 1, 0, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_RGBA32F => ("rgba32f", "(1, 1, 1, 1)", "(0, 0, 0, 0)", ""),
        glw::GL_R11F_G11F_B10F => ("r11f_g11f_b10f", "(1, 1, 1, 1)", "(0, 0, 0, 1)", ""),
        glw::GL_R8I => ("r8i", "(1, 0, 0, 1)", "(0, 0, 0, 1)", "i"),
        glw::GL_R8UI => ("r8ui", "(1, 0, 0, 1)", "(0, 0, 0, 1)", "u"),
        glw::GL_R16I => ("r16i", "(1, 0, 0, 1)", "(0, 0, 0, 1)", "i"),
        glw::GL_R16UI => ("r16ui", "(1, 0, 0, 1)", "(0, 0, 0, 1)", "u"),
        glw::GL_R32I => ("r32i", "(1, 0, 0, 1)", "(0, 0, 0, 1)", "i"),
        glw::GL_R32UI => ("r32ui", "(1, 0, 0, 1)", "(0, 0, 0, 1)", "u"),
        glw::GL_RG8I => ("rg8i", "(1, 1, 0, 1)", "(0, 0, 0, 1)", "i"),
        glw::GL_RG8UI => ("rg8ui", "(1, 1, 0, 1)", "(0, 0, 0, 1)", "u"),
        glw::GL_RG16I => ("rg16i", "(1, 1, 0, 1)", "(0, 0, 0, 1)", "i"),
        glw::GL_RG16UI => ("rg16ui", "(1, 1, 0, 1)", "(0, 0, 0, 1)", "u"),
        glw::GL_RG32I => ("rg32i", "(1, 1, 0, 1)", "(0, 0, 0, 1)", "i"),
        glw::GL_RG32UI => ("rg32ui", "(1, 1, 0, 1)", "(0, 0, 0, 1)", "u"),
        glw::GL_RGBA8I => ("rgba8i", "(1, 1, 1, 1)", "(0, 0, 0, 0)", "i"),
        glw::GL_RGBA8UI => ("rgba8ui", "(1, 1, 1, 1)", "(0, 0, 0, 0)", "u"),
        glw::GL_RGBA16I => ("rgba16i", "(1, 1, 1, 1)", "(0, 0, 0, 0)", "i"),
        glw::GL_RGBA16UI => ("rgba16ui", "(1, 1, 1, 1)", "(0, 0, 0, 0)", "u"),
        glw::GL_RGBA32I => ("rgba32i", "(1, 1, 1, 1)", "(0, 0, 0, 0)", "i"),
        glw::GL_DEPTH_COMPONENT16 => ("r16", "(1, 0, 0, 0)", "(0, 0, 0, 0)", ""),
        _ => return None,
    };
    Some(tokens)
}

/// `SparseTexture2CommitmentTestCase::createShaderTokens`
pub(super) fn create_shader_tokens(
    target: GLenum,
    verify_target: GLenum,
    format: GLenum,
    sample: GLint,
    output_base: &str,
    input_base: &str,
) -> TokenStrings {
    let mut s = TokenStrings::default();
    let mut prefix = "";

    if let Some((format_name, expected, default, format_prefix)) = format_tokens(format) {
        s.format = format_name.to_string();
        s.result_expected = expected.to_string();
        s.result_default = default.to_string();
        prefix = format_prefix;
    }

    s.return_type = format!("{prefix}vec4");
    s.output_type = format!("u{output_base}2D");
    s.input_type = format!("{prefix}{input_base}2D");
    s.point_type = "ivec2".to_string();
    s.point_def = "gl_WorkGroupID.x, gl_WorkGroupID.y".to_string();

    s.epsilon = if s.return_type == "vec4" { "0.008" } else { "0" }.to_string();

    match target {
        glw::GL_TEXTURE_1D => {
            s.input_type = format!("{prefix}{input_base}1D");
            s.point_type = "int".to_string();
            s.point_def = "gl_WorkGroupID.x".to_string();
        }
        glw::GL_TEXTURE_1D_ARRAY => {
            s.input_type = format!("{prefix}{input_base}1DArray");
            s.point_type = "ivec2".to_string();
            s.point_def = "gl_WorkGroupID.x, gl_WorkGroupID.z".to_string();
        }
        glw::GL_TEXTURE_2D_ARRAY => {
            s.input_type = format!("{prefix}{input_base}2DArray");
            s.point_type = "ivec3".to_string();
            s.point_def = "gl_WorkGroupID.x, gl_WorkGroupID.y, gl_WorkGroupID.z".to_string();
        }
        glw::GL_TEXTURE_3D => {
            s.output_type = format!("u{output_base}2DArray");
            s.input_type = format!("{prefix}{input_base}3D");
            s.point_type = "ivec3".to_string();
            s.point_def = "gl_WorkGroupID.x, gl_WorkGroupID.y, gl_WorkGroupID.z".to_string();
        }
        glw::GL_TEXTURE_CUBE_MAP => {
            s.input_type = format!("{prefix}{input_base}Cube");
            s.point_type = "ivec3".to_string();
            s.point_def = "gl_WorkGroupID.x, gl_WorkGroupID.y, gl_WorkGroupID.z % 6".to_string();
        }
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => {
            s.input_type = format!("{prefix}{input_base}CubeArray");
            s.point_type = "ivec3".to_string();
            s.point_def = "gl_WorkGroupID.x, gl_WorkGroupID.y, gl_WorkGroupID.z".to_string();
        }
        glw::GL_TEXTURE_RECTANGLE => {
            s.input_type = format!("{prefix}{input_base}2DRect");
        }
        glw::GL_TEXTURE_2D_MULTISAMPLE => {
            s.input_type = format!("{prefix}{input_base}2DMS");
            s.sample_def = format!(", {sample}");
        }
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY => {
            s.input_type = format!("{prefix}{input_base}2DMSArray");
            s.point_type = "ivec3".to_string();
            s.point_def = "gl_WorkGroupID.x, gl_WorkGroupID.y, gl_WorkGroupID.z".to_string();
            s.sample_def = format!(", {sample}");
        }
        _ => {}
    }

    if verify_target == glw::GL_TEXTURE_2D {
        s.output_type = format!("u{output_base}2D");
    } else {
        s.output_type = format!("u{output_base}2DArray");
    }

    s
}

/// `SparseTexture2CommitmentTestCase::caseAllowed`
pub(super) fn commitment_case_allowed(target: GLenum, format: GLenum) -> bool {
    !((target == glw::GL_TEXTURE_2D_MULTISAMPLE || target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY)
        && (format == glw::GL_RGB565 || format == glw::GL_RGB10_A2UI || format == glw::GL_RGB9_E5))
}

/// The `verifyTarget` selection that `writeDataToTexture` and every `verify*` function repeat.
pub(super) fn verify_target_of(target: GLenum) -> GLenum {
    if target == glw::GL_TEXTURE_2D_MULTISAMPLE || target == glw::GL_TEXTURE_2D || target == glw::GL_TEXTURE_RECTANGLE {
        glw::GL_TEXTURE_2D
    } else {
        glw::GL_TEXTURE_2D_ARRAY
    }
}

/// A `Commitment` set up the way `SparseTexture2CommitmentTestCase` is.
pub(super) fn new_commitment(context: &Context, target: GLenum, format: GLenum, scale: GLint) -> Commitment<'_> {
    Commitment {
        gl: context.gl(),
        target,
        format,
        dsa: false,
        log: String::new(),
        state: TextureState::default(),
        v2: true,
        scale,
    }
}

pub(super) fn compile_compute<'gl>(gl: &'gl glw::Functions, shader: &str) -> ShaderProgram<'gl> {
    ShaderProgram::new(gl, &ProgramSources::compute(shader))
}

fn level_check(c: &Commitment<'_>, level: GLint) -> Result<(), TestError> {
    if level > c.state.levels - 1 {
        return Err(TestError::Fail("Invalid level".to_string()));
    }
    Ok(())
}

fn tex_format_of(c: &Commitment<'_>) -> Result<crate::tcu::TextureFormat, TestError> {
    c.state
        .format
        .ok_or_else(|| TestError::Fail("texture format is not mapped".to_string()))
}

/// The upstream `for x < widthCommitted / for y / for z` loop of `memcmp`s; the z loop repeats the same window so it is left out.
fn region_matches(
    exp_data: &[u8],
    out_data: &[u8],
    width: GLint,
    height: GLint,
    x_begin: GLint,
    x_end: GLint,
    pixel_size: usize,
) -> bool {
    let mut result = true;

    for x in x_begin..x_end {
        for y in 0..height {
            let offset = (x + y * width) as usize * pixel_size;
            if exp_data[offset..offset + pixel_size] != out_data[offset..offset + pixel_size] {
                result = false;
            }
        }
    }

    result
}

/// The compute shader fill of `writeDataToTexture`, shared by the commitment (multisample), lookup and clamp-color versions: `conv_format` is the image format, `clamp_level_expected` selects the level-dependent colour of `SparseTextureClampLookupColorTestCase`.
pub(super) fn fill_with_shader(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    (width, height, depth): (GLint, GLint, GLint),
    layered: bool,
    conv_format: GLenum,
    clamp_level_expected: bool,
) -> Result<(), TestError> {
    let gl = c.gl;
    let target = c.target;
    let format = c.format;

    for sample in 0..c.state.samples {
        let mut shader = ST2_COMPUTE_TEXTURE_FILL.to_string();

        let verify_target = verify_target_of(target);
        let mut s = create_shader_tokens(target, verify_target, format, sample, "image", "image");

        if clamp_level_expected {
            s.result_expected =
                super::sparse_texture_clamp_tests::generate_expected_result(&s.return_type, level, conv_format);
        }

        replace_token("<INPUT_TYPE>", &s.input_type, &mut shader);
        replace_token("<POINT_TYPE>", &s.point_type, &mut shader);
        replace_token("<POINT_DEF>", &s.point_def, &mut shader);
        replace_token("<RETURN_TYPE>", &s.return_type, &mut shader);
        replace_token("<RESULT_EXPECTED>", &s.result_expected, &mut shader);
        replace_token("<SAMPLE_DEF>", &s.sample_def, &mut shader);

        let program = compile_compute(gl, &shader);
        if program.is_ok() {
            gl!(gl.use_program(program.program()));
            glu::expect_no_error(gl, "glUseProgram")?;
            gl!(gl.bind_image_texture(0, texture, level, gl_bool(layered), 0, glw::GL_WRITE_ONLY, conv_format));
            glu::expect_no_error(gl, "glBindImageTexture")?;
            gl!(gl.uniform_1i(1, 0));
            glu::expect_no_error(gl, "glUniform1i")?;
            gl!(gl.dispatch_compute(width as GLuint, height as GLuint, depth as GLuint));
            glu::expect_no_error(gl, "glDispatchCompute")?;
            gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
            glu::expect_no_error(gl, "glMemoryBarrier")?;
        } else {
            let info_log = program.build_failure_summary().unwrap_or_default();
            c.log.push_str(&format!("Compute shader compilation failed (writing) for target: {target}, format: {format}, sample: {sample}, infoLog: {info_log}, shaderSource: {shader} - "));
        }
    }
    let _ = context;
    Ok(())
}

// ---------------------------------------------------------------------------------------------------------------------
// ShaderExtensionTestCase / StandardPageSizesTestCase / SparseTexture2AllocationTestCase
// ---------------------------------------------------------------------------------------------------------------------

pub(super) fn shader_extension(context: &Context, extension: &str) -> TestOutcome {
    if !context.context_info.is_extension_supported(extension) {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }

    let gl = context.gl();

    let mut shader = ST2_COMPUTE_EXTENSION_CHECK.to_string();
    replace_token("<EXTENSION>", extension, &mut shader);

    let program = compile_compute(gl, &shader);

    if !program.is_ok() {
        log::info!(
            "Checking shader preprocessor directives failed. Source:\n{shader}InfoLog:\n{}\n",
            program.build_failure_summary().unwrap_or_default()
        );
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

fn standard_page_sizes(context: &Context, target: GLenum, format: GLenum, page: (GLint, GLint, GLint)) -> TestOutcome {
    if !context.context_info.is_extension_supported("GL_ARB_sparse_texture2") {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }

    let gl = context.gl();

    log::info!("Testing getInternalformativ");

    let (page_size_x, page_size_y, page_size_z) = get_texture_page_sizes(gl, target, format)?;

    if (page_size_x, page_size_y, page_size_z) != page {
        log::info!(
            "Standard Virtual Page Size mismatch, target: {target}, format: {format}, returned: {page_size_x}/{page_size_y}/{page_size_z}, expected: {}/{}/{}",
            page.0,
            page.1,
            page.2
        );
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

fn sparse_texture2_allocation(
    context: &Context,
    target: Option<GLenum>,
    full_array_target: Option<GLenum>,
    format: GLenum,
) -> TestOutcome {
    if !context.context_info.is_extension_supported("GL_ARB_sparse_texture2") {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }

    sparse_texture_allocation(context, target, full_array_target, format)
}

// ---------------------------------------------------------------------------------------------------------------------
// SparseTexture2CommitmentTestCase
// ---------------------------------------------------------------------------------------------------------------------

fn sparse_texture2_commitment(context: &Context, target: GLenum, format: GLenum) -> TestOutcome {
    if !context.context_info.is_extension_supported("GL_ARB_sparse_texture2") {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }
    check_sparse_texture_support(context)?;

    if commitment_case_allowed(target, format) {
        let mut c = new_commitment(context, target, format, 2);
        let gl = c.gl;

        c.log.push_str(&format!(
            "Testing sparse texture commitment for target: {target}, format: {format} - "
        ));

        let mut result = true;

        let mut texture = c.sparse_allocate_texture(3)?;
        for level in 0..c.state.levels {
            write_data_to_texture(context, &mut c, texture, level)?;
        }

        for level in 0..c.state.levels {
            if c.commit_texture_page(texture, level)? {
                write_data_to_texture(context, &mut c, texture, level)?;
                result = verify_texture_data(context, &mut c, texture, level)?;
            }

            if !result {
                break;
            }
        }

        texture_delete(gl, texture)?;

        result = result && c.verify_invalid_operation_errors(&mut texture)?;
        result = result && c.verify_invalid_value_errors(&mut texture)?;

        if !result {
            return fail_with_log(&c.log, "Fail");
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `SparseTexture2CommitmentTestCase::writeDataToTexture`
pub(super) fn write_data_to_texture(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
) -> Result<(), TestError> {
    let gl = c.gl;
    let target = c.target;
    c.log.push_str(&format!("Fill Texture [level: {level}] - "));

    level_check(c, level)?;

    let transfer_format = glu::get_transfer_format(tex_format_of(c)?)?;

    let (width, height, mut depth) = get_texture_level_size(target, &c.state, level);

    if width > 0 && height > 0 && depth >= c.state.min_depth {
        if target == glw::GL_TEXTURE_CUBE_MAP {
            depth *= 6;
        }

        let tex_size = (width * height * depth * c.pixel_size()?) as usize;

        let data = vec![255u8; tex_size];

        if target != glw::GL_TEXTURE_2D_MULTISAMPLE && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY {
            texture_sub_image(
                gl,
                target,
                level,
                0,
                0,
                0,
                width,
                height,
                depth,
                transfer_format.format,
                transfer_format.data_type,
                data.as_ptr().cast(),
            )?;
            glu::expect_no_error(gl, "SubImage")?;
        } else {
            let format = c.format;
            fill_with_shader(
                context,
                c,
                texture,
                level,
                (width, height, depth),
                depth > 1,
                format,
                false,
            )?;
        }
    }

    Ok(())
}

/// `SparseTexture2CommitmentTestCase::verifyTextureData`
pub(super) fn verify_texture_data(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    let _format = c.format;
    c.log.push_str(&format!("Verify Texture [level: {level}] - "));

    level_check(c, level)?;

    let transfer_format = glu::get_transfer_format(tex_format_of(c)?)?;

    let (width, height, depth) = get_texture_level_size(target, &c.state, level);

    let width_committed = width / 2;

    if width_committed == 0 || height == 0 || depth < c.state.min_depth {
        return Ok(true);
    }

    let pixel_size = c.pixel_size()? as usize;
    let mut result = true;

    if target != glw::GL_TEXTURE_CUBE_MAP
        && target != glw::GL_TEXTURE_2D_MULTISAMPLE
        && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
    {
        let tex_size = (width * height * depth) as usize * pixel_size;

        let exp_data = vec![255u8; tex_size];
        let mut out_data = vec![127u8; tex_size];

        gl!(gl.get_tex_image(
            target,
            level,
            transfer_format.format,
            transfer_format.data_type,
            out_data.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "Texture::GetData")?;

        result = region_matches(&exp_data, &out_data, width, height, 0, width_committed, pixel_size);
    } else if target == glw::GL_TEXTURE_CUBE_MAP {
        let sub_targets = [
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
        ];

        let tex_size = (width * height) as usize * pixel_size;

        let exp_data = vec![255u8; tex_size];
        let mut out_data = vec![127u8; tex_size];

        for sub_target in sub_targets {
            c.log
                .push_str(&format!("Verify Subtarget [subtarget: {sub_target}] - "));

            out_data.fill(127);

            gl!(gl.get_tex_image(
                sub_target,
                level,
                transfer_format.format,
                transfer_format.data_type,
                out_data.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Texture::GetData")?;

            result = region_matches(&exp_data, &out_data, width, height, 0, width_committed, pixel_size);

            if !result {
                break;
            }
        }
    } else {
        let verify_target = verify_target_of(target);

        let verify_texture = texture_generate(gl)?;
        texture_bind(gl, verify_texture, verify_target)?;
        texture_storage(gl, verify_target, 1, glw::GL_R8, width, height, depth)?;
        glu::expect_no_error(gl, "Texture::Storage")?;

        let outcome = verify_multisample_texture(
            context,
            c,
            texture,
            level,
            (width, height, depth),
            width_committed,
            verify_texture,
            verify_target,
        );

        texture_delete(gl, verify_texture)?;

        result = outcome?;
    }

    Ok(result)
}

/// The sample loop of the multisample branch of `verifyTextureData`.
fn verify_multisample_texture(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    (width, height, depth): (GLint, GLint, GLint),
    width_committed: GLint,
    verify_texture: GLuint,
    verify_target: GLenum,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    let format = c.format;
    let _ = context;

    let tex_size = (width * height * depth) as usize;
    let exp_data = vec![255u8; tex_size];
    let mut out_data = vec![0u8; tex_size];

    for sample in 0..c.state.samples {
        out_data.fill(0);

        texture_bind(gl, verify_texture, verify_target)?;
        texture_sub_image(
            gl,
            verify_target,
            0,
            0,
            0,
            0,
            width,
            height,
            depth,
            glw::GL_RED,
            glw::GL_UNSIGNED_BYTE,
            out_data.as_ptr().cast(),
        )?;
        glu::expect_no_error(gl, "Texture::SubImage")?;

        let mut shader = ST2_COMPUTE_TEXTURE_VERIFY.to_string();

        let s = create_shader_tokens(target, verify_target, format, sample, "image", "image");

        replace_token("<OUTPUT_TYPE>", &s.output_type, &mut shader);
        replace_token("<FORMAT>", &s.format, &mut shader);
        replace_token("<INPUT_TYPE>", &s.input_type, &mut shader);
        replace_token("<POINT_TYPE>", &s.point_type, &mut shader);
        replace_token("<POINT_DEF>", &s.point_def, &mut shader);
        replace_token("<RETURN_TYPE>", &s.return_type, &mut shader);
        replace_token("<SAMPLE_DEF>", &s.sample_def, &mut shader);
        replace_token("<RESULT_EXPECTED>", &s.result_expected, &mut shader);
        replace_token("<EPSILON>", &s.epsilon, &mut shader);

        let program = compile_compute(gl, &shader);
        if program.is_ok() {
            gl!(gl.use_program(program.program()));
            glu::expect_no_error(gl, "glUseProgram")?;
            gl!(gl.bind_image_texture(
                0,
                verify_texture,
                0,
                gl_bool(depth > 1),
                0,
                glw::GL_WRITE_ONLY,
                glw::GL_R8UI
            ));
            glu::expect_no_error(gl, "glBindImageTexture")?;
            gl!(gl.bind_image_texture(1, texture, level, gl_bool(depth > 1), 0, glw::GL_READ_ONLY, format));
            glu::expect_no_error(gl, "glBindImageTexture")?;
            gl!(gl.uniform_1i(1, 0));
            glu::expect_no_error(gl, "glUniform1i")?;
            gl!(gl.uniform_1i(2, 1));
            glu::expect_no_error(gl, "glUniform1i")?;
            gl!(gl.dispatch_compute(width as GLuint, height as GLuint, depth as GLuint));
            glu::expect_no_error(gl, "glDispatchCompute")?;
            gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
            glu::expect_no_error(gl, "glMemoryBarrier")?;

            gl!(gl.get_tex_image(
                verify_target,
                0,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                out_data.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Texture::GetData")?;

            for x in 0..width_committed {
                for y in 0..height {
                    for z in 0..depth {
                        let index = (x + y * width + z * width * height) as usize;
                        if exp_data[index] != out_data[index] {
                            log::info!(
                                "{}Error detected at {x},{y},{z} for sample {sample}: expected [{}] got [{}]",
                                c.log,
                                exp_data[index],
                                out_data[index]
                            );
                            return Ok(false);
                        }
                    }
                }
            }
        } else {
            let info_log = program.build_failure_summary().unwrap_or_default();
            c.log.push_str(&format!("Compute shader compilation failed (reading) for target: {target}, format: {format}, infoLog: {info_log}, shaderSource: {shader} - "));

            return Ok(false);
        }
    }

    Ok(true)
}

// ---------------------------------------------------------------------------------------------------------------------
// UncommittedRegionsAccessTestCase
// ---------------------------------------------------------------------------------------------------------------------

fn uncommitted_regions_access(context: &Context, target: GLenum, format: GLenum) -> TestOutcome {
    if !context.context_info.is_extension_supported("GL_ARB_sparse_texture2") {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }

    if commitment_case_allowed(target, format) {
        let mut c = new_commitment(context, target, format, 2);
        let gl = c.gl;
        let mut result = true;

        c.log.push_str(&format!(
            "Testing uncommitted regions access for target: {target}, format: {format} - "
        ));

        let texture = c.sparse_allocate_texture(3)?;
        for level in 0..c.state.levels {
            if c.commit_texture_page(texture, level)? {
                write_data_to_texture(context, &mut c, texture, level)?;
                result = result && uncommitted_reads(context, &mut c, texture, level)?;
                result = result && uncommitted_atomic_operations(context, &mut c, texture, level)?;
            }

            if !result {
                break;
            }
        }

        texture_delete(gl, texture)?;

        if !result {
            return fail_with_log(&c.log, "Fail");
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `UncommittedRegionsAccessTestCase::readsAllowed`
fn reads_allowed(format: GLenum, shader_only: bool) -> bool {
    !(shader_only && (format == glw::GL_RGB565 || format == glw::GL_RGB10_A2UI || format == glw::GL_RGB9_E5))
}

/// `UncommittedRegionsAccessTestCase::atomicAllowed`
fn atomic_allowed(format: GLenum) -> bool {
    format == glw::GL_R32I || format == glw::GL_R32UI
}

/// `UncommittedRegionsAccessTestCase::UncommittedReads`
fn uncommitted_reads(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    let format = c.format;
    let mut result = true;

    if reads_allowed(format, false) {
        c.log.push_str("API Reads - ");
        result = result && verify_texture_data_extended(context, c, texture, level, false)?;
    }

    if result && reads_allowed(format, true) {
        c.log.push_str("Shader Reads - ");
        result = result && verify_texture_data_extended(context, c, texture, level, true)?;
    }

    if result
        && level == 0
        && target != glw::GL_TEXTURE_RECTANGLE
        && target != glw::GL_TEXTURE_2D_MULTISAMPLE
        && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
    {
        // Khronos bugzilla #9471 states that mipmap generation with integer formats is unsupported, so skip this test
        match format {
            glw::GL_RGB10_A2UI
            | glw::GL_R8I
            | glw::GL_R8UI
            | glw::GL_R16I
            | glw::GL_R16UI
            | glw::GL_R32I
            | glw::GL_R32UI
            | glw::GL_RG8I
            | glw::GL_RG8UI
            | glw::GL_RG16I
            | glw::GL_RG16UI
            | glw::GL_RG32I
            | glw::GL_RG32UI
            | glw::GL_RGBA8I
            | glw::GL_RGBA8UI
            | glw::GL_RGBA16I
            | glw::GL_RGBA16UI
            | glw::GL_RGBA32I
            | glw::GL_RGBA32UI => return Ok(result),
            _ => {}
        }
        c.log.push_str("Mipmap Generate - ");
        texture_bind(gl, texture, target)?;
        gl!(gl.generate_mipmap(target));
        glu::expect_no_error(gl, "glGenerateMipmap")?;

        for _ in 1..c.state.levels {
            result = result && verify_texture_data_extended(context, c, texture, level, false)?;
        }
    }

    Ok(result)
}

/// `UncommittedRegionsAccessTestCase::UncommittedAtomicOperations`
fn uncommitted_atomic_operations(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
) -> Result<bool, TestError> {
    let mut result = true;

    if atomic_allowed(c.format) {
        c.log.push_str("Atomic Operations - ");
        result = result && verify_atomic_operations(context, c, texture, level)?;
    }

    Ok(result)
}

/// `UncommittedRegionsAccessTestCase::verifyTextureDataExtended`
fn verify_texture_data_extended(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    shader_only: bool,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    c.log.push_str(&format!("Verify Texture [level: {level}] - "));

    level_check(c, level)?;

    let transfer_format = glu::get_transfer_format(tex_format_of(c)?)?;

    let (width, height, mut depth) = get_texture_level_size(target, &c.state, level);

    let width_committed = width / 2;

    if width_committed == 0 || height == 0 || depth < c.state.min_depth {
        return Ok(true);
    }

    let pixel_size = c.pixel_size()? as usize;
    let mut result = true;

    if !shader_only
        && target != glw::GL_TEXTURE_CUBE_MAP
        && target != glw::GL_TEXTURE_2D_MULTISAMPLE
        && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
    {
        let tex_size = (width * height * depth) as usize * pixel_size;

        // Expected value in this case is 0 because atomic operations result on uncommitted regions are zeros
        let exp_data = vec![0u8; tex_size];
        let mut out_data = vec![255u8; tex_size];

        gl!(gl.get_tex_image(
            target,
            level,
            transfer_format.format,
            transfer_format.data_type,
            out_data.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "Texture::GetData")?;

        result = compare_uncommitted(
            &mut c.log,
            &exp_data,
            &out_data,
            width,
            height,
            width_committed,
            pixel_size,
        );
    } else if !shader_only && target == glw::GL_TEXTURE_CUBE_MAP {
        let sub_targets = [
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
        ];

        let tex_size = (width * height) as usize * pixel_size;

        let exp_data = vec![0u8; tex_size];
        let mut out_data = vec![255u8; tex_size];

        for sub_target in sub_targets {
            c.log
                .push_str(&format!("Verify Subtarget [subtarget: {sub_target}] - "));

            out_data.fill(255);

            gl!(gl.get_tex_image(
                sub_target,
                level,
                transfer_format.format,
                transfer_format.data_type,
                out_data.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Texture::GetData")?;

            result = compare_uncommitted(
                &mut c.log,
                &exp_data,
                &out_data,
                width,
                height,
                width_committed,
                pixel_size,
            );

            if !result {
                break;
            }
        }
    } else if shader_only {
        let verify_target = verify_target_of(target);

        if target == glw::GL_TEXTURE_CUBE_MAP {
            depth *= 6;
        }
        let mut token_target = target;
        if depth == 1 && c.state.samples == 1 {
            token_target = glw::GL_TEXTURE_2D;
        }

        let verify_texture = texture_generate(gl)?;
        texture_bind(gl, verify_texture, verify_target)?;
        texture_storage(gl, verify_target, 1, glw::GL_R8, width, height, depth)?;
        glu::expect_no_error(gl, "Texture::Storage")?;

        let outcome = verify_shader_reads(
            c,
            texture,
            level,
            (width, height, depth),
            width_committed,
            verify_texture,
            verify_target,
            token_target,
        );

        texture_delete(gl, verify_texture)?;

        result = outcome?;
    }

    let _ = context;
    Ok(result)
}

/// The expected-zero comparison of the uncommitted region, logging the first mismatching texel's bytes like upstream.
fn compare_uncommitted(
    log: &mut String,
    exp_data: &[u8],
    out_data: &[u8],
    width: GLint,
    height: GLint,
    width_committed: GLint,
    pixel_size: usize,
) -> bool {
    let mut result = true;

    'x: for x in width_committed..width {
        for y in 0..height {
            let offset = (x + y * width) as usize * pixel_size;
            let expected = &exp_data[offset..offset + pixel_size];
            let got = &out_data[offset..offset + pixel_size];
            if expected != got {
                log.push_str(&format!("Error detected at {x},{y},0: expected [ "));
                for byte in expected {
                    log.push_str(&format!("{byte} "));
                }
                log.push_str("] got [ ");
                for byte in got {
                    log.push_str(&format!("{byte} "));
                }
                log.push_str("] ");
                result = false;
                break 'x;
            }
        }
    }

    result
}

/// The sample loop of the `shaderOnly` branch of `verifyTextureDataExtended`.
fn verify_shader_reads(
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    (width, height, depth): (GLint, GLint, GLint),
    width_committed: GLint,
    verify_texture: GLuint,
    verify_target: GLenum,
    token_target: GLenum,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let format = c.format;

    let tex_size = (width * height * depth) as usize;

    // Expected value in this case is 255 because shader fills output texture with 255 if in texture is filled with zeros
    let exp_data = vec![255u8; tex_size];
    let mut out_data = vec![0u8; tex_size];

    for sample in 0..c.state.samples {
        out_data.fill(0);

        texture_bind(gl, verify_texture, verify_target)?;
        texture_sub_image(
            gl,
            verify_target,
            0,
            0,
            0,
            0,
            width,
            height,
            depth,
            glw::GL_RED,
            glw::GL_UNSIGNED_BYTE,
            out_data.as_ptr().cast(),
        )?;
        glu::expect_no_error(gl, "Texture::SubImage")?;

        let mut shader = ST2_COMPUTE_TEXTURE_VERIFY.to_string();

        let s = create_shader_tokens(token_target, verify_target, format, sample, "image", "image");

        replace_token("<OUTPUT_TYPE>", &s.output_type, &mut shader);
        replace_token("<FORMAT>", &s.format, &mut shader);
        replace_token("<INPUT_TYPE>", &s.input_type, &mut shader);
        replace_token("<POINT_TYPE>", &s.point_type, &mut shader);
        replace_token("<POINT_DEF>", &s.point_def, &mut shader);
        replace_token("<RETURN_TYPE>", &s.return_type, &mut shader);
        replace_token("<SAMPLE_DEF>", &s.sample_def, &mut shader);
        replace_token("<RESULT_EXPECTED>", &s.result_default, &mut shader);
        replace_token("<EPSILON>", &s.epsilon, &mut shader);

        let program = compile_compute(gl, &shader);
        if program.is_ok() {
            gl!(gl.use_program(program.program()));
            glu::expect_no_error(gl, "glUseProgram")?;
            gl!(gl.bind_image_texture(
                0,
                verify_texture,
                0,
                gl_bool(depth > 1),
                0,
                glw::GL_WRITE_ONLY,
                glw::GL_R8UI
            ));
            glu::expect_no_error(gl, "glBindImageTexture")?;
            gl!(gl.bind_image_texture(1, texture, level, gl_bool(depth > 1), 0, glw::GL_READ_ONLY, format));
            glu::expect_no_error(gl, "glBindImageTexture")?;
            gl!(gl.uniform_1i(1, 0));
            glu::expect_no_error(gl, "glUniform1i")?;
            gl!(gl.uniform_1i(2, 1));
            glu::expect_no_error(gl, "glUniform1i")?;
            gl!(gl.dispatch_compute(width as GLuint, height as GLuint, depth as GLuint));
            glu::expect_no_error(gl, "glDispatchCompute")?;
            gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
            glu::expect_no_error(gl, "glMemoryBarrier")?;

            gl!(gl.get_tex_image(
                verify_target,
                0,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                out_data.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Texture::GetData")?;

            for x in width_committed..width {
                for y in 0..height {
                    for z in 0..depth {
                        let index = (x + y * width + z * width * height) as usize;
                        if exp_data[index] != out_data[index] {
                            log::info!(
                                "{}Error detected at {x},{y},{z} for sample {sample}: expected [{}] got [{}]",
                                c.log,
                                exp_data[index],
                                out_data[index]
                            );
                            return Ok(false);
                        }
                    }
                }
            }
        } else {
            let info_log = program.build_failure_summary().unwrap_or_default();
            c.log.push_str(&format!("Compute shader compilation failed (reading) for target: {token_target}, format: {format}, sample: {sample}, infoLog: {info_log}, shaderSource: {shader} - "));

            return Ok(false);
        }
    }

    Ok(true)
}

/// `UncommittedRegionsAccessTestCase::verifyAtomicOperations`
fn verify_atomic_operations(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    c.log.push_str(&format!("Verify Atomic Operations [level: {level}] - "));

    level_check(c, level)?;

    let (width, height, mut depth) = get_texture_level_size(target, &c.state, level);

    let width_committed = width / 2;

    if width_committed == 0 || height == 0 || depth < c.state.min_depth {
        return Ok(true);
    }

    let verify_target = verify_target_of(target);
    if target == glw::GL_TEXTURE_CUBE_MAP {
        depth *= 6;
    }
    let mut token_target = target;
    if depth == 1 && c.state.samples == 1 {
        token_target = glw::GL_TEXTURE_2D;
    }

    let verify_texture = texture_generate(gl)?;
    texture_bind(gl, verify_texture, verify_target)?;
    texture_storage(gl, verify_target, 1, glw::GL_R8, width, height, depth)?;
    glu::expect_no_error(gl, "Texture::Storage")?;

    let outcome = run_atomic_verify(
        c,
        texture,
        level,
        (width, height, depth),
        width_committed,
        verify_texture,
        verify_target,
        token_target,
    );

    texture_delete(gl, verify_texture)?;

    let _ = context;
    outcome
}

/// The sample loop of `verifyAtomicOperations`.
fn run_atomic_verify(
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    (width, height, depth): (GLint, GLint, GLint),
    width_committed: GLint,
    verify_texture: GLuint,
    verify_target: GLenum,
    token_target: GLenum,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let format = c.format;

    let tex_size = (width * height * depth) as usize;

    // Expected value in this case is 0 because atomic operations result on uncommitted regions are zeros
    let exp_data = vec![0u8; tex_size];
    let mut out_data = vec![255u8; tex_size];

    for sample in 0..c.state.samples {
        out_data.fill(255);

        texture_bind(gl, verify_texture, verify_target)?;
        texture_sub_image(
            gl,
            verify_target,
            0,
            0,
            0,
            0,
            width,
            height,
            depth,
            glw::GL_RED,
            glw::GL_UNSIGNED_BYTE,
            out_data.as_ptr().cast(),
        )?;
        glu::expect_no_error(gl, "Texture::SubImage")?;

        let mut shader = ST2_COMPUTE_ATOMIC_VERIFY.to_string();

        let s = create_shader_tokens(token_target, verify_target, format, sample, "image", "image");
        let data_type = if s.return_type == "ivec4" { "int" } else { "uint" };

        replace_token("<OUTPUT_TYPE>", &s.output_type, &mut shader);
        replace_token("<FORMAT>", &s.format, &mut shader);
        replace_token("<INPUT_TYPE>", &s.input_type, &mut shader);
        replace_token("<POINT_TYPE>", &s.point_type, &mut shader);
        replace_token("<POINT_DEF>", &s.point_def, &mut shader);
        replace_token("<DATA_TYPE>", data_type, &mut shader);
        replace_token("<SAMPLE_DEF>", &s.sample_def, &mut shader);
        replace_token("<RETURN_TYPE>", &s.return_type, &mut shader);

        let program = compile_compute(gl, &shader);
        if program.is_ok() {
            gl!(gl.use_program(program.program()));
            glu::expect_no_error(gl, "glUseProgram")?;
            gl!(gl.bind_image_texture(
                0,
                verify_texture,
                0,
                gl_bool(depth > 1),
                0,
                glw::GL_WRITE_ONLY,
                glw::GL_R8UI
            ));
            glu::expect_no_error(gl, "glBindImageTexture")?;
            gl!(gl.bind_image_texture(1, texture, level, gl_bool(depth > 1), 0, glw::GL_READ_ONLY, format));
            glu::expect_no_error(gl, "glBindImageTexture")?;
            gl!(gl.uniform_1i(1, 0));
            glu::expect_no_error(gl, "glUniform1i")?;
            gl!(gl.uniform_1i(2, 1));
            glu::expect_no_error(gl, "glUniform1i")?;
            gl!(gl.uniform_1i(3, width_committed));
            glu::expect_no_error(gl, "glUniform1i")?;
            gl!(gl.dispatch_compute(width as GLuint, height as GLuint, depth as GLuint));
            glu::expect_no_error(gl, "glDispatchCompute")?;
            gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
            glu::expect_no_error(gl, "glMemoryBarrier")?;

            gl!(gl.get_tex_image(
                verify_target,
                0,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                out_data.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Texture::GetData")?;

            for x in 0..width {
                for y in 0..height {
                    for z in 0..depth {
                        let index = (x + y * width + z * width * height) as usize;
                        if exp_data[index] != out_data[index] {
                            log::info!(
                                "{}Error detected at {x},{y},{z} for sample {sample}: expected [{}] got [{}]",
                                c.log,
                                exp_data[index],
                                out_data[index]
                            );
                            return Ok(false);
                        }
                    }
                }
            }
        } else {
            let info_log = program.build_failure_summary().unwrap_or_default();
            c.log.push_str(&format!("Compute shader compilation failed (atomic) for target: {token_target}, format: {format}, sample: {sample}, infoLog: {info_log}, shaderSource: {shader} - "));

            return Ok(false);
        }
    }

    Ok(true)
}

// ---------------------------------------------------------------------------------------------------------------------
// SparseTexture2LookupTestCase
// ---------------------------------------------------------------------------------------------------------------------

/// `SparseTexture2LookupTestCase::init`
pub(super) fn lookup_functions() -> Vec<FunctionToken> {
    vec![
        function_token(
            "sparseTextureARB",
            "<CUBE_REFZ_DEF>",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_3D,
                glw::GL_TEXTURE_RECTANGLE,
            ],
        ),
        function_token(
            "sparseTextureLodARB",
            ", <LOD>",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_3D,
            ],
        ),
        function_token(
            "sparseTextureOffsetARB",
            ", <OFFSET_TYPE><OFFSET_DIM>(0)",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_3D,
                glw::GL_TEXTURE_RECTANGLE,
            ],
        ),
        function_token(
            "sparseTexelFetchARB",
            "<LOD_DEF>",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_3D,
                glw::GL_TEXTURE_RECTANGLE,
                glw::GL_TEXTURE_2D_MULTISAMPLE,
                glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
            ],
        ),
        function_token(
            "sparseTexelFetchOffsetARB",
            "<LOD_DEF>, <OFFSET_TYPE><OFFSET_DIM>(0)",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_3D,
                glw::GL_TEXTURE_RECTANGLE,
            ],
        ),
        function_token(
            "sparseTextureLodOffsetARB",
            ", <LOD>, <OFFSET_TYPE><OFFSET_DIM>(0)",
            &[glw::GL_TEXTURE_2D, glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_3D],
        ),
        function_token(
            "sparseTextureGradARB",
            ", <NOFFSET_TYPE><OFFSET_DIM>(0), <NOFFSET_TYPE><OFFSET_DIM>(0)",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_3D,
                glw::GL_TEXTURE_RECTANGLE,
            ],
        ),
        function_token(
            "sparseTextureGradOffsetARB",
            ", <NOFFSET_TYPE><OFFSET_DIM>(0), <NOFFSET_TYPE><OFFSET_DIM>(0), <OFFSET_TYPE><OFFSET_DIM>(0)",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_3D,
                glw::GL_TEXTURE_RECTANGLE,
            ],
        ),
        function_token(
            "sparseTextureGatherARB",
            "<REFZ_DEF>",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_RECTANGLE,
            ],
        ),
        function_token(
            "sparseTextureGatherOffsetARB",
            "<REFZ_DEF>, <OFFSET_TYPE><OFFSET_DIM>(0)",
            &[glw::GL_TEXTURE_2D, glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_RECTANGLE],
        ),
        function_token(
            "sparseTextureGatherOffsetsARB",
            "<REFZ_DEF>, <OFFSET_TYPE><OFFSET_DIM>[4](<OFFSET_TYPE><OFFSET_DIM>(0),<OFFSET_TYPE><OFFSET_DIM>(0),<OFFSET_TYPE><OFFSET_DIM>(0),<OFFSET_TYPE><OFFSET_DIM>(0))",
            &[glw::GL_TEXTURE_2D, glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_RECTANGLE],
        ),
        // "sparseImageLoadARB" is built upstream but never pushed (`//mFunctions.push_back(f)`).
    ]
}

/// `SparseTexture2LookupTestCase::caseAllowed`
pub(super) fn lookup_case_allowed(target: GLenum, format: GLenum) -> bool {
    if format == glw::GL_RGB565 || format == glw::GL_RGB10_A2UI || format == glw::GL_RGB9_E5 {
        return false;
    }

    if (target == glw::GL_TEXTURE_2D_MULTISAMPLE
        || target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
        || target == glw::GL_TEXTURE_3D)
        && format == glw::GL_DEPTH_COMPONENT16
    {
        return false;
    }

    true
}

/// `SparseTexture2LookupTestCase::funcAllowed`
fn lookup_func_allowed(target: GLenum, format: GLenum, func_token: &FunctionToken) -> bool {
    if !func_token.allowed_targets.contains(&target) {
        return false;
    }

    if format == glw::GL_DEPTH_COMPONENT16 {
        let name = func_token.name;
        if name == "sparseTextureLodARB" || name == "sparseTextureLodOffsetARB" {
            if target != glw::GL_TEXTURE_2D {
                return false;
            }
        } else if name == "sparseTextureOffsetARB"
            || name == "sparseTextureGradOffsetARB"
            || name == "sparseTextureGatherOffsetARB"
            || name == "sparseTextureGatherOffsetsARB"
        {
            if target != glw::GL_TEXTURE_2D && target != glw::GL_TEXTURE_2D_ARRAY && target != glw::GL_TEXTURE_RECTANGLE
            {
                return false;
            }
        } else if name == "sparseTexelFetchARB" || name == "sparseTexelFetchOffsetARB" {
            return false;
        } else if name == "sparseTextureGradARB" {
            if target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
                return false;
            }
        } else if name == "sparseImageLoadARB" {
            return false;
        }
    }

    true
}

fn func_allowed(kind: LookupKind, target: GLenum, format: GLenum, func_token: &FunctionToken) -> bool {
    match kind {
        LookupKind::Lookup => lookup_func_allowed(target, format, func_token),
        LookupKind::ClampResidency | LookupKind::ClampColor => {
            super::sparse_texture_clamp_tests::func_allowed(target, format, func_token)
        }
    }
}

/// `SparseTexture2LookupTestCase::iterate` (after the extension check), with the virtual calls resolved through `kind`.
pub(super) fn lookup_iterate(
    context: &Context,
    target: GLenum,
    format: GLenum,
    kind: LookupKind,
    functions: &[FunctionToken],
) -> TestOutcome {
    if lookup_case_allowed(target, format) {
        for func_token in functions {
            let mut result = true;

            if !func_allowed(kind, target, format, func_token) {
                continue;
            }

            let mut c = new_commitment(context, target, format, 2);
            let gl = c.gl;

            let mut num_virt_page_sizes: GLint = 0;
            gl!(gl.get_internalformativ(
                target,
                format,
                glw::GL_NUM_VIRTUAL_PAGE_SIZES_ARB,
                1,
                &mut num_virt_page_sizes
            ));
            if num_virt_page_sizes == 0 {
                continue;
            }

            c.log.push_str(&format!(
                "Testing sparse texture lookup functions for target: {target}, format: {format} - "
            ));

            let texture = c.sparse_allocate_texture(3)?;
            if format == glw::GL_DEPTH_COMPONENT16 {
                setup_depth_mode(gl, target, texture)?;
            }

            let channel_class = c.state.format.map(|format| format.channel_class());
            if (channel_class == Some(TextureChannelClass::SignedInteger)
                || channel_class == Some(TextureChannelClass::UnsignedInteger))
                && target != glw::GL_TEXTURE_2D_MULTISAMPLE
                && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
            {
                setup_nearest_filter(gl, target, texture)?;
            }

            for level in 0..c.state.levels {
                if c.commit_texture_page(texture, level)? {
                    lookup_write_data_to_texture(context, &mut c, texture, level)?;
                    result = result && verify_lookup_texture_data(context, &mut c, texture, level, func_token, kind)?;
                }

                if !result {
                    break;
                }
            }

            texture_delete(gl, texture)?;

            if !result {
                return fail_with_log(&c.log, "Fail");
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `SparseTexture2LookupTestCase::createLookupShaderTokens`
#[expect(clippy::if_same_then_else, reason = "upstream spells out both branches")]
pub(super) fn create_lookup_shader_tokens(
    target: GLenum,
    verify_target: GLenum,
    format: GLenum,
    level: GLint,
    sample: GLint,
    func_token: &FunctionToken,
) -> TokenStringsExt {
    let func_name = func_token.name;

    let input_type = if func_name == "sparseImageLoadARB" {
        "image"
    } else {
        "sampler"
    };

    let ss = create_shader_tokens(target, verify_target, format, sample, "image", input_type);
    let mut s = TokenStringsExt {
        epsilon: ss.epsilon,
        format: ss.format,
        input_type: ss.input_type,
        output_type: ss.output_type,
        point_def: ss.point_def,
        point_type: ss.point_type,
        result_default: ss.result_default,
        result_expected: ss.result_expected,
        return_type: ss.return_type,
        sample_def: ss.sample_def,
        ..Default::default()
    };

    if input_type == "image" {
        s.format_def = format!(", {}", s.format);
    }

    if format == glw::GL_DEPTH_COMPONENT16 {
        s.ref_z_def = ", 0.5".to_string();

        if input_type == "sampler"
            && target != glw::GL_TEXTURE_3D
            && target != glw::GL_TEXTURE_2D_MULTISAMPLE
            && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
        {
            s.input_type = format!("{}Shadow", s.input_type);
        }
    }

    s.coord_type = "vec2".to_string();
    s.offset_type = "ivec".to_string();
    s.n_offset_type = "vec".to_string();
    s.offset_dim = "2".to_string();
    if target == glw::GL_TEXTURE_1D {
        s.coord_type = "float".to_string();
        s.offset_type = "int".to_string();
        s.n_offset_type = "float".to_string();
        s.offset_dim = String::new();
    } else if target == glw::GL_TEXTURE_1D_ARRAY {
        s.coord_type = "vec2".to_string();
        s.offset_type = "int".to_string();
        s.n_offset_type = "float".to_string();
        s.offset_dim = String::new();
    } else if target == glw::GL_TEXTURE_2D_ARRAY {
        s.coord_type = "vec3".to_string();
    } else if target == glw::GL_TEXTURE_3D {
        s.coord_type = "vec3".to_string();
        s.offset_dim = "3".to_string();
    } else if target == glw::GL_TEXTURE_CUBE_MAP {
        s.coord_type = "vec3".to_string();
        s.offset_dim = "3".to_string();
    } else if target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
        s.coord_type = "vec4".to_string();
        s.coord_def =
            "gl_WorkGroupID.x, gl_WorkGroupID.y, gl_WorkGroupID.z % 6, floor(gl_WorkGroupID.z / 6)".to_string();
        s.offset_dim = "3".to_string();
    } else if target == glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY {
        s.coord_type = "vec3".to_string();
    }

    if (target == glw::GL_TEXTURE_CUBE_MAP || target == glw::GL_TEXTURE_CUBE_MAP_ARRAY) && !func_name.contains("Fetch")
    {
        s.cube_map_coord_def = "    int face = point.z % 6;\n\
    if (face == 0) coord.xyz = vec3(1, coord.y * 2 - 1, -coord.x * 2 + 1);\n\
    if (face == 1) coord.xyz = vec3(-1, coord.y * 2 - 1, coord.x * 2 - 1);\n\
    if (face == 2) coord.xyz = vec3(coord.x * 2 - 1, 1, coord.y * 2 - 1);\n\
    if (face == 3) coord.xyz = vec3(coord.x * 2 - 1, -1, -coord.y * 2 + 1);\n\
    if (face == 4) coord.xyz = vec3(coord.x * 2 - 1, coord.y * 2 - 1, 1);\n\
    if (face == 5) coord.xyz = vec3(-coord.x * 2 + 1, coord.y * 2 - 1, -1);\n"
            .to_string();
    }

    if s.coord_def.is_empty() {
        s.coord_def = s.point_def.clone();
    }

    if func_name.contains("Gather") {
        if format != glw::GL_DEPTH_COMPONENT16 {
            s.component_def = ", 0".to_string();
        }
        s.result_expected = "(1, 1, 1, 1)".to_string();
    } else if format == glw::GL_DEPTH_COMPONENT16 {
        if target != glw::GL_TEXTURE_CUBE_MAP_ARRAY {
            if s.coord_type == "float" {
                s.coord_type = "vec3".to_string();
            } else if s.coord_type == "vec2" {
                s.coord_type = "vec3".to_string();
            } else if s.coord_type == "vec3" {
                s.coord_type = "vec4".to_string();
            }
            let ref_z_def = s.ref_z_def.clone();
            s.coord_def.push_str(&ref_z_def);
        } else {
            s.cube_map_array_ref_z_def = s.ref_z_def.clone();
        }

        s.component_def = ".r".to_string();
    }

    if target != glw::GL_TEXTURE_RECTANGLE
        && target != glw::GL_TEXTURE_2D_MULTISAMPLE
        && target != glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY
    {
        s.lod = level.to_string();
        s.lod_def = format!(", {level}");
    }

    if target == glw::GL_TEXTURE_RECTANGLE || func_name.contains("Fetch") || func_name.contains("ImageLoad") {
        s.point_coord = "icoord".to_string();
    } else {
        s.point_coord = "coord".to_string();
    }

    if format != glw::GL_DEPTH_COMPONENT16 || func_name.contains("Gather") {
        if s.coord_type == "float" {
            s.size_def = "<TEX_WIDTH>".to_string();
        } else if s.coord_type == "vec2" && target == glw::GL_TEXTURE_1D_ARRAY {
            s.size_def = "<TEX_WIDTH>, <TEX_DEPTH>".to_string();
        } else if s.coord_type == "vec2" {
            s.size_def = "<TEX_WIDTH>, <TEX_HEIGHT>".to_string();
        } else if s.coord_type == "vec3" {
            s.size_def = "<TEX_WIDTH>, <TEX_HEIGHT>, <TEX_DEPTH>".to_string();
        } else if s.coord_type == "vec4" {
            s.size_def = "<TEX_WIDTH>, <TEX_HEIGHT>, 6, floor(<TEX_DEPTH> / 6)".to_string();
        }
    } else if s.coord_type == "vec3" && target == glw::GL_TEXTURE_1D {
        s.size_def = "<TEX_WIDTH>, 1 , 1".to_string();
    } else if s.coord_type == "vec3" && target == glw::GL_TEXTURE_1D_ARRAY {
        s.size_def = "<TEX_WIDTH>, <TEX_DEPTH>, 1".to_string();
    } else if s.coord_type == "vec3" {
        s.size_def = "<TEX_WIDTH>, <TEX_HEIGHT>, 1".to_string();
    } else if s.coord_type == "vec4" {
        s.size_def = "<TEX_WIDTH>, <TEX_HEIGHT>, <TEX_DEPTH>, 1".to_string();
    }

    if s.coord_type != "float" {
        s.i_coord_type = format!("i{}", s.coord_type);
    } else {
        s.i_coord_type = "int".to_string();
    }

    s
}

/// The run of `replaceToken` calls both lookup shader kinds make after `<FUNCTION>`/`<ARGUMENTS>`; `icoord_type` differs (`SparseTextureClampLookupColorTestCase` passes `coordType`).
pub(super) fn substitute_lookup_tokens(
    shader: &mut String,
    func_token: &FunctionToken,
    s: &TokenStringsExt,
    icoord_type: &str,
    (width, height, depth): (GLint, GLint, GLint),
) {
    replace_token("<FUNCTION>", func_token.name, shader);
    replace_token("<ARGUMENTS>", func_token.arguments, shader);

    replace_token("<OUTPUT_TYPE>", &s.output_type, shader);
    replace_token("<INPUT_TYPE>", &s.input_type, shader);
    replace_token("<SIZE_DEF>", &s.size_def, shader);
    replace_token("<LOD>", &s.lod, shader);
    replace_token("<LOD_DEF>", &s.lod_def, shader);
    replace_token("<COORD_TYPE>", &s.coord_type, shader);
    replace_token("<ICOORD_TYPE>", icoord_type, shader);
    replace_token("<COORD_DEF>", &s.coord_def, shader);
    replace_token("<POINT_TYPE>", &s.point_type, shader);
    replace_token("<POINT_DEF>", &s.point_def, shader);
    replace_token("<RETURN_TYPE>", &s.return_type, shader);
    replace_token("<RESULT_EXPECTED>", &s.result_expected, shader);
    replace_token("<EPSILON>", &s.epsilon, shader);
    replace_token("<SAMPLE_DEF>", &s.sample_def, shader);
    replace_token("<REFZ_DEF>", &s.ref_z_def, shader);
    replace_token("<CUBE_REFZ_DEF>", &s.cube_map_array_ref_z_def, shader);
    replace_token("<POINT_COORD>", &s.point_coord, shader);
    replace_token("<COMPONENT_DEF>", &s.component_def, shader);
    replace_token("<CUBE_MAP_COORD_DEF>", &s.cube_map_coord_def, shader);
    replace_token("<OFFSET_ARRAY_DEF>", &s.offset_array_def, shader);
    replace_token("<FORMAT_DEF>", &s.format_def, shader);
    replace_token("<OFFSET_TYPE>", &s.offset_type, shader);
    replace_token("<NOFFSET_TYPE>", &s.n_offset_type, shader);
    replace_token("<OFFSET_DIM>", &s.offset_dim, shader);

    replace_token("<TEX_WIDTH>", &width.to_string(), shader);
    replace_token("<TEX_HEIGHT>", &height.to_string(), shader);
    replace_token("<TEX_DEPTH>", &depth.to_string(), shader);
}

/// `SparseTexture2LookupTestCase::writeDataToTexture`
pub(super) fn lookup_write_data_to_texture(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
) -> Result<(), TestError> {
    let target = c.target;
    let format = c.format;
    c.log.push_str(&format!("Fill Texture with shader [level: {level}] - "));

    level_check(c, level)?;

    let (width, height, mut depth) = get_texture_level_size(target, &c.state, level);

    if width > 0 && height > 0 && depth >= c.state.min_depth {
        if target == glw::GL_TEXTURE_CUBE_MAP {
            depth *= 6;
        }

        let conv_format = if format == glw::GL_DEPTH_COMPONENT16 {
            glw::GL_R16
        } else {
            format
        };

        fill_with_shader(
            context,
            c,
            texture,
            level,
            (width, height, depth),
            depth > 1,
            conv_format,
            false,
        )?;
    }

    Ok(())
}

/// `SparseTexture2LookupTestCase::setupDepthMode`
pub(super) fn setup_depth_mode(gl: &glw::Functions, target: GLenum, texture: GLuint) -> Result<(), TestError> {
    texture_bind(gl, texture, target)?;
    gl!(gl.tex_parameteri(
        target,
        glw::GL_TEXTURE_COMPARE_MODE,
        glw::GL_COMPARE_REF_TO_TEXTURE as GLint
    ));
    glu::expect_no_error(gl, "glTexParameteri")?;
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_ALWAYS as GLint));
    glu::expect_no_error(gl, "glTexParameteri")
}

/// `SparseTexture2LookupTestCase::setupNearestFilter`
fn setup_nearest_filter(gl: &glw::Functions, target: GLenum, texture: GLuint) -> Result<(), TestError> {
    texture_bind(gl, texture, target)?;
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    glu::expect_no_error(gl, "glTexParameteri")?;
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
    glu::expect_no_error(gl, "glTexParameteri")
}

fn verify_lookup_texture_data(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    func_token: &FunctionToken,
    kind: LookupKind,
) -> Result<bool, TestError> {
    match kind {
        LookupKind::Lookup => verify_lookup_data(context, c, texture, level, func_token),
        LookupKind::ClampResidency => {
            super::sparse_texture_clamp_tests::verify_lookup_residency(context, c, texture, level, func_token)
        }
        LookupKind::ClampColor => {
            super::sparse_texture_clamp_tests::verify_lookup_color(context, c, texture, level, func_token)
        }
    }
}

/// `SparseTexture2LookupTestCase::verifyLookupTextureData`
fn verify_lookup_data(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    func_token: &FunctionToken,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    let format = c.format;
    c.log.push_str(&format!(
        "Verify Lookup Texture Data [function: {}, level: {level}] - ",
        func_token.name
    ));

    level_check(c, level)?;

    let (width, height, mut depth) = get_texture_level_size(target, &c.state, level);

    let width_committed = width / 2;

    if width_committed == 0 || height == 0 || depth < c.state.min_depth {
        return Ok(true);
    }

    if target == glw::GL_TEXTURE_CUBE_MAP {
        depth *= 6;
    }

    let verify_target = verify_target_of(target);

    let verify_texture = texture_generate(gl)?;
    texture_bind(gl, verify_texture, verify_target)?;
    texture_storage(gl, verify_target, 1, glw::GL_R8, width, height, depth)?;
    glu::expect_no_error(gl, "Texture::Storage")?;

    let outcome = run_lookup_verify(
        c,
        texture,
        level,
        func_token,
        (width, height, depth),
        width_committed,
        verify_texture,
        verify_target,
    );

    texture_delete(gl, verify_texture)?;

    let _ = (context, format);
    outcome
}

/// The sample loop of `verifyLookupTextureData`.
fn run_lookup_verify(
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    func_token: &FunctionToken,
    (width, height, depth): (GLint, GLint, GLint),
    width_committed: GLint,
    verify_texture: GLuint,
    verify_target: GLenum,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    let format = c.format;

    let tex_size = (width * height * depth) as usize;

    let exp_data = vec![255u8; tex_size];
    let mut out_data = vec![0u8; tex_size];

    for sample in 0..c.state.samples {
        out_data.fill(0);

        texture_bind(gl, verify_texture, verify_target)?;
        texture_sub_image(
            gl,
            verify_target,
            0,
            0,
            0,
            0,
            width,
            height,
            depth,
            glw::GL_RED,
            glw::GL_UNSIGNED_BYTE,
            out_data.as_ptr().cast(),
        )?;
        glu::expect_no_error(gl, "Texture::SubImage")?;

        let mut shader = ST2_COMPUTE_LOOKUP_VERIFY.to_string();

        let s = create_lookup_shader_tokens(target, verify_target, format, level, sample, func_token);

        substitute_lookup_tokens(&mut shader, func_token, &s, &s.i_coord_type, (width, height, depth));

        let program = compile_compute(gl, &shader);
        if program.is_ok() {
            gl!(gl.use_program(program.program()));
            glu::expect_no_error(gl, "glUseProgram")?;

            gl!(gl.bind_image_texture(
                1,
                verify_texture,
                0,
                gl_bool(depth > 1),
                0,
                glw::GL_WRITE_ONLY,
                glw::GL_R8UI
            ));
            glu::expect_no_error(gl, "glBindImageTexture")?;
            gl!(gl.uniform_1i(1, 1));
            glu::expect_no_error(gl, "glUniform1i")?;

            if func_token.name != "sparseImageLoadARB" {
                gl!(gl.active_texture(glw::GL_TEXTURE0));
                glu::expect_no_error(gl, "glActiveTexture")?;
                gl!(gl.bind_texture(target, texture));
                glu::expect_no_error(gl, "glBindTexture")?;
                gl!(gl.uniform_1i(2, 0));
                glu::expect_no_error(gl, "glUniform1i")?;
            } else {
                gl!(gl.bind_image_texture(0, texture, level, gl_bool(depth > 1), 0, glw::GL_READ_ONLY, format));
                glu::expect_no_error(gl, "glBindImageTexture")?;
                gl!(gl.uniform_1i(2, 0));
                glu::expect_no_error(gl, "glUniform1i")?;
            }

            gl!(gl.uniform_1i(3, width_committed));
            glu::expect_no_error(gl, "glUniform1i")?;
            gl!(gl.dispatch_compute(width as GLuint, height as GLuint, depth as GLuint));
            glu::expect_no_error(gl, "glDispatchCompute")?;
            gl!(gl.memory_barrier(glw::GL_ALL_BARRIER_BITS));
            glu::expect_no_error(gl, "glMemoryBarrier")?;

            texture_bind(gl, verify_texture, verify_target)?;
            gl!(gl.get_tex_image(
                verify_target,
                0,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                out_data.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Texture::GetData")?;

            for z in 0..depth {
                for y in 0..height {
                    for x in 0..width {
                        let index = (x + y * width + z * width * height) as usize;
                        if exp_data[index] != out_data[index] {
                            log::info!(
                                "{}Error detected at {x},{y},{z} for sample {sample}: expected [{}] got [{}]",
                                c.log,
                                exp_data[index],
                                out_data[index]
                            );
                            return Ok(false);
                        }
                    }
                }
            }
        } else {
            let info_log = program.build_failure_summary().unwrap_or_default();
            c.log.push_str(&format!("Compute shader compilation failed (lookup) for target: {target}, format: {format}, shaderInfoLog: {info_log}, shaderSource: {shader} - "));

            return Ok(false);
        }
    }

    Ok(true)
}

// ---------------------------------------------------------------------------------------------------------------------
// SparseTexture2Tests
// ---------------------------------------------------------------------------------------------------------------------

enum Kind {
    ShaderExtension,
    StandardPageSizes {
        target: GLenum,
        format: GLenum,
        page: (GLint, GLint, GLint),
    },
    Allocation {
        target: Option<GLenum>,
        full_array_target: Option<GLenum>,
        format: GLenum,
    },
    Commitment {
        target: GLenum,
        format: GLenum,
    },
    UncommittedRegionsAccess {
        target: GLenum,
        format: GLenum,
    },
    Lookup {
        target: GLenum,
        format: GLenum,
        functions: Vec<FunctionToken>,
    },
}

struct SparseTexture2Case {
    name: String,
    kind: Kind,
}

impl TestCase for SparseTexture2Case {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match &self.kind {
            Kind::ShaderExtension => shader_extension(context, "GL_ARB_sparse_texture2"),
            Kind::StandardPageSizes { target, format, page } => standard_page_sizes(context, *target, *format, *page),
            Kind::Allocation {
                target,
                full_array_target,
                format,
            } => sparse_texture2_allocation(context, *target, *full_array_target, *format),
            Kind::Commitment { target, format } => sparse_texture2_commitment(context, *target, *format),
            Kind::UncommittedRegionsAccess { target, format } => uncommitted_regions_access(context, *target, *format),
            Kind::Lookup {
                target,
                format,
                functions,
            } => {
                if !context.context_info.is_extension_supported("GL_ARB_sparse_texture2") {
                    return Err(TestError::NotSupported("Not Supported".to_string()));
                }
                lookup_iterate(context, *target, *format, LookupKind::Lookup, functions)
            }
        }
    }
}

/// `SparseTextureUtils::getTextureTargetString` over the targets of this group (`texture_buffer` is the one the shared table lacks).
fn target_name(target: GLenum) -> &'static str {
    if target == glw::GL_TEXTURE_BUFFER {
        "texture_buffer"
    } else {
        texture_target_string(target)
    }
}

/// `SparseTextureUtils::getTextureFormatString` over the formats of this group.
pub(super) fn format_name(format: GLenum) -> &'static str {
    match format {
        glw::GL_RGBA32UI => "rgba32ui",
        glw::GL_DEPTH_COMPONENT16 => "depth_component16",
        _ => SPARSE_TEXTURE_COMMITMENT_FORMATS
            .iter()
            .find(|(value, _)| *value == format)
            .map(|(_, name)| *name)
            .unwrap_or("null"),
    }
}

fn add_case(group: &mut TestCaseGroup, name: String, kind: Kind) {
    group.add_child(Box::new(SparseTexture2Case { name, kind }) as Box<dyn TestCase>);
}

/// `SparseTexture2Tests::addStandardPageSizesTestCase`
fn add_standard_page_sizes_test_case(group: &mut TestCaseGroup) {
    let supported_targets = [
        glw::GL_TEXTURE_1D,
        glw::GL_TEXTURE_1D_ARRAY,
        glw::GL_TEXTURE_2D,
        glw::GL_TEXTURE_2D_ARRAY,
        glw::GL_TEXTURE_CUBE_MAP,
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        glw::GL_TEXTURE_RECTANGLE,
        glw::GL_TEXTURE_BUFFER,
        glw::GL_RENDERBUFFER,
    ];

    let mut table: Vec<(GLenum, (GLint, GLint, GLint))> = vec![
        (glw::GL_R8, (256, 256, 1)),
        (glw::GL_R8_SNORM, (256, 256, 1)),
        (glw::GL_R8I, (256, 256, 1)),
        (glw::GL_R8UI, (256, 256, 1)),
        (glw::GL_R16, (256, 128, 1)),
        (glw::GL_R16_SNORM, (256, 128, 1)),
        (glw::GL_RG8, (256, 128, 1)),
        (glw::GL_RG8_SNORM, (256, 128, 1)),
        (glw::GL_RGB565, (256, 128, 1)),
        (glw::GL_R16F, (256, 128, 1)),
        (glw::GL_R16I, (256, 128, 1)),
        (glw::GL_R16UI, (256, 128, 1)),
        (glw::GL_RG8I, (256, 128, 1)),
        (glw::GL_RG8UI, (256, 128, 1)),
        (glw::GL_RG16, (128, 128, 1)),
        (glw::GL_RG16_SNORM, (128, 128, 1)),
        (glw::GL_RGBA8, (128, 128, 1)),
        (glw::GL_RGBA8_SNORM, (128, 128, 1)),
        (glw::GL_RGB10_A2, (128, 128, 1)),
        (glw::GL_RGB10_A2UI, (128, 128, 1)),
        (glw::GL_RG16F, (128, 128, 1)),
        (glw::GL_R32F, (128, 128, 1)),
        (glw::GL_R11F_G11F_B10F, (128, 128, 1)),
        (glw::GL_RGB9_E5, (128, 128, 1)),
        (glw::GL_R32I, (128, 128, 1)),
        (glw::GL_R32UI, (128, 128, 1)),
        (glw::GL_RG16I, (128, 128, 1)),
        (glw::GL_RG16UI, (128, 128, 1)),
        (glw::GL_RGBA8I, (128, 128, 1)),
        (glw::GL_RGBA8UI, (128, 128, 1)),
        (glw::GL_RGBA16, (128, 64, 1)),
        (glw::GL_RGBA16_SNORM, (128, 64, 1)),
        (glw::GL_RGBA16F, (128, 64, 1)),
        (glw::GL_RG32F, (128, 64, 1)),
        (glw::GL_RG32I, (128, 64, 1)),
        (glw::GL_RG32UI, (128, 64, 1)),
        (glw::GL_RGBA16I, (128, 64, 1)),
        (glw::GL_RGBA16UI, (128, 64, 1)),
        (glw::GL_RGBA32F, (64, 64, 1)),
        (glw::GL_RGBA32I, (64, 64, 1)),
        (glw::GL_RGBA32UI, (64, 64, 1)),
    ];
    // upstream iterates a `std::map<GLint, PageSizeStruct>`
    table.sort_by_key(|(format, _)| *format);

    for target in supported_targets {
        for (format, page) in &table {
            if target == glw::GL_TEXTURE_BUFFER {
                // filter out invalid texture buffer formats according to ARB_texture_buffer_object
                match *format {
                    glw::GL_RGB10_A2
                    | glw::GL_RGB10_A2UI
                    | glw::GL_R11F_G11F_B10F
                    | glw::GL_RGB9_E5
                    | glw::GL_RGB565
                    | glw::GL_R8_SNORM
                    | glw::GL_RG8_SNORM
                    | glw::GL_RGBA8_SNORM
                    | glw::GL_R16_SNORM
                    | glw::GL_RG16_SNORM
                    | glw::GL_RGBA16_SNORM => continue,
                    _ => {}
                }
            }
            let name = format!(
                "StandardPageSizesTestCase_{}_{}",
                target_name(target),
                format_name(*format)
            );
            add_case(
                group,
                name,
                Kind::StandardPageSizes {
                    target,
                    format: *format,
                    page: *page,
                },
            );
        }
    }
}

/// `SparseTexture2Tests::addSparseTexture2AllocationTestCase`
fn add_sparse_texture2_allocation_test_case(group: &mut TestCaseGroup) {
    let supported_targets = [glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY];
    let full_array_targets = [glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY];

    // RGB9_E5 isn't color renderable, and thus isn't valid for multisample textures.
    let supported_internal_formats = [
        glw::GL_R8,
        glw::GL_R8_SNORM,
        glw::GL_R16,
        glw::GL_R16_SNORM,
        glw::GL_RG8,
        glw::GL_RG8_SNORM,
        glw::GL_RG16,
        glw::GL_RG16_SNORM,
        glw::GL_RGB565,
        glw::GL_RGBA8,
        glw::GL_RGBA8_SNORM,
        glw::GL_RGB10_A2,
        glw::GL_RGB10_A2UI,
        glw::GL_RGBA16,
        glw::GL_RGBA16_SNORM,
        glw::GL_R16F,
        glw::GL_RG16F,
        glw::GL_RGBA16F,
        glw::GL_R32F,
        glw::GL_RG32F,
        glw::GL_RGBA32F,
        glw::GL_R11F_G11F_B10F,
        glw::GL_R8I,
        glw::GL_R8UI,
        glw::GL_R16I,
        glw::GL_R16UI,
        glw::GL_R32I,
        glw::GL_R32UI,
        glw::GL_RG8I,
        glw::GL_RG8UI,
        glw::GL_RG16I,
        glw::GL_RG16UI,
        glw::GL_RG32I,
        glw::GL_RG32UI,
        glw::GL_RGBA8I,
        glw::GL_RGBA8UI,
        glw::GL_RGBA16I,
        glw::GL_RGBA16UI,
        glw::GL_RGBA32I,
    ];

    for format in supported_internal_formats {
        for target in supported_targets {
            let name = format!(
                "SparseTexture2Allocation_{}_{}",
                target_name(target),
                format_name(format)
            );
            add_case(
                group,
                name,
                Kind::Allocation {
                    target: Some(target),
                    full_array_target: None,
                    format,
                },
            );
        }
        for target in full_array_targets {
            let name = format!(
                "SparseTexture2Allocation_fullArray_{}_{}",
                target_name(target),
                format_name(format)
            );
            add_case(
                group,
                name,
                Kind::Allocation {
                    target: None,
                    full_array_target: Some(target),
                    format,
                },
            );
        }
    }
}

/// `SparseTexture2Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sparse_texture2_tests");

    let additional_targets = [glw::GL_TEXTURE_2D_MULTISAMPLE, glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY];
    let commitment_formats = || SPARSE_TEXTURE_COMMITMENT_FORMATS.iter().map(|(format, _)| *format);

    add_case(&mut group, "ShaderExtension".to_string(), Kind::ShaderExtension);

    add_standard_page_sizes_test_case(&mut group);
    add_sparse_texture2_allocation_test_case(&mut group);

    // addSparseTexture2CommitmentTestCase
    for format in commitment_formats() {
        for target in additional_targets {
            let name = format!(
                "SparseTexture2Commitment_{}_{}",
                target_name(target),
                format_name(format)
            );
            add_case(&mut group, name, Kind::Commitment { target, format });
        }
    }

    // addUncommittedRegionsAccessTestCase
    for format in commitment_formats() {
        for target in SPARSE_TEXTURE_COMMITMENT_TARGETS.into_iter().chain(additional_targets) {
            let name = format!(
                "UncommittedRegionsAccess_{}_{}",
                target_name(target),
                format_name(format)
            );
            add_case(&mut group, name, Kind::UncommittedRegionsAccess { target, format });
        }
    }

    // addSparseTexture2LookupTestCase
    let additional_formats = [glw::GL_DEPTH_COMPONENT16];
    for format in commitment_formats().chain(additional_formats) {
        for target in SPARSE_TEXTURE_COMMITMENT_TARGETS.into_iter().chain(additional_targets) {
            let name = format!("SparseTexture2Lookup_{}_{}", target_name(target), format_name(format));
            add_case(
                &mut group,
                name,
                Kind::Lookup {
                    target,
                    format,
                    functions: lookup_functions(),
                },
            );
        }
    }

    group
}
