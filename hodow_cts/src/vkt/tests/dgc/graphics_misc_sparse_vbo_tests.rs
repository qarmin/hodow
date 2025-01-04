// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMiscTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_ms.toml` (`scripts/gen_dgc_ms_manifest.py`, case
// `sparse_vbo`). `Context::getSparseQueue` is the universal queue here, which has to belong to a family with sparse binding.
//
// Here: `sparse_vbo_token` of `dgc.ext.graphics.misc`: the vertex buffer bound by a vertex buffer token is a sparse buffer whose memory is
// bound by the sparse queue, with the command buffer waiting for the binding on the transfer stage.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDeviceGeneratedCommandsExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::dgc_ms::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout_with_push_constants, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, PipelineOptions, StageModules, build_draw_pipeline, copy_image_to_buffer, float_threshold_compare,
    push_back_element,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt, check_dgc_ext_support,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

struct SparseVboCase;

impl TestCase for SparseVboCase {
    fn name(&self) -> &str {
        "sparse_vbo_token"
    }

    /// `sparseVBOCheckSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        check_dgc_ext_support(
            context,
            stage_flags,
            vk::ShaderStageFlags::empty(),
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;
        if context.api_version() < (1, 3, 0) {
            context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        }
        if context.get_device_features().sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature sparseBinding not supported".to_string(),
            ));
        }
        let queue_families = unsafe {
            context
                .get_instance()
                .get_physical_device_queue_family_properties(context.get_physical_device())
        };
        let universal_family = queue_families.get(context.get_universal_queue_family_index() as usize);
        if !universal_family.is_some_and(|family| family.queue_flags.contains(vk::QueueFlags::SPARSE_BINDING)) {
            return Err(TestError::NotSupported("No sparse binding queue available".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "sparse_vbo")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SparseVboInstance { context })
    }
}

struct SparseVboInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for SparseVboInstance<'_> {
    /// `sparseVBORun`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let fb_extent = 2u32;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let clear_color: Vec4 = [0.0, 0.0, 0.0, 1.0]; // Different from the frag shader color.
        let stage_flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;

        let color_buffer = ImageWithBuffer::new(context, fb_extent, fb_extent, color_format, color_usage, 4)?;

        // Full-screen quad.
        let vertices: [Vec4; 4] = [
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ];

        // We will bind memory and transfer vertex data to this buffer later.
        let vertex_buffer_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let mut vertex_buffer_info = make_buffer_create_info(
            vertex_buffer_size,
            vk::BufferUsageFlags::VERTEX_BUFFER
                | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
                | vk::BufferUsageFlags::TRANSFER_DST,
        );
        vertex_buffer_info.flags = vk::BufferCreateFlags::SPARSE_BINDING;
        let vertex_buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&vertex_buffer_info, None) }.vk_check("vkCreateBuffer")?,
        );
        let vertex_buffer_mem_reqs = unsafe { device.get_buffer_memory_requirements(*vertex_buffer) };
        let vertex_buffer_alloc = context.get_default_allocator().allocate(
            device,
            vertex_buffer_mem_reqs,
            MemoryRequirement::DEVICE_ADDRESS,
        )?;

        let xfer_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = xfer_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the vertices.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    vertex_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], fb_extent, fb_extent, 1)?;

        let pipeline = build_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &StageModules {
                vert: *vert_module,
                tesc: None,
                tese: None,
                geom: None,
                frag: *frag_module,
            },
            &PipelineOptions {
                extent: (fb_extent, fb_extent),
                topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                patch_control_points: 0,
                dynamic_stride: true,
                dynamic_patch_control_points: false,
                no_vertex_input: false,
                extra_attribute: false,
                indirect_bindable: false,
                construction: Construction::Monolithic,
                depth_test: false,
                rendering: None,
            },
        )?;

        // Commands layout.
        const SEQUENCE_COUNT: u32 = 1;
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            *pipeline_layout,
        );
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_vertex_buffer_token(offset, 0);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut dgc_data: Vec<u32> = Vec::new();
        {
            let bind_cmd = vk::BindVertexBufferIndirectCommandEXT {
                buffer_address: buffer_device_address(device, *vertex_buffer),
                size: vertex_buffer_size as u32,
                stride: std::mem::size_of::<Vec4>() as u32,
            };
            push_back_element(&mut dgc_data, &bind_cmd);
        }
        {
            let draw_cmd = vk::DrawIndirectCommand {
                vertex_count: vertices.len() as u32,
                instance_count: 1,
                first_vertex: 0,
                first_instance: 0,
            };
            push_back_element(&mut dgc_data, &draw_cmd);
        }
        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = dgc_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Preprocess buffer.
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            SEQUENCE_COUNT,
            0,
            *pipeline,
            0,
        )?;

        // Commands.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        {
            let copy_region = vk::BufferCopy {
                src_offset: 0,
                dst_offset: 0,
                size: vertex_buffer_size,
            };
            unsafe { device.cmd_copy_buffer(cmd_buffer, xfer_buffer.get(), *vertex_buffer, &[copy_region]) };
        }
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, fb_extent, fb_extent),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            },
        );
        unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline) };
        {
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                SEQUENCE_COUNT,
                0,
                0,
                *pipeline,
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        }
        end_render_pass(device, cmd_buffer);
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            fb_extent,
            fb_extent,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;

        let bind_semaphore = Unique::new(
            device,
            unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                .vk_check("vkCreateSemaphore")?,
        );
        let sparse_memory_binds = [vk::SparseMemoryBind {
            resource_offset: 0,
            size: vertex_buffer_mem_reqs.size,
            memory: vertex_buffer_alloc.get_memory(),
            memory_offset: 0,
            flags: vk::SparseMemoryBindFlags::empty(),
        }];
        let buffer_binds = [vk::SparseBufferMemoryBindInfo::builder()
            .buffer(*vertex_buffer)
            .binds(&sparse_memory_binds)
            .build()];
        let signal_semaphores = [*bind_semaphore];
        let bind_info = vk::BindSparseInfo::builder()
            .buffer_binds(&buffer_binds)
            .signal_semaphores(&signal_semaphores);

        // Bind sparse buffer memory.
        unsafe { device.queue_bind_sparse(queue, &[bind_info], vk::Fence::null()) }.vk_check("vkQueueBindSparse")?;

        // Start running the command buffer waiting on the transfer operation.
        {
            let wait_semaphores = [*bind_semaphore];
            let wait_stages = [vk::PipelineStageFlags::TRANSFER];
            let cmd_buffers = [cmd_buffer];
            let submit_info = vk::SubmitInfo::builder()
                .wait_semaphores(&wait_semaphores)
                .wait_dst_stage_mask(&wait_stages)
                .command_buffers(&cmd_buffers);
            let fence = Unique::new(
                device,
                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
            );
            unsafe { device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
            unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
        }

        let result = color_buffer.read_bytes(device)?;
        let geom_color: Vec4 = [0.0, 0.0, 1.0, 1.0]; // Must match the fragment shader.
        let reference = vec![geom_color; (fb_extent * fb_extent) as usize];
        if !float_threshold_compare(result, &reference, [0.0; 4]) {
            return Ok(TestStatus::fail(
                "Unexpected result in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `sparse_vbo_token` case, by its full dotted path in `dgc`.
pub fn create_dgc_graphics_misc_sparse_vbo_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    vec![(
        "ext.graphics.misc.sparse_vbo_token".to_string(),
        Box::new(SparseVboCase) as Box<dyn TestCase>,
    )]
}
