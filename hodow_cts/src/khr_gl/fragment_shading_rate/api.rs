// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/fragment_shading_rate/esextcFragmentShadingRateBasic.cpp / .hpp
//   external/openglcts/modules/glesext/fragment_shading_rate/esextcFragmentShadingRateErrors.cpp / .hpp
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
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const DEFAULT_COLOR_FBO_SIZE: u32 = 255;
const ERROR_SHADING_RATE_ERROR: u32 = 1;

fn expect(gl: &glw::Functions, message: &str) -> Result<(), TestError> {
    glu::expect_no_error(gl, message)
}

fn uniform_location(gl: &glw::Functions, program: GLuint, name: &str) -> GLint {
    let name = CString::new(name).expect("no nul byte");
    gl!(gl.get_uniform_location(program, name.as_ptr()))
}

/// `FragmentShadingRateBasic`
pub(super) struct Basic {
    pub ext_params: ExtParameters,
}

#[derive(Default)]
struct BasicResources {
    to_id: GLuint,
    fbo_id: GLuint,
    vao_id: GLuint,
    vbo_id: GLuint,
}

impl Basic {
    fn gen_vs() -> &'static str {
        "#version 310 es                        \nprecision highp float;                 \nprecision highp int;                   \nlayout(location = 0) in vec4 position; \nvoid main() {                          \n    gl_Position = position;            \n}"
    }

    fn gen_fs() -> String {
        format!(
            "#version 310 es\n#extension GL_EXT_fragment_shading_rate : enable\nprecision highp float;\nprecision highp int;\nlayout(location = 0) out ivec4 color0;\nuniform int drawID;\nuniform int shadingRate;\nvoid main() {{\n    color0.x = gl_ShadingRateEXT;\n    color0.y = drawID;\n    color0.z = 0;\n    color0.w = 0;\n    if (gl_ShadingRateEXT != shadingRate) {{ \n        color0.w = {ERROR_SHADING_RATE_ERROR};\n    }}\n}}"
        )
    }

    fn deinit(gl: &glw::Functions, base: &TestCaseBase, resources: &BasicResources) {
        reset_shading_rate_state(gl, base);

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, 0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));

        gl!(gl.delete_textures(1, &resources.to_id));
        gl!(gl.delete_framebuffers(1, &resources.fbo_id));
        gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        gl!(gl.delete_buffers(1, &resources.vbo_id));
    }

    fn run(&self, context: &Context, resources: &mut BasicResources) -> TestOutcome {
        let gl = context.gl();
        let (width, height) = (DEFAULT_COLOR_FBO_SIZE, DEFAULT_COLOR_FBO_SIZE);

        // setupTest
        let program =
            ShaderProgram::new_reporting_build_failure(gl, &ProgramSources::vtx_frag(Self::gen_vs(), Self::gen_fs()));
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

        gl!(gl.bind_texture(glw::GL_TEXTURE_2D, resources.to_id));
        expect(gl, "Error binding texture object!")?;
        gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA32UI, width as i32, height as i32));
        expect(gl, "Error allocating texture object!")?;

        gl!(gl.framebuffer_texture_2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            resources.to_id,
            0
        ));
        expect(gl, "Error attaching texture to frame buffer")?;

        let vertices = random_vertices(0);

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

        let available_shading_rates = available_shading_rates(gl, 1)?;
        let translate =
            |draw_id: u32| -> GLenum { available_shading_rates[draw_id as usize % available_shading_rates.len()] };

        gl!(gl.shading_rate_ext(glw::GL_SHADING_RATE_1X1_PIXELS_EXT));
        expect(gl, "Error to set shadingRateEXT as default")?;

        gl!(gl.clear_color(0.0, 0.0, 0.0, 0.0));
        gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));

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

        // draw ID start from 1
        for draw_id in 1..TRIANGLE_COUNT {
            gl!(gl.uniform_1i(
                uniform_location(gl, program.program(), "shadingRate"),
                pack_shading_rate(translate(draw_id)) as GLint
            ));
            expect(gl, "Error set uniform shading Rate value")?;

            gl!(gl.uniform_1i(uniform_location(gl, program.program(), "drawID"), draw_id as GLint));
            expect(gl, "Error set uniform drawID value")?;

            gl!(gl.shading_rate_ext(translate(draw_id)));
            expect(gl, "Error set shading rate")?;
            gl!(gl.draw_arrays(glw::GL_TRIANGLES, (draw_id * 2) as GLint, 3));
            expect(gl, "Error draw a triangle")?;
        }

        let mut result_data = vec![0u32; (width * height * 4) as usize];
        gl!(gl.read_pixels(
            0,
            0,
            width as i32,
            height as i32,
            glw::GL_RGBA_INTEGER,
            glw::GL_UNSIGNED_INT,
            result_data.as_mut_ptr().cast()
        ));
        expect(gl, "Error reading pixels from frame buffer!")?;

        for y in 0..height {
            for x in 0..width {
                let sample = &result_data[((y * width + x) * 4) as usize..][..4];
                if sample[1] == 0 {
                    // nothing rendered
                    continue;
                }

                let shading_rate = sample[0];
                let draw_id = sample[1];

                if pack_shading_rate(translate(draw_id)) != shading_rate {
                    let message = format!(
                        "The draw ID is {draw_id}Shading Rate is{shading_rate}, But we expect {}",
                        pack_shading_rate(translate(draw_id))
                    );
                    return Ok(TestStatus::fail(message));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Basic {
    fn name(&self) -> &str {
        "basic"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_fragment_shading_rate_supported {
            return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
        }

        let mut resources = BasicResources::default();
        let outcome = self.run(context, &mut resources);
        Self::deinit(context.gl(), &base, &resources);
        outcome
    }
}

/// `FragmentShadingRateErrors`
pub(super) struct Errors {
    pub ext_params: ExtParameters,
}

/// `FragmentShadingRateErrors::verifyError`
fn verify_error(gl: &glw::Functions, expected_error: GLenum, description: &str) -> bool {
    let error_code = gl!(gl.get_error());
    if error_code != expected_error {
        log::info!("{description}");
        return false;
    }
    true
}

impl Errors {
    fn run(&self, context: &Context, base: &TestCaseBase) -> TestOutcome {
        let gl = context.gl();
        let mut test_passed = true;

        // INVALID_ENUM is generated by ShadingRateEXT if <rate> is not a valid shading rate from table
        gl!(gl.shading_rate_ext(glw::GL_SAMPLE_SHADING));
        test_passed = test_passed && verify_error(gl, glw::GL_INVALID_ENUM, "glShadingRateEXT <rate> is not valid");

        if base.is_fragment_shading_rate_attachment_supported {
            const BASE_LAYER: GLint = 0;
            const NUM_LAYER: i32 = 1;
            const TEXTURE_WIDTH: i32 = 256;
            const TEXTURE_HEIGHT: i32 = 256;
            const TEXEL_WIDTH: i32 = 16;
            const TEXEL_HEIGHT: i32 = 16;

            let mut fbo_id: GLuint = 0;
            gl!(gl.gen_framebuffers(1, &mut fbo_id));
            expect(gl, "Error setting up framebuffer objects")?;

            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_id));
            expect(gl, "Error binding frame buffer object!")?;

            let mut to_id: GLuint = 0;
            let mut mutable_to_id: GLuint = 0;
            gl!(gl.gen_textures(1, &mut to_id));
            expect(gl, "Error generating texture objects")?;

            gl!(gl.gen_textures(1, &mut mutable_to_id));
            expect(gl, "Error generating texture objects")?;

            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, to_id));
            expect(gl, "Error binding texture object!")?;
            gl!(gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_R8UI, TEXTURE_WIDTH, TEXTURE_HEIGHT));
            expect(gl, "Error allocating texture object!")?;

            gl!(gl.bind_texture(glw::GL_TEXTURE_2D, mutable_to_id));
            expect(gl, "Error binding texture object!")?;
            gl!(gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_R8 as GLint,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                0,
                glw::GL_RED,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null()
            ));
            expect(gl, "Error allocating texture object!")?;

            let query = |pname: GLenum, message: &str| -> Result<GLint, TestError> {
                let mut value: GLint = 0;
                gl!(gl.get_integerv(pname, &mut value));
                expect(gl, message)?;
                Ok(value)
            };
            let min_texel_width = query(
                glw::GL_MIN_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_WIDTH_EXT,
                "Error getIntegerv GL_MIN_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_WIDTH_EXT!",
            )?;
            let _max_texel_width = query(
                glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_WIDTH_EXT,
                "Error getIntegerv GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_WIDTH_EXT!",
            )?;
            let min_texel_height = query(
                glw::GL_MIN_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_HEIGHT_EXT,
                "Error getIntegerv GL_MIN_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_HEIGHT_EXT!",
            )?;
            let _max_texel_height = query(
                glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_HEIGHT_EXT,
                "Error getIntegerv GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_HEIGHT_EXT!",
            )?;
            let _max_attach_aspect_ratio = query(
                glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_ASPECT_RATIO_EXT,
                "Error getIntegerv GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_ASPECT_RATIO_EXT!",
            )?;
            let _max_attach_layer_count = query(
                glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS_EXT,
                "Error getIntegerv GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS_EXT!",
            )?;

            // An INVALID_ENUM error is generated if <target> is not DRAW_FRAMEBUFFER, READ_FRAMEBUFFER, or FRAMEBUFFER.
            gl!(gl.framebuffer_shading_rate_ext(
                glw::GL_RENDERBUFFER,
                glw::GL_SHADING_RATE_ATTACHMENT_EXT,
                to_id,
                BASE_LAYER,
                NUM_LAYER,
                TEXEL_WIDTH,
                TEXEL_HEIGHT
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "framebufferShadingRateEXT <target> is not valid",
                );

            // An INVALID_ENUM error is generated if <attachment> is not SHADING_RATE_ATTACHMENT_EXT.
            gl!(gl.framebuffer_shading_rate_ext(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                to_id,
                BASE_LAYER,
                NUM_LAYER,
                TEXEL_WIDTH,
                TEXEL_HEIGHT
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_ENUM,
                    "framebufferShadingRateEXT <attachment> is not valid",
                );

            // An INVALID_VALUE error is generated if <texture> is not zero and is not the name of an immutable texture object.
            gl!(gl.framebuffer_shading_rate_ext(
                glw::GL_FRAMEBUFFER,
                glw::GL_SHADING_RATE_ATTACHMENT_EXT,
                mutable_to_id,
                BASE_LAYER,
                NUM_LAYER,
                TEXEL_WIDTH,
                TEXEL_HEIGHT
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "framebufferShadingRateEXT <texture> is not valid",
                );

            // An INVALID_VALUE error is generated if <baseLayer> is greater than or equal to the value of MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS_EXT.
            gl!(gl.framebuffer_shading_rate_ext(
                glw::GL_FRAMEBUFFER,
                glw::GL_SHADING_RATE_ATTACHMENT_EXT,
                to_id,
                glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS_EXT as GLint,
                NUM_LAYER,
                TEXEL_WIDTH,
                TEXEL_HEIGHT
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "framebufferShadingRateEXT <baseLayer> is not valid",
                );

            // An INVALID_VALUE error is generated if <numLayers> is greater than the value of MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS_EXT.
            gl!(gl.framebuffer_shading_rate_ext(
                glw::GL_FRAMEBUFFER,
                glw::GL_SHADING_RATE_ATTACHMENT_EXT,
                to_id,
                0,
                (glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS_EXT + 1) as i32,
                TEXEL_WIDTH,
                TEXEL_HEIGHT
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "framebufferShadingRateEXT <numLayers> is not valid",
                );

            // An INVALID_VALUE error is generated if <texelWidth> / <texelHeight> is larger than MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_ASPECT_RATIO_EXT.
            gl!(gl.framebuffer_shading_rate_ext(
                glw::GL_FRAMEBUFFER,
                glw::GL_SHADING_RATE_ATTACHMENT_EXT,
                to_id,
                0,
                (glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS_EXT + 1) as i32,
                min_texel_width,
                min_texel_width
                    .wrapping_mul(glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_ASPECT_RATIO_EXT as i32)
                    .wrapping_shl(1)
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "framebufferShadingRateEXT <texelWidth, texelHeight> is not valid",
                );

            // An INVALID_VALUE error is generated if <texelHeight> / <texelWidth> is larger than MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_ASPECT_RATIO_EXT.
            gl!(gl.framebuffer_shading_rate_ext(
                glw::GL_FRAMEBUFFER,
                glw::GL_SHADING_RATE_ATTACHMENT_EXT,
                to_id,
                0,
                (glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_LAYERS_EXT + 1) as i32,
                min_texel_height
                    .wrapping_mul(glw::GL_MAX_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_ASPECT_RATIO_EXT as i32)
                    .wrapping_shl(1),
                min_texel_height
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_VALUE,
                    "framebufferShadingRateEXT <texelWidth, texelHeight> is not valid",
                );

            gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0));
            gl!(gl.delete_framebuffers(1, &fbo_id));
            gl!(gl.delete_textures(1, &to_id));
            gl!(gl.delete_textures(1, &mutable_to_id));
        }

        // An INVALID_ENUM error is generated if <combinerOp0> / <combinerOp1> is not one of the five combiner ops.
        gl!(gl.shading_rate_combiner_ops_ext(
            glw::GL_SHADING_RATE_EXT,
            glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_REPLACE_EXT
        ));
        test_passed = test_passed
            && verify_error(
                gl,
                glw::GL_INVALID_ENUM,
                "shadingRateCombinerOpsEXT <combinerOp0> is not valid",
            );
        gl!(gl.shading_rate_combiner_ops_ext(
            glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT,
            glw::GL_MIN_FRAGMENT_SHADING_RATE_ATTACHMENT_TEXEL_WIDTH_EXT
        ));
        test_passed = test_passed
            && verify_error(
                gl,
                glw::GL_INVALID_ENUM,
                "shadingRateCombinerOpsEXT <combinerOp1> is not valid",
            );

        let mut support_non_trivial_combiner: glw::GLboolean = 0;
        gl!(gl.get_booleanv(
            glw::GL_FRAGMENT_SHADING_RATE_NON_TRIVIAL_COMBINERS_SUPPORTED_EXT,
            &mut support_non_trivial_combiner
        ));
        expect(gl, "Error getBooleanv non trivial combiner")?;

        // An INVALID_OPERATION error is generated if the value of FRAGMENT_SHADING_RATE_NON_TRIVIAL_COMBINERS_SUPPORTED_EXT is FALSE and a combiner is not KEEP or REPLACE
        if support_non_trivial_combiner == 0 {
            gl!(gl.shading_rate_combiner_ops_ext(
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MIN_EXT,
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_KEEP_EXT
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "<combinerOp0> combiner is non trivial combiner",
                );

            gl!(gl.shading_rate_combiner_ops_ext(
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_REPLACE_EXT,
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MUL_EXT
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "<combinerOp1> combiner is non trivial combiner",
                );
        }

        // [[If GL_EXT_fragment_shading_rate_primitive is not supported]] an INVALID_OPERATION error is generated if <combinerOp0> is not KEEP
        if !base.is_fragment_shading_rate_primitive_supported {
            gl!(gl.shading_rate_combiner_ops_ext(
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MAX_EXT,
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_REPLACE_EXT
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "shadingRateCombinerOpsEXT <combinerOp0> is not valid",
                );
        }

        // [[If GL_EXT_fragment_shading_rate_attachment is not supported]] an INVALID_OPERATION error is generated if <combinerOp1> is not KEEP
        if !base.is_fragment_shading_rate_attachment_supported {
            gl!(gl.shading_rate_combiner_ops_ext(
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_MAX_EXT,
                glw::GL_FRAGMENT_SHADING_RATE_COMBINER_OP_REPLACE_EXT
            ));
            test_passed = test_passed
                && verify_error(
                    gl,
                    glw::GL_INVALID_OPERATION,
                    "shadingRateCombinerOpsEXT <combinerOp1> is not valid",
                );
        }

        Ok(if test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for Errors {
    fn name(&self) -> &str {
        "errors"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let base = TestCaseBase::init(context, self.ext_params);
        if !base.is_fragment_shading_rate_supported {
            return Err(not_supported(FRAGMENT_SHADING_RATE_NOT_SUPPORTED));
        }

        let outcome = self.run(context, &base);
        reset_shading_rate_state(context.gl(), &base);
        outcome
    }
}
