// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureGatherTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Narrowed from upstream in these ways:
// - Upstream's `TextureGatherCase` is a base class with three subclasses (2D, 2D array, cube);
//   here one `TextureGatherCase` carries a `TexKind` and every virtual is a `match` on it.
// - Upstream computes an "ideal" gather image on the host (`texture.gatherOffsets(...)`) and only
//   calls the `isGather*ResultValid` verifier when a pixel is outside the colour threshold of it.
//   This port has no host-side `gatherOffsets`, so every pixel goes straight to the verifier. A
//   result equal to the ideal one is also accepted by it, so verdicts match; the log carries no
//   ideal/error-mask images either.
// - The `ES` only branches are written: no `GL_TEXTURE_CUBE_MAP_SEAMLESS` enable (desktop only) and
//   no `core(4, 5)` context checks.
// - `tcu::Sampler::CLAMP_TO_EDGE`/`REPEAT_GL`/`MIRRORED_REPEAT_GL` are carried as `Wrap`, and the
//   filter modes as the GL enums they map to.

use crate::glu::texture::Texture2D;
use crate::glu::texture_2d_array::Texture2DArray;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util::{compute_quad_tex_coord_2d, compute_quad_tex_coord_2d_array};
use crate::glu::texture_test_util_surface::{
    compute_fixed_point_threshold, compute_quad_tex_coord_cube_region, get_bits_vec, get_compare_mask,
};
use crate::glu::{
    self, Context, Framebuffer, ProgramSources, Renderbuffer, ShaderProgram, ShaderType, TestCase, TestCaseGroup, pr,
    va,
};
use crate::glw::{self, GLenum};
use crate::tcu::pixel::{
    CompareMode, ConstPixelBufferAccess, CubeFace, FilterMode, PixelBufferAccess, Sampler, TextureLevel,
    WrapMode as PixelWrapMode, get_texture_format_info,
};
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::tex_compare_verifier::{
    TexComparePrecision, is_gather_compare_result_valid_cube, is_gather_offsets_compare_result_valid_2d,
    is_gather_offsets_compare_result_valid_2d_array,
};
use crate::tcu::tex_verifier::{
    IntLookupPrecision, LookupPrecision, WrapMode as VerifierWrapMode, is_gather_offsets_result_valid_2d,
    is_gather_offsets_result_valid_2d_array, is_gather_offsets_result_valid_2d_array_int,
    is_gather_offsets_result_valid_2d_array_uint, is_gather_offsets_result_valid_2d_int,
    is_gather_offsets_result_valid_2d_uint, is_gather_result_valid_cube, is_gather_result_valid_cube_int,
    is_gather_result_valid_cube_uint,
};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::texture_2d::Texture2D as RefTexture2D;
use crate::tcu::texture_2d_array::Texture2DArray as RefTexture2DArray;
use crate::tcu::texture_cube::TextureCube as RefTextureCube;
use crate::tcu::vector::Vec2;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};

const BASE_SEED: u32 = 0;
const RENDER_SIZE: [i32; 2] = [64, 64];
const SPEC_MAX_MIN_OFFSET: i32 = -8;
const SPEC_MIN_MAX_OFFSET: i32 = 7;

const FLAG_MIPMAP_INCOMPLETE: u32 = 1 << 0;
const FLAG_DONT_SAMPLE_CUBE_CORNERS: u32 = 1 << 1;

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum TexKind {
    Tex2D,
    Tex2DArray,
    Cube,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum GatherType {
    Basic,
    Offset,
    OffsetDynamic,
    Offsets,
}

impl GatherType {
    fn name(self) -> &'static str {
        match self {
            Self::Basic => "basic",
            Self::Offset => "offset",
            Self::OffsetDynamic => "offset_dynamic",
            Self::Offsets => "offsets",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum OffsetSize {
    None,
    MinimumRequired,
    ImplementationMaximum,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Wrap {
    ClampToEdge,
    Repeat,
    MirroredRepeat,
}

impl Wrap {
    fn gl(self) -> GLenum {
        match self {
            Self::ClampToEdge => glw::GL_CLAMP_TO_EDGE,
            Self::Repeat => glw::GL_REPEAT,
            Self::MirroredRepeat => glw::GL_MIRRORED_REPEAT,
        }
    }

    fn verifier(self) -> VerifierWrapMode {
        match self {
            Self::ClampToEdge => VerifierWrapMode::ClampToEdge,
            Self::Repeat => VerifierWrapMode::Repeat,
            Self::MirroredRepeat => VerifierWrapMode::MirroredRepeat,
        }
    }

    fn pixel(self) -> PixelWrapMode {
        match self {
            Self::ClampToEdge => PixelWrapMode::ClampToEdge,
            Self::Repeat => PixelWrapMode::Repeat,
            Self::MirroredRepeat => PixelWrapMode::MirroredRepeat,
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum FormatClass {
    Unorm,
    UInt,
    SInt,
    Depth,
}

#[derive(Clone, Copy)]
struct GatherFormat {
    name: &'static str,
    class: FormatClass,
    tcu: TextureFormat,
    gl: GLenum,
}

impl GatherFormat {
    fn is_depth(&self) -> bool {
        self.class == FormatClass::Depth
    }

    /// Format of the colour buffer: `RGBA` of the texture's own channel type, `UNORM_INT8` for depth.
    fn color_buffer_gl(&self) -> GLenum {
        match self.class {
            FormatClass::Unorm | FormatClass::Depth => glw::GL_RGBA8,
            FormatClass::UInt => glw::GL_RGBA8UI,
            FormatClass::SInt => glw::GL_RGBA8I,
        }
    }
}

fn gather_formats() -> [GatherFormat; 4] {
    [
        GatherFormat {
            name: "rgba8",
            class: FormatClass::Unorm,
            tcu: TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            gl: glw::GL_RGBA8,
        },
        GatherFormat {
            name: "rgba8ui",
            class: FormatClass::UInt,
            tcu: TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT8),
            gl: glw::GL_RGBA8UI,
        },
        GatherFormat {
            name: "rgba8i",
            class: FormatClass::SInt,
            tcu: TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT8),
            gl: glw::GL_RGBA8I,
        },
        GatherFormat {
            name: "depth32f",
            class: FormatClass::Depth,
            tcu: TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT),
            gl: glw::GL_DEPTH_COMPONENT32F,
        },
    ]
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum SwizzleComponent {
    R,
    G,
    B,
    A,
    Zero,
    One,
}

const SWIZZLE_COMPONENTS: [SwizzleComponent; 6] = [
    SwizzleComponent::R,
    SwizzleComponent::G,
    SwizzleComponent::B,
    SwizzleComponent::A,
    SwizzleComponent::Zero,
    SwizzleComponent::One,
];

impl SwizzleComponent {
    fn lower_name(self) -> &'static str {
        match self {
            Self::R => "red",
            Self::G => "green",
            Self::B => "blue",
            Self::A => "alpha",
            Self::Zero => "zero",
            Self::One => "one",
        }
    }

    fn gl(self) -> GLenum {
        match self {
            Self::R => glw::GL_RED,
            Self::G => glw::GL_GREEN,
            Self::B => glw::GL_BLUE,
            Self::A => glw::GL_ALPHA,
            Self::Zero => glw::GL_ZERO,
            Self::One => glw::GL_ONE,
        }
    }
}

/// `MaybeTextureSwizzle`
#[derive(Clone, Copy)]
struct MaybeTextureSwizzle(Option<[SwizzleComponent; 4]>);

impl MaybeTextureSwizzle {
    fn none() -> Self {
        Self(None)
    }

    fn is_identity(&self) -> bool {
        self.0
            == Some([
                SwizzleComponent::R,
                SwizzleComponent::G,
                SwizzleComponent::B,
                SwizzleComponent::A,
            ])
    }

    fn is_none_or_identity(&self) -> bool {
        self.0.is_none() || self.is_identity()
    }
}

/// `GatherArgs`
#[derive(Clone, Copy)]
struct GatherArgs {
    /// If negative, implicit component index 0 is used (i.e. the parameter is not given).
    component_ndx: i32,
    /// Unless `GatherType::Offsets` is used, only `offsets[0]` is relevant; for `OffsetDynamic` none are.
    offsets: [[i32; 2]; 4],
}

impl GatherArgs {
    fn new(comp: i32, off0: [i32; 2], off1: [i32; 2], off2: [i32; 2], off3: [i32; 2]) -> Self {
        Self {
            component_ndx: comp,
            offsets: [off0, off1, off2, off3],
        }
    }

    fn comp(comp: i32) -> Self {
        Self::new(comp, [0, 0], [0, 0], [0, 0], [0, 0])
    }

    fn comp_off(comp: i32, off0: [i32; 2]) -> Self {
        Self::new(comp, off0, [0, 0], [0, 0], [0, 0])
    }
}

/// `divRoundToZero` - Rust's `/` already truncates toward zero.
fn div_round_to_zero(a: i32, b: i32) -> i32 {
    a / b
}

fn is_mipmap_filter(filter: GLenum) -> bool {
    matches!(
        filter,
        glw::GL_NEAREST_MIPMAP_NEAREST
            | glw::GL_NEAREST_MIPMAP_LINEAR
            | glw::GL_LINEAR_MIPMAP_NEAREST
            | glw::GL_LINEAR_MIPMAP_LINEAR
    )
}

fn require_gpu_shader5(gather_type: GatherType) -> bool {
    matches!(gather_type, GatherType::OffsetDynamic | GatherType::Offsets)
}

fn gl_compare_func(mode: CompareMode) -> GLenum {
    match mode {
        CompareMode::Less => glw::GL_LESS,
        CompareMode::LessOrEqual => glw::GL_LEQUAL,
        CompareMode::Greater => glw::GL_GREATER,
        CompareMode::GreaterOrEqual => glw::GL_GEQUAL,
        CompareMode::Equal => glw::GL_EQUAL,
        CompareMode::NotEqual => glw::GL_NOTEQUAL,
        CompareMode::Always => glw::GL_ALWAYS,
        CompareMode::Never | CompareMode::None => glw::GL_NEVER,
    }
}

/// `fillWithRandomColorTiles`
fn fill_with_random_color_tiles(dst: &mut PixelBufferAccess<'_>, min_val: [f32; 4], max_val: [f32; 4], seed: u32) {
    let [width, height, depth] = dst.size();
    let num_cols = if width >= 7 { 7 } else { width };
    let num_rows = if height >= 5 { 5 } else { height };
    let mut rnd = Random::new(seed);

    for slice in 0..depth {
        for row in 0..num_rows {
            for col in 0..num_cols {
                let y_begin = row * height / num_rows;
                let y_end = (row + 1) * height / num_rows;
                let x_begin = col * width / num_cols;
                let x_end = (col + 1) * width / num_cols;
                let mut color = [0.0f32; 4];
                for i in 0..4 {
                    color[i] = rnd.get_float_range(min_val[i], max_val[i]);
                }
                for y in y_begin..y_end {
                    for x in x_begin..x_end {
                        dst.set_pixel(color, x, y, slice);
                    }
                }
            }
        }
    }
}

fn swizzle_channel_f(src: [f32; 4], swizzle: SwizzleComponent) -> f32 {
    match swizzle {
        SwizzleComponent::R => src[0],
        SwizzleComponent::G => src[1],
        SwizzleComponent::B => src[2],
        SwizzleComponent::A => src[3],
        SwizzleComponent::Zero => 0.0,
        SwizzleComponent::One => 1.0,
    }
}

fn swizzle_channel_i(src: [i32; 4], swizzle: SwizzleComponent) -> i32 {
    match swizzle {
        SwizzleComponent::R => src[0],
        SwizzleComponent::G => src[1],
        SwizzleComponent::B => src[2],
        SwizzleComponent::A => src[3],
        SwizzleComponent::Zero => 0,
        SwizzleComponent::One => 1,
    }
}

/// `swizzlePixels`
fn swizzle_pixels(
    dst: &mut PixelBufferAccess<'_>,
    src: &ConstPixelBufferAccess<'_>,
    swizzle: MaybeTextureSwizzle,
    class: FormatClass,
) {
    if class == FormatClass::Depth {
        debug_assert!(swizzle.is_none_or_identity());
    }

    let [width, height, depth] = src.size();
    let components = swizzle.0.filter(|_| !swizzle.is_identity());

    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                match class {
                    FormatClass::Unorm | FormatClass::Depth => {
                        let mut color = src.get_pixel(x, y, z);
                        if let Some(components) = components {
                            let original = color;
                            for i in 0..4 {
                                color[i] = swizzle_channel_f(original, components[i]);
                            }
                        }
                        dst.set_pixel(color, x, y, z);
                    }
                    FormatClass::UInt | FormatClass::SInt => {
                        let mut color = src.get_pixel_int(x, y, z);
                        if let Some(components) = components {
                            let original = color;
                            for i in 0..4 {
                                color[i] = swizzle_channel_i(original, components[i]);
                            }
                        }
                        let _ = dst.set_pixel_int(color, x, y, z);
                    }
                }
            }
        }
    }
}

/// The three host textures upstream keeps as `m_swizzledTexture`.
enum SwizzledTexture {
    Tex2D(RefTexture2D),
    Tex2DArray(RefTexture2DArray),
    Cube(RefTextureCube),
}

/// The three driver textures upstream keeps as `m_texture`.
#[allow(dead_code)] // held only to keep the driver texture alive
enum GlTexture<'a> {
    Tex2D(Texture2D<'a>),
    Tex2DArray(Texture2DArray<'a>),
    Cube(TextureCube<'a>),
}

#[derive(Clone, Copy)]
struct Iteration {
    gather_args: GatherArgs,
    layer_ndx: i32,
    face: CubeFace,
}

/// `PixelOffsets` functors
enum PixelOffsets {
    Multiple([[i32; 2]; 4]),
    DynamicSingle([i32; 2]),
}

impl PixelOffsets {
    /// `SinglePixelOffsets`
    fn single(offset: [i32; 2]) -> [[i32; 2]; 4] {
        [
            [offset[0], offset[1] + 1],
            [offset[0] + 1, offset[1] + 1],
            [offset[0] + 1, offset[1]],
            [offset[0], offset[1]],
        ]
    }

    fn get(&self, px: i32, py: i32) -> [[i32; 2]; 4] {
        match self {
            Self::Multiple(offsets) => *offsets,
            Self::DynamicSingle(offset_range) => {
                let offset_range_size = offset_range[1] - offset_range[0] + 1;
                Self::single([
                    py.rem_euclid(offset_range_size) + offset_range[0],
                    px.rem_euclid(offset_range_size) + offset_range[0],
                ])
            }
        }
    }
}

/// `makePixelOffsetsFunctor`
fn make_pixel_offsets_functor(
    gather_type: GatherType,
    gather_args: &GatherArgs,
    offset_range: [i32; 2],
) -> PixelOffsets {
    match gather_type {
        GatherType::Basic => PixelOffsets::Multiple(PixelOffsets::single([0, 0])),
        GatherType::Offset => PixelOffsets::Multiple(PixelOffsets::single(gather_args.offsets[0])),
        GatherType::OffsetDynamic => PixelOffsets::DynamicSingle(offset_range),
        GatherType::Offsets => PixelOffsets::Multiple(gather_args.offsets),
    }
}

/// `triQuadInterpolate`
fn tri_quad_interpolate(values: &[Vec<f32>; 4], x_factor: f32, y_factor: f32) -> Vec<f32> {
    let n = values[0].len();
    (0..n)
        .map(|j| {
            if x_factor + y_factor < 1.0 {
                values[0][j] + (values[2][j] - values[0][j]) * x_factor + (values[1][j] - values[0][j]) * y_factor
            } else {
                values[3][j]
                    + (values[1][j] - values[3][j]) * (1.0 - x_factor)
                    + (values[2][j] - values[3][j]) * (1.0 - y_factor)
            }
        })
        .collect()
}

/// `computeTexCoordVecs`
fn compute_tex_coord_vecs(tex_coords: &[f32]) -> [Vec<f32>; 4] {
    debug_assert!(tex_coords.len() == 8 || tex_coords.len() == 12);
    let n = tex_coords.len() / 4;
    std::array::from_fn(|i| tex_coords[i * n..(i + 1) * n].to_vec())
}

/// What `getPixels` returns, as plain per-pixel values.
struct Rendered {
    floats: Vec<[f32; 4]>,
    ints: Vec<[i32; 4]>,
}

/// `generateBasic2DCaseIterations`
fn generate_basic_2d_case_iterations(
    gather_type: GatherType,
    format: &GatherFormat,
    offset_range: [i32; 2],
) -> Vec<GatherArgs> {
    // \note For non-depth textures, test explicit components 0 to 3 and implicit component 0.
    let num_component_cases = if format.is_depth() { 1 } else { 4 + 1 };
    let mut result = Vec::new();

    for component_case_ndx in 0..num_component_cases {
        let component_ndx = component_case_ndx - 1;

        match gather_type {
            GatherType::Basic => result.push(GatherArgs::comp(component_ndx)),
            GatherType::Offset => {
                let min = offset_range[0];
                let max = offset_range[1];
                let hmin = div_round_to_zero(min, 2);
                let hmax = div_round_to_zero(max, 2);

                result.push(GatherArgs::comp_off(component_ndx, [min, max]));

                // Don't test all offsets variants for all color components (they should be pretty orthogonal).
                if component_case_ndx == 0 {
                    result.push(GatherArgs::comp_off(component_ndx, [min, min]));
                    result.push(GatherArgs::comp_off(component_ndx, [max, min]));
                    result.push(GatherArgs::comp_off(component_ndx, [max, max]));

                    result.push(GatherArgs::comp_off(component_ndx, [0, hmax]));
                    result.push(GatherArgs::comp_off(component_ndx, [hmin, 0]));
                    result.push(GatherArgs::comp_off(component_ndx, [0, 0]));
                }
            }
            GatherType::OffsetDynamic => result.push(GatherArgs::comp(component_ndx)),
            GatherType::Offsets => {
                let min = offset_range[0];
                let max = offset_range[1];
                let hmin = div_round_to_zero(min, 2);
                let hmax = div_round_to_zero(max, 2);

                result.push(GatherArgs::new(
                    component_ndx,
                    [min, min],
                    [min, max],
                    [max, min],
                    [max, max],
                ));

                // Don't test all offsets variants for all color components (they should be pretty orthogonal).
                if component_case_ndx == 0 {
                    result.push(GatherArgs::new(
                        component_ndx,
                        [min, hmax],
                        [hmin, max],
                        [0, hmax],
                        [hmax, 0],
                    ));
                }
            }
        }
    }

    result
}

/// `TextureGatherCase` together with its three subclasses.
struct TextureGatherCase {
    name: String,
    kind: TexKind,
    gather_type: GatherType,
    offset_size: OffsetSize,
    format: GatherFormat,
    shadow_compare_mode: CompareMode,
    wrap_s: Wrap,
    wrap_t: Wrap,
    texture_swizzle: MaybeTextureSwizzle,
    min_filter: GLenum,
    mag_filter: GLenum,
    base_level: i32,
    flags: u32,
    /// `m_textureSize`: `[w, h]` for 2D, `[w, h, layers]` for 2D array, `[size, _, _]` for cube.
    texture_size: [u32; 3],
}

impl TextureGatherCase {
    #[allow(clippy::too_many_arguments)]
    fn new(
        name: &str,
        kind: TexKind,
        gather_type: GatherType,
        offset_size: OffsetSize,
        format: GatherFormat,
        shadow_compare_mode: CompareMode,
        wrap_s: Wrap,
        wrap_t: Wrap,
        texture_swizzle: MaybeTextureSwizzle,
        min_filter: GLenum,
        mag_filter: GLenum,
        base_level: i32,
        texture_size: [u32; 3],
        flags: u32,
    ) -> Self {
        debug_assert!((gather_type == GatherType::Basic) == (offset_size == OffsetSize::None));
        debug_assert!((shadow_compare_mode != CompareMode::None) == format.is_depth());
        debug_assert!(is_mipmap_filter(min_filter) || (flags & FLAG_MIPMAP_INCOMPLETE) == 0);
        debug_assert!(kind == TexKind::Cube || (flags & FLAG_DONT_SAMPLE_CUBE_CORNERS) == 0);
        debug_assert!(!((flags & FLAG_MIPMAP_INCOMPLETE) != 0 && format.is_depth()));

        Self {
            name: name.to_string(),
            kind,
            gather_type,
            offset_size,
            format,
            shadow_compare_mode,
            wrap_s,
            wrap_t,
            texture_swizzle,
            min_filter,
            mag_filter,
            base_level,
            flags,
            texture_size,
        }
    }

    /// `getOffsetRange`
    fn get_offset_range(&self, context: &Context) -> [i32; 2] {
        match self.offset_size {
            OffsetSize::None => [0, 0],
            // \note Defined by spec.
            OffsetSize::MinimumRequired => [SPEC_MAX_MIN_OFFSET, SPEC_MIN_MAX_OFFSET],
            OffsetSize::ImplementationMaximum => [
                context
                    .context_info
                    .get_int(context.gl(), glw::GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET),
                context
                    .context_info
                    .get_int(context.gl(), glw::GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET),
            ],
        }
    }

    fn gl_texture_type(&self) -> GLenum {
        match self.kind {
            TexKind::Tex2D => glw::GL_TEXTURE_2D,
            TexKind::Tex2DArray => glw::GL_TEXTURE_2D_ARRAY,
            TexKind::Cube => glw::GL_TEXTURE_CUBE_MAP,
        }
    }

    fn num_tex_coord_dims(&self) -> i32 {
        match self.kind {
            TexKind::Tex2D => 2,
            TexKind::Tex2DArray | TexKind::Cube => 3,
        }
    }

    /// `getSamplerType` as the GLSL type name.
    fn sampler_type_name(&self) -> &'static str {
        match (self.format.class, self.kind) {
            (FormatClass::Depth, TexKind::Tex2D) => "sampler2DShadow",
            (FormatClass::Depth, TexKind::Tex2DArray) => "sampler2DArrayShadow",
            (FormatClass::Depth, TexKind::Cube) => "samplerCubeShadow",
            (FormatClass::Unorm, TexKind::Tex2D) => "sampler2D",
            (FormatClass::Unorm, TexKind::Tex2DArray) => "sampler2DArray",
            (FormatClass::Unorm, TexKind::Cube) => "samplerCube",
            (FormatClass::SInt, TexKind::Tex2D) => "isampler2D",
            (FormatClass::SInt, TexKind::Tex2DArray) => "isampler2DArray",
            (FormatClass::SInt, TexKind::Cube) => "isamplerCube",
            (FormatClass::UInt, TexKind::Tex2D) => "usampler2D",
            (FormatClass::UInt, TexKind::Tex2DArray) => "usampler2DArray",
            (FormatClass::UInt, TexKind::Cube) => "usamplerCube",
        }
    }

    /// `getSamplerGatherResultType` as the GLSL type name.
    fn gather_result_type_name(&self) -> &'static str {
        match self.format.class {
            FormatClass::Unorm | FormatClass::Depth => "vec4",
            FormatClass::SInt => "ivec4",
            FormatClass::UInt => "uvec4",
        }
    }

    /// `genVertexShaderSource`
    fn gen_vertex_shader_source(
        &self,
        context: &Context,
        require_gpu_shader5: bool,
        num_tex_coord_components: i32,
        use_normalized_coord_input: bool,
    ) -> String {
        let tex_coord_type = format!("vec{num_tex_coord_components}");
        let gpu_shader5 = if require_gpu_shader5 {
            format!("{}\n", gpu_shader5_require(context))
        } else {
            String::new()
        };
        let normalized_in = if use_normalized_coord_input {
            "in highp vec2 a_normalizedCoord; // (0,0) to (1,1)\n"
        } else {
            ""
        };
        let normalized_out = if use_normalized_coord_input {
            "out highp vec2 v_normalizedCoord;\n"
        } else {
            ""
        };
        let normalized_assign = if use_normalized_coord_input {
            "\tv_normalizedCoord = a_normalizedCoord;\n"
        } else {
            ""
        };

        format!(
            "{}\n{gpu_shader5}\n\
             in highp vec2 a_position;\n\
             in highp {tex_coord_type} a_texCoord;\n\
             {normalized_in}\n\
             out highp {tex_coord_type} v_texCoord;\n\
             {normalized_out}\n\
             void main (void)\n\
             {{\n\
             \x20   gl_Position = vec4(a_position.x, a_position.y, 0.0, 1.0);\n\
             \x20   v_texCoord = a_texCoord;\n\
             {normalized_assign}}}\n",
            context.context_type().glsl_version().declaration()
        )
    }

    /// `genFragmentShaderSource`
    fn gen_fragment_shader_source(
        &self,
        context: &Context,
        require_gpu_shader5: bool,
        num_tex_coord_components: i32,
        func_call: &str,
        use_normalized_coord_input: bool,
        use_pix_coord: bool,
    ) -> String {
        debug_assert!((2..=3).contains(&num_tex_coord_components));
        debug_assert!(!use_pix_coord || use_normalized_coord_input);

        let tex_coord_type = format!("vec{num_tex_coord_components}");
        let gpu_shader5 = if require_gpu_shader5 {
            format!("{}\n", gpu_shader5_require(context))
        } else {
            String::new()
        };
        let normalized_in = if use_normalized_coord_input {
            "in highp vec2 v_normalizedCoord;\n"
        } else {
            ""
        };
        let viewport_uniform = if use_normalized_coord_input {
            "uniform highp vec2 u_viewportSize;\n"
        } else {
            ""
        };
        let pix_coord = if use_pix_coord {
            "\tivec2 pixCoord = ivec2(v_normalizedCoord*u_viewportSize);\n"
        } else {
            ""
        };

        format!(
            "{}\n{gpu_shader5}\n\
             layout (location = 0) out mediump {} o_color;\n\
             \n\
             in highp {tex_coord_type} v_texCoord;\n\
             {normalized_in}\n\
             uniform highp {} u_sampler;\n\
             {viewport_uniform}\n\
             void main(void)\n\
             {{\n\
             {pix_coord}    o_color = {func_call};\n\
             }}\n",
            context.context_type().glsl_version().declaration(),
            self.gather_result_type_name(),
            self.sampler_type_name()
        )
    }

    /// `genGatherFuncCall`
    fn gen_gather_func_call(
        &self,
        gather_args: &GatherArgs,
        ref_z_expr: &str,
        offset_range: [i32; 2],
        indentation_depth: usize,
    ) -> String {
        let mut result = String::new();

        match self.gather_type {
            GatherType::Basic => result.push_str("textureGather"),
            GatherType::Offset | GatherType::OffsetDynamic => result.push_str("textureGatherOffset"),
            GatherType::Offsets => result.push_str("textureGatherOffsets"),
        }

        result.push_str("(u_sampler, v_texCoord");

        if self.format.is_depth() {
            debug_assert!(gather_args.component_ndx < 0);
            result.push_str(&format!(", {ref_z_expr}"));
        }

        if self.gather_type != GatherType::Basic {
            result.push_str(", ");
            let tabs = "\t".repeat(indentation_depth);
            let ivec2 = |o: [i32; 2]| format!("ivec2({}, {})", o[0], o[1]);
            match self.gather_type {
                GatherType::Offset => result.push_str(&ivec2(gather_args.offsets[0])),
                GatherType::OffsetDynamic => {
                    result.push_str(&format!(
                        "pixCoord.yx % ivec2({}) + {}",
                        offset_range[1] - offset_range[0] + 1,
                        offset_range[0]
                    ));
                }
                GatherType::Offsets => {
                    result.push_str(&format!(
                        "ivec2[4](\n{tabs}\t{},\n{tabs}\t{},\n{tabs}\t{},\n{tabs}\t{})\n{tabs}\t",
                        ivec2(gather_args.offsets[0]),
                        ivec2(gather_args.offsets[1]),
                        ivec2(gather_args.offsets[2]),
                        ivec2(gather_args.offsets[3])
                    ));
                }
                GatherType::Basic => unreachable!(),
            }
        }

        if gather_args.component_ndx >= 0 {
            debug_assert!(gather_args.component_ndx < 4);
            result.push_str(&format!(", {}", gather_args.component_ndx));
        }

        result.push(')');
        result
    }

    /// `genProgramSources`
    fn gen_program_sources(
        &self,
        context: &Context,
        gather_args: &GatherArgs,
        ref_z_expr: &str,
        offset_range: [i32; 2],
    ) -> ProgramSources {
        let use_pix_coord = self.gather_type == GatherType::OffsetDynamic;
        let use_normalized_coord = use_pix_coord || self.format.is_depth();
        let is_dynamic_offset = self.gather_type == GatherType::OffsetDynamic;
        let is_shadow = self.format.is_depth();
        let num_dims = self.num_tex_coord_dims();
        let func_call = self.gen_gather_func_call(gather_args, ref_z_expr, offset_range, 1);

        ProgramSources::default()
            .with(
                ShaderType::Vertex,
                self.gen_vertex_shader_source(
                    context,
                    require_gpu_shader5(self.gather_type),
                    num_dims,
                    is_dynamic_offset || is_shadow,
                ),
            )
            .with(
                ShaderType::Fragment,
                self.gen_fragment_shader_source(
                    context,
                    require_gpu_shader5(self.gather_type),
                    num_dims,
                    &func_call,
                    use_normalized_coord,
                    use_pix_coord,
                ),
            )
    }

    /// The subclasses' `generateIterations`
    fn generate_iterations(&self, offset_range: [i32; 2]) -> Vec<Iteration> {
        let basic_iterations = generate_basic_2d_case_iterations(self.gather_type, &self.format, offset_range);
        let mut iterations = Vec::new();

        match self.kind {
            TexKind::Tex2D => {
                for gather_args in basic_iterations {
                    iterations.push(Iteration {
                        gather_args,
                        layer_ndx: 0,
                        face: CubeFace::NegativeX,
                    });
                }
            }
            TexKind::Tex2DArray => {
                // \note Out-of-bounds layer indices are tested too.
                for layer_ndx in -1..(self.texture_size[2] as i32 + 1) {
                    // Don't duplicate all cases for all layers.
                    if layer_ndx == 0 {
                        for gather_args in &basic_iterations {
                            iterations.push(Iteration {
                                gather_args: *gather_args,
                                layer_ndx,
                                face: CubeFace::NegativeX,
                            });
                        }
                    } else {
                        // For other layers than 0, only test one component and one set of offsets per layer.
                        for gather_args in &basic_iterations {
                            if self.format.is_depth() || gather_args.component_ndx == (layer_ndx + 2).rem_euclid(4) {
                                iterations.push(Iteration {
                                    gather_args: *gather_args,
                                    layer_ndx,
                                    face: CubeFace::NegativeX,
                                });
                                break;
                            }
                        }
                    }
                }
            }
            TexKind::Cube => {
                const FACES: [CubeFace; 6] = [
                    CubeFace::NegativeX,
                    CubeFace::PositiveX,
                    CubeFace::NegativeY,
                    CubeFace::PositiveY,
                    CubeFace::NegativeZ,
                    CubeFace::PositiveZ,
                ];

                for (cube_face_i, &face) in FACES.iter().enumerate() {
                    // Don't duplicate all cases for all faces.
                    if cube_face_i == 0 {
                        for gather_args in &basic_iterations {
                            iterations.push(Iteration {
                                gather_args: *gather_args,
                                layer_ndx: 0,
                                face,
                            });
                        }
                    } else {
                        // For other faces than first, only test one component per face.
                        for gather_args in &basic_iterations {
                            if self.format.is_depth() || gather_args.component_ndx == (cube_face_i % 4) as i32 {
                                iterations.push(Iteration {
                                    gather_args: *gather_args,
                                    layer_ndx: 0,
                                    face,
                                });
                                break;
                            }
                        }
                    }
                }
            }
        }

        iterations
    }

    /// The subclasses' `computeQuadTexCoord`
    fn compute_quad_tex_coord(&self, iteration: &Iteration) -> Vec<f32> {
        match self.kind {
            TexKind::Tex2D => compute_quad_tex_coord_2d(Vec2::new(-0.3, -0.4), Vec2::new(1.5, 1.6)).to_vec(),
            TexKind::Tex2DArray => {
                compute_quad_tex_coord_2d_array(iteration.layer_ndx, Vec2::new(-0.3, -0.4), Vec2::new(1.5, 1.6))
                    .to_vec()
            }
            TexKind::Cube => {
                let corners = (self.flags & FLAG_DONT_SAMPLE_CUBE_CORNERS) == 0;
                let min_c = if corners {
                    Vec2::new(-1.2, -1.2)
                } else {
                    Vec2::new(-0.6, -1.2)
                };
                let max_c = if corners {
                    Vec2::new(1.2, 1.2)
                } else {
                    Vec2::new(0.6, 1.2)
                };
                compute_quad_tex_coord_cube_region(iteration.face, min_c, max_c).to_vec()
            }
        }
    }

    /// The subclasses' `createAndUploadTexture`
    fn create_and_upload_texture<'a>(
        &self,
        context: &'a Context,
    ) -> Result<(GlTexture<'a>, SwizzledTexture), TestError> {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let tex_fmt_info = get_texture_format_info(self.format.tcu);
        let [w, h, d] = self.texture_size;

        // SAFETY: plain state setting on the current context.
        unsafe { gl.active_texture(glw::GL_TEXTURE0) };

        match self.kind {
            TexKind::Tex2D => {
                let mut texture = Texture2D::new_sized(render_ctx, self.format.gl, w, h)?;
                let level_begin = self.base_level as usize;
                let num_levels = texture.ref_texture().num_levels();
                debug_assert!(level_begin < num_levels);
                let level_end = if is_mipmap_filter(self.min_filter) && (self.flags & FLAG_MIPMAP_INCOMPLETE) == 0 {
                    num_levels
                } else {
                    level_begin + 1
                };

                for level_ndx in level_begin..level_end {
                    texture.ref_texture_mut().alloc_level(level_ndx);
                    let mut level = texture.ref_texture_mut().level_mut(level_ndx);
                    fill_with_random_color_tiles(&mut level, tex_fmt_info.value_min, tex_fmt_info.value_max, BASE_SEED);
                }

                let mut swizzled = RefTexture2D::new(self.format.tcu, w, h);
                for level_ndx in 0..num_levels {
                    if texture.ref_texture().is_level_empty(level_ndx) {
                        continue;
                    }
                    swizzled.alloc_level(level_ndx);
                    swizzle_pixels(
                        &mut swizzled.level_mut(level_ndx),
                        &texture.ref_texture().level(level_ndx),
                        self.texture_swizzle,
                        self.format.class,
                    );
                }

                // SAFETY: a current context and the texture's own entry points.
                unsafe { texture.upload() }?;
                Ok((GlTexture::Tex2D(texture), SwizzledTexture::Tex2D(swizzled)))
            }
            TexKind::Tex2DArray => {
                let mut texture = Texture2DArray::new_sized(render_ctx, self.format.gl, w, h, d)?;
                let level_begin = self.base_level as usize;
                let num_levels = texture.ref_texture().num_levels();
                debug_assert!(level_begin < num_levels);
                let level_end = if is_mipmap_filter(self.min_filter) && (self.flags & FLAG_MIPMAP_INCOMPLETE) == 0 {
                    num_levels
                } else {
                    level_begin + 1
                };

                for level_ndx in level_begin..level_end {
                    texture.ref_texture_mut().alloc_level(level_ndx);
                    let mut level = texture.ref_texture_mut().level_mut(level_ndx);
                    fill_with_random_color_tiles(&mut level, tex_fmt_info.value_min, tex_fmt_info.value_max, BASE_SEED);
                }

                let mut swizzled = RefTexture2DArray::new(self.format.tcu, w, h, d);
                for level_ndx in 0..num_levels {
                    if texture.ref_texture().is_level_empty(level_ndx) {
                        continue;
                    }
                    swizzled.alloc_level(level_ndx);
                    swizzle_pixels(
                        &mut swizzled.level_mut(level_ndx),
                        &texture.ref_texture().level(level_ndx),
                        self.texture_swizzle,
                        self.format.class,
                    );
                }

                // SAFETY: as above.
                unsafe { texture.upload() }?;
                Ok((GlTexture::Tex2DArray(texture), SwizzledTexture::Tex2DArray(swizzled)))
            }
            TexKind::Cube => {
                let mut texture = TextureCube::new_sized(render_ctx, self.format.gl, w)?;
                let level_begin = self.base_level as usize;
                let num_levels = texture.ref_texture().num_levels();
                debug_assert!(level_begin < num_levels);
                let level_end = if is_mipmap_filter(self.min_filter) && (self.flags & FLAG_MIPMAP_INCOMPLETE) == 0 {
                    num_levels
                } else {
                    level_begin + 1
                };
                const FACES: [CubeFace; 6] = [
                    CubeFace::NegativeX,
                    CubeFace::PositiveX,
                    CubeFace::NegativeY,
                    CubeFace::PositiveY,
                    CubeFace::NegativeZ,
                    CubeFace::PositiveZ,
                ];

                for level_ndx in level_begin..level_end {
                    texture.ref_texture_mut().alloc_level(level_ndx);
                    for (cube_face_i, &face) in FACES.iter().enumerate() {
                        let mut level_face = texture.ref_texture_mut().face_level_mut(face, level_ndx);
                        fill_with_random_color_tiles(
                            &mut level_face,
                            tex_fmt_info.value_min,
                            tex_fmt_info.value_max,
                            BASE_SEED ^ cube_face_i as u32,
                        );
                    }
                }

                let mut swizzled = RefTextureCube::new(self.format.tcu, w);
                for level_ndx in 0..num_levels {
                    if texture.ref_texture().is_level_empty(level_ndx) {
                        continue;
                    }
                    swizzled.alloc_level(level_ndx);
                    swizzle_pixels(
                        &mut swizzled.level_mut(level_ndx),
                        &texture.ref_texture().level(level_ndx),
                        self.texture_swizzle,
                        self.format.class,
                    );
                }

                // SAFETY: as above.
                unsafe { texture.upload() }?;
                Ok((GlTexture::Cube(texture), SwizzledTexture::Cube(swizzled)))
            }
        }
    }

    /// `getPixels`, as plain values.
    fn get_pixels(&self, context: &Context) -> Result<Rendered, TestError> {
        let width = RENDER_SIZE[0] as u32;
        let height = RENDER_SIZE[1] as u32;
        let channel_type = match self.format.class {
            FormatClass::Unorm | FormatClass::Depth => ChannelType::UNORM_INT8,
            // signed and unsigned integers must be read using 32-bit values
            FormatClass::UInt => ChannelType::UNSIGNED_INT32,
            FormatClass::SInt => ChannelType::SIGNED_INT32,
        };
        let mut level = TextureLevel::new(TextureFormat::new(ChannelOrder::RGBA, channel_type), width, height, 1)?;
        glu::read_pixels(&context.render_context, 0, 0, &mut level.get_access())?;

        let access = level.get_const_access();
        let mut rendered = Rendered {
            floats: Vec::new(),
            ints: Vec::new(),
        };
        for y in 0..height {
            for x in 0..width {
                match self.format.class {
                    FormatClass::Unorm | FormatClass::Depth => rendered.floats.push(access.get_pixel(x, y, 0)),
                    FormatClass::UInt | FormatClass::SInt => rendered.ints.push(access.get_pixel_int(x, y, 0)),
                }
            }
        }
        Ok(rendered)
    }

    /// `verifySingleColored`
    fn verify_single_colored(rendered: &Rendered, ref_color: [f32; 4]) -> bool {
        let mut success = true;
        for pixel in &rendered.floats {
            if *pixel != ref_color {
                success = false;
            }
        }
        success
    }

    /// One pixel's `isGather*ResultValid` call, in place of upstream's ideal-image shortcut.
    #[allow(clippy::too_many_arguments)]
    fn pixel_valid(
        &self,
        swizzled: &SwizzledTexture,
        rendered: &Rendered,
        px: i32,
        py: i32,
        tex_coord: &[f32],
        component_ndx: usize,
        offsets: [[i32; 2]; 4],
    ) -> bool {
        let pixel_ndx = (py * RENDER_SIZE[0] + px) as usize;
        let pixel_format = PixelFormat::new(8, 8, 8, 8);
        let color_bits = get_bits_vec(pixel_format).map(|b| (b - 1).max(0));
        let (coord_bits, uvw_bits) = match self.kind {
            TexKind::Tex2D => ([20, 20, 0], [7, 7, 0]),
            TexKind::Cube => ([10, 10, 10], [6, 6, 0]),
            TexKind::Tex2DArray => ([20, 20, 20], [7, 7, 7]),
        };
        let base = self.base_level as usize;
        let wrap_s = self.wrap_s.verifier();
        let wrap_t = self.wrap_t.verifier();

        if self.format.is_depth() {
            let compare_prec = TexComparePrecision {
                coord_bits,
                uvw_bits,
                reference_bits: 16,
                result_bits: pixel_format.red_bits - 1,
                ..Default::default()
            };
            let mut sampler = Sampler::clamp_to_edge(FilterMode::Nearest);
            sampler.wrap_s = self.wrap_s.pixel();
            sampler.wrap_t = self.wrap_t.pixel();
            sampler.compare = self.shadow_compare_mode;
            sampler.normalized_coords = true;
            let ref_z = (px as f32 + 0.5) / RENDER_SIZE[0] as f32;
            let result = rendered.floats[pixel_ndx];

            return match swizzled {
                SwizzledTexture::Tex2D(t) => is_gather_offsets_compare_result_valid_2d(
                    &t.level(base),
                    &sampler,
                    wrap_s,
                    wrap_t,
                    &compare_prec,
                    [tex_coord[0], tex_coord[1]],
                    offsets,
                    ref_z,
                    result,
                ),
                SwizzledTexture::Tex2DArray(t) => is_gather_offsets_compare_result_valid_2d_array(
                    &t.level(base),
                    t.num_layers() as i32,
                    &sampler,
                    wrap_s,
                    wrap_t,
                    &compare_prec,
                    [tex_coord[0], tex_coord[1], tex_coord[2]],
                    offsets,
                    ref_z,
                    result,
                ),
                // \note Cube gather only exists in its zero-offset form.
                SwizzledTexture::Cube(t) => is_gather_compare_result_valid_cube(
                    &t.level(base),
                    &sampler,
                    &compare_prec,
                    [tex_coord[0], tex_coord[1], tex_coord[2]],
                    ref_z,
                    result,
                ),
            };
        }

        match self.format.class {
            FormatClass::Unorm => {
                let lookup_prec = LookupPrecision {
                    color_threshold: compute_fixed_point_threshold(color_bits),
                    coord_bits,
                    uvw_bits,
                    color_mask: get_compare_mask(pixel_format),
                    ..Default::default()
                };
                let result = rendered.floats[pixel_ndx];

                match swizzled {
                    SwizzledTexture::Tex2D(t) => is_gather_offsets_result_valid_2d(
                        &t.level(base),
                        wrap_s,
                        wrap_t,
                        true,
                        &lookup_prec,
                        [tex_coord[0], tex_coord[1]],
                        component_ndx,
                        offsets,
                        result,
                    ),
                    SwizzledTexture::Tex2DArray(t) => is_gather_offsets_result_valid_2d_array(
                        &t.level(base),
                        t.num_layers() as i32,
                        wrap_s,
                        wrap_t,
                        true,
                        &lookup_prec,
                        [tex_coord[0], tex_coord[1], tex_coord[2]],
                        component_ndx,
                        offsets,
                        result,
                    ),
                    SwizzledTexture::Cube(t) => is_gather_result_valid_cube(
                        &t.level(base),
                        true,
                        &lookup_prec,
                        [tex_coord[0], tex_coord[1], tex_coord[2]],
                        component_ndx,
                        result,
                    ),
                }
            }
            FormatClass::UInt | FormatClass::SInt => {
                let lookup_prec = IntLookupPrecision {
                    color_threshold: [0; 4],
                    coord_bits,
                    uvw_bits,
                    color_mask: get_compare_mask(pixel_format),
                };
                let result_i = rendered.ints[pixel_ndx];
                let result_u = result_i.map(|v| v as u32);
                let is_unsigned = self.format.class == FormatClass::UInt;

                match swizzled {
                    SwizzledTexture::Tex2D(t) => {
                        let coord = [tex_coord[0], tex_coord[1]];
                        if is_unsigned {
                            is_gather_offsets_result_valid_2d_uint(
                                &t.level(base),
                                wrap_s,
                                wrap_t,
                                true,
                                &lookup_prec,
                                coord,
                                component_ndx,
                                offsets,
                                [0; 4],
                                result_u,
                            )
                        } else {
                            is_gather_offsets_result_valid_2d_int(
                                &t.level(base),
                                wrap_s,
                                wrap_t,
                                true,
                                &lookup_prec,
                                coord,
                                component_ndx,
                                offsets,
                                [0; 4],
                                result_i,
                            )
                        }
                    }
                    SwizzledTexture::Tex2DArray(t) => {
                        let coord = [tex_coord[0], tex_coord[1], tex_coord[2]];
                        let layers = t.num_layers() as i32;
                        if is_unsigned {
                            is_gather_offsets_result_valid_2d_array_uint(
                                &t.level(base),
                                layers,
                                wrap_s,
                                wrap_t,
                                true,
                                &lookup_prec,
                                coord,
                                component_ndx,
                                offsets,
                                [0; 4],
                                result_u,
                            )
                        } else {
                            is_gather_offsets_result_valid_2d_array_int(
                                &t.level(base),
                                layers,
                                wrap_s,
                                wrap_t,
                                true,
                                &lookup_prec,
                                coord,
                                component_ndx,
                                offsets,
                                [0; 4],
                                result_i,
                            )
                        }
                    }
                    SwizzledTexture::Cube(t) => {
                        let coord = [tex_coord[0], tex_coord[1], tex_coord[2]];
                        if is_unsigned {
                            is_gather_result_valid_cube_uint(
                                &t.level(base),
                                true,
                                &lookup_prec,
                                coord,
                                component_ndx,
                                [0; 4],
                                result_u,
                            )
                        } else {
                            is_gather_result_valid_cube_int(
                                &t.level(base),
                                true,
                                &lookup_prec,
                                coord,
                                component_ndx,
                                [0; 4],
                                result_i,
                            )
                        }
                    }
                }
            }
            FormatClass::Depth => unreachable!(),
        }
    }

    /// `TextureGatherCase::verify` (the templated one) with `verifyGatherOffsets`/`verifyGatherOffsetsCompare`/
    /// `verifySingleColored` folded in.
    fn verify(
        &self,
        rendered: &Rendered,
        swizzled: &SwizzledTexture,
        tex_coords: &[f32],
        gather_args: &GatherArgs,
        offset_range: [i32; 2],
    ) -> bool {
        if (self.flags & FLAG_MIPMAP_INCOMPLETE) != 0 {
            let component_ndx = gather_args.component_ndx.max(0) as usize;
            let incomplete_color = [0.0f32, 0.0, 0.0, 1.0];
            let ref_color = [incomplete_color[component_ndx]; 4];
            let is_ok = Self::verify_single_colored(rendered, ref_color);

            if !is_ok {
                log::warn!(
                    "Note: expected color {ref_color:?} for all pixels; {} is component at index {component_ndx} in the color {incomplete_color:?}, which is used for incomplete textures",
                    incomplete_color[component_ndx]
                );
            }

            return is_ok;
        }

        let pixel_offsets = make_pixel_offsets_functor(self.gather_type, gather_args, offset_range);
        let component_ndx = gather_args.component_ndx.max(0) as usize;
        let tex_coord_vecs = compute_tex_coord_vecs(tex_coords);
        let width = RENDER_SIZE[0];
        // \note Upstream's `height = result.getWidth()`; the render size is square.
        let height = RENDER_SIZE[0];
        let mut success = true;

        for py in 0..height {
            for px in 0..width {
                let offsets = pixel_offsets.get(px, py);

                let viewport_x = (px as f32 + 0.5) / width as f32;
                let viewport_y = (py as f32 + 0.5) / height as f32;
                let tex_coord = tri_quad_interpolate(&tex_coord_vecs, viewport_x, viewport_y);

                if !self.pixel_valid(swizzled, rendered, px, py, &tex_coord, component_ndx, offsets) {
                    success = false;
                }
            }
        }

        success
    }
}

fn gpu_shader5_require(context: &Context) -> &'static str {
    if context.context_type().supports(3, 2) {
        ""
    } else {
        "#extension GL_EXT_gpu_shader5 : require"
    }
}

impl TestCase for TextureGatherCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// The prerequisite half of `TextureGatherCase::init`.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let supports_es32 = context.context_type().supports(3, 2);

        if require_gpu_shader5(self.gather_type)
            && !supports_es32
            && !context.context_info.is_extension_supported("GL_EXT_gpu_shader5")
        {
            return Err(TestError::NotSupported("GL_EXT_gpu_shader5 required".to_string()));
        }
        Ok(())
    }

    /// `init` followed by every `iterate` call upstream's `CONTINUE` would make.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let tex_type_gl = self.gl_texture_type();

        // Log and check implementation offset limits, if appropriate.
        if self.offset_size == OffsetSize::ImplementationMaximum {
            let offset_range = self.get_offset_range(context);
            log::info!(
                "Implementation's value for GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET: {}",
                offset_range[0]
            );
            log::info!(
                "Implementation's value for GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET: {}",
                offset_range[1]
            );
            if offset_range[0] > SPEC_MAX_MIN_OFFSET {
                return Err(TestError::Fail(format!(
                    "GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET must be at most {SPEC_MAX_MIN_OFFSET}"
                )));
            }
            if offset_range[1] < SPEC_MIN_MAX_OFFSET {
                return Err(TestError::Fail(format!(
                    "GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET must be at least {SPEC_MIN_MAX_OFFSET}"
                )));
            }
        }

        // Create rbo and fbo.
        let color_buffer = Renderbuffer::new(gl);
        // SAFETY: names this case generated.
        unsafe {
            gl.bind_renderbuffer(glw::GL_RENDERBUFFER, color_buffer.get());
            gl.renderbuffer_storage(
                glw::GL_RENDERBUFFER,
                self.format.color_buffer_gl(),
                RENDER_SIZE[0],
                RENDER_SIZE[1],
            );
        }
        glu::expect_no_error(gl, "Create and setup renderbuffer object")?;

        let fbo = Framebuffer::new(gl);
        // SAFETY: as above.
        unsafe {
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
            gl.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                color_buffer.get(),
            );
        }
        glu::expect_no_error(gl, "Create and setup framebuffer object")?;

        log::info!(
            "Using a framebuffer object with renderbuffer with format {:#x} and size {:?}",
            self.format.color_buffer_gl(),
            RENDER_SIZE
        );

        // Generate subclass-specific iterations.
        let offset_range = self.get_offset_range(context);
        let iterations = self.generate_iterations(offset_range);
        debug_assert!(!iterations.is_empty());

        // Initialize texture.
        let (gl_texture, swizzled) = self.create_and_upload_texture(context)?;
        let _ = &gl_texture;
        // SAFETY: the texture was just bound by its own upload; plain parameter setting.
        unsafe {
            gl.tex_parameteri(tex_type_gl, glw::GL_TEXTURE_WRAP_S, self.wrap_s.gl() as i32);
            gl.tex_parameteri(tex_type_gl, glw::GL_TEXTURE_WRAP_T, self.wrap_t.gl() as i32);
            gl.tex_parameteri(tex_type_gl, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
            gl.tex_parameteri(tex_type_gl, glw::GL_TEXTURE_MAG_FILTER, self.mag_filter as i32);

            if self.base_level != 0 {
                gl.tex_parameteri(tex_type_gl, glw::GL_TEXTURE_BASE_LEVEL, self.base_level);
            }

            if self.format.is_depth() {
                gl.tex_parameteri(
                    tex_type_gl,
                    glw::GL_TEXTURE_COMPARE_MODE,
                    glw::GL_COMPARE_REF_TO_TEXTURE as i32,
                );
                gl.tex_parameteri(
                    tex_type_gl,
                    glw::GL_TEXTURE_COMPARE_FUNC,
                    gl_compare_func(self.shadow_compare_mode) as i32,
                );
            }

            if let Some(components) = self.texture_swizzle.0 {
                let swizzle_names_gl = [
                    glw::GL_TEXTURE_SWIZZLE_R,
                    glw::GL_TEXTURE_SWIZZLE_G,
                    glw::GL_TEXTURE_SWIZZLE_B,
                    glw::GL_TEXTURE_SWIZZLE_A,
                ];

                for i in 0..4 {
                    gl.tex_parameteri(tex_type_gl, swizzle_names_gl[i], components[i].gl() as i32);
                }
            }
        }
        glu::expect_no_error(gl, "Set texture parameters")?;

        log::info!("Texture base level is {}", self.base_level);

        for (iteration_ndx, iteration) in iterations.iter().enumerate() {
            log::info!("Iteration {iteration_ndx}");

            let gather_args = &iteration.gather_args;
            let ref_z_expr = "v_normalizedCoord.x";
            let need_pixel_coord_in_shader = self.gather_type == GatherType::OffsetDynamic;
            let need_normalized_coord_in_shader = need_pixel_coord_in_shader || self.format.is_depth();

            // Generate a program appropriate for this iteration.
            let program = ShaderProgram::new(
                gl,
                &self.gen_program_sources(context, gather_args, ref_z_expr, offset_range),
            );
            if !program.is_ok() {
                return Err(TestError::Fail("Failed to build program".to_string()));
            }

            // Render.
            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.viewport(0, 0, RENDER_SIZE[0], RENDER_SIZE[1]);
                gl.clear_color(0.0, 0.0, 0.0, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT);
            }

            {
                let position: [f32; 8] = [-1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0];
                let normalized_coord: [f32; 8] = [0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 1.0];
                let tex_coord = self.compute_quad_tex_coord(iteration);

                let mut attr_bindings = vec![
                    va::float("a_position", 2, 4, 0, &position),
                    va::float("a_texCoord", (tex_coord.len() / 4) as i32, 4, 0, &tex_coord),
                ];
                if need_normalized_coord_in_shader {
                    attr_bindings.push(va::float("a_normalizedCoord", 2, 4, 0, &normalized_coord));
                }

                let indices: [u16; 6] = [0, 1, 2, 2, 1, 3];

                // SAFETY: a program just built; NUL-terminated names against it.
                unsafe {
                    gl.use_program(program.program());

                    let sampler_uniform_location = gl.get_uniform_location(program.program(), c"u_sampler".as_ptr());
                    if sampler_uniform_location < 0 {
                        return Err(TestError::Fail("samplerUniformLocation >= 0".to_string()));
                    }
                    gl.uniform_1i(sampler_uniform_location, 0);

                    if need_pixel_coord_in_shader {
                        let viewport_size_uniform_location =
                            gl.get_uniform_location(program.program(), c"u_viewportSize".as_ptr());
                        if viewport_size_uniform_location < 0 {
                            return Err(TestError::Fail("viewportSizeUniformLocation >= 0".to_string()));
                        }
                        gl.uniform_2f(
                            viewport_size_uniform_location,
                            RENDER_SIZE[0] as f32,
                            RENDER_SIZE[1] as f32,
                        );
                    }
                }

                log::info!(
                    "Texture coordinates run from {:?} to {:?}",
                    &tex_coord[..tex_coord.len() / 4],
                    &tex_coord[tex_coord.len() / 4 * 3..]
                );

                glu::draw(render_ctx, program.program(), &attr_bindings, &pr::triangles(&indices))?;
            }

            // Verify result.
            let rendered = self.get_pixels(context)?;
            let tex_coord = self.compute_quad_tex_coord(iteration);

            if !self.verify(&rendered, &swizzled, &tex_coord, gather_args, offset_range) {
                return Ok(TestStatus::fail("Result verification failed"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

#[allow(clippy::too_many_arguments)]
fn make_texture_gather_case(
    kind: TexKind,
    name: &str,
    gather_type: GatherType,
    offset_size: OffsetSize,
    format: GatherFormat,
    compare_mode: CompareMode,
    wrap_s: Wrap,
    wrap_t: Wrap,
    swizzle: MaybeTextureSwizzle,
    min_filter: GLenum,
    mag_filter: GLenum,
    base_level: i32,
    texture_size: [u32; 3],
    flags: u32,
) -> Box<dyn TestCase> {
    if kind == TexKind::Cube {
        debug_assert!(gather_type == GatherType::Basic);
        debug_assert!(offset_size == OffsetSize::None);
    }

    Box::new(TextureGatherCase::new(
        name,
        kind,
        gather_type,
        offset_size,
        format,
        compare_mode,
        wrap_s,
        wrap_t,
        swizzle,
        min_filter,
        mag_filter,
        base_level,
        texture_size,
        flags,
    ))
}

fn compare_mode_name(mode: CompareMode) -> &'static str {
    match mode {
        CompareMode::Less => "less",
        CompareMode::LessOrEqual => "less_or_equal",
        CompareMode::Greater => "greater",
        CompareMode::GreaterOrEqual => "greater_or_equal",
        CompareMode::Equal => "equal",
        CompareMode::NotEqual => "not_equal",
        CompareMode::Always => "always",
        CompareMode::Never => "never",
        CompareMode::None => "none",
    }
}

/// The body of `TextureGatherTests::init`'s innermost loops: one group per texture type, for one
/// (gather type, offset size) pair.
fn create_texture_type_groups(gather_type: GatherType, offset_size: OffsetSize) -> Vec<TestCaseGroup> {
    let texture_types = [
        ("2d", TexKind::Tex2D),
        ("2d_array", TexKind::Tex2DArray),
        ("cube", TexKind::Cube),
    ];
    let texture_sizes: [(&str, [u32; 3]); 2] = [("size_pot", [64, 64, 3]), ("size_npot", [17, 23, 3])];
    let wrap_modes = [
        ("clamp_to_edge", Wrap::ClampToEdge),
        ("repeat", Wrap::Repeat),
        ("mirrored_repeat", Wrap::MirroredRepeat),
    ];
    let mut texture_type_groups = Vec::new();

    for (texture_type_name, kind) in texture_types {
        if kind == TexKind::Cube && gather_type != GatherType::Basic {
            continue;
        }

        let mut texture_type_group = TestCaseGroup::new(texture_type_name);

        for format in gather_formats() {
            let mut format_group = TestCaseGroup::new(format.name);

            for no_corners_i in 0..=(if kind == TexKind::Cube { 1 } else { 0 }) {
                let no_corners = no_corners_i != 0;
                let mut size_groups = Vec::new();

                for (texture_size_name, texture_size) in texture_sizes {
                    let mut texture_size_group = TestCaseGroup::new(texture_size_name);

                    let compare_modes: &[CompareMode] = if format.is_depth() {
                        &[CompareMode::Less, CompareMode::Greater]
                    } else {
                        &[CompareMode::None]
                    };
                    for &compare_mode in compare_modes {
                        let mut compare_mode_group = (compare_mode != CompareMode::None)
                            .then(|| TestCaseGroup::new(format!("compare_{}", compare_mode_name(compare_mode))));

                        for wrap_case_ndx in 0..wrap_modes.len() {
                            let wrap_s_ndx = wrap_case_ndx;
                            let wrap_t_ndx = (wrap_case_ndx + 1) % wrap_modes.len();
                            let wrap_s = wrap_modes[wrap_s_ndx].1;
                            let wrap_t = wrap_modes[wrap_t_ndx].1;

                            let case_name = format!("{}_{}", wrap_modes[wrap_s_ndx].0, wrap_modes[wrap_t_ndx].0);

                            let case = make_texture_gather_case(
                                kind,
                                &case_name,
                                gather_type,
                                offset_size,
                                format,
                                compare_mode,
                                wrap_s,
                                wrap_t,
                                MaybeTextureSwizzle::none(),
                                glw::GL_NEAREST,
                                glw::GL_NEAREST,
                                0,
                                texture_size,
                                if no_corners { FLAG_DONT_SAMPLE_CUBE_CORNERS } else { 0 },
                            );
                            match compare_mode_group.as_mut() {
                                Some(group) => {
                                    group.add_child(case);
                                }
                                None => {
                                    texture_size_group.add_child(case);
                                }
                            }
                        }

                        if let Some(group) = compare_mode_group {
                            texture_size_group.add_child(group);
                        }
                    }

                    size_groups.push(texture_size_group);
                }

                if no_corners {
                    let mut corners_group = TestCaseGroup::new("no_corners");
                    for group in size_groups {
                        corners_group.add_child(group);
                    }
                    format_group.add_child(corners_group);
                } else {
                    for group in size_groups {
                        format_group.add_child(group);
                    }
                }
            }

            // Don't test all features for both offset size types, as they should be rather orthogonal.
            if offset_size != OffsetSize::MinimumRequired {
                if !format.is_depth() {
                    let mut swizzle_group = TestCaseGroup::new("texture_swizzle");

                    for swizzle_case_ndx in 0..SWIZZLE_COMPONENTS.len() {
                        let components: [SwizzleComponent; 4] = std::array::from_fn(|i| {
                            SWIZZLE_COMPONENTS[(swizzle_case_ndx + i) % SWIZZLE_COMPONENTS.len()]
                        });
                        let case_name = components.iter().map(|c| c.lower_name()).collect::<Vec<_>>().join("_");

                        swizzle_group.add_child(make_texture_gather_case(
                            kind,
                            &case_name,
                            gather_type,
                            offset_size,
                            format,
                            CompareMode::None,
                            Wrap::Repeat,
                            Wrap::Repeat,
                            MaybeTextureSwizzle(Some(components)),
                            glw::GL_NEAREST,
                            glw::GL_NEAREST,
                            0,
                            [64, 64, 3],
                            0,
                        ));
                    }

                    format_group.add_child(swizzle_group);
                }

                {
                    let mut filter_mode_group = TestCaseGroup::new("filter_mode");

                    let mag_filters = [("linear", glw::GL_LINEAR), ("nearest", glw::GL_NEAREST)];
                    // \note Don't test NEAREST here, as it's covered by other cases.
                    let min_filters = [
                        ("linear", glw::GL_LINEAR),
                        ("nearest_mipmap_nearest", glw::GL_NEAREST_MIPMAP_NEAREST),
                        ("nearest_mipmap_linear", glw::GL_NEAREST_MIPMAP_LINEAR),
                        ("linear_mipmap_nearest", glw::GL_LINEAR_MIPMAP_NEAREST),
                        ("linear_mipmap_linear", glw::GL_LINEAR_MIPMAP_LINEAR),
                    ];

                    for (min_filter_name, min_filter) in min_filters {
                        for (mag_filter_name, mag_filter) in mag_filters {
                            let compare_mode = if format.is_depth() {
                                CompareMode::Less
                            } else {
                                CompareMode::None
                            };

                            if matches!(format.class, FormatClass::Unorm | FormatClass::Depth)
                                && mag_filter == glw::GL_NEAREST
                            {
                                continue; // Covered by other cases.
                            }
                            if matches!(format.class, FormatClass::UInt | FormatClass::SInt)
                                && (mag_filter != glw::GL_NEAREST || min_filter != glw::GL_NEAREST_MIPMAP_NEAREST)
                            {
                                continue;
                            }

                            let case_name = format!("min_{min_filter_name}_mag_{mag_filter_name}");

                            filter_mode_group.add_child(make_texture_gather_case(
                                kind,
                                &case_name,
                                gather_type,
                                offset_size,
                                format,
                                compare_mode,
                                Wrap::Repeat,
                                Wrap::Repeat,
                                MaybeTextureSwizzle::none(),
                                min_filter,
                                mag_filter,
                                0,
                                [64, 64, 3],
                                0,
                            ));
                        }
                    }

                    format_group.add_child(filter_mode_group);
                }

                {
                    let mut base_level_group = TestCaseGroup::new("base_level");

                    for base_level in 1..=2 {
                        let case_name = format!("level_{base_level}");
                        let compare_mode = if format.is_depth() {
                            CompareMode::Less
                        } else {
                            CompareMode::None
                        };
                        base_level_group.add_child(make_texture_gather_case(
                            kind,
                            &case_name,
                            gather_type,
                            offset_size,
                            format,
                            compare_mode,
                            Wrap::Repeat,
                            Wrap::Repeat,
                            MaybeTextureSwizzle::none(),
                            glw::GL_NEAREST,
                            glw::GL_NEAREST,
                            base_level,
                            [64, 64, 3],
                            0,
                        ));
                    }

                    format_group.add_child(base_level_group);
                }

                // What shadow textures should return for incomplete textures is unclear.
                // Integer and unsigned integer lookups from incomplete textures return undefined values.
                if format.class == FormatClass::Unorm {
                    let mut incomplete_group = TestCaseGroup::new("incomplete");

                    incomplete_group.add_child(make_texture_gather_case(
                        kind,
                        "mipmap_incomplete",
                        gather_type,
                        offset_size,
                        format,
                        CompareMode::None,
                        Wrap::Repeat,
                        Wrap::Repeat,
                        MaybeTextureSwizzle::none(),
                        glw::GL_NEAREST_MIPMAP_NEAREST,
                        glw::GL_NEAREST,
                        0,
                        [64, 64, 3],
                        FLAG_MIPMAP_INCOMPLETE,
                    ));

                    format_group.add_child(incomplete_group);
                }
            }

            texture_type_group.add_child(format_group);
        }

        texture_type_groups.push(texture_type_group);
    }

    texture_type_groups
}

/// `TextureGatherTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("gather");

    for gather_type in [
        GatherType::Basic,
        GatherType::Offset,
        GatherType::OffsetDynamic,
        GatherType::Offsets,
    ] {
        let mut gather_type_group = TestCaseGroup::new(gather_type.name());

        for offset_size in [
            OffsetSize::None,
            OffsetSize::MinimumRequired,
            OffsetSize::ImplementationMaximum,
        ] {
            if (gather_type == GatherType::Basic) != (offset_size == OffsetSize::None) {
                continue;
            }

            let texture_type_groups = create_texture_type_groups(gather_type, offset_size);

            match offset_size {
                OffsetSize::None => {
                    for texture_type_group in texture_type_groups {
                        gather_type_group.add_child(texture_type_group);
                    }
                }
                OffsetSize::MinimumRequired | OffsetSize::ImplementationMaximum => {
                    let mut offset_size_group = TestCaseGroup::new(if offset_size == OffsetSize::MinimumRequired {
                        "min_required_offset"
                    } else {
                        "implementation_offset"
                    });
                    for texture_type_group in texture_type_groups {
                        offset_size_group.add_child(texture_type_group);
                    }
                    gather_type_group.add_child(offset_size_group);
                }
            }
        }

        group.add_child(gather_type_group);
    }

    group
}
