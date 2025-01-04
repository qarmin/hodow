// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationImageLayoutTransitionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders and the compute cases'
// parameters are in shaders/manifest/synchronization_layout_transition.toml.
//
// Registered under `synchronization2` only, as upstream does. `no_op` builds its own
// render pass and pipeline: the shared helpers always start an attachment in
// UNDEFINED, and this case is exactly about a LOAD attachment keeping its contents
// across a barrier whose old and new layouts are both UNDEFINED, with blending on.

use vulkanalia::prelude::v1_0::*;

use super::operation::{SyncType, cmd_pipeline_barrier, make_image_memory_barrier2, make_memory_barrier2};
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::texture::map_vk_format;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const WIDTH: u32 = 64;
const HEIGHT: u32 = 64;
const FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// The `rust_type` of the `no_op` manifest entry.
#[derive(Clone, Copy)]
pub struct NoOpCase {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `ComputeLayoutTransitionParams`; the extent and sample count are the manifest's
/// `getImageExtent()` / `getImageSampleCount()`.
#[derive(Clone, Copy)]
pub struct ComputeTransitionCase {
    pub name: &'static str,
    pub storage_usage: bool,
    pub local_size_x: u32,
    pub local_size_y: u32,
    pub sample_count: u32,
    pub programs: BinaryCollection,
}

impl ComputeTransitionCase {
    fn get_image_extent(&self) -> vk::Extent3D {
        vk::Extent3D {
            width: self.local_size_x,
            height: self.local_size_y,
            depth: 1,
        }
    }

    fn get_image_sample_count(&self) -> vk::SampleCountFlags {
        match self.sample_count {
            1 => vk::SampleCountFlags::_1,
            2 => vk::SampleCountFlags::_2,
            4 => vk::SampleCountFlags::_4,
            8 => vk::SampleCountFlags::_8,
            _ => vk::SampleCountFlags::_16,
        }
    }

    fn get_image_format(&self) -> vk::Format {
        vk::Format::R8G8B8A8_UNORM
    }

    fn get_image_type(&self) -> vk::ImageType {
        vk::ImageType::_2D
    }

    fn get_image_tiling(&self) -> vk::ImageTiling {
        vk::ImageTiling::OPTIMAL
    }

    fn get_image_usage(&self) -> vk::ImageUsageFlags {
        let read_usage = if self.storage_usage {
            vk::ImageUsageFlags::STORAGE
        } else {
            vk::ImageUsageFlags::SAMPLED
        };
        vk::ImageUsageFlags::COLOR_ATTACHMENT | read_usage | vk::ImageUsageFlags::TRANSFER_DST
    }
}

fn make_default_image_subresource_range() -> vk::ImageSubresourceRange {
    make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)
}

/// `makeImageCreateInfo`
fn make_image_create_info() -> vk::ImageCreateInfo {
    let usage =
        vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST | vk::ImageUsageFlags::COLOR_ATTACHMENT;
    vk::ImageCreateInfo {
        s_type: vk::StructureType::IMAGE_CREATE_INFO,
        next: std::ptr::null(),
        flags: vk::ImageCreateFlags::empty(),
        image_type: vk::ImageType::_2D,
        format: FORMAT,
        extent: vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        },
        mip_levels: 1,
        array_layers: 1,
        samples: vk::SampleCountFlags::_1,
        tiling: vk::ImageTiling::OPTIMAL,
        usage,
        sharing_mode: vk::SharingMode::EXCLUSIVE,
        queue_family_index_count: 0,
        queue_family_indices: std::ptr::null(),
        initial_layout: vk::ImageLayout::UNDEFINED,
    }
}

/// `genFullQuadVertices` - draw a quad covering the whole framebuffer
fn gen_full_quad_vertices() -> Vec<[f32; 4]> {
    vec![
        [-1.0, -1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [1.0, 1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
    ]
}

/// `makeRenderPass(vk, device, FORMAT, VK_FORMAT_UNDEFINED, VK_ATTACHMENT_LOAD_OP_LOAD)`:
/// upstream starts a LOAD attachment in COLOR_ATTACHMENT_OPTIMAL, not UNDEFINED.
pub(super) fn make_load_render_pass(device: &Device) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [vk::AttachmentDescription::builder()
        .format(FORMAT)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::LOAD)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let color_refs = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .build()];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// `makeGraphicsPipeline` with the blend state this case passes in.
fn make_blend_pipeline(
    device: &Device,
    pipeline_layout: vk::PipelineLayout,
    vertex_module: vk::ShaderModule,
    fragment_module: vk::ShaderModule,
    render_pass: vk::RenderPass,
) -> Result<Unique<'_, vk::Pipeline>, TestError> {
    let entry = c"main";
    let stages = [
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::VERTEX)
            .module(vertex_module)
            .name(entry.to_bytes_with_nul())
            .build(),
        vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::FRAGMENT)
            .module(fragment_module)
            .name(entry.to_bytes_with_nul())
            .build(),
    ];

    let bindings = [vk::VertexInputBindingDescription::builder()
        .binding(0)
        .stride(std::mem::size_of::<[f32; 4]>() as u32)
        .input_rate(vk::VertexInputRate::VERTEX)
        .build()];
    let attributes = [vk::VertexInputAttributeDescription::builder()
        .location(0)
        .binding(0)
        .format(vk::Format::R32G32B32A32_SFLOAT)
        .offset(0)
        .build()];
    let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&bindings)
        .vertex_attribute_descriptions(&attributes);

    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
        .primitive_restart_enable(false);

    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: WIDTH as f32,
        height: HEIGHT as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, WIDTH, HEIGHT)];
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);

    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);

    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(1.0);

    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::KEEP)
        .pass_op(vk::StencilOp::KEEP)
        .depth_fail_op(vk::StencilOp::KEEP)
        .compare_op(vk::CompareOp::NEVER)
        .build();
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);

    let clr_blend_attachment_state = [vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(true)
        .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
        .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::ONE)
        .dst_alpha_blend_factor(vk::BlendFactor::ONE)
        .alpha_blend_op(vk::BlendOp::MAX)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build()];
    let clr_blend_state_create_info = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&clr_blend_attachment_state)
        .blend_constants([1.0, 1.0, 1.0, 1.0]);

    let info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&clr_blend_state_create_info)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `clearColorImage(vk, device, queue, queueFamilyIndex, image, Vec4, oldLayout, newLayout, dstStageFlags, ...)`
#[allow(clippy::too_many_arguments)]
pub fn clear_color_image(
    vk: &Device,
    queue: vk::Queue,
    queue_family_index: u32,
    image: vk::Image,
    clear_color: vk::ClearColorValue,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    dst_stage_flags: vk::PipelineStageFlags,
    base_array_layer: u32,
    layer_count: u32,
) -> Result<(), TestError> {
    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let subresource_range =
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, base_array_layer, layer_count);

    let pre_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        old_layout,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image,
        subresource_range,
    );
    let post_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::SHADER_WRITE,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        new_layout,
        image,
        subresource_range,
    );

    begin_command_buffer(vk, *cmd_buffer)?;
    unsafe {
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_image_barrier],
        );
        vk.cmd_clear_color_image(
            *cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &clear_color,
            &[subresource_range],
        );
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            dst_stage_flags,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_image_barrier],
        );
    }
    end_command_buffer(vk, *cmd_buffer)?;

    submit_commands_and_wait(vk, queue, *cmd_buffer)
}

/// `vk::copyImageToBuffer`, narrowed to the single-region, single-layer 2D colour case.
pub fn copy_image_to_buffer(
    vk: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    size: (u32, u32),
    src_access_mask: vk::AccessFlags,
    old_layout: vk::ImageLayout,
) {
    let image_barrier = make_image_memory_barrier(
        src_access_mask,
        vk::AccessFlags::TRANSFER_READ,
        old_layout,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        image,
        make_default_image_subresource_range(),
    );

    unsafe {
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[image_barrier],
        );

        let subresource = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let region = make_buffer_image_copy(
            vk::Extent3D {
                width: size.0,
                height: size.1,
                depth: 1,
            },
            subresource,
        );
        vk.cmd_copy_image_to_buffer(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            buffer,
            &[region],
        );

        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer,
            0,
            vk::WHOLE_SIZE,
        );
        vk.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `SynchronizationImageLayoutTransitionTestInstance::iterate`
fn no_op_iterate(context: &Context<'_>) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let buffer_size: vk::DeviceSize = 16 * 1024;

    let vertices = gen_full_quad_vertices();
    let vertex_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(1024, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let vertex_buffer_alloc = vertex_buffer.get_allocation();
    let vertex_buffer_offset: vk::DeviceSize = 0;

    unsafe {
        std::ptr::copy_nonoverlapping(
            vertices.as_ptr().cast::<u8>(),
            vertex_buffer_alloc.get_host_ptr(),
            std::mem::size_of_val(vertices.as_slice()),
        );
    }
    flush_alloc(vk, vertex_buffer_alloc)?;

    let target_create_info = make_image_create_info();
    let target_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let target_image = ImageWithMemory::new(vk, allocator, target_create_info, MemoryRequirement::ANY)?;
    let target_image_view = make_image_view(
        vk,
        target_image.get(),
        vk::ImageViewType::_2D,
        FORMAT,
        target_subresource_range,
    )?;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let render_pass = make_load_render_pass(vk)?;
    let framebuffer = make_framebuffer(vk, *render_pass, &[*target_image_view], WIDTH, HEIGHT, 1)?;

    let binaries = context.get_binary_collection();
    let vertex_module = create_shader_module(vk, binaries.get("vert1")?)?;
    let fragment_module = create_shader_module(vk, binaries.get("frag1")?)?;

    let pipeline_layout = make_pipeline_layout(vk, &[])?;
    let graphics_pipeline = make_blend_pipeline(vk, *pipeline_layout, *vertex_module, *fragment_module, *render_pass)?;

    let result_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let result_buffer_memory = result_buffer.get_allocation();

    clear_color_image(
        vk,
        queue,
        queue_family_index,
        target_image.get(),
        vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 0.0],
        },
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::PipelineStageFlags::FRAGMENT_SHADER,
        0,
        1,
    )?;

    let clear_value = vk::ClearValue {
        color: vk::ClearColorValue { float32: [0.0; 4] },
    };

    begin_command_buffer(vk, *cmd_buffer)?;

    unsafe {
        vk.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
        vk.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
    }

    begin_render_pass(
        vk,
        *cmd_buffer,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, WIDTH, HEIGHT),
        clear_value,
    );
    unsafe { vk.cmd_draw(*cmd_buffer, vertices.len() as u32, 1, 0, 0) };
    end_render_pass(vk, *cmd_buffer);

    // Define an execution dependency and skip the layout transition. This is allowed when oldLayout
    // and newLayout are both UNDEFINED. The test will fail if the driver discards the contents of
    // the image.
    let image_memory_barrier2 = make_image_memory_barrier2(
        vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT, // srcStageMask
        vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,         // srcAccessMask
        vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT, // dstStageMask
        vk::AccessFlags2::COLOR_ATTACHMENT_READ,          // dstAccessMask
        vk::ImageLayout::UNDEFINED,                       // oldLayout
        vk::ImageLayout::UNDEFINED,                       // newLayout
        target_image.get(),                               // image
        target_subresource_range,                         // subresourceRange
    );
    cmd_pipeline_barrier(
        vk,
        SyncType::Synchronization2,
        *cmd_buffer,
        &[],
        &[image_memory_barrier2],
    );

    begin_render_pass(
        vk,
        *cmd_buffer,
        *render_pass,
        *framebuffer,
        make_rect_2d(0, 0, WIDTH, HEIGHT),
        clear_value,
    );
    unsafe { vk.cmd_draw(*cmd_buffer, vertices.len() as u32, 1, 0, 0) };
    end_render_pass(vk, *cmd_buffer);

    // Read the result buffer data
    copy_image_to_buffer(
        vk,
        *cmd_buffer,
        target_image.get(),
        result_buffer.get(),
        (WIDTH, HEIGHT),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    );

    end_command_buffer(vk, *cmd_buffer)?;
    submit_commands_and_wait(vk, queue, *cmd_buffer)?;

    invalidate_alloc(vk, result_buffer_memory)?;

    let result_data = unsafe {
        std::slice::from_raw_parts(
            result_buffer_memory.get_host_ptr().cast_const(),
            (WIDTH * HEIGHT * 4) as usize,
        )
    };
    let tcu_format = map_vk_format(FORMAT)
        .ok_or_else(|| TestError::InternalError("no texture format for R8G8B8A8_UNORM".to_string()))?;
    let result_image = ConstPixelBufferAccess::new(tcu_format, [WIDTH, HEIGHT, 1], result_data);

    let alpha = 0.4f32;
    let red = (2.0f32 - alpha) * alpha;
    let green = red;
    let blue = 0.0f32;
    let color = [red, green, blue, alpha];
    let threshold = [0.01f32; 4];

    let mut max_diff = [0.0f32; 4];
    for y in 0..HEIGHT {
        for x in 0..WIDTH {
            let pixel = result_image.get_pixel(x, y, 0);
            for c in 0..4 {
                max_diff[c] = max_diff[c].max((pixel[c] - color[c]).abs());
            }
        }
    }
    let ok = (0..4).all(|c| max_diff[c] <= threshold[c]);
    if !ok {
        log::info!(
            "Image comparison failed: expected {color:?}, max difference per channel {max_diff:?}, threshold {threshold:?}"
        );
    }
    Ok(if ok {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

impl TestCase for NoOpCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_synchronization2")
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(NoOpInstance { context })
    }
}

struct NoOpInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for NoOpInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        no_op_iterate(self.context)
    }
}

/// An image-descriptor write; `DescriptorSetUpdateBuilder` only carries buffer infos.
fn write_image_descriptor(
    device: &Device,
    descriptor_set: vk::DescriptorSet,
    binding: u32,
    descriptor_type: vk::DescriptorType,
    image_info: &vk::DescriptorImageInfo,
) {
    let write = vk::WriteDescriptorSet {
        s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
        next: std::ptr::null(),
        dst_set: descriptor_set,
        dst_binding: binding,
        dst_array_element: 0,
        descriptor_count: 1,
        descriptor_type,
        image_info,
        buffer_info: std::ptr::null(),
        texel_buffer_view: std::ptr::null(),
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
}

/// The `recordImageBarrier` lambda - one image barrier, BY_REGION.
fn record_image_barrier(device: &Device, cmd_buffer: vk::CommandBuffer, barrier: vk::ImageMemoryBarrier2) {
    cmd_pipeline_barrier(device, SyncType::Synchronization2, cmd_buffer, &[], &[barrier]);
}

/// The `recordMemBarrier` lambda - one global memory barrier, BY_REGION.
fn record_mem_barrier(device: &Device, cmd_buffer: vk::CommandBuffer, barrier: vk::MemoryBarrier2) {
    use vulkanalia::vk::KhrSynchronization2ExtensionDeviceCommands;
    let barriers = [barrier];
    let dep_info = vk::DependencyInfo {
        s_type: vk::StructureType::DEPENDENCY_INFO,
        next: std::ptr::null(),
        dependency_flags: vk::DependencyFlags::BY_REGION,
        memory_barrier_count: 1,
        memory_barriers: barriers.as_ptr(),
        buffer_memory_barrier_count: 0,
        buffer_memory_barriers: std::ptr::null(),
        image_memory_barrier_count: 0,
        image_memory_barriers: std::ptr::null(),
    };
    unsafe { device.cmd_pipeline_barrier2_khr(cmd_buffer, &dep_info) };
}

impl ComputeTransitionCase {
    /// `ComputeLayoutTransitionInstance::iterate`
    fn iterate(&self, context: &Context<'_>) -> TestOutcome {
        let vk = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let qf_index = context.get_universal_queue_family_index();
        let (compute_queue, compute_qf_index) = context
            .get_compute_queue()
            .ok_or_else(|| TestError::NotSupported("no compute-only queue family".to_string()))?;

        let image_extent = self.get_image_extent();
        let image_format = self.get_image_format();
        let image_usage = self.get_image_usage();
        let image_type = self.get_image_type();
        let image_tiling = self.get_image_tiling();
        let image_view_type = vk::ImageViewType::_2D;
        let image_descriptor_type = if self.storage_usage {
            vk::DescriptorType::STORAGE_IMAGE
        } else {
            vk::DescriptorType::COMBINED_IMAGE_SAMPLER
        };
        let image_read_layout = if self.storage_usage {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
        };
        let srr = make_default_image_subresource_range();
        let clear_color = [0.0f32, 0.0, 1.0, 1.0];
        let sample_count = self.get_image_sample_count();
        let buffer_extent = (
            image_extent.width * self.sample_count,
            image_extent.height,
            image_extent.depth,
        );
        let buffer_descriptor_type = vk::DescriptorType::STORAGE_BUFFER;

        let image_create_info = vk::ImageCreateInfo {
            s_type: vk::StructureType::IMAGE_CREATE_INFO,
            next: std::ptr::null(),
            flags: vk::ImageCreateFlags::empty(),
            image_type,
            format: image_format,
            extent: image_extent,
            mip_levels: 1,
            array_layers: 1,
            samples: sample_count,
            tiling: image_tiling,
            usage: image_usage,
            sharing_mode: vk::SharingMode::EXCLUSIVE,
            queue_family_index_count: 0,
            queue_family_indices: std::ptr::null(),
            initial_layout: vk::ImageLayout::UNDEFINED,
        };

        let image = ImageWithMemory::new(vk, allocator, image_create_info, MemoryRequirement::ANY)?;
        let image_view = make_image_view(vk, image.get(), image_view_type, image_format, srr)?;

        let sampler_create_info = vk::SamplerCreateInfo::builder()
            .mag_filter(vk::Filter::NEAREST)
            .min_filter(vk::Filter::NEAREST)
            .mipmap_mode(vk::SamplerMipmapMode::NEAREST)
            .address_mode_u(vk::SamplerAddressMode::REPEAT)
            .address_mode_v(vk::SamplerAddressMode::REPEAT)
            .address_mode_w(vk::SamplerAddressMode::REPEAT)
            .mip_lod_bias(0.0)
            .anisotropy_enable(false)
            .max_anisotropy(1.0)
            .compare_enable(false)
            .compare_op(vk::CompareOp::NEVER)
            .min_lod(0.0)
            .max_lod(0.0)
            .border_color(vk::BorderColor::FLOAT_TRANSPARENT_BLACK)
            .unnormalized_coordinates(false);
        let sampler = unsafe { vk.create_sampler(&sampler_create_info, None) }.vk_check("vkCreateSampler")?;
        let sampler = Unique::new(vk, sampler);

        let pixel_size = 4 * std::mem::size_of::<f32>() as u32; // R32G32B32A32_SFLOAT
        let buffer_size = u64::from(buffer_extent.0)
            * u64::from(buffer_extent.1)
            * u64::from(buffer_extent.2)
            * u64::from(pixel_size);
        let buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER;
        let buffer_create_info = make_buffer_create_info(buffer_size, buffer_usage);

        let buffer = BufferWithMemory::new(vk, allocator, buffer_create_info, MemoryRequirement::HOST_VISIBLE)?;

        let desc_pool = DescriptorPoolBuilder::new()
            .add_type(image_descriptor_type, 1)
            .add_type(buffer_descriptor_type, 1)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(image_descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(buffer_descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_set = make_descriptor_set(vk, *desc_pool, *set_layout)?;

        let descriptor_sampler = if self.storage_usage {
            vk::Sampler::null()
        } else {
            *sampler
        };
        let image_desc_info = vk::DescriptorImageInfo {
            sampler: descriptor_sampler,
            image_view: *image_view,
            image_layout: image_read_layout,
        };
        let buffer_desc_info = make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE);
        write_image_descriptor(vk, *descriptor_set, 0, image_descriptor_type, &image_desc_info);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(1),
                buffer_descriptor_type,
                &buffer_desc_info,
            )
            .update(vk);

        let binaries = context.get_binary_collection();
        let mut pipeline =
            ComputePipelineWrapper::new(vk, ComputePipelineConstructionType::Pipeline, binaries.get("comp")?);
        pipeline.set_descriptor_set_layout(*set_layout);
        pipeline.build_pipeline()?;

        let src_stage_mask = vk::PipelineStageFlags2::TOP_OF_PIPE;
        let src_access_mask = vk::AccessFlags2::empty();
        let dst_stages_mask = vk::PipelineStageFlags2::BOTTOM_OF_PIPE;
        let dst_access_mask = vk::AccessFlags2::empty();

        // First let's change the layout to color attachment optimal on the universal queue.
        {
            let cmd_pool = make_command_pool(vk, qf_index)?;
            let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let barrier = make_image_memory_barrier2(
                src_stage_mask,
                src_access_mask,
                dst_stages_mask,
                dst_access_mask,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                image.get(),
                srr,
            );

            begin_command_buffer(vk, *cmd_buffer)?;
            record_image_barrier(vk, *cmd_buffer, barrier);
            end_command_buffer(vk, *cmd_buffer)?;
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;
        }

        // Second: let's move it to the transfer dst layout on the compute queue.
        {
            let cmd_pool = make_command_pool(vk, compute_qf_index)?;
            let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let barrier = make_image_memory_barrier2(
                src_stage_mask,
                src_access_mask,
                dst_stages_mask,
                dst_access_mask,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                image.get(),
                srr,
            );

            begin_command_buffer(vk, *cmd_buffer)?;
            record_image_barrier(vk, *cmd_buffer, barrier);
            end_command_buffer(vk, *cmd_buffer)?;
            submit_commands_and_wait(vk, compute_queue, *cmd_buffer)?;
        }

        // Finally: clean it on the universal queue again and copy it out.
        {
            let cmd_pool = make_command_pool(vk, qf_index)?;
            let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let clear_color_vk = vk::ClearColorValue { float32: clear_color };

            begin_command_buffer(vk, *cmd_buffer)?;
            unsafe {
                vk.cmd_clear_color_image(
                    *cmd_buffer,
                    image.get(),
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    &clear_color_vk,
                    &[srr],
                )
            };
            {
                // After the clear, copy the image out.
                let comp_stage = vk::PipelineStageFlags2::COMPUTE_SHADER;
                let barrier = make_image_memory_barrier2(
                    vk::PipelineStageFlags2::ALL_TRANSFER,
                    vk::AccessFlags2::TRANSFER_WRITE,
                    comp_stage,
                    vk::AccessFlags2::SHADER_READ,
                    vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                    image_read_layout,
                    image.get(),
                    srr,
                );
                record_image_barrier(vk, *cmd_buffer, barrier);

                unsafe {
                    vk.cmd_bind_descriptor_sets(
                        *cmd_buffer,
                        vk::PipelineBindPoint::COMPUTE,
                        pipeline.get_pipeline_layout(),
                        0,
                        &[*descriptor_set],
                        &[],
                    );
                }
                pipeline.bind(*cmd_buffer);
                unsafe { vk.cmd_dispatch(*cmd_buffer, 1, 1, 1) };

                let barrier2 = make_memory_barrier2(
                    comp_stage,
                    vk::AccessFlags2::SHADER_WRITE,
                    vk::PipelineStageFlags2::HOST,
                    vk::AccessFlags2::HOST_READ,
                );
                record_mem_barrier(vk, *cmd_buffer, barrier2);
            }
            end_command_buffer(vk, *cmd_buffer)?;
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;
        }

        // Verify it matches the clear color.
        {
            let buffer_alloc = buffer.get_allocation();
            invalidate_alloc(vk, buffer_alloc)?;

            let value_count = (buffer_size / std::mem::size_of::<f32>() as u64) as usize;
            let result = unsafe {
                std::slice::from_raw_parts(buffer_alloc.get_host_ptr().cast_const().cast::<f32>(), value_count)
            };

            // tcu::floatThresholdCompare with a zero threshold: every texel has to equal the clear colour.
            let mut max_diff = [0.0f32; 4];
            for texel in result.chunks_exact(4) {
                for c in 0..4 {
                    max_diff[c] = max_diff[c].max((texel[c] - clear_color[c]).abs());
                }
            }
            if max_diff.iter().any(|&d| d > 0.0) {
                log::info!(
                    "Result comparison failed: expected {clear_color:?} in every texel, max difference per channel {max_diff:?}"
                );
                return Ok(TestStatus::fail(
                    "Unexpected results in color buffer; check log for details --",
                ));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestCase for ComputeTransitionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_synchronization2")?;
        if context.get_compute_queue().is_none() {
            return Err(TestError::NotSupported("no compute-only queue family".to_string()));
        }

        if self.storage_usage {
            let format = self.get_image_format();
            let image_type = self.get_image_type();
            let image_tiling = self.get_image_tiling();
            let image_usage = self.get_image_usage();

            let result = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    format,
                    image_type,
                    image_tiling,
                    image_usage,
                    vk::ImageCreateFlags::empty(),
                )
            };

            match result {
                Ok(properties) => {
                    if !properties.sample_counts.contains(self.get_image_sample_count()) {
                        return Err(TestError::NotSupported("Sample count not supported".to_string()));
                    }
                }
                Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) => {
                    return Err(TestError::NotSupported("Format not supported".to_string()));
                }
                Err(_) => {
                    return Err(TestError::Fail(
                        "Unexpected result in vkGetPhysicalDeviceImageFormatProperties".to_string(),
                    ));
                }
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ComputeTransitionInstance { context, case: *self })
    }
}

struct ComputeTransitionInstance<'a> {
    context: &'a Context<'a>,
    case: ComputeTransitionCase,
}

impl TestInstance for ComputeTransitionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.case.iterate(self.context)
    }
}

/// `createImageLayoutTransitionTests`
pub fn create_image_layout_transition_tests() -> TestCaseGroup {
    use crate::generated::shaders::synchronization_layout_transition as g;

    // No-op image layout transition tests
    let mut test_group = TestCaseGroup::new("layout_transition");
    test_group.add_child(Box::new(g::NO_OP) as Box<dyn TestCase>);

    test_group.add_child(Box::new(g::COMPUTE_TRANSITION) as Box<dyn TestCase>);
    test_group.add_child(Box::new(g::COMPUTE_TRANSITION_STORAGE) as Box<dyn TestCase>);

    test_group
}
