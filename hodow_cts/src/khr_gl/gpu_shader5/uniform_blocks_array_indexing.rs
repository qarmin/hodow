// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5UniformBlocksArrayIndexing.cpp / .hpp
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
use crate::khr_gl::esext::{EPSILON_FLOAT, ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GPUShader5UniformBlocksArrayIndexing`
pub(super) struct UniformBlocksArrayIndexing {
    pub ext_params: ExtParameters,
}

const N_ARRAY_SIZE: GLuint = 4;
const N_POSITION_COMPONENTS: usize = 4;

/// Data to fill in the buffer object associated with positionBlocks uniform array
const POSITION_DATA: [f32; 16] = [
    -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
];

const FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nout vec4 color;\n\nvoid main()\n{\n   color = vec4(1, 1, 1, 1);\n}\n";
const VERTEX_SHADER_CODE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nuniform PositionBlock\n{\n   vec4 position;\n} positionBlocks[4];\n\nuniform uint index;\n\nvoid main()\n{\n   gl_Position = positionBlocks[index].position;\n}\n";

impl UniformBlocksArrayIndexing {
    /// `drawAndCheckResult`
    fn draw_and_check_result(
        &self,
        context: &Context,
        index_location: i32,
        index_value: GLuint,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut result = true;

        gl!(gl.uniform_1ui(index_location, index_value));
        glu::expect_no_error(gl, "glUniform1ui() call failed")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glEnable(GL_RASTERIZER_DISCARD) call failed")?;

        gl!(gl.begin_transform_feedback(glw::GL_POINTS));
        glu::expect_no_error(gl, "glBeginTransformFeedback(GL_POINTS) call failed")?;

        gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
        glu::expect_no_error(gl, "Rendering failed!")?;

        gl!(gl.end_transform_feedback());
        glu::expect_no_error(gl, "glEndTransformFeedback() call failed")?;

        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        glu::expect_no_error(gl, "glDisable(GL_RASTERIZER_DISCARD) call failed")?;

        // Fetch the results via transform feedback
        let mapped = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            (std::mem::size_of::<f32>() * N_POSITION_COMPONENTS) as isize,
            glw::GL_MAP_READ_BIT
        ));
        glu::expect_no_error(gl, "Could not map buffer to process space")?;
        if mapped.is_null() {
            return Err(TestError::Fail("Could not map buffer to process space".to_string()));
        }
        // SAFETY: four floats were mapped for reading; the mapping lives until the unmap below.
        let feedback_result = unsafe { std::slice::from_raw_parts(mapped.cast::<f32>(), N_POSITION_COMPONENTS) };

        let expected = &POSITION_DATA
            [index_value as usize * N_POSITION_COMPONENTS..(index_value as usize + 1) * N_POSITION_COMPONENTS];

        if (0..N_POSITION_COMPONENTS)
            .any(|component| (feedback_result[component] - expected[component]).abs() > EPSILON_FLOAT)
        {
            log::info!(
                "Expected Data ({}, {}, {}, {}) Result Data ({}, {}, {}, {})",
                expected[0],
                expected[1],
                expected[2],
                expected[3],
                feedback_result[0],
                feedback_result[1],
                feedback_result[2],
                feedback_result[3]
            );

            result = false;
        }

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "glUnmapBuffer() call failed")?;

        Ok(result)
    }

    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        let gl = context.gl();

        // initTest
        require_gpu_shader5(base)?;

        let feedback_varyings = [CString::new("gl_Position").expect("no nul byte")];
        let feedback_varying_pointers = [feedback_varyings[0].as_ptr()];
        let n_varyings = feedback_varying_pointers.len();

        let mut vao_id: GLuint = 0;
        gl!(gl.gen_vertex_arrays(1, &mut vao_id));
        objects.vertex_arrays.push(vao_id);
        gl!(gl.bind_vertex_array(vao_id));
        glu::expect_no_error(gl, "Could not create vertex array object")?;

        let program_id = gl!(gl.create_program());
        objects.programs.push(program_id);
        glu::expect_no_error(gl, "Creating program object failed!")?;

        gl!(gl.transform_feedback_varyings(
            program_id,
            n_varyings as i32,
            feedback_varying_pointers.as_ptr(),
            glw::GL_INTERLEAVED_ATTRIBS
        ));
        glu::expect_no_error(gl, "Could not set transform feedback varyings!")?;

        let vertex_shader_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        let fragment_shader_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        objects.shaders.extend([vertex_shader_id, fragment_shader_id]);
        glu::expect_no_error(gl, "Creating shader objects failed!")?;

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
                "Program could not have been created sucessfully from a valid vertex/fragment shader!".to_string(),
            ));
        }

        let mut tf_buffer_id: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut tf_buffer_id));
        objects.buffers.push(tf_buffer_id);
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, tf_buffer_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (N_POSITION_COMPONENTS * std::mem::size_of::<f32>() * n_varyings) as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_COPY
        ));
        glu::expect_no_error(
            gl,
            "Could not create and initialize a buffer object to be used for XFB!",
        )?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, tf_buffer_id));
        glu::expect_no_error(gl, "Could not bind buffer object to transform feedback binding point!")?;

        // iterate
        gl!(gl.use_program(program_id));
        glu::expect_no_error(gl, "Could not use program object!")?;

        // Set up uniform buffer bindings
        let mut uniform_buffer_ids = [0 as GLuint; N_ARRAY_SIZE as usize];
        gl!(gl.gen_buffers(N_ARRAY_SIZE as i32, uniform_buffer_ids.as_mut_ptr()));
        objects.buffers.extend(uniform_buffer_ids);
        glu::expect_no_error(gl, "glGenBuffers() failed")?;

        for index_value in 0..N_ARRAY_SIZE {
            let position_block = CString::new(format!("PositionBlock[{index_value}]")).expect("no nul byte");
            let block_index = gl!(gl.get_uniform_block_index(program_id, position_block.as_ptr()));
            glu::expect_no_error(gl, "Could not get uniform block index")?;

            gl!(gl.uniform_block_binding(program_id, block_index, index_value));
            glu::expect_no_error(gl, "Could not assign uniform block binding")?;

            gl!(gl.bind_buffer(glw::GL_UNIFORM_BUFFER, uniform_buffer_ids[index_value as usize]));
            glu::expect_no_error(gl, "Could not bind buffer object")?;

            gl!(gl.buffer_data(
                glw::GL_UNIFORM_BUFFER,
                (N_POSITION_COMPONENTS * std::mem::size_of::<f32>()) as isize,
                POSITION_DATA[N_POSITION_COMPONENTS * index_value as usize..]
                    .as_ptr()
                    .cast(),
                glw::GL_STATIC_READ
            ));
            glu::expect_no_error(gl, "Could not set buffer object data")?;

            gl!(gl.bind_buffer_base(
                glw::GL_UNIFORM_BUFFER,
                index_value,
                uniform_buffer_ids[index_value as usize]
            ));
            glu::expect_no_error(gl, "Could not bind buffer object to uniform block binding point")?;
        }

        // Retrieve 'index' uniform location.
        let index_name = CString::new("index").expect("no nul byte");
        let index_uniform_location = gl!(gl.get_uniform_location(program_id, index_name.as_ptr()));
        glu::expect_no_error(gl, "glGetUniformLocation() call failed.")?;

        if index_uniform_location == -1 {
            return Err(TestError::Fail("Could not get index uniform location!".to_string()));
        }

        // Run the test
        let mut test_failed = false;

        for index_value in 0..N_ARRAY_SIZE {
            if !self.draw_and_check_result(context, index_uniform_location, index_value)? {
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

impl TestCase for UniformBlocksArrayIndexing {
    fn name(&self) -> &str {
        "uniform_blocks_array_indexing"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        run_case(context, self.ext_params, |context, base, objects| {
            self.run(context, base, objects)
        })
    }
}
