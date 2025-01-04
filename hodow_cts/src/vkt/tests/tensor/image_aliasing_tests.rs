// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorImageAliasing.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `genShaderImageAccess` and `genShaderTensorAccess` are `scripts/gen_tensor_manifests.py`: per image format one
// case with `image_r<image rank>_<variant>` and `tensor_r<tensor rank>_read|write` programs. The cases are returned keyed by their dotted path so
// `tensor::create_tests` can swap them in for the gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ArmTensorsExtensionDeviceCommands, DeviceV1_3};

use super::tensor_util::{
    ElementKind, StridedMemory, TensorDescription, TensorParameters, TensorView, compare_strided_memory,
    create_descriptor_pool, device_supports_non_packed_tensors, device_supports_shader_stages_tensor_access,
    device_supports_shader_tensor_access, format_support_tensor_flags, get_format_size, make_compute_pipeline,
    make_tensor_memory_barrier, pool_size, single_dimension_workgroup_count, tensor_descriptor_write,
};
use crate::generated::shaders::tensor_image_aliasing::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

const SHADER_IMAGE_ACCESS_WORKGROUP_SIZE: u32 = 128;
const SHADER_TENSOR_ACCESS_WORKGROUP_SIZE: u32 = 128;

#[derive(Clone, Copy, PartialEq, Eq)]
enum ImageAliasingVariant {
    ImageProducerTensorConsumer,
    TensorProducerImageConsumer,
    TensorProducerImageSample,
}

impl ImageAliasingVariant {
    fn name(self) -> &'static str {
        match self {
            Self::ImageProducerTensorConsumer => "image_to_tensor",
            Self::TensorProducerImageConsumer => "tensor_to_image",
            Self::TensorProducerImageSample => "tensor_to_sampled_image",
        }
    }
}

/// `imageToTensorFormat`
fn image_to_tensor_format(image_format: vk::Format) -> vk::Format {
    match image_format {
        vk::Format::R8_SINT | vk::Format::R8G8_SINT | vk::Format::R8G8B8A8_SINT => vk::Format::R8_SINT,
        vk::Format::R16_SINT | vk::Format::R16G16_SINT | vk::Format::R16G16B16A16_SINT => vk::Format::R16_SINT,
        vk::Format::R32_SINT | vk::Format::R32G32_SINT | vk::Format::R32G32B32A32_SINT => vk::Format::R32_SINT,
        vk::Format::R64_SINT => vk::Format::R64_SINT,
        vk::Format::R8_UINT | vk::Format::R8G8_UINT | vk::Format::R8G8B8A8_UINT => vk::Format::R8_UINT,
        vk::Format::R16_UINT | vk::Format::R16G16_UINT | vk::Format::R16G16B16A16_UINT => vk::Format::R16_UINT,
        vk::Format::R32_UINT | vk::Format::R32G32_UINT | vk::Format::R32G32B32A32_UINT => vk::Format::R32_UINT,
        vk::Format::R64_UINT => vk::Format::R64_UINT,
        _ => panic!("unexpected image format {image_format:?}"),
    }
}

/// `getFormatComponents`
fn format_components(format: vk::Format) -> u64 {
    match format {
        vk::Format::R8_SINT
        | vk::Format::R16_SINT
        | vk::Format::R32_SINT
        | vk::Format::R64_SINT
        | vk::Format::R8_UINT
        | vk::Format::R16_UINT
        | vk::Format::R32_UINT
        | vk::Format::R64_UINT => 1,
        vk::Format::R8G8_SINT
        | vk::Format::R16G16_SINT
        | vk::Format::R32G32_SINT
        | vk::Format::R8G8_UINT
        | vk::Format::R16G16_UINT
        | vk::Format::R32G32_UINT => 2,
        _ => 4,
    }
}

fn image_format_short_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R8_SINT => "R8_SINT",
        vk::Format::R8_UINT => "R8_UINT",
        vk::Format::R8G8_SINT => "R8G8_SINT",
        vk::Format::R8G8_UINT => "R8G8_UINT",
        vk::Format::R8G8B8A8_SINT => "R8G8B8A8_SINT",
        vk::Format::R8G8B8A8_UINT => "R8G8B8A8_UINT",
        vk::Format::R16_SINT => "R16_SINT",
        vk::Format::R16_UINT => "R16_UINT",
        vk::Format::R16G16_SINT => "R16G16_SINT",
        vk::Format::R16G16_UINT => "R16G16_UINT",
        vk::Format::R16G16B16A16_SINT => "R16G16B16A16_SINT",
        vk::Format::R16G16B16A16_UINT => "R16G16B16A16_UINT",
        vk::Format::R32_SINT => "R32_SINT",
        vk::Format::R32_UINT => "R32_UINT",
        vk::Format::R32G32_SINT => "R32G32_SINT",
        vk::Format::R32G32_UINT => "R32G32_UINT",
        vk::Format::R32G32B32A32_SINT => "R32G32B32A32_SINT",
        vk::Format::R32G32B32A32_UINT => "R32G32B32A32_UINT",
        vk::Format::R64_SINT => "R64_SINT",
        vk::Format::R64_UINT => "R64_UINT",
        _ => panic!("unsupported image format {format:?}"),
    }
}

fn image_type_short_name(image_type: vk::ImageType) -> &'static str {
    match image_type {
        vk::ImageType::_1D => "1D",
        vk::ImageType::_2D => "2D",
        _ => "3D",
    }
}

fn image_rank(image_type: vk::ImageType) -> usize {
    match image_type {
        vk::ImageType::_1D => 1,
        vk::ImageType::_2D => 2,
        _ => 3,
    }
}

fn image_type_to_image_view_type(image_type: vk::ImageType) -> vk::ImageViewType {
    match image_type {
        vk::ImageType::_1D => vk::ImageViewType::_1D,
        vk::ImageType::_2D => vk::ImageViewType::_2D,
        _ => vk::ImageViewType::_3D,
    }
}

fn image_tiling_to_tensor_tiling(tiling: vk::ImageTiling) -> vk::TensorTilingARM {
    if tiling == vk::ImageTiling::LINEAR {
        vk::TensorTilingARM::LINEAR
    } else {
        vk::TensorTilingARM::OPTIMAL
    }
}

/// `imageShapeToAliasedTensorShape`
fn image_shape_to_aliased_tensor_shape(
    image_type: vk::ImageType,
    format: vk::Format,
    extent: vk::Extent3D,
) -> Vec<i64> {
    let mut result = Vec::new();
    if image_type == vk::ImageType::_3D {
        result.push(i64::from(extent.depth));
    }
    if image_type != vk::ImageType::_1D {
        result.push(i64::from(extent.height));
    }
    result.push(i64::from(extent.width));
    result.push(format_components(format) as i64);
    result
}

/// `imageLayoutToAliasedTensorStrides`
fn image_layout_to_aliased_tensor_strides(
    image_type: vk::ImageType,
    image_format: vk::Format,
    layout: &vk::SubresourceLayout,
) -> Vec<i64> {
    let tensor_element_size = get_format_size(image_to_tensor_format(image_format)) as i64;

    let mut result = Vec::new();
    if image_type == vk::ImageType::_3D {
        result.push(layout.depth_pitch as i64);
    }
    if image_type != vk::ImageType::_1D {
        result.push(layout.row_pitch as i64);
    }
    result.push(format_components(image_format) as i64 * tensor_element_size);
    result.push(tensor_element_size);
    result
}

fn image_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    barrier: (
        vk::PipelineStageFlags2,
        vk::AccessFlags2,
        vk::PipelineStageFlags2,
        vk::AccessFlags2,
    ),
    layouts: (vk::ImageLayout, vk::ImageLayout),
) {
    let (src_stage_mask, src_access_mask, dst_stage_mask, dst_access_mask) = barrier;
    let image_barrier = vk::ImageMemoryBarrier2 {
        src_stage_mask,
        src_access_mask,
        dst_stage_mask,
        dst_access_mask,
        old_layout: layouts.0,
        new_layout: layouts.1,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        image,
        subresource_range: make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        ..Default::default()
    };
    let dependency_info = vk::DependencyInfo {
        image_memory_barrier_count: 1,
        image_memory_barriers: &image_barrier,
        ..Default::default()
    };
    unsafe { device.cmd_pipeline_barrier2(cmd_buffer, &dependency_info) };
}

fn barrier_transition_from_undefined(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    new_layout: vk::ImageLayout,
) {
    image_barrier(
        device,
        cmd_buffer,
        image,
        (
            vk::PipelineStageFlags2::empty(),
            vk::AccessFlags2::empty(),
            vk::PipelineStageFlags2::COMPUTE_SHADER,
            vk::AccessFlags2::SHADER_WRITE | vk::AccessFlags2::SHADER_READ | vk::AccessFlags2::SHADER_SAMPLED_READ,
        ),
        (vk::ImageLayout::UNDEFINED, new_layout),
    );
}

fn barrier_transition_between_compute_dispatches(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
) {
    image_barrier(
        device,
        cmd_buffer,
        image,
        (
            vk::PipelineStageFlags2::COMPUTE_SHADER,
            vk::AccessFlags2::SHADER_WRITE,
            vk::PipelineStageFlags2::COMPUTE_SHADER,
            vk::AccessFlags2::SHADER_READ,
        ),
        (old_layout, new_layout),
    );
}

fn barrier_tensor_between_compute_dispatches(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    tensor: vk::TensorARM,
    src_access: vk::AccessFlags2,
    dst_access: vk::AccessFlags2,
) {
    let barrier = make_tensor_memory_barrier(
        vk::PipelineStageFlags2::COMPUTE_SHADER,
        src_access,
        vk::PipelineStageFlags2::COMPUTE_SHADER,
        dst_access,
        vk::QUEUE_FAMILY_IGNORED,
        vk::QUEUE_FAMILY_IGNORED,
        tensor,
    );
    super::tensor_util::cmd_tensor_memory_barrier(device, cmd_buffer, &barrier);
}

fn barrier_buffer_output(device: &Device, cmd_buffer: vk::CommandBuffer, buffer: vk::Buffer) {
    let barrier = vk::BufferMemoryBarrier2 {
        src_stage_mask: vk::PipelineStageFlags2::COMPUTE_SHADER,
        src_access_mask: vk::AccessFlags2::SHADER_WRITE,
        dst_stage_mask: vk::PipelineStageFlags2::HOST,
        dst_access_mask: vk::AccessFlags2::HOST_READ,
        src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
        buffer,
        offset: 0,
        size: vk::WHOLE_SIZE,
        ..Default::default()
    };
    let dependency_info = vk::DependencyInfo {
        buffer_memory_barrier_count: 1,
        buffer_memory_barriers: &barrier,
        ..Default::default()
    };
    unsafe { device.cmd_pipeline_barrier2(cmd_buffer, &dependency_info) };
}

fn gcd(a: u64, b: u64) -> u64 {
    if b == 0 { a } else { gcd(b, a % b) }
}

struct TensorImageAliasingTestCase {
    name: String,
    image_tiling: vk::ImageTiling,
    image_type: vk::ImageType,
    image_shape: vk::Extent3D,
    image_format: vk::Format,
    variant: ImageAliasingVariant,
    tensor_parameters: TensorParameters,
    test_unified_image_layouts: bool,
}

impl TestCase for TensorImageAliasingTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ARM_tensors")?;

        super::tensor_util::require_tensor_shape_supported(context, &self.tensor_parameters)?;

        if self.test_unified_image_layouts {
            context.require_device_functionality("VK_KHR_unified_image_layouts")?;
        }

        if self.image_format == vk::Format::R64_SINT || self.image_format == vk::Format::R64_UINT {
            context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;
        }

        if !device_supports_shader_tensor_access(context) {
            return Err(TestError::NotSupported(
                "Device does not support shader tensor access".to_string(),
            ));
        }

        if !device_supports_shader_stages_tensor_access(context, vk::ShaderStageFlags::COMPUTE) {
            return Err(TestError::NotSupported(
                "Device does not support shader tensor access in compute shader stage".to_string(),
            ));
        }

        if self.image_tiling == vk::ImageTiling::LINEAR && !device_supports_non_packed_tensors(context) {
            return Err(TestError::NotSupported(
                "Device does not support non-packed tensors, which are required to align with image pitches"
                    .to_string(),
            ));
        }

        let mut required_tensor_format_features = vk::FormatFeatureFlags2::TENSOR_SHADER_ARM;
        if self.image_tiling == vk::ImageTiling::OPTIMAL {
            required_tensor_format_features |= vk::FormatFeatureFlags2::TENSOR_IMAGE_ALIASING_ARM;
        }
        if !format_support_tensor_flags(
            context,
            image_to_tensor_format(self.image_format),
            self.tensor_parameters.tiling,
            required_tensor_format_features,
        ) {
            return Err(TestError::NotSupported(
                "Device does not support the tensor flags for this tiling and format".to_string(),
            ));
        }

        if !image_usage_supported(context, self, self.image_usage()) {
            return Err(TestError::NotSupported(
                "Device does not support the image usage flags for this image type, tiling and format".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = format!("ia_{}", image_format_short_name(self.image_format));
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TensorImageAliasingTestInstance { context, case: self })
    }
}

impl TensorImageAliasingTestCase {
    fn image_usage(&self) -> vk::ImageUsageFlags {
        let mut usage = vk::ImageUsageFlags::STORAGE;
        if self.image_tiling == vk::ImageTiling::OPTIMAL {
            usage |= vk::ImageUsageFlags::TENSOR_ALIASING_ARM;
        }
        if self.variant == ImageAliasingVariant::TensorProducerImageSample {
            usage |= vk::ImageUsageFlags::SAMPLED;
        }
        usage
    }
}

/// `formatSupportImageFlags`
fn image_usage_supported(
    context: &Context<'_>,
    case: &TensorImageAliasingTestCase,
    usage: vk::ImageUsageFlags,
) -> bool {
    use vulkanalia::vk::InstanceV1_1;

    let format_info = vk::PhysicalDeviceImageFormatInfo2::builder()
        .format(case.image_format)
        .type_(case.image_type)
        .tiling(case.image_tiling)
        .usage(usage);
    let mut properties = vk::ImageFormatProperties2::default();
    unsafe {
        context.get_instance().get_physical_device_image_format_properties2(
            context.get_physical_device(),
            &format_info,
            &mut properties,
        )
    }
    .is_ok()
}

struct TensorImageAliasingTestInstance<'a> {
    context: &'a Context<'a>,
    case: &'a TensorImageAliasingTestCase,
}

impl TensorImageAliasingTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        use vulkanalia::vk::DeviceV1_1;

        let case = self.case;
        let context = self.context;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let tensor_parameters = &case.tensor_parameters;
        let kind = ElementKind::for_format(tensor_parameters.format);

        let test_optimal_tiling = case.image_tiling == vk::ImageTiling::OPTIMAL;
        let element_count = tensor_parameters.elements() as u32;

        let queue_family_indices = [queue_family_index];
        let image_create_info = vk::ImageCreateInfo::builder()
            .image_type(case.image_type)
            .format(case.image_format)
            .extent(case.image_shape)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(case.image_tiling)
            .usage(case.image_usage())
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .queue_family_indices(&queue_family_indices)
            .initial_layout(vk::ImageLayout::UNDEFINED);
        let image = Unique::new(
            device,
            unsafe { device.create_image(&image_create_info, None) }.vk_check("vkCreateImage")?,
        );

        let mut strides = Vec::new();
        let mut subresource_offset = 0u64;
        let mut tensor_usage = vk::TensorUsageFlagsARM::SHADER;

        if !test_optimal_tiling {
            let image_subresource = vk::ImageSubresource {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                array_layer: 0,
            };
            let layout = unsafe { device.get_image_subresource_layout(*image, &image_subresource) };
            strides = image_layout_to_aliased_tensor_strides(case.image_type, case.image_format, &layout);
            subresource_offset = layout.offset;
        } else {
            tensor_usage |= vk::TensorUsageFlagsARM::IMAGE_ALIASING;
        }

        let tensor_desc = TensorDescription::new(
            tensor_parameters.tiling,
            tensor_parameters.format,
            &tensor_parameters.dimensions,
            &strides,
            tensor_usage,
        );
        let description = tensor_desc.description();
        let tensor_create_info = vk::TensorCreateInfoARM {
            description: &description,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 1,
            queue_family_indices: queue_family_indices.as_ptr(),
            ..Default::default()
        };
        let tensor = AliasedTensor {
            device,
            tensor: unsafe { device.create_tensor_arm(&tensor_create_info, None) }.vk_check("vkCreateTensorARM")?,
        };

        let image_mem_info = vk::ImageMemoryRequirementsInfo2 {
            image: *image,
            ..Default::default()
        };
        let mut image_mem_reqs = vk::MemoryRequirements2::default();
        unsafe { device.get_image_memory_requirements2(&image_mem_info, &mut image_mem_reqs) };

        let tensor_mem_info = vk::TensorMemoryRequirementsInfoARM {
            tensor: tensor.tensor,
            ..Default::default()
        };
        let mut tensor_mem_reqs = vk::MemoryRequirements2::default();
        unsafe { device.get_tensor_memory_requirements_arm(&tensor_mem_info, &mut tensor_mem_reqs) };

        let image_reqs = image_mem_reqs.memory_requirements;
        let tensor_reqs = tensor_mem_reqs.memory_requirements;
        let mem_size = image_reqs.size.max(tensor_reqs.size + subresource_offset);
        let alignment = {
            let a = image_reqs.alignment;
            let b = tensor_reqs.alignment;
            a / gcd(a, b) * b
        };
        let _ = alignment;
        let mem_type_bits = image_reqs.memory_type_bits & tensor_reqs.memory_type_bits;
        assert!(mem_type_bits > 0);
        assert!(subresource_offset.is_multiple_of(tensor_reqs.alignment));

        let memory_type_index = mem_type_bits.trailing_zeros();
        let alloc_info = vk::MemoryAllocateInfo {
            allocation_size: mem_size,
            memory_type_index,
            ..Default::default()
        };
        let memory = Unique::new(
            device,
            unsafe { device.allocate_memory(&alloc_info, None) }.vk_check("vkAllocateMemory")?,
        );

        let image_bind_info = vk::BindImageMemoryInfo {
            image: *image,
            memory: *memory,
            memory_offset: 0,
            ..Default::default()
        };
        unsafe { device.bind_image_memory2(&[image_bind_info]) }.vk_check("vkBindImageMemory2")?;

        let tensor_bind_info = vk::BindTensorMemoryInfoARM {
            tensor: tensor.tensor,
            memory: *memory,
            memory_offset: subresource_offset,
            ..Default::default()
        };
        unsafe { device.bind_tensor_memory_arm(&[tensor_bind_info]) }.vk_check("vkBindTensorMemoryARM")?;

        let image_view = make_image_view(
            device,
            *image,
            image_type_to_image_view_type(case.image_type),
            case.image_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let tensor_view = TensorView::new(device, tensor.tensor, tensor_parameters.format)?;

        let buffer_size = u64::from(element_count) * kind.size() as u64;
        let make_buffer = || {
            BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )
        };
        let tensor_buffer = make_buffer()?;
        let image_buffer = make_buffer()?;

        let mut tensor_buffer_memory = StridedMemory::new(&[i64::from(element_count)], &[], kind);
        let mut image_buffer_memory = StridedMemory::new(&[i64::from(element_count)], &[], kind);
        match case.variant {
            ImageAliasingVariant::ImageProducerTensorConsumer => {
                image_buffer_memory.fill();
                tensor_buffer_memory.clear();
            }
            ImageAliasingVariant::TensorProducerImageConsumer | ImageAliasingVariant::TensorProducerImageSample => {
                tensor_buffer_memory.fill();
                image_buffer_memory.clear();
            }
        }
        for (memory, buffer) in [
            (&tensor_buffer_memory, &tensor_buffer),
            (&image_buffer_memory, &image_buffer),
        ] {
            unsafe {
                std::ptr::copy_nonoverlapping(
                    memory.data().as_ptr(),
                    buffer.get_allocation().get_host_ptr(),
                    buffer_size as usize,
                );
            }
            flush_alloc(device, buffer.get_allocation())?;
        }

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::TENSOR_ARM, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(
                vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
                vk::ShaderStageFlags::COMPUTE,
            )
            .build(device)?;
        let descriptor_pool = create_descriptor_pool(
            device,
            &[
                pool_size(vk::DescriptorType::TENSOR_ARM, 1),
                pool_size(vk::DescriptorType::STORAGE_BUFFER, 2),
                pool_size(vk::DescriptorType::STORAGE_IMAGE, 1),
                pool_size(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1),
            ],
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let tensor_buffer_descriptor_info = [make_descriptor_buffer_info(tensor_buffer.get(), 0, buffer_size)];
        let image_buffer_descriptor_info = [make_descriptor_buffer_info(image_buffer.get(), 0, buffer_size)];
        let image_descriptor_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *image_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let tensor_views = [tensor_view.get()];
        let tensor_descriptor_info = vk::WriteDescriptorSetTensorARM {
            tensor_view_count: 1,
            tensor_views: tensor_views.as_ptr(),
            ..Default::default()
        };
        let writes = [
            tensor_descriptor_write(descriptor_set.get(), 0, 0, &tensor_descriptor_info),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&tensor_buffer_descriptor_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(2)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&image_descriptor_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(3)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&image_buffer_descriptor_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let sampler = if case.variant == ImageAliasingVariant::TensorProducerImageSample {
            let sampler_info = vk::SamplerCreateInfo::builder()
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
                .compare_op(vk::CompareOp::ALWAYS)
                .min_lod(0.0)
                .max_lod(0.0)
                .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
                .unnormalized_coordinates(false);
            let sampler = Unique::new(
                device,
                unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
            );

            let sampled_image_info = [vk::DescriptorImageInfo {
                sampler: *sampler,
                image_view: *image_view,
                image_layout: vk::ImageLayout::GENERAL,
            }];
            let sampled_write = vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(4)
                .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
                .image_info(&sampled_image_info)
                .build();
            unsafe { device.update_descriptor_sets(&[sampled_write], &[] as &[vk::CopyDescriptorSet]) };
            Some(sampler)
        } else {
            None
        };

        {
            let rank = image_rank(case.image_type);
            let binaries = context.get_binary_collection();
            let image_binary = binaries.get(&format!("image_r{rank}_{}", case.variant.name()))?;
            let tensor_variant = if case.variant == ImageAliasingVariant::ImageProducerTensorConsumer {
                "read"
            } else {
                "write"
            };
            let tensor_binary = binaries.get(&format!("tensor_r{}_{tensor_variant}", rank + 1))?;

            // One shader invocation per texel for the image, so the component part of the tensor is skipped for its group count
            let image_group_count = single_dimension_workgroup_count(
                element_count / *tensor_parameters.dimensions.last().expect("a tensor has dimensions") as u32,
                SHADER_IMAGE_ACCESS_WORKGROUP_SIZE,
            );
            assert!(image_group_count <= 65535);
            let tensor_group_count =
                single_dimension_workgroup_count(element_count, SHADER_TENSOR_ACCESS_WORKGROUP_SIZE);
            assert!(tensor_group_count <= 65535);

            let image_shader_module = create_shader_module(device, image_binary)?;
            let tensor_shader_module = create_shader_module(device, tensor_binary)?;

            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let image_pipeline = make_compute_pipeline(device, *pipeline_layout, *image_shader_module)?;
            let tensor_pipeline = make_compute_pipeline(device, *pipeline_layout, *tensor_shader_module)?;

            let cmd_pool = make_command_pool(device, queue_family_index)?;
            let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;
            let cmd = cmd_buffer.get();

            begin_command_buffer(device, cmd)?;

            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[],
                );
            }

            let unified_or_linear = !test_optimal_tiling || case.test_unified_image_layouts;
            match case.variant {
                ImageAliasingVariant::ImageProducerTensorConsumer => {
                    barrier_transition_from_undefined(device, cmd, *image, vk::ImageLayout::GENERAL);

                    unsafe {
                        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *image_pipeline);
                        device.cmd_dispatch(cmd, image_group_count, 1, 1);
                    }

                    if !unified_or_linear {
                        barrier_transition_between_compute_dispatches(
                            device,
                            cmd,
                            *image,
                            vk::ImageLayout::GENERAL,
                            vk::ImageLayout::TENSOR_ALIASING_ARM,
                        );
                    }
                    barrier_tensor_between_compute_dispatches(
                        device,
                        cmd,
                        tensor.tensor,
                        vk::AccessFlags2::SHADER_WRITE,
                        vk::AccessFlags2::SHADER_READ,
                    );

                    unsafe {
                        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *tensor_pipeline);
                        device.cmd_dispatch(cmd, tensor_group_count, 1, 1);
                    }

                    barrier_buffer_output(device, cmd, tensor_buffer.get());
                }
                ImageAliasingVariant::TensorProducerImageConsumer | ImageAliasingVariant::TensorProducerImageSample => {
                    if unified_or_linear {
                        barrier_transition_from_undefined(device, cmd, *image, vk::ImageLayout::GENERAL);
                    } else {
                        barrier_transition_from_undefined(device, cmd, *image, vk::ImageLayout::TENSOR_ALIASING_ARM);
                    }

                    barrier_tensor_between_compute_dispatches(
                        device,
                        cmd,
                        tensor.tensor,
                        vk::AccessFlags2::SHADER_WRITE,
                        vk::AccessFlags2::SHADER_WRITE,
                    );

                    unsafe {
                        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *tensor_pipeline);
                        device.cmd_dispatch(cmd, tensor_group_count, 1, 1);
                    }

                    if unified_or_linear {
                        barrier_transition_between_compute_dispatches(
                            device,
                            cmd,
                            *image,
                            vk::ImageLayout::GENERAL,
                            vk::ImageLayout::GENERAL,
                        );
                    } else {
                        barrier_transition_between_compute_dispatches(
                            device,
                            cmd,
                            *image,
                            vk::ImageLayout::TENSOR_ALIASING_ARM,
                            vk::ImageLayout::GENERAL,
                        );
                    }

                    unsafe {
                        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *image_pipeline);
                        device.cmd_dispatch(cmd, image_group_count, 1, 1);
                    }

                    barrier_buffer_output(device, cmd, image_buffer.get());
                }
            }

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;
        }
        drop(sampler);

        invalidate_alloc(device, tensor_buffer.get_allocation())?;
        invalidate_alloc(device, image_buffer.get_allocation())?;
        for (memory, buffer) in [
            (&mut tensor_buffer_memory, &tensor_buffer),
            (&mut image_buffer_memory, &image_buffer),
        ] {
            unsafe {
                std::ptr::copy_nonoverlapping(
                    buffer.get_allocation().get_host_ptr(),
                    memory.data_mut().as_mut_ptr(),
                    buffer_size as usize,
                );
            }
        }

        Ok(compare_strided_memory(&tensor_buffer_memory, &image_buffer_memory))
    }
}

impl TestInstance for TensorImageAliasingTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// The tensor of an aliasing case, destroyed before the memory it is bound to
struct AliasedTensor<'a> {
    device: &'a Device,
    tensor: vk::TensorARM,
}

impl Drop for AliasedTensor<'_> {
    fn drop(&mut self) {
        unsafe { self.device.destroy_tensor_arm(self.tensor, None) };
    }
}

/// `addTensorImageAliasingTests<Format>`
fn add_tensor_image_aliasing_tests(cases: &mut HashMap<String, Box<dyn TestCase>>, format: vk::Format) {
    const EXTENT_1D: vk::Extent3D = vk::Extent3D {
        width: 4093,
        height: 1,
        depth: 1,
    };
    const EXTENT_2D: vk::Extent3D = vk::Extent3D {
        width: 523,
        height: 13,
        depth: 1,
    };
    const EXTENT_3D: vk::Extent3D = vk::Extent3D {
        width: 31,
        height: 17,
        depth: 13,
    };

    let element_size = get_format_size(image_to_tensor_format(format));

    for variant in [
        ImageAliasingVariant::ImageProducerTensorConsumer,
        ImageAliasingVariant::TensorProducerImageConsumer,
        ImageAliasingVariant::TensorProducerImageSample,
    ] {
        // Don't create sampled image test cases for 64-bit components
        if variant == ImageAliasingVariant::TensorProducerImageSample && element_size >= 8 {
            continue;
        }

        let combinations = [
            (vk::ImageTiling::LINEAR, false),
            (vk::ImageTiling::OPTIMAL, false),
            (vk::ImageTiling::OPTIMAL, true),
        ];
        for (image_tiling, test_unified_image_layouts) in combinations {
            for (image_type, image_shape) in [
                (vk::ImageType::_1D, EXTENT_1D),
                (vk::ImageType::_2D, EXTENT_2D),
                (vk::ImageType::_3D, EXTENT_3D),
            ] {
                let mut name = format!(
                    "{}_{}_{}_{}",
                    if image_tiling == vk::ImageTiling::LINEAR {
                        "linear"
                    } else {
                        "optimal"
                    },
                    image_format_short_name(format),
                    image_type_short_name(image_type),
                    variant.name()
                );
                if test_unified_image_layouts {
                    name.push_str("_unified_image_layouts");
                }
                let tensor_parameters = TensorParameters::new(
                    image_to_tensor_format(format),
                    image_tiling_to_tensor_tiling(image_tiling),
                    &image_shape_to_aliased_tensor_shape(image_type, format, image_shape),
                    &[],
                );
                cases.insert(
                    format!("image_aliasing.{name}"),
                    Box::new(TensorImageAliasingTestCase {
                        name,
                        image_tiling,
                        image_type,
                        image_shape,
                        image_format: format,
                        variant,
                        tensor_parameters,
                        test_unified_image_layouts,
                    }),
                );
            }
        }
    }
}

/// `createTensorImageAliasingTests`: the cases keyed by their dotted path (`image_aliasing.<name>`)
pub fn create_image_aliasing_cases() -> HashMap<String, Box<dyn TestCase>> {
    let mut cases = HashMap::new();
    for format in [
        vk::Format::R8_SINT,
        vk::Format::R8_UINT,
        vk::Format::R8G8_SINT,
        vk::Format::R8G8_UINT,
        vk::Format::R8G8B8A8_SINT,
        vk::Format::R8G8B8A8_UINT,
        vk::Format::R16_SINT,
        vk::Format::R16_UINT,
        vk::Format::R16G16_SINT,
        vk::Format::R16G16_UINT,
        vk::Format::R16G16B16A16_SINT,
        vk::Format::R16G16B16A16_UINT,
        vk::Format::R32_SINT,
        vk::Format::R32_UINT,
        vk::Format::R32G32_SINT,
        vk::Format::R32G32_UINT,
        vk::Format::R32G32B32A32_SINT,
        vk::Format::R32G32B32A32_UINT,
        vk::Format::R64_SINT,
        vk::Format::R64_UINT,
    ] {
        add_tensor_image_aliasing_tests(&mut cases, format);
    }
    cases
}
