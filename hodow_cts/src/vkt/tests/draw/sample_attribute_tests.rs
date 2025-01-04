// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawSampleAttributeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Tests for the sample interpolation attribute: test that sample interpolation correctly enables sample shading
// at a rate of 1.0.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::draw_sample_attribute::{
    SAMPLE_ATTRIBUTE_DECORATION, SAMPLE_ATTRIBUTE_SAMPLE_ID, SAMPLE_ATTRIBUTE_SAMPLE_POSITION,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::GroupParams;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 4;
const HEIGHT: u32 = 4;
const SAMPLE_COUNT: u32 = 4;
const EXPECTED_COUNTER: u32 = SAMPLE_COUNT * WIDTH * HEIGHT;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Trigger {
    SampleIdStaticUse,
    SamplePositionStaticUse,
    SampleDecorationDynamicUse,
}

#[derive(Clone, Copy)]
struct TestParameters {
    general: GroupParams,
    // Test case variant on the fragment shader.
    trigger: Trigger,
    // Test case variant: minSampleShading overrides to 1.0f.
    sample_shading_enable_value: bool,
    min_sample_shading_value: f32,
}

struct SampleShadingSampleAttributeTestCase {
    name: String,
    params: TestParameters,
}

impl TestCase for SampleShadingSampleAttributeTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        if params.general.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        if context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: fragmentStoresAndAtomics".to_string(),
            ));
        }

        // Every trigger declares or uses a sample-rate input.
        if context.get_device_features().sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: sampleRateShading".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.trigger {
            Trigger::SampleDecorationDynamicUse => SAMPLE_ATTRIBUTE_DECORATION.programs,
            Trigger::SampleIdStaticUse => SAMPLE_ATTRIBUTE_SAMPLE_ID.programs,
            Trigger::SamplePositionStaticUse => SAMPLE_ATTRIBUTE_SAMPLE_POSITION.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SampleShadingSampleAttributeTestInstance {
            context,
            params: self.params,
        })
    }
}

struct SampleShadingSampleAttributeTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

impl TestInstance for SampleShadingSampleAttributeTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let dynamic_rendering = params.general.use_dynamic_rendering;

        // Verification buffer.
        let buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, buffer_size as usize) };
        flush_alloc(device, buffer.get_allocation())?;

        // Color attachment.
        let image_format = vk::Format::R8G8B8A8_UNORM;
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(image_format)
            .extent(vk::Extent3D {
                width: WIDTH,
                height: HEIGHT,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_4)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_attachment = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let color_attachment_view = make_image_view(
            device,
            color_attachment.get(),
            vk::ImageViewType::_2D,
            image_format,
            subresource_range,
        )?;

        let scissor = rect_2d(WIDTH, HEIGHT);

        // Render pass and framebuffer.
        let attachments = [vk::AttachmentDescription::builder()
            .format(image_format)
            .samples(vk::SampleCountFlags::_4)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let color_attachment_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_references)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_attachment_view], WIDTH, HEIGHT, 1)?;
        let clear_value = clear_value_color([1.0, 1.0, 1.0, 1.0]);

        // Structures used for dynamic rendering.
        let color_attachments = [vk::RenderingAttachmentInfo::builder()
            .image_view(*color_attachment_view)
            .image_layout(vk::ImageLayout::ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(clear_value)
            .build()];
        let render_info_flags = if dynamic_rendering
            && !params
                .general
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass
            && params.general.use_secondary_cmd_buffer
        {
            vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
        } else {
            vk::RenderingFlags::empty()
        };
        let render_info = vk::RenderingInfo::builder()
            .flags(render_info_flags)
            .render_area(scissor)
            .layer_count(1)
            .view_mask(0)
            .color_attachments(&color_attachments);

        let color_formats = [image_format];
        let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
            .flags(vk::RenderingFlags::empty())
            .view_mask(0)
            .color_attachment_formats(&color_formats)
            .depth_attachment_format(vk::Format::UNDEFINED)
            .stencil_attachment_format(vk::Format::UNDEFINED)
            .rasterization_samples(vk::SampleCountFlags::_4);
        let buffer_inheritance_info =
            vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let set_layouts = [*descriptor_set_layout];
        let graphics_pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set_buffer = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        // Update descriptor sets.
        let buffer_info = make_descriptor_buffer_info(buffer.get(), 0, buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set_buffer,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer_info,
            )
            .update(device);

        let binaries = context.get_binary_collection();
        let vtx_shader = create_shader_module(device, binaries.get("vert")?)?;
        let frg_shader = create_shader_module(device, binaries.get("frag")?)?;

        // Set up a multisample state based on test parameters.
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
        state.viewports = vec![vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: WIDTH as f32,
            height: HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        state.scissors = vec![scissor];
        state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.samples = vk::SampleCountFlags::_4;
        state.sample_shading = params.sample_shading_enable_value;
        state.min_sample_shading = params.min_sample_shading_value;
        if dynamic_rendering {
            state.rendering_format = Some(image_format);
        }
        let pass = if dynamic_rendering {
            vk::RenderPass::null()
        } else {
            *render_pass
        };
        let pipeline = create_draw_pipeline(
            device,
            *graphics_pipeline_layout,
            pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vtx_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frg_shader),
            ],
            &state,
        )?;

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let primary_cmd_buffer_holder =
            allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let primary_cmd_buffer = *primary_cmd_buffer_holder;
        let secondary_cmd_buffer_holder =
            allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::SECONDARY)?;
        let secondary_cmd_buffer = *secondary_cmd_buffer_holder;

        begin_command_buffer(device, primary_cmd_buffer)?;

        let draw = |cmd: vk::CommandBuffer| unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *graphics_pipeline_layout,
                0,
                &[*descriptor_set_buffer],
                &[],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(cmd, 3, 1, 0, 0);
        };

        if dynamic_rendering {
            // Transition color attachment to the proper layout.
            let initial_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::ATTACHMENT_OPTIMAL,
                color_attachment.get(),
                subresource_range,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    primary_cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[initial_barrier],
                );
            }

            if params
                .general
                .secondary_cmd_buffer_completely_contains_dynamic_renderpass
            {
                let command_buf_begin_params = vk::CommandBufferBeginInfo::builder()
                    .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
                    .inheritance_info(&buffer_inheritance_info);

                unsafe {
                    device
                        .begin_command_buffer(secondary_cmd_buffer, &command_buf_begin_params)
                        .vk_check("vkBeginCommandBuffer")?;
                    device.cmd_begin_rendering(secondary_cmd_buffer, &render_info);
                }
                draw(secondary_cmd_buffer);
                unsafe { device.cmd_end_rendering(secondary_cmd_buffer) };
                end_command_buffer(device, secondary_cmd_buffer)?;
                unsafe { device.cmd_execute_commands(primary_cmd_buffer, &[secondary_cmd_buffer]) };
            } else if params.general.use_secondary_cmd_buffer {
                let command_buf_begin_params = vk::CommandBufferBeginInfo::builder()
                    .flags(
                        vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT
                            | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE,
                    )
                    .inheritance_info(&buffer_inheritance_info);

                unsafe {
                    device.cmd_begin_rendering(primary_cmd_buffer, &render_info);
                    device
                        .begin_command_buffer(secondary_cmd_buffer, &command_buf_begin_params)
                        .vk_check("vkBeginCommandBuffer")?;
                }
                draw(secondary_cmd_buffer);
                end_command_buffer(device, secondary_cmd_buffer)?;
                unsafe {
                    device.cmd_execute_commands(primary_cmd_buffer, &[secondary_cmd_buffer]);
                    device.cmd_end_rendering(primary_cmd_buffer);
                }
            } else {
                unsafe { device.cmd_begin_rendering(primary_cmd_buffer, &render_info) };
                draw(primary_cmd_buffer);
                unsafe { device.cmd_end_rendering(primary_cmd_buffer) };
            }
        } else {
            let clear_values = [clear_value];
            let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(scissor)
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(primary_cmd_buffer, &render_pass_begin_info, vk::SubpassContents::INLINE)
            };
            draw(primary_cmd_buffer);
            unsafe { device.cmd_end_render_pass(primary_cmd_buffer) };
        }

        let render_buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer.get(),
            0,
            buffer_size,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                primary_cmd_buffer,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[render_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, primary_cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), primary_cmd_buffer)?;

        invalidate_alloc(device, buffer.get_allocation())?;

        let result = unsafe { *buffer.get_allocation().get_host_ptr().cast::<u32>() };

        if result < EXPECTED_COUNTER {
            return Ok(TestStatus::fail(format!(
                "Atomic counter value lower than expected: {result}"
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createSampleAttributeTests`
pub fn create_sample_attribute_tests(group_params: GroupParams) -> TestCaseGroup {
    let trigger_cases = [
        // Dynamically use the sample decoration on a frag shader input variable
        (Trigger::SampleDecorationDynamicUse, "sample_decoration_dynamic_use"),
        // Declare SampleId built-in in the frag shader without using it
        (Trigger::SampleIdStaticUse, "sample_id_static_use"),
        // Declare SamplePosition built-in in the frag shader without using it
        (Trigger::SamplePositionStaticUse, "sample_position_static_use"),
    ];

    let mut group = TestCaseGroup::new("implicit_sample_shading");

    for (trigger, name) in trigger_cases {
        let params = TestParameters {
            general: group_params,
            trigger,
            sample_shading_enable_value: false,
            min_sample_shading_value: 0.0,
        };
        group.add_child(Box::new(SampleShadingSampleAttributeTestCase {
            name: name.to_string(),
            params,
        }) as Box<dyn TestCase>);

        // Test case variant: minSampleShading overrides to 1.0f with sampleShading enabled via builtins
        if !group_params.secondary_cmd_buffer_completely_contains_dynamic_renderpass {
            for (min_sample_shading_value, min_name) in [(0.0f32, "zero"), (0.25, "quarter"), (0.5, "half")] {
                let override_params = TestParameters {
                    general: group_params,
                    trigger,
                    sample_shading_enable_value: true,
                    min_sample_shading_value,
                };
                let override_name = format!("minSampleShadingValue_{min_name}_{name}");
                group.add_child(Box::new(SampleShadingSampleAttributeTestCase {
                    name: override_name,
                    params: override_params,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}
