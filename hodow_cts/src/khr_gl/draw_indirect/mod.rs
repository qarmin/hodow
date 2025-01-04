// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cDrawIndirectTests.cpp
//   external/openglcts/modules/gles31/es31cDrawIndirectTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the desktop half (`DrawIndirectTestsGL40` and `DrawIndirectTestsGL43`, the `test_api::GL` instantiation) is ported, so the `api` template parameter is gone and `DrawIndirectBase`'s helpers are free functions taking the `Context`. `DIResult`/`DILogger` are `DiResult`, which logs through `log::info!`.

use std::ffi::{CString, c_void};

use super::subcase::{ERROR, NO_ERROR, Subcase, TestSubcase};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

mod advanced_cases;
mod buffer_cases;
mod draw_cases;
mod mode_cases;
mod negative_cases;

pub(super) type Color = [f32; 4];

pub(super) const GL_TRUE_BYTE: glw::GLboolean = 1;
pub(super) const GL_FALSE_BYTE: glw::GLboolean = 0;

pub(super) const GLSL_VER_GL: &str = "#version 400";
pub(super) const GLSL_VER_GL_COMPUTE: &str = "#version 430";

/// `DIResult`
#[derive(Default)]
pub(super) struct DiResult {
    status: i64,
}

impl DiResult {
    pub(super) fn new() -> Self {
        Self { status: NO_ERROR }
    }

    pub(super) fn error(&mut self, message: impl std::fmt::Display) {
        self.status |= ERROR;
        log::info!("{message}");
    }

    pub(super) fn sub_result(&mut self, code: i64) {
        self.status |= code;
    }

    pub(super) fn code(&self) -> i64 {
        self.status
    }
}

/// `DrawArraysIndirectCommand`
#[repr(C)]
#[derive(Clone, Copy, Default)]
pub(super) struct DrawArraysIndirectCommand {
    pub count: GLuint,
    pub prim_count: GLuint,
    pub first: GLuint,
    pub reserved_must_be_zero: GLuint,
}

/// `DrawElementsIndirectCommand`
#[repr(C)]
#[derive(Clone, Copy, Default)]
pub(super) struct DrawElementsIndirectCommand {
    pub count: GLuint,
    pub prim_count: GLuint,
    pub first_index: GLuint,
    pub base_vertex: GLint,
    pub reserved_must_be_zero: GLuint,
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum DrawFunction {
    DrawArrays,
    DrawElements,
}

pub(super) const UINT_SIZE: usize = std::mem::size_of::<u32>();

pub(super) fn window_width(context: &Context) -> i32 {
    context.render_target().width
}

pub(super) fn window_height(context: &Context) -> i32 {
    context.render_target().height
}

/// `getDataSize`
pub(super) fn get_data_size(context: &Context) -> (i32, i32) {
    let width = window_width(context).min(16384);
    let height = window_height(context).min(4 * 16384 / width);
    (width, height)
}

fn compile_attached(gl: &glw::Functions, program: GLuint, shader_type: GLenum, source: &str) {
    let source = CString::new(source).expect("shader source holds no nul byte");
    let shader = gl!(gl.create_shader(shader_type));
    gl!(gl.attach_shader(program, shader));
    gl!(gl.delete_shader(shader));
    let sources = [source.as_ptr()];
    gl!(gl.shader_source(shader, 1, sources.as_ptr(), std::ptr::null()));
    gl!(gl.compile_shader(shader));
}

/// `CreateComputeProgram`
pub(super) fn create_compute_program(gl: &glw::Functions, cs: &str, link_and_check: bool) -> GLuint {
    let program = gl!(gl.create_program());
    compile_attached(gl, program, glw::GL_COMPUTE_SHADER, cs);

    if link_and_check {
        gl!(gl.link_program(program));
        if !check_program(gl, program) {
            return 0;
        }
    }
    program
}

/// `CreateProgram`
pub(super) fn create_program(gl: &glw::Functions, vs: &str, gs: &str, fs: &str, link_and_check: bool) -> GLuint {
    let program = gl!(gl.create_program());
    if !vs.is_empty() {
        compile_attached(gl, program, glw::GL_VERTEX_SHADER, vs);
    }
    if !gs.is_empty() {
        compile_attached(gl, program, glw::GL_GEOMETRY_SHADER, gs);
    }
    if !fs.is_empty() {
        compile_attached(gl, program, glw::GL_FRAGMENT_SHADER, fs);
    }

    if link_and_check {
        gl!(gl.link_program(program));
        if !check_program(gl, program) {
            return 0;
        }
    }
    program
}

fn buffer_to_string(buffer: &[u8]) -> String {
    let end = buffer.iter().position(|&byte| byte == 0).unwrap_or(buffer.len());
    String::from_utf8_lossy(&buffer[..end]).into_owned()
}

/// `CheckProgram`, true when the program linked.
pub(super) fn check_program(gl: &glw::Functions, program: GLuint) -> bool {
    let mut status = DiResult::new();
    let mut prog_status = 0;
    gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut prog_status));

    if prog_status == glw::GL_FALSE as GLint {
        status.error("GL_LINK_STATUS is false");

        let mut attached_shaders = 0;
        gl!(gl.get_programiv(program, glw::GL_ATTACHED_SHADERS, &mut attached_shaders));

        if attached_shaders > 0 {
            let mut shaders = vec![0 as GLuint; attached_shaders as usize];
            gl!(gl.get_attached_shaders(program, attached_shaders, std::ptr::null_mut(), shaders.as_mut_ptr()));

            for &shader in &shaders {
                let mut shader_type = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_TYPE, &mut shader_type));
                match shader_type as GLenum {
                    glw::GL_VERTEX_SHADER => status.error("*** Vertex Shader ***\n"),
                    glw::GL_FRAGMENT_SHADER => status.error("*** Fragment Shader ***\n"),
                    glw::GL_COMPUTE_SHADER => status.error("*** Compute Shader ***\n"),
                    _ => status.error("*** Unknown Shader ***\n"),
                }

                let mut length = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_SOURCE_LENGTH, &mut length));
                if length > 0 {
                    let mut source = vec![0u8; length as usize];
                    gl!(gl.get_shader_source(shader, length, std::ptr::null_mut(), source.as_mut_ptr().cast()));
                    status.error(buffer_to_string(&source));
                }

                gl!(gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut length));
                if length > 0 {
                    let mut info_log = vec![0u8; length as usize];
                    gl!(gl.get_shader_info_log(shader, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
                    status.error(buffer_to_string(&info_log));
                }
            }
        }

        let mut length = 0;
        gl!(gl.get_programiv(program, glw::GL_INFO_LOG_LENGTH, &mut length));
        if length > 0 {
            let mut info_log = vec![0u8; length as usize];
            gl!(gl.get_program_info_log(program, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
            status.error(buffer_to_string(&info_log));
        }
    }

    status.code() == NO_ERROR
}

/// `ReadPixelsFloat<test_api::GL>`
pub(super) fn read_pixels_float(gl: &glw::Functions, x: i32, y: i32, width: i32, height: i32, data: &mut [Color]) {
    assert!(
        data.len() >= (width * height) as usize,
        "ReadPixelsFloat destination too small"
    );
    gl!(gl.read_pixels(
        x,
        y,
        width,
        height,
        glw::GL_RGBA,
        glw::GL_FLOAT,
        data.as_mut_ptr().cast()
    ));
}

/// `GetBufferSubData<test_api::GL>`
pub(super) fn get_buffer_sub_data(gl: &glw::Functions, target: GLenum, offset: isize, data: &mut [u32]) {
    gl!(gl.get_buffer_sub_data(
        target,
        offset,
        (data.len() * UINT_SIZE) as isize,
        data.as_mut_ptr().cast()
    ));
}

/// `DataGen<unsigned int>`
pub(super) fn data_gen(size_x: u32, size_y: u32, value_min: u32, value_max: u32) -> Vec<u32> {
    let mut data = vec![0u32; (size_x * size_y) as usize];
    let range = value_max - value_min;
    let step_x = range / size_x;
    let step_y = range / size_y;

    for i in 0..size_y {
        let value_y = i * step_y;
        for j in 0..size_x {
            data[(j + i * size_x) as usize] = value_min + j * step_x + value_y;
        }
    }
    data
}

/// `DataCompare<unsigned int>`
#[allow(clippy::too_many_arguments)]
pub(super) fn data_compare(
    data_ref: &[u32],
    width_ref: u32,
    height_ref: u32,
    data_test: &[u32],
    width_test: u32,
    height_test: u32,
    offset_y_ref: u32,
    offset_y_test: u32,
) -> i64 {
    if (width_ref * height_ref) as usize > data_ref.len() {
        log::info!("Invalid reference buffer resolution!");
        return ERROR;
    }
    if (width_test * height_test) as usize > data_test.len() {
        log::info!("Invalid test buffer resolution!");
        return ERROR;
    }

    let width = width_ref.min(width_test);
    let height = height_ref.min(height_test);

    for i in 0..height {
        let offset_ref = ((i + offset_y_ref) * width_ref) as usize;
        let offset_test = ((i + offset_y_test) * width_test) as usize;

        for j in 0..width as usize {
            if data_ref[offset_ref + j] != data_test[offset_test + j] {
                let mut status = DiResult::new();
                status.error(format!(
                    "Compare failed: different values [x: {}, y: {}, reference: {}, test: {}]",
                    j,
                    i + offset_y_test,
                    data_ref[offset_ref + j],
                    data_test[offset_test + j]
                ));
                return status.code();
            }
        }
    }
    NO_ERROR
}

/// `DataCompare` with the two offsets left at zero.
pub(super) fn data_compare_plain(
    data_ref: &[u32],
    width_ref: u32,
    height_ref: u32,
    data_test: &[u32],
    width_test: u32,
    height_test: u32,
) -> i64 {
    data_compare(
        data_ref,
        width_ref,
        height_ref,
        data_test,
        width_test,
        height_test,
        0,
        0,
    )
}

/// `BufferCheck`: `buf_test` is a mapped pointer to `width_test * height_test` words.
#[allow(clippy::too_many_arguments)]
pub(super) fn buffer_check(
    data_ref: &[u32],
    width_ref: u32,
    height_ref: u32,
    buf_test: *const c_void,
    width_test: u32,
    height_test: u32,
    offset_y_ref: u32,
    offset_y_test: u32,
) -> i64 {
    if buf_test.is_null() {
        log::info!("Invalid test buffer!");
        return ERROR;
    }

    // SAFETY: the caller mapped at least `width_test * height_test` words behind a non-null pointer.
    let data_test =
        unsafe { std::slice::from_raw_parts(buf_test.cast::<u32>(), (width_test * height_test) as usize) }.to_vec();
    data_compare(
        data_ref,
        width_ref,
        height_ref,
        &data_test,
        width_test,
        height_test,
        offset_y_ref,
        offset_y_test,
    )
}

/// `BindingPointCheck<test_api::GL>`
pub(super) fn binding_point_check(gl: &glw::Functions, expected_value: GLuint) -> i64 {
    let mut status = DiResult::new();

    let mut value_int: GLint = -9999;
    gl!(gl.get_integerv(glw::GL_DRAW_INDIRECT_BUFFER_BINDING, &mut value_int));
    if value_int != expected_value as GLint {
        status.error(format!("glGetIntegerv(GL_DRAW_INDIRECT_BUFFER_BINDING) returned invalid value: {value_int}, expected: {expected_value}"));
    }

    let expected_bool = if expected_value != 0 {
        GL_TRUE_BYTE
    } else {
        GL_FALSE_BYTE
    };
    let mut value_bool = if expected_value != 0 {
        GL_FALSE_BYTE
    } else {
        GL_TRUE_BYTE
    };
    gl!(gl.get_booleanv(glw::GL_DRAW_INDIRECT_BUFFER_BINDING, &mut value_bool));
    if value_bool != expected_bool {
        status.error(format!(
            "glGetBooleanv(GL_DRAW_INDIRECT_BUFFER_BINDING) returned invalid value: {}, expected: {}",
            bool_to_string(value_bool),
            bool_to_string(expected_bool)
        ));
    }

    let mut value_float: f32 = -9999.0;
    let expected_float_value = expected_value as f32;
    gl!(gl.get_floatv(glw::GL_DRAW_INDIRECT_BUFFER_BINDING, &mut value_float));
    if value_float != expected_float_value {
        status.error(format!("glGetFloatv(GL_DRAW_INDIRECT_BUFFER_BINDING) returned invalid value: {value_float}, expected: {expected_value}"));
    }

    let mut value_double: f64 = -9999.0;
    gl!(gl.get_doublev(glw::GL_DRAW_INDIRECT_BUFFER_BINDING, &mut value_double));
    if value_double != expected_value as f64 {
        status.error(format!("glGetDoublev(GL_DRAW_INDIRECT_BUFFER_BINDING) returned invalid value: {value_double}, expected: {expected_value}"));
    }

    status.code()
}

pub(super) fn bool_to_string(value: glw::GLboolean) -> &'static str {
    if value == GL_TRUE_BYTE { "GL_TRUE" } else { "GL_FALSE" }
}

fn access_to_string(access: u32) -> String {
    match access {
        glw::GL_READ_WRITE => "GL_READ_WRITE".to_string(),
        glw::GL_READ_ONLY => "GL_READ_ONLY".to_string(),
        glw::GL_WRITE_ONLY => "GL_WRITE_ONLY".to_string(),
        _ => "Invalid access type!".to_string(),
    }
}

/// `ColorVerify`, which looks at the first three channels only.
fn color_verify(color: &Color, color_expected: &Color, epsilon: &Color) -> bool {
    (0..3).all(|i| (color_expected[i] - color[i]).abs() <= epsilon[i])
}

/// `BuffersCompare<tcu::Vec4>`
pub(super) fn buffers_compare(
    context: &Context,
    buffer_test: &[Color],
    width_test: u32,
    height_test: u32,
    buffer_ref: &[Color],
    width_ref: u32,
    height_ref: u32,
) -> i64 {
    let pixel_format = context.render_target();
    let bits = |count: i32| (1u32 << count) as f32;

    // glReadPixels uses either GL_UNSIGNED_INT_2_10_10_10_REV or GL_UNSIGNED_BYTE
    let bpc: Color = if pixel_format.red_bits > 10 && pixel_format.green_bits > 10 && pixel_format.blue_bits > 10 {
        [
            (1u32 << 8) as f32,
            (1u32 << 8) as f32,
            (1u32 << 8) as f32,
            bits(pixel_format.alpha_bits),
        ]
    } else {
        [
            bits(pixel_format.red_bits),
            bits(pixel_format.green_bits),
            bits(pixel_format.blue_bits),
            bits(pixel_format.alpha_bits),
        ]
    };

    let epsilon: Color = [1.0 / bpc[0], 1.0 / bpc[1], 1.0 / bpc[2], 1.0 / bpc[3]];
    let step_x = width_ref as f64 / width_test as f64;
    let step_y = height_ref as f64 / height_test as f64;
    for i in 0..height_test {
        let offset_test = (i * width_test) as usize;
        let offset_ref = ((i as f64 * step_y + 0.5) as u32 * width_ref) as usize;
        for j in 0..width_test {
            let pos_x_ref = (j as f64 * step_x + 0.5) as usize;
            let test = &buffer_test[j as usize + offset_test];
            let reference = &buffer_ref[pos_x_ref + offset_ref];
            if !color_verify(test, reference, &epsilon) {
                let mut status = DiResult::new();
                status.error(format!(
                    "(x,y)= ({},{}). Color RGBA({},{},{},{}) is different than expected RGBA({},{},{},{})",
                    j, i, test[0], test[1], test[2], test[3], reference[0], reference[1], reference[2], reference[3]
                ));
                return status.code();
            }
        }
    }
    NO_ERROR
}

/// `StateValidate<test_api::GL>`
pub(super) fn state_validate(
    gl: &glw::Functions,
    mapped: glw::GLboolean,
    access: u32,
    access_flag: u32,
    offset: isize,
    length: isize,
) -> i64 {
    let mut result = DiResult::new();

    let mut v: GLint = 0;
    gl!(gl.get_buffer_parameteriv(glw::GL_DRAW_INDIRECT_BUFFER, glw::GL_BUFFER_ACCESS, &mut v));
    if v != access as GLint {
        result.error(format!(
            "glGetBufferParameteriv(GL_BUFFER_ACCESS) returned incorrect state: {}, expected: {}",
            access_to_string(v as u32),
            access_to_string(access)
        ));
    }

    gl!(gl.get_buffer_parameteriv(glw::GL_DRAW_INDIRECT_BUFFER, glw::GL_BUFFER_ACCESS_FLAGS, &mut v));
    if v != access_flag as GLint {
        result.error(format!(
            "glGetBufferParameteriv(GL_BUFFER_ACCESS_FLAGS) returned incorrect state: {v}, expected: {access_flag}"
        ));
    }

    gl!(gl.get_buffer_parameteriv(glw::GL_DRAW_INDIRECT_BUFFER, glw::GL_BUFFER_MAPPED, &mut v));
    if v != mapped as GLint {
        result.error(format!(
            "glGetBufferParameteriv(GL_BUFFER_MAPPED) returned incorrect state: {}, expected: {}",
            bool_to_string(v as glw::GLboolean),
            bool_to_string(access as glw::GLboolean)
        ));
    }

    gl!(gl.get_buffer_parameteriv(glw::GL_DRAW_INDIRECT_BUFFER, glw::GL_BUFFER_MAP_OFFSET, &mut v));
    if v as isize != offset {
        result.error(format!(
            "glGetBufferParameteriv(GL_BUFFER_MAP_OFFSET) returned incorrect offset: {v}, expected: {offset}"
        ));
    }

    gl!(gl.get_buffer_parameteriv(glw::GL_DRAW_INDIRECT_BUFFER, glw::GL_BUFFER_MAP_LENGTH, &mut v));
    if v as isize != length {
        result.error(format!(
            "glGetBufferParameteriv(GL_BUFFER_MAP_LENGTH) returned incorrect length: {v}, expected: {length}"
        ));
    }

    result.code()
}

/// `PointsGen`
pub(super) fn points_gen(context: &Context, draw_size_x: u32, draw_size_y: u32, output: &mut Vec<Color>) {
    let raster_size_x = 2.0 / window_width(context) as f32;
    let raster_size_y = 2.0 / window_height(context) as f32;
    for i in 0..draw_size_y {
        let offset_y = -1.0 + raster_size_y * i as f32 + raster_size_y / 2.0;
        for j in 0..draw_size_x {
            let offset_x = -1.0 + raster_size_x * j as f32 + raster_size_x / 2.0;
            output.push([offset_x, offset_y, 0.0, 1.0]);
        }
    }
}

/// `LinesOffsetY`: offset lines slightly from the center of pixels so as not to hit rasterizer tie-break conditions.
fn lines_offset_y(i: u32, raster_size: f32) -> f32 {
    -1.0 + raster_size * i as f32 + raster_size / 2.0 + raster_size / 16.0
}

/// `LinesGen`
pub(super) fn lines_gen(context: &Context, draw_size_y: u32, output: &mut Vec<Color>) {
    let raster_size = 2.0 / window_height(context) as f32;
    for i in 0..draw_size_y {
        let offset_y = lines_offset_y(i, raster_size);
        output.push([-1.0, offset_y, 0.0, 1.0]);
        output.push([1.0, offset_y, 0.0, 1.0]);
    }
}

/// `LinesAdjacencyGen`
pub(super) fn lines_adjacency_gen(context: &Context, draw_size_y: u32, output: &mut Vec<Color>) {
    let raster_size = 2.0 / window_height(context) as f32;
    for i in 0..draw_size_y {
        let offset_y = lines_offset_y(i, raster_size);
        output.push([-1.5, -1.0 + offset_y, 0.0, 1.0]);
        output.push([-1.0, offset_y, 0.0, 1.0]);
        output.push([1.0, offset_y, 0.0, 1.0]);
        output.push([1.5, -1.0 + offset_y, 0.0, 1.0]);
    }
}

/// `LineStripAdjacencyGen`
pub(super) fn line_strip_adjacency_gen(context: &Context, draw_size_y: u32, output: &mut Vec<Color>) {
    let raster_size = 2.0 / window_height(context) as f32;
    output.push([-1.5, raster_size / 2.0, 0.0, 1.0]);
    for i in 0..draw_size_y {
        let offset_y = lines_offset_y(i, raster_size);
        output.push([-1.0, offset_y, 0.0, 1.0]);
        output.push([-1.0, offset_y, 0.0, 1.0]);
        output.push([1.0, offset_y, 0.0, 1.0]);
        output.push([1.0, offset_y, 0.0, 1.0]);
    }
    output.push([1.5, 1.0 - raster_size / 2.0, 0.0, 1.0]);
}

/// `TrianglesGen`
pub(super) fn triangles_gen(
    draw_size_x: u32,
    draw_size_y: u32,
    output: &mut Vec<Color>,
) -> Result<(), crate::tcu::TestError> {
    match draw_size_x {
        1 => {
            output.push([-1.0, -1.0, 0.0, 1.0]);
            output.push([4.0, -1.0, 0.0, 1.0]);
            output.push([-1.0, 4.0, 0.0, 1.0]);
        }
        0 => return Err(crate::tcu::TestError::Fail("Invalid drawSizeX!".to_string())),
        _ => {
            let draw_step_x = 2.0 / draw_size_x as f32;
            let draw_step_y = 2.0 / draw_size_y as f32;

            for i in 0..draw_size_y {
                let offset_y = -1.0 + draw_step_y * i as f32;
                for j in 0..draw_size_x {
                    let offset_x = -1.0 + draw_step_x * j as f32;

                    output.push([offset_x, offset_y, 0.0, 1.0]);
                    output.push([offset_x + draw_step_x, offset_y, 0.0, 1.0]);
                    output.push([offset_x, offset_y + draw_step_y, 0.0, 1.0]);

                    output.push([offset_x + draw_step_x, offset_y, 0.0, 1.0]);
                    output.push([offset_x + draw_step_x, offset_y + draw_step_y, 0.0, 1.0]);
                    output.push([offset_x, offset_y + draw_step_y, 0.0, 1.0]);
                }
            }
        }
    }
    Ok(())
}

/// `TrianglesAdjacencyGen`
pub(super) fn triangles_adjacency_gen(context: &Context, draw_size_x: u32, draw_size_y: u32, output: &mut Vec<Color>) {
    // A quarter pixel of jitter keeps triangle edges off fragment centers.
    let jig_x = 0.5 / window_width(context) as f32;
    let jig_y = 0.5 / window_height(context) as f32;

    let size_x = 1.0 / draw_size_x as f32;
    let size_y = 1.0 / draw_size_y as f32;

    for i in 0..draw_size_x {
        let offset_y = -0.5 + jig_y + size_y * i as f32;
        for j in 0..draw_size_y {
            let offset_x = -0.5 + jig_x + size_x * j as f32;

            output.push([offset_x, offset_y, 0.0, 1.0]);
            output.push([offset_x - size_x, offset_y + size_y, 0.0, 1.0]);
            output.push([offset_x, offset_y + size_y, 0.0, 1.0]);
            output.push([offset_x + size_x, offset_y + size_y, 0.0, 1.0]);
            output.push([offset_x + size_x, offset_y, 0.0, 1.0]);
            output.push([offset_x + size_x, offset_y - size_y, 0.0, 1.0]);

            output.push([offset_x + size_x, offset_y + size_y, 0.0, 1.0]);
            output.push([offset_x + 2.0 * size_x, offset_y, 0.0, 1.0]);
            output.push([offset_x + size_x, offset_y, 0.0, 1.0]);
            output.push([offset_x, offset_y, 0.0, 1.0]);
            output.push([offset_x, offset_y + size_y, 0.0, 1.0]);
            output.push([offset_x, offset_y + 2.0 * size_y, 0.0, 1.0]);
        }
    }
}

/// `TriangleStripAdjacencyGen`
pub(super) fn triangle_strip_adjacency_gen(
    context: &Context,
    draw_size_x: u32,
    draw_size_y: u32,
    output: &mut Vec<Color>,
) {
    let jig_x = 0.5 / window_width(context) as f32;
    let jig_y = 0.5 / window_height(context) as f32;

    let size_x = 1.0 / draw_size_x as f32;
    let size_y = 1.0 / draw_size_y as f32;

    for i in 0..draw_size_x {
        let offset_y = -0.5 + jig_y + size_y * i as f32;
        for j in 0..draw_size_y {
            let offset_x = -0.5 + jig_x + size_x * j as f32;

            output.push([offset_x, offset_y, 0.0, 1.0]);
            output.push([offset_x - size_x, offset_y + size_y, 0.0, 1.0]);
            output.push([offset_x, offset_y + size_y, 0.0, 1.0]);
            output.push([offset_x + size_x, offset_y - size_y, 0.0, 1.0]);
            output.push([offset_x + size_x, offset_y, 0.0, 1.0]);
            output.push([offset_x, offset_y + 2.0 * size_y, 0.0, 1.0]);
            output.push([offset_x + size_x, offset_y + size_y, 0.0, 1.0]);
            output.push([offset_x + 2.0 * size_x, offset_y - size_y, 0.0, 1.0]);
        }
    }
}

/// `PrimitiveGen`
pub(super) fn primitive_gen(
    context: &Context,
    primitive_type: GLenum,
    draw_size_x: u32,
    draw_size_y: u32,
    output: &mut Vec<Color>,
) -> Result<(), crate::tcu::TestError> {
    match primitive_type {
        glw::GL_POINTS => points_gen(context, draw_size_x, draw_size_y, output),
        glw::GL_LINES | glw::GL_LINE_STRIP | glw::GL_LINE_LOOP => lines_gen(context, draw_size_y, output),
        glw::GL_LINES_ADJACENCY => lines_adjacency_gen(context, draw_size_y, output),
        glw::GL_LINE_STRIP_ADJACENCY => line_strip_adjacency_gen(context, draw_size_y, output),
        glw::GL_TRIANGLES | glw::GL_TRIANGLE_STRIP | glw::GL_TRIANGLE_FAN => {
            triangles_gen(draw_size_x, draw_size_y, output)?
        }
        glw::GL_TRIANGLES_ADJACENCY => triangles_adjacency_gen(context, draw_size_x, draw_size_y, output),
        glw::GL_TRIANGLE_STRIP_ADJACENCY => triangle_strip_adjacency_gen(context, draw_size_x, draw_size_y, output),
        _ => return Err(crate::tcu::TestError::Fail("Unknown primitive type!".to_string())),
    }
    Ok(())
}

/// `shaders::vshSimple<GL>`
pub(super) fn vsh_simple() -> String {
    format!("{GLSL_VER_GL}\nin vec4 i_vertex;\nvoid main()\n{{\n    gl_Position = i_vertex;\n}}")
}

/// `shaders::vshSimple_point<GL>`
pub(super) fn vsh_simple_point() -> String {
    format!(
        "{GLSL_VER_GL}\nin vec4 i_vertex;\nvoid main()\n{{\n    gl_Position = i_vertex;\n#if defined(GL_ES)\n    gl_PointSize = 1.0;\n#endif\n}}"
    )
}

/// `shaders::fshSimple<GL>`
pub(super) fn fsh_simple() -> String {
    format!(
        "{GLSL_VER_GL}\nprecision highp float; \nout vec4 outColor;\nvoid main() {{\n  outColor = vec4(0.1,0.2,0.3,1.0);\n}}"
    )
}

pub(super) fn add_case(
    group: &mut TestCaseGroup,
    name: &str,
    factory: impl Fn() -> Box<dyn Subcase> + Send + Sync + 'static,
) {
    group.add_child(Box::new(TestSubcase::new(name, factory)) as Box<dyn TestCase>);
}

/// `DrawIndirectTestsGL40::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("draw_indirect");
    buffer_cases::add_binding_and_buffer_cases(&mut group);
    draw_cases::add_draw_cases(&mut group);
    mode_cases::add_mode_cases(&mut group);
    advanced_cases::add_advanced_cases(&mut group);
    negative_cases::add_negative_cases(&mut group);
    group
}

/// `DrawIndirectTestsGL43::init`
pub fn create_tests_43() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("draw_indirect_43");
    advanced_cases::add_compute_cases(&mut group);
    group
}
