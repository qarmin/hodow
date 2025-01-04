// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/simplereference/sglrReferenceContext.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// This is `sglr::ReferenceContext` - the software GL object/state-machine layer most
// of upstream's GLES render tests compare against, built on top of `rr::Renderer`.
// Upstream's own file is ~1239 (header) + ~5760 (source) lines covering buffer
// objects, VAOs, textures, framebuffers, renderbuffers, shader program objects, the
// whole fixed-function-adjacent state (blend/depth/stencil/scissor/viewport/...), and
// draw-call dispatch into `rr::Renderer::draw`. This port covers:
//  - buffer objects and vertex array objects (the two pieces the task that produced
//    this file named first, since every later piece reads through one of them),
//  - texture objects, covering every GL texture type except `GL_TEXTURE_1D`,
//    `GL_TEXTURE_2D_MULTISAMPLE` and `GL_TEXTURE_2D_MULTISAMPLE_ARRAY` (see the
//    "Still not ported" paragraph below for why those two stay out):
//    `GL_TEXTURE_2D`, `GL_TEXTURE_CUBE_MAP`, `GL_TEXTURE_2D_ARRAY`, `GL_TEXTURE_3D`,
//    `GL_TEXTURE_CUBE_MAP_ARRAY` and `GL_TEXTURE_BUFFER` (`genTextures`/`bindTexture`/
//    `texImage2D`/`texSubImage2D`/`texImage3D`/`texSubImage3D`/`texBuffer`/
//    `deleteTextures`/`activeTexture`, one
//    binding per texture unit *per target type* - `texture_2d_bindings`/
//    `texture_cube_bindings`/`texture_2d_array_bindings`/`texture_3d_bindings`/
//    `texture_cube_array_bindings`/`texture_buffer_bindings`, see `TextureObject`'s own
//    doc comment for why every
//    target shares one `ObjectManager`), plus `texParameteri` and `pixelStorei`
//    (`GL_UNPACK_ALIGNMENT`/`_ROW_LENGTH`/`_SKIP_ROWS`/`_SKIP_PIXELS`, actually honoured
//    by `tex_image_2d`/`tex_sub_image_2d`'s `unpack_2d_access`, plus `_IMAGE_HEIGHT`/
//    `_SKIP_IMAGES` for `tex_image_3d`/`tex_sub_image_3d`'s `unpack_3d_access`). No
//    implicit per-unit default texture object - `texImage2D`/`texImage3D` with nothing
//    bound reports `GL_INVALID_OPERATION` rather than silently acting on one, unlike
//    real GL. `Texture2D::is_complete`/`resolve_sampler` give `texParameteri`'s stored
//    state somewhere to go: mipmap completeness is checked exactly as upstream's own
//    `Texture2D::isComplete` does, and a complete texture's wrap/filter state is mapped
//    into a real `tcu::pixel::Sampler` for the draw to sample through (see
//    `ResolvedSampler2D`'s own doc comment) - an incomplete one resolves to `None`,
//    matching upstream's own `&m_emptyTex2D` fallback. `TextureCube`/`Texture2DArray`/
//    `Texture3D`/`TextureCubeArray` have their own `is_complete` (upstream's
//    `TextureCube::isComplete`/`Texture2DArray::isComplete`/`Texture3D::isComplete`/
//    `TextureCubeArray::isComplete`, all four ported) **and** their own `resolve_sampler`
//    (`ResolvedSamplerCube`/`ResolvedSampler2DArray`/`ResolvedSampler3D`/
//    `ResolvedSamplerCubeArray` - see each struct's own doc comment for what differs
//    from `Texture2D`'s),
//  - program objects, narrowed to one `rr::VertexShader` + one `rr::FragmentShader`
//    pair per program (`createProgram`/`useProgram`/`deleteProgram` - no geometry
//    shader slot) **or** a `sglr::ShaderProgram` with named uniform slots
//    (`createShaderProgram`, the `Declared` shape `sglr::Context::create_program`
//    always produces - see `shader_program.rs`'s own doc comment). A declared sampler
//    uniform of any of the five mip-mappable types above (`Sampler2D`/`SamplerCube`/
//    `Sampler2DArray`/`Sampler3D`/`SamplerCubeArray`), its integer/unsigned counterpart
//    (`IntSampler2D`/`UintSampler2D`/...), (for `Sampler2D`/`SamplerCube`/
//    `Sampler2DArray`/`SamplerCubeArray`) its shadow counterpart, or `SamplerBuffer`/
//    `IntSamplerBuffer`/`UintSamplerBuffer` (the `GL_TEXTURE_BUFFER` sampler family,
//    `texelFetch`-only - see `TextureBuffer`'s own doc comment) is resolved against whichever
//    matching-type texture object is bound to the texture unit `uniform1i` named for
//    it, but only at draw time (`resolve_sampler_uniforms`, called from
//    `draw_with_reference` below) - see `uniform1i`'s and
//    `ShaderProgram::bind_samplers`'s own doc comments for the full design and why it
//    clones the texture's mip chain rather than handing out a live reference the way
//    upstream's own `UniformSlot::sampler` union does,
//  - the default framebuffer: a plain owned colour buffer plus an optional depth
//    buffer (`viewport`, `clearColor`/`clear`, `clearBufferfv`/`clearBufferiv`/
//    `clearBufferuiv`/`clearBufferfi` (the one entry point able to initialise an
//    integer-format colour attachment with a real integer value rather than `clear`'s
//    own float-only `glClearColor` state - see `clear_buffer_iv`'s own doc comment),
//    `drawArrays`/`drawArraysInstanced`/`drawElements*`/`drawRangeElements*` wired all
//    the way into `rr::Renderer::draw_instanced`) - a real `drawArrays`/`drawElements`
//    call into an integer-format colour attachment (both the renderbuffer and the
//    texture-attachment shape of `resolve_color_target`) is confirmed end to end, not
//    just `clear`'s path: see `draw_arrays_writes_exact_signed_integer_values_into_an_integer_color_attachment`
//    and `draw_into_an_integer_color_texture_fbo_renders_there_and_is_readable_via_the_texture_object`.
//    `clear` itself now honours scissor,
//    `colorMask`, `depthMask` and the stencil write mask too - see its own doc comment
//    for why that was a real, previously-silent gap rather than a cosmetic one,
//  - renderbuffer, `GL_TEXTURE_2D`, cube-face and `GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_3D`/
//    `GL_TEXTURE_CUBE_MAP_ARRAY` layer (level 0 only) framebuffer attachments
//    (`genRenderbuffers`/`bindRenderbuffer`/`renderbufferStorage`/`deleteRenderbuffers`,
//    `genFramebuffers`/`bindFramebuffer`/`framebufferRenderbuffer`/
//    `framebufferTexture2D`/`framebufferTextureLayer`/`checkFramebufferStatus`/
//    `deleteFramebuffers`) - a draw call or `clear` with an FBO bound renders into its
//    attached renderbuffers/texture levels/cube faces/array layers instead of the
//    default framebuffer (`resolve_targets`/`resolve_color_target`/
//    `resolve_optional_target`, via the `FboAttachment` enum covering all five backing
//    kinds), so render-to-texture (draw into an FBO with a texture colour attachment,
//    then read the result back through that same texture object) now works end to end
//    - see `draw_into_a_color_texture_fbo_renders_there_and_is_readable_via_the_texture_object`
//    for the exact shape. `framebufferTexture2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X + face,
//    ...)` attaches one face of a `TextureCube` the same way, and `framebufferTextureLayer`
//    attaches one layer of a `Texture2DArray`/`Texture3D`/`TextureCubeArray` - both
//    `framebufferTexture2D` and `framebufferTextureLayer` only ever store/attach level 0
//    - matching upstream's own restriction (its own comment: "We should allow other
//    levels as well" - it never did), not a narrowing this port introduced. A
//    renderbuffer/texture attached to *both* `GL_DEPTH_ATTACHMENT` and
//    `GL_STENCIL_ATTACHMENT` at once (a real GL combined depth-stencil renderbuffer,
//    e.g. `GL_DEPTH24_STENCIL8`) **is** supported - `resolve_targets` resolves it to
//    one pointer and splits it into its two channel views via
//    `tcu::pixel::split_combined_depth_stencil_mut` (see both functions' own doc
//    comments, the latter for the aliasing caveat that split necessarily carries). Every
//    draw call (direct or indirect) now refuses to proceed with
//    `GL_INVALID_FRAMEBUFFER_OPERATION` when the bound draw framebuffer is incomplete,
//    matching upstream's own `predrawErrorChecks` - see `predraw_checks`'s own doc
//    comment for why this was missing for a while even after `checkFramebufferStatus`
//    itself existed. `clear` does not get the same check - upstream's own `clear` never
//    calls `checkFramebufferStatus` either, confirmed directly against its source.
//  - indirect draws (`drawArraysIndirect`/`drawElementsIndirect`, reading their command
//    struct's fields out of a bound `GL_DRAW_INDIRECT_BUFFER` and forwarding to
//    `draw_arrays_instanced`/`draw_elements_instanced_base_vertex` - see
//    `draw_arrays_indirect`'s own doc comment for the exact field layout),
//  - the fixed-function-adjacent state a draw call reads: `scissor`/`enable`/`disable`
//    (`GL_SCISSOR_TEST`/`GL_DEPTH_TEST`/`GL_STENCIL_TEST`/`GL_BLEND`/
//    `GL_POLYGON_OFFSET_FILL`/`GL_PRIMITIVE_RESTART_FIXED_INDEX`/`GL_DITHER`),
//    `stencilFunc(Separate)`/`stencilOp(Separate)`/`stencilMask(Separate)`,
//    `depthFunc`/`depthRangef`/`depthMask`, `polygonOffset`,
//    `blendEquation(Separate)`/`blendFunc(Separate)`/`blendColor`, `colorMask`,
//    `lineWidth` - all read by `draw_with_reference` into the matching
//    `rr::RenderState`/`rr::FragmentOperationState` fields - plus `drawRangeElements(BaseVertex)`
//    (upstream's own `start`/`end` hint does nothing here beyond its `end < start`
//    error check - every vertex is already read through `rr::VertexAttrib` regardless),
//    `finish` (a no-op; every draw call here already runs to completion
//    synchronously), `vertexAttrib{1,2,3,4}f`/`vertexAttribI4{i,ui}` (the "current"
//    generic value a *disabled* vertex attribute array reads at draw time - stored per
//    attribute in `current_attribs`, read by `build_vertex_attribs` exactly where GL's
//    own `(0,0,0,1)` default used to be hardcoded), and
//    `GL_PRIMITIVE_RESTART_FIXED_INDEX` actually splitting an indexed draw's index
//    stream (wired into `state.restart` off `rr::PrimitiveList::index_type` - see
//    `fixed_restart_index`'s own doc comment for the per-width restart value this
//    reads).
//
// Still not ported: `GL_TEXTURE_1D` (as a texture type, as an FBO attachment, and as a
// `framebufferTextureLayer` target - every other texture type now exists, see the
// texture-objects bullet above). Wrap/filter-aware sampling (see `ResolvedSampler2D`'s
// own doc comment) is wired for all five mip-mappable texture types this port backs,
// through one `ResolvedSampler` enum `resolve_sampler_uniforms` builds per declared
// sampler uniform - not just the five colour-path types (`Sampler2D`/`SamplerCube`/
// `Sampler2DArray`/`Sampler3D`/`SamplerCubeArray`) but also `IntSampler*`/`UintSampler*`
// (integer/unsigned texture storage was already there - `map_gl_internal_format`/
// `map_gl_tex_internal_format` map `GL_R32I`/`GL_RGBA32UI`-etc. internal formats same as
// any other - only the sampler side was missing: each `ResolvedSampler*` struct's own
// `sample_int`/`sample_uint` methods, reached through `tcu::pixel`'s own "Integer/unsigned
// sampler support" section, a `NEAREST`-only tap the GLES spec itself requires for an
// integer format) and `Sampler2DShadow`/`SamplerCubeShadow`/`Sampler2DArrayShadow`/
// `SamplerCubeArrayShadow` (depth-comparison sampling - `GL_TEXTURE_COMPARE_MODE`/`_FUNC`,
// stored on `TextureSamplerState` and resolved through `resolve_compare_mode` into each of
// those four `ResolvedSampler*` structs' own `compare` field, read only by their
// `sample_compare` method). `GL_TEXTURE_BUFFER` (`samplerBuffer`/`isamplerBuffer`/
// `usamplerBuffer`, `TextureBuffer`/`ResolvedSamplerBuffer`) is the sixth texture type,
// but genuinely does not share that machinery - no mip chain, no wrap/filter state, only
// `texelFetch` by raw index into the attached buffer's own bytes (see `TextureBuffer`'s
// own doc comment). All three of these (int/uint, shadow, buffer) are new code, not a
// port, the same way `generate_mipmap` already was - see `TextureSamplerState::
// compare_mode`'s own doc comment for the exact grep that confirmed upstream's real
// `texParameteri` never implements either shadow-comparison `pname` at all, and
// `tex_buffer`'s own doc comment for the equivalent grep against upstream's own
// `class Texture*` declarations (upstream's `sglr::ReferenceContext` has no buffer-backed
// texture type to port from either). `Sampler2DMultisample`/`IntSampler2DMultisample`/
// `UintSampler2DMultisample` and the `Image2D`/`Image3D`/... (shader image load/store)
// family are a different gap again, and a deeper one than `SamplerBuffer` turned out to
// be: **upstream's own `sglr::ReferenceContext` has zero support for either, not just an
// unported one** - confirmed by grep, the same way the buffer-texture claim above was:
// `sglrReferenceContext.hpp`'s six `class Texture*` declarations include no multisample
// type, and neither `imageLoad`/`imageStore`/`glBindImageTexture` nor
// `GL_TEXTURE_2D_MULTISAMPLE`/`texStorage2DMultisample` appear anywhere in either `.hpp`
// or `.cpp`. Backing either here would need a multisample-renderbuffer-backed texture
// (and, for a sampler to ever hold real multisample data rather than an empty one, MSAA
// rendering support in `rr::Renderer` itself - nothing upstream's own `rr` provides to
// this reference context either) or shader-image-load-store state threaded through
// `ShaderProgram::shade_fragments`'s current `&self`-only (read-only) signature
// respectively - both a materially larger undertaking than `SamplerBuffer` was, with no
// upstream C++ to check the result against either way. `generate_mipmap` is new code, not a port - grepped directly against
// `sglrContext.hpp`'s own ~90-method pure-virtual interface, upstream's
// `sglr::ReferenceContext` never implements `glGenerateMipmap` at all, since every
// upstream test that needs a complete mip pyramid through `sglr::Context` uploads each
// level with its own `texImage2D(level, ...)` call instead - covers every texture type
// this port backs (see that method's own doc comment for the box-filter downsample
// rule it uses and how one fully 3D downsample function serves all five without
// needing to special-case any of them).
//
// `renderbufferStorageMultisample` has no entry point here at all (not even as a stub)
// despite `rr::Renderer` now genuinely driving a multisampled `RenderTarget` down a real
// per-sample path (see `renderer.rs`'s own top doc comment) - re-checked deliberately
// after that `rr`-side work landed, rather than assumed still true. This is not the gap
// it might look like: upstream's own `ReferenceContext::renderbufferStorageMultisample`
// is itself a `\todo [2012-04-07 pyry] Implement MSAA support` stub that discards
// `samples` and falls straight back to the single-sample `renderbufferStorage` path, so
// a faithful port could only ever add the same do-nothing entry point, never a real
// multisampled renderbuffer. It also has no grep-confirmed caller yet: neither
// `es2fFboRenderTest.cpp` nor `es3fFboRenderTest.cpp` (the pair `context.rs`'s own top
// doc comment names as what grew this trait to begin with) ever calls it - the latter's
// `Format` struct carries a `samples` field that is assigned and never read anywhere in
// that file, so it does not count as a use either - which matters because `context.rs`'s
// own doc comment states this `Context` trait is deliberately narrowed to what an
// in-scope caller grep-confirms it needs, not upstream's whole interface; adding a method
// nothing calls would be the one thing that policy exists to prevent. `rr::multisample_
// pixel_buffer_access`'s MSAA *resolve* functions (`resolve_multisample_color_buffer` and
// friends) were ported anyway, same as `VertexPacketAllocator` was, since those are
// useful independently of this file ever growing a multisample renderbuffer - see that
// module's own doc comment.
//
// Geometry shaders, cull mode - **not a gap this port introduced**: upstream's own
// `drawWithReference` has `//state.cullMode = m_cullMode` commented out and no
// `m_cullMode` member at all, so `cullFace`/`frontFace` were never implemented
// upstream either. `GL_PRIMITIVE_RESTART` (the desktop-only settable-restart-index
// capability, as opposed to the ES `GL_PRIMITIVE_RESTART_FIXED_INDEX` above) is also
// dropped - see `enable`'s own doc comment on why.
//
// Upstream's `rc::NamedObject`/`rc::ObjectManager<T>` (pointer-identity, reference
// counted) is `object_manager::ObjectManager<T>` here (name-keyed, reference counted,
// no raw pointers) - see that module's own doc comment for why. Every binding point
// that upstream stores as a `DataBuffer*`/`VertexArray*` is a plain `Option<u32>` name
// here for the same reason.
//
// ES-only: `allowBGRA`/`isContextTypeES` branches collapse to "GLES, no BGRA" outright
// - this project has no desktop-GL root and none is planned (see CLAUDE.md's
// "hodow_cts" section), so `vertex_attrib_pointer`'s `GL_BGRA` acceptance (a desktop/
// `GL_ARB_vertex_array_bgra` extension) is dead code upstream itself only reaches on a
// non-ES context.
//
// `VertexAttribArray::pointer` is a `usize`, not a `*const u8`/raw pointer. GL's own API
// overloads this one argument: with no buffer bound it is a client-memory address, with
// a buffer bound it is a byte offset into that buffer - upstream exploits C's
// pointer/integer interconversion to store either in one `const void*` field.
// `build_vertex_attribs` is the one place that resolves it against whichever buffer is
// bound *at draw time* and turns it into the raw `*const u8` `rr::VertexAttrib::pointer`
// actually needs - unsafe there, same as `rr::vertex_attrib` itself requires, but
// nowhere else in this file touches memory through it.
//
// `drawElements*`'s index data is read eagerly into an owned `Vec<u32>`
// (`decode_indices`) rather than reinterpreted in place as a `&[u16]`/`&[u32]` slice -
// a byte offset into a `DataBuffer` has no alignment guarantee, and `rr::DrawIndices`'s
// typed-slice variants would be undefined behaviour to construct over misaligned bytes.
// Decoding once up front costs an allocation upstream's raw-pointer cast does not pay,
// in exchange for never constructing an unaligned reference.

use super::context::Context;
use super::object_manager::ObjectManager;
use super::reference_utils::{
    map_gl_blend_equation, map_gl_blend_func, map_gl_compare_func, map_gl_float_vertex_attribute_type,
    map_gl_mag_filter_mode, map_gl_min_filter_mode, map_gl_primitive_type, map_gl_pure_integer_vertex_attribute_type,
    map_gl_size, map_gl_stencil_op, map_gl_test_func, map_gl_wrap_mode,
};
use super::shader_program::{ShaderProgram, UniformSlot, UniformValue};
use crate::glu::shader_util::DataType;
use crate::glw::{self, GLenum};
use crate::rr::defs::IndexType;
use crate::rr::generic_vector::GenericVec4;
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{RenderState, RestartState, ViewportState, WindowRectangle};
use crate::rr::renderer::{
    self as rr_renderer, DrawCommand, DrawIndices as RrDrawIndices, PrimitiveList, Program, RenderTarget, Renderer,
};
use crate::rr::shaders::{FragmentShader, VertexShader};
use crate::rr::vertex_attrib::{VertexAttrib, VertexAttribType};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, FilterMode, MipmapFilterMode, PixelBufferAccess, Sampler, TextureLevel, WrapMode,
    linear_to_srgb_if_needed, sample_2d_array_mipmap, sample_2d_array_mipmap_compare,
    sample_2d_array_mipmap_compare_filtered, sample_2d_array_mipmap_filtered, sample_2d_array_mipmap_int,
    sample_2d_array_mipmap_uint, sample_2d_mipmap, sample_2d_mipmap_compare, sample_2d_mipmap_compare_filtered,
    sample_2d_mipmap_filtered, sample_2d_mipmap_int, sample_2d_mipmap_uint, sample_3d_mipmap,
    sample_3d_mipmap_filtered, sample_3d_mipmap_int, sample_3d_mipmap_uint, sample_cube_array_mipmap,
    sample_cube_array_mipmap_compare, sample_cube_array_mipmap_compare_filtered, sample_cube_array_mipmap_filtered,
    sample_cube_array_mipmap_int, sample_cube_array_mipmap_uint, sample_cube_mipmap, sample_cube_mipmap_compare,
    sample_cube_mipmap_compare_filtered, sample_cube_mipmap_filtered, sample_cube_mipmap_int, sample_cube_mipmap_uint,
    split_combined_depth_stencil_mut,
};
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::vector::{IVec4, UVec4, Vec4};

/// `rc::DataBuffer`
#[derive(Debug, Clone, Default)]
pub struct DataBuffer {
    data: Vec<u8>,
}

impl DataBuffer {
    /// `DataBuffer::setStorage`
    pub fn set_storage(&mut self, size: usize) {
        self.data.resize(size, 0);
    }

    pub fn size(&self) -> usize {
        self.data.len()
    }

    pub fn data(&self) -> &[u8] {
        &self.data
    }

    pub fn data_mut(&mut self) -> &mut [u8] {
        &mut self.data
    }
}

/// `rc::Renderbuffer`
#[derive(Default)]
pub struct Renderbuffer {
    /// `None` until `renderbufferStorage` is called - matching upstream's own
    /// `tcu::TextureLevel m_data` default-constructed (empty, zero size) state, just
    /// spelled as `Option` since `TextureLevel::new` needs a format up front.
    storage: Option<TextureLevel>,
}

impl Renderbuffer {
    /// `Renderbuffer::setStorage`
    fn set_storage(
        &mut self,
        format: crate::tcu::texture::TextureFormat,
        width: u32,
        height: u32,
    ) -> Result<(), crate::tcu::defs::TestError> {
        self.storage = Some(TextureLevel::new(format, width, height, 1)?);
        Ok(())
    }

    pub fn width(&self) -> u32 {
        self.storage.as_ref().map(|t| t.size()[0]).unwrap_or(0)
    }

    pub fn height(&self) -> u32 {
        self.storage.as_ref().map(|t| t.size()[1]).unwrap_or(0)
    }

    pub fn format(&self) -> Option<crate::tcu::texture::TextureFormat> {
        self.storage.as_ref().map(|t| t.format())
    }

    /// `Renderbuffer::getAccess`
    fn access(&mut self) -> Option<PixelBufferAccess<'_>> {
        self.storage.as_mut().map(|t| t.get_access())
    }

    /// Read-only access to this renderbuffer's own storage, for test introspection -
    /// `access` above is `&mut`-only and private (draw-time use only); a test reading
    /// back what a draw/clear wrote (e.g. a depth-stencil renderbuffer's own channels)
    /// needs a shared borrow it can hold onto without fighting `cx`'s own borrow.
    pub fn get_const_access(&self) -> Option<ConstPixelBufferAccess<'_>> {
        self.storage.as_ref().map(|t| t.get_const_access())
    }
}

/// `rc::Texture2D`, narrowed to `GL_TEXTURE_2D` only - see this module's top doc
/// comment for why `rc::Texture1D`/`TextureCube`/`Texture2DArray`/`Texture3D`/
/// `TextureCubeArray` are not ported. Upstream's `TextureLevelArray` (a fixed-size
/// array indexed by mip level, capped at `MAX_TEXTURE_SIZE_LOG2`) is a plain
/// `HashMap<i32, TextureLevel>` here - levels are sparse in practice (a test rarely
/// populates every level up to the cap) and nothing here needs the array's O(1)
/// index-by-level access enough to pay for the unused capacity.
#[derive(Default)]
pub struct Texture2D {
    levels: std::collections::HashMap<i32, TextureLevel>,
    /// `rc::Texture::getSampler()`'s target (`texParameteri`, below) - stored and
    /// validated as the literal `GLenum` values `glTexParameteri` was called with, mapped
    /// into a real `tcu::pixel::Sampler` only at draw time by `resolve_sampler` below
    /// (same lazy-resolution shape `resolve_sampler_uniforms` already uses for which
    /// texture object is bound - the state can change between `texParameteri` calls and
    /// the draw that samples it).
    sampler: TextureSamplerState,
}

impl Texture2D {
    /// `Texture2D::hasLevel`
    fn has_level(&self, level: i32) -> bool {
        self.levels.contains_key(&level)
    }

    /// `Texture2D::getLevel` (const)
    pub fn level(&self, level: i32) -> Option<&TextureLevel> {
        self.levels.get(&level)
    }

    /// `Texture2D::allocLevel`
    fn alloc_level(
        &mut self,
        level: i32,
        format: crate::tcu::texture::TextureFormat,
        width: u32,
        height: u32,
    ) -> Result<(), crate::tcu::defs::TestError> {
        self.levels.insert(level, TextureLevel::new(format, width, height, 1)?);
        Ok(())
    }

    /// `Texture2D::isComplete` - base level is always `0` on this port (no
    /// `GL_TEXTURE_BASE_LEVEL` support exists - `tex_parameteri` reports
    /// `GL_INVALID_ENUM` for it, same as every other `pname` it doesn't recognize), which
    /// drops upstream's own `getBaseLevel()` indirection everywhere below to a literal
    /// `0`. A texture whose `GL_TEXTURE_MIN_FILTER` isn't a mipmap mode (`GL_NEAREST`/
    /// `GL_LINEAR`) is complete as soon as level 0 exists, regardless of
    /// `GL_TEXTURE_MAX_LEVEL`; one with a mipmap min filter additionally needs every
    /// level from 1 up to `min(max_level, num_mip_levels_2d(level0) - 1)` present, each
    /// exactly half (rounded up to 1) its parent's size and the same format as level 0.
    pub fn is_complete(&self) -> bool {
        let Some(level0) = self.level(0) else { return false };
        if !is_gl_mipmap_min_filter(self.sampler.min_filter) {
            return true;
        }

        let format = level0.format();
        let [w, h, _] = level0.size();
        let num_levels = num_mip_levels_2d(w, h).min(self.sampler.max_level + 1);

        for level_ndx in 1..num_levels {
            let Some(level) = self.level(level_ndx) else {
                return false;
            };
            let expected_w = mip_level_size(w, level_ndx as u32);
            let expected_h = mip_level_size(h, level_ndx as u32);
            if level.size()[0] != expected_w || level.size()[1] != expected_h || level.format() != format {
                return false;
            }
        }
        true
    }

    /// `ReferenceContext::drawWithReference`'s own "Set shader samplers" step's
    /// `isComplete()` gate (`resolve_sampler_uniforms`'s own doc comment), narrowed to
    /// `GL_TEXTURE_2D` - `None` for an incomplete texture (the caller falls back to
    /// upstream's own `&m_emptyTex2D` behaviour instead of constructing it explicitly
    /// here, see `resolve_sampler_uniforms`), `Some` carrying either just level 0 (a
    /// non-mipmap min filter - minified sampling then also reads level 0 through that
    /// same tap, matching GL's "non-mipmap minification" definition) or the texture's
    /// whole complete mip chain (a mipmap min filter, `is_complete` already checked every
    /// level exists).
    pub fn resolve_sampler(&self) -> Option<ResolvedSampler2D> {
        if !self.is_complete() {
            return None;
        }
        let wrap_s = map_gl_wrap_mode(self.sampler.wrap_s)?;
        let wrap_t = map_gl_wrap_mode(self.sampler.wrap_t)?;
        let mag_filter = map_gl_mag_filter_mode(self.sampler.mag_filter)?;
        let min_filter = map_gl_min_filter_mode(self.sampler.min_filter)?;

        let level0 = self.level(0).expect("is_complete implies level 0 exists");
        let levels = if min_filter.1.is_some() {
            let [w, h, _] = level0.size();
            let num_levels = num_mip_levels_2d(w, h).min(self.sampler.max_level + 1);
            (0..num_levels)
                .map(|l| {
                    self.level(l)
                        .expect("is_complete already checked every level up to num_levels exists")
                        .clone()
                })
                .collect()
        } else {
            vec![level0.clone()]
        };

        let compare = resolve_compare_mode(&self.sampler);
        Some(ResolvedSampler2D {
            levels,
            wrap_s,
            wrap_t,
            mag_filter,
            min_filter,
            compare,
        })
    }
}

/// `rc::TextureCube`, narrowed the same way `Texture2D` is (see this module's top doc
/// comment): `GL_TEXTURE_CUBE_MAP` only, base level hardcoded to `0`, no seamless-cube-map
/// edge filtering. Upstream stores six independent `TextureLevelPyramid`s, one per face;
/// here each mip level is one `[Option<TextureLevel>; 6]` slot, indexed by
/// `GL_TEXTURE_CUBE_MAP_POSITIVE_X..NEGATIVE_Z`'s own contiguous order (0=+X, 1=-X,
/// 2=+Y, 3=-Y, 4=+Z, 5=-Z - see `reference_utils::map_gl_cube_map_face_index`'s own doc
/// comment for why that's also `tcu::get_cube_array_face_index`'s order with no
/// remapping needed), same sparse-per-level `HashMap` as `Texture2D::levels` for the
/// same reason - a test rarely uploads every face of every level at once.
///
/// `resolve_sampler` (below) merges each level's six independently stored faces into a
/// single depth-6 `TextureLevel` the way `tcu::pixel::sample_cube_mipmap`/`_filtered`
/// expect, rather than storing them that way from the start - upload happens one face at
/// a time (`tex_image_2d`'s own `GL_TEXTURE_CUBE_MAP_POSITIVE_X + face` branch), so a
/// single combined buffer would need the same per-face copy at upload time instead of at
/// resolve time, for no benefit (a texture is resolved at most once per draw, uploaded
/// however many times a test chooses to).
#[derive(Default)]
pub struct TextureCube {
    levels: std::collections::HashMap<i32, [Option<TextureLevel>; 6]>,
    sampler: TextureSamplerState,
}

impl TextureCube {
    fn has_face(&self, level: i32, face_index: usize) -> bool {
        self.levels.get(&level).is_some_and(|faces| faces[face_index].is_some())
    }

    fn face(&self, level: i32, face_index: usize) -> Option<&TextureLevel> {
        self.levels.get(&level)?[face_index].as_ref()
    }

    fn face_mut(&mut self, level: i32, face_index: usize) -> Option<&mut TextureLevel> {
        self.levels.get_mut(&level)?[face_index].as_mut()
    }

    fn alloc_face(
        &mut self,
        level: i32,
        face_index: usize,
        format: crate::tcu::texture::TextureFormat,
        width: u32,
        height: u32,
    ) -> Result<(), crate::tcu::defs::TestError> {
        let new_level = TextureLevel::new(format, width, height, 1)?;
        self.levels
            .entry(level)
            .or_insert_with(|| std::array::from_fn(|_| None))[face_index] = Some(new_level);
        Ok(())
    }

    /// `TextureCube::isComplete`. Upstream gates entry on `hasFace(baseLevel,
    /// CUBEFACE_NEGATIVE_X)` purely as an existence probe before deriving width/height/
    /// format from that one face - any fixed face index is behaviourally identical,
    /// since the consistency loop below already requires every face of level 0 present
    /// regardless of which one gated entry, so face index 0
    /// (`GL_TEXTURE_CUBE_MAP_POSITIVE_X`) is used here instead of upstream's arbitrary
    /// `NEGATIVE_X` choice. A non-square base face (`width != height`) is incomplete,
    /// matching upstream's own "non-square is not supported" comment - note this check
    /// runs, and the full per-face loop below runs, even for a non-mipmap min filter
    /// (`numLevels = 1`): upstream's own comment reads "Level 0 is always checked for
    /// consistency", unlike `Texture2D::isComplete`'s non-mipmap fast path which skips
    /// every check beyond "does level 0 exist".
    pub fn is_complete(&self) -> bool {
        const PROBE_FACE: usize = 0;
        let Some(probe) = self.face(0, PROBE_FACE) else {
            return false;
        };
        let [w, h, _] = probe.size();
        if w != h {
            return false;
        }
        let format = probe.format();
        let num_levels = if is_gl_mipmap_min_filter(self.sampler.min_filter) {
            num_mip_levels_2d(w, h).min(self.sampler.max_level + 1)
        } else {
            1
        };

        for level_ndx in 0..num_levels {
            let expected = mip_level_size(w, level_ndx as u32);
            for face_index in 0..6 {
                let Some(level) = self.face(level_ndx, face_index) else {
                    return false;
                };
                if level.size()[0] != expected || level.size()[1] != expected || level.format() != format {
                    return false;
                }
            }
        }
        true
    }

    /// `ReferenceContext::drawWithReference`'s own "Set shader samplers" step's
    /// `isComplete()` gate, the `GL_TEXTURE_CUBE_MAP` counterpart of
    /// `Texture2D::resolve_sampler` - see that method's own doc comment for the general
    /// shape (gate on `is_complete`, map wrap/filter state, collect one level or the
    /// whole chain depending on whether the min filter is a mipmap mode). The one real
    /// difference: each level here must first be merged from `TextureCube::levels`'s own
    /// per-face storage into a single depth-6 `TextureLevel` (face index already in
    /// `tcu::get_cube_array_face_index`'s order - see this struct's own doc comment),
    /// since every `sample_cube_mipmap`/`_filtered` tap reads all six faces of one level
    /// through one `ConstPixelBufferAccess`. The merge is a per-texel, format-agnostic
    /// copy through `get_pixel`/`set_pixel`, the same device `box_filter_downsample`
    /// already uses to stay independent of the concrete pixel format. Cube-map sampling
    /// always behaves as `GL_CLAMP_TO_EDGE` regardless of the texture's own
    /// `GL_TEXTURE_WRAP_S`/`_T` state (the GL spec's own cube-map addressing rule), so
    /// unlike `Texture2D::resolve_sampler` there is no wrap state to map here at all -
    /// `ResolvedSamplerCube::sampler_for` hardcodes it instead.
    pub fn resolve_sampler(&self) -> Option<ResolvedSamplerCube> {
        if !self.is_complete() {
            return None;
        }
        let mag_filter = map_gl_mag_filter_mode(self.sampler.mag_filter)?;
        let min_filter = map_gl_min_filter_mode(self.sampler.min_filter)?;

        let probe = self.face(0, 0).expect("is_complete implies face 0 of level 0 exists");
        let format = probe.format();
        // Same int-vs-float dispatch `copy_pixels` uses, and for the same reason: an
        // `IntSamplerCube`/`UintSamplerCube` texture merged through the float-only
        // `get_pixel`/`set_pixel` pair would round-trip every texel through an `f32`
        // intermediate, silently wrong above `f32`'s 24-bit mantissa (see
        // `copy_pixels`'s own doc comment). Known once for the whole merge - `format`
        // is shared by every face, `is_complete` already required that.
        let format_is_int = matches!(
            format.type_.channel_class(),
            crate::tcu::texture::TextureChannelClass::SignedInteger
                | crate::tcu::texture::TextureChannelClass::UnsignedInteger
        );
        let [w, h, _] = probe.size();
        let num_levels = if min_filter.1.is_some() {
            num_mip_levels_2d(w, h).min(self.sampler.max_level + 1)
        } else {
            1
        };

        let levels = (0..num_levels)
            .map(|level_ndx| {
                let size = mip_level_size(w, level_ndx as u32);
                let mut merged = TextureLevel::new(format, size, size, 6)
                    .expect("mip dimensions derived from an already-checked level must themselves be valid");
                {
                    let mut dst = merged.get_access();
                    for face_index in 0..6u32 {
                        let src = self
                            .face(level_ndx, face_index as usize)
                            .expect("is_complete already checked every face of every level up to num_levels exists")
                            .get_const_access();
                        for y in 0..size {
                            for x in 0..size {
                                if crate::tcu::pixel::is_combined_depth_stencil_type(format.type_) {
                                    dst.set_pix_depth(src.get_pix_depth(x, y, 0), x, y, face_index);
                                    if format.order == crate::tcu::texture::ChannelOrder::DS {
                                        dst.set_pix_stencil(src.get_pix_stencil(x, y, 0), x, y, face_index);
                                    }
                                } else if format_is_int {
                                    let _ = dst.set_pixel_int(src.get_pixel_int(x, y, 0), x, y, face_index);
                                } else {
                                    dst.set_pixel(src.get_pixel(x, y, 0), x, y, face_index);
                                }
                            }
                        }
                    }
                }
                merged
            })
            .collect();

        let compare = resolve_compare_mode(&self.sampler);
        Some(ResolvedSamplerCube {
            levels,
            mag_filter,
            min_filter,
            compare,
        })
    }
}

/// `rc::Texture2DArray`, narrowed the same way `Texture2D`/`TextureCube` are - see this
/// module's top doc comment. Unlike `TextureCube`'s fixed six faces, a 2D array's layer
/// count is itself part of each level's own size (the third dimension
/// `tcu::pixel::TextureLevel::new`'s `depth` parameter already carries), so one plain
/// `HashMap<i32, TextureLevel>` indexed by mip level holds every layer of that level at
/// once - exactly `Texture2D::levels`'s own shape, just with `depth > 1`.
///
/// `resolve_sampler` (below) needs no per-level merge the way `TextureCube::resolve_sampler`
/// does - every level here is already one `TextureLevel` with every layer as a depth
/// slice, exactly the shape `tcu::pixel::sample_2d_array_mipmap`/`_filtered` expect.
#[derive(Default)]
pub struct Texture2DArray {
    levels: std::collections::HashMap<i32, TextureLevel>,
    sampler: TextureSamplerState,
}

impl Texture2DArray {
    fn has_level(&self, level: i32) -> bool {
        self.levels.contains_key(&level)
    }

    /// `Texture2DArray::getLevel` (const)
    pub fn level(&self, level: i32) -> Option<&TextureLevel> {
        self.levels.get(&level)
    }

    /// `Texture2DArray::allocLevel`
    fn alloc_level(
        &mut self,
        level: i32,
        format: crate::tcu::texture::TextureFormat,
        width: u32,
        height: u32,
        num_layers: u32,
    ) -> Result<(), crate::tcu::defs::TestError> {
        self.levels
            .insert(level, TextureLevel::new(format, width, height, num_layers)?);
        Ok(())
    }

    /// `Texture2DArray::isComplete` - the same shape as `Texture2D::isComplete` (base
    /// level always `0`, a non-mipmap min filter is complete as soon as level 0
    /// exists), plus one extra per-level check upstream's own version has that
    /// `Texture2D`'s doesn't need: every present level's layer count
    /// (`TextureLevel::size()[2]`) must match level 0's, since a 2D array's layer count
    /// is part of its own size rather than a separate dimension `Texture2D` has
    /// nothing analogous to.
    pub fn is_complete(&self) -> bool {
        let Some(level0) = self.level(0) else { return false };
        if !is_gl_mipmap_min_filter(self.sampler.min_filter) {
            return true;
        }

        let format = level0.format();
        let [w, h, num_layers] = level0.size();
        let num_levels = num_mip_levels_2d(w, h).min(self.sampler.max_level + 1);

        for level_ndx in 1..num_levels {
            let Some(level) = self.level(level_ndx) else {
                return false;
            };
            let expected_w = mip_level_size(w, level_ndx as u32);
            let expected_h = mip_level_size(h, level_ndx as u32);
            if level.size()[0] != expected_w
                || level.size()[1] != expected_h
                || level.size()[2] != num_layers
                || level.format() != format
            {
                return false;
            }
        }
        true
    }

    /// `ReferenceContext::drawWithReference`'s own "Set shader samplers" step's
    /// `isComplete()` gate, the `GL_TEXTURE_2D_ARRAY` counterpart of
    /// `Texture2D::resolve_sampler` - see that method's own doc comment for the shape.
    /// No per-face/per-layer merge is needed the way `TextureCube::resolve_sampler`
    /// needs one: each level here is already a single `TextureLevel` with every layer as
    /// a depth slice, so the mip chain collected below is just a clone, same as
    /// `Texture2D::resolve_sampler`'s own.
    pub fn resolve_sampler(&self) -> Option<ResolvedSampler2DArray> {
        if !self.is_complete() {
            return None;
        }
        let wrap_s = map_gl_wrap_mode(self.sampler.wrap_s)?;
        let wrap_t = map_gl_wrap_mode(self.sampler.wrap_t)?;
        let mag_filter = map_gl_mag_filter_mode(self.sampler.mag_filter)?;
        let min_filter = map_gl_min_filter_mode(self.sampler.min_filter)?;

        let level0 = self.level(0).expect("is_complete implies level 0 exists");
        let levels = if min_filter.1.is_some() {
            let [w, h, _] = level0.size();
            let num_levels = num_mip_levels_2d(w, h).min(self.sampler.max_level + 1);
            (0..num_levels)
                .map(|l| {
                    self.level(l)
                        .expect("is_complete already checked every level up to num_levels exists")
                        .clone()
                })
                .collect()
        } else {
            vec![level0.clone()]
        };

        let compare = resolve_compare_mode(&self.sampler);
        Some(ResolvedSampler2DArray {
            levels,
            wrap_s,
            wrap_t,
            mag_filter,
            min_filter,
            compare,
        })
    }
}

/// `rc::Texture3D`, narrowed the same way `Texture2D`/`TextureCube`/`Texture2DArray`
/// are - see this module's top doc comment. Structurally identical to `Texture2DArray`
/// (one `HashMap<i32, TextureLevel>` indexed by mip level, each level's own `depth`
/// carrying the third dimension) - the only real difference is in `is_complete`: a 3D
/// texture's depth is a genuine spatial dimension that halves (rounded up to 1) at
/// every mip level the same way width/height do, where a 2D array's depth (its layer
/// count) stays fixed across the whole pyramid. That is also upstream's own only
/// structural difference between `Texture3D::isComplete` and `Texture2DArray::isComplete`.
///
/// `resolve_sampler` (below) is the same clone-the-chain shape `Texture2DArray::resolve_sampler`
/// uses, plus a genuine `GL_TEXTURE_WRAP_R` (the one real difference `TextureSamplerState::wrap_r`'s
/// own doc comment describes: a 3D texture's `r` axis is spatial and wraps, where a 2D
/// array's third coordinate is a layer index that never does).
#[derive(Default)]
pub struct Texture3D {
    levels: std::collections::HashMap<i32, TextureLevel>,
    sampler: TextureSamplerState,
}

impl Texture3D {
    fn has_level(&self, level: i32) -> bool {
        self.levels.contains_key(&level)
    }

    /// `Texture3D::getLevel` (const)
    pub fn level(&self, level: i32) -> Option<&TextureLevel> {
        self.levels.get(&level)
    }

    /// `Texture3D::allocLevel`
    fn alloc_level(
        &mut self,
        level: i32,
        format: crate::tcu::texture::TextureFormat,
        width: u32,
        height: u32,
        depth: u32,
    ) -> Result<(), crate::tcu::defs::TestError> {
        self.levels
            .insert(level, TextureLevel::new(format, width, height, depth)?);
        Ok(())
    }

    /// `Texture3D::isComplete` - the same shape as `Texture2D::isComplete` (base level
    /// always `0`, a non-mipmap min filter is complete as soon as level 0 exists), but
    /// using `num_mip_levels_3d`/shrinking `depth` at every level too (unlike
    /// `Texture2DArray::is_complete`, where the third dimension is a fixed layer count)
    /// - exactly upstream's own `Texture3D::isComplete`.
    pub fn is_complete(&self) -> bool {
        let Some(level0) = self.level(0) else { return false };
        if !is_gl_mipmap_min_filter(self.sampler.min_filter) {
            return true;
        }

        let format = level0.format();
        let [w, h, d] = level0.size();
        let num_levels = num_mip_levels_3d(w, h, d).min(self.sampler.max_level + 1);

        for level_ndx in 1..num_levels {
            let Some(level) = self.level(level_ndx) else {
                return false;
            };
            let expected_w = mip_level_size(w, level_ndx as u32);
            let expected_h = mip_level_size(h, level_ndx as u32);
            let expected_d = mip_level_size(d, level_ndx as u32);
            if level.size()[0] != expected_w
                || level.size()[1] != expected_h
                || level.size()[2] != expected_d
                || level.format() != format
            {
                return false;
            }
        }
        true
    }

    /// `ReferenceContext::drawWithReference`'s own "Set shader samplers" step's
    /// `isComplete()` gate, the `GL_TEXTURE_3D` counterpart of `Texture2D::resolve_sampler` -
    /// same shape as `Texture2DArray::resolve_sampler`, plus the genuine `wrap_r` mapping
    /// and `num_mip_levels_3d` in place of `num_mip_levels_2d` (the depth axis halves
    /// here, matching `is_complete`'s own use of it above).
    pub fn resolve_sampler(&self) -> Option<ResolvedSampler3D> {
        if !self.is_complete() {
            return None;
        }
        let wrap_s = map_gl_wrap_mode(self.sampler.wrap_s)?;
        let wrap_t = map_gl_wrap_mode(self.sampler.wrap_t)?;
        let wrap_r = map_gl_wrap_mode(self.sampler.wrap_r)?;
        let mag_filter = map_gl_mag_filter_mode(self.sampler.mag_filter)?;
        let min_filter = map_gl_min_filter_mode(self.sampler.min_filter)?;

        let level0 = self.level(0).expect("is_complete implies level 0 exists");
        let levels = if min_filter.1.is_some() {
            let [w, h, d] = level0.size();
            let num_levels = num_mip_levels_3d(w, h, d).min(self.sampler.max_level + 1);
            (0..num_levels)
                .map(|l| {
                    self.level(l)
                        .expect("is_complete already checked every level up to num_levels exists")
                        .clone()
                })
                .collect()
        } else {
            vec![level0.clone()]
        };

        Some(ResolvedSampler3D {
            levels,
            wrap_s,
            wrap_t,
            wrap_r,
            mag_filter,
            min_filter,
        })
    }
}

/// `rc::TextureCubeArray`, narrowed the same way the other texture types are - see this
/// module's top doc comment. Structurally identical to `Texture2DArray` (same
/// `HashMap<i32, TextureLevel>` shape, same `is_complete` - upstream's own
/// `TextureCubeArray::isComplete` is byte-for-byte the same shape as
/// `Texture2DArray::isComplete`, fixed `numLayers` across the whole pyramid rather than
/// halving like `Texture3D`'s real spatial depth does). The only real difference is
/// what the third dimension means and what upstream validates about it: a cube array's
/// layer count is always six faces times some number of array elements
/// (`DE_ASSERT(numLayers % 6 == 0)` in upstream's own `allocLevel` - mirrored here as a
/// `debug_assert_eq!` for the same reason `delete_texture`'s own invariant check uses
/// one, since `tex_image_3d`'s `GL_TEXTURE_CUBE_MAP_ARRAY` branch below is the only
/// caller and already turns a real violation into `GL_INVALID_VALUE` before reaching
/// here), and GL addresses one face-of-one-layer by a single flattened index
/// (`arrayLayer * 6 + face`) - which needs no special handling here at all, since that
/// is already exactly what `level_layer_access`'s own `layer` parameter indexes into a
/// `TextureLevel`'s third dimension.
///
/// `resolve_sampler` (below) needs no per-face merge either, unlike `TextureCube::resolve_sampler` -
/// the flattened `arrayLayer * 6 + face` layout this struct's own doc comment describes
/// is already exactly the depth-slice order `tcu::pixel::sample_cube_array_mipmap`/
/// `_filtered` read.
#[derive(Default)]
pub struct TextureCubeArray {
    levels: std::collections::HashMap<i32, TextureLevel>,
    sampler: TextureSamplerState,
}

impl TextureCubeArray {
    fn has_level(&self, level: i32) -> bool {
        self.levels.contains_key(&level)
    }

    /// `TextureCubeArray::getLevel` (const)
    pub fn level(&self, level: i32) -> Option<&TextureLevel> {
        self.levels.get(&level)
    }

    /// `TextureCubeArray::allocLevel`
    fn alloc_level(
        &mut self,
        level: i32,
        format: crate::tcu::texture::TextureFormat,
        width: u32,
        height: u32,
        num_layers: u32,
    ) -> Result<(), crate::tcu::defs::TestError> {
        debug_assert_eq!(
            num_layers % 6,
            0,
            "a cube-map-array layer count must be a multiple of 6 - tex_image_3d's own GL_TEXTURE_CUBE_MAP_ARRAY branch must have already rejected anything else as GL_INVALID_VALUE"
        );
        self.levels
            .insert(level, TextureLevel::new(format, width, height, num_layers)?);
        Ok(())
    }

    /// `TextureCubeArray::isComplete` - the same shape as `Texture2DArray::isComplete`
    /// (base level always `0`, a non-mipmap min filter is complete as soon as level 0
    /// exists, and the layer count stays fixed rather than halving at each mip level) -
    /// exactly upstream's own `TextureCubeArray::isComplete`.
    pub fn is_complete(&self) -> bool {
        let Some(level0) = self.level(0) else { return false };
        if !is_gl_mipmap_min_filter(self.sampler.min_filter) {
            return true;
        }

        let format = level0.format();
        let [w, h, num_layers] = level0.size();
        let num_levels = num_mip_levels_2d(w, h).min(self.sampler.max_level + 1);

        for level_ndx in 1..num_levels {
            let Some(level) = self.level(level_ndx) else {
                return false;
            };
            let expected_w = mip_level_size(w, level_ndx as u32);
            let expected_h = mip_level_size(h, level_ndx as u32);
            if level.size()[0] != expected_w
                || level.size()[1] != expected_h
                || level.size()[2] != num_layers
                || level.format() != format
            {
                return false;
            }
        }
        true
    }

    /// `ReferenceContext::drawWithReference`'s own "Set shader samplers" step's
    /// `isComplete()` gate, the `GL_TEXTURE_CUBE_MAP_ARRAY` counterpart of
    /// `Texture2D::resolve_sampler` - the same clone-the-chain shape
    /// `Texture2DArray::resolve_sampler` uses (no per-face merge needed, see this
    /// struct's own doc comment), wrapped as `ResolvedSamplerCubeArray` instead, whose
    /// own `sampler_for` hardcodes `GL_CLAMP_TO_EDGE` the same way `ResolvedSamplerCube`'s
    /// does rather than reading any wrap state here. `compare` resolves through
    /// `resolve_compare_mode` exactly like the other three shadow-capable types, backing
    /// `samplerCubeArrayShadow`.
    pub fn resolve_sampler(&self) -> Option<ResolvedSamplerCubeArray> {
        if !self.is_complete() {
            return None;
        }
        let mag_filter = map_gl_mag_filter_mode(self.sampler.mag_filter)?;
        let min_filter = map_gl_min_filter_mode(self.sampler.min_filter)?;

        let level0 = self.level(0).expect("is_complete implies level 0 exists");
        let levels = if min_filter.1.is_some() {
            let [w, h, _] = level0.size();
            let num_levels = num_mip_levels_2d(w, h).min(self.sampler.max_level + 1);
            (0..num_levels)
                .map(|l| {
                    self.level(l)
                        .expect("is_complete already checked every level up to num_levels exists")
                        .clone()
                })
                .collect()
        } else {
            vec![level0.clone()]
        };

        let compare = resolve_compare_mode(&self.sampler);
        Some(ResolvedSamplerCubeArray {
            levels,
            mag_filter,
            min_filter,
            compare,
        })
    }
}

/// `rc::TextureBuffer` - `GL_TEXTURE_BUFFER`, backing `samplerBuffer`/`isamplerBuffer`/
/// `usamplerBuffer`. Structurally unlike every other texture type this port backs: no
/// width/height, no mip chain, no wrap/filter state at all - a buffer texture is a flat
/// reinterpretation of an attached `DataBuffer`'s own bytes as an array of texels of one
/// GL internal format, read only through `texelFetch(sampler, int)` (GLSL has no plain
/// `texture()` overload for a buffer sampler - there is nothing to wrap or filter).
/// `glTexBuffer` attaches by name rather than by value, but `resolve_sampler` below
/// (like every other texture type's own) resolves against a snapshot taken at *draw*
/// time, not a live view - so unlike real GL, a `glBufferData` on the same buffer after
/// the draw that read it does not retroactively change an already-resolved sampler, and
/// unlike a `glTexImage2D`-backed texture there is also no upload step here to make that
/// distinction moot at the point of binding. Documented narrowing, not a soundness gap:
/// nothing in this port keeps a `ResolvedSampler` around across more than one draw call.
#[derive(Default)]
pub struct TextureBuffer {
    /// `GL_TEXTURE_BUFFER_DATA_STORE_BINDING` - the buffer attached by the most recent
    /// `tex_buffer` call, or `None` if the last call passed `buffer == 0` ("detach") or
    /// none has ever been made. Not reference-counted against `buffers` the way a VAO's
    /// element-array binding is - see `tex_buffer`'s own doc comment for why that
    /// narrowing was chosen.
    buffer: Option<u32>,
    /// `GL_TEXTURE_BUFFER_FORMAT` (not padded/renamed from upstream, since upstream's
    /// own `ReferenceContext` has no buffer-texture support at all to name it after -
    /// see this module's top doc comment). Stored as the raw `GLenum` rather than an
    /// already-mapped `TextureFormat`, matching every other texture type's own
    /// `TextureSamplerState`-style lazy-resolution convention.
    internal_format: Option<GLenum>,
}

impl TextureBuffer {
    /// `ReferenceContext::drawWithReference`'s own "Set shader samplers" step's
    /// completeness gate, the buffer-texture counterpart of `Texture2D::resolve_sampler` -
    /// `None` when nothing is attached, the attached buffer no longer exists (deleted
    /// out from under this texture - `buffers.find` simply stops finding it, no panic),
    /// the internal format never got set, or the buffer holds fewer bytes than one whole
    /// texel of that format.
    pub fn resolve_sampler(&self, buffers: &ObjectManager<DataBuffer>) -> Option<ResolvedSamplerBuffer> {
        let format = super::reference_utils::map_gl_tex_internal_format(self.internal_format?)?;
        let texel_size = format.pixel_size()?;
        let buf = buffers.find(self.buffer?)?;
        if (buf.size() as u32) < texel_size {
            return None;
        }
        Some(ResolvedSamplerBuffer {
            data: buf.data().to_vec(),
            format,
        })
    }
}

/// `rc::Texture`'s type tag, narrowed to the six concrete types this port backs
/// (`Texture2D`/`TextureCube`/`Texture2DArray`/`Texture3D`/`TextureCubeArray`/
/// `TextureBuffer` - see this module's top doc comment for `_1D`'s absence). Replaces
/// upstream's `getType()` + downcast: GL has one texture-name namespace shared across every target type (a name
/// returned by `glGenTextures` is untyped until its first `glBindTexture` fixes it), so
/// `ObjectManager<TextureObject>` is the single manager every texture name lives in
/// regardless of which concrete type it turns out to be - separate `ObjectManager`s
/// (one per concrete type) would give each target its own independent name counter,
/// which is wrong (name 5 could then legally exist as both a `Texture2D` and a
/// `TextureCube` at once; real GL refuses the second `glBindTexture` with
/// `GL_INVALID_OPERATION`, "name already has a different target" - `bind_texture`
/// below is where that check lives).
pub enum TextureObject {
    D2(Texture2D),
    Cube(TextureCube),
    D2Array(Texture2DArray),
    D3(Texture3D),
    CubeArray(TextureCubeArray),
    Buffer(TextureBuffer),
}

impl TextureObject {
    pub fn as_2d(&self) -> Option<&Texture2D> {
        match self {
            Self::D2(t) => Some(t),
            Self::Cube(_) | Self::D2Array(_) | Self::D3(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    fn as_2d_mut(&mut self) -> Option<&mut Texture2D> {
        match self {
            Self::D2(t) => Some(t),
            Self::Cube(_) | Self::D2Array(_) | Self::D3(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_cube(&self) -> Option<&TextureCube> {
        match self {
            Self::Cube(t) => Some(t),
            Self::D2(_) | Self::D2Array(_) | Self::D3(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    fn as_cube_mut(&mut self) -> Option<&mut TextureCube> {
        match self {
            Self::Cube(t) => Some(t),
            Self::D2(_) | Self::D2Array(_) | Self::D3(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_2d_array(&self) -> Option<&Texture2DArray> {
        match self {
            Self::D2Array(t) => Some(t),
            Self::D2(_) | Self::Cube(_) | Self::D3(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    fn as_2d_array_mut(&mut self) -> Option<&mut Texture2DArray> {
        match self {
            Self::D2Array(t) => Some(t),
            Self::D2(_) | Self::Cube(_) | Self::D3(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_3d(&self) -> Option<&Texture3D> {
        match self {
            Self::D3(t) => Some(t),
            Self::D2(_) | Self::Cube(_) | Self::D2Array(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    fn as_3d_mut(&mut self) -> Option<&mut Texture3D> {
        match self {
            Self::D3(t) => Some(t),
            Self::D2(_) | Self::Cube(_) | Self::D2Array(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_cube_array(&self) -> Option<&TextureCubeArray> {
        match self {
            Self::CubeArray(t) => Some(t),
            Self::D2(_) | Self::Cube(_) | Self::D2Array(_) | Self::D3(_) | Self::Buffer(_) => None,
        }
    }

    fn as_cube_array_mut(&mut self) -> Option<&mut TextureCubeArray> {
        match self {
            Self::CubeArray(t) => Some(t),
            Self::D2(_) | Self::Cube(_) | Self::D2Array(_) | Self::D3(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_buffer(&self) -> Option<&TextureBuffer> {
        match self {
            Self::Buffer(t) => Some(t),
            Self::D2(_) | Self::Cube(_) | Self::D2Array(_) | Self::D3(_) | Self::CubeArray(_) => None,
        }
    }

    fn as_buffer_mut(&mut self) -> Option<&mut TextureBuffer> {
        match self {
            Self::Buffer(t) => Some(t),
            Self::D2(_) | Self::Cube(_) | Self::D2Array(_) | Self::D3(_) | Self::CubeArray(_) => None,
        }
    }
}

/// `getNumMipLevels2D` - `deLog2Floor32(max(width, height)) + 1`, the number of mip
/// levels a complete `width x height` base level's pyramid has, from `width x height`
/// down to `1 x 1`.
fn num_mip_levels_2d(width: u32, height: u32) -> i32 {
    let largest = width.max(height).max(1);
    31 - largest.leading_zeros() as i32 + 1
}

/// `getNumMipLevels3D` - the same `deLog2Floor32(...) + 1` shape as `num_mip_levels_2d`,
/// over all three dimensions.
fn num_mip_levels_3d(width: u32, height: u32, depth: u32) -> i32 {
    let largest = width.max(height).max(depth).max(1);
    31 - largest.leading_zeros() as i32 + 1
}

/// `getMipLevelSize`
fn mip_level_size(base: u32, level_ndx: u32) -> u32 {
    (base >> level_ndx).max(1)
}

/// `generate_mipmap`'s own downsample rule: which half-open-then-closed range of source
/// texels along one axis a destination texel at `dst_coord` (out of `dst_size` total)
/// should average, given a parent axis of `src_size` texels. Not a fixed "always exactly
/// 2 wide" box - `dst_coord * src_size / dst_size ..= ((dst_coord + 1) * src_size /
/// dst_size).saturating_sub(1).max(lo)` instead, an area-proportional partition that
/// covers every source texel exactly once across all destination texels with neither a
/// gap nor an overlap, for *any* `src_size`/`dst_size` ratio - not just an exact 2:1
/// one. Chosen over a plain `[2*dst_coord, 2*dst_coord+1]` window specifically because
/// `dst_size` here is `mip_level_size(src_size, 1)` (`(src_size >> 1).max(1)`, i.e.
/// rounding *up* when `src_size` is odd), so a fixed 2-wide window would silently drop
/// the last source texel whenever `src_size` is odd (`src_size = 3, dst_size = 1` -
/// `[0, 1]` reads only 2 of the 3 texels); this rule instead gives that single
/// destination texel the range `0..=2`, averaging all three. For an exact 2:1 ratio
/// (`src_size` even) it reduces to the ordinary pairwise box filter: `src_size = 4,
/// dst_size = 2` gives `(0, 1)` and `(2, 3)`.
fn mip_src_range(dst_coord: u32, dst_size: u32, src_size: u32) -> (u32, u32) {
    let lo = dst_coord * src_size / dst_size;
    let hi = ((dst_coord + 1) * src_size / dst_size).saturating_sub(1).max(lo);
    (lo, hi)
}

/// `generate_mipmap`'s own per-level downsample: fills every texel of `dst` with the
/// float-space average of its own `mip_src_range` box in `src`, read/written through
/// `get_pixel`/`set_pixel` so this works over any `TextureFormat` the same way the rest
/// of this file's byte-level code stays format-agnostic by going through `tcu::pixel`
/// rather than raw bytes.
///
/// Fully 3D - `mip_src_range` is applied to the `z` axis exactly like `x`/`y`, which is
/// what lets the very same function serve every caller's shape without a 2D/3D split:
/// `GL_TEXTURE_2D` and `GL_TEXTURE_CUBE_MAP` (one call per face, each face already its
/// own standalone `TextureLevel`) pass `src`/`dst` with depth `1` on both sides, so
/// `mip_src_range(0, 1, 1)` always resolves to the single range `0..=0` and the `z` loop
/// below is a no-op for them - same shape `clear_to_texture_initial_value` already
/// documents for its own `z` loop. `GL_TEXTURE_2D_ARRAY` passes equal depth on both
/// sides (the layer count never halves - `Texture2DArray::is_complete`'s own rule), so
/// `mip_src_range(dst_z, n, n)` resolves to the single range `dst_z..=dst_z` for every
/// layer: every destination layer averages only its own matching source layer, with no
/// cross-layer blending, exactly as if a separate 2D downsample had been run per layer -
/// without this function needing to know that is what is happening. `GL_TEXTURE_3D`
/// passes a genuinely halved depth on the destination side, so the same `mip_src_range`
/// call instead produces a real multi-layer box across `z` too.
fn box_filter_downsample(src: &ConstPixelBufferAccess<'_>, dst: &mut PixelBufferAccess<'_>) {
    let [src_w, src_h, src_d] = src.size();
    let [dst_w, dst_h, dst_d] = dst.size();
    for dst_z in 0..dst_d {
        let (z0, z1) = mip_src_range(dst_z, dst_d, src_d);
        for dst_y in 0..dst_h {
            let (y0, y1) = mip_src_range(dst_y, dst_h, src_h);
            for dst_x in 0..dst_w {
                let (x0, x1) = mip_src_range(dst_x, dst_w, src_w);
                let mut sum = [0.0f32; 4];
                let mut count = 0.0f32;
                for src_z in z0..=z1 {
                    for src_y in y0..=y1 {
                        for src_x in x0..=x1 {
                            let texel = src.get_pixel(src_x, src_y, src_z);
                            for (s, t) in sum.iter_mut().zip(texel) {
                                *s += t;
                            }
                            count += 1.0;
                        }
                    }
                }
                dst.set_pixel(sum.map(|s| s / count), dst_x, dst_y, dst_z);
            }
        }
    }
}

/// `(anonymous)::isMipmapFilter` (`sglrReferenceContext.cpp`'s own file-local helper,
/// not `tcuTexVerifierUtil.hpp`'s more granular `isNearestMipmapFilter`/
/// `isLinearMipmapFilter` split, which this port doesn't need) - "not `GL_NEAREST`/
/// `GL_LINEAR`", true for all four `*_MIPMAP_*` modes.
fn is_gl_mipmap_min_filter(value: GLenum) -> bool {
    !matches!(value, glw::GL_NEAREST | glw::GL_LINEAR)
}

/// What `Texture2D::resolve_sampler` resolves a complete `GL_TEXTURE_2D` object to: its
/// mip chain (one level, or every level up to `GL_TEXTURE_MAX_LEVEL`/the pyramid's own
/// top - see `resolve_sampler`'s own doc comment) plus its wrap/filter state mapped into
/// real `tcu::pixel` types. `sample_2d_quad` is `Texture2D::sample4`'s own per-fragment
/// LOD-from-derivatives formula, reusing `tcu::pixel::sample_2d_mipmap`/
/// `sample_2d_mipmap_filtered` for the actual tap - the "lookup path" this module's top
/// doc comment used to list as not wired up at all.
///
/// Magnified (`lod <= 0.0`) and minified (`lod > 0.0`) lookups use their own GL filter
/// (`mag_filter`/`min_filter`) rather than a single shared tap the way
/// `glu::texture_test_util::exec_sample_2d`'s own `ReferenceParams::sampler` currently
/// has to (see that function's own doc comment) - `GL_TEXTURE_MIN_FILTER`/
/// `GL_TEXTURE_MAG_FILTER` can legitimately name different taps (the GL default state
/// itself does: `GL_NEAREST_MIPMAP_LINEAR` min, `GL_LINEAR` mag), and real `Sampler2D`
/// state driven straight off `texParameteri` is exactly the case that distinction
/// matters for, unlike every sampler `texture_test_util`'s own callers build by hand.
#[derive(Clone)]
pub struct ResolvedSampler2D {
    /// Level 0 first; more than one entry only when `min_filter.1` is `Some` (a mipmap
    /// min filter, and the texture was mip-complete when resolved).
    levels: Vec<TextureLevel>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    mag_filter: FilterMode,
    /// The minification tap plus mip-blend shape - see `reference_utils::map_gl_min_filter_mode`'s
    /// own doc comment for the split.
    min_filter: (FilterMode, Option<MipmapFilterMode>),
    /// `GL_TEXTURE_COMPARE_MODE`/`_FUNC`, already resolved into a real `tcu::pixel::
    /// CompareMode` by `resolve_compare_mode` (`CompareMode::None` unless the texture
    /// is configured as a shadow sampler) - read by `sample_compare` below, never by
    /// `sample`/`sample_2d_quad` (a non-shadow `Sampler2D` declared over a texture that
    /// happens to have `GL_COMPARE_REF_TO_TEXTURE` set is the app's own mistake to
    /// make, same as real GL; this port does not detect that mismatch).
    compare: crate::tcu::pixel::CompareMode,
}

impl ResolvedSampler2D {
    fn sampler_for(&self, filter: FilterMode, mip_filter: Option<MipmapFilterMode>) -> Sampler {
        Sampler {
            wrap_s: self.wrap_s,
            wrap_t: self.wrap_t,
            // `GL_TEXTURE_2D` sampling never reads `wrap_r` (there is no third axis) -
            // mirroring `wrap_s` into it matches upstream's own two-wrap-argument
            // `glu::mapGLSampler` overload, which forwards `wrapS` as `wrapR` too.
            // `GL_TEXTURE_3D`'s own `ResolvedSampler3D::sampler_for` below reads the
            // texture's *real* `GL_TEXTURE_WRAP_R` state instead, since a 3D texture's
            // `r` axis genuinely wraps (see `TextureSamplerState::wrap_r`'s own doc
            // comment for why only that one type's resolver reads it).
            wrap_r: self.wrap_s,
            filter,
            normalized_coords: true,
            compare: self.compare,
            compare_channel: 0,
            mip_filter,
            seamless_cube_map: true,
        }
    }

    /// `Texture2D::sample` - a single tap at an already-known `lod` (the sign of which
    /// alone decides magnified vs minified, matching GL's own `lod <= 0` rule).
    /// `sample_2d_quad` below is what a fragment shader actually wants instead: it
    /// derives `lod` from screen-space derivatives the same way upstream's
    /// `Texture2D::sample4` does.
    pub fn sample(&self, s: f32, t: f32, lod: f32) -> [f32; 4] {
        if lod <= 0.0 {
            let sampler = self.sampler_for(self.mag_filter, None);
            return self.levels[0]
                .get_const_access()
                .into_effective_depth()
                .sample_2d(&sampler, s, t, 0);
        }

        let (tap, mip_mode) = self.min_filter;
        let sampler = self.sampler_for(tap, mip_mode);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        match mip_mode {
            Some(mode) => sample_2d_mipmap_filtered(&level_views, &sampler, s, t, lod, mode),
            None => sample_2d_mipmap(&level_views, &sampler, s, t, lod),
        }
    }

    /// `Texture2D::sample4`'s own LOD-from-derivatives formula, for one fragment of a
    /// shaded 2x2 quad: `mu`/`mv` are the largest-magnitude screen-space derivative of
    /// the texcoord's own `s`/`t` component (across both screen axes), `lod =
    /// log2(max(mu * tex_width, mv * tex_height))` (no LOD bias - nothing in scope builds
    /// a shader that applies one). `dfdx`/`dfdy` are that fragment's own `(ds/dx,
    /// dt/dx)`/`(ds/dy, dt/dy)` - `rr::shading_context::dfdx_varying`/`dfdy_varying`'s
    /// per-fragment output, read through `.x()`/`.y()` by the caller before this is
    /// reached (this function takes plain tuples rather than `Vector<f32, 4>` so it
    /// doesn't need to know which varying slot the texcoord occupies).
    pub fn sample_2d_quad(&self, s: f32, t: f32, dfdx: (f32, f32), dfdy: (f32, f32)) -> [f32; 4] {
        let [w, h, _] = self.levels[0].size();
        let mu = dfdx.0.abs().max(dfdy.0.abs());
        let mv = dfdx.1.abs().max(dfdy.1.abs());
        let p = (mu * w as f32).max(mv * h as f32);
        self.sample(s, t, p.log2())
    }

    /// `isampler2D`'s own `texture()` tap - `IntSampler2D`'s counterpart of `sample`.
    /// Always nearest, regardless of `lod`'s sign or the texture's own filter state
    /// (see `tcu::pixel`'s own "Integer/unsigned sampler support" doc comment for why).
    pub fn sample_int(&self, s: f32, t: f32, lod: f32) -> [i32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_2d_mipmap_int(&level_views, &sampler, s, t, lod)
    }

    /// `sample_int`'s unsigned counterpart (`UintSampler2D`).
    pub fn sample_uint(&self, s: f32, t: f32, lod: f32) -> [u32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_2d_mipmap_uint(&level_views, &sampler, s, t, lod)
    }

    /// `Texture2DView::sampleCompare` - the shadow-sampler (`Sampler2DShadow`)
    /// counterpart of `sample`, same magnified/minified split, same `tcu::pixel`
    /// function pairing, differing only in which functions those are and that the
    /// result is a single comparison scalar rather than a 4-vector. New code, not a
    /// port - see `TextureSamplerState::compare_mode`'s own doc comment for why.
    pub fn sample_compare(&self, ref_: f32, s: f32, t: f32, lod: f32) -> f32 {
        if lod <= 0.0 {
            let sampler = self.sampler_for(self.mag_filter, None);
            return self.levels[0]
                .get_const_access()
                .into_effective_depth()
                .sample_2d_compare(&sampler, ref_, s, t, 0);
        }

        let (tap, mip_mode) = self.min_filter;
        let sampler = self.sampler_for(tap, mip_mode);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        match mip_mode {
            Some(mode) => sample_2d_mipmap_compare_filtered(&level_views, &sampler, ref_, s, t, lod, mode),
            None => sample_2d_mipmap_compare(&level_views, &sampler, ref_, s, t, lod),
        }
    }

    /// `sample_2d_quad`'s shadow-sampler counterpart - same derivative-based LOD
    /// estimate, routed through `sample_compare` instead of `sample`.
    pub fn sample_2d_quad_compare(&self, ref_: f32, s: f32, t: f32, dfdx: (f32, f32), dfdy: (f32, f32)) -> f32 {
        let [w, h, _] = self.levels[0].size();
        let mu = dfdx.0.abs().max(dfdy.0.abs());
        let mv = dfdx.1.abs().max(dfdy.1.abs());
        let p = (mu * w as f32).max(mv * h as f32);
        self.sample_compare(ref_, s, t, p.log2())
    }
}

/// What `TextureCube::resolve_sampler` resolves a complete `GL_TEXTURE_CUBE_MAP` object
/// to - the cube-map counterpart of `ResolvedSampler2D`. No wrap-mode fields: cube-map
/// sampling always behaves as `GL_CLAMP_TO_EDGE` regardless of the texture's own
/// `GL_TEXTURE_WRAP_S`/`_T` state (see `TextureCube::resolve_sampler`'s own doc comment),
/// so `sampler_for` hardcodes it rather than reading anything from the texture.
#[derive(Clone)]
pub struct ResolvedSamplerCube {
    /// Each entry already holds all six faces as depth slices (`TextureCube::resolve_sampler`'s
    /// own merge) - level 0 first, more than one entry only when `min_filter.1` is `Some`,
    /// exactly `ResolvedSampler2D::levels`'s own convention.
    levels: Vec<TextureLevel>,
    mag_filter: FilterMode,
    min_filter: (FilterMode, Option<MipmapFilterMode>),
    /// See `ResolvedSampler2D::compare`'s own doc comment - same resolution, same
    /// "only `sample_compare` reads it" rule, read by `SamplerCubeShadow`.
    compare: crate::tcu::pixel::CompareMode,
}

impl ResolvedSamplerCube {
    fn sampler_for(&self, filter: FilterMode, mip_filter: Option<MipmapFilterMode>) -> Sampler {
        Sampler {
            wrap_s: WrapMode::ClampToEdge,
            wrap_t: WrapMode::ClampToEdge,
            wrap_r: WrapMode::ClampToEdge,
            filter,
            normalized_coords: true,
            compare: self.compare,
            compare_channel: 0,
            mip_filter,
            seamless_cube_map: true,
        }
    }

    /// `TextureCube::sample` - a single tap at an already-known `lod`, the cube-map
    /// counterpart of `ResolvedSampler2D::sample`. Always goes through
    /// `sample_cube_mipmap`(`_filtered`) rather than a direct level-0 tap for the
    /// magnified case - unlike `ConstPixelBufferAccess::sample_2d`, there is no plain
    /// (non-mip-chain) seamless-cube entry point in `tcu::pixel`, and passing `lod = 0.0`
    /// into `sample_cube_mipmap` already resolves to level 0 by construction
    /// (`mipmap_level`'s own `lod <= 0.0 => 0` rule), so the result is identical.
    pub fn sample(&self, s: f32, t: f32, r: f32, lod: f32) -> [f32; 4] {
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        if lod <= 0.0 {
            let sampler = self.sampler_for(self.mag_filter, None);
            return sample_cube_mipmap(&level_views, &sampler, s, t, r, 0.0);
        }

        let (tap, mip_mode) = self.min_filter;
        let sampler = self.sampler_for(tap, mip_mode);
        match mip_mode {
            Some(mode) => sample_cube_mipmap_filtered(&level_views, &sampler, s, t, r, lod, mode),
            None => sample_cube_mipmap(&level_views, &sampler, s, t, r, lod),
        }
    }

    /// `TextureCube::sample4` for one fragment of a 2x2 packet (`frag_ndx = x + 2 * y`): the
    /// four directions are projected onto the fragment's own face and the lod comes from the
    /// differences of those face coordinates, exactly as upstream computes it.
    pub fn sample_cube_packet(&self, frag_ndx: usize, dirs: &[[f32; 3]; 4]) -> [f32; 4] {
        let dir = dirs[frag_ndx];
        self.sample(dir[0], dir[1], dir[2], self.cube_packet_lod(frag_ndx, dirs))
    }

    /// The lod `sample_cube_packet` samples at - what `isamplerCube`/`usamplerCube` lookups need too.
    pub fn cube_packet_lod(&self, frag_ndx: usize, dirs: &[[f32; 3]; 4]) -> f32 {
        let cube_side = self.levels[0].size()[0] as f32;
        let face = crate::tcu::pixel::select_cube_face(dirs[frag_ndx]);
        let coords: [[f32; 2]; 4] = std::array::from_fn(|i| crate::tcu::pixel::project_to_face(face, dirs[i]));
        let sub = |a: [f32; 2], b: [f32; 2]| [a[0] - b[0], a[1] - b[1]];

        let dfdx = if frag_ndx & 2 != 0 {
            sub(coords[3], coords[2])
        } else {
            sub(coords[1], coords[0])
        };
        let dfdy = if frag_ndx & 1 != 0 {
            sub(coords[3], coords[1])
        } else {
            sub(coords[2], coords[0])
        };

        let mu = dfdx[0].abs().max(dfdy[0].abs());
        let mv = dfdx[1].abs().max(dfdy[1].abs());
        (mu * cube_side).max(mv * cube_side).log2()
    }

    /// `TextureCube::sample4`'s own LOD-from-derivatives formula, approximated the way
    /// `ResolvedSampler2D::sample_2d_quad` is: every cube face is square
    /// (`TextureCube::is_complete` rejects a non-square base face), so the same
    /// `log2(max(mu, mv) * face_size)` shape applies directly to the direction vector's
    /// own screen-space derivatives rather than needing upstream's real per-face-axis
    /// projection - good enough for the minified-vs-magnified branch this port's own
    /// sampler shapes actually exercise (see `sample`'s own doc comment for why a
    /// single-level resolve makes the exact `lod` value immaterial there).
    pub fn sample_cube_quad(&self, s: f32, t: f32, r: f32, dfdx: (f32, f32, f32), dfdy: (f32, f32, f32)) -> [f32; 4] {
        let [w, h, _] = self.levels[0].size();
        let mu = dfdx
            .0
            .abs()
            .max(dfdy.0.abs())
            .max(dfdx.1.abs())
            .max(dfdy.1.abs())
            .max(dfdx.2.abs())
            .max(dfdy.2.abs());
        let p = mu * w.max(h) as f32;
        self.sample(s, t, r, p.log2())
    }

    /// `TextureCube::sample4`, one fragment of it: every coordinate of the quad is projected onto the face
    /// `packet_texcoords[frag_ndx]` selects before the derivatives are taken.
    pub fn sample_cube_quad4(&self, packet_texcoords: &[[f32; 3]; 4], frag_ndx: usize, lod_bias: f32) -> [f32; 4] {
        let cube_side = self.levels[0].size()[0] as f32;
        let face = crate::tcu::pixel::select_cube_face(packet_texcoords[frag_ndx]);
        let coords: [[f32; 2]; 4] =
            std::array::from_fn(|i| crate::tcu::pixel::project_to_face(face, packet_texcoords[i]));

        let dfdx = if frag_ndx & 2 != 0 {
            [coords[3][0] - coords[2][0], coords[3][1] - coords[2][1]]
        } else {
            [coords[1][0] - coords[0][0], coords[1][1] - coords[0][1]]
        };
        let dfdy = if frag_ndx & 1 != 0 {
            [coords[3][0] - coords[1][0], coords[3][1] - coords[1][1]]
        } else {
            [coords[2][0] - coords[0][0], coords[2][1] - coords[0][1]]
        };

        let mu = dfdx[0].abs().max(dfdy[0].abs());
        let mv = dfdx[1].abs().max(dfdy[1].abs());
        let p = (mu * cube_side).max(mv * cube_side);
        let c = packet_texcoords[frag_ndx];
        self.sample(c[0], c[1], c[2], p.log2() + lod_bias)
    }

    /// `isamplerCube`'s own `texture()` tap - `IntSamplerCube`'s counterpart of
    /// `sample`. See `ResolvedSampler2D::sample_int`'s own doc comment for why this is
    /// always nearest regardless of `lod`/filter state.
    pub fn sample_int(&self, s: f32, t: f32, r: f32, lod: f32) -> [i32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_cube_mipmap_int(&level_views, &sampler, s, t, r, lod)
    }

    /// `sample_int`'s unsigned counterpart (`UintSamplerCube`).
    pub fn sample_uint(&self, s: f32, t: f32, r: f32, lod: f32) -> [u32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_cube_mipmap_uint(&level_views, &sampler, s, t, r, lod)
    }

    /// `TextureCubeView::sampleCompare` - `sample`'s shadow-sampler (`SamplerCubeShadow`)
    /// counterpart, the cube-map analogue of `ResolvedSampler2D::sample_compare`. New
    /// code, not a port - see `TextureSamplerState::compare_mode`'s own doc comment.
    pub fn sample_compare(&self, ref_: f32, s: f32, t: f32, r: f32, lod: f32) -> f32 {
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        if lod <= 0.0 {
            let sampler = self.sampler_for(self.mag_filter, None);
            return sample_cube_mipmap_compare(&level_views, &sampler, ref_, s, t, r, 0.0);
        }

        let (tap, mip_mode) = self.min_filter;
        let sampler = self.sampler_for(tap, mip_mode);
        match mip_mode {
            Some(mode) => sample_cube_mipmap_compare_filtered(&level_views, &sampler, ref_, s, t, r, lod, mode),
            None => sample_cube_mipmap_compare(&level_views, &sampler, ref_, s, t, r, lod),
        }
    }
}

/// What `Texture2DArray::resolve_sampler` resolves a complete `GL_TEXTURE_2D_ARRAY`
/// object to - the array counterpart of `ResolvedSampler2D`. No `wrap_r` field: the third
/// coordinate is a layer index (`select_layer`'s own rounding + clamping), never wrapped.
#[derive(Clone)]
pub struct ResolvedSampler2DArray {
    levels: Vec<TextureLevel>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    mag_filter: FilterMode,
    min_filter: (FilterMode, Option<MipmapFilterMode>),
    /// See `ResolvedSampler2D::compare`'s own doc comment - read by `Sampler2DArrayShadow`.
    compare: crate::tcu::pixel::CompareMode,
}

impl ResolvedSampler2DArray {
    fn sampler_for(&self, filter: FilterMode, mip_filter: Option<MipmapFilterMode>) -> Sampler {
        Sampler {
            wrap_s: self.wrap_s,
            wrap_t: self.wrap_t,
            // Never read (the third axis is a layer index) - mirrors `wrap_s` into it
            // the same way `ResolvedSampler2D::sampler_for` does for `GL_TEXTURE_2D`.
            wrap_r: self.wrap_s,
            filter,
            normalized_coords: true,
            compare: self.compare,
            compare_channel: 0,
            mip_filter,
            seamless_cube_map: true,
        }
    }

    /// `Texture2DArrayView::sample` - the array counterpart of `ResolvedSampler2D::sample`.
    pub fn sample(&self, s: f32, t: f32, r: f32, lod: f32) -> [f32; 4] {
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        if lod <= 0.0 {
            let sampler = self.sampler_for(self.mag_filter, None);
            return sample_2d_array_mipmap(&level_views, &sampler, s, t, r, 0.0);
        }

        let (tap, mip_mode) = self.min_filter;
        let sampler = self.sampler_for(tap, mip_mode);
        match mip_mode {
            Some(mode) => sample_2d_array_mipmap_filtered(&level_views, &sampler, s, t, r, lod, mode),
            None => sample_2d_array_mipmap(&level_views, &sampler, s, t, r, lod),
        }
    }

    /// `ResolvedSampler2D::sample_2d_quad`'s array counterpart - the layer coordinate
    /// `r` carries no derivative (array-layer selection is never itself filtered, see
    /// `select_layer`'s own doc comment), so only `s`/`t` feed the LOD estimate.
    pub fn sample_2d_array_quad(&self, s: f32, t: f32, r: f32, dfdx: (f32, f32), dfdy: (f32, f32)) -> [f32; 4] {
        let [w, h, _] = self.levels[0].size();
        let mu = dfdx.0.abs().max(dfdy.0.abs());
        let mv = dfdx.1.abs().max(dfdy.1.abs());
        let p = (mu * w as f32).max(mv * h as f32);
        self.sample(s, t, r, p.log2())
    }

    /// `isampler2DArray`'s own `texture()` tap - `IntSampler2DArray`'s counterpart of
    /// `sample`. See `ResolvedSampler2D::sample_int`'s own doc comment for why this is
    /// always nearest regardless of `lod`/filter state.
    pub fn sample_int(&self, s: f32, t: f32, r: f32, lod: f32) -> [i32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_2d_array_mipmap_int(&level_views, &sampler, s, t, r, lod)
    }

    /// `sample_int`'s unsigned counterpart (`UintSampler2DArray`).
    pub fn sample_uint(&self, s: f32, t: f32, r: f32, lod: f32) -> [u32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_2d_array_mipmap_uint(&level_views, &sampler, s, t, r, lod)
    }

    /// `Texture2DArrayView::sampleCompare` - `sample`'s shadow-sampler
    /// (`Sampler2DArrayShadow`) counterpart. New code, not a port - see
    /// `TextureSamplerState::compare_mode`'s own doc comment.
    pub fn sample_compare(&self, ref_: f32, s: f32, t: f32, r: f32, lod: f32) -> f32 {
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        if lod <= 0.0 {
            let sampler = self.sampler_for(self.mag_filter, None);
            return sample_2d_array_mipmap_compare(&level_views, &sampler, ref_, s, t, r, 0.0);
        }

        let (tap, mip_mode) = self.min_filter;
        let sampler = self.sampler_for(tap, mip_mode);
        match mip_mode {
            Some(mode) => sample_2d_array_mipmap_compare_filtered(&level_views, &sampler, ref_, s, t, r, lod, mode),
            None => sample_2d_array_mipmap_compare(&level_views, &sampler, ref_, s, t, r, lod),
        }
    }
}

/// What `Texture3D::resolve_sampler` resolves a complete `GL_TEXTURE_3D` object to - the
/// 3D counterpart of `ResolvedSampler2D`, with a genuine `wrap_r` (a 3D texture's `r` axis
/// is spatial and wraps, unlike `ResolvedSampler2DArray`'s layer index).
#[derive(Clone)]
pub struct ResolvedSampler3D {
    levels: Vec<TextureLevel>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    wrap_r: WrapMode,
    mag_filter: FilterMode,
    min_filter: (FilterMode, Option<MipmapFilterMode>),
}

impl ResolvedSampler3D {
    fn sampler_for(&self, filter: FilterMode, mip_filter: Option<MipmapFilterMode>) -> Sampler {
        Sampler {
            wrap_s: self.wrap_s,
            wrap_t: self.wrap_t,
            wrap_r: self.wrap_r,
            filter,
            normalized_coords: true,
            compare: crate::tcu::pixel::CompareMode::None,
            compare_channel: 0,
            mip_filter,
            seamless_cube_map: true,
        }
    }

    /// `Texture3DView::sample` - the 3D counterpart of `ResolvedSampler2D::sample`.
    pub fn sample(&self, s: f32, t: f32, r: f32, lod: f32) -> [f32; 4] {
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        if lod <= 0.0 {
            let sampler = self.sampler_for(self.mag_filter, None);
            return sample_3d_mipmap(&level_views, &sampler, s, t, r, 0.0);
        }

        let (tap, mip_mode) = self.min_filter;
        let sampler = self.sampler_for(tap, mip_mode);
        match mip_mode {
            Some(mode) => sample_3d_mipmap_filtered(&level_views, &sampler, s, t, r, lod, mode),
            None => sample_3d_mipmap(&level_views, &sampler, s, t, r, lod),
        }
    }

    /// `ResolvedSampler2D::sample_2d_quad`'s 3D counterpart - the LOD estimate folds in
    /// the `r` axis' own derivative against the texture's depth, same `log2(max(...))`
    /// shape widened by one dimension.
    pub fn sample_3d_quad(&self, s: f32, t: f32, r: f32, dfdx: (f32, f32, f32), dfdy: (f32, f32, f32)) -> [f32; 4] {
        let [w, h, d] = self.levels[0].size();
        let mu = dfdx.0.abs().max(dfdy.0.abs());
        let mv = dfdx.1.abs().max(dfdy.1.abs());
        let mw = dfdx.2.abs().max(dfdy.2.abs());
        let p = (mu * w as f32).max(mv * h as f32).max(mw * d as f32);
        self.sample(s, t, r, p.log2())
    }

    /// `isampler3D`'s own `texture()` tap - `IntSampler3D`'s counterpart of `sample`.
    /// See `ResolvedSampler2D::sample_int`'s own doc comment for why this is always
    /// nearest regardless of `lod`/filter state. No shadow-sampler counterpart:
    /// GLSL ES has no `sampler3DShadow` type at all.
    pub fn sample_int(&self, s: f32, t: f32, r: f32, lod: f32) -> [i32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_3d_mipmap_int(&level_views, &sampler, s, t, r, lod)
    }

    /// `sample_int`'s unsigned counterpart (`UintSampler3D`).
    pub fn sample_uint(&self, s: f32, t: f32, r: f32, lod: f32) -> [u32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_3d_mipmap_uint(&level_views, &sampler, s, t, r, lod)
    }
}

/// What `TextureCubeArray::resolve_sampler` resolves a complete
/// `GL_TEXTURE_CUBE_MAP_ARRAY` object to - combines `ResolvedSamplerCube`'s own
/// always-clamp wrap behaviour (same GL cube-map addressing rule, see that struct's own
/// doc comment) with `ResolvedSampler2DArray`'s layer selection. No per-level merge is
/// needed the way `TextureCube::resolve_sampler` needs one: `TextureCubeArray::levels`
/// already stores each level as one `TextureLevel` with every layer's six faces as depth
/// slices, in GL's own flattened `arrayLayer * 6 + face` order (see that struct's own doc
/// comment) - exactly what `sample_cube_array_mipmap`/`_filtered` read directly.
#[derive(Clone)]
pub struct ResolvedSamplerCubeArray {
    levels: Vec<TextureLevel>,
    mag_filter: FilterMode,
    min_filter: (FilterMode, Option<MipmapFilterMode>),
    /// See `ResolvedSampler2D::compare`'s own doc comment - same resolution, same
    /// "only `sample_compare` reads it" rule, read by `SamplerCubeArrayShadow`.
    compare: crate::tcu::pixel::CompareMode,
}

impl ResolvedSamplerCubeArray {
    fn sampler_for(&self, filter: FilterMode, mip_filter: Option<MipmapFilterMode>) -> Sampler {
        Sampler {
            wrap_s: WrapMode::ClampToEdge,
            wrap_t: WrapMode::ClampToEdge,
            wrap_r: WrapMode::ClampToEdge,
            filter,
            normalized_coords: true,
            compare: self.compare,
            compare_channel: 0,
            mip_filter,
            seamless_cube_map: true,
        }
    }

    /// `TextureCubeArrayView::sample` generalized across a mip chain - the cube-array
    /// counterpart of `ResolvedSamplerCube::sample`.
    pub fn sample(&self, s: f32, t: f32, r: f32, q: f32, lod: f32) -> [f32; 4] {
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        if lod <= 0.0 {
            let sampler = self.sampler_for(self.mag_filter, None);
            return sample_cube_array_mipmap(&level_views, &sampler, s, t, r, q, 0.0);
        }

        let (tap, mip_mode) = self.min_filter;
        let sampler = self.sampler_for(tap, mip_mode);
        match mip_mode {
            Some(mode) => sample_cube_array_mipmap_filtered(&level_views, &sampler, s, t, r, q, lod, mode),
            None => sample_cube_array_mipmap(&level_views, &sampler, s, t, r, q, lod),
        }
    }

    /// `ResolvedSamplerCube::sample_cube_quad`'s array counterpart - `q` (the layer
    /// coordinate) carries no derivative, same reasoning `ResolvedSampler2DArray::sample_2d_array_quad`
    /// gives for its own `r`.
    pub fn sample_cube_array_quad(
        &self,
        s: f32,
        t: f32,
        r: f32,
        q: f32,
        dfdx: (f32, f32, f32),
        dfdy: (f32, f32, f32),
    ) -> [f32; 4] {
        let [w, h, _] = self.levels[0].size();
        let mu = dfdx
            .0
            .abs()
            .max(dfdy.0.abs())
            .max(dfdx.1.abs())
            .max(dfdy.1.abs())
            .max(dfdx.2.abs())
            .max(dfdy.2.abs());
        let p = mu * w.max(h) as f32;
        self.sample(s, t, r, q, p.log2())
    }

    /// `isamplerCubeArray`'s own `texture()` tap - `IntSamplerCubeArray`'s counterpart
    /// of `sample`. See `ResolvedSampler2D::sample_int`'s own doc comment for why this
    /// is always nearest regardless of `lod`/filter state.
    pub fn sample_int(&self, s: f32, t: f32, r: f32, q: f32, lod: f32) -> [i32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_cube_array_mipmap_int(&level_views, &sampler, s, t, r, q, lod)
    }

    /// `sample_int`'s unsigned counterpart (`UintSamplerCubeArray`).
    pub fn sample_uint(&self, s: f32, t: f32, r: f32, q: f32, lod: f32) -> [u32; 4] {
        let sampler = self.sampler_for(self.mag_filter, self.min_filter.1);
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        sample_cube_array_mipmap_uint(&level_views, &sampler, s, t, r, q, lod)
    }

    /// `TextureCubeArrayView::sampleCompare` - `sample`'s shadow-sampler
    /// (`SamplerCubeArrayShadow`) counterpart, the cube-array analogue of
    /// `ResolvedSamplerCube::sample_compare`. New code, not a port - see
    /// `TextureSamplerState::compare_mode`'s own doc comment.
    pub fn sample_compare(&self, ref_: f32, s: f32, t: f32, r: f32, q: f32, lod: f32) -> f32 {
        let level_views: Vec<ConstPixelBufferAccess<'_>> = self
            .levels
            .iter()
            .map(|l| l.get_const_access().into_effective_depth())
            .collect();
        if lod <= 0.0 {
            let sampler = self.sampler_for(self.mag_filter, None);
            return sample_cube_array_mipmap_compare(&level_views, &sampler, ref_, s, t, r, q, 0.0);
        }

        let (tap, mip_mode) = self.min_filter;
        let sampler = self.sampler_for(tap, mip_mode);
        match mip_mode {
            Some(mode) => {
                sample_cube_array_mipmap_compare_filtered(&level_views, &sampler, ref_, s, t, r, q, lod, mode)
            }
            None => sample_cube_array_mipmap_compare(&level_views, &sampler, ref_, s, t, r, q, lod),
        }
    }
}

/// What `TextureBuffer::resolve_sampler` resolves a complete `GL_TEXTURE_BUFFER` object
/// to - a byte-for-byte snapshot of the attached buffer plus the format it is viewed
/// through (see `TextureBuffer`'s own doc comment for why this is a snapshot rather than
/// a live view). No wrap/filter/mip fields at all: `texelFetch` is the only access GLSL
/// ES offers a buffer sampler, so there is nothing to resolve beyond the raw bytes.
#[derive(Clone)]
pub struct ResolvedSamplerBuffer {
    data: Vec<u8>,
    format: crate::tcu::texture::TextureFormat,
}

impl ResolvedSamplerBuffer {
    /// Texel count = total bytes / one texel's own byte size - `resolve_sampler` already
    /// guarantees at least one whole texel fits, via `pixel_size`'s own `Some` branch.
    fn texel_count(&self) -> i32 {
        let texel_size = self
            .format
            .pixel_size()
            .expect("resolve_sampler only ever builds this from a format pixel_size already accepted")
            as usize;
        (self.data.len() / texel_size) as i32
    }

    /// Clamps `idx` into the valid texel range rather than panicking - GLSL leaves an
    /// out-of-range `texelFetch` index undefined, and clamping is the same deterministic
    /// choice `wrap`/`select_layer` already make elsewhere in this port for an
    /// out-of-range coordinate.
    fn access(&self) -> (ConstPixelBufferAccess<'_>, i32) {
        let count = self.texel_count();
        (
            ConstPixelBufferAccess::new(self.format, [count.max(1) as u32, 1, 1], &self.data),
            count,
        )
    }

    fn clamp(idx: i32, count: i32) -> u32 {
        idx.clamp(0, (count - 1).max(0)) as u32
    }

    /// `samplerBuffer`'s own `texelFetch(sampler, int)`.
    pub fn texel_fetch(&self, idx: i32) -> [f32; 4] {
        let (access, count) = self.access();
        access.get_pixel(Self::clamp(idx, count), 0, 0)
    }

    /// `isamplerBuffer`'s own `texelFetch` (`IntSamplerBuffer`'s counterpart of
    /// `texel_fetch`).
    pub fn texel_fetch_int(&self, idx: i32) -> [i32; 4] {
        let (access, count) = self.access();
        access.get_pixel_int(Self::clamp(idx, count), 0, 0)
    }

    /// `texel_fetch_int`'s unsigned counterpart (`usamplerBuffer`) - see
    /// `ResolvedSampler2D::sample_uint`'s own doc comment for why this goes through
    /// `get_pixel_uint64` rather than reinterpreting the signed result.
    pub fn texel_fetch_uint(&self, idx: i32) -> [u32; 4] {
        let (access, count) = self.access();
        access.get_pixel_uint64(Self::clamp(idx, count), 0, 0).map(|c| c as u32)
    }
}

/// One declared sampler uniform's resolved value, at draw time - the tagged union
/// `resolve_sampler_uniforms` hands each `ShaderProgram::bind_samplers` implementation,
/// one variant per texture type this port backs (see this module's top doc comment for
/// why `GL_TEXTURE_1D` has no variant). A Rust enum rather than upstream's own raw
/// `rc::Texture*` pointer union, for the same reason `UniformValue` is a tagged enum
/// instead of a raw union (`shader_program.rs`'s own top doc comment) - a concrete
/// shader always knows which sampler type it declared a given uniform as, so a mismatch
/// here is a port bug worth panicking on rather than silently reinterpreting.
#[derive(Clone)]
pub enum ResolvedSampler {
    D2(ResolvedSampler2D),
    Cube(ResolvedSamplerCube),
    D2Array(ResolvedSampler2DArray),
    D3(ResolvedSampler3D),
    CubeArray(ResolvedSamplerCubeArray),
    Buffer(ResolvedSamplerBuffer),
}

impl ResolvedSampler {
    pub fn as_2d(&self) -> Option<&ResolvedSampler2D> {
        match self {
            Self::D2(s) => Some(s),
            Self::Cube(_) | Self::D2Array(_) | Self::D3(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_cube(&self) -> Option<&ResolvedSamplerCube> {
        match self {
            Self::Cube(s) => Some(s),
            Self::D2(_) | Self::D2Array(_) | Self::D3(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_2d_array(&self) -> Option<&ResolvedSampler2DArray> {
        match self {
            Self::D2Array(s) => Some(s),
            Self::D2(_) | Self::Cube(_) | Self::D3(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_3d(&self) -> Option<&ResolvedSampler3D> {
        match self {
            Self::D3(s) => Some(s),
            Self::D2(_) | Self::Cube(_) | Self::D2Array(_) | Self::CubeArray(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_cube_array(&self) -> Option<&ResolvedSamplerCubeArray> {
        match self {
            Self::CubeArray(s) => Some(s),
            Self::D2(_) | Self::Cube(_) | Self::D2Array(_) | Self::D3(_) | Self::Buffer(_) => None,
        }
    }

    pub fn as_buffer(&self) -> Option<&ResolvedSamplerBuffer> {
        match self {
            Self::Buffer(s) => Some(s),
            Self::D2(_) | Self::Cube(_) | Self::D2Array(_) | Self::D3(_) | Self::CubeArray(_) => None,
        }
    }
}

/// `rc::Texture::getSampler()`'s return type - stores the literal `GLenum` value rather
/// than mapping eagerly into `tcu::pixel::WrapMode`/`FilterMode` (`Texture2D::
/// resolve_sampler` does that lazily, at draw time, the same reason `texture_2d_bindings`
/// resolves a bound *name* rather than a reference - the value can still change between
/// `texParameteri` and the draw that reads it). Defaults match GL's own initial texture
/// state.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct TextureSamplerState {
    wrap_s: GLenum,
    wrap_t: GLenum,
    /// `GL_TEXTURE_WRAP_R` - real state on every texture object (real GL exposes it
    /// uniformly, same as `wrap_s`/`wrap_t`), but only `Texture3D::resolve_sampler`
    /// actually reads it: a 3D texture's `r` coordinate is a genuine spatial axis that
    /// wraps the same way `s`/`t` do, where `GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_CUBE_MAP_ARRAY`'s
    /// third coordinate is a layer index (rounded and clamped, never wrapped - see
    /// `select_layer`) and `GL_TEXTURE_CUBE_MAP`/`_ARRAY` sampling always behaves as
    /// `GL_CLAMP_TO_EDGE` regardless of this field, per the GL spec's own cube-map
    /// addressing rule (`ResolvedSamplerCube`/`ResolvedSamplerCubeArray` hardcode
    /// `WrapMode::ClampToEdge` rather than reading this at all).
    wrap_r: GLenum,
    min_filter: GLenum,
    mag_filter: GLenum,
    max_level: i32,
    /// `GL_TEXTURE_COMPARE_MODE` - `GL_NONE` (no shadow comparison, the GL default) or
    /// `GL_COMPARE_REF_TO_TEXTURE`. New state, not a port: upstream's real
    /// `sglr::ReferenceContext::texParameteri` never implements either this or
    /// `compare_func` below at all (grepped its real body directly - no
    /// `GL_TEXTURE_COMPARE_MODE`/`_FUNC` case exists), so its own `m_sampler` stays
    /// `COMPAREMODE_NONE` forever; see this module's own top doc comment for why that
    /// makes shadow-sampler support here new code rather than a port, same as
    /// `generate_mipmap`.
    compare_mode: GLenum,
    /// `GL_TEXTURE_COMPARE_FUNC` - the GL default is `GL_LEQUAL`, though it is inert
    /// until `compare_mode` above is `GL_COMPARE_REF_TO_TEXTURE`
    /// (`resolve_compare_mode`'s own doc comment).
    compare_func: GLenum,
}

impl Default for TextureSamplerState {
    fn default() -> Self {
        Self {
            wrap_s: glw::GL_REPEAT,
            wrap_t: glw::GL_REPEAT,
            wrap_r: glw::GL_REPEAT,
            min_filter: glw::GL_NEAREST_MIPMAP_LINEAR,
            mag_filter: glw::GL_LINEAR,
            max_level: 1000,
            compare_mode: glw::GL_NONE,
            compare_func: glw::GL_LEQUAL,
        }
    }
}

/// `tex_parameteri`'s own already-validated update, shared by all five texture types
/// this port backs (each carries its own `TextureSamplerState` field) - factored out so
/// `tex_parameteri` validates `pname`/`value` exactly once regardless of which concrete
/// object type it ends up applying the result to.
enum TexSamplerUpdate {
    WrapS(GLenum),
    WrapT(GLenum),
    WrapR(GLenum),
    MinFilter(GLenum),
    MagFilter(GLenum),
    MaxLevel(i32),
    CompareMode(GLenum),
    CompareFunc(GLenum),
}

fn apply_tex_sampler_update(sampler: &mut TextureSamplerState, update: TexSamplerUpdate) {
    match update {
        TexSamplerUpdate::WrapS(v) => sampler.wrap_s = v,
        TexSamplerUpdate::WrapT(v) => sampler.wrap_t = v,
        TexSamplerUpdate::WrapR(v) => sampler.wrap_r = v,
        TexSamplerUpdate::MinFilter(v) => sampler.min_filter = v,
        TexSamplerUpdate::MagFilter(v) => sampler.mag_filter = v,
        TexSamplerUpdate::MaxLevel(v) => sampler.max_level = v,
        TexSamplerUpdate::CompareMode(v) => sampler.compare_mode = v,
        TexSamplerUpdate::CompareFunc(v) => sampler.compare_func = v,
    }
}

/// `rc::Framebuffer::AttachmentPoint`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum AttachmentPoint {
    Color0,
    Depth,
    Stencil,
}

const ATTACHMENT_POINTS: [AttachmentPoint; 3] = [
    AttachmentPoint::Color0,
    AttachmentPoint::Depth,
    AttachmentPoint::Stencil,
];

/// `rc::Framebuffer::Attachment`, narrowed to the five attachment types this port
/// supports (`ATTACHMENTTYPE_RENDERBUFFER`/`ATTACHMENTTYPE_TEXTURE` with `TEXTARGET_2D`,
/// one of the six `TEXTARGET_CUBE_MAP_*`, or a `GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_3D`/
/// `GL_TEXTURE_CUBE_MAP_ARRAY` layer), and within any texture kind to mip level 0 only.
/// Upstream itself rejects any other level (`RC_IF_ERROR(level != 0, GL_INVALID_VALUE,
/// ...)`, its own comment reads "We should allow other levels as well" and never did),
/// so fixing level at 0 here is not a narrowing beyond upstream's own behaviour.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum FboAttachment {
    Renderbuffer(u32),
    Texture2D(u32),
    /// A cube-map attachment, carrying its own face index (0..=5, GL's own
    /// `GL_TEXTURE_CUBE_MAP_POSITIVE_X..NEGATIVE_Z` order - see
    /// `reference_utils::map_gl_cube_map_face_index`).
    TextureCube(u32, u32),
    /// A `GL_TEXTURE_2D_ARRAY` layer attachment (`framebufferTextureLayer`), carrying
    /// its own layer index.
    Texture2DArray(u32, u32),
    /// A `GL_TEXTURE_3D` layer attachment (`framebufferTextureLayer`, same entry point
    /// as `Texture2DArray` - upstream's own `texLayeredTypeToTarget` maps both
    /// `TYPE_2D_ARRAY` and `TYPE_3D` through it), carrying its own layer (z-slice)
    /// index.
    Texture3D(u32, u32),
    /// A `GL_TEXTURE_CUBE_MAP_ARRAY` layer attachment (`framebufferTextureLayer`, same
    /// entry point again), carrying GL's own flattened `arrayLayer * 6 + face` index -
    /// see `TextureCubeArray`'s own doc comment for why that needs no special handling
    /// here.
    CubeArray(u32, u32),
}

/// `rc::Framebuffer` - renderbuffer and (`GL_TEXTURE_2D`, level 0) texture attachments;
/// see this module's top doc comment for the narrowing.
#[derive(Default)]
pub struct Framebuffer {
    /// Indexed by `AttachmentPoint`. `None` is upstream's default `Attachment` (`type =
    /// ATTACHMENTTYPE_LAST`, nothing attached).
    attachments: [Option<FboAttachment>; 3],
}

impl Framebuffer {
    fn attachment(&self, point: AttachmentPoint) -> Option<FboAttachment> {
        self.attachments[point as usize]
    }
}

/// `ReferenceContext::acquireFboAttachmentReference`
fn acquire_fbo_attachment_reference(
    attachment: FboAttachment,
    renderbuffers: &mut ObjectManager<Renderbuffer>,
    textures: &mut ObjectManager<TextureObject>,
) {
    match attachment {
        FboAttachment::Renderbuffer(name) => renderbuffers.acquire_reference(name),
        FboAttachment::Texture2D(name)
        | FboAttachment::TextureCube(name, _)
        | FboAttachment::Texture2DArray(name, _)
        | FboAttachment::Texture3D(name, _)
        | FboAttachment::CubeArray(name, _) => textures.acquire_reference(name),
    }
}

/// `ReferenceContext::releaseFboAttachmentReference`
fn release_fbo_attachment_reference(
    attachment: FboAttachment,
    renderbuffers: &mut ObjectManager<Renderbuffer>,
    textures: &mut ObjectManager<TextureObject>,
) {
    match attachment {
        FboAttachment::Renderbuffer(name) => renderbuffers.release_reference(name),
        FboAttachment::Texture2D(name)
        | FboAttachment::TextureCube(name, _)
        | FboAttachment::Texture2DArray(name, _)
        | FboAttachment::Texture3D(name, _)
        | FboAttachment::CubeArray(name, _) => textures.release_reference(name),
    }
}

/// Whether two attachment-point contents resolve to the *same* backing storage -
/// matters only when both are the same variant with the same name, since a
/// renderbuffer name and a texture name are different namespaces (a real GL caller can
/// legitimately have renderbuffer 5 and texture 5 coexist as unrelated objects). Used
/// by `resolve_targets`' pairwise aliasing check, below.
fn attachments_alias(a: Option<FboAttachment>, b: Option<FboAttachment>) -> bool {
    matches!((a, b), (Some(x), Some(y)) if x == y)
}

/// `rc::VertexArray::VertexAttribArray`
///
/// See this module's top doc comment for why `pointer` is a `usize` and not a raw
/// pointer, and for the three-combination invariant upstream's own comment documents
/// (`buffer_deleted`/`buffer_binding`/`pointer`) - preserved verbatim below since it is
/// still exactly the invariant this struct maintains.
///
/// ```text
/// Only these three combinations are possible:
/// 1) buffer_deleted = false, buffer_binding = None,    pointer = user_ptr.  < render from a user ptr
/// 2) buffer_deleted = false, buffer_binding = Some(_), pointer = offset.    < render from a buffer with offset
/// 3) buffer_deleted = true,  buffer_binding = None,    pointer = offset     < render from a deleted buffer. Don't do anything
/// (buffer_deleted = true) implies (buffer_binding = None)
/// ```
#[derive(Debug, Clone, Copy)]
pub struct VertexAttribArray {
    pub enabled: bool,
    pub size: i32,
    pub stride: i32,
    pub type_: GLenum,
    pub normalized: bool,
    pub integer: bool,
    pub divisor: u32,
    pub buffer_deleted: bool,
    pub buffer_binding: Option<u32>,
    pub pointer: usize,
}

impl Default for VertexAttribArray {
    /// `VertexArray::VertexArray`'s per-attribute initialization loop.
    fn default() -> Self {
        Self {
            enabled: false,
            size: 4,
            stride: 0,
            type_: glw::GL_FLOAT,
            normalized: false,
            integer: false,
            divisor: 0,
            buffer_deleted: false,
            buffer_binding: None,
            pointer: 0,
        }
    }
}

/// `rc::VertexArray`
#[derive(Debug, Clone)]
pub struct VertexArray {
    pub element_array_buffer_binding: Option<u32>,
    pub arrays: Vec<VertexAttribArray>,
}

impl VertexArray {
    /// `VertexArray::VertexArray`
    pub fn new(max_vertex_attribs: usize) -> Self {
        Self {
            element_array_buffer_binding: None,
            arrays: vec![VertexAttribArray::default(); max_vertex_attribs],
        }
    }
}

/// The buffer targets `isValidBufferTarget` accepts.
fn is_valid_buffer_target(target: GLenum) -> bool {
    matches!(
        target,
        glw::GL_ARRAY_BUFFER
            | glw::GL_COPY_READ_BUFFER
            | glw::GL_COPY_WRITE_BUFFER
            | glw::GL_DRAW_INDIRECT_BUFFER
            | glw::GL_ELEMENT_ARRAY_BUFFER
            | glw::GL_PIXEL_PACK_BUFFER
            | glw::GL_PIXEL_UNPACK_BUFFER
            | glw::GL_TRANSFORM_FEEDBACK_BUFFER
            | glw::GL_UNIFORM_BUFFER
    )
}

/// `sglr::rc::ReferenceContext` - narrowed to buffers and VAOs; see this
/// module's top doc comment.
pub struct ReferenceContext {
    max_vertex_attribs: usize,
    last_error: GLenum,

    buffers: ObjectManager<DataBuffer>,
    array_buffer_binding: Option<u32>,
    copy_read_buffer_binding: Option<u32>,
    copy_write_buffer_binding: Option<u32>,
    draw_indirect_buffer_binding: Option<u32>,
    pixel_pack_buffer_binding: Option<u32>,
    pixel_unpack_buffer_binding: Option<u32>,
    transform_feedback_buffer_binding: Option<u32>,
    uniform_buffer_binding: Option<u32>,

    vertex_arrays: ObjectManager<VertexArray>,
    vertex_array_binding: Option<u32>,
    /// `m_clientVertexArray` - VAO 0, which is never stored in `vertex_arrays` (GL
    /// itself never lets a real name collide with it).
    client_vertex_array: VertexArray,

    programs: ObjectManager<ProgramObject>,
    current_program: Option<u32>,

    renderbuffers: ObjectManager<Renderbuffer>,
    renderbuffer_binding: Option<u32>,

    /// One name namespace shared by every texture target type - see `TextureObject`'s
    /// own doc comment for why this is a single `ObjectManager` rather than one per
    /// concrete type.
    textures: ObjectManager<TextureObject>,
    /// Indexed by texture unit (`GL_TEXTUREi - GL_TEXTURE0`). Upstream also has a
    /// `default2DTex` *per unit* that `texImage2D` falls back to when nothing is
    /// explicitly bound (unit 0's texture target always names a real, if initially
    /// empty, texture object in GL). Not ported - `tex_image_2d` here requires an
    /// explicit `bindTexture` first, reporting `GL_INVALID_OPERATION` otherwise. A
    /// narrowing, not a silent gap: GL code written against the implicit-default-object
    /// behaviour (vanishingly rare, since nothing can query it without a sampler) would
    /// get a clear error here instead of a wrong texture.
    texture_2d_bindings: Vec<Option<u32>>,
    /// `GL_TEXTURE_CUBE_MAP`'s own per-unit binding array - a separate `Vec` field per
    /// target type, matching `texture_2d_bindings`'s own documented convention (GL
    /// itself has an independent binding point per unit *per target type*, not one
    /// binding per unit).
    texture_cube_bindings: Vec<Option<u32>>,
    /// `GL_TEXTURE_2D_ARRAY`'s own per-unit binding array - same convention as
    /// `texture_cube_bindings` above.
    texture_2d_array_bindings: Vec<Option<u32>>,
    /// `GL_TEXTURE_3D`'s own per-unit binding array - same convention as
    /// `texture_cube_bindings` above.
    texture_3d_bindings: Vec<Option<u32>>,
    /// `GL_TEXTURE_CUBE_MAP_ARRAY`'s own per-unit binding array - same convention as
    /// `texture_cube_bindings` above.
    texture_cube_array_bindings: Vec<Option<u32>>,
    /// `GL_TEXTURE_BUFFER`'s own per-unit binding array - same convention as
    /// `texture_cube_bindings` above.
    texture_buffer_bindings: Vec<Option<u32>>,
    active_texture_unit: u32,

    /// `m_pixelUnpackAlignment`/`m_pixelPackAlignment` (`GL_UNPACK_ALIGNMENT`/
    /// `GL_PACK_ALIGNMENT`, default 4) and `m_pixelUnpackRowLength`/`SkipRows`/
    /// `SkipPixels` (`GL_UNPACK_ROW_LENGTH`/`_SKIP_ROWS`/`_SKIP_PIXELS`, default 0 -
    /// "use the image's own width"/"no skip"), read by `tex_image_2d`/
    /// `tex_sub_image_2d` below (`unpack_2d_access`). `GL_UNPACK_IMAGE_HEIGHT`/
    /// `_SKIP_IMAGES` (upstream's `getUnpack3DAccess`) are the `tex_image_3d`/
    /// `tex_sub_image_3d` analogues, read by `unpack_3d_access` below - not ported
    /// until `Texture2DArray` existed to need them.
    /// `pixel_pack_alignment` is validated and stored for `glPixelStorei`'s own error
    /// checking but not read by anything: `Context::read_pixels`'s destination
    /// (`tcu::Surface`) is always tightly packed RGBA8, so a pack alignment has
    /// nothing to apply to.
    pixel_unpack_alignment: i32,
    pixel_pack_alignment: i32,
    pixel_unpack_row_length: i32,
    pixel_unpack_skip_rows: i32,
    pixel_unpack_skip_pixels: i32,
    pixel_unpack_image_height: i32,
    pixel_unpack_skip_images: i32,

    framebuffers: ObjectManager<Framebuffer>,
    draw_framebuffer_binding: Option<u32>,
    read_framebuffer_binding: Option<u32>,
    /// The "current" generic vertex attribute value a disabled attribute reads -
    /// `m_currentAttribs` upstream. No setter yet; see this module's top doc comment.
    current_attribs: Vec<GenericVec4>,

    viewport: WindowRectangle,
    subpixel_bits: i32,
    /// `m_limits.extensionStr` - upstream's `ReferenceContextLimits` constructor
    /// (`sglrReferenceContext.cpp`, ~line 316-326) queries a real `glu::RenderContext`
    /// for its context-type-dependent limits and then hardcodes this list of extension
    /// strings onto it (`GL_EXT_texture_cube_map_array` only for an ES 3.1+ context).
    /// This port's `ReferenceContext::new` takes no `glu::RenderContext`/context-version
    /// parameter at all (see this module's own top doc comment), so there is nothing to
    /// gate the ES 3.1-only extension on - `extensions` below always holds exactly the
    /// three unconditional ones. Narrower than upstream on a 3.1+ context, never wider.
    extensions: String,
    clear_color: [f32; 4],
    /// `m_clearDepth`/`m_clearStencil` - no setter existed before the `sglr::Context`
    /// trait needed `clearDepthf`/`clearStencil` (see `Context::clear_depthf`/
    /// `clear_stencil` below); `clear` used to hardcode GL's own defaults (1.0/0)
    /// since nothing could ever change them.
    clear_depth: f32,
    clear_stencil: i32,

    /// Stands in for upstream's default framebuffer - see this module's top doc
    /// comment for why there is no real framebuffer-object support yet.
    color_buffer: TextureLevel,
    depth_buffer: Option<TextureLevel>,
    /// The default framebuffer's stencil plane (`ReferenceContextBuffers`' stencil buffer), if the render target has one.
    stencil_buffer: Option<TextureLevel>,

    // --- Fixed-function-adjacent state (`rr::RenderState`'s GL-side source) ---
    scissor_enabled: bool,
    scissor_box: (i32, i32, i32, i32),
    blend_enabled: bool,
    depth_test_enabled: bool,
    stencil_test_enabled: bool,
    polygon_offset_fill_enabled: bool,
    primitive_restart_fixed_index: bool,

    depth_func: GLenum,
    depth_range: (f32, f32),
    depth_mask: bool,

    polygon_offset_factor: f32,
    polygon_offset_units: f32,

    blend_mode_rgb: GLenum,
    blend_mode_alpha: GLenum,
    blend_factor_src_rgb: GLenum,
    blend_factor_dst_rgb: GLenum,
    blend_factor_src_alpha: GLenum,
    blend_factor_dst_alpha: GLenum,
    blend_color: [f32; 4],

    color_mask: [bool; 4],
    /// Indexed by `rr::render_state::FaceType`.
    stencil: [StencilFaceState; 2],

    line_width: f32,
}

/// `rc::ShaderProgramObjectContainer`. Two shapes share one object-name space (one
/// `programs: ObjectManager<ProgramObject>`, so `createProgram`/`useProgram` work
/// identically regardless of which a caller used to create the program):
///  - `Plain` - a bare `rr::VertexShader` + `rr::FragmentShader` pair with no uniform
///    slots, the original shape this port's `create_program` has always taken (a
///    concrete shader struct closes over whatever values it needs at construction
///    time - see this module's top doc comment's "program objects" bullet).
///  - `Declared` - a `sglr::ShaderProgram` (see `shader_program.rs`), whose uniform
///    slots `Context::uniform4fv`/`get_uniform_location` (below) can read and
///    overwrite by name *after* the program was created, which `Plain` has no slots
///    to support. `sglr::Context::create_program` always produces this shape.
enum ProgramObject {
    Plain {
        vertex_shader: Box<dyn VertexShader>,
        fragment_shader: Box<dyn FragmentShader>,
    },
    Declared(Box<dyn ShaderProgram>),
}

impl ProgramObject {
    fn vertex_shader(&self) -> &dyn VertexShader {
        match self {
            Self::Plain { vertex_shader, .. } => vertex_shader.as_ref(),
            // Trait upcasting (`&dyn ShaderProgram` -> `&dyn VertexShader`, stable
            // since Rust 1.86 - see `shader_program.rs`'s own doc comment on why
            // `ShaderProgram` is declared object-safe for exactly this).
            Self::Declared(program) => program.as_ref(),
        }
    }

    fn fragment_shader(&self) -> &dyn FragmentShader {
        match self {
            Self::Plain { fragment_shader, .. } => fragment_shader.as_ref(),
            Self::Declared(program) => program.as_ref(),
        }
    }

    /// `None` for a `Plain` program - it has no uniform slots/attribute-name table to
    /// look anything up in, matching upstream's own shape (a plain
    /// `rr::VertexShader`/`FragmentShader` pair was never constructed from a
    /// `pdec::ShaderProgramDeclaration` to begin with).
    fn declared(&self) -> Option<&dyn ShaderProgram> {
        match self {
            Self::Plain { .. } => None,
            Self::Declared(program) => Some(program.as_ref()),
        }
    }

    fn declared_mut(&mut self) -> Option<&mut dyn ShaderProgram> {
        match self {
            Self::Plain { .. } => None,
            Self::Declared(program) => Some(program.as_mut()),
        }
    }
}

/// `m_stencil[rr::FaceType]` - stored as the raw `GLenum`s GL exposes, mapped to
/// `rr::render_state` types only at draw time in `draw_with_reference` (same split
/// `m_depthFunc`/`m_blendModeRGB`/... use upstream).
#[derive(Debug, Clone, Copy)]
struct StencilFaceState {
    func: GLenum,
    ref_: i32,
    op_mask: u32,
    write_mask: u32,
    op_stencil_fail: GLenum,
    op_depth_fail: GLenum,
    op_depth_pass: GLenum,
}

impl Default for StencilFaceState {
    fn default() -> Self {
        Self {
            func: glw::GL_ALWAYS,
            ref_: 0,
            op_mask: !0,
            write_mask: !0,
            op_stencil_fail: glw::GL_KEEP,
            op_depth_fail: glw::GL_KEEP,
            op_depth_pass: glw::GL_KEEP,
        }
    }
}

impl ReferenceContext {
    /// `ReferenceContextLimits::maxTextureImageUnits`, which upstream reads off the real context.
    pub fn set_max_texture_image_units(&mut self, units: usize) {
        for bindings in [
            &mut self.texture_2d_bindings,
            &mut self.texture_cube_bindings,
            &mut self.texture_2d_array_bindings,
            &mut self.texture_3d_bindings,
            &mut self.texture_cube_array_bindings,
            &mut self.texture_buffer_bindings,
        ] {
            bindings.resize(units, None);
        }
    }

    /// Gives the default framebuffer a stencil plane.
    pub fn with_stencil_buffer(mut self, stencil_buffer: TextureLevel) -> Self {
        self.stencil_buffer = Some(stencil_buffer);
        self
    }

    pub fn new(
        max_vertex_attribs: usize,
        color_buffer: TextureLevel,
        depth_buffer: Option<TextureLevel>,
        subpixel_bits: i32,
    ) -> Self {
        let size = color_buffer.size();
        Self {
            max_vertex_attribs,
            last_error: glw::GL_NO_ERROR,
            buffers: ObjectManager::new(),
            array_buffer_binding: None,
            copy_read_buffer_binding: None,
            copy_write_buffer_binding: None,
            draw_indirect_buffer_binding: None,
            pixel_pack_buffer_binding: None,
            pixel_unpack_buffer_binding: None,
            transform_feedback_buffer_binding: None,
            uniform_buffer_binding: None,
            vertex_arrays: ObjectManager::new(),
            vertex_array_binding: None,
            client_vertex_array: VertexArray::new(max_vertex_attribs),
            programs: ObjectManager::new(),
            current_program: None,

            renderbuffers: ObjectManager::new(),
            renderbuffer_binding: None,

            textures: ObjectManager::new(),
            // `ReferenceContextLimits::maxTextureImageUnits`'s own default.
            texture_2d_bindings: vec![None; 16],
            texture_cube_bindings: vec![None; 16],
            texture_2d_array_bindings: vec![None; 16],
            texture_3d_bindings: vec![None; 16],
            texture_cube_array_bindings: vec![None; 16],
            texture_buffer_bindings: vec![None; 16],
            active_texture_unit: 0,

            pixel_unpack_alignment: 4,
            pixel_pack_alignment: 4,
            pixel_unpack_row_length: 0,
            pixel_unpack_skip_rows: 0,
            pixel_unpack_skip_pixels: 0,
            pixel_unpack_image_height: 0,
            pixel_unpack_skip_images: 0,

            framebuffers: ObjectManager::new(),
            draw_framebuffer_binding: None,
            read_framebuffer_binding: None,
            current_attribs: vec![GenericVec4::from_float(Vec4::new(0.0, 0.0, 0.0, 1.0)); max_vertex_attribs],
            viewport: WindowRectangle {
                left: 0,
                bottom: 0,
                width: size[0] as i32,
                height: size[1] as i32,
            },
            subpixel_bits,
            extensions: [
                "GL_EXT_color_buffer_half_float",
                "GL_EXT_color_buffer_float",
                "GL_EXT_texture_format_BGRA8888",
            ]
            .join(" "),
            clear_color: [0.0, 0.0, 0.0, 0.0],
            clear_depth: 1.0,
            clear_stencil: 0,
            color_buffer,
            depth_buffer,
            stencil_buffer: None,

            scissor_enabled: false,
            scissor_box: (0, 0, size[0] as i32, size[1] as i32),
            blend_enabled: false,
            depth_test_enabled: false,
            stencil_test_enabled: false,
            polygon_offset_fill_enabled: false,
            primitive_restart_fixed_index: false,

            depth_func: glw::GL_LESS,
            depth_range: (0.0, 1.0),
            depth_mask: true,

            polygon_offset_factor: 0.0,
            polygon_offset_units: 0.0,

            blend_mode_rgb: glw::GL_FUNC_ADD,
            blend_mode_alpha: glw::GL_FUNC_ADD,
            blend_factor_src_rgb: glw::GL_ONE,
            blend_factor_dst_rgb: glw::GL_ZERO,
            blend_factor_src_alpha: glw::GL_ONE,
            blend_factor_dst_alpha: glw::GL_ZERO,
            blend_color: [0.0, 0.0, 0.0, 0.0],

            color_mask: [true, true, true, true],
            stencil: [StencilFaceState::default(), StencilFaceState::default()],

            line_width: 1.0,
        }
    }

    /// `ReferenceContext::setError`
    fn set_error(&mut self, error: GLenum) {
        if self.last_error == glw::GL_NO_ERROR {
            self.last_error = error;
        }
    }

    /// `ReferenceContext::getError`
    pub fn get_error(&mut self) -> GLenum {
        let error = self.last_error;
        self.last_error = glw::GL_NO_ERROR;
        error
    }

    /// `ReferenceContext::getString` - `GL_EXTENSIONS` only, matching upstream's own
    /// `switch` (its `default` case also sets `GL_INVALID_ENUM`). See `extensions`'s
    /// own doc comment for what this list always contains and why.
    pub fn get_string(&mut self, pname: GLenum) -> Option<String> {
        match pname {
            glw::GL_EXTENSIONS => Some(self.extensions.clone()),
            _ => {
                self.set_error(glw::GL_INVALID_ENUM);
                None
            }
        }
    }

    // --- Buffer objects ---

    fn buffer_binding_point(&mut self, target: GLenum) -> &mut Option<u32> {
        let vao_binding = self.vertex_array_binding;
        match target {
            glw::GL_ARRAY_BUFFER => &mut self.array_buffer_binding,
            glw::GL_COPY_READ_BUFFER => &mut self.copy_read_buffer_binding,
            glw::GL_COPY_WRITE_BUFFER => &mut self.copy_write_buffer_binding,
            glw::GL_DRAW_INDIRECT_BUFFER => &mut self.draw_indirect_buffer_binding,
            glw::GL_ELEMENT_ARRAY_BUFFER => {
                if let Some(name) = vao_binding {
                    &mut self
                        .vertex_arrays
                        .find_mut(name)
                        .expect("bound VAO must exist")
                        .element_array_buffer_binding
                } else {
                    &mut self.client_vertex_array.element_array_buffer_binding
                }
            }
            glw::GL_PIXEL_PACK_BUFFER => &mut self.pixel_pack_buffer_binding,
            glw::GL_PIXEL_UNPACK_BUFFER => &mut self.pixel_unpack_buffer_binding,
            glw::GL_TRANSFORM_FEEDBACK_BUFFER => &mut self.transform_feedback_buffer_binding,
            glw::GL_UNIFORM_BUFFER => &mut self.uniform_buffer_binding,
            _ => unreachable!("is_valid_buffer_target should have been checked first"),
        }
    }

    /// `ReferenceContext::getBufferBinding`
    pub fn get_buffer_binding(&self, target: GLenum) -> Option<u32> {
        let vao = self
            .vertex_array_binding
            .map(|n| self.vertex_arrays.find(n).expect("bound VAO must exist"))
            .unwrap_or(&self.client_vertex_array);
        match target {
            glw::GL_ARRAY_BUFFER => self.array_buffer_binding,
            glw::GL_COPY_READ_BUFFER => self.copy_read_buffer_binding,
            glw::GL_COPY_WRITE_BUFFER => self.copy_write_buffer_binding,
            glw::GL_DRAW_INDIRECT_BUFFER => self.draw_indirect_buffer_binding,
            glw::GL_ELEMENT_ARRAY_BUFFER => vao.element_array_buffer_binding,
            glw::GL_PIXEL_PACK_BUFFER => self.pixel_pack_buffer_binding,
            glw::GL_PIXEL_UNPACK_BUFFER => self.pixel_unpack_buffer_binding,
            glw::GL_TRANSFORM_FEEDBACK_BUFFER => self.transform_feedback_buffer_binding,
            glw::GL_UNIFORM_BUFFER => self.uniform_buffer_binding,
            _ => unreachable!("is_valid_buffer_target should have been checked first"),
        }
    }

    /// `ReferenceContext::setBufferBinding`
    fn set_buffer_binding(&mut self, target: GLenum, buffer: Option<u32>) {
        let old = *self.buffer_binding_point(target);
        if let Some(old_name) = old {
            self.buffers.release_reference(old_name);
        }
        if let Some(name) = buffer {
            self.buffers.acquire_reference(name);
        }
        *self.buffer_binding_point(target) = buffer;
    }

    /// `ReferenceContext::bindBuffer`
    pub fn bind_buffer(&mut self, target: GLenum, buffer: u32) {
        if !is_valid_buffer_target(target) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }

        let buf_name = if buffer != 0 {
            if self.buffers.find(buffer).is_none() {
                self.buffers.insert(buffer, DataBuffer::default());
            }
            Some(buffer)
        } else {
            None
        };

        self.set_buffer_binding(target, buf_name);
    }

    /// `ReferenceContext::genBuffers`
    pub fn gen_buffers(&mut self, out: &mut [u32]) {
        for slot in out.iter_mut() {
            *slot = self.buffers.allocate_name();
        }
    }

    /// `ReferenceContext::deleteBuffer`
    fn delete_buffer(&mut self, name: u32) {
        const BINDING_POINTS: [GLenum; 9] = [
            glw::GL_ARRAY_BUFFER,
            glw::GL_COPY_READ_BUFFER,
            glw::GL_COPY_WRITE_BUFFER,
            glw::GL_DRAW_INDIRECT_BUFFER,
            glw::GL_ELEMENT_ARRAY_BUFFER,
            glw::GL_PIXEL_PACK_BUFFER,
            glw::GL_PIXEL_UNPACK_BUFFER,
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            glw::GL_UNIFORM_BUFFER,
        ];

        for &target in &BINDING_POINTS {
            if self.get_buffer_binding(target) == Some(name) {
                self.set_buffer_binding(target, None);
            }
        }

        let mut vao_names = self.vertex_arrays.names();
        vao_names.push(0); // stand-in for the client vertex array, handled below

        for vao_name in vao_names {
            // Borrow the VAO (or the client one) by name each iteration, so the
            // `release_reference` calls below never alias a live `&mut VertexArray`.
            let touches_element_binding;
            let mut touched_attribs = Vec::new();
            {
                let vao = if vao_name == 0 {
                    &mut self.client_vertex_array
                } else {
                    self.vertex_arrays
                        .find_mut(vao_name)
                        .expect("name just came from vertex_arrays.names()")
                };

                touches_element_binding = vao.element_array_buffer_binding == Some(name);
                if touches_element_binding {
                    vao.element_array_buffer_binding = None;
                }

                for (ndx, attrib) in vao.arrays.iter_mut().enumerate() {
                    if attrib.buffer_binding == Some(name) {
                        attrib.buffer_deleted = true;
                        attrib.buffer_binding = None;
                        touched_attribs.push(ndx);
                    }
                }
            }

            if touches_element_binding {
                self.buffers.release_reference(name);
            }
            for _ in &touched_attribs {
                self.buffers.release_reference(name);
            }
        }

        debug_assert_eq!(self.buffers.ref_count(name), Some(1));
        self.buffers.release_reference(name);
    }

    /// `ReferenceContext::deleteBuffers`
    pub fn delete_buffers(&mut self, names: &[u32]) {
        for &name in names {
            if name != 0 && self.buffers.find(name).is_some() {
                self.delete_buffer(name);
            }
        }
    }

    /// `ReferenceContext::bufferData`
    pub fn buffer_data(&mut self, target: GLenum, size: isize, data: Option<&[u8]>) {
        if !is_valid_buffer_target(target) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if size < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }

        let Some(buf_name) = self.get_buffer_binding(target) else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };

        let buffer = self.buffers.find_mut(buf_name).expect("bound buffer must exist");
        buffer.set_storage(size as usize);
        if let Some(data) = data {
            buffer.data_mut()[..data.len().min(size as usize)].copy_from_slice(&data[..data.len().min(size as usize)]);
        }
    }

    /// `ReferenceContext::bufferSubData`
    pub fn buffer_sub_data(&mut self, target: GLenum, offset: isize, data: &[u8]) {
        if !is_valid_buffer_target(target) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if offset < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }

        let Some(buf_name) = self.get_buffer_binding(target) else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };

        let buffer = self.buffers.find_mut(buf_name).expect("bound buffer must exist");
        if offset as usize + data.len() > buffer.size() {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }

        buffer.data_mut()[offset as usize..offset as usize + data.len()].copy_from_slice(data);
    }

    // --- Vertex array objects ---

    /// `ReferenceContext::bindVertexArray`
    pub fn bind_vertex_array(&mut self, array: u32) {
        let new_binding = if array != 0 {
            if self.vertex_arrays.find(array).is_none() {
                self.vertex_arrays
                    .insert(array, VertexArray::new(self.max_vertex_attribs));
            }
            Some(array)
        } else {
            None
        };

        if let Some(name) = new_binding {
            self.vertex_arrays.acquire_reference(name);
        }
        if let Some(old) = self.vertex_array_binding {
            self.vertex_arrays.release_reference(old);
        }

        self.vertex_array_binding = new_binding;
    }

    /// `ReferenceContext::genVertexArrays`
    pub fn gen_vertex_arrays(&mut self, out: &mut [u32]) {
        for slot in out.iter_mut() {
            *slot = self.vertex_arrays.allocate_name();
        }
    }

    /// `ReferenceContext::deleteVertexArray`
    fn delete_vertex_array(&mut self, name: u32) {
        if self.vertex_array_binding == Some(name) {
            self.bind_vertex_array(0);
        }

        let (element_binding, attrib_bindings) = {
            let vao = self.vertex_arrays.find(name).expect("name must exist");
            (
                vao.element_array_buffer_binding,
                vao.arrays.iter().filter_map(|a| a.buffer_binding).collect::<Vec<_>>(),
            )
        };

        if let Some(buf) = element_binding {
            self.buffers.release_reference(buf);
        }
        for buf in attrib_bindings {
            self.buffers.release_reference(buf);
        }

        debug_assert_eq!(self.vertex_arrays.ref_count(name), Some(1));
        self.vertex_arrays.release_reference(name);
    }

    /// `ReferenceContext::deleteVertexArrays`
    pub fn delete_vertex_arrays(&mut self, names: &[u32]) {
        for &name in names {
            if name != 0 && self.vertex_arrays.find(name).is_some() {
                self.delete_vertex_array(name);
            }
        }
    }

    fn current_vao_mut(&mut self) -> &mut VertexArray {
        match self.vertex_array_binding {
            Some(name) => self.vertex_arrays.find_mut(name).expect("bound VAO must exist"),
            None => &mut self.client_vertex_array,
        }
    }

    /// `ReferenceContext::vertexAttribPointer` - ES-only, so the `GL_BGRA`/non-ES
    /// branches are dropped; see this module's top doc comment.
    #[allow(clippy::too_many_arguments)]
    pub fn vertex_attrib_pointer(
        &mut self,
        index: u32,
        size: i32,
        type_: GLenum,
        normalized: bool,
        stride: i32,
        pointer: usize,
        has_pointer: bool,
    ) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        if !(1..=4).contains(&size) {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let valid_type = matches!(
            type_,
            glw::GL_BYTE
                | glw::GL_UNSIGNED_BYTE
                | glw::GL_SHORT
                | glw::GL_UNSIGNED_SHORT
                | glw::GL_INT
                | glw::GL_UNSIGNED_INT
                | glw::GL_FIXED
                | glw::GL_FLOAT
                | glw::GL_HALF_FLOAT
                | glw::GL_INT_2_10_10_10_REV
                | glw::GL_UNSIGNED_INT_2_10_10_10_REV
        );
        if !valid_type {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if stride < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        if (type_ == glw::GL_INT_2_10_10_10_REV || type_ == glw::GL_UNSIGNED_INT_2_10_10_10_REV) && size != 4 {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }
        if self.vertex_array_binding.is_some() && self.array_buffer_binding.is_none() && has_pointer {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }

        let array_buffer_binding = self.array_buffer_binding;
        let previous_binding = {
            let vao = self.current_vao_mut();
            let attrib = &mut vao.arrays[index as usize];

            let previous_binding = attrib.buffer_binding;

            attrib.size = size;
            attrib.stride = stride;
            attrib.type_ = type_;
            attrib.normalized = normalized;
            attrib.integer = false;
            attrib.pointer = pointer;
            attrib.buffer_deleted = false;
            attrib.buffer_binding = array_buffer_binding;

            previous_binding
        };

        // acquire new reference, release old one - done after the `vao` borrow above
        // ends, since both calls need `&mut self.buffers`.
        if let Some(name) = array_buffer_binding {
            self.buffers.acquire_reference(name);
        }
        if let Some(old) = previous_binding {
            self.buffers.release_reference(old);
        }
    }

    /// `ReferenceContext::vertexAttribIPointer`
    pub fn vertex_attrib_i_pointer(
        &mut self,
        index: u32,
        size: i32,
        type_: GLenum,
        stride: i32,
        pointer: usize,
        has_pointer: bool,
    ) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        if !(1..=4).contains(&size) {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let valid_type = matches!(
            type_,
            glw::GL_BYTE
                | glw::GL_UNSIGNED_BYTE
                | glw::GL_SHORT
                | glw::GL_UNSIGNED_SHORT
                | glw::GL_INT
                | glw::GL_UNSIGNED_INT
        );
        if !valid_type {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if stride < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        if self.vertex_array_binding.is_some() && self.array_buffer_binding.is_none() && has_pointer {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }

        let array_buffer_binding = self.array_buffer_binding;
        let previous_binding = {
            let vao = self.current_vao_mut();
            let attrib = &mut vao.arrays[index as usize];

            let previous_binding = attrib.buffer_binding;

            attrib.size = size;
            attrib.stride = stride;
            attrib.type_ = type_;
            attrib.normalized = false;
            attrib.integer = true;
            attrib.pointer = pointer;
            attrib.buffer_deleted = false;
            attrib.buffer_binding = array_buffer_binding;

            previous_binding
        };

        if let Some(name) = array_buffer_binding {
            self.buffers.acquire_reference(name);
        }
        if let Some(old) = previous_binding {
            self.buffers.release_reference(old);
        }
    }

    /// `ReferenceContext::enableVertexAttribArray`
    pub fn enable_vertex_attrib_array(&mut self, index: u32) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.current_vao_mut().arrays[index as usize].enabled = true;
    }

    /// `ReferenceContext::disableVertexAttribArray`
    pub fn disable_vertex_attrib_array(&mut self, index: u32) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.current_vao_mut().arrays[index as usize].enabled = false;
    }

    /// `ReferenceContext::vertexAttribDivisor`
    pub fn vertex_attrib_divisor(&mut self, index: u32, divisor: u32) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.current_vao_mut().arrays[index as usize].divisor = divisor;
    }

    /// `ReferenceContext::vertexAttrib1f` - sets the "current" generic value a *disabled*
    /// vertex attribute array reads during a draw (`build_vertex_attribs` below), GL's own
    /// default being `(0, 0, 0, 1)`. Unspecified trailing components are always `(0, 0, 1)`
    /// regardless of how many of x/y/z/w the call actually names - matching upstream, which
    /// never reads back whatever the previous value held there.
    pub fn vertex_attrib1f(&mut self, index: u32, x: f32) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.current_attribs[index as usize] = GenericVec4::from_float(Vec4::new(x, 0.0, 0.0, 1.0));
    }

    /// `ReferenceContext::vertexAttrib2f`
    pub fn vertex_attrib2f(&mut self, index: u32, x: f32, y: f32) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.current_attribs[index as usize] = GenericVec4::from_float(Vec4::new(x, y, 0.0, 1.0));
    }

    /// `ReferenceContext::vertexAttrib3f`
    pub fn vertex_attrib3f(&mut self, index: u32, x: f32, y: f32, z: f32) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.current_attribs[index as usize] = GenericVec4::from_float(Vec4::new(x, y, z, 1.0));
    }

    /// `ReferenceContext::vertexAttrib4f`
    pub fn vertex_attrib4f(&mut self, index: u32, x: f32, y: f32, z: f32, w: f32) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.current_attribs[index as usize] = GenericVec4::from_float(Vec4::new(x, y, z, w));
    }

    /// `ReferenceContext::vertexAttribI4i`
    pub fn vertex_attrib_i4i(&mut self, index: u32, x: i32, y: i32, z: i32, w: i32) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.current_attribs[index as usize] = GenericVec4::from_int(IVec4::new(x, y, z, w));
    }

    /// `ReferenceContext::vertexAttribI4ui`
    pub fn vertex_attrib_i4ui(&mut self, index: u32, x: u32, y: u32, z: u32, w: u32) {
        if index as usize >= self.max_vertex_attribs {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.current_attribs[index as usize] = GenericVec4::from_uint(UVec4::new(x, y, z, w));
    }

    // --- Inspection helpers for tests (and, later, getFramebufferAttachmentParameteriv-style queries) ---

    pub fn current_vertex_array_binding(&self) -> Option<u32> {
        self.vertex_array_binding
    }

    /// The "current" generic vertex attribute value `vertex_attrib{1,2,3,4}f`/
    /// `vertex_attrib_i4{i,ui}` set and a disabled attribute array reads at draw time -
    /// `build_vertex_attribs`' own `current_attribs[ndx]` read, exposed read-only here
    /// so a unit test can check the setter alone without needing a whole draw call.
    pub fn current_attrib(&self, index: u32) -> GenericVec4 {
        self.current_attribs[index as usize]
    }

    pub fn buffer(&self, name: u32) -> Option<&DataBuffer> {
        self.buffers.find(name)
    }

    pub fn vertex_array(&self, name: u32) -> Option<&VertexArray> {
        self.vertex_arrays.find(name)
    }

    pub fn client_vertex_array(&self) -> &VertexArray {
        &self.client_vertex_array
    }

    // --- Renderbuffer objects ---

    /// `ReferenceContext::bindRenderbuffer`
    pub fn bind_renderbuffer(&mut self, target: GLenum, name: u32) {
        if target != glw::GL_RENDERBUFFER {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }

        let new_binding = if name != 0 {
            if self.renderbuffers.find(name).is_none() {
                self.renderbuffers.insert(name, Renderbuffer::default());
            }
            Some(name)
        } else {
            None
        };

        if let Some(old) = self.renderbuffer_binding {
            self.renderbuffers.release_reference(old);
        }
        if let Some(n) = new_binding {
            self.renderbuffers.acquire_reference(n);
        }
        self.renderbuffer_binding = new_binding;
    }

    /// `ReferenceContext::genRenderbuffers`
    pub fn gen_renderbuffers(&mut self, out: &mut [u32]) {
        for slot in out.iter_mut() {
            *slot = self.renderbuffers.allocate_name();
        }
    }

    /// `ReferenceContext::renderbufferStorage`
    pub fn renderbuffer_storage(&mut self, target: GLenum, internalformat: GLenum, width: i32, height: i32) {
        if target != glw::GL_RENDERBUFFER {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        let Some(format) = super::reference_utils::map_gl_internal_format(internalformat) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        if width < 0 || height < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let Some(binding) = self.renderbuffer_binding else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };

        let rbo = self
            .renderbuffers
            .find_mut(binding)
            .expect("bound renderbuffer must exist");
        if rbo.set_storage(format, width as u32, height as u32).is_err() {
            self.set_error(glw::GL_INVALID_OPERATION);
        }
    }

    /// `ReferenceContext::deleteRenderbuffer`
    fn delete_renderbuffer(&mut self, name: u32) {
        if self.renderbuffer_binding == Some(name) {
            self.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        }

        // Detach from every framebuffer that currently references it - both binding
        // points if the same FBO happens to be bound to both (matching upstream's own
        // `releaseRefCount` doubling in that case).
        let fbo_names = self.framebuffers.names();
        for fbo_name in fbo_names {
            let extra_refs = (self.draw_framebuffer_binding == Some(fbo_name)) as u32
                + (self.read_framebuffer_binding == Some(fbo_name)) as u32;
            if extra_refs == 0 {
                continue;
            }
            let fbo = self
                .framebuffers
                .find_mut(fbo_name)
                .expect("name just came from framebuffers.names()");
            for point in ATTACHMENT_POINTS {
                if fbo.attachment(point) == Some(FboAttachment::Renderbuffer(name)) {
                    fbo.attachments[point as usize] = None;
                    for _ in 0..extra_refs {
                        self.renderbuffers.release_reference(name);
                    }
                }
            }
        }

        debug_assert_eq!(self.renderbuffers.ref_count(name), Some(1));
        self.renderbuffers.release_reference(name);
    }

    /// `ReferenceContext::deleteRenderbuffers`
    pub fn delete_renderbuffers(&mut self, names: &[u32]) {
        for &name in names {
            if name != 0 && self.renderbuffers.find(name).is_some() {
                self.delete_renderbuffer(name);
            }
        }
    }

    pub fn renderbuffer(&self, name: u32) -> Option<&Renderbuffer> {
        self.renderbuffers.find(name)
    }

    // --- Framebuffer objects ---

    fn is_valid_framebuffer_target(target: GLenum) -> bool {
        matches!(
            target,
            glw::GL_FRAMEBUFFER | glw::GL_DRAW_FRAMEBUFFER | glw::GL_READ_FRAMEBUFFER
        )
    }

    /// `ReferenceContext::bindFramebuffer`
    pub fn bind_framebuffer(&mut self, target: GLenum, name: u32) {
        if !Self::is_valid_framebuffer_target(target) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }

        let new_binding = if name != 0 {
            if self.framebuffers.find(name).is_none() {
                self.framebuffers.insert(name, Framebuffer::default());
            }
            Some(name)
        } else {
            None
        };

        // Upstream's `releaseFboAttachmentReference`/`acquireFboAttachmentReference`
        // bump each attached renderbuffer's refcount once per *binding point* (draw,
        // read) an FBO occupies - this loop does the same, once per target actually
        // rebound below.
        let targets: &[(GLenum, bool)] = &[(glw::GL_READ_FRAMEBUFFER, false), (glw::GL_DRAW_FRAMEBUFFER, true)];
        for &(binding_target, is_draw) in targets {
            if target != glw::GL_FRAMEBUFFER && target != binding_target {
                continue;
            }

            let old_binding = if is_draw {
                self.draw_framebuffer_binding
            } else {
                self.read_framebuffer_binding
            };
            if let Some(old) = old_binding {
                let attached: Vec<FboAttachment> = {
                    let fbo = self.framebuffers.find(old).expect("bound FBO must exist");
                    ATTACHMENT_POINTS.iter().filter_map(|&p| fbo.attachment(p)).collect()
                };
                for att in attached {
                    release_fbo_attachment_reference(att, &mut self.renderbuffers, &mut self.textures);
                }
                self.framebuffers.release_reference(old);
            }

            if let Some(n) = new_binding {
                self.framebuffers.acquire_reference(n);
                let attached: Vec<FboAttachment> = {
                    let fbo = self.framebuffers.find(n).expect("just inserted or found");
                    ATTACHMENT_POINTS.iter().filter_map(|&p| fbo.attachment(p)).collect()
                };
                for att in attached {
                    acquire_fbo_attachment_reference(att, &mut self.renderbuffers, &mut self.textures);
                }
            }

            if is_draw {
                self.draw_framebuffer_binding = new_binding;
            } else {
                self.read_framebuffer_binding = new_binding;
            }
        }
    }

    /// `ReferenceContext::genFramebuffers`
    pub fn gen_framebuffers(&mut self, out: &mut [u32]) {
        for slot in out.iter_mut() {
            *slot = self.framebuffers.allocate_name();
        }
    }

    /// `ReferenceContext::deleteFramebuffer`
    fn delete_framebuffer(&mut self, name: u32) {
        if self.draw_framebuffer_binding == Some(name) {
            self.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
        }
        if self.read_framebuffer_binding == Some(name) {
            self.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);
        }

        debug_assert_eq!(self.framebuffers.ref_count(name), Some(1));
        self.framebuffers.release_reference(name);
    }

    /// `ReferenceContext::deleteFramebuffers`
    pub fn delete_framebuffers(&mut self, names: &[u32]) {
        for &name in names {
            if name != 0 && self.framebuffers.find(name).is_some() {
                self.delete_framebuffer(name);
            }
        }
    }

    fn map_gl_attachment_point(attachment: GLenum) -> Option<AttachmentPoint> {
        match attachment {
            glw::GL_COLOR_ATTACHMENT0 => Some(AttachmentPoint::Color0),
            glw::GL_DEPTH_ATTACHMENT => Some(AttachmentPoint::Depth),
            glw::GL_STENCIL_ATTACHMENT => Some(AttachmentPoint::Stencil),
            _ => None,
        }
    }

    /// `ReferenceContext::framebufferRenderbuffer` - narrowed to renderbuffer
    /// attachments; see this module's top doc comment.
    pub fn framebuffer_renderbuffer(
        &mut self,
        target: GLenum,
        attachment: GLenum,
        renderbuffertarget: GLenum,
        renderbuffer: u32,
    ) {
        if attachment == glw::GL_DEPTH_STENCIL_ATTACHMENT {
            self.framebuffer_renderbuffer(target, glw::GL_DEPTH_ATTACHMENT, renderbuffertarget, renderbuffer);
            self.framebuffer_renderbuffer(target, glw::GL_STENCIL_ATTACHMENT, renderbuffertarget, renderbuffer);
            return;
        }

        if !Self::is_valid_framebuffer_target(target) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        let Some(point) = Self::map_gl_attachment_point(attachment) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };

        let is_draw = target == glw::GL_FRAMEBUFFER || target == glw::GL_DRAW_FRAMEBUFFER;
        let binding = if is_draw {
            self.draw_framebuffer_binding
        } else {
            self.read_framebuffer_binding
        };
        let Some(fbo_name) = binding else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };

        // If the same FBO is bound to both the draw and read targets, both references
        // must be released/acquired together - matching upstream's `bindingRefCount`.
        let ref_count = (self.draw_framebuffer_binding == Some(fbo_name)) as u32
            + (self.read_framebuffer_binding == Some(fbo_name)) as u32;

        let rb_name = if renderbuffer != 0 {
            if renderbuffertarget != glw::GL_RENDERBUFFER {
                self.set_error(glw::GL_INVALID_ENUM);
                return;
            }
            if self.renderbuffers.find(renderbuffer).is_none() {
                self.set_error(glw::GL_INVALID_OPERATION);
                return;
            }
            Some(renderbuffer)
        } else {
            None
        };

        let old = {
            let fbo = self.framebuffers.find_mut(fbo_name).expect("bound FBO must exist");
            let old = fbo.attachment(point);
            fbo.attachments[point as usize] = rb_name.map(FboAttachment::Renderbuffer);
            old
        };

        if let Some(old_att) = old {
            for _ in 0..ref_count {
                release_fbo_attachment_reference(old_att, &mut self.renderbuffers, &mut self.textures);
            }
        }
        if let Some(new_rb) = rb_name {
            for _ in 0..ref_count {
                self.renderbuffers.acquire_reference(new_rb);
            }
        }
    }

    /// `ReferenceContext::framebufferTexture2D`, narrowed to `GL_TEXTURE_2D` and the six
    /// `GL_TEXTURE_CUBE_MAP_POSITIVE_X..NEGATIVE_Z` face targets - real GL (and
    /// upstream) never accepts a `GL_TEXTURE_2D_ARRAY`/`_3D`/`_CUBE_MAP_ARRAY` texture
    /// through this entry point regardless of backing type; those three only ever
    /// attach through `framebufferTextureLayer` below - and `level == 0`; see
    /// `FboAttachment`'s own doc comment for why the
    /// level restriction is not a narrowing beyond upstream's own behaviour. Matches
    /// upstream's own type check: a `GL_TEXTURE_2D` `textarget` requires the named
    /// object to actually be a `Texture2D` and a cube-face `textarget` requires it to
    /// actually be a `TextureCube` - either mismatch reports `GL_INVALID_OPERATION`,
    /// the same error `bind_texture` reports for the equivalent name/target mismatch.
    pub fn framebuffer_texture2d(
        &mut self,
        target: GLenum,
        attachment: GLenum,
        textarget: GLenum,
        texture: u32,
        level: i32,
    ) {
        if attachment == glw::GL_DEPTH_STENCIL_ATTACHMENT {
            self.framebuffer_texture2d(target, glw::GL_DEPTH_ATTACHMENT, textarget, texture, level);
            self.framebuffer_texture2d(target, glw::GL_STENCIL_ATTACHMENT, textarget, texture, level);
            return;
        }

        if !Self::is_valid_framebuffer_target(target) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        let Some(point) = Self::map_gl_attachment_point(attachment) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };

        let is_draw = target == glw::GL_FRAMEBUFFER || target == glw::GL_DRAW_FRAMEBUFFER;
        let binding = if is_draw {
            self.draw_framebuffer_binding
        } else {
            self.read_framebuffer_binding
        };
        let Some(fbo_name) = binding else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };

        // If the same FBO is bound to both the draw and read targets, both references
        // must be released/acquired together - matching `framebuffer_renderbuffer`
        // above and upstream's own `bindingRefCount`.
        let ref_count = (self.draw_framebuffer_binding == Some(fbo_name)) as u32
            + (self.read_framebuffer_binding == Some(fbo_name)) as u32;

        let new_att = if texture != 0 {
            if level != 0 {
                self.set_error(glw::GL_INVALID_VALUE);
                return;
            }
            let Some(obj) = self.textures.find(texture) else {
                self.set_error(glw::GL_INVALID_OPERATION);
                return;
            };
            if textarget == glw::GL_TEXTURE_2D {
                if obj.as_2d().is_none() {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }
                Some(FboAttachment::Texture2D(texture))
            } else if let Some(face_index) = super::reference_utils::map_gl_cube_map_face_index(textarget) {
                if obj.as_cube().is_none() {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }
                Some(FboAttachment::TextureCube(texture, face_index))
            } else {
                self.set_error(glw::GL_INVALID_OPERATION);
                return;
            }
        } else {
            None
        };

        let old = {
            let fbo = self.framebuffers.find_mut(fbo_name).expect("bound FBO must exist");
            let old = fbo.attachment(point);
            fbo.attachments[point as usize] = new_att;
            old
        };

        if let Some(old_att) = old {
            for _ in 0..ref_count {
                release_fbo_attachment_reference(old_att, &mut self.renderbuffers, &mut self.textures);
            }
        }
        if new_att.is_some() {
            for _ in 0..ref_count {
                self.textures.acquire_reference(texture);
            }
        }
    }

    /// `ReferenceContext::framebufferTextureLayer`, accepting all three layered types
    /// this port backs - `GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_3D`/`GL_TEXTURE_CUBE_MAP_ARRAY`,
    /// exactly upstream's own accepted set
    /// (`RC_IF_ERROR(texObj->getType() != TYPE_2D_ARRAY && != TYPE_3D && !=
    /// TYPE_CUBE_MAP_ARRAY, GL_INVALID_OPERATION, ...)`). A real `texture != 0` name of
    /// either non-layered kind this port can produce (`Texture2D`/`TextureCube`) is
    /// still wrong for this entry point and still reports `GL_INVALID_OPERATION` -
    /// matching upstream's own check exactly. Keeps upstream's exact validation order:
    /// name-exists (`GL_INVALID_OPERATION`), then `level == 0` (`GL_INVALID_VALUE`),
    /// then the type check.
    ///
    /// Skips the upper `layer`/`level` bound upstream additionally applies for
    /// `TYPE_2D_ARRAY`/`TYPE_CUBE_MAP_ARRAY`/`TYPE_3D` (`layer >=
    /// GL_MAX_ARRAY_TEXTURE_LAYERS`/`GL_MAX_3D_TEXTURE_SIZE`) - this port tracks no
    /// `ReferenceContextLimits` analogue at all (`tex_image_2d`/`tex_image_3d` already
    /// skip the matching `m_limits.maxTexture2DSize`/`maxTexture2DArrayLayers`/
    /// `maxTexture3DSize` checks for the same reason), and upstream's own check here
    /// compares `layer` against the literal `GL_MAX_ARRAY_TEXTURE_LAYERS`/
    /// `GL_MAX_3D_TEXTURE_SIZE` *enum tokens* rather than a tracked limit, so there would
    /// be nothing meaningful to port even if there were somewhere to track one. `layer <
    /// 0` is still rejected (`GL_INVALID_VALUE`) since nothing downstream could use a
    /// negative index safely regardless. `texture == 0` (detach) is unchanged from
    /// before - it never looked at the attached type at all.
    pub fn framebuffer_texture_layer(
        &mut self,
        target: GLenum,
        attachment: GLenum,
        texture: u32,
        level: i32,
        layer: i32,
    ) {
        if attachment == glw::GL_DEPTH_STENCIL_ATTACHMENT {
            self.framebuffer_texture_layer(target, glw::GL_DEPTH_ATTACHMENT, texture, level, layer);
            self.framebuffer_texture_layer(target, glw::GL_STENCIL_ATTACHMENT, texture, level, layer);
            return;
        }

        if !Self::is_valid_framebuffer_target(target) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        let Some(point) = Self::map_gl_attachment_point(attachment) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };

        let is_draw = target == glw::GL_FRAMEBUFFER || target == glw::GL_DRAW_FRAMEBUFFER;
        let binding = if is_draw {
            self.draw_framebuffer_binding
        } else {
            self.read_framebuffer_binding
        };
        let Some(fbo_name) = binding else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };

        let new_att = if texture != 0 {
            let Some(obj) = self.textures.find(texture) else {
                self.set_error(glw::GL_INVALID_OPERATION);
                return;
            };
            if level != 0 {
                self.set_error(glw::GL_INVALID_VALUE);
                return;
            }
            let is_2d_array = obj.as_2d_array().is_some();
            let is_3d = obj.as_3d().is_some();
            let is_cube_array = obj.as_cube_array().is_some();
            if !is_2d_array && !is_3d && !is_cube_array {
                self.set_error(glw::GL_INVALID_OPERATION);
                return;
            }
            if layer < 0 {
                self.set_error(glw::GL_INVALID_VALUE);
                return;
            }
            if is_2d_array {
                Some(FboAttachment::Texture2DArray(texture, layer as u32))
            } else if is_3d {
                Some(FboAttachment::Texture3D(texture, layer as u32))
            } else {
                Some(FboAttachment::CubeArray(texture, layer as u32))
            }
        } else {
            None
        };

        let ref_count = (self.draw_framebuffer_binding == Some(fbo_name)) as u32
            + (self.read_framebuffer_binding == Some(fbo_name)) as u32;
        let old = {
            let fbo = self.framebuffers.find_mut(fbo_name).expect("bound FBO must exist");
            let old = fbo.attachment(point);
            fbo.attachments[point as usize] = new_att;
            old
        };
        if let Some(old_att) = old {
            for _ in 0..ref_count {
                release_fbo_attachment_reference(old_att, &mut self.renderbuffers, &mut self.textures);
            }
        }
        if new_att.is_some() {
            for _ in 0..ref_count {
                self.textures.acquire_reference(texture);
            }
        }
    }

    /// `ReferenceContext::checkFramebufferStatus` - renderbuffer and `GL_TEXTURE_2D`
    /// attachments; see this module's top doc comment for the narrowing.
    pub fn check_framebuffer_status(&mut self, target: GLenum) -> GLenum {
        if !Self::is_valid_framebuffer_target(target) {
            self.set_error(glw::GL_INVALID_ENUM);
            return 0;
        }

        let is_draw = target == glw::GL_FRAMEBUFFER || target == glw::GL_DRAW_FRAMEBUFFER;
        let binding = if is_draw {
            self.draw_framebuffer_binding
        } else {
            self.read_framebuffer_binding
        };

        // The default framebuffer is always complete.
        let Some(fbo_name) = binding else {
            return glw::GL_FRAMEBUFFER_COMPLETE;
        };
        let fbo = self.framebuffers.find(fbo_name).expect("bound FBO must exist");

        let mut size: Option<(u32, u32)> = None;
        let mut attachment_complete = true;
        let mut has_attachment = false;
        let mut dimensions_ok = true;

        for point in ATTACHMENT_POINTS {
            let Some(att) = fbo.attachment(point) else { continue };
            let Some((w, h, format)) = (match att {
                FboAttachment::Renderbuffer(rb_name) => {
                    let rb = self
                        .renderbuffers
                        .find(rb_name)
                        .expect("attached renderbuffer must exist");
                    rb.format().map(|format| (rb.width(), rb.height(), format))
                }
                FboAttachment::Texture2D(tex_name) => {
                    let tex = self
                        .textures
                        .find(tex_name)
                        .expect("attached texture must exist")
                        .as_2d()
                        .expect("GL_TEXTURE_2D attachment must name a Texture2D - checked in framebuffer_texture2d");
                    tex.level(0)
                        .map(|level| (level.size()[0], level.size()[1], level.format()))
                }
                FboAttachment::TextureCube(tex_name, face_index) => {
                    let tex = self
                        .textures
                        .find(tex_name)
                        .expect("attached texture must exist")
                        .as_cube()
                        .expect("cube-face attachment must name a TextureCube - checked in framebuffer_texture2d");
                    tex.face(0, face_index as usize)
                        .map(|level| (level.size()[0], level.size()[1], level.format()))
                }
                FboAttachment::Texture2DArray(tex_name, _layer) => {
                    // Every layer of a given level shares the same width/height/format,
                    // so the size/format check below needs no particular layer's data -
                    // only `resolve_targets`/`resolve_color_target`/`resolve_optional_target`
                    // (the ones that actually read/write pixels) need `_layer` itself.
                    let tex = self.textures.find(tex_name).expect("attached texture must exist").as_2d_array().expect("GL_TEXTURE_2D_ARRAY attachment must name a Texture2DArray - checked in framebuffer_texture_layer");
                    tex.level(0)
                        .map(|level| (level.size()[0], level.size()[1], level.format()))
                }
                FboAttachment::Texture3D(tex_name, _layer) => {
                    // Same reasoning as the `Texture2DArray` arm above - every z-slice
                    // of a given level shares the same width/height/format.
                    let tex = self
                        .textures
                        .find(tex_name)
                        .expect("attached texture must exist")
                        .as_3d()
                        .expect(
                            "GL_TEXTURE_3D attachment must name a Texture3D - checked in framebuffer_texture_layer",
                        );
                    tex.level(0)
                        .map(|level| (level.size()[0], level.size()[1], level.format()))
                }
                FboAttachment::CubeArray(tex_name, _layer) => {
                    // Same reasoning again - every face/layer of a given level shares
                    // the same width/height/format.
                    let tex = self.textures.find(tex_name).expect("attached texture must exist").as_cube_array().expect("GL_TEXTURE_CUBE_MAP_ARRAY attachment must name a TextureCubeArray - checked in framebuffer_texture_layer");
                    tex.level(0)
                        .map(|level| (level.size()[0], level.size()[1], level.format()))
                }
            }) else {
                continue; // never had storage/a level set - treated as if unattached
            };

            match size {
                None if w > 0 && h > 0 => {
                    size = Some((w, h));
                    has_attachment = true;
                }
                Some((sw, sh)) if w != sw || h != sh => dimensions_ok = false,
                _ => {}
            }

            use crate::tcu::texture::ChannelOrder::*;
            let compatible = match format.order {
                R | RG | RGB | RGBA | sRGB | sRGBA | BGRA => point == AttachmentPoint::Color0,
                D => point == AttachmentPoint::Depth,
                S => point == AttachmentPoint::Stencil,
                DS => point == AttachmentPoint::Depth || point == AttachmentPoint::Stencil,
                _ => false,
            };
            if !compatible {
                attachment_complete = false;
            }
        }

        if !attachment_complete {
            glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT
        } else if !has_attachment {
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        } else if !dimensions_ok {
            glw::GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS
        } else {
            glw::GL_FRAMEBUFFER_COMPLETE
        }
    }

    // --- Texture objects (every GL_TEXTURE_* type except GL_TEXTURE_1D - see this
    // module's top doc comment) ---

    /// `ReferenceContext::activeTexture`
    pub fn active_texture(&mut self, texture: GLenum) {
        if texture < glw::GL_TEXTURE0 || (texture - glw::GL_TEXTURE0) as usize >= self.texture_2d_bindings.len() {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        self.active_texture_unit = texture - glw::GL_TEXTURE0;
    }

    /// `ReferenceContext::bindTexture`, narrowed to `GL_TEXTURE_2D`/`GL_TEXTURE_CUBE_MAP`/
    /// `GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_3D`/`GL_TEXTURE_CUBE_MAP_ARRAY`/`GL_TEXTURE_BUFFER`
    /// (no `GL_TEXTURE_1D` backing type exists here - see this module's top doc comment). Matches upstream's own type
    /// check: binding an *existing* name against the "wrong" target (one whose
    /// first-ever bind used a different target) reports `GL_INVALID_OPERATION` rather
    /// than silently treating it as the new target - `TextureObject`'s own doc comment
    /// explains why a single shared name namespace needs this check at all.
    pub fn bind_texture(&mut self, target: GLenum, texture: u32) {
        let Some(kind) = classify_texture_target(target) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };

        let new_binding = if texture != 0 {
            match self.textures.find(texture) {
                Some(existing) => {
                    let type_matches = match kind {
                        TextureTargetKind::D2 => existing.as_2d().is_some(),
                        TextureTargetKind::Cube => existing.as_cube().is_some(),
                        TextureTargetKind::D2Array => existing.as_2d_array().is_some(),
                        TextureTargetKind::D3 => existing.as_3d().is_some(),
                        TextureTargetKind::CubeArray => existing.as_cube_array().is_some(),
                        TextureTargetKind::Buffer => existing.as_buffer().is_some(),
                    };
                    if !type_matches {
                        self.set_error(glw::GL_INVALID_OPERATION);
                        return;
                    }
                }
                None => {
                    let obj = match kind {
                        TextureTargetKind::D2 => TextureObject::D2(Texture2D::default()),
                        TextureTargetKind::Cube => TextureObject::Cube(TextureCube::default()),
                        TextureTargetKind::D2Array => TextureObject::D2Array(Texture2DArray::default()),
                        TextureTargetKind::D3 => TextureObject::D3(Texture3D::default()),
                        TextureTargetKind::CubeArray => TextureObject::CubeArray(TextureCubeArray::default()),
                        TextureTargetKind::Buffer => TextureObject::Buffer(TextureBuffer::default()),
                    };
                    self.textures.insert(texture, obj);
                }
            }
            Some(texture)
        } else {
            None
        };

        let unit = self.active_texture_unit as usize;
        let bindings = match kind {
            TextureTargetKind::D2 => &mut self.texture_2d_bindings,
            TextureTargetKind::Cube => &mut self.texture_cube_bindings,
            TextureTargetKind::D2Array => &mut self.texture_2d_array_bindings,
            TextureTargetKind::D3 => &mut self.texture_3d_bindings,
            TextureTargetKind::CubeArray => &mut self.texture_cube_array_bindings,
            TextureTargetKind::Buffer => &mut self.texture_buffer_bindings,
        };
        if let Some(old) = bindings[unit] {
            self.textures.release_reference(old);
        }
        if let Some(n) = new_binding {
            self.textures.acquire_reference(n);
        }
        bindings[unit] = new_binding;
    }

    /// `ReferenceContext::genTextures`
    pub fn gen_textures(&mut self, out: &mut [u32]) {
        for slot in out.iter_mut() {
            *slot = self.textures.allocate_name();
        }
    }

    /// `ReferenceContext::deleteTexture` - unbinds the texture from every texture unit
    /// it occupies (every one of the `GL_TEXTURE_2D`/`_CUBE_MAP`/`_2D_ARRAY`/`_3D`/
    /// `_CUBE_MAP_ARRAY`/`_BUFFER` binding arrays - a given name only ever appears in one of the
    /// six, since `bind_texture` enforces one target per name, but checking all six
    /// costs nothing and needs no branch on which concrete type `name` turned out to
    /// be) and detaches it from every framebuffer attachment point that references it
    /// (any cube face/array layer, not just the first), same shape as
    /// `delete_renderbuffer`'s own FBO-detach loop below. A `GL_TEXTURE_BUFFER` object
    /// is never itself an FBO attachment (the GL spec forbids attaching a buffer
    /// texture to a framebuffer at all), so its own unbind loop has no FBO-detach
    /// counterpart to the one below.
    fn delete_texture(&mut self, name: u32) {
        for unit in self.texture_2d_bindings.iter_mut() {
            if *unit == Some(name) {
                self.textures.release_reference(name);
                *unit = None;
            }
        }
        for unit in self.texture_cube_bindings.iter_mut() {
            if *unit == Some(name) {
                self.textures.release_reference(name);
                *unit = None;
            }
        }
        for unit in self.texture_2d_array_bindings.iter_mut() {
            if *unit == Some(name) {
                self.textures.release_reference(name);
                *unit = None;
            }
        }
        for unit in self.texture_3d_bindings.iter_mut() {
            if *unit == Some(name) {
                self.textures.release_reference(name);
                *unit = None;
            }
        }
        for unit in self.texture_cube_array_bindings.iter_mut() {
            if *unit == Some(name) {
                self.textures.release_reference(name);
                *unit = None;
            }
        }
        for unit in self.texture_buffer_bindings.iter_mut() {
            if *unit == Some(name) {
                self.textures.release_reference(name);
                *unit = None;
            }
        }

        let fbo_names = self.framebuffers.names();
        for fbo_name in fbo_names {
            let extra_refs = (self.draw_framebuffer_binding == Some(fbo_name)) as u32
                + (self.read_framebuffer_binding == Some(fbo_name)) as u32;
            if extra_refs == 0 {
                continue;
            }
            let fbo = self
                .framebuffers
                .find_mut(fbo_name)
                .expect("name just came from framebuffers.names()");
            for point in ATTACHMENT_POINTS {
                let names_this_texture = matches!(fbo.attachment(point), Some(FboAttachment::Texture2D(n)) if n == name)
                    || matches!(fbo.attachment(point), Some(FboAttachment::TextureCube(n, _)) if n == name)
                    || matches!(fbo.attachment(point), Some(FboAttachment::Texture2DArray(n, _)) if n == name)
                    || matches!(fbo.attachment(point), Some(FboAttachment::Texture3D(n, _)) if n == name)
                    || matches!(fbo.attachment(point), Some(FboAttachment::CubeArray(n, _)) if n == name);
                if names_this_texture {
                    fbo.attachments[point as usize] = None;
                    for _ in 0..extra_refs {
                        self.textures.release_reference(name);
                    }
                }
            }
        }

        debug_assert_eq!(self.textures.ref_count(name), Some(1));
        self.textures.release_reference(name);
    }

    /// `ReferenceContext::deleteTextures`
    pub fn delete_textures(&mut self, names: &[u32]) {
        for &name in names {
            if name != 0 && self.textures.find(name).is_some() {
                self.delete_texture(name);
            }
        }
    }

    pub fn texture(&self, name: u32) -> Option<&Texture2D> {
        self.textures.find(name).and_then(TextureObject::as_2d)
    }

    pub fn texture_cube(&self, name: u32) -> Option<&TextureCube> {
        self.textures.find(name).and_then(TextureObject::as_cube)
    }

    pub fn texture_2d_array(&self, name: u32) -> Option<&Texture2DArray> {
        self.textures.find(name).and_then(TextureObject::as_2d_array)
    }

    pub fn texture_3d(&self, name: u32) -> Option<&Texture3D> {
        self.textures.find(name).and_then(TextureObject::as_3d)
    }

    pub fn texture_cube_array(&self, name: u32) -> Option<&TextureCubeArray> {
        self.textures.find(name).and_then(TextureObject::as_cube_array)
    }

    pub fn texture_buffer(&self, name: u32) -> Option<&TextureBuffer> {
        self.textures.find(name).and_then(TextureObject::as_buffer)
    }

    /// `ReferenceContext::texImage2D`, narrowed per this module's top doc comment:
    /// `GL_TEXTURE_2D` or one of the six `GL_TEXTURE_CUBE_MAP_POSITIVE_X..NEGATIVE_Z`
    /// face targets, requires an explicit bound texture of the matching kind (no
    /// implicit per-unit default object), and does not special-case float depth formats
    /// the way upstream's `depthValueFloatClampCopy` does (a plain format-converting
    /// copy is used for every destination format). `GL_UNPACK_ALIGNMENT`/`_ROW_LENGTH`/
    /// `_SKIP_ROWS`/`_SKIP_PIXELS` are honoured via `unpack_2d_access` below - no
    /// longer assumes tightly-packed source data.
    #[allow(clippy::too_many_arguments)]
    pub fn tex_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        data: Option<&[u8]>,
    ) {
        let Some(target_kind) = classify_tex_image_target(target) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        if border != 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        if width < 0 || height < 0 || level < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let Some(storage_fmt) = super::reference_utils::map_gl_tex_internal_format(internal_format) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        let Some(transfer_fmt) = super::reference_utils::map_gl_transfer_format(format, type_) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        let unpack_state = (
            self.pixel_unpack_alignment,
            self.pixel_unpack_row_length,
            self.pixel_unpack_skip_rows,
            self.pixel_unpack_skip_pixels,
        );
        let unit = self.active_texture_unit as usize;

        match target_kind {
            TexImageTarget::D2 => {
                let Some(tex_name) = self.texture_2d_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_2d_mut()
                    .expect("GL_TEXTURE_2D binding must name a Texture2D");

                if texture
                    .alloc_level(level, storage_fmt, width as u32, height as u32)
                    .is_err()
                {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }

                let mut dst = texture.levels.get_mut(&level).expect("just allocated").get_access();
                if let Some(err) = fill_tex_image_2d_level(&mut dst, unpack_state, transfer_fmt, width, height, data) {
                    self.set_error(err);
                }
            }
            TexImageTarget::CubeFace(face_index) => {
                let Some(tex_name) = self.texture_cube_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_cube_mut()
                    .expect("cube-face binding must name a TextureCube");

                if texture
                    .alloc_face(level, face_index as usize, storage_fmt, width as u32, height as u32)
                    .is_err()
                {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }

                let mut dst = texture
                    .face_mut(level, face_index as usize)
                    .expect("just allocated")
                    .get_access();
                if let Some(err) = fill_tex_image_2d_level(&mut dst, unpack_state, transfer_fmt, width, height, data) {
                    self.set_error(err);
                }
            }
        }
    }

    /// `ReferenceContext::texSubImage2D` - see `tex_image_2d`'s own doc comment for the
    /// pixel-store-state handling both share via `unpack_2d_access`, and for the same
    /// `GL_TEXTURE_2D`/cube-face target dispatch.
    #[allow(clippy::too_many_arguments)]
    pub fn tex_sub_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        width: i32,
        height: i32,
        format: GLenum,
        type_: GLenum,
        data: &[u8],
    ) {
        let Some(target_kind) = classify_tex_image_target(target) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        if xoffset < 0 || yoffset < 0 || width < 0 || height < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let Some(transfer_fmt) = super::reference_utils::map_gl_transfer_format(format, type_) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        let unpack_state = (
            self.pixel_unpack_alignment,
            self.pixel_unpack_row_length,
            self.pixel_unpack_skip_rows,
            self.pixel_unpack_skip_pixels,
        );
        let unit = self.active_texture_unit as usize;

        match target_kind {
            TexImageTarget::D2 => {
                let Some(tex_name) = self.texture_2d_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_2d_mut()
                    .expect("GL_TEXTURE_2D binding must name a Texture2D");
                if !texture.has_level(level) {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }
                let dst_level = texture.levels.get_mut(&level).expect("just checked has_level");
                if let Err(err) = fill_tex_sub_image_2d(
                    dst_level,
                    xoffset,
                    yoffset,
                    width,
                    height,
                    unpack_state,
                    transfer_fmt,
                    data,
                ) {
                    self.set_error(err);
                }
            }
            TexImageTarget::CubeFace(face_index) => {
                let Some(tex_name) = self.texture_cube_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_cube_mut()
                    .expect("cube-face binding must name a TextureCube");
                if !texture.has_face(level, face_index as usize) {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }
                let dst_level = texture
                    .face_mut(level, face_index as usize)
                    .expect("just checked has_face");
                if let Err(err) = fill_tex_sub_image_2d(
                    dst_level,
                    xoffset,
                    yoffset,
                    width,
                    height,
                    unpack_state,
                    transfer_fmt,
                    data,
                ) {
                    self.set_error(err);
                }
            }
        }
    }

    /// The bytes of the buffer bound to `GL_PIXEL_UNPACK_BUFFER` from `offset` on, for the `*_pbo` uploads
    /// (the data-slice entry points ignore the binding, so the tail is handed to them as the client data).
    fn pixel_unpack_buffer_tail(&self, offset: isize) -> Option<Vec<u8>> {
        let name = self.pixel_unpack_buffer_binding?;
        let buffer = self.buffers.find(name)?;
        let start = usize::try_from(offset).ok()?;
        buffer.data().get(start..).map(<[u8]>::to_vec)
    }

    /// `ReferenceContext::copyTexImage2D` - narrowed to the unsized internal formats with `GL_UNSIGNED_BYTE`
    /// storage the copy cases use: the read framebuffer region is converted into a level of that format and
    /// handed to `tex_image_2d` with the unpack state forced to its defaults.
    #[allow(clippy::too_many_arguments)]
    pub fn copy_tex_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
        border: i32,
    ) {
        if border != 0 || width < 0 || height < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let Some(fmt) = super::reference_utils::map_gl_transfer_format(internal_format, glw::GL_UNSIGNED_BYTE) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        let pixels = self.read_pixels_rgba_f32(x, y, width, height, glw::GL_FLOAT);
        if pixels.len() != width as usize * height as usize {
            return;
        }
        let Ok(mut src) = TextureLevel::new(fmt, width as u32, height as u32, 1) else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        {
            let mut access = src.get_access();
            for row in 0..height {
                for column in 0..width {
                    access.set_pixel(pixels[(row * width + column) as usize], column as u32, row as u32, 0);
                }
            }
        }

        let saved = (
            self.pixel_unpack_alignment,
            self.pixel_unpack_row_length,
            self.pixel_unpack_skip_rows,
            self.pixel_unpack_skip_pixels,
        );
        self.pixel_unpack_alignment = 1;
        self.pixel_unpack_row_length = 0;
        self.pixel_unpack_skip_rows = 0;
        self.pixel_unpack_skip_pixels = 0;
        self.tex_image_2d(
            target,
            level,
            internal_format,
            width,
            height,
            0,
            internal_format,
            glw::GL_UNSIGNED_BYTE,
            Some(src.data()),
        );
        (
            self.pixel_unpack_alignment,
            self.pixel_unpack_row_length,
            self.pixel_unpack_skip_rows,
            self.pixel_unpack_skip_pixels,
        ) = saved;
    }

    /// `ReferenceContext::copyTexSubImage2D` - the read framebuffer region is written straight into the bound
    /// texture's existing level (converted by `set_pixel`), for `GL_TEXTURE_2D` and the cube-map faces.
    #[allow(clippy::too_many_arguments)]
    pub fn copy_tex_sub_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
    ) {
        let Some(target_kind) = classify_tex_image_target(target) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        if xoffset < 0 || yoffset < 0 || width < 0 || height < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let pixels = self.read_pixels_rgba_f32(x, y, width, height, glw::GL_FLOAT);
        if pixels.len() != width as usize * height as usize {
            return;
        }
        let unit = self.active_texture_unit as usize;
        let dst_level = match target_kind {
            TexImageTarget::D2 => {
                let Some(tex_name) = self.texture_2d_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_2d_mut()
                    .expect("GL_TEXTURE_2D binding must name a Texture2D");
                texture.levels.get_mut(&level)
            }
            TexImageTarget::CubeFace(face_index) => {
                let Some(tex_name) = self.texture_cube_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_cube_mut()
                    .expect("cube-face binding must name a TextureCube");
                texture.face_mut(level, face_index as usize)
            }
        };
        let Some(dst_level) = dst_level else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        let mut access = dst_level.get_access();
        if (xoffset + width) as u32 > access.size()[0] || (yoffset + height) as u32 > access.size()[1] {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        for row in 0..height {
            for column in 0..width {
                access.set_pixel(
                    pixels[(row * width + column) as usize],
                    (xoffset + column) as u32,
                    (yoffset + row) as u32,
                    0,
                );
            }
        }
    }

    /// `ReferenceContext::texImage3D`, narrowed to `GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_3D`/
    /// `GL_TEXTURE_CUBE_MAP_ARRAY` (see this module's top doc comment). Upstream's own
    /// `texImage2D`/`texSubImage2D` forward into `texImage3D`/`texSubImage3D` with
    /// `depth`/`zoffset` fixed at `1`/`0` - this port keeps `tex_image_2d`/
    /// `tex_sub_image_2d` as their own already-ported, independent entry points
    /// instead, so this method only ever has to get the array/volume cases right
    /// rather than re-verify the 2D/cube-face paths too. Also skips the
    /// `m_limits.maxTexture2DSize`/`maxTexture2DArrayLayers`/`maxTexture3DSize`/
    /// level-vs-log2 bound checks upstream applies here, the same way `tex_image_2d`
    /// already skips the matching `maxTexture2DSize` ones - this port tracks no
    /// `ReferenceContextLimits` analogue at all. The `GL_TEXTURE_CUBE_MAP_ARRAY` branch
    /// keeps upstream's `width != height || depth % 6 != 0` check, though - that is not
    /// a limit, it is the shape a cube-map-array texture is inherently required to
    /// have (six square faces per array layer), and `TextureCubeArray::alloc_level`'s
    /// own `debug_assert_eq!` relies on this branch having already rejected anything
    /// where it would not hold.
    #[allow(clippy::too_many_arguments)]
    pub fn tex_image_3d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        data: Option<&[u8]>,
    ) {
        let Some(target_kind) = classify_tex_image_3d_target(target) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        if border != 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        if width < 0 || height < 0 || depth < 0 || level < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let Some(storage_fmt) = super::reference_utils::map_gl_tex_internal_format(internal_format) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        let Some(transfer_fmt) = super::reference_utils::map_gl_transfer_format(format, type_) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        let unpack_state = (
            self.pixel_unpack_alignment,
            self.pixel_unpack_row_length,
            self.pixel_unpack_skip_rows,
            self.pixel_unpack_skip_pixels,
            self.pixel_unpack_image_height,
            self.pixel_unpack_skip_images,
        );
        let unit = self.active_texture_unit as usize;

        match target_kind {
            TexImage3DTarget::D2Array => {
                let Some(tex_name) = self.texture_2d_array_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_2d_array_mut()
                    .expect("GL_TEXTURE_2D_ARRAY binding must name a Texture2DArray");

                if texture
                    .alloc_level(level, storage_fmt, width as u32, height as u32, depth as u32)
                    .is_err()
                {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }

                let mut dst = texture.levels.get_mut(&level).expect("just allocated").get_access();
                if let Some(err) =
                    fill_tex_image_3d_level(&mut dst, unpack_state, transfer_fmt, width, height, depth, data)
                {
                    self.set_error(err);
                }
            }
            TexImage3DTarget::D3 => {
                let Some(tex_name) = self.texture_3d_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_3d_mut()
                    .expect("GL_TEXTURE_3D binding must name a Texture3D");

                if texture
                    .alloc_level(level, storage_fmt, width as u32, height as u32, depth as u32)
                    .is_err()
                {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }

                let mut dst = texture.levels.get_mut(&level).expect("just allocated").get_access();
                if let Some(err) =
                    fill_tex_image_3d_level(&mut dst, unpack_state, transfer_fmt, width, height, depth, data)
                {
                    self.set_error(err);
                }
            }
            TexImage3DTarget::CubeArray => {
                if width != height || depth % 6 != 0 {
                    self.set_error(glw::GL_INVALID_VALUE);
                    return;
                }
                let Some(tex_name) = self.texture_cube_array_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_cube_array_mut()
                    .expect("GL_TEXTURE_CUBE_MAP_ARRAY binding must name a TextureCubeArray");

                if texture
                    .alloc_level(level, storage_fmt, width as u32, height as u32, depth as u32)
                    .is_err()
                {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }

                let mut dst = texture.levels.get_mut(&level).expect("just allocated").get_access();
                if let Some(err) =
                    fill_tex_image_3d_level(&mut dst, unpack_state, transfer_fmt, width, height, depth, data)
                {
                    self.set_error(err);
                }
            }
        }
    }

    /// `ReferenceContext::texSubImage3D` - see `tex_image_3d`'s own doc comment for the
    /// same `GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_3D`/`GL_TEXTURE_CUBE_MAP_ARRAY` dispatch.
    /// No `width != height`/`depth % 6 != 0` re-check here - upstream's own
    /// `texSubImage3D` has none either, since a sub-image update can never change the
    /// shape an already-allocated level was given at `texImage3D` time.
    #[allow(clippy::too_many_arguments)]
    pub fn tex_sub_image_3d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        zoffset: i32,
        width: i32,
        height: i32,
        depth: i32,
        format: GLenum,
        type_: GLenum,
        data: &[u8],
    ) {
        let Some(target_kind) = classify_tex_image_3d_target(target) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        if xoffset < 0 || yoffset < 0 || zoffset < 0 || width < 0 || height < 0 || depth < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let Some(transfer_fmt) = super::reference_utils::map_gl_transfer_format(format, type_) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        let unpack_state = (
            self.pixel_unpack_alignment,
            self.pixel_unpack_row_length,
            self.pixel_unpack_skip_rows,
            self.pixel_unpack_skip_pixels,
            self.pixel_unpack_image_height,
            self.pixel_unpack_skip_images,
        );
        let unit = self.active_texture_unit as usize;

        match target_kind {
            TexImage3DTarget::D2Array => {
                let Some(tex_name) = self.texture_2d_array_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_2d_array_mut()
                    .expect("GL_TEXTURE_2D_ARRAY binding must name a Texture2DArray");
                if !texture.has_level(level) {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }
                let dst_level = texture.levels.get_mut(&level).expect("just checked has_level");
                if let Err(err) = fill_tex_sub_image_3d(
                    dst_level,
                    xoffset,
                    yoffset,
                    zoffset,
                    width,
                    height,
                    depth,
                    unpack_state,
                    transfer_fmt,
                    data,
                ) {
                    self.set_error(err);
                }
            }
            TexImage3DTarget::D3 => {
                let Some(tex_name) = self.texture_3d_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_3d_mut()
                    .expect("GL_TEXTURE_3D binding must name a Texture3D");
                if !texture.has_level(level) {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }
                let dst_level = texture.levels.get_mut(&level).expect("just checked has_level");
                if let Err(err) = fill_tex_sub_image_3d(
                    dst_level,
                    xoffset,
                    yoffset,
                    zoffset,
                    width,
                    height,
                    depth,
                    unpack_state,
                    transfer_fmt,
                    data,
                ) {
                    self.set_error(err);
                }
            }
            TexImage3DTarget::CubeArray => {
                let Some(tex_name) = self.texture_cube_array_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_cube_array_mut()
                    .expect("GL_TEXTURE_CUBE_MAP_ARRAY binding must name a TextureCubeArray");
                if !texture.has_level(level) {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                }
                let dst_level = texture.levels.get_mut(&level).expect("just checked has_level");
                if let Err(err) = fill_tex_sub_image_3d(
                    dst_level,
                    xoffset,
                    yoffset,
                    zoffset,
                    width,
                    height,
                    depth,
                    unpack_state,
                    transfer_fmt,
                    data,
                ) {
                    self.set_error(err);
                }
            }
        }
    }

    /// `ReferenceContext::pixelStorei`.
    pub fn pixel_storei(&mut self, pname: GLenum, param: i32) {
        match pname {
            glw::GL_UNPACK_ALIGNMENT => {
                if !matches!(param, 1 | 2 | 4 | 8) {
                    self.set_error(glw::GL_INVALID_VALUE);
                    return;
                }
                self.pixel_unpack_alignment = param;
            }
            glw::GL_PACK_ALIGNMENT => {
                if !matches!(param, 1 | 2 | 4 | 8) {
                    self.set_error(glw::GL_INVALID_VALUE);
                    return;
                }
                self.pixel_pack_alignment = param;
            }
            glw::GL_UNPACK_ROW_LENGTH => {
                if param < 0 {
                    self.set_error(glw::GL_INVALID_VALUE);
                    return;
                }
                self.pixel_unpack_row_length = param;
            }
            glw::GL_UNPACK_SKIP_ROWS => {
                if param < 0 {
                    self.set_error(glw::GL_INVALID_VALUE);
                    return;
                }
                self.pixel_unpack_skip_rows = param;
            }
            glw::GL_UNPACK_SKIP_PIXELS => {
                if param < 0 {
                    self.set_error(glw::GL_INVALID_VALUE);
                    return;
                }
                self.pixel_unpack_skip_pixels = param;
            }
            glw::GL_UNPACK_IMAGE_HEIGHT => {
                if param < 0 {
                    self.set_error(glw::GL_INVALID_VALUE);
                    return;
                }
                self.pixel_unpack_image_height = param;
            }
            glw::GL_UNPACK_SKIP_IMAGES => {
                if param < 0 {
                    self.set_error(glw::GL_INVALID_VALUE);
                    return;
                }
                self.pixel_unpack_skip_images = param;
            }
            _ => self.set_error(glw::GL_INVALID_ENUM),
        }
    }

    /// `ReferenceContext::texBuffer` - **not a port**: upstream's own `sglr::ReferenceContext`
    /// has no `TextureBuffer` class at all (grepped `sglrReferenceContext.hpp`'s own
    /// six `class Texture*` declarations directly - `Texture1D`/`Texture2D`/`TextureCube`/
    /// `Texture2DArray`/`Texture3D`/`TextureCubeArray`, no buffer-backed type among
    /// them), so this is new code backing `samplerBuffer`/`isamplerBuffer`/
    /// `usamplerBuffer`, the same way shadow-sampler support was. Narrowed to the whole-
    /// buffer form (`glTexBuffer`) - `glTexBufferRange`'s offset/size pair is not
    /// ported, so every `samplerBuffer` texture here always views its attached buffer's
    /// entire extent from byte 0. `buffer == 0` detaches, matching upstream's own
    /// (never implemented here, but spec-mandated) "any buffer object attached to the
    /// buffer texture is detached" behaviour; attaching a name that does not exist in
    /// `self.buffers` is `GL_INVALID_OPERATION`, the same error a bad name reports
    /// everywhere else in this file.
    pub fn tex_buffer(&mut self, target: GLenum, internal_format: GLenum, buffer: u32) {
        if !matches!(classify_texture_target(target), Some(TextureTargetKind::Buffer)) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        let Some(format) = super::reference_utils::map_gl_tex_internal_format(internal_format) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        if format.pixel_size().is_none() {
            // Every format this port accepts for a buffer texture must have a flat
            // per-texel byte size to index by - see `ResolvedSamplerBuffer::texel_count`.
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if buffer != 0 && self.buffers.find(buffer).is_none() {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }

        let unit = self.active_texture_unit as usize;
        let Some(tex_name) = self.texture_buffer_bindings[unit] else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        let tex = self
            .textures
            .find_mut(tex_name)
            .expect("bound texture must exist")
            .as_buffer_mut()
            .expect("GL_TEXTURE_BUFFER binding must name a TextureBuffer");
        tex.buffer = if buffer == 0 { None } else { Some(buffer) };
        tex.internal_format = Some(internal_format);
    }

    /// `ReferenceContext::texParameteri`, narrowed to `GL_TEXTURE_2D`/`GL_TEXTURE_CUBE_MAP`/
    /// `GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_3D`/`GL_TEXTURE_CUBE_MAP_ARRAY` (see this
    /// module's top doc comment) - `GL_TEXTURE_1D` is the only upstream `target` left
    /// with no backing texture type here. Also narrower than upstream in one more way:
    /// there is no implicit per-unit default texture object (the same restriction
    /// `tex_image_2d` already documents), so this requires an explicit bound texture
    /// rather than falling back to one. Unlike `tex_image_2d`'s per-face targets, every
    /// multi-layer/-face target here names the whole object - a cube map's/array's/
    /// volume's sampler state is shared by every face/layer, matching real GL (there is
    /// no per-face or per-layer `texParameteri`).
    pub fn tex_parameteri(&mut self, target: GLenum, pname: GLenum, value: i32) {
        let Some(kind) = classify_texture_target(target) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        if matches!(kind, TextureTargetKind::Buffer) {
            // `GL_TEXTURE_BUFFER` has no wrap/filter/compare state at all - see
            // `TextureTargetKind`'s own doc comment.
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }

        let update = match pname {
            glw::GL_TEXTURE_WRAP_S if is_valid_gl_wrap_mode(value as GLenum) => {
                TexSamplerUpdate::WrapS(value as GLenum)
            }
            glw::GL_TEXTURE_WRAP_T if is_valid_gl_wrap_mode(value as GLenum) => {
                TexSamplerUpdate::WrapT(value as GLenum)
            }
            glw::GL_TEXTURE_WRAP_R if is_valid_gl_wrap_mode(value as GLenum) => {
                TexSamplerUpdate::WrapR(value as GLenum)
            }
            glw::GL_TEXTURE_MIN_FILTER if is_valid_gl_min_filter(value as GLenum) => {
                TexSamplerUpdate::MinFilter(value as GLenum)
            }
            glw::GL_TEXTURE_MAG_FILTER if is_valid_gl_mag_filter(value as GLenum) => {
                TexSamplerUpdate::MagFilter(value as GLenum)
            }
            glw::GL_TEXTURE_MAX_LEVEL if value >= 0 => TexSamplerUpdate::MaxLevel(value),
            glw::GL_TEXTURE_COMPARE_MODE if is_valid_gl_compare_mode(value as GLenum) => {
                TexSamplerUpdate::CompareMode(value as GLenum)
            }
            glw::GL_TEXTURE_COMPARE_FUNC if map_gl_compare_func(value as GLenum).is_some() => {
                TexSamplerUpdate::CompareFunc(value as GLenum)
            }
            glw::GL_TEXTURE_WRAP_S
            | glw::GL_TEXTURE_WRAP_T
            | glw::GL_TEXTURE_WRAP_R
            | glw::GL_TEXTURE_MIN_FILTER
            | glw::GL_TEXTURE_MAG_FILTER
            | glw::GL_TEXTURE_MAX_LEVEL
            | glw::GL_TEXTURE_COMPARE_MODE
            | glw::GL_TEXTURE_COMPARE_FUNC => {
                self.set_error(glw::GL_INVALID_VALUE);
                return;
            }
            _ => {
                self.set_error(glw::GL_INVALID_ENUM);
                return;
            }
        };

        let unit = self.active_texture_unit as usize;
        let bindings = match kind {
            TextureTargetKind::D2 => &self.texture_2d_bindings,
            TextureTargetKind::Cube => &self.texture_cube_bindings,
            TextureTargetKind::D2Array => &self.texture_2d_array_bindings,
            TextureTargetKind::D3 => &self.texture_3d_bindings,
            TextureTargetKind::CubeArray => &self.texture_cube_array_bindings,
            TextureTargetKind::Buffer => unreachable!("tex_parameteri already rejected GL_TEXTURE_BUFFER above"),
        };
        let Some(tex_name) = bindings[unit] else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        let obj = self.textures.find_mut(tex_name).expect("bound texture must exist");
        let sampler = match kind {
            TextureTargetKind::D2 => {
                &mut obj
                    .as_2d_mut()
                    .expect("GL_TEXTURE_2D binding must name a Texture2D")
                    .sampler
            }
            TextureTargetKind::Cube => {
                &mut obj
                    .as_cube_mut()
                    .expect("GL_TEXTURE_CUBE_MAP binding must name a TextureCube")
                    .sampler
            }
            TextureTargetKind::D2Array => {
                &mut obj
                    .as_2d_array_mut()
                    .expect("GL_TEXTURE_2D_ARRAY binding must name a Texture2DArray")
                    .sampler
            }
            TextureTargetKind::D3 => {
                &mut obj
                    .as_3d_mut()
                    .expect("GL_TEXTURE_3D binding must name a Texture3D")
                    .sampler
            }
            TextureTargetKind::CubeArray => {
                &mut obj
                    .as_cube_array_mut()
                    .expect("GL_TEXTURE_CUBE_MAP_ARRAY binding must name a TextureCubeArray")
                    .sampler
            }
            TextureTargetKind::Buffer => unreachable!("tex_parameteri already rejected GL_TEXTURE_BUFFER above"),
        };
        apply_tex_sampler_update(sampler, update);
    }

    /// `glGenerateMipmap`, now covering every mip-mappable texture type this port backs
    /// (`GL_TEXTURE_2D`/`GL_TEXTURE_CUBE_MAP`/`GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_3D`/
    /// `GL_TEXTURE_CUBE_MAP_ARRAY` - `GL_TEXTURE_BUFFER` has no mip chain at all, by
    /// construction, and reports `GL_INVALID_ENUM` here the same as real GL does).
    /// **Not a port**: grepped directly against
    /// `sglrContext.hpp`'s own ~90-method pure-virtual interface (zero hits) -
    /// upstream's `sglr::ReferenceContext` never implements this at all, so there is no
    /// upstream C++ body to transcribe; every upstream test that needs a complete mip
    /// pyramid through `sglr::Context` uploads each level with its own
    /// `texImage2D(level, ...)` call instead. This is therefore new code, and the
    /// downsample rule it uses (`box_filter_downsample`/`mip_src_range` below) is a
    /// judgment call this reference model gets to make, not something upstream states -
    /// see `mip_src_range`'s own doc comment for the rule and why it was chosen over a
    /// plain always-2-wide box, and `box_filter_downsample`'s own doc comment for how
    /// one fully 3D function serves every type without needing to special-case any of
    /// them: `GL_TEXTURE_2D` directly, `GL_TEXTURE_CUBE_MAP` one call per face (a
    /// `TextureCube` already stores each face as its own standalone `TextureLevel`),
    /// and `GL_TEXTURE_2D_ARRAY`/`GL_TEXTURE_CUBE_MAP_ARRAY` one call over the whole
    /// level with every layer downsampled independently because the destination's own
    /// layer count never halves for either (`TextureCubeArray`'s layer count being
    /// `6 * arrayLength` rather than a bare layer count changes nothing here - it is
    /// still just "the size that doesn't halve"). `GL_TEXTURE_3D` is the one real
    /// three-dimensional case: one call over the whole level again, but this time with
    /// the destination's depth genuinely halved too.
    ///
    /// Reports `GL_INVALID_OPERATION` if level 0 (or, for a cube map, face 0 of level 0,
    /// the same existence probe `TextureCube::is_complete` itself uses - see that
    /// method's own doc comment for why any one fixed face is equivalent) is absent,
    /// and `GL_INVALID_ENUM` for any other `target` value. A cube map's incomplete
    /// faces (some face of the parent level missing, not reachable through this port's
    /// own `tex_image_2d`, which requires an explicit upload per face, but defended
    /// against anyway) are simply left absent at the child level too, rather than
    /// panicking: `is_complete` already reports such a texture incomplete regardless,
    /// and skipping is strictly more informative than fabricating a face from nothing.
    ///
    /// Every level from 1 up to the base level's own mip-pyramid depth (`num_mip_levels_2d`
    /// for the four types whose own `is_complete` uses it, `num_mip_levels_3d` for
    /// `GL_TEXTURE_3D`) is (re)computed from its own parent, unconditionally overwriting
    /// whatever was there before - exactly real GL's own behaviour, and irrespective of
    /// `GL_TEXTURE_MAX_LEVEL`/the current min filter (which only ever bound how much of
    /// an already-built pyramid `is_complete`/`resolve_sampler` read, never how much of
    /// one this builds).
    pub fn generate_mipmap(&mut self, target: GLenum) {
        let Some(kind) = classify_texture_target(target) else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        let unit = self.active_texture_unit as usize;

        match kind {
            TextureTargetKind::D2 => {
                let Some(tex_name) = self.texture_2d_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_2d_mut()
                    .expect("GL_TEXTURE_2D binding must name a Texture2D");
                let Some(level0) = texture.level(0) else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let format = level0.format();
                let [w, h, _] = level0.size();
                let num_levels = num_mip_levels_2d(w, h);

                for level_ndx in 1..num_levels {
                    let dst_w = mip_level_size(w, level_ndx as u32);
                    let dst_h = mip_level_size(h, level_ndx as u32);
                    let mut new_level = TextureLevel::new(format, dst_w, dst_h, 1)
                        .expect("mip dimensions derived from an existing level must themselves be valid");
                    {
                        let src = texture.level(level_ndx - 1).expect("the parent level was either level 0 (checked above) or was just computed by the previous loop iteration").get_const_access();
                        let mut dst = new_level.get_access();
                        box_filter_downsample(&src, &mut dst);
                    }
                    texture.levels.insert(level_ndx, new_level);
                }
            }
            TextureTargetKind::Cube => {
                let Some(tex_name) = self.texture_cube_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_cube_mut()
                    .expect("GL_TEXTURE_CUBE_MAP binding must name a TextureCube");
                let Some(probe) = texture.face(0, 0) else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let format = probe.format();
                let [w, h, _] = probe.size();
                let num_levels = num_mip_levels_2d(w, h);

                for level_ndx in 1..num_levels {
                    let dst_w = mip_level_size(w, level_ndx as u32);
                    let dst_h = mip_level_size(h, level_ndx as u32);
                    for face_index in 0..6usize {
                        let new_face = texture.face(level_ndx - 1, face_index).map(|src_face| {
                            let src = src_face.get_const_access();
                            let mut new_level = TextureLevel::new(format, dst_w, dst_h, 1)
                                .expect("mip dimensions derived from an existing level must themselves be valid");
                            box_filter_downsample(&src, &mut new_level.get_access());
                            new_level
                        });
                        if let Some(new_face) = new_face {
                            texture
                                .levels
                                .entry(level_ndx)
                                .or_insert_with(|| std::array::from_fn(|_| None))[face_index] = Some(new_face);
                        }
                    }
                }
            }
            TextureTargetKind::D2Array => {
                let Some(tex_name) = self.texture_2d_array_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_2d_array_mut()
                    .expect("GL_TEXTURE_2D_ARRAY binding must name a Texture2DArray");
                let Some(level0) = texture.level(0) else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let format = level0.format();
                let [w, h, num_layers] = level0.size();
                let num_levels = num_mip_levels_2d(w, h);

                // One call per level over the *whole* layered volume, not a per-layer
                // loop: `box_filter_downsample`'s own doc comment explains why passing
                // equal depth on both sides (the layer count here never halves) already
                // gives independent per-layer downsampling for free.
                for level_ndx in 1..num_levels {
                    let dst_w = mip_level_size(w, level_ndx as u32);
                    let dst_h = mip_level_size(h, level_ndx as u32);
                    let mut new_level = TextureLevel::new(format, dst_w, dst_h, num_layers)
                        .expect("mip dimensions derived from an existing level must themselves be valid");
                    {
                        let src = texture.level(level_ndx - 1).expect("the parent level was either level 0 (checked above) or was just computed by the previous loop iteration").get_const_access();
                        let mut dst = new_level.get_access();
                        box_filter_downsample(&src, &mut dst);
                    }
                    texture.levels.insert(level_ndx, new_level);
                }
            }
            TextureTargetKind::D3 => {
                let Some(tex_name) = self.texture_3d_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_3d_mut()
                    .expect("GL_TEXTURE_3D binding must name a Texture3D");
                let Some(level0) = texture.level(0) else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let format = level0.format();
                let [w, h, d] = level0.size();
                let num_levels = num_mip_levels_3d(w, h, d);

                for level_ndx in 1..num_levels {
                    let dst_w = mip_level_size(w, level_ndx as u32);
                    let dst_h = mip_level_size(h, level_ndx as u32);
                    let dst_d = mip_level_size(d, level_ndx as u32);
                    let mut new_level = TextureLevel::new(format, dst_w, dst_h, dst_d)
                        .expect("mip dimensions derived from an existing level must themselves be valid");
                    {
                        let src = texture.level(level_ndx - 1).expect("the parent level was either level 0 (checked above) or was just computed by the previous loop iteration").get_const_access();
                        let mut dst = new_level.get_access();
                        box_filter_downsample(&src, &mut dst);
                    }
                    texture.levels.insert(level_ndx, new_level);
                }
            }
            TextureTargetKind::CubeArray => {
                let Some(tex_name) = self.texture_cube_array_bindings[unit] else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let texture = self
                    .textures
                    .find_mut(tex_name)
                    .expect("bound texture must exist")
                    .as_cube_array_mut()
                    .expect("GL_TEXTURE_CUBE_MAP_ARRAY binding must name a TextureCubeArray");
                let Some(level0) = texture.level(0) else {
                    self.set_error(glw::GL_INVALID_OPERATION);
                    return;
                };
                let format = level0.format();
                let [w, h, num_layers] = level0.size();
                let num_levels = num_mip_levels_2d(w, h);

                // Same shape as GL_TEXTURE_2D_ARRAY above: one call over the whole
                // layered volume, relying on box_filter_downsample's own doc comment
                // for why equal depth on both sides already means every layer (here,
                // every face of every array element) downsamples independently.
                for level_ndx in 1..num_levels {
                    let dst_w = mip_level_size(w, level_ndx as u32);
                    let dst_h = mip_level_size(h, level_ndx as u32);
                    let mut new_level = TextureLevel::new(format, dst_w, dst_h, num_layers)
                        .expect("mip dimensions derived from an existing level must themselves be valid");
                    {
                        let src = texture.level(level_ndx - 1).expect("the parent level was either level 0 (checked above) or was just computed by the previous loop iteration").get_const_access();
                        let mut dst = new_level.get_access();
                        box_filter_downsample(&src, &mut dst);
                    }
                    texture.levels.insert(level_ndx, new_level);
                }
            }
            TextureTargetKind::Buffer => {
                // `GL_TEXTURE_BUFFER` has no mip chain at all (and real GL agrees:
                // `glGenerateMipmap(GL_TEXTURE_BUFFER)` is `GL_INVALID_ENUM`).
                self.set_error(glw::GL_INVALID_ENUM);
            }
        }
    }

    // --- Program objects ---

    /// `ReferenceContext::createProgram`, `Plain` shape - see `ProgramObject`'s own doc
    /// comment.
    pub fn create_program(
        &mut self,
        vertex_shader: Box<dyn VertexShader>,
        fragment_shader: Box<dyn FragmentShader>,
    ) -> u32 {
        let name = self.programs.allocate_name();
        self.programs.insert(
            name,
            ProgramObject::Plain {
                vertex_shader,
                fragment_shader,
            },
        );
        name
    }

    /// `ReferenceContext::createProgram(ShaderProgram*)`, `Declared` shape - the path
    /// `sglr::Context::create_program` (the trait impl below) goes through.
    pub fn create_shader_program(&mut self, program: Box<dyn ShaderProgram>) -> u32 {
        let name = self.programs.allocate_name();
        self.programs.insert(name, ProgramObject::Declared(program));
        name
    }

    /// `ReferenceContext::useProgram`
    pub fn use_program(&mut self, program: u32) {
        let new_binding = if program != 0 {
            if self.programs.find(program).is_none() {
                self.set_error(glw::GL_INVALID_VALUE);
                return;
            }
            Some(program)
        } else {
            None
        };

        if let Some(name) = new_binding {
            self.programs.acquire_reference(name);
        }
        if let Some(old) = self.current_program {
            self.programs.release_reference(old);
        }
        self.current_program = new_binding;
    }

    /// `ReferenceContext::deleteProgram` - narrowed to the "unbinding deletes it"
    /// half (`m_deleteFlag` always true here, since upstream's flag exists only to
    /// support the separate `attachShader`/`linkProgram`/... multi-call GL flow this
    /// port's `createProgram` collapses into one call to begin with).
    pub fn delete_program(&mut self, program: u32) {
        if program == 0 || self.programs.find(program).is_none() {
            return;
        }
        if self.current_program == Some(program) {
            self.use_program(0);
            return;
        }
        self.programs.release_reference(program);
    }

    pub fn current_program(&self) -> Option<u32> {
        self.current_program
    }

    /// `ReferenceContext::getAttribLocation` - `-1` for an unknown name or a `Plain`
    /// program (see `ProgramObject::declared`'s own doc comment).
    pub fn get_attrib_location(&mut self, program: u32, name: &str) -> i32 {
        let Some(program_obj) = self.programs.find(program) else {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return -1;
        };
        let Some(declared) = program_obj.declared() else {
            return -1;
        };
        declared
            .program_base()
            .attribute_names()
            .iter()
            .position(|n| n == name)
            .map(|ndx| ndx as i32)
            .unwrap_or(-1)
    }

    /// `ReferenceContext::getUniformLocation`
    pub fn get_uniform_location(&mut self, program: u32, name: &str) -> i32 {
        let Some(program_obj) = self.programs.find(program) else {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return -1;
        };
        let Some(declared) = program_obj.declared() else {
            return -1;
        };
        declared
            .program_base()
            .uniforms()
            .iter()
            .position(|u| u.name == name)
            .map(|ndx| ndx as i32)
            .unwrap_or(-1)
    }

    /// `ReferenceContext::uniformv` narrowed to the `vec4`-of-`float` case
    /// (`glu::TYPE_FLOAT_VEC4`) - the only uniform type any in-scope caller declares
    /// (`u_color` in `es2fDepthTests.cpp`/`es2fStencilTests.cpp`'s `DepthShader`-
    /// equivalent). Widen the same way (a `type_` parameter plus a `UniformValue`
    /// variant per call) once a caller declares a different uniform type - grep the
    /// real `.cpp` first, the same method this whole file's top doc comment already
    /// establishes.
    pub fn uniform4fv(&mut self, location: i32, count: i32, v: &[f32]) {
        let Some(program_name) = self.current_program else {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        };
        if location == -1 {
            return;
        }
        let Some(program_obj) = self.programs.find_mut(program_name) else {
            unreachable!("current_program must name a live program");
        };
        let Some(declared) = program_obj.declared_mut() else {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        };
        let uniforms = declared.program_base_mut().uniforms_mut();
        let bad = location < 0
            || (location as usize) >= uniforms.len()
            || count != 1
            || v.len() < 4
            || uniforms[location as usize].type_ != DataType::FloatVec4;
        if bad {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        uniforms[location as usize].value = UniformValue::F32Vec4([v[0], v[1], v[2], v[3]]);
    }

    /// `ReferenceContext::uniform1i` / `uniform1iv`, narrowed to the cases this port can
    /// reach: a plain `glu::TYPE_INT` scalar, and every sampler type this port's texture
    /// objects back - the five colour-path types (`glu::TYPE_SAMPLER_2D`/`_CUBE`/
    /// `_2D_ARRAY`/`_3D`/`_CUBE_ARRAY`), the four shadow types
    /// (`_SAMPLER_2D_SHADOW`/`_CUBE_SHADOW`/`_2D_ARRAY_SHADOW`/`_CUBE_ARRAY_SHADOW`), the eight integer/
    /// unsigned types (`_INT_SAMPLER_2D`/`_CUBE`/`_2D_ARRAY`/`_3D`/`_CUBE_ARRAY` and
    /// their `UINT` counterparts) and the three buffer-sampler types
    /// (`_SAMPLER_BUFFER`/`_INT_SAMPLER_BUFFER`/`_UINT_SAMPLER_BUFFER`) - see this
    /// module's top doc comment. For a sampler
    /// uniform the stored value is the texture *unit* index, matching upstream's own
    /// "\note texture unit is stored to value" comment exactly - nothing here resolves
    /// it into an actual pixel source yet; that happens only at draw time, in
    /// `resolve_sampler_uniforms` below, which `draw_with_reference` calls right before
    /// building the `rr::Renderer` program.
    pub fn uniform1i(&mut self, location: i32, value: i32) {
        let Some(program_name) = self.current_program else {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        };
        if location == -1 {
            return;
        }
        let Some(program_obj) = self.programs.find_mut(program_name) else {
            unreachable!("current_program must name a live program");
        };
        let Some(declared) = program_obj.declared_mut() else {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        };
        let uniforms = declared.program_base_mut().uniforms_mut();
        if location < 0 || (location as usize) >= uniforms.len() {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        let slot = &mut uniforms[location as usize];
        match slot.type_ {
            DataType::Int
            | DataType::Sampler2D
            | DataType::SamplerCube
            | DataType::Sampler2DArray
            | DataType::Sampler3D
            | DataType::SamplerCubeArray
            | DataType::Sampler2DShadow
            | DataType::SamplerCubeShadow
            | DataType::Sampler2DArrayShadow
            | DataType::SamplerCubeArrayShadow
            | DataType::IntSampler2D
            | DataType::IntSamplerCube
            | DataType::IntSampler2DArray
            | DataType::IntSampler3D
            | DataType::IntSamplerCubeArray
            | DataType::UintSampler2D
            | DataType::UintSamplerCube
            | DataType::UintSampler2DArray
            | DataType::UintSampler3D
            | DataType::UintSamplerCubeArray
            | DataType::SamplerBuffer
            | DataType::IntSamplerBuffer
            | DataType::UintSamplerBuffer => slot.value = UniformValue::I32(value),
            _ => {
                if self.last_error == glw::GL_NO_ERROR {
                    self.last_error = glw::GL_INVALID_OPERATION;
                }
            }
        }
    }

    /// The `uniform4fv`/`uniform1i` preamble above (locate the current program's
    /// declared-uniform slot for `location`, with the exact same error/early-return
    /// sequence both of those already establish - `location == -1` is silently
    /// ignored, anything else invalid sets `GL_INVALID_OPERATION`), factored out for
    /// `uniform1f` and the six new entry points below so `uniform4fv`/`uniform1i`
    /// themselves stay exactly as already committed and tested.
    fn uniform_slot_for_write(&mut self, location: i32) -> Option<&mut UniformSlot> {
        let Some(program_name) = self.current_program else {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return None;
        };
        if location == -1 {
            return None;
        }
        let Some(program_obj) = self.programs.find_mut(program_name) else {
            unreachable!("current_program must name a live program");
        };
        let Some(declared) = program_obj.declared_mut() else {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return None;
        };
        let uniforms = declared.program_base_mut().uniforms_mut();
        if location < 0 || (location as usize) >= uniforms.len() {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return None;
        }
        Some(&mut uniforms[location as usize])
    }

    /// `ReferenceContext::uniformv` narrowed to the plain scalar-`float` case
    /// (`glu::TYPE_FLOAT`) - see `uniform4fv`'s own doc comment for why a single
    /// `type_` case per narrowing is the established shape here. `draw.*`'s own need
    /// (`glsDrawTest.cpp`'s `u_coordScale`/`u_colorScale`).
    /// `ReferenceContext::uniformMatrix3fv` - the slot holds the matrix row-major, so column-major input
    /// (`transpose == false`) is transposed on the way in, exactly as upstream.
    pub fn uniform_matrix3fv(&mut self, location: i32, count: i32, transpose: bool, v: &[f32]) {
        let Some(slot) = self.uniform_slot_for_write(location) else {
            return;
        };
        if count == 0 {
            return;
        }
        if count > 1 || v.len() < 9 || slot.type_ != DataType::FloatMat3 {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        let mut m = [0.0f32; 9];
        for row in 0..3 {
            for col in 0..3 {
                m[row * 3 + col] = if transpose { v[row * 3 + col] } else { v[col * 3 + row] };
            }
        }
        slot.value = UniformValue::Mat3(m);
    }

    pub fn uniform1f(&mut self, location: i32, value: f32) {
        let Some(slot) = self.uniform_slot_for_write(location) else {
            return;
        };
        match slot.type_ {
            DataType::Float => slot.value = UniformValue::F32(value),
            _ => {
                if self.last_error == glw::GL_NO_ERROR {
                    self.last_error = glw::GL_INVALID_OPERATION;
                }
            }
        }
    }

    /// `ReferenceContext::uniformv` narrowed to the plain scalar `float` case
    /// (`glu::TYPE_FLOAT`, `numElements == 1`) - `glsFragOpInteractionCase.cpp`'s own
    /// `setUniformValue` grep-confirmed need (not yet a registered case - see
    /// `gls::frag_op_interaction_case`'s own top doc comment), alongside
    /// `uniform2fv`/`uniform3fv` below (`uniform4fv` already existed). `rsg::VariableType`
    /// never declares anything wider than a 4-component vector, so there is no
    /// `uniform1fv`-and-`count != 1` case to support here - matching `uniform4fv`'s own
    /// `count != 1` rejection.
    pub fn uniform1fv(&mut self, location: i32, count: i32, v: &[f32]) {
        let Some(slot) = self.uniform_slot_for_write(location) else {
            return;
        };
        if count != 1 || v.is_empty() || slot.type_ != DataType::Float {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        slot.value = UniformValue::F32(v[0]);
    }

    /// `ReferenceContext::uniformv` narrowed to `glu::TYPE_FLOAT_VEC2` - see
    /// `uniform1fv`'s own doc comment above.
    pub fn uniform2fv(&mut self, location: i32, count: i32, v: &[f32]) {
        let Some(slot) = self.uniform_slot_for_write(location) else {
            return;
        };
        if count != 1 || v.len() < 2 || slot.type_ != DataType::FloatVec2 {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        slot.value = UniformValue::F32Vec2([v[0], v[1]]);
    }

    /// `ReferenceContext::uniformv` narrowed to `glu::TYPE_FLOAT_VEC3` - see
    /// `uniform1fv`'s own doc comment above.
    pub fn uniform3fv(&mut self, location: i32, count: i32, v: &[f32]) {
        let Some(slot) = self.uniform_slot_for_write(location) else {
            return;
        };
        if count != 1 || v.len() < 3 || slot.type_ != DataType::FloatVec3 {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        slot.value = UniformValue::F32Vec3([v[0], v[1], v[2]]);
    }

    /// `ReferenceContext::uniformv` narrowed to the plain scalar `int`/sampler case
    /// (`glu::TYPE_INT` plus every sampler type `uniform1i` above already accepts,
    /// `numElements == 1`) - the `uniform1iv`-shaped sibling of `uniform1i` itself,
    /// both grep-confirmed called by `glsFragOpInteractionCase.cpp`'s own
    /// `setUniformValue` for the exact same source types (it reaches `uniform1iv`
    /// rather than `uniform1i` because it always calls through the `*v` family
    /// regardless of count). **Deliberately does not accept `DataType::Bool`** even
    /// though upstream's own `setUniformValue` groups `rsg::VariableType::TYPE_BOOL`
    /// into this same source-type switch - `uniform1i` above never gained `Bool`
    /// support either (grepped: nothing in scope today declares a bool-typed uniform),
    /// so this mirrors that same pre-existing narrowing rather than widening past it
    /// speculatively; a future caller that actually declares a `bool` `rsg` uniform
    /// needs both `uniform1i` and this function widened together.
    pub fn uniform1iv(&mut self, location: i32, count: i32, v: &[i32]) {
        let Some(slot) = self.uniform_slot_for_write(location) else {
            return;
        };
        let valid_type = matches!(
            slot.type_,
            DataType::Int
                | DataType::Bool
                | DataType::Sampler2D
                | DataType::SamplerCube
                | DataType::Sampler2DArray
                | DataType::Sampler3D
                | DataType::SamplerCubeArray
                | DataType::Sampler2DShadow
                | DataType::SamplerCubeShadow
                | DataType::Sampler2DArrayShadow
                | DataType::IntSampler2D
                | DataType::IntSamplerCube
                | DataType::IntSampler2DArray
                | DataType::IntSampler3D
                | DataType::IntSamplerCubeArray
                | DataType::UintSampler2D
                | DataType::UintSamplerCube
                | DataType::UintSampler2DArray
                | DataType::UintSampler3D
                | DataType::UintSamplerCubeArray
        );
        if count != 1 || v.is_empty() || !valid_type {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        slot.value = UniformValue::I32(v[0]);
    }

    /// `ReferenceContext::uniformv` narrowed to `glu::TYPE_INT_VEC2` - see
    /// `uniform1iv`'s own doc comment above for why there is no sampler/`Bool` case
    /// here (no sampler type is ever wider than one component).
    pub fn uniform2iv(&mut self, location: i32, count: i32, v: &[i32]) {
        let Some(slot) = self.uniform_slot_for_write(location) else {
            return;
        };
        if count != 1 || v.len() < 2 || !matches!(slot.type_, DataType::IntVec2 | DataType::BoolVec2) {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        slot.value = UniformValue::I32Vec2([v[0], v[1]]);
    }

    /// `ReferenceContext::uniformv` narrowed to `glu::TYPE_INT_VEC3` - see
    /// `uniform1iv`'s own doc comment above.
    pub fn uniform3iv(&mut self, location: i32, count: i32, v: &[i32]) {
        let Some(slot) = self.uniform_slot_for_write(location) else {
            return;
        };
        if count != 1 || v.len() < 3 || !matches!(slot.type_, DataType::IntVec3 | DataType::BoolVec3) {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        slot.value = UniformValue::I32Vec3([v[0], v[1], v[2]]);
    }

    /// `ReferenceContext::uniformv` narrowed to `glu::TYPE_INT_VEC4` - see
    /// `uniform1iv`'s own doc comment above.
    pub fn uniform4iv(&mut self, location: i32, count: i32, v: &[i32]) {
        let Some(slot) = self.uniform_slot_for_write(location) else {
            return;
        };
        if count != 1 || v.len() < 4 || !matches!(slot.type_, DataType::IntVec4 | DataType::BoolVec4) {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_OPERATION;
            }
            return;
        }
        slot.value = UniformValue::I32Vec4([v[0], v[1], v[2], v[3]]);
    }

    /// `ReferenceContext::readPixels` (the `tcu::Surface&` overload) - reads the bound
    /// *read* framebuffer's colour attachment (the default colour buffer if none is
    /// bound), always as `GL_RGBA`/`GL_UNSIGNED_BYTE`, matching upstream's own helper
    /// overload exactly (it always forwards to the 8-argument form with those two
    /// fixed).
    pub fn read_pixels(&mut self, dst: &mut Surface, x: i32, y: i32, width: i32, height: i32) {
        dst.set_size(width, height);
        let access = resolve_color_target(
            self.read_framebuffer_binding,
            &self.framebuffers,
            &mut self.renderbuffers,
            &mut self.textures,
            &mut self.color_buffer,
        );
        let size = access.size();
        if x < 0 || y < 0 || (x as u32) + (width as u32) > size[0] || (y as u32) + (height as u32) > size[1] {
            if self.last_error == glw::GL_NO_ERROR {
                self.last_error = glw::GL_INVALID_VALUE;
            }
            return;
        }
        let const_access = access.as_const();
        let region = const_access.get_subregion(x as u32, y as u32, 0, width as u32, height as u32, 1);
        for row in 0..height {
            for column in 0..width {
                let pixel = region.get_pixel(column as u32, row as u32, 0);
                dst.set_pixel(
                    column,
                    row,
                    RGBA::from_vec(Vec4::new(pixel[0], pixel[1], pixel[2], pixel[3])),
                );
            }
        }
    }

    /// `ReferenceContext::invalidateFramebuffer` - the whole of whatever is bound, as upstream
    /// (`invalidateSubFramebuffer` over `(0, 0, max width, max height)`; `intersect_rect` clamps per buffer).
    pub fn invalidate_framebuffer(&mut self, target: GLenum, attachments: &[GLenum]) {
        self.invalidate_sub_framebuffer(target, attachments, 0, 0, i32::MAX, i32::MAX);
    }

    /// `ReferenceContext::invalidateSubFramebuffer` - the invalidated area is reset to a defined value (colour 0,
    /// depth 1, stencil 0), exactly as upstream. Like upstream it accepts `GL_FRAMEBUFFER` only.
    pub fn invalidate_sub_framebuffer(
        &mut self,
        target: GLenum,
        attachments: &[GLenum],
        x: i32,
        y: i32,
        width: i32,
        height: i32,
    ) {
        if target != glw::GL_FRAMEBUFFER {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if width < 0 || height < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }

        let is_fbo_bound = self.draw_framebuffer_binding.is_some();
        let mut discard_buffers = [false; 3]; // Color, depth, stencil

        for &attachment in attachments {
            let is_color = attachment
                == if is_fbo_bound {
                    glw::GL_COLOR_ATTACHMENT0
                } else {
                    glw::GL_COLOR
                };
            let is_depth = attachment
                == if is_fbo_bound {
                    glw::GL_DEPTH_ATTACHMENT
                } else {
                    glw::GL_DEPTH
                };
            let is_stencil = attachment
                == if is_fbo_bound {
                    glw::GL_STENCIL_ATTACHMENT
                } else {
                    glw::GL_STENCIL
                };
            let is_depth_stencil = is_fbo_bound && attachment == glw::GL_DEPTH_STENCIL_ATTACHMENT;

            if !is_color && !is_depth && !is_stencil && !is_depth_stencil {
                self.set_error(glw::GL_INVALID_VALUE);
                return;
            }

            if is_color {
                discard_buffers[0] = true;
            }
            if is_depth || is_depth_stencil {
                discard_buffers[1] = true;
            }
            if is_stencil || is_depth_stencil {
                discard_buffers[2] = true;
            }
        }

        let (mut color, mut depth, mut stencil) = resolve_targets(
            self.draw_framebuffer_binding,
            &self.framebuffers,
            &mut self.renderbuffers,
            &mut self.textures,
            &mut self.color_buffer,
            self.depth_buffer.as_mut(),
            self.stencil_buffer.as_mut(),
        );
        let area_of = |size: [u32; 3]| intersect_rect((0, 0, size[0] as i32, size[1] as i32), (x, y, width, height));

        if discard_buffers[0] {
            let area = area_of(color.size());
            for yo in area.1..area.1 + area.3 {
                for xo in area.0..area.0 + area.2 {
                    color.set_pixel([0.0; 4], xo as u32, yo as u32, 0);
                }
            }
        }
        if discard_buffers[1]
            && let Some(access) = depth.as_mut()
        {
            let area = area_of(access.size());
            for yo in area.1..area.1 + area.3 {
                for xo in area.0..area.0 + area.2 {
                    access.set_pix_depth(1.0, xo as u32, yo as u32, 0);
                }
            }
        }
        if discard_buffers[2]
            && let Some(access) = stencil.as_mut()
        {
            let area = area_of(access.size());
            for yo in area.1..area.1 + area.3 {
                for xo in area.0..area.0 + area.2 {
                    access.set_pix_stencil(0, xo as u32, yo as u32, 0);
                }
            }
        }
    }

    /// `ReferenceContext::blitFramebuffer`, single-sample only (a multisampled read buffer cannot be
    /// represented here). The source region is copied out first so the read and draw framebuffers may be
    /// the same object; sRGB conversion is always on, as for an ES context. Upstream's colour branch tests
    /// `filter == tcu::Sampler::LINEAR` (the tcu enum, value 1) against a GL enum, which is never true, so
    /// a `GL_LINEAR` blit between two non-float, non-sRGB buffers copies nearest - kept as is.
    #[allow(clippy::too_many_arguments)]
    pub fn blit_framebuffer(
        &mut self,
        src_x0: i32,
        src_y0: i32,
        src_x1: i32,
        src_y1: i32,
        dst_x0: i32,
        dst_y0: i32,
        dst_x1: i32,
        dst_y1: i32,
        mask: GLenum,
        filter: GLenum,
    ) {
        use crate::tcu::pixel::CompareMode;
        use crate::tcu::texture::TextureChannelClass;

        let src_w = (src_x1 - src_x0).abs();
        let src_h = (src_y1 - src_y0).abs();
        let dst_w = (dst_x1 - dst_x0).abs();
        let dst_h = (dst_y1 - dst_y0).abs();
        let scale = src_w != dst_w || src_h != dst_h;
        let mut src_rect = (src_x0.min(src_x1), src_y0.min(src_y1), src_w, src_h);
        let mut dst_rect = (dst_x0.min(dst_x1), dst_y0.min(dst_y1), dst_w, dst_h);

        if filter != glw::GL_NEAREST && filter != glw::GL_LINEAR {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if (mask & (glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT)) != 0 && filter != glw::GL_NEAREST {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }

        // Validate that both targets are complete.
        if self.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE
            || self.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE
        {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }

        let want_color = mask & glw::GL_COLOR_BUFFER_BIT != 0;
        let want_depth = mask & glw::GL_DEPTH_BUFFER_BIT != 0;
        let want_stencil = mask & glw::GL_STENCIL_BUFFER_BIT != 0;
        let rect_of = |size: [u32; 3]| (0, 0, size[0] as i32, size[1] as i32);

        // Compute the source rectangle and copy the source out.
        let mut color_src: Option<(crate::tcu::texture::TextureFormat, Vec<u8>)> = None;
        let mut depth_src: Vec<f32> = Vec::new();
        let mut stencil_src: Vec<u32> = Vec::new();
        {
            let (r_color, r_depth, r_stencil) = resolve_targets(
                self.read_framebuffer_binding,
                &self.framebuffers,
                &mut self.renderbuffers,
                &mut self.textures,
                &mut self.color_buffer,
                self.depth_buffer.as_mut(),
                self.stencil_buffer.as_mut(),
            );

            if want_color {
                src_rect = intersect_rect(src_rect, rect_of(r_color.size()));
            }
            if want_depth {
                src_rect = intersect_rect(src_rect, r_depth.as_ref().map_or((0, 0, 0, 0), |a| rect_of(a.size())));
            }
            if want_stencil {
                src_rect = intersect_rect(src_rect, r_stencil.as_ref().map_or((0, 0, 0, 0), |a| rect_of(a.size())));
            }
            if src_rect.2 <= 0 || src_rect.3 <= 0 {
                return; // Don't attempt copy.
            }

            if want_color {
                let access = r_color.as_const();
                let format = access.format();
                let pixel_size = format
                    .pixel_size()
                    .expect("colour attachment formats have a pixel size") as usize;
                let mut data = Vec::with_capacity(src_rect.2 as usize * src_rect.3 as usize * pixel_size);
                for y in 0..src_rect.3 {
                    for x in 0..src_rect.2 {
                        data.extend_from_slice(
                            &access.pixel((src_rect.0 + x) as u32, (src_rect.1 + y) as u32, 0)[..pixel_size],
                        );
                    }
                }
                color_src = Some((format, data));
            }
            if want_depth && let Some(access) = r_depth.as_ref() {
                for y in 0..src_rect.3 {
                    for x in 0..src_rect.2 {
                        depth_src.push(access.get_pix_depth((src_rect.0 + x) as u32, (src_rect.1 + y) as u32, 0));
                    }
                }
            }
            if want_stencil && let Some(access) = r_stencil.as_ref() {
                for y in 0..src_rect.3 {
                    for x in 0..src_rect.2 {
                        stencil_src.push(access.get_pix_stencil((src_rect.0 + x) as u32, (src_rect.1 + y) as u32, 0));
                    }
                }
            }
        }

        let scissor_enabled = self.scissor_enabled;
        let scissor_box = self.scissor_box;
        let depth_mask = self.depth_mask;
        let stencil_write_mask = self.stencil[crate::rr::render_state::FaceType::Front as usize].write_mask;
        let (mut d_color, mut d_depth, mut d_stencil) = resolve_targets(
            self.draw_framebuffer_binding,
            &self.framebuffers,
            &mut self.renderbuffers,
            &mut self.textures,
            &mut self.color_buffer,
            self.depth_buffer.as_mut(),
            self.stencil_buffer.as_mut(),
        );

        // Compute the destination rectangle.
        if want_color {
            dst_rect = intersect_rect(dst_rect, rect_of(d_color.size()));
        }
        if want_depth {
            dst_rect = intersect_rect(dst_rect, d_depth.as_ref().map_or((0, 0, 0, 0), |a| rect_of(a.size())));
        }
        if want_stencil {
            dst_rect = intersect_rect(dst_rect, d_stencil.as_ref().map_or((0, 0, 0, 0), |a| rect_of(a.size())));
        }
        if scissor_enabled {
            dst_rect = intersect_rect(dst_rect, scissor_box);
        }
        if dst_rect.2 <= 0 || dst_rect.3 <= 0 {
            return; // Don't attempt copy.
        }

        // Coordinate transformation: dst offset space -> dst rectangle space -> src rectangle space -> src offset space.
        let ratio_x = (src_x1 - src_x0) as f32 / (dst_x1 - dst_x0) as f32;
        let ratio_y = (src_y1 - src_y0) as f32 / (dst_y1 - dst_y0) as f32;
        let source_coords = |xo: i32, yo: i32| {
            let d_x = xo as f32 + 0.5;
            let d_y = yo as f32 + 0.5;
            (
                ratio_x * (d_x + (dst_rect.0 - dst_x0) as f32) + (src_x0 - src_rect.0) as f32,
                ratio_y * (d_y + (dst_rect.1 - dst_y0) as f32) + (src_y0 - src_rect.1) as f32,
            )
        };

        if let Some((src_format, data)) = &color_src {
            let src = ConstPixelBufferAccess::new(*src_format, [src_rect.2 as u32, src_rect.3 as u32, 1], data);
            let dst_class = d_color.format().type_.channel_class();
            let dst_is_float = !matches!(
                dst_class,
                TextureChannelClass::SignedInteger | TextureChannelClass::UnsignedInteger
            );
            let s_filter = if scale && filter == glw::GL_LINEAR {
                FilterMode::Linear
            } else {
                FilterMode::Nearest
            };
            let sampler = Sampler {
                wrap_s: WrapMode::ClampToEdge,
                wrap_t: WrapMode::ClampToEdge,
                wrap_r: WrapMode::ClampToEdge,
                filter: s_filter,
                normalized_coords: false,
                compare: CompareMode::None,
                compare_channel: 0,
                mip_filter: None,
                seamless_cube_map: true,
            };
            let src_is_srgb = src.format().order.is_srgb();
            let dst_format = d_color.format();

            for yo in 0..dst_rect.3 {
                for xo in 0..dst_rect.2 {
                    let (s_x, s_y) = source_coords(xo, yo);

                    // do not copy pixels outside the modified source region (modified by buffer intersection)
                    if s_x < 0.0 || s_x >= src_rect.2 as f32 || s_y < 0.0 || s_y >= src_rect.3 as f32 {
                        continue;
                    }

                    let (dx, dy) = ((dst_rect.0 + xo) as u32, (dst_rect.1 + yo) as u32);
                    if dst_is_float || src_is_srgb || filter == 1 {
                        let p = src.sample_2d(&sampler, s_x, s_y, 0);
                        d_color.set_pixel(linear_to_srgb_if_needed(dst_format, p), dx, dy, 0);
                    } else {
                        let texel = src.get_pixel_int(s_x.floor() as u32, s_y.floor() as u32, 0);
                        let _ = d_color.set_pixel_int(texel, dx, dy, 0);
                    }
                }
            }
        }

        if want_depth
            && depth_mask
            && !depth_src.is_empty()
            && let Some(dst) = d_depth.as_mut()
        {
            for yo in 0..dst_rect.3 {
                for xo in 0..dst_rect.2 {
                    let (s_x, s_y) = source_coords(xo, yo);
                    let sx = (s_x.floor() as i32).clamp(0, src_rect.2 - 1);
                    let sy = (s_y.floor() as i32).clamp(0, src_rect.3 - 1);
                    dst.set_pix_depth(
                        depth_src[(sy * src_rect.2 + sx) as usize],
                        (dst_rect.0 + xo) as u32,
                        (dst_rect.1 + yo) as u32,
                        0,
                    );
                }
            }
        }

        if want_stencil
            && !stencil_src.is_empty()
            && let Some(dst) = d_stencil.as_mut()
        {
            let full_mask = stencil_bit_mask(num_stencil_bits_for_format(dst.format()));
            let write_mask = stencil_write_mask & full_mask;
            for yo in 0..dst_rect.3 {
                for xo in 0..dst_rect.2 {
                    let (s_x, s_y) = source_coords(xo, yo);
                    let sx = (s_x.floor() as i32).clamp(0, src_rect.2 - 1);
                    let sy = (s_y.floor() as i32).clamp(0, src_rect.3 - 1);
                    let (dx, dy) = ((dst_rect.0 + xo) as u32, (dst_rect.1 + yo) as u32);
                    let old = dst.get_pix_stencil(dx, dy, 0);
                    let src_stencil = stencil_src[(sy * src_rect.2 + sx) as usize];
                    dst.set_pix_stencil((old & !write_mask) | (src_stencil & write_mask), dx, dy, 0);
                }
            }
        }
    }

    /// `ReferenceContext::readPixels` for `GL_RGBA` with `GL_FLOAT`/`GL_INT`/`GL_UNSIGNED_INT` - see the trait method's
    /// doc comment. The bound read framebuffer's colour attachment is converted per pixel with `get_pixel`, which
    /// already yields the channel values as floats for every format class. Any other `type_` is `GL_INVALID_ENUM`.
    pub fn read_pixels_rgba_f32(&mut self, x: i32, y: i32, width: i32, height: i32, type_: GLenum) -> Vec<[f32; 4]> {
        if !matches!(type_, glw::GL_FLOAT | glw::GL_INT | glw::GL_UNSIGNED_INT) {
            self.set_error(glw::GL_INVALID_ENUM);
            return Vec::new();
        }
        let access = resolve_color_target(
            self.read_framebuffer_binding,
            &self.framebuffers,
            &mut self.renderbuffers,
            &mut self.textures,
            &mut self.color_buffer,
        );
        let size = access.size();
        if width < 0
            || height < 0
            || x < 0
            || y < 0
            || (x as u32) + (width as u32) > size[0]
            || (y as u32) + (height as u32) > size[1]
        {
            self.set_error(glw::GL_INVALID_VALUE);
            return Vec::new();
        }
        let const_access = access.as_const();
        let mut out = Vec::with_capacity(width as usize * height as usize);
        for row in 0..height {
            for column in 0..width {
                out.push(const_access.get_pixel((x + column) as u32, (y + row) as u32, 0));
            }
        }
        out
    }

    // --- Framebuffer state (default framebuffer only - see this module's top doc) ---

    /// `ReferenceContext::viewport`
    pub fn viewport(&mut self, x: i32, y: i32, width: i32, height: i32) {
        if width < 0 || height < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.viewport = WindowRectangle {
            left: x,
            bottom: y,
            width,
            height,
        };
    }

    /// `ReferenceContext::clearColor`
    pub fn clear_color(&mut self, red: f32, green: f32, blue: f32, alpha: f32) {
        self.clear_color = [
            red.clamp(0.0, 1.0),
            green.clamp(0.0, 1.0),
            blue.clamp(0.0, 1.0),
            alpha.clamp(0.0, 1.0),
        ];
    }

    /// `ReferenceContext::clearDepthf`
    pub fn clear_depthf(&mut self, depth: f32) {
        self.clear_depth = depth.clamp(0.0, 1.0);
    }

    /// `ReferenceContext::clearStencil`
    pub fn clear_stencil(&mut self, stencil: i32) {
        self.clear_stencil = stencil;
    }

    /// `ReferenceContext::clear`
    ///
    /// Now honours scissor, `colorMask`, `depthMask` and the stencil write mask - it
    /// used to clear the whole buffer unconditionally regardless of any of the four,
    /// which happened to be invisible to every pre-existing `#[test]` here only
    /// because every one of them clears with every mask at its GL-default (scissor
    /// disabled, all four colour channels writable, depth writable, stencil write mask
    /// `!0`) - see `clear_buffer_iv`/`clear_buffer_uiv`/`clear_buffer_fv`/
    /// `clear_buffer_fi` below for the sibling entry points this shares `intersect_rect`/
    /// `num_stencil_bits_for_format` with, and which first made the gap worth closing
    /// (a `glClearBufferiv`/`uiv`-initialised integer colour attachment needs the same
    /// scissor/mask handling `clear` was silently skipping).
    pub fn clear(&mut self, mask: GLenum) {
        if mask & !(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT) != 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }

        let base_area = if self.scissor_enabled {
            self.scissor_box
        } else {
            (0, 0, i32::MAX, i32::MAX)
        };

        if mask & glw::GL_COLOR_BUFFER_BIT != 0 {
            let mask_zero = !self.color_mask.iter().any(|&m| m);
            if !mask_zero {
                let mut access = resolve_color_target(
                    self.draw_framebuffer_binding,
                    &self.framebuffers,
                    &mut self.renderbuffers,
                    &mut self.textures,
                    &mut self.color_buffer,
                );
                let size = access.size();
                let area = intersect_rect(base_area, (0, 0, size[0] as i32, size[1] as i32));
                if area.2 > 0 && area.3 > 0 {
                    let mask_used = !self.color_mask.iter().all(|&m| m);
                    let color = linear_to_srgb_if_needed(access.format(), self.clear_color);
                    for y in area.1..area.1 + area.3 {
                        for x in area.0..area.0 + area.2 {
                            let c = if mask_used {
                                let original = access.as_const().get_pixel(x as u32, y as u32, 0);
                                let mut c = color;
                                for ch in 0..4 {
                                    if !self.color_mask[ch] {
                                        c[ch] = original[ch];
                                    }
                                }
                                c
                            } else {
                                color
                            };
                            access.set_pixel(c, x as u32, y as u32, 0);
                        }
                    }
                }
            }
        }
        if mask & glw::GL_DEPTH_BUFFER_BIT != 0
            && self.depth_mask
            && let Some(mut access) = resolve_optional_target(
                self.draw_framebuffer_binding,
                AttachmentPoint::Depth,
                &self.framebuffers,
                &mut self.renderbuffers,
                &mut self.textures,
                self.depth_buffer.as_mut(),
            )
        {
            let size = access.size();
            let area = intersect_rect(base_area, (0, 0, size[0] as i32, size[1] as i32));
            let depth = self.clear_depth;
            for y in area.1..area.1 + area.3 {
                for x in area.0..area.0 + area.2 {
                    // `set_pix_depth`, not plain `set_pixel` - a depth attachment can
                    // be a *combined* depth-stencil format (`GL_DEPTH24_STENCIL8`/
                    // `GL_DEPTH32F_STENCIL8`), and only `set_pix_depth` knows how to
                    // write just the depth channel's own bytes within that shared
                    // texel; `set_pixel`'s generic per-channel path has no notion of a
                    // combined format at all. Behaviour for an ordinary non-combined
                    // depth format (the only case this ever exercised before combined
                    // attachments were supported, see `resolve_targets`'s own doc
                    // comment) is unchanged - `set_pix_depth` falls through to the same
                    // single-channel `float_to_channel` encode `set_pixel` used.
                    access.set_pix_depth(depth, x as u32, y as u32, 0);
                }
            }
        }
        if mask & glw::GL_STENCIL_BUFFER_BIT != 0
            && let Some(mut access) = resolve_optional_target(
                self.draw_framebuffer_binding,
                AttachmentPoint::Stencil,
                &self.framebuffers,
                &mut self.renderbuffers,
                &mut self.textures,
                self.stencil_buffer.as_mut(),
            )
        {
            let size = access.size();
            let area = intersect_rect(base_area, (0, 0, size[0] as i32, size[1] as i32));
            let full_mask = stencil_bit_mask(num_stencil_bits_for_format(access.format()));
            // Widening a negative `glClearStencil` value through `as u32` keeps the
            // same bit pattern GL's own `GLint` parameter carries, matching
            // `set_pixel_int`'s old write before this masked path replaced it.
            let stencil = (self.clear_stencil as u32) & full_mask;
            let write_mask = self.stencil[crate::rr::render_state::FaceType::Front as usize].write_mask & full_mask;
            for y in area.1..area.1 + area.3 {
                for x in area.0..area.0 + area.2 {
                    // `(old & !write_mask) | (stencil & write_mask)` - `writeMaskedStencil`
                    // (sglrReferenceContext.cpp), folded into every pixel unconditionally
                    // rather than upstream's own fast/slow split on whether `write_mask`
                    // covers every real bit: `get_pix_stencil` already returns a value
                    // with every bit above the format's own width zero, so when
                    // `write_mask == full_mask` this reduces to `stencil` exactly, the
                    // same result the fast path gives - one code path for both, not a
                    // perf-only duplication of the same arithmetic.
                    let old = access.get_pix_stencil(x as u32, y as u32, 0);
                    access.set_pix_stencil((old & !write_mask) | (stencil & write_mask), x as u32, y as u32, 0);
                }
            }
        }
    }

    /// `ReferenceContext::clearBufferfv` - `buffer` is `GL_COLOR` or `GL_DEPTH`, unlike
    /// `clear` above this takes the value to write directly rather than reading
    /// `self.clear_color`/`self.clear_depth`. `drawbuffer` must be `0` - no MRT support,
    /// matching upstream's own `\todo [2012-04-06] MRT support` (not a narrowing this
    /// port introduced). `value` must hold at least 4 elements for `GL_COLOR`, 1 for
    /// `GL_DEPTH` - the caller's responsibility, same trust upstream's raw `const
    /// float*` places on its own caller.
    pub fn clear_buffer_fv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[f32]) {
        if buffer != glw::GL_COLOR && buffer != glw::GL_DEPTH {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if drawbuffer != 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }

        let base_area = if self.scissor_enabled {
            self.scissor_box
        } else {
            (0, 0, i32::MAX, i32::MAX)
        };

        if buffer == glw::GL_COLOR {
            let mask_zero = !self.color_mask.iter().any(|&m| m);
            if mask_zero {
                return;
            }
            let mut access = resolve_color_target(
                self.draw_framebuffer_binding,
                &self.framebuffers,
                &mut self.renderbuffers,
                &mut self.textures,
                &mut self.color_buffer,
            );
            let size = access.size();
            let area = intersect_rect(base_area, (0, 0, size[0] as i32, size[1] as i32));
            if area.2 <= 0 || area.3 <= 0 {
                return;
            }
            let mask_used = !self.color_mask.iter().all(|&m| m);
            let color = linear_to_srgb_if_needed(access.format(), [value[0], value[1], value[2], value[3]]);
            for y in area.1..area.1 + area.3 {
                for x in area.0..area.0 + area.2 {
                    let c = if mask_used {
                        let original = access.as_const().get_pixel(x as u32, y as u32, 0);
                        let mut c = color;
                        for ch in 0..4 {
                            if !self.color_mask[ch] {
                                c[ch] = original[ch];
                            }
                        }
                        c
                    } else {
                        color
                    };
                    access.set_pixel(c, x as u32, y as u32, 0);
                }
            }
        } else {
            debug_assert_eq!(buffer, glw::GL_DEPTH);
            if !self.depth_mask {
                return;
            }
            let Some(mut access) = resolve_optional_target(
                self.draw_framebuffer_binding,
                AttachmentPoint::Depth,
                &self.framebuffers,
                &mut self.renderbuffers,
                &mut self.textures,
                self.depth_buffer.as_mut(),
            ) else {
                return;
            };
            let size = access.size();
            let area = intersect_rect(base_area, (0, 0, size[0] as i32, size[1] as i32));
            let depth = value[0];
            for y in area.1..area.1 + area.3 {
                for x in area.0..area.0 + area.2 {
                    access.set_pix_depth(depth, x as u32, y as u32, 0);
                }
            }
        }
    }

    /// `ReferenceContext::clearBufferiv` - `buffer` is `GL_COLOR` (raw signed-integer
    /// write, via `set_pixel_int` exactly like `rr::fragment_operations`'
    /// `execute_signed_value_write`) or `GL_STENCIL` (`value[0]` only). See
    /// `clear_buffer_fv`'s own doc comment for the `drawbuffer`/slice-length notes,
    /// shared verbatim here.
    pub fn clear_buffer_iv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[i32]) {
        if buffer != glw::GL_COLOR && buffer != glw::GL_STENCIL {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if drawbuffer != 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }

        let base_area = if self.scissor_enabled {
            self.scissor_box
        } else {
            (0, 0, i32::MAX, i32::MAX)
        };

        if buffer == glw::GL_COLOR {
            let mask_zero = !self.color_mask.iter().any(|&m| m);
            if mask_zero {
                return;
            }
            let mut access = resolve_color_target(
                self.draw_framebuffer_binding,
                &self.framebuffers,
                &mut self.renderbuffers,
                &mut self.textures,
                &mut self.color_buffer,
            );
            let size = access.size();
            let area = intersect_rect(base_area, (0, 0, size[0] as i32, size[1] as i32));
            if area.2 <= 0 || area.3 <= 0 {
                return;
            }
            let mask_used = !self.color_mask.iter().all(|&m| m);
            let color = [value[0], value[1], value[2], value[3]];
            for y in area.1..area.1 + area.3 {
                for x in area.0..area.0 + area.2 {
                    let c = if mask_used {
                        let original = access.as_const().get_pixel_int(x as u32, y as u32, 0);
                        let mut c = color;
                        for ch in 0..4 {
                            if !self.color_mask[ch] {
                                c[ch] = original[ch];
                            }
                        }
                        c
                    } else {
                        color
                    };
                    let wrote = access.set_pixel_int(c, x as u32, y as u32, 0);
                    debug_assert!(
                        wrote,
                        "glClearBufferiv landed on a channel type TextureLevel::new already refused to create"
                    );
                }
            }
        } else {
            debug_assert_eq!(buffer, glw::GL_STENCIL);
            let Some(mut access) = resolve_optional_target(
                self.draw_framebuffer_binding,
                AttachmentPoint::Stencil,
                &self.framebuffers,
                &mut self.renderbuffers,
                &mut self.textures,
                None,
            ) else {
                return;
            };
            let size = access.size();
            let area = intersect_rect(base_area, (0, 0, size[0] as i32, size[1] as i32));
            let full_mask = stencil_bit_mask(num_stencil_bits_for_format(access.format()));
            let stencil = (value[0] as u32) & full_mask;
            let write_mask = self.stencil[crate::rr::render_state::FaceType::Front as usize].write_mask & full_mask;
            for y in area.1..area.1 + area.3 {
                for x in area.0..area.0 + area.2 {
                    let old = access.get_pix_stencil(x as u32, y as u32, 0);
                    access.set_pix_stencil((old & !write_mask) | (stencil & write_mask), x as u32, y as u32, 0);
                }
            }
        }
    }

    /// `ReferenceContext::clearBufferuiv` - `buffer` must be `GL_COLOR`. `set_pixel_int`
    /// already writes an unsigned channel's raw bit pattern rather than clamping a
    /// signed value into it (see `int_to_channel_bytes`'s own `UNSIGNED_INT32` arm in
    /// `tcu::pixel`) - the same bit-preserving round trip
    /// `rr::fragment_operations::execute_unsigned_value_write` relies on, run here at
    /// the `glClearBufferuiv` entry point instead of a fragment write.
    pub fn clear_buffer_uiv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[u32]) {
        if buffer != glw::GL_COLOR {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if drawbuffer != 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }

        let mask_zero = !self.color_mask.iter().any(|&m| m);
        if mask_zero {
            return;
        }

        let base_area = if self.scissor_enabled {
            self.scissor_box
        } else {
            (0, 0, i32::MAX, i32::MAX)
        };
        let mut access = resolve_color_target(
            self.draw_framebuffer_binding,
            &self.framebuffers,
            &mut self.renderbuffers,
            &mut self.textures,
            &mut self.color_buffer,
        );
        let size = access.size();
        let area = intersect_rect(base_area, (0, 0, size[0] as i32, size[1] as i32));
        if area.2 <= 0 || area.3 <= 0 {
            return;
        }
        let mask_used = !self.color_mask.iter().all(|&m| m);
        let color = [value[0] as i32, value[1] as i32, value[2] as i32, value[3] as i32];
        for y in area.1..area.1 + area.3 {
            for x in area.0..area.0 + area.2 {
                let c = if mask_used {
                    let original = access.as_const().get_pixel_uint64(x as u32, y as u32, 0);
                    let mut c = color;
                    for ch in 0..4 {
                        if !self.color_mask[ch] {
                            c[ch] = original[ch] as i32;
                        }
                    }
                    c
                } else {
                    color
                };
                let wrote = access.set_pixel_int(c, x as u32, y as u32, 0);
                debug_assert!(
                    wrote,
                    "glClearBufferuiv landed on a channel type TextureLevel::new already refused to create"
                );
            }
        }
    }

    /// `ReferenceContext::clearBufferfi` - `buffer` must be `GL_DEPTH_STENCIL`;
    /// upstream forwards straight into `clearBufferfv(GL_DEPTH, ...)` +
    /// `clearBufferiv(GL_STENCIL, ...)` and so does this, unconditionally - if
    /// `drawbuffer != 0` both sub-calls independently set `GL_INVALID_VALUE`, which
    /// `set_error`'s own sticky-until-queried behaviour collapses to one reported
    /// error, matching what upstream's two `RC_IF_ERROR`-guarded sub-functions do.
    pub fn clear_buffer_fi(&mut self, buffer: GLenum, drawbuffer: i32, depth: f32, stencil: i32) {
        if buffer != glw::GL_DEPTH_STENCIL {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        self.clear_buffer_fv(glw::GL_DEPTH, drawbuffer, &[depth]);
        self.clear_buffer_iv(glw::GL_STENCIL, drawbuffer, &[stencil]);
    }

    pub fn color_buffer(&self) -> &TextureLevel {
        &self.color_buffer
    }

    /// `ReferenceContext::getWidth`/`getHeight` - the default colour buffer's size,
    /// exactly as upstream's own implementation reads `m_defaultColorbuffer`
    /// regardless of which framebuffer happens to be bound.
    pub fn get_width(&self) -> i32 {
        self.color_buffer.size()[0] as i32
    }

    pub fn get_height(&self) -> i32 {
        self.color_buffer.size()[1] as i32
    }

    // --- Fixed-function-adjacent state ---

    /// `ReferenceContext::scissor`
    pub fn scissor(&mut self, x: i32, y: i32, width: i32, height: i32) {
        if width < 0 || height < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.scissor_box = (x, y, width, height);
    }

    /// `ReferenceContext::enable` - narrowed to the ES capabilities this context
    /// tracks; see this module's top doc comment for what GL state is not wired into
    /// a draw call yet even where a capability bit exists here (there is none such
    /// right now - every flag below is read by `draw_with_reference`). `GL_DITHER` is
    /// accepted and ignored, matching upstream exactly (dithering is not part of this
    /// pipeline at all). The GL-core-only capabilities upstream also handles here
    /// (`GL_FRAMEBUFFER_SRGB`, `GL_DEPTH_CLAMP`, `GL_PRIMITIVE_RESTART`) are dropped -
    /// this project has no desktop-GL root (see CLAUDE.md's "hodow_cts" section), so
    /// upstream's own `isContextTypeGLCore` branch for them is always the
    /// `GL_INVALID_ENUM` arm here.
    pub fn enable(&mut self, cap: GLenum) {
        match cap {
            glw::GL_BLEND => self.blend_enabled = true,
            glw::GL_SCISSOR_TEST => self.scissor_enabled = true,
            glw::GL_DEPTH_TEST => self.depth_test_enabled = true,
            glw::GL_STENCIL_TEST => self.stencil_test_enabled = true,
            glw::GL_POLYGON_OFFSET_FILL => self.polygon_offset_fill_enabled = true,
            glw::GL_DITHER => {}
            glw::GL_PRIMITIVE_RESTART_FIXED_INDEX => self.primitive_restart_fixed_index = true,
            _ => self.set_error(glw::GL_INVALID_ENUM),
        }
    }

    /// `ReferenceContext::disable`
    pub fn disable(&mut self, cap: GLenum) {
        match cap {
            glw::GL_BLEND => self.blend_enabled = false,
            glw::GL_SCISSOR_TEST => self.scissor_enabled = false,
            glw::GL_DEPTH_TEST => self.depth_test_enabled = false,
            glw::GL_STENCIL_TEST => self.stencil_test_enabled = false,
            glw::GL_POLYGON_OFFSET_FILL => self.polygon_offset_fill_enabled = false,
            glw::GL_DITHER => {}
            glw::GL_PRIMITIVE_RESTART_FIXED_INDEX => self.primitive_restart_fixed_index = false,
            _ => self.set_error(glw::GL_INVALID_ENUM),
        }
    }

    /// `ReferenceContext::stencilFuncSeparate`
    pub fn stencil_func_separate(&mut self, face: GLenum, func: GLenum, ref_: i32, mask: u32) {
        let set_front = face == glw::GL_FRONT || face == glw::GL_FRONT_AND_BACK;
        let set_back = face == glw::GL_BACK || face == glw::GL_FRONT_AND_BACK;

        if map_gl_test_func(func).is_none() {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if !set_front && !set_back {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }

        if set_front {
            self.stencil[0] = StencilFaceState {
                func,
                ref_,
                op_mask: mask,
                ..self.stencil[0]
            };
        }
        if set_back {
            self.stencil[1] = StencilFaceState {
                func,
                ref_,
                op_mask: mask,
                ..self.stencil[1]
            };
        }
    }

    pub fn stencil_func(&mut self, func: GLenum, ref_: i32, mask: u32) {
        self.stencil_func_separate(glw::GL_FRONT_AND_BACK, func, ref_, mask);
    }

    /// `ReferenceContext::stencilOpSeparate`
    pub fn stencil_op_separate(&mut self, face: GLenum, sfail: GLenum, dpfail: GLenum, dppass: GLenum) {
        let set_front = face == glw::GL_FRONT || face == glw::GL_FRONT_AND_BACK;
        let set_back = face == glw::GL_BACK || face == glw::GL_FRONT_AND_BACK;
        let valid_op = |op| map_gl_stencil_op(op).is_some();

        if !valid_op(sfail) || !valid_op(dpfail) || !valid_op(dppass) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if !set_front && !set_back {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }

        if set_front {
            self.stencil[0].op_stencil_fail = sfail;
            self.stencil[0].op_depth_fail = dpfail;
            self.stencil[0].op_depth_pass = dppass;
        }
        if set_back {
            self.stencil[1].op_stencil_fail = sfail;
            self.stencil[1].op_depth_fail = dpfail;
            self.stencil[1].op_depth_pass = dppass;
        }
    }

    pub fn stencil_op(&mut self, sfail: GLenum, dpfail: GLenum, dppass: GLenum) {
        self.stencil_op_separate(glw::GL_FRONT_AND_BACK, sfail, dpfail, dppass);
    }

    /// `ReferenceContext::stencilMaskSeparate`
    pub fn stencil_mask_separate(&mut self, face: GLenum, mask: u32) {
        let set_front = face == glw::GL_FRONT || face == glw::GL_FRONT_AND_BACK;
        let set_back = face == glw::GL_BACK || face == glw::GL_FRONT_AND_BACK;
        if !set_front && !set_back {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if set_front {
            self.stencil[0].write_mask = mask;
        }
        if set_back {
            self.stencil[1].write_mask = mask;
        }
    }

    pub fn stencil_mask(&mut self, mask: u32) {
        self.stencil_mask_separate(glw::GL_FRONT_AND_BACK, mask);
    }

    /// `ReferenceContext::depthFunc`
    pub fn depth_func(&mut self, func: GLenum) {
        if map_gl_test_func(func).is_none() {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        self.depth_func = func;
    }

    /// `ReferenceContext::depthRangef`
    pub fn depth_rangef(&mut self, n: f32, f: f32) {
        self.depth_range = (n.clamp(0.0, 1.0), f.clamp(0.0, 1.0));
    }

    pub fn depth_mask(&mut self, mask: bool) {
        self.depth_mask = mask;
    }

    /// `ReferenceContext::polygonOffset`
    pub fn polygon_offset(&mut self, factor: f32, units: f32) {
        self.polygon_offset_factor = factor;
        self.polygon_offset_units = units;
    }

    /// `ReferenceContext::blendEquationSeparate`
    pub fn blend_equation_separate(&mut self, mode_rgb: GLenum, mode_alpha: GLenum) {
        if map_gl_blend_equation(mode_rgb).is_none() || map_gl_blend_equation(mode_alpha).is_none() {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        self.blend_mode_rgb = mode_rgb;
        self.blend_mode_alpha = mode_alpha;
    }

    pub fn blend_equation(&mut self, mode: GLenum) {
        self.blend_equation_separate(mode, mode);
    }

    /// `ReferenceContext::blendFuncSeparate`
    pub fn blend_func_separate(&mut self, src_rgb: GLenum, dst_rgb: GLenum, src_alpha: GLenum, dst_alpha: GLenum) {
        let valid = |f| map_gl_blend_func(f).is_some();
        if !valid(src_rgb) || !valid(dst_rgb) || !valid(src_alpha) || !valid(dst_alpha) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        self.blend_factor_src_rgb = src_rgb;
        self.blend_factor_dst_rgb = dst_rgb;
        self.blend_factor_src_alpha = src_alpha;
        self.blend_factor_dst_alpha = dst_alpha;
    }

    pub fn blend_func(&mut self, src: GLenum, dst: GLenum) {
        self.blend_func_separate(src, dst, src, dst);
    }

    /// `ReferenceContext::blendColor`
    pub fn blend_color(&mut self, red: f32, green: f32, blue: f32, alpha: f32) {
        self.blend_color = [
            red.clamp(0.0, 1.0),
            green.clamp(0.0, 1.0),
            blue.clamp(0.0, 1.0),
            alpha.clamp(0.0, 1.0),
        ];
    }

    /// `ReferenceContext::colorMask`
    pub fn color_mask(&mut self, r: bool, g: bool, b: bool, a: bool) {
        self.color_mask = [r, g, b, a];
    }

    /// `ReferenceContext::lineWidth`
    pub fn line_width(&mut self, width: f32) {
        self.line_width = width;
    }

    // --- Draw calls ---

    /// `sglr::rr_util::mapGLPrimitiveType` plus upstream's `predrawErrorChecks`,
    /// narrowed to the mode check and the draw-framebuffer completeness check - there is
    /// no geometry shader slot to cross-check `mode` against (this module's top doc
    /// comment), and the buffer-mapping check upstream's own source comments out
    /// (`\todo [jarkko] Uncomment following code when the buffer mapping support is
    /// added`) has no buffer-mapping state here to check either.
    ///
    /// The framebuffer-completeness check was missing for a while after FBOs
    /// themselves landed - this function's own doc comment used to say "there is no
    /// real framebuffer object yet for `checkFramebufferStatus` to meaningfully
    /// reject", which stopped being true the moment `genFramebuffers`/
    /// `framebufferTexture2D`/`checkFramebufferStatus` were ported, and nothing ever
    /// came back to update either the doc comment or the check itself.
    /// `check_framebuffer_status(GL_DRAW_FRAMEBUFFER)` already exists and already does
    /// the real work (per-attachment existence/dimension/format agreement, matching
    /// upstream's own `GL_FRAMEBUFFER_COMPLETE`/`_INCOMPLETE_*` rules) - this just calls
    /// it before a draw proceeds, exactly where upstream's own `predrawErrorChecks`
    /// does, rather than leaving an incomplete FBO's draw silently well-defined when
    /// real GL would refuse it with `GL_INVALID_FRAMEBUFFER_OPERATION`.
    fn predraw_checks(&mut self, mode: GLenum) -> Option<PrimitiveType> {
        let primitive_type = match map_gl_primitive_type(mode) {
            Some(p) => p,
            None => {
                self.set_error(glw::GL_INVALID_ENUM);
                return None;
            }
        };

        if self.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
            self.set_error(glw::GL_INVALID_FRAMEBUFFER_OPERATION);
            return None;
        }

        Some(primitive_type)
    }

    /// `ReferenceContext::drawArrays`/`drawArraysInstanced`
    pub fn draw_arrays_instanced(&mut self, mode: GLenum, first: i32, count: i32, instance_count: i32) {
        if first < 0 || count < 0 || instance_count < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let Some(primitive_type) = self.predraw_checks(mode) else {
            return;
        };
        let primitives = PrimitiveList::from_arrays(primitive_type, count as usize, first);
        self.draw_with_reference(primitives, instance_count);
    }

    pub fn draw_arrays(&mut self, mode: GLenum, first: i32, count: i32) {
        self.draw_arrays_instanced(mode, first, count, 1);
    }

    /// `ReferenceContext::drawElementsInstancedBaseVertex` - `indices` is always a byte
    /// offset into the bound `GL_ELEMENT_ARRAY_BUFFER` here; a client-memory index
    /// array (no buffer bound) is not supported by this increment, matching how
    /// `build_vertex_attribs` already requires `GL_ARRAY_BUFFER` for a non-default VAO.
    pub fn draw_elements_instanced_base_vertex(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        instance_count: i32,
        base_vertex: i32,
    ) {
        if !matches!(
            type_,
            glw::GL_UNSIGNED_BYTE | glw::GL_UNSIGNED_SHORT | glw::GL_UNSIGNED_INT
        ) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        if count < 0 || instance_count < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        let Some(primitive_type) = self.predraw_checks(mode) else {
            return;
        };

        let vao = resolve_vao(
            self.vertex_array_binding,
            &self.vertex_arrays,
            &self.client_vertex_array,
        );
        let Some(element_buffer_name) = vao.element_array_buffer_binding else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        let buffer = self
            .buffers
            .find(element_buffer_name)
            .expect("bound element array buffer must exist");
        let indices = decode_indices(buffer.data(), type_, indices_offset, count as usize);

        // `decode_indices` always widens to an owned `u32` buffer (see this module's
        // own top doc comment on why) - `index_type` keeps the *original* GL element
        // type alongside it for `rr::PrimitiveList::index_type` (`validated by the
        // `matches!` check above, matching `decode_indices`' own `unreachable!` arm).
        let index_type = match type_ {
            glw::GL_UNSIGNED_BYTE => IndexType::Uint8,
            glw::GL_UNSIGNED_SHORT => IndexType::Uint16,
            glw::GL_UNSIGNED_INT => IndexType::Uint32,
            _ => unreachable!("type_ validated above"),
        };
        let draw_indices = RrDrawIndices::U32(&indices, base_vertex);
        let primitives = PrimitiveList::from_indices(primitive_type, count as usize, draw_indices, index_type);
        self.draw_with_reference(primitives, instance_count);
    }

    pub fn draw_elements(&mut self, mode: GLenum, count: i32, type_: GLenum, indices_offset: usize) {
        self.draw_elements_instanced_base_vertex(mode, count, type_, indices_offset, 1, 0);
    }

    pub fn draw_elements_base_vertex(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        base_vertex: i32,
    ) {
        self.draw_elements_instanced_base_vertex(mode, count, type_, indices_offset, 1, base_vertex);
    }

    /// `ReferenceContext::drawElementsInstanced` - the `glsDrawTest.cpp`-grep-confirmed
    /// no-base-vertex sibling of `draw_elements_instanced_base_vertex` (`base_vertex`
    /// hardcoded to `0`), matching how `draw_elements`/`draw_elements_base_vertex` are
    /// already two distinct call-site-faithful wrappers around that same function.
    pub fn draw_elements_instanced(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        instance_count: i32,
    ) {
        self.draw_elements_instanced_base_vertex(mode, count, type_, indices_offset, instance_count, 0);
    }

    /// `ReferenceContext::drawRangeElements` - `start`/`end` are upstream's own hint
    /// for a renderer that wants to pre-validate/cache a vertex range; this one reads
    /// every vertex through `rr::VertexAttrib` regardless, so only the `end < start`
    /// error check carries any behaviour.
    pub fn draw_range_elements(
        &mut self,
        mode: GLenum,
        start: u32,
        end: u32,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
    ) {
        if end < start {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.draw_elements(mode, count, type_, indices_offset);
    }

    #[allow(clippy::too_many_arguments)]
    pub fn draw_range_elements_base_vertex(
        &mut self,
        mode: GLenum,
        start: u32,
        end: u32,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        base_vertex: i32,
    ) {
        if end < start {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.draw_elements_base_vertex(mode, count, type_, indices_offset, base_vertex);
    }

    /// `ReferenceContext::drawArraysIndirect` - `indirect_offset` is a byte offset into
    /// the bound `GL_DRAW_INDIRECT_BUFFER`, matching this port's own convention of byte
    /// offsets rather than raw pointers everywhere a draw call takes one (every
    /// `draw_elements*` sibling's own `indices_offset`). Reads a
    /// `DrawArraysIndirectCommand` (`count`, `prim_count`, `first`,
    /// `reserved_must_be_zero` - four `u32`s, 16 bytes, upstream's own field order) out
    /// of the buffer and forwards to `draw_arrays_instanced` - an indirect draw only
    /// changes *where* the four draw parameters come from (a GPU-side compute pass can
    /// write them), not the rasterization itself, so no new drawing logic is needed.
    pub fn draw_arrays_indirect(&mut self, mode: GLenum, indirect_offset: usize) {
        if self.predraw_checks(mode).is_none() {
            return;
        }
        let Some(buffer_name) = self.draw_indirect_buffer_binding else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        if !indirect_offset.is_multiple_of(4) {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }
        let buffer = self
            .buffers
            .find(buffer_name)
            .expect("bound draw indirect buffer must exist");
        const COMMAND_SIZE: usize = 16;
        let data = buffer.data();
        if indirect_offset
            .checked_add(COMMAND_SIZE)
            .is_none_or(|end| end > data.len())
        {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }

        let count = read_u32(data, indirect_offset);
        let prim_count = read_u32(data, indirect_offset + 4);
        let first = read_u32(data, indirect_offset + 8);
        let reserved_must_be_zero = read_u32(data, indirect_offset + 12);
        if reserved_must_be_zero != 0 {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }

        self.draw_arrays_instanced(mode, first as i32, count as i32, prim_count as i32);
    }

    /// `ReferenceContext::drawElementsIndirect` - the `drawElementsInstancedBaseVertex`
    /// counterpart of `draw_arrays_indirect` above: reads a `DrawElementsIndirectCommand`
    /// (`count`, `prim_count`, `first_index`, `base_vertex`, `reserved_must_be_zero` -
    /// four `u32`s plus one `i32`, 20 bytes) out of the bound `GL_DRAW_INDIRECT_BUFFER`.
    /// Unlike `draw_arrays_indirect`, upstream additionally rejects a negative `count`/
    /// `prim_count` once read back as signed (`GL_INVALID_VALUE` - a real driver's own
    /// buffer contents are untrusted input, unlike an in-process `i32` argument that
    /// already can't be negative without the caller constructing it that way) - kept
    /// here for the same reason, not present on the arrays-only sibling because
    /// upstream's own `drawArraysIndirect` genuinely has no such check either.
    pub fn draw_elements_indirect(&mut self, mode: GLenum, type_: GLenum, indirect_offset: usize) {
        if self.predraw_checks(mode).is_none() {
            return;
        }
        if !matches!(
            type_,
            glw::GL_UNSIGNED_BYTE | glw::GL_UNSIGNED_SHORT | glw::GL_UNSIGNED_INT
        ) {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        }
        let vao = resolve_vao(
            self.vertex_array_binding,
            &self.vertex_arrays,
            &self.client_vertex_array,
        );
        if vao.element_array_buffer_binding.is_none() {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }
        let Some(buffer_name) = self.draw_indirect_buffer_binding else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        if !indirect_offset.is_multiple_of(4) {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }
        let buffer = self
            .buffers
            .find(buffer_name)
            .expect("bound draw indirect buffer must exist");
        const COMMAND_SIZE: usize = 20;
        let data = buffer.data();
        if indirect_offset
            .checked_add(COMMAND_SIZE)
            .is_none_or(|end| end > data.len())
        {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }

        let count = read_u32(data, indirect_offset);
        let prim_count = read_u32(data, indirect_offset + 4);
        let first_index = read_u32(data, indirect_offset + 8);
        let base_vertex = read_u32(data, indirect_offset + 12) as i32;
        let reserved_must_be_zero = read_u32(data, indirect_offset + 16);
        if reserved_must_be_zero != 0 {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        }
        if (count as i32) < 0 || (prim_count as i32) < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }

        let size_of_type: usize = match type_ {
            glw::GL_UNSIGNED_BYTE => 1,
            glw::GL_UNSIGNED_SHORT => 2,
            _ => 4,
        };
        let indices_offset = first_index as usize * size_of_type;
        self.draw_elements_instanced_base_vertex(
            mode,
            count as i32,
            type_,
            indices_offset,
            prim_count as i32,
            base_vertex,
        );
    }

    /// `ReferenceContext::finish` - a no-op: every draw call here already runs to
    /// completion synchronously, so there is nothing to wait for.
    pub fn finish(&mut self) {}

    /// `ReferenceContext::drawWithReference`, narrowed per this module's top doc
    /// comment (no blend/depth/stencil/scissor/cull/polygon-offset state yet, no
    /// restart index, provoking convention hardcoded to `Last` - GLES's own default).
    fn draw_with_reference(&mut self, primitives: PrimitiveList<'_>, instance_count: i32) {
        let Some(program_name) = self.current_program else {
            return; // undefined results upstream too - "no program bound"
        };

        let vertex_attribs = {
            let vao = resolve_vao(
                self.vertex_array_binding,
                &self.vertex_arrays,
                &self.client_vertex_array,
            );
            build_vertex_attribs(vao, &self.buffers, &self.current_attribs)
        };

        resolve_sampler_uniforms(
            &mut self.programs,
            program_name,
            &self.texture_2d_bindings,
            &self.texture_cube_bindings,
            &self.texture_2d_array_bindings,
            &self.texture_3d_bindings,
            &self.texture_cube_array_bindings,
            &self.texture_buffer_bindings,
            &self.textures,
            &self.buffers,
        );

        let program_obj = self.programs.find(program_name).expect("current program must exist");
        let program = Program {
            vertex_shader: program_obj.vertex_shader(),
            fragment_shader: program_obj.fragment_shader(),
            geometry_shader: None,
        };

        let viewport = self.viewport;
        let subpixel_bits = self.subpixel_bits;
        let mut state = RenderState::new(ViewportState::new(viewport), subpixel_bits);
        state.provoking_vertex_convention = Some(crate::rr::defs::ProvokingVertex::Last);

        {
            use crate::rr::render_state::FaceType;

            let base_type_is_triangles =
                primitives.primitive_type().base_type() == crate::rr::primitive_types::PrimitiveBaseType::Triangle;

            state.frag_ops.scissor_test_enabled = self.scissor_enabled;
            state.frag_ops.scissor_rectangle = WindowRectangle {
                left: self.scissor_box.0,
                bottom: self.scissor_box.1,
                width: self.scissor_box.2,
                height: self.scissor_box.3,
            };
            state.frag_ops.stencil_test_enabled = self.stencil_test_enabled;
            for face in [FaceType::Front, FaceType::Back] {
                let src = self.stencil[face as usize];
                state.frag_ops.stencil_states[face as usize] = crate::rr::render_state::StencilState {
                    func: map_gl_test_func(src.func).expect("validated at stencilFunc time"),
                    reference: src.ref_,
                    comp_mask: src.op_mask,
                    s_fail: map_gl_stencil_op(src.op_stencil_fail).expect("validated at stencilOp time"),
                    dp_fail: map_gl_stencil_op(src.op_depth_fail).expect("validated at stencilOp time"),
                    dp_pass: map_gl_stencil_op(src.op_depth_pass).expect("validated at stencilOp time"),
                    write_mask: src.write_mask,
                };
            }

            state.frag_ops.depth_test_enabled = self.depth_test_enabled;
            state.frag_ops.depth_func = map_gl_test_func(self.depth_func).expect("validated at depthFunc time");
            state.frag_ops.depth_mask = self.depth_mask;

            state.frag_ops.blend_mode = if self.blend_enabled {
                crate::rr::render_state::BlendMode::Standard
            } else {
                crate::rr::render_state::BlendMode::None
            };
            state.frag_ops.blend_rgb_state = crate::rr::render_state::BlendState {
                equation: map_gl_blend_equation(self.blend_mode_rgb).expect("validated at blendEquation time"),
                src_func: map_gl_blend_func(self.blend_factor_src_rgb).expect("validated at blendFunc time"),
                dst_func: map_gl_blend_func(self.blend_factor_dst_rgb).expect("validated at blendFunc time"),
            };
            state.frag_ops.blend_a_state = crate::rr::render_state::BlendState {
                equation: map_gl_blend_equation(self.blend_mode_alpha).expect("validated at blendEquation time"),
                src_func: map_gl_blend_func(self.blend_factor_src_alpha).expect("validated at blendFunc time"),
                dst_func: map_gl_blend_func(self.blend_factor_dst_alpha).expect("validated at blendFunc time"),
            };
            state.frag_ops.blend_color = self.blend_color;
            state.frag_ops.color_mask = self.color_mask;

            state.frag_ops.polygon_offset_enabled = base_type_is_triangles && self.polygon_offset_fill_enabled;
            state.frag_ops.polygon_offset_factor = self.polygon_offset_factor;
            state.frag_ops.polygon_offset_units = self.polygon_offset_units;

            state.viewport.zn = self.depth_range.0;
            state.viewport.zf = self.depth_range.1;
            state.line.line_width = self.line_width;

            // `ReferenceContext::drawWithReference`'s own restart block, narrowed to
            // the `GL_PRIMITIVE_RESTART_FIXED_INDEX` branch alone - the
            // `m_primitiveRestartSettableIndex`/`primitiveRestartIndex` (desktop-only
            // `GL_PRIMITIVE_RESTART`) branch is out of scope, see this module's own
            // "ES-only" doc comment and `enable`/`disable`'s own note that
            // `GL_PRIMITIVE_RESTART` is dropped. A non-indexed (`drawArrays`-like) list
            // has no index type (`primitives.index_type()` is `None`) and therefore no
            // fixed restart value to compute - matching upstream's own
            // `indexType != rr::INDEXTYPE_LAST` guard.
            state.restart = match primitives.index_type() {
                Some(index_type) if self.primitive_restart_fixed_index => RestartState {
                    enabled: true,
                    restart_index: fixed_restart_index(index_type),
                },
                _ => RestartState::default(),
            };
        }

        let (color_target, depth_target, stencil_target) = resolve_targets(
            self.draw_framebuffer_binding,
            &self.framebuffers,
            &mut self.renderbuffers,
            &mut self.textures,
            &mut self.color_buffer,
            self.depth_buffer.as_mut(),
            self.stencil_buffer.as_mut(),
        );
        let color_access = rr_renderer::as_multisample_view(color_target);
        let depth_access = depth_target.map(rr_renderer::as_multisample_view);
        let stencil_access = stencil_target.map(rr_renderer::as_multisample_view);

        if let Some(stencil) = &stencil_access {
            state.frag_ops.num_stencil_bits = num_stencil_bits_for_format(stencil.format()) as i32;
        }

        let mut render_target = RenderTarget::new(color_access, depth_access, stencil_access);

        let command = DrawCommand {
            state: &state,
            program: &program,
            vertex_attribs: &vertex_attribs,
            primitives: &primitives,
        };

        Renderer::new().draw_instanced(&command, &mut render_target, instance_count);
    }
}

/// A single 2D layer's worth of access out of a (possibly layered) `TextureLevel` -
/// layer `0` of a non-array level is the whole thing, so `Texture2D`/`TextureCube`'s
/// own attachment paths keep behaving exactly as before by always naming layer `0`;
/// `FboAttachment::Texture2DArray`'s own `layer` field is the only caller that ever
/// asks for anything else.
///
/// Written this way rather than `level.get_access().get_subregion(...)` for a load-
/// bearing lifetime reason: `PixelBufferAccess::get_subregion(&mut self, ...) ->
/// PixelBufferAccess<'_>` ties its result to the *reborrow* of `self` it's called
/// through, not to the underlying storage's own lifetime - chaining it straight onto a
/// freshly-constructed `get_access()` temporary would tie the narrowed view to that
/// temporary's own statement-local scope, which cannot satisfy this function's `'_`
/// (tied to `level`'s own, much longer, borrow). Going through
/// `PixelBufferAccess::into_raw_mut` instead *moves* the `&mut [u8]` straight out of
/// the owned `full` value (a true move, not a reborrow), keeping its original lifetime
/// intact; reslicing that moved reference by `offset..` is then an ordinary
/// `split_at_mut`-shaped reborrow, which NLL is happy to extend all the way back out.
fn level_layer_access(level: &mut TextureLevel, layer: u32) -> PixelBufferAccess<'_> {
    let full = level.get_access();
    let [w, h, _] = full.size();
    let [pixel_pitch, row_pitch, slice_pitch] = full.pitch();
    let format = full.format();
    let offset = layer as usize * slice_pitch;
    let raw = full.into_raw_mut();
    PixelBufferAccess::new_with_pitch(
        format,
        [w, h, 1],
        [pixel_pitch, row_pitch, slice_pitch],
        &mut raw[offset..],
    )
}

/// `intersect` (sglrReferenceContext.cpp) - axis-aligned `(x, y, width, height)`
/// rectangle intersection, clamped to a non-negative width/height (zero, not negative)
/// when the two do not overlap at all. Shared by `clear`/`clear_buffer_fv`/
/// `clear_buffer_iv`/`clear_buffer_uiv` to confine each to the scissor rectangle (or the
/// whole buffer, when scissoring is disabled) intersected with the actual resolved
/// target's own size. `saturating_add` rather than plain `+`: a caller-supplied scissor
/// rectangle's `x`/`y`/`width`/`height` are each independently bounded only by GL's own
/// `GLint` range, not by anything this function can assume stays small.
fn intersect_rect(a: (i32, i32, i32, i32), b: (i32, i32, i32, i32)) -> (i32, i32, i32, i32) {
    let x0 = a.0.max(b.0);
    let y0 = a.1.max(b.1);
    let x1 = a.0.saturating_add(a.2).min(b.0.saturating_add(b.2));
    let y1 = a.1.saturating_add(a.3).min(b.1.saturating_add(b.3));
    (x0, y0, (x1 - x0).max(0), (y1 - y0).max(0))
}

/// `getNumStencilBits` (sglrReferenceContext.cpp). ES stencil is always 8 bits in
/// practice - `map_gl_internal_format` only ever produces `S`/`UNSIGNED_INT8` or a
/// combined `DS` format with an 8-bit stencil component - but the match still mirrors
/// upstream's own wider switch rather than hardcoding `8`, so a future stencil-capable
/// format addition fails loudly here (the `unreachable!`) instead of silently clearing
/// the wrong bit width.
fn num_stencil_bits_for_format(format: crate::tcu::texture::TextureFormat) -> u32 {
    use crate::tcu::texture::{ChannelOrder, ChannelType};
    match (format.order, format.type_) {
        (ChannelOrder::S, ChannelType::UNSIGNED_INT8) => 8,
        (ChannelOrder::S, ChannelType::UNSIGNED_INT16) => 16,
        (ChannelOrder::S, ChannelType::UNSIGNED_INT32) => 32,
        (ChannelOrder::DS, ChannelType::UNSIGNED_INT_24_8) => 8,
        (ChannelOrder::DS, ChannelType::FLOAT_UNSIGNED_INT_24_8_REV) => 8,
        _ => unreachable!("not a format map_gl_internal_format ever produces for a stencil-capable attachment"),
    }
}

/// `maskStencil` (sglrReferenceContext.cpp), folded with the mask-width computation
/// above into one function - `deBitMask32(0, numBits)`'s own definition is undefined
/// for `numBits == 32` in C, and a plain `(1u32 << 32) - 1` is a Rust overflow panic in
/// debug for the same reason, so the 32-bit case is spelled as `u32::MAX` directly.
fn stencil_bit_mask(num_bits: u32) -> u32 {
    if num_bits >= 32 {
        u32::MAX
    } else {
        (1u32 << num_bits) - 1
    }
}

/// `ReferenceContext::getDrawColorbuffer` - resolves to the bound draw framebuffer's
/// `GL_COLOR_ATTACHMENT0` renderbuffer if one is bound, the default colour buffer
/// otherwise. A free function for the same disjoint-field-borrow reason `resolve_vao`
/// documents below. Panics if the bound FBO has no colour attachment - callers must
/// check `check_framebuffer_status` first, exactly as GL itself requires a draw call
/// against an incomplete framebuffer to be rejected before reaching here (`predraw_checks`
/// does not perform that check yet - see this module's top doc comment).
fn resolve_color_target<'a>(
    draw_fbo: Option<u32>,
    framebuffers: &ObjectManager<Framebuffer>,
    renderbuffers: &'a mut ObjectManager<Renderbuffer>,
    textures: &'a mut ObjectManager<TextureObject>,
    default_color: &'a mut TextureLevel,
) -> PixelBufferAccess<'a> {
    match draw_fbo {
        Some(fbo_name) => {
            let att = framebuffers
                .find(fbo_name)
                .expect("bound FBO must exist")
                .attachment(AttachmentPoint::Color0)
                .expect("FBO must have a colour attachment to be drawn into");
            match att {
                FboAttachment::Renderbuffer(name) => renderbuffers
                    .find_mut(name)
                    .expect("attached renderbuffer must exist")
                    .access()
                    .expect("attached colour target must have storage/level"),
                FboAttachment::Texture2D(name) => level_layer_access(
                    textures
                        .find_mut(name)
                        .expect("attached texture must exist")
                        .as_2d_mut()
                        .expect("GL_TEXTURE_2D attachment must name a Texture2D")
                        .levels
                        .get_mut(&0)
                        .expect("attached colour target must have storage/level"),
                    0,
                ),
                FboAttachment::TextureCube(name, face_index) => level_layer_access(
                    textures
                        .find_mut(name)
                        .expect("attached texture must exist")
                        .as_cube_mut()
                        .expect("cube-face attachment must name a TextureCube")
                        .face_mut(0, face_index as usize)
                        .expect("attached colour target must have storage/level"),
                    0,
                ),
                FboAttachment::Texture2DArray(name, layer) => level_layer_access(
                    textures
                        .find_mut(name)
                        .expect("attached texture must exist")
                        .as_2d_array_mut()
                        .expect("GL_TEXTURE_2D_ARRAY attachment must name a Texture2DArray")
                        .levels
                        .get_mut(&0)
                        .expect("attached colour target must have storage/level"),
                    layer,
                ),
                FboAttachment::Texture3D(name, layer) => level_layer_access(
                    textures
                        .find_mut(name)
                        .expect("attached texture must exist")
                        .as_3d_mut()
                        .expect("GL_TEXTURE_3D attachment must name a Texture3D")
                        .levels
                        .get_mut(&0)
                        .expect("attached colour target must have storage/level"),
                    layer,
                ),
                FboAttachment::CubeArray(name, layer) => level_layer_access(
                    textures
                        .find_mut(name)
                        .expect("attached texture must exist")
                        .as_cube_array_mut()
                        .expect("GL_TEXTURE_CUBE_MAP_ARRAY attachment must name a TextureCubeArray")
                        .levels
                        .get_mut(&0)
                        .expect("attached colour target must have storage/level"),
                    layer,
                ),
            }
        }
        None => default_color.get_access(),
    }
}

/// `ReferenceContext::getDrawDepthbuffer`/`getDrawStencilbuffer` - `None` if no FBO is
/// bound and there is no default depth/stencil buffer, or an FBO is bound but has
/// nothing attached at that point (both legal - a colour-only framebuffer is complete
/// as long as nothing tries to depth/stencil-test against it).
fn resolve_optional_target<'a>(
    draw_fbo: Option<u32>,
    point: AttachmentPoint,
    framebuffers: &ObjectManager<Framebuffer>,
    renderbuffers: &'a mut ObjectManager<Renderbuffer>,
    textures: &'a mut ObjectManager<TextureObject>,
    default_target: Option<&'a mut TextureLevel>,
) -> Option<PixelBufferAccess<'a>> {
    match draw_fbo {
        Some(fbo_name) => {
            let att = framebuffers
                .find(fbo_name)
                .expect("bound FBO must exist")
                .attachment(point)?;
            match att {
                FboAttachment::Renderbuffer(name) => renderbuffers
                    .find_mut(name)
                    .expect("attached renderbuffer must exist")
                    .access(),
                FboAttachment::Texture2D(name) => textures
                    .find_mut(name)
                    .expect("attached texture must exist")
                    .as_2d_mut()
                    .expect("GL_TEXTURE_2D attachment must name a Texture2D")
                    .levels
                    .get_mut(&0)
                    .map(|t| level_layer_access(t, 0)),
                FboAttachment::TextureCube(name, face_index) => textures
                    .find_mut(name)
                    .expect("attached texture must exist")
                    .as_cube_mut()
                    .expect("cube-face attachment must name a TextureCube")
                    .face_mut(0, face_index as usize)
                    .map(|t| level_layer_access(t, 0)),
                FboAttachment::Texture2DArray(name, layer) => textures
                    .find_mut(name)
                    .expect("attached texture must exist")
                    .as_2d_array_mut()
                    .expect("GL_TEXTURE_2D_ARRAY attachment must name a Texture2DArray")
                    .levels
                    .get_mut(&0)
                    .map(|t| level_layer_access(t, layer)),
                FboAttachment::Texture3D(name, layer) => textures
                    .find_mut(name)
                    .expect("attached texture must exist")
                    .as_3d_mut()
                    .expect("GL_TEXTURE_3D attachment must name a Texture3D")
                    .levels
                    .get_mut(&0)
                    .map(|t| level_layer_access(t, layer)),
                FboAttachment::CubeArray(name, layer) => textures
                    .find_mut(name)
                    .expect("attached texture must exist")
                    .as_cube_array_mut()
                    .expect("GL_TEXTURE_CUBE_MAP_ARRAY attachment must name a TextureCubeArray")
                    .levels
                    .get_mut(&0)
                    .map(|t| level_layer_access(t, layer)),
            }
        }
        None => default_target.map(|t| t.get_access()),
    }
}

/// Resolves a single attachment's backing `TextureLevel` to a raw pointer plus the
/// layer within it this attachment names (`0` for every non-array kind), for the
/// disjoint-borrow reason `resolve_targets` documents below - `None` if the attachment
/// point has nothing attached, or is attached but has no storage/level yet (both
/// "treated as unattached", matching `check_framebuffer_status`). Takes both managers
/// unconditionally (rather than, say, an enum of "which manager") because the caller
/// needs each of up to three attachment points resolved through whichever manager that
/// *particular* point happens to use, and the two parameters are plain disjoint `&mut`
/// borrows - computing one does not need to see the other.
fn attachment_level_ptr(
    attachment: FboAttachment,
    renderbuffers: &mut ObjectManager<Renderbuffer>,
    textures: &mut ObjectManager<TextureObject>,
) -> Option<(*mut TextureLevel, u32)> {
    match attachment {
        FboAttachment::Renderbuffer(name) => renderbuffers
            .find_mut(name)
            .expect("attached renderbuffer must exist")
            .storage
            .as_mut()
            .map(|t| (t as *mut TextureLevel, 0)),
        FboAttachment::Texture2D(name) => textures
            .find_mut(name)
            .expect("attached texture must exist")
            .as_2d_mut()
            .expect("GL_TEXTURE_2D attachment must name a Texture2D")
            .levels
            .get_mut(&0)
            .map(|t| (t as *mut TextureLevel, 0)),
        FboAttachment::TextureCube(name, face_index) => textures
            .find_mut(name)
            .expect("attached texture must exist")
            .as_cube_mut()
            .expect("cube-face attachment must name a TextureCube")
            .face_mut(0, face_index as usize)
            .map(|t| (t as *mut TextureLevel, 0)),
        FboAttachment::Texture2DArray(name, layer) => textures
            .find_mut(name)
            .expect("attached texture must exist")
            .as_2d_array_mut()
            .expect("GL_TEXTURE_2D_ARRAY attachment must name a Texture2DArray")
            .levels
            .get_mut(&0)
            .map(|t| (t as *mut TextureLevel, layer)),
        FboAttachment::Texture3D(name, layer) => textures
            .find_mut(name)
            .expect("attached texture must exist")
            .as_3d_mut()
            .expect("GL_TEXTURE_3D attachment must name a Texture3D")
            .levels
            .get_mut(&0)
            .map(|t| (t as *mut TextureLevel, layer)),
        FboAttachment::CubeArray(name, layer) => textures
            .find_mut(name)
            .expect("attached texture must exist")
            .as_cube_array_mut()
            .expect("GL_TEXTURE_CUBE_MAP_ARRAY attachment must name a TextureCubeArray")
            .levels
            .get_mut(&0)
            .map(|t| (t as *mut TextureLevel, layer)),
    }
}

/// Resolves the draw framebuffer's colour/depth/stencil targets *simultaneously* -
/// needed because `rr::RenderTarget` borrows all three for the duration of one draw
/// call, unlike `clear` above (which only ever needs one target alive at a time and so
/// never hits this problem). When an FBO is bound, each attachment's backing storage
/// lives inside one of two `ObjectManager`s (`renderbuffers`/`textures`), each a
/// `HashMap` keyed by name; getting two `&mut` borrows out of one `HashMap` through one
/// `&mut self.renderbuffers` (or `self.textures`) is exactly what the borrow checker
/// exists to refuse, even though the two objects' own backing storage is genuinely
/// disjoint heap memory. This resolves each attachment's identity first (an immutable,
/// `self.framebuffers`-only step), checks the up-to-three are pairwise distinct (via
/// `attachments_alias`, which also correctly treats e.g. renderbuffer 5 and texture 5 as
/// *not* aliasing - different namespaces, different objects), and only then takes a raw
/// pointer from each (short-lived safe `find_mut` calls, each ended before the next
/// begins, via `attachment_level_ptr`) before dereferencing all three together in one
/// `unsafe` block - sound exactly because distinctness was checked first.
///
/// Does not support a colour renderbuffer/texture also attached at `GL_DEPTH_ATTACHMENT`
/// or `GL_STENCIL_ATTACHMENT` - GL has no combined colour+depth/stencil format, so
/// there is no real-world shape this would ever legitimately need to resolve, and it
/// panics rather than silently aliasing two live `&mut` borrows of the same object.
/// **No longer reachable through a normal draw call**: `predraw_checks` now calls
/// `check_framebuffer_status` first (see that function's own doc comment), and the same
/// "no combined colour+depth/stencil format" fact that makes this pairing nonsensical
/// also makes `check_framebuffer_status` itself always report
/// `GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT` for it (one format can never be both
/// colour-compatible and depth/stencil-compatible under its own `compatible` match), so
/// `draw_with_reference` below is refused before this function is ever called. The
/// assert stays anyway as a defensive invariant - nothing currently calls this function
/// any way other than from a checked draw call, but a future caller that did would get
/// the same loud failure a silent aliasing bug deserves rather than a soundness hole.
///
/// A *combined* depth-stencil attachment - the same renderbuffer/texture bound to both
/// `GL_DEPTH_ATTACHMENT` and `GL_STENCIL_ATTACHMENT` at once (a real GL
/// `GL_DEPTH24_STENCIL8`/`GL_DEPTH32F_STENCIL8` renderbuffer, upstream's own deliberate
/// shape for this) **is** supported, via `tcu::pixel::split_combined_depth_stencil_mut`,
/// which carves the one underlying `TextureLevel` into its depth-only and stencil-only
/// channel views off a single resolved pointer - see that function's own doc comment
/// for the two views' aliasing caveat.
fn resolve_targets<'a>(
    draw_fbo: Option<u32>,
    framebuffers: &ObjectManager<Framebuffer>,
    renderbuffers: &'a mut ObjectManager<Renderbuffer>,
    textures: &'a mut ObjectManager<TextureObject>,
    default_color: &'a mut TextureLevel,
    default_depth: Option<&'a mut TextureLevel>,
    default_stencil: Option<&'a mut TextureLevel>,
) -> (
    PixelBufferAccess<'a>,
    Option<PixelBufferAccess<'a>>,
    Option<PixelBufferAccess<'a>>,
) {
    let (color_att, depth_att, stencil_att) = match draw_fbo {
        Some(fbo_name) => {
            let fbo = framebuffers.find(fbo_name).expect("bound FBO must exist");
            (
                fbo.attachment(AttachmentPoint::Color0),
                fbo.attachment(AttachmentPoint::Depth),
                fbo.attachment(AttachmentPoint::Stencil),
            )
        }
        None => (None, None, None),
    };

    // Colour aliasing depth or stencil would make the general path's `unsafe` block
    // below dereference two overlapping `&mut` borrows of one object, and GL's API does
    // not actually prevent a caller from attaching the same renderbuffer/texture to any
    // two points however nonsensical (`checkFramebufferStatus` would reject it, but
    // `predraw_checks` does not call that yet - see this module's top doc comment).
    assert!(
        !attachments_alias(color_att, depth_att),
        "a renderbuffer/texture attached to both GL_COLOR_ATTACHMENT0 and GL_DEPTH_ATTACHMENT is not supported - see resolve_targets's own doc comment"
    );
    assert!(
        !attachments_alias(color_att, stencil_att),
        "a renderbuffer/texture attached to both GL_COLOR_ATTACHMENT0 and GL_STENCIL_ATTACHMENT is not supported - see resolve_targets's own doc comment"
    );

    let color_ptr: Option<(*mut TextureLevel, u32)> = color_att.map(|a| {
        attachment_level_ptr(a, renderbuffers, textures).expect("attached colour target must have storage/level")
    });

    if attachments_alias(depth_att, stencil_att) {
        // Safety: `depth_att`/`stencil_att` name the same object here (just checked),
        // so resolving it once through `depth_att` alone and splitting the resulting
        // pointer is the combined-attachment case `split_combined_depth_stencil_mut`
        // documents, not the general two-pointer path below - `color_ptr` was checked
        // above not to alias it either, and nothing else in this function takes a
        // reference into this attachment's storage. The layer index is discarded here
        // (assumed 0) - a combined depth-stencil attachment at a non-zero array
        // layer/cube face is not exercised by anything in this port yet.
        return unsafe {
            let color_access = match color_ptr {
                Some((ptr, layer)) => level_layer_access(&mut *ptr, layer),
                None => default_color.get_access(),
            };
            match attachment_level_ptr(
                depth_att.expect("attachments_alias(Some, Some) implies Some"),
                renderbuffers,
                textures,
            ) {
                Some((ptr, _layer)) => {
                    let (depth_access, stencil_access) = split_combined_depth_stencil_mut(ptr);
                    (color_access, Some(depth_access), Some(stencil_access))
                }
                // Attached but with no storage/level yet - treated as unattached, same
                // as the general path below does for either target individually.
                None => (color_access, None, None),
            }
        };
    }

    let depth_ptr: Option<(*mut TextureLevel, u32)> =
        depth_att.and_then(|a| attachment_level_ptr(a, renderbuffers, textures));
    let stencil_ptr: Option<(*mut TextureLevel, u32)> =
        stencil_att.and_then(|a| attachment_level_ptr(a, renderbuffers, textures));

    // Safety: `color_ptr`/`depth_ptr`/`stencil_ptr`, where present, point at pairwise
    // distinct `TextureLevel`s (the combined depth-stencil case above is the only way
    // depth and stencil could alias, and it already returned), so dereferencing all
    // three together does not alias.
    unsafe {
        let color_access = match color_ptr {
            Some((ptr, layer)) => level_layer_access(&mut *ptr, layer),
            None => default_color.get_access(),
        };
        let depth_access = match depth_ptr {
            Some((ptr, layer)) => Some(level_layer_access(&mut *ptr, layer)),
            None if draw_fbo.is_none() => default_depth.map(|t| t.get_access()),
            None => None,
        };
        let stencil_access = match stencil_ptr {
            Some((ptr, layer)) => Some(level_layer_access(&mut *ptr, layer)),
            None if draw_fbo.is_none() => default_stencil.map(|t| t.get_access()),
            None => None,
        };
        (color_access, depth_access, stencil_access)
    }
}

/// `deAlign32` - rounds `value` up to the nearest multiple of `alignment`.
fn de_align32(value: usize, alignment: usize) -> usize {
    value.div_ceil(alignment) * alignment
}

/// `ReferenceContext::texImage2D`'s/`texSubImage2D`'s unpack-access construction
/// failure modes, kept distinct because upstream reports a different GL error for each
/// (`GL_INVALID_ENUM` for an unmappable transfer format, `GL_INVALID_OPERATION` for a
/// source buffer too short for the pixel-store state it's read through).
enum UnpackAccessError {
    BadFormat,
    BufferTooSmall,
}

/// `ReferenceContext::getUnpack2DAccess` - builds a `ConstPixelBufferAccess` over
/// `data` honouring `GL_UNPACK_ALIGNMENT`/`_ROW_LENGTH`/`_SKIP_ROWS`/`_SKIP_PIXELS`
/// (`unpack_state`, in that order) instead of assuming `data` is `width * height *
/// pixel_size` tightly-packed bytes. `(alignment, row_length, skip_rows, skip_pixels)`
/// are read out of `ReferenceContext`'s own fields by the caller before this is called,
/// since this is a free function (no `&self`) to sidestep a mutable borrow of
/// `self.textures` already being live at every call site (see `tex_image_2d`'s own
/// body) - the same reason the rest of this file inlines `self.last_error` checks
/// instead of calling `set_error` in some places.
fn unpack_2d_access<'a>(
    (alignment, row_length, skip_rows, skip_pixels): (i32, i32, i32, i32),
    format: crate::tcu::texture::TextureFormat,
    width: i32,
    height: i32,
    data: &'a [u8],
) -> Result<crate::tcu::pixel::ConstPixelBufferAccess<'a>, UnpackAccessError> {
    let pixel_size = format.pixel_size().ok_or(UnpackAccessError::BadFormat)? as usize;
    let row_len = if row_length > 0 {
        row_length as usize
    } else {
        width as usize
    };
    let row_pitch = de_align32(row_len * pixel_size, alignment as usize);
    let skip_offset = skip_rows as usize * row_pitch + skip_pixels as usize * pixel_size;
    let required_len = skip_offset
        + if height > 0 {
            (height as usize - 1) * row_pitch + width as usize * pixel_size
        } else {
            0
        };
    if data.len() < required_len {
        return Err(UnpackAccessError::BufferTooSmall);
    }
    Ok(crate::tcu::pixel::ConstPixelBufferAccess::new_with_pitch(
        format,
        [width as u32, height as u32, 1],
        [pixel_size, row_pitch, row_pitch * height as usize],
        &data[skip_offset..],
    ))
}

/// `ReferenceContext::getUnpack3DAccess` - the `GL_TEXTURE_2D_ARRAY` analogue of
/// `unpack_2d_access` above, additionally honouring `GL_UNPACK_IMAGE_HEIGHT`/
/// `_SKIP_IMAGES` (`image_height`/`skip_images`, defaulting to `height`/`0` exactly
/// like upstream's own `getUnpack3DAccess` - "use the image's own height"/"no skip").
#[allow(clippy::too_many_arguments)]
fn unpack_3d_access<'a>(
    (alignment, row_length, skip_rows, skip_pixels, image_height, skip_images): (i32, i32, i32, i32, i32, i32),
    format: crate::tcu::texture::TextureFormat,
    width: i32,
    height: i32,
    depth: i32,
    data: &'a [u8],
) -> Result<crate::tcu::pixel::ConstPixelBufferAccess<'a>, UnpackAccessError> {
    let pixel_size = format.pixel_size().ok_or(UnpackAccessError::BadFormat)? as usize;
    let row_len = if row_length > 0 {
        row_length as usize
    } else {
        width as usize
    };
    let row_pitch = de_align32(row_len * pixel_size, alignment as usize);
    let image_h = if image_height > 0 {
        image_height as usize
    } else {
        height as usize
    };
    let slice_pitch = image_h * row_pitch;
    let skip_offset =
        skip_images as usize * slice_pitch + skip_rows as usize * row_pitch + skip_pixels as usize * pixel_size;
    let required_len = skip_offset
        + if depth > 0 && height > 0 {
            (depth as usize - 1) * slice_pitch + (height as usize - 1) * row_pitch + width as usize * pixel_size
        } else {
            0
        };
    if data.len() < required_len {
        return Err(UnpackAccessError::BufferTooSmall);
    }
    Ok(crate::tcu::pixel::ConstPixelBufferAccess::new_with_pitch(
        format,
        [width as u32, height as u32, depth as u32],
        [pixel_size, row_pitch, slice_pitch],
        &data[skip_offset..],
    ))
}

/// `mapGLWrapMode`'s validity check - see `TextureSamplerState`'s own doc comment for
/// why this stores/validates the raw GL enum rather than mapping into a narrower type.
fn is_valid_gl_wrap_mode(value: GLenum) -> bool {
    matches!(value, glw::GL_CLAMP_TO_EDGE | glw::GL_REPEAT | glw::GL_MIRRORED_REPEAT)
}

/// `mapGLFilterMode`'s validity check, `GL_TEXTURE_MIN_FILTER`'s accepted set (every
/// filter mode, including the mipmap ones).
fn is_valid_gl_min_filter(value: GLenum) -> bool {
    matches!(
        value,
        glw::GL_NEAREST
            | glw::GL_LINEAR
            | glw::GL_NEAREST_MIPMAP_NEAREST
            | glw::GL_NEAREST_MIPMAP_LINEAR
            | glw::GL_LINEAR_MIPMAP_NEAREST
            | glw::GL_LINEAR_MIPMAP_LINEAR
    )
}

/// `GL_TEXTURE_MAG_FILTER`'s accepted set - upstream's own `texParameteri` additionally
/// requires this not be a mipmap mode (`RC_IF_ERROR(magMode != LINEAR && magMode !=
/// NEAREST, ...)`, stricter than `mapGLFilterMode` alone would allow).
fn is_valid_gl_mag_filter(value: GLenum) -> bool {
    matches!(value, glw::GL_NEAREST | glw::GL_LINEAR)
}

/// `GL_TEXTURE_COMPARE_MODE`'s accepted set - `GL_NONE` (no shadow comparison) or
/// `GL_COMPARE_REF_TO_TEXTURE`. New state, not a port - see `TextureSamplerState::
/// compare_mode`'s own doc comment.
fn is_valid_gl_compare_mode(value: GLenum) -> bool {
    matches!(value, glw::GL_NONE | glw::GL_COMPARE_REF_TO_TEXTURE)
}

/// Shared by `Texture2D`/`TextureCube`/`Texture2DArray`/`TextureCubeArray`'s own
/// `resolve_sampler` - `CompareMode::None` (not a shadow sampler at all) unless
/// `GL_TEXTURE_COMPARE_MODE` is `GL_COMPARE_REF_TO_TEXTURE`, in which case the
/// already-validated `GL_TEXTURE_COMPARE_FUNC` maps straight through
/// `map_gl_compare_func` (`tex_parameteri` already rejects any value that function
/// doesn't map, so the `unwrap_or` below is a defensive fallback that should never
/// actually trigger). `Texture3D` does not call this: GLSL ES has no `sampler3DShadow`
/// type at all (see this module's own top doc comment).
fn resolve_compare_mode(sampler: &TextureSamplerState) -> crate::tcu::pixel::CompareMode {
    if sampler.compare_mode != glw::GL_COMPARE_REF_TO_TEXTURE {
        return crate::tcu::pixel::CompareMode::None;
    }
    map_gl_compare_func(sampler.compare_func).unwrap_or(crate::tcu::pixel::CompareMode::None)
}

/// Shared body for each `DataType::Sampler*` arm of `resolve_sampler_uniforms` - looks up
/// a texture unit's bound name, narrows it to the expected concrete texture kind via
/// `as_kind` (a `TextureObject::as_*` function pointer), and resolves it via `resolve`
/// (that kind's own `resolve_sampler`), all through one `Option` chain so an out-of-range
/// unit, a negative unit (never set, or explicitly set negative - `uniform1i` accepts
/// any `i32`), an unbound unit, or an incomplete texture all collapse to the same `None`
/// upstream's own empty-texture fallback expects.
fn resolve_unit<T, R>(
    bindings: &[Option<u32>],
    textures: &ObjectManager<TextureObject>,
    unit: i32,
    as_kind: fn(&TextureObject) -> Option<&T>,
    resolve: fn(&T) -> Option<R>,
) -> Option<R> {
    if unit < 0 {
        return None;
    }
    bindings
        .get(unit as usize)
        .copied()
        .flatten()
        .and_then(|name| textures.find(name))
        .and_then(as_kind)
        .and_then(resolve)
}

/// `ReferenceContext::drawWithReference`'s own "Set shader samplers" step, covering every
/// sampler type this port's texture objects back: the five colour-path types
/// (`glu::TYPE_SAMPLER_2D`/`_CUBE`/`_2D_ARRAY`/`_3D`/`_CUBE_ARRAY`), the four shadow
/// types (`_SAMPLER_2D_SHADOW`/`_CUBE_SHADOW`/`_2D_ARRAY_SHADOW`/`_CUBE_ARRAY_SHADOW`),
/// the eight integer/unsigned types and the three buffer-sampler types
/// (`_SAMPLER_BUFFER`/`_INT_SAMPLER_BUFFER`/`_UINT_SAMPLER_BUFFER`) - each of the last
/// twelve non-buffer types shares its underlying `ResolvedSampler`
/// variant with the colour-path type backed by the same texture kind (a `sampler2D`
/// and a `sampler2DShadow` both sample a `GL_TEXTURE_2D` object; it is the texture's own
/// `GL_TEXTURE_COMPARE_MODE` state, not the GLSL type, that decides whether a tap is a
/// colour lookup or a depth comparison - see `resolve_compare_mode`'s own doc comment),
/// so no new `ResolvedSampler` variant is needed for those, only more `DataType` arms
/// below pointing at the same five. The buffer family is the one place that does need
/// its own `ResolvedSampler::Buffer` variant: `TextureBuffer::resolve_sampler` needs the
/// `buffers` manager too (the texel data lives in the attached `DataBuffer`, not inside
/// the texture object itself the way every other type's own `levels` does), so it
/// cannot go through `resolve_unit`'s single-argument `resolve` function pointer and is
/// resolved inline instead. A free function taking `self`'s relevant fields
/// explicitly (not `&mut self`) so `draw_with_reference` can call it while still holding
/// immutable borrows of other `self` fields afterward for the rest of the draw - see
/// `uniform1i`'s own doc comment for why resolution happens here and not inside
/// `uniform1i` itself (the bound texture can change, via a later `bindTexture` on the
/// same unit, between `uniform1i` and the draw call that actually uses it; resolving at
/// draw time is what upstream itself does too).
///
/// `tex->isComplete()` now gates this exactly like upstream for every type: each
/// `resolve_sampler` returns `None` for an incomplete texture - matching upstream's own
/// fallback to `&m_emptyTex2D` (a real, if conceptual, transparent-black
/// `CLAMP_TO_EDGE`/`NEAREST` texture) is each concrete `ShaderProgram::bind_samplers`
/// implementation's own responsibility (see that method's own doc comment and
/// `Sampler2DUniformShader`'s `shade_fragments`, below, for the one case in scope) - or
/// `Some(ResolvedSampler::<Kind>)`, carrying the texture's complete mip chain plus its
/// wrap/filter state mapped into real `tcu::pixel` types (see each struct's own doc
/// comment). Each declared uniform's own `DataType` picks which texture-unit array and
/// which `TextureObject::as_*`/`resolve_sampler` pair to resolve it through - a sampler
/// uniform never changes type after being declared, so this match happens once per draw
/// per uniform, not per texture lookup.
#[allow(clippy::too_many_arguments)]
fn resolve_sampler_uniforms(
    programs: &mut ObjectManager<ProgramObject>,
    program_name: u32,
    texture_2d_bindings: &[Option<u32>],
    texture_cube_bindings: &[Option<u32>],
    texture_2d_array_bindings: &[Option<u32>],
    texture_3d_bindings: &[Option<u32>],
    texture_cube_array_bindings: &[Option<u32>],
    texture_buffer_bindings: &[Option<u32>],
    textures: &ObjectManager<TextureObject>,
    buffers: &ObjectManager<DataBuffer>,
) {
    let Some(program_obj) = programs.find_mut(program_name) else {
        return;
    };
    let Some(declared) = program_obj.declared_mut() else {
        return;
    };

    let resolved: Vec<(String, Option<ResolvedSampler>)> = declared
        .program_base()
        .uniforms()
        .iter()
        .filter_map(|u| {
            // The type check happens *before* any `u.value.as_i32()` call, not after -
            // `uniforms()` lists every declared uniform, including non-sampler, non-`Int`
            // ones (`u_color: FloatVec4`, say) whose `value` is a different
            // `UniformValue` variant entirely, and `as_i32()` panics on a mismatch (see
            // `UniformValue`'s own doc comment for why that panic is deliberate).
            let sampler = match u.type_ {
                // Each `bindings` array only ever names a `TextureObject` of the
                // matching variant (enforced by `bind_texture`'s own type check), so the
                // `as_*` call never actually discards anything real here - it's still
                // the right way to read it, since the lookup goes through the single
                // shared `textures` manager. A negative unit (never set via `uniform1i`,
                // or explicitly set negative) resolves to `None`, matching upstream's own
                // empty-texture fallback the same way an out-of-range or unbound unit does.
                DataType::Sampler2D | DataType::Sampler2DShadow | DataType::IntSampler2D | DataType::UintSampler2D => {
                    resolve_unit(
                        texture_2d_bindings,
                        textures,
                        u.value.as_i32(),
                        TextureObject::as_2d,
                        Texture2D::resolve_sampler,
                    )
                    .map(ResolvedSampler::D2)
                }
                DataType::SamplerCube
                | DataType::SamplerCubeShadow
                | DataType::IntSamplerCube
                | DataType::UintSamplerCube => resolve_unit(
                    texture_cube_bindings,
                    textures,
                    u.value.as_i32(),
                    TextureObject::as_cube,
                    TextureCube::resolve_sampler,
                )
                .map(ResolvedSampler::Cube),
                DataType::Sampler2DArray
                | DataType::Sampler2DArrayShadow
                | DataType::IntSampler2DArray
                | DataType::UintSampler2DArray => resolve_unit(
                    texture_2d_array_bindings,
                    textures,
                    u.value.as_i32(),
                    TextureObject::as_2d_array,
                    Texture2DArray::resolve_sampler,
                )
                .map(ResolvedSampler::D2Array),
                DataType::Sampler3D | DataType::IntSampler3D | DataType::UintSampler3D => resolve_unit(
                    texture_3d_bindings,
                    textures,
                    u.value.as_i32(),
                    TextureObject::as_3d,
                    Texture3D::resolve_sampler,
                )
                .map(ResolvedSampler::D3),
                DataType::SamplerCubeArray
                | DataType::SamplerCubeArrayShadow
                | DataType::IntSamplerCubeArray
                | DataType::UintSamplerCubeArray => resolve_unit(
                    texture_cube_array_bindings,
                    textures,
                    u.value.as_i32(),
                    TextureObject::as_cube_array,
                    TextureCubeArray::resolve_sampler,
                )
                .map(ResolvedSampler::CubeArray),
                DataType::SamplerBuffer | DataType::IntSamplerBuffer | DataType::UintSamplerBuffer => {
                    let unit = u.value.as_i32();
                    if unit < 0 {
                        None
                    } else {
                        texture_buffer_bindings
                            .get(unit as usize)
                            .copied()
                            .flatten()
                            .and_then(|name| textures.find(name))
                            .and_then(TextureObject::as_buffer)
                            .and_then(|tex| tex.resolve_sampler(buffers))
                            .map(ResolvedSampler::Buffer)
                    }
                }
                // Not a sampler uniform at all (a plain `int`, or a `vec4`/... that
                // `uniform4fv`/`uniform1i`'s own type checks already keep separate) -
                // nothing to resolve here.
                _ => return None,
            };
            Some((u.name.clone(), sampler))
        })
        .collect();

    if !resolved.is_empty() {
        declared.bind_samplers(&resolved);
    }
}

/// `tcu::copy` - a plain per-pixel, format-converting copy (reads each source texel,
/// writes it through the destination's own format conversion), over the whole 3D box
/// `dst`/`src` share (a plain 2D copy is the `size[2] == 1` case of this, not a
/// separate path - `fill_tex_image_2d_level`/`fill_tex_sub_image_2d` and their 3D
/// counterparts below all go through this one function).
///
/// Now dispatches on channel class the way upstream's own `tcu::copy` does (`srcIsInt
/// && dstIsInt => dst.setPixel(src.getPixelInt(...))`, upstream's `setPixel` overloaded
/// on `IVec4` - `set_pixel_int` here): an integer-format upload (`GL_R32I`/`GL_R32UI`
/// and friends, via `IntSampler2D`/`UintSampler2D`-etc. support - see `sglr::reference_
/// context`'s own top doc comment) used to go through the float-only path below
/// regardless, which round-trips every texel through an `f32` intermediate - exact for
/// a small value, but `f32`'s 24-bit mantissa cannot represent every `i32`/`u32`
/// exactly, so a genuinely large integer texel silently came out *wrong* rather than
/// merely unchecked. Falls back to the plain float path (`get_pixel`/`set_pixel`) for
/// every other combination, unchanged. Still not the whole general function upstream
/// has: the tightly-packed/bit-exact `memcpy` fast paths for matching formats, and the
/// depth/stencil special case (`depthValueFloatClampCopy`), remain unneeded here for
/// the same reason the rest of this doc comment used to give for the integer branch
/// too - nothing in scope reaches either.
fn copy_pixels(dst: &mut PixelBufferAccess<'_>, src: &crate::tcu::pixel::ConstPixelBufferAccess<'_>) {
    use crate::tcu::texture::TextureChannelClass::{SignedInteger, UnsignedInteger};
    let size = dst.size();
    debug_assert_eq!(size, src.size());
    {
        use crate::tcu::texture::{ChannelOrder, ChannelType};
        let (dst_order, src_order) = (dst.format().order, src.format().order);
        let dst_depth_stencil = matches!(dst_order, ChannelOrder::D | ChannelOrder::DS | ChannelOrder::S);
        if dst_depth_stencil {
            // `depthValueFloatClampCopy` for the float depth formats, `tcu::copy` otherwise
            let clamp = matches!(
                (dst_order, dst.format().type_),
                (ChannelOrder::D, ChannelType::FLOAT) | (ChannelOrder::DS, ChannelType::FLOAT_UNSIGNED_INT_24_8_REV)
            );
            let src_has_depth = matches!(src_order, ChannelOrder::D | ChannelOrder::DS);
            let src_has_stencil = matches!(src_order, ChannelOrder::S | ChannelOrder::DS);
            let dst_has_depth = matches!(dst_order, ChannelOrder::D | ChannelOrder::DS);
            let dst_has_stencil = matches!(dst_order, ChannelOrder::S | ChannelOrder::DS);
            for z in 0..size[2] {
                for y in 0..size[1] {
                    for x in 0..size[0] {
                        if dst_has_depth && src_has_depth {
                            let d = src.get_pix_depth(x, y, z);
                            dst.set_pix_depth(if clamp { d.clamp(0.0, 1.0) } else { d }, x, y, z);
                        }
                        if dst_has_stencil && src_has_stencil {
                            dst.set_pix_stencil(src.get_pix_stencil(x, y, z), x, y, z);
                        }
                    }
                }
            }
            return;
        }
    }
    let src_is_int = matches!(src.format().type_.channel_class(), SignedInteger | UnsignedInteger);
    let dst_is_int = matches!(dst.format().type_.channel_class(), SignedInteger | UnsignedInteger);
    for z in 0..size[2] {
        for y in 0..size[1] {
            for x in 0..size[0] {
                if src_is_int && dst_is_int {
                    let texel = src.get_pixel_int(x, y, z);
                    let _ = dst.set_pixel_int(texel, x, y, z);
                } else {
                    let texel = src.get_pixel(x, y, z);
                    dst.set_pixel(texel, x, y, z);
                }
            }
        }
    }
}

/// Which concrete texture object `tex_image_2d`/`tex_sub_image_2d`'s own `target`
/// argument addresses - `GL_TEXTURE_2D` itself, or one of the six
/// `GL_TEXTURE_CUBE_MAP_POSITIVE_X..NEGATIVE_Z` face targets (carrying its own face
/// index, see `reference_utils::map_gl_cube_map_face_index`). A plain classification
/// with no borrow of `self` so each caller can match on it before touching
/// `self.textures`.
#[derive(Clone, Copy)]
enum TexImageTarget {
    D2,
    CubeFace(u32),
}

fn classify_tex_image_target(target: GLenum) -> Option<TexImageTarget> {
    if target == glw::GL_TEXTURE_2D {
        Some(TexImageTarget::D2)
    } else {
        super::reference_utils::map_gl_cube_map_face_index(target).map(TexImageTarget::CubeFace)
    }
}

/// Which concrete texture object `tex_image_3d`/`tex_sub_image_3d`'s own `target`
/// argument addresses - `GL_TEXTURE_2D_ARRAY`, `GL_TEXTURE_3D` or
/// `GL_TEXTURE_CUBE_MAP_ARRAY`. Kept as its own classification rather than folded into
/// `TexImageTarget` because the two upload entry points dispatch on disjoint `target`
/// sets (`texImage2D`'s six cube-face targets have no `texImage3D` counterpart, and a
/// real `GL_TEXTURE_2D_ARRAY`/`_3D`/`_CUBE_MAP_ARRAY` target would only ever reach
/// `texImage3D`).
#[derive(Clone, Copy)]
enum TexImage3DTarget {
    D2Array,
    D3,
    CubeArray,
}

fn classify_tex_image_3d_target(target: GLenum) -> Option<TexImage3DTarget> {
    match target {
        glw::GL_TEXTURE_2D_ARRAY => Some(TexImage3DTarget::D2Array),
        glw::GL_TEXTURE_3D => Some(TexImage3DTarget::D3),
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => Some(TexImage3DTarget::CubeArray),
        _ => None,
    }
}

/// Which texture-binding array (and, for `bind_texture`, concrete `TextureObject`
/// variant) a `target` argument addresses - shared by `bind_texture`, `tex_parameteri`
/// and `tex_buffer`, the entry points that dispatch on texture *target* rather than
/// a texture *name*'s already-fixed type. `tex_image_2d`/`tex_sub_image_2d` use
/// `TexImageTarget` instead (a cube-face target also carries its own face index, which
/// neither `bind_texture` nor `tex_parameteri` need - a cube map's binding/sampler
/// state is shared by all six faces). `tex_parameteri` rejects its own `Buffer` variant
/// outright, matching real GL (`GL_TEXTURE_BUFFER` is not a legal `texParameteri`
/// target at all - a buffer texture has no wrap/filter/compare state, see
/// `TextureBuffer`'s own doc comment) rather than needing a sixth arm in either of its
/// two matches.
#[derive(Clone, Copy)]
enum TextureTargetKind {
    D2,
    Cube,
    D2Array,
    D3,
    CubeArray,
    /// `GL_TEXTURE_BUFFER` - see `TextureBuffer`'s own doc comment.
    Buffer,
}

fn classify_texture_target(target: GLenum) -> Option<TextureTargetKind> {
    match target {
        glw::GL_TEXTURE_2D => Some(TextureTargetKind::D2),
        glw::GL_TEXTURE_CUBE_MAP => Some(TextureTargetKind::Cube),
        glw::GL_TEXTURE_2D_ARRAY => Some(TextureTargetKind::D2Array),
        glw::GL_TEXTURE_3D => Some(TextureTargetKind::D3),
        glw::GL_TEXTURE_CUBE_MAP_ARRAY => Some(TextureTargetKind::CubeArray),
        glw::GL_TEXTURE_BUFFER => Some(TextureTargetKind::Buffer),
        _ => None,
    }
}

/// Shared tail of `tex_image_2d`'s/`tex_sub_image_2d`'s two `TexImageTarget` branches:
/// write `data` (or `tex_image_2d`'s own initial-value fill when `data` is `None`) into
/// an already-sized destination access. Returns the GL error to report, if any, rather
/// than calling `set_error` itself - `dst` already mutably borrows the texture object
/// out of `self.textures`, so the caller (which still holds that same borrow at the
/// call site) is the one that can safely call `self.set_error` once `dst`'s own last use
/// has passed.
fn fill_tex_image_2d_level(
    dst: &mut PixelBufferAccess<'_>,
    unpack_state: (i32, i32, i32, i32),
    transfer_fmt: crate::tcu::texture::TextureFormat,
    width: i32,
    height: i32,
    data: Option<&[u8]>,
) -> Option<GLenum> {
    match data {
        Some(src_bytes) => match unpack_2d_access(unpack_state, transfer_fmt, width, height, src_bytes) {
            Ok(src) => {
                copy_pixels(dst, &src);
                None
            }
            Err(UnpackAccessError::BadFormat) => Some(glw::GL_INVALID_ENUM),
            Err(UnpackAccessError::BufferTooSmall) => Some(glw::GL_INVALID_OPERATION),
        },
        None => {
            clear_to_texture_initial_value(dst);
            None
        }
    }
}

/// `tex_sub_image_2d`'s own shared tail, the `texSubImage2D` analogue of
/// `fill_tex_image_2d_level` above (an existing level/face being partially overwritten
/// rather than a freshly allocated one, hence the bounds check against the level's own
/// size before `unpack_2d_access` ever runs).
#[allow(clippy::too_many_arguments)]
fn fill_tex_sub_image_2d(
    level: &mut TextureLevel,
    xoffset: i32,
    yoffset: i32,
    width: i32,
    height: i32,
    unpack_state: (i32, i32, i32, i32),
    transfer_fmt: crate::tcu::texture::TextureFormat,
    data: &[u8],
) -> Result<(), GLenum> {
    let mut full = level.get_access();
    if (xoffset + width) as u32 > full.size()[0] || (yoffset + height) as u32 > full.size()[1] {
        return Err(glw::GL_INVALID_VALUE);
    }
    let mut dst = full.get_subregion(xoffset as u32, yoffset as u32, 0, width as u32, height as u32, 1);
    match unpack_2d_access(unpack_state, transfer_fmt, width, height, data) {
        Ok(src) => {
            copy_pixels(&mut dst, &src);
            Ok(())
        }
        Err(UnpackAccessError::BadFormat) => Err(glw::GL_INVALID_ENUM),
        Err(UnpackAccessError::BufferTooSmall) => Err(glw::GL_INVALID_OPERATION),
    }
}

/// `tex_image_3d`'s own shared tail - the `texImage3D` analogue of
/// `fill_tex_image_2d_level` above.
#[allow(clippy::too_many_arguments)]
fn fill_tex_image_3d_level(
    dst: &mut PixelBufferAccess<'_>,
    unpack_state: (i32, i32, i32, i32, i32, i32),
    transfer_fmt: crate::tcu::texture::TextureFormat,
    width: i32,
    height: i32,
    depth: i32,
    data: Option<&[u8]>,
) -> Option<GLenum> {
    match data {
        Some(src_bytes) => match unpack_3d_access(unpack_state, transfer_fmt, width, height, depth, src_bytes) {
            Ok(src) => {
                copy_pixels(dst, &src);
                None
            }
            Err(UnpackAccessError::BadFormat) => Some(glw::GL_INVALID_ENUM),
            Err(UnpackAccessError::BufferTooSmall) => Some(glw::GL_INVALID_OPERATION),
        },
        None => {
            clear_to_texture_initial_value(dst);
            None
        }
    }
}

/// `tex_sub_image_3d`'s own shared tail - the `texSubImage3D` analogue of
/// `fill_tex_sub_image_2d` above.
#[allow(clippy::too_many_arguments)]
fn fill_tex_sub_image_3d(
    level: &mut TextureLevel,
    xoffset: i32,
    yoffset: i32,
    zoffset: i32,
    width: i32,
    height: i32,
    depth: i32,
    unpack_state: (i32, i32, i32, i32, i32, i32),
    transfer_fmt: crate::tcu::texture::TextureFormat,
    data: &[u8],
) -> Result<(), GLenum> {
    let mut full = level.get_access();
    if (xoffset + width) as u32 > full.size()[0]
        || (yoffset + height) as u32 > full.size()[1]
        || (zoffset + depth) as u32 > full.size()[2]
    {
        return Err(glw::GL_INVALID_VALUE);
    }
    let mut dst = full.get_subregion(
        xoffset as u32,
        yoffset as u32,
        zoffset as u32,
        width as u32,
        height as u32,
        depth as u32,
    );
    match unpack_3d_access(unpack_state, transfer_fmt, width, height, depth, data) {
        Ok(src) => {
            copy_pixels(&mut dst, &src);
            Ok(())
        }
        Err(UnpackAccessError::BadFormat) => Err(glw::GL_INVALID_ENUM),
        Err(UnpackAccessError::BufferTooSmall) => Err(glw::GL_INVALID_OPERATION),
    }
}

/// `(anonymous)::clearToTextureInitialValue` - what an uninitialised texture level
/// reads as when `texImage2D`/`texImage3D` is called with `data == NULL`, over the
/// whole 3D box `access` covers (every existing `texImage2D`/cube-face caller passes a
/// `size[2] == 1` access, so the `z` loop below is a no-op for them; `tex_image_3d` is
/// the first caller where it actually does something).
fn clear_to_texture_initial_value(access: &mut PixelBufferAccess<'_>) {
    use crate::tcu::texture::ChannelOrder::*;
    let order = access.format().order;
    let has_depth = matches!(order, D | DS);
    let has_stencil = matches!(order, S | DS);
    let size = access.size();

    if has_depth || has_stencil {
        for z in 0..size[2] {
            for y in 0..size[1] {
                for x in 0..size[0] {
                    if has_depth {
                        access.set_pix_depth(0.0, x, y, z);
                    }
                    if has_stencil {
                        access.set_pix_stencil(0, x, y, z);
                    }
                }
            }
        }
    } else {
        for z in 0..size[2] {
            for y in 0..size[1] {
                for x in 0..size[0] {
                    access.set_pixel([0.0, 0.0, 0.0, 1.0], x, y, z);
                }
            }
        }
    }
}

/// `getFixedRestartIndex` - the value `GL_PRIMITIVE_RESTART_FIXED_INDEX` restarts a
/// primitive on, defined by the index buffer's own element width (`0xFF`/`0xFFFF`/
/// `0xFFFFFFFF`), not by anything the application sets - `draw_with_reference`'s only
/// caller.
fn fixed_restart_index(index_type: IndexType) -> u32 {
    match index_type {
        IndexType::Uint8 => 0xFF,
        IndexType::Uint16 => 0xFFFF,
        IndexType::Uint32 => 0xFFFF_FFFF,
    }
}

/// `ReferenceContext::getBufferBinding`'s VAO resolution, extracted to a free function
/// so it can be called alongside other field borrows of `self` in `draw_with_reference`.
/// A method taking `&self` would borrow all of `self` for its return value's lifetime,
/// which conflicts with the disjoint-field borrows `draw_with_reference` needs at the
/// same time (`self.programs`, `self.color_buffer`, ...).
fn resolve_vao<'a>(
    vao_binding: Option<u32>,
    vertex_arrays: &'a ObjectManager<VertexArray>,
    client: &'a VertexArray,
) -> &'a VertexArray {
    match vao_binding {
        Some(name) => vertex_arrays.find(name).expect("bound VAO must exist"),
        None => client,
    }
}

/// `drawWithReference`'s "gen attributes" block.
fn build_vertex_attribs(
    vao: &VertexArray,
    buffers: &ObjectManager<DataBuffer>,
    current_attribs: &[GenericVec4],
) -> Vec<VertexAttrib> {
    vao.arrays
        .iter()
        .enumerate()
        .map(|(ndx, attrib)| {
            if !attrib.enabled {
                // Reading with the wrong type is allowed, but results are undefined;
                // DontCare + the current generic value matches upstream exactly.
                VertexAttrib {
                    type_: VertexAttribType::DontCare,
                    generic: current_attribs[ndx],
                    ..Default::default()
                }
            } else if attrib.buffer_deleted {
                VertexAttrib {
                    type_: VertexAttribType::DontCare,
                    generic: GenericVec4::zero(),
                    ..Default::default()
                }
            } else {
                let type_ = if attrib.integer {
                    map_gl_pure_integer_vertex_attribute_type(attrib.type_)
                        .expect("validated at vertexAttribIPointer time")
                } else {
                    map_gl_float_vertex_attribute_type(attrib.type_, attrib.normalized)
                        .expect("validated at vertexAttribPointer time")
                };
                let size = map_gl_size(attrib.size).expect("validated at vertexAttribPointer time");

                let pointer = match attrib.buffer_binding {
                    Some(buf_name) => {
                        let buf = buffers.find(buf_name).expect("bound buffer must exist");
                        // Safety: only the *base* offset is checked here - `.add()`
                        // requires the resulting pointer to land at most one byte past
                        // the allocation's end, which this enforces by clamping. It
                        // does **not** mean every byte a subsequent vertex read through
                        // this pointer (at `stride * vertex_ndx` further in, for
                        // `rr::VertexAttrib::size` components) is in bounds - that
                        // depends on the draw call's vertex count and is not validated
                        // anywhere in this port, same as upstream's own
                        // `getData() + reinterpret_cast<uintptr_t>(pointer)`, which
                        // performs no bounds check at all. An out-of-range
                        // `vertexAttribPointer` offset/stride combined with a
                        // `drawArrays` count large enough to walk off the end of a real
                        // buffer is undefined behaviour here exactly as it is in real
                        // GL; closing that needs per-read bounds checking in
                        // `rr::vertex_attrib` itself, not attempted yet.
                        let base = attrib.pointer.min(buf.data().len());
                        unsafe { buf.data().as_ptr().add(base) }
                    }
                    None => attrib.pointer as *const u8,
                };

                VertexAttrib::from_pointer(type_, size, attrib.stride, attrib.divisor as i32, pointer)
            }
        })
        .collect()
}

/// Reads `count` indices of `type_` starting at byte `offset` in `buffer`, widening
/// each to `u32` - see this module's top doc comment for why this is an eager decode
/// rather than a reinterpreted slice.
fn decode_indices(buffer: &[u8], type_: GLenum, offset: usize, count: usize) -> Vec<u32> {
    match type_ {
        glw::GL_UNSIGNED_BYTE => buffer[offset..offset + count].iter().map(|&b| b as u32).collect(),
        glw::GL_UNSIGNED_SHORT => (0..count)
            .map(|i| u16::from_ne_bytes([buffer[offset + i * 2], buffer[offset + i * 2 + 1]]) as u32)
            .collect(),
        glw::GL_UNSIGNED_INT => (0..count)
            .map(|i| {
                u32::from_ne_bytes([
                    buffer[offset + i * 4],
                    buffer[offset + i * 4 + 1],
                    buffer[offset + i * 4 + 2],
                    buffer[offset + i * 4 + 3],
                ])
            })
            .collect(),
        _ => unreachable!("type_ validated by the caller"),
    }
}

/// Reads one native-endian `u32` out of a buffer at a byte offset already checked to
/// leave 4 bytes in range - the same "reinterpret raw bytes" shape `decode_indices`'s
/// own `GL_UNSIGNED_INT` arm uses, shared here for `draw_arrays_indirect`/
/// `draw_elements_indirect`'s own command-struct fields.
fn read_u32(buffer: &[u8], offset: usize) -> u32 {
    u32::from_ne_bytes([
        buffer[offset],
        buffer[offset + 1],
        buffer[offset + 2],
        buffer[offset + 3],
    ])
}

/// `sglr::Context` for `sglr::ReferenceContext` - see `context.rs`'s own module doc
/// comment for which methods this covers and why. Every method here either forwards
/// directly to an existing inherent method of the identical name (resolved
/// unambiguously: inside a trait impl, `self: &mut ReferenceContext` is a concrete
/// type, so method-call syntax always picks the inherent method over this very trait
/// impl - no infinite recursion) or to one of the new `create_shader_program`/
/// `get_attrib_location`/`get_uniform_location`/`uniform4fv`/`read_pixels` methods
/// added above specifically to back it.
impl Context for ReferenceContext {
    fn get_width(&self) -> i32 {
        self.get_width()
    }

    fn get_height(&self) -> i32 {
        self.get_height()
    }

    fn clear_color(&mut self, red: f32, green: f32, blue: f32, alpha: f32) {
        self.clear_color(red, green, blue, alpha);
    }

    fn clear_depthf(&mut self, depth: f32) {
        self.clear_depthf(depth);
    }

    fn clear_stencil(&mut self, stencil: i32) {
        self.clear_stencil(stencil);
    }

    fn clear(&mut self, buffers: GLenum) {
        self.clear(buffers);
    }

    fn clear_buffer_fv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[f32]) {
        self.clear_buffer_fv(buffer, drawbuffer, value);
    }

    fn clear_buffer_iv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[i32]) {
        self.clear_buffer_iv(buffer, drawbuffer, value);
    }

    fn clear_buffer_uiv(&mut self, buffer: GLenum, drawbuffer: i32, value: &[u32]) {
        self.clear_buffer_uiv(buffer, drawbuffer, value);
    }

    fn clear_buffer_fi(&mut self, buffer: GLenum, drawbuffer: i32, depth: f32, stencil: i32) {
        self.clear_buffer_fi(buffer, drawbuffer, depth, stencil);
    }

    fn invalidate_framebuffer(&mut self, target: GLenum, attachments: &[GLenum]) {
        self.invalidate_framebuffer(target, attachments);
    }

    fn invalidate_sub_framebuffer(
        &mut self,
        target: GLenum,
        attachments: &[GLenum],
        x: i32,
        y: i32,
        width: i32,
        height: i32,
    ) {
        self.invalidate_sub_framebuffer(target, attachments, x, y, width, height);
    }

    fn blit_framebuffer(
        &mut self,
        src_x0: i32,
        src_y0: i32,
        src_x1: i32,
        src_y1: i32,
        dst_x0: i32,
        dst_y0: i32,
        dst_x1: i32,
        dst_y1: i32,
        mask: GLenum,
        filter: GLenum,
    ) {
        self.blit_framebuffer(
            src_x0, src_y0, src_x1, src_y1, dst_x0, dst_y0, dst_x1, dst_y1, mask, filter,
        );
    }

    fn scissor(&mut self, x: i32, y: i32, width: i32, height: i32) {
        self.scissor(x, y, width, height);
    }

    fn enable(&mut self, cap: GLenum) {
        self.enable(cap);
    }

    fn disable(&mut self, cap: GLenum) {
        self.disable(cap);
    }

    fn depth_func(&mut self, func: GLenum) {
        self.depth_func(func);
    }

    fn depth_mask(&mut self, flag: bool) {
        self.depth_mask(flag);
    }

    fn stencil_func(&mut self, func: GLenum, ref_: i32, mask: u32) {
        self.stencil_func(func, ref_, mask);
    }

    fn stencil_func_separate(&mut self, face: GLenum, func: GLenum, ref_: i32, mask: u32) {
        self.stencil_func_separate(face, func, ref_, mask);
    }

    fn stencil_op(&mut self, sfail: GLenum, dpfail: GLenum, dppass: GLenum) {
        self.stencil_op(sfail, dpfail, dppass);
    }

    fn stencil_op_separate(&mut self, face: GLenum, sfail: GLenum, dpfail: GLenum, dppass: GLenum) {
        self.stencil_op_separate(face, sfail, dpfail, dppass);
    }

    fn stencil_mask_separate(&mut self, face: GLenum, mask: u32) {
        self.stencil_mask_separate(face, mask);
    }

    fn stencil_mask(&mut self, mask: u32) {
        self.stencil_mask(mask);
    }

    fn gen_vertex_arrays(&mut self, out: &mut [u32]) {
        self.gen_vertex_arrays(out);
    }

    fn bind_vertex_array(&mut self, array: u32) {
        self.bind_vertex_array(array);
    }

    fn delete_vertex_arrays(&mut self, names: &[u32]) {
        self.delete_vertex_arrays(names);
    }

    fn gen_buffers(&mut self, out: &mut [u32]) {
        self.gen_buffers(out);
    }

    fn delete_buffers(&mut self, names: &[u32]) {
        self.delete_buffers(names);
    }

    fn bind_buffer(&mut self, target: GLenum, buffer: u32) {
        self.bind_buffer(target, buffer);
    }

    fn buffer_data(&mut self, target: GLenum, size: isize, data: Option<&[u8]>) {
        self.buffer_data(target, size, data);
    }

    fn buffer_sub_data(&mut self, target: GLenum, offset: isize, data: &[u8]) {
        self.buffer_sub_data(target, offset, data);
    }

    fn enable_vertex_attrib_array(&mut self, index: u32) {
        self.enable_vertex_attrib_array(index);
    }

    fn disable_vertex_attrib_array(&mut self, index: u32) {
        self.disable_vertex_attrib_array(index);
    }

    fn vertex_attrib_pointer(
        &mut self,
        index: u32,
        size: i32,
        type_: GLenum,
        normalized: bool,
        stride: i32,
        pointer: usize,
        has_pointer: bool,
    ) {
        self.vertex_attrib_pointer(index, size, type_, normalized, stride, pointer, has_pointer);
    }

    fn vertex_attrib_i_pointer(
        &mut self,
        index: u32,
        size: i32,
        type_: GLenum,
        stride: i32,
        pointer: usize,
        has_pointer: bool,
    ) {
        self.vertex_attrib_i_pointer(index, size, type_, stride, pointer, has_pointer);
    }

    fn vertex_attrib_divisor(&mut self, index: u32, divisor: u32) {
        self.vertex_attrib_divisor(index, divisor);
    }

    fn vertex_attrib1f(&mut self, index: u32, x: f32) {
        self.vertex_attrib1f(index, x);
    }

    fn vertex_attrib2f(&mut self, index: u32, x: f32, y: f32) {
        self.vertex_attrib2f(index, x, y);
    }

    fn vertex_attrib3f(&mut self, index: u32, x: f32, y: f32, z: f32) {
        self.vertex_attrib3f(index, x, y, z);
    }

    fn vertex_attrib4f(&mut self, index: u32, x: f32, y: f32, z: f32, w: f32) {
        self.vertex_attrib4f(index, x, y, z, w);
    }

    fn vertex_attrib_i4i(&mut self, index: u32, x: i32, y: i32, z: i32, w: i32) {
        self.vertex_attrib_i4i(index, x, y, z, w);
    }

    fn vertex_attrib_i4ui(&mut self, index: u32, x: u32, y: u32, z: u32, w: u32) {
        self.vertex_attrib_i4ui(index, x, y, z, w);
    }

    fn get_attrib_location(&mut self, program: u32, name: &str) -> i32 {
        self.get_attrib_location(program, name)
    }

    fn uniform4fv(&mut self, location: i32, count: i32, v: &[f32]) {
        self.uniform4fv(location, count, v);
    }

    fn uniform1i(&mut self, location: i32, value: i32) {
        self.uniform1i(location, value);
    }

    fn uniform1f(&mut self, location: i32, value: f32) {
        self.uniform1f(location, value);
    }

    fn uniform1fv(&mut self, location: i32, count: i32, v: &[f32]) {
        self.uniform1fv(location, count, v);
    }

    fn uniform2fv(&mut self, location: i32, count: i32, v: &[f32]) {
        self.uniform2fv(location, count, v);
    }

    fn uniform3fv(&mut self, location: i32, count: i32, v: &[f32]) {
        self.uniform3fv(location, count, v);
    }

    fn uniform1iv(&mut self, location: i32, count: i32, v: &[i32]) {
        self.uniform1iv(location, count, v);
    }

    fn uniform2iv(&mut self, location: i32, count: i32, v: &[i32]) {
        self.uniform2iv(location, count, v);
    }

    fn uniform3iv(&mut self, location: i32, count: i32, v: &[i32]) {
        self.uniform3iv(location, count, v);
    }

    fn uniform4iv(&mut self, location: i32, count: i32, v: &[i32]) {
        self.uniform4iv(location, count, v);
    }

    fn get_uniform_location(&mut self, program: u32, name: &str) -> i32 {
        self.get_uniform_location(program, name)
    }

    fn draw_arrays(&mut self, mode: GLenum, first: i32, count: i32) {
        self.draw_arrays(mode, first, count);
    }

    fn draw_arrays_instanced(&mut self, mode: GLenum, first: i32, count: i32, instance_count: i32) {
        self.draw_arrays_instanced(mode, first, count, instance_count);
    }

    fn draw_elements(&mut self, mode: GLenum, count: i32, type_: GLenum, indices_offset: usize) {
        self.draw_elements(mode, count, type_, indices_offset);
    }

    fn draw_elements_base_vertex(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        base_vertex: i32,
    ) {
        self.draw_elements_base_vertex(mode, count, type_, indices_offset, base_vertex);
    }

    fn draw_elements_instanced(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        instance_count: i32,
    ) {
        self.draw_elements_instanced(mode, count, type_, indices_offset, instance_count);
    }

    fn draw_elements_instanced_base_vertex(
        &mut self,
        mode: GLenum,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        instance_count: i32,
        base_vertex: i32,
    ) {
        self.draw_elements_instanced_base_vertex(mode, count, type_, indices_offset, instance_count, base_vertex);
    }

    fn draw_range_elements(
        &mut self,
        mode: GLenum,
        start: u32,
        end: u32,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
    ) {
        self.draw_range_elements(mode, start, end, count, type_, indices_offset);
    }

    fn draw_range_elements_base_vertex(
        &mut self,
        mode: GLenum,
        start: u32,
        end: u32,
        count: i32,
        type_: GLenum,
        indices_offset: usize,
        base_vertex: i32,
    ) {
        self.draw_range_elements_base_vertex(mode, start, end, count, type_, indices_offset, base_vertex);
    }

    fn draw_arrays_indirect(&mut self, mode: GLenum, indirect_offset: usize) {
        self.draw_arrays_indirect(mode, indirect_offset);
    }

    fn draw_elements_indirect(&mut self, mode: GLenum, type_: GLenum, indirect_offset: usize) {
        self.draw_elements_indirect(mode, type_, indirect_offset);
    }

    fn finish(&mut self) {
        self.finish();
    }

    fn create_program(&mut self, program: Box<dyn ShaderProgram>) -> u32 {
        self.create_shader_program(program)
    }

    fn use_program(&mut self, program: u32) {
        self.use_program(program);
    }

    fn delete_program(&mut self, program: u32) {
        self.delete_program(program);
    }

    fn read_pixels(&mut self, dst: &mut Surface, x: i32, y: i32, width: i32, height: i32) {
        self.read_pixels(dst, x, y, width, height);
    }

    fn read_pixels_rgba_f32(&mut self, x: i32, y: i32, width: i32, height: i32, type_: GLenum) -> Vec<[f32; 4]> {
        self.read_pixels_rgba_f32(x, y, width, height, type_)
    }

    fn get_error(&mut self) -> GLenum {
        self.get_error()
    }

    fn get_string(&mut self, pname: GLenum) -> Option<String> {
        self.get_string(pname)
    }

    fn viewport(&mut self, x: i32, y: i32, width: i32, height: i32) {
        self.viewport(x, y, width, height);
    }

    fn blend_equation(&mut self, mode: GLenum) {
        self.blend_equation(mode);
    }

    fn blend_equation_separate(&mut self, mode_rgb: GLenum, mode_alpha: GLenum) {
        self.blend_equation_separate(mode_rgb, mode_alpha);
    }

    fn blend_func_separate(&mut self, src_rgb: GLenum, dst_rgb: GLenum, src_alpha: GLenum, dst_alpha: GLenum) {
        self.blend_func_separate(src_rgb, dst_rgb, src_alpha, dst_alpha);
    }

    fn blend_color(&mut self, red: f32, green: f32, blue: f32, alpha: f32) {
        self.blend_color(red, green, blue, alpha);
    }

    fn blend_func(&mut self, src: GLenum, dst: GLenum) {
        self.blend_func(src, dst);
    }

    fn color_mask(&mut self, r: bool, g: bool, b: bool, a: bool) {
        self.color_mask(r, g, b, a);
    }

    fn line_width(&mut self, width: f32) {
        self.line_width(width);
    }

    fn active_texture(&mut self, texture: GLenum) {
        self.active_texture(texture);
    }

    fn gen_textures(&mut self, out: &mut [u32]) {
        self.gen_textures(out);
    }

    fn delete_textures(&mut self, names: &[u32]) {
        self.delete_textures(names);
    }

    fn bind_texture(&mut self, target: GLenum, texture: u32) {
        self.bind_texture(target, texture);
    }

    fn pixel_storei(&mut self, pname: GLenum, param: i32) {
        self.pixel_storei(pname, param);
    }

    fn tex_parameteri(&mut self, target: GLenum, pname: GLenum, value: i32) {
        self.tex_parameteri(target, pname, value);
    }

    fn tex_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        data: Option<&[u8]>,
    ) {
        self.tex_image_2d(
            target,
            level,
            internal_format,
            width,
            height,
            border,
            format,
            type_,
            data,
        );
    }

    fn tex_sub_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        width: i32,
        height: i32,
        format: GLenum,
        type_: GLenum,
        data: &[u8],
    ) {
        self.tex_sub_image_2d(target, level, xoffset, yoffset, width, height, format, type_, data);
    }

    fn tex_image_3d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        data: Option<&[u8]>,
    ) {
        self.tex_image_3d(
            target,
            level,
            internal_format,
            width,
            height,
            depth,
            border,
            format,
            type_,
            data,
        );
    }

    fn tex_sub_image_3d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        zoffset: i32,
        width: i32,
        height: i32,
        depth: i32,
        format: GLenum,
        type_: GLenum,
        data: &[u8],
    ) {
        self.tex_sub_image_3d(
            target, level, xoffset, yoffset, zoffset, width, height, depth, format, type_, data,
        );
    }

    fn tex_image_2d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    ) {
        let Some(data) = self.pixel_unpack_buffer_tail(offset) else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        self.tex_image_2d(
            target,
            level,
            internal_format,
            width,
            height,
            border,
            format,
            type_,
            Some(&data),
        );
    }

    fn tex_sub_image_2d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        width: i32,
        height: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    ) {
        let Some(data) = self.pixel_unpack_buffer_tail(offset) else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        self.tex_sub_image_2d(target, level, xoffset, yoffset, width, height, format, type_, &data);
    }

    fn tex_image_3d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
        border: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    ) {
        let Some(data) = self.pixel_unpack_buffer_tail(offset) else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        self.tex_image_3d(
            target,
            level,
            internal_format,
            width,
            height,
            depth,
            border,
            format,
            type_,
            Some(&data),
        );
    }

    fn tex_sub_image_3d_pbo(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        zoffset: i32,
        width: i32,
        height: i32,
        depth: i32,
        format: GLenum,
        type_: GLenum,
        offset: isize,
    ) {
        let Some(data) = self.pixel_unpack_buffer_tail(offset) else {
            self.set_error(glw::GL_INVALID_OPERATION);
            return;
        };
        self.tex_sub_image_3d(
            target, level, xoffset, yoffset, zoffset, width, height, depth, format, type_, &data,
        );
    }

    fn copy_tex_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        internal_format: GLenum,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
        border: i32,
    ) {
        self.copy_tex_image_2d(target, level, internal_format, x, y, width, height, border);
    }

    fn copy_tex_sub_image_2d(
        &mut self,
        target: GLenum,
        level: i32,
        xoffset: i32,
        yoffset: i32,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
    ) {
        self.copy_tex_sub_image_2d(target, level, xoffset, yoffset, x, y, width, height);
    }

    // Upstream's `ReferenceContext::texStorage2D/3D` also allocate every level through `texImage*` with the
    // transfer format of the internal format; immutability is not modelled.
    fn tex_storage_2d(&mut self, target: GLenum, levels: i32, internal_format: GLenum, width: i32, height: i32) {
        let Some(transfer) = crate::glu::texture_util::map_gl_internal_format(internal_format)
            .and_then(|f| crate::glu::texture_util::get_transfer_format(f).ok())
        else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        let targets: &[GLenum] = if target == glw::GL_TEXTURE_CUBE_MAP {
            &[
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
                glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
            ]
        } else {
            std::slice::from_ref(&target)
        };
        for level in 0..levels {
            let level_w = (width >> level).max(1);
            let level_h = (height >> level).max(1);
            for &face_target in targets {
                self.tex_image_2d(
                    face_target,
                    level,
                    internal_format,
                    level_w,
                    level_h,
                    0,
                    transfer.format,
                    transfer.data_type,
                    None,
                );
            }
        }
    }

    fn tex_storage_3d(
        &mut self,
        target: GLenum,
        levels: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
        depth: i32,
    ) {
        let Some(transfer) = crate::glu::texture_util::map_gl_internal_format(internal_format)
            .and_then(|f| crate::glu::texture_util::get_transfer_format(f).ok())
        else {
            self.set_error(glw::GL_INVALID_ENUM);
            return;
        };
        for level in 0..levels {
            let level_w = (width >> level).max(1);
            let level_h = (height >> level).max(1);
            let level_d = if target == glw::GL_TEXTURE_3D {
                (depth >> level).max(1)
            } else {
                depth
            };
            self.tex_image_3d(
                target,
                level,
                internal_format,
                level_w,
                level_h,
                level_d,
                0,
                transfer.format,
                transfer.data_type,
                None,
            );
        }
    }

    fn framebuffer_texture_layer(&mut self, target: GLenum, attachment: GLenum, texture: u32, level: i32, layer: i32) {
        self.framebuffer_texture_layer(target, attachment, texture, level, layer);
    }

    fn uniform_matrix3fv(&mut self, location: i32, count: i32, transpose: bool, v: &[f32]) {
        self.uniform_matrix3fv(location, count, transpose, v);
    }

    fn gen_renderbuffers(&mut self, out: &mut [u32]) {
        self.gen_renderbuffers(out);
    }

    fn delete_renderbuffers(&mut self, names: &[u32]) {
        self.delete_renderbuffers(names);
    }

    fn bind_renderbuffer(&mut self, target: GLenum, renderbuffer: u32) {
        self.bind_renderbuffer(target, renderbuffer);
    }

    fn renderbuffer_storage_multisample(
        &mut self,
        target: GLenum,
        samples: i32,
        internal_format: GLenum,
        width: i32,
        height: i32,
    ) {
        if samples < 0 {
            self.set_error(glw::GL_INVALID_VALUE);
            return;
        }
        self.renderbuffer_storage(target, internal_format, width, height);
    }

    fn renderbuffer_storage(&mut self, target: GLenum, internal_format: GLenum, width: i32, height: i32) {
        self.renderbuffer_storage(target, internal_format, width, height);
    }

    fn gen_framebuffers(&mut self, out: &mut [u32]) {
        self.gen_framebuffers(out);
    }

    fn delete_framebuffers(&mut self, names: &[u32]) {
        self.delete_framebuffers(names);
    }

    fn bind_framebuffer(&mut self, target: GLenum, framebuffer: u32) {
        self.bind_framebuffer(target, framebuffer);
    }

    fn framebuffer_renderbuffer(
        &mut self,
        target: GLenum,
        attachment: GLenum,
        renderbuffertarget: GLenum,
        renderbuffer: u32,
    ) {
        self.framebuffer_renderbuffer(target, attachment, renderbuffertarget, renderbuffer);
    }

    fn framebuffer_texture2d(
        &mut self,
        target: GLenum,
        attachment: GLenum,
        textarget: GLenum,
        texture: u32,
        level: i32,
    ) {
        self.framebuffer_texture2d(target, attachment, textarget, texture, level);
    }

    fn check_framebuffer_status(&mut self, target: GLenum) -> GLenum {
        self.check_framebuffer_status(target)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn ctx() -> ReferenceContext {
        ctx_with_size(4, 4)
    }

    fn ctx_with_size(width: u32, height: u32) -> ReferenceContext {
        let color = TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(
                crate::tcu::texture::ChannelOrder::RGBA,
                crate::tcu::texture::ChannelType::UNORM_INT8,
            ),
            width,
            height,
            1,
        )
        .unwrap();
        ReferenceContext::new(16, color, None, 8)
    }

    /// Same as `ctx_with_size`, but with an `RGBA`/`FLOAT` colour buffer instead of
    /// `UNORM_INT8` - for a test whose fragment shader writes a value outside `[0, 1]`
    /// (a raw `texelFetch` result, say), where a `UNORM_INT8` target would silently
    /// clamp it to `1.0` before the test ever gets to read it back.
    fn ctx_with_float_color(width: u32, height: u32) -> ReferenceContext {
        let color = TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(
                crate::tcu::texture::ChannelOrder::RGBA,
                crate::tcu::texture::ChannelType::FLOAT,
            ),
            width,
            height,
            1,
        )
        .unwrap();
        ReferenceContext::new(16, color, None, 8)
    }

    fn ctx_with_depth(width: u32, height: u32) -> ReferenceContext {
        let color = TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(
                crate::tcu::texture::ChannelOrder::RGBA,
                crate::tcu::texture::ChannelType::UNORM_INT8,
            ),
            width,
            height,
            1,
        )
        .unwrap();
        let depth = TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(
                crate::tcu::texture::ChannelOrder::D,
                crate::tcu::texture::ChannelType::FLOAT,
            ),
            width,
            height,
            1,
        )
        .unwrap();
        ReferenceContext::new(16, color, Some(depth), 8)
    }

    #[test]
    fn gen_buffers_yields_distinct_names() {
        let mut cx = ctx();
        let mut names = [0u32; 3];
        cx.gen_buffers(&mut names);
        assert_eq!(names, [1, 2, 3]);
    }

    #[test]
    fn binding_a_buffer_then_reading_the_binding_back_returns_what_was_bound() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_buffers(&mut names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, names[0]);
        assert_eq!(cx.get_buffer_binding(glw::GL_ARRAY_BUFFER), Some(names[0]));
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
    }

    #[test]
    fn binding_an_invalid_target_sets_invalid_enum() {
        let mut cx = ctx();
        cx.bind_buffer(0xDEAD, 1);
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn buffer_data_then_sub_data_round_trips_bytes() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_buffers(&mut names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, names[0]);
        cx.buffer_data(glw::GL_ARRAY_BUFFER, 8, Some(&[1, 2, 3, 4, 5, 6, 7, 8]));
        cx.buffer_sub_data(glw::GL_ARRAY_BUFFER, 2, &[0xAA, 0xBB]);

        let buf = cx.buffer(names[0]).unwrap();
        assert_eq!(buf.data(), &[1, 2, 0xAA, 0xBB, 5, 6, 7, 8]);
    }

    #[test]
    fn buffer_sub_data_past_the_end_is_invalid_value() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_buffers(&mut names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, names[0]);
        cx.buffer_data(glw::GL_ARRAY_BUFFER, 4, None);
        cx.buffer_sub_data(glw::GL_ARRAY_BUFFER, 2, &[1, 2, 3]); // would end at offset 5 > size 4
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    #[test]
    fn buffer_data_without_a_bound_buffer_is_invalid_operation() {
        let mut cx = ctx();
        cx.buffer_data(glw::GL_ARRAY_BUFFER, 4, None);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn tex_buffer_without_a_bound_texture_is_invalid_operation() {
        let mut cx = ctx();
        let mut buf_names = [0u32];
        cx.gen_buffers(&mut buf_names);
        // No `GL_TEXTURE_BUFFER` texture bound on the active unit at all.
        cx.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R32F, buf_names[0]);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn tex_buffer_rejects_an_invalid_internal_format() {
        let mut cx = ctx();
        let mut tex_names = [0u32];
        cx.gen_textures(&mut tex_names);
        cx.bind_texture(glw::GL_TEXTURE_BUFFER, tex_names[0]);
        cx.tex_buffer(glw::GL_TEXTURE_BUFFER, 0xBEEF, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn tex_buffer_with_a_nonexistent_buffer_name_is_invalid_operation() {
        let mut cx = ctx();
        let mut tex_names = [0u32];
        cx.gen_textures(&mut tex_names);
        cx.bind_texture(glw::GL_TEXTURE_BUFFER, tex_names[0]);
        cx.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R32F, 999);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn tex_parameteri_on_a_texture_buffer_target_is_invalid_enum() {
        let mut cx = ctx();
        let mut tex_names = [0u32];
        cx.gen_textures(&mut tex_names);
        cx.bind_texture(glw::GL_TEXTURE_BUFFER, tex_names[0]);
        // `GL_TEXTURE_BUFFER` has no wrap/filter/compare state at all - real GL rejects
        // this target outright for `texParameteri`.
        cx.tex_parameteri(
            glw::GL_TEXTURE_BUFFER,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn generate_mipmap_on_a_texture_buffer_target_is_invalid_enum() {
        let mut cx = ctx();
        let mut tex_names = [0u32];
        cx.gen_textures(&mut tex_names);
        cx.bind_texture(glw::GL_TEXTURE_BUFFER, tex_names[0]);
        cx.generate_mipmap(glw::GL_TEXTURE_BUFFER);
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn gen_vertex_arrays_and_bind_round_trips() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_vertex_arrays(&mut names);
        assert!(
            cx.vertex_array(names[0]).is_none(),
            "gen alone must not create the object - only bind does, lazily"
        );
        cx.bind_vertex_array(names[0]);
        assert_eq!(cx.current_vertex_array_binding(), Some(names[0]));
        assert!(cx.vertex_array(names[0]).is_some());
    }

    #[test]
    fn binding_vao_zero_returns_to_the_client_vertex_array() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_vertex_arrays(&mut names);
        cx.bind_vertex_array(names[0]);
        cx.bind_vertex_array(0);
        assert_eq!(cx.current_vertex_array_binding(), None);
    }

    #[test]
    fn enable_vertex_attrib_array_is_per_vao() {
        let mut cx = ctx();
        let mut names = [0u32, 0];
        cx.gen_vertex_arrays(&mut names);

        cx.bind_vertex_array(names[0]);
        cx.enable_vertex_attrib_array(3);
        assert!(cx.vertex_array(names[0]).unwrap().arrays[3].enabled);

        cx.bind_vertex_array(names[1]);
        assert!(
            !cx.vertex_array(names[1]).unwrap().arrays[3].enabled,
            "a second VAO must start with every attribute disabled"
        );
    }

    #[test]
    fn vertex_attrib_pointer_records_the_bound_buffer() {
        let mut cx = ctx();
        let mut buf_names = [0u32];
        cx.gen_buffers(&mut buf_names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, buf_names[0]);

        cx.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, false, 12, 0, false);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let attrib = cx.client_vertex_array().arrays[0];
        assert_eq!(attrib.buffer_binding, Some(buf_names[0]));
        assert_eq!(attrib.size, 3);
        assert_eq!(attrib.stride, 12);
        assert!(!attrib.integer);
    }

    #[test]
    fn vertex_attrib_pointer_with_user_ptr_and_a_vao_bound_but_no_buffer_is_invalid_operation() {
        let mut cx = ctx();
        let mut vao_names = [0u32];
        cx.gen_vertex_arrays(&mut vao_names);
        cx.bind_vertex_array(vao_names[0]);

        // has_pointer = true (a real client pointer), no GL_ARRAY_BUFFER bound: upstream
        // rejects this exact combination for a non-default VAO.
        cx.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, false, 0, 0x1000, true);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn deleting_a_bound_buffer_clears_the_binding_point() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_buffers(&mut names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, names[0]);
        cx.delete_buffers(&names);
        assert_eq!(cx.get_buffer_binding(glw::GL_ARRAY_BUFFER), None);
        assert!(cx.buffer(names[0]).is_none());
    }

    #[test]
    fn deleting_a_buffer_still_referenced_by_a_vertex_attrib_marks_it_deleted() {
        let mut cx = ctx();
        let mut buf_names = [0u32];
        cx.gen_buffers(&mut buf_names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, buf_names[0]);
        cx.vertex_attrib_pointer(0, 3, glw::GL_FLOAT, false, 0, 0, false);

        // Unbind GL_ARRAY_BUFFER itself, but the attrib still references the buffer.
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, 0);
        cx.delete_buffers(&buf_names);

        let attrib = cx.client_vertex_array().arrays[0];
        assert!(attrib.buffer_deleted);
        assert_eq!(attrib.buffer_binding, None);
    }

    #[test]
    fn deleting_the_bound_vao_falls_back_to_the_client_vertex_array() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_vertex_arrays(&mut names);
        cx.bind_vertex_array(names[0]);
        cx.delete_vertex_arrays(&names);
        assert_eq!(cx.current_vertex_array_binding(), None);
    }

    #[test]
    fn element_array_buffer_binding_lives_on_the_current_vao() {
        let mut cx = ctx();
        let mut vao_names = [0u32, 0];
        cx.gen_vertex_arrays(&mut vao_names);
        let mut buf_names = [0u32, 0];
        cx.gen_buffers(&mut buf_names);

        cx.bind_vertex_array(vao_names[0]);
        cx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, buf_names[0]);

        cx.bind_vertex_array(vao_names[1]);
        cx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, buf_names[1]);

        cx.bind_vertex_array(vao_names[0]);
        assert_eq!(cx.get_buffer_binding(glw::GL_ELEMENT_ARRAY_BUFFER), Some(buf_names[0]));
    }

    // --- Draw-call wiring (createProgram/useProgram through drawArrays/drawElements) ---

    use crate::rr::fragment_packet::FragmentPacket;
    use crate::rr::generic_vector::GenericVecType;
    use crate::rr::shaders::{FragmentInputInfo, FragmentOutputInfo, VertexInputInfo, VertexOutputInfo};
    use crate::rr::shading_context::{
        FragmentShadingContext, dfdx_varying, dfdy_varying, read_varying, write_fragment_output,
    };
    use crate::rr::vertex_attrib::read_vertex_attrib_float;
    use crate::rr::vertex_packet::VertexPacket;

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

    struct ConstantColorFragmentShader {
        inputs: Vec<FragmentInputInfo>,
        outputs: Vec<FragmentOutputInfo>,
        color: Vec4,
    }

    impl ConstantColorFragmentShader {
        fn new(color: Vec4) -> Self {
            Self {
                inputs: vec![],
                outputs: vec![FragmentOutputInfo {
                    type_: Some(GenericVecType::Float),
                }],
                color,
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
            eprintln!("shade_fragments called with {} packets", packets.len());
            let value = GenericVec4::from_float(self.color);
            for (packet_ndx, _) in packets.iter().enumerate() {
                for frag_ndx in 0..4 {
                    unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, value) };
                }
            }
        }
    }

    /// `ConstantColorFragmentShader`'s integer-output sibling - exists only to prove
    /// out `draw_with_reference`'s own integer colour path end to end through the
    /// *real* GL-state-machine draw call (`draw_arrays`/`draw_elements`), not just
    /// `clear_buffer_iv`/`clear_buffer_uiv` (see those tests just above - they already
    /// cover the clear path into an integer-format attachment, but nothing here had
    /// ever exercised a genuine *draw*). Nothing in `draw_with_reference` is
    /// float-specific - `resolve_targets`'s `color_target` is a plain
    /// `PixelBufferAccess` whose format comes straight from whatever the bound
    /// attachment's real storage format is, and `rr::Renderer::draw_instanced` ->
    /// `FragmentProcessor::render` dispatches on that format's own channel class
    /// (`rr::fragment_operations`'s integer colour-write path, ported alongside
    /// multisample support) - so declaring an `Int32`/`Uint32` fragment output here and
    /// pointing the draw at an integer renderbuffer attachment was expected to already
    /// work with zero further plumbing. This shader is what confirms that rather than
    /// merely arguing it from reading the code.
    struct IntegerConstantFragmentShader {
        inputs: Vec<FragmentInputInfo>,
        outputs: Vec<FragmentOutputInfo>,
        value: GenericVec4,
    }

    impl IntegerConstantFragmentShader {
        fn new_signed(v: IVec4) -> Self {
            Self {
                inputs: vec![],
                outputs: vec![FragmentOutputInfo {
                    type_: Some(GenericVecType::Int32),
                }],
                value: GenericVec4::from_int(v),
            }
        }

        fn new_unsigned(v: UVec4) -> Self {
            Self {
                inputs: vec![],
                outputs: vec![FragmentOutputInfo {
                    type_: Some(GenericVecType::Uint32),
                }],
                value: GenericVec4::from_uint(v),
            }
        }
    }

    impl FragmentShader for IntegerConstantFragmentShader {
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

    /// A second-attribute-carrying vertex shader: passes `position` straight through
    /// (attribute 0, exactly like `PassthroughVertexShader`) and copies attribute 1
    /// into varying slot 0 unchanged - a texture coordinate, in every caller below, but
    /// nothing here is specific to that; any per-vertex value a fragment shader wants
    /// interpolated goes through the same shape. This is what demonstrates the "Note on
    /// the fbo.render / fragment_ops sampler-wiring question": a concrete shader pair needs no change
    /// to `ReferenceContext` itself to read a texture during shading.
    struct TexcoordPassthroughVertexShader {
        inputs: Vec<VertexInputInfo>,
        outputs: Vec<VertexOutputInfo>,
    }

    impl TexcoordPassthroughVertexShader {
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
                outputs: vec![VertexOutputInfo {
                    type_: Some(GenericVecType::Float),
                    flatshade: false,
                }],
            }
        }
    }

    impl VertexShader for TexcoordPassthroughVertexShader {
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

                let mut texcoord = Vec4::splat(0.0);
                unsafe {
                    read_vertex_attrib_float(&mut texcoord, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0)
                };
                packet.outputs[0] = GenericVec4::from_float(texcoord);
            }
        }
    }

    /// A `NEAREST`/`CLAMP_TO_EDGE` texture-sampling fragment shader - every fragment
    /// reads varying 0 as a normalized `(s, t)` and samples `self.level` directly via
    /// the already-ported `ConstPixelBufferAccess::sample_2d`. Deliberately holds an
    /// owned `TextureLevel` snapshot (cloned from a `Texture2D`'s level at program
    /// construction time) rather than a live reference into `ReferenceContext`'s own
    /// texture storage - no generic uniform-slot system is needed: a concrete
    /// shader struct can simply own what it needs to sample.
    struct Texture2DSampleFragmentShader {
        inputs: Vec<FragmentInputInfo>,
        outputs: Vec<FragmentOutputInfo>,
        level: TextureLevel,
        sampler: crate::tcu::pixel::Sampler,
    }

    impl Texture2DSampleFragmentShader {
        fn new(level: TextureLevel) -> Self {
            Self {
                inputs: vec![FragmentInputInfo {
                    type_: Some(GenericVecType::Float),
                    flatshade: false,
                }],
                outputs: vec![FragmentOutputInfo {
                    type_: Some(GenericVecType::Float),
                }],
                level,
                // GLSL-style normalized `[0,1]` texture coordinates - `clamp_to_edge`'s
                // own default (`normalized_coords: false`) is for `tcu::scale`'s
                // pixel-space blit, not a shader varying; see this port's own
                // `glu::texture_test_util` module for the same distinction (its
                // `normalized_sampler` test helper).
                sampler: crate::tcu::pixel::Sampler {
                    normalized_coords: true,
                    ..crate::tcu::pixel::Sampler::clamp_to_edge(crate::tcu::pixel::FilterMode::Nearest)
                },
            }
        }
    }

    impl FragmentShader for Texture2DSampleFragmentShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            &self.inputs
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            &self.outputs
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            let access = self.level.get_const_access();
            for (packet_ndx, packet) in packets.iter().enumerate() {
                for frag_ndx in 0..4 {
                    let uv = unsafe { read_varying(packet, context, 0, frag_ndx as usize) };
                    let sample = access.sample_2d(&self.sampler, uv.x(), uv.y(), 0);
                    let value = GenericVec4::from_float(Vec4::new(sample[0], sample[1], sample[2], sample[3]));
                    unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, value) };
                }
            }
        }
    }

    /// A full-screen two-triangle quad with exact NDC corners (as opposed to
    /// `make_quad_buffer`'s single huge over-sized triangle, which relies on clipping
    /// to cover every pixel but gives no control over per-vertex attributes like a
    /// texture coordinate) - attribute 0 is clip-space position, attribute 1 is a `(u,
    /// v)` texture coordinate running `[0,1]` corner to corner, bound to attributes 0/1
    /// via two separate buffers (one per attribute, matching how every other test
    /// in this file binds one buffer per `vertex_attrib_pointer` call).
    fn make_textured_quad_buffers(cx: &mut ReferenceContext) {
        let mut names = [0u32, 0u32];
        cx.gen_buffers(&mut names);

        #[rustfmt::skip]
        let position_data: [[f32; 4]; 6] = [
            [-1.0, -1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0], [1.0, 1.0, 0.0, 1.0], [-1.0, 1.0, 0.0, 1.0],
        ];
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, names[0]);
        let bytes = unsafe {
            std::slice::from_raw_parts(
                position_data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(&position_data),
            )
        };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        #[rustfmt::skip]
        let texcoord_data: [[f32; 2]; 6] = [
            [0.0, 0.0], [1.0, 0.0], [1.0, 1.0],
            [0.0, 0.0], [1.0, 1.0], [0.0, 1.0],
        ];
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, names[1]);
        let bytes = unsafe {
            std::slice::from_raw_parts(
                texcoord_data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(&texcoord_data),
            )
        };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
        cx.vertex_attrib_pointer(1, 2, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(1);
    }

    #[test]
    fn drawing_a_textured_quad_samples_the_texture_during_fragment_shading() {
        // Demonstrates the "no change to ReferenceContext itself needed" claim: a concrete
        // FragmentShader that owns a texture level and samples it per-fragment needs
        // nothing from ReferenceContext beyond what the buffer/VAO/draw-call plumbing
        // already provides - not a generic uniform/sampler system.
        let mut cx = ctx_with_size(4, 4);

        let mut checkerboard = TextureLevel::new(
            crate::tcu::texture::TextureFormat::new(
                crate::tcu::texture::ChannelOrder::RGBA,
                crate::tcu::texture::ChannelType::UNORM_INT8,
            ),
            2,
            2,
            1,
        )
        .unwrap();
        {
            let mut access = checkerboard.get_access();
            access.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // texel (0,0): red
            access.set_pixel([0.0, 1.0, 0.0, 1.0], 1, 0, 0); // texel (1,0): green
            access.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 1, 0); // texel (0,1): blue
            access.set_pixel([1.0, 1.0, 0.0, 1.0], 1, 1, 0); // texel (1,1): yellow
        }

        make_textured_quad_buffers(&mut cx);
        let program = cx.create_program(
            Box::new(TexcoordPassthroughVertexShader::new()),
            Box::new(Texture2DSampleFragmentShader::new(checkerboard)),
        );
        cx.use_program(program);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        // `scissor_test_confines_drawing_to_the_scissor_rectangle` (above) already
        // establishes this port's own convention: destination pixel (0,0) is the
        // bottom-left of the viewport. `make_textured_quad_buffers` pairs NDC corner
        // (-1,-1) (bottom-left) with texcoord (0,0), (1,-1) (bottom-right) with (1,0),
        // (1,1) (top-right) with (1,1), and (-1,1) (top-left) with (0,1) - so each
        // destination corner must reproduce the texel its own corner's texcoord names.
        let access = cx.color_buffer().get_const_access();
        assert_eq!(
            access.get_pixel(0, 0, 0),
            [1.0, 0.0, 0.0, 1.0],
            "bottom-left destination corner should read the texture's (0,0) (red) texel"
        );
        assert_eq!(
            access.get_pixel(3, 0, 0),
            [0.0, 1.0, 0.0, 1.0],
            "bottom-right destination corner should read the texture's (1,0) (green) texel"
        );
        assert_eq!(
            access.get_pixel(3, 3, 0),
            [1.0, 1.0, 0.0, 1.0],
            "top-right destination corner should read the texture's (1,1) (yellow) texel"
        );
        assert_eq!(
            access.get_pixel(0, 3, 0),
            [0.0, 0.0, 1.0, 1.0],
            "top-left destination corner should read the texture's (0,1) (blue) texel"
        );
    }

    /// A `ShaderProgram` (not a plain `VertexShader`/`FragmentShader` pair) declaring
    /// one `Sampler2D` uniform (`u_sampler0`) - exercises the `uniform1i`/
    /// `resolve_sampler_uniforms`/`bind_samplers` path end to end, as opposed to
    /// `Texture2DSampleFragmentShader` above (a plain pair whose texture level is
    /// fixed at construction time, never touching a uniform at all).
    struct Sampler2DUniformShader {
        base: ShaderProgramBase,
        bound_sampler: Option<ResolvedSampler2D>,
    }

    impl Sampler2DUniformShader {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
                .vertex_attribute(pdec::VertexAttribute::new("a_texCoord", GenericVecType::Float))
                .vertex_to_fragment_varying(pdec::VertexToFragmentVarying::new(GenericVecType::Float))
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_sampler0", DataType::Sampler2D))
                .vertex_source("attribute highp vec4 a_position;\nattribute mediump vec2 a_texCoord;\nvarying mediump vec2 v_texCoord;\nvoid main (void)\n{\n    gl_Position = a_position;\n    v_texCoord = a_texCoord;\n}\n")
                .fragment_source("uniform sampler2D u_sampler0;\nvarying mediump vec2 v_texCoord;\nvoid main (void)\n{\n    gl_FragColor = texture2D(u_sampler0, v_texCoord);\n}\n");
            Self {
                base: ShaderProgramBase::new(&decl),
                bound_sampler: None,
            }
        }
    }

    impl VertexShader for Sampler2DUniformShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
            for packet in packets.iter_mut() {
                let mut position = Vec4::splat(0.0);
                unsafe {
                    read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0)
                };
                packet.position = position;

                let mut texcoord = Vec4::splat(0.0);
                unsafe {
                    read_vertex_attrib_float(&mut texcoord, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0)
                };
                packet.outputs[0] = GenericVec4::from_float(texcoord);
            }
        }
    }

    impl FragmentShader for Sampler2DUniformShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            let Some(sampler) = &self.bound_sampler else {
                // No texture resolved at `u_sampler0`'s unit (nothing bound, the bound
                // texture isn't mipmap-complete, or `bind_samplers` never ran) - matches
                // upstream's own `&m_emptyTex2D` fallback: a real (if conceptual)
                // transparent-black `CLAMP_TO_EDGE`/`NEAREST` texture, so every covered
                // fragment writes `(0,0,0,0)` explicitly rather than simply returning -
                // a bare `return` here would happen to produce the same colour only
                // because `rr::Renderer`'s own fragment-output buffer starts
                // zero-initialized per draw call, which is an implementation detail of
                // the renderer, not a property of "no sampler bound" this shader should
                // rely on.
                for (packet_ndx, _) in packets.iter().enumerate() {
                    for frag_ndx in 0..4 {
                        unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, GenericVec4::zero()) };
                    }
                }
                return;
            };
            for (packet_ndx, packet) in packets.iter().enumerate() {
                // `dfdx_varying`/`dfdy_varying` compute both derivatives for the whole
                // quad in one call each - hoisted out of the per-fragment loop below,
                // same as `write_fragment_output`'s own per-packet grouping.
                let dfdx = unsafe { dfdx_varying(packet, context, 0) };
                let dfdy = unsafe { dfdy_varying(packet, context, 0) };
                for frag_ndx in 0..4usize {
                    let uv = unsafe { read_varying(packet, context, 0, frag_ndx) };
                    let sample = sampler.sample_2d_quad(
                        uv.x(),
                        uv.y(),
                        (dfdx[frag_ndx].x(), dfdx[frag_ndx].y()),
                        (dfdy[frag_ndx].x(), dfdy[frag_ndx].y()),
                    );
                    let value = GenericVec4::from_float(Vec4::new(sample[0], sample[1], sample[2], sample[3]));
                    unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx as i32, 0, value) };
                }
            }
        }
    }

    impl ShaderProgram for Sampler2DUniformShader {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
        fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
            for (name, sampler) in resolved {
                if name == "u_sampler0" {
                    self.bound_sampler = sampler.as_ref().and_then(ResolvedSampler::as_2d).cloned();
                }
            }
        }
    }

    #[test]
    fn uniform1i_resolves_a_sampler_uniform_to_the_bound_texture_at_draw_time() {
        let mut cx = ctx_with_size(4, 4);

        // The checkerboard lives on texture unit 1, not 0 - proves `uniform1i`'s value
        // (not just "whatever happens to be on unit 0") is what gets resolved.
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.active_texture(glw::GL_TEXTURE1);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        #[rustfmt::skip]
        let data: [u8; 16] = [
            255, 0, 0, 255,    0, 255, 0, 255,
            0, 0, 255, 255,    255, 255, 0, 255,
        ];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        // `GL_TEXTURE_MIN_FILTER`'s own GL default (`GL_NEAREST_MIPMAP_LINEAR`) is a
        // mipmap mode, and this texture only ever gets level 0 - so without this,
        // `Texture2D::is_complete` would correctly call it incomplete and
        // `resolve_sampler` would resolve to `None`. `CLAMP_TO_EDGE`/`NEAREST` on both
        // axes also exercises the actual wrap/filter wiring this test is for, not just
        // the completeness gate - see the corner assertions below, unchanged from
        // before this wiring existed because they were already written against exactly
        // this sampler shape (then hardcoded in the shader, now driven by these calls).
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        cx.active_texture(glw::GL_TEXTURE0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        make_textured_quad_buffers(&mut cx);
        let program = cx.create_shader_program(Box::new(Sampler2DUniformShader::new()));
        cx.use_program(program);

        let loc = cx.get_uniform_location(program, "u_sampler0");
        assert!(loc >= 0, "u_sampler0 must be a declared uniform");
        cx.uniform1i(loc, 1);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        // Same corner <-> texcoord convention `drawing_a_textured_quad_samples_the_
        // texture_during_fragment_shading` above already established.
        let access = cx.color_buffer().get_const_access();
        assert_eq!(
            access.get_pixel(0, 0, 0),
            [1.0, 0.0, 0.0, 1.0],
            "bottom-left should read the texture's (0,0) (red) texel"
        );
        assert_eq!(
            access.get_pixel(3, 0, 0),
            [0.0, 1.0, 0.0, 1.0],
            "bottom-right should read the texture's (1,0) (green) texel"
        );
        assert_eq!(
            access.get_pixel(3, 3, 0),
            [1.0, 1.0, 0.0, 1.0],
            "top-right should read the texture's (1,1) (yellow) texel"
        );
        assert_eq!(
            access.get_pixel(0, 3, 0),
            [0.0, 0.0, 1.0, 1.0],
            "top-left should read the texture's (0,1) (blue) texel"
        );
    }

    #[test]
    fn an_incomplete_texture_resolves_to_no_sampler_and_every_fragment_reads_transparent_black() {
        let mut cx = ctx_with_size(2, 2);
        // A clear colour that cannot be mistaken for the transparent-black fallback this
        // test expects every covered pixel to become instead.
        cx.clear_color(0.0, 1.0, 0.0, 1.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        // `GL_TEXTURE_MIN_FILTER`'s own GL default (`GL_NEAREST_MIPMAP_LINEAR`) is a
        // mipmap mode. A 2x2 base level needs level 1 (1x1) too to be complete
        // (`num_mip_levels_2d(2, 2) == 2`) - deliberately never uploaded, so
        // `Texture2D::is_complete` reports incomplete. A 1x1 base level would not have
        // worked here: `num_mip_levels_2d(1, 1) == 1`, so it is already its own complete
        // one-level pyramid regardless of the min filter.
        let data: [u8; 16] = [
            255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        ];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert!(
            !cx.texture(names[0]).unwrap().is_complete(),
            "a mipmap min filter with only level 0 uploaded must be incomplete"
        );

        make_textured_quad_buffers(&mut cx);
        let program = cx.create_shader_program(Box::new(Sampler2DUniformShader::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_sampler0");
        assert!(loc >= 0);
        cx.uniform1i(loc, 0);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        // `resolve_sampler_uniforms` must have resolved `u_sampler0` to `None` (matching
        // upstream's own `&m_emptyTex2D` fallback), so every covered pixel became
        // transparent black - the full-screen quad covers every pixel of this 2x2
        // target, which is what tells the clear colour above apart from "the texture's
        // own transparent-black fallback happened to equal it".
        let access = cx.color_buffer().get_const_access();
        for y in 0..2 {
            for x in 0..2 {
                assert_eq!(
                    access.get_pixel(x, y, 0),
                    [0.0, 0.0, 0.0, 0.0],
                    "pixel ({x},{y}) should be the empty-texture fallback colour, not the clear colour"
                );
            }
        }
    }

    /// A position-only `VertexShader` shared by the four non-`Sampler2D` uniform tests
    /// below - none of them needs a per-fragment-varying texture coordinate, since each
    /// samples at one fixed, hardcoded coordinate written directly into `shade_fragments`
    /// (see `SamplerCubeUniformShader`'s own doc comment for why a fixed coordinate,
    /// rather than one carried by a varying the way `Sampler2DUniformShader`'s planar
    /// `v_texCoord` is, is what keeps these hand-verifiable).
    fn passthrough_position_vertex_shader(inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
        for packet in packets.iter_mut() {
            let mut position = Vec4::splat(0.0);
            unsafe { read_vertex_attrib_float(&mut position, &inputs[0], packet.instance_ndx, packet.vertex_ndx, 0) };
            packet.position = position;
        }
    }

    /// Writes `value` to every fragment of every packet - shared by the four shaders
    /// below for both their "no sampler bound" fallback (transparent black, matching
    /// `Sampler2DUniformShader`'s own) and their one-fixed-sample result.
    fn fill_fragment_output(packets: &[FragmentPacket], context: &FragmentShadingContext, value: GenericVec4) {
        for (packet_ndx, _) in packets.iter().enumerate() {
            for frag_ndx in 0..4 {
                unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, value) };
            }
        }
    }

    /// A `ShaderProgram` declaring one `SamplerCube` uniform (`u_samplerCube`), sampled
    /// at the fixed direction `(1, 0, 0)` - exercises the `uniform1i`/
    /// `resolve_sampler_uniforms`/`bind_samplers` path end to end for a cube sampler, the
    /// same way `Sampler2DUniformShader` does for `Sampler2D`. A fixed direction rather
    /// than one carried by a per-vertex/per-fragment varying: unlike a planar 2D
    /// texcoord, a cube direction vector's linear interpolation across a flat quad does
    /// not trace a simple per-corner-texel path (the direction (1,1,1)/2 at a quad's
    /// centre is not "halfway" between two face texels in any way worth hand-verifying),
    /// so a fixed per-draw direction is what keeps this test tractable while still
    /// proving the whole pipeline - `direction (1,0,0)` is `CubeFace::PositiveX`
    /// (`select_cube_face`'s own major-axis rule), face index `0` in this port's own
    /// `GL_TEXTURE_CUBE_MAP_POSITIVE_X`-first storage order (`get_cube_array_face_index`).
    struct SamplerCubeUniformShader {
        base: ShaderProgramBase,
        bound_sampler: Option<ResolvedSamplerCube>,
    }

    impl SamplerCubeUniformShader {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_samplerCube", DataType::SamplerCube))
                .vertex_source("attribute highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n")
                .fragment_source("uniform samplerCube u_samplerCube;\nvoid main (void)\n{\n    gl_FragColor = textureCube(u_samplerCube, vec3(1.0, 0.0, 0.0));\n}\n");
            Self {
                base: ShaderProgramBase::new(&decl),
                bound_sampler: None,
            }
        }
    }

    impl VertexShader for SamplerCubeUniformShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
            passthrough_position_vertex_shader(inputs, packets);
        }
    }

    impl FragmentShader for SamplerCubeUniformShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            let Some(sampler) = &self.bound_sampler else {
                fill_fragment_output(packets, context, GenericVec4::zero());
                return;
            };
            let sample = sampler.sample(1.0, 0.0, 0.0, 0.0);
            let value = GenericVec4::from_float(Vec4::new(sample[0], sample[1], sample[2], sample[3]));
            fill_fragment_output(packets, context, value);
        }
    }

    impl ShaderProgram for SamplerCubeUniformShader {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
        fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
            for (name, sampler) in resolved {
                if name == "u_samplerCube" {
                    self.bound_sampler = sampler.as_ref().and_then(ResolvedSampler::as_cube).cloned();
                }
            }
        }
    }

    #[test]
    fn drawing_with_a_sampler_cube_uniform_samples_the_bound_cube_texture() {
        let mut cx = ctx_with_size(2, 2);

        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);
        // One 1x1 texel per face, each a distinct colour - `+X` (face index 0 in this
        // port's own storage order) is red, every other face a colour that could never
        // be mistaken for it.
        let faces: [[u8; 4]; 6] = [
            [255, 0, 0, 255],
            [0, 255, 0, 255],
            [0, 0, 255, 255],
            [255, 255, 0, 255],
            [255, 0, 255, 255],
            [0, 255, 255, 255],
        ];
        for (face_index, data) in faces.iter().enumerate() {
            cx.tex_image_2d(
                glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + face_index as u32,
                0,
                glw::GL_RGBA8,
                1,
                1,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                Some(data),
            );
        }
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_NEAREST as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_cube(names[0]).unwrap().is_complete());

        make_textured_quad_buffers(&mut cx);
        let program = cx.create_shader_program(Box::new(SamplerCubeUniformShader::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_samplerCube");
        assert!(loc >= 0, "u_samplerCube must be a declared uniform");
        cx.uniform1i(loc, 0);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let access = cx.color_buffer().get_const_access();
        for y in 0..2 {
            for x in 0..2 {
                assert_eq!(
                    access.get_pixel(x, y, 0),
                    [1.0, 0.0, 0.0, 1.0],
                    "pixel ({x},{y}) should read the +X face's red texel - direction (1,0,0) is hardcoded in the shader"
                );
            }
        }
    }

    /// A `ShaderProgram` declaring one `Sampler2DArray` uniform (`u_sampler2DArray`),
    /// sampled at the fixed coordinate `(0.5, 0.5, 0.2)` - `r=0.2` selects layer `0`
    /// (`select_layer`'s own `(r + 0.5).floor()` rule: `(0.7).floor() == 0`), the same
    /// fixed-coordinate approach `SamplerCubeUniformShader` uses and for the same reason
    /// (a 1x1-per-layer texture makes the exact `s`/`t` value immaterial, so `0.5` keeps
    /// the nearest tap away from any texel-boundary ambiguity).
    struct Sampler2DArrayUniformShader {
        base: ShaderProgramBase,
        bound_sampler: Option<ResolvedSampler2DArray>,
    }

    impl Sampler2DArrayUniformShader {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_sampler2DArray", DataType::Sampler2DArray))
                .vertex_source("#version 300 es\nin highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n")
                .fragment_source(
                    "#version 300 es\nprecision mediump float;\nuniform sampler2DArray u_sampler2DArray;\nlayout(location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    o_color = texture(u_sampler2DArray, vec3(0.5, 0.5, 0.2));\n}\n",
                );
            Self {
                base: ShaderProgramBase::new(&decl),
                bound_sampler: None,
            }
        }
    }

    impl VertexShader for Sampler2DArrayUniformShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
            passthrough_position_vertex_shader(inputs, packets);
        }
    }

    impl FragmentShader for Sampler2DArrayUniformShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            let Some(sampler) = &self.bound_sampler else {
                fill_fragment_output(packets, context, GenericVec4::zero());
                return;
            };
            let sample = sampler.sample(0.5, 0.5, 0.2, 0.0);
            let value = GenericVec4::from_float(Vec4::new(sample[0], sample[1], sample[2], sample[3]));
            fill_fragment_output(packets, context, value);
        }
    }

    impl ShaderProgram for Sampler2DArrayUniformShader {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
        fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
            for (name, sampler) in resolved {
                if name == "u_sampler2DArray" {
                    self.bound_sampler = sampler.as_ref().and_then(ResolvedSampler::as_2d_array).cloned();
                }
            }
        }
    }

    #[test]
    fn drawing_with_a_sampler_2d_array_uniform_samples_the_bound_layer() {
        let mut cx = ctx_with_size(2, 2);

        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);
        // 1x1 RGBA8, two layers: red into layer 0, green into layer 1 - same data shape
        // `tex_image_3d_on_a_2d_array_uploads_into_the_right_layer` already establishes.
        let data: [u8; 8] = [255, 0, 0, 255, 0, 255, 0, 255];
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_2D_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_2D_ARRAY,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_NEAREST as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_2d_array(names[0]).unwrap().is_complete());

        make_textured_quad_buffers(&mut cx);
        let program = cx.create_shader_program(Box::new(Sampler2DArrayUniformShader::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_sampler2DArray");
        assert!(loc >= 0, "u_sampler2DArray must be a declared uniform");
        cx.uniform1i(loc, 0);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let access = cx.color_buffer().get_const_access();
        for y in 0..2 {
            for x in 0..2 {
                assert_eq!(
                    access.get_pixel(x, y, 0),
                    [1.0, 0.0, 0.0, 1.0],
                    "pixel ({x},{y}) should read layer 0's red texel - r=0.2 selects layer 0"
                );
            }
        }
    }

    /// A `ShaderProgram` declaring one `Sampler3D` uniform (`u_sampler3D`), sampled at
    /// the fixed coordinate `(0.5, 0.5, 0.2)` - `r=0.2` against a depth-2 volume
    /// unnormalizes to `0.4` (`ConstPixelBufferAccess::sample_3d`'s own `size * c`
    /// formula), and `floor(0.4) == 0` selects depth slice `0`, comfortably away from
    /// the `0.5` boundary between the two slices.
    struct Sampler3DUniformShader {
        base: ShaderProgramBase,
        bound_sampler: Option<ResolvedSampler3D>,
    }

    impl Sampler3DUniformShader {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_sampler3D", DataType::Sampler3D))
                .vertex_source("#version 300 es\nin highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n")
                .fragment_source(
                    "#version 300 es\nprecision mediump float;\nuniform sampler3D u_sampler3D;\nlayout(location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    o_color = texture(u_sampler3D, vec3(0.5, 0.5, 0.2));\n}\n",
                );
            Self {
                base: ShaderProgramBase::new(&decl),
                bound_sampler: None,
            }
        }
    }

    impl VertexShader for Sampler3DUniformShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
            passthrough_position_vertex_shader(inputs, packets);
        }
    }

    impl FragmentShader for Sampler3DUniformShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            let Some(sampler) = &self.bound_sampler else {
                fill_fragment_output(packets, context, GenericVec4::zero());
                return;
            };
            let sample = sampler.sample(0.5, 0.5, 0.2, 0.0);
            let value = GenericVec4::from_float(Vec4::new(sample[0], sample[1], sample[2], sample[3]));
            fill_fragment_output(packets, context, value);
        }
    }

    impl ShaderProgram for Sampler3DUniformShader {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
        fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
            for (name, sampler) in resolved {
                if name == "u_sampler3D" {
                    self.bound_sampler = sampler.as_ref().and_then(ResolvedSampler::as_3d).cloned();
                }
            }
        }
    }

    #[test]
    fn drawing_with_a_sampler_3d_uniform_samples_the_bound_depth_slice() {
        let mut cx = ctx_with_size(2, 2);

        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_3D, names[0]);
        // 1x1xN RGBA8, two depth slices: red at z=0, green at z=1.
        let data: [u8; 8] = [255, 0, 0, 255, 0, 255, 0, 255];
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            1,
            1,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        cx.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_3d(names[0]).unwrap().is_complete());

        make_textured_quad_buffers(&mut cx);
        let program = cx.create_shader_program(Box::new(Sampler3DUniformShader::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_sampler3D");
        assert!(loc >= 0, "u_sampler3D must be a declared uniform");
        cx.uniform1i(loc, 0);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let access = cx.color_buffer().get_const_access();
        for y in 0..2 {
            for x in 0..2 {
                assert_eq!(
                    access.get_pixel(x, y, 0),
                    [1.0, 0.0, 0.0, 1.0],
                    "pixel ({x},{y}) should read depth slice 0's red texel - r=0.2 unnormalizes to 0.4, floor 0"
                );
            }
        }
    }

    /// A `ShaderProgram` declaring one `SamplerCubeArray` uniform (`u_samplerCubeArray`),
    /// sampled at the fixed direction `(1, 0, 0)` and layer coordinate `q=0.2` - the same
    /// `+X`-face reasoning `SamplerCubeUniformShader` gives (face index `0`), combined
    /// with the same layer-0 reasoning `Sampler2DArrayUniformShader` gives
    /// (`select_layer(0.2, 2) == 0`), so the one texel this should read is the one
    /// stored at the flattened depth slice `layer * 6 + face == 0 * 6 + 0 == 0`.
    struct SamplerCubeArrayUniformShader {
        base: ShaderProgramBase,
        bound_sampler: Option<ResolvedSamplerCubeArray>,
    }

    impl SamplerCubeArrayUniformShader {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_samplerCubeArray", DataType::SamplerCubeArray))
                .vertex_source("#version 320 es\nin highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n")
                .fragment_source(
                    "#version 320 es\nprecision mediump float;\nuniform samplerCubeArray u_samplerCubeArray;\nlayout(location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    o_color = texture(u_samplerCubeArray, vec4(1.0, 0.0, 0.0, 0.2));\n}\n",
                );
            Self {
                base: ShaderProgramBase::new(&decl),
                bound_sampler: None,
            }
        }
    }

    impl VertexShader for SamplerCubeArrayUniformShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
            passthrough_position_vertex_shader(inputs, packets);
        }
    }

    impl FragmentShader for SamplerCubeArrayUniformShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            let Some(sampler) = &self.bound_sampler else {
                fill_fragment_output(packets, context, GenericVec4::zero());
                return;
            };
            let sample = sampler.sample(1.0, 0.0, 0.0, 0.2, 0.0);
            let value = GenericVec4::from_float(Vec4::new(sample[0], sample[1], sample[2], sample[3]));
            fill_fragment_output(packets, context, value);
        }
    }

    impl ShaderProgram for SamplerCubeArrayUniformShader {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
        fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
            for (name, sampler) in resolved {
                if name == "u_samplerCubeArray" {
                    self.bound_sampler = sampler.as_ref().and_then(ResolvedSampler::as_cube_array).cloned();
                }
            }
        }
    }

    #[test]
    fn drawing_with_a_sampler_cube_array_uniform_samples_the_bound_layer_and_face() {
        let mut cx = ctx_with_size(2, 2);

        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);
        // 1x1 RGBA8, 2 array layers (depth = 12 = 2 * 6) - every face of layer 0 is red,
        // every face of layer 1 a colour that could never be mistaken for it, so a test
        // that reads the wrong layer (not just the wrong face) fails loudly too.
        let mut data = [0u8; 12 * 4];
        for depth in 0..6usize {
            data[depth * 4..depth * 4 + 4].copy_from_slice(&[255, 0, 0, 255]);
        }
        for depth in 6..12usize {
            data[depth * 4..depth * 4 + 4].copy_from_slice(&[0, 255, 0, 255]);
        }
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            12,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_NEAREST as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_cube_array(names[0]).unwrap().is_complete());

        make_textured_quad_buffers(&mut cx);
        let program = cx.create_shader_program(Box::new(SamplerCubeArrayUniformShader::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_samplerCubeArray");
        assert!(loc >= 0, "u_samplerCubeArray must be a declared uniform");
        cx.uniform1i(loc, 0);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let access = cx.color_buffer().get_const_access();
        for y in 0..2 {
            for x in 0..2 {
                assert_eq!(
                    access.get_pixel(x, y, 0),
                    [1.0, 0.0, 0.0, 1.0],
                    "pixel ({x},{y}) should read layer 0's +X face (red) - direction (1,0,0), q=0.2 select layer 0"
                );
            }
        }
    }

    /// A `ShaderProgram` declaring one `SamplerBuffer` uniform (`u_samplerBuffer`),
    /// `texelFetch`ing a fixed index (2) - `samplerBuffer` has no `texture()` overload at
    /// all in GLSL ES, so (unlike every other sampler uniform shader in this file) there
    /// is no `s`/`t`/... coordinate to vary; the index is the whole story.
    struct SamplerBufferUniformShader {
        base: ShaderProgramBase,
        bound_sampler: Option<ResolvedSamplerBuffer>,
    }

    impl SamplerBufferUniformShader {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_samplerBuffer", DataType::SamplerBuffer))
                .vertex_source("#version 320 es\nin highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n")
                .fragment_source(
                    "#version 320 es\nprecision mediump float;\nuniform samplerBuffer u_samplerBuffer;\nlayout(location = 0) out mediump vec4 o_color;\nvoid main (void)\n{\n    o_color = texelFetch(u_samplerBuffer, 2);\n}\n",
                );
            Self {
                base: ShaderProgramBase::new(&decl),
                bound_sampler: None,
            }
        }
    }

    impl VertexShader for SamplerBufferUniformShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(&self, inputs: &[VertexAttrib], packets: &mut [VertexPacket]) {
            passthrough_position_vertex_shader(inputs, packets);
        }
    }

    impl FragmentShader for SamplerBufferUniformShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            let Some(sampler) = &self.bound_sampler else {
                fill_fragment_output(packets, context, GenericVec4::zero());
                return;
            };
            let sample = sampler.texel_fetch(2);
            let value = GenericVec4::from_float(Vec4::new(sample[0], sample[1], sample[2], sample[3]));
            fill_fragment_output(packets, context, value);
        }
    }

    impl ShaderProgram for SamplerBufferUniformShader {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
        fn bind_samplers(&mut self, resolved: &[(String, Option<ResolvedSampler>)]) {
            for (name, sampler) in resolved {
                if name == "u_samplerBuffer" {
                    self.bound_sampler = sampler.as_ref().and_then(ResolvedSampler::as_buffer).cloned();
                }
            }
        }
    }

    #[test]
    fn drawing_with_a_sampler_buffer_uniform_texel_fetches_the_attached_buffer() {
        // `texelFetch(u_samplerBuffer, 2)` reads back `30.0` raw - a `UNORM_INT8` colour
        // buffer (`ctx_with_size`'s own) would clamp that to `1.0` before this test ever
        // gets to read it, so this needs the float variant.
        let mut cx = ctx_with_float_color(2, 2);

        let mut buf_names = [0u32];
        cx.gen_buffers(&mut buf_names);
        // `glTexBuffer` attaches by name, not by binding point, so any buffer target
        // works to upload into it first - `GL_ARRAY_BUFFER` here is otherwise unrelated.
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, buf_names[0]);
        let values: [f32; 4] = [10.0, 20.0, 30.0, 40.0];
        let mut bytes = Vec::with_capacity(16);
        for v in values {
            bytes.extend_from_slice(&v.to_ne_bytes());
        }
        cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(&bytes));

        let mut tex_names = [0u32];
        cx.gen_textures(&mut tex_names);
        cx.bind_texture(glw::GL_TEXTURE_BUFFER, tex_names[0]);
        cx.tex_buffer(glw::GL_TEXTURE_BUFFER, glw::GL_R32F, buf_names[0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        make_textured_quad_buffers(&mut cx);
        let program = cx.create_shader_program(Box::new(SamplerBufferUniformShader::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_samplerBuffer");
        assert!(loc >= 0, "u_samplerBuffer must be a declared uniform");
        cx.uniform1i(loc, 0);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 6);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let access = cx.color_buffer().get_const_access();
        for y in 0..2 {
            for x in 0..2 {
                // `texelFetch(u_samplerBuffer, 2)` reads the third float (30.0) into the
                // red channel - `GL_R32F`'s `ChannelOrder::R` reads back as
                // `[stored, 0.0, 0.0, 1.0]` (`get_channel_read_swizzle`'s own `R` arm),
                // green/blue zero-filled and alpha defaulted to 1, matching GL's own
                // single-channel-format convention.
                assert_eq!(
                    access.get_pixel(x, y, 0),
                    [30.0, 0.0, 0.0, 1.0],
                    "pixel ({x},{y}) should read texel index 2 (30.0)"
                );
            }
        }
    }

    #[test]
    fn resolve_sampler_maps_nearest_filter_and_wraps_repeat_coordinates() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        #[rustfmt::skip]
        let data: [u8; 16] = [
            255, 0, 0, 255,    0, 255, 0, 255,
            0, 0, 255, 255,    255, 255, 0, 255,
        ];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as i32);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let texture = cx.texture(names[0]).unwrap();
        assert!(
            texture.is_complete(),
            "a non-mipmap min filter is complete as soon as level 0 exists"
        );
        let sampler = texture.resolve_sampler().expect("just checked is_complete");

        // Magnified (`lod < 0`): a single NEAREST tap at level 0. `(0.1, 0.1)` floors to
        // texel `(0, 0)` (red) regardless of wrap mode.
        assert_eq!(sampler.sample(0.1, 0.1, -1.0), [1.0, 0.0, 0.0, 1.0]);
        // `GL_REPEAT` must wrap `s = 1.1` to the same fractional position as `s = 0.1` -
        // `tcu::pixel::wrap`'s own `REPEAT` formula (`c.rem_euclid(size)`), exercised here
        // end to end from `texParameteri` rather than unit-tested on `wrap` alone.
        assert_eq!(
            sampler.sample(1.1, 0.1, -1.0),
            [1.0, 0.0, 0.0, 1.0],
            "GL_REPEAT must wrap s=1.1 to the same sample as s=0.1"
        );
    }

    #[test]
    fn resolve_sampler_blends_with_linear_filter_when_magnified() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        #[rustfmt::skip]
        let data: [u8; 16] = [
            255, 0, 0, 255,    0, 255, 0, 255,
            0, 0, 255, 255,    255, 255, 0, 255,
        ];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);

        let sampler = cx
            .texture(names[0])
            .unwrap()
            .resolve_sampler()
            .expect("GL_LINEAR is not a mipmap filter - complete as soon as level 0 exists");

        // `(0.5, 0.5)` unnormalizes to `(1.0, 1.0)` on a 2x2 texture, exactly the shared
        // corner of all four texels - `ConstPixelBufferAccess::sample_2d`'s own `LINEAR`
        // branch blends all four equally (weight `0.25` each): red+yellow average on the
        // R channel (`(1.0 + 1.0) * 0.25 = 0.5`), green+yellow on G, blue alone on B
        // (`1.0 * 0.25 = 0.25`), alpha is `1.0` from every texel.
        assert_eq!(sampler.sample(0.5, 0.5, -1.0), [0.5, 0.5, 0.25, 1.0]);
    }

    #[test]
    fn resolve_sampler_builds_the_whole_mip_chain_for_a_mipmap_min_filter() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        #[rustfmt::skip]
        let level0: [u8; 16] = [
            255, 0, 0, 255,    0, 255, 0, 255,
            0, 0, 255, 255,    255, 255, 0, 255,
        ];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&level0),
        );
        let level1: [u8; 4] = [255, 255, 255, 255];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            1,
            glw::GL_RGBA8,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&level1),
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST_MIPMAP_NEAREST as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let texture = cx.texture(names[0]).unwrap();
        assert!(
            texture.is_complete(),
            "both levels of a complete 2x2 pyramid (2x2, 1x1) are now present"
        );
        let sampler = texture.resolve_sampler().expect("just checked is_complete");

        // `lod = 2.0` is comfortably minified: `mipmap_level(2, 2.0)` (`tcu::pixel`'s own
        // formula, already unit-tested there) selects level 1, the solid-white 1x1 level -
        // proof `resolve_sampler` actually collected the *whole* chain, not just level 0.
        assert_eq!(sampler.sample(0.1, 0.1, 2.0), [1.0, 1.0, 1.0, 1.0]);
    }

    #[test]
    fn resolve_sampler_sample_int_reads_signed_32_bit_values_uploaded_through_the_public_api() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        // 2x2 `GL_R32I`. `ChannelOrder::R`'s own read swizzle means every texel below
        // reads back as `[value, 0, 0, 1]` (the colour path's `get_pixel` already uses
        // the same convention for a single-channel format).
        let texels: [i32; 4] = [-5, 42, 1000, -1];
        let mut data = Vec::new();
        for t in texels {
            data.extend_from_slice(&t.to_ne_bytes());
        }
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_R32I,
            2,
            2,
            0,
            glw::GL_RED_INTEGER,
            glw::GL_INT,
            Some(&data),
        );
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as i32);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let sampler = cx
            .texture(names[0])
            .unwrap()
            .resolve_sampler()
            .expect("non-mipmap min filter, level 0 present");

        // `(0.1,0.1)` floors to texel `(0,0)` = -5, magnified (`lod < 0`).
        assert_eq!(sampler.sample_int(0.1, 0.1, -1.0), [-5, 0, 0, 1]);
        // `(0.6,0.1)` floors to texel `(1,0)` = 42.
        assert_eq!(sampler.sample_int(0.6, 0.1, -1.0), [42, 0, 0, 1]);
        // `GL_REPEAT` wraps `s=1.1` to the same sample as `s=0.1`.
        assert_eq!(sampler.sample_int(1.1, 0.1, -1.0), [-5, 0, 0, 1]);
    }

    #[test]
    fn resolve_sampler_sample_uint_reads_the_full_unsigned_32_bit_range_uploaded_through_the_public_api() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        // `copy_pixels`'s own int/int dispatch is what makes this exact (bit 31 set, so
        // an `f32`-intermediate round trip - what this upload used to go through
        // unconditionally - would corrupt it): the value is above `f32`'s 24-bit
        // mantissa, and above `i32::MAX`, so a wrong dispatch would show up here either
        // as a rounded-off low bit or as a sign-reinterpreted negative value.
        let value: u32 = 0xFFFF_FFFE;
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_R32UI,
            1,
            1,
            0,
            glw::GL_RED_INTEGER,
            glw::GL_UNSIGNED_INT,
            Some(&value.to_ne_bytes()),
        );
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let sampler = cx
            .texture(names[0])
            .unwrap()
            .resolve_sampler()
            .expect("1x1, non-mipmap min filter");
        assert_eq!(sampler.sample_uint(0.1, 0.1, -1.0), [0xFFFF_FFFE, 0, 0, 1]);
    }

    #[test]
    fn tex_parameteri_compare_mode_and_func_enable_shadow_comparison_in_resolve_sampler() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        let depth: f32 = 0.5;
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_DEPTH_COMPONENT32F,
            1,
            1,
            0,
            glw::GL_DEPTH_COMPONENT,
            glw::GL_FLOAT,
            Some(&depth.to_ne_bytes()),
        );
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_COMPARE_MODE,
            glw::GL_COMPARE_REF_TO_TEXTURE as i32,
        );
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as i32);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let sampler = cx
            .texture(names[0])
            .unwrap()
            .resolve_sampler()
            .expect("1x1, non-mipmap min filter");
        // GL_LESS: `ref < stored`. `0.3 < 0.5` is true (a shadow "pass" -> 1.0);
        // `0.7 < 0.5` is false (-> 0.0).
        assert_eq!(sampler.sample_compare(0.3, 0.1, 0.1, -1.0), 1.0);
        assert_eq!(sampler.sample_compare(0.7, 0.1, 0.1, -1.0), 0.0);
    }

    #[test]
    fn resolve_sampler_without_compare_ref_to_texture_never_shadow_compares() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        let depth: f32 = 0.5;
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_DEPTH_COMPONENT32F,
            1,
            1,
            0,
            glw::GL_DEPTH_COMPONENT,
            glw::GL_FLOAT,
            Some(&depth.to_ne_bytes()),
        );
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        // `GL_TEXTURE_COMPARE_FUNC` set but `GL_TEXTURE_COMPARE_MODE` left at its
        // default `GL_NONE` - `resolve_compare_mode` must still resolve to
        // `CompareMode::None`, and `exec_compare`'s own `None => false` arm means every
        // comparison reports 0.0 regardless of `ref_`.
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_ALWAYS as i32);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let sampler = cx
            .texture(names[0])
            .unwrap()
            .resolve_sampler()
            .expect("1x1, non-mipmap min filter");
        assert_eq!(
            sampler.sample_compare(0.3, 0.1, 0.1, -1.0),
            0.0,
            "GL_COMPARE_REF_TO_TEXTURE was never set"
        );
    }

    /// `SamplerCubeArrayShadow`'s own counterpart of
    /// `tex_parameteri_compare_mode_and_func_enable_shadow_comparison_in_resolve_sampler`
    /// above - same `GL_LESS`/`ref` pass-vs-fail pair, through a 1x1-per-face, 2-layer
    /// `GL_TEXTURE_CUBE_MAP_ARRAY` depth texture instead of a `GL_TEXTURE_2D` one, sampled
    /// straight down the `+X` axis (face index 0, same reasoning
    /// `SamplerCubeArrayUniformShader`'s own doc comment gives) at `q=0.2` (layer 0, via
    /// `select_layer`). Proves `ResolvedSamplerCubeArray::compare` actually resolves
    /// through `resolve_compare_mode` and that `sample_compare` reaches
    /// `sample_cube_array_mipmap_compare` - the exact piece this round's own `tcu::pixel`
    /// addition was meant to unblock.
    #[test]
    fn tex_parameteri_compare_mode_and_func_enable_shadow_comparison_on_a_cube_array_texture() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);

        // 1x1 per face, 2 array layers (depth = 12 = 2 * 6), every texel the same depth -
        // isolates the compare behaviour from face/layer selection, the same reasoning
        // `flat_cube_array_level`'s own doc comment gives in `tcu::pixel`'s tests.
        let depth: f32 = 0.5;
        let mut data = [0u8; 12 * 4];
        for slice in 0..12usize {
            data[slice * 4..slice * 4 + 4].copy_from_slice(&depth.to_ne_bytes());
        }
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_DEPTH_COMPONENT32F,
            1,
            1,
            12,
            0,
            glw::GL_DEPTH_COMPONENT,
            glw::GL_FLOAT,
            Some(&data),
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_NEAREST as i32,
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_COMPARE_MODE,
            glw::GL_COMPARE_REF_TO_TEXTURE as i32,
        );
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_COMPARE_FUNC,
            glw::GL_LESS as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let sampler = cx
            .texture_cube_array(names[0])
            .unwrap()
            .resolve_sampler()
            .expect("1x1 per face, non-mipmap min filter");
        // GL_LESS: `ref < stored`. `0.3 < 0.5` is true (a shadow "pass" -> 1.0);
        // `0.7 < 0.5` is false (-> 0.0).
        assert_eq!(sampler.sample_compare(0.3, 1.0, 0.0, 0.0, 0.2, -1.0), 1.0);
        assert_eq!(sampler.sample_compare(0.7, 1.0, 0.0, 0.0, 0.2, -1.0), 0.0);
    }

    #[test]
    fn tex_parameteri_rejects_an_invalid_compare_mode_or_func_value() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_COMPARE_MODE, 0xBEEF);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_COMPARE_FUNC, 0xBEEF);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    #[test]
    fn uniform1i_on_a_non_int_non_sampler_uniform_is_invalid_operation() {
        let mut cx = ctx();
        let program = cx.create_shader_program(Box::new(ColorUniformShaderForUniform1iTest::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_color");
        assert!(loc >= 0);
        cx.uniform1i(loc, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn uniform1f_on_a_non_float_uniform_is_invalid_operation() {
        let mut cx = ctx();
        let program = cx.create_shader_program(Box::new(ColorUniformShaderForUniform1iTest::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_color");
        assert!(loc >= 0);
        cx.uniform1f(loc, 1.0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn uniform1f_sets_a_scalar_float_uniform() {
        let mut cx = ctx();
        let program = cx.create_shader_program(Box::new(ScaleUniformShaderForUniform1fTest::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_scale");
        assert!(loc >= 0);
        cx.uniform1f(loc, 2.5);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let program_obj = cx.programs.find(program).unwrap();
        let declared = program_obj.declared().unwrap();
        assert_eq!(declared.program_base().uniform_by_name("u_scale").value.as_f32(), 2.5);
    }

    /// A minimal scalar-`float`-uniform-only `ShaderProgram`, just for the two
    /// `uniform1f` tests above.
    struct ScaleUniformShaderForUniform1fTest {
        base: ShaderProgramBase,
    }

    impl ScaleUniformShaderForUniform1fTest {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_scale", DataType::Float))
                .vertex_source("void main(){gl_Position=vec4(0.0);}")
                .fragment_source("uniform mediump float u_scale;\nvoid main(){gl_FragColor=vec4(u_scale);}");
            Self {
                base: ShaderProgramBase::new(&decl),
            }
        }
    }

    impl VertexShader for ScaleUniformShaderForUniform1fTest {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(&self, _inputs: &[VertexAttrib], _packets: &mut [VertexPacket]) {}
    }

    impl FragmentShader for ScaleUniformShaderForUniform1fTest {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, _packets: &mut [FragmentPacket], _context: &FragmentShadingContext) {}
    }

    impl ShaderProgram for ScaleUniformShaderForUniform1fTest {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
    }

    /// A minimal `vec4`-uniform-only `ShaderProgram`, just for
    /// `uniform1i_on_a_non_int_non_sampler_uniform_is_invalid_operation` above - the
    /// full `ColorUniformShader` this file's `sglr::Context` tests use lives further
    /// down and pulls in `sglr::context`/`context_util`, which this section doesn't
    /// otherwise need.
    struct ColorUniformShaderForUniform1iTest {
        base: ShaderProgramBase,
    }

    impl ColorUniformShaderForUniform1iTest {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_color", DataType::FloatVec4))
                .vertex_source("void main(){gl_Position=vec4(0.0);}")
                .fragment_source("uniform mediump vec4 u_color;\nvoid main(){gl_FragColor=u_color;}");
            Self {
                base: ShaderProgramBase::new(&decl),
            }
        }
    }

    impl VertexShader for ColorUniformShaderForUniform1iTest {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(&self, _inputs: &[VertexAttrib], _packets: &mut [VertexPacket]) {}
    }

    impl FragmentShader for ColorUniformShaderForUniform1iTest {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, _packets: &mut [FragmentPacket], _context: &FragmentShadingContext) {}
    }

    impl ShaderProgram for ColorUniformShaderForUniform1iTest {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
    }

    /// A minimal multi-uniform `ShaderProgram`, just for the `uniform1fv`/`2fv`/`3fv`/
    /// `1iv`/`2iv`/`3iv`/`4iv` tests below - see `ColorUniformShaderForUniform1iTest`'s
    /// own doc comment above for why this stays a separate, narrow shader rather than
    /// reusing the full `ColorUniformShader` further down.
    struct MultiUniformsShader {
        base: ShaderProgramBase,
    }

    impl MultiUniformsShader {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_f1", DataType::Float))
                .uniform(pdec::Uniform::new("u_f2", DataType::FloatVec2))
                .uniform(pdec::Uniform::new("u_f3", DataType::FloatVec3))
                .uniform(pdec::Uniform::new("u_i1", DataType::Int))
                .uniform(pdec::Uniform::new("u_i2", DataType::IntVec2))
                .uniform(pdec::Uniform::new("u_i3", DataType::IntVec3))
                .uniform(pdec::Uniform::new("u_i4", DataType::IntVec4))
                .vertex_source("void main(){gl_Position=vec4(0.0);}")
                .fragment_source(
                    "uniform mediump float u_f1;\nuniform mediump vec2 u_f2;\nuniform mediump vec3 u_f3;\n\
                     uniform mediump int u_i1;\nuniform mediump ivec2 u_i2;\nuniform mediump ivec3 u_i3;\nuniform mediump ivec4 u_i4;\n\
                     void main(){gl_FragColor=vec4(u_f1)+vec4(u_f2,0.0,0.0)+vec4(u_f3,0.0)+vec4(float(u_i1))+vec4(vec2(u_i2),0.0,0.0)+vec4(vec3(u_i3),0.0)+vec4(u_i4);}",
                );
            Self {
                base: ShaderProgramBase::new(&decl),
            }
        }
    }

    impl VertexShader for MultiUniformsShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
        }
        fn shade_vertices(&self, _inputs: &[VertexAttrib], _packets: &mut [VertexPacket]) {}
    }

    impl FragmentShader for MultiUniformsShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, _packets: &mut [FragmentPacket], _context: &FragmentShadingContext) {}
    }

    impl ShaderProgram for MultiUniformsShader {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
    }

    /// Peeks at a declared program's own stored uniform value, bypassing
    /// `shade_fragments` (which is the only way a real draw ever reads it back) - valid
    /// here because `mod tests` is a descendant module of this whole file and so can
    /// see every private field/method `ReferenceContext`/`ProgramObject` have, the same
    /// way `uniform1i_resolves_a_sampler_uniform_to_the_bound_texture_at_draw_time`
    /// below already reaches into `ReferenceContext`'s own internals for its own
    /// assertions.
    fn uniform_value(cx: &mut ReferenceContext, program: u32, name: &str) -> UniformValue {
        let program_obj = cx.programs.find(program).expect("program must exist");
        let declared = program_obj.declared().expect("program must be declared");
        declared.program_base().uniform_by_name(name).value
    }

    #[test]
    fn uniform_fv_family_stores_scalar_and_vector_float_uniforms() {
        let mut cx = ctx();
        let program = cx.create_shader_program(Box::new(MultiUniformsShader::new()));
        cx.use_program(program);

        let loc1 = cx.get_uniform_location(program, "u_f1");
        let loc2 = cx.get_uniform_location(program, "u_f2");
        let loc3 = cx.get_uniform_location(program, "u_f3");
        assert!(loc1 >= 0 && loc2 >= 0 && loc3 >= 0);

        cx.uniform1fv(loc1, 1, &[3.5]);
        cx.uniform2fv(loc2, 1, &[1.0, 2.0]);
        cx.uniform3fv(loc3, 1, &[1.0, 2.0, 3.0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        assert_eq!(uniform_value(&mut cx, program, "u_f1"), UniformValue::F32(3.5));
        assert_eq!(
            uniform_value(&mut cx, program, "u_f2"),
            UniformValue::F32Vec2([1.0, 2.0])
        );
        assert_eq!(
            uniform_value(&mut cx, program, "u_f3"),
            UniformValue::F32Vec3([1.0, 2.0, 3.0])
        );
    }

    #[test]
    fn uniform_iv_family_stores_scalar_and_vector_int_uniforms() {
        let mut cx = ctx();
        let program = cx.create_shader_program(Box::new(MultiUniformsShader::new()));
        cx.use_program(program);

        let loc1 = cx.get_uniform_location(program, "u_i1");
        let loc2 = cx.get_uniform_location(program, "u_i2");
        let loc3 = cx.get_uniform_location(program, "u_i3");
        let loc4 = cx.get_uniform_location(program, "u_i4");
        assert!(loc1 >= 0 && loc2 >= 0 && loc3 >= 0 && loc4 >= 0);

        cx.uniform1iv(loc1, 1, &[7]);
        cx.uniform2iv(loc2, 1, &[1, 2]);
        cx.uniform3iv(loc3, 1, &[1, 2, 3]);
        cx.uniform4iv(loc4, 1, &[1, 2, 3, 4]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        assert_eq!(uniform_value(&mut cx, program, "u_i1"), UniformValue::I32(7));
        assert_eq!(uniform_value(&mut cx, program, "u_i2"), UniformValue::I32Vec2([1, 2]));
        assert_eq!(
            uniform_value(&mut cx, program, "u_i3"),
            UniformValue::I32Vec3([1, 2, 3])
        );
        assert_eq!(
            uniform_value(&mut cx, program, "u_i4"),
            UniformValue::I32Vec4([1, 2, 3, 4])
        );
    }

    #[test]
    fn uniform2fv_on_a_mismatched_type_is_invalid_operation() {
        let mut cx = ctx();
        let program = cx.create_shader_program(Box::new(MultiUniformsShader::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_f1"); // declared Float, not FloatVec2
        assert!(loc >= 0);
        cx.uniform2fv(loc, 1, &[1.0, 2.0]);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn uniform3iv_with_too_few_values_is_invalid_operation() {
        let mut cx = ctx();
        let program = cx.create_shader_program(Box::new(MultiUniformsShader::new()));
        cx.use_program(program);
        let loc = cx.get_uniform_location(program, "u_i3");
        assert!(loc >= 0);
        cx.uniform3iv(loc, 1, &[1, 2]); // only 2 values for an ivec3
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    fn make_quad_buffer(cx: &mut ReferenceContext) -> u32 {
        let mut names = [0u32];
        cx.gen_buffers(&mut names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, names[0]);
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [-10.0, -10.0, 0.0, 1.0],
            [10.0, -10.0, 0.0, 1.0],
            [0.0, 10.0, 0.0, 1.0],
        ];
        let bytes = unsafe {
            std::slice::from_raw_parts(
                position_data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(&position_data),
            )
        };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
        names[0]
    }

    #[test]
    fn draw_arrays_with_a_full_screen_triangle_fills_every_pixel() {
        let mut cx = ctx_with_size(4, 4);
        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(0.25, 0.5, 0.75, 1.0));
        let program = cx.create_program(Box::new(vs), Box::new(fs));
        cx.use_program(program);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let access = cx.color_buffer().get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let pixel = access.get_pixel(x, y, 0);
                assert!(
                    (pixel[0] - 0.25).abs() < 0.01 && (pixel[1] - 0.5).abs() < 0.01 && (pixel[2] - 0.75).abs() < 0.01,
                    "pixel ({x},{y}) = {pixel:?}"
                );
            }
        }
    }

    #[test]
    fn clear_then_draw_arrays_leaves_untouched_pixels_at_the_clear_color() {
        let mut cx = ctx_with_size(4, 4);
        cx.clear_color(1.0, 1.0, 1.0, 1.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        // A tiny triangle in the corner, leaving most pixels untouched.
        let mut names = [0u32];
        cx.gen_buffers(&mut names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, names[0]);
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [-1.0, -1.0, 0.0, 1.0],
            [-0.5, -1.0, 0.0, 1.0],
            [-1.0, -0.5, 0.0, 1.0],
        ];
        let bytes = unsafe {
            std::slice::from_raw_parts(
                position_data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(&position_data),
            )
        };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(0.0, 0.0, 0.0, 1.0));
        let program = cx.create_program(Box::new(vs), Box::new(fs));
        cx.use_program(program);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);

        let access = cx.color_buffer().get_const_access();
        // Top-right corner must still be the clear colour - the triangle only covers
        // the bottom-left.
        let pixel = access.get_pixel(3, 3, 0);
        assert!(
            pixel[0] > 0.9 && pixel[1] > 0.9 && pixel[2] > 0.9,
            "untouched pixel should be white, got {pixel:?}"
        );
    }

    #[test]
    fn clear_respects_the_color_mask() {
        let mut cx = ctx_with_size(2, 2);
        cx.clear_color(0.25, 0.5, 0.75, 1.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        // Mask off red and alpha, then clear to a different colour - only green/blue
        // may change.
        cx.color_mask(false, true, true, false);
        cx.clear_color(0.9, 0.1, 0.2, 0.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        let access = cx.color_buffer().get_const_access();
        let pixel = access.get_pixel(0, 0, 0);
        assert!(
            (pixel[0] - 0.25).abs() < 0.01,
            "red is masked off and must be unchanged, got {pixel:?}"
        );
        assert!(
            (pixel[1] - 0.1).abs() < 0.01,
            "green is unmasked and must have been overwritten, got {pixel:?}"
        );
        assert!(
            (pixel[2] - 0.2).abs() < 0.01,
            "blue is unmasked and must have been overwritten, got {pixel:?}"
        );
        assert!(
            (pixel[3] - 1.0).abs() < 0.01,
            "alpha is masked off and must be unchanged, got {pixel:?}"
        );
    }

    #[test]
    fn clear_is_confined_by_the_scissor_rectangle() {
        let mut cx = ctx_with_size(4, 4);
        cx.clear_color(1.0, 1.0, 1.0, 1.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        cx.enable(glw::GL_SCISSOR_TEST);
        cx.scissor(0, 0, 2, 2); // bottom-left 2x2 quadrant only
        cx.clear_color(0.0, 0.0, 0.0, 1.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        let access = cx.color_buffer().get_const_access();
        assert_eq!(
            access.get_pixel(0, 0, 0)[0],
            0.0,
            "inside the scissor rect must be cleared to black"
        );
        assert_eq!(
            access.get_pixel(1, 1, 0)[0],
            0.0,
            "inside the scissor rect must be cleared to black"
        );
        assert!(
            access.get_pixel(3, 3, 0)[0] > 0.9,
            "outside the scissor rect must keep the earlier clear colour"
        );
        assert!(
            access.get_pixel(2, 0, 0)[0] > 0.9,
            "outside the scissor rect (x=2) must keep the earlier clear colour"
        );
    }

    #[test]
    fn clear_buffer_iv_writes_raw_signed_values_into_an_integer_color_attachment() {
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rbs = [0u32];
        cx.gen_renderbuffers(&mut rbs);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA32I, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbs[0],
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        // Same values `execute_signed_value_write`'s own test (rr/fragment_operations.rs)
        // round-trips through `SIGNED_INT32`, reused here deliberately.
        cx.clear_buffer_iv(glw::GL_COLOR, 0, &[5, -3, 100, -7]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let rb = cx.renderbuffer(rbs[0]).unwrap();
        let pixel = rb.get_const_access().unwrap().get_pixel_int(2, 2, 0);
        assert_eq!(pixel, [5, -3, 100, -7]);
    }

    #[test]
    fn clear_buffer_uiv_writes_the_raw_unsigned_bit_pattern_into_an_integer_color_attachment() {
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rbs = [0u32];
        cx.gen_renderbuffers(&mut rbs);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA32UI, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbs[0],
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        // `0xFFFF_FFFE` has its high bit set, i.e. negative if misread as `i32` - the
        // same bit-reinterpretation case `execute_unsigned_value_write`'s own test
        // pins down on the fragment-write side.
        cx.clear_buffer_uiv(glw::GL_COLOR, 0, &[0xFFFF_FFFE, 1, 2, 3]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let rb = cx.renderbuffer(rbs[0]).unwrap();
        let pixel = rb.get_const_access().unwrap().get_pixel_uint64(1, 1, 0);
        assert_eq!(pixel, [0xFFFF_FFFE, 1, 2, 3]);
    }

    /// Unlike the two `clear_buffer_*` tests just above (which only ever exercise
    /// `clear`'s own path into an integer attachment), this drives a real
    /// `draw_arrays` call all the way through `draw_with_reference` ->
    /// `rr::Renderer::draw_instanced` -> `FragmentProcessor::render`'s integer
    /// colour-write branch - the end-to-end path `IntegerConstantFragmentShader`'s own
    /// doc comment describes. Same `[5, -3, 100, -7]` values `clear_buffer_iv`'s test
    /// and `execute_signed_value_write`'s own test (`rr/fragment_operations.rs`) both
    /// use, reused deliberately for consistency across all three layers this value now
    /// passes through unmodified.
    #[test]
    fn draw_arrays_writes_exact_signed_integer_values_into_an_integer_color_attachment() {
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rbs = [0u32];
        cx.gen_renderbuffers(&mut rbs);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA32I, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbs[0],
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let vs = PassthroughVertexShader::new();
        let fs = IntegerConstantFragmentShader::new_signed(IVec4::new(5, -3, 100, -7));
        let program = cx.create_program(Box::new(vs), Box::new(fs));
        cx.use_program(program);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let rb = cx.renderbuffer(rbs[0]).unwrap();
        let pixel = rb.get_const_access().unwrap().get_pixel_int(2, 2, 0);
        assert_eq!(
            pixel,
            [5, -3, 100, -7],
            "a real draw call must land exact integer values through the full GL state-machine path, not just clear_buffer_iv"
        );
    }

    /// Same shape as the signed test just above, over the unsigned path and reusing
    /// `0xFFFF_FFFE`'s high-bit-set value for the same reason
    /// `clear_buffer_uiv`'s own test does.
    #[test]
    fn draw_arrays_writes_the_raw_unsigned_bit_pattern_into_an_integer_color_attachment() {
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rbs = [0u32];
        cx.gen_renderbuffers(&mut rbs);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA32UI, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbs[0],
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let vs = PassthroughVertexShader::new();
        let fs = IntegerConstantFragmentShader::new_unsigned(UVec4::new(0xFFFF_FFFE, 1, 2, 3));
        let program = cx.create_program(Box::new(vs), Box::new(fs));
        cx.use_program(program);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let rb = cx.renderbuffer(rbs[0]).unwrap();
        let pixel = rb.get_const_access().unwrap().get_pixel_uint64(1, 1, 0);
        assert_eq!(pixel, [0xFFFF_FFFE, 1, 2, 3]);
    }

    #[test]
    fn clear_buffer_fi_writes_both_depth_and_stencil_of_a_combined_attachment_in_one_call() {
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rbs = [0u32, 0u32];
        cx.gen_renderbuffers(&mut rbs);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbs[0],
        );

        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[1]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbs[1],
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        cx.clear_buffer_fi(glw::GL_DEPTH_STENCIL, 0, 0.2, 7);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let rb = cx.renderbuffer(rbs[1]).unwrap();
        let access = rb.get_const_access().unwrap();
        assert!(
            (access.get_pix_depth(1, 1, 0) - 0.2).abs() < 0.001,
            "depth must round-trip through the combined attachment, got {}",
            access.get_pix_depth(1, 1, 0)
        );
        assert_eq!(
            access.get_pix_stencil(1, 1, 0),
            7,
            "stencil must round-trip through the combined attachment"
        );
    }

    #[test]
    fn draw_elements_with_a_u16_index_buffer_covers_a_quad() {
        let mut cx = ctx_with_size(4, 4);

        let mut vbo = [0u32];
        cx.gen_buffers(&mut vbo);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, vbo[0]);
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 4] = [
            [-10.0, -10.0, 0.0, 1.0],
            [10.0, -10.0, 0.0, 1.0],
            [-10.0, 10.0, 0.0, 1.0],
            [10.0, 10.0, 0.0, 1.0],
        ];
        let vertex_bytes = unsafe {
            std::slice::from_raw_parts(
                position_data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(&position_data),
            )
        };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, vertex_bytes.len() as isize, Some(vertex_bytes));
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let mut ebo = [0u32];
        cx.gen_buffers(&mut ebo);
        cx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ebo[0]);
        let indices: [u16; 4] = [3, 2, 1, 0]; // reversed, to prove indices are honoured
        let index_bytes =
            unsafe { std::slice::from_raw_parts(indices.as_ptr().cast::<u8>(), std::mem::size_of_val(&indices)) };
        cx.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            index_bytes.len() as isize,
            Some(index_bytes),
        );

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0));
        let program = cx.create_program(Box::new(vs), Box::new(fs));
        cx.use_program(program);

        cx.draw_elements(glw::GL_TRIANGLE_STRIP, 4, glw::GL_UNSIGNED_SHORT, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let access = cx.color_buffer().get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let pixel = access.get_pixel(x, y, 0);
                assert!(pixel[0] > 0.9, "pixel ({x},{y}) = {pixel:?}, expected white");
            }
        }
    }

    #[test]
    fn draw_arrays_with_no_program_bound_draws_nothing_and_reports_no_error() {
        let mut cx = ctx_with_size(4, 4);
        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(
            cx.get_error(),
            glw::GL_NO_ERROR,
            "undefined results, but never an error, matches upstream"
        );
    }

    #[test]
    fn draw_arrays_with_an_invalid_mode_sets_invalid_enum() {
        let mut cx = ctx();
        cx.draw_arrays(0xDEAD, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    // --- Fixed-function-adjacent state, exercised through a real draw ---

    #[test]
    fn scissor_test_confines_drawing_to_the_scissor_rectangle() {
        let mut cx = ctx_with_size(4, 4);
        cx.clear_color(1.0, 1.0, 1.0, 1.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        cx.enable(glw::GL_SCISSOR_TEST);
        cx.scissor(0, 0, 2, 2); // only the bottom-left 2x2 quadrant

        make_quad_buffer(&mut cx); // a big triangle covering the whole viewport
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let vs = PassthroughVertexShader::new();
        let fs = ConstantColorFragmentShader::new(Vec4::new(0.0, 0.0, 0.0, 1.0));
        let program = cx.create_program(Box::new(vs), Box::new(fs));
        cx.use_program(program);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);

        let access = cx.color_buffer().get_const_access();
        assert_eq!(
            access.get_pixel(0, 0, 0)[0],
            0.0,
            "inside the scissor rect must be drawn"
        );
        assert!(
            access.get_pixel(3, 3, 0)[0] > 0.9,
            "outside the scissor rect must stay the clear colour"
        );
    }

    #[test]
    fn depth_test_rejects_a_fragment_behind_what_is_already_there() {
        let mut cx = ctx_with_depth(4, 4);
        // `clear` always clears depth to 1.0 (farthest) - see this module's own doc
        // comment on `clear` for why there is no settable clear-depth value yet.
        cx.clear(glw::GL_DEPTH_BUFFER_BIT);
        cx.enable(glw::GL_DEPTH_TEST);
        cx.depth_func(glw::GL_LESS);

        let vs_factory = || PassthroughVertexShader::new();

        // Draw a near quad (z = -0.5) in white first.
        {
            let mut vbo = [0u32];
            cx.gen_buffers(&mut vbo);
            cx.bind_buffer(glw::GL_ARRAY_BUFFER, vbo[0]);
            #[rustfmt::skip]
            let near: [[f32; 4]; 3] = [[-10.0, -10.0, -0.5, 1.0], [10.0, -10.0, -0.5, 1.0], [0.0, 10.0, -0.5, 1.0]];
            let bytes = unsafe { std::slice::from_raw_parts(near.as_ptr().cast::<u8>(), std::mem::size_of_val(&near)) };
            cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
            cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
            cx.enable_vertex_attrib_array(0);

            let program = cx.create_program(
                Box::new(vs_factory()),
                Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0))),
            );
            cx.use_program(program);
            cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        }

        // Then draw a far quad (z = 0.5) in black over the same pixels - must be
        // rejected by the depth test and leave the near quad's white untouched.
        {
            let mut vbo = [0u32];
            cx.gen_buffers(&mut vbo);
            cx.bind_buffer(glw::GL_ARRAY_BUFFER, vbo[0]);
            #[rustfmt::skip]
            let far: [[f32; 4]; 3] = [[-10.0, -10.0, 0.5, 1.0], [10.0, -10.0, 0.5, 1.0], [0.0, 10.0, 0.5, 1.0]];
            let bytes = unsafe { std::slice::from_raw_parts(far.as_ptr().cast::<u8>(), std::mem::size_of_val(&far)) };
            cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
            cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);

            let program = cx.create_program(
                Box::new(vs_factory()),
                Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 0.0, 0.0, 1.0))),
            );
            cx.use_program(program);
            cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        }

        let access = cx.color_buffer().get_const_access();
        let pixel = access.get_pixel(2, 2, 0);
        assert!(
            pixel[0] > 0.9,
            "the farther black quad must have been rejected by the depth test, got {pixel:?}"
        );
    }

    #[test]
    fn blend_mixes_source_and_destination_colors() {
        let mut cx = ctx_with_size(4, 4);
        cx.clear_color(1.0, 1.0, 1.0, 1.0); // white background
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        cx.enable(glw::GL_BLEND);
        cx.blend_func(glw::GL_SRC_ALPHA, glw::GL_ONE_MINUS_SRC_ALPHA);

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        // Source colour (0,0,0, alpha=0.5) blended over white background should land
        // on mid-grey (0.5, 0.5, 0.5).
        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 0.0, 0.0, 0.5))),
        );
        cx.use_program(program);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);

        let access = cx.color_buffer().get_const_access();
        let pixel = access.get_pixel(2, 2, 0);
        assert!(
            (pixel[0] - 0.5).abs() < 0.05,
            "expected mid-grey from 50% blend over white, got {pixel:?}"
        );
    }

    /// `Context::blend_func`/`Context::finish`, reached through `&mut dyn Context` -
    /// the trait methods `clipping.*` needs
    /// (`glsClippingTests.cpp`'s own `ctx.blendFunc(GL_ONE, GL_ONE)`/`ctx.finish()`).
    /// `blend_mixes_source_and_destination_colors` above already proves the inherent
    /// `ReferenceContext::blend_func` method itself is correct; this proves the trait
    /// dispatch reaches it (same 50%-over-white mid-grey scenario) and that `finish()`
    /// is callable through the trait without upsetting the error state.
    #[test]
    fn context_trait_blend_func_and_finish_match_the_inherent_methods() {
        let mut cx = ctx_with_size(4, 4);
        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.clear_color(1.0, 1.0, 1.0, 1.0);
            ctx.clear(glw::GL_COLOR_BUFFER_BIT);
            ctx.enable(glw::GL_BLEND);
            ctx.blend_func(glw::GL_SRC_ALPHA, glw::GL_ONE_MINUS_SRC_ALPHA);
        }

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);
        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 0.0, 0.0, 0.5))),
        );
        cx.use_program(program);

        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
            ctx.finish();
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }

        let access = cx.color_buffer().get_const_access();
        let pixel = access.get_pixel(2, 2, 0);
        assert!(
            (pixel[0] - 0.5).abs() < 0.05,
            "expected mid-grey from 50% blend over white, got {pixel:?}"
        );
    }

    /// `Context::line_width`, reached through `&mut dyn Context` - a wider
    /// `GL_LINES` segment must rasterize into more rows than a narrower one at the
    /// same position, proving the trait setter actually reaches
    /// `rr::RenderState::line.line_width` (`reference_context.rs`'s own
    /// `draw_with_reference` wires `self.line_width` there) rather than just being
    /// stored and ignored.
    fn colored_rows_in_a_horizontal_line(width: f32) -> usize {
        let mut cx = ctx_with_size(8, 8);
        cx.clear_color(1.0, 1.0, 1.0, 1.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        let mut names = [0u32];
        cx.gen_buffers(&mut names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, names[0]);
        let position_data: [[f32; 4]; 2] = [[-1.0, 0.0, 0.0, 1.0], [1.0, 0.0, 0.0, 1.0]];
        let bytes = unsafe {
            std::slice::from_raw_parts(
                position_data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(&position_data),
            )
        };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 0.0, 0.0, 1.0))),
        );
        cx.use_program(program);

        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.line_width(width);
            ctx.draw_arrays(glw::GL_LINES, 0, 2);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }

        let access = cx.color_buffer().get_const_access();
        (0..8).filter(|&y| access.get_pixel(4, y, 0)[0] < 0.5).count()
    }

    #[test]
    fn context_trait_line_width_widens_a_rasterized_line() {
        let narrow = colored_rows_in_a_horizontal_line(1.0);
        let wide = colored_rows_in_a_horizontal_line(5.0);
        assert!(
            wide > narrow,
            "a wider line must cover more rows than a narrower one at the same position: narrow={narrow}, wide={wide}"
        );
    }

    /// `vertex_attrib_divisor`/`draw_arrays_instanced` through `&mut dyn Context` -
    /// the trait methods `draw.*` needs
    /// (`glsDrawTest.cpp`'s `AttributeArray` instanced-attribute setup). Deliberately
    /// geometry-independent: both instances draw the exact same full-screen triangle
    /// `draw_arrays_with_a_full_screen_triangle_fills_every_pixel` already proves
    /// covers every pixel (no small-triangle/pixel-boundary edge case to get wrong), so
    /// the only thing under test is whether a per-*instance* `a_color` attribute
    /// (`divisor=1`), carried through as a flatshaded varying, reads *instance 1's* own
    /// colour for every one of its three vertices. A divisor of `0` (ignored) would
    /// instead index `a_color` by `vertex_ndx` (0, 1, 2) into a 2-element buffer,
    /// reading out of bounds on the third vertex and producing a wrong/UB-derived
    /// colour instead of the flat green this test demands everywhere on screen - this
    /// is what first exercises `vertex_attrib_divisor` at all, inherent or trait,
    /// nothing used it before (confirmed by grep, no prior test in this file touches
    /// it).
    struct InstancedColorVertexShader {
        inputs: Vec<VertexInputInfo>,
        outputs: Vec<VertexOutputInfo>,
    }

    impl InstancedColorVertexShader {
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
                outputs: vec![VertexOutputInfo {
                    type_: Some(GenericVecType::Float),
                    flatshade: true,
                }],
            }
        }
    }

    impl VertexShader for InstancedColorVertexShader {
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

                let mut color = Vec4::splat(0.0);
                unsafe { read_vertex_attrib_float(&mut color, &inputs[1], packet.instance_ndx, packet.vertex_ndx, 0) };
                packet.outputs[0] = GenericVec4::from_float(color);
            }
        }
    }

    /// Writes its one flatshaded varying straight through as the fragment colour -
    /// the counterpart `InstancedColorVertexShader` above needs to make the
    /// per-instance `a_color` attribute observable in the final image.
    struct FlatVaryingFragmentShader {
        inputs: Vec<FragmentInputInfo>,
        outputs: Vec<FragmentOutputInfo>,
    }

    impl FlatVaryingFragmentShader {
        fn new() -> Self {
            Self {
                inputs: vec![FragmentInputInfo {
                    type_: Some(GenericVecType::Float),
                    flatshade: true,
                }],
                outputs: vec![FragmentOutputInfo {
                    type_: Some(GenericVecType::Float),
                }],
            }
        }
    }

    impl FragmentShader for FlatVaryingFragmentShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            &self.inputs
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            &self.outputs
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            for (packet_ndx, packet) in packets.iter().enumerate() {
                for frag_ndx in 0..4 {
                    let color = unsafe { read_varying(packet, context, 0, frag_ndx as usize) };
                    unsafe {
                        write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, GenericVec4::from_float(color))
                    };
                }
            }
        }
    }

    #[test]
    fn vertex_attrib_divisor_and_draw_arrays_instanced_pick_the_last_instances_own_color() {
        let mut cx = ctx_with_size(4, 4);
        cx.clear_color(1.0, 1.0, 1.0, 1.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let mut color_names = [0u32];
        cx.gen_buffers(&mut color_names);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, color_names[0]);
        let color_data: [[f32; 4]; 2] = [[1.0, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0]];
        let bytes =
            unsafe { std::slice::from_raw_parts(color_data.as_ptr().cast::<u8>(), std::mem::size_of_val(&color_data)) };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
        cx.vertex_attrib_pointer(1, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(1);

        let program = cx.create_program(
            Box::new(InstancedColorVertexShader::new()),
            Box::new(FlatVaryingFragmentShader::new()),
        );
        cx.use_program(program);

        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.vertex_attrib_divisor(1, 1);
            ctx.draw_arrays_instanced(glw::GL_TRIANGLES, 0, 3, 2);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }

        let access = cx.color_buffer().get_const_access();
        let pixel = access.get_pixel(2, 2, 0);
        assert_eq!(
            pixel,
            [0.0, 1.0, 0.0, 1.0],
            "the final on-screen colour must be instance 1's own green - it only comes out right if vertex_attrib_divisor made every one of its 3 vertices read color_data[1] instead of walking off the end of a 2-element buffer by vertex index"
        );
    }

    /// A freshly constructed `ReferenceContext` must start every attribute's current
    /// generic value at GL's own default `(0, 0, 0, 1)` - `ReferenceContext::new`'s own
    /// initializer, confirmed directly rather than only through a draw.
    #[test]
    fn current_attrib_defaults_to_0_0_0_1_before_any_setter_runs() {
        let cx = ctx();
        assert_eq!(cx.current_attrib(0).get_float(), Vec4::new(0.0, 0.0, 0.0, 1.0));
    }

    #[test]
    fn vertex_attrib1f_sets_x_and_leaves_y_z_at_0_and_w_at_1() {
        let mut cx = ctx();
        cx.vertex_attrib1f(2, 7.0);
        assert_eq!(cx.current_attrib(2).get_float(), Vec4::new(7.0, 0.0, 0.0, 1.0));
    }

    #[test]
    fn vertex_attrib2f_sets_x_y_and_leaves_z_at_0_and_w_at_1() {
        let mut cx = ctx();
        cx.vertex_attrib2f(2, 7.0, 8.0);
        assert_eq!(cx.current_attrib(2).get_float(), Vec4::new(7.0, 8.0, 0.0, 1.0));
    }

    #[test]
    fn vertex_attrib3f_sets_x_y_z_and_leaves_w_at_1() {
        let mut cx = ctx();
        cx.vertex_attrib3f(2, 7.0, 8.0, 9.0);
        assert_eq!(cx.current_attrib(2).get_float(), Vec4::new(7.0, 8.0, 9.0, 1.0));
    }

    #[test]
    fn vertex_attrib4f_sets_all_four_components() {
        let mut cx = ctx();
        cx.vertex_attrib4f(2, 7.0, 8.0, 9.0, 10.0);
        assert_eq!(cx.current_attrib(2).get_float(), Vec4::new(7.0, 8.0, 9.0, 10.0));
    }

    #[test]
    fn vertex_attrib_i4i_sets_all_four_components_as_signed_integers() {
        let mut cx = ctx();
        cx.vertex_attrib_i4i(2, -7, 8, -9, 10);
        assert_eq!(cx.current_attrib(2).get_int(), IVec4::new(-7, 8, -9, 10));
    }

    #[test]
    fn vertex_attrib_i4ui_sets_all_four_components_as_unsigned_integers() {
        let mut cx = ctx();
        cx.vertex_attrib_i4ui(2, 7, 8, 9, 10);
        assert_eq!(cx.current_attrib(2).get_uint(), UVec4::new(7, 8, 9, 10));
    }

    /// `index >= GL_MAX_VERTEX_ATTRIBS` is `GL_INVALID_VALUE` for every one of the six
    /// setters - `vertex_attrib4f` stands in for all of them, since every one of
    /// `vertex_attrib{1,2,3,4}f`/`vertex_attrib_i4{i,ui}` runs the identical bounds
    /// check `RC_IF_ERROR(index >= m_limits.maxVertexAttribs, GL_INVALID_VALUE, ...)`
    /// upstream states once per method.
    #[test]
    fn vertex_attrib4f_with_index_past_max_vertex_attribs_is_invalid_value() {
        let mut cx = ctx();
        cx.vertex_attrib4f(16, 1.0, 2.0, 3.0, 4.0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    /// `vertexAttrib4f` set on a *disabled* attribute array must be what a draw call
    /// reads for it - `build_vertex_attribs`' own `current_attribs[ndx]` read, the gap
    /// this port's own doc comment used to call out explicitly ("always `(0,0,0,1)`
    /// here"). Attribute 1 (the shader's `a_color` input) is left disabled for the
    /// whole draw; only `vertex_attrib4f` ever touches it.
    #[test]
    fn a_disabled_attributes_current_value_set_by_vertex_attrib4f_reaches_the_rasterized_pixel() {
        let mut cx = ctx_with_size(4, 4);
        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.vertex_attrib4f(1, 0.25, 0.5, 0.75, 1.0);
        }

        let program = cx.create_program(
            Box::new(InstancedColorVertexShader::new()),
            Box::new(FlatVaryingFragmentShader::new()),
        );
        cx.use_program(program);

        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }

        let access = cx.color_buffer().get_const_access();
        let pixel = access.get_pixel(2, 2, 0);
        // The default framebuffer is RGBA8, so the written value is rounded to the
        // nearest /255 level (0.25 -> 64/255 = 0.2509804, not exactly 0.25) - compare
        // with the same tolerance every other RGBA8 pixel assertion in this file uses.
        assert!(
            (pixel[0] - 0.25).abs() < 0.01
                && (pixel[1] - 0.5).abs() < 0.01
                && (pixel[2] - 0.75).abs() < 0.01
                && (pixel[3] - 1.0).abs() < 0.01,
            "a disabled attribute array must read the current generic value vertex_attrib4f set, not GL's own hardcoded (0,0,0,1) default: got {pixel:?}"
        );
    }

    /// `draw_elements_instanced`/`draw_elements_instanced_base_vertex`/
    /// `draw_range_elements`/`draw_range_elements_base_vertex` through `&mut dyn
    /// Context` - the remaining `draw.*`-motivated trait methods,
    /// smoke-tested the same way `draw_arrays_with_a_full_screen_triangle_fills_every_
    /// pixel` already proves `draw_arrays`: a full-screen triangle must still fill
    /// every pixel through each of these four entry points.
    #[test]
    fn draw_elements_instanced_variants_and_draw_range_elements_through_the_context_trait_fill_every_pixel() {
        fn indexed_full_screen_triangle() -> ReferenceContext {
            let mut cx = ctx_with_size(4, 4);
            make_quad_buffer(&mut cx);
            cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
            cx.enable_vertex_attrib_array(0);

            let mut index_names = [0u32];
            cx.gen_buffers(&mut index_names);
            cx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_names[0]);
            let indices: [u16; 3] = [0, 1, 2];
            let bytes =
                unsafe { std::slice::from_raw_parts(indices.as_ptr().cast::<u8>(), std::mem::size_of_val(&indices)) };
            cx.buffer_data(glw::GL_ELEMENT_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));

            let program = cx.create_program(
                Box::new(PassthroughVertexShader::new()),
                Box::new(ConstantColorFragmentShader::new(Vec4::new(0.25, 0.5, 0.75, 1.0))),
            );
            cx.use_program(program);
            cx
        }

        fn assert_fully_covered(cx: &ReferenceContext) {
            let access = cx.color_buffer().get_const_access();
            for y in 0..4 {
                for x in 0..4 {
                    let pixel = access.get_pixel(x, y, 0);
                    assert!((pixel[0] - 0.25).abs() < 0.01, "pixel ({x},{y}) = {pixel:?}");
                }
            }
        }

        let mut cx = indexed_full_screen_triangle();
        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.draw_elements_instanced(glw::GL_TRIANGLES, 3, glw::GL_UNSIGNED_SHORT, 0, 1);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }
        assert_fully_covered(&cx);

        let mut cx = indexed_full_screen_triangle();
        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.draw_elements_instanced_base_vertex(glw::GL_TRIANGLES, 3, glw::GL_UNSIGNED_SHORT, 0, 1, 0);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }
        assert_fully_covered(&cx);

        let mut cx = indexed_full_screen_triangle();
        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.draw_range_elements(glw::GL_TRIANGLES, 0, 2, 3, glw::GL_UNSIGNED_SHORT, 0);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }
        assert_fully_covered(&cx);

        let mut cx = indexed_full_screen_triangle();
        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.draw_range_elements_base_vertex(glw::GL_TRIANGLES, 0, 2, 3, glw::GL_UNSIGNED_SHORT, 0, 0);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }
        assert_fully_covered(&cx);
    }

    /// Writes a `DrawArraysIndirectCommand` (`count`, `prim_count`, `first`,
    /// `reserved_must_be_zero` - four `u32`s, upstream's own field order) into a
    /// freshly bound `GL_DRAW_INDIRECT_BUFFER` at `offset`.
    fn put_draw_arrays_indirect_command(
        cx: &mut ReferenceContext,
        offset: usize,
        count: u32,
        prim_count: u32,
        first: u32,
        reserved_must_be_zero: u32,
    ) -> u32 {
        let mut names = [0u32];
        cx.gen_buffers(&mut names);
        cx.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, names[0]);
        let mut bytes = vec![0u8; offset + 16];
        bytes[offset..offset + 4].copy_from_slice(&count.to_ne_bytes());
        bytes[offset + 4..offset + 8].copy_from_slice(&prim_count.to_ne_bytes());
        bytes[offset + 8..offset + 12].copy_from_slice(&first.to_ne_bytes());
        bytes[offset + 12..offset + 16].copy_from_slice(&reserved_must_be_zero.to_ne_bytes());
        cx.buffer_data(glw::GL_DRAW_INDIRECT_BUFFER, bytes.len() as isize, Some(&bytes));
        names[0]
    }

    /// `draw_arrays_indirect` through `&mut dyn Context` - needed by `draw.*`
    /// (see `context.rs`'s own doc comment).
    /// A full-screen triangle (the same proven-robust shape every other smoke test in
    /// this file uses) drawn via a command read entirely out of a bound
    /// `GL_DRAW_INDIRECT_BUFFER` must still cover every pixel, confirming the command
    /// decode (`count`/`first`/`prim_count`) and the forward to `draw_arrays_instanced`
    /// are both correct.
    #[test]
    fn draw_arrays_indirect_through_the_context_trait_fills_every_pixel() {
        let mut cx = ctx_with_size(4, 4);
        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);
        put_draw_arrays_indirect_command(&mut cx, 0, 3, 1, 0, 0);

        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.25, 0.5, 0.75, 1.0))),
        );
        cx.use_program(program);

        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.draw_arrays_indirect(glw::GL_TRIANGLES, 0);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }

        let access = cx.color_buffer().get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let pixel = access.get_pixel(x, y, 0);
                assert!((pixel[0] - 0.25).abs() < 0.01, "pixel ({x},{y}) = {pixel:?}");
            }
        }
    }

    #[test]
    fn draw_arrays_indirect_with_no_bound_indirect_buffer_is_invalid_operation() {
        let mut cx = ctx();
        cx.draw_arrays_indirect(glw::GL_TRIANGLES, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn draw_arrays_indirect_with_a_nonzero_reserved_field_is_invalid_operation() {
        let mut cx = ctx();
        put_draw_arrays_indirect_command(&mut cx, 0, 3, 1, 0, 1);
        cx.draw_arrays_indirect(glw::GL_TRIANGLES, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn draw_arrays_indirect_past_the_buffers_end_is_invalid_operation() {
        let mut cx = ctx();
        // Only 4 bytes committed where a whole 16-byte command is required.
        let names = put_draw_arrays_indirect_command(&mut cx, 0, 3, 1, 0, 0);
        cx.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, names);
        cx.buffer_data(glw::GL_DRAW_INDIRECT_BUFFER, 4, Some(&[0u8; 4]));
        cx.draw_arrays_indirect(glw::GL_TRIANGLES, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    /// `draw_elements_indirect` through `&mut dyn Context` - the `drawElementsIndirect`
    /// counterpart of the `draw_arrays_indirect` test above, over the same indexed
    /// full-screen triangle `draw_elements_instanced_variants_...` already uses.
    #[test]
    fn draw_elements_indirect_through_the_context_trait_fills_every_pixel() {
        let mut cx = ctx_with_size(4, 4);
        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let mut index_names = [0u32];
        cx.gen_buffers(&mut index_names);
        cx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, index_names[0]);
        let indices: [u16; 3] = [0, 1, 2];
        let bytes =
            unsafe { std::slice::from_raw_parts(indices.as_ptr().cast::<u8>(), std::mem::size_of_val(&indices)) };
        cx.buffer_data(glw::GL_ELEMENT_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));

        let mut indirect_names = [0u32];
        cx.gen_buffers(&mut indirect_names);
        cx.bind_buffer(glw::GL_DRAW_INDIRECT_BUFFER, indirect_names[0]);
        #[rustfmt::skip]
        let command: [u32; 5] = [
            3, // count
            1, // prim_count
            0, // first_index
            0, // base_vertex (as u32 bit pattern, 0 either way)
            0, // reserved_must_be_zero
        ];
        let command_bytes =
            unsafe { std::slice::from_raw_parts(command.as_ptr().cast::<u8>(), std::mem::size_of_val(&command)) };
        cx.buffer_data(
            glw::GL_DRAW_INDIRECT_BUFFER,
            command_bytes.len() as isize,
            Some(command_bytes),
        );

        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.25, 0.5, 0.75, 1.0))),
        );
        cx.use_program(program);

        {
            let ctx: &mut dyn Context = &mut cx;
            ctx.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_SHORT, 0);
            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
        }

        let access = cx.color_buffer().get_const_access();
        for y in 0..4 {
            for x in 0..4 {
                let pixel = access.get_pixel(x, y, 0);
                assert!((pixel[0] - 0.25).abs() < 0.01, "pixel ({x},{y}) = {pixel:?}");
            }
        }
    }

    #[test]
    fn draw_elements_indirect_with_no_bound_element_array_buffer_is_invalid_operation() {
        let mut cx = ctx();
        put_draw_arrays_indirect_command(&mut cx, 0, 3, 1, 0, 0);
        cx.draw_elements_indirect(glw::GL_TRIANGLES, glw::GL_UNSIGNED_SHORT, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn draw_range_elements_with_end_before_start_is_invalid_value() {
        let mut cx = ctx();
        cx.draw_range_elements(glw::GL_TRIANGLES, 5, 2, 3, glw::GL_UNSIGNED_SHORT, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    #[test]
    fn draw_range_elements_otherwise_behaves_like_draw_elements() {
        let mut cx = ctx_with_size(4, 4);
        let mut vbo = [0u32];
        cx.gen_buffers(&mut vbo);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, vbo[0]);
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [[-10.0, -10.0, 0.0, 1.0], [10.0, -10.0, 0.0, 1.0], [0.0, 10.0, 0.0, 1.0]];
        let vertex_bytes = unsafe {
            std::slice::from_raw_parts(
                position_data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(&position_data),
            )
        };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, vertex_bytes.len() as isize, Some(vertex_bytes));
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let mut ebo = [0u32];
        cx.gen_buffers(&mut ebo);
        cx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ebo[0]);
        let indices: [u16; 3] = [0, 1, 2];
        let index_bytes =
            unsafe { std::slice::from_raw_parts(indices.as_ptr().cast::<u8>(), std::mem::size_of_val(&indices)) };
        cx.buffer_data(
            glw::GL_ELEMENT_ARRAY_BUFFER,
            index_bytes.len() as isize,
            Some(index_bytes),
        );

        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0))),
        );
        cx.use_program(program);

        cx.draw_range_elements(glw::GL_TRIANGLES, 0, 2, 3, glw::GL_UNSIGNED_SHORT, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let access = cx.color_buffer().get_const_access();
        assert_eq!(access.get_pixel(1, 1, 0)[0], 1.0);
    }

    /// `GL_PRIMITIVE_RESTART_FIXED_INDEX` actually splitting a `GL_TRIANGLES` draw's
    /// index stream, through the full `enable`/`draw_elements` path (not a direct
    /// `rr::RestartState` construction) - the gap this port's own top doc comment used
    /// to call out ("tracked but not yet wired into `state.restart`").
    ///
    /// A `GL_UNSIGNED_BYTE` index buffer makes the fixed restart value `0xFF` (255);
    /// the position buffer is sized to 256 vertices precisely so that *even if restart
    /// were silently ignored*, reading index 255 as an ordinary vertex stays in-bounds
    /// (it reuses one of the covering triangle's own corners) rather than reading
    /// uninitialized memory through `rr::VertexAttrib`'s raw pointer - this test's only
    /// failure mode if the wiring is wrong is the pixel value it actually asserts on,
    /// never an out-of-bounds read.
    #[test]
    fn primitive_restart_fixed_index_splits_an_otherwise_continuous_triangle_run() {
        let mut cx = ctx_with_size(4, 4);
        cx.clear_color(0.0, 0.0, 0.0, 1.0);
        cx.clear(glw::GL_COLOR_BUFFER_BIT);

        let mut vbo = [0u32];
        cx.gen_buffers(&mut vbo);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, vbo[0]);
        let mut position_data = [[0.0f32; 4]; 256];
        // A single triangle big enough to cover the whole 4x4 viewport - the same
        // shape `make_quad_buffer` uses.
        position_data[0] = [-10.0, -10.0, 0.0, 1.0];
        position_data[1] = [10.0, -10.0, 0.0, 1.0];
        position_data[2] = [0.0, 10.0, 0.0, 1.0];
        // Reused on purpose - see this test's own doc comment on why index 255 must
        // stay a harmless in-bounds read regardless of the outcome being checked.
        position_data[255] = position_data[2];
        let bytes = unsafe {
            std::slice::from_raw_parts(
                position_data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(&position_data),
            )
        };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let mut ebo = [0u32];
        cx.gen_buffers(&mut ebo);
        cx.bind_buffer(glw::GL_ELEMENT_ARRAY_BUFFER, ebo[0]);
        // With the restart marker recognised this is two segments: [0, 1, 2] (one
        // full triangle) and, after skipping the marker, [0, 1] (only 2 elements -
        // not enough to assemble a second GL_TRIANGLES triangle). Without it, the
        // whole 6-element run assembles into two: (0,1,2) and (255,0,1).
        let indices: [u8; 6] = [0, 1, 2, 0xFF, 0, 1];
        cx.buffer_data(glw::GL_ELEMENT_ARRAY_BUFFER, indices.len() as isize, Some(&indices));

        cx.enable(glw::GL_PRIMITIVE_RESTART_FIXED_INDEX);
        cx.enable(glw::GL_BLEND);
        cx.blend_func(glw::GL_ONE, glw::GL_ONE);

        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.1, 0.1, 0.1, 1.0))),
        );
        cx.use_program(program);

        cx.draw_elements(glw::GL_TRIANGLES, 6, glw::GL_UNSIGNED_BYTE, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let access = cx.color_buffer().get_const_access();
        let pixel = access.get_pixel(2, 2, 0);
        assert!(
            (pixel[0] - 0.1).abs() < 0.02,
            "exactly one triangle must have been drawn (the restart-terminated [0,1,2] segment) - pixel={pixel:?}; two un-split triangles would additively blend to ~0.2, which is what an ignored restart marker looks like"
        );
    }

    // --- Texture objects ---

    #[test]
    fn gen_textures_and_bind_round_trips() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        assert!(
            cx.texture(names[0]).is_none(),
            "gen alone must not create the object - only bind does, lazily"
        );
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        assert!(cx.texture(names[0]).is_some());
    }

    #[test]
    fn bind_texture_with_an_unsupported_target_is_invalid_enum() {
        // GL_TEXTURE_1D has no backing object type here at all (see this module's top
        // doc comment) - unlike GL_TEXTURE_CUBE_MAP, which is now a valid target (see
        // the tests below).
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_1D, names[0]);
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn gen_textures_and_bind_cube_map_round_trips() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        assert!(cx.texture_cube(names[0]).is_none());
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_cube(names[0]).is_some());
        // A cube-map name must not also read back as a Texture2D.
        assert!(cx.texture(names[0]).is_none());
    }

    #[test]
    fn binding_a_name_to_a_different_target_than_its_first_bind_is_invalid_operation() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        // The same name was already fixed to GL_TEXTURE_2D by the bind above - trying
        // to also bind it as a cube map must fail, matching real GL's "name already has
        // a different target" rule (`TextureObject`'s own doc comment).
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
        // And the object must still be exactly what it was before the failed rebind.
        assert!(cx.texture(names[0]).is_some());
        assert!(cx.texture_cube(names[0]).is_none());
    }

    #[test]
    fn tex_image_2d_without_a_bound_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn tex_image_2d_uploads_pixel_data_exactly() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        // 2x1 RGBA8: red pixel, then green pixel.
        let data: [u8; 8] = [255, 0, 0, 255, 0, 255, 0, 255];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture(names[0]).unwrap();
        let level0 = tex.level(0).unwrap();
        let access = level0.get_const_access();
        assert_eq!(access.get_pixel(0, 0, 0), [1.0, 0.0, 0.0, 1.0]);
        assert_eq!(access.get_pixel(1, 0, 0), [0.0, 1.0, 0.0, 1.0]);
    }

    #[test]
    fn tex_image_2d_with_no_data_clears_to_the_texture_initial_value() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        let tex = cx.texture(names[0]).unwrap();
        let pixel = tex.level(0).unwrap().get_const_access().get_pixel(0, 0, 0);
        assert_eq!(
            pixel,
            [0.0, 0.0, 0.0, 1.0],
            "an uninitialised colour texture level must read back as opaque black"
        );
    }

    #[test]
    fn pixel_storei_validates_each_pname_the_same_way_upstream_does() {
        let mut cx = ctx();

        cx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 3);
        assert_eq!(
            cx.get_error(),
            glw::GL_INVALID_VALUE,
            "only 1/2/4/8 are valid alignments"
        );
        cx.pixel_storei(glw::GL_UNPACK_ALIGNMENT, 8);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.pixel_storei(glw::GL_PACK_ALIGNMENT, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);

        cx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, -1);
        assert_eq!(
            cx.get_error(),
            glw::GL_INVALID_VALUE,
            "a negative row length makes no sense"
        );
        cx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, -1);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
        cx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, -1);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);

        cx.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, -1);
        assert_eq!(
            cx.get_error(),
            glw::GL_INVALID_VALUE,
            "a negative image height makes no sense, same as a negative row length"
        );
        cx.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        cx.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, -1);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    #[test]
    fn tex_image_2d_honours_a_row_pitch_wider_than_the_tightly_packed_minimum() {
        // 3 bytes/pixel (GL_RGB) at width 3 is 9 bytes/row, not a multiple of the
        // default GL_UNPACK_ALIGNMENT (4) - this is exactly the case that would read
        // the wrong texel if `tex_image_2d` still assumed tightly-packed rows (an old
        // tightly-packed read would start row 1 nine bytes in, three bytes short of
        // where the real, alignment-padded row 1 actually starts).
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        #[rustfmt::skip]
        let data: [u8; 21] = [
            10, 20, 30,   40, 50, 60,   70, 80, 90,   0xFF, 0xFF, 0xFF, // row 0 (9 real bytes + 3 padding bytes to reach the 12-byte aligned pitch)
            100, 110, 120, 130, 140, 150, 160, 170, 180,                // row 1 (no trailing padding needed - only `width * pixel_size` bytes are read)
        ];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGB,
            3,
            2,
            0,
            glw::GL_RGB,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture(names[0]).unwrap();
        let access = tex.level(0).unwrap().get_const_access();
        assert_eq!(
            access.get_pixel(0, 0, 0),
            [10.0 / 255.0, 20.0 / 255.0, 30.0 / 255.0, 1.0]
        );
        assert_eq!(
            access.get_pixel(2, 0, 0),
            [70.0 / 255.0, 80.0 / 255.0, 90.0 / 255.0, 1.0]
        );
        assert_eq!(
            access.get_pixel(0, 1, 0),
            [100.0 / 255.0, 110.0 / 255.0, 120.0 / 255.0, 1.0]
        );
        assert_eq!(
            access.get_pixel(2, 1, 0),
            [160.0 / 255.0, 170.0 / 255.0, 180.0 / 255.0, 1.0]
        );
    }

    #[test]
    fn tex_image_2d_honours_unpack_row_length_skip_rows_and_skip_pixels_together() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        // A virtual 4-column-wide RGBA8 source image (`GL_UNPACK_ROW_LENGTH = 4`, so
        // the real row pitch is 16 bytes, not `2 * 4 = 8`), reading a 2x1 rectangle
        // starting one row and one pixel in (`GL_UNPACK_SKIP_ROWS`/`_SKIP_PIXELS = 1`).
        cx.pixel_storei(glw::GL_UNPACK_ROW_LENGTH, 4);
        cx.pixel_storei(glw::GL_UNPACK_SKIP_ROWS, 1);
        cx.pixel_storei(glw::GL_UNPACK_SKIP_PIXELS, 1);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        #[rustfmt::skip]
        let data: [u8; 28] = [
            // row 0 (16 bytes) - entirely skipped by GL_UNPACK_SKIP_ROWS.
            0xAA, 0xAA, 0xAA, 0xAA,  0xAA, 0xAA, 0xAA, 0xAA,  0xAA, 0xAA, 0xAA, 0xAA,  0xAA, 0xAA, 0xAA, 0xAA,
            // row 1: column 0 skipped by GL_UNPACK_SKIP_PIXELS, columns 1 and 2 read.
            0xAA, 0xAA, 0xAA, 0xAA,  10, 20, 30, 255,  40, 50, 60, 255,
        ];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            2,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture(names[0]).unwrap();
        let access = tex.level(0).unwrap().get_const_access();
        assert_eq!(
            access.get_pixel(0, 0, 0),
            [10.0 / 255.0, 20.0 / 255.0, 30.0 / 255.0, 1.0]
        );
        assert_eq!(
            access.get_pixel(1, 0, 0),
            [40.0 / 255.0, 50.0 / 255.0, 60.0 / 255.0, 1.0]
        );
    }

    #[test]
    fn tex_parameteri_without_a_bound_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn tex_parameteri_with_an_unsupported_target_is_invalid_enum() {
        // GL_TEXTURE_1D has no backing object type here at all - unlike
        // GL_TEXTURE_CUBE_MAP, which is now a valid tex_parameteri target (see
        // `tex_parameteri_on_a_cube_map_applies_to_the_whole_object_not_one_face`).
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        cx.tex_parameteri(glw::GL_TEXTURE_1D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn tex_parameteri_rejects_an_unmappable_value_as_invalid_value() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);

        // `GL_TEXTURE_MAG_FILTER` rejects the mipmap filter modes `GL_TEXTURE_MIN_FILTER`
        // accepts - upstream's own extra `magMode != LINEAR && magMode != NEAREST` check.
        cx.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_MAG_FILTER,
            glw::GL_NEAREST_MIPMAP_LINEAR as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);

        cx.tex_parameteri(
            glw::GL_TEXTURE_2D,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST_MIPMAP_LINEAR as i32,
        );
        assert_eq!(
            cx.get_error(),
            glw::GL_NO_ERROR,
            "GL_TEXTURE_MIN_FILTER does accept the mipmap modes"
        );

        cx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAX_LEVEL, -1);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    #[test]
    fn tex_sub_image_2d_updates_only_the_given_rectangle() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        let white: [u8; 4] = [255, 255, 255, 255];
        cx.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            1,
            1,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            &white,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture(names[0]).unwrap();
        let access = tex.level(0).unwrap().get_const_access();
        assert_eq!(access.get_pixel(1, 1, 0), [1.0, 1.0, 1.0, 1.0]);
        assert_eq!(
            access.get_pixel(0, 0, 0),
            [0.0, 0.0, 0.0, 1.0],
            "untouched texel must stay at the texture's initial value"
        );
    }

    #[test]
    fn tex_sub_image_2d_past_the_level_bounds_is_invalid_value() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        let data: [u8; 4] = [1, 2, 3, 4];
        cx.tex_sub_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            1,
            1,
            2,
            2,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            &data,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    #[test]
    fn deleting_a_bound_texture_clears_the_binding() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        cx.delete_textures(&names);
        assert!(cx.texture(names[0]).is_none());

        // Binding is gone too - a fresh texImage2D must report "nothing bound".
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn active_texture_selects_a_different_binding_point() {
        let mut cx = ctx();
        let mut names = [0u32, 0u32];
        cx.gen_textures(&mut names);

        cx.active_texture(glw::GL_TEXTURE0);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        cx.active_texture(glw::GL_TEXTURE1);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[1]);

        cx.active_texture(glw::GL_TEXTURE0);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert!(cx.texture(names[0]).unwrap().level(0).is_some());
        assert!(
            cx.texture(names[1]).unwrap().level(0).is_none(),
            "upload must land on unit 0's texture, not unit 1's"
        );
    }

    // --- Renderbuffer / framebuffer objects ---

    #[test]
    fn renderbuffer_storage_round_trips_format_and_size() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_renderbuffers(&mut names);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, names[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 8, 6);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let rb = cx.renderbuffer(names[0]).unwrap();
        assert_eq!((rb.width(), rb.height()), (8, 6));
        assert_eq!(
            rb.format(),
            Some(crate::tcu::texture::TextureFormat::new(
                crate::tcu::texture::ChannelOrder::RGBA,
                crate::tcu::texture::ChannelType::UNORM_INT8
            ))
        );
    }

    #[test]
    fn renderbuffer_storage_with_an_unknown_internalformat_is_invalid_enum() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_renderbuffers(&mut names);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, names[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, 0xDEAD, 8, 8);
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn framebuffer_with_no_attachment_is_incomplete_missing_attachment() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_framebuffers(&mut names);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, names[0]);
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        );
    }

    #[test]
    fn framebuffer_with_mismatched_attachment_dimensions_is_incomplete_dimensions() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rbs = [0u32, 0u32];
        cx.gen_renderbuffers(&mut rbs);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbs[0],
        );

        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[1]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH_COMPONENT16, 8, 8); // mismatched size
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbs[1],
        );

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS
        );
    }

    #[test]
    fn framebuffer_with_a_matching_color_attachment_is_complete() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rb = [0u32];
        cx.gen_renderbuffers(&mut rb);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rb[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rb[0],
        );

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );
    }

    #[test]
    fn deleting_a_renderbuffer_still_attached_detaches_it_from_the_framebuffer() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rb = [0u32];
        cx.gen_renderbuffers(&mut rb);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rb[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rb[0],
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, 0);
        cx.delete_renderbuffers(&rb);

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        );
    }

    #[test]
    fn draw_into_a_color_renderbuffer_fbo_renders_there_not_into_the_default_framebuffer() {
        let mut cx = ctx_with_size(4, 4);

        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rb = [0u32];
        cx.gen_renderbuffers(&mut rb);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rb[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rb[0],
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 1.0, 0.0, 1.0))),
        );
        cx.use_program(program);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        // The default framebuffer must be untouched (still the zero-initialised clear
        // colour - nothing cleared or drawn into it this test).
        let default_pixel = cx.color_buffer().get_const_access().get_pixel(2, 2, 0);
        assert_eq!(
            default_pixel,
            [0.0, 0.0, 0.0, 0.0],
            "default framebuffer must be untouched, got {default_pixel:?}"
        );

        // The renderbuffer itself must have the triangle's green colour - read through
        // the crate-private `access()`, visible here since `tests` is a submodule of
        // `reference_context` (there is no public pixel-read accessor yet; no
        // `readPixels` - see this module's top doc comment).
        let rbo = cx.renderbuffers.find_mut(rb[0]).unwrap();
        let pixel = rbo.access().unwrap().as_const().get_pixel(2, 2, 0);
        assert_eq!(
            pixel,
            [0.0, 1.0, 0.0, 1.0],
            "renderbuffer should hold the triangle's green, got {pixel:?}"
        );
    }

    #[test]
    fn drawing_with_the_same_renderbuffer_attached_to_color_and_depth_is_refused_as_incomplete() {
        // A nonsensical but API-constructible setup: the same `GL_RGBA8` renderbuffer
        // attached to both `GL_COLOR_ATTACHMENT0` and `GL_DEPTH_ATTACHMENT`. This used to
        // reach `resolve_targets`'s own `attachments_alias` panic, back when
        // `predraw_checks` did not call `check_framebuffer_status` first (see that
        // function's own doc comment for why it does now) - a single concrete format can
        // never be both colour-compatible (`check_framebuffer_status`'s `compatible`
        // match, `R|RG|RGB|RGBA|...` arm, `point == Color0` only) and depth-compatible
        // (`D => point == Depth` only) at once, so *any* attachment literally aliased
        // between `Color0` and `Depth`/`Stencil` is necessarily
        // `GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT` - `predraw_checks` now refuses the draw
        // with `GL_INVALID_FRAMEBUFFER_OPERATION` before `draw_with_reference`/
        // `resolve_targets` is ever reached, so `resolve_targets`'s own aliasing assert
        // for this pair is no longer reachable through the public draw-call path (kept
        // anyway as a defensive invariant - see that function's own doc comment).
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rb = [0u32];
        cx.gen_renderbuffers(&mut rb);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rb[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rb[0],
        );
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rb[0],
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);
        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0))),
        );
        cx.use_program(program);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_INVALID_FRAMEBUFFER_OPERATION);

        // Nothing was drawn - the renderbuffer must still hold its fresh
        // `renderbuffer_storage` zero fill, not the shader's white.
        let rbo = cx.renderbuffers.find_mut(rb[0]).unwrap();
        let pixel = rbo.access().unwrap().as_const().get_pixel(2, 2, 0);
        assert_eq!(
            pixel,
            [0.0, 0.0, 0.0, 0.0],
            "a refused draw must not have written anything, got {pixel:?}"
        );
    }

    // --- Texture-attached framebuffers (`framebuffer_texture2d`) ---

    #[test]
    fn framebuffer_with_a_matching_texture_color_attachment_is_complete() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );
    }

    #[test]
    fn framebuffer_texture_attachment_with_no_level_uploaded_is_missing_attachment() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        // A texture object exists but texImage2D was never called on it - no level 0,
        // so this must be treated exactly like an attached renderbuffer that never had
        // renderbufferStorage called: as if nothing were attached at all.
        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        );
    }

    #[test]
    fn framebuffer_texture_attachment_with_mismatched_dimensions_is_incomplete_dimensions() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );

        let mut rb = [0u32];
        cx.gen_renderbuffers(&mut rb);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rb[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH_COMPONENT16, 8, 8); // mismatched size
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rb[0],
        );

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS
        );
    }

    #[test]
    fn draw_into_a_color_texture_fbo_renders_there_and_is_readable_via_the_texture_object() {
        let mut cx = ctx_with_size(4, 4);

        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 0.0, 1.0, 1.0))),
        );
        cx.use_program(program);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        // The default framebuffer must be untouched.
        let default_pixel = cx.color_buffer().get_const_access().get_pixel(2, 2, 0);
        assert_eq!(
            default_pixel,
            [0.0, 0.0, 0.0, 0.0],
            "default framebuffer must be untouched, got {default_pixel:?}"
        );

        // Read the result back through the texture object itself - this is the whole
        // point of a texture-attached (as opposed to renderbuffer-attached) framebuffer:
        // a later draw can bind this same texture and sample what was just rendered.
        let level = cx.texture(tex[0]).unwrap().level(0).unwrap();
        let pixel = level.get_const_access().get_pixel(2, 2, 0);
        assert_eq!(
            pixel,
            [0.0, 0.0, 1.0, 1.0],
            "texture attachment should hold the triangle's blue, got {pixel:?}"
        );
    }

    /// The texture-attachment counterpart of
    /// `draw_arrays_writes_exact_signed_integer_values_into_an_integer_color_attachment`
    /// just above - that test only ever exercises `resolve_targets`' renderbuffer
    /// branch; `framebufferTexture2D` takes a genuinely different branch of the same
    /// function (`FboAttachment::Texture2D` rather than `FboAttachment::Renderbuffer`),
    /// so this is a real second code path worth its own confirmation rather than an
    /// assumed-identical duplicate. `tex_image_2d`'s `format`/`type_` transfer-format
    /// parameters (`GL_RGBA_INTEGER`/`GL_INT`) describe the source data layout GL would
    /// unpack from, which is `None` here - they still have to be a format
    /// `map_gl_transfer_format` accepts, or `tex_image_2d` itself would report
    /// `GL_INVALID_ENUM` before a single pixel is ever drawn.
    #[test]
    fn draw_into_an_integer_color_texture_fbo_renders_there_and_is_readable_via_the_texture_object() {
        let mut cx = ctx_with_size(4, 4);

        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA32I,
            4,
            4,
            0,
            glw::GL_RGBA_INTEGER,
            glw::GL_INT,
            None,
        );
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        let vs = PassthroughVertexShader::new();
        let fs = IntegerConstantFragmentShader::new_signed(IVec4::new(5, -3, 100, -7));
        let program = cx.create_program(Box::new(vs), Box::new(fs));
        cx.use_program(program);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let level = cx.texture(tex[0]).unwrap().level(0).unwrap();
        let pixel = level.get_const_access().get_pixel_int(2, 2, 0);
        assert_eq!(
            pixel,
            [5, -3, 100, -7],
            "an integer texture attachment must hold the exact drawn values, got {pixel:?}"
        );
    }

    #[test]
    fn deleting_a_texture_still_attached_detaches_it_from_the_framebuffer() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        cx.bind_texture(glw::GL_TEXTURE_2D, 0);
        cx.delete_textures(&tex);

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        );
    }

    #[test]
    fn drawing_with_the_same_texture_attached_to_color_and_depth_is_refused_as_incomplete() {
        // The texture-attachment counterpart of
        // `drawing_with_the_same_renderbuffer_attached_to_color_and_depth_is_refused_as_incomplete` -
        // see that test's own doc comment for why this is now caught by
        // `predraw_checks`'s completeness check rather than `resolve_targets`'s own
        // aliasing assert.
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);
        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0))),
        );
        cx.use_program(program);

        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_INVALID_FRAMEBUFFER_OPERATION);

        // Nothing was drawn - the texture must still hold its fresh `tex_image_2d(...,
        // None)` initial value (`fill_tex_image_2d_level`'s own `clear_to_texture_initial_value`
        // for a colour format, alpha `1.0` - not an all-zero fill; see that function's
        // own two other callers' identical assertion), not the shader's white.
        let tex_obj = cx.texture(tex[0]).unwrap();
        let pixel = tex_obj.level(0).unwrap().get_const_access().get_pixel(2, 2, 0);
        assert_eq!(
            pixel,
            [0.0, 0.0, 0.0, 1.0],
            "a refused draw must not have written anything, got {pixel:?}"
        );
    }

    /// A single `GL_DEPTH24_STENCIL8` renderbuffer attached at *both*
    /// `GL_DEPTH_ATTACHMENT` and `GL_STENCIL_ATTACHMENT` (`GL_DEPTH_STENCIL_ATTACHMENT`'s
    /// own recursive shape, see `framebuffer_renderbuffer`'s own doc comment) must draw
    /// through both channels correctly rather than hitting `resolve_targets`' old
    /// unconditional panic - this is `attachments_alias(depth_att, stencil_att)` being
    /// true for real, not a synthetic case.
    ///
    /// Deliberately avoids `clear(GL_DEPTH_BUFFER_BIT)`/`clear(GL_STENCIL_BUFFER_BIT)`
    /// against this attachment, to keep this test exercising the draw path
    /// (`resolve_targets`) alone - `clear`'s own combined-format handling is a separate
    /// fix, exercised by `clearing_a_combined_depth_stencil_renderbuffer_attachment_writes_both_channels_correctly`
    /// below. A freshly `renderbuffer_storage`d level starts zero-filled
    /// (`TextureLevel::new`'s own `vec![0u8; len]`), so both channels begin at a known
    /// `0` without needing a clear at all here.
    #[test]
    fn a_combined_depth_stencil_renderbuffer_attachment_draws_through_both_channels() {
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rbs = [0u32, 0u32];
        cx.gen_renderbuffers(&mut rbs);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbs[0],
        );

        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[1]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbs[1],
        );

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        // --- Depth half: a GL_ALWAYS-drawn near triangle must win over a
        // GL_LESS-tested far triangle drawn after it, which only comes out right if the
        // first draw's depth write and the second draw's depth read both went through
        // the same split depth-only view of the combined buffer.
        cx.enable(glw::GL_DEPTH_TEST);
        cx.depth_func(glw::GL_ALWAYS);
        let red = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 0.0, 0.0, 1.0))),
        );
        cx.use_program(red);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3); // z=0 (make_quad_buffer's own z)
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.depth_func(glw::GL_LESS);
        let blue = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 0.0, 1.0, 1.0))),
        );
        cx.use_program(blue);
        // A second, identically-covering quad at a farther z - make_quad_buffer's own
        // z is 0, so anything > 0 is farther; GL_LESS must reject it against what the
        // GL_ALWAYS pass above already wrote.
        let mut vbo = [0u32];
        cx.gen_buffers(&mut vbo);
        cx.bind_buffer(glw::GL_ARRAY_BUFFER, vbo[0]);
        #[rustfmt::skip]
        let far: [[f32; 4]; 3] = [[-10.0, -10.0, 0.5, 1.0], [10.0, -10.0, 0.5, 1.0], [0.0, 10.0, 0.5, 1.0]];
        let bytes = unsafe { std::slice::from_raw_parts(far.as_ptr().cast::<u8>(), std::mem::size_of_val(&far)) };
        cx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        {
            let rb = cx.renderbuffer(rbs[0]).unwrap();
            let pixel = rb.get_const_access().unwrap().get_pixel(2, 2, 0);
            assert_eq!(
                pixel,
                [1.0, 0.0, 0.0, 1.0],
                "the farther blue quad must have been rejected by the depth test against the combined buffer's own depth channel, got {pixel:?}"
            );
        }

        // --- Stencil half: GL_ALWAYS + GL_REPLACE writes 5 everywhere, then GL_EQUAL
        // ref=5 must pass (reading the same 5 back) while GL_EQUAL ref=6 must not -
        // only comes out right if the stencil write and both reads went through the
        // same split stencil-only view of the *same* combined buffer the depth half
        // above just wrote into, independent of whatever is in the depth channel.
        cx.disable(glw::GL_DEPTH_TEST);
        cx.enable(glw::GL_STENCIL_TEST);
        cx.stencil_func(glw::GL_ALWAYS, 5, 0xFF);
        cx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_REPLACE);
        let green = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 1.0, 0.0, 1.0))),
        );
        cx.use_program(green);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.stencil_func(glw::GL_EQUAL, 6, 0xFF);
        let magenta = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 0.0, 1.0, 1.0))),
        );
        cx.use_program(magenta);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        {
            let rb = cx.renderbuffer(rbs[0]).unwrap();
            let pixel = rb.get_const_access().unwrap().get_pixel(2, 2, 0);
            assert_eq!(
                pixel,
                [0.0, 1.0, 0.0, 1.0],
                "stencil ref=6 must not match the 5 the previous draw wrote, got {pixel:?}"
            );
        }

        cx.stencil_func(glw::GL_EQUAL, 5, 0xFF);
        let yellow = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 0.0, 1.0))),
        );
        cx.use_program(yellow);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        {
            let rb = cx.renderbuffer(rbs[0]).unwrap();
            let pixel = rb.get_const_access().unwrap().get_pixel(2, 2, 0);
            assert_eq!(
                pixel,
                [1.0, 1.0, 0.0, 1.0],
                "stencil ref=5 must match the 5 an earlier draw wrote into the combined buffer's own stencil channel, got {pixel:?}"
            );
        }
    }

    /// `clear(GL_DEPTH_BUFFER_BIT)`/`clear(GL_STENCIL_BUFFER_BIT)` against a *combined*
    /// depth-stencil attachment - found while writing the draw-path test above:
    /// `clear`'s own depth/stencil blocks wrote through plain
    /// `PixelBufferAccess::set_pixel`/`set_pixel_int`, which have no notion of a
    /// combined format at all (unlike `set_pix_depth`/`set_pix_stencil`, which already
    /// existed in `tcu::pixel` and already handled every combined `ChannelType` by
    /// writing only that channel's own bytes within the shared texel) - fixed by
    /// switching `clear` to those two instead. This test is the one that would have
    /// caught the bug: clearing depth to a *specific* non-default value (`0.2`, not the
    /// usual `1.0`/farthest) and stencil to a specific value (`7`, not `0`) and then
    /// testing against exactly those values is what distinguishes "wrote the right
    /// bytes" from "wrote *some* bytes that happen to leave the zero-initialized
    /// buffer's default behaviour looking right".
    #[test]
    fn clearing_a_combined_depth_stencil_renderbuffer_attachment_writes_both_channels_correctly() {
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rbs = [0u32, 0u32];
        cx.gen_renderbuffers(&mut rbs);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_RGBA8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbs[0],
        );

        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbs[1]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH24_STENCIL8, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_STENCIL_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rbs[1],
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        cx.clear_color(0.0, 0.0, 0.0, 1.0);
        // Deliberately not GL's own usual 1.0/farthest default and not stencil 0 -
        // see this test's own doc comment on why that matters.
        cx.clear_depthf(0.2);
        cx.clear_stencil(7);
        cx.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);

        // Depth half: make_quad_buffer's own z=0 maps to window depth 0.5 (default
        // depth range [0,1], NDC 0 -> (0*1+1)/2) - GL_LESS against the cleared 0.2
        // must reject it (0.5 is not < 0.2), which only comes out right if
        // clear_depthf(0.2) actually landed in the depth channel of the combined
        // buffer rather than in the stencil byte or nowhere at all.
        cx.enable(glw::GL_DEPTH_TEST);
        cx.depth_func(glw::GL_LESS);
        let white = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 1.0, 1.0, 1.0))),
        );
        cx.use_program(white);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        {
            let rb = cx.renderbuffer(rbs[0]).unwrap();
            let pixel = rb.get_const_access().unwrap().get_pixel(2, 2, 0);
            assert_eq!(
                pixel,
                [0.0, 0.0, 0.0, 1.0],
                "the white quad must have been rejected by the depth test against clear_depthf(0.2), got {pixel:?}"
            );
        }

        // Stencil half: GL_EQUAL ref=7 must pass everywhere clear_stencil(7) reached.
        cx.disable(glw::GL_DEPTH_TEST);
        cx.enable(glw::GL_STENCIL_TEST);
        cx.stencil_func(glw::GL_EQUAL, 7, 0xFF);
        let cyan = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 1.0, 1.0, 1.0))),
        );
        cx.use_program(cyan);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let rb = cx.renderbuffer(rbs[0]).unwrap();
        let pixel = rb.get_const_access().unwrap().get_pixel(2, 2, 0);
        assert_eq!(
            pixel,
            [0.0, 1.0, 1.0, 1.0],
            "stencil test against clear_stencil(7) must pass, confirming clear() wrote 7 into the combined buffer's own stencil channel, got {pixel:?}"
        );
    }

    #[test]
    fn a_renderbuffer_and_a_texture_sharing_the_same_raw_name_do_not_alias() {
        // Renderbuffer names and texture names are different namespaces - `gen_renderbuffers`
        // and `gen_textures` each run their own independent counter, so it is entirely
        // normal (not a test artifact) for renderbuffer 1 and texture 1 to both exist as
        // unrelated objects at once. `resolve_targets`' aliasing check must tell these
        // apart by (type, name), not by the raw name alone - this draw must succeed, not
        // panic, which is exactly what `attachments_alias` is for.
        let mut cx = ctx_with_size(4, 4);
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut rb = [0u32];
        cx.gen_renderbuffers(&mut rb);
        cx.bind_renderbuffer(glw::GL_RENDERBUFFER, rb[0]);
        cx.renderbuffer_storage(glw::GL_RENDERBUFFER, glw::GL_DEPTH_COMPONENT16, 4, 4);
        cx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_DEPTH_ATTACHMENT,
            glw::GL_RENDERBUFFER,
            rb[0],
        );

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        assert_eq!(
            rb[0], tex[0],
            "test premise: both object managers must hand out the same first name"
        );
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);
        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 0.0, 0.0, 1.0))),
        );
        cx.use_program(program);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let pixel = cx
            .texture(tex[0])
            .unwrap()
            .level(0)
            .unwrap()
            .get_const_access()
            .get_pixel(2, 2, 0);
        assert_eq!(pixel, [1.0, 0.0, 0.0, 1.0]);
    }

    // --- `sglr::Context`/`ShaderProgram` - a `DepthShader`/`DepthCompareCase`-shaped
    // end-to-end test (`es2fDepthTests.cpp`), driven entirely through `&mut dyn
    // Context` the way an actual case would, not through `ReferenceContext`'s own
    // inherent methods. ---

    use crate::sglr::context::Context;
    use crate::sglr::context_util::draw_quad;
    use crate::sglr::shader_program::{ShaderProgramBase, pdec};
    use crate::tcu::vector::Vec3;

    /// `DepthShader` - one `vec4` uniform (`u_color`), recoloured between draws via
    /// `Context::uniform4fv` exactly as `DepthShader::setColor` does upstream.
    struct ColorUniformShader {
        base: ShaderProgramBase,
    }

    impl ColorUniformShader {
        fn new() -> Self {
            let decl = pdec::ShaderProgramDeclaration::new()
                .vertex_attribute(pdec::VertexAttribute::new("a_position", GenericVecType::Float))
                .fragment_output(pdec::FragmentOutput::new(GenericVecType::Float))
                .uniform(pdec::Uniform::new("u_color", DataType::FloatVec4))
                .vertex_source(
                    "attribute highp vec4 a_position;\nvoid main (void)\n{\n    gl_Position = a_position;\n}\n",
                )
                .fragment_source(
                    "uniform mediump vec4 u_color;\nvoid main (void)\n{\n    gl_FragColor = u_color;\n}\n",
                );
            Self {
                base: ShaderProgramBase::new(&decl),
            }
        }
    }

    impl VertexShader for ColorUniformShader {
        fn inputs(&self) -> &[VertexInputInfo] {
            self.base.vertex_inputs()
        }
        fn outputs(&self) -> &[VertexOutputInfo] {
            self.base.vertex_outputs()
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

    impl FragmentShader for ColorUniformShader {
        fn inputs(&self) -> &[FragmentInputInfo] {
            self.base.fragment_inputs()
        }
        fn outputs(&self) -> &[FragmentOutputInfo] {
            self.base.fragment_outputs()
        }
        fn shade_fragments(&self, packets: &mut [FragmentPacket], context: &FragmentShadingContext) {
            let color = self.base.uniform_by_name("u_color").value.as_f32_vec4();
            let value = GenericVec4::from_float(Vec4::new(color[0], color[1], color[2], color[3]));
            for (packet_ndx, _) in packets.iter().enumerate() {
                for frag_ndx in 0..4 {
                    unsafe { write_fragment_output(context, packet_ndx as i32, frag_ndx, 0, value) };
                }
            }
        }
    }

    impl ShaderProgram for ColorUniformShader {
        fn program_base(&self) -> &ShaderProgramBase {
            &self.base
        }
        fn program_base_mut(&mut self) -> &mut ShaderProgramBase {
            &mut self.base
        }
    }

    /// `DepthShader::setColor`
    fn set_color(ctx: &mut dyn Context, program_id: u32, color: [f32; 4]) {
        ctx.use_program(program_id);
        let loc = ctx.get_uniform_location(program_id, "u_color");
        ctx.uniform4fv(loc, 1, &color);
    }

    /// Replicates one quadrant of `es2fDepthTests.cpp`'s `DepthCompareCase::render`:
    /// two full-screen quads at the identical depth (0.2), first drawn red with
    /// `depthFunc(GL_ALWAYS)`, then green with the compare op under test - run through
    /// `&mut dyn Context` end to end (`create_program`/`use_program`/
    /// `get_uniform_location`/`uniform4fv`/`draw_quad`/`get_error`), exactly the
    /// surface `DepthCase::render(sglr::Context&)` drives. Returns the final colour of
    /// a pixel that is inside both quads (every pixel is, since both cover the whole
    /// screen).
    fn render_two_quads_at_equal_depth(compare_op: GLenum) -> RGBA {
        let mut cx = ctx_with_depth(4, 4);
        let final_pixel;
        {
            let ctx: &mut dyn Context = &mut cx;
            let program_id = ctx.create_program(Box::new(ColorUniformShader::new()));

            ctx.clear_color(0.0, 0.0, 0.0, 1.0);
            ctx.clear(glw::GL_COLOR_BUFFER_BIT);
            ctx.clear_depthf(1.0);
            ctx.clear(glw::GL_DEPTH_BUFFER_BIT);
            ctx.enable(glw::GL_DEPTH_TEST);

            ctx.depth_func(glw::GL_ALWAYS);
            set_color(ctx, program_id, [1.0, 0.0, 0.0, 1.0]);
            draw_quad(ctx, program_id, Vec3::new(-1.0, -1.0, 0.2), Vec3::new(1.0, 1.0, 0.2));

            ctx.depth_func(compare_op);
            set_color(ctx, program_id, [0.0, 1.0, 0.0, 1.0]);
            draw_quad(ctx, program_id, Vec3::new(-1.0, -1.0, 0.2), Vec3::new(1.0, 1.0, 0.2));

            assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
            let mut surface = Surface::new(1, 1);
            ctx.read_pixels(&mut surface, 0, 0, 1, 1);
            final_pixel = surface.get_pixel(0, 0);
        }
        final_pixel
    }

    #[test]
    fn depth_compare_with_equal_depths_and_gl_less_keeps_the_first_quad_red() {
        // GL_LESS: 0.2 < 0.2 is false, so the second (green) draw's depth test fails
        // and the first (red) draw's colour survives - same as upstream's own
        // `cmp_less_than` case over its "same depth" quadrant.
        assert_eq!(render_two_quads_at_equal_depth(glw::GL_LESS), RGBA::new(255, 0, 0, 255));
    }

    #[test]
    fn depth_compare_with_equal_depths_and_gl_lequal_overwrites_with_the_second_quad_green() {
        // GL_LEQUAL: 0.2 <= 0.2 is true, so the second (green) draw passes the depth
        // test and overwrites the first (red) one - same as upstream's `cmp_less_or_
        // equal` case over its "same depth" quadrant.
        assert_eq!(
            render_two_quads_at_equal_depth(glw::GL_LEQUAL),
            RGBA::new(0, 255, 0, 255)
        );
    }

    #[test]
    fn use_program_through_the_context_trait_dispatches_to_the_declared_program_path() {
        // A `Plain` program (the pre-existing `create_program(vertex, fragment)` path)
        // has no uniform slots at all - `get_uniform_location`/`uniform4fv` must report
        // that rather than panicking, confirming `ProgramObject::declared` really does
        // distinguish the two shapes sharing one object-name space.
        let mut cx = ctx();
        let plain_program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(0.0, 0.0, 0.0, 1.0))),
        );
        assert_eq!(cx.get_uniform_location(plain_program, "u_color"), -1);
        assert_eq!(
            cx.get_attrib_location(plain_program, "a_position"),
            -1,
            "Plain has no declared attribute-name table either"
        );

        let ctx: &mut dyn Context = &mut cx;
        let declared_program = ctx.create_program(Box::new(ColorUniformShader::new()));
        assert_eq!(ctx.get_attrib_location(declared_program, "a_position"), 0);
        assert!(ctx.get_uniform_location(declared_program, "u_color") >= 0);
    }

    #[test]
    fn fbo_render_shaped_setup_builds_a_complete_texture_attached_fbo_through_the_context_trait() {
        // Replicates the FBO-construction half of `es2fFboRenderTest.cpp`'s
        // `Fbo::render` (the group this trait's second widening pass, "fbo.render's
        // own surface" in `context.rs`'s own module doc comment, was grepped from):
        // generate a texture, allocate its storage, attach it to a fresh framebuffer's
        // colour0 point, and confirm the framebuffer reports complete - entirely
        // through `&mut dyn Context`, exercising every texture/framebuffer method this
        // pass added (`active_texture` is exercised too, even though it has no
        // observable effect on a single-unit scenario, since `fbo.render` always calls
        // it before binding a texture).
        let mut cx = ctx_with_size(8, 8);
        let ctx: &mut dyn Context = &mut cx;

        ctx.active_texture(glw::GL_TEXTURE0);
        let mut tex = [0u32];
        ctx.gen_textures(&mut tex);
        ctx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        ctx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA,
            8,
            8,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        let mut fbo = [0u32];
        ctx.gen_framebuffers(&mut fbo);
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);
        ctx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );

        assert_eq!(
            ctx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );
        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);

        ctx.viewport(0, 0, 8, 8);
        ctx.color_mask(true, true, true, false);
        ctx.blend_equation(glw::GL_FUNC_ADD);
        ctx.blend_func_separate(glw::GL_ONE, glw::GL_ZERO, glw::GL_ONE, glw::GL_ZERO);
        assert_eq!(
            ctx.get_error(),
            glw::GL_NO_ERROR,
            "the blend/viewport/colorMask state setters themselves must not raise an error"
        );

        ctx.delete_framebuffers(&fbo);
        ctx.delete_textures(&tex);
        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
    }

    #[test]
    fn draw_arrays_and_buffer_sub_data_through_the_context_trait() {
        // `vertex_arrays.*`'s own grep-confirmed backing file (`glsVertexArrayTests.cpp`
        // - see `context.rs`'s own module doc comment) is what motivated widening the
        // trait with these two, plus `vertex_attrib_i_pointer` (exercised separately
        // below - no integer-attribute-reading shader exists in this test file yet to
        // prove data flow, so that one is checked for successful forwarding only).
        let mut cx = ctx_with_size(4, 4);
        let ctx: &mut dyn Context = &mut cx;

        let mut buf = [0u32];
        ctx.gen_buffers(&mut buf);
        ctx.bind_buffer(glw::GL_ARRAY_BUFFER, buf[0]);

        // Allocate storage with a degenerate (zero-area) triangle first...
        let degenerate: [[f32; 4]; 3] = [[0.0, 0.0, 0.0, 1.0]; 3];
        let bytes =
            unsafe { std::slice::from_raw_parts(degenerate.as_ptr().cast::<u8>(), std::mem::size_of_val(&degenerate)) };
        ctx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));

        // ...then overwrite it via `buffer_sub_data` with a real oversized triangle
        // that covers the whole viewport (same shape `make_quad_buffer` above uses).
        #[rustfmt::skip]
        let position_data: [[f32; 4]; 3] = [
            [-10.0, -10.0, 0.0, 1.0],
            [10.0, -10.0, 0.0, 1.0],
            [0.0, 10.0, 0.0, 1.0],
        ];
        let bytes = unsafe {
            std::slice::from_raw_parts(
                position_data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(&position_data),
            )
        };
        ctx.buffer_sub_data(glw::GL_ARRAY_BUFFER, 0, bytes);

        ctx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        ctx.enable_vertex_attrib_array(0);

        let program = ctx.create_program(Box::new(ColorUniformShader::new()));
        ctx.use_program(program);
        let loc = ctx.get_uniform_location(program, "u_color");
        ctx.uniform4fv(loc, 1, &[0.0, 1.0, 0.0, 1.0]);

        ctx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);

        let mut surface = Surface::new(1, 1);
        ctx.read_pixels(&mut surface, 2, 2, 1, 1);
        assert_eq!(
            surface.get_pixel(0, 0),
            RGBA::new(0, 255, 0, 255),
            "buffer_sub_data's overwrite must be what draw_arrays actually renders"
        );
    }

    #[test]
    fn vertex_attrib_i_pointer_through_the_context_trait_forwards_without_error() {
        let mut cx = ctx_with_size(4, 4);
        let ctx: &mut dyn Context = &mut cx;

        let mut buf = [0u32];
        ctx.gen_buffers(&mut buf);
        ctx.bind_buffer(glw::GL_ARRAY_BUFFER, buf[0]);
        let data: [i32; 4] = [1, 2, 3, 4];
        let bytes = unsafe { std::slice::from_raw_parts(data.as_ptr().cast::<u8>(), std::mem::size_of_val(&data)) };
        ctx.buffer_data(glw::GL_ARRAY_BUFFER, bytes.len() as isize, Some(bytes));

        ctx.vertex_attrib_i_pointer(0, 1, glw::GL_INT, 0, 0, false);
        assert_eq!(ctx.get_error(), glw::GL_NO_ERROR);
    }

    #[test]
    fn get_string_of_extensions_lists_exactly_the_three_unconditional_ones() {
        let mut cx = ctx();
        let extensions = cx
            .get_string(glw::GL_EXTENSIONS)
            .expect("GL_EXTENSIONS must answer Some");
        let names: Vec<&str> = extensions.split(' ').collect();
        assert_eq!(
            names,
            [
                "GL_EXT_color_buffer_half_float",
                "GL_EXT_color_buffer_float",
                "GL_EXT_texture_format_BGRA8888"
            ]
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
    }

    #[test]
    fn get_string_of_an_unsupported_pname_is_none_and_sets_invalid_enum() {
        let mut cx = ctx();
        assert_eq!(cx.get_string(glw::GL_VENDOR), None);
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn get_string_through_the_context_trait_forwards_to_the_same_answer() {
        let mut cx = ctx();
        let ctx: &mut dyn Context = &mut cx;
        let extensions = ctx.get_string(glw::GL_EXTENSIONS).unwrap();
        assert!(extensions.split(' ').any(|name| name == "GL_EXT_color_buffer_float"));
    }

    // --- Cube-map texture objects ---

    const CUBE_FACES: [GLenum; 6] = [
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
        glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
        glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
    ];

    #[test]
    fn tex_image_2d_on_a_cube_face_uploads_into_that_face_only() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);

        // Red into +X, green into -X; every other face left unallocated.
        let red: [u8; 4] = [255, 0, 0, 255];
        let green: [u8; 4] = [0, 255, 0, 255];
        cx.tex_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            0,
            glw::GL_RGBA8,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&red),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        cx.tex_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
            0,
            glw::GL_RGBA8,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&green),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_cube(names[0]).unwrap();
        assert_eq!(
            tex.face(0, 0).unwrap().get_const_access().get_pixel(0, 0, 0),
            [1.0, 0.0, 0.0, 1.0],
            "face index 0 (+X) must hold red"
        );
        assert_eq!(
            tex.face(0, 1).unwrap().get_const_access().get_pixel(0, 0, 0),
            [0.0, 1.0, 0.0, 1.0],
            "face index 1 (-X) must hold green"
        );
        assert!(tex.face(0, 2).is_none(), "+Y was never uploaded");
    }

    #[test]
    fn tex_image_2d_on_a_cube_face_without_a_bound_cube_texture_is_invalid_operation() {
        let mut cx = ctx();
        // A GL_TEXTURE_2D binding exists, but nothing is bound to GL_TEXTURE_CUBE_MAP.
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            0,
            glw::GL_RGBA8,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn tex_sub_image_2d_on_a_cube_face_updates_only_that_face() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let blue: [u8; 4] = [0, 0, 255, 255];
        cx.tex_sub_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
            0,
            1,
            1,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            &blue,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_cube(names[0]).unwrap();
        let access = tex.face(0, 4).unwrap().get_const_access(); // +Z is face index 4
        assert_eq!(access.get_pixel(1, 1, 0), [0.0, 0.0, 1.0, 1.0]);
        assert_eq!(
            access.get_pixel(0, 0, 0),
            [0.0, 0.0, 0.0, 1.0],
            "untouched texel must still read the initial-value clear"
        );
    }

    #[test]
    fn texture_cube_is_incomplete_until_all_six_faces_of_level_0_match() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);
        // A non-mipmap min filter, so completeness only needs level 0 of all six faces
        // (see `TextureCube::is_complete`'s own doc comment).
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        for &face in CUBE_FACES[..5].iter() {
            cx.tex_image_2d(
                face,
                0,
                glw::GL_RGBA8,
                2,
                2,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                None,
            );
            assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        }
        assert!(
            !cx.texture_cube(names[0]).unwrap().is_complete(),
            "GL_TEXTURE_CUBE_MAP_NEGATIVE_Z was never uploaded"
        );

        cx.tex_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(
            cx.texture_cube(names[0]).unwrap().is_complete(),
            "every face of level 0 is now present, same 2x2 size/format"
        );
    }

    #[test]
    fn texture_cube_with_a_non_square_face_is_incomplete() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );

        for &face in CUBE_FACES.iter() {
            cx.tex_image_2d(
                face,
                0,
                glw::GL_RGBA8,
                2,
                1,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                None,
            ); // 2x1, not square
            assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        }
        assert!(
            !cx.texture_cube(names[0]).unwrap().is_complete(),
            "upstream's own TextureCube::isComplete rejects a non-square face"
        );
    }

    #[test]
    fn tex_parameteri_on_a_cube_map_applies_to_the_whole_object_not_one_face() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP,
            glw::GL_TEXTURE_WRAP_S,
            glw::GL_CLAMP_TO_EDGE as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        // There is no per-face texParameteri target at all - binding any face target to
        // it must be GL_INVALID_ENUM, confirming the whole-object/per-face distinction.
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            glw::GL_TEXTURE_WRAP_S,
            glw::GL_REPEAT as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn framebuffer_texture2d_attaches_one_cube_face_and_draw_lands_only_there() {
        let mut cx = ctx_with_size(2, 2);

        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex[0]);
        for &face in CUBE_FACES.iter() {
            cx.tex_image_2d(
                face,
                0,
                glw::GL_RGBA8,
                2,
                2,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                None,
            );
        }
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
            tex[0],
            0,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);
        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 0.0, 0.0, 1.0))),
        );
        cx.use_program(program);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let cube = cx.texture_cube(tex[0]).unwrap();
        let positive_y = cube.face(0, 2).unwrap().get_const_access(); // +Y is face index 2
        assert_eq!(
            positive_y.get_pixel(1, 1, 0),
            [1.0, 0.0, 0.0, 1.0],
            "the draw must have landed in the attached +Y face"
        );
        let positive_x = cube.face(0, 0).unwrap().get_const_access();
        assert_eq!(
            positive_x.get_pixel(1, 1, 0),
            [0.0, 0.0, 0.0, 1.0],
            "every other face must be untouched (still the tex_image_2d initial-value clear)"
        );
    }

    #[test]
    fn framebuffer_texture2d_rejects_a_2d_texture_bound_as_a_cube_face_attachment() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        // tex[0] is a Texture2D, not a TextureCube - attaching it via a cube-face
        // textarget must report GL_INVALID_OPERATION, matching upstream's own type
        // check (`TCU_CHECK(texObj->getType() == Texture::TYPE_CUBE_MAP)`).
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            tex[0],
            0,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn deleting_a_cube_map_still_attached_detaches_it_from_the_framebuffer() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, tex[0]);
        for &face in CUBE_FACES.iter() {
            cx.tex_image_2d(
                face,
                0,
                glw::GL_RGBA8,
                2,
                2,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                None,
            );
        }
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            tex[0],
            0,
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, 0);
        cx.delete_textures(&tex);

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        );
    }

    // --- framebufferTextureLayer ---

    #[test]
    fn framebuffer_texture_layer_with_a_2d_texture_is_invalid_operation() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        // A Texture2D is the wrong type for this entry point (only GL_TEXTURE_2D_ARRAY/
        // GL_TEXTURE_3D/GL_TEXTURE_CUBE_MAP_ARRAY are accepted here - see this method's
        // own doc comment), even though the texture itself is otherwise perfectly
        // valid.
        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn framebuffer_texture_layer_with_texture_zero_clears_an_existing_attachment() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture2d(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_TEXTURE_2D,
            tex[0],
            0,
        );
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, 0, 0, 0);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        );
    }

    #[test]
    fn framebuffer_texture_layer_without_a_bound_framebuffer_is_invalid_operation() {
        let mut cx = ctx();
        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, 0, 0, 0);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    // --- GL_TEXTURE_2D_ARRAY texture objects ---

    #[test]
    fn gen_textures_and_bind_2d_array_round_trips() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        assert!(cx.texture_2d_array(names[0]).is_none());
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_2d_array(names[0]).is_some());
        // A 2D-array name must not also read back as a Texture2D or a TextureCube.
        assert!(cx.texture(names[0]).is_none());
        assert!(cx.texture_cube(names[0]).is_none());
    }

    #[test]
    fn binding_a_2d_texture_name_as_2d_array_is_invalid_operation() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
        assert!(cx.texture(names[0]).is_some());
        assert!(cx.texture_2d_array(names[0]).is_none());
    }

    #[test]
    fn tex_image_3d_on_a_2d_array_uploads_into_the_right_layer() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);

        // 1x1 RGBA8, two layers: red into layer 0, green into layer 1.
        let data: [u8; 8] = [255, 0, 0, 255, 0, 255, 0, 255];
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_2d_array(names[0]).unwrap();
        let full = tex.level(0).unwrap().get_const_access();
        assert_eq!(full.get_pixel(0, 0, 0), [1.0, 0.0, 0.0, 1.0], "layer 0 must hold red");
        assert_eq!(full.get_pixel(0, 0, 1), [0.0, 1.0, 0.0, 1.0], "layer 1 must hold green");
    }

    #[test]
    fn tex_image_3d_without_a_bound_2d_array_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn tex_image_3d_with_an_unsupported_target_is_invalid_enum() {
        let mut cx = ctx();
        // GL_TEXTURE_2D is a real target, just not one texImage3D ever accepts -
        // texImage2D is the entry point for it. GL_TEXTURE_2D_ARRAY/_3D/
        // _CUBE_MAP_ARRAY are no longer examples of an unsupported target here - see
        // the dedicated upload tests for each below.
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn tex_sub_image_3d_updates_only_the_given_box_in_one_layer() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let blue: [u8; 4] = [0, 0, 255, 255];
        cx.tex_sub_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            1,
            1,
            1,
            1,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            &blue,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_2d_array(names[0]).unwrap();
        let full = tex.level(0).unwrap().get_const_access();
        assert_eq!(full.get_pixel(1, 1, 1), [0.0, 0.0, 1.0, 1.0]);
        assert_eq!(
            full.get_pixel(0, 0, 1),
            [0.0, 0.0, 0.0, 1.0],
            "untouched texel in the same layer must still read the initial-value clear"
        );
        assert_eq!(
            full.get_pixel(1, 1, 0),
            [0.0, 0.0, 0.0, 1.0],
            "layer 0 must be completely untouched"
        );
    }

    #[test]
    fn tex_image_3d_honours_unpack_image_height_and_skip_images() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);

        // A virtual source with GL_UNPACK_IMAGE_HEIGHT = 3 (not the real height, 2) and
        // GL_UNPACK_SKIP_IMAGES = 1 (skip one whole 3-row image before the real one).
        cx.pixel_storei(glw::GL_UNPACK_IMAGE_HEIGHT, 3);
        cx.pixel_storei(glw::GL_UNPACK_SKIP_IMAGES, 1);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        #[rustfmt::skip]
        let data: [u8; 40] = [
            // Skipped image (GL_UNPACK_SKIP_IMAGES = 1), 3 rows * 8 bytes/row = 24
            // bytes. The first two rows are garbage a correct read never reaches; the
            // third exists only because GL_UNPACK_IMAGE_HEIGHT says the skipped image
            // is 3 rows tall, not 2 - a reader that defaulted image height to the real
            // height (2) would read these bytes as the first row of real data instead.
            0xFF, 0xFF, 0xFF, 0xFF,  0xFF, 0xFF, 0xFF, 0xFF,
            0xFF, 0xFF, 0xFF, 0xFF,  0xFF, 0xFF, 0xFF, 0xFF,
            0xEE, 0xEE, 0xEE, 0xEE,  0xEE, 0xEE, 0xEE, 0xEE,
            // The real 2x2 image.
            1, 2, 3, 4,     5, 6, 7, 8,
            9, 10, 11, 12,  13, 14, 15, 16,
        ];
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_2d_array(names[0]).unwrap();
        let full = tex.level(0).unwrap().get_const_access();
        assert_eq!(
            full.get_pixel(0, 0, 0),
            [1.0 / 255.0, 2.0 / 255.0, 3.0 / 255.0, 4.0 / 255.0]
        );
        assert_eq!(
            full.get_pixel(1, 1, 0),
            [13.0 / 255.0, 14.0 / 255.0, 15.0 / 255.0, 16.0 / 255.0]
        );
    }

    #[test]
    fn texture_2d_array_is_incomplete_until_every_level_and_layer_count_matches() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);
        cx.tex_parameteri(
            glw::GL_TEXTURE_2D_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST_MIPMAP_NEAREST as i32,
        );

        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            3,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(
            !cx.texture_2d_array(names[0]).unwrap().is_complete(),
            "level 1 (1x1) was never uploaded"
        );

        // Level 1 with the WRONG layer count (2, not 3) must still be incomplete.
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            glw::GL_RGBA8,
            1,
            1,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(
            !cx.texture_2d_array(names[0]).unwrap().is_complete(),
            "level 1's layer count (2) disagrees with level 0's (3)"
        );

        // Re-upload level 1 with the matching layer count (3) - now complete.
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            1,
            glw::GL_RGBA8,
            1,
            1,
            3,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_2d_array(names[0]).unwrap().is_complete());
    }

    #[test]
    fn tex_parameteri_on_a_2d_array_validates_values_and_updates_its_own_sampler_state() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);

        cx.tex_parameteri(glw::GL_TEXTURE_2D_ARRAY, glw::GL_TEXTURE_WRAP_S, 0xDEAD);
        assert_eq!(
            cx.get_error(),
            glw::GL_INVALID_VALUE,
            "an unmappable wrap mode must still be rejected for this target"
        );

        cx.tex_parameteri(
            glw::GL_TEXTURE_2D_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        // A non-mipmap min filter plus a present level 0 must now be complete - this
        // only passes if tex_parameteri actually wrote into *this* Texture2DArray's own
        // sampler field, not some other object's.
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert!(cx.texture_2d_array(names[0]).unwrap().is_complete());
    }

    #[test]
    fn framebuffer_texture_layer_attaches_one_array_layer_and_draw_lands_only_there() {
        let mut cx = ctx_with_size(2, 2);

        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, tex[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, 1);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);
        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 0.0, 0.0, 1.0))),
        );
        cx.use_program(program);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex_obj = cx.texture_2d_array(tex[0]).unwrap();
        let full = tex_obj.level(0).unwrap().get_const_access();
        assert_eq!(
            full.get_pixel(1, 1, 1),
            [1.0, 0.0, 0.0, 1.0],
            "the draw must have landed in the attached layer 1"
        );
        assert_eq!(
            full.get_pixel(1, 1, 0),
            [0.0, 0.0, 0.0, 1.0],
            "layer 0 must be untouched (still the tex_image_3d initial-value clear)"
        );
    }

    #[test]
    fn framebuffer_texture_layer_with_a_negative_layer_is_invalid_value() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, tex[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, -1);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    #[test]
    fn deleting_a_2d_array_still_attached_via_layer_detaches_it_from_the_framebuffer() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, tex[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, 1);
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, 0);
        cx.delete_textures(&tex);

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        );
    }

    // --- GL_TEXTURE_3D texture objects ---

    #[test]
    fn gen_textures_and_bind_3d_round_trips() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        assert!(cx.texture_3d(names[0]).is_none());
        cx.bind_texture(glw::GL_TEXTURE_3D, names[0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_3d(names[0]).is_some());
        // A 3D name must not also read back as any of the other three kinds.
        assert!(cx.texture(names[0]).is_none());
        assert!(cx.texture_cube(names[0]).is_none());
        assert!(cx.texture_2d_array(names[0]).is_none());
    }

    #[test]
    fn binding_a_2d_texture_name_as_3d_is_invalid_operation() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        cx.bind_texture(glw::GL_TEXTURE_3D, names[0]);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
        assert!(cx.texture(names[0]).is_some());
        assert!(cx.texture_3d(names[0]).is_none());
    }

    #[test]
    fn tex_image_3d_on_a_3d_texture_uploads_into_the_right_z_slice() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_3D, names[0]);

        // 1x1 RGBA8, two z-slices: red into z=0, green into z=1.
        let data: [u8; 8] = [255, 0, 0, 255, 0, 255, 0, 255];
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            1,
            1,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_3d(names[0]).unwrap();
        let full = tex.level(0).unwrap().get_const_access();
        assert_eq!(full.get_pixel(0, 0, 0), [1.0, 0.0, 0.0, 1.0], "z=0 must hold red");
        assert_eq!(full.get_pixel(0, 0, 1), [0.0, 1.0, 0.0, 1.0], "z=1 must hold green");
    }

    #[test]
    fn tex_image_3d_without_a_bound_3d_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn tex_sub_image_3d_on_a_3d_texture_updates_only_the_given_box() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_3D, names[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let blue: [u8; 4] = [0, 0, 255, 255];
        cx.tex_sub_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            1,
            1,
            1,
            1,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            &blue,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_3d(names[0]).unwrap();
        let full = tex.level(0).unwrap().get_const_access();
        assert_eq!(full.get_pixel(1, 1, 1), [0.0, 0.0, 1.0, 1.0]);
        assert_eq!(
            full.get_pixel(0, 0, 1),
            [0.0, 0.0, 0.0, 1.0],
            "untouched texel in the same z-slice must still read the initial-value clear"
        );
        assert_eq!(
            full.get_pixel(1, 1, 0),
            [0.0, 0.0, 0.0, 1.0],
            "z=0 must be completely untouched"
        );
    }

    #[test]
    fn texture_3d_is_incomplete_until_every_level_depth_is_correctly_halved() {
        // Base level 1x1x4: num_mip_levels_3d(1, 1, 4) = 3 (levels 0: depth 4, 1: depth
        // 2, 2: depth 1) - width/height are already 1 throughout, so this exercises
        // only Texture3D::is_complete's own depth-halving logic (the one real
        // difference from Texture2DArray::is_complete, where the third dimension is a
        // fixed layer count instead).
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_3D, names[0]);
        cx.tex_parameteri(
            glw::GL_TEXTURE_3D,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST_MIPMAP_NEAREST as i32,
        );

        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            1,
            1,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(
            !cx.texture_3d(names[0]).unwrap().is_complete(),
            "levels 1 (depth 2) and 2 (depth 1) were never uploaded"
        );

        // Level 1 with the WRONG depth (3, not the expected 2) must still be incomplete.
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            1,
            glw::GL_RGBA8,
            1,
            1,
            3,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(
            !cx.texture_3d(names[0]).unwrap().is_complete(),
            "level 1's depth (3) disagrees with the expected halving of level 0's (4 -> 2)"
        );

        // Re-upload level 1 with the correctly halved depth (2) - level 2 is still missing.
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            1,
            glw::GL_RGBA8,
            1,
            1,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(
            !cx.texture_3d(names[0]).unwrap().is_complete(),
            "level 2 (depth 1) was never uploaded"
        );

        // Level 2, depth correctly halved down to 1 - now complete.
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            2,
            glw::GL_RGBA8,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_3d(names[0]).unwrap().is_complete());
    }

    #[test]
    fn tex_parameteri_on_a_3d_texture_validates_values_and_updates_its_own_sampler_state() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_3D, names[0]);

        cx.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_S, 0xDEAD);
        assert_eq!(
            cx.get_error(),
            glw::GL_INVALID_VALUE,
            "an unmappable wrap mode must still be rejected for this target"
        );

        cx.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        // A non-mipmap min filter plus a present level 0 must now be complete - this
        // only passes if tex_parameteri actually wrote into *this* Texture3D's own
        // sampler field, not some other object's.
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert!(cx.texture_3d(names[0]).unwrap().is_complete());
    }

    #[test]
    fn framebuffer_texture_layer_attaches_one_z_slice_and_draw_lands_only_there() {
        let mut cx = ctx_with_size(2, 2);

        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_3D, tex[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, 1);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);
        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 0.0, 0.0, 1.0))),
        );
        cx.use_program(program);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex_obj = cx.texture_3d(tex[0]).unwrap();
        let full = tex_obj.level(0).unwrap().get_const_access();
        assert_eq!(
            full.get_pixel(1, 1, 1),
            [1.0, 0.0, 0.0, 1.0],
            "the draw must have landed in the attached z-slice 1"
        );
        assert_eq!(
            full.get_pixel(1, 1, 0),
            [0.0, 0.0, 0.0, 1.0],
            "z=0 must be untouched (still the tex_image_3d initial-value clear)"
        );
    }

    #[test]
    fn framebuffer_texture_layer_with_a_3d_texture_and_negative_layer_is_invalid_value() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_3D, tex[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            1,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, -1);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    #[test]
    fn deleting_a_3d_texture_still_attached_via_layer_detaches_it_from_the_framebuffer() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_3D, tex[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, 1);
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        cx.bind_texture(glw::GL_TEXTURE_3D, 0);
        cx.delete_textures(&tex);

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        );
    }

    // --- GL_TEXTURE_CUBE_MAP_ARRAY texture objects ---

    #[test]
    fn gen_textures_and_bind_cube_array_round_trips() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        assert!(cx.texture_cube_array(names[0]).is_none());
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_cube_array(names[0]).is_some());
        // A cube-array name must not also read back as any of the other four kinds.
        assert!(cx.texture(names[0]).is_none());
        assert!(cx.texture_cube(names[0]).is_none());
        assert!(cx.texture_2d_array(names[0]).is_none());
        assert!(cx.texture_3d(names[0]).is_none());
    }

    #[test]
    fn binding_a_2d_texture_name_as_cube_array_is_invalid_operation() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
        assert!(cx.texture(names[0]).is_some());
        assert!(cx.texture_cube_array(names[0]).is_none());
    }

    #[test]
    fn tex_image_3d_on_a_cube_array_uploads_into_the_right_layer_face() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);

        // 1x1 RGBA8, one array layer (6 faces): red into face index 0, green into face
        // index 5 - proving the flattened `arrayLayer * 6 + face` index is read/written
        // without any cube-specific unpacking (see TextureCubeArray's own doc comment).
        let mut data = [0u8; 24];
        data[0..4].copy_from_slice(&[255, 0, 0, 255]);
        data[20..24].copy_from_slice(&[0, 255, 0, 255]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_cube_array(names[0]).unwrap();
        let full = tex.level(0).unwrap().get_const_access();
        assert_eq!(full.get_pixel(0, 0, 0), [1.0, 0.0, 0.0, 1.0], "face 0 must hold red");
        assert_eq!(full.get_pixel(0, 0, 5), [0.0, 1.0, 0.0, 1.0], "face 5 must hold green");
    }

    #[test]
    fn tex_image_3d_without_a_bound_cube_array_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn tex_image_3d_on_a_cube_array_with_mismatched_width_and_height_is_invalid_value() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            1,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
        assert!(
            cx.texture_cube_array(names[0]).unwrap().level(0).is_none(),
            "a rejected upload must not allocate storage"
        );
    }

    #[test]
    fn tex_image_3d_on_a_cube_array_with_a_layer_count_not_a_multiple_of_6_is_invalid_value() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            7,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
        assert!(
            cx.texture_cube_array(names[0]).unwrap().level(0).is_none(),
            "a rejected upload must not allocate storage"
        );
    }

    #[test]
    fn tex_sub_image_3d_on_a_cube_array_updates_only_the_given_box() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let blue: [u8; 4] = [0, 0, 255, 255];
        cx.tex_sub_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            1,
            1,
            1,
            1,
            1,
            1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            &blue,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_cube_array(names[0]).unwrap();
        let full = tex.level(0).unwrap().get_const_access();
        assert_eq!(full.get_pixel(1, 1, 1), [0.0, 0.0, 1.0, 1.0]);
        assert_eq!(
            full.get_pixel(0, 0, 1),
            [0.0, 0.0, 0.0, 1.0],
            "untouched texel on the same face must still read the initial-value clear"
        );
        assert_eq!(
            full.get_pixel(1, 1, 0),
            [0.0, 0.0, 0.0, 1.0],
            "face 0 must be completely untouched"
        );
    }

    #[test]
    fn texture_cube_array_is_incomplete_until_every_level_and_layer_count_matches() {
        // Base level 2x2 (6 faces, 1 array layer): num_mip_levels_2d(2, 2) = 2 (level 0:
        // 2x2, level 1: 1x1) - the layer count (6) must stay fixed across both levels,
        // exactly the `Texture2DArray::is_complete` shape TextureCubeArray's own doc
        // comment says this reuses verbatim.
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);
        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST_MIPMAP_NEAREST as i32,
        );

        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(
            !cx.texture_cube_array(names[0]).unwrap().is_complete(),
            "level 1 (1x1) was never uploaded"
        );

        // Level 1 with the WRONG layer count (12, not 6) must still be incomplete.
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            1,
            glw::GL_RGBA8,
            1,
            1,
            12,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(
            !cx.texture_cube_array(names[0]).unwrap().is_complete(),
            "level 1's layer count (12) disagrees with level 0's (6)"
        );

        // Re-upload level 1 with the matching layer count (6) - now complete.
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            1,
            glw::GL_RGBA8,
            1,
            1,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert!(cx.texture_cube_array(names[0]).unwrap().is_complete());
    }

    #[test]
    fn tex_parameteri_on_a_cube_array_validates_values_and_updates_its_own_sampler_state() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);

        cx.tex_parameteri(glw::GL_TEXTURE_CUBE_MAP_ARRAY, glw::GL_TEXTURE_WRAP_S, 0xDEAD);
        assert_eq!(
            cx.get_error(),
            glw::GL_INVALID_VALUE,
            "an unmappable wrap mode must still be rejected for this target"
        );

        cx.tex_parameteri(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            glw::GL_TEXTURE_MIN_FILTER,
            glw::GL_NEAREST as i32,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        // A non-mipmap min filter plus a present level 0 must now be complete - this
        // only passes if tex_parameteri actually wrote into *this* TextureCubeArray's
        // own sampler field, not some other object's.
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert!(cx.texture_cube_array(names[0]).unwrap().is_complete());
    }

    #[test]
    fn framebuffer_texture_layer_attaches_one_cube_array_face_and_draw_lands_only_there() {
        let mut cx = ctx_with_size(2, 2);

        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, tex[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, 1);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        make_quad_buffer(&mut cx);
        cx.vertex_attrib_pointer(0, 4, glw::GL_FLOAT, false, 0, 0, false);
        cx.enable_vertex_attrib_array(0);
        let program = cx.create_program(
            Box::new(PassthroughVertexShader::new()),
            Box::new(ConstantColorFragmentShader::new(Vec4::new(1.0, 0.0, 0.0, 1.0))),
        );
        cx.use_program(program);
        cx.draw_arrays(glw::GL_TRIANGLES, 0, 3);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex_obj = cx.texture_cube_array(tex[0]).unwrap();
        let full = tex_obj.level(0).unwrap().get_const_access();
        assert_eq!(
            full.get_pixel(1, 1, 1),
            [1.0, 0.0, 0.0, 1.0],
            "the draw must have landed in the attached face index 1"
        );
        assert_eq!(
            full.get_pixel(1, 1, 0),
            [0.0, 0.0, 0.0, 1.0],
            "face 0 must be untouched (still the tex_image_3d initial-value clear)"
        );
    }

    #[test]
    fn framebuffer_texture_layer_with_a_cube_array_texture_and_negative_layer_is_invalid_value() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, tex[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            1,
            1,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );

        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, -1);
        assert_eq!(cx.get_error(), glw::GL_INVALID_VALUE);
    }

    #[test]
    fn deleting_a_cube_array_texture_still_attached_via_layer_detaches_it_from_the_framebuffer() {
        let mut cx = ctx();
        let mut fbo = [0u32];
        cx.gen_framebuffers(&mut fbo);
        cx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);

        let mut tex = [0u32];
        cx.gen_textures(&mut tex);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, tex[0]);
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        cx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex[0], 0, 1);
        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_COMPLETE
        );

        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, 0);
        cx.delete_textures(&tex);

        assert_eq!(
            cx.check_framebuffer_status(glw::GL_FRAMEBUFFER),
            glw::GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        );
    }

    // --- glGenerateMipmap ---

    #[test]
    fn generate_mipmap_without_a_bound_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.generate_mipmap(glw::GL_TEXTURE_2D);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_without_level_0_is_invalid_operation() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        cx.generate_mipmap(glw::GL_TEXTURE_2D);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_with_an_unsupported_target_is_invalid_enum() {
        let mut cx = ctx();
        // GL_TEXTURE_1D has no backing object type here at all (see this module's top
        // doc comment) - generate_mipmap now covers every texture type this port
        // backs, so GL_TEXTURE_1D is the only target left that is genuinely invalid
        // here, the same way it already is for bind_texture/tex_parameteri above.
        cx.generate_mipmap(glw::GL_TEXTURE_1D);
        assert_eq!(cx.get_error(), glw::GL_INVALID_ENUM);
    }

    #[test]
    fn generate_mipmap_builds_an_exact_box_filtered_pyramid() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);

        // A 4x4 RGBA8 base level built from four uniform 2x2 quadrants (red/green/blue/
        // black) - chosen so every downsample step averages either four identical
        // values (level 0 -> level 1, bit-exact) or four exact 0/1 values whose
        // RGBA8-rounded average is hand-computable (level 1 -> level 2).
        #[rustfmt::skip]
        let data: [u8; 64] = [
            255, 0, 0, 255,   255, 0, 0, 255,   0, 255, 0, 255,   0, 255, 0, 255,
            255, 0, 0, 255,   255, 0, 0, 255,   0, 255, 0, 255,   0, 255, 0, 255,
            0, 0, 255, 255,   0, 0, 255, 255,   0, 0, 0, 255,     0, 0, 0, 255,
            0, 0, 255, 255,   0, 0, 255, 255,   0, 0, 0, 255,     0, 0, 0, 255,
        ];
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            4,
            4,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.generate_mipmap(glw::GL_TEXTURE_2D);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture(names[0]).unwrap();

        // Level 1 (2x2): each texel averages one uniform quadrant, bit-exact.
        let level1 = tex.level(1).unwrap();
        assert_eq!(level1.size(), [2, 2, 1]);
        let level1_access = level1.get_const_access();
        assert_eq!(
            level1_access.get_pixel(0, 0, 0),
            [1.0, 0.0, 0.0, 1.0],
            "top-left quadrant must downsample to exact red"
        );
        assert_eq!(
            level1_access.get_pixel(1, 0, 0),
            [0.0, 1.0, 0.0, 1.0],
            "top-right quadrant must downsample to exact green"
        );
        assert_eq!(
            level1_access.get_pixel(0, 1, 0),
            [0.0, 0.0, 1.0, 1.0],
            "bottom-left quadrant must downsample to exact blue"
        );
        assert_eq!(
            level1_access.get_pixel(1, 1, 0),
            [0.0, 0.0, 0.0, 1.0],
            "bottom-right quadrant must downsample to exact black"
        );

        // Level 2 (1x1): averages all four level-1 texels (red+green+blue+black)/4 =
        // 0.25 in R, G and B, which round-to-nearest-even to RGBA8 byte 64 (0.25*255 =
        // 63.75, rounds up since the fraction exceeds 0.5) - 64/255 read back, not a
        // bare 0.25.
        let level2 = tex.level(2).unwrap();
        assert_eq!(level2.size(), [1, 1, 1]);
        let expected_rgb = 64.0 / 255.0;
        assert_eq!(
            level2.get_const_access().get_pixel(0, 0, 0),
            [expected_rgb, expected_rgb, expected_rgb, 1.0]
        );

        assert!(
            tex.level(3).is_none(),
            "a 4x4 base level has only 3 mip levels (4x4, 2x2, 1x1)"
        );
    }

    #[test]
    fn generate_mipmap_overwrites_a_previously_uploaded_level() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D, names[0]);
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            None,
        );
        // Level 1 would ordinarily be 1x1; pre-seed it with a value the real downsample
        // would never produce (level 0 was cleared to the texture-initial-value, all
        // zero/opaque-black, so a real level 1 must come out black too) - proving
        // generate_mipmap really overwrites rather than leaving an existing level alone.
        cx.tex_image_2d(
            glw::GL_TEXTURE_2D,
            1,
            glw::GL_RGBA8,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&[255, 255, 255, 255]),
        );
        assert_eq!(
            cx.texture(names[0])
                .unwrap()
                .level(1)
                .unwrap()
                .get_const_access()
                .get_pixel(0, 0, 0),
            [1.0, 1.0, 1.0, 1.0]
        );

        cx.generate_mipmap(glw::GL_TEXTURE_2D);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        assert_eq!(
            cx.texture(names[0])
                .unwrap()
                .level(1)
                .unwrap()
                .get_const_access()
                .get_pixel(0, 0, 0),
            [0.0, 0.0, 0.0, 1.0],
            "generate_mipmap must overwrite the stale hand-uploaded level 1 with a real downsample of level 0"
        );
    }

    #[test]
    fn generate_mipmap_on_a_cube_map_without_a_bound_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_on_a_cube_map_without_face_0_of_level_0_is_invalid_operation() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);
        // Every face except +X (face index 0, the existence probe generate_mipmap
        // itself uses - see its own doc comment).
        let red: [u8; 4] = [255, 0, 0, 255];
        cx.tex_image_2d(
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
            0,
            glw::GL_RGBA8,
            1,
            1,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&red),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_on_a_cube_map_downsamples_each_face_independently() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP, names[0]);

        // Six uniform 2x2 faces, each its own colour, so generate_mipmap's level 1
        // (1x1 per face) has an exact, hand-computable expectation per face - and any
        // cross-face blending bug would show up as a wrong colour rather than merely a
        // plausible-looking one.
        let colors: [([u8; 4], GLenum); 6] = [
            ([255, 0, 0, 255], glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X),
            ([0, 255, 0, 255], glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X),
            ([0, 0, 255, 255], glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y),
            ([255, 255, 0, 255], glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y),
            ([255, 0, 255, 255], glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z),
            ([0, 255, 255, 255], glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z),
        ];
        for (color, face_target) in colors {
            let data = color.repeat(4);
            cx.tex_image_2d(
                face_target,
                0,
                glw::GL_RGBA8,
                2,
                2,
                0,
                glw::GL_RGBA,
                glw::GL_UNSIGNED_BYTE,
                Some(&data),
            );
            assert_eq!(cx.get_error(), glw::GL_NO_ERROR);
        }

        cx.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_cube(names[0]).unwrap();
        let expected: [[f32; 4]; 6] = [
            [1.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 1.0, 1.0],
        ];
        for (face_index, &expected_color) in expected.iter().enumerate() {
            let level1 = tex.face(1, face_index).unwrap();
            assert_eq!(level1.size(), [1, 1, 1]);
            assert_eq!(
                level1.get_const_access().get_pixel(0, 0, 0),
                expected_color,
                "face {face_index} must downsample to its own uniform colour, not blended with any neighbour"
            );
        }
    }

    #[test]
    fn generate_mipmap_on_a_2d_array_without_a_bound_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.generate_mipmap(glw::GL_TEXTURE_2D_ARRAY);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_on_a_2d_array_without_level_0_is_invalid_operation() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);
        cx.generate_mipmap(glw::GL_TEXTURE_2D_ARRAY);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_on_a_2d_array_downsamples_each_layer_independently() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_2D_ARRAY, names[0]);

        // 2x2, two layers: layer 0 uniform red, layer 1 uniform green - chosen so a
        // level 1 (1x1x2) that blended across layers would show up as a wrong colour
        // rather than a merely plausible-looking one.
        #[rustfmt::skip]
        let data: [u8; 32] = [
            255, 0, 0, 255,   255, 0, 0, 255,   255, 0, 0, 255,   255, 0, 0, 255,
            0, 255, 0, 255,   0, 255, 0, 255,   0, 255, 0, 255,   0, 255, 0, 255,
        ];
        cx.tex_image_3d(
            glw::GL_TEXTURE_2D_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.generate_mipmap(glw::GL_TEXTURE_2D_ARRAY);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_2d_array(names[0]).unwrap();
        let level1 = tex.level(1).unwrap();
        assert_eq!(level1.size(), [1, 1, 2]);
        let level1_access = level1.get_const_access();
        assert_eq!(
            level1_access.get_pixel(0, 0, 0),
            [1.0, 0.0, 0.0, 1.0],
            "layer 0 must downsample to exact red, not blended with layer 1"
        );
        assert_eq!(
            level1_access.get_pixel(0, 0, 1),
            [0.0, 1.0, 0.0, 1.0],
            "layer 1 must downsample to exact green, not blended with layer 0"
        );
    }

    #[test]
    fn generate_mipmap_on_a_3d_texture_without_a_bound_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.generate_mipmap(glw::GL_TEXTURE_3D);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_on_a_3d_texture_without_level_0_is_invalid_operation() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_3D, names[0]);
        cx.generate_mipmap(glw::GL_TEXTURE_3D);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_on_a_3d_texture_downsamples_across_all_three_axes() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_3D, names[0]);

        // 2x2x2, z=0 slice uniform red, z=1 slice uniform black - level 1 (1x1x1)
        // averages all 8 corners at once (unlike GL_TEXTURE_2D_ARRAY, which never
        // blends across its own third dimension), so R averages (4*1.0 + 4*0.0) / 8 =
        // 0.5 exactly. 0.5*255 = 127.5 is an exact tie, and convertSatRte rounds ties to
        // even: 127 is odd, so it rounds up to 128 - not 127, and not a bare 0.5 when
        // read back (128/255 = 0.5019..., not 0.5).
        #[rustfmt::skip]
        let data: [u8; 32] = [
            255, 0, 0, 255,   255, 0, 0, 255,   255, 0, 0, 255,   255, 0, 0, 255,
            0, 0, 0, 255,     0, 0, 0, 255,      0, 0, 0, 255,     0, 0, 0, 255,
        ];
        cx.tex_image_3d(
            glw::GL_TEXTURE_3D,
            0,
            glw::GL_RGBA8,
            2,
            2,
            2,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.generate_mipmap(glw::GL_TEXTURE_3D);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_3d(names[0]).unwrap();
        let level1 = tex.level(1).unwrap();
        assert_eq!(level1.size(), [1, 1, 1]);
        let expected_r = 128.0 / 255.0;
        assert_eq!(
            level1.get_const_access().get_pixel(0, 0, 0),
            [expected_r, 0.0, 0.0, 1.0]
        );
    }

    #[test]
    fn generate_mipmap_on_a_cube_array_without_a_bound_texture_is_invalid_operation() {
        let mut cx = ctx();
        cx.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP_ARRAY);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_on_a_cube_array_without_level_0_is_invalid_operation() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);
        cx.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP_ARRAY);
        assert_eq!(cx.get_error(), glw::GL_INVALID_OPERATION);
    }

    #[test]
    fn generate_mipmap_on_a_cube_array_downsamples_each_face_layer_independently() {
        let mut cx = ctx();
        let mut names = [0u32];
        cx.gen_textures(&mut names);
        cx.bind_texture(glw::GL_TEXTURE_CUBE_MAP_ARRAY, names[0]);

        // 2x2, one array layer (6 faces): each face its own uniform colour, so level 1
        // (1x1x6) has an exact, hand-computable expectation per face-layer index - and
        // any blending across the flattened arrayLayer*6+face index would show up as a
        // wrong colour rather than a merely plausible-looking one.
        let colors: [[u8; 4]; 6] = [
            [255, 0, 0, 255],
            [0, 255, 0, 255],
            [0, 0, 255, 255],
            [255, 255, 0, 255],
            [255, 0, 255, 255],
            [0, 255, 255, 255],
        ];
        let mut data = Vec::new();
        for color in colors {
            data.extend_from_slice(&color.repeat(4));
        }
        cx.tex_image_3d(
            glw::GL_TEXTURE_CUBE_MAP_ARRAY,
            0,
            glw::GL_RGBA8,
            2,
            2,
            6,
            0,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_BYTE,
            Some(&data),
        );
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        cx.generate_mipmap(glw::GL_TEXTURE_CUBE_MAP_ARRAY);
        assert_eq!(cx.get_error(), glw::GL_NO_ERROR);

        let tex = cx.texture_cube_array(names[0]).unwrap();
        let level1 = tex.level(1).unwrap();
        assert_eq!(level1.size(), [1, 1, 6]);
        let level1_access = level1.get_const_access();
        let expected: [[f32; 4]; 6] = [
            [1.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 1.0, 1.0],
        ];
        for (face_index, &expected_color) in expected.iter().enumerate() {
            assert_eq!(
                level1_access.get_pixel(0, 0, face_index as u32),
                expected_color,
                "face-layer index {face_index} must downsample to its own uniform colour, not blended with any neighbour"
            );
        }
    }
}
