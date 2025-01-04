// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingLocalReadTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `MappingWithBlendStateTestInstance` (mapping_not_affecting_blend_state),
// `FeedbackLoopTestInstance` (feedback_loop, feedback_loop_msaa) and `FragShaderOnlyColorTestInstance` (frag_shader_only_color). The pipelines are
// monolithic and built without `GraphicsPipelineWrapper`, and the image logs are dropped.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrDynamicRenderingLocalReadExtensionDeviceCommands};

use super::dynamic_rendering_local_read_basic_tests::{
    PipelineSetup, begin_secondary_rendering_buffer, make_pipeline, ptr_or_null, write_input_attachment,
    write_storage_buffer,
};
use crate::generated::shaders::renderpass_local_read_basic::{
    LRB_BLEND, LRB_FEEDBACK_LOOP, LRB_FEEDBACK_LOOP_MSAA, LRB_FRAG_ONLY_COLOR,
};
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::random::Random;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_memory_barrier, make_pipeline_layout, make_pipeline_layout_with_push_constants,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::rect_2d;
use crate::vkt::{Context, TestCase, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum ExtraType {
    BlendState,
    FeedbackLoop,
    FeedbackLoopMsaa,
    FragShaderOnlyColor,
}

pub(super) struct ExtraLocalReadTestCase {
    pub(super) name: &'static str,
    pub(super) test_type: ExtraType,
    pub(super) secondary: bool,
}

impl TestCase for ExtraLocalReadTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `LocalReadTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_dynamic_rendering_local_read")
    }

    fn programs(&self) -> BinaryCollection {
        match self.test_type {
            ExtraType::BlendState => LRB_BLEND.programs,
            ExtraType::FeedbackLoop => LRB_FEEDBACK_LOOP.programs,
            ExtraType::FeedbackLoopMsaa => LRB_FEEDBACK_LOOP_MSAA.programs,
            ExtraType::FragShaderOnlyColor => LRB_FRAG_ONLY_COLOR.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ExtraLocalReadTestInstance {
            context,
            test_type: self.test_type,
            secondary: self.secondary,
        })
    }
}

struct ExtraLocalReadTestInstance<'a> {
    context: &'a Context<'a>,
    test_type: ExtraType,
    secondary: bool,
}

impl TestInstance for ExtraLocalReadTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.test_type {
            ExtraType::BlendState => run_blend_state(self.context, self.secondary),
            ExtraType::FeedbackLoop => run_feedback_loop(self.context, false, self.secondary),
            ExtraType::FeedbackLoopMsaa => run_feedback_loop(self.context, true, self.secondary),
            ExtraType::FragShaderOnlyColor => run_frag_shader_only_color(self.context, self.secondary),
        }
    }
}

fn create_image<'a>(
    context: &'a Context<'_>,
    size: u32,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
    samples: vk::SampleCountFlags,
) -> Result<ImageWithMemory<'a>, TestError> {
    let create_info = vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format,
        extent: vk::Extent3D {
            width: size,
            height: size,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    };
    ImageWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        create_info,
        MemoryRequirement::ANY,
    )
}

fn make_attachment_info(
    view: vk::ImageView,
    layout: vk::ImageLayout,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    clear_value: vk::ClearValue,
) -> vk::RenderingAttachmentInfo {
    vk::RenderingAttachmentInfo {
        s_type: vk::StructureType::RENDERING_ATTACHMENT_INFO,
        next: std::ptr::null(),
        image_view: view,
        image_layout: layout,
        resolve_mode: vk::ResolveModeFlags::NONE,
        resolve_image_view: vk::ImageView::null(),
        resolve_image_layout: vk::ImageLayout::UNDEFINED,
        load_op,
        store_op,
        clear_value,
    }
}

fn rendering_info(
    render_area: vk::Rect2D,
    color_attachments: &[vk::RenderingAttachmentInfo],
    secondary: bool,
) -> vk::RenderingInfo {
    vk::RenderingInfo {
        s_type: vk::StructureType::RENDERING_INFO,
        next: std::ptr::null(),
        flags: if secondary {
            vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS
        } else {
            vk::RenderingFlags::empty()
        },
        render_area,
        layer_count: 1,
        view_mask: 0,
        color_attachment_count: color_attachments.len() as u32,
        color_attachments: ptr_or_null(color_attachments),
        depth_attachment: std::ptr::null(),
        stencil_attachment: std::ptr::null(),
    }
}

fn image_barriers(
    device: &Device,
    cmd: vk::CommandBuffer,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    barriers: &[vk::ImageMemoryBarrier],
) {
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            barriers,
        )
    };
}

fn input_attachment_to_color_read_barrier(device: &Device, cmd: vk::CommandBuffer) {
    let barrier = make_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::INPUT_ATTACHMENT_READ,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            vk::DependencyFlags::BY_REGION,
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };
}

fn color_blend_attachment(
    blend_enable: bool,
    src_color: vk::BlendFactor,
    dst_color: vk::BlendFactor,
    color_op: vk::BlendOp,
    src_alpha: vk::BlendFactor,
    dst_alpha: vk::BlendFactor,
    alpha_op: vk::BlendOp,
) -> vk::PipelineColorBlendAttachmentState {
    vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::Bool32::from(blend_enable),
        src_color_blend_factor: src_color,
        dst_color_blend_factor: dst_color,
        color_blend_op: color_op,
        src_alpha_blend_factor: src_alpha,
        dst_alpha_blend_factor: dst_alpha,
        alpha_blend_op: alpha_op,
        color_write_mask: vk::ColorComponentFlags::all(),
    }
}

fn location_info(count: u32, locations: *const u32) -> vk::RenderingAttachmentLocationInfo {
    vk::RenderingAttachmentLocationInfo {
        s_type: vk::StructureType::RENDERING_ATTACHMENT_LOCATION_INFO,
        next: std::ptr::null(),
        color_attachment_count: count,
        color_attachment_locations: locations,
    }
}

fn default_depth_stencil() -> vk::PipelineDepthStencilStateCreateInfo {
    vk::PipelineDepthStencilStateCreateInfo::default()
}

/// `MappingWithBlendStateTestInstance::iterate`
fn run_blend_state(context: &Context<'_>, secondary: bool) -> TestOutcome {
    use vk::{BlendFactor as F, BlendOp as O};

    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let render_size = 16u32;
    let image_format = vk::Format::R8G8B8A8_UNORM;
    let texture_format =
        map_vk_format(image_format).ok_or_else(|| TestError::InternalError("no texture format".to_string()))?;
    let color_attachment_count = 4usize;

    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_sl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: render_size,
            height: render_size,
            depth: 1,
        },
        color_sl,
    );

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    // blend src color
    let clear_values: [[f32; 4]; 4] = [
        [0.5, 0.5, 0.4, 1.0],
        [0.2, 0.4, 0.3, 0.1],
        [0.2, 1.0, 0.5, 0.8],
        [1.0, 0.1, 0.3, 0.5],
    ];

    let color_blend_attachment_states = [
        color_blend_attachment(
            true,
            F::SRC_ALPHA,
            F::DST_ALPHA,
            O::ADD,
            F::SRC_ALPHA,
            F::DST_ALPHA,
            O::MAX,
        ),
        color_blend_attachment(
            true,
            F::ONE,
            F::ONE_MINUS_DST_ALPHA,
            O::SUBTRACT,
            F::ONE_MINUS_SRC_ALPHA,
            F::DST_ALPHA,
            O::ADD,
        ),
        color_blend_attachment(true, F::ONE, F::ONE, O::MIN, F::SRC_ALPHA, F::DST_ALPHA, O::MAX),
        color_blend_attachment(
            true,
            F::SRC_COLOR,
            F::DST_COLOR,
            O::MAX,
            F::SRC_ALPHA,
            F::DST_ALPHA,
            O::MIN,
        ),
    ];

    let color_attachment_locations = [3u32, 0, 2, 1];

    let output_buffer_size = u64::from(render_size * render_size) * 4;

    let mut images: Vec<ImageWithMemory<'_>> = Vec::new();
    let mut views: Vec<Unique<'_, vk::ImageView>> = Vec::new();
    let mut output_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
    let mut color_attachments: Vec<vk::RenderingAttachmentInfo> = Vec::new();
    for clear_value in clear_values {
        // create images and image views for the attachments
        let image = create_image(
            context,
            render_size,
            image_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            vk::SampleCountFlags::_1,
        )?;
        let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, image_format, color_srr)?;
        color_attachments.push(make_attachment_info(
            *view,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_value },
            },
        ));
        views.push(view);
        images.push(image);

        // create output buffers that will be used to get the attachments data
        output_buffers.push(BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                output_buffer_size,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?);
    }

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let color_formats = vec![image_format; color_attachment_count];
    let rendering_attachment_locations =
        location_info(color_attachment_count as u32, color_attachment_locations.as_ptr());
    let graphics_pipeline = make_pipeline(
        device,
        &PipelineSetup {
            layout: *pipeline_layout,
            vert: *vert_shader,
            frag: *frag_shader,
            color_formats: &color_formats,
            depth_format: vk::Format::UNDEFINED,
            stencil_format: vk::Format::UNDEFINED,
            blend_states: &color_blend_attachment_states,
            samples: vk::SampleCountFlags::_1,
            sample_shading: false,
            depth_stencil: default_depth_stencil(),
            dynamic_state: None,
            location_info: Some(rendering_attachment_locations),
            input_index_info: None,
        },
    )?;

    let render_area = rect_2d(render_size, render_size);
    let info = rendering_info(render_area, &color_attachments, secondary);

    let secondary_buffer = if secondary {
        let buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let mut locations = rendering_attachment_locations;
        locations.next = std::ptr::null();
        begin_secondary_rendering_buffer(
            device,
            *buffer,
            (&raw const locations).cast(),
            &color_formats,
            vk::Format::UNDEFINED,
            vk::Format::UNDEFINED,
            vk::SampleCountFlags::_1,
        )?;
        unsafe {
            device.cmd_bind_pipeline(*buffer, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline.get());
            device.cmd_draw(*buffer, 4, 1, 0, 0);
        }
        end_command_buffer(device, *buffer)?;
        Some(buffer)
    } else {
        None
    };

    begin_command_buffer(device, cmd)?;

    // transfer layout to color attachment optimal
    let mut barriers: Vec<vk::ImageMemoryBarrier> = images
        .iter()
        .map(|image| {
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                image.get(),
                color_srr,
            )
        })
        .collect();
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::empty(),
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        &barriers,
    );

    unsafe {
        device.cmd_begin_rendering(cmd, &info);

        // remapping should affect to which attachments the shader writes but not the blend state
        device.cmd_set_rendering_attachment_locations_khr(cmd, &rendering_attachment_locations);

        match &secondary_buffer {
            Some(buffer) => device.cmd_execute_commands(cmd, &[**buffer]),
            None => {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline.get());
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
        }
        device.cmd_end_rendering(cmd);
    }

    // transition the color buffers layout to transfer source optimal
    for barrier in &mut barriers {
        barrier.src_access_mask = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        barrier.dst_access_mask = vk::AccessFlags::TRANSFER_READ;
        barrier.old_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
        barrier.new_layout = vk::ImageLayout::TRANSFER_SRC_OPTIMAL;
    }
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        &barriers,
    );

    // read back the color images
    for (image, buffer) in images.iter().zip(&output_buffers) {
        unsafe {
            device.cmd_copy_image_to_buffer(
                cmd,
                image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer.get(),
                &[copy_region],
            )
        };
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    let expected_left_side_colors: [[f32; 4]; 4] = [
        [0.50, 0.98, 0.72, 1.00],
        [0.42, 0.44, 0.63, 0.17],
        [0.10, 0.30, 0.50, 0.80],
        [1.00, 0.40, 0.30, 0.50],
    ];

    let color_precision = 0.05f32;
    let differs = |a: [f32; 4], b: [f32; 4]| a.iter().zip(b).any(|(x, y)| (x - y).abs() > color_precision);

    let mut test_passed = true;
    for (i, buffer) in output_buffers.iter().enumerate() {
        let allocation = buffer.get_allocation();
        invalidate_alloc(device, allocation)?;

        let bytes = unsafe {
            std::slice::from_raw_parts(
                allocation.get_host_ptr().cast_const(),
                (render_size * render_size * 4) as usize,
            )
        };
        let output_access = ConstPixelBufferAccess::new(texture_format, [render_size, render_size, 1], bytes);

        // check one fragment from the left side of the image (after blending)
        let i_coord = i as u32;
        let left = output_access.get_pixel(i_coord, i_coord, 0);
        // check one fragment from the right side of the image (the clear color should be there)
        let right = output_access.get_pixel(render_size - 1 - i_coord, render_size - 1 - i_coord, 0);

        if differs(left, expected_left_side_colors[i]) || differs(right, clear_values[i]) {
            test_passed = false;
        }
    }

    if test_passed {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

/// `FragShaderOnlyColorTestInstance::iterate`
fn run_frag_shader_only_color(context: &Context<'_>, secondary: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let render_size = 16u32;

    let image_format = vk::Format::R32_UINT;
    let color_attachment_count = 4u32;
    let input_attachment_count = color_attachment_count - 1;
    let exported_attachment = (color_attachment_count - 1) as usize;
    let unused = vk::ATTACHMENT_UNUSED;

    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_sl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let copy_region = make_buffer_image_copy(
        vk::Extent3D {
            width: render_size,
            height: render_size,
            depth: 1,
        },
        color_sl,
    );

    let written_values = [1u32, 10, 100];
    let write_locations = [2u32, 0, 1, unused];
    let input_indices = [1u32, 2, 0, unused];
    let read_locations = [unused, unused, unused, 0u32];

    let value_per_attachment: Vec<u32> = write_locations
        .iter()
        .map(|&location| {
            if location != unused {
                written_values[location as usize]
            } else {
                0
            }
        })
        .collect();

    let mut expected_value = 0u32;
    for att_index in 0..color_attachment_count as usize {
        if input_indices[att_index] != unused {
            expected_value += (input_indices[att_index] + 1) * value_per_attachment[att_index];
        }
    }

    let clear_value = vk::ClearValue {
        color: vk::ClearColorValue { uint32: [0; 4] },
    };
    let image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::INPUT_ATTACHMENT
        | vk::ImageUsageFlags::TRANSFER_SRC;

    let mut images: Vec<ImageWithMemory<'_>> = Vec::new();
    let mut views: Vec<Unique<'_, vk::ImageView>> = Vec::new();
    let mut color_attachments: Vec<vk::RenderingAttachmentInfo> = Vec::new();
    for _ in 0..color_attachment_count {
        let image = create_image(
            context,
            render_size,
            image_format,
            image_usage,
            vk::SampleCountFlags::_1,
        )?;
        let view = make_image_view(device, image.get(), vk::ImageViewType::_2D, image_format, color_srr)?;
        color_attachments.push(make_attachment_info(
            *view,
            vk::ImageLayout::RENDERING_LOCAL_READ,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            clear_value,
        ));
        views.push(view);
        images.push(image);
    }

    let output_buffer_size = u64::from(render_size * render_size) * 4;
    let output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::INPUT_ATTACHMENT, input_attachment_count)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let mut set_layout_builder = DescriptorSetLayoutBuilder::new();
    for _ in 0..input_attachment_count {
        set_layout_builder =
            set_layout_builder.add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT);
    }
    let descriptor_set_layout = set_layout_builder.build(device)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    for att_index in 0..color_attachment_count as usize {
        if input_indices[att_index] == unused {
            continue;
        }
        write_input_attachment(
            device,
            descriptor_set.get(),
            input_indices[att_index],
            *views[att_index],
        );
    }

    let write_pipeline_layout = make_pipeline_layout(device, &[])?;
    let read_pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let write_frag_shader = create_shader_module(device, binaries.get("frag0")?)?;
    let read_frag_shader = create_shader_module(device, binaries.get("frag1")?)?;

    let color_blend_attachment_states = vec![
        vk::PipelineColorBlendAttachmentState {
            color_write_mask: vk::ColorComponentFlags::all(),
            ..Default::default()
        };
        color_attachment_count as usize
    ];

    let write_location_info = location_info(color_attachment_count, write_locations.as_ptr());
    let read_location_info = location_info(color_attachment_count, read_locations.as_ptr());
    let read_input_index_info = vk::RenderingInputAttachmentIndexInfo {
        s_type: vk::StructureType::RENDERING_INPUT_ATTACHMENT_INDEX_INFO,
        next: std::ptr::null(),
        color_attachment_count,
        color_attachment_input_indices: input_indices.as_ptr(),
        depth_input_attachment_index: std::ptr::null(),
        stencil_input_attachment_index: std::ptr::null(),
    };

    let color_formats = vec![image_format; color_attachment_count as usize];
    let write_pipeline = make_pipeline(
        device,
        &PipelineSetup {
            layout: *write_pipeline_layout,
            vert: *vert_shader,
            frag: *write_frag_shader,
            color_formats: &color_formats,
            depth_format: vk::Format::UNDEFINED,
            stencil_format: vk::Format::UNDEFINED,
            blend_states: &color_blend_attachment_states,
            samples: vk::SampleCountFlags::_1,
            sample_shading: false,
            depth_stencil: default_depth_stencil(),
            dynamic_state: None,
            location_info: Some(write_location_info),
            input_index_info: None,
        },
    )?;
    let read_pipeline = make_pipeline(
        device,
        &PipelineSetup {
            layout: *read_pipeline_layout,
            vert: *vert_shader,
            frag: *read_frag_shader,
            color_formats: &color_formats,
            depth_format: vk::Format::UNDEFINED,
            stencil_format: vk::Format::UNDEFINED,
            blend_states: &color_blend_attachment_states,
            samples: vk::SampleCountFlags::_1,
            sample_shading: false,
            depth_stencil: default_depth_stencil(),
            dynamic_state: None,
            location_info: Some(read_location_info),
            input_index_info: Some(read_input_index_info),
        },
    )?;

    let render_area = rect_2d(render_size, render_size);
    let info = rendering_info(render_area, &color_attachments, secondary);

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let record_write = |cmd: vk::CommandBuffer| unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, write_pipeline.get());
        device.cmd_draw(cmd, 4, 1, 0, 0);
    };
    let record_read = |cmd: vk::CommandBuffer| unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, read_pipeline.get());
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            *read_pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_draw(cmd, 4, 1, 0, 0);
    };

    let mut write_secondary = None;
    let mut read_secondary = None;
    if secondary {
        let buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        begin_secondary_rendering_buffer(
            device,
            *buffer,
            (&raw const write_location_info).cast(),
            &color_formats,
            vk::Format::UNDEFINED,
            vk::Format::UNDEFINED,
            vk::SampleCountFlags::_1,
        )?;
        record_write(*buffer);
        end_command_buffer(device, *buffer)?;
        write_secondary = Some(buffer);

        // the read secondary command buffer inherits the location info followed by the input attachment index info
        let mut read_inheritance_location_info = read_location_info;
        read_inheritance_location_info.next = (&raw const read_input_index_info).cast();
        let buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        begin_secondary_rendering_buffer(
            device,
            *buffer,
            (&raw const read_inheritance_location_info).cast(),
            &color_formats,
            vk::Format::UNDEFINED,
            vk::Format::UNDEFINED,
            vk::SampleCountFlags::_1,
        )?;
        record_read(*buffer);
        end_command_buffer(device, *buffer)?;
        read_secondary = Some(buffer);
    }

    begin_command_buffer(device, cmd)?;

    let barriers: Vec<vk::ImageMemoryBarrier> = images
        .iter()
        .map(|image| {
            make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::RENDERING_LOCAL_READ,
                image.get(),
                color_srr,
            )
        })
        .collect();
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        &barriers,
    );

    unsafe {
        device.cmd_begin_rendering(cmd, &info);

        device.cmd_set_rendering_attachment_locations_khr(cmd, &write_location_info);
    }
    match &write_secondary {
        Some(buffer) => unsafe { device.cmd_execute_commands(cmd, &[**buffer]) },
        None => record_write(cmd),
    }

    input_attachment_to_color_read_barrier(device, cmd);

    unsafe {
        device.cmd_set_rendering_attachment_locations_khr(cmd, &read_location_info);
        device.cmd_set_rendering_input_attachment_indices_khr(cmd, &read_input_index_info);
    }
    match &read_secondary {
        Some(buffer) => unsafe { device.cmd_execute_commands(cmd, &[**buffer]) },
        None => record_read(cmd),
    }
    unsafe { device.cmd_end_rendering(cmd) };

    let copy_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::RENDERING_LOCAL_READ,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        images[exported_attachment].get(),
        color_srr,
    );
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        &[copy_barrier],
    );
    unsafe {
        device.cmd_copy_image_to_buffer(
            cmd,
            images[exported_attachment].get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            output_buffer.get(),
            &[copy_region],
        )
    };

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    let allocation = output_buffer.get_allocation();
    invalidate_alloc(device, allocation)?;

    let values = unsafe {
        std::slice::from_raw_parts(
            allocation.get_host_ptr().cast_const().cast::<u32>(),
            (render_size * render_size) as usize,
        )
    };
    if let Some((index, value)) = values.iter().enumerate().find(|&(_, &value)| value != expected_value) {
        log::info!("Result for exported attachment: expected {expected_value} got {value} at index {index}");
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `FeedbackLoopTestInstance::iterate`
fn run_feedback_loop(context: &Context<'_>, is_msaa_test: bool, secondary: bool) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let image_format = vk::Format::R8G8B8A8_UNORM;
    // 1024 size is required to trigger delta color compression
    let image_size = 1024u32;
    let extent = vk::Extent3D {
        width: image_size,
        height: image_size,
        depth: 1,
    };
    let msaa_samples = if is_msaa_test {
        vk::SampleCountFlags::_4
    } else {
        vk::SampleCountFlags::_1
    };

    let srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let sl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
    let copy_region = make_buffer_image_copy(extent, sl);

    // generate noise that will be used as the input attachment
    let mut rnd = Random::new(1234);
    let mut procedural_data = vec![0u8; (image_size * image_size * 4) as usize];
    for data in &mut procedural_data {
        let value = rnd.get_uint8();
        // make sure there is no 0.5 in the shader so verification is easier; if v is too close to 127 then just subtract 50 from it
        *data = value.wrapping_sub(50 * u8::from(value > 125 && value < 129));
    }

    let image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
        | vk::ImageUsageFlags::INPUT_ATTACHMENT
        | vk::ImageUsageFlags::TRANSFER_DST
        | vk::ImageUsageFlags::TRANSFER_SRC;
    let image_with_memory = create_image(context, image_size, image_format, image_usage, vk::SampleCountFlags::_1)?;
    let image_view = make_image_view(
        device,
        image_with_memory.get(),
        vk::ImageViewType::_2D,
        image_format,
        srr,
    )?;

    let msaa_image_with_memory = if is_msaa_test {
        Some(create_image(
            context,
            image_size,
            image_format,
            image_usage,
            msaa_samples,
        )?)
    } else {
        None
    };
    let msaa_image_view = match &msaa_image_with_memory {
        Some(image) => Some(make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            image_format,
            srr,
        )?),
        None => None,
    };

    let buffer_size = u64::from(image_size * image_size * 4);
    let buffer_with_memory = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            buffer_size,
            vk::BufferUsageFlags::TRANSFER_DST
                | vk::BufferUsageFlags::TRANSFER_SRC
                | vk::BufferUsageFlags::STORAGE_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let allocation = buffer_with_memory.get_allocation();
    unsafe {
        std::ptr::copy_nonoverlapping(
            procedural_data.as_ptr(),
            allocation.get_host_ptr(),
            procedural_data.len(),
        )
    };
    flush_alloc(device, allocation)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let render_area = rect_2d(image_size, image_size);

    // setup the descriptor set with a single input attachment
    let msaa_init_descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let msaa_init_descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let msaa_init_descriptor_set =
        make_descriptor_set(device, *msaa_init_descriptor_pool, *msaa_init_descriptor_set_layout)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
    write_storage_buffer(device, msaa_init_descriptor_set.get(), buffer_with_memory.get());
    let input_view = match &msaa_image_view {
        Some(view) => **view,
        None => *image_view,
    };
    write_input_attachment_general(device, descriptor_set.get(), input_view);

    let msaa_init_pipeline_layout =
        make_pipeline_layout_with_push_constants(device, &[*msaa_init_descriptor_set_layout], &[])?;
    let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*descriptor_set_layout], &[])?;
    let binaries = context.get_binary_collection();
    let vert_shader = create_shader_module(device, binaries.get("vert")?)?;
    let frag_shader = create_shader_module(device, binaries.get("frag")?)?;

    let color_blend_attachment_states = [vk::PipelineColorBlendAttachmentState {
        color_write_mask: vk::ColorComponentFlags::all(),
        ..Default::default()
    }];
    let color_formats = [image_format];

    let pipeline = make_pipeline(
        device,
        &PipelineSetup {
            layout: *pipeline_layout,
            vert: *vert_shader,
            frag: *frag_shader,
            color_formats: &color_formats,
            depth_format: vk::Format::UNDEFINED,
            stencil_format: vk::Format::UNDEFINED,
            blend_states: &color_blend_attachment_states,
            samples: msaa_samples,
            sample_shading: is_msaa_test,
            depth_stencil: default_depth_stencil(),
            dynamic_state: None,
            location_info: None,
            input_index_info: None,
        },
    )?;

    let draw = |cmd: vk::CommandBuffer, layout: vk::PipelineLayout, pipeline: vk::Pipeline, set: vk::DescriptorSet| unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline);
        device.cmd_bind_descriptor_sets(cmd, vk::PipelineBindPoint::GRAPHICS, layout, 0, &[set], &[] as &[u32]);
        device.cmd_draw(cmd, 4, 1, 0, 0);
    };

    let secondary_buffer = if secondary {
        let buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        begin_secondary_rendering_buffer(
            device,
            *buffer,
            std::ptr::null(),
            &color_formats,
            vk::Format::UNDEFINED,
            vk::Format::UNDEFINED,
            msaa_samples,
        )?;
        draw(*buffer, *pipeline_layout, pipeline.get(), descriptor_set.get());
        end_command_buffer(device, *buffer)?;
        Some(buffer)
    } else {
        None
    };

    begin_command_buffer(device, cmd)?;

    let general_attachment = |view: vk::ImageView, load_op: vk::AttachmentLoadOp, store_op: vk::AttachmentStoreOp| {
        make_attachment_info(
            view,
            vk::ImageLayout::GENERAL,
            load_op,
            store_op,
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
        )
    };

    // Held outside the branches below: the MSAA initialisation pipeline and its shader outlive the recording.
    let frag_init_shader;
    let msaa_init_pipeline;

    if is_msaa_test {
        // If the image is MSAA, one can not copy into it from a buffer, so a shader is used to initialize it.
        frag_init_shader = create_shader_module(device, binaries.get("frag_init")?)?;
        msaa_init_pipeline = make_pipeline(
            device,
            &PipelineSetup {
                layout: *msaa_init_pipeline_layout,
                vert: *vert_shader,
                frag: *frag_init_shader,
                color_formats: &color_formats,
                depth_format: vk::Format::UNDEFINED,
                stencil_format: vk::Format::UNDEFINED,
                blend_states: &color_blend_attachment_states,
                samples: msaa_samples,
                sample_shading: false,
                depth_stencil: default_depth_stencil(),
                dynamic_state: None,
                location_info: None,
                input_index_info: None,
            },
        )?;

        // Barrier before the draw to put the single-sampled and MSAA images in the right layout
        let mut barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            image_with_memory.get(),
            srr,
        );
        image_barriers(
            device,
            cmd,
            vk::PipelineStageFlags::empty(),
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &[barrier],
        );
        let msaa_image = msaa_image_with_memory
            .as_ref()
            .ok_or_else(|| TestError::InternalError("no multisample image".to_string()))?;
        barrier.image = msaa_image.get();
        image_barriers(
            device,
            cmd,
            vk::PipelineStageFlags::empty(),
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &[barrier],
        );

        let msaa_view = msaa_image_view
            .as_ref()
            .ok_or_else(|| TestError::InternalError("no multisample view".to_string()))?;
        let mut color_attachment = general_attachment(
            **msaa_view,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::STORE,
        );

        // When primary command buffers are used, it is easy to merge the two render passes, so do that for extra testing.
        let use_single_pass = !secondary;
        if use_single_pass {
            color_attachment.resolve_mode = vk::ResolveModeFlags::AVERAGE;
            color_attachment.resolve_image_view = *image_view;
            color_attachment.resolve_image_layout = vk::ImageLayout::GENERAL;
            color_attachment.store_op = vk::AttachmentStoreOp::DONT_CARE;
        }

        let attachments = [color_attachment];
        let info = rendering_info(render_area, &attachments, false);

        unsafe { device.cmd_begin_rendering(cmd, &info) };
        draw(
            cmd,
            *msaa_init_pipeline_layout,
            msaa_init_pipeline.get(),
            msaa_init_descriptor_set.get(),
        );

        if use_single_pass {
            // Mid render pass barrier
            input_attachment_to_color_read_barrier(device, cmd);
        } else {
            unsafe { device.cmd_end_rendering(cmd) };

            // Barrier after the draw, synchronizing with the input attachment read in the next draw
            barrier.src_access_mask = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
            barrier.dst_access_mask = vk::AccessFlags::INPUT_ATTACHMENT_READ;
            barrier.old_layout = vk::ImageLayout::GENERAL;
            image_barriers(
                device,
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                &[barrier],
            );

            // Start the render pass where the attachment is used as input; like the other branch, but with a resolve attachment.
            let mut second_attachment = general_attachment(
                **msaa_view,
                vk::AttachmentLoadOp::LOAD,
                vk::AttachmentStoreOp::DONT_CARE,
            );
            second_attachment.resolve_mode = vk::ResolveModeFlags::AVERAGE;
            second_attachment.resolve_image_view = *image_view;
            second_attachment.resolve_image_layout = vk::ImageLayout::GENERAL;

            let second_attachments = [second_attachment];
            let second_info = rendering_info(render_area, &second_attachments, secondary);
            unsafe { device.cmd_begin_rendering(cmd, &second_info) };
        }
    } else {
        // copyBufferToImage
        let pre_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            image_with_memory.get(),
            srr,
        );
        image_barriers(
            device,
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            &[pre_barrier],
        );
        let buffer_barrier = make_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::TRANSFER_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[buffer_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            device.cmd_copy_buffer_to_image(
                cmd,
                buffer_with_memory.get(),
                image_with_memory.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[copy_region],
            );
        }
        let post_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::GENERAL,
            image_with_memory.get(),
            srr,
        );
        image_barriers(
            device,
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            &[post_barrier],
        );

        let attachments = [general_attachment(
            *image_view,
            vk::AttachmentLoadOp::LOAD,
            vk::AttachmentStoreOp::STORE,
        )];
        let info = rendering_info(render_area, &attachments, secondary);
        unsafe { device.cmd_begin_rendering(cmd, &info) };
    }

    match &secondary_buffer {
        Some(buffer) => unsafe { device.cmd_execute_commands(cmd, &[**buffer]) },
        None => draw(cmd, *pipeline_layout, pipeline.get(), descriptor_set.get()),
    }
    unsafe { device.cmd_end_rendering(cmd) };

    // copyImageToBuffer
    let to_transfer_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image_with_memory.get(),
        srr,
    );
    image_barriers(
        device,
        cmd,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
        &[to_transfer_barrier],
    );
    unsafe {
        device.cmd_copy_image_to_buffer(
            cmd,
            image_with_memory.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer_with_memory.get(),
            &[copy_region],
        )
    };
    let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[host_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    invalidate_alloc(device, allocation)?;

    // Verify the result by repeating the logic of the shader; the shader adds or subtracts 51, but the precision is not that important so the
    // range (40; 60) is checked.
    let output = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const(), procedural_data.len()) };
    let mut failure_count = 0u32;
    for (&input, &output) in procedural_data.iter().zip(output) {
        let (input, output) = (i32::from(input), i32::from(output));
        failure_count += if input > 127 {
            u32::from(output < input - 60 || output > input - 40)
        } else {
            u32::from(output < input + 40 || output > input + 60)
        };
    }

    if failure_count == 0 {
        return Ok(TestStatus::pass("Pass"));
    }

    Ok(TestStatus::fail(format!(
        "Fail ({}% of fragments had wrong value)",
        100.0 * failure_count as f32 / image_size as f32 / image_size as f32
    )))
}

fn write_input_attachment_general(device: &Device, set: vk::DescriptorSet, view: vk::ImageView) {
    let info = vk::DescriptorImageInfo {
        sampler: vk::Sampler::null(),
        image_view: view,
        image_layout: vk::ImageLayout::GENERAL,
    };
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: set,
        dst_binding: 0,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type: vk::DescriptorType::INPUT_ATTACHMENT,
        image_info: &info,
        buffer_info: std::ptr::null(),
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}
