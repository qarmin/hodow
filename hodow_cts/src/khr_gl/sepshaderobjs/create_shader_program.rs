// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gles31/es31cSeparateShaderObjsTests.cpp  (CreateShadProgCase)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::{create_shader_programv, fail, get_error, get_program};
use crate::glu::{self, Context, GlslVersion, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestOutcome, TestStatus};

/// `CreateShadProgCase`
pub(super) struct CreateShadProgCase {
    pub(super) glsl_version: GlslVersion,
}

/// `CreateShadProgCase::checkCSProg`: the program from glCreateShaderProgramv is valid, separable as expected and linked as expected.
fn check_cs_prog(gl: &glw::Functions, program: GLuint, expected_sep: GLint, expected_link: GLint) -> bool {
    let mut separable = glw::GL_FALSE as GLint;
    let mut linked = glw::GL_FALSE as GLint;

    if program != 0 {
        separable = get_program(gl, program, glw::GL_PROGRAM_SEPARABLE);
        linked = get_program(gl, program, glw::GL_LINK_STATUS);
    }

    program != 0 && separable == expected_sep && linked == expected_link
}

impl TestCase for CreateShadProgCase {
    fn name(&self) -> &str {
        "CreateShadProgApi"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let declaration = self.glsl_version.declaration();
        let per_vertex = "out gl_PerVertex {\n  vec4 gl_Position;\n};\n";
        let true_ = glw::GL_TRUE as GLint;
        let false_ = glw::GL_FALSE as GLint;

        log::info!("Begin:CreateShadProgCase iterate");

        let mut src_strings: Vec<&str> = vec![declaration, "\n"];
        if self.glsl_version >= GlslVersion::Glsl410 {
            src_strings.push(per_vertex);
        }
        src_strings.extend([
            "in vec4 a_position;\n",
            "void main ()\n",
            "{\n",
            "    gl_Position = a_position;\n",
            "}\n",
        ]);

        // SAFETY (all deletes below): plain object deletion with a current context.
        let mut program = create_shader_programv(gl, glw::GL_VERTEX_SHADER, src_strings.len() as i32, &src_strings);
        if !check_cs_prog(gl, program, true_, true_) {
            return fail("CreateShaderProgramv failed for vertex shader");
        }
        unsafe { gl.delete_program(program) };

        let mut src_strings: Vec<&str> = vec![declaration, "\n"];
        if self.glsl_version >= GlslVersion::Glsl410 {
            src_strings.push(per_vertex);
        }
        src_strings.extend([
            "in vec4 a_position;\nvoid main ()\n",
            "{\n    gl_Position = a_position;\n",
            "}\n",
        ]);

        program = create_shader_programv(gl, glw::GL_VERTEX_SHADER, src_strings.len() as i32, &src_strings);
        if !check_cs_prog(gl, program, true_, true_) {
            return fail("CreateShaderProgramv failed for vertex shader");
        }
        unsafe { gl.delete_program(program) };

        let mut src_strings: Vec<&str> = vec![
            declaration,
            "\nin highp vec4 u_color;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void main ()\n",
            "{\n",
            "    o_color = u_color;\n",
            "}\n",
        ];

        program = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, src_strings.len() as i32, &src_strings);
        if !check_cs_prog(gl, program, true_, true_) {
            return fail("CreateShaderProgramv failed for fragment shader");
        }
        unsafe { gl.delete_program(program) };

        glu::expect_no_error(gl, "CreateShaderProgramv failed")?;

        // invalid type
        program = create_shader_programv(
            gl,
            glw::GL_MAX_FRAGMENT_UNIFORM_VECTORS,
            src_strings.len() as i32,
            &src_strings,
        );
        let err = get_error(gl);
        if program != 0 || err != glw::GL_INVALID_ENUM {
            return fail("CreateShaderProgramv failed");
        }

        // Negative count
        program = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, -1, &src_strings);
        let err = get_error(gl);
        if program != 0 || err != glw::GL_INVALID_VALUE {
            return fail("CreateShaderProgramv failed");
        }

        // source compile error
        src_strings.pop();
        program = create_shader_programv(gl, glw::GL_FRAGMENT_SHADER, src_strings.len() as i32, &src_strings);

        // expect valid program and false for link status
        if !check_cs_prog(gl, program, false_, false_) {
            return fail("CreateShaderProgramv failed for fragment shader");
        }

        glu::expect_no_error(gl, "CreateShaderProgramv failed")?;

        unsafe { gl.delete_program(program) };

        Ok(TestStatus::pass("Pass"))
    }
}
