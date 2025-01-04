// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureFilteringTests.cpp (Texture2DFilteringTestInstance, `checkTextureSupport` for 2D, populateTextureFilteringTests' 2d group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the `2d` (formats, sizes, combinations), `unnormal`, `cube`, `2d_array` and `3d` groups are ported. The reference sampler has no
// stencil view of a combined depth/stencil format, so the stencil aspect cases sample a stencil-only copy of the levels (`reference_texture_*_stencil`). The four filter cases run in one `iterate` instead of
// one per call.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::test_util::{
    Program, QUAD_POSITIONS, RenderRequest, SamplerParams, ShaderParameters, TexKind, pixels_to_surface,
    reference_texture_2d, reference_texture_2d_array, reference_texture_2d_array_stencil, reference_texture_2d_stencil,
    reference_texture_3d, reference_texture_3d_stencil, reference_texture_cube, reference_texture_cube_stencil,
    render_quad_2d,
};
use crate::generated::shaders::texture_swizzle::{
    TSW_2D_ARRAY_FLOAT_NONE, TSW_2D_ARRAY_UINT_NONE, TSW_2D_FLOAT_NONE, TSW_2D_FLOAT_UNNORMAL, TSW_2D_UINT_NONE,
    TSW_2D_UINT_UNNORMAL, TSW_3D_FLOAT_NONE, TSW_3D_UINT_NONE, TSW_CUBE_FLOAT_NONE, TSW_CUBE_UINT_NONE,
};
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, SamplerType, TextureType, compute_quad_tex_coord_2d, get_sampler_type,
};
use crate::glu::texture_test_util_surface::{
    compute_fixed_point_threshold, compute_quad_tex_coord_cube_region, get_bits_vec, get_compare_mask,
    verify_texture_result_2d, verify_texture_result_2d_array, verify_texture_result_3d, verify_texture_result_cube,
};
use crate::tcu::pixel::{
    CompareMode, CubeFace, DepthStencilMode, FilterMode, MipmapFilterMode, PixelBufferAccess, Sampler, WrapMode,
    fill_with_component_gradients2, fill_with_grid, get_texture_format_info, into_effective_depth_stencil_access,
};
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision};
use crate::tcu::texture::TextureChannelClass;
use crate::tcu::{
    ChannelOrder, ChannelType, PixelFormat, TestError, TestOutcome, TestStatus, TextureFormat, Vec2, Vec4,
    map_vk_format,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::pipeline::image_util::create_test_texture;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const TEX2D_VIEWPORT_WIDTH: u32 = 64;
const TEX2D_VIEWPORT_HEIGHT: u32 = 64;
const TEXCUBE_VIEWPORT_SIZE: u32 = 28;

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Filter {
    Nearest,
    Linear,
    Cubic,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Mip {
    None,
    Nearest,
    Linear,
}

/// A `tcu::Sampler::FilterMode` of the min filter: the filter and its mipmap mode
#[derive(Clone, Copy, Debug)]
struct MinFilter {
    name: &'static str,
    filter: Filter,
    mip: Mip,
}

const fn min_filter(name: &'static str, filter: Filter, mip: Mip) -> MinFilter {
    MinFilter { name, filter, mip }
}

const MIN_FILTER_MODES_2D: &[MinFilter] = &[
    min_filter("nearest", Filter::Nearest, Mip::None),
    min_filter("linear", Filter::Linear, Mip::None),
    min_filter("cubic", Filter::Cubic, Mip::None),
    min_filter("nearest_mipmap_nearest", Filter::Nearest, Mip::Nearest),
    min_filter("linear_mipmap_nearest", Filter::Linear, Mip::Nearest),
    min_filter("nearest_mipmap_linear", Filter::Nearest, Mip::Linear),
    min_filter("linear_mipmap_linear", Filter::Linear, Mip::Linear),
    min_filter("cubic_mipmap_nearest", Filter::Cubic, Mip::Nearest),
    min_filter("cubic_mipmap_linear", Filter::Cubic, Mip::Linear),
];

const MAG_FILTER_MODES_2D: &[(&str, Filter)] = &[
    ("nearest", Filter::Nearest),
    ("linear", Filter::Linear),
    ("cubic", Filter::Cubic),
];

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Wrap {
    Repeat,
    MirroredRepeat,
    ClampToEdge,
    ClampToBorder,
    MirroredOnce,
}

const WRAP_MODES: &[(&str, Wrap)] = &[
    ("repeat", Wrap::Repeat),
    ("mirrored_repeat", Wrap::MirroredRepeat),
    ("clamp_to_edge", Wrap::ClampToEdge),
    ("clamp_to_border", Wrap::ClampToBorder),
    ("mirror_clamp_to_edge", Wrap::MirroredOnce),
];

const SIZES_2D: &[(u32, u32)] = &[(4, 8), (32, 64), (128, 128), (3, 7), (31, 55), (127, 99)];

const FILTERABLE_FORMATS: &[(&str, vk::Format, vk::ImageAspectFlags, Program)] = &[
    (
        "r16g16b16a16_sfloat",
        vk::Format::R16G16B16A16_SFLOAT,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "b10g11r11_ufloat",
        vk::Format::B10G11R11_UFLOAT_PACK32,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "e5b9g9r9_ufloat",
        vk::Format::E5B9G9R9_UFLOAT_PACK32,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "r8g8b8a8_unorm",
        vk::Format::R8G8B8A8_UNORM,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "r8g8b8a8_snorm",
        vk::Format::R8G8B8A8_SNORM,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "r5g6b5_unorm",
        vk::Format::R5G6B5_UNORM_PACK16,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "r10x6g10x6b10x6a10x6_unorm",
        vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "r4g4b4a4_unorm",
        vk::Format::R4G4B4A4_UNORM_PACK16,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "a4r4g4b4_unorm",
        vk::Format::A4R4G4B4_UNORM_PACK16,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "a4b4g4r4_unorm",
        vk::Format::A4B4G4R4_UNORM_PACK16,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "r5g5b5a1_unorm",
        vk::Format::R5G5B5A1_UNORM_PACK16,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "a8b8g8r8_srgb",
        vk::Format::A8B8G8R8_SRGB_PACK32,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "a1r5g5b5_unorm",
        vk::Format::A1R5G5B5_UNORM_PACK16,
        vk::ImageAspectFlags::COLOR,
        Program::Float2D,
    ),
    (
        "s8_uint",
        vk::Format::S8_UINT,
        vk::ImageAspectFlags::STENCIL,
        Program::Uint2D,
    ),
    (
        "d24_unorm_s8_uint_stencil",
        vk::Format::D24_UNORM_S8_UINT,
        vk::ImageAspectFlags::STENCIL,
        Program::Uint2D,
    ),
    (
        "d32_sfloat_s8_uint_stencil",
        vk::Format::D32_SFLOAT_S8_UINT,
        vk::ImageAspectFlags::STENCIL,
        Program::Uint2D,
    ),
];

/// `Texture2DTestCaseParameters` as the 2D filtering group sets it (always with mipmaps)
#[derive(Clone, Copy)]
struct FilterParameters {
    format: vk::Format,
    min_filter: MinFilter,
    mag_filter: Filter,
    wrap_s: Wrap,
    wrap_t: Wrap,
    width: u32,
    height: u32,
    aspect_mask: vk::ImageAspectFlags,
    program: Program,
    use_compute: bool,
    unnormal: bool,
    mipmaps: bool,
}

impl FilterParameters {
    /// What the reference sampler or the stencil view of a combined format cannot do yet
    fn not_ported(&self) -> Option<&'static str> {
        None
    }

    fn uses_cubic(&self) -> bool {
        self.min_filter.filter == Filter::Cubic || self.mag_filter == Filter::Cubic
    }
}

/// `texFormat.order == DS && aspectMask == STENCIL`: the lookups read the stencil aspect of a combined depth/stencil format
fn is_stencil_aspect(aspect_mask: vk::ImageAspectFlags, format: TextureFormat) -> bool {
    aspect_mask == vk::ImageAspectFlags::STENCIL && format.order == ChannelOrder::DS
}

/// `cBias`/`cScale` of a texture: the `S8_UINT` range for a stencil aspect, the format's own otherwise
fn bias_and_scale(format_info: &crate::tcu::pixel::TextureFormatInfo, stencil: bool) -> ([f32; 4], [f32; 4]) {
    let info = if stencil {
        get_texture_format_info(TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8))
    } else {
        *format_info
    };
    (
        info.value_min,
        std::array::from_fn(|c| info.value_max[c] - info.value_min[c]),
    )
}

/// `fillWithComponentGradients` on the level, or on its stencil aspect
fn fill_level_gradients(stencil: bool, level: PixelBufferAccess<'_>, g_min: [f32; 4], g_max: [f32; 4]) {
    let mut view = if stencil {
        into_effective_depth_stencil_access(level, DepthStencilMode::Stencil)
    } else {
        level
    };
    fill_with_component_gradients2(&mut view, g_min, g_max);
}

/// `fillWithGrid` on the level, or on its stencil aspect
fn fill_level_grid(stencil: bool, level: PixelBufferAccess<'_>, cell_size: u32, color_a: [f32; 4], color_b: [f32; 4]) {
    let mut view = if stencil {
        into_effective_depth_stencil_access(level, DepthStencilMode::Stencil)
    } else {
        level
    };
    fill_with_grid(&mut view, cell_size, color_a, color_b);
}

/// `verifierCanBeUsed`
fn verifier_can_be_used(format: vk::Format, min: MinFilter, mag: Filter) -> bool {
    let Some(texture_format) = map_vk_format(format) else {
        return true;
    };
    let class = texture_format.type_.channel_class();
    let float_class = matches!(
        class,
        TextureChannelClass::UnsignedFixedPoint
            | TextureChannelClass::SignedFixedPoint
            | TextureChannelClass::FloatingPoint
    );
    float_class
        || !(matches!(min.filter, Filter::Linear | Filter::Cubic) || matches!(mag, Filter::Linear | Filter::Cubic))
}

fn shared_program(program: Program, unnormal: bool) -> &'static SharedProgram {
    match (program, unnormal) {
        (Program::UintCube, _) => &TSW_CUBE_UINT_NONE,
        (Program::FloatCube, _) => &TSW_CUBE_FLOAT_NONE,
        (Program::Uint2DArray, _) => &TSW_2D_ARRAY_UINT_NONE,
        (Program::Float2DArray, _) => &TSW_2D_ARRAY_FLOAT_NONE,
        (Program::Uint3D, _) => &TSW_3D_UINT_NONE,
        (Program::Float3D, _) => &TSW_3D_FLOAT_NONE,
        (Program::Uint2D, false) => &TSW_2D_UINT_NONE,
        (Program::Uint2D, true) => &TSW_2D_UINT_UNNORMAL,
        (_, false) => &TSW_2D_FLOAT_NONE,
        (_, true) => &TSW_2D_FLOAT_UNNORMAL,
    }
}

fn vk_filter(filter: Filter) -> vk::Filter {
    match filter {
        Filter::Nearest => vk::Filter::NEAREST,
        Filter::Linear => vk::Filter::LINEAR,
        Filter::Cubic => vk::Filter::CUBIC_EXT,
    }
}

fn vk_wrap(wrap: Wrap) -> vk::SamplerAddressMode {
    match wrap {
        Wrap::Repeat => vk::SamplerAddressMode::REPEAT,
        Wrap::MirroredRepeat => vk::SamplerAddressMode::MIRRORED_REPEAT,
        Wrap::ClampToEdge => vk::SamplerAddressMode::CLAMP_TO_EDGE,
        Wrap::ClampToBorder => vk::SamplerAddressMode::CLAMP_TO_BORDER,
        Wrap::MirroredOnce => vk::SamplerAddressMode::MIRROR_CLAMP_TO_EDGE,
    }
}

fn tcu_wrap(wrap: Wrap) -> Option<WrapMode> {
    match wrap {
        Wrap::Repeat => Some(WrapMode::Repeat),
        Wrap::MirroredRepeat => Some(WrapMode::MirroredRepeat),
        Wrap::ClampToEdge => Some(WrapMode::ClampToEdge),
        Wrap::ClampToBorder => Some(WrapMode::ClampToBorder),
        Wrap::MirroredOnce => Some(WrapMode::MirroredOnce),
    }
}

fn tcu_filter(filter: Filter) -> FilterMode {
    match filter {
        Filter::Nearest => FilterMode::Nearest,
        Filter::Linear => FilterMode::Linear,
        Filter::Cubic => FilterMode::Cubic,
    }
}

struct FilteringCase {
    name: String,
    params: FilterParameters,
}

impl TestCase for FilteringCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkTextureSupport(Context&, const Texture2DTestCaseParameters&)`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        if params.uses_cubic() {
            context.require_device_functionality("VK_EXT_filter_cubic")?;

            // check if image format supports cubic filtering
            let view_info = vk::PhysicalDeviceImageViewImageFormatInfoEXT {
                image_view_type: vk::ImageViewType::_2D,
                ..Default::default()
            };
            let mut format_info = vk::PhysicalDeviceImageFormatInfo2::default();
            format_info.next = std::ptr::addr_of!(view_info).cast();
            format_info.format = params.format;
            format_info.type_ = vk::ImageType::_2D;
            format_info.tiling = vk::ImageTiling::OPTIMAL;
            format_info.usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST;

            let mut cubic_properties = vk::FilterCubicImageViewImageFormatPropertiesEXT::default();
            let mut format_properties = vk::ImageFormatProperties2::default();
            format_properties.next = std::ptr::addr_of_mut!(cubic_properties).cast();
            match unsafe {
                context.get_instance().get_physical_device_image_format_properties2(
                    context.get_physical_device(),
                    &format_info,
                    &mut format_properties,
                )
            } {
                Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                    return Err(TestError::NotSupported("Image format not supported".to_string()));
                }
                other => {
                    crate::vk::VkResultExt::vk_check(other, "vkGetPhysicalDeviceImageFormatProperties2")?;
                }
            }
            if cubic_properties.filter_cubic == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Image format does not support cubic filtering".to_string(),
                ));
            }

            let format_props = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), params.format)
            };
            if !format_props
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::SAMPLED_IMAGE_FILTER_CUBIC_EXT)
            {
                return Err(TestError::NotSupported(
                    "Format properties do not support cubic filtering feature".to_string(),
                ));
            }
        }

        if params.wrap_s == Wrap::MirroredOnce || params.wrap_t == Wrap::MirroredOnce {
            context.require_device_functionality("VK_KHR_sampler_mirror_clamp_to_edge")?;
        }

        if params.format == vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16 {
            let mut rgba10x6 = vk::PhysicalDeviceRGBA10X6FormatsFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut rgba10x6);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if rgba10x6.format_rgba10x6_without_y_cb_cr_sampler == vk::FALSE {
                return Err(TestError::NotSupported(
                    "formatRgba10x6WithoutYCbCrSampler not supported".to_string(),
                ));
            }
        }

        if let Some(reason) = params.not_ported() {
            return Err(TestError::NotPorted(reason.to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        shared_program(self.params.program, self.params.unnormal).programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FilteringInstance {
            context,
            params: self.params,
        })
    }

    fn is_stub(&self) -> bool {
        self.params.not_ported().is_some()
    }
}

struct FilteringInstance<'a> {
    context: &'a Context<'a>,
    params: FilterParameters,
}

/// One of the four filter cases: texture index and the quad's texture coordinate range
struct FilterCase {
    texture_index: usize,
    min_coord: Vec2,
    max_coord: Vec2,
}

impl TestInstance for FilteringInstance<'_> {
    /// `Texture2DFilteringTestInstance`'s constructor and `iterate`, every filter case in turn
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let min_filter = params.min_filter;
        let is_mipmap = min_filter.mip != Mip::None;

        let mut textures = [
            create_test_texture(
                params.format,
                vk::ImageViewType::_2D,
                [params.width as i32, params.height as i32, 1],
                1,
            )?,
            create_test_texture(
                params.format,
                vk::ImageViewType::_2D,
                [params.width as i32, params.height as i32, 1],
                1,
            )?,
        ];
        if !params.mipmaps {
            for texture in textures.iter_mut() {
                texture.truncate_levels(1);
            }
        }
        let tex_format = textures[0].get_texture_format();
        let format_info = get_texture_format_info(tex_format);
        let is_stencil = is_stencil_aspect(params.aspect_mask, tex_format);
        let (c_bias, c_scale) = bias_and_scale(&format_info, is_stencil);
        let num_levels = textures[0].get_num_levels();

        // Fill first gradient texture.
        for level in 0..num_levels {
            let g_min: [f32; 4] = std::array::from_fn(|c| [0.0, 0.0, 0.0, 1.0][c] * c_scale[c] + c_bias[c]);
            let g_max: [f32; 4] = std::array::from_fn(|c| [1.0, 1.0, 1.0, 0.0][c] * c_scale[c] + c_bias[c]);
            fill_level_gradients(is_stencil, textures[0].get_level_mut(level, 0), g_min, g_max);
        }

        // Fill second with grid texture.
        for level in 0..num_levels {
            let step = 0x00ff_ffffu32 / num_levels as u32;
            let rgb = step * level as u32;
            let color = |packed: u32| -> [f32; 4] {
                std::array::from_fn(|c| {
                    (if c == 3 {
                        255.0
                    } else {
                        ((packed >> (8 * c)) & 0xFF) as f32
                    }) / 255.0
                        * c_scale[c]
                        + c_bias[c]
                })
            };
            fill_level_grid(
                is_stencil,
                textures[1].get_level_mut(level, 0),
                4,
                color(0xff00_0000 | rgb),
                color(0xff00_0000 | !rgb),
            );
        }

        // Compute cases.
        let mut cases = Vec::new();
        for &(tex_ndx, lod_x, lod_y, o_x, o_y) in &[
            (0usize, 1.6f32, 2.9f32, -1.0f32, -2.7f32),
            (0, -2.0, -1.35, -0.2, 0.7),
            (1, 0.14, 0.275, -1.5, -1.1),
            (1, -0.92, -2.64, 0.4, -0.1),
        ] {
            let s_x = lod_x.exp2() * TEX2D_VIEWPORT_WIDTH as f32 / params.width as f32;
            let s_y = lod_y.exp2() * TEX2D_VIEWPORT_HEIGHT as f32 / params.height as f32;
            cases.push(FilterCase {
                texture_index: tex_ndx,
                min_coord: Vec2::new(o_x, o_y),
                max_coord: Vec2::new(o_x + s_x, o_y + s_y),
            });
        }

        let (Some(wrap_s), Some(wrap_t)) = (tcu_wrap(params.wrap_s), tcu_wrap(params.wrap_t)) else {
            return Err(TestError::NotPorted("MIRRORED_ONCE reference sampling".to_string()));
        };
        let border_color = if params.aspect_mask == vk::ImageAspectFlags::STENCIL {
            vk::BorderColor::INT_TRANSPARENT_BLACK
        } else {
            vk::BorderColor::FLOAT_TRANSPARENT_BLACK
        };
        let sampler = SamplerParams {
            wrap_u: vk_wrap(params.wrap_s),
            wrap_v: vk_wrap(params.wrap_t),
            wrap_w: vk_wrap(params.wrap_s),
            min_filter: vk_filter(min_filter.filter),
            mag_filter: vk_filter(params.mag_filter),
            mipmap_mode: if min_filter.mip == Mip::Linear {
                vk::SamplerMipmapMode::LINEAR
            } else {
                vk::SamplerMipmapMode::NEAREST
            },
            min_lod: 0.0,
            max_lod: if params.unnormal {
                0.0
            } else if is_mipmap {
                1000.0
            } else {
                0.25
            },
            border_color,
            compare_op: None,
            unnormalized: params.unnormal,
            non_seamless: false,
            max_anisotropy: None,
        };

        for current in &cases {
            let texture = &textures[current.texture_index];
            let tex_format = texture.get_texture_format();
            let format_info = get_texture_format_info(tex_format);

            // Setup params for reference.
            let tcu_sampler = Sampler {
                wrap_s,
                wrap_t,
                wrap_r: wrap_s,
                filter: tcu_filter(min_filter.filter),
                normalized_coords: !params.unnormal,
                compare: CompareMode::None,
                compare_channel: 0,
                mip_filter: match min_filter.mip {
                    Mip::None => None,
                    Mip::Nearest => Some(MipmapFilterMode::Nearest),
                    Mip::Linear => Some(MipmapFilterMode::Linear),
                },
                seamless_cube_map: true,
            };
            let mut ref_params = ReferenceParams::new(TextureType::Texture2D, tcu_sampler, LodMode::Exact);
            ref_params.mag_filter = Some(tcu_filter(params.mag_filter));
            ref_params.base.sampler_type = if is_stencil {
                SamplerType::Uint
            } else {
                get_sampler_type(tex_format)
            };
            ref_params.base.color_bias = Vec4::new(
                format_info.look_up_bias[0],
                format_info.look_up_bias[1],
                format_info.look_up_bias[2],
                format_info.look_up_bias[3],
            );
            ref_params.base.color_scale = Vec4::new(
                format_info.look_up_scale[0],
                format_info.look_up_scale[1],
                format_info.look_up_scale[2],
                format_info.look_up_scale[3],
            );

            // Compute texture coordinates.
            log::info!(
                "Texture coordinates: {:?} -> {:?}",
                (current.min_coord.x(), current.min_coord.y()),
                (current.max_coord.x(), current.max_coord.y())
            );
            let tex_coord = compute_quad_tex_coord_2d(current.min_coord, current.max_coord);

            let program = match ref_params.base.sampler_type {
                SamplerType::Float => Program::Float2D,
                SamplerType::Int => Program::Int2D,
                SamplerType::Uint => Program::Uint2D,
                other => return Err(TestError::NotPorted(format!("2D program for sampler type {other:?}"))),
            };
            let request = RenderRequest {
                texture,
                format: params.format,
                aspect_mask: params.aspect_mask,
                component_mapping: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                use_compute: params.use_compute,
                sparse: false,
                width: TEX2D_VIEWPORT_WIDTH,
                height: TEX2D_VIEWPORT_HEIGHT,
                tex_width: params.width,
                tex_height: params.height,
                tex_depth: 1,
                kind: TexKind::D2,
                sampler,
                tex_coord: &tex_coord,
                positions: QUAD_POSITIONS,
                view_levels: None,
                view_min_lod: None,
                output_format: vk::Format::R8G8B8A8_UNORM,
                program,
                parameters: ShaderParameters {
                    bias: ref_params.base.bias,
                    reference: ref_params.base.ref_,
                    color_scale: format_info.look_up_scale,
                    color_bias: format_info.look_up_bias,
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, TEX2D_VIEWPORT_WIDTH, TEX2D_VIEWPORT_HEIGHT);

            let is_nearest_only = min_filter.filter == Filter::Nearest
                && min_filter.mip == Mip::None
                && params.mag_filter == Filter::Nearest;
            let pixel_format = PixelFormat::new(8, 8, 8, 8);
            let reduction = if is_nearest_only { 1 } else { 2 };
            let color_bits = get_bits_vec(pixel_format).map(|bits| (bits - reduction).max(0)); // 1 inaccurate bit if nearest only, 2 otherwise
            let threshold = compute_fixed_point_threshold(color_bits);
            let scale = format_info.look_up_scale;
            let mut lod_precision = LodPrecision {
                derivate_bits: 18,
                lod_bits: 6,
            };
            let mut lookup_precision = LookupPrecision {
                color_threshold: std::array::from_fn(|c| threshold[c] / scale[c]),
                coord_bits: [20, 20, 0],
                uvw_bits: [7, 7, 0],
                color_mask: get_compare_mask(pixel_format),
                ..LookupPrecision::default()
            };

            let reference = if is_stencil {
                reference_texture_2d_stencil(texture, params.width, params.height)
            } else {
                reference_texture_2d(texture, params.width, params.height)
            };
            let is_high_quality = verify_texture_result_2d(
                &rendered,
                &reference,
                tex_coord,
                &ref_params,
                &lookup_precision,
                &lod_precision,
                pixel_format,
            )?;
            if !is_high_quality {
                // Evaluate against lower precision requirements.
                lod_precision.lod_bits = 4;
                lookup_precision.uvw_bits = [4, 4, 0];
                log::info!(
                    "Warning: Verification against high precision requirements failed, trying with lower requirements."
                );

                let is_ok = verify_texture_result_2d(
                    &rendered,
                    &reference,
                    tex_coord,
                    &ref_params,
                    &lookup_precision,
                    &lod_precision,
                    pixel_format,
                )?;
                if !is_ok {
                    log::info!("ERROR: Verification against low precision requirements failed, failing test case.");
                    return Ok(TestStatus::fail("Image verification failed"));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

const MIN_FILTER_MODES_3D: &[MinFilter] = &[
    min_filter("nearest", Filter::Nearest, Mip::None),
    min_filter("linear", Filter::Linear, Mip::None),
    min_filter("nearest_mipmap_nearest", Filter::Nearest, Mip::Nearest),
    min_filter("linear_mipmap_nearest", Filter::Linear, Mip::Nearest),
    min_filter("nearest_mipmap_linear", Filter::Nearest, Mip::Linear),
    min_filter("linear_mipmap_linear", Filter::Linear, Mip::Linear),
];

const MAG_FILTER_MODES_3D: &[(&str, Filter)] = &[("nearest", Filter::Nearest), ("linear", Filter::Linear)];

const SIZES_3D: &[(u32, u32, u32)] = &[(4, 8, 8), (32, 64, 16), (128, 32, 64), (3, 7, 5), (63, 63, 63)];

/// `Texture3DTestCaseParameters` as the 3D filtering group sets it
#[derive(Clone, Copy)]
struct Filter3DParameters {
    format: vk::Format,
    min_filter: MinFilter,
    mag_filter: Filter,
    wrap_s: Wrap,
    wrap_t: Wrap,
    wrap_r: Wrap,
    width: u32,
    height: u32,
    depth: u32,
    aspect_mask: vk::ImageAspectFlags,
    program: Program,
    use_compute: bool,
}

impl Filter3DParameters {
    fn not_ported(&self) -> Option<&'static str> {
        None
    }
}

struct Filtering3DCase {
    name: String,
    params: Filter3DParameters,
}

impl TestCase for Filtering3DCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkTextureSupport(Context&, const Texture3DTestCaseParameters&)`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        if [params.wrap_s, params.wrap_t, params.wrap_r].contains(&Wrap::MirroredOnce) {
            context.require_device_functionality("VK_KHR_sampler_mirror_clamp_to_edge")?;
        }
        if params.format == vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16 {
            let mut rgba10x6 = vk::PhysicalDeviceRGBA10X6FormatsFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut rgba10x6);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if rgba10x6.format_rgba10x6_without_y_cb_cr_sampler == vk::FALSE {
                return Err(TestError::NotSupported(
                    "formatRgba10x6WithoutYCbCrSampler not supported".to_string(),
                ));
            }
        }
        if let Some(reason) = params.not_ported() {
            return Err(TestError::NotPorted(reason.to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        shared_program(self.params.program, false).programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(Filtering3DInstance {
            context,
            params: self.params,
        })
    }

    fn is_stub(&self) -> bool {
        self.params.not_ported().is_some()
    }
}

struct Filtering3DInstance<'a> {
    context: &'a Context<'a>,
    params: Filter3DParameters,
}

impl TestInstance for Filtering3DInstance<'_> {
    /// `Texture3DFilteringTestInstance`'s constructor and `iterate`, every filter case in turn
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let min_filter = params.min_filter;
        let is_mipmap = min_filter.mip != Mip::None;
        let size = [params.width as i32, params.height as i32, params.depth as i32];

        let mut textures = [
            create_test_texture(params.format, vk::ImageViewType::_3D, size, 1)?,
            create_test_texture(params.format, vk::ImageViewType::_3D, size, 1)?,
        ];
        let tex_format = textures[0].get_texture_format();
        let format_info = get_texture_format_info(tex_format);
        let is_stencil = is_stencil_aspect(params.aspect_mask, tex_format);
        let (c_bias, c_scale) = bias_and_scale(&format_info, is_stencil);
        let num_levels = textures[0].get_num_levels();

        // Fill first gradient texture.
        for level in 0..num_levels {
            let g_min: [f32; 4] = std::array::from_fn(|c| [0.0, 0.0, 0.0, 1.0][c] * c_scale[c] + c_bias[c]);
            let g_max: [f32; 4] = std::array::from_fn(|c| [1.0, 1.0, 1.0, 0.0][c] * c_scale[c] + c_bias[c]);
            fill_level_gradients(is_stencil, textures[0].get_level_mut(level, 0), g_min, g_max);
        }

        // Fill second with grid texture.
        for level in 0..num_levels {
            let step = 0x00ff_ffffu32 / num_levels as u32;
            let rgb = step * level as u32;
            let color = |packed: u32| -> [f32; 4] {
                std::array::from_fn(|c| {
                    (if c == 3 {
                        255.0
                    } else {
                        ((packed >> (8 * c)) & 0xFF) as f32
                    }) / 255.0
                        * c_scale[c]
                        + c_bias[c]
                })
            };
            fill_level_grid(
                is_stencil,
                textures[1].get_level_mut(level, 0),
                4,
                color(0xff00_0000 | rgb),
                color(0xff00_0000 | !rgb),
            );
        }

        let (Some(wrap_s), Some(wrap_t), Some(wrap_r)) = (
            tcu_wrap(params.wrap_s),
            tcu_wrap(params.wrap_t),
            tcu_wrap(params.wrap_r),
        ) else {
            return Err(TestError::NotPorted("MIRRORED_ONCE reference sampling".to_string()));
        };
        let border_color = if params.aspect_mask == vk::ImageAspectFlags::STENCIL {
            vk::BorderColor::INT_TRANSPARENT_BLACK
        } else {
            vk::BorderColor::FLOAT_TRANSPARENT_BLACK
        };
        let sampler = SamplerParams {
            wrap_u: vk_wrap(params.wrap_s),
            wrap_v: vk_wrap(params.wrap_t),
            wrap_w: vk_wrap(params.wrap_r),
            min_filter: vk_filter(min_filter.filter),
            mag_filter: vk_filter(params.mag_filter),
            mipmap_mode: if min_filter.mip == Mip::Linear {
                vk::SamplerMipmapMode::LINEAR
            } else {
                vk::SamplerMipmapMode::NEAREST
            },
            min_lod: 0.0,
            max_lod: if is_mipmap { 1000.0 } else { 0.25 },
            border_color,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        };

        // Test cases: texture index, approximate lod per axis, offset
        let cases = [
            (0usize, [1.5f32, 2.8, 1.0], [-1.0f32, -2.7, -2.275]),
            (0, [-2.0, -1.5, -1.8], [-0.1, 0.9, -0.25]),
            (1, [0.2, 0.175, 0.3], [-2.0, -3.7, -1.825]),
            (1, [-0.8, -2.3, -2.5], [0.2, -0.1, 1.325]),
        ];

        for &(texture_index, lod, offset) in &cases {
            let texture = &textures[texture_index];
            let tex_format = texture.get_texture_format();
            let format_info = get_texture_format_info(tex_format);

            // Params for reference computation.
            let tcu_sampler = Sampler {
                wrap_s,
                wrap_t,
                wrap_r,
                filter: tcu_filter(min_filter.filter),
                normalized_coords: true,
                compare: CompareMode::None,
                compare_channel: 0,
                mip_filter: match min_filter.mip {
                    Mip::None => None,
                    Mip::Nearest => Some(MipmapFilterMode::Nearest),
                    Mip::Linear => Some(MipmapFilterMode::Linear),
                },
                seamless_cube_map: true,
            };
            let mut ref_params = ReferenceParams::new(TextureType::Texture3D, tcu_sampler, LodMode::Exact);
            ref_params.mag_filter = Some(tcu_filter(params.mag_filter));
            ref_params.base.sampler_type = if is_stencil {
                SamplerType::Uint
            } else {
                get_sampler_type(tex_format)
            };
            ref_params.base.color_bias = Vec4::new(
                format_info.look_up_bias[0],
                format_info.look_up_bias[1],
                format_info.look_up_bias[2],
                format_info.look_up_bias[3],
            );
            ref_params.base.color_scale = Vec4::new(
                format_info.look_up_scale[0],
                format_info.look_up_scale[1],
                format_info.look_up_scale[2],
                format_info.look_up_scale[3],
            );

            // Compute texture coordinates.
            log::info!("Approximate lod per axis = {lod:?}, offset = {offset:?}");
            let s_x = lod[0].exp2() * TEX2D_VIEWPORT_WIDTH as f32 / params.width as f32;
            let s_y = lod[1].exp2() * TEX2D_VIEWPORT_HEIGHT as f32 / params.height as f32;
            let s_z = lod[2].exp2() * TEX2D_VIEWPORT_WIDTH.max(TEX2D_VIEWPORT_HEIGHT) as f32 / params.depth as f32;
            let [o_x, o_y, o_z] = offset;
            let tex_coord: [f32; 12] = [
                o_x,
                o_y,
                o_z,
                o_x,
                o_y + s_y,
                o_z + s_z * 0.5,
                o_x + s_x,
                o_y,
                o_z + s_z * 0.5,
                o_x + s_x,
                o_y + s_y,
                o_z + s_z,
            ];

            let program = match ref_params.base.sampler_type {
                SamplerType::Float => Program::Float3D,
                SamplerType::Uint => Program::Uint3D,
                other => return Err(TestError::NotPorted(format!("3D program for sampler type {other:?}"))),
            };
            let request = RenderRequest {
                texture,
                format: params.format,
                aspect_mask: params.aspect_mask,
                component_mapping: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                use_compute: params.use_compute,
                sparse: false,
                width: TEX2D_VIEWPORT_WIDTH,
                height: TEX2D_VIEWPORT_HEIGHT,
                tex_width: params.width,
                tex_height: params.height,
                tex_depth: params.depth,
                kind: TexKind::D3,
                sampler,
                tex_coord: &tex_coord,
                positions: QUAD_POSITIONS,
                view_levels: None,
                view_min_lod: None,
                output_format: vk::Format::R8G8B8A8_UNORM,
                program,
                parameters: ShaderParameters {
                    bias: ref_params.base.bias,
                    reference: ref_params.base.ref_,
                    color_scale: format_info.look_up_scale,
                    color_bias: format_info.look_up_bias,
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, TEX2D_VIEWPORT_WIDTH, TEX2D_VIEWPORT_HEIGHT);

            let is_nearest_only = min_filter.filter == Filter::Nearest
                && min_filter.mip == Mip::None
                && params.mag_filter == Filter::Nearest;
            let pixel_format = PixelFormat::new(8, 8, 8, 8);
            let reduction = if is_nearest_only { 1 } else { 2 };
            let color_bits = get_bits_vec(pixel_format).map(|bits| (bits - reduction).max(0)); // 1 inaccurate bit if nearest only, 2 otherwise
            let threshold = compute_fixed_point_threshold(color_bits);
            let scale = format_info.look_up_scale;
            let mut lod_precision = LodPrecision {
                derivate_bits: 18,
                lod_bits: 6,
            };
            let mut lookup_precision = LookupPrecision {
                color_threshold: std::array::from_fn(|c| threshold[c] / scale[c]),
                coord_bits: [20, 20, 20],
                uvw_bits: [7, 7, 7],
                color_mask: get_compare_mask(pixel_format),
                ..LookupPrecision::default()
            };

            let reference = if is_stencil {
                reference_texture_3d_stencil(texture, params.width, params.height, params.depth)
            } else {
                reference_texture_3d(texture, params.width, params.height, params.depth)
            };
            let is_high_quality = verify_texture_result_3d(
                &rendered,
                &reference,
                tex_coord,
                &ref_params,
                &lookup_precision,
                &lod_precision,
                pixel_format,
            )?;
            if !is_high_quality {
                // Evaluate against lower precision requirements.
                lod_precision.lod_bits = 4;
                lookup_precision.uvw_bits = [4, 4, 4];
                log::info!(
                    "Warning: Verification against high precision requirements failed, trying with lower requirements."
                );

                let is_ok = verify_texture_result_3d(
                    &rendered,
                    &reference,
                    tex_coord,
                    &ref_params,
                    &lookup_precision,
                    &lod_precision,
                    pixel_format,
                )?;
                if !is_ok {
                    log::info!("ERROR: Verification against low precision requirements failed, failing test case.");
                    return Ok(TestStatus::fail("Image verification failed"));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

fn add_case_3d(group: &mut TestCaseGroup, name: &str, params: Filter3DParameters) {
    let mut params = params;
    group.add_child(Box::new(Filtering3DCase {
        name: name.to_string(),
        params,
    }) as Box<dyn TestCase>);

    // Compute case.
    params.use_compute = true;
    group.add_child(Box::new(Filtering3DCase {
        name: format!("{name}_compute"),
        params,
    }) as Box<dyn TestCase>);
}

/// `populateTextureFilteringTests`, the `3d` group
fn create_filtering_3d_tests() -> TestCaseGroup {
    let base = |format: vk::Format,
                min: MinFilter,
                mag: Filter,
                wraps: [Wrap; 3],
                size: (u32, u32, u32),
                aspect_mask: vk::ImageAspectFlags,
                program: Program| Filter3DParameters {
        format,
        min_filter: min,
        mag_filter: mag,
        wrap_s: wraps[0],
        wrap_t: wraps[1],
        wrap_r: wraps[2],
        width: size.0,
        height: size.1,
        depth: size.2,
        aspect_mask,
        program,
        use_compute: false,
    };
    let repeat = [Wrap::Repeat; 3];

    // Formats.
    let mut formats_group = TestCaseGroup::new("formats");
    for &(group_name, format, aspect_mask, program) in FILTERABLE_FORMATS {
        let program_3d = if program == Program::Uint2D {
            Program::Uint3D
        } else {
            Program::Float3D
        };
        let mut filter_group = TestCaseGroup::new(group_name);
        for &min in MIN_FILTER_MODES_3D {
            let is_mipmap = min.mip != Mip::None;
            let mag = if is_mipmap { Filter::Linear } else { min.filter };
            // Some tests have to be skipped due to the restrictions of the verifiers.
            if verifier_can_be_used(format, min, mag) {
                add_case_3d(
                    &mut filter_group,
                    &format!("{group_name}_{}", min.name),
                    base(format, min, mag, repeat, (64, 64, 64), aspect_mask, program_3d),
                );
            }
        }
        formats_group.add_child(filter_group);
    }

    // Sizes.
    let mut sizes_group = TestCaseGroup::new("sizes");
    for &(width, height, depth) in SIZES_3D {
        let mut filter_group = TestCaseGroup::new(format!("{width}x{height}x{depth}"));
        for &min in MIN_FILTER_MODES_3D {
            let is_mipmap = min.mip != Mip::None;
            let mag = if is_mipmap { Filter::Linear } else { min.filter };
            add_case_3d(
                &mut filter_group,
                min.name,
                base(
                    vk::Format::R8G8B8A8_UNORM,
                    min,
                    mag,
                    repeat,
                    (width, height, depth),
                    vk::ImageAspectFlags::COLOR,
                    Program::Float3D,
                ),
            );
        }
        sizes_group.add_child(filter_group);
    }

    // Wrap modes.
    let mut combinations_group = TestCaseGroup::new("combinations");
    for &min in MIN_FILTER_MODES_3D {
        let mut min_filter_group = TestCaseGroup::new(min.name);
        for &(mag_name, mag) in MAG_FILTER_MODES_3D {
            let mut mag_filter_group = TestCaseGroup::new(mag_name);
            for &(wrap_s_name, wrap_s) in WRAP_MODES {
                let mut wrap_s_group = TestCaseGroup::new(wrap_s_name);
                for &(wrap_t_name, wrap_t) in WRAP_MODES {
                    let mut wrap_t_group = TestCaseGroup::new(wrap_t_name);
                    for &(wrap_r_name, wrap_r) in WRAP_MODES {
                        add_case_3d(
                            &mut wrap_t_group,
                            wrap_r_name,
                            base(
                                vk::Format::R8G8B8A8_UNORM,
                                min,
                                mag,
                                [wrap_s, wrap_t, wrap_r],
                                (63, 57, 67),
                                vk::ImageAspectFlags::COLOR,
                                Program::Float3D,
                            ),
                        );
                    }
                    wrap_s_group.add_child(wrap_t_group);
                }
                mag_filter_group.add_child(wrap_s_group);
            }
            min_filter_group.add_child(mag_filter_group);
        }
        combinations_group.add_child(min_filter_group);
    }

    let mut group_3d = TestCaseGroup::new("3d");
    group_3d.add_child(formats_group);
    group_3d.add_child(sizes_group);
    group_3d.add_child(combinations_group);
    group_3d
}

const SIZES_2D_ARRAY: &[(u32, u32, u32)] = &[(4, 8, 8), (32, 64, 16), (128, 32, 64), (3, 7, 5), (63, 63, 63)];

/// `Texture2DArrayTestCaseParameters` as the 2D array filtering group sets it
#[derive(Clone, Copy)]
struct FilterArrayParameters {
    format: vk::Format,
    min_filter: MinFilter,
    mag_filter: Filter,
    wrap_s: Wrap,
    wrap_t: Wrap,
    width: u32,
    height: u32,
    num_layers: u32,
    aspect_mask: vk::ImageAspectFlags,
    program: Program,
    use_compute: bool,
}

impl FilterArrayParameters {
    fn not_ported(&self) -> Option<&'static str> {
        None
    }
}

struct FilteringArrayCase {
    name: String,
    params: FilterArrayParameters,
}

impl TestCase for FilteringArrayCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkTextureSupport(Context&, const Texture2DArrayTestCaseParameters&)`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        if [params.wrap_s, params.wrap_t].contains(&Wrap::MirroredOnce) {
            context.require_device_functionality("VK_KHR_sampler_mirror_clamp_to_edge")?;
        }
        // Every size of the group has more than one mip level
        if params.format == vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16 {
            let mut rgba10x6 = vk::PhysicalDeviceRGBA10X6FormatsFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut rgba10x6);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if rgba10x6.format_rgba10x6_without_y_cb_cr_sampler == vk::FALSE {
                return Err(TestError::NotSupported(
                    "formatRgba10x6WithoutYCbCrSampler not supported".to_string(),
                ));
            }
        }
        if let Some(reason) = params.not_ported() {
            return Err(TestError::NotPorted(reason.to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        shared_program(self.params.program, false).programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FilteringArrayInstance {
            context,
            params: self.params,
        })
    }

    fn is_stub(&self) -> bool {
        self.params.not_ported().is_some()
    }
}

struct FilteringArrayInstance<'a> {
    context: &'a Context<'a>,
    params: FilterArrayParameters,
}

impl TestInstance for FilteringArrayInstance<'_> {
    /// `Texture2DArrayFilteringTestInstance`'s constructor and `iterate`, every filter case in turn
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let min_filter = params.min_filter;
        let is_mipmap = min_filter.mip != Mip::None;
        let size = [params.width as i32, params.height as i32, 1];

        let mut textures = [
            create_test_texture(
                params.format,
                vk::ImageViewType::_2D_ARRAY,
                size,
                params.num_layers as i32,
            )?,
            create_test_texture(
                params.format,
                vk::ImageViewType::_2D_ARRAY,
                size,
                params.num_layers as i32,
            )?,
        ];
        let tex_format = textures[0].get_texture_format();
        let format_info = get_texture_format_info(tex_format);
        let is_stencil = is_stencil_aspect(params.aspect_mask, tex_format);
        let (c_bias, c_scale) = bias_and_scale(&format_info, is_stencil);
        let num_levels = textures[0].get_num_levels();

        let level_swz: [[usize; 4]; 4] = [[0, 1, 2, 3], [2, 1, 3, 0], [3, 0, 1, 2], [1, 3, 2, 0]];

        // Fill first gradient texture (gradient direction varies between layers).
        for level in 0..num_levels {
            for layer in 0..params.num_layers {
                let swz = level_swz[layer as usize % level_swz.len()];
                let g_min: [f32; 4] = std::array::from_fn(|c| [0.0f32, 0.0, 0.0, 1.0][swz[c]] * c_scale[c] + c_bias[c]);
                let g_max: [f32; 4] = std::array::from_fn(|c| [1.0f32, 1.0, 1.0, 0.0][swz[c]] * c_scale[c] + c_bias[c]);
                fill_level_gradients(is_stencil, textures[0].get_level_mut(level, layer), g_min, g_max);
            }
        }

        // Fill second with grid texture (each layer has unique colors).
        for level in 0..num_levels {
            for layer in 0..params.num_layers {
                let step = 0x00ff_ffffu32 / (num_levels as u32 * params.num_layers - 1);
                let rgb = step * (level as u32 + layer * num_levels as u32);
                let color = |packed: u32| -> [f32; 4] {
                    std::array::from_fn(|c| {
                        (if c == 3 {
                            255.0
                        } else {
                            ((packed >> (8 * c)) & 0xFF) as f32
                        }) / 255.0
                            * c_scale[c]
                            + c_bias[c]
                    })
                };
                fill_level_grid(
                    is_stencil,
                    textures[1].get_level_mut(level, layer),
                    4,
                    color(0xff00_0000 | rgb),
                    color(0xff00_0000 | !rgb),
                );
            }
        }

        let (Some(wrap_s), Some(wrap_t)) = (tcu_wrap(params.wrap_s), tcu_wrap(params.wrap_t)) else {
            return Err(TestError::NotPorted("MIRRORED_ONCE reference sampling".to_string()));
        };
        let border_color = if params.aspect_mask == vk::ImageAspectFlags::STENCIL {
            vk::BorderColor::INT_TRANSPARENT_BLACK
        } else {
            vk::BorderColor::FLOAT_TRANSPARENT_BLACK
        };
        let sampler = SamplerParams {
            wrap_u: vk_wrap(params.wrap_s),
            wrap_v: vk_wrap(params.wrap_t),
            wrap_w: vk_wrap(params.wrap_s),
            min_filter: vk_filter(min_filter.filter),
            mag_filter: vk_filter(params.mag_filter),
            mipmap_mode: if min_filter.mip == Mip::Linear {
                vk::SamplerMipmapMode::LINEAR
            } else {
                vk::SamplerMipmapMode::NEAREST
            },
            min_lod: 0.0,
            max_lod: if is_mipmap { 1000.0 } else { 0.25 },
            border_color,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        };

        // Test cases: texture index, approximate lod per axis, offset, layer range
        let layers = params.num_layers as f32;
        let cases = [
            (0usize, [1.5f32, 2.8], [-1.0f32, -2.7], [-0.5f32, layers + 0.5]),
            (1, [0.2, 0.175], [-2.0, -3.7], [-0.5, layers + 0.5]),
            (1, [-0.8, -2.3], [0.2, -0.1], [layers + 0.5, -0.5]),
            (0, [-2.0, -1.5], [-0.1, 0.9], [1.50001, 1.49999]),
        ];

        for &(texture_index, lod, offset, layer_range) in &cases {
            let texture = &textures[texture_index];
            let tex_format = texture.get_texture_format();
            let format_info = get_texture_format_info(tex_format);

            // Params for reference computation.
            let tcu_sampler = Sampler {
                wrap_s,
                wrap_t,
                wrap_r: wrap_s,
                filter: tcu_filter(min_filter.filter),
                normalized_coords: true,
                compare: CompareMode::None,
                compare_channel: 0,
                mip_filter: match min_filter.mip {
                    Mip::None => None,
                    Mip::Nearest => Some(MipmapFilterMode::Nearest),
                    Mip::Linear => Some(MipmapFilterMode::Linear),
                },
                seamless_cube_map: true,
            };
            let mut ref_params = ReferenceParams::new(TextureType::Texture2DArray, tcu_sampler, LodMode::Exact);
            ref_params.mag_filter = Some(tcu_filter(params.mag_filter));
            ref_params.base.sampler_type = if is_stencil {
                SamplerType::Uint
            } else {
                get_sampler_type(tex_format)
            };
            ref_params.base.color_bias = Vec4::new(
                format_info.look_up_bias[0],
                format_info.look_up_bias[1],
                format_info.look_up_bias[2],
                format_info.look_up_bias[3],
            );
            ref_params.base.color_scale = Vec4::new(
                format_info.look_up_scale[0],
                format_info.look_up_scale[1],
                format_info.look_up_scale[2],
                format_info.look_up_scale[3],
            );

            // Compute texture coordinates.
            log::info!("Approximate lod per axis = {lod:?}, offset = {offset:?}");
            let s_x = lod[0].exp2() * TEX2D_VIEWPORT_WIDTH as f32 / params.width as f32;
            let s_y = lod[1].exp2() * TEX2D_VIEWPORT_HEIGHT as f32 / params.height as f32;
            let [o_x, o_y] = offset;
            let [l0, l1] = layer_range;
            let middle = l0 * 0.5 + l1 * 0.5;
            let tex_coord: [f32; 12] = [
                o_x,
                o_y,
                l0,
                o_x,
                o_y + s_y,
                middle,
                o_x + s_x,
                o_y,
                middle,
                o_x + s_x,
                o_y + s_y,
                l1,
            ];

            let program = match ref_params.base.sampler_type {
                SamplerType::Float => Program::Float2DArray,
                SamplerType::Uint => Program::Uint2DArray,
                other => {
                    return Err(TestError::NotPorted(format!(
                        "2D array program for sampler type {other:?}"
                    )));
                }
            };
            let request = RenderRequest {
                texture,
                format: params.format,
                aspect_mask: params.aspect_mask,
                component_mapping: vk::ComponentMapping {
                    r: vk::ComponentSwizzle::R,
                    g: vk::ComponentSwizzle::G,
                    b: vk::ComponentSwizzle::B,
                    a: vk::ComponentSwizzle::A,
                },
                use_compute: params.use_compute,
                sparse: false,
                width: TEX2D_VIEWPORT_WIDTH,
                height: TEX2D_VIEWPORT_HEIGHT,
                tex_width: params.width,
                tex_height: params.height,
                tex_depth: params.num_layers,
                kind: TexKind::D2Array,
                sampler,
                tex_coord: &tex_coord,
                positions: QUAD_POSITIONS,
                view_levels: None,
                view_min_lod: None,
                output_format: vk::Format::R8G8B8A8_UNORM,
                program,
                parameters: ShaderParameters {
                    bias: ref_params.base.bias,
                    reference: ref_params.base.ref_,
                    color_scale: format_info.look_up_scale,
                    color_bias: format_info.look_up_bias,
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, TEX2D_VIEWPORT_WIDTH, TEX2D_VIEWPORT_HEIGHT);

            let is_nearest_only = min_filter.filter == Filter::Nearest
                && min_filter.mip == Mip::None
                && params.mag_filter == Filter::Nearest;
            let pixel_format = PixelFormat::new(8, 8, 8, 8);
            let reduction = if is_nearest_only { 1 } else { 2 };
            let color_bits = get_bits_vec(pixel_format).map(|bits| (bits - reduction).max(0)); // 1 inaccurate bit if nearest only, 2 otherwise
            let threshold = compute_fixed_point_threshold(color_bits);
            let scale = format_info.look_up_scale;
            let mut lod_precision = LodPrecision {
                derivate_bits: 18,
                lod_bits: 6,
            };
            let mut lookup_precision = LookupPrecision {
                color_threshold: std::array::from_fn(|c| threshold[c] / scale[c]),
                coord_bits: [20, 20, 20],
                uvw_bits: [7, 7, 0],
                color_mask: get_compare_mask(pixel_format),
                ..LookupPrecision::default()
            };

            let reference = if is_stencil {
                reference_texture_2d_array_stencil(texture, params.width, params.height, params.num_layers)
            } else {
                reference_texture_2d_array(texture, params.width, params.height, params.num_layers)
            };
            let is_high_quality = verify_texture_result_2d_array(
                &rendered,
                &reference,
                tex_coord,
                &ref_params,
                &lookup_precision,
                &lod_precision,
                pixel_format,
            )?;
            if !is_high_quality {
                // Evaluate against lower precision requirements.
                lod_precision.lod_bits = 4;
                lookup_precision.uvw_bits = [4, 4, 0];
                log::info!(
                    "Warning: Verification against high precision requirements failed, trying with lower requirements."
                );

                let is_ok = verify_texture_result_2d_array(
                    &rendered,
                    &reference,
                    tex_coord,
                    &ref_params,
                    &lookup_precision,
                    &lod_precision,
                    pixel_format,
                )?;
                if !is_ok {
                    log::info!("ERROR: Verification against low precision requirements failed, failing test case.");
                    return Ok(TestStatus::fail("Image verification failed"));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

fn add_case_array(group: &mut TestCaseGroup, name: &str, params: FilterArrayParameters) {
    let mut params = params;
    group.add_child(Box::new(FilteringArrayCase {
        name: name.to_string(),
        params,
    }) as Box<dyn TestCase>);

    // Compute case.
    params.use_compute = true;
    group.add_child(Box::new(FilteringArrayCase {
        name: format!("{name}_compute"),
        params,
    }) as Box<dyn TestCase>);
}

/// `populateTextureFilteringTests`, the `2d_array` group
fn create_filtering_2d_array_tests() -> TestCaseGroup {
    let base = |format: vk::Format,
                min: MinFilter,
                mag: Filter,
                wraps: [Wrap; 2],
                size: (u32, u32, u32),
                aspect_mask: vk::ImageAspectFlags,
                program: Program| FilterArrayParameters {
        format,
        min_filter: min,
        mag_filter: mag,
        wrap_s: wraps[0],
        wrap_t: wraps[1],
        width: size.0,
        height: size.1,
        num_layers: size.2,
        aspect_mask,
        program,
        use_compute: false,
    };
    let repeat = [Wrap::Repeat; 2];

    // Formats.
    let mut formats_group = TestCaseGroup::new("formats");
    for &(group_name, format, aspect_mask, program) in FILTERABLE_FORMATS {
        let program_array = if program == Program::Uint2D {
            Program::Uint2DArray
        } else {
            Program::Float2DArray
        };
        let mut filter_group = TestCaseGroup::new(group_name);
        for &min in MIN_FILTER_MODES_3D {
            let is_mipmap = min.mip != Mip::None;
            let mag = if is_mipmap { Filter::Linear } else { min.filter };
            // Some tests have to be skipped due to the restrictions of the verifiers.
            if verifier_can_be_used(format, min, mag) {
                add_case_array(
                    &mut filter_group,
                    &format!("{group_name}_{}", min.name),
                    base(format, min, mag, repeat, (128, 128, 8), aspect_mask, program_array),
                );
            }
        }
        formats_group.add_child(filter_group);
    }

    // Sizes.
    let mut sizes_group = TestCaseGroup::new("sizes");
    for &(width, height, num_layers) in SIZES_2D_ARRAY {
        let mut filter_group = TestCaseGroup::new(format!("{width}x{height}x{num_layers}"));
        for &min in MIN_FILTER_MODES_3D {
            let is_mipmap = min.mip != Mip::None;
            let mag = if is_mipmap { Filter::Linear } else { min.filter };
            add_case_array(
                &mut filter_group,
                min.name,
                base(
                    vk::Format::R8G8B8A8_UNORM,
                    min,
                    mag,
                    repeat,
                    (width, height, num_layers),
                    vk::ImageAspectFlags::COLOR,
                    Program::Float2DArray,
                ),
            );
        }
        sizes_group.add_child(filter_group);
    }

    // Wrap modes.
    let mut combinations_group = TestCaseGroup::new("combinations");
    for &min in MIN_FILTER_MODES_3D {
        let mut min_filter_group = TestCaseGroup::new(min.name);
        for &(mag_name, mag) in MAG_FILTER_MODES_3D {
            let mut mag_filter_group = TestCaseGroup::new(mag_name);
            for &(wrap_s_name, wrap_s) in WRAP_MODES {
                let mut wrap_s_group = TestCaseGroup::new(wrap_s_name);
                for &(wrap_t_name, wrap_t) in WRAP_MODES {
                    add_case_array(
                        &mut wrap_s_group,
                        wrap_t_name,
                        base(
                            vk::Format::R8G8B8A8_UNORM,
                            min,
                            mag,
                            [wrap_s, wrap_t],
                            (123, 107, 7),
                            vk::ImageAspectFlags::COLOR,
                            Program::Float2DArray,
                        ),
                    );
                }
                mag_filter_group.add_child(wrap_s_group);
            }
            min_filter_group.add_child(mag_filter_group);
        }
        combinations_group.add_child(min_filter_group);
    }

    let mut group_array = TestCaseGroup::new("2d_array");
    group_array.add_child(formats_group);
    group_array.add_child(sizes_group);
    group_array.add_child(combinations_group);
    group_array
}

const SIZES_CUBE: &[u32] = &[8, 64, 128, 7, 63];

/// (name, seamless)
const SEAMLESS_VARIANTS: &[(&str, bool)] = &[("seamless", true), ("non_seamless", false)];

/// `TextureCubeFilteringTestCaseParameters` as the cube filtering group sets it (the wrap modes of the group are not used by the instance, which always clamps to edge)
#[derive(Clone, Copy)]
struct FilterCubeParameters {
    format: vk::Format,
    min_filter: MinFilter,
    mag_filter: Filter,
    only_sample_face_interior: bool,
    size: u32,
    seamless: bool,
    aspect_mask: vk::ImageAspectFlags,
    program: Program,
    use_compute: bool,
}

impl FilterCubeParameters {
    fn not_ported(&self) -> Option<&'static str> {
        None
    }
}

struct FilteringCubeCase {
    name: String,
    params: FilterCubeParameters,
}

impl TestCase for FilteringCubeCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkTextureSupport(Context&, const TextureCubeFilteringTestCaseParameters&)`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        if params.format == vk::Format::R10X6G10X6B10X6A10X6_UNORM_4PACK16 {
            let mut rgba10x6 = vk::PhysicalDeviceRGBA10X6FormatsFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut rgba10x6);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if rgba10x6.format_rgba10x6_without_y_cb_cr_sampler == vk::FALSE {
                return Err(TestError::NotSupported(
                    "formatRgba10x6WithoutYCbCrSampler not supported".to_string(),
                ));
            }
        }
        if !params.seamless {
            context.require_device_functionality("VK_EXT_non_seamless_cube_map")?;
        }
        if let Some(reason) = params.not_ported() {
            return Err(TestError::NotPorted(reason.to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        shared_program(self.params.program, false).programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FilteringCubeInstance {
            context,
            params: self.params,
        })
    }

    fn is_stub(&self) -> bool {
        self.params.not_ported().is_some()
    }
}

struct FilteringCubeInstance<'a> {
    context: &'a Context<'a>,
    params: FilterCubeParameters,
}

impl TestInstance for FilteringCubeInstance<'_> {
    /// `TextureCubeFilteringTestInstance`'s constructor and `iterate`, every filter case and face in turn
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let min_filter = params.min_filter;
        let is_mipmap = min_filter.mip != Mip::None;
        let size = [params.size as i32, params.size as i32, 1];

        let mut textures = [
            create_test_texture(params.format, vk::ImageViewType::CUBE, size, 6)?,
            create_test_texture(params.format, vk::ImageViewType::CUBE, size, 6)?,
        ];
        let tex_format = textures[0].get_texture_format();
        let format_info = get_texture_format_info(tex_format);
        let is_stencil = is_stencil_aspect(params.aspect_mask, tex_format);
        let (c_bias, c_scale) = bias_and_scale(&format_info, is_stencil);
        let num_levels = textures[0].get_num_levels();

        // Fill first with gradient texture.
        let gradients: [[[f32; 4]; 2]; 6] = [
            [[0.0, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 0.0]], // negative x
            [[0.5, 0.0, 0.0, 1.0], [1.0, 1.0, 1.0, 0.0]], // positive x
            [[0.0, 0.5, 0.0, 1.0], [1.0, 1.0, 1.0, 0.0]], // negative y
            [[0.0, 0.0, 0.5, 1.0], [1.0, 1.0, 1.0, 0.0]], // positive y
            [[0.0, 0.0, 0.0, 0.5], [1.0, 1.0, 1.0, 1.0]], // negative z
            [[0.5, 0.5, 0.5, 1.0], [1.0, 1.0, 1.0, 0.0]], // positive z
        ];
        for face in 0..6usize {
            for level in 0..num_levels {
                let g_min: [f32; 4] = std::array::from_fn(|c| gradients[face][0][c] * c_scale[c] + c_bias[c]);
                let g_max: [f32; 4] = std::array::from_fn(|c| gradients[face][1][c] * c_scale[c] + c_bias[c]);
                fill_level_gradients(is_stencil, textures[0].get_level_mut(level, face as u32), g_min, g_max);
            }
        }

        // Fill second with grid texture.
        for face in 0..6usize {
            for level in 0..num_levels {
                let step = 0x00ff_ffffu32 / (num_levels as u32 * 6);
                let rgb = step * level as u32 * face as u32;
                let color = |packed: u32| -> [f32; 4] {
                    std::array::from_fn(|c| {
                        (if c == 3 {
                            255.0
                        } else {
                            ((packed >> (8 * c)) & 0xFF) as f32
                        }) / 255.0
                            * c_scale[c]
                            + c_bias[c]
                    })
                };
                fill_level_grid(
                    is_stencil,
                    textures[1].get_level_mut(level, face as u32),
                    4,
                    color(0xff00_0000 | rgb),
                    color(0xff00_0000 | !rgb),
                );
            }
        }

        // Compute cases
        let cases: [(usize, Vec2, Vec2); 4] = if params.only_sample_face_interior {
            [
                (0, Vec2::new(-0.8, -0.8), Vec2::new(0.8, 0.8)), // minification
                (0, Vec2::new(0.5, 0.65), Vec2::new(0.8, 0.8)),  // magnification
                (1, Vec2::new(-0.8, -0.8), Vec2::new(0.8, 0.8)), // minification
                (1, Vec2::new(0.2, 0.2), Vec2::new(0.6, 0.5)),   // magnification
            ]
        } else {
            [
                (0, Vec2::new(-1.25, -1.2), Vec2::new(1.2, 1.25)), // minification
                (0, Vec2::new(0.8, 0.8), Vec2::new(1.25, 1.20)),   // magnification
                (1, Vec2::new(-1.19, -1.3), Vec2::new(1.1, 1.35)), // minification
                (1, Vec2::new(-1.2, -1.1), Vec2::new(-0.8, -0.8)), // magnification
            ]
        };

        let border_color = if params.aspect_mask == vk::ImageAspectFlags::STENCIL {
            vk::BorderColor::INT_TRANSPARENT_BLACK
        } else {
            vk::BorderColor::FLOAT_TRANSPARENT_BLACK
        };
        let sampler = SamplerParams {
            wrap_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            wrap_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            wrap_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
            min_filter: vk_filter(min_filter.filter),
            mag_filter: vk_filter(params.mag_filter),
            mipmap_mode: if min_filter.mip == Mip::Linear {
                vk::SamplerMipmapMode::LINEAR
            } else {
                vk::SamplerMipmapMode::NEAREST
            },
            min_lod: 0.0,
            max_lod: if is_mipmap { 1000.0 } else { 0.25 },
            border_color,
            compare_op: None,
            unnormalized: false,
            non_seamless: !params.seamless,
            max_anisotropy: None,
        };

        for &(texture_index, bottom_left, top_right) in &cases {
            let texture = &textures[texture_index];
            let tex_format = texture.get_texture_format();
            let format_info = get_texture_format_info(tex_format);

            // Params for reference computation.
            let tcu_sampler = Sampler {
                wrap_s: WrapMode::ClampToEdge,
                wrap_t: WrapMode::ClampToEdge,
                wrap_r: WrapMode::ClampToEdge,
                filter: tcu_filter(min_filter.filter),
                normalized_coords: true,
                compare: CompareMode::None,
                compare_channel: 0,
                mip_filter: match min_filter.mip {
                    Mip::None => None,
                    Mip::Nearest => Some(MipmapFilterMode::Nearest),
                    Mip::Linear => Some(MipmapFilterMode::Linear),
                },
                seamless_cube_map: params.seamless,
            };
            let mut ref_params = ReferenceParams::new(TextureType::Cube, tcu_sampler, LodMode::Exact);
            ref_params.mag_filter = Some(tcu_filter(params.mag_filter));
            ref_params.base.sampler_type = if is_stencil {
                SamplerType::Uint
            } else {
                get_sampler_type(tex_format)
            };
            ref_params.base.color_bias = Vec4::new(
                format_info.look_up_bias[0],
                format_info.look_up_bias[1],
                format_info.look_up_bias[2],
                format_info.look_up_bias[3],
            );
            ref_params.base.color_scale = Vec4::new(
                format_info.look_up_scale[0],
                format_info.look_up_scale[1],
                format_info.look_up_scale[2],
                format_info.look_up_scale[3],
            );

            log::info!(
                "Coordinates: {:?} -> {:?}",
                (bottom_left.x(), bottom_left.y()),
                (top_right.x(), top_right.y())
            );
            let reference = if is_stencil {
                reference_texture_cube_stencil(texture, params.size)
            } else {
                reference_texture_cube(texture, params.size)
            };

            for face in [
                CubeFace::NegativeX,
                CubeFace::PositiveX,
                CubeFace::NegativeY,
                CubeFace::PositiveY,
                CubeFace::NegativeZ,
                CubeFace::PositiveZ,
            ] {
                let tex_coord = compute_quad_tex_coord_cube_region(face, bottom_left, top_right);
                log::info!("Face {face:?}");

                let program = match ref_params.base.sampler_type {
                    SamplerType::Float => Program::FloatCube,
                    SamplerType::Uint => Program::UintCube,
                    other => return Err(TestError::NotPorted(format!("cube program for sampler type {other:?}"))),
                };
                let request = RenderRequest {
                    texture,
                    format: params.format,
                    aspect_mask: params.aspect_mask,
                    component_mapping: vk::ComponentMapping {
                        r: vk::ComponentSwizzle::R,
                        g: vk::ComponentSwizzle::G,
                        b: vk::ComponentSwizzle::B,
                        a: vk::ComponentSwizzle::A,
                    },
                    use_compute: params.use_compute,
                    sparse: false,
                    width: TEXCUBE_VIEWPORT_SIZE,
                    height: TEXCUBE_VIEWPORT_SIZE,
                    tex_width: params.size,
                    tex_height: params.size,
                    tex_depth: 6,
                    kind: TexKind::Cube,
                    sampler,
                    tex_coord: &tex_coord,
                    positions: QUAD_POSITIONS,
                    view_levels: None,
                    view_min_lod: None,
                    output_format: vk::Format::R8G8B8A8_UNORM,
                    program,
                    parameters: ShaderParameters {
                        bias: ref_params.base.bias,
                        reference: ref_params.base.ref_,
                        color_scale: format_info.look_up_scale,
                        color_bias: format_info.look_up_bias,
                        lod: 0,
                    },
                };
                let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
                let rendered = pixels_to_surface(&pixels, TEXCUBE_VIEWPORT_SIZE, TEXCUBE_VIEWPORT_SIZE);

                let is_nearest_only = min_filter.filter == Filter::Nearest
                    && min_filter.mip == Mip::None
                    && params.mag_filter == Filter::Nearest;
                let pixel_format = PixelFormat::new(8, 8, 8, 8);
                let reduction = if is_nearest_only { 1 } else { 2 };
                let color_bits = get_bits_vec(pixel_format).map(|bits| (bits - reduction).max(0)); // 1 inaccurate bit if nearest only, 2 otherwise
                let threshold = compute_fixed_point_threshold(color_bits);
                let scale = format_info.look_up_scale;
                let mut lod_precision = LodPrecision {
                    derivate_bits: 10,
                    lod_bits: 5,
                };
                let mut lookup_precision = LookupPrecision {
                    color_threshold: std::array::from_fn(|c| threshold[c] / scale[c]),
                    coord_bits: [10, 10, 10],
                    uvw_bits: [6, 6, 0],
                    color_mask: get_compare_mask(pixel_format),
                    ..LookupPrecision::default()
                };

                let is_high_quality = verify_texture_result_cube(
                    &rendered,
                    &reference,
                    tex_coord,
                    &ref_params,
                    &lookup_precision,
                    &lod_precision,
                    pixel_format,
                )?;
                if !is_high_quality {
                    // Evaluate against lower precision requirements.
                    lod_precision.lod_bits = 4;
                    lookup_precision.uvw_bits = [4, 4, 0];
                    log::info!(
                        "Warning: Verification against high precision requirements failed, trying with lower requirements."
                    );

                    let is_ok = verify_texture_result_cube(
                        &rendered,
                        &reference,
                        tex_coord,
                        &ref_params,
                        &lookup_precision,
                        &lod_precision,
                        pixel_format,
                    )?;
                    if !is_ok {
                        log::info!("ERROR: Verification against low precision requirements failed, failing test case.");
                        return Ok(TestStatus::fail("Image verification failed"));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

fn add_case_cube(group: &mut TestCaseGroup, name: &str, params: FilterCubeParameters) {
    let mut params = params;
    group.add_child(Box::new(FilteringCubeCase {
        name: name.to_string(),
        params,
    }) as Box<dyn TestCase>);

    // Compute case.
    params.use_compute = true;
    group.add_child(Box::new(FilteringCubeCase {
        name: format!("{name}_compute"),
        params,
    }) as Box<dyn TestCase>);
}

/// `populateTextureFilteringTests`, the `cube` group
fn create_filtering_cube_tests() -> TestCaseGroup {
    let base = |format: vk::Format,
                min: MinFilter,
                mag: Filter,
                size: u32,
                seamless: bool,
                aspect_mask: vk::ImageAspectFlags,
                program: Program| FilterCubeParameters {
        format,
        min_filter: min,
        mag_filter: mag,
        only_sample_face_interior: false,
        size,
        seamless,
        aspect_mask,
        program,
        use_compute: false,
    };

    // Formats.
    let mut formats_group = TestCaseGroup::new("formats");
    for &(group_name, format, aspect_mask, program) in FILTERABLE_FORMATS {
        let program_cube = if program == Program::Uint2D {
            Program::UintCube
        } else {
            Program::FloatCube
        };
        let mut filter_group = TestCaseGroup::new(group_name);
        for &min in MIN_FILTER_MODES_3D {
            let mut min_filter_group = TestCaseGroup::new(min.name);
            for &(seamless_name, seamless) in SEAMLESS_VARIANTS {
                let is_mipmap = min.mip != Mip::None;
                let mag = if is_mipmap { Filter::Linear } else { min.filter };
                // Some tests have to be skipped due to the restrictions of the verifiers.
                if verifier_can_be_used(format, min, mag) {
                    add_case_cube(
                        &mut min_filter_group,
                        seamless_name,
                        base(format, min, mag, 64, seamless, aspect_mask, program_cube),
                    );
                }
            }
            filter_group.add_child(min_filter_group);
        }
        formats_group.add_child(filter_group);
    }

    // Sizes.
    let mut sizes_group = TestCaseGroup::new("sizes");
    for &size in SIZES_CUBE {
        let mut filter_group = TestCaseGroup::new(format!("{size}x{size}"));
        for &min in MIN_FILTER_MODES_3D {
            let mut min_filter_group = TestCaseGroup::new(min.name);
            for &(seamless_name, seamless) in SEAMLESS_VARIANTS {
                let is_mipmap = min.mip != Mip::None;
                let mag = if is_mipmap { Filter::Linear } else { min.filter };
                add_case_cube(
                    &mut min_filter_group,
                    seamless_name,
                    base(
                        vk::Format::R8G8B8A8_UNORM,
                        min,
                        mag,
                        size,
                        seamless,
                        vk::ImageAspectFlags::COLOR,
                        Program::FloatCube,
                    ),
                );
            }
            filter_group.add_child(min_filter_group);
        }
        sizes_group.add_child(filter_group);
    }

    // Filter/wrap mode combinations.
    let mut combinations_group = TestCaseGroup::new("combinations");
    for &min in MIN_FILTER_MODES_3D {
        let mut min_filter_group = TestCaseGroup::new(min.name);
        for &(mag_name, mag) in MAG_FILTER_MODES_3D {
            let mut mag_filter_group = TestCaseGroup::new(mag_name);
            for &(wrap_s_name, _) in WRAP_MODES {
                let mut wrap_s_group = TestCaseGroup::new(wrap_s_name);
                for &(wrap_t_name, _) in WRAP_MODES {
                    let mut wrap_t_group = TestCaseGroup::new(wrap_t_name);
                    for &(seamless_name, seamless) in SEAMLESS_VARIANTS {
                        add_case_cube(
                            &mut wrap_t_group,
                            seamless_name,
                            base(
                                vk::Format::R8G8B8A8_UNORM,
                                min,
                                mag,
                                63,
                                seamless,
                                vk::ImageAspectFlags::COLOR,
                                Program::FloatCube,
                            ),
                        );
                    }
                    wrap_s_group.add_child(wrap_t_group);
                }
                mag_filter_group.add_child(wrap_s_group);
            }
            min_filter_group.add_child(mag_filter_group);
        }
        combinations_group.add_child(min_filter_group);
    }

    // Cases with no visible cube edges.
    let mut only_face_interior_group = TestCaseGroup::new("no_edges_visible");
    for (name, filter) in [("nearest", Filter::Nearest), ("linear", Filter::Linear)] {
        let mut params = base(
            vk::Format::R8G8B8A8_UNORM,
            min_filter(name, filter, Mip::None),
            filter,
            63,
            true,
            vk::ImageAspectFlags::COLOR,
            Program::FloatCube,
        );
        params.only_sample_face_interior = true;
        add_case_cube(&mut only_face_interior_group, name, params);
    }

    let mut group_cube = TestCaseGroup::new("cube");
    group_cube.add_child(formats_group);
    group_cube.add_child(sizes_group);
    group_cube.add_child(combinations_group);
    group_cube.add_child(only_face_interior_group);
    group_cube
}

fn add_case(group: &mut TestCaseGroup, name: &str, params: FilterParameters) {
    let mut params = params;
    group.add_child(Box::new(FilteringCase {
        name: name.to_string(),
        params,
    }) as Box<dyn TestCase>);

    // Compute case.
    params.use_compute = true;
    group.add_child(Box::new(FilteringCase {
        name: format!("{name}_compute"),
        params,
    }) as Box<dyn TestCase>);
}

/// `populateTextureFilteringTests`, the `2d` group, below a `filtering` group
pub fn create_texture_filtering_tests() -> TestCaseGroup {
    let base = |format: vk::Format,
                min: MinFilter,
                mag: Filter,
                wrap_s: Wrap,
                wrap_t: Wrap,
                width: u32,
                height: u32,
                aspect_mask: vk::ImageAspectFlags,
                program: Program| FilterParameters {
        format,
        min_filter: min,
        mag_filter: mag,
        wrap_s,
        wrap_t,
        width,
        height,
        aspect_mask,
        program,
        use_compute: false,
        unnormal: false,
        mipmaps: true,
    };

    // 2D Texture Formats
    let mut formats_group = TestCaseGroup::new("formats");
    for &(group_name, format, aspect_mask, program) in FILTERABLE_FORMATS {
        let mut filter_group = TestCaseGroup::new(group_name);
        for &min in MIN_FILTER_MODES_2D {
            let is_mipmap = min.mip != Mip::None;
            let mag = if is_mipmap { Filter::Linear } else { min.filter };
            // Some combinations of the tests have to be skipped due to the restrictions of the verifiers.
            if verifier_can_be_used(format, min, mag) {
                add_case(
                    &mut filter_group,
                    min.name,
                    base(
                        format,
                        min,
                        mag,
                        Wrap::Repeat,
                        Wrap::Repeat,
                        64,
                        64,
                        aspect_mask,
                        program,
                    ),
                );
            }
        }
        formats_group.add_child(filter_group);
    }

    // Sizes.
    let mut sizes_group = TestCaseGroup::new("sizes");
    for &(width, height) in SIZES_2D {
        let mut filter_group = TestCaseGroup::new(format!("{width}x{height}"));
        for &min in MIN_FILTER_MODES_2D {
            let is_mipmap = min.mip != Mip::None;
            let mag = if is_mipmap { Filter::Linear } else { min.filter };
            add_case(
                &mut filter_group,
                min.name,
                base(
                    vk::Format::R8G8B8A8_UNORM,
                    min,
                    mag,
                    Wrap::Repeat,
                    Wrap::Repeat,
                    width,
                    height,
                    vk::ImageAspectFlags::COLOR,
                    Program::Float2D,
                ),
            );
        }
        sizes_group.add_child(filter_group);
    }

    // Wrap modes.
    let mut combinations_group = TestCaseGroup::new("combinations");
    for &min in MIN_FILTER_MODES_2D {
        let mut min_filter_group = TestCaseGroup::new(min.name);
        for &(mag_name, mag) in MAG_FILTER_MODES_2D {
            let mut mag_filter_group = TestCaseGroup::new(mag_name);
            for &(wrap_s_name, wrap_s) in WRAP_MODES {
                let mut wrap_s_group = TestCaseGroup::new(wrap_s_name);
                for &(wrap_t_name, wrap_t) in WRAP_MODES {
                    add_case(
                        &mut wrap_s_group,
                        wrap_t_name,
                        base(
                            vk::Format::R8G8B8A8_UNORM,
                            min,
                            mag,
                            wrap_s,
                            wrap_t,
                            63,
                            57,
                            vk::ImageAspectFlags::COLOR,
                            Program::Float2D,
                        ),
                    );
                }
                mag_filter_group.add_child(wrap_s_group);
            }
            min_filter_group.add_child(mag_filter_group);
        }
        combinations_group.add_child(min_filter_group);
    }

    let mut group_2d = TestCaseGroup::new("2d");
    group_2d.add_child(formats_group);
    group_2d.add_child(sizes_group);
    group_2d.add_child(combinations_group);

    // Unnormalized texture filtering.
    let unnormal_variant = |mut params: FilterParameters, wrap_selector: usize| {
        params.unnormal = true;
        params.mipmaps = false;
        params.wrap_s = if wrap_selector & 1 != 0 {
            Wrap::ClampToEdge
        } else {
            Wrap::ClampToBorder
        };
        params.wrap_t = if wrap_selector & 2 != 0 {
            Wrap::ClampToEdge
        } else {
            Wrap::ClampToBorder
        };
        params
    };
    let mut unnormal_formats_group = TestCaseGroup::new("formats");
    for (format_ndx, &(group_name, format, aspect_mask, program)) in FILTERABLE_FORMATS.iter().enumerate() {
        let mut filter_group = TestCaseGroup::new(group_name);
        for (filter_ndx, &(name, mag)) in MAG_FILTER_MODES_2D.iter().enumerate() {
            let min = min_filter(name, mag, Mip::None);
            // Some combinations of the tests have to be skipped due to the restrictions of the verifiers.
            if verifier_can_be_used(format, min, mag) {
                add_case(
                    &mut filter_group,
                    name,
                    unnormal_variant(
                        base(
                            format,
                            min,
                            mag,
                            Wrap::Repeat,
                            Wrap::Repeat,
                            64,
                            64,
                            aspect_mask,
                            program,
                        ),
                        format_ndx ^ filter_ndx,
                    ),
                );
            }
        }
        unnormal_formats_group.add_child(filter_group);
    }
    let mut unnormal_sizes_group = TestCaseGroup::new("sizes");
    for (size_ndx, &(width, height)) in SIZES_2D.iter().enumerate() {
        let mut filter_group = TestCaseGroup::new(format!("{width}x{height}"));
        for (filter_ndx, &(name, mag)) in MAG_FILTER_MODES_2D.iter().enumerate() {
            let min = min_filter(name, mag, Mip::None);
            add_case(
                &mut filter_group,
                name,
                unnormal_variant(
                    base(
                        vk::Format::R8G8B8A8_UNORM,
                        min,
                        mag,
                        Wrap::Repeat,
                        Wrap::Repeat,
                        width,
                        height,
                        vk::ImageAspectFlags::COLOR,
                        Program::Float2D,
                    ),
                    size_ndx ^ filter_ndx,
                ),
            );
        }
        unnormal_sizes_group.add_child(filter_group);
    }
    let mut group_unnormal = TestCaseGroup::new("unnormal");
    group_unnormal.add_child(unnormal_formats_group);
    group_unnormal.add_child(unnormal_sizes_group);

    let mut filtering = TestCaseGroup::new("filtering");
    filtering.add_child(group_2d);
    filtering.add_child(group_unnormal);
    filtering.add_child(create_filtering_cube_tests());
    filtering.add_child(create_filtering_2d_array_tests());
    filtering.add_child(create_filtering_3d_tests());
    filtering
}
