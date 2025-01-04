// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fClippingTests.cpp
//   modules/gles3/functional/es3fClippingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The two upstream files are the same test with three differences, so this single port
// serves both (`gles2::functional::clipping_tests` / `gles3::functional::clipping_tests`
// are thin wrappers): the GLSL dialect of the one shader, and the `far` distance of the
// three-vertex `triangle_vertex.clip_three` cases (30000 on ES 3.0, 20000 on ES 2.0, which
// upstream calls `farForThreeVertex`). Re-run `diff` of the two .cpp files before a re-sync.
//
// Narrowings, all of them about things this crate has no counterpart for:
//  - No `tcu::TestLog` and therefore no log of coordinates/diff mask images
//    (`genClippingPointInfoString`/`genColorString` and the `diffMask` surfaces only ever
//    fed the log, so they are not ported). Pass/fail is decided from the same counts.
//  - The `sglr::ReferenceContext` is always single sample (`ReferenceContext::new` takes
//    one colour buffer and has no multisample layout); the MSAA branches of the verifiers
//    still follow the *render target's* sample count exactly as upstream's do.

use crate::gls::reference_context_buffers::create_reference_context;
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::context::Context as SglrContext;
use crate::sglr::gl_context::GLContext;
use crate::sglr::shader_program::{ShaderProgram, ShaderProgramBase, pdec};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::vector::Vec4;
use crate::tcu::{RGBA, Random, Surface, TestError, TestOutcome, TestResult, TestStatus};

const TEST_CANVAS_SIZE: i32 = 200;

#[derive(Clone, Copy)]
struct Viewport {
    left: i32,
    bottom: i32,
    width: i32,
    height: i32,
}

const VIEWPORT_WHOLE: Viewport = Viewport {
    left: 0,
    bottom: 0,
    width: TEST_CANVAS_SIZE,
    height: TEST_CANVAS_SIZE,
};
const VIEWPORT_CENTER: Viewport = Viewport {
    left: TEST_CANVAS_SIZE / 4,
    bottom: TEST_CANVAS_SIZE / 4,
    width: TEST_CANVAS_SIZE / 2,
    height: TEST_CANVAS_SIZE / 2,
};
const VIEWPORT_CORNER: Viewport = Viewport {
    left: TEST_CANVAS_SIZE / 2,
    bottom: TEST_CANVAS_SIZE / 2,
    width: TEST_CANVAS_SIZE / 2,
    height: TEST_CANVAS_SIZE / 2,
};

/// Which of the two upstream files' shader dialect (and `farForThreeVertex`) to build.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ClippingGlslVersion {
    Es100,
    Es300,
}

impl ClippingGlslVersion {
    fn vertex_source(self) -> &'static str {
        match self {
            Self::Es100 => {
                "attribute highp vec4 a_position;\n\
                 attribute highp vec4 a_color;\n\
                 attribute highp float a_pointSize;\n\
                 varying mediump vec4 varFragColor;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   gl_PointSize = a_pointSize;\n\
                 \x20   varFragColor = a_color;\n\
                 }\n"
            }
            Self::Es300 => {
                "#version 300 es\n\
                 in highp vec4 a_position;\n\
                 in highp vec4 a_color;\n\
                 in highp float a_pointSize;\n\
                 out highp vec4 varFragColor;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_Position = a_position;\n\
                 \x20   gl_PointSize = a_pointSize;\n\
                 \x20   varFragColor = a_color;\n\
                 }\n"
            }
        }
    }

    fn fragment_source(self) -> &'static str {
        match self {
            Self::Es100 => {
                "varying mediump vec4 varFragColor;\n\
                 void main (void)\n\
                 {\n\
                 \x20   gl_FragColor = varFragColor;\n\
                 }\n"
            }
            Self::Es300 => {
                "#version 300 es\n\
                 layout(location = 0) out mediump vec4 fragColor;\
                 in highp vec4 varFragColor;\n\
                 void main (void)\n\
                 {\n\
                 \x20   fragColor = varFragColor;\n\
                 }\n"
            }
        }
    }

    fn far_for_three_vertex(self) -> f32 {
        match self {
            Self::Es100 => 20000.0,
            Self::Es300 => 30000.0,
        }
    }
}

type V4 = [f32; 4];
type Px = [i32; 4];

fn v4(x: f32, y: f32, z: f32, w: f32) -> V4 {
    [x, y, z, w]
}

fn scale4(s: f32, v: V4) -> V4 {
    [s * v[0], s * v[1], s * v[2], s * v[3]]
}

/// One `TriangleData`: p0, c0, p1, c1, p2, c2 laid out contiguously (stride 32 bytes).
type TriangleData = [V4; 6];
/// One `ColoredLineData`: p0, c0, p1, c1.
type ColoredLineData = [V4; 4];

fn tri(p0: V4, c0: V4, p1: V4, c1: V4, p2: V4, c2: V4) -> TriangleData {
    [p0, c0, p1, c1, p2, c2]
}

const WHITE: V4 = [1.0, 1.0, 1.0, 1.0];
const RED: V4 = [1.0, 0.0, 0.0, 1.0];
const YELLOW: V4 = [1.0, 1.0, 0.0, 1.0];
const BLUE: V4 = [0.0, 0.0, 1.0, 1.0];

fn is_black(a: &Px) -> bool {
    a[0] == 0 && a[1] == 0 && a[2] == 0
}

fn is_half_filled(a: &Px) -> bool {
    let half_filled = [127, 0, 0, 0];
    let threshold = [20, 256, 256, 256];
    (0..4).all(|i| (a[i] - half_filled[i]).abs() <= threshold[i])
}

fn is_less_than_half_filled(a: &Px) -> bool {
    a[0] + 20 < 127
}

fn compare_black_non_black_pixels(a: &Px, b: &Px) -> bool {
    is_black(a) == is_black(b)
}

fn compare_colored_pixels(a: &Px, b: &Px) -> bool {
    let a_is_black = is_black(a);
    let b_is_black = is_black(b);
    let threshold = [20, 20, 20, 0];

    if a_is_black && b_is_black {
        return true;
    }
    if a_is_black != b_is_black {
        return false;
    }
    (0..4).all(|i| (a[i] - b[i]).abs() <= threshold[i])
}

fn pixel_int(surface: &Surface, x: i32, y: i32) -> Px {
    let c = surface.get_pixel(x, y);
    [c.get_red(), c.get_green(), c.get_blue(), c.get_alpha()]
}

fn blit_image_on_black_surface(surface: &mut Surface) {
    for y in 0..surface.get_height() {
        for x in 0..surface.get_width() {
            let c = pixel_int(surface, x, y);
            surface.set_pixel(x, y, RGBA::new(c[0], c[1], c[2], 255));
        }
    }
}

/// `compareImages` - -1 = perfect match, 0 = deviation within the kernel, >0 = number of
/// faulty pixels.
fn compare_images(test: &Surface, reference: &Surface, kernel_radius: i32, pixel_cmp: fn(&Px, &Px) -> bool) -> i32 {
    let height = test.get_height();
    let width = test.get_width();
    let mut faulty_pixels = 0;
    let mut compare_failed = -1;

    for y in 0..height {
        for x in 0..width {
            let c_ref = pixel_int(reference, x, y);
            let c_test = pixel_int(test, x, y);

            if pixel_cmp(&c_ref, &c_test) {
                continue;
            }

            {
                let radius = kernel_radius;

                // Edges are considered a deviation too: the suitable pixel could be behind the edge.
                let (found_ref, found_test) = if y < radius || x < radius || y + radius >= height || x + radius >= width
                {
                    (true, true)
                } else {
                    let mut fr = false;
                    for k_y in (y - radius)..=(y + radius) {
                        for k_x in (x - radius)..=(x + radius) {
                            if pixel_cmp(&c_ref, &pixel_int(test, k_x, k_y)) {
                                fr = true;
                            }
                        }
                    }
                    let mut ft = false;
                    for k_y in (y - radius)..=(y + radius) {
                        for k_x in (x - radius)..=(x + radius) {
                            if pixel_cmp(&c_test, &pixel_int(reference, k_x, k_y)) {
                                ft = true;
                            }
                        }
                    }
                    (fr, ft)
                };

                if found_ref && found_test {
                    if compare_failed == -1 {
                        compare_failed = 0;
                    }
                    continue;
                }
            }

            faulty_pixels += 1;
            compare_failed = 1;
        }
    }

    if compare_failed == 1 {
        faulty_pixels
    } else {
        compare_failed
    }
}

fn compare_black_non_black_images(test: &Surface, reference: &Surface, kernel_radius: i32) -> i32 {
    compare_images(test, reference, kernel_radius, compare_black_non_black_pixels)
}

fn compare_colored_images(test: &Surface, reference: &Surface, kernel_radius: i32) -> i32 {
    compare_images(test, reference, kernel_radius, compare_colored_pixels)
}

/// `checkHalfFilledImageOverdraw` - false = area leaking.
fn check_half_filled_image_overdraw(num_samples: i32, image: &Surface) -> bool {
    for y in 0..image.get_height() {
        for x in 0..image.get_width() {
            let c_test = pixel_int(image, x, y);
            let pixel_valid =
                is_black(&c_test) || is_half_filled(&c_test) || (num_samples > 1 && is_less_than_half_filled(&c_test));
            if !pixel_valid {
                return false;
            }
        }
    }
    true
}

fn check_point_size(gl: &glw::Functions, point_size: f32) -> Result<(), TestError> {
    let mut range = [0.0f32; 2];
    // SAFETY: the query writes two floats into `range`.
    unsafe { gl.get_floatv(glw::GL_ALIASED_POINT_SIZE_RANGE, range.as_mut_ptr()) };
    if range[1] < point_size {
        return Err(TestError::NotSupported(
            "Maximum point size is too low for this test".to_string(),
        ));
    }
    Ok(())
}

fn check_line_width(gl: &glw::Functions, line_width: f32) -> Result<(), TestError> {
    let mut range = [0.0f32; 2];
    // SAFETY: the query writes two floats into `range`.
    unsafe { gl.get_floatv(glw::GL_ALIASED_LINE_WIDTH_RANGE, range.as_mut_ptr()) };
    if range[1] < line_width {
        return Err(TestError::NotSupported(
            "Maximum line width is too low for this test".to_string(),
        ));
    }
    Ok(())
}

type I3 = [i32; 3];

fn sub3(a: I3, b: I3) -> I3 {
    [a[0] - b[0], a[1] - b[1], a[2] - b[2]]
}

fn cross3(a: I3, b: I3) -> I3 {
    [
        a[1] * b[2] - a[2] * b[1],
        a[2] * b[0] - a[0] * b[2],
        a[0] * b[1] - a[1] * b[0],
    ]
}

fn dot3(a: I3, b: I3) -> i32 {
    a[0] * b[0] + a[1] * b[1] + a[2] * b[2]
}

fn de_sign32(x: i32) -> i32 {
    x.signum()
}

fn point_on_triangle(p: I3, t0: I3, t1: I3, t2: I3) -> bool {
    // Must be on the plane.
    let n = cross3(sub3(t1, t0), sub3(t2, t0));
    let d = sub3(p, t0);

    if dot3(n, d) != 0 {
        return false;
    }

    // Must be within the triangle area.
    if de_sign32(dot3(n, cross3(sub3(t1, t0), sub3(p, t0)))) == de_sign32(dot3(n, cross3(sub3(t2, t0), sub3(p, t0)))) {
        return false;
    }
    if de_sign32(dot3(n, cross3(sub3(t2, t1), sub3(p, t1)))) == de_sign32(dot3(n, cross3(sub3(t0, t1), sub3(p, t1)))) {
        return false;
    }
    if de_sign32(dot3(n, cross3(sub3(t0, t2), sub3(p, t2)))) == de_sign32(dot3(n, cross3(sub3(t1, t2), sub3(p, t2)))) {
        return false;
    }

    true
}

fn points_on_line(t0: [i32; 2], t1: [i32; 2], t2: [i32; 2]) -> bool {
    (t1[0] - t0[0]) * (t2[1] - t0[1]) - (t2[0] - t0[0]) * (t1[1] - t0[1]) == 0
}

/// True for cases where the polygon is (almost) along the xz or yz planes (normal.z < 0.1).
fn two_point_clipped_triangle_invisible(p: [f32; 3], dir1: I3, dir2: I3) -> bool {
    let fixed_scale = 64.0f32;
    let far_value: i64 = 1024;
    let d1 = [dir1[0] as i64, dir1[1] as i64, dir1[2] as i64];
    let d2 = [dir2[0] as i64, dir2[1] as i64, dir2[2] as i64];
    let pfixed = [
        (p[0] * fixed_scale).floor() as i64,
        (p[1] * fixed_scale).floor() as i64,
        (p[2] * fixed_scale).floor() as i64,
    ];
    let a = [
        d1[0] * far_value - pfixed[0],
        d1[1] * far_value - pfixed[1],
        d1[2] * far_value - pfixed[2],
    ];
    let b = [
        d2[0] * far_value - pfixed[0],
        d2[1] * far_value - pfixed[1],
        d2[2] * far_value - pfixed[2],
    ];
    let normal_dir = [
        a[1] * b[2] - a[2] * b[1],
        a[2] * b[0] - a[0] * b[2],
        a[0] * b[1] - a[1] * b[0],
    ];
    let normal_len2 = normal_dir[0] * normal_dir[0] + normal_dir[1] * normal_dir[1] + normal_dir[2] * normal_dir[2];

    (normal_dir[2] * normal_dir[2] - normal_len2 / 100) < 0
}

/// `PositionColorShader`
struct PositionColorShader {
    base: ShaderProgramBase,
}

impl PositionColorShader {
    fn new(glsl: ClippingGlslVersion) -> Self {
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_color", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_pointSize", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .vertex_source(glsl.vertex_source().to_string())
            .fragment_source(glsl.fragment_source().to_string());
        Self {
            base: ShaderProgramBase::new(&decl),
        }
    }
}

impl VertexShader for PositionColorShader {
    fn inputs(&self) -> &[VertexInputInfo] {
        self.base.vertex_inputs()
    }

    fn outputs(&self) -> &[VertexOutputInfo] {
        self.base.vertex_outputs()
    }

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        const VARYING_LOC_COLOR: usize = 0;
        const POSITION_ATTR_LOC: usize = 0;
        const COLOR_ATTR_LOC: usize = 1;
        const POINT_SIZE_ATTR_LOC: usize = 2;

        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut point_size = Vec4::splat(0.0);
            let mut color = Vec4::splat(0.0);
            // SAFETY: each attribute was bound by the case before the draw call.
            unsafe {
                read_vertex_attrib_float(
                    &mut position,
                    &inputs[POSITION_ATTR_LOC],
                    packet.instance_ndx,
                    packet.vertex_ndx,
                    0,
                );
                read_vertex_attrib_float(
                    &mut point_size,
                    &inputs[POINT_SIZE_ATTR_LOC],
                    packet.instance_ndx,
                    packet.vertex_ndx,
                    0,
                );
                read_vertex_attrib_float(
                    &mut color,
                    &inputs[COLOR_ATTR_LOC],
                    packet.instance_ndx,
                    packet.vertex_ndx,
                    0,
                );
            }

            packet.position = position;
            packet.point_size = point_size.x();
            packet.outputs[VARYING_LOC_COLOR] = GenericVec4::from_float(color);
        }
    }
}

impl FragmentShader for PositionColorShader {
    fn inputs(&self) -> &[FragmentInputInfo] {
        self.base.fragment_inputs()
    }

    fn outputs(&self) -> &[FragmentOutputInfo] {
        self.base.fragment_outputs()
    }

    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
        const VARYING_LOC_COLOR: i32 = 0;

        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe {
                    let value = read_varying(&packets[packet_ndx], context, VARYING_LOC_COLOR, frag_ndx);
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(value),
                    );
                }
            }
        }
    }
}

impl ShaderProgram for PositionColorShader {
    fn program_base(&self) -> &ShaderProgramBase {
        &self.base
    }

    fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
        &mut self.base
    }
}

#[derive(Clone, Copy)]
enum Verify {
    /// `LineCase` with its search kernel size.
    LineBlackNonBlack(i32),
    ColoredLine,
    Triangle,
    TriangleAttribute,
}

enum Geometry {
    Points {
        points: Vec<V4>,
        point_size: f32,
    },
    Lines {
        lines: Vec<ColoredLineData>,
        line_width: f32,
        verify: Verify,
    },
    Triangles {
        polys: Vec<TriangleData>,
        verify: Verify,
    },
    /// `TriangleFillTest` and its `QuadFillTest`/`TriangleFanFillTest` subclasses.
    Fill {
        triangles: Vec<TriangleData>,
    },
}

struct ClippingCase {
    name: String,
    glsl: ClippingGlslVersion,
    viewport: Viewport,
    geometry: Geometry,
}

fn bind_and_clear(ctx: &mut dyn SglrContext, glsl: ClippingGlslVersion, viewport: Viewport) -> u32 {
    let program_id = ctx.create_program(Box::new(PositionColorShader::new(glsl)));

    ctx.clear_color(0.0, 0.0, 0.0, 1.0);
    ctx.clear_depthf(1.0);
    ctx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
    ctx.viewport(viewport.left, viewport.bottom, viewport.width, viewport.height);
    ctx.use_program(program_id);
    program_id
}

fn release_program(ctx: &mut dyn SglrContext, program_id: u32) {
    ctx.use_program(0);
    ctx.delete_program(program_id);
    ctx.finish();
}

impl ClippingCase {
    fn render_points(&self, ctx: &mut dyn SglrContext, points: &[V4], point_size: f32) {
        let program_id = bind_and_clear(ctx, self.glsl, self.viewport);
        let position_loc = ctx.get_attrib_location(program_id, "a_position") as u32;
        let point_size_loc = ctx.get_attrib_location(program_id, "a_pointSize") as u32;
        let color_loc = ctx.get_attrib_location(program_id, "a_color") as u32;

        ctx.enable_vertex_attrib_array(position_loc);
        ctx.vertex_attrib_pointer(position_loc, 4, glw::GL_FLOAT, false, 0, points.as_ptr() as usize, true);
        ctx.vertex_attrib1f(point_size_loc, point_size);
        ctx.vertex_attrib4f(color_loc, 1.0, 1.0, 1.0, 1.0);
        ctx.draw_arrays(glw::GL_POINTS, 0, points.len() as i32);
        ctx.disable_vertex_attrib_array(position_loc);
        release_program(ctx, program_id);
    }

    fn render_lines(&self, ctx: &mut dyn SglrContext, lines: &[ColoredLineData], line_width: f32) {
        let vertices_per_line = 2;
        let program_id = bind_and_clear(ctx, self.glsl, self.viewport);
        let position_loc = ctx.get_attrib_location(program_id, "a_position") as u32;
        let color_loc = ctx.get_attrib_location(program_id, "a_color") as u32;
        let base = lines.as_ptr() as usize;
        let stride = (8 * std::mem::size_of::<f32>()) as i32;

        ctx.enable_vertex_attrib_array(position_loc);
        ctx.enable_vertex_attrib_array(color_loc);
        ctx.vertex_attrib_pointer(position_loc, 4, glw::GL_FLOAT, false, stride, base, true);
        ctx.vertex_attrib_pointer(
            color_loc,
            4,
            glw::GL_FLOAT,
            false,
            stride,
            base + 4 * std::mem::size_of::<f32>(),
            true,
        );
        ctx.line_width(line_width);
        ctx.draw_arrays(glw::GL_LINES, 0, vertices_per_line * lines.len() as i32);
        ctx.disable_vertex_attrib_array(position_loc);
        ctx.disable_vertex_attrib_array(color_loc);
        release_program(ctx, program_id);
    }

    fn render_triangles(&self, ctx: &mut dyn SglrContext, polys: &[TriangleData], blend: bool) {
        let vertices_per_triangle = 3;
        let program_id = bind_and_clear(ctx, self.glsl, self.viewport);
        let position_loc = ctx.get_attrib_location(program_id, "a_position") as u32;
        let color_loc = ctx.get_attrib_location(program_id, "a_color") as u32;
        let base = polys.as_ptr() as usize;
        let stride = (8 * std::mem::size_of::<f32>()) as i32;

        if blend {
            ctx.blend_func(glw::GL_ONE, glw::GL_ONE);
            ctx.enable(glw::GL_BLEND);
        }
        ctx.enable_vertex_attrib_array(position_loc);
        ctx.enable_vertex_attrib_array(color_loc);
        ctx.vertex_attrib_pointer(position_loc, 4, glw::GL_FLOAT, false, stride, base, true);
        ctx.vertex_attrib_pointer(
            color_loc,
            4,
            glw::GL_FLOAT,
            false,
            stride,
            base + 4 * std::mem::size_of::<f32>(),
            true,
        );
        ctx.draw_arrays(glw::GL_TRIANGLES, 0, vertices_per_triangle * polys.len() as i32);
        ctx.disable_vertex_attrib_array(position_loc);
        ctx.disable_vertex_attrib_array(color_loc);
        release_program(ctx, program_id);
    }

    fn render(&self, ctx: &mut dyn SglrContext) {
        match &self.geometry {
            Geometry::Points { points, point_size } => self.render_points(ctx, points, *point_size),
            Geometry::Lines { lines, line_width, .. } => self.render_lines(ctx, lines, *line_width),
            Geometry::Triangles { polys, .. } => self.render_triangles(ctx, polys, false),
            Geometry::Fill { triangles } => self.render_triangles(ctx, triangles, true),
        }
    }

    fn line_width(&self) -> f32 {
        match &self.geometry {
            Geometry::Lines { line_width, .. } => *line_width,
            _ => 1.0,
        }
    }
}

fn fail_status() -> TestStatus {
    TestStatus::fail("Got faulty pixels")
}

fn verify_fuzzy(test: &Surface, reference: &Surface) -> bool {
    fuzzy_compare_ok(&reference.get_const_access(), &test.get_const_access(), 0.3).unwrap_or(false)
}

impl ClippingCase {
    /// `LineCase::verifyImage`/`ColoredLineCase::verifyImage`/`TriangleCase::verifyImage`/
    /// `TriangleAttributeCase::verifyImage`
    fn verify_image(&self, verify: Verify, is_msaa: bool, test: &Surface, reference: &Surface) -> TestStatus {
        let faulty_limit = 6;
        match verify {
            Verify::LineBlackNonBlack(search_kernel_size) => {
                let faulty_pixels = compare_black_non_black_images(test, reference, search_kernel_size);
                if faulty_pixels > faulty_limit {
                    if self.line_width() != 1.0 && is_msaa {
                        return TestStatus::new(TestResult::CompatibilityWarning, "Wide line clipping failed");
                    }
                    return fail_status();
                }
            }
            Verify::ColoredLine => {
                if !is_msaa {
                    let faulty_pixels = compare_colored_images(test, reference, 1);
                    if faulty_pixels > faulty_limit {
                        return fail_status();
                    }
                } else if !verify_fuzzy(test, reference) {
                    if self.line_width() != 1.0 {
                        return TestStatus::new(TestResult::CompatibilityWarning, "Wide line clipping failed");
                    }
                    return fail_status();
                }
            }
            Verify::Triangle => {
                let faulty_pixels = compare_black_non_black_images(test, reference, 1);
                if faulty_pixels > faulty_limit {
                    return fail_status();
                }
            }
            Verify::TriangleAttribute => {
                if !is_msaa {
                    let faulty_pixels = compare_colored_images(test, reference, 1);
                    if faulty_pixels > faulty_limit {
                        return fail_status();
                    }
                } else if !verify_fuzzy(test, reference) {
                    return fail_status();
                }
            }
        }
        TestStatus::pass("Pass")
    }
}

impl TestCase for ClippingCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        match &self.geometry {
            Geometry::Points { point_size, .. } => check_point_size(context.gl(), *point_size),
            Geometry::Lines { line_width, .. } => check_line_width(context.gl(), *line_width),
            _ => Ok(()),
        }
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let rt = context.render_target();
        if rt.width < TEST_CANVAS_SIZE || rt.height < TEST_CANVAS_SIZE {
            return Err(TestError::NotSupported(format!(
                "Render target size must be at least {TEST_CANVAS_SIZE}x{TEST_CANVAS_SIZE}"
            )));
        }

        let mut test_surface = Surface::new(TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);
        let mut ref_surface = Surface::new(TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);

        {
            let mut gl_context = GLContext::new(&context.render_context, (0, 0, TEST_CANVAS_SIZE, TEST_CANVAS_SIZE));
            let mut ref_context = create_reference_context(context, TEST_CANVAS_SIZE, TEST_CANVAS_SIZE, rt.depth_bits)?;

            self.render(&mut gl_context);
            gl_context.read_pixels(&mut test_surface, 0, 0, TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);

            self.render(&mut ref_context);
            ref_context.read_pixels(&mut ref_surface, 0, 0, TEST_CANVAS_SIZE, TEST_CANVAS_SIZE);
        }

        let is_msaa = rt.num_samples > 1;
        match &self.geometry {
            Geometry::Points { .. } => {
                let faulty_pixels = compare_black_non_black_images(&test_surface, &ref_surface, 1);
                if faulty_pixels > 0 {
                    return Ok(TestStatus::fail("Got faulty pixels"));
                }
                Ok(TestStatus::pass("Pass"))
            }
            Geometry::Lines { verify, .. } | Geometry::Triangles { verify, .. } => {
                Ok(self.verify_image(*verify, is_msaa, &test_surface, &ref_surface))
            }
            Geometry::Fill { .. } => {
                let mut result = TestStatus::pass("Pass");

                // `FillTest::testRender` runs its reference with `numSamples = 1` and checks the
                // overdraw against the render target's own sample count.
                if !check_half_filled_image_overdraw(rt.num_samples, &test_surface) {
                    result = TestStatus::fail("Got overdraw");
                }

                blit_image_on_black_surface(&mut ref_surface);
                let faulty_pixels = compare_black_non_black_images(&test_surface, &ref_surface, 1);
                if faulty_pixels > 0 {
                    result = TestStatus::fail("Got faulty pixels");
                }
                Ok(result)
            }
        }
    }
}

fn boxed(case: ClippingCase) -> Box<dyn TestCase> {
    Box::new(case)
}

fn case(glsl: ClippingGlslVersion, name: &str, viewport: Viewport, geometry: Geometry) -> Box<dyn TestCase> {
    boxed(ClippingCase {
        name: name.to_string(),
        glsl,
        viewport,
        geometry,
    })
}

/// `QuadFillTest::QuadFillTest`
fn quad_fill_triangles(d1: [f32; 3], d2: [f32; 3], center_: [f32; 3]) -> Vec<TriangleData> {
    let radius = 40000.0f32;
    let center = [center_[0], center_[1], center_[2], 1.0f32];
    let half_white = [0.5f32, 0.5, 0.5, 0.5];
    let half_red = [0.5f32, 0.0, 0.0, 0.5];
    let e1 = [radius * d1[0], radius * d1[1], radius * d1[2], 0.0f32];
    let e2 = [radius * d2[0], radius * d2[1], radius * d2[2], 0.0f32];
    let add = |a: V4, b: V4| -> V4 { [a[0] + b[0], a[1] + b[1], a[2] + b[2], a[3] + b[3]] };
    let sub = |a: V4, b: V4| -> V4 { [a[0] - b[0], a[1] - b[1], a[2] - b[2], a[3] - b[3]] };

    let triangle1 = tri(
        add(add(center, e1), e2),
        half_white,
        sub(add(center, e1), e2),
        half_white,
        sub(sub(center, e1), e2),
        half_white,
    );
    let triangle2 = tri(
        add(add(center, e1), e2),
        half_red,
        sub(sub(center, e1), e2),
        half_red,
        add(sub(center, e1), e2),
        half_red,
    );
    vec![triangle1, triangle2]
}

fn normalize3(v: [f32; 3]) -> [f32; 3] {
    let len = (v[0] * v[0] + v[1] * v[1] + v[2] * v[2]).sqrt();
    [v[0] / len, v[1] / len, v[2] / len]
}

/// `tcu::mix(v1, v2, Vec3(t))`
fn mix3(a: [f32; 3], b: [f32; 3], t: f32) -> [f32; 3] {
    [
        a[0] * (1.0 - t) + b[0] * t,
        a[1] * (1.0 - t) + b[1] * t,
        a[2] * (1.0 - t) + b[2] * t,
    ]
}

/// `TriangleFanFillTest::TriangleFanFillTest`
fn triangle_fan_fill_triangles() -> Vec<TriangleData> {
    let radius = 70000.0f32;
    let triangles_per_visit = 40;
    let center = [0.0f32, 0.0, 0.0, 1.0];
    let half_white = [0.5f32, 0.5, 0.5, 0.5];
    let odd_slice_color = [0.0f32, 0.0, 0.5, 0.0];

    // (corner, entryPoint, exitPoint)
    let visits: [([f32; 3], [f32; 3], [f32; 3]); 6] = [
        ([1.0, 1.0, 1.0], [0.0, 1.0, 1.0], [1.0, 0.0, 1.0]),
        ([1.0, -1.0, 1.0], [1.0, 0.0, 1.0], [1.0, -1.0, 0.0]),
        ([1.0, -1.0, -1.0], [1.0, -1.0, 0.0], [0.0, -1.0, -1.0]),
        ([-1.0, -1.0, -1.0], [0.0, -1.0, -1.0], [-1.0, 0.0, -1.0]),
        ([-1.0, 1.0, -1.0], [-1.0, 0.0, -1.0], [-1.0, 1.0, 0.0]),
        ([-1.0, 1.0, 1.0], [-1.0, 1.0, 0.0], [0.0, 1.0, 1.0]),
    ];

    let mut triangles = Vec::new();
    for (corner, entry_point, exit_point) in visits {
        for t in 0..triangles_per_visit {
            let v1 = [
                entry_point[0] - corner[0],
                entry_point[1] - corner[1],
                entry_point[2] - corner[2],
            ];
            let v2 = [
                exit_point[0] - corner[0],
                exit_point[1] - corner[1],
                exit_point[2] - corner[2],
            ];

            let vertex0 = if t == 0 {
                // First vertex is magic.
                entry_point
            } else {
                let m = normalize3(mix3(v1, v2, t as f32 / triangles_per_visit as f32));
                [corner[0] + m[0], corner[1] + m[1], corner[2] + m[2]]
            };

            let vertex1 = if t == triangles_per_visit - 1 {
                // Last vertex is magic.
                exit_point
            } else {
                let m = normalize3(mix3(v1, v2, (t + 1) as f32 / triangles_per_visit as f32));
                [corner[0] + m[0], corner[1] + m[1], corner[2] + m[2]]
            };

            let color = if t % 2 != 0 {
                half_white
            } else {
                [
                    half_white[0] + odd_slice_color[0],
                    half_white[1] + odd_slice_color[1],
                    half_white[2] + odd_slice_color[2],
                    half_white[3] + odd_slice_color[3],
                ]
            };
            triangles.push(tri(
                center,
                color,
                [vertex0[0] * radius, vertex0[1] * radius, vertex0[2] * radius, 1.0],
                color,
                [vertex1[0] * radius, vertex1[1] * radius, vertex1[2] * radius, 1.0],
                color,
            ));
        }
    }
    triangles
}

/// `PointsTestGroup`
fn points_test_group(glsl: ClippingGlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("point");

    // One pixel over the viewport edge in VIEWPORT_WHOLE, half pixels over in the reduced viewport.
    let little_over_viewport = 1.0f32 + (2.0f32 / TEST_CANVAS_SIZE as f32);

    let viewport_test_points: Vec<V4> = vec![
        // in clip volume
        v4(0.0, 0.0, 0.0, 1.0),
        v4(0.1, 0.1, 0.1, 1.0),
        v4(-0.1, 0.1, -0.1, 1.0),
        v4(-0.1, -0.1, 0.1, 1.0),
        v4(0.1, -0.1, -0.1, 1.0),
        // in clip volume with w != 1
        v4(2.0, 2.0, 2.0, 3.0),
        v4(-2.0, -2.0, 2.0, 3.0),
        v4(0.5, -0.5, 0.5, 0.7),
        v4(-0.5, 0.5, -0.5, 0.7),
        // near the edge
        v4(-2.0, -2.0, 0.0, 2.2),
        v4(1.0, -1.0, 0.0, 1.1),
        v4(-1.0, 1.0, 0.0, 1.1),
        // not in the volume but still between near and far planes
        v4(1.3, 0.0, 0.0, 1.0),
        v4(-1.3, 0.0, 0.0, 1.0),
        v4(0.0, 1.3, 0.0, 1.0),
        v4(0.0, -1.3, 0.0, 1.0),
        v4(-1.3, -1.3, 0.0, 1.0),
        v4(-1.3, 1.3, 0.0, 1.0),
        v4(1.3, 1.3, 0.0, 1.0),
        v4(1.3, -1.3, 0.0, 1.0),
        // outside the viewport, wide points have fragments in the viewport
        v4(little_over_viewport, little_over_viewport, 0.0, 1.0),
        v4(0.0, little_over_viewport, 0.0, 1.0),
        v4(little_over_viewport, 0.0, 0.0, 1.0),
    ];
    let depth_test_points: Vec<V4> = vec![
        // in clip volume
        v4(0.0, 0.0, 0.0, 1.0),
        v4(0.1, 0.1, 0.1, 1.0),
        v4(-0.1, 0.1, -0.1, 1.0),
        v4(-0.1, -0.1, 0.1, 1.0),
        v4(0.1, -0.1, -0.1, 1.0),
        // not between the near and the far planes. These should be clipped
        v4(0.1, 0.0, 1.1, 1.0),
        v4(-0.1, 0.0, -1.1, 1.0),
        v4(-0.0, -0.1, 1.1, 1.0),
        v4(0.0, 0.1, -1.1, 1.0),
    ];

    let mut add = |name: &str, points: &Vec<V4>, size: f32, viewport: Viewport| {
        group.add_child(case(
            glsl,
            name,
            viewport,
            Geometry::Points {
                points: points.clone(),
                point_size: size,
            },
        ));
    };

    add("point_z_clip", &depth_test_points, 1.0, VIEWPORT_WHOLE);
    add("point_z_clip_viewport_center", &depth_test_points, 1.0, VIEWPORT_CENTER);
    add("point_z_clip_viewport_corner", &depth_test_points, 1.0, VIEWPORT_CORNER);

    add(
        "point_clip_viewport_center",
        &viewport_test_points,
        1.0,
        VIEWPORT_CENTER,
    );
    add(
        "point_clip_viewport_corner",
        &viewport_test_points,
        1.0,
        VIEWPORT_CORNER,
    );

    add("wide_point_z_clip", &depth_test_points, 5.0, VIEWPORT_WHOLE);
    add(
        "wide_point_z_clip_viewport_center",
        &depth_test_points,
        5.0,
        VIEWPORT_CENTER,
    );
    add(
        "wide_point_z_clip_viewport_corner",
        &depth_test_points,
        5.0,
        VIEWPORT_CORNER,
    );

    add("wide_point_clip", &viewport_test_points, 5.0, VIEWPORT_WHOLE);
    add(
        "wide_point_clip_viewport_center",
        &viewport_test_points,
        5.0,
        VIEWPORT_CENTER,
    );
    add(
        "wide_point_clip_viewport_corner",
        &viewport_test_points,
        5.0,
        VIEWPORT_CORNER,
    );

    group
}

fn colorless(p0: V4, p1: V4) -> ColoredLineData {
    [p0, WHITE, p1, WHITE]
}

/// `LinesTestGroup`
fn lines_test_group(glsl: ClippingGlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("line");

    let little_over_viewport = 1.0f32 + (2.0f32 / TEST_CANVAS_SIZE as f32);

    let viewport_test_lines: Vec<ColoredLineData> = vec![
        // from center to outside of viewport
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(0.0, 1.5, 0.0, 1.0)),
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(-1.5, 1.0, 0.0, 1.0)),
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(-1.5, 0.0, 0.0, 1.0)),
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(0.2, 0.4, 1.5, 1.0)),
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(-2.0, -1.0, 0.0, 1.0)),
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(1.0, 0.1, 0.0, 0.6)),
        // from outside to inside of viewport
        colorless(v4(1.5, 0.0, 0.0, 1.0), v4(0.8, -0.2, 0.0, 1.0)),
        colorless(v4(0.0, -1.5, 0.0, 1.0), v4(0.9, -0.7, 0.0, 1.0)),
        // from outside to outside
        colorless(v4(0.0, -1.3, 0.0, 1.0), v4(1.3, 0.0, 0.0, 1.0)),
        // outside the viewport, wide lines have fragments in the viewport
        colorless(
            v4(-0.8, -little_over_viewport, 0.0, 1.0),
            v4(0.0, -little_over_viewport, 0.0, 1.0),
        ),
        colorless(
            v4(-little_over_viewport - 1.0, 0.0, 0.0, 1.0),
            v4(0.0, -little_over_viewport - 1.0, 0.0, 1.0),
        ),
    ];
    let depth_test_lines: Vec<ColoredLineData> = vec![
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(1.3, 1.0, 2.0, 1.0)),
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(1.3, -1.0, 2.0, 1.0)),
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(-1.0, -1.1, -2.0, 1.0)),
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(-1.0, 1.1, -2.0, 1.0)),
        colorless(v4(0.0, 0.0, 0.0, 1.0), v4(1.0, 0.1, 2.0, 0.6)),
    ];
    let long_test_lines: Vec<ColoredLineData> = vec![
        colorless(
            v4(-41000.0, -40000.0, -1000000.0, 1.0),
            v4(41000.0, 40000.0, 1000000.0, 1.0),
        ),
        colorless(
            v4(41000.0, -40000.0, 1000000.0, 1.0),
            v4(-41000.0, 40000.0, -1000000.0, 1.0),
        ),
        colorless(v4(0.5, -40000.0, 100000.0, 1.0), v4(0.5, 40000.0, -100000.0, 1.0)),
        colorless(v4(-0.5, 40000.0, 100000.0, 1.0), v4(-0.5, -40000.0, -100000.0, 1.0)),
    ];

    // line attribute clipping
    let red = RED;
    let yellow = YELLOW;
    let light_blue = v4(0.3, 0.3, 1.0, 1.0);
    let color_test_lines: Vec<ColoredLineData> = vec![
        [v4(0.0, 0.0, 0.0, 1.0), red, v4(1.3, 1.0, 2.0, 1.0), yellow],
        [v4(0.0, 0.0, 0.0, 1.0), red, v4(1.3, -1.0, 2.0, 1.0), light_blue],
        [v4(0.0, 0.0, 0.0, 1.0), red, v4(-1.0, -1.0, -2.0, 1.0), yellow],
        [v4(0.0, 0.0, 0.0, 1.0), red, v4(-1.0, 1.0, -2.0, 1.0), light_blue],
    ];

    let mut add = |name: &str, lines: &Vec<ColoredLineData>, width: f32, viewport: Viewport, verify: Verify| {
        group.add_child(case(
            glsl,
            name,
            viewport,
            Geometry::Lines {
                lines: lines.clone(),
                line_width: width,
                verify,
            },
        ));
    };
    let plain = Verify::LineBlackNonBlack(1);

    // line clipping
    add("line_z_clip", &depth_test_lines, 1.0, VIEWPORT_WHOLE, plain);
    add(
        "line_z_clip_viewport_center",
        &depth_test_lines,
        1.0,
        VIEWPORT_CENTER,
        plain,
    );
    add(
        "line_z_clip_viewport_corner",
        &depth_test_lines,
        1.0,
        VIEWPORT_CORNER,
        plain,
    );

    add(
        "line_clip_viewport_center",
        &viewport_test_lines,
        1.0,
        VIEWPORT_CENTER,
        plain,
    );
    add(
        "line_clip_viewport_corner",
        &viewport_test_lines,
        1.0,
        VIEWPORT_CORNER,
        plain,
    );

    add("wide_line_z_clip", &depth_test_lines, 5.0, VIEWPORT_WHOLE, plain);
    add(
        "wide_line_z_clip_viewport_center",
        &depth_test_lines,
        5.0,
        VIEWPORT_CENTER,
        plain,
    );
    add(
        "wide_line_z_clip_viewport_corner",
        &depth_test_lines,
        5.0,
        VIEWPORT_CORNER,
        plain,
    );

    add("wide_line_clip", &viewport_test_lines, 5.0, VIEWPORT_WHOLE, plain);
    add(
        "wide_line_clip_viewport_center",
        &viewport_test_lines,
        5.0,
        VIEWPORT_CENTER,
        plain,
    );
    add(
        "wide_line_clip_viewport_corner",
        &viewport_test_lines,
        5.0,
        VIEWPORT_CORNER,
        plain,
    );

    add(
        "long_line_clip",
        &long_test_lines,
        1.0,
        VIEWPORT_WHOLE,
        Verify::LineBlackNonBlack(2),
    );
    add(
        "long_wide_line_clip",
        &long_test_lines,
        5.0,
        VIEWPORT_WHOLE,
        Verify::LineBlackNonBlack(2),
    );

    // line attribute clipping
    add(
        "line_attrib_clip",
        &color_test_lines,
        1.0,
        VIEWPORT_WHOLE,
        Verify::ColoredLine,
    );
    add(
        "wide_line_attrib_clip",
        &color_test_lines,
        5.0,
        VIEWPORT_WHOLE,
        Verify::ColoredLine,
    );

    group
}

/// `PolysTestGroup`
fn polys_test_group(glsl: ClippingGlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("polygon");

    let large = 100000.0f32;
    let offset = 0.9f32;
    let (white, red, yellow, blue) = (WHITE, RED, YELLOW, BLUE);

    // basic cases
    {
        let viewport_polys: Vec<TriangleData> = vec![
            // one vertex clipped
            tri(
                v4(-0.8, -0.2, 0.0, 1.0),
                white,
                v4(-0.8, 0.2, 0.0, 1.0),
                white,
                v4(-1.3, 0.05, 0.0, 1.0),
                white,
            ),
            // two vertices clipped
            tri(
                v4(-0.6, -1.2, 0.0, 1.0),
                white,
                v4(-1.2, -0.6, 0.0, 1.0),
                white,
                v4(-0.6, -0.6, 0.0, 1.0),
                white,
            ),
            // three vertices clipped
            tri(
                v4(-1.1, 0.6, 0.0, 1.0),
                white,
                v4(-1.1, 1.1, 0.0, 1.0),
                white,
                v4(-0.6, 1.1, 0.0, 1.0),
                white,
            ),
            tri(
                v4(0.8, 1.1, 0.0, 1.0),
                white,
                v4(0.95, -1.1, 0.0, 1.0),
                white,
                v4(3.0, 0.0, 0.0, 1.0),
                white,
            ),
        ];
        let depth_polys: Vec<TriangleData> = vec![
            // one vertex clipped to Z+
            tri(
                v4(-0.2, 0.7, 0.0, 1.0),
                white,
                v4(0.2, 0.7, 0.0, 1.0),
                white,
                v4(0.0, 0.9, 2.0, 1.0),
                white,
            ),
            // two vertices clipped to Z-
            tri(
                v4(0.9, 0.4, -1.5, 1.0),
                white,
                v4(0.9, -0.4, -1.5, 1.0),
                white,
                v4(0.6, 0.0, 0.0, 1.0),
                white,
            ),
            // three vertices clipped
            tri(
                v4(-0.9, 0.6, -2.0, 1.0),
                white,
                v4(-0.9, -0.6, -2.0, 1.0),
                white,
                v4(-0.4, 0.0, 2.0, 1.0),
                white,
            ),
            // three vertices clipped by X, Y and Z
            tri(
                v4(0.0, -1.2, 0.0, 1.0),
                white,
                v4(0.0, 0.5, -1.5, 1.0),
                white,
                v4(1.2, -0.9, 0.0, 1.0),
                white,
            ),
        ];
        let large_polys: Vec<TriangleData> = vec![
            // one vertex clipped
            tri(
                v4(-0.2, -0.3, 0.0, 1.0),
                white,
                v4(0.2, -0.3, 0.0, 1.0),
                white,
                v4(0.0, -large, 2.0, 1.0),
                white,
            ),
            // two vertices clipped
            tri(
                v4(0.5, 0.5, 0.0, 1.0),
                white,
                v4(large, 0.5, 0.0, 1.0),
                white,
                v4(0.5, large, 0.0, 1.0),
                white,
            ),
            // three vertices clipped
            tri(
                v4(-0.9, -large, 0.0, 1.0),
                white,
                v4(-1.1, -large, 0.0, 1.0),
                white,
                v4(-0.9, large, 0.0, 1.0),
                white,
            ),
        ];
        let large_depth_polys: Vec<TriangleData> = vec![
            // one vertex clipped
            tri(
                v4(-0.2, -0.3, 0.0, 1.0),
                white,
                v4(0.2, -0.3, 0.0, 1.0),
                white,
                v4(0.0, -large, large, 1.0),
                white,
            ),
            // two vertices clipped
            tri(
                v4(0.5, 0.5, 0.0, 1.0),
                white,
                v4(0.9, large / 2.0, -large, 1.0),
                white,
                v4(large / 4.0, 0.0, -large, 1.0),
                white,
            ),
            // three vertices clipped
            tri(
                v4(-0.9, large / 4.0, large, 1.0),
                white,
                v4(-0.5, -large / 4.0, -large, 1.0),
                white,
                v4(-0.2, large / 4.0, large, 1.0),
                white,
            ),
        ];
        let attrib_polys: Vec<TriangleData> = vec![
            // one vertex clipped to edge, large
            tri(
                v4(-0.2, -0.3, 0.0, 1.0),
                red,
                v4(0.2, -0.3, 0.0, 1.0),
                yellow,
                v4(0.0, -large, 2.0, 1.0),
                blue,
            ),
            // two vertices clipped to edges
            tri(
                v4(0.6, 1.2, 0.0, 1.0),
                red,
                v4(1.2, 0.6, 0.0, 1.0),
                yellow,
                v4(0.6, 0.6, 0.0, 1.0),
                blue,
            ),
            // two vertices clipped to edges, with non-uniform w
            tri(
                v4(0.6, -1.2, 0.0, 1.0),
                red,
                v4(1.2, -0.6, 0.0, 1.0),
                yellow,
                scale4(16.0, v4(0.6, -0.6, 0.0, 1.0)),
                blue,
            ),
            // three vertices clipped, large, Z
            tri(
                v4(-0.9, large / 4.0, large, 1.0),
                red,
                v4(-0.5, -large / 4.0, -large, 1.0),
                yellow,
                v4(-0.2, large / 4.0, large, 1.0),
                blue,
            ),
        ];

        let mut add = |name: &str, polys: &Vec<TriangleData>, viewport: Viewport, verify: Verify| {
            group.add_child(case(
                glsl,
                name,
                viewport,
                Geometry::Triangles {
                    polys: polys.clone(),
                    verify,
                },
            ));
        };

        add(
            "poly_clip_viewport_center",
            &viewport_polys,
            VIEWPORT_CENTER,
            Verify::Triangle,
        );
        add(
            "poly_clip_viewport_corner",
            &viewport_polys,
            VIEWPORT_CORNER,
            Verify::Triangle,
        );

        add("poly_z_clip", &depth_polys, VIEWPORT_WHOLE, Verify::Triangle);
        add(
            "poly_z_clip_viewport_center",
            &depth_polys,
            VIEWPORT_CENTER,
            Verify::Triangle,
        );
        add(
            "poly_z_clip_viewport_corner",
            &depth_polys,
            VIEWPORT_CORNER,
            Verify::Triangle,
        );

        add(
            "large_poly_clip_viewport_center",
            &large_polys,
            VIEWPORT_CENTER,
            Verify::Triangle,
        );
        add(
            "large_poly_clip_viewport_corner",
            &large_polys,
            VIEWPORT_CORNER,
            Verify::Triangle,
        );

        add(
            "large_poly_z_clip",
            &large_depth_polys,
            VIEWPORT_WHOLE,
            Verify::Triangle,
        );
        add(
            "large_poly_z_clip_viewport_center",
            &large_depth_polys,
            VIEWPORT_CENTER,
            Verify::Triangle,
        );
        add(
            "large_poly_z_clip_viewport_corner",
            &large_depth_polys,
            VIEWPORT_CORNER,
            Verify::Triangle,
        );

        add(
            "poly_attrib_clip",
            &attrib_polys,
            VIEWPORT_WHOLE,
            Verify::TriangleAttribute,
        );
        add(
            "poly_attrib_clip_viewport_center",
            &attrib_polys,
            VIEWPORT_CENTER,
            Verify::TriangleAttribute,
        );
        add(
            "poly_attrib_clip_viewport_corner",
            &attrib_polys,
            VIEWPORT_CORNER,
            Verify::TriangleAttribute,
        );
    }

    // multiple polygons
    {
        // The recurring "two vertices clipped to edges" corner triangles.
        let edge_ne = tri(
            v4(0.6, 1.2, 0.0, 1.0),
            red,
            v4(1.2, 0.6, 0.0, 1.0),
            yellow,
            v4(0.6, 0.6, 0.0, 1.0),
            blue,
        );
        let edge_se = tri(
            v4(0.6, -1.2, 0.0, 1.0),
            red,
            v4(1.2, -0.6, 0.0, 1.0),
            yellow,
            v4(0.6, -0.6, 0.0, 1.0),
            blue,
        );
        let edge_nw = tri(
            v4(-0.6, 1.2, 0.0, 1.0),
            red,
            v4(-1.2, 0.6, 0.0, 1.0),
            yellow,
            v4(-0.6, 0.6, 0.0, 1.0),
            blue,
        );
        let edge_sw = tri(
            v4(-0.6, -1.2, 0.0, 1.0),
            red,
            v4(-1.2, -0.6, 0.0, 1.0),
            yellow,
            v4(-0.6, -0.6, 0.0, 1.0),
            blue,
        );
        // The same corners with `16.0f * Vec4(...)` as the third vertex (non-uniform w).
        let edge_se_w = tri(
            v4(0.6, -1.2, 0.0, 1.0),
            red,
            v4(1.2, -0.6, 0.0, 1.0),
            yellow,
            scale4(16.0, v4(0.6, -0.6, 0.0, 1.0)),
            blue,
        );
        let edge_ne_w = tri(
            v4(0.6, 1.2, 0.0, 1.0),
            red,
            v4(1.2, 0.6, 0.0, 1.0),
            yellow,
            scale4(16.0, v4(0.6, 0.6, 0.0, 1.0)),
            blue,
        );
        let edge_nw_w = tri(
            v4(-0.6, 1.2, 0.0, 1.0),
            red,
            v4(-1.2, 0.6, 0.0, 1.0),
            yellow,
            scale4(16.0, v4(-0.6, 0.6, 0.0, 1.0)),
            blue,
        );
        let edge_sw_w = tri(
            v4(-0.6, -1.2, 0.0, 1.0),
            red,
            v4(-1.2, -0.6, 0.0, 1.0),
            yellow,
            scale4(16.0, v4(-0.6, -0.6, 0.0, 1.0)),
            blue,
        );
        let z_tri = |p0: V4, p1: V4, p2: V4| tri(p0, red, p1, yellow, p2, blue);

        let multiple: Vec<Vec<TriangleData>> = vec![
            // multiple_0
            vec![
                // one vertex clipped to edge
                z_tri(
                    v4(-0.2, -0.3, 0.0, 1.0),
                    v4(0.2, -0.3, 0.0, 1.0),
                    v4(0.0, -offset, 2.0, 1.0),
                ),
                // two vertices clipped to edges
                edge_ne,
                // two vertices clipped to edges, with non-uniform w
                edge_se_w,
                edge_ne_w,
                edge_nw_w,
                edge_sw_w,
                // three vertices clipped, Z
                z_tri(
                    v4(-0.9, offset / 4.0, offset, 1.0),
                    v4(-0.5, -offset / 4.0, -offset, 1.0),
                    v4(-0.2, offset / 4.0, offset, 1.0),
                ),
            ],
            // multiple_1
            vec![
                z_tri(
                    v4(-0.2, -0.3, 0.0, 1.0),
                    v4(0.2, -0.3, 0.0, 1.0),
                    v4(0.0, -offset, 2.0, 1.0),
                ),
                edge_ne,
                edge_se_w,
                edge_ne_w,
                edge_nw_w,
                edge_sw_w,
            ],
            // multiple_2
            vec![
                z_tri(
                    v4(-0.2, -0.3, 0.0, 1.0),
                    v4(0.2, -0.3, 0.0, 1.0),
                    v4(0.0, -offset, 2.0, 1.0),
                ),
                edge_ne,
                edge_se,
                edge_ne,
                edge_nw,
                edge_sw,
            ],
            // multiple_3
            vec![
                z_tri(
                    v4(-0.2, -0.3, 0.0, 1.0),
                    v4(0.2, -0.3, 0.0, 1.0),
                    v4(0.0, -offset, -2.0, 1.0),
                ),
                edge_se,
                edge_ne,
                edge_nw,
                edge_sw,
            ],
            // multiple_4
            vec![
                z_tri(
                    v4(0.3, 0.2, 0.0, 1.0),
                    v4(0.3, -0.2, 0.0, 1.0),
                    v4(offset, 0.0, 2.0, 1.0),
                ),
                edge_se,
                edge_ne,
                edge_nw,
                edge_sw,
            ],
            // multiple_5
            vec![
                z_tri(
                    v4(-0.3, 0.2, 0.0, 1.0),
                    v4(-0.3, -0.2, 0.0, 1.0),
                    v4(-offset, 0.0, 2.0, 1.0),
                ),
                edge_se,
                edge_ne,
                edge_nw,
                edge_sw,
            ],
            // multiple_6
            vec![
                z_tri(
                    v4(-0.2, 0.3, 0.0, 1.0),
                    v4(0.2, 0.3, 0.0, 1.0),
                    v4(0.0, offset, 2.0, 1.0),
                ),
                edge_se,
                edge_ne,
                edge_nw,
                edge_sw,
            ],
            // multiple_7
            vec![edge_ne, edge_se, edge_ne, edge_nw, edge_sw],
            // multiple_8
            vec![
                z_tri(
                    v4(-0.2, -0.3, 0.0, 1.0),
                    v4(0.2, -0.3, 0.0, 1.0),
                    v4(0.0, -offset, 2.0, 1.0),
                ),
                // fill
                tri(
                    v4(-1.0, -1.0, 0.0, 1.0),
                    white,
                    v4(1.0, -1.0, 0.0, 1.0),
                    white,
                    v4(-1.0, 1.0, 0.0, 1.0),
                    white,
                ),
                tri(
                    v4(-1.0, 1.0, 0.0, 1.0),
                    blue,
                    v4(1.0, -1.0, 0.0, 1.0),
                    blue,
                    v4(1.0, 1.0, 0.0, 1.0),
                    blue,
                ),
            ],
            // multiple_9
            vec![
                z_tri(
                    v4(-0.2, -0.3, 0.0, 1.0),
                    v4(0.2, -0.3, 0.0, 1.0),
                    v4(0.0, -offset, 2.0, 1.0),
                ),
                // fill
                tri(
                    v4(-1.0, 1.0, 0.0, 1.0),
                    red,
                    v4(1.0, -1.0, 0.0, 1.0),
                    red,
                    v4(1.0, 1.0, 0.0, 1.0),
                    red,
                ),
                tri(
                    v4(-1.0, -1.0, 0.0, 1.0),
                    blue,
                    v4(1.0, -1.0, 0.0, 1.0),
                    blue,
                    v4(-1.0, 1.0, 0.0, 1.0),
                    blue,
                ),
            ],
            // multiple_10
            vec![
                z_tri(
                    v4(-0.2, -0.3, 0.0, 1.0),
                    v4(0.2, -0.3, 0.0, 1.0),
                    v4(0.0, -offset, 2.0, 1.0),
                ),
                // fill
                tri(
                    v4(-1.0, -1.0, 0.0, 1.0),
                    white,
                    v4(1.0, -1.0, 0.0, 1.0),
                    white,
                    v4(-1.0, 1.0, 0.0, 1.0),
                    white,
                ),
                tri(
                    v4(-1.0, 1.0, 0.0, 1.0),
                    red,
                    v4(1.0, -1.0, 0.0, 1.0),
                    red,
                    v4(1.0, 1.0, 0.0, 1.0),
                    red,
                ),
                tri(
                    v4(-1.0, -1.0, 0.0, 1.0),
                    blue,
                    v4(1.0, -1.0, 0.0, 1.0),
                    blue,
                    v4(-1.0, 1.0, 0.0, 1.0),
                    blue,
                ),
            ],
            // multiple_11
            vec![
                z_tri(
                    v4(-0.2, -0.3, 0.0, 1.0),
                    v4(0.2, -0.3, 0.0, 1.0),
                    v4(0.0, -offset, 2.0, 1.0),
                ),
                // fill
                tri(
                    v4(-1.0, -1.0, 0.0, 1.0),
                    white,
                    v4(1.0, -1.0, 0.0, 1.0),
                    white,
                    v4(-1.0, 1.0, 0.0, 1.0),
                    white,
                ),
                tri(
                    v4(-1.0, 1.0, 0.0, 1.0),
                    red,
                    v4(1.0, -1.0, 0.0, 1.0),
                    red,
                    v4(1.0, 1.0, 0.0, 1.0),
                    red,
                ),
                tri(
                    v4(-1.0, -1.0, 0.0, 1.0),
                    blue,
                    v4(1.0, -1.0, 0.0, 1.0),
                    blue,
                    v4(-1.0, 1.0, 0.0, 1.0),
                    blue,
                ),
                tri(
                    v4(-1.0, 1.0, 0.0, 1.0),
                    yellow,
                    v4(1.0, -1.0, 0.0, 1.0),
                    yellow,
                    v4(1.0, 1.0, 0.0, 1.0),
                    yellow,
                ),
            ],
        ];

        for (ndx, polys) in multiple.iter().enumerate() {
            for (suffix, viewport) in [
                ("", VIEWPORT_WHOLE),
                ("_viewport_center", VIEWPORT_CENTER),
                ("_viewport_corner", VIEWPORT_CORNER),
            ] {
                group.add_child(case(
                    glsl,
                    &format!("multiple_{ndx}{suffix}"),
                    viewport,
                    Geometry::Triangles {
                        polys: polys.clone(),
                        verify: Verify::TriangleAttribute,
                    },
                ));
            }
        }
    }

    group
}

/// `PolyEdgesTestGroup`
fn poly_edges_test_group(glsl: ClippingGlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("polygon_edge");

    // Quads via origin: (tangent, bi-tangent)
    let quads: [([f32; 3], [f32; 3]); 5] = [
        ([1.0, 1.0, 1.0], [1.0, -1.0, 1.0]),
        ([1.0, 1.0, 1.0], [-1.0, 1.1, 1.0]),
        ([1.0, 1.0, 0.0], [-1.0, 1.0, 0.0]),
        ([0.0, 1.0, 0.0], [1.0, 0.0, 0.0]),
        ([0.0, 1.0, 0.0], [1.0, 0.1, 0.0]),
    ];

    // Quad near edge: (tangent, bi-tangent, center)
    let edge_quads: [([f32; 3], [f32; 3], [f32; 3]); 3] = [
        ([1.0, 0.01, 0.0], [0.0, 0.01, 0.0], [0.0, 0.99, 0.0]), // edge near x-plane
        ([0.01, 1.0, 0.0], [0.01, 0.0, 0.0], [0.99, 0.0, 0.0]), // edge near y-plane
        ([1.0, 1.0, 0.01], [0.01, -0.01, 0.0], [0.0, 0.0, 0.99]), // edge near z-plane
    ];

    for (ndx, (d1, d2)) in quads.iter().enumerate() {
        group.add_child(case(
            glsl,
            &format!("quad_at_origin_{ndx}"),
            VIEWPORT_CENTER,
            Geometry::Fill {
                triangles: quad_fill_triangles(*d1, *d2, [0.0, 0.0, 0.0]),
            },
        ));
    }
    for (ndx, (d1, d2, center)) in edge_quads.iter().enumerate() {
        group.add_child(case(
            glsl,
            &format!("quad_near_edge_{ndx}"),
            VIEWPORT_CENTER,
            Geometry::Fill {
                triangles: quad_fill_triangles(*d1, *d2, *center),
            },
        ));
    }

    // Polyfan
    group.add_child(case(
        glsl,
        "poly_fan",
        VIEWPORT_CENTER,
        Geometry::Fill {
            triangles: triangle_fan_fill_triangles(),
        },
    ));

    group
}

fn outside_name(v: I3) -> String {
    let mut name = String::new();
    name.push_str(if v[0] > 0 {
        "_pos_x"
    } else if v[0] < 0 {
        "_neg_x"
    } else {
        ""
    });
    name.push_str(if v[1] > 0 {
        "_pos_y"
    } else if v[1] < 0 {
        "_neg_y"
    } else {
        ""
    });
    name.push_str(if v[2] > 0 {
        "_pos_z"
    } else if v[2] < 0 {
        "_neg_z"
    } else {
        ""
    });
    name
}

/// `PolyVertexClipTestGroup`
fn poly_vertex_clip_test_group(glsl: ClippingGlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("triangle_vertex");

    let far = 30000.0f32;
    let far_for_three_vertex = glsl.far_for_three_vertex();
    let outside: [I3; 26] = [
        // outside one clipping plane
        [-1, 0, 0],
        [1, 0, 0],
        [0, 1, 0],
        [0, -1, 0],
        [0, 0, 1],
        [0, 0, -1],
        // outside two clipping planes
        [-1, -1, 0],
        [1, -1, 0],
        [1, 1, 0],
        [-1, 1, 0],
        [-1, 0, -1],
        [1, 0, -1],
        [1, 0, 1],
        [-1, 0, 1],
        [0, -1, -1],
        [0, 1, -1],
        [0, 1, 1],
        [0, -1, 1],
        // outside three clipping planes
        [-1, -1, 1],
        [1, -1, 1],
        [1, 1, 1],
        [-1, 1, 1],
        [-1, -1, -1],
        [1, -1, -1],
        [1, 1, -1],
        [-1, 1, -1],
    ];

    let mut rnd = Random::new(0x00ab_cdef);

    let mut clip_one = TestCaseGroup::new("clip_one");
    let mut clip_two = TestCaseGroup::new("clip_two");
    let mut clip_three = TestCaseGroup::new("clip_three");

    let single = |glsl: ClippingGlslVersion, name: &str, triangle: TriangleData| {
        case(
            glsl,
            name,
            VIEWPORT_CENTER,
            Geometry::Triangles {
                polys: vec![triangle],
                verify: Verify::Triangle,
            },
        )
    };
    let scaled = |r: [f32; 3], w: f32| -> V4 { [r[0] * w, r[1] * w, r[2] * w, w] };
    let far_vec = |r: I3, far: f32| -> [f32; 3] { [r[0] as f32 * far, r[1] as f32 * far, r[2] as f32 * far] };

    // Test 1 point clipped
    for o in outside.iter() {
        let w0 = rnd.get_float_range(0.2, 16.0);
        let w1 = rnd.get_float_range(0.2, 16.0);
        let w2 = rnd.get_float_range(0.2, 16.0);
        let r0 = [0.2f32, 0.3, 0.0];
        let r1 = [-0.3f32, -0.4, 0.0];
        let r2 = [o[0] as f32 * far, o[1] as f32 * far, o[2] as f32 * far];
        let p0 = scaled(r0, w0);
        let p1 = scaled(r1, w1);
        let p2 = scaled(r2, w2);

        let name = format!("clip{}", outside_name(*o));

        // don't try to test with degenerate (or almost degenerate) triangles
        if o[0] == 0 && o[1] == 0 {
            continue;
        }

        clip_one.add_child(single(glsl, &name, tri(p0, WHITE, p1, WHITE, p2, WHITE)));
    }

    // Special triangles for "clip_z" cases, default triangles is not good, since it has very small visible area => problems with MSAA
    {
        let pos_z_triangle = tri(
            v4(0.0, -0.7, -0.9, 1.0),
            WHITE,
            v4(0.8, 0.0, -0.7, 1.0),
            WHITE,
            v4(-0.9, 0.9, 3.0, 1.0),
            WHITE,
        );
        let neg_z_triangle = tri(
            v4(0.0, -0.7, 0.9, 1.0),
            WHITE,
            v4(0.4, 0.0, 0.7, 1.0),
            WHITE,
            v4(-0.9, 0.9, -3.0, 1.0),
            WHITE,
        );

        clip_one.add_child(single(glsl, "clip_pos_z", pos_z_triangle));
        clip_one.add_child(single(glsl, "clip_neg_z", neg_z_triangle));
    }

    // Test 2 points clipped
    for ndx1 in 0..outside.len() {
        for ndx2 in (ndx1 + 1)..outside.len() {
            let w0 = rnd.get_float_range(0.2, 16.0);
            let w1 = rnd.get_float_range(0.2, 16.0);
            let w2 = rnd.get_float_range(0.2, 16.0);
            let r0 = [0.2f32, 0.3, 0.0];
            let r1 = outside[ndx1];
            let r2 = outside[ndx2];
            let p0 = scaled(r0, w0);
            let p1 = scaled(far_vec(r1, far), w1);
            let p2 = scaled(far_vec(r2, far), w2);

            let name = format!("clip{}_and{}", outside_name(outside[ndx1]), outside_name(outside[ndx2]));

            if two_point_clipped_triangle_invisible(r0, r1, r2) {
                continue;
            }

            clip_two.add_child(single(glsl, &name, tri(p0, WHITE, p1, WHITE, p2, WHITE)));
        }
    }

    // Test 3 points clipped
    for ndx1 in 0..outside.len() {
        for ndx2 in (ndx1 + 1)..outside.len() {
            for ndx3 in (ndx2 + 1)..outside.len() {
                let w0 = rnd.get_float_range(0.2, 16.0);
                let w1 = rnd.get_float_range(0.2, 16.0);
                let w2 = rnd.get_float_range(0.2, 16.0);
                let r0 = outside[ndx1];
                let r1 = outside[ndx2];
                let r2 = outside[ndx3];
                let p0 = scaled(far_vec(r0, far_for_three_vertex), w0);
                let p1 = scaled(far_vec(r1, far_for_three_vertex), w1);
                let p2 = scaled(far_vec(r2, far_for_three_vertex), w2);

                // ignore cases where polygon is along xz or yz planes
                if points_on_line([r0[0], r0[1]], [r1[0], r1[1]], [r2[0], r2[1]]) {
                    continue;
                }

                // triangle is visible only if it intersects the origin
                if point_on_triangle([0, 0, 0], r0, r1, r2) {
                    let name = format!(
                        "clip{}_and{}_and{}",
                        outside_name(outside[ndx1]),
                        outside_name(outside[ndx2]),
                        outside_name(outside[ndx3])
                    );
                    clip_three.add_child(single(glsl, &name, tri(p0, WHITE, p1, WHITE, p2, WHITE)));
                }
            }
        }
    }

    group.add_child(clip_one);
    group.add_child(clip_two);
    group.add_child(clip_three);
    group
}

/// `ClippingTests::init`
pub fn create_tests(glsl: ClippingGlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("clipping");
    group.add_child(points_test_group(glsl));
    group.add_child(lines_test_group(glsl));
    group.add_child(polys_test_group(glsl));
    group.add_child(poly_edges_test_group(glsl));
    group.add_child(poly_vertex_clip_test_group(glsl));
    group
}
