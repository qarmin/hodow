// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderImageLoadStoreTests.cpp  (BasicAllTargetsAtomic)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `Atomic<T>`, `AtomicCube<T>` and `AtomicMS<T>` are generic over the scalar `AtomicTexel` (GLint, GLuint); the `GenFS*` generators repeat one nine-line atomic sequence per image. Written without compiling.

use super::base::*;
use super::targets_store::SIMPLE_VS;
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult};

/// `Format<GLint>`, `Type<GLint>`, `TypePrefix<GLint>` and the clear of `AtomicMS` for GLint and GLuint.
pub(super) trait AtomicTexel: Copy + Default {
    fn type_() -> GLenum;
    fn prefix() -> &'static str;
    fn clear_zero(gl: &glw::Functions, drawbuffer: GLint);
}

impl AtomicTexel for i32 {
    fn type_() -> GLenum {
        glw::GL_INT
    }
    fn prefix() -> &'static str {
        "i"
    }
    fn clear_zero(gl: &glw::Functions, drawbuffer: GLint) {
        let value = [0 as GLint; 4];
        gl!(gl.clear_bufferiv(glw::GL_COLOR, drawbuffer, value.as_ptr()));
    }
}

impl AtomicTexel for u32 {
    fn type_() -> GLenum {
        glw::GL_UNSIGNED_INT
    }
    fn prefix() -> &'static str {
        "u"
    }
    fn clear_zero(gl: &glw::Functions, drawbuffer: GLint) {
        let value = [0 as GLuint; 4];
        gl!(gl.clear_bufferuiv(glw::GL_COLOR, drawbuffer, value.as_ptr()));
    }
}

fn set_nearest(gl: &glw::Functions, target: GLenum) {
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    gl!(gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
}

/// The nine atomic calls the generators repeat for one image: `image` and its coordinate expression, with an optional sample argument.
fn atomic_sequence(image: &str, coord: &str, sample: Option<&str>) -> String {
    let sample = sample.map(|sample| format!(", {sample}")).unwrap_or_default();
    let mut os = String::new();
    for (op, args, expected) in [
        ("Add", "2", 0),
        ("Min", "3", 2),
        ("Max", "4", 2),
        ("And", "0", 4),
        ("Or", "7", 0),
        ("Xor", "4", 7),
        ("Exchange", "1", 3),
        ("CompSwap", "1, 6", 1),
        ("Exchange", "0", 6),
    ] {
        os.push_str(&format!("\n  if (imageAtomic{op}({image}, {coord}{sample}, {args}) != {expected}) o_color = vec4(1.0, 0.0, 0.0, 1.0);"));
    }
    os
}

/// `GenFS<T>`
fn gen_fs<T: AtomicTexel>(internalformat: GLenum) -> String {
    let format = format_enum_to_string(internalformat);
    let prefix = T::prefix();
    let images = [
        ("image1D", "g_image_1d", "coord.x"),
        ("image2D", "g_image_2d", "coord"),
        ("image3D", "g_image_3d", "ivec3(coord, 0)"),
        ("image2DRect", "g_image_2drect", "coord"),
        ("imageBuffer", "g_image_buffer", "coord.x"),
        ("image1DArray", "g_image_1darray", "ivec2(coord.x, 0)"),
        ("image2DArray", "g_image_2darray", "ivec3(coord, 0)"),
    ];
    let mut os = String::from("#version 420 core\nlayout(location = 0) out vec4 o_color;");
    for (type_name, name, _) in images {
        os.push_str(&format!(
            "\nlayout({format}) coherent uniform {prefix}{type_name} {name};"
        ));
    }
    os.push_str("\nvoid main() {\n  o_color = vec4(0.0, 1.0, 0.0, 1.0);\n  ivec2 coord = ivec2(gl_FragCoord.xy);");
    for (_, name, coord) in images {
        os.push_str(&atomic_sequence(name, coord, None));
    }
    os.push_str("\n}");
    os
}

/// `GenFSCube<T>`
fn gen_fs_cube<T: AtomicTexel>(internalformat: GLenum) -> String {
    let format = format_enum_to_string(internalformat);
    let prefix = T::prefix();
    let mut os = format!(
        "#version 420 core\nlayout(location = 0) out vec4 o_color;\nlayout({format}) coherent uniform {prefix}imageCube g_image_cube;\nlayout({format}) coherent uniform {prefix}imageCubeArray g_image_cube_array;\nvoid main() {{\n  o_color = vec4(0.0, 1.0, 0.0, 1.0);\n  ivec2 coord = ivec2(gl_FragCoord.xy);"
    );
    os.push_str(&atomic_sequence("g_image_cube", "ivec3(coord, 0)", None));
    os.push_str(&atomic_sequence("g_image_cube_array", "ivec3(coord, 0)", None));
    os.push_str("\n}");
    os
}

/// `GenFSMS<T>`
fn gen_fs_ms<T: AtomicTexel>(internalformat: GLenum) -> String {
    let format = format_enum_to_string(internalformat);
    let prefix = T::prefix();
    let mut os = format!(
        "#version 420 core\nlayout(location = 0) out vec4 o_color;\nlayout({format}) coherent uniform {prefix}image2DMS g_image_2dms;\nlayout({format}) coherent uniform {prefix}image2DMSArray g_image_2dms_array;\nvoid main() {{\n  o_color = vec4(0.0, 1.0, 0.0, 1.0);\n  ivec2 coord = ivec2(gl_FragCoord.xy);"
    );
    os.push_str(&atomic_sequence("g_image_2dms", "coord", Some("1")));
    os.push('\n');
    os.push_str(&atomic_sequence("g_image_2dms_array", "ivec3(coord, 1)", Some("1")));
    os.push_str("\n}");
    os
}

/// `Atomic<T>`
fn atomic<T: AtomicTexel>(context: &Context, vao: GLuint, internalformat: GLenum) -> bool {
    let gl = context.gl();
    let program = build_program(gl, Some(SIMPLE_VS), Some(&gen_fs::<T>(internalformat)));
    let mut textures = [0 as GLuint; 7];
    let mut buffer: GLuint = 0;
    gl!(gl.gen_textures(7, textures.as_mut_ptr()));
    gl!(gl.gen_buffers(1, &mut buffer));
    const K_SIZE: i32 = 16;
    let k = K_SIZE as usize;
    let data = vec![T::default(); k * k * 2];
    let (format, type_) = (glw::GL_RED_INTEGER, T::type_());
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
        (k * std::mem::size_of::<T>()) as isize,
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
            glw::GL_READ_WRITE,
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
    gl!(gl.viewport(0, 0, K_SIZE, 1));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

    let status = validate_read_buffer(context, 0, 0, K_SIZE, 1, &[0.0, 1.0, 0.0, 1.0]);

    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    gl!(gl.delete_textures(7, textures.as_ptr()));
    gl!(gl.delete_buffers(1, &buffer));
    status
}

/// `AtomicCube<T>`
fn atomic_cube<T: AtomicTexel>(context: &Context, vao: GLuint, internalformat: GLenum) -> bool {
    let gl = context.gl();
    let program = build_program(gl, Some(SIMPLE_VS), Some(&gen_fs_cube::<T>(internalformat)));
    let mut textures = [0 as GLuint; 2];
    gl!(gl.gen_textures(2, textures.as_mut_ptr()));
    const K_SIZE: i32 = 16;
    let k = K_SIZE as usize;
    let data = vec![T::default(); k * k * 12];
    let (format, type_) = (glw::GL_RED_INTEGER, T::type_());
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
            format,
            type_,
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
        format,
        type_,
        data.as_ptr().cast()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0));

    gl!(gl.bind_image_texture(0, textures[0], 0, glw::TRUE, 0, glw::GL_READ_WRITE, internalformat));
    gl!(gl.bind_image_texture(1, textures[1], 0, glw::TRUE, 0, glw::GL_READ_WRITE, internalformat));

    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
    gl!(gl.use_program(program));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_cube"), 0));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_cube_array"), 1));
    gl!(gl.bind_vertex_array(vao));
    gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

    let status = validate_read_buffer(context, 0, 0, K_SIZE, K_SIZE, &[0.0, 1.0, 0.0, 1.0]);

    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    gl!(gl.delete_textures(2, textures.as_ptr()));
    status
}

/// `AtomicMS<T>`
fn atomic_ms<T: AtomicTexel>(context: &Context, vao: GLuint, internalformat: GLenum) -> bool {
    let gl = context.gl();
    let program = build_program(gl, Some(SIMPLE_VS), Some(&gen_fs_ms::<T>(internalformat)));
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
        T::clear_zero(gl, drawbuffer);
    }
    gl!(gl.delete_framebuffers(1, &fbo));

    gl!(gl.bind_image_texture(1, textures[0], 0, glw::FALSE, 0, glw::GL_READ_WRITE, internalformat));
    gl!(gl.bind_image_texture(4, textures[1], 0, glw::TRUE, 0, glw::GL_READ_WRITE, internalformat));

    gl!(gl.use_program(program));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_2dms"), 1));
    gl!(gl.uniform_1i(uniform_location(gl, program, "g_image_2dms_array"), 4));
    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
    gl!(gl.bind_vertex_array(vao));
    gl!(gl.viewport(0, 0, K_SIZE, K_SIZE));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

    let status = validate_read_buffer(context, 0, 0, K_SIZE, K_SIZE, &[0.0, 1.0, 0.0, 1.0]);

    gl!(gl.delete_textures(2, textures.as_ptr()));
    gl!(gl.use_program(0));
    gl!(gl.delete_program(program));
    status
}

/// 1.3.3 BasicAllTargetsAtomic
#[derive(Default)]
pub(super) struct BasicAllTargetsAtomic {
    vao: GLuint,
    vbo: GLuint,
}

impl Subcase for BasicAllTargetsAtomic {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        create_full_viewport_quad(gl, &mut self.vao, &mut self.vbo, None);
        let vao = self.vao;
        if !atomic::<i32>(context, vao, glw::GL_R32I) || !atomic::<u32>(context, vao, glw::GL_R32UI) {
            return Ok(ERROR);
        }
        if !atomic_cube::<i32>(context, vao, glw::GL_R32I) || !atomic_cube::<u32>(context, vao, glw::GL_R32UI) {
            return Ok(ERROR);
        }
        let isamples = get_integer(gl, glw::GL_MAX_INTEGER_SAMPLES);
        if supported_samples(gl, 4)
            && isamples >= 4
            && (!atomic_ms::<i32>(context, vao, glw::GL_R32I) || !atomic_ms::<u32>(context, vao, glw::GL_R32UI))
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
