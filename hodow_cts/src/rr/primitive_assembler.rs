// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrPrimitiveAssembler.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `pa::` assemblers write
// through a caller-supplied output iterator and read from a `VertexPacket* const*`
// array (one pointer per vertex, in primitive order - built by the caller from the
// draw call's own index list). The Rust port appends to a caller-supplied `Vec`
// instead, and reads from `&[usize]` - an index into a `Vec<VertexPacket>` arena the
// renderer owns for the whole draw call, in place of a raw pointer. `getPrimitiveCount`
// stays a free function so `Renderer` can size that `Vec` up front exactly like
// upstream reserves its own output array.
//
// Indices, not borrows: `rr::Renderer`'s own clipping pass (`clip_primitives` in
// `rr::renderer`) needs to *mutate* a vertex a primitive points at - upstream's
// `makeSharedVerticeDistinct` gives a primitive its own private copy of a vertex it
// shares with a neighbour (two triangles of a strip touch the same `VertexPacket*`)
// before flatshading or clip-interpolation writes through it - and `&'a VertexPacket`
// borrows shared between several `Triangle`/`Line` values can never support that
// without fighting the borrow checker over aliased mutation the C++ performs through
// raw pointers. An index into an arena the caller holds `&mut` to, one primitive at a
// time, is the direct, hazard-free translation; `get_provoking_vertex`'s C++ shape
// (return the actual vertex) becomes `provoking_vertex_index`, since resolving *which*
// of `v0`/`v1`/`v2` is provoking never needed the arena in the first place.

use super::defs::ProvokingVertex;

/// `pa::Triangle`
#[derive(Clone, Copy)]
pub struct Triangle {
    pub v0: usize,
    pub v1: usize,
    pub v2: usize,
    pub provoking_index: i32,
}

impl Triangle {
    pub fn provoking_vertex_index(&self) -> usize {
        match self.provoking_index {
            0 => self.v0,
            1 => self.v1,
            2 => self.v2,
            _ => unreachable!("invalid provoking index"),
        }
    }
}

/// `pa::Triangles`
pub fn assemble_triangles(out: &mut Vec<Triangle>, vertices: &[usize], provoking: ProvokingVertex) {
    let provoking_offset = if provoking == ProvokingVertex::First { 0 } else { 2 };
    let mut ndx = 0;
    while ndx + 2 < vertices.len() {
        out.push(Triangle {
            v0: vertices[ndx],
            v1: vertices[ndx + 1],
            v2: vertices[ndx + 2],
            provoking_index: provoking_offset,
        });
        ndx += 3;
    }
}

pub fn triangles_primitive_count(num_vertices: usize) -> usize {
    num_vertices / 3
}

/// `pa::TriangleStrip`
pub fn assemble_triangle_strip(out: &mut Vec<Triangle>, vertices: &[usize], provoking: ProvokingVertex) {
    if vertices.len() < 3 {
        return;
    }

    let mut vert0 = vertices[0];
    let mut vert1 = vertices[1];
    let mut ndx = 2;

    loop {
        if ndx >= vertices.len() {
            break;
        }
        out.push(Triangle {
            v0: vert0,
            v1: vert1,
            v2: vertices[ndx],
            provoking_index: if provoking == ProvokingVertex::First { 0 } else { 2 },
        });
        vert0 = vertices[ndx];
        ndx += 1;

        if ndx >= vertices.len() {
            break;
        }
        out.push(Triangle {
            v0: vert0,
            v1: vert1,
            v2: vertices[ndx],
            provoking_index: if provoking == ProvokingVertex::First { 1 } else { 2 },
        });
        vert1 = vertices[ndx];
        ndx += 1;
    }
}

pub fn triangle_strip_primitive_count(num_vertices: usize) -> usize {
    if num_vertices < 3 { 0 } else { num_vertices - 2 }
}

/// `pa::TriangleFan`
pub fn assemble_triangle_fan(out: &mut Vec<Triangle>, vertices: &[usize], provoking: ProvokingVertex) {
    if vertices.is_empty() {
        return;
    }
    let provoking_offset = if provoking == ProvokingVertex::First { 1 } else { 2 };
    let first = vertices[0];
    let mut ndx = 1;
    while ndx + 1 < vertices.len() {
        out.push(Triangle {
            v0: first,
            v1: vertices[ndx],
            v2: vertices[ndx + 1],
            provoking_index: provoking_offset,
        });
        ndx += 1;
    }
}

pub fn triangle_fan_primitive_count(num_vertices: usize) -> usize {
    if num_vertices < 3 { 0 } else { num_vertices - 2 }
}

/// `pa::Line`
#[derive(Clone, Copy)]
pub struct Line {
    pub v0: usize,
    pub v1: usize,
    pub provoking_index: i32,
}

impl Line {
    pub fn provoking_vertex_index(&self) -> usize {
        match self.provoking_index {
            0 => self.v0,
            1 => self.v1,
            _ => unreachable!("invalid provoking index"),
        }
    }
}

/// `pa::Lines`
pub fn assemble_lines(out: &mut Vec<Line>, vertices: &[usize], provoking: ProvokingVertex) {
    let provoking_offset = if provoking == ProvokingVertex::First { 0 } else { 1 };
    let mut ndx = 0;
    while ndx + 1 < vertices.len() {
        out.push(Line {
            v0: vertices[ndx],
            v1: vertices[ndx + 1],
            provoking_index: provoking_offset,
        });
        ndx += 2;
    }
}

pub fn lines_primitive_count(num_vertices: usize) -> usize {
    num_vertices / 2
}

/// `pa::LineStrip`
pub fn assemble_line_strip(out: &mut Vec<Line>, vertices: &[usize], provoking: ProvokingVertex) {
    if vertices.is_empty() {
        return;
    }
    let provoking_offset = if provoking == ProvokingVertex::First { 0 } else { 1 };
    let mut prev = vertices[0];
    for &v in &vertices[1..] {
        out.push(Line {
            v0: prev,
            v1: v,
            provoking_index: provoking_offset,
        });
        prev = v;
    }
}

pub fn line_strip_primitive_count(num_vertices: usize) -> usize {
    if num_vertices < 2 { 0 } else { num_vertices - 1 }
}

/// `pa::LineLoop`
pub fn assemble_line_loop(out: &mut Vec<Line>, vertices: &[usize], provoking: ProvokingVertex) {
    if vertices.len() < 2 {
        return;
    }
    let provoking_offset = if provoking == ProvokingVertex::First { 0 } else { 1 };
    let mut prev = vertices[0];
    for &v in &vertices[1..] {
        out.push(Line {
            v0: prev,
            v1: v,
            provoking_index: provoking_offset,
        });
        prev = v;
    }
    out.push(Line {
        v0: prev,
        v1: vertices[0],
        provoking_index: provoking_offset,
    });
}

pub fn line_loop_primitive_count(num_vertices: usize) -> usize {
    if num_vertices < 2 { 0 } else { num_vertices }
}

/// `pa::Point`
#[derive(Clone, Copy)]
pub struct Point {
    pub v0: usize,
}

/// `pa::Points`
pub fn assemble_points(out: &mut Vec<Point>, vertices: &[usize], _provoking: ProvokingVertex) {
    for &v in vertices {
        out.push(Point { v0: v });
    }
}

pub fn points_primitive_count(num_vertices: usize) -> usize {
    num_vertices
}

/// `pa::LineAdjacency`
#[derive(Clone, Copy)]
pub struct LineAdjacency {
    pub v0: usize,
    pub v1: usize,
    pub v2: usize,
    pub v3: usize,
    pub provoking_index: i32,
}

impl LineAdjacency {
    pub fn provoking_vertex_index(&self) -> usize {
        match self.provoking_index {
            1 => self.v1,
            2 => self.v2,
            _ => unreachable!("invalid provoking index"),
        }
    }
}

/// `pa::LinesAdjacency`
pub fn assemble_lines_adjacency(out: &mut Vec<LineAdjacency>, vertices: &[usize], provoking: ProvokingVertex) {
    let provoking_offset = if provoking == ProvokingVertex::First { 1 } else { 2 };
    let mut ndx = 0;
    while ndx + 3 < vertices.len() {
        out.push(LineAdjacency {
            v0: vertices[ndx],
            v1: vertices[ndx + 1],
            v2: vertices[ndx + 2],
            v3: vertices[ndx + 3],
            provoking_index: provoking_offset,
        });
        ndx += 4;
    }
}

pub fn lines_adjacency_primitive_count(num_vertices: usize) -> usize {
    num_vertices / 4
}

/// `pa::LineStripAdjacency`
pub fn assemble_line_strip_adjacency(out: &mut Vec<LineAdjacency>, vertices: &[usize], provoking: ProvokingVertex) {
    let provoking_offset = if provoking == ProvokingVertex::First { 1 } else { 2 };
    let mut ndx = 0;
    while ndx + 3 < vertices.len() {
        out.push(LineAdjacency {
            v0: vertices[ndx],
            v1: vertices[ndx + 1],
            v2: vertices[ndx + 2],
            v3: vertices[ndx + 3],
            provoking_index: provoking_offset,
        });
        ndx += 1;
    }
}

pub fn line_strip_adjacency_primitive_count(num_vertices: usize) -> usize {
    if num_vertices < 4 { 0 } else { num_vertices - 3 }
}

/// `pa::TriangleAdjacency`
#[derive(Clone, Copy)]
pub struct TriangleAdjacency {
    pub v0: usize,
    pub v1: usize,
    pub v2: usize,
    pub v3: usize,
    pub v4: usize,
    pub v5: usize,
    pub provoking_index: i32,
}

impl TriangleAdjacency {
    pub fn provoking_vertex_index(&self) -> usize {
        match self.provoking_index {
            0 => self.v0,
            2 => self.v2,
            4 => self.v4,
            _ => unreachable!("invalid provoking index"),
        }
    }
}

/// `pa::TrianglesAdjacency`
pub fn assemble_triangles_adjacency(out: &mut Vec<TriangleAdjacency>, vertices: &[usize], provoking: ProvokingVertex) {
    let provoking_offset = if provoking == ProvokingVertex::First { 0 } else { 4 };
    let mut ndx = 0;
    while ndx + 5 < vertices.len() {
        out.push(TriangleAdjacency {
            v0: vertices[ndx],
            v1: vertices[ndx + 1],
            v2: vertices[ndx + 2],
            v3: vertices[ndx + 3],
            v4: vertices[ndx + 4],
            v5: vertices[ndx + 5],
            provoking_index: provoking_offset,
        });
        ndx += 6;
    }
}

pub fn triangles_adjacency_primitive_count(num_vertices: usize) -> usize {
    num_vertices / 6
}

/// `pa::TriangleStripAdjacency`
pub fn assemble_triangle_strip_adjacency(
    out: &mut Vec<TriangleAdjacency>,
    vertices: &[usize],
    provoking: ProvokingVertex,
) {
    let n = vertices.len();
    let provoking_first = provoking == ProvokingVertex::First;

    if n < 6 {
        return;
    } else if n < 8 {
        out.push(TriangleAdjacency {
            v0: vertices[0],
            v1: vertices[1],
            v2: vertices[2],
            v3: vertices[5],
            v4: vertices[4],
            v5: vertices[3],
            provoking_index: if provoking_first { 0 } else { 4 },
        });
        return;
    }

    let primitive_count = triangle_strip_adjacency_primitive_count(n);

    // first
    out.push(TriangleAdjacency {
        v0: vertices[0],
        v1: vertices[1],
        v2: vertices[2],
        v3: vertices[6],
        v4: vertices[4],
        v5: vertices[3],
        provoking_index: if provoking_first { 0 } else { 4 },
    });

    // middle
    let mut i = 1;
    while i + 1 < primitive_count {
        if i % 2 == 1 {
            out.push(TriangleAdjacency {
                v0: vertices[2 * i + 2],
                v1: vertices[2 * i - 2],
                v2: vertices[2 * i],
                v3: vertices[2 * i + 3],
                v4: vertices[2 * i + 4],
                v5: vertices[2 * i + 6],
                provoking_index: if provoking_first { 2 } else { 4 },
            });
        } else {
            out.push(TriangleAdjacency {
                v0: vertices[2 * i],
                v1: vertices[2 * i - 2],
                v2: vertices[2 * i + 2],
                v3: vertices[2 * i + 6],
                v4: vertices[2 * i + 4],
                v5: vertices[2 * i + 3],
                provoking_index: if provoking_first { 0 } else { 4 },
            });
        }
        i += 1;
    }

    // last
    if i % 2 == 1 {
        out.push(TriangleAdjacency {
            v0: vertices[2 * i + 2],
            v1: vertices[2 * i - 2],
            v2: vertices[2 * i],
            v3: vertices[2 * i + 3],
            v4: vertices[2 * i + 4],
            v5: vertices[2 * i + 5],
            provoking_index: if provoking_first { 2 } else { 4 },
        });
    } else {
        out.push(TriangleAdjacency {
            v0: vertices[2 * i],
            v1: vertices[2 * i - 2],
            v2: vertices[2 * i + 2],
            v3: vertices[2 * i + 5],
            v4: vertices[2 * i + 4],
            v5: vertices[2 * i + 3],
            provoking_index: if provoking_first { 0 } else { 4 },
        });
    }
}

pub fn triangle_strip_adjacency_primitive_count(num_vertices: usize) -> usize {
    if num_vertices < 6 { 0 } else { (num_vertices - 4) / 2 }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn identity_indices(n: usize) -> Vec<usize> {
        (0..n).collect()
    }

    #[test]
    fn triangles_groups_in_threes() {
        let verts = identity_indices(6);
        let mut out = Vec::new();
        assemble_triangles(&mut out, &verts, ProvokingVertex::First);
        assert_eq!(out.len(), 2);
        assert_eq!(triangles_primitive_count(6), 2);
        assert_eq!(out[1].v0, 3);
        assert_eq!(out[0].provoking_vertex_index(), 0);
    }

    #[test]
    fn triangle_strip_shares_edges() {
        let verts = identity_indices(5);
        let mut out = Vec::new();
        assemble_triangle_strip(&mut out, &verts, ProvokingVertex::First);
        assert_eq!(out.len(), 3);
        assert_eq!(triangle_strip_primitive_count(5), 3);
        // Upstream's alternating pattern for vertices 0..4: (0,1,2), (2,1,3), (2,3,4) -
        // every triangle shares an edge with the one before it, but which two vertices
        // of the running pair become v0/v1 of the next triangle alternates.
        assert_eq!((out[0].v0, out[0].v1, out[0].v2), (0, 1, 2));
        assert_eq!((out[1].v0, out[1].v1, out[1].v2), (2, 1, 3));
        assert_eq!((out[2].v0, out[2].v1, out[2].v2), (2, 3, 4));
    }

    #[test]
    fn triangle_fan_shares_first_vertex() {
        let verts = identity_indices(4);
        let mut out = Vec::new();
        assemble_triangle_fan(&mut out, &verts, ProvokingVertex::First);
        assert_eq!(out.len(), 2);
        for tri in &out {
            assert_eq!(tri.v0, 0);
        }
    }

    #[test]
    fn line_loop_closes_back_to_start() {
        let verts = identity_indices(3);
        let mut out = Vec::new();
        assemble_line_loop(&mut out, &verts, ProvokingVertex::First);
        assert_eq!(out.len(), 3);
        assert_eq!(line_loop_primitive_count(3), 3);
        assert_eq!(out[2].v0, 2);
        assert_eq!(out[2].v1, 0);
    }

    #[test]
    fn points_pass_through_one_to_one() {
        let verts = identity_indices(4);
        let mut out = Vec::new();
        assemble_points(&mut out, &verts, ProvokingVertex::First);
        assert_eq!(out.len(), 4);
        assert_eq!(points_primitive_count(4), 4);
    }

    #[test]
    fn triangle_strip_adjacency_minimal_case() {
        let verts = identity_indices(6);
        let mut out = Vec::new();
        assemble_triangle_strip_adjacency(&mut out, &verts, ProvokingVertex::First);
        assert_eq!(out.len(), 1);
        assert_eq!(
            (out[0].v0, out[0].v1, out[0].v2, out[0].v3, out[0].v4, out[0].v5),
            (0, 1, 2, 5, 4, 3)
        );
    }

    #[test]
    fn triangle_strip_adjacency_longer_matches_primitive_count() {
        let verts = identity_indices(10);
        let mut out = Vec::new();
        assemble_triangle_strip_adjacency(&mut out, &verts, ProvokingVertex::First);
        assert_eq!(out.len(), triangle_strip_adjacency_primitive_count(10));
    }
}
