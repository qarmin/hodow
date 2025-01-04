// SPDX-License-Identifier: Apache-2.0
//
// Not derived from a single upstream file - see the module-level doc comment below.
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).

//! A purpose-built, single-sample software triangle rasteriser.
//!
//! Not a port of `rrRasterizer.cpp`/`rrRenderer.cpp` (~3200 lines: fixed-point
//! multisample rasterisation, perspective-correct barycentric division, primitive
//! assembly and clipping) - those exist to rasterise *arbitrary* geometry that may
//! extend outside the viewport and be sampled at up to 16 subpixel positions.
//! `gls::texture_buffer_case` is the one consumer so far, and its geometry never needs
//! clipping (every vertex lands inside the viewport by construction: the vertex shader
//! it mirrors is `2 * (coord - 0.5)` for `coord` in `[0, 1]`) or a perspective divide
//! (`w` is always 1). This implements just the rasterisation rule that matters here:
//! standard edge functions with the top-left fill convention at pixel centres, which is
//! what the GL spec requires and what `tcu::fuzzy_image_compare`'s tolerance expects.

use crate::tcu::vector::Vec4;

/// One rasterised triangle's vertex: an already-viewport-transformed pixel-space
/// position (x grows right, y matches whatever `glu::read_pixels`/`tcu::Surface` calls
/// row 0 - i.e. NDC y is used directly with no flip, since that is the convention
/// `gls::shader_render_case`'s own grid-to-screen mapping already established as
/// correct against a real driver) plus the value to interpolate across the triangle.
#[derive(Clone, Copy)]
pub struct Vertex {
    pub x: f32,
    pub y: f32,
    pub varying: Vec4,
}

impl Vertex {
    pub const fn new(x: f32, y: f32, varying: Vec4) -> Self {
        Self { x, y, varying }
    }
}

/// `edgeFunction(a, b, p)` - twice the signed area of triangle `(a, b, p)`. Positive
/// when `p` is to the left of the directed edge `a -> b`.
fn edge(ax: f32, ay: f32, bx: f32, by: f32, px: f32, py: f32) -> f32 {
    (bx - ax) * (py - ay) - (by - ay) * (px - ax)
}

/// The top-left fill rule: a sample point lying exactly on an edge counts as covered
/// only if that edge is a "top" edge (horizontal, pointing right) or a "left" edge
/// (pointing down). Without this, two triangles sharing an edge would either both draw
/// the shared boundary pixels or neither would, each equally wrong.
fn is_top_left(ax: f32, ay: f32, bx: f32, by: f32) -> bool {
    let dy = by - ay;
    let dx = bx - ax;
    (dy == 0.0 && dx > 0.0) || dy < 0.0
}

/// Rasterises one triangle into a `width x height` target, calling `shade(x, y,
/// varying)` for every pixel whose centre the triangle covers. A degenerate
/// (zero-area) triangle is silently skipped, matching a real rasteriser drawing
/// nothing for one.
pub fn rasterize_triangle(
    width: i32,
    height: i32,
    v0: Vertex,
    v1: Vertex,
    v2: Vertex,
    shade: &mut dyn FnMut(i32, i32, Vec4),
) {
    let area = edge(v0.x, v0.y, v1.x, v1.y, v2.x, v2.y);
    if area == 0.0 {
        return;
    }

    // Normalise to a positive-area (CCW, by this function's own sign convention)
    // winding so the three "inside" tests below can all share one sign - nothing here
    // culls by face, so both winding orders must rasterise identically.
    let (v0, v1, v2, area) = if area < 0.0 {
        (v0, v2, v1, -area)
    } else {
        (v0, v1, v2, area)
    };

    let min_x = v0.x.min(v1.x).min(v2.x).floor().max(0.0) as i32;
    let max_x = (v0.x.max(v1.x).max(v2.x).ceil() as i32).min(width);
    let min_y = v0.y.min(v1.y).min(v2.y).floor().max(0.0) as i32;
    let max_y = (v0.y.max(v1.y).max(v2.y).ceil() as i32).min(height);

    let top_left_12 = is_top_left(v1.x, v1.y, v2.x, v2.y);
    let top_left_20 = is_top_left(v2.x, v2.y, v0.x, v0.y);
    let top_left_01 = is_top_left(v0.x, v0.y, v1.x, v1.y);

    for y in min_y..max_y {
        for x in min_x..max_x {
            let px = x as f32 + 0.5;
            let py = y as f32 + 0.5;

            let w0 = edge(v1.x, v1.y, v2.x, v2.y, px, py);
            let w1 = edge(v2.x, v2.y, v0.x, v0.y, px, py);
            let w2 = edge(v0.x, v0.y, v1.x, v1.y, px, py);

            let in0 = w0 > 0.0 || (w0 == 0.0 && top_left_12);
            let in1 = w1 > 0.0 || (w1 == 0.0 && top_left_20);
            let in2 = w2 > 0.0 || (w2 == 0.0 && top_left_01);

            if in0 && in1 && in2 {
                let b0 = w0 / area;
                let b1 = w1 / area;
                let b2 = w2 / area;
                let varying = v0.varying * b0 + v1.varying * b1 + v2.varying * b2;
                shade(x, y, varying);
            }
        }
    }
}

/// Rasterises a triangle *list* (three indices per triangle, in draw order). Later
/// triangles overwrite earlier ones at a shared pixel - there is no depth test or
/// blending here, matching the one consumer, which sets up neither.
#[expect(
    clippy::chunks_exact_to_as_chunks,
    reason = "slice::as_chunks is nightly-unstable and not worth a crate-wide feature gate for one call site"
)]
pub fn rasterize_triangle_list(
    width: i32,
    height: i32,
    vertices: &[Vertex],
    indices: &[u32],
    shade: &mut dyn FnMut(i32, i32, Vec4),
) {
    for tri in indices.chunks_exact(3) {
        rasterize_triangle(
            width,
            height,
            vertices[tri[0] as usize],
            vertices[tri[1] as usize],
            vertices[tri[2] as usize],
            shade,
        );
    }
}

#[cfg(test)]
mod tests {
    use std::collections::HashSet;

    use super::*;

    const WHITE: Vec4 = Vec4::new(1.0, 1.0, 1.0, 1.0);

    /// The "nice quad" shape `gls::texture_buffer_case` draws most often: two triangles
    /// sharing the diagonal from the bottom-left to the top-right corner, covering the
    /// whole target. Every pixel must be covered by *exactly one* of the two triangles -
    /// a double-covered or uncovered pixel along the shared diagonal would mean the
    /// fill rule is inconsistent between the two edges that meet there.
    #[test]
    fn full_screen_quad_has_no_gaps_or_overlaps() {
        let width = 17;
        let height = 13;
        let v00 = Vertex::new(0.0, 0.0, WHITE);
        let v10 = Vertex::new(width as f32, 0.0, WHITE);
        let v01 = Vertex::new(0.0, height as f32, WHITE);
        let v11 = Vertex::new(width as f32, height as f32, WHITE);

        let mut first = HashSet::new();
        rasterize_triangle(width, height, v00, v10, v11, &mut |x, y, _| {
            first.insert((x, y));
        });
        let mut second = HashSet::new();
        rasterize_triangle(width, height, v00, v11, v01, &mut |x, y, _| {
            second.insert((x, y));
        });

        assert!(
            first.intersection(&second).next().is_none(),
            "the two triangles drew a shared pixel"
        );
        let mut all: HashSet<(i32, i32)> = first.union(&second).copied().collect();
        for y in 0..height {
            for x in 0..width {
                assert!(all.remove(&(x, y)), "pixel ({x}, {y}) was covered by neither triangle");
            }
        }
        assert!(all.is_empty(), "covered a pixel outside the target");
    }

    #[test]
    fn degenerate_triangle_draws_nothing() {
        let mut count = 0;
        let p = Vertex::new(4.0, 4.0, WHITE);
        rasterize_triangle(8, 8, p, p, p, &mut |_, _, _| count += 1);
        assert_eq!(count, 0);

        let collinear = Vertex::new(6.0, 4.0, WHITE);
        rasterize_triangle(8, 8, p, collinear, Vertex::new(2.0, 4.0, WHITE), &mut |_, _, _| {
            count += 1
        });
        assert_eq!(count, 0, "a collinear (zero-area) triangle must not draw");
    }

    #[test]
    fn winding_order_does_not_change_coverage() {
        let width = 9;
        let height = 9;
        let a = Vertex::new(1.0, 1.0, WHITE);
        let b = Vertex::new(8.0, 1.0, WHITE);
        let c = Vertex::new(1.0, 8.0, WHITE);

        let mut ccw = HashSet::new();
        rasterize_triangle(width, height, a, b, c, &mut |x, y, _| {
            ccw.insert((x, y));
        });
        let mut cw = HashSet::new();
        rasterize_triangle(width, height, a, c, b, &mut |x, y, _| {
            cw.insert((x, y));
        });

        assert_eq!(ccw, cw);
        assert!(!ccw.is_empty());
    }

    /// Interpolation is a plain barycentric blend: at each triangle's own vertices the
    /// shaded value must equal that vertex's varying, and at the centroid it must equal
    /// the average of the three.
    #[test]
    fn varying_interpolates_linearly() {
        let width = 64;
        let height = 64;
        let v0 = Vertex::new(4.0, 4.0, Vec4::new(1.0, 0.0, 0.0, 1.0));
        let v1 = Vertex::new(60.0, 4.0, Vec4::new(0.0, 1.0, 0.0, 1.0));
        let v2 = Vertex::new(4.0, 60.0, Vec4::new(0.0, 0.0, 1.0, 1.0));

        let at = |x: i32, y: i32| -> Option<Vec4> {
            let mut found = None;
            rasterize_triangle(width, height, v0, v1, v2, &mut |px, py, varying| {
                if px == x && py == y {
                    found = Some(varying);
                }
            });
            found
        };

        let near_v0 = at(4, 4).expect("v0's own corner pixel must be covered");
        assert!(
            (near_v0.x() - 1.0).abs() < 0.05,
            "near v0 the red channel should dominate: {near_v0:?}"
        );

        let centroid_x = ((4.0 + 60.0 + 4.0) / 3.0) as i32;
        let centroid_y = ((4.0 + 4.0 + 60.0) / 3.0) as i32;
        let centroid = at(centroid_x, centroid_y).expect("the centroid pixel must be covered");
        for channel in 0..3 {
            assert!(
                (centroid[channel] - 1.0 / 3.0).abs() < 0.1,
                "centroid channel {channel} should be close to 1/3: {centroid:?}"
            );
        }
    }
}
