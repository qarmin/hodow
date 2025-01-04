// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureShadowTests.cpp (Texture2DShadowTestInstance, `verifyTexCompareResult`, `checkTextureSupport` for 2D, populateTextureShadowTests' 2d group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `2d`, `cube`, `2d_array`, `cube_array`, `1d` and `1d_array` groups are ported (the 1D ones are verified through 2D references one texel high). The six lookup cases run
// in one `iterate`. The floating point depth clamp is applied to the reference texture built from the test texture.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::test_util::{
    Program, QUAD_POSITIONS, RenderRequest, SamplerParams, ShaderParameters, TexKind, pixels_to_surface,
    reference_texture_1d, reference_texture_1d_array, reference_texture_2d, reference_texture_2d_array,
    reference_texture_cube, reference_texture_cube_array, render_quad_2d, require_sparse_image_2d,
};
use crate::generated::shaders::texture_shadow_1d::{PROGRAM_1D_ARRAY_SHADOW, PROGRAM_1D_SHADOW};
use crate::generated::shaders::texture_shadow_cube_array::CUBE_ARRAY_SHADOW;
use crate::generated::shaders::texture_swizzle::{TSW_2D_ARRAY_SHADOW_NONE, TSW_2D_SHADOW_NONE, TSW_CUBE_SHADOW_NONE};
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, SamplerType, TextureType, compute_quad_tex_coord_1d, compute_quad_tex_coord_2d,
};
use crate::glu::texture_test_util_surface::{
    compute_quad_tex_coord_cube_array, compute_quad_tex_coord_cube_region, verify_tex_compare_result_2d,
    verify_tex_compare_result_2d_array, verify_tex_compare_result_cube, verify_tex_compare_result_cube_array,
};
use crate::tcu::pixel::{
    CompareMode, CubeFace, FilterMode, MipmapFilterMode, Sampler, WrapMode, fill_with_component_gradients2,
    fill_with_grid, get_texture_format_info,
};
use crate::tcu::tex_compare_verifier::TexComparePrecision;
use crate::tcu::tex_verifier::LodPrecision;
use crate::tcu::texture::{ChannelOrder, ChannelType};
use crate::tcu::{PixelFormat, TestError, TestOutcome, TestStatus, Vec2, Vec4};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::pipeline::image_util::create_test_texture;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const TEX2D_VIEWPORT_WIDTH: u32 = 64;
const TEX2D_VIEWPORT_HEIGHT: u32 = 64;
const TEXCUBE_VIEWPORT_SIZE: u32 = 28;

#[derive(Clone, Copy)]
struct ShadowFilter {
    name: &'static str,
    min: FilterMode,
    min_mip: Option<MipmapFilterMode>,
    mag: FilterMode,
}

const FILTERS: &[ShadowFilter] = &[
    ShadowFilter {
        name: "nearest",
        min: FilterMode::Nearest,
        min_mip: None,
        mag: FilterMode::Nearest,
    },
    ShadowFilter {
        name: "linear",
        min: FilterMode::Linear,
        min_mip: None,
        mag: FilterMode::Linear,
    },
    ShadowFilter {
        name: "nearest_mipmap_nearest",
        min: FilterMode::Nearest,
        min_mip: Some(MipmapFilterMode::Nearest),
        mag: FilterMode::Linear,
    },
    ShadowFilter {
        name: "linear_mipmap_nearest",
        min: FilterMode::Linear,
        min_mip: Some(MipmapFilterMode::Nearest),
        mag: FilterMode::Linear,
    },
    ShadowFilter {
        name: "nearest_mipmap_linear",
        min: FilterMode::Nearest,
        min_mip: Some(MipmapFilterMode::Linear),
        mag: FilterMode::Linear,
    },
    ShadowFilter {
        name: "linear_mipmap_linear",
        min: FilterMode::Linear,
        min_mip: Some(MipmapFilterMode::Linear),
        mag: FilterMode::Linear,
    },
];

const COMPARE_OPS: &[(&str, CompareMode, vk::CompareOp)] = &[
    ("less_or_equal", CompareMode::LessOrEqual, vk::CompareOp::LESS_OR_EQUAL),
    (
        "greater_or_equal",
        CompareMode::GreaterOrEqual,
        vk::CompareOp::GREATER_OR_EQUAL,
    ),
    ("less", CompareMode::Less, vk::CompareOp::LESS),
    ("greater", CompareMode::Greater, vk::CompareOp::GREATER),
    ("equal", CompareMode::Equal, vk::CompareOp::EQUAL),
    ("not_equal", CompareMode::NotEqual, vk::CompareOp::NOT_EQUAL),
    ("always", CompareMode::Always, vk::CompareOp::ALWAYS),
    ("never", CompareMode::Never, vk::CompareOp::NEVER),
];

const FORMATS: &[(&str, vk::Format, vk::ImageAspectFlags)] = &[
    ("d16_unorm", vk::Format::D16_UNORM, vk::ImageAspectFlags::DEPTH),
    (
        "x8_d24_unorm_pack32",
        vk::Format::X8_D24_UNORM_PACK32,
        vk::ImageAspectFlags::DEPTH,
    ),
    ("d32_sfloat", vk::Format::D32_SFLOAT, vk::ImageAspectFlags::DEPTH),
    (
        "d16_unorm_s8_uint",
        vk::Format::D16_UNORM_S8_UINT,
        vk::ImageAspectFlags::DEPTH,
    ),
    (
        "d24_unorm_s8_uint",
        vk::Format::D24_UNORM_S8_UINT,
        vk::ImageAspectFlags::DEPTH,
    ),
    (
        "d32_sfloat_s8_uint",
        vk::Format::D32_SFLOAT_S8_UINT,
        vk::ImageAspectFlags::DEPTH,
    ),
    ("r16_unorm", vk::Format::R16_UNORM, vk::ImageAspectFlags::COLOR),
    ("r32_sfloat", vk::Format::R32_SFLOAT, vk::ImageAspectFlags::COLOR),
];

/// (name prefix, sparse)
const BACKING_MODES: &[(&str, bool)] = &[("", false), ("sparse_", true)];

/// `Texture2DShadowTestCaseParameters`
#[derive(Clone, Copy)]
struct ShadowParameters {
    filter: ShadowFilter,
    format: vk::Format,
    sparse: bool,
    compare_mode: CompareMode,
    compare_op: vk::CompareOp,
    width: u32,
    height: u32,
    aspect_mask: vk::ImageAspectFlags,
}

/// `isFloatingPointDepthFormat`
fn is_floating_point_depth_format(order: ChannelOrder, type_: ChannelType) -> bool {
    (order == ChannelOrder::D && type_ == ChannelType::FLOAT)
        || (order == ChannelOrder::DS && type_ == ChannelType::FLOAT_UNSIGNED_INT_24_8_REV)
}

struct ShadowCase {
    name: String,
    params: ShadowParameters,
}

impl TestCase for ShadowCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkTextureSupport(Context&, const Texture2DShadowTestCaseParameters&)`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let mut properties3 = vk::FormatProperties3::default();
        let mut properties2 = vk::FormatProperties2::builder().push_next(&mut properties3);
        unsafe {
            context.get_instance().get_physical_device_format_properties2(
                context.get_physical_device(),
                self.params.format,
                &mut properties2,
            )
        };
        if !properties3
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags2::SAMPLED_IMAGE_DEPTH_COMPARISON)
        {
            return Err(TestError::NotSupported(
                "Format does not support shadow sampling".to_string(),
            ));
        }
        if self.params.sparse {
            require_sparse_image_2d(context)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        TSW_2D_SHADOW_NONE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShadowInstance {
            context,
            params: self.params,
        })
    }
}

struct ShadowInstance<'a> {
    context: &'a Context<'a>,
    params: ShadowParameters,
}

impl TestInstance for ShadowInstance<'_> {
    /// `Texture2DShadowTestInstance`'s constructor and `iterate`, every lookup case in turn
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
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
        let num_levels = textures[0].get_num_levels();

        // Fill first gradient texture.
        for level in 0..num_levels {
            fill_with_component_gradients2(
                &mut textures[0].get_level_mut(level, 0),
                [-0.5, -0.5, -0.5, 2.0],
                [1.0, 1.0, 1.0, 0.0],
            );
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
                })
            };
            fill_with_grid(
                &mut textures[1].get_level_mut(level, 0),
                4,
                color(0xff00_0000 | rgb),
                color(0xff00_0000 | !rgb),
            );
        }

        // Compute cases.
        let equal_or_not = matches!(params.compare_mode, CompareMode::Equal | CompareMode::NotEqual);
        let ref_in_range_upper = if equal_or_not { 1.0f32 } else { 0.5 };
        let ref_in_range_lower = if equal_or_not { 0.0f32 } else { 0.5 };
        let ref_out_of_bounds_upper = 1.1f32; // lookup function should clamp values to [0, 1] range
        let ref_out_of_bounds_lower = -0.1f32;
        let case_table = [
            (0usize, ref_in_range_upper, 1.6f32, 2.9f32, -1.0f32, -2.7f32),
            (0, ref_in_range_lower, -2.0, -1.35, -0.2, 0.7),
            (1, ref_in_range_upper, 0.14, 0.275, -1.5, -1.1),
            (1, ref_in_range_lower, -0.92, -2.64, 0.4, -0.1),
            (1, ref_out_of_bounds_upper, -0.39, -0.52, 0.65, 0.87),
            (1, ref_out_of_bounds_lower, -1.55, 0.65, 0.35, 0.91),
        ];

        let sampler = SamplerParams {
            wrap_u: vk::SamplerAddressMode::REPEAT,
            wrap_v: vk::SamplerAddressMode::REPEAT,
            wrap_w: vk::SamplerAddressMode::REPEAT,
            min_filter: if params.filter.min == FilterMode::Nearest {
                vk::Filter::NEAREST
            } else {
                vk::Filter::LINEAR
            },
            mag_filter: if params.filter.mag == FilterMode::Nearest {
                vk::Filter::NEAREST
            } else {
                vk::Filter::LINEAR
            },
            mipmap_mode: if params.filter.min_mip == Some(MipmapFilterMode::Linear) {
                vk::SamplerMipmapMode::LINEAR
            } else {
                vk::SamplerMipmapMode::NEAREST
            },
            min_lod: 0.0,
            max_lod: if params.filter.min_mip.is_some() { 1000.0 } else { 0.25 },
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            compare_op: Some(params.compare_op),
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        };

        for &(tex_ndx, reference, lod_x, lod_y, o_x, o_y) in &case_table {
            let texture = &textures[tex_ndx];
            let tex_format = texture.get_texture_format();
            let format_info = get_texture_format_info(tex_format);
            let s_x = lod_x.exp2() * TEX2D_VIEWPORT_WIDTH as f32 / params.width as f32;
            let s_y = lod_y.exp2() * TEX2D_VIEWPORT_HEIGHT as f32 / params.height as f32;
            let (min_coord, max_coord) = (Vec2::new(o_x, o_y), Vec2::new(o_x + s_x, o_y + s_y));

            // Setup params for reference.
            let tcu_sampler = Sampler {
                wrap_s: WrapMode::Repeat,
                wrap_t: WrapMode::Repeat,
                wrap_r: WrapMode::Repeat,
                filter: params.filter.min,
                normalized_coords: true,
                compare: params.compare_mode,
                compare_channel: 0,
                mip_filter: params.filter.min_mip,
                seamless_cube_map: true,
            };
            let mut sample_params = ReferenceParams::new(TextureType::Texture2D, tcu_sampler, LodMode::Exact);
            sample_params.mag_filter = Some(params.filter.mag);
            sample_params.base.sampler_type = SamplerType::Shadow;
            sample_params.base.color_bias = Vec4::new(
                format_info.look_up_bias[0],
                format_info.look_up_bias[1],
                format_info.look_up_bias[2],
                format_info.look_up_bias[3],
            );
            sample_params.base.color_scale = Vec4::new(
                format_info.look_up_scale[0],
                format_info.look_up_scale[1],
                format_info.look_up_scale[2],
                format_info.look_up_scale[3],
            );
            sample_params.base.ref_ = reference;
            log::info!("Compare reference value = {reference}");

            // Compute texture coordinates.
            log::info!(
                "Texture coordinates: {:?} -> {:?}",
                (min_coord.x(), min_coord.y()),
                (max_coord.x(), max_coord.y())
            );
            let tex_coord = compute_quad_tex_coord_2d(min_coord, max_coord);

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
                use_compute: false,
                sparse: params.sparse,
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
                program: Program::Shadow2D,
                parameters: ShaderParameters {
                    bias: sample_params.base.bias,
                    reference,
                    color_scale: format_info.look_up_scale,
                    color_bias: format_info.look_up_bias,
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, TEX2D_VIEWPORT_WIDTH, TEX2D_VIEWPORT_HEIGHT);

            // The sampling reference expects depth values in [0, 1] as a GL implementation would have after the upload clamped them
            let mut reference_texture = reference_texture_2d(texture, params.width, params.height);
            if is_floating_point_depth_format(tex_format.order, tex_format.type_) {
                for level in 0..reference_texture.num_levels() {
                    if reference_texture.is_level_empty(level) {
                        continue;
                    }
                    let mut access = reference_texture.level_mut(level);
                    let [width, height, depth] = access.size();
                    for z in 0..depth {
                        for y in 0..height {
                            for x in 0..width {
                                let clamped = access.get_pix_depth(x, y, z).clamp(0.0, 1.0);
                                access.set_pix_depth(clamped, x, y, z);
                            }
                        }
                    }
                }
            }

            let pixel_format = PixelFormat::new(8, 8, 8, 8);
            let mut lod_precision = LodPrecision {
                derivate_bits: 18,
                lod_bits: 6,
            };
            let mut compare_precision = TexComparePrecision {
                coord_bits: [20, 20, 0],
                uvw_bits: [7, 7, 0],
                pcf_bits: 5,
                reference_bits: 16,
                result_bits: pixel_format.red_bits - 1,
                ..TexComparePrecision::default()
            };

            let is_high_quality = verify_tex_compare_result_2d(
                &rendered,
                &reference_texture,
                tex_coord,
                &sample_params,
                &compare_precision,
                &lod_precision,
                pixel_format,
            )?;
            if !is_high_quality {
                log::info!("Warning: Verification assuming high-quality PCF filtering failed.");
                lod_precision.lod_bits = 4;
                compare_precision.uvw_bits = [4, 4, 0];
                compare_precision.pcf_bits = 0;

                let is_ok = verify_tex_compare_result_2d(
                    &rendered,
                    &reference_texture,
                    tex_coord,
                    &sample_params,
                    &compare_precision,
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

/// `checkTextureSupport(Context&, const Texture{2DArray,Cube}ShadowTestCaseParameters&)`
fn check_shadow_support(
    context: &Context<'_>,
    format: vk::Format,
    sparse: bool,
    seamless: bool,
) -> Result<(), TestError> {
    let mut properties3 = vk::FormatProperties3::default();
    let mut properties2 = vk::FormatProperties2::builder().push_next(&mut properties3);
    unsafe {
        context.get_instance().get_physical_device_format_properties2(
            context.get_physical_device(),
            format,
            &mut properties2,
        )
    };
    if !properties3
        .optimal_tiling_features
        .contains(vk::FormatFeatureFlags2::SAMPLED_IMAGE_DEPTH_COMPARISON)
    {
        return Err(TestError::NotSupported(
            "Format does not support shadow sampling".to_string(),
        ));
    }
    if !seamless {
        context.require_device_functionality("VK_EXT_non_seamless_cube_map")?;
    }
    if sparse {
        require_sparse_image_2d(context)?;
    }
    Ok(())
}

/// The shadow lookup reference values of the six cases of the 2D array and cube groups
fn shadow_references(compare_mode: CompareMode) -> (f32, f32, f32, f32) {
    let equal_or_not = matches!(compare_mode, CompareMode::Equal | CompareMode::NotEqual);
    (
        if equal_or_not { 1.0 } else { 0.5 },
        if equal_or_not { 0.0 } else { 0.5 },
        1.1,
        -0.1,
    )
}

fn tcu_sampler_for(params_filter: ShadowFilter, compare_mode: CompareMode, wrap: WrapMode, seamless: bool) -> Sampler {
    Sampler {
        wrap_s: wrap,
        wrap_t: wrap,
        wrap_r: wrap,
        filter: params_filter.min,
        normalized_coords: true,
        compare: compare_mode,
        compare_channel: 0,
        mip_filter: params_filter.min_mip,
        seamless_cube_map: seamless,
    }
}

fn vk_sampler_for(
    filter: ShadowFilter,
    compare_op: vk::CompareOp,
    wrap: vk::SamplerAddressMode,
    non_seamless: bool,
) -> SamplerParams {
    SamplerParams {
        wrap_u: wrap,
        wrap_v: wrap,
        wrap_w: wrap,
        min_filter: if filter.min == FilterMode::Nearest {
            vk::Filter::NEAREST
        } else {
            vk::Filter::LINEAR
        },
        mag_filter: if filter.mag == FilterMode::Nearest {
            vk::Filter::NEAREST
        } else {
            vk::Filter::LINEAR
        },
        mipmap_mode: if filter.min_mip == Some(MipmapFilterMode::Linear) {
            vk::SamplerMipmapMode::LINEAR
        } else {
            vk::SamplerMipmapMode::NEAREST
        },
        min_lod: 0.0,
        max_lod: if filter.min_mip.is_some() { 1000.0 } else { 0.25 },
        border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
        compare_op: Some(compare_op),
        unnormalized: false,
        non_seamless,
        max_anisotropy: None,
    }
}

/// Clamp the floating point depth of a reference texture level to [0, 1], as the upload of a GL implementation does
fn clamp_float_depth(access: &mut crate::tcu::pixel::PixelBufferAccess<'_>) {
    let [width, height, depth] = access.size();
    for z in 0..depth {
        for y in 0..height {
            for x in 0..width {
                let clamped = access.get_pix_depth(x, y, z).clamp(0.0, 1.0);
                access.set_pix_depth(clamped, x, y, z);
            }
        }
    }
}

const RGBA_MAPPING: vk::ComponentMapping = vk::ComponentMapping {
    r: vk::ComponentSwizzle::R,
    g: vk::ComponentSwizzle::G,
    b: vk::ComponentSwizzle::B,
    a: vk::ComponentSwizzle::A,
};

fn grid_color(packed: u32, c_scale: [f32; 4], c_bias: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|c| {
        (if c == 3 {
            255.0
        } else {
            ((packed >> (8 * c)) & 0xFF) as f32
        }) / 255.0
            * c_scale[c]
            + c_bias[c]
    })
}

/// `Texture2DArrayShadowTestCaseParameters`
#[derive(Clone, Copy)]
struct ShadowArrayParameters {
    filter: ShadowFilter,
    format: vk::Format,
    sparse: bool,
    compare_mode: CompareMode,
    compare_op: vk::CompareOp,
    width: u32,
    height: u32,
    num_layers: u32,
    aspect_mask: vk::ImageAspectFlags,
}

struct ShadowArrayCase {
    name: String,
    params: ShadowArrayParameters,
}

impl TestCase for ShadowArrayCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_shadow_support(context, self.params.format, self.params.sparse, true)
    }

    fn programs(&self) -> BinaryCollection {
        TSW_2D_ARRAY_SHADOW_NONE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShadowArrayInstance {
            context,
            params: self.params,
        })
    }
}

struct ShadowArrayInstance<'a> {
    context: &'a Context<'a>,
    params: ShadowArrayParameters,
}

impl TestInstance for ShadowArrayInstance<'_> {
    /// `Texture2DArrayShadowTestInstance`'s constructor and `iterate`, every lookup case in turn
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
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
        let num_levels = textures[0].get_num_levels();
        let format_info = get_texture_format_info(textures[0].get_texture_format());
        let c_bias = format_info.value_min;
        let c_scale: [f32; 4] = std::array::from_fn(|c| format_info.value_max[c] - format_info.value_min[c]);

        // Fill first gradient texture.
        for level in 0..num_levels {
            let g_min: [f32; 4] = std::array::from_fn(|c| [-0.5f32, -0.5, -0.5, 2.0][c] * c_scale[c] + c_bias[c]);
            let g_max: [f32; 4] = std::array::from_fn(|c| [1.0f32, 1.0, 1.0, 0.0][c] * c_scale[c] + c_bias[c]);
            fill_with_component_gradients2(&mut textures[0].level_all_layers_mut(level), g_min, g_max);
        }

        // Fill second with grid texture.
        for level in 0..num_levels {
            let step = 0x00ff_ffffu32 / num_levels as u32;
            let rgb = step * level as u32;
            fill_with_grid(
                &mut textures[1].level_all_layers_mut(level),
                4,
                grid_color(0xff00_0000 | rgb, c_scale, c_bias),
                grid_color(0xff00_0000 | !rgb, c_scale, c_bias),
            );
        }

        let (in_range_upper, in_range_lower, out_of_bounds_upper, out_of_bounds_lower) =
            shadow_references(params.compare_mode);
        let case_table = [
            (0usize, in_range_upper, 1.6f32, 2.9f32, -1.0f32, -2.7f32),
            (0, in_range_lower, -2.0, -1.35, -0.2, 0.7),
            (1, in_range_upper, 0.14, 0.275, -1.5, -1.1),
            (1, in_range_lower, -0.92, -2.64, 0.4, -0.1),
            (1, out_of_bounds_upper, -0.49, -0.22, 0.45, 0.97),
            (1, out_of_bounds_lower, -0.85, 0.75, 0.25, 0.61),
        ];
        let sampler = vk_sampler_for(params.filter, params.compare_op, vk::SamplerAddressMode::REPEAT, false);
        let (min_layer, max_layer) = (-0.5f32, params.num_layers as f32);

        for &(tex_ndx, reference, lod_x, lod_y, o_x, o_y) in &case_table {
            let texture = &textures[tex_ndx];
            let tex_format = texture.get_texture_format();
            let s_x = lod_x.exp2() * TEX2D_VIEWPORT_WIDTH as f32 / params.width as f32;
            let s_y = lod_y.exp2() * TEX2D_VIEWPORT_HEIGHT as f32 / params.height as f32;
            let (min_coord, max_coord) = ([o_x, o_y, min_layer], [o_x + s_x, o_y + s_y, max_layer]);
            let middle = (min_coord[2] + max_coord[2]) / 2.0;
            let tex_coord: [f32; 12] = [
                min_coord[0],
                min_coord[1],
                min_coord[2],
                min_coord[0],
                max_coord[1],
                middle,
                max_coord[0],
                min_coord[1],
                middle,
                max_coord[0],
                max_coord[1],
                max_coord[2],
            ];

            let mut sample_params = ReferenceParams::new(
                TextureType::Texture2DArray,
                tcu_sampler_for(params.filter, params.compare_mode, WrapMode::Repeat, true),
                LodMode::Exact,
            );
            sample_params.mag_filter = Some(params.filter.mag);
            sample_params.base.sampler_type = SamplerType::Shadow;
            sample_params.base.ref_ = reference;
            log::info!("Compare reference value = {reference}\nTexture coordinates: {min_coord:?} -> {max_coord:?}");

            let request = RenderRequest {
                texture,
                format: params.format,
                aspect_mask: params.aspect_mask,
                component_mapping: RGBA_MAPPING,
                use_compute: false,
                sparse: params.sparse,
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
                program: Program::Shadow2DArray,
                parameters: ShaderParameters {
                    bias: 0.0,
                    reference,
                    color_scale: [1.0; 4],
                    color_bias: [0.0; 4],
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, TEX2D_VIEWPORT_WIDTH, TEX2D_VIEWPORT_HEIGHT);

            let mut reference_texture =
                reference_texture_2d_array(texture, params.width, params.height, params.num_layers);
            if is_floating_point_depth_format(tex_format.order, tex_format.type_) {
                for level in 0..reference_texture.num_levels() {
                    if !reference_texture.is_level_empty(level) {
                        clamp_float_depth(&mut reference_texture.level_mut(level));
                    }
                }
            }

            let pixel_format = PixelFormat::new(8, 8, 8, 8);
            let mut lod_precision = LodPrecision {
                derivate_bits: 18,
                lod_bits: 6,
            };
            let mut compare_precision = TexComparePrecision {
                coord_bits: [20, 20, 20],
                uvw_bits: [7, 7, 7],
                pcf_bits: 5,
                reference_bits: 16,
                result_bits: pixel_format.red_bits - 1,
                ..TexComparePrecision::default()
            };
            let is_high_quality = verify_tex_compare_result_2d_array(
                &rendered,
                &reference_texture,
                tex_coord,
                &sample_params,
                &compare_precision,
                &lod_precision,
                pixel_format,
            )?;
            if !is_high_quality {
                log::info!("Warning: Verification assuming high-quality PCF filtering failed.");
                lod_precision.lod_bits = 4;
                compare_precision.uvw_bits = [4, 4, 4];
                compare_precision.pcf_bits = 0;
                if !verify_tex_compare_result_2d_array(
                    &rendered,
                    &reference_texture,
                    tex_coord,
                    &sample_params,
                    &compare_precision,
                    &lod_precision,
                    pixel_format,
                )? {
                    log::info!("ERROR: Verification against low precision requirements failed, failing test case.");
                    return Ok(TestStatus::fail("Image verification failed"));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `Texture{Cube}ShadowTestCaseParameters`
#[derive(Clone, Copy)]
struct ShadowCubeParameters {
    filter: ShadowFilter,
    format: vk::Format,
    sparse: bool,
    seamless: bool,
    compare_mode: CompareMode,
    compare_op: vk::CompareOp,
    size: u32,
    aspect_mask: vk::ImageAspectFlags,
}

struct ShadowCubeCase {
    name: String,
    params: ShadowCubeParameters,
}

impl TestCase for ShadowCubeCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_shadow_support(context, self.params.format, self.params.sparse, self.params.seamless)
    }

    fn programs(&self) -> BinaryCollection {
        TSW_CUBE_SHADOW_NONE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShadowCubeInstance {
            context,
            params: self.params,
        })
    }
}

struct ShadowCubeInstance<'a> {
    context: &'a Context<'a>,
    params: ShadowCubeParameters,
}

impl TestInstance for ShadowCubeInstance<'_> {
    /// `TextureCubeShadowTestInstance`'s constructor and `iterate`, every lookup case and face in turn
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let size = [params.size as i32, params.size as i32, 1];
        let mut textures = [
            create_test_texture(params.format, vk::ImageViewType::CUBE, size, 6)?,
            create_test_texture(params.format, vk::ImageViewType::CUBE, size, 6)?,
        ];
        let num_levels = textures[0].get_num_levels();
        let format_info = get_texture_format_info(textures[0].get_texture_format());
        let c_bias = format_info.value_min;
        let c_scale: [f32; 4] = std::array::from_fn(|c| format_info.value_max[c] - format_info.value_min[c]);

        // Fill first with gradient texture.
        let gradients: [[[f32; 4]; 2]; 6] = [
            [[-1.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]], // negative x
            [[0.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]],  // positive x
            [[-1.0, 0.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]],  // negative y
            [[-1.0, -1.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]],  // positive y
            [[-1.0, -1.0, -1.0, 0.0], [1.0, 1.0, 1.0, 1.0]], // negative z
            [[0.0, 0.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]],    // positive z
        ];
        for face in 0..6usize {
            for level in 0..num_levels {
                let g_min: [f32; 4] = std::array::from_fn(|c| gradients[face][0][c] * c_scale[c] + c_bias[c]);
                let g_max: [f32; 4] = std::array::from_fn(|c| gradients[face][1][c] * c_scale[c] + c_bias[c]);
                fill_with_component_gradients2(&mut textures[0].get_level_mut(level, face as u32), g_min, g_max);
            }
        }

        // Fill second with grid texture.
        for face in 0..6usize {
            for level in 0..num_levels {
                let step = 0x00ff_ffffu32 / (num_levels as u32 * 6);
                let rgb = step * level as u32 * face as u32;
                fill_with_grid(
                    &mut textures[1].get_level_mut(level, face as u32),
                    4,
                    grid_color(0xff00_0000 | rgb, c_scale, c_bias),
                    grid_color(0xff00_0000 | !rgb, c_scale, c_bias),
                );
            }
        }

        let (in_range_upper, in_range_lower, out_of_bounds_upper, out_of_bounds_lower) =
            shadow_references(params.compare_mode);
        let cases: [(usize, f32, Vec2, Vec2); 6] = [
            (0, in_range_upper, Vec2::new(-1.25, -1.2), Vec2::new(1.2, 1.25)), // minification
            (0, in_range_lower, Vec2::new(0.8, 0.8), Vec2::new(1.25, 1.20)),   // magnification
            (1, in_range_upper, Vec2::new(-1.19, -1.3), Vec2::new(1.1, 1.35)), // minification
            (1, in_range_lower, Vec2::new(-1.2, -1.1), Vec2::new(-0.8, -0.8)), // magnification
            (1, out_of_bounds_upper, Vec2::new(-0.61, -0.1), Vec2::new(0.9, 1.18)), // reference value clamp, upper
            (1, out_of_bounds_lower, Vec2::new(-0.75, 1.0), Vec2::new(0.05, 0.75)), // reference value clamp, lower
        ];
        let sampler = vk_sampler_for(
            params.filter,
            params.compare_op,
            vk::SamplerAddressMode::CLAMP_TO_EDGE,
            !params.seamless,
        );

        for &(tex_ndx, reference, bottom_left, top_right) in &cases {
            let texture = &textures[tex_ndx];
            let tex_format = texture.get_texture_format();
            let mut sample_params = ReferenceParams::new(
                TextureType::Cube,
                tcu_sampler_for(
                    params.filter,
                    params.compare_mode,
                    WrapMode::ClampToEdge,
                    params.seamless,
                ),
                LodMode::Exact,
            );
            sample_params.mag_filter = Some(params.filter.mag);
            sample_params.base.sampler_type = SamplerType::Shadow;
            sample_params.base.ref_ = reference;
            log::info!(
                "Compare reference value = {reference}\nCoordinates: {:?} -> {:?}",
                (bottom_left.x(), bottom_left.y()),
                (top_right.x(), top_right.y())
            );

            let mut reference_texture = reference_texture_cube(texture, params.size);
            if is_floating_point_depth_format(tex_format.order, tex_format.type_) {
                for level in 0..reference_texture.num_levels() {
                    if !reference_texture.is_level_empty(level) {
                        clamp_float_depth(&mut reference_texture.level_mut(level));
                    }
                }
            }

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
                let request = RenderRequest {
                    texture,
                    format: params.format,
                    aspect_mask: params.aspect_mask,
                    component_mapping: RGBA_MAPPING,
                    use_compute: false,
                    sparse: params.sparse,
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
                    program: Program::ShadowCube,
                    parameters: ShaderParameters {
                        bias: 0.0,
                        reference,
                        color_scale: [1.0; 4],
                        color_bias: [0.0; 4],
                        lod: 0,
                    },
                };
                let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
                let result = pixels_to_surface(&pixels, TEXCUBE_VIEWPORT_SIZE, TEXCUBE_VIEWPORT_SIZE);

                let pixel_format = PixelFormat::new(8, 8, 8, 8);
                let mut lod_precision = LodPrecision {
                    derivate_bits: 10,
                    lod_bits: 5,
                };
                let mut compare_precision = TexComparePrecision {
                    coord_bits: [10, 10, 10],
                    uvw_bits: [6, 6, 0],
                    pcf_bits: 5,
                    reference_bits: 16,
                    result_bits: pixel_format.red_bits - 1,
                    ..TexComparePrecision::default()
                };
                let is_high_quality = verify_tex_compare_result_cube(
                    &result,
                    &reference_texture,
                    tex_coord,
                    &sample_params,
                    &compare_precision,
                    &lod_precision,
                    pixel_format,
                )?;
                if !is_high_quality {
                    log::info!("Warning: Verification assuming high-quality PCF filtering failed.");
                    lod_precision.lod_bits = 4;
                    compare_precision.uvw_bits = [4, 4, 0];
                    compare_precision.pcf_bits = 0;
                    if !verify_tex_compare_result_cube(
                        &result,
                        &reference_texture,
                        tex_coord,
                        &sample_params,
                        &compare_precision,
                        &lod_precision,
                        pixel_format,
                    )? {
                        log::info!("ERROR: Verification against low precision requirements failed, failing test case.");
                        return Ok(TestStatus::fail("Image verification failed"));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `TextureCubeArrayShadowTestCaseParameters`
#[derive(Clone, Copy)]
struct ShadowCubeArrayParameters {
    filter: ShadowFilter,
    format: vk::Format,
    sparse: bool,
    seamless: bool,
    compare_mode: CompareMode,
    compare_op: vk::CompareOp,
    size: u32,
    num_layers: u32,
    aspect_mask: vk::ImageAspectFlags,
}

struct ShadowCubeArrayCase {
    name: String,
    params: ShadowCubeArrayParameters,
}

impl TestCase for ShadowCubeArrayCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().image_cube_array == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: imageCubeArray".to_string(),
            ));
        }
        check_shadow_support(context, self.params.format, self.params.sparse, self.params.seamless)
    }

    fn programs(&self) -> BinaryCollection {
        CUBE_ARRAY_SHADOW.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShadowCubeArrayInstance {
            context,
            params: self.params,
        })
    }
}

struct ShadowCubeArrayInstance<'a> {
    context: &'a Context<'a>,
    params: ShadowCubeArrayParameters,
}

impl TestInstance for ShadowCubeArrayInstance<'_> {
    /// `TextureCubeArrayShadowTestInstance`'s constructor and `iterate`, every lookup case and every face of every layer in turn
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let size = [params.size as i32, params.size as i32, 1];
        let mut textures = [
            create_test_texture(
                params.format,
                vk::ImageViewType::CUBE_ARRAY,
                size,
                params.num_layers as i32,
            )?,
            create_test_texture(
                params.format,
                vk::ImageViewType::CUBE_ARRAY,
                size,
                params.num_layers as i32,
            )?,
        ];
        let num_levels = params.size.ilog2() as usize + 1;
        let format_info = get_texture_format_info(textures[0].get_texture_format());
        let c_bias = format_info.value_min;
        let c_scale: [f32; 4] = std::array::from_fn(|c| format_info.value_max[c] - format_info.value_min[c]);

        // Fill first with gradient texture.
        let gradients: [[[f32; 4]; 2]; 6] = [
            [[-1.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]], // negative x
            [[0.0, -1.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]],  // positive x
            [[-1.0, 0.0, -1.0, 2.0], [1.0, 1.0, 1.0, 0.0]],  // negative y
            [[-1.0, -1.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]],  // positive y
            [[-1.0, -1.0, -1.0, 0.0], [1.0, 1.0, 1.0, 1.0]], // negative z
            [[0.0, 0.0, 0.0, 2.0], [1.0, 1.0, 1.0, 0.0]],    // positive z
        ];
        for layer_face in 0..params.num_layers {
            let face = (layer_face % 6) as usize;
            let layer = layer_face / 6;
            let g_min: [f32; 4] =
                std::array::from_fn(|c| gradients[face][0][c] / (layer + 1) as f32 * c_scale[c] + c_bias[c]);
            let g_max: [f32; 4] =
                std::array::from_fn(|c| gradients[face][1][c] / (layer + 1) as f32 * c_scale[c] + c_bias[c]);
            for level in 0..num_levels {
                fill_with_component_gradients2(&mut textures[0].get_level_mut(level, layer_face), g_min, g_max);
            }
        }

        // Fill second with grid texture.
        for layer_face in 0..params.num_layers {
            let face = layer_face % 6;
            let layer = layer_face / 6;
            let cell_size = 4 + layer;
            for level in 0..num_levels {
                let step = 0x00ff_ffffu32 / (num_levels as u32 * 6);
                let rgb = step * level as u32 * face;
                fill_with_grid(
                    &mut textures[1].get_level_mut(level, layer_face),
                    cell_size,
                    grid_color(0xff00_0000 | rgb, c_scale, c_bias),
                    grid_color(0xff00_0000 | !rgb, c_scale, c_bias),
                );
            }
        }

        let (in_range_upper, in_range_lower, out_of_bounds_upper, out_of_bounds_lower) =
            shadow_references(params.compare_mode);
        let cases: [(usize, f32, Vec2, Vec2); 6] = [
            (0, in_range_upper, Vec2::new(-1.25, -1.2), Vec2::new(1.2, 1.25)), // minification
            (0, in_range_lower, Vec2::new(0.8, 0.8), Vec2::new(1.25, 1.20)),   // magnification
            (1, in_range_upper, Vec2::new(-1.19, -1.3), Vec2::new(1.1, 1.35)), // minification
            (1, in_range_lower, Vec2::new(-1.2, -1.1), Vec2::new(-0.8, -0.8)), // magnification
            (1, out_of_bounds_upper, Vec2::new(-0.61, -0.1), Vec2::new(0.9, 1.18)), // reference value clamp, upper
            (1, out_of_bounds_lower, Vec2::new(-0.75, 1.0), Vec2::new(0.05, 0.75)), // reference value clamp, lower
        ];
        let sampler = vk_sampler_for(
            params.filter,
            params.compare_op,
            vk::SamplerAddressMode::CLAMP_TO_EDGE,
            !params.seamless,
        );
        let cube_layers = params.num_layers / 6;

        for &(tex_ndx, reference, bottom_left, top_right) in &cases {
            let texture = &textures[tex_ndx];
            let tex_format = texture.get_texture_format();
            let mut sample_params = ReferenceParams::new(
                TextureType::CubeArray,
                tcu_sampler_for(
                    params.filter,
                    params.compare_mode,
                    WrapMode::ClampToEdge,
                    params.seamless,
                ),
                LodMode::Exact,
            );
            sample_params.mag_filter = Some(params.filter.mag);
            sample_params.base.sampler_type = SamplerType::Shadow;
            sample_params.base.ref_ = reference;
            log::info!(
                "Compare reference value = {reference}\nCoordinates: {:?} -> {:?}",
                (bottom_left.x(), bottom_left.y()),
                (top_right.x(), top_right.y())
            );

            let mut reference_texture = reference_texture_cube_array(texture, params.size, cube_layers);
            if is_floating_point_depth_format(tex_format.order, tex_format.type_) {
                for level in 0..reference_texture.num_levels() {
                    if !reference_texture.is_level_empty(level) {
                        clamp_float_depth(&mut reference_texture.level_mut(level));
                    }
                }
            }

            for layer_face in 0..params.num_layers {
                let face = [
                    CubeFace::NegativeX,
                    CubeFace::PositiveX,
                    CubeFace::NegativeY,
                    CubeFace::PositiveY,
                    CubeFace::NegativeZ,
                    CubeFace::PositiveZ,
                ][(layer_face % 6) as usize];
                let layer = layer_face / 6;
                let min_layer = -0.5 + layer as f32;
                let max_layer = params.num_layers as f32;
                let tex_coord =
                    compute_quad_tex_coord_cube_array(face, bottom_left, top_right, Vec2::new(min_layer, max_layer));
                log::info!("Face {face:?} at layer {layer}");
                let request = RenderRequest {
                    texture,
                    format: params.format,
                    aspect_mask: params.aspect_mask,
                    component_mapping: RGBA_MAPPING,
                    use_compute: false,
                    sparse: params.sparse,
                    width: TEXCUBE_VIEWPORT_SIZE,
                    height: TEXCUBE_VIEWPORT_SIZE,
                    tex_width: params.size,
                    tex_height: params.size,
                    tex_depth: params.num_layers,
                    kind: TexKind::CubeArray,
                    sampler,
                    tex_coord: &tex_coord,
                    positions: QUAD_POSITIONS,
                    view_levels: None,
                    view_min_lod: None,
                    output_format: vk::Format::R8G8B8A8_UNORM,
                    program: Program::ShadowCubeArray,
                    parameters: ShaderParameters {
                        bias: 0.0,
                        reference,
                        color_scale: [1.0; 4],
                        color_bias: [0.0; 4],
                        lod: 0,
                    },
                };
                let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
                let result = pixels_to_surface(&pixels, TEXCUBE_VIEWPORT_SIZE, TEXCUBE_VIEWPORT_SIZE);

                let pixel_format = PixelFormat::new(8, 8, 8, 8);
                let mut lod_precision = LodPrecision {
                    derivate_bits: 10,
                    lod_bits: 5,
                };
                let mut compare_precision = TexComparePrecision {
                    coord_bits: [10, 10, 10],
                    uvw_bits: [6, 6, 0],
                    pcf_bits: 5,
                    reference_bits: 16,
                    result_bits: pixel_format.red_bits - 1,
                    ..TexComparePrecision::default()
                };
                let is_high_quality = verify_tex_compare_result_cube_array(
                    &result,
                    &reference_texture,
                    tex_coord,
                    &sample_params,
                    &compare_precision,
                    &lod_precision,
                    pixel_format,
                )?;
                if !is_high_quality {
                    log::info!("Warning: Verification assuming high-quality PCF filtering failed.");
                    lod_precision.lod_bits = 4;
                    compare_precision.uvw_bits = [4, 4, 0];
                    compare_precision.pcf_bits = 0;
                    if !verify_tex_compare_result_cube_array(
                        &result,
                        &reference_texture,
                        tex_coord,
                        &sample_params,
                        &compare_precision,
                        &lod_precision,
                        pixel_format,
                    )? {
                        log::info!("ERROR: Verification against low precision requirements failed, failing test case.");
                        return Ok(TestStatus::fail("Image verification failed"));
                    }
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

const TEX1D_VIEWPORT_WIDTH: u32 = 64;

/// `Texture1DShadowTestCaseParameters` and `Texture1DArrayShadowTestCaseParameters`, `num_layers` is `Some` for the array
#[derive(Clone, Copy)]
struct Shadow1dParameters {
    filter: ShadowFilter,
    format: vk::Format,
    compare_mode: CompareMode,
    compare_op: vk::CompareOp,
    width: u32,
    num_layers: Option<u32>,
    aspect_mask: vk::ImageAspectFlags,
}

struct Shadow1dCase {
    name: String,
    params: Shadow1dParameters,
}

impl TestCase for Shadow1dCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_shadow_support(context, self.params.format, false, true)
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.num_layers.is_some() {
            PROGRAM_1D_ARRAY_SHADOW.programs
        } else {
            PROGRAM_1D_SHADOW.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(Shadow1dInstance {
            context,
            params: self.params,
        })
    }
}

struct Shadow1dInstance<'a> {
    context: &'a Context<'a>,
    params: Shadow1dParameters,
}

impl TestInstance for Shadow1dInstance<'_> {
    /// `Texture1D{,Array}ShadowTestInstance`'s constructor and `iterate`. The reference textures are held as 2D ones one texel high and
    /// verified through the 2D lookups with `t = 0.5`: every row of such a texture is the same, so they see the texels a 1D lookup does.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let layers = params.num_layers.unwrap_or(1);
        let view_type = if params.num_layers.is_some() {
            vk::ImageViewType::_1D_ARRAY
        } else {
            vk::ImageViewType::_1D
        };
        let size = [params.width as i32, 1, 1];
        let mut textures = [
            create_test_texture(params.format, view_type, size, layers as i32)?,
            create_test_texture(params.format, view_type, size, layers as i32)?,
        ];
        let num_levels = params.width.ilog2() as usize + 1;
        let format_info = get_texture_format_info(textures[0].get_texture_format());
        let c_bias = format_info.value_min;
        let c_scale: [f32; 4] = std::array::from_fn(|c| format_info.value_max[c] - format_info.value_min[c]);
        let (scale, bias) = if params.num_layers.is_some() {
            (c_scale, c_bias)
        } else {
            ([1.0; 4], [0.0; 4])
        };

        // Fill first with gradient texture.
        let g_min: [f32; 4] = std::array::from_fn(|c| [-0.5, -0.5, -0.5, 2.0][c] * scale[c] + bias[c]);
        let g_max: [f32; 4] = std::array::from_fn(|c| [1.0, 1.0, 1.0, 0.0][c] * scale[c] + bias[c]);
        for level in 0..num_levels {
            if params.num_layers.is_some() {
                fill_with_component_gradients2(&mut textures[0].level_all_layers_mut(level), g_min, g_max);
            } else {
                fill_with_component_gradients2(&mut textures[0].get_level_mut(level, 0), g_min, g_max);
            }
        }

        // Fill second with grid texture.
        for level in 0..num_levels {
            let step = 0x00ff_ffffu32 / num_levels as u32;
            let rgb = step * level as u32;
            let color_a = grid_color(0xff00_0000 | rgb, scale, bias);
            let color_b = grid_color(0xff00_0000 | !rgb, scale, bias);
            if params.num_layers.is_some() {
                fill_with_grid(&mut textures[1].level_all_layers_mut(level), 4, color_a, color_b);
            } else {
                fill_with_grid(&mut textures[1].get_level_mut(level, 0), 4, color_a, color_b);
            }
        }

        let (in_range_upper, in_range_lower, out_of_bounds_upper, out_of_bounds_lower) =
            shadow_references(params.compare_mode);
        let case_table: [(usize, f32, f32, f32); 6] = if params.num_layers.is_some() {
            [
                (0, in_range_upper, 1.6, -1.0),
                (0, in_range_lower, -2.0, -0.2),
                (1, in_range_upper, 0.14, -1.5),
                (1, in_range_lower, -0.92, 0.4),
                (1, out_of_bounds_upper, -0.49, 0.45),
                (1, out_of_bounds_lower, -0.85, 0.25),
            ]
        } else {
            [
                (0, in_range_upper, 1.6, -1.0),
                (0, in_range_lower, -2.0, -0.2),
                (1, in_range_upper, 0.14, -1.5),
                (1, in_range_lower, -0.92, 0.4),
                (1, out_of_bounds_upper, -0.39, 0.65),
                (1, out_of_bounds_lower, -1.55, 0.35),
            ]
        };
        let sampler = vk_sampler_for(params.filter, params.compare_op, vk::SamplerAddressMode::REPEAT, false);

        for &(tex_ndx, reference, lod_x, o_x) in &case_table {
            let texture = &textures[tex_ndx];
            let tex_format = texture.get_texture_format();
            let lookup_info = get_texture_format_info(tex_format);
            let s_x = lod_x.exp2() * TEX1D_VIEWPORT_WIDTH as f32 / params.width as f32;
            let (min_coord_x, max_coord_x) = (o_x, o_x + s_x);

            let mut sample_params = ReferenceParams::new(
                if params.num_layers.is_some() {
                    TextureType::Texture2DArray
                } else {
                    TextureType::Texture2D
                },
                tcu_sampler_for(params.filter, params.compare_mode, WrapMode::Repeat, false),
                LodMode::Exact,
            );
            sample_params.mag_filter = Some(params.filter.mag);
            sample_params.base.sampler_type = SamplerType::Shadow;
            sample_params.base.ref_ = reference;
            let (color_scale, color_bias) = if params.num_layers.is_some() {
                ([1.0; 4], [0.0; 4])
            } else {
                (lookup_info.look_up_scale, lookup_info.look_up_bias)
            };
            if params.num_layers.is_none() {
                sample_params.base.color_bias = Vec4::new(color_bias[0], color_bias[1], color_bias[2], color_bias[3]);
                sample_params.base.color_scale =
                    Vec4::new(color_scale[0], color_scale[1], color_scale[2], color_scale[3]);
            }
            log::info!("Compare reference value = {reference}\nTexture coordinates: {min_coord_x} -> {max_coord_x}");

            // One coordinate per vertex for a 1D texture, (s, layer) for an array; the verifier gets (s, 0.5[, layer])
            let (render_coord, tex_coord_2d, tex_coord_2d_array): (Vec<f32>, [f32; 8], [f32; 12]) =
                if let Some(num_layers) = params.num_layers {
                    let min_layer = -0.5f32;
                    let max_layer = num_layers as f32;
                    let mid_layer = (min_layer + max_layer) / 2.0;
                    let render_coord = vec![
                        min_coord_x,
                        min_layer,
                        min_coord_x,
                        mid_layer,
                        max_coord_x,
                        mid_layer,
                        max_coord_x,
                        max_layer,
                    ];
                    let array_coord = [
                        min_coord_x,
                        0.5,
                        min_layer,
                        min_coord_x,
                        0.5,
                        mid_layer,
                        max_coord_x,
                        0.5,
                        mid_layer,
                        max_coord_x,
                        0.5,
                        max_layer,
                    ];
                    (render_coord, [0.0; 8], array_coord)
                } else {
                    let coord_1d = compute_quad_tex_coord_1d(min_coord_x, max_coord_x);
                    let coord_2d: [f32; 8] = std::array::from_fn(|i| if i % 2 == 0 { coord_1d[i / 2] } else { 0.5 });
                    (coord_1d.to_vec(), coord_2d, [0.0; 12])
                };

            let request = RenderRequest {
                texture,
                format: params.format,
                aspect_mask: params.aspect_mask,
                component_mapping: RGBA_MAPPING,
                use_compute: false,
                sparse: false,
                width: TEX1D_VIEWPORT_WIDTH,
                height: 1,
                tex_width: params.width,
                tex_height: 1,
                tex_depth: layers,
                kind: if params.num_layers.is_some() {
                    TexKind::D1Array
                } else {
                    TexKind::D1
                },
                sampler,
                tex_coord: &render_coord,
                positions: QUAD_POSITIONS,
                view_levels: None,
                view_min_lod: None,
                output_format: vk::Format::R8G8B8A8_UNORM,
                program: if params.num_layers.is_some() {
                    Program::ShadowD1Array
                } else {
                    Program::ShadowD1
                },
                parameters: ShaderParameters {
                    bias: 0.0,
                    reference,
                    color_scale,
                    color_bias,
                    lod: 0,
                },
            };
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, TEX1D_VIEWPORT_WIDTH, 1);

            let pixel_format = PixelFormat::new(8, 8, 8, 8);
            let mut lod_precision = LodPrecision {
                derivate_bits: 18,
                lod_bits: 6,
            };
            let mut compare_precision = TexComparePrecision {
                coord_bits: if params.num_layers.is_some() {
                    [20, 20, 20]
                } else {
                    [20, 20, 0]
                },
                uvw_bits: if params.num_layers.is_some() {
                    [7, 7, 7]
                } else {
                    [7, 7, 0]
                },
                pcf_bits: 5,
                reference_bits: 16,
                result_bits: pixel_format.red_bits - 1,
                ..TexComparePrecision::default()
            };

            let floating_point = is_floating_point_depth_format(tex_format.order, tex_format.type_);
            let verify =
                |compare_precision: &TexComparePrecision, lod_precision: &LodPrecision| -> Result<bool, TestError> {
                    if let Some(num_layers) = params.num_layers {
                        let mut reference_texture = reference_texture_1d_array(texture, params.width, num_layers);
                        if floating_point {
                            for level in 0..reference_texture.num_levels() {
                                if !reference_texture.is_level_empty(level) {
                                    clamp_float_depth(&mut reference_texture.level_mut(level));
                                }
                            }
                        }
                        verify_tex_compare_result_2d_array(
                            &rendered,
                            &reference_texture,
                            tex_coord_2d_array,
                            &sample_params,
                            compare_precision,
                            lod_precision,
                            pixel_format,
                        )
                    } else {
                        let mut reference_texture = reference_texture_1d(texture, params.width);
                        if floating_point {
                            for level in 0..reference_texture.num_levels() {
                                if !reference_texture.is_level_empty(level) {
                                    clamp_float_depth(&mut reference_texture.level_mut(level));
                                }
                            }
                        }
                        verify_tex_compare_result_2d(
                            &rendered,
                            &reference_texture,
                            tex_coord_2d,
                            &sample_params,
                            compare_precision,
                            lod_precision,
                            pixel_format,
                        )
                    }
                };

            if !verify(&compare_precision, &lod_precision)? {
                log::info!("Warning: Verification assuming high-quality PCF filtering failed.");
                lod_precision.lod_bits = 4;
                compare_precision.uvw_bits = if params.num_layers.is_some() {
                    [4, 4, 4]
                } else {
                    [4, 4, 0]
                };
                compare_precision.pcf_bits = 0;
                if !verify(&compare_precision, &lod_precision)? {
                    log::info!("ERROR: Verification against low precision requirements failed, failing test case.");
                    return Ok(TestStatus::fail("Image verification failed"));
                }
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

const SEAM_MODES: &[(&str, bool)] = &[("", true), ("non_seamless_", false)];

/// `populateTextureShadowTests`, the `2d` group, below a `shadow` group
pub fn create_texture_shadow_tests() -> TestCaseGroup {
    let mut group_2d = TestCaseGroup::new("2d");
    for filter in FILTERS {
        let mut filter_group = TestCaseGroup::new(filter.name);
        for &(compare_name, compare_mode, compare_op) in COMPARE_OPS {
            for &(format_name, format, aspect_mask) in FORMATS {
                for &(backing_name, sparse) in BACKING_MODES {
                    let params = ShadowParameters {
                        filter: *filter,
                        format,
                        sparse,
                        compare_mode,
                        compare_op,
                        width: 32,
                        height: 64,
                        aspect_mask,
                    };
                    filter_group.add_child(Box::new(ShadowCase {
                        name: format!("{backing_name}{compare_name}_{format_name}"),
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
        group_2d.add_child(filter_group);
    }

    // Cubemap cases.
    let mut group_cube = TestCaseGroup::new("cube");
    for filter in FILTERS {
        let mut filter_group = TestCaseGroup::new(filter.name);
        for &(compare_name, compare_mode, compare_op) in COMPARE_OPS {
            for &(format_name, format, aspect_mask) in FORMATS {
                for &(backing_name, sparse) in BACKING_MODES {
                    for &(seam_name, seamless) in SEAM_MODES {
                        let params = ShadowCubeParameters {
                            filter: *filter,
                            format,
                            sparse,
                            seamless,
                            compare_mode,
                            compare_op,
                            size: 32,
                            aspect_mask,
                        };
                        filter_group.add_child(Box::new(ShadowCubeCase {
                            name: format!("{backing_name}{seam_name}{compare_name}_{format_name}"),
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }
        group_cube.add_child(filter_group);
    }

    // 2D array cases.
    let mut group_2d_array = TestCaseGroup::new("2d_array");
    for filter in FILTERS {
        let mut filter_group = TestCaseGroup::new(filter.name);
        for &(compare_name, compare_mode, compare_op) in COMPARE_OPS {
            for &(format_name, format, aspect_mask) in FORMATS {
                for &(backing_name, sparse) in BACKING_MODES {
                    let params = ShadowArrayParameters {
                        filter: *filter,
                        format,
                        sparse,
                        compare_mode,
                        compare_op,
                        width: 32,
                        height: 64,
                        num_layers: 8,
                        aspect_mask,
                    };
                    filter_group.add_child(Box::new(ShadowArrayCase {
                        name: format!("{backing_name}{compare_name}_{format_name}"),
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
        group_2d_array.add_child(filter_group);
    }

    let mut group_cube_array = TestCaseGroup::new("cube_array");
    for filter in FILTERS {
        let mut filter_group = TestCaseGroup::new(filter.name);
        for &(compare_name, compare_mode, compare_op) in COMPARE_OPS {
            for &(format_name, format, aspect_mask) in FORMATS {
                for &(backing_name, sparse) in BACKING_MODES {
                    for &(seam_name, seamless) in SEAM_MODES {
                        let params = ShadowCubeArrayParameters {
                            filter: *filter,
                            format,
                            sparse,
                            seamless,
                            compare_mode,
                            compare_op,
                            size: 32,
                            num_layers: 4 * 6,
                            aspect_mask,
                        };
                        filter_group.add_child(Box::new(ShadowCubeArrayCase {
                            name: format!("{backing_name}{seam_name}{compare_name}_{format_name}"),
                            params,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }
        group_cube_array.add_child(filter_group);
    }

    let mut group_1d = TestCaseGroup::new("1d");
    let mut group_1d_array = TestCaseGroup::new("1d_array");
    for (group, num_layers) in [(&mut group_1d, None), (&mut group_1d_array, Some(8))] {
        for filter in FILTERS {
            let mut filter_group = TestCaseGroup::new(filter.name);
            for &(compare_name, compare_mode, compare_op) in COMPARE_OPS {
                for &(format_name, format, aspect_mask) in FORMATS {
                    let params = Shadow1dParameters {
                        filter: *filter,
                        format,
                        compare_mode,
                        compare_op,
                        width: 32,
                        num_layers,
                        aspect_mask,
                    };
                    filter_group.add_child(Box::new(Shadow1dCase {
                        name: format!("{compare_name}_{format_name}"),
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
            group.add_child(filter_group);
        }
    }

    let mut shadow = TestCaseGroup::new("shadow");
    shadow.add_child(group_1d);
    shadow.add_child(group_1d_array);
    shadow.add_child(group_2d);
    shadow.add_child(group_cube);
    shadow.add_child(group_2d_array);
    shadow.add_child(group_cube_array);
    shadow.add_child(super::misc_amber_tests::create_texel_replacement_group());
    shadow
}
