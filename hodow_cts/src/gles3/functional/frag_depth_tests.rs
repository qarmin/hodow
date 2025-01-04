// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFragDepthTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Both case classes need a depth buffer in the default framebuffer, which is why
// `eglu::choose_config` asks for d24s8 - see the README. Without it every case here
// reports NotSupported, which is what upstream does on a colour-only target too.

use crate::gls::shader_render_case::setup_default_uniforms;
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestResult, TestStatus, de_string_hash};

/// `EvalFragDepthFunc`
type EvalFragDepthFunc = fn(coord: [f32; 2]) -> f32;

const VERTEX_SHADER_SRC: &str = concat!(
    "${VERSION_DECL}\n",
    "in highp vec4 a_position;\n",
    "in highp vec2 a_coord;\n",
    "out highp vec2 v_coord;\n",
    "void main (void)\n",
    "{\n",
    "    gl_Position = a_position;\n",
    "    v_coord = a_coord;\n",
    "}\n",
);

const DEFAULT_FRAGMENT_SHADER_SRC: &str = concat!(
    "${VERSION_DECL}\n",
    "uniform highp vec4 u_color;\n",
    "layout(location = 0) out mediump vec4 o_color;\n",
    "void main (void)\n",
    "{\n",
    "    o_color = u_color;\n",
    "}\n",
);

/// `specializeVersion` - ES upstream hard-codes `#version 300 es`; the Khronos copy takes the version from the package.
fn specialize_version(source: &str, version: GlslVersion) -> String {
    source.replace("${VERSION_DECL}", version.declaration())
}

const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

/// The quad the case under test draws: a full-viewport quad whose own depth runs from
/// +1 at the left edge to -1 at the right.
const TEST_POSITION: [f32; 16] = [
    -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, -1.0, 1.0,
];
const TEST_COORD: [f32; 8] = [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0];

/// `compare` - the depth-test comparison, evaluated on the host for the reference.
fn compare(func: GLenum, a: f32, b: f32) -> bool {
    match func {
        glw::GL_NEVER => false,
        glw::GL_ALWAYS => true,
        glw::GL_LESS => a < b,
        glw::GL_LEQUAL => a <= b,
        glw::GL_EQUAL => a == b,
        glw::GL_NOTEQUAL => a != b,
        glw::GL_GEQUAL => a >= b,
        glw::GL_GREATER => a > b,
        other => panic!("{other:#x} is not a depth function"),
    }
}

/// The viewport both cases pick, and the check that a depth buffer exists at all.
fn setup_viewport(context: &Context, name: &str) -> Result<(i32, i32, i32, i32), TestError> {
    let render_target = context.render_context.render_target();

    if render_target.depth_bits == 0 {
        return Err(TestError::NotSupported("Depth buffer is required".to_string()));
    }

    let mut rnd = Random::new(de_string_hash(name));
    let viewport_w = 128.min(render_target.width);
    let viewport_h = 128.min(render_target.height);
    let viewport_x = rnd.get_int(0, render_target.width - viewport_w);
    let viewport_y = rnd.get_int(0, render_target.height - viewport_h);

    Ok((viewport_x, viewport_y, viewport_w, viewport_h))
}

/// `FragDepthCompareCase`
struct FragDepthCompareCase {
    name: &'static str,
    glsl_version: GlslVersion,
    frag_src: &'static str,
    eval_func: EvalFragDepthFunc,
    compare_func: GLenum,
}

impl TestCase for FragDepthCompareCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let (viewport_x, viewport_y, viewport_w, viewport_h) = setup_viewport(context, self.name)?;
        let mut rendered_frame = Surface::new(viewport_w, viewport_h);
        let mut reference_frame = Surface::new(viewport_w, viewport_h);
        const CONST_DEPTH: f32 = 0.1;

        // SAFETY: a current context and plain state setters.
        unsafe {
            gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            gl.enable(glw::GL_DEPTH_TEST);
        }

        // Fill viewport with 2 quads - one with constant depth and another with d = [-1..1]
        {
            let basic_quad_program = ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(
                    specialize_version(VERTEX_SHADER_SRC, self.glsl_version),
                    specialize_version(DEFAULT_FRAGMENT_SHADER_SRC, self.glsl_version),
                ),
            );

            if !basic_quad_program.is_ok() {
                return Err(TestError::Fail("Compile failed".to_string()));
            }

            const CONST_DEPTH_COORD: [f32; 16] = [
                -1.0,
                -1.0,
                CONST_DEPTH,
                1.0,
                -1.0,
                1.0,
                CONST_DEPTH,
                1.0,
                0.0,
                -1.0,
                CONST_DEPTH,
                1.0,
                0.0,
                1.0,
                CONST_DEPTH,
                1.0,
            ];
            const VARYING_DEPTH_COORD: [f32; 16] = [
                0.0, -1.0, 1.0, 1.0, 0.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, -1.0, 1.0,
            ];

            // SAFETY: a linked program and a uniform it declares.
            unsafe {
                gl.use_program(basic_quad_program.program());
                gl.uniform_4f(
                    gl.get_uniform_location(basic_quad_program.program(), c"u_color".as_ptr()),
                    0.0,
                    0.0,
                    1.0,
                    1.0,
                );
                gl.depth_func(glw::GL_ALWAYS);
            }

            let pos_binding = [va::float("a_position", 4, 4, 0, &CONST_DEPTH_COORD)];
            glu::draw(
                render_ctx,
                basic_quad_program.program(),
                &pos_binding,
                &pr::triangles(&QUAD_INDICES),
            )?;

            let pos_binding = [va::float("a_position", 4, 4, 0, &VARYING_DEPTH_COORD)];
            glu::draw(
                render_ctx,
                basic_quad_program.program(),
                &pos_binding,
                &pr::triangles(&QUAD_INDICES),
            )?;

            glu::expect_no_error(gl, "Draw base quads")?;
        }

        // Render with depth test.
        {
            let program = ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(
                    specialize_version(VERTEX_SHADER_SRC, self.glsl_version),
                    specialize_version(self.frag_src, self.glsl_version),
                ),
            );

            if !program.is_ok() {
                return Err(TestError::Fail("Compile failed".to_string()));
            }

            // SAFETY: as above.
            unsafe {
                gl.use_program(program.program());
                gl.depth_func(self.compare_func);
                gl.uniform_4f(
                    gl.get_uniform_location(program.program(), c"u_color".as_ptr()),
                    0.0,
                    1.0,
                    0.0,
                    1.0,
                );
            }

            // Setup default helper uniforms.
            setup_default_uniforms(context, program.program());

            let vertex_arrays = [
                va::float("a_position", 4, 4, 0, &TEST_POSITION),
                va::float("a_coord", 2, 4, 0, &TEST_COORD),
            ];
            glu::draw(
                render_ctx,
                program.program(),
                &vertex_arrays,
                &pr::triangles(&QUAD_INDICES),
            )?;

            glu::expect_no_error(gl, "Draw test quad")?;
        }

        glu::read_pixels(render_ctx, viewport_x, viewport_y, &mut rendered_frame.get_access())?;

        // Render reference.
        #[expect(clippy::cast_precision_loss, reason = "the viewport is at most 128 pixels")]
        for y in 0..reference_frame.get_height() {
            let yf = (y as f32 + 0.5) / reference_frame.get_height() as f32;
            #[expect(
                clippy::cast_possible_truncation,
                reason = "upstream's own cast, clamped right after"
            )]
            let half =
                ((reference_frame.get_width() as f32).mul_add(0.5, 0.5) as i32).clamp(0, reference_frame.get_width());

            // Fill left half - comparison to constant 0.5
            for x in 0..half {
                let xf = (x as f32 + 0.5) / reference_frame.get_width() as f32;
                let d = (self.eval_func)([xf, yf]);
                let dpass = compare(self.compare_func, d, CONST_DEPTH.mul_add(0.5, 0.5));

                reference_frame.set_pixel(x, y, if dpass { RGBA::green() } else { RGBA::blue() });
            }

            // Fill right half - comparison to interpolated depth
            for x in half..reference_frame.get_width() {
                let xf = (x as f32 + 0.5) / reference_frame.get_width() as f32;
                let xh = ((x - half) as f32 + 0.5) / (reference_frame.get_width() - half) as f32;
                let rd = 1.0 - (xh + yf) * 0.5;
                let d = (self.eval_func)([xf, yf]);
                let dpass = compare(self.compare_func, d, rd);

                reference_frame.set_pixel(x, y, if dpass { RGBA::green() } else { RGBA::blue() });
            }
        }

        let is_ok = fuzzy_compare_ok(
            &reference_frame.get_const_access(),
            &rendered_frame.get_const_access(),
            0.05,
        )
        .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::new(TestResult::Fail, "Fail")
        })
    }
}

/// `FragDepthWriteCase`
struct FragDepthWriteCase {
    name: &'static str,
    glsl_version: GlslVersion,
    frag_src: &'static str,
    eval_func: EvalFragDepthFunc,
}

impl TestCase for FragDepthWriteCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let (viewport_x, viewport_y, viewport_w, viewport_h) = setup_viewport(context, self.name)?;
        let mut rendered_frame = Surface::new(viewport_w, viewport_h);
        let mut reference_frame = Surface::new(viewport_w, viewport_h);
        const NUM_DEPTH_STEPS: i32 = 16;
        #[expect(clippy::cast_precision_loss, reason = "a 16-step ramp")]
        let depth_step = 1.0 / (NUM_DEPTH_STEPS - 1) as f32;

        // SAFETY: a current context and plain state setters.
        unsafe {
            gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            gl.enable(glw::GL_DEPTH_TEST);
            gl.depth_func(glw::GL_LESS);
        }

        // Render with given shader.
        {
            let program = ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(
                    specialize_version(VERTEX_SHADER_SRC, self.glsl_version),
                    specialize_version(self.frag_src, self.glsl_version),
                ),
            );

            if !program.is_ok() {
                return Err(TestError::Fail("Compile failed".to_string()));
            }

            // SAFETY: a linked program and a uniform it declares.
            unsafe {
                gl.use_program(program.program());
                gl.uniform_4f(
                    gl.get_uniform_location(program.program(), c"u_color".as_ptr()),
                    0.0,
                    1.0,
                    0.0,
                    1.0,
                );
            }

            // Setup default helper uniforms.
            setup_default_uniforms(context, program.program());

            let vertex_arrays = [
                va::float("a_position", 4, 4, 0, &TEST_POSITION),
                va::float("a_coord", 2, 4, 0, &TEST_COORD),
            ];
            glu::draw(
                render_ctx,
                program.program(),
                &vertex_arrays,
                &pr::triangles(&QUAD_INDICES),
            )?;

            glu::expect_no_error(gl, "Draw test quad")?;
        }

        // Visualize by rendering full-screen quads with increasing depth and color.
        {
            let program = ShaderProgram::new(
                gl,
                &ProgramSources::vtx_frag(
                    specialize_version(VERTEX_SHADER_SRC, self.glsl_version),
                    specialize_version(DEFAULT_FRAGMENT_SHADER_SRC, self.glsl_version),
                ),
            );

            if !program.is_ok() {
                return Err(TestError::Fail("Compile failed".to_string()));
            }

            // SAFETY: a linked program; the attribute and uniform are ones it declares.
            let (pos_loc, color_loc) = unsafe {
                (
                    gl.get_attrib_location(program.program(), c"a_position".as_ptr()),
                    gl.get_uniform_location(program.program(), c"u_color".as_ptr()),
                )
            };

            // SAFETY: as above.
            unsafe {
                gl.use_program(program.program());
                gl.depth_mask(glw::FALSE);
            }

            for step_ndx in 0..NUM_DEPTH_STEPS {
                #[expect(clippy::cast_precision_loss, reason = "a 16-step ramp")]
                let f = step_ndx as f32 * depth_step;
                let depth = f.mul_add(2.0, -1.0);
                let color = [f, f, f, 1.0];

                let position: [f32; 16] = [
                    -1.0, -1.0, depth, 1.0, -1.0, 1.0, depth, 1.0, 1.0, -1.0, depth, 1.0, 1.0, 1.0, depth, 1.0,
                ];
                #[expect(
                    clippy::cast_sign_loss,
                    reason = "`a_position` is declared by the program just linked"
                )]
                let pos_binding = [va::float_at(pos_loc as u32, 4, 4, 0, &position)];

                // SAFETY: four floats for a vec4 uniform.
                unsafe { gl.uniform_4fv(color_loc, 1, color.as_ptr()) };
                glu::draw(
                    render_ctx,
                    program.program(),
                    &pos_binding,
                    &pr::triangles(&QUAD_INDICES),
                )?;
            }

            glu::expect_no_error(gl, "Visualization draw")?;
        }

        glu::read_pixels(render_ctx, viewport_x, viewport_y, &mut rendered_frame.get_access())?;

        // Render reference.
        #[expect(clippy::cast_precision_loss, reason = "the viewport is at most 128 pixels")]
        for y in 0..reference_frame.get_height() {
            for x in 0..reference_frame.get_width() {
                let xf = (x as f32 + 0.5) / reference_frame.get_width() as f32;
                let yf = (y as f32 + 0.5) / reference_frame.get_height() as f32;
                let d = (self.eval_func)([xf, yf]);
                #[expect(clippy::cast_possible_truncation, reason = "upstream's own deFloatFloor cast")]
                let step = (d / depth_step).floor() as i32;
                #[expect(
                    clippy::cast_possible_truncation,
                    reason = "upstream's own deRoundFloatToInt32, clamped"
                )]
                let col = ((step as f32 * depth_step * 255.0).round() as i32).clamp(0, 255);

                reference_frame.set_pixel(x, y, RGBA::new(col, col, col, 0xFF));
            }
        }

        let is_ok = fuzzy_compare_ok(
            &reference_frame.get_const_access(),
            &rendered_frame.get_const_access(),
            0.05,
        )
        .ok_or_else(|| TestError::InternalError("fuzzyCompare on an RGBA8 surface".to_string()))?;

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::new(TestResult::Fail, "Fail")
        })
    }
}

fn eval_const_depth(_coord: [f32; 2]) -> f32 {
    0.5
}

fn eval_dynamic_depth(coord: [f32; 2]) -> f32 {
    (coord[0] + coord[1]) * 0.5
}

fn eval_no_write(coord: [f32; 2]) -> f32 {
    1.0 - (coord[0] + coord[1]) * 0.5
}

fn eval_dynamic_conditional_depth(coord: [f32; 2]) -> f32 {
    let d = (coord[0] + coord[1]) * 0.5;
    if coord[1] < 0.5 { d } else { 1.0 - d }
}

/// `cases` - shared by `.write` and `.compare`, which register the same nine shaders.
const CASES: [(&str, EvalFragDepthFunc, &str); 9] = [
    (
        "no_write",
        eval_no_write,
        concat!(
            "${VERSION_DECL}\n",
            "uniform highp vec4 u_color;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void main (void)\n",
            "{\n",
            "    o_color = u_color;\n",
            "}\n",
        ),
    ),
    (
        "const",
        eval_const_depth,
        concat!(
            "${VERSION_DECL}\n",
            "uniform highp vec4 u_color;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void main (void)\n",
            "{\n",
            "    o_color = u_color;\n",
            "    gl_FragDepth = 0.5;\n",
            "}\n",
        ),
    ),
    (
        "uniform",
        eval_const_depth,
        concat!(
            "${VERSION_DECL}\n",
            "uniform highp vec4 u_color;\n",
            "uniform highp float uf_half;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void main (void)\n",
            "{\n",
            "    o_color = u_color;\n",
            "    gl_FragDepth = uf_half;\n",
            "}\n",
        ),
    ),
    (
        "dynamic",
        eval_dynamic_depth,
        concat!(
            "${VERSION_DECL}\n",
            "uniform highp vec4 u_color;\n",
            "in highp vec2 v_coord;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void main (void)\n",
            "{\n",
            "    o_color = u_color;\n",
            "    gl_FragDepth = (v_coord.x+v_coord.y)*0.5;\n",
            "}\n",
        ),
    ),
    (
        "fragcoord_z",
        eval_no_write,
        concat!(
            "${VERSION_DECL}\n",
            "uniform highp vec4 u_color;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void main (void)\n",
            "{\n",
            "    o_color = u_color;\n",
            "    gl_FragDepth = gl_FragCoord.z;\n",
            "}\n",
        ),
    ),
    (
        "uniform_conditional_write",
        eval_dynamic_depth,
        concat!(
            "${VERSION_DECL}\n",
            "uniform highp vec4 u_color;\n",
            "uniform bool ub_true;\n",
            "in highp vec2 v_coord;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void main (void)\n",
            "{\n",
            "    o_color = u_color;\n",
            "    if (ub_true)\n",
            "        gl_FragDepth = (v_coord.x+v_coord.y)*0.5;\n",
            "}\n",
        ),
    ),
    (
        "dynamic_conditional_write",
        eval_dynamic_conditional_depth,
        concat!(
            "${VERSION_DECL}\n",
            "uniform highp vec4 u_color;\n",
            "uniform bool ub_true;\n",
            "in highp vec2 v_coord;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void main (void)\n",
            "{\n",
            "    o_color = u_color;\n",
            "    mediump float d = (v_coord.x+v_coord.y)*0.5f;\n",
            "    if (v_coord.y < 0.5)\n",
            "        gl_FragDepth = d;\n",
            "    else\n",
            "        gl_FragDepth = 1.0 - d;\n",
            "}\n",
        ),
    ),
    (
        "uniform_loop_write",
        eval_const_depth,
        concat!(
            "${VERSION_DECL}\n",
            "uniform highp vec4 u_color;\n",
            "uniform int ui_two;\n",
            "uniform highp float uf_fourth;\n",
            "in highp vec2 v_coord;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void main (void)\n",
            "{\n",
            "    o_color = u_color;\n",
            "    gl_FragDepth = 0.0;\n",
            "    for (int i = 0; i < ui_two; i++)\n",
            "        gl_FragDepth += uf_fourth;\n",
            "}\n",
        ),
    ),
    (
        "write_in_function",
        eval_dynamic_depth,
        concat!(
            "${VERSION_DECL}\n",
            "uniform highp vec4 u_color;\n",
            "uniform highp float uf_half;\n",
            "in highp vec2 v_coord;\n",
            "layout(location = 0) out mediump vec4 o_color;\n",
            "void myfunc (highp vec2 coord)\n",
            "{\n",
            "    gl_FragDepth = (coord.x+coord.y)*0.5;\n",
            "}\n",
            "void main (void)\n",
            "{\n",
            "    o_color = u_color;\n",
            "    myfunc(v_coord);\n",
            "}\n",
        ),
    ),
];

/// `FragDepthTests::init`
pub fn create_tests() -> TestCaseGroup {
    create_group(GlslVersion::Es300)
}

/// `glcts` `FragDepthTests::init`, for the desktop packages.
pub fn create_khronos_tests(glsl_version: GlslVersion) -> TestCaseGroup {
    create_group(glsl_version)
}

fn create_group(glsl_version: GlslVersion) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fragdepth");

    // .write
    let mut write_group = TestCaseGroup::new("write");
    for (name, eval_func, frag_src) in CASES {
        write_group.add_child(Box::new(FragDepthWriteCase {
            name,
            glsl_version,
            frag_src,
            eval_func,
        }) as Box<dyn TestCase>);
    }
    group.add_child(write_group);

    // .compare
    let mut compare_group = TestCaseGroup::new("compare");
    for (name, eval_func, frag_src) in CASES {
        compare_group.add_child(Box::new(FragDepthCompareCase {
            name,
            glsl_version,
            frag_src,
            eval_func,
            compare_func: glw::GL_LESS,
        }) as Box<dyn TestCase>);
    }
    group.add_child(compare_group);

    group
}
