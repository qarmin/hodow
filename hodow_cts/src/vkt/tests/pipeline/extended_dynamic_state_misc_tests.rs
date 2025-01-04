// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineExtendedDynamicStateMiscTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Copyright (c) 2023 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Monolithic pipelines only; the group registers under `extended_dynamic_state`,
// whose other tests (vktPipelineExtendedDynamicStateTests.cpp) are not ported.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtExtendedDynamicState3ExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::pipeline_extended_dynamic_state_misc::{
    DYNAMIC_SAMPLE_SHADING, SAMPLE_SHADING_DYNAMIC_SAMPLE_COUNT,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, make_rect_2d, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, rect_2d, viewport,
};
use crate::vkt::tests::synchronization::image_layout_transition_tests::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const VERTEX_COUNT: u32 = 4;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

fn eds3_rasterization_samples_supported(context: &Context<'_>) -> Result<(), TestError> {
    let mut eds3_features = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut eds3_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    if eds3_features.extended_dynamic_state3_rasterization_samples == vk::FALSE {
        return Err(TestError::NotSupported(
            "extendedDynamicState3RasterizationSamples not supported".to_string(),
        ));
    }
    Ok(())
}

/// `verifyValueInRange`
fn verify_value_in_range(value: u32, min_value: u32, max_value: u32, value_desc: &str) -> Result<(), TestError> {
    if value < min_value || value > max_value {
        return Err(TestError::Fail(format!(
            "Unexpected value found for {value_desc}: {value} not in range [{min_value}, {max_value}]"
        )));
    }
    Ok(())
}

/// The two attachments of both tests: a multisample colour attachment that is cleared and not stored, resolved into a single-sample one.
fn make_resolve_render_pass(
    device: &Device,
    multisample_count: vk::SampleCountFlags,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachment_descs = [
        // Multisample attachment.
        vk::AttachmentDescription::builder()
            .format(COLOR_FORMAT)
            .samples(multisample_count)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::DONT_CARE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
        // Resolve attachment.
        vk::AttachmentDescription::builder()
            .format(COLOR_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::DONT_CARE)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build(),
    ];

    let color_att_refs = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let resolve_att_refs = [vk::AttachmentReference {
        attachment: 1,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpass_description = vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_att_refs)
        .resolve_attachments(&resolve_att_refs)
        .build();
    let subpasses = [subpass_description];
    let render_pass_create_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_descs)
        .subpasses(&subpasses);
    let render_pass =
        unsafe { device.create_render_pass(&render_pass_create_info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// A 2x2 multisample colour image with its view.
fn make_multisample_color_buffer<'a>(
    context: &'a Context<'a>,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> Result<(ImageWithMemory<'a>, Unique<'a, vk::ImageView>), TestError> {
    let device = context.get_device();
    let info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(vk::Extent3D {
            width: 2,
            height: 2,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let image = ImageWithMemory::new(device, context.get_default_allocator(), info, MemoryRequirement::ANY)?;
    let view = make_image_view(
        device,
        image.get(),
        vk::ImageViewType::_2D,
        COLOR_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    Ok((image, view))
}

fn zeroed_counter_buffer<'a>(context: &'a Context<'a>) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let counter_buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
    let counter_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(counter_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let alloc = counter_buffer.get_allocation();
    unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, counter_buffer_size as usize) };
    flush_alloc(device, alloc)?;
    Ok(counter_buffer)
}

fn read_counter(device: &Device, buffer: &BufferWithMemory<'_>) -> Result<u32, TestError> {
    let alloc = buffer.get_allocation();
    invalidate_alloc(device, alloc)?;
    Ok(unsafe { alloc.get_host_ptr().cast::<u32>().read_unaligned() })
}

/// Every texel of the 2x2 resolve buffer has to be the geometry colour, blue.
fn check_resolved_color(device: &Device, resolve_buffer: &ImageWithBuffer<'_>) -> Result<bool, TestError> {
    let data = resolve_buffer.read_bytes(device)?;
    Ok(data.chunks_exact(4).all(|texel| texel == [0u8, 0, 255, 255]))
}

// ---------------------------------------------------------------------------------
// sample_shading_dynamic_sample_count
// ---------------------------------------------------------------------------------

/// `sampleShadingWithDynamicSampleCount`
///
/// ```text
/// begin cmdbuf
/// bind pipeline with sample shading disabled
/// call vkCmdSetRasterizationSamplesEXT(samples > 1)
/// draw
/// bind pipeline with sample shading enabled
/// draw
/// sample shading should work for both draws with the expected number of samples
/// ```
/// Each draw will use one half of the framebuffer, controlled by the viewport and scissor.
fn sample_shading_with_dynamic_sample_count(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let fb_extent = (2u32, 2u32);
    let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
    const NUM_DRAWS: usize = 2;
    let multi_sample_count = vk::SampleCountFlags::_4;

    // Color buffers.
    let (color_image, color_view) = make_multisample_color_buffer(context, multi_sample_count, color_usage)?;
    let resolve_buffer = ImageWithBuffer::new(context, fb_extent.0, fb_extent.1, COLOR_FORMAT, color_usage, 4)?;

    // Counter buffers.
    let counter_buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
    let counter_buffers = [zeroed_counter_buffer(context)?, zeroed_counter_buffer(context)?];

    // Descriptor set layout, pool and set.
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, NUM_DRAWS as u32)
        .build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            NUM_DRAWS as u32,
        )?;

    let mut descriptor_sets = Vec::new();
    for counter_buffer in &counter_buffers {
        let set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let counter_buffer_descriptor_info = make_descriptor_buffer_info(counter_buffer.get(), 0, counter_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &counter_buffer_descriptor_info,
            )
            .update(device);
        descriptor_sets.push(set);
    }

    // Render pass and framebuffer.
    let render_pass = make_resolve_render_pass(device, multi_sample_count)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_view, *resolve_buffer.view],
        fb_extent.0,
        fb_extent.1,
        1,
    )?;

    // Pipelines.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

    let half_width = fb_extent.0 / 2;
    let half_width_f = half_width as f32;
    let height_f = fb_extent.1 as f32;
    let dynamic_scissors = [
        make_rect_2d(0, 0, half_width, fb_extent.1),
        make_rect_2d(half_width as i32, 0, half_width, fb_extent.1),
    ];
    let dynamic_viewports = [
        viewport(0.0, 0.0, half_width_f, height_f, 0.0, 1.0),
        viewport(half_width_f, 0.0, half_width_f, height_f, 0.0, 1.0),
    ];

    let mut pipelines = Vec::new();
    for sample_shading_enable in [false, true] {
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP);
        state.dynamic_states = vec![
            vk::DynamicState::RASTERIZATION_SAMPLES_EXT,
            vk::DynamicState::SCISSOR,
            vk::DynamicState::VIEWPORT,
        ];
        state.viewports = vec![viewport(0.0, 0.0, 0.0, 0.0, 0.0, 1.0)];
        state.scissors = vec![rect_2d(0, 0)];
        state.viewport_count = 1;
        state.samples = vk::SampleCountFlags::_64;
        state.sample_shading = sample_shading_enable;
        state.min_sample_shading = 1.0;
        pipelines.push(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            &state,
        )?);
    }

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = cmd_buffer_ptr.get();

    begin_command_buffer(device, cmd_buffer)?;
    begin_render_pass(
        device,
        cmd_buffer,
        *render_pass,
        *framebuffer,
        rect_2d(fb_extent.0, fb_extent.1),
        clear_value_color([0.0, 0.0, 0.0, 0.0]),
    );
    for draw_idx in 0..NUM_DRAWS {
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipelines[draw_idx]);
            if draw_idx == 0 {
                device.cmd_set_rasterization_samples_ext(cmd_buffer, multi_sample_count);
            }
            device.cmd_set_scissor(cmd_buffer, 0, &[dynamic_scissors[draw_idx]]);
            device.cmd_set_viewport(cmd_buffer, 0, &[dynamic_viewports[draw_idx]]);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_sets[draw_idx].get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd_buffer, VERTEX_COUNT, 1, 0, 0);
        }
    }
    unsafe { device.cmd_end_render_pass(cmd_buffer) };
    copy_image_to_buffer(
        device,
        cmd_buffer,
        resolve_buffer.image.get(),
        resolve_buffer.buffer.get(),
        fb_extent,
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    );
    end_command_buffer(device, cmd_buffer)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;
    let _keep_alive = &color_image;

    // Verify resolve buffer and counter buffers.
    if !check_resolved_color(device, &resolve_buffer)? {
        return Ok(TestStatus::fail(
            "Unexpected color buffer results -- check log for details",
        ));
    }

    let mut counter_results = [0u32; NUM_DRAWS];
    for draw_idx in 0..NUM_DRAWS {
        counter_results[draw_idx] = read_counter(device, &counter_buffers[draw_idx])?;
    }

    // The first result is run without sample shading enabled, so it can have any value from 1 to 4 invocations per pixel.
    // The second result runs with sample shading enabled, so it must have exactly 4 invocations per pixel.
    let min_invs = (fb_extent.0 * fb_extent.1) / 2;
    let max_invs = min_invs * 4;

    verify_value_in_range(
        counter_results[0],
        min_invs,
        max_invs,
        "invocation counter without sample shading",
    )?;
    verify_value_in_range(
        counter_results[1],
        max_invs,
        max_invs,
        "invocation counter with sample shading",
    )?;

    Ok(TestStatus::pass("Pass"))
}

// ---------------------------------------------------------------------------------
// dynamic_sample_shading_static_N_dynamic_M
// ---------------------------------------------------------------------------------

/// `DSS::Params`, without the construction type.
#[derive(Clone, Copy)]
struct DssParams {
    static_count: vk::SampleCountFlags,
    dynamic_count: vk::SampleCountFlags,
}

/// `dynamicSampleShadingTest`
///
/// Test that sample shading is enabled even if the sample count is dynamic and the product of minSampleShading and static sample
/// count is not greater than 1. Some drivers have an optimization along the lines of `sampleShadingEnable && minSampleShading *
/// rasterizationSamples > 1.0`, which skips sample shading when the rasterization sample count is only known at run time.
fn dynamic_sample_shading_test(context: &Context<'_>, params: DssParams) -> TestOutcome {
    let device = context.get_device();
    let fb_extent = (2u32, 2u32);
    let tex_extent = vk::Extent3D {
        width: 16,
        height: 16,
        depth: 1,
    };
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

    // Multisample color buffer with verification buffer.
    let (ms_color_buffer, ms_color_buffer_view) =
        make_multisample_color_buffer(context, params.dynamic_count, vk::ImageUsageFlags::COLOR_ATTACHMENT)?;

    // Resolve attachment with verification buffer.
    let ss_usage =
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST;
    let color_buffer = ImageWithBuffer::new(context, fb_extent.0, fb_extent.1, COLOR_FORMAT, ss_usage, 4)?;

    // Vertices: a position and the texture coordinates.
    #[repr(C)]
    #[derive(Clone, Copy)]
    struct VertexData {
        position: [f32; 4],
        tex_coords: [f32; 2],
    }
    let vertices = [
        VertexData {
            position: [-1.0, -1.0, 0.0, 1.0],
            tex_coords: [0.0, 0.0],
        },
        VertexData {
            position: [-1.0, 1.0, 0.0, 1.0],
            tex_coords: [0.0, 1.0],
        },
        VertexData {
            position: [1.0, -1.0, 0.0, 1.0],
            tex_coords: [1.0, 0.0],
        },
        VertexData {
            position: [1.0, 1.0, 0.0, 1.0],
            tex_coords: [1.0, 1.0],
        },
    ];

    // Vertex buffer
    let vb_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
    let vertex_buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(vb_size, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let vb_alloc = vertex_buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr(),
                vb_alloc.get_host_ptr().cast::<VertexData>(),
                vertices.len(),
            )
        };
        flush_alloc(device, vb_alloc)?;
    }

    // Sampled texture.
    let texture_create_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_FORMAT)
        .extent(tex_extent)
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::SAMPLED | vk::ImageUsageFlags::TRANSFER_DST)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let texture = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        texture_create_info,
        MemoryRequirement::ANY,
    )?;
    let texture_view = make_image_view(device, texture.get(), vk::ImageViewType::_2D, COLOR_FORMAT, color_srr)?;

    // Sampler.
    let sampler_create_info = vk::SamplerCreateInfo::builder()
        .mag_filter(vk::Filter::NEAREST)
        .min_filter(vk::Filter::NEAREST)
        .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
        .address_mode_u(vk::SamplerAddressMode::REPEAT)
        .address_mode_v(vk::SamplerAddressMode::REPEAT)
        .address_mode_w(vk::SamplerAddressMode::REPEAT)
        .mip_lod_bias(0.0)
        .anisotropy_enable(false)
        .max_anisotropy(0.0)
        .compare_enable(false)
        .compare_op(vk::CompareOp::NEVER)
        .min_lod(0.0)
        .max_lod(0.0)
        .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
        .unnormalized_coordinates(false);
    let sampler = Unique::new(
        device,
        unsafe { device.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?,
    );

    // Atomic counter buffer.
    let data_buffer = zeroed_counter_buffer(context)?;
    let db_size = std::mem::size_of::<u32>() as vk::DeviceSize;

    // Descriptor pool, set, layout, etc.
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, 1)
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER,
            vk::ShaderStageFlags::FRAGMENT,
        )
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
        .build(device)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

    let db_desc_info = make_descriptor_buffer_info(data_buffer.get(), 0, db_size);
    let tex_desc_info = vk::DescriptorImageInfo {
        sampler: *sampler,
        image_view: *texture_view,
        image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
    };
    let writes = [
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::COMBINED_IMAGE_SAMPLER)
            .image_info(std::slice::from_ref(&tex_desc_info))
            .build(),
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set.get())
            .dst_binding(1)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(std::slice::from_ref(&db_desc_info))
            .build(),
    ];
    unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;

    let render_pass = make_resolve_render_pass(device, params.dynamic_count)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*ms_color_buffer_view, *color_buffer.view],
        fb_extent.0,
        fb_extent.1,
        1,
    )?;

    // Modules.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    // This is critical for the test. We need to select a minSampleShading value
    // that results in <= 1.0 when multiplied with the static sample count, but
    // > 1.0 when using the dynamic sample count.
    let min_sample_shading = 1.0 / params.static_count.bits() as f32;

    let mut state =
        DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(fb_extent.0, fb_extent.1);
    state.dynamic_states = vec![vk::DynamicState::RASTERIZATION_SAMPLES_EXT];
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: std::mem::size_of::<VertexData>() as u32,
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
            format: vk::Format::R32G32_SFLOAT,
            offset: 16,
        },
    ];
    state.samples = params.static_count;
    state.sample_shading = true;
    state.min_sample_shading = min_sample_shading;
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ],
        &state,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = cmd_buffer_ptr.get();

    begin_command_buffer(device, cmd_buffer)?;

    // Clear texture to the geometry color.
    {
        let pre_clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            texture.get(),
            color_srr,
        );
        let tex_clear_color = vk::ClearColorValue {
            float32: [0.0, 0.0, 1.0, 1.0],
        };
        let post_clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            texture.get(),
            color_srr,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_clear_barrier],
            );
            device.cmd_clear_color_image(
                cmd_buffer,
                texture.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &tex_clear_color,
                &[color_srr],
            );
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post_clear_barrier],
            );
        }
    }

    begin_render_pass(
        device,
        cmd_buffer,
        *render_pass,
        *framebuffer,
        rect_2d(fb_extent.0, fb_extent.1),
        clear_value_color([0.0, 0.0, 0.0, 1.0]),
    );
    unsafe {
        device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_bind_descriptor_sets(
            cmd_buffer,
            vk::PipelineBindPoint::GRAPHICS,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
        device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
        device.cmd_set_rasterization_samples_ext(cmd_buffer, params.dynamic_count);
        device.cmd_draw(cmd_buffer, vertices.len() as u32, 1, 0, 0);
        device.cmd_end_render_pass(cmd_buffer);
    }
    copy_image_to_buffer(
        device,
        cmd_buffer,
        color_buffer.image.get(),
        color_buffer.buffer.get(),
        fb_extent,
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    );
    {
        let atomic_data_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::FRAGMENT_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[atomic_data_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
    end_command_buffer(device, cmd_buffer)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;
    let _keep_alive = &ms_color_buffer;

    // Verify color output.
    if !check_resolved_color(device, &color_buffer)? {
        return Ok(TestStatus::fail(
            "Unexpected color in result buffer; check log for details",
        ));
    }

    // Verify actual sample count.
    let min_count_per_pixel = (min_sample_shading * params.dynamic_count.bits() as f32) as u32;
    let pixel_count = fb_extent.0 * fb_extent.1;
    let min_expected_count = pixel_count * min_count_per_pixel;
    let result_count = read_counter(device, &data_buffer)?;

    if result_count < min_expected_count {
        return Err(TestError::Fail(format!(
            "Unexpected fragment shader count: expected at least {min_expected_count} but found {result_count}"
        )));
    }

    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy)]
enum Kind {
    SampleShadingDynamicSampleCount,
    DynamicSampleShading(DssParams),
}

struct MiscCase {
    name: String,
    kind: Kind,
}

impl TestCase for MiscCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        eds3_rasterization_samples_supported(context)?;

        match self.kind {
            Kind::SampleShadingDynamicSampleCount => {
                if context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "fragmentStoresAndAtomics not supported".to_string(),
                    ));
                }
                if context.get_device_features().sample_rate_shading == vk::FALSE {
                    return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
                }
            }
            Kind::DynamicSampleShading(params) => {
                let format_properties = unsafe {
                    context.get_instance().get_physical_device_image_format_properties(
                        context.get_physical_device(),
                        COLOR_FORMAT,
                        vk::ImageType::_2D,
                        vk::ImageTiling::OPTIMAL,
                        vk::ImageUsageFlags::COLOR_ATTACHMENT,
                        vk::ImageCreateFlags::empty(),
                    )
                }
                .vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
                let expected_counts = params.static_count | params.dynamic_count;

                if !format_properties.sample_counts.contains(expected_counts) {
                    return Err(TestError::NotSupported("Sample counts not supported".to_string()));
                }

                if context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "fragmentStoresAndAtomics not supported".to_string(),
                    ));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::SampleShadingDynamicSampleCount => SAMPLE_SHADING_DYNAMIC_SAMPLE_COUNT.programs,
            Kind::DynamicSampleShading(_) => DYNAMIC_SAMPLE_SHADING.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MiscInstance {
            context,
            kind: self.kind,
        })
    }
}

struct MiscInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

impl TestInstance for MiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.kind {
            Kind::SampleShadingDynamicSampleCount => sample_shading_with_dynamic_sample_count(self.context),
            Kind::DynamicSampleShading(params) => dynamic_sample_shading_test(self.context, params),
        }
    }
}

/// `createExtendedDynamicStateMiscTests`, for monolithic pipelines.
pub fn create_extended_dynamic_state_misc_tests() -> TestCaseGroup {
    let mut misc_group = TestCaseGroup::new("misc");

    misc_group.add_child(Box::new(MiscCase {
        name: "sample_shading_dynamic_sample_count".to_string(),
        kind: Kind::SampleShadingDynamicSampleCount,
    }) as Box<dyn TestCase>);

    let sample_counts = [
        vk::SampleCountFlags::_1,
        vk::SampleCountFlags::_2,
        vk::SampleCountFlags::_4,
        vk::SampleCountFlags::_8,
        vk::SampleCountFlags::_16,
    ];

    for i in 0..sample_counts.len() {
        for j in (i + 1)..sample_counts.len() {
            let static_count = sample_counts[i];
            // The actual dynamic count is always greater than the static value.
            let dynamic_count = sample_counts[j];

            let test_name = format!(
                "dynamic_sample_shading_static_{}_dynamic_{}",
                static_count.bits(),
                dynamic_count.bits()
            );
            misc_group.add_child(Box::new(MiscCase {
                name: test_name,
                kind: Kind::DynamicSampleShading(DssParams {
                    static_count,
                    dynamic_count,
                }),
            }) as Box<dyn TestCase>);
        }
    }

    misc_group
}
