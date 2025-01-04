// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (BasicAllFormatsStore, BasicAllFormatsLoad and the geometry/compute stage flavours)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `Write<T>`/`Read<T>` templates are generic over `Texel`; the (format, value, expected value) rows of `Run` are `FormatCase` rows in `format_cases`, whose three flavours (`vec4`, `ivec4`, `uvec4`) are the `Typed` variants. Written without compiling.

use super::base::*;
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};

/// A row of the format tables: the internal format, the value to write (or load) and the value expected back.
pub(super) enum FormatCase {
    Float(GLenum, Vec4, Vec4),
    Int(GLenum, IVec4, IVec4),
    Uint(GLenum, UVec4, UVec4),
}

/// The rows every `BasicAllFormats*` case runs, in upstream's order.
pub(super) fn format_cases() -> Vec<FormatCase> {
    use FormatCase::{Float as F, Int as I, Uint as U};
    let seq: Vec4 = [1.0, 2.0, 3.0, 4.0];
    let iseq: IVec4 = [1, -2, 3, -4];
    let useq: UVec4 = [0, 1, 2, 3];
    let user: UVec4 = [7, 2, 3, 4];
    let alt: Vec4 = [1.0, -1.0, 1.0, -1.0];
    let ralt: Vec4 = [-1.0, 1.0, -1.0, 1.0];
    vec![
        F(glw::GL_RGBA32F, seq, [1.0, 2.0, 3.0, 4.0]),
        F(glw::GL_RG32F, seq, [1.0, 2.0, 0.0, 1.0]),
        F(glw::GL_R32F, seq, [1.0, 0.0, 0.0, 1.0]),
        F(glw::GL_RGBA16F, seq, [1.0, 2.0, 3.0, 4.0]),
        F(glw::GL_RG16F, seq, [1.0, 2.0, 0.0, 1.0]),
        F(glw::GL_R16F, seq, [1.0, 0.0, 0.0, 1.0]),
        I(glw::GL_RGBA32I, iseq, [1, -2, 3, -4]),
        I(glw::GL_RG32I, iseq, [1, -2, 0, 1]),
        I(glw::GL_R32I, iseq, [1, 0, 0, 1]),
        F(glw::GL_R11F_G11F_B10F, seq, [1.0, 2.0, 3.0, 1.0]),
        I(glw::GL_RGBA16I, iseq, [1, -2, 3, -4]),
        I(glw::GL_RG16I, iseq, [1, -2, 0, 1]),
        I(glw::GL_R16I, iseq, [1, 0, 0, 1]),
        I(glw::GL_RGBA8I, iseq, [1, -2, 3, -4]),
        I(glw::GL_RG8I, iseq, [1, -2, 0, 1]),
        I(glw::GL_R8I, iseq, [1, 0, 0, 1]),
        U(glw::GL_RGBA32UI, useq, [0, 1, 2, 3]),
        U(glw::GL_RGB10_A2UI, useq, [0, 1, 2, 3]),
        U(glw::GL_RG32UI, useq, [0, 1, 0, 1]),
        U(glw::GL_R32UI, user, [7, 0, 0, 1]),
        U(glw::GL_RGBA16UI, useq, [0, 1, 2, 3]),
        U(glw::GL_RG16UI, useq, [0, 1, 0, 1]),
        U(glw::GL_R16UI, user, [7, 0, 0, 1]),
        U(glw::GL_RGBA8UI, useq, [0, 1, 2, 3]),
        U(glw::GL_RG8UI, useq, [0, 1, 0, 1]),
        U(glw::GL_R8UI, user, [7, 0, 0, 1]),
        F(glw::GL_RGBA16, [1.0; 4], [1.0; 4]),
        F(glw::GL_RGB10_A2, [1.0; 4], [1.0; 4]),
        F(glw::GL_RG16, [1.0; 4], [1.0, 1.0, 0.0, 1.0]),
        F(glw::GL_R16, [1.0; 4], [1.0, 0.0, 0.0, 1.0]),
        F(glw::GL_RGBA8, [1.0; 4], [1.0; 4]),
        F(glw::GL_RG8, [1.0; 4], [1.0, 1.0, 0.0, 1.0]),
        F(glw::GL_R8, [1.0; 4], [1.0, 0.0, 0.0, 1.0]),
        F(glw::GL_RGBA16_SNORM, alt, alt),
        F(glw::GL_RG16_SNORM, [-1.0; 4], [-1.0, -1.0, 0.0, 1.0]),
        F(glw::GL_R16_SNORM, ralt, [-1.0, 0.0, 0.0, 1.0]),
        F(glw::GL_RGBA8_SNORM, alt, alt),
        F(glw::GL_RG8_SNORM, [-1.0; 4], [-1.0, -1.0, 0.0, 1.0]),
        F(glw::GL_R8_SNORM, ralt, [-1.0, 0.0, 0.0, 1.0]),
    ]
}

/// `operator<<(std::ostream &, tcu::Vector)`: "(a, b, c, d)".
pub(super) fn vec_to_glsl<T: std::fmt::Display>(v: &[T; 4]) -> String {
    format!("({}, {}, {}, {})", v[0], v[1], v[2], v[3])
}

const FORMAT_VS: &str =
    "#version 420 core\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";

fn texture_parameters_nearest(gl: &glw::Functions) {
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
}

/// `GenFS` of BasicAllFormatsStore
fn gen_store_fs<T: Texel>(internalformat: GLenum, value: &[T; 4]) -> String {
    let prefix = T::type_prefix();
    format!(
        "#version 420 core\nlayout({}) writeonly uniform {prefix}image2D g_image;\nvoid main() {{\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  imageStore(g_image, coord, {prefix}vec4{});\n  discard;\n}}",
        format_enum_to_string(internalformat),
        vec_to_glsl(value)
    )
}

/// `GenFS` of BasicAllFormatsLoad
fn gen_load_fs<T: Texel>(internalformat: GLenum, expected_value: &[T; 4]) -> String {
    let prefix = T::type_prefix();
    format!(
        "#version 420 core\nlayout(location = 0) out vec4 o_color;\nlayout({}) readonly uniform {prefix}image2D g_image;\nvoid main() {{\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  {prefix}vec4 v = imageLoad(g_image, coord);\n  if (v != {prefix}vec4{}) o_color = vec4(1.0, 0.0, 0.0, 1.0);\n  else o_color = vec4(0.0, 1.0, 0.0, 1.0);\n}}",
        format_enum_to_string(internalformat),
        vec_to_glsl(expected_value)
    )
}

/// `Write<T>`
fn write<T: Texel>(
    gl: &glw::Functions,
    vao: GLuint,
    internalformat: GLenum,
    write_value: &[T; 4],
    expected_value: &[T; 4],
) -> bool {
    let program = build_program(gl, Some(FORMAT_VS), Some(&gen_store_fs(internalformat, write_value)));
    const K_SIZE: i32 = 16;
    let mut data = vec![[T::default(); 4]; (K_SIZE * K_SIZE) as usize];
    let mut texture: GLuint = 0;
    gl!(gl.gen_textures(1, &mut texture));
    for unit in 0..8 {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
        texture_parameters_nearest(gl);
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            internalformat as GLint,
            K_SIZE,
            K_SIZE,
            0,
            T::format(),
            T::type_(),
            data.as_ptr().cast()
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

        gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
        gl!(gl.use_program(program));
        gl!(gl.bind_image_texture(unit, texture, 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, internalformat));
        gl!(gl.bind_vertex_array(vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
        gl!(gl.get_tex_image(glw::GL_TEXTURE_2D, 0, T::format(), T::type_(), data.as_mut_ptr().cast()));

        for value in &data {
            if !T::equal(value, expected_value, internalformat) {
                gl!(gl.delete_textures(1, &texture));
                gl!(gl.use_program(0));
                gl!(gl.delete_program(program));
                log::info!(
                    "Value is: {}. Value should be: {}. Format is: {}. Unit is: {unit}",
                    vec_to_glsl(value),
                    vec_to_glsl(expected_value),
                    format_enum_to_string(internalformat)
                );
                return false;
            }
        }
        if unit < 7 {
            gl!(gl.uniform_1i(uniform_location(gl, program, "g_image"), unit as GLint + 1));
        }
    }
    gl!(gl.delete_textures(1, &texture));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    true
}

/// `Read<T>`
fn read<T: Texel>(
    context: &Context,
    vao: GLuint,
    internalformat: GLenum,
    value: &[T; 4],
    expected_value: &[T; 4],
) -> bool {
    let gl = context.gl();
    let program = build_program(gl, Some(FORMAT_VS), Some(&gen_load_fs(internalformat, expected_value)));
    const K_SIZE: i32 = 16;
    let data = vec![*value; (K_SIZE * K_SIZE) as usize];
    let mut texture: GLuint = 0;
    gl!(gl.gen_textures(1, &mut texture));
    for unit in 0..8 {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
        texture_parameters_nearest(gl);
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            internalformat as GLint,
            K_SIZE,
            K_SIZE,
            0,
            T::format(),
            T::type_(),
            data.as_ptr().cast()
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

        gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl!(gl.use_program(program));
        gl!(gl.bind_image_texture(unit, texture, 0, glw::FALSE, 0, glw::GL_READ_ONLY, internalformat));
        gl!(gl.bind_vertex_array(vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        if !validate_read_buffer(context, 0, 0, K_SIZE, K_SIZE, &[0.0, 1.0, 0.0, 1.0]) {
            gl!(gl.delete_textures(1, &texture));
            gl!(gl.use_program(0));
            gl!(gl.delete_program(program));
            log::info!(
                "Bad load value. Format is: {}. Unit is: {unit}",
                format_enum_to_string(internalformat)
            );
            return false;
        }
        if unit < 7 {
            gl!(gl.uniform_1i(uniform_location(gl, program, "g_image"), unit as GLint + 1));
        }
    }
    gl!(gl.delete_textures(1, &texture));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    true
}

/// 1.2.1 BasicAllFormatsStore
#[derive(Default)]
pub(super) struct BasicAllFormatsStore {
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for BasicAllFormatsStore {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        for case in format_cases() {
            let ok = match &case {
                FormatCase::Float(format, value, expected) => write::<f32>(gl, self.vao, *format, value, expected),
                FormatCase::Int(format, value, expected) => write::<i32>(gl, self.vao, *format, value, expected),
                FormatCase::Uint(format, value, expected) => write::<u32>(gl, self.vao, *format, value, expected),
            };
            if !ok {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        restore_viewport(context);
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        Ok(NO_ERROR)
    }
}

/// 1.2.2 BasicAllFormatsLoad
#[derive(Default)]
pub(super) struct BasicAllFormatsLoad {
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for BasicAllFormatsLoad {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        for case in format_cases() {
            let ok = match &case {
                FormatCase::Float(format, value, expected) => read::<f32>(context, self.vao, *format, value, expected),
                FormatCase::Int(format, value, expected) => read::<i32>(context, self.vao, *format, value, expected),
                FormatCase::Uint(format, value, expected) => read::<u32>(context, self.vao, *format, value, expected),
            };
            if !ok {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        restore_viewport(context);
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        Ok(NO_ERROR)
    }
}
