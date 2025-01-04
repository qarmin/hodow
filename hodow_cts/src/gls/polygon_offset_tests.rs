// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fPolygonOffsetTests.cpp
//   modules/gles3/functional/es3fPolygonOffsetTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The ES 2.0 and ES 3.0 files differ only in the
// shader dialect and the depth-buffer format list (ES 2.0 has `default` and `fixed16`), so the port
// lives here with a `GlslVersion` parameter.
//
// Each case draws a few triangles with the real driver (client-side vertex arrays, raw `glw` calls)
// and compares against either a flat-colour expectation or, for `enable` and `render_with_units`,
// against the same triangles drawn with `rr::Renderer` straight onto a `Surface` (no depth buffer,
// exactly as upstream). The comparison is upstream's kernel search (`compareImages`) with a 20 pixel
// allowance; the diff-mask image and the log are not produced.
//
// The test body of every case is a list of `GlStep`s (state, triangle, colour) so one runner drives
// all seven; the three cases that need a loop or per-iteration clears keep their own function.

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::generic_vector::{GenericVec4, GenericVecType};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{RenderState, ViewportState, WindowRectangle};
use crate::rr::renderer::{DrawCommand, PrimitiveList, Program, RenderTarget, Renderer, as_multisample_view};
use crate::rr::shaders::{
    FragmentInputInfo, FragmentOutputInfo, FragmentShader, VertexInputInfo, VertexOutputInfo, VertexShader,
};
use crate::rr::shading_context::{FragmentShadingContext, read_varying, write_fragment_output};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType, read_vertex_attrib_float};
use crate::rr::vertex_packet::VertexPacket;
use crate::sglr::shader_program::{ShaderProgramBase, pdec};
use crate::tcu::pixel::clear;
use crate::tcu::vector::Vec4;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

/// Which GLSL dialect (and which depth-buffer list) the group is built for.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum GlslVersion {
    Es100,
    Es300,
}

const VERTEX_ES100: &str = "attribute highp vec4 a_position;\n\
     attribute highp vec4 a_color;\n\
     varying mediump vec4 v_color;\n\
     void main (void)\n\
     {\n\
     \x20   gl_Position = a_position;\n\
     \x20   v_color = a_color;\n\
     }\n";
const FRAGMENT_ES100: &str = "varying mediump vec4 v_color;\n\
     void main (void)\n\
     {\n\
     \x20   gl_FragColor = v_color;\n\
     }\n";
const VERTEX_ES300: &str = "#version 300 es\n\
     in highp vec4 a_position;\n\
     in highp vec4 a_color;\n\
     out highp vec4 v_color;\n\
     void main (void)\n\
     {\n\
     \x20   gl_Position = a_position;\n\
     \x20   v_color = a_color;\n\
     }\n";
// The missing newline after `fragColor;` is upstream's.
const FRAGMENT_ES300: &str = "#version 300 es\n\
     in highp vec4 v_color;\n\
     layout(location = 0) out mediump vec4 fragColor;\
     void main (void)\n\
     {\n\
     \x20   fragColor = v_color;\n\
     }\n";

fn shader_sources(version: GlslVersion) -> (&'static str, &'static str) {
    match version {
        GlslVersion::Es100 => (VERTEX_ES100, FRAGMENT_ES100),
        GlslVersion::Es300 => (VERTEX_ES300, FRAGMENT_ES300),
    }
}

type Triangle = [[f32; 4]; 3];

const BLACK: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const WHITE: [f32; 4] = [1.0; 4];
const RED: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
const GREEN: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
const YELLOW: [f32; 4] = [1.0, 1.0, 0.0, 1.0];

/// `PositionColorShader`
struct PositionColorShader {
    base: ShaderProgramBase,
}

impl PositionColorShader {
    fn new(version: GlslVersion) -> Self {
        let (vertex, fragment) = shader_sources(version);
        let decl = pdec::ShaderProgramDeclaration::new()
            .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
            .vertex_attribute(pdec::VertexAttribute::new("a_color", GenericVecType::Float))
            .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
            .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
            .vertex_source(vertex)
            .fragment_source(fragment);
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
        const POSITION_ATTR_LOC: usize = 0;
        const COLOR_ATTR_LOC: usize = 1;

        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            let mut color = Vec4::splat(0.0);
            // SAFETY: the attributes were bound by the case before the draw call.
            unsafe {
                read_vertex_attrib_float(
                    &mut position,
                    &inputs[POSITION_ATTR_LOC],
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

            // Transform to position
            packet.position = position;
            // Pass color to FS
            packet.outputs[0] = GenericVec4::from_float(color);
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
        for packet_ndx in 0..packets.len() {
            for frag_ndx in 0..4usize {
                // SAFETY: the context was set up by the renderer for exactly these packets.
                unsafe {
                    let color = read_varying(&packets[packet_ndx], context, 0, frag_ndx);
                    write_fragment_output(
                        context,
                        packet_ndx as i32,
                        frag_ndx as i32,
                        0,
                        GenericVec4::from_float(color),
                    );
                }
            }
        }
    }
}

/// `verifyError` - records the first failure reason and carries on.
fn verify_error(gl: &glw::Functions, expected: GLenum, fail: &mut Option<String>) {
    // SAFETY: glGetError needs nothing but a current context.
    let got = unsafe { gl.get_error() };
    if got != expected && fail.is_none() {
        *fail = Some("Got invalid error".to_string());
    }
}

/// `compareImages` - -1 perfect match, 0 deviation within the kernel, >0 faulty pixel count.
/// Upstream calls it with the reference image as `test` and the rendered one as `ref`.
fn compare_images(context: &Context, test: &Surface, ref_: &Surface, radius: i32) -> i32 {
    let height = test.get_height();
    let width = test.get_width();
    let color_threshold = 128;
    let format_threshold = context.render_target().pixel_format().get_color_threshold();
    let threshold = [
        color_threshold + format_threshold.get_red(),
        color_threshold + format_threshold.get_green(),
        color_threshold + format_threshold.get_blue(),
        (if format_threshold.get_alpha() > 0 {
            color_threshold
        } else {
            0
        }) + format_threshold.get_alpha(),
    ];

    let pixel = |s: &Surface, x: i32, y: i32| {
        let c = s.get_pixel(x, y);
        [c.get_red(), c.get_green(), c.get_blue(), c.get_alpha()]
    };
    let within = |a: [i32; 4], b: [i32; 4]| (0..4).all(|i| (a[i] - b[i]).abs() <= threshold[i]);

    let mut faulty_pixels = 0;
    let mut compare_failed = -1;

    for y in 0..height {
        for x in 0..width {
            let c_ref = pixel(ref_, x, y);

            // Pixelwise match, no deviation or fault
            if within(c_ref, pixel(test, x, y)) {
                continue;
            }

            // If not, search within kernel radius
            let k_y_min = (y - radius).max(0);
            let k_y_max = (y + radius).min(height - 1);
            let k_x_min = (x - radius).max(0);
            let k_x_max = (x + radius).min(width - 1);
            let mut found = false;

            for k_y in k_y_min..=k_y_max {
                for k_x in k_x_min..=k_x_max {
                    if within(c_ref, pixel(test, k_x, k_y)) {
                        found = true;
                    }
                }
            }

            if found {
                // The pixel is deviating if the color is found inside the kernel
                if compare_failed == -1 {
                    compare_failed = 0;
                }
                continue;
            }

            faulty_pixels += 1; // The pixel is faulty if the color is not found
            compare_failed = 1;
        }
    }

    if compare_failed == 1 {
        faulty_pixels
    } else {
        compare_failed
    }
}

/// `verifyImages`
fn verify_images(context: &Context, test_image: &Surface, reference_image: &Surface, fail: &mut Option<String>) {
    let kernel_radius = 1;
    let faulty_pixel_limit = 20;

    let faulty_pixels = compare_images(context, reference_image, test_image, kernel_radius);

    if faulty_pixels > faulty_pixel_limit {
        *fail = Some("Got faulty pixels".to_string());
    }
}

/// One draw of the real-driver half: `glDepthFunc`/`glPolygonOffset`/colour mask, then a triangle.
struct GlStep<'a> {
    depth_func: Option<GLenum>,
    offset: (f32, f32),
    color_mask: bool,
    triangle: &'a Triangle,
    color: [f32; 4],
}

impl<'a> GlStep<'a> {
    fn new(depth_func: Option<GLenum>, offset: (f32, f32), triangle: &'a Triangle, color: [f32; 4]) -> Self {
        Self {
            depth_func,
            offset,
            color_mask: true,
            triangle,
            color,
        }
    }
}

/// The state every real-driver pass starts from.
struct GlPass<'a> {
    gl: &'a glw::Functions,
    program: ShaderProgram<'a>,
    position_loc: u32,
    color_loc: u32,
}

impl<'a> GlPass<'a> {
    fn new(context: &'a Context, version: GlslVersion) -> Result<Self, TestError> {
        let gl = context.gl();
        let (vertex, fragment) = shader_sources(version);
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vertex, fragment));
        if !program.is_ok() {
            return Err(TestError::Fail("Shader compile failed.".to_string()));
        }

        // SAFETY: plain attribute lookups on a linked program with a current context.
        let (position_loc, color_loc) = unsafe {
            (
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()) as u32,
                gl.get_attrib_location(program.program(), c"a_color".as_ptr()) as u32,
            )
        };
        Ok(Self {
            gl,
            program,
            position_loc,
            color_loc,
        })
    }

    /// The common opening: clears, viewport, program, depth test, optionally the offset fill and the
    /// position attribute array.
    fn begin(&self, size: i32, clear_depth_too: bool, enable_fill: bool) {
        let gl = self.gl;
        // SAFETY: ES 2.0 state setters with a current context.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            if clear_depth_too {
                gl.clear_depthf(1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
            } else {
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }
            gl.viewport(0, 0, size, size);
            gl.use_program(self.program.program());
            gl.enable(glw::GL_DEPTH_TEST);
            if enable_fill {
                gl.enable(glw::GL_POLYGON_OFFSET_FILL);
            }
            gl.enable_vertex_attrib_array(self.position_loc);
        }
    }

    fn step(&self, step: &GlStep<'_>) {
        let gl = self.gl;
        // SAFETY: the triangle outlives the draw call, which copies the client array.
        unsafe {
            if let Some(func) = step.depth_func {
                gl.depth_func(func);
            }
            gl.polygon_offset(step.offset.0, step.offset.1);
            let m = if step.color_mask { glw::TRUE } else { glw::FALSE };
            gl.color_mask(m, m, m, m);
            gl.vertex_attrib_pointer(
                self.position_loc,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                step.triangle.as_ptr().cast(),
            );
            gl.vertex_attrib_4f(
                self.color_loc,
                step.color[0],
                step.color[1],
                step.color[2],
                step.color[3],
            );
            gl.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        }
    }

    fn enable_fill(&self, on: bool) {
        // SAFETY: state setter with a current context.
        unsafe {
            if on {
                self.gl.enable(glw::GL_POLYGON_OFFSET_FILL);
            } else {
                self.gl.disable(glw::GL_POLYGON_OFFSET_FILL);
            }
        }
    }

    /// The common closing, then the pixel read-back and `GL_SUBPIXEL_BITS`.
    fn end(&self, context: &Context, size: i32) -> Result<(Surface, i32), TestError> {
        let gl = self.gl;
        let mut subpixel_bits = 0;
        // SAFETY: state setters with a current context; the query writes one integer.
        unsafe {
            gl.disable_vertex_attrib_array(self.position_loc);
            gl.use_program(0);
            gl.finish();
            gl.get_integerv(glw::GL_SUBPIXEL_BITS, &mut subpixel_bits);
        }

        let mut test_image = Surface::new(size, size);
        glu::read_pixels(&context.render_context, 0, 0, &mut test_image.get_access())?;
        Ok((test_image, subpixel_bits))
    }
}

/// Renders `draws` with `rr::Renderer` onto a black `Surface`.
fn render_reference(version: GlslVersion, size: i32, subpixel_bits: i32, draws: &[(&Triangle, [f32; 4])]) -> Surface {
    let mut reference_image = Surface::new(size, size);
    let state = RenderState::new(
        ViewportState::new(WindowRectangle {
            left: 0,
            bottom: 0,
            width: size,
            height: size,
        }),
        subpixel_bits,
    );
    let shader = PositionColorShader::new(version);
    let program = Program {
        vertex_shader: &shader,
        fragment_shader: &shader,
        geometry_shader: None,
    };
    let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, 3, 0);

    clear(&mut reference_image.get_access(), BLACK);

    for (triangle, color) in draws {
        let attribs = [
            VertexAttrib::from_pointer(VertexAttribType::Float, 4, 0, 0, triangle.as_ptr().cast()),
            VertexAttrib::from_generic_float(Vec4::new(color[0], color[1], color[2], color[3])),
        ];
        let mut render_target = RenderTarget::new(as_multisample_view(reference_image.get_access()), None, None);
        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };
        Renderer::new().draw(&command, &mut render_target);
    }

    reference_image
}

fn flat_image(size: i32, color: [f32; 4]) -> Surface {
    let mut image = Surface::new(size, size);
    clear(&mut image.get_access(), color);
    image
}

#[derive(Clone, Copy)]
enum Kind {
    Usage,
    UsageDisplacement,
    UsagePositiveNegative,
    ResultClamping,
    UsageSlope,
    ZeroSlope,
    OneSlope,
}

/// `PolygonOffsetTestCase` and its seven subclasses.
struct PolygonOffsetCase {
    name: String,
    kind: Kind,
    version: GlslVersion,
    /// 0 for the default framebuffer.
    internal_format: GLenum,
    target_size: i32,
}

impl PolygonOffsetCase {
    #[allow(clippy::new_ret_no_self)]
    fn new(
        kind: Kind,
        version: GlslVersion,
        internal_format: GLenum,
        format_name: &str,
        suffix: &str,
    ) -> Box<dyn TestCase> {
        Box::new(Self {
            name: format!("{format_name}_{suffix}"),
            kind,
            version,
            internal_format,
            target_size: 200,
        })
    }

    /// `testPolygonOffset`
    fn test_polygon_offset(&self, context: &Context, fail: &mut Option<String>) -> Result<(), TestError> {
        let size = self.target_size;
        let pass = GlPass::new(context, self.version)?;

        match self.kind {
            Kind::Usage => {
                let triangle: Triangle = [[-1.0, 1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0]];

                // render test image
                pass.begin(size, true, false);
                // DepthFunc = GL_LEQUAL: make the test pass if polygon offset does nothing, this case only
                // detects always-on offsets.
                // SAFETY: state setter with a current context.
                unsafe { context.gl().depth_func(glw::GL_LEQUAL) };

                // draw back (offset disabled)
                pass.enable_fill(false);
                pass.step(&GlStep::new(None, (0.0, -2.0), &triangle, WHITE));

                // draw front
                pass.enable_fill(true);
                pass.step(&GlStep::new(None, (0.0, -1.0), &triangle, RED));

                let (test_image, subpixel_bits) = pass.end(context, size)?;

                // Expecting: Bottom-right = Red.
                let reference_image = render_reference(self.version, size, subpixel_bits, &[(&triangle, RED)]);
                verify_images(context, &test_image, &reference_image, fail);
            }
            Kind::UsageDisplacement => {
                let mut rnd = Random::new(0xdec0de);
                let num_iterations = 40;

                pass.begin(size, true, true);

                // Draw a colorless triangle at a random location, then set an offset and render a green
                // triangle with depthfunc = equal: all fragments have different Z, so nothing may pass.
                for _ in 0..num_iterations {
                    let offset_direction = rnd.get_bool();
                    let offset = if offset_direction { -1.0f32 } else { 1.0 };
                    let mut triangle: Triangle = [[0.0; 4]; 3];

                    for vertex in triangle.iter_mut() {
                        // w >= 1.0 and z in (-0.9, 0.9): never clipped, nowhere near the depth planes.
                        let x = rnd.get_float_range(-1.0, 1.0);
                        let y = rnd.get_float_range(-1.0, 1.0);
                        let w = 1.0 + rnd.get_float();
                        *vertex = [x, y, 0.5, w];
                    }

                    let mut colorless = GlStep::new(Some(glw::GL_ALWAYS), (0.0, 0.0), &triangle, GREEN);
                    colorless.color_mask = false;
                    pass.step(&colorless);
                    pass.step(&GlStep::new(Some(glw::GL_EQUAL), (0.0, offset), &triangle, GREEN));
                }

                // The colour mask is left off by the last step only if the loop never ran; restore anyway.
                let (test_image, _) = pass.end(context, size)?;

                // Expecting black framebuffer.
                verify_images(context, &test_image, &flat_image(size, BLACK), fail);
            }
            Kind::UsagePositiveNegative => {
                let triangle_bottom_right: Triangle =
                    [[-1.0, 1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0]];
                let triangle_top_left: Triangle =
                    [[-1.0, -1.0, 0.0, 1.0], [-1.0, 1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0]];

                pass.begin(size, true, true);
                // SAFETY: state setter with a current context.
                unsafe { context.gl().depth_func(glw::GL_LESS) };

                // draw top left (negative offset test)
                pass.step(&GlStep::new(None, (0.0, 0.0), &triangle_top_left, WHITE));
                pass.step(&GlStep::new(None, (0.0, -1.0), &triangle_top_left, GREEN));

                // draw bottom right (positive offset test)
                pass.step(&GlStep::new(None, (0.0, 1.0), &triangle_bottom_right, WHITE));
                pass.step(&GlStep::new(None, (0.0, 0.0), &triangle_bottom_right, YELLOW));

                let (test_image, subpixel_bits) = pass.end(context, size)?;

                // Expecting: Top-left = Green, Bottom-right = Yellow.
                let reference_image = render_reference(
                    self.version,
                    size,
                    subpixel_bits,
                    &[(&triangle_top_left, GREEN), (&triangle_bottom_right, YELLOW)],
                );
                verify_images(context, &test_image, &reference_image, fail);
            }
            Kind::ResultClamping => {
                let triangle_bottom_right: Triangle =
                    [[-1.0, 1.0, 1.0, 1.0], [1.0, 1.0, 1.0, 1.0], [1.0, -1.0, 1.0, 1.0]];
                let triangle_top_left: Triangle =
                    [[-1.0, -1.0, -1.0, 1.0], [-1.0, 1.0, -1.0, 1.0], [1.0, -1.0, -1.0, 1.0]];

                pass.begin(size, true, true);

                // draw bottom right (far): the result depth should clamp to 1.0
                pass.step(&GlStep::new(
                    Some(glw::GL_ALWAYS),
                    (0.0, 8.0),
                    &triangle_bottom_right,
                    WHITE,
                ));
                pass.step(&GlStep::new(
                    Some(glw::GL_GREATER),
                    (0.0, 9.0),
                    &triangle_bottom_right,
                    RED,
                ));

                // draw top left (near): the result depth should clamp to -1.0
                pass.step(&GlStep::new(
                    Some(glw::GL_ALWAYS),
                    (0.0, -8.0),
                    &triangle_top_left,
                    WHITE,
                ));
                pass.step(&GlStep::new(
                    Some(glw::GL_LESS),
                    (0.0, -9.0),
                    &triangle_top_left,
                    YELLOW,
                ));

                let (test_image, _) = pass.end(context, size)?;

                // Expecting: Top-left = White, Bottom-right = White.
                verify_images(context, &test_image, &flat_image(size, WHITE), fail);
            }
            Kind::UsageSlope => {
                let triangle_bottom_right: Triangle =
                    [[-1.0, 1.0, 0.0, 1.0], [1.0, 1.0, 0.9, 1.0], [1.0, -1.0, 0.9, 1.0]];
                let triangle_top_left: Triangle =
                    [[-1.0, -1.0, -0.9, 1.0], [-1.0, 1.0, 0.9, 1.0], [1.0, -1.0, 0.0, 1.0]];

                pass.begin(size, true, true);

                // draw top left (negative offset test)
                pass.step(&GlStep::new(
                    Some(glw::GL_ALWAYS),
                    (0.0, 0.0),
                    &triangle_top_left,
                    WHITE,
                ));
                pass.step(&GlStep::new(Some(glw::GL_LESS), (-1.0, 0.0), &triangle_top_left, GREEN));

                // draw bottom right (positive offset test)
                pass.step(&GlStep::new(
                    Some(glw::GL_ALWAYS),
                    (0.0, 0.0),
                    &triangle_bottom_right,
                    WHITE,
                ));
                pass.step(&GlStep::new(
                    Some(glw::GL_GREATER),
                    (1.0, 0.0),
                    &triangle_bottom_right,
                    GREEN,
                ));

                let (test_image, _) = pass.end(context, size)?;

                // Expecting: Top-left = Green, Bottom-right = Green.
                verify_images(context, &test_image, &flat_image(size, GREEN), fail);
            }
            Kind::ZeroSlope => {
                let triangle: Triangle = [[-0.4, 0.4, 0.0, 1.0], [-0.8, -0.5, 0.0, 1.0], [0.7, 0.2, 0.0, 1.0]];

                pass.begin(size, true, true);

                pass.step(&GlStep::new(Some(glw::GL_ALWAYS), (0.0, 0.0), &triangle, RED));
                // triangle slope == 0
                pass.step(&GlStep::new(Some(glw::GL_EQUAL), (4.0, 0.0), &triangle, BLACK));

                let (test_image, _) = pass.end(context, size)?;

                verify_images(context, &test_image, &flat_image(size, BLACK), fail);
            }
            Kind::OneSlope => {
                // Vertices with dz_w / dx_w == 1 and dz_w / dy_w == 0, or the other way round: m == 1.
                let corner_depth = size as f32;
                let triangles: [Triangle; 2] = [
                    [
                        [-1.0, -1.0, -corner_depth, 1.0],
                        [-1.0, 1.0, -corner_depth, 1.0],
                        [1.0, -1.0, corner_depth, 1.0],
                    ],
                    [
                        [-1.0, 1.0, corner_depth, 1.0],
                        [1.0, 1.0, corner_depth, 1.0],
                        [1.0, -1.0, -corner_depth, 1.0],
                    ],
                ];
                let gl = context.gl();

                pass.begin(size, false, true);

                // top left (positive offset)
                // SAFETY: state setters with a current context.
                unsafe {
                    gl.clear_depthf(1.0); // far
                    gl.clear(glw::GL_DEPTH_BUFFER_BIT);
                }
                // clamps any depth on the triangle to 1
                pass.step(&GlStep::new(Some(glw::GL_NOTEQUAL), (10.0, 0.0), &triangles[0], RED));

                // bottom right (negative offset)
                // SAFETY: as above.
                unsafe {
                    gl.clear_depthf(0.0);
                    gl.clear(glw::GL_DEPTH_BUFFER_BIT);
                }
                // clamps depth to 0
                pass.step(&GlStep::new(Some(glw::GL_NOTEQUAL), (-10.0, 0.0), &triangles[1], GREEN));

                let (test_image, _) = pass.end(context, size)?;

                verify_images(context, &test_image, &flat_image(size, BLACK), fail);
            }
        }

        Ok(())
    }
}

impl TestCase for PolygonOffsetCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut fail: Option<String> = None;

        if self.internal_format == 0 {
            // default framebuffer
            let rt = context.render_target();

            if rt.width < self.target_size || rt.height < self.target_size {
                return Err(TestError::NotSupported(format!(
                    "Render context size must be at least {0}x{0}",
                    self.target_size
                )));
            }

            if rt.depth_bits == 0 {
                return Err(TestError::NotSupported(
                    "polygon offset tests require depth buffer".to_string(),
                ));
            }

            self.test_polygon_offset(context, &mut fail)?;
        } else {
            let gl = context.gl();
            let mut color_rbo_id = 0u32;
            let mut depth_rbo_id = 0u32;
            let mut fbo_id = 0u32;

            // SAFETY: plain object creation and attachment calls with a current context.
            let fbo_complete = unsafe {
                gl.gen_renderbuffers(1, &mut color_rbo_id);
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo_id);
                gl.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA4, self.target_size, self.target_size);
                verify_error(gl, glw::GL_NO_ERROR, &mut fail);

                gl.gen_renderbuffers(1, &mut depth_rbo_id);
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_rbo_id);
                gl.renderbuffer_storage(
                    glw::GL_RENDERBUFFER,
                    self.internal_format,
                    self.target_size,
                    self.target_size,
                );
                verify_error(gl, glw::GL_NO_ERROR, &mut fail);

                gl.gen_framebuffers(1, &mut fbo_id);
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo_id);
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    color_rbo_id,
                );
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    depth_rbo_id,
                );
                verify_error(gl, glw::GL_NO_ERROR, &mut fail);

                gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) == glw::GL_FRAMEBUFFER_COMPLETE
            };

            let result = if fbo_complete {
                self.test_polygon_offset(context, &mut fail)
            } else {
                Ok(())
            };

            // SAFETY: deleting the objects created above.
            unsafe {
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                gl.delete_framebuffers(1, &fbo_id);
                gl.delete_renderbuffers(1, &depth_rbo_id);
                gl.delete_renderbuffers(1, &color_rbo_id);
            }

            result?;

            if !fbo_complete {
                return Err(TestError::NotSupported("could not create fbo for testing.".to_string()));
            }
        }

        match fail {
            None => Ok(TestStatus::pass("Pass")),
            Some(reason) => Ok(TestStatus::fail(reason)),
        }
    }
}

/// `PolygonOffsetTests::init`
pub fn create_tests(version: GlslVersion) -> TestCaseGroup {
    // (internal format, name); format 0 is the default framebuffer.
    let depth_formats: &[(GLenum, &str)] = match version {
        GlslVersion::Es100 => &[(0, "default"), (glw::GL_DEPTH_COMPONENT16, "fixed16")],
        GlslVersion::Es300 => &[
            (0, "default"),
            (glw::GL_DEPTH_COMPONENT16, "fixed16"),
            (glw::GL_DEPTH_COMPONENT24, "fixed24"),
            (glw::GL_DEPTH_COMPONENT32F, "float32"),
        ],
    };

    let mut group = TestCaseGroup::new("polygon_offset");

    for &(internal_format, name) in depth_formats {
        // enable works?
        group.add_child(PolygonOffsetCase::new(
            Kind::Usage,
            version,
            internal_format,
            name,
            "enable",
        ));
        // Really moves the polygons ?
        group.add_child(PolygonOffsetCase::new(
            Kind::UsageDisplacement,
            version,
            internal_format,
            name,
            "displacement_with_units",
        ));
        // Really moves the polygons to right direction ?
        group.add_child(PolygonOffsetCase::new(
            Kind::UsagePositiveNegative,
            version,
            internal_format,
            name,
            "render_with_units",
        ));
        // Is total result clamped to [0,1] like promised?
        group.add_child(PolygonOffsetCase::new(
            Kind::ResultClamping,
            version,
            internal_format,
            name,
            "result_depth_clamp",
        ));
        // Slope really moves the polygon?
        group.add_child(PolygonOffsetCase::new(
            Kind::UsageSlope,
            version,
            internal_format,
            name,
            "render_with_factor",
        ));
        // Factor with zero slope
        group.add_child(PolygonOffsetCase::new(
            Kind::ZeroSlope,
            version,
            internal_format,
            name,
            "factor_0_slope",
        ));
        // Factor with 1.0 slope
        group.add_child(PolygonOffsetCase::new(
            Kind::OneSlope,
            version,
            internal_format,
            name,
            "factor_1_slope",
        ));
    }

    group
}
