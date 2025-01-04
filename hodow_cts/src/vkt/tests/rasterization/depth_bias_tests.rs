// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/data/vulkan/amber/rasterization/depth_bias/*.amber
//   external/vulkancts/data/vulkan/amber/rasterization/line_continuity/{line-strip,polygon-mode-lines}.amber
//   external/vulkancts/modules/vulkan/rasterization/vktRasterizationTests.cpp (the `depth_bias` group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 Google LLC.
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What the Amber pipelines do is done directly, in one render pass. Ported: the six
// `<format>_constant_one_less` and `_greater` scripts, which draw a quad whose depth goes from 0.3 to 0.5 twice, red with no depth bias and
// green with a constant depth bias of -1 (compare op less) or 1 (2 for D16, compare op greater), and expect the framebuffer to be green
// everywhere. Also ported: `<format>_constant_one` and `d16_unorm_slope`, which draw the quad into three depth buffers with no bias, with the
// second and with the third bias and compare the depth values at two corners; the script dumps the depth through a sampler into R32_SFLOAT
// images and verifies them in a compute shader, here the depth aspect is copied to a buffer and verified on the host. The three `<format>` scripts
// (two rectangles drawn with a bias of a constant and a slope together) are ported the same way. The `line_continuity` scripts (both) are here too;
// their flood-fill compute shader runs on the host over the read back image.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::rasterization_depth_bias::{DEPTH_BIAS_RECT, DEPTH_BIAS_SIMPLE, DEPTH_BIAS_WHITE};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const FRAMEBUFFER_SIZE: u32 = 256;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

struct DepthBiasCase {
    name: &'static str,
    format: vk::Format,
    /// The compare op and the constant bias of the second pipeline
    second_compare_op: vk::CompareOp,
    second_bias: f32,
}

fn check_format_support(
    context: &Context<'_>,
    format: vk::Format,
    usage: vk::ImageUsageFlags,
) -> Result<(), TestError> {
    let result = unsafe {
        context.get_instance().get_physical_device_image_format_properties(
            context.get_physical_device(),
            format,
            vk::ImageType::_2D,
            vk::ImageTiling::OPTIMAL,
            usage,
            vk::ImageCreateFlags::empty(),
        )
    };
    if result.is_err() {
        return Err(TestError::NotSupported(format!(
            "Image format {format:?} not supported"
        )));
    }
    Ok(())
}

impl TestCase for DepthBiasCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_format_support(context, self.format, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)
    }

    fn programs(&self) -> BinaryCollection {
        DEPTH_BIAS_SIMPLE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthBiasInstance {
            context,
            format: self.format,
            second_compare_op: self.second_compare_op,
            second_bias: self.second_bias,
        })
    }
}

struct DepthBiasInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    second_compare_op: vk::CompareOp,
    second_bias: f32,
}

fn has_stencil(format: vk::Format) -> bool {
    matches!(format, vk::Format::D24_UNORM_S8_UINT | vk::Format::D32_SFLOAT_S8_UINT)
}

fn make_host_buffer<'a>(
    device: &'a Device,
    allocator: &SimpleAllocator,
    usage: vk::BufferUsageFlags,
    data: &[f32],
) -> Result<BufferWithMemory<'a>, TestError> {
    let buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(std::mem::size_of_val(data) as u64, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            data.as_ptr().cast::<u8>(),
            buffer.get_allocation().get_host_ptr(),
            std::mem::size_of_val(data),
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

fn make_depth_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: &[(vk::ShaderStageFlags, vk::ShaderModule)],
    compare_op: vk::CompareOp,
    bias: f32,
    slope: f32,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP);
    state.bindings = vec![vk::VertexInputBindingDescription {
        binding: 0,
        stride: 16,
        input_rate: vk::VertexInputRate::VERTEX,
    }];
    state.attributes = vec![vk::VertexInputAttributeDescription {
        location: 0,
        binding: 0,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset: 0,
    }];
    state.viewports = vec![viewport(
        0.0,
        0.0,
        FRAMEBUFFER_SIZE as f32,
        FRAMEBUFFER_SIZE as f32,
        0.0,
        1.0,
    )];
    state.scissors = vec![rect_2d(FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE)];
    state.rasterization.depth_bias_enable = vk::TRUE;
    state.rasterization.depth_bias_constant_factor = bias;
    state.rasterization.depth_bias_clamp = 0.0;
    state.rasterization.depth_bias_slope_factor = slope;
    state.depth_stencil.depth_test_enable = vk::TRUE;
    state.depth_stencil.depth_write_enable = vk::TRUE;
    state.depth_stencil.depth_compare_op = compare_op;
    state.depth_stencil.depth_bounds_test_enable = vk::FALSE;
    state.depth_stencil.min_depth_bounds = 0.0;
    state.depth_stencil.max_depth_bounds = 1.0;
    create_draw_pipeline(device, layout, render_pass, stages, &state)
}

impl TestInstance for DepthBiasInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_aspect = if has_stencil(self.format) {
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::DEPTH
        };
        let extent = vk::Extent3D {
            width: FRAMEBUFFER_SIZE,
            height: FRAMEBUFFER_SIZE,
            depth: 1,
        };
        let make_image = |format: vk::Format, usage: vk::ImageUsageFlags| {
            ImageWithMemory::new(
                device,
                allocator,
                vk::ImageCreateInfo {
                    s_type: vk::StructureType::IMAGE_CREATE_INFO,
                    next: std::ptr::null(),
                    flags: vk::ImageCreateFlags::empty(),
                    image_type: vk::ImageType::_2D,
                    format,
                    extent,
                    mip_levels: 1,
                    array_layers: 1,
                    samples: vk::SampleCountFlags::_1,
                    tiling: vk::ImageTiling::OPTIMAL,
                    usage,
                    sharing_mode: vk::SharingMode::EXCLUSIVE,
                    queue_family_index_count: 0,
                    queue_family_indices: std::ptr::null(),
                    initial_layout: vk::ImageLayout::UNDEFINED,
                },
                MemoryRequirement::ANY,
            )
        };
        let color_image = make_image(
            COLOR_FORMAT,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let depth_image = make_image(self.format, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            self.format,
            make_image_subresource_range(depth_aspect, 0, 1, 0, 1),
        )?;

        // The render pass: a cleared colour attachment and a cleared depth attachment
        let attachments = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(self.format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_refs = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let depth_ref = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_refs)
            .depth_stencil_attachment(&depth_ref)
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
            &[*color_view, *depth_view],
            FRAMEBUFFER_SIZE,
            FRAMEBUFFER_SIZE,
            1,
        )?;

        // The quad: depth goes from 0.3 to 0.5, and the colours of the two draws
        let positions: [[f32; 4]; 4] = [
            [-1.0, -1.0, 0.3, 1.0],
            [1.0, -1.0, 0.5, 1.0],
            [-1.0, 1.0, 0.3, 1.0],
            [1.0, 1.0, 0.5, 1.0],
        ];
        let position_flat: Vec<f32> = positions.iter().flatten().copied().collect();
        let position_buffer = make_host_buffer(device, allocator, vk::BufferUsageFlags::VERTEX_BUFFER, &position_flat)?;
        let color_buffer1 = make_host_buffer(
            device,
            allocator,
            vk::BufferUsageFlags::STORAGE_BUFFER,
            &[1.0, 0.0, 0.0, 1.0],
        )?;
        let color_buffer2 = make_host_buffer(
            device,
            allocator,
            vk::BufferUsageFlags::STORAGE_BUFFER,
            &[0.0, 1.0, 0.0, 1.0],
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
        let descriptor_set1 = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_set2 = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        for (set, buffer) in [(&descriptor_set1, &color_buffer1), (&descriptor_set2, &color_buffer2)] {
            let info = vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            };
            let write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: &info,
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        }

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ];
        let pipeline1 = make_depth_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &stages,
            vk::CompareOp::LESS,
            0.0,
            0.0,
        )?;
        let pipeline2 = make_depth_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &stages,
            self.second_compare_op,
            self.second_bias,
            0.0,
        )?;

        let output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                u64::from(FRAMEBUFFER_SIZE * FRAMEBUFFER_SIZE) * 4,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [1.0, 1.0, 1.0, 1.0],
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[position_buffer.get()], &[0]);

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline1.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set1.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 4, 1, 0, 0);

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline2.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set2.get()],
                &[] as &[u32],
            );
            device.cmd_draw(cmd, 4, 1, 0, 0);

            device.cmd_end_render_pass(cmd);
        }

        // Read the framebuffer back
        let barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            color_srr,
        );
        let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer.get(),
                &[make_buffer_image_copy(
                    extent,
                    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                )],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, output_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                (FRAMEBUFFER_SIZE * FRAMEBUFFER_SIZE * 4) as usize,
            )
        };

        // EXPECT framebuffer IDX 0 0 SIZE 256 256 EQ_RGBA 0 255 0 255
        if let Some((index, _)) = pixels
            .chunks_exact(4)
            .enumerate()
            .find(|(_, pixel)| **pixel != [0u8, 255, 0, 255])
        {
            log::info!(
                "Pixel {index} is not (0, 255, 0, 255): {:?}",
                &pixels[index * 4..index * 4 + 4]
            );
            return Ok(TestStatus::fail("The framebuffer is not green everywhere"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `<format>.amber` (d16_unorm, d24_unorm, d32_sfloat): two rectangles of constant depth 0.3 and 0.5 (0..200 and 56..256 pixels) are drawn with a depth bias
/// of a large constant and a slope of 2, the depth is read back and compared at the corners the rectangles do and do not cover
struct DepthBiasRectCase {
    name: &'static str,
    format: vk::Format,
    bias_constant: f32,
    /// The script dumps the depth buffer as RGBA8 and compares with a tolerance of 5% (d32_sfloat) instead of loading the depth as float
    quantized: bool,
}

impl TestCase for DepthBiasRectCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_format_support(
            context,
            self.format,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )
    }

    fn programs(&self) -> BinaryCollection {
        DEPTH_BIAS_RECT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthBiasRectInstance {
            context,
            format: self.format,
            bias_constant: self.bias_constant,
            quantized: self.quantized,
        })
    }
}

struct DepthBiasRectInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    bias_constant: f32,
    quantized: bool,
}

impl TestInstance for DepthBiasRectInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let depth_aspect = if has_stencil(self.format) {
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::DEPTH
        };
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_srr = make_image_subresource_range(depth_aspect, 0, 1, 0, 1);
        let extent = vk::Extent3D {
            width: FRAMEBUFFER_SIZE,
            height: FRAMEBUFFER_SIZE,
            depth: 1,
        };
        let make_image = |format: vk::Format, usage: vk::ImageUsageFlags| {
            ImageWithMemory::new(
                device,
                allocator,
                vk::ImageCreateInfo {
                    s_type: vk::StructureType::IMAGE_CREATE_INFO,
                    next: std::ptr::null(),
                    flags: vk::ImageCreateFlags::empty(),
                    image_type: vk::ImageType::_2D,
                    format,
                    extent,
                    mip_levels: 1,
                    array_layers: 1,
                    samples: vk::SampleCountFlags::_1,
                    tiling: vk::ImageTiling::OPTIMAL,
                    usage,
                    sharing_mode: vk::SharingMode::EXCLUSIVE,
                    queue_family_index_count: 0,
                    queue_family_indices: std::ptr::null(),
                    initial_layout: vk::ImageLayout::UNDEFINED,
                },
                MemoryRequirement::ANY,
            )
        };
        let color_image = make_image(COLOR_FORMAT, vk::ImageUsageFlags::COLOR_ATTACHMENT)?;
        let depth_image = make_image(
            self.format,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            self.format,
            depth_srr,
        )?;

        let attachments = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(self.format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_refs = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let depth_ref = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_refs)
            .depth_stencil_attachment(&depth_ref)
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
            &[*color_view, *depth_view],
            FRAMEBUFFER_SIZE,
            FRAMEBUFFER_SIZE,
            1,
        )?;

        // DRAW_RECT POS 0 0 SIZE 200 200 and DRAW_RECT POS 56 56 SIZE 200 200, in normalized device coordinates
        let ndc = |pixel: f32| 2.0 * pixel / FRAMEBUFFER_SIZE as f32 - 1.0;
        let rect = |x0: f32, y0: f32, x1: f32, y1: f32| -> Vec<f32> {
            vec![
                ndc(x0),
                ndc(y0),
                0.0,
                1.0, //
                ndc(x1),
                ndc(y0),
                0.0,
                1.0, //
                ndc(x0),
                ndc(y1),
                0.0,
                1.0, //
                ndc(x1),
                ndc(y1),
                0.0,
                1.0,
            ]
        };
        let rect_buffer1 = make_host_buffer(
            device,
            allocator,
            vk::BufferUsageFlags::VERTEX_BUFFER,
            &rect(0.0, 0.0, 200.0, 200.0),
        )?;
        let rect_buffer2 = make_host_buffer(
            device,
            allocator,
            vk::BufferUsageFlags::VERTEX_BUFFER,
            &rect(56.0, 56.0, 256.0, 256.0),
        )?;
        let data_buffer1 = make_host_buffer(
            device,
            allocator,
            vk::BufferUsageFlags::STORAGE_BUFFER,
            &[1.0, 0.0, 0.0, 1.0, 0.3],
        )?;
        let data_buffer2 = make_host_buffer(
            device,
            allocator,
            vk::BufferUsageFlags::STORAGE_BUFFER,
            &[0.0, 1.0, 0.0, 1.0, 0.5],
        )?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::VERTEX)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 2)?;
        let descriptor_set1 = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let descriptor_set2 = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        for (set, buffer) in [(&descriptor_set1, &data_buffer1), (&descriptor_set2, &data_buffer2)] {
            let info = vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: vk::WHOLE_SIZE,
            };
            let write = vk::WriteDescriptorSet {
                s_type: vk::StructureType::WRITE_DESCRIPTOR_SET,
                next: std::ptr::null(),
                dst_set: set.get(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: 1,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                image_info: std::ptr::null(),
                buffer_info: &info,
                texel_buffer_view: std::ptr::null(),
            };
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
        }

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline = make_depth_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::FRAGMENT, *frag_module),
            ],
            vk::CompareOp::LESS,
            self.bias_constant,
            2.0,
        )?;

        let texel_size = u64::from(depth_texel_size(self.format));
        let readback_size = u64::from(FRAMEBUFFER_SIZE * FRAMEBUFFER_SIZE) * texel_size;
        let readback = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(readback_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [1.0, 1.0, 1.0, 1.0],
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            for (rect_buffer, set) in [(&rect_buffer1, &descriptor_set1), (&rect_buffer2, &descriptor_set2)] {
                device.cmd_bind_vertex_buffers(cmd, 0, &[rect_buffer.get()], &[0]);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[set.get()],
                    &[] as &[u32],
                );
                device.cmd_draw(cmd, 4, 1, 0, 0);
            }
            device.cmd_end_render_pass(cmd);
        }

        let barrier = make_image_memory_barrier(
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            depth_image.get(),
            depth_srr,
        );
        let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                depth_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                readback.get(),
                &[make_buffer_image_copy(
                    extent,
                    make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
                )],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, readback.get_allocation())?;
        let bytes = unsafe {
            std::slice::from_raw_parts(
                readback.get_allocation().get_host_ptr().cast_const(),
                readback_size as usize,
            )
        };
        let depth_at = |x: u32, y: u32| depth_value(self.format, bytes, x, y);

        let ok = if self.quantized {
            // EXPECT ddump IDX x y SIZE 1 1 EQ_RGBA v v v 255 TOLERANCE 5% 5% 5% 0, the depth dumped as RGBA8
            let close =
                |depth: f32, expected: f32| ((depth.clamp(0.0, 1.0) * 255.0).round() - expected).abs() <= 0.05 * 255.0;
            close(depth_at(0, 0), 108.0)
                && close(depth_at(255, 0), 255.0)
                && close(depth_at(0, 255), 255.0)
                && close(depth_at(255, 255), 191.0)
        } else {
            // The constant bias is 0.25 or 0.5 (two values are accepted for the minimum resolvable difference), so the depth of the first rectangle is
            // 0.55 or 0.8 and the one of the second 0.75 or 1.0
            let distance = |a: f32, b: f32| (a - b).abs();
            let depth0 = depth_at(0, 0);
            let depth1 = depth_at(255, 255);
            (distance(0.55, depth0) < 0.003 || distance(0.8, depth0) < 0.003)
                && (distance(0.75, depth1) < 0.003 || distance(1.0, depth1) < 0.003)
        };

        if !ok {
            log::info!(
                "depth at (0, 0) {}, (255, 0) {}, (0, 255) {}, (255, 255) {}",
                depth_at(0, 0),
                depth_at(255, 0),
                depth_at(0, 255),
                depth_at(255, 255)
            );
            return Ok(TestStatus::fail("The depth values do not match the bias"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// How the depth of the pipelines with a bias is checked against the one without
#[derive(Clone, Copy)]
enum Verification {
    /// The bias is one or minus one unit of the smallest resolvable difference `r`, of which there are two accepted values: `r0` and `r1`
    ConstantOne { r0: f32, r1: f32 },
    /// The bias is the maximum depth slope `m` of the quad, in either direction
    Slope { m: f32 },
}

struct DepthBiasDumpCase {
    name: &'static str,
    format: vk::Format,
    /// The constant factor and the slope factor of the second and third pipeline
    biases: [(f32, f32); 2],
    verification: Verification,
}

impl TestCase for DepthBiasDumpCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_format_support(
            context,
            self.format,
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )
    }

    fn programs(&self) -> BinaryCollection {
        DEPTH_BIAS_WHITE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthBiasDumpInstance {
            context,
            format: self.format,
            biases: self.biases,
            verification: self.verification,
        })
    }
}

struct DepthBiasDumpInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    biases: [(f32, f32); 2],
    verification: Verification,
}

fn depth_texel_size(format: vk::Format) -> u32 {
    if format == vk::Format::D16_UNORM { 2 } else { 4 }
}

fn depth_value(format: vk::Format, bytes: &[u8], x: u32, y: u32) -> f32 {
    let texel = (y * FRAMEBUFFER_SIZE + x) as usize;
    match format {
        vk::Format::D16_UNORM => {
            let raw = u16::from_ne_bytes([bytes[texel * 2], bytes[texel * 2 + 1]]);
            f32::from(raw) / 65535.0
        }
        vk::Format::D24_UNORM_S8_UINT => {
            let raw = u32::from_ne_bytes([
                bytes[texel * 4],
                bytes[texel * 4 + 1],
                bytes[texel * 4 + 2],
                bytes[texel * 4 + 3],
            ]);
            (raw & 0x00FF_FFFF) as f32 / 16_777_215.0
        }
        _ => f32::from_ne_bytes([
            bytes[texel * 4],
            bytes[texel * 4 + 1],
            bytes[texel * 4 + 2],
            bytes[texel * 4 + 3],
        ]),
    }
}

impl TestInstance for DepthBiasDumpInstance<'_> {
    /// The three pipelines of the Amber script draw the same quad with no bias, with the second and with the third bias, each into a depth buffer of its
    /// own; the depth values are read back (the script dumps them through a sampler and verifies them in a compute shader) and compared.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_aspect = if has_stencil(self.format) {
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::DEPTH
        };
        let depth_srr = make_image_subresource_range(depth_aspect, 0, 1, 0, 1);
        let extent = vk::Extent3D {
            width: FRAMEBUFFER_SIZE,
            height: FRAMEBUFFER_SIZE,
            depth: 1,
        };
        let make_image = |format: vk::Format, usage: vk::ImageUsageFlags| {
            ImageWithMemory::new(
                device,
                allocator,
                vk::ImageCreateInfo {
                    s_type: vk::StructureType::IMAGE_CREATE_INFO,
                    next: std::ptr::null(),
                    flags: vk::ImageCreateFlags::empty(),
                    image_type: vk::ImageType::_2D,
                    format,
                    extent,
                    mip_levels: 1,
                    array_layers: 1,
                    samples: vk::SampleCountFlags::_1,
                    tiling: vk::ImageTiling::OPTIMAL,
                    usage,
                    sharing_mode: vk::SharingMode::EXCLUSIVE,
                    queue_family_index_count: 0,
                    queue_family_indices: std::ptr::null(),
                    initial_layout: vk::ImageLayout::UNDEFINED,
                },
                MemoryRequirement::ANY,
            )
        };
        let color_image = make_image(COLOR_FORMAT, vk::ImageUsageFlags::COLOR_ATTACHMENT)?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;
        let mut depth_images = Vec::new();
        let mut depth_views = Vec::new();
        for _ in 0..3 {
            let image = make_image(
                self.format,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            )?;
            depth_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                self.format,
                depth_srr,
            )?);
            depth_images.push(image);
        }

        // The render pass: a cleared colour attachment and a cleared depth attachment that is kept
        let attachments = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(self.format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_refs = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let depth_ref = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_refs)
            .depth_stencil_attachment(&depth_ref)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let mut framebuffers = Vec::new();
        for depth_view in &depth_views {
            framebuffers.push(make_framebuffer(
                device,
                *render_pass,
                &[*color_view, **depth_view],
                FRAMEBUFFER_SIZE,
                FRAMEBUFFER_SIZE,
                1,
            )?);
        }

        let positions: [f32; 16] = [
            -1.0, -1.0, 0.3, 1.0, //
            1.0, -1.0, 0.5, 1.0, //
            -1.0, 1.0, 0.3, 1.0, //
            1.0, 1.0, 0.5, 1.0,
        ];
        let position_buffer = make_host_buffer(device, allocator, vk::BufferUsageFlags::VERTEX_BUFFER, &positions)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vert_module),
            (vk::ShaderStageFlags::FRAGMENT, *frag_module),
        ];
        let pipelines = [
            make_depth_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                vk::CompareOp::LESS,
                0.0,
                0.0,
            )?,
            make_depth_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                vk::CompareOp::LESS,
                self.biases[0].0,
                self.biases[0].1,
            )?,
            make_depth_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                vk::CompareOp::LESS,
                self.biases[1].0,
                self.biases[1].1,
            )?,
        ];

        let texel_size = u64::from(depth_texel_size(self.format));
        let readback_size = u64::from(FRAMEBUFFER_SIZE * FRAMEBUFFER_SIZE) * texel_size;
        let mut readbacks = Vec::new();
        for _ in 0..3 {
            readbacks.push(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(readback_size, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [1.0, 1.0, 1.0, 1.0],
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];
        for i in 0..3 {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffers[i])
                .render_area(rect_2d(FRAMEBUFFER_SIZE, FRAMEBUFFER_SIZE))
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_vertex_buffers(cmd, 0, &[position_buffer.get()], &[0]);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipelines[i].get());
                device.cmd_draw(cmd, 4, 1, 0, 0);
                device.cmd_end_render_pass(cmd);
            }
        }

        // Read the depth values back
        for i in 0..3 {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                depth_images[i].get(),
                depth_srr,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    depth_images[i].get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    readbacks[i].get(),
                    &[make_buffer_image_copy(
                        extent,
                        make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
                    )],
                );
            }
        }
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

        let mut depths: Vec<&[u8]> = Vec::new();
        for readback in &readbacks {
            invalidate_alloc(device, readback.get_allocation())?;
            depths.push(unsafe {
                std::slice::from_raw_parts(
                    readback.get_allocation().get_host_ptr().cast_const(),
                    readback_size as usize,
                )
            });
        }

        // The pixels the verification shader loads: the third depth buffer is read at (255, 55), as the script does
        let depth1_1 = depth_value(self.format, depths[0], 0, 0);
        let depth1_2 = depth_value(self.format, depths[0], 255, 255);
        let depth2_1 = depth_value(self.format, depths[1], 0, 0);
        let depth2_2 = depth_value(self.format, depths[1], 255, 255);
        let depth3_1 = depth_value(self.format, depths[2], 0, 0);
        let depth3_2 = depth_value(self.format, depths[2], 255, 55);

        let distance = |a: f32, b: f32| (a - b).abs();
        let (result0, result1) = match self.verification {
            Verification::ConstantOne { r0, r1 } => {
                let epsilon = 0.00001f32;
                (
                    (distance(depth1_1 + r0, depth2_1) < epsilon || distance(depth1_1 + r1, depth2_1) < epsilon)
                        && (distance(depth1_2 + r0, depth2_2) < epsilon || distance(depth1_2 + r1, depth2_2) < epsilon),
                    (distance(depth1_1 - r0, depth3_1) < epsilon || distance(depth1_1 - r1, depth3_1) < epsilon)
                        && (distance(depth1_2 - r0, depth3_2) < epsilon || distance(depth1_2 - r1, depth3_2) < epsilon),
                )
            }
            Verification::Slope { m } => {
                let epsilon = 0.00002f32;
                (
                    distance(depth1_1 + m, depth2_1) < epsilon && distance(depth1_2 + m, depth2_2) < epsilon,
                    distance(depth1_1 - m, depth3_1) < epsilon && distance(depth1_2 - m, depth3_2) < epsilon,
                )
            }
        };

        // EXPECT results IDX 0 EQ 1.0 and IDX 4 EQ 1.0
        if !result0 || !result1 {
            log::info!(
                "depth1 ({depth1_1}, {depth1_2}), depth2 ({depth2_1}, {depth2_2}), depth3 ({depth3_1}, {depth3_2}); results {result0} {result1}"
            );
            return Ok(TestStatus::fail("The depth values do not match the bias"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `depth_bias` group of `createRasterizationTests`
pub fn create_depth_bias_amber_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("depth_bias");

    let ported = [
        (
            "d16_unorm_constant_one_less",
            vk::Format::D16_UNORM,
            vk::CompareOp::LESS,
            -1.0,
        ),
        (
            "d16_unorm_constant_one_greater",
            vk::Format::D16_UNORM,
            vk::CompareOp::GREATER,
            2.0,
        ),
        (
            "d24_unorm_constant_one_less",
            vk::Format::D24_UNORM_S8_UINT,
            vk::CompareOp::LESS,
            -1.0,
        ),
        (
            "d24_unorm_constant_one_greater",
            vk::Format::D24_UNORM_S8_UINT,
            vk::CompareOp::GREATER,
            1.0,
        ),
        (
            "d32_sfloat_constant_one_less",
            vk::Format::D32_SFLOAT,
            vk::CompareOp::LESS,
            -1.0,
        ),
        (
            "d32_sfloat_constant_one_greater",
            vk::Format::D32_SFLOAT,
            vk::CompareOp::GREATER,
            1.0,
        ),
    ];
    for (name, format, second_compare_op, second_bias) in ported {
        group.add_child(Box::new(DepthBiasCase {
            name,
            format,
            second_compare_op,
            second_bias,
        }) as Box<dyn TestCase>);
    }

    let dump_cases = [
        (
            "d16_unorm_constant_one",
            vk::Format::D16_UNORM,
            [(1.0, 0.0), (-1.0, 0.0)],
            Verification::ConstantOne {
                r0: 1.0 / 65536.0,
                r1: 1.0 / 32768.0,
            },
        ),
        (
            "d24_unorm_constant_one",
            vk::Format::D24_UNORM_S8_UINT,
            [(1.0, 0.0), (-1.0, 0.0)],
            Verification::ConstantOne {
                r0: 1.0 / 16_777_216.0,
                r1: 1.0 / 8_388_608.0,
            },
        ),
        (
            "d32_sfloat_constant_one",
            vk::Format::D32_SFLOAT,
            [(1.0, 0.0), (-1.0, 0.0)],
            Verification::ConstantOne {
                r0: 1.0 / 33_554_432.0,
                r1: 1.0 / 16_777_216.0,
            },
        ),
        (
            "d16_unorm_slope",
            vk::Format::D16_UNORM,
            [(0.0, 1.0), (0.0, -1.0)],
            Verification::Slope { m: 0.2 / 256.0 },
        ),
    ];
    for (name, format, biases, verification) in dump_cases {
        group.add_child(Box::new(DepthBiasDumpCase {
            name,
            format,
            biases,
            verification,
        }) as Box<dyn TestCase>);
    }

    for (name, format, bias_constant, quantized) in [
        ("d16_unorm", vk::Format::D16_UNORM, 16384.0, false),
        ("d32_sfloat", vk::Format::D32_SFLOAT, 4_194_304.0, true),
        ("d24_unorm", vk::Format::D24_UNORM_S8_UINT, 4_194_304.0, false),
    ] {
        group.add_child(Box::new(DepthBiasRectCase {
            name,
            format,
            bias_constant,
            quantized,
        }) as Box<dyn TestCase>);
    }

    group
}

/// `rasterization/line_continuity/{line-strip,polygon-mode-lines}.amber`: white lines are drawn into a black 256x256 image; starting from any lit pixel in a
/// block of 32x4 pixels at `search_row`, a flood fill over the 8 neighbours erases every connected lit pixel (the script does it in a compute shader on
/// the image); the lines are continuous when the image is black afterwards, rows 0 to 254.
struct LineContinuityCase {
    name: &'static str,
    topology: vk::PrimitiveTopology,
    polygon_mode: vk::PolygonMode,
    search_row: u32,
    /// The vertices as the R8G8B8A8_SNORM bytes x, y, 0, 127
    vertices: &'static [[i8; 2]],
}

impl TestCase for LineContinuityCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.polygon_mode != vk::PolygonMode::FILL && context.get_device_features().fill_mode_non_solid == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Core feature fillModeNonSolid not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DEPTH_BIAS_WHITE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(LineContinuityInstance { context, case: self })
    }
}

struct LineContinuityInstance<'a> {
    context: &'a Context<'a>,
    case: &'a LineContinuityCase,
}

impl TestInstance for LineContinuityInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let case = self.case;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let size = FRAMEBUFFER_SIZE;

        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let extent = vk::Extent3D {
            width: size,
            height: size,
            depth: 1,
        };
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            vk::ImageCreateInfo {
                s_type: vk::StructureType::IMAGE_CREATE_INFO,
                next: std::ptr::null(),
                flags: vk::ImageCreateFlags::empty(),
                image_type: vk::ImageType::_2D,
                format: COLOR_FORMAT,
                extent,
                mip_levels: 1,
                array_layers: 1,
                samples: vk::SampleCountFlags::_1,
                tiling: vk::ImageTiling::OPTIMAL,
                usage: vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                sharing_mode: vk::SharingMode::EXCLUSIVE,
                queue_family_index_count: 0,
                queue_family_indices: std::ptr::null(),
                initial_layout: vk::ImageLayout::UNDEFINED,
            },
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;
        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], size, size, 1)?;

        let mut vertex_bytes = Vec::new();
        for vertex in case.vertices {
            vertex_bytes.extend_from_slice(&[vertex[0] as u8, vertex[1] as u8, 0, 127]);
        }
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_bytes.len() as u64, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex_bytes.as_ptr(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_bytes.len(),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let mut state = DrawPipelineState::new(case.topology);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 4,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R8G8B8A8_SNORM,
            offset: 0,
        }];
        state.viewports = vec![viewport(0.0, 0.0, size as f32, size as f32, 0.0, 1.0)];
        state.scissors = vec![rect_2d(size, size)];
        state.rasterization.polygon_mode = case.polygon_mode;
        state.rasterization.depth_bias_enable = vk::FALSE;
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

        let output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(u64::from(size * size) * 4, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            rect_2d(size, size),
            clear_value_color([0.0, 0.0, 0.0, 1.0]),
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, case.vertices.len() as u32, 1, 0, 0);
        }
        end_render_pass(device, cmd);

        let barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            color_srr,
        );
        let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                output_buffer.get(),
                &[make_buffer_image_copy(
                    extent,
                    make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                )],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[host_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, output_buffer.get_allocation())?;
        let mut pixels = unsafe {
            std::slice::from_raw_parts(
                output_buffer.get_allocation().get_host_ptr().cast_const(),
                (size * size * 4) as usize,
            )
        }
        .to_vec();

        let width = size as i32;
        let background = [0u8, 0, 0, 255];
        let is_background = |pixels: &[u8], x: i32, y: i32| {
            let offset = ((y * width + x) * 4) as usize;
            pixels[offset..offset + 4] == background
        };

        // Search for any pixel belonging to a line, in the 32 x 4 block the compute shader's work group covers
        let start = (0..4)
            .flat_map(|y| (0..32).map(move |x| (x, y)))
            .map(|(x, y)| (x, y + case.search_row as i32))
            .find(|&(x, y)| !is_background(&pixels, x, y));

        if let Some(start) = start {
            // Consume the pixels connected to it: erase the popped pixel, push its lit neighbours
            let mut stack = vec![start];
            while let Some((x, y)) = stack.pop() {
                let offset = ((y * width + x) * 4) as usize;
                pixels[offset..offset + 4].copy_from_slice(&background);

                for dy in -1..=1 {
                    for dx in -1..=1 {
                        let (nx, ny) = (x + dx, y + dy);
                        if nx >= 0 && ny >= 0 && nx < width && ny < width && !is_background(&pixels, nx, ny) {
                            stack.push((nx, ny));
                        }
                    }
                }
            }
        }

        // Everything should be the clear color since the checker consumes the drawn pixels if they are continuous.
        for y in 0..width - 1 {
            for x in 0..width {
                if !is_background(&pixels, x, y) {
                    log::info!("The pixel ({x}, {y}) is not connected to the first line pixel");
                    return Ok(TestStatus::fail("The lines are not continuous"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `line_continuity` group of `createRasterizationTests`
pub fn create_line_continuity_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("line_continuity");

    // Test line strip drawing produces continuous lines
    group.add_child(Box::new(LineContinuityCase {
        name: "line-strip",
        topology: vk::PrimitiveTopology::LINE_STRIP,
        polygon_mode: vk::PolygonMode::FILL,
        search_row: 128,
        vertices: &[
            [-120, -120],
            [-119, 120],
            [120, 119],
            [10, 20],
            [-80, 20],
            [-80, 95],
            [-83, 95],
            [-83, -95],
            [-85, 95],
        ],
    }) as Box<dyn TestCase>);

    // Test triangles drawn with lines are continuous
    group.add_child(Box::new(LineContinuityCase {
        name: "polygon-mode-lines",
        topology: vk::PrimitiveTopology::TRIANGLE_LIST,
        polygon_mode: vk::PolygonMode::LINE,
        search_row: 10,
        vertices: &[
            [-120, -120],
            [0, 120],
            [120, -120],
            [0, 0],
            [120, 0],
            [60, -60],
            [-100, 100],
            [110, 100],
            [110, 103],
        ],
    }) as Box<dyn TestCase>);

    group
}
