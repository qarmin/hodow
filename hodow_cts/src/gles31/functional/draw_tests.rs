// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fDrawTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `negative` sub-group is here;
// `draw_arrays_indirect`, `draw_elements_indirect` and `random` live in
// `draw_indirect_tests.rs` (they go through `gls::DrawTest`), `compute_interop` in
// `draw_compute_interop_tests.rs`, `instancing` in `draw_instancing_tests.rs`.
//
// Upstream's negative cases route their GL calls through an `sglr::GLContext`, which here is
// only a call-logging wrapper over the same entry points - unlike `es31fGeometryShaderTests`'
// negative cases, which also build an `sglr::ShaderProgram`. So these go straight onto
// `glw::Functions`, and the programs they need are ordinary `glu::ShaderProgram`s.

use crate::glu::{
    ApiCase, Buffer, ProgramSources, ShaderProgram, ShaderType, TestCaseGroup, VertexArray, add_api_case,
};
use crate::glw::{self, GLenum, GLint, GLsizeiptr, GLuint};

/// `s_commonVertexShaderSource`
const COMMON_VERTEX_SHADER_SOURCE: &str = "#version 310 es\n\
    in highp vec4 a_position;\n\
    void main (void)\n\
    {\n\
    \tgl_Position = a_position;\n\
    }\n";

/// `s_commonFragmentShaderSource`
const COMMON_FRAGMENT_SHADER_SOURCE: &str = "#version 310 es\n\
    layout(location = 0) out highp vec4 fragColor;\n\
    void main (void)\n\
    {\n\
    \tfragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\
    }\n";

/// `vertexPositions[]` - the same three vertices every case in this group uses.
const VERTEX_POSITIONS: [f32; 12] = [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0];

/// `indices[]`
const INDICES: [u16; 3] = [0, 2, 1];

/// `DrawElementsCommand`, as the 20 bytes the driver reads out of the indirect buffer.
/// `count`, `primCount`, `firstIndex`, `baseVertex`, `reservedMustBeZero`.
const DRAW_ELEMENTS_COMMAND: [u32; 5] = [3, 1, 0, 0, 0];

/// `DrawArraysCommand`: `count`, `primCount`, `first`, `reservedMustBeZero`.
const DRAW_ARRAYS_COMMAND: [u32; 4] = [3, 1, 0, 0];

/// `BadCommandBufferCase::CommandSize`
const COMMAND_SIZE: u32 = 20;

/// The common vertex/fragment program, plus the location of its one attribute.
fn build_common_program<'gl>(case: &ApiCase<'gl>) -> (ShaderProgram<'gl>, GLint) {
    let sources = ProgramSources::default()
        .with(ShaderType::Vertex, COMMON_VERTEX_SHADER_SOURCE)
        .with(ShaderType::Fragment, COMMON_FRAGMENT_SHADER_SOURCE);
    let program = ShaderProgram::new(case.gl(), &sources);

    let name = c"a_position";
    // SAFETY: the name outlives the call. A program that failed to link answers -1, which
    // the callers pass on to GL exactly as upstream does.
    let location = unsafe { case.gl().get_attrib_location(program.program(), name.as_ptr()) };
    (program, location)
}

/// `gl.bufferData(target, size, data, GL_STATIC_DRAW)` for a slice of plain data.
fn buffer_data<T>(case: &ApiCase<'_>, target: GLenum, data: &[T]) {
    // SAFETY: `data` is `size_of_val` bytes of initialised plain data and outlives the call.
    unsafe {
        case.gl().buffer_data(
            target,
            size_of_val(data) as GLsizeiptr,
            data.as_ptr().cast(),
            glw::GL_STATIC_DRAW,
        );
    }
}

/// The verdict every case in this group reaches.
fn expect_draw_error(case: &mut ApiCase<'_>, error: GLenum, expected: GLenum) {
    if error != expected {
        case.fail(
            format!(
                "Unexpected error. Expected {}, got {}",
                glw::error_name(expected),
                glw::error_name(error)
            ),
            "Got unexpected error.",
        );
    }
}

/// `BadCommandBufferCase::iterate`
///
/// `BadAlignmentCase` is this with `bufferSize = CommandSize + alignment`, the command
/// written, and `GL_INVALID_VALUE` expected; `BadBufferRangeCase` is it with
/// `bufferSize = CommandSize`, no command written, and `GL_INVALID_OPERATION`.
fn bad_command_buffer_case(
    case: &mut ApiCase<'_>,
    alignment: u32,
    buffer_size: u32,
    write_command_to_buffer: bool,
    expected_error: GLenum,
) {
    let gl = case.gl();
    let (program, pos_location) = build_common_program(case);

    let mut draw_command_buffer = vec![0u8; buffer_size as usize];
    if write_command_to_buffer {
        // `deMemcpy(&drawCommandBuffer[m_alignment], &drawCommand, sizeof(drawCommand))` -
        // the struct is tightly packed, so this is its five words in host byte order.
        let offset = alignment as usize;
        for (ndx, word) in DRAW_ELEMENTS_COMMAND.iter().enumerate() {
            let at = offset + ndx * size_of::<u32>();
            draw_command_buffer[at..at + size_of::<u32>()].copy_from_slice(&word.to_ne_bytes());
        }
    }

    case.expect_no_error("");

    let vao = VertexArray::new(gl);
    let position_buf = Buffer::new(gl);
    let index_buf = Buffer::new(gl);
    let draw_indirect_buf = Buffer::new(gl);

    #[expect(
        clippy::cast_sign_loss,
        reason = "upstream passes the raw attribute location to GL as well"
    )]
    let pos_index = pos_location as GLuint;

    // SAFETY: every buffer below outlives the draw, and the vertex attribute is fed from a
    // buffer object rather than client memory.
    unsafe {
        gl.bind_vertex_array(vao.get());

        gl.bind_buffer(glw::GL_ARRAY_BUFFER, position_buf.get());
        buffer_data(case, glw::GL_ARRAY_BUFFER, &VERTEX_POSITIONS);
        gl.vertex_attrib_pointer(pos_index, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
        gl.vertex_attrib_divisor(pos_index, 0);
        gl.enable_vertex_attrib_array(pos_index);
    }
    case.expect_no_error("");

    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buf.get());
        buffer_data(case, glw::GL_ELEMENT_ARRAY_BUFFER, &INDICES);
    }
    case.expect_no_error("");

    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, draw_indirect_buf.get());
        buffer_data(case, glw::GL_DRAW_INDIRECT_BUFFER, &draw_command_buffer);
    }
    case.expect_no_error("");

    // SAFETY: the malformed indirect offset is exactly what is being checked.
    let error = unsafe {
        gl.viewport(0, 0, 1, 1);
        gl.use_program(program.program());
        gl.draw_elements_indirect(
            glw::GL_TRIANGLES,
            glw::GL_UNSIGNED_SHORT,
            std::ptr::without_provenance(alignment as usize),
        );
        let error = gl.get_error();
        gl.use_program(0);
        gl.bind_vertex_array(0);
        error
    };

    expect_draw_error(case, error, expected_error);
}

/// `BadStateCase::CaseType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum BadState {
    ClientBufferVertexAttr,
    ClientBufferCommand,
    DefaultVao,
}

/// `BadStateCase::iterate`
fn bad_state_case(case: &mut ApiCase<'_>, case_type: BadState) {
    let gl = case.gl();
    let (program, pos_location) = build_common_program(case);

    #[expect(
        clippy::cast_sign_loss,
        reason = "upstream passes the raw attribute location to GL as well"
    )]
    let pos_index = pos_location as GLuint;

    case.expect_no_error("");

    // The vertex array object only exists for the one case that needs a non-default one:
    // the other two are errors *because* the default VAO is bound.
    let vao = (case_type == BadState::ClientBufferCommand).then(|| VertexArray::new(gl));
    let data_buffer = (case_type != BadState::ClientBufferVertexAttr).then(|| Buffer::new(gl));

    match case_type {
        BadState::ClientBufferVertexAttr => {
            // \note We use default VAO since we use client pointers. Trying indirect draw
            // with default VAO is also an error. => This test does two illegal operations
            // SAFETY: the client array outlives the draw below.
            unsafe {
                gl.vertex_attrib_pointer(
                    pos_index,
                    4,
                    glw::GL_FLOAT,
                    glw::FALSE,
                    0,
                    VERTEX_POSITIONS.as_ptr().cast(),
                );
                gl.enable_vertex_attrib_array(pos_index);
            }
        }
        BadState::ClientBufferCommand | BadState::DefaultVao => {
            // SAFETY: the buffer outlives the draw.
            unsafe {
                if let Some(vao) = &vao {
                    gl.bind_vertex_array(vao.get());
                }
                gl.bind_buffer(
                    glw::GL_ARRAY_BUFFER,
                    data_buffer
                        .as_ref()
                        .expect("a data buffer in both of these cases")
                        .get(),
                );
                buffer_data(case, glw::GL_ARRAY_BUFFER, &VERTEX_POSITIONS);
                gl.vertex_attrib_pointer(pos_index, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
                gl.enable_vertex_attrib_array(pos_index);
            }
        }
    }
    case.expect_no_error("");

    let index_buffer = Buffer::new(gl);
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buffer.get());
        buffer_data(case, glw::GL_ELEMENT_ARRAY_BUFFER, &INDICES);
    }
    case.expect_no_error("");

    let cmd_buffer = (case_type != BadState::ClientBufferCommand).then(|| Buffer::new(gl));
    if let Some(cmd_buffer) = &cmd_buffer {
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, cmd_buffer.get()) };
        buffer_data(case, glw::GL_DRAW_INDIRECT_BUFFER, &DRAW_ELEMENTS_COMMAND);
        case.expect_no_error("");
    }

    // SAFETY: the illegal state is what is being checked; the client-memory command array
    // outlives the call that names it.
    let error = unsafe {
        gl.viewport(0, 0, 1, 1);
        gl.use_program(program.program());
        let indirect = if case_type == BadState::ClientBufferCommand {
            DRAW_ELEMENTS_COMMAND.as_ptr().cast()
        } else {
            std::ptr::null()
        };
        gl.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_SHORT, indirect);
        let error = gl.get_error();
        gl.bind_vertex_array(0);
        gl.use_program(0);
        error
    };

    expect_draw_error(case, error, glw::GL_INVALID_OPERATION);
}

/// `BadDrawModeCase::DrawType`
#[derive(Clone, Copy, PartialEq, Eq)]
#[expect(
    clippy::enum_variant_names,
    reason = "upstream's DRAW_ARRAYS / DRAW_ELEMENTS / DRAW_ELEMENTS_BAD_INDEX, kept"
)]
enum BadDrawMode {
    DrawArrays,
    DrawElements,
    DrawElementsBadIndex,
}

/// `BadDrawModeCase::iterate`
fn bad_draw_mode_case(case: &mut ApiCase<'_>, draw_type: BadDrawMode) {
    let gl = case.gl();
    let (program, pos_location) = build_common_program(case);

    let bad_index = draw_type == BadDrawMode::DrawElementsBadIndex;
    let mode: GLenum = if bad_index { glw::GL_TRIANGLES } else { 0x123 };
    let index_type: GLenum = if bad_index { 0x123 } else { glw::GL_UNSIGNED_SHORT };
    let draws_elements = draw_type != BadDrawMode::DrawArrays;

    #[expect(
        clippy::cast_sign_loss,
        reason = "upstream passes the raw attribute location to GL as well"
    )]
    let pos_index = pos_location as GLuint;

    case.expect_no_error("");

    // vao
    let vao = VertexArray::new(gl);
    // SAFETY: the buffers below outlive the draw.
    unsafe { gl.bind_vertex_array(vao.get()) };

    // va
    let data_buffer = Buffer::new(gl);
    // SAFETY: as above.
    unsafe {
        gl.bind_buffer(glw::GL_ARRAY_BUFFER, data_buffer.get());
        buffer_data(case, glw::GL_ARRAY_BUFFER, &VERTEX_POSITIONS);
        gl.vertex_attrib_pointer(pos_index, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null());
        gl.enable_vertex_attrib_array(pos_index);
    }
    case.expect_no_error("");

    // index
    let index_buffer = draws_elements.then(|| Buffer::new(gl));
    if let Some(index_buffer) = &index_buffer {
        // SAFETY: as above.
        unsafe { gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_buffer.get()) };
        buffer_data(case, glw::GL_ELEMENT_ARRAY_BUFFER, &INDICES);
        case.expect_no_error("");
    }

    // cmd
    let cmd_buffer = Buffer::new(gl);
    // SAFETY: as above.
    unsafe { gl.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, cmd_buffer.get()) };
    if draws_elements {
        buffer_data(case, glw::GL_DRAW_INDIRECT_BUFFER, &DRAW_ELEMENTS_COMMAND);
    } else {
        buffer_data(case, glw::GL_DRAW_INDIRECT_BUFFER, &DRAW_ARRAYS_COMMAND);
    }
    case.expect_no_error("");

    // SAFETY: the invalid mode/type is what is being checked.
    let error = unsafe {
        gl.viewport(0, 0, 1, 1);
        gl.use_program(program.program());
        if draws_elements {
            gl.draw_elements_indirect(mode, index_type, std::ptr::null());
        } else {
            gl.draw_arrays_indirect(mode, std::ptr::null());
        }
        let error = gl.get_error();
        gl.use_program(0);
        gl.bind_vertex_array(0);
        error
    };

    expect_draw_error(case, error, glw::GL_INVALID_ENUM);
}

/// `NegativeGroup::init`
fn negative_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("negative");

    // invalid alignment
    for (name, alignment) in [
        ("command_bad_alignment_1", 1),
        ("command_bad_alignment_2", 2),
        ("command_bad_alignment_3", 3),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            bad_command_buffer_case(case, alignment, COMMAND_SIZE + alignment, true, glw::GL_INVALID_VALUE);
        });
    }

    // command only partially or not at all in the buffer
    for (name, offset) in [
        ("command_offset_partially_in_buffer", COMMAND_SIZE - 16),
        ("command_offset_not_in_buffer", COMMAND_SIZE),
        ("command_offset_not_in_buffer_unsigned32_wrap", 0xFFFF_FFFC_u32),
        ("command_offset_not_in_buffer_signed32_wrap", 0x7FFF_FFFC_u32),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            bad_command_buffer_case(case, offset, COMMAND_SIZE, false, glw::GL_INVALID_OPERATION);
        });
    }

    // use with client data and default vao
    for (name, case_type) in [
        ("client_vertex_attrib_array", BadState::ClientBufferVertexAttr),
        ("client_command_array", BadState::ClientBufferCommand),
        ("default_vao", BadState::DefaultVao),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            bad_state_case(case, case_type)
        });
    }

    // invalid mode & type
    for (name, draw_type) in [
        ("invalid_mode_draw_arrays", BadDrawMode::DrawArrays),
        ("invalid_mode_draw_elements", BadDrawMode::DrawElements),
        ("invalid_type_draw_elements", BadDrawMode::DrawElementsBadIndex),
    ] {
        add_api_case(&mut group, name, move |case: &mut ApiCase<'_>| {
            bad_draw_mode_case(case, draw_type)
        });
    }

    group
}

/// `DrawTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("draw_indirect");
    for method_group in crate::gles31::functional::draw_indirect_tests::create_basic_groups() {
        group.add_child(method_group);
    }
    group.add_child(crate::gles31::functional::draw_instancing_tests::create_tests());
    group.add_child(crate::gles31::functional::draw_compute_interop_tests::create_tests());
    group.add_child(crate::gles31::functional::draw_indirect_tests::create_random_group());
    group.add_child(negative_group());
    group
}
