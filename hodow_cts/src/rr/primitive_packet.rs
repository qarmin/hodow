// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrPrimitivePacket.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Geometry shading is wired into `rr::Renderer::draw_with_geometry_shader` (see that
// function's own doc comment) - `PrimitivePacket`/`GeometryEmitter` here are exactly
// what that caller builds and drains.
//
// `GeometryEmitter` takes a `&mut VertexPacketAllocator` exactly like upstream's own
// constructor does (this note used to say the allocator was dropped entirely and
// `emit_vertex` allocated through plain `VertexPacket::new` instead - true of an
// earlier pass, no longer true now that `vertex_packet.rs` ports the allocator as a
// reuse pool; see its own top doc comment for why). `draw_with_geometry_shader` builds
// one sized to the geometry shader's own output count, matching upstream's "vertices
// outputted by geometry shader may have different number of output variables than the
// original, create new memory allocator" - a GS can change the varying count, so this
// is never the same allocator the vertex-shading arena itself came from.

use super::generic_vector::GenericVec4;
use super::vertex_packet::{VertexPacket, VertexPacketAllocator};
use crate::tcu::vector::Vec4;

/// `rr::PrimitivePacket`
///
/// Geometry packet: inputs for geometry shading. Upstream's `vertices` is a raw
/// `const VertexPacket*[6]`; an index into the renderer's own vertex-packet arena
/// replaces the pointer here, the same translation `rr::primitive_assembler` uses and
/// for the same reason (see that module's doc comment).
pub struct PrimitivePacket {
    pub primitive_id_in: i32,
    pub vertices: [Option<usize>; 6],
}

/// `rr::GeometryEmitter`
///
/// Handles outputting of new vertices from a geometry shader. `None` entries in the
/// emitted list mark `EndPrimitive()` the same way upstream uses a null `VertexPacket*`.
pub struct GeometryEmitter<'a> {
    vpalloc: &'a mut VertexPacketAllocator,
    max_vertices: usize,
    num_emitted: usize,
    emitted: Vec<Option<VertexPacket>>,
}

impl<'a> GeometryEmitter<'a> {
    /// `GeometryEmitter::GeometryEmitter`
    pub fn new(vpalloc: &'a mut VertexPacketAllocator, num_vertices: usize) -> Self {
        Self {
            vpalloc,
            max_vertices: num_vertices,
            num_emitted: 0,
            emitted: Vec::new(),
        }
    }

    /// `GeometryEmitter::EmitVertex`
    ///
    /// Panics past `num_vertices` emitted since the last `end_primitive`, matching
    /// upstream's `DE_FATAL("Undefined results, too many vertices emitted.")`.
    pub fn emit_vertex(&mut self, position: Vec4, point_size: f32, varyings: &[GenericVec4], primitive_id: i32) {
        self.num_emitted += 1;
        assert!(
            self.num_emitted <= self.max_vertices,
            "Undefined results, too many vertices emitted."
        );

        let mut packet = self.vpalloc.alloc();
        packet.position = position;
        packet.point_size = point_size;
        packet.primitive_id = primitive_id;
        for (dst, src) in packet.outputs.iter_mut().zip(varyings.iter()) {
            *dst = *src;
        }

        self.emitted.push(Some(packet));
    }

    /// `GeometryEmitter::EndPrimitive`
    pub fn end_primitive(&mut self) {
        self.num_emitted = 0;
        self.emitted.push(None);
    }

    /// `GeometryEmitter::moveEmittedTo`
    pub fn move_emitted_to(&mut self, output: &mut Vec<Option<VertexPacket>>) {
        std::mem::swap(&mut self.emitted, output);
        self.emitted.clear();
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn emit_vertex_copies_varyings() {
        let mut vpalloc = VertexPacketAllocator::new(2);
        let mut emitter = GeometryEmitter::new(&mut vpalloc, 4);
        let varyings = [
            GenericVec4::from_float(Vec4::new(1.0, 2.0, 3.0, 4.0)),
            GenericVec4::zero(),
        ];
        emitter.emit_vertex(Vec4::new(0.0, 0.0, 0.0, 1.0), 1.0, &varyings, 7);

        let mut out = Vec::new();
        emitter.move_emitted_to(&mut out);
        assert_eq!(out.len(), 1);
        let packet = out[0].as_ref().unwrap();
        assert_eq!(packet.primitive_id, 7);
        assert_eq!(packet.outputs[0].get_float().x(), 1.0);
    }

    #[test]
    fn end_primitive_pushes_none_marker() {
        let mut vpalloc = VertexPacketAllocator::new(0);
        let mut emitter = GeometryEmitter::new(&mut vpalloc, 4);
        emitter.emit_vertex(Vec4::splat(0.0), 1.0, &[], 0);
        emitter.end_primitive();

        let mut out = Vec::new();
        emitter.move_emitted_to(&mut out);
        assert_eq!(out.len(), 2);
        assert!(out[0].is_some());
        assert!(out[1].is_none());
    }

    #[test]
    #[should_panic(expected = "too many vertices emitted")]
    fn emitting_past_max_vertices_panics() {
        let mut vpalloc = VertexPacketAllocator::new(0);
        let mut emitter = GeometryEmitter::new(&mut vpalloc, 1);
        emitter.emit_vertex(Vec4::splat(0.0), 1.0, &[], 0);
        emitter.emit_vertex(Vec4::splat(0.0), 1.0, &[], 0);
    }

    /// Emitted vertices must come from the allocator's own free list when one is
    /// available, the same proof `vertex_packet.rs`'s own test gives for `alloc`
    /// directly - this is the one real behavioural difference from the old
    /// `VertexPacket::new`-per-vertex shape: a recycled packet's `outputs` buffer is
    /// reused rather than reallocated.
    #[test]
    fn emit_vertex_recycles_a_released_packet_from_the_allocator() {
        let mut vpalloc = VertexPacketAllocator::new(3);
        let recycled_ptr = {
            let mut first = GeometryEmitter::new(&mut vpalloc, 1);
            first.emit_vertex(Vec4::splat(0.0), 1.0, &[GenericVec4::zero(); 3], 0);
            let mut out = Vec::new();
            first.move_emitted_to(&mut out);
            let ptr = out[0].as_ref().unwrap().outputs.as_ptr();
            vpalloc.release(out.into_iter().flatten().collect());
            ptr
        };

        let mut second = GeometryEmitter::new(&mut vpalloc, 1);
        second.emit_vertex(Vec4::splat(0.0), 1.0, &[GenericVec4::zero(); 3], 0);
        let mut out = Vec::new();
        second.move_emitted_to(&mut out);

        assert_eq!(out[0].as_ref().unwrap().outputs.as_ptr(), recycled_ptr);
    }
}
