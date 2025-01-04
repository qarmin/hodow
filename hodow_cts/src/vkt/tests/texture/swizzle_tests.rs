// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureSwizzleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The texture
// coordinate swizzle of the reference is applied to the quad's coordinates before they reach the shared 2D reference sampler instead of to the per-triangle coordinates inside the case.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::test_util::{
    Program, QUAD_POSITIONS, RenderRequest, SamplerParams, ShaderParameters, TexKind, render_quad_2d,
};
use crate::generated::shaders::texture_swizzle::*;
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, SamplerType, TextureType, compute_quad_tex_coord_2d, get_sampler_type,
};
use crate::glu::texture_test_util_surface::{compare_images, sample_texture_2d_to_surface};
use crate::tcu::pixel::{
    CompareMode, FilterMode, Sampler, WrapMode, get_texture_format_bit_depth, get_texture_format_info,
};
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::texture_2d::Texture2D as RefTexture2D;
use crate::tcu::{PixelFormat, RGBA, Surface, TestError, TestOutcome, TestStatus, Vec2, Vec4, map_vk_format};
use crate::vk::compressed_formats::is_compressed_format;
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::pipeline::image_util::{create_test_texture, format_case_name};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMATS_2D: &[(vk::Format, Program)] = &[
    (vk::Format::R4G4_UNORM_PACK8, Program::Float2D),
    (vk::Format::R4G4B4A4_UNORM_PACK16, Program::Float2D),
    (vk::Format::R5G6B5_UNORM_PACK16, Program::Float2D),
    (vk::Format::R5G5B5A1_UNORM_PACK16, Program::Float2D),
    (vk::Format::R8_UNORM, Program::Float2D),
    (vk::Format::R8_SNORM, Program::FloatBias2D),
    (vk::Format::R8_UINT, Program::Uint2D),
    (vk::Format::R8_SINT, Program::IntBias2D),
    (vk::Format::R8_SRGB, Program::Float2D),
    (vk::Format::R8G8_UNORM, Program::Float2D),
    (vk::Format::R8G8_SNORM, Program::FloatBias2D),
    (vk::Format::R8G8_UINT, Program::Uint2D),
    (vk::Format::R8G8_SINT, Program::IntBias2D),
    (vk::Format::R8G8_SRGB, Program::Float2D),
    (vk::Format::R8G8B8_UNORM, Program::Float2D),
    (vk::Format::R8G8B8_SNORM, Program::FloatBias2D),
    (vk::Format::R8G8B8_UINT, Program::Uint2D),
    (vk::Format::R8G8B8_SINT, Program::IntBias2D),
    (vk::Format::R8G8B8_SRGB, Program::Float2D),
    (vk::Format::R8G8B8A8_UNORM, Program::Float2D),
    (vk::Format::R8G8B8A8_SNORM, Program::FloatBias2D),
    (vk::Format::R8G8B8A8_UINT, Program::Uint2D),
    (vk::Format::R8G8B8A8_SINT, Program::IntBias2D),
    (vk::Format::R8G8B8A8_SRGB, Program::Float2D),
    (vk::Format::A2R10G10B10_UNORM_PACK32, Program::Float2D),
    (vk::Format::A2R10G10B10_UINT_PACK32, Program::Uint2D),
    (vk::Format::R16_UNORM, Program::Float2D),
    (vk::Format::R16_SNORM, Program::FloatBias2D),
    (vk::Format::R16_UINT, Program::Uint2D),
    (vk::Format::R16_SINT, Program::IntBias2D),
    (vk::Format::R16_SFLOAT, Program::FloatBias2D),
    (vk::Format::R16G16_UNORM, Program::Float2D),
    (vk::Format::R16G16_SNORM, Program::FloatBias2D),
    (vk::Format::R16G16_UINT, Program::Uint2D),
    (vk::Format::R16G16_SINT, Program::IntBias2D),
    (vk::Format::R16G16_SFLOAT, Program::FloatBias2D),
    (vk::Format::R16G16B16_UNORM, Program::Float2D),
    (vk::Format::R16G16B16_SNORM, Program::FloatBias2D),
    (vk::Format::R16G16B16_UINT, Program::Uint2D),
    (vk::Format::R16G16B16_SINT, Program::IntBias2D),
    (vk::Format::R16G16B16_SFLOAT, Program::FloatBias2D),
    (vk::Format::R16G16B16A16_UNORM, Program::Float2D),
    (vk::Format::R16G16B16A16_SNORM, Program::FloatBias2D),
    (vk::Format::R16G16B16A16_UINT, Program::Uint2D),
    (vk::Format::R16G16B16A16_SINT, Program::IntBias2D),
    (vk::Format::R16G16B16A16_SFLOAT, Program::FloatBias2D),
    (vk::Format::R32_UINT, Program::Uint2D),
    (vk::Format::R32_SINT, Program::IntBias2D),
    (vk::Format::R32_SFLOAT, Program::FloatBias2D),
    (vk::Format::R32G32_UINT, Program::Uint2D),
    (vk::Format::R32G32_SINT, Program::IntBias2D),
    (vk::Format::R32G32_SFLOAT, Program::FloatBias2D),
    (vk::Format::R32G32B32_UINT, Program::Uint2D),
    (vk::Format::R32G32B32_SINT, Program::IntBias2D),
    (vk::Format::R32G32B32_SFLOAT, Program::FloatBias2D),
    (vk::Format::R32G32B32A32_UINT, Program::Uint2D),
    (vk::Format::R32G32B32A32_SINT, Program::IntBias2D),
    (vk::Format::R32G32B32A32_SFLOAT, Program::FloatBias2D),
    (vk::Format::B10G11R11_UFLOAT_PACK32, Program::Float2D),
    (vk::Format::E5B9G9R9_UFLOAT_PACK32, Program::Float2D),
    (vk::Format::B4G4R4A4_UNORM_PACK16, Program::Float2D),
    (vk::Format::B5G5R5A1_UNORM_PACK16, Program::Float2D),
    (vk::Format::A4R4G4B4_UNORM_PACK16, Program::Float2D),
    (vk::Format::A4B4G4R4_UNORM_PACK16, Program::Float2D),
    (vk::Format::ETC2_R8G8B8_UNORM_BLOCK, Program::Float2D),
    (vk::Format::ETC2_R8G8B8_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK, Program::Float2D),
    (vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK, Program::Float2D),
    (vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK, Program::Float2D),
    (vk::Format::EAC_R11_UNORM_BLOCK, Program::Float2D),
    (vk::Format::EAC_R11_SNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::EAC_R11G11_UNORM_BLOCK, Program::Float2D),
    (vk::Format::EAC_R11G11_SNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_4X4_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_4X4_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_5X4_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_5X4_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_5X5_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_5X5_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_6X5_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_6X5_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_6X6_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_6X6_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_8X5_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_8X5_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_8X6_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_8X6_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_8X8_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_8X8_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_10X5_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_10X5_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_10X6_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_10X6_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_10X8_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_10X8_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_10X10_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_10X10_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_12X10_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_12X10_SRGB_BLOCK, Program::Float2D),
    (vk::Format::ASTC_12X12_UNORM_BLOCK, Program::FloatBias2D),
    (vk::Format::ASTC_12X12_SRGB_BLOCK, Program::Float2D),
];

const DEPTH_FORMATS_2D: &[(vk::Format, Program)] = &[
    (vk::Format::D16_UNORM, Program::Float2D),
    (vk::Format::X8_D24_UNORM_PACK32, Program::Float2D),
    (vk::Format::D32_SFLOAT, Program::Float2D),
    (vk::Format::D16_UNORM_S8_UINT, Program::Float2D),
    (vk::Format::D24_UNORM_S8_UINT, Program::Float2D),
    (vk::Format::D32_SFLOAT_S8_UINT, Program::Float2D),
];

const STENCIL_FORMATS_2D: &[(vk::Format, Program)] = &[
    (vk::Format::S8_UINT, Program::Uint2D),
    (vk::Format::D16_UNORM_S8_UINT, Program::Uint2D),
    (vk::Format::D24_UNORM_S8_UINT, Program::Uint2D),
    (vk::Format::D32_SFLOAT_S8_UINT, Program::Uint2D),
];

const SIZES_2D: &[(&str, u32, u32)] = &[("pot", 128, 64), ("npot", 51, 65)];

/// (name suffix, sparse)
const BACKING_MODES: &[(&str, bool)] = &[("", false), ("_sparse", true)];

const fn mapping(
    r: vk::ComponentSwizzle,
    g: vk::ComponentSwizzle,
    b: vk::ComponentSwizzle,
    a: vk::ComponentSwizzle,
) -> vk::ComponentMapping {
    vk::ComponentMapping { r, g, b, a }
}

const COMPONENT_MAPPINGS: &[(&str, vk::ComponentMapping)] = &[
    (
        "zzzz",
        mapping(
            vk::ComponentSwizzle::ZERO,
            vk::ComponentSwizzle::ZERO,
            vk::ComponentSwizzle::ZERO,
            vk::ComponentSwizzle::ZERO,
        ),
    ),
    (
        "oooo",
        mapping(
            vk::ComponentSwizzle::ONE,
            vk::ComponentSwizzle::ONE,
            vk::ComponentSwizzle::ONE,
            vk::ComponentSwizzle::ONE,
        ),
    ),
    (
        "rrrr",
        mapping(
            vk::ComponentSwizzle::R,
            vk::ComponentSwizzle::R,
            vk::ComponentSwizzle::R,
            vk::ComponentSwizzle::R,
        ),
    ),
    (
        "gggg",
        mapping(
            vk::ComponentSwizzle::G,
            vk::ComponentSwizzle::G,
            vk::ComponentSwizzle::G,
            vk::ComponentSwizzle::G,
        ),
    ),
    (
        "bbbb",
        mapping(
            vk::ComponentSwizzle::B,
            vk::ComponentSwizzle::B,
            vk::ComponentSwizzle::B,
            vk::ComponentSwizzle::B,
        ),
    ),
    (
        "aaaa",
        mapping(
            vk::ComponentSwizzle::A,
            vk::ComponentSwizzle::A,
            vk::ComponentSwizzle::A,
            vk::ComponentSwizzle::A,
        ),
    ),
    (
        "rgba",
        mapping(
            vk::ComponentSwizzle::R,
            vk::ComponentSwizzle::G,
            vk::ComponentSwizzle::B,
            vk::ComponentSwizzle::A,
        ),
    ),
    (
        "iiii",
        mapping(
            vk::ComponentSwizzle::IDENTITY,
            vk::ComponentSwizzle::IDENTITY,
            vk::ComponentSwizzle::IDENTITY,
            vk::ComponentSwizzle::IDENTITY,
        ),
    ),
    (
        "abgr",
        mapping(
            vk::ComponentSwizzle::A,
            vk::ComponentSwizzle::B,
            vk::ComponentSwizzle::G,
            vk::ComponentSwizzle::R,
        ),
    ),
];

const TEX_COORD_SWIZZLES_2D: &[(&str, [usize; 2])] = &[("yx", [1, 0]), ("xx", [0, 0]), ("yy", [1, 1])];

/// `makeComponentMappingRGBA`
const fn component_mapping_rgba() -> vk::ComponentMapping {
    mapping(
        vk::ComponentSwizzle::R,
        vk::ComponentSwizzle::G,
        vk::ComponentSwizzle::B,
        vk::ComponentSwizzle::A,
    )
}

/// `isDefaultComponentMapping`
fn is_default_component_mapping(m: vk::ComponentMapping) -> bool {
    (m.r == vk::ComponentSwizzle::R || m.r == vk::ComponentSwizzle::IDENTITY)
        && (m.g == vk::ComponentSwizzle::G || m.g == vk::ComponentSwizzle::IDENTITY)
        && (m.b == vk::ComponentSwizzle::B || m.b == vk::ComponentSwizzle::IDENTITY)
        && (m.a == vk::ComponentSwizzle::A || m.a == vk::ComponentSwizzle::IDENTITY)
}

/// The shaders `initializePrograms` builds for one program and texture coordinate swizzle.
fn shared_program(program: Program, swizzle: Option<&str>) -> &'static SharedProgram {
    match (program, swizzle) {
        (Program::Float2D, None) => &TSW_2D_FLOAT_NONE,
        (Program::Float2D, Some("yx")) => &TSW_2D_FLOAT_YX,
        (Program::Float2D, Some("xx")) => &TSW_2D_FLOAT_XX,
        (Program::Float2D, Some("yy")) => &TSW_2D_FLOAT_YY,
        (Program::FloatBias2D, None) => &TSW_2D_FLOAT_BIAS_NONE,
        (Program::FloatBias2D, Some("yx")) => &TSW_2D_FLOAT_BIAS_YX,
        (Program::FloatBias2D, Some("xx")) => &TSW_2D_FLOAT_BIAS_XX,
        (Program::FloatBias2D, Some("yy")) => &TSW_2D_FLOAT_BIAS_YY,
        (Program::Int2D, None) => &TSW_2D_INT_NONE,
        (Program::Int2D, Some("yx")) => &TSW_2D_INT_YX,
        (Program::Int2D, Some("xx")) => &TSW_2D_INT_XX,
        (Program::Int2D, Some("yy")) => &TSW_2D_INT_YY,
        (Program::IntBias2D, None) => &TSW_2D_INT_BIAS_NONE,
        (Program::IntBias2D, Some("yx")) => &TSW_2D_INT_BIAS_YX,
        (Program::IntBias2D, Some("xx")) => &TSW_2D_INT_BIAS_XX,
        (Program::IntBias2D, Some("yy")) => &TSW_2D_INT_BIAS_YY,
        (Program::Uint2D, None) => &TSW_2D_UINT_NONE,
        (Program::Uint2D, Some("yx")) => &TSW_2D_UINT_YX,
        (Program::Uint2D, Some("xx")) => &TSW_2D_UINT_XX,
        (Program::Uint2D, Some("yy")) => &TSW_2D_UINT_YY,
        _ => unreachable!("no texture_swizzle shaders for {program:?} with swizzle {swizzle:?}"),
    }
}

/// `Swizzle2DTestParameters`
#[derive(Clone, Copy)]
struct SwizzleParameters {
    format: vk::Format,
    sparse: bool,
    component_mapping: vk::ComponentMapping,
    tex_coord_swizzle: Option<&'static str>,
    tex_coord_mapping: Option<[usize; 2]>,
    width: u32,
    height: u32,
    aspect_mask: vk::ImageAspectFlags,
    program: Program,
    use_compute: bool,
}

/// `SwizzleTestCase<Swizzle2DTestInstance>`
struct SwizzleCase {
    name: String,
    params: SwizzleParameters,
}

impl TestCase for SwizzleCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self
            .params
            .aspect_mask
            .intersects(vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL)
        {
            context.require_device_functionality("VK_KHR_maintenance5")?;
            let mut maintenance5 = vk::PhysicalDeviceMaintenance5Properties::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance5);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
            if maintenance5.depth_stencil_swizzle_one_support == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Property depthStencilSwizzleOneSupport is not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        shared_program(self.params.program, self.params.tex_coord_swizzle).programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SwizzleInstance {
            context,
            params: self.params,
        })
    }
}

struct SwizzleInstance<'a> {
    context: &'a Context<'a>,
    params: SwizzleParameters,
}

impl TestInstance for SwizzleInstance<'_> {
    /// `Swizzle2DTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let (width, height) = (params.width, params.height);

        let texture = create_test_texture(
            params.format,
            vk::ImageViewType::_2D,
            [width as i32, height as i32, 1],
            1,
        )?;
        let texture_format = texture.get_texture_format();
        let format_info = get_texture_format_info(texture_format);
        let lookup_scale = format_info.look_up_scale[0];
        let lookup_bias = format_info.look_up_bias[0];

        // Params for reference
        let sampler = Sampler {
            wrap_s: WrapMode::Repeat,
            wrap_t: WrapMode::Repeat,
            wrap_r: WrapMode::Repeat,
            filter: FilterMode::Nearest,
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: None,
            seamless_cube_map: true,
        };
        let mut sample_params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        sample_params.base.color_bias = Vec4::splat(lookup_bias);
        sample_params.base.color_scale = Vec4::splat(lookup_scale);
        sample_params.base.sampler_type = if params.aspect_mask == vk::ImageAspectFlags::COLOR {
            if is_compressed_format(params.format) {
                SamplerType::Float
            } else {
                get_sampler_type(
                    map_vk_format(params.format)
                        .ok_or_else(|| TestError::NotPorted(format!("no texture format for {:?}", params.format)))?,
                )
            }
        } else if params.aspect_mask == vk::ImageAspectFlags::DEPTH {
            SamplerType::Float
        } else {
            SamplerType::Uint
        };
        if lookup_bias != 0.0 {
            sample_params.base.use_bias = true;
        }
        log::info!("Compare reference value = {}", sample_params.base.ref_);
        log::info!("Lookup scale = {lookup_scale}");
        log::info!("Lookup bias = {lookup_bias}");

        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        // TextureRenderer::renderQuad picks the program from the sampler type and whether a bias is used
        let use_bias = sample_params.base.use_bias;
        let program = match (sample_params.base.sampler_type, use_bias) {
            (SamplerType::Float, false) => Program::Float2D,
            (SamplerType::Float, true) => Program::FloatBias2D,
            (SamplerType::Int, false) => Program::Int2D,
            (SamplerType::Int, true) => Program::IntBias2D,
            (SamplerType::Uint, false) => Program::Uint2D,
            (other, bias) => {
                return Err(TestError::NotPorted(format!(
                    "2D program for sampler type {other:?} (bias {bias})"
                )));
            }
        };
        let request = RenderRequest {
            texture: &texture,
            format: params.format,
            aspect_mask: params.aspect_mask,
            component_mapping: params.component_mapping,
            use_compute: params.use_compute,
            sparse: params.sparse,
            width,
            height,
            tex_width: width,
            tex_height: height,
            tex_depth: 1,
            kind: TexKind::D2,
            sampler: SamplerParams::nearest_repeat(),
            tex_coord: &tex_coord,
            positions: QUAD_POSITIONS,
            view_levels: None,
            view_min_lod: None,
            output_format: vk::Format::R8G8B8A8_UNORM,
            program,
            parameters: ShaderParameters {
                bias: sample_params.base.bias,
                reference: sample_params.base.ref_,
                color_scale: [lookup_scale; 4],
                color_bias: [lookup_bias; 4],
                lod: 0,
            },
        };
        let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
        let mut rendered = Surface::new(width as i32, height as i32);
        for y in 0..height {
            for x in 0..width {
                let offset = ((y * width + x) * 4) as usize;
                rendered.set_pixel(
                    x as i32,
                    y as i32,
                    RGBA::new(
                        i32::from(pixels[offset]),
                        i32::from(pixels[offset + 1]),
                        i32::from(pixels[offset + 2]),
                        i32::from(pixels[offset + 3]),
                    ),
                );
            }
        }

        let pixel_format = PixelFormat::new(8, 8, 8, 8);
        let mut reference_frame = Surface::new(width as i32, height as i32);

        // Render reference
        {
            let mut reference_texture = RefTexture2D::new(texture_format, width, height);
            for level in 0..texture.get_num_levels() {
                reference_texture.alloc_level(level);
                let source = texture.get_level(level, 0);
                let size = source.size();
                reference_texture.level_mut(level).copy_region_from(
                    &source,
                    (0, 0, 0),
                    (0, 0, 0),
                    (size[0], size[1], size[2]),
                );
            }

            // Swizzle texture coordinates
            let mut reference_coord = tex_coord;
            if let Some(mapping) = params.tex_coord_mapping {
                for vertex in 0..4 {
                    reference_coord[2 * vertex] = tex_coord[2 * vertex + mapping[0]];
                    reference_coord[2 * vertex + 1] = tex_coord[2 * vertex + mapping[1]];
                }
            }

            let mut destination = SurfaceAccess::new(&mut reference_frame, pixel_format);
            sample_texture_2d_to_surface(&mut destination, &reference_texture, reference_coord, &sample_params)?;
        }

        // Reference component mapping swizzle
        if !is_default_component_mapping(params.component_mapping) {
            let mut swizzled_frame = reference_frame.clone();
            let bit_depth = get_texture_format_bit_depth(texture_format);
            let one = (255.0 * (lookup_scale + lookup_bias)) as u8;
            let zero = (255.0 * lookup_bias) as u8;
            let swizzle = [
                params.component_mapping.r,
                params.component_mapping.g,
                params.component_mapping.b,
                params.component_mapping.a,
            ];

            log::info!("Format bit depth = {bit_depth:?}");
            log::info!("One = {one}");
            log::info!("Zero = {zero}");

            for y in 0..height as i32 {
                for x in 0..width as i32 {
                    let original = reference_frame.get_pixel(x, y);
                    let mut swizzled = [
                        original.get_red(),
                        original.get_green(),
                        original.get_blue(),
                        original.get_alpha(),
                    ];
                    for (ndx, component) in swizzle.iter().enumerate() {
                        match *component {
                            vk::ComponentSwizzle::ZERO => swizzled[ndx] = i32::from(zero),
                            vk::ComponentSwizzle::ONE => swizzled[ndx] = i32::from(one),
                            vk::ComponentSwizzle::R => {
                                swizzled[ndx] = if bit_depth[0] != 0 {
                                    original.get_red()
                                } else {
                                    i32::from(zero)
                                }
                            }
                            vk::ComponentSwizzle::G => {
                                swizzled[ndx] = if bit_depth[1] != 0 {
                                    original.get_green()
                                } else {
                                    i32::from(zero)
                                }
                            }
                            vk::ComponentSwizzle::B => {
                                swizzled[ndx] = if bit_depth[2] != 0 {
                                    original.get_blue()
                                } else {
                                    i32::from(zero)
                                }
                            }
                            vk::ComponentSwizzle::A => {
                                swizzled[ndx] = if bit_depth[3] != 0 {
                                    original.get_alpha()
                                } else {
                                    i32::from(one)
                                }
                            }
                            _ => {}
                        }
                    }
                    swizzled_frame.set_pixel(x, y, RGBA::new(swizzled[0], swizzled[1], swizzled[2], swizzled[3]));
                }
            }
            reference_frame = swizzled_frame;
        }

        // Compare and log
        let threshold = pixel_format.get_color_threshold() + RGBA::new(2, 2, 2, 2);
        let is_ok = compare_images(&reference_frame, &rendered, threshold).ok;
        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Image verification failed")
        })
    }
}

fn add_color_cases(group: &mut TestCaseGroup, mappings: bool) {
    for &(size_name, width, height) in SIZES_2D {
        for &(format, program) in COLOR_FORMATS_2D {
            for &(backing_name, sparse) in BACKING_MODES {
                let base_name = format!("{}_2d_{size_name}{backing_name}", format_case_name(format));
                let variants: Vec<(
                    &'static str,
                    vk::ComponentMapping,
                    Option<&'static str>,
                    Option<[usize; 2]>,
                )> = if mappings {
                    COMPONENT_MAPPINGS
                        .iter()
                        .map(|&(name, m)| (name, m, None, None))
                        .collect()
                } else {
                    TEX_COORD_SWIZZLES_2D
                        .iter()
                        .map(|&(name, m)| (name, component_mapping_rgba(), Some(name), Some(m)))
                        .collect()
                };
                for (variant_name, component_mapping, tex_coord_swizzle, tex_coord_mapping) in variants {
                    let mut params = SwizzleParameters {
                        format,
                        sparse,
                        component_mapping,
                        tex_coord_swizzle,
                        tex_coord_mapping,
                        width,
                        height,
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        program,
                        use_compute: false,
                    };
                    let case_name = format!("{base_name}_{variant_name}");
                    group.add_child(Box::new(SwizzleCase {
                        name: case_name.clone(),
                        params,
                    }) as Box<dyn TestCase>);

                    // Compute case.
                    params.use_compute = true;
                    group.add_child(Box::new(SwizzleCase {
                        name: format!("{case_name}_compute"),
                        params,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }
}

fn add_depth_stencil_cases(
    group: &mut TestCaseGroup,
    formats: &[(vk::Format, Program)],
    aspect_mask: vk::ImageAspectFlags,
) {
    let (oooo_name, oooo) = COMPONENT_MAPPINGS[1];
    for &(size_name, width, height) in SIZES_2D {
        for &(format, program) in formats {
            for &(backing_name, sparse) in BACKING_MODES {
                let case_name = format!("{}_2d_{size_name}{backing_name}_{oooo_name}", format_case_name(format));
                let mut params = SwizzleParameters {
                    format,
                    sparse,
                    component_mapping: oooo,
                    tex_coord_swizzle: None,
                    tex_coord_mapping: None,
                    width,
                    height,
                    aspect_mask,
                    program,
                    use_compute: false,
                };
                group.add_child(Box::new(SwizzleCase {
                    name: case_name.clone(),
                    params,
                }) as Box<dyn TestCase>);

                // Compute case.
                params.use_compute = true;
                group.add_child(Box::new(SwizzleCase {
                    name: format!("{case_name}_compute"),
                    params,
                }) as Box<dyn TestCase>);
            }
        }
    }
}

/// `populateTextureSwizzleTests` / `createTextureSwizzleTests`
pub fn create_texture_swizzle_tests() -> TestCaseGroup {
    let mut group_color = TestCaseGroup::new("color");
    add_color_cases(&mut group_color, true);
    let mut group_depth = TestCaseGroup::new("depth");
    add_depth_stencil_cases(&mut group_depth, DEPTH_FORMATS_2D, vk::ImageAspectFlags::DEPTH);
    let mut group_stencil = TestCaseGroup::new("stencil");
    add_depth_stencil_cases(&mut group_stencil, STENCIL_FORMATS_2D, vk::ImageAspectFlags::STENCIL);

    let mut group_comp_map = TestCaseGroup::new("component_mapping");
    group_comp_map.add_child(group_color);
    group_comp_map.add_child(group_depth);
    group_comp_map.add_child(group_stencil);

    let mut group_tex_coord = TestCaseGroup::new("texture_coordinate");
    add_color_cases(&mut group_tex_coord, false);

    let mut swizzle = TestCaseGroup::new("swizzle");
    swizzle.add_child(group_comp_map);
    swizzle.add_child(group_tex_coord);
    swizzle
}
