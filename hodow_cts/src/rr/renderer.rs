// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrRenderer.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Scope deliberately narrowed for this port, each documented at its own site below:
//
//  - **Geometry shading is wired in** (`drawWithGeometryShader`,
//    `drawGeometryShaderOutputAsPrimitives`, `copyVertexPacketPointers` - all three
//    folded into `draw_with_geometry_shader` below, see its own doc comment for the
//    shape). `GeometryShader::shade_primitives` gained an `arena: &[VertexPacket]`
//    parameter upstream's signature doesn't have - see that trait method's own doc
//    comment for why (`PrimitivePacket::vertices` are arena indices here, not raw
//    pointers). Not ported: upstream's `rr::Tesselator` stage (`// if (state.tesselation)
//    ... ` is commented out in upstream itself, i.e. tessellation shading was never
//    wired into the *reference* renderer upstream either - GLES31's `tessellation.*`
//    groups that need a host-rendered reference image compute it some other way, not
//    through this renderer; not investigated by this port).
//  - **`RenderTarget` is genuinely multisample now.** Upstream's
//    `rr::MultisamplePixelBufferAccess` is still not ported as its own wrapper type -
//    `rr::fragment_operations::FragmentProcessor::render` (ported in an earlier
//    session, *before* `Renderer` existed to call it) already expected a
//    `tcu::PixelBufferAccess` laid out exactly as upstream's
//    `MultisamplePixelBufferAccess` would hand it one: samples addressed through the
//    buffer's own *width*, real x/y through its height/depth (`num_samples_per_fragment
//    = color_buffer.size()[0]`). `as_multisample_view` below is the one-line reshape a
//    single-sampled caller needs (upstream's `fromSinglesampleAccess`); a genuinely
//    multisampled caller instead constructs its `PixelBufferAccess`es directly with
//    `size[0] == num_samples` (samples addressed through the same dimension) and hands
//    them to `RenderTarget::new` unreshaped. `RenderTarget::get_num_samples` now reads
//    that dimension straight off `color_buffers[0]` (`size()[0]`, matching upstream's
//    own `RenderTarget::getNumSamples` -> `m_colorBuffers[0].getNumSamples()` ->
//    `raw().getWidth()`) instead of a hardcoded `1`, so a multisampled target actually
//    drives `TriangleRasterizer`/`MultiSampleLineRasterizer` down their genuine
//    multi-sample paths rather than only ever exercising single-sample. `Fragment` grew
//    a `sample_depths: [f32; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT]` array (see that
//    struct's own doc comment) and `FragmentProcessor::render`'s depth test/write now
//    index into it per-sample instead of reading one shared depth for every sample of a
//    fragment; `write_fragment_packets` below fills it from the rasterizer's per-sample
//    depth buffer the same way upstream's `Fragment::sampleDepths` pointer addresses
//    it. `rasterize_line` now takes the same `numSamples > 1` branch upstream's
//    `rasterizePrimitive<pa::Line>` does, choosing `MultiSampleLineRasterizer` over
//    `SingleSampleLineRasterizer` - not ported as its own standalone test target here,
//    since it has none beyond what `rasterizer`'s own unit tests already cover and
//    nothing in this file adds logic on top of calling it.
//  - **`DrawIndices` is a safe enum of typed slices, not a raw `(const void*, IndexType)`
//    pair.** Upstream's index buffer is always already-owned memory by the time it
//    reaches this layer (there is no FFI boundary here forcing a raw pointer the way
//    `rr::VertexAttrib::pointer` has one for arbitrary-stride vertex data), so
//    `DrawIndices<'a>` borrows `&'a [u8]`/`&'a [u16]`/`&'a [u32]` directly and
//    `readIndexArray`'s unsafe byte-offset read is not needed at all.
//  - **`isValidCommand` is ported in full now**, including its geometry-shader branches,
//    the "destination buffer basic type matches fragment output type" cross-check
//    (`getTextureChannelClass` of each colour buffer's own format against the matching
//    fragment-shader output's `GenericVecType` - this is a real, non-vacuous check even
//    with `RenderTarget`'s single colour buffer: it fires whenever a caller declares a
//    float fragment output but hands `RenderTarget::new` an integer-format colour
//    buffer, or vice versa), and the "every colour buffer matches buffer 0 for size and
//    sample count" loop above that one. The latter is ported verbatim despite being
//    genuinely vacuous with exactly one buffer - `RenderTarget::new`'s own doc comment
//    has the full finding, confirmed by reading `rrRenderer.cpp`'s
//    `RenderTarget::RenderTarget` directly: `m_numColorBuffers(1)` is hardcoded in
//    upstream's one and only constructor, with no other call site anywhere in the whole
//    reference-renderer framework that ever builds one with more, so the loop is a
//    single trivial iteration there too, not merely here - porting it costs nothing and
//    activates correctly with no further change the moment (if ever) that stops being
//    true.
//  - **`draw_instanced` threads a `VertexPacketAllocator` through every restart segment
//    of every instance now**, matching upstream's own single `VertexPacketAllocator
//    vpalloc(numVaryings)` declared once per `drawInstanced` - see that function's own
//    comment for what this replaced (a fresh `Vec<VertexPacket>` built via
//    `VertexPacket::new` per segment-per-instance) and `vertex_packet.rs`'s module doc
//    for the allocator itself.

use super::clip::{self, BasePrimitiveList};
use super::defs::{IndexType, ProvokingVertex};
use super::fragment_operations::{Fragment, FragmentProcessor};
use super::fragment_packet::FragmentPacket;
use super::generic_vector::GenericVec4;
use super::primitive_assembler::{self as pa};
use super::primitive_packet::{GeometryEmitter, PrimitivePacket};
use super::primitive_types::PrimitiveType;
use super::rasterizer::{
    MultiSampleLineRasterizer, RASTERIZER_MAX_SAMPLES_PER_FRAGMENT, SingleSampleLineRasterizer, TriangleRasterizer,
    get_coverage_any_fragment_sample_live, get_coverage_fragment_sample_bits, get_coverage_offset,
};
use super::render_state::{CullMode, FaceType, RenderState, StencilOp};
use super::shaders::{FragmentShader, GeometryShader, GeometryShaderInputType, GeometryShaderOutputType, VertexShader};
use super::shading_context::FragmentShadingContext;
use super::vertex_attrib::VertexAttrib;
use super::vertex_packet::{VertexPacket, VertexPacketAllocator};
use crate::tcu::pixel::{DepthStencilMode, PixelBufferAccess, into_effective_depth_stencil_access};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass};
use crate::tcu::vector::{IVec2, IVec4, Vec4};

/// `rr::(anonymous)::rectIntersection`
fn rect_intersection(a: IVec4, b: IVec4) -> IVec4 {
    let pos = (a.x().max(b.x()), a.y().max(b.y()));
    let end_pos = ((a.x() + a.z()).min(b.x() + b.z()), (a.y() + a.w()).min(b.y() + b.w()));
    IVec4::new(pos.0, pos.1, end_pos.0 - pos.0, end_pos.1 - pos.1)
}

/// `getBufferSize` - just the width/height (upstream also reports a z/depth-layer size
/// this port has no multi-layer render target for).
fn get_buffer_size(access: &PixelBufferAccess<'_>) -> IVec4 {
    let size = access.size();
    IVec4::new(0, 0, size[1] as i32, size[2] as i32)
}

/// `MAX_COLOR_BUFFERS`
pub const MAX_COLOR_BUFFERS: usize = 4;

/// Upstream's `MultisamplePixelBufferAccess::fromSinglesampleAccess` - reshapes a plain
/// `(width, height)` access into the `(samples=1, width, height)` layout
/// `rr::fragment_operations::FragmentProcessor::render` already addresses through
/// `size()[0]`/pixel `(sample, x, y)`. See this module's top doc comment for why no
/// separate wrapper type exists here.
pub fn as_multisample_view<'a>(access: PixelBufferAccess<'a>) -> PixelBufferAccess<'a> {
    let format = access.format();
    let size = access.size();
    let pitch = access.pitch();
    let data = access.into_raw_mut();
    // new pitch: [sample-step (unused, size[0]==1), x-step = old pixel pitch, y-step = old row pitch]
    PixelBufferAccess::new_with_pitch(format, [1, size[0], size[1]], [0, pitch[0], pitch[1]], data)
}

/// `rr::RenderTarget`
pub struct RenderTarget<'a> {
    color_buffers: [Option<PixelBufferAccess<'a>>; MAX_COLOR_BUFFERS],
    num_color_buffers: usize,
    depth_buffer: Option<PixelBufferAccess<'a>>,
    stencil_buffer: Option<PixelBufferAccess<'a>>,
}

impl<'a> RenderTarget<'a> {
    /// `RenderTarget::RenderTarget` - narrowed to one colour buffer; upstream's own
    /// constructor also only ever takes one (`m_numColorBuffers(1)` is hardcoded in the
    /// C++ constructor body itself, confirmed by reading it directly, not inferred
    /// from the public interface alone). Unlike `VertexShaderLoop`/`FragmentShaderLoop`
    /// (`rr::shaders`' own doc comment) this one genuinely has a consumer downstream -
    /// `isValidCommand`'s own "enough fragment output sinks"/"same size and sample
    /// count across every colour buffer"/"destination type matches the matching
    /// output" checks (all three ported, the last two in `is_valid_command` below) all
    /// loop over `get_num_color_buffers()` - but the other three `MAX_COLOR_BUFFERS`
    /// slots are still permanently unreachable through this port's own code, for the
    /// same reason upstream's own are: nowhere in `rrRenderer.cpp`/`.hpp`'s whole
    /// reference-renderer framework is a `RenderTarget` ever constructed any other way
    /// (this is the *only* constructor, and it is this one hardcoded call), so a
    /// fragment shader declaring more than one output always fails the check just
    /// below, on real `deqp-vk`/`deqp-gles*` exactly as much as here. A real multi-
    /// output draw path would have to come from a caller of this port (`sglr`, or a
    /// future one) building a `RenderTarget` through some *other* constructor that
    /// does not exist yet - not from upstream ever doing so itself.
    ///
    /// `depth_buffer`/`stencil_buffer` go through `tcu::getEffectiveDepthStencilAccess` as upstream does, so a combined
    /// (or `D`-order `UNSIGNED_INT_24_8`) buffer resolves to its single-aspect view.
    pub fn new(
        color_buffer: PixelBufferAccess<'a>,
        depth_buffer: Option<PixelBufferAccess<'a>>,
        stencil_buffer: Option<PixelBufferAccess<'a>>,
    ) -> Self {
        let mut color_buffers: [Option<PixelBufferAccess<'a>>; MAX_COLOR_BUFFERS] = [None, None, None, None];
        color_buffers[0] = Some(color_buffer);
        Self {
            color_buffers,
            num_color_buffers: 1,
            depth_buffer: depth_buffer.map(|b| into_effective_depth_stencil_access(b, DepthStencilMode::Depth)),
            stencil_buffer: stencil_buffer.map(|b| into_effective_depth_stencil_access(b, DepthStencilMode::Stencil)),
        }
    }

    /// `RenderTarget::getNumSamples` - `m_colorBuffers[0].getNumSamples()`, i.e. the
    /// multisample-addressing dimension (`size()[0]`) of the first colour buffer. A
    /// caller that wants a single-sampled target reshapes its buffer through
    /// `as_multisample_view` first (`size()[0] == 1`); one built with `size()[0] ==
    /// num_samples` directly drives the rasterizers below down their genuine
    /// multi-sample paths. See this module's top doc comment.
    pub fn get_num_samples(&self) -> i32 {
        self.color_buffers[0]
            .as_ref()
            .expect("RenderTarget::new always fills slot 0")
            .size()[0] as i32
    }

    pub fn get_num_color_buffers(&self) -> usize {
        self.num_color_buffers
    }

    pub fn color_buffer(&self, ndx: usize) -> &PixelBufferAccess<'a> {
        self.color_buffers[ndx]
            .as_ref()
            .expect("color buffer index out of range")
    }

    pub fn color_buffer_mut(&mut self, ndx: usize) -> &mut PixelBufferAccess<'a> {
        self.color_buffers[ndx]
            .as_mut()
            .expect("color buffer index out of range")
    }

    pub fn depth_buffer(&self) -> Option<&PixelBufferAccess<'a>> {
        self.depth_buffer.as_ref()
    }
}

/// `rr::Program`
pub struct Program<'a> {
    pub vertex_shader: &'a dyn VertexShader,
    pub fragment_shader: &'a dyn FragmentShader,
    pub geometry_shader: Option<&'a dyn GeometryShader>,
}

/// `rr::DrawIndices` - see this module's top doc comment for why this is an enum of
/// borrowed typed slices rather than a raw-pointer-plus-`IndexType` pair.
#[derive(Clone, Copy)]
pub enum DrawIndices<'a> {
    U8(&'a [u8], i32),
    U16(&'a [u16], i32),
    U32(&'a [u32], i32),
}

impl DrawIndices<'_> {
    fn get(&self, ndx: usize) -> u32 {
        match self {
            DrawIndices::U8(a, _) => a[ndx] as u32,
            DrawIndices::U16(a, _) => a[ndx] as u32,
            DrawIndices::U32(a, _) => a[ndx],
        }
    }

    fn base_vertex(&self) -> i32 {
        match self {
            DrawIndices::U8(_, b) | DrawIndices::U16(_, b) | DrawIndices::U32(_, b) => *b,
        }
    }
}

/// `rr::PrimitiveList`
pub struct PrimitiveList<'a> {
    primitive_type: PrimitiveType,
    num_elements: usize,
    indices: Option<DrawIndices<'a>>,
    /// The GL element type the index buffer was declared with (`GL_UNSIGNED_BYTE`/
    /// `_SHORT`/`_INT`, `None` for a `drawArrays`-like list) - kept as its own field
    /// rather than derived from `indices`' own `DrawIndices` variant, because a caller
    /// is free to decode every width into one owned `u32` buffer for storage
    /// convenience (`sglr::reference_context`'s `decode_indices` does exactly that,
    /// documented at that module's own top doc comment) and still needs the *original*
    /// GL type preserved for anything that depends on it, chiefly
    /// `GL_PRIMITIVE_RESTART_FIXED_INDEX`'s own per-width restart value
    /// (`0xFF`/`0xFFFF`/`0xFFFFFFFF` - see `index_type`'s own doc comment) - deriving it
    /// from a `DrawIndices::U32` wrapper around already-widened data would silently
    /// always answer `Uint32`, however the original buffer was actually declared.
    index_type: Option<IndexType>,
    /// Only meaningful when `indices` is `None` - the `drawArrays`-like "first" vertex.
    first_element: i32,
}

impl<'a> PrimitiveList<'a> {
    /// `PrimitiveList(PrimitiveType, int numElements, int firstElement)` -
    /// `drawArrays`-like.
    pub fn from_arrays(primitive_type: PrimitiveType, num_elements: usize, first_element: i32) -> Self {
        Self {
            primitive_type,
            num_elements,
            indices: None,
            index_type: None,
            first_element,
        }
    }

    /// `PrimitiveList(PrimitiveType, int numElements, const DrawIndices&)` -
    /// `drawElements`-like. `index_type` is the GL element type the caller's index
    /// buffer was actually declared with - see this struct's own `index_type` field
    /// doc comment for why it is a separate parameter rather than read off `indices`.
    pub fn from_indices(
        primitive_type: PrimitiveType,
        num_elements: usize,
        indices: DrawIndices<'a>,
        index_type: IndexType,
    ) -> Self {
        Self {
            primitive_type,
            num_elements,
            indices: Some(indices),
            index_type: Some(index_type),
            first_element: 0,
        }
    }

    pub fn num_elements(&self) -> usize {
        self.num_elements
    }

    pub fn primitive_type(&self) -> PrimitiveType {
        self.primitive_type
    }

    /// `PrimitiveList::getIndex`
    pub fn get_index(&self, element_ndx: usize) -> usize {
        match &self.indices {
            Some(indices) => (indices.base_vertex() + indices.get(element_ndx) as i32) as usize,
            None => self.first_element as usize + element_ndx,
        }
    }

    /// `PrimitiveList::isRestartIndex`
    pub fn is_restart_index(&self, element_ndx: usize, restart_index: u32) -> bool {
        match &self.indices {
            Some(indices) => indices.get(element_ndx) == restart_index,
            None => element_ndx as u32 == restart_index,
        }
    }

    /// `PrimitiveList::getIndexType` - `None` for a `drawArrays`-like list (upstream's
    /// own `INDEXTYPE_LAST` sentinel, "not indexed"), otherwise the GL element type the
    /// index buffer was declared with. `GL_PRIMITIVE_RESTART_FIXED_INDEX`'s own restart
    /// value is defined per this width (`0xFF`/`0xFFFF`/`0xFFFFFFFF`) - see
    /// `sglr::reference_context`'s own `draw_with_reference`, the one caller that needs
    /// it (upstream's `getFixedRestartIndex`/`drawWithReference`).
    pub fn index_type(&self) -> Option<IndexType> {
        self.index_type
    }
}

/// `rr::DrawCommand` - narrowed to hold the render target by reference the same way
/// upstream's `const RenderTarget&` does; `Renderer::draw`/`draw_instanced` take it
/// `&mut` separately rather than bundling it behind `&DrawCommand`, since Rust cannot
/// express "mutate through a field of a shared reference" the way the C++
/// `const RenderTarget&` (mutating through the `PixelBufferAccess`es it holds) does.
pub struct DrawCommand<'a> {
    pub state: &'a RenderState,
    pub program: &'a Program<'a>,
    pub vertex_attribs: &'a [VertexAttrib],
    pub primitives: &'a PrimitiveList<'a>,
}

// --- Polygon offset / depth-slope helpers ---

/// `findTriangleVertexDepthSlope`
fn find_triangle_vertex_depth_slope(p: Vec4, v0: Vec4, v1: Vec4) -> f32 {
    let a = (v0.x() - p.x(), v0.y() - p.y(), v0.z() - p.z());
    let b = (v1.x() - p.x(), v1.y() - p.y(), v1.z() - p.z());
    let epsilon = 0.0001f32;
    let det = a.0 * b.1 - b.0 * a.1;

    if det.abs() < epsilon {
        return 0.0;
    }

    let dx_dir = (b.1 / det, -a.1 / det);
    let dy_dir = (-b.0 / det, a.0 / det);

    let dzdx = dx_dir.0 * a.2 + dx_dir.1 * b.2;
    let dzdy = dy_dir.0 * a.2 + dy_dir.1 * b.2;

    dzdx.abs().max(dzdy.abs())
}

/// `findPrimitiveMaximumDepthSlope`
fn find_primitive_maximum_depth_slope(triangle: &pa::Triangle, arena: &[VertexPacket]) -> f32 {
    let p0 = arena[triangle.v0].position;
    let p1 = arena[triangle.v1].position;
    let p2 = arena[triangle.v2].position;

    let d1 = find_triangle_vertex_depth_slope(p0, p1, p2);
    let d2 = find_triangle_vertex_depth_slope(p1, p2, p0);
    let d3 = find_triangle_vertex_depth_slope(p2, p0, p1);

    d1.max(d2).max(d3)
}

/// `getFloatingPointMinimumResolvableDifference`
fn get_floating_point_minimum_resolvable_difference(max_z_value: f32, type_: ChannelType) -> f32 {
    assert_eq!(type_, ChannelType::FLOAT, "unexpected format");
    let max_exponent = crate::tcu::float::Float32::new(max_z_value).exponent();
    crate::tcu::float::Float32::construct(1, max_exponent - 23, 1 << 23).as_float()
}

/// `getFixedPointMinimumResolvableDifference`
fn get_fixed_point_minimum_resolvable_difference(num_bits: i32) -> f32 {
    crate::tcu::float::Float32::construct(1, -num_bits, 1 << 23).as_float()
}

/// `findPrimitiveMinimumResolvableDifference`
fn find_primitive_minimum_resolvable_difference(
    triangle: &pa::Triangle,
    arena: &[VertexPacket],
    depth_access: &PixelBufferAccess<'_>,
) -> f32 {
    let max_z = arena[triangle.v0]
        .position
        .z()
        .max(arena[triangle.v1].position.z())
        .max(arena[triangle.v2].position.z());
    let format = depth_access.format();

    match format.order {
        ChannelOrder::D => {
            let channel_class = format.type_.channel_class();
            let num_bits = crate::tcu::pixel::get_texture_format_bit_depth(format)[0];
            if channel_class == TextureChannelClass::FloatingPoint {
                get_floating_point_minimum_resolvable_difference(max_z, format.type_)
            } else {
                get_fixed_point_minimum_resolvable_difference(num_bits)
            }
        }
        ChannelOrder::DS => {
            if format.type_ == ChannelType::FLOAT_UNSIGNED_INT_24_8_REV {
                get_floating_point_minimum_resolvable_difference(max_z, ChannelType::FLOAT)
            } else if format.type_ == ChannelType::UNSIGNED_INT_24_8 {
                get_fixed_point_minimum_resolvable_difference(24)
            } else {
                panic!("unexpected depth/stencil format");
            }
        }
        _ => panic!("unexpected format"),
    }
}

/// `writeFragmentPackets`
#[allow(clippy::too_many_arguments)]
fn write_fragment_packets(
    state: &RenderState,
    render_target: &mut RenderTarget<'_>,
    program: &Program<'_>,
    fragment_packets: &[FragmentPacket],
    num_rasterized_packets: usize,
    num_samples: i32,
    facetype: FaceType,
    fragment_output_array: &[GenericVec4],
    fragment_output_array_src1: &[GenericVec4],
    depth_values: Option<&[f32]>,
    fragment_buffer: &mut [Fragment],
) {
    let num_outputs = program.fragment_shader.outputs().len();
    let mut frag_processor = FragmentProcessor::new();
    let num_samples_usize = num_samples as usize;

    // Translate fragments, but do not set the per-output value yet.
    {
        let mut frag_count = 0;
        for packet_ndx in 0..num_rasterized_packets {
            for frag_ndx in 0..4 {
                let packet = &fragment_packets[packet_ndx];
                let xo = frag_ndx % 2;
                let yo = frag_ndx / 2;

                if get_coverage_any_fragment_sample_live(packet.coverage, num_samples, xo, yo) {
                    let fragment = &mut fragment_buffer[frag_count];
                    frag_count += 1;

                    fragment.pixel_coord = [packet.position.x() + xo, packet.position.y() + yo];
                    fragment.coverage = ((packet.coverage & get_coverage_fragment_sample_bits(num_samples, xo, yo))
                        >> get_coverage_offset(num_samples, xo, yo)) as u32;
                    fragment.sample_depths = [0.0; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT];
                    if let Some(d) = depth_values {
                        let base = (packet_ndx * 4 + (yo * 2 + xo) as usize) * num_samples_usize;
                        fragment.sample_depths[..num_samples_usize].copy_from_slice(&d[base..base + num_samples_usize]);
                    }
                }
            }
        }
    }

    // Set the per-output value, one output (and one `FragmentProcessor::render` call)
    // at a time.
    {
        let mut no_stencil_depth_write_state = state.frag_ops;
        no_stencil_depth_write_state.depth_mask = false;
        no_stencil_depth_write_state.stencil_states[facetype as usize].s_fail = StencilOp::Keep;
        no_stencil_depth_write_state.stencil_states[facetype as usize].dp_fail = StencilOp::Keep;
        no_stencil_depth_write_state.stencil_states[facetype as usize].dp_pass = StencilOp::Keep;

        for output_ndx in 0..num_outputs {
            // Only the last output pass has the real state; the others write with
            // depth/stencil masked off.
            let frag_ops_state = if output_ndx == num_outputs - 1 {
                &state.frag_ops
            } else {
                &no_stencil_depth_write_state
            };

            let mut frag_count = 0;
            for packet_ndx in 0..num_rasterized_packets {
                for frag_ndx in 0..4usize {
                    let packet = &fragment_packets[packet_ndx];
                    let xo = (frag_ndx % 2) as i32;
                    let yo = (frag_ndx / 2) as i32;

                    if get_coverage_any_fragment_sample_live(packet.coverage, num_samples, xo, yo) {
                        let fragment = &mut fragment_buffer[frag_count];
                        frag_count += 1;

                        // Upstream: `fragment.value = fragmentOutputArray[...]` - a
                        // plain `GenericVec4` copy, no `.get<T>()` reinterpretation at
                        // this point. `raw_bits()` is that same copy; `Fragment::render`
                        // reinterprets as float/int32/uint32 only once it knows the
                        // colour buffer's real channel class (see that module's own doc
                        // comment on `Fragment` for why this stopped being `.get_float()`
                        // unconditionally).
                        fragment.value =
                            fragment_output_array[(packet_ndx * 4 + frag_ndx) * num_outputs + output_ndx].raw_bits();
                        fragment.value1 = fragment_output_array_src1
                            [(packet_ndx * 4 + frag_ndx) * num_outputs + output_ndx]
                            .raw_bits();
                    }
                }
            }

            let color_buffer = render_target.color_buffers[output_ndx]
                .as_mut()
                .expect("missing colour buffer for fragment output");
            frag_processor.render(
                color_buffer,
                render_target.depth_buffer.as_mut(),
                render_target.stencil_buffer.as_mut(),
                &fragment_buffer[..frag_count],
                facetype,
                frag_ops_state,
            );
        }
    }
}

/// `RasterizationInternalBuffers` - shared scratch space for one `rasterize()` call
/// (one primitive list), reused across every primitive in the list exactly like
/// upstream's `std::vector`s do.
struct RasterizationBuffers {
    fragment_packets: Vec<FragmentPacket>,
    shader_outputs: Vec<GenericVec4>,
    shader_outputs_src1: Vec<GenericVec4>,
    shaded_fragments: Vec<Fragment>,
    fragment_depth_buffer: Option<Vec<f32>>,
}

const MAX_FRAGMENT_PACKETS: usize = 128;

impl RasterizationBuffers {
    /// `num_samples` sizes `fragment_depth_buffer` - the rasterizer writes
    /// `num_samples` depth values per fragment (`(packet_ndx * 4 + frag_ndx) *
    /// num_samples + sample_ndx`, see `rr::rasterizer`/`rr::shading_context`'s own
    /// per-sample layout), so a single-sample-sized buffer would be a genuine
    /// out-of-bounds write the moment `num_samples > 1`.
    fn new(num_fragment_outputs: usize, has_depth_buffer: bool, num_samples: usize) -> Self {
        Self {
            fragment_packets: vec![
                FragmentPacket {
                    position: IVec2::new(0, 0),
                    coverage: 0,
                    barycentric: [Vec4::splat(0.0); 3],
                };
                MAX_FRAGMENT_PACKETS
            ],
            shader_outputs: vec![GenericVec4::zero(); MAX_FRAGMENT_PACKETS * 4 * num_fragment_outputs],
            shader_outputs_src1: vec![GenericVec4::zero(); MAX_FRAGMENT_PACKETS * 4 * num_fragment_outputs],
            shaded_fragments: vec![
                Fragment {
                    pixel_coord: [0, 0],
                    value: [0; 4],
                    value1: [0; 4],
                    coverage: 0,
                    sample_depths: [0.0; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT],
                };
                MAX_FRAGMENT_PACKETS * 4
            ],
            fragment_depth_buffer: if has_depth_buffer {
                Some(vec![0.0; MAX_FRAGMENT_PACKETS * 4 * num_samples])
            } else {
                None
            },
        }
    }

    fn depth_ptr_for_shading_context(&mut self) -> *mut f32 {
        self.fragment_depth_buffer
            .as_mut()
            .map(|v| v.as_mut_ptr())
            .unwrap_or(std::ptr::null_mut())
    }
}

/// `rasterizePrimitive(..., const pa::Triangle&, ...)`
#[allow(clippy::too_many_arguments)]
fn rasterize_triangle(
    state: &RenderState,
    render_target: &mut RenderTarget<'_>,
    program: &Program<'_>,
    triangle: &pa::Triangle,
    arena: &[VertexPacket],
    render_target_rect: IVec4,
    buffers: &mut RasterizationBuffers,
) {
    let num_samples = render_target.get_num_samples();
    let depth_clamp_min = state.viewport.zn.min(state.viewport.zf);
    let depth_clamp_max = state.viewport.zn.max(state.viewport.zf);
    let mut rasterizer = TriangleRasterizer::new(
        render_target_rect,
        num_samples,
        &state.rasterization,
        state.subpixel_bits,
    );

    let v0 = &arena[triangle.v0];
    let v1 = &arena[triangle.v1];
    let v2 = &arena[triangle.v2];
    rasterizer.init(v0.position, v1.position, v2.position);

    let visible_face = rasterizer.visible_face();
    if (state.cull_mode == CullMode::Front && visible_face == FaceType::Front)
        || (state.cull_mode == CullMode::Back && visible_face == FaceType::Back)
        || state.cull_mode == CullMode::FrontAndBack
    {
        return;
    }

    let num_fragment_outputs = program.fragment_shader.outputs().len() as i32;
    let mut depth_offset = 0.0f32;
    if buffers.fragment_depth_buffer.is_some() && state.frag_ops.polygon_offset_enabled {
        let max_slope = find_primitive_maximum_depth_slope(triangle, arena);
        let min_resolvable = find_primitive_minimum_resolvable_difference(
            triangle,
            arena,
            render_target
                .depth_buffer()
                .expect("polygon offset needs a depth buffer"),
        );
        depth_offset =
            max_slope * state.frag_ops.polygon_offset_factor + min_resolvable * state.frag_ops.polygon_offset_units;
    }

    let depth_ptr = buffers.depth_ptr_for_shading_context();
    let shading_context = FragmentShadingContext::new(
        v0.outputs.as_ptr(),
        v1.outputs.as_ptr(),
        v2.outputs.as_ptr(),
        buffers.shader_outputs.as_mut_ptr(),
        buffers.shader_outputs_src1.as_mut_ptr(),
        depth_ptr,
        v2.primitive_id,
        num_fragment_outputs,
        num_samples,
        visible_face,
    );

    loop {
        let max_fragment_packets = buffers.fragment_packets.len();
        let num_rasterized = rasterizer.rasterize(
            &mut buffers.fragment_packets,
            buffers.fragment_depth_buffer.as_deref_mut(),
            max_fragment_packets,
        );
        if num_rasterized == 0 {
            break;
        }

        if let Some(depth_buffer) = buffers.fragment_depth_buffer.as_deref_mut()
            && state.frag_ops.polygon_offset_enabled
        {
            for d in depth_buffer[..num_rasterized * 4 * num_samples as usize].iter_mut() {
                *d = (*d + depth_offset).clamp(0.0, 1.0);
            }
        }

        program
            .fragment_shader
            .shade_fragments(&mut buffers.fragment_packets[..num_rasterized], &shading_context);

        if let Some(depth_buffer) = buffers.fragment_depth_buffer.as_deref_mut()
            && state.frag_ops.depth_clamp_enabled
        {
            for d in depth_buffer[..num_rasterized * 4 * num_samples as usize].iter_mut() {
                *d = d.clamp(depth_clamp_min, depth_clamp_max);
            }
        }

        write_fragment_packets(
            state,
            render_target,
            program,
            &buffers.fragment_packets,
            num_rasterized,
            num_samples,
            visible_face,
            &buffers.shader_outputs,
            &buffers.shader_outputs_src1,
            buffers.fragment_depth_buffer.as_deref(),
            &mut buffers.shaded_fragments,
        );
    }
}

/// `rasterizePrimitive(..., const pa::Line&, ...)` - branches on `numSamples > 1` to
/// choose `MultiSampleLineRasterizer` over `SingleSampleLineRasterizer`, exactly like
/// upstream, now that `RenderTarget::get_num_samples` reports a real sample count (see
/// this module's top doc comment).
#[allow(clippy::too_many_arguments)]
fn rasterize_line(
    state: &RenderState,
    render_target: &mut RenderTarget<'_>,
    program: &Program<'_>,
    line: &pa::Line,
    arena: &[VertexPacket],
    render_target_rect: IVec4,
    buffers: &mut RasterizationBuffers,
) {
    let num_samples = render_target.get_num_samples();
    let msaa = num_samples > 1;
    let depth_clamp_min = state.viewport.zn.min(state.viewport.zf);
    let depth_clamp_max = state.viewport.zn.max(state.viewport.zf);

    let v0 = &arena[line.v0];
    let v1 = &arena[line.v1];

    let num_fragment_outputs = program.fragment_shader.outputs().len() as i32;
    let depth_ptr = buffers.depth_ptr_for_shading_context();
    let shading_context = FragmentShadingContext::new(
        v0.outputs.as_ptr(),
        v1.outputs.as_ptr(),
        std::ptr::null(),
        buffers.shader_outputs.as_mut_ptr(),
        buffers.shader_outputs_src1.as_mut_ptr(),
        depth_ptr,
        v1.primitive_id,
        num_fragment_outputs,
        num_samples,
        FaceType::Front,
    );

    let mut aliased_rasterizer = SingleSampleLineRasterizer::new(render_target_rect, state.subpixel_bits);
    let mut msaa_rasterizer = MultiSampleLineRasterizer::new(num_samples, render_target_rect, state.subpixel_bits);
    if msaa {
        msaa_rasterizer.init(v0.position, v1.position, state.line.line_width);
    } else {
        aliased_rasterizer.init(v0.position, v1.position, state.line.line_width, 1, 0xFFFF);
    }

    loop {
        let max_fragment_packets = buffers.fragment_packets.len();
        let num_rasterized = if msaa {
            msaa_rasterizer.rasterize(
                &mut buffers.fragment_packets,
                buffers.fragment_depth_buffer.as_deref_mut(),
                max_fragment_packets,
            )
        } else {
            aliased_rasterizer.rasterize(
                &mut buffers.fragment_packets,
                buffers.fragment_depth_buffer.as_deref_mut(),
                max_fragment_packets,
            )
        };
        if num_rasterized == 0 {
            break;
        }

        program
            .fragment_shader
            .shade_fragments(&mut buffers.fragment_packets[..num_rasterized], &shading_context);

        if let Some(depth_buffer) = buffers.fragment_depth_buffer.as_deref_mut()
            && state.frag_ops.depth_clamp_enabled
        {
            for d in depth_buffer[..num_rasterized * 4 * num_samples as usize].iter_mut() {
                *d = d.clamp(depth_clamp_min, depth_clamp_max);
            }
        }

        write_fragment_packets(
            state,
            render_target,
            program,
            &buffers.fragment_packets,
            num_rasterized,
            num_samples,
            FaceType::Front,
            &buffers.shader_outputs,
            &buffers.shader_outputs_src1,
            buffers.fragment_depth_buffer.as_deref(),
            &mut buffers.shaded_fragments,
        );
    }
}

/// `rasterizePrimitive(..., const pa::Point&, ...)` - a point is drawn as two
/// triangles over its `pointSize` square, exactly like upstream.
#[allow(clippy::too_many_arguments)]
fn rasterize_point(
    state: &RenderState,
    render_target: &mut RenderTarget<'_>,
    program: &Program<'_>,
    point: &pa::Point,
    arena: &[VertexPacket],
    render_target_rect: IVec4,
    buffers: &mut RasterizationBuffers,
) {
    let num_samples = render_target.get_num_samples();
    let depth_clamp_min = state.viewport.zn.min(state.viewport.zf);
    let depth_clamp_max = state.viewport.zn.max(state.viewport.zf);

    let v0 = &arena[point.v0];
    let offset = v0.point_size / 2.0;
    let p = v0.position;
    let w0 = Vec4::new(p.x() + offset, p.y() + offset, p.z(), p.w());
    let w1 = Vec4::new(p.x() - offset, p.y() + offset, p.z(), p.w());
    let w2 = Vec4::new(p.x() - offset, p.y() - offset, p.z(), p.w());
    let w3 = Vec4::new(p.x() + offset, p.y() - offset, p.z(), p.w());

    let mut rasterizer1 = TriangleRasterizer::new(
        render_target_rect,
        num_samples,
        &state.rasterization,
        state.subpixel_bits,
    );
    let mut rasterizer2 = TriangleRasterizer::new(
        render_target_rect,
        num_samples,
        &state.rasterization,
        state.subpixel_bits,
    );
    rasterizer1.init(w0, w1, w2);
    rasterizer2.init(w0, w2, w3);

    let num_fragment_outputs = program.fragment_shader.outputs().len() as i32;
    let depth_ptr = buffers.depth_ptr_for_shading_context();
    let shading_context = FragmentShadingContext::new(
        v0.outputs.as_ptr(),
        std::ptr::null(),
        std::ptr::null(),
        buffers.shader_outputs.as_mut_ptr(),
        buffers.shader_outputs_src1.as_mut_ptr(),
        depth_ptr,
        v0.primitive_id,
        num_fragment_outputs,
        num_samples,
        FaceType::Front,
    );

    loop {
        let max_fragment_packets = buffers.fragment_packets.len();
        let mut num_rasterized = {
            let (packets1, _) = buffers.fragment_packets.split_at_mut(max_fragment_packets);
            rasterizer1.rasterize(
                packets1,
                buffers.fragment_depth_buffer.as_deref_mut(),
                max_fragment_packets,
            )
        };

        if num_rasterized != max_fragment_packets {
            let depth_append = buffers
                .fragment_depth_buffer
                .as_deref_mut()
                .map(|d| &mut d[num_rasterized * num_samples as usize * 4..]);
            let (_, packets2) = buffers.fragment_packets.split_at_mut(num_rasterized);
            let num_rasterized2 = rasterizer2.rasterize(packets2, depth_append, max_fragment_packets - num_rasterized);
            num_rasterized += num_rasterized2;
        }

        if num_rasterized == 0 {
            break;
        }

        program
            .fragment_shader
            .shade_fragments(&mut buffers.fragment_packets[..num_rasterized], &shading_context);

        if let Some(depth_buffer) = buffers.fragment_depth_buffer.as_deref_mut()
            && state.frag_ops.depth_clamp_enabled
        {
            for d in depth_buffer[..num_rasterized * 4 * num_samples as usize].iter_mut() {
                *d = d.clamp(depth_clamp_min, depth_clamp_max);
            }
        }

        write_fragment_packets(
            state,
            render_target,
            program,
            &buffers.fragment_packets,
            num_rasterized,
            num_samples,
            FaceType::Front,
            &buffers.shader_outputs,
            &buffers.shader_outputs_src1,
            buffers.fragment_depth_buffer.as_deref(),
            &mut buffers.shaded_fragments,
        );

        // Both triangles' quota for this round is exhausted only if the first one
        // alone filled the whole buffer; otherwise everything fit in one round.
        if num_rasterized < max_fragment_packets {
            break;
        }
    }
}

/// `rasterize<ContainerType>`
fn rasterize(
    state: &RenderState,
    render_target: &mut RenderTarget<'_>,
    program: &Program<'_>,
    list: &BasePrimitiveList,
    arena: &[VertexPacket],
) {
    let num_fragment_outputs = program.fragment_shader.outputs().len();
    let num_samples = render_target.get_num_samples();
    let viewport_rect = IVec4::new(
        state.viewport.rect.left,
        state.viewport.rect.bottom,
        state.viewport.rect.width,
        state.viewport.rect.height,
    );
    let buffer_rect = get_buffer_size(render_target.color_buffer(0));
    let render_target_rect = rect_intersection(viewport_rect, buffer_rect);

    let has_depth_buffer = render_target
        .depth_buffer()
        .map(|d| d.size().iter().all(|&s| s != 0))
        .unwrap_or(false);
    let mut buffers = RasterizationBuffers::new(num_fragment_outputs, has_depth_buffer, num_samples as usize);

    match list {
        BasePrimitiveList::Triangles(tris) => {
            for t in tris {
                rasterize_triangle(
                    state,
                    render_target,
                    program,
                    t,
                    arena,
                    render_target_rect,
                    &mut buffers,
                );
            }
        }
        BasePrimitiveList::Lines(lines) => {
            for l in lines {
                rasterize_line(
                    state,
                    render_target,
                    program,
                    l,
                    arena,
                    render_target_rect,
                    &mut buffers,
                );
            }
        }
        BasePrimitiveList::Points(points) => {
            for p in points {
                rasterize_point(
                    state,
                    render_target,
                    program,
                    p,
                    arena,
                    render_target_rect,
                    &mut buffers,
                );
            }
        }
    }
}

/// `drawBasicPrimitives<ContainerType>`
fn draw_basic_primitives(
    state: &RenderState,
    render_target: &mut RenderTarget<'_>,
    program: &Program<'_>,
    prim_list: &mut BasePrimitiveList,
    arena: &mut Vec<VertexPacket>,
    vpalloc: &mut VertexPacketAllocator,
) {
    let clip_z = !state.frag_ops.depth_clamp_enabled;
    let frag_inputs = program.vertex_shader.outputs();

    clip::flatshade_vertices(frag_inputs, prim_list, arena);
    clip::clip_primitives(prim_list, frag_inputs, clip_z, arena, vpalloc);
    clip::transform_clip_coords_to_window_coords(
        &state.viewport.rect,
        state.viewport.zn,
        state.viewport.zf,
        prim_list,
        arena,
    );
    rasterize(state, render_target, program, prim_list, arena);
}

/// Upstream's `copyVertexPacketPointers` overload set, fused with "which assembled
/// shape does a geometry-shader input type need" into one enum - see
/// `rr::primitive_types`'s own doc comment for why a runtime `match` replaces
/// upstream's compile-time `PrimitiveTypeTraits<T>` dispatch throughout this file.
enum GsInputPrimitives {
    Points(Vec<pa::Point>),
    Lines(Vec<pa::Line>),
    Triangles(Vec<pa::Triangle>),
    LinesAdjacency(Vec<pa::LineAdjacency>),
    TrianglesAdjacency(Vec<pa::TriangleAdjacency>),
}

impl GsInputPrimitives {
    /// Assembles a draw call's vertex indices into the shape its own `PrimitiveType`
    /// implies, *without* converting adjacency primitives down to their base type -
    /// unlike the non-geometry-shader path, a geometry shader with
    /// `GEOMETRYSHADERINPUTTYPE_LINES_ADJACENCY`/`_TRIANGLES_ADJACENCY` needs the
    /// adjacency vertices too (`is_valid_command` is what rejects an incompatible
    /// pairing, e.g. a `Points` geometry shader fed `GL_TRIANGLES`).
    fn assemble(primitive_type: PrimitiveType, vertex_indices: &[usize], provoking: ProvokingVertex) -> Self {
        match primitive_type {
            PrimitiveType::Triangles => {
                let mut out = Vec::new();
                pa::assemble_triangles(&mut out, vertex_indices, provoking);
                GsInputPrimitives::Triangles(out)
            }
            PrimitiveType::TriangleStrip => {
                let mut out = Vec::new();
                pa::assemble_triangle_strip(&mut out, vertex_indices, provoking);
                GsInputPrimitives::Triangles(out)
            }
            PrimitiveType::TriangleFan => {
                let mut out = Vec::new();
                pa::assemble_triangle_fan(&mut out, vertex_indices, provoking);
                GsInputPrimitives::Triangles(out)
            }
            PrimitiveType::Lines => {
                let mut out = Vec::new();
                pa::assemble_lines(&mut out, vertex_indices, provoking);
                GsInputPrimitives::Lines(out)
            }
            PrimitiveType::LineStrip => {
                let mut out = Vec::new();
                pa::assemble_line_strip(&mut out, vertex_indices, provoking);
                GsInputPrimitives::Lines(out)
            }
            PrimitiveType::LineLoop => {
                let mut out = Vec::new();
                pa::assemble_line_loop(&mut out, vertex_indices, provoking);
                GsInputPrimitives::Lines(out)
            }
            PrimitiveType::Points => {
                let mut out = Vec::new();
                pa::assemble_points(&mut out, vertex_indices, provoking);
                GsInputPrimitives::Points(out)
            }
            PrimitiveType::LinesAdjacency => {
                let mut out = Vec::new();
                pa::assemble_lines_adjacency(&mut out, vertex_indices, provoking);
                GsInputPrimitives::LinesAdjacency(out)
            }
            PrimitiveType::LineStripAdjacency => {
                let mut out = Vec::new();
                pa::assemble_line_strip_adjacency(&mut out, vertex_indices, provoking);
                GsInputPrimitives::LinesAdjacency(out)
            }
            PrimitiveType::TrianglesAdjacency => {
                let mut out = Vec::new();
                pa::assemble_triangles_adjacency(&mut out, vertex_indices, provoking);
                GsInputPrimitives::TrianglesAdjacency(out)
            }
            PrimitiveType::TriangleStripAdjacency => {
                let mut out = Vec::new();
                pa::assemble_triangle_strip_adjacency(&mut out, vertex_indices, provoking);
                GsInputPrimitives::TrianglesAdjacency(out)
            }
        }
    }

    /// `PrimitiveTypeTraits<DrawPrimitiveType>::Type::NUM_VERTICES` - the vertex count a
    /// geometry shader's `shadePrimitives` receives per input primitive.
    fn num_vertices_in(&self) -> i32 {
        match self {
            GsInputPrimitives::Points(_) => 1,
            GsInputPrimitives::Lines(_) => 2,
            GsInputPrimitives::Triangles(_) => 3,
            GsInputPrimitives::LinesAdjacency(_) => 4,
            GsInputPrimitives::TrianglesAdjacency(_) => 6,
        }
    }

    /// `copyVertexPacketPointers` - builds the `PrimitivePacket` list `shadePrimitives`
    /// reads, `primitiveIDIn` assigned by the caller afterwards (matching
    /// `drawContext.primitiveID++` running right before upstream's call into
    /// `copyVertexPacketPointers`, in the same loop).
    fn to_primitive_packets(&self) -> Vec<PrimitivePacket> {
        fn pack(vertices: [Option<usize>; 6]) -> PrimitivePacket {
            PrimitivePacket {
                primitive_id_in: 0,
                vertices,
            }
        }
        match self {
            GsInputPrimitives::Points(ps) => ps
                .iter()
                .map(|p| pack([Some(p.v0), None, None, None, None, None]))
                .collect(),
            GsInputPrimitives::Lines(ls) => ls
                .iter()
                .map(|l| pack([Some(l.v0), Some(l.v1), None, None, None, None]))
                .collect(),
            GsInputPrimitives::Triangles(ts) => ts
                .iter()
                .map(|t| pack([Some(t.v0), Some(t.v1), Some(t.v2), None, None, None]))
                .collect(),
            GsInputPrimitives::LinesAdjacency(ls) => ls
                .iter()
                .map(|l| pack([Some(l.v0), Some(l.v1), Some(l.v2), Some(l.v3), None, None]))
                .collect(),
            GsInputPrimitives::TrianglesAdjacency(ts) => ts
                .iter()
                .map(|t| pack([Some(t.v0), Some(t.v1), Some(t.v2), Some(t.v3), Some(t.v4), Some(t.v5)]))
                .collect(),
        }
    }
}

/// `drawGeometryShaderOutputAsPrimitives<DrawPrimitiveType>` - assembles one contiguous
/// run of vertices a geometry shader invocation emitted (already drained out of the
/// `None`-separated `GeometryEmitter` output by the caller) as `output_type`'s own basic
/// primitive type, then draws it exactly like the non-geometry-shader path does.
/// `output_type` is always one of the three *basic* shapes (points/line strip/triangle
/// strip - never adjacency), so this calls the plain assemblers directly rather than
/// going through `GsInputPrimitives::assemble`.
fn draw_geometry_shader_output_as_primitives(
    state: &RenderState,
    render_target: &mut RenderTarget<'_>,
    program: &Program<'_>,
    output_type: GeometryShaderOutputType,
    gs_arena: &mut Vec<VertexPacket>,
    provoking: ProvokingVertex,
    vpalloc: &mut VertexPacketAllocator,
) {
    let local_indices: Vec<usize> = (0..gs_arena.len()).collect();
    let mut prim_list = match output_type {
        GeometryShaderOutputType::Points => {
            let mut out = Vec::new();
            pa::assemble_points(&mut out, &local_indices, provoking);
            BasePrimitiveList::Points(out)
        }
        GeometryShaderOutputType::LineStrip => {
            let mut out = Vec::new();
            pa::assemble_line_strip(&mut out, &local_indices, provoking);
            BasePrimitiveList::Lines(out)
        }
        GeometryShaderOutputType::TriangleStrip => {
            let mut out = Vec::new();
            pa::assemble_triangle_strip(&mut out, &local_indices, provoking);
            BasePrimitiveList::Triangles(out)
        }
    };

    // Make shared vertices distinct - same reason the non-geometry-shader path does
    // this (one window-space transform per vertex, correct flatshading). Uses the same
    // `vpalloc` `draw_with_geometry_shader` built `gs_arena`'s own packets from (see
    // that function's own comment) - not the draw call's vertex-shading one, which has
    // a different `num_outputs` - so a duplicate pulled here is sized correctly and
    // recyclable the same way.
    clip::make_shared_vertices_distinct(&mut prim_list, gs_arena, vpalloc);
    draw_basic_primitives(state, render_target, program, &mut prim_list, gs_arena, vpalloc);
}

/// `drawWithGeometryShader<DrawPrimitiveType>` - runs `geometry_shader` over every
/// assembled input primitive, once per invocation, then draws whatever each invocation
/// emits. `input_arena` is the vertex-shaded arena `draw_as_primitives` already built;
/// it is read-only here (nothing about geometry shading mutates a vertex the way
/// clipping does), which is why it is `&[VertexPacket]` rather than the `&mut Vec<_>`
/// the rest of this file threads through.
#[allow(clippy::too_many_arguments)]
fn draw_with_geometry_shader(
    state: &RenderState,
    render_target: &mut RenderTarget<'_>,
    program: &Program<'_>,
    geometry_shader: &dyn GeometryShader,
    input: GsInputPrimitives,
    input_arena: &[VertexPacket],
    next_primitive_id: &mut i32,
    provoking: ProvokingVertex,
) {
    let vertices_in = input.num_vertices_in();
    let mut packets = input.to_primitive_packets();
    if packets.is_empty() {
        return;
    }

    for packet in packets.iter_mut() {
        packet.primitive_id_in = *next_primitive_id;
        *next_primitive_id += 1;
    }

    let num_gs_outputs = geometry_shader.outputs().len();
    let num_invocations = geometry_shader.num_invocations();

    // "Vertices outputted by geometry shader may have different number of output
    // variables than the original, create new memory allocator" - upstream's own
    // comment on this exact allocator. One per call, shared across every invocation
    // below (and, via `release`, recycled between them), never the vertex-shading
    // arena's own allocator.
    let mut vpalloc = VertexPacketAllocator::new(num_gs_outputs);

    for invocation_ndx in 0..num_invocations {
        let mut emitter = GeometryEmitter::new(&mut vpalloc, geometry_shader.num_vertices_out());
        geometry_shader.shade_primitives(&mut emitter, vertices_in, &packets, invocation_ndx as i32, input_arena);

        let mut emitted: Vec<Option<VertexPacket>> = Vec::new();
        emitter.move_emitted_to(&mut emitted);

        // Find primitive runs in the emitted vertices - `None` entries mark
        // `EndPrimitive()`, matching upstream's null-`VertexPacket*` markers.
        let mut primitive_begin = 0usize;
        while primitive_begin < emitted.len() {
            if emitted[primitive_begin].is_none() {
                primitive_begin += 1;
                continue;
            }

            let mut primitive_end = primitive_begin + 1;
            while primitive_end < emitted.len() && emitted[primitive_end].is_some() {
                primitive_end += 1;
            }

            let mut gs_arena: Vec<VertexPacket> = emitted[primitive_begin..primitive_end]
                .iter()
                .map(|v| v.clone().expect("run is all Some by construction"))
                .collect();
            draw_geometry_shader_output_as_primitives(
                state,
                render_target,
                program,
                geometry_shader.output_type(),
                &mut gs_arena,
                provoking,
                &mut vpalloc,
            );
            // Not upstream (see the comment on the `emitted` release below) - `gs_arena`
            // was about to be dropped here anyway, and by now may hold more than its
            // original clones (`make_shared_vertices_distinct`'s own duplicates, plus
            // whatever clipping's subdivision pushed onto it), so handing the whole
            // thing back recycles all of it rather than only the two sources released
            // elsewhere in this function.
            vpalloc.release(gs_arena);

            primitive_begin = primitive_end + 1;
        }

        // Not upstream (its arena only ever frees itself whole, at the end of the
        // enclosing `drawWithGeometryShader` call) - `gs_arena` above already cloned
        // every packet it needed, so `emitted`'s own copies are free to recycle for the
        // *next* invocation's `emit_vertex` calls instead of just dropping here.
        vpalloc.release(emitted.into_iter().flatten().collect());
    }
}

/// `drawAsPrimitives<DrawPrimitiveType>` - assembly and the base-type conversion are
/// fused into one dispatch since Rust's `match` replaces the `PrimitiveTypeTraits<T>`
/// compile-time lookup upstream uses (see `rr::primitive_types`'s own doc comment).
#[allow(clippy::too_many_arguments)]
fn draw_as_primitives(
    state: &RenderState,
    render_target: &mut RenderTarget<'_>,
    program: &Program<'_>,
    vertex_indices: &[usize],
    next_primitive_id: &mut i32,
    arena: &mut Vec<VertexPacket>,
    primitive_type: PrimitiveType,
    provoking: ProvokingVertex,
    vpalloc: &mut VertexPacketAllocator,
) {
    if let Some(geometry_shader) = program.geometry_shader {
        let input = GsInputPrimitives::assemble(primitive_type, vertex_indices, provoking);
        draw_with_geometry_shader(
            state,
            render_target,
            program,
            geometry_shader,
            input,
            arena,
            next_primitive_id,
            provoking,
        );
        return;
    }

    let mut prim_list = match primitive_type {
        PrimitiveType::Triangles => {
            let mut out = Vec::new();
            pa::assemble_triangles(&mut out, vertex_indices, provoking);
            BasePrimitiveList::Triangles(out)
        }
        PrimitiveType::TriangleStrip => {
            let mut out = Vec::new();
            pa::assemble_triangle_strip(&mut out, vertex_indices, provoking);
            BasePrimitiveList::Triangles(out)
        }
        PrimitiveType::TriangleFan => {
            let mut out = Vec::new();
            pa::assemble_triangle_fan(&mut out, vertex_indices, provoking);
            BasePrimitiveList::Triangles(out)
        }
        PrimitiveType::Lines => {
            let mut out = Vec::new();
            pa::assemble_lines(&mut out, vertex_indices, provoking);
            BasePrimitiveList::Lines(out)
        }
        PrimitiveType::LineStrip => {
            let mut out = Vec::new();
            pa::assemble_line_strip(&mut out, vertex_indices, provoking);
            BasePrimitiveList::Lines(out)
        }
        PrimitiveType::LineLoop => {
            let mut out = Vec::new();
            pa::assemble_line_loop(&mut out, vertex_indices, provoking);
            BasePrimitiveList::Lines(out)
        }
        PrimitiveType::Points => {
            let mut out = Vec::new();
            pa::assemble_points(&mut out, vertex_indices, provoking);
            BasePrimitiveList::Points(out)
        }
        PrimitiveType::LinesAdjacency => {
            let mut adj = Vec::new();
            pa::assemble_lines_adjacency(&mut adj, vertex_indices, provoking);
            BasePrimitiveList::Lines(clip::line_adjacency_to_base(&adj))
        }
        PrimitiveType::LineStripAdjacency => {
            let mut adj = Vec::new();
            pa::assemble_line_strip_adjacency(&mut adj, vertex_indices, provoking);
            BasePrimitiveList::Lines(clip::line_adjacency_to_base(&adj))
        }
        PrimitiveType::TrianglesAdjacency => {
            let mut adj = Vec::new();
            pa::assemble_triangles_adjacency(&mut adj, vertex_indices, provoking);
            BasePrimitiveList::Triangles(clip::triangle_adjacency_to_base(&adj))
        }
        PrimitiveType::TriangleStripAdjacency => {
            let mut adj = Vec::new();
            pa::assemble_triangle_strip_adjacency(&mut adj, vertex_indices, provoking);
            BasePrimitiveList::Triangles(clip::triangle_adjacency_to_base(&adj))
        }
    };

    // Make shared vertices distinct - needed so the translation to window space
    // happens only once per vertex, and for flatshading.
    clip::make_shared_vertices_distinct(&mut prim_list, arena, vpalloc);

    // A primitive ID is generated even with no geometry shader active.
    clip::generate_primitive_ids(&mut prim_list, next_primitive_id, arena);

    draw_basic_primitives(state, render_target, program, &mut prim_list, arena, vpalloc);
}

/// `isValidCommand` - see this module's top doc comment for what is deliberately not
/// re-checked here.
fn is_valid_command(command: &DrawCommand<'_>, render_target: &RenderTarget<'_>, num_instances: i32) -> bool {
    if num_instances < 0 {
        return false;
    }

    // Shaders should have the same varyings.
    if let Some(geometry_shader) = command.program.geometry_shader {
        if command.program.vertex_shader.outputs() != geometry_shader.inputs() {
            return false;
        }
        if geometry_shader.outputs() != command.program.fragment_shader.inputs() {
            return false;
        }
    } else if command.program.vertex_shader.outputs() != command.program.fragment_shader.inputs() {
        return false;
    }

    let valid_generic_type = |t: Option<super::generic_vector::GenericVecType>| {
        matches!(
            t,
            Some(
                super::generic_vector::GenericVecType::Float
                    | super::generic_vector::GenericVecType::Int32
                    | super::generic_vector::GenericVecType::Uint32
            )
        )
    };

    if command
        .program
        .vertex_shader
        .inputs()
        .iter()
        .any(|i| !valid_generic_type(i.type_))
    {
        return false;
    }
    if command
        .program
        .vertex_shader
        .outputs()
        .iter()
        .any(|o| !valid_generic_type(o.type_))
    {
        return false;
    }
    if command
        .program
        .fragment_shader
        .inputs()
        .iter()
        .any(|i| !valid_generic_type(i.type_))
    {
        return false;
    }
    if command
        .program
        .fragment_shader
        .outputs()
        .iter()
        .any(|o| !valid_generic_type(o.type_))
    {
        return false;
    }
    if let Some(geometry_shader) = command.program.geometry_shader {
        if geometry_shader.inputs().iter().any(|i| !valid_generic_type(i.type_)) {
            return false;
        }
        if geometry_shader.outputs().iter().any(|o| !valid_generic_type(o.type_)) {
            return false;
        }
    }

    if command.vertex_attribs.len() < command.program.vertex_shader.inputs().len() {
        return false;
    }

    if render_target.get_num_color_buffers() < command.program.fragment_shader.outputs().len() {
        return false;
    }

    // All destination buffers should have the same number of samples and the same
    // size - currently a no-op in practice (`render_target.get_num_color_buffers()`
    // is always 1, since `RenderTarget::new` only ever fills colour-buffer slot 0, see
    // its own doc comment), ported verbatim anyway to match upstream's exact shape and
    // because it activates correctly, with zero further change needed here, the moment
    // (if ever) a caller constructs a `RenderTarget` with more than one colour buffer.
    for output_ndx in 0..render_target.get_num_color_buffers() {
        if get_buffer_size(render_target.color_buffer(0)) != get_buffer_size(render_target.color_buffer(output_ndx)) {
            return false;
        }
        if render_target.get_num_samples() != render_target.color_buffer(output_ndx).size()[0] as i32 {
            return false;
        }
    }

    // Destination buffer basic type must match the matching fragment-shader output's
    // declared type (`getTextureChannelClass` of the colour buffer's own format against
    // `GenericVecType`). Indexing `color_buffer(varying_ndx)` is in range here: the check
    // just above already requires `num_color_buffers >= fragment_shader.outputs().len()`.
    for (varying_ndx, output) in command.program.fragment_shader.outputs().iter().enumerate() {
        let colorbuffer_class = render_target.color_buffer(varying_ndx).format().channel_class();
        let color_type = match colorbuffer_class {
            TextureChannelClass::SignedInteger => super::generic_vector::GenericVecType::Int32,
            TextureChannelClass::UnsignedInteger => super::generic_vector::GenericVecType::Uint32,
            _ => super::generic_vector::GenericVecType::Float,
        };
        if output.type_ != Some(color_type) {
            return false;
        }
    }

    // Integer varyings must be flatshaded.
    if command.program.vertex_shader.outputs().iter().any(|o| {
        !o.flatshade
            && matches!(
                o.type_,
                Some(super::generic_vector::GenericVecType::Int32 | super::generic_vector::GenericVecType::Uint32)
            )
    }) {
        return false;
    }
    if let Some(geometry_shader) = command.program.geometry_shader
        && geometry_shader.outputs().iter().any(|o| {
            !o.flatshade
                && matches!(
                    o.type_,
                    Some(super::generic_vector::GenericVecType::Int32 | super::generic_vector::GenericVecType::Uint32)
                )
        })
    {
        return false;
    }

    // Draw primitive is valid for the geometry shader's declared input type.
    if let Some(geometry_shader) = command.program.geometry_shader {
        let primitive_type = command.primitives.primitive_type();
        let compatible = match geometry_shader.input_type() {
            GeometryShaderInputType::Points => primitive_type == PrimitiveType::Points,
            GeometryShaderInputType::Lines => matches!(
                primitive_type,
                PrimitiveType::Lines | PrimitiveType::LineStrip | PrimitiveType::LineLoop
            ),
            GeometryShaderInputType::Triangles => matches!(
                primitive_type,
                PrimitiveType::Triangles | PrimitiveType::TriangleStrip | PrimitiveType::TriangleFan
            ),
            GeometryShaderInputType::LinesAdjacency => matches!(
                primitive_type,
                PrimitiveType::LinesAdjacency | PrimitiveType::LineStripAdjacency
            ),
            GeometryShaderInputType::TrianglesAdjacency => matches!(
                primitive_type,
                PrimitiveType::TrianglesAdjacency | PrimitiveType::TriangleStripAdjacency
            ),
        };
        if !compatible {
            return false;
        }
    }

    true
}

/// `rr::Renderer`
pub struct Renderer;

impl Renderer {
    pub fn new() -> Self {
        Self
    }

    /// `Renderer::draw`
    pub fn draw(&self, command: &DrawCommand<'_>, render_target: &mut RenderTarget<'_>) {
        self.draw_instanced(command, render_target, 1);
    }

    /// `Renderer::drawInstanced`
    pub fn draw_instanced(&self, command: &DrawCommand<'_>, render_target: &mut RenderTarget<'_>, num_instances: i32) {
        if !is_valid_command(command, render_target, num_instances) {
            debug_assert!(false, "invalid draw command");
            return;
        }

        if command.primitives.num_elements() == 0 || num_instances == 0 {
            return;
        }

        let num_varyings = command.program.vertex_shader.outputs().len();
        let mut next_primitive_id;
        let provoking = command
            .state
            .provoking_vertex_convention
            .unwrap_or(ProvokingVertex::Last);

        // Upstream declares exactly one `VertexPacketAllocator vpalloc(numVaryings)` per
        // `drawInstanced` call and reuses the same backing storage for every restart
        // segment of every instance (`vertexPackets[numVertexPackets]->...` overwrites
        // fields of a single array sized once to `command.primitives.getNumElements()`,
        // never reallocating inside the loop below). The earlier version of this
        // function instead called `VertexPacket::new` fresh per segment-per-instance via
        // `.map(...).collect()`, which reallocates every `outputs` buffer on every single
        // restart segment of every single instance - the exact repeated-allocation shape
        // `VertexPacketAllocator` exists to avoid, just scoped one level narrower (within
        // one `draw_instanced` call) than this file's own `vertex_packet.rs` doc comment
        // first framed it ("across draw calls"): upstream's own `vpalloc` is itself local
        // to `drawInstanced`, never shared across separate `Renderer::draw` calls either
        // (confirmed by reading `sglrReferenceContext.cpp`'s draw call site, which
        // constructs a fresh `const rr::Renderer` per `glDrawArrays`/`glDrawElements`).
        let mut vpalloc = VertexPacketAllocator::new(num_varyings);

        for instance_id in 0..num_instances {
            next_primitive_id = 0;

            let mut element_ndx = 0usize;
            while element_ndx < command.primitives.num_elements() {
                // Collect primitive vertices until restart.
                let mut vertex_indices_in_segment = Vec::new();
                while element_ndx < command.primitives.num_elements()
                    && !(command.state.restart.enabled
                        && command
                            .primitives
                            .is_restart_index(element_ndx, command.state.restart.restart_index))
                {
                    vertex_indices_in_segment.push(command.primitives.get_index(element_ndx));
                    element_ndx += 1;
                }

                if vertex_indices_in_segment.is_empty() {
                    element_ndx += 1; // skip the duplicated restart index
                    continue;
                }

                let mut arena: Vec<VertexPacket> = vpalloc.alloc_array(vertex_indices_in_segment.len());
                for (packet, &vertex_ndx) in arena.iter_mut().zip(vertex_indices_in_segment.iter()) {
                    packet.instance_ndx = instance_id;
                    packet.vertex_ndx = vertex_ndx as i32;
                    packet.point_size = command.state.point.point_size;
                    packet.position = Vec4::new(0.0, 0.0, 0.0, 0.0);
                }

                command
                    .program
                    .vertex_shader
                    .shade_vertices(command.vertex_attribs, &mut arena);

                let local_indices: Vec<usize> = (0..arena.len()).collect();

                draw_as_primitives(
                    command.state,
                    render_target,
                    command.program,
                    &local_indices,
                    &mut next_primitive_id,
                    &mut arena,
                    command.primitives.primitive_type(),
                    provoking,
                    &mut vpalloc,
                );

                // Not upstream (its one-shot arena is only ever freed whole, at the end
                // of the enclosing `drawInstanced`) - hands this segment's packets back
                // to the pool, including any extra ones clipping pushed onto `arena`
                // beyond the original segment length, so the next segment's `alloc_array`
                // recycles their `outputs` buffers instead of reallocating.
                vpalloc.release(arena);
            }
        }
    }
}

impl Default for Renderer {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::rr::generic_vector::GenericVecType;
    use crate::rr::render_state::{PointState, RestartState, ViewportOrientation, ViewportState, WindowRectangle};
    use crate::rr::shaders::{
        FragmentInputInfo, FragmentOutputInfo, GeometryInputInfo, GeometryOutputInfo, VertexInputInfo, VertexOutputInfo,
    };
    use crate::rr::shading_context::write_fragment_output;
    use crate::rr::vertex_attrib::{VertexAttribType, read_vertex_attrib_float};
    use crate::tcu::texture::{ChannelOrder, ChannelType};
    use crate::tcu::vector::UVec4;

    /// A vertex shader that reads attribute 0 as `position` (`float`, size 4) and
    /// copies it straight through - no transform at all, so the caller supplies
    /// already-clip-space coordinates.
    struct PassthroughVertexShader {
        inputs: Vec<VertexInputInfo>,
        outputs: Vec<VertexOutputInfo>,
    }

    impl PassthroughVertexShader {
        fn new() -> Self {
            Self {
                inputs: vec![VertexInputInfo {
                    type_: Some(GenericVecType::Float),
                }],
                outputs: vec![],
            }
        }
    }

    impl VertexShader for PassthroughVertexShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            &self.inputs
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            &self.outputs
        }
        fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
            for packet in packets.iter_mut() {
                let mut position = Vec4::splat(0.0);
                unsafe {
                    read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0)
                };
                packet.position = position;
            }
        }
    }

    /// A vertex shader that reads attribute 0 as `position` (per-vertex, `float`, size
    /// 4) the same way `PassthroughVertexShader` does, and adds attribute 1's `x`
    /// component (a per-*instance* `float`, divisor 1) to `position.x` - the minimal
    /// shape that lets a single draw call's vertex shading observe both
    /// `packet.vertex_ndx` (which attribute-0 row to read) and `packet.instance_ndx`
    /// (which attribute-1 row to read) at once, for
    /// `draw_instanced_with_restart_segments_renders_every_segment_of_every_instance_correctly`
    /// below.
    struct InstancedOffsetVertexShader {
        inputs: Vec<VertexInputInfo>,
        outputs: Vec<VertexOutputInfo>,
    }

    impl InstancedOffsetVertexShader {
        fn new() -> Self {
            Self {
                inputs: vec![
                    VertexInputInfo {
                        type_: Some(GenericVecType::Float),
                    },
                    VertexInputInfo {
                        type_: Some(GenericVecType::Float),
                    },
                ],
                outputs: vec![],
            }
        }
    }

    impl VertexShader for InstancedOffsetVertexShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            &self.inputs
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            &self.outputs
        }
        fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
            for packet in packets.iter_mut() {
                let mut position = Vec4::splat(0.0);
                unsafe {
                    read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0)
                };
                let mut offset = Vec4::splat(0.0);
                unsafe { read_vertex_attrib_float(&mut offset, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0) };
                packet.position = Vec4::new(position.x() + offset.x(), position.y(), position.z(), position.w());
            }
        }
    }

    /// A fragment shader that writes one constant colour to output 0, every fragment.
    ///
    /// `new_with_output_type`'s `color` components are converted to the declared
    /// `GenericVecType` at construction time (`as i32`/`as u32` for integer-valued
    /// float literals like `5.0`/`-3.0`), not merely stamped with a type label over
    /// still-float bits - a mismatch here is exactly the bug `is_valid_command`'s
    /// destination-buffer-type check now catches at the *validation* layer, but a
    /// shader that lies about its own output type while this struct's `shade_fragments`
    /// still wrote float bits regardless would have defeated that check from the other
    /// side for any test that actually ran the pipeline instead of calling
    /// `is_valid_command` directly.
    struct ConstantColorFragmentShader {
        inputs: Vec<FragmentInputInfo>,
        outputs: Vec<FragmentOutputInfo>,
        value: GenericVec4,
    }

    impl ConstantColorFragmentShader {
        fn new(color: Vec4) -> Self {
            Self::new_with_output_type(color, GenericVecType::Float)
        }

        fn new_with_output_type(color: Vec4, type_: GenericVecType) -> Self {
            let value = match type_ {
                GenericVecType::Float => GenericVec4::from_float(color),
                GenericVecType::Int32 => GenericVec4::from_int(IVec4::new(
                    color.x() as i32,
                    color.y() as i32,
                    color.z() as i32,
                    color.w() as i32,
                )),
                GenericVecType::Uint32 => GenericVec4::from_uint(UVec4::new(
                    color.x() as u32,
                    color.y() as u32,
                    color.z() as u32,
                    color.w() as u32,
                )),
            };
            Self {
                inputs: vec![],
                outputs: vec![FragmentOutputInfo { type_: Some(type_) }],
                value,
            }
        }
    }

    impl FragmentShader for ConstantColorFragmentShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            &self.inputs
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            &self.outputs
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            for (packet_ndx, _) in packets.iter().enumerate() {
                for frag_ndx in 0..4 {
                    unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, self.value) };
                }
            }
        }
    }

    fn make_render_state(width: i32, height: i32) -> RenderState {
        RenderState {
            cull_mode: CullMode::None,
            provoking_vertex_convention: None,
            rasterization: super::super::render_state::RasterizationState {
                viewport_orientation: Some(ViewportOrientation::LowerLeft),
                ..Default::default()
            },
            frag_ops: super::super::render_state::FragmentOperationState::default(),
            point: PointState::default(),
            viewport: ViewportState::new(WindowRectangle {
                left: 0,
                bottom: 0,
                width,
                height,
            }),
            line: super::super::render_state::LineState::default(),
            restart: RestartState::default(),
            viewport_orientation: ViewportOrientation::LowerLeft,
            subpixel_bits: 8,
        }
    }

    #[test]
    fn a_full_screen_triangle_fills_every_pixel_with_the_constant_color() {
        const W: u32 = 4;
        const H: u32 = 4;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            W,
            H,
            1,
        )
        .unwrap();
        let color_access = as_multisample_view(level.get_access());
        let mut render_target = RenderTarget::new(color_access, None, None);

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(0.25, 0.5, 0.75, 1.0));
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: None,
        };

        let state = make_render_state(W as i32, H as i32);

        // A triangle covering way more than the viewport, in clip space (w=1), so every
        // pixel in the 4x4 target is inside it.
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [-10.0, -10.0, 0.0, 1.0],
            [10.0, -10.0, 0.0, 1.0],
            [0.0, 10.0, 0.0, 1.0],
        ];
        let attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            0,
            0,
            position_data.as_ptr().cast(),
        )];

        let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, 3, 0);
        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        Renderer::new().draw(&command, &mut render_target);

        for y in 0..H {
            for x in 0..W {
                let pixel = level.get_const_access().get_pixel(x, y, 0);
                assert!(
                    (pixel[0] - 0.25).abs() < 0.01
                        && (pixel[1] - 0.5).abs() < 0.01
                        && (pixel[2] - 0.75).abs() < 0.01
                        && (pixel[3] - 1.0).abs() < 0.01,
                    "pixel ({x},{y}) = {pixel:?}, expected approximately [0.25, 0.5, 0.75, 1.0]"
                );
            }
        }
    }

    /// End-to-end proof that this round's two fixes actually compose: a fragment shader
    /// declaring an `Int32` output, drawn through the real `Renderer::draw` pipeline
    /// (vertex shading, rasterising, `write_fragment_packets`, `FragmentProcessor::render`)
    /// into a genuinely `SIGNED_INT32` `RenderTarget`, lands the exact integer values -
    /// not a float reinterpretation of their bit pattern. Before this round this would
    /// have hit `debug_assert!(false, "invalid draw command")` in `draw_instanced`
    /// (`is_valid_command` had no destination-buffer-type check to even let it through
    /// deliberately) or, had that check been bypassed, silently painted nonsense (the
    /// old `write_fragment_packets` call `.get_float()` unconditionally).
    #[test]
    fn integer_fragment_output_lands_exact_values_in_a_signed_integer_render_target() {
        const W: u32 = 2;
        const H: u32 = 2;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32),
            W,
            H,
            1,
        )
        .unwrap();
        let color_access = as_multisample_view(level.get_access());
        let mut render_target = RenderTarget::new(color_access, None, None);

        let vs = PassthroughVertexShader::new();
        let fs =
            ConstantColorFragmentShader::new_with_output_type(Vec4::new(5.0, -3.0, 100.0, -7.0), GenericVecType::Int32);
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: None,
        };

        let state = make_render_state(W as i32, H as i32);

        // A triangle covering way more than the viewport, in clip space (w=1), so every
        // pixel in the 2x2 target is inside it.
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [-10.0, -10.0, 0.0, 1.0],
            [10.0, -10.0, 0.0, 1.0],
            [0.0, 10.0, 0.0, 1.0],
        ];
        let attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            0,
            0,
            position_data.as_ptr().cast(),
        )];

        let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, 3, 0);
        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        assert!(
            is_valid_command(&command, &render_target, 1),
            "an Int32 fragment output against a SIGNED_INT32 colour buffer is a valid pairing"
        );

        Renderer::new().draw(&command, &mut render_target);

        for y in 0..H {
            for x in 0..W {
                let pixel = level.get_const_access().get_pixel_int(x, y, 0);
                assert_eq!(pixel, [5, -3, 100, -7], "pixel ({x},{y})");
            }
        }
    }

    #[test]
    fn a_triangle_entirely_outside_the_clip_volume_draws_nothing() {
        const W: u32 = 4;
        const H: u32 = 4;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            W,
            H,
            1,
        )
        .unwrap();
        let color_access = as_multisample_view(level.get_access());
        let mut render_target = RenderTarget::new(color_access, None, None);

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(1.0, 0.0, 0.0, 1.0));
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: None,
        };

        let state = make_render_state(W as i32, H as i32);

        // Every vertex is far outside the +x clip plane (x > w).
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [10.0, -1.0, 0.0, 1.0],
            [11.0, -1.0, 0.0, 1.0],
            [10.0, 1.0, 0.0, 1.0],
        ];
        let attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            0,
            0,
            position_data.as_ptr().cast(),
        )];

        let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, 3, 0);
        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        Renderer::new().draw(&command, &mut render_target);

        for y in 0..H {
            for x in 0..W {
                let pixel = level.get_const_access().get_pixel(x, y, 0);
                assert_eq!(
                    pixel,
                    [0.0, 0.0, 0.0, 0.0],
                    "pixel ({x},{y}) should be untouched clear colour, got {pixel:?}"
                );
            }
        }
    }

    #[test]
    fn indexed_draw_with_triangle_strip_covers_a_quad() {
        const W: u32 = 4;
        const H: u32 = 4;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            W,
            H,
            1,
        )
        .unwrap();
        let color_access = as_multisample_view(level.get_access());
        let mut render_target = RenderTarget::new(color_access, None, None);

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0));
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: None,
        };

        let state = make_render_state(W as i32, H as i32);

        // A quad, big enough to cover the whole 4x4 viewport, as a triangle strip.
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 4] = [
            [-10.0, -10.0, 0.0, 1.0],
            [10.0, -10.0, 0.0, 1.0],
            [-10.0, 10.0, 0.0, 1.0],
            [10.0, 10.0, 0.0, 1.0],
        ];
        let attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            0,
            0,
            position_data.as_ptr().cast(),
        )];

        // Indexed draw via a u16 index buffer, reversed order, to prove indices (not
        // just implicit sequential vertices) are honoured.
        let indices: [u16; 4] = [3, 2, 1, 0];
        let draw_indices = DrawIndices::U16(&indices, 0);
        let primitives = PrimitiveList::from_indices(PrimitiveType::TriangleStrip, 4, draw_indices, IndexType::Uint16);

        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        Renderer::new().draw(&command, &mut render_target);

        for y in 0..H {
            for x in 0..W {
                let pixel = level.get_const_access().get_pixel(x, y, 0);
                assert!(pixel[0] > 0.9, "pixel ({x},{y}) = {pixel:?}, expected white");
            }
        }
    }

    /// Regression test for the `VertexPacketAllocator` reuse now threaded through
    /// `draw_instanced` (see that function's own comment) - until now nothing here
    /// exercised *either* a primitive-restart segment boundary or `num_instances > 1`
    /// through `Renderer::draw_instanced` at all, both of which this file's test suite
    /// had simply never driven through more than one iteration of that function's inner
    /// `while`/`for` loop.
    ///
    /// One indexed draw, two triangles separated by a restart index, times two
    /// instances, four iterations of the loop in total. Each iteration draws into its
    /// own narrow, non-overlapping column of a 4x1 render target: `InstancedOffsetVertexShader`
    /// reads a per-vertex base position (attribute 0, same two triangles for both
    /// instances) and adds a per-*instance* `x` offset (attribute 1, divisor 1) that
    /// shifts instance 1's pair of triangles two columns to the right of instance 0's.
    /// If a recycled `VertexPacket` ever carried a stale `vertex_ndx`/`instance_ndx`/
    /// `position` forward from an earlier iteration instead of this one's own, the
    /// affected column would end up either unwritten (still the texture's zero-filled
    /// default) or drawn into the wrong column - both of which the per-column check
    /// below catches, unlike a single full-viewport-covering triangle (every pre-existing
    /// test in this file) which only ever reveals that the *last* iteration drew
    /// something, not that every iteration's own data was correct.
    #[test]
    fn draw_instanced_with_restart_segments_renders_every_segment_of_every_instance_correctly() {
        const W: u32 = 4;
        const H: u32 = 1;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            W,
            H,
            1,
        )
        .unwrap();
        let color_access = as_multisample_view(level.get_access());
        let mut render_target = RenderTarget::new(color_access, None, None);

        let vs = InstancedOffsetVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0));
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: None,
        };

        let mut state = make_render_state(W as i32, H as i32);
        state.restart = RestartState {
            enabled: true,
            restart_index: 0xFFFF,
        };

        // Two tall, narrow triangles (base at y=-10, apex at y=10) centred at NDC
        // x=-0.75 ("segment A", pixel column 0 once instanced at offset 0) and
        // x=-0.25 ("segment B", column 1). At the H=1 sample row (NDC y=0, halfway
        // between base and apex) each triangle's cross-section is 0.2 wide around its
        // own centre - comfortably inside its own column (centres 0.5 apart, column
        // centres at x = (col+0.5)/4*2-1, i.e. -0.75/-0.25/0.25/0.75) and nowhere near
        // its neighbour's.
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 6] = [
            [-0.95, -10.0, 0.0, 1.0],
            [-0.55, -10.0, 0.0, 1.0],
            [-0.75, 10.0, 0.0, 1.0],
            [-0.45, -10.0, 0.0, 1.0],
            [-0.05, -10.0, 0.0, 1.0],
            [-0.25, 10.0, 0.0, 1.0],
        ];
        // Instance 0 draws segments A/B unshifted (columns 0/1); instance 1 shifts
        // both two columns to the right (columns 2/3) - `element_ndx` for a
        // divisor-1 attribute is just `instance_ndx` (see `vertex_attrib.rs`), so this
        // needs exactly one entry per instance.
        let offset_data: [f32; 2] = [0.0, 1.0];
        let attribs = [
            VertexAttrib::from_pointer(VertexAttribType::Float, 4, 0, 0, position_data.as_ptr().cast()),
            VertexAttrib::from_pointer(VertexAttribType::Float, 1, 0, 1, offset_data.as_ptr().cast()),
        ];

        // [segment A, segment B, restart, segment A, segment B] with only the index
        // buffer's own content marking the restart - `num_elements` covers the whole
        // 7-entry buffer, and `draw_instanced` below is what splits it back into two
        // 3-index segments.
        let indices: [u16; 7] = [0, 1, 2, 0xFFFF, 3, 4, 5];
        let draw_indices = DrawIndices::U16(&indices, 0);
        let primitives = PrimitiveList::from_indices(PrimitiveType::Triangles, 7, draw_indices, IndexType::Uint16);

        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        Renderer::new().draw_instanced(&command, &mut render_target, 2);

        for x in 0..W {
            let pixel = level.get_const_access().get_pixel(x, 0, 0);
            assert!(
                pixel[0] > 0.9,
                "column {x} = {pixel:?}, expected white (segment/instance data must not have gone stale across the allocator's recycled packets)"
            );
        }
    }

    /// Takes one input point (`GEOMETRYSHADERINPUTTYPE_POINTS`) and emits a quad of
    /// `half_extent` around it as a 4-vertex triangle strip - the classic point-sprite
    /// expansion shape, and exactly the "emit more than one output vertex per input
    /// primitive" case `copyVertexPacketPointers`/`GeometryEmitter` exist for. No
    /// varyings in or out (`inputs`/`outputs` both empty), matching
    /// `ConstantColorFragmentShader`'s own empty `inputs()`.
    struct PointToQuadGeometryShader {
        half_extent: f32,
    }

    impl GeometryShader for PointToQuadGeometryShader {
        fn inputs(&self) -> &[GeometryInputInfo] {
            &[]
        }
        fn outputs(&self) -> &[GeometryOutputInfo] {
            &[]
        }
        fn input_type(&self) -> GeometryShaderInputType {
            GeometryShaderInputType::Points
        }
        fn output_type(&self) -> GeometryShaderOutputType {
            GeometryShaderOutputType::TriangleStrip
        }
        fn num_vertices_out(&self) -> usize {
            4
        }
        fn num_invocations(&self) -> usize {
            1
        }
        fn shade_primitives(
            &self,
            output: &mut GeometryEmitter<'_>,
            vertices_in: i32,
            packets: &[PrimitivePacket],
            _invocation_id: i32,
            arena: &[VertexPacket],
        ) {
            assert_eq!(
                vertices_in, 1,
                "GEOMETRYSHADERINPUTTYPE_POINTS always hands shadePrimitives exactly one vertex"
            );
            let h = self.half_extent;
            for packet in packets {
                let center = arena[packet.vertices[0].expect("a point primitive always has v0")].position;
                for (dx, dy) in [(-h, -h), (h, -h), (-h, h), (h, h)] {
                    output.emit_vertex(
                        Vec4::new(center.x() + dx, center.y() + dy, center.z(), center.w()),
                        1.0,
                        &[],
                        packet.primitive_id_in,
                    );
                }
                output.end_primitive();
            }
        }
    }

    #[test]
    fn geometry_shader_expands_a_point_into_a_quad() {
        const W: u32 = 8;
        const H: u32 = 8;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            W,
            H,
            1,
        )
        .unwrap();
        let color_access = as_multisample_view(level.get_access());
        let mut render_target = RenderTarget::new(color_access, None, None);

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0));
        let gs = PointToQuadGeometryShader { half_extent: 0.5 };
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: Some(&gs),
        };

        let state = make_render_state(W as i32, H as i32);

        // One point at the exact clip-space origin.
        let position_data: [[f32; 4]; 1] = [[0.0, 0.0, 0.0, 1.0]];
        let attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            0,
            0,
            position_data.as_ptr().cast(),
        )];

        let primitives = PrimitiveList::from_arrays(PrimitiveType::Points, 1, 0);
        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        Renderer::new().draw(&command, &mut render_target);

        // The emitted quad covers clip-space [-0.5, 0.5] x [-0.5, 0.5], i.e. the middle
        // half of the 8x8 viewport (screen x/y in [2, 6)) - independent of the exact
        // pixel-centre convention, a corner of the viewport must stay untouched and the
        // dead centre must be covered.
        let center = level.get_const_access().get_pixel(W / 2, H / 2, 0);
        assert!(
            center[0] > 0.9,
            "centre pixel should be inside the emitted quad, got {center:?}"
        );

        let corner = level.get_const_access().get_pixel(0, 0, 0);
        assert_eq!(
            corner,
            [0.0, 0.0, 0.0, 0.0],
            "corner pixel should be outside the emitted quad, got {corner:?}"
        );
    }

    /// A geometry shader whose `input_type` does not match the draw call's own
    /// primitive type is rejected by `is_valid_command` (`isValidCommand`'s "draw
    /// primitive is valid for geometry shader" check) rather than silently
    /// misinterpreting the vertex stream.
    #[test]
    fn geometry_shader_input_type_mismatch_is_rejected() {
        const W: u32 = 4;
        const H: u32 = 4;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            W,
            H,
            1,
        )
        .unwrap();
        let color_access = as_multisample_view(level.get_access());
        let render_target = RenderTarget::new(color_access, None, None);

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0));
        let gs = PointToQuadGeometryShader { half_extent: 0.5 };
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: Some(&gs),
        };

        let state = make_render_state(W as i32, H as i32);

        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [-10.0, -10.0, 0.0, 1.0],
            [10.0, -10.0, 0.0, 1.0],
            [0.0, 10.0, 0.0, 1.0],
        ];
        let attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            0,
            0,
            position_data.as_ptr().cast(),
        )];

        // A Points-only geometry shader fed GL_TRIANGLES - not a valid pairing.
        let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, 3, 0);
        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        assert!(!is_valid_command(&command, &render_target, 1));
    }

    /// `isValidCommand`'s "destination buffer basic type matches fragment output type"
    /// cross-check: a `float` fragment output paired with an *integer*-format colour
    /// buffer must be rejected (`getTextureChannelClass(SIGNED_INT32) ==
    /// TEXTURECHANNELCLASS_SIGNED_INTEGER`, which maps to `GENERICVECTYPE_INT32`, not
    /// `GENERICVECTYPE_FLOAT`). Before this round's change `is_valid_command` never read
    /// the colour buffer's own format at all, so this exact mismatch passed silently.
    #[test]
    fn fragment_output_float_against_integer_colorbuffer_is_rejected() {
        const W: u32 = 2;
        const H: u32 = 2;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32),
            W,
            H,
            1,
        )
        .unwrap();
        let color_access = as_multisample_view(level.get_access());
        let render_target = RenderTarget::new(color_access, None, None);

        let vs = PassthroughVertexShader::new();
        // Declared as a float output, but the colour buffer above is an integer format.
        let fs =
            ConstantColorFragmentShader::new_with_output_type(Vec4::new(1.0, 1.0, 1.0, 1.0), GenericVecType::Float);
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: None,
        };

        let state = make_render_state(W as i32, H as i32);

        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [-10.0, -10.0, 0.0, 1.0],
            [10.0, -10.0, 0.0, 1.0],
            [0.0, 10.0, 0.0, 1.0],
        ];
        let attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            0,
            0,
            position_data.as_ptr().cast(),
        )];
        let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, 3, 0);
        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        assert!(!is_valid_command(&command, &render_target, 1));
    }

    /// The positive counterpart of the test above: an `Int32` fragment output paired
    /// with a genuinely integer-format colour buffer is accepted - the cross-check must
    /// not reject every integer buffer, only a mismatched one.
    #[test]
    fn fragment_output_int_against_matching_integer_colorbuffer_is_accepted() {
        const W: u32 = 2;
        const H: u32 = 2;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32),
            W,
            H,
            1,
        )
        .unwrap();
        let color_access = as_multisample_view(level.get_access());
        let render_target = RenderTarget::new(color_access, None, None);

        let vs = PassthroughVertexShader::new();
        let fs =
            ConstantColorFragmentShader::new_with_output_type(Vec4::new(1.0, 1.0, 1.0, 1.0), GenericVecType::Int32);
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: None,
        };

        let state = make_render_state(W as i32, H as i32);

        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [-10.0, -10.0, 0.0, 1.0],
            [10.0, -10.0, 0.0, 1.0],
            [0.0, 10.0, 0.0, 1.0],
        ];
        let attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            0,
            0,
            position_data.as_ptr().cast(),
        )];
        let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, 3, 0);
        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        assert!(is_valid_command(&command, &render_target, 1));
    }

    /// A `RenderTarget` built over a genuinely multisampled colour buffer (`size()[0]
    /// == NUM_SAMPLES`, no `as_multisample_view` reshape) must drive `TriangleRasterizer`
    /// down its real multi-sample path end to end through `Renderer::draw` - the same
    /// diagonal-triangle shape `rasterizer`'s own
    /// `multisample_coverage_has_more_live_samples_near_triangle_center` test uses
    /// (window-space right triangle at the viewport corners, hypotenuse along `x+y=4`),
    /// driven this time through vertex shading, clipping and the window-coordinate
    /// transform rather than calling the rasterizer directly. Before this change
    /// `RenderTarget::get_num_samples` always returned 1 regardless of the buffer's own
    /// shape, so this exact scenario would have silently rasterized single-sampled.
    #[test]
    fn multisample_render_target_drives_genuine_per_sample_coverage_through_the_renderer() {
        const W: u32 = 4;
        const H: u32 = 4;
        const NUM_SAMPLES: u32 = 4;

        let mut level = crate::tcu::pixel::TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            NUM_SAMPLES,
            W,
            H,
        )
        .unwrap();
        let color_access = level.get_access();
        assert_eq!(
            color_access.size(),
            [NUM_SAMPLES, W, H],
            "sanity: a genuine multisample layout, not a single-sample reshape"
        );
        let mut render_target = RenderTarget::new(color_access, None, None);
        assert_eq!(render_target.get_num_samples(), NUM_SAMPLES as i32);

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0));
        let program = Program {
            vertex_shader: &vs,
            fragment_shader: &fs,
            geometry_shader: None,
        };

        let state = make_render_state(W as i32, H as i32);

        // Clip-space (-1,-1)/(1,-1)/(-1,1) map (via transform_vertex_clip_coords_to_window_coords,
        // w=1 so no perspective divide needed) exactly onto window (0,0)/(4,0)/(0,4) -
        // the same right triangle rasterizer's own unit test above exercises.
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [-1.0, -1.0, 0.5, 1.0],
            [1.0, -1.0, 0.5, 1.0],
            [-1.0, 1.0, 0.5, 1.0],
        ];
        let attribs = [VertexAttrib::from_pointer(
            VertexAttribType::Float,
            4,
            0,
            0,
            position_data.as_ptr().cast(),
        )];
        let primitives = PrimitiveList::from_arrays(PrimitiveType::Triangles, 3, 0);
        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &attribs,
            primitives: &primitives,
        };

        Renderer::new().draw(&command, &mut render_target);

        let const_access = level.get_const_access();

        // The right-angle corner pixel (window (0,0)) is deep inside the triangle
        // (x+y=0 << 4): every sample must be painted.
        for s in 0..NUM_SAMPLES {
            assert_eq!(
                const_access.get_pixel(s, 0, 0),
                [1.0, 1.0, 1.0, 1.0],
                "sample {s} of the fully-covered corner pixel should be painted"
            );
        }

        // The opposite corner (window (W-1, H-1), x+y=6 >> 4) is deep outside: no
        // sample anywhere should have been touched.
        for s in 0..NUM_SAMPLES {
            assert_eq!(
                const_access.get_pixel(s, W - 1, H - 1),
                [0.0, 0.0, 0.0, 0.0],
                "sample {s} of the fully-uncovered corner pixel should stay clear"
            );
        }

        // At least one pixel along the diagonal must show a genuine mix of covered and
        // uncovered samples - the only way that can happen is if the renderer actually
        // exercised the rasterizer's multi-sample path (num_samples > 1) rather than
        // silently collapsing every fragment to one shared coverage/depth value.
        let mut saw_mixed_pixel = false;
        for y in 0..H {
            for x in 0..W {
                let white_samples = (0..NUM_SAMPLES)
                    .filter(|&s| const_access.get_pixel(s, x, y)[0] > 0.5)
                    .count();
                if white_samples > 0 && white_samples < NUM_SAMPLES as usize {
                    saw_mixed_pixel = true;
                }
            }
        }
        assert!(
            saw_mixed_pixel,
            "expected at least one pixel with partial MSAA coverage along the triangle's diagonal edge"
        );
    }
}
