// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (FunctionalTest5, FunctionalTest6, FunctionalTest7_8)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The error-logging helpers of upstream (`logError`) print the result and expected vectors with `{:?}` instead of the operation text.

use super::utils::{
    Buffer, Program, ProgramSources, UVec4, Vec4, VertexArray, draw_points_and_read_xfb, words_as_vec4,
};
use super::{check_subroutine_support, fail, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLint, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome};

const EIGHT_SUBROUTINES_VS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\n// Subroutine types\nsubroutine vec4  routine_type_1(in vec4 left, in vec4 right);\nsubroutine vec4  routine_type_2(in vec4 iparam);\nsubroutine vec4  routine_type_3(in vec4 a,    in vec4 b,    in vec4 c);\nsubroutine bvec4 routine_type_4(in vec4 left, in vec4 right);\n\n// Subroutine definitions\n// 1st type\nsubroutine(routine_type_1) vec4 add(in vec4 left, in vec4 right)\n{\n    return left + right;\n}\n\nsubroutine(routine_type_1) vec4 subtract(in vec4 left, in vec4 right)\n{\n    return left - right;\n}\n\n// 2nd type\nsubroutine(routine_type_2) vec4 square(in vec4 iparam)\n{\n    return iparam * iparam;\n}\n\nsubroutine(routine_type_2) vec4 square_root(in vec4 iparam)\n{\n    return sqrt(iparam);\n}\n\n// 3rd type\nsubroutine(routine_type_3) vec4 do_fma(in vec4 a, in vec4 b, in vec4 c)\n{\n    return fma(a, b, c);\n}\n\nsubroutine(routine_type_3) vec4 blend(in vec4 a, in vec4 b, in vec4 c)\n{\n    return c * a + (vec4(1) - c) * b;\n}\n\n// 4th type\nsubroutine(routine_type_4) bvec4 are_equal(in vec4 left, in vec4 right)\n{\n    return equal(left, right);\n}\n\nsubroutine(routine_type_4) bvec4 are_greater(in vec4 left, in vec4 right)\n{\n    return greaterThan(left, right);\n}\n\n// Sub routine uniforms\nsubroutine uniform routine_type_1 first_routine;\nsubroutine uniform routine_type_2 second_routine;\nsubroutine uniform routine_type_3 third_routine;\nsubroutine uniform routine_type_4 fourth_routine;\n\n// Input data\nuniform vec4 first_input;\nuniform vec4 second_input;\nuniform vec4 third_input;\n\n// Output\nout  vec4 out_result_from_first_routine;\nout  vec4 out_result_from_second_routine;\nout  vec4 out_result_from_third_routine;\nout uvec4 out_result_from_fourth_routine;\n\nvoid main()\n{\n    out_result_from_first_routine  =       first_routine (first_input, second_input);\n    out_result_from_second_routine =       second_routine(first_input);\n    out_result_from_third_routine  =       third_routine (first_input, second_input, third_input);\n    out_result_from_fourth_routine = uvec4(fourth_routine(first_input, second_input));\n}\n\n";

const EIGHT_SUBROUTINES_NAMES: [[&str; 2]; 4] = [
    ["add", "subtract"],
    ["square", "square_root"],
    ["do_fma", "blend"],
    ["are_equal", "are_greater"],
];
const EIGHT_SUBROUTINES_UNIFORM_NAMES: [&str; 4] =
    ["first_routine", "second_routine", "third_routine", "fourth_routine"];
const EIGHT_SUBROUTINES_INPUT_NAMES: [&str; 3] = ["first_input", "second_input", "third_input"];
const EIGHT_SUBROUTINES_VARYINGS: [&str; 4] = [
    "out_result_from_first_routine",
    "out_result_from_second_routine",
    "out_result_from_third_routine",
    "out_result_from_fourth_routine",
];

/// `FunctionalTest5`
pub(super) struct EightSubroutinesFourUniforms;

impl TestCase for EightSubroutinesFourUniforms {
    fn name(&self) -> &str {
        "eight_subroutines_four_uniforms"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        const TRANSFORM_FEEDBACK_BUFFER_SIZE: usize = 4 * std::mem::size_of::<f32>() * 4;

        let input_data = [
            Vec4([1.0, 4.0, 9.0, 16.0]),
            Vec4([16.0, 9.0, 4.0, 1.0]),
            Vec4([0.25, 0.5, 0.75, 1.0]),
        ];
        let expected_result_from_first_routine = [Vec4([17.0, 13.0, 13.0, 17.0]), Vec4([-15.0, -5.0, 5.0, 15.0])];
        let expected_result_from_second_routine = [Vec4([1.0, 16.0, 81.0, 256.0]), Vec4([1.0, 2.0, 3.0, 4.0])];
        let expected_result_from_third_routine = [Vec4([16.25, 36.5, 36.75, 17.0]), Vec4([12.25, 6.5, 7.75, 16.0])];
        let expected_result_from_fourth_routine = [UVec4([0, 0, 0, 0]), UVec4([0, 0, 1, 1])];

        check_subroutine_support(context)?;

        let mut result = true;
        let mut program = Program::new(context);
        let mut transform_feedback_buffer = Buffer::new(context);
        let mut vao = VertexArray::new(context);

        program.build(
            &ProgramSources {
                vertex: Some(EIGHT_SUBROUTINES_VS),
                ..Default::default()
            },
            &EIGHT_SUBROUTINES_VARYINGS,
            false,
        )?;
        program.use_program()?;

        vao.generate()?;
        vao.bind()?;

        transform_feedback_buffer.generate()?;
        transform_feedback_buffer.update(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            TRANSFORM_FEEDBACK_BUFFER_SIZE as GLsizeiptr,
            std::ptr::null(),
            glw::GL_DYNAMIC_COPY,
        )?;
        transform_feedback_buffer.bind_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            0,
            TRANSFORM_FEEDBACK_BUFFER_SIZE as GLsizeiptr,
        )?;

        let mut subroutine_uniform_locations = [0 as GLint; 4];
        let mut subroutine_indices = [[0 as GLuint; 2]; 4];

        for type_ in 0..4 {
            subroutine_uniform_locations[type_] = program
                .get_subroutine_uniform_location(EIGHT_SUBROUTINES_UNIFORM_NAMES[type_], glw::GL_VERTEX_SHADER)?;

            for routine in 0..2 {
                subroutine_indices[type_][routine] =
                    program.get_subroutine_index(EIGHT_SUBROUTINES_NAMES[type_][routine], glw::GL_VERTEX_SHADER)?;
            }
        }

        let mut uniform_locations = [0 as GLint; 3];
        for (i, name) in EIGHT_SUBROUTINES_INPUT_NAMES.iter().enumerate() {
            uniform_locations[i] = program.get_uniform_location(name)?;
        }

        for combination_bits in 0..16usize {
            let combination: [usize; 4] = std::array::from_fn(|i| (combination_bits >> (3 - i)) & 1);

            let mut routine_indices = [0 as GLuint; 4];
            for i in 0..4 {
                routine_indices[subroutine_uniform_locations[i] as usize] = subroutine_indices[i][combination[i]];
            }

            gl_call!(
                gl,
                "UniformSubroutinesuiv",
                gl.uniform_subroutinesuiv(glw::GL_VERTEX_SHADER, 4, routine_indices.as_ptr())
            );

            for (i, location) in uniform_locations.iter().enumerate() {
                let value = input_data[i].0;
                gl_call!(
                    gl,
                    "Uniform4f",
                    gl.uniform_4f(*location, value[0], value[1], value[2], value[3])
                );
            }

            let words = draw_points_and_read_xfb(context, 1, 16)?;
            let first = words_as_vec4(&words, 0);
            let second = words_as_vec4(&words, 4);
            let third = words_as_vec4(&words, 8);
            let fourth = UVec4([words[12], words[13], words[14], words[15]]);

            let first_expected = expected_result_from_first_routine[combination[0]];
            let second_expected = expected_result_from_second_routine[combination[1]];
            let third_expected = expected_result_from_third_routine[combination[2]];
            let fourth_expected = expected_result_from_fourth_routine[combination[3]];

            if !(first.matches(&first_expected)
                && second.matches(&second_expected)
                && third.matches(&third_expected)
                && fourth == fourth_expected)
            {
                log::info!("Error. Invalid result.");
                log::info!(
                    "Function: {}( {:?}, {:?} ). Result: {first:?}. Expected: {first_expected:?}",
                    EIGHT_SUBROUTINES_NAMES[0][combination[0]],
                    input_data[0],
                    input_data[1]
                );
                log::info!(
                    "Function: {}( {:?} ). Result: {second:?}. Expected: {second_expected:?}",
                    EIGHT_SUBROUTINES_NAMES[1][combination[1]],
                    input_data[0]
                );
                log::info!(
                    "Function: {}( {:?}, {:?}, {:?}). Result: {third:?}. Expected: {third_expected:?}",
                    EIGHT_SUBROUTINES_NAMES[2][combination[2]],
                    input_data[0],
                    input_data[1],
                    input_data[2]
                );
                log::info!(
                    "Function: {}( {:?}, {:?},  ). Result: {fourth:?}. Expected: {fourth_expected:?}",
                    EIGHT_SUBROUTINES_NAMES[3][combination[3]],
                    input_data[0],
                    input_data[1]
                );
                result = false;
            }
        }

        verdict(result)
    }
}

const STATIC_CALL_VS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\n// Subroutine type\nsubroutine vec4 routine_type(in vec4 iparam);\n\n// Subroutine definition\nsubroutine(routine_type) vec4 square(in vec4 iparam)\n{\n    return iparam * iparam;\n}\n\n// Sub routine uniform\nsubroutine uniform routine_type routine;\n\n// Input data\nuniform vec4 input_data;\n\n// Output\nout  vec4 out_result;\n\nvoid main()\n{\n    out_result  = square(input_data);\n}\n\n";

/// `FunctionalTest6`
pub(super) struct StaticSubroutineCall;

impl TestCase for StaticSubroutineCall {
    fn name(&self) -> &str {
        "static_subroutine_call"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        const TRANSFORM_FEEDBACK_BUFFER_SIZE: usize = 4 * std::mem::size_of::<f32>();

        let input_data = Vec4([1.0, 4.0, 9.0, 16.0]);
        let expected_result = Vec4([1.0, 16.0, 81.0, 256.0]);

        check_subroutine_support(context)?;

        let mut program = Program::new(context);
        let mut transform_feedback_buffer = Buffer::new(context);
        let mut vao = VertexArray::new(context);

        program.build(
            &ProgramSources {
                vertex: Some(STATIC_CALL_VS),
                ..Default::default()
            },
            &["out_result"],
            false,
        )?;
        program.use_program()?;

        vao.generate()?;
        vao.bind()?;

        transform_feedback_buffer.generate()?;
        transform_feedback_buffer.update(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            TRANSFORM_FEEDBACK_BUFFER_SIZE as GLsizeiptr,
            std::ptr::null(),
            glw::GL_DYNAMIC_COPY,
        )?;
        transform_feedback_buffer.bind_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            0,
            TRANSFORM_FEEDBACK_BUFFER_SIZE as GLsizeiptr,
        )?;

        let name = std::ffi::CString::new("input_data").expect("names have no NUL");
        // SAFETY: the name is a live NUL-terminated string.
        let uniform_location = unsafe { gl.get_uniform_location(program.program_object_id, name.as_ptr()) };
        crate::glu::expect_no_error(gl, "GetUniformLocation")?;

        if uniform_location == -1 {
            return fail("Uniform is not available");
        }

        gl_call!(
            gl,
            "Uniform4f",
            gl.uniform_4f(
                uniform_location,
                input_data.0[0],
                input_data.0[1],
                input_data.0[2],
                input_data.0[3]
            )
        );

        let words = draw_points_and_read_xfb(context, 1, 4)?;
        let result = words_as_vec4(&words, 0);

        if expected_result.matches(&result) {
            return verdict(true);
        }

        log::info!("Error. Invalid result.");
        log::info!("Function: square( {input_data:?} ). Result: {result:?}. Expected: {expected_result:?}");
        verdict(false)
    }
}

const ARRAYED_UNIFORMS_VS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\n// Subroutine type\nsubroutine vec4 routine_type(in vec4 left, in vec4 right);\n\n// Subroutine definitions\nsubroutine(routine_type) vec4 add(in vec4 left, in vec4 right)\n{\n    return left + right;\n}\n\nsubroutine(routine_type) vec4 multiply(in vec4 left, in vec4 right)\n{\n    return left * right;\n}\n\n// Sub routine uniform\nsubroutine uniform routine_type routine[4];\n\n// Input data\nuniform vec4  uni_left;\nuniform vec4  uni_right;\nuniform uvec4 uni_indices;\n\n// Output\nout vec4 out_combined;\nout vec4 out_combined_inverted;\nout vec4 out_constant;\nout vec4 out_constant_inverted;\nout vec4 out_dynamic;\nout vec4 out_dynamic_inverted;\nout vec4 out_loop;\nout uint out_array_length;\n\nvoid main()\n{\n    out_combined          = routine[3](routine[2](routine[1](routine[0](uni_left, uni_right), uni_right), uni_right), uni_right);\n    out_combined_inverted = routine[0](routine[1](routine[2](routine[3](uni_left, uni_right), uni_right), uni_right), uni_right);\n    \n    out_constant          = routine[3](routine[2](routine[1](routine[0](vec4(1, 2, 3, 4), vec4(-5, -6, -7, -8)), vec4(-1, -2, -3, -4)), vec4(5, 6, 7, 8)), vec4(1, 2, 3, 4));\n    out_constant_inverted = routine[0](routine[1](routine[2](routine[3](vec4(1, 2, 3, 4), vec4(-5, -6, -7, -8)), vec4(-1, -2, -3, -4)), vec4(5, 6, 7, 8)), vec4(1, 2, 3, 4));\n    \n    out_dynamic           = routine[uni_indices.w](routine[uni_indices.z](routine[uni_indices.y](routine[uni_indices.x](uni_left, uni_right), uni_right), uni_right), uni_right);\n    out_dynamic_inverted  = routine[uni_indices.x](routine[uni_indices.y](routine[uni_indices.z](routine[uni_indices.w](uni_left, uni_right), uni_right), uni_right), uni_right);\n    \n    out_loop              = uni_left;\n    for (uint i = 0u; i < routine.length(); ++i)\n    {\n        out_loop          = routine[i](out_loop, uni_right);\n    }\n    \n    out_array_length      = routine.length() + 6 - (uni_indices.x + uni_indices.y + uni_indices.z + uni_indices.w);\n}\n\n";

const ARRAYED_UNIFORMS_VARYINGS: [&str; 8] = [
    "out_combined",
    "out_combined_inverted",
    "out_constant",
    "out_constant_inverted",
    "out_dynamic",
    "out_dynamic_inverted",
    "out_loop",
    "out_array_length",
];

/// `FunctionalTest7_8::calculate` of one operation: 0 adds, anything else multiplies.
fn calculate_operation(function: usize, left: &Vec4, right: &Vec4) -> Vec4 {
    Vec4(std::array::from_fn(|i| {
        if function == 0 {
            left.0[i] + right.0[i]
        } else {
            left.0[i] * right.0[i]
        }
    }))
}

/// `FunctionalTest7_8::calculate` over a whole combination: the seven vec4 results the shader writes.
fn calculate_combination(combination: &[usize; 4], left: &Vec4, right: &Vec4, indices: &UVec4) -> [Vec4; 7] {
    let dynamic_combination: [usize; 4] = std::array::from_fn(|i| combination[indices.0[i] as usize]);
    let constant_values = [
        Vec4([1.0, 2.0, 3.0, 4.0]),
        Vec4([-5.0, -6.0, -7.0, -8.0]),
        Vec4([-1.0, -2.0, -3.0, -4.0]),
        Vec4([5.0, 6.0, 7.0, 8.0]),
        Vec4([1.0, 2.0, 3.0, 4.0]),
    ];

    let mut combined = *left;
    let mut combined_inverted = *left;
    let mut constant = constant_values[0];
    let mut constant_inverted = constant_values[0];
    let mut dynamic = *left;
    let mut dynamic_inverted = *left;

    for i in 0..4 {
        combined = calculate_operation(combination[i], &combined, right);
        combined_inverted = calculate_operation(combination[3 - i], &combined_inverted, right);
        constant = calculate_operation(combination[i], &constant, &constant_values[i + 1]);
        constant_inverted = calculate_operation(combination[3 - i], &constant_inverted, &constant_values[i + 1]);
        dynamic = calculate_operation(dynamic_combination[i], &dynamic, right);
        dynamic_inverted = calculate_operation(dynamic_combination[3 - i], &dynamic_inverted, right);
    }

    [
        combined,
        combined_inverted,
        constant,
        constant_inverted,
        dynamic,
        dynamic_inverted,
        combined,
    ]
}

/// `FunctionalTest7_8`
pub(super) struct ArrayedSubroutineUniforms;

impl ArrayedSubroutineUniforms {
    /// `FunctionalTest7_8::testDraw`
    fn test_draw(
        context: &Context,
        combination: &[usize; 4],
        left: &Vec4,
        right: &Vec4,
        indices: &UVec4,
        subroutine_indices: &[GLuint; 2],
        subroutine_uniform_locations: &[GLint; 4],
        uniform_locations: &[GLint; 3],
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let expected_results = calculate_combination(combination, left, right, indices);

        gl_call!(
            gl,
            "Uniform4f",
            gl.uniform_4f(uniform_locations[0], left.0[0], left.0[1], left.0[2], left.0[3])
        );
        gl_call!(
            gl,
            "Uniform4f",
            gl.uniform_4f(uniform_locations[1], right.0[0], right.0[1], right.0[2], right.0[3])
        );
        gl_call!(
            gl,
            "Uniform4ui",
            gl.uniform_4ui(
                uniform_locations[2],
                indices.0[0],
                indices.0[1],
                indices.0[2],
                indices.0[3]
            )
        );

        let mut routine_indices = [0 as GLuint; 4];
        for i in 0..4 {
            routine_indices[subroutine_uniform_locations[i] as usize] = subroutine_indices[combination[i]];
        }

        gl_call!(
            gl,
            "UniformSubroutinesuiv",
            gl.uniform_subroutinesuiv(glw::GL_VERTEX_SHADER, 4, routine_indices.as_ptr())
        );

        let words = draw_points_and_read_xfb(context, 1, 7 * 4 + 1)?;
        let vec4_results: [Vec4; 7] = std::array::from_fn(|i| words_as_vec4(&words, i * 4));
        let array_length = words[7 * 4];

        let results: [bool; 7] = std::array::from_fn(|i| vec4_results[i].matches(&expected_results[i]));
        let result = results.iter().all(|&matched| matched) && array_length == 4;

        if !result {
            for i in 0..7 {
                if !results[i] {
                    log::info!(
                        "Error. Invalid result. Operation {i}, combination {combination:?}, left {left:?}, right {right:?}, indices {indices:?}"
                    );
                    log::info!("Result: {:?}", vec4_results[i]);
                    log::info!("Expected: {:?}", expected_results[i]);
                }
            }

            if array_length != 4 {
                log::info!("Error. Invalid array length: {array_length}. Expected 4.");
            }
        }

        Ok(result)
    }
}

impl TestCase for ArrayedSubroutineUniforms {
    fn name(&self) -> &str {
        "arrayed_subroutine_uniforms"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const TRANSFORM_FEEDBACK_BUFFER_SIZE: usize = 8 * 4 * std::mem::size_of::<f32>();

        let uni_left = Vec4([-1.0, 0.75, -0.5, 0.25]);
        let uni_right = Vec4([1.0, -0.75, 0.5, -0.25]);
        let uni_indices = UVec4([1, 2, 0, 3]);

        check_subroutine_support(context)?;

        let mut program = Program::new(context);
        let mut transform_feedback_buffer = Buffer::new(context);
        let mut vao = VertexArray::new(context);
        let mut result = true;

        program.build(
            &ProgramSources {
                vertex: Some(ARRAYED_UNIFORMS_VS),
                ..Default::default()
            },
            &ARRAYED_UNIFORMS_VARYINGS,
            false,
        )?;
        program.use_program()?;

        vao.generate()?;
        vao.bind()?;

        transform_feedback_buffer.generate()?;

        let mut subroutine_indices = [0 as GLuint; 2];
        for (routine, name) in ["add", "multiply"].iter().enumerate() {
            subroutine_indices[routine] = program.get_subroutine_index(name, glw::GL_VERTEX_SHADER)?;
        }

        let mut subroutine_uniform_locations = [0 as GLint; 4];
        for (uniform, name) in ["routine[0]", "routine[1]", "routine[2]", "routine[3]"]
            .iter()
            .enumerate()
        {
            subroutine_uniform_locations[uniform] =
                program.get_subroutine_uniform_location(name, glw::GL_VERTEX_SHADER)?;
        }

        let mut uniform_locations = [0 as GLint; 3];
        for (i, name) in ["uni_left", "uni_right", "uni_indices"].iter().enumerate() {
            uniform_locations[i] = program.get_uniform_location(name)?;
        }

        for combination_bits in 0..16usize {
            let combination: [usize; 4] = std::array::from_fn(|i| (combination_bits >> (3 - i)) & 1);

            transform_feedback_buffer.update(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                TRANSFORM_FEEDBACK_BUFFER_SIZE as GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY,
            )?;
            transform_feedback_buffer.bind_range(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                0,
                0,
                TRANSFORM_FEEDBACK_BUFFER_SIZE as GLsizeiptr,
            )?;

            if !ArrayedSubroutineUniforms::test_draw(
                context,
                &combination,
                &uni_left,
                &uni_right,
                &uni_indices,
                &subroutine_indices,
                &subroutine_uniform_locations,
                &uniform_locations,
            )? {
                result = false;
            }
        }

        verdict(result)
    }
}
