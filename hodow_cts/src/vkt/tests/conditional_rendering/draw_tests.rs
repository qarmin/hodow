// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/conditional_rendering/vktConditionalDrawTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtConditionalRenderingExtensionDeviceCommands, KhrDrawIndirectCountExtensionDeviceCommands};

use crate::generated::shaders::conditional_rendering_draw::CONDITIONAL_DRAW;
use crate::tcu::fuzzy_image_compare::fuzzy_compare_ok;
use crate::tcu::pixel::TextureLevel;
use crate::tcu::{ChannelOrder, ChannelType, RGBA, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_framebuffer};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vk::ref_util::Unique;
use crate::vkt::tests::conditional_rendering::test_util::{
    ConditionalData, TESTS_DATA, begin_conditional_rendering, check_conditional_rendering_capabilities,
    check_nested_render_pass_capabilities, create_conditional_rendering_buffer,
};
use crate::vkt::tests::draw::base_class::{DrawTestsBase, GroupParams, ReferenceImageCoordinates, VertexElementData};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `DrawCommandType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawCommandType {
    Draw,
    DrawIndexed,
    DrawIndirect,
    DrawIndexedIndirect,
    DrawIndirectCount,
    DrawIndexedIndirectCount,
}

const ALL_DRAW_COMMAND_TYPES: [DrawCommandType; 6] = [
    DrawCommandType::Draw,
    DrawCommandType::DrawIndexed,
    DrawCommandType::DrawIndirect,
    DrawCommandType::DrawIndexedIndirect,
    DrawCommandType::DrawIndirectCount,
    DrawCommandType::DrawIndexedIndirectCount,
];

/// `getDrawCommandTypeName`
fn get_draw_command_type_name(command: DrawCommandType) -> &'static str {
    match command {
        DrawCommandType::Draw => "draw",
        DrawCommandType::DrawIndexed => "draw_indexed",
        DrawCommandType::DrawIndirect => "draw_indirect",
        DrawCommandType::DrawIndexedIndirect => "draw_indexed_indirect",
        DrawCommandType::DrawIndirectCount => "draw_indirect_count",
        DrawCommandType::DrawIndexedIndirectCount => "draw_indexed_indirect_count",
    }
}

/// `ConditionalTestSpec`
#[derive(Clone, Copy)]
struct ConditionalTestSpec {
    command: DrawCommandType,
    draw_calls: u32,
    conditional_data: ConditionalData,
}

struct ConditionalDrawCase {
    name: &'static str,
    test_spec: ConditionalTestSpec,
}

impl TestCase for ConditionalDrawCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let spec = &self.test_spec;
        check_conditional_rendering_capabilities(context, &spec.conditional_data)?;
        check_nested_render_pass_capabilities(context)?;

        if spec.command == DrawCommandType::DrawIndirectCount
            || spec.command == DrawCommandType::DrawIndexedIndirectCount
        {
            context.require_device_functionality("VK_KHR_draw_indirect_count")?;
        }

        if spec.conditional_data.condition_inherited && !spec.conditional_data.condition_in_secondary_command_buffer {
            context.require_device_functionality("VK_KHR_maintenance7")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        CONDITIONAL_DRAW.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConditionalDraw {
            context,
            spec: self.test_spec,
        })
    }
}

/// `ConditionalDraw`. The base class is built in `iterate` instead of the constructor.
struct ConditionalDraw<'a> {
    context: &'a Context<'a>,
    spec: ConditionalTestSpec,
}

/// A host-visible buffer holding a copy of `data`, flushed (`Draw::Buffer::createAndAlloc` + `deMemcpy` + `flushAlloc`).
fn create_host_buffer<'a, T: Copy>(
    context: &'a Context<'a>,
    data: &[T],
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = std::mem::size_of_val(data) as vk::DeviceSize;
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            data.as_ptr().cast::<u8>(),
            buffer.get_allocation().get_host_ptr(),
            size as usize,
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

impl<'a> ConditionalDraw<'a> {
    /// The vertex data the constructor pushes into `m_data`.
    fn build_vertex_data(draw_calls: u32) -> Vec<VertexElementData> {
        let blue = RGBA::blue().to_vec().m_data;
        let red = RGBA::red().to_vec().m_data;
        let mut data = Vec::new();

        let min_x = -0.3f32;
        let max_x = 0.3f32;
        let draw_step = 0.6f32 / draw_calls as f32;

        for draw_idx in 0..draw_calls {
            let min_y = min_x + draw_idx as f32 * draw_step;
            let max_y = min_y + draw_step;

            data.push(VertexElementData::new([min_x, max_y, 0.5, 1.0], blue, 0));
            data.push(VertexElementData::new([min_x, min_y, 0.5, 1.0], blue, 0));
            data.push(VertexElementData::new([max_x, max_y, 0.5, 1.0], blue, 0));

            data.push(VertexElementData::new([min_x, min_y, 0.5, 1.0], blue, 0));
            data.push(VertexElementData::new([max_x, max_y, 0.5, 1.0], blue, 0));
            data.push(VertexElementData::new([max_x, min_y, 0.5, 1.0], blue, 0));
        }

        data.push(VertexElementData::new([-1.0, 1.0, 0.0, 1.0], red, 0));
        data.push(VertexElementData::new([-1.0, -1.0, 0.0, 1.0], red, 0));
        data.push(VertexElementData::new([1.0, 1.0, 0.0, 1.0], red, 0));

        data.push(VertexElementData::new([-1.0, -1.0, 0.0, 1.0], red, 0));
        data.push(VertexElementData::new([1.0, 1.0, 0.0, 1.0], red, 0));
        data.push(VertexElementData::new([1.0, -1.0, 0.0, 1.0], red, 0));
        data
    }

    /// `createRenderPassWithClear`
    fn create_render_pass_with_clear(
        &self,
        base: &DrawTestsBase<'a>,
    ) -> Result<(Unique<'a, vk::RenderPass>, Unique<'a, vk::Framebuffer>), TestError> {
        let device = self.context.get_device();

        let attachments = [vk::AttachmentDescription::builder()
            .format(base.color_attachment_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR) // Clear with the render pass.
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::STORE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::GENERAL)
            .build()];
        let color_attachment_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::GENERAL)
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

        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*base.color_target_view],
            base.render_width,
            base.render_height,
            1,
        )?;
        Ok((render_pass, framebuffer))
    }

    /// `recordDraw`
    fn record_draw(
        &self,
        cmd_buffer: vk::CommandBuffer,
        indirect_buffer: Option<&BufferWithMemory<'_>>,
        indirect_count_buffer: Option<&BufferWithMemory<'_>>,
    ) {
        let device = self.context.get_device();

        for draw_idx in 0..self.spec.draw_calls {
            // Indirect buffer has next layout: goodCommand badCommand badCommand goodCommand badCommand badCommand ...
            let indirect_offset =
                (std::mem::size_of::<vk::DrawIndirectCommand>() as vk::DeviceSize) * draw_idx as vk::DeviceSize * 3;
            let indexed_indirect_offset = (std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as vk::DeviceSize)
                * draw_idx as vk::DeviceSize
                * 3;
            unsafe {
                match self.spec.command {
                    DrawCommandType::Draw => device.cmd_draw(cmd_buffer, 6, 1, 6 * draw_idx, 0),
                    DrawCommandType::DrawIndexed => device.cmd_draw_indexed(cmd_buffer, 6, 1, 6 * draw_idx, 0, 0),
                    DrawCommandType::DrawIndirect => device.cmd_draw_indirect(
                        cmd_buffer,
                        indirect_buffer.expect("indirect buffer").get(),
                        indirect_offset,
                        1,
                        0,
                    ),
                    DrawCommandType::DrawIndexedIndirect => device.cmd_draw_indexed_indirect(
                        cmd_buffer,
                        indirect_buffer.expect("indirect buffer").get(),
                        indexed_indirect_offset,
                        1,
                        0,
                    ),
                    DrawCommandType::DrawIndirectCount => device.cmd_draw_indirect_count_khr(
                        cmd_buffer,
                        indirect_buffer.expect("indirect buffer").get(),
                        indirect_offset,
                        indirect_count_buffer.expect("indirect count buffer").get(),
                        0,
                        3,
                        std::mem::size_of::<vk::DrawIndirectCommand>() as u32,
                    ),
                    DrawCommandType::DrawIndexedIndirectCount => device.cmd_draw_indexed_indirect_count_khr(
                        cmd_buffer,
                        indirect_buffer.expect("indirect buffer").get(),
                        indexed_indirect_offset,
                        indirect_count_buffer.expect("indirect count buffer").get(),
                        0,
                        3,
                        std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32,
                    ),
                }
            }
        }
    }

    /// `createAndBindIndexBuffer`
    fn create_and_bind_index_buffer(
        &self,
        cmd_buffer: vk::CommandBuffer,
        indexes: &[u32],
    ) -> Result<BufferWithMemory<'a>, TestError> {
        let buffer = create_host_buffer(self.context, indexes, vk::BufferUsageFlags::INDEX_BUFFER)?;
        unsafe {
            self.context
                .get_device()
                .cmd_bind_index_buffer(cmd_buffer, buffer.get(), 0, vk::IndexType::UINT32)
        };
        Ok(buffer)
    }

    /// `createIndirectBuffer`
    fn create_indirect_buffer(&self) -> Result<BufferWithMemory<'a>, TestError> {
        let draw_calls = self.spec.draw_calls;
        let bad_draw_command = vk::DrawIndirectCommand {
            vertex_count: 6,
            instance_count: 1,
            first_vertex: draw_calls * 6,
            first_instance: 0,
        };

        let mut draw_commands = Vec::new();
        for draw_idx in 0..draw_calls {
            let good_draw_command = vk::DrawIndirectCommand {
                vertex_count: 6,
                instance_count: 1,
                first_vertex: 6 * draw_idx,
                first_instance: 0,
            };

            draw_commands.push(good_draw_command);
            // *Bad* commands should not be rendered by vkCmdDrawIndirectCountKHR
            draw_commands.push(bad_draw_command);
            draw_commands.push(bad_draw_command);
        }
        create_host_buffer(self.context, &draw_commands, vk::BufferUsageFlags::INDIRECT_BUFFER)
    }

    /// `createIndexedIndirectBuffer`
    fn create_indexed_indirect_buffer(&self) -> Result<BufferWithMemory<'a>, TestError> {
        let draw_calls = self.spec.draw_calls;
        let bad_draw_command = vk::DrawIndexedIndirectCommand {
            index_count: 6,
            instance_count: 1,
            first_index: draw_calls * 6,
            vertex_offset: 0,
            first_instance: 0,
        };

        let mut draw_commands = Vec::new();
        for draw_idx in 0..draw_calls {
            let good_draw_command = vk::DrawIndexedIndirectCommand {
                index_count: 6,
                instance_count: 1,
                first_index: 6 * draw_idx,
                vertex_offset: 0,
                first_instance: 0,
            };

            draw_commands.push(good_draw_command);
            // *Bad* commands should not be rendered by vkCmdDrawIndexedIndirectCountKHR
            draw_commands.push(bad_draw_command);
            draw_commands.push(bad_draw_command);
        }
        create_host_buffer(self.context, &draw_commands, vk::BufferUsageFlags::INDIRECT_BUFFER)
    }

    /// `createIndirectCountBuffer`
    fn create_indirect_count_buffer(&self) -> Result<BufferWithMemory<'a>, TestError> {
        create_host_buffer(self.context, &[1u32], vk::BufferUsageFlags::INDIRECT_BUFFER)
    }
}

impl TestInstance for ConditionalDraw<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let spec = self.spec;
        let cd = spec.conditional_data;

        debug_assert!(!(cd.clear_in_render_pass && cd.condition_in_secondary_command_buffer));

        let data = Self::build_vertex_data(spec.draw_calls);
        let indexes: Vec<u32> = (0..data.len() as u32).collect();
        let base = DrawTestsBase::new_default(
            context,
            "vert",
            "frag",
            GroupParams::default(),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            data,
        )?;

        let rp_with_clear = if cd.clear_in_render_pass {
            Some(self.create_render_pass_with_clear(&base)?)
        } else {
            None
        };

        let secondary_cmd_buffer = allocate_command_buffer(device, *base.cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let nested_cmd_buffer = allocate_command_buffer(device, *base.cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

        // We will clear to a different color to be sure.
        let clear_color = if cd.clear_in_render_pass {
            RGBA::white().to_vec().m_data
        } else {
            RGBA::black().to_vec().m_data
        };

        let conditional_buffer = create_conditional_rendering_buffer(context, &cd, queue, queue_family_index)?;

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

        if let Some((render_pass, framebuffer)) = &rp_with_clear {
            // When clearing in the render pass we want to check the render pass clear is executed properly.
            begin_conditional_rendering(device, cmd_buffer, &conditional_buffer, &cd);
            let clear_values = [vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            }];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(**render_pass)
                .framebuffer(**framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: base.render_width,
                        height: base.render_height,
                    },
                })
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd_buffer, &begin_info, subpass_contents) };
        } else {
            base.begin_legacy_render(cmd_buffer, subpass_contents);
        }

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

        unsafe {
            device.cmd_bind_vertex_buffers(
                target_cmd_buffer,
                0,
                &[base.vertex_buffer.as_ref().expect("vertex buffer").get()],
                &[0],
            )
        };

        // Kept alive until the submission has finished.
        let mut _index_buffer = None;
        let mut indirect_buffer = None;
        let mut indirect_count_buffer = None;

        match spec.command {
            DrawCommandType::Draw => {}
            DrawCommandType::DrawIndexed => {
                _index_buffer = Some(self.create_and_bind_index_buffer(target_cmd_buffer, &indexes)?)
            }
            DrawCommandType::DrawIndirect => indirect_buffer = Some(self.create_indirect_buffer()?),
            DrawCommandType::DrawIndexedIndirect => {
                _index_buffer = Some(self.create_and_bind_index_buffer(target_cmd_buffer, &indexes)?);
                indirect_buffer = Some(self.create_indexed_indirect_buffer()?);
            }
            DrawCommandType::DrawIndirectCount => {
                indirect_buffer = Some(self.create_indirect_buffer()?);
                indirect_count_buffer = Some(self.create_indirect_count_buffer()?);
            }
            DrawCommandType::DrawIndexedIndirectCount => {
                _index_buffer = Some(self.create_and_bind_index_buffer(target_cmd_buffer, &indexes)?);
                indirect_buffer = Some(self.create_indexed_indirect_buffer()?);
                indirect_count_buffer = Some(self.create_indirect_count_buffer()?);
            }
        }

        unsafe { device.cmd_bind_pipeline(target_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *base.pipeline) };

        if cd.condition_in_secondary_command_buffer {
            begin_conditional_rendering(device, *secondary_cmd_buffer, &conditional_buffer, &cd);
            self.record_draw(
                *secondary_cmd_buffer,
                indirect_buffer.as_ref(),
                indirect_count_buffer.as_ref(),
            );
            unsafe { device.cmd_end_conditional_rendering_ext(*secondary_cmd_buffer) };
            end_command_buffer(device, *secondary_cmd_buffer)?;
        } else if cd.condition_inherited {
            self.record_draw(
                *secondary_cmd_buffer,
                indirect_buffer.as_ref(),
                indirect_count_buffer.as_ref(),
            );
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
            if !cd.clear_in_render_pass {
                begin_conditional_rendering(device, cmd_buffer, &conditional_buffer, &cd);
            }

            if cd.condition_inherited {
                unsafe { device.cmd_execute_commands(cmd_buffer, &[executed_cmd_buffer]) };
            } else {
                self.record_draw(cmd_buffer, indirect_buffer.as_ref(), indirect_count_buffer.as_ref());
            }

            if !cd.clear_in_render_pass {
                unsafe { device.cmd_end_conditional_rendering_ext(cmd_buffer) };
            }
        } else if use_secondary_cmd_buffer {
            unsafe { device.cmd_execute_commands(cmd_buffer, &[executed_cmd_buffer]) };
        }

        if cd.clear_in_render_pass {
            // Finish conditional rendering outside the render pass.
            unsafe {
                device.cmd_end_render_pass(cmd_buffer);
                device.cmd_end_conditional_rendering_ext(cmd_buffer);
            }
        } else {
            base.end_legacy_render(cmd_buffer);
        }

        end_command_buffer(device, cmd_buffer)?;

        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Validation
        let mut reference_frame = TextureLevel::new(
            TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
            base.render_width,
            base.render_height,
            1,
        )?;
        let frame_width = base.render_width;
        let frame_height = base.render_height;

        let draw_color = RGBA::blue().to_vec().m_data;
        let reference_color = if cd.expect_command_execution {
            draw_color
        } else {
            clear_color
        };
        let ref_coords = ReferenceImageCoordinates::default();

        {
            let mut access = reference_frame.get_access();
            for y in 0..frame_height {
                for x in 0..frame_width {
                    access.set_pixel(clear_color, x, y, 0);
                }
            }

            for y in 0..frame_height {
                let y_coord = (y as f64 / (0.5 * frame_height as f64)) as f32 - 1.0;

                for x in 0..frame_width {
                    let x_coord = (x as f64 / (0.5 * frame_width as f64)) as f32 - 1.0;

                    if f64::from(y_coord) >= ref_coords.bottom
                        && f64::from(y_coord) <= ref_coords.top
                        && f64::from(x_coord) >= ref_coords.left
                        && f64::from(x_coord) <= ref_coords.right
                    {
                        access.set_pixel(reference_color, x, y, 0);
                    }
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

/// `ConditionalDrawTests` - the `draw` group.
pub fn create_conditional_draw_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("draw");

    for condition_data in TESTS_DATA.iter() {
        let mut conditional_draw_root_group = TestCaseGroup::new(condition_data.to_name());

        for command in ALL_DRAW_COMMAND_TYPES {
            let test_spec = ConditionalTestSpec {
                command,
                draw_calls: 4,
                conditional_data: *condition_data,
            };
            conditional_draw_root_group.add_child(Box::new(ConditionalDrawCase {
                name: get_draw_command_type_name(command),
                test_spec,
            }) as Box<dyn TestCase>);
        }
        group.add_child(conditional_draw_root_group);
    }
    group
}
