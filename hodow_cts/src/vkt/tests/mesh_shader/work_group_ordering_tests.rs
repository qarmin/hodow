// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderMiscTestsEXT.cpp (`workGroupOrdering*`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/mesh_shader_misc_work_group_ordering.toml.
// 256 task work groups of 256 mesh work groups each draw 64 triangles over a 2x2 framebuffer; only the last triangles written must show.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtMeshShaderExtensionDeviceCommands;

use crate::generated::shaders::mesh_shader_misc_work_group_ordering::WORK_GROUP_ORDERING;
use crate::tcu::random::Random;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::mesh_shader::util::check_task_mesh_shader_support_ext;
use crate::vkt::tests::pipeline::pipeline_util::make_color_depth_render_pass;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct WorkGroupOrderingCase;

impl TestCase for WorkGroupOrderingCase {
    fn name(&self) -> &str {
        "work_group_ordering"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_task_mesh_shader_support_ext(context, true, true)
    }

    fn programs(&self) -> BinaryCollection {
        WORK_GROUP_ORDERING.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(WorkGroupOrderingInstance { context })
    }
}

struct WorkGroupOrderingInstance<'a> {
    context: &'a Context<'a>,
}

/// `PositionColor`
type PositionColor = [f32; 8];

impl TestInstance for WorkGroupOrderingInstance<'_> {
    /// `workGroupOrderingRun`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let mesh_wg_size = 64u32;
        let (width, height) = (2u32, 2u32);
        let extent = vk::Extent3D {
            width,
            height,
            depth: 1,
        };
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let depth_format = vk::Format::D16_UNORM;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let size = IVec2::new(width as i32, height as i32);

        let color_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                size,
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
            color_srr,
        )?;
        let color_verif_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(u64::from(width * height * 4), vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let depth_buffer = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                size,
                depth_format,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let depth_view = make_image_view(
            device,
            depth_buffer.get(),
            vk::ImageViewType::_2D,
            depth_format,
            depth_srr,
        )?;
        let depth_verif_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(u64::from(width * height * 2), vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Geometry data.
        let vertices_per_triangle = 3u32;
        let task_wg_count = 256u32;
        let mesh_wg_per_task_wg = 256u32;
        let mesh_wg_count = mesh_wg_per_task_wg * task_wg_count;
        let triangle_count = mesh_wg_count * mesh_wg_size;
        let vertex_count = triangle_count * vertices_per_triangle;
        let mut geom_data: Vec<PositionColor> = Vec::with_capacity(vertex_count as usize);
        let mut rnd = Random::new(1_758_709_612);

        // Triangles drawn around the pixel centers.
        let x_delta = (2.0 / width as f32) * 0.25;
        let y_delta = (2.0 / height as f32) * 0.25;
        for _ in 0..task_wg_count {
            for _ in 0..mesh_wg_per_task_wg {
                for i in 0..mesh_wg_size {
                    // The framebuffer is 2x2 and there are 64 invocations per work group: each pixel is covered 16 times.
                    let modular_idx = i & 0x3;
                    let x = modular_idx & 1;
                    let y = (modular_idx >> 1) & 1;
                    let color = [rnd.get_float(), rnd.get_float(), rnd.get_float(), 1.0];
                    let depth = rnd.get_float();
                    let x_center = (x as f32 + 0.5) / width as f32 * 2.0 - 1.0;
                    let y_center = (y as f32 + 0.5) / height as f32 * 2.0 - 1.0;
                    for position in [
                        [x_center - x_delta, y_center + y_delta, depth, 1.0],
                        [x_center + x_delta, y_center + y_delta, depth, 1.0],
                        [x_center, y_center - y_delta, depth, 1.0],
                    ] {
                        geom_data.push([
                            position[0],
                            position[1],
                            position[2],
                            position[3],
                            color[0],
                            color[1],
                            color[2],
                            color[3],
                        ]);
                    }
                }
            }
        }

        // A device-local buffer fed by a staging one, the latter preferably not in a non-resizable BAR section.
        let geom_data_size = (geom_data.len() * std::mem::size_of::<PositionColor>()) as u64;
        let geom_host_info = make_buffer_create_info(geom_data_size, vk::BufferUsageFlags::TRANSFER_SRC);
        let mut geom_host_buffer = None;
        for requirement in [
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED | MemoryRequirement::NON_LOCAL,
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED,
            MemoryRequirement::HOST_VISIBLE,
        ] {
            match BufferWithMemory::new(device, allocator, geom_host_info, requirement) {
                Ok(buffer) => {
                    geom_host_buffer = Some(buffer);
                    break;
                }
                Err(TestError::NotSupported(_)) => continue,
                Err(error) => return Err(error),
            }
        }
        let Some(geom_host_buffer) = geom_host_buffer else {
            return Err(TestError::NotSupported("No compatible memory types found".to_string()));
        };
        let host_allocation = geom_host_buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                geom_data.as_ptr() as *const u8,
                host_allocation.get_host_ptr(),
                geom_data_size as usize,
            )
        };
        flush_alloc(device, host_allocation)?;
        let geom_dev_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                geom_data_size,
                vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::ANY,
        )?;

        // Descriptor set.
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, vk::ShaderStageFlags::MESH_EXT)
            .build(device)?;
        let pc_values: [u8; 20] = {
            let mut bytes = [0u8; 20];
            for (i, value) in [1.0f32, 1.0, 1.0, 1.0].iter().enumerate() {
                bytes[i * 4..i * 4 + 4].copy_from_slice(&value.to_ne_bytes());
            }
            bytes[16..20].copy_from_slice(&1u32.to_ne_bytes());
            bytes
        };
        let pc_stages = vk::ShaderStageFlags::TASK_EXT | vk::ShaderStageFlags::MESH_EXT;
        let pc_ranges = [vk::PushConstantRange {
            stage_flags: pc_stages,
            offset: 0,
            size: pc_values.len() as u32,
        }];
        let set_layouts = [*set_layout];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let desc_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let desc_set = make_descriptor_set(device, *desc_pool, *set_layout)?;
        let desc_buffer_info = make_descriptor_buffer_info(geom_dev_buffer.get(), 0, vk::WHOLE_SIZE);
        let write = vk::WriteDescriptorSet {
            dst_set: *desc_set,
            dst_binding: 0,
            descriptor_count: 1,
            descriptor_type: desc_type,
            buffer_info: &desc_buffer_info,
            ..Default::default()
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // Render pass, framebuffer and pipeline.
        let render_pass = make_color_depth_render_pass(
            device,
            color_format,
            depth_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view, *depth_view], width, height, 1)?;

        let binaries = context.get_binary_collection();
        let task_shader = create_shader_module(device, binaries.get("task")?)?;
        let mesh_shader = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_shader = create_shader_module(device, binaries.get("frag")?)?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(width, height);
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.depth_stencil.depth_test_enable = vk::TRUE;
        state.depth_stencil.depth_write_enable = vk::TRUE;
        state.depth_stencil.depth_compare_op = vk::CompareOp::ALWAYS;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::TASK_EXT, *task_shader),
                (vk::ShaderStageFlags::MESH_EXT, *mesh_shader),
                (vk::ShaderStageFlags::FRAGMENT, *frag_shader),
            ],
            &state,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let clear_values = [
            clear_value_color([0.0, 0.0, 0.0, 0.0]),
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 },
            },
        ];

        begin_command_buffer(device, cmd)?;
        // Transfer the geometry data from the staging buffer to the device-only buffer.
        let copy_region = vk::BufferCopy {
            src_offset: 0,
            dst_offset: 0,
            size: geom_data_size,
        };
        let transfer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::SHADER_READ);
        unsafe {
            device.cmd_copy_buffer(cmd, geom_host_buffer.get(), geom_dev_buffer.get(), &[copy_region]);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::MESH_SHADER_EXT,
                vk::DependencyFlags::empty(),
                &[transfer_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(width, height))
            .clear_values(&clear_values);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[*desc_set],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_push_constants(cmd, *pipeline_layout, pc_stages, 0, &pc_values);
            device.cmd_draw_mesh_tasks_ext(cmd, task_wg_count, 1, 1);
            device.cmd_end_render_pass(cmd);
        }

        let layout_barriers = [
            make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_image.get(),
                color_srr,
            ),
            make_image_memory_barrier(
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                depth_buffer.get(),
                depth_srr,
            ),
        ];
        let color_copy = make_buffer_image_copy(
            extent,
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        let depth_copy = make_buffer_image_copy(
            extent,
            make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1),
        );
        let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                    | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
                    | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &layout_barriers,
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_verif_buffer.get(),
                &[color_copy],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                depth_buffer.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                depth_verif_buffer.get(),
                &[depth_copy],
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
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Only the last triangles stored in the geometry buffer must show in the framebuffer.
        invalidate_alloc(device, color_verif_buffer.get_allocation())?;
        invalidate_alloc(device, depth_verif_buffer.get_allocation())?;
        let color_result = unsafe {
            std::slice::from_raw_parts(
                color_verif_buffer.get_allocation().get_host_ptr().cast_const(),
                (width * height * 4) as usize,
            )
        };
        let depth_result = unsafe {
            std::slice::from_raw_parts(
                depth_verif_buffer.get_allocation().get_host_ptr().cast_const() as *const u16,
                (width * height) as usize,
            )
        };

        let base_idx = geom_data.len() - (width * height * vertices_per_triangle) as usize;
        let color_threshold = [0.005f32, 0.005, 0.005, 0.0];
        let depth_threshold = 0.000_025f32;
        let mut fail = false;
        for y in 0..height {
            for x in 0..width {
                let pixel = (y * width + x) as usize;
                let reference = geom_data[base_idx + pixel * vertices_per_triangle as usize];
                for c in 0..4 {
                    let result = f32::from(color_result[pixel * 4 + c]) / 255.0;
                    if (result - reference[4 + c]).abs() > color_threshold[c] {
                        fail = true;
                    }
                }
                let depth = f32::from(depth_result[pixel]) / 65535.0;
                if (depth - reference[2]).abs() > depth_threshold {
                    fail = true;
                }
            }
        }
        if fail {
            return Ok(TestStatus::fail(
                "Unexpected results in color or depth buffers; check log for details --",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `work_group_ordering` of the `misc` group.
pub fn add_work_group_ordering_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(WorkGroupOrderingCase) as Box<dyn TestCase>);
}
