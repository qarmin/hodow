// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderFragDataTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's ES 3.0 file is its ES 2.0 file plus `FragDataDrawBuffersCase` and the one
// helper that case needs, so only those two are here and `FragDataIndexingCase` /
// `compare_single_color` come from `gles2::functional::shader_frag_data_tests`. The
// four negative cases come from `data/gles3/shaders/fragdata.test` through
// `gls::ShaderLibrary`, as they do for ES 2.0.

use crate::generated::shader_library as lib;
use crate::gles2::functional::shader_frag_data_tests::{FragDataIndexingCase, IndexExprType, compare_single_color};
use crate::gls::shader_library::add_group_children;
use crate::glu::{
    self, Context, Framebuffer, ProgramSources, Renderbuffer, ShaderProgram, TestCase, TestCaseGroup, pr, va,
};
use crate::glw;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Surface, TestError, TestOutcome, TestResult, TestStatus};

/// `FragDataDrawBuffersCase`
struct FragDataDrawBuffersCase;

impl TestCase for FragDataDrawBuffersCase {
    fn name(&self) -> &str {
        "draw_buffers"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();

        // `isExtensionSupported` - upstream walks `glGetStringi(GL_EXTENSIONS, i)` here;
        // `ContextInfo` already holds that list.
        let has_ext_draw_buffers = context.context_info.is_extension_supported("GL_EXT_draw_buffers");
        let has_nv_draw_buffers = context.context_info.is_extension_supported("GL_NV_draw_buffers");

        let num_test_attachment = if has_ext_draw_buffers || has_nv_draw_buffers {
            2
        } else {
            1
        };

        let extension_string = if has_ext_draw_buffers {
            "#extension GL_EXT_draw_buffers : require\n"
        } else if has_nv_draw_buffers {
            "#extension GL_NV_draw_buffers : require\n"
        } else {
            ""
        };

        let program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(
                concat!(
                    "attribute highp vec4 a_position;\n",
                    "attribute highp vec4 a_color;\n",
                    "varying mediump vec4 v_color;\n",
                    "void main (void)\n",
                    "{\n",
                    "    gl_Position = a_position;\n",
                    "    v_color = a_color;\n",
                    "}\n",
                ),
                format!(
                    concat!(
                        "{}",
                        "varying mediump vec4 v_color;\n",
                        "uniform mediump int u_index;\n",
                        "void main (void)\n",
                        "{{\n",
                        "    gl_FragData[u_index] = v_color;\n",
                        "}}\n",
                    ),
                    extension_string
                ),
            ),
        );

        const WIDTH: i32 = 128;
        const HEIGHT: i32 = 128;

        if !program.is_ok() {
            return Err(TestError::NotSupported(
                "Dynamic indexing of gl_FragData[] not supported".to_string(),
            ));
        }

        // SAFETY: the location of a uniform the linked program declares.
        let index_loc = unsafe { gl.get_uniform_location(program.program(), c"u_index".as_ptr()) };

        let fbo = Framebuffer::new(gl);
        let color_buf0 = Renderbuffer::new(gl);
        let color_buf1 = Renderbuffer::new(gl);

        const POSITIONS: [f32; 8] = [-1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0];
        const COLORS: [f32; 16] = [
            0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0,
        ];
        const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

        let vertex_arrays = [
            va::float("a_position", 2, 4, 0, &POSITIONS),
            va::float("a_color", 4, 4, 0, &COLORS),
        ];

        // SAFETY: a current context and names this case owns.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
            for ndx in 0..num_test_attachment {
                let rbo = if ndx == 0 { color_buf0.get() } else { color_buf1.get() };

                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, WIDTH, HEIGHT);
                #[expect(clippy::cast_sign_loss, reason = "the attachment index is 0 or 1")]
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0 + ndx as u32,
                    glw::GL_RENDERBUFFER,
                    rbo,
                );
            }
        }

        // SAFETY: a framebuffer is bound.
        if unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) } != glw::GL_FRAMEBUFFER_COMPLETE {
            return Err(TestError::Fail("Framebuffer is not complete".to_string()));
        }

        const DRAW_BUFFERS: [glw::GLenum; 2] = [glw::GL_COLOR_ATTACHMENT0, glw::GL_COLOR_ATTACHMENT1];
        // SAFETY: two attachments are named and both exist on the bound framebuffer.
        unsafe {
            gl.draw_buffers(2, DRAW_BUFFERS.as_ptr());

            gl.viewport(0, 0, WIDTH, HEIGHT);
            gl.use_program(program.program());
        }

        glu::expect_no_error(gl, "Setup failed")?;

        let mut all_ok = true;
        let threshold = render_ctx.render_target().pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);

        for ndx in 0..num_test_attachment {
            let red = RGBA::red().to_vec();
            // SAFETY: four floats for a colour buffer, and a uniform location the
            // program declares.
            unsafe {
                gl.clear_bufferfv(glw::GL_COLOR, 0, (&raw const red).cast::<f32>());
                gl.clear_bufferfv(glw::GL_COLOR, 1, (&raw const red).cast::<f32>());
            }

            log::info!("Drawing to attachments {ndx}");

            // SAFETY: as above.
            unsafe { gl.uniform_1i(index_loc, ndx) };
            glu::draw(render_ctx, program.program(), &vertex_arrays, &pr::triangles(&INDICES))?;

            glu::expect_no_error(gl, "Rendering failed")?;

            {
                let mut result = Surface::new(WIDTH, HEIGHT);

                log::info!("Verifying attachment {ndx}...");

                #[expect(clippy::cast_sign_loss, reason = "the attachment index is 0 or 1")]
                // SAFETY: the attachment exists on the bound framebuffer.
                unsafe {
                    gl.read_buffer(glw::GL_COLOR_ATTACHMENT0 + ndx as u32);
                }
                glu::read_pixels(render_ctx, 0, 0, &mut result.get_access())?;
                glu::expect_no_error(gl, "Reading pixels failed")?;

                if !compare_single_color(&result, RGBA::green(), threshold) {
                    all_ok = false;
                }
            }
        }

        Ok(if all_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::new(TestResult::Fail, "Image comparison failed")
        })
    }
}

/// `ShaderFragDataTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fragdata");
    group.add_child(Box::new(FragDataIndexingCase {
        name: "valid_static_index",
        index_expr_type: IndexExprType::Static,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FragDataIndexingCase {
        name: "valid_uniform_index",
        index_expr_type: IndexExprType::Uniform,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FragDataIndexingCase {
        name: "valid_dynamic_index",
        index_expr_type: IndexExprType::Dynamic,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FragDataDrawBuffersCase) as Box<dyn TestCase>);

    // Negative cases.
    add_group_children(&mut group, &lib::gles3_fragdata::ROOT);

    group
}
