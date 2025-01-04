// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/texture/vktTextureCompressedFormatTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The renderer is `texture::test_util::render_quad_2d`. The 3D ASTC formats decode through `tcu::astc` with a block depth (HDR ones are not ported).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::test_util::{
    Program, QUAD_POSITIONS, RenderRequest, SamplerParams, ShaderParameters, TexKind, pixels_to_surface,
    reference_texture_2d, reference_texture_3d, render_quad_2d,
};
use crate::generated::shaders::texture_swizzle::{TSW_2D_FLOAT_NONE, TSW_3D_FLOAT_NONE};
use crate::glu::texture_test_util::{LodMode, ReferenceParams, SamplerType, TextureType, compute_quad_tex_coord_2d};
use crate::glu::texture_test_util_surface::{sample_texture_2d_to_surface, sample_texture_3d_to_surface};
use crate::tcu::pixel::{CompareMode, FilterMode, MipmapFilterMode, Sampler, WrapMode, get_texture_format_info};
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::{PixelFormat, RGBA, Surface, TestError, TestOutcome, TestStatus, Vec2, Vec4};
use crate::vk::compressed_formats::{is_astc_3d_format, is_astc_format};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::pipeline::image_util::{TestTexture, TextureKind};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `formats`
static FORMATS: &[vk::Format] = &[
    vk::Format::ETC2_R8G8B8_UNORM_BLOCK,
    vk::Format::ETC2_R8G8B8_SRGB_BLOCK,
    vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK,
    vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK,
    vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK,
    vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK,
    vk::Format::EAC_R11_UNORM_BLOCK,
    vk::Format::EAC_R11_SNORM_BLOCK,
    vk::Format::EAC_R11G11_UNORM_BLOCK,
    vk::Format::EAC_R11G11_SNORM_BLOCK,
    vk::Format::ASTC_4X4_UNORM_BLOCK,
    vk::Format::ASTC_4X4_SRGB_BLOCK,
    vk::Format::ASTC_5X4_UNORM_BLOCK,
    vk::Format::ASTC_5X4_SRGB_BLOCK,
    vk::Format::ASTC_5X5_UNORM_BLOCK,
    vk::Format::ASTC_5X5_SRGB_BLOCK,
    vk::Format::ASTC_6X5_UNORM_BLOCK,
    vk::Format::ASTC_6X5_SRGB_BLOCK,
    vk::Format::ASTC_6X6_UNORM_BLOCK,
    vk::Format::ASTC_6X6_SRGB_BLOCK,
    vk::Format::ASTC_8X5_UNORM_BLOCK,
    vk::Format::ASTC_8X5_SRGB_BLOCK,
    vk::Format::ASTC_8X6_UNORM_BLOCK,
    vk::Format::ASTC_8X6_SRGB_BLOCK,
    vk::Format::ASTC_8X8_UNORM_BLOCK,
    vk::Format::ASTC_8X8_SRGB_BLOCK,
    vk::Format::ASTC_10X5_UNORM_BLOCK,
    vk::Format::ASTC_10X5_SRGB_BLOCK,
    vk::Format::ASTC_10X6_UNORM_BLOCK,
    vk::Format::ASTC_10X6_SRGB_BLOCK,
    vk::Format::ASTC_10X8_UNORM_BLOCK,
    vk::Format::ASTC_10X8_SRGB_BLOCK,
    vk::Format::ASTC_10X10_UNORM_BLOCK,
    vk::Format::ASTC_10X10_SRGB_BLOCK,
    vk::Format::ASTC_12X10_UNORM_BLOCK,
    vk::Format::ASTC_12X10_SRGB_BLOCK,
    vk::Format::ASTC_12X12_UNORM_BLOCK,
    vk::Format::ASTC_12X12_SRGB_BLOCK,
    vk::Format::BC1_RGB_UNORM_BLOCK,
    vk::Format::BC1_RGB_SRGB_BLOCK,
    vk::Format::BC1_RGBA_UNORM_BLOCK,
    vk::Format::BC1_RGBA_SRGB_BLOCK,
    vk::Format::BC2_UNORM_BLOCK,
    vk::Format::BC2_SRGB_BLOCK,
    vk::Format::BC3_UNORM_BLOCK,
    vk::Format::BC3_SRGB_BLOCK,
    vk::Format::BC4_UNORM_BLOCK,
    vk::Format::BC4_SNORM_BLOCK,
    vk::Format::BC5_UNORM_BLOCK,
    vk::Format::BC5_SNORM_BLOCK,
    vk::Format::BC6H_UFLOAT_BLOCK,
    vk::Format::BC6H_SFLOAT_BLOCK,
    vk::Format::BC7_UNORM_BLOCK,
    vk::Format::BC7_SRGB_BLOCK,
];

/// `formats_astc_3d`
static FORMATS_ASTC_3D: &[vk::Format] = &[
    vk::Format::ASTC_3X3X3_UNORM_BLOCK_EXT,
    vk::Format::ASTC_3X3X3_SRGB_BLOCK_EXT,
    vk::Format::ASTC_3X3X3_SFLOAT_BLOCK_EXT,
    vk::Format::ASTC_4X3X3_UNORM_BLOCK_EXT,
    vk::Format::ASTC_4X3X3_SRGB_BLOCK_EXT,
    vk::Format::ASTC_4X3X3_SFLOAT_BLOCK_EXT,
    vk::Format::ASTC_4X4X3_UNORM_BLOCK_EXT,
    vk::Format::ASTC_4X4X3_SRGB_BLOCK_EXT,
    vk::Format::ASTC_4X4X3_SFLOAT_BLOCK_EXT,
    vk::Format::ASTC_4X4X4_UNORM_BLOCK_EXT,
    vk::Format::ASTC_4X4X4_SRGB_BLOCK_EXT,
    vk::Format::ASTC_4X4X4_SFLOAT_BLOCK_EXT,
    vk::Format::ASTC_5X4X4_UNORM_BLOCK_EXT,
    vk::Format::ASTC_5X4X4_SRGB_BLOCK_EXT,
    vk::Format::ASTC_5X4X4_SFLOAT_BLOCK_EXT,
    vk::Format::ASTC_5X5X4_UNORM_BLOCK_EXT,
    vk::Format::ASTC_5X5X4_SRGB_BLOCK_EXT,
    vk::Format::ASTC_5X5X4_SFLOAT_BLOCK_EXT,
    vk::Format::ASTC_5X5X5_UNORM_BLOCK_EXT,
    vk::Format::ASTC_5X5X5_SRGB_BLOCK_EXT,
    vk::Format::ASTC_5X5X5_SFLOAT_BLOCK_EXT,
    vk::Format::ASTC_6X5X5_UNORM_BLOCK_EXT,
    vk::Format::ASTC_6X5X5_SRGB_BLOCK_EXT,
    vk::Format::ASTC_6X5X5_SFLOAT_BLOCK_EXT,
    vk::Format::ASTC_6X6X5_UNORM_BLOCK_EXT,
    vk::Format::ASTC_6X6X5_SRGB_BLOCK_EXT,
    vk::Format::ASTC_6X6X5_SFLOAT_BLOCK_EXT,
    vk::Format::ASTC_6X6X6_UNORM_BLOCK_EXT,
    vk::Format::ASTC_6X6X6_SRGB_BLOCK_EXT,
    vk::Format::ASTC_6X6X6_SFLOAT_BLOCK_EXT,
];

/// `sizes`: width, height, depth, mipmaps, name
static SIZES: &[(u32, u32, u32, bool, &str)] = &[
    (128, 64, 8, false, "pot"),
    (51, 65, 17, false, "npot"),
    (51, 65, 17, true, "npot_mip1"),
];

fn is_bc_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::BC1_RGB_UNORM_BLOCK
            | vk::Format::BC1_RGB_SRGB_BLOCK
            | vk::Format::BC1_RGBA_UNORM_BLOCK
            | vk::Format::BC1_RGBA_SRGB_BLOCK
            | vk::Format::BC2_UNORM_BLOCK
            | vk::Format::BC2_SRGB_BLOCK
            | vk::Format::BC3_UNORM_BLOCK
            | vk::Format::BC3_SRGB_BLOCK
            | vk::Format::BC4_UNORM_BLOCK
            | vk::Format::BC4_SNORM_BLOCK
            | vk::Format::BC5_UNORM_BLOCK
            | vk::Format::BC5_SNORM_BLOCK
            | vk::Format::BC6H_UFLOAT_BLOCK
            | vk::Format::BC6H_SFLOAT_BLOCK
            | vk::Format::BC7_UNORM_BLOCK
            | vk::Format::BC7_SRGB_BLOCK
    )
}

fn is_bc_bit_exact_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::BC6H_UFLOAT_BLOCK
            | vk::Format::BC6H_SFLOAT_BLOCK
            | vk::Format::BC7_UNORM_BLOCK
            | vk::Format::BC7_SRGB_BLOCK
    )
}

fn is_bc_srgb_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::BC1_RGB_SRGB_BLOCK
            | vk::Format::BC1_RGBA_SRGB_BLOCK
            | vk::Format::BC2_SRGB_BLOCK
            | vk::Format::BC3_SRGB_BLOCK
            | vk::Format::BC7_SRGB_BLOCK
    )
}

fn is_etc_format(format: vk::Format) -> bool {
    let name = format!("{format:?}");
    name.starts_with("ETC2_") || name.starts_with("EAC_")
}

#[derive(Clone, Copy)]
struct CompressedParams {
    format: vk::Format,
    sparse: bool,
    width: u32,
    height: u32,
    depth: u32,
    mipmaps: bool,
    void_extent: bool,
    use_compute: bool,
    is_3d: bool,
    /// the 3D ASTC cases sample with a plain NEAREST min filter, every other case with NEAREST_MIPMAP_NEAREST
    mipmap_filter: bool,
}

impl CompressedParams {
    fn not_ported(&self) -> Option<&'static str> {
        None
    }
}

struct CompressedCase {
    name: String,
    params: CompressedParams,
}

impl TestCase for CompressedCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// The constructors' feature checks of `Compressed2DTestInstance` and `Compressed3DTestInstance`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let format = self.params.format;
        let features = context.get_device_features();
        let unsupported = || Err(TestError::NotSupported(format!("Unsupported format: {format:?}")));

        if self.params.is_3d && is_astc_3d_format(format) {
            // VUID-vkGetPhysicalDeviceImageFormatProperties-format-parameter
            context.require_device_functionality("VK_EXT_texture_compression_astc_3d")?;
            let mut astc_3d_features = vk::PhysicalDeviceTextureCompressionASTC3DFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut astc_3d_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if astc_3d_features.textureCompressionASTC_3D != vk::TRUE {
                return unsupported();
            }
        } else if is_astc_format(format) {
            if features.texture_compression_astc_ldr == vk::FALSE {
                return unsupported();
            }
        } else if is_etc_format(format) {
            if features.texture_compression_etc2 == vk::FALSE {
                return unsupported();
            }
        } else if is_bc_format(format) && features.texture_compression_bc == vk::FALSE {
            return unsupported();
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.is_3d {
            TSW_3D_FLOAT_NONE.programs
        } else {
            TSW_2D_FLOAT_NONE.programs
        }
    }

    fn is_stub(&self) -> bool {
        self.params.not_ported().is_some()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CompressedInstance {
            context,
            params: self.params,
        })
    }
}

struct CompressedInstance<'a> {
    context: &'a Context<'a>,
    params: CompressedParams,
}

/// `compareColor`, the match half of it: every channel of the difference within the threshold.
fn compare_color(reference: RGBA, result: RGBA, threshold: RGBA) -> bool {
    (reference.get_red() - result.get_red()).abs() <= threshold.get_red()
        && (reference.get_green() - result.get_green()).abs() <= threshold.get_green()
        && (reference.get_blue() - result.get_blue()).abs() <= threshold.get_blue()
        && (reference.get_alpha() - result.get_alpha()).abs() <= threshold.get_alpha()
}

/// `validateTexture`: every rendered pixel has to match a reference pixel within `coord_threshold` texels of where it samples.
fn validate_texture(
    rendered: &Surface,
    reference_frame: &Surface,
    texture_width: u32,
    texture_height: u32,
    color_threshold: RGBA,
    coord_threshold: f32,
) -> bool {
    let render_width = rendered.get_width() as u32;
    let render_height = rendered.get_height() as u32;
    let mut is_ok = true;

    for x in 0..render_width {
        for y in 0..render_height {
            let mut match_found = false;
            let rendered_color = rendered.get_pixel(x as i32, y as i32);

            let frag_x = (x as f32 + 0.5) / render_width as f32;
            let frag_y = (y as f32 + 0.5) / render_height as f32;
            let sample_pix_x = frag_x * texture_width as f32;
            let sample_pix_y = frag_y * texture_height as f32;
            let sample_x_min = (sample_pix_x - coord_threshold) as i32 as u32;
            let sample_x_max = (sample_pix_x + coord_threshold) as i32 as u32;
            let sample_y_min = (sample_pix_y - coord_threshold) as i32 as u32;
            let sample_y_max = (sample_pix_y + coord_threshold) as i32 as u32;

            // Compare color within given sample coordinates tolerance
            for smp_x in sample_x_min..=sample_x_max.min(reference_frame.get_width() as u32 - 1) {
                for smp_y in sample_y_min..=sample_y_max.min(reference_frame.get_height() as u32 - 1) {
                    let reference_color = reference_frame.get_pixel(smp_x as i32, smp_y as i32);
                    if compare_color(reference_color, rendered_color, color_threshold) {
                        match_found = true;
                    }
                }
            }

            if !match_found {
                is_ok = false;
            }
        }
    }

    if !is_ok {
        log::error!(
            "Image comparison failed: color threshold = {color_threshold}, coordinates threshold = {coord_threshold}"
        );
    }
    is_ok
}

impl CompressedInstance<'_> {
    /// The reference parameters of `Compressed2DTestInstance::iterate` and `Compressed3DTestInstance::iterate`, and the sampler of the renderer.
    fn sample_params(
        &self,
        texture: &TestTexture,
        mip_level: u32,
    ) -> (ReferenceParams, SamplerParams, [f32; 4], [f32; 4]) {
        let params = &self.params;
        let format = params.format;
        let format_info = get_texture_format_info(texture.get_texture_format());

        let tcu_sampler = Sampler {
            wrap_s: WrapMode::Repeat,
            wrap_t: WrapMode::Repeat,
            wrap_r: WrapMode::Repeat,
            filter: FilterMode::Nearest,
            normalized_coords: true,
            compare: CompareMode::None,
            compare_channel: 0,
            mip_filter: if params.mipmap_filter {
                Some(MipmapFilterMode::Nearest)
            } else {
                None
            },
            seamless_cube_map: true,
        };
        let mut ref_params = ReferenceParams::new(
            if params.is_3d {
                TextureType::Texture3D
            } else {
                TextureType::Texture2D
            },
            tcu_sampler,
            LodMode::Exact,
        );
        ref_params.mag_filter = Some(FilterMode::Nearest);
        ref_params.base.sampler_type = SamplerType::Float;
        if params.mipmaps {
            ref_params.min_lod = mip_level as f32;
            ref_params.max_lod = mip_level as f32;
        }

        let (color_scale, color_bias) =
            if is_astc_format(format) || matches!(format, vk::Format::BC4_UNORM_BLOCK | vk::Format::BC5_UNORM_BLOCK) {
                ([1.0; 4], [0.0; 4])
            } else if format == vk::Format::BC4_SNORM_BLOCK {
                ([0.5, 1.0, 1.0, 1.0], [0.5, 0.0, 0.0, 0.0])
            } else if format == vk::Format::BC5_SNORM_BLOCK {
                ([0.5, 0.5, 1.0, 1.0], [0.5, 0.5, 0.0, 0.0])
            } else {
                (format_info.look_up_scale, format_info.look_up_bias)
            };
        ref_params.base.color_bias = Vec4::new(color_bias[0], color_bias[1], color_bias[2], color_bias[3]);
        ref_params.base.color_scale = Vec4::new(color_scale[0], color_scale[1], color_scale[2], color_scale[3]);

        // `createSampler(REPEAT_GL, REPEAT_GL, minFilter, magFilter)` through `mapSampler`
        let sampler = SamplerParams {
            wrap_u: vk::SamplerAddressMode::REPEAT,
            wrap_v: vk::SamplerAddressMode::REPEAT,
            wrap_w: vk::SamplerAddressMode::REPEAT,
            min_filter: vk::Filter::NEAREST,
            mag_filter: vk::Filter::NEAREST,
            mipmap_mode: vk::SamplerMipmapMode::NEAREST,
            min_lod: if params.mipmaps { mip_level as f32 } else { 0.0 },
            max_lod: if !params.mipmap_filter {
                0.25
            } else if params.mipmaps {
                mip_level as f32
            } else {
                1000.0
            },
            border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
            compare_op: None,
            unnormalized: false,
            non_seamless: false,
            max_anisotropy: None,
        };
        (ref_params, sampler, color_scale, color_bias)
    }

    fn request<'t>(
        &self,
        texture: &'t TestTexture,
        sampler: SamplerParams,
        ref_params: &ReferenceParams,
        color_scale: [f32; 4],
        color_bias: [f32; 4],
        tex_coord: &'t [f32],
    ) -> RenderRequest<'t> {
        let params = &self.params;
        RenderRequest {
            texture,
            format: params.format,
            aspect_mask: vk::ImageAspectFlags::COLOR,
            component_mapping: vk::ComponentMapping {
                r: vk::ComponentSwizzle::R,
                g: vk::ComponentSwizzle::G,
                b: vk::ComponentSwizzle::B,
                a: vk::ComponentSwizzle::A,
            },
            use_compute: params.use_compute,
            sparse: params.sparse,
            width: params.width,
            height: params.height,
            tex_width: params.width,
            tex_height: params.height,
            tex_depth: if params.is_3d { params.depth } else { 1 },
            kind: if params.is_3d { TexKind::D3 } else { TexKind::D2 },
            sampler,
            tex_coord,
            positions: QUAD_POSITIONS,
            view_levels: None,
            view_min_lod: None,
            output_format: vk::Format::R8G8B8A8_UNORM,
            program: if params.is_3d {
                Program::Float3D
            } else {
                Program::Float2D
            },
            parameters: ShaderParameters {
                bias: ref_params.base.bias,
                reference: ref_params.base.ref_,
                color_scale,
                color_bias,
                lod: 0,
            },
        }
    }
}

impl TestInstance for CompressedInstance<'_> {
    /// `Compressed2DTestInstance::iterate` and `Compressed3DTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        if let Some(reason) = params.not_ported() {
            return Err(TestError::NotPorted(reason.to_string()));
        }

        let mip_level = u32::from(params.mipmaps);
        let pixel_format = PixelFormat::new(8, 8, 8, 8);
        let format = params.format;

        let threshold = if is_bc_bit_exact_format(format) {
            RGBA::new(1, 1, 1, 1)
        } else if params.is_3d && is_bc_srgb_format(format) {
            RGBA::new(9, 9, 9, 9)
        } else if is_bc_format(format) {
            RGBA::new(8, 8, 8, 8)
        } else {
            pixel_format.get_color_threshold() + RGBA::new(2, 2, 2, 2)
        };
        let coord_threshold = 0.01f32;

        let texture_width = params.width >> mip_level;
        let texture_height = params.height >> mip_level;

        if !params.is_3d {
            let texture = if params.void_extent {
                TestTexture::new_compressed_void_extent(format, [params.width, params.height, 1])?
            } else {
                TestTexture::new_compressed(format, TextureKind::Tex2D, [params.width, params.height, 1], 1)?
            };
            let (ref_params, sampler, color_scale, color_bias) = self.sample_params(&texture, mip_level);

            // Compute texture coordinates.
            let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));
            let request = self.request(&texture, sampler, &ref_params, color_scale, color_bias, &tex_coord);
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, params.width, params.height);

            let mut reference_frame = Surface::new(texture_width as i32, texture_height as i32);
            let reference = reference_texture_2d(&texture, params.width, params.height);
            sample_texture_2d_to_surface(
                &mut SurfaceAccess::new(&mut reference_frame, pixel_format),
                &reference,
                tex_coord,
                &ref_params,
            )?;

            let is_ok = validate_texture(
                &rendered,
                &reference_frame,
                texture_width,
                texture_height,
                threshold,
                coord_threshold,
            );
            return Ok(if is_ok {
                TestStatus::pass("Pass")
            } else {
                TestStatus::fail("Image verification failed")
            });
        }

        let texture = TestTexture::new_compressed(
            format,
            TextureKind::Tex3D,
            [params.width, params.height, params.depth],
            1,
        )?;
        let (ref_params, sampler, color_scale, color_bias) = self.sample_params(&texture, mip_level);
        let reference = reference_texture_3d(&texture, params.width, params.height, params.depth);

        let slices = 3u32;
        let mut is_ok = false;
        for s in 0..slices {
            // Test different slices of 3D texture.
            let slice_ndx = (params.depth - 1) * s / (slices - 1);
            // Render texture.
            let z = (slice_ndx as f32 + 0.5) / (params.depth >> mip_level) as f32;
            let tex_coord: [f32; 12] = [0.0, 0.0, z, 0.0, 1.0, z, 1.0, 0.0, z, 1.0, 1.0, z];
            let request = self.request(&texture, sampler, &ref_params, color_scale, color_bias, &tex_coord);
            let pixels = render_quad_2d(context, &request, context.get_binary_collection())?;
            let rendered = pixels_to_surface(&pixels, params.width, params.height);

            let mut reference_frame = Surface::new(texture_width as i32, texture_height as i32);
            sample_texture_3d_to_surface(
                &mut SurfaceAccess::new(&mut reference_frame, pixel_format),
                &reference,
                tex_coord,
                &ref_params,
            )?;

            is_ok = validate_texture(
                &rendered,
                &reference_frame,
                texture_width,
                texture_height,
                threshold,
                coord_threshold,
            );
            if !is_ok {
                break;
            }
        }
        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Image verification failed")
        })
    }
}

fn name_base(format: vk::Format) -> String {
    format!("{format:?}").to_lowercase()
}

const BACKING_MODES: &[(&str, bool)] = &[("", false), ("_sparse", true)];

/// `populateTextureCompressedFormatTests`
pub fn create_texture_compressed_format_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("compressed");

    for &(width, height, _, mipmaps, size_name) in SIZES {
        for &format in FORMATS {
            for &(backing_name, sparse) in BACKING_MODES {
                let name_base = name_base(format);
                let mut params = CompressedParams {
                    format,
                    sparse,
                    width,
                    height,
                    depth: 1,
                    mipmaps,
                    void_extent: false,
                    use_compute: false,
                    is_3d: false,
                    mipmap_filter: true,
                };
                let mut add = |name: String, params: CompressedParams| {
                    group.add_child(Box::new(CompressedCase { name, params }) as Box<dyn TestCase>);
                };

                add(format!("{name_base}_2d_{size_name}{backing_name}"), params);

                // Compute case.
                params.use_compute = true;
                add(
                    format!("{name_base}_2d_compute_{size_name}{backing_name}_compute"),
                    params,
                );

                if is_astc_format(format) {
                    params.void_extent = true;
                    params.use_compute = false;
                    add(format!("{name_base}_voidextent_2d_{size_name}{backing_name}"), params);

                    // Compute case with void extent.
                    params.use_compute = true;
                    add(
                        format!("{name_base}_voidextent_2d_{size_name}{backing_name}_compute"),
                        params,
                    );
                }
            }
        }
    }

    group
}

/// `populate3DTextureCompressedFormatTests`
pub fn create_3d_texture_compressed_format_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("compressed_3D");

    for &(width, height, depth, mipmaps, size_name) in SIZES {
        for &format in FORMATS {
            for &(backing_name, sparse) in BACKING_MODES {
                let name_base = name_base(format);
                let mut params = CompressedParams {
                    format,
                    sparse,
                    width,
                    height,
                    depth,
                    mipmaps,
                    void_extent: false,
                    use_compute: false,
                    is_3d: true,
                    mipmap_filter: true,
                };
                group.add_child(Box::new(CompressedCase {
                    name: format!("{name_base}_3d_{size_name}{backing_name}"),
                    params,
                }) as Box<dyn TestCase>);

                // Compute case.
                params.use_compute = true;
                group.add_child(Box::new(CompressedCase {
                    name: format!("{name_base}_3d_{size_name}{backing_name}_compute"),
                    params,
                }) as Box<dyn TestCase>);
            }
        }

        for &format in FORMATS_ASTC_3D {
            for &(backing_name, sparse) in BACKING_MODES {
                let name_base = name_base(format);
                // `mipmaps` and `useCompute` keep their defaults here, as upstream's `testParameters` of this loop does.
                let params = CompressedParams {
                    format,
                    sparse,
                    width,
                    height,
                    depth,
                    mipmaps: false,
                    void_extent: false,
                    use_compute: false,
                    is_3d: true,
                    mipmap_filter: false,
                };
                group.add_child(Box::new(CompressedCase {
                    name: format!("{name_base}_3d_{size_name}{backing_name}"),
                    params,
                }) as Box<dyn TestCase>);
            }
        }
        let _ = mipmaps;
    }

    group
}
