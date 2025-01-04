// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_ops/vktFragmentOperationsScissorMultiViewportTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// One point per viewport, each expanded by a geometry shader into a fullscreen quad in its own viewport;
// every viewport has its own scissor rectangle, so the result is a colourful grid. The shaders are in
// `shaders/manifest/fragment_ops_scissor_multi_viewport.toml`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::fragment_ops_scissor_multi_viewport::SCISSOR_MULTI_VIEWPORT;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Minimum number of viewports for an implementation supporting multiViewport.
const MIN_MAX_VIEWPORTS: u32 = 16;
const RENDER_SIZE: u32 = 128;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `generateScissors`: the rectangles are arranged in a grid.
fn generate_scissors(num_scissors: u32, render_size: u32) -> Vec<[i32; 4]> {
    let num_cols = (num_scissors as f32).sqrt().ceil() as u32;
    let num_rows = (num_scissors as f32 / num_cols as f32).ceil() as u32;
    let rect_width = (render_size / num_cols) as i32;
    let rect_height = (render_size / num_rows) as i32;

    let mut scissors = Vec::with_capacity(num_scissors as usize);
    let (mut x, mut y) = (0i32, 0i32);

    for scissor_ndx in 0..num_scissors {
        let next_row = scissor_ndx != 0 && scissor_ndx % num_cols == 0;
        if next_row {
            x = 0;
            y += rect_height;
        }

        scissors.push([x, y, rect_width, rect_height]);

        x += rect_width;
    }
    scissors
}

/// `generateColors`
fn generate_colors(num_colors: usize) -> Vec<[f32; 4]> {
    let colors: [[f32; 4]; 16] = [
        [0.18, 0.42, 0.17, 1.0],
        [0.29, 0.62, 0.28, 1.0],
        [0.59, 0.84, 0.44, 1.0],
        [0.96, 0.95, 0.72, 1.0],
        [0.94, 0.55, 0.39, 1.0],
        [0.82, 0.19, 0.12, 1.0],
        [0.46, 0.15, 0.26, 1.0],
        [0.24, 0.14, 0.24, 1.0],
        [0.49, 0.31, 0.26, 1.0],
        [0.78, 0.52, 0.33, 1.0],
        [0.94, 0.82, 0.31, 1.0],
        [0.98, 0.65, 0.30, 1.0],
        [0.22, 0.65, 0.53, 1.0],
        [0.67, 0.81, 0.91, 1.0],
        [0.43, 0.44, 0.75, 1.0],
        [0.26, 0.24, 0.48, 1.0],
    ];
    colors[..num_colors].to_vec()
}

fn float_to_unorm8(value: f32) -> u8 {
    (value * 255.0 + 0.5) as u8
}

/// `generateReferenceImage`: renders a colourful grid of rectangles.
fn generate_reference_image(clear_color: [f32; 4], scissors: &[[i32; 4]], scissor_colors: &[[f32; 4]]) -> Vec<u8> {
    let mut image = vec![0u8; (RENDER_SIZE * RENDER_SIZE * 4) as usize];
    for texel in image.chunks_exact_mut(4) {
        texel.copy_from_slice(&clear_color.map(float_to_unorm8));
    }

    for (scissor, color) in scissors.iter().zip(scissor_colors) {
        for y in scissor[1]..scissor[1] + scissor[3] {
            for x in scissor[0]..scissor[0] + scissor[2] {
                let offset = ((y as u32 * RENDER_SIZE + x as u32) * 4) as usize;
                image[offset..offset + 4].copy_from_slice(&color.map(float_to_unorm8));
            }
        }
    }
    image
}

struct ScissorMultiViewportCase {
    name: String,
    num_viewports: u32,
}

impl TestCase for ScissorMultiViewportCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("geometryShader not supported".to_string()));
        }
        if features.multi_viewport == vk::FALSE {
            return Err(TestError::NotSupported("multiViewport not supported".to_string()));
        }

        if context.get_device_properties().limits.max_viewports < MIN_MAX_VIEWPORTS {
            return Err(TestError::NotSupported(
                "Implementation doesn't support minimum required number of viewports".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        SCISSOR_MULTI_VIEWPORT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ScissorMultiViewportInstance {
            context,
            num_viewports: self.num_viewports,
        })
    }
}

struct ScissorMultiViewportInstance<'a> {
    context: &'a Context<'a>,
    num_viewports: u32,
}

impl TestInstance for ScissorMultiViewportInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let num_viewports = self.num_viewports;

        let clear_color = [0.5f32, 0.5, 0.5, 1.0];
        let vertex_colors = generate_colors(num_viewports as usize);
        let scissors = generate_scissors(num_viewports, RENDER_SIZE);

        let color_buffer_size = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::write_bytes(
                color_buffer.get_allocation().get_host_ptr(),
                0,
                color_buffer_size as usize,
            )
        };
        flush_alloc(device, color_buffer.get_allocation())?;

        log::info!(
            "Rendering a colorful grid of {num_viewports} rectangle(s). Not covered area will be filled with a gray color."
        );

        // ScissorRenderer
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let vertex_buffer_size = (vertex_colors.len() * std::mem::size_of::<[f32; 4]>()) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex_colors.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let geometry_module = create_shader_module(device, binaries.get("geom")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let render_pass = make_render_pass(device, COLOR_FORMAT)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let default_viewport = vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: RENDER_SIZE as f32,
            height: RENDER_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        };
        let viewports = vec![default_viewport; num_viewports as usize];
        let rect_scissors: Vec<vk::Rect2D> = scissors
            .iter()
            .map(|scissor| vk::Rect2D {
                offset: vk::Offset2D {
                    x: scissor[0],
                    y: scissor[1],
                },
                extent: vk::Extent2D {
                    width: scissor[2] as u32,
                    height: scissor[3] as u32,
                },
            })
            .collect();

        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vertex_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::GEOMETRY)
                .module(*geometry_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fragment_module)
                .name(b"main\0")
                .build(),
        ];
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::POINT_LIST)
            .primitive_restart_enable(false);
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&rect_scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // draw
        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                },
            },
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_draw(cmd, num_viewports, 1, 0, 0); // one vertex per viewport
        }
        end_render_pass(device, cmd);
        copy_image_to_buffer(
            device,
            cmd,
            color_image.get(),
            color_buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, color_buffer.get_allocation())?;
        let result_image = unsafe {
            std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), color_buffer_size as usize)
        };
        let reference_image = generate_reference_image(clear_color, &scissors, &vertex_colors);

        // Images should match, within 0.02 of a channel.
        let threshold = 0.02f32 * 255.0;
        let matches = reference_image
            .iter()
            .zip(result_image)
            .all(|(&reference, &result)| (f32::from(reference) - f32::from(result)).abs() <= threshold);
        if !matches {
            return Ok(TestStatus::fail("Rendered image is not correct"));
        }

        Ok(TestStatus::pass("OK"))
    }
}

/// `createScissorMultiViewportTests`
pub fn create_scissor_multi_viewport_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multi_viewport");

    for num_viewports in 1..=MIN_MAX_VIEWPORTS {
        group.add_child(Box::new(ScissorMultiViewportCase {
            name: format!("scissor_{num_viewports}"),
            num_viewports,
        }) as Box<dyn TestCase>);
    }

    group
}
