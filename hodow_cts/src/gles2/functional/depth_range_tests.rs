// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDepthRangeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Needs no rasterised reference image:
// both cases render a simple quad and compute the expected per-pixel colour
// analytically (a bilinear interpolation across the quad's own four corner depth
// values, split by upstream's own "top left" triangle fill rule), then compare against
// the real framebuffer with `tcu::fuzzyCompare`.

use crate::glu::{Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, expect_no_error, read_pixels};
use crate::glw::{self, GLenum};
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::{RGBA, Random, Surface, TestError, TestOutcome, TestStatus, de_string_hash};

const VISUALIZE_DEPTH_STEPS: i32 = 32;

const VERTEX_SOURCE: &str = concat!(
    "attribute highp vec4 a_position;\n",
    "attribute highp vec2 a_coord;\n",
    "void main (void)\n",
    "{\n",
    "    gl_Position = a_position;\n",
    "}\n"
);
const FRAGMENT_SOURCE: &str = concat!(
    "uniform mediump vec4 u_color;\n",
    "void main (void)\n",
    "{\n",
    "    gl_FragColor = u_color;\n",
    "}\n"
);

const QUAD_INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

/// `compare<T>` - a runtime GL comparison function applied to two `f32`s.
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
        _ => false,
    }
}

fn triangle_interpolate(v0: f32, v1: f32, v2: f32, x: f32, y: f32) -> f32 {
    v0 + (v2 - v0) * x + (v1 - v0) * y
}

/// `triQuadInterpolate` - `quad` holds the four corner values in the same order the
/// vertex position arrays below list them: bottom-left, top-left, bottom-right,
/// top-right.
fn tri_quad_interpolate(x: f32, y: f32, quad: [f32; 4]) -> f32 {
    // Top left fill rule.
    if x + y < 1.0 {
        triangle_interpolate(quad[0], quad[1], quad[2], x, y)
    } else {
        triangle_interpolate(quad[3], quad[2], quad[1], 1.0 - x, 1.0 - y)
    }
}

fn depth_range_transform(zd: f32, z_near: f32, z_far: f32) -> f32 {
    let c_near = z_near.clamp(0.0, 1.0);
    let c_far = z_far.clamp(0.0, 1.0);
    ((c_far - c_near) / 2.0) * zd + (c_near + c_far) / 2.0
}

/// One entry of upstream's `cases[]` table, shared by both case classes.
#[derive(Clone, Copy)]
struct Spec {
    name: &'static str,
    depth_coord: [f32; 4],
    z_near: f32,
    z_far: f32,
}

const CASES: &[Spec] = &[
    Spec {
        name: "default",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 0.0,
        z_far: 1.0,
    },
    Spec {
        name: "reverse",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 1.0,
        z_far: 0.0,
    },
    Spec {
        name: "zero_to_half",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 0.0,
        z_far: 0.5,
    },
    Spec {
        name: "half_to_one",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 0.5,
        z_far: 1.0,
    },
    Spec {
        name: "half_to_zero",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 0.5,
        z_far: 0.0,
    },
    Spec {
        name: "one_to_half",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 1.0,
        z_far: 0.5,
    },
    Spec {
        name: "third_to_0_8",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 1.0 / 3.0,
        z_far: 0.8,
    },
    Spec {
        name: "0_8_to_third",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 0.8,
        z_far: 1.0 / 3.0,
    },
    Spec {
        name: "zero_to_zero",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 0.0,
        z_far: 0.0,
    },
    Spec {
        name: "half_to_half",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 0.5,
        z_far: 0.5,
    },
    Spec {
        name: "one_to_one",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 1.0,
        z_far: 1.0,
    },
    Spec {
        name: "clamp_near",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: -1.0,
        z_far: 1.0,
    },
    Spec {
        name: "clamp_far",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: 0.0,
        z_far: 2.0,
    },
    Spec {
        name: "clamp_both",
        depth_coord: [-1.0, 0.2, -0.3, 1.0],
        z_near: -1.0,
        z_far: 2.0,
    },
];

fn build_program<'gl>(gl: &'gl glw::Functions) -> Result<ShaderProgram<'gl>, TestError> {
    let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(VERTEX_SOURCE, FRAGMENT_SOURCE));
    if !program.is_ok() {
        return Err(TestError::Fail("Compile failed".to_string()));
    }
    Ok(program)
}

fn check_depth_buffer_support(context: &Context) -> Result<(), TestError> {
    if context.render_target().depth_bits == 0 {
        Err(TestError::NotSupported("Depth buffer is required".to_string()))
    } else {
        Ok(())
    }
}

/// A `128x128`-or-smaller viewport at a random position within the render target -
/// upstream's own `viewportX`/`viewportY`/`viewportW`/`viewportH`.
fn random_viewport(context: &Context, rnd: &mut Random) -> (i32, i32, i32, i32) {
    let render_target = context.render_target();
    let w = 128.min(render_target.width);
    let h = 128.min(render_target.height);
    let x = rnd.get_int(0, render_target.width - w);
    let y = rnd.get_int(0, render_target.height - h);
    (x, y, w, h)
}

fn fuzzy_verdict(reference: &Surface, rendered: &Surface) -> TestOutcome {
    let ok = fuzzy_compare_ok(&reference.get_const_access(), &rendered.get_const_access(), 0.05)
        .ok_or_else(|| TestError::InternalError("fuzzy_compare: unsupported surface format".to_string()))?;
    if ok {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

/// `DepthRangeCompareCase` - `gl_FragDepth` (via the depth-range-transformed vertex z)
/// used with a depth comparison.
struct DepthRangeCompareCase {
    spec: Spec,
    compare_func: GLenum,
}

impl TestCase for DepthRangeCompareCase {
    fn name(&self) -> &str {
        self.spec.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_depth_buffer_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const CONST_DEPTH: f32 = 0.1;

        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(self.spec.name));
        let (viewport_x, viewport_y, viewport_w, viewport_h) = random_viewport(context, &mut rnd);

        let program = build_program(gl)?;
        // SAFETY: `program` was just built successfully.
        let (color_loc, pos_loc) = unsafe {
            (
                gl.get_uniform_location(program.program(), c"u_color".as_ptr()),
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()) as u32,
            )
        };

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

        // Fill viewport with 2 quads - one with constant depth and another with d = [-1..1].
        // SAFETY: `program` is current for the whole function; every buffer used below
        // is a local array outliving its own `draw_elements` call.
        unsafe {
            gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            gl.enable(glw::GL_DEPTH_TEST);
            gl.use_program(program.program());
            gl.enable_vertex_attrib_array(pos_loc);

            gl.uniform_4f(color_loc, 0.0, 0.0, 1.0, 1.0);
            gl.depth_func(glw::GL_ALWAYS);

            gl.vertex_attrib_pointer(
                pos_loc,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                CONST_DEPTH_COORD.as_ptr().cast(),
            );
            gl.draw_elements(
                glw::GL_TRIANGLES,
                6,
                glw::GL_UNSIGNED_SHORT,
                QUAD_INDICES.as_ptr().cast(),
            );

            gl.vertex_attrib_pointer(
                pos_loc,
                4,
                glw::GL_FLOAT,
                glw::GL_FALSE as glw::GLboolean,
                0,
                VARYING_DEPTH_COORD.as_ptr().cast(),
            );
            gl.draw_elements(
                glw::GL_TRIANGLES,
                6,
                glw::GL_UNSIGNED_SHORT,
                QUAD_INDICES.as_ptr().cast(),
            );
        }
        expect_no_error(gl, "fill viewport")?;

        // Render with depth test.
        {
            let position: [f32; 16] = [
                -1.0,
                -1.0,
                self.spec.depth_coord[0],
                1.0,
                -1.0,
                1.0,
                self.spec.depth_coord[1],
                1.0,
                1.0,
                -1.0,
                self.spec.depth_coord[2],
                1.0,
                1.0,
                1.0,
                self.spec.depth_coord[3],
                1.0,
            ];

            // SAFETY: as above.
            unsafe {
                gl.depth_rangef(self.spec.z_near, self.spec.z_far);
                gl.depth_func(self.compare_func);
                gl.uniform_4f(color_loc, 0.0, 1.0, 0.0, 1.0);
                gl.vertex_attrib_pointer(
                    pos_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::GL_FALSE as glw::GLboolean,
                    0,
                    position.as_ptr().cast(),
                );
                gl.draw_elements(
                    glw::GL_TRIANGLES,
                    6,
                    glw::GL_UNSIGNED_SHORT,
                    QUAD_INDICES.as_ptr().cast(),
                );
            }
            expect_no_error(gl, "render with depth test")?;
        }

        let mut rendered = Surface::new(viewport_w, viewport_h);
        read_pixels(
            &context.render_context,
            viewport_x,
            viewport_y,
            &mut rendered.get_access(),
        )?;

        let mut reference = Surface::new(viewport_w, viewport_h);
        for y in 0..viewport_h {
            let yf = (y as f32 + 0.5) / viewport_h as f32;
            let half = ((viewport_w as f32 * 0.5 + 0.5) as i32).clamp(0, viewport_w);

            // Left half - comparison to the constant-depth quad.
            for x in 0..half {
                let xf = (x as f32 + 0.5) / viewport_w as f32;
                let d = depth_range_transform(
                    tri_quad_interpolate(xf, yf, self.spec.depth_coord),
                    self.spec.z_near,
                    self.spec.z_far,
                );
                let dpass = compare(self.compare_func, d, CONST_DEPTH * 0.5 + 0.5);
                reference.set_pixel(x, y, if dpass { RGBA::green() } else { RGBA::blue() });
            }

            // Right half - comparison to the varying-depth quad.
            for x in half..viewport_w {
                let xf = (x as f32 + 0.5) / viewport_w as f32;
                let xh = ((x - half) as f32 + 0.5) / (viewport_w - half) as f32;
                let rd = 1.0 - (xh + yf) * 0.5;
                let d = depth_range_transform(
                    tri_quad_interpolate(xf, yf, self.spec.depth_coord),
                    self.spec.z_near,
                    self.spec.z_far,
                );
                let dpass = compare(self.compare_func, d, rd);
                reference.set_pixel(x, y, if dpass { RGBA::green() } else { RGBA::blue() });
            }
        }

        fuzzy_verdict(&reference, &rendered)
    }
}

/// `DepthRangeWriteCase` - visualises the depth-range-transformed depth by revealing it
/// through a `GL_LEQUAL` depth test against 32 successive candidate depths.
struct DepthRangeWriteCase {
    spec: Spec,
}

impl TestCase for DepthRangeWriteCase {
    fn name(&self) -> &str {
        self.spec.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_depth_buffer_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let num_depth_steps = VISUALIZE_DEPTH_STEPS;
        let depth_step = 1.0 / (num_depth_steps - 1) as f32;

        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(self.spec.name));
        let (viewport_x, viewport_y, viewport_w, viewport_h) = random_viewport(context, &mut rnd);

        let program = build_program(gl)?;
        // SAFETY: `program` was just built successfully.
        let (color_loc, pos_loc) = unsafe {
            (
                gl.get_uniform_location(program.program(), c"u_color".as_ptr()),
                gl.get_attrib_location(program.program(), c"a_position".as_ptr()) as u32,
            )
        };

        // SAFETY: `program` is current for the whole function.
        unsafe {
            gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            gl.enable(glw::GL_DEPTH_TEST);
            gl.use_program(program.program());
            gl.enable_vertex_attrib_array(pos_loc);
        }

        // Render with depth range - writes the transformed depth of `depth_coord` into
        // the depth buffer, at every pixel (GL_ALWAYS).
        {
            let position: [f32; 16] = [
                -1.0,
                -1.0,
                self.spec.depth_coord[0],
                1.0,
                -1.0,
                1.0,
                self.spec.depth_coord[1],
                1.0,
                1.0,
                -1.0,
                self.spec.depth_coord[2],
                1.0,
                1.0,
                1.0,
                self.spec.depth_coord[3],
                1.0,
            ];

            // SAFETY: as above.
            unsafe {
                gl.depth_func(glw::GL_ALWAYS);
                gl.depth_rangef(self.spec.z_near, self.spec.z_far);
                gl.uniform_4f(color_loc, 0.0, 1.0, 0.0, 1.0);
                gl.vertex_attrib_pointer(
                    pos_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::GL_FALSE as glw::GLboolean,
                    0,
                    position.as_ptr().cast(),
                );
                gl.draw_elements(
                    glw::GL_TRIANGLES,
                    6,
                    glw::GL_UNSIGNED_SHORT,
                    QUAD_INDICES.as_ptr().cast(),
                );
            }
            expect_no_error(gl, "render with depth range")?;
        }

        // Visualize by rendering full-screen quads with increasing depth and colour;
        // the depth range reverts to the plain [0, 1] one and no further depth write
        // happens, so the colour of the last step whose own depth still passes
        // GL_LEQUAL against the buffer written above is what survives.
        // SAFETY: as above; `depth_mask(GL_FALSE)` is left in that state deliberately,
        // matching upstream - the case ends right after this loop.
        unsafe {
            gl.depth_func(glw::GL_LEQUAL);
            gl.depth_mask(glw::GL_FALSE as glw::GLboolean);
            gl.depth_rangef(0.0, 1.0);

            for step_ndx in 0..num_depth_steps {
                let f = step_ndx as f32 * depth_step;
                let depth = f * 2.0 - 1.0;
                let color = [f, f, f, 1.0];

                let position: [f32; 16] = [
                    -1.0, -1.0, depth, 1.0, -1.0, 1.0, depth, 1.0, 1.0, -1.0, depth, 1.0, 1.0, 1.0, depth, 1.0,
                ];

                gl.uniform_4fv(color_loc, 1, color.as_ptr());
                gl.vertex_attrib_pointer(
                    pos_loc,
                    4,
                    glw::GL_FLOAT,
                    glw::GL_FALSE as glw::GLboolean,
                    0,
                    position.as_ptr().cast(),
                );
                gl.draw_elements(
                    glw::GL_TRIANGLES,
                    6,
                    glw::GL_UNSIGNED_SHORT,
                    QUAD_INDICES.as_ptr().cast(),
                );
            }
        }
        expect_no_error(gl, "visualize")?;

        let mut rendered = Surface::new(viewport_w, viewport_h);
        read_pixels(
            &context.render_context,
            viewport_x,
            viewport_y,
            &mut rendered.get_access(),
        )?;

        let mut reference = Surface::new(viewport_w, viewport_h);
        for y in 0..viewport_h {
            for x in 0..viewport_w {
                let xf = (x as f32 + 0.5) / viewport_w as f32;
                let yf = (y as f32 + 0.5) / viewport_h as f32;
                let d = depth_range_transform(
                    tri_quad_interpolate(xf, yf, self.spec.depth_coord),
                    self.spec.z_near,
                    self.spec.z_far,
                );
                let step = (d / depth_step).floor();
                let col = ((step * depth_step * 255.0).round() as i32).clamp(0, 255);

                reference.set_pixel(x, y, RGBA::new(col, col, col, 0xff));
            }
        }

        fuzzy_verdict(&reference, &rendered)
    }
}

/// `DepthRangeTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("depth_range");

    let mut write_group = TestCaseGroup::new("write");
    for &spec in CASES {
        write_group.add_child(Box::new(DepthRangeWriteCase { spec }) as Box<dyn TestCase>);
    }
    group.add_child(write_group);

    let mut compare_group = TestCaseGroup::new("compare");
    for &spec in CASES {
        compare_group.add_child(Box::new(DepthRangeCompareCase {
            spec,
            compare_func: glw::GL_LESS,
        }) as Box<dyn TestCase>);
    }
    group.add_child(compare_group);

    group
}
