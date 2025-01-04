// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fRasterizerDiscardTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NUM_CASE_ITERATIONS is 1 upstream,
// so the CONTINUE/STOP loop collapses into a single pass here; the program upstream
// builds in `init` is built at the top of `iterate`, because a `TestCase` here is
// immutable and has no `init` phase. The three sub-groups are one flat table with a
// `group` field rather than three separate `init` blocks.

use std::ffi::CString;

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::random::de_string_hash;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

const FAIL_COLOR_RED: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
const PASS_COLOR_BLUE: [f32; 4] = [0.0, 0.0, 0.5, 1.0];
const BLACK_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const FAIL_DEPTH: f32 = 0.0;
const FAIL_STENCIL: i32 = 1;

#[rustfmt::skip]
const UNIT_SQUARE: [f32; 16] = [
     1.0,  1.0, 0.05, 1.0,
     1.0, -1.0, 0.05, 1.0,
    -1.0,  1.0, 0.05, 1.0,
    -1.0, -1.0, 0.05, 1.0,
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseType {
    WriteDepth,
    WriteStencil,
    ClearColor,
    ClearDepth,
    ClearStencil,
}

const CASEOPTION_FBO: u32 = 1 << 0;
const CASEOPTION_SCISSOR: u32 = 1 << 1;

/// `generateVertices`
fn generate_vertices(dst: &mut Vec<f32>, num_primitives: i32, rnd: &mut Random, draw_mode: u32) {
    let num_vertices = match draw_mode {
        glw::GL_POINTS => num_primitives,
        glw::GL_LINES => 2 * num_primitives,
        glw::GL_LINE_STRIP => num_primitives + 1,
        glw::GL_LINE_LOOP => num_primitives + 2,
        glw::GL_TRIANGLES => 3 * num_primitives,
        glw::GL_TRIANGLE_STRIP => num_primitives + 2,
        glw::GL_TRIANGLE_FAN => num_primitives + 2,
        _ => {
            debug_assert!(false, "unknown draw mode");
            0
        }
    };

    dst.clear();
    dst.resize(num_vertices as usize * 4, 0.0);

    for i in 0..num_vertices as usize {
        dst[i * 4] = rnd.get_float_range(-1.0, 1.0);
        dst[i * 4 + 1] = rnd.get_float_range(-1.0, 1.0);
        dst[i * 4 + 2] = rnd.get_float_range(0.1, 0.9);
        dst[i * 4 + 3] = 1.0;
    }
}

/// The three FBO handles `setupFramebufferObject` creates, in one bundle so that
/// `deleteFramebufferObject` can be a single call on the error paths too.
struct Fbo {
    fbo: u32,
    color_buf: u32,
    depth_stencil_buf: u32,
}

impl Fbo {
    /// `RasterizerDiscardCase::setupFramebufferObject`
    fn setup(context: &Context) -> Result<Self, TestError> {
        let gl = context.gl();
        let render_target = context.render_target();
        let width = render_target.width;
        let height = render_target.height;

        let mut this = Self {
            fbo: 0,
            color_buf: 0,
            depth_stencil_buf: 0,
        };

        // SAFETY: all three handles are live u32s.
        let fbo_status = unsafe {
            gl.gen_framebuffers(1, &raw mut this.fbo);
            gl.gen_textures(1, &raw mut this.color_buf);
            gl.gen_renderbuffers(1, &raw mut this.depth_stencil_buf);

            gl.bind_texture(glw::GL_TEXTURE_2D, this.color_buf);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
            gl.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                glw::GL_RGBA8 as i32,
                width,
                height,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                std::ptr::null(),
            );

            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, this.depth_stencil_buf);
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, width, height);

            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, this.fbo);
            gl.framebuffer_texture_2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                this.color_buf,
                0,
            );
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_DEPTH_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                this.depth_stencil_buf,
            );
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_STENCIL_ATTACHMENT,
                glw::GL_RENDERBUFFER,
                this.depth_stencil_buf,
            );

            gl.check_framebuffer_status(glw::GL_FRAMEBUFFER)
        };

        if fbo_status == glw::GL_FRAMEBUFFER_UNSUPPORTED {
            this.delete(context);
            return Err(TestError::NotSupported("Framebuffer unsupported".to_string()));
        } else if fbo_status != glw::GL_FRAMEBUFFER_COMPLETE {
            this.delete(context);
            return Err(TestError::Fail("Failed to create framebuffer object".to_string()));
        }

        Ok(this)
    }

    /// `RasterizerDiscardCase::deleteFramebufferObject`
    fn delete(&self, context: &Context) {
        let gl = context.gl();
        // SAFETY: deleting the handles created above; 0 is silently ignored by GL.
        unsafe {
            gl.delete_textures(1, &raw const self.color_buf);
            gl.delete_renderbuffers(1, &raw const self.depth_stencil_buf);
            gl.delete_framebuffers(1, &raw const self.fbo);
        }
    }
}

#[derive(Clone, Copy)]
struct RasterizerDiscardCase {
    group: &'static str,
    name: &'static str,
    num_primitives: i32,
    case_type: CaseType,
    case_options: u32,
    draw_mode: u32,
}

impl TestCase for RasterizerDiscardCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();

        let program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(
                concat!(
                    "#version 300 es\n",
                    "layout(location = 0) in mediump vec4 a_position;\n",
                    "\n",
                    "void main (void)\n",
                    "{\n",
                    "    gl_Position = a_position;\n",
                    "}\n"
                ),
                concat!(
                    "#version 300 es\n",
                    "layout(location = 0) out mediump vec4 dEQP_FragColor;\n",
                    "uniform mediump vec4 u_color;\n",
                    "\n",
                    "void main (void)\n",
                    "{\n",
                    "    mediump float depth_gradient = gl_FragCoord.z;\n",
                    "    mediump float bias = 0.1;\n",
                    "    dEQP_FragColor = vec4(u_color.xyz * (depth_gradient + bias), 1.0);\n",
                    "}\n"
                ),
            ),
        );

        if !program.is_ok() {
            return Err(TestError::Fail("Failed to compile shader program".to_string()));
        }

        let color_name = CString::new("u_color").expect("literal has no nul");
        // SAFETY: valid program, nul-terminated name.
        let color_unif = unsafe { gl.get_uniform_location(program.program(), color_name.as_ptr()) };

        let mut rnd = Random::new(de_string_hash(self.name));
        let mut vertices: Vec<f32> = Vec::new();

        let fbo = if self.case_options & CASEOPTION_FBO != 0 {
            Some(Fbo::setup(context)?)
        } else {
            None
        };

        if self.case_options & CASEOPTION_SCISSOR != 0 {
            // SAFETY: plain state setup on the current context.
            unsafe {
                gl.enable(glw::GL_SCISSOR_TEST);
                gl.scissor(0, 0, render_target.width, render_target.height);
            }
        }

        // SAFETY: plain state setup and one client-array draw on the current context.
        unsafe {
            gl.use_program(program.program());

            gl.enable(glw::GL_DEPTH_TEST);
            gl.depth_rangef(0.0, 1.0);
            gl.depth_func(glw::GL_LEQUAL);

            gl.enable(glw::GL_STENCIL_TEST);
            gl.stencil_func(glw::GL_NOTEQUAL, 1, 0xFF);
            gl.stencil_op(glw::GL_REPLACE, glw::GL_KEEP, glw::GL_KEEP);

            gl.clear_color(
                PASS_COLOR_BLUE[0],
                PASS_COLOR_BLUE[1],
                PASS_COLOR_BLUE[2],
                PASS_COLOR_BLUE[3],
            );
            gl.clear_depthf(1.0);
            gl.clear_stencil(0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

            gl.enable_vertex_attrib_array(0);
            generate_vertices(&mut vertices, self.num_primitives, &mut rnd, self.draw_mode);
            gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, vertices.as_ptr().cast());

            // Clear color to black for depth and stencil clear cases.
            if self.case_type == CaseType::ClearDepth || self.case_type == CaseType::ClearStencil {
                gl.clear_color(BLACK_COLOR[0], BLACK_COLOR[1], BLACK_COLOR[2], BLACK_COLOR[3]);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            // Set fail values for color, depth and stencil.
            gl.uniform_4f(
                color_unif,
                FAIL_COLOR_RED[0],
                FAIL_COLOR_RED[1],
                FAIL_COLOR_RED[2],
                FAIL_COLOR_RED[3],
            );
            gl.clear_color(
                FAIL_COLOR_RED[0],
                FAIL_COLOR_RED[1],
                FAIL_COLOR_RED[2],
                FAIL_COLOR_RED[3],
            );
            gl.clear_depthf(FAIL_DEPTH);
            gl.clear_stencil(FAIL_STENCIL);

            gl.enable(glw::GL_RASTERIZER_DISCARD);
        }
        glu::expect_no_error(gl, "Rasterizer discard enabled")?;

        let vertex_count = vertices.len() as i32 / 4;
        let uses_fbo = self.case_options & CASEOPTION_FBO != 0;

        // SAFETY: the to-be-discarded draws and clears.
        unsafe {
            match self.case_type {
                CaseType::WriteDepth | CaseType::WriteStencil => {
                    gl.draw_arrays(self.draw_mode, 0, vertex_count);
                }
                CaseType::ClearColor => {
                    if uses_fbo {
                        gl.clear_bufferfv(glw::GL_COLOR, 0, FAIL_COLOR_RED.as_ptr());
                    } else {
                        gl.clear(glw::GL_COLOR_BUFFER_BIT);
                    }
                }
                CaseType::ClearDepth => {
                    if uses_fbo {
                        let depth = [FAIL_DEPTH];
                        gl.clear_bufferfv(glw::GL_DEPTH, 0, depth.as_ptr());
                    } else {
                        gl.clear(glw::GL_DEPTH_BUFFER_BIT);
                    }
                }
                CaseType::ClearStencil => {
                    if uses_fbo {
                        let stencil = [FAIL_STENCIL];
                        gl.clear_bufferiv(glw::GL_STENCIL, 0, stencil.as_ptr());
                    } else {
                        gl.clear(glw::GL_STENCIL_BUFFER_BIT);
                    }
                }
            }

            gl.disable(glw::GL_RASTERIZER_DISCARD);
        }
        glu::expect_no_error(gl, "Rasterizer discard disabled")?;

        // SAFETY: the pass-indicating draws, then a flush.
        unsafe {
            if self.case_type == CaseType::WriteStencil {
                if uses_fbo || render_target.stencil_bits > 0 {
                    // Draw a full-screen square that colors all pixels red if they have stencil value 1.
                    gl.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, glw::FALSE, 0, UNIT_SQUARE.as_ptr().cast());
                    gl.stencil_func(glw::GL_EQUAL, 1, 0xFF);
                    gl.draw_arrays(glw::GL_TRIANGLE_STRIP, 0, 4);
                }
                // \note If no stencil buffers are present and test is rendering to
                // default framebuffer, test will always pass.
            } else if self.case_type == CaseType::ClearDepth || self.case_type == CaseType::ClearStencil {
                gl.uniform_4f(
                    color_unif,
                    PASS_COLOR_BLUE[0],
                    PASS_COLOR_BLUE[1],
                    PASS_COLOR_BLUE[2],
                    PASS_COLOR_BLUE[3],
                );
                gl.draw_arrays(self.draw_mode, 0, vertex_count);
            }

            gl.finish();
            gl.disable(glw::GL_STENCIL_TEST);
            gl.disable(glw::GL_DEPTH_TEST);
            gl.disable(glw::GL_SCISSOR_TEST);
        }

        let mut pixels = Surface::new(render_target.width, render_target.height);
        let read = glu::read_pixels(&context.render_context, 0, 0, &mut pixels.get_access());

        let mut pass_color_found = false;
        let mut fail_color_found = false;
        'outer: for y in 0..pixels.get_height() {
            for x in 0..pixels.get_width() {
                if pixels.get_pixel(x, y).get_blue() != 0 {
                    pass_color_found = true;
                }
                if pixels.get_pixel(x, y).get_red() != 0 {
                    fail_color_found = true;
                    break 'outer;
                }
            }
        }

        if let Some(fbo) = &fbo {
            fbo.delete(context);
        }
        read?;

        if !(pass_color_found && !fail_color_found) {
            return Err(TestError::Fail(
                "Primitive or buffer clear was not discarded".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

#[rustfmt::skip]
const CASES: &[RasterizerDiscardCase] = &[
    RasterizerDiscardCase { group: "basic", name: "write_depth_points", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: 0, draw_mode: glw::GL_POINTS },
    RasterizerDiscardCase { group: "basic", name: "write_depth_lines", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: 0, draw_mode: glw::GL_LINES },
    RasterizerDiscardCase { group: "basic", name: "write_depth_line_strip", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: 0, draw_mode: glw::GL_LINE_STRIP },
    RasterizerDiscardCase { group: "basic", name: "write_depth_line_loop", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: 0, draw_mode: glw::GL_LINE_LOOP },
    RasterizerDiscardCase { group: "basic", name: "write_depth_triangles", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: 0, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "basic", name: "write_depth_triangle_strip", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: 0, draw_mode: glw::GL_TRIANGLE_STRIP },
    RasterizerDiscardCase { group: "basic", name: "write_depth_triangle_fan", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: 0, draw_mode: glw::GL_TRIANGLE_FAN },
    RasterizerDiscardCase { group: "basic", name: "write_stencil_points", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: 0, draw_mode: glw::GL_POINTS },
    RasterizerDiscardCase { group: "basic", name: "write_stencil_lines", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: 0, draw_mode: glw::GL_LINES },
    RasterizerDiscardCase { group: "basic", name: "write_stencil_line_strip", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: 0, draw_mode: glw::GL_LINE_STRIP },
    RasterizerDiscardCase { group: "basic", name: "write_stencil_line_loop", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: 0, draw_mode: glw::GL_LINE_LOOP },
    RasterizerDiscardCase { group: "basic", name: "write_stencil_triangles", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: 0, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "basic", name: "write_stencil_triangle_strip", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: 0, draw_mode: glw::GL_TRIANGLE_STRIP },
    RasterizerDiscardCase { group: "basic", name: "write_stencil_triangle_fan", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: 0, draw_mode: glw::GL_TRIANGLE_FAN },
    RasterizerDiscardCase { group: "basic", name: "clear_color", num_primitives: 4, case_type: CaseType::ClearColor, case_options: 0, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "basic", name: "clear_depth", num_primitives: 4, case_type: CaseType::ClearDepth, case_options: 0, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "basic", name: "clear_stencil", num_primitives: 4, case_type: CaseType::ClearStencil, case_options: 0, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "scissor", name: "write_depth_points", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_POINTS },
    RasterizerDiscardCase { group: "scissor", name: "write_depth_lines", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_LINES },
    RasterizerDiscardCase { group: "scissor", name: "write_depth_line_strip", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_LINE_STRIP },
    RasterizerDiscardCase { group: "scissor", name: "write_depth_line_loop", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_LINE_LOOP },
    RasterizerDiscardCase { group: "scissor", name: "write_depth_triangles", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "scissor", name: "write_depth_triangle_strip", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_TRIANGLE_STRIP },
    RasterizerDiscardCase { group: "scissor", name: "write_depth_triangle_fan", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_TRIANGLE_FAN },
    RasterizerDiscardCase { group: "scissor", name: "write_stencil_points", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_POINTS },
    RasterizerDiscardCase { group: "scissor", name: "write_stencil_lines", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_LINES },
    RasterizerDiscardCase { group: "scissor", name: "write_stencil_line_strip", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_LINE_STRIP },
    RasterizerDiscardCase { group: "scissor", name: "write_stencil_line_loop", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_LINE_LOOP },
    RasterizerDiscardCase { group: "scissor", name: "write_stencil_triangles", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "scissor", name: "write_stencil_triangle_strip", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_TRIANGLE_STRIP },
    RasterizerDiscardCase { group: "scissor", name: "write_stencil_triangle_fan", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_TRIANGLE_FAN },
    RasterizerDiscardCase { group: "scissor", name: "clear_color", num_primitives: 4, case_type: CaseType::ClearColor, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "scissor", name: "clear_depth", num_primitives: 4, case_type: CaseType::ClearDepth, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "scissor", name: "clear_stencil", num_primitives: 4, case_type: CaseType::ClearStencil, case_options: CASEOPTION_SCISSOR, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "fbo", name: "write_depth_points", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_FBO, draw_mode: glw::GL_POINTS },
    RasterizerDiscardCase { group: "fbo", name: "write_depth_lines", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_FBO, draw_mode: glw::GL_LINES },
    RasterizerDiscardCase { group: "fbo", name: "write_depth_line_strip", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_FBO, draw_mode: glw::GL_LINE_STRIP },
    RasterizerDiscardCase { group: "fbo", name: "write_depth_line_loop", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_FBO, draw_mode: glw::GL_LINE_LOOP },
    RasterizerDiscardCase { group: "fbo", name: "write_depth_triangles", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_FBO, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "fbo", name: "write_depth_triangle_strip", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_FBO, draw_mode: glw::GL_TRIANGLE_STRIP },
    RasterizerDiscardCase { group: "fbo", name: "write_depth_triangle_fan", num_primitives: 4, case_type: CaseType::WriteDepth, case_options: CASEOPTION_FBO, draw_mode: glw::GL_TRIANGLE_FAN },
    RasterizerDiscardCase { group: "fbo", name: "write_stencil_points", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_FBO, draw_mode: glw::GL_POINTS },
    RasterizerDiscardCase { group: "fbo", name: "write_stencil_lines", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_FBO, draw_mode: glw::GL_LINES },
    RasterizerDiscardCase { group: "fbo", name: "write_stencil_line_strip", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_FBO, draw_mode: glw::GL_LINE_STRIP },
    RasterizerDiscardCase { group: "fbo", name: "write_stencil_line_loop", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_FBO, draw_mode: glw::GL_LINE_LOOP },
    RasterizerDiscardCase { group: "fbo", name: "write_stencil_triangles", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_FBO, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "fbo", name: "write_stencil_triangle_strip", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_FBO, draw_mode: glw::GL_TRIANGLE_STRIP },
    RasterizerDiscardCase { group: "fbo", name: "write_stencil_triangle_fan", num_primitives: 4, case_type: CaseType::WriteStencil, case_options: CASEOPTION_FBO, draw_mode: glw::GL_TRIANGLE_FAN },
    RasterizerDiscardCase { group: "fbo", name: "clear_color", num_primitives: 4, case_type: CaseType::ClearColor, case_options: CASEOPTION_FBO, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "fbo", name: "clear_depth", num_primitives: 4, case_type: CaseType::ClearDepth, case_options: CASEOPTION_FBO, draw_mode: glw::GL_TRIANGLES },
    RasterizerDiscardCase { group: "fbo", name: "clear_stencil", num_primitives: 4, case_type: CaseType::ClearStencil, case_options: CASEOPTION_FBO, draw_mode: glw::GL_TRIANGLES },
];

/// `RasterizerDiscardTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("rasterizer_discard");
    for sub in ["basic", "scissor", "fbo"] {
        let mut sub_group = TestCaseGroup::new(sub);
        for case in CASES.iter().filter(|c| c.group == sub) {
            sub_group.add_child(Box::new(*case) as Box<dyn TestCase>);
        }
        group.add_child(sub_group);
    }
    group
}
