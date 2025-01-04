// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluTextureTestUtil.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `glu::TextureTestUtil` is 380 (header) + 3662 (source) lines: the shared
// reference-sampling engine `shaders.texture_functions`, `shaders.builtin_functions`'
// texture half and the (separately gated) `texture.*` root all build their expected
// images through. It supports every texture type GL has (1D/2D/3D/cube/array/
// cube-array/buffer), every sampler shape (float/int/uint/shadow/texel-fetch) and both
// the plain and perspective-projected quad shapes a GLSL `textureProj` call needs.
//
// This port covers only the 2D, float-sampler, non-mipmapped-or-level-array slice that
// a first consumer needs, chosen to be exactly what `tcu::pixel::sample_2d_mipmap`
// (already ported, see its own doc comment on `mipmap_level`'s narrowing) can answer:
//  - `TextureType`/`SamplerType`/`LodMode` - the full upstream enums, kept whole even
//    though most variants are unused yet, since matching a case name against one of
//    them is how a future port picks the right `sampleTexture` overload to add next,
//  - `RenderParams`/`ReferenceParams`, narrowed to the fields the 2D float path reads
//    (`sampler`, `lod_mode`, `min_lod`/`max_lod`, `base_level`/`max_level`, plus
//    `RenderParams`' own `tex_type`/`sampler_type`/`flags`/`w`/`bias`/`color_scale`/
//    `color_bias`) - `unnormal`/`float16_tex_coord`/the `ImageViewMinLod*` trio/
//    `lod_texel_fetch` are all upstream fields this slice never reads and are left out
//    rather than guessed at, matching `shader_render_case.rs`'s own `TextureBinding`
//    precedent,
//  - the LOD math in full for 1D/2D/3D (`compute_lod_from_derivates_*`,
//    `compute_non_projected_tri_lod_*`) - cheap, pure, and every later texture type
//    needs exactly this, not a 2D-only subset,
//  - the projected (`textureProj`) triangle derivative math for 2D only
//    (`tri_derivate_x`/`tri_derivate_y`/`projected_tri_interpolate`/
//    `compute_projected_tri_lod_2d`) - the 1D/3D siblings are the same shape and are
//    left for whichever future port needs them first,
//  - `compute_quad_tex_coord_1d`/`_2d`/`_2d_array`/`_3d` - cube-array is not ported,
//  - `sample_texture_2d` - given a texture's mip levels, a quad's texture coordinates
//    and a `ReferenceParams`, fills a destination buffer the same way upstream's two
//    `sampleTexture(..., Texture2DView, ...)` overloads do. `SAMPLERTYPE_FLOAT`/`INT`/
//    `UINT`/`SHADOW` are all handled (`exec_sample_2d` panics on the remaining
//    `FETCH_*` variants) - see that function's own doc comment for why `FLOAT`/`INT`/
//    `UINT` need no extra code here at all (the raw-integer decode already lives in
//    `tcu::pixel::ConstPixelBufferAccess::get_pixel`) while `SHADOW` needed a
//    genuinely new `tcu::pixel::Sampler::compare`/`sample_2d_mipmap_compare` piece,
//    added alongside this,
//  - `sample_texture_cube` - the `TextureCubeView` counterpart (upstream has no
//    separate projected form for cube at all), backed by the already-ported
//    `tcu::pixel::sample_cube_mipmap`/`select_cube_face` plus a new
//    `compute_cube_lod_from_derivates` (recovering the in-face derivatives from a
//    direction vector's own derivative, by the quotient rule on `project_to_face`'s
//    formula). `SAMPLERTYPE_FLOAT`/`INT`/`UINT`/`SHADOW` are all handled now -
//    `tcu::pixel::sample_cube_mipmap_compare` (the cube-shadow counterpart of
//    `sample_2d_mipmap_compare`, ported alongside this) closes the gap this doc
//    comment used to flag.
//  - `sample_texture_3d` - the `Texture3DView` counterpart, **non-projected only**: no
//    grep-confirmed caller (`es3fTextureFilteringTests.cpp`'s `Texture3DFilteringCase`)
//    ever sets `ReferenceParams::PROJECTED` for a `TEXTURETYPE_3D` case, so the
//    projected overload upstream does have is deliberately not ported (asserted against
//    rather than silently producing the wrong image - see that function's own doc
//    comment). `SAMPLERTYPE_FLOAT`/`INT`/`UINT` only; `Texture3DView` has no
//    `sampleCompare` at all upstream (no 3D shadow sampler exists in GLSL), so there is
//    no `SHADOW` arm to add, unlike `exec_sample_2d`/`exec_sample_cube`.
//  - `sample_texture_2d_array` - the `Texture2DArrayView` counterpart, **non-projected
//    only**: upstream's own `sampleTexture(..., Texture2DArrayView, ...)` has a literal
//    `DE_ASSERT(!(params.flags & ReferenceParams::PROJECTED))` with a "\todo Support
//    projected lookups" right next to it - there is no projected overload to port here
//    at all, unlike `Texture3DView`'s (which exists but is simply unreached).
//    `SAMPLERTYPE_FLOAT`/`INT`/`UINT`/`SHADOW` are all handled - `Texture2DArrayView`
//    genuinely has a `sampleCompare` (confirmed directly, the opposite of
//    `Texture3DView`), backed by the new `tcu::pixel::sample_2d_array_mipmap_compare`.
//
// `exec_sample_2d`/`_2d_array`/`_cube`/`_3d` each dispatch on `params.sampler.mip_filter`
// (`Some(mode)` -> the `tcu::pixel::sample_*_mipmap_filtered` sibling, `None` -> the
// plain, single-level-pick `sample_*_mipmap` every caller used before this field
// existed) - this is what makes the trilinear/mipmap-blend machinery
// `tcu::pixel::sample_2d_mipmap_filtered` and friends added (`texture.mipmap`'s own
// gap, see `Sampler`'s own doc comment in `tcu::pixel`) actually reachable from a
// `ReferenceParams` built here, rather than only from a direct `tcu::pixel` call.
// `SamplerType::Shadow` gets the same dispatch now too, through `tcu::pixel::
// sample_2d_mipmap_compare_filtered`/`sample_2d_array_mipmap_compare_filtered`/
// `sample_cube_mipmap_compare_filtered` - a trilinear *compare* variant for each
// texture type that has a shadow sampler at all (`Texture3DView` does not, matching
// `exec_sample_3d`'s own narrowing).
//
// `computeTextureLookupDiff` is now ported for both `Texture2DView` and
// `Texture2DArrayView` - `compute_texture_lookup_diff_2d`/`_2d_array`, the functions
// every one of `texture.filtering`/`format`/`specification`/`gather`/`border_clamp`
// (`hodow_cts/README.md`'s own coverage table lists these as blocked on exactly this)
// would call to turn a driver's rendered image and this file's own `sample_texture_2d`/
// `_2d_array` reference into a pass/fail verdict per pixel, by re-deriving each pixel's
// coordinate and LOD-bounds *window* (not the single ideal LOD the reference-image
// production path picks) and handing both to `tcu::tex_verifier::is_lookup_result_valid_2d`/
// `_2d_array`. See `compute_texture_lookup_diff_2d`'s own doc comment for what it narrows
// from upstream (no `baseLevel`/`maxLevel`/`imageViewMinLod`, no watchdog) and for the two
// small `pixel::Sampler` -> `tex_verifier` bridging functions (`to_verifier_wrap_mode`,
// `sampler_min_filter_mode`) it needed - `pixel::WrapMode` and `tex_verifier::WrapMode` are
// two independently-defined, identically-shaped enums (a real, pre-existing split in this
// crate, not introduced here), and this port's `Sampler` has no single `minFilter` field
// the way upstream's 9-variant `FilterMode` does.
//
// `compute_texture_lookup_diff_2d_array` is **not** a mechanical copy of the 2D overload
// with a layer axis bolted on - read upstream's own two bodies side by side
// (`gluTextureTestUtil.cpp` lines ~1632-1687 vs ~2328-2332) and they genuinely differ: the
// 2D overload widens the triangle search to both triangles near the shared diagonal edge
// (`tri0`/`tri1`/`posEps`, `MIN_SUBPIXEL_BITS`), while the 2D-array overload picks a single
// `triNdx = (nx + ny >= 1.0) ? 1 : 0` with no edge-widening at all - confirmed this is
// upstream's own asymmetry, not a narrowing introduced by this port, by reading both
// functions directly rather than assuming they share one shape.
//
// `compute_texture_lookup_diff_3d` (`Texture3DView`) is ported too, and - unlike the
// 2D-array overload - genuinely *is* the 2D overload's own `tri0`/`tri1` edge-widening
// shape with a third (depth) axis threaded through every `Vec2`/`coord` that was 2-wide,
// confirmed directly against upstream's body rather than assumed from either sibling.
// Needs `wrap_r` (`to_verifier_wrap_mode(params.sampler.wrap_r)`), unused by any 2D-shaped
// overload above.
//
// `compute_texture_lookup_diff_cube` (`TextureCubeView`) keeps the same edge-widening
// loop as 3D, but needed its own read of upstream's body rather than copying 3D's shape
// verbatim: `coordDx`/`coordDy` are *not* multiplied by a src-size vector (`tcu::
// tex_verifier::compute_cube_lod_bounds_from_derivates` already multiplies by
// `face_size` internally), the neighbour-offset loop recomputes a fresh direction
// coordinate `coordO` at each offset (not just the derivatives, since the cube LOD
// formula is a function of position as well as derivative), and the offset set itself
// has 8 entries rather than 4 (the extra diagonal four, upstream's own "not strictly
// allowed by spec" comment). `is_lookup_result_valid_cube` takes no `wrap_s`/`wrap_t` at
// all, unlike every overload above it.
//
// `computeTextureCompareDiff` (`compute_texture_compare_diff_2d`/`_2d_array`/`_cube`,
// the shadow-sampler counterparts of `compute_texture_lookup_diff_2d`/`_2d_array`/
// `_cube`, needed once a shadow-sampler `texture.filtering`/`gather` case is ported) is
// now ported for every GLES-reachable texture type too. Two things worth knowing before
// reusing it: it needs no colour-scale/bias adjustment at all (a shadow result is a raw
// 0/1 compare, not a colour `RenderParams::color_scale`/`color_bias` ever touches), and
// its fast path is **exact equality** on channel 0, not a `color_threshold`-sized window
// - a correct shadow result is already quantized to whatever the reference image itself
// produced, so "equal" is the only value a driver can match without needing real
// verification. The 2D/2D-array overloads use a single `triNdx` (no `tri0`/`tri1`
// edge-widening, unlike their lookup-diff counterparts); the cube overload keeps a
// fresh per-offset `coord_o` the same reason `compute_texture_lookup_diff_cube` does,
// but - confirmed by reading upstream's body directly rather than assumed from the
// lookup-diff cube shape - has only 4 neighbour-offset entries, not 8, and no edge-
// widening either.
//
// `computeTextureCompareDiff`/`computeTextureLookupDiff`/`verifyTextureResult` for
// `Texture1DView`/`Texture1DArrayView`/`TextureCubeArrayView` are deliberately **not**
// ported - same reasoning `tcu::tex_compare_verifier`'s own doc comment already gives
// for the identical gap there: no GLES2/3/31 texture target needs 1D/1D-array (no
// `GL_TEXTURE_1D` and no `sampler1D` exist in GLSL ES at all), and cube-array is an AEP
// extension, out of scope with everything else cube-array already is in this crate.
// Every `computeTextureLookupDiff`/`computeTextureCompareDiff` overload a GLES target
// can actually reach (2D/2D-array/3D/cube, cube skipping the no-shadow-3D-sampler case)
// is now ported.
//
// Not ported at all: `fetchTexture` (the texel-fetch reference path for a *buffer*
// texture specifically - a flat 1D `ConstPixelBufferAccess` indexed straight by the
// quad's own interpolated `s`, not a mipmapped view - so it needs
// `TextureType::Buffer`/`SamplerType::Fetch*` and a host-side texture-buffer type first,
// none of which exist here yet; `tcu::pixel::texel_fetch_2d` is unrelated, a 2D
// mipmap-level fetch this crate already has for a different consumer),
// `sampleTexture`'s 1D/cube-array overloads, 1D/cube-array coordinate generation,
// `GenMipmapPrecision`/`LogGradientFmt` (verification-report formatting, not reference
// generation). `getSamplerType`/`getFetchSamplerType` (`get_sampler_type`/
// `get_fetch_sampler_type` below) are ported despite having no caller yet - both are
// small, pure classifications a future `texture.format`/`texture.specification` case
// will need to pick its own sampler type from a real `TextureFormat`, unlike the
// buffer-texture/cube-array pieces above, each of which needs a whole new host-side
// texture type (and, for cube-array, hardware this project's own target GPU does not
// have) before it would mean anything.
//
// `glsTextureTestUtil`'s own `TextureRenderer`/`ProgramLibrary` (the real-driver half:
// compiles a GLSL program per `Program` variant and renders the quad through it) is
// ported too, in `gls::texture_test_util` - narrowed the same way this file is, see
// that module's own top doc comment for exactly which `TextureType`/`SamplerType`
// combinations it covers.

use crate::tcu::RGBA;
use crate::tcu::pixel::{
    ConstPixelBufferAccess, FilterMode, MipmapFilterMode, PixelBufferAccess, Sampler, WrapMode as PixelWrapMode, clear,
    sample_2d_array_mipmap, sample_2d_array_mipmap_compare, sample_2d_array_mipmap_compare_filtered,
    sample_2d_array_mipmap_filtered, sample_2d_mipmap, sample_2d_mipmap_compare, sample_2d_mipmap_compare_filtered,
    sample_2d_mipmap_filtered, sample_3d_mipmap, sample_3d_mipmap_filtered, sample_cube_level, sample_cube_mipmap,
    sample_cube_mipmap_compare, sample_cube_mipmap_compare_filtered, sample_cube_mipmap_filtered,
};
use crate::tcu::tex_compare_verifier::{
    TexComparePrecision, is_tex_compare_result_valid_2d, is_tex_compare_result_valid_2d_array,
    is_tex_compare_result_valid_cube, is_tex_compare_result_valid_cube_array,
};
use crate::tcu::tex_verifier::{
    LodPrecision, LookupPrecision, MinFilterMode, WrapMode, clamp_lod_bounds, compute_cube_lod_bounds_from_derivates,
    compute_lod_bounds_from_derivates, is_lookup_result_valid_2d, is_lookup_result_valid_2d_array,
    is_lookup_result_valid_3d, is_lookup_result_valid_cube, is_lookup_result_valid_cube_array,
};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::{IVec2, Vec2, Vec3, Vec4};

/// `glu::TextureTestUtil::TextureType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum TextureType {
    Texture2D,
    Cube,
    Texture2DArray,
    Texture3D,
    CubeArray,
    Texture1D,
    Texture1DArray,
    Buffer,
}

/// `glu::TextureTestUtil::SamplerType`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SamplerType {
    Float,
    Int,
    Uint,
    Shadow,
    FetchFloat,
    FetchInt,
    FetchUint,
}

/// `getSamplerType` - which GLSL sampler shape a non-shadow lookup against `format`
/// needs. Depth/stencil formats are the one case that is not determined by
/// `format.type_` alone: `UNSIGNED_INT16`/`UNSIGNED_INT_24_8` back both a genuine
/// `GL_DEPTH_COMPONENT16`/`GL_DEPTH24_STENCIL8` texture (sampled as float, through
/// `sampler2D`) and an ordinary 16-/32-bit unsigned integer colour format (sampled as
/// `usampler2D`) - `format.order` is what tells the two apart.
pub fn get_sampler_type(format: TextureFormat) -> SamplerType {
    use ChannelType::*;
    match format.type_ {
        SIGNED_INT8 | SIGNED_INT16 | SIGNED_INT32 => SamplerType::Int,
        UNSIGNED_INT8 | UNSIGNED_INT32 | UNSIGNED_INT_1010102_REV => SamplerType::Uint,
        UNSIGNED_INT16 | UNSIGNED_INT_24_8 => {
            if matches!(format.order, ChannelOrder::D | ChannelOrder::DS) {
                SamplerType::Float
            } else {
                SamplerType::Uint
            }
        }
        _ => SamplerType::Float,
    }
}

/// `getFetchSamplerType` - the `texelFetch` counterpart of `get_sampler_type`, for a
/// buffer texture's own `samplerBuffer`/`isamplerBuffer`/`usamplerBuffer` choice. Same
/// classification, `Fetch*` variants in place of the ordinary ones - there is no
/// `FetchShadow` because `samplerBufferShadow` does not exist in GLSL.
pub fn get_fetch_sampler_type(format: TextureFormat) -> SamplerType {
    use ChannelType::*;
    match format.type_ {
        SIGNED_INT8 | SIGNED_INT16 | SIGNED_INT32 => SamplerType::FetchInt,
        UNSIGNED_INT8 | UNSIGNED_INT32 | UNSIGNED_INT_1010102_REV => SamplerType::FetchUint,
        UNSIGNED_INT16 | UNSIGNED_INT_24_8 => {
            if matches!(format.order, ChannelOrder::D | ChannelOrder::DS) {
                SamplerType::FetchFloat
            } else {
                SamplerType::FetchUint
            }
        }
        _ => SamplerType::FetchFloat,
    }
}

/// `glu::TextureTestUtil::LodMode`
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum LodMode {
    /// `LODMODE_EXACT` - ideal (sqrt-of-squares) lod computation.
    Exact,
    /// `LODMODE_MIN_BOUND` - estimation range minimum bound (`max` of the per-axis
    /// derivative magnitudes).
    MinBound,
    /// `LODMODE_MAX_BOUND` - estimation range maximum bound (`sum` of them).
    MaxBound,
}

/// `glu::TextureTestUtil::RenderParams`, narrowed as this file's own doc comment
/// states - `flags` keeps only `PROJECTED`/`USE_BIAS` (the two this slice reads), the
/// `LOG_*` logging flags have no meaning without a `TextureRenderer` and are dropped.
#[derive(Debug, Clone, Copy)]
pub struct RenderParams {
    pub tex_type: TextureType,
    pub sampler_type: SamplerType,
    pub projected: bool,
    pub use_bias: bool,
    /// w coordinates for the quad's four vertices, in the same
    /// `(-1,-1),(-1,1),(1,-1),(1,1)` order every texture-coordinate array here uses.
    pub w: Vec4,
    pub bias: f32,
    /// `RenderParams::ref` (`ref` is a Rust keyword, hence the trailing underscore) -
    /// the shadow-lookup reference value a `SamplerType::Shadow` lookup compares the
    /// sampled depth against. Unused for every other `SamplerType`.
    pub ref_: f32,
    pub color_scale: Vec4,
    pub color_bias: Vec4,
}

impl RenderParams {
    pub fn new(tex_type: TextureType) -> Self {
        Self {
            tex_type,
            sampler_type: SamplerType::Float,
            projected: false,
            use_bias: false,
            w: Vec4::splat(1.0),
            bias: 0.0,
            ref_: 0.0,
            color_scale: Vec4::splat(1.0),
            color_bias: Vec4::splat(0.0),
        }
    }
}

/// `glu::TextureTestUtil::ReferenceParams`, narrowed the same way `RenderParams` is -
/// see this file's own module doc comment for exactly which upstream fields are absent.
#[derive(Debug, Clone, Copy)]
pub struct ReferenceParams {
    pub base: RenderParams,
    pub sampler: Sampler,
    pub lod_mode: LodMode,
    pub min_lod: f32,
    pub max_lod: f32,
    pub base_level: i32,
    pub max_level: i32,
    /// `Sampler::magFilter` when it differs from the min filter: `sampler.filter` (with
    /// `mip_filter`) stays the min filter, and a lookup at lod <= 0 uses this tap instead.
    /// `None` means the two are the same (every caller before this field existed).
    pub mag_filter: Option<FilterMode>,
    /// `ReferenceParams::float16TexCoord`: round `s`/`t` to half-float precision (toward zero) before every
    /// non-projected 2D lookup, which is what a driver with fp16 `mediump` coordinates does.
    pub float16_tex_coord: bool,
    /// `ReferenceParams::imageViewMinLod`: `VK_EXT_image_view_min_lod` of the view; 0.0 means no such state.
    pub image_view_min_lod: f32,
    /// `ImageViewMinLodMode::IMAGEVIEWMINLODMODE_ALTERNATIVE`: use the floor of `image_view_min_lod`.
    pub image_view_min_lod_alternative: bool,
    /// `ReferenceParams::lodTexelFetch`: the explicit level a `SamplerType::FetchFloat` lookup with `image_view_min_lod` reads
    pub lod_texel_fetch: i32,
}

impl ReferenceParams {
    /// The `(minLod, maxLod)` `computeTextureLookupDiff` clamps its lod bounds to: the view's minLod adapted to the
    /// mipmap mode (taken from the raw `imageViewMinLod`, as upstream does) raises the sampler's.
    pub(crate) fn lod_range_for_diff(&self) -> (f32, f32) {
        if self.image_view_min_lod == 0.0 {
            return (self.min_lod, self.max_lod);
        }
        let relative = self.image_view_min_lod - self.base_level as f32;
        let relative_for_mode = if matches!(self.sampler.mip_filter, Some(MipmapFilterMode::Linear)) {
            relative.floor()
        } else {
            (((relative + 0.5).ceil() as i32) - 1).clamp(self.base_level, self.max_level) as f32
        };
        (relative_for_mode.max(self.min_lod), self.max_lod)
    }

    /// `getImageViewMinLod(minLodParams->minLod) - baseLevel`: the view's minLod relative to its own level 0.
    pub(crate) fn image_view_min_lod_relative(&self) -> f32 {
        let min_lod = if self.image_view_min_lod_alternative {
            self.image_view_min_lod.floor()
        } else {
            self.image_view_min_lod
        };
        min_lod - self.base_level as f32
    }

    pub fn new(tex_type: TextureType, sampler: Sampler, lod_mode: LodMode) -> Self {
        Self {
            base: RenderParams::new(tex_type),
            sampler,
            lod_mode,
            min_lod: -1000.0,
            max_lod: 1000.0,
            base_level: 0,
            max_level: 1000,
            mag_filter: None,
            float16_tex_coord: false,
            image_view_min_lod: 0.0,
            image_view_min_lod_alternative: false,
            lod_texel_fetch: 0,
        }
    }

    /// The parameters a lookup at `lod` actually samples with: at lod <= 0 (upstream's
    /// default `lodThreshold`) the magnification filter replaces the minification one.
    pub(crate) fn effective_for_lod(&self, lod: f32) -> Self {
        match self.mag_filter {
            Some(mag) if lod <= 0.0 => {
                let mut p = *self;
                p.sampler.filter = mag;
                p.sampler.mip_filter = None;
                p.mag_filter = None;
                p
            }
            _ => *self,
        }
    }
}

/// `glu::TextureTestUtil::triangleInterpolate` (the free-scalar overload).
pub fn triangle_interpolate(v0: f32, v1: f32, v2: f32, x: f32, y: f32) -> f32 {
    v0 + (v2 - v0) * x + (v1 - v0) * y
}

/// `glu::TextureTestUtil::triangleInterpolate` (the `Vec3` overload).
pub fn triangle_interpolate_v3(v: Vec3, x: f32, y: f32) -> f32 {
    triangle_interpolate(v.x(), v.y(), v.z(), x, y)
}

/// `computeLodFromDerivates` (1D lookup - `dudx`/`dudy` only, min and max bound both
/// reduce to the exact value upstream notes `\note [mika] Min and max bound equal to
/// exact with 1D textures`).
pub fn compute_lod_from_derivates_1d(_mode: LodMode, dudx: f32, dudy: f32) -> f32 {
    dudx.abs().max(dudy.abs()).log2()
}

/// `computeLodFromDerivates` (2D lookup).
pub fn compute_lod_from_derivates_2d(mode: LodMode, dudx: f32, dvdx: f32, dudy: f32, dvdy: f32) -> f32 {
    let p = match mode {
        LodMode::Exact => (dudx * dudx + dvdx * dvdx)
            .sqrt()
            .max((dudy * dudy + dvdy * dvdy).sqrt()),
        LodMode::MinBound | LodMode::MaxBound => {
            let mu = dudx.abs().max(dudy.abs());
            let mv = dvdx.abs().max(dvdy.abs());
            if matches!(mode, LodMode::MinBound) {
                mu.max(mv)
            } else {
                mu + mv
            }
        }
    };
    p.log2()
}

/// `computeLodFromDerivates` (3D lookup).
pub fn compute_lod_from_derivates_3d(
    mode: LodMode,
    dudx: f32,
    dvdx: f32,
    dwdx: f32,
    dudy: f32,
    dvdy: f32,
    dwdy: f32,
) -> f32 {
    let p = match mode {
        LodMode::Exact => (dudx * dudx + dvdx * dvdx + dwdx * dwdx)
            .sqrt()
            .max((dudy * dudy + dvdy * dvdy + dwdy * dwdy).sqrt()),
        LodMode::MinBound | LodMode::MaxBound => {
            let mu = dudx.abs().max(dudy.abs());
            let mv = dvdx.abs().max(dvdy.abs());
            let mw = dwdx.abs().max(dwdy.abs());
            if matches!(mode, LodMode::MinBound) {
                mu.max(mv).max(mw)
            } else {
                mu + mv + mw
            }
        }
    };
    p.log2()
}

/// `computeNonProjectedTriLod` (1D).
pub fn compute_non_projected_tri_lod_1d(mode: LodMode, dst_size: IVec2, src_size: i32, sq: Vec3) -> f32 {
    let dux = (sq.z() - sq.x()) * src_size as f32;
    let duy = (sq.y() - sq.x()) * src_size as f32;
    let dx = dst_size.x() as f32;
    let dy = dst_size.y() as f32;
    compute_lod_from_derivates_1d(mode, dux / dx, duy / dy)
}

/// `computeNonProjectedTriLod` (2D).
pub fn compute_non_projected_tri_lod_2d(mode: LodMode, dst_size: IVec2, src_size: IVec2, sq: Vec3, tq: Vec3) -> f32 {
    let dux = (sq.z() - sq.x()) * src_size.x() as f32;
    let duy = (sq.y() - sq.x()) * src_size.x() as f32;
    let dvx = (tq.z() - tq.x()) * src_size.y() as f32;
    let dvy = (tq.y() - tq.x()) * src_size.y() as f32;
    let dx = dst_size.x() as f32;
    let dy = dst_size.y() as f32;
    compute_lod_from_derivates_2d(mode, dux / dx, dvx / dx, duy / dy, dvy / dy)
}

/// `computeNonProjectedTriLod` (3D).
pub fn compute_non_projected_tri_lod_3d(
    mode: LodMode,
    dst_size: IVec2,
    src_size: crate::tcu::vector::IVec3,
    sq: Vec3,
    tq: Vec3,
    rq: Vec3,
) -> f32 {
    let dux = (sq.z() - sq.x()) * src_size.x() as f32;
    let duy = (sq.y() - sq.x()) * src_size.x() as f32;
    let dvx = (tq.z() - tq.x()) * src_size.y() as f32;
    let dvy = (tq.y() - tq.x()) * src_size.y() as f32;
    let dwx = (rq.z() - rq.x()) * src_size.z() as f32;
    let dwy = (rq.y() - rq.x()) * src_size.z() as f32;
    let dx = dst_size.x() as f32;
    let dy = dst_size.y() as f32;
    compute_lod_from_derivates_3d(mode, dux / dx, dvx / dx, dwx / dx, duy / dy, dvy / dy, dwy / dy)
}

/// `projectedTriInterpolate` - perspective-correct barycentric interpolation of `s`
/// (the texture coordinate at the triangle's three corners) weighted by the reciprocal
/// of each corner's `w`.
fn projected_tri_interpolate(s: Vec3, w: Vec3, nx: f32, ny: f32) -> f32 {
    (s.x() * (1.0 - nx - ny) / w.x() + s.y() * ny / w.y() + s.z() * nx / w.z())
        / ((1.0 - nx - ny) / w.x() + ny / w.y() + nx / w.z())
}

/// `triDerivateX` - the exact (not estimated) screen-space x-derivative of a
/// perspective-interpolated attribute, differentiating `projected_tri_interpolate`
/// analytically rather than estimating it from neighbouring samples.
fn tri_derivate_x(s: Vec3, w: Vec3, wx: f32, width: f32, ny: f32) -> f32 {
    let d = w.y() * w.z() * (width * (ny - 1.0) + wx) - w.x() * (w.z() * width * ny + w.y() * wx);
    (w.x()
        * w.y()
        * w.z()
        * width
        * (w.y() * (s.x() - s.z()) * (ny - 1.0) + ny * (w.z() * (s.y() - s.x()) + w.x() * (s.z() - s.y()))))
        / (d * d)
}

/// `triDerivateY` - the y-axis counterpart of `tri_derivate_x`.
fn tri_derivate_y(s: Vec3, w: Vec3, wy: f32, height: f32, nx: f32) -> f32 {
    let d = w.y() * w.z() * (height * (nx - 1.0) + wy) - w.x() * (w.y() * height * nx + w.z() * wy);
    (w.x()
        * w.y()
        * w.z()
        * height
        * (w.z() * (s.x() - s.y()) * (nx - 1.0) + nx * (w.x() * (s.y() - s.z()) + w.y() * (s.z() - s.x()))))
        / (d * d)
}

/// `computeProjectedTriLod` (2D lookup).
#[allow(clippy::too_many_arguments)]
pub fn compute_projected_tri_lod_2d(
    mode: LodMode,
    u: Vec3,
    v: Vec3,
    projection: Vec3,
    wx: f32,
    wy: f32,
    width: f32,
    height: f32,
) -> f32 {
    let dudx = tri_derivate_x(u, projection, wx, width, wy / height);
    let dvdx = tri_derivate_x(v, projection, wx, width, wy / height);
    let dudy = tri_derivate_y(u, projection, wy, height, wx / width);
    let dvdy = tri_derivate_y(v, projection, wy, height, wx / width);
    compute_lod_from_derivates_2d(mode, dudx, dvdx, dudy, dvdy)
}

/// `computeProjectedTriLod` (3D overload)
#[allow(clippy::too_many_arguments)]
pub fn compute_projected_tri_lod_3d(
    mode: LodMode,
    u: Vec3,
    v: Vec3,
    w: Vec3,
    projection: Vec3,
    wx: f32,
    wy: f32,
    width: f32,
    height: f32,
) -> f32 {
    let dudx = tri_derivate_x(u, projection, wx, width, wy / height);
    let dvdx = tri_derivate_x(v, projection, wx, width, wy / height);
    let dwdx = tri_derivate_x(w, projection, wx, width, wy / height);
    let dudy = tri_derivate_y(u, projection, wy, height, wx / width);
    let dvdy = tri_derivate_y(v, projection, wy, height, wx / width);
    let dwdy = tri_derivate_y(w, projection, wy, height, wx / width);
    compute_lod_from_derivates_3d(mode, dudx, dvdx, dwdx, dudy, dvdy, dwdy)
}

/// `computeQuadTexCoord1D`
pub fn compute_quad_tex_coord_1d(left: f32, right: f32) -> [f32; 4] {
    [left, left, right, right]
}

/// `computeQuadTexCoord2D` (the `Vec2` overload). Vertex order is
/// `(-1,-1),(-1,1),(1,-1),(1,1)`, matching every other texture-coordinate helper here.
pub fn compute_quad_tex_coord_2d(bottom_left: Vec2, top_right: Vec2) -> [f32; 8] {
    [
        bottom_left.x(),
        bottom_left.y(),
        bottom_left.x(),
        top_right.y(),
        top_right.x(),
        bottom_left.y(),
        top_right.x(),
        top_right.y(),
    ]
}

/// `computeQuadTexCoord2DArray`
pub fn compute_quad_tex_coord_2d_array(layer_ndx: i32, bottom_left: Vec2, top_right: Vec2) -> [f32; 12] {
    let l = layer_ndx as f32;
    [
        bottom_left.x(),
        bottom_left.y(),
        l,
        bottom_left.x(),
        top_right.y(),
        l,
        top_right.x(),
        bottom_left.y(),
        l,
        top_right.x(),
        top_right.y(),
        l,
    ]
}

/// `sampleLevelArray2D`/`3D`/cube with `ImageViewMinLodParams` set (no integer texel coordinates): `tap` samples
/// level `n` of the view (whose level 0 is the view's base level) with the given sampler. A magnified lookup
/// picks its level from the view's minLod alone, a minified one clamps `lod` to it first.
fn sample_levels_with_view_min_lod(
    num_levels: usize,
    params: &ReferenceParams,
    lod: f32,
    (s, t): (f32, f32),
    tap: impl Fn(usize, &Sampler) -> [f32; 4],
) -> [f32; 4] {
    let min_lod_relative = params.image_view_min_lod_relative();
    // Integer texel coordinates (robustImageAccess2): a level below the view's minLod or outside it, and a coordinate outside 0..1, read zeros
    let int_tex_coord = params.base.sampler_type == SamplerType::FetchFloat;
    if int_tex_coord {
        if lod < min_lod_relative.floor() || lod >= num_levels as f32 {
            return [0.0; 4];
        }
        if !(0.0..=1.0).contains(&s) || !(0.0..=1.0).contains(&t) {
            return [0.0; 4];
        }
    }
    let max_level = num_levels as i32 - 1;
    let blend =
        |t0: [f32; 4], t1: [f32; 4], f: f32| -> [f32; 4] { std::array::from_fn(|c| t0[c] * (1.0 - f) + t1[c] * f) };
    let mip_linear = matches!(params.sampler.mip_filter, Some(MipmapFilterMode::Linear));

    if lod <= 0.0 {
        let mut sampler = params.sampler;
        sampler.filter = params.mag_filter.unwrap_or(sampler.filter);
        sampler.mip_filter = None;
        if mip_linear {
            let level0 = (min_lod_relative.floor() as i32).clamp(0, max_level);
            let level1 = (level0 + 1).min(max_level);
            let t0 = tap(level0 as usize, &sampler);
            let t1 = tap(level1 as usize, &sampler);
            blend(t0, t1, min_lod_relative - min_lod_relative.floor())
        } else {
            let level0 = (((min_lod_relative + 0.5).ceil() as i32) - 1).clamp(0, max_level);
            tap(level0 as usize, &sampler)
        }
    } else {
        let lod = if int_tex_coord { lod } else { lod.max(min_lod_relative) };
        if mip_linear {
            let level0 = (lod.floor() as i32).clamp(0, max_level);
            let level1 = (level0 + 1).min(max_level);
            let t0 = tap(level0 as usize, &params.sampler);
            let t1 = tap(level1 as usize, &params.sampler);
            blend(t0, t1, lod - lod.floor())
        } else {
            let level = (((lod + 0.5).ceil() as i32) - 1).clamp(0, max_level);
            tap(level as usize, &params.sampler)
        }
    }
}

/// `execSample` (the `Texture2DView` overload). `SAMPLERTYPE_FLOAT`/`INT`/`UINT` all
/// take the same `src.sample(...)` path upstream - the sampler-type-specific GLSL cast
/// (`vec4(texture(u_sampler, ...))` for an `isampler2D`/`usampler2D`) lives only in the
/// real-driver shader `gls::texture_test_util::ProgramLibrary` builds, never in this
/// host-side reference (`tcu::pixel::ConstPixelBufferAccess::get_pixel` already decodes
/// an integer-channel-class format to its raw, unnormalized value - confirmed against
/// `tcu::pixel`'s own `get_pixel` body, not assumed). `SAMPLERTYPE_SHADOW` instead takes
/// `src.sampleCompare(...)`, returning `Vec4(result, 0, 0, 1)` exactly as upstream's own
/// `execSample` shadow branch does. Every other `SamplerType` (`FETCH_*`) is not ported.
///
/// `params.sampler.mip_filter` picks which of `sample_2d_mipmap`/
/// `sample_2d_mipmap_filtered` actually runs - see `Sampler`'s own doc comment for why
/// that field exists. `Shadow` takes the same dispatch now, through
/// `sample_2d_mipmap_compare_filtered`'s `Some` arm.
pub(crate) fn exec_sample_2d(
    levels: &[ConstPixelBufferAccess<'_>],
    params: &ReferenceParams,
    s: f32,
    t: f32,
    lod: f32,
) -> [f32; 4] {
    if params.image_view_min_lod != 0.0 {
        return sample_levels_with_view_min_lod(levels.len(), params, lod, (s, t), |level, sampler| {
            levels[level].sample_2d(sampler, s, t, 0)
        });
    }
    let params = &params.effective_for_lod(lod);
    match params.base.sampler_type {
        SamplerType::Float | SamplerType::Int | SamplerType::Uint => match params.sampler.mip_filter {
            Some(mip_filter) => sample_2d_mipmap_filtered(levels, &params.sampler, s, t, lod, mip_filter),
            None => sample_2d_mipmap(levels, &params.sampler, s, t, lod),
        },
        SamplerType::Shadow => {
            let result = match params.sampler.mip_filter {
                Some(mip_filter) => {
                    sample_2d_mipmap_compare_filtered(levels, &params.sampler, params.base.ref_, s, t, lod, mip_filter)
                }
                None => sample_2d_mipmap_compare(levels, &params.sampler, params.base.ref_, s, t, lod),
            };
            [result, 0.0, 0.0, 1.0]
        }
        other => unimplemented!("exec_sample_2d: {other:?} is not ported (see module doc comment)"),
    }
}

/// `sampleTextureNonProjected` (the `Texture2DView` overload, with `PixelAccess`
/// narrowed to `PixelBufferAccess` - upstream's `tcu::SurfaceAccess` overload is not
/// separately ported since nothing distinguishes the two write paths here).
fn sample_texture_non_projected_2d(
    dst: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    sq: Vec4,
    tq: Vec4,
    params: &ReferenceParams,
) {
    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };

    let [dw, dh, _] = dst.size();
    let dst_size = IVec2::new(dw as i32, dh as i32);
    let [sw, sh, _] = levels[0].size();
    let src_size = IVec2::new(sw as i32, sh as i32);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_lod = [
        (compute_non_projected_tri_lod_2d(params.lod_mode, dst_size, src_size, tri_s[0], tri_t[0]) + lod_bias)
            .clamp(params.min_lod, params.max_lod),
        (compute_non_projected_tri_lod_2d(params.lod_mode, dst_size, src_size, tri_s[1], tri_t[1]) + lod_bias)
            .clamp(params.min_lod, params.max_lod),
    ];

    for y in 0..dh {
        for x in 0..dw {
            let yf = (y as f32 + 0.5) / dh as f32;
            let xf = (x as f32 + 0.5) / dw as f32;

            // Top-left fill rule - matches `rr`/upstream's own triangle split for a
            // screen-aligned quad.
            let tri_ndx = if xf + yf >= 1.0 { 1 } else { 0 };
            let tri_x = if tri_ndx == 1 { 1.0 - xf } else { xf };
            let tri_y = if tri_ndx == 1 { 1.0 - yf } else { yf };

            let s = triangle_interpolate_v3(tri_s[tri_ndx], tri_x, tri_y);
            let t = triangle_interpolate_v3(tri_t[tri_ndx], tri_x, tri_y);
            let lod = tri_lod[tri_ndx];
            let lod = if params.image_view_min_lod != 0.0 && params.base.sampler_type == SamplerType::FetchFloat {
                params.lod_texel_fetch as f32
            } else {
                lod
            };

            let (s, t) = if params.float16_tex_coord {
                (round_to_f16_toward_zero(s), round_to_f16_toward_zero(t))
            } else {
                (s, t)
            };

            let sample = exec_sample_2d(levels, params, s, t, lod);
            let color: [f32; 4] = std::array::from_fn(|c| {
                sample[c] * params.base.color_scale.m_data[c] + params.base.color_bias.m_data[c]
            });
            dst.set_pixel(color, x, y, 0);
        }
    }
}

/// `tcu::Float16(value, tcu::ROUND_TO_ZERO).asFloat()`: overflow saturates to the largest finite half-float.
fn round_to_f16_toward_zero(value: f32) -> f32 {
    const F16_MAX: f32 = 65504.0;
    const F16_MIN_NORMAL: f32 = 6.103_515_6e-5; // 2^-14
    const F16_SUBNORMAL_STEP: f32 = 5.960_464_5e-8; // 2^-24

    if !value.is_finite() || value == 0.0 {
        return value;
    }

    let sign = value.to_bits() & 0x8000_0000;
    let magnitude = value.abs();
    let rounded = if magnitude >= F16_MAX {
        F16_MAX
    } else if magnitude < F16_MIN_NORMAL {
        (magnitude / F16_SUBNORMAL_STEP).floor() * F16_SUBNORMAL_STEP
    } else {
        // Normal range: keep the 10 mantissa bits a half-float has.
        f32::from_bits(magnitude.to_bits() & !((1u32 << 13) - 1))
    };
    f32::from_bits(sign | rounded.to_bits())
}

/// `sampleTextureProjected` (the `Texture2DView` overload).
fn sample_texture_projected_2d(
    dst: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    sq: Vec4,
    tq: Vec4,
    params: &ReferenceParams,
) {
    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };
    let [dw, dh, _] = dst.size();
    let dst_w = dw as f32;
    let dst_h = dh as f32;
    let [sw, sh, _] = levels[0].size();

    let uq: Vec4 = Vec4::from_array(std::array::from_fn(|c| sq.m_data[c] * sw as f32));
    let vq: Vec4 = Vec4::from_array(std::array::from_fn(|c| tq.m_data[c] * sh as f32));

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_u = [uq.swizzle([0, 1, 2]), uq.swizzle([3, 2, 1])];
    let tri_v = [vq.swizzle([0, 1, 2]), vq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    for py in 0..dh {
        for px in 0..dw {
            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri_ndx = if nx + ny >= 1.0 { 1 } else { 0 };
            let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
            let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let s = projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny);
            let t = projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny);
            let lod = compute_projected_tri_lod_2d(
                params.lod_mode,
                tri_u[tri_ndx],
                tri_v[tri_ndx],
                tri_w[tri_ndx],
                tri_wx,
                tri_wy,
                dst_w,
                dst_h,
            ) + lod_bias;

            let sample = exec_sample_2d(levels, params, s, t, lod);
            let color: [f32; 4] = std::array::from_fn(|c| {
                sample[c] * params.base.color_scale.m_data[c] + params.base.color_bias.m_data[c]
            });
            dst.set_pixel(color, px, py, 0);
        }
    }
}

/// `getSubView` - clamps `base_level`/`max_level` to a valid sub-range of `levels`
/// (upstream's own `de::clamp` on both ends, in that order: `max_level` is clamped
/// against the *already-clamped* `base_level`, not the raw one, so a `max_level` below
/// `base_level` can never produce an empty or reversed range) and returns the
/// corresponding sub-slice. Mip levels outside `[base_level, max_level]` are then never
/// looked at by any lookup, exactly like a real `GL_TEXTURE_BASE_LEVEL`/
/// `GL_TEXTURE_MAX_LEVEL` pair restricts a driver's own sampling. Every current caller's
/// own default (`base_level: 0, max_level: 1000`) clamps to the whole of `levels`
/// unchanged, so this is behaviour-preserving for all of them; only a future caller
/// that narrows either field actually sees a different `levels` slice.
fn sub_view<'a>(
    levels: &'a [ConstPixelBufferAccess<'a>],
    base_level: i32,
    max_level: i32,
) -> &'a [ConstPixelBufferAccess<'a>] {
    debug_assert!(!levels.is_empty(), "a texture always has at least one mip level");
    let last = levels.len() as i32 - 1;
    let clamped_base = base_level.clamp(0, last);
    let clamped_max = max_level.clamp(clamped_base, last);
    &levels[clamped_base as usize..=clamped_max as usize]
}

/// `sampleTexture` (the `Texture2DView` overload) - dispatches on `RenderParams::PROJECTED`
/// exactly like upstream's single entry point does.
///
/// `tex_coord` is laid out as upstream's flat `const float *` is: `[s0,t0,s1,t1,s2,t2,s3,t3]`
/// for the quad's four vertices in `(-1,-1),(-1,1),(1,-1),(1,1)` order - exactly what
/// `compute_quad_tex_coord_2d` returns.
pub fn sample_texture_2d(
    dst: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 8],
    params: &ReferenceParams,
) {
    let levels = sub_view(levels, params.base_level, params.max_level);
    let sq = Vec4::new(tex_coord[0], tex_coord[2], tex_coord[4], tex_coord[6]);
    let tq = Vec4::new(tex_coord[1], tex_coord[3], tex_coord[5], tex_coord[7]);

    if params.base.projected {
        sample_texture_projected_2d(dst, levels, sq, tq, params);
    } else {
        sample_texture_non_projected_2d(dst, levels, sq, tq, params);
    }
}

/// `execSample` (the `Texture2DArrayView` overload). `SAMPLERTYPE_SHADOW` routes
/// through `tcu::pixel::sample_2d_array_mipmap_compare`, packed the same
/// `Vec4(result, 0, 0, 1)` way every other shadow branch here is - upstream's own
/// `Texture2DArrayView` genuinely has a `sampleCompare` (confirmed directly, unlike
/// `Texture3DView`, which does not), so this is a real arm, not a narrowing.
///
/// `params.sampler.mip_filter` dispatch matches `exec_sample_2d`'s own - see that
/// function's doc comment.
pub(crate) fn exec_sample_2d_array(
    levels: &[ConstPixelBufferAccess<'_>],
    params: &ReferenceParams,
    s: f32,
    t: f32,
    r: f32,
    lod: f32,
) -> [f32; 4] {
    let params = &params.effective_for_lod(lod);
    match params.base.sampler_type {
        SamplerType::Float | SamplerType::Int | SamplerType::Uint => match params.sampler.mip_filter {
            Some(mip_filter) => sample_2d_array_mipmap_filtered(levels, &params.sampler, s, t, r, lod, mip_filter),
            None => sample_2d_array_mipmap(levels, &params.sampler, s, t, r, lod),
        },
        SamplerType::Shadow => {
            let result = match params.sampler.mip_filter {
                Some(mip_filter) => sample_2d_array_mipmap_compare_filtered(
                    levels,
                    &params.sampler,
                    params.base.ref_,
                    s,
                    t,
                    r,
                    lod,
                    mip_filter,
                ),
                None => sample_2d_array_mipmap_compare(levels, &params.sampler, params.base.ref_, s, t, r, lod),
            };
            [result, 0.0, 0.0, 1.0]
        }
        other => unimplemented!("exec_sample_2d_array: {other:?} is not ported (see this function's own doc comment)"),
    }
}

/// `sampleTexture` (the `Texture2DArrayView` overload) - **non-projected only**:
/// upstream's own `DE_ASSERT(!(params.flags & ReferenceParams::PROJECTED))` inside this
/// exact function says so directly ("\todo Support projected lookups"), so there is no
/// projected overload to even consider porting, unlike `Texture3DView`'s (where one
/// exists but is simply unreached).
///
/// `tex_coord` is `[s,t,r]` per vertex (`r` the layer coordinate), 4 vertices (12
/// floats), the layout `compute_quad_tex_coord_2d_array` returns.
pub fn sample_texture_2d_array(
    dst: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 12],
    params: &ReferenceParams,
) {
    assert!(
        !params.base.projected,
        "sample_texture_2d_array: projected array lookups are not ported upstream either (see this function's own doc comment)"
    );
    let levels = sub_view(levels, params.base_level, params.max_level);
    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };

    let [dw, dh, _] = dst.size();
    let dst_size = IVec2::new(dw as i32, dh as i32);
    let [sw, sh, _] = levels[0].size();
    let src_size = IVec2::new(sw as i32, sh as i32);

    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_lod = [
        (compute_non_projected_tri_lod_2d(params.lod_mode, dst_size, src_size, tri_s[0], tri_t[0]) + lod_bias)
            .clamp(params.min_lod, params.max_lod),
        (compute_non_projected_tri_lod_2d(params.lod_mode, dst_size, src_size, tri_s[1], tri_t[1]) + lod_bias)
            .clamp(params.min_lod, params.max_lod),
    ];

    for y in 0..dh {
        for x in 0..dw {
            let yf = (y as f32 + 0.5) / dh as f32;
            let xf = (x as f32 + 0.5) / dw as f32;

            let tri_ndx = if xf + yf >= 1.0 { 1 } else { 0 };
            let tri_x = if tri_ndx == 1 { 1.0 - xf } else { xf };
            let tri_y = if tri_ndx == 1 { 1.0 - yf } else { yf };

            let s = triangle_interpolate_v3(tri_s[tri_ndx], tri_x, tri_y);
            let t = triangle_interpolate_v3(tri_t[tri_ndx], tri_x, tri_y);
            let r = triangle_interpolate_v3(tri_r[tri_ndx], tri_x, tri_y);
            let lod = tri_lod[tri_ndx];

            let sample = exec_sample_2d_array(levels, params, s, t, r, lod);
            let color: [f32; 4] = std::array::from_fn(|c| {
                sample[c] * params.base.color_scale.m_data[c] + params.base.color_bias.m_data[c]
            });
            dst.set_pixel(color, x, y, 0);
        }
    }
}

/// `execSample` (the `TextureCubeView` overload). `SAMPLERTYPE_SHADOW` routes through
/// `tcu::pixel::sample_cube_mipmap_compare`, packed the same `Vec4(result, 0, 0, 1)` way
/// `exec_sample_2d`'s own shadow branch is - see that function's own doc comment for why
/// a shadow/cube-shadow result is never broadcast across RGB.
///
/// `params.sampler.mip_filter` dispatch matches `exec_sample_2d`'s own - see that
/// function's doc comment.
pub(crate) fn exec_sample_cube(
    levels: &[ConstPixelBufferAccess<'_>],
    params: &ReferenceParams,
    s: f32,
    t: f32,
    r: f32,
    lod: f32,
) -> [f32; 4] {
    if params.image_view_min_lod != 0.0 {
        return sample_levels_with_view_min_lod(levels.len(), params, lod, (s, t), |level, sampler| {
            sample_cube_level(&levels[level], sampler, s, t, r)
        });
    }
    let params = &params.effective_for_lod(lod);
    match params.base.sampler_type {
        SamplerType::Float | SamplerType::Int | SamplerType::Uint => match params.sampler.mip_filter {
            Some(mip_filter) => sample_cube_mipmap_filtered(levels, &params.sampler, s, t, r, lod, mip_filter),
            None => sample_cube_mipmap(levels, &params.sampler, s, t, r, lod),
        },
        SamplerType::Shadow => {
            let result = match params.sampler.mip_filter {
                Some(mip_filter) => sample_cube_mipmap_compare_filtered(
                    levels,
                    &params.sampler,
                    params.base.ref_,
                    s,
                    t,
                    r,
                    lod,
                    mip_filter,
                ),
                None => sample_cube_mipmap_compare(levels, &params.sampler, params.base.ref_, s, t, r, lod),
            };
            [result, 0.0, 0.0, 1.0]
        }
        other => unimplemented!("exec_sample_cube: {other:?} is not ported (see this function's own doc comment)"),
    }
}

/// `computeCubeLodFromDerivates` - unlike the 2D LOD math, a cube lookup's `(s,t,r)` is
/// a direction vector rather than a pair of independent axes, so the two in-face
/// derivatives have to be recovered first: `selectCubeFace` picks which axis is the
/// major one (`ma`), and the other two project onto the face's own `s`/`t` the way
/// `tcu::project_to_face` does for the coordinate itself - this is the derivative of
/// that same projection (`s/ma`, scaled by half the face size), by the quotient rule.
/// Derivative signs don't matter for a LOD estimate, so every `abs()` here matches
/// upstream exactly rather than being simplified away.
///
/// `tcu::tex_verifier::compute_cube_lod_bounds_from_derivates` is the *verification*-side
/// sibling of this *reference-image-production*-side function - same in-face-derivative
/// recovery formula, confirmed by reading both upstream bodies directly, but that one
/// returns an uncertainty window for checking a real driver's own LOD choice rather than
/// one exact value for building a `LodMode::Exact` reference pixel.
fn compute_cube_lod_from_derivates(mode: LodMode, coord: Vec3, coord_dx: Vec3, coord_dy: Vec3, face_size: i32) -> f32 {
    let face = crate::tcu::pixel::select_cube_face(coord.m_data);
    let (ma_ndx, s_ndx, t_ndx) = match face {
        crate::tcu::pixel::CubeFace::NegativeX | crate::tcu::pixel::CubeFace::PositiveX => (0, 2, 1),
        crate::tcu::pixel::CubeFace::NegativeY | crate::tcu::pixel::CubeFace::PositiveY => (1, 0, 2),
        crate::tcu::pixel::CubeFace::NegativeZ | crate::tcu::pixel::CubeFace::PositiveZ => (2, 0, 1),
    };

    let sc = coord.m_data[s_ndx];
    let tc = coord.m_data[t_ndx];
    let ma = coord.m_data[ma_ndx].abs();
    let scdx = coord_dx.m_data[s_ndx];
    let tcdx = coord_dx.m_data[t_ndx];
    let madx = coord_dx.m_data[ma_ndx].abs();
    let scdy = coord_dy.m_data[s_ndx];
    let tcdy = coord_dy.m_data[t_ndx];
    let mady = coord_dy.m_data[ma_ndx].abs();

    let face_size = face_size as f32;
    let dudx = face_size * 0.5 * (scdx * ma - sc * madx) / (ma * ma);
    let dvdx = face_size * 0.5 * (tcdx * ma - tc * madx) / (ma * ma);
    let dudy = face_size * 0.5 * (scdy * ma - sc * mady) / (ma * ma);
    let dvdy = face_size * 0.5 * (tcdy * ma - tc * mady) / (ma * ma);

    compute_lod_from_derivates_2d(mode, dudx, dvdx, dudy, dvdy)
}

/// `sampleTextureCube` - the `TextureCubeView` overload's single reference path (upstream
/// has no separate projected form for a cube lookup at all, unlike 2D).
///
/// `levels` is one `ConstPixelBufferAccess` per mip level, each holding all six faces as
/// depth slices in `tcu::get_cube_array_face_index` order - exactly what
/// `tcu::pixel::sample_cube_mipmap` already expects and what
/// `tcu::texture_cube::TextureCube::level`/`glu::texture_cube::TextureCube::upload` both
/// produce/consume. `tex_coord` is `[s,t,r]` per vertex, 4 vertices (12 floats), in the
/// same `(-1,-1),(-1,1),(1,-1),(1,1)` order every other texture-coordinate array here
/// uses.
pub fn sample_texture_cube(
    dst: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 12],
    params: &ReferenceParams,
) {
    let levels = sub_view(levels, params.base_level, params.max_level);
    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };
    let [dw, dh, _] = dst.size();
    let dst_w = dw as f32;
    let dst_h = dh as f32;
    // Every level holds six faces of the same square size - level 0's own width is the
    // cube's face size, matching upstream's `src.getSize()`.
    let face_size = levels[0].size()[0] as i32;

    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    for py in 0..dh {
        for px in 0..dw {
            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri_ndx = if nx + ny >= 1.0 { 1 } else { 0 };
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let coord = Vec3::new(
                triangle_interpolate_v3(tri_s[tri_ndx], tri_nx, tri_ny),
                triangle_interpolate_v3(tri_t[tri_ndx], tri_nx, tri_ny),
                triangle_interpolate_v3(tri_r[tri_ndx], tri_nx, tri_ny),
            );
            let coord_dx = Vec3::new(
                tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
            );
            let coord_dy = Vec3::new(
                tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
            );

            let lod = (compute_cube_lod_from_derivates(params.lod_mode, coord, coord_dx, coord_dy, face_size)
                + lod_bias)
                .clamp(params.min_lod, params.max_lod);

            let sample = exec_sample_cube(levels, params, coord.x(), coord.y(), coord.z(), lod);
            let color: [f32; 4] = std::array::from_fn(|c| {
                sample[c] * params.base.color_scale.m_data[c] + params.base.color_bias.m_data[c]
            });
            dst.set_pixel(color, px, py, 0);
        }
    }
}

/// `computeQuadTexCoord3D` - `p0 + (p1 - p0) * f`, where `f` is one of four fixed
/// `(0,0,0)/(0,1,0)/(1,0,0)/(1,1,0)` corners swizzled by `dir_swz` (which axis of the
/// resulting `(s,t,r)` coordinate each of those two varying corner components lands
/// on) - a `texture.filtering`-style 3D case varies only two of the three texture axes
/// across the quad and holds the third fixed, and which two varies between its own
/// sub-cases, hence the swizzle rather than a fixed `(s,t)` pairing.
pub fn compute_quad_tex_coord_3d(p0: Vec3, p1: Vec3, dir_swz: [usize; 3]) -> [f32; 12] {
    let corner = |f: Vec3| -> Vec3 {
        let f = f.swizzle(dir_swz);
        Vec3::new(
            p0.x() + (p1.x() - p0.x()) * f.x(),
            p0.y() + (p1.y() - p0.y()) * f.y(),
            p0.z() + (p1.z() - p0.z()) * f.z(),
        )
    };
    let v0 = corner(Vec3::new(0.0, 0.0, 0.0));
    let v1 = corner(Vec3::new(0.0, 1.0, 0.0));
    let v2 = corner(Vec3::new(1.0, 0.0, 0.0));
    let v3 = corner(Vec3::new(1.0, 1.0, 0.0));
    [
        v0.x(),
        v0.y(),
        v0.z(),
        v1.x(),
        v1.y(),
        v1.z(),
        v2.x(),
        v2.y(),
        v2.z(),
        v3.x(),
        v3.y(),
        v3.z(),
    ]
}

/// `execSample` (the `Texture3DView` overload). `SAMPLERTYPE_FLOAT`/`INT`/`UINT` only -
/// upstream's own `Texture3DView` has no `sampleCompare` at all (no 3D shadow sampler
/// exists in GLSL), so there is no `Shadow` arm to add here, unlike `exec_sample_2d`/
/// `exec_sample_cube`.
///
/// `params.sampler.mip_filter` dispatch matches `exec_sample_2d`'s own - see that
/// function's doc comment.
pub(crate) fn exec_sample_3d(
    levels: &[ConstPixelBufferAccess<'_>],
    params: &ReferenceParams,
    s: f32,
    t: f32,
    r: f32,
    lod: f32,
) -> [f32; 4] {
    if params.image_view_min_lod != 0.0 {
        return sample_levels_with_view_min_lod(levels.len(), params, lod, (s, t), |level, sampler| {
            levels[level].sample_3d(sampler, s, t, r)
        });
    }
    let params = &params.effective_for_lod(lod);
    match params.base.sampler_type {
        SamplerType::Float | SamplerType::Int | SamplerType::Uint => match params.sampler.mip_filter {
            Some(mip_filter) => sample_3d_mipmap_filtered(levels, &params.sampler, s, t, r, lod, mip_filter),
            None => sample_3d_mipmap(levels, &params.sampler, s, t, r, lod),
        },
        other => unimplemented!("exec_sample_3d: {other:?} is not ported (see this function's own doc comment)"),
    }
}

/// `sampleTexture` (the `Texture3DView` overload) - **non-projected only**. Upstream's
/// own `sampleTextureProjected(Texture3DView, ...)` overload exists but no grep-confirmed
/// caller (`es3fTextureFilteringTests.cpp`'s `Texture3DFilteringCase`) ever sets
/// `ReferenceParams::PROJECTED` for a 3D case - `RenderParams::new`'s own default here
/// is already `projected: false`, matching that - so only the non-projected path is
/// ported, the same narrowing `sample_texture_cube` makes for an upstream overload it
/// does have (there, because none exists at all; here, because nothing reaches it).
///
/// `tex_coord` is `[s,t,r]` per vertex, 4 vertices (12 floats), the layout
/// `compute_quad_tex_coord_3d` returns.
pub fn sample_texture_3d(
    dst: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 12],
    params: &ReferenceParams,
) {
    let levels = sub_view(levels, params.base_level, params.max_level);
    if params.base.projected {
        sample_texture_projected_3d(dst, levels, tex_coord, params);
        return;
    }
    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };

    let [dw, dh, _] = dst.size();
    let dst_size = IVec2::new(dw as i32, dh as i32);
    let [sw, sh, sd] = levels[0].size();
    let src_size = crate::tcu::vector::IVec3::new(sw as i32, sh as i32, sd as i32);

    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_lod = [
        (compute_non_projected_tri_lod_3d(params.lod_mode, dst_size, src_size, tri_s[0], tri_t[0], tri_r[0])
            + lod_bias)
            .clamp(params.min_lod, params.max_lod),
        (compute_non_projected_tri_lod_3d(params.lod_mode, dst_size, src_size, tri_s[1], tri_t[1], tri_r[1])
            + lod_bias)
            .clamp(params.min_lod, params.max_lod),
    ];

    for y in 0..dh {
        for x in 0..dw {
            let yf = (y as f32 + 0.5) / dh as f32;
            let xf = (x as f32 + 0.5) / dw as f32;

            let tri_ndx = if xf + yf >= 1.0 { 1 } else { 0 };
            let tri_x = if tri_ndx == 1 { 1.0 - xf } else { xf };
            let tri_y = if tri_ndx == 1 { 1.0 - yf } else { yf };

            let s = triangle_interpolate_v3(tri_s[tri_ndx], tri_x, tri_y);
            let t = triangle_interpolate_v3(tri_t[tri_ndx], tri_x, tri_y);
            let r = triangle_interpolate_v3(tri_r[tri_ndx], tri_x, tri_y);
            let lod = tri_lod[tri_ndx];
            let lod = if params.image_view_min_lod != 0.0 && params.base.sampler_type == SamplerType::FetchFloat {
                params.lod_texel_fetch as f32
            } else {
                lod
            };

            let sample = exec_sample_3d(levels, params, s, t, r, lod);
            let color: [f32; 4] = std::array::from_fn(|c| {
                sample[c] * params.base.color_scale.m_data[c] + params.base.color_bias.m_data[c]
            });
            dst.set_pixel(color, x, y, 0);
        }
    }
}

/// `sampleTextureProjected` (the `Texture3DView` overload)
fn sample_texture_projected_3d(
    dst: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 12],
    params: &ReferenceParams,
) {
    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };
    let [dw, dh, _] = dst.size();
    let dst_w = dw as f32;
    let dst_h = dh as f32;
    let [sw, sh, sd] = levels[0].size();

    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);
    let uq: Vec4 = Vec4::from_array(std::array::from_fn(|c| sq.m_data[c] * sw as f32));
    let vq: Vec4 = Vec4::from_array(std::array::from_fn(|c| tq.m_data[c] * sh as f32));
    let wq: Vec4 = Vec4::from_array(std::array::from_fn(|c| rq.m_data[c] * sd as f32));

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_u = [uq.swizzle([0, 1, 2]), uq.swizzle([3, 2, 1])];
    let tri_v = [vq.swizzle([0, 1, 2]), vq.swizzle([3, 2, 1])];
    let tri_w = [wq.swizzle([0, 1, 2]), wq.swizzle([3, 2, 1])];
    let tri_p = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    for py in 0..dh {
        for px in 0..dw {
            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri_ndx = if nx + ny >= 1.0 { 1 } else { 0 };
            let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
            let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let s = projected_tri_interpolate(tri_s[tri_ndx], tri_p[tri_ndx], tri_nx, tri_ny);
            let t = projected_tri_interpolate(tri_t[tri_ndx], tri_p[tri_ndx], tri_nx, tri_ny);
            let r = projected_tri_interpolate(tri_r[tri_ndx], tri_p[tri_ndx], tri_nx, tri_ny);
            let lod = compute_projected_tri_lod_3d(
                params.lod_mode,
                tri_u[tri_ndx],
                tri_v[tri_ndx],
                tri_w[tri_ndx],
                tri_p[tri_ndx],
                tri_wx,
                tri_wy,
                dst_w,
                dst_h,
            ) + lod_bias;

            let sample = exec_sample_3d(levels, params, s, t, r, lod);
            let color: [f32; 4] = std::array::from_fn(|c| {
                sample[c] * params.base.color_scale.m_data[c] + params.base.color_bias.m_data[c]
            });
            dst.set_pixel(color, px, py, 0);
        }
    }
}

/// `glu::TextureTestUtil`'s own anonymous `MIN_SUBPIXEL_BITS` enum constant - shared by
/// every `computeTextureLookupDiff` overload, not just the 2D one below.
const MIN_SUBPIXEL_BITS: i32 = 4;

/// `tcu::Sampler::WrapMode` (pixel's production-side wrap enum) to `tcu::tex_verifier::
/// WrapMode` (the verification-side one) - the two are independently defined, identically-
/// shaped enums (see `tex_verifier::WrapMode`'s own doc comment and `tex_compare_verifier.rs`'s
/// `use super::tex_verifier::{... WrapMode ...}`, which already established that the
/// verifier always takes its own `WrapMode`, never `pixel::Sampler`'s), so a caller that
/// has a `Sampler` built for the *production* (reference-image) side - every
/// `ReferenceParams::sampler` here - needs this to hand its wrap modes to a verifier
/// function at all.
fn to_verifier_wrap_mode(w: PixelWrapMode) -> WrapMode {
    match w {
        PixelWrapMode::ClampToEdge => WrapMode::ClampToEdge,
        PixelWrapMode::ClampToBorder => WrapMode::ClampToBorder,
        PixelWrapMode::Repeat => WrapMode::Repeat,
        PixelWrapMode::MirroredRepeat => WrapMode::MirroredRepeat,
        PixelWrapMode::MirroredOnce => WrapMode::MirroredOnce,
    }
}

/// `Sampler::minFilter`, reconstructed as `tcu::tex_verifier::MinFilterMode` from this
/// port's own `(filter, mip_filter)` pair - see `pixel::Sampler`'s own doc comment for
/// why that pair exists instead of upstream's single 9-variant `FilterMode` field.
/// Matches `exec_sample_2d`'s own dispatch exactly (`mip_filter: None` is the implicit
/// `*_MIPMAP_NEAREST` shape every `sample_2d_mipmap` caller already gets, `Some(mode)` is
/// `*_MIPMAP_LINEAR`/`*_MIPMAP_NEAREST` chosen by `mode`) - the verifier has to search the
/// exact same levels the reference image was actually built from, or a conformant driver
/// answer at a level this function never considers would be reported as a failure.
fn sampler_min_filter_mode(sampler: &Sampler) -> MinFilterMode {
    match (sampler.filter, sampler.mip_filter) {
        (FilterMode::Nearest, None) | (FilterMode::Nearest, Some(MipmapFilterMode::Nearest)) => {
            MinFilterMode::NearestMipmapNearest
        }
        (FilterMode::Nearest, Some(MipmapFilterMode::Linear)) => MinFilterMode::NearestMipmapLinear,
        (FilterMode::Linear, None) | (FilterMode::Linear, Some(MipmapFilterMode::Nearest)) => {
            MinFilterMode::LinearMipmapNearest
        }
        (FilterMode::Linear, Some(MipmapFilterMode::Linear)) => MinFilterMode::LinearMipmapLinear,
        (FilterMode::Cubic, _) => unimplemented!(
            "compute_texture_lookup_diff_2d: cubic filtering is not ported, matching tex_verifier's own narrowing"
        ),
    }
}

/// `glu::computeTextureLookupDiff` for `Texture2DView` - given a driver's own rendered
/// `result` image and the reference image `sample_texture_2d` built for the same quad,
/// decides per pixel whether `result` could be a conformant answer, by re-deriving that
/// pixel's own texture coordinate and LOD-bounds *window* (not the single ideal LOD
/// `sample_texture_non_projected_2d`/`_projected_2d` use to pick one reference colour -
/// a driver is free to land anywhere a real rasterizer's derivative uncertainty allows)
/// and handing both to `tcu::tex_verifier::is_lookup_result_valid_2d`. Writes every
/// failing pixel red into `error_mask` (green elsewhere, upstream's own
/// `tcu::RGBA::green()`/`red()` convention) and returns the failure count.
///
/// A pixel whose `result`/`reference` colours already agree within `lookup_prec`'s own
/// `color_threshold` skips the expensive per-pixel geometry entirely and counts as a
/// pass - upstream's own fast path, confirmed directly against `computeTextureLookupDiff`
/// rather than assumed, and not merely an optimization: the geometric search below is a
/// *superset* check (loosening it to cover both triangles' candidate windows near a
/// shared edge, where a pixel's own output is ambiguous), not a cheaper equivalent of it.
///
/// Narrowed from upstream the same way the rest of this file already is (see its own top
/// doc comment): no `baseLevel`/`maxLevel`/`imageViewMinLod` slicing (`levels` is already
/// exactly the mip range to search), `lod_threshold` hardcoded to `0.0` (`Sampler::
/// lodThreshold`'s own upstream default - this port's `Sampler` carries no field for it,
/// matching the `border_color`-is-a-caller-argument reasoning `tcu::tex_verifier::
/// LookupPrecision`'s own doc comment gives for the same kind of gap), and no watchdog
/// (there is no long-running native test harness pumping one here).
#[allow(clippy::too_many_arguments)]
pub fn compute_texture_lookup_diff_2d(
    result: &ConstPixelBufferAccess<'_>,
    reference: &ConstPixelBufferAccess<'_>,
    error_mask: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 8],
    params: &ReferenceParams,
    lookup_prec: &LookupPrecision,
    lod_prec: &LodPrecision,
) -> i32 {
    let [rw, rh, _] = result.size();
    debug_assert_eq!(result.size(), reference.size());
    debug_assert_eq!(result.size(), error_mask.size());

    let sq = Vec4::new(tex_coord[0], tex_coord[2], tex_coord[4], tex_coord[6]);
    let tq = Vec4::new(tex_coord[1], tex_coord[3], tex_coord[5], tex_coord[7]);

    let dst_w = rw as f32;
    let dst_h = rh as f32;
    let [sw, sh, _] = levels[0].size();
    let src_size = Vec2::new(sw as f32, sh as f32);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };
    let pos_eps = 1.0 / (1i32 << MIN_SUBPIXEL_BITS) as f32;

    let wrap_s = to_verifier_wrap_mode(params.sampler.wrap_s);
    let wrap_t = to_verifier_wrap_mode(params.sampler.wrap_t);
    let min_filter = sampler_min_filter_mode(&params.sampler);
    let mag_filter = params.mag_filter.unwrap_or(params.sampler.filter);
    let normalized_coords = params.sampler.normalized_coords;

    const LOD_OFFSETS: [[f32; 2]; 4] = [[-1.0, 0.0], [1.0, 0.0], [0.0, -1.0], [0.0, 1.0]];

    let mut num_failed = 0;

    clear(error_mask, RGBA::green().to_vec().m_data);

    for py in 0..rh {
        for px in 0..rw {
            let res_pix = result.get_pixel(px, py, 0);
            let ref_pix = reference.get_pixel(px, py, 0);
            let res_adj: [f32; 4] = std::array::from_fn(|c| {
                (res_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });
            let ref_adj: [f32; 4] = std::array::from_fn(|c| {
                (ref_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });

            if (0..4usize).all(|c| (res_adj[c] - ref_adj[c]).abs() <= lookup_prec.color_threshold[c]) {
                continue;
            }

            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri0 = (wx - pos_eps) / dst_w + (wy - pos_eps) / dst_h <= 1.0;
            let tri1 = (wx + pos_eps) / dst_w + (wy + pos_eps) / dst_h >= 1.0;
            debug_assert!(tri0 || tri1);

            let mut is_ok = false;

            // A pixel can belong to either triangle if it lies close enough to the
            // shared edge - matching upstream's `for (triNdx = tri0 ? 0 : 1; triNdx <=
            // tri1 ? 1 : 0; triNdx++)` exactly.
            let tri_lo: usize = if tri0 { 0 } else { 1 };
            let tri_hi: usize = if tri1 { 1 } else { 0 };
            for tri_ndx in tri_lo..=tri_hi {
                let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
                let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
                let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
                let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

                let coord = [
                    projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                    projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                ];
                let coord_dx = [
                    tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.x(),
                    tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.y(),
                ];
                let coord_dy = [
                    tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.x(),
                    tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.y(),
                ];

                let mut lod_bounds = compute_lod_bounds_from_derivates(
                    coord_dx[0],
                    coord_dx[1],
                    0.0,
                    coord_dy[0],
                    coord_dy[1],
                    0.0,
                    lod_prec,
                );

                // Widen the bounds across the four neighbouring pixels too - a driver's
                // own derivative estimate (`dFdx`/`dFdy`) is itself only an estimate,
                // typically taken as a finite difference against a neighbour.
                for lod_offset in LOD_OFFSETS {
                    let wxo = tri_wx + lod_offset[0];
                    let wyo = tri_wy + lod_offset[1];
                    let nxo = wxo / dst_w;
                    let nyo = wyo / dst_h;

                    let coord_dxo = [
                        tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.x(),
                        tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.y(),
                    ];
                    let coord_dyo = [
                        tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.x(),
                        tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.y(),
                    ];
                    let lod_o = compute_lod_bounds_from_derivates(
                        coord_dxo[0],
                        coord_dxo[1],
                        0.0,
                        coord_dyo[0],
                        coord_dyo[1],
                        0.0,
                        lod_prec,
                    );

                    lod_bounds.0 = lod_bounds.0.min(lod_o.0);
                    lod_bounds.1 = lod_bounds.1.max(lod_o.1);
                }

                let clamped_lod = clamp_lod_bounds(
                    (lod_bounds.0 + lod_bias, lod_bounds.1 + lod_bias),
                    params.lod_range_for_diff(),
                    lod_prec,
                );

                if is_lookup_result_valid_2d(
                    levels,
                    wrap_s,
                    wrap_t,
                    normalized_coords,
                    min_filter,
                    mag_filter,
                    0.0,
                    lookup_prec,
                    coord,
                    clamped_lod,
                    res_adj,
                ) {
                    is_ok = true;
                    break;
                }
            }

            if !is_ok {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `glu::computeTextureLookupDiff` for `Texture2DArrayView` - the array counterpart of
/// `compute_texture_lookup_diff_2d` above. Read that function's own doc comment first for
/// the fast-path/narrowing notes shared by both; this one's own doc comment (on the module
/// top, where the two are compared side by side) covers the one real shape difference: no
/// `tri0`/`tri1` edge-widening here, matching upstream's own simpler `triNdx` pick for this
/// overload.
///
/// `levels[0].size()`'s third component is the array's own layer count
/// (`tcu::Texture2DArrayView::getNumLayers`) - `sample_texture_2d_array` already reads the
/// same field as `src_size`'s ignored third component, confirmed by reading that function
/// first rather than guessing the layout.
#[allow(clippy::too_many_arguments)]
pub fn compute_texture_lookup_diff_2d_array(
    result: &ConstPixelBufferAccess<'_>,
    reference: &ConstPixelBufferAccess<'_>,
    error_mask: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 12],
    params: &ReferenceParams,
    lookup_prec: &LookupPrecision,
    lod_prec: &LodPrecision,
) -> i32 {
    let [rw, rh, _] = result.size();
    debug_assert_eq!(result.size(), reference.size());
    debug_assert_eq!(result.size(), error_mask.size());

    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);

    let dst_w = rw as f32;
    let dst_h = rh as f32;
    let [sw, sh, num_layers] = levels[0].size();
    let src_size = Vec2::new(sw as f32, sh as f32);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };

    let wrap_s = to_verifier_wrap_mode(params.sampler.wrap_s);
    let wrap_t = to_verifier_wrap_mode(params.sampler.wrap_t);
    let min_filter = sampler_min_filter_mode(&params.sampler);
    let mag_filter = params.mag_filter.unwrap_or(params.sampler.filter);
    let normalized_coords = params.sampler.normalized_coords;

    const LOD_OFFSETS: [[f32; 2]; 4] = [[-1.0, 0.0], [1.0, 0.0], [0.0, -1.0], [0.0, 1.0]];

    let mut num_failed = 0;

    clear(error_mask, RGBA::green().to_vec().m_data);

    for py in 0..rh {
        for px in 0..rw {
            let res_pix = result.get_pixel(px, py, 0);
            let ref_pix = reference.get_pixel(px, py, 0);
            let res_adj: [f32; 4] = std::array::from_fn(|c| {
                (res_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });
            let ref_adj: [f32; 4] = std::array::from_fn(|c| {
                (ref_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });

            if (0..4usize).all(|c| (res_adj[c] - ref_adj[c]).abs() <= lookup_prec.color_threshold[c]) {
                continue;
            }

            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            // No `tri0`/`tri1` edge-widening in this overload - see this function's own
            // doc comment, confirmed directly against upstream.
            let tri_ndx: usize = if nx + ny >= 1.0 { 1 } else { 0 };
            let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
            let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let coord = [
                projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
            ];
            let coord_dx = [
                tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.x(),
                tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.y(),
            ];
            let coord_dy = [
                tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.x(),
                tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.y(),
            ];

            let mut lod_bounds = compute_lod_bounds_from_derivates(
                coord_dx[0],
                coord_dx[1],
                0.0,
                coord_dy[0],
                coord_dy[1],
                0.0,
                lod_prec,
            );

            for lod_offset in LOD_OFFSETS {
                let wxo = tri_wx + lod_offset[0];
                let wyo = tri_wy + lod_offset[1];
                let nxo = wxo / dst_w;
                let nyo = wyo / dst_h;

                let coord_dxo = [
                    tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.x(),
                    tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.y(),
                ];
                let coord_dyo = [
                    tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.x(),
                    tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.y(),
                ];
                let lod_o = compute_lod_bounds_from_derivates(
                    coord_dxo[0],
                    coord_dxo[1],
                    0.0,
                    coord_dyo[0],
                    coord_dyo[1],
                    0.0,
                    lod_prec,
                );

                lod_bounds.0 = lod_bounds.0.min(lod_o.0);
                lod_bounds.1 = lod_bounds.1.max(lod_o.1);
            }

            let clamped_lod = clamp_lod_bounds(
                (lod_bounds.0 + lod_bias, lod_bounds.1 + lod_bias),
                (params.min_lod, params.max_lod),
                lod_prec,
            );

            let is_ok = is_lookup_result_valid_2d_array(
                levels,
                num_layers as i32,
                wrap_s,
                wrap_t,
                normalized_coords,
                min_filter,
                mag_filter,
                0.0,
                lookup_prec,
                coord,
                clamped_lod,
                res_adj,
            );

            if !is_ok {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `glu::computeTextureLookupDiff` for `Texture3DView` - unlike the 2D-array overload
/// above, this one keeps the full `tri0`/`tri1` edge-widening search
/// `compute_texture_lookup_diff_2d` has (confirmed directly: upstream's 3D body is the 2D
/// one with a third, depth axis threaded through every `Vec2` -> `Vec3`, not the
/// 2D-array body's simplified single-`triNdx` pick) - so `coord`/`coord_dx`/`coord_dy` are
/// 3-wide here and `compute_lod_bounds_from_derivates` gets a real (non-zero) third
/// component on both axes, where the 2D/2D-array overloads always pass `0.0` for it.
/// Needs `wrap_r` (`pixel::Sampler::wrap_r`, unused by every 2D-shaped overload above) via
/// `to_verifier_wrap_mode`.
#[allow(clippy::too_many_arguments)]
pub fn compute_texture_lookup_diff_3d(
    result: &ConstPixelBufferAccess<'_>,
    reference: &ConstPixelBufferAccess<'_>,
    error_mask: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 12],
    params: &ReferenceParams,
    lookup_prec: &LookupPrecision,
    lod_prec: &LodPrecision,
) -> i32 {
    let [rw, rh, _] = result.size();
    debug_assert_eq!(result.size(), reference.size());
    debug_assert_eq!(result.size(), error_mask.size());

    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);

    let dst_w = rw as f32;
    let dst_h = rh as f32;
    let [sw, sh, sd] = levels[0].size();
    let src_size = Vec3::new(sw as f32, sh as f32, sd as f32);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };
    let pos_eps = 1.0 / (1i32 << MIN_SUBPIXEL_BITS) as f32;

    let wrap_s = to_verifier_wrap_mode(params.sampler.wrap_s);
    let wrap_t = to_verifier_wrap_mode(params.sampler.wrap_t);
    let wrap_r = to_verifier_wrap_mode(params.sampler.wrap_r);
    let min_filter = sampler_min_filter_mode(&params.sampler);
    let mag_filter = params.mag_filter.unwrap_or(params.sampler.filter);
    let normalized_coords = params.sampler.normalized_coords;

    const LOD_OFFSETS: [[f32; 2]; 4] = [[-1.0, 0.0], [1.0, 0.0], [0.0, -1.0], [0.0, 1.0]];

    let mut num_failed = 0;

    clear(error_mask, RGBA::green().to_vec().m_data);

    for py in 0..rh {
        for px in 0..rw {
            let res_pix = result.get_pixel(px, py, 0);
            let ref_pix = reference.get_pixel(px, py, 0);
            let res_adj: [f32; 4] = std::array::from_fn(|c| {
                (res_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });
            let ref_adj: [f32; 4] = std::array::from_fn(|c| {
                (ref_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });

            if (0..4usize).all(|c| (res_adj[c] - ref_adj[c]).abs() <= lookup_prec.color_threshold[c]) {
                continue;
            }

            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri0 = (wx - pos_eps) / dst_w + (wy - pos_eps) / dst_h <= 1.0;
            let tri1 = (wx + pos_eps) / dst_w + (wy + pos_eps) / dst_h >= 1.0;
            debug_assert!(tri0 || tri1);

            let mut is_ok = false;

            let tri_lo: usize = if tri0 { 0 } else { 1 };
            let tri_hi: usize = if tri1 { 1 } else { 0 };
            for tri_ndx in tri_lo..=tri_hi {
                let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
                let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
                let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
                let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

                let coord = [
                    projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                    projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                    projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                ];
                let coord_dx = [
                    tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.x(),
                    tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.y(),
                    tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.z(),
                ];
                let coord_dy = [
                    tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.x(),
                    tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.y(),
                    tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.z(),
                ];

                let mut lod_bounds = compute_lod_bounds_from_derivates(
                    coord_dx[0],
                    coord_dx[1],
                    coord_dx[2],
                    coord_dy[0],
                    coord_dy[1],
                    coord_dy[2],
                    lod_prec,
                );

                for lod_offset in LOD_OFFSETS {
                    let wxo = tri_wx + lod_offset[0];
                    let wyo = tri_wy + lod_offset[1];
                    let nxo = wxo / dst_w;
                    let nyo = wyo / dst_h;

                    let coord_dxo = [
                        tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.x(),
                        tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.y(),
                        tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.z(),
                    ];
                    let coord_dyo = [
                        tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.x(),
                        tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.y(),
                        tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.z(),
                    ];
                    let lod_o = compute_lod_bounds_from_derivates(
                        coord_dxo[0],
                        coord_dxo[1],
                        coord_dxo[2],
                        coord_dyo[0],
                        coord_dyo[1],
                        coord_dyo[2],
                        lod_prec,
                    );

                    lod_bounds.0 = lod_bounds.0.min(lod_o.0);
                    lod_bounds.1 = lod_bounds.1.max(lod_o.1);
                }

                let clamped_lod = clamp_lod_bounds(
                    (lod_bounds.0 + lod_bias, lod_bounds.1 + lod_bias),
                    params.lod_range_for_diff(),
                    lod_prec,
                );

                if is_lookup_result_valid_3d(
                    levels,
                    wrap_s,
                    wrap_t,
                    wrap_r,
                    normalized_coords,
                    min_filter,
                    mag_filter,
                    0.0,
                    lookup_prec,
                    coord,
                    clamped_lod,
                    res_adj,
                ) {
                    is_ok = true;
                    break;
                }
            }

            if !is_ok {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `glu::computeTextureLookupDiff` for `TextureCubeView` - keeps the same `tri0`/`tri1`
/// edge-widening loop `compute_texture_lookup_diff_3d` has, but otherwise is **not** a
/// mechanical copy of either sibling - confirmed by reading `gluTextureTestUtil.cpp`'s
/// cube body directly (lines ~1860-1920):
///
///  - `coordDx`/`coordDy` are **not** multiplied by a src-size vector the way the 2D/3D
///    siblings' are - `tcu::tex_verifier::compute_cube_lod_bounds_from_derivates` already
///    multiplies by `face_size` internally (the same quotient-rule formula
///    `compute_cube_lod_from_derivates`, this file's own reference-production-side
///    sibling, uses - see that function's own doc comment), so doing it again here would
///    double-apply the scale.
///  - the neighbour-offset loop recomputes a fresh `coord_o` (the direction vector) at
///    each offset position, not just `coord_dxo`/`coord_dyo` - `compute_cube_lod_bounds_
///    from_derivates` needs the coordinate itself (to pick which cube face and to divide
///    by `ma^2`), unlike the plain `compute_lod_bounds_from_derivates` the 2D/2D-array/3D
///    overloads call, which only ever needs the derivatives.
///  - the neighbour-offset set has **8** entries, not 4 - the extra diagonal four match
///    upstream's own code comment verbatim ("Not strictly allowed by spec, but
///    implementations do this in practice").
///
/// `is_lookup_result_valid_cube` takes no `wrap_s`/`wrap_t` at all (a cube face's edge
/// behaviour is `seamless_cube_map`/per-face clamping, not a `WrapMode`), so this function
/// needs no `to_verifier_wrap_mode` call anywhere, unlike every overload above it.
#[allow(clippy::too_many_arguments)]
pub fn compute_texture_lookup_diff_cube(
    result: &ConstPixelBufferAccess<'_>,
    reference: &ConstPixelBufferAccess<'_>,
    error_mask: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 12],
    params: &ReferenceParams,
    lookup_prec: &LookupPrecision,
    lod_prec: &LodPrecision,
) -> i32 {
    let [rw, rh, _] = result.size();
    debug_assert_eq!(result.size(), reference.size());
    debug_assert_eq!(result.size(), error_mask.size());

    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);

    let dst_w = rw as f32;
    let dst_h = rh as f32;
    // Every level holds six faces of the same square size - level 0's own width is the
    // cube's face size, matching upstream's `src.getSize()` (same reasoning as
    // `sample_texture_cube`'s own comment).
    let face_size = levels[0].size()[0] as i32;

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };
    let pos_eps = 1.0 / (1i32 << MIN_SUBPIXEL_BITS) as f32;

    let seamless_cube_map = params.sampler.seamless_cube_map;
    let min_filter = sampler_min_filter_mode(&params.sampler);
    let mag_filter = params.mag_filter.unwrap_or(params.sampler.filter);
    let normalized_coords = params.sampler.normalized_coords;

    // Upstream's own comment, kept verbatim: "Not strictly allowed by spec, but
    // implementations do this in practice" - the diagonal four entries beyond the plain
    // 2D/2D-array/3D `LOD_OFFSETS` set.
    const LOD_OFFSETS: [[f32; 2]; 8] = [
        [-1.0, 0.0],
        [1.0, 0.0],
        [0.0, -1.0],
        [0.0, 1.0],
        [-1.0, -1.0],
        [-1.0, 1.0],
        [1.0, -1.0],
        [1.0, 1.0],
    ];

    let mut num_failed = 0;

    clear(error_mask, RGBA::green().to_vec().m_data);

    for py in 0..rh {
        for px in 0..rw {
            let res_pix = result.get_pixel(px, py, 0);
            let ref_pix = reference.get_pixel(px, py, 0);
            let res_adj: [f32; 4] = std::array::from_fn(|c| {
                (res_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });
            let ref_adj: [f32; 4] = std::array::from_fn(|c| {
                (ref_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });

            if (0..4usize).all(|c| (res_adj[c] - ref_adj[c]).abs() <= lookup_prec.color_threshold[c]) {
                continue;
            }

            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri0 = (wx - pos_eps) / dst_w + (wy - pos_eps) / dst_h <= 1.0;
            let tri1 = (wx + pos_eps) / dst_w + (wy + pos_eps) / dst_h >= 1.0;
            debug_assert!(tri0 || tri1);

            let mut is_ok = false;

            let tri_lo: usize = if tri0 { 0 } else { 1 };
            let tri_hi: usize = if tri1 { 1 } else { 0 };
            for tri_ndx in tri_lo..=tri_hi {
                let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
                let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
                let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
                let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

                let coord = [
                    projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                    projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                    projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                ];
                let coord_dx = [
                    tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                    tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                    tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                ];
                let coord_dy = [
                    tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                    tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                    tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                ];

                let mut lod_bounds =
                    compute_cube_lod_bounds_from_derivates(coord, coord_dx, coord_dy, face_size, lod_prec);

                for lod_offset in LOD_OFFSETS {
                    let wxo = tri_wx + lod_offset[0];
                    let wyo = tri_wy + lod_offset[1];
                    let nxo = wxo / dst_w;
                    let nyo = wyo / dst_h;

                    let coord_o = [
                        projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                        projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                        projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                    ];
                    let coord_dxo = [
                        tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                        tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                        tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                    ];
                    let coord_dyo = [
                        tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                        tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                        tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                    ];
                    let lod_o =
                        compute_cube_lod_bounds_from_derivates(coord_o, coord_dxo, coord_dyo, face_size, lod_prec);

                    lod_bounds.0 = lod_bounds.0.min(lod_o.0);
                    lod_bounds.1 = lod_bounds.1.max(lod_o.1);
                }

                let clamped_lod = clamp_lod_bounds(
                    (lod_bounds.0 + lod_bias, lod_bounds.1 + lod_bias),
                    params.lod_range_for_diff(),
                    lod_prec,
                );

                if is_lookup_result_valid_cube(
                    levels,
                    normalized_coords,
                    seamless_cube_map,
                    min_filter,
                    mag_filter,
                    0.0,
                    lookup_prec,
                    coord,
                    clamped_lod,
                    res_adj,
                ) {
                    is_ok = true;
                    break;
                }
            }

            if !is_ok {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `glu::computeTextureCompareDiff` for `Texture2DView` - the shadow-sampler counterpart
/// of `compute_texture_lookup_diff_2d`, needed once a `texture.filtering`/`gather` shadow
/// case is ported. Read upstream's body directly rather than assumed from the lookup-diff
/// shape, and it differs in several real ways:
///
///  - no colour-scale/bias adjustment at all (a shadow result is a raw 0/1 compare, not a
///    colour `RenderParams::color_scale`/`color_bias` ever touches),
///  - channels 1-3 (g/b/a) are checked against `non_shadow_threshold` *first*, and any
///    channel outside it fails the pixel immediately without reaching the verifier at
///    all - these channels are always `(0, 0, 1)` by `exec_sample_2d`'s own shadow
///    packing, so this is really a sanity check on how `sample_texture_2d` filled them,
///    not a second real pass/fail path,
///  - the colour-threshold fast path is **exact equality** on channel 0
///    (`res_pix[0] == ref_pix[0]`), not a `color_threshold`-sized window - a shadow
///    compare result is already quantized to what the reference image itself produced,
///    so "equal" is the only value a driver can match without needing verification,
///  - single `triNdx` pick, no `tri0`/`tri1` edge-widening (matching the 2D-array lookup
///    overload's own shape, not the 2D lookup overload's).
///
/// Reuses `tcu::tex_compare_verifier::is_tex_compare_result_valid_2d`, which takes the
/// full `Sampler` (for `compare`/`compare_channel`) *and* the already-bridged
/// `wrap_s`/`wrap_t`/`min_filter` this file's own `to_verifier_wrap_mode`/
/// `sampler_min_filter_mode` produce - confirmed by reading that function's own doc
/// comment, which explains why both are needed side by side.
#[allow(clippy::too_many_arguments)]
pub fn compute_texture_compare_diff_2d(
    result: &ConstPixelBufferAccess<'_>,
    reference: &ConstPixelBufferAccess<'_>,
    error_mask: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 8],
    params: &ReferenceParams,
    compare_prec: &TexComparePrecision,
    lod_prec: &LodPrecision,
    non_shadow_threshold: [f32; 3],
) -> i32 {
    let [rw, rh, _] = result.size();
    debug_assert_eq!(result.size(), reference.size());
    debug_assert_eq!(result.size(), error_mask.size());

    let sq = Vec4::new(tex_coord[0], tex_coord[2], tex_coord[4], tex_coord[6]);
    let tq = Vec4::new(tex_coord[1], tex_coord[3], tex_coord[5], tex_coord[7]);

    let dst_w = rw as f32;
    let dst_h = rh as f32;
    let [sw, sh, _] = levels[0].size();
    let src_size = Vec2::new(sw as f32, sh as f32);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };

    let wrap_s = to_verifier_wrap_mode(params.sampler.wrap_s);
    let wrap_t = to_verifier_wrap_mode(params.sampler.wrap_t);
    let min_filter = sampler_min_filter_mode(&params.sampler);
    let mag_filter = params.mag_filter.unwrap_or(params.sampler.filter);

    const LOD_OFFSETS: [[f32; 2]; 4] = [[-1.0, 0.0], [1.0, 0.0], [0.0, -1.0], [0.0, 1.0]];

    let mut num_failed = 0;

    clear(error_mask, RGBA::green().to_vec().m_data);

    for py in 0..rh {
        for px in 0..rw {
            let res_pix = result.get_pixel(px, py, 0);
            let ref_pix = reference.get_pixel(px, py, 0);

            // Other channels should trivially match the reference.
            if (1..4usize).any(|c| (ref_pix[c] - res_pix[c]).abs() > non_shadow_threshold[c - 1]) {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
                continue;
            }

            // Reference result is known to be a valid result - skip verification if the
            // two already agree exactly.
            if res_pix[0] == ref_pix[0] {
                continue;
            }

            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri_ndx: usize = if nx + ny >= 1.0 { 1 } else { 0 };
            let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
            let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let coord = [
                projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
            ];
            let coord_dx = [
                tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.x(),
                tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.y(),
            ];
            let coord_dy = [
                tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.x(),
                tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.y(),
            ];

            let mut lod_bounds = compute_lod_bounds_from_derivates(
                coord_dx[0],
                coord_dx[1],
                0.0,
                coord_dy[0],
                coord_dy[1],
                0.0,
                lod_prec,
            );

            for lod_offset in LOD_OFFSETS {
                let wxo = tri_wx + lod_offset[0];
                let wyo = tri_wy + lod_offset[1];
                let nxo = wxo / dst_w;
                let nyo = wyo / dst_h;

                let coord_dxo = [
                    tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.x(),
                    tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.y(),
                ];
                let coord_dyo = [
                    tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.x(),
                    tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.y(),
                ];
                let lod_o = compute_lod_bounds_from_derivates(
                    coord_dxo[0],
                    coord_dxo[1],
                    0.0,
                    coord_dyo[0],
                    coord_dyo[1],
                    0.0,
                    lod_prec,
                );

                lod_bounds.0 = lod_bounds.0.min(lod_o.0);
                lod_bounds.1 = lod_bounds.1.max(lod_o.1);
            }

            let clamped_lod = clamp_lod_bounds(
                (lod_bounds.0 + lod_bias, lod_bounds.1 + lod_bias),
                (params.min_lod, params.max_lod),
                lod_prec,
            );

            let is_ok = is_tex_compare_result_valid_2d(
                levels,
                &params.sampler,
                wrap_s,
                wrap_t,
                min_filter,
                mag_filter,
                0.0,
                compare_prec,
                coord,
                clamped_lod,
                params.base.ref_,
                res_pix[0],
            );

            if !is_ok {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `glu::computeTextureCompareDiff` for `Texture2DArrayView` - `compute_texture_compare_diff_2d`'s
/// own body with an added layer axis, the same way `compute_texture_lookup_diff_2d_array`
/// relates to `compute_texture_lookup_diff_2d` - confirmed directly against upstream's
/// body rather than assumed, including that it keeps the single-`triNdx` shape (no
/// `tri0`/`tri1` edge-widening here either).
#[allow(clippy::too_many_arguments)]
pub fn compute_texture_compare_diff_2d_array(
    result: &ConstPixelBufferAccess<'_>,
    reference: &ConstPixelBufferAccess<'_>,
    error_mask: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 12],
    params: &ReferenceParams,
    compare_prec: &TexComparePrecision,
    lod_prec: &LodPrecision,
    non_shadow_threshold: [f32; 3],
) -> i32 {
    let [rw, rh, _] = result.size();
    debug_assert_eq!(result.size(), reference.size());
    debug_assert_eq!(result.size(), error_mask.size());

    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);

    let dst_w = rw as f32;
    let dst_h = rh as f32;
    let [sw, sh, num_layers] = levels[0].size();
    let src_size = Vec2::new(sw as f32, sh as f32);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };

    let wrap_s = to_verifier_wrap_mode(params.sampler.wrap_s);
    let wrap_t = to_verifier_wrap_mode(params.sampler.wrap_t);
    let min_filter = sampler_min_filter_mode(&params.sampler);
    let mag_filter = params.mag_filter.unwrap_or(params.sampler.filter);

    const LOD_OFFSETS: [[f32; 2]; 4] = [[-1.0, 0.0], [1.0, 0.0], [0.0, -1.0], [0.0, 1.0]];

    let mut num_failed = 0;

    clear(error_mask, RGBA::green().to_vec().m_data);

    for py in 0..rh {
        for px in 0..rw {
            let res_pix = result.get_pixel(px, py, 0);
            let ref_pix = reference.get_pixel(px, py, 0);

            if (1..4usize).any(|c| (ref_pix[c] - res_pix[c]).abs() > non_shadow_threshold[c - 1]) {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
                continue;
            }

            if res_pix[0] == ref_pix[0] {
                continue;
            }

            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri_ndx: usize = if nx + ny >= 1.0 { 1 } else { 0 };
            let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
            let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let coord = [
                projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
            ];
            let coord_dx = [
                tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.x(),
                tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny) * src_size.y(),
            ];
            let coord_dy = [
                tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.x(),
                tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx) * src_size.y(),
            ];

            let mut lod_bounds = compute_lod_bounds_from_derivates(
                coord_dx[0],
                coord_dx[1],
                0.0,
                coord_dy[0],
                coord_dy[1],
                0.0,
                lod_prec,
            );

            for lod_offset in LOD_OFFSETS {
                let wxo = tri_wx + lod_offset[0];
                let wyo = tri_wy + lod_offset[1];
                let nxo = wxo / dst_w;
                let nyo = wyo / dst_h;

                let coord_dxo = [
                    tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.x(),
                    tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo) * src_size.y(),
                ];
                let coord_dyo = [
                    tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.x(),
                    tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo) * src_size.y(),
                ];
                let lod_o = compute_lod_bounds_from_derivates(
                    coord_dxo[0],
                    coord_dxo[1],
                    0.0,
                    coord_dyo[0],
                    coord_dyo[1],
                    0.0,
                    lod_prec,
                );

                lod_bounds.0 = lod_bounds.0.min(lod_o.0);
                lod_bounds.1 = lod_bounds.1.max(lod_o.1);
            }

            let clamped_lod = clamp_lod_bounds(
                (lod_bounds.0 + lod_bias, lod_bounds.1 + lod_bias),
                (params.min_lod, params.max_lod),
                lod_prec,
            );

            let is_ok = is_tex_compare_result_valid_2d_array(
                levels,
                num_layers as i32,
                &params.sampler,
                wrap_s,
                wrap_t,
                min_filter,
                mag_filter,
                0.0,
                compare_prec,
                coord,
                clamped_lod,
                params.base.ref_,
                res_pix[0],
            );

            if !is_ok {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `glu::computeTextureCompareDiff` for `TextureCubeView` - **not** the same shape as
/// `compute_texture_lookup_diff_cube`, confirmed by reading upstream's body directly: no
/// `tri0`/`tri1` edge-widening (single `triNdx`, matching this file's own
/// `compute_texture_compare_diff_2d`/`_2d_array` above rather than the lookup-diff cube
/// overload), and only **4** neighbour-offset entries, not 8 - the lookup-diff cube
/// overload's extra diagonal four are specific to that function, not a general cube
/// property. Still needs a fresh `coord_o` per offset (not just derivatives), the same
/// reason `compute_texture_lookup_diff_cube` does: `compute_cube_lod_bounds_from_derivates`
/// is a function of position as well as derivative.
#[allow(clippy::too_many_arguments)]
pub fn compute_texture_compare_diff_cube(
    result: &ConstPixelBufferAccess<'_>,
    reference: &ConstPixelBufferAccess<'_>,
    error_mask: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 12],
    params: &ReferenceParams,
    compare_prec: &TexComparePrecision,
    lod_prec: &LodPrecision,
    non_shadow_threshold: [f32; 3],
) -> i32 {
    let [rw, rh, _] = result.size();
    debug_assert_eq!(result.size(), reference.size());
    debug_assert_eq!(result.size(), error_mask.size());

    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);

    let dst_w = rw as f32;
    let dst_h = rh as f32;
    let face_size = levels[0].size()[0] as i32;

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };

    let min_filter = sampler_min_filter_mode(&params.sampler);
    let mag_filter = params.mag_filter.unwrap_or(params.sampler.filter);

    const LOD_OFFSETS: [[f32; 2]; 4] = [[-1.0, 0.0], [1.0, 0.0], [0.0, -1.0], [0.0, 1.0]];

    let mut num_failed = 0;

    clear(error_mask, RGBA::green().to_vec().m_data);

    for py in 0..rh {
        for px in 0..rw {
            let res_pix = result.get_pixel(px, py, 0);
            let ref_pix = reference.get_pixel(px, py, 0);

            if (1..4usize).any(|c| (ref_pix[c] - res_pix[c]).abs() > non_shadow_threshold[c - 1]) {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
                continue;
            }

            if res_pix[0] == ref_pix[0] {
                continue;
            }

            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri_ndx: usize = if nx + ny >= 1.0 { 1 } else { 0 };
            let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
            let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let coord = [
                projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
            ];
            let coord_dx = [
                tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
            ];
            let coord_dy = [
                tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
            ];

            let mut lod_bounds = compute_cube_lod_bounds_from_derivates(coord, coord_dx, coord_dy, face_size, lod_prec);

            for lod_offset in LOD_OFFSETS {
                let wxo = tri_wx + lod_offset[0];
                let wyo = tri_wy + lod_offset[1];
                let nxo = wxo / dst_w;
                let nyo = wyo / dst_h;

                let coord_o = [
                    projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                    projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                    projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                ];
                let coord_dxo = [
                    tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                    tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                    tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                ];
                let coord_dyo = [
                    tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                    tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                    tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                ];
                let lod_o = compute_cube_lod_bounds_from_derivates(coord_o, coord_dxo, coord_dyo, face_size, lod_prec);

                lod_bounds.0 = lod_bounds.0.min(lod_o.0);
                lod_bounds.1 = lod_bounds.1.max(lod_o.1);
            }

            let clamped_lod = clamp_lod_bounds(
                (lod_bounds.0 + lod_bias, lod_bounds.1 + lod_bias),
                (params.min_lod, params.max_lod),
                lod_prec,
            );

            let is_ok = is_tex_compare_result_valid_cube(
                levels,
                &params.sampler,
                min_filter,
                mag_filter,
                0.0,
                compare_prec,
                coord,
                clamped_lod,
                params.base.ref_,
                res_pix[0],
            );

            if !is_ok {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `glu::computeTextureCompareDiff` for `TextureCubeView` - **not** the same shape as
/// `compute_texture_lookup_diff_cube`, confirmed by reading upstream's body directly: no
/// `tri0`/`tri1` edge-widening (single `triNdx`, matching this file's own
/// `compute_texture_compare_diff_2d`/`_2d_array` above rather than the lookup-diff cube
/// overload), and only **4** neighbour-offset entries, not 8 - the lookup-diff cube
/// overload's extra diagonal four are specific to that function, not a general cube
/// property. Still needs a fresh `coord_o` per offset (not just derivatives), the same
/// reason `compute_texture_lookup_diff_cube` does: `compute_cube_lod_bounds_from_derivates`
/// is a function of position as well as derivative.
#[allow(clippy::too_many_arguments)]
pub fn compute_texture_compare_diff_cube_array(
    result: &ConstPixelBufferAccess<'_>,
    reference: &ConstPixelBufferAccess<'_>,
    error_mask: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 16],
    params: &ReferenceParams,
    compare_prec: &TexComparePrecision,
    lod_prec: &LodPrecision,
    non_shadow_threshold: [f32; 3],
) -> i32 {
    let [rw, rh, _] = result.size();
    debug_assert_eq!(result.size(), reference.size());
    debug_assert_eq!(result.size(), error_mask.size());

    let sq = Vec4::new(tex_coord[0], tex_coord[4], tex_coord[8], tex_coord[12]);
    let tq = Vec4::new(tex_coord[1], tex_coord[5], tex_coord[9], tex_coord[13]);
    let rq = Vec4::new(tex_coord[2], tex_coord[6], tex_coord[10], tex_coord[14]);
    let qq = Vec4::new(tex_coord[3], tex_coord[7], tex_coord[11], tex_coord[15]);

    let dst_w = rw as f32;
    let dst_h = rh as f32;
    let face_size = levels[0].size()[0] as i32;

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_q = [qq.swizzle([0, 1, 2]), qq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };

    let min_filter = sampler_min_filter_mode(&params.sampler);
    let mag_filter = params.mag_filter.unwrap_or(params.sampler.filter);

    const LOD_OFFSETS: [[f32; 2]; 4] = [[-1.0, 0.0], [1.0, 0.0], [0.0, -1.0], [0.0, 1.0]];

    let mut num_failed = 0;

    clear(error_mask, RGBA::green().to_vec().m_data);

    for py in 0..rh {
        for px in 0..rw {
            let res_pix = result.get_pixel(px, py, 0);
            let ref_pix = reference.get_pixel(px, py, 0);

            if (1..4usize).any(|c| (ref_pix[c] - res_pix[c]).abs() > non_shadow_threshold[c - 1]) {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
                continue;
            }

            if res_pix[0] == ref_pix[0] {
                continue;
            }

            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri_ndx: usize = if nx + ny >= 1.0 { 1 } else { 0 };
            let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
            let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let coord = [
                projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
            ];
            let coord_q = projected_tri_interpolate(tri_q[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny);
            let coord_dx = [
                tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
            ];
            let coord_dy = [
                tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
            ];

            let mut lod_bounds = compute_cube_lod_bounds_from_derivates(coord, coord_dx, coord_dy, face_size, lod_prec);

            for lod_offset in LOD_OFFSETS {
                let wxo = tri_wx + lod_offset[0];
                let wyo = tri_wy + lod_offset[1];
                let nxo = wxo / dst_w;
                let nyo = wyo / dst_h;

                let coord_o = [
                    projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                    projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                    projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                ];
                let coord_dxo = [
                    tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                    tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                    tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                ];
                let coord_dyo = [
                    tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                    tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                    tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                ];
                let lod_o = compute_cube_lod_bounds_from_derivates(coord_o, coord_dxo, coord_dyo, face_size, lod_prec);

                lod_bounds.0 = lod_bounds.0.min(lod_o.0);
                lod_bounds.1 = lod_bounds.1.max(lod_o.1);
            }

            let clamped_lod = clamp_lod_bounds(
                (lod_bounds.0 + lod_bias, lod_bounds.1 + lod_bias),
                (params.min_lod, params.max_lod),
                lod_prec,
            );

            let is_ok = is_tex_compare_result_valid_cube_array(
                levels,
                &params.sampler,
                min_filter,
                mag_filter,
                0.0,
                compare_prec,
                [coord[0], coord[1], coord[2], coord_q],
                clamped_lod,
                params.base.ref_,
                res_pix[0],
            );

            if !is_ok {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
            }
        }
    }

    num_failed
}

/// `execSample(TextureCubeArrayView, ...)` for a non-shadow sampler. Same mip-filter dispatch
/// as `exec_sample_cube`, with the layer coordinate `q`.
#[allow(clippy::too_many_arguments)]
fn exec_sample_cube_array(
    levels: &[ConstPixelBufferAccess<'_>],
    params: &ReferenceParams,
    s: f32,
    t: f32,
    r: f32,
    q: f32,
    lod: f32,
) -> [f32; 4] {
    let params = &params.effective_for_lod(lod);
    if params.base.sampler_type == SamplerType::Shadow {
        let result = match params.sampler.mip_filter {
            Some(mip_filter) => crate::tcu::pixel::sample_cube_array_mipmap_compare_filtered(
                levels,
                &params.sampler,
                params.base.ref_,
                s,
                t,
                r,
                q,
                lod,
                mip_filter,
            ),
            None => crate::tcu::pixel::sample_cube_array_mipmap_compare(
                levels,
                &params.sampler,
                params.base.ref_,
                s,
                t,
                r,
                q,
                lod,
            ),
        };
        return [result, 0.0, 0.0, 1.0];
    }
    match params.sampler.mip_filter {
        Some(mip_filter) => {
            crate::tcu::pixel::sample_cube_array_mipmap_filtered(levels, &params.sampler, s, t, r, q, lod, mip_filter)
        }
        None => crate::tcu::pixel::sample_cube_array_mipmap(levels, &params.sampler, s, t, r, q, lod),
    }
}

/// `sampleTexture(SurfaceAccess, TextureCubeArrayView, texCoord, params)` - `tex_coord` is four
/// `(s,t,r,q)` vertices (16 floats), `levels` one access per mip level with `layers * 6` slices.
pub fn sample_texture_cube_array(
    dst: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 16],
    params: &ReferenceParams,
) {
    let levels = sub_view(levels, params.base_level, params.max_level);
    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };
    let [dw, dh, _] = dst.size();
    let dst_w = dw as f32;
    let dst_h = dh as f32;
    let face_size = levels[0].size()[0] as i32;

    let sq = Vec4::new(tex_coord[0], tex_coord[4], tex_coord[8], tex_coord[12]);
    let tq = Vec4::new(tex_coord[1], tex_coord[5], tex_coord[9], tex_coord[13]);
    let rq = Vec4::new(tex_coord[2], tex_coord[6], tex_coord[10], tex_coord[14]);
    let qq = Vec4::new(tex_coord[3], tex_coord[7], tex_coord[11], tex_coord[15]);

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_q = [qq.swizzle([0, 1, 2]), qq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    for py in 0..dh {
        for px in 0..dw {
            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri_ndx = if nx + ny >= 1.0 { 1 } else { 0 };
            let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
            let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

            let coord = Vec3::new(
                triangle_interpolate_v3(tri_s[tri_ndx], tri_nx, tri_ny),
                triangle_interpolate_v3(tri_t[tri_ndx], tri_nx, tri_ny),
                triangle_interpolate_v3(tri_r[tri_ndx], tri_nx, tri_ny),
            );
            let coord_q = triangle_interpolate_v3(tri_q[tri_ndx], tri_nx, tri_ny);
            let coord_dx = Vec3::new(
                tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
            );
            let coord_dy = Vec3::new(
                tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
            );

            let lod = (compute_cube_lod_from_derivates(params.lod_mode, coord, coord_dx, coord_dy, face_size)
                + lod_bias)
                .clamp(params.min_lod, params.max_lod);

            let sample = exec_sample_cube_array(levels, params, coord.x(), coord.y(), coord.z(), coord_q, lod);
            let color: [f32; 4] = std::array::from_fn(|c| {
                sample[c] * params.base.color_scale.m_data[c] + params.base.color_bias.m_data[c]
            });
            dst.set_pixel(color, px, py, 0);
        }
    }
}

/// `glu::computeTextureLookupDiff` for `TextureCubeArrayView` - `compute_texture_lookup_diff_cube`
/// with the layer coordinate carried through `is_lookup_result_valid_cube_array`.
/// `layer_coord_bits` is upstream's `coordBits.w()`.
#[allow(clippy::too_many_arguments)]
pub fn compute_texture_lookup_diff_cube_array(
    result: &ConstPixelBufferAccess<'_>,
    reference: &ConstPixelBufferAccess<'_>,
    error_mask: &mut PixelBufferAccess<'_>,
    levels: &[ConstPixelBufferAccess<'_>],
    tex_coord: [f32; 16],
    params: &ReferenceParams,
    lookup_prec: &LookupPrecision,
    layer_coord_bits: i32,
    lod_prec: &LodPrecision,
) -> i32 {
    let [rw, rh, _] = result.size();
    debug_assert_eq!(result.size(), reference.size());
    debug_assert_eq!(result.size(), error_mask.size());

    let sq = Vec4::new(tex_coord[0], tex_coord[4], tex_coord[8], tex_coord[12]);
    let tq = Vec4::new(tex_coord[1], tex_coord[5], tex_coord[9], tex_coord[13]);
    let rq = Vec4::new(tex_coord[2], tex_coord[6], tex_coord[10], tex_coord[14]);
    let qq = Vec4::new(tex_coord[3], tex_coord[7], tex_coord[11], tex_coord[15]);

    let dst_w = rw as f32;
    let dst_h = rh as f32;
    let face_size = levels[0].size()[0] as i32;

    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let tri_q = [qq.swizzle([0, 1, 2]), qq.swizzle([3, 2, 1])];
    let tri_w = [params.base.w.swizzle([0, 1, 2]), params.base.w.swizzle([3, 2, 1])];

    let lod_bias = if params.base.use_bias { params.base.bias } else { 0.0 };
    let pos_eps = 1.0 / (1i32 << MIN_SUBPIXEL_BITS) as f32;

    let seamless_cube_map = params.sampler.seamless_cube_map;
    let min_filter = sampler_min_filter_mode(&params.sampler);
    let mag_filter = params.mag_filter.unwrap_or(params.sampler.filter);
    let normalized_coords = params.sampler.normalized_coords;

    const LOD_OFFSETS: [[f32; 2]; 8] = [
        [-1.0, 0.0],
        [1.0, 0.0],
        [0.0, -1.0],
        [0.0, 1.0],
        [-1.0, -1.0],
        [-1.0, 1.0],
        [1.0, -1.0],
        [1.0, 1.0],
    ];

    let mut num_failed = 0;

    clear(error_mask, RGBA::green().to_vec().m_data);

    for py in 0..rh {
        for px in 0..rw {
            let res_pix = result.get_pixel(px, py, 0);
            let ref_pix = reference.get_pixel(px, py, 0);
            let res_adj: [f32; 4] = std::array::from_fn(|c| {
                (res_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });
            let ref_adj: [f32; 4] = std::array::from_fn(|c| {
                (ref_pix[c] - params.base.color_bias.m_data[c]) / params.base.color_scale.m_data[c]
            });

            if (0..4usize).all(|c| (res_adj[c] - ref_adj[c]).abs() <= lookup_prec.color_threshold[c]) {
                continue;
            }

            let wx = px as f32 + 0.5;
            let wy = py as f32 + 0.5;
            let nx = wx / dst_w;
            let ny = wy / dst_h;

            let tri0 = nx + ny - pos_eps <= 1.0;
            let tri1 = nx + ny + pos_eps >= 1.0;
            debug_assert!(tri0 || tri1);

            let mut is_ok = false;

            let tri_lo: usize = if tri0 { 0 } else { 1 };
            let tri_hi: usize = if tri1 { 1 } else { 0 };
            for tri_ndx in tri_lo..=tri_hi {
                let tri_wx = if tri_ndx == 1 { dst_w - wx } else { wx };
                let tri_wy = if tri_ndx == 1 { dst_h - wy } else { wy };
                let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
                let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };

                let coord = [
                    projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                    projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                    projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                    projected_tri_interpolate(tri_q[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                ];
                let coord_dx = [
                    tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                    tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                    tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wx, dst_w, tri_ny),
                ];
                let coord_dy = [
                    tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                    tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                    tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wy, dst_h, tri_nx),
                ];

                let mut lod_bounds = compute_cube_lod_bounds_from_derivates(
                    [coord[0], coord[1], coord[2]],
                    coord_dx,
                    coord_dy,
                    face_size,
                    lod_prec,
                );

                for lod_offset in LOD_OFFSETS {
                    let wxo = tri_wx + lod_offset[0];
                    let wyo = tri_wy + lod_offset[1];
                    let nxo = wxo / dst_w;
                    let nyo = wyo / dst_h;

                    let coord_o = [
                        projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                        projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                        projected_tri_interpolate(tri_r[tri_ndx], tri_w[tri_ndx], nxo, nyo),
                    ];
                    let coord_dxo = [
                        tri_derivate_x(tri_s[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                        tri_derivate_x(tri_t[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                        tri_derivate_x(tri_r[tri_ndx], tri_w[tri_ndx], wxo, dst_w, nyo),
                    ];
                    let coord_dyo = [
                        tri_derivate_y(tri_s[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                        tri_derivate_y(tri_t[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                        tri_derivate_y(tri_r[tri_ndx], tri_w[tri_ndx], wyo, dst_h, nxo),
                    ];
                    let lod_o =
                        compute_cube_lod_bounds_from_derivates(coord_o, coord_dxo, coord_dyo, face_size, lod_prec);

                    lod_bounds.0 = lod_bounds.0.min(lod_o.0);
                    lod_bounds.1 = lod_bounds.1.max(lod_o.1);
                }

                let clamped_lod = clamp_lod_bounds(
                    (lod_bounds.0 + lod_bias, lod_bounds.1 + lod_bias),
                    (params.min_lod, params.max_lod),
                    lod_prec,
                );

                if is_lookup_result_valid_cube_array(
                    levels,
                    normalized_coords,
                    seamless_cube_map,
                    min_filter,
                    mag_filter,
                    0.0,
                    lookup_prec,
                    layer_coord_bits,
                    coord,
                    clamped_lod,
                    res_adj,
                ) {
                    is_ok = true;
                    break;
                }
            }

            if !is_ok {
                error_mask.set_pixel(RGBA::red().to_vec().m_data, px, py, 0);
                num_failed += 1;
            }
        }
    }

    num_failed
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::pixel::{FilterMode, MipmapFilterMode, TextureLevel};
    use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

    /// An ordinary signed/unsigned integer colour format always reads as its own
    /// matching `Int`/`Uint` sampler type, regardless of channel order - unlike the
    /// depth/stencil-backed types below, nothing here depends on `order` at all.
    #[test]
    fn sampler_type_from_plain_integer_formats() {
        for type_ in [
            ChannelType::SIGNED_INT8,
            ChannelType::SIGNED_INT16,
            ChannelType::SIGNED_INT32,
        ] {
            let fmt = TextureFormat::new(ChannelOrder::RGBA, type_);
            assert_eq!(get_sampler_type(fmt), SamplerType::Int, "{type_:?}");
            assert_eq!(get_fetch_sampler_type(fmt), SamplerType::FetchInt, "{type_:?}");
        }
        for type_ in [
            ChannelType::UNSIGNED_INT8,
            ChannelType::UNSIGNED_INT32,
            ChannelType::UNSIGNED_INT_1010102_REV,
        ] {
            let fmt = TextureFormat::new(ChannelOrder::RGBA, type_);
            assert_eq!(get_sampler_type(fmt), SamplerType::Uint, "{type_:?}");
            assert_eq!(get_fetch_sampler_type(fmt), SamplerType::FetchUint, "{type_:?}");
        }
    }

    /// `UNSIGNED_INT16`/`UNSIGNED_INT_24_8` are the ambiguous pair: a `D`/`DS` order
    /// means a genuine depth(+stencil) texture, sampled as `Float`; any other order
    /// (an ordinary colour texture that merely happens to share the storage type)
    /// samples as `Uint` instead. Both branches of that `order` check are exercised.
    #[test]
    fn sampler_type_from_depth_stencil_shaped_formats_depends_on_order() {
        for type_ in [ChannelType::UNSIGNED_INT16, ChannelType::UNSIGNED_INT_24_8] {
            let depth_fmt = TextureFormat::new(ChannelOrder::D, type_);
            assert_eq!(get_sampler_type(depth_fmt), SamplerType::Float, "{type_:?} D");
            assert_eq!(
                get_fetch_sampler_type(depth_fmt),
                SamplerType::FetchFloat,
                "{type_:?} D"
            );

            let ds_fmt = TextureFormat::new(ChannelOrder::DS, type_);
            assert_eq!(get_sampler_type(ds_fmt), SamplerType::Float, "{type_:?} DS");
            assert_eq!(get_fetch_sampler_type(ds_fmt), SamplerType::FetchFloat, "{type_:?} DS");

            let color_fmt = TextureFormat::new(ChannelOrder::R, type_);
            assert_eq!(get_sampler_type(color_fmt), SamplerType::Uint, "{type_:?} R");
            assert_eq!(get_fetch_sampler_type(color_fmt), SamplerType::FetchUint, "{type_:?} R");
        }
    }

    /// Everything else (normalized/float colour formats) is the plain `Float` default.
    #[test]
    fn sampler_type_defaults_to_float() {
        let fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        assert_eq!(get_sampler_type(fmt), SamplerType::Float);
        assert_eq!(get_fetch_sampler_type(fmt), SamplerType::FetchFloat);

        let float_fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        assert_eq!(get_sampler_type(float_fmt), SamplerType::Float);
        assert_eq!(get_fetch_sampler_type(float_fmt), SamplerType::FetchFloat);
    }

    #[test]
    fn lod_from_derivates_2d_matches_hand_computed_values() {
        // dudx=2, dvdx=0, dudy=0, dvdy=2: both axes have magnitude 2.
        assert!((compute_lod_from_derivates_2d(LodMode::Exact, 2.0, 0.0, 0.0, 2.0) - 1.0).abs() < 1e-6);
        assert!((compute_lod_from_derivates_2d(LodMode::MinBound, 2.0, 0.0, 0.0, 2.0) - 1.0).abs() < 1e-6);
        // MaxBound sums mu+mv = 2+2 = 4 -> log2(4) = 2.
        assert!((compute_lod_from_derivates_2d(LodMode::MaxBound, 2.0, 0.0, 0.0, 2.0) - 2.0).abs() < 1e-6);
    }

    #[test]
    fn non_projected_tri_lod_2d_matches_hand_computed_value() {
        // src 4x4, dst 1x1, sq=(0,1,0) tq=(0,0,1): dux=0,duy=4,dvx=4,dvy=0 ->
        // EXACT = max(sqrt(0+16), sqrt(16+0)) = 4 -> log2(4) = 2.
        let lod = compute_non_projected_tri_lod_2d(
            LodMode::Exact,
            IVec2::new(1, 1),
            IVec2::new(4, 4),
            Vec3::new(0.0, 1.0, 0.0),
            Vec3::new(0.0, 0.0, 1.0),
        );
        assert!((lod - 2.0).abs() < 1e-6, "lod = {lod}");
    }

    #[test]
    fn quad_tex_coord_2d_matches_hand_computed_layout() {
        let c = compute_quad_tex_coord_2d(Vec2::new(0.25, 0.5), Vec2::new(0.75, 1.0));
        assert_eq!(c, [0.25, 0.5, 0.25, 1.0, 0.75, 0.5, 0.75, 1.0]);
    }

    #[test]
    fn quad_tex_coord_1d_matches_hand_computed_layout() {
        assert_eq!(compute_quad_tex_coord_1d(0.0, 1.0), [0.0, 0.0, 1.0, 1.0]);
    }

    #[test]
    fn quad_tex_coord_2d_array_matches_hand_computed_layout() {
        let c = compute_quad_tex_coord_2d_array(3, Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));
        assert_eq!(c, [0.0, 0.0, 3.0, 0.0, 1.0, 3.0, 1.0, 0.0, 3.0, 1.0, 1.0, 3.0]);
    }

    /// Hand-computed: `dir_swz = [1, 0, 2]` swaps the first two output axes, so corner
    /// `f1 = (0,1,0)` (the one that would normally vary the first output axis) instead
    /// varies the *second*, and `f2 = (1,0,0)` varies the first - i.e. `s` and `t` swap
    /// which corner moves them, while `r` (always fed `0` from every corner's own third
    /// component) stays at `p0.z()` everywhere.
    #[test]
    fn quad_tex_coord_3d_matches_hand_computed_layout_with_a_swizzled_direction() {
        let p0 = Vec3::new(0.0, 0.1, 0.2);
        let p1 = Vec3::new(1.0, 0.9, 0.8);
        let c = compute_quad_tex_coord_3d(p0, p1, [1, 0, 2]);
        #[rustfmt::skip]
        let expected = [
            0.0, 0.1, 0.2,
            1.0, 0.1, 0.2,
            0.0, 0.9, 0.2,
            1.0, 0.9, 0.2,
        ];
        assert_eq!(c, expected);
    }

    /// With every corner's `w` equal (no real perspective), `tri_derivate_x`/`_y` must
    /// reduce to the plain affine derivative `(end - start) / extent`, independent of
    /// the screen position (`wx`/`ny` or `wy`/`nx`) it's evaluated at - hand-derived in
    /// this session's own working notes by substituting `w = (1,1,1)` into both
    /// formulas and simplifying algebraically.
    #[test]
    fn tri_derivate_reduces_to_affine_case_when_w_is_uniform() {
        let w = Vec3::splat(1.0);
        let u = Vec3::new(0.0, 5.0, 8.0);
        let width = 10.0f32;
        let expected_x = (u.z() - u.x()) / width; // = 0.8
        assert!((tri_derivate_x(u, w, 3.0, width, 0.4) - expected_x).abs() < 1e-5);
        assert!((tri_derivate_x(u, w, 7.0, width, 0.9) - expected_x).abs() < 1e-5);

        let height = 20.0f32;
        let expected_y = (u.y() - u.x()) / height; // = 0.25
        assert!((tri_derivate_y(u, w, 2.0, height, 0.1) - expected_y).abs() < 1e-5);
        assert!((tri_derivate_y(u, w, 15.0, height, 0.6) - expected_y).abs() < 1e-5);
    }

    /// `compute_projected_tri_lod_2d` with uniform `w` must agree with
    /// `compute_non_projected_tri_lod_2d` fed the pre-scaled `u = sq * srcWidth` - the
    /// same relation `sample_texture_projected_2d`/`sample_texture_non_projected_2d`
    /// rely on to agree when a quad genuinely has no perspective.
    #[test]
    fn projected_tri_lod_matches_non_projected_when_w_is_uniform() {
        let src_size = IVec2::new(4, 4);
        let dst_size = IVec2::new(8, 8);
        let sq = Vec3::new(0.0, 1.0, 0.0);
        let tq = Vec3::new(0.0, 0.0, 1.0);
        let non_projected = compute_non_projected_tri_lod_2d(LodMode::Exact, dst_size, src_size, sq, tq);

        let u: Vec3 = Vec3::from_array(std::array::from_fn(|c| sq.m_data[c] * src_size.x() as f32));
        let v: Vec3 = Vec3::from_array(std::array::from_fn(|c| tq.m_data[c] * src_size.y() as f32));
        let w = Vec3::splat(1.0);
        let projected = compute_projected_tri_lod_2d(
            LodMode::Exact,
            u,
            v,
            w,
            4.0,
            4.0,
            dst_size.x() as f32,
            dst_size.y() as f32,
        );

        assert!(
            (projected - non_projected).abs() < 1e-4,
            "projected = {projected}, non_projected = {non_projected}"
        );
    }

    /// A GLSL `sampler2D` always samples with normalized `[0,1]` coordinates - unlike
    /// `Sampler::clamp_to_edge`, which `tcu::scale` built for pixel-space coordinates
    /// and deliberately sets `normalized_coords: false` (see that function's own doc
    /// comment); reusing it here would silently sample at the wrong texel.
    fn normalized_sampler(filter: FilterMode) -> Sampler {
        let mut sampler = Sampler::clamp_to_edge(filter);
        sampler.normalized_coords = true;
        sampler
    }

    fn checkerboard_level() -> TextureLevel {
        let mut level = TextureLevel::new(
            TextureFormat {
                order: ChannelOrder::RGBA,
                type_: ChannelType::UNORM_INT8,
            },
            2,
            2,
            1,
        )
        .unwrap();
        {
            let mut access = level.get_access();
            access.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // bottom-left: red
            access.set_pixel([0.0, 1.0, 0.0, 1.0], 1, 0, 0); // bottom-right: green
            access.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 1, 0); // top-left: blue
            access.set_pixel([1.0, 1.0, 0.0, 1.0], 1, 1, 0); // top-right: yellow
        }
        level
    }

    /// End-to-end: nearest-filter sampling of a 2x2 checkerboard through a quad
    /// covering the whole destination must reproduce each texel exactly in its own
    /// quadrant - the same shape `shaders.texture_functions`' simplest cases check.
    #[test]
    fn sample_texture_2d_nearest_reproduces_checkerboard_quadrants() {
        let level = checkerboard_level();
        let levels = [level.get_const_access()];

        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut dst_level = TextureLevel::new(fmt, 4, 4, 1).unwrap();
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));
        let params = ReferenceParams::new(
            TextureType::Texture2D,
            normalized_sampler(FilterMode::Nearest),
            LodMode::Exact,
        );

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d(&mut dst, &levels, tex_coord, &params);
        }

        let dst = dst_level.get_const_access();
        // Bottom-left quadrant -> red texel.
        assert_eq!(dst.get_pixel(0, 0, 0), [1.0, 0.0, 0.0, 1.0]);
        assert_eq!(dst.get_pixel(1, 0, 0), [1.0, 0.0, 0.0, 1.0]);
        // Bottom-right quadrant -> green texel.
        assert_eq!(dst.get_pixel(2, 0, 0), [0.0, 1.0, 0.0, 1.0]);
        assert_eq!(dst.get_pixel(3, 0, 0), [0.0, 1.0, 0.0, 1.0]);
        // Top-left quadrant -> blue texel.
        assert_eq!(dst.get_pixel(0, 2, 0), [0.0, 0.0, 1.0, 1.0]);
        // Top-right quadrant -> yellow texel.
        assert_eq!(dst.get_pixel(3, 3, 0), [1.0, 1.0, 0.0, 1.0]);
    }

    /// `color_scale`/`color_bias` must apply after the sample, matching upstream's
    /// `execSample(...) * params.colorScale + params.colorBias`.
    #[test]
    fn sample_texture_2d_applies_color_scale_and_bias() {
        let level = checkerboard_level();
        let levels = [level.get_const_access()];

        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut dst_level = TextureLevel::new(fmt, 2, 2, 1).unwrap();
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));
        let mut params = ReferenceParams::new(
            TextureType::Texture2D,
            normalized_sampler(FilterMode::Nearest),
            LodMode::Exact,
        );
        params.base.color_scale = Vec4::splat(0.5);
        params.base.color_bias = Vec4::new(0.1, 0.1, 0.1, 0.0);

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d(&mut dst, &levels, tex_coord, &params);
        }

        let dst = dst_level.get_const_access();
        // Bottom-left texel is red (1,0,0,1) -> scaled+biased: (0.6, 0.1, 0.1, 0.5).
        // UNORM_INT8 round-trips through an 8-bit store, so the tolerance has to cover
        // one quantization step (1/255 ~= 0.0039), not just float rounding.
        let px = dst.get_pixel(0, 0, 0);
        for (got, want) in px.iter().zip([0.6f32, 0.1, 0.1, 0.5].iter()) {
            assert!((got - want).abs() < 1e-2, "{px:?}");
        }
    }

    /// `getSubView`'s own clamping, exercised directly: `max_level` is clamped against
    /// the *already-clamped* `base_level`, not the raw value passed in, so a
    /// `max_level` below `base_level` still yields a single-level, non-empty range at
    /// `base_level` rather than an empty or reversed one.
    #[test]
    fn sub_view_clamps_base_and_max_level() {
        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::FLOAT,
        };
        let levels: Vec<TextureLevel> = (0..4).map(|_| TextureLevel::new(fmt, 1, 1, 1).unwrap()).collect();
        let accesses: Vec<ConstPixelBufferAccess<'_>> = levels.iter().map(|l| l.get_const_access()).collect();

        assert_eq!(sub_view(&accesses, 1, 2).len(), 2);
        assert_eq!(
            sub_view(&accesses, -5, 1000).len(),
            4,
            "out-of-range on both ends clamps to the whole chain"
        );
        assert_eq!(
            sub_view(&accesses, 2, 1).len(),
            1,
            "max_level below base_level still yields base_level alone"
        );
    }

    /// `sample_texture_2d` must only ever look at mip levels inside
    /// `[base_level, max_level]` - a magnified lookup (dst size == src size, lod ~ 0)
    /// would otherwise read level 0 regardless, so restricting the range to level 1
    /// alone is what proves the field is actually wired in rather than merely stored.
    #[test]
    fn sample_texture_2d_respects_base_level_and_max_level() {
        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut level0 = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        level0.get_access().set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // red
        let mut level1 = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        level1.get_access().set_pixel([0.0, 0.0, 1.0, 1.0], 0, 0, 0); // blue
        let levels = [level0.get_const_access(), level1.get_const_access()];

        let mut dst_level = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));
        let mut params = ReferenceParams::new(
            TextureType::Texture2D,
            normalized_sampler(FilterMode::Nearest),
            LodMode::Exact,
        );
        params.base_level = 1;
        params.max_level = 1;

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d(&mut dst, &levels, tex_coord, &params);
        }

        assert_eq!(
            dst_level.get_const_access().get_pixel(0, 0, 0),
            [0.0, 0.0, 1.0, 1.0],
            "base_level=max_level=1 must only ever see the blue level"
        );
    }

    /// `SamplerType::Int`/`Uint` need no new reference-sampling code at all (see
    /// `exec_sample_2d`'s own doc comment) - this proves it end to end through
    /// `sample_texture_2d` rather than taking that claim on faith: an `UNSIGNED_INT32`
    /// single-channel texture holding raw values well outside `[0,1]` must come back
    /// unnormalized, the same way an `isampler2D`/`usampler2D` GLSL lookup would.
    #[test]
    fn sample_texture_2d_uint_sampler_returns_raw_unnormalized_values() {
        let fmt = TextureFormat {
            order: ChannelOrder::R,
            type_: ChannelType::UNSIGNED_INT32,
        };
        let mut level = TextureLevel::new(fmt, 2, 1, 1).unwrap();
        {
            let mut access = level.get_access();
            access.set_pixel([10.0, 0.0, 0.0, 0.0], 0, 0, 0);
            access.set_pixel([200.0, 0.0, 0.0, 0.0], 1, 0, 0);
        }
        let levels = [level.get_const_access()];

        let dst_fmt = TextureFormat {
            order: ChannelOrder::R,
            type_: ChannelType::UNSIGNED_INT32,
        };
        let mut dst_level = TextureLevel::new(dst_fmt, 2, 1, 1).unwrap();
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));
        let sampler = normalized_sampler(FilterMode::Nearest);
        let mut params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        params.base.sampler_type = SamplerType::Uint;

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d(&mut dst, &levels, tex_coord, &params);
        }

        let dst = dst_level.get_const_access();
        assert_eq!(dst.get_pixel(0, 0, 0)[0], 10.0);
        assert_eq!(dst.get_pixel(1, 0, 0)[0], 200.0);
    }

    fn shadow_depth_level() -> TextureLevel {
        // 2x2 depth texture, same per-texel layout convention `checkerboard_level`
        // uses: (0,0)=shallowest, (1,1)=deepest.
        let mut level = TextureLevel::new(
            TextureFormat {
                order: ChannelOrder::D,
                type_: ChannelType::UNORM_INT16,
            },
            2,
            2,
            1,
        )
        .unwrap();
        let mut access = level.get_access();
        access.set_pixel([0.2, 0.0, 0.0, 1.0], 0, 0, 0);
        access.set_pixel([0.4, 0.0, 0.0, 1.0], 1, 0, 0);
        access.set_pixel([0.6, 0.0, 0.0, 1.0], 0, 1, 0);
        access.set_pixel([0.8, 0.0, 0.0, 1.0], 1, 1, 0);
        level
    }

    /// `SamplerType::Shadow` end to end through `sample_texture_2d`: a quad covering
    /// the whole destination samples each quadrant's own depth texel (`NEAREST`, same
    /// quadrant-reproduction shape as `sample_texture_2d_nearest_reproduces_checkerboard_quadrants`),
    /// compared against one fixed `ref_` with `CompareMode::Less` - `ref_ = 0.5` must
    /// pass (`[R,R,R,1]` with `R=1.0`) in the two shallower quadrants and fail
    /// (`R=0.0`) in the two deeper ones, exactly the shape `execSample`'s
    /// `Vec4(result, 0, 0, 1)` packing produces.
    #[test]
    fn sample_texture_2d_shadow_sampler_compares_each_quadrants_own_depth() {
        let level = shadow_depth_level();
        let levels = [level.get_const_access()];

        let dst_fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut dst_level = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        let sampler = Sampler {
            compare: crate::tcu::pixel::CompareMode::Less,
            ..normalized_sampler(FilterMode::Nearest)
        };
        let mut params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        params.base.sampler_type = SamplerType::Shadow;
        params.base.ref_ = 0.5;

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d(&mut dst, &levels, tex_coord, &params);
        }

        let dst = dst_level.get_const_access();
        // `execSample`'s own `Vec4(result, 0, 0, 1)` packing puts the compare result in
        // channel 0 only (channels 1/2 are always 0, channel 3 always 1) - matching
        // upstream exactly rather than broadcasting it across RGB.
        //
        // Bottom-left quadrant -> depth 0.2, compare is `ref < stored`: 0.5 < 0.2 fails
        // -> 0.0. Bottom-right -> depth 0.4, 0.5 < 0.4 fails -> 0.0. Top-left -> depth
        // 0.6, 0.5 < 0.6 passes -> 1.0. Top-right -> depth 0.8, 0.5 < 0.8 passes -> 1.0.
        assert_eq!(dst.get_pixel(0, 0, 0), [0.0, 0.0, 0.0, 1.0]);
        assert_eq!(dst.get_pixel(3, 0, 0), [0.0, 0.0, 0.0, 1.0]);
        assert_eq!(dst.get_pixel(0, 3, 0), [1.0, 0.0, 0.0, 1.0]);
        assert_eq!(dst.get_pixel(3, 3, 0), [1.0, 0.0, 0.0, 1.0]);
    }

    /// `sample_texture_cube` end to end: a 1x1-per-face cube (so `NEAREST` always
    /// reads that face's one and only texel, isolating face *selection* from
    /// within-face addressing, which is already covered by `tcu::pixel`'s own cube
    /// tests) with a distinct solid colour per face. A quad whose four corners all
    /// share the same direction vector samples that one face's colour everywhere -
    /// checked for two different faces to catch a mixed-up axis, not just an
    /// off-by-one in the face enum.
    #[test]
    fn sample_texture_cube_selects_the_right_face_and_colour() {
        use crate::glu::texture_cube::ALL_FACES;
        use crate::tcu::texture_cube::TextureCube;

        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut cube = TextureCube::new(fmt, 1);
        cube.alloc_level(0);
        let face_colors: [[f32; 4]; 6] = [
            [1.0, 0.0, 0.0, 1.0], // +X red
            [0.0, 1.0, 0.0, 1.0], // -X green
            [0.0, 0.0, 1.0, 1.0], // +Y blue
            [1.0, 1.0, 0.0, 1.0], // -Y yellow
            [1.0, 0.0, 1.0, 1.0], // +Z magenta
            [0.0, 1.0, 1.0, 1.0], // -Z cyan
        ];
        for (face, color) in ALL_FACES.into_iter().zip(face_colors) {
            cube.face_level_mut(face, 0).set_pixel(color, 0, 0, 0);
        }
        let levels = [cube.level(0)];

        let dst_fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let sampler = Sampler {
            normalized_coords: true,
            ..Sampler::clamp_to_edge(FilterMode::Nearest)
        };
        let params = ReferenceParams::new(TextureType::Cube, sampler, LodMode::Exact);

        let check_face = |dir: [f32; 3], expected: [f32; 4]| {
            let mut dst_level = TextureLevel::new(dst_fmt, 2, 2, 1).unwrap();
            let tex_coord: [f32; 12] = std::array::from_fn(|i| dir[i % 3]);
            {
                let mut dst = dst_level.get_access();
                sample_texture_cube(&mut dst, &levels, tex_coord, &params);
            }
            let dst = dst_level.get_const_access();
            for y in 0..2 {
                for x in 0..2 {
                    assert_eq!(dst.get_pixel(x, y, 0), expected, "dir {dir:?} pixel ({x},{y})");
                }
            }
        };

        check_face([1.0, 0.0, 0.0], face_colors[0]); // +X
        check_face([0.0, 0.0, -1.0], face_colors[5]); // -Z
    }

    /// `SamplerType::Shadow` through `sample_texture_cube`, the cube counterpart of
    /// `sample_texture_2d_shadow_sampler_compares_each_quadrants_own_depth`: a 1x1-per-face
    /// depth cube with a distinct depth per face, so face *selection* for the compare
    /// path is isolated the same way the colour test above isolates it for `Float`.
    #[test]
    fn sample_texture_cube_shadow_sampler_compares_each_faces_own_depth() {
        use crate::glu::texture_cube::ALL_FACES;
        use crate::tcu::texture_cube::TextureCube;

        let fmt = TextureFormat {
            order: ChannelOrder::D,
            type_: ChannelType::UNORM_INT16,
        };
        let mut cube = TextureCube::new(fmt, 1);
        cube.alloc_level(0);
        // +X shallow (0.3), -Z deep (0.7) - the same two faces the colour test above checks.
        let face_depths: [f32; 6] = [0.3, 0.5, 0.5, 0.5, 0.5, 0.7];
        for (face, depth) in ALL_FACES.into_iter().zip(face_depths) {
            cube.face_level_mut(face, 0).set_pixel([depth, 0.0, 0.0, 1.0], 0, 0, 0);
        }
        let levels = [cube.level(0)];

        let dst_fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let sampler = Sampler {
            normalized_coords: true,
            compare: crate::tcu::pixel::CompareMode::Less,
            ..Sampler::clamp_to_edge(FilterMode::Nearest)
        };
        let mut params = ReferenceParams::new(TextureType::Cube, sampler, LodMode::Exact);
        params.base.sampler_type = SamplerType::Shadow;
        params.base.ref_ = 0.5;

        let check_face = |dir: [f32; 3], expected: f32| {
            let mut dst_level = TextureLevel::new(dst_fmt, 2, 2, 1).unwrap();
            let tex_coord: [f32; 12] = std::array::from_fn(|i| dir[i % 3]);
            {
                let mut dst = dst_level.get_access();
                sample_texture_cube(&mut dst, &levels, tex_coord, &params);
            }
            let dst = dst_level.get_const_access();
            assert_eq!(dst.get_pixel(0, 0, 0), [expected, 0.0, 0.0, 1.0], "dir {dir:?}");
        };

        check_face([1.0, 0.0, 0.0], 0.0); // +X: ref 0.5 < stored 0.3 fails
        check_face([0.0, 0.0, -1.0], 1.0); // -Z: ref 0.5 < stored 0.7 passes
    }

    /// `sample_texture_3d` end to end: a 1x1x2 texture (one texel per depth slice) with
    /// a distinct colour per slice, sampled with `r=0.25` on the quad's left two
    /// corners and `r=0.75` on its right two (`NEAREST`, `normalized_coords: true`) -
    /// isolates depth-slice *selection* the same way `sample_texture_cube_selects_
    /// the_right_face_and_colour` isolates face selection, independent of
    /// `compute_quad_tex_coord_3d` (tested separately above by hand).
    #[test]
    fn sample_texture_3d_nearest_selects_the_right_depth_slice() {
        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut level = TextureLevel::new(fmt, 1, 1, 2).unwrap();
        {
            let mut access = level.get_access();
            access.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // slice 0: red
            access.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 0, 1); // slice 1: blue
        }
        let levels = [level.get_const_access()];

        let dst_fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut dst_level = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();
        // tex_coord order is (-1,-1),(-1,1),(1,-1),(1,1) - both left corners get
        // r=0.25 (slice 0), both right corners get r=0.75 (slice 1).
        let tex_coord: [f32; 12] = [0.5, 0.5, 0.25, 0.5, 0.5, 0.25, 0.5, 0.5, 0.75, 0.5, 0.5, 0.75];
        let sampler = normalized_sampler(FilterMode::Nearest);
        let params = ReferenceParams::new(TextureType::Texture3D, sampler, LodMode::Exact);

        {
            let mut dst = dst_level.get_access();
            sample_texture_3d(&mut dst, &levels, tex_coord, &params);
        }

        let dst = dst_level.get_const_access();
        assert_eq!(
            dst.get_pixel(0, 0, 0),
            [1.0, 0.0, 0.0, 1.0],
            "left should sample slice 0 (red)"
        );
        assert_eq!(
            dst.get_pixel(3, 0, 0),
            [0.0, 0.0, 1.0, 1.0],
            "right should sample slice 1 (blue)"
        );
    }

    /// `sample_texture_2d_array` end to end: a 1x1-per-layer, 2-layer texture with a
    /// distinct colour per layer, sampled with `r=0.0` (layer 0) on the quad's left two
    /// corners and `r=1.0` (layer 1) on its right two - isolates layer selection the
    /// same way `sample_texture_3d_nearest_selects_the_right_depth_slice` isolates
    /// depth-slice selection.
    #[test]
    fn sample_texture_2d_array_nearest_selects_the_right_layer() {
        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut level = TextureLevel::new(fmt, 1, 1, 2).unwrap();
        {
            let mut access = level.get_access();
            access.set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0); // layer 0: red
            access.set_pixel([0.0, 0.0, 1.0, 1.0], 0, 0, 1); // layer 1: blue
        }
        let levels = [level.get_const_access()];

        let dst_fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut dst_level = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();
        let tex_coord: [f32; 12] = [0.5, 0.5, 0.0, 0.5, 0.5, 0.0, 0.5, 0.5, 1.0, 0.5, 0.5, 1.0];
        let sampler = normalized_sampler(FilterMode::Nearest);
        let params = ReferenceParams::new(TextureType::Texture2DArray, sampler, LodMode::Exact);

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d_array(&mut dst, &levels, tex_coord, &params);
        }

        let dst = dst_level.get_const_access();
        assert_eq!(
            dst.get_pixel(0, 0, 0),
            [1.0, 0.0, 0.0, 1.0],
            "left should sample layer 0 (red)"
        );
        assert_eq!(
            dst.get_pixel(3, 0, 0),
            [0.0, 0.0, 1.0, 1.0],
            "right should sample layer 1 (blue)"
        );
    }

    /// The `SamplerType::Shadow` counterpart: a 1x1-per-layer depth array with a
    /// distinct depth per layer, compared against one fixed `ref_`.
    #[test]
    fn sample_texture_2d_array_shadow_sampler_compares_each_layers_own_depth() {
        let fmt = TextureFormat {
            order: ChannelOrder::D,
            type_: ChannelType::UNORM_INT16,
        };
        let mut level = TextureLevel::new(fmt, 1, 1, 2).unwrap();
        {
            let mut access = level.get_access();
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 0, 0, 0); // layer 0: shallow
            access.set_pixel([0.8, 0.0, 0.0, 1.0], 0, 0, 1); // layer 1: deep
        }
        let levels = [level.get_const_access()];

        let dst_fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut dst_level = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();
        let tex_coord: [f32; 12] = [0.5, 0.5, 0.0, 0.5, 0.5, 0.0, 0.5, 0.5, 1.0, 0.5, 0.5, 1.0];
        let sampler = Sampler {
            compare: crate::tcu::pixel::CompareMode::Less,
            ..normalized_sampler(FilterMode::Nearest)
        };
        let mut params = ReferenceParams::new(TextureType::Texture2DArray, sampler, LodMode::Exact);
        params.base.sampler_type = SamplerType::Shadow;
        params.base.ref_ = 0.5;

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d_array(&mut dst, &levels, tex_coord, &params);
        }

        let dst = dst_level.get_const_access();
        // Layer 0: ref 0.5 < 0.2 fails -> 0.0. Layer 1: ref 0.5 < 0.8 passes -> 1.0.
        assert_eq!(dst.get_pixel(0, 0, 0), [0.0, 0.0, 0.0, 1.0]);
        assert_eq!(dst.get_pixel(3, 0, 0), [1.0, 0.0, 0.0, 1.0]);
    }

    #[test]
    #[should_panic(expected = "projected array lookups are not ported")]
    fn sample_texture_2d_array_rejects_a_projected_request() {
        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let level = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        let levels = [level.get_const_access()];
        let mut dst_level = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        let sampler = normalized_sampler(FilterMode::Nearest);
        let mut params = ReferenceParams::new(TextureType::Texture2DArray, sampler, LodMode::Exact);
        params.base.projected = true;
        sample_texture_2d_array(&mut dst_level.get_access(), &levels, [0.0; 12], &params);
    }

    /// `exec_sample_2d`'s `mip_filter: Some(MipmapFilterMode::Linear)` dispatch, proven
    /// end to end through the public `sample_texture_2d` entry point - `tcu::pixel`'s
    /// own `sample_2d_mipmap_filtered` already has a direct hand-computed blend test
    /// (iteration 8 of `tmp/DO_UNTIL_CTS_FOUNDATIONS_GLES23.md`), but nothing before
    /// this iteration proved `ReferenceParams`/`Sampler` could actually reach it - every
    /// other caller in this crate still builds a `Sampler` with `mip_filter: None`.
    ///
    /// Two flat levels (level 0, width 2, colour `0.2`; level 1, width 1, colour `0.8`)
    /// sampled through a 1x1 destination whose quad spans `s in [0, SQRT_2/2]` with `t`
    /// held flat - chosen so `compute_non_projected_tri_lod_2d`'s own formula
    /// (`dudx = (tr.x - bl.x) * src_w / dst_w = (SQRT_2/2) * 2 / 1 = SQRT_2`) gives
    /// `lod = log2(SQRT_2) = 0.5` exactly, the same one-half blend fraction iteration
    /// 8's own raw-function test used (`0.2*(1-0.5) + 0.8*0.5 = 0.5`).
    #[test]
    fn sample_texture_2d_trilinear_blends_two_levels_through_the_mip_filter_field() {
        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut level0 = TextureLevel::new(fmt, 2, 1, 1).unwrap();
        {
            let mut access = level0.get_access();
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 0, 0, 0);
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 1, 0, 0);
        }
        let mut level1 = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        level1.get_access().set_pixel([0.8, 0.0, 0.0, 1.0], 0, 0, 0);
        let levels = [level0.get_const_access(), level1.get_const_access()];

        let mut dst_level = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        let tr_s = std::f32::consts::SQRT_2 / 2.0;
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(tr_s, 0.0));

        let mut sampler = normalized_sampler(FilterMode::Nearest);
        sampler.mip_filter = Some(MipmapFilterMode::Linear);
        let params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d(&mut dst, &levels, tex_coord, &params);
        }

        let px = dst_level.get_const_access().get_pixel(0, 0, 0);
        assert!((px[0] - 0.5).abs() < 1e-2, "{px:?}");
    }

    /// The `SamplerType::Shadow` counterpart of the trilinear test above, same exact
    /// `lod = 0.5` geometry: two flat depth levels (`0.2`, `0.8`) with `ref_ = 0.5`
    /// under `CompareMode::Less` compare flat per level (`0.5 < 0.2` false -> `0.0`,
    /// `0.5 < 0.8` true -> `1.0`), so the trilinear blend is the same `0.0*0.5 +
    /// 1.0*0.5 = 0.5` the plain-colour test above hand-computes - proving
    /// `exec_sample_2d`'s `Shadow` arm reaches `sample_2d_mipmap_compare_filtered` too,
    /// not just the `Float`/`Int`/`Uint` arm.
    #[test]
    fn sample_texture_2d_shadow_trilinear_blends_two_levels_through_the_mip_filter_field() {
        let fmt = TextureFormat {
            order: ChannelOrder::D,
            type_: ChannelType::UNORM_INT16,
        };
        let mut level0 = TextureLevel::new(fmt, 2, 1, 1).unwrap();
        {
            let mut access = level0.get_access();
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 0, 0, 0);
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 1, 0, 0);
        }
        let mut level1 = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        level1.get_access().set_pixel([0.8, 0.0, 0.0, 1.0], 0, 0, 0);
        let levels = [level0.get_const_access(), level1.get_const_access()];

        let mut dst_level = TextureLevel::new(
            TextureFormat {
                order: ChannelOrder::RGBA,
                type_: ChannelType::UNORM_INT8,
            },
            1,
            1,
            1,
        )
        .unwrap();
        let tr_s = std::f32::consts::SQRT_2 / 2.0;
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(tr_s, 0.0));

        let mut sampler = Sampler {
            compare: crate::tcu::pixel::CompareMode::Less,
            ..normalized_sampler(FilterMode::Nearest)
        };
        sampler.mip_filter = Some(MipmapFilterMode::Linear);
        let mut params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        params.base.sampler_type = SamplerType::Shadow;
        params.base.ref_ = 0.5;

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d(&mut dst, &levels, tex_coord, &params);
        }

        let px = dst_level.get_const_access().get_pixel(0, 0, 0);
        assert!((px[0] - 0.5).abs() < 1e-2, "{px:?}");
    }

    /// The `TextureType::Texture2DArray` counterpart of the trilinear test above -
    /// `exec_sample_2d_array` reuses the same `compute_non_projected_tri_lod_2d`
    /// formula `sample_texture_2d` does (the layer axis doesn't enter the LOD
    /// calculation at all), so the identical `s in [0, SQRT_2/2]` trick gives the same
    /// exact `lod = 0.5`. Single layer (`layer_ndx = 0`), held flat across the quad by
    /// `compute_quad_tex_coord_2d_array`, so layer *selection* is not what's under test
    /// here - the mip-filter dispatch is.
    #[test]
    fn sample_texture_2d_array_trilinear_blends_two_levels_through_the_mip_filter_field() {
        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut level0 = TextureLevel::new(fmt, 2, 1, 1).unwrap();
        {
            let mut access = level0.get_access();
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 0, 0, 0);
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 1, 0, 0);
        }
        let mut level1 = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        level1.get_access().set_pixel([0.8, 0.0, 0.0, 1.0], 0, 0, 0);
        let levels = [level0.get_const_access(), level1.get_const_access()];

        let mut dst_level = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        let tr_s = std::f32::consts::SQRT_2 / 2.0;
        let tex_coord = compute_quad_tex_coord_2d_array(0, Vec2::new(0.0, 0.0), Vec2::new(tr_s, 0.0));

        let mut sampler = normalized_sampler(FilterMode::Nearest);
        sampler.mip_filter = Some(MipmapFilterMode::Linear);
        let params = ReferenceParams::new(TextureType::Texture2DArray, sampler, LodMode::Exact);

        {
            let mut dst = dst_level.get_access();
            sample_texture_2d_array(&mut dst, &levels, tex_coord, &params);
        }

        let px = dst_level.get_const_access().get_pixel(0, 0, 0);
        assert!((px[0] - 0.5).abs() < 1e-2, "{px:?}");
    }

    /// The `TextureType::Texture3D` counterpart - `compute_non_projected_tri_lod_3d`
    /// reduces to the same `dudx = SQRT_2` as the 2D case when `t`/`r` are both held
    /// flat (their own derivative terms vanish), so the identical trick applies with a
    /// hand-built `[s,t,r]` tex-coord array instead of `compute_quad_tex_coord_3d`'s own
    /// swizzled-corner layout (simpler to reason about directly for this one case: flat
    /// `t=0`/`r=0` at all four vertices, `s` ranging `[0, SQRT_2/2]`, the same
    /// `(-1,-1),(-1,1),(1,-1),(1,1)` vertex order every other tex-coord array here uses).
    #[test]
    fn sample_texture_3d_trilinear_blends_two_levels_through_the_mip_filter_field() {
        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut level0 = TextureLevel::new(fmt, 2, 1, 1).unwrap();
        {
            let mut access = level0.get_access();
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 0, 0, 0);
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 1, 0, 0);
        }
        let mut level1 = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        level1.get_access().set_pixel([0.8, 0.0, 0.0, 1.0], 0, 0, 0);
        let levels = [level0.get_const_access(), level1.get_const_access()];

        let mut dst_level = TextureLevel::new(fmt, 1, 1, 1).unwrap();
        let tr_s = std::f32::consts::SQRT_2 / 2.0;
        let tex_coord: [f32; 12] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, tr_s, 0.0, 0.0, tr_s, 0.0, 0.0];

        let mut sampler = normalized_sampler(FilterMode::Nearest);
        sampler.mip_filter = Some(MipmapFilterMode::Linear);
        let params = ReferenceParams::new(TextureType::Texture3D, sampler, LodMode::Exact);

        {
            let mut dst = dst_level.get_access();
            sample_texture_3d(&mut dst, &levels, tex_coord, &params);
        }

        let px = dst_level.get_const_access().get_pixel(0, 0, 0);
        assert!((px[0] - 0.5).abs() < 1e-2, "{px:?}");
    }

    /// The `TextureType::Cube` counterpart is narrower than the three above: a cube
    /// lookup's LOD (`compute_cube_lod_from_derivates`) goes through the direction
    /// vector's quotient-rule derivative rather than a plain per-axis one, so there is
    /// no equally simple choice of coordinates that lands on an exact, hand-verifiable
    /// `lod`. What this proves instead is that the dispatch itself is wired correctly:
    /// `mip_filter: Some(MipmapFilterMode::Nearest)` must produce *exactly* the same
    /// result as `mip_filter: None` for any lod, since `sample_cube_mipmap_filtered`'s
    /// own `Nearest` arm is required to reproduce `sample_cube_mipmap` exactly
    /// (iteration 8's own cross-check test, at the raw `tcu::pixel` level) - checked
    /// here one level up, through `exec_sample_cube`/`sample_texture_cube`, which is
    /// the part that was actually new this iteration.
    #[test]
    fn sample_texture_cube_mip_filter_nearest_matches_the_unset_default() {
        use crate::glu::texture_cube::ALL_FACES;
        use crate::tcu::texture_cube::TextureCube;

        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut cube = TextureCube::new(fmt, 2);
        cube.alloc_level(0);
        for face in ALL_FACES {
            let mut access = cube.face_level_mut(face, 0);
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel([0.2, 0.4, 0.6, 1.0], x, y, 0);
                }
            }
        }
        let levels = [cube.level(0)];

        let dst_fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let tex_coord: [f32; 12] = [1.0, 0.1, 0.1, 1.0, 0.1, -0.1, 1.0, -0.1, 0.1, 1.0, -0.1, -0.1];

        let sampler_none = Sampler {
            normalized_coords: true,
            ..Sampler::clamp_to_edge(FilterMode::Nearest)
        };
        let mut sampler_some = sampler_none;
        sampler_some.mip_filter = Some(MipmapFilterMode::Nearest);

        let params_none = ReferenceParams::new(TextureType::Cube, sampler_none, LodMode::Exact);
        let params_some = ReferenceParams::new(TextureType::Cube, sampler_some, LodMode::Exact);

        let mut dst_none = TextureLevel::new(dst_fmt, 2, 2, 1).unwrap();
        let mut dst_some = TextureLevel::new(dst_fmt, 2, 2, 1).unwrap();
        sample_texture_cube(&mut dst_none.get_access(), &levels, tex_coord, &params_none);
        sample_texture_cube(&mut dst_some.get_access(), &levels, tex_coord, &params_some);

        assert_eq!(
            dst_none.get_const_access().get_pixel(0, 0, 0),
            dst_some.get_const_access().get_pixel(0, 0, 0)
        );
        assert_eq!(dst_none.get_const_access().get_pixel(0, 0, 0), [0.2, 0.4, 0.6, 1.0]);
    }

    /// `to_verifier_wrap_mode` must map every `pixel::WrapMode` variant onto the
    /// identically-named `tex_verifier::WrapMode` one - `matches!` rather than
    /// `assert_eq!` since neither `WrapMode` derives `Debug`.
    #[test]
    fn to_verifier_wrap_mode_matches_every_variant_by_name() {
        assert!(matches!(
            to_verifier_wrap_mode(PixelWrapMode::ClampToEdge),
            WrapMode::ClampToEdge
        ));
        assert!(matches!(
            to_verifier_wrap_mode(PixelWrapMode::ClampToBorder),
            WrapMode::ClampToBorder
        ));
        assert!(matches!(to_verifier_wrap_mode(PixelWrapMode::Repeat), WrapMode::Repeat));
        assert!(matches!(
            to_verifier_wrap_mode(PixelWrapMode::MirroredRepeat),
            WrapMode::MirroredRepeat
        ));
    }

    /// `sampler_min_filter_mode` must match `exec_sample_2d`'s own dispatch exactly:
    /// `mip_filter: None` is the implicit `*_MIPMAP_NEAREST` shape (same as
    /// `Some(MipmapFilterMode::Nearest)`), `Some(MipmapFilterMode::Linear)` is
    /// `*_MIPMAP_LINEAR`.
    #[test]
    fn sampler_min_filter_mode_matches_exec_sample_2d_own_dispatch() {
        let nearest_no_mip = normalized_sampler(FilterMode::Nearest);
        assert!(matches!(
            sampler_min_filter_mode(&nearest_no_mip),
            MinFilterMode::NearestMipmapNearest
        ));

        let mut nearest_explicit_nearest = nearest_no_mip;
        nearest_explicit_nearest.mip_filter = Some(MipmapFilterMode::Nearest);
        assert!(matches!(
            sampler_min_filter_mode(&nearest_explicit_nearest),
            MinFilterMode::NearestMipmapNearest
        ));

        let mut nearest_linear_mip = nearest_no_mip;
        nearest_linear_mip.mip_filter = Some(MipmapFilterMode::Linear);
        assert!(matches!(
            sampler_min_filter_mode(&nearest_linear_mip),
            MinFilterMode::NearestMipmapLinear
        ));

        let linear_no_mip = normalized_sampler(FilterMode::Linear);
        assert!(matches!(
            sampler_min_filter_mode(&linear_no_mip),
            MinFilterMode::LinearMipmapNearest
        ));

        let mut linear_linear_mip = linear_no_mip;
        linear_linear_mip.mip_filter = Some(MipmapFilterMode::Linear);
        assert!(matches!(
            sampler_min_filter_mode(&linear_linear_mip),
            MinFilterMode::LinearMipmapLinear
        ));
    }

    /// `compute_texture_lookup_diff_2d` against a 1x1-texel texture: every dst pixel can
    /// only ever land on that one texel's own colour, whatever the exact
    /// triangle/derivative/LOD-bounds math picks - which makes this test's correctness
    /// independent of that math's fine detail while still exercising it for real (the
    /// tampered pixel still has to travel all the way through the geometry and reach
    /// `is_lookup_result_valid_2d` before being rejected, since its colour differs from
    /// `reference`'s and so cannot take the fast `color_threshold` shortcut).
    #[test]
    fn compute_texture_lookup_diff_2d_flags_exactly_the_tampered_pixel() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let color = [0.2, 0.4, 0.6, 1.0];

        let mut tex_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        tex_level.get_access().set_pixel(color, 0, 0, 0);
        let levels = [tex_level.get_const_access()];

        let mut reference = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = reference.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }

        let mut result = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = result.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
            // Pixel (1, 0) is tampered with - far outside any reasonable colour threshold.
            access.set_pixel([0.9, 0.1, 0.0, 1.0], 1, 0, 0);
        }

        let mut error_mask = TextureLevel::new(format, 2, 2, 1).unwrap();

        let sampler = normalized_sampler(FilterMode::Nearest);
        let params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        let lookup_prec = LookupPrecision {
            color_threshold: [1.0 / 255.0; 4],
            ..LookupPrecision::default()
        };
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_lookup_diff_2d(
            &result.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &lookup_prec,
            &lod_prec,
        );

        assert_eq!(num_failed, 1, "exactly the one tampered pixel should fail");

        let mask = error_mask.get_const_access();
        assert_eq!(
            mask.get_pixel(1, 0, 0),
            RGBA::red().to_vec().m_data,
            "the tampered pixel must be flagged red"
        );
        assert_eq!(mask.get_pixel(0, 0, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(0, 1, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(1, 1, 0), RGBA::green().to_vec().m_data);
    }

    /// The same fixture as above but with no tampering at all - every pixel must take
    /// the fast `color_threshold` path and the whole image must report clean.
    #[test]
    fn compute_texture_lookup_diff_2d_reports_clean_when_result_matches_reference() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let color = [0.2, 0.4, 0.6, 1.0];

        let mut tex_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        tex_level.get_access().set_pixel(color, 0, 0, 0);
        let levels = [tex_level.get_const_access()];

        let mut image = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = image.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }
        let mut error_mask = TextureLevel::new(format, 2, 2, 1).unwrap();

        let sampler = normalized_sampler(FilterMode::Nearest);
        let params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        let lookup_prec = LookupPrecision {
            color_threshold: [1.0 / 255.0; 4],
            ..LookupPrecision::default()
        };
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_lookup_diff_2d(
            &image.get_const_access(),
            &image.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &lookup_prec,
            &lod_prec,
        );

        assert_eq!(num_failed, 0);
        let mask = error_mask.get_const_access();
        for y in 0..2u32 {
            for x in 0..2u32 {
                assert_eq!(mask.get_pixel(x, y, 0), RGBA::green().to_vec().m_data);
            }
        }
    }

    /// `compute_texture_lookup_diff_2d_array` against a 1x1-texel, single-layer array
    /// texture - the same isolating-fixture idea as the 2D tests above (every dst pixel
    /// can only ever land on that one texel/layer's own colour), with
    /// `compute_quad_tex_coord_2d_array(0, ...)` supplying the (constant) layer
    /// coordinate `tex_coord[12]` needs that the plain 2D overload's `[f32; 8]` has no
    /// room for at all.
    #[test]
    fn compute_texture_lookup_diff_2d_array_flags_exactly_the_tampered_pixel() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let color = [0.2, 0.4, 0.6, 1.0];

        let mut tex_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        tex_level.get_access().set_pixel(color, 0, 0, 0);
        let levels = [tex_level.get_const_access()];

        let mut reference = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = reference.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }

        let mut result = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = result.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
            // Pixel (0, 1) is tampered with this time - far outside any reasonable
            // colour threshold.
            access.set_pixel([0.0, 0.1, 0.9, 1.0], 0, 1, 0);
        }

        let mut error_mask = TextureLevel::new(format, 2, 2, 1).unwrap();

        let sampler = normalized_sampler(FilterMode::Nearest);
        let params = ReferenceParams::new(TextureType::Texture2DArray, sampler, LodMode::Exact);
        let tex_coord = compute_quad_tex_coord_2d_array(0, Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        let lookup_prec = LookupPrecision {
            color_threshold: [1.0 / 255.0; 4],
            ..LookupPrecision::default()
        };
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_lookup_diff_2d_array(
            &result.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &lookup_prec,
            &lod_prec,
        );

        assert_eq!(num_failed, 1, "exactly the one tampered pixel should fail");

        let mask = error_mask.get_const_access();
        assert_eq!(
            mask.get_pixel(0, 1, 0),
            RGBA::red().to_vec().m_data,
            "the tampered pixel must be flagged red"
        );
        assert_eq!(mask.get_pixel(0, 0, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(1, 0, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(1, 1, 0), RGBA::green().to_vec().m_data);
    }

    /// The same fixture as above but with no tampering at all - every pixel must take
    /// the fast `color_threshold` path and the whole image must report clean.
    #[test]
    fn compute_texture_lookup_diff_2d_array_reports_clean_when_result_matches_reference() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let color = [0.2, 0.4, 0.6, 1.0];

        let mut tex_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        tex_level.get_access().set_pixel(color, 0, 0, 0);
        let levels = [tex_level.get_const_access()];

        let mut image = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = image.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }
        let mut error_mask = TextureLevel::new(format, 2, 2, 1).unwrap();

        let sampler = normalized_sampler(FilterMode::Nearest);
        let params = ReferenceParams::new(TextureType::Texture2DArray, sampler, LodMode::Exact);
        let tex_coord = compute_quad_tex_coord_2d_array(0, Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        let lookup_prec = LookupPrecision {
            color_threshold: [1.0 / 255.0; 4],
            ..LookupPrecision::default()
        };
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_lookup_diff_2d_array(
            &image.get_const_access(),
            &image.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &lookup_prec,
            &lod_prec,
        );

        assert_eq!(num_failed, 0);
        let mask = error_mask.get_const_access();
        for y in 0..2u32 {
            for x in 0..2u32 {
                assert_eq!(mask.get_pixel(x, y, 0), RGBA::green().to_vec().m_data);
            }
        }
    }

    /// `compute_texture_lookup_diff_3d` against a 1x1x1-texel 3D texture - the same
    /// isolating-fixture idea as the 2D/2D-array tests above. `compute_quad_tex_coord_3d(
    /// (0,0,0), (1,1,0), [0,1,2])` was hand-checked against its own formula
    /// (`corner(f) = p0 + (p1-p0)*f`, `f.z()` always `0` for every one of the four
    /// corners) to confirm it yields a constant `r = 0` across the whole quad - landing
    /// on this texture's only depth slice regardless of the triangle/derivative math -
    /// while its `s`/`t` pair is exactly `compute_quad_tex_coord_2d((0,0), (1,1))`'s own
    /// layout, confirmed by comparing both arrays' `sq`/`tq` extraction side by side.
    #[test]
    fn compute_texture_lookup_diff_3d_flags_exactly_the_tampered_pixel() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let color = [0.2, 0.4, 0.6, 1.0];

        let mut tex_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        tex_level.get_access().set_pixel(color, 0, 0, 0);
        let levels = [tex_level.get_const_access()];

        let mut reference = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = reference.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }

        let mut result = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = result.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
            // Pixel (1, 1) is tampered with this time - far outside any reasonable
            // colour threshold.
            access.set_pixel([0.9, 0.9, 0.0, 1.0], 1, 1, 0);
        }

        let mut error_mask = TextureLevel::new(format, 2, 2, 1).unwrap();

        let sampler = normalized_sampler(FilterMode::Nearest);
        let params = ReferenceParams::new(TextureType::Texture3D, sampler, LodMode::Exact);
        let tex_coord = compute_quad_tex_coord_3d(Vec3::new(0.0, 0.0, 0.0), Vec3::new(1.0, 1.0, 0.0), [0, 1, 2]);

        let lookup_prec = LookupPrecision {
            color_threshold: [1.0 / 255.0; 4],
            ..LookupPrecision::default()
        };
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_lookup_diff_3d(
            &result.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &lookup_prec,
            &lod_prec,
        );

        assert_eq!(num_failed, 1, "exactly the one tampered pixel should fail");

        let mask = error_mask.get_const_access();
        assert_eq!(
            mask.get_pixel(1, 1, 0),
            RGBA::red().to_vec().m_data,
            "the tampered pixel must be flagged red"
        );
        assert_eq!(mask.get_pixel(0, 0, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(1, 0, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(0, 1, 0), RGBA::green().to_vec().m_data);
    }

    /// The same fixture as above but with no tampering at all - every pixel must take
    /// the fast `color_threshold` path and the whole image must report clean.
    #[test]
    fn compute_texture_lookup_diff_3d_reports_clean_when_result_matches_reference() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let color = [0.2, 0.4, 0.6, 1.0];

        let mut tex_level = TextureLevel::new(format, 1, 1, 1).unwrap();
        tex_level.get_access().set_pixel(color, 0, 0, 0);
        let levels = [tex_level.get_const_access()];

        let mut image = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = image.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }
        let mut error_mask = TextureLevel::new(format, 2, 2, 1).unwrap();

        let sampler = normalized_sampler(FilterMode::Nearest);
        let params = ReferenceParams::new(TextureType::Texture3D, sampler, LodMode::Exact);
        let tex_coord = compute_quad_tex_coord_3d(Vec3::new(0.0, 0.0, 0.0), Vec3::new(1.0, 1.0, 0.0), [0, 1, 2]);

        let lookup_prec = LookupPrecision {
            color_threshold: [1.0 / 255.0; 4],
            ..LookupPrecision::default()
        };
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_lookup_diff_3d(
            &image.get_const_access(),
            &image.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &lookup_prec,
            &lod_prec,
        );

        assert_eq!(num_failed, 0);
        let mask = error_mask.get_const_access();
        for y in 0..2u32 {
            for x in 0..2u32 {
                assert_eq!(mask.get_pixel(x, y, 0), RGBA::green().to_vec().m_data);
            }
        }
    }

    /// `compute_texture_lookup_diff_cube` against a 1-texel-per-face cube, reusing
    /// `sample_texture_cube_selects_the_right_face_and_colour`'s own fixture idea: a
    /// **constant** direction vector repeated at all four quad vertices
    /// (`std::array::from_fn(|i| dir[i % 3])`, that test's own trick) makes every one of
    /// `tri_s`/`tri_t`/`tri_r`'s three swizzled corners equal, so every derivative this
    /// function computes (`tri_derivate_x`/`_y` on a 3-identical-component input) is
    /// exactly `0.0` - hand-verified through `compute_cube_lod_bounds_from_derivates`'s
    /// own formula (every `*cdx`/`*cdy` term is `0`, so `dudx = dvdx = dudy = dvdy = 0`)
    /// rather than assumed, which collapses to `compute_lod_bounds_from_derivates(0, 0,
    /// 0, 0, 0, 0, _)` - `log2(0.0) = -inf` in Rust (no panic), and `clamp_lod_bounds`
    /// then clamps that back into `[min_lod, max_lod]` (`-1000.0` by
    /// `ReferenceParams::new`'s own default), so `can_be_magnified` (`min_lod <=
    /// lod_threshold(0.0)`) is true regardless of the exact clamped value - the pixel
    /// always samples level 0's one texel on the `+X` face, independent of this
    /// function's geometry arithmetic the same way the 2D/3D tests' 1x1-texel fixture is.
    #[test]
    fn compute_texture_lookup_diff_cube_flags_exactly_the_tampered_pixel() {
        use crate::glu::texture_cube::ALL_FACES;
        use crate::tcu::texture_cube::TextureCube;

        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut cube = TextureCube::new(fmt, 1);
        cube.alloc_level(0);
        let face_colors: [[f32; 4]; 6] = [
            [1.0, 0.0, 0.0, 1.0], // +X red
            [0.0, 1.0, 0.0, 1.0], // -X green
            [0.0, 0.0, 1.0, 1.0], // +Y blue
            [1.0, 1.0, 0.0, 1.0], // -Y yellow
            [1.0, 0.0, 1.0, 1.0], // +Z magenta
            [0.0, 1.0, 1.0, 1.0], // -Z cyan
        ];
        for (face, color) in ALL_FACES.into_iter().zip(face_colors) {
            cube.face_level_mut(face, 0).set_pixel(color, 0, 0, 0);
        }
        let levels = [cube.level(0)];

        let sampler = Sampler {
            normalized_coords: true,
            ..Sampler::clamp_to_edge(FilterMode::Nearest)
        };
        let params = ReferenceParams::new(TextureType::Cube, sampler, LodMode::Exact);

        let dir = [1.0f32, 0.0, 0.0]; // +X, matching face_colors[0]
        // `t` (the second component) gets a tiny per-column perturbation instead of
        // being bit-for-bit identical across all four corners - `|0.02| << |dir[0]|`
        // keeps every corner on the same +X face (so the same single texel is sampled
        // either way), but an exactly-zero spatial derivative would make
        // `compute_cube_lod_bounds_from_derivates`'s own `compute_lod_bounds_from_derivates`
        // call trip its `min_lod <= max_lod` debug assertion (`log2` of a value that is
        // genuinely negative once `compute_floating_point_error` perturbs an exact 0.0
        // by its own tiny `tcu::Float32`-zero-encoding epsilon) - real GPU-computed
        // derivatives never land on bit-exact zero in practice.
        let tex_coord: [f32; 12] = [
            dir[0],
            dir[1] - 0.02,
            dir[2],
            dir[0],
            dir[1] - 0.02,
            dir[2],
            dir[0],
            dir[1] + 0.02,
            dir[2],
            dir[0],
            dir[1] + 0.02,
            dir[2],
        ];
        let color = face_colors[0];

        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let mut reference = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = reference.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }

        let mut result = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = result.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
            // Pixel (1, 0) is tampered with - far outside any reasonable colour threshold.
            access.set_pixel([0.0, 0.0, 0.0, 1.0], 1, 0, 0);
        }

        let mut error_mask = TextureLevel::new(format, 2, 2, 1).unwrap();

        let lookup_prec = LookupPrecision {
            color_threshold: [1.0 / 255.0; 4],
            ..LookupPrecision::default()
        };
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_lookup_diff_cube(
            &result.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &lookup_prec,
            &lod_prec,
        );

        assert_eq!(num_failed, 1, "exactly the one tampered pixel should fail");

        let mask = error_mask.get_const_access();
        assert_eq!(
            mask.get_pixel(1, 0, 0),
            RGBA::red().to_vec().m_data,
            "the tampered pixel must be flagged red"
        );
        assert_eq!(mask.get_pixel(0, 0, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(0, 1, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(1, 1, 0), RGBA::green().to_vec().m_data);
    }

    /// The same fixture as above but with no tampering at all - every pixel must take
    /// the fast `color_threshold` path and the whole image must report clean.
    #[test]
    fn compute_texture_lookup_diff_cube_reports_clean_when_result_matches_reference() {
        use crate::glu::texture_cube::ALL_FACES;
        use crate::tcu::texture_cube::TextureCube;

        let fmt = TextureFormat {
            order: ChannelOrder::RGBA,
            type_: ChannelType::UNORM_INT8,
        };
        let mut cube = TextureCube::new(fmt, 1);
        cube.alloc_level(0);
        let face_colors: [[f32; 4]; 6] = [
            [1.0, 0.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [1.0, 0.0, 1.0, 1.0],
            [0.0, 1.0, 1.0, 1.0],
        ];
        for (face, color) in ALL_FACES.into_iter().zip(face_colors) {
            cube.face_level_mut(face, 0).set_pixel(color, 0, 0, 0);
        }
        let levels = [cube.level(0)];

        let sampler = Sampler {
            normalized_coords: true,
            ..Sampler::clamp_to_edge(FilterMode::Nearest)
        };
        let params = ReferenceParams::new(TextureType::Cube, sampler, LodMode::Exact);

        let dir = [1.0f32, 0.0, 0.0];
        let tex_coord: [f32; 12] = std::array::from_fn(|i| dir[i % 3]);
        let color = face_colors[0];

        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let mut image = TextureLevel::new(format, 2, 2, 1).unwrap();
        {
            let mut access = image.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    access.set_pixel(color, x, y, 0);
                }
            }
        }
        let mut error_mask = TextureLevel::new(format, 2, 2, 1).unwrap();

        let lookup_prec = LookupPrecision {
            color_threshold: [1.0 / 255.0; 4],
            ..LookupPrecision::default()
        };
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_lookup_diff_cube(
            &image.get_const_access(),
            &image.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &lookup_prec,
            &lod_prec,
        );

        assert_eq!(num_failed, 0);
        let mask = error_mask.get_const_access();
        for y in 0..2u32 {
            for x in 0..2u32 {
                assert_eq!(mask.get_pixel(x, y, 0), RGBA::green().to_vec().m_data);
            }
        }
    }

    /// `compute_texture_compare_diff_2d` against `shadow_depth_level`'s own fixture (see
    /// `sample_texture_2d_shadow_sampler_compares_each_quadrants_own_depth` above) - build
    /// the real reference via `sample_texture_2d`, copy it into `result` unchanged, then
    /// tamper exactly one pixel to the *opposite* of its correct compare verdict.
    /// Deliberately does not add a separate "reports clean" test: every untampered pixel
    /// in this same fixture already takes the exact-equality fast path (`res_pix[0] ==
    /// ref_pix[0]`) and is asserted green below, which exercises that path for real.
    #[test]
    fn compute_texture_compare_diff_2d_flags_exactly_the_tampered_pixel() {
        let level = shadow_depth_level();
        let levels = [level.get_const_access()];

        let dst_fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let mut reference = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        let sampler = Sampler {
            compare: crate::tcu::pixel::CompareMode::Less,
            ..normalized_sampler(FilterMode::Nearest)
        };
        let mut params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        params.base.sampler_type = SamplerType::Shadow;
        params.base.ref_ = 0.5;

        {
            let mut dst = reference.get_access();
            sample_texture_2d(&mut dst, &levels, tex_coord, &params);
        }

        // Bottom-left quadrant (pixel (0,0) among others) samples depth 0.2: `0.5 < 0.2`
        // fails, so the reference's own value there is `0.0` - confirmed by this same
        // fixture's own `sample_texture_2d_shadow_sampler_compares_each_quadrants_own_depth`
        // test, which checks that exact corner.
        let mut result = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();
        {
            let src = reference.get_const_access();
            let mut dst = result.get_access();
            for y in 0..4 {
                for x in 0..4 {
                    dst.set_pixel(src.get_pixel(x, y, 0), x, y, 0);
                }
            }
        }
        // Tamper pixel (0,0): flip the correctly-`0.0` compare result to `1.0`.
        result.get_access().set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0);

        let mut error_mask = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();

        let compare_prec = TexComparePrecision::default();
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_compare_diff_2d(
            &result.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &compare_prec,
            &lod_prec,
            [0.0, 0.0, 0.0],
        );

        assert_eq!(num_failed, 1, "exactly the one tampered pixel should fail");
        let mask = error_mask.get_const_access();
        assert_eq!(
            mask.get_pixel(0, 0, 0),
            RGBA::red().to_vec().m_data,
            "the tampered pixel must be flagged red"
        );
        assert_eq!(mask.get_pixel(3, 0, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(0, 3, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(3, 3, 0), RGBA::green().to_vec().m_data);
    }

    /// `compute_texture_compare_diff_2d_array` against
    /// `sample_texture_2d_array_shadow_sampler_compares_each_layers_own_depth`'s own
    /// fixture (1x1-per-layer, 2-layer depth texture, layer 0 shallow/layer 1 deep).
    #[test]
    fn compute_texture_compare_diff_2d_array_flags_exactly_the_tampered_pixel() {
        let fmt = TextureFormat {
            order: ChannelOrder::D,
            type_: ChannelType::UNORM_INT16,
        };
        let mut level = TextureLevel::new(fmt, 1, 1, 2).unwrap();
        {
            let mut access = level.get_access();
            access.set_pixel([0.2, 0.0, 0.0, 1.0], 0, 0, 0); // layer 0: shallow
            access.set_pixel([0.8, 0.0, 0.0, 1.0], 0, 0, 1); // layer 1: deep
        }
        let levels = [level.get_const_access()];

        let dst_fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let mut reference = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();
        // `s` varies slightly (0.4/0.6) between the left/right halves, matching the
        // layer split, rather than staying bit-for-bit constant across all four
        // corners - a single 1x1-per-layer texel samples identically either way, but an
        // exactly-zero spatial derivative makes `compute_texture_compare_diff_2d_array`'s
        // own `compute_lod_bounds_from_derivates` call trip its `min_lod <= max_lod`
        // debug assertion (`log2` of a value that is genuinely negative once
        // `compute_floating_point_error` perturbs an exact 0.0 by its own tiny
        // `tcu::Float32`-zero-encoding epsilon) - real GPU-computed derivatives never
        // land on bit-exact zero in practice.
        let tex_coord: [f32; 12] = [0.4, 0.5, 0.0, 0.4, 0.5, 0.0, 0.6, 0.5, 1.0, 0.6, 0.5, 1.0];
        let sampler = Sampler {
            compare: crate::tcu::pixel::CompareMode::Less,
            ..normalized_sampler(FilterMode::Nearest)
        };
        let mut params = ReferenceParams::new(TextureType::Texture2DArray, sampler, LodMode::Exact);
        params.base.sampler_type = SamplerType::Shadow;
        params.base.ref_ = 0.5;

        {
            let mut dst = reference.get_access();
            sample_texture_2d_array(&mut dst, &levels, tex_coord, &params);
        }

        // Left half samples layer 0 (depth 0.2): `0.5 < 0.2` fails -> reference value
        // `0.0` there, matching `sample_texture_2d_array_shadow_sampler_compares_each_layers_own_depth`.
        let mut result = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();
        {
            let src = reference.get_const_access();
            let mut dst = result.get_access();
            for y in 0..4 {
                for x in 0..4 {
                    dst.set_pixel(src.get_pixel(x, y, 0), x, y, 0);
                }
            }
        }
        // Tamper pixel (0,0) (left half, layer 0): flip the correctly-`0.0` result to `1.0`.
        result.get_access().set_pixel([1.0, 0.0, 0.0, 1.0], 0, 0, 0);

        let mut error_mask = TextureLevel::new(dst_fmt, 4, 4, 1).unwrap();

        let compare_prec = TexComparePrecision::default();
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_compare_diff_2d_array(
            &result.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &compare_prec,
            &lod_prec,
            [0.0, 0.0, 0.0],
        );

        assert_eq!(num_failed, 1, "exactly the one tampered pixel should fail");
        let mask = error_mask.get_const_access();
        assert_eq!(
            mask.get_pixel(0, 0, 0),
            RGBA::red().to_vec().m_data,
            "the tampered pixel must be flagged red"
        );
        assert_eq!(
            mask.get_pixel(3, 0, 0),
            RGBA::green().to_vec().m_data,
            "right half (layer 1) must stay untouched"
        );
        assert_eq!(
            mask.get_pixel(1, 0, 0),
            RGBA::green().to_vec().m_data,
            "the rest of the left half must stay untouched"
        );
    }

    /// `compute_texture_compare_diff_cube` against
    /// `sample_texture_cube_shadow_sampler_compares_each_faces_own_depth`'s own fixture
    /// (1x1-per-face depth cube, `+X` shallow/`-Z` deep).
    #[test]
    fn compute_texture_compare_diff_cube_flags_exactly_the_tampered_pixel() {
        use crate::glu::texture_cube::ALL_FACES;
        use crate::tcu::texture_cube::TextureCube;

        let fmt = TextureFormat {
            order: ChannelOrder::D,
            type_: ChannelType::UNORM_INT16,
        };
        let mut cube = TextureCube::new(fmt, 1);
        cube.alloc_level(0);
        let face_depths: [f32; 6] = [0.3, 0.5, 0.5, 0.5, 0.5, 0.7];
        for (face, depth) in ALL_FACES.into_iter().zip(face_depths) {
            cube.face_level_mut(face, 0).set_pixel([depth, 0.0, 0.0, 1.0], 0, 0, 0);
        }
        let levels = [cube.level(0)];

        let dst_fmt = TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT);
        let sampler = Sampler {
            normalized_coords: true,
            compare: crate::tcu::pixel::CompareMode::Less,
            ..Sampler::clamp_to_edge(FilterMode::Nearest)
        };
        let mut params = ReferenceParams::new(TextureType::Cube, sampler, LodMode::Exact);
        params.base.sampler_type = SamplerType::Shadow;
        params.base.ref_ = 0.5;

        // +X direction, with a tiny per-column perturbation in `t` rather than being
        // bit-for-bit constant across the whole quad - see
        // `compute_texture_lookup_diff_cube_flags_exactly_the_tampered_pixel`'s own note
        // on why an exactly-zero derivative here trips `compute_cube_lod_bounds_from_derivates`'s
        // debug assertion; `|0.02| << |dir[0]|` keeps every corner on the same +X face.
        let dir = [1.0f32, 0.0, 0.0];
        let tex_coord: [f32; 12] = [
            dir[0],
            dir[1] - 0.02,
            dir[2],
            dir[0],
            dir[1] - 0.02,
            dir[2],
            dir[0],
            dir[1] + 0.02,
            dir[2],
            dir[0],
            dir[1] + 0.02,
            dir[2],
        ];

        let mut reference = TextureLevel::new(dst_fmt, 2, 2, 1).unwrap();
        {
            let mut dst = reference.get_access();
            sample_texture_cube(&mut dst, &levels, tex_coord, &params);
        }

        // +X is shallow (0.3): `0.5 < 0.3` fails -> reference value `0.0` everywhere,
        // matching `sample_texture_cube_shadow_sampler_compares_each_faces_own_depth`'s
        // own `check_face([1.0, 0.0, 0.0], 0.0)`.
        let mut result = TextureLevel::new(dst_fmt, 2, 2, 1).unwrap();
        {
            let src = reference.get_const_access();
            let mut dst = result.get_access();
            for y in 0..2 {
                for x in 0..2 {
                    dst.set_pixel(src.get_pixel(x, y, 0), x, y, 0);
                }
            }
        }
        // Tamper pixel (0, 1): flip the correctly-`0.0` result to `1.0`.
        result.get_access().set_pixel([1.0, 0.0, 0.0, 1.0], 0, 1, 0);

        let mut error_mask = TextureLevel::new(dst_fmt, 2, 2, 1).unwrap();

        let compare_prec = TexComparePrecision::default();
        let lod_prec = LodPrecision::default();

        let num_failed = compute_texture_compare_diff_cube(
            &result.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            &params,
            &compare_prec,
            &lod_prec,
            [0.0, 0.0, 0.0],
        );

        assert_eq!(num_failed, 1, "exactly the one tampered pixel should fail");
        let mask = error_mask.get_const_access();
        assert_eq!(
            mask.get_pixel(0, 1, 0),
            RGBA::red().to_vec().m_data,
            "the tampered pixel must be flagged red"
        );
        assert_eq!(mask.get_pixel(0, 0, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(1, 0, 0), RGBA::green().to_vec().m_data);
        assert_eq!(mask.get_pixel(1, 1, 0), RGBA::green().to_vec().m_data);
    }
}
