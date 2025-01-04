// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cSparseTextureClampTests.{hpp,cpp}
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `SparseTextureClampLookupResidencyTestCase` and `SparseTextureClampLookupColorTestCase` derive from `SparseTexture2LookupTestCase` upstream; here they are the `LookupKind`s of `sparse_texture2_tests.rs`, which calls the overrides below. `ShaderExtensionTestCase` is shared with `sparse_texture2_tests.rs`. The `std::stringstream mLog` is a `String` that is logged when the case fails.
//
// Written without compiling.

#![allow(clippy::too_many_arguments)]

use super::sparse_texture_tests::{
    Commitment, SPARSE_TEXTURE_COMMITMENT_FORMATS, SPARSE_TEXTURE_COMMITMENT_TARGETS, fail_with_log,
    get_texture_level_size, texture_bind, texture_delete, texture_generate, texture_storage, texture_sub_image,
    texture_target_string,
};
use super::sparse_texture2_tests::{
    FunctionToken, LookupKind, create_lookup_shader_tokens, fill_with_shader, format_name, function_token,
    lookup_case_allowed, lookup_iterate, new_commitment, replace_token, setup_depth_mode, shader_extension,
    substitute_lookup_tokens,
};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals or buffers of the right size.
        unsafe { $call }
    };
}

const STC_VERTEX_COMMON: &str = "#version 450\n\
\n\
in vec3 vertex;\n\
in <COORD_TYPE> inCoord;\n\
out <COORD_TYPE> texCoord;\n\
\n\
void main()\n\
{\n\
    texCoord = inCoord;\n\
    gl_Position = vec4(vertex, 1);\n\
}\n";

const STC_FRAGMENT_LOOKUP_RESIDENCY: &str = "#version 450 core\n\
\n\
#extension GL_ARB_sparse_texture2 : enable\n\
#extension GL_ARB_sparse_texture_clamp : enable\n\
\n\
in <COORD_TYPE> texCoord;\n\
out vec4 fragColor;\n\
\n\
layout (location = 1<FORMAT_DEF>) uniform <INPUT_TYPE> uni_in;\n\
layout (location = 2) uniform int widthCommitted;\n\
\n\
void main()\n\
{\n\
    <COORD_TYPE> coord = texCoord;\n\
    <ICOORD_TYPE> texSize = <ICOORD_TYPE>(<SIZE_DEF>);\n\
    <POINT_TYPE> point = <POINT_TYPE>(coord * texSize);\n\
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
\n\
    fragColor = vec4(1);\n\
\n\
    if (point.x > corner1.x && point.y > corner1.y &&\n\
        point.x < corner2.x && point.y < corner2.y &&\n\
        point.x < widthCommitted - 1)\n\
    {\n\
        if (!sparseTexelsResidentARB(code) ||\n\
            any(greaterThan(retValue, expValue + epsilon)) ||\n\
            any(lessThan(retValue, expValue - epsilon)))\n\
        {\n\
            fragColor = vec4(0);\n\
        }\n\
    }\n\
\n\
    if (point.x > corner1.x && point.y > corner1.y &&\n\
        point.x < corner2.x && point.y < corner2.y &&\n\
        point.x >= widthCommitted + 1)\n\
    {\n\
        if (sparseTexelsResidentARB(code))\n\
        {\n\
            fragColor = vec4(0);\n\
        }\n\
    }\n\
}\n";

const STC_FRAGMENT_LOOKUP_COLOR: &str = "#version 450 core\n\
\n\
#extension GL_ARB_sparse_texture2 : enable\n\
#extension GL_ARB_sparse_texture_clamp : enable\n\
\n\
in <COORD_TYPE> texCoord;\n\
out vec4 fragColor;\n\
\n\
layout (location = 1<FORMAT_DEF>) uniform <INPUT_TYPE> uni_in;\n\
\n\
void main()\n\
{\n\
    <COORD_TYPE> coord = texCoord;\n\
    <ICOORD_TYPE> texSize = <ICOORD_TYPE>(<SIZE_DEF>);\n\
    <POINT_TYPE> point = <POINT_TYPE>(coord * texSize);\n\
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
<FUNCTION_DEF>\n\
\n\
    fragColor = vec4(1);\n\
\n\
    if (any(greaterThan(retValue, expValue + epsilon)) ||\n\
        any(lessThan(retValue, expValue - epsilon)))\n\
    {\n\
        fragColor = vec4(0);\n\
    }\n\
}\n";

fn level_check(c: &Commitment<'_>, level: GLint) -> Result<(), TestError> {
    if level > c.state.levels - 1 {
        return Err(TestError::Fail("Invalid level".to_string()));
    }
    Ok(())
}

/// `SparseTextureClampLookupResidencyTestCase::init`
fn residency_functions() -> Vec<FunctionToken> {
    vec![
        function_token(
            "sparseTextureClampARB",
            "<CUBE_REFZ_DEF>, <LOD>",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_3D,
            ],
        ),
        function_token(
            "sparseTextureOffsetClampARB",
            ", <OFFSET_TYPE><OFFSET_DIM>(0), <LOD>",
            &[glw::GL_TEXTURE_2D, glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_3D],
        ),
        function_token(
            "sparseTextureGradClampARB",
            ", <NOFFSET_TYPE><OFFSET_DIM>(0), <NOFFSET_TYPE><OFFSET_DIM>(0), <LOD>",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_3D,
            ],
        ),
        function_token(
            "sparseTextureGradOffsetClampARB",
            ", <NOFFSET_TYPE><OFFSET_DIM>(0), <NOFFSET_TYPE><OFFSET_DIM>(0), <OFFSET_TYPE><OFFSET_DIM>(0), <LOD>",
            &[glw::GL_TEXTURE_2D, glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_3D],
        ),
    ]
}

/// `SparseTextureClampLookupColorTestCase::init`
fn color_functions() -> Vec<FunctionToken> {
    let all_with_1d = [
        glw::GL_TEXTURE_1D,
        glw::GL_TEXTURE_1D_ARRAY,
        glw::GL_TEXTURE_2D,
        glw::GL_TEXTURE_2D_ARRAY,
        glw::GL_TEXTURE_CUBE_MAP,
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        glw::GL_TEXTURE_3D,
    ];
    let no_cube_with_1d = [
        glw::GL_TEXTURE_1D,
        glw::GL_TEXTURE_1D_ARRAY,
        glw::GL_TEXTURE_2D,
        glw::GL_TEXTURE_2D_ARRAY,
        glw::GL_TEXTURE_3D,
    ];
    let offset_args = ", <OFFSET_TYPE><OFFSET_DIM>(0), <LOD>";
    let grad_args = ", <NOFFSET_TYPE><OFFSET_DIM>(0), <NOFFSET_TYPE><OFFSET_DIM>(0), <LOD>";
    let grad_offset_args =
        ", <NOFFSET_TYPE><OFFSET_DIM>(0), <NOFFSET_TYPE><OFFSET_DIM>(0), <OFFSET_TYPE><OFFSET_DIM>(0), <LOD>";

    vec![
        function_token(
            "sparseTextureClampARB",
            "<CUBE_REFZ_DEF>, <LOD>",
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_3D,
            ],
        ),
        function_token("textureClampARB", "<CUBE_REFZ_DEF>, <LOD>", &all_with_1d),
        function_token(
            "sparseTextureOffsetClampARB",
            offset_args,
            &[glw::GL_TEXTURE_2D, glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_3D],
        ),
        function_token("textureOffsetClampARB", offset_args, &no_cube_with_1d),
        function_token(
            "sparseTextureGradClampARB",
            grad_args,
            &[
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_CUBE_MAP,
                glw::GL_TEXTURE_CUBE_MAP_ARRAY,
                glw::GL_TEXTURE_3D,
            ],
        ),
        function_token("textureGradClampARB", grad_args, &all_with_1d),
        function_token(
            "sparseTextureGradOffsetClampARB",
            grad_offset_args,
            &[glw::GL_TEXTURE_2D, glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_3D],
        ),
        function_token("textureGradOffsetClampARB", grad_offset_args, &no_cube_with_1d),
    ]
}

/// `SparseTextureClampLookupResidencyTestCase::funcAllowed`
pub(super) fn func_allowed(target: GLenum, format: GLenum, func_token: &FunctionToken) -> bool {
    if !func_token.allowed_targets.contains(&target) {
        return false;
    }

    if format == glw::GL_DEPTH_COMPONENT16
        && target == glw::GL_TEXTURE_CUBE_MAP_ARRAY
        && (func_token.name == "sparseTextureGradClampARB" || func_token.name == "textureGradClampARB")
    {
        return false;
    }

    true
}

/// `SparseTextureClampLookupColorTestCase::generateExpectedResult`
pub(super) fn generate_expected_result(return_type: &str, level: GLint, format: GLenum) -> String {
    if format == glw::GL_DEPTH_COMPONENT16 {
        "(1, 0, 0, 0)".to_string()
    } else if return_type == "vec4" {
        format!("({}, 0, 0, 1)", 0.5f32 + level as f32 / 10.0)
    } else {
        format!("({}, 0, 0, 1)", level * 10)
    }
}

/// `SparseTextureClampLookupColorTestCase::generateFunctionDef`
fn generate_function_def(func_name: &str) -> &'static str {
    if func_name.contains("sparse") {
        "    <FUNCTION>(uni_in,\n\
               <POINT_COORD><SAMPLE_DEF><ARGUMENTS>,\n\
               retValue<COMPONENT_DEF>);\n"
    } else {
        "    retValue<COMPONENT_DEF> = <FUNCTION>(uni_in,\n\
                                         <POINT_COORD><SAMPLE_DEF><ARGUMENTS>);\n"
    }
}

/// `SparseTextureClampLookupResidencyTestCase::draw`
fn draw(context: &Context, target: GLenum, layer: GLint, program: &ShaderProgram<'_>) -> Result<(), TestError> {
    let tex_coord_1d: [f32; 4] = [0.0, 1.0, 0.0, 1.0];

    let tex_coord_2d: [f32; 8] = [0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0];

    let tex_coord_3d: [f32; 12] = [0.0, 0.0, 0.5, 1.0, 0.0, 0.5, 0.0, 1.0, 0.5, 1.0, 1.0, 0.5];

    let tex_coord_cube_map: [[f32; 12]; 6] = [
        [0.0, 0.0, 0.00, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 1.0, 0.0],
        [0.0, 0.0, 0.17, 1.0, 0.0, 0.17, 0.0, 1.0, 0.17, 1.0, 1.0, 0.17],
        [0.0, 0.0, 0.33, 1.0, 0.0, 0.33, 0.0, 1.0, 0.33, 1.0, 1.0, 0.33],
        [0.0, 0.0, 0.5, 1.0, 0.0, 0.5, 0.0, 1.0, 0.5, 1.0, 1.0, 0.5],
        [0.0, 0.0, 0.67, 1.0, 0.0, 0.67, 0.0, 1.0, 0.67, 1.0, 1.0, 0.67],
        [0.0, 0.0, 0.83, 1.0, 0.0, 0.83, 0.0, 1.0, 0.83, 1.0, 1.0, 0.83],
    ];

    // The fragment shader uses (z * 6) % 6 to calculate a cube face index.
    let cube_map_array_z_coord = layer as f32 / 6.0 + 0.01;
    // The fragment shader does not modify w for layer selection.
    let cube_map_array_w_coord = (layer / 6) as f32;
    let tex_coord_cube_map_array: [f32; 16] = [
        0.0,
        0.0,
        cube_map_array_z_coord,
        cube_map_array_w_coord,
        1.0,
        0.0,
        cube_map_array_z_coord,
        cube_map_array_w_coord,
        0.0,
        1.0,
        cube_map_array_z_coord,
        cube_map_array_w_coord,
        1.0,
        1.0,
        cube_map_array_z_coord,
        cube_map_array_w_coord,
    ];

    let vertices: [f32; 12] = [-1.0, -1.0, 0.0, 1.0, -1.0, 0.0, -1.0, 1.0, 0.0, 1.0, 1.0, 0.0];

    let indices: [u16; 6] = [0, 1, 2, 1, 2, 3];

    let float_coord = if target == glw::GL_TEXTURE_1D || target == glw::GL_TEXTURE_1D_ARRAY {
        va::float("inCoord", 1, 4, 0, &tex_coord_1d)
    } else if target == glw::GL_TEXTURE_3D {
        va::float("inCoord", 3, 4, 0, &tex_coord_3d)
    } else if target == glw::GL_TEXTURE_CUBE_MAP {
        va::float("inCoord", 3, 4, 0, &tex_coord_cube_map[layer as usize])
    } else if target == glw::GL_TEXTURE_CUBE_MAP_ARRAY {
        va::float("inCoord", 4, 4, 0, &tex_coord_cube_map_array)
    } else {
        va::float("inCoord", 2, 4, 0, &tex_coord_2d)
    };

    let vertex_arrays = [va::float("vertex", 3, 4, 0, &vertices), float_coord];

    glu::draw(
        &context.render_context,
        program.program(),
        &vertex_arrays,
        &pr::triangle_strip(&indices),
    )
}

/// The framebuffer-with-verify-texture part both `verifyLookup*TextureData` set up before the sample loop; returns `(verifyTexture, fbo)`.
fn prepare_verify_framebuffer(
    gl: &glw::Functions,
    width: GLint,
    height: GLint,
    depth: GLint,
) -> Result<(GLuint, GLuint), TestError> {
    let verify_target = glw::GL_TEXTURE_2D;
    let verify_texture = texture_generate(gl)?;
    texture_bind(gl, verify_texture, verify_target)?;
    texture_storage(gl, verify_target, 1, glw::GL_R8, width, height, depth)?;
    glu::expect_no_error(gl, "Texture::Storage")?;

    let mut fbo: GLuint = 0;
    gl!(gl.gen_framebuffers(1, &mut fbo));
    glu::expect_no_error(gl, "glGenFramebuffers")?;
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
    glu::expect_no_error(gl, "glBindFramebuffer")?;
    gl!(gl.framebuffer_texture_2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_COLOR_ATTACHMENT0,
        verify_target,
        verify_texture,
        0
    ));
    glu::expect_no_error(gl, "glFramebufferTexture2D")?;

    gl!(gl.viewport(0, 0, width, height));

    Ok((verify_texture, fbo))
}

/// The `out:` label of both verify functions.
fn release_verify_framebuffer(gl: &glw::Functions, verify_texture: GLuint, fbo: GLuint) -> Result<(), TestError> {
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
    glu::expect_no_error(gl, "glBindFramebuffer")?;

    gl!(gl.delete_framebuffers(1, &fbo));
    glu::expect_no_error(gl, "glDeleteFramebuffers")?;

    texture_delete(gl, verify_texture)
}

/// One `z` iteration of the draw loop: clears the verify texture, draws the lookup and reads the result back into `out_data`.
fn draw_lookup_layer(
    context: &Context,
    c: &Commitment<'_>,
    program: &ShaderProgram<'_>,
    texture: GLuint,
    verify_texture: GLuint,
    out_data: &mut [u8],
    width: GLint,
    height: GLint,
    z: GLint,
    width_committed: Option<GLint>,
) -> Result<(), TestError> {
    let gl = c.gl;
    let target = c.target;
    let verify_target = glw::GL_TEXTURE_2D;

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
        0,
        glw::GL_RED,
        glw::GL_UNSIGNED_BYTE,
        out_data.as_ptr().cast(),
    )?;
    glu::expect_no_error(gl, "Texture::SubImage")?;

    gl!(gl.use_program(program.program()));
    glu::expect_no_error(gl, "glUseProgram")?;

    gl!(gl.active_texture(glw::GL_TEXTURE0));
    glu::expect_no_error(gl, "glActiveTexture")?;
    gl!(gl.uniform_1i(1, 0));
    glu::expect_no_error(gl, "glUniform1i")?;

    if let Some(width_committed) = width_committed {
        gl!(gl.uniform_1i(2, width_committed));
        glu::expect_no_error(gl, "glUniform1i")?;
    }

    gl!(gl.bind_texture(target, texture));
    glu::expect_no_error(gl, "glBindTexture")?;
    gl!(gl.tex_parameteri(
        target,
        glw::GL_TEXTURE_MIN_FILTER,
        glw::GL_NEAREST_MIPMAP_NEAREST as GLint
    ));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));

    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT));
    draw(context, target, z, program)?;

    texture_bind(gl, verify_texture, verify_target)?;
    gl!(gl.get_tex_image(
        verify_target,
        0,
        glw::GL_RED,
        glw::GL_UNSIGNED_BYTE,
        out_data.as_mut_ptr().cast()
    ));
    glu::expect_no_error(gl, "Texture::GetData")
}

/// `SparseTextureClampLookupResidencyTestCase::verifyLookupTextureData`
pub(super) fn verify_lookup_residency(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    func_token: &FunctionToken,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    c.log.push_str(&format!(
        "Verify Lookup Residency Texture Data [function: {}, level: {level}] - ",
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

    let (verify_texture, fbo) = prepare_verify_framebuffer(gl, width, height, depth)?;

    let outcome = run_residency_verify(
        context,
        c,
        texture,
        level,
        func_token,
        (width, height, depth),
        width_committed,
        verify_texture,
    );

    release_verify_framebuffer(gl, verify_texture, fbo)?;

    outcome
}

/// The sample loop of `SparseTextureClampLookupResidencyTestCase::verifyLookupTextureData`.
fn run_residency_verify(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    func_token: &FunctionToken,
    (width, height, depth): (GLint, GLint, GLint),
    width_committed: GLint,
    verify_texture: GLuint,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    let format = c.format;
    let verify_target = glw::GL_TEXTURE_2D;

    let tex_size = (width * height) as usize;
    let exp_data = vec![255u8; tex_size];
    let mut out_data = vec![0u8; tex_size];

    for sample in 0..c.state.samples {
        let mut vertex = STC_VERTEX_COMMON.to_string();
        let mut fragment = STC_FRAGMENT_LOOKUP_RESIDENCY.to_string();

        let s = create_lookup_shader_tokens(target, verify_target, format, level, sample, func_token);

        replace_token("<COORD_TYPE>", &s.coord_type, &mut vertex);

        substitute_lookup_tokens(&mut fragment, func_token, &s, &s.i_coord_type, (width, height, depth));

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex, fragment.clone()));
        if program.is_ok() {
            for z in 0..depth {
                draw_lookup_layer(
                    context,
                    c,
                    &program,
                    texture,
                    verify_texture,
                    &mut out_data,
                    width,
                    height,
                    z,
                    Some(width_committed),
                )?;

                for y in 0..height {
                    for x in 0..width {
                        let index = (x + y * width) as usize;
                        if exp_data[index] != out_data[index] {
                            log::info!(
                                "{}Error detected at {x},{y},{z}: expected [{}] got [{}]",
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
            c.log.push_str(&format!("Shader compilation failed (lookup residency) for target: {target}, format: {format}, infoLog: {info_log}, fragmentSource: {fragment} - "));

            return Ok(false);
        }
    }

    Ok(true)
}

/// `SparseTextureClampLookupColorTestCase::verifyLookupTextureData`
pub(super) fn verify_lookup_color(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    func_token: &FunctionToken,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    c.log.push_str(&format!(
        "Verify Lookup Color Texture Data [function: {}, level: {level}] - ",
        func_token.name
    ));

    level_check(c, level)?;

    let (width, height, mut depth) = get_texture_level_size(target, &c.state, level);

    if width == 0 || height == 0 || depth < c.state.min_depth {
        return Ok(true);
    }

    if target == glw::GL_TEXTURE_CUBE_MAP {
        depth *= 6;
    }

    let (verify_texture, fbo) = prepare_verify_framebuffer(gl, width, height, depth)?;

    let outcome = run_color_verify(
        context,
        c,
        texture,
        level,
        func_token,
        (width, height, depth),
        verify_texture,
    );

    release_verify_framebuffer(gl, verify_texture, fbo)?;

    outcome
}

/// The sample loop of `SparseTextureClampLookupColorTestCase::verifyLookupTextureData`.
fn run_color_verify(
    context: &Context,
    c: &mut Commitment<'_>,
    texture: GLuint,
    level: GLint,
    func_token: &FunctionToken,
    (width, height, depth): (GLint, GLint, GLint),
    verify_texture: GLuint,
) -> Result<bool, TestError> {
    let gl = c.gl;
    let target = c.target;
    let format = c.format;
    let verify_target = glw::GL_TEXTURE_2D;
    let mut result = true;

    let tex_size = (width * height) as usize;
    let exp_data = vec![255u8; tex_size];
    let mut out_data = vec![0u8; tex_size];

    for sample in 0..c.state.samples {
        let mut vertex = STC_VERTEX_COMMON.to_string();
        let mut fragment = STC_FRAGMENT_LOOKUP_COLOR.to_string();

        let function_def = generate_function_def(func_token.name);

        let mut s = create_lookup_shader_tokens(target, verify_target, format, level, sample, func_token);

        s.result_expected = generate_expected_result(&s.return_type, level, format);

        replace_token("<COORD_TYPE>", &s.coord_type, &mut vertex);

        replace_token("<FUNCTION_DEF>", function_def, &mut fragment);
        substitute_lookup_tokens(&mut fragment, func_token, &s, &s.coord_type, (width, height, depth));

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex, fragment.clone()));
        if program.is_ok() {
            for z in 0..depth {
                draw_lookup_layer(
                    context,
                    c,
                    &program,
                    texture,
                    verify_texture,
                    &mut out_data,
                    width,
                    height,
                    z,
                    None,
                )?;

                for y in 0..height {
                    for x in 0..width {
                        let index = (x + y * width) as usize;
                        if exp_data[index] != out_data[index] {
                            result = false;
                        }
                    }
                }
            }
        } else {
            let info_log = program.build_failure_summary().unwrap_or_default();
            c.log.push_str(&format!("Shader compilation failed (lookup color) for target: {target}, format: {format}, infoLog: {info_log}, fragmentSource: {fragment} - "));

            result = false;
        }
    }

    Ok(result)
}

// ---------------------------------------------------------------------------------------------------------------------
// SparseTextureClampLookupColorTestCase overrides
// ---------------------------------------------------------------------------------------------------------------------

/// `SparseTextureClampLookupColorTestCase::writeDataToTexture`
fn color_write_data_to_texture(
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
            true,
            conv_format,
            true,
        )?;
    }

    Ok(())
}

/// `SparseTextureClampLookupColorTestCase::isInPageSizesRange`
fn color_is_in_page_sizes_range(c: &Commitment<'_>, level: GLint) -> bool {
    let (width, height, mut depth) = get_texture_level_size(c.target, &c.state, level);

    if c.target == glw::GL_TEXTURE_CUBE_MAP {
        depth *= 6;
    }

    width >= c.state.page_size_x
        && height >= c.state.page_size_y
        && (c.state.min_depth == 0 || depth >= c.state.page_size_z)
}

/// `SparseTextureClampLookupColorTestCase::isPageSizesMultiplication`
fn color_is_page_sizes_multiplication(c: &Commitment<'_>, level: GLint) -> bool {
    let (width, height, mut depth) = get_texture_level_size(c.target, &c.state, level);

    if c.target == glw::GL_TEXTURE_CUBE_MAP {
        depth *= 6;
    }

    (width % c.state.page_size_x) == 0 && (height % c.state.page_size_y) == 0 && (depth % c.state.page_size_z) == 0
}

/// `SparseTextureClampLookupColorTestCase::commitTexturePage`
fn color_commit_texture_page(c: &mut Commitment<'_>, texture: GLuint, level: GLint) -> Result<bool, TestError> {
    let gl = c.gl;
    c.log.push_str(&format!("Commit Region [level: {level}] - "));

    level_check(c, level)?;

    if !color_is_in_page_sizes_range(c, level) || !color_is_page_sizes_multiplication(c, level) {
        c.log.push_str(&format!("Skip commitment [level: {level}] - "));
        return Ok(false);
    }

    let (width, height, mut depth) = get_texture_level_size(c.target, &c.state, level);

    if c.target == glw::GL_TEXTURE_CUBE_MAP {
        depth *= 6;
    }

    texture_bind(gl, texture, c.target)?;
    c.tex_page_commitment(texture, level, 0, 0, 0, width, height, depth, true)?;
    glu::expect_no_error(gl, "texPageCommitment")?;

    Ok(true)
}

// ---------------------------------------------------------------------------------------------------------------------
// SparseTextureClampTests
// ---------------------------------------------------------------------------------------------------------------------

/// `SparseTextureClampLookupResidencyTestCase::iterate`
fn lookup_residency(context: &Context, target: GLenum, format: GLenum, functions: &[FunctionToken]) -> TestOutcome {
    if !context
        .context_info
        .is_extension_supported("GL_ARB_sparse_texture_clamp")
    {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }

    if !context.context_info.is_extension_supported("GL_ARB_sparse_texture2") {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }

    lookup_iterate(context, target, format, LookupKind::ClampResidency, functions)
}

/// `SparseTextureClampLookupColorTestCase::iterate`
fn lookup_color(context: &Context, target: GLenum, format: GLenum, functions: &[FunctionToken]) -> TestOutcome {
    if !context
        .context_info
        .is_extension_supported("GL_ARB_sparse_texture_clamp")
    {
        return Err(TestError::NotSupported("Not Supported".to_string()));
    }

    if lookup_case_allowed(target, format) {
        for func_token in functions {
            if !func_allowed(target, format, func_token) {
                continue;
            }

            let is_sparse = func_token.name.contains("sparse");

            let mut c = new_commitment(context, target, format, 4);
            let gl = c.gl;
            c.log.push_str(&format!(
                "Testing sparse texture lookup color functions for target: {target}, format: {format} - "
            ));

            let texture = if is_sparse {
                c.sparse_allocate_texture(3)?
            } else {
                c.allocate_texture(3)?
            };

            if format == glw::GL_DEPTH_COMPONENT16 {
                setup_depth_mode(gl, target, texture)?;
            }

            let mut max_levels = 0;
            for level in 0..c.state.levels {
                if !is_sparse || color_commit_texture_page(&mut c, texture, level)? {
                    color_write_data_to_texture(context, &mut c, texture, level)?;
                    max_levels = level;
                }
            }

            let mut result = true;
            for level in 0..=max_levels {
                result = result && verify_lookup_color(context, &mut c, texture, level, func_token)?;

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

enum Kind {
    ShaderExtension,
    LookupResidency { target: GLenum, format: GLenum },
    LookupColor { target: GLenum, format: GLenum },
}

struct SparseTextureClampCase {
    name: String,
    kind: Kind,
}

impl TestCase for SparseTextureClampCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        match &self.kind {
            Kind::ShaderExtension => shader_extension(context, "GL_ARB_sparse_texture_clamp"),
            Kind::LookupResidency { target, format } => {
                lookup_residency(context, *target, *format, &residency_functions())
            }
            Kind::LookupColor { target, format } => lookup_color(context, *target, *format, &color_functions()),
        }
    }
}

fn add_case(group: &mut TestCaseGroup, name: String, kind: Kind) {
    group.add_child(Box::new(SparseTextureClampCase { name, kind }) as Box<dyn TestCase>);
}

/// `SparseTextureClampTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sparse_texture_clamp_tests");

    let commitment_formats = || SPARSE_TEXTURE_COMMITMENT_FORMATS.iter().map(|(format, _)| *format);
    let additional_formats = [glw::GL_DEPTH_COMPONENT16];
    let additional_targets = [glw::GL_TEXTURE_1D, glw::GL_TEXTURE_1D_ARRAY];

    add_case(&mut group, "ShaderExtension".to_string(), Kind::ShaderExtension);

    // addSparseTextureClampLookupResidencyTestCase
    for format in commitment_formats().chain(additional_formats) {
        for target in SPARSE_TEXTURE_COMMITMENT_TARGETS {
            let name = format!(
                "SparseTextureClampLookupResidency_{}_{}",
                texture_target_string(target),
                format_name(format)
            );
            add_case(&mut group, name, Kind::LookupResidency { target, format });
        }
    }

    // addSparseTextureClampLookupColorTestCase
    for format in commitment_formats().chain(additional_formats) {
        for target in SPARSE_TEXTURE_COMMITMENT_TARGETS.into_iter().chain(additional_targets) {
            let name = format!(
                "SparseTextureClampLookupColor_{}_{}",
                texture_target_string(target),
                format_name(format)
            );
            add_case(&mut group, name, Kind::LookupColor { target, format });
        }
    }

    group
}
