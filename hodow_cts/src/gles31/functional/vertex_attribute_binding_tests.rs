// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fVertexAttributeBindingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `usage` sub-group (`BindingRenderCase` and its four subclasses) needs no rasterised
// reference at all: every case draws a grid where each cell is green or yellow-green (equal
// red and blue components aside, both have G=255, B=0), and `verifyImageYellowGreen` checks
// only that every rendered pixel is close to one of those two colours or a blend of them -
// which is what a triangle edge produces under multisampling/blending. So the check is a
// pure per-pixel predicate on the readback, not a comparison against a second image.
//
// `BindingRenderCase::iterate` also has a `m_unalignedData` branch that reports
// `QP_TEST_RESULT_COMPATIBILITY_WARNING` instead of `Fail` on a verification failure; it is
// not modelled; here because none of the seven registered `single_binding` cases can reach
// it - `SingleBindingCase::isDataUnaligned` checks `FLAG_ATTRIB_ALIGNED` before either
// `FLAG_BUF_UNALIGNED_OFFSET`/`FLAG_BUF_UNALIGNED_STRIDE`, and the one registered case that
// sets the former (`unaligned_offset_elements_1_aligned_elements`) also sets the latter, so
// `isDataUnaligned` always returns `false` for every case actually registered.

use crate::glu::{self, ApiCase, Buffer, ProgramSources, ShaderProgram, TestCaseGroup, VertexArray, add_api_case};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::surface::Surface;

/// `BindingRenderCase::TEST_RENDER_SIZE`
const TEST_RENDER_SIZE: i32 = 64;
/// The grid every `.usage` case renders, shared by all four render-case shapes (each
/// upstream class redeclares its own `GRID_SIZE = 20`).
const GRID_SIZE: i32 = 20;

/// One `[f32; 4]`'s worth of bytes - upstream's ubiquitous `sizeof(tcu::Vec4)`.
const VEC4_BYTES: usize = size_of::<[f32; 4]>();

/// `s_colorFragmentShader`
const COLOR_FRAGMENT_SHADER: &str = "#version 310 es\n\
                                     in mediump vec4 v_color;\n\
                                     layout(location = 0) out mediump vec4 fragColor;\n\
                                     void main (void)\n\
                                     {\n\
                                     \tfragColor = v_color;\n\
                                     }\n";

/// `s_positionColorShader`
const POSITION_COLOR_SHADER: &str = "#version 310 es\n\
                                     in highp vec4 a_position;\n\
                                     in highp vec4 a_color;\n\
                                     out highp vec4 v_color;\n\
                                     void main (void)\n\
                                     {\n\
                                     \tgl_Position = a_position;\n\
                                     \tv_color = a_color;\n\
                                     }\n";

/// `s_positionColorOffsetShader`
const POSITION_COLOR_OFFSET_SHADER: &str = "#version 310 es\n\
                                            in highp vec4 a_position;\n\
                                            in highp vec4 a_offset;\n\
                                            in highp vec4 a_color;\n\
                                            out highp vec4 v_color;\n\
                                            void main (void)\n\
                                            {\n\
                                            \tgl_Position = a_position + a_offset;\n\
                                            \tv_color = a_color;\n\
                                            }\n";

/// `verifyImageYellowGreen` - verifies the image contains only yellow or green, or a
/// linear combination of these colors.
fn verify_image_yellow_green(image: &Surface) -> bool {
    const COLOR_THRESHOLD: i32 = 20;
    let mut is_ok = true;

    for y in 0..image.get_height() {
        for x in 0..image.get_width() {
            let pixel = image.get_pixel(x, y);
            // Any pixel with !(G ~= 255) is faulty (not a linear combination of green and yellow).
            let mut pixel_ok = (pixel.get_green() - 255).abs() <= COLOR_THRESHOLD;
            // Any pixel with !(B ~= 0) is faulty (not a linear combination of green and yellow).
            pixel_ok &= pixel.get_blue().abs() <= COLOR_THRESHOLD;
            is_ok = is_ok && pixel_ok;
        }
    }

    is_ok
}

/// `BindingRenderCase::init`'s render-target-size check.
fn check_render_target_size(case: &mut ApiCase<'_>) -> bool {
    let target = case.context().render_target();
    if target.width < TEST_RENDER_SIZE || target.height < TEST_RENDER_SIZE {
        case.not_supported(format!(
            "Test requires at least {TEST_RENDER_SIZE}x{TEST_RENDER_SIZE} render target"
        ));
        return false;
    }
    true
}

/// `BindingRenderCase::iterate`'s verdict - see the file header for why the
/// `m_unalignedData` branch is not modelled.
fn finish_binding_render_case(case: &mut ApiCase<'_>, surface: &Surface) {
    if !verify_image_yellow_green(surface) {
        case.fail("Image verification failed".to_string(), "Image verification failed");
    }
}

/// Writes one `vec4`'s worth of native-endian bytes at a byte offset - the Rust shape of
/// upstream's `memcpy(&dataBuf[offset], value.getPtr(), sizeof(value))`.
fn write_vec4(buf: &mut [u8], offset: usize, v: [f32; 4]) {
    for (i, c) in v.iter().enumerate() {
        buf[offset + i * 4..offset + i * 4 + 4].copy_from_slice(&c.to_ne_bytes());
    }
}

/// The verdict every case in this group reaches: the call above must have raised exactly
/// `expected` and nothing else.
fn expect_error(case: &mut ApiCase<'_>, expected: GLenum) {
    // SAFETY: glGetError needs only a current context.
    let error = unsafe { case.gl().get_error() };
    if error != expected {
        case.fail(
            format!(
                "ERROR! Expected {}, got {}",
                glw::error_name(expected),
                glw::error_name(error)
            ),
            "Invalid error",
        );
    }
}

/// `DefaultVAOCase::CaseType`
#[derive(Clone, Copy)]
enum DefaultVaoCase {
    BindVertexBuffer,
    VertexAttribFormat,
    VertexAttribIFormat,
    VertexAttribBinding,
    VertexBindingDivisor,
}

/// `DefaultVAOCase::iterate` - each of these is an error only because the default vertex
/// array object is bound, which is why none of them binds one.
fn default_vao_case(case: &mut ApiCase<'_>, case_type: DefaultVaoCase) {
    let gl = case.gl();

    // SAFETY: every call below is the one whose error code is being checked; the buffer
    // outlives the call that names it.
    unsafe {
        match case_type {
            DefaultVaoCase::BindVertexBuffer => {
                let buffer = Buffer::new(gl);
                gl.bind_vertex_buffer(0, buffer.get(), 0, 0);
            }
            DefaultVaoCase::VertexAttribFormat => gl.vertex_attrib_format(0, 4, glw::GL_FLOAT, glw::FALSE, 0),
            DefaultVaoCase::VertexAttribIFormat => gl.vertex_attrib_i_format(0, 4, glw::GL_INT, 0),
            DefaultVaoCase::VertexAttribBinding => gl.vertex_attrib_binding(0, 0),
            DefaultVaoCase::VertexBindingDivisor => gl.vertex_binding_divisor(0, 1),
        }
    }

    expect_error(case, glw::GL_INVALID_OPERATION);
}

/// `BindToCreateCase::iterate` - `glBindVertexBuffer` does not create the buffer the way
/// `glBindBuffer` does, so a name that was generated and then deleted is not a buffer.
fn bind_to_create_case(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let vao = VertexArray::new(gl);
    let mut buffer: GLuint = 0;

    // SAFETY: one name in and out; the name is deliberately dead by the time it is bound.
    unsafe {
        gl.gen_buffers(1, &mut buffer);
        gl.delete_buffers(1, &buffer);
    }
    case.expect_no_error("");

    // SAFETY: as above.
    unsafe {
        gl.bind_vertex_array(vao.get());
        gl.bind_vertex_buffer(0, buffer, 0, 0);
    }

    expect_error(case, glw::GL_INVALID_OPERATION);
}

/// `NegativeApiCase::CaseType`
#[derive(Clone, Copy)]
enum NegativeApi {
    LargeOffset,
    LargeStride,
    NegativeStride,
    NegativeOffset,
    InvalidAttr,
    InvalidBinding,
}

/// One "read a limit, then go one past it" step, answering `None` when the limit leaves no
/// value to go past - upstream throws `NotSupportedError` there.
fn one_past_limit(case: &mut ApiCase<'_>, pname: GLenum, reason: &str) -> Option<GLint> {
    let mut limit: GLint = -1;
    // SAFETY: one integer output.
    unsafe { case.gl().get_integerv(pname, &mut limit) };
    case.expect_no_error("");

    // skip if maximum unsigned or signed values
    if limit == -1 || limit == 0x7FFF_FFFF {
        case.not_supported(reason);
        return None;
    }
    Some(limit + 1)
}

/// `NegativeApiCase::iterate`
fn negative_api_case(case: &mut ApiCase<'_>, case_type: NegativeApi) {
    let gl = case.gl();
    let vao = VertexArray::new(gl);
    // SAFETY: a name this case generated; every call below needs a non-default VAO bound.
    unsafe { gl.bind_vertex_array(vao.get()) };

    match case_type {
        NegativeApi::LargeOffset => {
            let Some(large_offset) = one_past_limit(
                case,
                glw::GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET,
                "Implementation supports all offsets",
            ) else {
                return;
            };
            #[expect(
                clippy::cast_sign_loss,
                reason = "upstream's GLint is converted to the entry point's GLuint"
            )]
            let large_offset = large_offset as GLuint;
            // SAFETY: the out-of-range offset is what is being checked.
            unsafe {
                case.gl()
                    .vertex_attrib_format(0, 4, glw::GL_FLOAT, glw::FALSE, large_offset)
            };
        }
        NegativeApi::LargeStride => {
            let buffer = Buffer::new(gl);
            let Some(large_stride) = one_past_limit(
                case,
                glw::GL_MAX_VERTEX_ATTRIB_STRIDE,
                "Implementation supports all strides",
            ) else {
                return;
            };
            // SAFETY: as above; `buffer` outlives the call.
            unsafe { case.gl().bind_vertex_buffer(0, buffer.get(), 0, large_stride) };
        }
        NegativeApi::NegativeStride => {
            let buffer = Buffer::new(gl);
            // SAFETY: the negative stride is what is being checked.
            unsafe { gl.bind_vertex_buffer(0, buffer.get(), 0, -20) };
        }
        NegativeApi::NegativeOffset => {
            let buffer = Buffer::new(gl);
            // SAFETY: the negative offset is what is being checked.
            unsafe { gl.bind_vertex_buffer(0, buffer.get(), -20, 0) };
        }
        NegativeApi::InvalidAttr => {
            let Some(large_index) = one_past_limit(
                case,
                glw::GL_MAX_VERTEX_ATTRIBS,
                "Implementation supports any attribute index",
            ) else {
                return;
            };
            #[expect(
                clippy::cast_sign_loss,
                reason = "upstream's GLint is converted to the entry point's GLuint"
            )]
            let large_index = large_index as GLuint;
            // SAFETY: the out-of-range attribute index is what is being checked.
            unsafe { case.gl().vertex_attrib_binding(large_index, 0) };
        }
        NegativeApi::InvalidBinding => {
            let Some(large_binding) = one_past_limit(
                case,
                glw::GL_MAX_VERTEX_ATTRIB_BINDINGS,
                "Implementation supports any binding",
            ) else {
                return;
            };
            #[expect(
                clippy::cast_sign_loss,
                reason = "upstream's GLint is converted to the entry point's GLuint"
            )]
            let large_binding = large_binding as GLuint;
            // SAFETY: the out-of-range binding index is what is being checked.
            unsafe { case.gl().vertex_attrib_binding(0, large_binding) };
        }
    }

    expect_error(case, glw::GL_INVALID_VALUE);
}

/// `VertexAttributeBindingTests::init`'s `negative` sub-group.
fn negative_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("negative");

    for (name, case_type) in [
        ("default_vao_bind_vertex_buffer", DefaultVaoCase::BindVertexBuffer),
        ("default_vao_vertex_attrib_format", DefaultVaoCase::VertexAttribFormat),
        (
            "default_vao_vertex_attrib_i_format",
            DefaultVaoCase::VertexAttribIFormat,
        ),
        ("default_vao_vertex_attrib_binding", DefaultVaoCase::VertexAttribBinding),
        (
            "default_vao_vertex_binding_divisor",
            DefaultVaoCase::VertexBindingDivisor,
        ),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            default_vao_case(case, case_type)
        });
    }

    add_api_case(&mut group, "bind_create_new_buffer", bind_to_create_case);

    for (name, case_type) in [
        ("vertex_attrib_format_large_offset", NegativeApi::LargeOffset),
        ("bind_vertex_buffer_large_stride", NegativeApi::LargeStride),
        ("bind_vertex_buffer_negative_stride", NegativeApi::NegativeStride),
        ("bind_vertex_buffer_negative_offset", NegativeApi::NegativeOffset),
        ("vertex_attrib_binding_invalid_attr", NegativeApi::InvalidAttr),
        ("vertex_attrib_binding_invalid_binding", NegativeApi::InvalidBinding),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            negative_api_case(case, case_type)
        });
    }

    group
}

// SingleBindingCase

/// `SingleBindingCase::CaseFlag`
mod single_binding_flags {
    pub const ATTRIB_UNALIGNED: u32 = 1 << 0;
    pub const ATTRIB_ALIGNED: u32 = 1 << 1;
    pub const ATTRIBS_MULTIPLE_ELEMS: u32 = 1 << 2;
    pub const ATTRIBS_SHARED_ELEMS: u32 = 1 << 3;
    pub const BUF_ALIGNED_OFFSET: u32 = 1 << 4;
    pub const BUF_UNALIGNED_OFFSET: u32 = 1 << 5;
    pub const BUF_UNALIGNED_STRIDE: u32 = 1 << 6;
}

/// `SingleBindingCase::TestSpec`
struct SingleBindingSpec {
    buffer_offset: i32,
    buffer_stride: i32,
    position_attr_offset: i32,
    color_attr_offset: i32,
    has_color_attr: bool,
}

/// `SingleBindingCase::genTestSpec`
fn single_binding_gen_test_spec(flags: u32) -> SingleBindingSpec {
    use single_binding_flags::*;

    let datum_size = 4;
    let buffer_offset = if flags & BUF_ALIGNED_OFFSET != 0 {
        32
    } else if flags & BUF_UNALIGNED_OFFSET != 0 {
        19
    } else {
        0
    };
    let attr_buf_alignment = if buffer_offset % datum_size == 0 {
        0
    } else {
        datum_size - (buffer_offset % datum_size)
    };
    let position_attr_offset = if flags & ATTRIB_UNALIGNED != 0 {
        3
    } else if flags & ATTRIB_ALIGNED != 0 {
        attr_buf_alignment
    } else {
        0
    };
    let has_color_attr = (flags & ATTRIBS_SHARED_ELEMS != 0) || (flags & ATTRIBS_MULTIPLE_ELEMS != 0);
    let color_attr_offset = if flags & ATTRIBS_SHARED_ELEMS != 0 {
        2 * datum_size
    } else if flags & ATTRIBS_MULTIPLE_ELEMS != 0 {
        4 * datum_size
    } else {
        -1
    };

    let buffer_stride_base = (position_attr_offset + 4 * datum_size).max(color_attr_offset + 4 * datum_size);
    let buffer_stride_alignment = if buffer_stride_base % datum_size == 0 {
        0
    } else {
        datum_size - (buffer_stride_base % datum_size)
    };
    let is_aligned = |v: i32| v % datum_size == 0;
    let buffer_stride_padding = if (flags & BUF_UNALIGNED_STRIDE != 0) && is_aligned(buffer_stride_base) {
        13
    } else if (flags & BUF_UNALIGNED_STRIDE == 0) && !is_aligned(buffer_stride_base) {
        buffer_stride_alignment
    } else {
        0
    };

    SingleBindingSpec {
        buffer_offset,
        buffer_stride: buffer_stride_base + buffer_stride_padding,
        position_attr_offset,
        color_attr_offset,
        has_color_attr,
    }
}

/// `SingleBindingCase::genVertexSource`
fn single_binding_vertex_source(spec: &SingleBindingSpec) -> String {
    let use_uniform_color = !spec.has_color_attr;
    let mut buf = String::from("#version 310 es\nin highp vec4 a_position;\n");

    if !use_uniform_color {
        buf.push_str("in highp vec4 a_color;\n");
    } else {
        buf.push_str("uniform highp vec4 u_color;\n");
    }

    buf.push_str("out highp vec4 v_color;\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_color = ");
    buf.push_str(if use_uniform_color { "u_color" } else { "a_color" });
    buf.push_str(";\n}\n");
    buf
}

/// `SingleBindingCase::createBuffers`
fn single_binding_create_buffer<'gl>(gl: &'gl glw::Functions, spec: &SingleBindingSpec) -> Buffer<'gl> {
    let color_a = [0.0f32, 1.0, 0.0, 1.0];
    let color_b = [0.5f32, 1.0, 0.0, 1.0];
    let mut data = vec![0u8; (spec.buffer_offset + spec.buffer_stride * GRID_SIZE * GRID_SIZE * 6) as usize];

    for y in 0..GRID_SIZE {
        for x in 0..GRID_SIZE {
            let color = if (x + y) % 2 == 0 { color_a } else { color_b };
            let (gx0, gx1) = (
                x as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                (x + 1) as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
            );
            let (gy0, gy1) = (
                y as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                (y + 1) as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
            );
            let positions: [[f32; 4]; 6] = [
                [gx0, gy0, 0.0, 1.0],
                [gx0, gy1, 0.0, 1.0],
                [gx1, gy1, 0.0, 1.0],
                [gx0, gy0, 0.0, 1.0],
                [gx1, gy1, 0.0, 1.0],
                [gx1, gy0, 0.0, 1.0],
            ];

            // copy cell vertices to the buffer.
            for (v, pos) in positions.iter().enumerate() {
                let offset = (spec.buffer_offset
                    + spec.position_attr_offset
                    + spec.buffer_stride * ((y * GRID_SIZE + x) * 6 + v as i32)) as usize;
                write_vec4(&mut data, offset, *pos);
            }

            // copy color to buffer.
            if spec.has_color_attr {
                for v in 0..6 {
                    let offset = (spec.buffer_offset
                        + spec.color_attr_offset
                        + spec.buffer_stride * ((y * GRID_SIZE + x) * 6 + v)) as usize;
                    write_vec4(&mut data, offset, color);
                }
            }
        }
    }

    let buffer = Buffer::new(gl);
    // SAFETY: `data` is exactly the size passed to `buffer_data`.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            data.len() as isize,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
    }
    buffer
}

/// `SingleBindingCase::renderTo`
fn single_binding_case(case: &mut ApiCase<'_>, flags: u32) {
    if !check_render_target_size(case) {
        return;
    }

    let spec = single_binding_gen_test_spec(flags);
    let gl = case.gl();
    let vao = VertexArray::new(gl);
    let buffer = single_binding_create_buffer(gl, &spec);
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(single_binding_vertex_source(&spec), COLOR_FRAGMENT_SHADER),
    );
    if !program.is_ok() {
        case.fail("could not build shader".to_string(), "Fail");
        return;
    }
    let program_id = program.program();

    // SAFETY: names of a program this case just linked.
    let (position_loc, color_loc, color_uniform_loc) = unsafe {
        (
            gl.get_attrib_location(program_id, c"a_position".as_ptr()),
            gl.get_attrib_location(program_id, c"a_color".as_ptr()),
            gl.get_uniform_location(program_id, c"u_color".as_ptr()),
        )
    };
    let position_loc = position_loc as GLuint;
    let color_loc = color_loc as GLuint;

    let mut surface = Surface::new(TEST_RENDER_SIZE, TEST_RENDER_SIZE);

    // SAFETY: plain draw state on a current context, against a VAO/buffer/program this case
    // just created and linked.
    unsafe {
        gl.clear_color(0.0, 0.0, 0.0, 0.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.viewport(0, 0, TEST_RENDER_SIZE, TEST_RENDER_SIZE);
        gl.bind_vertex_array(vao.get());
    }
    case.expect_no_error("set vao");
    unsafe { gl.use_program(program_id) };
    case.expect_no_error("use program");

    // SAFETY: as above; binding point 3 is arbitrary and consistent across the calls below.
    unsafe { gl.bind_vertex_buffer(3, buffer.get(), spec.buffer_offset as isize, spec.buffer_stride) };

    if spec.has_color_attr {
        // SAFETY: as above.
        unsafe {
            gl.vertex_attrib_binding(position_loc, 3);
            gl.vertex_attrib_format(
                position_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                spec.position_attr_offset as GLuint,
            );
            gl.enable_vertex_attrib_array(position_loc);

            gl.vertex_attrib_binding(color_loc, 3);
            gl.vertex_attrib_format(
                color_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                spec.color_attr_offset as GLuint,
            );
            gl.enable_vertex_attrib_array(color_loc);
        }
        case.expect_no_error("set va");

        unsafe { gl.draw_arrays(glw::GL_TRIANGLES, 0, GRID_SIZE * GRID_SIZE * 6) };
        case.expect_no_error("draw");
    } else {
        // SAFETY: as above.
        unsafe {
            gl.vertex_attrib_binding(position_loc, 3);
            gl.vertex_attrib_format(
                position_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                spec.position_attr_offset as GLuint,
            );
            gl.enable_vertex_attrib_array(position_loc);
        }
        case.expect_no_error("set va");

        // SAFETY: as above.
        unsafe {
            gl.uniform_4f(color_uniform_loc, 0.0, 1.0, 0.0, 1.0);
            gl.draw_arrays(glw::GL_TRIANGLES, 0, GRID_SIZE * GRID_SIZE * 6);
        }
        case.expect_no_error("draw");
    }

    // SAFETY: as above.
    unsafe {
        gl.finish();
        gl.bind_vertex_array(0);
        gl.use_program(0);
    }
    case.expect_no_error("clean");

    if let Err(e) = glu::pixel_transfer::read_pixels(&case.context().render_context, 0, 0, &mut surface.get_access()) {
        case.fail(e.to_string(), "Fail");
        return;
    }

    finish_binding_render_case(case, &surface);
}

// MultipleBindingCase

/// `MultipleBindingCase::CaseFlag`
mod multiple_binding_flags {
    pub const ZERO_STRIDE: u32 = 1 << 0;
    pub const INSTANCED: u32 = 1 << 1;
    pub const ALIASING_BUFFERS: u32 = 1 << 2;
}

/// `MultipleBindingCase::createBuffers`
fn multiple_binding_create_buffers<'gl>(
    gl: &'gl glw::Functions,
    zero_stride: bool,
    instanced: bool,
    aliasing_buffers: bool,
) -> (Buffer<'gl>, Option<Buffer<'gl>>) {
    let green = [0.0f32, 1.0, 0.0, 1.0];
    let yellow = [1.0f32, 1.0, 0.0, 1.0];

    let vertex_data_size = if instanced { 6 } else { 6 * GRID_SIZE * GRID_SIZE };
    let offset_color_size = if zero_stride {
        2
    } else if instanced {
        2 * GRID_SIZE * GRID_SIZE
    } else {
        2 * 6 * GRID_SIZE * GRID_SIZE
    };
    let primitive_buf_size = if aliasing_buffers {
        vertex_data_size + offset_color_size
    } else {
        vertex_data_size
    };

    let mut primitive_data = vec![[0.0f32; 4]; primitive_buf_size as usize];
    let mut color_offset_data = vec![[0.0f32; 4]; offset_color_size as usize];

    // write vertex position.
    if instanced {
        // store single basic primitive.
        primitive_data[0] = [0.0, 0.0, 0.0, 1.0];
        primitive_data[1] = [0.0, 2.0 / GRID_SIZE as f32, 0.0, 1.0];
        primitive_data[2] = [2.0 / GRID_SIZE as f32, 2.0 / GRID_SIZE as f32, 0.0, 1.0];
        primitive_data[3] = [0.0, 0.0, 0.0, 1.0];
        primitive_data[4] = [2.0 / GRID_SIZE as f32, 2.0 / GRID_SIZE as f32, 0.0, 1.0];
        primitive_data[5] = [2.0 / GRID_SIZE as f32, 0.0, 0.0, 1.0];
    } else {
        // store whole grid.
        for y in 0..GRID_SIZE {
            for x in 0..GRID_SIZE {
                let (gx0, gx1) = (
                    x as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                    (x + 1) as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                );
                let (gy0, gy1) = (
                    y as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                    (y + 1) as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                );
                let base = ((y * GRID_SIZE + x) * 6) as usize;
                primitive_data[base] = [gx0, gy0, 0.0, 1.0];
                primitive_data[base + 1] = [gx0, gy1, 0.0, 1.0];
                primitive_data[base + 2] = [gx1, gy1, 0.0, 1.0];
                primitive_data[base + 3] = [gx0, gy0, 0.0, 1.0];
                primitive_data[base + 4] = [gx1, gy1, 0.0, 1.0];
                primitive_data[base + 5] = [gx1, gy0, 0.0, 1.0];
            }
        }
    }

    // store color & offset.
    if zero_stride {
        color_offset_data[0] = green;
        color_offset_data[1] = [0.0; 4];
    } else if instanced {
        for y in 0..GRID_SIZE {
            for x in 0..GRID_SIZE {
                let color = if (x + y) % 2 == 0 { green } else { yellow };
                let ndx = ((y * GRID_SIZE + x) * 2) as usize;
                color_offset_data[ndx] = color;
                color_offset_data[ndx + 1] = [
                    x as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                    y as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                    0.0,
                    0.0,
                ];
            }
        }
    } else {
        for y in 0..GRID_SIZE {
            for x in 0..GRID_SIZE {
                for v in 0..6 {
                    let color = if (x + y) % 2 == 0 { green } else { yellow };
                    let ndx = (((y * GRID_SIZE + x) * 6 + v) * 2) as usize;
                    color_offset_data[ndx] = color;
                    color_offset_data[ndx + 1] = [0.0; 4];
                }
            }
        }
    }

    // upload vertex data.
    if aliasing_buffers {
        let offset = if instanced {
            6usize
        } else {
            (GRID_SIZE * GRID_SIZE * 6) as usize
        };
        primitive_data[offset..offset + color_offset_data.len()].copy_from_slice(&color_offset_data);
    }

    let primitive_buffer = Buffer::new(gl);
    // SAFETY: `primitive_data` is exactly the size passed to `buffer_data`.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, primitive_buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_val(primitive_data.as_slice()) as isize,
            primitive_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }

    let color_offset_buffer = if aliasing_buffers {
        None
    } else {
        let buffer = Buffer::new(gl);
        // SAFETY: as above.
        unsafe {
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                size_of_val(color_offset_data.as_slice()) as isize,
                color_offset_data.as_ptr().cast(),
                glw::GL_STATIC_DRAW,
            );
        }
        Some(buffer)
    };

    (primitive_buffer, color_offset_buffer)
}

/// `MultipleBindingCase::renderTo`
fn multiple_binding_case(case: &mut ApiCase<'_>, flags: u32) {
    if !check_render_target_size(case) {
        return;
    }

    let zero_stride = flags & multiple_binding_flags::ZERO_STRIDE != 0;
    let instanced = flags & multiple_binding_flags::INSTANCED != 0;
    let aliasing_buffers = flags & multiple_binding_flags::ALIASING_BUFFERS != 0;

    let gl = case.gl();
    let vao = VertexArray::new(gl);
    let (primitive_buffer, color_offset_buffer) =
        multiple_binding_create_buffers(gl, zero_stride, instanced, aliasing_buffers);
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(POSITION_COLOR_OFFSET_SHADER, COLOR_FRAGMENT_SHADER),
    );
    if !program.is_ok() {
        case.fail("could not build shader".to_string(), "Fail");
        return;
    }
    let program_id = program.program();

    // SAFETY: names of a program this case just linked.
    let (position_loc, color_loc, offset_loc) = unsafe {
        (
            gl.get_attrib_location(program_id, c"a_position".as_ptr()),
            gl.get_attrib_location(program_id, c"a_color".as_ptr()),
            gl.get_attrib_location(program_id, c"a_offset".as_ptr()),
        )
    };
    let position_loc = position_loc as GLuint;
    let color_loc = color_loc as GLuint;
    let offset_loc = offset_loc as GLuint;

    const POSITION_BINDING: GLuint = 1;
    const COLOR_OFFSET_BINDING: GLuint = 2;

    let mut surface = Surface::new(TEST_RENDER_SIZE, TEST_RENDER_SIZE);

    // SAFETY: plain draw state against objects this case just created and linked.
    unsafe {
        gl.clear_color(0.0, 0.0, 0.0, 0.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.viewport(0, 0, TEST_RENDER_SIZE, TEST_RENDER_SIZE);
        gl.bind_vertex_array(vao.get());
    }
    case.expect_no_error("set vao");
    unsafe { gl.use_program(program_id) };
    case.expect_no_error("use program");

    // Setup format & binding.
    // SAFETY: as above.
    unsafe {
        gl.enable_vertex_attrib_array(position_loc);
        gl.enable_vertex_attrib_array(color_loc);
        gl.enable_vertex_attrib_array(offset_loc);

        gl.vertex_attrib_format(position_loc, 4, glw::GL_FLOAT, glw::FALSE, 0);
        gl.vertex_attrib_format(color_loc, 4, glw::GL_FLOAT, glw::FALSE, 0);
        gl.vertex_attrib_format(offset_loc, 4, glw::GL_FLOAT, glw::FALSE, VEC4_BYTES as GLuint);

        gl.vertex_attrib_binding(position_loc, POSITION_BINDING);
        gl.vertex_attrib_binding(color_loc, COLOR_OFFSET_BINDING);
        gl.vertex_attrib_binding(offset_loc, COLOR_OFFSET_BINDING);
    }
    case.expect_no_error("setup attribs");

    // setup binding points.
    // SAFETY: as above.
    unsafe {
        gl.vertex_binding_divisor(POSITION_BINDING, 0);
        gl.bind_vertex_buffer(POSITION_BINDING, primitive_buffer.get(), 0, VEC4_BYTES as GLenum as i32);
    }
    {
        let stride = if zero_stride { 0 } else { 2 * VEC4_BYTES as i32 };
        let offset: isize = if !aliasing_buffers {
            0
        } else if instanced {
            VEC4_BYTES as isize * 6
        } else {
            VEC4_BYTES as isize * (6 * GRID_SIZE * GRID_SIZE) as isize
        };
        let buffer_name = if aliasing_buffers {
            primitive_buffer.get()
        } else {
            color_offset_buffer.as_ref().expect("built when not aliasing").get()
        };
        let divisor = if instanced { 1 } else { 0 };

        // SAFETY: as above.
        unsafe {
            gl.vertex_binding_divisor(COLOR_OFFSET_BINDING, divisor);
            gl.bind_vertex_buffer(COLOR_OFFSET_BINDING, buffer_name, offset, stride);
        }
    }
    case.expect_no_error("set binding points");

    // SAFETY: as above.
    unsafe {
        if instanced {
            gl.draw_arrays_instanced(glw::GL_TRIANGLES, 0, 6, GRID_SIZE * GRID_SIZE);
        } else {
            gl.draw_arrays(glw::GL_TRIANGLES, 0, GRID_SIZE * GRID_SIZE * 6);
        }
    }
    case.expect_no_error("draw");

    // SAFETY: as above.
    unsafe {
        gl.finish();
        gl.bind_vertex_array(0);
        gl.use_program(0);
    }
    case.expect_no_error("clean");

    if let Err(e) = glu::pixel_transfer::read_pixels(&case.context().render_context, 0, 0, &mut surface.get_access()) {
        case.fail(e.to_string(), "Fail");
        return;
    }

    finish_binding_render_case(case, &surface);
}

// MixedBindingCase

/// `MixedBindingCase::CaseType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum MixedBindingCaseType {
    Basic,
    InstancedBinding,
    InstancedAttrib,
}

/// `MixedBindingCase::createBuffers`
fn mixed_binding_create_buffers<'gl>(
    gl: &'gl glw::Functions,
    case_type: MixedBindingCaseType,
) -> (Buffer<'gl>, Buffer<'gl>) {
    let green = [0.0f32, 1.0, 0.0, 1.0];
    let yellow = [1.0f32, 1.0, 0.0, 1.0];

    // draw grid. In instanced mode, each cell is an instance.
    let instanced = matches!(
        case_type,
        MixedBindingCaseType::InstancedBinding | MixedBindingCaseType::InstancedAttrib
    );
    let num_cells = GRID_SIZE * GRID_SIZE;
    let num_position_cells = if instanced { 1 } else { num_cells };
    let num_instance_elements_per_cell = if instanced { 1 } else { 6 };

    let mut position_data = vec![[0.0f32; 4]; (6 * num_position_cells) as usize];
    let mut color_offset_data = vec![[0.0f32; 4]; (2 * num_instance_elements_per_cell * num_cells) as usize];

    // positions.
    for prim_ndx in 0..num_position_cells {
        let base = (prim_ndx * 6) as usize;
        position_data[base] = [0.0, 0.0, 0.0, 1.0];
        position_data[base + 1] = [0.0, 2.0 / GRID_SIZE as f32, 0.0, 1.0];
        position_data[base + 2] = [2.0 / GRID_SIZE as f32, 2.0 / GRID_SIZE as f32, 0.0, 1.0];
        position_data[base + 3] = [0.0, 0.0, 0.0, 1.0];
        position_data[base + 4] = [2.0 / GRID_SIZE as f32, 2.0 / GRID_SIZE as f32, 0.0, 1.0];
        position_data[base + 5] = [2.0 / GRID_SIZE as f32, 0.0, 0.0, 1.0];
    }

    // color & offset.
    for y in 0..GRID_SIZE {
        for x in 0..GRID_SIZE {
            for v in 0..num_instance_elements_per_cell {
                let color = if (x + y) % 2 == 0 { green } else { yellow };
                let ndx = (((y * GRID_SIZE + x) * num_instance_elements_per_cell + v) * 2) as usize;
                color_offset_data[ndx] = color;
                color_offset_data[ndx + 1] = [
                    x as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                    y as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                    0.0,
                    0.0,
                ];
            }
        }
    }

    // upload vertex data.
    let position_buffer = Buffer::new(gl);
    // SAFETY: `position_data` is exactly the size passed to `buffer_data`.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, position_buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_val(position_data.as_slice()) as isize,
            position_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }

    let color_offset_buffer = Buffer::new(gl);
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, color_offset_buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_val(color_offset_data.as_slice()) as isize,
            color_offset_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }

    (position_buffer, color_offset_buffer)
}

/// `MixedBindingCase::renderTo`
fn mixed_binding_case(case: &mut ApiCase<'_>, case_type: MixedBindingCaseType) {
    if !check_render_target_size(case) {
        return;
    }

    let gl = case.gl();
    let vao = VertexArray::new(gl);
    let (pos_buffer, color_offset_buffer) = mixed_binding_create_buffers(gl, case_type);
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(POSITION_COLOR_OFFSET_SHADER, COLOR_FRAGMENT_SHADER),
    );
    if !program.is_ok() {
        case.fail("could not build shader".to_string(), "Fail");
        return;
    }
    let program_id = program.program();

    // SAFETY: names of a program this case just linked.
    let (position_loc, color_loc, offset_loc) = unsafe {
        (
            gl.get_attrib_location(program_id, c"a_position".as_ptr()),
            gl.get_attrib_location(program_id, c"a_color".as_ptr()),
            gl.get_attrib_location(program_id, c"a_offset".as_ptr()),
        )
    };
    let position_loc = position_loc as GLuint;
    let color_loc = color_loc as GLuint;
    let offset_loc = offset_loc as GLuint;

    let mut surface = Surface::new(TEST_RENDER_SIZE, TEST_RENDER_SIZE);

    // SAFETY: plain draw state against objects this case just created and linked.
    unsafe {
        gl.clear_color(0.0, 0.0, 0.0, 0.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.viewport(0, 0, TEST_RENDER_SIZE, TEST_RENDER_SIZE);
        gl.bind_vertex_array(vao.get());
    }
    case.expect_no_error("set vao");
    unsafe { gl.use_program(program_id) };
    case.expect_no_error("use program");

    match case_type {
        MixedBindingCaseType::Basic => {
            // bind position using vertex_attrib_binding api.
            // SAFETY: as above.
            unsafe {
                gl.bind_vertex_buffer(position_loc, pos_buffer.get(), 0, VEC4_BYTES as i32);
                gl.vertex_attrib_binding(position_loc, position_loc);
                gl.vertex_attrib_format(position_loc, 4, glw::GL_FLOAT, glw::FALSE, 0);
            }
            case.expect_no_error("set binding");

            // bind color using old api.
            // SAFETY: as above.
            unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, color_offset_buffer.get());
                gl.vertex_attrib_pointer(
                    color_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    std::ptr::null(),
                );
                gl.vertex_attrib_pointer(
                    offset_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    VEC4_BYTES as *const _,
                );
            }
            case.expect_no_error("set va");

            // draw.
            // SAFETY: as above.
            unsafe {
                gl.enable_vertex_attrib_array(position_loc);
                gl.enable_vertex_attrib_array(color_loc);
                gl.enable_vertex_attrib_array(offset_loc);
                gl.draw_arrays(glw::GL_TRIANGLES, 0, 6 * GRID_SIZE * GRID_SIZE);
            }
        }
        MixedBindingCaseType::InstancedBinding => {
            // bind position using old api.
            // SAFETY: as above.
            unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, pos_buffer.get());
                gl.vertex_attrib_pointer(position_loc, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
            }
            case.expect_no_error("set va");

            // bind color using vertex_attrib_binding api.
            // SAFETY: as above.
            unsafe {
                gl.bind_vertex_buffer(color_loc, color_offset_buffer.get(), 0, (2 * VEC4_BYTES) as i32);
                gl.vertex_binding_divisor(color_loc, 1);

                gl.vertex_attrib_binding(color_loc, color_loc);
                gl.vertex_attrib_binding(offset_loc, color_loc);

                gl.vertex_attrib_format(color_loc, 4, glw::GL_FLOAT, glw::FALSE, 0);
                gl.vertex_attrib_format(offset_loc, 4, glw::GL_FLOAT, glw::FALSE, VEC4_BYTES as GLuint);
            }
            case.expect_no_error("set binding");

            // draw.
            // SAFETY: as above.
            unsafe {
                gl.enable_vertex_attrib_array(position_loc);
                gl.enable_vertex_attrib_array(color_loc);
                gl.enable_vertex_attrib_array(offset_loc);
                gl.draw_arrays_instanced(glw::GL_TRIANGLES, 0, 6, GRID_SIZE * GRID_SIZE);
            }
        }
        MixedBindingCaseType::InstancedAttrib => {
            // bind position using vertex_attrib_binding api.
            // SAFETY: as above.
            unsafe {
                gl.bind_vertex_buffer(position_loc, pos_buffer.get(), 0, VEC4_BYTES as i32);
                gl.vertex_attrib_binding(position_loc, position_loc);
                gl.vertex_attrib_format(position_loc, 4, glw::GL_FLOAT, glw::FALSE, 0);
            }
            case.expect_no_error("set binding");

            // bind color using old api.
            // SAFETY: as above.
            unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, color_offset_buffer.get());
                gl.vertex_attrib_pointer(
                    color_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    std::ptr::null(),
                );
                gl.vertex_attrib_pointer(
                    offset_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    VEC4_BYTES as *const _,
                );
                gl.vertex_attrib_divisor(color_loc, 1);
                gl.vertex_attrib_divisor(offset_loc, 1);
            }
            case.expect_no_error("set va");

            // draw.
            // SAFETY: as above.
            unsafe {
                gl.enable_vertex_attrib_array(position_loc);
                gl.enable_vertex_attrib_array(color_loc);
                gl.enable_vertex_attrib_array(offset_loc);
                gl.draw_arrays_instanced(glw::GL_TRIANGLES, 0, 6, GRID_SIZE * GRID_SIZE);
            }
        }
    }
    case.expect_no_error("draw");

    // SAFETY: as above.
    unsafe {
        gl.finish();
        gl.bind_vertex_array(0);
        gl.use_program(0);
    }
    case.expect_no_error("clean");

    if let Err(e) = glu::pixel_transfer::read_pixels(&case.context().render_context, 0, 0, &mut surface.get_access()) {
        case.fail(e.to_string(), "Fail");
        return;
    }

    finish_binding_render_case(case, &surface);
}

// MixedApiCase

/// `MixedApiCase::CaseType`
///
/// clippy refuses upstream's shared `Change*` prefix (`enum_variant_names`); the variants
/// are `CASE_CHANGE_BUFFER` / `_BUFFER_OFFSET` / `_BUFFER_STRIDE` / `_BINDING_POINT` upstream.
#[derive(Clone, Copy)]
#[allow(clippy::enum_variant_names)]
enum MixedApiCaseType {
    ChangeBuffer,
    ChangeBufferOffset,
    ChangeBufferStride,
    ChangeBindingPoint,
}

/// `MixedApiCase::createBuffers`
fn mixed_api_create_buffer(gl: &glw::Functions) -> Buffer<'_> {
    let green = [0.0f32, 1.0, 0.0, 1.0];
    let yellow = [1.0f32, 1.0, 0.0, 1.0];
    let mut vertex_data = vec![[0.0f32; 4]; (12 * GRID_SIZE * GRID_SIZE) as usize];

    for y in 0..GRID_SIZE {
        for x in 0..GRID_SIZE {
            let color = if (x + y) % 2 == 0 { green } else { yellow };
            let (gx0, gx1) = (
                x as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                (x + 1) as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
            );
            let (gy0, gy1) = (
                y as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
                (y + 1) as f32 / GRID_SIZE as f32 * 2.0 - 1.0,
            );
            let base = ((y * GRID_SIZE + x) * 12) as usize;

            vertex_data[base] = [gx0, gy0, 0.0, 1.0];
            vertex_data[base + 1] = color;
            vertex_data[base + 2] = [gx0, gy1, 0.0, 1.0];
            vertex_data[base + 3] = color;
            vertex_data[base + 4] = [gx1, gy1, 0.0, 1.0];
            vertex_data[base + 5] = color;
            vertex_data[base + 6] = [gx0, gy0, 0.0, 1.0];
            vertex_data[base + 7] = color;
            vertex_data[base + 8] = [gx1, gy1, 0.0, 1.0];
            vertex_data[base + 9] = color;
            vertex_data[base + 10] = [gx1, gy0, 0.0, 1.0];
            vertex_data[base + 11] = color;
        }
    }

    let buffer = Buffer::new(gl);
    // SAFETY: `vertex_data` is exactly the size passed to `buffer_data`.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
        gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            size_of_val(vertex_data.as_slice()) as isize,
            vertex_data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }
    buffer
}

/// `MixedApiCase::renderTo`
fn mixed_api_case(case: &mut ApiCase<'_>, case_type: MixedApiCaseType) {
    if !check_render_target_size(case) {
        return;
    }

    let gl = case.gl();
    let vao = VertexArray::new(gl);
    let buffer = mixed_api_create_buffer(gl);
    let unused_buffer = Buffer::new(gl);
    let program = ShaderProgram::new(
        gl,
        &ProgramSources::vtx_frag(POSITION_COLOR_SHADER, COLOR_FRAGMENT_SHADER),
    );
    if !program.is_ok() {
        case.fail("could not build shader".to_string(), "Fail");
        return;
    }
    let program_id = program.program();

    // SAFETY: names of a program this case just linked.
    let (position_loc, color_loc) = unsafe {
        (
            gl.get_attrib_location(program_id, c"a_position".as_ptr()),
            gl.get_attrib_location(program_id, c"a_color".as_ptr()),
        )
    };
    let position_loc = position_loc as GLuint;
    let color_loc = color_loc as GLuint;

    let mut surface = Surface::new(TEST_RENDER_SIZE, TEST_RENDER_SIZE);

    // SAFETY: plain draw state against objects this case just created and linked.
    unsafe {
        gl.clear_color(0.0, 0.0, 0.0, 0.0);
        gl.clear(glw::GL_COLOR_BUFFER_BIT);
        gl.viewport(0, 0, TEST_RENDER_SIZE, TEST_RENDER_SIZE);
        gl.bind_vertex_array(vao.get());
    }
    case.expect_no_error("set vao");
    unsafe { gl.use_program(program_id) };
    case.expect_no_error("use program");

    match case_type {
        MixedApiCaseType::ChangeBuffer => {
            // bind data using old api.
            // SAFETY: as above; `unused_buffer` is abandoned once the binding-point calls
            // below rebind both attributes to `buffer`, exactly as upstream leaves it.
            unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, unused_buffer.get());
                gl.vertex_attrib_pointer(
                    position_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    std::ptr::null(),
                );
                gl.vertex_attrib_pointer(
                    color_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    VEC4_BYTES as *const _,
                );

                // change buffer with vertex_attrib_binding.
                gl.bind_vertex_buffer(position_loc, buffer.get(), 0, (2 * VEC4_BYTES) as i32);
                gl.bind_vertex_buffer(color_loc, buffer.get(), VEC4_BYTES as isize, (2 * VEC4_BYTES) as i32);
            }
            case.expect_no_error("");
        }
        MixedApiCaseType::ChangeBufferOffset => {
            // bind data using old api.
            // SAFETY: as above.
            unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
                gl.vertex_attrib_pointer(
                    position_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    std::ptr::null(),
                );
                gl.vertex_attrib_pointer(
                    color_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    std::ptr::null(),
                );

                // change buffer offset with vertex_attrib_binding.
                gl.bind_vertex_buffer(position_loc, buffer.get(), 0, (2 * VEC4_BYTES) as i32);
                gl.bind_vertex_buffer(color_loc, buffer.get(), VEC4_BYTES as isize, (2 * VEC4_BYTES) as i32);
            }
            case.expect_no_error("");
        }
        MixedApiCaseType::ChangeBufferStride => {
            // bind data using old api.
            // SAFETY: as above.
            unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
                gl.vertex_attrib_pointer(position_loc, 4, glw::GL_FLOAT, glw::FALSE, 8, std::ptr::null());
                gl.vertex_attrib_pointer(color_loc, 4, glw::GL_FLOAT, glw::FALSE, 4, std::ptr::null());

                // change buffer stride with vertex_attrib_binding.
                gl.bind_vertex_buffer(position_loc, buffer.get(), 0, (2 * VEC4_BYTES) as i32);
                gl.bind_vertex_buffer(color_loc, buffer.get(), VEC4_BYTES as isize, (2 * VEC4_BYTES) as i32);
            }
            case.expect_no_error("");
        }
        MixedApiCaseType::ChangeBindingPoint => {
            let max_used_location = position_loc.max(color_loc);
            let binding_point_1 = max_used_location + 1;
            let binding_point_2 = max_used_location + 2;

            // bind data using old api.
            // SAFETY: `binding_point_1`/`binding_point_2` are small attribute indices never
            // enabled via `enable_vertex_attrib_array`, used here only for the implicit
            // binding point `vertex_attrib_pointer` creates at their index.
            unsafe {
                gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer.get());
                gl.vertex_attrib_pointer(
                    binding_point_1,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    std::ptr::null(),
                );
                gl.vertex_attrib_pointer(
                    binding_point_2,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    (2 * VEC4_BYTES) as i32,
                    VEC4_BYTES as *const _,
                );

                // change buffer binding point with vertex_attrib_binding.
                gl.vertex_attrib_format(position_loc, 4, glw::GL_FLOAT, glw::FALSE, 0);
                gl.vertex_attrib_format(color_loc, 4, glw::GL_FLOAT, glw::FALSE, 0);

                gl.vertex_attrib_binding(position_loc, binding_point_1);
                gl.vertex_attrib_binding(color_loc, binding_point_2);
            }
            case.expect_no_error("");
        }
    }

    // draw.
    // SAFETY: as above.
    unsafe {
        gl.enable_vertex_attrib_array(position_loc);
        gl.enable_vertex_attrib_array(color_loc);
        gl.draw_arrays(glw::GL_TRIANGLES, 0, 6 * GRID_SIZE * GRID_SIZE);
    }

    // SAFETY: as above.
    unsafe {
        gl.finish();
        gl.bind_vertex_array(0);
        gl.use_program(0);
    }
    case.expect_no_error("clean");

    if let Err(e) = glu::pixel_transfer::read_pixels(&case.context().render_context, 0, 0, &mut surface.get_access()) {
        case.fail(e.to_string(), "Fail");
        return;
    }

    finish_binding_render_case(case, &surface);
}

/// `VertexAttributeBindingTests::init`'s `.usage` sub-group.
fn usage_group() -> TestCaseGroup {
    let mut single_group = TestCaseGroup::new("single_binding");
    let mut multiple_group = TestCaseGroup::new("multiple_bindings");
    let mut mixed_group = TestCaseGroup::new("mixed_usage");

    {
        use single_binding_flags::*;
        for (name, flags) in [
            ("elements_1", 0),
            ("elements_2", ATTRIBS_MULTIPLE_ELEMS),
            ("elements_2_share_elements", ATTRIBS_SHARED_ELEMS),
            ("offset_elements_1", BUF_ALIGNED_OFFSET),
            ("offset_elements_2", BUF_ALIGNED_OFFSET | ATTRIBS_MULTIPLE_ELEMS),
            (
                "offset_elements_2_share_elements",
                BUF_ALIGNED_OFFSET | ATTRIBS_SHARED_ELEMS,
            ),
            (
                "unaligned_offset_elements_1_aligned_elements",
                BUF_UNALIGNED_OFFSET | ATTRIB_ALIGNED,
            ),
        ] {
            add_api_case(&mut single_group, name, move |case: &mut ApiCase<'_>| {
                single_binding_case(case, flags)
            });
        }
    }

    {
        use multiple_binding_flags::*;
        for (name, flags) in [
            ("basic", 0),
            ("zero_stride", ZERO_STRIDE),
            ("instanced", INSTANCED),
            ("aliasing_buffer_zero_stride", ALIASING_BUFFERS | ZERO_STRIDE),
            ("aliasing_buffer_instanced", ALIASING_BUFFERS | INSTANCED),
        ] {
            add_api_case(&mut multiple_group, name, move |case: &mut ApiCase<'_>| {
                multiple_binding_case(case, flags)
            });
        }
    }

    for (name, case_type) in [
        ("mixed_attribs_basic", MixedBindingCaseType::Basic),
        (
            "mixed_attribs_instanced_binding",
            MixedBindingCaseType::InstancedBinding,
        ),
        ("mixed_attribs_instanced_attrib", MixedBindingCaseType::InstancedAttrib),
    ] {
        add_api_case(&mut mixed_group, name, move |case: &mut ApiCase<'_>| {
            mixed_binding_case(case, case_type)
        });
    }

    for (name, case_type) in [
        ("mixed_api_change_buffer", MixedApiCaseType::ChangeBuffer),
        ("mixed_api_change_buffer_offset", MixedApiCaseType::ChangeBufferOffset),
        ("mixed_api_change_buffer_stride", MixedApiCaseType::ChangeBufferStride),
        ("mixed_api_change_binding_point", MixedApiCaseType::ChangeBindingPoint),
    ] {
        add_api_case(&mut mixed_group, name, move |case: &mut ApiCase<'_>| {
            mixed_api_case(case, case_type)
        });
    }

    let mut group = TestCaseGroup::new("usage");
    group.add_child(single_group);
    group.add_child(multiple_group);
    group.add_child(mixed_group);
    group
}

/// `VertexAttributeBindingTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex_attribute_binding");
    group.add_child(usage_group());
    group.add_child(negative_group());
    group
}
