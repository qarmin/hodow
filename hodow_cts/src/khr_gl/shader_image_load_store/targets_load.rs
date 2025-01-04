// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (BasicAllTargetsLoadNonMS, BasicAllTargetsLoadMS)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `Read<T>`, `ReadCube<T>` and `ReadMS<T>` are generic over `Texel`; the `GenFS*` shader generators build the repeated `imageLoad` checks in loops. Written without compiling.

use super::base::*;
use super::formats::vec_to_glsl;
use super::targets_store::SIMPLE_VS;
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, NOT_SUPPORTED, Subcase, SubcaseResult};

fn set_nearest(gl: &glw::Functions, target: GLenum) {
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
}

/// The `GL_ACTIVE_UNIFORMS` count check, the name to index map and the `CheckUniform` calls shared by the three read helpers; `expected` is (name, texture target) for every image uniform, `count` the active uniforms the program should report.
fn check_image_uniforms<T: Texel>(
    gl: &glw::Functions,
    program: GLuint,
    count: GLint,
    expected: &[(&str, GLenum)],
) -> bool {
    let mut status = true;
    let mut uniforms: GLint = 0;
    gl!(gl.get_programiv(program, glw::GL_ACTIVE_UNIFORMS, &mut uniforms));
    if uniforms != count {
        status = false;
        log::info!("ACTIVE_UNIFORMS is {uniforms} should be {count}.");
    }
    let mut name_index_map = std::collections::BTreeMap::new();
    for index in 0..uniforms as GLuint {
        let mut name = [0u8; 32];
        gl!(gl.get_active_uniform_name(
            program,
            index,
            name.len() as glw::GLsizei,
            std::ptr::null_mut(),
            name.as_mut_ptr().cast()
        ));
        let end = name.iter().position(|&byte| byte == 0).unwrap_or(name.len());
        name_index_map.insert(String::from_utf8_lossy(&name[..end]).into_owned(), index);
    }
    for (name, target) in expected {
        let Some(&index) = name_index_map.get(*name) else {
            status = false;
            continue;
        };
        if !check_uniform(gl, program, name, index, 1, T::image_type(*target)) {
            status = false;
        }
    }
    status
}

/// `GenFS` of BasicAllTargetsLoadNonMS
fn gen_fs<T: Texel>(internalformat: GLenum, expected_value: &[T; 4]) -> String {
    let format = format_enum_to_string(internalformat);
    let prefix = T::type_prefix();
    let vec = format!("{prefix}vec4{}", vec_to_glsl(expected_value));
    let mut os = String::from("#version 420 core\nlayout(location = 0) out vec4 o_color;");
    for (type_name, name) in [
        ("image1D", "g_image_1d"),
        ("image2D", "g_image_2d"),
        ("image3D", "g_image_3d"),
        ("image2DRect", "g_image_2drect"),
        ("imageBuffer", "g_image_buffer"),
        ("image1DArray", "g_image_1darray"),
        ("image2DArray", "g_image_2darray"),
    ] {
        os.push_str(&format!(
            "\nlayout({format}) readonly uniform {prefix}{type_name} {name};"
        ));
    }
    os.push_str(&format!("\nvoid main() {{\n  o_color = vec4(0.0, 1.0, 0.0, 1.0);\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  {prefix}vec4 v;"));
    for (load, alpha) in [
        ("imageLoad(g_image_1d, coord.x)", "0.05"),
        ("imageLoad(g_image_2d, coord)", "0.1"),
        ("imageLoad(g_image_3d, ivec3(coord.xy, 0))", "0.15"),
        ("imageLoad(g_image_3d, ivec3(coord.xy, 1))", "0.2"),
        ("imageLoad(g_image_2drect, coord)", "0.25"),
        ("imageLoad(g_image_buffer, coord.x)", "0.6"),
        ("imageLoad(g_image_1darray, ivec2(coord.x, 0))", "0.65"),
        ("imageLoad(g_image_1darray, ivec2(coord.x, 1))", "0.7"),
        ("imageLoad(g_image_2darray, ivec3(coord, 0))", "0.75"),
        ("imageLoad(g_image_2darray, ivec3(coord, 1))", "0.8"),
    ] {
        os.push_str(&format!(
            "\n  v = {load};\n  if (v != {vec}) o_color = vec4(1.0, 0.0, 0.0, {alpha});"
        ));
    }
    os.push_str("\n}");
    os
}

/// `GenFSCube`
fn gen_fs_cube<T: Texel>(internalformat: GLenum, expected_value: &[T; 4]) -> String {
    let format = format_enum_to_string(internalformat);
    let prefix = T::type_prefix();
    let vec = format!("{prefix}vec4{}", vec_to_glsl(expected_value));
    let mut os = format!(
        "#version 420 core\nlayout(location = 0) out vec4 o_color;\nlayout({format}) readonly uniform {prefix}imageCube g_image_cube;\nlayout({format}) readonly uniform {prefix}imageCubeArray g_image_cube_array;\nvoid main() {{\n  o_color = vec4(0.0, 1.0, 0.0, 1.0);\n  ivec2 coord = ivec2(gl_FragCoord.xy);\n  {prefix}vec4 v;"
    );
    for face in 0..6 {
        let alpha = ["0.3", "0.35", "0.4", "0.45", "0.5", "0.55"][face];
        os.push_str(&format!("\n  v = imageLoad(g_image_cube, ivec3(coord, {face}));\n  if (v != {vec}) o_color = vec4(1.0, 0.0, 0.0, {alpha});"));
    }
    for layer in 0..12 {
        let alpha = [
            "0.05", "0.1", "0.15", "0.2", "0.25", "0.3", "0.35", "0.4", "0.45", "0.5", "0.55", "0.6",
        ][layer];
        os.push_str(&format!("\n  v = imageLoad(g_image_cube_array, ivec3(coord, {layer}));\n  if (v != {vec}) o_color = vec4(1.0, 0.0, 0.0, {alpha});"));
    }
    os.push_str("\n}");
    os
}

/// `GenFSMS` of BasicAllTargetsLoadMS
fn gen_fs_ms<T: Texel>(internalformat: GLenum, expected_value: &[T; 4]) -> String {
    let format = format_enum_to_string(internalformat);
    let prefix = T::type_prefix();
    let vec = format!("{prefix}vec4{}", vec_to_glsl(expected_value));
    let mut os = format!(
        "#version 420 core\nlayout(location = 0) out vec4 o_color;\nlayout({format}) readonly uniform {prefix}image2DMS g_image_2dms;\nlayout({format}) readonly uniform {prefix}image2DMSArray g_image_2dms_array;\nvoid main() {{\n  o_color = vec4(0.0, 1.0, 0.0, 1.0);\n  ivec2 coord = ivec2(gl_FragCoord.xy);"
    );
    for sample in 0..4 {
        os.push_str(&format!(
            "\n  if (imageLoad(g_image_2dms, coord, {sample}) != {vec}) o_color = vec4(1.0, 0.0, 0.0, 0.1);"
        ));
    }
    for (layer, alpha) in [(0, "0.2"), (1, "0.3")] {
        for sample in 0..4 {
            os.push_str(&format!("\n  if (imageLoad(g_image_2dms_array, ivec3(coord, {layer}), {sample}) != {vec}) o_color = vec4(1.0, 0.0, 0.0, {alpha});"));
        }
    }
    os.push_str("\n}");
    os
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
    let program = build_program(gl, Some(SIMPLE_VS), Some(&gen_fs(internalformat, expected_value)));
    let mut textures = [0 as GLuint; 7];
    let mut buffer: GLuint = 0;
    gl!(gl.gen_textures(7, textures.as_mut_ptr()));
    gl!(gl.gen_buffers(1, &mut buffer));
    const K_SIZE: i32 = 16;
    let k = K_SIZE as usize;
    let data = vec![*value; k * k * 2];
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

    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, buffer));
    gl!(gl.buffer_data(
        glw::GL_TEXTURE_BUFFER,
        (k * std::mem::size_of::<[T; 4]>()) as isize,
        data.as_ptr().cast(),
        glw::GL_DYNAMIC_DRAW
    ));
    gl!(gl.bind_buffer(glw::GL_TEXTURE_BUFFER, 0));
    gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, textures[4]));
    gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, internalformat, buffer));
    gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, 0));

    gl!(gl.bind_texture(glw::GL_TEXTURE_1D_ARRAY, textures[5]));
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

    gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, textures[6]));
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
        (4, glw::FALSE),
        (5, glw::TRUE),
        (6, glw::TRUE),
    ] {
        gl!(gl.bind_image_texture(
            unit,
            textures[unit as usize],
            0,
            layered,
            0,
            glw::GL_READ_ONLY,
            internalformat
        ));
    }

    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
    gl!(gl.use_program(program));
    for (unit, name) in [
        "g_image_1d",
        "g_image_2d",
        "g_image_3d",
        "g_image_2drect",
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
    if !validate_read_buffer(context, 0, 0, K_SIZE, K_SIZE, &[0.0, 1.0, 0.0, 1.0]) {
        status = false;
    }
    let expected = [
        ("g_image_1d", glw::GL_TEXTURE_1D),
        ("g_image_2d", glw::GL_TEXTURE_2D),
        ("g_image_3d", glw::GL_TEXTURE_3D),
        ("g_image_2drect", glw::GL_TEXTURE_RECTANGLE),
        ("g_image_buffer", glw::GL_TEXTURE_BUFFER),
        ("g_image_1darray", glw::GL_TEXTURE_1D_ARRAY),
        ("g_image_2darray", glw::GL_TEXTURE_2D_ARRAY),
    ];
    if !check_image_uniforms::<T>(gl, program, 7, &expected) {
        status = false;
    }

    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    gl!(gl.delete_textures(7, textures.as_ptr()));
    gl!(gl.delete_buffers(1, &buffer));
    status
}

/// `ReadCube<T>`
fn read_cube<T: Texel>(
    context: &Context,
    vao: GLuint,
    internalformat: GLenum,
    value: &[T; 4],
    expected_value: &[T; 4],
) -> bool {
    let gl = context.gl();
    let program = build_program(gl, Some(SIMPLE_VS), Some(&gen_fs_cube(internalformat, expected_value)));
    let mut textures = [0 as GLuint; 2];
    gl!(gl.gen_textures(2, textures.as_mut_ptr()));
    const K_SIZE: i32 = 16;
    let k = K_SIZE as usize;
    let data = vec![*value; k * k * 12];
    let internal = internalformat as GLint;

    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, textures[0]));
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
            T::format(),
            T::type_(),
            data.as_ptr().cast()
        ));
    }
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0));

    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, textures[1]));
    set_nearest(gl, glw::GL_TEXTURE_CUBE_MAP_ARRAY);
    gl!(gl.tex_image_3d(
        glw::GL_TEXTURE_CUBE_MAP_ARRAY,
        0,
        internal,
        K_SIZE,
        K_SIZE,
        12,
        0,
        T::format(),
        T::type_(),
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0));

    gl!(gl.bind_image_texture(0, textures[0], 0, glw::TRUE, 0, glw::GL_READ_ONLY, internalformat));
    gl!(gl.bind_image_texture(1, textures[1], 0, glw::TRUE, 0, glw::GL_READ_ONLY, internalformat));

    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
    gl!(gl.use_program(program));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_cube"), 0));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_cube_array"), 1));
    gl!(gl.bind_vertex_array(vao));
    gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

    let mut status = true;
    if !validate_read_buffer(context, 0, 0, K_SIZE, K_SIZE, &[0.0, 1.0, 0.0, 1.0]) {
        status = false;
    }
    if !check_image_uniforms::<T>(
        gl,
        program,
        2,
        &[
            ("g_image_cube", glw::GL_TEXTURE_CUBE_MAP),
            ("g_image_cube_array", glw::GL_TEXTURE_CUBE_MAP_ARRAY),
        ],
    ) {
        status = false;
    }

    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    gl!(gl.delete_textures(2, textures.as_ptr()));
    status
}

/// `ReadMS<T>`
fn read_ms<T: Texel>(
    context: &Context,
    vao: GLuint,
    internalformat: GLenum,
    value: &[T; 4],
    expected_value: &[T; 4],
) -> bool {
    let gl = context.gl();
    let program = build_program(gl, Some(SIMPLE_VS), Some(&gen_fs_ms(internalformat, expected_value)));
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

    let mut fbo: GLuint = 0;
    gl!(gl.gen_framebuffers(1, &mut fbo));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
    gl!(gl.framebuffer_texture_2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_TEXTURE_2D_MULTISAMPLE,
        textures[0],
        0
    ));
    gl!(gl.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT1, textures[1], 0, 0));
    gl!(gl.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT2, textures[1], 0, 1));
    let draw_buffers: [GLenum; 3] = [
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_COLOR_ATTACHMENT1,
        glw::GL_COLOR_ATTACHMENT2,
    ];
    gl!(gl.draw_buffers(3, draw_buffers.as_ptr()));
    for drawbuffer in 0..3 {
        T::clear_buffer(gl, glw::GL_COLOR, drawbuffer, value);
    }
    gl!(gl.delete_framebuffers(1, &fbo));

    gl!(gl.bind_image_texture(1, textures[0], 0, glw::FALSE, 0, glw::GL_READ_ONLY, internalformat));
    gl!(gl.bind_image_texture(4, textures[1], 0, glw::TRUE, 0, glw::GL_READ_ONLY, internalformat));

    gl!(gl.use_program(program));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_2dms"), 1));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_2dms_array"), 4));
    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
    gl!(gl.bind_vertex_array(vao));
    gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

    let mut status = true;
    if !validate_read_buffer(context, 0, 0, K_SIZE, K_SIZE, &[0.0, 1.0, 0.0, 1.0]) {
        status = false;
    }
    if !check_image_uniforms::<T>(
        gl,
        program,
        2,
        &[
            ("g_image_2dms", glw::GL_TEXTURE_2D_MULTISAMPLE),
            ("g_image_2dms_array", glw::GL_TEXTURE_2D_MULTISAMPLE_ARRAY),
        ],
    ) {
        status = false;
    }

    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    gl!(gl.delete_textures(2, textures.as_ptr()));
    status
}

/// 1.3.2.1 BasicAllTargetsLoadNonMS
#[derive(Default)]
pub(super) struct BasicAllTargetsLoadNonMs {
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for BasicAllTargetsLoadNonMs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        let vao = self.vao;
        let (f, i, u): (Vec4, IVec4, UVec4) = ([-1.0, 10.0, -200.0, 3000.0], [-1, 10, -200, 3000], [1, 10, 200, 3000]);
        if !read::<f32>(context, vao, glw::GL_RGBA32F, &f, &f)
            || !read::<i32>(context, vao, glw::GL_RGBA32I, &i, &i)
            || !read::<u32>(context, vao, glw::GL_RGBA32UI, &u, &u)
        {
            return Ok(ERROR);
        }
        if !read_cube::<f32>(context, vao, glw::GL_RGBA32F, &f, &f)
            || !read_cube::<i32>(context, vao, glw::GL_RGBA32I, &i, &i)
            || !read_cube::<u32>(context, vao, glw::GL_RGBA32UI, &u, &u)
        {
            return Ok(ERROR);
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

/// 1.3.2.2 BasicAllTargetsLoadMS
#[derive(Default)]
pub(super) struct BasicAllTargetsLoadMs {
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for BasicAllTargetsLoadMs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !supported_samples(gl, 4) {
            return Ok(NOT_SUPPORTED);
        }
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        let vao = self.vao;
        let f: Vec4 = [-1.0, 10.0, -200.0, 3000.0];
        if !read_ms::<f32>(context, vao, glw::GL_RGBA32F, &f, &f) {
            return Ok(ERROR);
        }
        let isamples = get_integer(gl, glw::GL_MAX_INTEGER_SAMPLES);
        if isamples >= 4 {
            let (i, u): (IVec4, UVec4) = ([1, -2, 3, -4], [1, 2, 3, 4]);
            if !read_ms::<i32>(context, vao, glw::GL_RGBA32I, &i, &i)
                || !read_ms::<u32>(context, vao, glw::GL_RGBA32UI, &u, &u)
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
