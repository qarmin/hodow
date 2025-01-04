// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fMultiviewTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2018 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Every GL object this creates is a
// local variable, deleted explicitly before `iterate` returns on every path - there is
// no persistent per-case state across a call the way upstream's own `init`/`deinit`
// split implies. Upstream's own `NUM_CASE_ITERATIONS` is 1, so the `CONTINUE`/`STOP`
// loop it drives is not ported - this always returns after one pass, exactly like that
// loop's own only possible outcome.

use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, read_pixels};
use crate::glw::{self, GLint, GLuint};
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

const UNIT_SQUARE: [f32; 16] = [
    1.0, 1.0, 0.05, 1.0, // Vertex 0
    1.0, -1.0, 0.05, 1.0, // Vertex 1
    -1.0, 1.0, 0.05, 1.0, // Vertex 2
    -1.0, -1.0, 0.05, 1.0, // Vertex 3
];
const COLOR_VALUES: [f32; 8] = [
    1.0, 0.0, 0.0, 1.0, // Red for view 0
    0.0, 1.0, 0.0, 1.0, // Green for view 1
];

const MULTIVIEW_VERTEX_SOURCE: &str = concat!(
    "#version 300 es\n",
    "#extension GL_OVR_multiview : enable\n",
    "layout(num_views=2) in;\n",
    "layout(location = 0) in mediump vec4 a_position;\n",
    "uniform mediump vec4 uColor[2];\n",
    "out mediump vec4 vColor;\n",
    "void main() {\n",
    "  vColor = uColor[gl_ViewID_OVR];\n",
    "  gl_Position = a_position;\n",
    "}\n"
);

const MULTIVIEW_FRAGMENT_SOURCE: &str = concat!(
    "#version 300 es\n",
    "layout(location = 0) out mediump vec4 dEQP_FragColor;\n",
    "in mediump vec4 vColor;\n",
    "void main() {\n",
    "  dEQP_FragColor = vColor;\n",
    "}\n"
);

const FINAL_VERTEX_SOURCE: &str = concat!(
    "#version 300 es\n",
    "layout(location = 0) in mediump vec4 a_position;\n",
    "out highp vec3 vTexCoord;\n",
    "void main() {\n",
    "  vTexCoord.x = fract(a_position.x + 1.0);\n",
    "  vTexCoord.y = .5 * (a_position.y + 1.0);\n",
    "  vTexCoord.z = a_position.x;\n",
    "  gl_Position = a_position;\n",
    "}\n"
);

const FINAL_FRAGMENT_SOURCE: &str = concat!(
    "#version 300 es\n",
    "layout(location = 0) out mediump vec4 dEQP_FragColor;\n",
    "uniform lowp sampler2DArray uArrayTexture;\n",
    "in highp vec3 vTexCoord;\n",
    "void main() {\n",
    "  highp vec3 uvw = vTexCoord;\n",
    "  uvw.z = floor(vTexCoord.z + 1.0);\n",
    "  dEQP_FragColor = texture(uArrayTexture, uvw);\n",
    "}\n"
);

/// `MultiviewCase`
struct MultiviewCase {
    name: &'static str,
    num_samples: i32,
}

impl TestCase for MultiviewCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_info.is_extension_supported("GL_OVR_multiview") {
            return Err(TestError::NotSupported("Multiview is not supported".to_string()));
        }
        if self.num_samples > 1
            && !context
                .context_info
                .is_extension_supported("GL_OVR_multiview_multisampled_render_to_texture")
        {
            return Err(TestError::NotSupported(
                "Implicit MSAA multiview is not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const WIDTH: i32 = 512;
        const HEIGHT: i32 = 512;

        let gl = context.gl();

        let multiview_program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(MULTIVIEW_VERTEX_SOURCE, MULTIVIEW_FRAGMENT_SOURCE),
        );
        if !multiview_program.is_ok() {
            return Err(TestError::Fail("Failed to compile multiview shader".to_string()));
        }
        let final_program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(FINAL_VERTEX_SOURCE, FINAL_FRAGMENT_SOURCE),
        );
        if !final_program.is_ok() {
            return Err(TestError::Fail("Failed to compile final shader".to_string()));
        }

        let mut array_texture: GLuint = 0;
        let mut multiview_fbo: GLuint = 0;

        // `setupFramebufferObjects` - creates the array texture and multiview FBO.
        // SAFETY: both objects are created here; every path below deletes them again
        // before this function returns.
        let setup_result: Result<(), TestError> = unsafe {
            gl.gen_textures(1, &mut array_texture);
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, array_texture);
            gl.tex_storage_3d(glw::GL_TEXTURE_2D_ARRAY, 1, glw::GL_RGBA8, WIDTH / 2, HEIGHT, 2);
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MIN_FILTER,
                glw::GL_NEAREST as GLint,
            );
            gl.tex_parameteri(
                glw::GL_TEXTURE_2D_ARRAY,
                glw::GL_TEXTURE_MAG_FILTER,
                glw::GL_NEAREST as GLint,
            );

            gl.gen_framebuffers(1, &mut multiview_fbo);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, multiview_fbo);
            if self.num_samples == 1 {
                gl.framebuffer_texture_multiview_ovr(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    array_texture,
                    0,
                    0,
                    2,
                );
            } else {
                gl.framebuffer_texture_multisample_multiview_ovr(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    array_texture,
                    0,
                    self.num_samples,
                    0,
                    2,
                );
            }

            let status = gl.check_framebuffer_status(glw::GL_FRAMEBUFFER);
            if status == glw::GL_FRAMEBUFFER_UNSUPPORTED {
                Err(TestError::NotSupported("Framebuffer unsupported".to_string()))
            } else if status != glw::GL_FRAMEBUFFER_COMPLETE {
                Err(TestError::Fail("Failed to create framebuffer object".to_string()))
            } else {
                Ok(())
            }
        };

        if let Err(err) = setup_result {
            // SAFETY: deleting exactly the two objects created just above.
            unsafe {
                gl.delete_textures(1, &array_texture);
                gl.delete_framebuffers(1, &multiview_fbo);
            }
            return Err(err);
        }

        // Draw a full-screen quad into the multiview framebuffer; it is instanced into
        // both layers of the array texture.
        // SAFETY: `multiview_program` was just built successfully and `multiview_fbo`
        // is complete.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, multiview_fbo);
            gl.viewport(0, 0, WIDTH / 2, HEIGHT);
            gl.use_program(multiview_program.program());
            let color_uniform = gl.get_uniform_location(multiview_program.program(), c"uColor".as_ptr());
            gl.uniform_4fv(color_uniform, 2, COLOR_VALUES.as_ptr());
            gl.enable_vertex_attrib_array(0);
            gl.vertex_attrib_pointer(
                0,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                UNIT_SQUARE.as_ptr().cast(),
            );
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
        }

        // Sample from the array texture to draw a quad into the backbuffer.
        let render_target = context.render_target();
        let backbuffer_width = render_target.width;
        let backbuffer_height = render_target.height;

        // SAFETY: `final_program` was just built successfully and `array_texture`
        // holds the two layers just rendered above.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.viewport(0, 0, backbuffer_width, backbuffer_height);
            gl.use_program(final_program.program());
            gl.bind_texture(glw::GL_TEXTURE_2D_ARRAY, array_texture);
            gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
        }

        let mut pixels = Surface::new(backbuffer_width, backbuffer_height);
        read_pixels(&context.render_context, 0, 0, &mut pixels.get_access())?;

        // SAFETY: deleting exactly the two objects created above.
        unsafe {
            gl.delete_textures(1, &array_texture);
            gl.delete_framebuffers(1, &multiview_fbo);
        }

        // Left half of the screen must be red (view 0), right half green (view 1); the
        // exact middle column is untested, matching upstream's own `x > width/2` check.
        let mut failed = false;
        for y in 0..backbuffer_height {
            for x in 0..backbuffer_width {
                let pixel = pixels.get_pixel(x, y);
                if x < backbuffer_width / 2 {
                    if pixel.get_red() != 255 || pixel.get_green() != 0 || pixel.get_blue() != 0 {
                        failed = true;
                    }
                } else if x > backbuffer_width / 2
                    && (pixel.get_red() != 0 || pixel.get_green() != 255 || pixel.get_blue() != 0)
                {
                    failed = true;
                }
                if failed {
                    break;
                }
            }
        }

        if failed {
            Ok(TestStatus::fail("Fail"))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `MultiviewTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multiview");
    group.add_child(Box::new(MultiviewCase {
        name: "samples_1",
        num_samples: 1,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(MultiviewCase {
        name: "samples_2",
        num_samples: 2,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(MultiviewCase {
        name: "samples_4",
        num_samples: 4,
    }) as Box<dyn TestCase>);
    group
}
