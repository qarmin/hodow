// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/gpu_shader5/esextcGPUShader5SamplerArrayIndexing.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling; the GL object bookkeeping is `common::Objects`.

use std::ffi::CString;

use super::common::{Objects, require_gpu_shader5, run_case};
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `GPUShader5SamplerArrayIndexing`
pub(super) struct SamplerArrayIndexing {
    pub ext_params: ExtParameters,
}

const N_SMALL_TEXTURES: usize = 4;
const BIG_TEXTURE_HEIGHT: GLint = 3;
const BIG_TEXTURE_WIDTH: GLint = 3;
const N_TEXTURE_LEVELS: GLint = 1;
const SMALL_TEXTURE_HEIGHT: GLint = 1;
const SMALL_TEXTURE_WIDTH: GLint = 1;

const VERTEX_SHADER_CODE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nin vec4 position;\nvoid main()\n{\n   gl_Position = position;}\n";
const FRAGMENT_SHADER_CODE: &str = "${VERSION}\n\n${GPU_SHADER5_REQUIRE}\n\nprecision highp float;\n\nuniform sampler2D samplers[4];\n\nlayout(location = 0) out vec4 outColor;\n\nvoid main(void)\n{\n    outColor = vec4(0, 0, 0, 0);\n\n    for (int i = 0;i < 4; ++i)\n    {\n        outColor +=  texture(samplers[i],vec2(0,0));\n    }\n}\n";

impl SamplerArrayIndexing {
    /// `initTest`; returns `(fbo_id, small_texture_ids, vbo_id, po_id)`.
    fn init_test(
        &self,
        context: &Context,
        base: &TestCaseBase,
        objects: &mut Objects,
    ) -> Result<(GLuint, [GLuint; N_SMALL_TEXTURES], GLuint, GLuint), TestError> {
        let gl = context.gl();

        require_gpu_shader5(base)?;

        let fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        let vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        objects.shaders.extend([fs_id, vs_id]);

        let po_id = gl!(gl.create_program());
        objects.programs.push(po_id);

        let (built, _) = base.build_program(
            context,
            po_id,
            &[
                ShaderBody::Source(fs_id, &[FRAGMENT_SHADER_CODE]),
                ShaderBody::Source(vs_id, &[VERTEX_SHADER_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Could not create program object!".to_string()));
        }

        let mut vao_id: GLuint = 0;
        gl!(gl.gen_vertex_arrays(1, &mut vao_id));
        objects.vertex_arrays.push(vao_id);
        gl!(gl.bind_vertex_array(vao_id));
        glu::expect_no_error(gl, "Error configuring vertex array object")?;

        // Configure vertex buffer
        let vertices: [f32; 16] = [
            -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
        ];

        let mut vbo_id: GLuint = 0;
        gl!(gl.gen_buffers(1, &mut vbo_id));
        objects.buffers.push(vbo_id);
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            std::mem::size_of_val(&vertices) as isize,
            vertices.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        glu::expect_no_error(gl, "Error creating vertex buffer object!")?;

        // Create and configure texture object used as color attachment
        let mut big_to_id: GLuint = 0;
        gl!(gl.gen_textures(1, &mut big_to_id));
        objects.textures.push(big_to_id);
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, big_to_id));
        gl!(gl.tex_storage_2d(
            glw::GL_TEXTURE_2D,
            N_TEXTURE_LEVELS,
            glw::GL_RGBA8,
            BIG_TEXTURE_WIDTH,
            BIG_TEXTURE_HEIGHT
        ));
        glu::expect_no_error(gl, "Error configuring texture object!")?;

        // Create and configure the framebuffer object
        let mut fbo_id: GLuint = 0;
        gl!(gl.gen_framebuffers(1, &mut fbo_id));
        objects.framebuffers.push(fbo_id);
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo_id));
        gl!(gl.framebuffer_texture_2d(
            glw::GL_DRAW_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            big_to_id,
            0
        ));
        glu::expect_no_error(gl, "Error configuring framebuffer object!")?;

        // Configure textures used in fragment shader
        let alpha: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
        let blue: [f32; 4] = [0.0, 0.0, 1.0, 0.0];
        let green: [f32; 4] = [0.0, 1.0, 0.0, 0.0];
        let red: [f32; 4] = [1.0, 0.0, 0.0, 0.0];

        let mut small_to_ids = [0 as GLuint; N_SMALL_TEXTURES];
        gl!(gl.gen_textures(N_SMALL_TEXTURES as i32, small_to_ids.as_mut_ptr()));
        objects.textures.extend(small_to_ids);

        for (unit, (texture, color)) in small_to_ids.iter().zip([&red, &green, &blue, &alpha]).enumerate() {
            gl!(gl.active_texture(glw::GL_TEXTURE0 + unit as u32));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, *texture));
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA32F as GLint,
                SMALL_TEXTURE_WIDTH,
                SMALL_TEXTURE_HEIGHT,
                0,
                glw::GL_RGBA,
                glw::GL_FLOAT,
                color.as_ptr().cast()
            ));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint));
            gl!(gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint));
            glu::expect_no_error(gl, "Error configuring texture object")?;
        }

        Ok((fbo_id, small_to_ids, vbo_id, po_id))
    }

    fn run(&self, context: &Context, base: &TestCaseBase, objects: &mut Objects) -> TestOutcome {
        let (fbo_id, small_to_ids, vbo_id, po_id) = self.init_test(context, base, objects)?;
        let gl = context.gl();

        gl!(gl.viewport(0, 0, BIG_TEXTURE_WIDTH, BIG_TEXTURE_HEIGHT));
        glu::expect_no_error(gl, "glViewport() call failed")?;

        gl!(gl.use_program(po_id));
        glu::expect_no_error(gl, "glUseProgram() call failed")?;

        // Configure position vertex array
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, vbo_id));
        glu::expect_no_error(gl, "glBindBuffer() call failed")?;

        let position_name = CString::new("position").expect("no nul byte");
        let position_attribute_location = gl!(gl.get_attrib_location(po_id, position_name.as_ptr()));

        gl!(gl.vertex_attrib_pointer(
            position_attribute_location as GLuint,
            4,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            std::ptr::null()
        ));
        gl!(gl.enable_vertex_attrib_array(position_attribute_location as GLuint));
        glu::expect_no_error(gl, "Error configuring position vertex attribute array!")?;

        let samplers_name = CString::new("samplers").expect("no nul byte");
        let samplers_uniform_location = gl!(gl.get_uniform_location(po_id, samplers_name.as_ptr()));

        for (unit, texture) in small_to_ids.iter().enumerate() {
            gl!(gl.active_texture(glw::GL_TEXTURE0 + unit as u32));
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, *texture));
            gl!(gl.uniform_1i(samplers_uniform_location + unit as GLint, unit as GLint));
            glu::expect_no_error(
                gl,
                &format!("Error assigning texture unit {unit} to samplers[{unit}] uniform location!"),
            )?;
        }

        // Render
        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        glu::expect_no_error(gl, "Error clearing color buffer!")?;

        gl!(gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4));
        glu::expect_no_error(gl, "Rendering error")?;

        // Verify results
        let reference_color: [u8; 4] = [255, 255, 255, 255];
        let mut buffer = [0u8; 4];

        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo_id));
        gl!(gl.read_pixels(
            1,
            1,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            buffer.as_mut_ptr().cast()
        ));
        glu::expect_no_error(gl, "Error reading pixel data!")?;

        // Fail if result color is different from reference color
        if reference_color != buffer {
            log::info!(
                "Rendered color [{}, {}, {}, {}] is different from reference color [{}, {}, {}, {}] !",
                buffer[0],
                buffer[1],
                buffer[2],
                buffer[3],
                reference_color[0],
                reference_color[1],
                reference_color[2],
                reference_color[3]
            );

            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for SamplerArrayIndexing {
    fn name(&self) -> &str {
        "sampler_array_indexing"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        run_case(context, self.ext_params, |context, base, objects| {
            self.run(context, base, objects)
        })
    }
}
