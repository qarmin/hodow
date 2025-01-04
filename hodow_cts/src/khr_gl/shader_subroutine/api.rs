// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (APITest1, APITest2)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::{ShaderStage, build_program, check_subroutine_support, fail, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLboolean, GLchar, GLdouble, GLfloat, GLint, GLsizei};
use crate::tcu::TestOutcome;

/// `APITest1`
pub(super) struct MinMaxes;

impl TestCase for MinMaxes {
    fn name(&self) -> &str {
        "min_maxes"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        let pnames = [
            (glw::GL_MAX_SUBROUTINES, "GL_MAX_SUBROUTINES", 256),
            (
                glw::GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS,
                "GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS",
                1024,
            ),
        ];

        for (pname, pname_string, min_value) in pnames {
            let mut bool_value = glw::GL_FALSE as GLboolean;
            let mut double_value: GLdouble = 0.0;
            let mut float_value: GLfloat = 0.0;
            let mut int_value: GLint = 0;

            gl_call!(
                gl,
                "glGetBooleanv() call failed.",
                gl.get_booleanv(pname, &mut bool_value)
            );
            gl_call!(
                gl,
                "glGetDoublev() call failed.",
                gl.get_doublev(pname, &mut double_value)
            );
            gl_call!(gl, "glGetFloatv() call failed.", gl.get_floatv(pname, &mut float_value));
            gl_call!(
                gl,
                "glGetIntegerv() call failed.",
                gl.get_integerv(pname, &mut int_value)
            );

            if int_value < min_value {
                log::info!(
                    "GL implementation reports a value of [{int_value}] for property [{pname_string}], whereas the min max for the property is [{min_value}]."
                );
                has_test_passed = false;
            }

            let epsilon = 1e-5;

            if (int_value == 0 && bool_value == glw::GL_TRUE as GLboolean)
                || (int_value != 0 && bool_value != glw::GL_TRUE as GLboolean)
            {
                log::info!(
                    "Invalid boolean value [{bool_value}] reported for property [{pname_string}] (int value:[{int_value}])"
                );
                has_test_passed = false;
            }

            if (double_value - int_value as f64).abs() > epsilon {
                log::info!(
                    "Invalid double value [{double_value}] reported for property [{pname_string}] (int value:[{int_value}])"
                );
                has_test_passed = false;
            }

            if (float_value - int_value as f32).abs() > epsilon as f32 {
                log::info!(
                    "Invalid float value [{float_value}] reported for property [{pname_string}] (int value:[{int_value}])"
                );
                has_test_passed = false;
            }
        }

        verdict(has_test_passed)
    }
}

const SUBROUTINE_NAME1: &str = "subroutine1";
const SUBROUTINE_NAME2: &str = "subroutine2";
const SUBROUTINE_UNIFORM_NAME: &str = "data_provider";

const NAME_GETTERS_VS: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine int ExampleSubroutineType(int example_argument);\n\nsubroutine(ExampleSubroutineType) int subroutine1(int example_argument)\n{\n    return 1;\n}\n\nsubroutine(ExampleSubroutineType) int subroutine2(int example_argument)\n{\n    return 2;\n}\n\nsubroutine uniform ExampleSubroutineType data_provider;\n\nvoid main()\n{\n    gl_Position = vec4(float(data_provider(0)), vec3(1) );\n}\n";

/// The bytes of a NUL-terminated `GLchar` buffer up to the terminator.
fn buffer_string(buffer: &[GLchar]) -> String {
    let bytes: Vec<u8> = buffer
        .iter()
        .take_while(|&&byte| byte != 0)
        .map(|&byte| byte as u8)
        .collect();
    String::from_utf8_lossy(&bytes).into_owned()
}

/// `APITest2`
pub(super) struct NameGetters;

impl TestCase for NameGetters {
    fn name(&self) -> &str {
        "name_getters"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        check_subroutine_support(context)?;

        let Some(program) = build_program(gl, &[(ShaderStage::Vertex, NAME_GETTERS_VS)], None)? else {
            return fail("Shader compilation or program linking failed.");
        };
        let po_id = program.program;

        let mut n_active_subroutines: GLint = 0;
        let mut n_active_subroutine_uniforms: GLint = 0;
        gl_call!(gl, "glGetProgramStageiv() call failed.", {
            gl.get_program_stageiv(
                po_id,
                glw::GL_VERTEX_SHADER,
                glw::GL_ACTIVE_SUBROUTINES,
                &mut n_active_subroutines,
            );
            gl.get_program_stageiv(
                po_id,
                glw::GL_VERTEX_SHADER,
                glw::GL_ACTIVE_SUBROUTINE_UNIFORMS,
                &mut n_active_subroutine_uniforms,
            );
        });

        if n_active_subroutines != 2 {
            log::info!("Invalid amount of active subroutines reported; expected: 2, reported:{n_active_subroutines}");
            return fail("Invalid GL_ACTIVE_SUBROUTINES property value.");
        }

        if n_active_subroutine_uniforms != 1 {
            log::info!(
                "Invalid amount of active subroutine uniforms reported: expected: 1, reported: {n_active_subroutine_uniforms}"
            );
            return fail("Invalid GL_ACTIVE_SUBROUTINE_UNIFORMS property value.");
        }

        let expected_length1 = SUBROUTINE_NAME1.len() as GLsizei + 1;
        let expected_length2 = SUBROUTINE_NAME1.len() as GLsizei + 1;
        let mut reported_length: GLsizei = 0;

        gl_call!(
            gl,
            "glGetActiveSubroutineName() call failed.",
            gl.get_active_subroutine_name(
                po_id,
                glw::GL_VERTEX_SHADER,
                0,
                0,
                std::ptr::null_mut(),
                std::ptr::null_mut()
            )
        );
        gl_call!(
            gl,
            "glGetActiveSubroutineName() call failed.",
            gl.get_program_interfaceiv(
                po_id,
                glw::GL_VERTEX_SUBROUTINE,
                glw::GL_MAX_NAME_LENGTH,
                &mut reported_length
            )
        );

        if reported_length != expected_length1 && reported_length != expected_length2 {
            log::info!(
                "Invalid active subroutine name length reported:{reported_length}, instead of: {expected_length1} or {expected_length2}"
            );
            return fail("Incorrect length of active subroutine name");
        }

        let mut buffer = vec![0 as GLchar; reported_length as usize];
        gl_call!(
            gl,
            "glGetActiveSubroutineName() call failed.",
            gl.get_active_subroutine_name(
                po_id,
                glw::GL_VERTEX_SHADER,
                0,
                reported_length,
                std::ptr::null_mut(),
                buffer.as_mut_ptr()
            )
        );

        let name = buffer_string(&buffer);
        if name != SUBROUTINE_NAME1 && name != SUBROUTINE_NAME2 {
            log::info!(
                "Invalid active subroutine name reported:[{name}] instead of:[{SUBROUTINE_NAME1}] or:[{SUBROUTINE_NAME2}]."
            );
            return fail("Invalid active subroutine name reported.");
        }

        let expected_length = SUBROUTINE_UNIFORM_NAME.len() as GLsizei;

        gl_call!(
            gl,
            "glGetActiveSubroutineUniformName() call failed.",
            gl.get_active_subroutine_uniform_name(
                po_id,
                glw::GL_VERTEX_SHADER,
                0,
                0,
                std::ptr::null_mut(),
                std::ptr::null_mut()
            )
        );
        gl_call!(
            gl,
            "glGetActiveSubroutineUniformName() call failed.",
            gl.get_active_subroutine_uniform_name(
                po_id,
                glw::GL_VERTEX_SHADER,
                0,
                0,
                &mut reported_length,
                std::ptr::null_mut()
            )
        );

        if reported_length != 0 {
            log::info!("Invalid active subroutine uniform name length reported:{reported_length}, instead of: 0");
            return fail("Incorrect length of active subroutine uniform name");
        }

        let mut buffer = vec![0 as GLchar; expected_length as usize + 1];
        gl_call!(
            gl,
            "getActiveSubroutineUniformName() call failed.",
            gl.get_active_subroutine_uniform_name(
                po_id,
                glw::GL_VERTEX_SHADER,
                0,
                expected_length + 1,
                &mut reported_length,
                buffer.as_mut_ptr()
            )
        );

        if reported_length != expected_length {
            log::info!(
                "Invalid active subroutine uniform name length reported:{reported_length}, instead of: {expected_length}"
            );
            return fail("Incorrect length of active subroutine uniform name");
        }

        let name = buffer_string(&buffer);
        if name != SUBROUTINE_UNIFORM_NAME {
            log::info!(
                "Invalid active subroutine uniform name reported:[{name}] instead of:[{SUBROUTINE_UNIFORM_NAME}]"
            );
            return fail("Invalid active subroutine uniform name reported.");
        }

        verdict(true)
    }
}
