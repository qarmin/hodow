// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5ImagesArrayIndexing.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling; the GL object bookkeeping is `common::Objects`.

use super::common::{Objects, require_gpu_shader5, run_case};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GPUShader5ImagesArrayIndexing`
pub(super) struct ImagesArrayIndexing {
    pub ext_params: ExtParameters,
}

const ARRAY_SIZE: GLuint = 4;
const TEXTURE_N_COMPONENTS: GLint = 1;

/// `getComputeShaderCode`
fn compute_shader_code(local_size_x: &str, local_size_y: &str) -> String {
    let template = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nlayout (local_size_x = <-MAX-LOCAL-SIZE-X->,\n        local_size_y = <-MAX-LOCAL-SIZE-Y->,\n        local_size_z = 1) in;\n\nlayout (r32ui, binding = 0) uniform highp uimage2D image[4];\n\nvoid main(void)\n{\n   uvec4 texel0 = imageLoad(image[0], ivec2(gl_LocalInvocationID.x, gl_LocalInvocationID.y) );\n   uvec4 texel1 = imageLoad(image[1], ivec2(gl_LocalInvocationID.x, gl_LocalInvocationID.y) );\n   uvec4 texel2 = imageLoad(image[2], ivec2(gl_LocalInvocationID.x, gl_LocalInvocationID.y) );\n   uvec4 texel3 = imageLoad(image[3], ivec2(gl_LocalInvocationID.x, gl_LocalInvocationID.y) );\n   uvec4 addon  = uvec4(gl_LocalInvocationID.x+gl_LocalInvocationID.y);\n\n   imageStore(image[0], ivec2( gl_LocalInvocationID.x, gl_LocalInvocationID.y), texel0  + addon);\n   imageStore(image[1], ivec2( gl_LocalInvocationID.x, gl_LocalInvocationID.y), texel1  + addon);\n   imageStore(image[2], ivec2( gl_LocalInvocationID.x, gl_LocalInvocationID.y), texel2  + addon);\n   imageStore(image[3], ivec2( gl_LocalInvocationID.x, gl_LocalInvocationID.y), texel3  + addon);\n}\n";

    template
        .replace("<-MAX-LOCAL-SIZE-X->", local_size_x)
        .replace("<-MAX-LOCAL-SIZE-Y->", local_size_y)
}

impl ImagesArrayIndexing {
    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        let gl = context.gl();

        // initTest
        require_gpu_shader5(base)?;

        // Calculate platform-specific value that should be used for local_size_x, local_size_y in compute shader
        let mut texture_width: GLint = 0;
        let mut texture_height: GLint = 0;
        let mut max_compute_work_group_invocations_value: GLint = 0;

        gl!(gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 0, &mut texture_width));
        glu::expect_no_error(gl, "Could not query GL_MAX_COMPUTE_WORK_GROUP_SIZE!")?;

        gl!(gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 1, &mut texture_height));
        glu::expect_no_error(gl, "Could not query GL_MAX_COMPUTE_WORK_GROUP_SIZE!")?;

        gl!(gl.get_integerv(
            glw::GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS,
            &mut max_compute_work_group_invocations_value
        ));
        glu::expect_no_error(gl, "Could not query GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS!")?;

        if texture_width * texture_height > max_compute_work_group_invocations_value {
            texture_width = max_compute_work_group_invocations_value / texture_height;
        }

        let compute_shader_code = compute_shader_code(&texture_width.to_string(), &texture_height.to_string());

        let program_id = gl!(gl.create_program());
        objects.programs.push(program_id);
        glu::expect_no_error(gl, "glCreateProgram() call failed")?;

        let compute_shader_id = gl!(gl.create_shader(glw::GL_COMPUTE_SHADER));
        objects.shaders.push(compute_shader_id);
        glu::expect_no_error(gl, "glCreateShader(GL_COMPUTE_SHADER) failed")?;

        let (built, _) = base.build_program(
            context,
            program_id,
            &[ShaderBody::Source(compute_shader_id, &[compute_shader_code.as_str()])],
        )?;
        if !built {
            return Err(TestError::Fail("Could not create program object!".to_string()));
        }

        // Generate texture objects
        let mut to_ids = [0 as GLuint; ARRAY_SIZE as usize];
        gl!(gl.gen_textures(ARRAY_SIZE as i32, to_ids.as_mut_ptr()));
        objects.textures.extend(to_ids);
        glu::expect_no_error(gl, "Could not generate texture objects!")?;

        // Allocate a buffer filled with data used as a data source for the texture objects
        let data_size = (texture_width * texture_height * TEXTURE_N_COMPONENTS) as usize;
        let mut data_buffer = vec![0 as GLuint; data_size * ARRAY_SIZE as usize];

        for array_index in 0..ARRAY_SIZE as usize {
            for index in 0..data_size {
                data_buffer[index + array_index * data_size] = 1 + array_index as GLuint;
            }
        }

        // Initialize storage for the texture objects
        for index in 0..ARRAY_SIZE {
            gl!(gl.active_texture(glw::GL_TEXTURE0 + index));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, to_ids[index as usize]));
            glu::expect_no_error(gl, "Could not bind a texture object to texture unit!")?;

            gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R32UI, texture_width, texture_height));

            gl!(gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                texture_width,
                texture_height,
                glw::GL_RED_INTEGER,
                glw::GL_UNSIGNED_INT,
                data_buffer[index as usize * data_size..].as_ptr().cast()
            ));

            gl!(gl.tex_parameterf(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as f32));
            gl!(gl.tex_parameterf(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as f32));

            glu::expect_no_error(gl, "Could not allocate storage for a texture object!")?;
        }

        // iterate
        gl!(gl.use_program(program_id));
        glu::expect_no_error(gl, "glUseProgram() call failed")?;

        for index in 0..ARRAY_SIZE {
            gl!(gl.bind_image_texture(
                index,
                to_ids[index as usize],
                0,
                glw::FALSE,
                0,
                glw::GL_READ_WRITE,
                glw::GL_R32UI
            ));
            glu::expect_no_error(gl, "Could not bind a texture object to image unit!")?;
        }

        gl!(gl.dispatch_compute(1, 1, 1));
        glu::expect_no_error(gl, "Failed to dispatch compute operation")?;

        // Create and configure a framebuffer object
        let mut fbo_id: GLuint = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo_id));
        objects.framebuffers.push(fbo_id);
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo_id));
        glu::expect_no_error(gl, "Could not create framebuffer object")?;

        gl!(gl.viewport(0, 0, texture_width, texture_height));
        glu::expect_no_error(gl, "glViewport() call failed")?;

        // Allocate space for result data
        let result_size = (texture_width * texture_height * TEXTURE_N_COMPONENTS * 4) as usize;
        let mut result_buffer = vec![0 as GLuint; result_size];

        gl!(gl.memory_barrier(glw::GL_PIXEL_BUFFER_BARRIER_BIT));
        glu::expect_no_error(gl, "Could not set memory barrier!")?;

        for i in 0..ARRAY_SIZE {
            // Attach texture to framebuffer's color attachment 0
            gl!(gl.framebuffer_texture_2d(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                to_ids[i as usize],
                0
            ));
            glu::expect_no_error(gl, "Error configuring color attachment for framebuffer object!")?;

            // Read the rendered data
            gl!(gl.read_pixels(
                0,
                0,
                texture_width,
                texture_height,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                result_buffer.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "glReadPixels() call failed!")?;

            // Loop over all pixels and compare the rendered data with reference value
            for y in 0..texture_height {
                let data_row = (y * texture_width * TEXTURE_N_COMPONENTS * 4) as usize;

                for x in 0..texture_width {
                    let data = data_row + (x * TEXTURE_N_COMPONENTS * 4) as usize;

                    let result_expected = (x + y + 1) as GLuint + i;

                    if result_expected != result_buffer[data] {
                        log::info!(
                            "Invalid image data acquired for image at index {i}, position: ({x},{y}). Rendered data [{}] Expected data [{result_expected}]",
                            result_buffer[data]
                        );

                        return Ok(TestStatus::fail("Fail"));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for ImagesArrayIndexing {
    fn name(&self) -> &str {
        "images_array_indexing"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        run_case(context, self.ext_params, |context, base, objects| {
            self.run(context, base, objects)
        })
    }
}
