// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineImageUtil.cpp / .hpp (TestTexture and its subclasses, the sampling
//   capability queries, `getLookupScaleBias`, the border colour helpers, `uploadTestTexture`)
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineVertexUtil.cpp / .hpp (`Vertex4Tex4`, the quad mosaics)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The seven `TestTexture` subclasses are one `TestTexture` with a `TextureKind`;
// every mip level is one `TextureLevel` holding all the layers (depth slices, with the 1D array as rows), which is what the
// lookup verifier's array views want, and `get_level` cuts a layer out of it. Compressed formats are only generated for the
// formats `tcu::compressed_texture::decompress` decodes.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::compressed_texture::{decompress, get_uncompressed_format};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, DepthStencilMode, PixelBufferAccess, TextureLevel, fill_with_component_gradients2,
    get_channel_bit_depth, get_effective_depth_stencil_texture_format, get_texture_format_info, has_depth_component,
    has_stencil_component, is_combined_depth_stencil_type, tight_pitch,
};
use crate::tcu::random::Random;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};
use crate::tcu::{TestError, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::compressed_formats::{
    get_block_depth, get_block_height, get_block_size_in_bytes, get_block_width, is_astc_format, is_astc_hdr_format,
    is_astc_srgb_format, is_compressed_format,
};
use crate::vk::mem_util::{Allocation, MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::ref_util::Unique;
use crate::vk::sparse_util::allocate_and_bind_sparse_image;
use crate::vkt::Context;

/// `BorderColor`
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum BorderColor {
    OpaqueBlack,
    OpaqueWhite,
    TransparentBlack,
    Custom,
}

impl BorderColor {
    /// The name used in case names, `borderColorNames`.
    pub fn name(self) -> &'static str {
        match self {
            Self::OpaqueBlack => "opaque_black",
            Self::OpaqueWhite => "opaque_white",
            Self::TransparentBlack => "transparent_black",
            Self::Custom => "custom",
        }
    }
}

/// `vk::isIntFormat` - a format whose tcu channel class is signed integer.
pub fn is_int_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|tcu_format| tcu_format.channel_class() == TextureChannelClass::SignedInteger)
}

/// `vk::isUintFormat`
pub fn is_uint_format(format: vk::Format) -> bool {
    map_vk_format(format).is_some_and(|tcu_format| tcu_format.channel_class() == TextureChannelClass::UnsignedInteger)
}

/// `vk::isDepthStencilFormat`
pub fn is_depth_stencil_format(format: vk::Format) -> bool {
    !is_compressed_format(format)
        && map_vk_format(format)
            .is_some_and(|tcu_format| matches!(tcu_format.order, ChannelOrder::D | ChannelOrder::S | ChannelOrder::DS))
}

/// `vk::getFormatName` lowercased without the `VK_FORMAT_` prefix, the name of a format in a case name.
pub fn format_case_name(format: vk::Format) -> String {
    format!("{format:?}").to_lowercase()
}

/// `isSupportedSamplableFormat`
pub fn is_supported_samplable_format(context: &Context<'_>, format: vk::Format) -> bool {
    if is_compressed_format(format) {
        let mut astc_hdr_features = vk::PhysicalDeviceTextureCompressionASTCHDRFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut astc_hdr_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        let features = features2.features;

        if is_astc_format(format) {
            if is_astc_hdr_format(format) {
                if astc_hdr_features.texture_compression_astc_hdr == vk::FALSE {
                    return false;
                }
            } else if features.texture_compression_astc_ldr == vk::FALSE {
                return false;
            }
        } else if matches!(
            format,
            vk::Format::ETC2_R8G8B8_UNORM_BLOCK
                | vk::Format::ETC2_R8G8B8_SRGB_BLOCK
                | vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK
                | vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK
                | vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK
                | vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK
                | vk::Format::EAC_R11_UNORM_BLOCK
                | vk::Format::EAC_R11_SNORM_BLOCK
                | vk::Format::EAC_R11G11_UNORM_BLOCK
                | vk::Format::EAC_R11G11_SNORM_BLOCK
        ) {
            if features.texture_compression_etc2 == vk::FALSE {
                return false;
            }
        } else if features.texture_compression_bc == vk::FALSE {
            return false;
        }
    }

    let properties = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };
    properties
        .optimal_tiling_features
        .contains(vk::FormatFeatureFlags::SAMPLED_IMAGE)
}

fn tiling_features(context: &Context<'_>, format: vk::Format, tiling: vk::ImageTiling) -> vk::FormatFeatureFlags {
    let properties = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };
    if tiling == vk::ImageTiling::LINEAR {
        properties.linear_tiling_features
    } else {
        properties.optimal_tiling_features
    }
}

/// `isLinearFilteringSupported`
pub fn is_linear_filtering_supported(context: &Context<'_>, format: vk::Format, tiling: vk::ImageTiling) -> bool {
    tiling_features(context, format, tiling).contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_LINEAR)
}

/// `isMinMaxFilteringSupported`
pub fn is_min_max_filtering_supported(context: &Context<'_>, format: vk::Format, tiling: vk::ImageTiling) -> bool {
    tiling_features(context, format, tiling).contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_MINMAX)
}

fn is_border_color_int(format: vk::Format, use_stencil_aspect: bool) -> bool {
    !is_compressed_format(format)
        && (is_int_format(format) || is_uint_format(format) || (is_depth_stencil_format(format) && use_stencil_aspect))
}

/// `getFormatBorderColor`
pub fn get_format_border_color(color: BorderColor, format: vk::Format, use_stencil_aspect: bool) -> vk::BorderColor {
    if is_border_color_int(format, use_stencil_aspect) {
        match color {
            BorderColor::OpaqueBlack => vk::BorderColor::INT_OPAQUE_BLACK,
            BorderColor::OpaqueWhite => vk::BorderColor::INT_OPAQUE_WHITE,
            BorderColor::TransparentBlack => vk::BorderColor::INT_TRANSPARENT_BLACK,
            BorderColor::Custom => vk::BorderColor::INT_CUSTOM_EXT,
        }
    } else {
        match color {
            BorderColor::OpaqueBlack => vk::BorderColor::FLOAT_OPAQUE_BLACK,
            BorderColor::OpaqueWhite => vk::BorderColor::FLOAT_OPAQUE_WHITE,
            BorderColor::TransparentBlack => vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            BorderColor::Custom => vk::BorderColor::FLOAT_CUSTOM_EXT,
        }
    }
}

/// `rr::GenericVec4` as a border colour carries it - four 32-bit words read as float, int or uint by the format class.
#[derive(Clone, Copy, Debug, Default, PartialEq)]
pub struct BorderValue(pub [u32; 4]);

/// `getFormatCustomBorderColor`
pub fn get_format_custom_border_color(
    float_value: [f32; 4],
    int_value: [i32; 4],
    format: vk::Format,
    use_stencil_aspect: bool,
) -> BorderValue {
    if is_border_color_int(format, use_stencil_aspect) {
        BorderValue(int_value.map(|value| value as u32))
    } else {
        BorderValue(float_value.map(f32::to_bits))
    }
}

#[derive(Clone, Copy)]
enum BorderSwizzle {
    Zero,
    One,
    Channel(usize),
}

/// `getBorderColorReadSwizzle`
fn border_color_read_swizzle(order: ChannelOrder) -> [BorderSwizzle; 4] {
    use BorderSwizzle::{Channel as C, One, Zero};
    use ChannelOrder::*;

    match order {
        R | sR | D | S => [C(0), Zero, Zero, One],
        A => [Zero, Zero, Zero, C(3)],
        I => [C(0), C(0), C(0), C(0)],
        L => [C(0), C(0), C(0), One],
        LA => [C(0), C(0), C(0), C(3)],
        RG | sRG => [C(0), C(1), Zero, One],
        RA => [C(0), Zero, Zero, C(3)],
        RGB | BGR | sRGB | sBGR => [C(0), C(1), C(2), One],
        RGBA | ARGB | ABGR | BGRA | sRGBA | sBGRA => [C(0), C(1), C(2), C(3)],
        DS => [Zero, Zero, Zero, One],
    }
}

fn signed_range(bits: i32) -> (i32, i32) {
    if bits > 0 {
        ((-(1i64 << (bits - 1))) as i32, ((1i64 << (bits - 1)) - 1) as i32)
    } else {
        (0, 0)
    }
}

fn unsigned_max(bits: i32) -> u32 {
    if bits >= 32 {
        u32::MAX
    } else if bits > 0 {
        ((1u64 << bits) - 1) as u32
    } else {
        0
    }
}

/// `lookupBorder` - the border texel as the float vector a lookup of `format` yields (`sampleTextureBorder`).
pub fn lookup_border(format: TextureFormat, border: &BorderValue) -> [f32; 4] {
    let class = format.type_.channel_class();
    let map = border_color_read_swizzle(format.order);
    let channel_bits = get_channel_bit_depth(format.type_);

    match class {
        TextureChannelClass::FloatingPoint
        | TextureChannelClass::SignedFixedPoint
        | TextureChannelClass::UnsignedFixedPoint => {
            let is_float = class == TextureChannelClass::FloatingPoint;
            let value_min = if class != TextureChannelClass::UnsignedFixedPoint {
                -1.0f32
            } else {
                0.0
            };
            let border_f = border.0.map(f32::from_bits);
            std::array::from_fn(|c| match map[c] {
                BorderSwizzle::Zero => 0.0,
                BorderSwizzle::One => 1.0,
                BorderSwizzle::Channel(ch) => {
                    if is_float {
                        border_f[ch]
                    } else {
                        border_f[ch].clamp(value_min, 1.0)
                    }
                }
            })
        }
        TextureChannelClass::SignedInteger => std::array::from_fn(|c| match map[c] {
            BorderSwizzle::Zero => 0.0,
            BorderSwizzle::One => 1.0,
            BorderSwizzle::Channel(ch) => {
                let (min, max) = signed_range(channel_bits[ch]);
                (border.0[ch] as i32).clamp(min, max) as f32
            }
        }),
        TextureChannelClass::UnsignedInteger => std::array::from_fn(|c| match map[c] {
            BorderSwizzle::Zero => 0.0,
            BorderSwizzle::One => 1.0,
            BorderSwizzle::Channel(ch) => border.0[ch].min(unsigned_max(channel_bits[ch])) as f32,
        }),
        TextureChannelClass::Last => [-1.0; 4],
    }
}

/// `getLookupScaleBias` - the scale and bias that bring the lookup result of a format into the 0..1 range of the render target.
pub fn get_lookup_scale_bias(format: vk::Format, use_stencil_aspect: bool) -> ([f32; 4], [f32; 4]) {
    if !is_compressed_format(format) {
        let tcu_format = map_vk_format(format).expect("an uncompressed sampled format has a tcu format");

        if use_stencil_aspect {
            ([1.0 / 255.0, 1.0, 1.0, 1.0], [0.0; 4])
        } else {
            let info = get_texture_format_info(tcu_format);
            (info.look_up_scale, info.look_up_bias)
        }
    } else {
        match format {
            vk::Format::EAC_R11_SNORM_BLOCK => ([0.5, 1.0, 1.0, 1.0], [0.5, 0.0, 0.0, 0.0]),
            vk::Format::EAC_R11G11_SNORM_BLOCK | vk::Format::BC5_SNORM_BLOCK => {
                ([0.5, 0.5, 1.0, 1.0], [0.5, 0.5, 0.0, 0.0])
            }
            // ASTC HDR blocks decompress to f16, which is normalized to the 0..1 range here.
            vk::Format::ASTC_3X3X3_SFLOAT_BLOCK_EXT
            | vk::Format::ASTC_4X3X3_SFLOAT_BLOCK_EXT
            | vk::Format::ASTC_4X4X3_SFLOAT_BLOCK_EXT
            | vk::Format::ASTC_4X4X4_SFLOAT_BLOCK_EXT
            | vk::Format::ASTC_5X4X4_SFLOAT_BLOCK_EXT
            | vk::Format::ASTC_5X5X4_SFLOAT_BLOCK_EXT
            | vk::Format::ASTC_5X5X5_SFLOAT_BLOCK_EXT
            | vk::Format::ASTC_6X5X5_SFLOAT_BLOCK_EXT
            | vk::Format::ASTC_6X6X5_SFLOAT_BLOCK_EXT
            | vk::Format::ASTC_6X6X6_SFLOAT_BLOCK_EXT => {
                let scale = 1.0 / (65504.0 - (-65504.0));
                ([scale; 4], [65504.0 * scale; 4])
            }
            // All other supported compressed formats need no normalization.
            _ => ([1.0; 4], [0.0; 4]),
        }
    }
}

/// `vk::getImageAspectFlags`
pub fn get_image_aspect_flags(format: TextureFormat) -> vk::ImageAspectFlags {
    let mut flags = vk::ImageAspectFlags::empty();
    if has_depth_component(format.order) {
        flags |= vk::ImageAspectFlags::DEPTH;
    }
    if has_stencil_component(format.order) {
        flags |= vk::ImageAspectFlags::STENCIL;
    }
    if flags.is_empty() {
        vk::ImageAspectFlags::COLOR
    } else {
        flags
    }
}

// ---------------------------------------------------------------------------------------------------------------------------
// Vertex4Tex4 and the quad mosaics (vktPipelineVertexUtil.cpp)
// ---------------------------------------------------------------------------------------------------------------------------

/// `Vertex4Tex4`
#[derive(Clone, Copy, Debug, Default)]
#[repr(C)]
pub struct Vertex4Tex4 {
    pub position: [f32; 4],
    pub tex_coord: [f32; 4],
}

/// `createFullscreenQuad`
pub fn create_fullscreen_quad() -> Vec<Vertex4Tex4> {
    let lower_left = Vertex4Tex4 {
        position: [-1.0, -1.0, 0.0, 1.0],
        tex_coord: [0.0, 0.0, 0.0, 0.0],
    };
    let upper_left = Vertex4Tex4 {
        position: [-1.0, 1.0, 0.0, 1.0],
        tex_coord: [0.0, 1.0, 0.0, 0.0],
    };
    let lower_right = Vertex4Tex4 {
        position: [1.0, -1.0, 0.0, 1.0],
        tex_coord: [1.0, 0.0, 0.0, 0.0],
    };
    let upper_right = Vertex4Tex4 {
        position: [1.0, 1.0, 0.0, 1.0],
        tex_coord: [1.0, 1.0, 0.0, 0.0],
    };

    vec![
        lower_left,
        lower_right,
        upper_left,
        upper_left,
        lower_right,
        upper_right,
    ]
}

/// `createQuadMosaic`
pub fn create_quad_mosaic(rows: u32, columns: u32) -> Vec<Vertex4Tex4> {
    debug_assert!(rows >= 1 && columns >= 1);

    let mut vertices = Vec::new();
    let row_size = 2.0 / rows as f32;
    let column_size = 2.0 / columns as f32;
    let mut array_index = 0u32;

    for row_ndx in 0..rows {
        for column_ndx in 0..columns {
            let ll_x = -1.0 + column_ndx as f32 * column_size;
            let ll_y = -1.0 + row_ndx as f32 * row_size;
            let layer = array_index as f32;
            let lower_left = Vertex4Tex4 {
                position: [ll_x, ll_y, 0.0, 1.0],
                tex_coord: [0.0, 0.0, layer, 0.0],
            };
            let upper_left = Vertex4Tex4 {
                position: [ll_x, ll_y + row_size, 0.0, 1.0],
                tex_coord: [0.0, 1.0, layer, 0.0],
            };
            let lower_right = Vertex4Tex4 {
                position: [ll_x + column_size, ll_y, 0.0, 1.0],
                tex_coord: [1.0, 0.0, layer, 0.0],
            };
            let upper_right = Vertex4Tex4 {
                position: [ll_x + column_size, ll_y + row_size, 0.0, 1.0],
                tex_coord: [1.0, 1.0, layer, 0.0],
            };

            vertices.extend([
                lower_left,
                lower_right,
                upper_left,
                upper_left,
                lower_right,
                upper_right,
            ]);
            array_index += 1;
        }
    }

    vertices
}

/// `createQuadMosaicCube`
pub fn create_quad_mosaic_cube() -> Vec<Vertex4Tex4> {
    const TEX_COORDS_CUBE: [[f32; 3]; 8] = [
        [-1.0, -1.0, -1.0], // 0: -X, -Y, -Z
        [1.0, -1.0, -1.0],  // 1:  X, -Y, -Z
        [1.0, -1.0, 1.0],   // 2:  X, -Y,  Z
        [-1.0, -1.0, 1.0],  // 3: -X, -Y,  Z
        [-1.0, 1.0, -1.0],  // 4: -X,  Y, -Z
        [1.0, 1.0, -1.0],   // 5:  X,  Y, -Z
        [1.0, 1.0, 1.0],    // 6:  X,  Y,  Z
        [-1.0, 1.0, 1.0],   // 7: -X,  Y,  Z
    ];

    const TEX_COORD_CUBE_INDICES: [[usize; 6]; 6] = [
        [6, 5, 2, 2, 5, 1], // +X face
        [3, 0, 7, 7, 0, 4], // -X face
        [4, 5, 7, 7, 5, 6], // +Y face
        [3, 2, 0, 0, 2, 1], // -Y face
        [2, 3, 6, 6, 3, 7], // +Z face
        [0, 1, 4, 4, 1, 5], // -Z face
    ];

    // Create 6 quads and set appropriate texture coordinates for cube mapping
    let mut vertices = create_quad_mosaic(2, 3);
    for quad_ndx in 0..6 {
        for vertex_ndx in 0..6 {
            let coords = TEX_COORDS_CUBE[TEX_COORD_CUBE_INDICES[quad_ndx][vertex_ndx]];
            vertices[quad_ndx * 6 + vertex_ndx].tex_coord[..3].copy_from_slice(&coords);
        }
    }

    vertices
}

/// `createQuadMosaicCubeArray`
pub fn create_quad_mosaic_cube_array(face_array_indices: [i32; 6]) -> Vec<Vertex4Tex4> {
    let mut vertices = create_quad_mosaic_cube();
    for quad_ndx in 0..6 {
        for vertex_ndx in 0..6 {
            vertices[quad_ndx * 6 + vertex_ndx].tex_coord[3] = face_array_indices[quad_ndx] as f32;
        }
    }
    vertices
}

/// `createTestQuadMosaic`
pub fn create_test_quad_mosaic(view_type: vk::ImageViewType) -> Vec<Vertex4Tex4> {
    match view_type {
        vk::ImageViewType::_1D | vk::ImageViewType::_2D => create_fullscreen_quad(),
        vk::ImageViewType::_1D_ARRAY => {
            let mut vertices = create_quad_mosaic(2, 3);

            // Set up array indices
            for quad_ndx in 0..6 {
                for vertex_ndx in 0..6 {
                    vertices[quad_ndx * 6 + vertex_ndx].tex_coord[1] = quad_ndx as f32;
                }
            }
            vertices
        }
        vk::ImageViewType::_2D_ARRAY => create_quad_mosaic(2, 3),
        vk::ImageViewType::_3D => {
            let mut vertices = create_quad_mosaic(2, 3);

            // Use z between 0.0 and 1.0, less a small value that corrects floating-point errors at the boundaries between slices.
            for vertex in vertices.iter_mut() {
                vertex.tex_coord[2] /= 5.0;
                vertex.tex_coord[2] -= 0.001;
            }
            vertices
        }
        vk::ImageViewType::CUBE => create_quad_mosaic_cube(),
        _ => create_quad_mosaic_cube_array([0, 1, 2, 3, 4, 5]),
    }
}

// ---------------------------------------------------------------------------------------------------------------------------
// TestTexture
// ---------------------------------------------------------------------------------------------------------------------------

fn next_multiple(divisor: u32, value: u32) -> u32 {
    if value % divisor == 0 {
        value
    } else {
        value + divisor - (value % divisor)
    }
}

fn next_multiple_of_all(divisors: &[u32], value: u32) -> u32 {
    let mut next = next_multiple(divisors[0], value);
    loop {
        if divisors.iter().all(|divisor| next % divisor == 0) {
            return next;
        }
        next = next_multiple(divisors[0], next + 1);
    }
}

/// Which `TestTexture` subclass a texture is.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum TextureKind {
    Tex1D,
    Tex1DArray,
    Tex2D,
    Tex2DArray,
    Tex3D,
    TexCube,
    TexCubeArray,
}

/// `getCompatibleImageType`
pub fn get_compatible_image_type(view_type: vk::ImageViewType) -> vk::ImageType {
    match view_type {
        vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY => vk::ImageType::_1D,
        vk::ImageViewType::_2D
        | vk::ImageViewType::_2D_ARRAY
        | vk::ImageViewType::CUBE
        | vk::ImageViewType::CUBE_ARRAY => vk::ImageType::_2D,
        _ => vk::ImageType::_3D,
    }
}

struct CompressedStorage {
    format: vk::Format,
    /// `m_compressedLevels`, `level * array_size + layer`
    levels: Vec<Vec<u8>>,
    /// Width, height and depth of each entry of `levels`
    extents: Vec<[u32; 3]>,
}

/// `TestTexture` and its subclasses.
pub struct TestTexture {
    kind: TextureKind,
    format: TextureFormat,
    levels: Vec<TextureLevel>,
    array_size: u32,
    compressed: Option<CompressedStorage>,
}

fn level_size(base: u32, level: usize) -> u32 {
    (base >> level).max(1)
}

fn level_count(size: u32) -> usize {
    size.ilog2() as usize + 1
}

fn subregion<'a>(level: &'a TextureLevel, x: u32, y: u32, z: u32, size: [u32; 3]) -> ConstPixelBufferAccess<'a> {
    let pitch = tight_pitch(level.format(), level.size());
    let offset = x as usize * pitch[0] + y as usize * pitch[1] + z as usize * pitch[2];
    ConstPixelBufferAccess::new_with_pitch(level.format(), size, pitch, &level.data()[offset..])
}

impl TestTexture {
    /// The texture of the constructors that take a `tcu::TextureFormat`: `width`, `height` and `depth_or_layers` as the
    /// subclass wants them, gradient filled. `size` is `(width, height, depth)` of the image, `layers` its array size.
    pub fn new(format: TextureFormat, kind: TextureKind, size: [u32; 3], layers: u32) -> Result<Self, TestError> {
        let mut texture = Self::allocate(format, kind, size, layers)?;
        texture.populate_levels();
        Ok(texture)
    }

    /// The compressed constructors: random blocks decompressed into the levels.
    pub fn new_compressed(
        format: vk::Format,
        kind: TextureKind,
        size: [u32; 3],
        layers: u32,
    ) -> Result<Self, TestError> {
        let uncompressed =
            get_uncompressed_format(format).ok_or_else(|| TestError::NotPorted(format!("decompressing {format:?}")))?;
        if is_astc_hdr_format(format) {
            return Err(TestError::NotPorted(format!("decompressing {format:?} (HDR ASTC)")));
        }
        let mut texture = Self::allocate(uncompressed, kind, size, layers)?;
        texture.populate_compressed_levels(format)?;
        Ok(texture)
    }

    /// `TestTexture2D(format, width, height, voidExtent = true)`: the ASTC void extent blocks of `generateBlockCaseTestData` in every level.
    pub fn new_compressed_void_extent(format: vk::Format, size: [u32; 3]) -> Result<Self, TestError> {
        if !is_astc_format(format) || is_astc_hdr_format(format) || get_block_depth(format) > 1 {
            return Err(TestError::NotPorted(format!("void extent blocks of {format:?}")));
        }
        let uncompressed =
            get_uncompressed_format(format).ok_or_else(|| TestError::NotPorted(format!("decompressing {format:?}")))?;
        let mut texture = Self::allocate(uncompressed, TextureKind::Tex2D, size, 1)?;
        let mut storage = CompressedStorage {
            format,
            levels: Vec::new(),
            extents: Vec::new(),
        };
        for level_ndx in 0..texture.levels.len() {
            let data = crate::tcu::astc::generate_block_case_test_data(
                get_block_width(format) as i32,
                get_block_height(format) as i32,
                crate::tcu::astc::BlockTestType::VoidExtentLdr,
            );
            let extent = texture.levels[level_ndx].size();
            let mut access = texture.levels[level_ndx].get_access();
            if !decompress(&mut access, format, &data) {
                return Err(TestError::NotPorted(format!("decompressing {format:?}")));
            }
            storage.levels.push(data);
            storage.extents.push(extent);
        }
        texture.compressed = Some(storage);
        Ok(texture)
    }

    fn allocate(format: TextureFormat, kind: TextureKind, size: [u32; 3], layers: u32) -> Result<Self, TestError> {
        let [width, height, depth] = size;
        let (num_levels, array_size) = match kind {
            TextureKind::Tex1D => (level_count(width), 1),
            TextureKind::Tex1DArray => (level_count(width), layers),
            TextureKind::Tex2D => (level_count(width.max(height)), 1),
            TextureKind::Tex2DArray => (level_count(width.max(height)), layers),
            TextureKind::Tex3D => (level_count(width.max(height).max(depth)), 1),
            TextureKind::TexCube => (level_count(width), 6),
            TextureKind::TexCubeArray => (level_count(width), layers),
        };

        let mut levels = Vec::with_capacity(num_levels);
        for level in 0..num_levels {
            let w = level_size(width, level);
            let h = level_size(height, level);
            let level_texture = match kind {
                TextureKind::Tex1D => TextureLevel::new(format, w, 1, 1)?,
                TextureKind::Tex1DArray => TextureLevel::new(format, w, layers, 1)?,
                TextureKind::Tex2D => TextureLevel::new(format, w, h, 1)?,
                TextureKind::Tex2DArray => TextureLevel::new(format, w, h, layers)?,
                TextureKind::Tex3D => TextureLevel::new(format, w, h, level_size(depth, level))?,
                TextureKind::TexCube => TextureLevel::new(format, w, w, 6)?,
                TextureKind::TexCubeArray => TextureLevel::new(format, w, w, layers)?,
            };
            levels.push(level_texture);
        }

        Ok(Self {
            kind,
            format,
            levels,
            array_size,
            compressed: None,
        })
    }

    fn fill_with_gradient(access: &mut PixelBufferAccess<'_>) {
        let info = get_texture_format_info(access.format());
        fill_with_component_gradients2(access, info.value_min, info.value_max);
    }

    /// `populateLevels`; a cube is filled one face at a time, as `TestTextureCube`'s constructor does.
    fn populate_levels(&mut self) {
        let kind = self.kind;
        for level in self.levels.iter_mut() {
            let mut access = level.get_access();
            if kind == TextureKind::TexCube {
                let [w, h, _] = access.size();
                for face in 0..6 {
                    let mut face_access = access.get_subregion(0, 0, face, w, h, 1);
                    Self::fill_with_gradient(&mut face_access);
                }
            } else {
                Self::fill_with_gradient(&mut access);
            }
        }
    }

    /// `populateCompressedLevels` over the levels in `level * array_size + layer` order, one random stream (`de::Random(123)`).
    fn populate_compressed_levels(&mut self, format: vk::Format) -> Result<(), TestError> {
        let mut random = Random::new(123);
        let is_astc_sfloat = is_astc_hdr_format(format);
        let block_bytes = get_block_size_in_bytes(format) as usize;
        let per_level_entries = self.array_size_for_compressed();
        let mut storage = CompressedStorage {
            format,
            levels: Vec::new(),
            extents: Vec::new(),
        };

        for level_ndx in 0..self.levels.len() {
            let [w, h, d] = self.levels[level_ndx].size();
            // Every entry covers one layer, except a 3D level which is one entry.
            let entries: Vec<[u32; 3]> = match self.kind {
                TextureKind::Tex1D | TextureKind::Tex2D | TextureKind::Tex3D => vec![[w, h, d]],
                TextureKind::Tex1DArray => (0..per_level_entries).map(|_| [w, 1, 1]).collect(),
                _ => (0..per_level_entries).map(|_| [w, h, 1]).collect(),
            };

            for (entry_ndx, extent) in entries.iter().enumerate() {
                let blocks = (extent[0].div_ceil(get_block_width(format))
                    * extent[1].div_ceil(get_block_height(format))
                    * extent[2].div_ceil(get_block_depth(format))) as usize;
                let mut data = vec![0u8; blocks * block_bytes];

                if is_astc_format(format) {
                    crate::tcu::astc::generate_random_valid_blocks_3d(
                        &mut data,
                        blocks,
                        [
                            get_block_width(format),
                            get_block_height(format),
                            get_block_depth(format),
                        ],
                        is_astc_srgb_format(format),
                        !is_astc_sfloat,
                        random.get_uint32(),
                    );
                } else {
                    for byte in data.iter_mut() {
                        *byte = (random.get_uint32() & 0xFF) as u8;
                    }

                    // BC7 mode 8 (LSB == 0x00) should not be tested as it is underspecified
                    if matches!(format, vk::Format::BC7_UNORM_BLOCK | vk::Format::BC7_SRGB_BLOCK) {
                        for block in data.chunks_mut(block_bytes) {
                            while block[0] == 0x00 {
                                block[0] = (random.get_uint32() & 0xFF) as u8;
                            }
                        }
                    }
                }

                // Store decompressed data
                let mut access = self.levels[level_ndx].get_access();
                let decoded = if matches!(self.kind, TextureKind::Tex1D | TextureKind::Tex2D | TextureKind::Tex3D) {
                    decompress(&mut access, format, &data)
                } else if self.kind == TextureKind::Tex1DArray {
                    let mut layer_access = access.get_subregion(0, entry_ndx as u32, 0, w, 1, 1);
                    decompress(&mut layer_access, format, &data)
                } else {
                    let mut layer_access = access.get_subregion(0, 0, entry_ndx as u32, w, h, 1);
                    decompress(&mut layer_access, format, &data)
                };
                if !decoded {
                    return Err(TestError::NotPorted(format!("decompressing {format:?}")));
                }

                storage.levels.push(data);
                storage.extents.push(*extent);
            }
        }

        self.compressed = Some(storage);
        Ok(())
    }

    fn array_size_for_compressed(&self) -> u32 {
        match self.kind {
            TextureKind::Tex1D | TextureKind::Tex2D | TextureKind::Tex3D => 1,
            _ => self.array_size,
        }
    }

    /// The whole of a mip level, all layers as its depth, writable
    pub fn level_all_layers_mut(&mut self, level: usize) -> PixelBufferAccess<'_> {
        self.levels[level].get_access()
    }

    /// `TestTexture2D(format, width, height, 1)`: only the first `count` levels of the pyramid
    pub fn truncate_levels(&mut self, count: usize) {
        self.levels.truncate(count);
    }

    pub fn kind(&self) -> TextureKind {
        self.kind
    }

    /// `getNumLevels`
    pub fn get_num_levels(&self) -> usize {
        self.levels.len()
    }

    /// `getArraySize`
    pub fn get_array_size(&self) -> u32 {
        match self.kind {
            TextureKind::Tex1D | TextureKind::Tex2D | TextureKind::Tex3D => 1,
            _ => self.array_size,
        }
    }

    /// `getTextureFormat`
    pub fn get_texture_format(&self) -> TextureFormat {
        self.format
    }

    /// `isCompressed`
    pub fn is_compressed(&self) -> bool {
        self.compressed.is_some()
    }

    /// The level with every layer in it, as the lookup verifier's array views read it.
    pub fn level_all_layers(&self, level: usize) -> ConstPixelBufferAccess<'_> {
        self.levels[level].get_const_access()
    }

    /// The access of a level as a 2D array of one-row layers: the 1D array stores its layers as rows, which is
    /// a `w x 1 x layers` access to the verifier.
    pub fn level_as_layers(&self, level: usize) -> ConstPixelBufferAccess<'_> {
        let storage = &self.levels[level];
        let [w, h, d] = storage.size();
        if self.kind == TextureKind::Tex1DArray {
            let pixel = storage
                .format()
                .pixel_size()
                .expect("a texture format has a pixel size") as usize;
            return ConstPixelBufferAccess::new_with_pitch(
                storage.format(),
                [w, 1, h],
                [pixel, pixel * w as usize, pixel * w as usize],
                storage.data(),
            );
        }
        ConstPixelBufferAccess::new_with_pitch(
            storage.format(),
            [w, h, d],
            tight_pitch(storage.format(), storage.size()),
            storage.data(),
        )
    }

    /// `getLevel` - one layer of a mip level (the whole level of a 3D texture).
    pub fn get_level(&self, level: usize, layer: u32) -> ConstPixelBufferAccess<'_> {
        let storage = &self.levels[level];
        let [w, h, _] = storage.size();
        match self.kind {
            TextureKind::Tex1D | TextureKind::Tex2D | TextureKind::Tex3D => storage.get_const_access(),
            TextureKind::Tex1DArray => subregion(storage, 0, layer, 0, [w, 1, 1]),
            _ => subregion(storage, 0, 0, layer, [w, h, 1]),
        }
    }

    pub fn get_level_mut(&mut self, level: usize, layer: u32) -> PixelBufferAccess<'_> {
        let kind = self.kind;
        let storage = &mut self.levels[level];
        let [w, h, _] = storage.size();
        let access = storage.get_access();
        match kind {
            TextureKind::Tex1D | TextureKind::Tex2D | TextureKind::Tex3D => access,
            TextureKind::Tex1DArray => {
                let pitch = access.pitch();
                let offset = layer as usize * pitch[1];
                let format = access.format();
                PixelBufferAccess::new_with_pitch(format, [w, 1, 1], pitch, &mut access.into_raw_mut()[offset..])
            }
            _ => {
                let pitch = access.pitch();
                let offset = layer as usize * pitch[2];
                let format = access.format();
                PixelBufferAccess::new_with_pitch(format, [w, h, 1], pitch, &mut access.into_raw_mut()[offset..])
            }
        }
    }

    fn pixel_size(&self) -> u32 {
        self.format.pixel_size().expect("a texture format has a pixel size")
    }

    /// `getSize`
    pub fn get_size(&self) -> u32 {
        let multiples = [4, self.pixel_size()];
        let mut texture_size = 0u32;

        for level_ndx in 0..self.get_num_levels() {
            for layer_ndx in 0..self.get_array_size() {
                let level = self.get_level(level_ndx, layer_ndx);
                let [w, h, d] = level.size();
                texture_size = next_multiple_of_all(&multiples, texture_size);
                texture_size += w * h * d * self.pixel_size();
            }
        }

        texture_size
    }

    fn compressed_storage(&self) -> Result<&CompressedStorage, TestError> {
        self.compressed
            .as_ref()
            .ok_or_else(|| TestError::InternalError("Texture is not compressed".to_string()))
    }

    /// `getCompressedSize`
    pub fn get_compressed_size(&self) -> Result<u32, TestError> {
        let storage = self.compressed_storage()?;
        let multiples = [4, get_block_size_in_bytes(storage.format)];
        let mut texture_size = 0u32;
        for data in &storage.levels {
            texture_size = next_multiple_of_all(&multiples, texture_size);
            texture_size += data.len() as u32;
        }
        Ok(texture_size)
    }

    /// The bytes `write` puts in the upload buffer, and how large they are.
    pub fn upload_size(&self) -> Result<u32, TestError> {
        if self.is_compressed() {
            self.get_compressed_size()
        } else {
            Ok(self.get_size())
        }
    }

    /// `getBufferCopyRegions`
    pub fn get_buffer_copy_regions(&self) -> Result<Vec<vk::BufferImageCopy>, TestError> {
        let mut regions = Vec::new();
        let mut layer_data_offset = 0u32;

        if let Some(storage) = &self.compressed {
            let multiples = [4, get_block_size_in_bytes(storage.format)];
            let (block_width, block_height) = (get_block_width(storage.format), get_block_height(storage.format));
            let array_size = self.get_array_size();

            for level_ndx in 0..self.get_num_levels() as u32 {
                for layer_ndx in 0..array_size {
                    let index = (level_ndx * array_size + layer_ndx) as usize;
                    let [w, h, d] = storage.extents[index];
                    layer_data_offset = next_multiple_of_all(&multiples, layer_data_offset);

                    regions.push(vk::BufferImageCopy {
                        buffer_offset: u64::from(layer_data_offset),
                        buffer_row_length: next_multiple(block_width, w),
                        buffer_image_height: next_multiple(block_height, h),
                        image_subresource: vk::ImageSubresourceLayers {
                            aspect_mask: vk::ImageAspectFlags::COLOR,
                            mip_level: level_ndx,
                            base_array_layer: layer_ndx,
                            layer_count: 1,
                        },
                        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        image_extent: vk::Extent3D {
                            width: w,
                            height: h,
                            depth: d,
                        },
                    });
                    layer_data_offset += storage.levels[index].len() as u32;
                }
            }
        } else {
            let mut image_aspects = Vec::new();
            if has_depth_component(self.format.order) {
                image_aspects.push(vk::ImageAspectFlags::DEPTH);
            }
            if has_stencil_component(self.format.order) {
                image_aspects.push(vk::ImageAspectFlags::STENCIL);
            }
            if image_aspects.is_empty() {
                image_aspects.push(vk::ImageAspectFlags::COLOR);
            }

            let multiples = [4, self.pixel_size()];

            for level_ndx in 0..self.get_num_levels() as u32 {
                for layer_ndx in 0..self.get_array_size() {
                    let [w, h, d] = self.get_level(level_ndx as usize, layer_ndx).size();
                    layer_data_offset = next_multiple_of_all(&multiples, layer_data_offset);

                    for &aspect in &image_aspects {
                        regions.push(vk::BufferImageCopy {
                            buffer_offset: u64::from(layer_data_offset),
                            buffer_row_length: w,
                            buffer_image_height: h,
                            image_subresource: vk::ImageSubresourceLayers {
                                aspect_mask: aspect,
                                mip_level: level_ndx,
                                base_array_layer: layer_ndx,
                                layer_count: 1,
                            },
                            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                            image_extent: vk::Extent3D {
                                width: w,
                                height: h,
                                depth: d,
                            },
                        });
                    }
                    layer_data_offset += w * h * d * self.pixel_size();
                }
            }
        }

        Ok(regions)
    }

    /// `write`
    pub fn write(&self, dest: &mut [u8]) -> Result<(), TestError> {
        let mut level_offset = 0u32;

        if let Some(storage) = &self.compressed {
            let multiples = [4, get_block_size_in_bytes(storage.format)];
            for data in &storage.levels {
                level_offset = next_multiple_of_all(&multiples, level_offset);
                dest[level_offset as usize..level_offset as usize + data.len()].copy_from_slice(data);
                level_offset += data.len() as u32;
            }
        } else {
            let multiples = [4, self.pixel_size()];
            for level_ndx in 0..self.get_num_levels() {
                for layer_ndx in 0..self.get_array_size() {
                    level_offset = next_multiple_of_all(&multiples, level_offset);
                    let source = self.get_level(level_ndx, layer_ndx);
                    let [w, h, d] = source.size();
                    let pixel = self.pixel_size() as usize;
                    let pitch = source.pitch();
                    let mut at = level_offset as usize;
                    // `tcu::copy` into a tightly packed destination
                    for z in 0..d as usize {
                        for y in 0..h as usize {
                            let from = z * pitch[2] + y * pitch[1];
                            let row = w as usize * pixel;
                            dest[at..at + row].copy_from_slice(&source.raw()[from..from + row]);
                            at += row;
                        }
                    }
                    level_offset += w * h * d * self.pixel_size();
                }
            }
        }

        Ok(())
    }

    /// `copy` into a texture of another format, used for the aspects of combined depth/stencil textures: each texel goes through
    /// the aspect accessors the destination format asks for.
    pub fn copy(&self, format: TextureFormat) -> Result<TestTexture, TestError> {
        if self.is_compressed() {
            return Err(TestError::InternalError("cannot copy a compressed texture".to_string()));
        }

        let size = self.levels[0].size();
        let (create_size, layers) = match self.kind {
            TextureKind::Tex1D => ([size[0], 1, 1], 1),
            TextureKind::Tex1DArray => ([size[0], 1, 1], size[1]),
            TextureKind::Tex2D => ([size[0], size[1], 1], 1),
            TextureKind::Tex2DArray => ([size[0], size[1], 1], size[2]),
            TextureKind::Tex3D => (size, 1),
            TextureKind::TexCube => ([size[0], size[0], 1], 6),
            TextureKind::TexCubeArray => ([size[0], size[0], 1], size[2]),
        };
        let mut texture = Self::allocate(format, self.kind, create_size, layers)?;

        for level_ndx in 0..self.get_num_levels() {
            for layer_ndx in 0..self.get_array_size() {
                let source = self.get_level(level_ndx, layer_ndx);
                let mut destination = texture.get_level_mut(level_ndx, layer_ndx);
                copy_texels(&mut destination, &source);
            }
        }

        Ok(texture)
    }
}

/// `tcu::copy` between two accesses of one size and possibly different formats.
fn copy_texels(dst: &mut PixelBufferAccess<'_>, src: &ConstPixelBufferAccess<'_>) {
    let [width, height, depth] = src.size();
    let dst_format = dst.format();
    let dst_class = dst_format.channel_class();

    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                if dst_format.order == ChannelOrder::D {
                    dst.set_pix_depth(src.get_pix_depth(x, y, z), x, y, z);
                } else if dst_format.order == ChannelOrder::S {
                    dst.set_pix_stencil(src.get_pix_stencil(x, y, z), x, y, z);
                } else if dst_class == TextureChannelClass::SignedInteger
                    || dst_class == TextureChannelClass::UnsignedInteger
                {
                    let _ = dst.set_pixel_int(src.get_pixel_int(x, y, z), x, y, z);
                } else {
                    dst.set_pixel(src.get_pixel(x, y, z), x, y, z);
                }
            }
        }
    }
}

/// `createTestTexture`
pub fn create_test_texture(
    format: vk::Format,
    view_type: vk::ImageViewType,
    size: [i32; 3],
    layer_count: i32,
) -> Result<TestTexture, TestError> {
    let size = size.map(|v| v as u32);
    let layers = layer_count as u32;
    let kind = match get_compatible_image_type(view_type) {
        vk::ImageType::_1D => {
            if layers == 1 {
                TextureKind::Tex1D
            } else {
                TextureKind::Tex1DArray
            }
        }
        vk::ImageType::_2D => {
            if layers == 1 {
                TextureKind::Tex2D
            } else if view_type == vk::ImageViewType::CUBE || view_type == vk::ImageViewType::CUBE_ARRAY {
                if layers == 6 && view_type == vk::ImageViewType::CUBE {
                    TextureKind::TexCube
                } else {
                    TextureKind::TexCubeArray
                }
            } else {
                TextureKind::Tex2DArray
            }
        }
        _ => TextureKind::Tex3D,
    };

    if is_compressed_format(format) {
        TestTexture::new_compressed(format, kind, size, layers)
    } else {
        let tcu_format =
            map_vk_format(format).ok_or_else(|| TestError::NotPorted(format!("no texture format for {format:?}")))?;
        TestTexture::new(tcu_format, kind, size, layers)
    }
}

// ---------------------------------------------------------------------------------------------------------------------------
// uploadTestTexture
// ---------------------------------------------------------------------------------------------------------------------------

/// `copyBufferToImage` (the version that submits) with the access mask of a shader read.
#[allow(clippy::too_many_arguments)]
fn copy_buffer_to_image(
    context: &Context<'_>,
    queue: vk::Queue,
    queue_family_index: u32,
    buffer: vk::Buffer,
    buffer_size: vk::DeviceSize,
    copy_regions: &[vk::BufferImageCopy],
    wait_semaphore: Option<vk::Semaphore>,
    image_aspect_flags: vk::ImageAspectFlags,
    mip_levels: u32,
    array_layers: u32,
    dest_image: vk::Image,
    dest_image_layout: vk::ImageLayout,
    dest_stage_flags: vk::PipelineStageFlags,
) -> Result<(), TestError> {
    let device = context.get_device();
    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let transfer_layout = if dest_image_layout == vk::ImageLayout::GENERAL {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::TRANSFER_DST_OPTIMAL
    };
    let range = vk::ImageSubresourceRange {
        aspect_mask: image_aspect_flags,
        base_mip_level: 0,
        level_count: mip_levels,
        base_array_layer: 0,
        layer_count: array_layers,
    };

    let pre_buffer_barrier = vk::BufferMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::HOST_WRITE)
        .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .buffer(buffer)
        .offset(0)
        .size(buffer_size)
        .build();
    let pre_image_barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::empty())
        .dst_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .old_layout(vk::ImageLayout::UNDEFINED)
        .new_layout(transfer_layout)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(dest_image)
        .subresource_range(range)
        .build();
    let post_image_barrier = vk::ImageMemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::SHADER_READ)
        .old_layout(transfer_layout)
        .new_layout(dest_image_layout)
        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
        .image(dest_image)
        .subresource_range(range)
        .build();

    begin_command_buffer(device, cmd)?;
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[pre_buffer_barrier],
            &[pre_image_barrier],
        );
        device.cmd_copy_buffer_to_image(cmd, buffer, dest_image, transfer_layout, copy_regions);
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            dest_stage_flags,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_image_barrier],
        );
    }
    end_command_buffer(device, cmd)?;

    let wait_semaphores: Vec<vk::Semaphore> = wait_semaphore.into_iter().collect();
    let wait_stages = vec![vk::PipelineStageFlags::TRANSFER; wait_semaphores.len()];
    let cmd_buffers = [cmd];
    let submit_info = vk::SubmitInfo::builder()
        .wait_semaphores(&wait_semaphores)
        .wait_dst_stage_mask(&wait_stages)
        .command_buffers(&cmd_buffers);
    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    unsafe { device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

fn upload_test_texture_internal(
    context: &Context<'_>,
    queue: vk::Queue,
    queue_family_index: u32,
    src_texture: &TestTexture,
    src_stencil_texture: Option<&TestTexture>,
    format: TextureFormat,
    dest_image: vk::Image,
    dest_image_layout: vk::ImageLayout,
    dest_stage_flags: vk::PipelineStageFlags,
) -> Result<(), TestError> {
    let device = context.get_device();
    let image_aspect_flags = get_image_aspect_flags(format);
    let mut stencil_offset = 0u32;
    let mut copy_regions = src_texture.get_buffer_copy_regions()?;
    let mut buffer_size = src_texture.upload_size()?;

    // A stencil-only texture is provided if (and only if) the image has a combined depth/stencil format
    debug_assert_eq!(
        has_depth_component(format.order) && has_stencil_component(format.order),
        src_stencil_texture.is_some()
    );

    if let Some(stencil) = src_stencil_texture {
        stencil_offset = buffer_size.next_multiple_of(4);
        buffer_size = stencil_offset + stencil.get_size();
    }

    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(vk::DeviceSize::from(buffer_size), vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    {
        let host =
            unsafe { std::slice::from_raw_parts_mut(buffer.get_allocation().get_host_ptr(), buffer_size as usize) };
        src_texture.write(host)?;

        if let Some(stencil) = src_stencil_texture {
            debug_assert!(stencil_offset != 0);
            stencil.write(&mut host[stencil_offset as usize..])?;

            for mut region in stencil.get_buffer_copy_regions()? {
                region.buffer_offset += u64::from(stencil_offset);
                copy_regions.push(region);
            }
        }

        flush_alloc(device, buffer.get_allocation())?;
    }

    copy_buffer_to_image(
        context,
        queue,
        queue_family_index,
        buffer.get(),
        vk::DeviceSize::from(buffer_size),
        &copy_regions,
        None,
        image_aspect_flags,
        src_texture.get_num_levels() as u32,
        src_texture.get_array_size(),
        dest_image,
        dest_image_layout,
        dest_stage_flags,
    )
}

/// `uploadTestTextureInternalSparse`: the image is backed with sparse memory first, and the copy waits for the bind.
#[allow(clippy::too_many_arguments)]
fn upload_test_texture_internal_sparse<'a>(
    context: &'a Context<'a>,
    image_create_info: &vk::ImageCreateInfo,
    universal_queue: vk::Queue,
    universal_queue_family_index: u32,
    sparse_queue: vk::Queue,
    allocations: &mut Vec<Allocation<'a>>,
    src_texture: &TestTexture,
    src_stencil_texture: Option<&TestTexture>,
    format: TextureFormat,
    dest_image: vk::Image,
    dest_image_layout: vk::ImageLayout,
    dest_stage_flags: vk::PipelineStageFlags,
) -> Result<(), TestError> {
    let device = context.get_device();
    let mut buffer_size = src_texture.upload_size()?;
    let image_aspect_flags = get_image_aspect_flags(format);
    let mut stencil_offset = 0u32;
    let image_memory_bind_semaphore = Unique::new(
        device,
        unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }.vk_check("vkCreateSemaphore")?,
    );
    let mut copy_regions = src_texture.get_buffer_copy_regions()?;

    debug_assert_eq!(
        has_depth_component(format.order) && has_stencil_component(format.order),
        src_stencil_texture.is_some()
    );

    if let Some(stencil) = src_stencil_texture {
        stencil_offset = buffer_size.next_multiple_of(4);
        buffer_size = stencil_offset + stencil.get_size();
    }

    allocate_and_bind_sparse_image(
        device,
        context.get_instance(),
        context.get_physical_device(),
        image_create_info,
        *image_memory_bind_semaphore,
        sparse_queue,
        context.get_default_allocator(),
        allocations,
        format,
        dest_image,
        vk::Fence::null(),
    )?;

    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(vk::DeviceSize::from(buffer_size), vk::BufferUsageFlags::TRANSFER_SRC),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    {
        let host =
            unsafe { std::slice::from_raw_parts_mut(buffer.get_allocation().get_host_ptr(), buffer_size as usize) };
        src_texture.write(host)?;

        if let Some(stencil) = src_stencil_texture {
            debug_assert!(stencil_offset != 0);
            stencil.write(&mut host[stencil_offset as usize..])?;

            for mut region in stencil.get_buffer_copy_regions()? {
                region.buffer_offset += u64::from(stencil_offset);
                copy_regions.push(region);
            }
        }

        flush_alloc(device, buffer.get_allocation())?;
    }

    copy_buffer_to_image(
        context,
        universal_queue,
        universal_queue_family_index,
        buffer.get(),
        vk::DeviceSize::from(buffer_size),
        &copy_regions,
        Some(*image_memory_bind_semaphore),
        image_aspect_flags,
        image_create_info.mip_levels,
        image_create_info.array_layers,
        dest_image,
        dest_image_layout,
        dest_stage_flags,
    )
}

/// `uploadTestTextureSparse`
#[allow(clippy::too_many_arguments)]
pub fn upload_test_texture_sparse<'a>(
    context: &'a Context<'a>,
    image_create_info: &vk::ImageCreateInfo,
    universal_queue: vk::Queue,
    universal_queue_family_index: u32,
    sparse_queue: vk::Queue,
    allocations: &mut Vec<Allocation<'a>>,
    src_texture: &TestTexture,
    dest_image: vk::Image,
    dest_image_layout: vk::ImageLayout,
    dest_stage_flags: vk::PipelineStageFlags,
) -> Result<(), TestError> {
    let src_format = src_texture.get_texture_format();

    if is_combined_depth_stencil_type(src_format.type_) {
        let mut src_depth_texture = None;
        let mut src_stencil_texture = None;

        if has_depth_component(src_format.order) {
            let format = match src_format.type_ {
                ChannelType::UNSIGNED_INT_16_8_8 => TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16),
                ChannelType::UNSIGNED_INT_24_8_REV => {
                    TextureFormat::new(ChannelOrder::D, ChannelType::UNSIGNED_INT_24_8_REV)
                }
                ChannelType::FLOAT_UNSIGNED_INT_24_8_REV => TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT),
                other => {
                    return Err(TestError::InternalError(format!(
                        "Unexpected source texture format {other:?}"
                    )));
                }
            };
            src_depth_texture = Some(src_texture.copy(format)?);
        }

        if has_stencil_component(src_format.order) {
            src_stencil_texture = Some(src_texture.copy(get_effective_depth_stencil_texture_format(
                src_format,
                DepthStencilMode::Stencil,
            ))?);
        }

        let depth_texture = src_depth_texture
            .ok_or_else(|| TestError::InternalError("a combined format without a depth component".to_string()))?;
        upload_test_texture_internal_sparse(
            context,
            image_create_info,
            universal_queue,
            universal_queue_family_index,
            sparse_queue,
            allocations,
            &depth_texture,
            src_stencil_texture.as_ref(),
            src_format,
            dest_image,
            dest_image_layout,
            dest_stage_flags,
        )
    } else {
        upload_test_texture_internal_sparse(
            context,
            image_create_info,
            universal_queue,
            universal_queue_family_index,
            sparse_queue,
            allocations,
            src_texture,
            None,
            src_format,
            dest_image,
            dest_image_layout,
            dest_stage_flags,
        )
    }
}

/// `uploadTestTexture`
pub fn upload_test_texture(
    context: &Context<'_>,
    queue: vk::Queue,
    queue_family_index: u32,
    src_texture: &TestTexture,
    dest_image: vk::Image,
    dest_image_layout: vk::ImageLayout,
    dest_stage_flags: vk::PipelineStageFlags,
) -> Result<(), TestError> {
    let src_format = src_texture.get_texture_format();

    if is_combined_depth_stencil_type(src_format.type_) {
        let mut src_depth_texture = None;
        let mut src_stencil_texture = None;

        if has_depth_component(src_format.order) {
            let format = match src_format.type_ {
                ChannelType::UNSIGNED_INT_16_8_8 => TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16),
                ChannelType::UNSIGNED_INT_24_8_REV => {
                    TextureFormat::new(ChannelOrder::D, ChannelType::UNSIGNED_INT_24_8_REV)
                }
                ChannelType::FLOAT_UNSIGNED_INT_24_8_REV => TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT),
                other => {
                    return Err(TestError::InternalError(format!(
                        "Unexpected source texture format {other:?}"
                    )));
                }
            };
            src_depth_texture = Some(src_texture.copy(format)?);
        }

        if has_stencil_component(src_format.order) {
            src_stencil_texture = Some(src_texture.copy(get_effective_depth_stencil_texture_format(
                src_format,
                DepthStencilMode::Stencil,
            ))?);
        }

        let depth_texture = src_depth_texture
            .ok_or_else(|| TestError::InternalError("a combined format without a depth component".to_string()))?;
        upload_test_texture_internal(
            context,
            queue,
            queue_family_index,
            &depth_texture,
            src_stencil_texture.as_ref(),
            src_format,
            dest_image,
            dest_image_layout,
            dest_stage_flags,
        )
    } else {
        upload_test_texture_internal(
            context,
            queue,
            queue_family_index,
            src_texture,
            None,
            src_format,
            dest_image,
            dest_image_layout,
            dest_stage_flags,
        )
    }
}
