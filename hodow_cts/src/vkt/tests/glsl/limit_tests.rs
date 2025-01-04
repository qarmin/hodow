// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderLimitTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `glsl.limits.near_max.fragment_input.components_<n>` without `ShaderRenderCaseInstance`: the
// instance only sets up one position attribute and draws four indexed triangles that cover the target. The shaders (one pair per component
// count) are in `shaders/manifest/glsl_limits.toml`, written by `scripts/gen_glsl_limits_shaders.py`. Upstream checks the limits when it
// creates the instance, here they are in `check_support`.

use vulkanalia::prelude::v1_0::*;

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
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info,
    make_buffer_memory_barrier, make_command_pool, make_framebuffer, make_graphics_pipeline_staged,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 64;

struct FragmentInputComponentCase {
    name: String,
    input_components: u32,
}

impl TestCase for FragmentInputComponentCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let limits = &context.get_device_properties().limits;

        if self.input_components > limits.max_fragment_input_components {
            return Err(TestError::NotSupported(format!(
                "Unsupported number of fragment input components ({}) maxFragmentInputComponents={}",
                self.input_components, limits.max_fragment_input_components
            )));
        }

        // gl_Position counts as an output component as well, so outputComponents = inputComponents + 4
        if self.input_components + 4 > limits.max_vertex_output_components {
            return Err(TestError::NotSupported(format!(
                "Unsupported number of user specified vertex output components ({}) maxVertexOutputComponents={}",
                self.input_components + 4,
                limits.max_vertex_output_components
            )));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::glsl_limits::GLSL_LIMITS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FragmentInputComponentCaseInstance {
            context,
            input_components: self.input_components,
        })
    }
}

/// `FragmentInputComponentCaseInstance`
struct FragmentInputComponentCaseInstance<'a> {
    context: &'a Context<'a>,
    input_components: u32,
}

impl TestInstance for FragmentInputComponentCaseInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let n = self.input_components;

        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_buffer_size = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(RENDER_SIZE as i32, RENDER_SIZE as i32),
                color_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_range,
        )?;
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], RENDER_SIZE, RENDER_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get(&format!("vert_{n}"))?)?;
        let frag_module = create_shader_module(device, binaries.get(&format!("frag_{n}"))?)?;
        let stages = GraphicsPipelineStages {
            vertex: *vert_module,
            fragment: *frag_module,
            tessellation_control: None,
            tessellation_evaluation: None,
            geometry: None,
        };
        let pipeline = make_graphics_pipeline_staged(
            device,
            *pipeline_layout,
            stages,
            *render_pass,
            (RENDER_SIZE, RENDER_SIZE),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            None,
            1,
            None,
            None,
        )?;

        let indices: [u16; 12] = [0, 4, 1, 0, 5, 4, 1, 2, 3, 1, 3, 4];
        let vertices: [[f32; 4]; 6] = [
            [-1.0, -1.0, 0.0, 1.0],
            [0.0, -1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
            [0.0, 1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
        ];

        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                std::mem::size_of_val(&vertices) as u64,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&vertices),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;
        let index_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                std::mem::size_of_val(&indices) as u64,
                vk::BufferUsageFlags::INDEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                indices.as_ptr().cast::<u8>(),
                index_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&indices),
            )
        };
        flush_alloc(device, index_buffer.get_allocation())?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();

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
                width: RENDER_SIZE,
                height: RENDER_SIZE,
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

        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, RENDER_SIZE, RENDER_SIZE),
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        );
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_index_buffer(cmd, index_buffer.get(), 0, vk::IndexType::UINT16);
            device.cmd_draw_indexed(cmd, indices.len() as u32, 1, 0, 0, 0);
        }
        end_render_pass(device, cmd);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                &[region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, color_buffer.get_allocation())?;
        let result = unsafe {
            std::slice::from_raw_parts(
                color_buffer.get_allocation().get_host_ptr().cast_const(),
                color_buffer_size as usize,
            )
        };

        // Reference image: green everywhere, compared with a threshold of two per channel.
        const REFERENCE: [u8; 4] = [0, 255, 0, 255];
        const THRESHOLD: u8 = 2;
        let mismatches = result
            .chunks_exact(4)
            .filter(|pixel| pixel.iter().zip(REFERENCE).any(|(a, b)| a.abs_diff(b) > THRESHOLD))
            .count();
        if mismatches > 0 {
            log::info!("Image comparison failed: {mismatches} pixels differ from the reference");
            return Ok(TestStatus::fail("Image mismatch"));
        }

        Ok(TestStatus::pass("Result image matches reference"))
    }
}

/// `createLimitTests`
pub fn create_limit_tests() -> TestCaseGroup {
    const FRAGMENT_COMPONENT_MAX_LIMITS: [u32; 3] = [64, 128, 256];

    let mut input_components_group = TestCaseGroup::new("fragment_input");
    for limit in FRAGMENT_COMPONENT_MAX_LIMITS {
        for cases in (1..=5u32).rev() {
            let input_components = limit - cases;
            input_components_group.add_child(Box::new(FragmentInputComponentCase {
                name: format!("components_{input_components}"),
                input_components,
            }) as Box<dyn TestCase>);
        }
    }

    let mut near_group = TestCaseGroup::new("near_max");
    near_group.add_child(input_components_group);
    let mut limit_group = TestCaseGroup::new("limits");
    limit_group.add_child(near_group);
    limit_group
}
