// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/conditional_rendering/vktConditionalClearAttachmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtConditionalRenderingExtensionDeviceCommands;

use crate::generated::shaders::conditional_rendering_clear_attachments::CONDITIONAL_CLEAR_ATTACHMENTS;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{ChannelOrder, ChannelType, RGBA, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::allocate_command_buffer;
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::conditional_rendering::test_util::{
    ConditionalData, TESTS_DATA, begin_conditional_rendering, check_conditional_rendering_capabilities,
    check_nested_render_pass_capabilities, create_conditional_rendering_buffer,
};
use crate::vkt::tests::draw::base_class::{DrawTestsBase, GroupParams, VertexElementData};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `ConditionalClearAttachmentTest` as a test case; `checkSupport` is the file-local function of the same name.
struct ConditionalClearAttachmentCase {
    conditional_data: ConditionalData,
}

impl TestCase for ConditionalClearAttachmentCase {
    fn name(&self) -> &str {
        "clear_attachments"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_conditional_rendering_capabilities(context, &self.conditional_data)?;
        check_nested_render_pass_capabilities(context)
    }

    fn programs(&self) -> BinaryCollection {
        CONDITIONAL_CLEAR_ATTACHMENTS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConditionalClearAttachmentTest {
            context,
            conditional_data: self.conditional_data,
        })
    }
}

/// `ConditionalClearAttachmentTest`. Upstream builds the base class in the constructor; its GPU work moves into `iterate` here.
struct ConditionalClearAttachmentTest<'a> {
    context: &'a Context<'a>,
    conditional_data: ConditionalData,
}

impl TestInstance for ConditionalClearAttachmentTest<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let cd = self.conditional_data;

        let base = DrawTestsBase::new_default(
            context,
            "vert",
            "frag",
            GroupParams::default(),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vec![VertexElementData::new([0.0; 4], [0.0; 4], 0)],
        )?;
        let secondary_cmd_buffer = allocate_command_buffer(device, *base.cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let nested_cmd_buffer = allocate_command_buffer(device, *base.cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

        let clear_color = RGBA::black().to_vec().m_data;
        let draw_color = RGBA::blue().to_vec().m_data;

        let cmd_buffer = *base.cmd_buffer;
        begin_command_buffer(device, cmd_buffer)?;
        base.pre_render_barriers();
        let use_secondary_cmd_buffer = cd.condition_inherited || cd.condition_in_secondary_command_buffer;
        let subpass_contents = if cd.condition_inherited && !cd.condition_in_secondary_command_buffer {
            vk::SubpassContents::INLINE_AND_SECONDARY_COMMAND_BUFFERS_KHR
        } else if use_secondary_cmd_buffer {
            vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
        } else {
            vk::SubpassContents::INLINE
        };
        base.begin_legacy_render(cmd_buffer, subpass_contents);

        let mut target_cmd_buffer = cmd_buffer;

        if use_secondary_cmd_buffer {
            let mut conditional_rendering_inheritance_info =
                vk::CommandBufferInheritanceConditionalRenderingInfoEXT::builder()
                    .conditional_rendering_enable(cd.condition_inherited);
            let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                .render_pass(base.render_pass_handle())
                .subpass(0)
                .framebuffer(base.framebuffer_handle())
                .occlusion_query_enable(false)
                .push_next(&mut conditional_rendering_inheritance_info);
            let command_buffer_begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance_info);

            if cd.secondary_command_buffer_nested {
                unsafe { device.begin_command_buffer(*nested_cmd_buffer, &command_buffer_begin_info) }
                    .vk_check("vkBeginCommandBuffer")?;
            }
            unsafe { device.begin_command_buffer(*secondary_cmd_buffer, &command_buffer_begin_info) }
                .vk_check("vkBeginCommandBuffer")?;

            target_cmd_buffer = *secondary_cmd_buffer;
        }

        unsafe { device.cmd_bind_pipeline(target_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *base.pipeline) };

        let clear_attachment = vk::ClearAttachment {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            color_attachment: 0,
            clear_value: vk::ClearValue {
                color: vk::ClearColorValue { float32: draw_color },
            },
        };
        let rect = vk::ClearRect {
            rect: vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: base.render_width,
                    height: base.render_height,
                },
            },
            base_array_layer: 0,
            layer_count: 1,
        };

        let conditional_buffer = create_conditional_rendering_buffer(context, &cd, queue, queue_family_index)?;

        if cd.condition_in_secondary_command_buffer {
            begin_conditional_rendering(device, *secondary_cmd_buffer, &conditional_buffer, &cd);
            unsafe {
                device.cmd_clear_attachments(*secondary_cmd_buffer, &[clear_attachment], &[rect]);
                device.cmd_end_conditional_rendering_ext(*secondary_cmd_buffer);
            }
            end_command_buffer(device, *secondary_cmd_buffer)?;
        } else if cd.condition_inherited {
            unsafe { device.cmd_clear_attachments(*secondary_cmd_buffer, &[clear_attachment], &[rect]) };
            end_command_buffer(device, *secondary_cmd_buffer)?;
        }

        if use_secondary_cmd_buffer && cd.secondary_command_buffer_nested {
            unsafe { device.cmd_execute_commands(*nested_cmd_buffer, &[*secondary_cmd_buffer]) };
            end_command_buffer(device, *nested_cmd_buffer)?;
        }

        let executed_cmd_buffer = if cd.secondary_command_buffer_nested {
            *nested_cmd_buffer
        } else {
            *secondary_cmd_buffer
        };

        if cd.condition_in_primary_command_buffer {
            begin_conditional_rendering(device, cmd_buffer, &conditional_buffer, &cd);

            if cd.condition_inherited {
                unsafe { device.cmd_execute_commands(cmd_buffer, &[executed_cmd_buffer]) };
            } else {
                unsafe { device.cmd_clear_attachments(cmd_buffer, &[clear_attachment], &[rect]) };
            }

            unsafe { device.cmd_end_conditional_rendering_ext(cmd_buffer) };
        } else if use_secondary_cmd_buffer {
            unsafe { device.cmd_execute_commands(cmd_buffer, &[executed_cmd_buffer]) };
        }

        base.end_legacy_render(cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;

        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Validation
        let mut reference_frame = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            base.render_width,
            base.render_height,
            1,
        )?;
        let reference_color = if cd.expect_command_execution {
            draw_color
        } else {
            clear_color
        };
        {
            let mut access = reference_frame.get_access();
            for y in 0..base.render_height {
                for x in 0..base.render_width {
                    access.set_pixel(reference_color, x, y, 0);
                }
            }
        }

        let rendered_frame = base.read_color_surface(queue, vk::ImageLayout::GENERAL)?;

        if fuzzy_compare_ok(
            &reference_frame.get_const_access(),
            &rendered_frame.get_const_access(),
            0.05,
        ) != Some(true)
        {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `ConditionalClearAttachmentTests` - the `clear_attachments` group.
pub fn create_conditional_clear_attachment_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("clear_attachments");

    for condition_data in TESTS_DATA.iter() {
        if condition_data.clear_in_render_pass {
            continue;
        }

        let mut conditional_draw_root_group = TestCaseGroup::new(condition_data.to_name());
        conditional_draw_root_group.add_child(Box::new(ConditionalClearAttachmentCase {
            conditional_data: *condition_data,
        }) as Box<dyn TestCase>);
        group.add_child(conditional_draw_root_group);
    }
    group
}
