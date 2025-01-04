// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrFragmentPacket.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Not to be confused with `rr::fragment_operations::Fragment` (same upstream
// `rr::Fragment` name, but a different struct entirely - see that file's own doc
// comment for its own multisample/integer-colour fields): `FragmentPacket` is what the
// *rasterizer* emits, one per 2x2 pixel quad, carrying per-sample coverage and
// perspective-correct barycentrics rather than a shaded colour. The renderer shades a
// `FragmentPacket` and only then produces the `Fragment` values `FragmentProcessor`
// consumes - unlike `Fragment` (now multisample- and integer/unsigned-colour-aware,
// see `rr::fragment_operations`'s own doc comment), `FragmentPacket` itself never
// changed shape: a rasterizer always emits perspective-correct barycentrics and a
// per-sample coverage mask regardless of how many samples the render target has or
// what channel class its colour buffer is.

use crate::tcu::vector::{IVec2, Vec4};

/// Fragment shading is always done in 2x2 blocks in order to easily estimate
/// derivatives for mipmap selection etc.
pub const NUM_FRAGMENTS_PER_PACKET: usize = 4;

/// `rr::FragmentPacket`
///
/// Values packed in vectors (such as `barycentric`) are in order:
/// `(x0,y0), (x1,y0), (x0,y1), (x1,y1)`, i.e. `ndx = y*2 + x`.
#[derive(Debug, Clone, Copy)]
pub struct FragmentPacket {
    /// Position of the (0,0) fragment.
    pub position: IVec2,
    /// Coverage mask.
    pub coverage: u64,
    /// Perspective-correct barycentric values, one `Vec4` per triangle vertex (lines
    /// use only `[0]`/`[1]`, points use only `[0]`).
    pub barycentric: [Vec4; 3],
}
