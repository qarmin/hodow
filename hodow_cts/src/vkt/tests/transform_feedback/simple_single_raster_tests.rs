// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackSimpleTests.cpp (`MultiStreamSingleRasterCase`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Mobica Limited.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `multi_stream_single_raster` and `multi_stream_single_raster_non_zero` of the `simple` group:
// one geometry shader emits a point on each of two streams, only the rasterized stream's point reaches the 1x2 colour image and both are
// written to their transform feedback buffers. The shaders are the `single_raster_*` ones of
// `shaders/manifest/transform_feedback_simple_streams.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1};

use super::simple_pipeline::{XfbPipelineOptions, XfbStages, make_xfb_pipeline};
use super::simple_tests::make_pipeline_layout;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const EXTENT: (u32, u32) = (1, 2);

struct SingleRasterCase {
    name: String,
    non_zero_stream: bool,
}

impl TestCase for SingleRasterCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_transform_feedback")?;
        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature is not supported".to_string(),
            ));
        }

        let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };

        if xfb_properties.max_transform_feedback_streams < 2 {
            return Err(TestError::NotSupported(
                "maxTransformFeedbackStreams not large enough".to_string(),
            ));
        }

        if xfb_properties.max_transform_feedback_buffers < 2 {
            return Err(TestError::NotSupported(
                "maxTransformFeedbackBuffers not large enough".to_string(),
            ));
        }

        if self.non_zero_stream && xfb_properties.transform_feedback_rasterization_stream_select == vk::FALSE {
            return Err(TestError::NotSupported(
                "transformFeedbackRasterizationStreamSelect not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::transform_feedback_simple_streams::XFB_STREAM_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SingleRasterInstance {
            context,
            non_zero_stream: self.non_zero_stream,
        })
    }
}

/// `MultiStreamSingleRasterTest`
struct SingleRasterInstance<'a> {
    context: &'a Context<'a>,
    non_zero_stream: bool,
}

impl TestInstance for SingleRasterInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let stream = self.non_zero_stream as u32;
        let (width, height) = EXTENT;
        let color_format = vk::Format::R8G8B8A8_UNORM;

        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_buffer_size = (width * height * 4) as vk::DeviceSize;
        let color_image = ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(
                IVec2::new(width as i32, height as i32),
                color_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(vk, color_image.get(), vk::ImageViewType::_2D, color_format, color_range)?;
        let color_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let pipeline_layout = make_pipeline_layout(vk)?;
        let render_pass = make_render_pass(vk, color_format)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[*color_view], width, height, 1)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(vk, binaries.get("single_raster_vert")?)?;
        let geom_module = create_shader_module(vk, binaries.get(&format!("single_raster_geom_s{stream}"))?)?;
        let frag_module = create_shader_module(vk, binaries.get(&format!("single_raster_frag_s{stream}"))?)?;

        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes)
            .build();
        let stages = XfbStages {
            vert: *vert_module,
            geom: Some(*geom_module),
            frag: Some(*frag_module),
            ..XfbStages::default()
        };
        let options = XfbPipelineOptions {
            rasterization_stream: self.non_zero_stream.then_some(1),
            vertex_input: Some(&vertex_input),
            attachment_count: 1,
            ..XfbPipelineOptions::default()
        };
        let pipeline = make_xfb_pipeline(
            vk,
            *pipeline_layout,
            *render_pass,
            &stages,
            (width, height),
            0,
            &options,
        )?;

        let vertices: [[f32; 4]; 1] = [[0.0, -0.5, 0.0, 1.0]];
        let vertex_buffer_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size as usize,
            )
        };
        flush_alloc(vk, vertex_buffer.get_allocation())?;

        // Create space for potentially duplicated vertices. Note in reality each buffer would only get one copy, not two.
        const XFB_BUFFER_COUNT: usize = 2; // Must match the geometry shader.
        let xfb_buffer_size = vertex_buffer_size * 2;
        let mut xfb_buffers = Vec::with_capacity(XFB_BUFFER_COUNT);
        for _ in 0..XFB_BUFFER_COUNT {
            xfb_buffers.push(BufferWithMemory::new(
                vk,
                allocator,
                make_buffer_create_info(xfb_buffer_size, vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();

        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let geom_color = [0u8, 0, 255, 255]; // Must match frag shader above.
        let black = [0u8, 0, 0, 255];

        begin_command_buffer(vk, cmd)?;
        begin_render_pass(
            vk,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, width, height),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            },
        );
        unsafe {
            vk.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            vk.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

            let handles: Vec<vk::Buffer> = xfb_buffers.iter().map(|buffer| buffer.get()).collect();
            let offsets = vec![0 as vk::DeviceSize; XFB_BUFFER_COUNT];
            let sizes = vec![xfb_buffer_size; XFB_BUFFER_COUNT];
            vk.cmd_bind_transform_feedback_buffers_ext(cmd, 0, &handles, &offsets, &sizes);

            (vk.commands().cmd_begin_transform_feedback_ext)(cmd, 0, 0, std::ptr::null(), std::ptr::null());
            vk.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            (vk.commands().cmd_end_transform_feedback_ext)(cmd, 0, 0, std::ptr::null(), std::ptr::null());
        }
        end_render_pass(vk, cmd);

        let image_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            color_range,
        );
        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width,
                height,
                depth: 1,
            },
        };
        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            color_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            vk.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                &[region],
            );
            vk.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, cmd)?;
        submit_commands_and_wait(vk, queue, cmd)?;

        invalidate_alloc(vk, color_buffer.get_allocation())?;
        let result = unsafe {
            std::slice::from_raw_parts(
                color_buffer.get_allocation().get_host_ptr().cast_const(),
                color_buffer_size as usize,
            )
        };

        // One of the two pixels is rasterized, depending on the rasterization stream: Top pixel for stream 0, bottom pixel for stream 1.
        let rasterized_row = self.non_zero_stream as usize;
        for row in 0..height as usize {
            let expected = if row == rasterized_row { geom_color } else { black };
            if result[row * 4..row * 4 + 4] != expected {
                return Err(TestError::Fail(
                    "Unexpected results found in color buffer; check log for details --".to_string(),
                ));
            }
        }

        // Verify both streams are saved to the transform feedback buffers.
        let mut xfb_fail = false;
        for (i, xfb_buffer) in xfb_buffers.iter().enumerate() {
            invalidate_alloc(vk, xfb_buffer.get_allocation())?;
            let mut positions = [0.0f32; 4];
            unsafe {
                std::ptr::copy_nonoverlapping(
                    xfb_buffer.get_allocation().get_host_ptr().cast_const(),
                    positions.as_mut_ptr().cast::<u8>(),
                    std::mem::size_of_val(&positions),
                )
            };

            let mut expected = vertices[0];
            if i > 0 {
                expected[1] = -expected[1];
            }

            if positions != expected {
                xfb_fail = true;
                log::info!(
                    "Unexpected result at XFB buffer {i} vertex 0: expected {expected:?} but found {positions:?}"
                );
            }
        }

        if xfb_fail {
            return Err(TestError::Fail(
                "Unexpected results in transform feedback buffers; check log for details --".to_string(),
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `multi_stream_single_raster` block of `createTransformFeedbackSimpleTests`.
pub(super) fn add_single_raster_tests(group: &mut TestCaseGroup) {
    for non_zero_stream in [false, true] {
        let name = format!(
            "multi_stream_single_raster{}",
            if non_zero_stream { "_non_zero" } else { "" }
        );
        group.add_child(Box::new(SingleRasterCase { name, non_zero_stream }) as Box<dyn TestCase>);
    }
}
