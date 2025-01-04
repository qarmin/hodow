// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/texture_buffer/esextcTextureBufferAtomicFunctions.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use super::TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLboolean, GLint, GLsizeiptr, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const SHADER_IMAGE_ATOMIC_EXTENSION_NOT_SUPPORTED: &str = "Shader image atomic functionality not supported, skipping";

/// `TextureBufferAtomicFunctions`
pub(super) struct AtomicFunctions {
    pub(super) ext_params: ExtParameters,
}

/// The members `initTest` fills and `deinit` releases.
#[derive(Default)]
struct Objects {
    cs_id: GLuint,
    po_id: GLuint,
    tbo_id: GLuint,
    tbo_tex_id: GLuint,
    n_texels_in_texture_buffer: GLuint,
}

impl AtomicFunctions {
    /// `getComputeShaderCode`
    fn get_compute_shader_code(work_group_size: GLint) -> String {
        format!(
            concat!(
                "${{VERSION}}\n",
                "\n",
                "${{TEXTURE_BUFFER_REQUIRE}}\n",
                "${{SHADER_IMAGE_ATOMIC_REQUIRE}}\n",
                "\n",
                "precision highp float;\n",
                "\n",
                "layout (local_size_x = {} ) in;\n",
                "\n",
                "layout(r32ui, binding = 0) coherent uniform highp uimageBuffer uimage_buffer;\n",
                "\n",
                "void main(void)\n",
                "{{\n",
                "   uint value = imageLoad( uimage_buffer, int(gl_LocalInvocationID.x) + 1 ).x;\n",
                "   imageAtomicAdd( uimage_buffer, 0 , value );\n",
                "\n",
                "   memoryBarrier();\n",
                "   barrier();\n",
                "\n",
                "   value = imageLoad( uimage_buffer, 0 ).x;\n",
                "   imageAtomicCompSwap( uimage_buffer, int(gl_LocalInvocationID.x) + 1, gl_LocalInvocationID.x + 1u, value );\n",
                "}}\n",
            ),
            work_group_size
        )
    }

    /// `initTest`
    fn init_test(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> Result<(), TestError> {
        if !base.is_texture_buffer_supported {
            return Err(TestError::NotSupported(
                TEXTURE_BUFFER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }
        if !base.is_shader_image_atomic_supported {
            return Err(TestError::NotSupported(
                SHADER_IMAGE_ATOMIC_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        let mut work_group_size: GLint = 0;
        gl_call!(
            gl,
            "Error getting GL_MAX_COMPUTE_WORK_GROUP_SIZE parameter value!",
            gl.get_integeri_v(glw::GL_MAX_COMPUTE_WORK_GROUP_SIZE, 0, &mut work_group_size)
        );

        objects.n_texels_in_texture_buffer = work_group_size as GLuint + 1;
        let data_buffer: Vec<GLuint> = (0..objects.n_texels_in_texture_buffer).collect();

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
                (data_buffer.len() * size_of::<GLuint>()) as GLsizeiptr,
                data_buffer.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
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
            gl.tex_buffer(tokens.texture_buffer, glw::GL_R32UI, objects.tbo_id)
        );

        // SAFETY: object creation on the current context.
        unsafe { objects.po_id = gl.create_program() };
        glu::expect_no_error(gl, "Error creating program object!")?;

        // SAFETY: as above.
        unsafe { objects.cs_id = gl.create_shader(glw::GL_COMPUTE_SHADER) };
        glu::expect_no_error(gl, "Error creating shader object!")?;

        let source = Self::get_compute_shader_code(work_group_size);
        let parts = [source.as_str()];
        if !base
            .build_program(context, objects.po_id, &[ShaderBody::Source(objects.cs_id, &parts)])?
            .0
        {
            return Err(TestError::Fail(
                "Could not create a program object from valid compute shader object!".to_string(),
            ));
        }
        Ok(())
    }

    /// `deinit`
    fn deinit(context: &Context, base: &TestCaseBase, objects: &mut Objects) {
        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;

        // SAFETY: state resets and deletes of names this case created.
        unsafe {
            gl.use_program(0);
            gl.bind_buffer(tokens.texture_buffer, 0);
            gl.bind_texture(tokens.texture_buffer, 0);

            if objects.po_id != 0 {
                gl.delete_program(objects.po_id);
                objects.po_id = 0;
            }
            if objects.cs_id != 0 {
                gl.delete_shader(objects.cs_id);
                objects.cs_id = 0;
            }
            if objects.tbo_tex_id != 0 {
                gl.delete_textures(1, &objects.tbo_tex_id);
                objects.tbo_tex_id = 0;
            }
            if objects.tbo_id != 0 {
                gl.delete_buffers(1, &objects.tbo_id);
                objects.tbo_id = 0;
            }
        }
    }

    fn run(context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        Self::init_test(context, base, objects)?;

        let gl = context.gl();
        let tokens = &base.gl_ext_tokens;
        let mut test_result = true;

        gl_call!(
            gl,
            "Error setting active program object!",
            gl.use_program(objects.po_id)
        );
        gl_call!(
            gl,
            "Error binding texture object to image unit 0!",
            gl.bind_image_texture(
                0,
                objects.tbo_tex_id,
                0,
                glw::GL_FALSE as GLboolean,
                0,
                glw::GL_READ_WRITE,
                glw::GL_R32UI
            )
        );
        gl_call!(gl, "Error running compute shader!", gl.dispatch_compute(1, 1, 1));
        gl_call!(
            gl,
            "Error setting memory barrier!",
            gl.memory_barrier(glw::GL_BUFFER_UPDATE_BARRIER_BIT)
        );

        let n_texels = objects.n_texels_in_texture_buffer as usize;
        // SAFETY: a read mapping of the whole store the case allocated.
        let mapped = unsafe {
            gl.map_buffer_range(
                tokens.texture_buffer,
                0,
                (n_texels * size_of::<GLuint>()) as GLsizeiptr,
                glw::GL_MAP_READ_BIT,
            )
        };
        glu::expect_no_error(gl, "Error mapping buffer object's data store to client address space!")?;
        if mapped.is_null() {
            return Err(TestError::Fail(
                "Error mapping buffer object's data store to client address space!".to_string(),
            ));
        }
        // SAFETY: the mapping holds n_texels GLuints until it is unmapped below; they are copied out first.
        let result: Vec<GLuint> = unsafe { std::slice::from_raw_parts(mapped.cast::<GLuint>(), n_texels) }.to_vec();

        let n = objects.n_texels_in_texture_buffer;
        let expected_value = (n * (n - 1)) / 2;

        for (i, &value) in result.iter().enumerate() {
            if value != expected_value {
                log::info!(
                    "Result is different than expected at index: {i}\nExpected value: {expected_value}\nResult   value: {value}\n"
                );
                test_result = false;
                break;
            }
        }

        // SAFETY: the buffer mapped above.
        unsafe { gl.unmap_buffer(tokens.texture_buffer) };

        Ok(if test_result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for AtomicFunctions {
    fn name(&self) -> &str {
        "texture_buffer_atomic_functions"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        let mut objects = Objects::default();

        let outcome = Self::run(context, &base, &mut objects);
        Self::deinit(context, &base, &mut objects);
        outcome
    }
}
