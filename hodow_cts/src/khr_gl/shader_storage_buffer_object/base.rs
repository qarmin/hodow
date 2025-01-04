// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderStorageBufferObjectTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ShaderStorageBufferObjectBase` is this module's free functions (each takes the `Context` the C++ class reaches through `m_context`); the log messages that upstream writes with `tcu::TestLog` go through `log::info!`. Written without compiling.

#![allow(dead_code)]

use std::ffi::{CString, c_void};

use crate::glu::Context;
use crate::glw::{self, GLenum, GLint, GLsizeiptr, GLuint};
use crate::khr_gl::subcase::output_not_supported;

pub(super) const GLSL_VER: &str = "#version 430 core\n";

pub(super) type Vec3 = [f32; 3];

pub(super) const FS_GREEN: &str =
    "\nlayout(location = 0) out vec4 o_color;\nvoid main() {\n  o_color = vec4(0.0, 1.0, 0.0, 1.0);\n}";

/// `kGLSLVer` and the body as the two source strings of `glShaderSource`.
pub(super) fn shader_source(gl: &glw::Functions, shader: GLuint, body: &str) {
    let parts = [
        CString::new(GLSL_VER).expect("no NUL"),
        CString::new(body).expect("shader sources hold no NUL"),
    ];
    let pointers = [parts[0].as_ptr(), parts[1].as_ptr()];
    gl!(gl.shader_source(shader, 2, pointers.as_ptr(), std::ptr::null()));
}

pub(super) fn get_integer(gl: &glw::Functions, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_integerv(pname, &mut value));
    value
}

fn supported_in(gl: &glw::Functions, pname: GLenum, required: i32, stage: &str) -> bool {
    let blocks = get_integer(gl, pname);
    if blocks >= required {
        return true;
    }
    output_not_supported(&format!(
        "Required {required} {stage} storage blocks but only {blocks} available.\n"
    ));
    false
}

/// `SupportedInVS`
pub(super) fn supported_in_vs(gl: &glw::Functions, required_vs: i32) -> bool {
    supported_in(gl, glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS, required_vs, "VS")
}

/// `SupportedInTCS`
pub(super) fn supported_in_tcs(gl: &glw::Functions, required_tcs: i32) -> bool {
    supported_in(gl, glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS, required_tcs, "TCS")
}

/// `SupportedInTES`
pub(super) fn supported_in_tes(gl: &glw::Functions, required_tes: i32) -> bool {
    supported_in(
        gl,
        glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS,
        required_tes,
        "TES",
    )
}

/// `SupportedInGS`
pub(super) fn supported_in_gs(gl: &glw::Functions, required_gs: i32) -> bool {
    supported_in(gl, glw::GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS, required_gs, "GS")
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
                    "*** {} ***",
                    match shader_type as GLenum {
                        glw::GL_VERTEX_SHADER => "Vertex Shader",
                        glw::GL_TESS_CONTROL_SHADER => "Tessellation Control Shader",
                        glw::GL_TESS_EVALUATION_SHADER => "Tessellation Evaluation Shader",
                        glw::GL_GEOMETRY_SHADER => "Geometry Shader",
                        glw::GL_FRAGMENT_SHADER => "Fragment Shader",
                        glw::GL_COMPUTE_SHADER => "Compute Shader",
                        _ => "Unknown Shader",
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

/// `CreateProgram(vs, fs)`
pub(super) fn create_program(gl: &glw::Functions, vs: &str, fs: &str) -> GLuint {
    create_program_5(gl, vs, "", "", "", fs)
}

/// `CreateProgram(vs, tcs, tes, gs, fs)`
pub(super) fn create_program_5(gl: &glw::Functions, vs: &str, tcs: &str, tes: &str, gs: &str, fs: &str) -> GLuint {
    let program = gl!(gl.create_program());
    for (shader_type, body) in [
        (glw::GL_VERTEX_SHADER, vs),
        (glw::GL_TESS_CONTROL_SHADER, tcs),
        (glw::GL_TESS_EVALUATION_SHADER, tes),
        (glw::GL_GEOMETRY_SHADER, gs),
        (glw::GL_FRAGMENT_SHADER, fs),
    ] {
        if !body.is_empty() {
            attach_compiled(gl, program, shader_type, body);
        }
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
    let mut parts = vec![CString::new(GLSL_VER).expect("no NUL")];
    if shader_type == glw::GL_COMPUTE_SHADER {
        parts.push(CString::new("#extension GL_ARB_compute_shader : require\n").expect("no NUL"));
    }
    parts.push(CString::new(source).expect("shader sources hold no NUL"));
    let pointers: Vec<*const glw::GLchar> = parts.iter().map(|part| part.as_ptr()).collect();
    gl!(gl.create_shader_programv(shader_type, pointers.len() as i32, pointers.as_ptr()))
}

fn color_eps(context: &Context) -> [f32; 4] {
    let target = context.render_target();
    [
        1.0 / (1u32 << target.red_bits) as f32,
        1.0 / (1u32 << target.green_bits) as f32,
        1.0 / (1u32 << target.blue_bits) as f32,
        1.0 / (1u32 << target.alpha_bits) as f32,
    ]
}

/// `ColorEqual(vec3, vec3, vec4)`
fn color_equal(c0: Vec3, c1: Vec3, epsilon: [f32; 4]) -> bool {
    (0..3).all(|k| (c0[k] - c1[k]).abs() <= epsilon[k])
}

/// `ValidateReadBuffer`
pub(super) fn validate_read_buffer(context: &Context, x: i32, y: i32, w: i32, h: i32, expected: Vec3) -> bool {
    let gl = context.gl();
    let eps = color_eps(context);

    let mut display = vec![[0.0f32; 3]; (w * h) as usize];
    gl!(gl.read_pixels(x, y, w, h, glw::GL_RGB, glw::GL_FLOAT, display.as_mut_ptr().cast()));

    let mut result = true;
    for j in 0..h {
        for i in 0..w {
            let pixel = display[(j * w + i) as usize];
            if !color_equal(pixel, expected, eps) {
                log::info!(
                    "Color at ({}, {}) is ({} {} {}) should be ({} {} {}).",
                    x + i,
                    y + j,
                    pixel[0],
                    pixel[1],
                    pixel[2],
                    expected[0],
                    expected[1],
                    expected[2]
                );
                result = false;
            }
        }
    }

    result
}

/// `ValidateReadBuffer(0, 0, getWindowWidth(), getWindowHeight(), expected)`
pub(super) fn validate_window(context: &Context, expected: Vec3) -> bool {
    let target = context.render_target();
    validate_read_buffer(context, 0, 0, target.width, target.height, expected)
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

    let width = 100i32;
    let height = 100i32;
    let mut fb = vec![[0.0f32; 3]; (width * height) as usize];
    gl!(gl.read_pixels(0, 0, width, height, glw::GL_RGB, glw::GL_FLOAT, fb.as_mut_ptr().cast()));

    let mut status = true;
    let mut bad = 0;

    // (name, first y, last y exclusive, first x, last x exclusive, colour)
    let quads = [
        ("left-bottom", 10, height / 2 - 10, 10, width / 2 - 10, lb),
        ("right-bottom", 10, height / 2 - 10, width / 2 + 10, width - 10, rb),
        (
            "right-top",
            height / 2 + 10,
            height - 10,
            width / 2 + 10,
            width - 10,
            rt,
        ),
        ("left-top", height / 2 + 10, height - 10, 10, width / 2 - 10, lt),
    ];
    for (name, y0, y1, x0, x1, expected) in quads {
        for y in y0..y1 {
            for x in x0..x1 {
                let pixel = fb[(y * width + x) as usize];
                if !color_equal(pixel, expected, eps) {
                    log::info!("Bad color at ({x}, {y}): {} {} {}", pixel[0], pixel[1], pixel[2]);
                    status = false;
                    bad += 1;
                }
            }
        }
        if !status {
            log::info!("{name} quad checking failed. Bad pixels: {bad}");
        }
    }

    for y in (height / 2 - 2)..(height / 2 + 2) {
        for x in 0..width {
            let pixel = fb[(y * width + x) as usize];
            if !color_equal(pixel, [0.0; 3], eps) {
                log::info!("Bad color at ({x}, {y}): {} {} {}", pixel[0], pixel[1], pixel[2]);
                status = false;
                bad += 1;
            }
        }
    }
    if !status {
        log::info!("middle horizontal line checking failed. Bad pixels: {bad}");
    }

    for y in 0..height {
        for x in (width / 2 - 2)..(width / 2 + 2) {
            let pixel = fb[(y * width + x) as usize];
            if !color_equal(pixel, [0.0; 3], eps) {
                log::info!("Bad color at ({x}, {y}): {} {} {}", pixel[0], pixel[1], pixel[2]);
                status = false;
                bad += 1;
            }
        }
    }
    if !status {
        log::info!("middle vertical line checking failed. Bad pixels: {bad}");
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

/// `GLenumToString`
pub(super) fn glenum_to_string(e: GLenum) -> &'static str {
    match e {
        glw::GL_SHADER_STORAGE_BUFFER_BINDING => "GL_SHADER_STORAGE_BUFFER_BINDING",
        glw::GL_SHADER_STORAGE_BUFFER_START => "GL_SHADER_STORAGE_BUFFER_START",
        glw::GL_SHADER_STORAGE_BUFFER_SIZE => "GL_SHADER_STORAGE_BUFFER_SIZE",
        glw::GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS => "GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS",
        glw::GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS => "GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS",
        glw::GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS => "GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS",
        glw::GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS => "GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS",
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

/// `glMapBufferRange` for reading `count` elements of `T` from the bound `GL_SHADER_STORAGE_BUFFER`, copied out; the buffer is left mapped.
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

/// The three triangle corners every full-viewport case uploads (`vec4 position[3]`).
pub(super) const TRIANGLE_POSITIONS: [f32; 12] = [-1.0, -1.0, 0.0, 1.0, 3.0, -1.0, 0.0, 1.0, -1.0, 3.0, 0.0, 1.0];

pub(super) fn put_f32(data: &mut [u8], index: usize, value: f32) {
    data[index * 4..index * 4 + 4].copy_from_slice(&value.to_ne_bytes());
}

pub(super) fn put_i32(data: &mut [u8], index: usize, value: i32) {
    data[index * 4..index * 4 + 4].copy_from_slice(&value.to_ne_bytes());
}

pub(super) fn put_u32(data: &mut [u8], index: usize, value: u32) {
    data[index * 4..index * 4 + 4].copy_from_slice(&value.to_ne_bytes());
}

/// `*reinterpret_cast<double *>(fp + float_index) = value`
pub(super) fn put_f64(data: &mut [u8], float_index: usize, value: f64) {
    data[float_index * 4..float_index * 4 + 8].copy_from_slice(&value.to_ne_bytes());
}

/// `glGetUniformLocation` by name.
pub(super) fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("uniform names hold no NUL");
    gl!(gl.get_uniform_location(program, name.as_ptr()))
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

/// `glBufferData` on `GL_ARRAY_BUFFER` from `data` and a vertex array that sources attribute 0 (two floats) from it.
pub(super) fn init_vertex_state(
    gl: &glw::Functions,
    data: &[f32],
    vertex_buffer: &mut GLuint,
    vertex_array: &mut GLuint,
) {
    gl!(gl.gen_buffers(1, vertex_buffer));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vertex_buffer));
    buffer_data(gl, glw::GL_ARRAY_BUFFER, data, glw::GL_STATIC_DRAW);
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.gen_vertex_arrays(1, vertex_array));
    gl!(gl.bind_vertex_array(*vertex_array));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vertex_buffer));
    gl!(gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    gl!(gl.enable_vertex_attrib_array(0));
    gl!(gl.bind_vertex_array(0));
}

/// The four-point vertex data most of the rendering cases draw.
pub(super) const POINT_VERTICES: [f32; 8] = [-0.8, -0.8, 0.8, -0.8, -0.8, 0.8, 0.8, 0.8];

/// `glGetBufferSubData` of `count` elements of `T` at `offset` of the bound `GL_SHADER_STORAGE_BUFFER`.
pub(super) fn get_sub_data<T: Copy + Default>(gl: &glw::Functions, offset: isize, count: usize) -> Vec<T> {
    let mut out = vec![T::default(); count];
    gl!(gl.get_buffer_sub_data(
        glw::GL_SHADER_STORAGE_BUFFER,
        offset,
        (count * std::mem::size_of::<T>()) as isize,
        out.as_mut_ptr().cast()
    ));
    out
}

/// Compares `count` elements of the bound buffer against `expected(i)`, logging the first difference; `what` is "uData" or "iData". `mapped` reads through a mapping (compute flavours) rather than `glGetBufferSubData`.
pub(super) fn check_values<T: Copy + Default + std::fmt::Display + PartialEq>(
    gl: &glw::Functions,
    what: &str,
    offset: isize,
    count: usize,
    mapped: bool,
    expected: impl Fn(usize) -> T,
) -> bool {
    let data = if mapped {
        match map_read::<T>(gl, offset, count) {
            Some(data) => data,
            None => return false,
        }
    } else {
        get_sub_data::<T>(gl, offset, count)
    };
    for (i, value) in data.iter().enumerate() {
        if *value != expected(i) {
            log::info!("{what} at index {i} is {value} should be {}", expected(i));
            if mapped {
                unmap(gl);
            }
            return false;
        }
    }
    if mapped {
        unmap(gl);
    }
    true
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
    gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, rt, 0));
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

/// `glGetBufferSubData` through an unmapped read: the bound buffer's first `count` elements.
#[allow(dead_code)]
pub(super) fn bytes_of<T: Copy>(values: &[T]) -> Vec<u8> {
    // SAFETY: `T: Copy` plain data, the view covers exactly the slice's bytes.
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }.to_vec()
}

/// `glMapBuffer(GL_SHADER_STORAGE_BUFFER, GL_WRITE_ONLY)` filled with `values`; the buffer is left mapped. False when the mapping is NULL.
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

/// The float array `Translation` builds its tcu::Mat4 from, as the column-major memory the matrix has.
pub(super) fn translation(tx: f32, ty: f32, tz: f32) -> [f32; 16] {
    [
        1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, tx, ty, tz, 1.0,
    ]
}
