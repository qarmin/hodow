// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fNegativeVertexArrayApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. See the note in `buffer.rs` about
// the shape of these files.

use crate::glu::api_case::BAD_ENUM;
use crate::glu::{ApiCase, ApiCaseFn, ProgramSources, ShaderProgram, TestCaseGroup, add_api_cases};
use crate::glw;

const VERTEX_SHADER_SOURCE: &str = "void main (void) { gl_Position = vec4(0.0); }\n";
const FRAGMENT_SHADER_SOURCE: &str = "void main (void) { gl_FragColor = vec4(0.0); }\n";

fn vertex_attrib(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as u32;
    // SAFETY: a current context; the index is out of range on purpose.
    unsafe { gl.vertex_attrib_1f(max_vertex_attribs, 0.0) };
    case.expect_error(glw::GL_INVALID_VALUE);
    unsafe { gl.vertex_attrib_2f(max_vertex_attribs, 0.0, 0.0) };
    case.expect_error(glw::GL_INVALID_VALUE);
    unsafe { gl.vertex_attrib_3f(max_vertex_attribs, 0.0, 0.0, 0.0) };
    case.expect_error(glw::GL_INVALID_VALUE);
    unsafe { gl.vertex_attrib_4f(max_vertex_attribs, 0.0, 0.0, 0.0, 0.0) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn vertex_attribv(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as u32;
    let v = [0.0f32; 4];
    // SAFETY: the array is four floats, which is as many as the widest of these reads.
    unsafe { gl.vertex_attrib_1fv(max_vertex_attribs, v.as_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);
    unsafe { gl.vertex_attrib_2fv(max_vertex_attribs, v.as_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);
    unsafe { gl.vertex_attrib_3fv(max_vertex_attribs, v.as_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);
    unsafe { gl.vertex_attrib_4fv(max_vertex_attribs, v.as_ptr()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn vertex_attrib_pointer(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_ENUM is generated if type is not an accepted value.");
    // SAFETY: as above; a rejected call reads nothing through the null pointer.
    unsafe { gl.vertex_attrib_pointer(0, 1, 0, glw::TRUE, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as u32;
    unsafe { gl.vertex_attrib_pointer(max_vertex_attribs, 1, glw::GL_BYTE, glw::TRUE, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if size is not 1, 2, 3, or 4.");
    unsafe { gl.vertex_attrib_pointer(0, 0, glw::GL_BYTE, glw::TRUE, 0, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_VALUE is generated if stride is negative.");
    unsafe { gl.vertex_attrib_pointer(0, 1, glw::GL_BYTE, glw::TRUE, -1, std::ptr::null()) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn enable_vertex_attrib_array(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as u32;
    // SAFETY: as above.
    unsafe { gl.enable_vertex_attrib_array(max_vertex_attribs) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

fn disable_vertex_attrib_array(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    case.section("GL_INVALID_VALUE is generated if index is greater than or equal to GL_MAX_VERTEX_ATTRIBS.");
    let max_vertex_attribs = case.get_int(glw::GL_MAX_VERTEX_ATTRIBS) as u32;
    // SAFETY: as above.
    unsafe { gl.disable_vertex_attrib_array(max_vertex_attribs) };
    case.expect_error(glw::GL_INVALID_VALUE);
}

/// The three `draw_arrays*` cases differ only in what program is bound and which
/// primitive mode they use, which is exactly how upstream writes them - three separate
/// cases with the same body.
fn draw_arrays_body(case: &mut ApiCase<'_>, mode: glw::GLenum) {
    let gl = case.gl();

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: as above.
    unsafe { gl.draw_arrays(BAD_ENUM, 0, 1) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    unsafe { gl.draw_arrays(mode, 0, -1) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    let mut fbo = 0;
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
        gl.draw_arrays(mode, 0, 1);
    }
    case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_framebuffers(1, &fbo);
    }
}

fn draw_arrays(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: the program handle is this case's own.
    unsafe { gl.use_program(program.program()) };
    draw_arrays_body(case, glw::GL_POINTS);
    unsafe { gl.use_program(0) };
}

fn draw_arrays_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: unbinding the program is always valid.
    unsafe { gl.use_program(0) };
    draw_arrays_body(case, glw::GL_POINTS);
}

fn draw_arrays_incomplete_primitive(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: as in `draw_arrays`.
    unsafe { gl.use_program(program.program()) };
    draw_arrays_body(case, glw::GL_TRIANGLES);
    unsafe { gl.use_program(0) };
}

fn draw_elements_body(case: &mut ApiCase<'_>, mode: glw::GLenum) {
    let gl = case.gl();
    let vertices = [0.0f32; 1];
    let indices = vertices.as_ptr().cast();

    case.section("GL_INVALID_ENUM is generated if mode is not an accepted value.");
    // SAFETY: the index pointer is four bytes of client memory, which is more than the
    // single GL_UNSIGNED_BYTE index the accepted call below reads.
    unsafe { gl.draw_elements(BAD_ENUM, 1, glw::GL_UNSIGNED_BYTE, indices) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_ENUM is generated if type is not GL_UNSIGNED_BYTE or GL_UNSIGNED_SHORT.");
    unsafe { gl.draw_elements(mode, 1, BAD_ENUM, indices) };
    case.expect_error(glw::GL_INVALID_ENUM);

    case.section("GL_INVALID_VALUE is generated if count is negative.");
    unsafe { gl.draw_elements(mode, -1, glw::GL_UNSIGNED_BYTE, indices) };
    case.expect_error(glw::GL_INVALID_VALUE);

    case.section("GL_INVALID_FRAMEBUFFER_OPERATION is generated if the currently bound framebuffer is not framebuffer complete.");
    let mut fbo = 0;
    unsafe {
        gl.gen_framebuffers(1, &mut fbo);
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
        gl.draw_elements(mode, 1, glw::GL_UNSIGNED_BYTE, indices);
    }
    case.expect_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
    unsafe {
        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        gl.delete_framebuffers(1, &fbo);
    }
}

fn draw_elements(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: as in `draw_arrays`.
    unsafe { gl.use_program(program.program()) };
    draw_elements_body(case, glw::GL_POINTS);
    unsafe { gl.use_program(0) };
}

fn draw_elements_invalid_program(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    // SAFETY: as above.
    unsafe { gl.use_program(0) };
    draw_elements_body(case, glw::GL_POINTS);
}

fn draw_elements_incomplete_primitive(case: &mut ApiCase<'_>) {
    let gl = case.gl();
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SHADER_SOURCE, FRAGMENT_SHADER_SOURCE));
    // SAFETY: as above.
    unsafe { gl.use_program(program.program()) };
    draw_elements_body(case, glw::GL_TRIANGLES);
    unsafe { gl.use_program(0) };
}

/// `NegativeVertexArrayApiTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex_array");
    let cases: &[(&'static str, ApiCaseFn)] = &[
        ("vertex_attrib", vertex_attrib),
        ("vertex_attribv", vertex_attribv),
        ("vertex_attrib_pointer", vertex_attrib_pointer),
        ("enable_vertex_attrib_array", enable_vertex_attrib_array),
        ("disable_vertex_attrib_array", disable_vertex_attrib_array),
        ("draw_arrays", draw_arrays),
        ("draw_arrays_invalid_program", draw_arrays_invalid_program),
        ("draw_arrays_incomplete_primitive", draw_arrays_incomplete_primitive),
        ("draw_elements", draw_elements),
        ("draw_elements_invalid_program", draw_elements_invalid_program),
        ("draw_elements_incomplete_primitive", draw_elements_incomplete_primitive),
    ];
    add_api_cases(&mut group, cases);
    group
}
