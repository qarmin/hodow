// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's reference renderer is a whole software rasteriser (`rrRenderer`,
// `rrRasterizer`, `rrShaders`, ...), and as of this port that whole pipeline is here:
// vertex attribute fetch (`vertex_attrib`), primitive assembly for every GL primitive
// type including the adjacency ones (`primitive_assembler`, `primitive_types`), the
// generic polygon-clip-against-a-plane algorithm plus flatshading and primitive-ID
// generation (`clip`), fixed-point triangle and line rasterisation at 1/2/4/8/16
// samples (`rasterizer`), and `renderer::Renderer::draw`/`draw_instanced` tying all of
// it together - vertex shading, clipping, window-coordinate transform, rasterising,
// fragment shading, and writing through `fragment_operations::FragmentProcessor` (ported
// earlier, before `Renderer` existed to call it, and genuinely multisample-aware now -
// see `renderer`'s own module doc). Geometry shading is wired in too
// (`draw_with_geometry_shader`, see `renderer`'s own doc comment for the exact shape).
// See `renderer`'s own module doc for what is deliberately still narrower than upstream
// (`DrawIndices` is a safe enum instead of a raw pointer, tessellation is not wired in -
// upstream's own reference renderer never wires it in either).
//
// `triangle_rasterizer` is **not** a part of this and predates it - it is a small,
// purpose-built triangle rasteriser written for `gls::texture_buffer_case`, kept as its
// own separate, reduced thing (see its own module doc) rather than folded into
// `rasterizer`/`renderer`, since that caller's geometry needs no clipping or
// perspective divide and migrating it buys nothing.
//
// `sglr::GLContext`/`sglr::ReferenceContext` - the software GL object/state-machine
// layer built on top of all of this - is under active, ongoing porting; see `sglr`'s
// own module doc for exactly how far it currently reaches (deliberately not restated
// here, since that doc is updated far more often than this one and the two drifting
// apart would be worse than one pointer).
//
// `multisample_pixel_buffer_access` is the actual MSAA *resolve* (averaging a
// multisampled buffer down to one value per pixel) - see its own module doc for why the
// wrapper types upstream wraps this in are not ported (this port already addresses a
// multisample buffer as a plain `tcu::pixel` access, see `renderer`'s own doc) and for
// why it has no caller yet, the same "general-purpose piece built ahead of the case
// that will use it" call `vertex_packet`'s `VertexPacketAllocator` already made.

pub mod clip;
pub mod defs;
pub mod fragment_operations;
pub mod fragment_packet;
pub mod generic_vector;
pub mod multisample_pixel_buffer_access;
pub mod primitive_assembler;
pub mod primitive_packet;
pub mod primitive_types;
pub mod rasterizer;
pub mod render_state;
pub mod renderer;
pub mod shaders;
pub mod shading_context;
pub mod triangle_rasterizer;
pub mod vertex_attrib;
pub mod vertex_packet;
