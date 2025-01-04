// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cProgramInterfaceQueryTests.cpp
//   external/openglcts/modules/gl/gl4cProgramInterfaceQueryTests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case classes are `Subcase`s (see `subcase.rs`); `PIQBase`'s Verify* helpers are free functions accumulating into a `&mut i64` error exactly as upstream's `long &error` does. Only part of the group is ported so far (see `create_tests`).

use std::collections::BTreeMap;
use std::ffi::CString;

use super::subcase::{ERROR, NO_ERROR, Subcase, SubcaseResult, TestSubcase};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call below is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const INTERFACES: [GLenum; 19] = [
    glw::GL_PROGRAM_INPUT,
    glw::GL_PROGRAM_OUTPUT,
    glw::GL_UNIFORM,
    glw::GL_UNIFORM_BLOCK,
    glw::GL_BUFFER_VARIABLE,
    glw::GL_SHADER_STORAGE_BLOCK,
    glw::GL_VERTEX_SUBROUTINE,
    glw::GL_TESS_CONTROL_SUBROUTINE,
    glw::GL_TESS_EVALUATION_SUBROUTINE,
    glw::GL_GEOMETRY_SUBROUTINE,
    glw::GL_FRAGMENT_SUBROUTINE,
    glw::GL_COMPUTE_SUBROUTINE,
    glw::GL_VERTEX_SUBROUTINE_UNIFORM,
    glw::GL_TESS_CONTROL_SUBROUTINE_UNIFORM,
    glw::GL_TESS_EVALUATION_SUBROUTINE_UNIFORM,
    glw::GL_GEOMETRY_SUBROUTINE_UNIFORM,
    glw::GL_FRAGMENT_SUBROUTINE_UNIFORM,
    glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
    glw::GL_TRANSFORM_FEEDBACK_VARYING,
];

/// The eleven properties every input and uniform-like resource is checked for.
const PROPS_11: [GLenum; 11] = [
    glw::GL_NAME_LENGTH,
    glw::GL_TYPE,
    glw::GL_ARRAY_SIZE,
    glw::GL_REFERENCED_BY_COMPUTE_SHADER,
    glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
    glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
    glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
    glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
    glw::GL_REFERENCED_BY_VERTEX_SHADER,
    glw::GL_LOCATION,
    glw::GL_IS_PER_PATCH,
];

/// `PROPS_11` plus `GL_LOCATION_INDEX`, used for fragment outputs.
const PROPS_12: [GLenum; 12] = [
    glw::GL_NAME_LENGTH,
    glw::GL_TYPE,
    glw::GL_ARRAY_SIZE,
    glw::GL_REFERENCED_BY_COMPUTE_SHADER,
    glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
    glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
    glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
    glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
    glw::GL_REFERENCED_BY_VERTEX_SHADER,
    glw::GL_LOCATION,
    glw::GL_IS_PER_PATCH,
    glw::GL_LOCATION_INDEX,
];

fn c_string(text: &str) -> CString {
    CString::new(text).expect("no nul byte")
}

/// `PIQBase::LinkProgram`
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

/// `PIQBase::CreateProgram(vs, fs, link)`
fn create_program(gl: &glw::Functions, vs: Option<&str>, fs: Option<&str>, link: bool) -> GLuint {
    let program = gl!(gl.create_program());
    for (shader_type, source) in [(glw::GL_VERTEX_SHADER, vs), (glw::GL_FRAGMENT_SHADER, fs)] {
        if let Some(source) = source {
            let source = c_string(source);
            let pointer = source.as_ptr();
            let shader = gl!(gl.create_shader(shader_type));
            gl!(gl.attach_shader(program, shader));
            gl!(gl.delete_shader(shader));
            gl!(gl.shader_source(shader, 1, &pointer, std::ptr::null()));
            gl!(gl.compile_shader(shader));
        }
    }
    if link {
        link_program(gl, program);
    }
    program
}

/// `PIQBase::VerifyGetProgramInterfaceiv`
fn verify_get_program_interfaceiv(
    gl: &glw::Functions,
    program: GLuint,
    program_interface: GLenum,
    pname: GLenum,
    expected: GLint,
    error: &mut i64,
) {
    let mut res: GLint = 0;
    gl!(gl.get_program_interfaceiv(program, program_interface, pname, &mut res));
    if res != expected {
        log::info!("ERROR: Got {res}, expected {expected}");
        *error = ERROR;
    }
}

/// `PIQBase::VerifyGetProgramResourceIndex` with an expected value
fn verify_get_program_resource_index(
    gl: &glw::Functions,
    program: GLuint,
    program_interface: GLenum,
    name: &str,
    expected: GLuint,
    error: &mut i64,
) {
    let name = c_string(name);
    let res = gl!(gl.get_program_resource_index(program, program_interface, name.as_ptr()));
    if res != expected {
        log::info!("ERROR: Got {res}, expected {expected}");
        *error = ERROR;
    }
}

/// `PIQBase::VerifyGetProgramResourceIndex` recording the index under `name` and rejecting duplicates
fn verify_get_program_resource_index_unique(
    gl: &glw::Functions,
    program: GLuint,
    program_interface: GLenum,
    indices: &mut BTreeMap<String, GLuint>,
    name: &str,
    error: &mut i64,
) {
    let c_name = c_string(name);
    let res = gl!(gl.get_program_resource_index(program, program_interface, c_name.as_ptr()));
    if res == glw::GL_INVALID_INDEX {
        log::info!("ERROR: Got {res}, expected number other than -1");
        *error = ERROR;
        return;
    }
    if indices.values().any(|&value| value == res) {
        log::info!("ERROR: Duplicated value found: {res}");
        *error = ERROR;
        return;
    }
    indices.insert(name.to_string(), res);
}

/// `PIQBase::VerifyGetProgramResourceName`
fn verify_get_program_resource_name(
    gl: &glw::Functions,
    program: GLuint,
    program_interface: GLenum,
    index: GLuint,
    expected: &str,
    error: &mut i64,
) {
    let mut name = [0u8; 1024];
    let mut len: i32 = 0;
    gl!(gl.get_program_resource_name(
        program,
        program_interface,
        index,
        1024,
        &mut len,
        name.as_mut_ptr().cast()
    ));
    if len <= 0 || len > 1023 || name[(len - 1) as usize] == 0 {
        log::info!("ERROR: Length in glGetProgramResourceName should not count null terminator!");
        *error = ERROR;
    } else {
        let end = name.iter().position(|&byte| byte == 0).unwrap_or(name.len());
        if &name[..end] != expected.as_bytes() || name[len as usize] != 0 {
            log::info!(
                "ERROR: Got {}, expected {expected}",
                String::from_utf8_lossy(&name[..end])
            );
            *error = ERROR;
        }
    }
}

/// `PIQBase::VerifyGetProgramResourceLocation` with an expected value
fn verify_get_program_resource_location(
    gl: &glw::Functions,
    program: GLuint,
    program_interface: GLenum,
    name: &str,
    expected: GLint,
    error: &mut i64,
) {
    let name = c_string(name);
    let res = gl!(gl.get_program_resource_location(program, program_interface, name.as_ptr()));
    if res != expected {
        log::info!("ERROR: Got {res}, expected {expected}");
        *error = ERROR;
    }
}

/// `PIQBase::VerifyGetProgramResourceLocationIndex`
fn verify_get_program_resource_location_index(
    gl: &glw::Functions,
    program: GLuint,
    program_interface: GLenum,
    name: &str,
    expected: GLint,
    error: &mut i64,
) {
    let c_name = c_string(name);
    let res = gl!(gl.get_program_resource_location_index(program, program_interface, c_name.as_ptr()));
    if res != expected {
        log::info!(
            "ERROR: Got {res}, expected {expected}\nCALL: glGetProgramResourceLocationIndex, with {program_interface}, {name}"
        );
        *error = ERROR;
    }
}

/// `PIQBase::VerifyGetProgramResourceiv`
fn verify_get_program_resourceiv(
    gl: &glw::Functions,
    program: GLuint,
    program_interface: GLenum,
    index: GLuint,
    props: &[GLenum],
    expected_length: i32,
    expected: &[GLint],
    error: &mut i64,
) {
    const BUF_SIZE: usize = 1000;
    let mut length: i32 = 0;
    let mut params = [0 as GLint; BUF_SIZE];
    gl!(gl.get_program_resourceiv(
        program,
        program_interface,
        index,
        props.len() as i32,
        props.as_ptr(),
        BUF_SIZE as i32,
        &mut length,
        params.as_mut_ptr()
    ));
    if length != expected_length || length <= 0 {
        *error = ERROR;
        log::info!(
            "ERROR: Got length {length}, expected {expected_length}\nCALL: glGetProgramResourceiv, with {program_interface}, {index}"
        );
        return;
    }
    for i in 0..length as usize {
        if params[i] != expected[i] {
            *error = ERROR;
            log::info!(
                "ERROR: Got {}, expected {} at: {i}\nCALL: glGetProgramResourceiv, with {program_interface}, {index}",
                params[i],
                expected[i]
            );
        }
    }
}

const SIMPLE_VERTEX_SHADER: &str =
    "#version 430\nin vec4 position;\nvoid main(void)\n{\n    gl_Position = position;\n}";
const SIMPLE_FRAGMENT_SHADER: &str = "#version 430\nout vec4 color;\nvoid main() {\n    color = vec4(0, 1, 0, 1);\n}";

fn cleanup_use_program(context: &Context) -> SubcaseResult {
    gl!(context.gl().use_program(0));
    Ok(NO_ERROR)
}

/// `NoShaders`
struct NoShaders;

impl Subcase for NoShaders {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let program = gl!(gl.create_program());
        let mut error = NO_ERROR;

        for interface in INTERFACES {
            verify_get_program_interfaceiv(gl, program, interface, glw::GL_ACTIVE_RESOURCES, 0, &mut error);
            if interface == glw::GL_ATOMIC_COUNTER_BUFFER {
                continue;
            }
            verify_get_program_interfaceiv(gl, program, interface, glw::GL_MAX_NAME_LENGTH, 0, &mut error);
        }

        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            glw::GL_MAX_NUM_ACTIVE_VARIABLES,
            0,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_MAX_NUM_ACTIVE_VARIABLES,
            0,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_UNIFORM_BLOCK,
            glw::GL_MAX_NUM_ACTIVE_VARIABLES,
            0,
            &mut error,
        );

        for interface in [
            glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
            glw::GL_FRAGMENT_SUBROUTINE_UNIFORM,
            glw::GL_GEOMETRY_SUBROUTINE_UNIFORM,
            glw::GL_TESS_EVALUATION_SUBROUTINE_UNIFORM,
            glw::GL_TESS_CONTROL_SUBROUTINE_UNIFORM,
            glw::GL_VERTEX_SUBROUTINE_UNIFORM,
        ] {
            verify_get_program_interfaceiv(
                gl,
                program,
                interface,
                glw::GL_MAX_NUM_COMPATIBLE_SUBROUTINES,
                0,
                &mut error,
            );
        }

        for interface in INTERFACES {
            if interface == glw::GL_ATOMIC_COUNTER_BUFFER {
                continue;
            }
            verify_get_program_resource_index(gl, program, interface, "", glw::GL_INVALID_INDEX, &mut error);
        }

        // can't test GetProgramResourceLocation* here since program has to be linked
        // can't test GetProgramResourceiv, need valid index
        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `SimpleShaders`
struct SimpleShaders;

impl Subcase for SimpleShaders {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_MAX_NAME_LENGTH,
            9,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_MAX_NAME_LENGTH,
            6,
            &mut error,
        );

        verify_get_program_resource_index(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 0, &mut error);
        verify_get_program_resource_index(gl, program, glw::GL_PROGRAM_INPUT, "position", 0, &mut error);

        verify_get_program_resource_name(gl, program, glw::GL_PROGRAM_OUTPUT, 0, "color", &mut error);
        verify_get_program_resource_name(gl, program, glw::GL_PROGRAM_INPUT, 0, "position", &mut error);

        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_INPUT, "position", 0, &mut error);
        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 0, &mut error);
        verify_get_program_resource_location_index(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 0, &mut error);

        let expected = [9, glw::GL_FLOAT_VEC4 as GLint, 1, 0, 0, 0, 0, 0, 1, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            0,
            &PROPS_11,
            11,
            &expected,
            &mut error,
        );

        let expected2 = [6, glw::GL_FLOAT_VEC4 as GLint, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            0,
            &PROPS_12,
            12,
            &expected2,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `InputTypes` (locations bound through the API) and `InputLayout` (locations set through layout qualifiers)
struct InputTypes {
    layout_qualifiers: bool,
}

impl Subcase for InputTypes {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin mat4 a;\nin ivec4 b;\nin float c[2];\nin mat2x3 d[2];\nin uvec2 e;\nin uint f;\nin vec3 g[2];\nin int h;\nvoid main(void)\n{\n   vec4 pos;\n   pos.w = h + g[0].x + g[1].y + d[1][1].y;\n   pos.y = b.x * c[0] + c[1] + d[0][0].x;\n   pos.x = a[0].x + a[1].y + a[2].z + a[3].w;\n   pos.z = d[0][1].z + e.x * f + d[1][0].z;\n   gl_Position = pos;\n}";
        let layout_vertex_shader = "#version 430\nlayout(location = 4) in ivec4 b;\nlayout(location = 7) in mat2x3 d[2];\nlayout(location = 5) in float c[2];\nlayout(location = 12) in uint f;\nlayout(location = 13) in vec3 g[2];\nlayout(location = 0) in mat4 a;\nlayout(location = 15) in int h;\nlayout(location = 11) in uvec2 e;\nvoid main(void)\n{\n   vec4 pos;\n   pos.w = h + g[0].x + g[1].y + d[1][1].y;\n   pos.y = b.x * c[0] + c[1] + d[0][0].x;\n   pos.x = a[0].x + a[1].y + a[2].z + a[3].w;\n   pos.z = d[0][1].z + e.x * f + d[1][0].z;\n   gl_Position = pos;\n}";
        let vertex_shader = if self.layout_qualifiers {
            layout_vertex_shader
        } else {
            vertex_shader
        };
        let program = create_program(gl, Some(vertex_shader), Some(SIMPLE_FRAGMENT_SHADER), false);
        if !self.layout_qualifiers {
            for (location, name) in [
                (0, c"a"),
                (4, c"b"),
                (5, c"c"),
                (7, c"d"),
                (11, c"e"),
                (12, c"f"),
                (13, c"g"),
                (15, c"h"),
            ] {
                gl!(gl.bind_attrib_location(program, location, name.as_ptr()));
            }
        }
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_ACTIVE_RESOURCES,
            8,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_MAX_NAME_LENGTH,
            5,
            &mut error,
        );

        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["a", "b", "c[0]", "d", "e", "f", "g", "h"] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_PROGRAM_INPUT,
                &mut indices,
                name,
                &mut error,
            );
        }
        let index = |name: &str| indices.get(name).copied().unwrap_or(0);

        for (key, expected_name) in [
            ("a", "a"),
            ("b", "b"),
            ("c[0]", "c[0]"),
            ("d", "d[0]"),
            ("e", "e"),
            ("f", "f"),
            ("g", "g[0]"),
            ("h", "h"),
        ] {
            verify_get_program_resource_name(
                gl,
                program,
                glw::GL_PROGRAM_INPUT,
                index(key),
                expected_name,
                &mut error,
            );
        }

        for (name, location) in [
            ("a", 0),
            ("b", 4),
            ("c[0]", 5),
            ("c", 5),
            ("c[1]", 6),
            ("d[0]", 7),
            ("d", 7),
            ("e", 11),
            ("f", 12),
            ("g[0]", 13),
            ("g", 13),
            ("g[1]", 14),
            ("h", 15),
        ] {
            verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_INPUT, name, location, &mut error);
        }

        let expectations: [(&str, [GLint; 11]); 8] = [
            ("a", [2, glw::GL_FLOAT_MAT4 as GLint, 1, 0, 0, 0, 0, 0, 1, 0, 0]),
            ("b", [2, glw::GL_INT_VEC4 as GLint, 1, 0, 0, 0, 0, 0, 1, 4, 0]),
            ("c[0]", [5, glw::GL_FLOAT as GLint, 2, 0, 0, 0, 0, 0, 1, 5, 0]),
            ("d", [5, glw::GL_FLOAT_MAT2x3 as GLint, 2, 0, 0, 0, 0, 0, 1, 7, 0]),
            ("e", [2, glw::GL_UNSIGNED_INT_VEC2 as GLint, 1, 0, 0, 0, 0, 0, 1, 11, 0]),
            ("f", [2, glw::GL_UNSIGNED_INT as GLint, 1, 0, 0, 0, 0, 0, 1, 12, 0]),
            ("g", [5, glw::GL_FLOAT_VEC3 as GLint, 2, 0, 0, 0, 0, 0, 1, 13, 0]),
            ("h", [2, glw::GL_INT as GLint, 1, 0, 0, 0, 0, 0, 1, 15, 0]),
        ];
        for (name, expected) in expectations {
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_PROGRAM_INPUT,
                index(name),
                &PROPS_11,
                11,
                &expected,
                &mut error,
            );
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `OutputTypes` (locations bound through the API) and `OutputLayout` (locations set through layout qualifiers)
struct OutputTypes {
    layout_qualifiers: bool,
}

impl Subcase for OutputTypes {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let fragment_shader = "#version 430\nout vec3 a[2];\nout uint b;\nout float c[2];\nout int d[2];\nout vec2 e;\nvoid main() {\n    c[1] = -0.6;\n    d[0] = 0;\n    b = 12u;\n    c[0] = 1.1;\n    e = vec2(0, 1);\n    d[1] = -19;\n    a[1] = vec3(0, 1, 0);\n    a[0] = vec3(0, 1, 0);\n}";
        let layout_fragment_shader = "#version 430\nlayout(location = 2) out uint b;\nlayout(location = 7) out vec2 e;\nlayout(location = 3) out float c[2];\nlayout(location = 5) out int d[2];\nlayout(location = 0) out vec3 a[2];\nvoid main() {\n    c[1] = -0.6;\n    d[0] = 0;\n    b = 12u;\n    c[0] = 1.1;\n    e = vec2(0, 1);\n    d[1] = -19;\n    a[1] = vec3(0, 1, 0);\n    a[0] = vec3(0, 1, 0);\n}";
        let fragment_shader = if self.layout_qualifiers {
            layout_fragment_shader
        } else {
            fragment_shader
        };
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(fragment_shader), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        if !self.layout_qualifiers {
            for (location, name) in [(0, c"a"), (2, c"b"), (3, c"c"), (5, c"d"), (7, c"e")] {
                gl!(gl.bind_frag_data_location(program, location, name.as_ptr()));
            }
        }
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_ACTIVE_RESOURCES,
            5,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_MAX_NAME_LENGTH,
            5,
            &mut error,
        );

        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["a", "b", "c[0]", "d", "e"] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_PROGRAM_OUTPUT,
                &mut indices,
                name,
                &mut error,
            );
        }
        let index = |name: &str| indices.get(name).copied().unwrap_or(0);

        for (key, expected_name) in [("a", "a[0]"), ("b", "b"), ("c[0]", "c[0]"), ("d", "d[0]"), ("e", "e")] {
            verify_get_program_resource_name(
                gl,
                program,
                glw::GL_PROGRAM_OUTPUT,
                index(key),
                expected_name,
                &mut error,
            );
        }

        for (name, location) in [
            ("a[0]", 0),
            ("a", 0),
            ("a[1]", 1),
            ("b", 2),
            ("c[0]", 3),
            ("c", 3),
            ("c[1]", 4),
            ("d[0]", 5),
            ("d", 5),
            ("d[1]", 6),
            ("e", 7),
        ] {
            verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_OUTPUT, name, location, &mut error);
        }
        for name in ["a[0]", "a", "b", "c[0]", "c", "d[0]", "d", "e"] {
            verify_get_program_resource_location_index(gl, program, glw::GL_PROGRAM_OUTPUT, name, 0, &mut error);
        }

        let expectations: [(&str, [GLint; 12]); 5] = [
            ("a", [5, glw::GL_FLOAT_VEC3 as GLint, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0]),
            ("b", [2, glw::GL_UNSIGNED_INT as GLint, 1, 0, 1, 0, 0, 0, 0, 2, 0, 0]),
            ("c[0]", [5, glw::GL_FLOAT as GLint, 2, 0, 1, 0, 0, 0, 0, 3, 0, 0]),
            ("d", [5, glw::GL_INT as GLint, 2, 0, 1, 0, 0, 0, 0, 5, 0, 0]),
            ("e", [2, glw::GL_FLOAT_VEC2 as GLint, 1, 0, 1, 0, 0, 0, 0, 7, 0, 0]),
        ];
        for (name, expected) in expectations {
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_PROGRAM_OUTPUT,
                index(name),
                &PROPS_12,
                12,
                &expected,
                &mut error,
            );
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `OutputLocationIndex`
struct OutputLocationIndex;

impl Subcase for OutputLocationIndex {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location_indexed(program, 0, 1, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 0, &mut error);
        verify_get_program_resource_location_index(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 1, &mut error);

        let expected = [6, glw::GL_FLOAT_VEC4 as GLint, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            0,
            &PROPS_12,
            12,
            &expected,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `InputBuiltIn`
struct InputBuiltIn;

impl Subcase for InputBuiltIn {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader =
            "#version 430\nvoid main(void)\n{\n    gl_Position = (gl_VertexID + gl_InstanceID) * vec4(0.1);\n}";
        let program = create_program(gl, Some(vertex_shader), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_ACTIVE_RESOURCES,
            2,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_MAX_NAME_LENGTH,
            14,
            &mut error,
        );

        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["gl_VertexID", "gl_InstanceID"] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_PROGRAM_INPUT,
                &mut indices,
                name,
                &mut error,
            );
        }
        let index = |name: &str| indices.get(name).copied().unwrap_or(0);
        for name in ["gl_VertexID", "gl_InstanceID"] {
            verify_get_program_resource_name(gl, program, glw::GL_PROGRAM_INPUT, index(name), name, &mut error);
        }
        for name in ["gl_VertexID", "gl_InstanceID"] {
            verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_INPUT, name, -1, &mut error);
        }

        let int = glw::GL_INT as GLint;
        let expected = [12, int, 1, 0, 0, 0, 0, 0, 1, -1, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index("gl_VertexID"),
            &PROPS_11,
            11,
            &expected,
            &mut error,
        );
        let expected2 = [14, int, 1, 0, 0, 0, 0, 0, 1, -1, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index("gl_InstanceID"),
            &PROPS_11,
            11,
            &expected2,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `OutputBuiltIn`
struct OutputBuiltIn;

impl Subcase for OutputBuiltIn {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let fragment_shader = "#version 430\nvoid main(void)\n{\n    gl_FragDepth = 0.1;\n    gl_SampleMask[0] = 1;\n}";
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(fragment_shader), true);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_ACTIVE_RESOURCES,
            2,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_MAX_NAME_LENGTH,
            17,
            &mut error,
        );

        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["gl_FragDepth", "gl_SampleMask[0]"] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_PROGRAM_OUTPUT,
                &mut indices,
                name,
                &mut error,
            );
        }
        let index = |name: &str| indices.get(name).copied().unwrap_or(0);
        for name in ["gl_FragDepth", "gl_SampleMask[0]"] {
            verify_get_program_resource_name(gl, program, glw::GL_PROGRAM_OUTPUT, index(name), name, &mut error);
        }
        for name in ["gl_FragDepth", "gl_SampleMask", "gl_SampleMask[0]"] {
            verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_OUTPUT, name, -1, &mut error);
        }
        // spec is not clear what to require here
        for name in ["gl_FragDepth", "gl_SampleMask", "gl_SampleMask[0]"] {
            verify_get_program_resource_location_index(gl, program, glw::GL_PROGRAM_OUTPUT, name, -1, &mut error);
        }

        let expected = [13, glw::GL_FLOAT as GLint, 1, 0, 1, 0, 0, 0, 0, -1, 0, -1];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index("gl_FragDepth"),
            &PROPS_12,
            12,
            &expected,
            &mut error,
        );
        let expected2 = [17, glw::GL_INT as GLint, 1, 0, 1, 0, 0, 0, 0, -1, 0, -1];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index("gl_SampleMask[0]"),
            &PROPS_12,
            12,
            &expected2,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `OutputLayoutIndex`
struct OutputLayoutIndex;

impl Subcase for OutputLayoutIndex {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let fragment_shader = "#version 430\nlayout(location = 0, index = 1) out vec4 color;\nvoid main() {\n    color = vec4(0, 1, 0, 1);\n}";
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(fragment_shader), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 0, &mut error);
        verify_get_program_resource_location_index(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 1, &mut error);

        let expected = [6, glw::GL_FLOAT_VEC4 as GLint, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            0,
            &PROPS_12,
            12,
            &expected,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// The properties every `GL_UNIFORM` resource is checked for.
const PROPS_UNIFORM: [GLenum; 16] = [
    glw::GL_NAME_LENGTH,
    glw::GL_TYPE,
    glw::GL_ARRAY_SIZE,
    glw::GL_OFFSET,
    glw::GL_BLOCK_INDEX,
    glw::GL_ARRAY_STRIDE,
    glw::GL_MATRIX_STRIDE,
    glw::GL_IS_ROW_MAJOR,
    glw::GL_ATOMIC_COUNTER_BUFFER_INDEX,
    glw::GL_REFERENCED_BY_COMPUTE_SHADER,
    glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
    glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
    glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
    glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
    glw::GL_REFERENCED_BY_VERTEX_SHADER,
    glw::GL_LOCATION,
];

/// The expected `PROPS_UNIFORM` values of a default-block uniform used by the fragment and/or vertex shader.
fn uniform_expected(
    name_length: GLint,
    ty: GLenum,
    array_size: GLint,
    by_fragment: GLint,
    by_vertex: GLint,
    location: GLint,
) -> [GLint; 16] {
    [
        name_length,
        ty as GLint,
        array_size,
        -1,
        -1,
        -1,
        -1,
        0,
        -1,
        0,
        by_fragment,
        0,
        0,
        0,
        by_vertex,
        location,
    ]
}

fn get_uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = c_string(name);
    gl!(gl.get_uniform_location(program, name.as_ptr()))
}

fn get_program_value(gl: &glw::Functions, program: GLuint, pname: GLenum) -> GLint {
    let mut value = 0;
    gl!(gl.get_programiv(program, pname, &mut value));
    value
}

/// `UniformSimple`
struct UniformSimple;

impl Subcase for UniformSimple {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nuniform vec4 repos;\nvoid main(void)\n{\n    gl_Position = position + repos;\n}";
        let fragment_shader = "#version 430\nuniform vec4 recolor;\nout vec4 color;\nvoid main() {\n    color = vec4(0, 1, 0, 1) + recolor;\n}";
        let program = create_program(gl, Some(vertex_shader), Some(fragment_shader), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            glw::GL_ACTIVE_RESOURCES,
            get_program_value(gl, program, glw::GL_ACTIVE_UNIFORMS),
            &mut error,
        );
        verify_get_program_interfaceiv(gl, program, glw::GL_UNIFORM, glw::GL_MAX_NAME_LENGTH, 8, &mut error);

        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["repos", "recolor"] {
            verify_get_program_resource_index_unique(gl, program, glw::GL_UNIFORM, &mut indices, name, &mut error);
        }
        let index = |name: &str| indices.get(name).copied().unwrap_or(0);
        for name in ["repos", "recolor"] {
            verify_get_program_resource_name(gl, program, glw::GL_UNIFORM, index(name), name, &mut error);
        }
        for name in ["repos", "recolor"] {
            verify_get_program_resource_location(
                gl,
                program,
                glw::GL_UNIFORM,
                name,
                get_uniform_location(gl, program, name),
                &mut error,
            );
        }

        let expected = uniform_expected(
            6,
            glw::GL_FLOAT_VEC4,
            1,
            0,
            1,
            get_uniform_location(gl, program, "repos"),
        );
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            index("repos"),
            &PROPS_UNIFORM,
            16,
            &expected,
            &mut error,
        );
        let expected2 = uniform_expected(
            8,
            glw::GL_FLOAT_VEC4,
            1,
            1,
            0,
            get_uniform_location(gl, program, "recolor"),
        );
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            index("recolor"),
            &PROPS_UNIFORM,
            16,
            &expected2,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `UniformTypes`
struct UniformTypes;

impl Subcase for UniformTypes {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nuniform vec4 a;\nuniform ivec3 b;\nuniform uvec2 c[3];\nuniform mat2 g[8];\nuniform mat3x2 i;\nvoid main(void)\n{\n    float tmp;\n    tmp =  g[0][1][1] + a.z + b.y + c[0].x;\n    tmp += g[1][1][1] + c[1].x;\n    tmp += g[2][1][1] + c[2].x;\n    for (int i = 3; i < 8; ++i)\n        tmp += g[i][1][1];\n    tmp = tmp + i[1][1];\n    gl_Position = position * tmp;\n}";
        let fragment_shader = "#version 430\nstruct U {\n   bool a[3];\n   vec4 b;\n   mat3 c;\n   float d[2];\n};\nstruct UU {\n   U a;\n   U b[2];\n   uvec2 c;\n};\nuniform mat4 d;\nuniform mat3 e;\nuniform float h;\nuniform int f;\nuniform U j;\nuniform UU k;\nuniform UU l[3];\nout vec4 color;\nvoid main() {\n    float tmp;\n    tmp = h + f + e[2][2];\n    tmp = tmp + d[0][0] + j.b.x;\n    tmp = tmp + k.b[0].c[0][0];\n    tmp = tmp + l[2].a.c[0][1];\n    tmp = tmp + l[2].b[1].d[0];\n    tmp = tmp + l[2].b[1].d[1];\n    tmp = tmp + l[0].c.x;\n    color = vec4(0, 1, 0, 1) * tmp;\n}";
        let program = create_program(gl, Some(vertex_shader), Some(fragment_shader), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        // only active structure members
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            glw::GL_ACTIVE_RESOURCES,
            get_program_value(gl, program, glw::GL_ACTIVE_UNIFORMS),
            &mut error,
        );
        // l[2].b[1].d[0] and \0
        verify_get_program_interfaceiv(gl, program, glw::GL_UNIFORM, glw::GL_MAX_NAME_LENGTH, 15, &mut error);

        // (name queried by index and location, name reported for the index, expected name length, type, array size, used by fragment, used by vertex)
        let uniforms: [(&str, &str, GLint, GLenum, GLint, GLint, GLint); 14] = [
            ("a", "a", 2, glw::GL_FLOAT_VEC4, 1, 0, 1),
            ("b", "b", 2, glw::GL_INT_VEC3, 1, 0, 1),
            ("c", "c[0]", 5, glw::GL_UNSIGNED_INT_VEC2, 3, 0, 1),
            ("d", "d", 2, glw::GL_FLOAT_MAT4, 1, 1, 0),
            ("e", "e", 2, glw::GL_FLOAT_MAT3, 1, 1, 0),
            ("f", "f", 2, glw::GL_INT, 1, 1, 0),
            ("g", "g[0]", 5, glw::GL_FLOAT_MAT2, 8, 0, 1),
            ("h", "h", 2, glw::GL_FLOAT, 1, 1, 0),
            ("i", "i", 2, glw::GL_FLOAT_MAT3x2, 1, 0, 1),
            ("j.b", "j.b", 4, glw::GL_FLOAT_VEC4, 1, 1, 0),
            ("k.b[0].c", "k.b[0].c", 9, glw::GL_FLOAT_MAT3, 1, 1, 0),
            ("l[0].c", "l[0].c", 7, glw::GL_UNSIGNED_INT_VEC2, 1, 1, 0),
            ("l[2].b[1].d[0]", "l[2].b[1].d[0]", 15, glw::GL_FLOAT, 2, 1, 0),
            ("l[2].a.c", "l[2].a.c", 9, glw::GL_FLOAT_MAT3, 1, 1, 0),
        ];

        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        for (key, ..) in uniforms {
            verify_get_program_resource_index_unique(gl, program, glw::GL_UNIFORM, &mut indices, key, &mut error);
        }
        let index = |name: &str| indices.get(name).copied().unwrap_or(0);
        for (key, reported_name, ..) in uniforms {
            verify_get_program_resource_name(gl, program, glw::GL_UNIFORM, index(key), reported_name, &mut error);
        }
        for (key, ..) in uniforms {
            verify_get_program_resource_location(
                gl,
                program,
                glw::GL_UNIFORM,
                key,
                get_uniform_location(gl, program, key),
                &mut error,
            );
        }
        for (key, _, name_length, ty, array_size, by_fragment, by_vertex) in uniforms {
            let expected = uniform_expected(
                name_length,
                ty,
                array_size,
                by_fragment,
                by_vertex,
                get_uniform_location(gl, program, key),
            );
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_UNIFORM,
                index(key),
                &PROPS_UNIFORM,
                16,
                &expected,
                &mut error,
            );
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `UniformBlockTypes`
struct UniformBlockTypes;

impl UniformBlockTypes {
    /// The `GL_ACTIVE_VARIABLES` check of one block: every index must be one of `expected` and there must be exactly three.
    fn check_active_variables(
        gl: &glw::Functions,
        program: GLuint,
        block_index: GLuint,
        expected: &[GLuint; 3],
        block_name: &str,
    ) -> bool {
        let prop = glw::GL_ACTIVE_VARIABLES;
        const BUF_SIZE: usize = 1000;
        let mut length: i32 = 0;
        let mut param = [0 as GLint; BUF_SIZE];
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_UNIFORM_BLOCK,
            block_index,
            1,
            &prop,
            BUF_SIZE as i32,
            &mut length,
            param.as_mut_ptr()
        ));
        for &value in &param[..length as usize] {
            if !expected.contains(&(value as GLuint)) {
                log::info!(
                    "Unexpected index found in active variables of {block_name}: {value}\nCall: glGetProgramResourceiv, property: GL_ACTIVE_VARIABLES interface: GL_UNIFORM_BLOCK"
                );
                return false;
            } else if length != 3 {
                log::info!(
                    "Call: glGetProgramResourceiv, property: GL_ACTIVE_VARIABLES interface: GL_UNIFORM_BLOCK\nExpected length: 3, actual length: {length}"
                );
                return false;
            }
        }
        true
    }
}

impl Subcase for UniformBlockTypes {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nuniform SimpleBlock {\n   mat3x2 a;\n   mat4 b;\n   vec4 c;\n};\nuniform NotSoSimpleBlockk {\n   ivec2 a[4];\n   mat3 b[2];\n   mat2 c;\n} d;\nvoid main(void)\n{\n    float tmp;\n    tmp =  a[0][1] * b[1][2] * c.x;\n    tmp = tmp + d.a[2].y + d.b[0][1][1] + d.c[1][1];\n    gl_Position = position * tmp;\n}";
        let fragment_shader = "#version 430\nstruct U {\n   bool a[3];\n   vec4 b;\n   mat3 c;\n   float d[2];\n};\nstruct UU {\n   U a;\n   U b[2];\n   uvec2 c;\n};\nuniform TrickyBlock {\n   UU a[3];\n   mat4 b;\n   uint c;\n} e[2];\nout vec4 color;\nvoid main() {\n    float tmp;\n    tmp = e[0].a[2].b[0].d[1];\n    color = vec4(0, 1, 0, 1) * tmp;\n}";
        let program = create_program(gl, Some(vertex_shader), Some(fragment_shader), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            glw::GL_ACTIVE_RESOURCES,
            get_program_value(gl, program, glw::GL_ACTIVE_UNIFORMS),
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_UNIFORM_BLOCK,
            glw::GL_ACTIVE_RESOURCES,
            4,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_UNIFORM_BLOCK,
            glw::GL_MAX_NAME_LENGTH,
            18,
            &mut error,
        );

        let mut indices_ub: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_u: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["SimpleBlock", "NotSoSimpleBlockk", "TrickyBlock", "TrickyBlock[1]"] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_UNIFORM_BLOCK,
                &mut indices_ub,
                name,
                &mut error,
            );
        }
        for name in [
            "a",
            "b",
            "c",
            "NotSoSimpleBlockk.a[0]",
            "NotSoSimpleBlockk.c",
            "NotSoSimpleBlockk.b[0]",
            "TrickyBlock.a[2].b[0].d",
        ] {
            verify_get_program_resource_index_unique(gl, program, glw::GL_UNIFORM, &mut indices_u, name, &mut error);
        }
        let ub = |name: &str| indices_ub.get(name).copied().unwrap_or(0);
        let u = |name: &str| indices_u.get(name).copied().unwrap_or(0);

        gl!(gl.uniform_block_binding(program, ub("SimpleBlock"), 0));
        gl!(gl.uniform_block_binding(program, ub("NotSoSimpleBlockk"), 2));
        gl!(gl.uniform_block_binding(program, ub("TrickyBlock"), 3));
        gl!(gl.uniform_block_binding(program, ub("TrickyBlock[1]"), 4));

        for (key, expected_name) in [
            ("SimpleBlock", "SimpleBlock"),
            ("NotSoSimpleBlockk", "NotSoSimpleBlockk"),
            ("TrickyBlock", "TrickyBlock[0]"),
            ("TrickyBlock[1]", "TrickyBlock[1]"),
        ] {
            verify_get_program_resource_name(gl, program, glw::GL_UNIFORM_BLOCK, ub(key), expected_name, &mut error);
        }
        for (key, expected_name) in [
            ("a", "a"),
            ("b", "b"),
            ("c", "c"),
            ("NotSoSimpleBlockk.a[0]", "NotSoSimpleBlockk.a[0]"),
            ("NotSoSimpleBlockk.c", "NotSoSimpleBlockk.c"),
            ("NotSoSimpleBlockk.b[0]", "NotSoSimpleBlockk.b[0]"),
            ("TrickyBlock.a[2].b[0].d", "TrickyBlock.a[2].b[0].d[0]"),
        ] {
            verify_get_program_resource_name(gl, program, glw::GL_UNIFORM, u(key), expected_name, &mut error);
        }
        for name in ["a", "b", "c"] {
            verify_get_program_resource_location(gl, program, glw::GL_UNIFORM, name, -1, &mut error);
        }

        let props: [GLenum; 9] = [
            glw::GL_NAME_LENGTH,
            glw::GL_BUFFER_BINDING,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
            glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
            glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_BUFFER_DATA_SIZE,
        ];
        let block_data_size = |block: GLuint| {
            let mut size: GLint = 0;
            gl!(gl.get_active_uniform_blockiv(program, block, glw::GL_UNIFORM_BLOCK_DATA_SIZE, &mut size));
            size
        };
        let block_expectations: [(&str, [GLint; 8]); 4] = [
            ("SimpleBlock", [12, 0, 0, 0, 0, 0, 0, 1]),
            ("NotSoSimpleBlockk", [18, 2, 0, 0, 0, 0, 0, 1]),
            ("TrickyBlock", [15, 3, 0, 1, 0, 0, 0, 0]),
            ("TrickyBlock[1]", [15, 4, 0, 0, 0, 0, 0, 0]),
        ];
        for (name, values) in block_expectations {
            // the size is queried for the block named in the table, as upstream does (including for TrickyBlock[1], which uses TrickyBlock's size)
            let size_block = if name == "TrickyBlock[1]" {
                ub("TrickyBlock")
            } else {
                ub(name)
            };
            let mut expected = [0 as GLint; 9];
            expected[..8].copy_from_slice(&values);
            expected[8] = block_data_size(size_block);
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_UNIFORM_BLOCK,
                ub(name),
                &props,
                9,
                &expected,
                &mut error,
            );
        }

        let props2: [GLenum; 14] = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_BLOCK_INDEX,
            glw::GL_ARRAY_STRIDE,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_ATOMIC_COUNTER_BUFFER_INDEX,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
            glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
            glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_LOCATION,
        ];
        let expected5 = [
            2,
            glw::GL_FLOAT_MAT3x2 as GLint,
            1,
            ub("SimpleBlock") as GLint,
            0,
            0,
            -1,
            0,
            0,
            0,
            0,
            0,
            1,
            -1,
        ];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            u("a"),
            &props2,
            14,
            &expected5,
            &mut error,
        );
        let props3: [GLenum; 14] = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_BLOCK_INDEX,
            glw::GL_MATRIX_STRIDE,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_ATOMIC_COUNTER_BUFFER_INDEX,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
            glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
            glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_LOCATION,
        ];
        let expected6 = [
            27,
            glw::GL_FLOAT as GLint,
            2,
            ub("TrickyBlock") as GLint,
            0,
            0,
            -1,
            0,
            1,
            0,
            0,
            0,
            0,
            -1,
        ];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            u("TrickyBlock.a[2].b[0].d"),
            &props3,
            14,
            &expected6,
            &mut error,
        );

        if !Self::check_active_variables(gl, program, ub("SimpleBlock"), &[u("a"), u("b"), u("c")], "SimpleBlock") {
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        }
        if !Self::check_active_variables(
            gl,
            program,
            ub("NotSoSimpleBlockk"),
            &[
                u("NotSoSimpleBlockk.a[0]"),
                u("NotSoSimpleBlockk.b[0]"),
                u("NotSoSimpleBlockk.c"),
            ],
            "NotSoSimpleBlockk",
        ) {
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        }

        let mut res: GLint = 0;
        gl!(gl.get_program_interfaceiv(
            program,
            glw::GL_UNIFORM_BLOCK,
            glw::GL_MAX_NUM_ACTIVE_VARIABLES,
            &mut res
        ));
        if res < 3 {
            log::info!("Value of GL_MAX_NUM_ACTIVE_VARIABLES less than 3!");
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `TransformFeedbackTypes`
struct TransformFeedbackTypes;

impl Subcase for TransformFeedbackTypes {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nflat out ivec4 a;\nout float b[2];\nflat out uvec2 c;\nflat out uint d;\nout vec3 e[2];\nflat out int f;\nvoid main(void)\n{\n   vec4 pos;\n   a = ivec4(1);\n   b[0] = 1.1;\n   b[1] = 1.1;\n   c = uvec2(1u);\n   d = 1u;\n   e[0] = vec3(1.1);\n   e[1] = vec3(1.1);\n   f = 1;\n   gl_Position = position;\n}";
        let program = create_program(gl, Some(vertex_shader), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        let varyings = [
            c"a".as_ptr(),
            c"b[0]".as_ptr(),
            c"b[1]".as_ptr(),
            c"c".as_ptr(),
            c"d".as_ptr(),
            c"e".as_ptr(),
        ];
        gl!(gl.transform_feedback_varyings(program, 6, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_TRANSFORM_FEEDBACK_VARYING,
            glw::GL_ACTIVE_RESOURCES,
            6,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_TRANSFORM_FEEDBACK_VARYING,
            glw::GL_MAX_NAME_LENGTH,
            5,
            &mut error,
        );

        let names = ["a", "b[0]", "b[1]", "c", "d", "e"];
        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in names {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_TRANSFORM_FEEDBACK_VARYING,
                &mut indices,
                name,
                &mut error,
            );
        }
        let index = |name: &str| indices.get(name).copied().unwrap_or(0);
        for name in names {
            verify_get_program_resource_name(
                gl,
                program,
                glw::GL_TRANSFORM_FEEDBACK_VARYING,
                index(name),
                name,
                &mut error,
            );
        }

        let props = [glw::GL_NAME_LENGTH, glw::GL_TYPE, glw::GL_ARRAY_SIZE];
        let expectations: [(&str, [GLint; 3]); 6] = [
            ("a", [2, glw::GL_INT_VEC4 as GLint, 1]),
            ("b[0]", [5, glw::GL_FLOAT as GLint, 1]),
            ("b[1]", [5, glw::GL_FLOAT as GLint, 1]),
            ("c", [2, glw::GL_UNSIGNED_INT_VEC2 as GLint, 1]),
            ("d", [2, glw::GL_UNSIGNED_INT as GLint, 1]),
            ("e", [2, glw::GL_FLOAT_VEC3 as GLint, 2]),
        ];
        for (name, expected) in expectations {
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_TRANSFORM_FEEDBACK_VARYING,
                index(name),
                &props,
                3,
                &expected,
                &mut error,
            );
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `AtomicCounterSimple`
struct AtomicCounterSimple;

impl AtomicCounterSimple {
    /// The atomic counter buffer index of the uniform `uniform_index`.
    fn buffer_index_of(gl: &glw::Functions, program: GLuint, uniform_index: GLuint) -> GLint {
        let prop = glw::GL_ATOMIC_COUNTER_BUFFER_INDEX;
        let mut length: i32 = 0;
        let mut res: GLint = 0;
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_UNIFORM,
            uniform_index,
            1,
            &prop,
            1000,
            &mut length,
            &mut res
        ));
        res
    }

    /// `GL_ACTIVE_VARIABLES` of the buffer the uniform lives in must be exactly `expected`.
    fn check_active_variables(
        gl: &glw::Functions,
        program: GLuint,
        uniform_index: GLuint,
        expected: &[GLuint; 2],
    ) -> bool {
        let buffer_index = Self::buffer_index_of(gl, program, uniform_index) as GLuint;
        let prop = glw::GL_ACTIVE_VARIABLES;
        let mut length: i32 = 0;
        let mut param = [0 as GLint; 1000];
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            buffer_index,
            1,
            &prop,
            1000,
            &mut length,
            param.as_mut_ptr()
        ));
        for &value in &param[..length as usize] {
            if !expected.contains(&(value as GLuint)) || length != 2 {
                log::info!(
                    "Length: {length}\nUnexpected index/length found in active variables of ATOMIC_COUNTER_BUFFER: {value}"
                );
                return false;
            }
        }
        true
    }
}

impl Subcase for AtomicCounterSimple {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let fragment_shader = "#version 430\nout vec4 color;\nlayout (binding = 1, offset = 0) uniform atomic_uint a;\nlayout (binding = 2, offset = 0) uniform atomic_uint b;\nlayout (binding = 2, offset = 4) uniform atomic_uint c;\nlayout (binding = 5, offset = 0) uniform atomic_uint d[3];\nlayout (binding = 5, offset = 12) uniform atomic_uint e;\nvoid main() {\n   uint x = atomicCounterIncrement(d[0]) + atomicCounterIncrement(a);\n   uint y = atomicCounterIncrement(d[1]) + atomicCounterIncrement(b);\n   uint z = atomicCounterIncrement(d[2]) + atomicCounterIncrement(c);\n   uint w = atomicCounterIncrement(e);\n   color = vec4(float(x), float(y), float(z), float(w));\n}";
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(fragment_shader), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            glw::GL_ACTIVE_RESOURCES,
            3,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            glw::GL_MAX_NUM_ACTIVE_VARIABLES,
            2,
            &mut error,
        );

        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["a", "b", "c", "d", "e"] {
            verify_get_program_resource_index_unique(gl, program, glw::GL_UNIFORM, &mut indices, name, &mut error);
        }
        let u = |name: &str| indices.get(name).copied().unwrap_or(0);
        for (key, expected_name) in [("a", "a"), ("b", "b"), ("c", "c"), ("d", "d[0]"), ("e", "e")] {
            verify_get_program_resource_name(gl, program, glw::GL_UNIFORM, u(key), expected_name, &mut error);
        }
        for name in ["a", "b", "c", "d", "e", "d[0]", "d[1]", "d[2]"] {
            verify_get_program_resource_location(gl, program, glw::GL_UNIFORM, name, -1, &mut error);
        }

        let props = [
            glw::GL_BUFFER_BINDING,
            glw::GL_BUFFER_DATA_SIZE,
            glw::GL_NUM_ACTIVE_VARIABLES,
            glw::GL_ACTIVE_VARIABLES,
        ];
        let expected = [1, 4, 1, u("a") as GLint];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            Self::buffer_index_of(gl, program, u("a")) as GLuint,
            &props,
            4,
            &expected,
            &mut error,
        );

        let props2 = [
            glw::GL_BUFFER_BINDING,
            glw::GL_BUFFER_DATA_SIZE,
            glw::GL_NUM_ACTIVE_VARIABLES,
        ];
        let expected2 = [2, 8, 2];
        let expected3 = [5, 16, 2];
        for (name, expected) in [
            ("b", &expected2),
            ("c", &expected2),
            ("d", &expected3),
            ("e", &expected3),
        ] {
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_ATOMIC_COUNTER_BUFFER,
                Self::buffer_index_of(gl, program, u(name)) as GLuint,
                &props2,
                3,
                expected,
                &mut error,
            );
        }

        if !Self::check_active_variables(gl, program, u("b"), &[u("b"), u("c")]) {
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        }
        log::info!("GL_ACTIVE_VARIABLES ok for 1st ATOMIC_COUNTER_BUFFER");
        if !Self::check_active_variables(gl, program, u("d"), &[u("d"), u("e")]) {
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `PIQBase::CreateProgram(vs, tcs, tes, gs, fs, link)`
fn create_program_all_stages(gl: &glw::Functions, sources: [Option<&str>; 5], link: bool) -> GLuint {
    let program = gl!(gl.create_program());
    let stage_types = [
        glw::GL_VERTEX_SHADER,
        glw::GL_TESS_CONTROL_SHADER,
        glw::GL_TESS_EVALUATION_SHADER,
        glw::GL_GEOMETRY_SHADER,
        glw::GL_FRAGMENT_SHADER,
    ];
    for (shader_type, source) in stage_types.into_iter().zip(sources) {
        if let Some(source) = source {
            let source = c_string(source);
            let pointer = source.as_ptr();
            let shader = gl!(gl.create_shader(shader_type));
            gl!(gl.attach_shader(program, shader));
            gl!(gl.delete_shader(shader));
            gl!(gl.shader_source(shader, 1, &pointer, std::ptr::null()));
            gl!(gl.compile_shader(shader));
        }
    }
    if link {
        link_program(gl, program);
    }
    program
}

const SUBROUTINE_DECLARATIONS: &str =
    "subroutine vec4 a_t();\nsubroutine uniform a_t a;\nsubroutine(a_t) vec4 x() {\n   return vec4(1);\n}\n";

/// The five shaders of `SubroutinesBase`.
fn subroutine_shaders() -> [String; 5] {
    [
        "#version 430\nin vec4 position;\nsubroutine vec4 a_t();\nsubroutine uniform a_t a;\nsubroutine(a_t) vec4 x() {\n   return vec4(1);\n}\nsubroutine(a_t) vec4 y() {\n   return vec4(0);\n}\nvoid main(void)\n{\n   gl_Position = a();\n}".to_string(),
        format!("#version 430\nlayout(vertices = 3) out;\n{SUBROUTINE_DECLARATIONS}void main() {{\n   gl_out[gl_InvocationID].gl_Position = a();\n   gl_TessLevelInner[0] = 1.0;\n   gl_TessLevelInner[1] = 1.0;\n   gl_TessLevelOuter[0] = 1.0;\n   gl_TessLevelOuter[1] = 1.0;\n   gl_TessLevelOuter[2] = 1.0;\n}}"),
        format!("#version 430\nlayout(triangles, equal_spacing) in;\n{SUBROUTINE_DECLARATIONS}void main() {{\n   vec4 p0 = gl_in[0].gl_Position;\n   vec4 p1 = gl_in[1].gl_Position;\n   vec4 p2 = gl_in[2].gl_Position;\n   vec3 p = gl_TessCoord.xyz;\n   gl_Position = a();\n}}"),
        format!("#version 430\nlayout(triangles) in;\nlayout(triangle_strip, max_vertices = 4) out;\n{SUBROUTINE_DECLARATIONS}void main() {{\n   gl_Position = vec4(-1, 1, 0, 1);\n   EmitVertex();\n   gl_Position = vec4(-1, -1, 0, 1);\n   EmitVertex();\n   gl_Position = vec4(1, 1, 0, 1);\n   EmitVertex();\n   gl_Position = a();\n   EmitVertex();\n   EndPrimitive();\n}}"),
        format!("#version 430\nout vec4 color;\n{SUBROUTINE_DECLARATIONS}void main() {{\n   color = a();\n}}"),
    ]
}

/// The shader stages `SubroutinesVertex`, `SubroutinesTessControl`, `SubroutinesTessEval`, `SubroutinesGeometry` and `SubroutinesFragment` look at.
#[derive(Clone, Copy)]
enum SubroutineStage {
    Vertex,
    TessControl,
    TessEval,
    Geometry,
    Fragment,
}

impl SubroutineStage {
    /// The subroutine interface, the subroutine uniform interface and the shader type
    fn interfaces(self) -> (GLenum, GLenum, GLenum) {
        match self {
            Self::Vertex => (
                glw::GL_VERTEX_SUBROUTINE,
                glw::GL_VERTEX_SUBROUTINE_UNIFORM,
                glw::GL_VERTEX_SHADER,
            ),
            Self::TessControl => (
                glw::GL_TESS_CONTROL_SUBROUTINE,
                glw::GL_TESS_CONTROL_SUBROUTINE_UNIFORM,
                glw::GL_TESS_CONTROL_SHADER,
            ),
            Self::TessEval => (
                glw::GL_TESS_EVALUATION_SUBROUTINE,
                glw::GL_TESS_EVALUATION_SUBROUTINE_UNIFORM,
                glw::GL_TESS_EVALUATION_SHADER,
            ),
            Self::Geometry => (
                glw::GL_GEOMETRY_SUBROUTINE,
                glw::GL_GEOMETRY_SUBROUTINE_UNIFORM,
                glw::GL_GEOMETRY_SHADER,
            ),
            Self::Fragment => (
                glw::GL_FRAGMENT_SUBROUTINE,
                glw::GL_FRAGMENT_SUBROUTINE_UNIFORM,
                glw::GL_FRAGMENT_SHADER,
            ),
        }
    }
}

/// `SubroutinesVertex`, `SubroutinesTessControl`, `SubroutinesTessEval`, `SubroutinesGeometry` and `SubroutinesFragment`
struct Subroutines {
    stage: SubroutineStage,
}

impl Subroutines {
    /// `SubroutinesBase::VerifyVS`
    fn verify_vs(gl: &glw::Functions, program: GLuint, error: &mut i64) {
        let (subroutine, subroutine_uniform, shader_type) = SubroutineStage::Vertex.interfaces();
        verify_get_program_interfaceiv(gl, program, subroutine, glw::GL_ACTIVE_RESOURCES, 2, error);
        verify_get_program_interfaceiv(gl, program, subroutine, glw::GL_MAX_NAME_LENGTH, 2, error);
        verify_get_program_interfaceiv(gl, program, subroutine_uniform, glw::GL_ACTIVE_RESOURCES, 1, error);
        verify_get_program_interfaceiv(gl, program, subroutine_uniform, glw::GL_MAX_NAME_LENGTH, 2, error);
        verify_get_program_interfaceiv(
            gl,
            program,
            subroutine_uniform,
            glw::GL_MAX_NUM_COMPATIBLE_SUBROUTINES,
            2,
            error,
        );

        let mut indices_s: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["x", "y"] {
            verify_get_program_resource_index_unique(gl, program, subroutine, &mut indices_s, name, error);
        }
        let mut indices_u: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(gl, program, subroutine_uniform, &mut indices_u, "a", error);
        let s = |name: &str| indices_s.get(name).copied().unwrap_or(0);
        let u = |name: &str| indices_u.get(name).copied().unwrap_or(0);

        verify_get_program_resource_name(gl, program, subroutine, s("x"), "x", error);
        verify_get_program_resource_name(gl, program, subroutine, s("y"), "y", error);
        verify_get_program_resource_name(gl, program, subroutine_uniform, u("a"), "a", error);
        let location = Self::subroutine_uniform_location(gl, program, shader_type);
        verify_get_program_resource_location(gl, program, subroutine_uniform, "a", location, error);

        let props_s = [glw::GL_NAME_LENGTH];
        verify_get_program_resourceiv(gl, program, subroutine, s("x"), &props_s, 1, &[2], error);
        verify_get_program_resourceiv(gl, program, subroutine, s("y"), &props_s, 1, &[2], error);
        let props_u = [
            glw::GL_NAME_LENGTH,
            glw::GL_ARRAY_SIZE,
            glw::GL_NUM_COMPATIBLE_SUBROUTINES,
            glw::GL_LOCATION,
        ];
        verify_get_program_resourceiv(
            gl,
            program,
            subroutine_uniform,
            u("a"),
            &props_u,
            4,
            &[2, 1, 2, location],
            error,
        );

        let prop = glw::GL_COMPATIBLE_SUBROUTINES;
        let mut param = [0 as GLint; 1000];
        let mut length: i32 = 0;
        gl!(gl.get_program_resourceiv(
            program,
            subroutine_uniform,
            u("a"),
            1,
            &prop,
            1000,
            &mut length,
            param.as_mut_ptr()
        ));
        for &value in &param[..length as usize] {
            if ![s("x"), s("y")].contains(&(value as GLuint)) || length != 2 {
                log::info!(
                    "Length: {length}\nUnexpected index/length found in active variables of GL_VERTEX_SUBROUTINE_UNIFORM: {value}"
                );
                *error = ERROR;
            }
        }
    }

    fn subroutine_uniform_location(gl: &glw::Functions, program: GLuint, shader_type: GLenum) -> GLint {
        gl!(gl.get_subroutine_uniform_location(program, shader_type, c"a".as_ptr()))
    }

    /// `VerifyTCS`, `VerifyTES`, `VerifyGEO` and `VerifyFS`: one subroutine `x`, one subroutine uniform `a`.
    fn verify_single_subroutine(gl: &glw::Functions, program: GLuint, stage: SubroutineStage, error: &mut i64) {
        let (subroutine, subroutine_uniform, shader_type) = stage.interfaces();
        verify_get_program_interfaceiv(gl, program, subroutine, glw::GL_ACTIVE_RESOURCES, 1, error);
        verify_get_program_interfaceiv(gl, program, subroutine, glw::GL_MAX_NAME_LENGTH, 2, error);
        verify_get_program_interfaceiv(gl, program, subroutine_uniform, glw::GL_ACTIVE_RESOURCES, 1, error);
        verify_get_program_interfaceiv(gl, program, subroutine_uniform, glw::GL_MAX_NAME_LENGTH, 2, error);
        verify_get_program_interfaceiv(
            gl,
            program,
            subroutine_uniform,
            glw::GL_MAX_NUM_COMPATIBLE_SUBROUTINES,
            1,
            error,
        );

        let mut indices_s: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(gl, program, subroutine, &mut indices_s, "x", error);
        let mut indices_u: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(gl, program, subroutine_uniform, &mut indices_u, "a", error);
        let s = |name: &str| indices_s.get(name).copied().unwrap_or(0);
        let u = |name: &str| indices_u.get(name).copied().unwrap_or(0);

        verify_get_program_resource_name(gl, program, subroutine, s("x"), "x", error);
        verify_get_program_resource_name(gl, program, subroutine_uniform, u("a"), "a", error);
        let location = Self::subroutine_uniform_location(gl, program, shader_type);
        verify_get_program_resource_location(gl, program, subroutine_uniform, "a", location, error);

        let props_s = [glw::GL_NAME_LENGTH];
        verify_get_program_resourceiv(gl, program, subroutine, s("x"), &props_s, 1, &[2], error);
        let props_u = [
            glw::GL_NAME_LENGTH,
            glw::GL_ARRAY_SIZE,
            glw::GL_NUM_COMPATIBLE_SUBROUTINES,
            glw::GL_LOCATION,
            glw::GL_COMPATIBLE_SUBROUTINES,
        ];
        verify_get_program_resourceiv(
            gl,
            program,
            subroutine_uniform,
            u("a"),
            &props_u,
            5,
            &[2, 1, 1, location, s("x") as GLint],
            error,
        );
    }
}

impl Subcase for Subroutines {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let shaders = subroutine_shaders();
        let program = create_program_all_stages(
            gl,
            [
                Some(&shaders[0]),
                Some(&shaders[1]),
                Some(&shaders[2]),
                Some(&shaders[3]),
                Some(&shaders[4]),
            ],
            false,
        );
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        match self.stage {
            SubroutineStage::Vertex => Self::verify_vs(gl, program, &mut error),
            stage => Self::verify_single_subroutine(gl, program, stage, &mut error),
        }
        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `SoubroutinesCompute`
struct SubroutinesCompute;

impl Subcase for SubroutinesCompute {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let compute_shader = "layout(local_size_x = 1, local_size_y = 1) in;\nlayout(std430) buffer Output {\n  vec4 data;\n} g_out;\nsubroutine vec4 a_t();\nsubroutine uniform a_t a;\nsubroutine(a_t) vec4 ax() {\n   return vec4(1);\n}\nsubroutine(a_t) vec4 ay() {\n   return vec4(0);\n}\nsubroutine vec4 b_t();\nsubroutine uniform b_t b[3];\nsubroutine(b_t) vec4 bx() {\n   return vec4(1);\n}\nsubroutine(b_t) vec4 by() {\n   return vec4(0);\n}\nsubroutine(b_t) vec4 bz() {\n   return vec4(-1);\n}\nvoid main() {\n   g_out.data = a() + b[0]() + b[1]() + b[2]();\n}";
        let program = super::compute_shader_tests::create_compute_program(gl, compute_shader);
        gl!(gl.link_program(program));
        if !super::compute_shader_tests::check_program(gl, program) {
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        }
        gl!(gl.use_program(program));

        let mut error = NO_ERROR;
        Self::verify_compute(gl, program, &mut error);
        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

impl SubroutinesCompute {
    /// `VerifyCompute`
    fn verify_compute(gl: &glw::Functions, program: GLuint, error: &mut i64) {
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_COMPUTE_SUBROUTINE,
            glw::GL_ACTIVE_RESOURCES,
            5,
            error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_COMPUTE_SUBROUTINE,
            glw::GL_MAX_NAME_LENGTH,
            3,
            error,
        );
        let mut res: GLint = 0;
        gl!(gl.get_program_stageiv(
            program,
            glw::GL_COMPUTE_SHADER,
            glw::GL_ACTIVE_SUBROUTINE_UNIFORMS,
            &mut res
        ));
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
            glw::GL_ACTIVE_RESOURCES,
            res,
            error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
            glw::GL_MAX_NAME_LENGTH,
            5,
            error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
            glw::GL_MAX_NUM_COMPATIBLE_SUBROUTINES,
            3,
            error,
        );

        let subroutine_names = ["ax", "ay", "bx", "by", "bz"];
        let mut indices_ts: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in subroutine_names {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_COMPUTE_SUBROUTINE,
                &mut indices_ts,
                name,
                error,
            );
        }
        let mut indices_tu: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["a", "b[0]"] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
                &mut indices_tu,
                name,
                error,
            );
        }
        let ts = |name: &str| indices_ts.get(name).copied().unwrap_or(0);
        let tu = |name: &str| indices_tu.get(name).copied().unwrap_or(0);

        for name in subroutine_names {
            verify_get_program_resource_name(gl, program, glw::GL_COMPUTE_SUBROUTINE, ts(name), name, error);
        }
        for name in ["a", "b[0]"] {
            verify_get_program_resource_name(gl, program, glw::GL_COMPUTE_SUBROUTINE_UNIFORM, tu(name), name, error);
        }
        let location_of = |name: &std::ffi::CStr| {
            gl!(gl.get_subroutine_uniform_location(program, glw::GL_COMPUTE_SHADER, name.as_ptr()))
        };
        verify_get_program_resource_location(
            gl,
            program,
            glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
            "a",
            location_of(c"a"),
            error,
        );
        verify_get_program_resource_location(
            gl,
            program,
            glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
            "b",
            location_of(c"b"),
            error,
        );

        let props_s = [glw::GL_NAME_LENGTH];
        for name in subroutine_names {
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_COMPUTE_SUBROUTINE,
                ts(name),
                &props_s,
                1,
                &[3],
                error,
            );
        }
        let props_u = [
            glw::GL_NAME_LENGTH,
            glw::GL_ARRAY_SIZE,
            glw::GL_NUM_COMPATIBLE_SUBROUTINES,
            glw::GL_LOCATION,
        ];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
            tu("a"),
            &props_u,
            4,
            &[2, 1, 2, location_of(c"a")],
            error,
        );
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_COMPUTE_SUBROUTINE_UNIFORM,
            tu("b[0]"),
            &props_u,
            4,
            &[5, 3, 3, location_of(c"b")],
            error,
        );
    }
}

/// `PIQBase::ExpectError`
fn expect_error(gl: &glw::Functions, expected: GLenum, error: &mut i64) {
    if *error != NO_ERROR {
        return;
    }
    let found = gl!(gl.get_error());
    if found == expected {
        log::info!("Found expected error");
        *error = NO_ERROR;
    } else {
        *error = ERROR;
        log::info!("{expected} error was expected, found: {found}");
    }
}

/// `InvalidValueTest`
struct InvalidValueTest;

impl Subcase for InvalidValueTest {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut error = NO_ERROR;
        let mut res: GLint = 0;
        let mut len: i32 = 0;
        let mut name = [0u8; 100];
        let props = [glw::GL_NAME_LENGTH];

        log::info!("Case 1: <program> not a name of shader/program object");
        gl!(gl.get_program_interfaceiv(1337, glw::GL_PROGRAM_INPUT, glw::GL_ACTIVE_RESOURCES, &mut res));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);
        gl!(gl.get_program_resource_index(31337, glw::GL_PROGRAM_INPUT, c"pie".as_ptr()));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);
        gl!(gl.get_program_resource_name(1337, glw::GL_PROGRAM_INPUT, 0, 1024, &mut len, name.as_mut_ptr().cast()));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);
        gl!(gl.get_program_resourceiv(
            1337,
            glw::GL_PROGRAM_INPUT,
            0,
            1,
            props.as_ptr(),
            1024,
            &mut len,
            &mut res
        ));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);
        gl!(gl.get_program_resource_location(1337, glw::GL_PROGRAM_INPUT, c"pie".as_ptr()));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);
        gl!(gl.get_program_resource_location_index(1337, glw::GL_PROGRAM_OUTPUT, c"pie".as_ptr()));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);
        log::info!("Case 1 finished");

        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        log::info!("Case 2: <index> is greater than the number of the active resources in GetProgramResourceName");
        gl!(gl.get_program_resource_name(
            program,
            glw::GL_PROGRAM_INPUT,
            3000,
            1024,
            &mut len,
            name.as_mut_ptr().cast()
        ));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);
        log::info!("Case 2 finished");

        log::info!("Case 3: <propCount> is zero in GetProgramResourceiv");
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_PROGRAM_INPUT,
            0,
            0,
            props.as_ptr(),
            1024,
            &mut len,
            &mut res
        ));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);
        log::info!("Case 3 finished");

        let mut text = *b"position\0";
        gl!(gl.get_program_resource_name(
            program,
            glw::GL_PROGRAM_INPUT,
            0,
            -100,
            std::ptr::null_mut(),
            text.as_mut_ptr().cast()
        ));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);

        let prop = glw::GL_NAME_LENGTH;
        gl!(gl.get_program_resourceiv(program, glw::GL_PROGRAM_INPUT, 0, 1, &prop, -100, &mut len, &mut res));
        expect_error(gl, glw::GL_INVALID_VALUE, &mut error);

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `InvalidEnumTest`
struct InvalidEnumTest;

impl Subcase for InvalidEnumTest {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let fragment_shader = "#version 430\nout vec4 color;\nlayout (binding = 1, offset = 0) uniform atomic_uint a;\nlayout (binding = 2, offset = 0) uniform atomic_uint b;\nlayout (binding = 2, offset = 4) uniform atomic_uint c;\nlayout (binding = 5, offset = 0) uniform atomic_uint d[3];\nlayout (binding = 5, offset = 12) uniform atomic_uint e;\nvoid main() {\n   uint x = atomicCounterIncrement(d[0]) + atomicCounterIncrement(a);\n   uint y = atomicCounterIncrement(d[1]) + atomicCounterIncrement(b);\n   uint z = atomicCounterIncrement(d[2]) + atomicCounterIncrement(c);\n   uint w = atomicCounterIncrement(e);\n   color = vec4(float(x), float(y), float(z), float(w));\n}";
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(fragment_shader), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        let mut res: GLint = 0;
        let mut len: i32 = 0;
        let mut name = [0u8; 100];
        let props = [glw::GL_TEXTURE_1D];

        log::info!(
            "Case 1: <programInterface> is ATOMIC_COUNTER_BUFFER in GetProgramResourceIndex or GetProgramResourceName"
        );
        gl!(gl.get_program_resource_index(program, glw::GL_ATOMIC_COUNTER_BUFFER, name.as_ptr().cast()));
        expect_error(gl, glw::GL_INVALID_ENUM, &mut error);
        gl!(gl.get_program_resource_name(
            program,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            0,
            1024,
            &mut len,
            name.as_mut_ptr().cast()
        ));
        expect_error(gl, glw::GL_INVALID_ENUM, &mut error);
        log::info!("Case 1 finished");

        log::info!("Case 2: <props> is not a property name supported by the command GetProgramResourceiv");
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_PROGRAM_INPUT,
            0,
            1,
            props.as_ptr(),
            1024,
            &mut len,
            &mut res
        ));
        expect_error(gl, glw::GL_INVALID_ENUM, &mut error);
        log::info!("Case 2 finished");

        gl!(gl.get_program_resource_location(program, glw::GL_ATOMIC_COUNTER_BUFFER, c"position".as_ptr()));
        expect_error(gl, glw::GL_INVALID_ENUM, &mut error);

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `InvalidOperationTest`
struct InvalidOperationTest;

impl Subcase for InvalidOperationTest {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let mut error = NO_ERROR;
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(SIMPLE_FRAGMENT_SHADER), false);
        let program2 = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let shader = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        let mut res: GLint = 0;
        let mut len: i32 = 0;
        let mut name = [0u8; 100];
        let props = [glw::GL_OFFSET];

        log::info!("Case 1: <program> is the name of a shader object");
        gl!(gl.get_program_interfaceiv(shader, glw::GL_PROGRAM_INPUT, glw::GL_ACTIVE_RESOURCES, &mut res));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        gl!(gl.get_program_resource_index(shader, glw::GL_PROGRAM_INPUT, c"pie".as_ptr()));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        gl!(gl.get_program_resource_name(
            shader,
            glw::GL_PROGRAM_INPUT,
            0,
            1024,
            &mut len,
            name.as_mut_ptr().cast()
        ));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        gl!(gl.get_program_resourceiv(
            shader,
            glw::GL_PROGRAM_INPUT,
            0,
            1,
            props.as_ptr(),
            1024,
            &mut len,
            &mut res
        ));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        gl!(gl.get_program_resource_location(shader, glw::GL_PROGRAM_INPUT, c"pie".as_ptr()));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        gl!(gl.get_program_resource_location_index(shader, glw::GL_PROGRAM_OUTPUT, c"pie".as_ptr()));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        gl!(gl.delete_shader(shader));

        log::info!("Case 1 finished\nCase 2: <pname> is not supported in GetProgramInterfacei");
        gl!(gl.get_program_interfaceiv(
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_MAX_NUM_ACTIVE_VARIABLES,
            &mut res
        ));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);

        log::info!("Case 2 finished\nCase 3: <props> is not supported in GetProgramResourceiv");
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_PROGRAM_INPUT,
            0,
            1,
            props.as_ptr(),
            1024,
            &mut len,
            &mut res
        ));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);

        log::info!(
            "Case 3 finished\nCase 4: <program> has not been linked in GetProgramResourceLocation/GetProgramResourceLocationIndex"
        );
        gl!(gl.get_program_resource_location(program2, glw::GL_PROGRAM_INPUT, c"pie".as_ptr()));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        gl!(gl.get_program_resource_location_index(program2, glw::GL_PROGRAM_OUTPUT, c"pie".as_ptr()));
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        log::info!("Case 4 finished\n");

        gl!(gl.delete_program(program));
        gl!(gl.delete_program(program2));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `UniformBlockArray`
struct UniformBlockArray;

impl Subcase for UniformBlockArray {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nvoid main(void)\n{\n    gl_Position = vec4(1.0);\n}";
        let fragment_shader = "#version 430\nuniform TestBlock {\n   mediump vec4 color;\n} blockInstance[4];\nout mediump vec4 color;\nvoid main() {\n    color = blockInstance[2].color + blockInstance[3].color;\n}";
        let program = create_program(gl, Some(vertex_shader), Some(fragment_shader), false);
        link_program(gl, program);

        let mut error = NO_ERROR;
        let mut indices_ub: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_UNIFORM_BLOCK,
            &mut indices_ub,
            "TestBlock",
            &mut error,
        );
        let mut indices_u: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_UNIFORM,
            &mut indices_u,
            "TestBlock.color",
            &mut error,
        );

        let props = [glw::GL_BLOCK_INDEX];
        let expected = [indices_ub.get("TestBlock").copied().unwrap_or(0) as GLint];
        let color_index = indices_u.get("TestBlock.color").copied().unwrap_or(0);
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            color_index,
            &props,
            1,
            &expected,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `TransformFeedbackBuiltin`
struct TransformFeedbackBuiltin;

impl Subcase for TransformFeedbackBuiltin {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nout ivec4 a;\nout uvec2 c;\nout uint d;\nout int f;\nout uint e;\nout int g;\nvoid main(void)\n{\n   vec4 pos;\n   a = ivec4(1);\n   c = uvec2(1u);\n   d = 1u;\n   f = 1;\n   e = 1u;\n   g = 1;\n   gl_Position = position;\n}";
        let program = create_program(gl, Some(vertex_shader), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        let varyings = [
            c"a",
            c"gl_NextBuffer",
            c"c",
            c"gl_SkipComponents1",
            c"d",
            c"gl_SkipComponents2",
            c"f",
            c"gl_SkipComponents3",
            c"e",
            c"gl_SkipComponents4",
            c"g",
        ]
        .map(|name| name.as_ptr());
        gl!(gl.transform_feedback_varyings(program, 11, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_TRANSFORM_FEEDBACK_VARYING,
            glw::GL_ACTIVE_RESOURCES,
            11,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_TRANSFORM_FEEDBACK_VARYING,
            glw::GL_MAX_NAME_LENGTH,
            19,
            &mut error,
        );
        for name in [
            "gl_NextBuffer",
            "gl_SkipComponents1",
            "gl_SkipComponents2",
            "gl_SkipComponents3",
            "gl_SkipComponents4",
        ] {
            verify_get_program_resource_index(
                gl,
                program,
                glw::GL_TRANSFORM_FEEDBACK_VARYING,
                name,
                glw::GL_INVALID_INDEX,
                &mut error,
            );
        }

        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        for i in 0..11u32 {
            let mut length: i32 = 0;
            let mut name = [0u8; 1024];
            gl!(gl.get_program_resource_name(
                program,
                glw::GL_TRANSFORM_FEEDBACK_VARYING,
                i,
                1024,
                &mut length,
                name.as_mut_ptr().cast()
            ));
            let end = name.iter().position(|&byte| byte == 0).unwrap_or(name.len());
            indices.insert(String::from_utf8_lossy(&name[..end]).into_owned(), i);
        }
        let index = |name: &str| indices.get(name).copied().unwrap_or(0);
        log::info!(
            "Indices of builtins:\n{}, {}, {}, {}, {}",
            index("gl_NextBuffer"),
            index("gl_SkipComponents1"),
            index("gl_SkipComponents2"),
            index("gl_SkipComponents3"),
            index("gl_SkipComponents4")
        );

        let props = [glw::GL_NAME_LENGTH, glw::GL_TYPE, glw::GL_ARRAY_SIZE];
        let none = glw::GL_NONE as GLint;
        let expectations = [
            ("gl_NextBuffer", [14, none, 0]),
            ("gl_SkipComponents1", [19, none, 1]),
            ("gl_SkipComponents2", [19, none, 2]),
            ("gl_SkipComponents3", [19, none, 3]),
            ("gl_SkipComponents4", [19, none, 4]),
        ];
        for (name, expected) in expectations {
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_TRANSFORM_FEEDBACK_VARYING,
                index(name),
                &props,
                3,
                &expected,
                &mut error,
            );
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `NullLength`
struct NullLength;

impl Subcase for NullLength {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut name = [0u8; 1024];
        let index = gl!(gl.get_program_resource_index(program, glw::GL_PROGRAM_OUTPUT, c"color".as_ptr()));
        let prop = glw::GL_ARRAY_SIZE;
        let mut res: GLint = 0;
        gl!(gl.get_program_resource_name(
            program,
            glw::GL_PROGRAM_OUTPUT,
            0,
            1024,
            std::ptr::null_mut(),
            name.as_mut_ptr().cast()
        ));
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_PROGRAM_OUTPUT,
            index,
            1,
            &prop,
            1,
            std::ptr::null_mut(),
            &mut res
        ));

        let end = name.iter().position(|&byte| byte == 0).unwrap_or(name.len());
        let expected = "color";
        if &name[..end] != expected.as_bytes() {
            log::info!(
                "Expected name: {expected}, got: {}",
                String::from_utf8_lossy(&name[..end])
            );
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        } else if res != 1 {
            log::info!("Expected array_size: 1, got: {res}");
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        }
        gl!(gl.delete_program(program));
        Ok(NO_ERROR)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `ArraysOfArrays`
struct ArraysOfArrays;

impl Subcase for ArraysOfArrays {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nuniform vec4 a[3][4][5];\nvoid main(void)\n{\n    gl_Position = position;\n    for (int i = 0; i < 5; ++i)\n        gl_Position += a[2][1][i];\n}";
        let program = create_program(gl, Some(vertex_shader), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(gl, program, glw::GL_UNIFORM, glw::GL_MAX_NAME_LENGTH, 11, &mut error);
        let mut indices: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(gl, program, glw::GL_UNIFORM, &mut indices, "a[2][1]", &mut error);
        let index = indices.get("a[2][1]").copied().unwrap_or(0);
        verify_get_program_resource_index(gl, program, glw::GL_UNIFORM, "a[2][1][0]", index, &mut error);
        verify_get_program_resource_name(gl, program, glw::GL_UNIFORM, index, "a[2][1][0]", &mut error);

        let expected = uniform_expected(
            11,
            glw::GL_FLOAT_VEC4,
            5,
            0,
            1,
            get_uniform_location(gl, program, "a[2][1]"),
        );
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            index,
            &PROPS_UNIFORM,
            16,
            &expected,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `TopLevelArray`
struct TopLevelArray;

impl Subcase for TopLevelArray {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let fragment_shader = "#version 430\nbuffer Block {\n   vec4 a[5][4][3];\n};\nout vec4 color;\nvoid main() {\n    color = vec4(0, 1, 0, 1) + a[0][0][0];\n}";
        let program = create_program(gl, Some(SIMPLE_VERTEX_SHADER), Some(fragment_shader), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            glw::GL_MAX_NAME_LENGTH,
            11,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_MAX_NAME_LENGTH,
            6,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );

        let mut indices_ssb: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_bv: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            &mut indices_bv,
            "a[0][0]",
            &mut error,
        );
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            &mut indices_ssb,
            "Block",
            &mut error,
        );
        let variable = indices_bv.get("a[0][0]").copied().unwrap_or(0);
        let block = indices_ssb.get("Block").copied().unwrap_or(0);

        verify_get_program_resource_name(gl, program, glw::GL_BUFFER_VARIABLE, variable, "a[0][0][0]", &mut error);
        verify_get_program_resource_name(gl, program, glw::GL_SHADER_STORAGE_BLOCK, block, "Block", &mut error);

        let props3 = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_BLOCK_INDEX,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
            glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
            glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_TOP_LEVEL_ARRAY_SIZE,
        ];
        let expected5 = [
            11,
            glw::GL_FLOAT_VEC4 as GLint,
            3,
            block as GLint,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            5,
        ];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            variable,
            &props3,
            12,
            &expected5,
            &mut error,
        );

        let prop = glw::GL_TOP_LEVEL_ARRAY_STRIDE;
        let mut len: i32 = 0;
        let mut res: GLint = 0;
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_BUFFER_VARIABLE,
            variable,
            1,
            &prop,
            1024,
            &mut len,
            &mut res
        ));
        if res <= 0 {
            log::info!(
                "Call: glGetProgramResourceiv, interface: GL_BUFFER_VARIABLE, param: GL_TOP_LEVEL_ARRAY_STRIDE\nExpected value greater than 0, got: {res}"
            );
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `PIQBase::VerifyGetProgramResourceLocation` recording the location under `name` and rejecting duplicates
fn verify_get_program_resource_location_unique(
    gl: &glw::Functions,
    program: GLuint,
    program_interface: GLenum,
    locations: &mut BTreeMap<String, GLint>,
    name: &str,
    error: &mut i64,
) {
    let c_name = c_string(name);
    let res = gl!(gl.get_program_resource_location(program, program_interface, c_name.as_ptr()));
    if res < 0 {
        log::info!("ERROR: Got {res}, expected not less than 0");
        *error = ERROR;
        return;
    }
    if locations.values().any(|&value| value == res) {
        log::info!("ERROR: Duplicated value found: {res}");
        *error = ERROR;
        return;
    }
    locations.insert(name.to_string(), res);
}

/// `indices["name"]` of a `std::map`, which is 0 for a name that was never inserted
fn index_of(indices: &BTreeMap<String, GLuint>, name: &str) -> GLuint {
    indices.get(name).copied().unwrap_or(0)
}

/// The `Create*Program` + `glBindAttribLocation` + `glBindFragDataLocation` + `LinkProgram` sequence of the simple cases
fn linked_program(gl: &glw::Functions, vertex_shader: &str, fragment_shader: &str) -> GLuint {
    let program = create_program(gl, Some(vertex_shader), Some(fragment_shader), false);
    gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
    gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
    link_program(gl, program);
    program
}

/// `UniformBlockAdvanced`
struct UniformBlockAdvanced;

impl Subcase for UniformBlockAdvanced {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nlayout(row_major) uniform SimpleBlock {\n   mat4 a;\n   vec4 b[10];\n};\nvoid main(void)\n{\n    float tmp;\n    tmp = a[0][0] + b[0].x;\n    gl_Position = position * tmp;\n}";
        let program = linked_program(gl, vertex_shader, SIMPLE_FRAGMENT_SHADER);

        let mut error = NO_ERROR;
        let mut indices_u: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(gl, program, glw::GL_UNIFORM, &mut indices_u, "a", &mut error);
        verify_get_program_resource_index_unique(gl, program, glw::GL_UNIFORM, &mut indices_u, "b", &mut error);

        let props = [glw::GL_IS_ROW_MAJOR];
        let expected = [1];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            index_of(&indices_u, "a"),
            &props,
            1,
            &expected,
            &mut error,
        );

        let query = |index: GLuint, prop: GLenum| -> GLint {
            let mut len: i32 = 0;
            let mut res: GLint = 0;
            gl!(gl.get_program_resourceiv(program, glw::GL_UNIFORM, index, 1, &prop, 1024, &mut len, &mut res));
            res
        };

        let res = query(index_of(&indices_u, "a"), glw::GL_MATRIX_STRIDE);
        if res < 1 {
            log::info!(
                "ERROR: glGetProgramResourceiv, interface GL_UNIFORM, prop GL_MATRIX_STRIDE\nExpected value greater than 0, got {res}"
            );
        }
        let res = query(index_of(&indices_u, "a"), glw::GL_OFFSET);
        if res < 0 {
            log::info!(
                "ERROR: glGetProgramResourceiv, interface GL_UNIFORM, prop GL_OFFSET\nExpected value not less than 0, got {res}"
            );
        }
        let res = query(index_of(&indices_u, "b"), glw::GL_ARRAY_STRIDE);
        if res < 1 {
            log::info!(
                "ERROR: glGetProgramResourceiv, interface GL_UNIFORM, prop GL_ARRAY_STRIDE\nExpected value greater than 0, got {res}"
            );
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `ArrayNames`
struct ArrayNames;

impl Subcase for ArrayNames {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nuniform vec4 a[2];\nvoid main(void)\n{\n    gl_Position = position + a[0] + a[1];\n}";
        let program = create_program(gl, Some(vertex_shader), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        let a_location = get_uniform_location(gl, program, "a");
        let a1_location = get_uniform_location(gl, program, "a[1]");
        verify_get_program_resource_location(gl, program, glw::GL_UNIFORM, "a", a_location, &mut error);
        verify_get_program_resource_location(gl, program, glw::GL_UNIFORM, "a[0]", a_location, &mut error);
        verify_get_program_resource_location(gl, program, glw::GL_UNIFORM, "a[1]", a1_location, &mut error);
        for name in [
            "a[2]", "a[0 + 0]", "a[0+0]", "a[ 0]", "a[0 ]", "a[\n0]", "a[\t0]", "a[01]", "a[00]",
        ] {
            verify_get_program_resource_location(gl, program, glw::GL_UNIFORM, name, -1, &mut error);
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `BuffLength`
struct BuffLength;

impl Subcase for BuffLength {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nuniform vec4 someLongName;\nvoid main(void)\n{\n    gl_Position = position + someLongName;\n}";
        let program = create_program(gl, Some(vertex_shader), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        let index = gl!(gl.get_program_resource_index(program, glw::GL_UNIFORM, c"someLongName".as_ptr()));
        let mut length: i32 = 0;
        let mut buff: [u8; 3] = *b"abc";

        gl!(gl.get_program_resource_name(
            program,
            glw::GL_UNIFORM,
            index,
            0,
            std::ptr::null_mut(),
            std::ptr::null_mut()
        ));
        gl!(gl.get_program_resource_name(
            program,
            glw::GL_UNIFORM,
            index,
            0,
            std::ptr::null_mut(),
            buff.as_mut_ptr().cast()
        ));
        if buff != *b"abc" {
            log::info!("ERROR: buff has changed");
            error = ERROR;
        }

        gl!(gl.get_program_resource_name(
            program,
            glw::GL_UNIFORM,
            index,
            2,
            &mut length,
            buff.as_mut_ptr().cast()
        ));
        if buff[0] != b's' || buff[1] != 0 || buff[2] != b'c' {
            log::info!("ERROR: buff different then expected");
            error = ERROR;
        }
        if length != 1 {
            log::info!("ERROR: incorrect length, expected 1, got {length}");
            error = ERROR;
        }

        let mut params: [GLint; 3] = [1, 2, 3];
        let props = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_OFFSET,
            glw::GL_BLOCK_INDEX,
            glw::GL_ARRAY_STRIDE,
            glw::GL_MATRIX_STRIDE,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_ATOMIC_COUNTER_BUFFER_INDEX,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_LOCATION,
        ];
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_UNIFORM,
            index,
            13,
            props.as_ptr(),
            0,
            std::ptr::null_mut(),
            std::ptr::null_mut()
        ));
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_UNIFORM,
            index,
            13,
            props.as_ptr(),
            0,
            std::ptr::null_mut(),
            params.as_mut_ptr()
        ));
        if params != [1, 2, 3] {
            log::info!("ERROR: params has changed");
            error = ERROR;
        }

        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_UNIFORM,
            index,
            13,
            props.as_ptr(),
            2,
            &mut length,
            params.as_mut_ptr()
        ));
        if params[0] != 13 || params[1] != glw::GL_FLOAT_VEC4 as GLint || params[2] != 3 {
            log::info!("ERROR: params has incorrect values");
            error = ERROR;
        }
        if length != 2 {
            log::info!("ERROR: incorrect length, expected 2, got {length}");
            error = ERROR;
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `NoLocations`
struct NoLocations;

impl Subcase for NoLocations {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 a;\nin vec4 b;\nin vec4 c[1];\nin vec4 d;\nvoid main(void)\n{\n    gl_Position = a + b + c[0] + d;\n}";
        let fragment_shader = "#version 430\nout vec4 a;\nout vec4 b;\nout vec4 c;\nout vec4 d[1];\nvoid main() {\n    a = vec4(0, 1, 0, 1);\n    b = vec4(0, 1, 0, 1);\n    c = vec4(0, 1, 0, 1);\n    d[0] = vec4(0, 1, 0, 1);\n}";
        let program = create_program(gl, Some(vertex_shader), Some(fragment_shader), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.link_program(program));

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_ACTIVE_RESOURCES,
            4,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_MAX_NAME_LENGTH,
            5,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_ACTIVE_RESOURCES,
            4,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_MAX_NAME_LENGTH,
            5,
            &mut error,
        );

        let mut indices_i: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_o: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["a", "b", "c", "d"] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_PROGRAM_INPUT,
                &mut indices_i,
                name,
                &mut error,
            );
        }
        for name in ["a", "b", "c", "d[0]"] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_PROGRAM_OUTPUT,
                &mut indices_o,
                name,
                &mut error,
            );
        }

        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "a"),
            "a",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "b"),
            "b",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "c"),
            "c[0]",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "d"),
            "d",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "a"),
            "a",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "b"),
            "b",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "c"),
            "c",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "d[0]"),
            "d[0]",
            &mut error,
        );

        let mut locations_i: BTreeMap<String, GLint> = BTreeMap::new();
        let mut locations_o: BTreeMap<String, GLint> = BTreeMap::new();
        for name in ["a", "b", "c", "d"] {
            verify_get_program_resource_location_unique(
                gl,
                program,
                glw::GL_PROGRAM_INPUT,
                &mut locations_i,
                name,
                &mut error,
            );
        }
        for name in ["a", "b", "c", "d[0]"] {
            verify_get_program_resource_location_unique(
                gl,
                program,
                glw::GL_PROGRAM_OUTPUT,
                &mut locations_o,
                name,
                &mut error,
            );
        }

        let props = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
        ];
        let float_vec4 = glw::GL_FLOAT_VEC4 as GLint;
        let expected = [2, float_vec4, 1, 0, 0, 1];
        for name in ["a", "b", "d"] {
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_PROGRAM_INPUT,
                index_of(&indices_i, name),
                &props,
                6,
                &expected,
                &mut error,
            );
        }
        let expected2 = [5, float_vec4, 1, 0, 0, 1];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "c"),
            &props,
            6,
            &expected2,
            &mut error,
        );

        let expected3 = [2, float_vec4, 1, 0, 1, 0];
        for name in ["a", "b", "c"] {
            verify_get_program_resourceiv(
                gl,
                program,
                glw::GL_PROGRAM_OUTPUT,
                index_of(&indices_o, name),
                &props,
                6,
                &expected3,
                &mut error,
            );
        }
        let expected4 = [5, float_vec4, 1, 0, 1, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "d[0]"),
            &props,
            6,
            &expected4,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `ComputeShaderTest::CreateComputeProgram`
fn create_compute_program_with_version(gl: &glw::Functions, cs: &str) -> GLuint {
    let program = gl!(gl.create_program());
    if !cs.is_empty() {
        let version = c_string("#version 430  core \n");
        let source = c_string(cs);
        let sources = [version.as_ptr(), source.as_ptr()];
        let shader = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
        gl!(gl.attach_shader(program, shader));
        gl!(gl.delete_shader(shader));
        gl!(gl.shader_source(shader, 2, sources.as_ptr(), std::ptr::null()));
        gl!(gl.compile_shader(shader));
    }
    program
}

fn log_to_string(buffer: &[u8]) -> String {
    let end = buffer.iter().position(|&byte| byte == 0).unwrap_or(buffer.len());
    String::from_utf8_lossy(&buffer[..end]).into_owned()
}

/// `ComputeShaderTest::CheckProgram`
fn check_program_logging(gl: &glw::Functions, program: GLuint) -> bool {
    let mut compile_status = glw::GL_TRUE as GLint;
    let status = get_program_value(gl, program, glw::GL_LINK_STATUS);

    if status == glw::GL_FALSE as GLint {
        let attached_shaders = get_program_value(gl, program, glw::GL_ATTACHED_SHADERS);
        if attached_shaders > 0 {
            let mut shaders = vec![0 as GLuint; attached_shaders as usize];
            gl!(gl.get_attached_shaders(program, attached_shaders, std::ptr::null_mut(), shaders.as_mut_ptr()));

            for &shader in &shaders {
                let mut shader_type = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_TYPE, &mut shader_type));
                log::info!(
                    "*** {} Shader ***",
                    match shader_type as GLenum {
                        glw::GL_VERTEX_SHADER => "Vertex",
                        glw::GL_TESS_CONTROL_SHADER => "Tessellation Control",
                        glw::GL_TESS_EVALUATION_SHADER => "Tessellation Evaluation",
                        glw::GL_GEOMETRY_SHADER => "Geometry",
                        glw::GL_FRAGMENT_SHADER => "Fragment",
                        glw::GL_COMPUTE_SHADER => "Compute",
                        _ => "Unknown",
                    }
                );

                let mut res = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_COMPILE_STATUS, &mut res));
                if res != glw::GL_TRUE as GLint {
                    compile_status = res;
                }

                let mut length = 0;
                gl!(gl.get_shaderiv(shader, glw::GL_SHADER_SOURCE_LENGTH, &mut length));
                if length > 0 {
                    let mut source = vec![0u8; length as usize];
                    gl!(gl.get_shader_source(shader, length, std::ptr::null_mut(), source.as_mut_ptr().cast()));
                    log::info!("{}", log_to_string(&source));
                }

                gl!(gl.get_shaderiv(shader, glw::GL_INFO_LOG_LENGTH, &mut length));
                if length > 0 {
                    let mut info_log = vec![0u8; length as usize];
                    gl!(gl.get_shader_info_log(shader, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
                    log::info!("{}", log_to_string(&info_log));
                }
            }
        }

        let length = get_program_value(gl, program, glw::GL_INFO_LOG_LENGTH);
        if length > 0 {
            let mut info_log = vec![0u8; length as usize];
            gl!(gl.get_program_info_log(program, length, std::ptr::null_mut(), info_log.as_mut_ptr().cast()));
            log::info!("{}", log_to_string(&info_log));
        }
    }

    if compile_status != glw::GL_TRUE as GLint {
        return false;
    }
    status == glw::GL_TRUE as GLint
}

/// `ComputeShaderTest`
struct ComputeShaderTest;

impl Subcase for ComputeShaderTest {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let compute_shader = "layout(local_size_x = 1, local_size_y = 1) in;\nlayout(std430) buffer Output {\n   vec4 data[];\n} g_out;\nvoid main() {\n   g_out.data[0] = vec4(1.0, 2.0, 3.0, 4.0);\n   g_out.data[100] = vec4(1.0, 2.0, 3.0, 4.0);\n}";
        let program = create_compute_program_with_version(gl, compute_shader);
        gl!(gl.link_program(program));
        if !check_program_logging(gl, program) {
            gl!(gl.delete_program(program));
            return Ok(ERROR);
        }
        gl!(gl.use_program(program));

        let mut error = NO_ERROR;

        // VerifyCompute
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            glw::GL_MAX_NAME_LENGTH,
            15,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_MAX_NAME_LENGTH,
            7,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_MAX_NUM_ACTIVE_VARIABLES,
            1,
            &mut error,
        );

        let mut indices_ssb: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_bv: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            &mut indices_ssb,
            "Output",
            &mut error,
        );
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            &mut indices_bv,
            "Output.data",
            &mut error,
        );

        // upstream looks the variable up as "Outputa.data", which std::map turns into index 0
        let variable = index_of(&indices_bv, "Outputa.data");
        let block = index_of(&indices_ssb, "Output");
        verify_get_program_resource_name(gl, program, glw::GL_SHADER_STORAGE_BLOCK, block, "Output", &mut error);
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            variable,
            "Output.data[0]",
            &mut error,
        );

        let props3 = [
            glw::GL_NAME_LENGTH,
            glw::GL_BUFFER_BINDING,
            glw::GL_NUM_ACTIVE_VARIABLES,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_ACTIVE_VARIABLES,
        ];
        let expected3 = [7, 0, 1, 1, 0, 0, variable as GLint];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            block,
            &props3,
            7,
            &expected3,
            &mut error,
        );

        let props4 = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_BLOCK_INDEX,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_TOP_LEVEL_ARRAY_SIZE,
        ];
        let expected4 = [15, glw::GL_FLOAT_VEC4 as GLint, 0, block as GLint, 0, 1, 0, 0, 1];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            variable,
            &props4,
            9,
            &expected4,
            &mut error,
        );

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `QueryNotUsed`
struct QueryNotUsed;

impl Subcase for QueryNotUsed {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader2 = "#version 430\nin vec4 p;\nvoid main(void)\n{\n    gl_Position = p;\n}";
        let fragment_shader2 = "#version 430\nout vec4 c;\nvoid main() {\n    c = vec4(0, 1, 0, 1);\n}";

        let program = linked_program(gl, SIMPLE_VERTEX_SHADER, SIMPLE_FRAGMENT_SHADER);
        let program2 = create_program(gl, Some(vertex_shader2), Some(fragment_shader2), false);
        // upstream binds these two on the first program, not on the second one
        gl!(gl.bind_attrib_location(program, 0, c"p".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"c".as_ptr()));
        link_program(gl, program2);
        gl!(gl.use_program(program2));

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_MAX_NAME_LENGTH,
            9,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_MAX_NAME_LENGTH,
            6,
            &mut error,
        );

        verify_get_program_resource_index(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 0, &mut error);
        verify_get_program_resource_index(gl, program, glw::GL_PROGRAM_INPUT, "position", 0, &mut error);

        verify_get_program_resource_name(gl, program, glw::GL_PROGRAM_OUTPUT, 0, "color", &mut error);
        verify_get_program_resource_name(gl, program, glw::GL_PROGRAM_INPUT, 0, "position", &mut error);

        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_INPUT, "position", 0, &mut error);
        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 0, &mut error);
        verify_get_program_resource_location_index(gl, program, glw::GL_PROGRAM_OUTPUT, "color", 0, &mut error);

        let expected = [9, glw::GL_FLOAT_VEC4 as GLint, 1, 0, 0, 0, 0, 0, 1, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            0,
            &PROPS_11,
            11,
            &expected,
            &mut error,
        );

        let expected2 = [6, glw::GL_FLOAT_VEC4 as GLint, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            0,
            &PROPS_12,
            12,
            &expected2,
            &mut error,
        );

        gl!(gl.delete_program(program));
        gl!(gl.delete_program(program2));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// The four vertices of the strip `RelinkFailure` and `LinkFailure` draw
const STRIP_VERTICES: [[f32; 4]; 4] = [
    [-1.0, 1.0, 0.0, 1.0],
    [-1.0, -1.0, 0.0, 1.0],
    [1.0, 1.0, 0.0, 1.0],
    [1.0, -1.0, 0.0, 1.0],
];

/// The draw of `RelinkFailure` and `LinkFailure`: a strip from attribute 0, then clear and release everything
fn draw_strip_and_clear(gl: &glw::Functions) {
    let mut vao: GLuint = 0;
    let mut vbuf: GLuint = 0;
    gl!(gl.gen_vertex_arrays(1, &mut vao));
    gl!(gl.bind_vertex_array(vao));
    gl!(gl.gen_buffers(1, &mut vbuf));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbuf));
    gl!(gl.buffer_data(
        glw::GL_ARRAY_BUFFER,
        std::mem::size_of_val(&STRIP_VERTICES) as isize,
        STRIP_VERTICES.as_ptr().cast(),
        glw::GL_STATIC_DRAW
    ));
    gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, 0, 16, std::ptr::null()));
    gl!(gl.enable_vertex_attrib_array(0));
    gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
    gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT));
    gl!(gl.disable_vertex_attrib_array(0));
    gl!(gl.delete_vertex_arrays(1, &vao));
    gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
    gl!(gl.delete_buffers(1, &vbuf));
}

fn transform_feedback_varyings_qz(gl: &glw::Functions, program: GLuint) {
    let varyings = [c"q".as_ptr(), c"z".as_ptr()];
    gl!(gl.transform_feedback_varyings(program, 2, varyings.as_ptr(), glw::GL_INTERLEAVED_ATTRIBS));
}

/// `RelinkFailure`
struct RelinkFailure;

impl Subcase for RelinkFailure {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let vertex_shader = "#version 430\nin vec4 position;\nin vec3 pos;\nvoid main(void)\n{\n    gl_Position = position + vec4(pos, 1);\n}";
        let program = create_program(gl, Some(vertex_shader), Some(SIMPLE_FRAGMENT_SHADER), false);
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        gl!(gl.bind_attrib_location(program, 1, c"pos".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_INPUT, "pos", 1, &mut error);

        gl!(gl.use_program(program));
        draw_strip_and_clear(gl);

        gl!(gl.bind_attrib_location(program, 0, c"pos".as_ptr()));
        gl!(gl.bind_attrib_location(program, 0, c"position".as_ptr()));
        transform_feedback_varyings_qz(gl, program);
        link_program(gl, program);

        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_INPUT, "position", -1, &mut error);
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_INPUT, "pos", -1, &mut error);
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);
        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_OUTPUT, "color", -1, &mut error);
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `LinkFailure`
struct LinkFailure;

impl Subcase for LinkFailure {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let src_vs =
            c_string("#version 430\nin vec4 posit;\nin vec4 p;\nvoid main(void)\n{\n    gl_Position = p + posit;\n}");
        let src_fs = c_string("#version 430\nout vec4 color;\nvoid main() {\n    color = vec4(0, 1, 0, 1);\n}");
        let src_vsh = c_string("#version 430\nin vec4 position;\nvoid main(void)\n{\n    gl_Position = position;\n}");

        let program = gl!(gl.create_program());

        let compile_attached = |shader_type: GLenum, source: &CString| -> GLuint {
            let shader = gl!(gl.create_shader(shader_type));
            gl!(gl.attach_shader(program, shader));
            gl!(gl.delete_shader(shader));
            let pointer = source.as_ptr();
            gl!(gl.shader_source(shader, 1, &pointer, std::ptr::null()));
            gl!(gl.compile_shader(shader));
            shader
        };
        let sh1 = compile_attached(glw::GL_VERTEX_SHADER, &src_vs);
        compile_attached(glw::GL_FRAGMENT_SHADER, &src_fs);

        gl!(gl.bind_attrib_location(program, 0, c"p".as_ptr()));
        gl!(gl.bind_attrib_location(program, 1, c"posit".as_ptr()));
        gl!(gl.bind_frag_data_location(program, 0, c"color".as_ptr()));
        link_program(gl, program);

        let mut error = NO_ERROR;
        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_INPUT, "posit", 1, &mut error);

        gl!(gl.use_program(program));
        draw_strip_and_clear(gl);

        gl!(gl.detach_shader(program, sh1));
        compile_attached(glw::GL_VERTEX_SHADER, &src_vsh);

        transform_feedback_varyings_qz(gl, program);
        link_program(gl, program);

        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_INPUT, "position", -1, &mut error);
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);

        let mut res: GLint = 0;
        gl!(gl.get_program_interfaceiv(program, glw::GL_PROGRAM_INPUT, glw::GL_ACTIVE_RESOURCES, &mut res));
        if res != 0 && res != 1 {
            log::info!("Error, expected 0 or 1 active resources, got: {res}");
            error = ERROR;
        }

        gl!(gl.get_program_interfaceiv(program, glw::GL_PROGRAM_INPUT, glw::GL_MAX_NAME_LENGTH, &mut res));
        if res != 0 && res != 9 {
            log::info!("Error, expected 1 or 9 GL_MAX_NAME_LENGTH, got: {res}");
            error = ERROR;
        }

        verify_get_program_resource_location(gl, program, glw::GL_PROGRAM_OUTPUT, "color", -1, &mut error);
        expect_error(gl, glw::GL_INVALID_OPERATION, &mut error);

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// `ShaderStorageBlock`
struct ShaderStorageBlock;

impl ShaderStorageBlock {
    fn fragment_shader() -> &'static str {
        "#version 430\nstruct U {\n   bool a[3];\n   mediump vec4 b;\n   mediump mat3 c;\n   mediump float d[2];\n};\nstruct UU {\n   U a;\n   U b[2];\n   uvec2 c;\n};\nlayout(binding=4) buffer TrickyBuffer {\n   UU a[3];\n   mediump mat4 b;\n   uint c;\n} e[2];\nlayout(binding = 0) buffer SimpleBuffer {\n   mediump mat3x2 a;\n   mediump mat4 b;\n   mediump vec4 c;\n};\nlayout(binding = 1) buffer NotSoSimpleBuffer {\n   ivec2 a[4];\n   mediump mat3 b[2];\n   mediump mat2 c;\n} d;\nout mediump vec4 color;\nvoid main() {\n    mediump float tmp;\n    mediump float tmp2;\n    tmp = e[0].a[0].b[0].d[0] * float(e[1].c);\n    tmp2 = a[0][0] * b[0][0] * c.x;\n    tmp2 = tmp2 + float(d.a[0].y) + d.b[0][0][0] + d.c[0][0];\n    color = vec4(0, 1, 0, 1) * tmp * tmp2;\n}"
    }

    /// The two active variable checks of `Run`: every index must be one of `expected` and there must be three of them. Err carries the verdict `Run` returns on the spot.
    fn check_active_variables(
        gl: &glw::Functions,
        program: GLuint,
        block: GLuint,
        expected: &[GLuint],
        owner: &str,
    ) -> Result<(), i64> {
        let prop = glw::GL_ACTIVE_VARIABLES;
        const BUF_SIZE: usize = 1000;
        let mut length: i32 = 0;
        let mut param = [0 as GLint; BUF_SIZE];
        gl!(gl.get_program_resourceiv(
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            block,
            1,
            &prop,
            BUF_SIZE as i32,
            &mut length,
            param.as_mut_ptr()
        ));
        for &value in &param[..length.max(0) as usize] {
            if !expected.contains(&(value as GLuint)) {
                log::info!(
                    "Unexpected index found in active variables of {owner}: {value}\nCall: glGetProgramResourceiv, property: GL_ACTIVE_VARIABLES interface: GL_SHADER_STORAGE_BLOCK"
                );
                return Err(ERROR);
            } else if length != 3 {
                log::info!(
                    "Call: glGetProgramResourceiv, property: GL_ACTIVE_VARIABLES interface: GL_SHADER_STORAGE_BLOCK\nExpected length: 3, actual length: {length}"
                );
                return Err(ERROR);
            }
        }
        Ok(())
    }
}

impl Subcase for ShaderStorageBlock {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        let program = linked_program(gl, SIMPLE_VERTEX_SHADER, Self::fragment_shader());

        let mut error = NO_ERROR;
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            glw::GL_MAX_NAME_LENGTH,
            28,
            &mut error,
        );
        let mut res: GLint = 0;
        gl!(gl.get_program_interfaceiv(program, glw::GL_BUFFER_VARIABLE, glw::GL_ACTIVE_RESOURCES, &mut res));
        if res < 7 {
            log::info!(
                "Error on: glGetProgramInterfaceiv, if: GL_BUFFER_VARIABLE, param: GL_ACTIVE_RESOURCES\nExpected value greater or equal to 7, got {res}"
            );
            error = ERROR;
        }
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_ACTIVE_RESOURCES,
            4,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_MAX_NAME_LENGTH,
            18,
            &mut error,
        );

        let mut indices_ssb: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_bv: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["SimpleBuffer", "NotSoSimpleBuffer", "TrickyBuffer", "TrickyBuffer[1]"] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_SHADER_STORAGE_BLOCK,
                &mut indices_ssb,
                name,
                &mut error,
            );
        }
        for name in [
            "a",
            "b",
            "c",
            "NotSoSimpleBuffer.a[0]",
            "NotSoSimpleBuffer.c",
            "NotSoSimpleBuffer.b[0]",
            "TrickyBuffer.a[0].b[0].d",
            "TrickyBuffer.b",
            "TrickyBuffer.c",
        ] {
            verify_get_program_resource_index_unique(
                gl,
                program,
                glw::GL_BUFFER_VARIABLE,
                &mut indices_bv,
                name,
                &mut error,
            );
        }

        let ssb = |name: &str| index_of(&indices_ssb, name);
        let bv = |name: &str| index_of(&indices_bv, name);

        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            ssb("SimpleBuffer"),
            "SimpleBuffer",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            ssb("NotSoSimpleBuffer"),
            "NotSoSimpleBuffer",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            ssb("TrickyBuffer"),
            "TrickyBuffer[0]",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            ssb("TrickyBuffer[1]"),
            "TrickyBuffer[1]",
            &mut error,
        );
        verify_get_program_resource_name(gl, program, glw::GL_BUFFER_VARIABLE, bv("a"), "a", &mut error);
        verify_get_program_resource_name(gl, program, glw::GL_BUFFER_VARIABLE, bv("b"), "b", &mut error);
        verify_get_program_resource_name(gl, program, glw::GL_BUFFER_VARIABLE, bv("c"), "c", &mut error);
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            bv("NotSoSimpleBuffer.a[0]"),
            "NotSoSimpleBuffer.a[0]",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            bv("NotSoSimpleBuffer.c"),
            "NotSoSimpleBuffer.c",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            bv("NotSoSimpleBuffer.b[0]"),
            "NotSoSimpleBuffer.b[0]",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            bv("TrickyBuffer.a[0].b[0].d"),
            "TrickyBuffer.a[0].b[0].d[0]",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            bv("TrickyBuffer.b"),
            "TrickyBuffer.b",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            bv("TrickyBuffer.c"),
            "TrickyBuffer.c",
            &mut error,
        );

        let props = [
            glw::GL_NAME_LENGTH,
            glw::GL_BUFFER_BINDING,
            glw::GL_NUM_ACTIVE_VARIABLES,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
            glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
            glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
        ];
        let expected = [13, 0, 3, 0, 1, 0, 0, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            ssb("SimpleBuffer"),
            &props,
            9,
            &expected,
            &mut error,
        );

        let props2 = [
            glw::GL_NAME_LENGTH,
            glw::GL_BUFFER_BINDING,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
            glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
            glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
        ];
        let expected2 = [18, 1, 0, 1, 0, 0, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            ssb("NotSoSimpleBuffer"),
            &props2,
            8,
            &expected2,
            &mut error,
        );
        let expected3 = [16, 4, 0, 1, 0, 0, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            ssb("TrickyBuffer"),
            &props2,
            8,
            &expected3,
            &mut error,
        );
        let expected4 = [16, 5, 0, 1, 0, 0, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            ssb("TrickyBuffer[1]"),
            &props2,
            8,
            &expected4,
            &mut error,
        );

        let props3 = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_BLOCK_INDEX,
            glw::GL_ARRAY_STRIDE,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
            glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
            glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_TOP_LEVEL_ARRAY_SIZE,
            glw::GL_TOP_LEVEL_ARRAY_STRIDE,
        ];
        let expected5 = [
            2,
            glw::GL_FLOAT_MAT3x2 as GLint,
            1,
            ssb("SimpleBuffer") as GLint,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
        ];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            bv("a"),
            &props3,
            14,
            &expected5,
            &mut error,
        );

        let props4 = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_BLOCK_INDEX,
            glw::GL_MATRIX_STRIDE,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
            glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
            glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_TOP_LEVEL_ARRAY_SIZE,
        ];
        let expected6 = [
            28,
            glw::GL_FLOAT as GLint,
            2,
            ssb("TrickyBuffer") as GLint,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            3,
        ];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            bv("TrickyBuffer.a[0].b[0].d"),
            &props4,
            13,
            &expected6,
            &mut error,
        );

        let exp = [bv("a"), bv("b"), bv("c")];
        if let Err(verdict) = Self::check_active_variables(gl, program, ssb("SimpleBuffer"), &exp, "SimpleBuffer") {
            gl!(gl.delete_program(program));
            return Ok(verdict);
        }
        let exp2 = [
            bv("NotSoSimpleBuffer.a[0]"),
            bv("NotSoSimpleBuffer.b[0]"),
            bv("NotSoSimpleBuffer.c"),
        ];
        if let Err(verdict) =
            Self::check_active_variables(gl, program, ssb("NotSoSimpleBuffer"), &exp2, "NotSoSimpleBuffer")
        {
            gl!(gl.delete_program(program));
            return Ok(verdict);
        }

        gl!(gl.get_program_interfaceiv(
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_MAX_NUM_ACTIVE_VARIABLES,
            &mut res
        ));
        if res < 3 {
            log::info!(
                "Value of GL_MAX_NUM_ACTIVE_VARIABLES less than 3!\nCall: glGetProgramInterfaceiv, interface: GL_SHADER_STORAGE_BLOCK"
            );
            return Ok(ERROR);
        }

        gl!(gl.delete_program(program));
        Ok(error)
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

/// The six `GL_REFERENCED_BY_*_SHADER` properties, in the order the `SeparatePrograms*` property lists have them
const REFERENCED_BY: [GLenum; 6] = [
    glw::GL_REFERENCED_BY_COMPUTE_SHADER,
    glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
    glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
    glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
    glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
    glw::GL_REFERENCED_BY_VERTEX_SHADER,
];

/// `NAME_LENGTH, TYPE, ARRAY_SIZE`, the six referenced-by properties and then `tail`
fn props_with_referenced_by(tail: &[GLenum]) -> Vec<GLenum> {
    let mut props = vec![glw::GL_NAME_LENGTH, glw::GL_TYPE, glw::GL_ARRAY_SIZE];
    props.extend(REFERENCED_BY);
    props.extend_from_slice(tail);
    props
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum SeparateStage {
    Vertex,
    TessControl,
    TessEval,
    Geometry,
    Fragment,
}

/// `SeparateProgramsVertex` and the four classes derived from it
struct SeparatePrograms {
    stage: SeparateStage,
}

/// `SeparateProgramsVertex::CreateShaderProgram`
fn create_shader_program(gl: &glw::Functions, shader_type: GLenum, source: &str) -> GLuint {
    let source = c_string(source);
    let pointer = source.as_ptr();
    let program = gl!(gl.create_shader_programv(shader_type, 1, &pointer));
    let status = get_program_value(gl, program, glw::GL_LINK_STATUS);
    if status == glw::GL_FALSE as GLint {
        let mut length = 0;
        let mut info_log = [0u8; 1024];
        gl!(gl.get_program_info_log(
            program,
            info_log.len() as i32,
            &mut length,
            info_log.as_mut_ptr().cast()
        ));
        if length > 1 {
            log::info!("Program Info Log:\n{}", log_to_string(&info_log));
        }
    }
    program
}

impl SeparatePrograms {
    fn run_vertex(gl: &glw::Functions) -> i64 {
        let mut error = NO_ERROR;
        let src_vs = "#version 430 core\nlayout(location = 0) in vec4 in_vertex;\nout Color {\n  float r, g, b;\n  vec4 iLikePie;\n} vs_color;\nout gl_PerVertex {\n  vec4 gl_Position;\n};\nuniform float u;\nuniform vec4 v;\nvoid main() {\n  gl_Position = in_vertex;\n  vs_color.r = u;\n  vs_color.g = 0.0;\n  vs_color.b = 0.0;\n  vs_color.iLikePie = v;\n}";
        let vs = create_shader_program(gl, glw::GL_VERTEX_SHADER, src_vs);
        verify_get_program_interfaceiv(gl, vs, glw::GL_UNIFORM, glw::GL_MAX_NAME_LENGTH, 2, &mut error);
        verify_get_program_interfaceiv(gl, vs, glw::GL_UNIFORM, glw::GL_ACTIVE_RESOURCES, 2, &mut error);
        verify_get_program_interfaceiv(gl, vs, glw::GL_PROGRAM_INPUT, glw::GL_MAX_NAME_LENGTH, 10, &mut error);
        verify_get_program_interfaceiv(gl, vs, glw::GL_PROGRAM_INPUT, glw::GL_ACTIVE_RESOURCES, 1, &mut error);
        verify_get_program_interfaceiv(gl, vs, glw::GL_PROGRAM_OUTPUT, glw::GL_MAX_NAME_LENGTH, 15, &mut error);
        verify_get_program_interfaceiv(gl, vs, glw::GL_PROGRAM_OUTPUT, glw::GL_ACTIVE_RESOURCES, 5, &mut error);

        let mut indices_u: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_i: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_o: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(gl, vs, glw::GL_UNIFORM, &mut indices_u, "u", &mut error);
        verify_get_program_resource_index_unique(gl, vs, glw::GL_UNIFORM, &mut indices_u, "v", &mut error);
        verify_get_program_resource_index_unique(
            gl,
            vs,
            glw::GL_PROGRAM_INPUT,
            &mut indices_i,
            "in_vertex",
            &mut error,
        );
        let outputs = ["Color.r", "Color.g", "Color.b", "Color.iLikePie", "gl_Position"];
        for name in outputs {
            verify_get_program_resource_index_unique(gl, vs, glw::GL_PROGRAM_OUTPUT, &mut indices_o, name, &mut error);
        }

        verify_get_program_resource_name(gl, vs, glw::GL_UNIFORM, index_of(&indices_u, "u"), "u", &mut error);
        verify_get_program_resource_name(gl, vs, glw::GL_UNIFORM, index_of(&indices_u, "v"), "v", &mut error);
        verify_get_program_resource_name(
            gl,
            vs,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "in_vertex"),
            "in_vertex",
            &mut error,
        );
        for name in outputs {
            verify_get_program_resource_name(
                gl,
                vs,
                glw::GL_PROGRAM_OUTPUT,
                index_of(&indices_o, name),
                name,
                &mut error,
            );
        }

        let u_location = get_uniform_location(gl, vs, "u");
        let v_location = get_uniform_location(gl, vs, "v");
        verify_get_program_resource_location(gl, vs, glw::GL_UNIFORM, "u", u_location, &mut error);
        verify_get_program_resource_location(gl, vs, glw::GL_UNIFORM, "v", v_location, &mut error);
        verify_get_program_resource_location(gl, vs, glw::GL_PROGRAM_INPUT, "in_vertex", 0, &mut error);
        for name in outputs {
            verify_get_program_resource_location_index(gl, vs, glw::GL_PROGRAM_OUTPUT, name, -1, &mut error);
        }

        let float_vec4 = glw::GL_FLOAT_VEC4 as GLint;
        let props = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_OFFSET,
            glw::GL_BLOCK_INDEX,
            glw::GL_ARRAY_STRIDE,
            glw::GL_MATRIX_STRIDE,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_ATOMIC_COUNTER_BUFFER_INDEX,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_GEOMETRY_SHADER,
            glw::GL_REFERENCED_BY_TESS_CONTROL_SHADER,
            glw::GL_REFERENCED_BY_TESS_EVALUATION_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_LOCATION,
        ];
        let expected = [2, float_vec4, 1, -1, -1, -1, -1, 0, -1, 0, 0, 0, 0, 0, 1, v_location];
        verify_get_program_resourceiv(
            gl,
            vs,
            glw::GL_UNIFORM,
            index_of(&indices_u, "v"),
            &props,
            16,
            &expected,
            &mut error,
        );

        let props2 = props_with_referenced_by(&[glw::GL_LOCATION, glw::GL_IS_PER_PATCH]);
        let expected2 = [10, float_vec4, 1, 0, 0, 0, 0, 0, 1, 0, 0];
        verify_get_program_resourceiv(
            gl,
            vs,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "in_vertex"),
            &props2,
            11,
            &expected2,
            &mut error,
        );

        let props3 = props_with_referenced_by(&[glw::GL_IS_PER_PATCH, glw::GL_LOCATION_INDEX]);
        let expected3 = [15, float_vec4, 1, 0, 0, 0, 0, 0, 1, 0, -1];
        verify_get_program_resourceiv(
            gl,
            vs,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "Color.iLikePie"),
            &props3,
            11,
            &expected3,
            &mut error,
        );

        gl!(gl.delete_program(vs));
        error
    }

    fn run_tess_control(gl: &glw::Functions) -> i64 {
        let mut error = NO_ERROR;
        let src_tcs = "#version 430\nlayout(vertices = 3) out;\nlayout(location = 0) patch out vec4 data;\nout gl_PerVertex {\n   vec4 gl_Position;\n   float gl_PointSize;\n   float gl_ClipDistance[];\n} gl_out[];\nin Color {\n  float r, g, b;\n  vec4 iLikePie;\n} vs_color[];\nvoid main() {\n   data = vec4(1);\n   gl_out[gl_InvocationID].gl_Position =\n           vec4(vs_color[0].r, vs_color[0].g, vs_color[0].b, vs_color[0].iLikePie.x + float(gl_InvocationID));\n   gl_TessLevelInner[0] = 1.0;\n   gl_TessLevelInner[1] = 1.0;\n   gl_TessLevelOuter[0] = 1.0;\n   gl_TessLevelOuter[1] = 1.0;\n   gl_TessLevelOuter[2] = 1.0;\n}";
        let tcs = create_shader_program(gl, glw::GL_TESS_CONTROL_SHADER, src_tcs);

        // gl_InvocationID should be included
        verify_get_program_interfaceiv(gl, tcs, glw::GL_PROGRAM_INPUT, glw::GL_MAX_NAME_LENGTH, 16, &mut error);
        verify_get_program_interfaceiv(gl, tcs, glw::GL_PROGRAM_INPUT, glw::GL_ACTIVE_RESOURCES, 5, &mut error);

        let mut indices_i: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_o: BTreeMap<String, GLuint> = BTreeMap::new();
        for name in ["gl_PerVertex.gl_Position", "data"] {
            verify_get_program_resource_index_unique(gl, tcs, glw::GL_PROGRAM_OUTPUT, &mut indices_o, name, &mut error);
        }
        let inputs = ["Color.r", "Color.g", "Color.b", "Color.iLikePie"];
        for name in inputs {
            verify_get_program_resource_index_unique(gl, tcs, glw::GL_PROGRAM_INPUT, &mut indices_i, name, &mut error);
        }

        for name in ["gl_PerVertex.gl_Position", "data"] {
            verify_get_program_resource_name(
                gl,
                tcs,
                glw::GL_PROGRAM_OUTPUT,
                index_of(&indices_o, name),
                name,
                &mut error,
            );
        }
        for name in inputs {
            verify_get_program_resource_name(
                gl,
                tcs,
                glw::GL_PROGRAM_INPUT,
                index_of(&indices_i, name),
                name,
                &mut error,
            );
        }

        let float_vec4 = glw::GL_FLOAT_VEC4 as GLint;
        let props2 = props_with_referenced_by(&[glw::GL_IS_PER_PATCH]);
        let expected2 = [15, float_vec4, 1, 0, 0, 0, 1, 0, 0, 0];
        verify_get_program_resourceiv(
            gl,
            tcs,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "Color.iLikePie"),
            &props2,
            10,
            &expected2,
            &mut error,
        );

        let props3 = props_with_referenced_by(&[glw::GL_IS_PER_PATCH, glw::GL_LOCATION, glw::GL_LOCATION_INDEX]);
        let expected3 = [5, float_vec4, 1, 0, 0, 0, 1, 0, 0, 1, 0, -1];
        verify_get_program_resourceiv(
            gl,
            tcs,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "data"),
            &props3,
            12,
            &expected3,
            &mut error,
        );

        gl!(gl.delete_program(tcs));
        error
    }

    /// `SeparateProgramsTessEval` and `SeparateProgramsGeometry`, which differ in the shader, its stage and the referenced-by flags
    fn run_per_vertex_position(
        gl: &glw::Functions,
        shader_type: GLenum,
        source: &str,
        referenced_by: [GLint; 6],
        input_length: GLint,
    ) -> i64 {
        let mut error = NO_ERROR;
        let program = create_shader_program(gl, shader_type, source);

        let mut indices_i: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_o: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            &mut indices_i,
            "gl_PerVertex.gl_Position",
            &mut error,
        );
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            &mut indices_o,
            "gl_Position",
            &mut error,
        );

        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "gl_PerVertex.gl_Position"),
            "gl_PerVertex.gl_Position",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "gl_Position"),
            "gl_Position",
            &mut error,
        );

        let float_vec4 = glw::GL_FLOAT_VEC4 as GLint;
        let props2 = props_with_referenced_by(&[glw::GL_IS_PER_PATCH]);
        let mut expected2 = vec![input_length, float_vec4, 1];
        expected2.extend(referenced_by);
        expected2.push(0);
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "gl_PerVertex.gl_Position"),
            &props2,
            10,
            &expected2,
            &mut error,
        );

        let props3 = props_with_referenced_by(&[glw::GL_IS_PER_PATCH, glw::GL_LOCATION_INDEX]);
        let mut expected3 = vec![12, float_vec4, 1];
        expected3.extend(referenced_by);
        expected3.extend([0, -1]);
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "gl_Position"),
            &props3,
            11,
            &expected3,
            &mut error,
        );

        gl!(gl.delete_program(program));
        error
    }

    fn run_fragment(gl: &glw::Functions) -> i64 {
        let mut error = NO_ERROR;
        let src_fs = "#version 430\nout vec4 fs_color;\nlayout(location = 1) uniform vec4 x;\nlayout(binding = 0) buffer SimpleBuffer {\n   vec4 a;\n};\nin vec4 vs_color;\nvoid main() {\n   fs_color = vs_color + x + a;\n}";
        let program = create_shader_program(gl, glw::GL_FRAGMENT_SHADER, src_fs);

        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_MAX_NAME_LENGTH,
            9,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_MAX_NAME_LENGTH,
            9,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(gl, program, glw::GL_UNIFORM, glw::GL_MAX_NAME_LENGTH, 2, &mut error);
        verify_get_program_interfaceiv(gl, program, glw::GL_UNIFORM, glw::GL_ACTIVE_RESOURCES, 1, &mut error);
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            glw::GL_MAX_NAME_LENGTH,
            2,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_ACTIVE_RESOURCES,
            1,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_MAX_NAME_LENGTH,
            13,
            &mut error,
        );
        verify_get_program_interfaceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_MAX_NUM_ACTIVE_VARIABLES,
            1,
            &mut error,
        );

        let mut indices_ssb: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_bv: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_i: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_o: BTreeMap<String, GLuint> = BTreeMap::new();
        let mut indices_u: BTreeMap<String, GLuint> = BTreeMap::new();
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            &mut indices_i,
            "vs_color",
            &mut error,
        );
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            &mut indices_o,
            "fs_color",
            &mut error,
        );
        verify_get_program_resource_index_unique(gl, program, glw::GL_UNIFORM, &mut indices_u, "x", &mut error);
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            &mut indices_ssb,
            "SimpleBuffer",
            &mut error,
        );
        verify_get_program_resource_index_unique(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            &mut indices_bv,
            "a",
            &mut error,
        );

        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            index_of(&indices_ssb, "SimpleBuffer"),
            "SimpleBuffer",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            index_of(&indices_bv, "a"),
            "a",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "vs_color"),
            "vs_color",
            &mut error,
        );
        verify_get_program_resource_name(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "fs_color"),
            "fs_color",
            &mut error,
        );
        verify_get_program_resource_name(gl, program, glw::GL_UNIFORM, index_of(&indices_u, "x"), "x", &mut error);

        verify_get_program_resource_location(gl, program, glw::GL_UNIFORM, "x", 1, &mut error);

        let float_vec4 = glw::GL_FLOAT_VEC4 as GLint;
        let props2 = props_with_referenced_by(&[glw::GL_IS_PER_PATCH]);
        let expected2 = [9, float_vec4, 1, 0, 1, 0, 0, 0, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_INPUT,
            index_of(&indices_i, "vs_color"),
            &props2,
            10,
            &expected2,
            &mut error,
        );

        let props3 = props_with_referenced_by(&[glw::GL_IS_PER_PATCH, glw::GL_LOCATION_INDEX]);
        let expected3 = [9, float_vec4, 1, 0, 1, 0, 0, 0, 0, 0, 0];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_PROGRAM_OUTPUT,
            index_of(&indices_o, "fs_color"),
            &props3,
            11,
            &expected3,
            &mut error,
        );

        let props5 = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_OFFSET,
            glw::GL_BLOCK_INDEX,
            glw::GL_ARRAY_STRIDE,
            glw::GL_MATRIX_STRIDE,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_ATOMIC_COUNTER_BUFFER_INDEX,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_LOCATION,
        ];
        let expected5 = [2, float_vec4, 1, -1, -1, -1, -1, 0, -1, 0, 1, 0, 1];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_UNIFORM,
            index_of(&indices_u, "x"),
            &props5,
            13,
            &expected5,
            &mut error,
        );

        let props6 = [
            glw::GL_NAME_LENGTH,
            glw::GL_BUFFER_BINDING,
            glw::GL_NUM_ACTIVE_VARIABLES,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_ACTIVE_VARIABLES,
        ];
        let expected6 = [13, 0, 1, 0, 1, 0, index_of(&indices_bv, "a") as GLint];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            index_of(&indices_ssb, "SimpleBuffer"),
            &props6,
            7,
            &expected6,
            &mut error,
        );

        let props7 = [
            glw::GL_NAME_LENGTH,
            glw::GL_TYPE,
            glw::GL_ARRAY_SIZE,
            glw::GL_BLOCK_INDEX,
            glw::GL_ARRAY_STRIDE,
            glw::GL_IS_ROW_MAJOR,
            glw::GL_REFERENCED_BY_COMPUTE_SHADER,
            glw::GL_REFERENCED_BY_FRAGMENT_SHADER,
            glw::GL_REFERENCED_BY_VERTEX_SHADER,
            glw::GL_TOP_LEVEL_ARRAY_SIZE,
            glw::GL_TOP_LEVEL_ARRAY_STRIDE,
        ];
        let expected7 = [
            2,
            float_vec4,
            1,
            index_of(&indices_ssb, "SimpleBuffer") as GLint,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
        ];
        verify_get_program_resourceiv(
            gl,
            program,
            glw::GL_BUFFER_VARIABLE,
            index_of(&indices_bv, "a"),
            &props7,
            11,
            &expected7,
            &mut error,
        );

        gl!(gl.delete_program(program));
        error
    }
}

impl Subcase for SeparatePrograms {
    fn run(&mut self, context: &Context) -> SubcaseResult {
        let gl = context.gl();
        Ok(match self.stage {
            SeparateStage::Vertex => Self::run_vertex(gl),
            SeparateStage::TessControl => Self::run_tess_control(gl),
            SeparateStage::TessEval => {
                let source = "#version 430\nlayout(quads, equal_spacing, ccw) in;\nout gl_PerVertex {\n   vec4 gl_Position;\n   float gl_PointSize;\n   float gl_ClipDistance[];\n};\nin gl_PerVertex {\n   vec4 gl_Position;\n   float gl_PointSize;\n   float gl_ClipDistance[];\n} gl_in[];\nvoid main() {\n   vec4 p0 = gl_in[0].gl_Position;\n   vec4 p1 = gl_in[1].gl_Position;\n   vec4 p2 = gl_in[2].gl_Position;\n   gl_Position = vec4(p0.x, p1.y, p2.z, p0.x);\n}";
                // referenced by: compute, fragment, geometry, tess control, tess evaluation, vertex
                Self::run_per_vertex_position(gl, glw::GL_TESS_EVALUATION_SHADER, source, [0, 0, 0, 0, 1, 0], 25)
            }
            SeparateStage::Geometry => {
                let source = "#version 430\nlayout(triangles) in;\nlayout(triangle_strip, max_vertices = 4) out;\nout gl_PerVertex {\n   vec4 gl_Position;\n   float gl_PointSize;\n   float gl_ClipDistance[];\n};\nin gl_PerVertex {\n   vec4 gl_Position;\n   float gl_PointSize;\n   float gl_ClipDistance[];\n} gl_in[];\nvoid main() {\n   gl_Position = vec4(-1, 1, 0, 1);\n   EmitVertex();\n   gl_Position = vec4(-1, -1, 0, 1);\n   EmitVertex();\n   gl_Position = vec4(1, 1, 0, 1);\n   EmitVertex();\n   gl_Position = gl_in[0].gl_Position;\n   EmitVertex();\n   EndPrimitive();\n}";
                Self::run_per_vertex_position(gl, glw::GL_GEOMETRY_SHADER, source, [0, 0, 1, 0, 0, 0], 25)
            }
            SeparateStage::Fragment => Self::run_fragment(gl),
        })
    }

    fn cleanup(&mut self, context: &Context) -> SubcaseResult {
        cleanup_use_program(context)
    }
}

fn add_case<F: Fn() -> Box<dyn Subcase> + Send + Sync + 'static>(group: &mut TestCaseGroup, name: &str, factory: F) {
    group.add_child(Box::new(TestSubcase::new(name, factory)) as Box<dyn TestCase>);
}

/// `ProgramInterfaceQueryTests::init`; all 43 cases are ported.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("program_interface_query");
    add_case(&mut group, "empty-shaders", || Box::new(NoShaders));
    add_case(&mut group, "simple-shaders", || Box::new(SimpleShaders));
    add_case(&mut group, "input-types", || {
        Box::new(InputTypes {
            layout_qualifiers: false,
        })
    });
    add_case(&mut group, "input-built-in", || Box::new(InputBuiltIn));
    add_case(&mut group, "input-layout", || {
        Box::new(InputTypes {
            layout_qualifiers: true,
        })
    });
    add_case(&mut group, "output-types", || {
        Box::new(OutputTypes {
            layout_qualifiers: false,
        })
    });
    add_case(&mut group, "output-location-index", || Box::new(OutputLocationIndex));
    add_case(&mut group, "output-built-in", || Box::new(OutputBuiltIn));
    add_case(&mut group, "output-layout", || {
        Box::new(OutputTypes {
            layout_qualifiers: true,
        })
    });
    add_case(&mut group, "output-layout-index", || Box::new(OutputLayoutIndex));
    add_case(&mut group, "uniform-simple", || Box::new(UniformSimple));
    add_case(&mut group, "uniform-types", || Box::new(UniformTypes));
    add_case(&mut group, "uniform-block-types", || Box::new(UniformBlockTypes));
    add_case(&mut group, "transform-feedback-types", || {
        Box::new(TransformFeedbackTypes)
    });
    add_case(&mut group, "atomic-counters", || Box::new(AtomicCounterSimple));
    add_case(&mut group, "subroutines-vertex", || {
        Box::new(Subroutines {
            stage: SubroutineStage::Vertex,
        })
    });
    add_case(&mut group, "subroutines-tess-control", || {
        Box::new(Subroutines {
            stage: SubroutineStage::TessControl,
        })
    });
    add_case(&mut group, "subroutines-tess-eval", || {
        Box::new(Subroutines {
            stage: SubroutineStage::TessEval,
        })
    });
    add_case(&mut group, "subroutines-geometry", || {
        Box::new(Subroutines {
            stage: SubroutineStage::Geometry,
        })
    });
    add_case(&mut group, "subroutines-fragment", || {
        Box::new(Subroutines {
            stage: SubroutineStage::Fragment,
        })
    });
    add_case(&mut group, "subroutines-compute", || Box::new(SubroutinesCompute));
    add_case(&mut group, "ssb-types", || Box::new(ShaderStorageBlock));
    add_case(&mut group, "transform-feedback-built-in", || {
        Box::new(TransformFeedbackBuiltin)
    });
    add_case(&mut group, "null-length", || Box::new(NullLength));
    add_case(&mut group, "arrays-of-arrays", || Box::new(ArraysOfArrays));
    add_case(&mut group, "top-level-array", || Box::new(TopLevelArray));
    add_case(&mut group, "separate-programs-vertex", || {
        Box::new(SeparatePrograms {
            stage: SeparateStage::Vertex,
        })
    });
    add_case(&mut group, "separate-programs-tess-control", || {
        Box::new(SeparatePrograms {
            stage: SeparateStage::TessControl,
        })
    });
    add_case(&mut group, "separate-programs-tess-eval", || {
        Box::new(SeparatePrograms {
            stage: SeparateStage::TessEval,
        })
    });
    add_case(&mut group, "separate-programs-geometry", || {
        Box::new(SeparatePrograms {
            stage: SeparateStage::Geometry,
        })
    });
    add_case(&mut group, "separate-programs-fragment", || {
        Box::new(SeparatePrograms {
            stage: SeparateStage::Fragment,
        })
    });
    add_case(&mut group, "uniform-block", || Box::new(UniformBlockAdvanced));
    add_case(&mut group, "uniform-block-array", || Box::new(UniformBlockArray));
    add_case(&mut group, "array-names", || Box::new(ArrayNames));
    add_case(&mut group, "buff-length", || Box::new(BuffLength));
    add_case(&mut group, "no-locations", || Box::new(NoLocations));
    add_case(&mut group, "query-not-used", || Box::new(QueryNotUsed));
    add_case(&mut group, "relink-failure", || Box::new(RelinkFailure));
    add_case(&mut group, "link-failure", || Box::new(LinkFailure));
    add_case(&mut group, "compute-shader", || Box::new(ComputeShaderTest));
    add_case(&mut group, "invalid-value", || Box::new(InvalidValueTest));
    add_case(&mut group, "invalid-operation", || Box::new(InvalidOperationTest));
    add_case(&mut group, "invalid-enum", || Box::new(InvalidEnumTest));
    group
}
