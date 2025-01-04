// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (FunctionalTest1_2, FunctionalTest3_4)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `Utils::pnameToStr` and `programInterfaceToStr`, which only feed log lines, print the enumerant as hex.

use std::ffi::CString;

use super::utils::{Buffer, Program, ProgramSources, VariableType, Vec4, VertexArray};
use super::{ShaderStage, build_program, check_subroutine_support, fail, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLchar, GLenum, GLint, GLsizei, GLuint};
use crate::tcu::{TestError, TestOutcome};

/// `FunctionalTest1_2::getVertexShaderBody`
fn two_getters_vertex_shader(variable_type: VariableType, array_size: usize) -> String {
    let base_variable_type = variable_type.base();
    let n_variable_type_components = variable_type.n_components();
    let variable_type_glsl = variable_type.glsl_name();
    let array_suffix = if array_size > 1 {
        format!("[{array_size}]")
    } else {
        String::new()
    };
    let arrayed = format!("{variable_type_glsl}{array_suffix}");

    let mut result = String::from("#version 400\n\n#extension GL_ARB_shader_subroutine : require\n");

    if variable_type == VariableType::Double {
        result.push_str("#extension GL_ARB_gpu_shader_fp64 : require\n");
    }

    result.push_str(&format!(
        "\nsubroutine {arrayed} colorGetter(in {variable_type_glsl} in_value{array_suffix});\n\n"
    ));

    for n_getter in 0..2 {
        result.push_str(&format!(
            "subroutine(colorGetter) {arrayed} getter{n_getter}(in {variable_type_glsl} in_value{array_suffix})\n{{\n"
        ));

        if array_size > 1 {
            result.push_str(&format!("{variable_type_glsl} temp{array_suffix};\n"));
        }

        if base_variable_type == VariableType::Bool {
            let negation = if n_getter == 0 {
                if variable_type_glsl == "bool" { "!" } else { "not" }
            } else {
                ""
            };

            if array_size > 1 {
                for array_index in 0..array_size {
                    result.push_str(&format!(
                        "    temp[{array_index}] = {negation}(in_value[{array_index}]);\n"
                    ));
                }
                result.push_str("    return temp;\n");
            } else {
                result.push_str(&format!("    return {negation}(in_value);\n"));
            }
        } else if array_size > 1 {
            for array_index in 0..array_size {
                result.push_str(&format!(
                    "    temp[{array_index}] = in_value[{array_index}] + {};\n",
                    n_getter + 1
                ));
            }
            result.push_str("    return temp;\n");
        } else {
            result.push_str(&format!("    return (in_value + {});\n", n_getter + 1));
        }

        result.push_str("}\n");
    }

    result.push_str("subroutine uniform colorGetter colorGetterUniform;\n\n");

    result.push_str("out ");
    let result_as_int_glsl = match base_variable_type {
        VariableType::Bool => VariableType::from_properties(VariableType::Int, n_variable_type_components)
            .map(VariableType::glsl_name)
            .unwrap_or("int"),
        _ => variable_type_glsl,
    };
    result.push_str(result_as_int_glsl);
    result.push_str(" result;\n\n");

    result.push_str(&format!(
        "void main()\n{{\n    {variable_type_glsl} temp{};\n",
        if array_size > 1 {
            format!("[{array_size}]")
        } else {
            String::new()
        }
    ));

    for array_index in 0..array_size {
        result.push_str("    temp");
        if array_size > 1 {
            result.push_str(&format!("[{array_index}]"));
        }
        result.push_str(&format!(" = {variable_type_glsl}("));
        if base_variable_type == VariableType::Bool {
            result.push_str("true");
        } else {
            result.push_str(&vec!["3"; n_variable_type_components].join(", "));
        }
        result.push_str(");\n");
    }

    if base_variable_type == VariableType::Bool {
        result.push_str(&format!(
            "{arrayed} subroutine_result = colorGetterUniform(temp);\nresult = "
        ));

        for array_index in 0..array_size {
            if variable_type_glsl == "bool" {
                result.push_str("bool(subroutine_result");
            } else {
                result.push_str("all(subroutine_result");
            }
            if array_size > 1 {
                result.push_str(&format!("[{array_index}]"));
            }
            result.push(')');
            if array_index != array_size - 1 {
                result.push_str("&& ");
            }
        }

        result.push_str(&format!(
            " == true ? {result_as_int_glsl}(1) : {result_as_int_glsl}(0);"
        ));
    } else if array_size > 1 {
        result.push_str(&format!(
            "{variable_type_glsl} subroutine_result{array_suffix} = colorGetterUniform(temp);\n\nif (subroutine_result[0] == subroutine_result[1]) result = subroutine_result[0];\nelse\nresult = {variable_type_glsl}(-1);\n"
        ));
    } else {
        result.push_str("result = colorGetterUniform(temp);\n");
    }

    result.push_str("}\n");
    result
}

/// `FunctionalTest1_2::verifyXFBData`
fn verify_xfb_data(xfb_data: &[u8], variable_type: VariableType) -> bool {
    let base_variable_type = variable_type.base();
    let epsilon = 1e-5;
    let n_variable_type_components = variable_type.n_components();
    let mut result = true;
    let mut traveller = 0;

    let read_i32 = |offset: usize| i32::from_ne_bytes(xfb_data[offset..offset + 4].try_into().expect("four bytes"));
    let read_f32 = |offset: usize| f32::from_ne_bytes(xfb_data[offset..offset + 4].try_into().expect("four bytes"));
    let read_f64 = |offset: usize| f64::from_ne_bytes(xfb_data[offset..offset + 8].try_into().expect("eight bytes"));

    if base_variable_type == VariableType::Bool {
        for ref_value in [0u32, 1] {
            for _ in 0..n_variable_type_components {
                let found = read_i32(traveller);

                if found != ref_value as i32 {
                    log::info!(
                        "Invalid value reported by subroutine using [{}] argument/return types (expected:[{ref_value}], found:[{found}])",
                        variable_type.glsl_name()
                    );
                    result = false;
                    break;
                }

                traveller += 4;
            }
        }
    } else {
        for ref_value in [4u32, 5] {
            for _ in 0..n_variable_type_components {
                match base_variable_type {
                    VariableType::Double => {
                        let found = read_f64(traveller);
                        if (found - ref_value as f64).abs() > epsilon {
                            log::info!(
                                "Invalid value reported by subroutine using [{}] argument/return types (expected:[{ref_value}], found:[{found}])",
                                variable_type.glsl_name()
                            );
                            result = false;
                        }
                        traveller += 8;
                    }
                    VariableType::Float => {
                        let found = read_f32(traveller);
                        if (found - ref_value as f32).abs() > epsilon as f32 {
                            log::info!(
                                "Invalid value reported by subroutine using [{}] argument/return types (expected:[{ref_value}], found:[{found}])",
                                variable_type.glsl_name()
                            );
                            result = false;
                        }
                        traveller += 4;
                    }
                    _ => {
                        let found = read_i32(traveller);
                        if found != ref_value as i32 {
                            log::info!(
                                "Invalid value reported by subroutine using [{}] argument/return types (expected:[{ref_value}], found:[{found}])",
                                variable_type.glsl_name()
                            );
                            result = false;
                        }
                        traveller += 4;
                    }
                }
            }
        }
    }

    result
}

/// `FunctionalTest1_2`
pub(super) struct TwoSubroutinesSingleUniform;

impl TwoSubroutinesSingleUniform {
    /// `FunctionalTest1_2::executeTestIteration`
    fn execute_test_iteration(
        context: &Context,
        xfb_bo_id: GLuint,
        variable_type: VariableType,
        array_size: usize,
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        let vs_body = two_getters_vertex_shader(variable_type, array_size);
        let Some(program) = build_program(gl, &[(ShaderStage::Vertex, vs_body.as_str())], Some(&["result"]))? else {
            return fail("Test program failed to build.");
        };
        let po_id = program.program;

        let getter0 = std::ffi::CString::new("getter0").expect("names have no NUL");
        let getter1 = std::ffi::CString::new("getter1").expect("names have no NUL");
        // SAFETY: the names are live NUL-terminated strings.
        let (po_getter0_subroutine_index, po_getter1_subroutine_index) = unsafe {
            (
                gl.get_subroutine_index(po_id, glw::GL_VERTEX_SHADER, getter0.as_ptr()),
                gl.get_subroutine_index(po_id, glw::GL_VERTEX_SHADER, getter1.as_ptr()),
            )
        };
        crate::glu::expect_no_error(gl, "glGetSubroutineIndex() call(s) failed.")?;

        if po_getter0_subroutine_index == glw::GL_INVALID_INDEX || po_getter1_subroutine_index == glw::GL_INVALID_INDEX
        {
            return fail("At least one subroutine is considered inactive which is invalid.");
        }

        let uniform_name = std::ffi::CString::new("colorGetterUniform").expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let po_subroutine_uniform_index =
            unsafe { gl.get_subroutine_uniform_location(po_id, glw::GL_VERTEX_SHADER, uniform_name.as_ptr()) };
        crate::glu::expect_no_error(gl, "glGetSubroutineUniformLocation() call failed.")?;

        if po_subroutine_uniform_index == -1 {
            return fail("Subroutine uniform is considered inactive which is invalid.");
        }

        let base_variable_type = variable_type.base();
        let mut iteration_xfb_bo_size = base_variable_type.component_size() * variable_type.n_components();

        if base_variable_type == VariableType::Bool {
            iteration_xfb_bo_size *= std::mem::size_of::<i32>();
        }

        let total_xfb_bo_size = iteration_xfb_bo_size * 2;
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                total_xfb_bo_size as glw::GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(po_id));

        for (n_subroutine_index, current_subroutine_index) in [po_getter0_subroutine_index, po_getter1_subroutine_index]
            .into_iter()
            .enumerate()
        {
            gl_call!(
                gl,
                "glUniformSubroutinesuiv() call failed.",
                gl.uniform_subroutinesuiv(glw::GL_VERTEX_SHADER, 1, &current_subroutine_index)
            );

            gl_call!(
                gl,
                "glBindBufferRange() call failed.",
                gl.bind_buffer_range(
                    glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                    0,
                    xfb_bo_id,
                    (iteration_xfb_bo_size * n_subroutine_index) as glw::GLintptr,
                    iteration_xfb_bo_size as glw::GLsizeiptr
                )
            );

            gl_call!(
                gl,
                "glBeginTransformFeedback() call failed.",
                gl.begin_transform_feedback(glw::GL_POINTS)
            );
            gl_call!(gl, "glDrawArrays() call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 1));
            gl_call!(gl, "glEndTransformFeedback() call failed.", gl.end_transform_feedback());
        }

        // SAFETY: the buffer holds `total_xfb_bo_size` bytes, written by the draws above.
        let xfb_data_ptr = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
        crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

        let verified = if xfb_data_ptr.is_null() {
            false
        } else {
            // SAFETY: the mapping is `total_xfb_bo_size` bytes and stays valid until the unmap below.
            let xfb_data = unsafe { std::slice::from_raw_parts(xfb_data_ptr.cast::<u8>(), total_xfb_bo_size) };
            verify_xfb_data(xfb_data, variable_type)
        };

        gl_call!(
            gl,
            "glUnmapBuffeR() call failed.",
            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
        );

        Ok(verified)
    }
}

impl TestCase for TwoSubroutinesSingleUniform {
    fn name(&self) -> &str {
        "two_subroutines_single_subroutine_uniform"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        let mut xfb_bo = Buffer::new(context);
        let mut vao = VertexArray::new(context);

        xfb_bo.generate()?;
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, xfb_bo.id)
        );
        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, xfb_bo.id)
        );
        vao.generate()?;
        vao.bind()?;

        use VariableType::*;
        let variable_types = [
            Bool, Bvec2, Bvec3, Bvec4, Double, Float, Int, Ivec2, Ivec3, Ivec4, Mat2, Mat2x3, Mat2x4, Mat3, Mat3x2,
            Mat3x4, Mat4, Mat4x2, Mat4x3, Uint, Uvec2, Uvec3, Uvec4, Vec2, Vec3, Vec4,
        ];

        let mut test_cases = Vec::new();
        for current_variable_type in variable_types {
            for array_size in 1..3 {
                if !context.context_info.is_extension_supported("GL_ARB_gpu_shader_fp64")
                    && current_variable_type == Double
                {
                    continue;
                }

                test_cases.push((current_variable_type, array_size));
            }
        }

        for (variable_type, array_size) in test_cases {
            has_test_passed &= Self::execute_test_iteration(context, xfb_bo.id, variable_type, array_size)?;
        }

        verdict(has_test_passed)
    }
}

const FOUR_SUBROUTINES_VS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\n// Sub routine type declaration\nsubroutine vec4 routine_type(in vec4 iparam);\n\n// Sub routine definitions\nsubroutine(routine_type) vec4 inverse_order(in vec4 iparam)\n{\n    return iparam.wzyx;\n}\n\nsubroutine(routine_type) vec4 negate(in vec4 iparam)\n{\n    return -iparam;\n}\n\nsubroutine(routine_type) vec4 inverse(in vec4 iparam)\n{\n    return 1 / iparam;\n}\n\nsubroutine(routine_type) vec4 square(in vec4 iparam)\n{\n    return iparam * iparam;\n}\n\n// Sub routine uniforms\nsubroutine uniform routine_type first_routine;\nsubroutine uniform routine_type second_routine;\n\n// Input data\nuniform vec4 input_data;\n\n// Output\nout vec4 out_input_data;\nout vec4 out_result_from_first_routine;\nout vec4 out_result_from_second_routine;\nout vec4 out_result_from_combined_routines;\nout vec4 out_result_from_routines_combined_in_reveresed_order;\n\nvoid main()\n{\n    out_input_data                                       = input_data;\n    out_result_from_first_routine                        = first_routine(input_data);\n    out_result_from_second_routine                       = second_routine(input_data);\n    out_result_from_combined_routines                    = second_routine(first_routine(input_data));\n    out_result_from_routines_combined_in_reveresed_order = first_routine(second_routine(input_data));\n}\n\n";

const FOUR_SUBROUTINES_VARYINGS: [&str; 5] = [
    "out_input_data",
    "out_result_from_first_routine",
    "out_result_from_second_routine",
    "out_result_from_combined_routines",
    "out_result_from_routines_combined_in_reveresed_order",
];

const FOUR_SUBROUTINES_UNIFORM_NAMES: [&str; 2] = ["first_routine", "second_routine"];
const FOUR_SUBROUTINES_NAMES: [&str; 4] = ["inverse_order", "negate", "inverse", "square"];

/// The enumerant a log line names, as upstream's `pnameToStr` would print it.
fn enum_text(value: GLenum) -> String {
    format!("0x{value:X}")
}

/// `FunctionalTest3_4::inspectionDetails`
struct InspectionDetails {
    pname: GLenum,
    expected_value: GLint,
}

/// `FunctionalTest3_4`
pub(super) struct FourSubroutinesTwoUniforms;

/// The counts `FunctionalTest3_4::iterate` fixes before it inspects anything.
struct Expected {
    n_active_subroutine_uniforms: GLint,
    n_active_subroutine_uniform_locations: GLint,
    n_active_subroutines: GLint,
    n_active_subroutine_uniform_name_length: GLint,
    n_active_subroutine_name_length: GLint,
    n_active_subroutine_uniform_size: GLint,
}

impl FourSubroutinesTwoUniforms {
    /// `FunctionalTest3_4::checkProgramStageiv`
    fn check_program_stageiv(
        context: &Context,
        program_id: GLuint,
        pname: GLenum,
        expected: GLint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut value: GLint = 0;
        gl_call!(
            gl,
            "GetProgramStageiv",
            gl.get_program_stageiv(program_id, glw::GL_VERTEX_SHADER, pname, &mut value)
        );

        if expected != value {
            log::info!(
                "Error. Invalid result. Function: getProgramStageiv. pname: {}. Result: {value}. Expected: {expected}.",
                enum_text(pname)
            );
            return Ok(false);
        }

        Ok(true)
    }

    /// `FunctionalTest3_4::checkProgramResourceiv`
    fn check_program_resourceiv(
        context: &Context,
        program_id: GLuint,
        program_interface: GLenum,
        pname: GLenum,
        resource_name: &str,
        expected: GLint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let name = CString::new(resource_name).expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let index = unsafe { gl.get_program_resource_index(program_id, program_interface, name.as_ptr()) };
        let mut value: GLint = 0;

        if index == glw::GL_INVALID_INDEX {
            return Ok(false);
        }

        gl_call!(
            gl,
            "getProgramResourceiv",
            gl.get_program_resourceiv(
                program_id,
                program_interface,
                index,
                1,
                &pname,
                1,
                std::ptr::null_mut(),
                &mut value
            )
        );

        if expected != value {
            log::info!(
                "Error. Invalid result. Function: getProgramResourceiv. Program interface: {}. Resource name: {resource_name}. Property: {}. Result: {value}. Expected: {expected}.",
                enum_text(program_interface),
                enum_text(pname)
            );
            return Ok(false);
        }

        Ok(true)
    }

    /// `FunctionalTest3_4::checkProgramInterfaceiv`
    fn check_program_interfaceiv(
        context: &Context,
        program_id: GLuint,
        program_interface: GLenum,
        pname: GLenum,
        expected: GLint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut value: GLint = 0;
        gl_call!(
            gl,
            "GetProgramInterfaceiv",
            gl.get_program_interfaceiv(program_id, program_interface, pname, &mut value)
        );

        if expected != value {
            log::info!(
                "Error. Invalid result. Function: getProgramInterfaceiv. Program interface: {}. pname: {}. Result: {value}. Expected: {expected}.",
                enum_text(program_interface),
                enum_text(pname)
            );
            return Ok(false);
        }

        Ok(true)
    }

    /// `FunctionalTest3_4::checkActiveSubroutineUniformiv`
    fn check_active_subroutine_uniformiv(
        context: &Context,
        program_id: GLuint,
        index: GLuint,
        pname: GLenum,
        expected: GLint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut value: GLint = 0;
        gl_call!(
            gl,
            "getActiveSubroutineUniformiv",
            gl.get_active_subroutine_uniformiv(program_id, glw::GL_VERTEX_SHADER, index, pname, &mut value)
        );

        if expected != value {
            log::info!(
                "Error. Invalid result. Function: getActiveSubroutineUniformiv. idnex: {index}. pname: {}. Result: {value}. Expected: {expected}.",
                enum_text(pname)
            );
            return Ok(false);
        }

        Ok(true)
    }

    /// `FunctionalTest3_4::getProgramResourceIndex`
    fn get_program_resource_index(
        context: &Context,
        program_id: GLuint,
        program_interface: GLenum,
        resource_name: &str,
    ) -> Result<GLuint, TestError> {
        let gl = context.gl();
        let name = CString::new(resource_name).expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let index = unsafe { gl.get_program_resource_index(program_id, program_interface, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "getProgramResourceIndex")?;

        if index == glw::GL_INVALID_INDEX {
            log::info!(
                "Error. Program resource is not available. Program interface: {}. Resource name: {resource_name}.",
                enum_text(program_interface)
            );
        }

        Ok(index)
    }

    /// `FunctionalTest3_4::getSubroutineIndex`
    fn get_subroutine_index(
        context: &Context,
        program_id: GLuint,
        subroutine_name: &str,
        use_program_query: bool,
    ) -> Result<GLuint, TestError> {
        let gl = context.gl();
        let name = CString::new(subroutine_name).expect("names have no NUL");

        let index = if !use_program_query {
            // SAFETY: the name is a live NUL-terminated string.
            let index = unsafe { gl.get_subroutine_index(program_id, glw::GL_VERTEX_SHADER, name.as_ptr()) };
            crate::glu::expect_no_error(gl, "GetSubroutineIndex")?;
            index
        } else {
            // SAFETY: the name is a live NUL-terminated string.
            let index = unsafe { gl.get_program_resource_index(program_id, glw::GL_VERTEX_SUBROUTINE, name.as_ptr()) };
            crate::glu::expect_no_error(gl, "GetProgramResourceIndex")?;
            index
        };

        if index == glw::GL_INVALID_INDEX {
            return fail("Subroutine is not available");
        }

        Ok(index)
    }

    /// `FunctionalTest3_4::getSubroutineUniformLocation`
    fn get_subroutine_uniform_location(
        context: &Context,
        program_id: GLuint,
        uniform_name: &str,
        use_program_query: bool,
    ) -> Result<GLint, TestError> {
        let gl = context.gl();
        let name = CString::new(uniform_name).expect("names have no NUL");

        let location = if !use_program_query {
            // SAFETY: the name is a live NUL-terminated string.
            let location =
                unsafe { gl.get_subroutine_uniform_location(program_id, glw::GL_VERTEX_SHADER, name.as_ptr()) };
            crate::glu::expect_no_error(gl, "GetSubroutineUniformLocation")?;
            location
        } else {
            // SAFETY: the name is a live NUL-terminated string.
            let location = unsafe {
                gl.get_program_resource_location(program_id, glw::GL_VERTEX_SUBROUTINE_UNIFORM, name.as_ptr())
            };
            crate::glu::expect_no_error(gl, "GetProgramResourceLocation")?;
            location
        };

        if location == -1 {
            return fail("Subroutine uniform is not available");
        }

        Ok(location)
    }

    /// `FunctionalTest3_4::inspectProgramStageiv`
    fn inspect_program_stageiv(context: &Context, program_id: GLuint, expected: &Expected) -> Result<bool, TestError> {
        let details = [
            InspectionDetails {
                pname: glw::GL_ACTIVE_SUBROUTINE_UNIFORMS,
                expected_value: expected.n_active_subroutine_uniforms,
            },
            InspectionDetails {
                pname: glw::GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS,
                expected_value: expected.n_active_subroutine_uniform_locations,
            },
            InspectionDetails {
                pname: glw::GL_ACTIVE_SUBROUTINES,
                expected_value: expected.n_active_subroutines,
            },
            InspectionDetails {
                pname: glw::GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH,
                expected_value: expected.n_active_subroutine_uniform_name_length + 1,
            },
            InspectionDetails {
                pname: glw::GL_ACTIVE_SUBROUTINE_MAX_LENGTH,
                expected_value: expected.n_active_subroutine_name_length + 1,
            },
        ];

        let mut result = true;
        for detail in &details {
            if !Self::check_program_stageiv(context, program_id, detail.pname, detail.expected_value)? {
                result = false;
            }
        }

        Ok(result)
    }

    /// `FunctionalTest3_4::inspectProgramInterfaceiv`
    fn inspect_program_interfaceiv(
        context: &Context,
        program_id: GLuint,
        expected: &Expected,
    ) -> Result<bool, TestError> {
        let details = [
            (
                glw::GL_VERTEX_SUBROUTINE_UNIFORM,
                glw::GL_ACTIVE_RESOURCES,
                expected.n_active_subroutine_uniforms,
            ),
            (
                glw::GL_VERTEX_SUBROUTINE_UNIFORM,
                glw::GL_MAX_NAME_LENGTH,
                expected.n_active_subroutine_uniform_name_length + 1,
            ),
            (
                glw::GL_VERTEX_SUBROUTINE_UNIFORM,
                glw::GL_MAX_NUM_COMPATIBLE_SUBROUTINES,
                expected.n_active_subroutines,
            ),
            (
                glw::GL_VERTEX_SUBROUTINE,
                glw::GL_ACTIVE_RESOURCES,
                expected.n_active_subroutines,
            ),
            (
                glw::GL_VERTEX_SUBROUTINE,
                glw::GL_MAX_NAME_LENGTH,
                expected.n_active_subroutine_name_length + 1,
            ),
        ];

        let mut result = true;
        for (program_interface, pname, expected_value) in details {
            if !Self::check_program_interfaceiv(context, program_id, program_interface, pname, expected_value)? {
                result = false;
            }
        }

        Ok(result)
    }

    /// `FunctionalTest3_4::inspectProgramResourceiv`
    fn inspect_program_resourceiv(
        context: &Context,
        program_id: GLuint,
        expected: &Expected,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;

        for subroutine_name in FOUR_SUBROUTINES_NAMES
            .iter()
            .take(expected.n_active_subroutines as usize)
        {
            let length = subroutine_name.len() as GLint + 1;

            if !Self::check_program_resourceiv(
                context,
                program_id,
                glw::GL_VERTEX_SUBROUTINE,
                glw::GL_NAME_LENGTH,
                subroutine_name,
                length,
            )? {
                result = false;
            }
        }

        for uniform_name in FOUR_SUBROUTINES_UNIFORM_NAMES
            .iter()
            .take(expected.n_active_subroutine_uniforms as usize)
        {
            let length = uniform_name.len() as GLint + 1;
            let location = Self::get_subroutine_uniform_location(context, program_id, uniform_name, true)?;

            let details = [
                InspectionDetails {
                    pname: glw::GL_NAME_LENGTH,
                    expected_value: length,
                },
                InspectionDetails {
                    pname: glw::GL_ARRAY_SIZE,
                    expected_value: 1,
                },
                InspectionDetails {
                    pname: glw::GL_NUM_COMPATIBLE_SUBROUTINES,
                    expected_value: expected.n_active_subroutines,
                },
                InspectionDetails {
                    pname: glw::GL_LOCATION,
                    expected_value: location,
                },
            ];

            for detail in &details {
                if !Self::check_program_resourceiv(
                    context,
                    program_id,
                    glw::GL_VERTEX_SUBROUTINE_UNIFORM,
                    detail.pname,
                    uniform_name,
                    detail.expected_value,
                )? {
                    result = false;
                }
            }

            let index =
                Self::get_program_resource_index(context, program_id, glw::GL_VERTEX_SUBROUTINE_UNIFORM, uniform_name)?;

            if index != glw::GL_INVALID_INDEX {
                let mut compatible_subroutines = vec![0 as GLint; expected.n_active_subroutines as usize];
                let prop = glw::GL_COMPATIBLE_SUBROUTINES;

                gl_call!(
                    gl,
                    "GetProgramResourceiv",
                    gl.get_program_resourceiv(
                        program_id,
                        glw::GL_VERTEX_SUBROUTINE_UNIFORM,
                        index,
                        1,
                        &prop,
                        expected.n_active_subroutines,
                        std::ptr::null_mut(),
                        compatible_subroutines.as_mut_ptr()
                    )
                );

                let index_sum: GLint = compatible_subroutines.iter().sum();

                if ((expected.n_active_subroutines - 1) * expected.n_active_subroutines) / 2 != index_sum {
                    let results: String = compatible_subroutines
                        .iter()
                        .skip(1)
                        .map(|value| value.to_string())
                        .collect();
                    log::info!(
                        "Error. Invalid result. Function: getProgramResourceiv. Program interface: GL_VERTEX_SUBROUTINE_UNIFORM. Resource name: {uniform_name}. Property: GL_COMPATIBLE_SUBROUTINES. Results: {results}"
                    );
                    result = false;
                }
            }
        }

        Ok(result)
    }

    /// `FunctionalTest3_4::inspectActiveSubroutineUniformiv`
    fn inspect_active_subroutine_uniformiv(
        context: &Context,
        program_id: GLuint,
        expected: &Expected,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;
        let mut n_active_subroutine_uniforms: GLint = 0;

        gl_call!(
            gl,
            "GetProgramStageiv",
            gl.get_program_stageiv(
                program_id,
                glw::GL_VERTEX_SHADER,
                glw::GL_ACTIVE_SUBROUTINE_UNIFORMS,
                &mut n_active_subroutine_uniforms
            )
        );

        for uniform in 0..n_active_subroutine_uniforms {
            let name_length = FOUR_SUBROUTINES_UNIFORM_NAMES[uniform as usize].len() as GLint;

            let details = [
                InspectionDetails {
                    pname: glw::GL_NUM_COMPATIBLE_SUBROUTINES,
                    expected_value: expected.n_active_subroutines,
                },
                InspectionDetails {
                    pname: glw::GL_UNIFORM_SIZE,
                    expected_value: expected.n_active_subroutine_uniform_size,
                },
                InspectionDetails {
                    pname: glw::GL_UNIFORM_NAME_LENGTH,
                    expected_value: name_length + 1,
                },
            ];

            for detail in &details {
                if !Self::check_active_subroutine_uniformiv(
                    context,
                    program_id,
                    uniform as GLuint,
                    detail.pname,
                    detail.expected_value,
                )? {
                    result = false;
                }
            }

            let mut compatible_subroutines = vec![0 as GLint; expected.n_active_subroutines as usize];
            gl_call!(
                gl,
                "getActiveSubroutineUniformiv",
                gl.get_active_subroutine_uniformiv(
                    program_id,
                    glw::GL_VERTEX_SHADER,
                    uniform as GLuint,
                    glw::GL_COMPATIBLE_SUBROUTINES,
                    compatible_subroutines.as_mut_ptr()
                )
            );

            let index_sum: GLint = compatible_subroutines.iter().sum();

            if ((expected.n_active_subroutines - 1) * expected.n_active_subroutines) / 2 != index_sum {
                let results: String = compatible_subroutines
                    .iter()
                    .skip(1)
                    .map(|value| value.to_string())
                    .collect();
                log::info!(
                    "Error. Invalid result. Function: getActiveSubroutineUniformiv. idnex: {uniform}. pname: GL_COMPATIBLE_SUBROUTINES. Results: {results}"
                );
                result = false;
            }
        }

        Ok(result)
    }

    /// `FunctionalTest3_4::inspectActiveSubroutineUniformName`
    fn inspect_active_subroutine_uniform_name(
        context: &Context,
        program_id: GLuint,
        expected: &Expected,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut n_active_subroutine_uniforms: GLint = 0;

        gl_call!(
            gl,
            "GetProgramStageiv",
            gl.get_program_stageiv(
                program_id,
                glw::GL_VERTEX_SHADER,
                glw::GL_ACTIVE_SUBROUTINE_UNIFORMS,
                &mut n_active_subroutine_uniforms
            )
        );

        let mut active_uniform_name = vec![0 as GLchar; expected.n_active_subroutine_uniform_name_length as usize + 1];

        for uniform in 0..n_active_subroutine_uniforms {
            gl_call!(
                gl,
                "GetActiveSubroutineUniformName",
                gl.get_active_subroutine_uniform_name(
                    program_id,
                    glw::GL_VERTEX_SHADER,
                    uniform as GLuint,
                    active_uniform_name.len() as GLsizei,
                    std::ptr::null_mut(),
                    active_uniform_name.as_mut_ptr()
                )
            );

            let name = chars_to_string(&active_uniform_name);
            let is_name_ok = FOUR_SUBROUTINES_UNIFORM_NAMES
                .iter()
                .take(n_active_subroutine_uniforms as usize)
                .any(|candidate| *candidate == name);

            if !is_name_ok {
                log::info!(
                    "Error. Invalid result. Function: getActiveSubroutineUniformName. idnex: {uniform}. Result: {name}"
                );
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `FunctionalTest3_4::inspectActiveSubroutineName`
    fn inspect_active_subroutine_name(
        context: &Context,
        program_id: GLuint,
        expected: &Expected,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut n_active_subroutines: GLint = 0;

        gl_call!(
            gl,
            "GetProgramStageiv",
            gl.get_program_stageiv(
                program_id,
                glw::GL_VERTEX_SHADER,
                glw::GL_ACTIVE_SUBROUTINES,
                &mut n_active_subroutines
            )
        );

        let mut active_subroutine_name = vec![0 as GLchar; expected.n_active_subroutine_name_length as usize + 1];

        for uniform in 0..n_active_subroutines {
            gl_call!(
                gl,
                "getActiveSubroutineName",
                gl.get_active_subroutine_name(
                    program_id,
                    glw::GL_VERTEX_SHADER,
                    uniform as GLuint,
                    active_subroutine_name.len() as GLsizei,
                    std::ptr::null_mut(),
                    active_subroutine_name.as_mut_ptr()
                )
            );

            let name = chars_to_string(&active_subroutine_name);
            let is_name_ok = FOUR_SUBROUTINES_NAMES
                .iter()
                .take(n_active_subroutines as usize)
                .any(|candidate| *candidate == name);

            if !is_name_ok {
                log::info!(
                    "Error. Invalid result. Function: getActiveSubroutineName. idnex: {uniform}. Result: {name}"
                );
                return Ok(false);
            }
        }

        Ok(true)
    }

    /// `FunctionalTest3_4::inspectSubroutineBinding`
    fn inspect_subroutine_binding(
        context: &Context,
        program_id: GLuint,
        use_program_query: bool,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;
        let mut n_active_subroutines: GLint = 0;
        let mut n_active_subroutine_uniforms: GLint = 0;

        gl_call!(
            gl,
            "GetProgramStageiv",
            gl.get_program_stageiv(
                program_id,
                glw::GL_VERTEX_SHADER,
                glw::GL_ACTIVE_SUBROUTINES,
                &mut n_active_subroutines
            )
        );
        gl_call!(
            gl,
            "GetProgramStageiv",
            gl.get_program_stageiv(
                program_id,
                glw::GL_VERTEX_SHADER,
                glw::GL_ACTIVE_SUBROUTINE_UNIFORMS,
                &mut n_active_subroutine_uniforms
            )
        );

        let mut subroutine_uniforms = vec![0 as GLuint; n_active_subroutine_uniforms as usize];

        for uniform in 0..n_active_subroutine_uniforms as usize {
            let uniform_location = Self::get_subroutine_uniform_location(
                context,
                program_id,
                FOUR_SUBROUTINES_UNIFORM_NAMES[uniform],
                use_program_query,
            )? as GLuint;

            for routine in 0..n_active_subroutines as usize {
                let routine_index = Self::get_subroutine_index(
                    context,
                    program_id,
                    FOUR_SUBROUTINES_NAMES[routine],
                    use_program_query,
                )?;
                let mut queried_subroutine_index: GLuint = 0;

                subroutine_uniforms[uniform] = routine_index;

                gl_call!(
                    gl,
                    "UniformSubroutinesuiv",
                    gl.uniform_subroutinesuiv(
                        glw::GL_VERTEX_SHADER,
                        n_active_subroutine_uniforms,
                        subroutine_uniforms.as_ptr()
                    )
                );
                gl_call!(
                    gl,
                    "GetUniformSubroutineuiv",
                    gl.get_uniform_subroutineuiv(
                        glw::GL_VERTEX_SHADER,
                        uniform_location as GLint,
                        &mut queried_subroutine_index
                    )
                );

                if queried_subroutine_index != routine_index {
                    log::info!(
                        "Error. Invalid result. Function: gl.getUniformSubroutineuiv. Subroutine uniform: {uniform}, name: {}, location: {uniform_location}. Subroutine: {routine}, name: {}, index: {routine_index}. Result: {queried_subroutine_index}",
                        FOUR_SUBROUTINES_UNIFORM_NAMES[uniform],
                        FOUR_SUBROUTINES_NAMES[routine]
                    );
                    result = false;
                }
            }
        }

        Ok(result)
    }

    /// `FunctionalTest3_4::testDraw`
    fn test_draw(
        context: &Context,
        program_id: GLuint,
        first_routine_name: &str,
        second_routine_name: &str,
        expected_results: &[Vec4; 5],
        use_program_query: bool,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut subroutine_uniforms: [GLuint; 2] = [0; 2];

        let first_routine_location = Self::get_subroutine_uniform_location(
            context,
            program_id,
            FOUR_SUBROUTINES_UNIFORM_NAMES[0],
            use_program_query,
        )?;
        let second_routine_location = Self::get_subroutine_uniform_location(
            context,
            program_id,
            FOUR_SUBROUTINES_UNIFORM_NAMES[1],
            use_program_query,
        )?;
        let first_routine_index =
            Self::get_subroutine_index(context, program_id, first_routine_name, use_program_query)?;
        let second_routine_index =
            Self::get_subroutine_index(context, program_id, second_routine_name, use_program_query)?;

        subroutine_uniforms[first_routine_location as usize] = first_routine_index;
        subroutine_uniforms[second_routine_location as usize] = second_routine_index;

        gl_call!(
            gl,
            "UniformSubroutinesuiv",
            gl.uniform_subroutinesuiv(glw::GL_VERTEX_SHADER, 2, subroutine_uniforms.as_ptr())
        );

        let input_data = CString::new("input_data").expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let input_data_location = unsafe { gl.get_uniform_location(program_id, input_data.as_ptr()) };
        crate::glu::expect_no_error(gl, "GetUniformLocation")?;

        if input_data_location == -1 {
            return fail("Uniform is not available");
        }

        let input = expected_results[0].0;
        gl_call!(
            gl,
            "Uniform4f",
            gl.uniform_4f(input_data_location, input[0], input[1], input[2], input[3])
        );

        gl_call!(
            gl,
            "BeginTransformFeedback",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );
        gl_call!(gl, "DrawArrays", gl.draw_arrays(glw::GL_POINTS, 0, 1));
        gl_call!(gl, "EndTransformFeedback", gl.end_transform_feedback());

        // SAFETY: the buffer holds the 20 floats of the five captured vec4 varyings.
        let feedback_data = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) };
        crate::glu::expect_no_error(gl, "MapBuffer")?;

        if feedback_data.is_null() {
            return fail("MapBuffer returned no pointer");
        }

        // SAFETY: the mapping is 20 floats long and stays valid until the unmap below.
        let feedback = unsafe { std::slice::from_raw_parts(feedback_data.cast::<f32>(), 20) };
        let results: [Vec4; 5] = std::array::from_fn(|i| {
            Vec4([
                feedback[i * 4],
                feedback[i * 4 + 1],
                feedback[i * 4 + 2],
                feedback[i * 4 + 3],
            ])
        });

        gl_call!(gl, "UnmapBuffer", gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));

        let result = results
            .iter()
            .zip(expected_results)
            .all(|(found, expected)| found.matches(expected));

        if !result {
            log::info!(
                "Error. Invalid result. First routine: {first_routine_name}. Second routine: {second_routine_name}"
            );
            log::info!("Results:{results:?}");
            log::info!("Expected:{expected_results:?}");
        }

        Ok(result)
    }
}

/// The text of a NUL-terminated `GLchar` buffer up to the terminator.
fn chars_to_string(buffer: &[GLchar]) -> String {
    let bytes: Vec<u8> = buffer
        .iter()
        .take_while(|&&byte| byte != 0)
        .map(|&byte| byte as u8)
        .collect();
    String::from_utf8_lossy(&bytes).into_owned()
}

impl TestCase for FourSubroutinesTwoUniforms {
    fn name(&self) -> &str {
        "four_subroutines_with_two_uniforms"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const N_VARYINGS: usize = 5;
        const TRANSFORM_FEEDBACK_BUFFER_SIZE: usize = N_VARYINGS * std::mem::size_of::<f32>() * 4;

        let inverse_order_negate_data = [
            Vec4([-2.0, -1.0, 1.0, 2.0]),
            Vec4([2.0, 1.0, -1.0, -2.0]),
            Vec4([2.0, 1.0, -1.0, -2.0]),
            Vec4([-2.0, -1.0, 1.0, 2.0]),
            Vec4([-2.0, -1.0, 1.0, 2.0]),
        ];
        let inverse_order_inverse_data = [
            Vec4([-2.0, -1.0, 1.0, 2.0]),
            Vec4([2.0, 1.0, -1.0, -2.0]),
            Vec4([-0.5, -1.0, 1.0, 0.5]),
            Vec4([0.5, 1.0, -1.0, -0.5]),
            Vec4([0.5, 1.0, -1.0, -0.5]),
        ];
        let inverse_order_square_data = [
            Vec4([-2.0, -1.0, 1.0, 2.0]),
            Vec4([2.0, 1.0, -1.0, -2.0]),
            Vec4([4.0, 1.0, 1.0, 4.0]),
            Vec4([4.0, 1.0, 1.0, 4.0]),
            Vec4([4.0, 1.0, 1.0, 4.0]),
        ];
        let negate_inverse_data = [
            Vec4([-2.0, -1.0, 1.0, 2.0]),
            Vec4([2.0, 1.0, -1.0, -2.0]),
            Vec4([-0.5, -1.0, 1.0, 0.5]),
            Vec4([0.5, 1.0, -1.0, -0.5]),
            Vec4([0.5, 1.0, -1.0, -0.5]),
        ];
        let negate_square_data = [
            Vec4([-2.0, -1.0, 1.0, 2.0]),
            Vec4([2.0, 1.0, -1.0, -2.0]),
            Vec4([4.0, 1.0, 1.0, 4.0]),
            Vec4([4.0, 1.0, 1.0, 4.0]),
            Vec4([-4.0, -1.0, -1.0, -4.0]),
        ];
        let inverse_square_data = [
            Vec4([-2.0, -1.0, 1.0, 2.0]),
            Vec4([-0.5, -1.0, 1.0, 0.5]),
            Vec4([4.0, 1.0, 1.0, 4.0]),
            Vec4([0.25, 1.0, 1.0, 0.25]),
            Vec4([0.25, 1.0, 1.0, 0.25]),
        ];

        check_subroutine_support(context)?;

        let mut expected = Expected {
            n_active_subroutine_uniforms: 2,
            n_active_subroutine_uniform_locations: 2,
            n_active_subroutines: 4,
            n_active_subroutine_uniform_name_length: 0,
            n_active_subroutine_name_length: 0,
            n_active_subroutine_uniform_size: 1,
        };

        let mut program = Program::new(context);
        let mut transform_feedback_buffer = Buffer::new(context);
        let mut vao = VertexArray::new(context);
        let mut result = true;

        for name in FOUR_SUBROUTINES_UNIFORM_NAMES
            .iter()
            .take(expected.n_active_subroutine_uniforms as usize)
        {
            expected.n_active_subroutine_uniform_name_length = expected
                .n_active_subroutine_uniform_name_length
                .max(name.len() as GLsizei);
        }

        for name in FOUR_SUBROUTINES_NAMES
            .iter()
            .take(expected.n_active_subroutines as usize)
        {
            expected.n_active_subroutine_name_length =
                expected.n_active_subroutine_name_length.max(name.len() as GLsizei);
        }

        program.build(
            &ProgramSources {
                vertex: Some(FOUR_SUBROUTINES_VS),
                ..Default::default()
            },
            &FOUR_SUBROUTINES_VARYINGS,
            false,
        )?;

        vao.generate()?;
        vao.bind()?;

        transform_feedback_buffer.generate()?;
        transform_feedback_buffer.update(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            TRANSFORM_FEEDBACK_BUFFER_SIZE as glw::GLsizeiptr,
            std::ptr::null(),
            glw::GL_DYNAMIC_COPY,
        )?;
        transform_feedback_buffer.bind_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            0,
            TRANSFORM_FEEDBACK_BUFFER_SIZE as glw::GLsizeiptr,
        )?;

        program.use_program()?;
        let program_id = program.program_object_id;

        if !(Self::inspect_program_stageiv(context, program_id, &expected)?
            && Self::inspect_active_subroutine_uniformiv(context, program_id, &expected)?
            && Self::inspect_active_subroutine_uniform_name(context, program_id, &expected)?
            && Self::inspect_active_subroutine_name(context, program_id, &expected)?
            && Self::inspect_subroutine_binding(context, program_id, false)?)
        {
            result = false;
        }

        let uses_program_interface_query = context
            .context_info
            .is_extension_supported("GL_ARB_program_interface_query");

        if uses_program_interface_query
            && !(Self::inspect_program_interfaceiv(context, program_id, &expected)?
                && Self::inspect_program_resourceiv(context, program_id, &expected)?
                && Self::inspect_subroutine_binding(context, program_id, true)?)
        {
            result = false;
        }

        let names = FOUR_SUBROUTINES_NAMES;
        let draws: [(usize, usize, &[Vec4; 5]); 6] = [
            (0, 1, &inverse_order_negate_data),
            (0, 2, &inverse_order_inverse_data),
            (0, 3, &inverse_order_square_data),
            (1, 2, &negate_inverse_data),
            (1, 3, &negate_square_data),
            (2, 3, &inverse_square_data),
        ];

        for (first, second, data) in draws {
            if !Self::test_draw(context, program_id, names[first], names[second], data, false)? {
                result = false;
                break;
            }
        }

        if uses_program_interface_query {
            for (first, second, data) in draws {
                if !Self::test_draw(context, program_id, names[first], names[second], data, true)? {
                    result = false;
                    break;
                }
            }
        }

        verdict(result)
    }
}
