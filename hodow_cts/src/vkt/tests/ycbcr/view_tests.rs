// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ycbcr/vktYCbCrViewTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders of the three executors (the plane view is sampled as float, int or uint)
// come from `scripts/gen_shader_executor_programs.py`. What `tcu::TextureFormat` does for the plane compatible formats is done by
// `TexDesc`: a texel is one little-endian integer whose channels sit at a shift and a width. The `_descriptor_buffer` and `_descriptor_heap`
// cases are registered and report NotPorted: the executor only has the descriptor set mode.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, ExtDescriptorBufferExtensionDeviceCommands, InstanceV1_1};

use super::format_tests::{channel_desc, read_channel, ycbcr_formats};
use super::image_query_tests::{IDENTITY, YcbcrConversion};
use super::util::{
    MultiPlaneImageData, allocate_and_bind_image_memory, check_image_support, format_description, plane_aspect,
    plane_extent, upload_image,
};
use crate::tcu::random::{Random, de_int32_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_descriptor_set};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::shaderexecutor::{
    BufferDescriptor, ExecutorDescriptorMode, ScalarKind, ShaderSpec, ShaderType, Symbol, check_support_shader,
    execute, execute_buffer, executor_programs, executor_supported,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// "Plane Format Compatibility Table" companions: some formats compatible with the plane formats.
const COMPATIBLE_FORMATS: [vk::Format; 17] = [
    vk::Format::R4G4_UNORM_PACK8,
    vk::Format::R8_UINT,
    vk::Format::R8_SINT,
    vk::Format::R8G8_UNORM,
    vk::Format::R8G8_UINT,
    vk::Format::R10X6_UNORM_PACK16,
    vk::Format::R12X4_UNORM_PACK16,
    vk::Format::R16_UNORM,
    vk::Format::R16_UINT,
    vk::Format::R16_SINT,
    vk::Format::R4G4B4A4_UNORM_PACK16,
    vk::Format::R10X6G10X6_UNORM_2PACK16,
    vk::Format::R12X4G12X4_UNORM_2PACK16,
    vk::Format::R16G16_UNORM,
    vk::Format::R8G8B8A8_UNORM,
    vk::Format::R8G8B8A8_UINT,
    vk::Format::R32_UINT,
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    Unorm,
    Uint,
    Sint,
}

/// A texel of a single plane format as one little-endian integer; each channel is `(shift, width)`.
#[derive(Clone, Copy)]
struct TexDesc {
    bytes: usize,
    channels: [Option<(u32, u32)>; 4],
    kind: Kind,
}

const fn desc(bytes: usize, channels: [Option<(u32, u32)>; 4], kind: Kind) -> TexDesc {
    TexDesc { bytes, channels, kind }
}

const R8: [Option<(u32, u32)>; 4] = [Some((0, 8)), None, None, None];
const R16: [Option<(u32, u32)>; 4] = [Some((0, 16)), None, None, None];
const R8G8: [Option<(u32, u32)>; 4] = [Some((0, 8)), Some((8, 8)), None, None];

static TEX_DESCS: &[(vk::Format, TexDesc)] = &[
    (
        vk::Format::R4G4_UNORM_PACK8,
        desc(1, [Some((4, 4)), Some((0, 4)), None, None], Kind::Unorm),
    ),
    (vk::Format::R8_UNORM, desc(1, R8, Kind::Unorm)),
    (vk::Format::R8_UINT, desc(1, R8, Kind::Uint)),
    (vk::Format::R8_SINT, desc(1, R8, Kind::Sint)),
    (vk::Format::R8G8_UNORM, desc(2, R8G8, Kind::Unorm)),
    (vk::Format::R8G8_UINT, desc(2, R8G8, Kind::Uint)),
    (
        vk::Format::R10X6_UNORM_PACK16,
        desc(2, [Some((6, 10)), None, None, None], Kind::Unorm),
    ),
    (
        vk::Format::R12X4_UNORM_PACK16,
        desc(2, [Some((4, 12)), None, None, None], Kind::Unorm),
    ),
    (vk::Format::R16_UNORM, desc(2, R16, Kind::Unorm)),
    (vk::Format::R16_UINT, desc(2, R16, Kind::Uint)),
    (vk::Format::R16_SINT, desc(2, R16, Kind::Sint)),
    (
        vk::Format::R4G4B4A4_UNORM_PACK16,
        desc(
            2,
            [Some((12, 4)), Some((8, 4)), Some((4, 4)), Some((0, 4))],
            Kind::Unorm,
        ),
    ),
    (
        vk::Format::R10X6G10X6_UNORM_2PACK16,
        desc(4, [Some((6, 10)), Some((22, 10)), None, None], Kind::Unorm),
    ),
    (
        vk::Format::R12X4G12X4_UNORM_2PACK16,
        desc(4, [Some((4, 12)), Some((20, 12)), None, None], Kind::Unorm),
    ),
    (
        vk::Format::R16G16_UNORM,
        desc(4, [Some((0, 16)), Some((16, 16)), None, None], Kind::Unorm),
    ),
    (
        vk::Format::R8G8B8A8_UNORM,
        desc(
            4,
            [Some((0, 8)), Some((8, 8)), Some((16, 8)), Some((24, 8))],
            Kind::Unorm,
        ),
    ),
    (
        vk::Format::R8G8B8A8_UINT,
        desc(
            4,
            [Some((0, 8)), Some((8, 8)), Some((16, 8)), Some((24, 8))],
            Kind::Uint,
        ),
    ),
    (
        vk::Format::R32_UINT,
        desc(4, [Some((0, 32)), None, None, None], Kind::Uint),
    ),
];

fn tex_desc(format: vk::Format) -> TexDesc {
    TEX_DESCS
        .iter()
        .find(|(f, _)| *f == format)
        .map(|(_, d)| *d)
        .unwrap_or_else(|| panic!("no texel description for {format:?}"))
}

fn channel_mask(bits: u32) -> u64 {
    (1u64 << bits) - 1
}

/// `ConstPixelBufferAccess::getPixel`: absent channels read as (0, 0, 0, 1); integer formats give the integer value as a float.
fn decode_texel(desc: &TexDesc, bytes: &[u8]) -> [f32; 4] {
    let mut word = 0u64;
    for (ndx, byte) in bytes.iter().take(desc.bytes).enumerate() {
        word |= u64::from(*byte) << (8 * ndx);
    }
    std::array::from_fn(|c| match desc.channels[c] {
        Some((shift, bits)) => {
            let raw = (word >> shift) & channel_mask(bits);
            match desc.kind {
                Kind::Unorm => raw as f32 / channel_mask(bits) as f32,
                Kind::Uint => raw as f32,
                Kind::Sint => {
                    let sign = 1u64 << (bits - 1);
                    if raw & sign != 0 {
                        (raw as i64 - (1i64 << bits)) as f32
                    } else {
                        raw as f32
                    }
                }
            }
        }
        None => {
            if c == 3 {
                1.0
            } else {
                0.0
            }
        }
    })
}

/// `PixelBufferAccess::setPixel` through the `PixelSetter` of the format: `words` are what the executor wrote, floats, ints or uints
/// by the plane compatible format. Every channel goes through the saturating conversion of the channel type.
fn encode_texel(desc: &TexDesc, words: [u32; 4]) -> Vec<u8> {
    let mut texel = 0u64;
    for c in 0..4 {
        let Some((shift, bits)) = desc.channels[c] else {
            continue;
        };
        let max = channel_mask(bits);
        let raw = match desc.kind {
            Kind::Unorm => (f32::from_bits(words[c]).clamp(0.0, 1.0) * max as f32 + 0.5).floor() as u64,
            Kind::Uint => u64::from(words[c]).min(max),
            Kind::Sint => {
                let half = 1i64 << (bits - 1);
                ((words[c] as i32 as i64).clamp(-half, half - 1) as u64) & max
            }
        };
        texel |= raw << shift;
    }
    texel.to_le_bytes()[..desc.bytes].to_vec()
}

fn is_int_format(format: vk::Format) -> bool {
    format!("{format:?}").ends_with("SINT")
}

fn is_uint_format(format: vk::Format) -> bool {
    format!("{format:?}").ends_with("UINT")
}

fn is_padded_format(format: vk::Format) -> bool {
    let name = format!("{format:?}");
    name.contains("10X6") || name.contains("12X4")
}

fn formats_are_compatible(format0: vk::Format, format1: vk::Format) -> bool {
    format0 == format1 || tex_desc(format0).bytes == tex_desc(format1).bytes
}

/// `chooseComparisonFormat`
fn choose_comparison_format(plane_original: vk::Format, plane_compatible: vk::Format) -> vk::Format {
    let is_original_padded = is_padded_format(plane_original);
    let is_compatible_padded = is_padded_format(plane_compatible);

    if is_original_padded && is_compatible_padded {
        if plane_original == plane_compatible {
            return plane_original;
        }

        let (fmt1, fmt2) = if plane_original.as_raw() < plane_compatible.as_raw() {
            (plane_original, plane_compatible)
        } else {
            (plane_compatible, plane_original)
        };

        if fmt1 == vk::Format::R10X6_UNORM_PACK16 && fmt2 == vk::Format::R12X4_UNORM_PACK16 {
            return fmt1;
        }
        if fmt1 == vk::Format::R10X6G10X6_UNORM_2PACK16 && fmt2 == vk::Format::R12X4G12X4_UNORM_2PACK16 {
            return fmt1;
        }
        panic!("no common format for {plane_original:?} and {plane_compatible:?}");
    }

    if is_compatible_padded {
        return plane_compatible;
    }
    plane_original
}

static VIEW_SPEC_FLOAT: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("texCoord", ScalarKind::Float, 2)],
    outputs: &[
        Symbol::new("result0", ScalarKind::Float, 4),
        Symbol::new("result1", ScalarKind::Float, 4),
    ],
};

static VIEW_SPEC_INT: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("texCoord", ScalarKind::Float, 2)],
    outputs: &[
        Symbol::new("result0", ScalarKind::Float, 4),
        Symbol::new("result1", ScalarKind::Int, 4),
    ],
};

static VIEW_SPEC_UINT: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("texCoord", ScalarKind::Float, 2)],
    outputs: &[
        Symbol::new("result0", ScalarKind::Float, 4),
        Symbol::new("result1", ScalarKind::Uint, 4),
    ],
};

/// `getShaderSpec` and the key of the programs the generator wrote for it.
fn view_spec(plane_compatible_format: vk::Format) -> (&'static ShaderSpec, &'static str) {
    if is_int_format(plane_compatible_format) {
        (&VIEW_SPEC_INT, "ycbcr_view_int")
    } else if is_uint_format(plane_compatible_format) {
        (&VIEW_SPEC_UINT, "ycbcr_view_uint")
    } else {
        (&VIEW_SPEC_FLOAT, "ycbcr_view_float")
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ViewType {
    ImageView,
    MemoryAlias,
}

/// `TestParameters`
#[derive(Clone, Copy)]
struct TestParameters {
    view_type: ViewType,
    format: vk::Format,
    size: (u32, u32),
    create_flags: vk::ImageCreateFlags,
    plane_ndx: usize,
    plane_compatible_format: vk::Format,
    shader_type: ShaderType,
    descriptor_type: ExecutorDescriptorMode,
}

/// `glu::ShaderType` enum value, for the seed.
fn shader_type_value(shader_type: ShaderType) -> i32 {
    match shader_type {
        ShaderType::Vertex => 0,
        ShaderType::Fragment => 1,
        ShaderType::Geometry => 2,
        ShaderType::TessellationControl => 3,
        ShaderType::TessellationEvaluation => 4,
        ShaderType::Compute => 5,
        ShaderType::Task => 6,
        ShaderType::Mesh => 7,
    }
}

/// `checkImageFeatureSupport`
fn check_image_feature_support(
    context: &Context<'_>,
    format: vk::Format,
    required: vk::FormatFeatureFlags,
) -> Result<(), TestError> {
    let properties = unsafe {
        context
            .get_instance()
            .get_physical_device_format_properties(context.get_physical_device(), format)
    };
    if !properties.optimal_tiling_features.contains(required) {
        return Err(TestError::NotSupported(
            "Format doesn't support required features".to_string(),
        ));
    }
    Ok(())
}

/// `createTestImage`
fn create_test_image<'a>(
    device: &'a Device,
    format: vk::Format,
    size: (u32, u32),
    create_flags: vk::ImageCreateFlags,
) -> Result<Unique<'a, vk::Image>, TestError> {
    let create_info = vk::ImageCreateInfo::builder()
        .flags(create_flags)
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: size.0,
            height: size.1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED);
    Ok(Unique::new(
        device,
        unsafe { device.create_image(&create_info, None) }.vk_check("vkCreateImage")?,
    ))
}

/// `makeImageViewCreateInfo`
fn make_image_view_create_info(
    image: vk::Image,
    format: vk::Format,
    image_aspect: vk::ImageAspectFlags,
    sampler_conversion_info: *const vk::SamplerYcbcrConversionInfo,
) -> vk::ImageViewCreateInfo {
    vk::ImageViewCreateInfo {
        s_type: vk::StructureType::IMAGE_VIEW_CREATE_INFO,
        next: sampler_conversion_info.cast(),
        flags: vk::ImageViewCreateFlags::empty(),
        image,
        view_type: vk::ImageViewType::_2D,
        format,
        components: IDENTITY,
        subresource_range: vk::ImageSubresourceRange {
            aspect_mask: image_aspect,
            base_mip_level: 0,
            level_count: 1,
            base_array_layer: 0,
            layer_count: 1,
        },
    }
}

/// `executeImageBarrier`
fn execute_image_barrier(
    device: &Device,
    queue: vk::Queue,
    queue_family_index: u32,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) -> Result<(), TestError> {
    let command_pool = make_command_pool(device, queue_family_index)?;
    let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

    begin_command_buffer(device, *command_buffer)?;
    unsafe {
        device.cmd_pipeline_barrier(
            *command_buffer,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
    end_command_buffer(device, *command_buffer)?;
    submit_commands_and_wait(device, queue, *command_buffer)
}

fn sampler_create_info(next: *const vk::SamplerYcbcrConversionInfo) -> vk::SamplerCreateInfo {
    vk::SamplerCreateInfo {
        s_type: vk::StructureType::SAMPLER_CREATE_INFO,
        next: next.cast(),
        flags: vk::SamplerCreateFlags::empty(),
        mag_filter: vk::Filter::NEAREST,
        min_filter: vk::Filter::NEAREST,
        mipmap_mode: vk::SamplerMipmapMode::NEAREST,
        address_mode_u: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        address_mode_v: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        address_mode_w: vk::SamplerAddressMode::CLAMP_TO_EDGE,
        mip_lod_bias: 0.0,
        anisotropy_enable: vk::FALSE,
        max_anisotropy: 1.0,
        compare_enable: vk::FALSE,
        compare_op: vk::CompareOp::ALWAYS,
        min_lod: 0.0,
        max_lod: 0.0,
        border_color: vk::BorderColor::FLOAT_TRANSPARENT_BLACK,
        unnormalized_coordinates: vk::FALSE,
    }
}

struct PlaneViewCase {
    name: String,
    params: TestParameters,
}

impl TestCase for PlaneViewCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        check_image_support(context, params.format, params.create_flags, vk::ImageTiling::OPTIMAL)?;
        check_image_feature_support(
            context,
            params.format,
            vk::FormatFeatureFlags::SAMPLED_IMAGE
                | vk::FormatFeatureFlags::TRANSFER_DST
                | vk::FormatFeatureFlags::MIDPOINT_CHROMA_SAMPLES,
        )?;
        check_image_feature_support(
            context,
            params.plane_compatible_format,
            vk::FormatFeatureFlags::SAMPLED_IMAGE | vk::FormatFeatureFlags::TRANSFER_DST,
        )?;
        check_support_shader(context, params.shader_type)?;

        match params.descriptor_type {
            ExecutorDescriptorMode::DescriptorBuffer => {
                context.require_device_functionality("VK_EXT_descriptor_buffer")?
            }
            ExecutorDescriptorMode::DescriptorHeap => context.require_device_functionality("VK_EXT_descriptor_heap")?,
            ExecutorDescriptorMode::DescriptorSet => {}
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(
            view_spec(self.params.plane_compatible_format).1,
            self.params.shader_type,
        )
    }

    fn is_stub(&self) -> bool {
        self.params.descriptor_type == ExecutorDescriptorMode::DescriptorHeap
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PlaneViewInstance {
            context,
            params: self.params,
        })
    }
}

struct PlaneViewInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

impl TestInstance for PlaneViewInstance<'_> {
    /// `testPlaneView`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;

        if params.descriptor_type == ExecutorDescriptorMode::DescriptorHeap {
            return Err(TestError::NotPorted(
                "the descriptor heap mode of the executor".to_string(),
            ));
        }
        let use_descriptor_buffer = params.descriptor_type == ExecutorDescriptorMode::DescriptorBuffer;

        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let mut random_gen = Random::new(
            de_int32_hash(params.format.as_raw())
                ^ de_int32_hash(params.plane_ndx as i32)
                ^ de_int32_hash(shader_type_value(params.shader_type)),
        );

        let (queue, queue_ndx) = if params.shader_type == ShaderType::Fragment {
            (
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            )
        } else {
            context.get_compute_queue().unwrap_or((
                context.get_universal_queue(),
                context.get_universal_queue_family_index(),
            ))
        };

        let format = params.format;
        let create_flags = params.create_flags;
        let size = params.size;
        let format_info = format_description(format);
        let plane_extent = plane_extent(&format_info, size, params.plane_ndx);

        let image = create_test_image(device, format, size, create_flags)?;
        let image_alias = if params.view_type == ViewType::MemoryAlias {
            Some(create_test_image(
                device,
                params.plane_compatible_format,
                plane_extent,
                create_flags,
            )?)
        } else {
            None
        };
        let allocations = allocate_and_bind_image_memory(
            device,
            allocator,
            *image,
            format,
            create_flags.contains(vk::ImageCreateFlags::DISJOINT),
            MemoryRequirement::ANY,
        )?;

        if let Some(image_alias) = &image_alias {
            let allocation = &allocations[params.plane_ndx];
            if create_flags.contains(vk::ImageCreateFlags::DISJOINT) {
                let mut plane_info =
                    vk::BindImagePlaneMemoryInfo::builder().plane_aspect(vk::ImageAspectFlags::PLANE_0);
                let core_info = vk::BindImageMemoryInfo::builder()
                    .image(**image_alias)
                    .memory(allocation.get_memory())
                    .memory_offset(allocation.get_offset())
                    .push_next(&mut plane_info);
                unsafe { device.bind_image_memory2(&[core_info]) }.vk_check("vkBindImageMemory2")?;
            } else {
                unsafe { device.bind_image_memory(**image_alias, allocation.get_memory(), allocation.get_offset()) }
                    .vk_check("vkBindImageMemory")?;
            }
        }

        let conversion_info = vk::SamplerYcbcrConversionCreateInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_CREATE_INFO,
            next: std::ptr::null(),
            format,
            ycbcr_model: vk::SamplerYcbcrModelConversion::RGB_IDENTITY,
            ycbcr_range: vk::SamplerYcbcrRange::ITU_FULL,
            components: IDENTITY,
            x_chroma_offset: vk::ChromaLocation::MIDPOINT,
            y_chroma_offset: vk::ChromaLocation::MIDPOINT,
            chroma_filter: vk::Filter::NEAREST,
            force_explicit_reconstruction: vk::FALSE,
        };
        let conversion = YcbcrConversion {
            device,
            handle: unsafe { device.create_sampler_ycbcr_conversion(&conversion_info, None) }
                .vk_check("vkCreateSamplerYcbcrConversion")?,
        };
        let sampler_conversion_info = vk::SamplerYcbcrConversionInfo {
            s_type: vk::StructureType::SAMPLER_YCBCR_CONVERSION_INFO,
            next: std::ptr::null(),
            conversion: conversion.handle,
        };

        let whole_view_create_info =
            make_image_view_create_info(*image, format, vk::ImageAspectFlags::COLOR, &sampler_conversion_info);
        let plane_view_create_info = match &image_alias {
            None => make_image_view_create_info(
                *image,
                params.plane_compatible_format,
                plane_aspect(params.plane_ndx),
                std::ptr::null(),
            ),
            Some(image_alias) => make_image_view_create_info(
                **image_alias,
                params.plane_compatible_format,
                vk::ImageAspectFlags::COLOR,
                std::ptr::null(),
            ),
        };
        let whole_view = Unique::new(
            device,
            unsafe { device.create_image_view(&whole_view_create_info, None) }.vk_check("vkCreateImageView")?,
        );
        let plane_view = Unique::new(
            device,
            unsafe { device.create_image_view(&plane_view_create_info, None) }.vk_check("vkCreateImageView")?,
        );

        let whole_sampler_info = sampler_create_info(&sampler_conversion_info);
        let plane_sampler_info = sampler_create_info(std::ptr::null());

        let image_format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
            .format(format)
            .type_(vk::ImageType::_2D)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::SAMPLED)
            .flags(create_flags);
        let mut ycbcr_properties = vk::SamplerYcbcrConversionImageFormatProperties::default();
        let mut ext_properties = vk::ImageFormatProperties2::builder().push_next(&mut ycbcr_properties);
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties2(
                context.get_physical_device(),
                &image_format_info,
                &mut ext_properties,
            )
        };
        if matches!(result, Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED)) {
            return Err(TestError::NotSupported("Format not supported.".to_string()));
        }
        result.vk_check("vkGetPhysicalDeviceImageFormatProperties2")?;
        let combined_sampler_descriptor_count = ycbcr_properties.combined_image_sampler_descriptor_count;

        let whole_sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&whole_sampler_info, None) }.vk_check("vkCreateSampler")?,
        );
        let plane_sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&plane_sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        // Set 1: binding 0 is the plane view, binding 1 the whole image with the immutable conversion sampler.
        let desc_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, vk::ShaderStageFlags::ALL)
            .add_indexed_sampler_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::ALL,
                1,
                &[*whole_sampler],
            )
            .build_with_flags(
                device,
                if use_descriptor_buffer {
                    vk::DescriptorSetLayoutCreateFlags::DESCRIPTOR_BUFFER_EXT
                } else {
                    vk::DescriptorSetLayoutCreateFlags::empty()
                },
            )?;
        let image_info0 = vk::DescriptorImageInfo {
            sampler: *plane_sampler,
            image_view: *plane_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let image_info1 = vk::DescriptorImageInfo {
            sampler: *whole_sampler,
            image_view: *whole_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        };
        let buffer_descriptors = [
            BufferDescriptor {
                image_info: image_info0,
                buffer_offset: unsafe { device.get_descriptor_set_layout_binding_offset_ext(*desc_layout, 0) },
                combined_sampler_descriptor_count: 1,
            },
            BufferDescriptor {
                image_info: image_info1,
                buffer_offset: unsafe { device.get_descriptor_set_layout_binding_offset_ext(*desc_layout, 1) },
                combined_sampler_descriptor_count,
            },
        ];
        let desc_pool = DescriptorPoolBuilder::new()
            .add_type(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                2 * combined_sampler_descriptor_count,
            )
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let desc_set = if use_descriptor_buffer {
            None
        } else {
            Some(make_descriptor_set(device, *desc_pool, *desc_layout)?)
        };
        if let Some(desc_set) = &desc_set {
            let writes = [
                vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: desc_set.get(),
                    dst_binding: 0,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    image_info: &image_info0,
                    buffer_info: std::ptr::null(),
                    texel_buffer_view: std::ptr::null(),
                },
                vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: desc_set.get(),
                    dst_binding: 1,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                    image_info: &image_info1,
                    buffer_info: std::ptr::null(),
                    texel_buffer_view: std::ptr::null(),
                },
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        let mut image_data = MultiPlaneImageData::new(format, size);
        image_data.fill_random(&mut random_gen);

        if let Some(image_alias) = &image_alias {
            // Transition the alias to the right layout first
            let init_alias_barrier = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::SHADER_READ)
                .old_layout(vk::ImageLayout::UNDEFINED)
                .new_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(**image_alias)
                .subresource_range(vk::ImageSubresourceRange {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    base_mip_level: 0,
                    level_count: 1,
                    base_array_layer: 0,
                    layer_count: 1,
                })
                .build();
            execute_image_barrier(
                device,
                queue,
                queue_ndx,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::ALL_COMMANDS,
                init_alias_barrier,
            )?;
        }

        upload_image(
            device,
            allocator,
            queue,
            queue_ndx,
            *image,
            &image_data,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        )?;

        let num_values = 500usize;
        let threshold = 0.02f32;
        let mut all_ok = true;

        // generateLookupCoordinates
        let mut texels = Vec::with_capacity(num_values);
        let mut tex_coord: Vec<[f32; 2]> = Vec::with_capacity(num_values);
        for _ in 0..num_values {
            let texel_x = random_gen.get_uint32() % size.0;
            let texel_y = random_gen.get_uint32() % size.1;
            texels.push((texel_x, texel_y));
            tex_coord.push([
                (texel_x as f32 + 0.5) / size.0 as f32,
                (texel_y as f32 + 0.5) / size.1 as f32,
            ]);
        }
        let tex_coord_bytes: Vec<u8> = tex_coord
            .iter()
            .flatten()
            .flat_map(|value| value.to_ne_bytes())
            .collect();
        let mut result_whole_bytes = vec![0u8; num_values * 16];
        let mut result_plane_bytes = vec![0u8; num_values * 16];

        let (spec, _) = view_spec(params.plane_compatible_format);
        if let Some(desc_set) = &desc_set {
            execute(
                context,
                params.shader_type,
                spec,
                Some(*desc_layout),
                num_values,
                &[&tex_coord_bytes],
                &mut [&mut result_whole_bytes[..], &mut result_plane_bytes[..]],
                Some(desc_set.get()),
            )?;
        } else {
            execute_buffer(
                context,
                params.shader_type,
                spec,
                *desc_layout,
                num_values,
                &[&tex_coord_bytes],
                &mut [&mut result_whole_bytes[..], &mut result_plane_bytes[..]],
                &buffer_descriptors,
            )?;
        }

        let words_of = |bytes: &[u8], ndx: usize| -> [u32; 4] {
            std::array::from_fn(|c| {
                let at = ndx * 16 + 4 * c;
                u32::from_ne_bytes([bytes[at], bytes[at + 1], bytes[at + 2], bytes[at + 3]])
            })
        };

        // Compare whole image.
        for ndx in 0..num_values {
            let (texel_x, texel_y) = texels[ndx];
            let reference: [f32; 4] = std::array::from_fn(|channel_ndx| {
                if channel_desc(format, channel_ndx).is_some() {
                    read_channel(&image_data, channel_ndx, texel_x, texel_y)
                } else if channel_ndx == 3 {
                    1.0
                } else {
                    0.0
                }
            });
            let result = words_of(&result_whole_bytes, ndx).map(f32::from_bits);

            if (0..4).any(|c| (result[c] - reference[c]).abs() >= threshold) {
                log::error!(
                    "ERROR: When sampling complete image at {:?}: got {:?}, expected {:?}",
                    tex_coord[ndx],
                    result,
                    reference
                );
                all_ok = false;
            }
        }

        // Compare sampled plane.
        {
            // The format of the specific plane we worked with (G10X6_etc becomes R10X6), not the full image format.
            let plane_original_format = format_info.planes[params.plane_ndx].compatible_format;
            let plane_compatible_format = params.plane_compatible_format;
            let compatible_desc = tex_desc(plane_compatible_format);

            // The padded format is chosen as a priority because, if it exists, some bits may have been lost there.
            let comparison_format = choose_comparison_format(plane_original_format, plane_compatible_format);
            let comparison_desc = tex_desc(comparison_format);

            let plane_data = image_data.plane(params.plane_ndx);
            let (plane_width, plane_height) = plane_extent;

            for ndx in 0..num_values {
                // The executor's raw words are re-packed into the compatible format, then read back as the comparison format.
                let repacked = encode_texel(&compatible_desc, words_of(&result_plane_bytes, ndx));
                let mut padded = repacked.clone();
                padded.resize(8, 0);
                let result_value = decode_texel(&comparison_desc, &padded);

                let coord = tex_coord[ndx];
                let sample_x =
                    ((coord[0] * plane_width as f32).floor() as i64).clamp(0, i64::from(plane_width) - 1) as usize;
                let sample_y =
                    ((coord[1] * plane_height as f32).floor() as i64).clamp(0, i64::from(plane_height) - 1) as usize;
                let at = (sample_y * plane_width as usize + sample_x) * comparison_desc.bytes;
                let reference_value = decode_texel(&comparison_desc, &plane_data[at..at + comparison_desc.bytes]);

                if (0..4).any(|c| (result_value[c] - reference_value[c]).abs() >= threshold) {
                    log::error!(
                        "ERROR: When sampling plane view at {:?}: got {:?}, expected {:?}",
                        coord,
                        result_value,
                        reference_value
                    );
                    all_ok = false;
                }
            }
        }

        Ok(if all_ok {
            TestStatus::pass("All samples passed")
        } else {
            TestStatus::fail("Got invalid results")
        })
    }
}

/// `addPlaneViewCase`
fn add_plane_view_case(group: &mut TestCaseGroup, params: TestParameters, is_compatibility_format: bool) {
    let mut name = format!("{format:?}", format = params.format).to_lowercase();

    if params.view_type != ViewType::MemoryAlias && params.create_flags.contains(vk::ImageCreateFlags::DISJOINT) {
        name.push_str("_disjoint");
    }

    name.push_str(&format!("_plane_{}", params.plane_ndx));

    if is_compatibility_format {
        name.push_str(&format!(
            "_compatible_format_{}",
            format!("{:?}", params.plane_compatible_format).to_lowercase()
        ));
    }

    match params.shader_type {
        ShaderType::Compute => name.push_str("_compute"),
        ShaderType::Fragment => name.push_str("_fragment"),
        _ => {}
    }

    match params.descriptor_type {
        ExecutorDescriptorMode::DescriptorBuffer => name.push_str("_descriptor_buffer"),
        ExecutorDescriptorMode::DescriptorHeap => name.push_str("_descriptor_heap"),
        ExecutorDescriptorMode::DescriptorSet => {}
    }

    group.add_child(Box::new(PlaneViewCase { name, params }) as Box<dyn TestCase>);
}

/// `populateViewTypeGroup`
fn populate_view_type_group(group: &mut TestCaseGroup, view_type: ViewType) {
    let shader_types = [ShaderType::Fragment, ShaderType::Compute];
    let size = (32u32, 58u32);
    let base_flags = vk::ImageCreateFlags::MUTABLE_FORMAT
        | if view_type == ViewType::MemoryAlias {
            vk::ImageCreateFlags::ALIAS
        } else {
            vk::ImageCreateFlags::empty()
        };
    let descriptor_types = [
        ExecutorDescriptorMode::DescriptorSet,
        ExecutorDescriptorMode::DescriptorBuffer,
        ExecutorDescriptorMode::DescriptorHeap,
    ];

    let mut formats = ycbcr_formats();
    // Upstream's second loop stops before the last 444 two plane format.
    formats.retain(|format| *format != vk::Format::G16_B16R16_2PLANE_444_UNORM);

    for format in formats {
        let num_planes = format_description(format).planes.len();

        if num_planes == 1 {
            continue;
        }

        for is_disjoint in [false, true] {
            let flags = base_flags
                | if is_disjoint {
                    vk::ImageCreateFlags::DISJOINT
                } else {
                    vk::ImageCreateFlags::empty()
                };

            if view_type == ViewType::MemoryAlias && !flags.contains(vk::ImageCreateFlags::DISJOINT) {
                continue;
            }

            for plane_ndx in 0..num_planes {
                for shader_type in shader_types {
                    for descriptor_type in descriptor_types {
                        if !executor_supported(shader_type, descriptor_type) {
                            continue;
                        }

                        let plane_format = format_description(format).planes[plane_ndx].compatible_format;
                        let make_params = |plane_compatible_format: vk::Format| TestParameters {
                            view_type,
                            format,
                            size,
                            create_flags: flags,
                            plane_ndx,
                            plane_compatible_format,
                            shader_type,
                            descriptor_type,
                        };

                        // An image view with a format taken from the "Plane Format Compatibility Table".
                        add_plane_view_case(group, make_params(plane_format), false);

                        // Views with a format that is compatible with the plane's format, e.g. R4G4_UNORM_PACK8 with R8_UNORM.
                        for compatible_format in COMPATIBLE_FORMATS {
                            if compatible_format == plane_format {
                                continue;
                            }
                            if !formats_are_compatible(plane_format, compatible_format) {
                                continue;
                            }
                            add_plane_view_case(group, make_params(compatible_format), true);
                        }
                    }
                }
            }
        }
    }
}

/// `createViewTests`
pub fn create_view_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("plane_view");

    let mut image_view = TestCaseGroup::new("image_view");
    populate_view_type_group(&mut image_view, ViewType::ImageView);
    group.add_child(image_view);

    let mut memory_alias = TestCaseGroup::new("memory_alias");
    populate_view_type_group(&mut memory_alias, ViewType::MemoryAlias);
    group.add_child(memory_alias);

    group
}
