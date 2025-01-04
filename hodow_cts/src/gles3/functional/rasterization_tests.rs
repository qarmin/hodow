// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fRasterizationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, **all 108 of `dEQP-GLES3.functional.
// rasterization.*`** - `primitives.*`, `fill_rules.*`, `culling.*`,
// `interpolation.{basic,projected}.*`, `flatshading.*` on the default framebuffer, and
// the whole `fbo.*` sub-tree (see `FboTarget`'s own doc comment) repeating a narrower
// `primitives`/`fill_rules`/`interpolation` against a renderbuffer or texture colour
// attachment (single- or multi-sample) instead of the default framebuffer, via
// `RenderHarness`'s own `FboTarget`-parameterized constructor. `LineInterpolationTest`
// reuses the same upstream class for both `interpolation.*` and `flatshading`'s line
// cases, gated by `m_flatshade`, exactly like `TriangleInterpolationCase` already was.
// Upstream's ES3 file additionally has `limits.*` (ES3 has no `limits` group at all -
// confirmed by reading the file, `limits.points` is ES2-only).
//
// The ES2 and ES3 `TrianglesCase`/`TriangleStripCase`/`TriangleFanCase`/`FillRuleCase`/
// `CullingTest`/`PointCase` data tables and logic are byte-identical upstream (confirmed
// by reading both files); only the GLSL (`#version 300 es`, `in`/`out` instead of
// `attribute`/`varying`, `gl_FragColor` replaced by an explicit `layout(location=0) out`)
// differs, which is why this file duplicates `gles2::functional::rasterization_tests`
// rather than sharing it - upstream itself duplicates the whole file per API, and this
// port follows that shape (see CLAUDE.md's "ported code keeps upstream shape"). ES3's
// `PointCase` additionally picks three hand-chosen wide sizes (`10.0`/`25.0`/the queried
// max) rather than ES2's "10.0 for every iteration but the last", confirmed by reading
// both files directly - not a port inconsistency.

use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, expect_no_error, read_pixels};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::rasterization_verifier::{
    LineInterpolationMethod, LineSceneSpec, PointSceneSpec, RasterizationArguments, SceneLine, ScenePoint,
    SceneTriangle, TriangleSceneSpec, VerificationMode, verify_line_group_interpolation,
    verify_line_group_rasterization, verify_point_group_rasterization, verify_triangle_group_interpolation,
    verify_triangle_group_rasterization,
};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{PixelFormat, RGBA, Random, Surface, TestError, TestOutcome, TestResult, TestStatus, Vec4};

/// `BaseRenderingCase::SAMPLE_COUNT_MAX` - "use whatever `GL_SAMPLES` the driver's own
/// `GL_RGBA8` renderbuffer query reports as its maximum" rather than a fixed count.
const SAMPLE_COUNT_MAX: i32 = -2;

/// `BaseRenderingCase::RenderTarget`, restricted to what this file ports: the default
/// framebuffer, the two non-multisampled FBO targets (`texture_2d`/`rbo_singlesample`),
/// and the two multisampled renderbuffer targets (`rbo_multisample_4`/
/// `rbo_multisample_max`, the `requested_samples` field distinguishing them - `4` or
/// `SAMPLE_COUNT_MAX`). Every case type reaches every target now, including
/// `LineInterpolationCase` on a multisample target -
/// `verify_line_group_interpolation`'s multisample path
/// (`verify_multisample_line_group_interpolation` in `tcu::rasterization_verifier`)
/// turned out, like `verify_line_group_rasterization`'s own multisample path before it,
/// to need no new *coverage* math: both reduce to "two triangles" forwarded to the
/// already-multisample-aware triangle machinery, the same shape point rasterization
/// already had - only the *interpolator* substituted in differs
/// (`MultisampleLineInterpolator` instead of `TriangleInterpolator`).
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum FboTarget {
    Default,
    Texture2d,
    RboSinglesample,
    RboMultisample { requested_samples: i32 },
}

/// `s_shaderVertexTemplate` with `${INTERPOLATION}` specialized - `"flat "` for
/// `flatshading.*`'s triangle cases, empty otherwise.
fn vertex_source(flatshade: bool) -> String {
    let interpolation = if flatshade { "flat " } else { "" };
    format!(
        "#version 300 es\nin highp vec4 a_position;\nin highp vec4 a_color;\n{interpolation}out highp vec4 v_color;\nuniform highp float u_pointSize;\nvoid main ()\n{{\n    gl_Position = a_position;\n    gl_PointSize = u_pointSize;\n    v_color = a_color;\n}}\n"
    )
}
/// `s_shaderFragmentTemplate` with `${INTERPOLATION}` specialized.
fn fragment_source(flatshade: bool) -> String {
    let interpolation = if flatshade { "flat " } else { "" };
    format!(
        "#version 300 es\nlayout(location = 0) out highp vec4 fragColor;\n{interpolation}in highp vec4 v_color;\nvoid main ()\n{{\n    fragColor = v_color;\n}}\n"
    )
}

/// `BaseRenderingCase`, covering the default framebuffer and all four `FboTarget`s.
struct RenderHarness<'gl> {
    gl: &'gl glw::Functions,
    shader: ShaderProgram<'gl>,
    position_loc: GLint,
    color_loc: GLint,
    point_size_loc: GLint,
    render_size: i32,
    num_samples: i32,
    subpixel_bits: i32,
    pixel_format: PixelFormat,
    fbo: GLuint,
    texture: GLuint,
    rbo: GLuint,
    /// `BaseRenderingCase::m_blitDstFbo`/`m_blitDstRbo` - the singlesample resolve
    /// target a multisample renderbuffer must be blitted to before `glReadPixels` can
    /// read it back at all. Both 0 for every other target.
    blit_dst_fbo: GLuint,
    blit_dst_rbo: GLuint,
}

impl<'gl> RenderHarness<'gl> {
    /// `BaseRenderingCase::init`.
    fn new(context: &'gl Context, render_size: i32) -> Result<Self, TestError> {
        Self::new_for_target(context, render_size, false, FboTarget::Default)
    }

    /// `BaseRenderingCase::init`, with `${INTERPOLATION}` specialized for
    /// `flatshading.*`'s triangle cases.
    fn new_with_flatshade(
        context: &'gl Context,
        render_size: i32,
        flatshade: bool,
        target: FboTarget,
    ) -> Result<Self, TestError> {
        Self::new_for_target(context, render_size, flatshade, target)
    }

    /// `BaseRenderingCase::init`, for an `fbo.*` case - `flatshade` is always `false`
    /// there (upstream's `fbo.*` registrations never set `INTERPOLATIONFLAGS_FLATSHADE`,
    /// confirmed by reading the registration code directly).
    fn new_fbo(context: &'gl Context, render_size: i32, target: FboTarget) -> Result<Self, TestError> {
        Self::new_for_target(context, render_size, false, target)
    }

    /// `BaseRenderingCase::init`, the common path behind all three constructors above.
    /// For `FboTarget::Default` this is unchanged from before this FBO support was
    /// added (same size check, same `context.render_target()`-derived sample count and
    /// pixel format); for the two FBO targets it instead creates a colour attachment of
    /// the fixed `GL_RGBA8` format `BaseRenderingCase` itself always uses, matching
    /// upstream's own `m_fboInternalFormat` constant.
    fn new_for_target(
        context: &'gl Context,
        render_size: i32,
        flatshade: bool,
        target: FboTarget,
    ) -> Result<Self, TestError> {
        if target == FboTarget::Default {
            let render_target = context.render_target();
            if render_target.width < render_size || render_target.height < render_size {
                return Err(TestError::NotSupported(format!(
                    "Render target size must be at least {render_size}x{render_size}"
                )));
            }
        }

        let gl = context.gl();
        let shader = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(vertex_source(flatshade), fragment_source(flatshade)),
        );
        if !shader.is_ok() {
            return Err(TestError::Fail("could not create shader".to_string()));
        }
        // SAFETY: the shader just linked successfully, so every name is a valid
        // program queried for its own attributes/uniforms.
        let (position_loc, color_loc, point_size_loc) = unsafe {
            (
                gl.get_attrib_location(shader.program(), c"a_position".as_ptr()),
                gl.get_attrib_location(shader.program(), c"a_color".as_ptr()),
                gl.get_uniform_location(shader.program(), c"u_pointSize".as_ptr()),
            )
        };

        let mut subpixel_bits: GLint = 0;
        // SAFETY: one query, one GLint of output.
        unsafe { gl.get_integerv(glw::GL_SUBPIXEL_BITS, &mut subpixel_bits) };

        let (num_samples, pixel_format, fbo, texture, rbo, blit_dst_fbo, blit_dst_rbo) = if target == FboTarget::Default
        {
            let render_target = context.render_target();
            (render_target.num_samples, render_target.pixel_format(), 0, 0, 0, 0, 0)
        } else {
            let mut fbo: GLuint = 0;
            let mut texture: GLuint = 0;
            let mut rbo: GLuint = 0;
            // SAFETY: plain object creation/binding on a current context, error-checked
            // right after via `gl.get_error()`/`expect_no_error`.
            unsafe {
                gl.gen_framebuffers(1, &mut fbo);
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);

                match target {
                    FboTarget::Texture2d => {
                        gl.gen_textures(1, &mut texture);
                        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
                        gl.tex_storage_2d(glw::GL_TEXTURE_2D, 1, glw::GL_RGBA8, render_size, render_size);
                        gl.framebuffer_texture_2d(
                            glw::GL_FRAMEBUFFER,
                            glw::GL_COLOR_ATTACHMENT0,
                            glw::GL_TEXTURE_2D,
                            texture,
                            0,
                        );
                    }
                    FboTarget::RboSinglesample => {
                        gl.gen_renderbuffers(1, &mut rbo);
                        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
                        gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, render_size, render_size);
                        gl.framebuffer_renderbuffer(
                            glw::GL_FRAMEBUFFER,
                            glw::GL_COLOR_ATTACHMENT0,
                            glw::GL_RENDERBUFFER,
                            rbo,
                        );
                    }
                    FboTarget::RboMultisample { .. } => {
                        gl.gen_renderbuffers(1, &mut rbo);
                        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
                        // `samples` is resolved to a concrete count further down, once
                        // this unsafe block (and its own error check) is behind us -
                        // the query itself needs no binding/state of its own.
                    }
                    FboTarget::Default => unreachable!(),
                }
            }

            if let FboTarget::RboMultisample { requested_samples } = target {
                let mut max_samples: GLint = 0;
                // SAFETY: one query, one GLint of output.
                unsafe {
                    gl.get_internalformativ(
                        glw::GL_RENDERBUFFER,
                        glw::GL_RGBA8,
                        glw::GL_SAMPLES,
                        1,
                        &mut max_samples,
                    )
                };
                let target_samples = if requested_samples == SAMPLE_COUNT_MAX {
                    max_samples
                } else if max_samples >= requested_samples {
                    requested_samples
                } else {
                    // SAFETY: cleaning up exactly what was just created above.
                    unsafe {
                        gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
                        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                        gl.delete_renderbuffers(1, &rbo);
                        gl.delete_framebuffers(1, &fbo);
                    }
                    return Err(TestError::NotSupported(format!(
                        "Test requires {requested_samples}x msaa rbo"
                    )));
                };
                // SAFETY: `rbo` is already bound from the match arm above.
                unsafe {
                    gl.renderbuffer_storage_multisample(
                        glw::GL_RENDERBUFFER,
                        target_samples,
                        glw::GL_RGBA8,
                        render_size,
                        render_size,
                    );
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_RENDERBUFFER,
                        rbo,
                    );
                }
            }

            // SAFETY: one query, no output buffer.
            let error = unsafe { gl.get_error() };
            if error == glw::GL_OUT_OF_MEMORY {
                // SAFETY: cleaning up exactly what was just created above.
                unsafe {
                    gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                    gl.delete_framebuffers(1, &fbo);
                    if texture != 0 {
                        gl.delete_textures(1, &texture);
                    }
                    if rbo != 0 {
                        gl.delete_renderbuffers(1, &rbo);
                    }
                }
                return Err(TestError::NotSupported(
                    "could not create target texture, got out of memory".to_string(),
                ));
            }
            expect_no_error(gl, "create fbo render target")?;

            // Resolve (blitFramebuffer) target fbo for MSAA targets - `glReadPixels`
            // cannot read a multisample renderbuffer directly.
            let (blit_dst_fbo, blit_dst_rbo) = if matches!(target, FboTarget::RboMultisample { .. }) {
                let mut blit_dst_fbo: GLuint = 0;
                let mut blit_dst_rbo: GLuint = 0;
                // SAFETY: plain object creation/binding, error-checked right after.
                unsafe {
                    gl.gen_framebuffers(1, &mut blit_dst_fbo);
                    gl.bind_framebuffer(glw::GL_FRAMEBUFFER, blit_dst_fbo);
                    gl.gen_renderbuffers(1, &mut blit_dst_rbo);
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, blit_dst_rbo);
                    gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, render_size, render_size);
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_RENDERBUFFER,
                        blit_dst_rbo,
                    );
                }
                expect_no_error(gl, "create blit target")?;
                // SAFETY: restoring the actual render target as current, matching
                // upstream's own `init` doing the same right after creating this.
                unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo) };
                (blit_dst_fbo, blit_dst_rbo)
            } else {
                (0, 0)
            };

            let num_samples = if matches!(target, FboTarget::RboMultisample { .. }) {
                let mut num_samples: GLint = -1;
                // SAFETY: `rbo` is this harness's own renderbuffer, already created above.
                unsafe {
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
                    gl.get_renderbuffer_parameteriv(
                        glw::GL_RENDERBUFFER,
                        glw::GL_RENDERBUFFER_SAMPLES,
                        &mut num_samples,
                    );
                }
                expect_no_error(gl, "get RENDERBUFFER_SAMPLES")?;
                num_samples
            } else {
                0
            };

            (
                num_samples,
                PixelFormat::new(8, 8, 8, 8),
                fbo,
                texture,
                rbo,
                blit_dst_fbo,
                blit_dst_rbo,
            )
        };

        Ok(Self {
            gl,
            shader,
            position_loc,
            color_loc,
            point_size_loc,
            render_size,
            num_samples,
            subpixel_bits,
            pixel_format,
            fbo,
            texture,
            rbo,
            blit_dst_fbo,
            blit_dst_rbo,
        })
    }

    fn pixel_format(&self) -> PixelFormat {
        self.pixel_format
    }

    /// `BaseRenderingCase::drawPrimitives(result, vertexData, primitiveType)` - defaults
    /// every vertex to white.
    fn draw_white(
        &self,
        context: &Context,
        vertex_data: &[Vec4],
        primitive_type: GLenum,
    ) -> Result<Surface, TestError> {
        let color_data = vec![Vec4::new(1.0, 1.0, 1.0, 1.0); vertex_data.len()];
        self.draw(context, vertex_data, &color_data, primitive_type, 1.0, 1.0)
    }

    /// `PointCase::drawPrimitives(result, vertexData, GL_POINTS)` - white, with an
    /// explicit `gl_PointSize` instead of the default 1.0.
    fn draw_points(&self, context: &Context, vertex_data: &[Vec4], point_size: f32) -> Result<Surface, TestError> {
        let color_data = vec![Vec4::new(1.0, 1.0, 1.0, 1.0); vertex_data.len()];
        self.draw(context, vertex_data, &color_data, glw::GL_POINTS, point_size, 1.0)
    }

    /// `BaseLineCase::drawPrimitives(result, vertexData, primitiveDrawType)` - white,
    /// with an explicit line width instead of the GL default of 1.0.
    fn draw_lines(
        &self,
        context: &Context,
        vertex_data: &[Vec4],
        primitive_type: GLenum,
        line_width: f32,
    ) -> Result<Surface, TestError> {
        let color_data = vec![Vec4::new(1.0, 1.0, 1.0, 1.0); vertex_data.len()];
        self.draw(context, vertex_data, &color_data, primitive_type, 1.0, line_width)
    }

    /// `BaseRenderingCase::drawPrimitives(result, vertexData, colorData, primitiveType)`.
    /// Upstream calls both `gl.uniform1f(pointSizeLoc, ...)` and `gl.lineWidth(...)`
    /// unconditionally on every draw, regardless of the primitive type being drawn.
    fn draw(
        &self,
        context: &Context,
        vertex_data: &[Vec4],
        color_data: &[Vec4],
        primitive_type: GLenum,
        point_size: f32,
        line_width: f32,
    ) -> Result<Surface, TestError> {
        let gl = context.gl();
        let positions: Vec<f32> = vertex_data.iter().flat_map(|v| v.m_data).collect();
        let colors: Vec<f32> = color_data.iter().flat_map(|v| v.m_data).collect();

        // SAFETY: `positions`/`colors` outlive the draw call below, and each has
        // exactly `vertex_data.len()` vertices' worth of 4 components, matching what
        // `vertex_attrib_pointer`/`draw_arrays` are told.
        unsafe {
            // Rebinding `self.fbo` here is a no-op for `FboTarget::Default` (where it is
            // 0, the default framebuffer) and keeps this harness's own target current
            // even if some other code rebound a framebuffer since `new_for_target`.
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo);
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
            gl.viewport(0, 0, self.render_size, self.render_size);
            gl.use_program(self.shader.program());
            gl.enable_vertex_attrib_array(self.position_loc as GLuint);
            gl.vertex_attrib_pointer(
                self.position_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                positions.as_ptr().cast(),
            );
            gl.enable_vertex_attrib_array(self.color_loc as GLuint);
            gl.vertex_attrib_pointer(
                self.color_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                colors.as_ptr().cast(),
            );
            gl.uniform_1f(self.point_size_loc, point_size);
            gl.line_width(line_width);
            gl.draw_arrays(primitive_type, 0, vertex_data.len() as glw::GLsizei);
            gl.disable_vertex_attrib_array(self.color_loc as GLuint);
            gl.disable_vertex_attrib_array(self.position_loc as GLuint);
            gl.use_program(0);
            gl.finish();
        }
        expect_no_error(gl, "draw primitives")?;

        let mut result = Surface::new(self.render_size, self.render_size);
        if self.blit_dst_fbo != 0 {
            // resolve msaa, then read the resolved (singlesample) copy - `glReadPixels`
            // cannot read a multisample renderbuffer directly.
            // SAFETY: both framebuffers are this harness's own, already created.
            unsafe {
                gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.fbo);
                gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.blit_dst_fbo);
                gl.blit_framebuffer(
                    0,
                    0,
                    self.render_size,
                    self.render_size,
                    0,
                    0,
                    self.render_size,
                    self.render_size,
                    glw::GL_COLOR_BUFFER_BIT,
                    glw::GL_NEAREST,
                );
            }
            expect_no_error(gl, "blit")?;
            // SAFETY: reading from the just-resolved framebuffer.
            unsafe { gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.blit_dst_fbo) };
            read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;
            expect_no_error(gl, "read pixels")?;
            // SAFETY: restoring the actual render target as current, matching
            // upstream's own post-resolve `gl.bindFramebuffer(GL_FRAMEBUFFER, m_fbo)`.
            unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.fbo) };
        } else {
            read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;
        }
        Ok(result)
    }

    fn rasterization_args(&self, _context: &Context) -> RasterizationArguments {
        RasterizationArguments {
            num_samples: self.num_samples,
            subpixel_bits: self.subpixel_bits,
            red_bits: self.pixel_format.red_bits,
            green_bits: self.pixel_format.green_bits,
            blue_bits: self.pixel_format.blue_bits,
        }
    }
}

/// `BaseRenderingCase::deinit`'s FBO half - a no-op for `FboTarget::Default`, where
/// every id is 0.
impl Drop for RenderHarness<'_> {
    fn drop(&mut self) {
        if self.fbo == 0 {
            return;
        }
        // SAFETY: every id here was created by this same harness in `new_for_target`
        // and nothing else holds a reference to it.
        unsafe {
            self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            if self.texture != 0 {
                self.gl.bind_texture(glw::GL_TEXTURE_2D, 0);
                self.gl.delete_textures(1, &self.texture);
            }
            if self.rbo != 0 {
                self.gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
                self.gl.delete_renderbuffers(1, &self.rbo);
            }
            self.gl.delete_framebuffers(1, &self.fbo);
            if self.blit_dst_rbo != 0 {
                self.gl.delete_renderbuffers(1, &self.blit_dst_rbo);
            }
            if self.blit_dst_fbo != 0 {
                self.gl.delete_framebuffers(1, &self.blit_dst_fbo);
            }
        }
    }
}

/// `BaseTriangleCase` + the three `generateTriangles` overrides, generalized over a
/// plain function pointer instead of virtual dispatch - `TrianglesCase`/
/// `TriangleStripCase`/`TriangleFanCase` differ in nothing else.
struct TriangleCase {
    name: &'static str,
    primitive_type: GLenum,
    generate: fn(i32) -> (Vec<Vec4>, Vec<SceneTriangle>),
    target: FboTarget,
}

impl TestCase for TriangleCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let harness = RenderHarness::new_fbo(context, 256, self.target)?;
        let args = harness.rasterization_args(context);

        for iteration in 0..3 {
            let (draw_buffer, triangles) = (self.generate)(iteration);
            let result_image = harness.draw_white(context, &draw_buffer, self.primitive_type)?;
            let scene = TriangleSceneSpec { triangles };

            let verify = verify_triangle_group_rasterization(&result_image, &scene, &args, VerificationMode::Strict);
            if !verify.ok {
                return Ok(TestStatus::fail(format!(
                    "Incorrect rasterization at iteration {iteration} ({} missing, {} unexpected pixels)",
                    verify.missing_pixels, verify.unexpected_pixels
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `TrianglesCase::generateTriangles` - identical data to the ES2 file.
fn generate_triangles(iteration: i32) -> (Vec<Vec4>, Vec<SceneTriangle>) {
    let data: [[f32; 2]; 6] = match iteration {
        0 => [
            [0.2, 0.8],
            [0.5, 0.2],
            [0.5, 0.3],
            [-0.5, 0.2],
            [-1.5, -0.4],
            [-0.4, 0.2],
        ],
        1 => [
            [-0.499, 0.128],
            [-0.501, -0.3],
            [0.11, -0.2],
            [0.11, 0.2],
            [0.88, 0.9],
            [0.4, 1.2],
        ],
        _ => [
            [-0.9, -0.3],
            [1.1, -0.9],
            [-1.1, -0.1],
            [-0.11, 0.2],
            [0.88, 0.7],
            [-0.4, 0.4],
        ],
    };
    let out_data: Vec<Vec4> = data.iter().map(|p| Vec4::new(p[0], p[1], 0.0, 1.0)).collect();
    let triangles = vec![
        SceneTriangle::new(out_data[0], out_data[1], out_data[2]),
        SceneTriangle::new(out_data[3], out_data[4], out_data[5]),
    ];
    (out_data, triangles)
}

/// `TriangleStripCase::generateTriangles` - identical data to the ES2 file.
fn generate_triangle_strip(iteration: i32) -> (Vec<Vec4>, Vec<SceneTriangle>) {
    let data: [[f32; 2]; 5] = match iteration {
        0 => [[-0.504, 0.8], [-0.2, -0.2], [-0.2, 0.199], [0.5, 0.201], [1.5, 0.4]],
        1 => [
            [-0.499, 0.129],
            [-0.501, -0.3],
            [0.11, -0.2],
            [0.11, -0.31],
            [0.88, 0.9],
        ],
        _ => [[-0.9, -0.3], [1.1, -0.9], [-0.87, -0.1], [-0.11, 0.19], [0.88, 0.7]],
    };
    let out_data: Vec<Vec4> = data.iter().map(|p| Vec4::new(p[0], p[1], 0.0, 1.0)).collect();

    let mut t0 = SceneTriangle::new(out_data[0], out_data[1], out_data[2]);
    t0.shared_edge[1] = true;
    let mut t1 = SceneTriangle::new(out_data[2], out_data[1], out_data[3]);
    t1.shared_edge[0] = true;
    t1.shared_edge[2] = true;
    let mut t2 = SceneTriangle::new(out_data[2], out_data[3], out_data[4]);
    t2.shared_edge[0] = true;

    (out_data, vec![t0, t1, t2])
}

/// `TriangleFanCase::generateTriangles` - identical data to the ES2 file.
fn generate_triangle_fan(iteration: i32) -> (Vec<Vec4>, Vec<SceneTriangle>) {
    let data: [[f32; 2]; 5] = match iteration {
        0 => [[0.01, 0.0], [0.5, 0.2], [0.46, 0.3], [-0.5, 0.2], [-1.5, -0.4]],
        1 => [[-0.499, 0.128], [-0.501, -0.3], [0.11, -0.2], [0.11, 0.2], [0.88, 0.9]],
        _ => [[-0.9, -0.3], [1.1, -0.9], [0.7, -0.1], [0.11, 0.2], [0.88, 0.7]],
    };
    let out_data: Vec<Vec4> = data.iter().map(|p| Vec4::new(p[0], p[1], 0.0, 1.0)).collect();

    let mut t0 = SceneTriangle::new(out_data[0], out_data[1], out_data[2]);
    t0.shared_edge[2] = true;
    let mut t1 = SceneTriangle::new(out_data[0], out_data[2], out_data[3]);
    t1.shared_edge[0] = true;
    t1.shared_edge[2] = true;
    let mut t2 = SceneTriangle::new(out_data[0], out_data[3], out_data[4]);
    t2.shared_edge[0] = true;

    (out_data, vec![t0, t1, t2])
}

/// `TriangleInterpolationTest` - `basic`/`projected` register this with
/// `flatshade = false`, `flatshading` with `flatshade = true` (the line variants of
/// `flatshading` reuse the same upstream class with `LineInterpolationTest` instead and
/// need the line half of the verifier, not ported here).
struct TriangleInterpolationCase {
    name: &'static str,
    primitive_type: GLenum,
    projective: bool,
    flatshade: bool,
    target: FboTarget,
}

impl TriangleInterpolationCase {
    const COLORS: [Vec4; 3] = [
        Vec4::new(1.0, 0.0, 0.0, 1.0),
        Vec4::new(0.0, 1.0, 0.0, 1.0),
        Vec4::new(0.0, 0.0, 1.0, 1.0),
    ];

    /// `TriangleInterpolationTest::generateVertices`
    fn generate_vertices(&self, iteration: i32) -> (Vec<Vec4>, Vec<Vec4>) {
        let mut rnd = Random::new((123 + iteration * 1000 + self.primitive_type as i32) as u32);
        let mut vertices = Vec::with_capacity(6);
        let mut colors = Vec::with_capacity(6);

        for vtx_ndx in 0..6usize {
            let mut x = rnd.get_float_range(-0.9, 0.9);
            let mut y = rnd.get_float_range(-0.9, 0.9);
            let w = if !self.projective {
                1.0
            } else {
                let w = rnd.get_float_range(0.2, 4.0);
                x *= w;
                y *= w;
                w
            };
            vertices.push(Vec4::new(x, y, 0.0, w));
            colors.push(Self::COLORS[vtx_ndx % Self::COLORS.len()]);
        }

        (vertices, colors)
    }

    /// `TriangleInterpolationTest::extractTriangles` - when `flatshade`, every vertex of
    /// a triangle takes the *last* vertex's colour (matching the GPU's own flat-shading
    /// provoking-vertex convention, which is always the triangle's last vertex here).
    fn extract_triangles(&self, vertices: &[Vec4], colors: &[Vec4]) -> Vec<SceneTriangle> {
        let mut out = Vec::new();
        if self.primitive_type == glw::GL_TRIANGLES {
            let mut vtx_ndx = 0;
            while vtx_ndx + 2 < vertices.len() {
                let [c0, c1, c2] = if self.flatshade {
                    [colors[vtx_ndx + 2]; 3]
                } else {
                    [colors[vtx_ndx], colors[vtx_ndx + 1], colors[vtx_ndx + 2]]
                };
                out.push(SceneTriangle::with_colors(
                    vertices[vtx_ndx],
                    vertices[vtx_ndx + 1],
                    vertices[vtx_ndx + 2],
                    c0,
                    c1,
                    c2,
                ));
                vtx_ndx += 3;
            }
        } else if self.primitive_type == glw::GL_TRIANGLE_STRIP {
            for vtx_ndx in 0..vertices.len().saturating_sub(2) {
                let [c0, c1, c2] = if self.flatshade {
                    [colors[vtx_ndx + 2]; 3]
                } else {
                    [colors[vtx_ndx], colors[vtx_ndx + 1], colors[vtx_ndx + 2]]
                };
                out.push(SceneTriangle::with_colors(
                    vertices[vtx_ndx],
                    vertices[vtx_ndx + 1],
                    vertices[vtx_ndx + 2],
                    c0,
                    c1,
                    c2,
                ));
            }
        } else if self.primitive_type == glw::GL_TRIANGLE_FAN {
            for vtx_ndx in 1..vertices.len().saturating_sub(1) {
                let [c0, c1, c2] = if self.flatshade {
                    [colors[vtx_ndx + 1]; 3]
                } else {
                    [colors[0], colors[vtx_ndx], colors[vtx_ndx + 1]]
                };
                out.push(SceneTriangle::with_colors(
                    vertices[0],
                    vertices[vtx_ndx],
                    vertices[vtx_ndx + 1],
                    c0,
                    c1,
                    c2,
                ));
            }
        } else {
            unreachable!("TriangleInterpolationCase only registers triangle primitives in this port");
        }
        out
    }
}

impl TestCase for TriangleInterpolationCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let harness = RenderHarness::new_with_flatshade(context, 256, self.flatshade, self.target)?;
        let args = harness.rasterization_args(context);

        for iteration in 0..3 {
            let (vertices, colors) = self.generate_vertices(iteration);
            let triangles = self.extract_triangles(&vertices, &colors);
            let result_image = harness.draw(context, &vertices, &colors, self.primitive_type, 1.0, 1.0)?;
            let scene = TriangleSceneSpec { triangles };

            let verify = verify_triangle_group_interpolation(&result_image, &scene, &args);
            if !verify.ok {
                return Ok(TestStatus::fail(format!(
                    "Found invalid pixel values at iteration {iteration} ({} invalid pixels)",
                    verify.invalid_pixels
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `FillRuleCase::FillRuleCaseType`
#[derive(Clone, Copy)]
enum FillRuleCaseType {
    Basic,
    Reversed,
    ClippedFull,
    ClippedPartial,
    Projected,
}

/// `FillRuleCase` - needs no `tcu::rasterization_verifier` call at all, see the ES2
/// file's own note on the same struct.
struct FillRuleCase {
    name: &'static str,
    case_type: FillRuleCaseType,
    target: FboTarget,
}

impl FillRuleCase {
    fn render_size(&self) -> i32 {
        match self.case_type {
            FillRuleCaseType::ClippedFull | FillRuleCaseType::ClippedPartial => 64,
            _ => 256,
        }
    }

    fn num_iterations(&self) -> i32 {
        match self.case_type {
            FillRuleCaseType::ClippedFull | FillRuleCaseType::ClippedPartial => 15,
            _ => 2,
        }
    }

    /// `FillRuleCase::generateTriangles`
    fn generate_triangles(&self, iteration: i32, iteration_count: i32) -> Vec<Vec4> {
        match self.case_type {
            FillRuleCaseType::Basic | FillRuleCaseType::Reversed | FillRuleCaseType::Projected => {
                const NUM_ROWS: i32 = 4;
                const NUM_COLUMNS: i32 = 4;
                const QUAD_SIDE: f32 = 0.15;
                let mut rnd = Random::new(0xabcd);
                let mut out_data = vec![Vec4::new(0.0, 0.0, 0.0, 1.0); (6 * NUM_ROWS * NUM_COLUMNS) as usize];

                for col in 0..NUM_COLUMNS {
                    for row in 0..NUM_ROWS {
                        let center = [
                            (row as f32 + 0.5) / NUM_ROWS as f32 * 2.0 - 1.0,
                            (col as f32 + 0.5) / NUM_COLUMNS as f32 * 2.0 - 1.0,
                        ];
                        let rotation = (iteration * NUM_COLUMNS * NUM_ROWS + col * NUM_ROWS + row) as f32
                            / (iteration_count * NUM_COLUMNS * NUM_ROWS) as f32
                            * std::f32::consts::PI
                            / 2.0;
                        let side_h = [QUAD_SIDE * rotation.cos(), QUAD_SIDE * rotation.sin()];
                        let side_v = [side_h[1], -side_h[0]];
                        let quad: [[f32; 2]; 4] = [
                            [center[0] + side_h[0] + side_v[0], center[1] + side_h[1] + side_v[1]],
                            [center[0] + side_h[0] - side_v[0], center[1] + side_h[1] - side_v[1]],
                            [center[0] - side_h[0] - side_v[0], center[1] - side_h[1] - side_v[1]],
                            [center[0] - side_h[0] + side_v[0], center[1] - side_h[1] + side_v[1]],
                        ];

                        let base = (6 * (col * NUM_ROWS + row)) as usize;
                        match self.case_type {
                            FillRuleCaseType::Basic => {
                                let idx = [0, 1, 2, 2, 0, 3];
                                for (i, &qi) in idx.iter().enumerate() {
                                    out_data[base + i] = Vec4::new(quad[qi][0], quad[qi][1], 0.0, 1.0);
                                }
                            }
                            FillRuleCaseType::Reversed => {
                                let idx = [0, 1, 2, 0, 2, 3];
                                for (i, &qi) in idx.iter().enumerate() {
                                    out_data[base + i] = Vec4::new(quad[qi][0], quad[qi][1], 0.0, 1.0);
                                }
                            }
                            FillRuleCaseType::Projected => {
                                let w: [f32; 4] = std::array::from_fn(|_| rnd.get_float_range(0.1, 4.0));
                                let idx = [0, 1, 2, 2, 0, 3];
                                for (i, &qi) in idx.iter().enumerate() {
                                    out_data[base + i] =
                                        Vec4::new(quad[qi][0] * w[qi], quad[qi][1] * w[qi], 0.0, w[qi]);
                                }
                            }
                            _ => unreachable!(),
                        }
                    }
                }

                out_data
            }

            FillRuleCaseType::ClippedPartial | FillRuleCaseType::ClippedFull => {
                let quad_side = if matches!(self.case_type, FillRuleCaseType::ClippedPartial) {
                    1.0
                } else {
                    2.0
                };
                let center = if matches!(self.case_type, FillRuleCaseType::ClippedPartial) {
                    [0.5, 0.5]
                } else {
                    [0.0, 0.0]
                };
                let rotation = iteration as f32 / (iteration_count - 1) as f32 * std::f32::consts::PI / 2.0;
                let side_h = [quad_side * rotation.cos(), quad_side * rotation.sin()];
                let side_v = [side_h[1], -side_h[0]];
                let quad: [[f32; 2]; 4] = [
                    [center[0] + side_h[0] + side_v[0], center[1] + side_h[1] + side_v[1]],
                    [center[0] + side_h[0] - side_v[0], center[1] + side_h[1] - side_v[1]],
                    [center[0] - side_h[0] - side_v[0], center[1] - side_h[1] - side_v[1]],
                    [center[0] - side_h[0] + side_v[0], center[1] - side_h[1] + side_v[1]],
                ];
                let idx = [0, 1, 2, 2, 0, 3];
                idx.iter()
                    .map(|&qi| Vec4::new(quad[qi][0], quad[qi][1], 0.0, 1.0))
                    .collect()
            }
        }
    }
}

impl TestCase for FillRuleCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_size = self.render_size();
        let harness = RenderHarness::new_fbo(context, render_size, self.target)?;
        let iteration_count = self.num_iterations();
        let pf = harness.pixel_format();
        let threshold_red = 1 << (8 - pf.red_bits);
        let threshold_green = 1 << (8 - pf.green_bits);
        let threshold_blue = 1 << (8 - pf.blue_bits);
        let mut all_passed = true;

        for iteration in 0..iteration_count {
            let draw_buffer = self.generate_triangles(iteration, iteration_count);
            let color_data = vec![Vec4::new(0.5, 0.5, 0.5, 1.0); draw_buffer.len()];

            let gl = context.gl();
            // SAFETY: plain state toggles the draw below relies on.
            unsafe {
                gl.enable(glw::GL_BLEND);
                gl.blend_equation(glw::GL_FUNC_ADD);
                gl.blend_func(glw::GL_ONE, glw::GL_ONE);
            }
            let result_image = harness.draw(context, &draw_buffer, &color_data, glw::GL_TRIANGLES, 1.0, 1.0)?;

            // verify no overdraw
            let triangle_color = RGBA::new(127, 127, 127, 255);
            for y in 0..result_image.get_height() {
                for x in 0..result_image.get_width() {
                    let color = result_image.get_pixel(x, y);
                    if (color.get_red() - triangle_color.get_red()) > threshold_red
                        || (color.get_green() - triangle_color.get_green()) > threshold_green
                        || (color.get_blue() - triangle_color.get_blue()) > threshold_blue
                    {
                        all_passed = false;
                    }
                }
            }

            // verify no missing fragments in the full-viewport case
            if matches!(self.case_type, FillRuleCaseType::ClippedFull) {
                for y in 0..result_image.get_height() {
                    for x in 0..result_image.get_width() {
                        let color = result_image.get_pixel(x, y);
                        if color.get_red() <= threshold_red
                            || color.get_green() <= threshold_green
                            || color.get_blue() <= threshold_blue
                        {
                            all_passed = false;
                        }
                    }
                }
            }
        }

        if all_passed {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Found invalid pixels"))
        }
    }
}

/// `CullingTest`
struct CullingTest {
    name: String,
    cull_mode: GLenum,
    primitive: GLenum,
    face_order: GLenum,
}

impl CullingTest {
    /// `CullingTest::generateVertices`
    fn generate_vertices() -> Vec<Vec4> {
        let mut rnd = Random::new(543210);
        (0..6)
            .map(|_| Vec4::new(rnd.get_float_range(-0.9, 0.9), rnd.get_float_range(-0.9, 0.9), 0.0, 1.0))
            .collect()
    }

    /// `CullingTest::triangleOrder`
    fn triangle_order(v0: Vec4, v1: Vec4, v2: Vec4) -> bool {
        let s0 = crate::tcu::Vec2::new(v0.x() / v0.w(), v0.y() / v0.w());
        let s1 = crate::tcu::Vec2::new(v1.x() / v1.w(), v1.y() / v1.w());
        let s2 = crate::tcu::Vec2::new(v2.x() / v2.w(), v2.y() / v2.w());
        ((s1.x() - s0.x()) * (s2.y() - s0.y()) - (s2.x() - s0.x()) * (s1.y() - s0.y())) < 0.0
    }

    /// `CullingTest::extractTriangles`
    fn extract_triangles(&self, vertices: &[Vec4]) -> Vec<SceneTriangle> {
        let cull_direction = (self.cull_mode == glw::GL_FRONT) ^ (self.face_order == glw::GL_CCW);
        if self.cull_mode == glw::GL_FRONT_AND_BACK {
            return Vec::new();
        }

        let mut out = Vec::new();
        if self.primitive == glw::GL_TRIANGLES {
            let mut vtx_ndx = 0;
            while vtx_ndx + 2 < vertices.len() {
                let (v0, v1, v2) = (vertices[vtx_ndx], vertices[vtx_ndx + 1], vertices[vtx_ndx + 2]);
                if Self::triangle_order(v0, v1, v2) != cull_direction {
                    out.push(SceneTriangle::new(v0, v1, v2));
                }
                vtx_ndx += 3;
            }
        } else if self.primitive == glw::GL_TRIANGLE_STRIP {
            for vtx_ndx in 0..vertices.len().saturating_sub(2) {
                let (v0, v1, v2) = (vertices[vtx_ndx], vertices[vtx_ndx + 1], vertices[vtx_ndx + 2]);
                if Self::triangle_order(v0, v1, v2) != (cull_direction ^ (vtx_ndx % 2 != 0)) {
                    out.push(SceneTriangle::new(v0, v1, v2));
                }
            }
        } else if self.primitive == glw::GL_TRIANGLE_FAN {
            for vtx_ndx in 1..vertices.len().saturating_sub(1) {
                let (v0, v1, v2) = (vertices[0], vertices[vtx_ndx], vertices[vtx_ndx + 1]);
                if Self::triangle_order(v0, v1, v2) != cull_direction {
                    out.push(SceneTriangle::new(v0, v1, v2));
                }
            }
        } else {
            unreachable!("CullingTest only registers triangle primitives in this port");
        }
        out
    }
}

impl TestCase for CullingTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let harness = RenderHarness::new(context, 256)?;
        let vertices = Self::generate_vertices();
        let triangles = self.extract_triangles(&vertices);

        let gl = context.gl();
        // SAFETY: plain state toggles the draw below relies on.
        unsafe {
            gl.enable(glw::GL_CULL_FACE);
            gl.cull_face(self.cull_mode);
            gl.front_face(self.face_order);
        }
        let result_image = harness.draw_white(context, &vertices, self.primitive)?;

        let scene = TriangleSceneSpec { triangles };
        let args = harness.rasterization_args(context);
        let verify = verify_triangle_group_rasterization(&result_image, &scene, &args, VerificationMode::Weak);

        if verify.ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Incorrect rendering"))
        }
    }
}

/// `PointCase` - `primitives.points` is always registered with
/// `PRIMITIVEWIDENESS_WIDE` upstream (confirmed by reading the file - there is no
/// narrow `points` case in the mustpass).
struct PointCase {
    target: FboTarget,
}

impl PointCase {
    /// `PointCase::init` - the wide-point size list: `10.0`, `25.0`, then the queried max.
    fn point_sizes(max_size: f32) -> [f32; 3] {
        [10.0, 25.0, max_size]
    }

    /// `PointCase::generatePoints` - identical arbitrary per-iteration data to upstream.
    fn generate_points(iteration: i32, point_size: f32) -> (Vec<Vec4>, Vec<ScenePoint>) {
        let data: [[f32; 2]; 6] = match iteration {
            0 => [
                [0.2, 0.8],
                [0.5, 0.2],
                [0.5, 0.3],
                [-0.5, 0.2],
                [-0.2, -0.4],
                [-0.4, 0.2],
            ],
            1 => [
                [-0.499, 0.128],
                [-0.501, -0.3],
                [0.11, -0.2],
                [0.11, 0.2],
                [0.88, 0.9],
                [0.4, 1.2],
            ],
            _ => [
                [-0.9, -0.3],
                [0.3, -0.9],
                [-0.4, -0.1],
                [-0.11, 0.2],
                [0.88, 0.7],
                [-0.4, 0.4],
            ],
        };
        let out_data: Vec<Vec4> = data.iter().map(|p| Vec4::new(p[0], p[1], 0.0, 1.0)).collect();
        let points = out_data
            .iter()
            .map(|&position| ScenePoint { position, point_size })
            .collect();
        (out_data, points)
    }
}

impl TestCase for PointCase {
    fn name(&self) -> &str {
        "points"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let harness = RenderHarness::new_fbo(context, 256, self.target)?;
        let args = harness.rasterization_args(context);

        let gl = context.gl();
        let mut range = [0.0f32; 2];
        // SAFETY: one query, two GLfloats of output.
        unsafe { gl.get_floatv(glw::GL_ALIASED_POINT_SIZE_RANGE, range.as_mut_ptr()) };
        // no wide point support
        if range[1] <= 1.0 {
            return Err(TestError::NotSupported("wide point support required".to_string()));
        }
        let point_sizes = Self::point_sizes(range[1]);
        let max_point_size = range[1];

        for (iteration, &point_size) in point_sizes.iter().enumerate() {
            // `supported?` check upstream - a hand-picked size (10.0/25.0) may still
            // exceed the queried max on some implementations.
            if point_size > max_point_size {
                continue;
            }
            let (draw_buffer, points) = Self::generate_points(iteration as i32, point_size);
            let result_image = harness.draw_points(context, &draw_buffer, point_size)?;
            let scene = PointSceneSpec { points };

            let verify = verify_point_group_rasterization(&result_image, &scene, &args);
            if !verify.ok {
                return Ok(TestStatus::fail(format!(
                    "Incorrect rasterization at iteration {iteration} ({} missing, {} unexpected pixels)",
                    verify.missing_pixels, verify.unexpected_pixels
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `BaseLineCase` - ES3's own hand-picked wide sizes (`5.0`/`10.0`/the queried max),
/// each skipped individually if it exceeds the queried max, mirroring `PointCase`'s own
/// ES2/ES3 split above (confirmed by reading the file directly).
struct LineCase {
    name: &'static str,
    primitive_type: GLenum,
    wide: bool,
    generate: fn(i32) -> (Vec<Vec4>, Vec<SceneLine>),
    target: FboTarget,
}

impl LineCase {
    fn line_widths(max_width: f32) -> [f32; 3] {
        [5.0, 10.0, max_width]
    }
}

impl TestCase for LineCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let harness = RenderHarness::new_fbo(context, 256, self.target)?;
        let args = harness.rasterization_args(context);

        let line_widths: [f32; 3];
        let max_line_width: f32;
        if self.wide {
            let gl = context.gl();
            let mut range = [0.0f32; 2];
            // SAFETY: one query, two GLfloats of output.
            unsafe { gl.get_floatv(glw::GL_ALIASED_LINE_WIDTH_RANGE, range.as_mut_ptr()) };
            // no wide line support
            if range[1] <= 1.0 {
                return Err(TestError::NotSupported("wide line support required".to_string()));
            }
            line_widths = Self::line_widths(range[1]);
            max_line_width = range[1];
        } else {
            line_widths = [1.0, 1.0, 1.0];
            max_line_width = 1.0;
        }

        let mut multisample_relaxation_required = false;
        for (iteration, &line_width) in line_widths.iter().enumerate() {
            // `supported?` check upstream - a hand-picked size (5.0/10.0) may still
            // exceed the queried max on some implementations.
            if line_width > max_line_width {
                continue;
            }
            let (draw_buffer, lines) = (self.generate)(iteration as i32);
            let result_image = harness.draw_lines(context, &draw_buffer, self.primitive_type, line_width)?;
            let scene = LineSceneSpec {
                lines,
                line_width,
                ..Default::default()
            };

            let verify = verify_line_group_rasterization(&result_image, &scene, &args);
            let mut compare_ok = verify.ok;

            // multisampled wide lines might not be supported
            if line_width != 1.0 && args.num_samples > 1 && !compare_ok {
                multisample_relaxation_required = true;
                compare_ok = true;
            }

            if !compare_ok {
                return Ok(TestStatus::fail(format!(
                    "Incorrect rasterization at iteration {iteration}"
                )));
            }
        }

        if multisample_relaxation_required {
            Ok(TestStatus::new(
                TestResult::CompatibilityWarning,
                "Rasterization of multisampled wide lines failed",
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `LinesCase::generateLines` - identical data to the ES2 file.
fn generate_lines(iteration: i32) -> (Vec<Vec4>, Vec<SceneLine>) {
    let data: [[f32; 2]; 6] = match iteration {
        0 => [
            [0.01, 0.0],
            [0.5, 0.2],
            [0.46, 0.3],
            [-0.3, 0.2],
            [-1.5, -0.4],
            [0.1, 0.5],
        ],
        1 => [
            [-0.499, 0.128],
            [-0.501, -0.3],
            [0.11, -0.2],
            [0.11, 0.2],
            [0.88, 0.9],
            [0.18, -0.2],
        ],
        _ => [
            [-0.9, -0.3],
            [1.1, -0.9],
            [0.7, -0.1],
            [0.11, 0.2],
            [0.88, 0.7],
            [0.8, -0.7],
        ],
    };
    let out_data: Vec<Vec4> = data.iter().map(|p| Vec4::new(p[0], p[1], 0.0, 1.0)).collect();
    let lines = vec![
        SceneLine::new(out_data[0], out_data[1]),
        SceneLine::new(out_data[2], out_data[3]),
        SceneLine::new(out_data[4], out_data[5]),
    ];
    (out_data, lines)
}

/// `LineStripCase::generateLines` - identical data to the ES2 file.
fn generate_line_strip(iteration: i32) -> (Vec<Vec4>, Vec<SceneLine>) {
    let data: [[f32; 2]; 4] = match iteration {
        0 => [[0.01, 0.0], [0.5, 0.2], [0.46, 0.3], [-0.5, 0.2]],
        1 => [[-0.499, 0.128], [-0.501, -0.3], [0.11, -0.2], [0.11, 0.2]],
        _ => [[-0.9, -0.3], [1.1, -0.9], [0.7, -0.1], [0.11, 0.2]],
    };
    let out_data: Vec<Vec4> = data.iter().map(|p| Vec4::new(p[0], p[1], 0.0, 1.0)).collect();
    let lines = vec![
        SceneLine::new(out_data[0], out_data[1]),
        SceneLine::new(out_data[1], out_data[2]),
        SceneLine::new(out_data[2], out_data[3]),
    ];
    (out_data, lines)
}

/// `LineLoopCase::generateLines` - identical data to the ES2 file.
fn generate_line_loop(iteration: i32) -> (Vec<Vec4>, Vec<SceneLine>) {
    let data: [[f32; 2]; 4] = match iteration {
        0 => [[0.01, 0.0], [0.5, 0.2], [0.46, 0.3], [-0.5, 0.2]],
        1 => [[-0.499, 0.128], [-0.501, -0.3], [0.11, -0.2], [0.11, 0.2]],
        _ => [[-0.9, -0.3], [1.1, -0.9], [0.7, -0.1], [0.11, 0.2]],
    };
    let out_data: Vec<Vec4> = data.iter().map(|p| Vec4::new(p[0], p[1], 0.0, 1.0)).collect();
    let lines = vec![
        SceneLine::new(out_data[0], out_data[1]),
        SceneLine::new(out_data[1], out_data[2]),
        SceneLine::new(out_data[2], out_data[3]),
        SceneLine::new(out_data[3], out_data[0]),
    ];
    (out_data, lines)
}

/// `RasterizationTests::init`, restricted to the groups this batch ported.
/// `LineInterpolationTest` - `wide` mirrors `LineCase`'s own field: `false` registers
/// the narrow (`lineWidth == 1.0`) cases, `true` the three hand-picked wide sizes
/// (`5.0`/`10.0`/the queried max, same list `LineCase` itself uses - confirmed by
/// reading `LineInterpolationTest::init` directly, byte-identical to
/// `BaseLineCase::init`'s own wide-size list). `flatshade` mirrors
/// `TriangleInterpolationCase`'s own field: `interpolation.*` registers `false`,
/// `flatshading` registers `true`.
struct LineInterpolationCase {
    name: &'static str,
    primitive_type: GLenum,
    projective: bool,
    flatshade: bool,
    wide: bool,
    target: FboTarget,
}

impl LineInterpolationCase {
    const COLORS: [Vec4; 3] = [
        Vec4::new(1.0, 0.0, 0.0, 1.0),
        Vec4::new(0.0, 1.0, 0.0, 1.0),
        Vec4::new(0.0, 0.0, 1.0, 1.0),
    ];

    /// `LineInterpolationTest::generateVertices` - identical shape to
    /// `TriangleInterpolationCase::generate_vertices`.
    fn generate_vertices(&self, iteration: i32) -> (Vec<Vec4>, Vec<Vec4>) {
        let mut rnd = Random::new((123 + iteration * 1000 + self.primitive_type as i32) as u32);
        let mut vertices = Vec::with_capacity(6);
        let mut colors = Vec::with_capacity(6);

        for vtx_ndx in 0..6usize {
            let mut x = rnd.get_float_range(-0.9, 0.9);
            let mut y = rnd.get_float_range(-0.9, 0.9);
            let w = if !self.projective {
                1.0
            } else {
                let w = rnd.get_float_range(0.2, 4.0);
                x *= w;
                y *= w;
                w
            };
            vertices.push(Vec4::new(x, y, 0.0, w));
            colors.push(Self::COLORS[vtx_ndx % Self::COLORS.len()]);
        }

        (vertices, colors)
    }

    /// `LineInterpolationTest::extractLines` - when `flatshade`, both ends of a line
    /// take the *second* (ending) vertex's colour.
    fn extract_lines(&self, vertices: &[Vec4], colors: &[Vec4]) -> Vec<SceneLine> {
        let mut out = Vec::new();
        if self.primitive_type == glw::GL_LINES {
            let mut vtx_ndx = 0;
            while vtx_ndx + 1 < vertices.len() {
                let (c0, c1) = if self.flatshade {
                    (colors[vtx_ndx + 1], colors[vtx_ndx + 1])
                } else {
                    (colors[vtx_ndx], colors[vtx_ndx + 1])
                };
                out.push(SceneLine::with_colors(vertices[vtx_ndx], vertices[vtx_ndx + 1], c0, c1));
                vtx_ndx += 2;
            }
        } else if self.primitive_type == glw::GL_LINE_STRIP {
            for vtx_ndx in 0..vertices.len().saturating_sub(1) {
                let (c0, c1) = if self.flatshade {
                    (colors[vtx_ndx + 1], colors[vtx_ndx + 1])
                } else {
                    (colors[vtx_ndx], colors[vtx_ndx + 1])
                };
                out.push(SceneLine::with_colors(vertices[vtx_ndx], vertices[vtx_ndx + 1], c0, c1));
            }
        } else if self.primitive_type == glw::GL_LINE_LOOP {
            for vtx_ndx in 0..vertices.len() {
                let next = (vtx_ndx + 1) % vertices.len();
                let (c0, c1) = if self.flatshade {
                    (colors[next], colors[next])
                } else {
                    (colors[vtx_ndx], colors[next])
                };
                out.push(SceneLine::with_colors(vertices[vtx_ndx], vertices[next], c0, c1));
            }
        } else {
            unreachable!("LineInterpolationCase only registers line primitives in this port");
        }
        out
    }
}

impl TestCase for LineInterpolationCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let harness = RenderHarness::new_with_flatshade(context, 256, self.flatshade, self.target)?;
        let args = harness.rasterization_args(context);
        let mut result = ResultCollector::new("");

        let line_widths: [f32; 3];
        let max_line_width: f32;
        if self.wide {
            let gl = context.gl();
            let mut range = [0.0f32; 2];
            // SAFETY: one query, two GLfloats of output.
            unsafe { gl.get_floatv(glw::GL_ALIASED_LINE_WIDTH_RANGE, range.as_mut_ptr()) };
            if range[1] <= 1.0 {
                return Err(TestError::NotSupported("wide line support required".to_string()));
            }
            line_widths = LineCase::line_widths(range[1]);
            max_line_width = range[1];
        } else {
            line_widths = [1.0, 1.0, 1.0];
            max_line_width = 1.0;
        }

        for (iteration, &line_width) in line_widths.iter().enumerate() {
            // `supported?` check upstream - a hand-picked size (5.0/10.0) may still
            // exceed the queried max on some implementations; skipping contributes no
            // `ResultCollector` entry for this iteration, matching upstream exactly.
            if line_width > max_line_width {
                continue;
            }
            let (vertices, colors) = self.generate_vertices(iteration as i32);
            let lines = self.extract_lines(&vertices, &colors);
            let result_image = harness.draw(context, &vertices, &colors, self.primitive_type, 1.0, line_width)?;
            let scene = LineSceneSpec {
                lines,
                line_width,
                ..Default::default()
            };

            match verify_line_group_interpolation(&result_image, &scene, &args) {
                LineInterpolationMethod::StrictlyCorrect => result.add_result(TestResult::Pass, "Pass".to_string()),
                LineInterpolationMethod::Projected => result.add_result(
                    TestResult::QualityWarning,
                    "Interpolation was calculated using projected coordinateds".to_string(),
                ),
                LineInterpolationMethod::Incorrect => {
                    result.add_result(TestResult::Fail, "Found invalid pixel values".to_string())
                }
            }
        }

        Ok(result.to_status())
    }
}

#[rustfmt::skip]
const FILL_RULE_CASES: &[(&str, FillRuleCaseType)] = &[
    ("basic_quad",         FillRuleCaseType::Basic),
    ("basic_quad_reverse", FillRuleCaseType::Reversed),
    ("clipped_full",       FillRuleCaseType::ClippedFull),
    ("clipped_partly",     FillRuleCaseType::ClippedPartial),
    ("projected",          FillRuleCaseType::Projected),
];

/// `fbo.*`'s own, narrower sub-registration (confirmed by reading the registration code
/// directly, not assumed): `primitives` has only `triangles`/`lines`/`lines_wide`/`points`
/// (no `triangle_strip`/`triangle_fan`/`line_strip`/`line_loop`), `fill_rules` is the
/// full 5 cases unchanged, `interpolation` has only `triangles`/`lines`/`lines_wide` with
/// no `basic`/`projected` split (`m_projective` is always `false`) and no `flatshading`
/// sibling group at all - genuinely a smaller tree than the default-framebuffer one
/// above, not a port omission. Every case here (including `interpolation.{lines,
/// lines_wide}`) is registered unconditionally regardless of `target`: both
/// `verify_line_group_rasterization` and `verify_line_group_interpolation` dispatch on
/// `args.num_samples` internally and both multisample paths are ported.
fn register_fbo_target(fbo_group: &mut TestCaseGroup, group_name: &'static str, target: FboTarget) {
    let mut color_attachment = TestCaseGroup::new(group_name);

    let mut primitives = TestCaseGroup::new("primitives");
    primitives.add_child(Box::new(TriangleCase {
        name: "triangles",
        primitive_type: glw::GL_TRIANGLES,
        generate: generate_triangles,
        target,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "lines",
        primitive_type: glw::GL_LINES,
        wide: false,
        generate: generate_lines,
        target,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "lines_wide",
        primitive_type: glw::GL_LINES,
        wide: true,
        generate: generate_lines,
        target,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(PointCase { target }) as Box<dyn TestCase>);
    color_attachment.add_child(primitives);

    let mut fill_rules = TestCaseGroup::new("fill_rules");
    for &(name, case_type) in FILL_RULE_CASES {
        fill_rules.add_child(Box::new(FillRuleCase {
            name,
            case_type,
            target,
        }) as Box<dyn TestCase>);
    }
    color_attachment.add_child(fill_rules);

    let mut interpolation = TestCaseGroup::new("interpolation");
    interpolation.add_child(Box::new(TriangleInterpolationCase {
        name: "triangles",
        primitive_type: glw::GL_TRIANGLES,
        projective: false,
        flatshade: false,
        target,
    }) as Box<dyn TestCase>);
    interpolation.add_child(Box::new(LineInterpolationCase {
        name: "lines",
        primitive_type: glw::GL_LINES,
        projective: false,
        flatshade: false,
        wide: false,
        target,
    }) as Box<dyn TestCase>);
    interpolation.add_child(Box::new(LineInterpolationCase {
        name: "lines_wide",
        primitive_type: glw::GL_LINES,
        projective: false,
        flatshade: false,
        wide: true,
        target,
    }) as Box<dyn TestCase>);
    color_attachment.add_child(interpolation);

    fbo_group.add_child(color_attachment);
}

pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("rasterization");

    let mut primitives = TestCaseGroup::new("primitives");
    primitives.add_child(Box::new(TriangleCase {
        name: "triangles",
        primitive_type: glw::GL_TRIANGLES,
        generate: generate_triangles,
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(TriangleCase {
        name: "triangle_strip",
        primitive_type: glw::GL_TRIANGLE_STRIP,
        generate: generate_triangle_strip,
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(TriangleCase {
        name: "triangle_fan",
        primitive_type: glw::GL_TRIANGLE_FAN,
        generate: generate_triangle_fan,
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "lines",
        primitive_type: glw::GL_LINES,
        wide: false,
        generate: generate_lines,
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "line_strip",
        primitive_type: glw::GL_LINE_STRIP,
        wide: false,
        generate: generate_line_strip,
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "line_loop",
        primitive_type: glw::GL_LINE_LOOP,
        wide: false,
        generate: generate_line_loop,
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "lines_wide",
        primitive_type: glw::GL_LINES,
        wide: true,
        generate: generate_lines,
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "line_strip_wide",
        primitive_type: glw::GL_LINE_STRIP,
        wide: true,
        generate: generate_line_strip,
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "line_loop_wide",
        primitive_type: glw::GL_LINE_LOOP,
        wide: true,
        generate: generate_line_loop,
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(PointCase {
        target: FboTarget::Default,
    }) as Box<dyn TestCase>);
    group.add_child(primitives);

    let mut fill_rules = TestCaseGroup::new("fill_rules");
    for &(name, case_type) in FILL_RULE_CASES {
        fill_rules.add_child(Box::new(FillRuleCase {
            name,
            case_type,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    group.add_child(fill_rules);

    let mut interpolation = TestCaseGroup::new("interpolation");
    const TRIANGLE_PRIMITIVES: &[(GLenum, &str)] = &[
        (glw::GL_TRIANGLES, "triangles"),
        (glw::GL_TRIANGLE_STRIP, "triangle_strip"),
        (glw::GL_TRIANGLE_FAN, "triangle_fan"),
    ];
    const LINE_PRIMITIVES: &[(GLenum, &str)] = &[
        (glw::GL_LINES, "lines"),
        (glw::GL_LINE_STRIP, "line_strip"),
        (glw::GL_LINE_LOOP, "line_loop"),
    ];
    const LINE_PRIMITIVES_WIDE: &[(GLenum, &str)] = &[
        (glw::GL_LINES, "lines_wide"),
        (glw::GL_LINE_STRIP, "line_strip_wide"),
        (glw::GL_LINE_LOOP, "line_loop_wide"),
    ];
    let mut basic = TestCaseGroup::new("basic");
    for &(primitive_type, name) in TRIANGLE_PRIMITIVES {
        basic.add_child(Box::new(TriangleInterpolationCase {
            name,
            primitive_type,
            projective: false,
            flatshade: false,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES {
        basic.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: false,
            flatshade: false,
            wide: false,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES_WIDE {
        basic.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: false,
            flatshade: false,
            wide: true,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    interpolation.add_child(basic);
    let mut projected = TestCaseGroup::new("projected");
    for &(primitive_type, name) in TRIANGLE_PRIMITIVES {
        projected.add_child(Box::new(TriangleInterpolationCase {
            name,
            primitive_type,
            projective: true,
            flatshade: false,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES {
        projected.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: true,
            flatshade: false,
            wide: false,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES_WIDE {
        projected.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: true,
            flatshade: false,
            wide: true,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    interpolation.add_child(projected);
    group.add_child(interpolation);

    // .flatshading - triangle and line variants (`m_flatshade = true`), narrow and wide.
    let mut flatshading = TestCaseGroup::new("flatshading");
    for &(primitive_type, name) in TRIANGLE_PRIMITIVES {
        flatshading.add_child(Box::new(TriangleInterpolationCase {
            name,
            primitive_type,
            projective: false,
            flatshade: true,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES {
        flatshading.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: false,
            flatshade: true,
            wide: false,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES_WIDE {
        flatshading.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: false,
            flatshade: true,
            wide: true,
            target: FboTarget::Default,
        }) as Box<dyn TestCase>);
    }
    group.add_child(flatshading);

    let mut culling = TestCaseGroup::new("culling");
    const CULL_MODES: &[(GLenum, &str)] = &[
        (glw::GL_FRONT, "front_"),
        (glw::GL_BACK, "back_"),
        (glw::GL_FRONT_AND_BACK, "both_"),
    ];
    const PRIMITIVE_TYPES: &[(GLenum, &str)] = &[
        (glw::GL_TRIANGLES, "triangles"),
        (glw::GL_TRIANGLE_STRIP, "triangle_strip"),
        (glw::GL_TRIANGLE_FAN, "triangle_fan"),
    ];
    const FRONT_ORDERS: &[(GLenum, &str)] = &[(glw::GL_CCW, ""), (glw::GL_CW, "_reverse")];
    for &(cull_mode, prefix) in CULL_MODES {
        for &(primitive, prim_name) in PRIMITIVE_TYPES {
            for &(face_order, postfix) in FRONT_ORDERS {
                let name = format!("{prefix}{prim_name}{postfix}");
                culling.add_child(Box::new(CullingTest {
                    name,
                    cull_mode,
                    primitive,
                    face_order,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group.add_child(culling);

    let mut fbo_group = TestCaseGroup::new("fbo");
    register_fbo_target(&mut fbo_group, "texture_2d", FboTarget::Texture2d);
    register_fbo_target(&mut fbo_group, "rbo_singlesample", FboTarget::RboSinglesample);
    register_fbo_target(
        &mut fbo_group,
        "rbo_multisample_4",
        FboTarget::RboMultisample { requested_samples: 4 },
    );
    register_fbo_target(
        &mut fbo_group,
        "rbo_multisample_max",
        FboTarget::RboMultisample {
            requested_samples: SAMPLE_COUNT_MAX,
        },
    );
    group.add_child(fbo_group);

    group
}
