// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/fragment_shading_rate/esextcFragmentShadingRateAttachmentTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use std::ffi::CString;

use super::{
    FRAGMENT_SHADING_RATE_NOT_SUPPORTED, TRIANGLE_COUNT, available_shading_rates, not_supported, pack_shading_rate,
    random_vertices, reset_shading_rate_state,
};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase};
use crate::glw::{self, GLenum, GLint, GLsizei, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const MULTIVIEW_OVR_NOT_SUPPORTED: &str = "multiview ovr functionality not supported, skipping";

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum TestKind {
    Scissor,
    MultiView,
}

/// `FragmentShadingRateAttachment::TestcaseParam`
#[derive(Clone, Copy)]
pub(super) struct TestcaseParam {
    pub test_kind: TestKind,
    pub attachment_shading_rate: bool,
    pub multi_shading_rate: bool,
    pub framebuffer_size: u32,
    pub layer_count: u32,
}

/// `FragmentShadingRateAttachment::Box`
#[derive(Clone, Copy, Default)]
struct ScissorBox {
    x: u32,
    y: u32,
    width: u32,
    height: u32,
}

impl ScissorBox {
    fn contains(&self, x_in: u32, y_in: u32) -> bool {
        x_in >= self.x && x_in < self.x + self.width && y_in >= self.y && y_in < self.y + self.height
    }
}

fn expect(gl: &glw::Functions, message: &str) -> Result<(), TestError> {
    glu::expect_no_error(gl, message)
}

fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("no nul byte");
    gl!(gl.get_uniform_location(program, name.as_ptr()))
}

/// `FragmentShadingRateAttachment`
pub(super) struct Attachment {
    ext_params: ExtParameters,
    param: TestcaseParam,
    name: String,
}

#[derive(Default)]
struct Resources {
    to_id: GLuint,
    sr_to_id: GLuint,
    fbo_id: GLuint,
    vao_id: GLuint,
    vbo_id: GLuint,
}

impl Attachment {
    pub(super) fn new(ext_params: ExtParameters, param: TestcaseParam, name: String) -> Self {
        Self {
            ext_params,
            param,
            name,
        }
    }

    fn init(&self, context: &Context, base: &TestCaseBase) -> Result<(), TestError> {
        let param = &self.param;
        let gl = context.gl();

        if !base.is_fragment_shading_rate_supported {
            return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
        }

        if !base.is_fragment_shading_rate_attachment_supported {
            if param.attachment_shading_rate {
                return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
            }

            if param.multi_shading_rate {
                return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
            }
        }

        if !base.is_multiview_ovr_supported {
            return Err(not_supported(MULTIVIEW_OVR_NOT_SUPPORTED));
        }

        if param.layer_count > 1 {
            let mut max_layers: GLint = 1;
            if param.attachment_shading_rate {
                gl!(gl.get_integerv(glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS_EXT, &mut max_layers));
                expect(gl, "Error getting MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS")?;

                if param.layer_count as GLint > max_layers {
                    return Err(not_supported("Number of layers in FSR attachment exceeds limit"));
                }
            }
        }
        Ok(())
    }

    fn deinit(gl: &glw::Functions, base: &TestCaseBase, resources: &Resources) {
        reset_shading_rate_state(gl, base);

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        gl!(gl.delete_textures(1, &resources.to_id));
        gl!(gl.delete_textures(1, &resources.sr_to_id));
        gl!(gl.delete_framebuffers(1, &resources.fbo_id));
        gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        gl!(gl.delete_buffers(1, &resources.vbo_id));
    }

    fn gen_vs(&self) -> String {
        let multi_view = self.param.test_kind == TestKind::MultiView;
        let mut os = String::from("#version 310 es\n");
        if multi_view {
            os.push_str("#extension GL_OVR_multiview: enable\nlayout(num_views = 2) in;\n");
        }
        os.push_str("precision highp float;\nprecision highp int;\nuniform int drawID;\nlayout(location = 0) in vec4 position;\nvoid main() {\n    gl_Position = position;\n");
        if multi_view {
            os.push_str("if (gl_ViewID_OVR == 1u) {\ngl_Position.x  += 0.1;\n}\n");
        }
        os.push('}');
        os
    }

    fn gen_fs() -> &'static str {
        "#version 310 es\n#extension GL_EXT_fragment_shading_rate : enable\nprecision highp float;\nprecision highp int;\nlayout(location = 0) out ivec4 color0;\nuniform int drawID;\nvoid main() {\n    color0.x = gl_ShadingRateEXT;\n    color0.y = drawID;\n    color0.z = 0;\n    color0.w = 0;\n}"
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let param = &self.param;
        let size = param.framebuffer_size;
        let rates = available_shading_rates(gl, 1)?;
        let translate_coords =
            |sr_layer: u32, srx: u32, sry: u32| -> GLenum { rates[(sr_layer + srx + sry) as usize % rates.len()] };
        let translate_draw_id = |draw_id: u32| -> GLenum { rates[draw_id as usize % rates.len()] };

        // setupTest
        let program =
            ShaderProgram::new_reporting_build_failure(gl, &ProgramSources::vtx_frag(self.gen_vs(), Self::gen_fs()));
        if !program.is_ok() {
            if let Some(summary) = program.build_failure_summary() {
                log::info!("{summary}");
            }
            return Err(TestError::Fail("Shader creation failed".to_string()));
        }

        gl!(gl.gen_framebuffers(1, &mut resources.fbo_id));
        expect(gl, "Error setting up framebuffer objects")?;

        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resources.fbo_id));
        expect(gl, "Error binding frame buffer object!")?;

        gl!(gl.gen_textures(1, &mut resources.to_id));
        expect(gl, "Error generating texture objects")?;

        if param.layer_count > 1 {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, resources.to_id));
            expect(gl, "Error binding texture object!")?;
            gl!(gl.tex_storage_3d(
                glw::GL_TEXTURE_2D_ARRAY,
                1,
                glw::GL_RGBA32UI,
                size as GLsizei,
                size as GLsizei,
                param.layer_count as GLsizei
            ));
            expect(gl, "Error allocating texture object!")?;
        } else {
            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, resources.to_id));
            expect(gl, "Error binding texture object!")?;
            gl!(gl.tex_storage_2d(
                glw::GL_TEXTURE_2D,
                1,
                glw::GL_RGBA32UI,
                size as GLsizei,
                size as GLsizei
            ));
            expect(gl, "Error allocating texture object!")?;
        }

        if param.test_kind == TestKind::MultiView {
            gl!(gl.framebuffer_texture_multiview_ovr(
                glw::GL_DRAW_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                resources.to_id,
                0,
                0,
                param.layer_count as GLsizei
            ));
            expect(gl, "Error attaching texture to frame buffer")?;
        } else {
            gl!(gl.framebuffer_texture(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, resources.to_id, 0));
            expect(gl, "Error attaching texture to frame buffer")?;
        }

        // Adjust viewport to fit new framebuffer
        gl!(gl.viewport(0, 0, size as GLsizei, size as GLsizei));
        expect(gl, "viewport")?;

        let (mut sr_texel_width, mut sr_texel_height): (GLint, GLint) = (0, 0);

        // Generate a shading rate texture name
        if param.attachment_shading_rate {
            gl!(gl.get_integerv(
                glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_WIDTH_EXT,
                &mut sr_texel_width
            ));
            expect(
                gl,
                "Error getIntegerv GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_WIDTH_EXT!",
            )?;
            gl!(gl.get_integerv(
                glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_HEIGHT_EXT,
                &mut sr_texel_height
            ));
            expect(
                gl,
                "Error getIntegerv GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_HEIGHT_EXT!",
            )?;

            let sr_width = size.div_ceil(sr_texel_width as u32);
            let sr_height = size.div_ceil(sr_texel_height as u32);

            let sr_layer_count: u32 = if param.multi_shading_rate { 2 } else { 1 };
            let mut attachment_shading_rate_data: Vec<u8> =
                Vec::with_capacity((sr_width * sr_height * sr_layer_count) as usize);
            for sr_layer in 0..sr_layer_count {
                for y in 0..sr_height {
                    for x in 0..sr_width {
                        attachment_shading_rate_data.push(pack_shading_rate(translate_coords(sr_layer, x, y)) as u8);
                    }
                }
            }

            gl!(gl.gen_textures(1, &mut resources.sr_to_id));
            expect(gl, "Error generating texture objects")?;

            gl!(gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 1));
            expect(gl, "Error set pixelStorei for unpack alignment")?;

            if param.multi_shading_rate {
                gl!(gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, resources.sr_to_id));
                expect(gl, "Error binding texture object!")?;
                gl!(gl.tex_storage_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    1,
                    glw::GL_R8UI,
                    sr_width as GLsizei,
                    sr_height as GLsizei,
                    param.layer_count as GLsizei
                ));
                expect(gl, "Error allocating texture object!")?;
                gl!(gl.tex_sub_image_3d(
                    glw::GL_TEXTURE_2D_ARRAY,
                    0,
                    0,
                    0,
                    0,
                    sr_width as GLsizei,
                    sr_height as GLsizei,
                    param.layer_count as GLsizei,
                    glw::GL_RED_INTEGER,
                    glw::GL_UNSIGNED_BYTE,
                    attachment_shading_rate_data.as_ptr().cast()
                ));
                expect(gl, "Error updating shading rate data to texture")?;

                gl!(gl.framebuffer_shading_rate_ext(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_SHADING_RATE_ATTACHMENT_EXT,
                    resources.sr_to_id,
                    0,
                    param.layer_count as GLsizei,
                    sr_texel_width,
                    sr_texel_height
                ));
                expect(gl, "Error framebufferShadingRate")?;
            } else {
                gl!(gl.bind_texture(glw::GL_TEXTURE_2D, resources.sr_to_id));
                expect(gl, "Error binding texture object!")?;
                gl!(gl.tex_storage_2d(
                    glw::GL_TEXTURE_2D,
                    1,
                    glw::GL_R8UI,
                    sr_width as GLsizei,
                    sr_height as GLsizei
                ));
                expect(gl, "Error allocating texture object!")?;
                gl!(gl.tex_sub_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    0,
                    0,
                    sr_width as GLsizei,
                    sr_height as GLsizei,
                    glw::GL_RED_INTEGER,
                    glw::GL_UNSIGNED_BYTE,
                    attachment_shading_rate_data.as_ptr().cast()
                ));
                expect(gl, "Error updating shading rate data to texture")?;

                gl!(gl.framebuffer_shading_rate_ext(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_SHADING_RATE_ATTACHMENT_EXT,
                    resources.sr_to_id,
                    0,
                    1,
                    sr_texel_width,
                    sr_texel_height
                ));
                expect(gl, "Error framebufferShadingRate")?;
            }
        }

        // 1st draw triangle is huge to fill all rect.
        let mut vertices: Vec<f32> = vec![-3.0, -3.0, -3.0, 3.0, 3.0, -3.0];
        vertices.extend(random_vertices(0));

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        expect(gl, "Error generate vertex arrays")?;

        gl!(gl.bind_vertex_array(resources.vao_id));
        expect(gl, "Error bind vertex array")?;

        gl!(gl.gen_buffers(1, &mut resources.vbo_id));
        expect(gl, "Error generate buffer objects")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.vbo_id));
        expect(gl, "Error binding buffer objects")?;

        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (vertices.len() * std::mem::size_of::<f32>()) as isize,
            vertices.as_ptr().cast(),
            glw::GL_STATIC_DRAW
        ));
        expect(gl, "Error uploading buffer data")?;

        let mut scissor_box = ScissorBox::default();
        if param.test_kind == TestKind::Scissor {
            scissor_box = ScissorBox {
                x: size / 3,
                y: size / 3,
                width: size / 3,
                height: size / 3,
            };
        }

        gl!(gl.disable(glw::GL_DEPTH_TEST));
        gl!(gl.shading_rate_ext(glw::GL_SHADING_RATE_1X1_PIXELS_EXT));
        expect(gl, "Error to set shadingRateEXT as default")?;

        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        expect(gl, "Error clear Color")?;
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
        expect(gl, "Error clear")?;

        gl!(gl.use_program(program.program()));
        expect(gl, "Error use program")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.vbo_id));
        expect(gl, "Error bind buffer vertex data")?;

        gl!(gl.enable_vertex_attrib_array(0));
        expect(gl, "Error enabling vertex attrib pointer 0")?;

        gl!(gl.vertex_attrib_pointer(
            0,
            2,
            glw::GL_FLOAT,
            0,
            (std::mem::size_of::<f32>() * 2) as i32,
            std::ptr::null()
        ));
        expect(gl, "Error binding vertex attrib pointer 0")?;

        if param.attachment_shading_rate {
            gl!(gl.shading_rate_combiner_ops_ext(
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT,
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_REPLACE_EXT
            ));
        } else {
            gl!(gl.shading_rate_combiner_ops_ext(
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT,
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT
            ));
        }

        if param.test_kind == TestKind::Scissor {
            gl!(gl.scissor(
                scissor_box.x as GLint,
                scissor_box.y as GLint,
                scissor_box.width as GLsizei,
                scissor_box.height as GLsizei
            ));
            gl!(gl.enable(glw::GL_SCISSOR_TEST));
        }

        // draw ID start from 1
        for draw_id in 1..TRIANGLE_COUNT {
            gl!(gl.uniform_1i(uniform_location(gl, program.program(), "drawID"), draw_id as GLint));
            expect(gl, "Error set uniform drawID value")?;

            if !param.attachment_shading_rate {
                gl!(gl.shading_rate_ext(translate_draw_id(draw_id)));
                expect(gl, "Error set shading rate")?;
            }

            let start_vertex = (draw_id - 1) * 2; // to use first vertices "-1" because drawID start from 1
            gl!(gl.draw_arrays(glw::GL_TRIANGLES, start_vertex as GLint, 3));
            expect(gl, "Error draw a triangle")?;
        }

        for layer in 0..param.layer_count {
            if param.layer_count > 1 {
                gl!(gl.framebuffer_texture_layer(
                    glw::GL_READ_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    resources.to_id,
                    0,
                    layer as GLint
                ));
            }

            let data_size = size * size * 4;
            let mut result_data = vec![0u32; data_size as usize];
            gl!(gl.read_pixels(
                0,
                0,
                size as GLsizei,
                size as GLsizei,
                glw::GL_RGBA_INTEGER,
                glw::GL_UNSIGNED_INT,
                result_data.as_mut_ptr().cast()
            ));
            expect(gl, "Error reading pixels from frame buffer!")?;

            for y in 0..size {
                for x in 0..size {
                    let sample = &result_data[(((y * size) + x) * 4) as usize..][..4];
                    if param.test_kind == TestKind::Scissor {
                        // outside the box the pixels stay cleared, and upstream builds an error message there that it never reports
                        if !scissor_box.contains(x, y) && sample[1] == 0 {
                            // success. outside scissor is always 0
                            continue;
                        }
                    } else if sample[1] == 0 {
                        // nothing rendered for the other case except scissor test
                        continue;
                    }

                    let shading_rate = sample[0];
                    let draw_id = sample[1];

                    let expected_shading_rate = if param.attachment_shading_rate {
                        let sr_layer = if param.multi_shading_rate { layer } else { 0 };
                        pack_shading_rate(translate_coords(
                            sr_layer,
                            x / sr_texel_width as u32,
                            y / sr_texel_height as u32,
                        ))
                    } else {
                        pack_shading_rate(translate_draw_id(draw_id))
                    };

                    if expected_shading_rate != shading_rate {
                        let message = format!(
                            "The draw ID is {draw_id}Shading Rate is{shading_rate}, But we expect {expected_shading_rate}"
                        );
                        return Ok(TestStatus::fail(message));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Attachment {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        self.init(context, &base)?;

        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);
        Self::deinit(context.gl(), &base, &resources);
        outcome
    }
}
