// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustnessExtsTests.cpp (RobustnessExtsTestInstance)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017-2019 The Khronos Group Inc.
// Copyright (c) 2018-2020 NVIDIA Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The instance runs on a `RobustnessDevice` of its own with the features its case asks for
// (upstream's `SingletonDevice`).

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_1, InstanceV1_1, KhrPushDescriptorExtensionDeviceCommands, KhrRayTracingPipelineExtensionDeviceCommands,
};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
use crate::vk::programs::create_shader_module;
use crate::vk::ray_tracing_util::{create_shader_binding_table, shader_group_sizes};
use crate::vk::ref_util::Unique;
use crate::vkt::context::{RobustnessDevice, RobustnessFeatures};
use crate::vkt::tests::robustness::exts_tests::{
    CaseDef, DIM, Desc, PipelineRobustnessCase, Stage, format_channel_size, format_is_float, format_is_r64,
    format_is_signed_int, format_pixel_size,
};
use crate::vkt::{Context, TestInstance};

/// `Layout`: the descriptor types of the set and the data the buffers and images hold.
pub struct Layout {
    pub binding_types: Vec<vk::DescriptorType>,
    pub ref_data: Vec<u8>,
}

fn pack_f32(data: &mut [u8], index: usize, value: f32) {
    data[index * 4..index * 4 + 4].copy_from_slice(&value.to_le_bytes());
}

fn pack_u32(data: &mut [u8], index: usize, value: u32) {
    data[index * 4..index * 4 + 4].copy_from_slice(&value.to_le_bytes());
}

fn pack_u64(data: &mut [u8], index: usize, value: u64) {
    data[index * 8..index * 8 + 8].copy_from_slice(&value.to_le_bytes());
}

fn f16_bits(value: f32) -> u16 {
    crate::tcu::float::Float16::new(value).bits()
}

/// `generateLayout`
#[expect(clippy::manual_checked_ops, reason = "mirrors upstream's zero check")]
pub fn generate_layout(c: &CaseDef) -> Layout {
    let mut binding_types = vec![vk::DescriptorType::STORAGE_IMAGE];
    if let Some(desc_type) = c.desc.descriptor_type() {
        binding_types.push(desc_type);
    }

    let mut layout = Layout {
        binding_types,
        ref_data: Vec::new(),
    };

    if c.null_descriptor {
        return layout;
    }

    if let Some(scalar) = c.long_vector_scalar {
        // Pack-of-N elements; round bufferLen down so OOB indices land on whole vectors.
        let scalar_bytes = scalar.size_bytes();
        let element_bytes = c.long_vector_components * scalar_bytes;
        let aligned_len = if element_bytes == 0 {
            0
        } else {
            c.buffer_len as u32 / element_bytes * element_bytes
        };
        layout.ref_data.resize(aligned_len as usize, 0);
        let num_scalars = aligned_len / scalar_bytes;
        for i in 0..num_scalars as usize {
            use crate::vkt::tests::robustness::exts_tests::LongVectorScalar;
            match scalar {
                LongVectorScalar::F32 => pack_f32(&mut layout.ref_data, i, 2.0 * i as f32 + 3.0),
                LongVectorScalar::I32 | LongVectorScalar::U32 => pack_u32(&mut layout.ref_data, i, 2 * i as u32 + 3),
                LongVectorScalar::F16 => {
                    layout.ref_data[i * 2..i * 2 + 2].copy_from_slice(&f16_bits(2.0 * i as f32 + 3.0).to_le_bytes())
                }
            }
        }
        return layout;
    }

    if c.buffer_len == 0 {
        // Clear color values for image tests
        const UREF_DATA: [u32; 4] = [0x12345678, 0x23456789, 0x34567890, 0x45678901];
        const UREF_DATA64: [u64; 4] = [0x1234567887654321, 0x234567899, 0x345678909, 0x456789019];
        const FREF_DATA: [f32; 4] = [123.0, 234.0, 345.0, 456.0];

        if format_is_r64(c.format) {
            layout.ref_data.resize(32, 0);
            for (i, v) in UREF_DATA64.iter().enumerate() {
                pack_u64(&mut layout.ref_data, i, *v);
            }
        } else {
            layout.ref_data.resize(16, 0);
            for i in 0..4 {
                if format_is_float(c.format) {
                    pack_f32(&mut layout.ref_data, i, FREF_DATA[i]);
                } else {
                    pack_u32(&mut layout.ref_data, i, UREF_DATA[i]);
                }
            }
        }
    } else {
        let r64 = format_is_r64(c.format);
        let size = (c.buffer_len & if r64 { !7 } else { !3 }) as usize;
        layout.ref_data.resize(size, 0);
        // upstream writes a float for a float format and then, because the following `if` is a separate statement, overwrites it with the integer
        for i in 0..(c.buffer_len as usize / if r64 { 8 } else { 4 }) {
            if r64 {
                if (i + 1) * 8 <= size {
                    pack_u64(&mut layout.ref_data, i, 2 * i as u64 + 3);
                }
            } else if (i + 1) * 4 <= size {
                pack_u32(&mut layout.ref_data, i, 2 * i as u32 + 3);
            }
        }
    }

    layout
}

/// `deIntRoundToPow2`
fn round_to_pow2(value: u64, alignment: u64) -> u64 {
    if alignment == 0 {
        return value;
    }
    (value + alignment - 1) & !(alignment - 1)
}

/// `imageViewTypeToImageType`
fn image_view_type_to_image_type(view_type: vk::ImageViewType) -> vk::ImageType {
    match view_type {
        vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY => vk::ImageType::_1D,
        vk::ImageViewType::_3D => vk::ImageType::_3D,
        _ => vk::ImageType::_2D,
    }
}

/// `getPipelineRobustnessInfo`
fn pipeline_robustness_info(robustness2: bool, desc: Desc) -> vk::PipelineRobustnessCreateInfo {
    let mut info = vk::PipelineRobustnessCreateInfo {
        storage_buffers: vk::PipelineRobustnessBufferBehavior::DISABLED,
        uniform_buffers: vk::PipelineRobustnessBufferBehavior::DISABLED,
        vertex_inputs: vk::PipelineRobustnessBufferBehavior::DISABLED,
        images: vk::PipelineRobustnessImageBehavior::DISABLED,
        ..Default::default()
    };
    let buffer_behavior = if robustness2 {
        vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS_2
    } else {
        vk::PipelineRobustnessBufferBehavior::ROBUST_BUFFER_ACCESS
    };
    let image_behavior = if robustness2 {
        vk::PipelineRobustnessImageBehavior::ROBUST_IMAGE_ACCESS_2
    } else {
        vk::PipelineRobustnessImageBehavior::ROBUST_IMAGE_ACCESS
    };
    match desc {
        Desc::StorageBufferDynamic | Desc::StorageBuffer | Desc::StorageTexelBuffer => {
            info.storage_buffers = buffer_behavior
        }
        Desc::StorageImage | Desc::CombinedImageSampler => info.images = image_behavior,
        Desc::UniformBufferDynamic | Desc::UniformTexelBuffer | Desc::UniformBuffer => {
            info.uniform_buffers = buffer_behavior
        }
        Desc::VertexAttributeFetch => info.vertex_inputs = buffer_behavior,
    }
    info
}

/// `vk::copyBufferToImage` for the layers of one image: UNDEFINED -> TRANSFER_DST, copy, then TRANSFER_DST -> GENERAL for `dst_stage`.
fn copy_buffer_to_image(
    device: &Device,
    cmd: vk::CommandBuffer,
    buffer: vk::Buffer,
    extent: vk::Extent3D,
    layers: u32,
    image: vk::Image,
    dst_stage: vk::PipelineStageFlags,
) {
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layers);
    let pre = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image,
        range,
    );
    let post = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::SHADER_READ,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::ImageLayout::GENERAL,
        image,
        range,
    );
    let region = make_buffer_image_copy(
        extent,
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, layers),
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre],
        );
        device.cmd_copy_buffer_to_image(cmd, buffer, image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &[region]);
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post],
        );
    }
}

fn image_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barrier: vk::ImageMemoryBarrier,
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

fn memory_barrier(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
) {
    let barrier = vk::MemoryBarrier::builder()
        .src_access_mask(src_access)
        .dst_access_mask(dst_access);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[*barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

fn clear_value_first_component_add_one(clear: &mut [u32; 4], format: vk::Format) {
    if format_is_float(format) {
        clear[0] = (f32::from_bits(clear[0]) + 1.0).to_bits();
    } else if format_is_signed_int(format) {
        clear[0] = (clear[0] as i32).wrapping_add(1) as u32;
    } else {
        clear[0] = clear[0].wrapping_add(1);
    }
}

/// `createGraphicsPipeline` of one create info
fn create_graphics_pipeline<'d>(
    device: &'d Device,
    info: &vk::GraphicsPipelineCreateInfo,
) -> Result<Unique<'d, vk::Pipeline>, TestError> {
    let created = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[*info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, created.0[0]))
}

/// The instance of one `robustness2`/`image_robustness`/`pipeline_robustness` case.
pub struct ExtsInstance<'a> {
    context: &'a Context<'a>,
    data: CaseDef,
}

impl<'a> ExtsInstance<'a> {
    pub fn new(context: &'a Context<'a>, data: CaseDef) -> Self {
        Self { context, data }
    }

    /// `getLogicalDevice`
    fn create_logical_device(&self, queue_family_index: u32) -> Result<RobustnessDevice, TestError> {
        let c = &self.data;
        let features = if c.needs_pipeline_robustness() {
            RobustnessFeatures {
                pipeline_robustness: true,
                shader_image_int64_atomics: true,
                ..Default::default()
            }
        } else if c.test_robustness2 {
            RobustnessFeatures {
                robust_buffer_access2: true,
                robust_image_access2: true,
                shader_image_int64_atomics: true,
                ..Default::default()
            }
        } else {
            RobustnessFeatures {
                robust_image_access: true,
                shader_image_int64_atomics: true,
                ..Default::default()
            }
        };
        RobustnessDevice::new(
            self.context.get_instance(),
            self.context.get_physical_device(),
            queue_family_index,
            features,
        )
    }
}

impl TestInstance for ExtsInstance<'_> {
    #[expect(clippy::explicit_counter_loop, reason = "mirrors upstream's counter")]
    fn iterate(&mut self) -> TestOutcome {
        let c = self.data;
        let context = self.context;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let queue_family_index = if c.use_compute_queue {
            context
                .get_compute_queue()
                .map(|(_, family)| family)
                .ok_or_else(|| TestError::NotSupported("Exclusive compute queue not supported.".to_string()))?
        } else {
            context.get_universal_queue_family_index()
        };

        let robust_device = self.create_logical_device(queue_family_index)?;
        let device = robust_device.device();
        let queue = robust_device.queue();
        let allocator = context.get_default_allocator();

        let layout = generate_layout(&c);

        // Get needed properties.
        let mut robustness2_properties = vk::PhysicalDeviceRobustness2PropertiesKHR::default();
        if context.is_device_functionality_supported("VK_KHR_robustness2")
            || context.is_device_functionality_supported("VK_EXT_robustness2")
        {
            let mut properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut robustness2_properties);
            unsafe { instance.get_physical_device_properties2(physical_device, &mut properties) };
        }
        let storage_alignment = robustness2_properties.robust_storage_buffer_access_size_alignment;
        let uniform_alignment = robustness2_properties.robust_uniform_buffer_access_size_alignment;

        if c.test_robustness2 {
            if storage_alignment != 1 && storage_alignment != 4 {
                return Ok(TestStatus::fail(
                    "robustStorageBufferAccessSizeAlignment must be 1 or 4",
                ));
            }

            if !(1..=256).contains(&uniform_alignment) || !uniform_alignment.is_power_of_two() {
                return Ok(TestStatus::fail(
                    "robustUniformBufferAccessSizeAlignment must be a power of two in [1,256]",
                ));
            }
        }

        let bind_point = match c.stage {
            Stage::Compute => vk::PipelineBindPoint::COMPUTE,
            Stage::Raygen => vk::PipelineBindPoint::RAY_TRACING_KHR,
            _ => vk::PipelineBindPoint::GRAPHICS,
        };

        let format_bytes = format_pixel_size(c.format);
        let num_components = (format_bytes / format_channel_size(c.format)) as usize;

        let binding_types = layout.binding_types.clone();
        let all_shader_stages = vk::ShaderStageFlags::ALL;
        let all_pipeline_stages = vk::PipelineStageFlags::ALL_COMMANDS;

        // Create a layout and allocate a descriptor set for it.
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for &binding_type in &binding_types {
            layout_builder = layout_builder.add_single_binding(binding_type, all_shader_stages);
        }
        let layout_flags = if c.push_descriptor {
            vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR
        } else {
            vk::DescriptorSetLayoutCreateFlags::empty()
        };
        let descriptor_set_layout = layout_builder.build_with_flags(device, layout_flags)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, 1)
            .add_type(vk::DescriptorType::UNIFORM_TEXEL_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_TEXEL_BUFFER, 1)
            .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let descriptor_set = if c.push_descriptor {
            None
        } else {
            Some(make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?)
        };

        let mut buffer: Option<BufferWithMemory<'_>> = None;
        let mut buffer_ptr: *mut u8 = std::ptr::null_mut();
        if !c.null_descriptor {
            // Create a buffer to hold data for all descriptors.
            let mut size = u64::from(if c.buffer_len != 0 { c.buffer_len as u32 } else { 1 }).max(256);

            let mut usage = if c.stage == Stage::Compute || c.stage == Stage::Raygen {
                vk::BufferUsageFlags::STORAGE_BUFFER
            } else {
                vk::BufferUsageFlags::VERTEX_BUFFER
            };

            if c.desc.is_ubo() {
                size = round_to_pow2(size, uniform_alignment);
                usage |= vk::BufferUsageFlags::UNIFORM_BUFFER;
            } else if c.desc.is_ssbo() {
                size = round_to_pow2(size, storage_alignment);
                usage |= vk::BufferUsageFlags::STORAGE_BUFFER;
            } else if c.desc == Desc::StorageTexelBuffer {
                usage |= vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER;
            } else if c.desc == Desc::UniformTexelBuffer {
                usage |= vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER;
            } else if c.desc == Desc::VertexAttributeFetch {
                size = c.buffer_len as u64;
            }

            let created = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(size, usage),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            buffer_ptr = created.get_allocation().get_host_ptr();

            unsafe {
                std::ptr::write_bytes(buffer_ptr, 0x3f, size as usize);
                std::ptr::write_bytes(buffer_ptr, 0, c.buffer_len as usize);
                if c.desc.is_ubo() {
                    std::ptr::write_bytes(
                        buffer_ptr,
                        0,
                        round_to_pow2(c.buffer_len as u64, uniform_alignment) as usize,
                    );
                } else if c.desc.is_ssbo() {
                    std::ptr::write_bytes(
                        buffer_ptr,
                        0,
                        round_to_pow2(c.buffer_len as u64, storage_alignment) as usize,
                    );
                }
            }
            buffer = Some(created);
        }

        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        let barrier_range = make_image_subresource_range(
            vk::ImageAspectFlags::COLOR,
            0,
            vk::REMAINING_MIP_LEVELS,
            0,
            vk::REMAINING_ARRAY_LAYERS,
        );
        let pre_image_barrier = |image: vk::Image| {
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image,
                barrier_range,
            )
        };
        let post_image_barrier = |image: vk::Image| {
            make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::SHADER_READ,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                vk::ImageLayout::GENERAL,
                image,
                barrier_range,
            )
        };

        let mut clear_value = [0u32; 4];

        begin_command_buffer(device, cmd)?;

        let mut buffer_views: Vec<Unique<'_, vk::BufferView>> = Vec::new();

        // The 64-bit image tests use a view format which differs from the image.
        let mutable_format_flag = if format_is_r64(c.format) {
            vk::ImageCreateFlags::MUTABLE_FORMAT
        } else {
            vk::ImageCreateFlags::empty()
        };
        let mut image_create_flags = mutable_format_flag;
        if c.view_type == vk::ImageViewType::CUBE || c.view_type == vk::ImageViewType::CUBE_ARRAY {
            image_create_flags |= vk::ImageCreateFlags::CUBE_COMPATIBLE;
        }

        let feature_sampled_image =
            unsafe { instance.get_physical_device_format_properties(physical_device, c.format) }
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::SAMPLED_IMAGE);
        let usage_sampled_image = if feature_sampled_image {
            vk::ImageUsageFlags::SAMPLED
        } else {
            vk::ImageUsageFlags::empty()
        };

        let output_image_create_info = vk::ImageCreateInfo::builder()
            .flags(mutable_format_flag)
            .image_type(vk::ImageType::_2D)
            .format(c.format)
            .extent(vk::Extent3D {
                width: DIM,
                height: DIM,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::STORAGE
                    | usage_sampled_image
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        let width = c.image_dim[0];
        let height = if c.view_type != vk::ImageViewType::_1D && c.view_type != vk::ImageViewType::_1D_ARRAY {
            c.image_dim[1]
        } else {
            1
        };
        let depth = if c.view_type == vk::ImageViewType::_3D {
            c.image_dim[2]
        } else {
            1
        };
        let layers = if c.view_type == vk::ImageViewType::_1D_ARRAY {
            c.image_dim[1]
        } else if c.view_type != vk::ImageViewType::_1D
            && c.view_type != vk::ImageViewType::_2D
            && c.view_type != vk::ImageViewType::_3D
        {
            c.image_dim[2]
        } else {
            1
        };

        let usage_image = if c.desc == Desc::StorageImage {
            vk::ImageUsageFlags::STORAGE
        } else {
            vk::ImageUsageFlags::empty()
        };

        let image_create_info = vk::ImageCreateInfo::builder()
            .flags(image_create_flags)
            .image_type(image_view_type_to_image_type(c.view_type))
            .format(c.format)
            .extent(vk::Extent3D { width, height, depth })
            .mip_levels(1)
            .array_layers(layers)
            .samples(c.samples)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                usage_image
                    | usage_sampled_image
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        let mut view_format = c.format;
        let mut images: Vec<Option<ImageWithMemory<'_>>> = vec![None, None];
        let mut image_views: Vec<Option<Unique<'_, vk::ImageView>>> = vec![None, None];

        if c.desc == Desc::VertexAttributeFetch {
            let buffer_ptr = buffer_ptr;
            unsafe { std::ptr::copy_nonoverlapping(layout.ref_data.as_ptr(), buffer_ptr, layout.ref_data.len()) };
        }

        let mut buffer_image_r64: Option<BufferWithMemory<'_>> = None;
        let mut buffer_output_image_r64: Option<BufferWithMemory<'_>> = None;
        let size_output_r64 = 8
            * u64::from(output_image_create_info.extent.width)
            * u64::from(output_image_create_info.extent.height)
            * u64::from(output_image_create_info.extent.depth);
        let size_one_layer = 8
            * u64::from(image_create_info.extent.width)
            * u64::from(image_create_info.extent.height)
            * u64::from(image_create_info.extent.depth);
        let size_image_r64 = size_one_layer * u64::from(layers);

        if format_is_r64(c.format) {
            let output = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(size_output_r64, vk::BufferUsageFlags::TRANSFER_SRC),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe { std::ptr::write_bytes(output.get_allocation().get_host_ptr(), 0, size_output_r64 as usize) };
            flush_alloc(device, output.get_allocation())?;
            buffer_output_image_r64 = Some(output);

            let image_buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    size_image_r64,
                    vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::STORAGE_BUFFER,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let is_cube = c.view_type == vk::ImageViewType::CUBE || c.view_type == vk::ImageViewType::CUBE_ARRAY;
            for layer in 0..layers {
                let base = unsafe {
                    image_buffer
                        .get_allocation()
                        .get_host_ptr()
                        .add((size_one_layer * u64::from(layer)) as usize)
                }
                .cast::<u64>();
                for ndx in 0..(size_one_layer / 8) as usize {
                    unsafe {
                        base.add(ndx)
                            .write_unaligned(0x1234567887654321 + if is_cube { 0 } else { u64::from(layer) })
                    };
                }
            }
            flush_alloc(device, image_buffer.get_allocation())?;
            buffer_image_r64 = Some(image_buffer);
        }

        // The objects of the 64-bit multisample fill, which have to outlive the command buffer's execution
        let mut r64_fill_layout: Option<Unique<'_, vk::DescriptorSetLayout>> = None;
        let mut r64_fill_pool: Option<Unique<'_, vk::DescriptorPool>> = None;
        let mut r64_fill_set = None;
        let mut r64_fill_module: Option<Unique<'_, vk::ShaderModule>> = None;
        let mut r64_fill_pipeline_layout: Option<Unique<'_, vk::PipelineLayout>> = None;
        let mut r64_fill_pipeline: Option<Unique<'_, vk::Pipeline>> = None;

        for (b, &binding_type) in binding_types.iter().enumerate() {
            if b == 1 && c.null_descriptor {
                continue;
            }

            match binding_type {
                vk::DescriptorType::UNIFORM_BUFFER
                | vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC
                | vk::DescriptorType::STORAGE_BUFFER
                | vk::DescriptorType::STORAGE_BUFFER_DYNAMIC => {
                    unsafe {
                        std::ptr::copy_nonoverlapping(layout.ref_data.as_ptr(), buffer_ptr, layout.ref_data.len())
                    };
                }
                vk::DescriptorType::UNIFORM_TEXEL_BUFFER | vk::DescriptorType::STORAGE_TEXEL_BUFFER => {
                    unsafe {
                        std::ptr::copy_nonoverlapping(layout.ref_data.as_ptr(), buffer_ptr, layout.ref_data.len())
                    };

                    let view_info = vk::BufferViewCreateInfo::builder()
                        .buffer(buffer.as_ref().expect("buffer").get())
                        .format(c.format)
                        .offset(0)
                        .range(c.buffer_len as u64);
                    let buffer_view =
                        unsafe { device.create_buffer_view(&view_info, None) }.vk_check("vkCreateBufferView")?;
                    buffer_views.push(Unique::new(device, buffer_view));
                }
                _ => {
                    // vk::DescriptorType::STORAGE_IMAGE | COMBINED_IMAGE_SAMPLER
                    if binding_types.len() > 1 && binding_types[1] == vk::DescriptorType::COMBINED_IMAGE_SAMPLER {
                        if c.format == vk::Format::R64_SINT {
                            view_format = vk::Format::R32G32_SINT;
                        }
                        if c.format == vk::Format::R64_UINT {
                            view_format = vk::Format::R32G32_UINT;
                        }
                    }

                    {
                        let img_create_info = if b == 0 {
                            &output_image_create_info
                        } else {
                            &image_create_info
                        };
                        let result = unsafe {
                            instance.get_physical_device_image_format_properties(
                                physical_device,
                                img_create_info.format,
                                img_create_info.image_type,
                                img_create_info.tiling,
                                img_create_info.usage,
                                img_create_info.flags,
                            )
                        };

                        if let Err(error) = result {
                            if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED {
                                return Err(TestError::NotSupported(format!(
                                    "format {:?} does not support the required features",
                                    c.format
                                )));
                            }
                            return Ok(TestStatus::fail(
                                "vkGetPhysicalDeviceImageFormatProperties returned unexpected error",
                            ));
                        }
                    }

                    let view_type = if b == 0 {
                        images[b] = Some(ImageWithMemory::new(
                            device,
                            allocator,
                            output_image_create_info,
                            MemoryRequirement::ANY,
                        )?);
                        vk::ImageViewType::_2D
                    } else {
                        images[b] = Some(ImageWithMemory::new(
                            device,
                            allocator,
                            image_create_info,
                            MemoryRequirement::ANY,
                        )?);
                        c.view_type
                    };
                    let image = images[b].as_ref().expect("image").get();
                    let view_info = vk::ImageViewCreateInfo::builder()
                        .image(image)
                        .view_type(view_type)
                        .format(view_format)
                        .components(vk::ComponentMapping::default())
                        .subresource_range(barrier_range);
                    let view = unsafe { device.create_image_view(&view_info, None) }.vk_check("vkCreateImageView")?;
                    image_views[b] = Some(Unique::new(device, view));

                    let image_info = if b == 0 {
                        &output_image_create_info
                    } else {
                        &image_create_info
                    };
                    let clear_layers = if b == 0 { 1 } else { layers };

                    if !format_is_r64(c.format) {
                        if b == 1 {
                            for (i, chunk) in layout.ref_data.chunks(4).take(4).enumerate() {
                                let mut word = [0u8; 4];
                                word[..chunk.len()].copy_from_slice(chunk);
                                clear_value[i] = u32::from_le_bytes(word);
                            }
                        }

                        image_barrier(
                            device,
                            cmd,
                            vk::PipelineStageFlags::BOTTOM_OF_PIPE,
                            vk::PipelineStageFlags::TRANSFER,
                            pre_image_barrier(image),
                        );

                        for i in 0..clear_layers {
                            let clear_range = make_image_subresource_range(
                                vk::ImageAspectFlags::COLOR,
                                0,
                                vk::REMAINING_MIP_LEVELS,
                                i,
                                1,
                            );
                            let clear_color = vk::ClearColorValue { uint32: clear_value };
                            unsafe {
                                device.cmd_clear_color_image(
                                    cmd,
                                    image,
                                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                                    &clear_color,
                                    &[clear_range],
                                )
                            };

                            // Use same data for all faces for cube(array), otherwise make value a function of the layer
                            if c.view_type != vk::ImageViewType::CUBE && c.view_type != vk::ImageViewType::CUBE_ARRAY {
                                clear_value_first_component_add_one(&mut clear_value, c.format);
                            }
                        }
                        image_barrier(
                            device,
                            cmd,
                            vk::PipelineStageFlags::TRANSFER,
                            all_pipeline_stages,
                            post_image_barrier(image),
                        );
                    } else if c.samples != vk::SampleCountFlags::_1 && b == 1 {
                        let buffer_r64 = buffer_image_r64.as_ref().expect("r64 buffer").get();
                        let subresource_range =
                            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, clear_layers);
                        let image_barrier_pre = make_image_memory_barrier(
                            vk::AccessFlags::empty(),
                            vk::AccessFlags::SHADER_WRITE,
                            vk::ImageLayout::UNDEFINED,
                            vk::ImageLayout::GENERAL,
                            image,
                            subresource_range,
                        );
                        let image_barrier_post = make_image_memory_barrier(
                            vk::AccessFlags::SHADER_WRITE,
                            vk::AccessFlags::SHADER_READ,
                            vk::ImageLayout::GENERAL,
                            vk::ImageLayout::GENERAL,
                            image,
                            subresource_range,
                        );

                        let fill_layout = DescriptorSetLayoutBuilder::new()
                            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
                            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                            .build(device)?;
                        let fill_pool = DescriptorPoolBuilder::new()
                            .add_type(vk::DescriptorType::STORAGE_IMAGE, 1)
                            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
                            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
                        let fill_set = make_descriptor_set(device, *fill_pool, *fill_layout)?;

                        let binaries = context.get_binary_collection();
                        let fill_module = create_shader_module(device, binaries.get("fillShader")?)?;
                        let fill_set_layouts = [*fill_layout];
                        let fill_pipeline_layout_info =
                            vk::PipelineLayoutCreateInfo::builder().set_layouts(&fill_set_layouts);
                        let fill_pipeline_layout = Unique::new(
                            device,
                            unsafe { device.create_pipeline_layout(&fill_pipeline_layout_info, None) }
                                .vk_check("vkCreatePipelineLayout")?,
                        );
                        let fill_stage = vk::PipelineShaderStageCreateInfo::builder()
                            .stage(vk::ShaderStageFlags::COMPUTE)
                            .module(*fill_module)
                            .name(b"main\0");
                        let fill_pipeline_info = vk::ComputePipelineCreateInfo::builder()
                            .stage(*fill_stage)
                            .layout(*fill_pipeline_layout)
                            .base_pipeline_index(0);
                        let fill_pipeline = Unique::new(
                            device,
                            unsafe {
                                device.create_compute_pipelines(vk::PipelineCache::null(), &[fill_pipeline_info], None)
                            }
                            .vk_check("vkCreateComputePipelines")?
                            .0[0],
                        );

                        let result_image_info = [vk::DescriptorImageInfo {
                            sampler: vk::Sampler::null(),
                            image_view: image_views[b].as_ref().expect("view").get(),
                            image_layout: vk::ImageLayout::GENERAL,
                        }];
                        let result_buffer_info = [make_descriptor_buffer_info(buffer_r64, 0, size_image_r64)];
                        let writes = [
                            vk::WriteDescriptorSet::builder()
                                .dst_set(fill_set.get())
                                .dst_binding(0)
                                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                                .image_info(&result_image_info)
                                .build(),
                            vk::WriteDescriptorSet::builder()
                                .dst_set(fill_set.get())
                                .dst_binding(1)
                                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                                .buffer_info(&result_buffer_info)
                                .build(),
                        ];
                        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

                        image_barrier(
                            device,
                            cmd,
                            vk::PipelineStageFlags::HOST,
                            vk::PipelineStageFlags::COMPUTE_SHADER,
                            image_barrier_pre,
                        );

                        unsafe {
                            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *fill_pipeline);
                            device.cmd_bind_descriptor_sets(
                                cmd,
                                vk::PipelineBindPoint::COMPUTE,
                                *fill_pipeline_layout,
                                0,
                                &[fill_set.get()],
                                &[],
                            );
                            device.cmd_dispatch(cmd, image_info.extent.width, image_info.extent.height, clear_layers);
                        }

                        image_barrier(
                            device,
                            cmd,
                            vk::PipelineStageFlags::COMPUTE_SHADER,
                            all_pipeline_stages,
                            image_barrier_post,
                        );

                        // Declared in this order so the set is dropped before its pool and the pool before its layout
                        r64_fill_layout = Some(fill_layout);
                        r64_fill_pool = Some(fill_pool);
                        r64_fill_set = Some(fill_set);
                        r64_fill_module = Some(fill_module);
                        r64_fill_pipeline_layout = Some(fill_pipeline_layout);
                        r64_fill_pipeline = Some(fill_pipeline);
                    } else {
                        let buffer_r64 = if b == 0 {
                            buffer_output_image_r64.as_ref()
                        } else {
                            buffer_image_r64.as_ref()
                        }
                        .expect("r64 buffer")
                        .get();
                        copy_buffer_to_image(
                            device,
                            cmd,
                            buffer_r64,
                            image_info.extent,
                            clear_layers,
                            image,
                            all_pipeline_stages,
                        );
                    }
                }
            }
        }

        let sampler_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::ALWAYS)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(if format_is_float(c.format) {
                vk::BorderColor::FLOAT_TRANSPARENT_BLACK
            } else {
                vk::BorderColor::INT_TRANSPARENT_BLACK
            })
            .unnormalized_coordinates(false);
        let sampler = Unique::new(
            device,
            unsafe { device.create_sampler(&sampler_info, None) }.vk_check("vkCreateSampler")?,
        );

        // Flush modified memory.
        if let Some(buffer) = &buffer {
            flush_alloc(device, buffer.get_allocation())?;
        }

        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let copy_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(u64::from(DIM * DIM * 16), vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        {
            let mut buffer_infos = [vk::DescriptorBufferInfo::default(); 2];
            let mut image_infos = [vk::DescriptorImageInfo::default(); 2];
            let mut buffer_view_handles = [vk::BufferView::null(); 2];
            let mut writes_before_bind: Vec<vk::WriteDescriptorSet> = Vec::new();
            let mut vec_index = 0usize;
            let mut num_dynamic = 0usize;

            let mut img_template_entries: Vec<vk::DescriptorUpdateTemplateEntry> = Vec::new();
            let mut buf_template_entries: Vec<vk::DescriptorUpdateTemplateEntry> = Vec::new();
            let mut texel_buf_template_entries: Vec<vk::DescriptorUpdateTemplateEntry> = Vec::new();

            for (b, &binding_type) in binding_types.iter().enumerate() {
                // Construct the declaration for the binding
                match binding_type {
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER | vk::DescriptorType::STORAGE_IMAGE => {
                        // Output image.
                        image_infos[vec_index] = if b == 1 && c.null_descriptor {
                            vk::DescriptorImageInfo {
                                sampler: sampler.get(),
                                image_view: vk::ImageView::null(),
                                image_layout: vk::ImageLayout::GENERAL,
                            }
                        } else {
                            vk::DescriptorImageInfo {
                                sampler: sampler.get(),
                                image_view: image_views[b].as_ref().expect("view").get(),
                                image_layout: vk::ImageLayout::GENERAL,
                            }
                        };
                    }
                    vk::DescriptorType::UNIFORM_TEXEL_BUFFER | vk::DescriptorType::STORAGE_TEXEL_BUFFER => {
                        buffer_view_handles[vec_index] = if b == 1 && c.null_descriptor {
                            vk::BufferView::null()
                        } else {
                            buffer_views[0].get()
                        };
                    }
                    _ => {
                        // Other descriptor types.
                        buffer_infos[vec_index] = if b == 1 && c.null_descriptor {
                            make_descriptor_buffer_info(vk::Buffer::null(), 0, vk::WHOLE_SIZE)
                        } else {
                            make_descriptor_buffer_info(
                                buffer.as_ref().expect("buffer").get(),
                                0,
                                layout.ref_data.len() as u64,
                            )
                        };
                    }
                }

                let write = vk::WriteDescriptorSet {
                    s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                    next: std::ptr::null(),
                    dst_set: if c.push_descriptor {
                        vk::DescriptorSet::null()
                    } else {
                        descriptor_set.as_ref().expect("set").get()
                    },
                    dst_binding: b as u32,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: binding_type,
                    image_info: &raw const image_infos[vec_index],
                    buffer_info: &raw const buffer_infos[vec_index],
                    texel_buffer_view: &raw const buffer_view_handles[vec_index],
                };

                let mut template_entry = vk::DescriptorUpdateTemplateEntry {
                    dst_binding: b as u32,
                    dst_array_element: 0,
                    descriptor_count: 1,
                    descriptor_type: binding_type,
                    offset: 0,
                    stride: 0,
                };

                match binding_type {
                    vk::DescriptorType::COMBINED_IMAGE_SAMPLER | vk::DescriptorType::STORAGE_IMAGE => {
                        template_entry.offset = vec_index * std::mem::size_of::<vk::DescriptorImageInfo>();
                        img_template_entries.push(template_entry);
                    }
                    vk::DescriptorType::UNIFORM_TEXEL_BUFFER | vk::DescriptorType::STORAGE_TEXEL_BUFFER => {
                        template_entry.offset = vec_index * std::mem::size_of::<vk::BufferView>();
                        texel_buf_template_entries.push(template_entry);
                    }
                    _ => {
                        template_entry.offset = vec_index * std::mem::size_of::<vk::DescriptorBufferInfo>();
                        buf_template_entries.push(template_entry);
                    }
                }

                vec_index += 1;

                writes_before_bind.push(write);

                // Count the number of dynamic descriptors in this set.
                if binding_type == vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC
                    || binding_type == vk::DescriptorType::STORAGE_BUFFER_DYNAMIC
                {
                    num_dynamic += 1;
                }
            }

            // Make zeros have at least one element so &zeros[0] works
            let zeros = vec![0u32; num_dynamic.max(1)];
            let dynamic_offsets = &zeros[..num_dynamic];

            // Randomly select between vkUpdateDescriptorSets and vkUpdateDescriptorSetWithTemplate
            if c.use_template {
                let template_type = if c.push_descriptor {
                    vk::DescriptorUpdateTemplateType::PUSH_DESCRIPTORS
                } else {
                    vk::DescriptorUpdateTemplateType::DESCRIPTOR_SET
                };
                let template_data: [*const c_void; 3] = [
                    image_infos.as_ptr().cast(),
                    buffer_infos.as_ptr().cast(),
                    buffer_view_handles.as_ptr().cast(),
                ];
                let template_vectors = [
                    &img_template_entries,
                    &buf_template_entries,
                    &texel_buf_template_entries,
                ];

                for (entries, data) in template_vectors.into_iter().zip(template_data) {
                    if entries.is_empty() {
                        continue;
                    }
                    let mut template_info = vk::DescriptorUpdateTemplateCreateInfo::builder()
                        .descriptor_update_entries(entries)
                        .template_type(template_type)
                        .descriptor_set_layout(*descriptor_set_layout)
                        .pipeline_bind_point(bind_point);
                    template_info = template_info.pipeline_layout(*pipeline_layout).set(0);
                    let template = unsafe { device.create_descriptor_update_template(&template_info, None) }
                        .vk_check("vkCreateDescriptorUpdateTemplate")?;
                    unsafe {
                        if c.push_descriptor {
                            device.cmd_push_descriptor_set_with_template_khr(cmd, template, *pipeline_layout, 0, data);
                        } else {
                            device.update_descriptor_set_with_template(
                                descriptor_set.as_ref().expect("set").get(),
                                template,
                                data,
                            );
                        }
                        device.destroy_descriptor_update_template(template, None);
                    }
                }

                if !c.push_descriptor {
                    unsafe {
                        device.cmd_bind_descriptor_sets(
                            cmd,
                            bind_point,
                            *pipeline_layout,
                            0,
                            &[descriptor_set.as_ref().expect("set").get()],
                            dynamic_offsets,
                        )
                    };
                }
            } else if c.push_descriptor {
                if !writes_before_bind.is_empty() {
                    unsafe {
                        device.cmd_push_descriptor_set_khr(cmd, bind_point, *pipeline_layout, 0, &writes_before_bind)
                    };
                }
            } else {
                if !writes_before_bind.is_empty() {
                    unsafe { device.update_descriptor_sets(&writes_before_bind, &[] as &[vk::CopyDescriptorSet]) };
                }

                unsafe {
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        bind_point,
                        *pipeline_layout,
                        0,
                        &[descriptor_set.as_ref().expect("set").get()],
                        dynamic_offsets,
                    )
                };
            }
        }

        // Pipelines and what keeps them alive
        let binaries = context.get_binary_collection();
        let mut pipelines: Vec<Unique<'_, vk::Pipeline>> = Vec::new();
        let mut shader_modules: Vec<Unique<'_, vk::ShaderModule>> = Vec::new();
        let mut rgen_sbt: Option<BufferWithMemory<'_>> = None;
        let mut rgen_region = vk::StridedDeviceAddressRegionKHR::default();
        let mut render_pass: Option<Unique<'_, vk::RenderPass>> = None;
        let mut framebuffer: Option<Unique<'_, vk::Framebuffer>> = None;

        let mut pipeline_flags2 = vk::PipelineCreateFlags2CreateInfo {
            flags: vk::PipelineCreateFlags2::_64_BIT_INDEXING_EXT,
            ..Default::default()
        };
        let base_next: *const c_void = if c.uses_64bit_indexing {
            (&raw mut pipeline_flags2).cast()
        } else {
            std::ptr::null()
        };

        if c.stage == Stage::Compute {
            let shader = create_shader_module(device, binaries.get("test")?)?;
            let stage_info = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(*shader)
                .name(b"main\0");

            let mut robustness_info = pipeline_robustness_info(c.test_robustness2, c.desc);
            let mut next = base_next;
            if c.needs_pipeline_robustness() {
                robustness_info.next = next;
                next = (&raw const robustness_info).cast();
            }
            let create_info = vk::ComputePipelineCreateInfo {
                s_type: vk::StructureType::COMPUTE_PIPELINE_CREATE_INFO,
                next,
                flags: vk::PipelineCreateFlags::empty(),
                stage: *stage_info,
                layout: *pipeline_layout,
                base_pipeline_handle: vk::Pipeline::null(),
                base_pipeline_index: 0,
            };
            let created = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[create_info], None) }
                .vk_check("vkCreateComputePipelines")?;
            pipelines.push(Unique::new(device, created.0[0]));
            shader_modules.push(shader);
        } else if c.stage == Stage::Raygen {
            let shader = create_shader_module(device, binaries.get("test")?)?;
            let stage_info = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::RAYGEN_KHR)
                .module(*shader)
                .name(b"main\0");
            let group = vk::RayTracingShaderGroupCreateInfoKHR {
                type_: vk::RayTracingShaderGroupTypeKHR::GENERAL,
                general_shader: 0,
                closest_hit_shader: vk::SHADER_UNUSED_KHR,
                any_hit_shader: vk::SHADER_UNUSED_KHR,
                intersection_shader: vk::SHADER_UNUSED_KHR,
                ..Default::default()
            };

            let mut robustness_info = pipeline_robustness_info(c.test_robustness2, c.desc);
            let mut next = base_next;
            if c.needs_pipeline_robustness() {
                robustness_info.next = next;
                next = (&raw const robustness_info).cast();
            }
            let stages = [*stage_info];
            let groups = [group];
            let create_info = vk::RayTracingPipelineCreateInfoKHR {
                next,
                stage_count: 1,
                stages: stages.as_ptr(),
                group_count: 1,
                groups: groups.as_ptr(),
                max_pipeline_ray_recursion_depth: 0,
                layout: *pipeline_layout,
                base_pipeline_handle: vk::Pipeline::null(),
                base_pipeline_index: 0,
                ..Default::default()
            };
            let created = unsafe {
                device.create_ray_tracing_pipelines_khr(
                    vk::DeferredOperationKHR::null(),
                    vk::PipelineCache::null(),
                    &[create_info],
                    None,
                )
            }
            .vk_check("vkCreateRayTracingPipelinesKHR")?;
            pipelines.push(Unique::new(device, created.0[0]));
            shader_modules.push(shader);

            let (handle_size, base_alignment) = shader_group_sizes(instance, physical_device);
            let (sbt, region) =
                create_shader_binding_table(device, allocator, pipelines[0].get(), handle_size, base_alignment, 0, 1)?;
            rgen_sbt = Some(sbt);
            rgen_region = region;
        } else {
            let subpass_desc = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
            let write_stage = if c.stage == Stage::Vertex {
                vk::PipelineStageFlags::VERTEX_SHADER
            } else {
                vk::PipelineStageFlags::FRAGMENT_SHADER
            };
            let subpass_dependencies = [
                vk::SubpassDependency {
                    src_subpass: vk::SUBPASS_EXTERNAL,
                    dst_subpass: 0,
                    src_stage_mask: vk::PipelineStageFlags::TRANSFER,
                    dst_stage_mask: vk::PipelineStageFlags::FRAGMENT_SHADER,
                    src_access_mask: vk::AccessFlags::TRANSFER_WRITE,
                    dst_access_mask: vk::AccessFlags::INPUT_ATTACHMENT_READ | vk::AccessFlags::SHADER_READ,
                    dependency_flags: vk::DependencyFlags::BY_REGION,
                },
                vk::SubpassDependency {
                    src_subpass: 0,
                    dst_subpass: 0,
                    src_stage_mask: vk::PipelineStageFlags::VERTEX_INPUT,
                    dst_stage_mask: write_stage,
                    src_access_mask: vk::AccessFlags::VERTEX_ATTRIBUTE_READ,
                    dst_access_mask: vk::AccessFlags::SHADER_WRITE,
                    dependency_flags: vk::DependencyFlags::empty(),
                },
            ];
            let subpasses = [*subpass_desc];
            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .subpasses(&subpasses)
                .dependencies(&subpass_dependencies);
            let created_render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );

            let framebuffer_info = vk::FramebufferCreateInfo::builder()
                .render_pass(*created_render_pass)
                .width(DIM)
                .height(DIM)
                .layers(1);
            framebuffer = Some(Unique::new(
                device,
                unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
            ));

            let binding_description = vk::VertexInputBindingDescription {
                binding: 0,
                stride: format_bytes,
                input_rate: vk::VertexInputRate::VERTEX,
            };
            let attribute_description = vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: c.format,
                offset: 0,
            };
            let num_attribs = u32::from(c.desc == Desc::VertexAttributeFetch);

            let vertex_input_state = vk::PipelineVertexInputStateCreateInfo {
                s_type: vk::StructureType::PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::PipelineVertexInputStateCreateFlags::empty(),
                vertex_binding_description_count: num_attribs,
                vertex_binding_descriptions: &raw const binding_description,
                vertex_attribute_description_count: num_attribs,
                vertex_attribute_descriptions: &raw const attribute_description,
            };

            let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
                .topology(if c.stage == Stage::Vertex {
                    vk::PrimitiveTopology::POINT_LIST
                } else {
                    vk::PrimitiveTopology::TRIANGLE_STRIP
                })
                .primitive_restart_enable(false);

            let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
                .depth_clamp_enable(false)
                .rasterizer_discard_enable(c.stage == Stage::Vertex)
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(vk::CullModeFlags::NONE)
                .front_face(vk::FrontFace::CLOCKWISE)
                .depth_bias_enable(false)
                .line_width(1.0);

            let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
                .rasterization_samples(vk::SampleCountFlags::_1)
                .sample_shading_enable(false)
                .min_sample_shading(1.0);

            let viewports = [vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: DIM as f32,
                height: DIM as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            }];
            let scissors = [vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: DIM,
                    height: DIM,
                },
            }];
            let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                .viewports(&viewports)
                .scissors(&scissors);

            let (vs, fs, num_stages);
            if c.stage == Stage::Vertex {
                vs = create_shader_module(device, binaries.get("test")?)?;
                fs = create_shader_module(device, binaries.get("test")?)?; // bogus
                num_stages = 1u32;
            } else {
                vs = create_shader_module(device, binaries.get("vert")?)?;
                fs = create_shader_module(device, binaries.get("test")?)?;
                num_stages = 2u32;
            }

            let mut shader_create_info = [
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::VERTEX)
                    .module(*vs)
                    .name(b"main\0")
                    .build(),
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(*fs)
                    .name(b"main\0")
                    .build(),
            ];

            let robustness_info = pipeline_robustness_info(c.test_robustness2, c.desc);
            let mut monolithic_next = base_next;
            if c.needs_pipeline_robustness() && c.pipeline_robustness_case == PipelineRobustnessCase::EnabledMonolithic
            {
                // would need to handle the pNext chain
                debug_assert!(!c.uses_64bit_indexing);
                if c.desc == Desc::VertexAttributeFetch {
                    monolithic_next = (&raw const robustness_info).cast();
                } else if c.stage == Stage::Vertex {
                    shader_create_info[0].next = (&raw const robustness_info).cast();
                } else {
                    shader_create_info[1].next = (&raw const robustness_info).cast();
                }
            }

            // Base structure with everything for the monolithic case.
            let graphics_pipeline_info = vk::GraphicsPipelineCreateInfo {
                s_type: vk::StructureType::GRAPHICS_PIPELINE_CREATE_INFO,
                next: monolithic_next,
                flags: vk::PipelineCreateFlags::empty(),
                stage_count: num_stages,
                stages: shader_create_info.as_ptr(),
                vertex_input_state: &raw const vertex_input_state,
                input_assembly_state: &raw const *input_assembly_state,
                tessellation_state: std::ptr::null(),
                viewport_state: &raw const *viewport_state,
                rasterization_state: &raw const *rasterization_state,
                multisample_state: &raw const *multisample_state,
                depth_stencil_state: std::ptr::null(),
                color_blend_state: std::ptr::null(),
                dynamic_state: std::ptr::null(),
                layout: *pipeline_layout,
                render_pass: *created_render_pass,
                subpass: 0,
                base_pipeline_handle: vk::Pipeline::null(),
                base_pipeline_index: 0,
            };

            let mut linked: Option<Unique<'_, vk::Pipeline>> = None;
            if c.needs_pipeline_robustness() && c.pipeline_robustness_case != PipelineRobustnessCase::EnabledMonolithic
            {
                // Fast or Optimized graphics pipeline libraries.
                let mut library_creation_flags = vk::PipelineCreateFlags::LIBRARY_KHR;
                let mut link_flags = vk::PipelineCreateFlags::empty();

                if c.pipeline_robustness_case == PipelineRobustnessCase::EnabledOptimizedGpl {
                    library_creation_flags |= vk::PipelineCreateFlags::RETAIN_LINK_TIME_OPTIMIZATION_INFO_EXT;
                    link_flags |= vk::PipelineCreateFlags::LINK_TIME_OPTIMIZATION_EXT;
                }

                let mut libraries: Vec<Unique<'_, vk::Pipeline>> = Vec::new();

                // Vertex input state library. When testing the robust vertex shaders, this will be merged with it in the same library.
                if c.stage != Stage::Vertex || c.desc == Desc::VertexAttributeFetch {
                    let mut vertex_input_lib_info = vk::GraphicsPipelineLibraryCreateInfoEXT {
                        flags: vk::GraphicsPipelineLibraryFlagsEXT::VERTEX_INPUT_INTERFACE,
                        ..Default::default()
                    };
                    if c.desc == Desc::VertexAttributeFetch {
                        vertex_input_lib_info.next = (&raw const robustness_info).cast();
                    }
                    let vertex_input_pipeline_info = vk::GraphicsPipelineCreateInfo {
                        next: (&raw const vertex_input_lib_info).cast(),
                        flags: library_creation_flags,
                        vertex_input_state: graphics_pipeline_info.vertex_input_state,
                        input_assembly_state: graphics_pipeline_info.input_assembly_state,
                        ..Default::default()
                    };
                    libraries.push(create_graphics_pipeline(device, &vertex_input_pipeline_info)?);
                }

                // Pre-rasterization shader state library.
                {
                    let mut pre_raster_lib_info = vk::GraphicsPipelineLibraryCreateInfoEXT {
                        flags: vk::GraphicsPipelineLibraryFlagsEXT::PRE_RASTERIZATION_SHADERS,
                        ..Default::default()
                    };
                    let mut vertex_stage_info = shader_create_info[0];
                    let mut pre_raster_pipeline_info = vk::GraphicsPipelineCreateInfo {
                        flags: library_creation_flags,
                        layout: graphics_pipeline_info.layout,
                        viewport_state: graphics_pipeline_info.viewport_state,
                        rasterization_state: graphics_pipeline_info.rasterization_state,
                        tessellation_state: graphics_pipeline_info.tessellation_state,
                        render_pass: graphics_pipeline_info.render_pass,
                        subpass: graphics_pipeline_info.subpass,
                        ..Default::default()
                    };
                    if c.stage == Stage::Vertex && c.desc != Desc::VertexAttributeFetch {
                        pre_raster_pipeline_info.vertex_input_state = graphics_pipeline_info.vertex_input_state;
                        pre_raster_pipeline_info.input_assembly_state = graphics_pipeline_info.input_assembly_state;
                        pre_raster_lib_info.flags |= vk::GraphicsPipelineLibraryFlagsEXT::VERTEX_INPUT_INTERFACE;
                        vertex_stage_info.next = (&raw const robustness_info).cast();
                    }
                    pre_raster_pipeline_info.next = (&raw const pre_raster_lib_info).cast();
                    pre_raster_pipeline_info.stage_count = 1;
                    pre_raster_pipeline_info.stages = &raw const vertex_stage_info;
                    libraries.push(create_graphics_pipeline(device, &pre_raster_pipeline_info)?);
                }

                // Fragment shader stage library.
                {
                    let frag_shader_lib_info = vk::GraphicsPipelineLibraryCreateInfoEXT {
                        flags: vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_SHADER,
                        ..Default::default()
                    };
                    let mut fragment_stages: Vec<vk::PipelineShaderStageCreateInfo> = Vec::new();
                    if c.stage != Stage::Vertex {
                        fragment_stages.push(shader_create_info[1]);
                        if c.desc != Desc::VertexAttributeFetch {
                            fragment_stages.last_mut().expect("pushed").next = (&raw const robustness_info).cast();
                        }
                    }
                    let frag_shader_pipeline_info = vk::GraphicsPipelineCreateInfo {
                        next: (&raw const frag_shader_lib_info).cast(),
                        flags: library_creation_flags,
                        layout: graphics_pipeline_info.layout,
                        multisample_state: graphics_pipeline_info.multisample_state,
                        depth_stencil_state: graphics_pipeline_info.depth_stencil_state,
                        render_pass: graphics_pipeline_info.render_pass,
                        subpass: graphics_pipeline_info.subpass,
                        stage_count: fragment_stages.len() as u32,
                        stages: if fragment_stages.is_empty() {
                            std::ptr::null()
                        } else {
                            fragment_stages.as_ptr()
                        },
                        ..Default::default()
                    };
                    libraries.push(create_graphics_pipeline(device, &frag_shader_pipeline_info)?);
                }

                // Fragment output library.
                {
                    let frag_output_lib_info = vk::GraphicsPipelineLibraryCreateInfoEXT {
                        flags: vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_OUTPUT_INTERFACE,
                        ..Default::default()
                    };
                    let frag_output_pipeline_info = vk::GraphicsPipelineCreateInfo {
                        next: (&raw const frag_output_lib_info).cast(),
                        flags: library_creation_flags,
                        color_blend_state: graphics_pipeline_info.color_blend_state,
                        render_pass: graphics_pipeline_info.render_pass,
                        subpass: graphics_pipeline_info.subpass,
                        multisample_state: graphics_pipeline_info.multisample_state,
                        ..Default::default()
                    };
                    libraries.push(create_graphics_pipeline(device, &frag_output_pipeline_info)?);
                }

                // Linked pipeline.
                let library_handles: Vec<vk::Pipeline> = libraries.iter().map(|library| library.get()).collect();
                let linked_library_info = vk::PipelineLibraryCreateInfoKHR {
                    library_count: library_handles.len() as u32,
                    libraries: library_handles.as_ptr(),
                    ..Default::default()
                };
                let linked_pipeline_info = vk::GraphicsPipelineCreateInfo {
                    next: (&raw const linked_library_info).cast(),
                    flags: link_flags,
                    layout: graphics_pipeline_info.layout,
                    ..Default::default()
                };
                linked = Some(create_graphics_pipeline(device, &linked_pipeline_info)?);
                pipelines.extend(libraries);
            }

            match linked {
                Some(pipeline) => pipelines.push(pipeline),
                None => {
                    let created = unsafe {
                        device.create_graphics_pipelines(vk::PipelineCache::null(), &[graphics_pipeline_info], None)
                    }
                    .vk_check("vkCreateGraphicsPipelines")?;
                    pipelines.push(Unique::new(device, created.0[0]));
                }
            }
            shader_modules.push(vs);
            shader_modules.push(fs);
            render_pass = Some(created_render_pass);
        }

        let main_pipeline = pipelines.iter().next_back().expect("a pipeline").get();
        let output_image = images[0].as_ref().expect("output image").get();

        let image_barrier_output = vk::ImageMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::empty())
            .dst_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .old_layout(vk::ImageLayout::UNDEFINED)
            .new_layout(vk::ImageLayout::GENERAL)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .image(output_image)
            .subresource_range(make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1))
            .build();
        image_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::BOTTOM_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            image_barrier_output,
        );

        unsafe { device.cmd_bind_pipeline(cmd, bind_point, main_pipeline) };

        if !format_is_r64(c.format) {
            let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
            let clear_color = vk::ClearColorValue { uint32: [0, 0, 0, 0] };
            unsafe {
                device.cmd_clear_color_image(cmd, output_image, vk::ImageLayout::GENERAL, &clear_color, &[range])
            };
        } else {
            let output_buffer = buffer_output_image_r64.as_ref().expect("r64 output buffer").get();
            copy_buffer_to_image(
                device,
                cmd,
                output_buffer,
                vk::Extent3D {
                    width: DIM,
                    height: DIM,
                    depth: 1,
                },
                1,
                output_image,
                all_pipeline_stages,
            );
        }

        let mut dst_access = vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE;
        if !c.use_compute_queue {
            dst_access |= vk::AccessFlags::VERTEX_ATTRIBUTE_READ;
        }
        memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            all_pipeline_stages,
            vk::AccessFlags::TRANSFER_WRITE,
            dst_access,
        );

        if c.stage == Stage::Compute {
            unsafe { device.cmd_dispatch(cmd, DIM, DIM, 1) };
        } else if c.stage == Stage::Raygen {
            let no_region = vk::StridedDeviceAddressRegionKHR::default();
            unsafe { device.cmd_trace_rays_khr(cmd, &rgen_region, &no_region, &no_region, &no_region, DIM, DIM, 1) };
        } else {
            let render_area = vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: DIM,
                    height: DIM,
                },
            };
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass.as_ref().expect("render pass").get())
                .framebuffer(framebuffer.as_ref().expect("framebuffer").get())
                .render_area(render_area);
            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
            // Draw a point cloud for vertex shader testing, and a single quad for fragment shader testing
            if c.desc == Desc::VertexAttributeFetch {
                let vertex_buffer = if c.null_descriptor {
                    vk::Buffer::null()
                } else {
                    buffer.as_ref().expect("buffer").get()
                };
                unsafe {
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer], &[0]);
                    device.cmd_draw(cmd, 1000, 1, 0, 0);
                }

                // This barrier corresponds to the second subpass dependency.
                let write_stage = if c.stage == Stage::Vertex {
                    vk::PipelineStageFlags::VERTEX_SHADER
                } else {
                    vk::PipelineStageFlags::FRAGMENT_SHADER
                };
                memory_barrier(
                    device,
                    cmd,
                    vk::PipelineStageFlags::VERTEX_INPUT,
                    write_stage,
                    vk::AccessFlags::VERTEX_ATTRIBUTE_READ,
                    vk::AccessFlags::SHADER_WRITE,
                );
            }
            unsafe {
                if c.stage == Stage::Vertex {
                    device.cmd_draw(cmd, DIM * DIM, 1, 0, 0);
                } else {
                    device.cmd_draw(cmd, 4, 1, 0, 0);
                }
                device.cmd_end_render_pass(cmd);
            }
        }

        memory_barrier(
            device,
            cmd,
            all_pipeline_stages,
            vk::PipelineStageFlags::TRANSFER,
            vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ | vk::AccessFlags::TRANSFER_WRITE,
        );

        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: DIM,
                height: DIM,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                output_image,
                vk::ImageLayout::GENERAL,
                copy_buffer.get(),
                &[copy_region],
            )
        };

        memory_barrier(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
        );

        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, queue, cmd)?;

        let ptr = copy_buffer.get_allocation().get_host_ptr();

        invalidate_alloc(device, copy_buffer.get_allocation())?;

        let mut pass = true;

        for i in 0..(DIM * DIM) as usize {
            let index = i * num_components;
            unsafe {
                if format_is_float(c.format) {
                    if ptr.cast::<f32>().add(index).read_unaligned() != 1.0 {
                        pass = false;
                    }
                } else if format_is_r64(c.format) {
                    if ptr.cast::<u64>().add(index).read_unaligned() != 1 {
                        pass = false;
                    }
                } else if ptr.cast::<u32>().add(index).read_unaligned() != 1 {
                    pass = false;
                }
            }
        }

        drop((
            rgen_sbt,
            r64_fill_pipeline,
            r64_fill_pipeline_layout,
            r64_fill_module,
            r64_fill_set,
            r64_fill_pool,
            r64_fill_layout,
        ));

        Ok(if pass {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}
