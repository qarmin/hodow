// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateDiscardTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `discard`: a quad is drawn by a fragment shader that discards every fragment, with the one state under test set
// dynamically; neither the colour target nor the depth or stencil image may change. `DiscardTestInstance::beginRenderPass`
// clears the depth/stencil image through one range, the stencil aspect for S8_UINT and the depth aspect for anything
// else, so the stencil of a combined format is not cleared before the stencil case reads it; that is kept as upstream has it.

use vulkanalia::prelude::v1_0::*;

use super::construction::create_graphics_pipeline;
use crate::generated::shaders::dynamic_state_discard::DISCARD;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{default_depth_stencil_state, default_rasterization_state, rect_2d};
use crate::vkt::tests::draw::{initial_transition_color_2d_image, transition_2d_image};
use crate::vkt::tests::dynamic_state::base_class::{
    BLACK, GREEN, HEIGHT, PositionColorVertex, WIDTH, default_blend_attachment, read_image_aspect_bytes,
    read_rgba8_image,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `TestDynamicStateDiscard`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestDynamicStateDiscard {
    Stencil,
    Viewport,
    Scissor,
    Depth,
    BlendConstants,
    LineWidth,
}

/// `pickSupportedStencilFormat`
fn pick_supported_stencil_format(context: &Context<'_>) -> Result<vk::Format, TestError> {
    for format in [
        vk::Format::S8_UINT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ] {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
        {
            return Ok(format);
        }
    }
    Err(TestError::Fail("Cannot find supported stencil format".to_string()))
}

/// `DiscardTestCase`
struct DiscardTestCase {
    name: &'static str,
    test_case: TestDynamicStateDiscard,
}

impl TestCase for DiscardTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DISCARD.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DiscardTestInstance {
            context,
            test_case: self.test_case,
        })
    }
}

/// `DiscardTestInstance` and its six derived classes.
struct DiscardTestInstance<'a> {
    context: &'a Context<'a>,
    test_case: TestDynamicStateDiscard,
}

impl DiscardTestInstance<'_> {
    /// `setDynamicState` of the derived class
    fn set_dynamic_state(&self, cmd: vk::CommandBuffer) {
        let device = self.context.get_device();
        unsafe {
            match self.test_case {
                TestDynamicStateDiscard::Stencil => {
                    let value = 0x80;
                    device.cmd_set_stencil_compare_mask(cmd, vk::StencilFaceFlags::FRONT, value);
                    device.cmd_set_stencil_write_mask(cmd, vk::StencilFaceFlags::FRONT, value);
                    device.cmd_set_stencil_reference(cmd, vk::StencilFaceFlags::FRONT, value);
                    device.cmd_set_stencil_compare_mask(cmd, vk::StencilFaceFlags::BACK, value);
                    device.cmd_set_stencil_write_mask(cmd, vk::StencilFaceFlags::BACK, value);
                    device.cmd_set_stencil_reference(cmd, vk::StencilFaceFlags::BACK, value);
                }
                TestDynamicStateDiscard::Viewport => {
                    let viewport = vk::Viewport {
                        x: 0.0,
                        y: 0.0,
                        width: WIDTH as f32,
                        height: HEIGHT as f32,
                        min_depth: 0.0,
                        max_depth: 1.0,
                    };
                    device.cmd_set_viewport(cmd, 0, &[viewport]);
                }
                TestDynamicStateDiscard::Scissor => device.cmd_set_scissor(cmd, 0, &[rect_2d(WIDTH, HEIGHT)]),
                TestDynamicStateDiscard::Depth => {
                    device.cmd_set_depth_bounds(cmd, 0.0, 1.0);
                    device.cmd_set_depth_bias(cmd, 1.0, 1.0, 1.0);
                }
                TestDynamicStateDiscard::BlendConstants => device.cmd_set_blend_constants(cmd, [0.0; 4]),
                TestDynamicStateDiscard::LineWidth => device.cmd_set_line_width(cmd, 1.0),
            }
        }
    }

    /// The `m_dynamicStates` the derived class sets.
    fn dynamic_states(&self) -> Vec<vk::DynamicState> {
        match self.test_case {
            TestDynamicStateDiscard::Stencil => vec![
                vk::DynamicState::STENCIL_COMPARE_MASK,
                vk::DynamicState::STENCIL_WRITE_MASK,
                vk::DynamicState::STENCIL_REFERENCE,
            ],
            TestDynamicStateDiscard::Viewport => vec![vk::DynamicState::VIEWPORT],
            TestDynamicStateDiscard::Scissor => vec![vk::DynamicState::SCISSOR],
            TestDynamicStateDiscard::Depth => vec![vk::DynamicState::DEPTH_BIAS, vk::DynamicState::DEPTH_BOUNDS],
            TestDynamicStateDiscard::BlendConstants => vec![vk::DynamicState::BLEND_CONSTANTS],
            TestDynamicStateDiscard::LineWidth => vec![vk::DynamicState::LINE_WIDTH],
        }
    }

    /// `verifyResults` of the derived class
    fn verify_results(
        &self,
        color_target: vk::Image,
        depth_stencil_image: vk::Image,
        depth_stencil_format: vk::Format,
    ) -> TestOutcome {
        let context = self.context;
        match self.test_case {
            TestDynamicStateDiscard::Stencil => {
                let both = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
                let barrier_aspect = if depth_stencil_format == vk::Format::S8_UINT {
                    vk::ImageAspectFlags::STENCIL
                } else {
                    both
                };
                let stencil = read_image_aspect_bytes(
                    context,
                    depth_stencil_image,
                    barrier_aspect,
                    vk::ImageAspectFlags::STENCIL,
                    vk::ImageLayout::GENERAL,
                    WIDTH,
                    HEIGHT,
                    1,
                )?;
                if stencil.iter().any(|&value| value != 0) {
                    return Ok(TestStatus::fail("Image verification failed"));
                }
            }
            TestDynamicStateDiscard::Depth => {
                let depth = read_image_aspect_bytes(
                    context,
                    depth_stencil_image,
                    vk::ImageAspectFlags::DEPTH,
                    vk::ImageAspectFlags::DEPTH,
                    vk::ImageLayout::GENERAL,
                    WIDTH,
                    HEIGHT,
                    4,
                )?;
                if depth
                    .chunks_exact(4)
                    .any(|texel| f32::from_le_bytes([texel[0], texel[1], texel[2], texel[3]]) != 0.0)
                {
                    return Ok(TestStatus::fail("Image verification failed"));
                }
            }
            _ => {
                let pixels = read_rgba8_image(context, color_target, vk::ImageLayout::GENERAL, WIDTH, HEIGHT)?;
                let expected = [0u8, 0, 0, 255];
                if pixels.chunks_exact(4).any(|pixel| pixel != expected) {
                    return Ok(TestStatus::fail("Image verification failed"));
                }
            }
        }
        Ok(TestStatus::pass("Image verification passed"))
    }
}

impl TestInstance for DiscardTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();

        // The constructor of the derived class: which depth/stencil format, and whether the static depth bounds test is on.
        let depth_stencil_format = if self.test_case == TestDynamicStateDiscard::Depth {
            vk::Format::D32_SFLOAT
        } else {
            pick_supported_stencil_format(context)?
        };
        let depth_bounds = if self.test_case == TestDynamicStateDiscard::Stencil {
            context.get_device_features().depth_bounds != vk::FALSE
        } else {
            false
        };

        let extent = vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        };
        let color_attachment_format = vk::Format::R8G8B8A8_UNORM;

        let color_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_attachment_format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_target_image = ImageWithMemory::new(device, alloc, color_info, MemoryRequirement::ANY)?;
        let color_target_view = make_image_view(
            device,
            color_target_image.get(),
            vk::ImageViewType::_2D,
            color_attachment_format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let ds_has_depth = depth_stencil_format != vk::Format::S8_UINT;
        let ds_has_stencil = depth_stencil_format != vk::Format::D32_SFLOAT;
        let mut ds_aspects = vk::ImageAspectFlags::empty();
        if ds_has_depth {
            ds_aspects |= vk::ImageAspectFlags::DEPTH;
        }
        if ds_has_stencil {
            ds_aspects |= vk::ImageAspectFlags::STENCIL;
        }

        let stencil_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(depth_stencil_format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let depth_stencil_image = ImageWithMemory::new(device, alloc, stencil_image_info, MemoryRequirement::ANY)?;
        let depth_stencil_view = make_image_view(
            device,
            depth_stencil_image.get(),
            vk::ImageViewType::_2D,
            depth_stencil_format,
            make_image_subresource_range(ds_aspects, 0, 1, 0, 1),
        )?;

        let data = vec![
            PositionColorVertex::new([-1.0, 1.0, 1.0, 1.0], GREEN),
            PositionColorVertex::new([1.0, 1.0, 1.0, 1.0], GREEN),
            PositionColorVertex::new([-1.0, -1.0, 1.0, 1.0], GREEN),
            PositionColorVertex::new([1.0, -1.0, 1.0, 1.0], GREEN),
        ];

        // m_otherSetLayout and the pipeline layout
        let binding = [vk::DescriptorSetLayoutBinding::builder()
            .binding(0)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
            .descriptor_count(1)
            .stage_flags(vk::ShaderStageFlags::FRAGMENT)
            .build()];
        let set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&binding);
        let set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&set_layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let set_layouts = [*set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // The vertex buffer
        let data_size = std::mem::size_of_val(data.as_slice());
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(data_size as vk::DeviceSize, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                data.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                data_size,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // initRenderPass
        let attachments = [
            vk::AttachmentDescription::builder()
                .format(color_attachment_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::GENERAL)
                .final_layout(vk::ImageLayout::GENERAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(depth_stencil_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::LOAD)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::GENERAL)
                .final_layout(vk::ImageLayout::GENERAL)
                .build(),
        ];
        let color_reference = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::GENERAL)
            .build()];
        let stencil_reference = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::GENERAL)
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_reference)
            .depth_stencil_attachment(&stencil_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // initFramebuffer
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_target_view, *depth_stencil_view],
            WIDTH,
            HEIGHT,
            1,
        )?;

        // initPipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("discard.vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("discard.frag")?)?;
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vertex_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fragment_module)
                .name(b"main\0")
                .build(),
        ];
        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: WIDTH as f32,
            height: HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [rect_2d(WIDTH, HEIGHT)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = default_rasterization_state();
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let blend_attachments = [default_blend_attachment()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&blend_attachments);

        let stencil_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::REPLACE)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::ALWAYS)
            .compare_mask(0)
            .write_mask(0)
            .reference(0)
            .build();
        let mut depth_stencil_state = default_depth_stencil_state();
        depth_stencil_state.depth_test_enable = vk::TRUE;
        depth_stencil_state.depth_write_enable = vk::TRUE;
        depth_stencil_state.depth_compare_op = vk::CompareOp::ALWAYS;
        depth_stencil_state.depth_bounds_test_enable = vk::Bool32::from(depth_bounds);
        depth_stencil_state.min_depth_bounds = 0.0;
        depth_stencil_state.max_depth_bounds = 1.0;
        depth_stencil_state.stencil_test_enable = vk::TRUE;
        depth_stencil_state.front = stencil_state;
        depth_stencil_state.back = stencil_state;

        let dynamic_states = self.dynamic_states();
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .dynamic_state(&dynamic_state)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipeline = create_graphics_pipeline(device, &pipeline_info)?;

        // DiscardTestInstance::iterate
        let pool_sizes = [vk::DescriptorPoolSize {
            type_: vk::DescriptorType::UNIFORM_BUFFER,
            descriptor_count: 1,
        }];
        let pool_info = vk::DescriptorPoolCreateInfo::builder()
            .flags(vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET)
            .max_sets(1)
            .pool_sizes(&pool_sizes);
        let descriptor_pool = Unique::new(
            device,
            unsafe { device.create_descriptor_pool(&pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
        );
        let allocate_info = vk::DescriptorSetAllocateInfo::builder()
            .descriptor_pool(*descriptor_pool)
            .set_layouts(&set_layouts);
        let descriptor_set =
            unsafe { device.allocate_descriptor_sets(&allocate_info) }.vk_check("vkAllocateDescriptorSets")?[0];

        let size = std::mem::size_of::<i32>() as vk::DeviceSize;
        let buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(size, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, size as usize) };
        flush_alloc(device, buffer.get_allocation())?;

        let buffer_info = [vk::DescriptorBufferInfo {
            buffer: buffer.get(),
            offset: 0,
            range: size,
        }];
        let descriptor_write = vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set)
            .dst_binding(0)
            .dst_array_element(0)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
            .buffer_info(&buffer_info);
        unsafe { device.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]) };

        // beginRenderPass(clearColor)
        begin_command_buffer(device, cmd)?;

        initial_transition_color_2d_image(
            device,
            cmd,
            color_target_image.get(),
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::PipelineStageFlags::TRANSFER,
            1,
        );

        let clear_color = vk::ClearColorValue { float32: BLACK };
        unsafe {
            device.cmd_clear_color_image(
                cmd,
                color_target_image.get(),
                vk::ImageLayout::GENERAL,
                &clear_color,
                &[make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)],
            )
        };

        let mem_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[mem_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        // VUID-vkCmdDraw-None-09600
        transition_2d_image(
            device,
            cmd,
            depth_stencil_image.get(),
            ds_aspects,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            1,
        );

        let depth_stencil_clear_value = vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 };
        let clear_aspect = if depth_stencil_format == vk::Format::S8_UINT {
            vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::DEPTH
        };
        unsafe {
            device.cmd_clear_depth_stencil_image(
                cmd,
                depth_stencil_image.get(),
                vk::ImageLayout::GENERAL,
                &depth_stencil_clear_value,
                &[make_image_subresource_range(clear_aspect, 0, 1, 0, 1)],
            );
        }

        let ds_mem_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ
                | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
                | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                    | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
                    | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::DependencyFlags::empty(),
                &[ds_mem_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(WIDTH, HEIGHT));
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set],
                &[],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
        }

        self.set_dynamic_state(cmd);

        unsafe {
            device.cmd_draw(cmd, 4, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, queue, cmd)?;

        self.verify_results(
            color_target_image.get(),
            depth_stencil_image.get(),
            depth_stencil_format,
        )
    }
}

/// `DynamicStateDiscardTests`
pub fn create_discard_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("discard");

    // Use dynamic stencil with discard
    group.add_child(Box::new(DiscardTestCase {
        name: "stencil",
        test_case: TestDynamicStateDiscard::Stencil,
    }) as Box<dyn TestCase>);
    // Use dynamic viewport with discard
    group.add_child(Box::new(DiscardTestCase {
        name: "viewport",
        test_case: TestDynamicStateDiscard::Viewport,
    }) as Box<dyn TestCase>);
    // Use dynamic scissor with discard
    group.add_child(Box::new(DiscardTestCase {
        name: "scissor",
        test_case: TestDynamicStateDiscard::Scissor,
    }) as Box<dyn TestCase>);
    // Use dynamic depth with discard
    group.add_child(Box::new(DiscardTestCase {
        name: "depth",
        test_case: TestDynamicStateDiscard::Depth,
    }) as Box<dyn TestCase>);
    // Use dynamic blend constants with discard
    group.add_child(Box::new(DiscardTestCase {
        name: "blend",
        test_case: TestDynamicStateDiscard::BlendConstants,
    }) as Box<dyn TestCase>);
    // Use dynamic line width with discard
    group.add_child(Box::new(DiscardTestCase {
        name: "line",
        test_case: TestDynamicStateDiscard::LineWidth,
    }) as Box<dyn TestCase>);

    group
}
