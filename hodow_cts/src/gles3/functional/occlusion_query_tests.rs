// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fOcclusionQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `iterate` returns
// CONTINUE and is re-entered NUM_CASE_ITERATIONS times; here that is a loop inside
// `iterate`, and the program upstream builds in `init` is built once above the loop,
// because a `TestCase` here is immutable and has no `init` phase. The RNG is seeded
// once per case (upstream's `m_rnd` is a member, so it carries across iterations),
// which keeps the per-iteration inputs in the same sequence.

use std::ffi::CString;

use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::random::de_string_hash;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

const DEPTH_WRITE_COLOR: [f32; 4] = [0.0, 0.0, 1.0, 1.0];
const DEPTH_CLEAR_COLOR: [f32; 4] = [0.0, 0.5, 0.8, 1.0];
const STENCIL_WRITE_COLOR: [f32; 4] = [0.0, 1.0, 0.0, 1.0];
const STENCIL_CLEAR_COLOR: [f32; 4] = [0.0, 0.8, 0.5, 1.0];
const TARGET_COLOR: [f32; 4] = [1.0, 0.0, 0.0, 1.0];
const ELEMENTS_PER_VERTEX: usize = 4;
const NUM_CASE_ITERATIONS: i32 = 10;

// Constants to tweak visible/invisible case probability balance.

const DEPTH_CLEAR_OFFSET: i32 = 100;
const STENCIL_CLEAR_OFFSET: i32 = 100;
const SCISSOR_OFFSET: i32 = 100;
const SCISSOR_MINSIZE: i32 = 250;

const OCCLUDER_SCISSOR: u32 = 1 << 0;
const OCCLUDER_DEPTH_WRITE: u32 = 1 << 1;
const OCCLUDER_DEPTH_CLEAR: u32 = 1 << 2;
const OCCLUDER_STENCIL_WRITE: u32 = 1 << 3;
const OCCLUDER_STENCIL_CLEAR: u32 = 1 << 4;

/// `generateVertices`. Upstream takes `de::Random` **by value**, so every call inside a
/// single iteration restarts from the same stream; reproduced here by cloning.
fn generate_vertices(
    dst: &mut Vec<f32>,
    width: f32,
    height: f32,
    primitive_count: i32,
    vertices_per_primitive: i32,
    rnd: &Random,
    primitive_size: f32,
    min_z: f32,
    max_z: f32,
) {
    let mut rnd = *rnd;

    let w = width / 2.0;
    let h = height / 2.0;
    let s = primitive_size / 2.0;

    let vertex_count = vertices_per_primitive * primitive_count;
    dst.clear();
    dst.resize(vertex_count as usize * ELEMENTS_PER_VERTEX, 0.0);

    // First loop gets a random point inside the unit square.
    let mut i = 0;
    while i < vertex_count {
        let rnd_x = rnd.get_float_range(-w, w);
        let rnd_y = rnd.get_float_range(-h, h);

        // Second loop gets 3 random points within given distance s from (rndX, rndY).
        for j in 0..vertices_per_primitive {
            // Upstream indexes unguarded here; every caller passes 3, which keeps
            // (i + j) inside the buffer because the outer loop steps by 3.
            let base = (i + j) as usize * ELEMENTS_PER_VERTEX;
            if base + 3 >= dst.len() {
                break;
            }
            dst[base] = rnd_x + rnd.get_float_range(-s, s);
            dst[base + 1] = rnd_y + rnd.get_float_range(-s, s);
            dst[base + 2] = rnd.get_float_range(min_z, max_z);
            dst[base + 3] = 1.0;
        }

        i += 3;
    }
}

#[derive(Clone, Copy)]
struct OcclusionQueryCase {
    name: &'static str,
    num_occluder_draws: i32,
    num_occluders_per_draw: i32,
    occluder_size: f32,
    num_target_draws: i32,
    num_targets_per_draw: i32,
    target_size: f32,
    query_mode: u32,
    occluder_types: u32,
}

impl OcclusionQueryCase {
    /// One pass of upstream's `iterate` body.
    fn run_iteration(&self, context: &Context, program: &ShaderProgram, rnd: &mut Random) -> Result<(), TestError> {
        let gl = context.gl();
        let render_target = context.render_target();
        let target_w = render_target.width;
        let target_h = render_target.height;

        let color_name = CString::new("u_color").expect("literal has no nul");
        // SAFETY: valid program, nul-terminated name.
        let color_unif = unsafe { gl.get_uniform_location(program.program(), color_name.as_ptr()) };

        let mut occluder_vertices: Vec<f32> = Vec::new();
        let mut target_vertices: Vec<f32> = Vec::new();
        let mut query_id: u32 = 0;

        // SAFETY: plain state setup on the current context.
        unsafe {
            gl.clear_color(0.0, 0.0, 0.0, 1.0);
            gl.clear_depthf(1.0);
            gl.clear_stencil(0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            gl.use_program(program.program());
            gl.enable_vertex_attrib_array(0);
        }

        // Draw occluders.

        let mut occ_options: Vec<u32> = Vec::new();
        if self.occluder_types & OCCLUDER_DEPTH_WRITE != 0 {
            occ_options.push(OCCLUDER_DEPTH_WRITE);
        }
        if self.occluder_types & OCCLUDER_DEPTH_CLEAR != 0 {
            occ_options.push(OCCLUDER_DEPTH_CLEAR);
        }
        if self.occluder_types & OCCLUDER_STENCIL_WRITE != 0 {
            occ_options.push(OCCLUDER_STENCIL_WRITE);
        }
        if self.occluder_types & OCCLUDER_STENCIL_CLEAR != 0 {
            occ_options.push(OCCLUDER_STENCIL_CLEAR);
        }

        for _ in 0..self.num_occluder_draws {
            if occ_options.is_empty() {
                break;
            }

            let occluder_type = occ_options[rnd.get_int(0, occ_options.len() as i32 - 1) as usize];

            match occluder_type {
                OCCLUDER_DEPTH_WRITE => {
                    generate_vertices(
                        &mut occluder_vertices,
                        2.0,
                        2.0,
                        self.num_occluders_per_draw,
                        3,
                        rnd,
                        self.occluder_size,
                        0.0,
                        0.6,
                    );

                    // SAFETY: the pointer stays valid for the duration of the draw.
                    unsafe {
                        gl.enable(glw::GL_DEPTH_TEST);
                        gl.uniform_4f(
                            color_unif,
                            DEPTH_WRITE_COLOR[0],
                            DEPTH_WRITE_COLOR[1],
                            DEPTH_WRITE_COLOR[2],
                            DEPTH_WRITE_COLOR[3],
                        );
                        gl.vertex_attrib_pointer(
                            0,
                            ELEMENTS_PER_VERTEX as i32,
                            glw::GL_FLOAT,
                            glw::FALSE,
                            0,
                            occluder_vertices.as_ptr().cast(),
                        );
                        gl.draw_arrays(glw::GL_TRIANGLES, 0, 3 * self.num_occluders_per_draw);
                        gl.disable(glw::GL_DEPTH_TEST);
                    }
                }

                OCCLUDER_DEPTH_CLEAR => {
                    let scissor_box_x = rnd.get_int(-DEPTH_CLEAR_OFFSET, target_w);
                    let scissor_box_y = rnd.get_int(-DEPTH_CLEAR_OFFSET, target_h);
                    let scissor_box_w = rnd.get_int(DEPTH_CLEAR_OFFSET, target_w + DEPTH_CLEAR_OFFSET);
                    let scissor_box_h = rnd.get_int(DEPTH_CLEAR_OFFSET, target_h + DEPTH_CLEAR_OFFSET);

                    // SAFETY: scissored clear on the current context.
                    unsafe {
                        gl.enable(glw::GL_SCISSOR_TEST);
                        gl.scissor(scissor_box_x, scissor_box_y, scissor_box_w, scissor_box_h);
                        gl.clear_depthf(0.0);
                        gl.clear_color(
                            DEPTH_CLEAR_COLOR[0],
                            DEPTH_CLEAR_COLOR[1],
                            DEPTH_CLEAR_COLOR[2],
                            DEPTH_CLEAR_COLOR[3],
                        );
                        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT);
                        gl.disable(glw::GL_SCISSOR_TEST);
                    }
                }

                OCCLUDER_STENCIL_WRITE => {
                    generate_vertices(
                        &mut occluder_vertices,
                        2.0,
                        2.0,
                        self.num_occluders_per_draw,
                        3,
                        rnd,
                        self.occluder_size,
                        0.0,
                        0.6,
                    );

                    // SAFETY: the pointer stays valid for the duration of the draw.
                    unsafe {
                        gl.stencil_func(glw::GL_ALWAYS, 1, 0xFF);
                        gl.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_REPLACE);
                        gl.enable(glw::GL_STENCIL_TEST);
                        gl.uniform_4f(
                            color_unif,
                            STENCIL_WRITE_COLOR[0],
                            STENCIL_WRITE_COLOR[1],
                            STENCIL_WRITE_COLOR[2],
                            STENCIL_WRITE_COLOR[3],
                        );
                        gl.vertex_attrib_pointer(
                            0,
                            ELEMENTS_PER_VERTEX as i32,
                            glw::GL_FLOAT,
                            glw::FALSE,
                            0,
                            occluder_vertices.as_ptr().cast(),
                        );
                        gl.draw_arrays(glw::GL_TRIANGLES, 0, 3 * self.num_occluders_per_draw);
                        gl.disable(glw::GL_STENCIL_TEST);
                    }
                }

                OCCLUDER_STENCIL_CLEAR => {
                    let scissor_box_x = rnd.get_int(-STENCIL_CLEAR_OFFSET, target_w);
                    let scissor_box_y = rnd.get_int(-STENCIL_CLEAR_OFFSET, target_h);
                    let scissor_box_w = rnd.get_int(STENCIL_CLEAR_OFFSET, target_w + STENCIL_CLEAR_OFFSET);
                    let scissor_box_h = rnd.get_int(STENCIL_CLEAR_OFFSET, target_h + STENCIL_CLEAR_OFFSET);

                    // SAFETY: scissored clear on the current context.
                    unsafe {
                        gl.enable(glw::GL_SCISSOR_TEST);
                        gl.scissor(scissor_box_x, scissor_box_y, scissor_box_w, scissor_box_h);
                        gl.clear_stencil(1);
                        gl.clear_color(
                            STENCIL_CLEAR_COLOR[0],
                            STENCIL_CLEAR_COLOR[1],
                            STENCIL_CLEAR_COLOR[2],
                            STENCIL_CLEAR_COLOR[3],
                        );
                        gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
                        gl.disable(glw::GL_SCISSOR_TEST);
                    }
                }

                _ => debug_assert!(false, "unknown occluder type"),
            }
        }

        if self.occluder_types & OCCLUDER_SCISSOR != 0 {
            let scissor_box_x = rnd.get_int(-SCISSOR_OFFSET, target_w - SCISSOR_OFFSET);
            let scissor_box_y = rnd.get_int(-SCISSOR_OFFSET, target_h - SCISSOR_OFFSET);
            let scissor_box_w = rnd.get_int(SCISSOR_MINSIZE, target_w + SCISSOR_OFFSET);
            let scissor_box_h = rnd.get_int(SCISSOR_MINSIZE, target_h + SCISSOR_OFFSET);

            // SAFETY: enables the scissor test for the target draws below.
            unsafe {
                gl.enable(glw::GL_SCISSOR_TEST);
                gl.scissor(scissor_box_x, scissor_box_y, scissor_box_w, scissor_box_h);
            }
        }

        // SAFETY: `query_id` is a live u32.
        unsafe {
            gl.gen_queries(1, &raw mut query_id);
            gl.begin_query(self.query_mode, query_id);
        }
        glu::expect_no_error(gl, "Occlusion query started")?;

        // Draw target primitives.

        // SAFETY: depth/stencil test state for the target draws.
        unsafe {
            gl.enable(glw::GL_DEPTH_TEST);
            gl.enable(glw::GL_STENCIL_TEST);
            gl.stencil_func(glw::GL_EQUAL, 0, 0xFF);
        }

        for _ in 0..self.num_target_draws {
            generate_vertices(
                &mut target_vertices,
                2.0,
                2.0,
                self.num_targets_per_draw,
                3,
                rnd,
                self.target_size,
                0.4,
                1.0,
            );

            if !target_vertices.is_empty() {
                // SAFETY: the pointer stays valid for the duration of the draw.
                unsafe {
                    gl.uniform_4f(
                        color_unif,
                        TARGET_COLOR[0],
                        TARGET_COLOR[1],
                        TARGET_COLOR[2],
                        TARGET_COLOR[3],
                    );
                    gl.vertex_attrib_pointer(
                        0,
                        ELEMENTS_PER_VERTEX as i32,
                        glw::GL_FLOAT,
                        glw::FALSE,
                        0,
                        target_vertices.as_ptr().cast(),
                    );
                    gl.draw_arrays(glw::GL_TRIANGLES, 0, 3 * self.num_targets_per_draw);
                }
            }
        }

        // SAFETY: ends the query and flushes it to completion.
        unsafe {
            gl.end_query(self.query_mode);
            gl.finish();
            gl.disable(glw::GL_SCISSOR_TEST);
            gl.disable(glw::GL_STENCIL_TEST);
            gl.disable(glw::GL_DEPTH_TEST);
        }

        // Check that query result is available.
        let mut result_available: u32 = glw::GL_FALSE as u32;
        // SAFETY: `query_id` names a live query object.
        unsafe {
            gl.get_query_objectuiv(query_id, glw::GL_QUERY_RESULT_AVAILABLE, &raw mut result_available);
        }

        if result_available == glw::GL_FALSE as u32 {
            // SAFETY: `query_id` names a live query object.
            unsafe { gl.delete_queries(1, &raw const query_id) };
            return Err(TestError::Fail(
                "Occlusion query failed to return a result after glFinish()".to_string(),
            ));
        }

        // Read query result.
        let mut result: u32 = 0;
        // SAFETY: `query_id` names a live query object with an available result.
        unsafe {
            gl.get_query_objectuiv(query_id, glw::GL_QUERY_RESULT, &raw mut result);
            gl.delete_queries(1, &raw const query_id);
        }
        let query_result = result != glw::GL_FALSE as u32;
        glu::expect_no_error(gl, "Occlusion query finished")?;

        // Read pixel data.

        let mut pixels = Surface::new(render_target.width, render_target.height);
        glu::read_pixels(&context.render_context, 0, 0, &mut pixels.get_access())?;

        let mut color_read_result = false;
        'outer: for y in 0..pixels.get_height() {
            for x in 0..pixels.get_width() {
                if pixels.get_pixel(x, y).get_red() != 0 {
                    color_read_result = true;
                    break 'outer;
                }
            }
        }

        let test_ok = if self.query_mode == glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE {
            if query_result || color_read_result {
                // Allow conservative occlusion query to return false positives.
                query_result
            } else {
                query_result == color_read_result
            }
        } else {
            query_result == color_read_result
        };

        if !test_ok {
            return Err(TestError::Fail(format!(
                "Occlusion query result: target {}, framebuffer read result: target {}",
                if query_result { "visible" } else { "invisible" },
                if color_read_result { "visible" } else { "invisible" }
            )));
        }

        Ok(())
    }
}

impl TestCase for OcclusionQueryCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

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
                    "    mediump float depth_gradient = max(gl_FragCoord.z, 0.0);\n",
                    "    mediump float bias = 0.1;\n",
                    "    dEQP_FragColor = vec4(u_color.xyz * (depth_gradient + bias), 1.0);\n",
                    "}\n"
                ),
            ),
        );

        if !program.is_ok() {
            return Err(TestError::Fail("Failed to compile shader program".to_string()));
        }

        let mut rnd = Random::new(de_string_hash(self.name));

        for _ in 0..NUM_CASE_ITERATIONS {
            self.run_iteration(context, &program, &mut rnd)?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

#[rustfmt::skip]
const CASES: &[OcclusionQueryCase] = &[
    OcclusionQueryCase { name: "scissor", num_occluder_draws: 1, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 1, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR },
    OcclusionQueryCase { name: "depth_write", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 7, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_WRITE },
    OcclusionQueryCase { name: "depth_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.2, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_CLEAR },
    OcclusionQueryCase { name: "stencil_write", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 2.0, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "stencil_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 2.0, num_target_draws: 1, num_targets_per_draw: 3, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "scissor_depth_write", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE },
    OcclusionQueryCase { name: "scissor_depth_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 1.0, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_CLEAR },
    OcclusionQueryCase { name: "scissor_stencil_write", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "scissor_stencil_clear", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 1.0, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "depth_write_depth_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.2, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR },
    OcclusionQueryCase { name: "depth_write_stencil_write", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "depth_write_stencil_clear", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "depth_clear_stencil_write", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "depth_clear_stencil_clear", num_occluder_draws: 12, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.2, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "stencil_write_stencil_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 2.0, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "scissor_depth_write_depth_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR },
    OcclusionQueryCase { name: "scissor_depth_write_stencil_write", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "scissor_depth_write_stencil_clear", num_occluder_draws: 6, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "scissor_depth_clear_stencil_write", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "scissor_depth_clear_stencil_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "scissor_stencil_write_stencil_clear", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "depth_write_depth_clear_stencil_write", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "depth_write_depth_clear_stencil_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "depth_write_stencil_write_stencil_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "depth_clear_stencil_write_stencil_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "scissor_depth_write_depth_clear_stencil_write", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "scissor_depth_write_depth_clear_stencil_clear", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "scissor_depth_write_stencil_write_stencil_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "scissor_depth_clear_stencil_write_stencil_clear", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "depth_write_depth_clear_stencil_write_stencil_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "all_occluders", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 3, num_targets_per_draw: 5, target_size: 0.6, query_mode: glw::GL_ANY_SAMPLES_PASSED, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor", num_occluder_draws: 1, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 1, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR },
    OcclusionQueryCase { name: "conservative_depth_write", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 7, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_WRITE },
    OcclusionQueryCase { name: "conservative_depth_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.2, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_CLEAR },
    OcclusionQueryCase { name: "conservative_stencil_write", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 2.0, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "conservative_stencil_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 2.0, num_target_draws: 1, num_targets_per_draw: 3, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor_depth_write", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE },
    OcclusionQueryCase { name: "conservative_scissor_depth_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 1.0, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor_stencil_write", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "conservative_scissor_stencil_clear", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 1.0, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_depth_write_depth_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.2, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR },
    OcclusionQueryCase { name: "conservative_depth_write_stencil_write", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "conservative_depth_write_stencil_clear", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_depth_clear_stencil_write", num_occluder_draws: 8, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.3, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "conservative_depth_clear_stencil_clear", num_occluder_draws: 12, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.2, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_stencil_write_stencil_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 2.0, num_target_draws: 1, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor_depth_write_depth_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor_depth_write_stencil_write", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "conservative_scissor_depth_write_stencil_clear", num_occluder_draws: 6, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor_depth_clear_stencil_write", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "conservative_scissor_depth_clear_stencil_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor_stencil_write_stencil_clear", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_depth_write_depth_clear_stencil_write", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "conservative_depth_write_depth_clear_stencil_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_depth_write_stencil_write_stencil_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_depth_clear_stencil_write_stencil_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor_depth_write_depth_clear_stencil_write", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE },
    OcclusionQueryCase { name: "conservative_scissor_depth_write_depth_clear_stencil_clear", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor_depth_write_stencil_write_stencil_clear", num_occluder_draws: 5, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_scissor_depth_clear_stencil_write_stencil_clear", num_occluder_draws: 4, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_depth_write_depth_clear_stencil_write_stencil_clear", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 2, num_targets_per_draw: 5, target_size: 0.4, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
    OcclusionQueryCase { name: "conservative_all_occluders", num_occluder_draws: 7, num_occluders_per_draw: 10, occluder_size: 1.6, num_target_draws: 3, num_targets_per_draw: 5, target_size: 0.6, query_mode: glw::GL_ANY_SAMPLES_PASSED_CONSERVATIVE, occluder_types: OCCLUDER_SCISSOR | OCCLUDER_DEPTH_WRITE | OCCLUDER_DEPTH_CLEAR | OCCLUDER_STENCIL_WRITE | OCCLUDER_STENCIL_CLEAR },
];

/// `OcclusionQueryTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("occlusion_query");
    for case in CASES {
        group.add_child(Box::new(*case) as Box<dyn TestCase>);
    }
    group
}
