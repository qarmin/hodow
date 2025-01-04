// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ShaderStorageBufferObjectBase` is this module's free functions (each takes the `Context` the C++ class reaches through `m_context`); the log messages that upstream writes with `tcu::TestLog` go through `log::info!`.

use std::ffi::c_void;

use super::super::subcase::output_not_supported;
use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLsizeiptr, GLuint};

pub(super) const GLSL_VER: &str = "#version 310 es\nprecision highp float;\nprecision highp int;";

pub(super) type Vec3 = [f32; 3];

pub(super) const FS_GREEN: &str =
    "\nlayout(location = 0) out vec4 o_color;\nvoid main() {\n  o_color = vec4(0.0, 1.0, 0.0, 1.0);\n}";

/// `kGLSLVer` and the body as the two source strings of `glShaderSource`.
pub(super) fn shader_source(gl: &glw::Functions, shader: GLuint, body: &str) {
    let parts = [GLSL_VER, body];
    let pointers = [
        parts[0].as_ptr().cast::<glw::GLchar>(),
        parts[1].as_ptr().cast::<glw::GLchar>(),
    ];
    let lengths = [parts[0].len() as GLint, parts[1].len() as GLint];
    gl!(gl.shader_source(shader, 2, pointers.as_ptr(), lengths.as_ptr()));
}

/// `IsVSFSAvailable`
pub(super) fn is_vsfs_available(gl: &glw::Functions, required_vs: i32, required_fs: i32) -> bool {
    let blocks_vs = get_integer(gl, glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS);
    let blocks_fs = get_integer(gl, glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS);
    if blocks_vs >= required_vs && blocks_fs >= required_fs {
        return true;
    }
    output_not_supported(&format!(
        "Required {required_vs} VS storage blocks but only {blocks_vs} available.\nRequired {required_fs} FS storage blocks but only {blocks_fs} available.\n"
    ));
    false
}

pub(super) fn get_integer(gl: &glw::Functions, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_integerv(pname, &mut value));
    value
}

fn get_program_value(gl: &glw::Functions, program: GLuint, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_programiv(program, pname, &mut value));
    value
}

/// `CheckProgram`
pub(super) fn check_program(gl: &glw::Functions, program: GLuint) -> bool {
    let status = get_program_value(gl, program, glw::GL_LINK_STATUS);
    if status == glw::GL_FALSE as GLint {
        let attached_shaders = get_program_value(gl, program, glw::GL_ATTACHED_SHADERS);
        if attached_shaders > 0 {
            let mut shaders = vec![0 as GLuint; attached_shaders as usize];
            gl!(gl.get_attached_shaders(program, attached_shaders, std::ptr::null_mut(), shaders.as_mut_ptr()));
            for &shader in &shaders {
                let mut shader_type: GLint = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_TYPE, &mut shader_type));
                log::info!(
                    "*** {} Shader ***",
                    match shader_type as GLenum {
                        glw::GL_VERTEX_SHADER => "Vertex",
                        glw::GL_FRAGMENT_SHADER => "Fragment",
                        _ => "Unknown",
                    }
                );
                let mut length: GLint = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_SOURCE_LENGTH, &mut length));
                if length > 0 {
                    let mut source = vec![0u8; length as usize];
                    gl!(gl.get_shader_source(shader, length, std::ptr::null_mut(), source.as_mut_ptr().cast()));
                    log::info!("{}", String::from_utf8_lossy(&source));
                }
                gl!(gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut length));
                if length > 0 {
                    let mut info_log = vec![0u8; length as usize];
                    gl!(gl.get_shader_info_log(shader, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
                    log::info!("{}", String::from_utf8_lossy(&info_log));
                }
            }
        }
        let length = get_program_value(gl, program, glw::GL_INFO_LOG_LENGTH);
        if length > 0 {
            let mut info_log = vec![0u8; length as usize];
            gl!(gl.get_program_info_log(program, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
            log::info!("{}", String::from_utf8_lossy(&info_log));
        }
    }
    status == glw::GL_TRUE as GLint
}

fn attach_compiled(gl: &glw::Functions, program: GLuint, shader_type: GLenum, body: &str) {
    let shader = gl!(gl.create_shader(shader_type));
    gl!(gl.attach_shader(program, shader));
    gl!(gl.delete_shader(shader));
    shader_source(gl, shader, body);
    gl!(gl.compile_shader(shader));
}

/// `CreateProgram`
pub(super) fn create_program(gl: &glw::Functions, vs: &str, fs: &str) -> GLuint {
    let program = gl!(gl.create_program());
    if !vs.is_empty() {
        attach_compiled(gl, program, glw::GL_VERTEX_SHADER, vs);
    }
    if !fs.is_empty() {
        attach_compiled(gl, program, glw::GL_FRAGMENT_SHADER, fs);
    }
    program
}

/// `CreateProgramCS`
pub(super) fn create_program_cs(gl: &glw::Functions, cs: &str) -> GLuint {
    let program = gl!(gl.create_program());
    if !cs.is_empty() {
        attach_compiled(gl, program, glw::GL_COMPUTE_SHADER, cs);
    }
    program
}

/// `BuildShaderProgram`
pub(super) fn build_shader_program(gl: &glw::Functions, shader_type: GLenum, source: &str) -> GLuint {
    let parts = [GLSL_VER, source];
    let sources: Vec<std::ffi::CString> = parts
        .iter()
        .map(|part| std::ffi::CString::new(*part).expect("shader sources hold no NUL"))
        .collect();
    let pointers: Vec<*const glw::GLchar> = sources.iter().map(|part| part.as_ptr()).collect();
    gl!(gl.create_shader_programv(shader_type, 2, pointers.as_ptr()))
}

fn color_eps(context: &Context) -> Vec3 {
    let target = context.render_target();
    [
        1.0 / (1u32 << target.red_bits) as f32,
        1.0 / (1u32 << target.green_bits) as f32,
        1.0 / (1u32 << target.blue_bits) as f32,
    ]
}

/// `ColorEqual`
fn color_equal(x: i32, y: i32, c0: Vec3, expected: Vec3, epsilon: Vec3, color_max: Vec3) -> bool {
    let status = (0..3).all(|k| (c0[k] / color_max[k] - expected[k]).abs() <= epsilon[k]);
    if !status {
        log::info!(
            "Incorrect framebuffer color at pixel ({x} {y}). Color is ({} {} {}). Color should be ({} {} {}).",
            c0[0] / color_max[0],
            c0[1] / color_max[1],
            c0[2] / color_max[2],
            expected[0],
            expected[1],
            expected[2]
        );
    }
    status
}

/// `CheckFB`
pub(super) fn check_fb(context: &Context, expected: Vec3) -> bool {
    let gl = context.gl();
    let target = context.render_target();
    let eps = color_eps(context);
    let max = 255.0f32;
    let (fb_w, fb_h) = (target.width, target.height);
    let mut fb = vec![0u8; (fb_w * fb_h * 4) as usize];
    gl!(gl.read_pixels(
        0,
        0,
        fb_w,
        fb_h,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        fb.as_mut_ptr().cast()
    ));
    let mut i = 0usize;
    for y in 0..fb_h {
        for x in 0..fb_w {
            if (0..3).any(|k| (fb[i + k] as f32 / max - expected[k]).abs() > eps[k]) {
                log::info!(
                    "Incorrect framebuffer color at pixel ({x} {y}). Color is ({} {} {}). Color should be ({} {} {}).",
                    fb[i] as f32 / max,
                    fb[i + 1] as f32 / max,
                    fb[i + 2] as f32 / max,
                    expected[0],
                    expected[1],
                    expected[2]
                );
                return false;
            }
            i += 4;
        }
    }
    true
}

/// `ValidateWindow4Quads`
pub(super) fn validate_window_4_quads(
    context: &Context,
    lb: Vec3,
    rb: Vec3,
    rt: Vec3,
    lt: Vec3,
    bad_pixels: Option<&mut i32>,
) -> bool {
    let gl = context.gl();
    let eps = color_eps(context);
    let color_max = [255.0f32; 3];

    let width = 100i32;
    let height = 100i32;
    let mut fb = vec![0u8; (width * height * 4) as usize];
    gl!(gl.read_pixels(
        0,
        0,
        width,
        height,
        glw::GL_RGBA,
        glw::GL_UNSIGNED_BYTE,
        fb.as_mut_ptr().cast()
    ));

    let pixel = |i: i32| -> Vec3 {
        [
            fb[i as usize] as f32,
            fb[i as usize + 1] as f32,
            fb[i as usize + 2] as f32,
        ]
    };
    let mut status = true;
    let mut bad = 0;

    // (name, first y, last y exclusive, first x, last x exclusive, initial i, colour)
    let quads = [
        (
            "Left-bottom",
            10,
            height / 2 - 10,
            10,
            width / 2 - 10,
            (100 * 10 + 10) * 4,
            lb,
        ),
        (
            "Right-bottom",
            10,
            height / 2 - 10,
            width / 2 + 10,
            width - 10,
            (100 * 10 + 60) * 4,
            rb,
        ),
        (
            "Right-top",
            height / 2 + 10,
            height - 10,
            width / 2 + 10,
            width - 10,
            (100 * 60 + 60) * 4,
            rt,
        ),
        (
            "Left-top",
            height / 2 + 10,
            height - 10,
            10,
            width / 2 - 10,
            (100 * 60 + 10) * 4,
            lt,
        ),
    ];
    for (name, y0, y1, x0, x1, i0, expected) in quads {
        let mut i = i0;
        for y in y0..y1 {
            for x in x0..x1 {
                if !color_equal(x, y, pixel(i), expected, eps, color_max) {
                    status = false;
                    bad += 1;
                }
                i += 4;
            }
            i += 70 * 4;
        }
        if !status {
            log::info!("{name} quad checking failed. Bad pixels: {bad}");
        }
    }

    // middle horizontal line should be black
    let mut i = (100 * 48) * 4;
    for y in (height / 2 - 2)..(height / 2 + 2) {
        for x in 0..width {
            if !color_equal(x, y, pixel(i), [0.0; 3], eps, color_max) {
                status = false;
                bad += 1;
            }
            i += 4;
        }
    }
    if !status {
        log::info!("Middle horizontal line checking failed. Bad pixels: {bad}");
    }
    // middle vertical line should be black
    let mut i = 48 * 4;
    for _y in 0..height {
        for x in (width / 2 - 2)..(width / 2 + 2) {
            if !color_equal(x, _y, pixel(i), [0.0; 3], eps, color_max) {
                status = false;
                bad += 1;
            }
            i += 4;
        }
        i += 96 * 4;
    }
    if !status {
        log::info!("Middle vertical line checking failed. Bad pixels: {bad}");
    }

    let reported = match bad_pixels {
        Some(out) => {
            *out = bad;
            bad
        }
        None => 0,
    };
    log::info!("Bad pixels: {reported}, counted bad: {bad}");
    status
}

/// The float array `Translation` builds its (row-major) tcu::Mat4 from
pub(super) fn translation(tx: f32, ty: f32, tz: f32) -> [f32; 16] {
    [
        1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, tx, ty, tz, 1.0,
    ]
}

/// `GLenumToString`
pub(super) fn glenum_to_string(e: GLenum) -> &'static str {
    match e {
        glw::GL_SHADER_STORAGE_BUFFER_BINDING => "GL_SHADER_STORAGE_BUFFER_BINDING",
        glw::GL_SHADER_STORAGE_BUFFER_START => "GL_SHADER_STORAGE_BUFFER_START",
        glw::GL_SHADER_STORAGE_BUFFER_SIZE => "GL_SHADER_STORAGE_BUFFER_SIZE",
        glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS => "GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS",
        glw::GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS => "GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS",
        glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS => "GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS",
        glw::GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS => "GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS",
        glw::GL_MAX_SHADER_STORAGE_BLOCK_SIZE => "GL_MAX_SHADER_STORAGE_BLOCK_SIZE",
        glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS => "GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS",
        glw::GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES => "GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES",
        glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT => "GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT",
        _ => "unknown enum",
    }
}

/// `glBufferData` on `GL_SHADER_STORAGE_BUFFER` from a slice.
pub(super) fn ssbo_data<T: Copy>(gl: &glw::Functions, data: &[T], usage: GLenum) {
    gl!(gl.buffer_data(
        glw::GL_SHADER_STORAGE_BUFFER,
        std::mem::size_of_val(data) as GLsizeiptr,
        data.as_ptr().cast(),
        usage
    ));
}

/// `glBufferData` on `GL_SHADER_STORAGE_BUFFER` with a null pointer.
pub(super) fn ssbo_alloc(gl: &glw::Functions, size: usize, usage: GLenum) {
    gl!(gl.buffer_data(
        glw::GL_SHADER_STORAGE_BUFFER,
        size as GLsizeiptr,
        std::ptr::null(),
        usage
    ));
}

/// `glMapBufferRange` for reading `count` elements of `T` from the start of the bound `GL_SHADER_STORAGE_BUFFER`, copied out; the buffer is left mapped.
pub(super) fn map_read<T: Copy>(gl: &glw::Functions, offset: isize, count: usize) -> Option<Vec<T>> {
    let length = (count * std::mem::size_of::<T>()) as GLsizeiptr;
    let pointer: *mut c_void =
        gl!(gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, offset, length, glw::GL_MAP_READ_BIT));
    if pointer.is_null() {
        return None;
    }
    // SAFETY: the mapping covers `count` elements of `T` and a mapped range of a buffer object is suitably aligned.
    Some(unsafe { std::slice::from_raw_parts(pointer.cast::<T>(), count) }.to_vec())
}

pub(super) fn unmap(gl: &glw::Functions) {
    gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
}

#[allow(dead_code)]
pub(super) fn f32_bytes(values: &[f32]) -> Vec<u8> {
    values.iter().flat_map(|v| v.to_ne_bytes()).collect()
}

pub(super) fn put_f32(data: &mut [u8], index: usize, value: f32) {
    data[index * 4..index * 4 + 4].copy_from_slice(&value.to_ne_bytes());
}

pub(super) fn put_i32(data: &mut [u8], index: usize, value: i32) {
    data[index * 4..index * 4 + 4].copy_from_slice(&value.to_ne_bytes());
}

#[allow(dead_code)]
pub(super) fn put_u32(data: &mut [u8], index: usize, value: u32) {
    data[index * 4..index * 4 + 4].copy_from_slice(&value.to_ne_bytes());
}

/// `glMapBufferRange` with `GL_MAP_WRITE_BIT` on the bound `GL_SHADER_STORAGE_BUFFER`, filled with `values`; the buffer is left mapped. False when the mapping is NULL.
pub(super) fn write_mapped<T: Copy>(gl: &glw::Functions, offset: isize, values: &[T]) -> bool {
    let length = std::mem::size_of_val(values) as GLsizeiptr;
    let pointer: *mut c_void =
        gl!(gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, offset, length, glw::GL_MAP_WRITE_BIT));
    if pointer.is_null() {
        return false;
    }
    // SAFETY: the mapping is writable and covers `values.len()` elements of `T`.
    unsafe { std::ptr::copy_nonoverlapping(values.as_ptr(), pointer.cast::<T>(), values.len()) };
    true
}

/// `glGetUniformLocation` by name.
pub(super) fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = std::ffi::CString::new(name).expect("uniform names hold no NUL");
    gl!(gl.get_uniform_location(program, name.as_ptr()))
}

/// The four-point vertex buffer and the vertex array that sources attribute 0 from it, as the atomic cases build them.
pub(super) fn init_point_vertex_state(gl: &glw::Functions, vertex_buffer: &mut GLuint, vertex_array: &mut GLuint) {
    let data: [f32; 8] = [-0.8, -0.8, 0.8, -0.8, -0.8, 0.8, 0.8, 0.8];
    gl!(gl.gen_buffers(1, vertex_buffer));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vertex_buffer));
    gl!(gl.buffer_data(
        glw::GL_ARRAY_BUFFER,
        std::mem::size_of_val(&data) as GLsizeiptr,
        data.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.gen_vertex_arrays(1, vertex_array));
    gl!(gl.bind_vertex_array(*vertex_array));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vertex_buffer));
    gl!(gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    gl!(gl.enable_vertex_attrib_array(0));
    gl!(gl.bind_vertex_array(0));
}

/// `glBufferData` on any target from a slice.
pub(super) fn buffer_data<T: Copy>(gl: &glw::Functions, target: GLenum, data: &[T], usage: GLenum) {
    gl!(gl.buffer_data(
        target,
        std::mem::size_of_val(data) as GLsizeiptr,
        data.as_ptr().cast(),
        usage
    ));
}

/// The 100x100 RGBA8 texture bound to `fbo` that the rendering cases draw into, with the viewport set to match.
pub(super) fn init_render_target(gl: &glw::Functions, rt: GLuint, fbo: GLuint) {
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, rt));
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as GLint));
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as GLint));
    gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, 100, 100));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
    gl!(gl.viewport(0, 0, 100, 100));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo));
    gl!(gl.framebuffer_texture_2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_TEXTURE_2D,
        rt,
        0
    ));
}

/// `glViewport(0, 0, getWindowWidth(), getWindowHeight())`
pub(super) fn restore_viewport(context: &Context) {
    let target = context.render_target();
    gl!(context.gl().viewport(0, 0, target.width, target.height));
}

/// `ValidateWindow4Quads(red, green, yellow, blue)` without the bad pixel count, the colours every rendering case expects.
pub(super) fn validate_window_4_quads_default(context: &Context) -> bool {
    validate_window_4_quads(
        context,
        [1.0, 0.0, 0.0],
        [0.0, 1.0, 0.0],
        [1.0, 1.0, 0.0],
        [0.0, 0.0, 1.0],
        None,
    )
}

/// One of the four coloured quads (as `VertexData { vec2 position; vec3 color; }` in std430, 32 floats) the switching cases draw as a triangle strip.
pub(super) fn quad_vertices(offset_x: f32, offset_y: f32, color: Vec3) -> [f32; 32] {
    let (left, right) = (-0.4f32 + offset_x, 0.4f32 + offset_x);
    let (bottom, top) = (-0.4f32 + offset_y, 0.4f32 + offset_y);
    let mut data = [0.0f32; 32];
    for (vertex, (x, y)) in [(left, bottom), (right, bottom), (left, top), (right, top)]
        .into_iter()
        .enumerate()
    {
        data[vertex * 8..vertex * 8 + 8].copy_from_slice(&[x, y, 0.0, 0.0, color[0], color[1], color[2], 0.0]);
    }
    data
}

/// The red, green, blue and yellow quads in the order the cases upload them (left-bottom, right-bottom, left-top, right-top).
pub(super) fn four_quads() -> [[f32; 32]; 4] {
    [
        quad_vertices(-0.5, -0.5, [1.0, 0.0, 0.0]),
        quad_vertices(0.5, -0.5, [0.0, 1.0, 0.0]),
        quad_vertices(-0.5, 0.5, [0.0, 0.0, 1.0]),
        quad_vertices(0.5, 0.5, [1.0, 1.0, 0.0]),
    ]
}

/// `deRoundUp32`
pub(super) fn round_up(value: i32, alignment: i32) -> i32 {
    (value + alignment - 1) / alignment * alignment
}
