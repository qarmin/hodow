// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawShaderInvocationTests.cpp (the Amber scripts under
//   data/vulkan/amber/draw/shader_invocation)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A 2x2 strip is drawn into an R32G32B32A32_SFLOAT target cleared to 1 by a fragment
// shader that quad-broadcasts values depending on whether the invocation is a helper and demotes two of the four. The script's
// compute shader, which accepts the result when it matches any of the sixteen combinations of which invocations were helpers, is
// run on the host over the read back colour of pixel (0, 0) and the four atomic counters.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::draw_shader_invocation::{
    HELPER_INVOCATION, HELPER_INVOCATION_VOLATILE, HELPER_INVOCATION_VOLATILE_MEM_MODEL,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FORMAT: vk::Format = vk::Format::R32G32B32A32_SFLOAT;

/// `TestType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    Ext,
    Core,
    CoreMemModel,
}

struct ShaderInvocationCase {
    name: &'static str,
    test_type: TestType,
}

impl TestCase for ShaderInvocationCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut subgroup = vk::PhysicalDeviceSubgroupProperties::default();
        let mut properties = vk::PhysicalDeviceProperties2::builder().push_next(&mut subgroup);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties) };
        if !subgroup.supported_operations.contains(vk::SubgroupFeatureFlags::QUAD) {
            return Err(TestError::NotSupported(
                "Device does not support subgroup quad operations".to_string(),
            ));
        }

        let mut demote = vk::PhysicalDeviceShaderDemoteToHelperInvocationFeatures::default();
        let mut memory_model = vk::PhysicalDeviceVulkanMemoryModelFeatures::default();
        {
            let mut features = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut demote)
                .push_next(&mut memory_model);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features) };
        }
        if demote.shader_demote_to_helper_invocation == vk::FALSE {
            return Err(TestError::NotSupported(
                "demoteToHelperInvocation not supported.".to_string(),
            ));
        }

        // EXT test requires that the extension be supported, because OpIsHelperInvocationEXT was not promoted to core.
        if self.test_type == TestType::Ext
            && !context.is_device_functionality_supported("VK_EXT_shader_demote_to_helper_invocation")
        {
            return Err(TestError::NotSupported(
                "VK_EXT_shader_demote_to_helper_invocation not supported.".to_string(),
            ));
        }

        // CORE and CORE_MEM_MODEL tests require SPIR-V 1.6.
        if self.test_type != TestType::Ext && context.api_version() < (1, 3, 0) {
            return Err(TestError::NotSupported("SPIR-V 1.6 requires Vulkan 1.3".to_string()));
        }

        if self.test_type == TestType::CoreMemModel && memory_model.vulkan_memory_model == vk::FALSE {
            return Err(TestError::NotSupported(
                "Vulkan memory model not supported.".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.test_type {
            TestType::Ext => HELPER_INVOCATION.programs,
            TestType::Core => HELPER_INVOCATION_VOLATILE.programs,
            TestType::CoreMemModel => HELPER_INVOCATION_VOLATILE_MEM_MODEL.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderInvocationInstance { context })
    }
}

struct ShaderInvocationInstance<'a> {
    context: &'a Context<'a>,
}

impl ShaderInvocationInstance<'_> {
    /// The script's compute shader: whether (`color`, `atomics`) match one of the outcomes of which of the four invocations were helpers.
    fn matches_some_outcome(color: [f32; 4], atomics: [u32; 4]) -> bool {
        for mask in 0..16u32 {
            let mut test_vec = [
                (mask & 1) as f32,
                (mask >> 1 & 1) as f32 * 2.0,
                (mask >> 2 & 1) as f32 * 3.0,
                (mask >> 3 & 1) as f32 * 4.0,
            ];
            let mut atomic_vec = [0u32; 4];

            for j in 0..4 {
                if test_vec[j] > 0.0 {
                    test_vec[j] = 8.0;
                    atomic_vec[j] = 0;
                } else {
                    test_vec[j] = j as f32 + 1.0;
                    atomic_vec[j] = 101;
                }
            }

            let dot = |v: [f32; 4]| v[0] + v[1] * 10.0 + v[2] * 100.0 + v[3] * 1000.0;
            let mask0 = dot(test_vec);
            let mask1 = dot([test_vec[0], 8.0, 8.0, test_vec[3]]);
            let mask2 = dot([test_vec[0], 8.0, 8.0, 8.0]);

            atomic_vec[1] = 0;
            atomic_vec[2] = 0;

            if color[0] == 1.0
                && atomics[0] == atomic_vec[0]
                && color[1] == mask0
                && atomics[1] == atomic_vec[1]
                && color[2] == mask1
                && atomics[2] == atomic_vec[2]
                && color[3] == mask2
                && atomics[3] == atomic_vec[3]
            {
                return true;
            }
        }
        false
    }
}

impl TestInstance for ShaderInvocationInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();

        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(FORMAT)
            .extent(vk::Extent3D {
                width: 2,
                height: 2,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;
        let view = make_image_view(
            device,
            *image,
            vk::ImageViewType::_2D,
            FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let render_pass = make_render_pass(device, FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*view], 2, 2, 1)?;

        let storage = |values: &[u8]| -> Result<BufferWithMemory<'_>, TestError> {
            let buffer = BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(values.len() as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(values.as_ptr(), buffer.get_allocation().get_host_ptr(), values.len())
            };
            flush_alloc(device, buffer.get_allocation())?;
            Ok(buffer)
        };
        let alpha_bytes: Vec<u8> = [0.75f32, 2.25, 3.25, 3.75]
            .iter()
            .flat_map(|v| v.to_ne_bytes())
            .collect();
        let alpha = storage(&alpha_bytes)?;
        let atomics = storage(&[0u8; 16])?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &make_descriptor_buffer_info(alpha.get(), 0, vk::WHOLE_SIZE),
            )
            .write_single(
                *set,
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &make_descriptor_buffer_info(atomics.get(), 0, vk::WHOLE_SIZE),
            )
            .update(device);
        let layout = make_pipeline_layout(device, &[*set_layout])?;

        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
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
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_STRIP);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: 2.0,
            height: 2.0,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, 2, 2)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0);
        let multisample =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let blend = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .color_blend_state(&color_blend)
            .layout(*layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd)?;
        let clear_values = [vk::ClearValue {
            color: vk::ClearColorValue { float32: [1.0; 4] },
        }];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(make_rect_2d(0, 0, 2, 2))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(*cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(*cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(*cmd, vk::PipelineBindPoint::GRAPHICS, *layout, 0, &[*set], &[]);
            device.cmd_draw(*cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(*cmd);
        }
        end_command_buffer(device, *cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd)?;

        invalidate_alloc(device, atomics.get_allocation())?;
        let atomic_bytes = unsafe { std::slice::from_raw_parts(atomics.get_allocation().get_host_ptr(), 16) };
        let mut atomic_values = [0u32; 4];
        for (value, chunk) in atomic_values.iter_mut().zip(atomic_bytes.chunks_exact(4)) {
            *value = u32::from_ne_bytes(chunk.try_into().expect("four bytes"));
        }

        let rendered = read_color_attachment(
            context,
            *image,
            FORMAT,
            (2, 2),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let color = rendered.get_const_access().get_pixel(0, 0, 0);

        // We don't know if the invocations are helpers or not at the start and therefore all the possible outcomes are allowed.
        if Self::matches_some_outcome(color, atomic_values) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail(format!(
                "Pixel (0, 0) {color:?} with atomics {atomic_values:?} matches none of the possible helper invocation outcomes"
            )))
        }
    }
}

/// `createShaderInvocationTests`
pub fn create_shader_invocation_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shader_invocation");
    group.add_child(Box::new(ShaderInvocationCase {
        name: "helper_invocation",
        test_type: TestType::Ext,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(ShaderInvocationCase {
        name: "helper_invocation_volatile",
        test_type: TestType::Core,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(ShaderInvocationCase {
        name: "helper_invocation_volatile_mem_model",
        test_type: TestType::CoreMemModel,
    }) as Box<dyn TestCase>);
    group
}
