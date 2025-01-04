// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cShaderSubroutineTests.cpp  (FunctionalTest9, FunctionalTest10, FunctionalTest11)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::utils::{Buffer, Framebuffer, Program, ProgramSources, Texture, VertexArray, draw_points_and_read_xfb};
use super::{ShaderStage, build_program, check_subroutine_support, fail, verdict};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLint, GLsizeiptr, GLuint};
use crate::tcu::{TestError, TestOutcome};

const THREE_TYPES_VS: &str = "#version 400\n\n#extension GL_ARB_shader_subroutine : require\n\nsubroutine void subroutineType1(inout float);\nsubroutine void subroutineType2(inout float);\nsubroutine void subroutineType3(inout float);\n\nsubroutine(subroutineType1, subroutineType2, subroutineType3) void function(inout float result)\n{\n    result += float(0.123) + float(gl_VertexID);\n}\n\nsubroutine uniform subroutineType1 subroutine_uniform1;\nsubroutine uniform subroutineType2 subroutine_uniform2;\nsubroutine uniform subroutineType3 subroutine_uniform3;\n\nout vec4 result;\n\nvoid main()\n{\n    result = vec4(0, 1, 2, 3);\n\n    subroutine_uniform1(result.x);\n    subroutine_uniform2(result.y);\n    subroutine_uniform3(result.z);\n\n    result.w += result.x + result.y + result.z;\n}\n";

/// `FunctionalTest9`
pub(super) struct ThreeTypesOneFunction;

impl TestCase for ThreeTypesOneFunction {
    fn name(&self) -> &str {
        "subroutines_3_subroutine_types_and_subroutine_uniforms_one_function"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const N_POINTS_TO_DRAW: usize = 16;
        let gl = context.gl();
        let mut has_test_passed = true;

        check_subroutine_support(context)?;

        let Some(program) = build_program(gl, &[(ShaderStage::Vertex, THREE_TYPES_VS)], Some(&["result"]))? else {
            return fail("Program failed to link successfully");
        };

        let xfb_bo_size = std::mem::size_of::<f32>() * 4 * N_POINTS_TO_DRAW;
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
        gl_call!(
            gl,
            "glBufferData() call failed.",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                xfb_bo_size as GLsizeiptr,
                std::ptr::null(),
                glw::GL_STATIC_COPY
            )
        );
        vao.generate()?;
        vao.bind()?;

        gl_call!(gl, "glUseProgram() call failed.", gl.use_program(program.program));

        let words = draw_points_and_read_xfb(context, N_POINTS_TO_DRAW as glw::GLsizei, N_POINTS_TO_DRAW * 4)?;
        let epsilon = 1e-5;

        for n_point in 0..N_POINTS_TO_DRAW {
            let mut expected_result = [0.0f32, 1.0, 2.0, 3.0];

            for component in expected_result.iter_mut().take(3) {
                *component += 0.123 + n_point as f32;
            }
            expected_result[3] += expected_result[0] + expected_result[1] + expected_result[2];

            let found: [f32; 4] = std::array::from_fn(|i| f32::from_bits(words[n_point * 4 + i]));

            if (0..4).any(|i| (expected_result[i] - found[i]).abs() > epsilon) {
                log::info!(
                    "XFBed data is invalid. Expected:({}, {}, {}, {}), found:({}, {}, {}, {}).",
                    expected_result[0],
                    expected_result[1],
                    expected_result[2],
                    expected_result[3],
                    found[0],
                    found[1],
                    found[2],
                    found[3]
                );
                has_test_passed = false;
                break;
            }
        }

        verdict(has_test_passed)
    }
}

const ARRAYS_OF_ARRAYS_VS: &str = "#version 400 core\n#extension GL_ARB_arrays_of_arrays  : require\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\n// Subroutine type\nsubroutine int routine_type(in int iparam);\n\n// Subroutine definitions\nsubroutine(routine_type) int increment(in int iparam)\n{\n    return iparam + 1;\n}\n\nsubroutine(routine_type) int decrement(in int iparam)\n{\n    return iparam - 1;\n}\n\n// Sub routine uniform\nsubroutine uniform routine_type routine[4][4];\n\n// Output\nout int out_result;\n\nvoid main()\n{\n    int result = 0;\n    \n    for (uint j = 0; j < routine.length(); ++j)\n    {\n        for (uint i = 0; i < routine[j].length(); ++i)\n        {\n            result = routine[j][i](result);\n        }\n    }\n    \n    out_result = result;\n}\n\n";

const ARRAYS_OF_ARRAYS_UNIFORM_NAMES: [&str; 16] = [
    "routine[0][0]",
    "routine[1][0]",
    "routine[2][0]",
    "routine[3][0]",
    "routine[0][1]",
    "routine[1][1]",
    "routine[2][1]",
    "routine[3][1]",
    "routine[0][2]",
    "routine[1][2]",
    "routine[2][2]",
    "routine[3][2]",
    "routine[0][3]",
    "routine[1][3]",
    "routine[2][3]",
    "routine[3][3]",
];

/// `FunctionalTest10`
pub(super) struct ArraysOfArraysOfUniforms;

impl ArraysOfArraysOfUniforms {
    /// `FunctionalTest10::testDraw`
    fn test_draw(
        context: &Context,
        routine_indices: &[usize; 16],
        subroutine_indices: &[GLuint; 2],
        subroutine_uniform_locations: &[GLint; 16],
    ) -> Result<GLint, TestError> {
        let gl = context.gl();
        let mut indices = [0 as GLuint; 16];

        for i in 0..16 {
            indices[subroutine_uniform_locations[i] as usize] = subroutine_indices[routine_indices[i]];
        }

        gl_call!(
            gl,
            "UniformSubroutinesuiv",
            gl.uniform_subroutinesuiv(glw::GL_VERTEX_SHADER, 16, indices.as_ptr())
        );

        let words = draw_points_and_read_xfb(context, 1, 1)?;
        Ok(words[0] as GLint)
    }
}

impl TestCase for ArraysOfArraysOfUniforms {
    fn name(&self) -> &str {
        "arrays_of_arrays_of_uniforms"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const TRANSFORM_FEEDBACK_BUFFER_SIZE: usize = std::mem::size_of::<GLint>();

        let configuration_increment = [0usize; 16];
        let configuration_decrement = [1usize; 16];
        let configuration_mix = [1usize, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1];

        check_subroutine_support(context)?;

        if !context.context_info.is_extension_supported("GL_ARB_arrays_of_arrays") {
            return Err(TestError::NotSupported(
                "GL_ARB_arrays_of_arrays is not supported.".to_string(),
            ));
        }

        let mut result = true;
        let mut program = Program::new(context);
        let mut transform_feedback_buffer = Buffer::new(context);
        let mut vao = VertexArray::new(context);

        program.build(
            &ProgramSources {
                vertex: Some(ARRAYS_OF_ARRAYS_VS),
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

        let mut subroutine_indices = [0 as GLuint; 2];
        for (routine, name) in ["increment", "decrement"].iter().enumerate() {
            subroutine_indices[routine] = program.get_subroutine_index(name, glw::GL_VERTEX_SHADER)?;
        }

        let mut subroutine_uniform_locations = [0 as GLint; 16];
        for (uniform, name) in ARRAYS_OF_ARRAYS_UNIFORM_NAMES.iter().enumerate() {
            subroutine_uniform_locations[uniform] =
                program.get_subroutine_uniform_location(name, glw::GL_VERTEX_SHADER)?;
        }

        let increment_result = Self::test_draw(
            context,
            &configuration_increment,
            &subroutine_indices,
            &subroutine_uniform_locations,
        )?;
        let decrement_result = Self::test_draw(
            context,
            &configuration_decrement,
            &subroutine_indices,
            &subroutine_uniform_locations,
        )?;
        let mix_result = Self::test_draw(
            context,
            &configuration_mix,
            &subroutine_indices,
            &subroutine_uniform_locations,
        )?;

        if increment_result != 16 {
            result = false;
        }
        if decrement_result != -16 {
            result = false;
        }
        if mix_result != 0 {
            result = false;
        }

        if !result {
            log::info!(
                "Error. Invalid result. Incrementation applied 16 times: {increment_result}. Decrementation applied 16 times: {decrement_result}. Incrementation and decrementation applied 8 times: {mix_result}"
            );
        }

        verdict(result)
    }
}

const TEXTURE_HEIGHT: GLuint = 32;
const TEXTURE_WIDTH: GLuint = 32;

const GLOBALS_FS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\n// Output\nlayout(location = 0) out vec4 out_color;\n\n// Global variables\nvec4 success_color;\nvec4 failure_color;\n\n// Samplers\nuniform sampler2D sampler_1;\nuniform sampler2D sampler_2;\n\n// Functions\nbool are_same(in vec4 left, in vec4 right)\n{\n    bvec4 result;\n\n    result.x = (left.x == right.x);\n    result.y = (left.y == right.y);\n    result.z = (left.z == right.z);\n    result.w = (left.w == right.w);\n\n    return all(result);\n}\n\nbool are_different(in vec4 left, in vec4 right)\n{\n    bvec4 result;\n\n    result.x = (left.x != right.x);\n    result.y = (left.y != right.y);\n    result.z = (left.z != right.z);\n    result.w = (left.w != right.w);\n\n    return any(result);\n}\n\n// Subroutine types\nsubroutine void discard_fragment_type(void);\nsubroutine void set_global_colors_type(void);\nsubroutine vec4 sample_texture_type(in vec2);\nsubroutine bool comparison_type(in vec4 left, in vec4 right);\nsubroutine void test_type(void);\n\n// Subroutine definitions\n// discard_fragment_type\nsubroutine(discard_fragment_type) void discard_yes(void)\n{\n    discard;\n}\n\nsubroutine(discard_fragment_type) void discard_no(void)\n{\n}\n\n// set_global_colors_type\nsubroutine(set_global_colors_type) void red_pass_blue_fail(void)\n{\n    success_color = vec4(1, 0, 0, 1);\n    failure_color = vec4(0, 0, 1, 1);\n}\n\nsubroutine(set_global_colors_type) void blue_pass_red_fail(void)\n{\n    success_color = vec4(0, 0, 1, 1);\n    failure_color = vec4(1, 0, 0, 1);\n}\n\n// sample_texture_type\nsubroutine(sample_texture_type) vec4 first_sampler(in vec2 coord)\n{\n    return texture(sampler_1, coord);\n}\n\nsubroutine(sample_texture_type) vec4 second_sampler(in vec2 coord)\n{\n    return texture(sampler_2, coord);\n}\n\n// comparison_type\nsubroutine(comparison_type) bool check_equal(in vec4 left, in vec4 right)\n{\n    return are_same(left, right);\n}\n\nsubroutine(comparison_type) bool check_not_equal(in vec4 left, in vec4 right)\n{\n    return are_different(left, right);\n}\n\n// Subroutine uniforms\nsubroutine uniform discard_fragment_type  discard_fragment;\nsubroutine uniform set_global_colors_type set_global_colors;\nsubroutine uniform sample_texture_type    sample_texture;\nsubroutine uniform comparison_type        compare;\n\n// Subroutine definitions\n// test_type\nsubroutine(test_type) void test_with_discard(void)\n{\n    discard_fragment();\n    out_color = failure_color;\n\n    set_global_colors();\n\n    vec4 sampled_color = sample_texture(gl_PointCoord);\n\n    bool comparison_result = compare(success_color, sampled_color);\n\n    if (true == comparison_result)\n    {\n        out_color = success_color;\n    }\n    else\n    {\n        out_color = failure_color;\n    }\n}\n\nsubroutine(test_type) void test_without_discard(void)\n{\n    set_global_colors();\n\n    vec4 sampled_color = sample_texture(gl_PointCoord);\n\n    bool comparison_result = compare(success_color, sampled_color);\n\n    if (true == comparison_result)\n    {\n        out_color = success_color;\n    }\n    else\n    {\n        out_color = failure_color;\n    }\n}\n\n// Subroutine uniforms\nsubroutine uniform test_type test;\n\nvoid main()\n{\n    // Set colors\n    success_color = vec4(0.5, 0.5, 0.5, 0.5);\n    failure_color = vec4(0.5, 0.5, 0.5, 0.5);\n\n    test();\n}\n\n";

const GLOBALS_GS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\nlayout(points)                           in;\nlayout(triangle_strip, max_vertices = 4) out;\n\nvoid main()\n{\n    gl_Position = vec4(-1, -1, 0, 1);\n    EmitVertex();\n    \n    gl_Position = vec4(-1,  1, 0, 1);\n    EmitVertex();\n    \n    gl_Position = vec4( 1, -1, 0, 1);\n    EmitVertex();\n    \n    gl_Position = vec4( 1,  1, 0, 1);\n    EmitVertex();\n    \n    EndPrimitive();\n}\n\n";

const GLOBALS_VS: &str = "#version 400 core\n#extension GL_ARB_shader_subroutine : require\n\nprecision highp float;\n\nvoid main()\n{\n}\n\n";

const GLOBALS_SUBROUTINE_NAMES: [[&str; 2]; 5] = [
    ["discard_yes", "discard_no"],
    ["red_pass_blue_fail", "blue_pass_red_fail"],
    ["first_sampler", "second_sampler"],
    ["check_equal", "check_not_equal"],
    ["test_with_discard", "test_without_discard"],
];
const GLOBALS_SUBROUTINE_UNIFORM_NAMES: [&str; 5] = [
    "discard_fragment",
    "set_global_colors",
    "sample_texture",
    "compare",
    "test",
];

/// `FunctionalTest11::testConfiguration`
struct TestConfiguration {
    description: &'static str,
    expected_color: [u8; 4],
    routines: [usize; 5],
    samplers: [usize; 2],
}

/// `FunctionalTest11`
pub(super) struct GlobalsSamplingOutputDiscardFunctionCalls;

impl GlobalsSamplingOutputDiscardFunctionCalls {
    /// `FunctionalTest11::fillTexture`
    fn fill_texture(texture: &Texture, color: &[u8; 4]) -> Result<(), TestError> {
        let texture_data: Vec<u8> = (0..TEXTURE_WIDTH * TEXTURE_HEIGHT).flat_map(|_| *color).collect();
        texture.update(
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            texture_data.as_ptr().cast(),
        )
    }

    /// `FunctionalTest11::testDraw`
    fn test_draw(
        context: &Context,
        routine_configuration: &[usize; 5],
        sampler_configuration: &[usize; 2],
        expected_color: &[u8; 4],
        color_texture: &Texture,
        source_textures: &[GLuint; 2],
        subroutine_indices: &[[GLuint; 2]; 5],
        subroutine_uniform_locations: &[GLint; 5],
        uniform_locations: &[GLint; 2],
    ) -> Result<bool, TestError> {
        let gl = context.gl();

        for i in 0..2 {
            let texture = source_textures[sampler_configuration[i]];

            gl_call!(gl, "ActiveTexture", gl.active_texture(glw::GL_TEXTURE0 + i as u32));
            gl_call!(gl, "BindTexture", gl.bind_texture(glw::GL_TEXTURE_2D, texture));
            gl_call!(gl, "Uniform1i", gl.uniform_1i(uniform_locations[i], i as GLint));
        }

        // SAFETY: plain state call.
        unsafe { gl.active_texture(glw::GL_TEXTURE0) };

        let mut indices = [0 as GLuint; 5];
        for i in 0..5 {
            indices[subroutine_uniform_locations[i] as usize] = subroutine_indices[i][routine_configuration[i]];
        }

        gl_call!(
            gl,
            "UniformSubroutinesuiv",
            gl.uniform_subroutinesuiv(glw::GL_FRAGMENT_SHADER, 5, indices.as_ptr())
        );
        gl_call!(gl, "DrawArrays", gl.draw_arrays(glw::GL_POINTS, 0, 1));

        let mut captured_data = vec![0u8; (TEXTURE_WIDTH * TEXTURE_HEIGHT * 4) as usize];
        color_texture.get(glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, captured_data.as_mut_ptr().cast())?;

        Ok(captured_data.chunks_exact(4).all(|pixel| pixel == expected_color))
    }
}

impl TestCase for GlobalsSamplingOutputDiscardFunctionCalls {
    fn name(&self) -> &str {
        "globals_sampling_output_discard_function_calls"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const BLUE_COLOR: [u8; 4] = [0, 0, 255, 255];
        const CLEAN_COLOR: [u8; 4] = [0, 0, 0, 0];
        const RED_COLOR: [u8; 4] = [255, 0, 0, 255];

        let test_configurations = [
            TestConfiguration {
                description: "Expect red color from 1st sampler",
                expected_color: RED_COLOR,
                routines: [1, 0, 0, 0, 0],
                samplers: [1, 0],
            },
            TestConfiguration {
                description: "Test \"without discard\" option, expect no blue color from 2nd sampler",
                expected_color: BLUE_COLOR,
                routines: [0, 1, 1, 1, 1],
                samplers: [0, 1],
            },
            TestConfiguration {
                description: "Fragment shoud be discarded",
                expected_color: CLEAN_COLOR,
                routines: [0, 0, 0, 0, 0],
                samplers: [1, 0],
            },
            TestConfiguration {
                description: "Expect blue color from 1st sampler",
                expected_color: BLUE_COLOR,
                routines: [1, 1, 0, 0, 0],
                samplers: [0, 1],
            },
            TestConfiguration {
                description: "Expect red color from 2nd sampler",
                expected_color: RED_COLOR,
                routines: [1, 0, 1, 0, 0],
                samplers: [0, 1],
            },
            TestConfiguration {
                description: "Expect no blue color from 2nd sampler",
                expected_color: BLUE_COLOR,
                routines: [1, 1, 1, 1, 0],
                samplers: [0, 1],
            },
        ];

        check_subroutine_support(context)?;

        let mut blue_texture = Texture::new(context);
        let mut color_texture = Texture::new(context);
        let mut framebuffer = Framebuffer::new(context);
        let mut program = Program::new(context);
        let mut red_texture = Texture::new(context);
        let mut vao = VertexArray::new(context);

        program.build(
            &ProgramSources {
                fragment: Some(GLOBALS_FS),
                geometry: Some(GLOBALS_GS),
                vertex: Some(GLOBALS_VS),
                ..Default::default()
            },
            &[],
            false,
        )?;
        program.use_program()?;

        vao.generate()?;
        vao.bind()?;

        blue_texture.create(TEXTURE_WIDTH, TEXTURE_HEIGHT, glw::GL_RGBA8)?;
        color_texture.create(TEXTURE_WIDTH, TEXTURE_HEIGHT, glw::GL_RGBA8)?;
        red_texture.create(TEXTURE_WIDTH, TEXTURE_HEIGHT, glw::GL_RGBA8)?;

        framebuffer.generate()?;
        framebuffer.bind()?;
        framebuffer.attach_texture(
            glw::GL_COLOR_ATTACHMENT0,
            color_texture.id,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
        )?;

        let mut subroutine_indices = [[0 as GLuint; 2]; 5];
        for type_ in 0..5 {
            subroutine_indices[type_][0] =
                program.get_subroutine_index(GLOBALS_SUBROUTINE_NAMES[type_][0], glw::GL_FRAGMENT_SHADER)?;
            subroutine_indices[type_][1] =
                program.get_subroutine_index(GLOBALS_SUBROUTINE_NAMES[type_][1], glw::GL_FRAGMENT_SHADER)?;
        }

        let mut subroutine_uniform_locations = [0 as GLint; 5];
        for (uniform, name) in GLOBALS_SUBROUTINE_UNIFORM_NAMES.iter().enumerate() {
            subroutine_uniform_locations[uniform] =
                program.get_subroutine_uniform_location(name, glw::GL_FRAGMENT_SHADER)?;
        }

        let mut uniform_locations = [0 as GLint; 2];
        for (i, name) in ["sampler_1", "sampler_2"].iter().enumerate() {
            uniform_locations[i] = program.get_uniform_location(name)?;
        }

        Self::fill_texture(&blue_texture, &BLUE_COLOR)?;
        Self::fill_texture(&color_texture, &CLEAN_COLOR)?;
        Self::fill_texture(&red_texture, &RED_COLOR)?;

        let source_textures = [blue_texture.id, red_texture.id];

        framebuffer.clear_color(0.0, 0.0, 0.0, 0.0)?;

        let mut result = true;

        for configuration in &test_configurations {
            framebuffer.clear(glw::GL_COLOR_BUFFER_BIT)?;

            if !Self::test_draw(
                context,
                &configuration.routines,
                &configuration.samplers,
                &configuration.expected_color,
                &color_texture,
                &source_textures,
                &subroutine_indices,
                &subroutine_uniform_locations,
                &uniform_locations,
            )? {
                log::info!("Error. Failure for configuration: {}", configuration.description);
                result = false;
            }
        }

        verdict(result)
    }
}
