// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrRasterizer.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Not to be confused with `rr::triangle_rasterizer` (that file's own doc explains why
// it is a separate, reduced, single-purpose rasterizer for `gls::texture_buffer_case`
// and not a port of this one). This *is* the generic one: fixed-point triangle
// rasterisation at 1/2/4/8/16 samples, single- and multi-sampled line rasterisation,
// and the GL "diamond exit" line rule.
//
// Two upstream pieces are deliberately not ported:
//  - `LineExitDiamondGenerator` - upstream's own doc says it exists only "to prevent
//    test cases requiring accurate diamonds from abusing SingleSampleLineRasterizer",
//    i.e. it is a convenience wrapper for *verifying* rasterisation precision tests,
//    never called by `rr` itself. `SingleSampleLineRasterizer` still needs (and gets)
//    the underlying `doesLineSegmentExitDiamond` rule; only the wrapper class is
//    skipped, since nothing in this session's target groups (draw.*, draw_indirect.*,
//    vertex_arrays.*, clipping.*, fragment_ops.*, fbo.*) needs it, and it is cheap to
//    add back later as a thin wrapper if `rasterization.*` ever needs it.
//  - the `template <int NumSamples>` split between `rasterizeSingleSample` and
//    `rasterizeMultiSample<N>` stays as two functions (single-sample truly is a
//    different algorithm, sampling the exact pixel centre rather than a per-sample
//    offset table - see the comment on `rasterize_single_sample` below), but
//    `rasterizeMultiSample<N>`'s compile-time `N` becomes a runtime `num_samples`
//    parameter bounded by `RASTERIZER_MAX_SAMPLES_PER_FRAGMENT`. This is a reference
//    rasteriser, not a hot path Rust needs monomorphised per sample count for; the
//    maths is identical either way.
//
// The GL "diamond exit" rule itself (`SubpixelLineSegment`, `does_line_segment_exit_diamond`
// and its corner-case helpers) is **not duplicated here** - it already exists, ported
// earlier for `tcu::rasterization_verifier`'s own line-rasterisation verifier, which
// needs the exact same infinite-precision rule to check a *driver's* line output
// against. Re-deriving ~350 lines of corner-case geometry a second time would only add
// a second place for the same transcription bug to hide; the needed pieces are
// re-exported `pub(crate)` from that module and used directly below.

use super::fragment_packet::FragmentPacket;
use super::render_state::{FaceType, HorizontalFill, RasterizationState, VerticalFill, Winding};
use crate::tcu::rasterization_verifier::{
    SubpixelLineSegment, ceil_subpixel_to_pixel_coord, does_line_segment_exit_diamond, floor_subpixel_to_pixel_coord,
    to_subpixel_coord_f32, to_subpixel_coord_i32, to_subpixel_vector_f, to_subpixel_vector_i,
};
use crate::tcu::vector::{IVec2, IVec4, Vec4};

/// Rasterizer configuration.
pub const RASTERIZER_MAX_SAMPLES_PER_FRAGMENT: usize = 16;

/// `getCoverageBit`
pub fn get_coverage_bit(num_samples: i32, x: i32, y: i32, sample_ndx: i32) -> u64 {
    debug_assert!((1..=64).contains(&num_samples) && (0..2).contains(&x) && (0..2).contains(&y));
    1u64 << ((x * 2 + y) * num_samples + sample_ndx)
}

/// `getCoverageFragmentSampleBits`
pub fn get_coverage_fragment_sample_bits(num_samples: i32, x: i32, y: i32) -> u64 {
    debug_assert!((0..2).contains(&x) && (0..2).contains(&y));
    let frag_mask = (1u64 << num_samples) - 1;
    frag_mask << ((x * 2 + y) * num_samples)
}

/// `setCoverageValue`
pub fn set_coverage_value(mask: u64, num_samples: i32, x: i32, y: i32, sample_ndx: i32, val: bool) -> u64 {
    let bit = get_coverage_bit(num_samples, x, y, sample_ndx);
    if val { mask | bit } else { mask & !bit }
}

/// `getCoverageValue`
pub fn get_coverage_value(mask: u64, num_samples: i32, x: i32, y: i32, sample_ndx: i32) -> bool {
    (mask & get_coverage_bit(num_samples, x, y, sample_ndx)) != 0
}

/// `getCoverageAnyFragmentSampleLive`
pub fn get_coverage_any_fragment_sample_live(mask: u64, num_samples: i32, x: i32, y: i32) -> bool {
    (mask & get_coverage_fragment_sample_bits(num_samples, x, y)) != 0
}

/// `getCoverageOffset`
pub fn get_coverage_offset(num_samples: i32, x: i32, y: i32) -> i32 {
    (x * 2 + y) * num_samples
}

/// `rr::EdgeFunction`
///
/// Can be evaluated for point P (in fixed-point coordinates with `subpixel_bits`
/// fractional part) by computing `D = a*Px + b*Py + c`. `D` will be a fixed-point value
/// where the lower `subpixel_bits*2` bits are the fractional part. `a`/`b` carry
/// `subpixel_bits` fractional bits, `c` carries `subpixel_bits*2`.
#[derive(Debug, Clone, Copy, Default)]
struct EdgeFunction {
    a: i64,
    b: i64,
    c: i64,
    /// True if the edge is inclusive according to the fill rules.
    inclusive: bool,
}

/// `initEdgeCCW`
fn init_edge_ccw(
    horizontal_fill: HorizontalFill,
    vertical_fill: VerticalFill,
    x0: i64,
    y0: i64,
    x1: i64,
    y1: i64,
) -> EdgeFunction {
    let xd = x1 - x0;
    let yd = y1 - y0;
    let inclusive = if yd == 0 {
        if vertical_fill == VerticalFill::Bottom {
            xd >= 0
        } else {
            xd <= 0
        }
    } else if horizontal_fill == HorizontalFill::Left {
        yd <= 0
    } else {
        yd >= 0
    };

    EdgeFunction {
        a: y0 - y1,
        b: x1 - x0,
        c: x0 * y1 - y0 * x1,
        inclusive,
    }
}

/// `reverseEdge`
fn reverse_edge(edge: &mut EdgeFunction) {
    edge.a = -edge.a;
    edge.b = -edge.b;
    edge.c = -edge.c;
    edge.inclusive = !edge.inclusive;
}

/// `evaluateEdge`
fn evaluate_edge(edge: &EdgeFunction, x: i64, y: i64) -> i64 {
    edge.a * x + edge.b * y + edge.c
}

/// `isInsideCCW`
fn is_inside_ccw(edge: &EdgeFunction, edge_val: i64) -> bool {
    if edge.inclusive { edge_val >= 0 } else { edge_val > 0 }
}

// Sample positions - ordered as (x, y) list, same tables as upstream's
// `s_samplePts{2,4,8,16}`.
const SAMPLE_PTS_2: [f32; 4] = [0.3, 0.3, 0.7, 0.7];
const SAMPLE_PTS_4: [f32; 8] = [0.25, 0.25, 0.75, 0.25, 0.25, 0.75, 0.75, 0.75];
const SAMPLE_PTS_8: [f32; 16] = [
    7.0 / 16.0,
    9.0 / 16.0,
    9.0 / 16.0,
    13.0 / 16.0,
    11.0 / 16.0,
    3.0 / 16.0,
    13.0 / 16.0,
    11.0 / 16.0,
    1.0 / 16.0,
    7.0 / 16.0,
    5.0 / 16.0,
    1.0 / 16.0,
    15.0 / 16.0,
    5.0 / 16.0,
    3.0 / 16.0,
    15.0 / 16.0,
];
const SAMPLE_PTS_16: [f32; 32] = [
    1.0 / 8.0,
    1.0 / 8.0,
    3.0 / 8.0,
    1.0 / 8.0,
    5.0 / 8.0,
    1.0 / 8.0,
    7.0 / 8.0,
    1.0 / 8.0,
    1.0 / 8.0,
    3.0 / 8.0,
    3.0 / 8.0,
    3.0 / 8.0,
    5.0 / 8.0,
    3.0 / 8.0,
    7.0 / 8.0,
    3.0 / 8.0,
    1.0 / 8.0,
    5.0 / 8.0,
    3.0 / 8.0,
    5.0 / 8.0,
    5.0 / 8.0,
    5.0 / 8.0,
    7.0 / 8.0,
    5.0 / 8.0,
    1.0 / 8.0,
    7.0 / 8.0,
    3.0 / 8.0,
    7.0 / 8.0,
    5.0 / 8.0,
    7.0 / 8.0,
    7.0 / 8.0,
    7.0 / 8.0,
];

fn sample_points_for(num_samples: i32) -> &'static [f32] {
    match num_samples {
        2 => &SAMPLE_PTS_2,
        4 => &SAMPLE_PTS_4,
        8 => &SAMPLE_PTS_8,
        16 => &SAMPLE_PTS_16,
        _ => unreachable!("unsupported multisample count: {num_samples}"),
    }
}

/// `rr::TriangleRasterizer`
///
/// Implements:
///  - Rasterization using fixed-point coordinates.
///  - 1, 2, 4, 8 and 16-sample rasterization.
///  - Depth interpolation.
///  - Perspective-correct barycentric computation for interpolation.
///  - Visible face determination.
///
/// It does not (and will not) implement:
///  - Triangle setup, clipping, degenerate elimination, coordinate transformation
///    (inputs are in screen space), culling (query `visible_face` instead) or
///    scissoring (control the viewport rectangle instead).
pub struct TriangleRasterizer {
    // Constant rasterization state.
    viewport: IVec4,
    num_samples: i32,
    winding: Winding,
    horizontal_fill: HorizontalFill,
    vertical_fill: VerticalFill,
    subpixel_bits: i32,
    viewport_orientation_upper_left: bool,

    // Per-triangle rasterization state.
    v0: Vec4,
    v1: Vec4,
    v2: Vec4,
    edge01: EdgeFunction,
    edge12: EdgeFunction,
    edge20: EdgeFunction,
    face: FaceType,
    bbox_min: (i32, i32),
    bbox_max: (i32, i32),
    cur_pos: (i32, i32),
}

impl TriangleRasterizer {
    /// `TriangleRasterizer::TriangleRasterizer`
    pub fn new(viewport: IVec4, num_samples: i32, state: &RasterizationState, subpixel_bits: i32) -> Self {
        Self {
            viewport,
            num_samples,
            winding: state.winding,
            horizontal_fill: state.horizontal_fill,
            vertical_fill: state.vertical_fill,
            subpixel_bits,
            viewport_orientation_upper_left: state.viewport_orientation
                == Some(super::render_state::ViewportOrientation::UpperLeft),
            v0: Vec4::splat(0.0),
            v1: Vec4::splat(0.0),
            v2: Vec4::splat(0.0),
            edge01: EdgeFunction::default(),
            edge12: EdgeFunction::default(),
            edge20: EdgeFunction::default(),
            face: FaceType::Front,
            bbox_min: (0, 0),
            bbox_max: (0, 0),
            cur_pos: (0, 0),
        }
    }

    pub fn visible_face(&self) -> FaceType {
        self.face
    }

    /// `TriangleRasterizer::init` - screen-space coordinates (x, y, z) and 1/w for
    /// each vertex.
    pub fn init(&mut self, v0: Vec4, v1: Vec4, v2: Vec4) {
        self.v0 = v0;
        self.v1 = v1;
        self.v2 = v2;

        let x0 = to_subpixel_coord_f32(v0.x(), self.subpixel_bits);
        let y0 = to_subpixel_coord_f32(v0.y(), self.subpixel_bits);
        let x1 = to_subpixel_coord_f32(v1.x(), self.subpixel_bits);
        let y1 = to_subpixel_coord_f32(v1.y(), self.subpixel_bits);
        let x2 = to_subpixel_coord_f32(v2.x(), self.subpixel_bits);
        let y2 = to_subpixel_coord_f32(v2.y(), self.subpixel_bits);

        let (mut edge01, mut edge12, mut edge20) = if self.winding == Winding::Ccw {
            (
                init_edge_ccw(self.horizontal_fill, self.vertical_fill, x0, y0, x1, y1),
                init_edge_ccw(self.horizontal_fill, self.vertical_fill, x1, y1, x2, y2),
                init_edge_ccw(self.horizontal_fill, self.vertical_fill, x2, y2, x0, y0),
            )
        } else {
            (
                init_edge_ccw(self.horizontal_fill, self.vertical_fill, x1, y1, x0, y0),
                init_edge_ccw(self.horizontal_fill, self.vertical_fill, x2, y2, x1, y1),
                init_edge_ccw(self.horizontal_fill, self.vertical_fill, x0, y0, x2, y2),
            )
        };

        let s = evaluate_edge(&edge01, x2, y2);
        let positive_area = if self.winding == Winding::Ccw { s > 0 } else { s < 0 };

        self.face = if self.viewport_orientation_upper_left {
            if positive_area { FaceType::Back } else { FaceType::Front }
        } else if positive_area {
            FaceType::Front
        } else {
            FaceType::Back
        };

        if !positive_area {
            reverse_edge(&mut edge01);
            reverse_edge(&mut edge12);
            reverse_edge(&mut edge20);
        }

        self.edge01 = edge01;
        self.edge12 = edge12;
        self.edge20 = edge20;

        let x_min = x0.min(x1).min(x2);
        let x_max = x0.max(x1).max(x2);
        let y_min = y0.min(y1).min(y2);
        let y_max = y0.max(y1).max(y2);

        let mut bbox_min_x =
            floor_subpixel_to_pixel_coord(x_min, self.subpixel_bits, self.horizontal_fill == HorizontalFill::Left);
        let mut bbox_min_y =
            floor_subpixel_to_pixel_coord(y_min, self.subpixel_bits, self.vertical_fill == VerticalFill::Bottom);
        let mut bbox_max_x =
            ceil_subpixel_to_pixel_coord(x_max, self.subpixel_bits, self.horizontal_fill == HorizontalFill::Right);
        let mut bbox_max_y =
            ceil_subpixel_to_pixel_coord(y_max, self.subpixel_bits, self.vertical_fill == VerticalFill::Top);

        let w_x0 = self.viewport.x();
        let w_y0 = self.viewport.y();
        let w_x1 = w_x0 + self.viewport.z() - 1;
        let w_y1 = w_y0 + self.viewport.w() - 1;

        bbox_min_x = bbox_min_x.clamp(w_x0, w_x1);
        bbox_min_y = bbox_min_y.clamp(w_y0, w_y1);
        bbox_max_x = bbox_max_x.clamp(w_x0, w_x1);
        bbox_max_y = bbox_max_y.clamp(w_y0, w_y1);

        self.bbox_min = (bbox_min_x, bbox_min_y);
        self.bbox_max = (bbox_max_x, bbox_max_y);
        self.cur_pos = self.bbox_min;
    }

    /// `TriangleRasterizer::rasterize`. Returns the number of fragment packets
    /// written.
    pub fn rasterize(
        &mut self,
        fragment_packets: &mut [FragmentPacket],
        depth_values: Option<&mut [f32]>,
        max_fragment_packets: usize,
    ) -> usize {
        debug_assert!(max_fragment_packets > 0);
        if self.num_samples == 1 {
            self.rasterize_single_sample(fragment_packets, depth_values, max_fragment_packets)
        } else {
            self.rasterize_multi_sample(self.num_samples, fragment_packets, depth_values, max_fragment_packets)
        }
    }

    /// `TriangleRasterizer::rasterizeSingleSample`
    fn rasterize_single_sample(
        &mut self,
        fragment_packets: &mut [FragmentPacket],
        depth_values: Option<&mut [f32]>,
        max_fragment_packets: usize,
    ) -> usize {
        let half_pixel = 1i64 << (self.subpixel_bits - 1);
        let mut packet_ndx = 0;

        // For depth interpolation; given barycentrics A, B, C = (1 - A - B) we can
        // reformulate the usual z = z0*A + z1*B + z2*C into the more stable
        // z = A*(z0 - z2) + B*(z1 - z2) + z2.
        let za = self.v0.z() - self.v2.z();
        let zb = self.v1.z() - self.v2.z();
        let zc = self.v2.z();

        let mut depth_values = depth_values;

        while self.cur_pos.1 <= self.bbox_max.1 && packet_ndx < max_fragment_packets {
            let x0 = self.cur_pos.0;
            let y0 = self.cur_pos.1;

            let sx0 = to_subpixel_coord_i32(x0, self.subpixel_bits) + half_pixel;
            let sx1 = to_subpixel_coord_i32(x0 + 1, self.subpixel_bits) + half_pixel;
            let sy0 = to_subpixel_coord_i32(y0, self.subpixel_bits) + half_pixel;
            let sy1 = to_subpixel_coord_i32(y0 + 1, self.subpixel_bits) + half_pixel;

            let sx = [sx0, sx1, sx0, sx1];
            let sy = [sy0, sy0, sy1, sy1];

            let out_x1 = x0 + 1 == self.viewport.x() + self.viewport.z();
            let out_y1 = y0 + 1 == self.viewport.y() + self.viewport.w();

            let mut e01 = [0i64; 4];
            let mut e12 = [0i64; 4];
            let mut e20 = [0i64; 4];
            for i in 0..4 {
                e01[i] = evaluate_edge(&self.edge01, sx[i], sy[i]);
                e12[i] = evaluate_edge(&self.edge12, sx[i], sy[i]);
                e20[i] = evaluate_edge(&self.edge20, sx[i], sy[i]);
            }

            let mut coverage = 0u64;
            coverage = set_coverage_value(
                coverage,
                1,
                0,
                0,
                0,
                is_inside_ccw(&self.edge01, e01[0])
                    && is_inside_ccw(&self.edge12, e12[0])
                    && is_inside_ccw(&self.edge20, e20[0]),
            );
            coverage = set_coverage_value(
                coverage,
                1,
                1,
                0,
                0,
                !out_x1
                    && is_inside_ccw(&self.edge01, e01[1])
                    && is_inside_ccw(&self.edge12, e12[1])
                    && is_inside_ccw(&self.edge20, e20[1]),
            );
            coverage = set_coverage_value(
                coverage,
                1,
                0,
                1,
                0,
                !out_y1
                    && is_inside_ccw(&self.edge01, e01[2])
                    && is_inside_ccw(&self.edge12, e12[2])
                    && is_inside_ccw(&self.edge20, e20[2]),
            );
            coverage = set_coverage_value(
                coverage,
                1,
                1,
                1,
                0,
                !out_x1
                    && !out_y1
                    && is_inside_ccw(&self.edge01, e01[3])
                    && is_inside_ccw(&self.edge12, e12[3])
                    && is_inside_ccw(&self.edge20, e20[3]),
            );

            self.cur_pos.0 += 2;
            if self.cur_pos.0 > self.bbox_max.0 {
                self.cur_pos.1 += 2;
                self.cur_pos.0 = self.bbox_min.0;
            }

            if coverage == 0 {
                continue;
            }

            let e01f = e01.map(|v| v as f32);
            let e12f = e12.map(|v| v as f32);
            let e20f = e20.map(|v| v as f32);

            if let Some(depth_values) = depth_values.as_deref_mut() {
                for i in 0..4 {
                    let edge_sum = e01f[i] + e12f[i] + e20f[i];
                    let z0 = e12f[i] / edge_sum;
                    let z1 = e20f[i] / edge_sum;
                    depth_values[packet_ndx * 4 + i] = z0 * za + z1 * zb + zc;
                }
            }

            {
                let b0 = Vec4::new(e12f[0], e12f[1], e12f[2], e12f[3]) * self.v0.w();
                let b1 = Vec4::new(e20f[0], e20f[1], e20f[2], e20f[3]) * self.v1.w();
                let b2 = Vec4::new(e01f[0], e01f[1], e01f[2], e01f[3]) * self.v2.w();
                let b_sum = b0 + b1 + b2;
                let bary0 = b0 / b_sum;
                let bary1 = b1 / b_sum;
                let bary2 = Vec4::splat(1.0) - bary0 - bary1;

                fragment_packets[packet_ndx] = FragmentPacket {
                    position: IVec2::new(x0, y0),
                    coverage,
                    barycentric: [bary0, bary1, bary2],
                };
                packet_ndx += 1;
            }
        }

        debug_assert!(packet_ndx <= max_fragment_packets);
        packet_ndx
    }

    /// `TriangleRasterizer::rasterizeMultiSample<NumSamples>` - `num_samples` is a
    /// runtime value here (2, 4, 8 or 16) rather than a template parameter; see this
    /// module's top doc comment for why.
    fn rasterize_multi_sample(
        &mut self,
        num_samples: i32,
        fragment_packets: &mut [FragmentPacket],
        depth_values: Option<&mut [f32]>,
        max_fragment_packets: usize,
    ) -> usize {
        let sample_pts = sample_points_for(num_samples);
        let n = num_samples as usize;
        let mut sample_pos = [(0i64, 0i64); RASTERIZER_MAX_SAMPLES_PER_FRAGMENT];
        for c in 0..n {
            sample_pos[c] = (
                to_subpixel_coord_f32(sample_pts[c * 2], self.subpixel_bits),
                to_subpixel_coord_f32(sample_pts[c * 2 + 1], self.subpixel_bits),
            );
        }

        let half_pixel = 1i64 << (self.subpixel_bits - 1);
        let mut packet_ndx = 0;

        let za = self.v0.z() - self.v2.z();
        let zb = self.v1.z() - self.v2.z();
        let zc = self.v2.z();

        let mut depth_values = depth_values;

        while self.cur_pos.1 <= self.bbox_max.1 && packet_ndx < max_fragment_packets {
            let x0 = self.cur_pos.0;
            let y0 = self.cur_pos.1;

            let sx0 = to_subpixel_coord_i32(x0, self.subpixel_bits);
            let sx1 = to_subpixel_coord_i32(x0 + 1, self.subpixel_bits);
            let sy0 = to_subpixel_coord_i32(y0, self.subpixel_bits);
            let sy1 = to_subpixel_coord_i32(y0 + 1, self.subpixel_bits);

            let sx = [sx0, sx1, sx0, sx1];
            let sy = [sy0, sy0, sy1, sy1];

            let out_x1 = x0 + 1 == self.viewport.x() + self.viewport.z();
            let out_y1 = y0 + 1 == self.viewport.y() + self.viewport.w();

            let mut e01 = [[0i64; 4]; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT];
            let mut e12 = [[0i64; 4]; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT];
            let mut e20 = [[0i64; 4]; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT];

            for sample_ndx in 0..n {
                let (ox, oy) = sample_pos[sample_ndx];
                for frag_ndx in 0..4 {
                    e01[sample_ndx][frag_ndx] = evaluate_edge(&self.edge01, sx[frag_ndx] + ox, sy[frag_ndx] + oy);
                    e12[sample_ndx][frag_ndx] = evaluate_edge(&self.edge12, sx[frag_ndx] + ox, sy[frag_ndx] + oy);
                    e20[sample_ndx][frag_ndx] = evaluate_edge(&self.edge20, sx[frag_ndx] + ox, sy[frag_ndx] + oy);
                }
            }

            let mut coverage = 0u64;
            for sample_ndx in 0..n {
                let si = sample_ndx as i32;
                coverage = set_coverage_value(
                    coverage,
                    num_samples,
                    0,
                    0,
                    si,
                    is_inside_ccw(&self.edge01, e01[sample_ndx][0])
                        && is_inside_ccw(&self.edge12, e12[sample_ndx][0])
                        && is_inside_ccw(&self.edge20, e20[sample_ndx][0]),
                );
                coverage = set_coverage_value(
                    coverage,
                    num_samples,
                    1,
                    0,
                    si,
                    !out_x1
                        && is_inside_ccw(&self.edge01, e01[sample_ndx][1])
                        && is_inside_ccw(&self.edge12, e12[sample_ndx][1])
                        && is_inside_ccw(&self.edge20, e20[sample_ndx][1]),
                );
                coverage = set_coverage_value(
                    coverage,
                    num_samples,
                    0,
                    1,
                    si,
                    !out_y1
                        && is_inside_ccw(&self.edge01, e01[sample_ndx][2])
                        && is_inside_ccw(&self.edge12, e12[sample_ndx][2])
                        && is_inside_ccw(&self.edge20, e20[sample_ndx][2]),
                );
                coverage = set_coverage_value(
                    coverage,
                    num_samples,
                    1,
                    1,
                    si,
                    !out_x1
                        && !out_y1
                        && is_inside_ccw(&self.edge01, e01[sample_ndx][3])
                        && is_inside_ccw(&self.edge12, e12[sample_ndx][3])
                        && is_inside_ccw(&self.edge20, e20[sample_ndx][3]),
                );
            }

            self.cur_pos.0 += 2;
            if self.cur_pos.0 > self.bbox_max.0 {
                self.cur_pos.1 += 2;
                self.cur_pos.0 = self.bbox_min.0;
            }

            if coverage == 0 {
                continue;
            }

            if let Some(depth_values) = depth_values.as_deref_mut() {
                for sample_ndx in 0..n {
                    let e01f = e01[sample_ndx].map(|v| v as f32);
                    let e12f = e12[sample_ndx].map(|v| v as f32);
                    let e20f = e20[sample_ndx].map(|v| v as f32);

                    for frag_ndx in 0..4 {
                        let edge_sum = e01f[frag_ndx] + e12f[frag_ndx] + e20f[frag_ndx];
                        let z0 = e12f[frag_ndx] / edge_sum;
                        let z1 = e20f[frag_ndx] / edge_sum;
                        depth_values[(packet_ndx * 4 + frag_ndx) * n + sample_ndx] = z0 * za + z1 * zb + zc;
                    }
                }
            }

            {
                let mut e01f = [0f32; 4];
                let mut e12f = [0f32; 4];
                let mut e20f = [0f32; 4];
                for i in 0..4 {
                    e01f[i] = evaluate_edge(&self.edge01, sx[i] + half_pixel, sy[i] + half_pixel) as f32;
                    e12f[i] = evaluate_edge(&self.edge12, sx[i] + half_pixel, sy[i] + half_pixel) as f32;
                    e20f[i] = evaluate_edge(&self.edge20, sx[i] + half_pixel, sy[i] + half_pixel) as f32;
                }

                let b0 = Vec4::new(e12f[0], e12f[1], e12f[2], e12f[3]) * self.v0.w();
                let b1 = Vec4::new(e20f[0], e20f[1], e20f[2], e20f[3]) * self.v1.w();
                let b2 = Vec4::new(e01f[0], e01f[1], e01f[2], e01f[3]) * self.v2.w();
                let b_sum = b0 + b1 + b2;
                let bary0 = b0 / b_sum;
                let bary1 = b1 / b_sum;
                let bary2 = Vec4::splat(1.0) - bary0 - bary1;

                fragment_packets[packet_ndx] = FragmentPacket {
                    position: IVec2::new(x0, y0),
                    coverage,
                    barycentric: [bary0, bary1, bary2],
                };
                packet_ndx += 1;
            }
        }

        debug_assert!(packet_ndx <= max_fragment_packets);
        packet_ndx
    }
}

/// `rr::SingleSampleLineRasterizer`
///
/// Implements:
///  - Rasterization using fixed-point coordinates.
///  - Depth interpolation.
///  - Perspective-correct interpolation.
///
/// Does not implement clipping or multisampled line rasterization.
pub struct SingleSampleLineRasterizer {
    viewport: IVec4,
    subpixel_bits: i32,

    v0: Vec4,
    v1: Vec4,
    bbox_min: (i32, i32),
    bbox_max: (i32, i32),
    cur_pos: (i32, i32),
    cur_row_fragment: i32,
    line_width: f32,
    stipple_factor: u32,
    stipple_pattern: u16,
    stipple_counter: u32,
}

impl SingleSampleLineRasterizer {
    pub fn new(viewport: IVec4, subpixel_bits: i32) -> Self {
        Self {
            viewport,
            subpixel_bits,
            v0: Vec4::splat(0.0),
            v1: Vec4::splat(0.0),
            bbox_min: (0, 0),
            bbox_max: (0, 0),
            cur_pos: (0, 0),
            cur_row_fragment: 0,
            line_width: 0.0,
            stipple_factor: 1,
            stipple_pattern: 0xFFFF,
            stipple_counter: 0,
        }
    }

    pub fn reset_stipple(&mut self) {
        self.stipple_counter = 0;
    }

    /// `SingleSampleLineRasterizer::init`
    pub fn init(&mut self, v0: Vec4, v1: Vec4, line_width: f32, stipple_factor: u32, stipple_pattern: u16) {
        let is_x_major = (v1.x() - v0.x()).abs() >= (v1.y() - v0.y()).abs();

        // Bounding box. Note: with wide lines, the line is actually moved as in the
        // spec.
        let line_width_pixels = if line_width > 1.0 {
            (line_width + 0.5).floor() as i32
        } else {
            1
        };

        let width_dir: (i64, i64) = if is_x_major { (0, -1) } else { (-1, 0) };
        let scale = to_subpixel_coord_i32(line_width_pixels - 1, self.subpixel_bits) / 2;
        let width_offset = (width_dir.0 * scale, width_dir.1 * scale);

        let x0 = to_subpixel_coord_f32(v0.x(), self.subpixel_bits) + width_offset.0;
        let y0 = to_subpixel_coord_f32(v0.y(), self.subpixel_bits) + width_offset.1;
        let x1 = to_subpixel_coord_f32(v1.x(), self.subpixel_bits) + width_offset.0;
        let y1 = to_subpixel_coord_f32(v1.y(), self.subpixel_bits) + width_offset.1;

        let one_px = to_subpixel_coord_i32(1, self.subpixel_bits);
        let x_min = x0.min(x1) - one_px;
        let x_max = x0.max(x1) + one_px;
        let y_min = y0.min(y1) - one_px;
        let y_max = y0.max(y1) + one_px;

        let (bbox_min, bbox_max);
        if is_x_major {
            bbox_min = (
                floor_subpixel_to_pixel_coord(x_min, self.subpixel_bits, true)
                    .clamp(self.viewport.x(), self.viewport.x() + self.viewport.z() - 1),
                floor_subpixel_to_pixel_coord(y_min, self.subpixel_bits, true).clamp(
                    self.viewport.y() - line_width_pixels,
                    self.viewport.y() + self.viewport.w() - 1,
                ),
            );
            bbox_max = (
                ceil_subpixel_to_pixel_coord(x_max, self.subpixel_bits, true)
                    .clamp(self.viewport.x(), self.viewport.x() + self.viewport.z() - 1),
                ceil_subpixel_to_pixel_coord(y_max, self.subpixel_bits, true).clamp(
                    self.viewport.y() - line_width_pixels,
                    self.viewport.y() + self.viewport.w() - 1,
                ),
            );
        } else {
            bbox_min = (
                floor_subpixel_to_pixel_coord(x_min, self.subpixel_bits, true).clamp(
                    self.viewport.x() - line_width_pixels,
                    self.viewport.x() + self.viewport.z() - 1,
                ),
                floor_subpixel_to_pixel_coord(y_min, self.subpixel_bits, true)
                    .clamp(self.viewport.y(), self.viewport.y() + self.viewport.w() - 1),
            );
            bbox_max = (
                ceil_subpixel_to_pixel_coord(x_max, self.subpixel_bits, true).clamp(
                    self.viewport.x() - line_width_pixels,
                    self.viewport.x() + self.viewport.z() - 1,
                ),
                ceil_subpixel_to_pixel_coord(y_max, self.subpixel_bits, true)
                    .clamp(self.viewport.y(), self.viewport.y() + self.viewport.w() - 1),
            );
        }

        self.bbox_min = bbox_min;
        self.bbox_max = bbox_max;
        self.line_width = line_width;
        self.v0 = v0;
        self.v1 = v1;

        let x_delta = if (v1 - v0).x() > 0.0 { 1 } else { -1 };
        let y_delta = if (v1 - v0).y() > 0.0 { 1 } else { -1 };

        self.cur_pos = (
            if x_delta > 0 { self.bbox_min.0 } else { self.bbox_max.0 },
            if y_delta > 0 { self.bbox_min.1 } else { self.bbox_max.1 },
        );

        self.cur_row_fragment = 0;
        self.stipple_factor = stipple_factor;
        self.stipple_pattern = stipple_pattern;
    }

    /// `SingleSampleLineRasterizer::rasterize`. Returns the number of fragment packets
    /// written.
    pub fn rasterize(
        &mut self,
        fragment_packets: &mut [FragmentPacket],
        mut depth_values: Option<&mut [f32]>,
        max_fragment_packets: usize,
    ) -> usize {
        debug_assert!(max_fragment_packets > 0);

        let half_pixel = 1i64 << (self.subpixel_bits - 1);
        let line_width = if self.line_width > 1.0 {
            (self.line_width + 0.5).floor() as i32
        } else {
            1
        };
        let is_x_major = (self.v1.x() - self.v0.x()).abs() >= (self.v1.y() - self.v0.y()).abs();
        let minor_direction: (i32, i32) = if is_x_major { (0, 1) } else { (1, 0) };
        let min_viewport_limit = if is_x_major {
            self.viewport.y()
        } else {
            self.viewport.x()
        };
        let max_viewport_limit = if is_x_major {
            self.viewport.y() + self.viewport.w()
        } else {
            self.viewport.x() + self.viewport.z()
        };

        let width_offset = (
            -(minor_direction.0 as i64) * (to_subpixel_coord_i32(line_width - 1, self.subpixel_bits) / 2),
            -(minor_direction.1 as i64) * (to_subpixel_coord_i32(line_width - 1, self.subpixel_bits) / 2),
        );
        let pa_raw = to_subpixel_vector_f(
            crate::tcu::vector::Vec2::new(self.v0.x(), self.v0.y()),
            self.subpixel_bits,
        );
        let pb_raw = to_subpixel_vector_f(
            crate::tcu::vector::Vec2::new(self.v1.x(), self.v1.y()),
            self.subpixel_bits,
        );
        let pa = (pa_raw.0 + width_offset.0, pa_raw.1 + width_offset.1);
        let pb = (pb_raw.0 + width_offset.0, pb_raw.1 + width_offset.1);
        let line = SubpixelLineSegment::new(pa, pb);

        let mut packet_ndx = 0;
        let x_delta = if (self.v1 - self.v0).x() > 0.0 { 1 } else { -1 };
        let y_delta = if (self.v1 - self.v0).y() > 0.0 { 1 } else { -1 };

        while self.cur_pos.1 <= self.bbox_max.1
            && self.cur_pos.1 >= self.bbox_min.1
            && packet_ndx < max_fragment_packets
        {
            let diamond_position = {
                let p = to_subpixel_vector_i(self.cur_pos, self.subpixel_bits);
                (p.0 + half_pixel, p.1 + half_pixel)
            };

            if does_line_segment_exit_diamond(&line, diamond_position, self.subpixel_bits) {
                let pr = diamond_position;
                let pr_f = (pr.0 as f32, pr.1 as f32);
                let pa_f = (pa.0 as f32, pa.1 as f32);
                let pb_f = (pb.0 as f32, pb.1 as f32);
                let pr_pa = (pr_f.0 - pa_f.0, pr_f.1 - pa_f.1);
                let pb_pa = (pb_f.0 - pa_f.0, pb_f.1 - pa_f.1);
                let dot = pr_pa.0 * pb_pa.0 + pr_pa.1 * pb_pa.1;
                let len_sq = pb_pa.0 * pb_pa.0 + pb_pa.1 * pb_pa.1;
                let t = dot / len_sq;

                let fragment_location = if is_x_major { self.cur_pos.1 } else { self.cur_pos.0 };
                let row_frag_begin = 0.max(min_viewport_limit - fragment_location);
                let row_frag_end = (max_viewport_limit - fragment_location).min(line_width);

                let stipple_bit = (self.stipple_counter / self.stipple_factor) % 16;
                let stipple_pass = (self.stipple_pattern & (1 << stipple_bit)) != 0;
                self.stipple_counter += 1;

                if stipple_pass {
                    while row_frag_begin + self.cur_row_fragment < row_frag_end {
                        let replication_id = row_frag_begin + self.cur_row_fragment;
                        let fragment_pos = (
                            self.cur_pos.0 + minor_direction.0 * replication_id,
                            self.cur_pos.1 + minor_direction.1 * replication_id,
                        );

                        if let Some(depth_values) = depth_values.as_deref_mut() {
                            let za = self.v0.z();
                            let zb = self.v1.z();
                            depth_values[packet_ndx * 4] = (1.0 - t) * za + t * zb;
                            depth_values[packet_ndx * 4 + 1] = 0.0;
                            depth_values[packet_ndx * 4 + 2] = 0.0;
                            depth_values[packet_ndx * 4 + 3] = 0.0;
                        }

                        {
                            // Note: in order to make consistent output with
                            // multisampled line rasterization, output "barycentric"
                            // coordinates.
                            let b0 = 1.0 - t;
                            let b1 = t;
                            let oo_sum = 1.0 / (b0 + b1);

                            fragment_packets[packet_ndx] = FragmentPacket {
                                position: IVec2::new(fragment_pos.0, fragment_pos.1),
                                coverage: get_coverage_bit(1, 0, 0, 0),
                                barycentric: [Vec4::splat(b0 * oo_sum), Vec4::splat(b1 * oo_sum), Vec4::splat(0.0)],
                            };
                            packet_ndx += 1;
                        }

                        self.cur_row_fragment += 1;

                        if packet_ndx == max_fragment_packets {
                            self.stipple_counter -= 1; // reuse the same stipple counter next time
                            return packet_ndx;
                        }
                    }

                    self.cur_row_fragment = 0;
                }
            }

            self.cur_pos.0 += x_delta;
            if self.cur_pos.0 > self.bbox_max.0 || self.cur_pos.0 < self.bbox_min.0 {
                self.cur_pos.1 += y_delta;
                self.cur_pos.0 = if x_delta > 0 { self.bbox_min.0 } else { self.bbox_max.0 };
            }
        }

        debug_assert!(packet_ndx <= max_fragment_packets);
        packet_ndx
    }
}

/// `rr::MultiSampleLineRasterizer`
///
/// Implements rasterization using fixed-point coordinates, depth interpolation and
/// perspective-correct interpolation by reusing `TriangleRasterizer` over a quad built
/// from the line's two long edges - exactly like upstream, which notes the two
/// triangles are the whole trick. Does not implement clipping or aliased (single-
/// sample) line rasterization.
pub struct MultiSampleLineRasterizer {
    num_samples: i32,
    triangle_rasterizer0: TriangleRasterizer,
    triangle_rasterizer1: TriangleRasterizer,
}

impl MultiSampleLineRasterizer {
    pub fn new(num_samples: i32, viewport: IVec4, subpixel_bits: i32) -> Self {
        let state = RasterizationState::default();
        Self {
            num_samples,
            triangle_rasterizer0: TriangleRasterizer::new(viewport, num_samples, &state, subpixel_bits),
            triangle_rasterizer1: TriangleRasterizer::new(viewport, num_samples, &state, subpixel_bits),
        }
    }

    /// `MultiSampleLineRasterizer::init`
    pub fn init(&mut self, v0: Vec4, v1: Vec4, line_width: f32) {
        // Allow creation of single-sampled rasterizer objects but do not allow using
        // them.
        debug_assert!(self.num_samples > 1);

        let line_vec = (v1.x() - v0.x(), v1.y() - v0.y());
        let len = (line_vec.0 * line_vec.0 + line_vec.1 * line_vec.1).sqrt();
        let normal2 = (-line_vec.1 / len, line_vec.0 / len);
        let normal4 = Vec4::new(normal2.0, normal2.1, 0.0, 0.0);
        let offset = line_width / 2.0;

        let p0 = v0 + normal4 * offset;
        let p1 = v0 - normal4 * offset;
        let p2 = v1 - normal4 * offset;
        let p3 = v1 + normal4 * offset;

        // Edge 0 -> 1 is always along the line and edge 1 -> 2 is at a 90 degree
        // angle to the line.
        self.triangle_rasterizer0.init(p0, p3, p2);
        self.triangle_rasterizer1.init(p2, p1, p0);
    }

    /// `MultiSampleLineRasterizer::rasterize`. Returns the number of fragment packets
    /// written.
    pub fn rasterize(
        &mut self,
        fragment_packets: &mut [FragmentPacket],
        mut depth_values: Option<&mut [f32]>,
        max_fragment_packets: usize,
    ) -> usize {
        debug_assert!(max_fragment_packets > 0);

        let mut num_packets_rasterized =
            self.triangle_rasterizer0
                .rasterize(fragment_packets, depth_values.as_deref_mut(), max_fragment_packets);

        // Remove the 3rd barycentric value and rebalance. Lines do not have a
        // non-zero barycentric value at index 2.
        for packet in fragment_packets.iter_mut().take(num_packets_rasterized) {
            let removed = packet.barycentric[2];
            packet.barycentric[2] = Vec4::splat(0.0);
            packet.barycentric[1] = packet.barycentric[1] + removed;
        }

        if num_packets_rasterized == max_fragment_packets {
            return num_packets_rasterized;
        }

        {
            let (_, next_fragment_packets) = fragment_packets.split_at_mut(num_packets_rasterized);
            let next_depth_values =
                depth_values.map(|d| &mut d[4 * num_packets_rasterized * self.num_samples as usize..]);

            let num_packets_rasterized2 = self.triangle_rasterizer1.rasterize(
                next_fragment_packets,
                next_depth_values,
                max_fragment_packets - num_packets_rasterized,
            );

            for packet in next_fragment_packets.iter_mut().take(num_packets_rasterized2) {
                let removed = packet.barycentric[2];
                packet.barycentric[2] = Vec4::splat(0.0);
                packet.barycentric[1] = packet.barycentric[1] + removed;
                // The edge has a reversed direction.
                packet.barycentric.swap(0, 1);
            }

            num_packets_rasterized += num_packets_rasterized2;
        }

        num_packets_rasterized
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rr::render_state::ViewportOrientation;

    fn default_state() -> RasterizationState {
        RasterizationState {
            viewport_orientation: Some(ViewportOrientation::LowerLeft),
            ..RasterizationState::default()
        }
    }

    /// A triangle covering the whole 4x4 viewport should produce exactly 4 fragment
    /// packets (2x2 each) with full coverage on all 4 lanes, single-sampled.
    #[test]
    fn full_viewport_triangle_covers_every_pixel() {
        let viewport = IVec4::new(0, 0, 4, 4);
        let state = default_state();
        let mut rast = TriangleRasterizer::new(viewport, 1, &state, 8);

        // A large CCW triangle enclosing the whole viewport.
        rast.init(
            Vec4::new(-10.0, -10.0, 0.5, 1.0),
            Vec4::new(20.0, -10.0, 0.5, 1.0),
            Vec4::new(-10.0, 20.0, 0.5, 1.0),
        );

        let mut packets = vec![
            FragmentPacket {
                position: IVec2::new(0, 0),
                coverage: 0,
                barycentric: [Vec4::splat(0.0); 3],
            };
            4
        ];
        let n = rast.rasterize(&mut packets, None, 4);
        assert_eq!(n, 4);
        for p in &packets {
            assert_eq!(p.coverage, 0b1111);
        }
    }

    #[test]
    fn winding_determines_visible_face() {
        let viewport = IVec4::new(0, 0, 4, 4);
        let state = default_state();

        let mut ccw = TriangleRasterizer::new(viewport, 1, &state, 8);
        ccw.init(
            Vec4::new(0.0, 0.0, 0.5, 1.0),
            Vec4::new(4.0, 0.0, 0.5, 1.0),
            Vec4::new(0.0, 4.0, 0.5, 1.0),
        );
        assert_eq!(ccw.visible_face(), FaceType::Front);

        let mut cw = TriangleRasterizer::new(viewport, 1, &state, 8);
        cw.init(
            Vec4::new(0.0, 0.0, 0.5, 1.0),
            Vec4::new(0.0, 4.0, 0.5, 1.0),
            Vec4::new(4.0, 0.0, 0.5, 1.0),
        );
        assert_eq!(cw.visible_face(), FaceType::Back);
    }

    #[test]
    fn depth_interpolates_linearly_across_a_flat_triangle() {
        let viewport = IVec4::new(0, 0, 4, 4);
        let state = default_state();
        let mut rast = TriangleRasterizer::new(viewport, 1, &state, 8);
        // All three vertices at the same depth -> every fragment must report that
        // depth exactly, with w=1 (no perspective skew).
        rast.init(
            Vec4::new(-10.0, -10.0, 0.75, 1.0),
            Vec4::new(20.0, -10.0, 0.75, 1.0),
            Vec4::new(-10.0, 20.0, 0.75, 1.0),
        );

        let mut packets = vec![
            FragmentPacket {
                position: IVec2::new(0, 0),
                coverage: 0,
                barycentric: [Vec4::splat(0.0); 3],
            };
            4
        ];
        let mut depths = vec![0f32; 16];
        let n = rast.rasterize(&mut packets, Some(&mut depths), 4);
        assert_eq!(n, 4);
        for &d in &depths {
            assert!((d - 0.75).abs() < 1e-5, "expected 0.75, got {d}");
        }
    }

    #[test]
    fn multisample_coverage_has_more_live_samples_near_triangle_center() {
        let viewport = IVec4::new(0, 0, 4, 4);
        let state = default_state();
        let mut rast = TriangleRasterizer::new(viewport, 4, &state, 8);
        // A diagonal triangle that only covers part of the viewport, so some pixel
        // quads are partially covered under multisampling.
        rast.init(
            Vec4::new(0.0, 0.0, 0.5, 1.0),
            Vec4::new(4.0, 0.0, 0.5, 1.0),
            Vec4::new(0.0, 4.0, 0.5, 1.0),
        );

        let mut packets = vec![
            FragmentPacket {
                position: IVec2::new(0, 0),
                coverage: 0,
                barycentric: [Vec4::splat(0.0); 3],
            };
            4
        ];
        let n = rast.rasterize(&mut packets, None, 4);
        assert!(n > 0);
        // At least one packet should have partial (not full, not zero) coverage for
        // some lane, proving the multisample path evaluated more than one sample.
        let any_partial = packets[..n].iter().any(|p| {
            (0..4).any(|frag| {
                let bits = get_coverage_fragment_sample_bits(4, frag % 2, frag / 2);
                let live = p.coverage & bits;
                live != 0 && live != bits
            })
        });
        assert!(
            any_partial,
            "expected at least one partially-covered pixel under 4x MSAA on a diagonal edge"
        );
    }

    #[test]
    fn single_sample_horizontal_line_rasterizes_expected_pixel_count() {
        let viewport = IVec4::new(0, 0, 10, 10);
        let mut rast = SingleSampleLineRasterizer::new(viewport, 8);
        rast.init(
            Vec4::new(1.5, 2.5, 0.0, 1.0),
            Vec4::new(6.5, 2.5, 0.0, 1.0),
            1.0,
            1,
            0xFFFF,
        );

        let mut packets = vec![
            FragmentPacket {
                position: IVec2::new(0, 0),
                coverage: 0,
                barycentric: [Vec4::splat(0.0); 3],
            };
            32
        ];
        let n = rast.rasterize(&mut packets, None, 32);
        // A horizontal line from x=1.5 to x=6.5 through pixel row y=2 covers 5 pixel
        // centres (2,3,4,5,6 at y=2).
        assert_eq!(n, 5);
        for p in &packets[..n] {
            assert_eq!(p.position.y(), 2);
        }
    }

    #[test]
    fn multisample_line_rasterizer_produces_a_quad_of_fragments() {
        let viewport = IVec4::new(0, 0, 10, 10);
        let mut rast = MultiSampleLineRasterizer::new(4, viewport, 8);
        rast.init(Vec4::new(1.0, 5.0, 0.0, 1.0), Vec4::new(8.0, 5.0, 0.0, 1.0), 1.0);

        let mut packets = vec![
            FragmentPacket {
                position: IVec2::new(0, 0),
                coverage: 0,
                barycentric: [Vec4::splat(0.0); 3],
            };
            64
        ];
        let n = rast.rasterize(&mut packets, None, 64);
        assert!(n > 0);
        // Every emitted fragment's 3rd barycentric component must be exactly zero -
        // that is the "lines never use index 2" rebalancing this function performs.
        for p in &packets[..n] {
            for lane in 0..4 {
                assert_eq!(p.barycentric[2][lane], 0.0);
            }
        }
    }
}
