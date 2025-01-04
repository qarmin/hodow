// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrVertexPacket.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `VertexPacket` itself is the same "flexible array member has no safe Rust shape, so
// give it a plain owned `Vec<GenericVec4>` instead" reading an earlier pass of this
// port already settled on - that part is unchanged and is still exactly the "allocate
// it like anything else in Rust" simplification the project's own idiomatic-Rust rule
// calls for.
//
// `VertexPacketAllocator` itself *is* ported now, on a second look, for a reason the
// note it replaces did not weigh: upstream's own one is a one-shot *arena*, not a
// reuse pool - `allocArray` always calls `new int8_t[]` for a brand new region, and
// nothing is ever given back until the whole allocator (one per `drawInstanced` call
// upstream) is destroyed. Reproducing that shape literally would only win inside a
// single draw call (batching N per-vertex allocations into one), which a plain `Vec`
// of `VertexPacket`s already does for the packets themselves. **An earlier pass here
// framed the real win as happening *across* separate draw calls - that turned out to
// be wrong, not just imprecise**: `sglrReferenceContext.cpp`'s own draw call site
// constructs a fresh `rr::Renderer` per `glDrawArrays`/`glDrawElements`, exactly like
// this port already does, so nothing ever carries one draw call's allocator into the
// next. The real win is narrower and still genuine: *within* one `draw_instanced` call,
// clipping/culling/vertex-sharing can each produce a short-lived extra `VertexPacket`
// (a clipped triangle's new corner, a shared-vertex duplicate, a restart segment's own
// vertex-shaded set) that a plain `Vec::push`/rebuild would allocate and then drop
// again every single time; a free list recycles that `outputs` buffer back into the
// *next* such packet instead, for as long as the one allocator handed to that draw call
// stays alive. This `VertexPacketAllocator` is a free list on top of `VertexPacket::reset`:
// `alloc`/`alloc_array` pull a recycled packet and reset it in place (which only
// reallocates if the pooled `outputs` buffer is smaller than `num_outputs` now asks
// for) before falling back to `VertexPacket::new`, and `release` - which upstream has
// no counterpart for at all, since its arena never gives anything back before its own
// destructor - is what makes that recycling possible: a caller hands a finished batch
// of packets back once it is done with them, instead of letting them drop.
//
// Every production call site that builds a `VertexPacket` beyond an already-passed-in
// arena goes through one of two allocators, both scoped to a single `draw_instanced`
// call (`renderer.rs`'s own doc comment has the construction/threading detail for
// each): `draw_with_geometry_shader` builds one sized to the geometry shader's own
// output count (matching upstream's own `drawWithGeometryShader`) and threads it
// through every `GeometryEmitter` invocation, releasing each invocation's emitted
// packets back before the next one starts; `draw_instanced` itself (upstream's own
// `Renderer::drawInstanced`) builds one sized to the program's varying count and
// threads it through every restart segment of every instance - and that same
// allocator is what `clip.rs`'s `make_shared_vertices_distinct` (a repeated index's
// duplicate) and `clip_triangles`' own near/far-plane subdivision rebuild (a clipped
// triangle's new corner packets) both pull from now too, rather than growing their own
// arena by `.clone()`/`VertexPacket::new` independently of whichever allocator owns
// the rest of that same arena's packets.

use super::generic_vector::GenericVec4;
use crate::tcu::vector::Vec4;

/// `rr::VertexPacket`
///
/// Vertex packet contains inputs and outputs for vertex shading.
#[derive(Debug, Clone)]
pub struct VertexPacket {
    /// Instance index.
    pub instance_ndx: i32,
    /// Vertex index.
    pub vertex_ndx: i32,

    /// Transformed position - must be written always.
    pub position: Vec4,
    /// Point size, required when rendering points.
    pub point_size: f32,
    /// Geometry shader output.
    pub primitive_id: i32,

    /// Generic vertex shader outputs - passed to subsequent shader stages. Length is
    /// the number of outputs the program declares.
    pub outputs: Vec<GenericVec4>,
}

impl VertexPacket {
    /// Upstream's `VertexPacketAllocator::alloc`/`allocArray` default-construct a
    /// packet with `numVertexOutputs` output slots; this is that, minus the arena.
    pub fn new(num_outputs: usize) -> Self {
        Self {
            instance_ndx: 0,
            vertex_ndx: 0,
            position: Vec4::splat(0.0),
            point_size: 1.0,
            primitive_id: 0,
            outputs: vec![GenericVec4::zero(); num_outputs],
        }
    }

    /// Puts a packet back into the same just-constructed state `new` leaves it in,
    /// without dropping its `outputs` buffer first - `resize` only grows (and only
    /// reallocates when it does), so a packet recycled at the same `num_outputs` it
    /// already had never touches the allocator. Not upstream (the C++ arena never
    /// reuses a `VertexPacket` at all); this is what `VertexPacketAllocator::alloc`
    /// below calls on a pooled packet instead of `VertexPacket::new`.
    pub fn reset(&mut self, num_outputs: usize) {
        self.instance_ndx = 0;
        self.vertex_ndx = 0;
        self.position = Vec4::splat(0.0);
        self.point_size = 1.0;
        self.primitive_id = 0;
        self.outputs.clear();
        self.outputs.resize(num_outputs, GenericVec4::zero());
    }
}

/// `rr::VertexPacketAllocator`
///
/// See this file's own top doc comment for why this is a reuse free list rather than
/// a literal port of upstream's one-shot arena, and the complete list of production
/// call sites that pull from one of these rather than allocating a `VertexPacket`
/// independently.
pub struct VertexPacketAllocator {
    num_outputs: usize,
    free_list: Vec<VertexPacket>,
}

impl VertexPacketAllocator {
    pub fn new(num_outputs: usize) -> Self {
        Self {
            num_outputs,
            free_list: Vec::new(),
        }
    }

    /// `rr::VertexPacketAllocator::getNumVertexOutputs`
    pub fn num_vertex_outputs(&self) -> usize {
        self.num_outputs
    }

    /// `rr::VertexPacketAllocator::alloc` - pulls one packet off the free list,
    /// resetting it to this allocator's own `num_outputs`, or builds a fresh one if
    /// the free list is empty. Upstream instead refills its pool in batches of 8 via
    /// `allocArray` whenever it runs dry; this allocates one at a time on the fallback
    /// path since there is no arena-sizing reason here to do otherwise (see the "one
    /// allocation per *draw call*, not per vertex" framing in the top doc comment -
    /// `reset` is what makes a single fallback allocation here as cheap as upstream's
    /// batched ones were meant to be, since neither one is the common case once a
    /// caller is actually recycling arenas across draw calls).
    pub fn alloc(&mut self) -> VertexPacket {
        match self.free_list.pop() {
            Some(mut packet) => {
                packet.reset(self.num_outputs);
                packet
            }
            None => VertexPacket::new(self.num_outputs),
        }
    }

    /// `rr::VertexPacketAllocator::allocArray`
    pub fn alloc_array(&mut self, count: usize) -> Vec<VertexPacket> {
        (0..count).map(|_| self.alloc()).collect()
    }

    /// No upstream counterpart (its arena is only ever freed whole, in its own
    /// destructor) - this is the other half of making `VertexPacketAllocator` a reuse
    /// pool: a caller done with an arena hands it back here instead of letting it drop,
    /// so the next `alloc`/`alloc_array` can recycle its packets' `outputs` buffers.
    pub fn release(&mut self, packets: Vec<VertexPacket>) {
        self.free_list.extend(packets);
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn new_has_requested_output_slots() {
        let p = VertexPacket::new(3);
        assert_eq!(p.outputs.len(), 3);
        assert_eq!(p.position.x(), 0.0);
        assert_eq!(p.point_size, 1.0);
    }

    #[test]
    fn zero_outputs_is_allowed() {
        let p = VertexPacket::new(0);
        assert!(p.outputs.is_empty());
    }

    #[test]
    fn reset_restores_every_field_to_news_own_defaults() {
        let mut p = VertexPacket::new(3);
        p.instance_ndx = 7;
        p.vertex_ndx = 9;
        p.position = Vec4::new(1.0, 2.0, 3.0, 4.0);
        p.point_size = 5.0;
        p.primitive_id = 11;
        p.outputs[1] = GenericVec4::from_float(Vec4::new(9.0, 9.0, 9.0, 9.0));

        p.reset(3);

        assert_eq!(p.instance_ndx, 0);
        assert_eq!(p.vertex_ndx, 0);
        assert_eq!(p.position, Vec4::splat(0.0));
        assert_eq!(p.point_size, 1.0);
        assert_eq!(p.primitive_id, 0);
        assert_eq!(p.outputs.len(), 3);
        assert!(p.outputs.iter().all(|o| *o == GenericVec4::zero()));
    }

    #[test]
    fn reset_to_fewer_outputs_truncates_the_slot_count() {
        let mut p = VertexPacket::new(4);
        p.reset(2);
        assert_eq!(p.outputs.len(), 2);
    }

    #[test]
    fn reset_to_more_outputs_grows_the_slot_count() {
        let mut p = VertexPacket::new(1);
        p.reset(5);
        assert_eq!(p.outputs.len(), 5);
        assert!(p.outputs.iter().all(|o| *o == GenericVec4::zero()));
    }

    #[test]
    fn alloc_array_returns_the_requested_count_with_the_allocators_own_output_slot_count() {
        let mut alloc = VertexPacketAllocator::new(2);
        let packets = alloc.alloc_array(5);
        assert_eq!(packets.len(), 5);
        assert!(packets.iter().all(|p| p.outputs.len() == 2));
    }

    #[test]
    fn alloc_falls_back_to_a_fresh_packet_when_the_free_list_is_empty() {
        let mut alloc = VertexPacketAllocator::new(4);
        let p = alloc.alloc();
        assert_eq!(p.outputs.len(), 4);
        assert_eq!(p.position, Vec4::splat(0.0));
    }

    #[test]
    fn num_vertex_outputs_reports_the_value_the_allocator_was_constructed_with() {
        let alloc = VertexPacketAllocator::new(6);
        assert_eq!(alloc.num_vertex_outputs(), 6);
    }

    /// The whole point of this being a free list rather than `VertexPacket::new` at
    /// every call site: a packet handed back via `release` and pulled back out via the
    /// next `alloc` at the same `num_outputs` must be the *same* `outputs` heap
    /// allocation, not a freshly reallocated one - `reset`'s `clear()` leaves capacity
    /// untouched and `resize` back up to an already-held capacity reallocates nothing,
    /// so the pointer survives the round trip if and only if recycling actually happened.
    #[test]
    fn release_then_alloc_reuses_the_same_outputs_allocation_at_matching_output_count() {
        let mut alloc = VertexPacketAllocator::new(4);
        let packets = alloc.alloc_array(3);
        // `release` pushes onto a `Vec` free list that `alloc` pops from (LIFO), so the
        // *last* packet handed to `release` is the one the very next `alloc` hands back.
        let last_ptr = packets.last().unwrap().outputs.as_ptr();

        alloc.release(packets);
        let reused = alloc.alloc();

        assert_eq!(
            reused.outputs.as_ptr(),
            last_ptr,
            "alloc after release must recycle the pooled packet's own outputs buffer, not allocate a new one"
        );
        assert_eq!(reused.outputs.len(), 4);
    }
}
