// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderAdjacency.cpp / .hpp
//   external/openglcts/modules/glesext/geometry_shader/esextcGeometryShaderAdjacencyTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The grid objects hold indices instead of pointers, the eight
// `GeometryShaderAdjacency` instances differ by `Mode` and `indiced`, and every instance has a geometry shader
// (upstream only ever passes `withGS = true`).

use std::ffi::CString;

use crate::glu::{self, Context, TestCase};
use crate::glw::{self, GLenum, GLuint};
use crate::khr_gl::esext::{ExtParameters, ShaderBody, TestCaseBase};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const FS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nvoid main()\n{\n}\n";
const VS_CODE: &str = "${VERSION}\n\nprecision highp float;\n\nlayout(location = 0) in vec2 position_data;\n\nvoid main()\n{\n    gl_Position = vec4(position_data, 0, 1);\n}\n";

const GS_CODE_LINES: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(lines_adjacency)            in;\nlayout(line_strip, max_vertices=2) out;\n\nlayout(location = 0) out vec4 out_adjacent_geometry;\nlayout(location = 1) out vec4 out_geometry;\n\nvoid main()\n{\n    out_adjacent_geometry = gl_in[0].gl_Position;\n    out_geometry          = gl_in[1].gl_Position;\n    EmitVertex();\n    out_adjacent_geometry = gl_in[3].gl_Position;\n    out_geometry          = gl_in[2].gl_Position;\n    EmitVertex();\n    EndPrimitive();\n}\n";
const GS_CODE_LINE_STRIP: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(lines_adjacency)            in;\nlayout(line_strip, max_vertices=2) out;\n\nout vec4 out_adjacent_geometry;\nout vec4 out_geometry;\n\nvoid main()\n{\n    out_adjacent_geometry = gl_in[0].gl_Position;\n    out_geometry          = gl_in[1].gl_Position;\n    EmitVertex();\n    out_adjacent_geometry = gl_in[3].gl_Position;\n    out_geometry          = gl_in[2].gl_Position;\n    EmitVertex();\n    EndPrimitive();\n}\n";
const GS_CODE_TRIANGLES: &str = "${VERSION}\n\n${GEOMETRY_SHADER_REQUIRE}\n\nprecision highp float;\n\nlayout(triangles_adjacency)            in;\nlayout(triangle_strip, max_vertices=3) out;\n\nout vec4 out_adjacent_geometry;\nout vec4 out_geometry;\n\nvoid main()\n{\n    out_adjacent_geometry = gl_in[1].gl_Position;\n    out_geometry          = gl_in[0].gl_Position;\n    EmitVertex();\n    out_adjacent_geometry = gl_in[3].gl_Position;\n    out_geometry          = gl_in[2].gl_Position;\n    EmitVertex();\n    out_adjacent_geometry = gl_in[5].gl_Position;\n    out_geometry          = gl_in[4].gl_Position;\n    EmitVertex();\n    EndPrimitive();\n}\n";

const GRID_GRANULARITY: usize = 1;
const N_COMPONENTS_INPUT: usize = 2;
const N_COMPONENTS_OUTPUT: usize = 4;
const N_LINE_SEGMENTS: usize = 4;
const N_VERTICES_PER_TRIANGLE: usize = 3;
const EPSILON: f32 = 0.00001;
const FLOAT_SIZE: usize = std::mem::size_of::<f32>();
const UINT_SIZE: usize = std::mem::size_of::<u32>();

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Mode {
    Lines,
    LineStrip,
    Triangles,
    TriangleStrip,
}

/// `GeometryShaderAdjacency` with the `AdjacencyTestData` its group builds for it
pub(super) struct Adjacency {
    pub ext_params: ExtParameters,
    pub name: &'static str,
    pub mode: Mode,
    pub indiced: bool,
}

#[derive(Clone, Copy, Default)]
struct GridPoint {
    index: u32,
    x: f32,
    y: f32,
}

#[derive(Clone, Copy, Default)]
struct LineSegment {
    end: usize,
    end_adjacent: usize,
    start: usize,
    start_adjacent: usize,
}

#[derive(Clone, Copy, Default)]
struct GridTriangle {
    vertex_x: usize,
    vertex_x_adjacent: usize,
    vertex_y: usize,
    vertex_y_adjacent: usize,
    vertex_z: usize,
    vertex_z_adjacent: usize,
}

#[derive(Default)]
struct Grid {
    line_segments: Vec<LineSegment>,
    line_strip: Vec<GridPoint>,
    points: Vec<GridPoint>,
    triangles: Vec<GridTriangle>,
    triangle_strip: Vec<GridPoint>,
}

#[derive(Default)]
struct TestData {
    gs_code: &'static str,
    mode: GLenum,
    n_vertices: usize,
    geometry_bo_size: usize,
    index_data_bo_size: usize,
    vertex_data_bo_size: usize,
    expected_adjacency_geometry: Vec<f32>,
    expected_geometry: Vec<f32>,
    alternate_expected_adjacency_geometry: Vec<f32>,
    alternate_expected_geometry: Vec<f32>,
    index_data: Vec<u32>,
    tf_mode: GLenum,
    vertex_data: Vec<f32>,
}

#[derive(Default)]
struct Resources {
    adjacency_geometry_bo_id: GLuint,
    fs_id: GLuint,
    geometry_bo_id: GLuint,
    gs_id: GLuint,
    index_data_bo_id: GLuint,
    vertex_data_bo_id: GLuint,
    po_id: GLuint,
    vao_id: GLuint,
    vs_id: GLuint,
}

fn push_point(target: &mut Vec<f32>, point: &GridPoint) {
    target.extend_from_slice(&[point.x, point.y, 0.0, 1.0]);
}

fn push_xy(target: &mut Vec<f32>, point: &GridPoint) {
    target.extend_from_slice(&[point.x, point.y]);
}

fn distance(a: &GridPoint, b: &GridPoint) -> f32 {
    ((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)).sqrt()
}

/// `GeometryShaderAdjacencyTests::createGrid` and what it calls
fn create_grid(mode: Mode) -> Grid {
    let mut grid = Grid::default();

    let n_points = (GRID_GRANULARITY + 1) * (GRID_GRANULARITY + 1);
    let dx = 1.0f32 / GRID_GRANULARITY as f32;
    let dy = 1.0f32 / GRID_GRANULARITY as f32;
    for n_point in 0..n_points {
        let x = n_point % (GRID_GRANULARITY + 1);
        let y = n_point / (GRID_GRANULARITY + 1);
        grid.points.push(GridPoint {
            index: n_point as u32,
            x: dx * x as f32,
            y: dy * y as f32,
        });
    }

    match mode {
        Mode::Lines => create_grid_line_segments(&mut grid),
        Mode::LineStrip => {
            create_grid_line_segments(&mut grid);
            create_grid_line_strip(&mut grid);
        }
        Mode::Triangles => create_grid_triangles(&mut grid),
        Mode::TriangleStrip => {
            create_grid_triangles(&mut grid);
            create_grid_triangle_strip(&mut grid);
        }
    }
    grid
}

/// `GeometryShaderAdjacencyTests::createGridLineSegments`
fn create_grid_line_segments(grid: &mut Grid) {
    for n_point in 0..GRID_GRANULARITY * GRID_GRANULARITY {
        let point_tl = n_point;
        let point_tr = n_point + 1;
        let point_bl = GRID_GRANULARITY + 1;
        let point_br = GRID_GRANULARITY + 2;

        let candidate_segments = [
            (point_tl, point_tr),
            (point_tr, point_br),
            (point_br, point_bl),
            (point_bl, point_tl),
        ];
        for &(candidate_start, candidate_end) in candidate_segments.iter().take(N_LINE_SEGMENTS) {
            let already_added = grid.line_segments.iter().any(|segment| {
                (segment.end == candidate_end || segment.end == candidate_start)
                    && (segment.start == candidate_end || segment.start == candidate_start)
            });
            if !already_added {
                grid.line_segments.push(LineSegment {
                    end: candidate_end,
                    start: candidate_start,
                    ..LineSegment::default()
                });
            }
        }
    }

    for n_segment in 0..grid.line_segments.len() {
        let mut end_to_adjacent_point_delta = 2.0f32 * GRID_GRANULARITY as f32;
        let mut start_to_adjacent_point_delta = 2.0f32 * GRID_GRANULARITY as f32;
        let segment = grid.line_segments[n_segment];

        for n_point in 0..grid.points.len() {
            if n_point != segment.end && n_point != segment.start {
                let delta_start = distance(&grid.points[segment.start], &grid.points[n_point]);
                let delta_end = distance(&grid.points[segment.end], &grid.points[n_point]);

                if delta_start < start_to_adjacent_point_delta {
                    grid.line_segments[n_segment].start_adjacent = n_point;
                    start_to_adjacent_point_delta = delta_start;
                }
                if delta_end < end_to_adjacent_point_delta {
                    grid.line_segments[n_segment].end_adjacent = n_point;
                    end_to_adjacent_point_delta = delta_end;
                }
            }
        }
    }
}

/// `GeometryShaderAdjacencyTests::createGridLineStrip`
fn create_grid_line_strip(grid: &mut Grid) {
    let n_points = grid.points.len() + 2;
    let n_segments = grid.line_segments.len();
    let mut strip = vec![GridPoint::default(); n_points];

    for (n, point) in strip.iter_mut().enumerate() {
        point.index = n as u32;
        let source = if n == 0 {
            &grid.points[grid.line_segments[0].start_adjacent]
        } else if n == n_points - 1 {
            &grid.points[grid.line_segments[n_segments - 1].end_adjacent]
        } else {
            &grid.points[grid.line_segments[n - 1].start]
        };
        point.x = source.x;
        point.y = source.y;
    }
    grid.line_strip = strip;
}

/// `GeometryShaderAdjacencyTests::createGridTriangles`
#[allow(clippy::modulo_one)]
fn create_grid_triangles(grid: &mut Grid) {
    const TRIANGLES_PER_QUAD: usize = 2;
    let n_triangles = GRID_GRANULARITY * GRID_GRANULARITY * TRIANGLES_PER_QUAD;
    grid.triangles = vec![GridTriangle::default(); n_triangles];

    for n_quad in 0..n_triangles / TRIANGLES_PER_QUAD {
        let quad_tl_x = n_quad % GRID_GRANULARITY;
        let quad_tl_y = n_quad / GRID_GRANULARITY;

        let point_tl = quad_tl_y * (GRID_GRANULARITY + 1) + quad_tl_x;
        let point_tr = quad_tl_y * (GRID_GRANULARITY + 1) + quad_tl_x + 1;
        let point_bl = (quad_tl_y + 1) * (GRID_GRANULARITY + 1) + quad_tl_x;
        let point_br = (quad_tl_y + 1) * (GRID_GRANULARITY + 1) + quad_tl_x + 1;

        grid.triangles[n_quad * TRIANGLES_PER_QUAD] = GridTriangle {
            vertex_x: point_tl,
            vertex_x_adjacent: point_tr,
            vertex_y: point_br,
            vertex_y_adjacent: point_bl,
            vertex_z: point_bl,
            vertex_z_adjacent: point_br,
        };
        grid.triangles[n_quad * TRIANGLES_PER_QUAD + 1] = GridTriangle {
            vertex_x: point_tl,
            vertex_x_adjacent: point_tr,
            vertex_y: point_tr,
            vertex_y_adjacent: point_tl,
            vertex_z: point_br,
            vertex_z_adjacent: point_bl,
        };
    }
}

/// `GeometryShaderAdjacencyTests::createGridTriangleStrip`
fn create_grid_triangle_strip(grid: &mut Grid) {
    const VERTICES_PER_TRIANGLE_STRIP_PRIMITIVE: usize = 6;
    let n_points = grid.triangles.len() * VERTICES_PER_TRIANGLE_STRIP_PRIMITIVE;
    let mut strip = vec![GridPoint::default(); n_points];

    for (n, point) in strip.iter_mut().enumerate() {
        let triangle = grid.triangles[n / VERTICES_PER_TRIANGLE_STRIP_PRIMITIVE];
        point.index = n as u32;
        let source = match n % VERTICES_PER_TRIANGLE_STRIP_PRIMITIVE {
            0 => triangle.vertex_x,
            1 => triangle.vertex_x_adjacent,
            2 => triangle.vertex_y,
            3 => triangle.vertex_y_adjacent,
            4 => triangle.vertex_z,
            _ => triangle.vertex_z_adjacent,
        };
        point.x = grid.points[source].x;
        point.y = grid.points[source].y;
    }
    grid.triangle_strip = strip;
}

/// `setLinePointsNonindiced`
fn set_line_points_nonindiced(grid: &Grid, test_data: &mut TestData) {
    test_data.n_vertices = grid.line_segments.len() * 2;
    test_data.geometry_bo_size = test_data.n_vertices * N_COMPONENTS_OUTPUT * FLOAT_SIZE;
    test_data.vertex_data_bo_size = test_data.n_vertices * N_COMPONENTS_INPUT * 2 * FLOAT_SIZE;

    for segment in &grid.line_segments {
        push_xy(&mut test_data.vertex_data, &grid.points[segment.start_adjacent]);
        push_xy(&mut test_data.vertex_data, &grid.points[segment.start]);
        push_xy(&mut test_data.vertex_data, &grid.points[segment.end]);
        push_xy(&mut test_data.vertex_data, &grid.points[segment.end_adjacent]);

        push_point(
            &mut test_data.expected_adjacency_geometry,
            &grid.points[segment.start_adjacent],
        );
        push_point(
            &mut test_data.expected_adjacency_geometry,
            &grid.points[segment.end_adjacent],
        );
        push_point(&mut test_data.expected_geometry, &grid.points[segment.start]);
        push_point(&mut test_data.expected_geometry, &grid.points[segment.end]);
    }
}

/// `setLinePointsindiced`
fn set_line_points_indiced(grid: &Grid, test_data: &mut TestData) {
    test_data.n_vertices = grid.line_segments.len() * 2;
    test_data.geometry_bo_size = test_data.n_vertices * N_COMPONENTS_OUTPUT * FLOAT_SIZE;
    test_data.vertex_data_bo_size = grid.points.len() * N_COMPONENTS_INPUT * FLOAT_SIZE;
    test_data.index_data_bo_size = test_data.n_vertices * 2 * UINT_SIZE;

    for point in &grid.points {
        push_xy(&mut test_data.vertex_data, point);
    }
    for segment in &grid.line_segments {
        test_data.index_data.push(grid.points[segment.end_adjacent].index);
        test_data.index_data.push(grid.points[segment.end].index);
        test_data.index_data.push(grid.points[segment.start].index);
        test_data.index_data.push(grid.points[segment.start_adjacent].index);

        push_point(
            &mut test_data.expected_adjacency_geometry,
            &grid.points[segment.end_adjacent],
        );
        push_point(
            &mut test_data.expected_adjacency_geometry,
            &grid.points[segment.start_adjacent],
        );
        push_point(&mut test_data.expected_geometry, &grid.points[segment.end]);
        push_point(&mut test_data.expected_geometry, &grid.points[segment.start]);
    }
}

/// `setLineStripPointsNonindiced`
fn set_line_strip_points_nonindiced(grid: &Grid, test_data: &mut TestData) {
    test_data.n_vertices = grid.line_strip.len();
    test_data.geometry_bo_size = (test_data.n_vertices - 3) * N_COMPONENTS_OUTPUT * 2 * FLOAT_SIZE;
    test_data.vertex_data_bo_size = test_data.n_vertices * N_COMPONENTS_INPUT * FLOAT_SIZE;

    for point in &grid.line_strip {
        push_xy(&mut test_data.vertex_data, point);
    }
    for n in 0..test_data.n_vertices - 3 {
        push_point(&mut test_data.expected_adjacency_geometry, &grid.line_strip[n]);
        push_point(&mut test_data.expected_adjacency_geometry, &grid.line_strip[n + 3]);
        push_point(&mut test_data.expected_geometry, &grid.line_strip[n + 1]);
        push_point(&mut test_data.expected_geometry, &grid.line_strip[n + 2]);
    }
}

/// `setLineStripPointsIndiced`
fn set_line_strip_points_indiced(grid: &Grid, test_data: &mut TestData) {
    test_data.n_vertices = grid.line_strip.len();
    test_data.geometry_bo_size = (test_data.n_vertices - 3) * N_COMPONENTS_OUTPUT * 2 * FLOAT_SIZE;
    test_data.vertex_data_bo_size = test_data.n_vertices * N_COMPONENTS_INPUT * FLOAT_SIZE;
    test_data.index_data_bo_size = test_data.n_vertices * UINT_SIZE;

    for point in &grid.line_strip {
        push_xy(&mut test_data.vertex_data, point);
    }
    for n in 0..test_data.n_vertices {
        test_data.index_data.push((test_data.n_vertices - n - 1) as u32);
    }
    for n in 0..test_data.n_vertices - 3 {
        let point_at = |offset: usize| &grid.line_strip[test_data.index_data[n + offset] as usize];
        let (point_n0, point_n1, point_n2, point_n3) = (point_at(0), point_at(1), point_at(2), point_at(3));

        push_point(&mut test_data.expected_adjacency_geometry, point_n0);
        push_point(&mut test_data.expected_adjacency_geometry, point_n3);
        push_point(&mut test_data.expected_geometry, point_n1);
        push_point(&mut test_data.expected_geometry, point_n2);
    }
}

/// `setTrianglePointsNonindiced`
fn set_triangle_points_nonindiced(grid: &Grid, test_data: &mut TestData) {
    test_data.n_vertices = grid.triangles.len() * N_VERTICES_PER_TRIANGLE;
    test_data.geometry_bo_size = grid.triangles.len() * N_VERTICES_PER_TRIANGLE * N_COMPONENTS_OUTPUT * FLOAT_SIZE;
    test_data.vertex_data_bo_size = test_data.n_vertices * N_COMPONENTS_INPUT * FLOAT_SIZE * 2;

    for triangle in &grid.triangles {
        for vertex in [
            triangle.vertex_x,
            triangle.vertex_x_adjacent,
            triangle.vertex_y,
            triangle.vertex_y_adjacent,
            triangle.vertex_z,
            triangle.vertex_z_adjacent,
        ] {
            push_xy(&mut test_data.vertex_data, &grid.points[vertex]);
        }

        for vertex in [
            triangle.vertex_x_adjacent,
            triangle.vertex_y_adjacent,
            triangle.vertex_z_adjacent,
        ] {
            push_point(&mut test_data.expected_adjacency_geometry, &grid.points[vertex]);
        }
        for vertex in [triangle.vertex_x, triangle.vertex_y, triangle.vertex_z] {
            push_point(&mut test_data.expected_geometry, &grid.points[vertex]);
        }
    }
}

/// `setTrianglePointsIndiced`
fn set_triangle_points_indiced(grid: &Grid, test_data: &mut TestData) {
    test_data.n_vertices = grid.triangles.len() * N_VERTICES_PER_TRIANGLE;
    test_data.geometry_bo_size = grid.triangles.len() * N_VERTICES_PER_TRIANGLE * N_COMPONENTS_OUTPUT * FLOAT_SIZE;
    test_data.vertex_data_bo_size = grid.points.len() * N_COMPONENTS_INPUT * FLOAT_SIZE;
    test_data.index_data_bo_size = test_data.n_vertices * UINT_SIZE * 2;

    for point in &grid.points {
        push_xy(&mut test_data.vertex_data, point);
    }
    for n in 0..grid.triangles.len() {
        let triangle = grid.triangles[(n + 1) % 2];

        for vertex in [
            triangle.vertex_x,
            triangle.vertex_x_adjacent,
            triangle.vertex_y,
            triangle.vertex_y_adjacent,
            triangle.vertex_z,
            triangle.vertex_z_adjacent,
        ] {
            test_data.index_data.push(grid.points[vertex].index);
        }

        for vertex in [
            triangle.vertex_x_adjacent,
            triangle.vertex_y_adjacent,
            triangle.vertex_z_adjacent,
        ] {
            push_point(&mut test_data.expected_adjacency_geometry, &grid.points[vertex]);
        }
        for vertex in [triangle.vertex_x, triangle.vertex_y, triangle.vertex_z] {
            push_point(&mut test_data.expected_geometry, &grid.points[vertex]);
        }
    }
}

/// The vertex indices of triangle `n` of a triangle strip with adjacency, derived from table 2.X1 of the spec (1 based there).
fn triangle_strip_indices(n: i32, n_triangles: i32, alternate: bool) -> ([i32; 3], [i32; 3]) {
    let (adj_vertex_index, vertex_index) = if n == 0 {
        ([2, 7, 4], [1, 3, 5])
    } else if n == n_triangles - 1 {
        if n % 2 == 0 {
            ([2 * n - 1, 2 * n + 6, 2 * n + 4], [2 * n + 1, 2 * n + 3, 2 * n + 5])
        } else if !alternate {
            ([2 * n - 1, 2 * n + 4, 2 * n + 6], [2 * n + 3, 2 * n + 1, 2 * n + 5])
        } else {
            ([2 * n + 4, 2 * n + 6, 2 * n - 1], [2 * n + 1, 2 * n + 5, 2 * n + 3])
        }
    } else if n % 2 == 0 {
        ([2 * n - 1, 2 * n + 7, 2 * n + 4], [2 * n + 1, 2 * n + 3, 2 * n + 5])
    } else if !alternate {
        ([2 * n - 1, 2 * n + 4, 2 * n + 7], [2 * n + 3, 2 * n + 1, 2 * n + 5])
    } else {
        ([2 * n + 4, 2 * n + 7, 2 * n - 1], [2 * n + 1, 2 * n + 5, 2 * n + 3])
    };
    (
        adj_vertex_index.map(|index| index - 1),
        vertex_index.map(|index| index - 1),
    )
}

/// `setTriangleStripPointsNonindiced` and `setTriangleStripPointsIndiced` (`indiced`)
fn set_triangle_strip_points(grid: &Grid, test_data: &mut TestData, indiced: bool) {
    let n_triangles = (grid.triangle_strip.len() - 4) / 2;

    test_data.n_vertices = grid.triangle_strip.len();
    test_data.geometry_bo_size = n_triangles * N_COMPONENTS_OUTPUT * 3 * FLOAT_SIZE;
    test_data.vertex_data_bo_size = test_data.n_vertices * N_COMPONENTS_INPUT * FLOAT_SIZE;

    if indiced {
        test_data.index_data_bo_size = test_data.n_vertices * UINT_SIZE;
        for n in 0..test_data.n_vertices {
            test_data.index_data.push((test_data.n_vertices - 1 - n) as u32);
        }
    }
    for point in &grid.triangle_strip {
        push_xy(&mut test_data.vertex_data, point);
    }

    for alternate in [false, true] {
        let mut expected_adjacency_geometry = Vec::new();
        let mut expected_geometry = Vec::new();

        for n in 0..n_triangles {
            let (adj_vertex_index, vertex_index) = triangle_strip_indices(n as i32, n_triangles as i32, alternate);
            let point_at = |index: i32| {
                let index = index as usize;
                if indiced {
                    &grid.triangle_strip[test_data.index_data[index] as usize]
                } else {
                    &grid.triangle_strip[index]
                }
            };

            for index in adj_vertex_index {
                push_point(&mut expected_adjacency_geometry, point_at(index));
            }
            for index in vertex_index {
                push_point(&mut expected_geometry, point_at(index));
            }
        }

        if alternate {
            test_data.alternate_expected_adjacency_geometry = expected_adjacency_geometry;
            test_data.alternate_expected_geometry = expected_geometry;
        } else {
            test_data.expected_adjacency_geometry = expected_adjacency_geometry;
            test_data.expected_geometry = expected_geometry;
        }
    }
}

/// `GeometryShaderAdjacencyTests::configureTestData*`
fn configure_test_data(mode: Mode, indiced: bool) -> TestData {
    let (gs_code, gl_mode, tf_mode) = match mode {
        Mode::Lines => (GS_CODE_LINES, glw::GL_LINES_ADJACENCY, glw::GL_LINES),
        Mode::LineStrip => (GS_CODE_LINE_STRIP, glw::GL_LINE_STRIP_ADJACENCY, glw::GL_LINES),
        Mode::Triangles => (GS_CODE_TRIANGLES, glw::GL_TRIANGLES_ADJACENCY, glw::GL_TRIANGLES),
        Mode::TriangleStrip => (GS_CODE_TRIANGLES, glw::GL_TRIANGLE_STRIP_ADJACENCY, glw::GL_TRIANGLES),
    };
    let mut test_data = TestData {
        gs_code,
        mode: gl_mode,
        tf_mode,
        ..TestData::default()
    };

    let grid = create_grid(mode);
    match (mode, indiced) {
        (Mode::Lines, false) => set_line_points_nonindiced(&grid, &mut test_data),
        (Mode::Lines, true) => set_line_points_indiced(&grid, &mut test_data),
        (Mode::LineStrip, false) => set_line_strip_points_nonindiced(&grid, &mut test_data),
        (Mode::LineStrip, true) => set_line_strip_points_indiced(&grid, &mut test_data),
        (Mode::Triangles, false) => set_triangle_points_nonindiced(&grid, &mut test_data),
        (Mode::Triangles, true) => set_triangle_points_indiced(&grid, &mut test_data),
        (Mode::TriangleStrip, indiced) => set_triangle_strip_points(&grid, &mut test_data, indiced),
    }
    test_data
}

fn format_floats(values: &[f32]) -> String {
    let mut text = String::from("[");
    for value in values {
        text.push_str(&format!("{value}, "));
    }
    text.push(']');
    text
}

/// What the two comparison passes of `iterate` track: whether the data matches the expected and the alternate data.
struct Matches {
    expected: bool,
    alternate: bool,
}

impl Adjacency {
    /// `GeometryShaderAdjacency::initTest`
    fn init_test(
        &self,
        context: &Context,
        base: &TestCaseBase,
        test_data: &TestData,
        resources: &mut Resources,
    ) -> Result<(), TestError> {
        let gl = context.gl();

        if !base.is_geometry_shader_extension_supported {
            return Err(TestError::NotSupported(
                "Geometry shader functionality not supported, skipping".to_string(),
            ));
        }

        gl!(gl.gen_vertex_arrays(1, &mut resources.vao_id));
        glu::expect_no_error(gl, "Could not generate vertex array object")?;

        resources.fs_id = gl!(gl.create_shader(glw::GL_FRAGMENT_SHADER));
        resources.vs_id = gl!(gl.create_shader(glw::GL_VERTEX_SHADER));
        resources.gs_id = gl!(gl.create_shader(base.gl_ext_tokens.geometry_shader));
        resources.po_id = gl!(gl.create_program());
        glu::expect_no_error(gl, "Error creating program/shader objects.")?;

        let varyings = [
            CString::new("out_adjacent_geometry").expect("no nul byte"),
            CString::new("out_geometry").expect("no nul byte"),
        ];
        let varying_ptrs = [varyings[0].as_ptr(), varyings[1].as_ptr()];
        gl!(gl.transform_feedback_varyings(resources.po_id, 2, varying_ptrs.as_ptr(), glw::GL_SEPARATE_ATTRIBS));
        glu::expect_no_error(gl, "Error configuring vertex array object!")?;

        let (built, _) = base.build_program(
            context,
            resources.po_id,
            &[
                ShaderBody::Source(resources.fs_id, &[FS_CODE]),
                ShaderBody::Source(resources.gs_id, &[test_data.gs_code]),
                ShaderBody::Source(resources.vs_id, &[VS_CODE]),
            ],
        )?;
        if !built {
            return Err(TestError::Fail(
                "Could not create a program object from a valid shader!".to_string(),
            ));
        }

        gl!(gl.gen_buffers(1, &mut resources.vertex_data_bo_id));
        gl!(gl.gen_buffers(1, &mut resources.adjacency_geometry_bo_id));
        gl!(gl.gen_buffers(1, &mut resources.geometry_bo_id));

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.adjacency_geometry_bo_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (test_data.geometry_bo_size * 4) as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.geometry_bo_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            (test_data.geometry_bo_size * 4) as isize,
            std::ptr::null(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.vertex_data_bo_id));
        gl!(gl.buffer_data(
            glw::GL_ARRAY_BUFFER,
            test_data.vertex_data_bo_size as isize,
            test_data.vertex_data.as_ptr().cast(),
            glw::GL_DYNAMIC_DRAW
        ));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));
        glu::expect_no_error(gl, "Error configuring vertex buffer objects for vertex data!")?;

        if test_data.index_data_bo_size > 0 {
            gl!(gl.gen_buffers(1, &mut resources.index_data_bo_id));
            gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, resources.index_data_bo_id));
            gl!(gl.buffer_data(
                glw::GL_ELEMENT_ARRAY_BUFFER,
                test_data.index_data_bo_size as isize,
                test_data.index_data.as_ptr().cast(),
                glw::GL_DYNAMIC_DRAW
            ));
            gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, 0));
            glu::expect_no_error(gl, "Error configuring vertex buffer objects for index data!")?;
        }
        Ok(())
    }

    /// Maps the first `geometry_bo_size` bytes of the buffer bound to the transform feedback target as floats.
    fn read_transform_feedback_buffer(gl: &glw::Functions, size: usize) -> Result<Vec<f32>, TestError> {
        let mapped = gl!(gl.map_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            size as isize,
            glw::GL_MAP_READ_BIT
        ))
        .cast::<u8>();
        glu::expect_no_error(gl, "Error when mapping data to client space")?;
        if mapped.is_null() {
            return Err(TestError::Fail("glMapBufferRange() returned NULL.".to_string()));
        }
        // SAFETY: `size` bytes were mapped for reading and the mapping lives until the unmap below.
        let bytes = unsafe { std::slice::from_raw_parts(mapped, size) };
        let values = bytes
            .chunks_exact(FLOAT_SIZE)
            .map(|chunk| f32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]))
            .collect();
        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        Ok(values)
    }

    fn compare(result: &[f32], expected: &[f32], alternate: Option<&[f32]>) -> Matches {
        let mismatch = |reference: &[f32]| result.iter().zip(reference).any(|(r, e)| (r - e).abs() >= EPSILON);
        Matches {
            expected: !mismatch(expected),
            alternate: alternate.is_some_and(|alternate| !mismatch(alternate)),
        }
    }

    fn log_mismatch(label: &str, result: &[f32], expected: &[f32], alternate: Option<&[f32]>) {
        let first_difference = |reference: &[f32]| {
            result
                .iter()
                .zip(reference)
                .position(|(r, e)| (r - e).abs() >= EPSILON)
                .unwrap_or(0)
        };

        let index = first_difference(expected);
        log::info!(
            "At [{index}] position {label} buffer position Reference value is different than the rendered data (epsilon {EPSILON} ) ({}) vs ({})",
            expected[index],
            result[index]
        );
        if let Some(alternate) = alternate {
            let index = first_difference(alternate);
            log::info!(
                "At [{index}] alternate position {label} buffer position Reference value is different than the rendered data (epsilon {EPSILON} ) ({}) vs ({})",
                alternate[index],
                result[index]
            );
        }
    }

    /// `GeometryShaderAdjacency::iterate`
    fn run(
        &self,
        context: &Context,
        base: &TestCaseBase,
        test_data: &TestData,
        resources: &mut Resources,
    ) -> TestOutcome {
        let gl = context.gl();
        self.init_test(context, base, test_data, resources)?;

        gl!(gl.bind_vertex_array(resources.vao_id));
        glu::expect_no_error(gl, "Error binding vertex array object!")?;

        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, resources.adjacency_geometry_bo_id));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, resources.geometry_bo_id));
        glu::expect_no_error(gl, "Error configuring transform feedback buffer binding points!")?;

        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, resources.vertex_data_bo_id));
        let position_attribute_location = gl!(gl.get_attrib_location(resources.po_id, c"position_data".as_ptr()));
        gl!(gl.vertex_attrib_pointer(
            position_attribute_location as GLuint,
            N_COMPONENTS_INPUT as i32,
            glw::GL_FLOAT,
            glw::FALSE,
            0,
            std::ptr::null()
        ));
        gl!(gl.enable_vertex_attrib_array(position_attribute_location as GLuint));
        glu::expect_no_error(gl, "Error setting vertex attribute array for position_data attribute")?;

        if test_data.index_data_bo_size > 0 {
            gl!(gl.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, resources.index_data_bo_id));
        }
        glu::expect_no_error(gl, "Error binding index data buffer")?;

        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.use_program(resources.po_id));
        gl!(gl.begin_transform_feedback(test_data.tf_mode));

        let strip_mode =
            test_data.mode == glw::GL_LINE_STRIP_ADJACENCY || test_data.mode == glw::GL_TRIANGLE_STRIP_ADJACENCY;
        let n_vertices = (test_data.n_vertices * if strip_mode { 1 } else { 2 }) as i32;

        if test_data.index_data_bo_size > 0 {
            gl!(gl.draw_elements(test_data.mode, n_vertices, glw::GL_UNSIGNED_INT, std::ptr::null()));
        } else {
            gl!(gl.draw_arrays(test_data.mode, 0, n_vertices));
        }
        glu::expect_no_error(gl, "Error while trying to render")?;

        gl!(gl.disable(glw::GL_RASTERIZER_DISCARD));
        gl!(gl.end_transform_feedback());

        let has_alternate_data = !test_data.alternate_expected_geometry.is_empty()
            && !test_data.alternate_expected_adjacency_geometry.is_empty();
        let alternate_adjacency =
            has_alternate_data.then_some(test_data.alternate_expected_adjacency_geometry.as_slice());
        let alternate_geometry = has_alternate_data.then_some(test_data.alternate_expected_geometry.as_slice());

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.adjacency_geometry_bo_id));
        let result_adjacency_geometry = Self::read_transform_feedback_buffer(gl, test_data.geometry_bo_size)?;

        let adjacent = Self::compare(
            &result_adjacency_geometry,
            &test_data.expected_adjacency_geometry,
            alternate_adjacency,
        );
        if !adjacent.expected && !adjacent.alternate {
            Self::log_mismatch(
                "adjacency",
                &result_adjacency_geometry,
                &test_data.expected_adjacency_geometry,
                alternate_adjacency,
            );
            return Ok(TestStatus::fail("Fail"));
        }
        log::info!(
            "Adjacency Expected: {}",
            format_floats(&test_data.expected_adjacency_geometry)
        );
        if let Some(alternate) = alternate_adjacency {
            log::info!("Alternate adjacency Expected: {}", format_floats(alternate));
        }
        log::info!("Adjacency Result:  {}", format_floats(&result_adjacency_geometry));

        gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, resources.geometry_bo_id));
        let result_geometry = Self::read_transform_feedback_buffer(gl, test_data.geometry_bo_size)?;

        let geometry = Self::compare(&result_geometry, &test_data.expected_geometry, alternate_geometry);
        if !geometry.expected && !geometry.alternate {
            Self::log_mismatch(
                "geometry",
                &result_geometry,
                &test_data.expected_geometry,
                alternate_geometry,
            );
            return Ok(TestStatus::fail("Fail"));
        }

        if geometry.expected && !adjacent.expected {
            log::info!("Geometry matches OpenGL ordering but adjacent geometry matches Vulkan ordering");
            return Ok(TestStatus::fail("Fail"));
        }
        if geometry.alternate && !adjacent.alternate {
            log::info!("Geometry matches Vulkan ordering but adjacent geometry matches OpenGL ordering");
            return Ok(TestStatus::fail("Fail"));
        }

        let mut expected_text = format_floats(&test_data.expected_geometry);
        if let Some(alternate) = alternate_geometry {
            expected_text.push_str("\nor\n");
            expected_text.push_str(&format_floats(alternate));
        }
        log::info!("Expected: {expected_text}");
        log::info!("Result:  {}", format_floats(&result_geometry));

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for Adjacency {
    fn name(&self) -> &str {
        self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let base = TestCaseBase::init(context, self.ext_params);
        let test_data = configure_test_data(self.mode, self.indiced);
        let mut resources = Resources::default();
        let outcome = self.run(context, &base, &test_data, &mut resources);

        gl!(gl.use_program(0));
        gl!(gl.bind_vertex_array(0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0, 0));
        gl!(gl.bind_buffer_base(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 1, 0));
        gl!(gl.bind_buffer(glw::GL_ARRAY_BUFFER, 0));

        if resources.po_id != 0 {
            gl!(gl.delete_program(resources.po_id));
        }
        for shader in [resources.fs_id, resources.gs_id, resources.vs_id] {
            if shader != 0 {
                gl!(gl.delete_shader(shader));
            }
        }
        for buffer in [
            resources.adjacency_geometry_bo_id,
            resources.geometry_bo_id,
            resources.index_data_bo_id,
            resources.vertex_data_bo_id,
        ] {
            if buffer != 0 {
                gl!(gl.delete_buffers(1, &buffer));
            }
        }
        if resources.vao_id != 0 {
            gl!(gl.delete_vertex_arrays(1, &resources.vao_id));
        }
        outcome
    }
}
