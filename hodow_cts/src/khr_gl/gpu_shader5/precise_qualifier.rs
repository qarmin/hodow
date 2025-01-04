// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5PreciseQualifier.cpp / .hpp
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
use crate::khr_gl::esext::{ExtParameters, RandomFormula, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GPUShader5PreciseQualifier`
pub(super) struct PreciseQualifier {
    pub ext_params: ExtParameters,
}

const N_COMPONENTS: usize = 4;
const N_ITERATIONS: GLuint = 100;
const POSITION_RANGE: i32 = 1000;

const FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nout vec4 color;\n\nvoid main()\n{\n   color = vec4(1, 1, 1, 1);\n}\n";
const VERTEX_SHADER_CODE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nlayout(location = 0) in  vec4 positions;\nlayout(location = 1) in  vec4 weights;\nout vec4 weightedSum;\n\nvoid eval(in vec4 p, in vec4 w, precise out float result)\n{\n    result = (p.x*w.x + p.y*w.y) + (p.z*w.z + p.w*w.w);\n}\n\nfloat eval(in vec4 p, in vec4 w)\n{\n    precise float result = (p.x*w.x + p.y*w.y) + (p.z*w.z + p.w*w.w);\n\n    return result;\n}\nvoid main()\n{\n    eval(positions, weights, weightedSum.x);\n\n    weightedSum.y = eval(positions, weights);\n\n    precise float result = 0.0f;\n\n    result        = (positions.x * weights.x + positions.y * weights.y) +\n                    (positions.z * weights.z + positions.w * weights.w);\n    weightedSum.z = result;\n    weightedSum.w = (positions.x * weights.x + positions.y * weights.y) + \n                    (positions.z * weights.z + positions.w * weights.w);\n}\n";

impl PreciseQualifier {
    /// `drawAndGetFeedbackResult`; the `WeightedSum` union is read back as bit patterns.
    fn draw_and_get_feedback_result(
        &self,
        context: &Context,
        positions_buffer_id: GLuint,
        weights_buffer_id: GLuint,
        vertex_data_positions: &[f32; N_COMPONENTS],
        vertex_data_weights: &[f32; N_COMPONENTS],
    ) -> Result<[u32; N_COMPONENTS], TestError> {
        let gl = context.gl();
        let data_size = (std::mem::size_of::<f32>() * N_COMPONENTS) as isize;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, positions_buffer_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            data_size,
            vertex_data_positions.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "Could not set buffer object's data!")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, weights_buffer_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            data_size,
            vertex_data_weights.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "Could not set buffer object's data!")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) failed")?;

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback(GL_POINTS) failed")?;

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "Rendering Failed!")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() failed")?;

        // Fetch the results via transform feedback
        let mapped = gl!(gl.map_buffer_range(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, data_size, glw::GL_MAP_READ_BIT));
        glu::expect_no_error(gl, "glMapBufferRange() failed")?;
        if mapped.is_null() {
            return Err(TestError::Fail("glMapBufferRange() failed".to_string()));
        }
        // SAFETY: four 32-bit words were mapped for reading; they are copied out before the unmap below.
        let result: [u32; N_COMPONENTS] = unsafe { std::slice::from_raw_parts(mapped.cast::<u32>(), N_COMPONENTS) }
            .try_into()
            .expect("four components");

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() failed")?;

        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glDisable(GL_RASTERIZER_DISCARD) failed")?;

        Ok(result)
    }

    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        let gl = context.gl();

        // initTest
        require_gpu_shader5(base)?;

        let program_id = gl!(gl.create_program());
        objects.programs.push(program_id);

        // Setup transform feedback varyings
        let feedback_varying = CString::new("weightedSum").expect("no nul byte");
        let feedback_varying_pointer = feedback_varying.as_ptr();
        gl!(gl.transform_feedback_varyings(program_id, 1, &feedback_varying_pointer, glw::GL_INTERLEAVED_ATTRIBS));
        glu::expect_no_error(gl, "Could not set transform feedback varyings!")?;

        let vertex_shader_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        let fragment_shader_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        objects.shaders.extend([vertex_shader_id, fragment_shader_id]);

        let (built, _) = base.build_program(
            context,
            program_id,
            &[
                ShaderBody::Source(fragment_shader_id, &[FRAGMENT_SHADER_CODE]),
                ShaderBody::Source(vertex_shader_id, &[VERTEX_SHADER_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Program could not have been created sucessfully from a valid vertex/geometry/fragment shader!"
                    .to_string(),
            ));
        }

        let mut vao_id: GLuint = 0;
        gl!(gl.gen_vertex_arrays(1, &mut vao_id));
        objects.vertex_arrays.push(vao_id);
        gl!(gl.bind_vertex_array(vao_id));
        glu::expect_no_error(gl, "Could not create a vertex array object!")?;

        let data_size = (std::mem::size_of::<f32>() * N_COMPONENTS) as isize;

        // Create transform feedback buffer object
        let mut tf_buffer_id: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut tf_buffer_id));
        objects.buffers.push(tf_buffer_id);
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, tf_buffer_id));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, data_size, std::ptr::null(), glw::GL_STATIC_COPY));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        glu::expect_no_error(gl, "Could not create buffer object!")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, tf_buffer_id));
        glu::expect_no_error(gl, "Could not bind buffer object to transform feedback binding point!")?;

        // Create positions buffer object
        let mut vertex_positions_buffer_id: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut vertex_positions_buffer_id));
        objects.buffers.push(vertex_positions_buffer_id);
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_positions_buffer_id));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, data_size, std::ptr::null(), glw::GL_STATIC_DRAW));
        glu::expect_no_error(gl, "Could not create buffer object!")?;

        // Create weights buffer object
        let mut vertex_weights_buffer_id: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut vertex_weights_buffer_id));
        objects.buffers.push(vertex_weights_buffer_id);
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_weights_buffer_id));
        gl!(gl.buffer_data(glw::GL_ARRAY_BUFFER, data_size, std::ptr::null(), glw::GL_STATIC_DRAW));
        glu::expect_no_error(gl, "Could not create buffer object!")?;

        gl!(gl.use_program(program_id));
        glu::expect_no_error(gl, "Could not use a program object!")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_positions_buffer_id));
        gl!(gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
        glu::expect_no_error(
            gl,
            "Could not configure vertex attribute array for positions attribute!",
        )?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, vertex_weights_buffer_id));
        gl!(gl.vertex_attrib_pointer(1, 4, glw::GL_FLOAT, glw::FALSE, 0, std::ptr::null()));
        glu::expect_no_error(gl, "Could not configure vertex attribute array for weights attribute!")?;

        gl!(gl.enable_vertex_attrib_array(0));
        glu::expect_no_error(gl, "Could not enable vertex attribute array for index 0!")?;

        gl!(gl.enable_vertex_attrib_array(1));
        glu::expect_no_error(gl, "Could not enable vertex attribute array for index 1!")?;

        // iterate: set the seed for the random generator
        let mut random = RandomFormula::default();
        random.random_seed(1);

        let mut test_failed = false;

        for _test_iter in 0..N_ITERATIONS {
            // Create the data for positions and weights attributes
            let mut vertex_data_positions = [0.0f32; N_COMPONENTS];
            let mut vertex_data_weights = [0.0f32; N_COMPONENTS];
            let mut weights_sum = 1.0f32;

            for component_nr in 0..N_COMPONENTS {
                vertex_data_positions[component_nr] =
                    (random.random_formula(2 * POSITION_RANGE as GLuint) as i32 - POSITION_RANGE) as f32;

                if component_nr != N_COMPONENTS - 1 {
                    let random_value = random.random_formula(POSITION_RANGE as GLuint) as f32 / POSITION_RANGE as f32;
                    vertex_data_weights[component_nr] = random_value;
                    weights_sum -= random_value;
                } else {
                    vertex_data_weights[component_nr] = weights_sum;
                }
            }

            // Compute forward weighted sum
            let weighted_sum_forward = self.draw_and_get_feedback_result(
                context,
                vertex_positions_buffer_id,
                vertex_weights_buffer_id,
                &vertex_data_positions,
                &vertex_data_weights,
            )?;

            // Reverse the data for positions and weights attributes
            for component_nr in 0..N_COMPONENTS / 2 {
                vertex_data_positions.swap(component_nr, N_COMPONENTS - 1 - component_nr);
                vertex_data_weights.swap(component_nr, N_COMPONENTS - 1 - component_nr);
            }

            // Compute backward weighted sum
            let weighted_sum_backward = self.draw_and_get_feedback_result(
                context,
                vertex_positions_buffer_id,
                vertex_weights_buffer_id,
                &vertex_data_positions,
                &vertex_data_weights,
            )?;

            // Check if results are bitwise accurate
            if weighted_sum_backward[0] != weighted_sum_backward[1]
                || weighted_sum_backward[0] != weighted_sum_backward[2]
                || weighted_sum_backward[0] != weighted_sum_forward[0]
                || weighted_sum_backward[0] != weighted_sum_forward[1]
                || weighted_sum_backward[0] != weighted_sum_forward[2]
            {
                test_failed = true;
                break;
            }
        }

        Ok(if test_failed {
            TestStatus::fail("Fail")
        } else {
            TestStatus::pass("Pass")
        })
    }
}

impl TestCase for PreciseQualifier {
    fn name(&self) -> &str {
        "precise_qualifier"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        run_case(context, self.ext_params, |context, base, objects| {
            self.run(context, base, objects)
        })
    }
}
