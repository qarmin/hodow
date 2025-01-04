// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineStencilTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `stencil.no_stencil_att`: the stencil test is enabled (statically or through
// dynamic state) while no stencil attachment exists, which has to leave coverage alone. The shader object variant is not built.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, ExtExtendedDynamicStateExtensionDeviceCommands};

use crate::generated::shaders::pipeline_stencil_no_att::NO_STENCIL_ATT;
use crate::tcu::texture::ChannelOrder;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_framebuffer};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::pipeline::pipeline_util::{
    make_color_depth_render_pass, read_color_attachment, read_depth_attachment, read_stencil_attachment,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const FB_SIZE: u32 = 32;
const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const GEOMETRY_COLOR: [u8; 4] = [0, 0, 255, 255];
const CLEAR_DEPTH: f32 = 0.5;
const GEOMETRY_DEPTH: f32 = 0.75;
const STENCIL_CLEAR: u32 = 255;
const STENCIL_REF: u32 = 128;

/// `NoStencilAttachmentParams`
#[derive(Clone, Copy)]
struct NoStencilAttachmentParams {
    construction: PipelineConstructionType,
    format: vk::Format,
    dynamic_rendering: bool,
    dynamic_enable: bool,
}

/// `NoStencilAttachmentCase::getImageCreateInfo`
fn image_create_info(format: vk::Format) -> vk::ImageCreateInfo {
    let is_depth_stencil = format != COLOR_FORMAT;
    let main_usage = if is_depth_stencil {
        vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
    } else {
        vk::ImageUsageFlags::COLOR_ATTACHMENT
    };
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: FB_SIZE,
            height: FB_SIZE,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(main_usage | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

struct NoStencilAttachmentCase {
    name: String,
    params: NoStencilAttachmentParams,
}

impl TestCase for NoStencilAttachmentCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `NoStencilAttachmentCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_pipeline_construction_requirements(context, self.params.construction)?;

        if self.params.dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        if self.params.dynamic_enable {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }

        let create_info = image_create_info(self.params.format);
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                create_info.format,
                create_info.image_type,
                create_info.tiling,
                create_info.usage,
                create_info.flags,
            )
        };
        match result {
            Ok(_) => Ok(()),
            Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => Err(TestError::NotSupported(
                "Format does not support the required features".to_string(),
            )),
            Err(error) => Err(TestError::Fail(format!(
                "vkGetPhysicalDeviceImageFormatProperties: {error:?}"
            ))),
        }
    }

    fn programs(&self) -> BinaryCollection {
        NO_STENCIL_ATT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NoStencilAttachmentInstance {
            context,
            params: self.params,
        })
    }
}

struct NoStencilAttachmentInstance<'a> {
    context: &'a Context<'a>,
    params: NoStencilAttachmentParams,
}

impl TestInstance for NoStencilAttachmentInstance<'_> {
    /// `NoStencilAttachmentInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let params = self.params;
        let use_dr = params.dynamic_rendering;

        let tcu_ds_format = map_vk_format(params.format)
            .ok_or_else(|| TestError::NotPorted("depth/stencil format without a texture format".to_string()))?;
        let has_stencil = tcu_ds_format.order == ChannelOrder::DS;
        let ds_aspect = if has_stencil {
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::DEPTH
        };
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let ds_srr = make_image_subresource_range(ds_aspect, 0, 1, 0, 1);

        let color_image = ImageWithMemory::new(device, alloc, image_create_info(COLOR_FORMAT), MemoryRequirement::ANY)?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;
        let ds_image = ImageWithMemory::new(device, alloc, image_create_info(params.format), MemoryRequirement::ANY)?;
        let ds_view = make_image_view(device, ds_image.get(), vk::ImageViewType::_2D, params.format, ds_srr)?;

        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: std::mem::size_of::<f32>() as u32,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let render_pass = if use_dr {
            None
        } else {
            Some(make_color_depth_render_pass(
                device,
                COLOR_FORMAT,
                params.format,
                vk::AttachmentLoadOp::CLEAR,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            )?)
        };
        let framebuffer = match &render_pass {
            Some(render_pass) => Some(make_framebuffer(
                device,
                **render_pass,
                &[*color_view, *ds_view],
                FB_SIZE,
                FB_SIZE,
                1,
            )?),
            None => None,
        };

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Depth/stencil state: despite having no stencil attachment the stencil test is enabled in a way that would not preserve the
        // stencil clear value whether the test passes or not.
        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::ZERO)
            .pass_op(vk::StencilOp::DECREMENT_AND_CLAMP)
            .depth_fail_op(vk::StencilOp::INVERT)
            .compare_op(vk::CompareOp::EQUAL)
            .compare_mask(0xFF)
            .write_mask(0xFF)
            .reference(STENCIL_REF)
            .build();

        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(FB_SIZE, FB_SIZE);
        state.depth_stencil.depth_test_enable = vk::TRUE;
        state.depth_stencil.depth_write_enable = vk::TRUE;
        state.depth_stencil.depth_compare_op = vk::CompareOp::GREATER;
        state.depth_stencil.depth_bounds_test_enable = vk::FALSE;
        state.depth_stencil.stencil_test_enable = if params.dynamic_enable { vk::FALSE } else { vk::TRUE };
        state.depth_stencil.front = stencil_op_state;
        state.depth_stencil.back = stencil_op_state;
        state.depth_stencil.min_depth_bounds = 0.0;
        state.depth_stencil.max_depth_bounds = 1.0;
        if params.dynamic_enable {
            state.dynamic_states.push(vk::DynamicState::STENCIL_TEST_ENABLE);
        }
        if use_dr {
            // The lack of a stencil attachment is signalled by VK_FORMAT_UNDEFINED for the stencil format.
            state.rendering_format = Some(COLOR_FORMAT);
            state.depth_rendering_format = params.format;
            state.stencil_rendering_format = vk::Format::UNDEFINED;
        }
        state.construction = params.construction;
        let render_pass_handle = render_pass
            .as_ref()
            .map(|render_pass| **render_pass)
            .unwrap_or_default();
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            render_pass_handle,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let render_area = rect_2d(FB_SIZE, FB_SIZE);
        let clear_color = vk::ClearColorValue { float32: CLEAR_COLOR };
        let clear_ds = vk::ClearDepthStencilValue {
            depth: CLEAR_DEPTH,
            stencil: STENCIL_CLEAR,
        };

        begin_command_buffer(device, cmd)?;
        if use_dr {
            // Cleared by commands rather than by beginRendering, so that the stencil aspect of the image is cleared too when present.
            let pre_clear_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    color_image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    ds_image.get(),
                    ds_srr,
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_clear_barriers,
                );
                device.cmd_clear_color_image(
                    cmd,
                    color_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color,
                    &[color_srr],
                );
                device.cmd_clear_depth_stencil_image(
                    cmd,
                    ds_image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_ds,
                    &[ds_srr],
                );
            }
            let post_clear_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_image.get(),
                    color_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    ds_image.get(),
                    ds_srr,
                ),
            ];
            let dst_stage = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
                | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    dst_stage,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &post_clear_barriers,
                );
            }

            let color_attachment = vk::RenderingAttachmentInfo::builder()
                .image_view(*color_view)
                .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .build();
            let depth_attachment = vk::RenderingAttachmentInfo::builder()
                .image_view(*ds_view)
                .image_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::LOAD)
                .store_op(vk::AttachmentStoreOp::STORE)
                .build();
            let color_attachments = [color_attachment];
            let rendering_info = vk::RenderingInfo::builder()
                .render_area(render_area)
                .layer_count(1)
                .view_mask(0)
                .color_attachments(&color_attachments)
                .depth_attachment(&depth_attachment);
            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
        } else {
            let clear_values = [
                vk::ClearValue { color: clear_color },
                vk::ClearValue {
                    depth_stencil: clear_ds,
                },
            ];
            let framebuffer = framebuffer.as_ref().expect("a render pass case has a framebuffer");
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass_handle)
                .framebuffer(**framebuffer)
                .render_area(render_area)
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };
        }

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_push_constants(
                cmd,
                *pipeline_layout,
                vk::ShaderStageFlags::VERTEX,
                0,
                &GEOMETRY_DEPTH.to_ne_bytes(),
            );
            if params.dynamic_enable {
                device.cmd_set_stencil_test_enable_ext(cmd, true);
            }
            device.cmd_draw(cmd, 3, 1, 0, 0);
            if use_dr {
                device.cmd_end_rendering(cmd);
            } else {
                device.cmd_end_render_pass(cmd);
            }
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let render_size = (FB_SIZE, FB_SIZE);
        let pixel_count = (FB_SIZE * FB_SIZE) as usize;

        // Verify color output.
        let color = read_color_attachment(
            context,
            color_image.get(),
            COLOR_FORMAT,
            render_size,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        if color
            .data()
            .chunks_exact(4)
            .take(pixel_count)
            .any(|pixel| pixel != GEOMETRY_COLOR)
        {
            return Ok(TestStatus::fail(
                "Unexpected color in result buffer; check log for details",
            ));
        }

        // Verify depth, and stencil if available.
        let depth = read_depth_attachment(
            context,
            ds_image.get(),
            params.format,
            render_size,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;
        // Should be good enough for D16, D24 and D32 given the depth values used here.
        let depth_threshold = 0.000025f32;
        {
            let access = depth.get_const_access();
            for y in 0..FB_SIZE {
                for x in 0..FB_SIZE {
                    if (access.get_pix_depth(x, y, 0) - GEOMETRY_DEPTH).abs() > depth_threshold {
                        return Ok(TestStatus::fail(
                            "Unexpected depth in result buffer; check log for details",
                        ));
                    }
                }
            }
        }
        if has_stencil {
            let stencil = read_stencil_attachment(
                context,
                ds_image.get(),
                params.format,
                render_size,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            )?;
            if stencil
                .data()
                .iter()
                .take(pixel_count)
                .any(|&value| u32::from(value) != STENCIL_CLEAR)
            {
                return Ok(TestStatus::fail(
                    "Unexpected stencil in result buffer; check log for details",
                ));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

fn format_case_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::D16_UNORM => "d16_unorm",
        vk::Format::X8_D24_UNORM_PACK32 => "x8_d24_unorm_pack32",
        vk::Format::D32_SFLOAT => "d32_sfloat",
        vk::Format::D16_UNORM_S8_UINT => "d16_unorm_s8_uint",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        _ => "d32_sfloat_s8_uint",
    }
}

/// The `no_stencil_att` group of `createStencilTests`, built for the monolithic and the fast linked library construction types.
pub fn create_no_stencil_att_tests(construction: PipelineConstructionType) -> TestCaseGroup {
    let depth_formats = [
        vk::Format::D16_UNORM,
        vk::Format::X8_D24_UNORM_PACK32,
        vk::Format::D32_SFLOAT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];
    let mut group = TestCaseGroup::new("no_stencil_att");
    for dynamic_rendering in [false, true] {
        let mut rendering_group = TestCaseGroup::new(if dynamic_rendering {
            "dynamic_rendering"
        } else {
            "render_passes"
        });
        for dynamic_enable in [false, true] {
            let mut enable_group = TestCaseGroup::new(if dynamic_enable {
                "dynamic_enable"
            } else {
                "static_enable"
            });
            for format in depth_formats {
                // When using classic render passes, a separate stencil format and image cannot be indicated.
                let has_stencil = map_vk_format(format).is_some_and(|tcu_format| tcu_format.order == ChannelOrder::DS);
                if !dynamic_rendering && has_stencil {
                    continue;
                }
                let params = NoStencilAttachmentParams {
                    construction,
                    format,
                    dynamic_rendering,
                    dynamic_enable,
                };
                enable_group.add_child(Box::new(NoStencilAttachmentCase {
                    name: format_case_name(format).to_string(),
                    params,
                }) as Box<dyn TestCase>);
            }
            rendering_group.add_child(enable_group);
        }
        group.add_child(rendering_group);
    }
    group
}
