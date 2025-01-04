// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrDefs.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `rr::FaceType` is not repeated here
// - it already lives in `rr::render_state`, ported for `FragmentProcessor` before this
// file existed, and both halves mean the same enum.

/// `rr::IndexType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum IndexType {
    Uint8,
    Uint16,
    Uint32,
}

/// `rr::ProvokingVertex`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ProvokingVertex {
    /// The first vertex of the primitive provokes (OpenGL ES convention).
    First,
    /// The last vertex of the primitive provokes (Vulkan convention).
    Last,
}
