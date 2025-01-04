// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingDescriptorCombinationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Both cases use VK_EXT_descriptor_buffer. The first records push descriptors, a legacy descriptor
// set and a descriptor buffer into one command buffer, each driving its own storage buffer. The
// second creates three samplers with custom border colours, captures their descriptor data,
// recreates them in the opposite order from that data and checks that the descriptors written into
// the descriptor buffer beforehand still select the right border colours. The shaders are in
// `shaders/manifest/binding_model_descriptor_combination.toml`.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_2, ExtDescriptorBufferExtensionDeviceCommands, InstanceV1_1, KhrPushDescriptorExtensionDeviceCommands,
};

use crate::generated::shaders::binding_model_descriptor_combination::{
    DESCRIPTOR_COMBINATION_CUSTOM_BORDER_COLOR, DESCRIPTOR_COMBINATION_LEGACY_AND_BUFFER,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `TestType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    DescriptorBufferAndLegacyDescriptorInCommandBuffer,
    DescriptorBufferCaptureReplayWithCustomBorderColor,
}

fn descriptor_buffer_properties(context: &Context<'_>) -> vk::PhysicalDeviceDescriptorBufferPropertiesEXT {
    let mut properties = vk::PhysicalDeviceDescriptorBufferPropertiesEXT::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    properties
}

/// `DescriptorCombinationTestCase`
struct DescriptorCombinationTestCase {
    name: &'static str,
    test_type: TestType,
}

impl TestCase for DescriptorCombinationTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_descriptor_buffer")?;
        if self.test_type == TestType::DescriptorBufferAndLegacyDescriptorInCommandBuffer {
            context.require_device_functionality("VK_KHR_push_descriptor")?;
        }
        if self.test_type == TestType::DescriptorBufferCaptureReplayWithCustomBorderColor {
            context.require_device_functionality("VK_EXT_custom_border_color")?;

            let mut features = vk::PhysicalDeviceDescriptorBufferFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if features.descriptor_buffer_capture_replay == vk::FALSE {
                return Err(TestError::NotSupported(
                    "descriptorBufferCaptureReplay is not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.test_type {
            TestType::DescriptorBufferAndLegacyDescriptorInCommandBuffer => {
                DESCRIPTOR_COMBINATION_LEGACY_AND_BUFFER.programs
            }
            TestType::DescriptorBufferCaptureReplayWithCustomBorderColor => {
                DESCRIPTOR_COMBINATION_CUSTOM_BORDER_COLOR.programs
            }
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        match self.test_type {
            TestType::DescriptorBufferCaptureReplayWithCustomBorderColor => {
                Box::new(DescriptorCustomBorderColorInstance { context })
            }
            TestType::DescriptorBufferAndLegacyDescriptorInCommandBuffer => {
                Box::new(DescriptorCombinationInstance { context })
            }
        }
    }
}

/// `DescriptorCombinationTestInstance`
struct DescriptorCombinationInstance<'a> {
    context: &'a Context<'a>,
}

impl DescriptorCombinationInstance<'_> {
    /// `createBasicPipeline`
    fn create_basic_pipeline(
        &self,
        layout: vk::PipelineLayout,
        shader_module: vk::ShaderModule,
        flags: vk::PipelineCreateFlags,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(shader_module)
            .name(b"main\0")
            .build();
        let info = vk::ComputePipelineCreateInfo::builder()
            .flags(flags)
            .stage(stage)
            .layout(layout)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateComputePipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// A pipeline layout with the one push constant range both shaders read.
    fn make_layout(
        &self,
        set_layout: vk::DescriptorSetLayout,
        range: vk::PushConstantRange,
    ) -> Result<Unique<'_, vk::PipelineLayout>, TestError> {
        let device = self.context.get_device();
        let set_layouts = [set_layout];
        let ranges = [range];
        let info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&ranges);
        let layout = unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;
        Ok(Unique::new(device, layout))
    }
}

impl TestInstance for DescriptorCombinationInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // test using both descriptor buffers & legacy descriptors in the same command buffer
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        // Create three storage buffers, one for each way we setup descriptors
        let buffer_size = (16 * std::mem::size_of::<u32>()) as vk::DeviceSize;
        let buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER
            | vk::BufferUsageFlags::TRANSFER_SRC
            | vk::BufferUsageFlags::TRANSFER_DST;
        let buffer_for_legacy_ds = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let buffer_for_push_desc = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, buffer_usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let buffer_for_desc_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, buffer_usage | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
        )?;

        // Create descriptor pool - we need just one descriptor set
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;

        // Create three descriptor layouts
        let layout_for_push_desc = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, vk::ShaderStageFlags::COMPUTE)
            .build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)?;
        let layout_for_legacy_ds = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let layout_for_desc_buffer = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, vk::ShaderStageFlags::COMPUTE)
            .build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::DESCRIPTOR_BUFFER_EXT)?;

        // Create legacy descriptor set
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *layout_for_legacy_ds)?;
        let mut buffer_descriptor_info = make_descriptor_buffer_info(buffer_for_legacy_ds.get(), 0, buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                desc_type,
                &buffer_descriptor_info,
            )
            .update(device);

        // Define WriteDescriptorSet for push descriptor
        buffer_descriptor_info.buffer = buffer_for_push_desc.get();
        let push_buffer_infos = [buffer_descriptor_info];
        let descriptor_writes = [vk::WriteDescriptorSet::builder()
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&push_buffer_infos)
            .build()];

        // Check how big descriptor buffer we need
        let descriptor_buffer_size = unsafe { device.get_descriptor_set_layout_size_ext(*layout_for_desc_buffer) };

        // Create descriptor buffer with needed size
        let descriptor_buffer_usage =
            vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
        let descriptor_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(descriptor_buffer_size, descriptor_buffer_usage),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
        )?;
        let descriptor_buffer_host_ptr = descriptor_buffer.get_allocation().get_host_ptr();

        // Get address of ssbo to which we will write in shader
        let ssbo_address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer_for_desc_buffer.get());
        let descriptor_address_info = vk::DescriptorAddressInfoEXT {
            address: unsafe { device.get_buffer_device_address(&ssbo_address_info) },
            range: buffer_size,
            ..Default::default()
        };

        let descriptor_get_info = vk::DescriptorGetInfoEXT {
            type_: vk::DescriptorType::STORAGE_BUFFER,
            data: vk::DescriptorDataEXT {
                storage_buffer: &descriptor_address_info,
            },
            ..Default::default()
        };

        let size = descriptor_buffer_properties(context).storage_buffer_descriptor_size;
        let offset =
            unsafe { device.get_descriptor_set_layout_binding_offset_ext(*layout_for_desc_buffer, 0) } as usize;
        unsafe {
            device.get_descriptor_ext(
                &descriptor_get_info,
                std::slice::from_raw_parts_mut(descriptor_buffer_host_ptr.add(offset), size),
            )
        };
        flush_alloc(device, descriptor_buffer.get_allocation())?;

        // Get address of descriptor buffer
        let descriptor_buffer_address_info = vk::BufferDeviceAddressInfo::builder().buffer(descriptor_buffer.get());
        let descriptor_buffer_binding_info = vk::DescriptorBufferBindingInfoEXT {
            address: unsafe { device.get_buffer_device_address(&descriptor_buffer_address_info) },
            usage: vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT,
            ..Default::default()
        };

        let memory_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::SHADER_READ);
        let push_constant_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            offset: 0,
            size: std::mem::size_of::<i32>() as u32,
        };

        let descriptor_buffer_indices = [0u32];
        let descriptor_buffer_offsets = [0 as vk::DeviceSize];
        let binaries = context.get_binary_collection();

        let shader_module_init = create_shader_module(device, binaries.get("comp_init")?)?;
        let shader_module_add = create_shader_module(device, binaries.get("comp_add")?)?;
        let layout_push = self.make_layout(*layout_for_push_desc, push_constant_range)?;
        let layout_legacy = self.make_layout(*layout_for_legacy_ds, push_constant_range)?;
        let layout_buffer = self.make_layout(*layout_for_desc_buffer, push_constant_range)?;
        let no_flags = vk::PipelineCreateFlags::empty();
        let pipeline_init_for_push_desc = self.create_basic_pipeline(*layout_push, *shader_module_init, no_flags)?;
        let pipeline_init_for_legacy_ds = self.create_basic_pipeline(*layout_legacy, *shader_module_init, no_flags)?;
        let pipeline_init_for_desc_buffer = self.create_basic_pipeline(
            *layout_buffer,
            *shader_module_init,
            vk::PipelineCreateFlags::DESCRIPTOR_BUFFER_EXT,
        )?;
        let pipeline_add_for_push_desc = self.create_basic_pipeline(*layout_push, *shader_module_add, no_flags)?;
        let pipeline_add_for_legacy_ds = self.create_basic_pipeline(*layout_legacy, *shader_module_add, no_flags)?;
        let pipeline_add_for_desc_buffer = self.create_basic_pipeline(
            *layout_buffer,
            *shader_module_add,
            vk::PipelineCreateFlags::DESCRIPTOR_BUFFER_EXT,
        )?;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let bind_point = vk::PipelineBindPoint::COMPUTE;

        let use_push_descriptor = |pipeline: vk::Pipeline, push_const_value: i32| unsafe {
            device.cmd_bind_pipeline(cmd, bind_point, pipeline);
            device.cmd_push_constants(
                cmd,
                *layout_push,
                vk::ShaderStageFlags::COMPUTE,
                0,
                &push_const_value.to_ne_bytes(),
            );
            device.cmd_push_descriptor_set_khr(cmd, bind_point, *layout_push, 0, &descriptor_writes);
            device.cmd_dispatch(cmd, 1, 1, 1);
        };
        let use_legacy_descriptor = |pipeline: vk::Pipeline, push_const_value: i32| unsafe {
            device.cmd_bind_pipeline(cmd, bind_point, pipeline);
            device.cmd_push_constants(
                cmd,
                *layout_legacy,
                vk::ShaderStageFlags::COMPUTE,
                0,
                &push_const_value.to_ne_bytes(),
            );
            device.cmd_bind_descriptor_sets(cmd, bind_point, *layout_legacy, 0, &[*descriptor_set], &[]);
            device.cmd_dispatch(cmd, 1, 1, 1);
        };
        let use_descriptor_buffer = |pipeline: vk::Pipeline, push_const_value: i32| unsafe {
            device.cmd_bind_pipeline(cmd, bind_point, pipeline);
            device.cmd_push_constants(
                cmd,
                *layout_buffer,
                vk::ShaderStageFlags::COMPUTE,
                0,
                &push_const_value.to_ne_bytes(),
            );
            device.cmd_bind_descriptor_buffers_ext(cmd, &[descriptor_buffer_binding_info]);
            device.cmd_set_descriptor_buffer_offsets_ext(
                cmd,
                bind_point,
                *layout_buffer,
                0,
                &descriptor_buffer_indices,
                &descriptor_buffer_offsets,
            );
            device.cmd_dispatch(cmd, 1, 1, 1);
        };
        let compute_barrier = || unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        };

        begin_command_buffer(device, cmd)?;

        use_push_descriptor(*pipeline_init_for_push_desc, 3);
        use_legacy_descriptor(*pipeline_init_for_legacy_ds, 5);
        use_descriptor_buffer(*pipeline_init_for_desc_buffer, 6);
        compute_barrier();

        use_push_descriptor(*pipeline_add_for_push_desc, 2);
        use_legacy_descriptor(*pipeline_add_for_legacy_ds, 1);
        compute_barrier();

        use_push_descriptor(*pipeline_add_for_push_desc, 2);
        use_descriptor_buffer(*pipeline_add_for_desc_buffer, 3);
        compute_barrier();

        use_push_descriptor(*pipeline_add_for_push_desc, 2);

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let expected_results: [(&BufferWithMemory<'_>, [i32; 16]); 3] = [
            (
                &buffer_for_legacy_ds,
                [1, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61, 66, 71, 76],
            ),
            (
                &buffer_for_push_desc,
                [6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51],
            ),
            (
                &buffer_for_desc_buffer,
                [3, 9, 15, 21, 27, 33, 39, 45, 51, 57, 63, 69, 75, 81, 87, 93],
            ),
        ];

        // Verify all three result buffers
        for (buffer, expected_values) in expected_results {
            let allocation = buffer.get_allocation();
            invalidate_alloc(device, allocation)?;

            let values = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr() as *const i32, 16) };
            if values != expected_values {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `DescriptorCustomBorderColorTestInstance`
struct DescriptorCustomBorderColorInstance<'a> {
    context: &'a Context<'a>,
}

const SAMPLER_COUNT: usize = 3;

impl DescriptorCustomBorderColorInstance<'_> {
    /// One of the three samplers: `replay_data` is the captured descriptor data when recreating.
    fn create_sampler(
        &self,
        border_color: [f32; 4],
        format: vk::Format,
        replay_data: Option<*const u8>,
    ) -> Result<Unique<'_, vk::Sampler>, TestError> {
        let device = self.context.get_device();

        let mut custom_border_color_info = vk::SamplerCustomBorderColorCreateInfoEXT {
            custom_border_color: vk::ClearColorValue { float32: border_color },
            format,
            ..Default::default()
        };
        let mut opaque_create_info = vk::OpaqueCaptureDescriptorDataCreateInfoEXT {
            opaque_capture_descriptor_data: replay_data.unwrap_or(std::ptr::null()) as *const c_void,
            ..Default::default()
        };

        let info = vk::SamplerCreateInfo::builder()
            .flags(vk::SamplerCreateFlags::DESCRIPTOR_BUFFER_CAPTURE_REPLAY_EXT)
            .address_mode_u(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .address_mode_v(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .address_mode_w(vk::SamplerAddressMode::CLAMP_TO_BORDER)
            .max_anisotropy(1.0)
            .border_color(vk::BorderColor::FLOAT_CUSTOM_EXT)
            .push_next(&mut custom_border_color_info);
        let info = if replay_data.is_some() {
            info.push_next(&mut opaque_create_info)
        } else {
            info
        };
        let sampler = unsafe { device.create_sampler(&info, None) }.vk_check("vkCreateSampler")?;
        Ok(Unique::new(device, sampler))
    }
}

impl TestInstance for DescriptorCustomBorderColorInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // Coverage for capture/replay with custom border color;
        // Create samplers A, B, C  ->  replay samplers C, B, A;
        // Draw using samplers to verify that border colors are fine.
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        let size = 8u32;
        let format = vk::Format::R8G8B8A8_UNORM;
        let image_extent = vk::Extent3D {
            width: size,
            height: size,
            depth: 1,
        };
        let viewport_scissor = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: size,
                height: size,
            },
        };
        let srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let texture_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();
        let texture_image = ImageWithMemory::new(device, allocator, texture_info, MemoryRequirement::ANY)?;
        let texture_image_view = make_image_view(device, texture_image.get(), vk::ImageViewType::_2D, format, srr)?;

        // ImageWithBuffer
        let color_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::COLOR_ATTACHMENT)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();
        let color_image = ImageWithMemory::new(device, allocator, color_info, MemoryRequirement::ANY)?;
        let color_image_view = make_image_view(device, color_image.get(), vk::ImageViewType::_2D, format, srr)?;
        let color_buffer_size = (size * size * 4) as vk::DeviceSize;
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::COHERENT,
        )?;

        // create samplers A, B, C
        let colors: [[f32; 4]; SAMPLER_COUNT] = [[1.0, 0.0, 0.0, 1.0], [0.0, 1.0, 0.0, 1.0], [1.0, 0.0, 1.0, 1.0]];
        let mut samplers: Vec<Option<Unique<'_, vk::Sampler>>> = Vec::with_capacity(SAMPLER_COUNT);
        for color in colors {
            samplers.push(Some(self.create_sampler(color, format, None)?));
        }

        let render_pass = make_render_pass(device, format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_image_view], size, size, 1)?;

        let mut layout_builder = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::SAMPLED_IMAGE, vk::ShaderStageFlags::FRAGMENT);
        for _ in 0..SAMPLER_COUNT {
            layout_builder =
                layout_builder.add_single_binding(vk::DescriptorType::SAMPLER, vk::ShaderStageFlags::FRAGMENT);
        }
        let descriptor_set_layout =
            layout_builder.build_with_flags(device, vk::DescriptorSetLayoutCreateFlags::DESCRIPTOR_BUFFER_EXT)?;

        // check how big descriptor buffer we need
        let buffer_size = unsafe { device.get_descriptor_set_layout_size_ext(*descriptor_set_layout) };

        // create buffer for descriptor buffer
        let buffer_usage = vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
            | vk::BufferUsageFlags::TRANSFER_DST
            | vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT
            | vk::BufferUsageFlags::SAMPLER_DESCRIPTOR_BUFFER_EXT;
        let buffer_with_memory = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, buffer_usage),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
        )?;

        // get address of descriptor buffer
        let buffer_address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer_with_memory.get());
        let descriptor_buffer_binding_info = vk::DescriptorBufferBindingInfoEXT {
            address: unsafe { device.get_buffer_device_address(&buffer_address_info) },
            usage: vk::BufferUsageFlags::RESOURCE_DESCRIPTOR_BUFFER_EXT
                | vk::BufferUsageFlags::SAMPLER_DESCRIPTOR_BUFFER_EXT,
            ..Default::default()
        };

        let buffer_allocation = buffer_with_memory.get_allocation();
        let mut descriptor_buffer_host_ptr = buffer_allocation.get_host_ptr();

        // place texture image into descriptor buffer
        let db_properties = descriptor_buffer_properties(context);
        let sampled_image_size = db_properties.sampled_image_descriptor_size;
        let image_info = vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *texture_image_view,
            image_layout: vk::ImageLayout::ATTACHMENT_OPTIMAL,
        };
        let mut desc_get_info = vk::DescriptorGetInfoEXT {
            type_: vk::DescriptorType::SAMPLED_IMAGE,
            data: vk::DescriptorDataEXT {
                sampled_image: &image_info,
            },
            ..Default::default()
        };
        unsafe {
            device.get_descriptor_ext(
                &desc_get_info,
                std::slice::from_raw_parts_mut(descriptor_buffer_host_ptr, sampled_image_size),
            )
        };

        // place samplers into descriptor buffer in order A, B, C (order of creation)
        descriptor_buffer_host_ptr = unsafe { descriptor_buffer_host_ptr.add(sampled_image_size) };
        let sampler_descriptor_size = db_properties.sampler_descriptor_size;
        for sampler in &samplers {
            let sampler_handle: vk::Sampler = **sampler
                .as_ref()
                .expect("the samplers exist until they are destroyed below");
            desc_get_info.type_ = vk::DescriptorType::SAMPLER;
            desc_get_info.data = vk::DescriptorDataEXT {
                sampler: &sampler_handle,
            };
            unsafe {
                device.get_descriptor_ext(
                    &desc_get_info,
                    std::slice::from_raw_parts_mut(descriptor_buffer_host_ptr, sampler_descriptor_size),
                )
            };
            descriptor_buffer_host_ptr = unsafe { descriptor_buffer_host_ptr.add(sampler_descriptor_size) };
        }
        flush_alloc(device, buffer_allocation)?;

        // capture replay data for all samplers
        let sampler_replay_size = db_properties.sampler_capture_replay_descriptor_data_size;
        let mut capture_replay_data = vec![0u8; SAMPLER_COUNT * sampler_replay_size];
        for (i, sampler) in samplers.iter().enumerate() {
            let info = vk::SamplerCaptureDescriptorDataInfoEXT {
                sampler: **sampler
                    .as_ref()
                    .expect("the samplers exist until they are destroyed below"),
                ..Default::default()
            };
            unsafe {
                device.get_sampler_opaque_capture_descriptor_data_ext(
                    &info,
                    capture_replay_data[i * sampler_replay_size..].as_mut_ptr() as *mut c_void,
                )
            }
            .vk_check("vkGetSamplerOpaqueCaptureDescriptorDataEXT")?;
        }

        // destroy all samplers
        for sampler in samplers.iter_mut() {
            *sampler = None;
        }

        // recreate samplers in order C, B, A (reverse order)
        for i in 0..SAMPLER_COUNT {
            let source = SAMPLER_COUNT - 1 - i;
            let replay_data = capture_replay_data[source * sampler_replay_size..].as_ptr();
            samplers[i] = Some(self.create_sampler(colors[source], format, Some(replay_data))?);
        }

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // define empty VertexInputState, full screen triangle will be generated in vertex shader
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vert_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(b"main\0")
                .build(),
        ];
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: size as f32,
            height: size as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [viewport_scissor];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .flags(vk::PipelineCreateFlags::DESCRIPTOR_BUFFER_EXT)
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let graphics_pipeline = Unique::new(device, pipelines.0[0]);

        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        // transition texture image to SHADER_READ_ONLY_OPTIMAL
        let texture_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            texture_image.get(),
            srr,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[texture_barrier],
            );
        }

        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            scissors[0],
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [1.0, 0.0, 0.0, 1.0],
                },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, bind_point, *graphics_pipeline);
            device.cmd_bind_descriptor_buffers_ext(cmd, &[descriptor_buffer_binding_info]);
            device.cmd_set_descriptor_buffer_offsets_ext(
                cmd,
                bind_point,
                *pipeline_layout,
                0,
                &[0u32],
                &[0 as vk::DeviceSize],
            );
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        // copyImageToBuffer
        let to_transfer_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            srr,
        );
        let copy_region = make_buffer_image_copy(
            image_extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        let to_host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer_barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[to_host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let allocation = color_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;
        let pixels = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), color_buffer_size as usize) };

        // verify result: mix(mix(A, B, 0.25), C, 0.7)
        let mix = |a: [f32; 4], b: [f32; 4], t: f32| -> [f32; 4] {
            std::array::from_fn(|channel| a[channel] * (1.0 - t) + b[channel] * t)
        };
        let expected_color = mix(mix(colors[0], colors[1], 0.25), colors[2], 0.7);
        for i in 0..4usize {
            // it should be sufficient to verify just few fragments
            let offset = i * 4 * (size as usize + i * 2);
            let rendered_color: [f32; 4] = std::array::from_fn(|channel| f32::from(pixels[offset + channel]) / 255.0);

            if (0..4).any(|channel| (expected_color[channel] - rendered_color[channel]).abs() > 0.05) {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `populateDescriptorCombinationTests` / `createDescriptorCombinationTests`
pub fn create_descriptor_combination_tests() -> TestCaseGroup {
    let mut top_group = TestCaseGroup::new("descriptor_combination");
    let mut basic_group = TestCaseGroup::new("basic");

    let case_list = [
        (
            "descriptor_buffer_and_legacy_descriptor_in_command_buffer",
            TestType::DescriptorBufferAndLegacyDescriptorInCommandBuffer,
        ),
        (
            "descriptor_buffer_capture_replay_with_custom_border_color",
            TestType::DescriptorBufferCaptureReplayWithCustomBorderColor,
        ),
    ];
    for (name, test_type) in case_list {
        basic_group.add_child(Box::new(DescriptorCombinationTestCase { name, test_type }) as Box<dyn TestCase>);
    }

    top_group.add_child(basic_group);
    top_group
}
