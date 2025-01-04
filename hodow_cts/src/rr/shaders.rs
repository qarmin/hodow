// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrShaders.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's abstract base classes
// (`VertexShader`/`FragmentShader`/`GeometryShader`) become Rust traits;
// `VertexShaderLoop<Shader>`/`FragmentShaderLoop<Shader>` are not ported, and this was
// re-checked rather than taken on an earlier pass's word for it: they are not merely
// unused *here*, they are dead code in upstream itself. Both are a template adapter -
// given any `Shader` with a *singular* `shadeVertex(inputs, packet)`/
// `shadeFragment(packet)` method, wrap it in a loop over `numPackets` to satisfy the
// *batch* `VertexShader`/`FragmentShader` interface (`shadeVertices`/`shadeFragments`)
// this file's own traits already are. Grepping the whole upstream tree
// (`tmp/VK-GL-CTS/`) for `VertexShaderLoop<`/`FragmentShaderLoop<` and for any class
// anywhere defining a singular `shadeVertex`/`shadeFragment` method turns up nothing
// outside `rrShaders.hpp` itself - no template instantiation, no `Shader` concept to adapt.
// Every concrete shader this port has, upstream and here alike (`sglr::reference_
// context`'s `PassthroughVertexShader`, `ConstantColorFragmentShader`,
// `InstancedColorVertexShader`, `FlatVaryingFragmentShader`, ...) implements
// `VertexShader`/`FragmentShader` directly in its own batch form, bypassing the loop
// helper entirely rather than being a `Shader` the helper would wrap. Porting the
// helper now would be porting code upstream itself never calls.

use super::generic_vector::GenericVecType;
use super::primitive_packet::{GeometryEmitter, PrimitivePacket};
use super::vertex_attrib::VertexAttrib;
use super::vertex_packet::VertexPacket;
use crate::rr::fragment_packet::FragmentPacket;
use crate::rr::shading_context::FragmentShadingContext;

/// `rr::VertexInputInfo`
#[derive(Debug, Clone, Copy, Default)]
pub struct VertexInputInfo {
    pub type_: Option<GenericVecType>,
}

/// `rr::VertexVaryingInfo` (aliased upstream as `VertexOutputInfo`/`FragmentInputInfo`/
/// `GeometryInputInfo`/`GeometryOutputInfo` - kept as one type here too).
#[derive(Debug, Clone, Copy, Default, PartialEq)]
pub struct VertexVaryingInfo {
    pub type_: Option<GenericVecType>,
    pub flatshade: bool,
}

pub type VertexOutputInfo = VertexVaryingInfo;
pub type FragmentInputInfo = VertexVaryingInfo;
pub type GeometryInputInfo = VertexVaryingInfo;
pub type GeometryOutputInfo = VertexVaryingInfo;

/// `rr::FragmentOutputInfo`
#[derive(Debug, Clone, Copy, Default)]
pub struct FragmentOutputInfo {
    pub type_: Option<GenericVecType>,
}

/// `rr::VertexShader`
///
/// Vertex shaders execute shading for a set of vertex packets. See `VertexPacket`
/// documentation for more details on the shading API.
pub trait VertexShader {
    fn inputs(&self) -> &[VertexInputInfo];
    fn outputs(&self) -> &[VertexOutputInfo];

    fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]);
}

/// `rr::FragmentShader`
///
/// Executes shading for a list of fragment packets. See `FragmentPacket`
/// documentation for more details on the shading API.
pub trait FragmentShader {
    fn inputs(&self) -> &[FragmentInputInfo];
    fn outputs(&self) -> &[FragmentOutputInfo];

    /// `numPackets` must be greater than zero.
    fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext);
}

/// `rr::GeometryShaderInputType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum GeometryShaderInputType {
    Points,
    Lines,
    LinesAdjacency,
    Triangles,
    TrianglesAdjacency,
}

/// `rr::GeometryShaderOutputType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum GeometryShaderOutputType {
    Points,
    LineStrip,
    TriangleStrip,
}

/// `rr::GeometryShader`
///
/// Executes a list of primitive packets and outputs a new set of vertex packets for
/// new primitives.
pub trait GeometryShader {
    fn inputs(&self) -> &[GeometryInputInfo];
    fn outputs(&self) -> &[GeometryOutputInfo];

    fn input_type(&self) -> GeometryShaderInputType;
    fn output_type(&self) -> GeometryShaderOutputType;
    fn num_vertices_out(&self) -> usize;
    fn num_invocations(&self) -> usize;

    /// `GeometryShader::shadePrimitives` - `arena` is new relative to upstream's own
    /// signature: upstream's `PrimitivePacket::vertices` are raw `const VertexPacket*`,
    /// directly dereferenceable by the shader body with no further argument needed.
    /// This port's `PrimitivePacket::vertices` are arena indices instead (see that
    /// type's own doc comment), so an implementation needs the arena itself to resolve
    /// `packets[i].vertices[v]` back to a `&VertexPacket` - `rr::renderer::draw_with_geometry_shader`
    /// is the one caller and always has it (the vertex-shaded input arena, read-only
    /// for the whole geometry-shading stage).
    fn shade_primitives(
        &self,
        output: &mut GeometryEmitter<'_>,
        vertices_in: i32,
        packets: &[PrimitivePacket],
        invocation_id: i32,
        arena: &[VertexPacket],
    );
}
