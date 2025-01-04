// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderBlitting.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The abstract `GeometryShaderBlitting` and its three subclasses are one struct with a `Kind` selecting `setUpFramebuffersForRendering`.

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const TEXTURE_DEPTH: i32 = 4;
const TEXTURE_WIDTH: i32 = 4;
const TEXTURE_HEIGHT: i32 = 4;
const TEXTURE_TEXEL_COMPONENTS: usize = 4;
const LAYER_BYTES: usize = (TEXTURE_WIDTH * TEXTURE_HEIGHT) as usize * TEXTURE_TEXEL_COMPONENTS;

#[derive(Clone, Copy)]
pub(super) enum Kind {
    LayeredToNonLayered,
    NonLayeredToLayered,
    LayeredToLayered,
}

/// `GeometryShaderBlitting`
pub(super) struct Blitting {
    pub ext_params: ExtParameters,
    pub kind: Kind,
}

#[derive(Default)]
struct Resources {
    fbo_draw_id: GLuint,
    fbo_read_id: GLuint,
    to_draw: GLuint,
    to_read: GLuint,
    vao_id: GLuint,
}

impl Blitting {
    /// `setUpFramebuffersForRendering`
    fn set_up_framebuffers_for_rendering(&self, gl: &glw::Functions, resources: &Resources) -> Result<(), TestError> {
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, resources.fbo_read_id));
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, resources.fbo_draw_id));

        let (read_layered, draw_layered) = match self.kind {
            Kind::LayeredToNonLayered => (true, false),
            Kind::NonLayeredToLayered => (false, true),
            Kind::LayeredToLayered => (true, true),
        };
        let attach = |target: u32, texture: GLuint, layered: bool| {
            if layered {
                gl!(gl.framebuffer_texture(target, glw::GL_COLOR_ATTACHMENT0, texture, 0));
            } else {
                gl!(gl.framebuffer_texture_layer(target, glw::GL_COLOR_ATTACHMENT0, texture, 0, 0));
            }
        };
        attach(glw::GL_READ_FRAMEBUFFER, resources.to_read, read_layered);
        attach(glw::GL_DRAW_FRAMEBUFFER, resources.to_draw, draw_layered);
        glu::expect_no_error(gl, "Error setting up FBOs setUpFramebuffersForRendering")
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        // Generate and bind a vertex array object
        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error setting up vertex array object")?;

        // Generate texture objects
        gl!(gl.gen_textures(1, &mut resources.to_draw));
        gl!(gl.gen_textures(1, &mut resources.to_read));
        glu::expect_no_error(gl, "Error generating texture objects")?;

        // Generate framebuffer objects
        gl!(gl.gen_framebuffers(1, &mut resources.fbo_draw_id));
        gl!(gl.gen_framebuffers(1, &mut resources.fbo_read_id));
        glu::expect_no_error(gl, "Error setting up framebuffer objects")?;

        // Configure texture storage
        for texture in [resources.to_draw, resources.to_read] {
            gl!(gl.bind_texture(glw::GL_TEXTURE_3D, texture));
            gl!(gl.tex_image_3d(
                glw::GL_TEXTURE_3D,
                0,
                glw::GL_RGBA8 as GLint,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                TEXTURE_DEPTH,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null()
            ));
            glu::expect_no_error(gl, "Error setting up texture objects")?;
        }

        let mut layer_sources = [[0u8; LAYER_BYTES]; 4];
        let layer_target = [0u8; LAYER_BYTES];
        for (component, source) in layer_sources.iter_mut().enumerate() {
            for n in 0..(TEXTURE_WIDTH * TEXTURE_HEIGHT) as usize {
                source[n * TEXTURE_TEXEL_COMPONENTS + component] = 255;
            }
        }

        // Set up draw FBO
        self.set_up_framebuffers_for_rendering(gl, resources)?;

        // Fill texture objects with data
        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, resources.to_read));
        for (layer, source) in layer_sources.iter().enumerate() {
            gl!(gl.tex_sub_image_3d(
                glw::GL_TEXTURE_3D,
                0,
                0,
                0,
                layer as GLint,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                source.as_ptr().cast()
            ));
        }
        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, resources.to_draw));
        for layer in 0..TEXTURE_DEPTH {
            gl!(gl.tex_sub_image_3d(
                glw::GL_TEXTURE_3D,
                0,
                0,
                0,
                layer,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                1,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                layer_target.as_ptr().cast()
            ));
        }

        // Check FB completeness
        let draw_fbo_completeness = gl!(gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER));
        let read_fbo_completeness = gl!(gl.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER));
        if draw_fbo_completeness != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail(
                "Draw framebuffer is reported as incomplete, though expected it to be complete".to_string(),
            ));
        }
        if read_fbo_completeness != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail(
                "Read framebuffer is reported as incomplete, though expected it to be complete".to_string(),
            ));
        }

        // Blit!
        gl!(gl.blit_framebuffer(
            0,
            0,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            0,
            0,
            TEXTURE_WIDTH,
            TEXTURE_HEIGHT,
            glw::GL_COLOR_BUFFER_BIT,
            glw::GL_NEAREST
        ));
        glu::expect_no_error(gl, "Error blitting")?;

        for n in 0..TEXTURE_DEPTH {
            let mut result_data = [0u8; LAYER_BYTES];
            let expected_result_data = if n == 0 { layer_sources[0] } else { [0u8; LAYER_BYTES] };

            // Set up read FBO
            gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, resources.fbo_draw_id));
            gl!(gl.framebuffer_texture_layer(
                glw::GL_READ_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                resources.to_draw,
                0,
                n
            ));
            glu::expect_no_error(gl, "Error setting up FBOs setUpFramebuffersForReading")?;

            // Read the rendered data
            gl!(gl.read_pixels(
                0,
                0,
                TEXTURE_WIDTH,
                TEXTURE_HEIGHT,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                result_data.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "Failed to read rendered pixel data")?;

            // Compare the rendered data with reference data
            for index in (0..LAYER_BYTES).step_by(TEXTURE_TEXEL_COMPONENTS) {
                let result = &result_data[index..index + TEXTURE_TEXEL_COMPONENTS];
                let expected = &expected_result_data[index..index + TEXTURE_TEXEL_COMPONENTS];
                if result != expected {
                    log::info!("Rendered data {result:?} is different from reference data {expected:?} !");
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Blitting {
    fn name(&self) -> &str {
        match self.kind {
            Kind::LayeredToNonLayered => "layered_nonlayered",
            Kind::NonLayeredToLayered => "nonlayered_layered",
            Kind::LayeredToLayered => "layered_layered",
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        gl!(gl.bind_texture(glw::GL_TEXTURE_3D, 0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0));
        gl!(gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0));
        for fbo in [resources.fbo_draw_id, resources.fbo_read_id] {
            if fbo != 0 {
                gl!(gl.delete_framebuffers(1, &fbo));
            }
        }
        for texture in [resources.to_draw, resources.to_read] {
            if texture != 0 {
                gl!(gl.delete_textures(1, &texture));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
