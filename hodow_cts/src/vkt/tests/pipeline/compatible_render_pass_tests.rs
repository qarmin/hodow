// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleTests.cpp (CompatibleRenderPassTest, the
//   `compatible_render_pass` group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only.
//
// A pipeline created against a render pass with one multisampled colour attachment is used in a render pass that also resolves
// it (the two are compatible), over every dynamic state the case enables.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtExtendedDynamicStateExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::pipeline_compatible_render_pass::COMPATIBLE_RENDER_PASS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const SIZE: u32 = 32;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

struct CompatibleRenderPassCase {
    name: &'static str,
    dynamic: bool,
}

impl TestCase for CompatibleRenderPassCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        COMPATIBLE_RENDER_PASS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CompatibleRenderPassInstance {
            context,
            dynamic: self.dynamic,
        })
    }
}

struct CompatibleRenderPassInstance<'a> {
    context: &'a Context<'a>,
    dynamic: bool,
}

impl TestInstance for CompatibleRenderPassInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        compatible_render_pass_iterate(self.context, self.dynamic)
    }
}

fn make_image<'a>(context: &'a Context<'a>, samples: vk::SampleCountFlags) -> Result<ImageWithMemory<'a>, TestError> {
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(vk::Extent3D {
            width: SIZE,
            height: SIZE,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        info,
        MemoryRequirement::ANY,
    )
}

fn attachment_description(samples: vk::SampleCountFlags, store_op: vk::AttachmentStoreOp) -> vk::AttachmentDescription {
    vk::AttachmentDescription {
        flags: vk::AttachmentDescriptionFlags::empty(),
        format: COLOR_FORMAT,
        samples,
        load_op: vk::AttachmentLoadOp::CLEAR,
        store_op,
        stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
        stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
        initial_layout: vk::ImageLayout::UNDEFINED,
        final_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }
}

/// `CompatibleRenderPassTestInstance::iterate`
fn compatible_render_pass_iterate<'a>(context: &'a Context<'a>, dynamic: bool) -> TestOutcome {
    let device = context.get_device();
    let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

    let color_attachment = make_image(context, vk::SampleCountFlags::_4)?;
    let resolve_attachment = make_image(context, vk::SampleCountFlags::_1)?;
    let color_image_view = make_image_view(
        device,
        color_attachment.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        color_range,
    )?;
    let resolve_image_view = make_image_view(
        device,
        resolve_attachment.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        color_range,
    )?;

    let attachment_descriptions = [
        attachment_description(vk::SampleCountFlags::_4, vk::AttachmentStoreOp::STORE),
        attachment_description(vk::SampleCountFlags::_1, vk::AttachmentStoreOp::STORE),
    ];
    let color_attachment_reference = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let resolve_attachment_reference = [vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];

    let subpass_with_resolve = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_attachment_reference)
        .resolve_attachments(&resolve_attachment_reference)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions)
        .subpasses(&subpass_with_resolve);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );

    let framebuffer_attachments = [*color_image_view, *resolve_image_view];
    let framebuffer_info = vk::FramebufferCreateInfo::builder()
        .render_pass(*render_pass)
        .attachments(&framebuffer_attachments)
        .width(SIZE)
        .height(SIZE)
        .layers(1);
    let framebuffer = Unique::new(
        device,
        unsafe { device.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
    );

    // The compatible render pass has the colour attachment alone.
    let subpass_without_resolve = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_attachment_reference)
        .build()];
    let compatible_render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descriptions[..1])
        .subpasses(&subpass_without_resolve);
    let compatible_render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&compatible_render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let mut eds_features = vk::PhysicalDeviceExtendedDynamicStateFeaturesEXT::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    let extended_dynamic_state = eds_features.extended_dynamic_state != vk::FALSE;

    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(SIZE, SIZE);
    state.samples = vk::SampleCountFlags::_4;
    if dynamic {
        state.dynamic_states = vec![
            vk::DynamicState::VIEWPORT,
            vk::DynamicState::SCISSOR,
            vk::DynamicState::DEPTH_BIAS,
            vk::DynamicState::BLEND_CONSTANTS,
            vk::DynamicState::DEPTH_BOUNDS,
            vk::DynamicState::STENCIL_COMPARE_MASK,
            vk::DynamicState::STENCIL_WRITE_MASK,
            vk::DynamicState::STENCIL_REFERENCE,
        ];
        if extended_dynamic_state {
            state.dynamic_states.extend([
                vk::DynamicState::CULL_MODE,
                vk::DynamicState::DEPTH_BOUNDS_TEST_ENABLE,
                vk::DynamicState::DEPTH_COMPARE_OP,
                vk::DynamicState::DEPTH_TEST_ENABLE,
                vk::DynamicState::DEPTH_WRITE_ENABLE,
                vk::DynamicState::FRONT_FACE,
                vk::DynamicState::PRIMITIVE_TOPOLOGY,
                vk::DynamicState::STENCIL_OP,
                vk::DynamicState::STENCIL_TEST_ENABLE,
            ]);
            // The viewport and the scissor are dynamic anyway, so the pipeline states only their count.
            state.viewports.clear();
            state.scissors.clear();
            state.viewport_count = 1;
        }
    }
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *compatible_render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let clear_values = [
        clear_value_color([0.25, 0.25, 0.25, 1.0]),
        clear_value_color([0.5, 0.5, 0.5, 1.0]),
    ];

    begin_command_buffer(device, cmd)?;
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(SIZE, SIZE))
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);

        if dynamic {
            device.cmd_set_viewport(cmd, 0, &[viewport(0.0, 0.0, SIZE as f32, SIZE as f32, 0.0, 1.0)]);
            device.cmd_set_scissor(cmd, 0, &[rect_2d(SIZE, SIZE)]);
            device.cmd_set_depth_bias(cmd, 0.0, 1.0, 1.0);
            device.cmd_set_blend_constants(cmd, [1.0, 1.0, 1.0, 1.0]);
            device.cmd_set_depth_bounds(cmd, 0.0, 1.0);
            device.cmd_set_stencil_compare_mask(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xff);
            device.cmd_set_stencil_write_mask(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xff);
            device.cmd_set_stencil_reference(cmd, vk::StencilFaceFlags::FRONT_AND_BACK, 0xff);
            if extended_dynamic_state {
                device.cmd_set_cull_mode_ext(cmd, vk::CullModeFlags::NONE);
                device.cmd_set_depth_bounds_test_enable_ext(cmd, false);
                device.cmd_set_depth_compare_op_ext(cmd, vk::CompareOp::ALWAYS);
                device.cmd_set_depth_test_enable_ext(cmd, false);
                device.cmd_set_depth_write_enable_ext(cmd, false);
                device.cmd_set_front_face_ext(cmd, vk::FrontFace::COUNTER_CLOCKWISE);
                device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP);
                device.cmd_set_stencil_op_ext(
                    cmd,
                    vk::StencilFaceFlags::FRONT_AND_BACK,
                    vk::StencilOp::KEEP,
                    vk::StencilOp::KEEP,
                    vk::StencilOp::KEEP,
                    vk::CompareOp::ALWAYS,
                );
                device.cmd_set_stencil_test_enable_ext(cmd, false);
            }
        }

        device.cmd_draw(cmd, 4, 1, 0, 0);
        device.cmd_end_render_pass(cmd);
    }
    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    let color_level = read_color_attachment(
        context,
        resolve_attachment.get(),
        COLOR_FORMAT,
        (SIZE, SIZE),
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    )?;
    let color_access = color_level.get_const_access();
    for y in 0..SIZE {
        for x in 0..SIZE {
            if color_access.get_pixel(x, y, 0) != [1.0, 1.0, 1.0, 1.0] {
                return Ok(TestStatus::fail("Fail"));
            }
        }
    }

    Ok(TestStatus::pass("Passed"))
}

/// The `compatible_render_pass` child of upstream's `multisample` group.
pub(super) fn add_compatible_render_pass_tests(multisample_tests: &mut TestCaseGroup) {
    let mut group = TestCaseGroup::new("compatible_render_pass");
    group.add_child(Box::new(CompatibleRenderPassCase {
        name: "static",
        dynamic: false,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(CompatibleRenderPassCase {
        name: "dynamic",
        dynamic: true,
    }) as Box<dyn TestCase>);
    multisample_tests.add_child(group);
}
