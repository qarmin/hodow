// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5FmaAccuracy.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling; the GL object bookkeeping is `common::Objects`.

use std::ffi::CString;

use super::common::{Objects, require_gpu_shader5, run_case};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GPUShader5FmaAccuracyTest`
pub(super) struct FmaAccuracy {
    pub ext_params: ExtParameters,
}

const BUFFER_SIZE: isize = std::mem::size_of::<f32>() as isize;
const N_DRAW_CALL_EXECUTIONS: usize = 10;
const EXPECTED_RESULT: f32 = 2.71828;

const FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nlayout(location = 0) out vec4 fs_out_color;\n\nvoid main()\n{\n    fs_out_color = vec4(1, 1, 1, 1);\n}\n";
const VERTEX_SHADER_CODE_FOR_FMA_PASS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nuniform uint  uni_number_of_steps;\nout     float vs_fs_result;\n\nvoid main()\n{\n    float border_case   = 1.0;\n    float h             = 1.0 / float(uni_number_of_steps);\n    float current_value = border_case;\n\n    for (uint step = 0u; step < uni_number_of_steps; ++step)\n    {\n        float next_value = fma(h, current_value, current_value);\n\n        current_value = next_value;\n    }\n\n    vs_fs_result = current_value;\n}\n";
const VERTEX_SHADER_CODE_FOR_FLOAT_PASS: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nuniform uint  uni_number_of_steps;\nout     float vs_fs_result;\n\nvoid main()\n{\n    float border_case   = 1.0;\n    float h             = 1.0 / float(uni_number_of_steps);\n    float current_value = border_case;\n\n    for (uint step = 0u; step < uni_number_of_steps; ++step)\n    {\n        float next_value = h * current_value + current_value;\n\n        current_value = next_value;\n    }\n\n    vs_fs_result = current_value;\n}\n";

impl FmaAccuracy {
    /// `getNumberOfStepsForIndex`
    fn number_of_steps_for_index(index: usize) -> GLuint {
        let mut number_of_steps: GLuint = 10;

        for _ in 0..index {
            number_of_steps *= 2;
        }

        number_of_steps
    }

    /// `calculateRelativeError`
    fn calculate_relative_error(result: f32, expected_result: f32) -> f32 {
        let delta = (expected_result - result).abs();

        delta / expected_result
    }

    /// `logArray`
    fn log_array(description: &str, data: &[f32]) {
        let values: String = data.iter().map(|value| format!("{value} | ")).collect();

        log::info!("{description}");
        log::info!("| {values}");
    }

    /// `executePass`
    fn execute_pass(
        &self,
        context: &Context,
        program_object_id: GLuint,
        buffer_object_id: GLuint,
    ) -> Result<[f32; N_DRAW_CALL_EXECUTIONS], TestError> {
        let gl = context.gl();
        let mut results = [0.0f32; N_DRAW_CALL_EXECUTIONS];

        let uniform_name = CString::new("uni_number_of_steps").expect("no nul byte");
        let uniform_location = gl!(gl.get_uniform_location(program_object_id, uniform_name.as_ptr()));
        glu::expect_no_error(gl, "Failed to get uniform location")?;

        if uniform_location == -1 {
            return Err(TestError::Fail("Unexpected inactive uniform location".to_string()));
        }

        // Setup transform feedback
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) call failed")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, buffer_object_id));
        glu::expect_no_error(
            gl,
            "Failed to bind buffer object id to transform feedback binding point",
        )?;

        // Setup draw call
        gl!(gl.use_program(program_object_id));
        glu::expect_no_error(gl, "glUseProgram() failed")?;

        for (i, result) in results.iter_mut().enumerate() {
            // Get number of steps for the Euler iterative algorithm
            let number_of_steps = Self::number_of_steps_for_index(i);

            gl!(gl.uniform_1ui(uniform_location, number_of_steps));
            glu::expect_no_error(gl, "Failed to set uniform data")?;

            gl!(gl.begin_transform_feedback(glw::GL_POINTS));
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "Error doing a draw call")?;

            // Map transfrom feedback results
            let mapped =
                gl!(gl.map_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, BUFFER_SIZE, glw::GL_MAP_READ_BIT));
            glu::expect_no_error(gl, "Could not map the buffer object into process space")?;
            if mapped.is_null() {
                return Err(TestError::Fail(
                    "Could not map the buffer object into process space".to_string(),
                ));
            }
            // SAFETY: one float was mapped for reading; the mapping lives until the unmap below.
            *result = unsafe { *mapped.cast::<f32>() };

            gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
            glu::expect_no_error(gl, "Error unmapping the buffer object")?;
        }

        Ok(results)
    }

    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        let gl = context.gl();

        // initTest: this test should only run if gpu_shader5 is supported
        require_gpu_shader5(base)?;

        let program_object_id_for_fma_pass = gl!(gl.create_program());
        let program_object_id_for_float_pass = gl!(gl.create_program());
        objects
            .programs
            .extend([program_object_id_for_fma_pass, program_object_id_for_float_pass]);
        let fragment_shader_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        let vertex_shader_id_for_fma_pass = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        let vertex_shader_id_for_float_pass = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        objects.shaders.extend([
            fragment_shader_id,
            vertex_shader_id_for_fma_pass,
            vertex_shader_id_for_float_pass,
        ]);
        glu::expect_no_error(gl, "Failed to create program or shader object(s)")?;

        // Declare a name of a varying captured via TF
        let captured_varying_name = CString::new("vs_fs_result").expect("no nul byte");
        let captured_varying_pointer = captured_varying_name.as_ptr();

        // Build program for fma pass
        gl!(gl.transform_feedback_varyings(
            program_object_id_for_fma_pass,
            1,
            &captured_varying_pointer,
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        let (built, _) = base.build_program(
            context,
            program_object_id_for_fma_pass,
            &[
                ShaderBody::Source(fragment_shader_id, &[FRAGMENT_SHADER_CODE]),
                ShaderBody::Source(vertex_shader_id_for_fma_pass, &[VERTEX_SHADER_CODE_FOR_FMA_PASS]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from a valid vertex/fragment shader".to_string(),
            ));
        }

        // Build program for float pass
        gl!(gl.transform_feedback_varyings(
            program_object_id_for_float_pass,
            1,
            &captured_varying_pointer,
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        let (built, _) = base.build_program(
            context,
            program_object_id_for_float_pass,
            &[
                ShaderBody::Source(fragment_shader_id, &[FRAGMENT_SHADER_CODE]),
                ShaderBody::Source(vertex_shader_id_for_float_pass, &[VERTEX_SHADER_CODE_FOR_FLOAT_PASS]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create program from valid vertex/fragment shader".to_string(),
            ));
        }

        // Generate and bind VAO
        let mut vertex_array_object_id: GLuint = 0;
        gl!(gl.gen_vertex_arrays(1, &mut vertex_array_object_id));
        objects.vertex_arrays.push(vertex_array_object_id);
        gl!(gl.bind_vertex_array(vertex_array_object_id));
        glu::expect_no_error(gl, "Could not create and bind vertex array object")?;

        // Generate, bind and allocate buffer
        let mut buffer_object_id: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut buffer_object_id));
        objects.buffers.push(buffer_object_id);
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, buffer_object_id));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, BUFFER_SIZE, std::ptr::null(), glw::GL_STATIC_DRAW));
        glu::expect_no_error(gl, "Could not create vertex array object")?;

        // iterate
        let results_of_fma_pass = self.execute_pass(context, program_object_id_for_fma_pass, buffer_object_id)?;
        let results_of_float_pass = self.execute_pass(context, program_object_id_for_float_pass, buffer_object_id)?;

        let mut relative_errors_for_fma_pass = [0.0f32; N_DRAW_CALL_EXECUTIONS];
        let mut relative_errors_for_float_pass = [0.0f32; N_DRAW_CALL_EXECUTIONS];

        for i in 0..N_DRAW_CALL_EXECUTIONS {
            relative_errors_for_fma_pass[i] = Self::calculate_relative_error(results_of_fma_pass[i], EXPECTED_RESULT);
            relative_errors_for_float_pass[i] =
                Self::calculate_relative_error(results_of_float_pass[i], EXPECTED_RESULT);
        }

        let relative_error_sum_for_fma_pass: f32 = relative_errors_for_fma_pass.iter().sum();
        let relative_error_sum_for_float_pass: f32 = relative_errors_for_float_pass.iter().sum();

        if relative_error_sum_for_fma_pass <= relative_error_sum_for_float_pass {
            return Ok(TestStatus::pass("Pass"));
        }

        log::info!("Routine fma has lower accuracy than a * b + c !");

        log::info!("Sum of relative error");
        log::info!("fma       {relative_error_sum_for_fma_pass}");
        log::info!("a * b + c {relative_error_sum_for_float_pass}");

        log::info!("Relative errors");
        Self::log_array("fma", &relative_errors_for_fma_pass);
        Self::log_array("a * b + c", &relative_errors_for_float_pass);

        log::info!("Results");
        Self::log_array("fma", &results_of_fma_pass);
        Self::log_array("a * b + c", &results_of_float_pass);

        Ok(TestStatus::fail("Fail"))
    }
}

impl TestCase for FmaAccuracy {
    fn name(&self) -> &str {
        "fma_accuracy"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        run_case(context, self.ext_params, |context, base, objects| {
            self.run(context, base, objects)
        })
    }
}
