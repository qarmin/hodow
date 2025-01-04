// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fRasterizationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, **`primitives.{triangles,
// triangle_strip,triangle_fan,points,lines,line_strip,line_loop,lines_wide,
// line_strip_wide,line_loop_wide}`, `limits.points`, `fill_rules.*`, `culling.*` and
// `interpolation.{basic,projected}.{triangles,triangle_strip,triangle_fan,lines,
// line_strip,line_loop,lines_wide,line_strip_wide,line_loop_wide}` only** - the
// triangle/point/line-rasterization slice of the group, plus triangle and line (narrow
// and wide) colour interpolation. Unlike ES3's `LineInterpolationTest` (which varies the
// wide width across its 3 iterations - `5.0`/`10.0`/the queried max), ES2's own class
// takes a single fixed `lineWidth` per case instead (confirmed by reading
// `es2fRasterizationTests.cpp` directly: its `*_wide` registrations all pass a constant
// `5.0f`, matching `LineCase::WIDE_SIZE` above) - not a port inconsistency, genuinely
// different between the two files. `fbo.*` (rendering the same scenes to a
// renderbuffer/texture target instead of the default framebuffer) does not exist in the
// ES2 package upstream at all - it is ES3-only, see `gles3::functional::rasterization_tests`.
//
// `TriangleInterpolationTest` is ported with `m_flatshade` hardcoded to `false` -
// `flatshading.*` does not exist in the ES2 package either (ES3-only, see the ES3 file's
// own header on that group).
//
// Upstream re-enters `iterate` via CONTINUE/STOP once per iteration of a 2-or-3
// iteration case; here each case's `iterate` loops internally instead, which is this
// project's established convention (see e.g. `color_clear_test.rs`) and leaves GL state
// alive across iterations exactly as upstream's own re-entry does.
//
// `BaseRenderingCase`'s shader is compiled once in upstream's `init` and reused for
// every iteration of a case; `RenderHarness::new` plays that role here, built fresh at
// the top of each case's `iterate` rather than carried in a field across calls (no
// `init`/`deinit` split exists on this port's `TestCase` trait - see the
// `OcclusionQueryFboDeleteCase` convention note for the same shape elsewhere).

use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, expect_no_error, read_pixels};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::rasterization_verifier::{
    LineInterpolationMethod, LineSceneSpec, PointSceneSpec, RasterizationArguments, SceneLine, ScenePoint,
    SceneTriangle, TriangleSceneSpec, VerificationMode, verify_line_group_interpolation,
    verify_line_group_rasterization, verify_point_group_rasterization, verify_triangle_group_interpolation,
    verify_triangle_group_rasterization,
};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::rgba::compare_threshold;
use crate::tcu::{RGBA, Random, Surface, TestError, TestOutcome, TestResult, TestStatus, Vec4};

const VERTEX_SOURCE: &str = concat!(
    "attribute highp vec4 a_position;\n",
    "attribute highp vec4 a_color;\n",
    "varying highp vec4 v_color;\n",
    "uniform highp float u_pointSize;\n",
    "void main ()\n",
    "{\n",
    "    gl_Position = a_position;\n",
    "    gl_PointSize = u_pointSize;\n",
    "    v_color = a_color;\n",
    "}\n"
);
const FRAGMENT_SOURCE: &str = concat!(
    "varying mediump vec4 v_color;\n",
    "void main ()\n",
    "{\n",
    "    gl_FragColor = v_color;\n",
    "}\n"
);

/// `BaseRenderingCase`, covering the triangle/point/line-drawing path this port needs.
struct RenderHarness<'gl> {
    shader: ShaderProgram<'gl>,
    position_loc: GLint,
    color_loc: GLint,
    point_size_loc: GLint,
    render_size: i32,
    num_samples: i32,
    subpixel_bits: i32,
}

impl<'gl> RenderHarness<'gl> {
    /// `BaseRenderingCase::init`.
    fn new(context: &'gl Context, render_size: i32) -> Result<Self, TestError> {
        let render_target = context.render_target();
        if render_target.width < render_size || render_target.height < render_size {
            return Err(TestError::NotSupported(format!(
                "Render target size must be at least {render_size}x{render_size}"
            )));
        }

        let gl = context.gl();
        let shader = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SOURCE, FRAGMENT_SOURCE));
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

        Ok(Self {
            shader,
            position_loc,
            color_loc,
            point_size_loc,
            render_size,
            num_samples: render_target.num_samples,
            subpixel_bits,
        })
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
        read_pixels(&context.render_context, 0, 0, &mut result.get_access())?;
        Ok(result)
    }

    fn rasterization_args(&self, context: &Context) -> RasterizationArguments {
        let pf = context.render_target().pixel_format();
        RasterizationArguments {
            num_samples: self.num_samples,
            subpixel_bits: self.subpixel_bits,
            red_bits: pf.red_bits,
            green_bits: pf.green_bits,
            blue_bits: pf.blue_bits,
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
}

impl TestCase for TriangleCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let harness = RenderHarness::new(context, 256)?;
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

/// `TrianglesCase::generateTriangles`
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

/// `TriangleStripCase::generateTriangles`
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

/// `TriangleFanCase::generateTriangles`
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

/// `TriangleInterpolationTest`, restricted to `m_flatshade = false` (`basic`/`projected`
/// only - `flatshading.*` reuses this same class with `m_flatshade = true` and is not
/// ported, see the module header).
struct TriangleInterpolationCase {
    name: &'static str,
    primitive_type: GLenum,
    projective: bool,
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

    /// `TriangleInterpolationTest::extractTriangles`
    fn extract_triangles(&self, vertices: &[Vec4], colors: &[Vec4]) -> Vec<SceneTriangle> {
        let mut out = Vec::new();
        if self.primitive_type == glw::GL_TRIANGLES {
            let mut vtx_ndx = 0;
            while vtx_ndx + 2 < vertices.len() {
                out.push(SceneTriangle::with_colors(
                    vertices[vtx_ndx],
                    vertices[vtx_ndx + 1],
                    vertices[vtx_ndx + 2],
                    colors[vtx_ndx],
                    colors[vtx_ndx + 1],
                    colors[vtx_ndx + 2],
                ));
                vtx_ndx += 3;
            }
        } else if self.primitive_type == glw::GL_TRIANGLE_STRIP {
            for vtx_ndx in 0..vertices.len().saturating_sub(2) {
                out.push(SceneTriangle::with_colors(
                    vertices[vtx_ndx],
                    vertices[vtx_ndx + 1],
                    vertices[vtx_ndx + 2],
                    colors[vtx_ndx],
                    colors[vtx_ndx + 1],
                    colors[vtx_ndx + 2],
                ));
            }
        } else if self.primitive_type == glw::GL_TRIANGLE_FAN {
            for vtx_ndx in 1..vertices.len().saturating_sub(1) {
                out.push(SceneTriangle::with_colors(
                    vertices[0],
                    vertices[vtx_ndx],
                    vertices[vtx_ndx + 1],
                    colors[0],
                    colors[vtx_ndx],
                    colors[vtx_ndx + 1],
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
        let harness = RenderHarness::new(context, 256)?;
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

/// `FillRuleCase` - needs no `tcu::rasterization_verifier` call at all: it draws grey,
/// additively-blended triangles sharing edges and checks the result never exceeds the
/// single-triangle grey (any brighter pixel is two triangles double-covering it), plus
/// (for the full-viewport variant only) that no pixel stays at the black background.
struct FillRuleCase {
    name: &'static str,
    case_type: FillRuleCaseType,
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
        let harness = RenderHarness::new(context, render_size)?;
        let iteration_count = self.num_iterations();
        let pf = context.render_target().pixel_format();
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
/// `PRIMITIVEWIDENESS_WIDE` upstream (`main.cpp`'s own `RasterizationTests::init`,
/// confirmed by reading the file - there is no narrow `points` case in the mustpass).
struct PointCase;

impl PointCase {
    const WIDE_SIZE: f32 = 10.0;

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
        let harness = RenderHarness::new(context, 256)?;
        let args = harness.rasterization_args(context);

        let gl = context.gl();
        let mut range = [0.0f32; 2];
        // SAFETY: one query, two GLfloats of output.
        unsafe { gl.get_floatv(glw::GL_ALIASED_POINT_SIZE_RANGE, range.as_mut_ptr()) };
        if Self::WIDE_SIZE < range[0] || Self::WIDE_SIZE > range[1] {
            return Err(TestError::NotSupported(format!(
                "Support for point size {} is required.",
                Self::WIDE_SIZE
            )));
        }

        for iteration in 0..3 {
            // last iteration, max out size
            let point_size = if iteration == 2 { range[1] } else { Self::WIDE_SIZE };
            let (draw_buffer, points) = Self::generate_points(iteration, point_size);
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

/// `PointSizeClampedTest` - tests that `gl_PointSize` is clamped, before rasterization,
/// to `GL_ALIASED_POINT_SIZE_RANGE`. Self-contained: no `tcu::rasterization_verifier`
/// call at all, a dedicated renderbuffer FBO and a direct pixel comparison against green.
struct PointSizeClampedTest;

impl TestCase for PointSizeClampedTest {
    fn name(&self) -> &str {
        "points"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let harness = RenderHarness::new(context, 256)?;
        let gl = context.gl();

        const FBO_HEIGHT: i32 = 4;
        const TEST_AREA_WIDTH: i32 = 4;
        const TEST_AREA_WIDTH_WITH_MARGIN: i32 = TEST_AREA_WIDTH + 4;
        const POINT_RADIUS_OVERAGE: f32 = 8.0;

        let mut max_renderbuffer_size: GLint = 0;
        let mut max_viewport_dims = [0 as GLint; 2];
        // SAFETY: plain integer-state queries.
        unsafe {
            gl.get_integerv(glw::GL_MAX_RENDERBUFFER_SIZE, &mut max_renderbuffer_size);
            gl.get_integerv(glw::GL_MAX_VIEWPORT_DIMS, max_viewport_dims.as_mut_ptr());
        }
        let max_fbo_width = max_renderbuffer_size.min(max_viewport_dims[0]);

        let mut point_size_range = [0.0f32; 2];
        // SAFETY: one query, two GLfloats of output.
        unsafe { gl.get_floatv(glw::GL_ALIASED_POINT_SIZE_RANGE, point_size_range.as_mut_ptr()) };
        // Typically (in the correct case), max_point_diameter is an odd integer.
        let max_point_diameter = point_size_range[1] as i32;
        // max_point_radius is inclusive of the center point.
        let max_point_radius = (max_point_diameter + 1) / 2;
        if max_point_radius > max_fbo_width - TEST_AREA_WIDTH_WITH_MARGIN {
            return Ok(TestStatus::new(
                TestResult::CompatibilityWarning,
                "max framebuffer size isn't large enough to test max point size",
            ));
        }
        let mut fbo_width = max_point_radius + TEST_AREA_WIDTH_WITH_MARGIN;
        // Round up to the nearest multiple of 2.
        fbo_width = ((fbo_width + 1) / 2) * 2;

        let point_size = (max_point_diameter as f32) + POINT_RADIUS_OVERAGE * 2.0;

        // Create a framebuffer that is (fbo_width)x(FBO_HEIGHT), cleared to green.
        let mut fbo: GLuint = 0;
        let mut rbo: GLuint = 0;
        // SAFETY: plain object creation, binding and state toggles on a current context.
        unsafe {
            gl.viewport(0, 0, fbo_width, FBO_HEIGHT);
            gl.gen_framebuffers(1, &mut fbo);
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            gl.gen_renderbuffers(1, &mut rbo);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
            gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, fbo_width, FBO_HEIGHT);
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo,
            );
        }
        let fbo_status = unsafe { gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) };
        if fbo_status != glw::GL_FRAMEBUFFER_COMPLETE {
            // SAFETY: cleanup of objects this case created itself.
            unsafe {
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                gl.delete_framebuffers(1, &fbo);
                gl.delete_renderbuffers(1, &rbo);
            }
            return Ok(TestStatus::new(
                TestResult::CompatibilityWarning,
                "couldn't complete a framebuffer suitable to test max point size",
            ));
        }
        // SAFETY: plain clear on the just-completed FBO.
        unsafe {
            gl.clear_color(0.0, 1.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT);
        }
        expect_no_error(gl, "clear max point size fbo")?;

        // Draw a red point, with size `point_size`, at the far right.
        let position = [1.0f32, 0.0, 0.0, 1.0];
        let color = [1.0f32, 0.0, 0.0, 1.0];
        // SAFETY: a single untextured point, drawn through the harness's own shader.
        unsafe {
            gl.use_program(harness.shader.program());
            gl.enable_vertex_attrib_array(harness.position_loc as GLuint);
            gl.vertex_attrib_pointer(
                harness.position_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                position.as_ptr().cast(),
            );
            gl.enable_vertex_attrib_array(harness.color_loc as GLuint);
            gl.vertex_attrib_pointer(
                harness.color_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                color.as_ptr().cast(),
            );
            gl.uniform_1f(harness.point_size_loc, point_size);
            gl.draw_arrays(glw::GL_POINTS, 0, 1);
            gl.disable_vertex_attrib_array(harness.color_loc as GLuint);
            gl.disable_vertex_attrib_array(harness.position_loc as GLuint);
            gl.use_program(0);
        }
        expect_no_error(gl, "draw clamped point size")?;

        // Test that the resulting draw leaves the test area (far from the point) green.
        let mut pixels = Surface::new(TEST_AREA_WIDTH, FBO_HEIGHT);
        let readback = read_pixels(&context.render_context, 0, 0, &mut pixels.get_access());
        // SAFETY: cleanup of objects this case created itself.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
            gl.delete_framebuffers(1, &fbo);
            gl.delete_renderbuffers(1, &rbo);
        }
        readback?;

        let threshold = RGBA::new(12, 12, 12, 12);
        let green = RGBA::new(0, 255, 0, 255);
        for y in 0..FBO_HEIGHT {
            for x in 0..TEST_AREA_WIDTH {
                let color = pixels.get_pixel(x, y);
                if !compare_threshold(color, green, threshold) {
                    return Ok(TestStatus::fail(
                        "gl_PointSize was not clamped to ALIASED_POINT_SIZE_RANGE",
                    ));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `BaseLineCase` - ES2's `m_lineWidth` is a plain fixed value (`s_wideSize` = 5.0 for
/// every iteration of the wide variant, confirmed by reading the file directly - unlike
/// `PointCase`'s own iteration-maxing, or ES3's `BaseLineCase` below).
struct LineCase {
    name: &'static str,
    primitive_type: GLenum,
    wide: bool,
    generate: fn(i32) -> (Vec<Vec4>, Vec<SceneLine>),
}

impl LineCase {
    const WIDE_SIZE: f32 = 5.0;
}

impl TestCase for LineCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let harness = RenderHarness::new(context, 256)?;
        let args = harness.rasterization_args(context);
        let line_width = if self.wide { Self::WIDE_SIZE } else { 1.0 };

        if line_width != 1.0 {
            let gl = context.gl();
            let mut range = [0.0f32; 2];
            // SAFETY: one query, two GLfloats of output.
            unsafe { gl.get_floatv(glw::GL_ALIASED_LINE_WIDTH_RANGE, range.as_mut_ptr()) };
            if line_width < range[0] || line_width > range[1] {
                return Err(TestError::NotSupported(format!(
                    "Support for line width {line_width} is required."
                )));
            }
        }

        let mut multisample_relaxation_required = false;
        for iteration in 0..3 {
            let (draw_buffer, lines) = (self.generate)(iteration);
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

/// `LinesCase::generateLines`
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

/// `LineStripCase::generateLines`
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

/// `LineLoopCase::generateLines`
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
/// `LineInterpolationTest` - ES2's own class takes a single fixed line width per case
/// (see the module header): `wide` selects `LineCase::WIDE_SIZE` (`5.0`) instead of
/// `1.0`, applied identically across all 3 iterations.
struct LineInterpolationCase {
    name: &'static str,
    primitive_type: GLenum,
    projective: bool,
    wide: bool,
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

    /// `LineInterpolationTest::extractLines`
    fn extract_lines(&self, vertices: &[Vec4], colors: &[Vec4]) -> Vec<SceneLine> {
        let mut out = Vec::new();
        if self.primitive_type == glw::GL_LINES {
            let mut vtx_ndx = 0;
            while vtx_ndx + 1 < vertices.len() {
                out.push(SceneLine::with_colors(
                    vertices[vtx_ndx],
                    vertices[vtx_ndx + 1],
                    colors[vtx_ndx],
                    colors[vtx_ndx + 1],
                ));
                vtx_ndx += 2;
            }
        } else if self.primitive_type == glw::GL_LINE_STRIP {
            for vtx_ndx in 0..vertices.len().saturating_sub(1) {
                out.push(SceneLine::with_colors(
                    vertices[vtx_ndx],
                    vertices[vtx_ndx + 1],
                    colors[vtx_ndx],
                    colors[vtx_ndx + 1],
                ));
            }
        } else if self.primitive_type == glw::GL_LINE_LOOP {
            for vtx_ndx in 0..vertices.len() {
                let next = (vtx_ndx + 1) % vertices.len();
                out.push(SceneLine::with_colors(
                    vertices[vtx_ndx],
                    vertices[next],
                    colors[vtx_ndx],
                    colors[next],
                ));
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
        let harness = RenderHarness::new(context, 256)?;
        let args = harness.rasterization_args(context);
        let mut result = ResultCollector::new("");
        let line_width = if self.wide { LineCase::WIDE_SIZE } else { 1.0 };

        if line_width != 1.0 {
            let gl = context.gl();
            let mut range = [0.0f32; 2];
            // SAFETY: one query, two GLfloats of output.
            unsafe { gl.get_floatv(glw::GL_ALIASED_LINE_WIDTH_RANGE, range.as_mut_ptr()) };
            if line_width < range[0] || line_width > range[1] {
                return Err(TestError::NotSupported(format!(
                    "Support for line width {line_width} is required."
                )));
            }
        }

        for iteration in 0..3 {
            let (vertices, colors) = self.generate_vertices(iteration);
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

pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("rasterization");

    let mut primitives = TestCaseGroup::new("primitives");
    primitives.add_child(Box::new(TriangleCase {
        name: "triangles",
        primitive_type: glw::GL_TRIANGLES,
        generate: generate_triangles,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(TriangleCase {
        name: "triangle_strip",
        primitive_type: glw::GL_TRIANGLE_STRIP,
        generate: generate_triangle_strip,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(TriangleCase {
        name: "triangle_fan",
        primitive_type: glw::GL_TRIANGLE_FAN,
        generate: generate_triangle_fan,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "lines",
        primitive_type: glw::GL_LINES,
        wide: false,
        generate: generate_lines,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "line_strip",
        primitive_type: glw::GL_LINE_STRIP,
        wide: false,
        generate: generate_line_strip,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "line_loop",
        primitive_type: glw::GL_LINE_LOOP,
        wide: false,
        generate: generate_line_loop,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "lines_wide",
        primitive_type: glw::GL_LINES,
        wide: true,
        generate: generate_lines,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "line_strip_wide",
        primitive_type: glw::GL_LINE_STRIP,
        wide: true,
        generate: generate_line_strip,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(LineCase {
        name: "line_loop_wide",
        primitive_type: glw::GL_LINE_LOOP,
        wide: true,
        generate: generate_line_loop,
    }) as Box<dyn TestCase>);
    primitives.add_child(Box::new(PointCase) as Box<dyn TestCase>);
    group.add_child(primitives);

    let mut limits = TestCaseGroup::new("limits");
    limits.add_child(Box::new(PointSizeClampedTest) as Box<dyn TestCase>);
    group.add_child(limits);

    let mut fill_rules = TestCaseGroup::new("fill_rules");
    #[rustfmt::skip]
    const FILL_RULE_CASES: &[(&str, FillRuleCaseType)] = &[
        ("basic_quad",         FillRuleCaseType::Basic),
        ("basic_quad_reverse", FillRuleCaseType::Reversed),
        ("clipped_full",       FillRuleCaseType::ClippedFull),
        ("clipped_partly",     FillRuleCaseType::ClippedPartial),
        ("projected",          FillRuleCaseType::Projected),
    ];
    for &(name, case_type) in FILL_RULE_CASES {
        fill_rules.add_child(Box::new(FillRuleCase { name, case_type }) as Box<dyn TestCase>);
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
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES {
        basic.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: false,
            wide: false,
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES_WIDE {
        basic.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: false,
            wide: true,
        }) as Box<dyn TestCase>);
    }
    interpolation.add_child(basic);
    let mut projected = TestCaseGroup::new("projected");
    for &(primitive_type, name) in TRIANGLE_PRIMITIVES {
        projected.add_child(Box::new(TriangleInterpolationCase {
            name,
            primitive_type,
            projective: true,
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES {
        projected.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: true,
            wide: false,
        }) as Box<dyn TestCase>);
    }
    for &(primitive_type, name) in LINE_PRIMITIVES_WIDE {
        projected.add_child(Box::new(LineInterpolationCase {
            name,
            primitive_type,
            projective: true,
            wide: true,
        }) as Box<dyn TestCase>);
    }
    interpolation.add_child(projected);
    group.add_child(interpolation);

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

    group
}
