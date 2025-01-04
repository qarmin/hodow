// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/dynamic_state/vktDynamicStateClearTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `image`: a clear, a blit, a copy or a resolve after the dynamic states have been set must not disturb them. The
// states are set on a command buffer, a transfer command or `vkCmdClearAttachments` follows, and a line is drawn.
// `ResolveTestInstance` sets `m_samples` after `initialize()` and the image it resolves from is never written; the render
// pass then clears the target, so the resolve has no effect on the verdict, which is kept as it is upstream.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::dynamic_state_vertex_fetch::VERTEX_FETCH;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::image_util::{ImageWithMemory, make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::MemoryRequirement;
use crate::vkt::tests::draw::transition_2d_image;
use crate::vkt::tests::dynamic_state::base_class::{
    BaseConfig, DepthStencilDynamicState, DynamicStateBase, GREEN, HEIGHT, PositionColorVertex, StateTestCase, WIDTH,
    build_reference_frame_by_pixel,
};
use crate::vkt::{Context, TestCase, TestCaseGroup};

#[derive(Clone, Copy, PartialEq, Eq)]
enum Command {
    Clear,
    Blit,
    Copy,
    Resolve,
}

/// `checkSupport(context, samples)`
fn check_sample_count_support(context: &Context<'_>, samples: vk::SampleCountFlags) -> Result<(), TestError> {
    let usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let properties = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            vk::Format::R8G8B8A8_UNORM,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    };
    match properties {
        Ok(properties) if properties.sample_counts.contains(samples) => Ok(()),
        _ => Err(TestError::NotSupported("Color image type not supported".to_string())),
    }
}

fn common_check_support(context: &Context<'_>) -> Result<(), TestError> {
    check_sample_count_support(context, vk::SampleCountFlags::_1)
}

fn resolve_check_support(context: &Context<'_>) -> Result<(), TestError> {
    check_sample_count_support(context, vk::SampleCountFlags::_2)
}

fn color_layers() -> vk::ImageSubresourceLayers {
    vk::ImageSubresourceLayers {
        aspect_mask: vk::ImageAspectFlags::COLOR,
        mip_level: 0,
        base_array_layer: 0,
        layer_count: 1,
    }
}

/// `CmdBaseCase::iterate` with `command` and `buildReferenceFrame` of the given variant.
fn cmd_base_run<'a>(context: &'a Context<'a>, command: Command) -> TestOutcome {
    let device = context.get_device();
    let samples = if command == Command::Resolve {
        vk::SampleCountFlags::_2
    } else {
        vk::SampleCountFlags::_1
    };

    // CmdBaseCase::CmdBaseCase
    let data = vec![
        PositionColorVertex::new([0.0, 0.0, 1.0, 1.0], GREEN),
        PositionColorVertex::new([1.0, 0.0, 1.0, 1.0], GREEN),
    ];
    let mut config = BaseConfig::new("vert", "frag", vk::PrimitiveTopology::LINE_LIST, data);
    config.blend_attachment = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(true)
        .src_color_blend_factor(vk::BlendFactor::ONE_MINUS_CONSTANT_COLOR)
        .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_CONSTANT_COLOR)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ONE_MINUS_CONSTANT_ALPHA)
        .dst_alpha_blend_factor(vk::BlendFactor::ONE_MINUS_CONSTANT_ALPHA)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build();
    let base = DynamicStateBase::new(context, config)?;

    let line_width = context.get_device_properties().limits.line_width_range[1];

    crate::vk::cmd_util::begin_command_buffer(device, base.cmd())?;

    // set dynamic states
    let viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: (WIDTH / 2) as f32,
        height: (HEIGHT / 2) as f32,
        min_depth: 0.0,
        max_depth: 0.0,
    };
    let scissor = vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D {
            width: WIDTH,
            height: HEIGHT,
        },
    };

    base.set_dynamic_viewport_state_array(&[viewport], &[scissor]);
    base.set_dynamic_rasterization_state(line_width, 0.0, 0.0, 0.0);
    base.set_dynamic_blend_state([0.75, 0.75, 0.75, 0.75]);
    base.set_dynamic_depth_stencil_state(DepthStencilDynamicState::default());

    let image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(base.color_attachment_format)
        .extent(vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSFER_SRC
                | vk::ImageUsageFlags::TRANSFER_DST,
        )
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        image_info,
        MemoryRequirement::ANY,
    )?;

    let to_general = |image: vk::Image, dst_access: vk::AccessFlags| {
        transition_2d_image(
            device,
            base.cmd(),
            image,
            vk::ImageAspectFlags::COLOR,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::empty(),
            dst_access,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            1,
        )
    };
    if samples != vk::SampleCountFlags::_1 {
        to_general(image.get(), vk::AccessFlags::TRANSFER_WRITE);
        to_general(base.color_target_image.get(), vk::AccessFlags::TRANSFER_READ);
    } else {
        to_general(base.color_target_image.get(), vk::AccessFlags::TRANSFER_WRITE);
        to_general(image.get(), vk::AccessFlags::TRANSFER_READ);
    }

    let extent = vk::Extent3D {
        width: WIDTH,
        height: HEIGHT,
        depth: 1,
    };
    let offset = vk::Offset3D { x: 0, y: 0, z: 0 };

    // should not interfere with dynamic state
    record_command(&base, image.get(), command, false, extent, offset);

    base.begin_render_pass_with_clear_color([0.0, 0.0, 0.0, 1.0], true, true)?;

    record_command(&base, image.get(), command, true, extent, offset);

    base.bind_pipeline(0);

    base.bind_vertex_buffer();

    unsafe { device.cmd_draw(base.cmd(), 2, 1, 0, 0) };

    base.end_and_submit()?;

    // validation
    let reference_frame = build_reference_frame(command, line_width as i32)?;
    base.verify_against(&reference_frame)
}

/// `command(renderPassActive)` of the four variants.
fn record_command(
    base: &DynamicStateBase<'_>,
    image: vk::Image,
    command: Command,
    render_pass_active: bool,
    extent: vk::Extent3D,
    offset: vk::Offset3D,
) {
    let device = base.context.get_device();
    let cmd = base.cmd();
    let color_target = base.color_target_image.get();

    match command {
        Command::Clear => {
            if render_pass_active {
                // Clear attachment
                let clear_attachment = vk::ClearAttachment {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    color_attachment: 0,
                    clear_value: vk::ClearValue {
                        color: vk::ClearColorValue {
                            float32: [1.0, 1.0, 1.0, 1.0],
                        },
                    },
                };
                let rect = vk::ClearRect {
                    rect: vk::Rect2D {
                        offset: vk::Offset2D { x: 0, y: 0 },
                        extent: vk::Extent2D {
                            width: WIDTH,
                            height: HEIGHT,
                        },
                    },
                    base_array_layer: 0,
                    layer_count: 1,
                };
                unsafe { device.cmd_clear_attachments(cmd, &[clear_attachment], &[rect]) };
            }
        }
        Command::Blit => {
            if !render_pass_active {
                let blit_region = vk::ImageBlit {
                    src_subresource: color_layers(),
                    src_offsets: [
                        offset,
                        vk::Offset3D {
                            x: WIDTH as i32,
                            y: HEIGHT as i32,
                            z: 1,
                        },
                    ],
                    dst_subresource: color_layers(),
                    dst_offsets: [
                        offset,
                        vk::Offset3D {
                            x: WIDTH as i32,
                            y: HEIGHT as i32,
                            z: 1,
                        },
                    ],
                };
                unsafe {
                    device.cmd_blit_image(
                        cmd,
                        color_target,
                        vk::ImageLayout::GENERAL,
                        image,
                        vk::ImageLayout::GENERAL,
                        &[blit_region],
                        vk::Filter::NEAREST,
                    )
                };
            }
        }
        Command::Copy => {
            if !render_pass_active {
                let copy_region = vk::ImageCopy {
                    src_subresource: color_layers(),
                    src_offset: offset,
                    dst_subresource: color_layers(),
                    dst_offset: offset,
                    extent,
                };
                unsafe {
                    device.cmd_copy_image(
                        cmd,
                        color_target,
                        vk::ImageLayout::GENERAL,
                        image,
                        vk::ImageLayout::GENERAL,
                        &[copy_region],
                    )
                };
            }
        }
        Command::Resolve => {
            if !render_pass_active {
                let resolve_region = vk::ImageResolve {
                    src_subresource: color_layers(),
                    src_offset: offset,
                    dst_subresource: color_layers(),
                    dst_offset: offset,
                    extent,
                };
                unsafe {
                    device.cmd_resolve_image(
                        cmd,
                        image,
                        vk::ImageLayout::GENERAL,
                        color_target,
                        vk::ImageLayout::GENERAL,
                        &[resolve_region],
                    )
                };

                let image_barrier = make_image_memory_barrier(
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::GENERAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    image,
                    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::ALL_COMMANDS,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[image_barrier],
                    );
                }
            }
        }
    }
}

/// `buildReferenceFrame(lineWidth)` of the four variants.
fn build_reference_frame(command: Command, line_width: i32) -> Result<crate::tcu::pixel::TextureLevel, TestError> {
    let frame_width = WIDTH as i32;
    let frame_height = HEIGHT as i32;

    build_reference_frame_by_pixel(|x, y| {
        let on_line = y < frame_height / 2
            && y >= 32 - line_width / 2
            && y < 32 + line_width / 2
            && x >= frame_width / 4
            && x < frame_width / 2;
        match command {
            // The clear attachment wipes the target to white and the line is blended over it.
            Command::Clear => {
                if on_line {
                    [0.25, 0.5, 0.25, 0.5]
                } else {
                    [1.0, 1.0, 1.0, 1.0]
                }
            }
            _ => {
                if on_line {
                    [0.0, 0.25, 0.0, 0.5]
                } else {
                    [0.0, 0.0, 0.0, 1.0]
                }
            }
        }
    })
}

fn clear_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    cmd_base_run(context, Command::Clear)
}

fn blit_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    cmd_base_run(context, Command::Blit)
}

fn copy_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    cmd_base_run(context, Command::Copy)
}

fn resolve_run<'a>(context: &'a Context<'a>) -> TestOutcome {
    cmd_base_run(context, Command::Resolve)
}

/// `DynamicStateClearTests`
pub fn create_clear_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("image");

    // Clear attachment after setting dynamic states
    group.add_child(Box::new(StateTestCase {
        name: "clear",
        programs: VERTEX_FETCH.programs,
        support: common_check_support,
        run: clear_run,
    }) as Box<dyn TestCase>);
    // Blit image after setting dynamic states
    group.add_child(Box::new(StateTestCase {
        name: "blit",
        programs: VERTEX_FETCH.programs,
        support: common_check_support,
        run: blit_run,
    }) as Box<dyn TestCase>);
    // Copy image after setting dynamic states
    group.add_child(Box::new(StateTestCase {
        name: "copy",
        programs: VERTEX_FETCH.programs,
        support: common_check_support,
        run: copy_run,
    }) as Box<dyn TestCase>);
    // Resolve image after setting dynamic states
    group.add_child(Box::new(StateTestCase {
        name: "resolve",
        programs: VERTEX_FETCH.programs,
        support: resolve_check_support,
        run: resolve_run,
    }) as Box<dyn TestCase>);

    group
}
