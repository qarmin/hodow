// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderBuiltinVarTests.cpp
//   modules/gles3/functional/es3fShaderBuiltinVarTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two upstream files carry the same
// `ShaderDepthRangeTest`, `FragCoordXYZCase`, `FragCoordWCase`, `PointCoordCase` and
// `FrontFacingCase` apart from the GLSL dialect; they are written once here and take a
// `BuiltinVarGlsl`. `ShaderDepthRangeTest::iterate` re-enters `ShaderRenderCase::iterate`
// three times (CONTINUE); here one `iterate` runs the three `glDepthRangef` settings in turn.

use std::sync::Mutex;

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase};
use crate::glw;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::pixel::clear;
use crate::tcu::rgba::RGBA;
use crate::tcu::vector::{Vec3, Vec4};
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestResult, TestStatus};

/// Which GLSL dialect a shared case is written in.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum BuiltinVarGlsl {
    Es100,
    Es300,
}

impl BuiltinVarGlsl {
    fn vertex_position_only(self) -> &'static str {
        match self {
            Self::Es100 => "attribute highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n",
            Self::Es300 => {
                "#version 300 es\nin highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n"
            }
        }
    }
}

fn compile<'a>(context: &'a Context, vert: &str, frag: &str) -> Result<ShaderProgram<'a>, TestError> {
    let program = ShaderProgram::new(context.gl(), &ProgramSources::vtx_frag(vert, frag));
    if !program.is_ok() {
        return Err(TestError::InternalError("Compile failed".to_string()));
    }
    Ok(program)
}

fn compare_verdict(ok: bool) -> TestOutcome {
    Ok(if ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Image comparison failed")
    })
}

fn threshold_of(context: &Context) -> RGBA {
    RGBA::new(1, 1, 1, 1) + context.render_target().pixel_format().get_color_threshold()
}

// --- ShaderDepthRangeTest ---

/// `DepthRangeEvaluator` plus the `DepthRangeParams` it reads.
struct DepthRangeSpec {
    name: String,
    is_vertex_case: bool,
    vert_src: String,
    frag_src: String,
    params: Mutex<(f32, f32)>,
}

impl ShaderRenderCaseSpec for DepthRangeSpec {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        (&self.vert_src, &self.frag_src)
    }

    fn is_vertex_case(&self) -> bool {
        self.is_vertex_case
    }

    fn evaluate(&self, c: &mut ShaderEvalContext) {
        let (z_near, z_far) = *self.params.lock().expect("depth range params lock");
        let z_near = z_near.clamp(0.0, 1.0);
        let z_far = z_far.clamp(0.0, 1.0);
        let diff = z_far - z_near;
        c.color.m_data[..3].copy_from_slice(&[z_near, z_far, diff * 0.5 + 0.5]);
    }
}

/// `ShaderDepthRangeTest`
struct ShaderDepthRangeTest {
    inner: ShaderRenderCase<DepthRangeSpec>,
}

impl TestCase for ShaderDepthRangeTest {
    fn name(&self) -> &str {
        self.inner.spec.name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        const CASES: [(f32, f32); 3] = [(0.0, 1.0), (1.5, -1.0), (0.7, 0.3)];

        let mut status = TestStatus::pass("Pass");
        for (z_near, z_far) in CASES {
            *self.inner.spec.params.lock().expect("depth range params lock") = (z_near, z_far);
            // SAFETY: plain state setter with a current context.
            unsafe { gl.depth_rangef(z_near, z_far) };
            glu::expect_no_error(gl, "glDepthRangef()")?;

            status = self.inner.iterate(context)?;
            if status.code() != TestResult::Pass {
                break;
            }
        }
        Ok(status)
    }
}

/// `ShaderDepthRangeTest::init` + constructor
pub fn depth_range_case(name: &str, is_vertex_case: bool, glsl: BuiltinVarGlsl) -> Box<dyn TestCase> {
    let es3 = glsl == BuiltinVarGlsl::Es300;
    let (default_vert, default_frag) = if es3 {
        (
            "#version 300 es\nin highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n",
            "#version 300 es\nin mediump vec4 v_color;\nlayout(location = 0) out mediump vec4 o_color;\n\nvoid main (void)\n{\n    o_color = v_color;\n}\n",
        )
    } else {
        (
            "attribute highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n",
            "varying mediump vec4 v_color;\n\nvoid main (void)\n{\n    gl_FragColor = v_color;\n}\n",
        )
    };

    let mut src = String::new();
    if es3 {
        src.push_str("#version 300 es\n");
        if is_vertex_case {
            src.push_str("in highp vec4 a_position;\nout mediump vec4 v_color;\n");
        } else {
            src.push_str("layout(location = 0) out mediump vec4 o_color;\n");
        }
    } else if is_vertex_case {
        src.push_str("attribute highp vec4 a_position;\nvarying mediump vec4 v_color;\n");
    }

    src.push_str("void main (void)\n{\n");
    let out_name = match (is_vertex_case, es3) {
        (true, _) => "v_color",
        (false, true) => "o_color",
        (false, false) => "gl_FragColor",
    };
    src.push_str(&format!(
        "\t{out_name} = vec4(gl_DepthRange.near, gl_DepthRange.far, gl_DepthRange.diff*0.5 + 0.5, 1.0);\n"
    ));
    if is_vertex_case {
        src.push_str("\tgl_Position = a_position;\n");
    }
    src.push_str("}\n");

    let (vert_src, frag_src) = if is_vertex_case {
        (src, default_frag.to_string())
    } else {
        (default_vert.to_string(), src)
    };

    Box::new(ShaderDepthRangeTest {
        inner: ShaderRenderCase::new(DepthRangeSpec {
            name: name.to_string(),
            is_vertex_case,
            vert_src,
            frag_src,
            params: Mutex::new((0.0, 1.0)),
        }),
    })
}

// --- FragCoordXYZCase ---

struct FragCoordXyzCase {
    glsl: BuiltinVarGlsl,
}

impl TestCase for FragCoordXyzCase {
    fn name(&self) -> &str {
        "fragcoord_xyz"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let width = render_target.width;
        let height = render_target.height;
        let threshold = threshold_of(context);
        let scale = Vec3::new(1.0 / width as f32, 1.0 / height as f32, 1.0);

        let mut test_img = Surface::new(width, height);
        let mut ref_img = Surface::new(width, height);

        let frag = match self.glsl {
            BuiltinVarGlsl::Es100 => {
                "uniform mediump vec3 u_scale;\nvoid main (void)\n{\n    gl_FragColor = vec4(gl_FragCoord.xyz*u_scale, 1.0);\n}\n"
            }
            BuiltinVarGlsl::Es300 => {
                "#version 300 es\nuniform highp vec3 u_scale;\nlayout(location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    o_color = vec4(gl_FragCoord.xyz*u_scale, 1.0);\n}\n"
            }
        };
        let program = compile(context, self.glsl.vertex_position_only(), frag)?;

        // Draw with GL.
        {
            const POSITIONS: [f32; 16] = [
                -1.0, 1.0, -1.0, 1.0, -1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 1.0, 1.0,
            ];
            const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

            // SAFETY: a program this case built and a 3-float array that outlives the call.
            unsafe {
                let scale_loc = gl.get_uniform_location(program.program(), c"u_scale".as_ptr());
                gl.use_program(program.program());
                gl.uniform_3fv(scale_loc, 1, scale.m_data.as_ptr());
            }
            let pos_binding = glu::va::float("a_position", 4, 4, 0, &POSITIONS);

            glu::draw(
                &context.render_context,
                program.program(),
                &[pos_binding],
                &glu::pr::triangles(&INDICES),
            )?;
            glu::read_pixels(&context.render_context, 0, 0, &mut test_img.get_access())?;
            glu::expect_no_error(gl, "Draw")?;
        }

        // Draw reference
        for y in 0..ref_img.get_height() {
            for x in 0..ref_img.get_width() {
                let xf = (x as f32 + 0.5) / ref_img.get_width() as f32;
                let yf = ((ref_img.get_height() - y - 1) as f32 + 0.5) / ref_img.get_height() as f32;
                let z = (xf + yf) / 2.0;
                let frag_coord = Vec3::new(x as f32 + 0.5, y as f32 + 0.5, z);
                let scaled = Vec3::new(
                    frag_coord.x() * scale.x(),
                    frag_coord.y() * scale.y(),
                    frag_coord.z() * scale.z(),
                );
                ref_img.set_pixel(x, y, RGBA::from_vec(Vec4::new(scaled.x(), scaled.y(), scaled.z(), 1.0)));
            }
        }

        compare_verdict(pixel_threshold_compare(&ref_img, &test_img, threshold).ok)
    }
}

// --- FragCoordWCase ---

fn projected_tri_interpolate(s: [f32; 3], w: [f32; 3], nx: f32, ny: f32) -> f32 {
    (s[0] * (1.0 - nx - ny) / w[0] + s[1] * ny / w[1] + s[2] * nx / w[2])
        / ((1.0 - nx - ny) / w[0] + ny / w[1] + nx / w[2])
}

struct FragCoordWCase {
    glsl: BuiltinVarGlsl,
}

impl TestCase for FragCoordWCase {
    fn name(&self) -> &str {
        "fragcoord_w"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let width = render_target.width;
        let height = render_target.height;
        let threshold = threshold_of(context);

        let mut test_img = Surface::new(width, height);
        let mut ref_img = Surface::new(width, height);

        let w: [f32; 4] = [1.7, 2.0, 1.2, 1.0];

        let frag = match self.glsl {
            BuiltinVarGlsl::Es100 => {
                "void main (void)\n{\n    gl_FragColor = vec4(0.0, 1.0/gl_FragCoord.w - 1.0, 0.0, 1.0);\n}\n"
            }
            BuiltinVarGlsl::Es300 => {
                "#version 300 es\nlayout(location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    o_color = vec4(0.0, 1.0/gl_FragCoord.w - 1.0, 0.0, 1.0);\n}\n"
            }
        };
        let program = compile(context, self.glsl.vertex_position_only(), frag)?;

        // Draw with GL.
        {
            let positions: [f32; 16] = [
                -w[0], w[0], 0.0, w[0], -w[1], -w[1], 0.0, w[1], w[2], w[2], 0.0, w[2], w[3], -w[3], 0.0, w[3],
            ];
            const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

            let pos_binding = glu::va::float("a_position", 4, 4, 0, &positions);
            // SAFETY: a program this case built.
            unsafe { gl.use_program(program.program()) };

            glu::draw(
                &context.render_context,
                program.program(),
                &[pos_binding],
                &glu::pr::triangles(&INDICES),
            )?;
            glu::read_pixels(&context.render_context, 0, 0, &mut test_img.get_access())?;
            glu::expect_no_error(gl, "Draw")?;
        }

        // Draw reference
        for y in 0..ref_img.get_height() {
            for x in 0..ref_img.get_width() {
                let xf = (x as f32 + 0.5) / ref_img.get_width() as f32;
                let yf = ((ref_img.get_height() - y - 1) as f32 + 0.5) / ref_img.get_height() as f32;
                let oow = if xf + yf < 1.0 {
                    projected_tri_interpolate([w[0], w[1], w[2]], [w[0], w[1], w[2]], xf, yf)
                } else {
                    projected_tri_interpolate([w[3], w[2], w[1]], [w[3], w[2], w[1]], 1.0 - xf, 1.0 - yf)
                };
                ref_img.set_pixel(x, y, RGBA::from_vec(Vec4::new(0.0, oow - 1.0, 0.0, 1.0)));
            }
        }

        compare_verdict(pixel_threshold_compare(&ref_img, &test_img, threshold).ok)
    }
}

// --- PointCoordCase ---

/// `deRoundFloatToInt32`
fn round_to_int(value: f32) -> i32 {
    (value + 0.5).floor() as i32
}

struct PointCoordCase {
    glsl: BuiltinVarGlsl,
}

impl TestCase for PointCoordCase {
    fn name(&self) -> &str {
        "pointcoord"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let render_target = context.render_target();
        let width = render_target.width.min(256);
        let height = render_target.height.min(256);
        let threshold = 0.02f32;

        const NUM_POINTS: usize = 8;

        let mut coords = [[0.0f32; 3]; NUM_POINTS];
        let mut point_size_range = [0.0f32; 2];

        let mut rnd = Random::new(0x145fa);
        let mut test_img = Surface::new(width, height);
        let mut ref_img = Surface::new(width, height);

        // SAFETY: GL_ALIASED_POINT_SIZE_RANGE writes two floats.
        unsafe { gl.get_floatv(glw::GL_ALIASED_POINT_SIZE_RANGE, point_size_range.as_mut_ptr()) };
        glu::expect_no_error(gl, "glGetFloatv(GL_ALIASED_POINT_SIZE_RANGE)")?;

        if point_size_range[0] <= 0.0 || point_size_range[1] <= 0.0 || point_size_range[1] < point_size_range[0] {
            return Err(TestError::Fail("Invalid GL_ALIASED_POINT_SIZE_RANGE".to_string()));
        }

        // Compute coordinates.
        for coord in &mut coords {
            coord[0] = rnd.get_float_range(-0.9, 0.9);
            coord[1] = rnd.get_float_range(-0.9, 0.9);
            coord[2] = rnd.get_float_range(point_size_range[0], point_size_range[1]);
        }

        let (vert, frag) = match self.glsl {
            BuiltinVarGlsl::Es100 => (
                "attribute highp vec3 a_positionSize;\nvoid main (void)\n{\n    gl_Position = vec4(a_positionSize.xy, 0.0, 1.0);\n    gl_PointSize = a_positionSize.z;\n}\n",
                "void main (void)\n{\n    gl_FragColor = vec4(gl_PointCoord, 0.0, 1.0);\n}\n",
            ),
            BuiltinVarGlsl::Es300 => (
                "#version 300 es\nin highp vec3 a_positionSize;\nvoid main (void)\n{\n    gl_Position = vec4(a_positionSize.xy, 0.0, 1.0);\n    gl_PointSize = a_positionSize.z;\n}\n",
                "#version 300 es\nlayout(location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    o_color = vec4(gl_PointCoord, 0.0, 1.0);\n}\n",
            ),
        };
        let program = compile(context, vert, frag)?;

        // Draw with GL.
        {
            let flat: Vec<f32> = coords.iter().flatten().copied().collect();
            let pos_binding = glu::va::float("a_positionSize", 3, coords.len() as i32, 0, &flat);
            let viewport_x = rnd.get_int(0, render_target.width - width);
            let viewport_y = rnd.get_int(0, render_target.height - height);

            // SAFETY: plain state setters and a program this case built.
            unsafe {
                gl.viewport(viewport_x, viewport_y, width, height);
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
                gl.use_program(program.program());
            }

            glu::draw(
                &context.render_context,
                program.program(),
                &[pos_binding],
                &glu::pr::list(glu::PrimitiveType::Points, coords.len() as i32),
            )?;
            glu::read_pixels(
                &context.render_context,
                viewport_x,
                viewport_y,
                &mut test_img.get_access(),
            )?;
            glu::expect_no_error(gl, "Draw")?;
        }

        // Draw reference
        clear(&mut ref_img.get_access(), [0.0, 0.0, 0.0, 1.0]);
        for p in &coords {
            let (fw, fh) = (width as f32, height as f32);
            let x0 = round_to_int(fw * (p[0] * 0.5 + 0.5) - p[2] * 0.5);
            let y0 = round_to_int(fh * (p[1] * 0.5 + 0.5) - p[2] * 0.5);
            let x1 = round_to_int(fw * (p[0] * 0.5 + 0.5) + p[2] * 0.5);
            let y1 = round_to_int(fh * (p[1] * 0.5 + 0.5) + p[2] * 0.5);
            let w = x1 - x0;
            let h = y1 - y0;

            for yo in 0..h {
                for xo in 0..w {
                    let xf = (xo as f32 + 0.5) / w as f32;
                    let yf = ((h - yo - 1) as f32 + 0.5) / h as f32;
                    let dx = x0 + xo;
                    let dy = y0 + yo;

                    if dx >= 0 && dx < ref_img.get_width() && dy >= 0 && dy < ref_img.get_height() {
                        ref_img.set_pixel(dx, dy, RGBA::from_vec(Vec4::new(xf, yf, 0.0, 1.0)));
                    }
                }
            }
        }

        let ok = fuzzy_compare_ok(&ref_img.get_const_access(), &test_img.get_const_access(), threshold)
            .ok_or_else(|| TestError::InternalError("fuzzy comparison of unsupported formats".to_string()))?;
        compare_verdict(ok)
    }
}

// --- FrontFacingCase ---

struct FrontFacingCase {
    glsl: BuiltinVarGlsl,
}

impl TestCase for FrontFacingCase {
    fn name(&self) -> &str {
        "frontfacing"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // Test case renders two adjecent quads, where left is has front-facing
        // triagles and right back-facing. Color is selected based on gl_FrontFacing
        // value.
        let gl = context.gl();
        let render_target = context.render_target();
        let mut rnd = Random::new(0x89f2c);
        let width = render_target.width.min(64);
        let height = render_target.height.min(64);
        let viewport_x = rnd.get_int(0, render_target.width - width);
        let viewport_y = rnd.get_int(0, render_target.height - height);
        let threshold = threshold_of(context);

        let mut test_img = Surface::new(width, height);
        let mut ref_img = Surface::new(width, height);

        let frag = match self.glsl {
            BuiltinVarGlsl::Es100 => {
                "void main (void)\n{\n    if (gl_FrontFacing)\n        gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0);\n    else\n        gl_FragColor = vec4(0.0, 0.0, 1.0, 1.0);\n}\n"
            }
            BuiltinVarGlsl::Es300 => {
                "#version 300 es\nlayout(location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    if (gl_FrontFacing)\n        o_color = vec4(0.0, 1.0, 0.0, 1.0);\n    else\n        o_color = vec4(0.0, 0.0, 1.0, 1.0);\n}\n"
            }
        };
        let program = compile(context, self.glsl.vertex_position_only(), frag)?;

        // Draw with GL.
        {
            const POSITIONS: [f32; 16] = [
                -1.0, 1.0, 0.0, 1.0, -1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0,
            ];
            const INDICES_CCW: [u16; 6] = [0, 1, 2, 2, 1, 3];
            const INDICES_CW: [u16; 6] = [2, 1, 0, 3, 1, 2];

            let draw = |indices: &[u16]| -> Result<(), TestError> {
                let pos_binding = glu::va::float("a_position", 4, 4, 0, &POSITIONS);
                glu::draw(
                    &context.render_context,
                    program.program(),
                    &[pos_binding],
                    &glu::pr::triangles(indices),
                )
            };

            // SAFETY: plain state setters and a program this case built.
            unsafe {
                gl.use_program(program.program());
                gl.front_face(glw::GL_CCW);
                gl.viewport(viewport_x, viewport_y, width / 2, height / 2);
            }
            draw(&INDICES_CCW)?;

            // SAFETY: as above.
            unsafe { gl.viewport(viewport_x + width / 2, viewport_y, width - width / 2, height / 2) };
            draw(&INDICES_CW)?;

            // SAFETY: as above.
            unsafe {
                gl.front_face(glw::GL_CW);
                gl.viewport(viewport_x, viewport_y + height / 2, width / 2, height - height / 2);
            }
            draw(&INDICES_CCW)?;

            // SAFETY: as above.
            unsafe {
                gl.viewport(
                    viewport_x + width / 2,
                    viewport_y + height / 2,
                    width - width / 2,
                    height - height / 2,
                )
            };
            draw(&INDICES_CW)?;

            glu::read_pixels(
                &context.render_context,
                viewport_x,
                viewport_y,
                &mut test_img.get_access(),
            )?;
            glu::expect_no_error(gl, "Draw")?;
        }

        // Draw reference
        for y in 0..ref_img.get_height() / 2 {
            for x in 0..ref_img.get_width() / 2 {
                ref_img.set_pixel(x, y, RGBA::green());
            }
        }
        for y in 0..ref_img.get_height() / 2 {
            for x in ref_img.get_width() / 2..ref_img.get_width() {
                ref_img.set_pixel(x, y, RGBA::blue());
            }
        }
        for y in ref_img.get_height() / 2..ref_img.get_height() {
            for x in 0..ref_img.get_width() / 2 {
                ref_img.set_pixel(x, y, RGBA::blue());
            }
        }
        for y in ref_img.get_height() / 2..ref_img.get_height() {
            for x in ref_img.get_width() / 2..ref_img.get_width() {
                ref_img.set_pixel(x, y, RGBA::green());
            }
        }

        compare_verdict(pixel_threshold_compare(&ref_img, &test_img, threshold).ok)
    }
}

/// `FragCoordXYZCase`
pub fn frag_coord_xyz_case(glsl: BuiltinVarGlsl) -> Box<dyn TestCase> {
    Box::new(FragCoordXyzCase { glsl })
}

/// `FragCoordWCase`
pub fn frag_coord_w_case(glsl: BuiltinVarGlsl) -> Box<dyn TestCase> {
    Box::new(FragCoordWCase { glsl })
}

/// `PointCoordCase`
pub fn point_coord_case(glsl: BuiltinVarGlsl) -> Box<dyn TestCase> {
    Box::new(PointCoordCase { glsl })
}

/// `FrontFacingCase`
pub fn front_facing_case(glsl: BuiltinVarGlsl) -> Box<dyn TestCase> {
    Box::new(FrontFacingCase { glsl })
}
