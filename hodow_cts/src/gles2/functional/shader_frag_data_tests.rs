// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderFragDataTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The four negative cases are not written in C++ at all: upstream loads them from
// `data/gles2/shaders/fragdata.test` through `gls::ShaderLibrary`, which
// `scripts/gen_shader_library.py` turned into `src/generated/shader_library/`.
//
// `es3fShaderFragDataTests.cpp` is this file plus one extra case, byte for byte, so
// `IndexExprType`, `compare_single_color` and `FragDataIndexingCase` are `pub(crate)`
// and the gles3 module reuses them rather than carrying a second copy that can drift.

use crate::generated::shader_library as lib;
use crate::gls::shader_library::add_group_children;
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw;
use crate::tcu::rgba::{RGBA, compare_threshold};
use crate::tcu::{Surface, TestError, TestOutcome, TestResult, TestStatus};

/// `IndexExprType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum IndexExprType {
    Static,
    Uniform,
    Dynamic,
}

/// `compareSingleColor`
pub fn compare_single_color(surface: &Surface, expected_color: RGBA, threshold: RGBA) -> bool {
    const MAX_PRINTS: i32 = 10;
    let mut num_failed_pixels = 0;

    log::info!("Expecting {expected_color} with threshold {threshold}");

    for y in 0..surface.get_height() {
        for x in 0..surface.get_width() {
            let result_color = surface.get_pixel(x, y);
            let is_ok = compare_threshold(result_color, expected_color, threshold);

            if !is_ok {
                if num_failed_pixels < MAX_PRINTS {
                    log::warn!("ERROR: Got {result_color} at ({x}, {y})!");
                } else if num_failed_pixels == MAX_PRINTS {
                    log::warn!("...");
                }

                num_failed_pixels += 1;
            }
        }
    }

    if num_failed_pixels > 0 {
        log::warn!("Found {num_failed_pixels} invalid pixels, comparison FAILED!");
        false
    } else {
        log::info!("Image comparison passed.");
        true
    }
}

pub struct FragDataIndexingCase {
    pub name: &'static str,
    pub index_expr_type: IndexExprType,
}

impl FragDataIndexingCase {
    /// `FragDataIndexingCase::genSources`
    fn gen_sources(index_expr_type: IndexExprType) -> ProgramSources {
        let frag_index_expr = match index_expr_type {
            IndexExprType::Static => "0",
            IndexExprType::Uniform => "u_index",
            IndexExprType::Dynamic => "int(v_index)",
        };

        ProgramSources::vtx_frag(
            concat!(
                "attribute highp vec4 a_position;\n",
                "attribute highp float a_index;\n",
                "attribute highp vec4 a_color;\n",
                "varying mediump float v_index;\n",
                "varying mediump vec4 v_color;\n",
                "void main (void)\n",
                "{\n",
                "    gl_Position = a_position;\n",
                "    v_color = a_color;\n",
                "    v_index = a_index;\n",
                "}\n",
            ),
            format!(
                concat!(
                    "varying mediump vec4 v_color;\n",
                    "varying mediump float v_index;\n",
                    "uniform mediump int u_index;\n",
                    "void main (void)\n",
                    "{{\n",
                    "    gl_FragData[{}] = v_color;\n",
                    "}}\n",
                ),
                frag_index_expr
            ),
        )
    }
}

impl TestCase for FragDataIndexingCase {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let program = ShaderProgram::new(gl, &Self::gen_sources(self.index_expr_type));
        let viewport_w = render_ctx.render_target().width.min(128);
        let viewport_h = render_ctx.render_target().height.min(128);

        const POSITIONS: [f32; 8] = [-1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, 1.0];
        const COLORS: [f32; 16] = [
            0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0,
        ];
        const INDEX_VALUES: [f32; 4] = [0.0, 0.0, 0.0, 0.0];
        const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

        let vertex_arrays = [
            va::float("a_position", 2, 4, 0, &POSITIONS),
            va::float("a_color", 4, 4, 0, &COLORS),
            va::float("a_index", 1, 4, 0, &INDEX_VALUES),
        ];

        if !program.is_ok() {
            if self.index_expr_type == IndexExprType::Static {
                return Err(TestError::Fail("Compile failed".to_string()));
            }
            return Err(TestError::NotSupported(
                "Dynamic indexing of gl_FragData[] not supported".to_string(),
            ));
        }

        // SAFETY: a current context; the uniform is the one the fragment shader
        // declares, and nothing here takes a client pointer.
        unsafe {
            gl.clear_color(1.0, 0.0, 0.0, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);

            gl.viewport(0, 0, viewport_w, viewport_h);
            gl.use_program(program.program());
            gl.uniform_1i(gl.get_uniform_location(program.program(), c"u_index".as_ptr()), 0);
        }

        glu::draw(render_ctx, program.program(), &vertex_arrays, &pr::triangles(&INDICES))?;
        glu::expect_no_error(gl, "Rendering failed")?;

        {
            let mut result = Surface::new(viewport_w, viewport_h);
            let threshold = render_ctx.render_target().pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);

            glu::read_pixels(render_ctx, 0, 0, &mut result.get_access())?;
            glu::expect_no_error(gl, "Reading pixels failed")?;

            let is_ok = compare_single_color(&result, RGBA::green(), threshold);

            Ok(if is_ok {
                TestStatus::pass("Pass")
            } else {
                TestStatus::new(TestResult::Fail, "Image comparison failed")
            })
        }
    }
}

/// `ShaderFragDataTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fragdata");
    group.add_child(Box::new(FragDataIndexingCase {
        name: "valid_static_index",
        index_expr_type: IndexExprType::Static,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FragDataIndexingCase {
        name: "valid_uniform_index",
        index_expr_type: IndexExprType::Uniform,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(FragDataIndexingCase {
        name: "valid_dynamic_index",
        index_expr_type: IndexExprType::Dynamic,
    }) as Box<dyn TestCase>);

    // Negative cases.
    add_group_children(&mut group, &lib::gles2_fragdata::ROOT);

    group
}
