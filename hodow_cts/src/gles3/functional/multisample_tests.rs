// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fMultisampleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The whole file is now ported: `NumSamplesCase` (`num_samples_polygon`/`num_samples_line`),
// `CommonEdgeCase` (`common_edge_small_quads`/`common_edge_big_quad`/`common_edge_viewport_quad`),
// `SampleDepthCase` (`depth`), `SampleStencilCase` (`stencil`), `CoverageMaskInvertCase`
// (`sample_coverage_invert`), `MaskProportionalityCase` (`proportionality_*`) and
// `MaskConstancyCase` (`constancy_*`) - all 16 case names, across the same four framebuffer
// configs (`default_framebuffer`/`fbo_4_samples`/`fbo_8_samples`/`fbo_max_samples`) upstream
// itself loops over: 64 cases total.
//
// `MultisampleHarness` is upstream's `MultisampleCase` (the abstract base every case in the
// real file derives from): compiles the flat-shaded colour program, and - when `FboParams`
// asks for one - sets up a multisample colour(+depth/stencil) renderbuffer pair behind an
// FBO, plus a single-sample resolve FBO `glBlitFramebuffer` draws into before every
// readback. `Framebuffer`/`Renderbuffer` (`glu::objects`) already exist and are reused
// unchanged; nothing else in this campaign needed multisample FBO setup before this file
// (`gles31::functional::multisample_shader_render_case` is upstream's *separate*
// `MultisampleShaderRenderCase`, a different base class for a different upstream file, but
// confirms the same RBO/FBO/blit shape already works in this codebase).
//
// Upstream splits `NumSamplesCase::iterate` across up to `m_maxNumIterations` harness calls
// (`CONTINUE`/`STOP`) purely so a slow-to-converge case does not block the runner with one
// giant iteration; a single `iterate()` looping the same retries internally does the same
// work, matching how every other multi-iterate case in this campaign has been collapsed.

use crate::glu::{Context, Framebuffer, ProgramSources, Renderbuffer, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::rgba::{RGBA, compare_threshold};
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestResult, TestStatus};

const FBO_COLOR_FORMAT: GLenum = glw::GL_RGBA8;
const SQRT_HALF: f32 = 0.707107;

/// `MultisampleCase::FboParams`
#[derive(Clone, Copy)]
struct FboParams {
    use_fbo: bool,
    /// If 0 (and `use_fbo`), use the implementation-defined maximum.
    num_samples: i32,
    use_depth: bool,
    use_stencil: bool,
}

impl FboParams {
    fn none() -> Self {
        Self {
            use_fbo: false,
            num_samples: -1,
            use_depth: false,
            use_stencil: false,
        }
    }

    /// `numFboSamples >= 0 ? FboParams(numFboSamples, useDepth, useStencil) : FboParams()`
    fn from_num_fbo_samples(num_fbo_samples: i32, use_depth: bool, use_stencil: bool) -> Self {
        if num_fbo_samples >= 0 {
            Self {
                use_fbo: true,
                num_samples: num_fbo_samples,
                use_depth,
                use_stencil,
            }
        } else {
            Self::none()
        }
    }
}

struct FboResources<'gl> {
    ms_fbo: Framebuffer<'gl>,
    resolve_fbo: Framebuffer<'gl>,
    // Kept alive for the harness's own lifetime; never read again after `init`.
    _ms_color_rbo: Renderbuffer<'gl>,
    _resolve_color_rbo: Renderbuffer<'gl>,
    _ms_depth_stencil_rbo: Option<Renderbuffer<'gl>>,
}

/// `MultisampleCase` - the shared harness every case in this file builds on.
struct MultisampleHarness<'gl> {
    gl: &'gl glw::Functions,
    program: ShaderProgram<'gl>,
    attr_position_loc: GLuint,
    attr_color_loc: GLuint,
    num_samples: i32,
    viewport_size: i32,
    render_width: i32,
    render_height: i32,
    viewport_x: i32,
    viewport_y: i32,
    rnd: Random,
    fbo: Option<FboResources<'gl>>,
}

const VERT_SHADER_SOURCE: &str = "#version 300 es\n\
    in highp vec4 a_position;\n\
    in mediump vec4 a_color;\n\
    out mediump vec4 v_color;\n\
    void main()\n\
    {\n    \
    gl_Position = a_position;\n    \
    v_color = a_color;\n\
    }\n";

const FRAG_SHADER_SOURCE: &str = "#version 300 es\n\
    in mediump vec4 v_color;\n\
    layout(location = 0) out mediump vec4 o_color;\n\
    void main()\n\
    {\n    \
    o_color = v_color;\n\
    }\n";

impl<'gl> MultisampleHarness<'gl> {
    /// `MultisampleCase::MultisampleCase` + `MultisampleCase::init`.
    fn new(
        context: &'gl Context,
        name: &str,
        desired_viewport_size: i32,
        fbo_params: FboParams,
    ) -> Result<Self, TestError> {
        let gl = context.gl();
        let render_target = context.render_target();
        let (render_width, render_height) = if fbo_params.use_fbo {
            (2 * desired_viewport_size, 2 * desired_viewport_size)
        } else {
            (render_target.width, render_target.height)
        };

        if !fbo_params.use_fbo && render_target.num_samples <= 1 {
            return Err(TestError::NotSupported("No multisample buffers".to_string()));
        }

        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERT_SHADER_SOURCE, FRAG_SHADER_SOURCE));
        if !program.is_ok() {
            return Err(TestError::Fail("Failed to compile program".to_string()));
        }
        // SAFETY: `program` just linked successfully.
        let (attr_position_loc, attr_color_loc) = unsafe {
            (
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()) as GLuint,
                gl.get_attrib_location(program.program(), c"a_color".as_ptr()) as GLuint,
            )
        };

        let num_samples = if fbo_params.use_fbo {
            if fbo_params.num_samples > 0 {
                fbo_params.num_samples
            } else {
                let mut max_samples: GLint = 0;
                // SAFETY: one property is asked for and one GLint of output is given.
                unsafe {
                    gl.get_internalformativ(
                        glw::GL_RENDERBUFFER,
                        FBO_COLOR_FORMAT,
                        glw::GL_SAMPLES,
                        1,
                        &mut max_samples,
                    )
                };
                max_samples
            }
        } else {
            render_target.num_samples
        };

        let fbo = if fbo_params.use_fbo {
            let ms_color_rbo = Renderbuffer::new(gl);
            let ms_depth_stencil_rbo = if fbo_params.use_depth || fbo_params.use_stencil {
                Some(Renderbuffer::new(gl))
            } else {
                None
            };
            let ms_fbo = Framebuffer::new(gl);
            let resolve_color_rbo = Renderbuffer::new(gl);
            let resolve_fbo = Framebuffer::new(gl);

            // SAFETY: the renderbuffer is the one just created above.
            unsafe {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, ms_color_rbo.get());
                gl.renderbuffer_storage_multisample(
                    glw::GL_RENDERBUFFER,
                    num_samples,
                    FBO_COLOR_FORMAT,
                    render_width,
                    render_height,
                );
            }
            // If glRenderbufferStorageMultisample() fails, check if it's because of a too high sample count.
            if let Err(error) = crate::glu::expect_no_error(gl, "glRenderbufferStorageMultisample") {
                let mut max_sample_count: GLint = -1;
                // SAFETY: one property is asked for and one GLint of output is given.
                unsafe {
                    gl.get_internalformativ(
                        glw::GL_RENDERBUFFER,
                        FBO_COLOR_FORMAT,
                        glw::GL_SAMPLES,
                        1,
                        &mut max_sample_count,
                    )
                };
                crate::glu::expect_no_error(gl, "glGetInternalformativ")?;
                if max_sample_count < num_samples {
                    return Err(TestError::NotSupported(format!(
                        "Maximum sample count returned by glGetInternalformativ() for GL_RGBA8 is only {max_sample_count}"
                    )));
                }
                return Err(error);
            }

            // SAFETY: every renderbuffer/framebuffer name below is one just created above.
            unsafe {
                if let Some(depth_stencil_rbo) = &ms_depth_stencil_rbo {
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_stencil_rbo.get());
                    gl.renderbuffer_storage_multisample(
                        glw::GL_RENDERBUFFER,
                        num_samples,
                        glw::GL_DEPTH24_STENCIL8,
                        render_width,
                        render_height,
                    );
                }

                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, ms_fbo.get());
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    ms_color_rbo.get(),
                );
                if let Some(depth_stencil_rbo) = &ms_depth_stencil_rbo {
                    gl.framebuffer_renderbuffer(
                        glw::GL_FRAMEBUFFER,
                        glw::GL_DEPTH_STENCIL_ATTACHMENT,
                        glw::GL_RENDERBUFFER,
                        depth_stencil_rbo.get(),
                    );
                }

                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, resolve_color_rbo.get());
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, FBO_COLOR_FORMAT, render_width, render_height);

                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, resolve_fbo.get());
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    resolve_color_rbo.get(),
                );

                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, ms_fbo.get());
            }
            crate::glu::expect_no_error(gl, "multisample FBO setup")?;

            Some(FboResources {
                ms_fbo,
                resolve_fbo,
                _ms_color_rbo: ms_color_rbo,
                _resolve_color_rbo: resolve_color_rbo,
                _ms_depth_stencil_rbo: ms_depth_stencil_rbo,
            })
        } else {
            None
        };

        let viewport_size = desired_viewport_size.min(render_width).min(render_height);
        let mut harness = Self {
            gl,
            program,
            attr_position_loc,
            attr_color_loc,
            num_samples,
            viewport_size,
            render_width,
            render_height,
            viewport_x: 0,
            viewport_y: 0,
            rnd: Random::new(crate::tcu::de_string_hash(name)),
            fbo,
        };
        harness.randomize_viewport();
        Ok(harness)
    }

    /// `MultisampleCase::randomizeViewport`
    fn randomize_viewport(&mut self) {
        self.viewport_x = self.rnd.get_int(0, self.render_width - self.viewport_size);
        self.viewport_y = self.rnd.get_int(0, self.render_height - self.viewport_size);
        // SAFETY: takes plain integers only.
        unsafe {
            self.gl
                .viewport(self.viewport_x, self.viewport_y, self.viewport_size, self.viewport_size)
        };
    }

    /// `MultisampleCase::renderTriangle(Vec3, Vec3, Vec3, Vec4, Vec4, Vec4)` - the fully
    /// general form (per-vertex position including `z`, per-vertex colour); every other
    /// overload upstream has is one of this with some arguments repeated, matched below by
    /// the other `render_triangle*` convenience wrappers.
    fn render_triangle3(&self, p0: [f32; 3], p1: [f32; 3], p2: [f32; 3], colors: [[f32; 4]; 3]) {
        let positions: [f32; 12] = [
            p0[0], p0[1], p0[2], 1.0, p1[0], p1[1], p1[2], 1.0, p2[0], p2[1], p2[2], 1.0,
        ];
        let colors_flat: [f32; 12] = std::array::from_fn(|i| colors[i / 4][i % 4]);

        // SAFETY: `positions`/`colors_flat` outlive the draw call they describe, and each
        // points at exactly 3 vertices' worth of its own declared component count.
        unsafe {
            self.gl.enable_vertex_attrib_array(self.attr_position_loc);
            self.gl.vertex_attrib_pointer(
                self.attr_position_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                positions.as_ptr().cast(),
            );
            self.gl.enable_vertex_attrib_array(self.attr_color_loc);
            self.gl.vertex_attrib_pointer(
                self.attr_color_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                colors_flat.as_ptr().cast(),
            );
            self.gl.use_program(self.program.program());
            self.gl.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        }
    }

    /// `MultisampleCase::renderTriangle(Vec2, Vec2, Vec2, Vec4)` - single colour, `z = 0`.
    fn render_triangle(&self, p0: [f32; 2], p1: [f32; 2], p2: [f32; 2], color: [f32; 4]) {
        self.render_triangle3(
            [p0[0], p0[1], 0.0],
            [p1[0], p1[1], 0.0],
            [p2[0], p2[1], 0.0],
            [color, color, color],
        );
    }

    /// `MultisampleCase::renderTriangle(Vec2, Vec2, Vec2, Vec4, Vec4, Vec4)` - per-vertex
    /// colour, `z = 0`.
    fn render_triangle_colors(
        &self,
        p0: [f32; 2],
        p1: [f32; 2],
        p2: [f32; 2],
        c0: [f32; 4],
        c1: [f32; 4],
        c2: [f32; 4],
    ) {
        self.render_triangle3(
            [p0[0], p0[1], 0.0],
            [p1[0], p1[1], 0.0],
            [p2[0], p2[1], 0.0],
            [c0, c1, c2],
        );
    }

    /// `MultisampleCase::renderQuad(Vec2 x4, Vec4 x4)` - two triangles sharing the `p1`-`p2`
    /// diagonal, exactly as upstream splits it. `p`/`c` are corners 0..3 in upstream's own
    /// `p0, p1, p2, p3` order.
    fn render_quad_colors(&self, p: [[f32; 2]; 4], c: [[f32; 4]; 4]) {
        self.render_triangle_colors(p[0], p[1], p[2], c[0], c[1], c[2]);
        self.render_triangle_colors(p[2], p[1], p[3], c[2], c[1], c[3]);
    }

    /// `MultisampleCase::renderQuad(Vec2 x4, Vec4)` - single colour.
    fn render_quad(&self, p: [[f32; 2]; 4], color: [f32; 4]) {
        self.render_quad_colors(p, [color, color, color, color]);
    }

    /// `MultisampleCase::renderLine`
    fn render_line(&self, p0: [f32; 2], p1: [f32; 2], color: [f32; 4]) {
        let positions: [f32; 8] = [p0[0], p0[1], 0.0, 1.0, p1[0], p1[1], 0.0, 1.0];
        let colors: [f32; 8] = std::array::from_fn(|i| color[i % 4]);

        // SAFETY: as `render_triangle` above, for 2 vertices.
        unsafe {
            self.gl.enable_vertex_attrib_array(self.attr_position_loc);
            self.gl.vertex_attrib_pointer(
                self.attr_position_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                positions.as_ptr().cast(),
            );
            self.gl.enable_vertex_attrib_array(self.attr_color_loc);
            self.gl.vertex_attrib_pointer(
                self.attr_color_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                colors.as_ptr().cast(),
            );
            self.gl.use_program(self.program.program());
            self.gl.draw_arrays(glw::GL_LINES, 0, 2);
        }
    }

    /// `MultisampleCase::readImage`
    fn read_image(&self, context: &Context, dst: &mut Surface) -> Result<(), TestError> {
        if let Some(fbo) = &self.fbo {
            // SAFETY: `resolve_fbo`/`ms_fbo` are this harness's own, still alive.
            unsafe {
                self.gl
                    .bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo.resolve_fbo.get());
                self.gl.blit_framebuffer(
                    0,
                    0,
                    self.render_width,
                    self.render_height,
                    0,
                    0,
                    self.render_width,
                    self.render_height,
                    glw::GL_COLOR_BUFFER_BIT,
                    glw::GL_NEAREST,
                );
                self.gl
                    .bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo.resolve_fbo.get());
            }
            crate::glu::read_pixels(
                &context.render_context,
                self.viewport_x,
                self.viewport_y,
                &mut dst.get_access(),
            )?;
            // SAFETY: rebinding the still-alive ms FBO for whatever renders next.
            unsafe { self.gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.ms_fbo.get()) };
            Ok(())
        } else {
            crate::glu::read_pixels(
                &context.render_context,
                self.viewport_x,
                self.viewport_y,
                &mut dst.get_access(),
            )
        }
    }
}

/// `getIterationCount` - upstream's `--deqp-test-iteration-count` override is not threaded
/// through this port, so this is always the default.
const DEFAULT_MAX_NUM_ITERATIONS: i32 = 16;

/// `NumSamplesCase::iterate`, generalised over the two `renderPattern` overrides
/// (`render_pattern` here) - `PolygonNumSamplesCase`/`LineNumSamplesCase` differ only in
/// that closure.
fn run_num_samples_case(
    harness: &mut MultisampleHarness,
    context: &Context,
    render_pattern: impl Fn(&MultisampleHarness, i32),
) -> TestOutcome {
    let mut detected_colors: Vec<RGBA> = Vec::new();
    let required_num_distinct_colors = (harness.num_samples + 1) as usize;

    for current_iteration in 0..DEFAULT_MAX_NUM_ITERATIONS {
        harness.randomize_viewport();

        // SAFETY: plain state + a clear of the just-bound draw framebuffer.
        unsafe {
            harness.gl.clear_color(0.0, 0.0, 0.0, 1.0);
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        render_pattern(harness, current_iteration);

        let mut rendered_img = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut rendered_img)?;

        for y in 0..rendered_img.get_height() {
            if detected_colors.len() >= required_num_distinct_colors {
                break;
            }
            for x in 0..rendered_img.get_width() {
                if detected_colors.len() >= required_num_distinct_colors {
                    break;
                }
                let color = rendered_img.get_pixel(x, y);
                if !detected_colors
                    .iter()
                    .any(|&c| compare_threshold(color, c, RGBA::new(3, 3, 3, 3)))
                {
                    detected_colors.push(color);
                }
            }
        }

        if detected_colors.len() >= required_num_distinct_colors {
            return Ok(TestStatus::pass("Passed"));
        }
    }

    // Ran out of iterations without detecting enough distinct colors.
    let detected_num_samples = detected_colors.len() as i32 - 1; // One color is the background.
    if (harness.render_width >= 2048 || harness.render_height >= 2048)
        && detected_num_samples >= harness.num_samples / 2
    {
        Ok(TestStatus::new(
            TestResult::QualityWarning,
            "Measured sample count below the advertised count",
        ))
    } else {
        Ok(TestStatus::fail("Failed"))
    }
}

/// `PolygonNumSamplesCase::renderPattern`
fn render_polygon_pattern(harness: &MultisampleHarness, current_iteration: i32) {
    const NUM_TRIANGLES: i32 = 25;
    for i in 0..NUM_TRIANGLES {
        let angle0 =
            2.0 * std::f32::consts::PI * (i as f32) / (NUM_TRIANGLES as f32) + 0.001 * (current_iteration as f32);
        let angle1 = 2.0 * std::f32::consts::PI * ((i as f32) + 0.5) / (NUM_TRIANGLES as f32)
            + 0.001 * (current_iteration as f32);
        harness.render_triangle(
            [0.0, 0.0],
            [angle0.cos() * 0.95, angle0.sin() * 0.95],
            [angle1.cos() * 0.95, angle1.sin() * 0.95],
            [1.0, 1.0, 1.0, 1.0],
        );
    }
}

/// `LineNumSamplesCase::renderPattern`
fn render_line_pattern(harness: &MultisampleHarness, current_iteration: i32) {
    let num_lines = (100.0 * (harness.viewport_size as f32 / 256.0).sqrt()) as i32;
    for i in 0..num_lines {
        let angle = 2.0 * std::f32::consts::PI * (i as f32) / (num_lines as f32) + 0.001 * (current_iteration as f32);
        harness.render_line(
            [0.0, 0.0],
            [angle.cos() * 0.95, angle.sin() * 0.95],
            [1.0, 1.0, 1.0, 1.0],
        );
    }
}

struct PolygonNumSamplesCase {
    name: String,
    num_fbo_samples: i32,
}

impl TestCase for PolygonNumSamplesCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut harness = MultisampleHarness::new(
            context,
            &self.name,
            256,
            FboParams::from_num_fbo_samples(self.num_fbo_samples, false, false),
        )?;
        run_num_samples_case(&mut harness, context, render_polygon_pattern)
    }
}

struct LineNumSamplesCase {
    name: String,
    num_fbo_samples: i32,
}

impl TestCase for LineNumSamplesCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut harness = MultisampleHarness::new(
            context,
            &self.name,
            256,
            FboParams::from_num_fbo_samples(self.num_fbo_samples, false, false),
        )?;
        run_num_samples_case(&mut harness, context, render_line_pattern)
    }
}

fn min4(a: i32, b: i32, c: i32, d: i32) -> i32 {
    a.min(b).min(c).min(d)
}

fn max4(a: i32, b: i32, c: i32, d: i32) -> i32 {
    a.max(b).max(c).max(d)
}

/// `isInsideQuad`
fn is_inside_quad(point: [i32; 2], p0: [i32; 2], p1: [i32; 2], p2: [i32; 2], p3: [i32; 2]) -> bool {
    let dot0 = (point[0] - p0[0]) * (p1[1] - p0[1]) + (point[1] - p0[1]) * (p0[0] - p1[0]);
    let dot1 = (point[0] - p1[0]) * (p2[1] - p1[1]) + (point[1] - p1[1]) * (p1[0] - p2[0]);
    let dot2 = (point[0] - p2[0]) * (p3[1] - p2[1]) + (point[1] - p2[1]) * (p2[0] - p3[0]);
    let dot3 = (point[0] - p3[0]) * (p0[1] - p3[1]) + (point[1] - p3[1]) * (p3[0] - p0[0]);
    (dot0 > 0) == (dot1 > 0) && (dot1 > 0) == (dot2 > 0) && (dot2 > 0) == (dot3 > 0)
}

/// `isPixelRegionUnicolored` - upstream also builds an error-mask image for its test log;
/// there is no image log here (see `tcuImageCompare`'s own port note elsewhere in this
/// campaign), so this only returns the verdict `drawUnicolorTestErrors` would have driven.
fn is_pixel_region_unicolored(img: &Surface, p0: [i32; 2], p1: [i32; 2], p2: [i32; 2], p3: [i32; 2]) -> bool {
    let x_min = min4(p0[0], p1[0], p2[0], p3[0]).clamp(0, img.get_width() - 1);
    let y_min = min4(p0[1], p1[1], p2[1], p3[1]).clamp(0, img.get_height() - 1);
    let x_max = max4(p0[0], p1[0], p2[0], p3[0]).clamp(0, img.get_width() - 1);
    let y_max = max4(p0[1], p1[1], p2[1], p3[1]).clamp(0, img.get_height() - 1);
    let mut inside_encountered = false;
    let mut inside_color = RGBA::black();

    for y in y_min..=y_max {
        for x in x_min..=x_max {
            if is_inside_quad([x, y], p0, p1, p2, p3) {
                let pix_color = img.get_pixel(x, y);
                if inside_encountered {
                    if !compare_threshold(pix_color, inside_color, RGBA::new(3, 3, 3, 3)) {
                        return false;
                    }
                } else {
                    inside_encountered = true;
                    inside_color = pix_color;
                }
            }
        }
    }
    true
}

/// `((region_point + 1.0f) * 0.5f * (float)(viewportSize - 1) + 0.5f).asInt()` - every
/// value this is called with is non-negative, so the truncation `as i32` performs matches
/// `asInt()`'s `static_cast<int>`.
fn to_window(p: [f32; 2], viewport_size: i32) -> [i32; 2] {
    let scale = 0.5 * (viewport_size - 1) as f32;
    [((p[0] + 1.0) * scale + 0.5) as i32, ((p[1] + 1.0) * scale + 0.5) as i32]
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CommonEdgeCaseType {
    SmallQuads,
    BiggerThanViewportQuad,
    FitViewportQuad,
}

const DEFAULT_SMALL_QUADS_ITERATIONS: i32 = 16;
const DEFAULT_BIGGER_THAN_VIEWPORT_QUAD_ITERATIONS: i32 = 8 * 8;

/// `CommonEdgeCase`
struct CommonEdgeCase {
    name: String,
    case_type: CommonEdgeCaseType,
    num_fbo_samples: i32,
}

impl TestCase for CommonEdgeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let desired_viewport_size = if self.case_type == CommonEdgeCaseType::SmallQuads {
            128
        } else {
            32
        };
        let num_iterations = match self.case_type {
            CommonEdgeCaseType::SmallQuads => DEFAULT_SMALL_QUADS_ITERATIONS,
            CommonEdgeCaseType::BiggerThanViewportQuad => DEFAULT_BIGGER_THAN_VIEWPORT_QUAD_ITERATIONS,
            // \note With CASETYPE_FIT_VIEWPORT_QUAD, we don't do rotations other than
            // multiples of 90 deg -> constant number of iterations.
            CommonEdgeCaseType::FitViewportQuad => 8,
        };
        let mut harness = MultisampleHarness::new(
            context,
            &self.name,
            desired_viewport_size,
            FboParams::from_num_fbo_samples(self.num_fbo_samples, false, false),
        )?;

        if self.case_type == CommonEdgeCaseType::SmallQuads {
            const MIN_VIEWPORT_SIZE: i32 = 32;
            if harness.viewport_size < MIN_VIEWPORT_SIZE {
                return Err(TestError::InternalError(format!(
                    "Render target width or height too low (is {}, should be at least {MIN_VIEWPORT_SIZE})",
                    harness.viewport_size
                )));
            }
        }

        // SAFETY: plain state, no pointers involved.
        unsafe {
            harness.gl.enable(glw::GL_BLEND);
            harness.gl.blend_equation(glw::GL_FUNC_ADD);
            harness.gl.blend_func(glw::GL_ONE, glw::GL_ONE);
        }

        const GREY: [f32; 4] = [0.5, 0.5, 0.5, 1.0];

        for current_iteration in 0..num_iterations {
            harness.randomize_viewport();
            // SAFETY: plain state + a clear of the just-bound draw framebuffer.
            unsafe {
                harness.gl.clear_color(0.0, 0.0, 0.0, 1.0);
                harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            let mut regions: Vec<[[f32; 2]; 4]> = Vec::new();

            match self.case_type {
                CommonEdgeCaseType::SmallQuads => {
                    // \note Fit 3 quads in both x and y directions.
                    let quad_diag_len = 2.0 / 3.0 * 0.9;
                    let (angle_cos, angle_sin) = if current_iteration == 0 {
                        (1.0, 0.0)
                    } else if current_iteration == 1 {
                        (SQRT_HALF, SQRT_HALF)
                    } else {
                        let angle =
                            0.5 * std::f32::consts::PI * (current_iteration - 1) as f32 / (num_iterations - 1) as f32;
                        (angle.cos(), angle.sin())
                    };
                    let corners: [[f32; 2]; 4] = [
                        [0.5 * quad_diag_len * angle_cos, 0.5 * quad_diag_len * angle_sin],
                        [0.5 * quad_diag_len * -angle_sin, 0.5 * quad_diag_len * angle_cos],
                        [0.5 * quad_diag_len * -angle_cos, 0.5 * quad_diag_len * -angle_sin],
                        [0.5 * quad_diag_len * angle_sin, 0.5 * quad_diag_len * -angle_cos],
                    ];

                    // Draw 8 quads. First four are rotated at angles angle+0, angle+90,
                    // angle+180 and angle+270. Last four are rotated the same angles as
                    // the first four, but the ordering of the last triangle's vertices is
                    // reversed.
                    for quad_ndx in 0..8usize {
                        let center = [
                            (2.0 - quad_diag_len) * (quad_ndx % 3) as f32 / 2.0 - 0.5 * (2.0 - quad_diag_len),
                            (2.0 - quad_diag_len) * (quad_ndx / 3) as f32 / 2.0 - 0.5 * (2.0 - quad_diag_len),
                        ];
                        let add_center = |p: [f32; 2]| [p[0] + center[0], p[1] + center[1]];
                        let c0 = add_center(corners[quad_ndx % 4]);
                        let c1 = add_center(corners[(1 + quad_ndx) % 4]);
                        let c2 = add_center(corners[(2 + quad_ndx) % 4]);
                        let c3 = add_center(corners[(3 + quad_ndx) % 4]);

                        harness.render_triangle(c0, c1, c2, GREY);
                        if quad_ndx >= 4 {
                            harness.render_triangle(c3, c2, c0, GREY);
                        } else {
                            harness.render_triangle(c0, c2, c3, GREY);
                        }

                        // The size of the "interior" of a quad is assumed to be
                        // approximately unicolorRegionScale*<actual size of quad>.
                        let unicolor_region_scale = 1.0 - 6.0 * 2.0 / harness.viewport_size as f32 / quad_diag_len;
                        let scaled = |p: [f32; 2]| {
                            [
                                center[0] + p[0] * unicolor_region_scale,
                                center[1] + p[1] * unicolor_region_scale,
                            ]
                        };
                        regions.push([
                            scaled(corners[0]),
                            scaled(corners[1]),
                            scaled(corners[2]),
                            scaled(corners[3]),
                        ]);
                    }
                }
                CommonEdgeCaseType::BiggerThanViewportQuad => {
                    let quad_base_angle_ndx = current_iteration / 8;
                    let quad_sub_angle_ndx = (current_iteration % 8) as usize;
                    let (angle_cos, angle_sin) = if quad_base_angle_ndx == 0 {
                        (1.0, 0.0)
                    } else if quad_base_angle_ndx == 1 {
                        (SQRT_HALF, SQRT_HALF)
                    } else {
                        let angle =
                            0.5 * std::f32::consts::PI * (current_iteration - 1) as f32 / (num_iterations - 1) as f32;
                        (angle.cos(), angle.sin())
                    };
                    let quad_diag_len = 2.5 / angle_cos.max(angle_sin);
                    let corners: [[f32; 2]; 4] = [
                        [0.5 * quad_diag_len * angle_cos, 0.5 * quad_diag_len * angle_sin],
                        [0.5 * quad_diag_len * -angle_sin, 0.5 * quad_diag_len * angle_cos],
                        [0.5 * quad_diag_len * -angle_cos, 0.5 * quad_diag_len * -angle_sin],
                        [0.5 * quad_diag_len * angle_sin, 0.5 * quad_diag_len * -angle_cos],
                    ];

                    let c0 = corners[quad_sub_angle_ndx % 4];
                    let c1 = corners[(1 + quad_sub_angle_ndx) % 4];
                    let c2 = corners[(2 + quad_sub_angle_ndx) % 4];
                    let c3 = corners[(3 + quad_sub_angle_ndx) % 4];

                    harness.render_triangle(c0, c1, c2, GREY);
                    if quad_sub_angle_ndx >= 4 {
                        harness.render_triangle(c3, c2, c0, GREY);
                    } else {
                        harness.render_triangle(c0, c2, c3, GREY);
                    }

                    let scale = 1.0 - 6.0 * 2.0 / harness.viewport_size as f32 / quad_diag_len;
                    regions.push([
                        [corners[0][0] * scale, corners[0][1] * scale],
                        [corners[1][0] * scale, corners[1][1] * scale],
                        [corners[2][0] * scale, corners[2][1] * scale],
                        [corners[3][0] * scale, corners[3][1] * scale],
                    ]);
                }
                CommonEdgeCaseType::FitViewportQuad => {
                    let quad_sub_angle_ndx = (current_iteration % 8) as usize;
                    let corners: [[f32; 2]; 4] = [[1.0, 1.0], [-1.0, 1.0], [-1.0, -1.0], [1.0, -1.0]];

                    let c0 = corners[quad_sub_angle_ndx % 4];
                    let c1 = corners[(1 + quad_sub_angle_ndx) % 4];
                    let c2 = corners[(2 + quad_sub_angle_ndx) % 4];
                    let c3 = corners[(3 + quad_sub_angle_ndx) % 4];

                    harness.render_triangle(c0, c1, c2, GREY);
                    if quad_sub_angle_ndx >= 4 {
                        harness.render_triangle(c3, c2, c0, GREY);
                    } else {
                        harness.render_triangle(c0, c2, c3, GREY);
                    }

                    regions.push(corners);
                }
            }

            let mut rendered_img = Surface::new(harness.viewport_size, harness.viewport_size);
            harness.read_image(context, &mut rendered_img)?;

            let mut errors_detected = false;
            for region in &regions {
                let p = region.map(|v| to_window(v, harness.viewport_size));
                if !is_pixel_region_unicolored(&rendered_img, p[0], p[1], p[2], p[3]) {
                    errors_detected = true;
                }
            }

            if errors_detected {
                return Ok(TestStatus::fail("Failed"));
            }
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `SampleDepthCase::renderPattern` - re-clears with `GL_DEPTH_BUFFER_BIT` on top of every
/// call, on top of whatever `run_num_samples_case`'s own colour-only clear already did -
/// upstream does the exact same double clear, so this keeps that shape rather than
/// "optimising" it away.
fn render_depth_pattern(harness: &MultisampleHarness, current_iteration: i32) {
    // SAFETY: plain state.
    unsafe {
        harness.gl.clear_color(0.0, 0.0, 0.0, 0.0);
        harness.gl.clear_depthf(1.0);
        harness.gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
    }

    const NUM_POLYGONS: i32 = 50;
    for i in 0..NUM_POLYGONS {
        let color = if i % 2 == 0 {
            [1.0, 1.0, 1.0, 1.0]
        } else {
            [0.0, 0.0, 0.0, 1.0]
        };
        let angle = 2.0 * std::f32::consts::PI * i as f32 / NUM_POLYGONS as f32 + 0.001 * current_iteration as f32;
        let two_thirds_pi = 2.0 * std::f32::consts::PI / 3.0;
        let pt0 = [3.0 * angle.cos(), 3.0 * angle.sin(), 1.0];
        let pt1 = [
            3.0 * (angle + two_thirds_pi).cos(),
            3.0 * (angle + two_thirds_pi).sin(),
            0.0,
        ];
        let pt2 = [
            3.0 * (angle + 2.0 * two_thirds_pi).cos(),
            3.0 * (angle + 2.0 * two_thirds_pi).sin(),
            0.0,
        ];
        harness.render_triangle3(pt0, pt1, pt2, [color, color, color]);
    }
}

/// `SampleDepthCase`
struct SampleDepthCase {
    name: String,
    num_fbo_samples: i32,
}

impl TestCase for SampleDepthCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        if context.render_target().depth_bits == 0 {
            return Err(TestError::NotSupported("Test requires depth buffer".to_string()));
        }

        let mut harness = MultisampleHarness::new(
            context,
            &self.name,
            256,
            FboParams::from_num_fbo_samples(self.num_fbo_samples, true, false),
        )?;
        // SAFETY: plain state.
        unsafe {
            harness.gl.enable(glw::GL_DEPTH_TEST);
            harness.gl.depth_func(glw::GL_LESS);
        }
        run_num_samples_case(&mut harness, context, render_depth_pattern)
    }
}

/// `SampleStencilCase`
struct SampleStencilCase {
    name: String,
    num_fbo_samples: i32,
}

impl TestCase for SampleStencilCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        if context.render_target().stencil_bits == 0 {
            return Err(TestError::NotSupported("Test requires stencil buffer".to_string()));
        }

        let mut harness = MultisampleHarness::new(
            context,
            &self.name,
            256,
            FboParams::from_num_fbo_samples(self.num_fbo_samples, false, true),
        )?;
        harness.randomize_viewport();

        // SAFETY: plain state.
        unsafe {
            harness.gl.clear_color(0.0, 0.0, 0.0, 1.0);
            harness.gl.clear_stencil(0);
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            harness.gl.enable(glw::GL_STENCIL_TEST);
            harness.gl.stencil_func(glw::GL_ALWAYS, 1, 1);
            harness.gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_REPLACE);
        }

        const NUM_TRIANGLES: i32 = 25;
        for i in 0..NUM_TRIANGLES {
            let angle0 = 2.0 * std::f32::consts::PI * i as f32 / NUM_TRIANGLES as f32;
            let angle1 = 2.0 * std::f32::consts::PI * (i as f32 + 0.5) / NUM_TRIANGLES as f32;
            harness.render_triangle(
                [0.0, 0.0],
                [angle0.cos() * 0.95, angle0.sin() * 0.95],
                [angle1.cos() * 0.95, angle1.sin() * 0.95],
                [1.0, 1.0, 1.0, 1.0],
            );
        }

        let mut rendered_first = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut rendered_first)?;

        // SAFETY: plain state.
        unsafe {
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
            harness.gl.stencil_func(glw::GL_EQUAL, 1, 1);
            harness.gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);
        }

        {
            let mut cleared_img = Surface::new(harness.viewport_size, harness.viewport_size);
            harness.read_image(context, &mut cleared_img)?;
            for y in 0..cleared_img.get_height() {
                for x in 0..cleared_img.get_width() {
                    if cleared_img.get_pixel(x, y) != RGBA::black() {
                        return Ok(TestStatus::fail("Failed"));
                    }
                }
            }
        }

        harness.render_quad(
            [[-1.0, -1.0], [1.0, -1.0], [-1.0, 1.0], [1.0, 1.0]],
            [1.0, 1.0, 1.0, 1.0],
        );

        let mut rendered_second = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut rendered_second)?;

        let result = pixel_threshold_compare(&rendered_first, &rendered_second, RGBA::new(0, 0, 0, 0));
        Ok(if result.ok {
            TestStatus::pass("Passed")
        } else {
            TestStatus::fail("Failed")
        })
    }
}

/// `CoverageMaskInvertCase`
struct CoverageMaskInvertCase {
    name: String,
    num_fbo_samples: i32,
}

impl CoverageMaskInvertCase {
    /// `CoverageMaskInvertCase::drawPattern`
    fn draw_pattern(harness: &MultisampleHarness, invert_sample_coverage: bool) {
        const NUM_TRIANGLES: i32 = 25;
        for i in 0..NUM_TRIANGLES {
            // SAFETY: takes plain floats/an enum-like boolean.
            unsafe {
                harness.gl.sample_coverage(
                    i as f32 / (NUM_TRIANGLES - 1) as f32,
                    if invert_sample_coverage { glw::TRUE } else { glw::FALSE },
                );
            }

            let angle0 = 2.0 * std::f32::consts::PI * i as f32 / NUM_TRIANGLES as f32;
            let angle1 = 2.0 * std::f32::consts::PI * (i as f32 + 0.5) / NUM_TRIANGLES as f32;
            let t = i as f32 / NUM_TRIANGLES as f32;
            harness.render_triangle(
                [0.0, 0.0],
                [angle0.cos() * 0.95, angle0.sin() * 0.95],
                [angle1.cos() * 0.95, angle1.sin() * 0.95],
                [0.4 + t * 0.6, 0.5 + t * 0.3, 0.6 - t * 0.5, 0.7 - t * 0.7],
            );
        }
    }
}

impl TestCase for CoverageMaskInvertCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut harness = MultisampleHarness::new(
            context,
            &self.name,
            256,
            FboParams::from_num_fbo_samples(self.num_fbo_samples, false, false),
        )?;
        harness.randomize_viewport();

        // SAFETY: plain state.
        unsafe {
            harness.gl.enable(glw::GL_BLEND);
            harness.gl.blend_equation(glw::GL_FUNC_ADD);
            harness.gl.blend_func(glw::GL_ONE, glw::GL_ONE);

            harness.gl.clear_color(0.0, 0.0, 0.0, 0.0);
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        Self::draw_pattern(&harness, false);
        let mut no_sample_coverage_img = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut no_sample_coverage_img)?;

        // SAFETY: plain state.
        unsafe {
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
            harness.gl.enable(glw::GL_SAMPLE_COVERAGE);
        }
        Self::draw_pattern(&harness, false);
        Self::draw_pattern(&harness, true);
        let mut sample_coverage_img = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut sample_coverage_img)?;

        let result = pixel_threshold_compare(&no_sample_coverage_img, &sample_coverage_img, RGBA::new(0, 0, 0, 0));
        Ok(if result.ok {
            TestStatus::pass("Passed")
        } else {
            TestStatus::fail("Failed")
        })
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum MaskProportionalityType {
    AlphaToCoverage,
    SampleCoverage,
    SampleCoverageInverted,
}

/// `MaskProportionalityCase`
struct MaskProportionalityCase {
    name: String,
    prop_type: MaskProportionalityType,
    num_fbo_samples: i32,
}

impl TestCase for MaskProportionalityCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut harness = MultisampleHarness::new(
            context,
            &self.name,
            32,
            FboParams::from_num_fbo_samples(self.num_fbo_samples, false, false),
        )?;

        // SAFETY: plain state.
        unsafe {
            if self.prop_type == MaskProportionalityType::AlphaToCoverage {
                harness.gl.enable(glw::GL_SAMPLE_ALPHA_TO_COVERAGE);
            } else {
                harness.gl.enable(glw::GL_SAMPLE_COVERAGE);
            }
        }

        let num_iterations = (harness.num_samples * 5).max(2);
        // \note Using the same viewport for every iteration since coverage mask may
        // depend on window-relative pixel coordinate.
        harness.randomize_viewport();

        let mut previous_iteration_color_sum: i64 = -1;

        for current_iteration in 0..num_iterations {
            let num_pixels = harness.viewport_size as i64 * harness.viewport_size as i64;

            // SAFETY: plain state.
            unsafe {
                harness.gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::TRUE);
                harness.gl.clear_color(0.0, 0.0, 0.0, 1.0);
                harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            if self.prop_type == MaskProportionalityType::AlphaToCoverage {
                // SAFETY: plain state.
                unsafe { harness.gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::FALSE) };
            }

            let alpha_or_coverage_value = current_iteration as f32 / (num_iterations - 1) as f32;
            let mut quad_color = [1.0f32, 0.0, 0.0, 1.0];

            match self.prop_type {
                MaskProportionalityType::AlphaToCoverage => quad_color[3] = alpha_or_coverage_value,
                MaskProportionalityType::SampleCoverage | MaskProportionalityType::SampleCoverageInverted => {
                    let is_inverted = self.prop_type == MaskProportionalityType::SampleCoverageInverted;
                    let coverage_value = if is_inverted {
                        1.0 - alpha_or_coverage_value
                    } else {
                        alpha_or_coverage_value
                    };
                    // SAFETY: takes plain floats/an enum-like boolean.
                    unsafe {
                        harness
                            .gl
                            .sample_coverage(coverage_value, if is_inverted { glw::TRUE } else { glw::FALSE })
                    };
                }
            }

            harness.render_quad([[-1.0, -1.0], [1.0, -1.0], [-1.0, 1.0], [1.0, 1.0]], quad_color);

            let mut rendered_img = Surface::new(harness.viewport_size, harness.viewport_size);
            harness.read_image(context, &mut rendered_img)?;

            let mut sum_red: i64 = 0;
            for y in 0..rendered_img.get_height() {
                for x in 0..rendered_img.get_width() {
                    sum_red += rendered_img.get_pixel(x, y).get_red() as i64;
                }
            }

            if sum_red < previous_iteration_color_sum {
                return Ok(TestStatus::fail("Failed"));
            }

            if current_iteration == 0 && sum_red != 0 {
                return Ok(TestStatus::fail("Failed"));
            }

            if current_iteration == num_iterations - 1 && sum_red != 0xff * num_pixels {
                return Ok(TestStatus::fail("Failed"));
            }

            previous_iteration_color_sum = sum_red;
        }

        Ok(TestStatus::pass("Passed"))
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum MaskConstancyType {
    AlphaToCoverage,
    SampleCoverage,
    SampleCoverageInverted,
    Both,
    BothInverted,
}

impl MaskConstancyType {
    fn is_alpha_to_coverage(self) -> bool {
        matches!(self, Self::AlphaToCoverage | Self::Both | Self::BothInverted)
    }

    fn is_sample_coverage(self) -> bool {
        matches!(
            self,
            Self::SampleCoverage | Self::SampleCoverageInverted | Self::Both | Self::BothInverted
        )
    }

    fn is_inverted_sample_coverage(self) -> bool {
        matches!(self, Self::SampleCoverageInverted | Self::BothInverted)
    }
}

/// `MaskConstancyCase`
struct MaskConstancyCase {
    name: String,
    constancy_type: MaskConstancyType,
    num_fbo_samples: i32,
}

impl TestCase for MaskConstancyCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut harness = MultisampleHarness::new(
            context,
            &self.name,
            256,
            FboParams::from_num_fbo_samples(self.num_fbo_samples, false, false),
        )?;
        harness.randomize_viewport();

        // SAFETY: plain state.
        unsafe {
            harness.gl.clear_color(0.0, 0.0, 0.0, 1.0);
            harness.gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }

        let is_alpha_to_coverage = self.constancy_type.is_alpha_to_coverage();
        let is_sample_coverage = self.constancy_type.is_sample_coverage();
        let is_inverted_sample_coverage = self.constancy_type.is_inverted_sample_coverage();

        // SAFETY: plain state.
        unsafe {
            if is_alpha_to_coverage {
                harness.gl.enable(glw::GL_SAMPLE_ALPHA_TO_COVERAGE);
                harness.gl.color_mask(glw::TRUE, glw::TRUE, glw::TRUE, glw::FALSE);
            }
            if is_sample_coverage {
                harness.gl.enable(glw::GL_SAMPLE_COVERAGE);
            }
        }

        let num_quad_rows_cols = harness.num_samples * 4;

        for row in 0..num_quad_rows_cols {
            for col in 0..num_quad_rows_cols {
                let x0 = col as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let x1 = (col + 1) as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let y0 = row as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;
                let y1 = (row + 1) as f32 / num_quad_rows_cols as f32 * 2.0 - 1.0;

                let base_green = [0.0, 1.0, 0.0, 0.0];
                let base_red = [1.0, 0.0, 0.0, 0.0];
                let alpha0_w = if is_alpha_to_coverage {
                    col as f32 / (num_quad_rows_cols - 1) as f32
                } else {
                    1.0
                };
                let alpha1_w = if is_alpha_to_coverage {
                    row as f32 / (num_quad_rows_cols - 1) as f32
                } else {
                    1.0
                };
                let alpha0 = [0.0, 0.0, 0.0, alpha0_w];
                let alpha1 = [0.0, 0.0, 0.0, alpha1_w];

                if is_sample_coverage {
                    let value =
                        (row * num_quad_rows_cols + col) as f32 / (num_quad_rows_cols * num_quad_rows_cols - 1) as f32;
                    let coverage = if is_inverted_sample_coverage {
                        1.0 - value
                    } else {
                        value
                    };
                    // SAFETY: takes plain floats/an enum-like boolean.
                    unsafe {
                        harness.gl.sample_coverage(
                            coverage,
                            if is_inverted_sample_coverage {
                                glw::TRUE
                            } else {
                                glw::FALSE
                            },
                        )
                    };
                }

                let add = |a: [f32; 4], b: [f32; 4]| [a[0] + b[0], a[1] + b[1], a[2] + b[2], a[3] + b[3]];
                let quad_p = [[x0, y0], [x1, y0], [x0, y1], [x1, y1]];
                harness.render_quad_colors(
                    quad_p,
                    [
                        add(base_green, alpha0),
                        add(base_green, alpha1),
                        add(base_green, alpha0),
                        add(base_green, alpha1),
                    ],
                );
                harness.render_quad_colors(
                    quad_p,
                    [
                        add(base_red, alpha0),
                        add(base_red, alpha1),
                        add(base_red, alpha0),
                        add(base_red, alpha1),
                    ],
                );
            }
        }

        let mut rendered_img = Surface::new(harness.viewport_size, harness.viewport_size);
        harness.read_image(context, &mut rendered_img)?;

        for y in 0..rendered_img.get_height() {
            for x in 0..rendered_img.get_width() {
                if rendered_img.get_pixel(x, y).get_green() > 0 {
                    return Ok(TestStatus::fail("Failed"));
                }
            }
        }

        Ok(TestStatus::pass("Passed"))
    }
}

/// `MultisampleTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multisample");

    const CASE_TYPES: [(&str, i32); 4] = [
        ("default_framebuffer", -1),
        ("fbo_4_samples", 4),
        ("fbo_8_samples", 8),
        ("fbo_max_samples", 0),
    ];

    for (group_name, num_fbo_samples) in CASE_TYPES {
        let mut sub_group = TestCaseGroup::new(group_name);
        sub_group.add_child(Box::new(PolygonNumSamplesCase {
            name: "num_samples_polygon".to_string(),
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(LineNumSamplesCase {
            name: "num_samples_line".to_string(),
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(CommonEdgeCase {
            name: "common_edge_small_quads".to_string(),
            case_type: CommonEdgeCaseType::SmallQuads,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(CommonEdgeCase {
            name: "common_edge_big_quad".to_string(),
            case_type: CommonEdgeCaseType::BiggerThanViewportQuad,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(CommonEdgeCase {
            name: "common_edge_viewport_quad".to_string(),
            case_type: CommonEdgeCaseType::FitViewportQuad,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(SampleDepthCase {
            name: "depth".to_string(),
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(SampleStencilCase {
            name: "stencil".to_string(),
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(CoverageMaskInvertCase {
            name: "sample_coverage_invert".to_string(),
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(MaskProportionalityCase {
            name: "proportionality_alpha_to_coverage".to_string(),
            prop_type: MaskProportionalityType::AlphaToCoverage,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(MaskProportionalityCase {
            name: "proportionality_sample_coverage".to_string(),
            prop_type: MaskProportionalityType::SampleCoverage,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(MaskProportionalityCase {
            name: "proportionality_sample_coverage_inverted".to_string(),
            prop_type: MaskProportionalityType::SampleCoverageInverted,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(MaskConstancyCase {
            name: "constancy_alpha_to_coverage".to_string(),
            constancy_type: MaskConstancyType::AlphaToCoverage,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(MaskConstancyCase {
            name: "constancy_sample_coverage".to_string(),
            constancy_type: MaskConstancyType::SampleCoverage,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(MaskConstancyCase {
            name: "constancy_sample_coverage_inverted".to_string(),
            constancy_type: MaskConstancyType::SampleCoverageInverted,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(MaskConstancyCase {
            name: "constancy_both".to_string(),
            constancy_type: MaskConstancyType::Both,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        sub_group.add_child(Box::new(MaskConstancyCase {
            name: "constancy_both_inverted".to_string(),
            constancy_type: MaskConstancyType::BothInverted,
            num_fbo_samples,
        }) as Box<dyn TestCase>);
        group.add_child(sub_group);
    }

    group
}
