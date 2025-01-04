// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuRasterizationVerifier.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, covering triangle/point/line
// rasterization and interpolation at any sample count (narrow and wide lines,
// single-sample and multisample). Upstream's file is ~3600 lines covering triangles,
// lines (several rounding/width/multisample variants) and points, plus
// colour-interpolation verification for all three. What's ported:
// `calculateTriangleCoverage` + `verifyTriangleGroupRasterization` (triangle
// rasterization, already multisample-aware via `args.numSamples` internally),
// `calcTriangleInterpolationWeights` +
// `verifyTriangleGroupInterpolationWithInterpolator<TriangleInterpolator>` (triangle
// interpolation, i.e. upstream's public `verifyTriangleGroupInterpolation` entry point,
// also already multisample-aware), `verifyPointGroupRasterization`/
// `verifyMultisamplePointGroupRasterization` (point rasterization - needs no new
// coverage math at all, see that function's own doc comment, and works at any sample
// count by forwarding to the triangle rasterizer above), `verifySinglesampleLineGroupRasterization`
// (single-sample line rasterization, narrow and wide - `rasterize_single_sample_line`
// below), `verifyMultisampleLineGroupRasterization` restricted to this port's own
// calling convention (`verify_multisample_line_group_rasterization` below - "two
// triangles", the same trick point rasterization already uses, reusing the triangle
// rasterizer unchanged), both single-sample line interpolation paths
// (`verifyLineGroupPixelIndependentInterpolation`, narrow lines called with either
// weight equation, and `verifySinglesampleWideLineGroupInterpolation`'s "root fragment,
// then replicated" model - `verify_single_sample_wide_line_group_interpolation` below),
// and `verifyMultisampleLineGroupInterpolation` restricted to this port's own calling
// convention (`verify_multisample_line_group_interpolation` below - every caller here
// passes `strictMode = true`, so only its `MultisampleLineInterpolator` path is live;
// the non-strict `TriangleInterpolator`-then-line-interpolator fallback is dead code for
// this port and is not ported). `verifyTriangulatedLineGroupInterpolation` (a
// `strictMode`/`allowBresenhamForNonStrictLines`-parameterized wrapper around the same
// function, used by Vulkan-side callers this port has no equivalent of) is not ported.
//
// `verifyTriangleGroupRasterization`'s `coverageMap` is a `tcu::TextureLevel` upstream
// (an `R`/`UNSIGNED_INT8` texture used purely as a `width*height` scratch array); ported
// here as a plain `Vec<CoverageType>` instead; this is an internal implementation detail
// with no observable effect; this project has no caller that reads a coverage map back.
// Likewise there is no `TestLog`/image-stash output (see `tcu::image_compare`'s own note
// on the same point) - the result carries the missing/unexpected pixel counts instead,
// which is what a caller puts in the failure description.

use crate::tcu::float::Float32;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::{IVec2, IVec3, IVec4, Vec2, Vec4};

/// `tcu::VerificationMode`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum VerificationMode {
    Strict,
    Weak,
    Weaker,
    Smooth,
}

/// `tcu::CoverageType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum CoverageType {
    Full,
    Partial,
    None,
}

/// `tcu::RasterizationArguments`
#[derive(Clone, Copy, Debug)]
pub struct RasterizationArguments {
    pub num_samples: i32,
    pub subpixel_bits: i32,
    pub red_bits: i32,
    pub green_bits: i32,
    pub blue_bits: i32,
}

/// `TriangleSceneSpec::SceneTriangle`
#[derive(Clone, Copy, Debug)]
pub struct SceneTriangle {
    pub positions: [Vec4; 3],
    /// Only read by `verify_triangle_group_interpolation`; every rasterization-only
    /// caller leaves these at `new`'s white default, matching upstream's own
    /// `verifyTriangleGroupRasterization` (which never reads `colors` either, see its
    /// own doc comment: "Triangle colors are not used. The triangle is expected to be
    /// white.").
    pub colors: [Vec4; 3],
    /// Is the edge `i -> i+1` shared with another scene triangle.
    pub shared_edge: [bool; 3],
}

impl SceneTriangle {
    pub fn new(p0: Vec4, p1: Vec4, p2: Vec4) -> Self {
        Self {
            positions: [p0, p1, p2],
            colors: [Vec4::new(1.0, 1.0, 1.0, 1.0); 3],
            shared_edge: [false; 3],
        }
    }

    /// `TriangleInterpolationTest::extractTriangles` - a scene triangle carrying its own
    /// per-vertex colour, for `verify_triangle_group_interpolation`.
    pub fn with_colors(p0: Vec4, p1: Vec4, p2: Vec4, c0: Vec4, c1: Vec4, c2: Vec4) -> Self {
        Self {
            positions: [p0, p1, p2],
            colors: [c0, c1, c2],
            shared_edge: [false; 3],
        }
    }
}

/// `TriangleSceneSpec`
#[derive(Clone, Debug, Default)]
pub struct TriangleSceneSpec {
    pub triangles: Vec<SceneTriangle>,
}

/// `verifyTriangleGroupRasterization`'s return value plus the counts its log would
/// otherwise have printed - see the file header for why there is no log/stash here.
#[derive(Clone, Copy, Debug)]
pub struct RasterizationVerifyResult {
    pub ok: bool,
    pub missing_pixels: i32,
    pub unexpected_pixels: i32,
}

// --- int64 2-vector, used only for the subpixel edge-intersection math below. A
// plain tuple + free functions, rather than growing `tcu::vector::Vector` for a type
// used nowhere else (see the "on demand" rule at the top of `tcu/mod.rs`). ---
pub(crate) type I64Vec2 = (i64, i64);

fn i64_sub(a: I64Vec2, b: I64Vec2) -> I64Vec2 {
    (a.0 - b.0, a.1 - b.1)
}

fn i64_cross(a: I64Vec2, b: I64Vec2) -> i64 {
    a.0 * b.1 - a.1 * b.0
}

// --- double-precision 2-vector, used only for the broad triangle/pixel intersection
// check below. Same rationale as `I64Vec2`. ---
type DVec2 = (f64, f64);

fn d_sub(a: DVec2, b: DVec2) -> DVec2 {
    (a.0 - b.0, a.1 - b.1)
}

fn d_cross(a: DVec2, b: DVec2) -> f64 {
    a.0 * b.1 - a.1 * b.0
}

fn d_length_squared(v: DVec2) -> f64 {
    v.0 * v.0 + v.1 * v.1
}

/// `lineLineIntersect` - do the two (infinite-precision, integer) line segments
/// intersect. "Lines do not intersect if the other line's endpoints are on the same
/// side, otherwise they do."
fn line_line_intersect(line0_beg: I64Vec2, line0_end: I64Vec2, line1_beg: I64Vec2, line1_end: I64Vec2) -> bool {
    {
        let line = i64_sub(line0_end, line0_beg);
        let v0 = i64_sub(line1_beg, line0_beg);
        let v1 = i64_sub(line1_end, line0_beg);
        let cross_product0 = i64_cross(line, v0);
        let cross_product1 = i64_cross(line, v1);
        if (cross_product0 < 0 && cross_product1 < 0) || (cross_product0 > 0 && cross_product1 > 0) {
            return false;
        }
    }
    {
        let line = i64_sub(line1_end, line1_beg);
        let v0 = i64_sub(line0_beg, line1_beg);
        let v1 = i64_sub(line0_end, line1_beg);
        let cross_product0 = i64_cross(line, v0);
        let cross_product1 = i64_cross(line, v1);
        if (cross_product0 < 0 && cross_product1 < 0) || (cross_product0 > 0 && cross_product1 > 0) {
            return false;
        }
    }
    true
}

/// `isTriangleClockwise`
fn is_triangle_clockwise(p0: Vec4, p1: Vec4, p2: Vec4) -> bool {
    let u = Vec2::new(p1.x() / p1.w() - p0.x() / p0.w(), p1.y() / p1.w() - p0.y() / p0.w());
    let v = Vec2::new(p2.x() / p2.w() - p0.x() / p0.w(), p2.y() / p2.w() - p0.y() / p0.w());
    let cross_product = u.x() * v.y() - u.y() * v.x();
    cross_product > 0.0
}

/// `compareColors`
fn compare_colors(color_a: RGBA, color_b: RGBA, red_bits: i32, green_bits: i32, blue_bits: i32) -> bool {
    let threshold_red = 1 << (8 - red_bits);
    let threshold_green = 1 << (8 - green_bits);
    let threshold_blue = 1 << (8 - blue_bits);

    (color_a.get_red() - color_b.get_red()).abs() <= threshold_red
        && (color_a.get_green() - color_b.get_green()).abs() <= threshold_green
        && (color_a.get_blue() - color_b.get_blue()).abs() <= threshold_blue
}

/// `pixelNearLineSegment` - "near" means the distance from the line to the pixel
/// center is less than `2 * pixel_max_radius` (`pixel_max_radius = sqrt(2) / 2`), and
/// the pixel is between the segment's endpoints (within the same tolerance).
fn pixel_near_line_segment(pixel: IVec2, p0: Vec2, p1: Vec2) -> bool {
    let pixel_center = Vec2::new(pixel.x() as f32 + 0.5, pixel.y() as f32 + 0.5);
    let max_pixel_distance = 1.414;
    let max_pixel_distance_squared = 2.0;

    {
        let line = p1 - p0;
        let v = pixel_center - p0;
        let cross_product = line.x() * v.y() - line.y() * v.x();
        if cross_product * cross_product > max_pixel_distance_squared * length_squared(line) {
            return false;
        }
    }
    {
        let max_distance = length(p1 - p0) + max_pixel_distance;
        if length(pixel_center - p0) > max_distance {
            return false;
        }
        if length(pixel_center - p1) > max_distance {
            return false;
        }
    }
    true
}

fn length_squared(v: Vec2) -> f32 {
    v.x() * v.x() + v.y() * v.y()
}

fn length(v: Vec2) -> f32 {
    length_squared(v).sqrt()
}

fn triangle_screen_space(triangle: &SceneTriangle, viewport_size: IVec2) -> [Vec2; 3] {
    std::array::from_fn(|i| {
        let p = triangle.positions[i];
        let ndc = Vec2::new(p.x() / p.w(), p.y() / p.w());
        Vec2::new(
            (ndc.x() + 1.0) * 0.5 * viewport_size.x() as f32,
            (ndc.y() + 1.0) * 0.5 * viewport_size.y() as f32,
        )
    })
}

/// `pixelOnlyOnASharedEdge`
fn pixel_only_on_a_shared_edge(pixel: IVec2, triangle: &SceneTriangle, viewport_size: IVec2) -> bool {
    if !(triangle.shared_edge[0] || triangle.shared_edge[1] || triangle.shared_edge[2]) {
        return false;
    }

    let screen_space = triangle_screen_space(triangle, viewport_size);
    let pixel_on_edge0 = pixel_near_line_segment(pixel, screen_space[0], screen_space[1]);
    let pixel_on_edge1 = pixel_near_line_segment(pixel, screen_space[1], screen_space[2]);
    let pixel_on_edge2 = pixel_near_line_segment(pixel, screen_space[2], screen_space[0]);

    // If the pixel is on multiple edges, return false.
    if pixel_on_edge0 && !pixel_on_edge1 && !pixel_on_edge2 {
        return triangle.shared_edge[0];
    }
    if !pixel_on_edge0 && pixel_on_edge1 && !pixel_on_edge2 {
        return triangle.shared_edge[1];
    }
    if !pixel_on_edge0 && !pixel_on_edge1 && pixel_on_edge2 {
        return triangle.shared_edge[2];
    }
    false
}

/// `getTriangleAABB`
fn get_triangle_aabb(triangle: &SceneTriangle, viewport_size: IVec2) -> IVec4 {
    let screen_space = triangle_screen_space(triangle, viewport_size);

    let min_x = screen_space[0].x().min(screen_space[1].x()).min(screen_space[2].x());
    let min_y = screen_space[0].y().min(screen_space[1].y()).min(screen_space[2].y());
    let max_x = screen_space[0].x().max(screen_space[1].x()).max(screen_space[2].x());
    let max_y = screen_space[0].y().max(screen_space[1].y()).max(screen_space[2].y());

    IVec4::new(
        min_x.floor() as i32,
        min_y.floor() as i32,
        max_x.ceil() as i32,
        max_y.ceil() as i32,
    )
}

/// `calculateTriangleCoverage` - the coverage of a triangle at a given pixel. If
/// `multisample` is false, the pixel center is compared against the triangle; if
/// true, the whole pixel area is. The triangle must not be z-clipped.
fn calculate_triangle_coverage(
    p0: Vec4,
    p1: Vec4,
    p2: Vec4,
    pixel: IVec2,
    viewport_size: IVec2,
    subpixel_bits: i32,
    multisample: bool,
) -> CoverageType {
    let num_sub_pixels: u64 = 1u64 << subpixel_bits;
    let pixel_hit_box_size: u64 = if multisample { num_sub_pixels } else { 5 }; // 5 = ceil(6 * sqrt(2) / 2), a 3-subpixel fuzz around the pixel center

    let order = is_triangle_clockwise(p0, p1, p2);
    let ordered = [p0, if order { p1 } else { p2 }, if order { p2 } else { p1 }];
    let ndc: [Vec2; 3] =
        std::array::from_fn(|i| Vec2::new(ordered[i].x() / ordered[i].w(), ordered[i].y() / ordered[i].w()));
    let screen_space: [Vec2; 3] = std::array::from_fn(|i| {
        Vec2::new(
            (ndc[i].x() + 1.0) * 0.5 * viewport_size.x() as f32,
            (ndc[i].y() + 1.0) * 0.5 * viewport_size.y() as f32,
        )
    });

    // Broad bounding box - pixel check
    {
        let min_x = screen_space[0].x().min(screen_space[1].x()).min(screen_space[2].x());
        let min_y = screen_space[0].y().min(screen_space[1].y()).min(screen_space[2].y());
        let max_x = screen_space[0].x().max(screen_space[1].x()).max(screen_space[2].x());
        let max_y = screen_space[0].y().max(screen_space[1].y()).max(screen_space[2].y());

        if pixel.x() as f32 > max_x + 1.0
            || pixel.y() as f32 > max_y + 1.0
            || (pixel.x() as f32) < min_x - 1.0
            || (pixel.y() as f32) < min_y - 1.0
        {
            return CoverageType::None;
        }
    }

    // Broad triangle - pixel area intersection
    {
        let pixel_center: DVec2 = (
            pixel.x() as f64 * num_sub_pixels as f64 + num_sub_pixels as f64 / 2.0,
            pixel.y() as f64 * num_sub_pixels as f64 + num_sub_pixels as f64 / 2.0,
        );
        let tri_sub_pixel: [DVec2; 3] = std::array::from_fn(|i| {
            (
                screen_space[i].x() as f64 * num_sub_pixels as f64,
                screen_space[i].y() as f64 * num_sub_pixels as f64,
            )
        });

        let mut inside_all_edges = true;
        for vtx_ndx in 0..3 {
            let other_vtx_ndx = (vtx_ndx + 1) % 3;
            let max_pixel_distance_squared = (pixel_hit_box_size * pixel_hit_box_size) as f64;
            let edge = d_sub(tri_sub_pixel[other_vtx_ndx], tri_sub_pixel[vtx_ndx]);
            let v = d_sub(pixel_center, tri_sub_pixel[vtx_ndx]);
            let cross_product = d_cross(edge, v);

            if cross_product < 0.0
                && cross_product * cross_product > max_pixel_distance_squared * d_length_squared(edge)
            {
                return CoverageType::None;
            }
            if cross_product < 0.0
                || cross_product * cross_product < max_pixel_distance_squared * d_length_squared(edge)
            {
                inside_all_edges = false;
            }
        }

        if inside_all_edges {
            return CoverageType::Full;
        }
    }

    // Accurate intersection for edge pixels. In multisampling, the sample points can
    // be anywhere in the pixel; in single sampling only at the center.
    {
        let n = num_sub_pixels as i64;
        let px = pixel.x() as i64;
        let py = pixel.y() as i64;

        let pixel_corners: [I64Vec2; 4] = [
            (px * n, py * n),
            ((px + 1) * n, py * n),
            ((px + 1) * n, (py + 1) * n),
            (px * n, (py + 1) * n),
        ];
        let pixel_center_corners: [I64Vec2; 4] = [
            (px * n + n / 2 - 3, py * n + n / 2 - 3),
            (px * n + n / 2 + 3, py * n + n / 2 - 3),
            (px * n + n / 2 + 3, py * n + n / 2 + 3),
            (px * n + n / 2 - 3, py * n + n / 2 + 3),
        ];

        let tri_floor: [I64Vec2; 3] = std::array::from_fn(|i| {
            (
                (screen_space[i].x() * num_sub_pixels as f32).floor() as i64,
                (screen_space[i].y() * num_sub_pixels as f32).floor() as i64,
            )
        });
        let tri_ceil: [I64Vec2; 3] = std::array::from_fn(|i| {
            (
                (screen_space[i].x() * num_sub_pixels as f32).ceil() as i64,
                (screen_space[i].y() * num_sub_pixels as f32).ceil() as i64,
            )
        });

        let corners = if multisample {
            &pixel_corners
        } else {
            &pixel_center_corners
        };

        // Test if any edge (with any rounding) intersects the pixel (boundary). If it
        // does, Partial; if not, fully inside or outside.
        for edge_ndx in 0..3 {
            let next_edge_ndx = (edge_ndx + 1) % 3;
            for start_rounding in 0..4 {
                for end_rounding in 0..4 {
                    let start_pos = (
                        if start_rounding & 0x01 != 0 {
                            tri_floor[edge_ndx].0
                        } else {
                            tri_ceil[edge_ndx].0
                        },
                        if start_rounding & 0x02 != 0 {
                            tri_floor[edge_ndx].1
                        } else {
                            tri_ceil[edge_ndx].1
                        },
                    );
                    let end_pos = (
                        if end_rounding & 0x01 != 0 {
                            tri_floor[next_edge_ndx].0
                        } else {
                            tri_ceil[next_edge_ndx].0
                        },
                        if end_rounding & 0x02 != 0 {
                            tri_floor[next_edge_ndx].1
                        } else {
                            tri_ceil[next_edge_ndx].1
                        },
                    );

                    for pixel_edge_ndx in 0..4 {
                        let pixel_edge_end = (pixel_edge_ndx + 1) % 4;
                        if line_line_intersect(start_pos, end_pos, corners[pixel_edge_ndx], corners[pixel_edge_end]) {
                            return CoverageType::Partial;
                        }
                    }
                }
            }
        }

        // fully inside or outside
        for edge_ndx in 0..3 {
            let next_edge_ndx = (edge_ndx + 1) % 3;
            let start_pos = tri_floor[edge_ndx];
            let end_pos = tri_floor[next_edge_ndx];
            let edge = i64_sub(end_pos, start_pos);
            let v = i64_sub(corners[0], end_pos);
            let cross_product = i64_cross(edge, v);

            // a corner of the pixel is outside => "fully inside" is impossible
            if cross_product < 0 {
                return CoverageType::None;
            }
        }

        CoverageType::Full
    }
}

/// `calculateUnderestimateLineCoverage`
pub fn calculate_underestimate_line_coverage(
    p0: Vec4,
    p1: Vec4,
    line_width: f32,
    pixel: IVec2,
    viewport_size: IVec2,
) -> CoverageType {
    let p = Vec2::new(p0.x(), p0.y());
    let q = Vec2::new(p1.x(), p1.y());
    let pq = Vec2::new(p1.x() - p0.x(), p1.y() - p0.y());
    let pqn = normalize2(pq);
    let lw = Vec2::new(0.5 * line_width * pqn.x(), 0.5 * line_width * pqn.y());
    let n = Vec2::new(lw.y(), -lw.x());
    let vp = Vec2::new(viewport_size.x() as f32, viewport_size.y() as f32);
    let a = Vec2::new(
        0.5 * (p.x() + 1.0) * vp.x() + n.x(),
        0.5 * (p.y() + 1.0) * vp.y() + n.y(),
    );
    let b = Vec2::new(
        0.5 * (p.x() + 1.0) * vp.x() - n.x(),
        0.5 * (p.y() + 1.0) * vp.y() - n.y(),
    );
    let c = Vec2::new(
        0.5 * (q.x() + 1.0) * vp.x() - n.x(),
        0.5 * (q.y() + 1.0) * vp.y() - n.y(),
    );
    let ba = Vec2::new(b.x() - a.x(), b.y() - a.y());
    let bc = Vec2::new(b.x() - c.x(), b.y() - c.y());
    let det = ba.x() * bc.y() - ba.y() * bc.x();
    let mut within = 0;

    if det != 0.0 {
        for corner_ndx in 0..4 {
            let pixel_corner_offset_x = if corner_ndx & 1 != 0 { 1 } else { 0 };
            let pixel_corner_offset_y = if corner_ndx & 2 != 0 { 1 } else { 0 };
            let f = Vec2::new(
                (pixel.x() + pixel_corner_offset_x) as f32,
                (pixel.y() + pixel_corner_offset_y) as f32,
            );
            let bf = Vec2::new(b.x() - f.x(), b.y() - f.y());
            let alpha = (bf.x() * bc.y() - bc.x() * bf.y()) / det;
            let beta = (ba.x() * bf.y() - bf.x() * ba.y()) / det;
            let corner_within = (0.0..=1.0).contains(&alpha) && (0.0..=1.0).contains(&beta);

            if corner_within {
                within += 1;
            }
        }
    }

    match within {
        0 => CoverageType::None,
        4 => CoverageType::Full,
        _ => CoverageType::Partial,
    }
}

/// `calculateUnderestimateTriangleCoverage`
pub fn calculate_underestimate_triangle_coverage(
    p0: Vec4,
    p1: Vec4,
    p2: Vec4,
    pixel: IVec2,
    subpixel_bits: i32,
    viewport_size: IVec2,
) -> CoverageType {
    let num_sub_pixels: u64 = 1u64 << subpixel_bits;

    let order = is_triangle_clockwise(p0, p1, p2);
    let ordered = [p0, if order { p1 } else { p2 }, if order { p2 } else { p1 }];
    let ndc: [Vec2; 3] =
        std::array::from_fn(|i| Vec2::new(ordered[i].x() / ordered[i].w(), ordered[i].y() / ordered[i].w()));
    let screen_space: [Vec2; 3] = std::array::from_fn(|i| {
        Vec2::new(
            (ndc[i].x() + 1.0) * 0.5 * viewport_size.x() as f32,
            (ndc[i].y() + 1.0) * 0.5 * viewport_size.y() as f32,
        )
    });

    // Broad bounding box - pixel check
    {
        let min_x = screen_space[0].x().min(screen_space[1].x()).min(screen_space[2].x());
        let min_y = screen_space[0].y().min(screen_space[1].y()).min(screen_space[2].y());
        let max_x = screen_space[0].x().max(screen_space[1].x()).max(screen_space[2].x());
        let max_y = screen_space[0].y().max(screen_space[1].y()).max(screen_space[2].y());

        if pixel.x() as f32 > max_x + 1.0
            || pixel.y() as f32 > max_y + 1.0
            || (pixel.x() as f32) < min_x - 1.0
            || (pixel.y() as f32) < min_y - 1.0
        {
            return CoverageType::None;
        }
    }

    // Accurate intersection for edge pixels
    let n = num_sub_pixels as i64;
    let px = pixel.x() as i64;
    let py = pixel.y() as i64;

    let pixel_corners: [I64Vec2; 4] = [
        (px * n, py * n),
        ((px + 1) * n, py * n),
        ((px + 1) * n, (py + 1) * n),
        (px * n, (py + 1) * n),
    ];

    let tri_floor: [I64Vec2; 3] = std::array::from_fn(|i| {
        (
            (screen_space[i].x() * num_sub_pixels as f32).floor() as i64,
            (screen_space[i].y() * num_sub_pixels as f32).floor() as i64,
        )
    });
    let tri_ceil: [I64Vec2; 3] = std::array::from_fn(|i| {
        (
            (screen_space[i].x() * num_sub_pixels as f32).ceil() as i64,
            (screen_space[i].y() * num_sub_pixels as f32).ceil() as i64,
        )
    });

    for edge_ndx in 0..3 {
        let next_edge_ndx = (edge_ndx + 1) % 3;
        for start_rounding in 0..4 {
            for end_rounding in 0..4 {
                let start_pos = (
                    if start_rounding & 0x01 != 0 {
                        tri_floor[edge_ndx].0
                    } else {
                        tri_ceil[edge_ndx].0
                    },
                    if start_rounding & 0x02 != 0 {
                        tri_floor[edge_ndx].1
                    } else {
                        tri_ceil[edge_ndx].1
                    },
                );
                let end_pos = (
                    if end_rounding & 0x01 != 0 {
                        tri_floor[next_edge_ndx].0
                    } else {
                        tri_ceil[next_edge_ndx].0
                    },
                    if end_rounding & 0x02 != 0 {
                        tri_floor[next_edge_ndx].1
                    } else {
                        tri_ceil[next_edge_ndx].1
                    },
                );

                for pixel_edge_ndx in 0..4 {
                    let pixel_edge_end = (pixel_edge_ndx + 1) % 4;
                    if line_line_intersect(
                        start_pos,
                        end_pos,
                        pixel_corners[pixel_edge_ndx],
                        pixel_corners[pixel_edge_end],
                    ) {
                        return CoverageType::Partial;
                    }
                }
            }
        }
    }

    // fully inside or outside
    for edge_ndx in 0..3 {
        let next_edge_ndx = (edge_ndx + 1) % 3;
        let edge = i64_sub(tri_floor[next_edge_ndx], tri_floor[edge_ndx]);
        let v = i64_sub(pixel_corners[0], tri_floor[next_edge_ndx]);
        if i64_cross(edge, v) < 0 {
            return CoverageType::None;
        }
    }

    CoverageType::Full
}

/// `verifyTriangleGroupRasterization`
pub fn verify_triangle_group_rasterization(
    surface: &Surface,
    scene: &TriangleSceneSpec,
    args: &RasterizationArguments,
    mode: VerificationMode,
) -> RasterizationVerifyResult {
    verify_triangle_group_rasterization_for_lines(surface, scene, args, mode, false)
}

/// `verifyTriangleGroupRasterization` with its `vulkanLinesTest` argument: a partially covered pixel then has to have a fully covered
/// pixel next to it that the reference gives some coverage to.
pub(crate) fn verify_triangle_group_rasterization_for_lines(
    surface: &Surface,
    scene: &TriangleSceneSpec,
    args: &RasterizationArguments,
    mode: VerificationMode,
    vulkan_lines_test: bool,
) -> RasterizationVerifyResult {
    let background_color = RGBA::new(0, 0, 0, 255);
    let triangle_color = RGBA::new(255, 255, 255, 255);
    const WEAK_VERIFICATION_THRESHOLD: i32 = 10;
    const WEAKER_VERIFICATION_THRESHOLD: i32 = 25;
    let multisampled = args.num_samples != 0;
    let viewport_size = IVec2::new(surface.get_width(), surface.get_height());
    let mut missing_pixels = 0;
    let mut unexpected_pixels = 0;

    // At high subpixel-bit counts we might overflow; check at a lower, less strict
    // count instead (this may produce false positives, per upstream's own comment).
    let subpixel_bits = args.subpixel_bits.clamp(0, 16);

    let width = surface.get_width();
    let height = surface.get_height();
    let mut coverage_map = vec![CoverageType::None; (width as usize) * (height as usize)];
    let idx = |x: i32, y: i32| (y as usize) * (width as usize) + (x as usize);

    for (tri_ndx, triangle) in scene.triangles.iter().enumerate() {
        let aabb = get_triangle_aabb(triangle, viewport_size);

        for y in aabb.y().max(0)..=aabb.w().min(height - 1) {
            for x in aabb.x().max(0)..=aabb.z().min(width - 1) {
                if coverage_map[idx(x, y)] == CoverageType::Full {
                    continue;
                }

                let coverage = calculate_triangle_coverage(
                    triangle.positions[0],
                    triangle.positions[1],
                    triangle.positions[2],
                    IVec2::new(x, y),
                    viewport_size,
                    subpixel_bits,
                    multisampled,
                );

                match coverage {
                    CoverageType::Full => coverage_map[idx(x, y)] = CoverageType::Full,
                    CoverageType::Partial => {
                        // Sharing an edge with another triangle? There should always be
                        // one, but the pixel in the other triangle might be on multiple
                        // edges, some not shared, in which case coverage cannot be
                        // determined; assume full coverage if the pixel is only on a
                        // shared edge in the shared triangle too.
                        let mut result_coverage = CoverageType::Partial;
                        if pixel_only_on_a_shared_edge(IVec2::new(x, y), triangle, viewport_size) {
                            let friend_found = scene.triangles.iter().enumerate().any(|(friend_ndx, friend)| {
                                friend_ndx != tri_ndx
                                    && calculate_triangle_coverage(
                                        friend.positions[0],
                                        friend.positions[1],
                                        friend.positions[2],
                                        IVec2::new(x, y),
                                        viewport_size,
                                        subpixel_bits,
                                        multisampled,
                                    ) != CoverageType::None
                                    && pixel_only_on_a_shared_edge(IVec2::new(x, y), friend, viewport_size)
                            });
                            if friend_found {
                                result_coverage = CoverageType::Full;
                            }
                        }
                        coverage_map[idx(x, y)] = result_coverage;
                    }
                    CoverageType::None => {}
                }
            }
        }
    }

    // check pixels
    let mut reference_empty = true;
    let mut result_empty = true;

    for y in 0..height {
        for x in 0..width {
            let color = surface.get_pixel(x, y);
            let image_no_coverage =
                compare_colors(color, background_color, args.red_bits, args.green_bits, args.blue_bits);
            let image_full_coverage =
                compare_colors(color, triangle_color, args.red_bits, args.green_bits, args.blue_bits);
            let reference_coverage = coverage_map[idx(x, y)];

            if !image_no_coverage {
                result_empty = false;
            }

            match reference_coverage {
                CoverageType::None => {
                    if !image_no_coverage {
                        unexpected_pixels += 1;
                    }
                }
                CoverageType::Partial => {
                    reference_empty = false;
                    let mut found_fragment = false;
                    if vulkan_lines_test {
                        'search: for dy in -1..2 {
                            for dx in -1..2 {
                                if x + dx >= 0
                                    && x + dx != width
                                    && y + dy >= 0
                                    && y + dy != height
                                    && coverage_map[idx(x + dx, y + dy)] != CoverageType::None
                                {
                                    let color2 = surface.get_pixel(x + dx, y + dy);
                                    if compare_colors(
                                        color2,
                                        triangle_color,
                                        args.red_bits,
                                        args.green_bits,
                                        args.blue_bits,
                                    ) {
                                        found_fragment = true;
                                        break 'search;
                                    }
                                }
                            }
                        }
                    }
                    // Otherwise "anything goes" - a partially covered pixel's exact color is not checked
                    if !found_fragment && vulkan_lines_test {
                        missing_pixels += 1;
                    }
                }
                CoverageType::Full => {
                    reference_empty = false;
                    if !image_full_coverage {
                        missing_pixels += 1;
                    }
                }
            }
        }
    }

    let ok = !(((mode == VerificationMode::Strict) && (missing_pixels + unexpected_pixels > 0))
        || ((mode == VerificationMode::Weak) && (missing_pixels + unexpected_pixels > WEAK_VERIFICATION_THRESHOLD))
        || ((mode == VerificationMode::Weaker)
            && (missing_pixels + unexpected_pixels > WEAKER_VERIFICATION_THRESHOLD))
        || ((mode == VerificationMode::Smooth) && (missing_pixels > WEAK_VERIFICATION_THRESHOLD))
        || reference_empty != result_empty);

    RasterizationVerifyResult {
        ok,
        missing_pixels,
        unexpected_pixels,
    }
}

// --- Point rasterization verification. `PointSceneSpec::ScenePoint` +
// `verifyPointGroupRasterization`/`verifyMultisamplePointGroupRasterization` - upstream's
// own comment on the latter: "Multisampled point == 2 triangles" / "Splitting to
// triangles is a valid solution in multisampled cases and even in non-multisample cases
// too", so this needs no new coverage math at all: each point becomes a
// `point_size`-wide screen-space square (two triangles sharing the diagonal) and is
// handed straight to `verify_triangle_group_rasterization`. ---

/// `PointSceneSpec::ScenePoint`
#[derive(Clone, Copy, Debug)]
pub struct ScenePoint {
    pub position: Vec4,
    pub point_size: f32,
}

/// `PointSceneSpec`
#[derive(Clone, Debug, Default)]
pub struct PointSceneSpec {
    pub points: Vec<ScenePoint>,
}

/// `verifyPointGroupRasterization` (which merely forwards to
/// `verifyMultisamplePointGroupRasterization`, unconditionally - upstream's own comment
/// explains why no non-multisample point-specific path exists). The hpp declares no
/// `mode` parameter and the one caller passes none, so (matching the default argument's
/// effective value) this always verifies at `VerificationMode::Strict`.
pub fn verify_point_group_rasterization(
    surface: &Surface,
    scene: &PointSceneSpec,
    args: &RasterizationArguments,
) -> RasterizationVerifyResult {
    let viewport_size = Vec2::new(surface.get_width() as f32, surface.get_height() as f32);
    let mut triangles = Vec::with_capacity(scene.points.len() * 2);

    for point in &scene.points {
        let point_ndc = Vec2::new(
            point.position.x() / point.position.w(),
            point.position.y() / point.position.w(),
        );
        let point_screen = (point_ndc + Vec2::new(1.0, 1.0)) * 0.5 * viewport_size;
        let offset = point.point_size * 0.5;
        let to_ndc = |corner: Vec2| (point_screen + corner) / viewport_size * 2.0 - Vec2::new(1.0, 1.0);
        let quad_ndc: [Vec2; 4] = [
            to_ndc(Vec2::new(-offset, -offset)),
            to_ndc(Vec2::new(-offset, offset)),
            to_ndc(Vec2::new(offset, offset)),
            to_ndc(Vec2::new(offset, -offset)),
        ];
        let v = |q: Vec2| Vec4::new(q.x(), q.y(), 0.0, 1.0);

        let mut t0 = SceneTriangle::new(v(quad_ndc[0]), v(quad_ndc[1]), v(quad_ndc[2]));
        t0.shared_edge[2] = true;
        let mut t1 = SceneTriangle::new(v(quad_ndc[0]), v(quad_ndc[2]), v(quad_ndc[3]));
        t1.shared_edge[0] = true;
        triangles.push(t0);
        triangles.push(t1);
    }

    verify_triangle_group_rasterization(
        surface,
        &TriangleSceneSpec { triangles },
        args,
        VerificationMode::Strict,
    )
}

// --- Single-sample line rasterization verification. `rr::SingleSampleLineRasterizer`
// (`framework/referencerenderer/rrRasterizer.{hpp,cpp}`) plus
// `verifySinglesampleLineGroupRasterization` - the path `verifyLineGroupRasterization`
// takes whenever `args.numSamples == 0`, which every case this port drives through the
// default framebuffer is (this port's headless EGL context never requests multisampling
// for the default framebuffer target). The multisample path
// (`verifyMultisampleLineGroupRasterization`, built on the *triangle* rasterizer with
// two triangles per line segment) is not ported - `verify_line_group_rasterization`
// panics with a clear message rather than silently calling the wrong algorithm if it is
// ever reached with `num_samples != 0`.
//
// Simplifications from upstream, each because this port's only caller (`BaseLineCase`,
// both ES2 and ES3) never needs the generality:
// - Stippling is omitted entirely. `BaseLineCase` always sets `stippleFactor = 1`,
//   `stipplePattern = 0xFFFF` (every one of the 16 pattern bits set), which makes
//   upstream's own `stipplePass` test (`stipplePattern & (1 << stippleBit)) != 0`) true
//   unconditionally regardless of the counter - so the per-line `resetStipple()`
//   upstream calls when a line list (not a strip) starts a new line can never change the
//   result for any caller this port drives. `SceneLine`/`LineSceneSpec` carry no stipple
//   fields at all, rather than porting them inertly.
// - `rr::FragmentPacket`'s batching (`rasterize()` filling up to `maxFragmentPackets` at
//   a time, so a real renderer can pipeline them) and its depth/barycentric output (read
//   by other `rr` consumers, never by this verifier) are both dropped:
//   `rasterize_single_sample_line` below collects every covered pixel into one `Vec` in
//   a single call, since `verifySinglesampleLineGroupRasterization` only ever reads a
//   fragment's *position*, not which batch it arrived in or its interpolated depth - the
//   line's own interpolation parameter `t` is computed upstream only to feed that unused
//   barycentric output, so it is dropped too.
// - `genScreenSpaceLines`'s separate pre-pass is folded into the main verify loop below
//   (screen-space conversion happens right where each line is rasterized) rather than
//   building a standalone array nothing else reads afterward.

/// `LineSceneSpec::SceneLine`. `colors` is only read by the line colour-interpolation
/// verifier below (matching `SceneTriangle::colors`'s own doc comment) - every
/// rasterization-only caller leaves it at `new`'s white default (upstream's own
/// `verifyLineGroupRasterization` doc comment: "Line colors are not used. The line is
/// expected to be white.").
#[derive(Clone, Copy, Debug)]
pub struct SceneLine {
    pub positions: [Vec4; 2],
    pub colors: [Vec4; 2],
}

impl SceneLine {
    pub fn new(p0: Vec4, p1: Vec4) -> Self {
        Self {
            positions: [p0, p1],
            colors: [Vec4::new(1.0, 1.0, 1.0, 1.0); 2],
        }
    }

    /// `LineInterpolationTest::extractLines` - a scene line carrying its own per-vertex
    /// colour, for the line colour-interpolation verifier.
    pub fn with_colors(p0: Vec4, p1: Vec4, c0: Vec4, c1: Vec4) -> Self {
        Self {
            positions: [p0, p1],
            colors: [c0, c1],
        }
    }
}

/// `LineSceneSpec`. The narrow line verifier reads `lines` and `line_width` only; the rest is for `verify_relaxed_line_group_rasterization`.
#[derive(Clone, Debug)]
pub struct LineSceneSpec {
    pub lines: Vec<SceneLine>,
    pub line_width: f32,
    pub stipple_enable: bool,
    pub stipple_factor: u32,
    pub stipple_pattern: u16,
    pub is_strip: bool,
    pub is_smooth: bool,
    pub is_rectangular: bool,
    pub verification_mode: VerificationMode,
}

impl Default for LineSceneSpec {
    fn default() -> Self {
        Self {
            lines: Vec::new(),
            line_width: 1.0,
            stipple_enable: false,
            stipple_factor: 1,
            stipple_pattern: 0xFFFF,
            is_strip: false,
            is_smooth: false,
            is_rectangular: false,
            verification_mode: VerificationMode::Strict,
        }
    }
}

/// `toSubpixelCoord(float, int)`
pub(crate) fn to_subpixel_coord_f32(v: f32, bits: i32) -> i64 {
    (v * (1i64 << bits) as f32 + if v < 0.0 { -0.5 } else { 0.5 }) as i64
}

/// `toSubpixelCoord(int32_t, int)`
pub(crate) fn to_subpixel_coord_i32(v: i32, bits: i32) -> i64 {
    (v as i64) << bits
}

/// `ceilSubpixelToPixelCoord`
pub(crate) fn ceil_subpixel_to_pixel_coord(coord: i64, bits: i32, fill_edge: bool) -> i32 {
    if coord >= 0 {
        ((coord + ((1i64 << bits) - if fill_edge { 0 } else { 1 })) >> bits) as i32
    } else {
        ((coord + if fill_edge { 1 } else { 0 }) >> bits) as i32
    }
}

/// `floorSubpixelToPixelCoord`
pub(crate) fn floor_subpixel_to_pixel_coord(coord: i64, bits: i32, fill_edge: bool) -> i32 {
    if coord >= 0 {
        ((coord - if fill_edge { 1 } else { 0 }) >> bits) as i32
    } else {
        ((coord - ((1i64 << bits) - if fill_edge { 0 } else { 1 })) >> bits) as i32
    }
}

fn i64_add(a: I64Vec2, b: I64Vec2) -> I64Vec2 {
    (a.0 + b.0, a.1 + b.1)
}

fn i64_neg(a: I64Vec2) -> I64Vec2 {
    (-a.0, -a.1)
}

fn i64_scale(a: I64Vec2, s: i64) -> I64Vec2 {
    (a.0 * s, a.1 * s)
}

fn i64_dot(a: I64Vec2, b: I64Vec2) -> i64 {
    a.0 * b.0 + a.1 * b.1
}

fn i64_length_squared(a: I64Vec2) -> i64 {
    i64_dot(a, a)
}

/// `LineRasterUtil::toSubpixelVector` (the `Vec2` overload).
pub(crate) fn to_subpixel_vector_f(v: Vec2, bits: i32) -> I64Vec2 {
    (to_subpixel_coord_f32(v.x(), bits), to_subpixel_coord_f32(v.y(), bits))
}

/// `LineRasterUtil::toSubpixelVector` (the `IVec2` overload).
pub(crate) fn to_subpixel_vector_i(v: (i32, i32), bits: i32) -> I64Vec2 {
    (to_subpixel_coord_i32(v.0, bits), to_subpixel_coord_i32(v.1, bits))
}

/// `LineRasterUtil::SubpixelLineSegment`
#[derive(Clone, Copy)]
pub(crate) struct SubpixelLineSegment {
    pub(crate) v0: I64Vec2,
    pub(crate) v1: I64Vec2,
}

impl SubpixelLineSegment {
    pub(crate) fn new(v0: I64Vec2, v1: I64Vec2) -> Self {
        Self { v0, v1 }
    }

    pub(crate) fn direction(&self) -> I64Vec2 {
        i64_sub(self.v1, self.v0)
    }
}

/// `LineRasterUtil::LINE_SIDE`
#[derive(Clone, Copy, PartialEq, Eq)]
enum LineSide {
    Intersect,
    Left,
    Right,
}

/// `LineRasterUtil::vertexOnLeftSideOfLine`
fn vertex_on_left_side_of_line(p: I64Vec2, l: &SubpixelLineSegment) -> bool {
    let u = l.direction();
    let v = i64_sub(p, l.v0);
    i64_cross(u, v) < 0
}

/// `LineRasterUtil::vertexOnRightSideOfLine`
fn vertex_on_right_side_of_line(p: I64Vec2, l: &SubpixelLineSegment) -> bool {
    let u = l.direction();
    let v = i64_sub(p, l.v0);
    i64_cross(u, v) > 0
}

/// `LineRasterUtil::vertexOnLine`
fn vertex_on_line(p: I64Vec2, l: &SubpixelLineSegment) -> bool {
    let u = l.direction();
    let v = i64_sub(p, l.v0);
    i64_cross(u, v) == 0
}

/// `LineRasterUtil::vertexOnLineSegment`
fn vertex_on_line_segment(p: I64Vec2, l: &SubpixelLineSegment) -> bool {
    if !vertex_on_line(p, l) {
        return false;
    }
    let v = l.direction();
    let u1 = i64_sub(p, l.v0);
    let u2 = i64_sub(p, l.v1);
    if v.0 == 0 && v.1 == 0 {
        return false;
    }
    i64_dot(v, u1) >= 0 && i64_dot(i64_neg(v), u2) >= 0
}

/// `LineRasterUtil::getVertexSide`
fn get_vertex_side(p: I64Vec2, l: &SubpixelLineSegment) -> LineSide {
    if vertex_on_left_side_of_line(p, l) {
        LineSide::Left
    } else if vertex_on_right_side_of_line(p, l) {
        LineSide::Right
    } else {
        // `vertex_on_line` must hold here, matching upstream's own DE_ASSERT/fallback.
        LineSide::Intersect
    }
}

/// `LineRasterUtil::lineInCornerAngleRange` - true if the angle between `line` and
/// `corner_exit_normal` is in range (-45, 45).
fn line_in_corner_angle_range(line: &SubpixelLineSegment, corner_exit_normal: I64Vec2) -> bool {
    let v = line.direction();
    let dot_product = i64_dot(v, corner_exit_normal);
    if dot_product < 0 {
        return false;
    }
    2 * dot_product * dot_product > i64_length_squared(v) * i64_length_squared(corner_exit_normal)
}

/// `LineRasterUtil::lineInCornerOutsideAngleRange` - true if the angle between `line`
/// and `corner_exit_normal` is in range (-135, 135).
fn line_in_corner_outside_angle_range(line: &SubpixelLineSegment, corner_exit_normal: I64Vec2) -> bool {
    let v = line.direction();
    let dot_product = i64_dot(v, corner_exit_normal);
    if dot_product >= 0 {
        return true;
    }
    2 * (-dot_product) * (-dot_product) < i64_length_squared(v) * i64_length_squared(corner_exit_normal)
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CornerEdgeCase {
    None,
    Hit,
    HitFirstQuarter,
    HitSecondQuarter,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CornerStartCase {
    None,
    Outside,
    PositiveY45,
    NegativeY45,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CornerEndCase {
    None,
    Direction,
    DirectionAndFirstQuarter,
    DirectionAndSecondQuarter,
}

struct DiamondCorner {
    dp: I64Vec2,
    point_inclusive: bool,
    line_behavior: CornerEdgeCase,
    start_behavior: CornerStartCase,
    end_behavior: CornerEndCase,
}

struct DiamondBound {
    p0: I64Vec2,
    p1: I64Vec2,
    edge_inclusive: bool,
}

/// `LineRasterUtil::doesLineSegmentExitDiamond` - the GL "diamond exit" rule: does the
/// line segment, at infinite precision, exit the unit diamond centered on
/// `diamond_center` (which must be a fragment center, i.e. `(x+0.5, y+0.5)` in subpixel
/// coordinates)?
pub(crate) fn does_line_segment_exit_diamond(line: &SubpixelLineSegment, diamond_center: I64Vec2, bits: i32) -> bool {
    let half_pixel: i64 = 1i64 << (bits - 1);

    // Reject distant diamonds early.
    {
        let u = line.direction();
        let v = i64_sub(diamond_center, line.v0);
        let cross_product = i64_cross(u, v);

        const FLOOR_SQRT_MAX_INT64: i64 = 3037000499;
        let broad_reject_distance = 2 * half_pixel;
        let broad_reject_distance_squared = broad_reject_distance * broad_reject_distance;
        let cross_product_overflows = !(-FLOOR_SQRT_MAX_INT64..=FLOOR_SQRT_MAX_INT64).contains(&cross_product);
        let cross_product_squared = if cross_product_overflows {
            0
        } else {
            cross_product * cross_product
        };
        let line_length_squared = i64_length_squared(u);
        let clz = |v: i64| -> u32 { (v as u64).leading_zeros() };
        let limit_value_could_overflow =
            (64 - clz(line_length_squared)) + (64 - clz(broad_reject_distance_squared)) > 63;
        let limit_value = if limit_value_could_overflow {
            0
        } else {
            line_length_squared * broad_reject_distance_squared
        };

        if cross_product_overflows && !limit_value_could_overflow {
            return false;
        }
        if !cross_product_overflows && !limit_value_could_overflow && cross_product_squared > limit_value {
            return false;
        }
    }

    let bounds = [
        DiamondBound {
            p0: i64_add(diamond_center, (0i64, -half_pixel)),
            p1: i64_add(diamond_center, (-half_pixel, 0i64)),
            edge_inclusive: false,
        },
        DiamondBound {
            p0: i64_add(diamond_center, (-half_pixel, 0i64)),
            p1: i64_add(diamond_center, (0i64, half_pixel)),
            edge_inclusive: false,
        },
        DiamondBound {
            p0: i64_add(diamond_center, (0i64, half_pixel)),
            p1: i64_add(diamond_center, (half_pixel, 0i64)),
            edge_inclusive: true,
        },
        DiamondBound {
            p0: i64_add(diamond_center, (half_pixel, 0i64)),
            p1: i64_add(diamond_center, (0i64, -half_pixel)),
            edge_inclusive: true,
        },
    ];

    let corners = [
        DiamondCorner {
            dp: (0i64, -half_pixel),
            point_inclusive: false,
            line_behavior: CornerEdgeCase::HitSecondQuarter,
            start_behavior: CornerStartCase::PositiveY45,
            end_behavior: CornerEndCase::DirectionAndSecondQuarter,
        },
        DiamondCorner {
            dp: (-half_pixel, 0i64),
            point_inclusive: false,
            line_behavior: CornerEdgeCase::None,
            start_behavior: CornerStartCase::None,
            end_behavior: CornerEndCase::Direction,
        },
        DiamondCorner {
            dp: (0i64, half_pixel),
            point_inclusive: false,
            line_behavior: CornerEdgeCase::HitFirstQuarter,
            start_behavior: CornerStartCase::NegativeY45,
            end_behavior: CornerEndCase::DirectionAndFirstQuarter,
        },
        DiamondCorner {
            dp: (half_pixel, 0i64),
            point_inclusive: true,
            line_behavior: CornerEdgeCase::Hit,
            start_behavior: CornerStartCase::Outside,
            end_behavior: CornerEndCase::None,
        },
    ];

    // Corner cases at the corners.
    for corner in &corners {
        let p = i64_add(diamond_center, corner.dp);
        if !vertex_on_line_segment(p, line) {
            continue;
        }

        // line segment body intersects with the corner
        if p != line.v0 && p != line.v1 {
            if corner.line_behavior == CornerEdgeCase::Hit {
                return true;
            }
            // endpoint in (+X, -Y) (X or Y may be 0) direction <==> x*y <= 0
            if corner.line_behavior == CornerEdgeCase::HitFirstQuarter && (line.direction().0 * line.direction().1) <= 0
            {
                return true;
            }
            // endpoint in (+X, +Y) (Y > 0) direction <==> x*y > 0
            if corner.line_behavior == CornerEdgeCase::HitSecondQuarter && (line.direction().0 * line.direction().1) > 0
            {
                return true;
            }
        }

        // line exits the area at the corner
        if line_in_corner_angle_range(line, corner.dp) {
            let start_is_inside = corner.point_inclusive || p != line.v0;
            let end_is_outside = !corner.point_inclusive || p != line.v1;
            if start_is_inside && end_is_outside {
                return true;
            }
        }

        // line end is at the corner
        if p == line.v1 {
            if matches!(
                corner.end_behavior,
                CornerEndCase::Direction
                    | CornerEndCase::DirectionAndFirstQuarter
                    | CornerEndCase::DirectionAndSecondQuarter
            ) && line_in_corner_angle_range(line, corner.dp)
            {
                return true;
            }
            if corner.end_behavior == CornerEndCase::DirectionAndFirstQuarter
                && line.direction().0 < 0
                && line.direction().1 > 0
            {
                return true;
            }
            if corner.end_behavior == CornerEndCase::DirectionAndSecondQuarter
                && line.direction().0 > 0
                && line.direction().1 > 0
            {
                return true;
            }
        }

        // line start is at the corner
        if p == line.v0 {
            if corner.start_behavior == CornerStartCase::Outside && line_in_corner_outside_angle_range(line, corner.dp)
            {
                return true;
            }
            if corner.start_behavior == CornerStartCase::PositiveY45
                && line.direction().0 > 0
                && line.direction().1 > 0
                && line.direction().1 <= line.direction().0
            {
                return true;
            }
            if corner.start_behavior == CornerStartCase::NegativeY45
                && line.direction().0 > 0
                && line.direction().1 <= 0
                && -line.direction().1 <= line.direction().0
            {
                return true;
            }
        }
    }

    // Does the line intersect boundary at the left == exits the diamond.
    for bound in &bounds {
        let edge = SubpixelLineSegment::new(bound.p0, bound.p1);
        let start_vertex_inside =
            vertex_on_left_side_of_line(line.v0, &edge) || (bound.edge_inclusive && vertex_on_line(line.v0, &edge));
        let end_vertex_inside =
            vertex_on_left_side_of_line(line.v1, &edge) || (bound.edge_inclusive && vertex_on_line(line.v1, &edge));

        if !start_vertex_inside || end_vertex_inside {
            continue;
        }

        let side_p0 = get_vertex_side(bound.p0, line);
        let side_p1 = get_vertex_side(bound.p1, line);
        if side_p0 != LineSide::Intersect && side_p1 != LineSide::Intersect && side_p0 != side_p1 {
            return true;
        }
    }

    false
}

/// `rr::SingleSampleLineRasterizer::init` + `::rasterize`, collapsed into one pure
/// function returning every covered pixel directly - see the section header for why
/// `rr::FragmentPacket`'s batching/depth/barycentric output is not needed here.
/// `v0`/`v1` are already in screen space (not clip space).
fn rasterize_single_sample_line(
    v0: Vec4,
    v1: Vec4,
    line_width: f32,
    viewport: (i32, i32, i32, i32),
    bits: i32,
) -> Vec<(i32, i32)> {
    let (vx, vy, vw, vh) = viewport;
    let dx = v1.x() - v0.x();
    let dy = v1.y() - v0.y();
    let is_x_major = dx.abs() >= dy.abs();
    let line_width_pixels_i32: i32 = if line_width > 1.0 {
        (line_width + 0.5).floor() as i32
    } else {
        1
    };

    let width_offset_init: I64Vec2 = {
        let dir: I64Vec2 = if is_x_major { (0, -1) } else { (-1, 0) };
        i64_scale(dir, to_subpixel_coord_i32(line_width_pixels_i32 - 1, bits) / 2)
    };
    let x0 = to_subpixel_coord_f32(v0.x(), bits) + width_offset_init.0;
    let y0 = to_subpixel_coord_f32(v0.y(), bits) + width_offset_init.1;
    let x1 = to_subpixel_coord_f32(v1.x(), bits) + width_offset_init.0;
    let y1 = to_subpixel_coord_f32(v1.y(), bits) + width_offset_init.1;

    let one_subpixel = to_subpixel_coord_i32(1, bits);
    let x_min = x0.min(x1) - one_subpixel;
    let x_max = x0.max(x1) + one_subpixel;
    let y_min = y0.min(y1) - one_subpixel;
    let y_max = y0.max(y1) + one_subpixel;

    let (bbox_min_x, bbox_max_x, bbox_min_y, bbox_max_y);
    if is_x_major {
        bbox_min_x = floor_subpixel_to_pixel_coord(x_min, bits, true).clamp(vx, vx + vw - 1);
        bbox_max_x = ceil_subpixel_to_pixel_coord(x_max, bits, true).clamp(vx, vx + vw - 1);
        bbox_min_y = floor_subpixel_to_pixel_coord(y_min, bits, true).clamp(vy - line_width_pixels_i32, vy + vh - 1);
        bbox_max_y = ceil_subpixel_to_pixel_coord(y_max, bits, true).clamp(vy - line_width_pixels_i32, vy + vh - 1);
    } else {
        bbox_min_y = floor_subpixel_to_pixel_coord(y_min, bits, true).clamp(vy, vy + vh - 1);
        bbox_max_y = ceil_subpixel_to_pixel_coord(y_max, bits, true).clamp(vy, vy + vh - 1);
        bbox_min_x = floor_subpixel_to_pixel_coord(x_min, bits, true).clamp(vx - line_width_pixels_i32, vx + vw - 1);
        bbox_max_x = ceil_subpixel_to_pixel_coord(x_max, bits, true).clamp(vx - line_width_pixels_i32, vx + vw - 1);
    }

    let half_pixel: i64 = 1i64 << (bits - 1);
    let minor_direction: (i32, i32) = if is_x_major { (0, 1) } else { (1, 0) };
    let min_viewport_limit = if is_x_major { vy } else { vx };
    let max_viewport_limit = if is_x_major { vy + vh } else { vx + vw };
    let width_offset: I64Vec2 = {
        let neg_minor: I64Vec2 = (-(minor_direction.0 as i64), -(minor_direction.1 as i64));
        i64_scale(neg_minor, to_subpixel_coord_i32(line_width_pixels_i32 - 1, bits) / 2)
    };
    let pa = i64_add(to_subpixel_vector_f(Vec2::new(v0.x(), v0.y()), bits), width_offset);
    let pb = i64_add(to_subpixel_vector_f(Vec2::new(v1.x(), v1.y()), bits), width_offset);
    let line = SubpixelLineSegment::new(pa, pb);

    let x_delta: i32 = if dx > 0.0 { 1 } else { -1 };
    let y_delta: i32 = if dy > 0.0 { 1 } else { -1 };

    let mut cur_pos = (
        if x_delta > 0 { bbox_min_x } else { bbox_max_x },
        if y_delta > 0 { bbox_min_y } else { bbox_max_y },
    );
    let mut out = Vec::new();

    while cur_pos.1 <= bbox_max_y && cur_pos.1 >= bbox_min_y {
        let diamond_position = i64_add(to_subpixel_vector_i(cur_pos, bits), (half_pixel, half_pixel));

        if does_line_segment_exit_diamond(&line, diamond_position, bits) {
            let fragment_location = if is_x_major { cur_pos.1 } else { cur_pos.0 };
            let row_frag_begin = 0.max(min_viewport_limit - fragment_location);
            let row_frag_end = (max_viewport_limit - fragment_location).min(line_width_pixels_i32);

            // Stipple always passes for this port's scope (see the section header).
            let mut replication_id = row_frag_begin;
            while replication_id < row_frag_end {
                let fragment_pos = (
                    cur_pos.0 + minor_direction.0 * replication_id,
                    cur_pos.1 + minor_direction.1 * replication_id,
                );
                out.push(fragment_pos);
                replication_id += 1;
            }
        }

        cur_pos.0 += x_delta;
        if cur_pos.0 > bbox_max_x || cur_pos.0 < bbox_min_x {
            cur_pos.1 += y_delta;
            cur_pos.0 = if x_delta > 0 { bbox_min_x } else { bbox_max_x };
        }
    }

    out
}

/// `genScreenSpaceLines`'s per-vertex transform, folded into the main verify loop (see
/// the section header).
fn line_vertex_to_screen_space(p: Vec4, viewport_size: (f32, f32)) -> Vec2 {
    let ndc = Vec2::new(p.x() / p.w(), p.y() / p.w());
    Vec2::new(
        (ndc.x() + 1.0) * 0.5 * viewport_size.0,
        (ndc.y() + 1.0) * 0.5 * viewport_size.1,
    )
}

/// `verifySinglesampleLineGroupRasterization`, with the simplifications the section
/// header describes (no stipple state, no log/image stash - like every other function
/// in this module). Requirement 4 (continuity of shared line-strip endpoints) is a
/// `\todo` upstream itself never implemented; not ported here either, matching
/// upstream's own incompleteness rather than introducing a deviation from it.
fn verify_single_sample_line_group_rasterization(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
) -> RasterizationVerifyResult {
    let white = RGBA::new(255, 255, 255, 255);
    let width = surface.get_width();
    let height = surface.get_height();
    let viewport = (0, 0, width, height);
    let subpixel_bits = args.subpixel_bits.clamp(0, 16);

    let line_width_int = (scene.line_width + 0.5).floor() as i32;
    let line_width_has_frac = scene.line_width.fract() > 0.0;

    let mut reference_line_map = vec![0i32; (width as usize) * (height as usize)];
    let mut line_is_x_major = vec![false; scene.lines.len()];
    let mut overdraw_in_reference = false;

    let idx = |x: i32, y: i32| (y as usize) * (width as usize) + (x as usize);

    for (line_ndx, line) in scene.lines.iter().enumerate() {
        let p0 = line_vertex_to_screen_space(line.positions[0], (width as f32, height as f32));
        let p1 = line_vertex_to_screen_space(line.positions[1], (width as f32, height as f32));
        line_is_x_major[line_ndx] = (p1.x() - p0.x()).abs() >= (p1.y() - p0.y()).abs();

        let screen_v0 = Vec4::new(p0.x(), p0.y(), 0.0, 1.0);
        let screen_v1 = Vec4::new(p1.x(), p1.y(), 0.0, 1.0);
        let fragments = rasterize_single_sample_line(screen_v0, screen_v1, scene.line_width, viewport, subpixel_bits);

        for (fx, fy) in fragments {
            // Defensive only - the rasterizer clamps to the viewport by construction,
            // matching upstream's own `DE_ASSERT(inViewport(fragmentPos, viewport))`.
            if fx < 0 || fy < 0 || fx >= width || fy >= height {
                continue;
            }
            let cell = idx(fx, fy);
            if reference_line_map[cell] != 0 {
                overdraw_in_reference = true;
            }
            reference_line_map[cell] = (line_ndx as i32) + 1;
        }
    }

    // Requirement 1: a reference fragment's matching result fragment must be within one pixel.
    let mut missing_fragments = false;
    let mut reference_fragments = 0i32;
    let mut result_fragments = 0i32;
    for y in 0..height {
        for x in 0..width {
            let reference = reference_line_map[idx(x, y)] != 0;
            let result = compare_colors(
                surface.get_pixel(x, y),
                white,
                args.red_bits,
                args.green_bits,
                args.blue_bits,
            );
            if reference {
                reference_fragments += 1;
            }
            if result {
                result_fragments += 1;
            }
            if reference == result {
                continue;
            }

            if reference && !result {
                let mut found_fragment = x == 0 || y == 0 || x == width - 1 || y == height - 1;
                if !found_fragment {
                    'search: for dy in -1..=1 {
                        for dx in -1..=1 {
                            if compare_colors(
                                surface.get_pixel(x + dx, y + dy),
                                white,
                                args.red_bits,
                                args.green_bits,
                                args.blue_bits,
                            ) {
                                found_fragment = true;
                                break 'search;
                            }
                        }
                    }
                }
                if !found_fragment {
                    missing_fragments = true;
                }
            }
        }
    }

    // Requirement 2: the total fragment count may differ from the reference by no more
    // than one pixel per primitive in the major direction - skipped entirely if any
    // reference fragment was overdrawn (two lines' coverage overlapped), matching
    // upstream: the count is meaningless in that case.
    let mut fragment_count_invalid = false;
    if !overdraw_in_reference {
        let allowed_deviation = (scene.lines.len() as i32) * line_width_int;
        if (reference_fragments - result_fragments).abs() > allowed_deviation {
            fragment_count_invalid = true;
        }
    }

    // Requirement 3: line width must be constant, checked once scanning rows (x-major
    // lines) and once scanning columns (y-major lines).
    let mut invalid_width_found = false;
    for y in 1..height - 1 {
        let mut full_visible_line = false;
        let mut previous_pixel_undefined = false;
        let mut current_line = 0i32;
        let mut current_width = 1i32;

        for x in 1..width - 1 {
            let result = compare_colors(
                surface.get_pixel(x, y),
                white,
                args.red_bits,
                args.green_bits,
                args.blue_bits,
            );
            let mut line_id = 0i32;

            if result {
                let mut multiple_nearby_lines = false;
                let render_at_surface_edge = x == 1 || x == width - 2;
                for dy in -1..=1 {
                    for dx in -1..=1 {
                        let nearby_id = reference_line_map[idx(x + dx, y + dy)];
                        if nearby_id != 0 {
                            if line_id != 0 && line_id != nearby_id {
                                multiple_nearby_lines = true;
                            }
                            line_id = nearby_id;
                        }
                    }
                }

                if multiple_nearby_lines || render_at_surface_edge {
                    previous_pixel_undefined = true;
                    continue;
                }
            }

            if previous_pixel_undefined {
                current_line = line_id;
                current_width = 1;
                full_visible_line = false;
                previous_pixel_undefined = false;
            } else if line_id == current_line {
                current_width += 1;
            } else if line_id > current_line {
                current_line = line_id;
                current_width = 1;
                full_visible_line = true;
            } else {
                if full_visible_line
                    && !line_is_x_major[(current_line - 1) as usize]
                    && !(line_width_has_frac && current_width + 1 == line_width_int)
                    && current_width != line_width_int
                {
                    invalid_width_found = true;
                }
                current_line = line_id;
                current_width = 1;
                full_visible_line = false;
            }
        }
    }
    for x in 1..width - 1 {
        let mut full_visible_line = false;
        let mut previous_pixel_undefined = false;
        let mut current_line = 0i32;
        let mut current_width = 1i32;

        for y in 1..height - 1 {
            let result = compare_colors(
                surface.get_pixel(x, y),
                white,
                args.red_bits,
                args.green_bits,
                args.blue_bits,
            );
            let mut line_id = 0i32;

            if result {
                let mut multiple_nearby_lines = false;
                // Matches upstream exactly, including its own bug: this compares `y`
                // against `width - 2` rather than `height - 2` - see QUIRKS.md.
                let render_at_surface_edge = y == 1 || y == width - 2;
                for dy in -1..=1 {
                    for dx in -1..=1 {
                        let nearby_id = reference_line_map[idx(x + dx, y + dy)];
                        if nearby_id != 0 {
                            if line_id != 0 && line_id != nearby_id {
                                multiple_nearby_lines = true;
                            }
                            line_id = nearby_id;
                        }
                    }
                }

                if multiple_nearby_lines || render_at_surface_edge {
                    previous_pixel_undefined = true;
                    continue;
                }
            }

            if previous_pixel_undefined {
                current_line = line_id;
                current_width = 1;
                full_visible_line = false;
                previous_pixel_undefined = false;
            } else if line_id == current_line {
                current_width += 1;
            } else if line_id > current_line {
                current_line = line_id;
                current_width = 1;
                full_visible_line = true;
            } else {
                if full_visible_line
                    && line_is_x_major[(current_line - 1) as usize]
                    && !(line_width_has_frac && current_width + 1 == line_width_int)
                    && current_width != line_width_int
                {
                    invalid_width_found = true;
                }
                current_line = line_id;
                current_width = 1;
                full_visible_line = false;
            }
        }
    }

    let ok = !missing_fragments && !fragment_count_invalid && !invalid_width_found;
    RasterizationVerifyResult {
        ok,
        missing_pixels: 0,
        unexpected_pixels: 0,
    }
}

fn normalize2(v: Vec2) -> Vec2 {
    let len = length(v);
    Vec2::new(v.x() / len, v.y() / len)
}

/// `verifyMultisampleLineGroupRasterization`, restricted to this port's own calling
/// convention: `verifyLineGroupRasterization`'s GLES dispatch always passes
/// `CLIPMODE_NO_CLIPPING`, `logStash = nullptr`, `vulkanLinesTest = false`,
/// `strictMode = true` - and every caller in this port's scope leaves stippling off
/// (`LineSceneSpec` here has no `stippleEnable` field at all, matching the narrow-line
/// rasterizer's own note on the same point). Under those restrictions the function
/// reduces to exactly what its own doc comment says: "Multisampled line == 2 triangles" -
/// build one quad per line, perpendicular to the line's own screen-space direction
/// (`strictMode` always true here, so the "axis-aligned normal" alternative upstream
/// also supports never applies), and hand it to the already-ported, already
/// multisample-aware `verify_triangle_group_rasterization` unchanged - a
/// `vulkanLinesTest = false`/no-log-stash call there is exactly what this port's own
/// 4-argument `verify_triangle_group_rasterization` already is.
fn verify_multisample_line_group_rasterization(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
) -> RasterizationVerifyResult {
    let viewport_size = Vec2::new(surface.get_width() as f32, surface.get_height() as f32);
    let half_line_width = scene.line_width * 0.5;
    let one_one = Vec2::new(1.0, 1.0);

    let mut triangles = Vec::with_capacity(scene.lines.len() * 2);
    for line in &scene.lines {
        let p0 = Vec2::new(
            line.positions[0].x() / line.positions[0].w(),
            line.positions[0].y() / line.positions[0].w(),
        );
        let p1 = Vec2::new(
            line.positions[1].x() / line.positions[1].w(),
            line.positions[1].y() / line.positions[1].w(),
        );
        let s0 = (p0 + one_one) * 0.5 * viewport_size;
        let s1 = (p1 + one_one) * 0.5 * viewport_size;

        let dir = normalize2(s1 - s0);
        let normal = Vec2::new(dir.y(), -dir.x());

        let quad_screen = [
            s0 + normal * half_line_width,
            s0 - normal * half_line_width,
            s1 - normal * half_line_width,
            s1 + normal * half_line_width,
        ];
        let quad_ndc = quad_screen.map(|q| q / viewport_size * 2.0 - one_one);
        let v = |i: usize| Vec4::new(quad_ndc[i].x(), quad_ndc[i].y(), 0.0, 1.0);

        let mut t0 = SceneTriangle::new(v(0), v(1), v(2));
        t0.shared_edge[2] = true;
        let mut t1 = SceneTriangle::new(v(0), v(2), v(3));
        t1.shared_edge[0] = true;
        triangles.push(t0);
        triangles.push(t1);
    }

    verify_triangle_group_rasterization(
        surface,
        &TriangleSceneSpec { triangles },
        args,
        VerificationMode::Strict,
    )
}

/// `verifyLineGroupRasterization` - dispatches on `args.numSamples`.
pub fn verify_line_group_rasterization(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
) -> RasterizationVerifyResult {
    if args.num_samples != 0 {
        return verify_multisample_line_group_rasterization(surface, scene, args);
    }
    verify_single_sample_line_group_rasterization(surface, scene, args)
}

/// `ClipMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ClipMode {
    NoClipping,
    UseClippingBox,
}

/// `calculateIntersectionParameter`
fn calculate_intersection_parameter(line: &[Vec2; 2], w: f32, component_ndx: usize) -> f32 {
    let component = |v: Vec2| if component_ndx == 0 { v.x() } else { v.y() };
    if component(line[1]) == component(line[0]) {
        return -1.0;
    }
    (w - component(line[0])) / (component(line[1]) - component(line[0]))
}

fn get_component(v: Vec2, component: usize) -> f32 {
    if component == 0 { v.x() } else { v.y() }
}

fn set_component(v: &mut Vec2, component: usize, value: f32) {
    if component == 0 {
        *v = Vec2::new(value, v.y());
    } else {
        *v = Vec2::new(v.x(), value);
    }
}

/// `applyClippingBox` - clips the line with a ((-w, -w), (-w, w), (w, w), (w, -w)) rectangle
fn apply_clipping_box(line: &mut [Vec2; 2], w: f32) {
    for side in 0..4usize {
        let sign = (((side / 2) as i32) * -2 + 1) as f32;
        let component = side % 2;
        let t = calculate_intersection_parameter(line, w * sign, component);

        if t > 0.0 && t < 1.0 {
            let other = 1 - component;
            let new_coord = t * get_component(line[1], other) + (1.0 - t) * get_component(line[0], other);

            let target = if get_component(line[1], component) > w * sign {
                1 - side / 2
            } else {
                side / 2
            };
            set_component(&mut line[target], component, w * sign);
            set_component(&mut line[target], other, new_coord);
        }
    }
}

fn mix2(a: Vec2, b: Vec2, t: f32) -> Vec2 {
    a * (1.0 - t) + b * t
}

/// `verifyMultisampleLineGroupRasterization` with every argument of upstream: a line is two triangles, or the triangles of the pieces of it that the
/// stipple lets through.
fn verify_multisample_line_group_rasterization_with(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
    clip_mode: ClipMode,
    vulkan_lines_test: bool,
    strict_mode: bool,
    carry_remainder: bool,
) -> RasterizationVerifyResult {
    let viewport_size = Vec2::new(surface.get_width() as f32, surface.get_height() as f32);
    let half_line_width = scene.line_width * 0.5;
    let one_one = Vec2::new(1.0, 1.0);
    let mut triangles: Vec<SceneTriangle> = Vec::with_capacity(scene.lines.len() * 2);

    let mut stipple_counter: u32 = 0;
    let mut leftover_phase: f32 = 0.0;

    let quad = |screen: [Vec2; 4]| -> [SceneTriangle; 2] {
        let ndc = screen.map(|q| q / viewport_size * 2.0 - one_one);
        let v = |i: usize| Vec4::new(ndc[i].x(), ndc[i].y(), 0.0, 1.0);
        let mut t0 = SceneTriangle::new(v(0), v(1), v(2));
        t0.shared_edge = [false, false, true];
        let mut t1 = SceneTriangle::new(v(0), v(2), v(3));
        t1.shared_edge = [true, false, false];
        [t0, t1]
    };

    for line in &scene.lines {
        if !scene.is_strip {
            // reset stipple at the start of each line segment
            stipple_counter = 0;
            leftover_phase = 0.0;
        }

        // Transform to screen space, add pixel offsets, convert back to normalized device space, and test as triangles
        let mut line_ndc = [
            Vec2::new(
                line.positions[0].x() / line.positions[0].w(),
                line.positions[0].y() / line.positions[0].w(),
            ),
            Vec2::new(
                line.positions[1].x() / line.positions[1].w(),
                line.positions[1].y() / line.positions[1].w(),
            ),
        ];

        if clip_mode == ClipMode::UseClippingBox {
            apply_clipping_box(&mut line_ndc, 1.0);
        }

        let line_screen = [
            (line_ndc[0] + one_one) * 0.5 * viewport_size,
            (line_ndc[1] + one_one) * 0.5 * viewport_size,
        ];

        let line_dir = normalize2(line_screen[1] - line_screen[0]);
        let line_normal_dir = if strict_mode || scene.is_rectangular {
            Vec2::new(line_dir.y(), -line_dir.x())
        } else if is_line_x_major(line_screen[0], line_screen[1]) {
            Vec2::new(0.0, 1.0)
        } else {
            Vec2::new(1.0, 0.0)
        };

        if scene.stipple_enable {
            let line_length = length(line_screen[1] - line_screen[0]);
            let mut line_offset = 0.0f32;
            let mut line_segment_start = -1.0f32;
            let mut line_segment_end = -1.0f32;
            let mut prev_stipple_pass = false;

            while line_offset < line_length {
                let d0 = line_offset;
                let mut d1 = d0 + 1.0;

                if carry_remainder {
                    // "leftoverPhase" carries over a fractional stipple phase that was "unused"
                    // by the last line segment in the strip, if it wasn't an integer length.
                    if leftover_phase > line_length {
                        d1 = line_length;
                        leftover_phase -= line_length;
                    } else if leftover_phase != 0.0 {
                        d1 = leftover_phase;
                        leftover_phase = 0.0;
                    } else if d0 + 1.0 > line_length {
                        d1 = line_length;
                        leftover_phase = d0 + 1.0 - line_length;
                    } else {
                        d1 = d0 + 1.0;
                    }
                } else if d1 > line_length {
                    d1 = line_length;
                }

                // set offset for next iteration
                line_offset = d1;

                let stipple_bit = (stipple_counter / scene.stipple_factor) % 16;
                let stipple_pass = (u32::from(scene.stipple_pattern) & (1 << stipple_bit)) != 0;

                if leftover_phase == 0.0 {
                    stipple_counter += 1;
                }

                if stipple_pass {
                    // start new segment
                    if !prev_stipple_pass {
                        line_segment_start = d0;
                    }

                    // extend current segment
                    line_segment_end = d1;
                }

                // update state
                prev_stipple_pass = stipple_pass;

                // keep accumulating lines
                if (stipple_pass && line_offset < line_length) || line_segment_start == line_segment_end {
                    continue;
                }

                let t0 = line_segment_start / line_length;
                let t1 = line_segment_end / line_length;
                line_segment_start = -1.0;
                line_segment_end = -1.0;

                let l0 = mix2(line_screen[0], line_screen[1], t0);
                let l1 = mix2(line_screen[0], line_screen[1], t1);

                triangles.extend(quad([
                    l0 + line_normal_dir * half_line_width,
                    l0 - line_normal_dir * half_line_width,
                    l1 - line_normal_dir * half_line_width,
                    l1 + line_normal_dir * half_line_width,
                ]));
            }
        } else {
            triangles.extend(quad([
                line_screen[0] + line_normal_dir * half_line_width,
                line_screen[0] - line_normal_dir * half_line_width,
                line_screen[1] - line_normal_dir * half_line_width,
                line_screen[1] + line_normal_dir * half_line_width,
            ]));
        }
    }

    verify_triangle_group_rasterization_for_lines(
        surface,
        &TriangleSceneSpec { triangles },
        args,
        scene.verification_mode,
        vulkan_lines_test,
    )
}

/// The stipple wrapper overload of `verifyMultisampleLineGroupRasterization`: a stippled scene passes if either way of carrying the remainder does.
fn verify_multisample_line_group_rasterization_stipple(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
    clip_mode: ClipMode,
    vulkan_lines_test: bool,
    strict_mode: bool,
) -> RasterizationVerifyResult {
    let run = |carry_remainder: bool| {
        verify_multisample_line_group_rasterization_with(
            surface,
            scene,
            args,
            clip_mode,
            vulkan_lines_test,
            strict_mode,
            carry_remainder,
        )
    };
    if scene.stipple_enable {
        let first = run(true);
        if first.ok { first } else { run(false) }
    } else {
        run(true)
    }
}

/// `verifyRelaxedLineGroupRasterization`
pub fn verify_relaxed_line_group_rasterization(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
    vulkan_lines_test: bool,
    strict: bool,
) -> bool {
    let attempt = |clip_mode: ClipMode, strict_mode: bool| {
        verify_multisample_line_group_rasterization_stipple(
            surface,
            scene,
            args,
            clip_mode,
            vulkan_lines_test,
            strict_mode,
        )
        .ok
    };

    attempt(ClipMode::UseClippingBox, strict)
        || attempt(ClipMode::NoClipping, strict)
        || (!strict && attempt(ClipMode::UseClippingBox, true))
        || (!strict && attempt(ClipMode::NoClipping, true))
        || (!strict && args.num_samples == 0 && verify_line_group_rasterization(surface, scene, args).ok)
}

// --- Triangle colour-interpolation verification, `calcTriangleInterpolationWeights` +
// `verifyTriangleGroupInterpolationWithInterpolator<TriangleInterpolator>` (the line
// interpolator and everything it needs is not ported - see the file header). ---

/// `triangleArea` - twice-signed-area formula, same winding convention as
/// `isTriangleClockwise` above.
fn triangle_area(s0: Vec2, s1: Vec2, s2: Vec2) -> f32 {
    let u = s1 - s0;
    let v = s2 - s0;
    (u.x() * v.y() - u.y() * v.x()) / 2.0
}

/// `getExponentEpsilonFromULP` - "assume mediump precision, using ulp as ulps in a 10
/// bit mantissa".
fn get_exponent_epsilon_from_ulp(value_exponent: i32, ulp: u32) -> f32 {
    debug_assert!(ulp < (1u32 << 10));
    Float32::construct(1, value_exponent, (1u32 << 23) + (ulp << (23 - 10))).as_float()
        - Float32::construct(1, value_exponent, 1u32 << 23).as_float()
}

/// `getValueEpsilonFromULP`
fn get_value_epsilon_from_ulp(value: f32, ulp: u32) -> f32 {
    debug_assert!(!value.is_infinite());
    get_exponent_epsilon_from_ulp(Float32::new(value).exponent(), ulp)
}

/// `getMaxValueWithinError`
fn get_max_value_within_error(value: f32, ulp: u32) -> f32 {
    if value.is_infinite() {
        return value;
    }
    value + get_value_epsilon_from_ulp(value, ulp)
}

/// `getMinValueWithinError`
fn get_min_value_within_error(value: f32, ulp: u32) -> f32 {
    if value.is_infinite() {
        return value;
    }
    value - get_value_epsilon_from_ulp(value, ulp)
}

/// `getMinFlushToZero` - "flush to zero if that decreases the value, assume mediump
/// precision".
fn get_min_flush_to_zero(value: f32) -> f32 {
    if value > 0.0 && value < Float32::construct(1, -14, 1u32 << 23).as_float() {
        0.0
    } else {
        value
    }
}

/// `getMaxFlushToZero`
fn get_max_flush_to_zero(value: f32) -> f32 {
    if value < 0.0 && value > Float32::construct(-1, -14, 1u32 << 23).as_float() {
        0.0
    } else {
        value
    }
}

/// `convertRGB8ToNativeFormat` - the middle `channelBitCount == 8` branch upstream has is
/// unreachable there too (already handled by the first `<= 8` branch); collapsed to two
/// arms here rather than reproducing dead code.
fn convert_rgb8_to_native_format(color: RGBA, args: &RasterizationArguments) -> IVec3 {
    let channel = |bits: i32, value: i32| -> i32 {
        if bits <= 8 {
            value >> (8 - bits)
        } else {
            value << (bits - 8)
        }
    };
    IVec3::new(
        channel(args.red_bits, color.get_red()),
        channel(args.green_bits, color.get_green()),
        channel(args.blue_bits, color.get_blue()),
    )
}

/// Returns the maximum value of `x / y`, where `x` in `[min_dividend, max_dividend]` and
/// `y` in `[min_divisor, max_divisor]`.
fn maximal_range_division(min_dividend: f32, max_dividend: f32, min_divisor: f32, max_divisor: f32) -> f32 {
    if min_dividend == 0.0 && max_dividend == 0.0 {
        return 0.0;
    }
    if min_divisor <= 0.0 && max_divisor >= 0.0 {
        return f32::INFINITY;
    }
    (min_dividend / min_divisor)
        .max(min_dividend / max_divisor)
        .max((max_dividend / min_divisor).max(max_dividend / max_divisor))
}

/// Returns the minimum value of `x / y`, same ranges as `maximal_range_division`.
fn minimal_range_division(min_dividend: f32, max_dividend: f32, min_divisor: f32, max_divisor: f32) -> f32 {
    if min_dividend == 0.0 && max_dividend == 0.0 {
        return 0.0;
    }
    if min_divisor <= 0.0 && max_divisor >= 0.0 {
        return f32::NEG_INFINITY;
    }
    (min_dividend / min_divisor)
        .min(min_dividend / max_divisor)
        .min((max_dividend / min_divisor).min(max_dividend / max_divisor))
}

/// `InterpolationRange` - a `tcu::Vec3` pair upstream (one component per triangle
/// vertex); a plain `[f32; 3]` pair here, same rationale as `I64Vec2`/`DVec2` above.
#[derive(Clone, Copy, Debug)]
struct InterpolationRange {
    max: [f32; 3],
    min: [f32; 3],
}

/// `calcTriangleInterpolationWeights`
fn calc_triangle_interpolation_weights(p0: Vec4, p1: Vec4, p2: Vec4, ndpixel: Vec2) -> InterpolationRange {
    const ROUND_ERROR: u32 = 1;
    const BARYCENTRIC_ERROR: u32 = 3;
    const DIV_ERROR: u32 = 8;

    let nd0 = Vec2::new(p0.x() / p0.w(), p0.y() / p0.w());
    let nd1 = Vec2::new(p1.x() / p1.w(), p1.y() / p1.w());
    let nd2 = Vec2::new(p2.x() / p2.w(), p2.y() / p2.w());

    let ka = triangle_area(ndpixel, nd1, nd2);
    let kb = triangle_area(ndpixel, nd2, nd0);
    let kc = triangle_area(ndpixel, nd0, nd1);

    let k_max = [
        get_max_flush_to_zero(get_max_value_within_error(ka, BARYCENTRIC_ERROR)),
        get_max_flush_to_zero(get_max_value_within_error(kb, BARYCENTRIC_ERROR)),
        get_max_flush_to_zero(get_max_value_within_error(kc, BARYCENTRIC_ERROR)),
    ];
    let k_min = [
        get_min_flush_to_zero(get_min_value_within_error(ka, BARYCENTRIC_ERROR)),
        get_min_flush_to_zero(get_min_value_within_error(kb, BARYCENTRIC_ERROR)),
        get_min_flush_to_zero(get_min_value_within_error(kc, BARYCENTRIC_ERROR)),
    ];

    // weights: vec3(ka / p0.w, kb / p1.w, kc / p2.w) / (ka / p0.w + kb / p1.w + kc / p2.w)
    let w = [p0.w(), p1.w(), p2.w()];
    let max_pre_division_values: [f32; 3] = std::array::from_fn(|i| {
        get_max_flush_to_zero(get_max_value_within_error(
            get_max_flush_to_zero(k_max[i] / w[i]),
            DIV_ERROR,
        ))
    });
    let min_pre_division_values: [f32; 3] = std::array::from_fn(|i| {
        get_min_flush_to_zero(get_min_value_within_error(
            get_min_flush_to_zero(k_min[i] / w[i]),
            DIV_ERROR,
        ))
    });

    let max_divisor = get_max_flush_to_zero(get_max_value_within_error(
        max_pre_division_values[0] + max_pre_division_values[1] + max_pre_division_values[2],
        2 * ROUND_ERROR,
    ));
    let min_divisor = get_min_flush_to_zero(get_min_value_within_error(
        min_pre_division_values[0] + min_pre_division_values[1] + min_pre_division_values[2],
        2 * ROUND_ERROR,
    ));

    let max: [f32; 3] = std::array::from_fn(|i| {
        get_max_flush_to_zero(get_max_value_within_error(
            get_max_flush_to_zero(maximal_range_division(
                min_pre_division_values[i],
                max_pre_division_values[i],
                min_divisor,
                max_divisor,
            )),
            DIV_ERROR,
        ))
    });
    let min: [f32; 3] = std::array::from_fn(|i| {
        get_min_flush_to_zero(get_min_value_within_error(
            get_min_flush_to_zero(minimal_range_division(
                min_pre_division_values[i],
                max_pre_division_values[i],
                min_divisor,
                max_divisor,
            )),
            DIV_ERROR,
        ))
    });

    InterpolationRange { max, min }
}

/// `TriangleInterpolator::interpolate`
fn triangle_interpolate(
    scene: &TriangleSceneSpec,
    primitive_ndx: usize,
    pixel: IVec2,
    viewport_size: IVec2,
    multisample: bool,
    subpixel_bits: i32,
) -> InterpolationRange {
    // allow anywhere in the pixel area in multisample; allow only in the center
    // subpixels (4 subpixels) in singlesample
    let test_square_size = if multisample {
        1.0
    } else {
        2.0 / (1u64 << subpixel_bits) as f32
    };
    let test_square_pos = if multisample { 0.0 } else { 0.5 - test_square_size / 2.0 };

    let ndc = |x_off: f32, y_off: f32| {
        Vec2::new(
            (pixel.x() as f32 + test_square_pos + x_off) / viewport_size.x() as f32 * 2.0 - 1.0,
            (pixel.y() as f32 + test_square_pos + y_off) / viewport_size.y() as f32 * 2.0 - 1.0,
        )
    };
    let corners = [
        ndc(0.0, 0.0),
        ndc(0.0, test_square_size),
        ndc(test_square_size, test_square_size),
        ndc(test_square_size, 0.0),
    ];

    let tri = &scene.triangles[primitive_ndx];
    let weights: [InterpolationRange; 4] =
        corners.map(|c| calc_triangle_interpolation_weights(tri.positions[0], tri.positions[1], tri.positions[2], c));

    let mut result = InterpolationRange {
        max: [f32::NEG_INFINITY; 3],
        min: [f32::INFINITY; 3],
    };
    for w in &weights {
        for k in 0..3 {
            result.min[k] = result.min[k].min(w.min[k]);
            result.max[k] = result.max[k].max(w.max[k]);
        }
    }
    result
}

fn vec4_min(a: Vec4, b: Vec4) -> Vec4 {
    Vec4::from_array(std::array::from_fn(|i| a.m_data[i].min(b.m_data[i])))
}

fn vec4_max(a: Vec4, b: Vec4) -> Vec4 {
    Vec4::from_array(std::array::from_fn(|i| a.m_data[i].max(b.m_data[i])))
}

/// `verifyTriangleGroupInterpolation`'s return value, same no-log/no-stash convention as
/// `RasterizationVerifyResult` above.
#[derive(Clone, Copy, Debug)]
pub struct InterpolationVerifyResult {
    pub ok: bool,
    pub invalid_pixels: i32,
}

/// `verifyTriangleGroupInterpolation` - upstream's public entry point always calls
/// `verifyTriangleGroupInterpolationWithInterpolator` with a `TriangleInterpolator`
/// (never the line one, which only `verifyMultisampleLineGroupInterpolation` uses), so
/// that is the only instantiation this port needs.
pub fn verify_triangle_group_interpolation(
    surface: &Surface,
    scene: &TriangleSceneSpec,
    args: &RasterizationArguments,
) -> InterpolationVerifyResult {
    let multisampled = args.num_samples != 0;
    let viewport_size = IVec2::new(surface.get_width(), surface.get_height());
    let subpixel_bits = args.subpixel_bits.clamp(0, 16);
    let mut invalid_pixels = 0;

    for y in 0..surface.get_height() {
        for x in 0..surface.get_width() {
            let color = surface.get_pixel(x, y);
            let mut stack_bottom_found = false;
            let mut stack_size: i32 = 0;
            let mut color_stack_min = Vec4::splat(0.0);
            let mut color_stack_max = Vec4::splat(0.0);

            // Iterate triangle coverage front to back, find the stack of potentially
            // contributing fragments.
            for tri_ndx in (0..scene.triangles.len()).rev() {
                let tri = &scene.triangles[tri_ndx];
                let coverage = calculate_triangle_coverage(
                    tri.positions[0],
                    tri.positions[1],
                    tri.positions[2],
                    IVec2::new(x, y),
                    viewport_size,
                    subpixel_bits,
                    multisampled,
                );

                if coverage == CoverageType::Full || coverage == CoverageType::Partial {
                    let weights = triangle_interpolate(
                        scene,
                        tri_ndx,
                        IVec2::new(x, y),
                        viewport_size,
                        multisampled,
                        subpixel_bits,
                    );

                    let fragment_color_max = tri.colors[0] * weights.max[0].clamp(0.0, 1.0)
                        + tri.colors[1] * weights.max[1].clamp(0.0, 1.0)
                        + tri.colors[2] * weights.max[2].clamp(0.0, 1.0);
                    let fragment_color_min = tri.colors[0] * weights.min[0].clamp(0.0, 1.0)
                        + tri.colors[1] * weights.min[1].clamp(0.0, 1.0)
                        + tri.colors[2] * weights.min[2].clamp(0.0, 1.0);

                    if stack_size == 0 {
                        color_stack_min = fragment_color_min;
                        color_stack_max = fragment_color_max;
                    } else {
                        color_stack_min = vec4_min(color_stack_min, fragment_color_min);
                        color_stack_max = vec4_max(color_stack_max, fragment_color_max);
                    }
                    stack_size += 1;

                    if coverage == CoverageType::Full {
                        // bottommost fragment; loop terminates
                        stack_bottom_found = true;
                        break;
                    }
                }
            }

            // Partial coverage == background may be visible.
            if stack_size != 0 && !stack_bottom_found {
                stack_size += 1;
                color_stack_min = Vec4::new(0.0, 0.0, 0.0, 1.0);
            }

            if stack_size == 0 {
                // No coverage, allow only background (black, value=0).
                let native = convert_rgb8_to_native_format(color, args);
                const THRESHOLD: i32 = 1;
                if native.x() > THRESHOLD || native.y() > THRESHOLD || native.z() > THRESHOLD {
                    invalid_pixels += 1;
                }
            } else {
                // Each additional step in the stack may cause conversion error of 1 bit
                // due to undefined rounding direction.
                let threshold = stack_size - 1;

                let format_limit = [
                    (1i32 << args.red_bits) - 1,
                    (1i32 << args.green_bits) - 1,
                    (1i32 << args.blue_bits) - 1,
                ];
                let color_min_f: [f32; 3] = std::array::from_fn(|i| {
                    (color_stack_min.m_data[i] * format_limit[i] as f32).clamp(0.0, format_limit[i] as f32)
                });
                let color_max_f: [f32; 3] = std::array::from_fn(|i| {
                    (color_stack_max.m_data[i] * format_limit[i] as f32).clamp(0.0, format_limit[i] as f32)
                });
                let color_min: [i32; 3] = std::array::from_fn(|i| color_min_f[i].floor() as i32);
                let color_max: [i32; 3] = std::array::from_fn(|i| color_max_f[i].ceil() as i32);

                let native = convert_rgb8_to_native_format(color, args);
                let native_arr = [native.x(), native.y(), native.z()];
                let out_of_range = (0..3)
                    .any(|i| native_arr[i] < color_min[i] - threshold || native_arr[i] > color_max[i] + threshold);
                if out_of_range {
                    invalid_pixels += 1;
                }
            }
        }
    }

    InterpolationVerifyResult {
        ok: invalid_pixels == 0,
        invalid_pixels,
    }
}

// --- Narrow (lineWidth == 1.0) line colour-interpolation verification.
// `calcLineInterpolationWeights`/`calcLineInterpolationWeightsAxisProjected` +
// `verifyLineGroupPixelIndependentInterpolation`, reached from upstream's public
// `verifyLineGroupInterpolation` only via its narrow-line branch
// (`verifySinglesampleNarrowLineGroupInterpolation`, tried first) and its final
// fallback (`verifyLineGroupInterpolationWithProjectedWeights`) - both are thin
// wrappers calling the same shared function with a different weight equation, which is
// why one function covers both. The *wide*-line branch
// (`verifySinglesampleWideLineGroupInterpolation`, upstream's own largest single
// function in this file at ~360 lines, handling a line's width as a projected quad
// rather than a single interpolation parameter) is not ported - see the module header.
// `setMaskMapCoverageBitForLine(s)` needs no new rasterization code at all: it is
// `rasterize_single_sample_line` called once per line, OR-ing a per-line bit into a
// coverage bitmask instead of a single winning line index (plain `verify_single_sample_line_group_rasterization`'s own `reference_line_map` stores "the last
// line to cover this pixel"; this needs "every line that might cover this pixel", since
// nearby lines of different colours can leave a pixel's correct colour ambiguous
// without checking each candidate). ---

/// `LineInterpolationRange` - a `tcu::Vec2` pair upstream (`.x()` the weight for
/// `colors[0]`, `.y()` for `colors[1]`); kept as `Vec2` directly here since `Vec2`
/// already exists and nothing else needs a bespoke pair type for this one.
#[derive(Clone, Copy, Debug)]
struct LineInterpolationRange {
    max: Vec2,
    min: Vec2,
}

fn dot2(a: Vec2, b: Vec2) -> f32 {
    a.x() * b.x() + a.y() * b.y()
}

/// `isLineXMajor`
fn is_line_x_major(pa: Vec2, pb: Vec2) -> bool {
    (pb.x() - pa.x()).abs() >= (pb.y() - pa.y()).abs()
}

/// `calcLineInterpolationWeights` - the GL spec's exact (non-axis-projected)
/// perspective line interpolation weights, as an error-bounded range rather than a
/// single value (same ULP/flush-to-zero approach `calc_triangle_interpolation_weights`
/// above uses, reusing its helpers unchanged).
fn calc_line_interpolation_weights(pa: Vec2, wa: f32, pb: Vec2, wb: f32, pr: Vec2) -> LineInterpolationRange {
    const DIV_ERROR: u32 = 3;
    const ROUND_ERROR: u32 = 1;

    let dividend = dot2(pr - pa, pb - pa);
    let dividend_max = get_max_value_within_error(dividend, 1);
    let dividend_min = get_min_value_within_error(dividend, 1);

    let divisor = length_squared(pb - pa);
    let divisor_max = get_max_value_within_error(divisor, 1);
    let divisor_min = get_min_value_within_error(divisor, 1);

    let t_max = get_max_value_within_error(
        maximal_range_division(dividend_min, dividend_max, divisor_min, divisor_max),
        DIV_ERROR,
    );
    let t_min = get_min_value_within_error(
        minimal_range_division(dividend_min, dividend_max, divisor_min, divisor_max),
        DIV_ERROR,
    );

    let perspective_t_max = get_max_value_within_error(maximal_range_division(t_min, t_max, wb, wb), DIV_ERROR);
    let perspective_t_min = get_min_value_within_error(minimal_range_division(t_min, t_max, wb, wb), DIV_ERROR);

    let perspective_inv_t_max =
        get_max_value_within_error(maximal_range_division(1.0 - t_max, 1.0 - t_min, wa, wa), DIV_ERROR);
    let perspective_inv_t_min =
        get_min_value_within_error(minimal_range_division(1.0 - t_max, 1.0 - t_min, wa, wa), DIV_ERROR);

    let perspective_divisor_max = get_max_value_within_error(perspective_t_max + perspective_inv_t_max, ROUND_ERROR);
    let perspective_divisor_min = get_min_value_within_error(perspective_t_min + perspective_inv_t_min, ROUND_ERROR);

    LineInterpolationRange {
        max: Vec2::new(
            get_max_value_within_error(
                maximal_range_division(
                    perspective_inv_t_min,
                    perspective_inv_t_max,
                    perspective_divisor_min,
                    perspective_divisor_max,
                ),
                DIV_ERROR,
            ),
            get_max_value_within_error(
                maximal_range_division(
                    perspective_t_min,
                    perspective_t_max,
                    perspective_divisor_min,
                    perspective_divisor_max,
                ),
                DIV_ERROR,
            ),
        ),
        min: Vec2::new(
            get_min_value_within_error(
                minimal_range_division(
                    perspective_inv_t_min,
                    perspective_inv_t_max,
                    perspective_divisor_min,
                    perspective_divisor_max,
                ),
                DIV_ERROR,
            ),
            get_min_value_within_error(
                minimal_range_division(
                    perspective_t_min,
                    perspective_t_max,
                    perspective_divisor_min,
                    perspective_divisor_max,
                ),
                DIV_ERROR,
            ),
        ),
    }
}

/// `calcLineInterpolationWeightsAxisProjected` - the "inaccurate" method some
/// implementations use: `t` is computed by projecting onto the line's major axis
/// instead of `calc_line_interpolation_weights`'s own dot-product formula.
fn calc_line_interpolation_weights_axis_projected(
    pa: Vec2,
    wa: f32,
    pb: Vec2,
    wb: f32,
    pr: Vec2,
) -> LineInterpolationRange {
    const DIV_ERROR: u32 = 3;
    const ROUND_ERROR: u32 = 1;
    let major = if is_line_x_major(pa, pb) { 0 } else { 1 };
    let pr_major = if major == 0 { pr.x() } else { pr.y() };
    let pa_major = if major == 0 { pa.x() } else { pa.y() };
    let pb_major = if major == 0 { pb.x() } else { pb.y() };

    let dividend = pr_major - pa_major;
    let dividend_max = get_max_value_within_error(dividend, 1);
    let dividend_min = get_min_value_within_error(dividend, 1);

    let divisor = pb_major - pa_major;
    let divisor_max = get_max_value_within_error(divisor, 1);
    let divisor_min = get_min_value_within_error(divisor, 1);

    let t_max = get_max_value_within_error(
        maximal_range_division(dividend_min, dividend_max, divisor_min, divisor_max),
        DIV_ERROR,
    );
    let t_min = get_min_value_within_error(
        minimal_range_division(dividend_min, dividend_max, divisor_min, divisor_max),
        DIV_ERROR,
    );

    let perspective_t_max = get_max_value_within_error(maximal_range_division(t_min, t_max, wb, wb), DIV_ERROR);
    let perspective_t_min = get_min_value_within_error(minimal_range_division(t_min, t_max, wb, wb), DIV_ERROR);

    let perspective_inv_t_max =
        get_max_value_within_error(maximal_range_division(1.0 - t_max, 1.0 - t_min, wa, wa), DIV_ERROR);
    let perspective_inv_t_min =
        get_min_value_within_error(minimal_range_division(1.0 - t_max, 1.0 - t_min, wa, wa), DIV_ERROR);

    let perspective_divisor_max = get_max_value_within_error(perspective_t_max + perspective_inv_t_max, ROUND_ERROR);
    let perspective_divisor_min = get_min_value_within_error(perspective_t_min + perspective_inv_t_min, ROUND_ERROR);

    LineInterpolationRange {
        max: Vec2::new(
            get_max_value_within_error(
                maximal_range_division(
                    perspective_inv_t_min,
                    perspective_inv_t_max,
                    perspective_divisor_min,
                    perspective_divisor_max,
                ),
                DIV_ERROR,
            ),
            get_max_value_within_error(
                maximal_range_division(
                    perspective_t_min,
                    perspective_t_max,
                    perspective_divisor_min,
                    perspective_divisor_max,
                ),
                DIV_ERROR,
            ),
        ),
        min: Vec2::new(
            get_min_value_within_error(
                minimal_range_division(
                    perspective_inv_t_min,
                    perspective_inv_t_max,
                    perspective_divisor_min,
                    perspective_divisor_max,
                ),
                DIV_ERROR,
            ),
            get_min_value_within_error(
                minimal_range_division(
                    perspective_t_min,
                    perspective_t_max,
                    perspective_divisor_min,
                    perspective_divisor_max,
                ),
                DIV_ERROR,
            ),
        ),
    }
}

/// `calcSingleSampleLineInterpolationRangeWithWeightEquation` - "allow interpolation
/// weights anywhere in the central subpixels": samples the given weight equation at the
/// four corners of a tiny square centered on the pixel (sized by `subpixel_bits`) and
/// returns the union of their ranges.
fn calc_single_sample_line_interpolation_range_with_weight_equation(
    pa: Vec2,
    wa: f32,
    pb: Vec2,
    wb: f32,
    pixel: (i32, i32),
    subpixel_bits: i32,
    weight_equation: fn(Vec2, f32, Vec2, f32, Vec2) -> LineInterpolationRange,
) -> LineInterpolationRange {
    let test_square_size = 2.0 / ((1u32 << subpixel_bits) as f32);
    let test_square_pos = 0.5 - test_square_size / 2.0;
    let (px, py) = (pixel.0 as f32, pixel.1 as f32);
    let corners = [
        Vec2::new(px + test_square_pos, py + test_square_pos),
        Vec2::new(px + test_square_pos, py + test_square_pos + test_square_size),
        Vec2::new(
            px + test_square_pos + test_square_size,
            py + test_square_pos + test_square_size,
        ),
        Vec2::new(px + test_square_pos + test_square_size, py + test_square_pos),
    ];
    let weights = corners.map(|c| weight_equation(pa, wa, pb, wb, c));

    let min = weights.iter().fold(Vec2::new(f32::INFINITY, f32::INFINITY), |acc, w| {
        Vec2::new(acc.x().min(w.min.x()), acc.y().min(w.min.y()))
    });
    let max = weights
        .iter()
        .fold(Vec2::new(f32::NEG_INFINITY, f32::NEG_INFINITY), |acc, w| {
            Vec2::new(acc.x().max(w.max.x()), acc.y().max(w.max.y()))
        });

    LineInterpolationRange { max, min }
}

fn calc_single_sample_line_interpolation_range(
    pa: Vec2,
    wa: f32,
    pb: Vec2,
    wb: f32,
    pixel: (i32, i32),
    subpixel_bits: i32,
) -> LineInterpolationRange {
    calc_single_sample_line_interpolation_range_with_weight_equation(
        pa,
        wa,
        pb,
        wb,
        pixel,
        subpixel_bits,
        calc_line_interpolation_weights,
    )
}

fn calc_single_sample_line_interpolation_range_axis_projected(
    pa: Vec2,
    wa: f32,
    pb: Vec2,
    wb: f32,
    pixel: (i32, i32),
    subpixel_bits: i32,
) -> LineInterpolationRange {
    calc_single_sample_line_interpolation_range_with_weight_equation(
        pa,
        wa,
        pb,
        wb,
        pixel,
        subpixel_bits,
        calc_line_interpolation_weights_axis_projected,
    )
}

/// `rr::LineExitDiamondGenerator::init` + `::rasterize`, collapsed into one pure
/// function returning every diamond-exit position directly. Unlike
/// `rasterize_single_sample_line`, this does **not** clamp its walk to a viewport or
/// replicate for line width - it is upstream's own generic, viewport-unbounded
/// diamond walk (upstream's own doc comment: "provided to prevent test cases requiring
/// accurate diamonds from abusing SingleSampleLineRasterizer"), used below only to find
/// a wide line's "root" fragment position at each major-axis coordinate.
fn line_exit_diamonds(v0: Vec2, v1: Vec2, bits: i32) -> Vec<(i32, i32)> {
    let x0 = to_subpixel_coord_f32(v0.x(), bits);
    let y0 = to_subpixel_coord_f32(v0.y(), bits);
    let x1 = to_subpixel_coord_f32(v1.x(), bits);
    let y1 = to_subpixel_coord_f32(v1.y(), bits);

    let one_subpixel = to_subpixel_coord_i32(1, bits);
    let x_min = x0.min(x1) - one_subpixel;
    let x_max = x0.max(x1) + one_subpixel;
    let y_min = y0.min(y1) - one_subpixel;
    let y_max = y0.max(y1) + one_subpixel;

    let bbox_min_x = floor_subpixel_to_pixel_coord(x_min, bits, true);
    let bbox_min_y = floor_subpixel_to_pixel_coord(y_min, bits, true);
    let bbox_max_x = ceil_subpixel_to_pixel_coord(x_max, bits, true);
    let bbox_max_y = ceil_subpixel_to_pixel_coord(y_max, bits, true);

    let half_pixel: i64 = 1i64 << (bits - 1);
    let pa = to_subpixel_vector_f(v0, bits);
    let pb = to_subpixel_vector_f(v1, bits);
    let line = SubpixelLineSegment::new(pa, pb);

    let mut out = Vec::new();
    let mut cur = (bbox_min_x, bbox_min_y);
    while cur.1 <= bbox_max_y {
        let diamond_position = i64_add(to_subpixel_vector_i(cur, bits), (half_pixel, half_pixel));
        if does_line_segment_exit_diamond(&line, diamond_position, bits) {
            out.push(cur);
        }
        cur.0 += 1;
        if cur.0 > bbox_max_x {
            cur.1 += 1;
            cur.0 = bbox_min_x;
        }
    }
    out
}

/// `getLineCoordAtAxisCoord` - the point on the infinite line through `pa`/`pb` at a
/// given coordinate along the major (`is_x_axis`) or minor axis, found by linear
/// extrapolation. Panics (matching upstream's `DE_ASSERT(fixedDifference != 0.0f)`) if
/// the line has zero extent along that axis - every caller here only ever extrapolates
/// along a line's own *major* axis, which cannot be zero by construction.
fn get_line_coord_at_axis_coord(pa: Vec2, pb: Vec2, is_x_axis: bool, axis_coord: f32) -> Vec2 {
    let (fixed_idx, varying_idx) = if is_x_axis { (0, 1) } else { (1, 0) };
    let fixed_difference = pb[fixed_idx] - pa[fixed_idx];
    let varying_difference = pb[varying_idx] - pa[varying_idx];
    debug_assert_ne!(fixed_difference, 0.0);

    let result_fixed_coord = axis_coord;
    let result_varying_coord = pa[varying_idx] + (axis_coord - pa[fixed_idx]) * (varying_difference / fixed_difference);

    if is_x_axis {
        Vec2::new(result_fixed_coord, result_varying_coord)
    } else {
        Vec2::new(result_varying_coord, result_fixed_coord)
    }
}

/// `setMaskMapCoverageBitForLines` - per-pixel bitmask of which lines might cover it,
/// built with the same `rasterize_single_sample_line` the rasterization verifier uses.
/// Shared by the narrow (`verify_line_group_pixel_independent_interpolation`) and wide
/// (`verify_single_sample_wide_line_group_interpolation`) interpolation verifiers below,
/// exactly as upstream's own free function is shared by both.
fn set_mask_map_coverage_bit_for_lines(
    width: i32,
    height: i32,
    screen_lines: &[(Vec2, Vec2)],
    line_width: f32,
    subpixel_bits: i32,
) -> Vec<u8> {
    let viewport = (0, 0, width, height);
    let idx = |x: i32, y: i32| (y as usize) * (width as usize) + (x as usize);
    let mut coverage_map = vec![0u8; (width as usize) * (height as usize)];
    for (line_ndx, &(p0, p1)) in screen_lines.iter().enumerate() {
        let fragments = rasterize_single_sample_line(
            Vec4::new(p0.x(), p0.y(), 0.0, 1.0),
            Vec4::new(p1.x(), p1.y(), 0.0, 1.0),
            line_width,
            viewport,
            subpixel_bits,
        );
        for (x, y) in fragments {
            if x < 0 || y < 0 || x >= width || y >= height {
                continue;
            }
            coverage_map[idx(x, y)] |= 1 << line_ndx;
        }
    }
    coverage_map
}

/// `verifyLineGroupPixelIndependentInterpolation` - `strict` selects
/// `calc_line_interpolation_weights` (upstream's `LINEINTERPOLATION_STRICTLY_CORRECT`)
/// vs `calc_line_interpolation_weights_axis_projected` (`LINEINTERPOLATION_PROJECTED`).
/// Limited to 8 lines per scene, matching upstream's own 8-bit coverage bitmask.
fn verify_line_group_pixel_independent_interpolation(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
    strict: bool,
) -> bool {
    debug_assert!(scene.lines.len() < 8);
    let black = RGBA::new(0, 0, 0, 255);
    let width = surface.get_width();
    let height = surface.get_height();
    let subpixel_bits = args.subpixel_bits.clamp(0, 16);
    let idx = |x: i32, y: i32| (y as usize) * (width as usize) + (x as usize);

    let mut screen_lines: Vec<(Vec2, Vec2)> = Vec::with_capacity(scene.lines.len());
    for line in &scene.lines {
        let p0 = line_vertex_to_screen_space(line.positions[0], (width as f32, height as f32));
        let p1 = line_vertex_to_screen_space(line.positions[1], (width as f32, height as f32));
        screen_lines.push((p0, p1));
    }
    let coverage_map =
        set_mask_map_coverage_bit_for_lines(width, height, &screen_lines, scene.line_width, subpixel_bits);

    let format_limit = IVec3::new(
        (1 << args.red_bits) - 1,
        (1 << args.green_bits) - 1,
        (1 << args.blue_bits) - 1,
    );
    let mut invalid_pixels = 0;

    for y in 1..height - 1 {
        for x in 1..width - 1 {
            let color = surface.get_pixel(x, y);
            let pixel_native_color = convert_rgb8_to_native_format(color, args);

            let mut line_coverage_set: u8 = 0;
            let mut line_surrounding_coverage: u8 = 0xFF;
            for dy in -1..=1 {
                for dx in -1..=1 {
                    let coverage = coverage_map[idx(x + dx, y + dy)];
                    line_coverage_set |= coverage;
                    line_surrounding_coverage &= coverage;
                }
            }

            // background color is possible?
            if line_surrounding_coverage == 0
                && compare_colors(color, black, args.red_bits, args.green_bits, args.blue_bits)
            {
                continue;
            }

            let mut match_found = false;
            for (line_ndx, line) in scene.lines.iter().enumerate() {
                if (line_coverage_set >> line_ndx) & 1 == 0 {
                    continue;
                }

                let (pa, pb) = screen_lines[line_ndx];
                let wa = line.positions[0].w();
                let wb = line.positions[1].w();
                let range = if strict {
                    calc_single_sample_line_interpolation_range(pa, wa, pb, wb, (x, y), subpixel_bits)
                } else {
                    calc_single_sample_line_interpolation_range_axis_projected(pa, wa, pb, wb, (x, y), subpixel_bits)
                };

                let value_min =
                    line.colors[0] * range.min.x().clamp(0.0, 1.0) + line.colors[1] * range.min.y().clamp(0.0, 1.0);
                let value_max =
                    line.colors[0] * range.max.x().clamp(0.0, 1.0) + line.colors[1] * range.max.y().clamp(0.0, 1.0);

                let clamped = |v: f32, limit: i32| (v * limit as f32).clamp(0.0, limit as f32);
                let color_min = IVec3::new(
                    clamped(value_min.x(), format_limit.x()).floor() as i32,
                    clamped(value_min.y(), format_limit.y()).floor() as i32,
                    clamped(value_min.z(), format_limit.z()).floor() as i32,
                );
                let color_max = IVec3::new(
                    clamped(value_max.x(), format_limit.x()).ceil() as i32,
                    clamped(value_max.y(), format_limit.y()).ceil() as i32,
                    clamped(value_max.z(), format_limit.z()).ceil() as i32,
                );

                if pixel_native_color.x() < color_min.x()
                    || pixel_native_color.y() < color_min.y()
                    || pixel_native_color.z() < color_min.z()
                    || pixel_native_color.x() > color_max.x()
                    || pixel_native_color.y() > color_max.y()
                    || pixel_native_color.z() > color_max.z()
                {
                    continue;
                }
                match_found = true;
                break;
            }

            if !match_found {
                invalid_pixels += 1;
            }
        }
    }

    invalid_pixels == 0
}

/// For a wide line's already width-shifted "effective" line (`pa`/`pb`), the "root"
/// fragment's minor-axis coordinate at every major-axis position in `0..major_size` -
/// the position a wide line's fragment column (row for y-major) is replicated from.
/// Mirrors upstream's dedicated `rr::LineExitDiamondGenerator` pass in
/// `verifySinglesampleWideLineGroupInterpolation`: the line is first extended one pixel
/// past each end of the *viewport* (not its own endpoints - "the implementation's
/// fragment major coordinate range might not be a subset of the correct line range"),
/// so every major position gets an entry even if the real segment is shorter.
/// `None` at a position is possible only if the diamond walk genuinely never produced a
/// candidate there (upstream expects this never to happen and asserts it in debug);
/// treated as "no candidate" rather than panicking, since nothing downstream needs it
/// to be infallible.
fn root_pixel_locations(pa: Vec2, pb: Vec2, is_x_major: bool, major_size: i32, bits: i32) -> Vec<Option<i32>> {
    let expanded_p0 = get_line_coord_at_axis_coord(pa, pb, is_x_major, -1.0);
    let expanded_p1 = get_line_coord_at_axis_coord(pa, pb, is_x_major, major_size as f32 + 1.0);

    let mut table = vec![None; major_size as usize];
    for (x, y) in line_exit_diamonds(expanded_p0, expanded_p1, bits) {
        let (major_pos, minor_pos) = if is_x_major { (x, y) } else { (y, x) };
        if major_pos >= 0 && major_pos < major_size {
            table[major_pos as usize] = Some(minor_pos);
        }
    }
    table
}

/// `verifySinglesampleWideLineGroupInterpolation` - wide-line (`lineWidth > 1.0`)
/// colour interpolation. Unlike the narrow-line path above, a wide line's fragments are
/// not interpolated independently at their own screen position: the whole fragment
/// column (row for y-major) a wide line occupies at a given major-axis position is
/// replicated from a single "root" fragment, computed on the line shifted by
/// `(lineWidth - 1) / 2` towards the minor-negative direction (`effective_lines` below).
/// So verification works backward from each surface pixel to the covering line(s)' root
/// fragment candidate(s) (the root position itself, and one pixel to either side along
/// the minor axis - an implementation is allowed to round the root to any of the three)
/// rather than interpolating directly at the pixel itself. Limited to 8 lines per scene,
/// matching upstream's own 8-bit coverage bitmask (same limit the narrow path has).
fn verify_single_sample_wide_line_group_interpolation(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
) -> bool {
    debug_assert!(scene.lines.len() < 8);
    let width = surface.get_width();
    let height = surface.get_height();
    let subpixel_bits = args.subpixel_bits.clamp(0, 16);
    let idx = |x: i32, y: i32| (y as usize) * (width as usize) + (x as usize);

    let mut screen_lines: Vec<(Vec2, Vec2)> = Vec::with_capacity(scene.lines.len());
    for line in &scene.lines {
        let p0 = line_vertex_to_screen_space(line.positions[0], (width as f32, height as f32));
        let p1 = line_vertex_to_screen_space(line.positions[1], (width as f32, height as f32));
        screen_lines.push((p0, p1));
    }
    let coverage_map =
        set_mask_map_coverage_bit_for_lines(width, height, &screen_lines, scene.line_width, subpixel_bits);

    // `effectiveLines` - each line shifted towards the minor-negative direction by half
    // its (raw, unrounded) width, same formula `rasterize_single_sample_line` applies
    // internally (there via the *rounded* integer width - a deliberately different
    // computation for a deliberately different purpose, see that function's own body).
    let mut line_is_x_major = vec![false; scene.lines.len()];
    let mut effective_lines: Vec<(Vec2, Vec2)> = Vec::with_capacity(scene.lines.len());
    let mut root_tables: Vec<Vec<Option<i32>>> = Vec::with_capacity(scene.lines.len());
    for (line_ndx, &(p0, p1)) in screen_lines.iter().enumerate() {
        let is_x_major = is_line_x_major(p0, p1);
        line_is_x_major[line_ndx] = is_x_major;

        let offset_length = (scene.line_width - 1.0) / 2.0;
        let offset = if is_x_major {
            Vec2::new(0.0, -offset_length)
        } else {
            Vec2::new(-offset_length, 0.0)
        };
        let eff_p0 = p0 + offset;
        let eff_p1 = p1 + offset;
        effective_lines.push((eff_p0, eff_p1));

        let major_size = if is_x_major { width } else { height };
        root_tables.push(root_pixel_locations(
            eff_p0,
            eff_p1,
            is_x_major,
            major_size,
            subpixel_bits,
        ));
    }

    let format_limit = IVec3::new(
        (1 << args.red_bits) - 1,
        (1 << args.green_bits) - 1,
        (1 << args.blue_bits) - 1,
    );
    let mut invalid_pixels = 0;

    for y in 1..height - 1 {
        for x in 1..width - 1 {
            let color = surface.get_pixel(x, y);
            let pixel_native_color = convert_rgb8_to_native_format(color, args);

            let mut line_coverage_set: u8 = 0;
            let mut line_surrounding_coverage: u8 = 0xFF;
            for dy in -1..=1 {
                for dx in -1..=1 {
                    let c = coverage_map[idx(x + dx, y + dy)];
                    line_coverage_set |= c;
                    line_surrounding_coverage &= c;
                }
            }

            // background color is possible?
            if line_surrounding_coverage == 0
                && compare_colors(
                    color,
                    RGBA::new(0, 0, 0, 255),
                    args.red_bits,
                    args.green_bits,
                    args.blue_bits,
                )
            {
                continue;
            }

            let mut match_found = false;
            for (line_ndx, line) in scene.lines.iter().enumerate() {
                if (line_coverage_set >> line_ndx) & 1 == 0 {
                    continue;
                }

                let wa = line.positions[0].w();
                let wb = line.positions[1].w();
                let (pa, pb) = effective_lines[line_ndx];
                let is_x_major = line_is_x_major[line_ndx];
                let major_position = if is_x_major { x } else { y };
                let minor_position = match root_tables[line_ndx][major_position as usize] {
                    Some(v) => v,
                    None => continue,
                };
                let ideal_root = if is_x_major {
                    (major_position, minor_position)
                } else {
                    (minor_position, major_position)
                };
                let minor_direction = if is_x_major { (0, 1) } else { (1, 0) };

                // Interpolation happens at the root fragment, which is then replicated
                // in the minor direction. Search for the implementation's root position
                // near the accurate root (any of the 3 candidates may be the real one).
                let mut line_match = false;
                for minor_offset in -1..=1 {
                    let root_x = ideal_root.0 + minor_offset * minor_direction.0;
                    let root_y = ideal_root.1 + minor_offset * minor_direction.1;

                    // A fragment can be the root fragment only if it exists - note no
                    // pixel-format threshold, since allowing only exact black is more
                    // conservative here (matches upstream's own `isBlack`, not
                    // `compareColors`).
                    if root_x >= 0 && root_x < width && root_y >= 0 && root_y < height {
                        let root_color = surface.get_pixel(root_x, root_y);
                        if root_color.get_red() == 0 && root_color.get_green() == 0 && root_color.get_blue() == 0 {
                            continue;
                        }
                    }

                    let range =
                        calc_single_sample_line_interpolation_range(pa, wa, pb, wb, (root_x, root_y), subpixel_bits);
                    let value_min =
                        line.colors[0] * range.min.x().clamp(0.0, 1.0) + line.colors[1] * range.min.y().clamp(0.0, 1.0);
                    let value_max =
                        line.colors[0] * range.max.x().clamp(0.0, 1.0) + line.colors[1] * range.max.y().clamp(0.0, 1.0);

                    let clamped = |v: f32, limit: i32| (v * limit as f32).clamp(0.0, limit as f32);
                    let color_min = IVec3::new(
                        clamped(value_min.x(), format_limit.x()).floor() as i32,
                        clamped(value_min.y(), format_limit.y()).floor() as i32,
                        clamped(value_min.z(), format_limit.z()).floor() as i32,
                    );
                    let color_max = IVec3::new(
                        clamped(value_max.x(), format_limit.x()).ceil() as i32,
                        clamped(value_max.y(), format_limit.y()).ceil() as i32,
                        clamped(value_max.z(), format_limit.z()).ceil() as i32,
                    );

                    if pixel_native_color.x() >= color_min.x()
                        && pixel_native_color.y() >= color_min.y()
                        && pixel_native_color.z() >= color_min.z()
                        && pixel_native_color.x() <= color_max.x()
                        && pixel_native_color.y() <= color_max.y()
                        && pixel_native_color.z() <= color_max.z()
                    {
                        line_match = true;
                        break;
                    }
                }

                if line_match {
                    match_found = true;
                    break;
                }
            }

            if !match_found {
                invalid_pixels += 1;
            }
        }
    }

    invalid_pixels == 0
}

// --- Multisample line colour-interpolation verification ---
// `MultisampleLineInterpolator::interpolate` + `verifyMultisampleLineGroupInterpolationInternal`,
// restricted to this port's own calling convention - the same restriction the multisample
// *rasterization* function above already established (see its own doc comment):
// `verifyLineGroupInterpolation`'s multisample branch always calls
// `verifyMultisampleLineGroupInterpolation` with its default `strictMode = true`, never
// varying it, so only `verifyTriangleGroupInterpolationWithInterpolator<MultisampleLineInterpolator>`'s
// path is live here - the non-strict fallback (`TriangleInterpolator` tried first, the
// line interpolator only as its own fallback) is dead code for this port and is not
// ported. Rather than generalizing the already-tested `verify_triangle_group_interpolation`
// over a pluggable interpolator (a real refactor of working code, risking exactly the
// kind of regression a negative control might miss), this duplicates its per-pixel loop
// with `multisample_line_interpolate`'s weight calculation substituted in - this port's
// established preference when the alternative risks reworking tested code.

/// `MultisampleLineInterpolator::interpolate` - note this reads the *original*,
/// unquantised `scene.lines[lineNdx]` positions (screen-space, derived independently
/// from the `w`-divide below) rather than the quad corners
/// `build_multisample_line_interpolation_scene` constructs for coverage testing - exactly
/// matching upstream, which keeps its own `scene` (the `LineSceneSpec`) around inside the
/// interpolator precisely so it can do this.
fn multisample_line_interpolate(
    scene: &LineSceneSpec,
    primitive_ndx: usize,
    pixel: IVec2,
    viewport_size: IVec2,
) -> InterpolationRange {
    // In triangulation, one line emits two triangles.
    let line_ndx = primitive_ndx / 2;
    let line = &scene.lines[line_ndx];

    // Allow interpolation weights anywhere in the pixel.
    let corners = [
        Vec2::new(pixel.x() as f32, pixel.y() as f32),
        Vec2::new(pixel.x() as f32, pixel.y() as f32 + 1.0),
        Vec2::new(pixel.x() as f32 + 1.0, pixel.y() as f32 + 1.0),
        Vec2::new(pixel.x() as f32 + 1.0, pixel.y() as f32),
    ];

    let wa = line.positions[0].w();
    let wb = line.positions[1].w();
    let pa = Vec2::new(
        (line.positions[0].x() / wa + 1.0) * 0.5 * viewport_size.x() as f32,
        (line.positions[0].y() / wa + 1.0) * 0.5 * viewport_size.y() as f32,
    );
    let pb = Vec2::new(
        (line.positions[1].x() / wb + 1.0) * 0.5 * viewport_size.x() as f32,
        (line.positions[1].y() / wb + 1.0) * 0.5 * viewport_size.y() as f32,
    );

    // Calculate interpolation as a line.
    let weights: [LineInterpolationRange; 4] = corners.map(|c| calc_line_interpolation_weights(pa, wa, pb, wb, c));

    let mut min_weights = Vec2::new(f32::INFINITY, f32::INFINITY);
    let mut max_weights = Vec2::new(f32::NEG_INFINITY, f32::NEG_INFINITY);
    for w in &weights {
        min_weights = Vec2::new(min_weights.x().min(w.min.x()), min_weights.y().min(w.min.y()));
        max_weights = Vec2::new(max_weights.x().max(w.max.x()), max_weights.y().max(w.max.y()));
    }

    // Convert to three-component form. For all triangles, vertex 0 is always emitted by
    // the line's starting point, and vertex 2 by its ending point.
    InterpolationRange {
        max: [max_weights.x(), 0.0, max_weights.y()],
        min: [min_weights.x(), 0.0, min_weights.y()],
    }
}

/// The scene-construction half of `verifyMultisampleLineGroupInterpolationInternal` -
/// builds the same "two triangles per line" quad `verify_multisample_line_group_rasterization`
/// does, but additionally carrying each line endpoint's colour onto both of its quad
/// corners (`colors[0]`/`colors[0]`/`colors[1]` for the first triangle,
/// `colors[0]`/`colors[1]`/`colors[1]` for the second - both corners on one line endpoint
/// share that endpoint's colour). Deliberately duplicated rather than shared with the
/// rasterization-only quad builder, which carries no colour at all by design (see its
/// own doc comment).
fn build_multisample_line_interpolation_scene(
    scene: &LineSceneSpec,
    viewport_size: Vec2,
    strict_mode: bool,
) -> TriangleSceneSpec {
    let half_line_width = scene.line_width * 0.5;
    let one_one = Vec2::new(1.0, 1.0);

    let mut triangles = Vec::with_capacity(scene.lines.len() * 2);
    for line in &scene.lines {
        let p0 = Vec2::new(
            line.positions[0].x() / line.positions[0].w(),
            line.positions[0].y() / line.positions[0].w(),
        );
        let p1 = Vec2::new(
            line.positions[1].x() / line.positions[1].w(),
            line.positions[1].y() / line.positions[1].w(),
        );
        let s0 = (p0 + one_one) * 0.5 * viewport_size;
        let s1 = (p1 + one_one) * 0.5 * viewport_size;

        let dir = normalize2(s1 - s0);
        let normal = if strict_mode {
            Vec2::new(dir.y(), -dir.x())
        } else if (s1.x() - s0.x()).abs() >= (s1.y() - s0.y()).abs() {
            Vec2::new(0.0, 1.0)
        } else {
            Vec2::new(1.0, 0.0)
        };

        let quad_screen = [
            s0 + normal * half_line_width,
            s0 - normal * half_line_width,
            s1 - normal * half_line_width,
            s1 + normal * half_line_width,
        ];
        let quad_ndc = quad_screen.map(|q| q / viewport_size * 2.0 - one_one);
        let v = |i: usize| Vec4::new(quad_ndc[i].x(), quad_ndc[i].y(), 0.0, 1.0);

        let c0 = line.colors[0];
        let c1 = line.colors[1];

        let mut t0 = SceneTriangle::with_colors(v(0), v(1), v(2), c0, c0, c1);
        t0.shared_edge[2] = true;
        let mut t1 = SceneTriangle::with_colors(v(0), v(2), v(3), c0, c1, c1);
        t1.shared_edge[0] = true;
        triangles.push(t0);
        triangles.push(t1);
    }

    TriangleSceneSpec { triangles }
}

/// `verifyMultisampleLineGroupInterpolationInternal`'s per-pixel verification loop - a
/// standalone duplicate of `verify_triangle_group_interpolation` with
/// `multisample_line_interpolate` substituted for `triangle_interpolate` (see the
/// section header above for why this is a new function rather than a generalization of
/// that one).
fn verify_multisample_line_group_interpolation(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
) -> bool {
    verify_multisample_line_group_interpolation_internal(surface, scene, args, true)
}

/// `verifyMultisampleLineGroupInterpolationInternal`: the strict mode builds the quad around the line's normal and verifies with the
/// line interpolator only; the other one builds an axis-aligned quad and also accepts triangle interpolation.
fn verify_multisample_line_group_interpolation_internal(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
    strict_mode: bool,
) -> bool {
    let viewport_size = IVec2::new(surface.get_width(), surface.get_height());
    let triangle_scene = build_multisample_line_interpolation_scene(
        scene,
        Vec2::new(viewport_size.x() as f32, viewport_size.y() as f32),
        strict_mode,
    );
    if !strict_mode && verify_triangle_group_interpolation(surface, &triangle_scene, args).ok {
        return true;
    }
    verify_line_interpolation_over_triangles(surface, scene, args, &triangle_scene)
}

/// `verifyTriangulatedLineGroupInterpolation` / `verifyMultisampleLineGroupInterpolation` with `strictMode` and
/// `allowBresenhamForNonStrictLines`.
pub fn verify_triangulated_line_group_interpolation(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
    strict_mode: bool,
    allow_bresenham_for_non_strict_lines: bool,
) -> bool {
    if strict_mode {
        return verify_multisample_line_group_interpolation_internal(surface, scene, args, true);
    }
    if verify_multisample_line_group_interpolation_internal(surface, scene, args, false)
        || verify_multisample_line_group_interpolation_internal(surface, scene, args, true)
    {
        return true;
    }
    // In the non-strict line case, bresenham is also permissable, though not specified.
    args.num_samples <= 1
        && allow_bresenham_for_non_strict_lines
        && verify_line_group_pixel_independent_interpolation(surface, scene, args, false)
}

fn verify_line_interpolation_over_triangles(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
    triangle_scene: &TriangleSceneSpec,
) -> bool {
    let viewport_size = IVec2::new(surface.get_width(), surface.get_height());
    let multisampled = args.num_samples != 0;
    let subpixel_bits = args.subpixel_bits.clamp(0, 16);
    let mut invalid_pixels = 0;

    for y in 0..surface.get_height() {
        for x in 0..surface.get_width() {
            let color = surface.get_pixel(x, y);
            let mut stack_bottom_found = false;
            let mut stack_size: i32 = 0;
            let mut color_stack_min = Vec4::splat(0.0);
            let mut color_stack_max = Vec4::splat(0.0);

            // Iterate triangle coverage front to back, find the stack of potentially
            // contributing fragments.
            for tri_ndx in (0..triangle_scene.triangles.len()).rev() {
                let tri = &triangle_scene.triangles[tri_ndx];
                let coverage = calculate_triangle_coverage(
                    tri.positions[0],
                    tri.positions[1],
                    tri.positions[2],
                    IVec2::new(x, y),
                    viewport_size,
                    subpixel_bits,
                    multisampled,
                );

                if coverage == CoverageType::Full || coverage == CoverageType::Partial {
                    let weights = multisample_line_interpolate(scene, tri_ndx, IVec2::new(x, y), viewport_size);

                    let fragment_color_max = tri.colors[0] * weights.max[0].clamp(0.0, 1.0)
                        + tri.colors[1] * weights.max[1].clamp(0.0, 1.0)
                        + tri.colors[2] * weights.max[2].clamp(0.0, 1.0);
                    let fragment_color_min = tri.colors[0] * weights.min[0].clamp(0.0, 1.0)
                        + tri.colors[1] * weights.min[1].clamp(0.0, 1.0)
                        + tri.colors[2] * weights.min[2].clamp(0.0, 1.0);

                    if stack_size == 0 {
                        color_stack_min = fragment_color_min;
                        color_stack_max = fragment_color_max;
                    } else {
                        color_stack_min = vec4_min(color_stack_min, fragment_color_min);
                        color_stack_max = vec4_max(color_stack_max, fragment_color_max);
                    }
                    stack_size += 1;

                    if coverage == CoverageType::Full {
                        // Bottommost fragment; loop terminates.
                        stack_bottom_found = true;
                        break;
                    }
                }
            }

            // Partial coverage == background may be visible.
            if stack_size != 0 && !stack_bottom_found {
                stack_size += 1;
                color_stack_min = Vec4::new(0.0, 0.0, 0.0, 1.0);
            }

            if stack_size == 0 {
                // No coverage, allow only background (black, value=0).
                let native = convert_rgb8_to_native_format(color, args);
                const THRESHOLD: i32 = 1;
                if native.x() > THRESHOLD || native.y() > THRESHOLD || native.z() > THRESHOLD {
                    invalid_pixels += 1;
                }
            } else {
                // Each additional step in the stack may cause conversion error of 1 bit
                // due to undefined rounding direction.
                let threshold = stack_size - 1;

                let format_limit = [
                    (1i32 << args.red_bits) - 1,
                    (1i32 << args.green_bits) - 1,
                    (1i32 << args.blue_bits) - 1,
                ];
                let color_min_f: [f32; 3] = std::array::from_fn(|i| {
                    (color_stack_min.m_data[i] * format_limit[i] as f32).clamp(0.0, format_limit[i] as f32)
                });
                let color_max_f: [f32; 3] = std::array::from_fn(|i| {
                    (color_stack_max.m_data[i] * format_limit[i] as f32).clamp(0.0, format_limit[i] as f32)
                });
                let color_min: [i32; 3] = std::array::from_fn(|i| color_min_f[i].floor() as i32);
                let color_max: [i32; 3] = std::array::from_fn(|i| color_max_f[i].ceil() as i32);

                let native = convert_rgb8_to_native_format(color, args);
                let native_arr = [native.x(), native.y(), native.z()];
                let out_of_range = (0..3)
                    .any(|i| native_arr[i] < color_min[i] - threshold || native_arr[i] > color_max[i] + threshold);
                if out_of_range {
                    invalid_pixels += 1;
                }
            }
        }
    }

    invalid_pixels == 0
}

/// `tcu::LineInterpolationMethod`.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum LineInterpolationMethod {
    StrictlyCorrect,
    Projected,
    Incorrect,
}

/// `verifyLineGroupInterpolation`. The multisample branch always calls
/// `verifyMultisampleLineGroupInterpolation` with its default `strictMode = true` and
/// reports only `StrictlyCorrect`/`Incorrect` (upstream's own dispatch: `true` -> the
/// strict result directly, never `LINEINTERPOLATION_PROJECTED`). The single-sample
/// branch is unchanged. `scene.allowNonProjectedInterpolation` is not threaded through
/// separately there: every caller in this port's scope (`LineInterpolationCase`) always
/// sets it `true` upstream, so the extra pixel-independent-strict attempt it gates is
/// simply always made for a wide line that fails its own dedicated wide-line check,
/// matching upstream's actual behaviour for this port's only caller rather than adding
/// an unused field to `LineSceneSpec`.
pub fn verify_line_group_interpolation(
    surface: &Surface,
    scene: &LineSceneSpec,
    args: &RasterizationArguments,
) -> LineInterpolationMethod {
    if args.num_samples != 0 {
        return if verify_multisample_line_group_interpolation(surface, scene, args) {
            LineInterpolationMethod::StrictlyCorrect
        } else {
            LineInterpolationMethod::Incorrect
        };
    }

    if scene.line_width == 1.0 {
        if verify_line_group_pixel_independent_interpolation(surface, scene, args, true) {
            return LineInterpolationMethod::StrictlyCorrect;
        }
    } else {
        if verify_single_sample_wide_line_group_interpolation(surface, scene, args) {
            return LineInterpolationMethod::StrictlyCorrect;
        }
        if verify_line_group_pixel_independent_interpolation(surface, scene, args, true) {
            return LineInterpolationMethod::StrictlyCorrect;
        }
    }
    if verify_line_group_pixel_independent_interpolation(surface, scene, args, false) {
        return LineInterpolationMethod::Projected;
    }
    LineInterpolationMethod::Incorrect
}

#[cfg(test)]
mod tests {
    use super::*;

    fn white_triangle_surface(size: i32, p0: Vec4, p1: Vec4, p2: Vec4) -> Surface {
        // A tiny CPU-side reference rasterizer used only by this test, independent of
        // `calculate_triangle_coverage`, so the test is not circular: it fills a pixel
        // iff its center lies inside the triangle via the plain sign-of-area test.
        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let ndc = |p: Vec4| Vec2::new(p.x() / p.w(), p.y() / p.w());
        let to_screen = |p: Vec2| Vec2::new((p.x() + 1.0) * 0.5 * size as f32, (p.y() + 1.0) * 0.5 * size as f32);
        let s0 = to_screen(ndc(p0));
        let s1 = to_screen(ndc(p1));
        let s2 = to_screen(ndc(p2));
        let sign = |a: Vec2, b: Vec2, c: Vec2| (c.x() - a.x()) * (b.y() - a.y()) - (b.x() - a.x()) * (c.y() - a.y());
        for y in 0..size {
            for x in 0..size {
                let p = Vec2::new(x as f32 + 0.5, y as f32 + 0.5);
                let d0 = sign(s0, s1, p);
                let d1 = sign(s1, s2, p);
                let d2 = sign(s2, s0, p);
                let has_neg = d0 < 0.0 || d1 < 0.0 || d2 < 0.0;
                let has_pos = d0 > 0.0 || d1 > 0.0 || d2 > 0.0;
                if !(has_neg && has_pos) {
                    surface.set_pixel(x, y, RGBA::new(255, 255, 255, 255));
                }
            }
        }
        surface
    }

    fn args() -> RasterizationArguments {
        RasterizationArguments {
            num_samples: 0,
            subpixel_bits: 8,
            red_bits: 8,
            green_bits: 8,
            blue_bits: 8,
        }
    }

    #[test]
    fn a_triangle_rasterized_with_the_fill_rule_agrees_with_itself() {
        let p0 = Vec4::new(-0.6, -0.5, 0.0, 1.0);
        let p1 = Vec4::new(0.7, -0.3, 0.0, 1.0);
        let p2 = Vec4::new(-0.2, 0.8, 0.0, 1.0);
        let surface = white_triangle_surface(64, p0, p1, p2);
        let scene = TriangleSceneSpec {
            triangles: vec![SceneTriangle::new(p0, p1, p2)],
        };

        let result = verify_triangle_group_rasterization(&surface, &scene, &args(), VerificationMode::Strict);
        assert!(result.ok, "{result:?}");
        assert_eq!(result.missing_pixels, 0);
        assert_eq!(result.unexpected_pixels, 0);
    }

    #[test]
    fn an_empty_image_against_a_real_triangle_fails() {
        let p0 = Vec4::new(-0.6, -0.5, 0.0, 1.0);
        let p1 = Vec4::new(0.7, -0.3, 0.0, 1.0);
        let p2 = Vec4::new(-0.2, 0.8, 0.0, 1.0);
        let mut surface = Surface::new(64, 64);
        for y in 0..64 {
            for x in 0..64 {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let scene = TriangleSceneSpec {
            triangles: vec![SceneTriangle::new(p0, p1, p2)],
        };

        let result = verify_triangle_group_rasterization(&surface, &scene, &args(), VerificationMode::Strict);
        assert!(!result.ok);
        assert!(result.missing_pixels > 0);
    }

    #[test]
    fn winding_order_does_not_change_coverage() {
        let p0 = Vec4::new(-0.6, -0.5, 0.0, 1.0);
        let p1 = Vec4::new(0.7, -0.3, 0.0, 1.0);
        let p2 = Vec4::new(-0.2, 0.8, 0.0, 1.0);
        let surface_cw = white_triangle_surface(64, p0, p1, p2);
        let surface_ccw = white_triangle_surface(64, p0, p2, p1);

        let scene_cw = TriangleSceneSpec {
            triangles: vec![SceneTriangle::new(p0, p1, p2)],
        };
        let scene_ccw = TriangleSceneSpec {
            triangles: vec![SceneTriangle::new(p0, p2, p1)],
        };

        assert!(verify_triangle_group_rasterization(&surface_cw, &scene_cw, &args(), VerificationMode::Strict).ok);
        assert!(verify_triangle_group_rasterization(&surface_ccw, &scene_ccw, &args(), VerificationMode::Strict).ok);
    }

    #[test]
    fn a_degenerate_triangle_covers_nothing() {
        // Collinear points: zero area.
        let p0 = Vec4::new(-0.5, 0.0, 0.0, 1.0);
        let p1 = Vec4::new(0.0, 0.0, 0.0, 1.0);
        let p2 = Vec4::new(0.5, 0.0, 0.0, 1.0);
        let mut surface = Surface::new(32, 32);
        for y in 0..32 {
            for x in 0..32 {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let scene = TriangleSceneSpec {
            triangles: vec![SceneTriangle::new(p0, p1, p2)],
        };

        let result = verify_triangle_group_rasterization(&surface, &scene, &args(), VerificationMode::Strict);
        assert!(result.ok, "{result:?}");
        assert_eq!(result.missing_pixels, 0);
        assert_eq!(result.unexpected_pixels, 0);
    }

    #[test]
    fn a_rendered_point_square_agrees_with_itself() {
        // A perfectly axis-aligned point at the surface center, sized so its quad lands
        // on exact pixel boundaries - fill every pixel the quad covers, nothing else.
        let size = 64;
        let point_size = 10.0;
        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let half = (point_size / 2.0) as i32;
        for y in (size / 2 - half)..(size / 2 + half) {
            for x in (size / 2 - half)..(size / 2 + half) {
                surface.set_pixel(x, y, RGBA::new(255, 255, 255, 255));
            }
        }
        let scene = PointSceneSpec {
            points: vec![ScenePoint {
                position: Vec4::new(0.0, 0.0, 0.0, 1.0),
                point_size,
            }],
        };

        let result = verify_point_group_rasterization(&surface, &scene, &args());
        assert!(result.ok, "{result:?}");
        assert_eq!(result.missing_pixels, 0);
        assert_eq!(result.unexpected_pixels, 0);
    }

    #[test]
    fn an_empty_image_against_a_real_point_fails() {
        let size = 64;
        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let scene = PointSceneSpec {
            points: vec![ScenePoint {
                position: Vec4::new(0.0, 0.0, 0.0, 1.0),
                point_size: 10.0,
            }],
        };

        let result = verify_point_group_rasterization(&surface, &scene, &args());
        assert!(!result.ok);
        assert!(result.missing_pixels > 0);
    }

    /// A tiny CPU-side reference renderer, independent of `calc_triangle_interpolation_weights`:
    /// per pixel, barycentric-interpolates the three vertex colours at the pixel center (plain
    /// perspective-correct interpolation, no error bars) if the center lies inside the triangle.
    fn interpolated_triangle_surface(size: i32, tri: &SceneTriangle) -> Surface {
        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let ndc = |p: Vec4| Vec2::new(p.x() / p.w(), p.y() / p.w());
        let to_screen = |p: Vec2| Vec2::new((p.x() + 1.0) * 0.5 * size as f32, (p.y() + 1.0) * 0.5 * size as f32);
        let s = tri.positions.map(|p| to_screen(ndc(p)));
        let sign = |a: Vec2, b: Vec2, c: Vec2| (c.x() - a.x()) * (b.y() - a.y()) - (b.x() - a.x()) * (c.y() - a.y());
        let area = sign(s[0], s[1], s[2]);

        for y in 0..size {
            for x in 0..size {
                let p = Vec2::new(x as f32 + 0.5, y as f32 + 0.5);
                let w0 = sign(s[1], s[2], p) / area;
                let w1 = sign(s[2], s[0], p) / area;
                let w2 = sign(s[0], s[1], p) / area;
                if w0 >= 0.0 && w1 >= 0.0 && w2 >= 0.0 {
                    let color = tri.colors[0] * w0 + tri.colors[1] * w1 + tri.colors[2] * w2;
                    surface.set_pixel(
                        x,
                        y,
                        RGBA::new(
                            (color.x() * 255.0).round() as i32,
                            (color.y() * 255.0).round() as i32,
                            (color.z() * 255.0).round() as i32,
                            255,
                        ),
                    );
                }
            }
        }
        surface
    }

    #[test]
    fn a_colored_triangle_interpolation_agrees_with_itself() {
        let p0 = Vec4::new(-0.6, -0.5, 0.0, 1.0);
        let p1 = Vec4::new(0.7, -0.3, 0.0, 1.0);
        let p2 = Vec4::new(-0.2, 0.8, 0.0, 1.0);
        let tri = SceneTriangle::with_colors(
            p0,
            p1,
            p2,
            Vec4::new(1.0, 0.0, 0.0, 1.0),
            Vec4::new(0.0, 1.0, 0.0, 1.0),
            Vec4::new(0.0, 0.0, 1.0, 1.0),
        );
        let surface = interpolated_triangle_surface(64, &tri);
        let scene = TriangleSceneSpec { triangles: vec![tri] };

        let result = verify_triangle_group_interpolation(&surface, &scene, &args());
        assert!(result.ok, "{result:?}");
        assert_eq!(result.invalid_pixels, 0);
    }

    #[test]
    fn a_wrong_colored_pixel_fails_interpolation() {
        let p0 = Vec4::new(-0.6, -0.5, 0.0, 1.0);
        let p1 = Vec4::new(0.7, -0.3, 0.0, 1.0);
        let p2 = Vec4::new(-0.2, 0.8, 0.0, 1.0);
        let tri = SceneTriangle::with_colors(
            p0,
            p1,
            p2,
            Vec4::new(1.0, 0.0, 0.0, 1.0),
            Vec4::new(0.0, 1.0, 0.0, 1.0),
            Vec4::new(0.0, 0.0, 1.0, 1.0),
        );
        let mut surface = interpolated_triangle_surface(64, &tri);
        // Flip one interior pixel to the complementary colour.
        let before = surface.get_pixel(32, 32);
        surface.set_pixel(
            32,
            32,
            RGBA::new(
                255 - before.get_red(),
                255 - before.get_green(),
                255 - before.get_blue(),
                255,
            ),
        );
        let scene = TriangleSceneSpec { triangles: vec![tri] };

        let result = verify_triangle_group_interpolation(&surface, &scene, &args());
        assert!(!result.ok);
        assert!(result.invalid_pixels > 0);
    }

    #[test]
    fn an_empty_image_against_a_colored_triangle_fails_interpolation() {
        let p0 = Vec4::new(-0.6, -0.5, 0.0, 1.0);
        let p1 = Vec4::new(0.7, -0.3, 0.0, 1.0);
        let p2 = Vec4::new(-0.2, 0.8, 0.0, 1.0);
        let tri = SceneTriangle::with_colors(
            p0,
            p1,
            p2,
            Vec4::new(1.0, 0.0, 0.0, 1.0),
            Vec4::new(0.0, 1.0, 0.0, 1.0),
            Vec4::new(0.0, 0.0, 1.0, 1.0),
        );
        let mut surface = Surface::new(64, 64);
        for y in 0..64 {
            for x in 0..64 {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let scene = TriangleSceneSpec { triangles: vec![tri] };

        let result = verify_triangle_group_interpolation(&surface, &scene, &args());
        assert!(!result.ok);
        assert!(result.invalid_pixels > 0);
    }

    // --- rasterize_single_sample_line ---

    #[test]
    fn a_horizontal_line_through_a_pixel_row_center_covers_one_row() {
        // A perfectly horizontal line at y = 20.5 (a row of pixel centers), from x=10
        // to x=50, width 1.0: every covered pixel should be on row 20, and the run
        // should span roughly the line's own length (exact endpoint pixels depend on
        // the diamond-exit rule's own corner handling, so this checks the shape rather
        // than an exact literal count).
        let v0 = Vec4::new(10.0, 20.5, 0.0, 1.0);
        let v1 = Vec4::new(50.0, 20.5, 0.0, 1.0);
        let fragments = rasterize_single_sample_line(v0, v1, 1.0, (0, 0, 64, 64), 8);

        assert!(!fragments.is_empty());
        assert!(fragments.iter().all(|&(_, y)| y == 20), "{fragments:?}");
        let xs: Vec<i32> = fragments.iter().map(|&(x, _)| x).collect();
        assert!(
            xs.len() >= 38 && xs.len() <= 42,
            "expected ~40 pixels, got {}",
            xs.len()
        );
    }

    #[test]
    fn a_vertical_line_through_a_pixel_column_center_covers_one_column() {
        let v0 = Vec4::new(32.5, 10.0, 0.0, 1.0);
        let v1 = Vec4::new(32.5, 50.0, 0.0, 1.0);
        let fragments = rasterize_single_sample_line(v0, v1, 1.0, (0, 0, 64, 64), 8);

        assert!(!fragments.is_empty());
        assert!(fragments.iter().all(|&(x, _)| x == 32), "{fragments:?}");
        assert!(
            fragments.len() >= 38 && fragments.len() <= 42,
            "expected ~40 pixels, got {}",
            fragments.len()
        );
    }

    #[test]
    fn reversing_a_lines_endpoints_covers_almost_the_same_pixel_set() {
        // The diamond-exit rule deliberately treats a segment's two endpoints
        // asymmetrically (an "entering" vs an "exiting" diamond) - that is exactly what
        // upstream's own requirement 4 `\todo` comment is about: it is what lets two
        // *connected* segments sharing an endpoint avoid either a duplicate or a missing
        // fragment there. One consequence, confirmed directly against this port's own
        // output rather than assumed: reversing a single, unconnected segment's
        // direction may add or drop exactly one fragment near an endpoint, not leave the
        // pixel set unchanged. So this checks "almost the same" (symmetric difference of
        // at most one pixel), not bitwise equality.
        let v0 = Vec4::new(12.3, 15.7, 0.0, 1.0);
        let v1 = Vec4::new(48.9, 33.1, 0.0, 1.0);
        let mut forward = rasterize_single_sample_line(v0, v1, 1.0, (0, 0, 64, 64), 8);
        let mut backward = rasterize_single_sample_line(v1, v0, 1.0, (0, 0, 64, 64), 8);
        forward.sort();
        backward.sort();

        let forward_set: std::collections::HashSet<_> = forward.iter().copied().collect();
        let backward_set: std::collections::HashSet<_> = backward.iter().copied().collect();
        let symmetric_difference = forward_set.symmetric_difference(&backward_set).count();

        assert!(symmetric_difference <= 1, "forward={forward:?} backward={backward:?}");
        assert!(!forward.is_empty());
    }

    #[test]
    fn a_wide_line_covers_more_pixels_than_a_narrow_one() {
        let v0 = Vec4::new(10.0, 20.5, 0.0, 1.0);
        let v1 = Vec4::new(50.0, 20.5, 0.0, 1.0);
        let narrow = rasterize_single_sample_line(v0, v1, 1.0, (0, 0, 64, 64), 8);
        let wide = rasterize_single_sample_line(v0, v1, 5.0, (0, 0, 64, 64), 8);

        assert!(wide.len() > narrow.len());
        // every narrow-line fragment's row should be covered by the wide line too, in
        // the minor (vertical) direction, spanning 5 rows centered near y=20.
        let wide_ys: std::collections::HashSet<i32> = wide.iter().map(|&(_, y)| y).collect();
        assert!(wide_ys.len() >= 4 && wide_ys.len() <= 6, "{wide_ys:?}");
    }

    fn white_line_surface(size: i32, lines: &[(Vec4, Vec4)], line_width: f32) -> Surface {
        // A CPU-side reference image built directly from `rasterize_single_sample_line`
        // itself - this is intentionally the same code under test, since the point of
        // these tests is to check `verify_single_sample_line_group_rasterization`'s own
        // comparison logic (requirement 1/2/3 bookkeeping) agrees with an image the
        // rasterizer says is exactly right, not to re-derive the geometry independently
        // (the real independent check is `diff_vs_deqp.py` against upstream's own
        // `deqp-gles{2,3}` binary, run separately for every wired-up GL case).
        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        for &(v0, v1) in lines {
            let p0 = line_vertex_to_screen_space(v0, (size as f32, size as f32));
            let p1 = line_vertex_to_screen_space(v1, (size as f32, size as f32));
            for (x, y) in rasterize_single_sample_line(
                Vec4::new(p0.x(), p0.y(), 0.0, 1.0),
                Vec4::new(p1.x(), p1.y(), 0.0, 1.0),
                line_width,
                (0, 0, size, size),
                8,
            ) {
                surface.set_pixel(x, y, RGBA::new(255, 255, 255, 255));
            }
        }
        surface
    }

    fn line_args() -> RasterizationArguments {
        RasterizationArguments {
            num_samples: 0,
            subpixel_bits: 8,
            red_bits: 8,
            green_bits: 8,
            blue_bits: 8,
        }
    }

    #[test]
    fn a_rasterized_line_group_agrees_with_itself() {
        let v0 = Vec4::new(-0.9, -0.3, 0.0, 1.0);
        let v1 = Vec4::new(0.3, -0.9, 0.0, 1.0);
        let v2 = Vec4::new(-0.4, -0.1, 0.0, 1.0);
        let v3 = Vec4::new(0.7, 0.5, 0.0, 1.0);
        let lines = [(v0, v1), (v2, v3)];
        let surface = white_line_surface(64, &lines, 1.0);
        let scene = LineSceneSpec {
            lines: lines.iter().map(|&(a, b)| SceneLine::new(a, b)).collect(),
            line_width: 1.0,
            ..Default::default()
        };

        let result = verify_line_group_rasterization(&surface, &scene, &line_args());
        assert!(result.ok, "{result:?}");
    }

    #[test]
    fn an_empty_image_against_a_real_line_fails() {
        let v0 = Vec4::new(-0.9, -0.3, 0.0, 1.0);
        let v1 = Vec4::new(0.3, -0.9, 0.0, 1.0);
        let mut surface = Surface::new(64, 64);
        for y in 0..64 {
            for x in 0..64 {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let scene = LineSceneSpec {
            lines: vec![SceneLine::new(v0, v1)],
            line_width: 1.0,
            ..Default::default()
        };

        let result = verify_line_group_rasterization(&surface, &scene, &line_args());
        assert!(!result.ok);
    }

    #[test]
    fn a_wide_line_group_agrees_with_itself() {
        let v0 = Vec4::new(-0.9, -0.3, 0.0, 1.0);
        let v1 = Vec4::new(0.5, 0.6, 0.0, 1.0);
        let lines = [(v0, v1)];
        let surface = white_line_surface(64, &lines, 5.0);
        let scene = LineSceneSpec {
            lines: lines.iter().map(|&(a, b)| SceneLine::new(a, b)).collect(),
            line_width: 5.0,
            ..Default::default()
        };

        let result = verify_line_group_rasterization(&surface, &scene, &line_args());
        assert!(result.ok, "{result:?}");
    }

    /// Builds the reference image independently of `verify_multisample_line_group_rasterization`:
    /// the quad corners are computed here by hand (same formula the real function
    /// uses, transcribed independently rather than called), then filled with the plain
    /// sign-of-area pixel-center test `white_triangle_surface` itself uses - not
    /// `calculate_triangle_coverage` - so this is a genuinely independent check: a test must not reuse the code it checks.
    #[test]
    fn a_multisampled_wide_line_group_agrees_with_itself() {
        let size = 64;
        let v0 = Vec4::new(-0.9, -0.3, 0.0, 1.0);
        let v1 = Vec4::new(0.3, 0.7, 0.0, 1.0);
        let line_width = 5.0;

        let viewport = Vec2::new(size as f32, size as f32);
        let p0 = Vec2::new(v0.x(), v0.y());
        let p1 = Vec2::new(v1.x(), v1.y());
        let s0 = (p0 + Vec2::new(1.0, 1.0)) * 0.5 * viewport;
        let s1 = (p1 + Vec2::new(1.0, 1.0)) * 0.5 * viewport;
        let dir = normalize2(s1 - s0);
        let normal = Vec2::new(dir.y(), -dir.x());
        let half = line_width * 0.5;
        let quad_screen = [
            s0 + normal * half,
            s0 - normal * half,
            s1 - normal * half,
            s1 + normal * half,
        ];

        let to_ndc = |q: Vec2| {
            Vec4::new(
                (q.x() / viewport.x()) * 2.0 - 1.0,
                (q.y() / viewport.y()) * 2.0 - 1.0,
                0.0,
                1.0,
            )
        };
        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        for &(a, b, c) in &[(0, 1, 2), (0, 2, 3)] {
            let sub = white_triangle_surface(
                size,
                to_ndc(quad_screen[a]),
                to_ndc(quad_screen[b]),
                to_ndc(quad_screen[c]),
            );
            for y in 0..size {
                for x in 0..size {
                    if sub.get_pixel(x, y) == RGBA::new(255, 255, 255, 255) {
                        surface.set_pixel(x, y, RGBA::new(255, 255, 255, 255));
                    }
                }
            }
        }

        let scene = LineSceneSpec {
            lines: vec![SceneLine::new(v0, v1)],
            line_width,
            ..Default::default()
        };
        let args = RasterizationArguments {
            num_samples: 4,
            subpixel_bits: 8,
            red_bits: 8,
            green_bits: 8,
            blue_bits: 8,
        };
        let result = verify_line_group_rasterization(&surface, &scene, &args);
        assert!(result.ok, "{result:?}");
    }

    #[test]
    fn a_multisampled_empty_image_against_a_real_wide_line_fails() {
        let size = 64;
        let v0 = Vec4::new(-0.9, -0.3, 0.0, 1.0);
        let v1 = Vec4::new(0.3, 0.7, 0.0, 1.0);
        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let scene = LineSceneSpec {
            lines: vec![SceneLine::new(v0, v1)],
            line_width: 5.0,
            ..Default::default()
        };
        let args = RasterizationArguments {
            num_samples: 4,
            subpixel_bits: 8,
            red_bits: 8,
            green_bits: 8,
            blue_bits: 8,
        };
        let result = verify_line_group_rasterization(&surface, &scene, &args);
        assert!(!result.ok);
    }

    #[test]
    fn a_colored_line_interpolation_agrees_with_itself() {
        // Builds the reference image using the verifier's *own* interpolation weight
        // at each covered pixel (the midpoint of its range), the same "test the
        // comparison logic, not an independently-derived rasterization" shape
        // `a_rasterized_line_group_agrees_with_itself` uses - the real independent check
        // is `diff_vs_deqp.py` against the real driver.
        let size = 64;
        let v0 = Vec4::new(-0.9, -0.3, 0.0, 1.0);
        let v1 = Vec4::new(0.7, 0.5, 0.0, 1.0);
        let c0 = Vec4::new(1.0, 0.0, 0.0, 1.0);
        let c1 = Vec4::new(0.0, 0.0, 1.0, 1.0);

        let p0 = line_vertex_to_screen_space(v0, (size as f32, size as f32));
        let p1 = line_vertex_to_screen_space(v1, (size as f32, size as f32));
        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let fragments = rasterize_single_sample_line(
            Vec4::new(p0.x(), p0.y(), 0.0, 1.0),
            Vec4::new(p1.x(), p1.y(), 0.0, 1.0),
            1.0,
            (0, 0, size, size),
            8,
        );
        for (x, y) in fragments {
            let range = calc_single_sample_line_interpolation_range(p0, v0.w(), p1, v1.w(), (x, y), 8);
            let mid_w0 = ((range.min.x() + range.max.x()) / 2.0).clamp(0.0, 1.0);
            let mid_w1 = ((range.min.y() + range.max.y()) / 2.0).clamp(0.0, 1.0);
            let color = c0 * mid_w0 + c1 * mid_w1;
            surface.set_pixel(
                x,
                y,
                RGBA::new(
                    (color.x() * 255.0).round() as i32,
                    (color.y() * 255.0).round() as i32,
                    (color.z() * 255.0).round() as i32,
                    255,
                ),
            );
        }

        let scene = LineSceneSpec {
            lines: vec![SceneLine::with_colors(v0, v1, c0, c1)],
            line_width: 1.0,
            ..Default::default()
        };
        let result = verify_line_group_interpolation(&surface, &scene, &line_args());
        assert_eq!(
            result,
            LineInterpolationMethod::StrictlyCorrect,
            "surface built from the verifier's own weights should verify as strictly correct"
        );
    }

    #[test]
    fn a_wrong_colored_line_pixel_fails_interpolation() {
        let size = 64;
        let v0 = Vec4::new(-0.9, -0.3, 0.0, 1.0);
        let v1 = Vec4::new(0.7, 0.5, 0.0, 1.0);
        let c0 = Vec4::new(1.0, 0.0, 0.0, 1.0);
        let c1 = Vec4::new(0.0, 0.0, 1.0, 1.0);

        let p0 = line_vertex_to_screen_space(v0, (size as f32, size as f32));
        let p1 = line_vertex_to_screen_space(v1, (size as f32, size as f32));
        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let fragments = rasterize_single_sample_line(
            Vec4::new(p0.x(), p0.y(), 0.0, 1.0),
            Vec4::new(p1.x(), p1.y(), 0.0, 1.0),
            1.0,
            (0, 0, size, size),
            8,
        );
        for &(x, y) in &fragments {
            surface.set_pixel(x, y, RGBA::new(0, 255, 0, 255)); // uniformly green, matching neither endpoint colour
        }

        let scene = LineSceneSpec {
            lines: vec![SceneLine::with_colors(v0, v1, c0, c1)],
            line_width: 1.0,
            ..Default::default()
        };
        let result = verify_line_group_interpolation(&surface, &scene, &line_args());
        assert_eq!(result, LineInterpolationMethod::Incorrect);
    }

    /// Independent of the verifier under test - plain linear extrapolation, checked by
    /// hand, as is done wherever feasible.
    #[test]
    fn get_line_coord_at_axis_coord_extrapolates_linearly() {
        let pa = Vec2::new(0.0, 0.0);
        let pb = Vec2::new(10.0, 5.0); // slope 0.5

        let far = get_line_coord_at_axis_coord(pa, pb, true, 20.0);
        assert!(
            (far.x() - 20.0).abs() < 1e-5 && (far.y() - 10.0).abs() < 1e-5,
            "{far:?}"
        );

        let behind = get_line_coord_at_axis_coord(pa, pb, true, -2.0);
        assert!(
            (behind.x() + 2.0).abs() < 1e-5 && (behind.y() + 1.0).abs() < 1e-5,
            "{behind:?}"
        );

        // minor-axis form: the *y* coordinate is now the fixed one.
        let via_y = get_line_coord_at_axis_coord(pa, pb, false, 10.0);
        assert!(
            (via_y.y() - 10.0).abs() < 1e-5 && (via_y.x() - 20.0).abs() < 1e-5,
            "{via_y:?}"
        );
    }

    /// Exercises `line_exit_diamonds` + `get_line_coord_at_axis_coord` together without
    /// going through the wide-line interpolation verifier itself - checked against the
    /// line's own hand-computable slope, independent of `calc_single_sample_line_interpolation_range`
    /// or any other function under test elsewhere in this module.
    #[test]
    fn root_pixel_locations_tracks_a_near_horizontal_line() {
        let pa = Vec2::new(5.0, 10.4);
        let pb = Vec2::new(55.0, 12.6);
        let table = root_pixel_locations(pa, pb, true, 64, 8);
        assert_eq!(table.len(), 64);

        for x in 5..=55 {
            assert!(table[x as usize].is_some(), "no root pixel found at major position {x}");
        }
        // the diamond-exit rule rounds to the nearest pixel rather than teleporting, so
        // the minor coordinate found should track the line's own straight-line value to
        // within a pixel or two.
        assert!((table[5].unwrap() as f32 - 10.4).abs() <= 2.0, "{:?}", table[5]);
        assert!((table[55].unwrap() as f32 - 12.6).abs() <= 2.0, "{:?}", table[55]);
    }

    /// Builds the reference image the same way `a_colored_line_interpolation_agrees_with_itself`
    /// does for the narrow path: every drawn fragment's colour comes from this module's
    /// own weight range at that fragment's **root** position (the wide-line model this
    /// function itself implements), so this checks the comparison logic agrees with an
    /// image already built to match it - not an independently-derived rasterization.
    /// The real independent check is `diff_vs_deqp.py` against the real driver.
    #[test]
    fn a_colored_wide_line_interpolation_agrees_with_itself() {
        let size = 64;
        let line_width = 5.0;
        let v0 = Vec4::new(-0.9, -0.3, 0.0, 1.0);
        let v1 = Vec4::new(0.7, 0.5, 0.0, 1.0);
        let c0 = Vec4::new(1.0, 0.0, 0.0, 1.0);
        let c1 = Vec4::new(0.0, 0.0, 1.0, 1.0);

        let p0 = line_vertex_to_screen_space(v0, (size as f32, size as f32));
        let p1 = line_vertex_to_screen_space(v1, (size as f32, size as f32));
        let is_x_major = is_line_x_major(p0, p1);
        let offset_length = (line_width - 1.0) / 2.0;
        let offset = if is_x_major {
            Vec2::new(0.0, -offset_length)
        } else {
            Vec2::new(-offset_length, 0.0)
        };
        let eff_p0 = p0 + offset;
        let eff_p1 = p1 + offset;
        let major_size = size;
        let root_table = root_pixel_locations(eff_p0, eff_p1, is_x_major, major_size, 8);

        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let fragments = rasterize_single_sample_line(
            Vec4::new(p0.x(), p0.y(), 0.0, 1.0),
            Vec4::new(p1.x(), p1.y(), 0.0, 1.0),
            line_width,
            (0, 0, size, size),
            8,
        );
        for (x, y) in fragments {
            let major_position = if is_x_major { x } else { y };
            let minor_position = root_table[major_position as usize]
                .expect("root should exist for a rasterized fragment's own major position");
            let root = if is_x_major {
                (major_position, minor_position)
            } else {
                (minor_position, major_position)
            };
            let range = calc_single_sample_line_interpolation_range(eff_p0, v0.w(), eff_p1, v1.w(), root, 8);
            let mid_w0 = ((range.min.x() + range.max.x()) / 2.0).clamp(0.0, 1.0);
            let mid_w1 = ((range.min.y() + range.max.y()) / 2.0).clamp(0.0, 1.0);
            let color = c0 * mid_w0 + c1 * mid_w1;
            surface.set_pixel(
                x,
                y,
                RGBA::new(
                    (color.x() * 255.0).round() as i32,
                    (color.y() * 255.0).round() as i32,
                    (color.z() * 255.0).round() as i32,
                    255,
                ),
            );
        }

        let scene = LineSceneSpec {
            lines: vec![SceneLine::with_colors(v0, v1, c0, c1)],
            line_width,
            ..Default::default()
        };
        let result = verify_line_group_interpolation(&surface, &scene, &line_args());
        assert_eq!(result, LineInterpolationMethod::StrictlyCorrect, "{result:?}");
    }

    #[test]
    fn a_wrong_colored_wide_line_pixel_fails_interpolation() {
        let size = 64;
        let line_width = 5.0;
        let v0 = Vec4::new(-0.9, -0.3, 0.0, 1.0);
        let v1 = Vec4::new(0.7, 0.5, 0.0, 1.0);
        let c0 = Vec4::new(1.0, 0.0, 0.0, 1.0);
        let c1 = Vec4::new(0.0, 0.0, 1.0, 1.0);
        let p0 = line_vertex_to_screen_space(v0, (size as f32, size as f32));
        let p1 = line_vertex_to_screen_space(v1, (size as f32, size as f32));

        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
            }
        }
        let fragments = rasterize_single_sample_line(
            Vec4::new(p0.x(), p0.y(), 0.0, 1.0),
            Vec4::new(p1.x(), p1.y(), 0.0, 1.0),
            line_width,
            (0, 0, size, size),
            8,
        );
        for &(x, y) in &fragments {
            // uniformly green - matches neither endpoint colour (both are pure red/blue,
            // no channel has any green component), so no candidate root can explain it.
            surface.set_pixel(x, y, RGBA::new(0, 255, 0, 255));
        }

        let scene = LineSceneSpec {
            lines: vec![SceneLine::with_colors(v0, v1, c0, c1)],
            line_width,
            ..Default::default()
        };
        let result = verify_line_group_interpolation(&surface, &scene, &line_args());
        assert_eq!(result, LineInterpolationMethod::Incorrect);
    }

    /// Exercises `multisample_line_interpolate`'s own colour-assignment directly:
    /// `build_multisample_line_interpolation_scene` is used only to get the quad's
    /// *coverage* geometry (`calculate_triangle_coverage`, already independently tested
    /// via the triangle rasterization tests above); the expected *colour* at each fully
    /// covered pixel is computed here from scratch, by projecting the pixel center onto
    /// the line segment with plain vector algebra - not by calling
    /// `multisample_line_interpolate`/`calc_line_interpolation_weights`. Pixels that are
    /// not fully covered are left at the cleared background colour, which the verifier's
    /// own partial/no-coverage branches both accept regardless of exact subpixel
    /// boundary placement, so this is not sensitive to where the quad's edge actually
    /// falls.
    fn multisample_args() -> RasterizationArguments {
        RasterizationArguments {
            num_samples: 4,
            subpixel_bits: 8,
            red_bits: 8,
            green_bits: 8,
            blue_bits: 8,
        }
    }

    fn render_multisample_line_reference(
        size: i32,
        v0: Vec4,
        v1: Vec4,
        c0: Vec4,
        c1: Vec4,
        scene: &LineSceneSpec,
    ) -> Surface {
        let viewport_size = Vec2::new(size as f32, size as f32);
        let triangle_scene = build_multisample_line_interpolation_scene(scene, viewport_size, true);
        let s0 = line_vertex_to_screen_space(v0, (size as f32, size as f32));
        let s1 = line_vertex_to_screen_space(v1, (size as f32, size as f32));

        let mut surface = Surface::new(size, size);
        for y in 0..size {
            for x in 0..size {
                surface.set_pixel(x, y, RGBA::new(0, 0, 0, 255));
                let pr = Vec2::new(x as f32 + 0.5, y as f32 + 0.5);
                let fully_covered = triangle_scene.triangles.iter().any(|tri| {
                    calculate_triangle_coverage(
                        tri.positions[0],
                        tri.positions[1],
                        tri.positions[2],
                        IVec2::new(x, y),
                        IVec2::new(size, size),
                        8,
                        true,
                    ) == CoverageType::Full
                });
                if fully_covered {
                    let t = (dot2(pr - s0, s1 - s0) / length_squared(s1 - s0)).clamp(0.0, 1.0);
                    let color = c0 * (1.0 - t) + c1 * t;
                    surface.set_pixel(
                        x,
                        y,
                        RGBA::new(
                            (color.x() * 255.0).round() as i32,
                            (color.y() * 255.0).round() as i32,
                            (color.z() * 255.0).round() as i32,
                            255,
                        ),
                    );
                }
            }
        }
        surface
    }

    #[test]
    fn a_correctly_interpolated_multisample_line_passes() {
        let size = 64;
        let line_width = 6.0;
        let v0 = Vec4::new(-0.8, 0.0, 0.0, 1.0);
        let v1 = Vec4::new(0.8, 0.0, 0.0, 1.0);
        let c0 = Vec4::new(1.0, 0.0, 0.0, 1.0);
        let c1 = Vec4::new(0.0, 0.0, 1.0, 1.0);
        let scene = LineSceneSpec {
            lines: vec![SceneLine::with_colors(v0, v1, c0, c1)],
            line_width,
            ..Default::default()
        };
        let surface = render_multisample_line_reference(size, v0, v1, c0, c1, &scene);

        assert!(verify_multisample_line_group_interpolation(
            &surface,
            &scene,
            &multisample_args()
        ));
    }

    #[test]
    fn a_multisample_line_with_swapped_endpoint_colours_fails_verification() {
        let size = 64;
        let line_width = 6.0;
        let v0 = Vec4::new(-0.8, 0.0, 0.0, 1.0);
        let v1 = Vec4::new(0.8, 0.0, 0.0, 1.0);
        let c0 = Vec4::new(1.0, 0.0, 0.0, 1.0);
        let c1 = Vec4::new(0.0, 0.0, 1.0, 1.0);
        // Render the reference with the real endpoint colours, but hand the verifier a
        // scene whose endpoint colours are swapped - every fully-covered, non-midpoint
        // pixel then has the wrong expected colour.
        let render_scene = LineSceneSpec {
            lines: vec![SceneLine::with_colors(v0, v1, c0, c1)],
            line_width,
            ..Default::default()
        };
        let surface = render_multisample_line_reference(size, v0, v1, c0, c1, &render_scene);
        let verify_scene = LineSceneSpec {
            lines: vec![SceneLine::with_colors(v0, v1, c1, c0)],
            line_width,
            ..Default::default()
        };

        assert!(!verify_multisample_line_group_interpolation(
            &surface,
            &verify_scene,
            &multisample_args()
        ));
    }

    #[test]
    fn multisample_line_interpolation_scene_assigns_quad_corner_colours_correctly() {
        let p0 = Vec4::new(-0.5, 0.0, 0.0, 1.0);
        let p1 = Vec4::new(0.5, 0.0, 0.0, 1.0);
        let c0 = Vec4::new(1.0, 0.0, 0.0, 1.0);
        let c1 = Vec4::new(0.0, 0.0, 1.0, 1.0);
        let scene = LineSceneSpec {
            lines: vec![SceneLine::with_colors(p0, p1, c0, c1)],
            line_width: 4.0,
            ..Default::default()
        };

        let triangle_scene = build_multisample_line_interpolation_scene(&scene, Vec2::new(64.0, 64.0), true);

        assert_eq!(triangle_scene.triangles.len(), 2);
        assert_eq!(triangle_scene.triangles[0].colors, [c0, c0, c1]);
        assert_eq!(triangle_scene.triangles[1].colors, [c0, c1, c1]);
    }
}
