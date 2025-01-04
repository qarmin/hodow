// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrRenderer.cpp (the anonymous `cliputil` namespace,
//   `clipPrimitives` for pa::Triangle/pa::Line/pa::Point, and `flatshadeVertices`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `ClipVolumePlane`/`ComponentPlane<Sign, CompNdx>` becomes one `ComponentPlane` struct
// holding its sign and component index as plain fields rather than const generic
// parameters - this is reference software, not a hot path that benefits from
// monomorphising six planes at compile time, and a runtime field reads identically to
// the six `ComponentPlane<+1,0>`/`<-1,0>`/... instantiations upstream constructs.
//
// `ClipVec4` (upstream: `tcu::Vector<double, 4>`) is a plain `[f64; 4]` with free
// functions rather than an extension of `tcu::vector::Vector` to `f64` - the generic
// arithmetic `impl`s there are `f32`-only by design (every other consumer is a `Vec4`),
// and the handful of operations clipping needs (`mix`, componentwise index, `.w()`) are
// cheaper to write directly than to thread a second scalar type through that macro.
//
// The container-type polymorphism upstream gets from `template <typename ContainerType>`
// (instantiated for `std::vector<pa::Triangle>`, `pa::Line`, `pa::Point`) is a `BasePrimitiveList`
// enum here, matched once per function - see `rr::renderer`'s own doc for why an enum
// reads better in Rust than a trait per primitive kind for this one pipeline.

use super::generic_vector::GenericVecType;
use super::primitive_assembler::{Line, Point, Triangle};
use super::shaders::{FragmentInputInfo, VertexVaryingInfo};
use super::vertex_packet::{VertexPacket, VertexPacketAllocator};
use crate::tcu::vector::Vec4;

/// `rr::(anonymous)::BasePrimitiveList` - not an upstream name; see this module's own
/// doc comment for why an enum, matched once per helper, replaces the
/// `template <typename ContainerType>` instantiations upstream relies on for
/// `std::vector<pa::Triangle>`/`pa::Line`/`pa::Point` specifically (adjacency types are
/// converted to one of these three before any of this runs - see
/// `rr::renderer::convert_primitive_to_base_type`).
pub enum BasePrimitiveList {
    Triangles(Vec<Triangle>),
    Lines(Vec<Line>),
    Points(Vec<Point>),
}

type ClipFloat = f64;
/// `rr::(anonymous)::ClipVec4` - see this module's top doc comment for why this is a
/// plain array rather than `tcu::Vector<f64, 4>`.
#[derive(Clone, Copy, Default, PartialEq, Debug)]
pub struct ClipVec4([ClipFloat; 4]);

impl ClipVec4 {
    pub fn new(x: ClipFloat, y: ClipFloat, z: ClipFloat, w: ClipFloat) -> Self {
        Self([x, y, z, w])
    }

    pub fn x(&self) -> ClipFloat {
        self.0[0]
    }
    pub fn y(&self) -> ClipFloat {
        self.0[1]
    }
    pub fn z(&self) -> ClipFloat {
        self.0[2]
    }
    pub fn w(&self) -> ClipFloat {
        self.0[3]
    }
}

impl std::ops::Index<usize> for ClipVec4 {
    type Output = ClipFloat;
    fn index(&self, i: usize) -> &ClipFloat {
        &self.0[i]
    }
}

/// `tcu::mix` over `ClipVec4`.
fn mix(a: ClipVec4, b: ClipVec4, t: ClipFloat) -> ClipVec4 {
    ClipVec4([
        a.0[0] + (b.0[0] - a.0[0]) * t,
        a.0[1] + (b.0[1] - a.0[1]) * t,
        a.0[2] + (b.0[2] - a.0[2]) * t,
        a.0[3] + (b.0[3] - a.0[3]) * t,
    ])
}

/// `vec4ToClipVec4`
fn vec4_to_clip_vec4(v: Vec4) -> ClipVec4 {
    ClipVec4::new(
        v.x() as ClipFloat,
        v.y() as ClipFloat,
        v.z() as ClipFloat,
        v.w() as ClipFloat,
    )
}

/// `clipVec4ToVec4`
fn clip_vec4_to_vec4(v: ClipVec4) -> Vec4 {
    Vec4::new(v.x() as f32, v.y() as f32, v.z() as f32, v.w() as f32)
}

/// `cliputil::getSegmentVolumeEdgeClip`
///
/// How much (in `[0,1]`) of the line segment v0-v1 is on the clipped side of `plane`.
fn get_segment_volume_edge_clip(
    v0: ClipFloat,
    w0: ClipFloat,
    v1: ClipFloat,
    w1: ClipFloat,
    plane: ClipFloat,
) -> ClipFloat {
    // The +epsilon avoids division by zero without causing a meaningful change in the
    // calculation.
    (plane * w0 - v0) / ((v1 - v0) - plane * (w1 - w0) + ClipFloat::EPSILON)
}

/// `cliputil::getLineEndpointClipping`
fn get_line_endpoint_clipping(v0: ClipVec4, v1: ClipVec4) -> ClipFloat {
    let clip_volume_size: ClipFloat = 1.0;
    if v0.z() > v0.w() {
        get_segment_volume_edge_clip(v0.z(), v0.w(), v1.z(), v1.w(), clip_volume_size)
    } else if v0.z() < -v0.w() {
        get_segment_volume_edge_clip(v0.z(), v0.w(), v1.z(), v1.w(), -clip_volume_size)
    } else {
        0.0
    }
}

/// `cliputil::ComponentPlane<Sign, CompNdx>` - see this module's top doc comment.
struct ComponentPlane {
    sign: ClipFloat,
    comp_ndx: usize,
}

impl ComponentPlane {
    const fn new(sign: ClipFloat, comp_ndx: usize) -> Self {
        Self { sign, comp_ndx }
    }

    /// `ComponentPlane::pointInClipVolume`
    fn point_in_clip_volume(&self, p: ClipVec4) -> bool {
        let clip_volume_size: ClipFloat = 1.0;
        self.sign * p[self.comp_ndx] <= clip_volume_size * p.w()
    }

    /// `ComponentPlane::clipLineSegmentEnd`
    fn clip_line_segment_end(&self, v0: ClipVec4, v1: ClipVec4) -> ClipFloat {
        let clip_volume_size: ClipFloat = 1.0;
        get_segment_volume_edge_clip(
            v0[self.comp_ndx],
            v0.w(),
            v1[self.comp_ndx],
            v1.w(),
            self.sign * clip_volume_size,
        )
    }

    /// `ComponentPlane::getLineIntersectionPoint`
    ///
    /// A point on the line might be far away, causing the clipping ratio
    /// (`clip_line_segment_end`) to become extremely close to 1.0 even if the other
    /// point is not on the plane. Prevent the clipping ratio from saturating by using
    /// points on the line that are (nearly) on this and (nearly) on the opposite plane.
    fn get_line_intersection_point(&self, v0: ClipVec4, v1: ClipVec4) -> ClipVec4 {
        let plus = ComponentPlane::new(1.0, self.comp_ndx);
        let minus = ComponentPlane::new(-1.0, self.comp_ndx);

        let clipped_v0 = mix(v0, v1, plus.clip_line_segment_end(v0, v1));
        let clipped_v1 = mix(v0, v1, minus.clip_line_segment_end(v0, v1));
        let clip_ratio = self.clip_line_segment_end(clipped_v0, clipped_v1);

        if clip_ratio <= 0.5 {
            mix(clipped_v0, clipped_v1, clip_ratio)
        } else {
            let complement_clip_ratio = self.clip_line_segment_end(clipped_v1, clipped_v0);
            mix(clipped_v1, clipped_v0, complement_clip_ratio)
        }
    }
}

/// `cliputil::TriangleVertex`
#[derive(Clone, Copy)]
struct TriangleVertex {
    position: ClipVec4,
    /// Barycentrics.
    weight: [ClipFloat; 3],
}

/// `cliputil::SubTriangle`
#[derive(Clone, Copy)]
struct SubTriangle {
    vertices: [TriangleVertex; 3],
}

/// `cliputil::clipTriangleOneVertex`
fn clip_triangle_one_vertex(
    clipped_edges: &mut Vec<TriangleVertex>,
    plane: &ComponentPlane,
    clipped: TriangleVertex,
    v1: TriangleVertex,
    v2: TriangleVertex,
) {
    let degenerate_limit: ClipFloat = 1.0;
    let mut output_degenerate = false;

    let mid = |inside: TriangleVertex, outside: TriangleVertex| -> Option<TriangleVertex> {
        let hit_dist = plane.clip_line_segment_end(inside.position, outside.position);
        if hit_dist >= degenerate_limit {
            None
        } else {
            let approximated_clip_point = mix(inside.position, outside.position, hit_dist);
            let another_point_on_line = if hit_dist > 0.5 {
                inside.position
            } else {
                outside.position
            };
            Some(TriangleVertex {
                position: plane.get_line_intersection_point(approximated_clip_point, another_point_on_line),
                weight: [
                    inside.weight[0] + (outside.weight[0] - inside.weight[0]) * hit_dist,
                    inside.weight[1] + (outside.weight[1] - inside.weight[1]) * hit_dist,
                    inside.weight[2] + (outside.weight[2] - inside.weight[2]) * hit_dist,
                ],
            })
        }
    };

    let mid1 = mid(v1, clipped);
    if mid1.is_none() {
        output_degenerate = true;
    }
    let mid2 = mid(v2, clipped);
    if mid2.is_none() {
        output_degenerate = true;
    }

    if !output_degenerate {
        // gen quad (v1) -> mid1 -> mid2 -> (v2)
        clipped_edges.push(v1);
        clipped_edges.push(mid1.unwrap());
        clipped_edges.push(mid2.unwrap());
        clipped_edges.push(v2);
    } else {
        // don't modify
        clipped_edges.push(v1);
        clipped_edges.push(clipped);
        clipped_edges.push(v2);
    }
}

/// `cliputil::clipTriangleTwoVertices`
fn clip_triangle_two_vertices(
    clipped_edges: &mut Vec<TriangleVertex>,
    plane: &ComponentPlane,
    v0: TriangleVertex,
    clipped1: TriangleVertex,
    clipped2: TriangleVertex,
) {
    let unclippable_limit: ClipFloat = 1.0;

    let mid = |inside: TriangleVertex, outside: TriangleVertex| -> Option<TriangleVertex> {
        let hit_dist = plane.clip_line_segment_end(inside.position, outside.position);
        if hit_dist >= unclippable_limit {
            None
        } else {
            let approximated_clip_point = mix(inside.position, outside.position, hit_dist);
            let another_point_on_line = if hit_dist > 0.5 {
                inside.position
            } else {
                outside.position
            };
            Some(TriangleVertex {
                position: plane.get_line_intersection_point(approximated_clip_point, another_point_on_line),
                weight: [
                    inside.weight[0] + (outside.weight[0] - inside.weight[0]) * hit_dist,
                    inside.weight[1] + (outside.weight[1] - inside.weight[1]) * hit_dist,
                    inside.weight[2] + (outside.weight[2] - inside.weight[2]) * hit_dist,
                ],
            })
        }
    };

    let mid1 = mid(v0, clipped1);
    let mid2 = mid(v0, clipped2);

    match (mid1, mid2) {
        (Some(m1), Some(m2)) => {
            clipped_edges.push(v0);
            clipped_edges.push(m1);
            clipped_edges.push(m2);
        }
        (Some(m1), None) => {
            clipped_edges.push(v0);
            clipped_edges.push(m1);
            clipped_edges.push(clipped2);
        }
        (None, Some(m2)) => {
            clipped_edges.push(v0);
            clipped_edges.push(clipped1);
            clipped_edges.push(m2);
        }
        (None, None) => {
            clipped_edges.push(v0);
            clipped_edges.push(clipped1);
            clipped_edges.push(clipped2);
        }
    }
}

/// `cliputil::clipTriangleToPlane`
fn clip_triangle_to_plane(
    clipped_edges: &mut Vec<TriangleVertex>,
    vertices: &[TriangleVertex; 3],
    plane: &ComponentPlane,
) {
    let v_clipped = [
        !plane.point_in_clip_volume(vertices[0].position),
        !plane.point_in_clip_volume(vertices[1].position),
        !plane.point_in_clip_volume(vertices[2].position),
    ];
    let clip_count = v_clipped.iter().filter(|&&c| c).count();

    match clip_count {
        0 => clipped_edges.extend_from_slice(vertices),
        1 => {
            if v_clipped[0] {
                clip_triangle_one_vertex(clipped_edges, plane, vertices[0], vertices[1], vertices[2]);
            } else if v_clipped[1] {
                clip_triangle_one_vertex(clipped_edges, plane, vertices[1], vertices[2], vertices[0]);
            } else {
                clip_triangle_one_vertex(clipped_edges, plane, vertices[2], vertices[0], vertices[1]);
            }
        }
        2 => {
            if !v_clipped[0] {
                clip_triangle_two_vertices(clipped_edges, plane, vertices[0], vertices[1], vertices[2]);
            } else if !v_clipped[1] {
                clip_triangle_two_vertices(clipped_edges, plane, vertices[1], vertices[2], vertices[0]);
            } else {
                clip_triangle_two_vertices(clipped_edges, plane, vertices[2], vertices[0], vertices[1]);
            }
        }
        3 => {
            // discard
        }
        _ => unreachable!(),
    }
}

fn to_2d_cartesian(p: Vec4) -> (f32, f32) {
    (p.x() / p.w(), p.y() / p.w())
}

fn cross2d(a: (f32, f32), b: (f32, f32)) -> f32 {
    a.0 * b.1 - a.1 * b.0
}

/// `flatshadeVertices` - the set of varying infos is whichever stage feeds the
/// rasterizer: the geometry shader's outputs if there is one, the vertex shader's
/// otherwise. Geometry shading is not wired into `rr::Renderer` yet (see
/// `rr::renderer`'s doc), so the caller always passes the vertex shader's own outputs.
pub fn flatshade_vertices(outputs: &[VertexVaryingInfo], list: &mut BasePrimitiveList, arena: &mut [VertexPacket]) {
    for (input_ndx, info) in outputs.iter().enumerate() {
        if !info.flatshade {
            continue;
        }
        match list {
            BasePrimitiveList::Triangles(tris) => {
                for t in tris.iter() {
                    let flat_value = arena[t.provoking_vertex_index()].outputs[input_ndx];
                    arena[t.v0].outputs[input_ndx] = flat_value;
                    arena[t.v1].outputs[input_ndx] = flat_value;
                    arena[t.v2].outputs[input_ndx] = flat_value;
                }
            }
            BasePrimitiveList::Lines(lines) => {
                for l in lines.iter() {
                    let flat_value = arena[l.provoking_vertex_index()].outputs[input_ndx];
                    arena[l.v0].outputs[input_ndx] = flat_value;
                    arena[l.v1].outputs[input_ndx] = flat_value;
                }
            }
            BasePrimitiveList::Points(_) => {
                // `flatshadePrimitiveVertices(pa::Point&, size_t)` is a no-op upstream too:
                // a point has only one vertex, so there is nothing to flatten it onto.
            }
        }
    }
}

/// `clipPrimitives(std::vector<pa::Triangle>&, ...)`
fn clip_triangles(
    list: &mut Vec<Triangle>,
    frag_inputs: &[FragmentInputInfo],
    clip_with_z_planes: bool,
    arena: &mut Vec<VertexPacket>,
    vpalloc: &mut VertexPacketAllocator,
) {
    let clip_pos_x = ComponentPlane::new(1.0, 0);
    let clip_neg_x = ComponentPlane::new(-1.0, 0);
    let clip_pos_y = ComponentPlane::new(1.0, 1);
    let clip_neg_y = ComponentPlane::new(-1.0, 1);
    let clip_pos_z = ComponentPlane::new(1.0, 2);
    let clip_neg_z = ComponentPlane::new(-1.0, 2);
    let planes = [
        &clip_pos_x,
        &clip_neg_x,
        &clip_pos_y,
        &clip_neg_y,
        &clip_pos_z,
        &clip_neg_z,
    ];
    let num_planes = if clip_with_z_planes { 6 } else { 4 };

    let mut output_triangles = Vec::new();

    for tri in list.iter() {
        let mut clipped_by_plane = [false; 6];
        let mut discard_primitive = false;
        let mut fully_in_clip_volume = true;

        for (plane_ndx, &plane) in planes.iter().enumerate().take(num_planes) {
            let v0_inside = plane.point_in_clip_volume(vec4_to_clip_vec4(arena[tri.v0].position));
            let v1_inside = plane.point_in_clip_volume(vec4_to_clip_vec4(arena[tri.v1].position));
            let v2_inside = plane.point_in_clip_volume(vec4_to_clip_vec4(arena[tri.v2].position));

            if !v0_inside && !v1_inside && !v2_inside {
                discard_primitive = true;
                break;
            } else if !v0_inside || !v1_inside || !v2_inside {
                clipped_by_plane[plane_ndx] = true;
                fully_in_clip_volume = false;
            } else {
                clipped_by_plane[plane_ndx] = false;
            }
        }

        if discard_primitive {
            continue;
        }
        if fully_in_clip_volume {
            output_triangles.push(*tri);
            continue;
        }

        let mut sub_triangles = vec![SubTriangle {
            vertices: [
                TriangleVertex {
                    position: vec4_to_clip_vec4(arena[tri.v0].position),
                    weight: [1.0, 0.0, 0.0],
                },
                TriangleVertex {
                    position: vec4_to_clip_vec4(arena[tri.v1].position),
                    weight: [0.0, 1.0, 0.0],
                },
                TriangleVertex {
                    position: vec4_to_clip_vec4(arena[tri.v2].position),
                    weight: [0.0, 0.0, 1.0],
                },
            ],
        }];

        for (plane_ndx, &plane) in planes.iter().enumerate().take(num_planes) {
            if !clipped_by_plane[plane_ndx] {
                continue;
            }

            let mut next_phase_sub_triangles = Vec::new();

            for sub_tri in &sub_triangles {
                let mut convex_primitive = Vec::new();
                clip_triangle_to_plane(&mut convex_primitive, &sub_tri.vertices, plane);

                if convex_primitive.is_empty() {
                    continue;
                }
                debug_assert!(convex_primitive.len() == 3 || convex_primitive.len() == 4);

                // Triangulate the planar convex n-gon.
                let v0 = convex_primitive[0];
                for sub_sub_ndx in 1..convex_primitive.len() - 1 {
                    let degenerate_epsilon = 1.0e-6f32;
                    let v1 = convex_primitive[sub_sub_ndx];
                    let v2 = convex_primitive[sub_sub_ndx + 1];

                    let p0 = to_2d_cartesian(clip_vec4_to_vec4(v0.position));
                    let p1 = to_2d_cartesian(clip_vec4_to_vec4(v1.position));
                    let p2 = to_2d_cartesian(clip_vec4_to_vec4(v2.position));
                    let visible_area = cross2d((p1.0 - p0.0, p1.1 - p0.1), (p2.0 - p0.0, p2.1 - p0.1)).abs();

                    if visible_area >= degenerate_epsilon {
                        next_phase_sub_triangles.push(SubTriangle { vertices: [v0, v1, v2] });
                    }
                }
            }

            sub_triangles = next_phase_sub_triangles;
        }

        // Rebuild pa::Triangles from the sub-triangles. Pulled from `vpalloc` rather
        // than `VertexPacket::new` directly, same reasoning as
        // `make_shared_vertices_distinct` above - these are exactly the same kind of
        // "extra packet beyond the original arena" a clip-plane crossing can add, just
        // via a different route (per-plane subdivision instead of shared-index
        // duplication).
        for sub_tri in &sub_triangles {
            debug_assert_eq!(
                arena[tri.v0].outputs.len(),
                vpalloc.num_vertex_outputs(),
                "vpalloc must be sized to this draw's own varying count, matching every packet already in arena"
            );
            let mut p0 = vpalloc.alloc();
            let mut p1 = vpalloc.alloc();
            let mut p2 = vpalloc.alloc();

            p0.position = clip_vec4_to_vec4(sub_tri.vertices[0].position);
            p1.position = clip_vec4_to_vec4(sub_tri.vertices[1].position);
            p2.position = clip_vec4_to_vec4(sub_tri.vertices[2].position);

            for (output_ndx, info) in frag_inputs.iter().enumerate() {
                if info.type_ == Some(GenericVecType::Float) {
                    let out0 = arena[tri.v0].outputs[output_ndx].get_float();
                    let out1 = arena[tri.v1].outputs[output_ndx].get_float();
                    let out2 = arena[tri.v2].outputs[output_ndx].get_float();

                    let w = sub_tri.vertices[0].weight;
                    p0.outputs[output_ndx] = super::generic_vector::GenericVec4::from_float(
                        out0 * (w[0] as f32) + out1 * (w[1] as f32) + out2 * (w[2] as f32),
                    );
                    let w = sub_tri.vertices[1].weight;
                    p1.outputs[output_ndx] = super::generic_vector::GenericVec4::from_float(
                        out0 * (w[0] as f32) + out1 * (w[1] as f32) + out2 * (w[2] as f32),
                    );
                    let w = sub_tri.vertices[2].weight;
                    p2.outputs[output_ndx] = super::generic_vector::GenericVec4::from_float(
                        out0 * (w[0] as f32) + out1 * (w[1] as f32) + out2 * (w[2] as f32),
                    );
                } else {
                    // Only floats are interpolated; everything else must already have
                    // been flatshaded.
                    let provoking = arena[tri.provoking_vertex_index()].outputs[output_ndx];
                    p0.outputs[output_ndx] = provoking;
                    p1.outputs[output_ndx] = provoking;
                    p2.outputs[output_ndx] = provoking;
                }
            }

            let i0 = arena.len();
            arena.push(p0);
            let i1 = arena.len();
            arena.push(p1);
            let i2 = arena.len();
            arena.push(p2);

            output_triangles.push(Triangle {
                v0: i0,
                v1: i1,
                v2: i2,
                provoking_index: -1,
            });
        }
    }

    *list = output_triangles;
}

/// `clipPrimitives(std::vector<pa::Line>&, ...)`
///
/// Lines are clipped only by the far and near planes here; clipping by the other
/// planes is a by-product of the viewport test performed during rasterization.
fn clip_lines(
    list: &mut Vec<Line>,
    frag_inputs: &[FragmentInputInfo],
    clip_with_z_planes: bool,
    arena: &mut [VertexPacket],
) {
    if !clip_with_z_planes {
        return;
    }

    let mut visible_lines = Vec::new();

    for l in list.iter() {
        let p0v = arena[l.v0].position;
        let p1v = arena[l.v1].position;

        if (p0v.z() < -p0v.w() && p1v.z() < -p1v.w()) || (p0v.z() > p0v.w() && p1v.z() > p1v.w()) {
            continue; // discard
        }

        let p0 = vec4_to_clip_vec4(p0v);
        let p1 = vec4_to_clip_vec4(p1v);
        let t0 = get_line_endpoint_clipping(p0, p1);
        let t1 = get_line_endpoint_clipping(p1, p0);

        if t0 == 0.0 && t1 == 0.0 {
            visible_lines.push(Line {
                v0: l.v0,
                v1: l.v1,
                provoking_index: -1,
            });
        } else {
            arena[l.v0].position = clip_vec4_to_vec4(mix(p0, p1, t0));
            arena[l.v1].position = clip_vec4_to_vec4(mix(p1, p0, t1));

            for (output_ndx, info) in frag_inputs.iter().enumerate() {
                if info.type_ == Some(GenericVecType::Float) {
                    let a0 = arena[l.v0].outputs[output_ndx].get_float();
                    let a1 = arena[l.v1].outputs[output_ndx].get_float();
                    arena[l.v0].outputs[output_ndx] =
                        super::generic_vector::GenericVec4::from_float(a0 + (a1 - a0) * (t0 as f32));
                    arena[l.v1].outputs[output_ndx] =
                        super::generic_vector::GenericVec4::from_float(a1 + (a0 - a1) * (t1 as f32));
                }
            }

            visible_lines.push(Line {
                v0: l.v0,
                v1: l.v1,
                provoking_index: -1,
            });
        }
    }

    *list = visible_lines;
}

/// `clipPrimitives(std::vector<pa::Point>&, ...)`
///
/// Points are discarded only if Z is out of range here; (wide) point clipping against
/// the other planes happens during rasterization.
fn clip_points(list: &mut Vec<Point>, clip_with_z_planes: bool, arena: &[VertexPacket]) {
    if !clip_with_z_planes {
        return;
    }

    list.retain(|p| {
        let pos = arena[p.v0].position;
        (-pos.w()..=pos.w()).contains(&pos.z())
    });
}

/// `clipPrimitives` dispatch over `BasePrimitiveList`. `vpalloc` is only ever read by
/// the `Triangles` arm (the only one of the three that can grow `arena` - see
/// `clip_triangles`'s own comment); `Lines`/`Points` clipping only discards or mutates
/// existing packets in place.
pub fn clip_primitives(
    list: &mut BasePrimitiveList,
    frag_inputs: &[FragmentInputInfo],
    clip_with_z_planes: bool,
    arena: &mut Vec<VertexPacket>,
    vpalloc: &mut VertexPacketAllocator,
) {
    match list {
        BasePrimitiveList::Triangles(tris) => clip_triangles(tris, frag_inputs, clip_with_z_planes, arena, vpalloc),
        BasePrimitiveList::Lines(lines) => clip_lines(lines, frag_inputs, clip_with_z_planes, arena),
        BasePrimitiveList::Points(points) => clip_points(points, clip_with_z_planes, arena),
    }
}

/// `makeSharedVerticeDistinct`/`makeSharedVerticesDistinct` - gives every primitive its
/// own private vertex for any index shared with an earlier-visited primitive (a
/// triangle strip's interior vertices are every neighbouring triangle's `v0`/`v1`), so
/// that the window-coordinate transform and flatshading below run exactly once per
/// *primitive-local* vertex rather than clobbering a shared one twice.
///
/// Takes `vpalloc` now (it did not before a later pass of this port) - upstream's own
/// `makeSharedVerticeDistinct` (singular) pulls the duplicate from the very same
/// `VertexPacketAllocator` the caller's whole arena came from, copying only
/// `position`/`pointSize`/`primitiveID`/`outputs` (never `instanceNdx`/`vertexNdx` -
/// by the time a duplicate is needed those have already done their one job of
/// addressing the original vertex-shaded packet, and upstream's own copy list omits
/// them too). The version this replaced instead grew `arena` via `.clone()`, which
/// reallocates a brand new `outputs` buffer per duplicate; `vpalloc.alloc()` recycles
/// one from the pool `draw_instanced`/`draw_with_geometry_shader` already maintain
/// instead, the same win `vertex_packet.rs`'s own doc comment describes for the arena's
/// *first* allocation, just for the handful of *extra* packets a triangle strip/fan or
/// line strip/loop's shared-vertex topology can add beyond that.
pub fn make_shared_vertices_distinct(
    list: &mut BasePrimitiveList,
    arena: &mut Vec<VertexPacket>,
    vpalloc: &mut VertexPacketAllocator,
) {
    let mut seen: std::collections::HashSet<usize> = std::collections::HashSet::new();

    let mut make_distinct = |ndx: &mut usize, arena: &mut Vec<VertexPacket>, vpalloc: &mut VertexPacketAllocator| {
        if seen.insert(*ndx) {
            // first sighting: keep it as-is
        } else {
            let mut new_packet = vpalloc.alloc();
            new_packet.position = arena[*ndx].position;
            new_packet.point_size = arena[*ndx].point_size;
            new_packet.primitive_id = arena[*ndx].primitive_id;
            new_packet.outputs.copy_from_slice(&arena[*ndx].outputs);
            arena.push(new_packet);
            *ndx = arena.len() - 1;
        }
    };

    match list {
        BasePrimitiveList::Triangles(tris) => {
            for t in tris.iter_mut() {
                make_distinct(&mut t.v0, arena, vpalloc);
                make_distinct(&mut t.v1, arena, vpalloc);
                make_distinct(&mut t.v2, arena, vpalloc);
            }
        }
        BasePrimitiveList::Lines(lines) => {
            for l in lines.iter_mut() {
                make_distinct(&mut l.v0, arena, vpalloc);
                make_distinct(&mut l.v1, arena, vpalloc);
            }
        }
        BasePrimitiveList::Points(points) => {
            for p in points.iter_mut() {
                make_distinct(&mut p.v0, arena, vpalloc);
            }
        }
    }
}

/// `generatePrimitiveIDs`
pub fn generate_primitive_ids(list: &mut BasePrimitiveList, next_primitive_id: &mut i32, arena: &mut [VertexPacket]) {
    match list {
        BasePrimitiveList::Triangles(tris) => {
            for t in tris.iter() {
                let id = *next_primitive_id;
                arena[t.v0].primitive_id = id;
                arena[t.v1].primitive_id = id;
                arena[t.v2].primitive_id = id;
                *next_primitive_id += 1;
            }
        }
        BasePrimitiveList::Lines(lines) => {
            for l in lines.iter() {
                let id = *next_primitive_id;
                arena[l.v0].primitive_id = id;
                arena[l.v1].primitive_id = id;
                *next_primitive_id += 1;
            }
        }
        BasePrimitiveList::Points(points) => {
            for p in points.iter() {
                let id = *next_primitive_id;
                arena[p.v0].primitive_id = id;
                *next_primitive_id += 1;
            }
        }
    }
}

/// `transformVertexClipCoordsToWindowCoords`
pub fn transform_vertex_clip_coords_to_window_coords(
    viewport: &super::render_state::WindowRectangle,
    zn: f32,
    zf: f32,
    packet: &mut VertexPacket,
) {
    // To normalized device coordinates.
    packet.position = Vec4::new(
        packet.position.x() / packet.position.w(),
        packet.position.y() / packet.position.w(),
        packet.position.z() / packet.position.w(),
        1.0 / packet.position.w(),
    );

    // To window coordinates.
    let half_w = viewport.width as f32 / 2.0;
    let half_h = viewport.height as f32 / 2.0;
    let o_x = viewport.left as f32 + half_w;
    let o_y = viewport.bottom as f32 + half_h;

    packet.position = Vec4::new(
        packet.position.x() * half_w + o_x,
        packet.position.y() * half_h + o_y,
        packet.position.z() * (zf - zn) / 2.0 + (zn + zf) / 2.0,
        packet.position.w(),
    );
}

/// `transformClipCoordsToWindowCoords`
pub fn transform_clip_coords_to_window_coords(
    viewport: &super::render_state::WindowRectangle,
    zn: f32,
    zf: f32,
    list: &BasePrimitiveList,
    arena: &mut [VertexPacket],
) {
    let visit = |ndx: usize, arena: &mut [VertexPacket]| {
        transform_vertex_clip_coords_to_window_coords(viewport, zn, zf, &mut arena[ndx]);
    };

    match list {
        BasePrimitiveList::Triangles(tris) => {
            for t in tris {
                visit(t.v0, arena);
                visit(t.v1, arena);
                visit(t.v2, arena);
            }
        }
        BasePrimitiveList::Lines(lines) => {
            for l in lines {
                visit(l.v0, arena);
                visit(l.v1, arena);
            }
        }
        BasePrimitiveList::Points(points) => {
            for p in points {
                visit(p.v0, arena);
            }
        }
    }
}

/// `convertPrimitiveToBaseType` - the adjacency-vertex-dropping half only; the
/// pass-through overloads (Triangle->Triangle, Line->Line, Point->Point) are simply
/// not needed since callers that already have a base type skip this function entirely.
pub fn line_adjacency_to_base(input: &[super::primitive_assembler::LineAdjacency]) -> Vec<Line> {
    input
        .iter()
        .map(|l| {
            let adjacent_provoking_vertex = l.provoking_index;
            let base_provoking_vertex_index = adjacent_provoking_vertex - 1;
            Line {
                v0: l.v1,
                v1: l.v2,
                provoking_index: base_provoking_vertex_index,
            }
        })
        .collect()
}

pub fn triangle_adjacency_to_base(input: &[super::primitive_assembler::TriangleAdjacency]) -> Vec<Triangle> {
    input
        .iter()
        .map(|t| {
            let adjacent_provoking_vertex = t.provoking_index;
            let base_provoking_vertex_index = adjacent_provoking_vertex / 2;
            Triangle {
                v0: t.v0,
                v1: t.v2,
                v2: t.v4,
                provoking_index: base_provoking_vertex_index,
            }
        })
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rr::generic_vector::GenericVec4;

    fn make_arena(positions: &[Vec4]) -> Vec<VertexPacket> {
        positions
            .iter()
            .map(|&pos| {
                let mut p = VertexPacket::new(1);
                p.position = pos;
                p.outputs[0] = GenericVec4::from_float(Vec4::new(1.0, 0.0, 0.0, 1.0));
                p
            })
            .collect()
    }

    #[test]
    fn triangle_fully_inside_passes_through_unmodified() {
        let mut arena = make_arena(&[
            Vec4::new(-0.1, -0.1, 0.0, 1.0),
            Vec4::new(0.1, -0.1, 0.0, 1.0),
            Vec4::new(0.0, 0.1, 0.0, 1.0),
        ]);
        let mut list = BasePrimitiveList::Triangles(vec![Triangle {
            v0: 0,
            v1: 1,
            v2: 2,
            provoking_index: 0,
        }]);
        clip_primitives(&mut list, &[], true, &mut arena, &mut VertexPacketAllocator::new(1));
        match &list {
            BasePrimitiveList::Triangles(tris) => assert_eq!(tris.len(), 1),
            _ => unreachable!(),
        }
    }

    #[test]
    fn triangle_fully_outside_is_discarded() {
        let mut arena = make_arena(&[
            Vec4::new(2.0, 2.0, 0.0, 1.0),
            Vec4::new(3.0, 2.0, 0.0, 1.0),
            Vec4::new(2.0, 3.0, 0.0, 1.0),
        ]);
        let mut list = BasePrimitiveList::Triangles(vec![Triangle {
            v0: 0,
            v1: 1,
            v2: 2,
            provoking_index: 0,
        }]);
        clip_primitives(&mut list, &[], true, &mut arena, &mut VertexPacketAllocator::new(1));
        match &list {
            BasePrimitiveList::Triangles(tris) => assert!(tris.is_empty()),
            _ => unreachable!(),
        }
    }

    /// Same geometry as `triangle_crossing_one_plane_produces_a_quad_two_triangles`
    /// below, but checking *how* the clipped-off triangle's own replacement packets got
    /// into `arena` - the subdivision rebuild pulls from `vpalloc` now rather than
    /// calling `VertexPacket::new` directly (see `clip_triangles`'s own comment), so the
    /// very first packet it creates must be the allocator's own pre-seeded, recognizable
    /// one, not a fresh allocation.
    #[test]
    fn triangle_crossing_one_plane_pulls_its_new_packets_from_the_allocator_passed_in() {
        let mut arena = make_arena(&[
            Vec4::new(0.0, -0.5, 0.0, 1.0),
            Vec4::new(0.0, 0.5, 0.0, 1.0),
            Vec4::new(2.0, 0.0, 0.0, 1.0),
        ]);
        let mut list = BasePrimitiveList::Triangles(vec![Triangle {
            v0: 0,
            v1: 1,
            v2: 2,
            provoking_index: 0,
        }]);

        let mut vpalloc = VertexPacketAllocator::new(1);
        let mut seed = vpalloc.alloc();
        let seed_outputs_ptr = seed.outputs.as_ptr();
        seed.position = Vec4::new(9.0, 9.0, 9.0, 9.0);
        vpalloc.release(vec![seed]);

        let arena_len_before = arena.len();
        clip_primitives(&mut list, &[], true, &mut arena, &mut vpalloc);

        // The subdivision rebuild always allocates at least one new packet here (the
        // triangle genuinely crosses a plane), and the very first `vpalloc.alloc()` it
        // makes is the first new arena entry - which must be the seeded packet, since
        // the free list had nothing else in it.
        assert!(
            arena.len() > arena_len_before,
            "clipping must have appended at least one rebuilt packet"
        );
        assert_eq!(
            arena[arena_len_before].outputs.as_ptr(),
            seed_outputs_ptr,
            "the first rebuilt packet must reuse the allocator's own recycled packet, not allocate a fresh one"
        );
    }

    #[test]
    fn triangle_crossing_one_plane_produces_a_quad_two_triangles() {
        // A triangle with one vertex outside the +x=w plane (x=2 at w=1) and two inside.
        let mut arena = make_arena(&[
            Vec4::new(0.0, -0.5, 0.0, 1.0),
            Vec4::new(0.0, 0.5, 0.0, 1.0),
            Vec4::new(2.0, 0.0, 0.0, 1.0),
        ]);
        let mut list = BasePrimitiveList::Triangles(vec![Triangle {
            v0: 0,
            v1: 1,
            v2: 2,
            provoking_index: 0,
        }]);
        clip_primitives(&mut list, &[], true, &mut arena, &mut VertexPacketAllocator::new(1));
        match &list {
            BasePrimitiveList::Triangles(tris) => {
                assert_eq!(
                    tris.len(),
                    2,
                    "clipping one corner off a triangle must produce a quad, i.e. two triangles"
                );
                // Every vertex position of the result must satisfy the clip volume (x <= w).
                for t in tris {
                    for &idx in &[t.v0, t.v1, t.v2] {
                        let p = arena[idx].position;
                        assert!(
                            p.x() <= p.w() + 1e-5,
                            "clipped vertex at x={} w={} is still outside +x plane",
                            p.x(),
                            p.w()
                        );
                    }
                }
            }
            _ => unreachable!(),
        }
    }

    #[test]
    fn line_entirely_behind_near_plane_is_discarded() {
        let mut arena = make_arena(&[Vec4::new(0.0, 0.0, -2.0, 1.0), Vec4::new(0.0, 0.0, -3.0, 1.0)]);
        let mut list = BasePrimitiveList::Lines(vec![Line {
            v0: 0,
            v1: 1,
            provoking_index: 0,
        }]);
        clip_primitives(&mut list, &[], true, &mut arena, &mut VertexPacketAllocator::new(1));
        match &list {
            BasePrimitiveList::Lines(lines) => assert!(lines.is_empty()),
            _ => unreachable!(),
        }
    }

    #[test]
    fn line_crossing_near_plane_is_clipped_to_it() {
        // v0 is inside (z=0,w=1), v1 is behind the near plane (z=-2,w=1).
        let mut arena = make_arena(&[Vec4::new(0.0, 0.0, 0.0, 1.0), Vec4::new(0.0, 0.0, -2.0, 1.0)]);
        let mut list = BasePrimitiveList::Lines(vec![Line {
            v0: 0,
            v1: 1,
            provoking_index: 0,
        }]);
        clip_primitives(&mut list, &[], true, &mut arena, &mut VertexPacketAllocator::new(1));
        match &list {
            BasePrimitiveList::Lines(lines) => {
                assert_eq!(lines.len(), 1);
                let l = lines[0];
                assert!(
                    (arena[l.v1].position.z() + arena[l.v1].position.w()).abs() < 1e-5,
                    "clipped endpoint must land exactly on z=-w"
                );
            }
            _ => unreachable!(),
        }
    }

    #[test]
    fn point_outside_z_range_is_discarded() {
        let mut arena = make_arena(&[Vec4::new(0.0, 0.0, 2.0, 1.0)]);
        let mut list = BasePrimitiveList::Points(vec![Point { v0: 0 }]);
        clip_primitives(&mut list, &[], true, &mut arena, &mut VertexPacketAllocator::new(1));
        match &list {
            BasePrimitiveList::Points(points) => assert!(points.is_empty()),
            _ => unreachable!(),
        }
    }

    #[test]
    fn make_shared_vertices_distinct_duplicates_second_use() {
        let mut arena = make_arena(&[
            Vec4::new(0.0, 0.0, 0.0, 1.0),
            Vec4::new(1.0, 0.0, 0.0, 1.0),
            Vec4::new(0.0, 1.0, 0.0, 1.0),
            Vec4::new(1.0, 1.0, 0.0, 1.0),
        ]);
        // Two triangles sharing vertices 0 and 1 (as a strip would).
        let mut list = BasePrimitiveList::Triangles(vec![
            Triangle {
                v0: 0,
                v1: 1,
                v2: 2,
                provoking_index: 0,
            },
            Triangle {
                v0: 2,
                v1: 1,
                v2: 3,
                provoking_index: 0,
            },
        ]);
        let before_len = arena.len();
        let mut vpalloc = VertexPacketAllocator::new(1);
        make_shared_vertices_distinct(&mut list, &mut arena, &mut vpalloc);
        // Vertex 1 and vertex 2 are each referenced twice, so exactly two new entries
        // should have been appended.
        assert_eq!(arena.len(), before_len + 2);
        match &list {
            BasePrimitiveList::Triangles(tris) => {
                // No two triangles should now share an index.
                let mut all = vec![tris[0].v0, tris[0].v1, tris[0].v2, tris[1].v0, tris[1].v1, tris[1].v2];
                all.sort_unstable();
                all.dedup();
                assert_eq!(all.len(), 6);
            }
            _ => unreachable!(),
        }
    }

    /// Proves the duplicate `make_shared_vertices_distinct` creates for a repeated
    /// index comes from the exact `VertexPacketAllocator` passed in - not a fresh
    /// `VertexPacket::new`, and not stale data left over from whatever that allocator's
    /// own free-list entry was carrying before - by pre-seeding the allocator with one
    /// recognizable recycled packet (a marker position and a known `outputs` heap
    /// allocation) and checking both that the duplicate reused that exact allocation
    /// (pointer identity, the same proof `vertex_packet.rs`'s own
    /// `release_then_alloc_reuses_the_same_outputs_allocation_at_matching_output_count`
    /// test uses) and that its *content* is the duplicated vertex's own data, not the
    /// marker's.
    #[test]
    fn make_shared_vertices_distinct_pulls_the_duplicate_from_the_allocator_passed_in() {
        let mut arena = make_arena(&[
            Vec4::new(0.0, 0.0, 0.0, 1.0),
            Vec4::new(1.0, 0.0, 0.0, 1.0),
            Vec4::new(0.0, 1.0, 0.0, 1.0),
        ]);
        // One triangle that references vertex 1 twice (as v1 and v2) - the second
        // reference must be made distinct even within a single primitive.
        let mut list = BasePrimitiveList::Triangles(vec![Triangle {
            v0: 0,
            v1: 1,
            v2: 1,
            provoking_index: 0,
        }]);

        let mut vpalloc = VertexPacketAllocator::new(1);
        let mut seed = vpalloc.alloc();
        let seed_outputs_ptr = seed.outputs.as_ptr();
        seed.position = Vec4::new(9.0, 9.0, 9.0, 9.0); // a marker no real vertex here has
        vpalloc.release(vec![seed]);

        make_shared_vertices_distinct(&mut list, &mut arena, &mut vpalloc);

        let BasePrimitiveList::Triangles(tris) = &list else {
            unreachable!();
        };
        assert_ne!(
            tris[0].v1, tris[0].v2,
            "the repeated reference to vertex 1 must have been made distinct"
        );
        let duplicate = &arena[tris[0].v2];
        assert_eq!(
            duplicate.outputs.as_ptr(),
            seed_outputs_ptr,
            "the duplicate must reuse the allocator's own recycled packet, not allocate a fresh one"
        );
        assert_eq!(
            duplicate.position,
            Vec4::new(1.0, 0.0, 0.0, 1.0),
            "the duplicate must carry vertex 1's own position, not the recycled packet's stale marker value"
        );
        assert_eq!(
            duplicate.outputs[0],
            GenericVec4::from_float(Vec4::new(1.0, 0.0, 0.0, 1.0)),
            "and vertex 1's own output, copied field-by-field rather than left over from the recycled packet"
        );
    }
}
