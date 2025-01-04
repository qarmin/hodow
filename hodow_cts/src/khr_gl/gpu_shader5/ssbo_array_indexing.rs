// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5SSBOArrayIndexing.cpp / .hpp
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

/// `GPUShader5SSBOArrayIndexing`
pub(super) struct SsboArrayIndexing {
    pub ext_params: ExtParameters,
}

const N_ARRAYS: usize = 4;

const COMPUTE_SHADER_CODE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\n#define LOCAL_SIZE_X 3u\n#define LOCAL_SIZE_Y 3u\n\nlayout (local_size_x = LOCAL_SIZE_X, local_size_y = LOCAL_SIZE_Y) in;\n\nlayout(binding = 0) buffer ComputeSSBO\n{\n    uint value;\n} computeSSBO[4];\n\nuniform uint index;\n\nvoid main(void)\n{\n    uint id = gl_LocalInvocationID.x * LOCAL_SIZE_Y + gl_LocalInvocationID.y;\n\n    for (uint i = 0u; i < LOCAL_SIZE_X * LOCAL_SIZE_Y; ++i)\n    {\n        if (id == i)\n        {\n            computeSSBO[index].value += id;\n        }\n\n        memoryBarrier();\n    }\n}\n";

impl SsboArrayIndexing {
    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        let gl = context.gl();

        // initTest
        require_gpu_shader5(base)?;

        let program_id = gl!(gl.create_program());
        objects.programs.push(program_id);
        glu::expect_no_error(gl, "Could not create program object!")?;

        let compute_shader_id = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
        objects.shaders.push(compute_shader_id);
        glu::expect_no_error(gl, "Could not create shader object!")?;

        let (built, _) = base.build_program(
            context,
            program_id,
            &[ShaderBody::Source(compute_shader_id, &[COMPUTE_SHADER_CODE])],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not build program from valid compute shader!".to_string(),
            ));
        }

        let mut ssbo_buffer_ids = [0 as GLuint; N_ARRAYS];
        gl!(gl.gen_buffers(N_ARRAYS as i32, ssbo_buffer_ids.as_mut_ptr()));
        objects.buffers.extend(ssbo_buffer_ids);
        glu::expect_no_error(gl, "glGenBuffers() call failed")?;

        for (index, buffer) in ssbo_buffer_ids.iter().enumerate() {
            gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, *buffer));
            glu::expect_no_error(gl, "Could not bind buffer object!")?;

            let ssbo_data: GLuint = 0;
            gl!(gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                std::mem::size_of::<GLuint>() as isize,
                (&ssbo_data as *const GLuint).cast(),
                glw::GL_DYNAMIC_COPY
            ));
            glu::expect_no_error(gl, "Could not set buffer object data!")?;

            gl!(gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, index as GLuint, *buffer));
            glu::expect_no_error(gl, "Could not bind buffer object to shader storage binding point!")?;
        }

        // iterate: activate the program object and retrieve index uniform location
        gl!(gl.use_program(program_id));
        glu::expect_no_error(gl, "Could not use program!")?;

        let index_name = CString::new("index").expect("no nul byte");
        let index_location = gl!(gl.get_uniform_location(program_id, index_name.as_ptr()));
        glu::expect_no_error(gl, "glGetUniformLocation() call failed!")?;

        if index_location == -1 {
            return Err(TestError::Fail(
                "Index uniform location is inactive which is invalid!".to_string(),
            ));
        }

        // Issue a few compute operations
        for index in [1, 3] {
            gl!(gl.uniform_1ui(index_location, index));
            glu::expect_no_error(gl, "Could not set value of index uniform variable!")?;

            gl!(gl.dispatch_compute(1, 1, 1));
            glu::expect_no_error(gl, "Could not dispatch compute!")?;

            gl!(gl.memory_barrier(glw::GL_SHADER_STORAGE_BARRIER_BIT));
            glu::expect_no_error(gl, "Could not set memory barrier!")?;
        }

        // Validate the results
        let expected_result: [GLuint; N_ARRAYS] = [0, 36, 0, 36];
        let mut test_failed = false;

        for (index, buffer) in ssbo_buffer_ids.iter().enumerate() {
            gl!(gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, *buffer));
            glu::expect_no_error(gl, "Could not bind a buffer object!")?;

            let mapped = gl!(gl.map_buffer_range(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                std::mem::size_of::<GLuint>() as isize,
                glw::GL_MAP_READ_BIT
            ));
            glu::expect_no_error(gl, "Could not map buffer data to client memory")?;
            if mapped.is_null() {
                return Err(TestError::Fail(
                    "Could not map buffer data to client memory".to_string(),
                ));
            }
            // SAFETY: one GLuint was mapped for reading; the mapping lives until the unmap below.
            let value = unsafe { *mapped.cast::<GLuint>() };

            if value != expected_result[index] {
                log::info!("Expected Data ({}) Result Data ({value})", expected_result[index]);
                test_failed = true;
            }

            gl!(gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER));
            glu::expect_no_error(gl, "Could not unmap buffer")?;
        }

        Ok(if test_failed {
            TestStatus::fail("Fail")
        } else {
            TestStatus::pass("Pass")
        })
    }
}

impl TestCase for SsboArrayIndexing {
    fn name(&self) -> &str {
        "ssbo_array_indexing"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        run_case(context, self.ext_params, |context, base, objects| {
            self.run(context, base, objects)
        })
    }
}
