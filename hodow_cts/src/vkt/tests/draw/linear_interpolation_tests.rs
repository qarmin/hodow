// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawMultisampleLinearInterpolationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The VK_KHR_portability_subset check of upstream's checkSupport is
// not ported, and each draw is read back through a buffer copy recorded at the end of its command buffer.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::draw_linear_interpolation::{
    LINEAR_INTERPOLATION_NO_OFFSET, LINEAR_INTERPOLATION_OFFSET_MAX, LINEAR_INTERPOLATION_OFFSET_MIN,
};
use crate::tcu::image_compare::float_threshold_compare;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::{ChannelOrder, ChannelType, TestError, TestOutcome, TestStatus, TextureFormat};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_subresource_layers, make_image_subresource_range,
    make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{GroupParams, create_host_buffer};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, clear_color_image, create_draw_pipeline, end_rendering, rect_2d,
};
use crate::vkt::tests::draw::{initial_transition_color_2d_image, transition_2d_image};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Offset {
    None,
    Min,
    Max,
}

struct MultisampleLinearInterpolationTestCase {
    name: String,
    render_size: (u32, u32),
    interpolation_range: f32,
    offset: Offset,
    sample_count_flag_bits: vk::SampleCountFlags,
    group_params: GroupParams,
}

impl TestCase for MultisampleLinearInterpolationTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MultisampleLinearInterpolationTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: sampleRateShading".to_string(),
            ));
        }

        if !context
            .get_device_properties()
            .limits
            .framebuffer_color_sample_counts
            .intersects(self.sample_count_flag_bits)
        {
            return Err(TestError::NotSupported(format!(
                "Multisampling with {} samples not supported",
                self.sample_count_flag_bits.bits()
            )));
        }

        if self.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.offset {
            Offset::None => LINEAR_INTERPOLATION_NO_OFFSET.programs,
            Offset::Min => LINEAR_INTERPOLATION_OFFSET_MIN.programs,
            Offset::Max => LINEAR_INTERPOLATION_OFFSET_MAX.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampleLinearInterpolationTestInstance {
            context,
            render_size: self.render_size,
            interpolation_range: self.interpolation_range,
            sample_count_flag_bits: self.sample_count_flag_bits,
            group_params: self.group_params,
        })
    }
}

struct MultisampleLinearInterpolationTestInstance<'a> {
    context: &'a Context<'a>,
    render_size: (u32, u32),
    interpolation_range: f32,
    sample_count_flag_bits: vk::SampleCountFlags,
    group_params: GroupParams,
}

/// The copy of a colour image already in TRANSFER_SRC_OPTIMAL into `buffer`, visible to the host.
fn copy_transfer_src_image_to_buffer(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    width: u32,
    height: u32,
) {
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let to_transfer = vk::MemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
        .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
        .build();
    let to_host = vk::MemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::HOST_READ)
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[to_transfer],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[copy_region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

impl MultisampleLinearInterpolationTestInstance<'_> {
    /// One iteration of the `draw` loop of `iterate`: draw 0 is the reference shape, draw 1 the one under test.
    fn draw(&self, draw: usize) -> Result<Vec<u8>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let dynamic_rendering = self.group_params.use_dynamic_rendering;
        let image_color_format = vk::Format::R8G8B8A8_UNORM;
        let (width, height) = self.render_size;
        let sample_count = self.sample_count_flag_bits;
        let use_multisampling = sample_count != vk::SampleCountFlags::_1;
        let range = self.interpolation_range;

        let vert_shader_names = ["vertRef", "vertNoPer"];
        let frag_shader_names = ["fragRef", "fragNoPer"];
        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get(vert_shader_names[draw])?)?;
        let fs = create_shader_module(device, binaries.get(frag_shader_names[draw])?)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // Create color buffer images
        let target_image_extent = vk::Extent3D {
            width,
            height,
            depth: 1,
        };
        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let image_info = |samples: vk::SampleCountFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(image_color_format)
                .extent(target_image_extent)
                .mip_levels(1)
                .array_layers(1)
                .samples(samples)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };
        let color_target_image = ImageWithMemory::new(
            device,
            alloc,
            image_info(vk::SampleCountFlags::_1),
            MemoryRequirement::ANY,
        )?;
        let multisample_image = if use_multisampling {
            Some(ImageWithMemory::new(
                device,
                alloc,
                image_info(sample_count),
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_target_view = make_image_view(
            device,
            color_target_image.get(),
            vk::ImageViewType::_2D,
            image_color_format,
            subresource_range,
        )?;
        let multisample_view = match &multisample_image {
            Some(image) => Some(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                image_color_format,
                subresource_range,
            )?),
            None => None,
        };

        // Create render pass and frame buffer.
        let (render_pass, framebuffer) = if dynamic_rendering {
            (None, None)
        } else {
            let mut attachments = vec![
                vk::AttachmentDescription::builder()
                    .format(image_color_format)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                    .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                    .build(),
            ];
            let mut attachment_views = vec![*color_target_view];
            let color_attachment_refs = [vk::AttachmentReference {
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];
            let multisample_attachment_refs = [vk::AttachmentReference {
                attachment: 1,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            }];

            if let Some(view) = &multisample_view {
                attachments.push(
                    vk::AttachmentDescription::builder()
                        .format(image_color_format)
                        .samples(sample_count)
                        .load_op(vk::AttachmentLoadOp::CLEAR)
                        .store_op(vk::AttachmentStoreOp::DONT_CARE)
                        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                        .initial_layout(vk::ImageLayout::UNDEFINED)
                        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                        .build(),
                );
                attachment_views.push(**view);
            }

            let mut subpass = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
            subpass = if use_multisampling {
                subpass
                    .color_attachments(&multisample_attachment_refs)
                    .resolve_attachments(&color_attachment_refs)
            } else {
                subpass.color_attachments(&color_attachment_refs)
            };
            let subpasses = [subpass.build()];
            let render_pass_info = vk::RenderPassCreateInfo::builder()
                .attachments(&attachments)
                .subpasses(&subpasses);
            let render_pass = Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
            );
            let framebuffer = make_framebuffer(device, *render_pass, &attachment_views, width, height, 1)?;
            (Some(render_pass), Some(framebuffer))
        };
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |pass| **pass);
        let framebuffer_handle = framebuffer
            .as_ref()
            .map_or_else(vk::Framebuffer::null, |framebuffer| **framebuffer);

        // Create vertex buffer.
        //
        // The first draw is for reference image.
        //      ____            ____
        //     /    \          |    |
        //    /      \         |____|
        //   /        \
        //  /__________\
        //
        //     result        reference
        //
        // In result shape the bottom vertices are deeper. When the drawn result image is a perfect square,
        // and color comparison with reference image is easy to make.
        let deep = if draw == 0 { 1.0f32 } else { 2.0 };
        let vertices: [[f32; 8]; 6] = [
            [1.0, -1.0, 0.0, 1.0, /* Color */ 0.0, range, 0.0, range], // Top Right
            [
                -1.0,
                -1.0,
                0.0,
                1.0,
                /* Color */ range * 0.5,
                range * 0.5,
                0.0,
                range,
            ], // Top Left
            [
                deep,
                deep,
                0.0,
                deep,
                /* Color */ range * 0.5,
                range * 0.5,
                0.0,
                range,
            ], // Bottom Right
            [-deep, deep, 0.0, deep, /* Color */ range, 0.0, 0.0, range], // Bottom Left
            [
                deep,
                deep,
                0.0,
                deep,
                /* Color */ range * 0.5,
                range * 0.5,
                0.0,
                range,
            ], // Bottom Right
            [
                -1.0,
                -1.0,
                0.0,
                1.0,
                /* Color */ range * 0.5,
                range * 0.5,
                0.0,
                range,
            ], // Top Left
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Create pipeline.
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(width, height);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
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
        state.samples = sample_count;
        state.sample_shading = false;
        state.min_sample_shading = 0.0;
        state.sample_mask = Some(0xfffffff);
        if dynamic_rendering {
            state.rendering_format = Some(image_color_format);
        }
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            render_pass_handle,
            &[
                (vk::ShaderStageFlags::VERTEX, *vs),
                (vk::ShaderStageFlags::FRAGMENT, *fs),
            ],
            &state,
        )?;

        // Draw quad and read results.
        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue {
                float32: [0.0, 0.0, 0.0, 1.0],
            },
        };
        let render_area = rect_2d(width, height);
        let frame_buffer_size = (width * height * 4) as usize;
        let frame_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(frame_buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let draw_commands = |cmd: vk::CommandBuffer| unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_draw(cmd, 6, 1, 0, 0);
        };

        clear_color_image(
            context,
            color_target_image.get(),
            [0.0, 0.0, 0.0, 1.0],
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            1,
            1,
        )?;

        if dynamic_rendering {
            let pre_render_barriers = |cmd: vk::CommandBuffer| {
                // VUID-vkCmdDraw-None-09600
                initial_transition_color_2d_image(
                    device,
                    cmd,
                    color_target_image.get(),
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    1,
                );

                if let Some(image) = &multisample_image {
                    // VUID-vkCmdDraw-None-09600
                    initial_transition_color_2d_image(
                        device,
                        cmd,
                        image.get(),
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        1,
                    );
                }
            };

            let begin_rendering = |cmd: vk::CommandBuffer, flags: vk::RenderingFlags| {
                let mut color_attachment = vk::RenderingAttachmentInfo::builder()
                    .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(clear_color);
                color_attachment = match &multisample_view {
                    Some(view) => color_attachment
                        .image_view(**view)
                        .resolve_mode(vk::ResolveModeFlags::AVERAGE)
                        .resolve_image_view(*color_target_view),
                    None => color_attachment.image_view(*color_target_view),
                };
                let color_attachments = [color_attachment.build()];
                let rendering_info = vk::RenderingInfo::builder()
                    .flags(flags)
                    .render_area(render_area)
                    .layer_count(1)
                    .view_mask(0)
                    .color_attachments(&color_attachments);
                unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
            };

            let mut sec_cmd_buffers = Vec::new();
            if self.group_params.use_secondary_cmd_buffer {
                let sec_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
                let sec = *sec_cmd_buffer;
                sec_cmd_buffers.push(sec_cmd_buffer);
                let contains = self
                    .group_params
                    .secondary_cmd_buffer_completely_contains_dynamic_renderpass;

                let color_formats = [image_color_format];
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(if contains {
                        vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
                    } else {
                        vk::RenderingFlags::empty()
                    })
                    .view_mask(0)
                    .color_attachment_formats(&color_formats)
                    .depth_attachment_format(vk::Format::UNDEFINED)
                    .stencil_attachment_format(vk::Format::UNDEFINED)
                    .rasterization_samples(sample_count);
                let inheritance_info =
                    vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
                let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
                if !contains {
                    usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
                }
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(usage_flags)
                    .inheritance_info(&inheritance_info);

                // record secondary command buffer
                unsafe { device.begin_command_buffer(sec, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
                if contains {
                    begin_rendering(sec, vk::RenderingFlags::empty());
                }

                draw_commands(sec);

                if contains {
                    end_rendering(device, sec);
                }
                end_command_buffer(device, sec)?;

                // record primary command buffer
                begin_command_buffer(device, *cmd_buffer)?;

                pre_render_barriers(*cmd_buffer);

                if !contains {
                    begin_rendering(*cmd_buffer, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
                }
                unsafe { device.cmd_execute_commands(*cmd_buffer, &[sec]) };

                if !contains {
                    end_rendering(device, *cmd_buffer);
                }
            } else {
                begin_command_buffer(device, *cmd_buffer)?;
                pre_render_barriers(*cmd_buffer);

                begin_rendering(*cmd_buffer, vk::RenderingFlags::empty());
                draw_commands(*cmd_buffer);
                end_rendering(device, *cmd_buffer);
            }

            // Transition color image to transfer src for readback
            transition_2d_image(
                device,
                *cmd_buffer,
                color_target_image.get(),
                vk::ImageAspectFlags::COLOR,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
        } else {
            let clear_values = [clear_color, clear_color];
            let images_count = 1 + multisample_view.iter().count();

            begin_command_buffer(device, *cmd_buffer)?;

            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass_handle)
                .framebuffer(framebuffer_handle)
                .render_area(render_area)
                .clear_values(&clear_values[..images_count]);
            unsafe { device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
            draw_commands(*cmd_buffer);
            unsafe { device.cmd_end_render_pass(*cmd_buffer) };
        }

        copy_transfer_src_image_to_buffer(
            device,
            *cmd_buffer,
            color_target_image.get(),
            frame_buffer.get(),
            width,
            height,
        );
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        invalidate_alloc(device, frame_buffer.get_allocation())?;
        let frame =
            unsafe { std::slice::from_raw_parts(frame_buffer.get_allocation().get_host_ptr(), frame_buffer_size) };
        Ok(frame.to_vec())
    }
}

impl TestInstance for MultisampleLinearInterpolationTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let (width, height) = self.render_size;
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);

        let reference = self.draw(0)?;
        let result = self.draw(1)?;

        let reference_access = ConstPixelBufferAccess::new(format, [width, height, 1], &reference);
        let result_access = ConstPixelBufferAccess::new(format, [width, height, 1], &result);

        if !float_threshold_compare(&reference_access, &result_access, [0.005; 4]).ok {
            return Ok(TestStatus::fail("Rendered color image is not correct"));
        }

        Ok(TestStatus::pass("Success"))
    }
}

/// `createMultisampleLinearInterpolationTests`
pub fn create_multisample_linear_interpolation_tests(group_params: GroupParams) -> TestCaseGroup {
    // Tests for linear interpolation decorations.
    let mut group = TestCaseGroup::new("linear_interpolation");

    let offsets = [
        ("no_offset", Offset::None),
        ("offset_min", Offset::Min),
        ("offset_max", Offset::Max),
    ];
    let flag_bits = [
        ("1_sample", vk::SampleCountFlags::_1),
        ("2_samples", vk::SampleCountFlags::_2),
        ("4_samples", vk::SampleCountFlags::_4),
        ("8_samples", vk::SampleCountFlags::_8),
        ("16_samples", vk::SampleCountFlags::_16),
        ("32_samples", vk::SampleCountFlags::_32),
        ("64_samples", vk::SampleCountFlags::_64),
    ];

    for (offset_name, offset) in offsets {
        for (flag_bit_name, flag_bit) in flag_bits {
            // reduce number of tests for dynamic rendering cases where secondary command buffer is used
            if group_params.use_secondary_cmd_buffer && flag_bit.bits() > vk::SampleCountFlags::_4.bits() {
                break;
            }

            group.add_child(Box::new(MultisampleLinearInterpolationTestCase {
                name: format!("{offset_name}_{flag_bit_name}"),
                render_size: (16, 16),
                interpolation_range: 1.0,
                offset,
                sample_count_flag_bits: flag_bit,
                group_params,
            }) as Box<dyn TestCase>);
        }
    }
    group
}
