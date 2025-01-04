// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cTextureViewTests.cpp  (TextureViewTestCoherency)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::{check_texture_view_support, shader_source, uniform_location};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const STATIC_TEXTURE_HEIGHT: u32 = 1;
const STATIC_TEXTURE_WIDTH: u32 = 1;
const TEXTURE_HEIGHT: u32 = 64;
const TEXTURE_N_COMPONENTS: u32 = 4;
const TEXTURE_N_LEVELS: u32 = 7;
const TEXTURE_WIDTH: u32 = 64;

const STATIC_COLOR_BYTE: [u8; 4] = [100, 0, 255, 200];

const GRADIENT_VERIFICATION_VS_BODY: &str = "#version 400\n\nout int result;\n\nuniform float     lod;\nuniform bool      sample_exact_uv;\nuniform sampler2D texture;\n\nvoid main()\n{\n    const float epsilon    = 1.0 / 255.0;\n    const vec4  end_rgba   = vec4(0.0, 0.1, 1.0, 1.0);\n    const vec4  start_rgba = vec4(1.0, 0.9, 0.0, 0.0);\n\n    ivec2 texture_size   = textureSize(texture, int(lod) );\n    vec2  uv             = vec2(      float(gl_VertexID % texture_size.x) / float(texture_size.x),\n                                1.0 - float(gl_VertexID / texture_size.x) / float(texture_size.y) );\n    vec4  expected_color;\n    vec4  texture_color  = textureLod(texture, uv, lod);\n\n    if (sample_exact_uv)\n    {\n        expected_color = mix(start_rgba, end_rgba, uv.x);\n    }\n    else\n    {\n        expected_color = mix(start_rgba, end_rgba, uv.x + 0.5/float(texture_size.x) );\n    }\n\n\n    if (abs(texture_color.x - expected_color.x) > epsilon ||\n        abs(texture_color.y - expected_color.y) > epsilon ||\n        abs(texture_color.z - expected_color.z) > epsilon ||\n        abs(texture_color.w - expected_color.w) > epsilon)\n    {\n        result = int( texture_color.y * 255.0);\n    }\n    else\n    {\n        result = 1;\n    }\n}\n";

const GRADIENT_WRITE_IMAGE_VS_BODY: &str = "#version 400\n\n#extension GL_ARB_shader_image_load_store : require\n\nlayout(rgba8) uniform image2D image;\n              uniform ivec2   image_size;\n\nvoid main()\n{\n    const  vec4 end_rgba   =  vec4(0.0, 0.1, 1.0, 1.0);\n    const  vec4 start_rgba =  vec4(1.0, 0.9, 0.0, 0.0);\n          ivec2 xy         = ivec2(gl_VertexID % image_size.x,              gl_VertexID / image_size.x);\n           vec2 uv         =  vec2(float(xy.x) / float(image_size.x), 1.0 - float(xy.y) / float(image_size.y) );\n          vec4  result     = mix  (start_rgba, end_rgba, uv.x);\n\n    imageStore(image, xy, result);\n}\n";

const GRADIENT_WRITE_FS_BODY: &str = "#version 400\n\nin vec2 uv;\n\nlayout(location = 0) out vec4 result;\n\nvoid main()\n{\n    const vec4 end_rgba   = vec4(0.0, 0.1, 1.0, 1.0);\n    const vec4 start_rgba = vec4(1.0, 0.9, 0.0, 0.0);\n\n    result = mix(start_rgba, end_rgba, uv.x);\n}\n";

const GRADIENT_WRITE_VS_BODY: &str = "#version 400\n\nout vec2 uv;\n\nvoid main()\n{\n    switch (gl_VertexID)\n    {\n        case 0: gl_Position = vec4(-1.0, -1.0, 0.0, 1.0); uv = vec2(0.0, 1.0); break;\n        case 1: gl_Position = vec4(-1.0,  1.0, 0.0, 1.0); uv = vec2(0.0, 0.0); break;\n        case 2: gl_Position = vec4( 1.0, -1.0, 0.0, 1.0); uv = vec2(1.0, 1.0); break;\n        case 3: gl_Position = vec4( 1.0,  1.0, 0.0, 1.0); uv = vec2(1.0, 0.0); break;\n    }\n}\n";

const VERIFICATION_VS_BODY: &str = "#version 400\n\nuniform vec4      expected_color;\nuniform int       lod;\nuniform sampler2D sampler;\n\nout int result;\n\nvoid main()\n{\n    const float epsilon = 1.0 / 256.0;\n\n    vec4 sampled_data = textureLod(sampler, vec2(0.5, 0.5), lod);\n\n    if (abs(sampled_data.x - expected_color.x) > epsilon ||\n        abs(sampled_data.y - expected_color.y) > epsilon ||\n        abs(sampled_data.z - expected_color.z) > epsilon ||\n        abs(sampled_data.w - expected_color.w) > epsilon)\n    {\n        result = 0;\n    }\n    else\n    {\n        result = 1;\n    }\n}\n";

#[derive(Clone, Copy, PartialEq, Eq)]
enum BarrierType {
    None,
    TextureFetchBarrierBit,
    TextureUpdateBufferBit,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TextureType {
    ParentTexture,
    TextureView,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum VerificationMean {
    Program,
    GlGetTexImage,
}

fn static_color_float() -> [f32; 4] {
    STATIC_COLOR_BYTE.map(|byte| byte as f32 / 255.0)
}

/// `getStaticColorTextureData`
fn static_color_texture_data(width: u32, height: u32) -> Vec<u8> {
    let mut result = vec![0u8; (width * height * TEXTURE_N_COMPONENTS) as usize];

    for pixel in result.chunks_exact_mut(TEXTURE_N_COMPONENTS as usize) {
        pixel.copy_from_slice(&STATIC_COLOR_BYTE);
    }

    result
}

/// `getHorizontalGradientData`
fn horizontal_gradient_data() -> Vec<u8> {
    let end_rgba = [1.0f32, 0.9, 0.0, 0.0];
    let start_rgba = [0.0f32, 0.1, 1.0, 1.0];
    let texel_size = TEXTURE_N_COMPONENTS as usize;
    let mut result = vec![0u8; (TEXTURE_WIDTH * TEXTURE_HEIGHT * TEXTURE_N_COMPONENTS) as usize];

    for y in 0..TEXTURE_HEIGHT as usize {
        let row_offset = texel_size * TEXTURE_WIDTH as usize * y;

        for x in 0..TEXTURE_WIDTH as usize {
            let lerp_factor = x as f32 / TEXTURE_WIDTH as f32;
            let pixel_offset = row_offset + texel_size * x;

            for n_component in 0..4 {
                result[pixel_offset + n_component] = ((end_rgba[n_component] * lerp_factor
                    + start_rgba[n_component] * (1.0 - lerp_factor))
                    * 255.0) as u8;
            }
        }
    }

    result
}

/// The GL objects of one run; `TextureViewTestCoherency::deinit` is the `Drop`.
struct State<'gl> {
    gl: &'gl glw::Functions,
    are_images_supported: bool,
    bo_id: GLuint,
    draw_fbo_id: GLuint,
    gradient_verification_po_id: GLuint,
    gradient_verification_po_sample_exact_uv_location: GLint,
    gradient_verification_po_lod_location: GLint,
    gradient_verification_po_texture_location: GLint,
    gradient_verification_vs_id: GLuint,
    gradient_image_write_image_size_location: GLint,
    gradient_image_write_po_id: GLuint,
    gradient_image_write_vs_id: GLuint,
    gradient_write_po_id: GLuint,
    gradient_write_fs_id: GLuint,
    gradient_write_vs_id: GLuint,
    read_fbo_id: GLuint,
    static_to_id: GLuint,
    to_id: GLuint,
    vao_id: GLuint,
    view_to_id: GLuint,
    verification_po_expected_color_location: GLint,
    verification_po_lod_location: GLint,
    verification_po_id: GLuint,
    verification_vs_id: GLuint,
}

impl Drop for State<'_> {
    fn drop(&mut self) {
        let gl = self.gl;
        // SAFETY: every name below was created by this state, is deleted once and zero names are skipped.
        unsafe {
            if self.bo_id != 0 {
                gl.delete_buffers(1, &self.bo_id);
            }
            if self.draw_fbo_id != 0 {
                gl.delete_framebuffers(1, &self.draw_fbo_id);
            }
            for program in [
                self.gradient_image_write_po_id,
                self.gradient_verification_po_id,
                self.gradient_write_po_id,
                self.verification_po_id,
            ] {
                if program != 0 {
                    gl.delete_program(program);
                }
            }
            for shader in [
                self.gradient_image_write_vs_id,
                self.gradient_verification_vs_id,
                self.gradient_write_fs_id,
                self.gradient_write_vs_id,
                self.verification_vs_id,
            ] {
                if shader != 0 {
                    gl.delete_shader(shader);
                }
            }
            if self.read_fbo_id != 0 {
                gl.delete_framebuffers(1, &self.read_fbo_id);
            }
            for texture in [self.static_to_id, self.to_id, self.view_to_id] {
                if texture != 0 {
                    gl.delete_textures(1, &texture);
                }
            }
            if self.vao_id != 0 {
                gl.delete_vertex_arrays(1, &self.vao_id);
            }
            gl.disable(glw::GL_RASTERIZER_DISCARD);
        }
    }
}

impl<'gl> State<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        Self {
            gl,
            are_images_supported: false,
            bo_id: 0,
            draw_fbo_id: 0,
            gradient_verification_po_id: 0,
            gradient_verification_po_sample_exact_uv_location: -1,
            gradient_verification_po_lod_location: -1,
            gradient_verification_po_texture_location: -1,
            gradient_verification_vs_id: 0,
            gradient_image_write_image_size_location: -1,
            gradient_image_write_po_id: 0,
            gradient_image_write_vs_id: 0,
            gradient_write_po_id: 0,
            gradient_write_fs_id: 0,
            gradient_write_vs_id: 0,
            read_fbo_id: 0,
            static_to_id: 0,
            to_id: 0,
            vao_id: 0,
            view_to_id: 0,
            verification_po_expected_color_location: -1,
            verification_po_lod_location: -1,
            verification_po_id: 0,
            verification_vs_id: 0,
        }
    }

    /// `getReadPropertiesForTextureType`: the sibling's name and the LOD to read it at.
    fn read_properties(&self, texture_type: TextureType) -> (GLuint, u32) {
        match texture_type {
            // LOD1 of the parent is LOD 0 of the view; LOD1 of the view is LOD2 of the parent.
            TextureType::ParentTexture => (self.view_to_id, 0),
            TextureType::TextureView => (self.to_id, 2),
        }
    }

    /// `getWritePropertiesForTextureType`: name, width and height of the mip-map the test writes to (layer 1 of either object).
    fn write_properties(&self, texture_type: TextureType) -> (GLuint, u32, u32) {
        match texture_type {
            TextureType::ParentTexture => (self.to_id, TEXTURE_WIDTH >> 1, TEXTURE_HEIGHT >> 1),
            TextureType::TextureView => (self.view_to_id, TEXTURE_WIDTH >> 2, TEXTURE_HEIGHT >> 2),
        }
    }

    /// `checkAPICallCoherency`
    fn check_api_call_coherency(
        &self,
        texture_type: TextureType,
        should_use_gl_tex_sub_image_2d: bool,
    ) -> Result<(), TestError> {
        let gl = self.gl;
        let (write_to_id, write_to_width, write_to_height) = self.write_properties(texture_type);

        if should_use_gl_tex_sub_image_2d {
            gl_call!(
                gl,
                "glActiveTexture() call failed.",
                gl.active_texture(glw::GL_TEXTURE0)
            );
            gl_call!(
                gl,
                "glBindTexture() call failed.",
                gl.bind_texture(glw::GL_TEXTURE_2D, write_to_id)
            );
        } else {
            gl_call!(gl, "glBindFramebuffer call(s) failed.", {
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.draw_fbo_id);
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.read_fbo_id);
            });
            gl_call!(
                gl,
                "glFramebufferTexture2D() call failed for GL_DRAW_FRAMEBUFFER target.",
                gl.framebuffer_texture_2d(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    write_to_id,
                    1
                )
            );
            gl_call!(
                gl,
                "glFramebufferTexture2D() call failed for GL_READ_FRAMEBUFFER target.",
                gl.framebuffer_texture_2d(
                    glw::GL_READ_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    self.static_to_id,
                    0
                )
            );
        }

        let region_width = write_to_width >> 1;
        let region_height = write_to_height >> 1;
        let region_x = region_width - (region_width >> 1);
        let region_y = region_height - (region_height >> 1);

        if should_use_gl_tex_sub_image_2d {
            let static_color_data = static_color_texture_data(region_width, region_height);
            gl_call!(
                gl,
                "glTexSubImage2D() call failed.",
                gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    1,
                    region_x as GLint,
                    region_y as GLint,
                    region_width as GLint,
                    region_height as GLint,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    static_color_data.as_ptr().cast()
                )
            );
        } else {
            gl_call!(
                gl,
                "glBlitFramebuffer() call failed.",
                gl.blit_framebuffer(
                    0,
                    0,
                    STATIC_TEXTURE_WIDTH as GLint,
                    STATIC_TEXTURE_HEIGHT as GLint,
                    region_x as GLint,
                    region_y as GLint,
                    (region_x + region_width) as GLint,
                    (region_y + region_height) as GLint,
                    glw::GL_COLOR_BUFFER_BIT,
                    glw::GL_NEAREST
                )
            );
        }

        let (read_to_id, read_lod) = self.read_properties(texture_type);
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, read_to_id)
        );

        gl_call!(
            gl,
            "glUseProgram() call failed.",
            gl.use_program(self.verification_po_id)
        );

        let static_color = static_color_float();
        gl_call!(
            gl,
            "glUniform4fv() call failed.",
            gl.uniform_4fv(self.verification_po_expected_color_location, 1, static_color.as_ptr())
        );
        gl_call!(
            gl,
            "glUniform1i() call failed.",
            gl.uniform_1i(self.verification_po_lod_location, read_lod as GLint)
        );

        gl_call!(gl, "glEnable() call failed.", gl.enable(glw::GL_RASTERIZER_DISCARD));

        gl_call!(
            gl,
            "glBeginTransformFeedback() call failed.",
            gl.begin_transform_feedback(glw::GL_POINTS)
        );
        gl_call!(gl, "glDrawArrays() call failed.", gl.draw_arrays(glw::GL_POINTS, 0, 1));
        gl_call!(gl, "glEndTransformFeedback() call failed.", gl.end_transform_feedback());

        let results = self.map_results(1)?;

        if results[0] != 1 {
            return Err(TestError::Fail("Invalid data was sampled in vertex shader".to_string()));
        }

        gl_call!(gl, "glDisable() call failed.", gl.disable(glw::GL_RASTERIZER_DISCARD));

        Ok(())
    }

    /// Maps the transform feedback buffer, copies the first `count` results and unmaps it again.
    fn map_results(&self, count: usize) -> Result<Vec<GLint>, TestError> {
        let gl = self.gl;

        // SAFETY: the buffer was sized for (TEXTURE_HEIGHT >> 1) * (TEXTURE_WIDTH >> 1) integers, see init_buffer_objects.
        let data_ptr = unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) } as *const GLint;
        crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

        if data_ptr.is_null() {
            return Err(TestError::Fail(
                "glMapBuffer() did not generate an error but returned a NULL pointer".to_string(),
            ));
        }

        // SAFETY: `count` never exceeds the number of integers the buffer was sized for.
        let results = unsafe { std::slice::from_raw_parts(data_ptr, count) }.to_vec();

        gl_call!(
            gl,
            "glUnmapBuffer() call failed.",
            gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
        );

        Ok(results)
    }

    /// `checkProgramWriteCoherency`
    fn check_program_write_coherency(
        &self,
        texture_type: TextureType,
        should_use_images: bool,
        barrier_type: BarrierType,
        verification_mean: VerificationMean,
    ) -> Result<(), TestError> {
        let gl = self.gl;

        if !should_use_images {
            debug_assert!(barrier_type == BarrierType::None);
            debug_assert!(verification_mean == VerificationMean::Program);
        }

        let (write_to_id, write_to_width, write_to_height) = self.write_properties(texture_type);

        if should_use_images {
            gl_call!(
                gl,
                "glBindImageTexture() call failed.",
                gl.bind_image_texture(0, write_to_id, 1, glw::FALSE, 0, glw::GL_WRITE_ONLY, glw::GL_RGBA8)
            );
        } else {
            gl_call!(
                gl,
                "glBindFramebuffer() call failed for GL_FRAMEBUFFER target",
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.draw_fbo_id)
            );
            gl_call!(
                gl,
                "glFramebufferTexture2D() call failed.",
                gl.framebuffer_texture_2d(
                    glw::GL_DRAW_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    write_to_id,
                    1
                )
            );

            gl_call!(
                gl,
                "glViewport() call failed.",
                gl.viewport(0, 0, write_to_width as GLint, write_to_height as GLint)
            );
        }

        if should_use_images {
            gl_call!(
                gl,
                "glUseProgram() call failed.",
                gl.use_program(self.gradient_image_write_po_id)
            );

            gl_call!(
                gl,
                "glUniform2i() call failed.",
                gl.uniform_2i(
                    self.gradient_image_write_image_size_location,
                    write_to_width as GLint,
                    write_to_height as GLint
                )
            );

            gl_call!(
                gl,
                "glEnable(GL_RASTERIZER_DISCARD) call failed.",
                gl.enable(glw::GL_RASTERIZER_DISCARD)
            );

            gl_call!(
                gl,
                "glDrawArrays() call failed.",
                gl.draw_arrays(glw::GL_POINTS, 0, (write_to_width * write_to_height) as GLint)
            );

            gl_call!(
                gl,
                "glDisable(GL_RASTERIZER_DISCARD) call failed.",
                gl.disable(glw::GL_RASTERIZER_DISCARD)
            );

            match barrier_type {
                BarrierType::TextureFetchBarrierBit => {
                    gl_call!(
                        gl,
                        "glMemoryBarrier() call failed for GL_TEXTURE_FETCH_BARRIER_BIT barrier",
                        gl.memory_barrier(glw::GL_TEXTURE_FETCH_BARRIER_BIT)
                    );
                }
                BarrierType::TextureUpdateBufferBit => {
                    gl_call!(
                        gl,
                        "glMemoryBarrier() call failed for GL_TEXTURE_UPDATE_BARRIER_BIT barrier",
                        gl.memory_barrier(glw::GL_TEXTURE_UPDATE_BARRIER_BIT)
                    );
                }
                BarrierType::None => {
                    return Err(TestError::Fail("Unrecognized barrier type".to_string()));
                }
            }
        } else {
            gl_call!(
                gl,
                "gluseProgram() call failed.",
                gl.use_program(self.gradient_write_po_id)
            );
            gl_call!(
                gl,
                "glDrawArrays() call failed.",
                gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4)
            );
            gl_call!(gl, "glTextureBarrier() call failed.", gl.texture_barrier());
        }

        let (read_to_id, read_lod) = self.read_properties(texture_type);

        gl_call!(
            gl,
            "glActiveTexture() call failed.",
            gl.active_texture(glw::GL_TEXTURE0)
        );
        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, read_to_id)
        );

        if verification_mean == VerificationMean::Program {
            let n_invocations = (write_to_width * write_to_height) as usize;

            gl_call!(
                gl,
                "glUseProgram() call failed.",
                gl.use_program(self.gradient_verification_po_id)
            );
            gl_call!(
                gl,
                "glUniform1i() call failed.",
                gl.uniform_1i(self.gradient_verification_po_texture_location, 0)
            );
            gl_call!(
                gl,
                "glUniform1i() call failed.",
                gl.uniform_1i(
                    self.gradient_verification_po_sample_exact_uv_location,
                    should_use_images as GLint
                )
            );
            gl_call!(
                gl,
                "glUniform1f() call failed.",
                gl.uniform_1f(self.gradient_verification_po_lod_location, read_lod as f32)
            );

            gl_call!(
                gl,
                "glEnable(GL_RASTERIZER_DISCARD) call failed.",
                gl.enable(glw::GL_RASTERIZER_DISCARD)
            );

            gl_call!(
                gl,
                "glBeginTransformFeedback() call failed.",
                gl.begin_transform_feedback(glw::GL_POINTS)
            );
            gl_call!(
                gl,
                "glDrawArrays() call failed.",
                gl.draw_arrays(glw::GL_POINTS, 0, n_invocations as GLint)
            );
            gl_call!(gl, "glEndTransformFeedback() call failed.", gl.end_transform_feedback());

            gl_call!(
                gl,
                "glDisable(GL_RASTERIZER_DISCARD) call failed.",
                gl.disable(glw::GL_RASTERIZER_DISCARD)
            );

            // SAFETY: the buffer holds (TEXTURE_HEIGHT >> 1) * (TEXTURE_WIDTH >> 1) integers and n_invocations never exceeds that.
            let data_ptr =
                unsafe { gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY) } as *const GLint;
            crate::glu::expect_no_error(gl, "glMapBuffer() call failed.")?;

            if data_ptr.is_null() {
                return Err(TestError::Fail(
                    "glMapBuffer() did not generate an error but returned a NULL pointer".to_string(),
                ));
            }

            // SAFETY: see the mapping above.
            let result_data = unsafe { std::slice::from_raw_parts(data_ptr, n_invocations) }.to_vec();

            for (n_invocation, result) in result_data.iter().enumerate() {
                if *result != 1 {
                    let invocation_x = n_invocation as u32 % write_to_width;
                    let invocation_y = n_invocation as u32 / write_to_width;

                    log::info!(
                        "Invalid data was sampled at ({invocation_x}, {invocation_y}) when sampling from {}",
                        if texture_type == TextureType::ParentTexture {
                            "a texture"
                        } else {
                            "a view"
                        }
                    );

                    // SAFETY: the buffer is mapped; it is unmapped before failing.
                    unsafe { gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER) };

                    return Err(TestError::Fail("Invalid data sampled".to_string()));
                }
            }

            gl_call!(
                gl,
                "glUnmapBuffer() call failed.",
                gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER)
            );
        } else {
            debug_assert!(verification_mean == VerificationMean::GlGetTexImage);

            let mut data = vec![0u8; (write_to_width * write_to_height * TEXTURE_N_COMPONENTS) as usize];

            // SAFETY: the buffer holds a whole RGBA8 level of write_to_width x write_to_height texels.
            unsafe {
                gl.get_tex_image(
                    glw::GL_TEXTURE_2D,
                    read_lod as GLint,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data.as_mut_ptr().cast(),
                )
            };
            if unsafe { gl.get_error() } != glw::GL_NO_ERROR {
                return Err(TestError::Fail("glGetTexImage() call failed.".to_string()));
            }

            let epsilon = 1;
            let mut is_data_correct = true;

            for y in 0..write_to_height as usize {
                let row_offset = y * TEXTURE_N_COMPONENTS as usize * write_to_width as usize;

                for x in 0..write_to_width as usize {
                    let texel = &data[row_offset + x * TEXTURE_N_COMPONENTS as usize..];
                    let end_rgba = [0.0f32, 0.1, 1.0, 1.0];
                    let lerp_factor = x as f32 / write_to_width as f32;
                    let start_rgba = [1.0f32, 0.9, 0.0, 0.0];
                    let expected_data_float: [f32; 4] =
                        std::array::from_fn(|n| start_rgba[n] * (1.0 - lerp_factor) + end_rgba[n] * lerp_factor);
                    let expected_data_ubyte: [u8; 4] = expected_data_float.map(|value| (value * 255.0) as u8);

                    if (0..4).any(|n| (texel[n] as i32 - expected_data_ubyte[n] as i32).abs() > epsilon) {
                        is_data_correct = false;
                        break;
                    }
                }
            }

            if !is_data_correct {
                return Err(TestError::Fail("Invalid data sampled".to_string()));
            }
        }

        Ok(())
    }

    /// `initBufferObjects`
    fn init_buffer_objects(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(gl, "glGenBuffers() call failed.", gl.gen_buffers(1, &mut self.bo_id));
        gl_call!(
            gl,
            "glBindBuffer() call failed.",
            gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, self.bo_id)
        );
        gl_call!(
            gl,
            "glBindBufferBase() call failed.",
            gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, self.bo_id)
        );

        let bo_size = ((TEXTURE_HEIGHT >> 1) * (TEXTURE_WIDTH >> 1)) as usize * std::mem::size_of::<i32>();
        gl_call!(
            gl,
            "glBufferdata() call failed.",
            gl.buffer_data(
                glw::GL_TRANSFORM_FEEDBACK_BUFFER,
                bo_size as isize,
                std::ptr::null(),
                glw::GL_STATIC_DRAW
            )
        );

        Ok(())
    }

    /// `initFBO`
    fn init_fbo(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(gl, "glGenFramebuffers() call failed.", {
            gl.gen_framebuffers(1, &mut self.draw_fbo_id);
            gl.gen_framebuffers(1, &mut self.read_fbo_id);
        });

        Ok(())
    }

    /// `initPrograms`
    fn init_programs(&mut self, context: &Context) -> Result<(), TestError> {
        let gl = self.gl;

        self.are_images_supported = context
            .context_info
            .is_extension_supported("GL_ARB_shader_image_load_store");

        if self.are_images_supported {
            let mut gl_max_vertex_image_uniforms_value: GLint = 0;
            gl_call!(
                gl,
                "glGetIntegerv() call failed for GL_MAX_VERTEX_IMAGE_UNIFORM pname",
                gl.get_integerv(
                    glw::GL_MAX_VERTEX_IMAGE_UNIFORMS,
                    &mut gl_max_vertex_image_uniforms_value
                )
            );

            if gl_max_vertex_image_uniforms_value < 1 {
                log::info!(
                    "Image support will not be tested by view_parent_texture_coherency, asthe implementation does not support image uniforms in vertex shader stage."
                );

                self.are_images_supported = false;
            }
        }

        // SAFETY: plain object creation with a current context.
        unsafe {
            if self.are_images_supported {
                self.gradient_image_write_po_id = gl.create_program();
            }
            self.gradient_verification_po_id = gl.create_program();
            self.gradient_write_po_id = gl.create_program();
            self.verification_po_id = gl.create_program();
        }
        crate::glu::expect_no_error(gl, "glCreateProgram() call(s) failed.")?;

        // SAFETY: plain object creation with a current context.
        self.gradient_write_fs_id = unsafe { gl.create_shader(glw::GL_FRAGMENT_SHADER) };
        crate::glu::expect_no_error(gl, "glCreateShader() call failed for GL_FRAGMENT_SHADER type")?;

        // SAFETY: plain object creation with a current context.
        unsafe {
            if self.are_images_supported {
                self.gradient_image_write_vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
            }
            self.gradient_verification_vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
            self.gradient_write_vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
            self.verification_vs_id = gl.create_shader(glw::GL_VERTEX_SHADER);
        }
        crate::glu::expect_no_error(gl, "glCreateShader() call(s) failed for GL_VERTEX_SHADER type.")?;

        shader_source(
            gl,
            self.gradient_verification_vs_id,
            GRADIENT_VERIFICATION_VS_BODY,
            "glShaderSource() call failed.",
        )?;

        if self.are_images_supported {
            shader_source(
                gl,
                self.gradient_image_write_vs_id,
                GRADIENT_WRITE_IMAGE_VS_BODY,
                "glShaderSource() call failed.",
            )?;
        }

        shader_source(
            gl,
            self.gradient_write_fs_id,
            GRADIENT_WRITE_FS_BODY,
            "glShaderSource() call failed.",
        )?;
        shader_source(
            gl,
            self.gradient_write_vs_id,
            GRADIENT_WRITE_VS_BODY,
            "glShaderSource() call failed.",
        )?;
        shader_source(
            gl,
            self.verification_vs_id,
            VERIFICATION_VS_BODY,
            "glShaderSource() call failed.",
        )?;

        let so_ids = [
            self.gradient_image_write_vs_id,
            self.gradient_verification_vs_id,
            self.gradient_write_fs_id,
            self.gradient_write_vs_id,
            self.verification_vs_id,
        ];

        for so_id in so_ids {
            if so_id != 0 {
                gl_call!(gl, "glCompileShader() call failed.", gl.compile_shader(so_id));

                let mut compile_status = glw::GL_FALSE as GLint;
                gl_call!(
                    gl,
                    "glGetShaderiv() call failed.",
                    gl.get_shaderiv(so_id, glw::GL_COMPILE_STATUS, &mut compile_status)
                );

                if compile_status != glw::GL_TRUE as GLint {
                    return Err(TestError::Fail("Shader compilation failed.".to_string()));
                }
            }
        }

        gl_call!(gl, "glAttachShader() call(s) failed.", {
            if self.are_images_supported {
                gl.attach_shader(self.gradient_image_write_po_id, self.gradient_image_write_vs_id);
            }
            gl.attach_shader(self.gradient_verification_po_id, self.gradient_verification_vs_id);
            gl.attach_shader(self.gradient_write_po_id, self.gradient_write_fs_id);
            gl.attach_shader(self.gradient_write_po_id, self.gradient_write_vs_id);
            gl.attach_shader(self.verification_po_id, self.verification_vs_id);
        });

        let verification_varying_name = CString::new("result").expect("no NUL");
        let verification_varying_name_ptr = verification_varying_name.as_ptr();

        for po_id in [self.gradient_verification_po_id, self.verification_po_id] {
            gl_call!(
                gl,
                "glTransformFeedbackVaryings() call failed.",
                gl.transform_feedback_varyings(po_id, 1, &verification_varying_name_ptr, glw::GL_INTERLEAVED_ATTRIBS)
            );
        }

        let po_ids = [
            self.gradient_image_write_po_id,
            self.gradient_verification_po_id,
            self.gradient_write_po_id,
            self.verification_po_id,
        ];

        for po_id in po_ids {
            if po_id != 0 {
                gl_call!(gl, "glLinkProgram() call failed.", gl.link_program(po_id));

                let mut link_status = glw::GL_FALSE as GLint;
                gl_call!(
                    gl,
                    "glGetProgramiv() call failed.",
                    gl.get_programiv(po_id, glw::GL_LINK_STATUS, &mut link_status)
                );

                if link_status != glw::GL_TRUE as GLint {
                    return Err(TestError::Fail("Program linking failed.".to_string()));
                }
            }
        }

        if self.are_images_supported {
            self.gradient_image_write_image_size_location =
                uniform_location(gl, self.gradient_image_write_po_id, "image_size");

            if self.gradient_image_write_image_size_location == -1 {
                return Err(TestError::Fail(
                    "image_size is considered an inactive uniform which is invalid.".to_string(),
                ));
            }
        }

        self.gradient_verification_po_sample_exact_uv_location =
            uniform_location(gl, self.gradient_verification_po_id, "sample_exact_uv");
        self.gradient_verification_po_lod_location = uniform_location(gl, self.gradient_verification_po_id, "lod");
        self.gradient_verification_po_texture_location =
            uniform_location(gl, self.gradient_verification_po_id, "texture");

        if self.gradient_verification_po_sample_exact_uv_location == -1 {
            return Err(TestError::Fail(
                "sample_exact_uv is considered an inactive uniform which is invalid".to_string(),
            ));
        }

        if self.gradient_verification_po_lod_location == -1 {
            return Err(TestError::Fail(
                "lod is considered an inactive uniform which is invalid.".to_string(),
            ));
        }

        if self.gradient_verification_po_texture_location == -1 {
            return Err(TestError::Fail(
                "texture is considered an inactive uniform which is invalid.".to_string(),
            ));
        }

        self.verification_po_expected_color_location = uniform_location(gl, self.verification_po_id, "expected_color");
        self.verification_po_lod_location = uniform_location(gl, self.verification_po_id, "lod");

        if self.verification_po_expected_color_location == -1 {
            return Err(TestError::Fail(
                "expected_color is considered an inactive uniform which is invalid.".to_string(),
            ));
        }

        if self.verification_po_lod_location == -1 {
            return Err(TestError::Fail(
                "lod is considered an inactive uniform which is invalid.".to_string(),
            ));
        }

        Ok(())
    }

    /// `initTextures`
    fn init_textures(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(gl, "glGenTextures() call(s) failed.", {
            gl.gen_textures(1, &mut self.static_to_id);
            gl.gen_textures(1, &mut self.to_id);
            gl.gen_textures(1, &mut self.view_to_id);
        });

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.to_id)
        );

        gl_call!(
            gl,
            "glTexStorage2D() call failed.",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                TEXTURE_N_LEVELS as GLint,
                glw::GL_RGBA8,
                TEXTURE_WIDTH as GLint,
                TEXTURE_HEIGHT as GLint
            )
        );

        gl_call!(gl, "glTexParameteri() call(s) failed.", {
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_WRAP_S,
                glw::GL_CLAMP_TO_EDGE as GLint,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_WRAP_T,
                glw::GL_CLAMP_TO_EDGE as GLint,
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST_MIPMAP_NEAREST as GLint,
            );
        });

        gl_call!(
            gl,
            "glTextureView() call failed",
            gl.texture_view(
                self.view_to_id,
                glw::GL_TEXTURE_2D,
                self.to_id,
                glw::GL_RGBA8,
                1,
                2,
                0,
                1
            )
        );

        // SAFETY: plain state calls on the bound view.
        unsafe {
            gl.bind_texture(glw::GL_TEXTURE_2D, self.view_to_id);
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_WRAP_S,
                glw::GL_CLAMP_TO_EDGE as GLint,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_WRAP_T,
                glw::GL_CLAMP_TO_EDGE as GLint,
            );
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST_MIPMAP_NEAREST as GLint,
            );
        }

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.static_to_id)
        );

        gl_call!(
            gl,
            "glTexStorage2D() call failed.",
            gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA8,
                STATIC_TEXTURE_WIDTH as GLint,
                STATIC_TEXTURE_HEIGHT as GLint
            )
        );

        self.init_texture_contents()
    }

    /// `initTextureContents`
    fn init_texture_contents(&self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.to_id)
        );

        let base_mipmap_data = horizontal_gradient_data();
        // SAFETY: the buffer holds a whole TEXTURE_WIDTH x TEXTURE_HEIGHT RGBA8 level.
        unsafe {
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                TEXTURE_WIDTH as GLint,
                TEXTURE_HEIGHT as GLint,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                base_mipmap_data.as_ptr().cast(),
            );
        }
        crate::glu::expect_no_error(gl, "glTexSubImage2D() call failed.")?;

        gl_call!(
            gl,
            "glGenerateMipmap() call failed.",
            gl.generate_mipmap(glw::GL_TEXTURE_2D)
        );

        const { assert!(STATIC_TEXTURE_HEIGHT == 1 && STATIC_TEXTURE_WIDTH == 1) };
        let static_texture_data = static_color_texture_data(STATIC_TEXTURE_WIDTH, STATIC_TEXTURE_HEIGHT);

        gl_call!(
            gl,
            "glBindTexture() call failed.",
            gl.bind_texture(glw::GL_TEXTURE_2D, self.static_to_id)
        );

        // SAFETY: the buffer holds the single RGBA8 texel of the static texture.
        unsafe {
            gl.tex_sub_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                0,
                0,
                STATIC_TEXTURE_WIDTH as GLint,
                STATIC_TEXTURE_HEIGHT as GLint,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                static_texture_data.as_ptr().cast(),
            );
        }
        crate::glu::expect_no_error(gl, "glTexSubImage2D() call failed.")?;

        Ok(())
    }

    /// `initVAO`
    fn init_vao(&mut self) -> Result<(), TestError> {
        let gl = self.gl;

        gl_call!(
            gl,
            "glGenVertexArrays() call failed.",
            gl.gen_vertex_arrays(1, &mut self.vao_id)
        );
        gl_call!(
            gl,
            "glBindVertexArray() call failed.",
            gl.bind_vertex_array(self.vao_id)
        );

        Ok(())
    }
}

/// `TextureViewTestCoherency`
pub(super) struct Coherency;

impl TestCase for Coherency {
    fn name(&self) -> &str {
        "coherency"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        check_texture_view_support(context)?;

        let mut state = State::new(context.gl());

        state.init_buffer_objects()?;
        state.init_programs(context)?;
        state.init_textures()?;
        state.init_fbo()?;
        state.init_vao()?;

        for texture_type in [TextureType::ParentTexture, TextureType::TextureView] {
            state.check_api_call_coherency(texture_type, true)?;

            state.check_api_call_coherency(texture_type, false)?;

            state.check_program_write_coherency(texture_type, false, BarrierType::None, VerificationMean::Program)?;

            if state.are_images_supported {
                state.check_program_write_coherency(
                    texture_type,
                    true,
                    BarrierType::TextureFetchBarrierBit,
                    VerificationMean::Program,
                )?;

                state.check_program_write_coherency(
                    texture_type,
                    true,
                    BarrierType::TextureUpdateBufferBit,
                    VerificationMean::GlGetTexImage,
                )?;
            }

            state.init_texture_contents()?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}
