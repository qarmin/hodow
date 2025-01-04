// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderInvariance.cpp / .hpp   (TessellationShaderInvarianceRule1Test ... Rule5Test)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling. See `invariance.rs` for how the C++ class hierarchy maps onto `InvarianceRule`.

#![allow(clippy::float_cmp)]

use super::invariance::{InvarianceRule, IterationProperties, Vertex, bytes_as_floats};
use super::utils::{
    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE, PrimitiveMode, Utils, VertexOrdering, VertexSpacing,
    get_es_token_for_primitive_mode, get_es_token_for_vertex_spacing_mode, get_generic_te_code,
    get_tessellation_level_set_for_primitive_mode, is_outer_edge_vertex,
};
use crate::glu::{self, Context};
use crate::glw::GLint;
use crate::khr_gl::esext::TestCaseBase;
use crate::tcu::TestError;

/// `glGetIntegerv(GL_MAX_TESS_GEN_LEVEL_EXT)` as the `initTestIterations` functions do it.
pub(super) fn max_tess_gen_level(context: &Context, base: &TestCaseBase) -> Result<GLint, TestError> {
    let gl = context.gl();
    let mut gl_max_tess_gen_level_value: GLint = 0;

    gl!(gl.get_integerv(base.gl_ext_tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
    glu::expect_no_error(gl, "glGetIntegerv() failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

    Ok(gl_max_tess_gen_level_value)
}

/// What `*out_result_buffer_size` receives when a caller asks for it: bytes of XFB storage for `n_vertices` of three floats each. Stores the vertex count through `n_vertices_out`.
pub(super) fn query_result_buffer_size(
    utils: &Utils<'_>,
    properties: &IterationProperties,
    vertex_spacing: VertexSpacing,
    draw_call_count_argument: u32,
    n_vertices_out: &mut u32,
) -> Result<u32, TestError> {
    let n_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
        properties.primitive_mode,
        &properties.inner_tess_levels,
        &properties.outer_tess_levels,
        vertex_spacing,
        properties.point_mode,
    )?;

    *n_vertices_out = n_vertices;

    Ok(n_vertices * draw_call_count_argument * 3 * std::mem::size_of::<f32>() as u32)
}

fn read_vertex(data: &[f32], n_vertex: usize) -> &[f32] {
    &data[n_vertex * 3..n_vertex * 3 + 3]
}

// ---------------------------------------------------------------------------------------------------------------------
// Rule 1
// ---------------------------------------------------------------------------------------------------------------------

/// `TessellationShaderInvarianceRule1Test`
pub(super) struct Rule1;

impl InvarianceRule for Rule1 {
    fn amount_of_iterations(&mut self, _context: &Context, _base: &TestCaseBase) -> Result<u32, TestError> {
        Ok(6)
    }

    fn draw_call_count_argument(&self) -> u32 {
        3
    }

    fn iteration_properties(
        &mut self,
        utils: &Utils<'_>,
        n_iteration: u32,
        query: bool,
    ) -> Result<IterationProperties, TestError> {
        let mut properties = IterationProperties::new(PrimitiveMode::Triangles);
        properties.vertex_ordering = VertexOrdering::Ccw;

        match n_iteration {
            0 | 5 => {
                // Triangles (point mode)
                properties.inner_tess_levels[0] = 1.0;
                properties.outer_tess_levels[0] = 1.0;
                properties.outer_tess_levels[1] = 1.0;
                properties.outer_tess_levels[2] = 1.0;
                properties.point_mode = true;
                properties.primitive_mode = PrimitiveMode::Triangles;
            }
            1 | 3 => {
                // Lines
                properties.outer_tess_levels[0] = 1.0;
                properties.outer_tess_levels[1] = 1.0;
                properties.point_mode = false;
                properties.primitive_mode = PrimitiveMode::Isolines;
            }
            2 | 4 => {
                // Triangles
                properties.inner_tess_levels[0] = 1.0;
                properties.outer_tess_levels[0] = 1.0;
                properties.outer_tess_levels[1] = 1.0;
                properties.outer_tess_levels[2] = 1.0;
                properties.point_mode = false;
                properties.primitive_mode = PrimitiveMode::Triangles;
            }
            _ => return Err(TestError::Fail("Unrecognzied iteration index".to_string())),
        }

        if query {
            let mut n_vertices = 0;
            properties.result_buffer_size = query_result_buffer_size(
                utils,
                &properties,
                VertexSpacing::Equal,
                self.draw_call_count_argument(),
                &mut n_vertices,
            )?;
        }

        Ok(properties)
    }

    fn te_code(&mut self, utils: &Utils<'_>, n_iteration: u32) -> Result<String, TestError> {
        let properties = self.iteration_properties(utils, n_iteration, true)?;

        Ok(get_generic_te_code(
            VertexSpacing::Equal,
            properties.primitive_mode,
            properties.vertex_ordering,
            properties.point_mode,
        ))
    }

    fn verify_result_data(&mut self, all_iterations_data: &[Vec<u8>]) -> Result<(), TestError> {
        let lines_vertex_data_1 = &all_iterations_data[1];
        let lines_vertex_data_2 = &all_iterations_data[3];
        let point_vertex_data_1 = &all_iterations_data[0];
        let point_vertex_data_2 = &all_iterations_data[5];
        let tris_vertex_data_1 = &all_iterations_data[2];
        let tris_vertex_data_2 = &all_iterations_data[4];

        let draw_call_count_argument = self.draw_call_count_argument() as usize;
        let n_line_vertices = 2 * draw_call_count_argument;
        let n_point_vertices = draw_call_count_argument;
        let n_tri_vertices = 3 * draw_call_count_argument;
        let vertex_size = std::mem::size_of::<f32>() * 3;

        // Make sure the data sets match, given different draw call ordering
        for n_type in 0..3 {
            let (data1, data2, data_type_string, n_vertices) = match n_type {
                0 => (lines_vertex_data_1, lines_vertex_data_2, "Line", n_line_vertices),
                1 => (point_vertex_data_1, point_vertex_data_2, "Point", n_point_vertices),
                _ => (tris_vertex_data_1, tris_vertex_data_2, "Triangle", n_tri_vertices),
            };

            let size = vertex_size * n_vertices;
            let data1 = &data1[..size];
            let data2 = &data2[..size];

            // Make sure the buffer storage in both cases has been modified
            if data1.iter().all(|&byte| byte == 0) || data2.iter().all(|&byte| byte == 0) {
                return Err(TestError::Fail(
                    "One of the draw calls has not outputted any data to XFB buffer object storage".to_string(),
                ));
            }

            if data1 != data2 {
                let floats1 = bytes_as_floats(data1);
                let floats2 = bytes_as_floats(data2);
                let list = |floats: &[f32]| {
                    floats
                        .iter()
                        .take(n_vertices)
                        .map(|value| value.to_string())
                        .collect::<Vec<_>>()
                        .join(", ")
                };

                log::info!(
                    "{data_type_string} data rendered in pass 1: ({}) and in pass 2: ({}) do not match",
                    list(&floats1),
                    list(&floats2)
                );

                return Err(TestError::Fail("Data mismatch".to_string()));
            }
        }

        Ok(())
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// Rule 2
// ---------------------------------------------------------------------------------------------------------------------

/// `TessellationShaderInvarianceRule2Test`
#[derive(Default)]
pub(super) struct Rule2 {
    n_tessellated_vertices: [u32; 4],
}

impl Rule2 {
    /// `getIterationProperties` without the vertex count query
    fn properties(n_iteration: u32) -> Result<IterationProperties, TestError> {
        let mut properties = IterationProperties::new(PrimitiveMode::Triangles);
        properties.vertex_ordering = VertexOrdering::Ccw;

        match n_iteration {
            0 | 1 => {
                // Triangles
                properties.outer_tess_levels[0] = 2.0;
                properties.outer_tess_levels[1] = 3.0;
                properties.outer_tess_levels[2] = 4.0;

                if n_iteration == 0 {
                    properties.inner_tess_levels = [4.0, 5.0];
                } else {
                    properties.inner_tess_levels = [3.0, 4.0];
                }

                properties.point_mode = false;
                properties.primitive_mode = PrimitiveMode::Triangles;
            }
            2 | 3 => {
                // Quads
                properties.outer_tess_levels = [2.0, 3.0, 4.0, 5.0];

                if n_iteration == 2 {
                    properties.inner_tess_levels = [2.0, 3.0];
                } else {
                    properties.inner_tess_levels = [4.0, 5.0];
                }

                properties.point_mode = false;
                properties.primitive_mode = PrimitiveMode::Quads;
            }
            _ => return Err(TestError::Fail("Unrecognized iteration index".to_string())),
        }

        Ok(properties)
    }
}

impl InvarianceRule for Rule2 {
    fn amount_of_iterations(&mut self, _context: &Context, _base: &TestCaseBase) -> Result<u32, TestError> {
        Ok(4)
    }

    fn iteration_properties(
        &mut self,
        utils: &Utils<'_>,
        n_iteration: u32,
        query: bool,
    ) -> Result<IterationProperties, TestError> {
        let mut properties = Self::properties(n_iteration)?;

        if query {
            let mut n_vertices = 0;
            properties.result_buffer_size = query_result_buffer_size(
                utils,
                &properties,
                VertexSpacing::Equal,
                self.draw_call_count_argument(),
                &mut n_vertices,
            )?;
            self.n_tessellated_vertices[n_iteration as usize] = n_vertices;
        }

        Ok(properties)
    }

    fn te_code(&mut self, utils: &Utils<'_>, n_iteration: u32) -> Result<String, TestError> {
        let properties = self.iteration_properties(utils, n_iteration, true)?;

        Ok(get_generic_te_code(
            VertexSpacing::Equal,
            properties.primitive_mode,
            properties.vertex_ordering,
            properties.point_mode,
        ))
    }

    fn verify_result_data(&mut self, all_iterations_data: &[Vec<u8>]) -> Result<(), TestError> {
        // Iterate through one tessellated set of vertices for a given primitive type
        for n_primitive_type in 0..2usize {
            let data1 = bytes_as_floats(&all_iterations_data[n_primitive_type * 2]);
            let data2 = bytes_as_floats(&all_iterations_data[n_primitive_type * 2 + 1]);
            let primitive_mode = if n_primitive_type == 0 {
                PrimitiveMode::Triangles
            } else {
                PrimitiveMode::Quads
            };

            let mut outer_vertices: Vec<Vertex> = Vec::new();

            // Iterate through all data1 vertices..
            for n_vertex in 0..self.n_tessellated_vertices[n_primitive_type * 2] as usize {
                // Vertices located on the outer edge are the reference ones.
                let vertex_ptr = read_vertex(&data1, n_vertex);

                if is_outer_edge_vertex(primitive_mode, vertex_ptr) {
                    // Only add the vertex if it has not been added already to the vector
                    let has_already_been_added = outer_vertices.iter().any(|vertex| {
                        vertex.u == vertex_ptr[0] && vertex.v == vertex_ptr[1] && vertex.w == vertex_ptr[2]
                    });

                    if !has_already_been_added {
                        outer_vertices.push(Vertex {
                            u: vertex_ptr[0],
                            v: vertex_ptr[1],
                            w: vertex_ptr[2],
                        });
                    }
                }
            }

            // Make sure the outer vertices are present in the other data set
            for ref_vertex in &outer_vertices {
                let mut has_been_found = false;

                for n_vertex in 0..self.n_tessellated_vertices[n_primitive_type * 2 + 1] as usize {
                    let vertex_ptr = read_vertex(&data2, n_vertex);

                    if vertex_ptr[0] == ref_vertex.u && vertex_ptr[1] == ref_vertex.v && vertex_ptr[2] == ref_vertex.w {
                        has_been_found = true;
                        break;
                    }
                }

                if !has_been_found {
                    let primitive_type = if n_primitive_type == 0 { "triangles" } else { "quads" };
                    let reference = Self::properties((n_primitive_type * 2) as u32)?;
                    let compared = Self::properties((n_primitive_type * 2 + 1) as u32)?;

                    log::info!(
                        "Outer vertex ({}, {}, {}) was not found in tessellated data coordinate set generated for primitive type: {primitive_type}. Reference inner tessellation level: ({}, {}), reference outer tessellation level: ({}, {}, {}, {}), test inner tessellation level: ({}, {}), reference outer tessellation level: ({}, {}, {}, {}).",
                        ref_vertex.u,
                        ref_vertex.v,
                        ref_vertex.w,
                        reference.inner_tess_levels[0],
                        reference.inner_tess_levels[1],
                        reference.outer_tess_levels[0],
                        reference.outer_tess_levels[1],
                        reference.outer_tess_levels[2],
                        reference.outer_tess_levels[3],
                        compared.inner_tess_levels[0],
                        compared.inner_tess_levels[1],
                        compared.outer_tess_levels[0],
                        compared.outer_tess_levels[1],
                        compared.outer_tess_levels[2],
                        compared.outer_tess_levels[3]
                    );

                    return Err(TestError::Fail("Outer edge vertex was not found in tessellated coordinate set generated for the same outer tessellation levels and vertex spacing, but different inner tessellation levels".to_string()));
                }
            }
        }

        Ok(())
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// Rules 3 and 4
// ---------------------------------------------------------------------------------------------------------------------

/// `_test_iteration` of rules 3 and 4
#[derive(Clone)]
struct SpacingIteration {
    inner_tess_levels: [f32; 2],
    outer_tess_levels: [f32; 4],
    primitive_mode: PrimitiveMode,
    vertex_spacing: VertexSpacing,
    n_vertices: u32,
}

/// The `getIterationProperties` of rules 3 and 4.
fn spacing_iteration_properties(
    iterations: &mut [SpacingIteration],
    utils: &Utils<'_>,
    n_iteration: u32,
    query: bool,
    draw_call_count_argument: u32,
) -> Result<IterationProperties, TestError> {
    let test_iteration = &mut iterations[n_iteration as usize];

    let mut properties = IterationProperties::new(test_iteration.primitive_mode);
    properties.inner_tess_levels = test_iteration.inner_tess_levels;
    properties.outer_tess_levels = test_iteration.outer_tess_levels;
    properties.point_mode = false;
    properties.vertex_ordering = VertexOrdering::Ccw;

    if query {
        let mut n_vertices = 0;
        properties.result_buffer_size = query_result_buffer_size(
            utils,
            &properties,
            test_iteration.vertex_spacing,
            draw_call_count_argument,
            &mut n_vertices,
        )?;
        test_iteration.n_vertices = n_vertices;
    }

    Ok(properties)
}

/// `TessellationShaderInvarianceRule3Test`
#[derive(Default)]
pub(super) struct Rule3 {
    iterations: Vec<SpacingIteration>,
}

impl Rule3 {
    /// `initTestIterations`
    fn init_test_iterations(&mut self, context: &Context, base: &TestCaseBase) -> Result<(), TestError> {
        let gl_max_tess_gen_level_value = max_tess_gen_level(context, base)?;

        // Iterate through all primitive and vertex spacing modes
        for primitive_mode in [PrimitiveMode::Isolines, PrimitiveMode::Quads, PrimitiveMode::Triangles] {
            for vertex_spacing in [
                VertexSpacing::Equal,
                VertexSpacing::FractionalEven,
                VertexSpacing::FractionalOdd,
            ] {
                // Retrieve inner/outer tessellation level combinations the test is run for
                let levels_set = get_tessellation_level_set_for_primitive_mode(
                    primitive_mode,
                    gl_max_tess_gen_level_value,
                    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE,
                );

                for levels in &levels_set {
                    self.iterations.push(SpacingIteration {
                        inner_tess_levels: levels.inner,
                        outer_tess_levels: levels.outer,
                        primitive_mode,
                        vertex_spacing,
                        n_vertices: 0,
                    });
                }
            }
        }

        Ok(())
    }
}

impl InvarianceRule for Rule3 {
    fn amount_of_iterations(&mut self, context: &Context, base: &TestCaseBase) -> Result<u32, TestError> {
        if self.iterations.is_empty() {
            self.init_test_iterations(context, base)?;
        }

        Ok(self.iterations.len() as u32)
    }

    fn iteration_properties(
        &mut self,
        utils: &Utils<'_>,
        n_iteration: u32,
        query: bool,
    ) -> Result<IterationProperties, TestError> {
        let draw_call_count_argument = self.draw_call_count_argument();

        spacing_iteration_properties(
            &mut self.iterations,
            utils,
            n_iteration,
            query,
            draw_call_count_argument,
        )
    }

    fn te_code(&mut self, _utils: &Utils<'_>, n_iteration: u32) -> Result<String, TestError> {
        let test_iteration = &self.iterations[n_iteration as usize];

        Ok(get_generic_te_code(
            test_iteration.vertex_spacing,
            test_iteration.primitive_mode,
            VertexOrdering::Ccw,
            false,
        ))
    }

    fn verify_result_data_for_iteration(&mut self, n_iteration: u32, data: &[u8]) -> Result<(), TestError> {
        let data_float = bytes_as_floats(data);
        let test_iteration = &self.iterations[n_iteration as usize];

        // Iterate through all generated vertices..
        for n_vertex in 0..test_iteration.n_vertices as usize {
            let mut expected_vertex = Vertex {
                u: -1.0,
                v: -1.0,
                w: -1.0,
            };
            let vertex_data = read_vertex(&data_float, n_vertex);

            // Make sure that for each vertex, the symmetrical vertex required by the extension specification was generated as well.
            match test_iteration.primitive_mode {
                PrimitiveMode::Isolines => {
                    // For isoline tessellation, if it generates vertices at (0,x) and (1,x) ..., it will also generate vertices at (0,1-x) and (1,1-x).
                    if vertex_data[0] == 0.0 && vertex_data[1] != 0.0 {
                        expected_vertex = Vertex {
                            u: vertex_data[0],
                            v: 1.0 - vertex_data[1],
                            w: -1.0,
                        };
                    } else if vertex_data[0] == 1.0 && vertex_data[1] != 0.0 {
                        expected_vertex = Vertex {
                            u: vertex_data[0],
                            v: 1.0 - vertex_data[1],
                            w: -1.0,
                        };
                    }
                }
                PrimitiveMode::Quads => {
                    // For quad tessellation, if the subdivision generates a vertex with coordinates of (x,0) or (0,x), it will also generate a vertex with coordinates of (1-x,0) or (0,1-x), respectively.
                    if vertex_data[0] != 0.0 && vertex_data[1] == 0.0 {
                        expected_vertex = Vertex {
                            u: 1.0 - vertex_data[0],
                            v: vertex_data[1],
                            w: -1.0,
                        };
                    } else if vertex_data[0] == 0.0 && vertex_data[1] != 0.0 {
                        expected_vertex = Vertex {
                            u: vertex_data[0],
                            v: 1.0 - vertex_data[1],
                            w: -1.0,
                        };
                    }
                }
                PrimitiveMode::Triangles => {
                    // For triangle tessellation, if the subdivision generates a vertex with coordinates of (0,x,1-x), (x,0,1-x) or (x,1-x,0), it will also generate a vertex with coordinates of exactly (0,1-x,x), (1-x,0,x), or (1-x,x,0), respectively.
                    if vertex_data[0] == 0.0 && vertex_data[1] != 0.0 && vertex_data[2] == (1.0 - vertex_data[1]) {
                        expected_vertex = Vertex {
                            u: vertex_data[0],
                            v: vertex_data[2],
                            w: vertex_data[1],
                        };
                    } else if vertex_data[0] != 0.0 && vertex_data[1] == 0.0 && vertex_data[2] == (1.0 - vertex_data[0])
                    {
                        expected_vertex = Vertex {
                            u: vertex_data[2],
                            v: vertex_data[1],
                            w: vertex_data[0],
                        };
                    } else if vertex_data[0] != 0.0 && vertex_data[1] == (1.0 - vertex_data[0]) && vertex_data[2] == 0.0
                    {
                        expected_vertex = Vertex {
                            u: vertex_data[1],
                            v: vertex_data[0],
                            w: vertex_data[2],
                        };
                    }
                }
            }

            // If any of the "expected vertex"'s components is no longer negative, make sure the vertex can be found in the result data
            if expected_vertex.u >= 0.0 || expected_vertex.v >= 0.0 || expected_vertex.w >= 0.0 {
                let mut has_been_found = false;

                for n_find_vertex in 0..test_iteration.n_vertices as usize {
                    let current_vertex_data = read_vertex(&data_float, n_find_vertex);
                    let epsilon = 1e-4f32;
                    let abs_delta = [
                        (current_vertex_data[0] - expected_vertex.u).abs(),
                        (current_vertex_data[1] - expected_vertex.v).abs(),
                        (current_vertex_data[2] - expected_vertex.w).abs(),
                    ];

                    if abs_delta[0] < epsilon
                        && abs_delta[1] < epsilon
                        && (expected_vertex.w < 0.0 || abs_delta[2] < epsilon)
                    {
                        has_been_found = true;
                        break;
                    }
                }

                if !has_been_found {
                    return Err(TestError::Fail(
                        "Expected symmetrical vertex data was not generated by the tessellator.".to_string(),
                    ));
                }
            }
        }

        Ok(())
    }
}

/// `TessellationShaderInvarianceRule4Test`
#[derive(Default)]
pub(super) struct Rule4 {
    iterations: Vec<SpacingIteration>,
}

impl Rule4 {
    /// `initTestIterations`
    fn init_test_iterations(&mut self, context: &Context, base: &TestCaseBase) -> Result<(), TestError> {
        let gl_max_tess_gen_level_value = max_tess_gen_level(context, base)?;

        // Iterate through all primitive and vertex spacing modes relevant to the test
        for primitive_mode in [PrimitiveMode::Quads, PrimitiveMode::Triangles] {
            for vertex_spacing in [
                VertexSpacing::Equal,
                VertexSpacing::FractionalEven,
                VertexSpacing::FractionalOdd,
            ] {
                let levels = get_tessellation_level_set_for_primitive_mode(
                    primitive_mode,
                    gl_max_tess_gen_level_value,
                    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE,
                );

                for current_levels in &levels {
                    // The set uses different outer tessellation level values, so the levels are set to the same FP values for the test to succeed.
                    self.iterations.push(SpacingIteration {
                        inner_tess_levels: current_levels.inner,
                        outer_tess_levels: [current_levels.outer[0]; 4],
                        primitive_mode,
                        vertex_spacing,
                        n_vertices: 0,
                    });
                }
            }
        }

        Ok(())
    }

    /// `isVertexDefined`
    fn is_vertex_defined(
        vertex_data: &[f32],
        n_vertices: u32,
        vertex_data_seeked: &[f32],
        n_vertex_data_seeked_components: u32,
    ) -> bool {
        for n_vertex in 0..n_vertices as usize {
            let current_vertex_data = read_vertex(vertex_data, n_vertex);

            if vertex_data_seeked[0] == current_vertex_data[0]
                && vertex_data_seeked[1] == current_vertex_data[1]
                && (n_vertex_data_seeked_components < 3 || vertex_data_seeked[2] == current_vertex_data[2])
            {
                return true;
            }
        }

        false
    }
}

impl InvarianceRule for Rule4 {
    fn amount_of_iterations(&mut self, context: &Context, base: &TestCaseBase) -> Result<u32, TestError> {
        if self.iterations.is_empty() {
            self.init_test_iterations(context, base)?;
        }

        Ok(self.iterations.len() as u32)
    }

    fn iteration_properties(
        &mut self,
        utils: &Utils<'_>,
        n_iteration: u32,
        query: bool,
    ) -> Result<IterationProperties, TestError> {
        let draw_call_count_argument = self.draw_call_count_argument();

        spacing_iteration_properties(
            &mut self.iterations,
            utils,
            n_iteration,
            query,
            draw_call_count_argument,
        )
    }

    fn te_code(&mut self, _utils: &Utils<'_>, n_iteration: u32) -> Result<String, TestError> {
        let test_iteration = &self.iterations[n_iteration as usize];

        Ok(get_generic_te_code(
            test_iteration.vertex_spacing,
            test_iteration.primitive_mode,
            VertexOrdering::Ccw,
            false,
        ))
    }

    fn verify_result_data_for_iteration(&mut self, n_iteration: u32, data: &[u8]) -> Result<(), TestError> {
        let data_float = bytes_as_floats(data);
        let test_iteration = &self.iterations[n_iteration as usize];

        // Iterate through all generated vertices..
        for n_vertex in 0..test_iteration.n_vertices as usize {
            let mut expected_vertices: Vec<Vertex> = Vec::new();
            let vertex_data = read_vertex(&data_float, n_vertex);

            match test_iteration.primitive_mode {
                PrimitiveMode::Quads => {
                    // For quad tessellation, if vertices at (x,0) and (1-x,0) are generated when subdividing the v==0 edge, vertices must be generated at (0,x) and (0,1-x) when subdividing an otherwise identical u==0 edge.
                    if vertex_data[0] != 0.0 && vertex_data[1] == 0.0 {
                        let paired_vertex_data = [1.0 - vertex_data[0], vertex_data[1]];

                        if Self::is_vertex_defined(&data_float, test_iteration.n_vertices, &paired_vertex_data, 2) {
                            expected_vertices.push(Vertex {
                                u: vertex_data[1],
                                v: vertex_data[0],
                                w: -1.0,
                            });
                            expected_vertices.push(Vertex {
                                u: vertex_data[1],
                                v: 1.0 - vertex_data[0],
                                w: -1.0,
                            });
                        }
                    }
                }
                PrimitiveMode::Triangles => {
                    // For triangular tessellation, if vertices at (x,1-x,0) and (1-x,x,0) are generated when subdividing the w==0 edge, vertices must be generated at (x,0,1-x) and (1-x,0,x) when subdividing an otherwise identical v==0 edge.
                    if vertex_data[0] != 0.0 && vertex_data[1] == (1.0 - vertex_data[0]) && vertex_data[2] == 0.0 {
                        let paired_vertex_data = [vertex_data[1], vertex_data[0], vertex_data[2]];

                        if Self::is_vertex_defined(&data_float, test_iteration.n_vertices, &paired_vertex_data, 3) {
                            expected_vertices.push(Vertex {
                                u: vertex_data[0],
                                v: vertex_data[2],
                                w: vertex_data[1],
                            });
                            expected_vertices.push(Vertex {
                                u: vertex_data[1],
                                v: vertex_data[2],
                                w: vertex_data[0],
                            });
                        }
                    }
                }
                PrimitiveMode::Isolines => return Err(TestError::Fail("Primitive mode unrecognized".to_string())),
            }

            // Iterate through all expected vertices
            for expected_vertex in &expected_vertices {
                let expected_vertex_raw = [expected_vertex.u, expected_vertex.v, expected_vertex.w];

                let has_been_found = Self::is_vertex_defined(
                    &data_float,
                    test_iteration.n_vertices,
                    &expected_vertex_raw,
                    if expected_vertex.w < 0.0 { 2 } else { 3 },
                );

                if !has_been_found {
                    let mut expected_vertex_string = format!("{}, {}", expected_vertex.u, expected_vertex.v);
                    if expected_vertex.w >= 0.0 {
                        expected_vertex_string.push_str(&format!(", {}", expected_vertex.w));
                    }

                    log::info!(
                        "For primitive mode:[{}]and vertex spacing mode:[{}] and inner tessellation levels:[{}, {})  and outer tessellation levels:[{}, {}, {}, {})  the following vertex was expected:[{expected_vertex_string}] but was not found in the tessellated cooordinate data set",
                        get_es_token_for_primitive_mode(test_iteration.primitive_mode),
                        get_es_token_for_vertex_spacing_mode(test_iteration.vertex_spacing),
                        test_iteration.inner_tess_levels[0],
                        test_iteration.inner_tess_levels[1],
                        test_iteration.outer_tess_levels[0],
                        test_iteration.outer_tess_levels[1],
                        test_iteration.outer_tess_levels[2],
                        test_iteration.outer_tess_levels[3]
                    );

                    return Err(TestError::Fail(
                        "Expected symmetrical vertex data was not generated by the tessellator.".to_string(),
                    ));
                }
            }
        }

        Ok(())
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// Rules 5, 6 and 7 share the iteration list layout
// ---------------------------------------------------------------------------------------------------------------------

/// `_test_iteration` of rules 5 and 6
#[derive(Clone)]
pub(super) struct OrderedIteration {
    pub inner_tess_levels: [f32; 2],
    pub outer_tess_levels: [f32; 4],
    pub primitive_mode: PrimitiveMode,
    pub vertex_ordering: VertexOrdering,
    pub n_vertices: u32,
}

/// `getTestForIteration` of rules 5 and 6 (triangle iterations first, then the quad ones).
pub(super) fn ordered_test_for_iteration<'a>(
    triangles: &'a mut [OrderedIteration],
    quads: &'a mut [OrderedIteration],
    n_iteration: u32,
) -> &'a mut OrderedIteration {
    let n_triangles_tests = triangles.len() as u32;

    if n_iteration < n_triangles_tests {
        &mut triangles[n_iteration as usize]
    } else {
        &mut quads[(n_iteration - n_triangles_tests) as usize]
    }
}

/// The `getIterationProperties` of rules 5 and 6.
pub(super) fn ordered_iteration_properties(
    test_iteration: &mut OrderedIteration,
    utils: &Utils<'_>,
    query: bool,
    draw_call_count_argument: u32,
) -> Result<IterationProperties, TestError> {
    let mut properties = IterationProperties::new(test_iteration.primitive_mode);
    properties.inner_tess_levels = test_iteration.inner_tess_levels;
    properties.outer_tess_levels = test_iteration.outer_tess_levels;
    properties.point_mode = false;
    properties.vertex_ordering = test_iteration.vertex_ordering;

    if query {
        let mut n_vertices = 0;
        properties.result_buffer_size = query_result_buffer_size(
            utils,
            &properties,
            VertexSpacing::Equal,
            draw_call_count_argument,
            &mut n_vertices,
        )?;
        test_iteration.n_vertices = n_vertices;
    }

    Ok(properties)
}

/// `TessellationShaderInvarianceRule5Test`
#[derive(Default)]
pub(super) struct Rule5 {
    triangles_iterations: Vec<OrderedIteration>,
    quads_iterations: Vec<OrderedIteration>,
}

impl Rule5 {
    /// `initTestIterations`
    fn init_test_iterations(&mut self, context: &Context, base: &TestCaseBase) -> Result<(), TestError> {
        let gl_max_tess_gen_level_value = max_tess_gen_level(context, base)?;

        for primitive_mode in [PrimitiveMode::Quads, PrimitiveMode::Triangles] {
            for vertex_ordering in [VertexOrdering::Ccw, VertexOrdering::Cw] {
                let levels_set = get_tessellation_level_set_for_primitive_mode(
                    primitive_mode,
                    gl_max_tess_gen_level_value,
                    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE,
                );

                // Only use the last inner/outer level configuration, as reported by the utils function.
                let levels = levels_set
                    .last()
                    .ok_or_else(|| TestError::Fail("No tessellation level sets".to_string()))?;

                let test = OrderedIteration {
                    inner_tess_levels: levels.inner,
                    outer_tess_levels: levels.outer,
                    primitive_mode,
                    vertex_ordering,
                    n_vertices: 0,
                };

                if primitive_mode == PrimitiveMode::Triangles {
                    self.triangles_iterations.push(test);
                } else {
                    self.quads_iterations.push(test);
                }
            }
        }

        Ok(())
    }

    /// `isVertexDefined`
    fn is_vertex_defined(
        vertex_data: &[f32],
        n_vertices: u32,
        vertex_data_seeked: &[f32],
        n_vertex_data_seeked_components: u32,
    ) -> bool {
        let epsilon = 1e-5f32;

        for n_vertex in 0..n_vertices as usize {
            let current_vertex_data = read_vertex(vertex_data, n_vertex);

            if (vertex_data_seeked[0] - current_vertex_data[0]).abs() < epsilon
                && (vertex_data_seeked[1] - current_vertex_data[1]).abs() < epsilon
                && (n_vertex_data_seeked_components < 3
                    || (vertex_data_seeked[2] - current_vertex_data[2]).abs() < epsilon)
            {
                return true;
            }
        }

        false
    }
}

impl InvarianceRule for Rule5 {
    fn amount_of_iterations(&mut self, context: &Context, base: &TestCaseBase) -> Result<u32, TestError> {
        if self.quads_iterations.is_empty() || self.triangles_iterations.is_empty() {
            self.init_test_iterations(context, base)?;
        }

        Ok((self.quads_iterations.len() + self.triangles_iterations.len()) as u32)
    }

    fn iteration_properties(
        &mut self,
        utils: &Utils<'_>,
        n_iteration: u32,
        query: bool,
    ) -> Result<IterationProperties, TestError> {
        let draw_call_count_argument = self.draw_call_count_argument();
        let test_iteration =
            ordered_test_for_iteration(&mut self.triangles_iterations, &mut self.quads_iterations, n_iteration);

        ordered_iteration_properties(test_iteration, utils, query, draw_call_count_argument)
    }

    fn te_code(&mut self, _utils: &Utils<'_>, n_iteration: u32) -> Result<String, TestError> {
        let test_iteration =
            ordered_test_for_iteration(&mut self.triangles_iterations, &mut self.quads_iterations, n_iteration);

        Ok(get_generic_te_code(
            VertexSpacing::Equal,
            test_iteration.primitive_mode,
            test_iteration.vertex_ordering,
            false,
        ))
    }

    fn verify_result_data(&mut self, all_iterations_data: &[Vec<u8>]) -> Result<(), TestError> {
        // Run two separate iterations: triangles, then quads.
        for n_iteration in 0..2 {
            let n_base_iteration = if n_iteration == 0 {
                0
            } else {
                self.triangles_iterations.len()
            };
            let test_iterations = if n_iteration == 0 {
                &self.triangles_iterations
            } else {
                &self.quads_iterations
            };
            let set_size = test_iterations.len();

            if test_iterations.is_empty() {
                return Err(TestError::Fail("No test iterations".to_string()));
            }

            // For each iteration, verify that all vertices generated for both vertex orderings are exactly the same (but in different order)
            let base_vertex_data = bytes_as_floats(&all_iterations_data[n_base_iteration]);

            for n_set in 1..set_size {
                let set_vertex_data = bytes_as_floats(&all_iterations_data[n_base_iteration + n_set]);

                // Run through all vertices in base set and make sure they can be found in currently processed set
                for n_base_vertex in 0..test_iterations[0].n_vertices as usize {
                    let base_vertex = read_vertex(&base_vertex_data, n_base_vertex);

                    if !Self::is_vertex_defined(&set_vertex_data, test_iterations[n_set].n_vertices, base_vertex, 3) {
                        let primitive_mode = if n_iteration == 0 { "triangles" } else { "quads" };

                        log::info!(
                            "For primitive mode [{primitive_mode}] a vertex with tessellation coordinates:[{}, {}, {}) could not have been found for both vertex orderings.",
                            base_vertex[0],
                            base_vertex[1],
                            base_vertex[2]
                        );

                        return Err(TestError::Fail("Implementation does not follow Rule 5.".to_string()));
                    }
                }
            }
        }

        Ok(())
    }
}
