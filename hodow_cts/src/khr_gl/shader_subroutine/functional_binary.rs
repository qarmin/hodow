// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (FunctionalTest14_15)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::utils::{Buffer, Program, ProgramSources, UVec4, VertexArray, draw_points_and_read_xfb};
use super::{check_subroutine_support, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLint, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome};

const STRUCTURE_PARAMETERS_VS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\nstruct data\n{\n    uint r;\n    uint g;\n    uint b;\n    uint a;\n};\n\nsubroutine void routine_type_1(in data iparam, out data oparam);\nsubroutine void routine_type_2(inout data arg);\n\nsubroutine (routine_type_1) void invert(in data iparam, out data oparam)\n{\n    oparam.r = iparam.a;\n    oparam.g = iparam.b;\n    oparam.b = iparam.g;\n    oparam.a = iparam.r;\n}\n\nsubroutine (routine_type_1) void increment(in data iparam, out data oparam)\n{\n    oparam.r = 1 + iparam.r;\n    oparam.g = 1 + iparam.g;\n    oparam.b = 1 + iparam.b;\n    oparam.a = 1 + iparam.a;\n}\n\nsubroutine (routine_type_2) void div_by_2(inout data arg)\n{\n    arg.r = arg.r / 2;\n    arg.g = arg.g / 2;\n    arg.b = arg.b / 2;\n    arg.a = arg.a / 2;\n}\n\nsubroutine (routine_type_2) void decrement(inout data arg)\n{\n    arg.r = arg.r - 1;\n    arg.g = arg.g - 1;\n    arg.b = arg.b - 1;\n    arg.a = arg.a - 1;\n}\n\nsubroutine uniform routine_type_1 routine_1;\nsubroutine uniform routine_type_2 routine_2;\n\nuniform uvec4 uni_input;\n\nout uvec4 out_routine_1;\nout uvec4 out_routine_2;\n\n\nvoid main()\n{\n    data routine_1_input;\n    data routine_1_output;\n    data routine_2_arg;\n\n    routine_1_input.r = uni_input.r;\n    routine_1_input.g = uni_input.g;\n    routine_1_input.b = uni_input.b;\n    routine_1_input.a = uni_input.a;\n\n    routine_2_arg.r = uni_input.r;\n    routine_2_arg.g = uni_input.g;\n    routine_2_arg.b = uni_input.b;\n    routine_2_arg.a = uni_input.a;\n\n    routine_1(routine_1_input, routine_1_output);\n    routine_2(routine_2_arg);\n\n    out_routine_1.r = routine_1_output.r;\n    out_routine_1.g = routine_1_output.g;\n    out_routine_1.b = routine_1_output.b;\n    out_routine_1.a = routine_1_output.a;\n\n    out_routine_2.r = routine_2_arg.r;\n    out_routine_2.g = routine_2_arg.g;\n    out_routine_2.b = routine_2_arg.b;\n    out_routine_2.a = routine_2_arg.a;\n}\n\n";

const SUBROUTINE_NAMES: [[&str; 2]; 2] = [["invert", "increment"], ["div_by_2", "decrement"]];
const SUBROUTINE_UNIFORM_NAMES: [&str; 2] = ["routine_1", "routine_2"];

/// The two uvec4 varyings of one draw.
fn read_routine_results(context: &Context) -> Result<(UVec4, UVec4), TestError> {
    let words = draw_points_and_read_xfb(context, 1, 8)?;
    Ok((
        UVec4([words[0], words[1], words[2], words[3]]),
        UVec4([words[4], words[5], words[6], words[7]]),
    ))
}

/// `FunctionalTest14_15`
pub(super) struct StructureParametersProgramBinary;

impl StructureParametersProgramBinary {
    /// `FunctionalTest14_15::testDefaultSubroutineSet`
    fn test_default_subroutine_set(
        context: &Context,
        uniform_location: GLint,
        uni_input: &UVec4,
        expected_routine_1_result: &[UVec4; 2],
        expected_routine_2_result: &[UVec4; 2],
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        gl_call!(
            gl,
            "Uniform4f",
            gl.uniform_4ui(
                uniform_location,
                uni_input.0[0],
                uni_input.0[1],
                uni_input.0[2],
                uni_input.0[3]
            )
        );

        let (routine_1_result, routine_2_result) = read_routine_results(context)?;

        let result = expected_routine_1_result.contains(&routine_1_result)
            && expected_routine_2_result.contains(&routine_2_result);

        if !result {
            log::info!("Error. Invalid result.");
            log::info!("Routine_1, result: {routine_1_result:?}Routine_2, result: {routine_2_result:?}");
        }

        Ok(result)
    }

    /// `FunctionalTest14_15::testDraw`
    fn test_draw(
        context: &Context,
        routine_configuration: usize,
        uni_input: &UVec4,
        expected_routine_1_result: &UVec4,
        expected_routine_2_result: &UVec4,
        uniform_location: GLint,
        subroutine_indices: &[[GLuint; 2]; 2],
        subroutine_uniform_locations: &[GLint; 2],
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        gl_call!(
            gl,
            "Uniform4f",
            gl.uniform_4ui(
                uniform_location,
                uni_input.0[0],
                uni_input.0[1],
                uni_input.0[2],
                uni_input.0[3]
            )
        );

        let mut indices = [0 as GLuint; 2];
        for i in 0..2 {
            indices[subroutine_uniform_locations[i] as usize] = subroutine_indices[i][routine_configuration];
        }

        gl_call!(
            gl,
            "UniformSubroutinesuiv",
            gl.uniform_subroutinesuiv(glw::GL_VERTEX_SHADER, 2, indices.as_ptr())
        );

        let (routine_1_result, routine_2_result) = read_routine_results(context)?;
        let result = routine_1_result == *expected_routine_1_result && routine_2_result == *expected_routine_2_result;

        if !result {
            log::info!("Error. Invalid result.");
            log::info!(
                "Routine_1, result: {routine_1_result:?}, expected: {expected_routine_1_result:?}Routine_2, result: {routine_2_result:?}, expected: {expected_routine_2_result:?}"
            );
        }

        Ok(result)
    }
}

impl TestCase for StructureParametersProgramBinary {
    fn name(&self) -> &str {
        "structure_parameters_program_binary"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const TRANSFORM_FEEDBACK_BUFFER_SIZE: usize = 2 * 4 * std::mem::size_of::<GLuint>();

        let uni_input = [UVec4([8, 64, 4096, 16777216]), UVec4([8, 64, 4096, 16777216])];
        let out_routine_1 = [UVec4([16777216, 4096, 64, 8]), UVec4([9, 65, 4097, 16777217])];
        let out_routine_2 = [UVec4([4, 32, 2048, 8388608]), UVec4([7, 63, 4095, 16777215])];

        check_subroutine_support(context)?;

        let mut program = Program::new(context);
        let mut transform_feedback_buffer = Buffer::new(context);
        let mut vao = VertexArray::new(context);

        let is_program_binary_supported = program.is_program_binary_supported()?;

        program.build(
            &ProgramSources {
                vertex: Some(STRUCTURE_PARAMETERS_VS),
                ..Default::default()
            },
            &["out_routine_1", "out_routine_2"],
            false,
        )?;

        let mut initial_subroutine_indices = [[0 as GLuint; 2]; 2];
        let mut initial_subroutine_uniform_locations = [0 as GLint; 2];

        if is_program_binary_supported {
            for type_ in 0..2 {
                initial_subroutine_indices[type_][0] =
                    program.get_subroutine_index(SUBROUTINE_NAMES[type_][0], glw::GL_VERTEX_SHADER)?;
                initial_subroutine_indices[type_][1] =
                    program.get_subroutine_index(SUBROUTINE_NAMES[type_][1], glw::GL_VERTEX_SHADER)?;
            }

            for uniform in 0..2 {
                initial_subroutine_uniform_locations[uniform] = program
                    .get_subroutine_uniform_location(SUBROUTINE_UNIFORM_NAMES[uniform], glw::GL_VERTEX_SHADER)?;
            }

            let (program_binary, binary_format) = program.get_binary()?;
            program.remove();
            program.create_from_binary(&program_binary, binary_format)?;
        }

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

        let mut subroutine_indices = [[0 as GLuint; 2]; 2];
        for type_ in 0..2 {
            subroutine_indices[type_][0] =
                program.get_subroutine_index(SUBROUTINE_NAMES[type_][0], glw::GL_VERTEX_SHADER)?;
            subroutine_indices[type_][1] =
                program.get_subroutine_index(SUBROUTINE_NAMES[type_][1], glw::GL_VERTEX_SHADER)?;
        }

        let mut subroutine_uniform_locations = [0 as GLint; 2];
        for uniform in 0..2 {
            subroutine_uniform_locations[uniform] =
                program.get_subroutine_uniform_location(SUBROUTINE_UNIFORM_NAMES[uniform], glw::GL_VERTEX_SHADER)?;
        }

        let uniform_location = program.get_uniform_location("uni_input")?;

        let mut result = true;

        if is_program_binary_supported {
            if subroutine_indices != initial_subroutine_indices
                || subroutine_uniform_locations != initial_subroutine_uniform_locations
            {
                log::info!("Error. Subroutine indices or subroutine uniform location changed.");

                for type_ in 0..2 {
                    for i in 0..2 {
                        log::info!(
                            "Subroutine: {} index: {} initial index: {}",
                            SUBROUTINE_NAMES[type_][i],
                            subroutine_indices[type_][i],
                            initial_subroutine_indices[type_][i]
                        );
                    }
                }

                for uniform in 0..2 {
                    log::info!(
                        "Subroutine uniform: {} location: {} initial location: {}",
                        SUBROUTINE_UNIFORM_NAMES[uniform],
                        subroutine_uniform_locations[uniform],
                        initial_subroutine_uniform_locations[uniform]
                    );
                }

                result = false;
            }

            if !Self::test_default_subroutine_set(
                context,
                uniform_location,
                &uni_input[0],
                &out_routine_1,
                &out_routine_2,
            )? {
                result = false;
            }
        }

        for i in 0..2 {
            if !Self::test_draw(
                context,
                i,
                &uni_input[i],
                &out_routine_1[i],
                &out_routine_2[i],
                uniform_location,
                &subroutine_indices,
                &subroutine_uniform_locations,
            )? {
                result = false;
            }
        }

        verdict(result)
    }
}
