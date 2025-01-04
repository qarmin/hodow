// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferParamValueIntToFloatConversion.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLfloat, GLint, GLsizeiptr, GLubyte, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const EPSILON: GLfloat = 1.0 / 256.0;

/// `TextureBufferParamValueIntToFloatConversion`
pub(super) struct ParamValueIntToFloatConversion {
    pub(super) ext_params: ExtParameters,
}

/// The members `initTest` fills and `deinit` releases; the work group and buffer sizes are static members upstream.
#[derive(Default)]
struct Objects {
    cs_id: GLuint,
    po_id: GLuint,
    ssbo_id: GLuint,
    tbo_id: GLuint,
    tbo_tex_id: GLuint,
    texture_buffer_size: GLuint,
    work_group_x_size: GLuint,
    work_group_y_size: GLuint,
}

impl ParamValueIntToFloatConversion {
    /// `getComputeShaderCode`
    fn get_compute_shader_code(work_group_x_size: GLuint, work_group_y_size: GLuint) -> String {
        format!(
            concat!(
                "${{VERSION}}\n",
                "\n",
                "${{TEXTURE_BUFFER_REQUIRE}}\n",
                "\n",
                "precision highp float;\n",
                "\n",
                "uniform highp samplerBuffer sampler_buffer;\n",
                "\n",
                "layout(std430) buffer ComputeSSBO\n",
                "{{\n",
                "    float value[];\n",
                "}} computeSSBO;\n",
                "\n",
                "layout (local_size_x = {}, local_size_y = {}) in;\n",
                "\n",
                "void main(void)\n",
                "{{\n",
                "    int index = int(gl_LocalInvocationID.x * gl_WorkGroupSize.y + gl_LocalInvocationID.y);\n",
                "\n",
                "    computeSSBO.value[index] = texelFetch( sampler_buffer, index ).x;\n",
                "}}\n",
            ),
            work_group_x_size, work_group_y_size
        )
    }

    /// `initTest`
    fn init_test(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<(), TestError> {
        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        let mut max_workgroup_size: GLint = 0;
        gl_call!(
            gl,
            "Error getting GL_MAX_COMPUTE_WORK_GROUP_SIZE parameter value!",
            gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 0, &mut max_workgroup_size)
        );

        objects.work_group_x_size = ((max_workgroup_size as f32).sqrt().floor() as GLuint).min(16);
        objects.work_group_y_size = objects.work_group_x_size;
        objects.texture_buffer_size = objects.work_group_x_size * objects.work_group_y_size;

        let data_buffer: Vec<GLubyte> = (0..objects.texture_buffer_size).map(|i| i as GLubyte).collect();

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut objects.tbo_id)
        );
        gl_call!(
            gl,
            "Error binding buffer object!",
            gl.bind_buffer(tokens.texture_buffer, objects.tbo_id)
        );
        gl_call!(
            gl,
            "Error allocating buffer object's data store!",
            gl.buffer_data(
                tokens.texture_buffer,
                data_buffer.len() as GLsizeiptr,
                data_buffer.as_ptr().cast(),
                glw::GL_STATIC_READ
            )
        );

        gl_call!(
            gl,
            "Error generating texture object!",
            gl.gen_textures(1, &mut objects.tbo_tex_id)
        );
        gl_call!(
            gl,
            "Error setting active texture unit!",
            gl.active_texture(glw::GL_TEXTURE0)
        );
        gl_call!(
            gl,
            "Error binding texture object to GL_TEXTURE_BUFFER_EXT target!",
            gl.bind_texture(tokens.texture_buffer, objects.tbo_tex_id)
        );
        gl_call!(
            gl,
            "Error setting buffer object as texture buffer's data store!",
            gl.tex_buffer(tokens.texture_buffer, glw::GL_R8, objects.tbo_id)
        );

        // SAFETY: object creation on the current context.
        unsafe { objects.po_id = gl.create_program() };
        glu::expect_no_error(gl, "Error creating program object!")?;

        // SAFETY: as above.
        unsafe { objects.cs_id = gl.create_shader(glw::GL_COMPUTE_SHADER) };
        glu::expect_no_error(gl, "Error creating shader object!")?;

        let source = Self::get_compute_shader_code(objects.work_group_x_size, objects.work_group_y_size);
        let parts = [source.as_str()];
        if !base
            .build_program(context, objects.po_id, &[ShaderBody::Source(objects.cs_id, &parts)])?
            .0
        {
            return Err(TestError::Fail(
                "Could not create a program object from valid compute shader object!".to_string(),
            ));
        }

        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.gen_buffers(1, &mut objects.ssbo_id)
        );
        gl_call!(
            gl,
            "Error binding  buffer object!",
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, objects.ssbo_id)
        );
        gl_call!(
            gl,
            "Error generating buffer object!",
            gl.buffer_data(
                glw::GL_ARRAY_BUFFER,
                (objects.texture_buffer_size as usize * size_of::<GLfloat>()) as GLsizeiptr,
                std::ptr::null(),
                glw::GL_DYNAMIC_COPY
            )
        );
        Ok(())
    }

    /// `deinit`
    fn deinit(context: &Context, base: &TestCaseBase, objects: &mut Objects) {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        // SAFETY: state resets and deletes of names this case created.
        unsafe {
            gl.use_program(0);
            gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
            gl.bind_buffer(tokens.texture_buffer, 0);
            gl.bind_texture(tokens.texture_buffer, 0);
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, 0);

            if objects.cs_id != 0 {
                gl.delete_shader(objects.cs_id);
                objects.cs_id = 0;
            }
            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
                objects.po_id = 0;
            }
            if objects.ssbo_id != 0 {
                gl.delete_buffers(1, &objects.ssbo_id);
                objects.ssbo_id = 0;
            }
            if objects.tbo_id != 0 {
                gl.delete_buffers(1, &objects.tbo_id);
                objects.tbo_id = 0;
            }
            if objects.tbo_tex_id != 0 {
                gl.delete_textures(1, &objects.tbo_tex_id);
                objects.tbo_tex_id = 0;
            }
        }
    }

    fn run(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        Self::init_test(context, base, objects)?;

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;
        let mut test_result = true;

        gl_call!(gl, "Error using program!", gl.use_program(objects.po_id));
        gl_call!(
            gl,
            "Could not bind buffer object to shader storage binding point!",
            gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, objects.ssbo_id)
        );
        gl_call!(
            gl,
            "Error setting active texture unit!",
            gl.active_texture(glw::GL_TEXTURE0)
        );
        gl_call!(
            gl,
            "Error binding texture object!",
            gl.bind_texture(tokens.texture_buffer, objects.tbo_tex_id)
        );

        // SAFETY: a NUL-terminated name on the program in use.
        let location = unsafe { gl.get_uniform_location(objects.po_id, c"sampler_buffer".as_ptr()) };
        glu::expect_no_error(gl, "Error getting uniform location!")?;

        gl_call!(
            gl,
            "Error setting value for uniform location!",
            gl.uniform_1i(location, 0)
        );
        gl_call!(gl, "Error running compute shader!", gl.dispatch_compute(1, 1, 1));
        gl_call!(
            gl,
            "Error setting memory barrier!",
            gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
        );

        let n = objects.texture_buffer_size as usize;
        // SAFETY: a read mapping of the floats the shader wrote.
        let mapped = unsafe {
            gl.map_buffer_range(
                glw::GL_SHADER_STORAGE_BUFFER,
                0,
                (n * size_of::<GLfloat>()) as GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        };
        glu::expect_no_error(gl, "Error mapping buffer object's data store to client address space!")?;
        if mapped.is_null() {
            return Err(TestError::Fail(
                "Error mapping buffer object's data store to client address space!".to_string(),
            ));
        }
        // SAFETY: the mapping holds n GLfloats until it is unmapped below; they are copied out first.
        let result: Vec<GLfloat> = unsafe { std::slice::from_raw_parts(mapped.cast::<GLfloat>(), n) }.to_vec();

        for (i, &value) in result.iter().enumerate() {
            // The texture format is R8, so i may wrap - hence the GLubyte cast.
            if (value - (i as GLubyte) as GLfloat / 255.0).abs() > EPSILON {
                log::info!(
                    "Result is different than expected \nExpected value: {}\nResult   value: {value}\n",
                    i as GLfloat / 255.0
                );
                test_result = false;
                break;
            }
        }

        // SAFETY: the buffer mapped above.
        unsafe { gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER) };

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for ParamValueIntToFloatConversion {
    fn name(&self) -> &str {
        "texture_buffer_conv_int_to_float"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = Objects::default();

        let outcome = Self::run(context, &base, &mut objects);
        Self::deinit(context, &base, &mut objects);
        outcome
    }
}
