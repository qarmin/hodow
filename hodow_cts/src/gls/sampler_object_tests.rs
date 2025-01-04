// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsSamplerObjectTest.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Needs no rasterised reference image
// and no captured expected values: every case renders the same textured quad(s) twice -
// once with the sampling state set directly on the texture object(s), once with a real
// sampler object bound holding the state instead - and checks the two renders are
// pixel-identical (threshold 0). Whichever GPU/driver runs this is its own oracle, same
// reasoning as `vertex_array_object_tests`'s own header.
//
// Texture content is a deterministic component gradient
// (`fill_with_component_gradients2`). Upstream's own call site uses the unsuffixed
// `fillWithComponentGradients`, which selects the "old" gradient style this port has no
// separate enum variant for - but the exact pixel pattern is irrelevant here, since both
// compared renders sample the very same texture data.
//
// `#version 300 es` is hardcoded rather than probed for a desktop-GL fallback: this
// port's GLES half never runs desktop GL (see CLAUDE.md), so upstream's
// `GLSL_VERSION_330` branch has nothing to port.
//
// `TextureSamplerTest` compares one bound texture unit; `MultiTextureSamplerTest`
// compares two, bound to the same sampler object at once (`glBindSampler(0, ...)` and
// `glBindSampler(1, ...)` both naming the one sampler upstream creates) - the two share
// almost all of their machinery, factored here into the `render`/`render_references`/
// `render_results` free functions parameterized over how many texture units a case uses.

use crate::glu::draw_util::{PrimitiveType, pr, va};
use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, draw, read_pixels};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::pixel::{TextureLevel, fill_with_component_gradients2};
use crate::tcu::{
    ChannelOrder, ChannelType, RGBA, Random, Surface, TestError, TestOutcome, TestStatus, TextureFormat, de_string_hash,
};

const VIEWPORT_WIDTH: i32 = 128;
const VIEWPORT_HEIGHT: i32 = 128;
const TEXTURE2D_SIZE: u32 = 32;
const TEXTURE3D_SIZE: u32 = 32;
const CUBEMAP_SIZE: u32 = 32;

#[derive(Clone, Copy)]
pub struct SamplingState {
    pub min_filter: GLenum,
    pub mag_filter: GLenum,
    pub wrap_s: GLenum,
    pub wrap_t: GLenum,
    pub wrap_r: GLenum,
    pub min_lod: f32,
    pub max_lod: f32,
}

/// `TextureSamplerTest::TestSpec`
pub struct TestSpec {
    pub name: &'static str,
    pub target: GLenum,
    pub texture_state: SamplingState,
    pub sampler_state: SamplingState,
}

/// `MultiTextureSamplerTest::TestSpec`
pub struct MultiTestSpec {
    pub name: &'static str,
    pub target: GLenum,
    pub texture_state1: SamplingState,
    pub texture_state2: SamplingState,
    pub sampler_state: SamplingState,
}

fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let cname = std::ffi::CString::new(name).expect("no interior NUL");
    // SAFETY: a NUL-terminated name and a program the caller built.
    unsafe { gl.get_uniform_location(program, cname.as_ptr()) }
}

/// `TextureSamplerTest::selectVertexShader` / `MultiTextureSamplerTest::selectVertexShader`
/// - identical between the single- and multi-texture variants.
fn vertex_shader_source(target: GLenum) -> String {
    match target {
        glw::GL_TEXTURE_2D => "#version 300 es\n\
             in highp vec2 a_position;\n\
             uniform highp float u_posScale;\n\
             out mediump vec2 v_texCoord;\n\
             void main (void)\n\
             {\n\
             \tv_texCoord = a_position;\n\
             \tgl_Position = vec4(u_posScale * a_position, 0.0, 1.0);\n\
             }"
        .to_string(),
        glw::GL_TEXTURE_3D => "#version 300 es\n\
             in highp vec3 a_position;\n\
             uniform highp float u_posScale;\n\
             out mediump vec3 v_texCoord;\n\
             void main (void)\n\
             {\n\
             \tv_texCoord = a_position;\n\
             \tgl_Position = vec4(u_posScale * a_position.xy, 0.0, 1.0);\n\
             }"
        .to_string(),
        glw::GL_TEXTURE_CUBE_MAP => "#version 300 es\n\
             in highp vec4 a_position;\n\
             uniform highp float u_posScale;\n\
             out mediump vec2 v_texCoord;\n\
             void main (void)\n\
             {\n\
             \tv_texCoord = a_position.zw;\n\
             \tgl_Position = vec4(u_posScale * a_position.xy, 0.0, 1.0);\n\
             }"
        .to_string(),
        _ => unreachable!("TestSpec::target is one of the three GL texture targets above"),
    }
}

/// `TextureSamplerTest::selectFragmentShader`
fn fragment_shader_source_single(target: GLenum) -> String {
    match target {
        glw::GL_TEXTURE_2D => "#version 300 es\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform lowp sampler2D u_sampler;\n\
             in mediump vec2 v_texCoord;\n\
             void main (void)\n\
             {\n\
             \to_color = texture(u_sampler, v_texCoord);\n\
             }"
        .to_string(),
        glw::GL_TEXTURE_3D => "#version 300 es\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform lowp sampler3D u_sampler;\n\
             in mediump vec3 v_texCoord;\n\
             void main (void)\n\
             {\n\
             \to_color = texture(u_sampler, v_texCoord);\n\
             }"
        .to_string(),
        glw::GL_TEXTURE_CUBE_MAP => "#version 300 es\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform lowp samplerCube u_sampler;\n\
             in mediump vec2 v_texCoord;\n\
             void main (void)\n\
             {\n\
             \to_color = texture(u_sampler, vec3(cos(3.14 * v_texCoord.y) * sin(3.14 * v_texCoord.x), sin(3.14 * v_texCoord.y), cos(3.14 * v_texCoord.y) * cos(3.14 * v_texCoord.x)));\n\
             }"
        .to_string(),
        _ => unreachable!("TestSpec::target is one of the three GL texture targets above"),
    }
}

/// `MultiTextureSamplerTest::selectFragmentShader`
fn fragment_shader_source_multi(target: GLenum) -> String {
    match target {
        glw::GL_TEXTURE_2D => "#version 300 es\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform lowp sampler2D u_sampler1;\n\
             uniform lowp sampler2D u_sampler2;\n\
             in mediump vec2 v_texCoord;\n\
             void main (void)\n\
             {\n\
             \to_color = vec4(0.75, 0.75, 0.75, 1.0) * (texture(u_sampler1, v_texCoord) + texture(u_sampler2, v_texCoord));\n\
             }"
        .to_string(),
        glw::GL_TEXTURE_3D => "#version 300 es\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform lowp sampler3D u_sampler1;\n\
             uniform lowp sampler3D u_sampler2;\n\
             in mediump vec3 v_texCoord;\n\
             void main (void)\n\
             {\n\
             \to_color = vec4(0.75, 0.75, 0.75, 1.0) * (texture(u_sampler1, v_texCoord) + texture(u_sampler2, v_texCoord));\n\
             }"
        .to_string(),
        glw::GL_TEXTURE_CUBE_MAP => "#version 300 es\n\
             layout(location = 0) out mediump vec4 o_color;\n\
             uniform lowp samplerCube u_sampler1;\n\
             uniform lowp samplerCube u_sampler2;\n\
             in mediump vec2 v_texCoord;\n\
             void main (void)\n\
             {\n\
             \to_color = vec4(0.5, 0.5, 0.5, 1.0) * (texture(u_sampler1, vec3(cos(3.14 * v_texCoord.y) * sin(3.14 * v_texCoord.x), sin(3.14 * v_texCoord.y), cos(3.14 * v_texCoord.y) * cos(3.14 * v_texCoord.x))) + texture(u_sampler2, vec3(cos(3.14 * v_texCoord.y) * sin(3.14 * v_texCoord.x), sin(3.14 * v_texCoord.y), cos(3.14 * v_texCoord.y) * cos(3.14 * v_texCoord.x))));\n\
             }"
        .to_string(),
        _ => unreachable!("TestSpec::target is one of the three GL texture targets above"),
    }
}

const S_POSITIONS: &[f32] = &[-1.0, -1.0, 1.0, -1.0, 1.0, 1.0, 1.0, 1.0, -1.0, 1.0, -1.0, -1.0];
const S_POSITIONS_3D: &[f32] = &[
    -1.0, -1.0, -1.0, 1.0, -1.0, 1.0, 1.0, 1.0, -1.0, 1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, -1.0, -1.0,
];
const S_POSITIONS_CUBE: &[f32] = &[
    -1.0, -1.0, -1.0, -0.5, 1.0, -1.0, 1.0, -0.5, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 0.5, -1.0, 1.0, -1.0, 0.5, -1.0,
    -1.0, -1.0, -0.5,
];

fn position_data(target: GLenum) -> (i32, &'static [f32]) {
    match target {
        glw::GL_TEXTURE_2D => (2, S_POSITIONS),
        glw::GL_TEXTURE_3D => (3, S_POSITIONS_3D),
        glw::GL_TEXTURE_CUBE_MAP => (4, S_POSITIONS_CUBE),
        _ => unreachable!("TestSpec::target is one of the three GL texture targets above"),
    }
}

fn set_texture_state(gl: &glw::Functions, target: GLenum, state: &SamplingState) {
    // SAFETY: `target` names whichever texture is currently bound.
    unsafe {
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, state.min_filter as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, state.mag_filter as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, state.wrap_s as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, state.wrap_t as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_R, state.wrap_r as GLint);
        gl.tex_parameterf(target, glw::GL_TEXTURE_MAX_LOD, state.max_lod);
        gl.tex_parameterf(target, glw::GL_TEXTURE_MIN_LOD, state.min_lod);
    }
}

fn set_sampler_state(gl: &glw::Functions, sampler: GLuint, state: &SamplingState) {
    // SAFETY: `sampler` is a live sampler object name.
    unsafe {
        gl.sampler_parameteri(sampler, glw::GL_TEXTURE_MIN_FILTER, state.min_filter as GLint);
        gl.sampler_parameteri(sampler, glw::GL_TEXTURE_MAG_FILTER, state.mag_filter as GLint);
        gl.sampler_parameteri(sampler, glw::GL_TEXTURE_WRAP_S, state.wrap_s as GLint);
        gl.sampler_parameteri(sampler, glw::GL_TEXTURE_WRAP_T, state.wrap_t as GLint);
        gl.sampler_parameteri(sampler, glw::GL_TEXTURE_WRAP_R, state.wrap_r as GLint);
        gl.sampler_parameterf(sampler, glw::GL_TEXTURE_MAX_LOD, state.max_lod);
        gl.sampler_parameterf(sampler, glw::GL_TEXTURE_MIN_LOD, state.min_lod);
    }
}

/// `TextureSamplerTest::createTexture2D` / `MultiTextureSamplerTest::createTexture2D` -
/// `gradient_min`/`gradient_max` are the two functions' only difference (the multi
/// variant's `id` selects which half of the colour cube each of its two textures gets).
fn create_texture_2d(gl: &glw::Functions, gradient_min: [f32; 4], gradient_max: [f32; 4]) -> Result<GLuint, TestError> {
    let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let mut level = TextureLevel::new(format, TEXTURE2D_SIZE, TEXTURE2D_SIZE, 1)?;
    fill_with_component_gradients2(&mut level.get_access(), gradient_min, gradient_max);

    let mut texture: GLuint = 0;
    // SAFETY: `level`'s backing storage holds exactly `TEXTURE2D_SIZE^2` RGBA8 texels.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8 as GLint,
            TEXTURE2D_SIZE as GLint,
            TEXTURE2D_SIZE as GLint,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            level.data().as_ptr().cast(),
        );
        gl.generate_mipmap(glw::GL_TEXTURE_2D);
        gl.bind_texture(glw::GL_TEXTURE_2D, 0);
    }
    Ok(texture)
}

/// `TextureSamplerTest::createTexture3D` / `MultiTextureSamplerTest::createTexture3D`
fn create_texture_3d(gl: &glw::Functions, gradient_min: [f32; 4], gradient_max: [f32; 4]) -> Result<GLuint, TestError> {
    let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let mut level = TextureLevel::new(format, TEXTURE3D_SIZE, TEXTURE3D_SIZE, TEXTURE3D_SIZE)?;
    fill_with_component_gradients2(&mut level.get_access(), gradient_min, gradient_max);

    let mut texture: GLuint = 0;
    // SAFETY: `level`'s backing storage holds exactly `TEXTURE3D_SIZE^3` RGBA8 texels.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_3D, texture);
        gl.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8 as GLint,
            TEXTURE3D_SIZE as GLint,
            TEXTURE3D_SIZE as GLint,
            TEXTURE3D_SIZE as GLint,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            level.data().as_ptr().cast(),
        );
        gl.generate_mipmap(glw::GL_TEXTURE_3D);
        gl.bind_texture(glw::GL_TEXTURE_3D, 0);
    }
    Ok(texture)
}

/// `TextureSamplerTest::createTextureCube` / `MultiTextureSamplerTest::createTextureCube`
fn create_texture_cube(
    gl: &glw::Functions,
    gradient_min: [f32; 4],
    gradient_max: [f32; 4],
) -> Result<GLuint, TestError> {
    let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let mut texture: GLuint = 0;
    // SAFETY: each face's backing storage holds exactly `CUBEMAP_SIZE^2` RGBA8 texels.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture);
        for face in 0..6u32 {
            let mut level = TextureLevel::new(format, CUBEMAP_SIZE, CUBEMAP_SIZE, 1)?;
            fill_with_component_gradients2(&mut level.get_access(), gradient_min, gradient_max);
            let target = glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + face;
            gl.tex_image_2d(
                target,
                0,
                glw::GL_RGBA8 as GLint,
                CUBEMAP_SIZE as GLint,
                CUBEMAP_SIZE as GLint,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                level.data().as_ptr().cast(),
            );
        }
        gl.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP);
        gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0);
    }
    Ok(texture)
}

fn create_texture(
    gl: &glw::Functions,
    target: GLenum,
    gradient_min: [f32; 4],
    gradient_max: [f32; 4],
) -> Result<GLuint, TestError> {
    match target {
        glw::GL_TEXTURE_2D => create_texture_2d(gl, gradient_min, gradient_max),
        glw::GL_TEXTURE_3D => create_texture_3d(gl, gradient_min, gradient_max),
        glw::GL_TEXTURE_CUBE_MAP => create_texture_cube(gl, gradient_min, gradient_max),
        _ => unreachable!("TestSpec::target is one of the three GL texture targets above"),
    }
}

const GRADIENT_MIN: [f32; 4] = [0.0, 0.0, 0.0, 0.0];
const GRADIENT_MAX: [f32; 4] = [1.0, 1.0, 1.0, 1.0];

/// `TextureSamplerTest::render` - two draws of the same quad, full scale then a quarter
/// scale, with `u_posScale`/`u_sampler` already bound to texture unit 0.
fn draw_quad(context: &Context, program: GLuint, target: GLenum, scale_loc: GLint) -> Result<(), TestError> {
    let gl = context.gl();
    let (num_components, positions) = position_data(target);
    let num_elements = positions.len() as i32 / num_components;
    let binding = va::float("a_position", num_components, num_elements, 0, positions);
    let primitives = pr::list(PrimitiveType::Triangles, num_elements);

    // SAFETY: `scale_loc` is a uniform location `render_single`/`render_multi` just
    // resolved from this same `program`.
    unsafe { gl.uniform_1f(scale_loc, 1.0) };
    draw(&context.render_context, program, &[binding], &primitives)?;

    let binding = va::float("a_position", num_components, num_elements, 0, positions);
    unsafe { gl.uniform_1f(scale_loc, 0.25) };
    draw(&context.render_context, program, &[binding], &primitives)?;

    Ok(())
}

/// `TextureSamplerTest::render`
fn render_single(context: &Context, program: &ShaderProgram<'_>, target: GLenum) -> Result<(), TestError> {
    let gl = context.gl();
    let sampler_loc = uniform_location(gl, program.program(), "u_sampler");
    let scale_loc = uniform_location(gl, program.program(), "u_posScale");

    // SAFETY: `program` compiled successfully.
    unsafe {
        gl.use_program(program.program());
        gl.clear_color(0.5, 0.5, 0.5, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.uniform_1i(sampler_loc, 0);
    }
    draw_quad(context, program.program(), target, scale_loc)
}

/// `MultiTextureSamplerTest::render`
fn render_multi(context: &Context, program: &ShaderProgram<'_>, target: GLenum) -> Result<(), TestError> {
    let gl = context.gl();
    let sampler_loc1 = uniform_location(gl, program.program(), "u_sampler1");
    let sampler_loc2 = uniform_location(gl, program.program(), "u_sampler2");
    let scale_loc = uniform_location(gl, program.program(), "u_posScale");

    // SAFETY: `program` compiled successfully.
    unsafe {
        gl.use_program(program.program());
        gl.clear_color(0.5, 0.5, 0.5, 1.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.uniform_1i(sampler_loc1, 0);
        gl.uniform_1i(sampler_loc2, 1);
    }
    draw_quad(context, program.program(), target, scale_loc)
}

fn read_viewport(context: &Context, x: i32, y: i32) -> Result<Surface, TestError> {
    let mut surface = Surface::new(VIEWPORT_WIDTH, VIEWPORT_HEIGHT);
    read_pixels(&context.render_context, x, y, &mut surface.get_access())?;
    Ok(surface)
}

struct TextureSamplerCase {
    name: &'static str,
    target: GLenum,
    texture_state: SamplingState,
    sampler_state: SamplingState,
}

impl TestCase for TextureSamplerCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `TextureSamplerTest::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(self.name));
        let render_target = context.render_target();
        let x = rnd.get_int(0, render_target.width - VIEWPORT_WIDTH);
        let y = rnd.get_int(0, render_target.height - VIEWPORT_HEIGHT);

        let vertex = vertex_shader_source(self.target);
        let fragment = fragment_shader_source_single(self.target);
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex, fragment));
        if !program.is_ok() {
            return Ok(TestStatus::fail("Failed to compile shaders"));
        }

        // `TextureSamplerTest::renderReferences` - both renders driven directly by the
        // texture object's own sampling state.
        let (texture_ref, sampler_ref) = {
            let texture = create_texture(gl, self.target, GRADIENT_MIN, GRADIENT_MAX)?;
            // SAFETY: `texture` was just created and is bound to `self.target`.
            unsafe {
                gl.viewport(x, y, VIEWPORT_WIDTH, VIEWPORT_HEIGHT);
                gl.bind_texture(self.target, texture);
            }
            set_texture_state(gl, self.target, &self.texture_state);
            render_single(context, &program, self.target)?;
            let texture_ref = read_viewport(context, x, y)?;

            set_texture_state(gl, self.target, &self.sampler_state);
            render_single(context, &program, self.target)?;
            let sampler_ref = read_viewport(context, x, y)?;

            // SAFETY: `texture` was generated just above by this same block.
            unsafe { gl.delete_textures(1, &texture) };
            (texture_ref, sampler_ref)
        };

        // `TextureSamplerTest::renderResults` - the sampler-object render first (real
        // sampler bound, overriding the texture's own state), then the plain-texture
        // render (sampler unbound again).
        let (texture_result, sampler_result) = {
            let texture = create_texture(gl, self.target, GRADIENT_MIN, GRADIENT_MAX)?;
            let mut sampler: GLuint = 0;
            // SAFETY: `texture`/`sampler` are freshly created below.
            unsafe {
                gl.viewport(x, y, VIEWPORT_WIDTH, VIEWPORT_HEIGHT);
                gl.gen_samplers(1, &mut sampler);
                gl.bind_sampler(0, sampler);
            }
            set_sampler_state(gl, sampler, &self.sampler_state);
            // SAFETY: `texture` was just created.
            unsafe { gl.bind_texture(self.target, texture) };
            set_texture_state(gl, self.target, &self.texture_state);

            render_single(context, &program, self.target)?;
            let sampler_result = read_viewport(context, x, y)?;

            // SAFETY: unbinding the sampler falls back to the texture's own state.
            unsafe { gl.bind_sampler(0, 0) };
            render_single(context, &program, self.target)?;
            let texture_result = read_viewport(context, x, y)?;

            // SAFETY: both were generated just above by this same block.
            unsafe {
                gl.delete_samplers(1, &sampler);
                gl.delete_textures(1, &texture);
            }
            (texture_result, sampler_result)
        };

        let threshold = RGBA::new(0, 0, 0, 0);
        let sampler_ok = pixel_threshold_compare(&sampler_ref, &sampler_result, threshold).ok;
        let texture_ok = pixel_threshold_compare(&texture_ref, &texture_result, threshold).ok;

        if sampler_ok && texture_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

/// The per-`id` gradient bounds `MultiTextureSamplerTest::createTexture{2D,3D,Cube}`
/// select between - identical for 2D/3D, and cube's own narrower halves.
fn multi_gradient(target: GLenum, id: u32) -> ([f32; 4], [f32; 4]) {
    match (target, id) {
        (glw::GL_TEXTURE_CUBE_MAP, 0) => ([0.0, 0.0, 0.0, 0.0], [0.5, 0.5, 0.5, 0.5]),
        (glw::GL_TEXTURE_CUBE_MAP, 1) => ([0.5, 0.5, 0.5, 0.5], [1.0, 1.0, 1.0, 1.0]),
        (_, 0) => ([0.0, 0.0, 0.0, 0.0], [1.0, 1.0, 0.5, 0.5]),
        (_, 1) => ([0.0, 0.0, 0.0, 0.0], [0.5, 0.5, 1.0, 1.0]),
        _ => unreachable!("id is 0 or 1"),
    }
}

struct MultiTextureSamplerCase {
    name: &'static str,
    target: GLenum,
    texture_state1: SamplingState,
    texture_state2: SamplingState,
    sampler_state: SamplingState,
}

impl TestCase for MultiTextureSamplerCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `MultiTextureSamplerTest::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(self.name));
        let render_target = context.render_target();
        let x = rnd.get_int(0, render_target.width - VIEWPORT_WIDTH);
        let y = rnd.get_int(0, render_target.height - VIEWPORT_HEIGHT);

        let vertex = vertex_shader_source(self.target);
        let fragment = fragment_shader_source_multi(self.target);
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex, fragment));
        if !program.is_ok() {
            return Ok(TestStatus::fail("Failed to compile shaders"));
        }

        // `MultiTextureSamplerTest::renderReferences`
        let (texture_ref, sampler_ref) = {
            let (min0, max0) = multi_gradient(self.target, 0);
            let (min1, max1) = multi_gradient(self.target, 1);
            let texture1 = create_texture(gl, self.target, min0, max0)?;
            let texture2 = create_texture(gl, self.target, min1, max1)?;
            // SAFETY: both textures were just created above.
            unsafe {
                gl.viewport(x, y, VIEWPORT_WIDTH, VIEWPORT_HEIGHT);

                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(self.target, texture1);
                set_texture_state(gl, self.target, &self.texture_state1);

                gl.active_texture(glw::GL_TEXTURE1);
                gl.bind_texture(self.target, texture2);
                set_texture_state(gl, self.target, &self.texture_state2);
            }
            render_multi(context, &program, self.target)?;
            let texture_ref = read_viewport(context, x, y)?;

            // SAFETY: as above - both texture units still hold `texture1`/`texture2`.
            unsafe {
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(self.target, texture1);
                set_texture_state(gl, self.target, &self.sampler_state);

                gl.active_texture(glw::GL_TEXTURE1);
                gl.bind_texture(self.target, texture2);
                set_texture_state(gl, self.target, &self.sampler_state);
            }
            render_multi(context, &program, self.target)?;
            let sampler_ref = read_viewport(context, x, y)?;

            // SAFETY: `texture1`/`texture2` were generated just above by this same block.
            unsafe {
                gl.delete_textures(1, &texture1);
                gl.delete_textures(1, &texture2);
            }
            (texture_ref, sampler_ref)
        };

        // `MultiTextureSamplerTest::renderResults`
        let (texture_result, sampler_result) = {
            let (min0, max0) = multi_gradient(self.target, 0);
            let (min1, max1) = multi_gradient(self.target, 1);
            let texture1 = create_texture(gl, self.target, min0, max0)?;
            let texture2 = create_texture(gl, self.target, min1, max1)?;
            let mut sampler: GLuint = 0;
            // SAFETY: `texture1`/`texture2`/`sampler` are freshly created here.
            unsafe {
                gl.viewport(x, y, VIEWPORT_WIDTH, VIEWPORT_HEIGHT);
                gl.gen_samplers(1, &mut sampler);
                gl.bind_sampler(0, sampler);
                gl.bind_sampler(1, sampler);
            }
            set_sampler_state(gl, sampler, &self.sampler_state);

            // SAFETY: both textures were just created above.
            unsafe {
                gl.bind_texture(self.target, texture1);
                set_texture_state(gl, self.target, &self.texture_state1);
                gl.bind_texture(self.target, texture2);
                set_texture_state(gl, self.target, &self.texture_state2);

                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(self.target, texture1);
                gl.active_texture(glw::GL_TEXTURE1);
                gl.bind_texture(self.target, texture2);
            }

            render_multi(context, &program, self.target)?;
            let sampler_result = read_viewport(context, x, y)?;

            // SAFETY: unbinding both samplers falls back to each texture's own state.
            unsafe {
                gl.bind_sampler(0, 0);
                gl.bind_sampler(1, 0);
            }
            render_multi(context, &program, self.target)?;
            let texture_result = read_viewport(context, x, y)?;

            // SAFETY: all three were generated just above by this same block.
            unsafe {
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(self.target, 0);
                gl.active_texture(glw::GL_TEXTURE1);
                gl.bind_texture(self.target, 0);
                gl.delete_samplers(1, &sampler);
                gl.delete_textures(1, &texture1);
                gl.delete_textures(1, &texture2);
            }
            (texture_result, sampler_result)
        };

        let threshold = RGBA::new(0, 0, 0, 0);
        let sampler_ok = pixel_threshold_compare(&sampler_ref, &sampler_result, threshold).ok;
        let texture_ok = pixel_threshold_compare(&texture_ref, &texture_result, threshold).ok;

        if sampler_ok && texture_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Fail"))
        }
    }
}

pub fn make_texture_sampler_case(spec: TestSpec) -> Box<dyn TestCase> {
    Box::new(TextureSamplerCase {
        name: spec.name,
        target: spec.target,
        texture_state: spec.texture_state,
        sampler_state: spec.sampler_state,
    })
}

pub fn make_multi_texture_sampler_case(spec: MultiTestSpec) -> Box<dyn TestCase> {
    Box::new(MultiTextureSamplerCase {
        name: spec.name,
        target: spec.target,
        texture_state1: spec.texture_state1,
        texture_state2: spec.texture_state2,
        sampler_state: spec.sampler_state,
    })
}
