// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrPrimitiveTypes.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `PrimitiveTypeTraits<T>`
// template specialisation maps each `PrimitiveType` enumerator to its assembler type at
// compile time, used so `rrRenderer.cpp`'s one templated `drawAsPrimitives<DrawPrimitiveType>`
// body works for every primitive type. Rust has no partial template specialisation to
// mirror that with; `Renderer::draw` instead `match`es on this enum directly and calls
// the one assembler function (`primitive_assembler::assemble_*`) that corresponds to
// it - same mapping, expressed as a runtime dispatch instead of a compile-time trait
// lookup, since every case still compiles to the same handful of assembler calls either
// way.

/// `rr::PrimitiveType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PrimitiveType {
    /// Separate triangles.
    Triangles,
    /// Triangle strip.
    TriangleStrip,
    /// Triangle fan.
    TriangleFan,

    /// Separate lines.
    Lines,
    /// Line strip.
    LineStrip,
    /// Line loop.
    LineLoop,

    /// Points.
    Points,

    /// Separate lines (adjacency).
    LinesAdjacency,
    /// Line strip (adjacency).
    LineStripAdjacency,
    /// Separate triangles (adjacency).
    TrianglesAdjacency,
    /// Triangle strip (adjacency).
    TriangleStripAdjacency,
}

impl PrimitiveType {
    /// Upstream's `PrimitiveTypeTraits<T>::BaseType` - whether the primitive type's
    /// generated primitives are triangles, lines or points, once any adjacency-only
    /// vertices are set aside. This is what a shader-interpolation or culling path
    /// switches on; the adjacency vertices themselves stay visible on the assembled
    /// primitive for anything that does need them (a geometry shader).
    pub fn base_type(self) -> PrimitiveBaseType {
        use PrimitiveType::*;
        match self {
            Triangles | TriangleStrip | TriangleFan | TrianglesAdjacency | TriangleStripAdjacency => {
                PrimitiveBaseType::Triangle
            }
            Lines | LineStrip | LineLoop | LinesAdjacency | LineStripAdjacency => PrimitiveBaseType::Line,
            Points => PrimitiveBaseType::Point,
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PrimitiveBaseType {
    Triangle,
    Line,
    Point,
}
