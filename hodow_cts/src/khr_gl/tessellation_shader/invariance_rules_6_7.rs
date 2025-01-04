// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderInvariance.cpp / .hpp   (TessellationShaderInvarianceRule6Test, Rule7Test)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Written without compiling. See `invariance.rs` for how the C++ class hierarchy maps onto `InvarianceRule`.

#![allow(clippy::float_cmp)]

use super::invariance::{InvarianceRule, IterationProperties, bytes_as_floats};
use super::invariance_rules_1_to_5::{
    OrderedIteration, max_tess_gen_level, ordered_iteration_properties, ordered_test_for_iteration,
    query_result_buffer_size,
};
use super::utils::{
    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE, PrimitiveMode, Utils, VertexOrdering, VertexSpacing,
    get_es_token_for_primitive_mode, get_generic_te_code, get_tessellation_level_set_for_primitive_mode,
    is_outer_edge_vertex, is_triangle_defined,
};
use crate::glu::Context;
use crate::khr_gl::esext::TestCaseBase;
use crate::tcu::TestError;

// ---------------------------------------------------------------------------------------------------------------------
// Rule 6
// ---------------------------------------------------------------------------------------------------------------------

/// `TessellationShaderInvarianceRule6Test`
#[derive(Default)]
pub(super) struct Rule6 {
    triangles_iterations: Vec<OrderedIteration>,
    quads_iterations: Vec<OrderedIteration>,
}

impl Rule6 {
    /// `initTestIterations`
    fn init_test_iterations(&mut self, context: &Context, base: &TestCaseBase) -> Result<(), TestError> {
        let gl_max_tess_gen_level_value = max_tess_gen_level(context, base)?;

        for primitive_mode in [PrimitiveMode::Triangles, PrimitiveMode::Quads] {
            for vertex_ordering in [VertexOrdering::Ccw, VertexOrdering::Cw] {
                // Each level set the utils function provides is unique and does not repeat; the inner level values are forced to the last set's, so that the conditions the test must meet are actually met.
                let mut levels_set = get_tessellation_level_set_for_primitive_mode(
                    primitive_mode,
                    gl_max_tess_gen_level_value,
                    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE,
                );
                let n_levels_sets = levels_set.len();
                let inner_levels_to_use = levels_set
                    .last()
                    .ok_or_else(|| TestError::Fail("No tessellation level sets".to_string()))?
                    .inner;

                for levels in levels_set.iter_mut().take(n_levels_sets - 1) {
                    levels.inner = inner_levels_to_use;
                }

                for levels in &levels_set {
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
        }

        Ok(())
    }
}

impl InvarianceRule for Rule6 {
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
            let n_sets = test_iterations.len();
            let primitive_mode = if n_iteration == 0 {
                PrimitiveMode::Triangles
            } else {
                PrimitiveMode::Quads
            };

            if test_iterations.is_empty() {
                return Err(TestError::Fail("No test iterations".to_string()));
            }

            let n_triangles_in_base_set = (test_iterations[0].n_vertices / 3) as usize;

            // For each iteration, verify that all interior triangles are the same (but in different order)
            let base_test = &test_iterations[0];
            let base_vertex_data = bytes_as_floats(&all_iterations_data[n_base_iteration]);

            for n_set in 1..n_sets {
                let set_test = &test_iterations[n_set];
                let set_vertex_data = bytes_as_floats(&all_iterations_data[n_base_iteration + n_set]);

                let n_triangles_in_curr_set = (test_iterations[n_set].n_vertices / 3) as usize;

                // Take base triangles and make sure they can be found in the iteration-specific set. No specific vertex and triangle order is assumed, hence the slow search.
                for n_base_triangle in 0..n_triangles_in_base_set {
                    let base_triangle = &base_vertex_data[n_base_triangle * 9..n_base_triangle * 9 + 9];
                    let base_triangle_vertex1 = &base_triangle[0..3];
                    let base_triangle_vertex2 = &base_triangle[3..6];
                    let base_triangle_vertex3 = &base_triangle[6..9];

                    // Only interior triangles should be left intact. Is this an interior triangle?
                    if !is_outer_edge_vertex(primitive_mode, base_triangle_vertex1)
                        && !is_outer_edge_vertex(primitive_mode, base_triangle_vertex2)
                        && !is_outer_edge_vertex(primitive_mode, base_triangle_vertex3)
                    {
                        let mut has_base_set_triangle_been_found = false;

                        for n_curr_set_triangle in 0..n_triangles_in_curr_set {
                            let curr_triangle = &set_vertex_data[n_curr_set_triangle * 9..n_curr_set_triangle * 9 + 9];

                            if is_triangle_defined(base_triangle, curr_triangle) {
                                has_base_set_triangle_been_found = true;
                                break;
                            }
                        }

                        if !has_base_set_triangle_been_found {
                            log::info!(
                                "For primitive mode [{}], base inner tessellation levels:[{}, {}], base outer tessellation levels:[{}, {}, {}, {}], reference inner tessellation levels:[{}, {}], reference outer tessellation levels:[{}, {}, {}, {}], the following triangle formed during base tessellation run was not found in reference run:[{}, {}, {}]x[{}, {}, {}]x[{}, {}, {}",
                                get_es_token_for_primitive_mode(base_test.primitive_mode),
                                base_test.inner_tess_levels[0],
                                base_test.inner_tess_levels[1],
                                base_test.outer_tess_levels[0],
                                base_test.outer_tess_levels[1],
                                base_test.outer_tess_levels[2],
                                base_test.outer_tess_levels[3],
                                set_test.inner_tess_levels[0],
                                set_test.inner_tess_levels[1],
                                set_test.outer_tess_levels[0],
                                set_test.outer_tess_levels[1],
                                set_test.outer_tess_levels[2],
                                set_test.outer_tess_levels[3],
                                base_triangle_vertex1[0],
                                base_triangle_vertex1[1],
                                base_triangle_vertex1[2],
                                base_triangle_vertex2[0],
                                base_triangle_vertex2[1],
                                base_triangle_vertex2[2],
                                base_triangle_vertex3[0],
                                base_triangle_vertex3[1],
                                base_triangle_vertex3[2]
                            );

                            return Err(TestError::Fail(
                                "Implementation does not appear to be rule 6-conformant".to_string(),
                            ));
                        }
                    }
                }
            }
        }

        Ok(())
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// Rule 7
// ---------------------------------------------------------------------------------------------------------------------

/// `_test_iteration` of rule 7
#[derive(Clone)]
struct Rule7Iteration {
    inner_tess_levels: [f32; 2],
    outer_tess_levels: [f32; 4],
    primitive_mode: PrimitiveMode,
    vertex_ordering: VertexOrdering,
    is_base_iteration: bool,
    n_modified_outer_tess_level: u32,
    n_vertices: u32,
}

/// `TessellationShaderInvarianceRule7Test`
#[derive(Default)]
pub(super) struct Rule7 {
    triangles_iterations: Vec<Rule7Iteration>,
    quads_iterations: Vec<Rule7Iteration>,
}

impl Rule7 {
    /// `initTestIterations`
    fn init_test_iterations(&mut self, context: &Context, base: &TestCaseBase) -> Result<(), TestError> {
        let gl_max_tess_gen_level_value = max_tess_gen_level(context, base)?;

        for primitive_mode in [PrimitiveMode::Quads, PrimitiveMode::Triangles] {
            let n_relevant_outer_tess_levels = if primitive_mode == PrimitiveMode::Quads { 4 } else { 3 };

            for vertex_ordering in [VertexOrdering::Ccw, VertexOrdering::Cw] {
                let levels_set = get_tessellation_level_set_for_primitive_mode(
                    primitive_mode,
                    gl_max_tess_gen_level_value,
                    LEVEL_SET_FILTER_ALL_LEVELS_USE_THE_SAME_VALUE,
                );

                // Create test descriptor for all inner/outer level configurations received from the utils function.
                for levels in &levels_set {
                    for n_outer_level_to_change in 0..n_relevant_outer_tess_levels + 1 {
                        let mut test = Rule7Iteration {
                            inner_tess_levels: levels.inner,
                            outer_tess_levels: levels.outer,
                            primitive_mode,
                            vertex_ordering,
                            is_base_iteration: false,
                            n_modified_outer_tess_level: 0,
                            n_vertices: 0,
                        };

                        // Change the iteration-specific outer tessellation level to a different value, but only if this is not a base iteration.
                        if n_outer_level_to_change != n_relevant_outer_tess_levels {
                            test.n_modified_outer_tess_level = n_outer_level_to_change;
                            test.outer_tess_levels[n_outer_level_to_change as usize] =
                                gl_max_tess_gen_level_value as f32 / 3.0;
                        } else {
                            test.is_base_iteration = true;
                        }

                        if primitive_mode == PrimitiveMode::Triangles {
                            self.triangles_iterations.push(test);
                        } else {
                            self.quads_iterations.push(test);
                        }
                    }
                }
            }
        }

        Ok(())
    }

    /// `getTestForIteration`
    fn test_for_iteration(&mut self, n_iteration: u32) -> &mut Rule7Iteration {
        let n_triangles_tests = self.triangles_iterations.len() as u32;

        if n_iteration < n_triangles_tests {
            &mut self.triangles_iterations[n_iteration as usize]
        } else {
            &mut self.quads_iterations[(n_iteration - n_triangles_tests) as usize]
        }
    }

    /// `getTestIterationIndex`
    fn test_iteration_index(
        &self,
        is_triangles_iteration: bool,
        inner_tess_levels: &[f32; 2],
        outer_tess_levels: &[f32; 4],
        vertex_ordering: VertexOrdering,
        n_modified_outer_tess_level: u32,
    ) -> Option<usize> {
        let epsilon = 1e-5f32;
        let test_iterations = if is_triangles_iteration {
            &self.triangles_iterations
        } else {
            &self.quads_iterations
        };

        for (n_test_iteration, test_iteration) in test_iterations.iter().enumerate() {
            if (test_iteration.inner_tess_levels[0] - inner_tess_levels[0]).abs() < epsilon
                && (test_iteration.inner_tess_levels[1] - inner_tess_levels[1]).abs() < epsilon
                && test_iteration.vertex_ordering == vertex_ordering
                && test_iteration.n_modified_outer_tess_level == n_modified_outer_tess_level
            {
                // Only compare outer tessellation levels that have not been modified
                let outer_matches = (0..4).all(|n_level| {
                    n_modified_outer_tess_level == n_level as u32
                        || (test_iteration.outer_tess_levels[n_level] - outer_tess_levels[n_level]).abs() < epsilon
                });

                if outer_matches {
                    return Some(n_test_iteration);
                }
            }
        }

        None
    }

    /// `isTriangleDefinedInVertexDataSet`
    fn is_triangle_defined_in_vertex_data_set(
        base_triangle_data: &[f32],
        vertex_data: &[f32],
        vertex_data_n_vertices: u32,
    ) -> bool {
        for n_triangle in 0..(vertex_data_n_vertices / 3) as usize {
            let current_triangle_data = &vertex_data[n_triangle * 9..n_triangle * 9 + 9];

            if is_triangle_defined(current_triangle_data, base_triangle_data) {
                return true;
            }
        }

        false
    }

    /// The `n_base_tess_level` selection of `verifyResultData` for one triangle touching the outer edge.
    fn base_tess_level(primitive_mode: PrimitiveMode, vertices: [&[f32]; 3], is_outer: [bool; 3]) -> u32 {
        let epsilon = 1e-5f32;

        if primitive_mode == PrimitiveMode::Triangles {
            let touches_component_zero =
                |component: usize| (0..3).all(|n| !is_outer[n] || vertices[n][component] == 0.0);

            if touches_component_zero(0) {
                0
            } else if touches_component_zero(1) {
                1
            } else {
                2
            }
        } else {
            let outer_edge_vertices: Vec<&[f32]> = (0..3).filter(|&n| is_outer[n]).map(|n| vertices[n]).collect();

            let mut is_top_outer_edge = true;
            let mut is_right_outer_edge = true;
            let mut is_bottom_outer_edge = true;
            let mut is_left_outer_edge = true;

            // Find which outer edges the vertices don't belong to. If one is in a corner, the other will clarify to which edge both vertices belong.
            for vertex in &outer_edge_vertices {
                // Y < 1, not top outer edge
                if (vertex[1] - 1.0).abs() > epsilon {
                    is_top_outer_edge = false;
                }

                // X < 1, not right outer edge
                if (vertex[0] - 1.0).abs() > epsilon {
                    is_right_outer_edge = false;
                }

                // Y > 0, not bottom outer edge
                if vertex[1].abs() > epsilon {
                    is_bottom_outer_edge = false;
                }

                // X > 0, not left outer edge
                if vertex[0].abs() > epsilon {
                    is_left_outer_edge = false;
                }
            }

            if outer_edge_vertices.len() == 1 {
                // A single vertex with corner-coordinates belongs to two edges. Choose one.
                let x_is_0 = outer_edge_vertices[0][0].abs() < epsilon;
                let x_is_1 = (outer_edge_vertices[0][0] - 1.0).abs() < epsilon;
                let y_is_0 = outer_edge_vertices[0][1].abs() < epsilon;
                let y_is_1 = (outer_edge_vertices[0][1] - 1.0).abs() < epsilon;

                if x_is_0 && y_is_0 {
                    // bottom edge
                    is_left_outer_edge = false;
                } else if x_is_0 && y_is_1 {
                    // left edge
                    is_top_outer_edge = false;
                } else if x_is_1 && y_is_0 {
                    // right edge
                    is_bottom_outer_edge = false;
                } else if x_is_1 && y_is_1 {
                    // top edge
                    is_right_outer_edge = false;
                }
            }

            let _ = is_top_outer_edge;

            // Determine which tessellation level describes the subdivision of the edge that the triangle touches
            if is_left_outer_edge {
                0
            } else if is_bottom_outer_edge {
                1
            } else if is_right_outer_edge {
                2
            } else {
                3
            }
        }
    }
}

impl InvarianceRule for Rule7 {
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
        let test_iteration = self.test_for_iteration(n_iteration);

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

    fn te_code(&mut self, _utils: &Utils<'_>, n_iteration: u32) -> Result<String, TestError> {
        let test_iteration = self.test_for_iteration(n_iteration);

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
            let is_triangles_iteration = n_iteration == 0;
            let n_base_iteration = if n_iteration == 0 {
                0
            } else {
                self.triangles_iterations.len()
            };
            let n_relevant_outer_tess_levels: u32 = if is_triangles_iteration { 3 } else { 4 };
            let primitive_mode = if n_iteration == 0 {
                PrimitiveMode::Triangles
            } else {
                PrimitiveMode::Quads
            };
            let test_iterations = if n_iteration == 0 {
                &self.triangles_iterations
            } else {
                &self.quads_iterations
            };

            if test_iterations.is_empty() {
                return Err(TestError::Fail("No test iterations".to_string()));
            }

            // Find a base iteration first
            for (n_base_test_iteration, base_iteration) in test_iterations.iter().enumerate() {
                if !base_iteration.is_base_iteration {
                    continue;
                }

                // Retrieve reference test iterations
                let mut ref_iteration_indices: Vec<usize> = Vec::new();

                for n_reference_iteration in 0..n_relevant_outer_tess_levels {
                    let n_modified_outer_tess_level =
                        (base_iteration.n_modified_outer_tess_level + n_reference_iteration + 1)
                            % n_relevant_outer_tess_levels;

                    let ref_iteration_index = self
                        .test_iteration_index(
                            is_triangles_iteration,
                            &base_iteration.inner_tess_levels,
                            &base_iteration.outer_tess_levels,
                            base_iteration.vertex_ordering,
                            n_modified_outer_tess_level,
                        )
                        .ok_or_else(|| TestError::Fail("Could not find a reference iteration".to_string()))?;

                    ref_iteration_indices.push(ref_iteration_index);
                }

                // Compare the base data with the information generated for the reference iterations.
                for &n_ref_test_iteration in &ref_iteration_indices {
                    let ref_iteration = &test_iterations[n_ref_test_iteration];

                    // Move through all triangles generated for the base test iteration, focusing on the ones that connect the outer edge with one of the inner ones.
                    let base_iteration_vertex_data =
                        bytes_as_floats(&all_iterations_data[n_base_iteration + n_base_test_iteration]);
                    let ref_iteration_vertex_data =
                        bytes_as_floats(&all_iterations_data[n_base_iteration + n_ref_test_iteration]);

                    for n_base_triangle in 0..(base_iteration.n_vertices / 3) as usize {
                        let base_triangle_data =
                            &base_iteration_vertex_data[n_base_triangle * 9..n_base_triangle * 9 + 9];

                        let base_triangle_vertices = [
                            &base_triangle_data[0..3],
                            &base_triangle_data[3..6],
                            &base_triangle_data[6..9],
                        ];
                        let is_outer = [
                            is_outer_edge_vertex(primitive_mode, base_triangle_vertices[0]),
                            is_outer_edge_vertex(primitive_mode, base_triangle_vertices[1]),
                            is_outer_edge_vertex(primitive_mode, base_triangle_vertices[2]),
                        ];

                        let n_outer_edge_vertices_found = is_outer.iter().filter(|&&outer| outer).count();

                        if n_outer_edge_vertices_found == 0 {
                            // This is an inner triangle, not really of interest
                            continue;
                        }

                        let n_base_tess_level = Self::base_tess_level(primitive_mode, base_triangle_vertices, is_outer);

                        // The check is not performed if the edge was described by a different outer tessellation level in the reference data set
                        if n_base_tess_level == ref_iteration.n_modified_outer_tess_level {
                            continue;
                        }

                        // This triangle should be present in both vertex data sets
                        if !Self::is_triangle_defined_in_vertex_data_set(
                            base_triangle_data,
                            &ref_iteration_vertex_data,
                            ref_iteration.n_vertices,
                        ) {
                            let primitive_mode_str = if is_triangles_iteration { "triangles" } else { "quads" };

                            log::info!(
                                "For primitive mode [{primitive_mode_str}] , inner tessellation levels:[{}, {}], outer tessellation levels:[{}, {}, {}, {}], a triangle connecting inner & outer edges:[{}, {}, {}]x[{}, {}, {}]x[{}, {}, {}] was not found for runs using CW and CCW vertex ordering, which is against the extension specification's rule 7.",
                                base_iteration.inner_tess_levels[0],
                                base_iteration.inner_tess_levels[1],
                                base_iteration.outer_tess_levels[0],
                                base_iteration.outer_tess_levels[1],
                                base_iteration.outer_tess_levels[2],
                                base_iteration.outer_tess_levels[3],
                                base_triangle_vertices[0][0],
                                base_triangle_vertices[0][1],
                                base_triangle_vertices[0][2],
                                base_triangle_vertices[1][0],
                                base_triangle_vertices[1][1],
                                base_triangle_vertices[1][2],
                                base_triangle_vertices[2][0],
                                base_triangle_vertices[2][1],
                                base_triangle_vertices[2][2]
                            );

                            return Err(TestError::Fail(
                                "Implementation is not conformant with Tessellation Rule 7".to_string(),
                            ));
                        }
                    }
                }
            }
        }

        Ok(())
    }
}
