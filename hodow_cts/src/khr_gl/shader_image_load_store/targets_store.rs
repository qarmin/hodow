// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (BasicAllTargetsStore)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `Write<T>`, `WriteMS<T>` and `WriteCubeArray<T>` are generic over `Texel`; the `GenFS*` shader generators build the repeated `imageStore` lines in loops. Written without compiling.

use super::base::*;
use super::formats::vec_to_glsl;
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};

pub(super) const SIMPLE_VS: &str =
    "#version 420 core\nlayout(location = 0) in vec4 i_position;\nvoid main() {\n  gl_Position = i_position;\n}";

fn set_nearest(gl: &glw::Functions, target: GLenum) {
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
}

/// `tcu::allEqual` over `count` texels of `data`; logs the first difference as "<target> target failed".
fn all_equal<T: Texel>(data: &[[T; 4]], count: usize, expected: &[T; 4], target_name: &str) -> bool {
    for texel in &data[..count] {
        if texel != expected {
            log::info!(
                "{target_name} target failed. Value is: {}. Value should be: {}",
                vec_to_glsl(texel),
                vec_to_glsl(expected)
            );
            return false;
        }
    }
    true
}

/// `GenFS`
fn gen_fs<T: Texel>(internalformat: GLenum, write_value: &T4<T>) -> String {
    let format = format_enum_to_string(internalformat);
    let prefix = T::type_prefix();
    let value = vec_to_glsl(write_value);
    let mut os = String::from("#version 420 core");
    for (type_name, name) in [
        ("image1D", "g_image_1d"),
        ("image2D", "g_image_2d"),
        ("image3D", "g_image_3d"),
        ("image2DRect", "g_image_2drect"),
        ("imageCube", "g_image_cube"),
        ("imageBuffer", "g_image_buffer"),
        ("image1DArray", "g_image_1darray"),
        ("image2DArray", "g_image_2darray"),
    ] {
        os.push_str(&format!(
            "\nlayout({format}) writeonly uniform {prefix}{type_name} {name};"
        ));
    }
    os.push_str("\nvoid main() {\n  ivec2 coord = ivec2(gl_FragCoord.xy);");
    let vec = format!("{prefix}vec4{value}");
    os.push_str(&format!("\n  imageStore(g_image_1d, coord.x, {vec});"));
    os.push_str(&format!("\n  imageStore(g_image_2d, coord, {vec});"));
    for layer in 0..2 {
        os.push_str(&format!("\n  imageStore(g_image_3d, ivec3(coord.xy, {layer}), {vec});"));
    }
    os.push_str(&format!("\n  imageStore(g_image_2drect, coord, {vec});"));
    for face in 0..6 {
        os.push_str(&format!("\n  imageStore(g_image_cube, ivec3(coord, {face}), {vec});"));
    }
    os.push_str(&format!("\n  imageStore(g_image_buffer, coord.x, {vec});"));
    for layer in 0..2 {
        os.push_str(&format!(
            "\n  imageStore(g_image_1darray, ivec2(coord.x, {layer}), {vec});"
        ));
    }
    for layer in 0..2 {
        os.push_str(&format!(
            "\n  imageStore(g_image_2darray, ivec3(coord, {layer}), {vec});"
        ));
    }
    os.push_str("\n  discard;\n}");
    os
}

pub(super) type T4<T> = [T; 4];

/// `GenFSMS`
fn gen_fs_ms<T: Texel>(internalformat: GLenum, write_value: &T4<T>) -> String {
    let format = format_enum_to_string(internalformat);
    let prefix = T::type_prefix();
    let vec = format!("{prefix}vec4{}", vec_to_glsl(write_value));
    let mut os = format!(
        "#version 420 core\nlayout({format}) writeonly uniform {prefix}image2DMS g_image_2dms;\nlayout({format}) writeonly uniform {prefix}image2DMSArray g_image_2dms_array;\nvoid main() {{\n  ivec2 coord = ivec2(gl_FragCoord.xy);"
    );
    for sample in 0..4 {
        os.push_str(&format!("\n  imageStore(g_image_2dms, coord, {sample}, {vec});"));
    }
    for layer in 0..2 {
        for sample in 0..4 {
            os.push_str(&format!(
                "\n  imageStore(g_image_2dms_array, ivec3(coord, {layer}), {sample}, {vec});"
            ));
        }
    }
    os.push_str("\n  discard;\n}");
    os
}

/// `GenFSMSVal`
fn gen_fs_ms_val<T: Texel>(expected_value: &T4<T>) -> String {
    let prefix = T::type_prefix();
    let vec = format!("{prefix}vec4{}", vec_to_glsl(expected_value));
    let mut os = format!(
        "#version 420 core\nlayout(location = 0) out vec4 o_color;\nuniform {prefix}sampler2DMS g_sampler_2dms;\nuniform {prefix}sampler2DMSArray g_sampler_2dms_array;\nvoid main() {{\n  o_color = vec4(0.0, 1.0, 0.0, 1.0);\n  ivec2 coord = ivec2(gl_FragCoord.xy);"
    );
    for sample in 0..4 {
        os.push_str(&format!(
            "\n  if (texelFetch(g_sampler_2dms, coord, {sample}) != {vec}) o_color = vec4(1.0, 0.0, 0.0, 0.1);"
        ));
    }
    for (layer, alpha) in [(0, "0.2"), (1, "0.3")] {
        for sample in 0..4 {
            os.push_str(&format!("\n  if (texelFetch(g_sampler_2dms_array, ivec3(coord, {layer}), {sample}) != {vec}) o_color = vec4(1.0, 0.0, 0.0, {alpha});"));
        }
    }
    os.push_str("\n}");
    os
}

/// `GenFSCubeArray`
fn gen_fs_cube_array<T: Texel>(internalformat: GLenum, write_value: &T4<T>) -> String {
    let format = format_enum_to_string(internalformat);
    let prefix = T::type_prefix();
    let vec = format!("{prefix}vec4{}", vec_to_glsl(write_value));
    let mut os = format!(
        "#version 420 core\nlayout({format}) writeonly uniform {prefix}imageCubeArray g_image_cube_array;\nvoid main() {{\n  ivec2 coord = ivec2(gl_FragCoord.xy);"
    );
    for layer in 0..12 {
        os.push_str(&format!(
            "\n  imageStore(g_image_cube_array, ivec3(coord, {layer}), {vec});"
        ));
    }
    os.push_str("\n  discard;\n}");
    os
}

/// `Write<T>`
fn write<T: Texel>(
    gl: &glw::Functions,
    vao: GLuint,
    internalformat: GLenum,
    write_value: &T4<T>,
    expected_value: &T4<T>,
) -> bool {
    let program = build_program(gl, Some(SIMPLE_VS), Some(&gen_fs(internalformat, write_value)));
    let mut textures = [0 as GLuint; 8];
    let mut buffer: GLuint = 0;
    gl!(gl.gen_textures(8, textures.as_mut_ptr()));
    gl!(gl.gen_buffers(1, &mut buffer));
    const K_SIZE: i32 = 16;
    let k = K_SIZE as usize;
    let mut data = vec![[T::default(); 4]; k * k * 2];
    let (format, type_) = (T::format(), T::type_());
    let internal = internalformat as GLint;

    gl!(gl.bind_texture(glw::GL_TEXTURE_1D, textures[0]));
    set_nearest(gl, glw::GL_TEXTURE_1D);
    gl!(gl.tex_image_1d(
        glw::GL_TEXTURE_1D,
        0,
        internal,
        K_SIZE,
        0,
        format,
        type_,
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_1D, 0));

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, textures[1]));
    set_nearest(gl, glw::GL_TEXTURE_2D);
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        internal,
        K_SIZE,
        K_SIZE,
        0,
        format,
        type_,
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

    gl!(gl.bind_texture(glw::GL_TEXTURE_3D, textures[2]));
    set_nearest(gl, glw::GL_TEXTURE_3D);
    gl!(gl.tex_image_3d(
        glw::GL_TEXTURE_3D,
        0,
        internal,
        K_SIZE,
        K_SIZE,
        2,
        0,
        format,
        type_,
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_3D, 0));

    gl!(gl.bind_texture(glw::GL_TEXTURE_RECTANGLE, textures[3]));
    set_nearest(gl, glw::GL_TEXTURE_RECTANGLE);
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_RECTANGLE,
        0,
        internal,
        K_SIZE,
        K_SIZE,
        0,
        format,
        type_,
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_RECTANGLE, 0));

    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[4]));
    set_nearest(gl, glw::GL_TEXTURE_CUBE_MAP);
    for face in [
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
    ] {
        gl!(gl.tex_image_2d(
            face,
            0,
            internal,
            K_SIZE,
            K_SIZE,
            0,
            format,
            type_,
            data.as_ptr().cast()
        ));
    }
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0));

    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, buffer));
    gl!(gl.buffer_data(
        glw::GL_TEXTURE_BUFFER,
        (k * std::mem::size_of::<[T; 4]>()) as isize,
        data.as_ptr().cast(),
        glw::GL_DYNAMIC_DRAW
    ));
    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));
    gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, textures[5]));
    gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, internalformat, buffer));
    gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0));

    gl!(gl.bind_texture(glw::GL_TEXTURE_1D_ARRAY, textures[6]));
    set_nearest(gl, glw::GL_TEXTURE_1D_ARRAY);
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_1D_ARRAY,
        0,
        internal,
        K_SIZE,
        2,
        0,
        format,
        type_,
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_1D_ARRAY, 0));

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, textures[7]));
    set_nearest(gl, glw::GL_TEXTURE_2D_ARRAY);
    gl!(gl.tex_image_3d(
        glw::GL_TEXTURE_2D_ARRAY,
        0,
        internal,
        K_SIZE,
        K_SIZE,
        2,
        0,
        format,
        type_,
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));

    for (unit, layered) in [
        (0, glw::FALSE),
        (1, glw::FALSE),
        (2, glw::TRUE),
        (3, glw::FALSE),
        (4, glw::TRUE),
        (5, glw::FALSE),
        (6, glw::TRUE),
        (7, glw::TRUE),
    ] {
        gl!(gl.bind_image_texture(
            unit,
            textures[unit as usize],
            0,
            layered,
            0,
            glw::GL_WRITE_ONLY,
            internalformat
        ));
    }

    gl!(gl.use_program(program));
    for (unit, name) in [
        "g_image_1d",
        "g_image_2d",
        "g_image_3d",
        "g_image_2drect",
        "g_image_cube",
        "g_image_buffer",
        "g_image_1darray",
        "g_image_2darray",
    ]
    .into_iter()
    .enumerate()
    {
        gl!(gl.uniform_1i(uniform_location(gl, program, name), unit as GLint));
    }

    gl!(gl.bind_vertex_array(vao));
    gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

    let mut status = true;
    let read_target = |target: GLenum, texture: GLuint, data: &mut Vec<[T; 4]>| {
        gl!(gl.bind_texture(target, texture));
        gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
        gl!(gl.get_tex_image(target, 0, format, type_, data.as_mut_ptr().cast()));
        gl!(gl.bind_texture(target, 0));
    };

    read_target(glw::GL_TEXTURE_1D, textures[0], &mut data);
    status &= all_equal(&data, k, expected_value, "GL_TEXTURE_1D");

    data.fill([T::default(); 4]);
    read_target(glw::GL_TEXTURE_2D, textures[1], &mut data);
    status &= all_equal(&data, k * k, expected_value, "GL_TEXTURE_2D");

    read_target(glw::GL_TEXTURE_3D, textures[2], &mut data);
    status &= all_equal(&data, k * k * 2, expected_value, "GL_TEXTURE_3D");

    read_target(glw::GL_TEXTURE_RECTANGLE, textures[3], &mut data);
    status &= all_equal(&data, k * k, expected_value, "GL_TEXTURE_RECTANGLE");

    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[4]));
    gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
    for face in 0..6 {
        gl!(gl.get_tex_image(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + face,
            0,
            format,
            type_,
            data.as_mut_ptr().cast()
        ));
        status &= all_equal(&data, k * k, expected_value, "GL_TEXTURE_CUBE_MAP_POSITIVE_X");
    }
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0));

    gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, textures[5]));
    gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
    gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0));
    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, buffer));
    gl!(gl.get_buffer_sub_data(
        glw::GL_TEXTURE_BUFFER,
        0,
        (k * std::mem::size_of::<[T; 4]>()) as isize,
        data.as_mut_ptr().cast()
    ));
    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));
    status &= all_equal(&data, k, expected_value, "GL_TEXTURE_BUFFER");

    read_target(glw::GL_TEXTURE_1D_ARRAY, textures[6], &mut data);
    status &= all_equal(&data, k * 2, expected_value, "GL_TEXTURE_1D_ARRAY");

    read_target(glw::GL_TEXTURE_2D_ARRAY, textures[7], &mut data);
    status &= all_equal(&data, k * k * 2, expected_value, "GL_TEXTURE_2D_ARRAY");

    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    gl!(gl.delete_textures(8, textures.as_ptr()));
    gl!(gl.delete_buffers(1, &buffer));
    status
}

/// `WriteMS<T>`
fn write_ms<T: Texel>(
    context: &Context,
    vao: GLuint,
    internalformat: GLenum,
    write_value: &T4<T>,
    expected_value: &T4<T>,
) -> bool {
    let gl = context.gl();
    let program = build_program(gl, Some(SIMPLE_VS), Some(&gen_fs_ms(internalformat, write_value)));
    let val_program = build_program(gl, Some(SIMPLE_VS), Some(&gen_fs_ms_val(expected_value)));
    let mut textures = [0 as GLuint; 2];
    gl!(gl.gen_textures(2, textures.as_mut_ptr()));
    const K_SIZE: i32 = 16;

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, textures[0]));
    gl!(gl.tex_image_2d_multisample(
        glw::GL_TEXTURE_2D_MULTISAMPLE,
        4,
        internalformat,
        K_SIZE,
        K_SIZE,
        glw::FALSE
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, 0));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, textures[1]));
    gl!(gl.tex_image_3d_multisample(
        glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY,
        4,
        internalformat,
        K_SIZE,
        K_SIZE,
        2,
        glw::FALSE
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, 0));

    gl!(gl.bind_image_texture(1, textures[0], 0, glw::FALSE, 0, glw::GL_WRITE_ONLY, internalformat));
    gl!(gl.bind_image_texture(4, textures[1], 0, glw::TRUE, 0, glw::GL_WRITE_ONLY, internalformat));

    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
    gl!(gl.use_program(program));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_2dms"), 1));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_2dms_array"), 4));
    gl!(gl.bind_vertex_array(vao));
    gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

    let mut status = true;
    gl!(gl.active_texture(glw::GL_TEXTURE0));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE, textures[0]));
    gl!(gl.active_texture(glw::GL_TEXTURE1));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY, textures[1]));
    gl!(gl.use_program(val_program));
    gl!(gl.uniform_1i(uniform_location(gl, val_program, "g_sampler_2dms"), 0));
    gl!(gl.uniform_1i(uniform_location(gl, val_program, "g_sampler_2dms_array"), 1));
    gl!(gl.bind_vertex_array(vao));
    gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
    gl!(gl.memory_barrier(glw::GL_SHADER_IMAGE_ACCESS_BARRIER_BIT));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

    if !validate_read_buffer(context, 0, 0, K_SIZE, K_SIZE, &[0.0, 1.0, 0.0, 1.0]) {
        status = false;
        log::info!("GL_TEXTURE_2D_MULTISAMPLE or GL_TEXTURE_2D_MULTISAMPLE_ARRAY target failed.");
    }

    gl!(gl.active_texture(glw::GL_TEXTURE0));
    gl!(gl.delete_textures(2, textures.as_ptr()));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    gl!(gl.delete_program(val_program));
    status
}

/// `WriteCubeArray<T>`
fn write_cube_array<T: Texel>(
    gl: &glw::Functions,
    vao: GLuint,
    internalformat: GLenum,
    write_value: &T4<T>,
    expected_value: &T4<T>,
) -> bool {
    let program = build_program(
        gl,
        Some(SIMPLE_VS),
        Some(&gen_fs_cube_array(internalformat, write_value)),
    );
    let mut texture: GLuint = 0;
    gl!(gl.gen_textures(1, &mut texture));
    const K_SIZE: i32 = 16;
    let k = K_SIZE as usize;
    let mut data = vec![[T::default(); 4]; k * k * 12];
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, texture));
    gl!(gl.tex_parameteri(
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        glw::GL_TEXTURE_MIN_FILTER,
        glw::GL_LINEAR as GLint
    ));
    gl!(gl.tex_image_3d(
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        0,
        internalformat as GLint,
        K_SIZE,
        K_SIZE,
        12,
        0,
        T::format(),
        T::type_(),
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0));

    gl!(gl.bind_image_texture(0, texture, 0, glw::TRUE, 0, glw::GL_WRITE_ONLY, internalformat));
    gl!(gl.use_program(program));
    gl!(gl.bind_vertex_array(vao));
    gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

    data.fill([T::default(); 4]);
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, texture));
    gl!(gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT));
    gl!(gl.get_tex_image(
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        0,
        T::format(),
        T::type_(),
        data.as_mut_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0));
    let status = all_equal(&data, k * k * 12, expected_value, "GL_TEXTURE_CUBE_MAP_ARRAY");

    gl!(gl.delete_textures(1, &texture));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    status
}

/// 1.3.1 BasicAllTargetsStore
#[derive(Default)]
pub(super) struct BasicAllTargetsStore {
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for BasicAllTargetsStore {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        let (f, i, u): (Vec4, IVec4, UVec4) = ([-1.0, 2.0, 3.0, -4.0], [1, -2, 3, -4], [1, 2, 3, 4]);
        let vao = self.vao;
        if !write::<f32>(gl, vao, glw::GL_RGBA32F, &f, &f)
            || !write::<i32>(gl, vao, glw::GL_RGBA32I, &i, &i)
            || !write::<u32>(gl, vao, glw::GL_RGBA32UI, &u, &u)
        {
            return Ok(ERROR);
        }
        if !write_cube_array::<f32>(gl, vao, glw::GL_RGBA32F, &f, &f)
            || !write_cube_array::<i32>(gl, vao, glw::GL_RGBA32I, &i, &i)
            || !write_cube_array::<u32>(gl, vao, glw::GL_RGBA32UI, &u, &u)
        {
            return Ok(ERROR);
        }
        if supported_samples(gl, 4) {
            if !write_ms::<f32>(context, vao, glw::GL_RGBA32F, &f, &f) {
                return Ok(ERROR);
            }
            let isamples = get_integer(gl, glw::GL_MAX_INTEGER_SAMPLES);
            if isamples >= 4
                && (!write_ms::<i32>(context, vao, glw::GL_RGBA32I, &i, &i)
                    || !write_ms::<u32>(context, vao, glw::GL_RGBA32UI, &u, &u))
            {
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
