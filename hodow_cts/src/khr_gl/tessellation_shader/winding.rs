// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderWinding.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. PRIMITIVE_TYPE and WINDING are substituted into the evaluation shader before it is specialized (the specialization map of `TestCaseBase` is not extensible).

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const RENDER_SIZE: GLint = 64;

/// `WindingCase`
pub(super) struct WindingCase {
    pub ext_params: ExtParameters,
    pub name: &'static str,
    pub primitive_type: &'static str,
    pub winding: &'static str,
}

#[derive(Default)]
struct Resources {
    po_id: GLuint,
    shaders: [GLuint; 4],
    rbo: GLuint,
    fbo: GLuint,
    vao: GLuint,
}

impl WindingCase {
    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        let vs = "${VERSION}\nvoid main (void)\n{\n}\n";
        let tcs = "${VERSION}\n${TESSELLATION_SHADER_REQUIRE}\nlayout (vertices = 1) out;\nvoid main (void)\n{\n    gl_TessLevelInner[0] = 5.0;\n    gl_TessLevelInner[1] = 5.0;\n\n    gl_TessLevelOuter[0] = 5.0;\n    gl_TessLevelOuter[1] = 5.0;\n    gl_TessLevelOuter[2] = 5.0;\n    gl_TessLevelOuter[3] = 5.0;\n}\n";
        let tes = "${VERSION}\n${TESSELLATION_SHADER_REQUIRE}\nlayout (${PRIMITIVE_TYPE}, ${WINDING}) in;\nvoid main (void)\n{\n    gl_Position = vec4(gl_TessCoord.xy*2.0 - 1.0, 0.0, 1.0);\n}\n"
            .replace("${PRIMITIVE_TYPE}", self.primitive_type)
            .replace("${WINDING}", self.winding);
        let fs = "${VERSION}\nlayout (location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    o_color = vec4(1.0);\n}\n";

        resources.po_id = gl!(gl.create_program());
        resources.shaders = [
            gl!(gl.create_shader(glw::GL_VERTEX_SHADER)),
            gl!(gl.create_shader(base.gl_ext_tokens.tess_control_shader)),
            gl!(gl.create_shader(base.gl_ext_tokens.tess_evaluation_shader)),
            gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER)),
        ];
        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.shaders[0], &[vs]),
                ShaderBody::Source(resources.shaders[1], &[tcs]),
                ShaderBody::Source(resources.shaders[2], &[tes.as_str()]),
                ShaderBody::Source(resources.shaders[3], &[fs]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail("Program compilation failed".to_string()));
        }

        let windings = [glw::GL_CW, glw::GL_CCW];
        let winding_names = ["GL_CW", "GL_CCW"];

        let test_primitive_type_is_triangles = self.primitive_type == "triangles";
        let test_winding_is_cw = self.winding == "cw";
        let mut success = true;

        // prepareFramebuffer
        gl!(gl.gen_renderbuffers(1, &mut resources.rbo));
        glu::expect_no_error(gl, "glGenRenderbuffers call failed.")?;
        gl!(gl.bind_renderbuffer(glw::GL_RENDERBUFFER, resources.rbo));
        glu::expect_no_error(gl, "glBindRenderbuffer call failed.")?;
        gl!(gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, RENDER_SIZE, RENDER_SIZE));
        glu::expect_no_error(gl, "glRenderbufferStorage call failed.")?;
        gl!(gl.gen_framebuffers(1, &mut resources.fbo));
        glu::expect_no_error(gl, "glGenFramebuffers call failed.")?;
        gl!(gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resources.fbo));
        glu::expect_no_error(gl, "glBindFramebuffer call failed.")?;
        gl!(gl.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            resources.rbo
        ));
        glu::expect_no_error(gl, "glFramebufferRenderbuffer call failed.")?;

        gl!(gl.viewport(0, 0, RENDER_SIZE, RENDER_SIZE));
        gl!(gl.clear_color(1.0, 0.0, 0.0, 1.0));
        gl!(gl.use_program(resources.po_id));
        gl!(gl.patch_parameteri(glw::GL_PATCH_VERTICES, 1));
        gl!(gl.enable(glw::GL_CULL_FACE));

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao));
        gl!(gl.bind_vertex_array(resources.vao));

        log::info!("Face culling enabled");

        for winding_index in 0..2 {
            log::info!("Setting glFrontFace({})", winding_names[winding_index]);

            gl!(gl.front_face(windings[winding_index]));
            gl!(gl.clear(glw::GL_COLOR_BUFFER_BIT));
            gl!(gl.draw_arrays(glw::GL_PATCHES, 0, 1));
            glu::expect_no_error(gl, "Draw failed")?;

            let mut rendered = vec![0u8; (RENDER_SIZE * RENDER_SIZE * 4) as usize];
            gl!(gl.read_pixels(
                0,
                0,
                RENDER_SIZE,
                RENDER_SIZE,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                rendered.as_mut_ptr().cast()
            ));
            glu::expect_no_error(gl, "glReadPixels() failed")?;

            let bad_pixel_tolerance = if test_primitive_type_is_triangles {
                5 * RENDER_SIZE
            } else {
                0
            };
            let total_num_pixels = RENDER_SIZE * RENDER_SIZE;

            let mut num_white_pixels = 0;
            let mut num_red_pixels = 0;
            for pixel in rendered.chunks_exact(4) {
                if pixel == [255, 255, 255, 255] {
                    num_white_pixels += 1;
                }
                if pixel == [255, 0, 0, 255] {
                    num_red_pixels += 1;
                }
            }

            log::info!("Note: got {num_white_pixels} white and {num_red_pixels} red pixels");

            if total_num_pixels - num_white_pixels - num_red_pixels > bad_pixel_tolerance {
                log::info!(
                    "Failure: Got {} other than white or red pixels (maximum tolerance {bad_pixel_tolerance})",
                    total_num_pixels - num_white_pixels - num_red_pixels
                );
                success = false;
                break;
            }

            let front_face_winding_is_cw = winding_index == 0;
            if front_face_winding_is_cw == test_winding_is_cw {
                if test_primitive_type_is_triangles {
                    if (num_white_pixels - total_num_pixels / 2).abs() > bad_pixel_tolerance {
                        log::info!(
                            "Failure: wrong number of white pixels; expected approximately {}",
                            total_num_pixels / 2
                        );
                        success = false;
                        break;
                    }
                } else if num_white_pixels != total_num_pixels {
                    log::info!("Failure: expected only white pixels (full-viewport quad)");
                    success = false;
                    break;
                }
            } else if num_white_pixels != 0 {
                log::info!("Failure: expected only red pixels (everything culled)");
                success = false;
                break;
            }
        }

        gl!(gl.bind_vertex_array(0));
        gl!(gl.delete_vertex_arrays(1, &resources.vao));
        resources.vao = 0;

        Ok(if success {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Image verification failed")
        })
    }
}

impl TestCase for WindingCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        if resources.fbo != 0 {
            gl!(gl.delete_framebuffers(1, &resources.fbo));
        }
        if resources.rbo != 0 {
            gl!(gl.delete_renderbuffers(1, &resources.rbo));
        }
        if resources.vao != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao));
        }
        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in resources.shaders {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        outcome
    }
}
