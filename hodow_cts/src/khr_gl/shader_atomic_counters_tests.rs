// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderAtomicCountersTests.cpp
//   external/openglcts/modules/gl/gl4cShaderAtomicCountersTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case classes are `Subcase`s (see `subcase.rs`); `SACSubcaseBase`'s helpers are free functions taking the `Context`/`Functions`, and `Buffer` is a struct holding the expected state. The `*-usage-no-offset` and `*-fs` cases share one struct (the shader differs).

use std::collections::BTreeMap;
use std::ffi::{CStr, CString, c_void};

use super::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult, TestSubcase, output_not_supported};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLint64, GLuint};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Surface, TestError};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const TEXT_VS: &str =
    "#version 420 core\nlayout(location = 0) in vec4 i_vertex;\nvoid main() {\n  gl_Position = i_vertex;\n}";

fn get_integer(gl: &glw::Functions, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_integerv(pname, &mut value));
    value
}

/// `ValidateReadBuffer`
fn validate_read_buffer(context: &Context, expected: [f32; 4]) -> Result<i64, TestError> {
    let render_target = context.render_target();
    let (width, height) = (render_target.width, render_target.height);
    let mut rendered_frame = Surface::new(width, height);
    let mut reference_frame = Surface::new(width, height);

    glu::read_pixels(&context.render_context, 0, 0, &mut rendered_frame.get_access())?;

    let color = RGBA::new(
        (expected[0] * 255.0) as i32,
        (expected[1] * 255.0) as i32,
        (expected[2] * 255.0) as i32,
        (expected[3] * 255.0) as i32,
    );
    for y in 0..height {
        for x in 0..width {
            reference_frame.set_pixel(x, y, color);
        }
    }
    let is_ok = fuzzy_compare_ok(
        &reference_frame.get_const_access(),
        &rendered_frame.get_const_access(),
        0.05,
    )
    .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;
    Ok(if is_ok { NO_ERROR } else { ERROR })
}

fn link_program(gl: &glw::Functions, program: GLuint) {
    gl!(gl.link_program(program));
    let mut length = 0;
    let mut info_log = [0u8; 1024];
    gl!(gl.get_program_info_log(
        program,
        info_log.len() as i32,
        &mut length,
        info_log.as_mut_ptr().cast()
    ));
    if length > 1 {
        log::info!(
            "Program Info Log:\n{}",
            String::from_utf8_lossy(&info_log[..length as usize])
        );
    }
}

fn attach_shader_source(gl: &glw::Functions, program: GLuint, shader_type: GLenum, source: &str) {
    let source = CString::new(source).expect("shader source holds no nul byte");
    let pointer = source.as_ptr();
    let shader = gl!(gl.create_shader(shader_type));
    gl!(gl.attach_shader(program, shader));
    gl!(gl.delete_shader(shader));
    gl!(gl.shader_source(shader, 1, &pointer, std::ptr::null()));
    gl!(gl.compile_shader(shader));
}

/// `CreateProgram`
fn create_program(
    gl: &glw::Functions,
    vs: Option<&str>,
    tcs: Option<&str>,
    tes: Option<&str>,
    gs: Option<&str>,
    fs: Option<&str>,
    link: bool,
) -> GLuint {
    let program = gl!(gl.create_program());
    let stages = [
        (glw::GL_VERTEX_SHADER, vs),
        (glw::GL_TESS_CONTROL_SHADER, tcs),
        (glw::GL_TESS_EVALUATION_SHADER, tes),
        (glw::GL_GEOMETRY_SHADER, gs),
        (glw::GL_FRAGMENT_SHADER, fs),
    ];
    for (shader_type, source) in stages {
        if let Some(source) = source {
            attach_shader_source(gl, program, shader_type, source);
        }
    }
    if link {
        link_program(gl, program);
    }
    program
}

/// `CheckProgram`
fn check_program(gl: &glw::Functions, program: GLuint) -> bool {
    let mut status = 0;
    gl!(gl.get_programiv(program, glw::GL_LINK_STATUS, &mut status));
    let mut length = 0;
    gl!(gl.get_programiv(program, glw::GL_INFO_LOG_LENGTH, &mut length));
    if length > 1 {
        let mut info_log = vec![0u8; length as usize];
        gl!(gl.get_program_info_log(program, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
        log::info!("{}", String::from_utf8_lossy(&info_log));
    }
    status == glw::GL_TRUE as GLint
}

const QUAD_VERTICES: [f32; 44] = [
    -1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0,
    -1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0,
];

/// `CreateQuad`
fn create_quad(gl: &glw::Functions, vao: &mut GLuint, vbo: &mut GLuint) {
    create_vertex_array(gl, &QUAD_VERTICES, vao, vbo);
}

fn gl_enum_to_string(e: GLenum) -> &'static str {
    match e {
        glw::GL_ATOMIC_COUNTER_BUFFER_BINDING => "GL_ATOMIC_COUNTER_BUFFER_BINDING",
        glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS => "GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS",
        glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS => "GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS",
        glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS => "GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS",
        glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS => "GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS",
        glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS => "GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS",
        glw::GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS => "GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS",
        glw::GL_MAX_VERTEX_ATOMIC_COUNTERS => "GL_MAX_VERTEX_ATOMIC_COUNTERS",
        glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS => "GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS",
        glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS => "GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS",
        glw::GL_MAX_GEOMETRY_ATOMIC_COUNTERS => "GL_MAX_GEOMETRY_ATOMIC_COUNTERS",
        glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS => "GL_MAX_FRAGMENT_ATOMIC_COUNTERS",
        glw::GL_MAX_COMBINED_ATOMIC_COUNTERS => "GL_MAX_COMBINED_ATOMIC_COUNTERS",
        glw::GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE => "GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE",
        glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS => "GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS",
        _ => unreachable!("GLenumToString: unexpected enum"),
    }
}

/// `CheckMaxValue`
fn check_max_value(gl: &glw::Functions, e: GLenum, expected: GLint) -> bool {
    let mut ok = true;
    let name = gl_enum_to_string(e);

    let i = get_integer(gl, e);
    log::info!("{name} = {i}");
    if i < expected {
        ok = false;
        log::info!("{name} state is incorrect (GetIntegerv, is: {i}, expected: {expected})");
    }

    let mut i64_value: GLint64 = 0;
    gl!(gl.get_integer_64v(e, &mut i64_value));
    if i64_value < expected as GLint64 {
        ok = false;
        log::info!(
            "{name} state is incorrect (GetInteger64v, is: {}, expected: {expected})",
            i64_value as GLint
        );
    }

    let mut f = 0.0f32;
    gl!(gl.get_floatv(e, &mut f));
    if f < expected as f32 {
        ok = false;
        log::info!("{name} state is incorrect (GetFloatv, is: {f}, expected: {expected})");
    }

    let mut d = 0.0f64;
    gl!(gl.get_doublev(e, &mut d));
    if d < expected as f64 {
        ok = false;
        log::info!("{name} state is incorrect (GetDoublev, is: {d}, expected: {expected})");
    }

    let mut b = 0;
    gl!(gl.get_booleanv(e, &mut b));

    ok
}

/// `CheckGetCommands`
fn check_get_commands(gl: &glw::Functions, e: GLenum, expected: GLint) -> bool {
    let mut ok = true;
    let name = gl_enum_to_string(e);

    let i = get_integer(gl, e);
    if i != expected {
        ok = false;
        log::info!("{name} state is incorrect (GetIntegerv, is: {i}, expected: {expected})");
    }

    let mut i64_value: GLint64 = 0;
    gl!(gl.get_integer_64v(e, &mut i64_value));
    if i64_value != expected as GLint64 {
        ok = false;
        log::info!(
            "{name} state is incorrect (GetInteger64v, is: {}, expected: {expected})",
            i64_value as GLint
        );
    }

    let mut f = 0.0f32;
    gl!(gl.get_floatv(e, &mut f));
    if f != expected as f32 {
        ok = false;
        log::info!("{name} state is incorrect (GetFloatv, is: {f}, expected: {expected})");
    }

    let mut d = 0.0f64;
    gl!(gl.get_doublev(e, &mut d));
    if d != expected as f64 {
        ok = false;
        log::info!("{name} state is incorrect (GetDoublev, is: {d}, expected: {expected})");
    }

    let mut b = 0;
    gl!(gl.get_booleanv(e, &mut b));
    let expected_boolean = u8::from(expected != 0);
    if b != expected_boolean {
        ok = false;
        log::info!("{name} state is incorrect (GetBooleanv, is: {b}, expected: {expected_boolean})");
    }

    ok
}

/// `CheckBufferBindingState`
fn check_buffer_binding_state(
    gl: &glw::Functions,
    index: GLuint,
    binding: GLint,
    start: GLint64,
    size: GLint64,
) -> bool {
    let mut ok = true;

    let mut i = 0;
    gl!(gl.get_integeri_v(glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, index, &mut i));
    if i != binding {
        ok = false;
        log::info!(
            "GL_ATOMIC_COUNTER_BUFFER_BINDING state is incorrect (GetIntegeri_v, is: {i}, expected: {binding}, index: {index})"
        );
    }

    let mut i64_value: GLint64 = 0;
    gl!(gl.get_integer_64i_v(glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, index, &mut i64_value));
    if i64_value != binding as GLint64 {
        ok = false;
        log::info!(
            "GL_ATOMIC_COUNTER_BUFFER_BINDING state is incorrect (GetInteger64i_v, is: {}, expected: {binding}, index: {index})",
            i64_value as GLint
        );
    }

    let mut f = 0.0f32;
    gl!(gl.get_floati_v(glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, index, &mut f));
    if f != binding as f32 {
        ok = false;
        log::info!(
            "GL_ATOMIC_COUNTER_BUFFER_BINDING state is incorrect (GetFloati_v, is: {f}, expected: {binding}, index: {index})"
        );
    }

    let mut d = 0.0f64;
    gl!(gl.get_doublei_v(glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, index, &mut d));
    if d != binding as f64 {
        ok = false;
        log::info!(
            "GL_ATOMIC_COUNTER_BUFFER_BINDING state is incorrect (GetDoublei_v, is: {d}, expected: {binding}, index: {index})"
        );
    }

    let mut b = 0;
    gl!(gl.get_booleani_v(glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, index, &mut b));
    let expected_boolean = u8::from(binding != 0);
    if b != expected_boolean {
        ok = false;
        log::info!(
            "GL_ATOMIC_COUNTER_BUFFER_BINDING state is incorrect (GetBooleani_v, is: {d}, expected: {expected_boolean}, index: {index})"
        );
    }

    gl!(gl.get_integer_64i_v(glw::GL_ATOMIC_COUNTER_BUFFER_START, index, &mut i64_value));
    if i64_value != start {
        ok = false;
        log::info!(
            "GL_ATOMIC_COUNTER_BUFFER_START state is incorrect (GetInteger64i_v, is: {}, expected: {}, index: {index})",
            i64_value as GLint,
            start as GLint
        );
    }
    gl!(gl.get_integer_64i_v(glw::GL_ATOMIC_COUNTER_BUFFER_SIZE, index, &mut i64_value));
    if i64_value != size && i64_value != 0 {
        ok = false;
        log::info!(
            "GL_ATOMIC_COUNTER_BUFFER_SIZE state is incorrect (GetInteger64i_v, is: {}, expected: {}, index: {index})",
            i64_value as GLint,
            size as GLint
        );
    }

    ok
}

fn buffer_to_string(buffer: &[u8]) -> String {
    CStr::from_bytes_until_nul(buffer)
        .map(|name| name.to_string_lossy().into_owned())
        .unwrap_or_else(|_| String::from_utf8_lossy(buffer).into_owned())
}

fn get_active_uniformsiv_one(gl: &glw::Functions, program: GLuint, index: GLuint, pname: GLenum) -> GLint {
    let mut param = 0;
    gl!(gl.get_active_uniformsiv(program, 1, &index, pname, &mut param));
    param
}

/// `CheckUniform`
#[allow(clippy::too_many_arguments)]
fn check_uniform(
    gl: &glw::Functions,
    program: GLuint,
    uniform_name: &str,
    uniform_index: GLuint,
    uniform_type: GLint,
    uniform_size: GLint,
    uniform_offset: GLint,
    uniform_array_stride: GLint,
    buffer_index: GLuint,
) -> bool {
    let mut ok = true;

    let c_name = CString::new(uniform_name).expect("uniform name holds no nul byte");
    let name_pointer = c_name.as_ptr();
    let mut index: GLuint = 0;
    gl!(gl.get_uniform_indices(program, 1, &name_pointer, &mut index));
    if index != uniform_index {
        log::info!("Uniform: {uniform_name}: Bad index returned by glGetUniformIndices.");
        ok = false;
    }

    let uniform_length = uniform_name.len() as GLint;

    let mut length: GLint = 0;
    let mut size: GLint = 0;
    let mut type_: GLenum = 0;
    let mut name = [0u8; 32];

    gl!(gl.get_active_uniform_name(
        program,
        uniform_index,
        name.len() as i32,
        &mut length,
        name.as_mut_ptr().cast()
    ));
    if buffer_to_string(&name) != uniform_name {
        log::info!("Uniform: {uniform_name}: Bad name returned by glGetActiveUniformName.");
        ok = false;
    }
    if length != uniform_length {
        log::info!("Uniform: {uniform_name}: Length is {length} should be {uniform_length}");
        ok = false;
    }

    gl!(gl.get_active_uniform(
        program,
        uniform_index,
        name.len() as i32,
        &mut length,
        &mut size,
        &mut type_,
        name.as_mut_ptr().cast()
    ));
    if buffer_to_string(&name) != uniform_name {
        log::info!("Uniform: {uniform_name}: Bad name returned by glGetActiveUniform.");
        ok = false;
    }
    if length != uniform_length {
        log::info!("Uniform: {uniform_name}: Length is {length} should be {uniform_length}");
        ok = false;
    }
    if size != uniform_size {
        log::info!("Uniform: {uniform_name}: Size is {size} should be {uniform_size}");
        ok = false;
    }
    if type_ != uniform_type as GLenum {
        log::info!("Uniform: {uniform_name}: Type is {type_} should be {uniform_type}");
        ok = false;
    }

    let param = get_active_uniformsiv_one(gl, program, uniform_index, glw::GL_UNIFORM_TYPE);
    if param != uniform_type {
        log::info!("Uniform: {uniform_name}: Type is {param} should be {uniform_type}");
        ok = false;
    }
    let param = get_active_uniformsiv_one(gl, program, uniform_index, glw::GL_UNIFORM_SIZE);
    if param != uniform_size {
        log::info!("Uniform: {uniform_name}: GL_UNIFORM_SIZE is {param} should be {uniform_size}");
        ok = false;
    }
    let param = get_active_uniformsiv_one(gl, program, uniform_index, glw::GL_UNIFORM_NAME_LENGTH);
    if param != uniform_length + 1 {
        log::info!(
            "Uniform: {uniform_name}: GL_UNIFORM_NAME_LENGTH is {param} should be {}",
            uniform_length + 1
        );
        ok = false;
    }
    let param = get_active_uniformsiv_one(gl, program, uniform_index, glw::GL_UNIFORM_BLOCK_INDEX);
    if param != -1 {
        log::info!("Uniform: {uniform_name}: GL_UNIFORM_BLOCK_INDEX should be -1.");
        ok = false;
    }
    let param = get_active_uniformsiv_one(gl, program, uniform_index, glw::GL_UNIFORM_OFFSET);
    if param != uniform_offset {
        log::info!("Uniform: {uniform_name}: GL_UNIFORM_OFFSET is {param} should be {uniform_offset}");
        ok = false;
    }
    let param = get_active_uniformsiv_one(gl, program, uniform_index, glw::GL_UNIFORM_ARRAY_STRIDE);
    if param != uniform_array_stride {
        log::info!("Uniform: {uniform_name}: GL_UNIFORM_ARRAY_STRIDE is {param} should be {uniform_array_stride}");
        ok = false;
    }
    let param = get_active_uniformsiv_one(gl, program, uniform_index, glw::GL_UNIFORM_MATRIX_STRIDE);
    if param != 0 {
        log::info!("Uniform: {uniform_name}: GL_UNIFORM_MATRIX_STRIDE should be 0 is {param}");
        ok = false;
    }
    let param = get_active_uniformsiv_one(gl, program, uniform_index, glw::GL_UNIFORM_IS_ROW_MAJOR);
    if param != 0 {
        log::info!("Uniform: {uniform_name}: GL_UNIFORM_IS_ROW_MAJOR should be 0 is {param}");
        ok = false;
    }
    let param = get_active_uniformsiv_one(gl, program, uniform_index, glw::GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX);
    if param != buffer_index as GLint {
        log::info!(
            "Uniform: {uniform_name}: GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX is {param} should be {buffer_index}"
        );
        ok = false;
    }

    ok
}

/// `CheckCounterValues`
fn check_counter_values(values: &mut [GLuint], min_value: GLuint) -> bool {
    values.sort_unstable();
    for (i, &value) in values.iter().enumerate() {
        log::info!("{value}");
        let expected = i as GLuint + min_value;
        if value != expected {
            log::info!("Counter value is {value} should be {expected}");
            return false;
        }
    }
    true
}

/// `CheckFinalCounterValue`
fn check_final_counter_value(gl: &glw::Functions, buffer: GLuint, offset: isize, expected_value: GLuint) -> bool {
    let mut value: GLuint = 0;
    gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, buffer));
    gl!(gl.get_buffer_sub_data(
        glw::GL_ATOMIC_COUNTER_BUFFER,
        offset,
        4,
        std::ptr::from_mut(&mut value).cast()
    ));
    if value != expected_value {
        log::info!("Counter value is {value} should be {expected_value}");
        return false;
    }
    true
}

/// A counter buffer written through an invalidating `glMapBufferRange`, as every case does before drawing.
fn init_counter_buffer(gl: &glw::Functions, buffer: GLuint, bytes: isize, values: &[(usize, GLuint)]) {
    gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, buffer));
    let ptr = gl!(gl.map_buffer_range(
        glw::GL_ATOMIC_COUNTER_BUFFER,
        0,
        bytes,
        glw::GL_MAP_WRITE_BIT | glw::GL_MAP_INVALIDATE_BUFFER_BIT
    ))
    .cast::<GLuint>();
    if !ptr.is_null() {
        for &(index, value) in values {
            // SAFETY: the mapped range is `bytes` long and every index written is inside it.
            unsafe { ptr.add(index).write(value) };
        }
    }
    gl!(gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER));
}

fn gen_buffer_with_data(gl: &glw::Functions, buffer: &mut GLuint, target: GLenum, size: isize, usage: GLenum) {
    gl!(gl.gen_buffers(1, buffer));
    gl!(gl.bind_buffer(target, *buffer));
    gl!(gl.buffer_data(target, size, std::ptr::null(), usage));
    gl!(gl.bind_buffer(target, 0));
}

fn gen_transform_feedback_buffers(gl: &glw::Functions, buffers: &mut [GLuint; 2]) {
    gl!(gl.gen_buffers(2, buffers.as_mut_ptr()));
    for buffer in *buffers {
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buffer));
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            1000,
            std::ptr::null(),
            glw::GL_STREAM_COPY
        ));
    }
    gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
}

/// The array buffer of 32 zero `uint`s.
fn create_zero_uint_buffer(gl: &glw::Functions, array_buffer: &mut GLuint) {
    let data = [0u32; 32];
    gl!(gl.gen_buffers(1, array_buffer));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *array_buffer));
    gl!(gl.buffer_data(
        glw::GL_ARRAY_BUFFER,
        std::mem::size_of_val(&data) as isize,
        data.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
}

fn setup_zero_uint_vao(gl: &glw::Functions, array_buffer: GLuint, vao: &mut GLuint) {
    gl!(gl.gen_vertex_arrays(1, vao));
    gl!(gl.bind_vertex_array(*vao));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, array_buffer));
    gl!(gl.vertex_attrib_i_pointer(0, 1, glw::GL_UNSIGNED_INT, 0, std::ptr::null()));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    gl!(gl.enable_vertex_attrib_array(0));
    gl!(gl.bind_vertex_array(0));
}

fn set_xfb_varyings_and_link(gl: &glw::Functions, program: GLuint) {
    let varyings = [c"o_atomic_inc".as_ptr(), c"o_atomic_dec".as_ptr()];
    gl!(gl.transform_feedback_varyings(program, 2, varyings.as_ptr(), glw::GL_SEPARATE_ATTRIBS));
    link_program(gl, program);
}

fn read_xfb_buffer(gl: &glw::Functions, buffer: GLuint, data: &mut [GLuint]) {
    gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, buffer));
    gl!(gl.get_buffer_sub_data(
        glw::GL_TRANSFORM_FEEDBACK_BUFFER,
        0,
        std::mem::size_of_val(data) as isize,
        data.as_mut_ptr().cast()
    ));
}

/// `Buffer`
struct Buffer<'a> {
    gl: &'a glw::Functions,
    name: GLuint,
    size: GLint64,
    usage: GLenum,
    access: GLenum,
    access_flags: GLint,
    mapped: u8,
    map_pointer: *mut c_void,
    map_offset: GLint64,
    map_length: GLint64,
}

impl<'a> Buffer<'a> {
    fn new(gl: &'a glw::Functions) -> Self {
        let mut name = 0;
        gl!(gl.gen_buffers(1, &mut name));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, name));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));
        Self {
            gl,
            name,
            size: 0,
            usage: glw::GL_STATIC_DRAW,
            access: glw::GL_READ_WRITE,
            access_flags: 0,
            mapped: glw::FALSE,
            map_pointer: std::ptr::null_mut(),
            map_offset: 0,
            map_length: 0,
        }
    }

    fn verify(&self) -> i64 {
        let gl = self.gl;
        let mut i: GLint = 0;
        let mut i64_value: GLint64 = 0;

        gl!(gl.get_buffer_parameteri_64v(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_BUFFER_SIZE, &mut i64_value));
        if i64_value != self.size {
            log::info!("BUFFER_SIZE is {} should be {}", i64_value as GLint, self.size as GLint);
            return ERROR;
        }
        gl!(gl.get_buffer_parameteriv(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_BUFFER_USAGE, &mut i));
        if i != self.usage as GLint {
            log::info!("BUFFER_USAGE is {i} should be {}", self.usage);
            return ERROR;
        }
        gl!(gl.get_buffer_parameteriv(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_BUFFER_ACCESS, &mut i));
        if i != self.access as GLint {
            log::info!("BUFFER_ACCESS is {i} should be {}", self.access);
            return ERROR;
        }
        gl!(gl.get_buffer_parameteriv(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_BUFFER_ACCESS_FLAGS, &mut i));
        if i != self.access_flags {
            log::info!("BUFFER_ACCESS_FLAGS is {i} should be {}", self.access_flags);
            return ERROR;
        }
        gl!(gl.get_buffer_parameteriv(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_BUFFER_MAPPED, &mut i));
        if i != GLint::from(self.mapped) {
            log::info!("BUFFER_MAPPED is {i} should be {}", self.mapped);
            return ERROR;
        }
        gl!(gl.get_buffer_parameteri_64v(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_BUFFER_MAP_OFFSET, &mut i64_value));
        if i64_value != self.map_offset {
            log::info!(
                "BUFFER_MAP_OFFSET is {} should be {}",
                i64_value as GLint,
                self.map_offset
            );
            return ERROR;
        }
        gl!(gl.get_buffer_parameteri_64v(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_BUFFER_MAP_LENGTH, &mut i64_value));
        if i64_value != self.map_length {
            log::info!(
                "BUFFER_MAP_LENGTH is {} should be {}",
                i64_value as GLint,
                self.map_length as GLint
            );
            return ERROR;
        }

        let mut ptr: *mut c_void = std::ptr::null_mut();
        gl!(gl.get_buffer_pointerv(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_BUFFER_MAP_POINTER, &mut ptr));
        if ptr != self.map_pointer {
            log::info!("BUFFER_MAP_POINTER is {ptr:?} should be {:?}", self.map_pointer);
            return ERROR;
        }
        NO_ERROR
    }

    fn data(&mut self, size: isize, usage: GLenum) {
        self.size = size as GLint64;
        self.usage = usage;
        gl!(self
            .gl
            .buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, size, std::ptr::null(), usage));
    }

    fn map_range(&mut self, offset: isize, length: isize, access: u32) -> *mut c_void {
        debug_assert!(self.mapped == glw::FALSE);
        self.map_pointer = gl!(self
            .gl
            .map_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, offset, length, access));
        if !self.map_pointer.is_null() {
            self.map_offset = offset as GLint64;
            self.map_length = length as GLint64;
            self.access_flags = access as GLint;
            if access & glw::GL_MAP_WRITE_BIT != 0 && access & glw::GL_MAP_READ_BIT != 0 {
                self.access = glw::GL_READ_WRITE;
            } else if access & glw::GL_MAP_READ_BIT != 0 {
                self.access = glw::GL_READ_ONLY;
            } else if access & glw::GL_MAP_WRITE_BIT != 0 {
                self.access = glw::GL_WRITE_ONLY;
            }
            self.mapped = glw::TRUE;
        }
        self.map_pointer
    }

    fn map(&mut self, access: GLenum) -> *mut c_void {
        debug_assert!(self.mapped == glw::FALSE);
        self.map_pointer = gl!(self.gl.map_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, access));
        if !self.map_pointer.is_null() {
            self.mapped = glw::TRUE;
            self.access = access;
            if access == glw::GL_READ_WRITE {
                self.access_flags = (glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT) as GLint;
            } else if access == glw::GL_READ_ONLY {
                self.access_flags = glw::GL_MAP_READ_BIT as GLint;
            } else if access == glw::GL_WRITE_ONLY {
                self.access_flags = glw::GL_MAP_WRITE_BIT as GLint;
            }
            self.map_offset = 0;
            self.map_length = self.size;
        }
        self.map_pointer
    }

    fn unmap(&mut self) -> u8 {
        debug_assert!(self.mapped == glw::TRUE);
        if gl!(self.gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER)) != 0 {
            self.map_offset = 0;
            self.map_length = 0;
            self.map_pointer = std::ptr::null_mut();
            self.mapped = glw::FALSE;
            self.access_flags = 0;
            self.access = glw::GL_READ_WRITE;
            return glw::TRUE;
        }
        glw::FALSE
    }
}

impl Drop for Buffer<'_> {
    fn drop(&mut self) {
        gl!(self.gl.delete_buffers(1, &self.name));
    }
}

// ---------------------------------------------------------------------------------------------------------------------

#[derive(Default)]
struct BasicBufferOperations {
    buffer: GLuint,
}

impl Subcase for BasicBufferOperations {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            8 * 4,
            std::ptr::null(),
            glw::GL_STATIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.buffer));
        let ptr = gl!(gl.map_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, glw::GL_WRITE_ONLY)).cast::<GLuint>();
        for i in 0..8 {
            // SAFETY: the buffer was allocated with 8 uints and is mapped.
            unsafe { ptr.add(i).write(i as GLuint) };
        }
        gl!(gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        let mut res = NO_ERROR;
        let mut data = [0 as GLuint; 8];
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.buffer));
        gl!(gl.get_buffer_sub_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            0,
            std::mem::size_of_val(&data) as isize,
            data.as_mut_ptr().cast()
        ));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));
        for i in 0..8 {
            if data[i] != i as GLuint {
                log::info!("data[{i}] is: {}should be: {i}", data[i]);
                res = ERROR;
            }
        }
        if res != NO_ERROR {
            return Ok(res);
        }

        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.buffer));
        let ptr =
            gl!(gl.map_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 0, 32, glw::GL_MAP_WRITE_BIT)).cast::<GLuint>();
        for i in 0..8 {
            // SAFETY: as above, 32 bytes are mapped.
            unsafe { ptr.add(i).write(i as GLuint * 2) };
        }
        gl!(gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.buffer));
        let ptr = gl!(gl.map_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 0, 32, glw::GL_MAP_READ_BIT)).cast::<GLuint>();
        for i in 0..8 {
            // SAFETY: as above, 32 bytes are mapped.
            let value = unsafe { ptr.add(i).read() };
            if value != i as GLuint * 2 {
                log::info!("data[{i}] is: {}should be: {}", data[i], i * 2);
                res = ERROR;
            }
        }
        gl!(gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.buffer));
        for i in 0..8 {
            data[i] = i as GLuint * 3;
        }
        gl!(gl.buffer_sub_data(glw::GL_ATOMIC_COUNTER_BUFFER, 0, 32, data.as_ptr().cast()));
        data = [0; 8];
        gl!(gl.get_buffer_sub_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            0,
            std::mem::size_of_val(&data) as isize,
            data.as_mut_ptr().cast()
        ));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));
        for i in 0..8 {
            if data[i] != i as GLuint * 3 {
                log::info!("data[{i}] is: {}should be: {}", data[i], i * 3);
                res = ERROR;
            }
        }
        Ok(res)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

struct BasicBufferState;

impl Subcase for BasicBufferState {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut buffer = Buffer::new(gl);
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, buffer.name));
        if buffer.verify() != NO_ERROR {
            return Ok(ERROR);
        }
        buffer.data(100, glw::GL_DYNAMIC_COPY);
        if buffer.verify() != NO_ERROR {
            return Ok(ERROR);
        }
        buffer.map_range(10, 50, glw::GL_MAP_WRITE_BIT);
        if buffer.verify() != NO_ERROR {
            return Ok(ERROR);
        }
        buffer.unmap();
        if buffer.verify() != NO_ERROR {
            return Ok(ERROR);
        }
        buffer.map(glw::GL_READ_ONLY);
        if buffer.verify() != NO_ERROR {
            return Ok(ERROR);
        }
        buffer.unmap();
        if buffer.verify() != NO_ERROR {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

#[derive(Default)]
struct BasicBufferBind {
    buffer: GLuint,
}

impl Subcase for BasicBufferBind {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let bindings = get_integer(gl, glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS);
        log::info!("MAX_ATOMIC_COUNTER_BUFFER_BINDINGS: {bindings}");

        if !check_get_commands(gl, glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, 0) {
            return Ok(ERROR);
        }
        for index in 0..bindings {
            if !check_buffer_binding_state(gl, index as GLuint, 0, 0, 0) {
                return Ok(ERROR);
            }
        }

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.buffer));
        if !check_get_commands(gl, glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, self.buffer as GLint) {
            return Ok(ERROR);
        }
        for index in 0..bindings {
            if !check_buffer_binding_state(gl, index as GLuint, 0, 0, 0) {
                return Ok(ERROR);
            }
        }

        let mut res = NO_ERROR;
        let buffer = self.buffer as GLint;
        gl!(gl.buffer_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            1000,
            std::ptr::null(),
            glw::GL_DYNAMIC_COPY
        ));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 1, self.buffer));
        if !check_buffer_binding_state(gl, 1, buffer, 0, 1000) {
            res = ERROR;
        }
        if !check_get_commands(gl, glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, buffer) {
            res = ERROR;
        }
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, (bindings / 2) as GLuint, self.buffer));
        if !check_buffer_binding_state(gl, (bindings / 2) as GLuint, buffer, 0, 1000) {
            res = ERROR;
        }
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, (bindings - 1) as GLuint, self.buffer));
        if !check_buffer_binding_state(gl, (bindings - 1) as GLuint, buffer, 0, 1000) {
            res = ERROR;
        }

        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));
        gl!(gl.bind_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 1, self.buffer, 8, 32));
        if !check_buffer_binding_state(gl, 1, buffer, 8, 32) {
            res = ERROR;
        }
        if !check_get_commands(gl, glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, buffer) {
            res = ERROR;
        }
        gl!(gl.bind_buffer_range(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            (bindings / 2) as GLuint,
            self.buffer,
            512,
            100
        ));
        if !check_buffer_binding_state(gl, (bindings / 2) as GLuint, buffer, 512, 100) {
            res = ERROR;
        }
        gl!(gl.bind_buffer_range(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            (bindings - 1) as GLuint,
            self.buffer,
            12,
            128
        ));
        if !check_buffer_binding_state(gl, (bindings - 1) as GLuint, buffer, 12, 128) {
            res = ERROR;
        }

        gl!(gl.delete_buffers(1, &self.buffer));
        self.buffer = 0;

        if get_integer(gl, glw::GL_ATOMIC_COUNTER_BUFFER_BINDING) != 0 {
            log::info!("Generic binding point should be 0 after deleting bound buffer object.");
            res = ERROR;
        }
        for index in 0..bindings {
            let mut i = 0;
            gl!(gl.get_integeri_v(glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, index as GLuint, &mut i));
            if i != 0 {
                log::info!("Binding point %u should be 0 after deleting bound buffer object.");
                res = ERROR;
            }
        }
        Ok(res)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

struct BasicProgramMax;

impl Subcase for BasicProgramMax {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let checks = [
            (glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS, 1),
            (glw::GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE, 32),
            (glw::GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS, 1),
            (glw::GL_MAX_COMBINED_ATOMIC_COUNTERS, 8),
            (glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS, 0),
            (glw::GL_MAX_VERTEX_ATOMIC_COUNTERS, 0),
            (glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS, 0),
            (glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS, 0),
            (glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS, 0),
            (glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS, 0),
            (glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS, 0),
            (glw::GL_MAX_GEOMETRY_ATOMIC_COUNTERS, 0),
            (glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS, 1),
            (glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS, 8),
        ];
        for (pname, expected) in checks {
            if !check_max_value(gl, pname, expected) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }
}

#[derive(Default)]
struct BasicProgramQuery {
    counter_buffer: GLuint,
    vao: GLuint,
    vbo: GLuint,
    prog: GLuint,
}

impl Subcase for BasicProgramQuery {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_fs = "#version 420 core\nlayout(location = 0, index = 0)  out vec4 o_color;\nlayout(binding = 0, offset = 0)  uniform atomic_uint ac_counter0;\nlayout(binding = 0, offset = 4)  uniform atomic_uint ac_counter1;\nlayout(binding = 0)              uniform atomic_uint ac_counter2;\nlayout(binding = 0)              uniform atomic_uint ac_counter67[2];\nlayout(binding = 0)              uniform atomic_uint ac_counter3;\nlayout(binding = 0)              uniform atomic_uint ac_counter4;\nlayout(binding = 0)              uniform atomic_uint ac_counter5;\nvoid main() {\n  uint c = 0;\n  c += atomicCounterIncrement(ac_counter0);\n  c += atomicCounterIncrement(ac_counter1);\n  c += atomicCounterIncrement(ac_counter2);\n  c += atomicCounterIncrement(ac_counter3);\n  c += atomicCounterIncrement(ac_counter4);\n  c += atomicCounterIncrement(ac_counter5);\n  c += atomicCounterIncrement(ac_counter67[0]);\n  c += atomicCounterIncrement(ac_counter67[1]);\n  if (c > 10u) o_color = vec4(0.0, 1.0, 0.0, 1.0);\n  else o_color = vec4(1.0, 0.0, 0.0, 1.0);\n}";
        self.prog = create_program(gl, Some(TEXT_VS), None, None, None, Some(glsl_fs), true);

        let active_buffers = get_program_value(gl, self.prog, glw::GL_ACTIVE_ATOMIC_COUNTER_BUFFERS);
        if active_buffers != 1 {
            log::info!("GL_ACTIVE_ATOMIC_COUNTER_BUFFERS is {active_buffers} should be 1.");
            return Ok(ERROR);
        }

        let mut buffers_binding_index: GLint = 0;
        gl!(gl.get_active_atomic_counter_bufferiv(
            self.prog,
            0,
            glw::GL_ATOMIC_COUNTER_BUFFER_BINDING,
            &mut buffers_binding_index
        ));
        let binding_index = buffers_binding_index as GLuint;

        let mut i: GLint = 0;
        gl!(gl.get_active_atomic_counter_bufferiv(
            self.prog,
            binding_index,
            glw::GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE,
            &mut i
        ));
        if i < 32 {
            log::info!("GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE is {i} should be 32.");
            return Ok(ERROR);
        }
        gl!(gl.get_active_atomic_counter_bufferiv(
            self.prog,
            binding_index,
            glw::GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS,
            &mut i
        ));
        if i != 7 {
            log::info!("GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS is {i} should be 8.");
            return Ok(ERROR);
        }

        let mut indices = [-1 as GLint; 7];
        gl!(gl.get_active_atomic_counter_bufferiv(
            self.prog,
            binding_index,
            glw::GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES,
            indices.as_mut_ptr()
        ));
        log::info!("GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES:");
        for index in indices {
            log::info!("{index}");
            if index == -1 {
                log::info!("Index -1 found!");
                return Ok(ERROR);
            }
        }

        let referenced_by = [
            (
                glw::GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER,
                "GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER",
                glw::GL_FALSE,
            ),
            (
                glw::GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER,
                "GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER",
                glw::GL_FALSE,
            ),
            (
                glw::GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER,
                "GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER",
                glw::GL_FALSE,
            ),
            (
                glw::GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER,
                "GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER",
                glw::GL_FALSE,
            ),
            (
                glw::GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER,
                "GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER",
                glw::GL_TRUE,
            ),
        ];
        for (pname, name, expected) in referenced_by {
            gl!(gl.get_active_atomic_counter_bufferiv(self.prog, binding_index, pname, &mut i));
            if i != expected as GLint {
                log::info!("{name} is {i} should be {}.", expected);
                return Ok(ERROR);
            }
        }

        let active_uniforms = get_program_value(gl, self.prog, glw::GL_ACTIVE_UNIFORMS) as GLuint;
        if active_uniforms != 7 {
            log::info!("GL_ACTIVE_UNIFORMS is {active_uniforms} should be 8.");
            return Ok(ERROR);
        }
        let mut uniforms_name_index: BTreeMap<String, GLuint> = BTreeMap::new();
        for index in 0..active_uniforms {
            let mut name = [0u8; 32];
            gl!(gl.get_active_uniform_name(
                self.prog,
                index,
                name.len() as i32,
                std::ptr::null_mut(),
                name.as_mut_ptr().cast()
            ));
            uniforms_name_index.entry(buffer_to_string(&name)).or_insert(index);
        }

        let uniforms: [(&str, GLint, GLint, GLint); 7] = [
            ("ac_counter0", 1, 0, 0),
            ("ac_counter1", 1, 4, 0),
            ("ac_counter2", 1, 8, 0),
            ("ac_counter3", 1, 20, 0),
            ("ac_counter4", 1, 24, 0),
            ("ac_counter5", 1, 28, 0),
            ("ac_counter67[0]", 2, 12, 4),
        ];
        for (name, size, offset, array_stride) in uniforms {
            let uniform_index = uniforms_name_index.get(name).copied().unwrap_or(0);
            if !check_uniform(
                gl,
                self.prog,
                name,
                uniform_index,
                glw::GL_UNSIGNED_INT_ATOMIC_COUNTER as GLint,
                size,
                offset,
                array_stride,
                binding_index,
            ) {
                return Ok(ERROR);
            }
        }

        gl!(gl.gen_buffers(1, &mut self.counter_buffer));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.counter_buffer));
        let data = [20u32; 7];
        gl!(gl.buffer_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            std::mem::size_of_val(&data) as isize,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        create_quad(gl, &mut self.vao, &mut self.vbo);

        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        if validate_read_buffer(context, [0.0, 1.0, 0.0, 1.0])? != NO_ERROR {
            log::info!("Render target color should be (0.0, 1.0, 0.0, 1.0).");
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_quad_program(context.gl(), self.counter_buffer, self.vao, self.vbo, self.prog);
        Ok(NO_ERROR)
    }
}

fn get_program_value(gl: &glw::Functions, program: GLuint, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_programiv(program, pname, &mut value));
    value
}

fn cleanup_quad_program(gl: &glw::Functions, counter_buffer: GLuint, vao: GLuint, vbo: GLuint, prog: GLuint) {
    gl!(gl.delete_buffers(1, &counter_buffer));
    gl!(gl.delete_vertex_arrays(1, &vao));
    gl!(gl.delete_buffers(1, &vbo));
    gl!(gl.delete_program(prog));
    gl!(gl.use_program(0));
}

#[derive(Default)]
struct BasicUsageSimple {
    counter_buffer: GLuint,
    vao: GLuint,
    vbo: GLuint,
    prog: GLuint,
}

impl Subcase for BasicUsageSimple {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let src_fs = "#version 420 core\nlayout(location = 0) out vec4 o_color;\nlayout(binding = 0, offset = 0) uniform atomic_uint ac_counter;\nvoid main() {\n  uint c = atomicCounterIncrement(ac_counter);\n  float r = float(c / 40u) / 255.0;\n  o_color = vec4(r, 0.0, 0.0, 1.0);\n}";
        self.prog = create_program(gl, Some(TEXT_VS), None, None, None, Some(src_fs), true);

        gen_buffer_with_data(
            gl,
            &mut self.counter_buffer,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            4,
            glw::GL_DYNAMIC_COPY,
        );
        create_quad(gl, &mut self.vao, &mut self.vbo);

        init_counter_buffer(gl, self.counter_buffer, 4, &[(0, 0)]);

        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        validate_read_buffer(context, [1.0, 0.0, 0.0, 1.0])?;
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_quad_program(context.gl(), self.counter_buffer, self.vao, self.vbo, self.prog);
        Ok(NO_ERROR)
    }
}

/// `BasicUsageFS` and `BasicUsageNoOffset`: the same case with offsets given in the layout or left to the compiler.
struct BasicUsageFs {
    explicit_offsets: bool,
    counter_buffer: GLuint,
    vao: GLuint,
    vbo: GLuint,
    prog: GLuint,
    fbo: GLuint,
    rt: [GLuint; 2],
}

impl BasicUsageFs {
    fn new(explicit_offsets: bool) -> Self {
        Self {
            explicit_offsets,
            counter_buffer: 0,
            vao: 0,
            vbo: 0,
            prog: 0,
            fbo: 0,
            rt: [0; 2],
        }
    }
}

impl Subcase for BasicUsageFs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let src_fs = if self.explicit_offsets {
            "#version 420 core\nlayout(location = 0) out uvec4 o_color[2];\nlayout(binding = 0, offset = 0) uniform atomic_uint ac_counter_inc;\nlayout(binding = 0, offset = 4) uniform atomic_uint ac_counter_dec;\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter_inc));\n  o_color[1] = uvec4(atomicCounterDecrement(ac_counter_dec));\n}"
        } else {
            "#version 420 core\nlayout(location = 0) out uvec4 o_color[2];\nlayout(binding = 0) uniform atomic_uint ac_counter_inc;\nlayout(binding = 0) uniform atomic_uint ac_counter_dec;\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter_inc));\n  o_color[1] = uvec4(atomicCounterDecrement(ac_counter_dec));\n}"
        };
        self.prog = create_program(gl, Some(TEXT_VS), None, None, None, Some(src_fs), true);

        gen_buffer_with_data(
            gl,
            &mut self.counter_buffer,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            8,
            glw::GL_DYNAMIC_COPY,
        );

        const S: i32 = 8;
        gl!(gl.gen_textures(2, self.rt.as_mut_ptr()));
        for texture in self.rt {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_R32UI as GLint,
                S,
                S,
                0,
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_INT,
                std::ptr::null()
            ));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        }

        gl!(gl.gen_framebuffers(1, &mut self.fbo));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, self.rt[0], 0));
        gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT1, self.rt[1], 0));
        let draw_buffers = [glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT1];
        gl!(gl.draw_buffers(2, draw_buffers.as_ptr()));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        create_quad(gl, &mut self.vao, &mut self.vbo);

        init_counter_buffer(gl, self.counter_buffer, 8, &[(0, 0), (1, 80)]);

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        gl!(gl.viewport(0, 0, S, S));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        let mut data = [0 as GLuint; (S * S) as usize];
        gl!(gl.read_buffer(glw::GL_COLOR_ATTACHMENT0));
        gl!(gl.read_pixels(
            0,
            0,
            S,
            S,
            glw::GL_RED_INTEGER,
            glw::GL_UNSIGNED_INT,
            data.as_mut_ptr().cast()
        ));
        if !check_counter_values(&mut data, 0) {
            return Ok(ERROR);
        }
        gl!(gl.read_buffer(glw::GL_COLOR_ATTACHMENT1));
        gl!(gl.read_pixels(
            0,
            0,
            S,
            S,
            glw::GL_RED_INTEGER,
            glw::GL_UNSIGNED_INT,
            data.as_mut_ptr().cast()
        ));
        if !check_counter_values(&mut data, 16) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 0, 64) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 4, 16) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_textures(2, self.rt.as_ptr()));
        let render_target = context.render_target();
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));
        cleanup_quad_program(gl, self.counter_buffer, self.vao, self.vbo, self.prog);
        Ok(NO_ERROR)
    }
}

/// `BasicUsageVS`
#[derive(Default)]
struct BasicUsageVs {
    counter_buffer: [GLuint; 2],
    xfb_buffer: [GLuint; 2],
    array_buffer: GLuint,
    vao: GLuint,
    prog: GLuint,
}

impl Subcase for BasicUsageVs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if get_integer(gl, glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS) < 2
            || get_integer(gl, glw::GL_MAX_VERTEX_ATOMIC_COUNTERS) < 2
        {
            return Ok(NO_ERROR);
        }

        let src_vs = "#version 420 core\nlayout(location = 0) in uint i_zero;\nout uint o_atomic_inc;\nout uint o_atomic_dec;\nlayout(binding = 0, offset = 0) uniform atomic_uint ac_counter_inc;\nlayout(binding = 1, offset = 0) uniform atomic_uint ac_counter_dec;\nvoid main() {\n  o_atomic_inc = i_zero + atomicCounterIncrement(ac_counter_inc);\n  o_atomic_dec = i_zero + atomicCounterDecrement(ac_counter_dec);\n}";
        self.prog = create_program(gl, Some(src_vs), None, None, None, None, false);
        set_xfb_varyings_and_link(gl, self.prog);

        create_zero_uint_buffer(gl, &mut self.array_buffer);

        gl!(gl.gen_buffers(2, self.counter_buffer.as_mut_ptr()));
        for buffer in self.counter_buffer {
            gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, buffer));
            gl!(gl.buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, 4, std::ptr::null(), glw::GL_DYNAMIC_COPY));
        }
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gen_transform_feedback_buffers(gl, &mut self.xfb_buffer);

        init_counter_buffer(gl, self.counter_buffer[0], 4, &[(0, 7)]);
        init_counter_buffer(gl, self.counter_buffer[1], 4, &[(0, 77)]);

        setup_zero_uint_vao(gl, self.array_buffer, &mut self.vao);

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer[0]));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 1, self.counter_buffer[1]));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.xfb_buffer[0]));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, self.xfb_buffer[1]));
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 32));
        gl!(gl.end_transform_feedback());
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));

        let mut data = [0 as GLuint; 32];
        read_xfb_buffer(gl, self.xfb_buffer[0], &mut data);
        if !check_counter_values(&mut data, 7) {
            return Ok(ERROR);
        }
        read_xfb_buffer(gl, self.xfb_buffer[1], &mut data);
        if !check_counter_values(&mut data, 45) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer[0], 0, 39) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer[1], 0, 45) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(2, self.counter_buffer.as_ptr()));
        gl!(gl.delete_buffers(2, self.xfb_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.array_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_program(self.prog));
        gl!(gl.use_program(0));
        Ok(NO_ERROR)
    }
}

/// `BasicUsageGS`
#[derive(Default)]
struct BasicUsageGs {
    counter_buffer: GLuint,
    xfb_buffer: [GLuint; 2],
    array_buffer: GLuint,
    vao: GLuint,
    prog: GLuint,
}

impl Subcase for BasicUsageGs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if get_integer(gl, glw::GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS) < 1
            || get_integer(gl, glw::GL_MAX_GEOMETRY_ATOMIC_COUNTERS) < 2
        {
            return Ok(NO_ERROR);
        }

        let glsl_vs = "#version 420 core\nlayout(location = 0) in uint i_zero;\nout uint vs_zero;\nvoid main() {\n  vs_zero = i_zero;\n}";
        let glsl_gs = "#version 420 core\nlayout(points) in;\nin uint vs_zero[];\nlayout(points, max_vertices = 1) out;\nout uint o_atomic_inc;\nout uint o_atomic_dec;\nlayout(binding = 0, offset = 8) uniform atomic_uint ac_counter_inc;\nlayout(binding = 0, offset = 16) uniform atomic_uint ac_counter_dec;\nvoid main() {\n  o_atomic_inc = vs_zero[0] + atomicCounterIncrement(ac_counter_inc);\n  o_atomic_dec = vs_zero[0] + atomicCounterDecrement(ac_counter_dec);\n  EmitVertex();\n}";
        self.prog = create_program(gl, Some(glsl_vs), None, None, Some(glsl_gs), None, false);
        set_xfb_varyings_and_link(gl, self.prog);

        create_zero_uint_buffer(gl, &mut self.array_buffer);
        gen_buffer_with_data(
            gl,
            &mut self.counter_buffer,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            32,
            glw::GL_DYNAMIC_COPY,
        );
        gen_transform_feedback_buffers(gl, &mut self.xfb_buffer);
        setup_zero_uint_vao(gl, self.array_buffer, &mut self.vao);

        init_counter_buffer(gl, self.counter_buffer, 32, &[(2, 17), (4, 100)]);

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.xfb_buffer[0]));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, self.xfb_buffer[1]));
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 32));
        gl!(gl.end_transform_feedback());
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));

        let mut data = [0 as GLuint; 32];
        read_xfb_buffer(gl, self.xfb_buffer[0], &mut data);
        if !check_counter_values(&mut data, 17) {
            return Ok(ERROR);
        }
        read_xfb_buffer(gl, self.xfb_buffer[1], &mut data);
        if !check_counter_values(&mut data, 68) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 8, 49) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 16, 68) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.counter_buffer));
        gl!(gl.delete_buffers(2, self.xfb_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.array_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_program(self.prog));
        gl!(gl.use_program(0));
        Ok(NO_ERROR)
    }
}

/// `BasicUsageTES`
#[derive(Default)]
struct BasicUsageTes {
    counter_buffer: GLuint,
    xfb_buffer: [GLuint; 2],
    array_buffer: GLuint,
    vao: GLuint,
    prog: GLuint,
}

impl Subcase for BasicUsageTes {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if get_integer(gl, glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS) < 1
            || get_integer(gl, glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS) < 1
        {
            return Ok(NO_ERROR);
        }

        let glsl_vs = "#version 420 core\nlayout(location = 0) in uint i_zero;\nout uint vs_zero;\nvoid main() {\n  vs_zero = i_zero;\n}";
        let glsl_tes = "#version 420 core\nlayout(triangles, equal_spacing, ccw) in;\nin uint vs_zero[];\nout uint o_atomic_inc;\nout uint o_atomic_dec;\nlayout(binding = 0, offset = 128) uniform atomic_uint ac_counter[2];\nvoid main() {\n  o_atomic_inc = vs_zero[0] + vs_zero[31] + atomicCounterIncrement(ac_counter[0]);\n  o_atomic_dec = vs_zero[0] + vs_zero[31] + atomicCounterDecrement(ac_counter[1]);\n}";
        self.prog = create_program(gl, Some(glsl_vs), None, Some(glsl_tes), None, None, false);
        set_xfb_varyings_and_link(gl, self.prog);

        create_zero_uint_buffer(gl, &mut self.array_buffer);
        gen_buffer_with_data(
            gl,
            &mut self.counter_buffer,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            200,
            glw::GL_DYNAMIC_READ,
        );
        gen_transform_feedback_buffers(gl, &mut self.xfb_buffer);
        setup_zero_uint_vao(gl, self.array_buffer, &mut self.vao);

        init_counter_buffer(gl, self.counter_buffer, 180, &[(32, 100000), (33, 111)]);

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.xfb_buffer[0]));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, self.xfb_buffer[1]));
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 32));
        gl!(gl.begin_transform_feedback(glw::GL_TRIANGLES));
        gl!(gl.draw_arrays(glw::GL_PATCHES, 0, 32));
        gl!(gl.end_transform_feedback());
        gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 3));
        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));

        let mut data = [0 as GLuint; 3];
        read_xfb_buffer(gl, self.xfb_buffer[0], &mut data);
        if !check_counter_values(&mut data, 100000) {
            return Ok(ERROR);
        }
        read_xfb_buffer(gl, self.xfb_buffer[1], &mut data);
        if !check_counter_values(&mut data, 108) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 128, 100003) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 132, 108) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.counter_buffer));
        gl!(gl.delete_buffers(2, self.xfb_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.array_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_program(self.prog));
        gl!(gl.use_program(0));
        Ok(NO_ERROR)
    }
}

/// `BasicUsageCS::CreateComputeProgram`
fn create_compute_program(gl: &glw::Functions, cs: &str) -> GLuint {
    let program = gl!(gl.create_program());
    let version = c"#version 420 core \n#extension GL_ARB_compute_shader: require \n#extension GL_ARB_shader_storage_buffer_object: require \n";
    if !cs.is_empty() {
        let shader = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
        gl!(gl.attach_shader(program, shader));
        gl!(gl.delete_shader(shader));
        let source = CString::new(cs).expect("shader source holds no nul byte");
        let sources = [version.as_ptr(), source.as_ptr()];
        gl!(gl.shader_source(shader, 2, sources.as_ptr(), std::ptr::null()));
        gl!(gl.compile_shader(shader));
    }
    program
}

/// `BasicUsageCS::CheckProgram`
fn check_compute_program(gl: &glw::Functions, program: GLuint) -> bool {
    let mut compile_status = glw::GL_TRUE as GLint;
    let status = get_program_value(gl, program, glw::GL_LINK_STATUS);
    if status == glw::GL_FALSE as GLint {
        let attached_shaders = get_program_value(gl, program, glw::GL_ATTACHED_SHADERS);
        if attached_shaders > 0 {
            let mut shaders = vec![0 as GLuint; attached_shaders as usize];
            gl!(gl.get_attached_shaders(program, attached_shaders, std::ptr::null_mut(), shaders.as_mut_ptr()));
            for &shader in &shaders {
                log::info!("*** Compute Shader ***");
                let mut result = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut result));
                if result != glw::GL_TRUE as GLint {
                    compile_status = result;
                }
                let mut length = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_SOURCE_LENGTH, &mut length));
                if length > 0 {
                    let mut source = vec![0u8; length as usize];
                    gl!(gl.get_shader_source(shader, length, std::ptr::null_mut(), source.as_mut_ptr().cast()));
                    log::info!("{}", buffer_to_string(&source));
                }
                gl!(gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut length));
                if length > 0 {
                    let mut info_log = vec![0u8; length as usize];
                    gl!(gl.get_shader_info_log(shader, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
                    log::info!("{}", buffer_to_string(&info_log));
                }
            }
        }
        let length = get_program_value(gl, program, glw::GL_INFO_LOG_LENGTH);
        if length > 0 {
            let mut info_log = vec![0u8; length as usize];
            gl!(gl.get_program_info_log(program, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
            log::info!("{}", buffer_to_string(&info_log));
        }
    }
    if compile_status != glw::GL_TRUE as GLint {
        return false;
    }
    status == glw::GL_TRUE as GLint
}

fn compute_and_ssbo_supported(context: &Context) -> bool {
    context.context_info.is_extension_supported("GL_ARB_compute_shader")
        && context
            .context_info
            .is_extension_supported("GL_ARB_shader_storage_buffer_object")
}

/// `BasicUsageCS`
#[derive(Default)]
struct BasicUsageCs {
    counter_buffer: GLuint,
    prog: GLuint,
    buffer: GLuint,
}

impl Subcase for BasicUsageCs {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !compute_and_ssbo_supported(context) {
            output_not_supported("GL_ARB_shader_storage_buffer_object or GL_ARB_compute_shader not supported");
            return Ok(NO_ERROR);
        }

        let glsl_cs = "\nlayout(local_size_x = 8, local_size_y = 8, local_size_z = 1) in;\nlayout(binding = 0, offset = 0) uniform atomic_uint ac_counter_inc;\nlayout(binding = 0, offset = 4) uniform atomic_uint ac_counter_dec;\nlayout(std430) buffer Output {\n  uint data_inc[256];\n  uint data_dec[256];\n} g_out;\nvoid main() {\n  uint offset = 32 * gl_GlobalInvocationID.y + gl_GlobalInvocationID.x;\n  g_out.data_inc[offset] = atomicCounterIncrement(ac_counter_inc);\n  g_out.data_dec[offset] = atomicCounterDecrement(ac_counter_dec);\n}";
        self.prog = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.prog));
        if !check_compute_program(gl, self.prog) {
            return Ok(ERROR);
        }

        gl!(gl.gen_buffers(1, &mut self.counter_buffer));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        gl!(gl.buffer_data(glw::GL_ATOMIC_COUNTER_BUFFER, 8, std::ptr::null(), glw::GL_DYNAMIC_COPY));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        init_counter_buffer(gl, self.counter_buffer, 8, &[(0, 0), (1, 256)]);

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            512 * 4,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.use_program(self.prog));
        gl!(gl.dispatch_compute(4, 1, 1));

        let mut data = [0 as GLuint; 512];
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        gl!(gl.get_buffer_sub_data(glw::GL_SHADER_STORAGE_BUFFER, 0, 512 * 4, data.as_mut_ptr().cast()));
        data.sort_unstable();
        for i in (0..512).step_by(2) {
            if data[i] != data[i + 1] {
                log::info!("Pair of values should be equal, got: {}, {}", data[i], data[i + 1]);
                return Ok(ERROR);
            }
            if i < 510 && data[i] == data[i + 2] {
                log::info!("Too many same values found: {}, index: {i}", data[i]);
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.counter_buffer));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_program(self.prog));
        gl!(gl.use_program(0));
        Ok(NO_ERROR)
    }
}

/// `BasicGLSLBuiltIn`
#[derive(Default)]
struct BasicGlslBuiltIn {
    prog: GLuint,
    buffer: GLuint,
}

impl Subcase for BasicGlslBuiltIn {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !compute_and_ssbo_supported(context) {
            log::info!("GL_ARB_compute_shader or GL_ARB_shader_storage_buffer_object not supported, skipping test");
            return Ok(NO_ERROR);
        }

        let glsl_cs = "\nlayout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;\nlayout(std430) buffer Output {\n  uint data;\n} g_out;\nuniform int m_vac;\nuniform int m_fac;\nuniform int m_csac;\nuniform int m_cac;\nuniform int m_abuf;\nuniform int m_tcac;\nuniform int m_teac;\nuniform int m_gac;\nvoid main() {\n  uint res = 1u;\n  if (gl_MaxVertexAtomicCounters < 0 || gl_MaxVertexAtomicCounters != m_vac)\n     res = res * 2u;\n  if (gl_MaxFragmentAtomicCounters < 0 || gl_MaxFragmentAtomicCounters != m_fac)\n     res = res * 3u;\n  if (gl_MaxComputeAtomicCounters < 8 || gl_MaxComputeAtomicCounters != m_csac)\n     res = res * 5u;\n  if (gl_MaxCombinedAtomicCounters < 8 || gl_MaxCombinedAtomicCounters != m_cac)\n     res = res * 7u;\n  if (gl_MaxAtomicCounterBindings < 1 || gl_MaxAtomicCounterBindings != m_abuf)\n     res = res * 11u;\n  if (gl_MaxTessControlAtomicCounters < 0 || gl_MaxTessControlAtomicCounters != m_tcac)\n     res = res * 13u;\n  if (gl_MaxTessEvaluationAtomicCounters < 0 || gl_MaxTessEvaluationAtomicCounters != m_teac)\n     res = res * 17u;\n  if (gl_MaxGeometryAtomicCounters < 0 || gl_MaxGeometryAtomicCounters != m_gac)\n     res = res * 19u;\n  g_out.data = res;\n}";
        self.prog = create_compute_program(gl, glsl_cs);
        gl!(gl.link_program(self.prog));
        if !check_compute_program(gl, self.prog) {
            return Ok(ERROR);
        }
        gl!(gl.use_program(self.prog));

        let uniforms = [
            (c"m_vac", glw::GL_MAX_VERTEX_ATOMIC_COUNTERS),
            (c"m_fac", glw::GL_MAX_FRAGMENT_ATOMIC_COUNTERS),
            (c"m_csac", glw::GL_MAX_COMPUTE_ATOMIC_COUNTERS),
            (c"m_cac", glw::GL_MAX_COMBINED_ATOMIC_COUNTERS),
            (c"m_abuf", glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS),
            (c"m_tcac", glw::GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS),
            (c"m_teac", glw::GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS),
            (c"m_gac", glw::GL_MAX_GEOMETRY_ATOMIC_COUNTERS),
        ];
        for (name, pname) in uniforms {
            let value = get_integer(gl, pname);
            let location = gl!(gl.get_uniform_location(self.prog, name.as_ptr()));
            gl!(gl.uniform_1i(location, value));
        }

        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.buffer));
        gl!(gl.buffer_data(glw::GL_SHADER_STORAGE_BUFFER, 4, std::ptr::null(), glw::GL_DYNAMIC_DRAW));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));

        gl!(gl.dispatch_compute(1, 1, 1));

        let mut error = NO_ERROR;
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, self.buffer));
        gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
        let data = gl!(gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, 4, glw::GL_MAP_READ_BIT)).cast::<GLuint>();
        // SAFETY: 4 bytes were mapped for reading.
        let value = unsafe { data.read() };
        if value != 1 {
            log::info!("Expected 1, got: {value}");
            error = ERROR;
        }
        gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
        gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_program(self.prog));
        gl!(gl.use_program(0));
        Ok(NO_ERROR)
    }
}
const TRIANGLE_VERTICES: [f32; 33] = [
    -1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 3.0, -1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0,
    -1.0, 3.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0,
];

/// `CreateQuad` and `CreateTriangle` differ only in their vertex data (the `ebo` argument is unused by every caller)
fn create_vertex_array(gl: &glw::Functions, vertices: &[f32], vao: &mut GLuint, vbo: &mut GLuint) {
    gl!(gl.gen_buffers(1, vbo));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vbo));
    gl!(gl.buffer_data(
        glw::GL_ARRAY_BUFFER,
        std::mem::size_of_val(vertices) as isize,
        vertices.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

    gl!(gl.gen_vertex_arrays(1, vao));
    gl!(gl.bind_vertex_array(*vao));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *vbo));
    let stride = (std::mem::size_of::<f32>() * 11) as i32;
    gl!(gl.vertex_attrib_pointer(0, 2, glw::GL_FLOAT, glw::FALSE, stride, std::ptr::null()));
    gl!(gl.vertex_attrib_pointer(
        1,
        3,
        glw::GL_FLOAT,
        glw::FALSE,
        stride,
        (std::mem::size_of::<f32>() * 2) as *const c_void
    ));
    gl!(gl.vertex_attrib_pointer(
        2,
        3,
        glw::GL_FLOAT,
        glw::FALSE,
        stride,
        (std::mem::size_of::<f32>() * 5) as *const c_void
    ));
    gl!(gl.vertex_attrib_pointer(
        3,
        3,
        glw::GL_FLOAT,
        glw::FALSE,
        stride,
        (std::mem::size_of::<f32>() * 8) as *const c_void
    ));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    for index in 0..4 {
        gl!(gl.enable_vertex_attrib_array(index));
    }
    gl!(gl.bind_vertex_array(0));
}

/// `CreateTriangle`
fn create_triangle(gl: &glw::Functions, vao: &mut GLuint, vbo: &mut GLuint) {
    create_vertex_array(gl, &TRIANGLE_VERTICES, vao, vbo);
}

const RT_SIZE: i32 = 8;

/// The two R32UI render targets and the framebuffer drawing to both, as in the fragment-shader cases.
fn create_uint_render_targets(gl: &glw::Functions, rt: &mut [GLuint; 2], fbo: &mut GLuint) {
    gl!(gl.gen_textures(2, rt.as_mut_ptr()));
    for texture in *rt {
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_R32UI as GLint,
            RT_SIZE,
            RT_SIZE,
            0,
            glw::GL_RED_INTEGER,
            glw::GL_UNSIGNED_INT,
            std::ptr::null()
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
    }
    gl!(gl.gen_framebuffers(1, fbo));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, *fbo));
    gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, rt[0], 0));
    gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT1, rt[1], 0));
    let draw_buffers = [glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT1];
    gl!(gl.draw_buffers(2, draw_buffers.as_ptr()));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
}

fn read_uint_render_target(gl: &glw::Functions, attachment: GLenum, data: &mut [GLuint]) {
    gl!(gl.read_buffer(attachment));
    gl!(gl.read_pixels(
        0,
        0,
        RT_SIZE,
        RT_SIZE,
        glw::GL_RED_INTEGER,
        glw::GL_UNSIGNED_INT,
        data.as_mut_ptr().cast()
    ));
}

fn delete_uint_render_targets(context: &Context, fbo: GLuint, rt: &[GLuint; 2]) {
    let gl = context.gl();
    gl!(gl.delete_framebuffers(1, &fbo));
    gl!(gl.delete_textures(2, rt.as_ptr()));
    let render_target = context.render_target();
    gl!(gl.viewport(0, 0, render_target.width, render_target.height));
}

/// `AdvancedUsageMultiStage`
#[derive(Default)]
struct AdvancedUsageMultiStage {
    counter_buffer: GLuint,
    xfb_buffer: [GLuint; 2],
    vao: GLuint,
    vbo: GLuint,
    prog: GLuint,
    fbo: GLuint,
    rt: [GLuint; 2],
}

impl Subcase for AdvancedUsageMultiStage {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if get_integer(gl, glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS) < 8
            || get_integer(gl, glw::GL_MAX_VERTEX_ATOMIC_COUNTERS) < 2
            || get_integer(gl, glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS) < 8
        {
            return Ok(NO_ERROR);
        }

        let src_vs = "#version 420 core\nlayout(location = 0) in vec4 i_vertex;\nout uint o_atomic_inc;\nout uint o_atomic_dec;\nlayout(binding = 1, offset = 16) uniform atomic_uint ac_counter_inc;\nlayout(binding = 7, offset = 128) uniform atomic_uint ac_counter_dec;\nvoid main() {\n  gl_Position = i_vertex;\n  o_atomic_inc = atomicCounterIncrement(ac_counter_inc);\n  o_atomic_dec = atomicCounterDecrement(ac_counter_dec);\n}";
        let src_fs = "#version 420 core\nlayout(location = 0) out uvec4 o_color[2];\nlayout(binding = 1, offset = 16) uniform atomic_uint ac_counter_inc;\nlayout(binding = 7, offset = 128) uniform atomic_uint ac_counter_dec;\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter_inc));\n  o_color[1] = uvec4(atomicCounterDecrement(ac_counter_dec));\n}";
        self.prog = create_program(gl, Some(src_vs), None, None, None, Some(src_fs), false);
        set_xfb_varyings_and_link(gl, self.prog);

        let init_data = [100 as GLuint; 256];
        gl!(gl.gen_buffers(1, &mut self.counter_buffer));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.counter_buffer));
        gl!(gl.buffer_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            std::mem::size_of_val(&init_data) as isize,
            init_data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY
        ));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gen_transform_feedback_buffers(gl, &mut self.xfb_buffer);
        create_uint_render_targets(gl, &mut self.rt, &mut self.fbo);
        create_triangle(gl, &mut self.vao, &mut self.vbo);

        gl!(gl.bind_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 1, self.counter_buffer, 16, 32));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 7, self.counter_buffer));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.xfb_buffer[0]));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, self.xfb_buffer[1]));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        gl!(gl.viewport(0, 0, RT_SIZE, RT_SIZE));
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.begin_transform_feedback(glw::GL_TRIANGLES));
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));
        gl!(gl.end_transform_feedback());

        const PIXELS: usize = (RT_SIZE * RT_SIZE) as usize;
        let mut data = [0 as GLuint; PIXELS + 3];
        read_uint_render_target(gl, glw::GL_COLOR_ATTACHMENT0, &mut data[..PIXELS]);
        read_xfb_buffer(gl, self.xfb_buffer[0], &mut data[PIXELS..]);
        if !check_counter_values(&mut data, 100) {
            return Ok(ERROR);
        }
        read_uint_render_target(gl, glw::GL_COLOR_ATTACHMENT1, &mut data[..PIXELS]);
        read_xfb_buffer(gl, self.xfb_buffer[1], &mut data[PIXELS..]);
        if !check_counter_values(&mut data, 33) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 32, 167) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 128, 33) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        delete_uint_render_targets(context, self.fbo, &self.rt);
        gl!(gl.delete_buffers(1, &self.counter_buffer));
        gl!(gl.delete_buffers(2, self.xfb_buffer.as_ptr()));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_program(self.prog));
        gl!(gl.use_program(0));
        Ok(NO_ERROR)
    }
}

/// `AdvancedUsageDrawUpdateDraw`
#[derive(Default)]
struct AdvancedUsageDrawUpdateDraw {
    counter_buffer: GLuint,
    vao: GLuint,
    vbo: GLuint,
    prog: GLuint,
    prog2: GLuint,
    fbo: GLuint,
    rt: [GLuint; 2],
}

impl Subcase for AdvancedUsageDrawUpdateDraw {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let src_fs = "#version 420 core\nlayout(location = 0) out uvec4 o_color[2];\nlayout(binding = 0) uniform atomic_uint ac_counter[2];\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter[0]));\n  o_color[1] = uvec4(atomicCounterDecrement(ac_counter[1]));\n}";
        let src_fs2 = "#version 420 core\nlayout(location = 0) out uvec4 o_color[2];\nlayout(binding = 0) uniform atomic_uint ac_counter[2];\nvoid main() {\n  o_color[0] = uvec4(atomicCounter(ac_counter[0]));\n  o_color[1] = uvec4(atomicCounter(ac_counter[1]));\n}";
        self.prog = create_program(gl, Some(TEXT_VS), None, None, None, Some(src_fs), true);
        self.prog2 = create_program(gl, Some(TEXT_VS), None, None, None, Some(src_fs2), true);

        gen_buffer_with_data(
            gl,
            &mut self.counter_buffer,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            8,
            glw::GL_DYNAMIC_COPY,
        );
        create_uint_render_targets(gl, &mut self.rt, &mut self.fbo);
        create_quad(gl, &mut self.vao, &mut self.vbo);

        init_counter_buffer(gl, self.counter_buffer, 8, &[(0, 256), (1, 256)]);

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        gl!(gl.viewport(0, 0, RT_SIZE, RT_SIZE));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.counter_buffer));
        let ptr = gl!(gl.map_buffer_range(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            0,
            8,
            glw::GL_MAP_WRITE_BIT | glw::GL_MAP_READ_BIT
        ))
        .cast::<GLuint>();
        if !ptr.is_null() {
            // SAFETY: 8 bytes are mapped for reading and writing.
            unsafe {
                ptr.write(ptr.read() + 512);
                ptr.add(1).write(ptr.add(1).read() + 1024);
            }
        }
        gl!(gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER));

        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_ATOMIC_COUNTER_BARRIER_BIT));

        gl!(gl.use_program(self.prog2));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        let mut data = [0 as GLuint; (RT_SIZE * RT_SIZE) as usize];
        read_uint_render_target(gl, glw::GL_COLOR_ATTACHMENT0, &mut data);
        for value in data {
            if value != 896 {
                log::info!("Counter value is {value} should be 896.");
                return Ok(ERROR);
            }
        }
        read_uint_render_target(gl, glw::GL_COLOR_ATTACHMENT1, &mut data);
        for value in data {
            if value != 1152 {
                log::info!("Counter value is {value} should be 896.");
                return Ok(ERROR);
            }
        }
        if !check_final_counter_value(gl, self.counter_buffer, 0, 896) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 4, 1152) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        delete_uint_render_targets(context, self.fbo, &self.rt);
        gl!(gl.delete_buffers(1, &self.counter_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_program(self.prog));
        gl!(gl.delete_program(self.prog2));
        gl!(gl.use_program(0));
        Ok(NO_ERROR)
    }
}

/// `AdvancedUsageManyCounters`
#[derive(Default)]
struct AdvancedUsageManyCounters {
    counter_buffer: GLuint,
    vao: GLuint,
    vbo: GLuint,
    prog: GLuint,
    fbo: GLuint,
    rt: [GLuint; 8],
}

impl Subcase for AdvancedUsageManyCounters {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let src_fs = "#version 420 core\nlayout(location = 0) out uvec4 o_color[8];\nuniform int u_active_counters[8];\nlayout(binding = 0) uniform atomic_uint ac_counter[8];\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter[u_active_counters[0]]));\n  o_color[1] = uvec4(atomicCounterDecrement(ac_counter[u_active_counters[1]]));\n  o_color[2] = uvec4(atomicCounter(ac_counter[u_active_counters[2]]));\n  o_color[3] = uvec4(atomicCounterIncrement(ac_counter[u_active_counters[3]]));\n  o_color[4] = uvec4(atomicCounterDecrement(ac_counter[u_active_counters[4]]));\n  o_color[5] = uvec4(atomicCounter(ac_counter[u_active_counters[5]]));\n  o_color[6] = uvec4(atomicCounterIncrement(ac_counter[u_active_counters[6]]));\n  o_color[7] = uvec4(atomicCounterIncrement(ac_counter[u_active_counters[7]]));\n}";
        self.prog = create_program(gl, Some(TEXT_VS), None, None, None, Some(src_fs), true);

        let init_data = [1000 as GLuint; 8];
        gl!(gl.gen_buffers(1, &mut self.counter_buffer));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.counter_buffer));
        gl!(gl.buffer_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            32,
            init_data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY
        ));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gl!(gl.gen_textures(8, self.rt.as_mut_ptr()));
        for texture in self.rt {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, texture));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_R32UI as GLint,
                RT_SIZE,
                RT_SIZE,
                0,
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_INT,
                std::ptr::null()
            ));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        }

        gl!(gl.gen_framebuffers(1, &mut self.fbo));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        let mut draw_buffers = [0 as GLenum; 8];
        for (i, texture) in self.rt.into_iter().enumerate() {
            gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0 + i as GLenum, texture, 0));
            draw_buffers[i] = glw::GL_COLOR_ATTACHMENT0 + i as GLenum;
        }
        gl!(gl.draw_buffers(8, draw_buffers.as_ptr()));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        create_triangle(gl, &mut self.vao, &mut self.vbo);

        gl!(gl.use_program(self.prog));
        let active_counters = [5, 2, 7, 3, 0, 4, 6, 1];
        for (i, counter) in active_counters.into_iter().enumerate() {
            let name = CString::new(format!("u_active_counters[{i}]")).expect("uniform name holds no nul byte");
            let location = gl!(gl.get_uniform_location(self.prog, name.as_ptr()));
            gl!(gl.uniform_1i(location, counter));
        }

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        gl!(gl.viewport(0, 0, RT_SIZE, RT_SIZE));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));

        // (attachment, lowest sorted value or None for "all 1000", final counter offset and value)
        let expectations: [(GLenum, Option<GLuint>, isize, GLuint); 8] = [
            (glw::GL_COLOR_ATTACHMENT0, Some(1000), 20, 1064),
            (glw::GL_COLOR_ATTACHMENT1, Some(1000 - 64), 8, 1000 - 64),
            (glw::GL_COLOR_ATTACHMENT2, None, 28, 1000),
            (glw::GL_COLOR_ATTACHMENT3, Some(1000), 12, 1064),
            (glw::GL_COLOR_ATTACHMENT4, Some(1000 - 64), 0, 1000 - 64),
            (glw::GL_COLOR_ATTACHMENT5, None, 16, 1000),
            (glw::GL_COLOR_ATTACHMENT6, Some(1000), 24, 1064),
            (glw::GL_COLOR_ATTACHMENT7, Some(1000), 4, 1064),
        ];
        let mut data = [0 as GLuint; (RT_SIZE * RT_SIZE) as usize];
        for (attachment, min_value, offset, final_value) in expectations {
            read_uint_render_target(gl, attachment, &mut data);
            match min_value {
                Some(min_value) => {
                    if !check_counter_values(&mut data, min_value) {
                        return Ok(ERROR);
                    }
                }
                None => {
                    if data.iter().any(|&value| value != 1000) {
                        return Ok(ERROR);
                    }
                }
            }
            if !check_final_counter_value(gl, self.counter_buffer, offset, final_value) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_textures(8, self.rt.as_ptr()));
        let render_target = context.render_target();
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));
        cleanup_quad_program(gl, self.counter_buffer, self.vao, self.vbo, self.prog);
        Ok(NO_ERROR)
    }
}

/// `AdvancedUsageSwitchPrograms`
#[derive(Default)]
struct AdvancedUsageSwitchPrograms {
    counter_buffer: [GLuint; 8],
    xfb_buffer: GLuint,
    vao: GLuint,
    vbo: GLuint,
    prog: [GLuint; 8],
    fbo: GLuint,
    rt: GLuint,
}

impl AdvancedUsageSwitchPrograms {
    fn gen_vs_src(binding: i32, offset: i32) -> String {
        format!(
            "#version 420 core\nlayout(location = 0) in vec4 i_vertex;\nout uvec4 o_atomic_value;\nlayout(binding = {binding}, offset = {offset}) uniform atomic_uint ac_counter_vs;\nvoid main() {{\n  gl_Position = i_vertex;\n  o_atomic_value = uvec4(atomicCounterIncrement(ac_counter_vs));\n}}"
        )
    }

    fn gen_fs_src(binding: i32, offset: i32) -> String {
        format!(
            "#version 420 core\nlayout(location = 0) out uvec4 o_color;\nlayout(binding = {binding}, offset = {offset}) uniform atomic_uint ac_counter_fs;\nvoid main() {{\n  o_color = uvec4(atomicCounterIncrement(ac_counter_fs));\n}}"
        )
    }
}

impl Subcase for AdvancedUsageSwitchPrograms {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if get_integer(gl, glw::GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS) < 8
            || get_integer(gl, glw::GL_MAX_VERTEX_ATOMIC_COUNTERS) < 1
            || get_integer(gl, glw::GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS) < 8
        {
            return Ok(NO_ERROR);
        }

        for i in 0..8 {
            let vs = Self::gen_vs_src(i, i * 8);
            let fs = Self::gen_fs_src(7 - i, 128 + i * 16);
            let program = create_program(gl, Some(&vs), None, None, None, Some(&fs), false);
            self.prog[i as usize] = program;
            let varying = c"o_atomic_value".as_ptr();
            gl!(gl.transform_feedback_varyings(program, 1, &varying, glw::GL_SEPARATE_ATTRIBS));
            link_program(gl, program);
        }

        gl!(gl.gen_buffers(8, self.counter_buffer.as_mut_ptr()));
        for buffer in self.counter_buffer {
            let init_data = [0 as GLuint; 256];
            gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, buffer));
            gl!(gl.buffer_data(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                std::mem::size_of_val(&init_data) as isize,
                init_data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY
            ));
        }
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gl!(gl.gen_buffers(1, &mut self.xfb_buffer));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.xfb_buffer));
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            1000,
            std::ptr::null(),
            glw::GL_STREAM_COPY
        ));
        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));

        gl!(gl.gen_textures(1, &mut self.rt));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, self.rt));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
        gl!(gl.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_R32UI as GLint,
            RT_SIZE,
            RT_SIZE,
            0,
            glw::GL_RED_INTEGER,
            glw::GL_UNSIGNED_INT,
            std::ptr::null()
        ));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

        gl!(gl.gen_framebuffers(1, &mut self.fbo));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, self.rt, 0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        create_triangle(gl, &mut self.vao, &mut self.vbo);

        for (i, buffer) in self.counter_buffer.into_iter().enumerate() {
            gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, i as GLuint, buffer));
        }
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.xfb_buffer));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        gl!(gl.viewport(0, 0, RT_SIZE, RT_SIZE));
        gl!(gl.bind_vertex_array(self.vao));
        for i in 0..8usize {
            gl!(gl.use_program(self.prog[i]));
            gl!(gl.begin_transform_feedback(glw::GL_TRIANGLES));
            gl!(gl.draw_arrays(glw::GL_TRIANGLES, 0, 3));
            gl!(gl.end_transform_feedback());
            gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
            if !check_final_counter_value(gl, self.counter_buffer[i], (i * 8) as isize, 3) {
                return Ok(ERROR);
            }
            if !check_final_counter_value(gl, self.counter_buffer[7 - i], (128 + i * 16) as isize, 64) {
                return Ok(ERROR);
            }
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_textures(1, &self.rt));
        let render_target = context.render_target();
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));
        gl!(gl.delete_buffers(8, self.counter_buffer.as_ptr()));
        gl!(gl.delete_buffers(1, &self.xfb_buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        for program in self.prog {
            gl!(gl.delete_program(program));
        }
        gl!(gl.use_program(0));
        Ok(NO_ERROR)
    }
}

/// One R32UI render target of `size` x `size` and the framebuffer holding it.
fn create_single_uint_render_target(gl: &glw::Functions, size: i32, rt: &mut GLuint, fbo: &mut GLuint) {
    gl!(gl.gen_textures(1, rt));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, *rt));
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
    gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
    gl!(gl.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        glw::GL_R32UI as GLint,
        size,
        size,
        0,
        glw::GL_RED_INTEGER,
        glw::GL_UNSIGNED_INT,
        std::ptr::null()
    ));
    gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));

    gl!(gl.gen_framebuffers(1, fbo));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, *fbo));
    gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, *rt, 0));
    gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
}

/// `AdvancedUsageUBO` and `AdvancedUsageTBO`: the counter indexes a uniform block or a buffer texture.
#[derive(Default)]
struct AdvancedUsageIndexedBuffer {
    texture_buffer: bool,
    counter_buffer: GLuint,
    buffer: GLuint,
    texture: GLuint,
    vao: GLuint,
    vbo: GLuint,
    prog: GLuint,
    fbo: GLuint,
    rt: GLuint,
}

impl AdvancedUsageIndexedBuffer {
    fn new(texture_buffer: bool) -> Self {
        Self {
            texture_buffer,
            ..Self::default()
        }
    }
}

impl Subcase for AdvancedUsageIndexedBuffer {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let src_fs = if self.texture_buffer {
            "#version 420 core\nlayout(location = 0) out uvec4 o_color;\nlayout(binding = 0, offset = 0) uniform atomic_uint ac_counter;\nuniform usamplerBuffer s_buffer;\nvoid main() {\n  o_color = uvec4(texelFetch(s_buffer, int(atomicCounterIncrement(ac_counter))).r);\n}"
        } else {
            "#version 420 core\nlayout(location = 0) out uvec4 o_color;\nlayout(binding = 0, offset = 0) uniform atomic_uint ac_counter;\nlayout(std140) uniform Data {\n  uint index[256];\n} ub_data;\nvoid main() {\n  o_color = uvec4(ub_data.index[atomicCounterIncrement(ac_counter)]);\n}"
        };
        self.prog = create_program(gl, Some(TEXT_VS), None, None, None, Some(src_fs), true);
        if !self.texture_buffer {
            let block_index = gl!(gl.get_uniform_block_index(self.prog, c"Data".as_ptr()));
            gl!(gl.uniform_block_binding(self.prog, block_index, 1));
        }

        let zero: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut self.counter_buffer));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.counter_buffer));
        gl!(gl.buffer_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            4,
            std::ptr::from_ref(&zero).cast(),
            glw::GL_DYNAMIC_COPY
        ));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

        gl!(gl.gen_buffers(1, &mut self.buffer));
        if self.texture_buffer {
            let init_data: Vec<GLuint> = (0..256).collect();
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, self.buffer));
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (4 * init_data.len()) as isize,
                init_data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY
            ));
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

            gl!(gl.gen_textures(1, &mut self.texture));
            gl!(gl.bind_texture(glw::GL_TEXTURE_BUFFER, self.texture));
            gl!(gl.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R32UI, self.buffer));
        } else {
            // UVec4(i) for every i, the std140 stride of the `uint index[256]` array
            let init_data: Vec<[GLuint; 4]> = (0..256).map(|i| [i; 4]).collect();
            gl!(gl.bind_buffer(glw::GL_UNIFORM_BUFFER, self.buffer));
            gl!(gl.buffer_data(
                glw::GL_UNIFORM_BUFFER,
                (16 * init_data.len()) as isize,
                init_data.as_ptr().cast(),
                glw::GL_DYNAMIC_COPY
            ));
            gl!(gl.bind_buffer(glw::GL_UNIFORM_BUFFER, 0));
        }

        const S: i32 = 16;
        create_single_uint_render_target(gl, S, &mut self.rt, &mut self.fbo);
        create_quad(gl, &mut self.vao, &mut self.vbo);

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        gl!(gl.viewport(0, 0, S, S));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        if !self.texture_buffer {
            gl!(gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, 1, self.buffer));
        }
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        let mut data = [0 as GLuint; (S * S) as usize];
        gl!(gl.read_buffer(glw::GL_COLOR_ATTACHMENT0));
        gl!(gl.read_pixels(
            0,
            0,
            S,
            S,
            glw::GL_RED_INTEGER,
            glw::GL_UNSIGNED_INT,
            data.as_mut_ptr().cast()
        ));
        if !check_counter_values(&mut data, 0) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 0, 256) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_framebuffers(1, &self.fbo));
        gl!(gl.delete_textures(1, &self.rt));
        if self.texture_buffer {
            gl!(gl.delete_textures(1, &self.texture));
        }
        let render_target = context.render_target();
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));
        gl!(gl.delete_buffers(1, &self.counter_buffer));
        gl!(gl.delete_buffers(1, &self.buffer));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_buffers(1, &self.vbo));
        gl!(gl.delete_program(self.prog));
        gl!(gl.use_program(0));
        Ok(NO_ERROR)
    }
}

/// `AdvancedManyDrawCalls`
#[derive(Default)]
struct AdvancedManyDrawCalls {
    counter_buffer: GLuint,
    vao: GLuint,
    vbo: GLuint,
    prog: GLuint,
    fbo: GLuint,
    rt: [GLuint; 2],
}

impl Subcase for AdvancedManyDrawCalls {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let src_fs = "#version 420 core\nlayout(location = 0) out uvec4 o_color[2];\nlayout(binding = 0, offset = 0) uniform atomic_uint ac_counter_inc;\nlayout(binding = 0, offset = 4) uniform atomic_uint ac_counter_dec;\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter_inc));\n  o_color[1] = uvec4(atomicCounterDecrement(ac_counter_dec));\n}";
        self.prog = create_program(gl, Some(TEXT_VS), None, None, None, Some(src_fs), true);

        gen_buffer_with_data(
            gl,
            &mut self.counter_buffer,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            8,
            glw::GL_DYNAMIC_COPY,
        );
        create_uint_render_targets(gl, &mut self.rt, &mut self.fbo);
        create_quad(gl, &mut self.vao, &mut self.vbo);

        init_counter_buffer(gl, self.counter_buffer, 8, &[(0, 0), (1, 256)]);

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo));
        gl!(gl.viewport(0, 0, RT_SIZE, RT_SIZE));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.counter_buffer));
        gl!(gl.use_program(self.prog));
        gl!(gl.bind_vertex_array(self.vao));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_ATOMIC_COUNTER_BARRIER_BIT));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_ATOMIC_COUNTER_BARRIER_BIT));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        gl!(gl.memory_barrier(glw::GL_ATOMIC_COUNTER_BARRIER_BIT));
        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));

        let mut data = [0 as GLuint; (RT_SIZE * RT_SIZE) as usize];
        read_uint_render_target(gl, glw::GL_COLOR_ATTACHMENT0, &mut data);
        if !check_counter_values(&mut data, (RT_SIZE * RT_SIZE * 3) as GLuint) {
            return Ok(ERROR);
        }
        read_uint_render_target(gl, glw::GL_COLOR_ATTACHMENT1, &mut data);
        if !check_counter_values(&mut data, 0) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 0, 256) {
            return Ok(ERROR);
        }
        if !check_final_counter_value(gl, self.counter_buffer, 4, 0) {
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        delete_uint_render_targets(context, self.fbo, &self.rt);
        cleanup_quad_program(gl, self.counter_buffer, self.vao, self.vbo, self.prog);
        Ok(NO_ERROR)
    }
}

fn create_shader_program(gl: &glw::Functions, shader_type: GLenum, source: &str) -> GLuint {
    let source = CString::new(source).expect("shader source holds no nul byte");
    let pointer = source.as_ptr();
    gl!(gl.create_shader_programv(shader_type, 1, &pointer))
}

/// The 100 draws or dispatches of `AdvancedManyDrawCalls2` and `AdvancedUsageMultipleComputeDispatches` write 0..100 to the SSBO through a counter; both end in the same check.
fn check_many_calls_result(gl: &glw::Functions, acbo: GLuint, ssbo: GLuint, compute: bool) -> i64 {
    let mut status = NO_ERROR;
    gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, acbo));
    gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
    let data = gl!(gl.map_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, 0, 4, glw::GL_MAP_READ_BIT)).cast::<GLuint>();
    // SAFETY: 4 bytes were mapped for reading.
    let counter = unsafe { data.read() };
    if counter != 100 {
        status = ERROR;
        log::info!("AC buffer content is {counter}, sholud be 100.");
    }
    gl!(gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER));
    gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, 0));

    gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, ssbo));
    gl!(gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT));
    let data =
        gl!(gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, 100 * 4, glw::GL_MAP_READ_BIT)).cast::<GLuint>();
    // SAFETY: 100 uints were mapped for reading; they are copied out because a read-only mapping cannot be sorted in place.
    let mut values = unsafe { std::slice::from_raw_parts(data, 100) }.to_vec();
    values.sort_unstable();
    for (i, &value) in values.iter().enumerate() {
        if value != i as GLuint {
            status = ERROR;
            let shown = if compute { values[0] } else { value };
            log::info!("data[{i}] is {shown}, should be {i}");
        }
    }
    gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
    gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0));
    status
}

/// `AdvancedManyDrawCalls2`
#[derive(Default)]
struct AdvancedManyDrawCalls2 {
    acbo: GLuint,
    ssbo: GLuint,
    vao: GLuint,
    ppo: GLuint,
    vsp: GLuint,
    fsp: GLuint,
}

impl Subcase for AdvancedManyDrawCalls2 {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_buffers(1, &mut self.acbo));
        gl!(gl.gen_buffers(1, &mut self.ssbo));
        gl!(gl.gen_vertex_arrays(1, &mut self.vao));
        gl!(gl.gen_program_pipelines(1, &mut self.ppo));
        self.vsp = 0;
        self.fsp = 0;
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.acbo));
        gl!(gl.delete_buffers(1, &self.ssbo));
        gl!(gl.delete_vertex_arrays(1, &self.vao));
        gl!(gl.delete_program_pipelines(1, &self.ppo));
        gl!(gl.delete_program(self.vsp));
        gl!(gl.delete_program(self.fsp));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !context
            .context_info
            .is_extension_supported("GL_ARB_shader_storage_buffer_object")
        {
            output_not_supported("GL_ARB_shader_storage_buffer_object not supported");
            return Ok(NO_ERROR);
        }

        let glsl_vs = "#version 420 core\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nvoid main() {\n  gl_Position = vec4(0, 0, 0, 1);\n}";
        let glsl_fs = "#version 420 core\n#extension GL_ARB_shader_storage_buffer_object : require\nlayout(binding = 0) uniform atomic_uint g_counter;\nlayout(std430, binding = 0) buffer Output {\n  uint g_output[];\n};\nvoid main() {\n  uint c = atomicCounterIncrement(g_counter);\n  g_output[c] = c;\n}";
        self.vsp = create_shader_program(gl, glw::GL_VERTEX_SHADER, glsl_vs);
        self.fsp = create_shader_program(gl, glw::GL_FRAGMENT_SHADER, glsl_fs);
        if !check_program(gl, self.vsp) || !check_program(gl, self.fsp) {
            return Ok(ERROR);
        }
        gl!(gl.use_program_stages(self.ppo, glw::GL_VERTEX_SHADER_BIT, self.vsp));
        gl!(gl.use_program_stages(self.ppo, glw::GL_FRAGMENT_SHADER_BIT, self.fsp));

        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.acbo));
        let counter: GLuint = 0;
        gl!(gl.buffer_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            4,
            std::ptr::from_ref(&counter).cast(),
            glw::GL_DYNAMIC_COPY
        ));
        let data = [0xffff as GLuint; 1000];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.ssbo));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            4000,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_READ
        ));

        gl!(gl.viewport(0, 0, 1, 1));
        gl!(gl.bind_program_pipeline(self.ppo));
        gl!(gl.bind_vertex_array(self.vao));
        for _ in 0..100 {
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        }
        let render_target = context.render_target();
        gl!(gl.viewport(0, 0, render_target.width, render_target.height));

        Ok(check_many_calls_result(gl, self.acbo, self.ssbo, false))
    }
}

/// `AdvancedUsageMultipleComputeDispatches`
#[derive(Default)]
struct AdvancedUsageMultipleComputeDispatches {
    acbo: GLuint,
    ssbo: GLuint,
    ppo: GLuint,
    csp: GLuint,
}

impl Subcase for AdvancedUsageMultipleComputeDispatches {
    fn setup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.gen_buffers(1, &mut self.acbo));
        gl!(gl.gen_buffers(1, &mut self.ssbo));
        gl!(gl.gen_program_pipelines(1, &mut self.ppo));
        self.csp = 0;
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_buffers(1, &self.acbo));
        gl!(gl.delete_buffers(1, &self.ssbo));
        gl!(gl.delete_program_pipelines(1, &self.ppo));
        gl!(gl.delete_program(self.csp));
        Ok(NO_ERROR)
    }

    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if !compute_and_ssbo_supported(context) {
            log::info!("GL_ARB_compute_shader or GL_ARB_shader_storage_buffer_object not supported, skipping test");
            return Ok(NO_ERROR);
        }

        let glsl_cs = "#version 420 core\n#extension GL_ARB_compute_shader : require\n#extension GL_ARB_shader_storage_buffer_object : require\nlayout(local_size_x = 1) in;\nlayout(binding = 0) uniform atomic_uint g_counter;\nlayout(std430, binding = 0) buffer Output {\n  uint g_output[];\n};\nvoid main() {\n  const uint c = atomicCounterIncrement(g_counter);\n  g_output[c] = c;\n}";
        self.csp = create_shader_program(gl, glw::GL_COMPUTE_SHADER, glsl_cs);
        if !check_program(gl, self.csp) {
            return Ok(ERROR);
        }
        gl!(gl.use_program_stages(self.ppo, glw::GL_COMPUTE_SHADER_BIT, self.csp));

        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, 0, self.acbo));
        let counter: GLuint = 0;
        gl!(gl.buffer_data(
            glw::GL_ATOMIC_COUNTER_BUFFER,
            4,
            std::ptr::from_ref(&counter).cast(),
            glw::GL_DYNAMIC_COPY
        ));
        let data = [0xffff as GLuint; 1000];
        gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, self.ssbo));
        gl!(gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            4000,
            data.as_ptr().cast(),
            glw::GL_DYNAMIC_READ
        ));

        gl!(gl.bind_program_pipeline(self.ppo));
        for _ in 0..100 {
            gl!(gl.dispatch_compute(1, 1, 1));
        }

        Ok(check_many_calls_result(gl, self.acbo, self.ssbo, true))
    }
}

/// `NegativeAPI`
#[derive(Default)]
struct NegativeApi {
    prog: GLuint,
    buffer: GLuint,
}

impl Subcase for NegativeApi {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_fs = "#version 420 core\nlayout(location = 0) out uvec4 o_color[4];\nlayout(binding = 0) uniform atomic_uint ac_counter0;\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter0));\n}";
        self.prog = create_program(gl, Some(TEXT_VS), None, None, None, Some(glsl_fs), true);

        let mut error = NO_ERROR;
        let mut i: GLint = 0;
        for index in [1, 7] {
            gl!(gl.get_active_atomic_counter_bufferiv(self.prog, index, glw::GL_ATOMIC_COUNTER_BUFFER_BINDING, &mut i));
            if gl!(gl.get_error()) != glw::GL_INVALID_VALUE {
                log::info!(
                    "INVALID_VALUE was expected by GetActiveAtomicCounterBufferiv when <bufferIndex> index is greater than or equal GL_ACTIVE_ATOMIC_COUNTER_BUFFERS."
                );
                error = ERROR;
            }
        }

        let res = get_integer(gl, glw::GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS);
        gl!(gl.gen_buffers(1, &mut self.buffer));
        gl!(gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, self.buffer));
        gl!(gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, res as GLuint, self.buffer));
        if gl!(gl.get_error()) != glw::GL_INVALID_VALUE {
            log::info!(
                "INVALID_VALUE was expected by BindBufferBase when <index> index is greater than or equal GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS."
            );
            error = ERROR;
        }
        gl!(gl.bind_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, res as GLuint, self.buffer, 0, 4));
        if gl!(gl.get_error()) != glw::GL_INVALID_VALUE {
            log::info!(
                "INVALID_VALUE was expected by BindBufferRange when <index> index is greater than or equal GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS."
            );
            error = ERROR;
        }
        gl!(gl.bind_buffer_range(glw::GL_ATOMIC_COUNTER_BUFFER, (res - 1) as GLuint, self.buffer, 3, 4));
        if gl!(gl.get_error()) != glw::GL_INVALID_VALUE {
            log::info!("INVALID_VALUE was expected by BindBufferRange when <offset> is not a multiple of four");
            error = ERROR;
        }
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        gl!(gl.delete_program(self.prog));
        gl!(gl.delete_buffers(1, &self.buffer));
        Ok(NO_ERROR)
    }
}

/// `NegativeGLSL`
#[derive(Default)]
struct NegativeGlsl {
    prog: GLuint,
}

impl Subcase for NegativeGlsl {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_fs = "#version 420 core\nlayout(location = 0) out uvec4 o_color[4];\nlayout(binding = 0, offset = 4) uniform atomic_uint ac_counter0;\nlayout(binding = 0, offset = 4) uniform atomic_uint ac_counter2;\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter0));\n  o_color[2] = uvec4(atomicCounterIncrement(ac_counter2));\n}";
        self.prog = create_program(gl, Some(TEXT_VS), None, None, None, Some(glsl_fs), false);

        gl!(gl.link_program(self.prog));
        if get_program_value(gl, self.prog, glw::GL_LINK_STATUS) == glw::GL_TRUE as GLint {
            log::info!("Link should fail when two atomic counters share the same binding and offset.");
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_program(self.prog));
        Ok(NO_ERROR)
    }
}

/// `NegativeUBO`, `NegativeSSBO`, `NegativeUniform`, `NegativeArray` and `NegativeArithmetic`: a valid vertex shader and a fragment shader which must fail to compile or to link.
struct NegativeShaderPair {
    needs_shader_storage_buffer_object: bool,
    vs: &'static str,
    fs: &'static str,
    failure_message: &'static str,
    prog: GLuint,
}

impl NegativeShaderPair {
    fn new(
        needs_shader_storage_buffer_object: bool,
        vs: &'static str,
        fs: &'static str,
        failure_message: &'static str,
    ) -> Self {
        Self {
            needs_shader_storage_buffer_object,
            vs,
            fs,
            failure_message,
            prog: 0,
        }
    }
}

fn compile_status(gl: &glw::Functions, shader: GLuint) -> GLint {
    let mut status = 0;
    gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut status));
    status
}

fn compile_shader_source(gl: &glw::Functions, shader: GLuint, source: &str) {
    let source = CString::new(source).expect("shader source holds no nul byte");
    let pointer = source.as_ptr();
    gl!(gl.shader_source(shader, 1, &pointer, std::ptr::null()));
    gl!(gl.compile_shader(shader));
}

impl Subcase for NegativeShaderPair {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        if self.needs_shader_storage_buffer_object
            && !context
                .context_info
                .is_extension_supported("GL_ARB_shader_storage_buffer_object")
        {
            output_not_supported("GL_ARB_shader_storage_buffer_object not supported");
            return Ok(NO_ERROR);
        }

        self.prog = gl!(gl.create_program());
        let vertex_shader = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        gl!(gl.attach_shader(self.prog, vertex_shader));
        compile_shader_source(gl, vertex_shader, self.vs);
        if compile_status(gl, vertex_shader) != glw::GL_TRUE as GLint {
            log::info!("Vertex shader compilation failed.");
            return Ok(ERROR);
        }
        gl!(gl.delete_shader(vertex_shader));

        let fragment_shader = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        gl!(gl.attach_shader(self.prog, fragment_shader));
        compile_shader_source(gl, fragment_shader, self.fs);
        let status_comp = compile_status(gl, fragment_shader);
        gl!(gl.delete_shader(fragment_shader));

        gl!(gl.link_program(self.prog));
        let status = get_program_value(gl, self.prog, glw::GL_LINK_STATUS);
        if status_comp == glw::GL_TRUE as GLint && status == glw::GL_TRUE as GLint {
            log::info!("{}", self.failure_message);
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        gl!(context.gl().delete_program(self.prog));
        Ok(NO_ERROR)
    }
}

/// `NegativeLargeOffset`
struct NegativeLargeOffset;

impl Subcase for NegativeLargeOffset {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let max_size = get_integer(gl, glw::GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE);
        let source = format!(
            "#version 420 core\nlayout(location = 0) out uvec4 o_color;\nlayout(binding = 0, offset = {max_size}) uniform atomic_uint ac_counter_fs;\nvoid main() {{\n  o_color = uvec4(atomicCounterIncrement(ac_counter_fs)); \n }}"
        );
        let shader = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        compile_shader_source(gl, shader, &source);
        let status_comp = compile_status(gl, shader);
        gl!(gl.delete_shader(shader));
        if status_comp == glw::GL_TRUE as GLint {
            log::info!(
                "Compilation should fail when the offset of an atomic counter is MAX_ATOMIC_COUNTER_BUFFER_SIZE."
            );
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

/// `NegativeUnsizedArray`
struct NegativeUnsizedArray;

impl Subcase for NegativeUnsizedArray {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let glsl_fs = "#version 450 core\nlayout(location = 0) out uvec4 o_color[4];  layout(binding = 0, offset = 4) uniform atomic_uint ac_counter[];\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter[0]));\n}";
        let shader = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        compile_shader_source(gl, shader, glsl_fs);
        let status_comp = compile_status(gl, shader);
        gl!(gl.delete_shader(shader));
        if status_comp == glw::GL_TRUE as GLint {
            log::info!("Compilation should fail for an unsized array of atomic counters.");
            return Ok(ERROR);
        }
        Ok(NO_ERROR)
    }
}

const VS_420: &str =
    "#version 420 core\nlayout(location = 0) in vec4 i_vertex;\nvoid main() {\n  gl_Position = i_vertex;\n}";
const VS_430: &str =
    "#version 430 core\nlayout(location = 0) in vec4 i_vertex;\nvoid main() {\n  gl_Position = i_vertex;\n}";

fn add_case<F: Fn() -> Box<dyn Subcase> + Send + Sync + 'static>(group: &mut TestCaseGroup, name: &str, factory: F) {
    group.add_child(Box::new(TestSubcase::new(name, factory)) as Box<dyn TestCase>);
}

/// The case `ShaderAtomicCountersTests::init` adds only when the context is core 4.5 or newer.
pub fn add_gl45_cases(group: &mut TestCaseGroup) {
    add_case(group, "negative-unsized-array", || Box::new(NegativeUnsizedArray));
}

/// `ShaderAtomicCountersTests::init`; ported so far: the buffer and program cases and the fragment, vertex, geometry, tessellation evaluation compute usage and the multi-stage, draw-update-draw, many-counters, switch-programs, ubo, tbo, many-draw-calls, many-dispatches and negative cases (`negative-unsized-array` is `add_gl45_cases`).
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_atomic_counters");
    add_case(&mut group, "advanced-usage-many-counters", || {
        Box::new(AdvancedUsageManyCounters::default())
    });
    add_case(&mut group, "basic-buffer-operations", || {
        Box::new(BasicBufferOperations::default())
    });
    add_case(&mut group, "basic-buffer-state", || Box::new(BasicBufferState));
    add_case(&mut group, "basic-buffer-bind", || Box::new(BasicBufferBind::default()));
    add_case(&mut group, "basic-program-max", || Box::new(BasicProgramMax));
    add_case(&mut group, "basic-program-query", || {
        Box::new(BasicProgramQuery::default())
    });
    add_case(&mut group, "basic-usage-simple", || {
        Box::new(BasicUsageSimple::default())
    });
    add_case(&mut group, "basic-usage-no-offset", || {
        Box::new(BasicUsageFs::new(false))
    });
    add_case(&mut group, "basic-usage-fs", || Box::new(BasicUsageFs::new(true)));
    add_case(&mut group, "basic-usage-vs", || Box::new(BasicUsageVs::default()));
    add_case(&mut group, "basic-usage-gs", || Box::new(BasicUsageGs::default()));
    add_case(&mut group, "basic-usage-tes", || Box::new(BasicUsageTes::default()));
    add_case(&mut group, "basic-usage-cs", || Box::new(BasicUsageCs::default()));
    add_case(&mut group, "basic-glsl-built-in", || {
        Box::new(BasicGlslBuiltIn::default())
    });
    add_case(&mut group, "advanced-usage-multi-stage", || {
        Box::new(AdvancedUsageMultiStage::default())
    });
    add_case(&mut group, "advanced-usage-draw-update-draw", || {
        Box::new(AdvancedUsageDrawUpdateDraw::default())
    });
    add_case(&mut group, "advanced-usage-switch-programs", || {
        Box::new(AdvancedUsageSwitchPrograms::default())
    });
    add_case(&mut group, "advanced-usage-ubo", || {
        Box::new(AdvancedUsageIndexedBuffer::new(false))
    });
    add_case(&mut group, "advanced-usage-tbo", || {
        Box::new(AdvancedUsageIndexedBuffer::new(true))
    });
    add_case(&mut group, "advanced-usage-many-draw-calls", || {
        Box::new(AdvancedManyDrawCalls::default())
    });
    add_case(&mut group, "advanced-usage-many-draw-calls2", || {
        Box::new(AdvancedManyDrawCalls2::default())
    });
    add_case(&mut group, "advanced-usage-many-dispatches", || {
        Box::new(AdvancedUsageMultipleComputeDispatches::default())
    });
    add_case(&mut group, "negative-api", || Box::new(NegativeApi::default()));
    add_case(&mut group, "negative-glsl", || Box::new(NegativeGlsl::default()));
    add_case(&mut group, "negative-ssbo", || {
        Box::new(NegativeShaderPair::new(
            true,
            VS_420,
            "#version 420 core\n#extension GL_ARB_shader_storage_buffer_object: require\nlayout(location = 0) out uvec4 o_color[4];\nlayout(binding = 0) buffer Buffer {\n  layout(binding = 0, offset = 16) uniform atomic_uint ac_counter0;\n};\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter0));\n}",
            "Atomic counter declared inside a shader storage block should fail to compile or link.",
        ))
    });
    add_case(&mut group, "negative-ubo", || {
        Box::new(NegativeShaderPair::new(
            false,
            VS_430,
            "#version 430 core\nlayout(location = 0) out uvec4 o_color[4];\nuniform Block {\n  layout(binding = 0, offset = 0) uniform atomic_uint ac_counter0;\n};\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter0));\n}",
            "Atomic counter declared inside a uniform block should fail to compile or link.",
        ))
    });
    add_case(&mut group, "negative-uniform", || {
        Box::new(NegativeShaderPair::new(
            false,
            VS_430,
            "#version 430 core\nlayout(location = 0) out uvec4 o_color[4];\nuniform uint ac_counter0;\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter0));\n}",
            "atomicCounterIncrement on a plain uniform should fail to compile or link.",
        ))
    });
    add_case(&mut group, "negative-array", || {
        Box::new(NegativeShaderPair::new(
            false,
            VS_430,
            "#version 430 core\nlayout(location = 0) out uvec4 o_color[4];\nlayout(binding = 0, offset = 0) uniform atomic_uint ac_counter0[3];\nvoid main() {\n  o_color[0] = uvec4(atomicCounterIncrement(ac_counter0));\n  o_color[1] = uvec4(atomicCounterDecrement(ac_counter0));\n}",
            "Atomic counter functions applied to a whole array should fail to compile or link.",
        ))
    });
    add_case(&mut group, "negative-arithmetic", || {
        Box::new(NegativeShaderPair::new(
            false,
            VS_420,
            "#version 420 core\nlayout(location = 0) out uvec4 o_color[4];\nlayout(binding = 0, offset = 0) uniform atomic_uint ac_counter;\nvoid main() {\n  o_color[0] = ac_counter++;\n}",
            "Arithmetic on an atomic counter should fail to compile or link.",
        ))
    });
    add_case(&mut group, "negative-large-offset", || Box::new(NegativeLargeOffset));
    group
}
