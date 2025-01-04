// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/image/vktImageCompressionTranscodingSupport.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders come from the manifest (scripts/gen_texel_view_manifest.py). The failure-only
// image logging of the compute instances is reduced to the verdict.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::texel_view_graphics_tests::GraphicsTestInstance;
use crate::generated::shaders::image_texel_view_compatible::ALL_SHARED_PROGRAM;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::random::Random;
use crate::tcu::texture::{TextureChannelClass, map_vk_format};
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compressed_formats::{get_block_depth, get_block_height, get_block_size_in_bytes, get_block_width};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout, make_pipeline_layout_with_push_constants,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::image::tests_util::{
    ImageType, get_image_size_bytes, get_layer_size, get_num_layers, map_image_type, map_image_view_type,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum ShaderType {
    Compute,
    Fragment,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum Operation {
    ImageLoad,
    TexelFetch,
    Texture,
    ImageStore,
    AttachmentRead,
    AttachmentWrite,
    TextureRead,
    TextureWrite,
}

const OPERATIONS: [Operation; 8] = [
    Operation::ImageLoad,
    Operation::TexelFetch,
    Operation::Texture,
    Operation::ImageStore,
    Operation::AttachmentRead,
    Operation::AttachmentWrite,
    Operation::TextureRead,
    Operation::TextureWrite,
];

fn operation_name(operation: Operation) -> &'static str {
    match operation {
        Operation::ImageLoad => "image_load",
        Operation::TexelFetch => "texel_fetch",
        Operation::Texture => "texture",
        Operation::ImageStore => "image_store",
        Operation::AttachmentRead => "attachment_read",
        Operation::AttachmentWrite => "attachment_write",
        Operation::TextureRead => "texture_read",
        Operation::TextureWrite => "texture_write",
    }
}

/// `TestParameters`
#[derive(Clone, Copy)]
pub(super) struct TestParameters {
    pub operation: Operation,
    pub shader: ShaderType,
    pub size: [u32; 3],
    pub layers: u32,
    pub image_type: ImageType,
    pub format_compressed: vk::Format,
    pub format_uncompressed: vk::Format,
    pub images_count: u32,
    pub compressed_image_usage: vk::ImageUsageFlags,
    pub compressed_image_view_usage: vk::ImageUsageFlags,
    pub uncompressed_image_usage: vk::ImageUsageFlags,
    pub use_mipmaps: bool,
    pub format_for_verify: vk::Format,
    pub multi_layer_view: bool,
}

impl TestParameters {
    pub fn format_is_astc(&self) -> bool {
        (vk::Format::ASTC_4X4_UNORM_BLOCK.as_raw()..=vk::Format::ASTC_12X12_SRGB_BLOCK.as_raw())
            .contains(&self.format_compressed.as_raw())
    }

    pub fn use_multi_layer_views(&self) -> bool {
        self.multi_layer_view && self.layers > 1
    }
}

pub(super) fn format_short_string(format: vk::Format) -> String {
    format!("{format:?}").to_lowercase()
}

/// `getCompressedImageResolutionInBlocks`
pub(super) fn get_compressed_image_resolution_in_blocks(format: vk::Format, size: [u32; 3]) -> [u32; 3] {
    [
        size[0].div_ceil(get_block_width(format)),
        size[1].div_ceil(get_block_height(format)),
        size[2].div_ceil(get_block_depth(format)),
    ]
}

/// `getCompressedImageSizeInBytes`
pub(super) fn get_compressed_image_size_in_bytes(format: vk::Format, size: [u32; 3]) -> vk::DeviceSize {
    let blocks = get_compressed_image_resolution_in_blocks(format, size);
    vk::DeviceSize::from(blocks[0])
        * vk::DeviceSize::from(blocks[1])
        * vk::DeviceSize::from(blocks[2])
        * vk::DeviceSize::from(get_block_size_in_bytes(format))
}

pub(super) fn make_extent_3d(size: [u32; 3]) -> vk::Extent3D {
    vk::Extent3D {
        width: size[0],
        height: size[1],
        depth: size[2],
    }
}

pub(super) const SINGLE_LEVEL: u32 = 1;
pub(super) const SINGLE_LAYER: u32 = 1;

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum BinaryCompareMode {
    Normal,
    AllowAstcErrorColourWarning,
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum BinaryCompareResult {
    Ok,
    AstcQualityWarning,
    Failed,
}

const ASTC_LDR_ERROR_COLOUR: u32 = 0xFFFF00FF;
const ASTC_HDR_ERROR_COLOUR: u32 = 0x00000000;

/// `BinaryCompare`
pub(super) fn binary_compare(reference: &[u8], result: &[u8], mode: BinaryCompareMode) -> BinaryCompareResult {
    if reference == result {
        return BinaryCompareResult::Ok;
    }
    if mode == BinaryCompareMode::AllowAstcErrorColourWarning {
        let mut warn = false;
        let mut fail = false;
        for (ref_px, res_px) in reference.chunks_exact(4).zip(result.chunks_exact(4)) {
            let ref_val = u32::from_ne_bytes([ref_px[0], ref_px[1], ref_px[2], ref_px[3]]);
            let res_val = u32::from_ne_bytes([res_px[0], res_px[1], res_px[2], res_px[3]]);
            if ref_val != res_val {
                if (ref_val == ASTC_LDR_ERROR_COLOUR && res_val == ASTC_HDR_ERROR_COLOUR)
                    || (ref_val == ASTC_HDR_ERROR_COLOUR && res_val == ASTC_LDR_ERROR_COLOUR)
                {
                    warn = true;
                } else {
                    fail = true;
                }
            }
        }
        if !fail {
            return if warn {
                BinaryCompareResult::AstcQualityWarning
            } else {
                BinaryCompareResult::Ok
            };
        }
    }
    BinaryCompareResult::Failed
}

/// `TestStatusASTCQualityWarning`
pub(super) fn test_status_astc_quality_warning() -> TestStatus {
    TestStatus::new(
        TestResult::QualityWarning,
        "ASTC HDR error colour output instead of LDR error colour",
    )
}

const PATTERN: [u8; 208] = [
    0x11, 0x11, 0x11, 0x11, 0x22, 0x22, 0x22, 0x22, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0xFF, 0x00, 0x00, 0x00, 0x7F, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x7F, 0xF0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x7F, 0xF7, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0xFF, 0xF7, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0xF8, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x80, 0x00, 0x00, 0xFF, 0x80, 0x00, 0x00, 0x7F, 0x80, 0x00,
    0x01, 0x7F, 0xBF, 0xFF, 0xFF, 0xFF, 0x80, 0x00, 0x01, 0xFF, 0xBF, 0xFF, 0xFF, 0x7F, 0xC0, 0x00, 0x00, 0x7F, 0xFF,
    0xFF, 0xFF, 0xFF, 0xC0, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xAA, 0xAA, 0xAA, 0xAA, 0x55, 0x55, 0x55, 0x55,
];

/// `BasicTranscodingTestInstance` - the state and helpers the four instances share.
pub(super) struct BasicTranscoding {
    pub parameters: TestParameters,
    pub block_width: u32,
    pub block_height: u32,
    pub level_count: u32,
    pub layer_size: [u32; 3],
    pub astc_error_colour_mismatch: bool,
}

impl BasicTranscoding {
    pub fn new(parameters: TestParameters) -> Self {
        let block_width = get_block_width(parameters.format_compressed);
        let block_height = get_block_height(parameters.format_compressed);
        Self {
            parameters,
            block_width,
            block_height,
            level_count: Self::find_mip_map_level_count(&parameters, block_width, block_height),
            layer_size: get_layer_size(parameters.image_type, parameters.size),
            astc_error_colour_mismatch: false,
        }
    }

    fn find_mip_map_level_count(parameters: &TestParameters, block_width: u32, block_height: u32) -> u32 {
        let mut level_count = 1;
        // Mipmap levels below the block size cannot be used.
        if parameters.use_mipmaps {
            let mut w = parameters.size[0];
            let mut h = parameters.size[1];
            while w > block_width && h > block_height {
                w >>= 1;
                h >>= 1;
                if w > block_width && h > block_height {
                    level_count += 1;
                }
            }
        }
        level_count
    }

    pub fn get_level_count(&self) -> u32 {
        self.level_count
    }

    pub fn get_layer_count(&self) -> u32 {
        self.parameters.layers
    }

    pub fn get_layer_dims(&self) -> [u32; 3] {
        self.layer_size
    }

    /// `getMipLevelSizes`
    pub fn get_mip_level_sizes(&self, mut base_size: [u32; 3]) -> Vec<[u32; 3]> {
        let mut level_sizes = Vec::new();
        let level_count = self.get_level_count() as usize;

        base_size[2] = 1;
        level_sizes.push(base_size);

        if self.parameters.image_type == ImageType::OneD {
            base_size[1] = 1;
            while level_sizes.len() < level_count && base_size[0] != 1 {
                base_size[0] = (base_size[0] >> 1).max(1);
                level_sizes.push(base_size);
            }
        } else {
            while level_sizes.len() < level_count && (base_size[0] != 1 || base_size[1] != 1) {
                base_size[0] = (base_size[0] >> 1).max(1);
                base_size[1] = (base_size[1] >> 1).max(1);
                level_sizes.push(base_size);
            }
        }
        level_sizes
    }

    /// `getCompressedMipLevelSizes`
    pub fn get_compressed_mip_level_sizes(
        &self,
        compressed_format: vk::Format,
        uncompressed_sizes: &[[u32; 3]],
    ) -> Vec<[u32; 3]> {
        uncompressed_sizes
            .iter()
            .map(|&size| get_compressed_image_resolution_in_blocks(compressed_format, size))
            .collect()
    }

    /// `generateData`
    pub fn generate_data(&self, to_fill: &mut [u8], format: vk::Format, layer: u32, level: u32) {
        let size = to_fill.len();
        let mut start = 0usize;
        let mut size_to_rnd = size;

        if layer == 0 && level == 0 && size >= 2 * PATTERN.len() {
            // Rotated pattern
            for (i, &byte) in PATTERN.iter().enumerate() {
                to_fill[PATTERN.len() - i - 1] = byte;
            }
            start += PATTERN.len();
            size_to_rnd -= PATTERN.len();

            // Direct pattern
            to_fill[start..start + PATTERN.len()].copy_from_slice(&PATTERN);
            start += PATTERN.len();
            size_to_rnd -= PATTERN.len();
        }

        debug_assert!(size_to_rnd % 4 == 0);
        let seed = (layer << 24) ^ (level << 16) ^ (format.as_raw() as u32);
        let mut rnd = Random::new(seed);
        for chunk in to_fill[start..start + size_to_rnd].chunks_exact_mut(4) {
            chunk.copy_from_slice(&rnd.get_uint32().to_ne_bytes());
        }

        // Remove values that may not be preserved by the uncompressed view format.
        let uncompressed = self.parameters.format_uncompressed;
        let texture_format = map_vk_format(uncompressed).expect("uncompressed view formats have a tcu format");
        match texture_format.channel_class() {
            TextureChannelClass::SignedFixedPoint => {
                // SNORM fix: a write replaces 0x00 0x80 with 0x01 0x80
                for i in (0..size).step_by(2) {
                    if to_fill[i] == 0x00 && to_fill[i + 1] == 0x80 {
                        to_fill[i + 1] = 0x81;
                    }
                }
            }
            TextureChannelClass::FloatingPoint => {
                if texture_format.type_ == crate::tcu::texture::ChannelType::HALF_FLOAT {
                    for i in (0..size).step_by(2) {
                        // HALF_FLOAT fix: remove INF and NaN
                        if (to_fill[i + 1] & 0x7C) == 0x7C {
                            to_fill[i + 1] = 0x00;
                        }
                    }
                } else if texture_format.type_ == crate::tcu::texture::ChannelType::FLOAT {
                    for i in (0..size).step_by(4) {
                        if (to_fill[i + 1] & 0x7C) == 0x7C {
                            to_fill[i + 1] = 0x00;
                        }
                    }
                    for i in (0..size).step_by(4) {
                        // FLOAT fix: remove INF, NaN, and denorm; little endian then big endian
                        if ((to_fill[i + 3] & 0x7F) == 0x7F && (to_fill[i + 2] & 0x80) == 0x80)
                            || ((to_fill[i + 3] & 0x7F) == 0x00 && (to_fill[i + 2] & 0x80) == 0x00)
                        {
                            to_fill[i + 3] = 0x01;
                        }
                        if ((to_fill[i] & 0x7F) == 0x7F && (to_fill[i + 1] & 0x80) == 0x80)
                            || ((to_fill[i] & 0x7F) == 0x00 && (to_fill[i + 1] & 0x80) == 0x00)
                        {
                            to_fill[i] = 0x01;
                        }
                    }
                }
            }
            _ => {}
        }
    }
}

/// `makeImageView` with an optional `VkImageViewUsageCreateInfo` chained
pub(super) fn make_view<'a>(
    device: &'a Device,
    image: vk::Image,
    view_type: vk::ImageViewType,
    format: vk::Format,
    subresource_range: vk::ImageSubresourceRange,
    usage: Option<vk::ImageUsageFlags>,
) -> Result<Unique<'a, vk::ImageView>, TestError> {
    let mut usage_info = vk::ImageViewUsageCreateInfo::builder().usage(usage.unwrap_or_default());
    let mut info = vk::ImageViewCreateInfo::builder()
        .image(image)
        .view_type(view_type)
        .format(format)
        .components(vk::ComponentMapping {
            r: vk::ComponentSwizzle::IDENTITY,
            g: vk::ComponentSwizzle::IDENTITY,
            b: vk::ComponentSwizzle::IDENTITY,
            a: vk::ComponentSwizzle::IDENTITY,
        })
        .subresource_range(subresource_range);
    if usage.is_some() {
        info = info.push_next(&mut usage_info);
    }
    let view = unsafe { device.create_image_view(&info, None) }.vk_check("vkCreateImageView")?;
    Ok(Unique::new(device, view))
}

pub(super) fn pipeline_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    buffer_barriers: &[vk::BufferMemoryBarrier],
    image_barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            buffer_barriers,
            image_barriers,
        )
    };
}

pub(super) fn write_image_descriptor(
    device: &Device,
    descriptor_set: vk::DescriptorSet,
    binding: u32,
    descriptor_type: vk::DescriptorType,
    image_info: &vk::DescriptorImageInfo,
) {
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: descriptor_set,
        dst_binding: binding,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type,
        image_info,
        buffer_info: std::ptr::null(),
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

pub(super) fn make_descriptor_image_info(
    sampler: vk::Sampler,
    image_view: vk::ImageView,
    image_layout: vk::ImageLayout,
) -> vk::DescriptorImageInfo {
    vk::DescriptorImageInfo {
        sampler,
        image_view,
        image_layout,
    }
}

pub(super) fn make_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0");
    let info = vk::ComputePipelineCreateInfo::builder().stage(*stage).layout(layout);
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[*info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

pub(super) fn make_nearest_sampler(
    device: &Device,
    max_lod: f32,
    unnormalized_coordinates: bool,
) -> Result<Unique<'_, vk::Sampler>, TestError> {
    let info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_EDGE)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(1.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::EQUAL)
        .min_lod(0.0)
        .max_lod(max_lod)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(unnormalized_coordinates);
    let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
    Ok(Unique::new(device, sampler))
}

pub(super) fn image_create_info(
    flags: vk::ImageCreateFlags,
    image_type: vk::ImageType,
    format: vk::Format,
    extent: vk::Extent3D,
    mip_levels: u32,
    array_layers: u32,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .flags(flags)
        .image_type(image_type)
        .format(format)
        .extent(extent)
        .mip_levels(mip_levels)
        .array_layers(array_layers)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

/// `BasicComputeTestInstance::ImageData`
#[derive(Default)]
struct ImageData<'a> {
    images: Vec<ImageWithMemory<'a>>,
    views: Vec<Unique<'a, vk::ImageView>>,
    infos: Vec<vk::ImageCreateInfo>,
}

impl ImageData<'_> {
    fn get_image(&self, ndx: usize) -> vk::Image {
        self.images[ndx].get()
    }

    fn get_image_view(&self, ndx: usize) -> vk::ImageView {
        *self.views[ndx]
    }

    fn get_image_info(&self, ndx: usize) -> vk::ImageCreateInfo {
        self.infos[ndx]
    }
}

/// `BasicComputeTestInstance` and, through `store`, `ImageStoreComputeTestInstance`
pub(super) struct BasicComputeTestInstance<'a> {
    context: &'a Context<'a>,
    base: BasicTranscoding,
    data: Vec<u8>,
    store: bool,
}

impl<'a> BasicComputeTestInstance<'a> {
    fn new(context: &'a Context<'a>, parameters: TestParameters) -> Self {
        Self {
            context,
            base: BasicTranscoding::new(parameters),
            data: Vec::new(),
            store: parameters.operation == Operation::ImageStore,
        }
    }

    fn run(&mut self) -> TestOutcome {
        let parameters = self.base.parameters;
        let context = self.context;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let alloc = context.get_default_allocator();
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let full_size = [
            parameters.size[0],
            if parameters.image_type == ImageType::OneD {
                1
            } else {
                parameters.size[1]
            },
            1,
        ];
        let mip_map_sizes = if parameters.use_mipmaps {
            self.base.get_mip_level_sizes(self.base.get_layer_dims())
        } else {
            vec![full_size]
        };
        let mut image_data: Vec<ImageData<'_>> = (0..parameters.images_count).map(|_| ImageData::default()).collect();
        let compressed_ndx = 0usize;
        let result_image_ndx = parameters.images_count as usize - 1;
        let view_type = map_image_view_type(parameters.image_type).expect("image type has a view type");

        for image_ndx in 0..parameters.images_count as usize {
            let is_compressed = compressed_ndx == image_ndx;
            self.create_image_infos(&mut image_data[image_ndx], &mip_map_sizes, is_compressed)?;
            let infos = image_data[image_ndx].infos.clone();
            for (info_ndx, info) in infos.iter().enumerate() {
                let image = ImageWithMemory::new(device, alloc, *info, MemoryRequirement::ANY)?;
                image_data[image_ndx].images.push(image);
                let handle = image_data[image_ndx].get_image(info_ndx);
                let usage = is_compressed.then_some(parameters.compressed_image_usage);
                if parameters.use_multi_layer_views() {
                    // Single image with all layers.
                    let view = make_view(
                        device,
                        handle,
                        vk::ImageViewType::_2D_ARRAY,
                        parameters.format_uncompressed,
                        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, self.base.get_layer_count()),
                        usage,
                    )?;
                    image_data[image_ndx].views.push(view);
                } else if is_compressed {
                    for mip_ndx in 0..mip_map_sizes.len() as u32 {
                        for layer_ndx in 0..self.base.get_layer_count() {
                            let view = make_view(
                                device,
                                handle,
                                view_type,
                                parameters.format_uncompressed,
                                make_image_subresource_range(vk::ImageAspectFlags::COLOR, mip_ndx, 1, layer_ndx, 1),
                                usage,
                            )?;
                            image_data[image_ndx].views.push(view);
                        }
                    }
                } else {
                    let view = make_view(
                        device,
                        handle,
                        view_type,
                        parameters.format_uncompressed,
                        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                        None,
                    )?;
                    image_data[image_ndx].views.push(view);
                }
            }
        }

        {
            let mut size = 0usize;
            for mip_size in &mip_map_sizes {
                size += (get_compressed_image_size_in_bytes(parameters.format_compressed, *mip_size)
                    * vk::DeviceSize::from(self.base.get_layer_count())) as usize;
            }
            self.data = vec![0u8; size];
            let mut data = std::mem::take(&mut self.data);
            self.base.generate_data(&mut data, parameters.format_compressed, 0, 0);
            self.data = data;
        }

        match parameters.operation {
            Operation::ImageLoad | Operation::TexelFetch | Operation::Texture => {
                self.copy_data_to_image(cmd, &image_data[compressed_ndx], &mip_map_sizes, true)?;
            }
            Operation::ImageStore => {
                self.copy_data_to_image(cmd, &image_data[1], &mip_map_sizes, false)?;
            }
            _ => unreachable!("graphics operation in a compute instance"),
        }

        let mut pass = true;
        let mut fail_string = String::new();
        {
            let mut layout_builder = DescriptorSetLayoutBuilder::new();
            let mut pool_builder = DescriptorPoolBuilder::new();
            let view_count = image_data[0].views.len() as u32;
            for image_ndx in 0..parameters.images_count as usize {
                match parameters.operation {
                    Operation::ImageLoad | Operation::ImageStore => {
                        layout_builder = layout_builder
                            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE);
                        pool_builder = pool_builder.add_type(vk::DescriptorType::STORAGE_IMAGE, view_count);
                    }
                    _ => {
                        let descriptor_type = if compressed_ndx == image_ndx {
                            vk::DescriptorType::COMBINED_IMAGE_SAMPLER
                        } else {
                            vk::DescriptorType::STORAGE_IMAGE
                        };
                        layout_builder =
                            layout_builder.add_single_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE);
                        pool_builder = pool_builder.add_type(descriptor_type, view_count);
                    }
                }
            }
            let descriptor_set_layout = layout_builder.build(device)?;
            let descriptor_pool =
                pool_builder.build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, view_count)?;
            self.execute_shader(cmd, *descriptor_set_layout, *descriptor_pool, &image_data)?;

            // For multilayer views everything is done in a single iteration.
            let layer_iterations = if parameters.use_multi_layer_views() {
                1
            } else {
                self.base.get_layer_count()
            };
            let mut offset = 0 as vk::DeviceSize;

            for (mip_ndx, mip_size) in mip_map_sizes.iter().enumerate() {
                for layer_ndx in 0..layer_iterations {
                    let image_ndx = layer_ndx as usize + mip_ndx * self.base.get_layer_count() as usize;
                    let extent = image_data[result_image_ndx].get_image_info(image_ndx).extent;
                    let size = [extent.width, extent.height, extent.depth];
                    if !self.copy_result_and_compare(
                        cmd,
                        image_data[result_image_ndx].get_image(image_ndx),
                        offset,
                        size,
                    )? {
                        pass = false;
                        fail_string = format!(
                            "Uncompressed output mismatch at offset {offset} even before executing decompression"
                        );
                    }
                    offset += get_compressed_image_size_in_bytes(parameters.format_compressed, *mip_size);
                }
            }
        }
        if !self.decompress_image(cmd, &mut image_data, &mip_map_sizes)? {
            pass = false;
            fail_string = "Decompression failed".to_string();
        }

        if !pass {
            return Ok(TestStatus::fail(fail_string));
        }
        if self.base.astc_error_colour_mismatch {
            debug_assert!(parameters.format_is_astc());
            return Ok(test_status_astc_quality_warning());
        }
        Ok(TestStatus::pass("Pass"))
    }

    fn copy_data_to_image(
        &self,
        cmd: vk::CommandBuffer,
        image_data: &ImageData<'_>,
        mip_map_sizes: &[[u32; 3]],
        is_compressed: bool,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let parameters = self.base.parameters;

        let image_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(self.data.len() as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let mut offset = 0 as vk::DeviceSize;
        {
            let buffer_alloc = image_buffer.get_allocation();
            unsafe { std::ptr::copy_nonoverlapping(self.data.as_ptr(), buffer_alloc.get_host_ptr(), self.data.len()) };
            flush_alloc(device, buffer_alloc)?;
        }

        begin_command_buffer(device, cmd)?;
        let first_info = image_data.get_image_info(0);
        let subresource_range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: first_info.mip_levels,
            base_array_layer: 0,
            layer_count: first_info.array_layers,
        };

        for image_ndx in 0..image_data.images.len() {
            let pre_copy_image_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image_data.get_image(image_ndx),
                subresource_range,
            );
            let flush_host_copy_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::HOST_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                image_buffer.get(),
                0,
                self.data.len() as vk::DeviceSize,
            );
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                &[flush_host_copy_barrier],
                &[pre_copy_image_barrier],
            );

            let info = image_data.get_image_info(image_ndx);
            for mip_ndx in 0..info.mip_levels {
                let image_extent = if is_compressed {
                    make_extent_3d(mip_map_sizes[mip_ndx as usize])
                } else {
                    info.extent
                };
                let copy_region = vk::BufferImageCopy {
                    buffer_offset: offset,
                    buffer_row_length: 0,
                    buffer_image_height: 0,
                    image_subresource: make_image_subresource_layers(
                        vk::ImageAspectFlags::COLOR,
                        mip_ndx,
                        0,
                        info.array_layers,
                    ),
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent,
                };
                unsafe {
                    device.cmd_copy_buffer_to_image(
                        cmd,
                        image_buffer.get(),
                        image_data.get_image(image_ndx),
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        &[copy_region],
                    )
                };
                offset += get_compressed_image_size_in_bytes(
                    parameters.format_compressed,
                    [
                        if is_compressed {
                            image_extent.width
                        } else {
                            image_extent.width * self.base.block_width
                        },
                        if is_compressed {
                            image_extent.height
                        } else {
                            image_extent.height * self.base.block_height
                        },
                        image_extent.depth,
                    ],
                ) * vk::DeviceSize::from(info.array_layers);
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
        Ok(())
    }

    fn create_sampler_for_execute(&self) -> Result<Unique<'a, vk::Sampler>, TestError> {
        make_nearest_sampler(self.context.get_device(), 0.0, self.store)
    }

    /// `BasicComputeTestInstance::executeShader` and `ImageStoreComputeTestInstance::executeShader`
    fn execute_shader(
        &self,
        cmd: vk::CommandBuffer,
        descriptor_set_layout: vk::DescriptorSetLayout,
        descriptor_pool: vk::DescriptorPool,
        image_data: &[ImageData<'_>],
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let parameters = self.base.parameters;
        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(device, binaries.get("comp")?)?;
        let view_count = image_data[0].views.len();
        let pipeline_layout = make_pipeline_layout(device, &[descriptor_set_layout])?;
        let pipeline = make_compute_pipeline(device, *pipeline_layout, *shader_module)?;
        let sampler = self.create_sampler_for_execute()?;
        let images_count = parameters.images_count as usize;

        let mut descriptor_image_infos = Vec::with_capacity(view_count * images_count);
        for view_ndx in 0..view_count {
            for image_ndx in 0..images_count {
                descriptor_image_infos.push(make_descriptor_image_info(
                    *sampler,
                    image_data[image_ndx].get_image_view(view_ndx),
                    vk::ImageLayout::GENERAL,
                ));
            }
        }

        let mut descriptor_sets: Vec<UniqueDescriptorSet<'_>> = Vec::with_capacity(view_count);
        for _ in 0..view_count {
            descriptor_sets.push(make_descriptor_set(device, descriptor_pool, descriptor_set_layout)?);
        }

        begin_command_buffer(device, cmd)?;
        {
            let first_info = image_data[0].get_image_info(0);
            let compressed_range = vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: first_info.mip_levels,
                base_array_layer: 0,
                layer_count: first_info.array_layers,
            };
            let layer_count = if parameters.use_multi_layer_views() {
                self.base.get_layer_count()
            } else {
                1
            };
            let uncompressed_range = vk::ImageSubresourceRange {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                base_mip_level: 0,
                level_count: 1,
                base_array_layer: 0,
                layer_count,
            };

            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline) };

            let mut pre_shader_image_barriers: Vec<vk::ImageMemoryBarrier> = Vec::new();
            if self.store {
                for image_ndx in 0..image_data[1].images.len() {
                    pre_shader_image_barriers.push(make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                        vk::ImageLayout::GENERAL,
                        image_data[1].get_image(image_ndx),
                        uncompressed_range,
                    ));
                }
                for image_ndx in 0..image_data[1].images.len() {
                    pre_shader_image_barriers.push(make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::SHADER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::GENERAL,
                        image_data[2].get_image(image_ndx),
                        uncompressed_range,
                    ));
                }
                pre_shader_image_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    image_data[0].get_image(0),
                    compressed_range,
                ));
            } else {
                for image_ndx in 0..image_data[1].images.len() {
                    pre_shader_image_barriers.push(make_image_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::SHADER_WRITE,
                        vk::ImageLayout::UNDEFINED,
                        vk::ImageLayout::GENERAL,
                        image_data[1].get_image(image_ndx),
                        uncompressed_range,
                    ));
                }
                pre_shader_image_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::SHADER_READ,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::GENERAL,
                    image_data[0].get_image(0),
                    compressed_range,
                ));
            }

            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                &[],
                &pre_shader_image_barriers,
            );

            for (ndx, descriptor_set) in descriptor_sets.iter().enumerate() {
                self.descriptor_set_update(descriptor_set.get(), &descriptor_image_infos[ndx * images_count..]);
                unsafe {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::COMPUTE,
                        *pipeline_layout,
                        0,
                        &[descriptor_set.get()],
                        &[] as &[u32],
                    )
                };

                // For multilayer views the Z dimension handles the layers; the extent depth is only 1 in that case.
                let extent = image_data[1].get_image_info(ndx).extent;
                unsafe {
                    device.cmd_dispatch(
                        cmd,
                        extent.width,
                        extent.height,
                        if parameters.use_multi_layer_views() {
                            self.base.get_layer_count()
                        } else {
                            extent.depth
                        },
                    )
                };
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;
        Ok(())
    }

    fn copy_result_and_compare(
        &self,
        cmd: vk::CommandBuffer,
        uncompressed: vk::Image,
        offset: vk::DeviceSize,
        size: [u32; 3],
    ) -> Result<bool, TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let parameters = self.base.parameters;
        let layer_count = if parameters.use_multi_layer_views() {
            self.base.get_layer_count()
        } else {
            1
        };
        let image_dim = [
            size[0] as i32,
            size[1] as i32,
            if parameters.use_multi_layer_views() {
                layer_count as i32
            } else {
                size[2] as i32
            },
        ];
        // For multilayer views the buffer holds the full image, including all layers.
        let image_result_size = get_image_size_bytes(image_dim, parameters.format_uncompressed)
            .ok_or_else(|| TestError::InternalError("no tcu format for the view format".to_string()))?;
        let image_buffer_result = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(image_result_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        begin_command_buffer(device, cmd)?;
        {
            let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layer_count);
            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, layer_count),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: make_extent_3d(size),
            };
            let prepare_for_transfer_barrier = make_image_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                uncompressed,
                subresource_range,
            );
            let copy_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                image_buffer_result.get(),
                0,
                image_result_size,
            );
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                &[],
                &[prepare_for_transfer_barrier],
            );
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    uncompressed,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    image_buffer_result.get(),
                    &[copy_region],
                )
            };
            pipeline_barrier(
                device,
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                &[copy_barrier],
                &[],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        let alloc_result = image_buffer_result.get_allocation();
        invalidate_alloc(device, alloc_result)?;
        let result = unsafe { std::slice::from_raw_parts(alloc_result.get_host_ptr(), image_result_size as usize) };
        let expected = &self.data[offset as usize..offset as usize + image_result_size as usize];
        Ok(result == expected)
    }

    fn descriptor_set_update(
        &self,
        descriptor_set: vk::DescriptorSet,
        descriptor_image_infos: &[vk::DescriptorImageInfo],
    ) {
        let device = self.context.get_device();
        let parameters = self.base.parameters;
        for binding in 0..parameters.images_count {
            let descriptor_type = match parameters.operation {
                Operation::ImageLoad | Operation::ImageStore => vk::DescriptorType::STORAGE_IMAGE,
                _ if binding == 0 => vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                _ => vk::DescriptorType::STORAGE_IMAGE,
            };
            write_image_descriptor(
                device,
                descriptor_set,
                binding,
                descriptor_type,
                &descriptor_image_infos[binding as usize],
            );
        }
    }

    fn create_image_infos(
        &self,
        image_data: &mut ImageData<'_>,
        mip_map_sizes: &[[u32; 3]],
        is_compressed: bool,
    ) -> Result<(), TestError> {
        let parameters = self.base.parameters;
        let image_type = map_image_type(parameters.image_type);

        if is_compressed {
            let extent_compressed = make_extent_3d(get_layer_size(parameters.image_type, parameters.size));
            let compressed_info = image_create_info(
                vk::ImageCreateFlags::MUTABLE_FORMAT
                    | vk::ImageCreateFlags::BLOCK_TEXEL_VIEW_COMPATIBLE
                    | vk::ImageCreateFlags::EXTENDED_USAGE,
                image_type,
                parameters.format_compressed,
                extent_compressed,
                mip_map_sizes.len() as u32,
                self.base.get_layer_count(),
                vk::ImageUsageFlags::SAMPLED
                    | vk::ImageUsageFlags::STORAGE
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            );
            let supported = unsafe {
                self.context.get_instance().get_physical_device_image_format_properties(
                    self.context.get_physical_device(),
                    compressed_info.format,
                    compressed_info.image_type,
                    compressed_info.tiling,
                    compressed_info.usage,
                    compressed_info.flags,
                )
            };
            if supported.is_err() {
                return Err(TestError::NotSupported("Image parameters not supported".to_string()));
            }
            image_data.infos.push(compressed_info);
        } else {
            let mut size = parameters.size;
            if parameters.image_type == ImageType::OneD {
                size[1] = 1;
            }
            size[2] = 1;
            let original_resolution_in_blocks = make_extent_3d(get_compressed_image_resolution_in_blocks(
                parameters.format_compressed,
                size,
            ));

            // For multilayer views a single iteration takes care of all layers.
            let array_layers = if parameters.use_multi_layer_views() {
                self.base.get_layer_count()
            } else {
                1
            };
            let layer_iterations = if parameters.use_multi_layer_views() {
                1
            } else {
                self.base.get_layer_count()
            };

            for mip_size in mip_map_sizes {
                for _ in 0..layer_iterations {
                    let extent_uncompressed = if parameters.use_mipmaps {
                        make_extent_3d(get_compressed_image_resolution_in_blocks(
                            parameters.format_compressed,
                            *mip_size,
                        ))
                    } else {
                        original_resolution_in_blocks
                    };
                    image_data.infos.push(image_create_info(
                        vk::ImageCreateFlags::empty(),
                        image_type,
                        parameters.format_uncompressed,
                        extent_uncompressed,
                        1,
                        array_layers,
                        parameters.uncompressed_image_usage | vk::ImageUsageFlags::SAMPLED,
                    ));
                }
            }
        }
        Ok(())
    }

    /// `BasicComputeTestInstance::decompressImage`
    fn decompress_image(
        &mut self,
        cmd: vk::CommandBuffer,
        image_data: &mut [ImageData<'_>],
        mip_map_sizes: &[[u32; 3]],
    ) -> Result<bool, TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let parameters = self.base.parameters;
        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(device, binaries.get("decompress")?)?;
        let compressed = image_data[0].get_image(0);
        let image_type = map_image_type(parameters.image_type);

        for data in image_data.iter_mut() {
            data.views.clear();
        }

        let layer_iterations = if parameters.use_multi_layer_views() {
            1
        } else {
            self.base.get_layer_count()
        };
        let mut result = true;

        for (mip_ndx, mip_map_size) in mip_map_sizes.iter().enumerate() {
            let mip_ndx = mip_ndx as u32;
            for layer_ndx in 0..layer_iterations {
                let layout_shader_read_only = layer_ndx % 2 == 1;
                let image_ndx = layer_ndx as usize + mip_ndx as usize * self.base.get_layer_count() as usize;
                let extent_compressed = make_extent_3d(*mip_map_size);
                let uncompressed = image_data[parameters.images_count as usize - 1].get_image(image_ndx);
                let extent_uncompressed = image_data[parameters.images_count as usize - 1]
                    .get_image_info(image_ndx)
                    .extent;
                let buffer_size_extent = if parameters.use_multi_layer_views() {
                    [mip_map_size[0], mip_map_size[1], self.base.get_layer_count()]
                } else {
                    *mip_map_size
                };
                let buffer_size_comp =
                    get_compressed_image_size_in_bytes(parameters.format_compressed, buffer_size_extent);
                let array_layers = if parameters.use_multi_layer_views() {
                    self.base.get_layer_count()
                } else {
                    1
                };

                let properties = unsafe {
                    context.get_instance().get_physical_device_format_properties(
                        context.get_physical_device(),
                        parameters.format_for_verify,
                    )
                };
                if !properties
                    .optimal_tiling_features
                    .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
                {
                    return Err(TestError::NotSupported(
                        "Format storage feature not supported".to_string(),
                    ));
                }

                let decompressed_image_info = image_create_info(
                    vk::ImageCreateFlags::empty(),
                    image_type,
                    parameters.format_for_verify,
                    extent_compressed,
                    1,
                    array_layers,
                    vk::ImageUsageFlags::SAMPLED
                        | vk::ImageUsageFlags::STORAGE
                        | vk::ImageUsageFlags::TRANSFER_SRC
                        | vk::ImageUsageFlags::TRANSFER_DST,
                );
                let compressed_image_info = image_create_info(
                    vk::ImageCreateFlags::empty(),
                    image_type,
                    parameters.format_compressed,
                    extent_compressed,
                    1,
                    array_layers,
                    vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST,
                );
                let compressed_view_usage_flags = vk::ImageUsageFlags::SAMPLED
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST;
                let image_view_type = if parameters.use_multi_layer_views() {
                    vk::ImageViewType::_2D_ARRAY
                } else {
                    map_image_view_type(parameters.image_type).expect("image type has a view type")
                };
                let result_image =
                    ImageWithMemory::new(device, alloc, decompressed_image_info, MemoryRequirement::ANY)?;
                let reference_image =
                    ImageWithMemory::new(device, alloc, decompressed_image_info, MemoryRequirement::ANY)?;
                let uncompressed_image =
                    ImageWithMemory::new(device, alloc, compressed_image_info, MemoryRequirement::ANY)?;
                let full_range = |depth: u32, layers: u32| {
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, depth, 0, layers)
                };
                let result_view = make_view(
                    device,
                    result_image.get(),
                    image_view_type,
                    decompressed_image_info.format,
                    full_range(
                        decompressed_image_info.extent.depth,
                        decompressed_image_info.array_layers,
                    ),
                    None,
                )?;
                let reference_view = make_view(
                    device,
                    reference_image.get(),
                    image_view_type,
                    decompressed_image_info.format,
                    full_range(
                        decompressed_image_info.extent.depth,
                        decompressed_image_info.array_layers,
                    ),
                    None,
                )?;
                let uncompressed_view = make_view(
                    device,
                    uncompressed_image.get(),
                    image_view_type,
                    parameters.format_compressed,
                    full_range(compressed_image_info.extent.depth, compressed_image_info.array_layers),
                    None,
                )?;
                let use_multi_layer = parameters.image_type == ImageType::TwoD && parameters.layers > 1;
                let compressed_view = if use_multi_layer {
                    make_view(
                        device,
                        compressed,
                        vk::ImageViewType::_2D_ARRAY,
                        parameters.format_compressed,
                        make_image_subresource_range(
                            vk::ImageAspectFlags::COLOR,
                            0,
                            mip_map_sizes.len() as u32,
                            0,
                            parameters.layers,
                        ),
                        Some(compressed_view_usage_flags),
                    )?
                } else {
                    make_view(
                        device,
                        compressed,
                        image_view_type,
                        parameters.format_compressed,
                        make_image_subresource_range(vk::ImageAspectFlags::COLOR, mip_ndx, 1, layer_ndx, 1),
                        Some(compressed_view_usage_flags),
                    )?
                };
                let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
                    .add_single_binding(
                        vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                        vk::ShaderStageFlags::COMPUTE,
                    )
                    .add_single_binding(
                        vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                        vk::ShaderStageFlags::COMPUTE,
                    )
                    .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
                    .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
                    .build(device)?;
                let descriptor_pool = DescriptorPoolBuilder::new()
                    .add_type(
                        vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                        decompressed_image_info.array_layers,
                    )
                    .add_type(
                        vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                        decompressed_image_info.array_layers,
                    )
                    .add_type(vk::DescriptorType::STORAGE_IMAGE, decompressed_image_info.array_layers)
                    .add_type(vk::DescriptorType::STORAGE_IMAGE, decompressed_image_info.array_layers)
                    .build(
                        device,
                        vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                        decompressed_image_info.array_layers,
                    )?;
                let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
                let push_data = [layer_ndx, mip_ndx];
                let push_constant_range = vk::PushConstantRange {
                    stage_flags: vk::ShaderStageFlags::COMPUTE,
                    offset: 0,
                    size: std::mem::size_of_val(&push_data) as u32,
                };
                let pipeline_layout = make_pipeline_layout_with_push_constants(
                    device,
                    &[*descriptor_set_layout],
                    &[push_constant_range],
                )?;
                let pipeline = make_compute_pipeline(device, *pipeline_layout, *shader_module)?;
                // For multilayer views the buffer holds the full image with all layers.
                let buffer_size_extent_verif = [
                    extent_compressed.width as i32,
                    extent_compressed.height as i32,
                    if parameters.use_multi_layer_views() {
                        self.base.get_layer_count() as i32
                    } else {
                        extent_compressed.depth as i32
                    },
                ];
                let buffer_size = get_image_size_bytes(buffer_size_extent_verif, parameters.format_for_verify)
                    .ok_or_else(|| TestError::InternalError("no tcu format for the verify format".to_string()))?;
                let result_buffer = BufferWithMemory::new(
                    device,
                    alloc,
                    make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                let reference_buffer = BufferWithMemory::new(
                    device,
                    alloc,
                    make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                let transfer_buffer = BufferWithMemory::new(
                    device,
                    alloc,
                    make_buffer_create_info(
                        buffer_size_comp,
                        vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
                    ),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                let sampler = make_nearest_sampler(device, mip_map_sizes.len() as f32, false)?;

                let sampled_layout = if layout_shader_read_only {
                    vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
                } else {
                    vk::ImageLayout::GENERAL
                };
                let descriptor_image_infos = [
                    make_descriptor_image_info(*sampler, *uncompressed_view, sampled_layout),
                    make_descriptor_image_info(*sampler, *compressed_view, sampled_layout),
                    make_descriptor_image_info(vk::Sampler::null(), *result_view, vk::ImageLayout::GENERAL),
                    make_descriptor_image_info(vk::Sampler::null(), *reference_view, vk::ImageLayout::GENERAL),
                ];
                let set = descriptor_set.get();
                write_image_descriptor(
                    device,
                    set,
                    0,
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    &descriptor_image_infos[0],
                );
                write_image_descriptor(
                    device,
                    set,
                    1,
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    &descriptor_image_infos[1],
                );
                write_image_descriptor(
                    device,
                    set,
                    2,
                    vk::DescriptorType::STORAGE_IMAGE,
                    &descriptor_image_infos[2],
                );
                write_image_descriptor(
                    device,
                    set,
                    3,
                    vk::DescriptorType::STORAGE_IMAGE,
                    &descriptor_image_infos[3],
                );

                begin_command_buffer(device, cmd)?;
                {
                    let subresource_range =
                        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, array_layers);
                    let subresource_range_comp = vk::ImageSubresourceRange {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        base_mip_level: if use_multi_layer { 0 } else { mip_ndx },
                        level_count: if use_multi_layer { mip_map_sizes.len() as u32 } else { 1 },
                        base_array_layer: if use_multi_layer { 0 } else { layer_ndx },
                        layer_count: if use_multi_layer { parameters.layers } else { 1 },
                    };
                    let copy_region = vk::BufferImageCopy {
                        buffer_offset: 0,
                        buffer_row_length: 0,
                        buffer_image_height: 0,
                        image_subresource: make_image_subresource_layers(
                            vk::ImageAspectFlags::COLOR,
                            0,
                            0,
                            array_layers,
                        ),
                        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        image_extent: decompressed_image_info.extent,
                    };
                    let compressed_copy_region = vk::BufferImageCopy {
                        buffer_offset: 0,
                        buffer_row_length: 0,
                        buffer_image_height: 0,
                        image_subresource: make_image_subresource_layers(
                            vk::ImageAspectFlags::COLOR,
                            0,
                            0,
                            array_layers,
                        ),
                        image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                        image_extent: extent_uncompressed,
                    };

                    {
                        let pre_copy_buffer_barrier = make_buffer_memory_barrier(
                            vk::AccessFlags::empty(),
                            vk::AccessFlags::TRANSFER_WRITE,
                            transfer_buffer.get(),
                            0,
                            buffer_size_comp,
                        );
                        pipeline_barrier(
                            device,
                            cmd,
                            vk::PipelineStageFlags::TOP_OF_PIPE,
                            vk::PipelineStageFlags::TRANSFER,
                            &[pre_copy_buffer_barrier],
                            &[],
                        );
                    }

                    unsafe {
                        device.cmd_copy_image_to_buffer(
                            cmd,
                            uncompressed,
                            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                            transfer_buffer.get(),
                            &[compressed_copy_region],
                        )
                    };

                    {
                        let post_copy_buffer_barrier = make_buffer_memory_barrier(
                            vk::AccessFlags::TRANSFER_WRITE,
                            vk::AccessFlags::TRANSFER_READ,
                            transfer_buffer.get(),
                            0,
                            buffer_size_comp,
                        );
                        let pre_copy_image_barrier = make_image_memory_barrier(
                            vk::AccessFlags::empty(),
                            vk::AccessFlags::TRANSFER_WRITE,
                            vk::ImageLayout::UNDEFINED,
                            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                            uncompressed_image.get(),
                            subresource_range,
                        );
                        pipeline_barrier(
                            device,
                            cmd,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::TRANSFER,
                            &[post_copy_buffer_barrier],
                            &[pre_copy_image_barrier],
                        );
                    }

                    unsafe {
                        device.cmd_copy_buffer_to_image(
                            cmd,
                            transfer_buffer.get(),
                            uncompressed_image.get(),
                            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                            &[copy_region],
                        )
                    };

                    unsafe {
                        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
                        device.cmd_bind_descriptor_sets(
                            cmd,
                            vk::PipelineBindPoint::COMPUTE,
                            *pipeline_layout,
                            0,
                            &[set],
                            &[] as &[u32],
                        );
                    }

                    {
                        let compressed_old_layout = if use_multi_layer && !layout_shader_read_only && layer_ndx != 0 {
                            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
                        } else {
                            vk::ImageLayout::GENERAL
                        };
                        let pre_shader_image_barriers = [
                            make_image_memory_barrier(
                                vk::AccessFlags::TRANSFER_WRITE,
                                vk::AccessFlags::SHADER_READ,
                                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                                sampled_layout,
                                uncompressed_image.get(),
                                subresource_range,
                            ),
                            make_image_memory_barrier(
                                vk::AccessFlags::empty(),
                                vk::AccessFlags::SHADER_READ,
                                compressed_old_layout,
                                sampled_layout,
                                compressed,
                                subresource_range_comp,
                            ),
                            make_image_memory_barrier(
                                vk::AccessFlags::empty(),
                                vk::AccessFlags::SHADER_WRITE,
                                vk::ImageLayout::UNDEFINED,
                                vk::ImageLayout::GENERAL,
                                result_image.get(),
                                subresource_range,
                            ),
                            make_image_memory_barrier(
                                vk::AccessFlags::empty(),
                                vk::AccessFlags::SHADER_WRITE,
                                vk::ImageLayout::UNDEFINED,
                                vk::ImageLayout::GENERAL,
                                reference_image.get(),
                                subresource_range,
                            ),
                        ];
                        pipeline_barrier(
                            device,
                            cmd,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::COMPUTE_SHADER,
                            &[],
                            &pre_shader_image_barriers,
                        );
                    }

                    let push_bytes: Vec<u8> = push_data.iter().flat_map(|value| value.to_ne_bytes()).collect();
                    unsafe {
                        device.cmd_push_constants(cmd, *pipeline_layout, vk::ShaderStageFlags::COMPUTE, 0, &push_bytes)
                    };

                    // For multilayer views the Z dimension iterates over the layers; the extent depth is 1 in that case.
                    unsafe {
                        device.cmd_dispatch(
                            cmd,
                            extent_compressed.width,
                            extent_compressed.height,
                            if parameters.use_multi_layer_views() {
                                self.base.get_layer_count()
                            } else {
                                extent_compressed.depth
                            },
                        )
                    };

                    {
                        let post_shader_image_barriers = [
                            make_image_memory_barrier(
                                vk::AccessFlags::SHADER_WRITE,
                                vk::AccessFlags::TRANSFER_READ,
                                vk::ImageLayout::GENERAL,
                                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                                result_image.get(),
                                subresource_range,
                            ),
                            make_image_memory_barrier(
                                vk::AccessFlags::SHADER_WRITE,
                                vk::AccessFlags::TRANSFER_READ,
                                vk::ImageLayout::GENERAL,
                                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                                reference_image.get(),
                                subresource_range,
                            ),
                        ];
                        pipeline_barrier(
                            device,
                            cmd,
                            vk::PipelineStageFlags::COMPUTE_SHADER,
                            vk::PipelineStageFlags::TRANSFER,
                            &[],
                            &post_shader_image_barriers,
                        );
                    }

                    unsafe {
                        device.cmd_copy_image_to_buffer(
                            cmd,
                            result_image.get(),
                            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                            result_buffer.get(),
                            &[copy_region],
                        );
                        device.cmd_copy_image_to_buffer(
                            cmd,
                            reference_image.get(),
                            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                            reference_buffer.get(),
                            &[copy_region],
                        );
                    }

                    {
                        let post_copy_buffer_barriers = [
                            make_buffer_memory_barrier(
                                vk::AccessFlags::TRANSFER_WRITE,
                                vk::AccessFlags::HOST_READ,
                                result_buffer.get(),
                                0,
                                buffer_size,
                            ),
                            make_buffer_memory_barrier(
                                vk::AccessFlags::TRANSFER_WRITE,
                                vk::AccessFlags::HOST_READ,
                                reference_buffer.get(),
                                0,
                                buffer_size,
                            ),
                        ];
                        pipeline_barrier(
                            device,
                            cmd,
                            vk::PipelineStageFlags::TRANSFER,
                            vk::PipelineStageFlags::HOST,
                            &post_copy_buffer_barriers,
                            &[],
                        );
                    }
                }
                end_command_buffer(device, cmd)?;
                submit_commands_and_wait(device, queue, cmd)?;

                let result_alloc = result_buffer.get_allocation();
                let reference_alloc = reference_buffer.get_allocation();
                invalidate_alloc(device, result_alloc)?;
                invalidate_alloc(device, reference_alloc)?;
                let result_bytes =
                    unsafe { std::slice::from_raw_parts(result_alloc.get_host_ptr(), buffer_size as usize) };
                let reference_bytes =
                    unsafe { std::slice::from_raw_parts(reference_alloc.get_host_ptr(), buffer_size as usize) };

                let compare_mode = if parameters.format_is_astc() {
                    BinaryCompareMode::AllowAstcErrorColourWarning
                } else {
                    BinaryCompareMode::Normal
                };
                match binary_compare(reference_bytes, result_bytes, compare_mode) {
                    BinaryCompareResult::Failed => {
                        // Multilayer views are compared once, so the layers are compared one by one here.
                        let inner_iterations = if parameters.use_multi_layer_views() {
                            self.base.get_layer_count()
                        } else {
                            1
                        };
                        let tcu_format =
                            map_vk_format(decompressed_image_info.format).expect("the verify format has a tcu format");
                        let extent = decompressed_image_info.extent;
                        let layer_bytes = (extent.width * extent.height * extent.depth) as usize
                            * tcu_format.pixel_size().unwrap_or(4) as usize;
                        for i in 0..inner_iterations as usize {
                            let result_pixels = ConstPixelBufferAccess::new(
                                tcu_format,
                                [extent.width, extent.height, extent.depth],
                                &result_bytes[layer_bytes * i..layer_bytes * (i + 1)],
                            );
                            let reference_pixels = ConstPixelBufferAccess::new(
                                tcu_format,
                                [extent.width, extent.height, extent.depth],
                                &reference_bytes[layer_bytes * i..layer_bytes * (i + 1)],
                            );
                            if fuzzy_compare_ok(&result_pixels, &reference_pixels, 0.001) != Some(true) {
                                result = false;
                            }
                        }
                    }
                    BinaryCompareResult::AstcQualityWarning => self.base.astc_error_colour_mismatch = true,
                    BinaryCompareResult::Ok => {}
                }
            }
        }
        Ok(result)
    }
}

impl TestInstance for BasicComputeTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

struct TexelViewCompatibleCase {
    name: String,
    parameters: TestParameters,
}

impl TexelViewCompatibleCase {
    fn program_key(&self) -> String {
        let p = &self.parameters;
        let image_type = super::tests_util::get_image_type_name(p.image_type);
        let format = format_short_string(p.format_uncompressed);
        match p.shader {
            ShaderType::Compute => {
                let ref_array = p.image_type == ImageType::TwoD && p.layers > 1;
                format!(
                    "c_{}_{format}_{image_type}_{}_{}",
                    operation_name(p.operation),
                    u32::from(ref_array),
                    u32::from(p.use_multi_layer_views())
                )
            }
            ShaderType::Fragment => {
                let kind = match p.operation {
                    Operation::AttachmentRead | Operation::AttachmentWrite => "att",
                    _ => "tex",
                };
                format!("g_{kind}_{format}_{image_type}")
            }
        }
    }
}

impl TestCase for TexelViewCompatibleCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let p = &self.parameters;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        context.require_device_functionality("VK_KHR_maintenance2")?;

        {
            let result = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    p.format_uncompressed,
                    map_image_type(p.image_type),
                    vk::ImageTiling::OPTIMAL,
                    p.uncompressed_image_usage,
                    vk::ImageCreateFlags::empty(),
                )
            };
            if matches!(result, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
                return Err(TestError::NotSupported(
                    "Operation not supported with this image format".to_string(),
                ));
            }
            let result = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    p.format_compressed,
                    map_image_type(p.image_type),
                    vk::ImageTiling::OPTIMAL,
                    p.compressed_image_usage,
                    vk::ImageCreateFlags::BLOCK_TEXEL_VIEW_COMPATIBLE
                        | vk::ImageCreateFlags::MUTABLE_FORMAT
                        | vk::ImageCreateFlags::EXTENDED_USAGE,
                )
            };
            if matches!(result, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
                return Err(TestError::NotSupported(
                    "Operation not supported with this image format".to_string(),
                ));
            }
        }

        {
            let features = unsafe { instance.get_physical_device_features(physical_device) };
            let raw = p.format_compressed.as_raw();
            if (vk::Format::BC1_RGB_UNORM_BLOCK.as_raw()..=vk::Format::BC7_SRGB_BLOCK.as_raw()).contains(&raw)
                && features.texture_compression_bc == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "textureCompressionBC not supported".to_string(),
                ));
            }
            if (vk::Format::ETC2_R8G8B8_UNORM_BLOCK.as_raw()..=vk::Format::EAC_R11G11_SNORM_BLOCK.as_raw())
                .contains(&raw)
                && features.texture_compression_etc2 == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "textureCompressionETC2 not supported".to_string(),
                ));
            }
            if p.format_is_astc() && features.texture_compression_astc_ldr == vk::FALSE {
                return Err(TestError::NotSupported(
                    "textureCompressionASTC_LDR not supported".to_string(),
                ));
            }

            // Upstream tests a VkFormatFeatureFlags bit against the usage mask, which is the transfer-dst usage bit.
            if p.uncompressed_image_usage.bits() & vk::FormatFeatureFlags::STORAGE_IMAGE.bits() != 0 {
                let format_properties =
                    unsafe { instance.get_physical_device_format_properties(physical_device, p.format_uncompressed) };
                if !format_properties
                    .optimal_tiling_features
                    .contains(vk::FormatFeatureFlags::STORAGE_IMAGE)
                {
                    return Err(TestError::NotSupported("Storage view format not supported".to_string()));
                }
            }
        }

        if p.use_multi_layer_views() {
            let mut maintenance6 = vk::PhysicalDeviceMaintenance6Properties::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance6);
            unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
            if maintenance6.block_texel_view_compatible_multiple_layers == vk::FALSE {
                return Err(TestError::NotSupported(
                    "blockTexelViewCompatibleMultipleLayers not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.program_key();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .map(|program| program.programs)
            .unwrap_or_else(|| BinaryCollection::new(&[]))
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let p = self.parameters;
        debug_assert!(p.use_mipmaps || get_num_layers(p.image_type, p.size) == 1);
        match p.shader {
            ShaderType::Compute => Box::new(BasicComputeTestInstance::new(context, p)),
            ShaderType::Fragment => Box::new(GraphicsTestInstance::new(context, p)),
        }
    }
}

/// `getUnniceResolution`
fn get_unnice_resolution(format: vk::Format, layers: u32) -> [u32; 3] {
    const UNNICE_MIPMAP_TEXTURE_SIZE: [u32; 13] = [1, 1, 1, 8, 22, 48, 117, 275, 604, 208, 611, 274, 1211];
    let base_texture_width = UNNICE_MIPMAP_TEXTURE_SIZE[get_block_width(format) as usize];
    let base_texture_height = UNNICE_MIPMAP_TEXTURE_SIZE[get_block_height(format) as usize];
    let base_texture_width_levels = base_texture_width.ilog2();
    let base_texture_height_levels = base_texture_height.ilog2();
    let width_multiplier = if base_texture_height_levels > base_texture_width_levels {
        1 << (base_texture_height_levels - base_texture_width_levels)
    } else {
        1
    };
    let height_multiplier = if base_texture_width_levels > base_texture_height_levels {
        1 << (base_texture_width_levels - base_texture_height_levels)
    } else {
        1
    };
    let width = base_texture_width * width_multiplier;
    let height = base_texture_height * height_multiplier;
    debug_assert!(width.ilog2() == height.ilog2());
    [width, height, layers]
}

const COMPRESSED_FORMATS_64BIT: [vk::Format; 12] = [
    vk::Format::BC1_RGB_UNORM_BLOCK,
    vk::Format::BC1_RGB_SRGB_BLOCK,
    vk::Format::BC1_RGBA_UNORM_BLOCK,
    vk::Format::BC1_RGBA_SRGB_BLOCK,
    vk::Format::BC4_UNORM_BLOCK,
    vk::Format::BC4_SNORM_BLOCK,
    vk::Format::ETC2_R8G8B8_UNORM_BLOCK,
    vk::Format::ETC2_R8G8B8_SRGB_BLOCK,
    vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK,
    vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK,
    vk::Format::EAC_R11_UNORM_BLOCK,
    vk::Format::EAC_R11_SNORM_BLOCK,
];

const COMPRESSED_FORMATS_128BIT: [vk::Format; 42] = [
    vk::Format::BC2_UNORM_BLOCK,
    vk::Format::BC2_SRGB_BLOCK,
    vk::Format::BC3_UNORM_BLOCK,
    vk::Format::BC3_SRGB_BLOCK,
    vk::Format::BC5_UNORM_BLOCK,
    vk::Format::BC5_SNORM_BLOCK,
    vk::Format::BC6H_UFLOAT_BLOCK,
    vk::Format::BC6H_SFLOAT_BLOCK,
    vk::Format::BC7_UNORM_BLOCK,
    vk::Format::BC7_SRGB_BLOCK,
    vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK,
    vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK,
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
];

// Floating point views are left out upstream: they cannot preserve NaN, infinity and denormal values.
const UNCOMPRESSED_FORMATS_64BIT: [vk::Format; 8] = [
    vk::Format::R16G16B16A16_UNORM,
    vk::Format::R16G16B16A16_SNORM,
    vk::Format::R16G16B16A16_USCALED,
    vk::Format::R16G16B16A16_SSCALED,
    vk::Format::R16G16B16A16_UINT,
    vk::Format::R16G16B16A16_SINT,
    vk::Format::R32G32_UINT,
    vk::Format::R32G32_SINT,
];

const UNCOMPRESSED_FORMATS_128BIT: [vk::Format; 2] = [vk::Format::R32G32B32A32_UINT, vk::Format::R32G32B32A32_SINT];

/// `createImageCompressionTranscodingTests`
pub fn create_image_compression_transcoding_tests() -> TestCaseGroup {
    let base_usage = vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let sampled = vk::ImageUsageFlags::SAMPLED;
    let storage = vk::ImageUsageFlags::STORAGE;
    let compressed_usage: [vk::ImageUsageFlags; 8] = [
        base_usage | storage,
        base_usage | sampled | storage,
        base_usage | sampled | storage,
        base_usage | sampled | storage,
        base_usage | vk::ImageUsageFlags::INPUT_ATTACHMENT | sampled,
        base_usage | sampled | vk::ImageUsageFlags::COLOR_ATTACHMENT,
        base_usage | sampled,
        base_usage | sampled | storage,
    ];
    let mut compressed_view_usage = compressed_usage;
    compressed_view_usage[5] |= vk::ImageUsageFlags::COLOR_ATTACHMENT;
    let uncompressed_usage: [vk::ImageUsageFlags; 8] = [
        base_usage | storage,
        base_usage | sampled | storage,
        base_usage | sampled | storage,
        base_usage | sampled | storage,
        base_usage | vk::ImageUsageFlags::COLOR_ATTACHMENT | sampled,
        base_usage | vk::ImageUsageFlags::INPUT_ATTACHMENT,
        base_usage | storage | sampled,
        base_usage | sampled,
    ];

    let image_types = [
        (ImageType::OneD, "1d_image"),
        (ImageType::TwoD, "2d_image"),
        (ImageType::ThreeD, "3d_image"),
    ];
    let compressed_sets: [&[vk::Format]; 2] = [&COMPRESSED_FORMATS_64BIT, &COMPRESSED_FORMATS_128BIT];
    let uncompressed_sets: [&[vk::Format]; 2] = [&UNCOMPRESSED_FORMATS_64BIT, &UNCOMPRESSED_FORMATS_128BIT];

    let mut texel_view_compatible_tests = TestCaseGroup::new("texel_view_compatible");

    for (shader_type, pipeline_name) in [(ShaderType::Compute, "compute"), (ShaderType::Fragment, "graphic")] {
        let mut pipeline_type_group = TestCaseGroup::new(pipeline_name);

        for (mipmap_test, mipmap_name) in [(false, "basic"), (true, "extended")] {
            let mut mipmap_type_group = TestCaseGroup::new(mipmap_name);

            for (image_type, image_type_name) in image_types {
                let mut image_type_group = TestCaseGroup::new(image_type_name);

                for (operation_ndx, operation) in OPERATIONS.into_iter().enumerate() {
                    let is_graphics_operation = operation_ndx >= Operation::AttachmentRead as usize;
                    if shader_type != ShaderType::Fragment && is_graphics_operation {
                        continue;
                    }
                    if shader_type != ShaderType::Compute && !is_graphics_operation {
                        continue;
                    }
                    if image_type == ImageType::ThreeD
                        && (operation == Operation::AttachmentRead || operation == Operation::AttachmentWrite)
                    {
                        continue;
                    }

                    let mut image_operation_group = TestCaseGroup::new(operation_name(operation));

                    let depth = if image_type == ImageType::ThreeD { 3 } else { 1 };
                    let image_count = 2 + u32::from(operation == Operation::ImageStore);

                    for (compressed_formats, uncompressed_formats) in compressed_sets.iter().zip(uncompressed_sets) {
                        for &format_compressed in *compressed_formats {
                            let mut compressed_format_group =
                                TestCaseGroup::new(&format_short_string(format_compressed));

                            for &format_uncompressed in uncompressed_formats {
                                let parameters = TestParameters {
                                    operation,
                                    shader: shader_type,
                                    size: if mipmap_test {
                                        get_unnice_resolution(format_compressed, 1)
                                    } else {
                                        [64, 64, depth]
                                    },
                                    layers: 1 + 2 * u32::from(mipmap_test && image_type != ImageType::ThreeD),
                                    image_type,
                                    format_compressed,
                                    format_uncompressed,
                                    images_count: image_count,
                                    compressed_image_usage: compressed_usage[operation_ndx],
                                    compressed_image_view_usage: compressed_view_usage[operation_ndx],
                                    uncompressed_image_usage: uncompressed_usage[operation_ndx],
                                    use_mipmaps: mipmap_test,
                                    format_for_verify: vk::Format::R8G8B8A8_UNORM,
                                    multi_layer_view: false,
                                };
                                compressed_format_group.add_child(Box::new(TexelViewCompatibleCase {
                                    name: format_short_string(format_uncompressed),
                                    parameters,
                                })
                                    as Box<dyn TestCase>);
                            }
                            image_operation_group.add_child(compressed_format_group);
                        }
                    }
                    image_type_group.add_child(image_operation_group);
                }
                mipmap_type_group.add_child(image_type_group);
            }
            pipeline_type_group.add_child(mipmap_type_group);
        }
        texel_view_compatible_tests.add_child(pipeline_type_group);
    }

    let mut multi_layer_group = TestCaseGroup::new("multi_layer_views");
    for operation_ndx in Operation::ImageLoad as usize..=Operation::ImageStore as usize {
        let operation = OPERATIONS[operation_ndx];
        let mut image_operation_group = TestCaseGroup::new(operation_name(operation));
        let image_count = 2 + u32::from(operation == Operation::ImageStore);

        for (compressed_formats, uncompressed_formats) in compressed_sets.iter().zip(uncompressed_sets) {
            for &format_compressed in *compressed_formats {
                let mut compressed_format_group = TestCaseGroup::new(&format_short_string(format_compressed));
                for &format_uncompressed in uncompressed_formats {
                    let parameters = TestParameters {
                        operation,
                        shader: ShaderType::Compute,
                        size: [64, 64, 1],
                        layers: 3,
                        image_type: ImageType::TwoD,
                        format_compressed,
                        format_uncompressed,
                        images_count: image_count,
                        compressed_image_usage: compressed_usage[operation_ndx],
                        compressed_image_view_usage: compressed_view_usage[operation_ndx],
                        uncompressed_image_usage: uncompressed_usage[operation_ndx],
                        use_mipmaps: false,
                        format_for_verify: vk::Format::R8G8B8A8_UNORM,
                        multi_layer_view: true,
                    };
                    compressed_format_group.add_child(Box::new(TexelViewCompatibleCase {
                        name: format_short_string(format_uncompressed),
                        parameters,
                    }) as Box<dyn TestCase>);
                }
                image_operation_group.add_child(compressed_format_group);
            }
        }
        multi_layer_group.add_child(image_operation_group);
    }
    texel_view_compatible_tests.add_child(multi_layer_group);

    texel_view_compatible_tests
}
