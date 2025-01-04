// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderTextureFunctionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `.invalid` sub-group comes from `invalid_texture_functions.test`. This file also
// ports a scoped slice of the `ShaderTextureFunctionCase`/`gls::ShaderRenderCase`-driven
// lookup cases: `sampler2D`/`samplerCube`/`sampler2DArray`/`sampler3D`/`isampler2D`/
// `usampler2D`/`isamplerCube`/`usamplerCube`/`isampler2DArray`/`usampler2DArray`/
// `isampler3D`/`usampler3D`, `_fixed`(RGBA8)/`_float`(RGBA16F)/int(RGBA8I)/uint(RGBA8UI)
// formats, plus (see below) shadow-comparison sampling across every function group upstream
// registers one for. The `isampler*`/`usampler*` forms are always `NEAREST`-filtered (GLES3
// has no linear filtering for an integer texture format) - see `TexFormat::is_integer`.
// `sampler3D` has no `textureProj3`/`textureProjLod3`/`textureProjGrad3` GLSL forms (those
// exist only for `sampler2D`'s vec3-coordinate proj) - its own `textureProj` family always
// takes the vec4 form and divides x/y/z by w, transcribed straight off upstream's own
// `CASE_SPEC` tables (no `sampler3d_vec3`/`_vec4` split the way `sampler2d` needs).
//
// Unlike the ES2 sibling, upstream's own `Function` enum here already has ten values
// (`FUNCTION_TEXTURE` through `FUNCTION_TEXELFETCH`, including `_GRAD`/`_PROJGRAD` pairs)
// and one generic `initShaderSources`/eval-parameter shape (`TexLookupParams`) rather than
// ~30 hand-written per-function eval closures, so this file carries the same shape over
// unchanged: one `Function` enum matching upstream 1:1, one shader-source generator, one
// `evaluate` that branches on the same flags (`has_proj`/`has_grad`/`has_lod`) upstream's
// own `functionHasProj`/`functionHasGrad`/`functionHasLod` do.
//
// `textureSize()` (`TextureSizeCase`, the `.texturesize` sub-group) is fully in scope,
// including its three shadow-sampler-type entries (`sampler2DShadow`/`samplerCubeShadow`/
// `sampler2DArrayShadow`) - it never samples the texture at all, only compares GLSL's own
// `textureSize(sampler, lod)` against the size the host asked for.
//
// Shadow-comparison *sampling* (`TexFormat::Shadow`, a `GL_DEPTH_COMPONENT16` texture and
// `GL_TEXTURE_COMPARE_MODE`/`_FUNC`) is ported in full, including the projective
// (`textureProj`/`textureProjLod`/`textureProjGrad`, `sampler2DShadow` only - no
// `Cube`/`Array2D` shadow-proj form is ever registered upstream) and gradient
// (`textureGrad`/`textureProjGrad`, `sampler2DShadow`/`samplerCubeShadow`/
// `sampler2DArrayShadow`) forms. This file's whole shadow scope is `NEAREST`-only
// (`samplerShadowNoMipmap`/`samplerShadowMipmap`, the only two shadow `Sampler`s upstream
// ever constructs here, are both `NEAREST`/`NEAREST_MIPMAP_NEAREST`) - a `NEAREST` filter is
// already a single unblended tap, so `evaluate` reuses the plain `sample_*_mipmap` functions
// unchanged and just compares that one tap's depth value (`.x()`, `ChannelOrder::D`'s only
// channel) against the lookup's own "ref" coordinate afterwards (divided by the same
// projective `w` a proj lookup already divides `s`/`t` by, for the one sampler kind that has
// a shadow-proj form at all) - no bilinear-PCF sampler was ever needed.

use std::sync::OnceLock;

use crate::generated::shader_library as lib;
use crate::gls::shader_library::create_group;
use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec, viewport_size};
use crate::glu::{self, Context, PrimitiveType, ProgramSources, ShaderProgram, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::matrix::Mat4;
use crate::tcu::pixel::{
    CompareMode, ConstPixelBufferAccess, CubeFace, FilterMode, PixelBufferAccess, Sampler, TextureLevel, WrapMode,
    get_cube_array_face_index, get_cube_face_coords, get_texture_format_info, sample_2d_array_mipmap,
    sample_2d_array_mipmap_offset, sample_2d_mipmap, sample_2d_mipmap_offset, sample_3d_mipmap,
    sample_3d_mipmap_offset, sample_cube_mipmap, texel_fetch_2d, texel_fetch_2d_array, texel_fetch_3d,
};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::Vec4;
use crate::tcu::{Surface, TestError, TestOutcome, TestStatus};

/// `Function` - transcribed straight off upstream's ten-value enum (`FUNCTION_TEXTURE` ..
/// `FUNCTION_TEXELFETCH`), unlike the ES2 sibling's folded six.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Function {
    Texture,
    TextureProj,  // textureProj(sampler2D, vec4) - divides by w
    TextureProj3, // textureProj(sampler2D, vec3) - divides by z
    TextureLod,
    TextureProjLod,
    TextureProjLod3,
    TextureGrad,
    TextureProjGrad,
    TextureProjGrad3,
    TexelFetch,
}

impl Function {
    /// `functionHasProj`
    fn has_proj(self) -> bool {
        matches!(
            self,
            Self::TextureProj
                | Self::TextureProj3
                | Self::TextureProjLod
                | Self::TextureProjGrad
                | Self::TextureProjLod3
                | Self::TextureProjGrad3
        )
    }

    /// `functionHasGrad`
    fn has_grad(self) -> bool {
        matches!(self, Self::TextureGrad | Self::TextureProjGrad | Self::TextureProjGrad3)
    }

    /// `functionHasLod`
    fn has_lod(self) -> bool {
        matches!(
            self,
            Self::TextureLod | Self::TextureProjLod | Self::TextureProjLod3 | Self::TexelFetch
        )
    }

    /// The projective divide picked by `function == FUNCTION_TEXTUREPROJ3` (and its
    /// `Lod3`/`Grad3` siblings): the `vec3`-coordinate forms divide by `z`, the
    /// `vec4` forms (proj by a homogeneous `w`) divide by `w`.
    fn is_proj3(self) -> bool {
        matches!(
            self,
            Self::TextureProj3 | Self::TextureProjLod3 | Self::TextureProjGrad3
        )
    }

    /// `functionHasAutoLod` - fragment-stage-only, and only for the three functions with
    /// no explicit LOD/grad/bias-only-derived value: the driver picks the LOD itself from
    /// screen-space derivatives, which is why `initTexture` neutralises the mip pyramid's
    /// colour gradient for these (see `is_auto_lod` below).
    fn has_auto_lod(self, is_vertex_case: bool) -> bool {
        !is_vertex_case && matches!(self, Self::Texture | Self::TextureProj | Self::TextureProj3)
    }

    /// `initShaderSources`'s `baseFuncName` switch - `TEXTUREPROJ`/`TEXTUREPROJ3` and their
    /// `Lod`/`Grad` siblings share one GLSL name apiece, since the `3`-suffix only changes
    /// which coordinate divides (host-side), not which builtin GLSL calls.
    fn glsl_base_name(self) -> &'static str {
        match self {
            Self::Texture => "texture",
            Self::TextureProj | Self::TextureProj3 => "textureProj",
            Self::TextureLod => "textureLod",
            Self::TextureProjLod | Self::TextureProjLod3 => "textureProjLod",
            Self::TextureGrad => "textureGrad",
            Self::TextureProjGrad | Self::TextureProjGrad3 => "textureProjGrad",
            Self::TexelFetch => "texelFetch",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TexKind {
    Tex2D,
    Cube,
    /// `sampler2DArray` - `TEXTURETYPE_2D_ARRAY` upstream.
    Array2D,
    /// `sampler3D` - `TEXTURETYPE_3D` upstream. Unlike `Array2D`, whose layer count stays
    /// fixed across mip levels, a 3D texture's own depth shrinks per level exactly like its
    /// width/height (see `TextureSpec::depth`, `build_texture_levels`'s `Tex3D` branch).
    Tex3D,
}

impl TexKind {
    /// `TextureSizeCase::getGLTextureTarget` - the same target every other case in this
    /// file derives inline per call site (`upload_texture`'s own `match tex.kind`); this one
    /// gets a named method because `TextureSizeCase` has no `TextureSpec` to match on at all.
    fn gl_target(self) -> glw::GLenum {
        match self {
            Self::Tex2D => glw::GL_TEXTURE_2D,
            Self::Cube => glw::GL_TEXTURE_CUBE_MAP,
            Self::Array2D => glw::GL_TEXTURE_2D_ARRAY,
            Self::Tex3D => glw::GL_TEXTURE_3D,
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TexFormat {
    Fixed, // GL_RGBA8 / UNORM_INT8
    Float, // GL_RGBA16F / HALF_FLOAT
    Int,   // GL_RGBA8I / SIGNED_INT8 - isampler2D/isamplerCube
    Uint,  // GL_RGBA8UI / UNSIGNED_INT8 - usampler2D/usamplerCube
    /// `sampler2DShadow`/`samplerCubeShadow`/`sampler2DArrayShadow` - `GL_DEPTH_COMPONENT16`,
    /// a single-channel (`ChannelOrder::D`) format unlike every other variant's four-channel
    /// RGBA-ish one (see `channel_order`). Always paired with `samplerShadowNoMipmap`/
    /// `samplerShadowMipmap` upstream, both `NEAREST`-only (see `is_nearest_only`) - GLES3
    /// shadow sampling never blends taps in this file's scope (no `LINEAR`/`LINEAR_MIPMAP_*`
    /// shadow sampler is ever constructed), which is what lets `evaluate` reuse the plain
    /// `sample_*_mipmap` functions unchanged instead of a new bilinear-PCF one: a `NEAREST`
    /// filter is already a single unblended tap, so only comparing that one tap's value is
    /// needed on top.
    Shadow,
}

impl TexFormat {
    fn channel_type(self) -> ChannelType {
        match self {
            Self::Fixed => ChannelType::UNORM_INT8,
            Self::Float => ChannelType::HALF_FLOAT,
            Self::Int => ChannelType::SIGNED_INT8,
            Self::Uint => ChannelType::UNSIGNED_INT8,
            Self::Shadow => ChannelType::UNORM_INT16,
        }
    }

    /// Every non-shadow format here is a four-channel RGBA-ish one; `GL_DEPTH_COMPONENT16`
    /// is single-channel (`ChannelOrder::D`). Both `upload_texture` and `evaluate`/
    /// `setup_uniforms` used to hardcode `ChannelOrder::RGBA` before this variant existed -
    /// now they read it from here instead, so a future format needing a third channel order
    /// only has to change this one method.
    fn channel_order(self) -> ChannelOrder {
        if self == Self::Shadow {
            ChannelOrder::D
        } else {
            ChannelOrder::RGBA
        }
    }

    fn gl_internal_format(self) -> GLint {
        (match self {
            Self::Fixed => glw::GL_RGBA8,
            Self::Float => glw::GL_RGBA16F,
            Self::Int => glw::GL_RGBA8I,
            Self::Uint => glw::GL_RGBA8UI,
            Self::Shadow => glw::GL_DEPTH_COMPONENT16,
        }) as GLint
    }

    fn gl_type(self) -> glw::GLenum {
        match self {
            Self::Fixed | Self::Uint => glw::GL_UNSIGNED_BYTE,
            Self::Float => glw::GL_HALF_FLOAT,
            Self::Int => glw::GL_BYTE,
            Self::Shadow => glw::GL_UNSIGNED_SHORT,
        }
    }

    /// The `glTexImage2D` `format` (not `internalformat`) parameter - `GL_RGBA_INTEGER`
    /// for the two integer formats, since an integer internal format may only be
    /// uploaded through the `_INTEGER` external format (`GL_RGBA` is rejected).
    fn gl_format(self) -> glw::GLenum {
        match self {
            Self::Fixed | Self::Float => glw::GL_RGBA,
            Self::Int | Self::Uint => glw::GL_RGBA_INTEGER,
            Self::Shadow => glw::GL_DEPTH_COMPONENT,
        }
    }

    /// `isampler2D`/`usampler2D` (and their cube counterparts) may only be filtered
    /// `NEAREST` - GLES3 has no linear filtering for an integer texture format, so every
    /// `isampler`/`usampler` case uses `samplerNearestNoMipmap`/`samplerNearestMipmap`
    /// (upstream's own choice) rather than the `LINEAR`/`LINEAR_MIPMAP_NEAREST` pair
    /// `Fixed`/`Float` use.
    fn is_integer(self) -> bool {
        matches!(self, Self::Int | Self::Uint)
    }

    fn is_shadow(self) -> bool {
        self == Self::Shadow
    }

    /// `isampler`/`usampler` and shadow textures are both always `NEAREST`-filtered, for
    /// different reasons (no ES3 linear filtering for an integer format; upstream simply
    /// never constructs a `LINEAR`-filtered shadow sampler in this file) - `upload_texture`'s
    /// `is_nearest` reads this instead of repeating `is_integer() || is_shadow()` itself.
    fn is_nearest_only(self) -> bool {
        self.is_integer() || self.is_shadow()
    }
}

/// `TextureSpec`, narrowed to the two sampler kinds and two formats this file's scope
/// covers - internal format is derived from `format` rather than carried separately, since
/// every case here uses the one GL sized format each `TexFormat` implies.
#[derive(Clone, Copy)]
struct TextureSpec {
    kind: TexKind,
    format: TexFormat,
    width: u32,
    height: u32,
    num_levels: u32,
    /// `samplerTexelFetch` (`NEAREST_MIPMAP_NEAREST`/non-normalized) vs
    /// `samplerLinear{,Mipmap}` (`LINEAR`/`LINEAR_MIPMAP_NEAREST`, normalized) - `texelFetch`
    /// ignores both the GL sampler state and the host `Sampler` struct entirely (direct,
    /// unfiltered, unwrapped indexing), so this only selects the GL texture parameters and
    /// the const constructors below, never anything `evaluate` reads.
    is_texel_fetch: bool,
    /// Only meaningful for `TexKind::Array2D` (the array layer count, `m_textureSpec.depth`
    /// upstream) - `1` for `Tex2D`/`Cube`/`Tex3D`, unread there.
    layers: u32,
    /// Only meaningful for `TexKind::Tex3D` (`m_textureSpec.depth` upstream, the same field
    /// `layers` reads for `Array2D` - but unlike a layer count this is a genuine spatial
    /// extent that shrinks per mip level, so it gets its own field rather than sharing
    /// `layers`'s always-constant-across-levels meaning). `1` for every other kind, unread
    /// there.
    depth: u32,
}

const fn tex_spec(kind: TexKind, format: TexFormat, width: u32, height: u32, num_levels: u32) -> TextureSpec {
    TextureSpec {
        kind,
        format,
        width,
        height,
        num_levels,
        is_texel_fetch: false,
        layers: 1,
        depth: 1,
    }
}

const fn texel_fetch_spec(format: TexFormat, width: u32, height: u32, num_levels: u32) -> TextureSpec {
    TextureSpec {
        kind: TexKind::Tex2D,
        format,
        width,
        height,
        num_levels,
        is_texel_fetch: true,
        layers: 1,
        depth: 1,
    }
}

/// `TEXTURETYPE_2D_ARRAY` - `layers` is `m_textureSpec.depth` upstream (the array layer
/// count, not a mip-shrinking spatial extent).
const fn array_spec(format: TexFormat, width: u32, height: u32, layers: u32, num_levels: u32) -> TextureSpec {
    TextureSpec {
        kind: TexKind::Array2D,
        format,
        width,
        height,
        num_levels,
        is_texel_fetch: false,
        layers,
        depth: 1,
    }
}

const fn array_texel_fetch_spec(
    format: TexFormat,
    width: u32,
    height: u32,
    layers: u32,
    num_levels: u32,
) -> TextureSpec {
    TextureSpec {
        kind: TexKind::Array2D,
        format,
        width,
        height,
        num_levels,
        is_texel_fetch: true,
        layers,
        depth: 1,
    }
}

/// `TEXTURETYPE_3D` - `depth` is `m_textureSpec.depth` upstream, a spatial extent that
/// shrinks per mip level exactly like `width`/`height` (unlike `Array2D`'s `layers`).
const fn tex_3d_spec(format: TexFormat, width: u32, height: u32, depth: u32, num_levels: u32) -> TextureSpec {
    TextureSpec {
        kind: TexKind::Tex3D,
        format,
        width,
        height,
        num_levels,
        is_texel_fetch: false,
        layers: 1,
        depth,
    }
}

const fn texel_fetch_3d_spec(format: TexFormat, width: u32, height: u32, depth: u32, num_levels: u32) -> TextureSpec {
    TextureSpec {
        kind: TexKind::Tex3D,
        format,
        width,
        height,
        num_levels,
        is_texel_fetch: true,
        layers: 1,
        depth,
    }
}

const TEX_2D_FIXED: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Fixed, 256, 256, 1);
const TEX_2D_MIPMAP_FIXED: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Fixed, 256, 256, 9);
const TEX_2D_FLOAT: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Float, 256, 256, 1);
const TEX_2D_MIPMAP_FLOAT: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Float, 256, 256, 9);
const TEX_CUBE_FIXED: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Fixed, 256, 256, 1);
const TEX_CUBE_MIPMAP_FIXED: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Fixed, 256, 256, 9);
const TEX_CUBE_FLOAT: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Float, 256, 256, 1);
const TEX_CUBE_MIPMAP_FLOAT: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Float, 128, 128, 8);
const TEX_2D_TEXELFETCH_FIXED: TextureSpec = texel_fetch_spec(TexFormat::Fixed, 256, 256, 9);
const TEX_2D_TEXELFETCH_FLOAT: TextureSpec = texel_fetch_spec(TexFormat::Float, 256, 256, 9);

// `isampler2D`/`usampler2D`/`isamplerCube`/`usamplerCube` - `tex2DInt`/`tex2DUint`/
// `texCubeInt`/`texCubeUint` and their `Mipmap` siblings upstream, always `NEAREST`-filtered
// (see `TexFormat::is_integer`).
const TEX_2D_INT: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Int, 256, 256, 1);
const TEX_2D_MIPMAP_INT: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Int, 256, 256, 9);
const TEX_2D_UINT: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Uint, 256, 256, 1);
const TEX_2D_MIPMAP_UINT: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Uint, 256, 256, 9);
const TEX_CUBE_INT: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Int, 256, 256, 1);
const TEX_CUBE_MIPMAP_INT: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Int, 256, 256, 9);
const TEX_CUBE_UINT: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Uint, 256, 256, 1);
const TEX_CUBE_MIPMAP_UINT: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Uint, 256, 256, 9);
const TEX_2D_TEXELFETCH_INT: TextureSpec = texel_fetch_spec(TexFormat::Int, 256, 256, 9);
const TEX_2D_TEXELFETCH_UINT: TextureSpec = texel_fetch_spec(TexFormat::Uint, 256, 256, 9);

// `sampler2DArray` - `tex2DArray*` upstream (`TEXTURETYPE_2D_ARRAY`, 128x128, 4 layers).
const TEX_2D_ARRAY_FIXED: TextureSpec = array_spec(TexFormat::Fixed, 128, 128, 4, 1);
const TEX_2D_ARRAY_MIPMAP_FIXED: TextureSpec = array_spec(TexFormat::Fixed, 128, 128, 4, 8);
const TEX_2D_ARRAY_FLOAT: TextureSpec = array_spec(TexFormat::Float, 128, 128, 4, 1);
const TEX_2D_ARRAY_MIPMAP_FLOAT: TextureSpec = array_spec(TexFormat::Float, 128, 128, 4, 8);
const TEX_2D_ARRAY_INT: TextureSpec = array_spec(TexFormat::Int, 128, 128, 4, 1);
const TEX_2D_ARRAY_MIPMAP_INT: TextureSpec = array_spec(TexFormat::Int, 128, 128, 4, 8);
const TEX_2D_ARRAY_UINT: TextureSpec = array_spec(TexFormat::Uint, 128, 128, 4, 1);
const TEX_2D_ARRAY_MIPMAP_UINT: TextureSpec = array_spec(TexFormat::Uint, 128, 128, 4, 8);
const TEX_2D_ARRAY_TEXELFETCH_FIXED: TextureSpec = array_texel_fetch_spec(TexFormat::Fixed, 128, 128, 4, 8);
const TEX_2D_ARRAY_TEXELFETCH_FLOAT: TextureSpec = array_texel_fetch_spec(TexFormat::Float, 128, 128, 4, 8);
const TEX_2D_ARRAY_TEXELFETCH_INT: TextureSpec = array_texel_fetch_spec(TexFormat::Int, 128, 128, 4, 8);
const TEX_2D_ARRAY_TEXELFETCH_UINT: TextureSpec = array_texel_fetch_spec(TexFormat::Uint, 128, 128, 4, 8);

// `sampler3D` - `tex3D*` upstream (`TEXTURETYPE_3D`, 64x32x32).
const TEX_3D_FIXED: TextureSpec = tex_3d_spec(TexFormat::Fixed, 64, 32, 32, 1);
const TEX_3D_MIPMAP_FIXED: TextureSpec = tex_3d_spec(TexFormat::Fixed, 64, 32, 32, 7);
const TEX_3D_FLOAT: TextureSpec = tex_3d_spec(TexFormat::Float, 64, 32, 32, 1);
const TEX_3D_MIPMAP_FLOAT: TextureSpec = tex_3d_spec(TexFormat::Float, 64, 32, 32, 7);
const TEX_3D_INT: TextureSpec = tex_3d_spec(TexFormat::Int, 64, 32, 32, 1);
const TEX_3D_MIPMAP_INT: TextureSpec = tex_3d_spec(TexFormat::Int, 64, 32, 32, 7);
const TEX_3D_UINT: TextureSpec = tex_3d_spec(TexFormat::Uint, 64, 32, 32, 1);
const TEX_3D_MIPMAP_UINT: TextureSpec = tex_3d_spec(TexFormat::Uint, 64, 32, 32, 7);
const TEX_3D_TEXELFETCH_FIXED: TextureSpec = texel_fetch_3d_spec(TexFormat::Fixed, 64, 32, 32, 7);
const TEX_3D_TEXELFETCH_FLOAT: TextureSpec = texel_fetch_3d_spec(TexFormat::Float, 64, 32, 32, 7);
const TEX_3D_TEXELFETCH_INT: TextureSpec = texel_fetch_3d_spec(TexFormat::Int, 64, 32, 32, 7);
const TEX_3D_TEXELFETCH_UINT: TextureSpec = texel_fetch_3d_spec(TexFormat::Uint, 64, 32, 32, 7);

// `sampler2DShadow`/`samplerCubeShadow`/`sampler2DArrayShadow` - `tex2DShadow`/
// `texCubeShadow`/`tex2DArrayShadow` and their `Mipmap` siblings upstream. Same
// width/height/layer-count as each kind's non-shadow siblings above; only the format and
// (for `Cube`) the single-level-vs-9 level count come from upstream's own tables verbatim.
const TEX_2D_SHADOW: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Shadow, 256, 256, 1);
const TEX_2D_MIPMAP_SHADOW: TextureSpec = tex_spec(TexKind::Tex2D, TexFormat::Shadow, 256, 256, 9);
const TEX_CUBE_SHADOW: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Shadow, 256, 256, 1);
const TEX_CUBE_MIPMAP_SHADOW: TextureSpec = tex_spec(TexKind::Cube, TexFormat::Shadow, 256, 256, 9);
const TEX_2D_ARRAY_SHADOW: TextureSpec = array_spec(TexFormat::Shadow, 128, 128, 4, 1);
const TEX_2D_ARRAY_MIPMAP_SHADOW: TextureSpec = array_spec(TexFormat::Shadow, 128, 128, 4, 8);

/// `TextureLookupSpec`.
#[derive(Clone, Copy)]
struct LookupSpec {
    function: Function,
    min_coord: [f32; 4],
    max_coord: [f32; 4],
    use_bias: bool,
    min_lod_bias: f32,
    max_lod_bias: f32,
    /// Only read when `function.has_grad()`.
    min_dx: [f32; 3],
    max_dx: [f32; 3],
    min_dy: [f32; 3],
    max_dy: [f32; 3],
    use_offset: bool,
    offset: [i32; 3],
}

/// `CASE_SPEC`.
#[allow(clippy::too_many_arguments)]
const fn lookup(
    function: Function,
    min_coord: [f32; 4],
    max_coord: [f32; 4],
    use_bias: bool,
    min_lod_bias: f32,
    max_lod_bias: f32,
    use_offset: bool,
    offset: [i32; 3],
) -> LookupSpec {
    LookupSpec {
        function,
        min_coord,
        max_coord,
        use_bias,
        min_lod_bias,
        max_lod_bias,
        min_dx: [0.0; 3],
        max_dx: [0.0; 3],
        min_dy: [0.0; 3],
        max_dy: [0.0; 3],
        use_offset,
        offset,
    }
}

/// `GRAD_CASE_SPEC`.
#[allow(clippy::too_many_arguments)]
const fn grad_lookup(
    function: Function,
    min_coord: [f32; 4],
    max_coord: [f32; 4],
    min_dx: [f32; 3],
    max_dx: [f32; 3],
    min_dy: [f32; 3],
    max_dy: [f32; 3],
    use_offset: bool,
    offset: [i32; 3],
) -> LookupSpec {
    LookupSpec {
        function,
        min_coord,
        max_coord,
        use_bias: false,
        min_lod_bias: 0.0,
        max_lod_bias: 0.0,
        min_dx,
        max_dx,
        min_dy,
        max_dy,
        use_offset,
        offset,
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Flags {
    Vertex,
    Fragment,
    Both,
}

/// `TexFuncCaseSpec` - transcribed straight off upstream's `CASE_SPEC`/`GRAD_CASE_SPEC`
/// tables, restricted to the `sampler2d`/`samplercube` `_fixed`/`_float` entries.
struct CaseSpec {
    name: &'static str,
    lookup: LookupSpec,
    tex: TextureSpec,
    flags: Flags,
}

const fn cs(name: &'static str, lookup: LookupSpec, tex: TextureSpec, flags: Flags) -> CaseSpec {
    CaseSpec {
        name,
        lookup,
        tex,
        flags,
    }
}

use Flags::{Both, Fragment, Vertex};
use Function::*;

const COORD_2D: [f32; 4] = [-0.2, -0.4, 0.0, 0.0];
const COORD_2D_MAX: [f32; 4] = [1.5, 2.3, 0.0, 0.0];
const COORD_CUBE_MIN: [f32; 4] = [-1.0, -1.0, 1.01, 0.0];
const COORD_CUBE_MAX: [f32; 4] = [1.0, 1.0, 1.01, 0.0];
const COORD_CUBE_MIN_NEG: [f32; 4] = [-1.0, -1.0, -1.01, 0.0];
const COORD_CUBE_MAX_NEG: [f32; 4] = [1.0, 1.0, -1.01, 0.0];
const COORD_PROJ3_MIN: [f32; 4] = [-0.3, -0.6, 1.5, 0.0];
const COORD_PROJ3_MAX: [f32; 4] = [2.25, 3.45, 1.5, 0.0];
const COORD_PROJ4_MIN: [f32; 4] = [-0.3, -0.6, 0.0, 1.5];
const COORD_PROJ4_MAX: [f32; 4] = [2.25, 3.45, 0.0, 1.5];
const COORD_2D_ARRAY_MIN: [f32; 4] = [-1.2, -0.4, -0.5, 0.0];
const COORD_2D_ARRAY_MAX: [f32; 4] = [1.5, 2.3, 3.5, 0.0];
const COORD_3D_MIN: [f32; 4] = [-1.2, -1.4, 0.1, 0.0];
const COORD_3D_MAX: [f32; 4] = [1.5, 2.3, 2.3, 0.0];
const COORD_3D_PROJ_MIN: [f32; 4] = [0.9, 1.05, -0.08, -0.75];
const COORD_3D_PROJ_MAX: [f32; 4] = [-1.13, -1.7, -1.7, -0.75];

// Shadow-comparison coordinates: the same `s`/`t`/(`r`/layer) ranges as each kind's
// non-shadow siblings above, plus one extra "ref" component (the depth value compared
// against) - `.z()` for `Tex2D` (which has no third coordinate component otherwise),
// `.w()` for `Cube`/`Array2D` (whose `.z()` is already `r`/layer). Transcribed from
// upstream's own shadow `CASE_SPEC` rows, which carry the ref range in that same slot
// rather than needing a separate field.
const COORD_2D_SHADOW_MIN: [f32; 4] = [-0.2, -0.4, 0.0, 0.0];
const COORD_2D_SHADOW_MAX: [f32; 4] = [1.5, 2.3, 1.0, 0.0];
const COORD_CUBE_SHADOW_MIN: [f32; 4] = [-1.0, -1.0, 1.01, 0.0];
const COORD_CUBE_SHADOW_MAX: [f32; 4] = [1.0, 1.0, 1.01, 1.0];
const COORD_2D_ARRAY_SHADOW_MIN: [f32; 4] = [-1.2, -0.4, -0.5, 0.0];
const COORD_2D_ARRAY_SHADOW_MAX: [f32; 4] = [1.5, 2.3, 3.5, 1.0];
// `sampler2dshadow`'s own `textureProj`/`textureProjGrad` coordinate ranges - distinct
// numeric values from both `COORD_PROJ4_MIN/MAX` (the non-shadow vec4-proj siblings) and
// from each other (`textureProjGrad`'s own `w` range is negative), transcribed verbatim off
// upstream's `textureProjCases`/`textureProjGradCases` tables rather than reused.
const COORD_PROJ4_SHADOW_MIN: [f32; 4] = [0.2, 0.6, 0.0, 1.5];
const COORD_PROJ4_SHADOW_MAX: [f32; 4] = [-2.25, -3.45, 1.5, 1.5];
const COORD_PROJGRAD_SHADOW_MIN: [f32; 4] = [0.2, 0.6, 0.0, -1.5];
const COORD_PROJGRAD_SHADOW_MAX: [f32; 4] = [-2.25, -3.45, -1.5, -1.5];

const TEXTURE_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_fixed",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_2D_FIXED,
        Vertex,
    ),
    cs(
        "sampler2d_fixed",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_2D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_float",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_2D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler2d_float",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_2D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "sampler2d_bias_fixed",
        lookup(Texture, COORD_2D, COORD_2D_MAX, true, -2.0, 2.0, false, [0; 3]),
        TEX_2D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_bias_float",
        lookup(Texture, COORD_2D, COORD_2D_MAX, true, -2.0, 2.0, false, [0; 3]),
        TEX_2D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "samplercube_fixed",
        lookup(Texture, COORD_CUBE_MIN, COORD_CUBE_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_CUBE_FIXED,
        Vertex,
    ),
    cs(
        "samplercube_fixed",
        lookup(Texture, COORD_CUBE_MIN, COORD_CUBE_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_CUBE_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "samplercube_float",
        lookup(
            Texture,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_FLOAT,
        Vertex,
    ),
    cs(
        "samplercube_float",
        lookup(
            Texture,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "samplercube_bias_fixed",
        lookup(Texture, COORD_CUBE_MIN, COORD_CUBE_MAX, true, -2.0, 2.0, false, [0; 3]),
        TEX_CUBE_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "samplercube_bias_float",
        lookup(
            Texture,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler2d",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_2D_INT,
        Vertex,
    ),
    cs(
        "isampler2d",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_2D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2d",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_2D_UINT,
        Vertex,
    ),
    cs(
        "usampler2d",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_2D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "isampler2d_bias",
        lookup(Texture, COORD_2D, COORD_2D_MAX, true, -2.0, 2.0, false, [0; 3]),
        TEX_2D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2d_bias",
        lookup(Texture, COORD_2D, COORD_2D_MAX, true, -2.0, 2.0, false, [0; 3]),
        TEX_2D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "isamplercube",
        lookup(Texture, COORD_CUBE_MIN, COORD_CUBE_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_CUBE_INT,
        Vertex,
    ),
    cs(
        "isamplercube",
        lookup(Texture, COORD_CUBE_MIN, COORD_CUBE_MAX, false, 0.0, 0.0, false, [0; 3]),
        TEX_CUBE_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usamplercube",
        lookup(
            Texture,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_UINT,
        Vertex,
    ),
    cs(
        "usamplercube",
        lookup(
            Texture,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "isamplercube_bias",
        lookup(Texture, COORD_CUBE_MIN, COORD_CUBE_MAX, true, -2.0, 2.0, false, [0; 3]),
        TEX_CUBE_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usamplercube_bias",
        lookup(
            Texture,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler2darray_fixed",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_FIXED,
        Vertex,
    ),
    cs(
        "sampler2darray_fixed",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2darray_float",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_FLOAT,
        Vertex,
    ),
    cs(
        "sampler2darray_float",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler2darray",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_INT,
        Vertex,
    ),
    cs(
        "isampler2darray",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2darray",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_UINT,
        Vertex,
    ),
    cs(
        "usampler2darray",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler2darray_bias_fixed",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2darray_bias_float",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler2darray_bias",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2darray_bias",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler3d_fixed",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, false, [0, 0, 0]),
        TEX_3D_FIXED,
        Vertex,
    ),
    cs(
        "sampler3d_fixed",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, false, [0, 0, 0]),
        TEX_3D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler3d_float",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, false, [0, 0, 0]),
        TEX_3D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler3d_float",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, false, [0, 0, 0]),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, false, [0, 0, 0]),
        TEX_3D_INT,
        Vertex,
    ),
    cs(
        "isampler3d",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, false, [0, 0, 0]),
        TEX_3D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler3d",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, false, [0, 0, 0]),
        TEX_3D_UINT,
        Vertex,
    ),
    cs(
        "usampler3d",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, false, [0, 0, 0]),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler3d_bias_fixed",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, true, -2.0, 1.0, false, [0, 0, 0]),
        TEX_3D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler3d_bias_float",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, true, -2.0, 1.0, false, [0, 0, 0]),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d_bias",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, true, -2.0, 2.0, false, [0, 0, 0]),
        TEX_3D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler3d_bias",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, true, -2.0, 2.0, false, [0, 0, 0]),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            Texture,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            Texture,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Fragment,
    ),
    cs(
        "sampler2dshadow_bias",
        lookup(
            Texture,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Fragment,
    ),
    cs(
        "samplercubeshadow",
        lookup(
            Texture,
            COORD_CUBE_SHADOW_MIN,
            COORD_CUBE_SHADOW_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_SHADOW,
        Vertex,
    ),
    cs(
        "samplercubeshadow",
        lookup(
            Texture,
            COORD_CUBE_SHADOW_MIN,
            COORD_CUBE_SHADOW_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_SHADOW,
        Fragment,
    ),
    cs(
        "samplercubeshadow_bias",
        lookup(
            Texture,
            COORD_CUBE_SHADOW_MIN,
            COORD_CUBE_SHADOW_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_SHADOW,
        Fragment,
    ),
    cs(
        "sampler2darrayshadow",
        lookup(
            Texture,
            COORD_2D_ARRAY_SHADOW_MIN,
            COORD_2D_ARRAY_SHADOW_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2darrayshadow",
        lookup(
            Texture,
            COORD_2D_ARRAY_SHADOW_MIN,
            COORD_2D_ARRAY_SHADOW_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Fragment,
    ),
    // upstream's own `sampler2darrayshadow_bias` row is commented out ("Not in spec"),
    // confirmed absent from `es3fShaderTextureFunctionTests.cpp` rather than a port omission.
];

/// `_bias` variants deliberately keep the non-mipmap texture spec ("thanks to wide allowed
/// range for LOD computation", upstream's own comment).
const TEXTURE_OFFSET_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_fixed",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, true, [-8, 7, 0]),
        TEX_2D_FIXED,
        Vertex,
    ),
    cs(
        "sampler2d_fixed",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, true, [7, -8, 0]),
        TEX_2D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_float",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, true, [-8, 7, 0]),
        TEX_2D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler2d_float",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, true, [7, -8, 0]),
        TEX_2D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "sampler2d_bias_fixed",
        lookup(Texture, COORD_2D, COORD_2D_MAX, true, -2.0, 2.0, true, [-8, 7, 0]),
        TEX_2D_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_bias_float",
        lookup(Texture, COORD_2D, COORD_2D_MAX, true, -2.0, 2.0, true, [7, -8, 0]),
        TEX_2D_FLOAT,
        Fragment,
    ),
    cs(
        "isampler2d",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, true, [-8, 7, 0]),
        TEX_2D_INT,
        Vertex,
    ),
    cs(
        "isampler2d",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, true, [7, -8, 0]),
        TEX_2D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2d",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, true, [-8, 7, 0]),
        TEX_2D_UINT,
        Vertex,
    ),
    cs(
        "usampler2d",
        lookup(Texture, COORD_2D, COORD_2D_MAX, false, 0.0, 0.0, true, [7, -8, 0]),
        TEX_2D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "isampler2d_bias",
        lookup(Texture, COORD_2D, COORD_2D_MAX, true, -2.0, 2.0, true, [-8, 7, 0]),
        TEX_2D_INT,
        Fragment,
    ),
    cs(
        "usampler2d_bias",
        lookup(Texture, COORD_2D, COORD_2D_MAX, true, -2.0, 2.0, true, [7, -8, 0]),
        TEX_2D_UINT,
        Fragment,
    ),
    cs(
        "sampler2darray_fixed",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_FIXED,
        Vertex,
    ),
    cs(
        "sampler2darray_fixed",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2darray_float",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_FLOAT,
        Vertex,
    ),
    cs(
        "sampler2darray_float",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler2darray",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_INT,
        Vertex,
    ),
    cs(
        "isampler2darray",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2darray",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_UINT,
        Vertex,
    ),
    cs(
        "usampler2darray",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler2darray_bias_fixed",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_FIXED,
        Fragment,
    ),
    cs(
        "sampler2darray_bias_float",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            true,
            -2.0,
            2.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_FLOAT,
        Fragment,
    ),
    cs(
        "isampler2darray_bias",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_INT,
        Fragment,
    ),
    cs(
        "usampler2darray_bias",
        lookup(
            Texture,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            true,
            -2.0,
            2.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_UINT,
        Fragment,
    ),
    cs(
        "sampler3d_fixed",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, true, [-8, 7, 3]),
        TEX_3D_FIXED,
        Vertex,
    ),
    cs(
        "sampler3d_fixed",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, true, [7, 3, -8]),
        TEX_3D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler3d_float",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, true, [3, -8, 7]),
        TEX_3D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler3d_float",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, true, [-8, 7, 3]),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, true, [7, 3, -8]),
        TEX_3D_INT,
        Vertex,
    ),
    cs(
        "isampler3d",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, true, [3, -8, 7]),
        TEX_3D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler3d",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, true, [-8, 7, 3]),
        TEX_3D_UINT,
        Vertex,
    ),
    cs(
        "usampler3d",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, false, 0.0, 0.0, true, [7, 3, -8]),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler3d_bias_fixed",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, true, -2.0, 1.0, true, [-8, 7, 3]),
        TEX_3D_FIXED,
        Fragment,
    ),
    cs(
        "sampler3d_bias_float",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, true, -2.0, 1.0, true, [7, 3, -8]),
        TEX_3D_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d_bias",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, true, -2.0, 2.0, true, [3, -8, 7]),
        TEX_3D_INT,
        Fragment,
    ),
    cs(
        "usampler3d_bias",
        lookup(Texture, COORD_3D_MIN, COORD_3D_MAX, true, -2.0, 2.0, true, [-8, 7, 3]),
        TEX_3D_UINT,
        Fragment,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            Texture,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            Texture,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Fragment,
    ),
    cs(
        "sampler2dshadow_bias",
        lookup(
            Texture,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_SHADOW,
        Fragment,
    ),
];

const TEXTURE_PROJ_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_vec3_fixed",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_FIXED,
        Vertex,
    ),
    cs(
        "sampler2d_vec3_fixed",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_vec3_float",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler2d_vec3_float",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "sampler2d_vec3_bias_fixed",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_vec3_bias_float",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "sampler2d_vec4_fixed",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_FIXED,
        Vertex,
    ),
    cs(
        "sampler2d_vec4_fixed",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_vec4_float",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler2d_vec4_float",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "sampler2d_vec4_bias_fixed",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_vec4_bias_float",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler2d_vec3",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_INT,
        Vertex,
    ),
    cs(
        "isampler2d_vec3",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2d_vec3",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_UINT,
        Vertex,
    ),
    cs(
        "usampler2d_vec3",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "isampler2d_vec3_bias",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2d_vec3_bias",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "isampler2d_vec4",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_INT,
        Vertex,
    ),
    cs(
        "isampler2d_vec4",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2d_vec4",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_UINT,
        Vertex,
    ),
    cs(
        "usampler2d_vec4",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "isampler2d_vec4_bias",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2d_vec4_bias",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_FIXED,
        Vertex,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_INT,
        Vertex,
    ),
    cs(
        "isampler3d",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler3d",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_UINT,
        Vertex,
    ),
    cs(
        "usampler3d",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler3d_bias_fixed",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            true,
            -2.0,
            1.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler3d_bias_float",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            true,
            -2.0,
            1.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d_bias",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler3d_bias",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            TextureProj,
            COORD_PROJ4_SHADOW_MIN,
            COORD_PROJ4_SHADOW_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            TextureProj,
            COORD_PROJ4_SHADOW_MIN,
            COORD_PROJ4_SHADOW_MAX,
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Fragment,
    ),
    cs(
        "sampler2dshadow_bias",
        lookup(
            TextureProj,
            COORD_PROJ4_SHADOW_MIN,
            COORD_PROJ4_SHADOW_MAX,
            true,
            -2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Fragment,
    ),
];

const TEXTURE_PROJ_OFFSET_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_vec3_fixed",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_FIXED,
        Vertex,
    ),
    cs(
        "sampler2d_vec3_fixed",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_vec3_float",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler2d_vec3_float",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "sampler2d_vec3_bias_fixed",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_vec3_bias_float",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            true,
            -2.0,
            2.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_FLOAT,
        Fragment,
    ),
    cs(
        "sampler2d_vec4_fixed",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_FIXED,
        Vertex,
    ),
    cs(
        "sampler2d_vec4_fixed",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_vec4_float",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler2d_vec4_float",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "sampler2d_vec4_bias_fixed",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_FIXED,
        Fragment,
    ),
    cs(
        "sampler2d_vec4_bias_float",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            true,
            -2.0,
            2.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_FLOAT,
        Fragment,
    ),
    cs(
        "isampler2d_vec3",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_INT,
        Vertex,
    ),
    cs(
        "isampler2d_vec3",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2d_vec3",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_UINT,
        Vertex,
    ),
    cs(
        "usampler2d_vec3",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "isampler2d_vec3_bias",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_INT,
        Fragment,
    ),
    cs(
        "usampler2d_vec3_bias",
        lookup(
            TextureProj3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            true,
            -2.0,
            2.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_UINT,
        Fragment,
    ),
    cs(
        "isampler2d_vec4",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_INT,
        Vertex,
    ),
    cs(
        "isampler2d_vec4",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler2d_vec4",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_UINT,
        Vertex,
    ),
    cs(
        "usampler2d_vec4",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "isampler2d_vec4_bias",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_INT,
        Fragment,
    ),
    cs(
        "usampler2d_vec4_bias",
        lookup(
            TextureProj,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            true,
            -2.0,
            2.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_UINT,
        Fragment,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_FIXED,
        Vertex,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, 3, -8],
        ),
        TEX_3D_MIPMAP_FIXED,
        Fragment,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            true,
            [3, -8, 7],
        ),
        TEX_3D_FLOAT,
        Vertex,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, 3, -8],
        ),
        TEX_3D_INT,
        Vertex,
    ),
    cs(
        "isampler3d",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            true,
            [3, -8, 7],
        ),
        TEX_3D_MIPMAP_INT,
        Fragment,
    ),
    cs(
        "usampler3d",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_UINT,
        Vertex,
    ),
    cs(
        "usampler3d",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, 3, -8],
        ),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler3d_bias_fixed",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_FIXED,
        Fragment,
    ),
    cs(
        "sampler3d_bias_float",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            true,
            -2.0,
            2.0,
            true,
            [7, 3, -8],
        ),
        TEX_3D_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d_bias",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            true,
            -2.0,
            2.0,
            true,
            [3, -8, 7],
        ),
        TEX_3D_INT,
        Fragment,
    ),
    cs(
        "usampler3d_bias",
        lookup(
            TextureProj,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_UINT,
        Fragment,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            TextureProj,
            COORD_PROJ4_SHADOW_MIN,
            COORD_PROJ4_SHADOW_MAX,
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            TextureProj,
            COORD_PROJ4_SHADOW_MIN,
            COORD_PROJ4_SHADOW_MAX,
            false,
            0.0,
            0.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Fragment,
    ),
    cs(
        "sampler2dshadow_bias",
        lookup(
            TextureProj,
            COORD_PROJ4_SHADOW_MIN,
            COORD_PROJ4_SHADOW_MAX,
            true,
            -2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_SHADOW,
        Fragment,
    ),
];

const TEXTURE_LOD_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_fixed",
        lookup(TextureLod, COORD_2D, COORD_2D_MAX, false, -1.0, 9.0, false, [0; 3]),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_float",
        lookup(TextureLod, COORD_2D, COORD_2D_MAX, false, -1.0, 9.0, false, [0; 3]),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "samplercube_fixed",
        lookup(
            TextureLod,
            COORD_CUBE_MIN,
            COORD_CUBE_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "samplercube_float",
        lookup(
            TextureLod,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2d",
        lookup(TextureLod, COORD_2D, COORD_2D_MAX, false, -1.0, 9.0, false, [0; 3]),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d",
        lookup(TextureLod, COORD_2D, COORD_2D_MAX, false, -1.0, 9.0, false, [0; 3]),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "isamplercube",
        lookup(
            TextureLod,
            COORD_CUBE_MIN,
            COORD_CUBE_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_INT,
        Both,
    ),
    cs(
        "usamplercube",
        lookup(
            TextureLod,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler2darray_fixed",
        lookup(
            TextureLod,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            -1.0,
            8.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2darray_float",
        lookup(
            TextureLod,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            -1.0,
            8.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2darray",
        lookup(
            TextureLod,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            -1.0,
            8.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2darray",
        lookup(
            TextureLod,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            -1.0,
            8.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TextureLod,
            COORD_3D_MIN,
            COORD_3D_MAX,
            false,
            -1.0,
            7.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TextureLod,
            COORD_3D_MIN,
            COORD_3D_MAX,
            false,
            -1.0,
            7.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler3d",
        lookup(
            TextureLod,
            COORD_3D_MIN,
            COORD_3D_MAX,
            false,
            -1.0,
            7.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler3d",
        lookup(
            TextureLod,
            COORD_3D_MIN,
            COORD_3D_MAX,
            false,
            -1.0,
            7.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            TextureLod,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Both,
    ),
];

const TEXTURE_LOD_OFFSET_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_fixed",
        lookup(TextureLod, COORD_2D, COORD_2D_MAX, false, -1.0, 9.0, true, [-8, 7, 0]),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_float",
        lookup(TextureLod, COORD_2D, COORD_2D_MAX, false, -1.0, 9.0, true, [7, -8, 0]),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2d",
        lookup(TextureLod, COORD_2D, COORD_2D_MAX, false, -1.0, 9.0, true, [-8, 7, 0]),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d",
        lookup(TextureLod, COORD_2D, COORD_2D_MAX, false, -1.0, 9.0, true, [7, -8, 0]),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler2darray_fixed",
        lookup(
            TextureLod,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            -1.0,
            8.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2darray_float",
        lookup(
            TextureLod,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            -1.0,
            8.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2darray",
        lookup(
            TextureLod,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            -1.0,
            8.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2darray",
        lookup(
            TextureLod,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            false,
            -1.0,
            8.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TextureLod,
            COORD_3D_MIN,
            COORD_3D_MAX,
            false,
            -1.0,
            7.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TextureLod,
            COORD_3D_MIN,
            COORD_3D_MAX,
            false,
            -1.0,
            7.0,
            true,
            [7, 3, -8],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler3d",
        lookup(
            TextureLod,
            COORD_3D_MIN,
            COORD_3D_MAX,
            false,
            -1.0,
            7.0,
            true,
            [3, -8, 7],
        ),
        TEX_3D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler3d",
        lookup(
            TextureLod,
            COORD_3D_MIN,
            COORD_3D_MAX,
            false,
            -1.0,
            7.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            TextureLod,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            false,
            -1.0,
            9.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Both,
    ),
];

const TEXTURE_PROJ_LOD_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_vec3_fixed",
        lookup(
            TextureProjLod3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_vec3_float",
        lookup(
            TextureProjLod3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "sampler2d_vec4_fixed",
        lookup(
            TextureProjLod,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_vec4_float",
        lookup(
            TextureProjLod,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2d_vec3",
        lookup(
            TextureProjLod3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d_vec3",
        lookup(
            TextureProjLod3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "isampler2d_vec4",
        lookup(
            TextureProjLod,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d_vec4",
        lookup(
            TextureProjLod,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TextureProjLod,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            -1.0,
            7.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TextureProjLod,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            -1.0,
            7.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler3d",
        lookup(
            TextureProjLod,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            -1.0,
            7.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler3d",
        lookup(
            TextureProjLod,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            -1.0,
            7.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            TextureProjLod,
            COORD_PROJ4_SHADOW_MIN,
            COORD_PROJ4_SHADOW_MAX,
            false,
            -1.0,
            9.0,
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Both,
    ),
];

const TEXTURE_PROJ_LOD_OFFSET_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_vec3_fixed",
        lookup(
            TextureProjLod3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            -1.0,
            9.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_vec3_float",
        lookup(
            TextureProjLod3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            -1.0,
            9.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "sampler2d_vec4_fixed",
        lookup(
            TextureProjLod,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            -1.0,
            9.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_vec4_float",
        lookup(
            TextureProjLod,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            -1.0,
            9.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2d_vec3",
        lookup(
            TextureProjLod3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            -1.0,
            9.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d_vec3",
        lookup(
            TextureProjLod3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            false,
            -1.0,
            9.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "isampler2d_vec4",
        lookup(
            TextureProjLod,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            -1.0,
            9.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d_vec4",
        lookup(
            TextureProjLod,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            false,
            -1.0,
            9.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TextureProjLod,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            -1.0,
            7.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TextureProjLod,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            -1.0,
            7.0,
            true,
            [7, 3, -8],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler3d",
        lookup(
            TextureProjLod,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            -1.0,
            7.0,
            true,
            [3, -8, 7],
        ),
        TEX_3D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler3d",
        lookup(
            TextureProjLod,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            false,
            -1.0,
            7.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler2dshadow",
        lookup(
            TextureProjLod,
            COORD_PROJ4_SHADOW_MIN,
            COORD_PROJ4_SHADOW_MAX,
            false,
            -1.0,
            9.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Both,
    ),
];

const TEXTURE_GRAD_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_fixed",
        grad_lookup(
            TextureGrad,
            COORD_2D,
            COORD_2D_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_float",
        grad_lookup(
            TextureGrad,
            COORD_2D,
            COORD_2D_MAX,
            [0.0; 3],
            [0.0, -0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "samplercube_fixed",
        grad_lookup(
            TextureGrad,
            COORD_CUBE_MIN,
            COORD_CUBE_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "samplercube_float",
        grad_lookup(
            TextureGrad,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            [0.0; 3],
            [0.0, -0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2d",
        grad_lookup(
            TextureGrad,
            COORD_2D,
            COORD_2D_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [-0.2, 0.0, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d",
        grad_lookup(
            TextureGrad,
            COORD_2D,
            COORD_2D_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, 0.2, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "isamplercube",
        grad_lookup(
            TextureGrad,
            COORD_CUBE_MIN,
            COORD_CUBE_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [-0.2, 0.0, 0.0],
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_INT,
        Both,
    ),
    cs(
        "usamplercube",
        grad_lookup(
            TextureGrad,
            COORD_CUBE_MIN_NEG,
            COORD_CUBE_MAX_NEG,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, 0.2, 0.0],
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler2darray_fixed",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2darray_float",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            [0.0; 3],
            [0.0, -0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2darray",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [-0.2, 0.0, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2darray",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, 0.2, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.2, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, -0.2, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Vertex,
    ),
    cs(
        "sampler3d_float",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.2],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [-0.2, 0.0, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler3d",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.2, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_UINT,
        Vertex,
    ),
    cs(
        "usampler3d",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, -0.2],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler2dshadow",
        grad_lookup(
            TextureGrad,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Both,
    ),
    cs(
        "samplercubeshadow",
        grad_lookup(
            TextureGrad,
            COORD_CUBE_SHADOW_MIN,
            COORD_CUBE_SHADOW_MAX,
            [0.0; 3],
            [0.0, 0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_CUBE_MIPMAP_SHADOW,
        Both,
    ),
    cs(
        "sampler2darrayshadow",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_SHADOW_MIN,
            COORD_2D_ARRAY_SHADOW_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.2, 0.0, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2darrayshadow",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_SHADOW_MIN,
            COORD_2D_ARRAY_SHADOW_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, -0.2, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Fragment,
    ),
];

const TEXTURE_GRAD_OFFSET_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_fixed",
        grad_lookup(
            TextureGrad,
            COORD_2D,
            COORD_2D_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_float",
        grad_lookup(
            TextureGrad,
            COORD_2D,
            COORD_2D_MAX,
            [0.0; 3],
            [0.0, -0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2d",
        grad_lookup(
            TextureGrad,
            COORD_2D,
            COORD_2D_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [-0.2, 0.0, 0.0],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d",
        grad_lookup(
            TextureGrad,
            COORD_2D,
            COORD_2D_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, 0.2, 0.0],
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler2darray_fixed",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2darray_float",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            [0.0; 3],
            [0.0, -0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2darray",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [-0.2, 0.0, 0.0],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2darray",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_MIN,
            COORD_2D_ARRAY_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, 0.2, 0.0],
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.2, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            true,
            [-8, 7, 3],
        ),
        TEX_3D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, -0.2, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            true,
            [7, 3, -8],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Vertex,
    ),
    cs(
        "sampler3d_float",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.2],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            true,
            [3, -8, 7],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [-0.2, 0.0, 0.0],
            true,
            [-8, 7, 3],
        ),
        TEX_3D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler3d",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.2, 0.0],
            true,
            [7, 3, -8],
        ),
        TEX_3D_MIPMAP_UINT,
        Vertex,
    ),
    cs(
        "usampler3d",
        grad_lookup(
            TextureGrad,
            COORD_3D_MIN,
            COORD_3D_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, -0.2],
            true,
            [3, -8, 7],
        ),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler2dshadow",
        grad_lookup(
            TextureGrad,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2dshadow",
        grad_lookup(
            TextureGrad,
            COORD_2D_SHADOW_MIN,
            COORD_2D_SHADOW_MAX,
            [0.0; 3],
            [0.0, 0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Fragment,
    ),
    cs(
        "sampler2darrayshadow",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_SHADOW_MIN,
            COORD_2D_ARRAY_SHADOW_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.2, 0.0, 0.0],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2darrayshadow",
        grad_lookup(
            TextureGrad,
            COORD_2D_ARRAY_SHADOW_MIN,
            COORD_2D_ARRAY_SHADOW_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, -0.2, 0.0],
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_MIPMAP_SHADOW,
        Fragment,
    ),
];

const TEXTURE_PROJ_GRAD_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_vec3_fixed",
        grad_lookup(
            TextureProjGrad3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_vec3_float",
        grad_lookup(
            TextureProjGrad3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            [0.0; 3],
            [0.0, -0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "sampler2d_vec4_fixed",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_vec4_float",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            [0.0; 3],
            [0.0, -0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2d_vec3",
        grad_lookup(
            TextureProjGrad3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [-0.2, 0.0, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d_vec3",
        grad_lookup(
            TextureProjGrad3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, 0.2, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "isampler2d_vec4",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [-0.2, 0.0, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d_vec4",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, 0.2, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.2, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, -0.2, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Vertex,
    ),
    cs(
        "sampler3d_float",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.2],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [-0.2, 0.0, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler3d",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.2, 0.0],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_UINT,
        Vertex,
    ),
    cs(
        "usampler3d",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, -0.2],
            false,
            [0, 0, 0],
        ),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler2dshadow",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJGRAD_SHADOW_MIN,
            COORD_PROJGRAD_SHADOW_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2dshadow",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJGRAD_SHADOW_MIN,
            COORD_PROJGRAD_SHADOW_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, -0.2, 0.0],
            false,
            [0; 3],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Fragment,
    ),
];

const TEXTURE_PROJ_GRAD_OFFSET_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_vec3_fixed",
        grad_lookup(
            TextureProjGrad3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_vec3_float",
        grad_lookup(
            TextureProjGrad3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            [0.0; 3],
            [0.0, -0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "sampler2d_vec4_fixed",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler2d_vec4_float",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            [0.0; 3],
            [0.0, -0.2, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_FLOAT,
        Both,
    ),
    cs(
        "isampler2d_vec3",
        grad_lookup(
            TextureProjGrad3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [-0.2, 0.0, 0.0],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d_vec3",
        grad_lookup(
            TextureProjGrad3,
            COORD_PROJ3_MIN,
            COORD_PROJ3_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, 0.2, 0.0],
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "isampler2d_vec4",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [-0.2, 0.0, 0.0],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler2d_vec4",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJ4_MIN,
            COORD_PROJ4_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, 0.2, 0.0],
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.2, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            true,
            [-8, 7, 3],
        ),
        TEX_3D_MIPMAP_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, -0.2, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            true,
            [7, 3, -8],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Vertex,
    ),
    cs(
        "sampler3d_float",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.2],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            true,
            [3, -8, 7],
        ),
        TEX_3D_MIPMAP_FLOAT,
        Fragment,
    ),
    cs(
        "isampler3d",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [-0.2, 0.0, 0.0],
            true,
            [-8, 7, 3],
        ),
        TEX_3D_MIPMAP_INT,
        Both,
    ),
    cs(
        "usampler3d",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.2, 0.0],
            true,
            [7, 3, -8],
        ),
        TEX_3D_MIPMAP_UINT,
        Vertex,
    ),
    cs(
        "usampler3d",
        grad_lookup(
            TextureProjGrad,
            COORD_3D_PROJ_MIN,
            COORD_3D_PROJ_MAX,
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0],
            [0.0, 0.0, -0.2],
            true,
            [3, -8, 7],
        ),
        TEX_3D_MIPMAP_UINT,
        Fragment,
    ),
    cs(
        "sampler2dshadow",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJGRAD_SHADOW_MIN,
            COORD_PROJGRAD_SHADOW_MAX,
            [0.0; 3],
            [0.2, 0.0, 0.0],
            [0.0; 3],
            [0.0; 3],
            true,
            [-8, 7, 0],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Vertex,
    ),
    cs(
        "sampler2dshadow",
        grad_lookup(
            TextureProjGrad,
            COORD_PROJGRAD_SHADOW_MIN,
            COORD_PROJGRAD_SHADOW_MAX,
            [0.0; 3],
            [0.0; 3],
            [0.0; 3],
            [0.0, -0.2, 0.0],
            true,
            [7, -8, 0],
        ),
        TEX_2D_MIPMAP_SHADOW,
        Fragment,
    ),
];

const TEXEL_FETCH_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_fixed",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [255.9, 255.9, 0.0, 0.0],
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_TEXELFETCH_FIXED,
        Both,
    ),
    cs(
        "sampler2d_float",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [127.9, 127.9, 0.0, 0.0],
            false,
            1.0,
            1.0,
            false,
            [0; 3],
        ),
        TEX_2D_TEXELFETCH_FLOAT,
        Both,
    ),
    cs(
        "isampler2d",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [63.9, 63.9, 0.0, 0.0],
            false,
            2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_TEXELFETCH_INT,
        Both,
    ),
    cs(
        "usampler2d",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [15.9, 15.9, 0.0, 0.0],
            false,
            4.0,
            4.0,
            false,
            [0; 3],
        ),
        TEX_2D_TEXELFETCH_UINT,
        Both,
    ),
    cs(
        "sampler2darray_fixed",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [127.9, 127.9, 3.9, 0.0],
            false,
            0.0,
            0.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_TEXELFETCH_FIXED,
        Both,
    ),
    cs(
        "sampler2darray_float",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [63.9, 63.9, 3.9, 0.0],
            false,
            1.0,
            1.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_TEXELFETCH_FLOAT,
        Both,
    ),
    cs(
        "isampler2darray",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [31.9, 31.9, 3.9, 0.0],
            false,
            2.0,
            2.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_TEXELFETCH_INT,
        Both,
    ),
    cs(
        "usampler2darray",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [15.9, 15.9, 3.9, 0.0],
            false,
            3.0,
            3.0,
            false,
            [0; 3],
        ),
        TEX_2D_ARRAY_TEXELFETCH_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [63.9, 31.9, 31.9, 0.0],
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_TEXELFETCH_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [31.9, 15.9, 15.9, 0.0],
            false,
            1.0,
            1.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_TEXELFETCH_FLOAT,
        Both,
    ),
    cs(
        "isampler3d",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [15.9, 7.9, 7.9, 0.0],
            false,
            2.0,
            2.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_TEXELFETCH_INT,
        Both,
    ),
    cs(
        "usampler3d",
        lookup(
            TexelFetch,
            [0.0, 0.0, 0.0, 0.0],
            [63.9, 31.9, 31.9, 0.0],
            false,
            0.0,
            0.0,
            false,
            [0, 0, 0],
        ),
        TEX_3D_TEXELFETCH_UINT,
        Both,
    ),
];

const TEXEL_FETCH_OFFSET_CASES: &[CaseSpec] = &[
    cs(
        "sampler2d_fixed",
        lookup(
            TexelFetch,
            [8.0, -7.0, 0.0, 0.0],
            [263.9, 248.9, 0.0, 0.0],
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_TEXELFETCH_FIXED,
        Both,
    ),
    cs(
        "sampler2d_float",
        lookup(
            TexelFetch,
            [-7.0, 8.0, 0.0, 0.0],
            [120.9, 135.9, 0.0, 0.0],
            false,
            1.0,
            1.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_TEXELFETCH_FLOAT,
        Both,
    ),
    cs(
        "isampler2d",
        lookup(
            TexelFetch,
            [8.0, -7.0, 0.0, 0.0],
            [71.9, 56.9, 0.0, 0.0],
            false,
            2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_TEXELFETCH_INT,
        Both,
    ),
    cs(
        "usampler2d",
        lookup(
            TexelFetch,
            [-7.0, 8.0, 0.0, 0.0],
            [8.9, 23.9, 0.0, 0.0],
            false,
            4.0,
            4.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_TEXELFETCH_UINT,
        Both,
    ),
    cs(
        "sampler2darray_fixed",
        lookup(
            TexelFetch,
            [8.0, -7.0, 0.0, 0.0],
            [135.9, 120.9, 3.9, 0.0],
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_TEXELFETCH_FIXED,
        Both,
    ),
    cs(
        "sampler2darray_float",
        lookup(
            TexelFetch,
            [-7.0, 8.0, 0.0, 0.0],
            [56.9, 71.9, 3.9, 0.0],
            false,
            1.0,
            1.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_TEXELFETCH_FLOAT,
        Both,
    ),
    cs(
        "isampler2darray",
        lookup(
            TexelFetch,
            [8.0, -7.0, 0.0, 0.0],
            [39.9, 24.9, 3.9, 0.0],
            false,
            2.0,
            2.0,
            true,
            [-8, 7, 0],
        ),
        TEX_2D_ARRAY_TEXELFETCH_INT,
        Both,
    ),
    cs(
        "usampler2darray",
        lookup(
            TexelFetch,
            [-7.0, 8.0, 0.0, 0.0],
            [8.9, 23.9, 3.9, 0.0],
            false,
            3.0,
            3.0,
            true,
            [7, -8, 0],
        ),
        TEX_2D_ARRAY_TEXELFETCH_UINT,
        Both,
    ),
    cs(
        "sampler3d_fixed",
        lookup(
            TexelFetch,
            [8.0, -7.0, -3.0, 0.0],
            [71.9, 24.9, 28.9, 0.0],
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_TEXELFETCH_FIXED,
        Both,
    ),
    cs(
        "sampler3d_float",
        lookup(
            TexelFetch,
            [-7.0, -3.0, 8.0, 0.0],
            [24.9, 12.9, 23.9, 0.0],
            false,
            1.0,
            1.0,
            true,
            [7, 3, -8],
        ),
        TEX_3D_TEXELFETCH_FLOAT,
        Both,
    ),
    cs(
        "isampler3d",
        lookup(
            TexelFetch,
            [-3.0, 8.0, -7.0, 0.0],
            [12.9, 15.9, 0.9, 0.0],
            false,
            2.0,
            2.0,
            true,
            [3, -8, 7],
        ),
        TEX_3D_TEXELFETCH_INT,
        Both,
    ),
    cs(
        "usampler3d",
        lookup(
            TexelFetch,
            [8.0, -7.0, -3.0, 0.0],
            [71.9, 24.9, 28.9, 0.0],
            false,
            0.0,
            0.0,
            true,
            [-8, 7, 3],
        ),
        TEX_3D_TEXELFETCH_UINT,
        Both,
    ),
];

/// `fillWithGrid`, generalised over the depth slice a cube face's fill lands on (a 2D
/// texture always fills slice 0). Verbatim from the ES2 sibling.
fn fill_with_grid(
    access: &mut PixelBufferAccess<'_>,
    depth: u32,
    cell_size: u32,
    color_even: [f32; 4],
    color_odd: [f32; 4],
) {
    let [width, height, _] = access.size();
    for y in 0..height {
        for x in 0..width {
            let parity = ((x / cell_size) % 2) ^ ((y / cell_size) % 2);
            access.set_pixel(if parity != 0 { color_odd } else { color_even }, x, y, depth);
        }
    }
}

/// `fillWithGrid3D` - the genuinely 3D form `TEXTURETYPE_3D` needs (`fillWithGrid`
/// upstream dispatches to this whenever the access has depth > 1): the checkerboard
/// parity XORs all three axes rather than just the two `fill_with_grid` covers.
fn fill_with_grid_3d(access: &mut PixelBufferAccess<'_>, cell_size: u32, color_even: [f32; 4], color_odd: [f32; 4]) {
    let [width, height, depth] = access.size();
    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let parity = ((x / cell_size) % 2) ^ ((y / cell_size) % 2) ^ ((z / cell_size) % 2);
                access.set_pixel(if parity != 0 { color_odd } else { color_even }, x, y, z);
            }
        }
    }
}

/// `texCubeSwz` - which two of `(fA, fB)` land in each of a face's four channels.
fn cube_swizzle(face: CubeFace) -> [usize; 4] {
    match face {
        CubeFace::NegativeX => [0, 0, 1, 1],
        CubeFace::PositiveX => [1, 1, 0, 0],
        CubeFace::NegativeY => [0, 1, 0, 1],
        CubeFace::PositiveY => [1, 0, 1, 0],
        CubeFace::NegativeZ => [0, 1, 1, 0],
        CubeFace::PositiveZ => [1, 0, 0, 1],
    }
}

const CUBE_FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

/// `ShaderTextureFunctionCase::initTexture`'s mip-pyramid construction, generalised over
/// `TexFormat` (via `get_texture_format_info` rather than a hardcoded `[0,1]` range) and
/// over `is_auto_lod` (`initTexture`'s own `isAutoLod`): when the fragment stage is going
/// to let the driver pick its own LOD (`Texture`/`TextureProj`/`TextureProj3` with no
/// explicit LOD/grad), every level's colour pair is forced identical (`levelStep = 0`) so
/// which level the driver actually picked cannot matter to the comparison - only the cell
/// size still shrinks per level, exactly as upstream's `initTexture` does.
fn build_texture_levels(tex: TextureSpec, is_auto_lod: bool) -> Vec<TextureLevel> {
    let format = TextureFormat::new(tex.format.channel_order(), tex.format.channel_type());
    let info = get_texture_format_info(format);
    let c_scale: [f32; 4] = std::array::from_fn(|i| info.value_max[i] - info.value_min[i]);
    let c_bias = info.value_min;
    // `TEXTURETYPE_3D`'s own `initTexture` halves rather than quarters, and folds depth
    // into the same `min` chain - a volumetric cell shrinks on all three axes.
    let base_cell_size = match tex.kind {
        TexKind::Tex3D => (tex.width / 2).min(tex.height / 2).min(tex.depth / 2),
        TexKind::Tex2D | TexKind::Cube | TexKind::Array2D => (tex.width / 4).min(tex.height / 4),
    };
    let level_step = if is_auto_lod {
        0.0
    } else {
        1.0 / (tex.num_levels - 1).max(1) as f32
    };

    (0..tex.num_levels)
        .map(|level| {
            let f_a = level as f32 * level_step;
            let f_b = 1.0 - f_a;
            let w_at_level = (tex.width >> level).max(1);
            let h_at_level = (tex.height >> level).max(1);
            let cell_size = (base_cell_size >> level).max(1);

            let depth = match tex.kind {
                TexKind::Cube => 6,
                TexKind::Array2D => tex.layers,
                // Unlike `Array2D`'s constant layer count, a 3D texture's own depth
                // shrinks per level exactly like its width/height.
                TexKind::Tex3D => (tex.depth >> level).max(1),
                TexKind::Tex2D => 1,
            };
            let mut tex_level = TextureLevel::new(format, w_at_level, h_at_level, depth)
                .expect("texture_functions: RGBA8/RGBA16F are always writable, sized formats");

            match tex.kind {
                TexKind::Tex2D => {
                    let color_a: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * [f_a, f_b, f_a, f_b][c]);
                    let color_b: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * [f_b, f_a, f_b, f_a][c]);
                    fill_with_grid(&mut tex_level.get_access(), 0, cell_size, color_a, color_b);
                }
                TexKind::Cube => {
                    for face in CUBE_FACES {
                        let swz = cube_swizzle(face);
                        let f = [f_a, f_b];
                        let color_a: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * f[swz[c]]);
                        let color_b: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * f[1 - swz[c]]);
                        let slice = get_cube_array_face_index(face);
                        fill_with_grid(&mut tex_level.get_access(), slice, cell_size, color_a, color_b);
                    }
                }
                // `TEXTURETYPE_2D_ARRAY`'s own `initTexture`: unlike `Tex2D`/`Cube`, the
                // per-layer colour pair carries an *additional* `layerStep` term
                // (`layerStep = 1/depth`) on top of the per-level one - each layer inside a
                // level gets its own point along the same [0,1] gradient the level axis
                // uses, so `layerStep`/`levelStep` are scaled to interleave rather than
                // reusing the outer `f_a`/`f_b` computed above.
                TexKind::Array2D => {
                    let layer_step = 1.0 / tex.layers.max(1) as f32;
                    let array_level_step = if is_auto_lod {
                        0.0
                    } else {
                        1.0 / ((tex.num_levels - 1).max(1) * tex.layers.max(1)) as f32
                    };
                    for layer in 0..tex.layers {
                        let fa = layer as f32 * layer_step + level as f32 * array_level_step;
                        let fb = 1.0 - fa;
                        let color_a: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * [fa, fb, fa, fb][c]);
                        let color_b: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * [fb, fa, fb, fa][c]);
                        fill_with_grid(&mut tex_level.get_access(), layer, cell_size, color_a, color_b);
                    }
                }
                // `TEXTURETYPE_3D`'s own `initTexture` reuses the same per-level `f_a`/`f_b`
                // `Tex2D` does (no `layerStep`-style term - the whole level shares one colour
                // pair), but fills through `fillWithGrid3D` (all three axes XORed) rather
                // than the 2D form.
                TexKind::Tex3D => {
                    let color_a: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * [f_a, f_b, f_a, f_b][c]);
                    let color_b: [f32; 4] = std::array::from_fn(|c| c_bias[c] + c_scale[c] * [f_b, f_a, f_b, f_a][c]);
                    fill_with_grid_3d(&mut tex_level.get_access(), cell_size, color_a, color_b);
                }
            }

            tex_level
        })
        .collect()
}

/// Uploads `levels` into a fresh GL texture object, one `glTexImage2D` per level (and per
/// cube face) - never `glGenerateMipmap`, for the same reason the ES2 sibling gives: it
/// would box-filter a continuous gradient rather than reproduce this test's own hand-built
/// checkerboard pyramid.
fn upload_texture(gl: &glw::Functions, tex: TextureSpec, levels: &[TextureLevel]) -> GLuint {
    let target = match tex.kind {
        TexKind::Tex2D => glw::GL_TEXTURE_2D,
        TexKind::Cube => glw::GL_TEXTURE_CUBE_MAP,
        TexKind::Array2D => glw::GL_TEXTURE_2D_ARRAY,
        TexKind::Tex3D => glw::GL_TEXTURE_3D,
    };
    // `isampler`/`usampler` textures may only be `NEAREST`-filtered (GLES3 has no linear
    // filtering for an integer format), matching `is_texel_fetch`'s own always-NEAREST
    // treatment - both pick between the plain and `_MIPMAP_NEAREST` min filter purely off
    // whether the texture has more than one level. A shadow texture is `NEAREST`-only too
    // (see `TexFormat::is_nearest_only`).
    let is_nearest = tex.is_texel_fetch || tex.format.is_nearest_only();
    let min_filter = if is_nearest {
        if tex.num_levels > 1 {
            glw::GL_NEAREST_MIPMAP_NEAREST
        } else {
            glw::GL_NEAREST
        }
    } else if tex.num_levels > 1 {
        glw::GL_LINEAR_MIPMAP_NEAREST
    } else {
        glw::GL_LINEAR
    };
    let mag_filter = if is_nearest { glw::GL_NEAREST } else { glw::GL_LINEAR };
    let format = TextureFormat::new(tex.format.channel_order(), tex.format.channel_type());
    let bytes_per_pixel = format.pixel_size().expect("every TexFormat here is a sized format") as usize;

    let mut texture: GLuint = 0;
    // SAFETY: one object is asked for and one `GLuint` of output is given; every call
    // below targets that same, just-bound object.
    unsafe {
        gl.gen_textures(1, &mut texture);
        gl.bind_texture(target, texture);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, min_filter as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, mag_filter as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as GLint);
        gl.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as GLint);

        if tex.format.is_shadow() {
            // `samplerShadowNoMipmap`/`samplerShadowMipmap`'s own `COMPAREMODE_LESS` - the
            // only compare mode any shadow `TextureSpec` in this file ever uses (see
            // `evaluate`'s own hardcoded `execCompare` equivalent).
            gl.tex_parameteri(
                target,
                glw::GL_TEXTURE_COMPARE_MODE,
                glw::GL_COMPARE_REF_TO_TEXTURE as GLint,
            );
            gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as GLint);
        }

        for (level_ndx, level) in levels.iter().enumerate() {
            let [w, h, d] = level.size();
            let data = level.data();
            let face_bytes = w as usize * h as usize * bytes_per_pixel;

            match tex.kind {
                TexKind::Tex2D => {
                    gl.tex_image_2d(
                        glw::GL_TEXTURE_2D,
                        level_ndx as GLint,
                        tex.format.gl_internal_format(),
                        w as GLint,
                        h as GLint,
                        0,
                        tex.format.gl_format(),
                        tex.format.gl_type(),
                        data.as_ptr().cast(),
                    );
                }
                TexKind::Cube => {
                    for face_ndx in 0..6usize {
                        let face_data = &data[face_ndx * face_bytes..(face_ndx + 1) * face_bytes];
                        gl.tex_image_2d(
                            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X + face_ndx as u32,
                            level_ndx as GLint,
                            tex.format.gl_internal_format(),
                            w as GLint,
                            h as GLint,
                            0,
                            tex.format.gl_format(),
                            tex.format.gl_type(),
                            face_data.as_ptr().cast(),
                        );
                    }
                }
                // One `glTexImage3D` call per level uploads every layer at once - `data`
                // is already the whole level's contiguous depth-major buffer (confirmed by
                // the `Cube` branch's own per-face slicing above using the same layout).
                TexKind::Array2D => {
                    gl.tex_image_3d(
                        glw::GL_TEXTURE_2D_ARRAY,
                        level_ndx as GLint,
                        tex.format.gl_internal_format(),
                        w as GLint,
                        h as GLint,
                        tex.layers as GLint,
                        0,
                        tex.format.gl_format(),
                        tex.format.gl_type(),
                        data.as_ptr().cast(),
                    );
                }
                // Same shape as `Array2D` above, but the depth comes from this level's own
                // stored size (`d`) rather than a texture-wide constant - a 3D texture's
                // depth shrinks per level exactly like its width/height.
                TexKind::Tex3D => {
                    gl.tex_image_3d(
                        glw::GL_TEXTURE_3D,
                        level_ndx as GLint,
                        tex.format.gl_internal_format(),
                        w as GLint,
                        h as GLint,
                        d as GLint,
                        0,
                        tex.format.gl_format(),
                        tex.format.gl_type(),
                        data.as_ptr().cast(),
                    );
                }
            }
        }

        gl.bind_texture(target, 0);
    }

    texture
}

/// `computeLodFromDerivates(LODMODE_EXACT, dudx, dudy)` - the 1D/axis-aligned reduction
/// used whenever the non-grad, non-explicit-LOD path's derivative has no cross term
/// (`dvdx == dudy == 0`, true for every plain `texture()`/`textureProj()` case here).
fn compute_lod_exact(dudx: f32, dvdy: f32) -> f32 {
    dudx.abs().max(dvdy.abs()).log2()
}

/// `computeLodFromDerivates(LODMODE_EXACT, dudx, dvdx, dudy, dvdy)` - the general 2D form
/// `computeLodFromGrad2D`/`computeLodFromGradCube` need, since a grad-based lookup's two
/// screen-space derivative vectors are arbitrary rather than axis-aligned.
fn compute_lod_exact4(dudx: f32, dvdx: f32, dudy: f32, dvdy: f32) -> f32 {
    (dudx * dudx + dvdx * dvdx)
        .sqrt()
        .max((dudy * dudy + dvdy * dvdy).sqrt())
        .log2()
}

/// `computeLodFromDerivates(LODMODE_EXACT, dudx, dvdx, dwdx, dudy, dvdy, dwdy)` - the 3D
/// form `computeLodFromGrad3D` and `TEXTURETYPE_3D`'s own `initTexture` LOD computation
/// both need, with a third (`w`) axis folded into each of the two per-screen-derivative
/// vectors.
fn compute_lod_exact6(dudx: f32, dvdx: f32, dwdx: f32, dudy: f32, dvdy: f32, dwdy: f32) -> f32 {
    (dudx * dudx + dvdx * dvdx + dwdx * dwdx)
        .sqrt()
        .max((dudy * dudy + dvdy * dvdy + dwdy * dwdy).sqrt())
        .log2()
}

/// `ShaderTextureFunctionCase::initTexture`'s two `computeLodFromDerivates` call sites
/// (2D and cube), used for every non-grad case regardless of whether the result is
/// actually read (`has_lod()` cases ignore it, matching upstream computing it
/// unconditionally too).
fn compute_base_lod(lookup: &LookupSpec, tex: TextureSpec, viewport: (f32, f32)) -> f32 {
    let use_proj = lookup.function.has_proj() && !lookup.function.has_grad() && !lookup.function.has_lod();
    let proj = if use_proj {
        let divisor = if lookup.function.is_proj3() {
            lookup.min_coord[2]
        } else {
            lookup.min_coord[3]
        };
        1.0 / divisor
    } else {
        1.0
    };

    match tex.kind {
        // `TEXTURETYPE_2D_ARRAY`'s own branch upstream computes `dudx`/`dvdy` identically
        // to `TEXTURETYPE_2D` (the layer axis never enters the LOD calculation), so it
        // folds into the same arm rather than repeating the formula.
        TexKind::Tex2D | TexKind::Array2D => {
            let dudx = (lookup.max_coord[0] - lookup.min_coord[0]) * proj * tex.width as f32 / viewport.0;
            let dvdy = (lookup.max_coord[1] - lookup.min_coord[1]) * proj * tex.height as f32 / viewport.1;
            compute_lod_exact(dudx, dvdy)
        }
        TexKind::Cube => {
            let scaled = |c: [f32; 4]| [c[0] * proj, c[1] * proj, c[2] * proj];
            let (_, c00) = get_cube_face_coords(scaled(lookup.min_coord));
            let (_, c10) = get_cube_face_coords(scaled([
                lookup.max_coord[0],
                lookup.min_coord[1],
                lookup.min_coord[2],
                0.0,
            ]));
            let (_, c01) = get_cube_face_coords(scaled([
                lookup.min_coord[0],
                lookup.max_coord[1],
                lookup.min_coord[2],
                0.0,
            ]));
            let dudx = (c10[0] - c00[0]) * tex.width as f32 / viewport.0;
            let dvdy = (c01[1] - c00[1]) * tex.height as f32 / viewport.1;
            compute_lod_exact(dudx, dvdy)
        }
        // `TEXTURETYPE_3D`'s own branch: a third (`w`) derivative term, halved and split
        // across both screen axes (`0.5 * proj * depth / viewport.{0,1}`), on top of the
        // plain 2D `dudx`/`dvdy` pair.
        TexKind::Tex3D => {
            let dudx = (lookup.max_coord[0] - lookup.min_coord[0]) * proj * tex.width as f32 / viewport.0;
            let dvdy = (lookup.max_coord[1] - lookup.min_coord[1]) * proj * tex.height as f32 / viewport.1;
            let dwdx = (lookup.max_coord[2] - lookup.min_coord[2]) * 0.5 * proj * tex.depth as f32 / viewport.0;
            let dwdy = (lookup.max_coord[2] - lookup.min_coord[2]) * 0.5 * proj * tex.depth as f32 / viewport.1;
            compute_lod_exact6(dudx, 0.0, dwdx, 0.0, dvdy, dwdy)
        }
    }
}

/// `computeLodFromGrad2D`/`computeLodFromGradCube`/`computeLodFromGrad2DArray` - the array
/// form upstream uses the exact same formula as the plain 2D one (width/height only, the
/// layer axis is never differentiated), so it shares the same arm.
fn compute_grad_lod(tex: TextureSpec, in0: Vec4, dx: Vec4, dy: Vec4) -> f32 {
    match tex.kind {
        TexKind::Tex2D | TexKind::Array2D => {
            let w = tex.width as f32;
            let h = tex.height as f32;
            compute_lod_exact4(dx.x() * w, dx.y() * h, dy.x() * w, dy.y() * h)
        }
        TexKind::Cube => {
            // \note Major axis is always -Z or +Z.
            let m = in0.z().abs();
            let s = tex.width as f32 / (2.0 * m);
            compute_lod_exact4(dx.x() * s, dx.y() * s, dy.x() * s, dy.y() * s)
        }
        // `computeLodFromGrad3D` - a genuine third (`w`/depth) axis on each grad vector,
        // unlike `Array2D` which folds into the plain 2D form above.
        TexKind::Tex3D => {
            let w = tex.width as f32;
            let h = tex.height as f32;
            let d = tex.depth as f32;
            compute_lod_exact6(dx.x() * w, dx.y() * h, dx.z() * d, dy.x() * w, dy.y() * h, dy.z() * d)
        }
    }
}

/// `s.x, 0, 0, b.x / 0, s.y, 0, b.y / ...` - `ShaderTextureFunctionCase::init`'s base
/// coordinate `m_userAttribTransforms` entry. Verbatim from the ES2 sibling.
fn coord_transform(min_coord: [f32; 4], max_coord: [f32; 4]) -> Mat4 {
    let s: [f32; 4] = std::array::from_fn(|i| max_coord[i] - min_coord[i]);
    let b = min_coord;

    let mut m = Mat4::zero();
    m.set(0, 0, s[0]);
    m.set(0, 3, b[0]);
    m.set(1, 1, s[1]);
    m.set(1, 3, b[1]);
    m.set(2, 0, s[2] / 2.0);
    m.set(2, 1, -s[2] / 2.0);
    m.set(2, 3, s[2] / 2.0 + b[2]);
    m.set(3, 0, -s[3] / 2.0);
    m.set(3, 1, s[3] / 2.0);
    m.set(3, 3, s[3] / 2.0 + b[3]);
    m
}

/// The `hasLodBias` transform (a_in1: explicit LOD or bias).
fn lod_transform(min_lod_bias: f32, max_lod_bias: f32) -> Mat4 {
    let mut m = Mat4::zero();
    let s = max_lod_bias - min_lod_bias;
    m.set(0, 0, s / 2.0);
    m.set(0, 1, s / 2.0);
    m.set(0, 3, min_lod_bias);
    m
}

/// The `isGrad` pair of transforms (a_in1/a_in2: `dFdx`/`dFdy`). Upstream's own
/// `gradDyTrans` biases off `maxDY`, not `minDY` (asymmetric with `gradDxTrans`'s `minDX`) -
/// transcribed as written, not "fixed"; every case in this file's scope has `minDY ==
/// maxDY == 0`, so the asymmetry has no observable effect here regardless.
fn grad_transforms(min_dx: [f32; 3], max_dx: [f32; 3], min_dy: [f32; 3], max_dy: [f32; 3]) -> (Mat4, Mat4) {
    let sx: [f32; 3] = std::array::from_fn(|i| max_dx[i] - min_dx[i]);
    let sy: [f32; 3] = std::array::from_fn(|i| max_dy[i] - min_dy[i]);

    let mut dx_trans = Mat4::zero();
    for row in 0..3 {
        dx_trans.set(row, 0, sx[row] / 2.0);
        dx_trans.set(row, 1, sx[row] / 2.0);
        dx_trans.set(row, 3, min_dx[row]);
    }

    let mut dy_trans = Mat4::zero();
    for row in 0..3 {
        dy_trans.set(row, 0, -sy[row] / 2.0);
        dy_trans.set(row, 1, -sy[row] / 2.0);
        dy_trans.set(row, 3, max_dy[row]);
    }

    (dx_trans, dy_trans)
}

/// `ShaderTextureFunctionCase`.
struct ShaderTextureFunctionCase {
    name: String,
    lookup: LookupSpec,
    tex: TextureSpec,
    is_vertex_case: bool,
    vert_src: String,
    frag_src: String,
    user_attrib_transforms: Vec<Mat4>,
    is_auto_lod: bool,
    /// Built on first use, as upstream's `init()` does: building every case's texture
    /// when the tree is constructed made listing dEQP-GLES3 take 23 s on a Cortex-A9.
    levels: OnceLock<Vec<TextureLevel>>,
    lod: OnceLock<f32>,
    gl_texture: OnceLock<GLuint>,
}

impl ShaderTextureFunctionCase {
    fn new(case: &CaseSpec, is_vertex_case: bool) -> Self {
        let lookup = case.lookup;
        let tex = case.tex;

        let mut user_attrib_transforms = vec![coord_transform(lookup.min_coord, lookup.max_coord)];
        let has_lod_bias = lookup.function.has_lod() || lookup.use_bias;
        if has_lod_bias {
            user_attrib_transforms.push(lod_transform(lookup.min_lod_bias, lookup.max_lod_bias));
        } else if lookup.function.has_grad() {
            let (dx, dy) = grad_transforms(lookup.min_dx, lookup.max_dx, lookup.min_dy, lookup.max_dy);
            user_attrib_transforms.push(dx);
            user_attrib_transforms.push(dy);
        }

        let (vert_src, frag_src) = build_shader_sources(lookup, tex.kind, tex.format, is_vertex_case);
        let is_auto_lod = lookup.function.has_auto_lod(is_vertex_case);

        Self {
            name: case.name.to_string(),
            lookup,
            tex,
            is_vertex_case,
            vert_src,
            frag_src,
            user_attrib_transforms,
            is_auto_lod,
            levels: OnceLock::new(),
            lod: OnceLock::new(),
            gl_texture: OnceLock::new(),
        }
    }

    fn levels(&self) -> &[TextureLevel] {
        self.levels
            .get_or_init(|| build_texture_levels(self.tex, self.is_auto_lod))
    }

    fn level_accesses(&self) -> Vec<ConstPixelBufferAccess<'_>> {
        self.levels().iter().map(TextureLevel::get_const_access).collect()
    }
}

impl ShaderRenderCaseSpec for ShaderTextureFunctionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        (&self.vert_src, &self.frag_src)
    }

    fn is_vertex_case(&self) -> bool {
        self.is_vertex_case
    }

    fn user_attrib_transforms(&self) -> Vec<Mat4> {
        self.user_attrib_transforms.clone()
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.is_vertex_case {
            let gl = context.gl();
            let mut units: GLint = 0;
            // SAFETY: `units` is a valid destination for one `GLint`.
            unsafe { gl.get_integerv(glw::GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS, &mut units) };
            if units < 1 {
                return Err(TestError::NotSupported(
                    "Vertex shader texture access is not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn setup_uniforms(&self, context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
        let gl = context.gl();

        self.lod.get_or_init(|| {
            let size = viewport_size(context);
            compute_base_lod(&self.lookup, self.tex, (size.x() as f32, size.y() as f32))
        });

        let texture = *self
            .gl_texture
            .get_or_init(|| upload_texture(gl, self.tex, self.levels()));
        let target = match self.tex.kind {
            TexKind::Tex2D => glw::GL_TEXTURE_2D,
            TexKind::Cube => glw::GL_TEXTURE_CUBE_MAP,
            TexKind::Array2D => glw::GL_TEXTURE_2D_ARRAY,
            TexKind::Tex3D => glw::GL_TEXTURE_3D,
        };

        let sampler_name = std::ffi::CString::new("u_sampler").expect("no interior NUL");
        let scale_name = std::ffi::CString::new("u_scale").expect("no interior NUL");
        let bias_name = std::ffi::CString::new("u_bias").expect("no interior NUL");
        let info = get_texture_format_info(TextureFormat::new(
            self.tex.format.channel_order(),
            self.tex.format.channel_type(),
        ));

        // SAFETY: NUL-terminated names and a program this case built; locations are
        // checked for `-1` before use, and `texture` is this case's own object for
        // `target`.
        unsafe {
            let sampler_loc = gl.get_uniform_location(program, sampler_name.as_ptr());
            let scale_loc = gl.get_uniform_location(program, scale_name.as_ptr());
            let bias_loc = gl.get_uniform_location(program, bias_name.as_ptr());

            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(target, texture);
            if sampler_loc != -1 {
                gl.uniform_1i(sampler_loc, 0);
            }
            if scale_loc != -1 {
                gl.uniform_4fv(scale_loc, 1, info.look_up_scale.as_ptr());
            }
            if bias_loc != -1 {
                gl.uniform_4fv(bias_loc, 1, info.look_up_bias.as_ptr());
            }
        }
        Ok(())
    }

    fn cleanup(&self, context: &Context) {
        if let Some(&texture) = self.gl_texture.get() {
            let gl = context.gl();
            // SAFETY: `texture` is this case's own, deleted at most once.
            unsafe { gl.delete_textures(1, &texture) };
        }
    }

    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        let function = self.lookup.function;
        let in0 = ctx.in_[0];
        let info = get_texture_format_info(TextureFormat::new(
            self.tex.format.channel_order(),
            self.tex.format.channel_type(),
        ));
        let apply_scale_bias = |color: [f32; 4]| -> Vec4 {
            Vec4::from_array(std::array::from_fn(|c| {
                color[c] * info.look_up_scale[c] + info.look_up_bias[c]
            }))
        };

        if function == Function::TexelFetch {
            let levels = self.level_accesses();
            let lod = ctx.in_[1].x() as i32;
            let x = in0.x() as i32 + self.lookup.offset[0];
            let y = in0.y() as i32 + self.lookup.offset[1];
            // `evalTexelFetch2DArray` reads the layer straight off `in[0].z()`, truncated
            // like `x`/`y` but with no offset added - `texelFetchOffset`'s `ivec2 offset`
            // only ever covers the `x`/`y` axes for a `sampler2DArray`. `evalTexelFetch3D`
            // differs: its third axis is a genuine spatial coordinate, so the offset's own
            // `z` component does apply there.
            let color = match self.tex.kind {
                TexKind::Array2D => texel_fetch_2d_array(&levels, lod, x, y, in0.z() as i32),
                TexKind::Tex3D => {
                    let z = in0.z() as i32 + self.lookup.offset[2];
                    texel_fetch_3d(&levels, lod, x, y, z)
                }
                TexKind::Tex2D | TexKind::Cube => texel_fetch_2d(&levels, lod, x, y),
            };
            ctx.color = apply_scale_bias(color);
            return;
        }

        let (s, t) = if function.has_proj() {
            let divisor = if function.is_proj3() { in0.z() } else { in0.w() };
            (in0.x() / divisor, in0.y() / divisor)
        } else {
            (in0.x(), in0.y())
        };
        // The third coordinate: a plain direction/layer index for `Cube`/`Array2D`, but for
        // `Tex3D` a projective lookup divides it by the same `w` divisor `s`/`t` use above
        // (`sampler3D` never has a `Proj3` form, so the divisor is always `in0.w()`).
        let r = if self.tex.kind == TexKind::Tex3D && function.has_proj() {
            in0.z() / in0.w()
        } else {
            in0.z()
        };

        let lod_base = self.lod.get().copied().unwrap_or(0.0);
        let lod = if function.has_grad() {
            compute_grad_lod(self.tex, in0, ctx.in_[1], ctx.in_[2])
        } else if function.has_lod() {
            ctx.in_[1].x()
        } else if self.lookup.use_bias {
            lod_base + ctx.in_[1].x()
        } else {
            lod_base
        };

        let levels = self.level_accesses();
        // `isampler`/`usampler` textures are always `NEAREST`-filtered (GLES3 has no linear
        // filtering for an integer format); a shadow sampler is *always* `NEAREST` too, in
        // this file's scope - see `TexFormat::is_nearest_only`'s own doc comment for why
        // that is what lets a shadow lookup reuse these plain samplers unchanged (a
        // `NEAREST` filter is already a single unblended tap, so comparing that one tap's
        // value on top of the ordinary sample is the whole of what shadow sampling needs
        // here - no bilinear-PCF form is ever registered).
        let filter = if self.tex.format.is_nearest_only() {
            FilterMode::Nearest
        } else {
            FilterMode::Linear
        };
        let sampler = Sampler {
            wrap_s: WrapMode::Repeat,
            wrap_t: WrapMode::Repeat,
            wrap_r: WrapMode::Repeat,
            filter,
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        };

        let color = match self.tex.kind {
            TexKind::Tex2D => {
                if self.lookup.use_offset {
                    sample_2d_mipmap_offset(
                        &levels,
                        &sampler,
                        s,
                        t,
                        lod,
                        [self.lookup.offset[0], self.lookup.offset[1]],
                    )
                } else {
                    sample_2d_mipmap(&levels, &sampler, s, t, lod)
                }
            }
            TexKind::Cube => sample_cube_mipmap(&levels, &sampler, s, t, r, lod),
            TexKind::Array2D => {
                if self.lookup.use_offset {
                    sample_2d_array_mipmap_offset(
                        &levels,
                        &sampler,
                        s,
                        t,
                        r,
                        lod,
                        [self.lookup.offset[0], self.lookup.offset[1]],
                    )
                } else {
                    sample_2d_array_mipmap(&levels, &sampler, s, t, r, lod)
                }
            }
            TexKind::Tex3D => {
                if self.lookup.use_offset {
                    sample_3d_mipmap_offset(&levels, &sampler, s, t, r, lod, self.lookup.offset)
                } else {
                    sample_3d_mipmap(&levels, &sampler, s, t, r, lod)
                }
            }
        };

        if self.tex.format.is_shadow() {
            // `texture2DShadow`/`textureCubeShadow`/`texture2DArrayShadow` - the "ref"
            // (depth-compare) value is the coordinate component right after `r`/layer for
            // `Cube`/`Array2D` (`.w()`, since `.z()` is already taken), or right after `s`/`t`
            // for `Tex2D` (`.z()`, which nothing else reads there). A projective shadow
            // lookup divides it by the same `w` divisor `s`/`t` already used above - matching
            // `evalTexture2DShadowProj`'s own `c.in[0].z() / c.in[0].w()` - and only ever
            // occurs for `Tex2D` in this whole file (no `Cube`/`Array2D` shadow-proj form is
            // ever registered upstream), so the two conditions never overlap in practice.
            let ref_raw = if matches!(self.tex.kind, TexKind::Cube | TexKind::Array2D) {
                in0.w()
            } else {
                in0.z()
            };
            let ref_ = if function.has_proj() {
                ref_raw / in0.w()
            } else {
                ref_raw
            };
            // `execCompare` with `Sampler::COMPAREMODE_LESS` and a fixed-point depth format -
            // the only compare mode and the only depth channel type any shadow `TextureSpec`
            // in this whole file ever uses (`samplerShadowNoMipmap`/`samplerShadowMipmap`),
            // so both are hardcoded here rather than threaded through as parameters.
            let result = if ref_.clamp(0.0, 1.0) < color[0].clamp(0.0, 1.0) {
                1.0
            } else {
                0.0
            };
            ctx.color = Vec4::new(result, 0.0, 0.0, 1.0);
        } else {
            ctx.color = apply_scale_bias(color);
        }
    }
}

/// `ShaderTextureFunctionCase::initShaderSources`, restricted to the non-shadow,
/// float-sampler (`sampler2D`/`samplerCube`) shape this file's scope covers.
fn build_shader_sources(
    lookup: LookupSpec,
    tex_kind: TexKind,
    tex_format: TexFormat,
    is_vertex_case: bool,
) -> (String, String) {
    let function = lookup.function;
    let is_proj = function.has_proj();
    let is_grad = function.has_grad();
    let is_2d_proj4 = !tex_format.is_shadow()
        && tex_kind == TexKind::Tex2D
        && matches!(
            function,
            Function::TextureProj | Function::TextureProjLod | Function::TextureProjGrad
        );
    let is_int_coord = function == Function::TexelFetch;
    let has_lod_bias = function.has_lod() || lookup.use_bias;
    let tex_coord_comps = if tex_kind == TexKind::Tex2D { 2 } else { 3 };
    // `extraCoordComps` upstream: a projective divisor component, PLUS one more for a
    // shadow sampler's own "ref" (depth-compare) component - the two are independent and
    // additive, though this file's shadow scope (see `TexFormat::Shadow`'s own doc
    // comment) never combines them (no `Proj` function is registered for any shadow case).
    let extra_coord_comps =
        (if is_proj { if is_2d_proj4 { 2 } else { 1 } } else { 0 }) + usize::from(tex_format.is_shadow());
    let coord_comps = tex_coord_comps + extra_coord_comps;
    let coord_type = format!("vec{coord_comps}");
    // `gradType` upstream: `vec3` only for `CUBE_MAP`/`3D` (a cube's/volume's direction
    // derivative genuinely has 3 components) - `2D_ARRAY` stays `vec2` like plain `2D`,
    // since the array-layer axis is never differentiated (`computeLodFromGrad2DArray`
    // reads only `.x()`/`.y()` off each grad vector).
    let grad_type = if matches!(tex_kind, TexKind::Cube | TexKind::Tex3D) {
        "vec3"
    } else {
        "vec2"
    };
    // `getSampler2DType`/`getSamplerCubeType` - the GLSL sampler keyword depends on the
    // texture's channel class, not just its dimensionality: `isampler*`/`usampler*` for
    // the two integer formats, plain `sampler*` for `Fixed`/`Float`, and a wholly separate
    // `*Shadow` keyword (never prefixed) for a shadow sampler regardless of `tex_format`'s
    // own (unread, in that case) `Fixed` placeholder value - see `TEX_2D_SHADOW` etc.'s own
    // `tex_spec(..., TexFormat::Shadow, ...)` construction.
    let sampler_prefix = match tex_format {
        TexFormat::Fixed | TexFormat::Float | TexFormat::Shadow => "",
        TexFormat::Int => "i",
        TexFormat::Uint => "u",
    };
    let sampler_type = match (tex_kind, tex_format.is_shadow()) {
        (TexKind::Tex2D, false) => format!("{sampler_prefix}sampler2D"),
        (TexKind::Tex2D, true) => "sampler2DShadow".to_string(),
        (TexKind::Cube, false) => format!("{sampler_prefix}samplerCube"),
        (TexKind::Cube, true) => "samplerCubeShadow".to_string(),
        (TexKind::Array2D, false) => format!("{sampler_prefix}sampler2DArray"),
        (TexKind::Array2D, true) => "sampler2DArrayShadow".to_string(),
        (TexKind::Tex3D, _) => format!("{sampler_prefix}sampler3D"),
    };
    let base_func_name = function.glsl_base_name();

    let mut vert = String::new();
    let mut frag = String::new();

    vert.push_str("#version 300 es\n");
    vert.push_str("in highp vec4 a_position;\n");
    vert.push_str(&format!("in highp {coord_type} a_in0;\n"));
    if is_grad {
        vert.push_str(&format!("in highp {grad_type} a_in1;\n"));
        vert.push_str(&format!("in highp {grad_type} a_in2;\n"));
    } else if has_lod_bias {
        vert.push_str("in highp float a_in1;\n");
    }

    frag.push_str("#version 300 es\n");
    frag.push_str("layout(location = 0) out mediump vec4 o_color;\n");

    if is_vertex_case {
        vert.push_str("out mediump vec4 v_color;\n");
        frag.push_str("in mediump vec4 v_color;\n");
    } else {
        vert.push_str(&format!("out highp {coord_type} v_texCoord;\n"));
        frag.push_str(&format!("in highp {coord_type} v_texCoord;\n"));
        if is_grad {
            vert.push_str(&format!("out highp {grad_type} v_gradX;\n"));
            vert.push_str(&format!("out highp {grad_type} v_gradY;\n"));
            frag.push_str(&format!("in highp {grad_type} v_gradX;\n"));
            frag.push_str(&format!("in highp {grad_type} v_gradY;\n"));
        }
        if has_lod_bias {
            vert.push_str("out highp float v_lodBias;\n");
            frag.push_str("in highp float v_lodBias;\n");
        }
    }

    // Uniforms - into whichever stage does the lookup.
    let uniform_decls =
        format!("uniform highp {sampler_type} u_sampler;\nuniform highp vec4 u_scale;\nuniform highp vec4 u_bias;\n");
    if is_vertex_case {
        vert.push_str(&uniform_decls);
    } else {
        frag.push_str(&uniform_decls);
    }

    vert.push_str("\nvoid main()\n{\n\tgl_Position = a_position;\n");
    frag.push_str("\nvoid main()\n{\n");

    let tex_coord = if is_vertex_case { "a_in0" } else { "v_texCoord" };
    let grad_x = if is_vertex_case { "a_in1" } else { "v_gradX" };
    let grad_y = if is_vertex_case { "a_in2" } else { "v_gradY" };
    let lod_bias = if is_vertex_case { "a_in1" } else { "v_lodBias" };

    let mut op = format!("vec4({base_func_name}");
    if lookup.use_offset {
        op.push_str("Offset");
    }
    op.push_str("(u_sampler, ");
    if is_int_coord {
        op.push_str(&format!("ivec{coord_comps}("));
    }
    op.push_str(tex_coord);
    if is_int_coord {
        op.push(')');
    }
    if is_grad {
        op.push_str(&format!(", {grad_x}, {grad_y}"));
    }
    if function.has_lod() {
        if is_int_coord {
            op.push_str(&format!(", int({lod_bias})"));
        } else {
            op.push_str(&format!(", {lod_bias}"));
        }
    }
    if lookup.use_offset {
        // `m_textureSpec.type == TEXTURETYPE_3D ? 3 : 2` - every other kind's offset is
        // 2-component (`sampler2DArray`'s own offset never touches the layer axis).
        if tex_kind == TexKind::Tex3D {
            op.push_str(&format!(
                ", ivec3({}, {}, {})",
                lookup.offset[0], lookup.offset[1], lookup.offset[2]
            ));
        } else {
            op.push_str(&format!(", ivec2({}, {})", lookup.offset[0], lookup.offset[1]));
        }
    }
    if lookup.use_bias {
        op.push_str(&format!(", {lod_bias}"));
    }
    op.push(')'); // closes the lookup function call
    if tex_format.is_shadow() {
        // A shadow lookup already returns a plain `float` (the compare result), so the
        // outer `vec4(...)` just pads it with the same fixed `(0,0,1)` GBA upstream uses -
        // no `u_scale`/`u_bias` at all, matching `evaluate`'s own host-side construction.
        op.push_str(", 0.0, 0.0, 1.0);\n");
    } else {
        op.push_str(")*u_scale + u_bias;\n"); // closes vec4(...)
    }

    if is_vertex_case {
        vert.push_str("\tv_color = ");
        vert.push_str(&op);
        frag.push_str("\to_color = v_color;\n");
    } else {
        frag.push_str("\to_color = ");
        frag.push_str(&op);
        vert.push_str("\tv_texCoord = a_in0;\n");
        if is_grad {
            vert.push_str("\tv_gradX = a_in1;\n");
            vert.push_str("\tv_gradY = a_in2;\n");
        } else if has_lod_bias {
            vert.push_str("\tv_lodBias = a_in1;\n");
        }
    }

    vert.push_str("}\n");
    frag.push_str("}\n");

    (vert, frag)
}

/// `createCaseGroup`.
fn create_case_group(parent: &mut TestCaseGroup, group_name: &str, cases: &[CaseSpec]) {
    let mut group = TestCaseGroup::new(group_name);
    for case in cases {
        if matches!(case.flags, Flags::Vertex | Flags::Both) {
            let name = format!("{}_vertex", case.name);
            let mut inner = ShaderTextureFunctionCase::new(case, true);
            inner.name = name;
            group.add_child(Box::new(ShaderRenderCase::new(inner)) as Box<dyn TestCase>);
        }
        if matches!(case.flags, Flags::Fragment | Flags::Both) {
            let name = format!("{}_fragment", case.name);
            let mut inner = ShaderTextureFunctionCase::new(case, false);
            inner.name = name;
            group.add_child(Box::new(ShaderRenderCase::new(inner)) as Box<dyn TestCase>);
        }
    }
    parent.add_child(group);
}

// ---------------------------------------------------------------------------------------
// textureSize() tests (`TextureSizeCase`)
//
// A wholly separate `TestCase`, not `ShaderTextureFunctionCase`/`ShaderRenderCase`-driven at
// all - it never reads a texel, only compares GLSL's own `textureSize(sampler, lod)` against
// the size the host asked `glTexStorage{2,3}D` for, so it needs none of this file's
// pixel-value/mipmap-fill machinery. This is also why its three `*shadow` entries
// (`sampler2DShadow`/`samplerCubeShadow`/`sampler2DArrayShadow`) are in scope even though
// shadow-comparison *sampling* (an actual `texture()`/`textureProj()` call against one of
// these types) is still not ported anywhere else in this file: a shadow sampler still needs
// a legal depth texture with `GL_TEXTURE_COMPARE_MODE` set to be used as one at all, but
// `textureSize()` never samples it, so the missing `sampleCompare`-equivalent this file's own
// header still tracks is simply never reached by these three cases.
// ---------------------------------------------------------------------------------------

/// `TextureSizeCase::TestSize` - transcribed verbatim off the fixed 34-entry table
/// `TextureSizeCase::iterate` builds locally upstream (same values used for every one of the
/// 19 sampler-type/format cases below - the `TexKind` in scope only changes how `size`/
/// `expected`'s components are interpreted, never which values are tried).
struct TextureSizeTestSize {
    size: [i32; 3],
    lod: i32,
    lod_base: i32,
    expected: [i32; 3],
}

const fn ts(size: [i32; 3], lod: i32, lod_base: i32, expected: [i32; 3]) -> TextureSizeTestSize {
    TextureSizeTestSize {
        size,
        lod,
        lod_base,
        expected,
    }
}

const TEXTURE_SIZE_TEST_SIZES: &[TextureSizeTestSize] = &[
    ts([1, 2, 1], 1, 0, [1, 1, 1]),
    ts([1, 2, 1], 0, 0, [1, 2, 1]),
    ts([1, 3, 2], 0, 0, [1, 3, 2]),
    ts([1, 3, 2], 1, 0, [1, 1, 1]),
    ts([100, 31, 18], 0, 0, [100, 31, 18]),
    ts([100, 31, 18], 1, 0, [50, 15, 9]),
    ts([100, 31, 18], 2, 0, [25, 7, 4]),
    ts([100, 31, 18], 3, 0, [12, 3, 2]),
    ts([100, 31, 18], 4, 0, [6, 1, 1]),
    ts([100, 31, 18], 5, 0, [3, 1, 1]),
    ts([100, 31, 18], 6, 0, [1, 1, 1]),
    ts([100, 128, 32], 0, 0, [100, 128, 32]),
    ts([100, 128, 32], 1, 0, [50, 64, 16]),
    ts([100, 128, 32], 2, 0, [25, 32, 8]),
    ts([100, 128, 32], 3, 0, [12, 16, 4]),
    ts([100, 128, 32], 4, 0, [6, 8, 2]),
    ts([100, 128, 32], 5, 0, [3, 4, 1]),
    ts([100, 128, 32], 6, 0, [1, 2, 1]),
    ts([100, 128, 32], 7, 0, [1, 1, 1]),
    // pow 2
    ts([128, 64, 32], 0, 0, [128, 64, 32]),
    ts([128, 64, 32], 1, 0, [64, 32, 16]),
    ts([128, 64, 32], 2, 0, [32, 16, 8]),
    ts([128, 64, 32], 3, 0, [16, 8, 4]),
    ts([128, 64, 32], 4, 0, [8, 4, 2]),
    ts([128, 64, 32], 5, 0, [4, 2, 1]),
    ts([128, 64, 32], 6, 0, [2, 1, 1]),
    ts([128, 64, 32], 7, 0, [1, 1, 1]),
    // w == h
    ts([1, 1, 1], 0, 0, [1, 1, 1]),
    ts([64, 64, 64], 0, 0, [64, 64, 64]),
    ts([64, 64, 64], 1, 0, [32, 32, 32]),
    ts([64, 64, 64], 2, 0, [16, 16, 16]),
    ts([64, 64, 64], 3, 0, [8, 8, 8]),
    ts([64, 64, 64], 4, 0, [4, 4, 4]),
    // with lod base
    ts([100, 31, 18], 3, 1, [6, 1, 1]),
    ts([128, 64, 32], 3, 1, [8, 4, 2]),
    ts([64, 64, 64], 1, 1, [16, 16, 16]),
];

/// `TextureSizeCase`'s own `TextureSizeCaseSpec` table entry - `format`'s value is unread
/// when `is_shadow` is set (the GL internal format is `GL_DEPTH_COMPONENT16` regardless).
struct TextureSizeCaseSpec {
    name: &'static str,
    sampler_type: &'static str,
    kind: TexKind,
    format: TexFormat,
    is_shadow: bool,
}

const fn size_case(
    name: &'static str,
    sampler_type: &'static str,
    kind: TexKind,
    format: TexFormat,
) -> TextureSizeCaseSpec {
    TextureSizeCaseSpec {
        name,
        sampler_type,
        kind,
        format,
        is_shadow: false,
    }
}

const fn size_shadow_case(name: &'static str, sampler_type: &'static str, kind: TexKind) -> TextureSizeCaseSpec {
    TextureSizeCaseSpec {
        name,
        sampler_type,
        kind,
        format: TexFormat::Fixed,
        is_shadow: true,
    }
}

/// `textureSizeCases` - transcribed 1:1, including its own ordering (`sampler2d` before
/// `sampler3d` before `samplercube` before `sampler2darray`, each fixed/float/int/uint/shadow
/// in that order where present).
const TEXTURE_SIZE_CASES: &[TextureSizeCaseSpec] = &[
    size_case("sampler2d_fixed", "sampler2D", TexKind::Tex2D, TexFormat::Fixed),
    size_case("sampler2d_float", "sampler2D", TexKind::Tex2D, TexFormat::Float),
    size_case("isampler2d", "isampler2D", TexKind::Tex2D, TexFormat::Int),
    size_case("usampler2d", "usampler2D", TexKind::Tex2D, TexFormat::Uint),
    size_shadow_case("sampler2dshadow", "sampler2DShadow", TexKind::Tex2D),
    size_case("sampler3d_fixed", "sampler3D", TexKind::Tex3D, TexFormat::Fixed),
    size_case("sampler3d_float", "sampler3D", TexKind::Tex3D, TexFormat::Float),
    size_case("isampler3d", "isampler3D", TexKind::Tex3D, TexFormat::Int),
    size_case("usampler3d", "usampler3D", TexKind::Tex3D, TexFormat::Uint),
    size_case("samplercube_fixed", "samplerCube", TexKind::Cube, TexFormat::Fixed),
    size_case("samplercube_float", "samplerCube", TexKind::Cube, TexFormat::Float),
    size_case("isamplercube", "isamplerCube", TexKind::Cube, TexFormat::Int),
    size_case("usamplercube", "usamplerCube", TexKind::Cube, TexFormat::Uint),
    size_shadow_case("samplercubeshadow", "samplerCubeShadow", TexKind::Cube),
    size_case(
        "sampler2darray_fixed",
        "sampler2DArray",
        TexKind::Array2D,
        TexFormat::Fixed,
    ),
    size_case(
        "sampler2darray_float",
        "sampler2DArray",
        TexKind::Array2D,
        TexFormat::Float,
    ),
    size_case("isampler2darray", "isampler2DArray", TexKind::Array2D, TexFormat::Int),
    size_case("usampler2darray", "usampler2DArray", TexKind::Array2D, TexFormat::Uint),
    size_shadow_case("sampler2darrayshadow", "sampler2DArrayShadow", TexKind::Array2D),
];

/// The triangle `testTextureSize` draws into a 1x1 viewport - covers the whole thing
/// regardless of where that 1x1 viewport sits, exactly like upstream's own comment says.
const TEXTURE_SIZE_TRIANGLE: [f32; 12] = [-1.0, -1.0, 0.0, 1.0, 4.0, -1.0, 0.0, 1.0, -1.0, 4.0, 0.0, 1.0];

struct TextureSizeCase {
    name: String,
    spec: &'static TextureSizeCaseSpec,
    is_vertex_case: bool,
}

impl TextureSizeCase {
    /// `TextureSizeCase::genVertexShader`
    fn gen_vertex_shader(&self) -> String {
        let mut vert = String::from("#version 300 es\nin highp vec4 a_position;\n");
        if self.is_vertex_case {
            vert.push_str("out mediump vec4 v_color;\n");
            vert.push_str(&format!("uniform highp {} u_sampler;\n", self.spec.sampler_type));
            vert.push_str(&format!(
                "uniform highp ivec{} u_texSize;\n",
                if self.has_3d_size() { 3 } else { 2 }
            ));
            vert.push_str("uniform highp int u_lod;\n");
        }
        vert.push_str("void main()\n{\n");
        if self.is_vertex_case {
            vert.push_str("    v_color = (textureSize(u_sampler, u_lod) == u_texSize ? vec4(1.0, 1.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));\n");
        }
        vert.push_str("    gl_Position = a_position;\n}\n");
        vert
    }

    /// `TextureSizeCase::genFragmentShader`
    fn gen_fragment_shader(&self) -> String {
        let mut frag = String::from("#version 300 es\nlayout(location = 0) out mediump vec4 o_color;\n");
        if self.is_vertex_case {
            frag.push_str("in mediump vec4 v_color;\n");
        } else {
            frag.push_str(&format!("uniform highp {} u_sampler;\n", self.spec.sampler_type));
            frag.push_str(&format!(
                "uniform highp ivec{} u_texSize;\n",
                if self.has_3d_size() { 3 } else { 2 }
            ));
            frag.push_str("uniform highp int u_lod;\n");
        }
        frag.push_str("void main()\n{\n");
        if self.is_vertex_case {
            frag.push_str("    o_color = v_color;\n");
        } else {
            frag.push_str("    o_color = (textureSize(u_sampler, u_lod) == u_texSize ? vec4(1.0, 1.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0));\n");
        }
        frag.push_str("}\n");
        frag
    }

    /// `m_has3DSize` - `TEXTURETYPE_3D || TEXTURETYPE_2D_ARRAY` (the layer axis counts for
    /// this purely syntactic decision even though it never itself shrinks per level).
    fn has_3d_size(&self) -> bool {
        matches!(self.spec.kind, TexKind::Array2D | TexKind::Tex3D)
    }

    /// `TextureSizeCase::testTextureSize` - one test size against one already-linked program.
    /// Returns `Ok(false)` for an ordinary GL-level or size-mismatch failure (upstream's own
    /// `success = false`), and propagates a resource error (`GL_OUT_OF_MEMORY`) or a draw/
    /// readback error instead of folding either into the boolean, matching upstream's own
    /// `glu::OutOfMemoryError`/uncaught-exception split from a plain "wrong pixel".
    fn test_texture_size(
        &self,
        context: &Context,
        program: GLuint,
        test_size: &TextureSizeTestSize,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let render_ctx = &context.render_context;
        let target = self.spec.kind.gl_target();
        let is_square = test_size.size[0] == test_size.size[1];
        let is_2d_lod_valid = (test_size.size[0] >> (test_size.lod + test_size.lod_base) != 0)
            || (test_size.size[1] >> (test_size.lod + test_size.lod_base) != 0);

        // Skip incompatible cases - `TEXTURETYPE_CUBE_MAP`/`_2D`/`_2D_ARRAY` only; `_3D` has
        // no skip condition at all (every axis is independent, so no lod can shift every
        // dimension to zero without the others already being covered by another entry).
        if self.spec.kind == TexKind::Cube && !is_square {
            return Ok(true);
        }
        if matches!(self.spec.kind, TexKind::Tex2D | TexKind::Array2D) && !is_2d_lod_valid {
            return Ok(true);
        }

        // SAFETY: a current context; every call below targets state this function itself
        // just set up (the program, the viewport, the one texture object it creates).
        unsafe {
            gl.use_program(program);
            gl.uniform_1i(gl.get_uniform_location(program, c"u_sampler".as_ptr()), 0);
            gl.clear_color(0.5, 0.5, 0.5, 1.0);
            gl.viewport(0, 0, 1, 1);
        }

        let size_loc = unsafe { gl.get_uniform_location(program, c"u_texSize".as_ptr()) };
        let lod_loc = unsafe { gl.get_uniform_location(program, c"u_lod".as_ptr()) };
        let max_level = test_size.lod + test_size.lod_base;
        let levels = max_level + 1;
        let internal_format: GLenum = if self.spec.is_shadow {
            glw::GL_DEPTH_COMPONENT16
        } else {
            self.spec.format.gl_internal_format() as GLenum
        };
        let mut success = true;
        let mut tex_id: GLuint = 0;

        // SAFETY: one texture object is generated and bound before every call that
        // configures or fills it, matching `upload_texture`'s own gen/bind ordering.
        unsafe {
            gl.gen_textures(1, &mut tex_id);
            gl.bind_texture(target, tex_id);
            gl.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as GLint);
            gl.tex_parameteri(target, glw::GL_TEXTURE_BASE_LEVEL, test_size.lod_base);

            if self.spec.is_shadow {
                gl.tex_parameteri(
                    target,
                    glw::GL_TEXTURE_COMPARE_MODE,
                    glw::GL_COMPARE_REF_TO_TEXTURE as GLint,
                );
                // `getGLCompareFunc(COMPAREMODE_LESS)` - `samplerShadowNoMipmap`'s own
                // compare mode, the only one any upstream `*Shadow` `TextureSpec` uses.
                gl.tex_parameteri(target, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_LESS as GLint);
            }

            match self.spec.kind {
                TexKind::Tex3D => {
                    gl.uniform_3iv(size_loc, 1, test_size.expected.as_ptr());
                    gl.uniform_1iv(lod_loc, 1, [test_size.lod].as_ptr());
                    gl.tex_storage_3d(
                        target,
                        levels,
                        internal_format,
                        test_size.size[0],
                        test_size.size[1],
                        test_size.size[2],
                    );
                }
                TexKind::Tex2D | TexKind::Cube => {
                    gl.uniform_2iv(size_loc, 1, test_size.expected.as_ptr());
                    gl.uniform_1iv(lod_loc, 1, [test_size.lod].as_ptr());
                    gl.tex_storage_2d(target, levels, internal_format, test_size.size[0], test_size.size[1]);
                }
                TexKind::Array2D => {
                    // The layer axis (`z`) never shrinks across levels, unlike `_3D`'s own
                    // depth - `expectedSize` keeps the *input* layer count, not the derived one.
                    let expected = [test_size.expected[0], test_size.expected[1], test_size.size[2]];
                    gl.uniform_3iv(size_loc, 1, expected.as_ptr());
                    gl.uniform_1iv(lod_loc, 1, [test_size.lod].as_ptr());
                    gl.tex_storage_3d(
                        target,
                        levels,
                        internal_format,
                        test_size.size[0],
                        test_size.size[1],
                        test_size.size[2],
                    );
                }
            }
        }

        let error = unsafe { gl.get_error() };
        if error == glw::GL_OUT_OF_MEMORY {
            // Matches upstream: the texture object is not cleaned up on this path either.
            return Err(TestError::ResourceError(
                "Failed to allocate texture, got GL_OUT_OF_MEMORY.".to_string(),
            ));
        } else if error != glw::GL_NO_ERROR {
            success = false;
        } else {
            // SAFETY: a bound framebuffer (the default one) and a program just linked.
            unsafe { gl.clear(glw::GL_COLOR_BUFFER_BIT) };

            let position_loc = unsafe { gl.get_attrib_location(program, c"a_position".as_ptr()) };
            #[expect(
                clippy::cast_sign_loss,
                reason = "`a_position` is declared by the program just linked"
            )]
            let vertex_arrays = [va::float_at(position_loc as u32, 4, 3, 0, &TEXTURE_SIZE_TRIANGLE)];
            glu::draw(
                render_ctx,
                program,
                &vertex_arrays,
                &pr::list(PrimitiveType::Triangles, 3),
            )?;
            // SAFETY: a current context.
            unsafe { gl.finish() };

            let mut sample = Surface::new(1, 1);
            glu::read_pixels(render_ctx, 0, 0, &mut sample.get_access())?;
            let color = sample.get_pixel(0, 0).to_vec();
            const COLOR_TOLERANCE: f32 = 0.1;

            if !(color.x() >= 1.0 - COLOR_TOLERANCE
                && color.y() >= 1.0 - COLOR_TOLERANCE
                && color.z() >= 1.0 - COLOR_TOLERANCE)
            {
                success = false;
            }
        }

        // SAFETY: the same object bound and generated above.
        unsafe {
            gl.bind_texture(target, 0);
            gl.delete_textures(1, &tex_id);
            gl.use_program(0);
        }

        Ok(success)
    }
}

impl TestCase for TextureSizeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TextureSizeCase::iterate` - upstream spreads this over its own `STOP`/`CONTINUE`
    /// state machine (one GL-level test size per harness callback, so a later size still
    /// runs after an earlier one already failed); this port does the same "test every size,
    /// remember only whether any failed" in one call instead; the visible verdict is
    /// identical either way.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let vert_src = self.gen_vertex_shader();
        let frag_src = self.gen_fragment_shader();
        let program = ShaderProgram::new(context.gl(), &ProgramSources::vtx_frag(vert_src, frag_src));

        if !program.is_ok() {
            return Ok(TestStatus::fail("Shader failed"));
        }

        let mut any_failed = false;
        for test_size in TEXTURE_SIZE_TEST_SIZES {
            if !self.test_texture_size(context, program.program(), test_size)? {
                any_failed = true;
            }
        }

        Ok(if any_failed {
            TestStatus::fail("Got unexpected texture size")
        } else {
            TestStatus::pass("Pass")
        })
    }
}

fn create_texture_size_group(parent: &mut TestCaseGroup) {
    let mut group = TestCaseGroup::new("texturesize");
    for spec in TEXTURE_SIZE_CASES {
        group.add_child(Box::new(TextureSizeCase {
            name: format!("{}_vertex", spec.name),
            spec,
            is_vertex_case: true,
        }) as Box<dyn TestCase>);
        group.add_child(Box::new(TextureSizeCase {
            name: format!("{}_fragment", spec.name),
            spec,
            is_vertex_case: false,
        }) as Box<dyn TestCase>);
    }
    parent.add_child(group);
}

/// `ShaderTextureFunctionTests::init`, restricted to the shader-library `.invalid` cases
/// plus the scoped `sampler2D`/`samplerCube` `_fixed`/`_float` lookup cases this file
/// now ports (see the module-level doc comment for exactly what is and is not covered).
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("texture_functions");
    create_case_group(&mut group, "texture", TEXTURE_CASES);
    create_case_group(&mut group, "textureoffset", TEXTURE_OFFSET_CASES);
    create_case_group(&mut group, "textureproj", TEXTURE_PROJ_CASES);
    create_case_group(&mut group, "textureprojoffset", TEXTURE_PROJ_OFFSET_CASES);
    create_case_group(&mut group, "texturelod", TEXTURE_LOD_CASES);
    create_case_group(&mut group, "texturelodoffset", TEXTURE_LOD_OFFSET_CASES);
    create_case_group(&mut group, "textureprojlod", TEXTURE_PROJ_LOD_CASES);
    create_case_group(&mut group, "textureprojlodoffset", TEXTURE_PROJ_LOD_OFFSET_CASES);
    create_case_group(&mut group, "texturegrad", TEXTURE_GRAD_CASES);
    create_case_group(&mut group, "texturegradoffset", TEXTURE_GRAD_OFFSET_CASES);
    create_case_group(&mut group, "textureprojgrad", TEXTURE_PROJ_GRAD_CASES);
    create_case_group(&mut group, "textureprojgradoffset", TEXTURE_PROJ_GRAD_OFFSET_CASES);
    create_case_group(&mut group, "texelfetch", TEXEL_FETCH_CASES);
    create_case_group(&mut group, "texelfetchoffset", TEXEL_FETCH_OFFSET_CASES);
    create_texture_size_group(&mut group);
    group.add_child(create_group("invalid", &lib::gles3_invalid_texture_functions::ROOT));

    group
}
