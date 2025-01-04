// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/tessellation_shader/esextcTessellationShaderVertexSpacing.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `_tess_coordinate_cartesian` is `[f32; 2]`; its `operator==` is `same_point` (epsilon 1e-3) and `_comparator_exact_tess_coordinate_match` is `==`.

use std::cmp::Ordering;

use super::TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED;
use super::utils::{
    LEVEL_SET_FILTER_INNER_AND_OUTER_LEVELS_USE_DIFFERENT_VALUES, PrimitiveMode, Utils, VertexOrdering, VertexSpacing,
    bytes_to_floats, convert_barycentric_coordinates_to_cartesian, get_es_token_for_primitive_mode,
    get_es_token_for_vertex_spacing_mode, get_tessellation_level_after_vertex_spacing,
    get_tessellation_level_set_for_primitive_mode,
};
use crate::glu::{self, Context, TestCase};
use crate::glw::{GLint, GLuint};
use crate::khr_gl::esext::{ExtParameters, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// Precision, with which the test should be executed.
const EPSILON: f32 = 1e-3;

type Point = [f32; 2];

/// `TessellationShaderVertexSpacing`
pub(super) struct VertexSpacingCase {
    pub ext_params: ExtParameters,
    pub name: String,
    pub primitive_mode: PrimitiveMode,
    pub vs_mode: VertexSpacing,
}

impl VertexSpacingCase {
    /// The constructor appends `_primitive_mode_<mode>_vs_mode_<spacing>` to `vertex_spacing`.
    pub fn new(ext_params: ExtParameters, primitive_mode: PrimitiveMode, vs_mode: VertexSpacing) -> Self {
        let name = format!(
            "vertex_spacing_primitive_mode_{}_vs_mode_{}",
            get_es_token_for_primitive_mode(primitive_mode),
            get_es_token_for_vertex_spacing_mode(vs_mode)
        );
        Self {
            ext_params,
            name,
            primitive_mode,
            vs_mode,
        }
    }
}

/// `_run`
struct Run {
    inner: [f32; 2],
    outer: [f32; 4],
    primitive_mode: PrimitiveMode,
    vertex_spacing: VertexSpacing,
    data: Vec<f32>,
    /// only used for 'triangles'
    data_cartesian: Vec<f32>,
    n_vertices: u32,
}

/// `_tess_edge`
struct Edge {
    points: Vec<Point>,
    edge_length: f32,
    outermost_tess_level: f32,
    tess_level: f32,
}

/// `_tess_coordinate_delta`
struct CoordinateDelta {
    counter: u32,
    delta: f32,
}

/// `_tess_coordinate_cartesian::operator==`
fn same_point(a: Point, b: Point) -> bool {
    (a[0] - b[0]).abs() < EPSILON && (a[1] - b[1]).abs() < EPSILON
}

fn distance(a: Point, b: Point) -> f32 {
    ((a[0] - b[0]) * (a[0] - b[0]) + (a[1] - b[1]) * (a[1] - b[1])).sqrt()
}

/// `std::find` with `operator==` followed by `erase`
fn remove_first_match(coordinates: &mut Vec<Point>, point: Point) {
    if let Some(index) = coordinates.iter().position(|candidate| same_point(*candidate, point)) {
        coordinates.remove(index);
    }
}

/// `_comparator_relative_to_base_point`
fn sort_relative_to_base_point(points: &mut [Point], base_point: Point) {
    points.sort_by(|a, b| {
        distance(*a, base_point)
            .partial_cmp(&distance(*b, base_point))
            .unwrap_or(Ordering::Equal)
    });
}

/// `isPointOnLine`: the distance from a point to a line passing through two points.
fn is_point_on_line(line_v1: Point, line_v2: Point, point: Point) -> bool {
    let dx = line_v1[0] - line_v2[0];
    let dy = line_v1[1] - line_v2[1];
    let denominator = (dx * dx + dy * dy).sqrt();
    let d = (dy * point[0] - dx * point[1] + line_v1[0] * line_v2[1] - line_v2[0] * line_v1[1]).abs() / denominator;
    d.abs() < EPSILON
}

/// `getEdgesForIsolinesTessellation`
fn get_edges_for_isolines_tessellation(run: &Run) -> Vec<Edge> {
    let mut result: Vec<Edge> = Vec::new();

    // Convert the array data to a vector of edges, each of which is a vector of points with the same V component; the outermost level does not apply to this primitive mode.
    for n_vertex in 0..run.n_vertices as usize {
        let coordinate = &run.data[3 * n_vertex..];
        let new_item = [coordinate[0], coordinate[1]];

        // Each edge uses the same Y component, so only the first entry has to be checked.
        if let Some(edge) = result
            .iter_mut()
            .find(|edge| (edge.points[0][1] - coordinate[1]).abs() < EPSILON)
        {
            edge.points.push(new_item);
        } else {
            result.push(Edge {
                points: vec![new_item],
                edge_length: 1.0,
                outermost_tess_level: run.outer[1],
                tess_level: run.outer[1],
            });
        }
    }

    // For each edge, sort the points by U coordinate
    for edge in &mut result {
        edge.points
            .sort_by(|a, b| a[0].partial_cmp(&b[0]).unwrap_or(Ordering::Equal));
    }
    result
}

/// `getEdgesForQuadsTessellation`
fn get_edges_for_quads_tessellation(run: &Run) -> Result<Vec<Edge>, TestError> {
    let mut result: Vec<Edge> = Vec::new();

    // The data set describes an outer and an inner rectangle. Each of the two iterations finds the corner vertices (the furthest from (0.5, 0.5) in each quadrant), removes them, and then
    // collects the points lying on the edges between the corners.
    let mut coordinates: Vec<Point> = (0..run.n_vertices as usize)
        .map(|n_vertex| [run.data[3 * n_vertex], run.data[3 * n_vertex + 1]])
        .collect();

    let n_iterations = if run.inner[0] > 1.0 { 2 } else { 1 };
    for n_iteration in 0..n_iterations {
        let mut current_tl_point: Point = [0.0, 0.0];
        let mut current_tl_point_delta = 0.0_f32;
        let mut current_tr_point: Point = [0.0, 0.0];
        let mut current_tr_point_delta = 0.0_f32;
        let mut current_bl_point: Point = [0.0, 0.0];
        let mut current_bl_point_delta = 0.0_f32;
        let mut current_br_point: Point = [0.0, 0.0];
        let mut current_br_point_delta = 0.0_f32;

        for &coordinate in &coordinates {
            let delta_x = coordinate[0] - 0.5;
            let delta_y = coordinate[1] - 0.5;
            let delta = (delta_x * delta_x + delta_y * delta_y).sqrt();

            if delta_x <= 0.0 && delta_y >= 0.0 && delta > current_tl_point_delta {
                current_tl_point = coordinate;
                current_tl_point_delta = delta;
            }
            if delta_x >= 0.0 && delta_y >= 0.0 && delta > current_tr_point_delta {
                current_tr_point = coordinate;
                current_tr_point_delta = delta;
            }
            if delta_x <= 0.0 && delta_y <= 0.0 && delta > current_bl_point_delta {
                current_bl_point = coordinate;
                current_bl_point_delta = delta;
            }
            if delta_x >= 0.0 && delta_y <= 0.0 && delta > current_br_point_delta {
                current_br_point = coordinate;
                current_br_point_delta = delta;
            }
        }

        // If any outer level is 1, at least two corner points refer to the same point; a corner already erased is simply not found.
        for corner_coordinate in [current_tl_point, current_tr_point, current_bl_point, current_br_point] {
            remove_first_match(&mut coordinates, corner_coordinate);
        }

        // For the inner quad, 2 segments connecting the outer and the inner coordinates are subtracted.
        let tl_tr_delta = distance(current_tl_point, current_tr_point);
        let tr_br_delta = distance(current_tr_point, current_br_point);
        let br_bl_delta = distance(current_br_point, current_bl_point);
        let bl_tl_delta = distance(current_bl_point, current_tl_point);

        let mut tl_tr_edge = Edge {
            points: Vec::new(),
            edge_length: tl_tr_delta,
            outermost_tess_level: run.outer[3],
            tess_level: 0.0,
        };
        let mut tr_br_edge = Edge {
            points: Vec::new(),
            edge_length: tr_br_delta,
            outermost_tess_level: run.outer[2],
            tess_level: 0.0,
        };
        let mut br_bl_edge = Edge {
            points: Vec::new(),
            edge_length: br_bl_delta,
            outermost_tess_level: run.outer[1],
            tess_level: 0.0,
        };
        let mut bl_tl_edge = Edge {
            points: Vec::new(),
            edge_length: bl_tl_delta,
            outermost_tess_level: run.outer[0],
            tess_level: 0.0,
        };

        if n_iteration == 0 {
            tl_tr_edge.tess_level = run.outer[3];
            tr_br_edge.tess_level = run.outer[2];
            br_bl_edge.tess_level = run.outer[1];
            bl_tl_edge.tess_level = run.outer[0];
        } else {
            tl_tr_edge.tess_level = run.inner[0] - 2.0;
            br_bl_edge.tess_level = run.inner[0] - 2.0;
            tr_br_edge.tess_level = run.inner[1] - 2.0;
            bl_tl_edge.tess_level = run.inner[1] - 2.0;
        }

        // Add the corner points to the edge descriptors; the same point must not be added twice, as that confuses verifyEdges().
        tl_tr_edge.points.push(current_tl_point);
        if !same_point(current_tl_point, current_tr_point) {
            tl_tr_edge.points.push(current_tr_point);
        }
        tr_br_edge.points.push(current_tr_point);
        if !same_point(current_tr_point, current_br_point) {
            tr_br_edge.points.push(current_br_point);
        }
        br_bl_edge.points.push(current_br_point);
        if !same_point(current_br_point, current_bl_point) {
            br_bl_edge.points.push(current_bl_point);
        }
        bl_tl_edge.points.push(current_bl_point);
        if !same_point(current_bl_point, current_tl_point) {
            bl_tl_edge.points.push(current_tl_point);
        }

        let mut edges = [tl_tr_edge, tr_br_edge, br_bl_edge, bl_tl_edge];

        // Identify the points that lie on any of the edges considered
        for edge in &mut edges {
            // Degenerate edges consist of one point only.
            if edge.points.len() > 1 {
                let edge_start_point = edge.points[0];
                let edge_end_point = edge.points[1];

                for &coordinate in &coordinates {
                    if is_point_on_line(edge_start_point, edge_end_point, coordinate)
                        && !same_point(edge_start_point, coordinate)
                        && !same_point(edge_end_point, coordinate)
                    {
                        // A duplicate is very likely a bug in the implementation's point mode support.
                        if !edge.points.contains(&coordinate) {
                            edge.points.push(coordinate);
                        } else {
                            log::info!(
                                "A duplicate vertex ({}, {}) was found in set of coordinates generated for the following configuration: inner tessellation levels:({}, {}) outer tessellation levels:({}, {}, {}, {}) primitive mode:{} vertex spacing mode:{} point mode:yes",
                                coordinate[0],
                                coordinate[1],
                                run.inner[0],
                                run.inner[1],
                                run.outer[0],
                                run.outer[1],
                                run.outer[2],
                                run.outer[3],
                                get_es_token_for_primitive_mode(run.primitive_mode),
                                get_es_token_for_vertex_spacing_mode(run.vertex_spacing)
                            );
                            return Err(TestError::Fail("A duplicate vertex was found in generated tessellation coordinate set when point mode was used".to_string()));
                        }
                    }
                }

                sort_relative_to_base_point(&mut edge.points, edge_start_point);
            }
        }

        // Remove all coordinates associated with edges from the data set
        for edge in &edges {
            for &coordinate in &edge.points {
                remove_first_match(&mut coordinates, coordinate);
            }
        }

        result.extend(edges);
    }

    Ok(result)
}

/// `getEdgesForTrianglesTessellation`
fn get_edges_for_triangles_tessellation(run: &Run, gl_max_tess_gen_level_value: GLint) -> Result<Vec<Edge>, TestError> {
    if run.data_cartesian.is_empty() {
        return Err(TestError::Fail("Cartesian data missing".to_string()));
    }

    let mut coordinates: Vec<Point> = (0..run.n_vertices as usize)
        .map(|n_vertex| [run.data_cartesian[n_vertex * 2], run.data_cartesian[n_vertex * 2 + 1]])
        .collect();

    // Finds three corner vertices of the outermost triangle (an error if fewer than three coordinates are left), associates the remaining points with the AB, BC and CA edges, removes them, and
    // goes on with the next inner triangle while coordinates remain.
    let mut tess_level_delta = 0_u32;
    let mut result: Vec<Edge> = Vec::new();

    // As per the extension spec, an inner level of one with any outer level above one is treated as 1+epsilon and rounded up to a two- or three-segment subdivision according to the spacing.
    let (_, inner0_round_clamped_value) =
        get_tessellation_level_after_vertex_spacing(run.vertex_spacing, run.inner[0], gl_max_tess_gen_level_value);
    let base_tess_level =
        if inner0_round_clamped_value == 1.0 && (run.outer[0] > 1.0 || run.outer[1] > 1.0 || run.outer[2] > 1.0) {
            get_tessellation_level_after_vertex_spacing(
                run.vertex_spacing,
                inner0_round_clamped_value + 1.0,
                gl_max_tess_gen_level_value,
            )
            .1
        } else {
            get_tessellation_level_after_vertex_spacing(run.vertex_spacing, run.inner[0], gl_max_tess_gen_level_value).1
        };

    while !coordinates.is_empty() {
        // With an even tessellation level one coordinate may be left, which is the degenerate vertex.
        if (base_tess_level as i32) % 2 == 0 && coordinates.len() == 1 {
            break;
        }
        if coordinates.len() < 3 {
            return Err(TestError::Fail(
                "Could not extract three corner vertices that would make up a triangle".to_string(),
            ));
        }

        // The corner vertices of the outermost triangle are (1, 0, 0), (0, 1, 0) and (0, 0, 1) in barycentric coordinates, i.e. (0.5, 0), (1, 1) and (0, 1) in Euclidean space; the vertices closest to
        // those ideal coordinates are picked.
        let mut delta_v1 = 0.0_f32;
        let mut delta_v2 = 0.0_f32;
        let mut delta_v3 = 0.0_f32;
        let mut selected_v1_index = 0;
        let mut selected_v2_index = 0;
        let mut selected_v3_index = 0;
        for (curr_index, coordinate) in coordinates.iter().enumerate() {
            let curr_delta_v1 =
                ((coordinate[0] - 0.5) * (coordinate[0] - 0.5) + (coordinate[1] - 0.0) * (coordinate[1] - 0.0)).sqrt();
            let curr_delta_v2 =
                ((coordinate[0] - 1.0) * (coordinate[0] - 1.0) + (coordinate[1] - 1.0) * (coordinate[1] - 1.0)).sqrt();
            let curr_delta_v3 =
                ((coordinate[0] - 0.0) * (coordinate[0] - 0.0) + (coordinate[1] - 1.0) * (coordinate[1] - 1.0)).sqrt();

            if curr_index == 0 {
                delta_v1 = curr_delta_v1;
                delta_v2 = curr_delta_v2;
                delta_v3 = curr_delta_v3;
            } else {
                if curr_delta_v1 < delta_v1 {
                    delta_v1 = curr_delta_v1;
                    selected_v1_index = curr_index;
                }
                if curr_delta_v2 < delta_v2 {
                    delta_v2 = curr_delta_v2;
                    selected_v2_index = curr_index;
                }
                if curr_delta_v3 < delta_v3 {
                    delta_v3 = curr_delta_v3;
                    selected_v3_index = curr_index;
                }
            }
        }

        let corner_vertices = [
            coordinates[selected_v1_index],
            coordinates[selected_v2_index],
            coordinates[selected_v3_index],
        ];
        for vertex in corner_vertices {
            remove_first_match(&mut coordinates, vertex);
        }

        // Identify all points that lie on the edges defined by these corner vertices
        let [v1, v2, v3] = corner_vertices;
        let mut edge_v1_v2_vertices: Vec<Point> = Vec::new();
        let mut edge_v2_v3_vertices: Vec<Point> = Vec::new();
        let mut edge_v3_v1_vertices: Vec<Point> = Vec::new();
        for &coordinate in &coordinates {
            if is_point_on_line(v1, v2, coordinate) {
                edge_v1_v2_vertices.push(coordinate);
            }
            if is_point_on_line(v2, v3, coordinate) {
                edge_v2_v3_vertices.push(coordinate);
            }
            if is_point_on_line(v3, v1, coordinate) {
                edge_v3_v1_vertices.push(coordinate);
            }
        }

        // Now that the edge vertices are known, remove them from the data set
        for edge in [&edge_v1_v2_vertices, &edge_v2_v3_vertices, &edge_v3_v1_vertices] {
            for &coordinate in edge {
                remove_first_match(&mut coordinates, coordinate);
            }
        }

        // Add the corner coordinates to the vectors, unless they are already there.
        let add_if_missing = |edge: &mut Vec<Point>, point: Point| {
            if !edge.iter().any(|candidate| same_point(*candidate, point)) {
                edge.push(point);
            }
        };
        add_if_missing(&mut edge_v1_v2_vertices, v1);
        add_if_missing(&mut edge_v1_v2_vertices, v2);
        add_if_missing(&mut edge_v2_v3_vertices, v2);
        add_if_missing(&mut edge_v2_v3_vertices, v3);
        add_if_missing(&mut edge_v3_v1_vertices, v3);
        add_if_missing(&mut edge_v3_v1_vertices, v1);

        // Sort all points relative to the corner point
        sort_relative_to_base_point(&mut edge_v1_v2_vertices, v1);
        sort_relative_to_base_point(&mut edge_v2_v3_vertices, v2);
        sort_relative_to_base_point(&mut edge_v3_v1_vertices, v3);

        for (n_edge_ptr, edge) in [edge_v1_v2_vertices, edge_v2_v3_vertices, edge_v3_v1_vertices]
            .into_iter()
            .enumerate()
        {
            // The tessellation level values of the edge
            let (curr_tess_level, outermost_tess_level) = if tess_level_delta == 0 {
                // Assuming v1 = (1, 0, 0), v2 = (0, 1, 0), v3 = (0, 0, 1)
                match n_edge_ptr {
                    0 => (run.outer[2], run.outer[2]),
                    1 => (run.outer[0], run.outer[0]),
                    _ => (run.outer[1], run.outer[1]),
                }
            } else {
                (base_tess_level - tess_level_delta as f32, base_tess_level)
            };

            let edge_start_point = edge[0];
            let edge_end_point = edge[edge.len() - 1];
            let edge_length = distance(edge_end_point, edge_start_point);

            result.push(Edge {
                points: edge,
                edge_length,
                outermost_tess_level,
                tess_level: curr_tess_level,
            });
        }

        // Next inner triangle: as per spec, the tessellation level is reduced by 2.
        tess_level_delta += 2;
    }

    Ok(result)
}

impl VertexSpacingCase {
    /// `verifyEdges`
    fn verify_edges(edges: &[Edge], run: &Run, gl_max_tess_gen_level_value: GLint) -> Result<(), TestError> {
        let primitive_mode_string = get_es_token_for_primitive_mode(run.primitive_mode);
        let vertex_spacing_string = get_es_token_for_vertex_spacing_mode(run.vertex_spacing);
        let describe = || {
            format!(
                "primitive mode:{primitive_mode_string}vertex spacing mode:{vertex_spacing_string}inner tessellation levels: ({}, {}), outer tessellation levels: ({}, {}, {}, {})",
                run.inner[0], run.inner[1], run.outer[0], run.outer[1], run.outer[2], run.outer[3]
            )
        };

        for (n_edge, edge) in edges.iter().enumerate() {
            let (_, outermost_edge_tess_level_clamped_rounded) = get_tessellation_level_after_vertex_spacing(
                run.vertex_spacing,
                edge.outermost_tess_level,
                gl_max_tess_gen_level_value,
            );
            let (edge_clamped_tess_level, edge_clamped_rounded_tess_level) =
                get_tessellation_level_after_vertex_spacing(
                    run.vertex_spacing,
                    edge.tess_level,
                    gl_max_tess_gen_level_value,
                );
            let _ = edge_clamped_tess_level;

            // Vertex spacing has no meaning for degenerate edges, so they are skipped.
            let n_points = edge.points.len();
            if n_points < 2 {
                continue;
            }

            let mut segment_deltas: Vec<CoordinateDelta> = Vec::new();
            for n_base_point in 0..n_points - 1 {
                let distance = distance(edge.points[n_base_point], edge.points[n_base_point + 1]);

                if let Some(known) = segment_deltas
                    .iter_mut()
                    .find(|candidate| (candidate.delta - distance).abs() < EPSILON)
                {
                    known.counter += 1;
                } else {
                    segment_deltas.push(CoordinateDelta {
                        counter: 1,
                        delta: distance,
                    });
                }
            }

            match run.vertex_spacing {
                VertexSpacing::Default | VertexSpacing::Equal => {
                    // A single delta of a predefined length, describing exactly edge_clamped_rounded_tess_level segments.
                    let expected_delta = edge.edge_length / edge_clamped_rounded_tess_level;

                    if segment_deltas.len() != 1 {
                        log::info!(
                            "More than one segment delta was generated for the following tessellation configuration: {}",
                            describe()
                        );
                        return Err(TestError::Fail("Equal vertex spacing mode tessellation generated segment edges of varying lengths, whereas only one was expected.".to_string()));
                    }
                    if (segment_deltas[0].delta - expected_delta).abs() > EPSILON {
                        log::info!(
                            "Invalid segment delta (expected:{expected_delta}, found: {}) was generated for the following tessellation configuration: {}",
                            segment_deltas[0].delta,
                            describe()
                        );
                        return Err(TestError::Fail("Invalid delta between segments generated by the tessellator configured to run in equal vertex spacing mode".to_string()));
                    }
                    if segment_deltas[0].counter != edge_clamped_rounded_tess_level as u32 {
                        log::info!(
                            "Invalid amount of segments (expected:{}, found: {}) was generated for the following tessellation configuration: {}",
                            edge_clamped_rounded_tess_level as i32,
                            segment_deltas[0].counter,
                            describe()
                        );
                        return Err(TestError::Fail(
                            "Invalid amount of segments generated for equal vertex spacing mode".to_string(),
                        ));
                    }
                }
                VertexSpacing::FractionalEven | VertexSpacing::FractionalOdd => {
                    // The extension specification is very liberal about segment lengths, so only this is tested: a) no more than 2 deltas per edge; b) a single delta defines exactly
                    // edge_clamped_rounded_tess_level-2 segments if |edge_clamped_rounded_tess_level - edge_clamped_tess_level| == 2.0, or edge_clamped_rounded_tess_level otherwise;
                    // c) two deltas: one defines 2 segments and the other edge_clamped_rounded_tess_level-2.
                    if segment_deltas.len() > 2 {
                        log::info!(
                            "More than two segment deltas ({}) were generated for the following tessellation configuration: {}",
                            segment_deltas.len(),
                            describe()
                        );
                        return Err(TestError::Fail("Fractional spacing mode tessellated edges to segments of more than two differentiable lengths".to_string()));
                    }

                    if segment_deltas.len() == 1 {
                        let expected_counter: i32 = if run.primitive_mode == PrimitiveMode::Triangles {
                            // With each triangle level 2 segments go out; each triangle consists of 3 edges.
                            outermost_edge_tess_level_clamped_rounded as i32 - 2 * (n_edge / 3) as i32
                        } else {
                            let mut expected_counter = edge_clamped_rounded_tess_level as i32;
                            if run.primitive_mode == PrimitiveMode::Quads
                                && run.vertex_spacing == VertexSpacing::FractionalOdd
                            {
                                // 8 edges are expected in total; the inner quad has 2 segments less.
                                expected_counter = edge_clamped_rounded_tess_level as i32 - 2 * (n_edge / 4) as i32;
                            }
                            // For degenerate cases exactly one segment is expected.
                            if edge.tess_level <= 0.0 {
                                expected_counter = 1;
                            }
                            expected_counter
                        };

                        if segment_deltas[0].counter != expected_counter as u32 {
                            log::info!(
                                "Invalid amount of segments (expected:{expected_counter}, found: {}) was generated for the following tessellation configuration: {}",
                                segment_deltas[0].counter,
                                describe()
                            );
                            return Err(TestError::Fail(
                                "Invalid amount of segments generated for fractional vertex spacing mode".to_string(),
                            ));
                        }
                    } else {
                        let rounded_minus_two = (edge_clamped_rounded_tess_level as u32).wrapping_sub(2);
                        if !((segment_deltas[0].counter == 2 && segment_deltas[1].counter == rounded_minus_two)
                            || (segment_deltas[1].counter == 2 && segment_deltas[0].counter == rounded_minus_two))
                        {
                            log::info!(
                                "Invalid number of segments with different deltas ({} and {}) was generated. {}",
                                segment_deltas[0].delta,
                                segment_deltas[1].delta,
                                describe()
                            );
                            return Err(TestError::Fail(
                                "Equal amount of segments was generated for segments of different deltas".to_string(),
                            ));
                        }
                        if segment_deltas[0].counter != 2 && segment_deltas[1].counter != 2 {
                            log::info!(
                                "Neither of the segments generated by the tessellator was defined exactly twice.{}",
                                describe()
                            );
                            return Err(TestError::Fail("Neither of the generated segments was repeated exactly twice for fractional vertex spacing mode".to_string()));
                        }
                    }
                }
            }
        }
        Ok(())
    }

    fn run(&self, context: &Context, vao_id: &mut GLuint) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);

        if !base.is_tessellation_shader_supported {
            return Err(TestError::NotSupported(
                TESSELLATION_SHADER_EXTENSION_NOT_SUPPORTED.to_string(),
            ));
        }

        // initTest
        let utils = Utils::new(context, &base)?;

        gl!(gl.gen_vertex_arrays(1, vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;
        gl!(gl.bind_vertex_array(*vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        let mut gl_max_tess_gen_level_value: GLint = 0;
        gl!(gl.get_integerv(base.gl_ext_tokens.max_tess_gen_level, &mut gl_max_tess_gen_level_value));
        glu::expect_no_error(gl, "glGetIntegerv() call failed for GL_MAX_TESS_GEN_LEVEL_EXT pname")?;

        let tess_levels_set = get_tessellation_level_set_for_primitive_mode(
            self.primitive_mode,
            gl_max_tess_gen_level_value,
            LEVEL_SET_FILTER_INNER_AND_OUTER_LEVELS_USE_DIFFERENT_VALUES,
        );

        let mut runs: Vec<Run> = Vec::new();
        for tess_levels in &tess_levels_set {
            if self.primitive_mode == PrimitiveMode::Quads
                && self.vs_mode == VertexSpacing::FractionalOdd
                && (tess_levels.inner[0] <= 1.0 || tess_levels.inner[1] <= 1.0)
            {
                continue;
            }

            let mut run = Run {
                inner: tess_levels.inner,
                outer: tess_levels.outer,
                primitive_mode: self.primitive_mode,
                vertex_spacing: self.vs_mode,
                data: Vec::new(),
                data_cartesian: Vec::new(),
                n_vertices: 0,
            };

            run.n_vertices = utils.get_amount_of_vertices_generated_by_tessellator(
                run.primitive_mode,
                &run.inner,
                &run.outer,
                run.vertex_spacing,
                true,
            )?;
            if run.n_vertices == 0 {
                log::info!(
                    "No vertices were generated by tessellator for: inner tess levels:[{}, {}], outer tess levels:[{}, {}, {}, {}], primitive mode: {}, vertex spacing: {}",
                    run.inner[0],
                    run.inner[1],
                    run.outer[0],
                    run.outer[1],
                    run.outer[2],
                    run.outer[3],
                    get_es_token_for_primitive_mode(self.primitive_mode),
                    get_es_token_for_vertex_spacing_mode(self.vs_mode)
                );
                return Err(TestError::Fail(
                    "Zero vertices were generated by tessellator".to_string(),
                ));
            }

            run.data = bytes_to_floats(&utils.get_data_generated_by_tessellator(
                &run.inner,
                true,
                run.primitive_mode,
                VertexOrdering::Ccw,
                run.vertex_spacing,
                &run.outer,
            )?);

            // 'triangles' data is expressed in barycentric coordinates and has to be converted to Euclidean space.
            if run.primitive_mode == PrimitiveMode::Triangles {
                run.data_cartesian = (0..run.n_vertices as usize)
                    .flat_map(|n_vertex| convert_barycentric_coordinates_to_cartesian(&run.data[n_vertex * 3..]))
                    .collect();
            }
            runs.push(run);
        }

        for run in &runs {
            let edges = match run.primitive_mode {
                PrimitiveMode::Isolines => get_edges_for_isolines_tessellation(run),
                PrimitiveMode::Quads => get_edges_for_quads_tessellation(run)?,
                PrimitiveMode::Triangles => get_edges_for_triangles_tessellation(run, gl_max_tess_gen_level_value)?,
            };
            Self::verify_edges(&edges, run, gl_max_tess_gen_level_value)?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for VertexSpacingCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut vao_id: GLuint = 0;
        let outcome = self.run(context, &mut vao_id);

        gl!(gl.bind_vertex_array(0));
        if vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &vao_id));
        }
        outcome
    }
}
