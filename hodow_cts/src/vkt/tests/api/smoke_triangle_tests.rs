// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiSmokeTests.cpp (`renderTriangleTest`, `renderTriangleUnusedResolveAttachmentTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A magenta triangle is drawn over a cleared 256x256 image and the result is compared with the software renderer's, allowing a
// position deviation of one pixel. The reference shaders here carry a colour attribute next to the position - the same draw as
// `RefVertexShader`/`RefFragmentShader`, whose output is the constant the colour attribute holds. The shaders are in
// `shaders/manifest/api_smoke_triangle.toml`; `asm_triangle` and `asm_triangle_no_opname` are SPIR-V assembly.

use vulkanalia::prelude::v1_0::*;

use super::case_util::add_case;
use crate::generated::shaders::api_smoke_triangle::{SMOKE_TRIANGLE, SMOKE_TRIANGLE_ASM, SMOKE_TRIANGLE_ASM_NO_OPNAME};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{RenderState, ViewportState};
use crate::tcu::image_compare::int_threshold_position_deviation_compare;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::{TestError, TestOutcome, TestStatus, UVec4, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_graphics_pipeline, make_memory_barrier,
    make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::pipeline_util::{
    ColorFragmentShader, ColorVertexShader, ReferenceRenderer, Vertex4Rgba,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 256;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const CLEAR_COLOR: [f32; 4] = [0.125, 0.25, 0.75, 1.0];
const MAGENTA: [f32; 4] = [1.0, 0.0, 1.0, 1.0];
const VERTICES: [[f32; 4]; 3] = [[-0.5, -0.5, 0.0, 1.0], [0.5, -0.5, 0.0, 1.0], [0.0, 0.5, 0.0, 1.0]];

/// One of the four triangle cases.
struct SmokeTriangleCase {
    name: &'static str,
    programs: &'static SharedProgram,
    unused_resolve_attachment: bool,
}

impl TestCase for SmokeTriangleCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SmokeTriangleInstance {
            context,
            unused_resolve_attachment: self.unused_resolve_attachment,
        })
    }
}

struct SmokeTriangleInstance<'a> {
    context: &'a Context<'a>,
    unused_resolve_attachment: bool,
}

/// `renderReferenceTriangle`
fn render_reference_triangle(sub_pixel_bits: u32) -> Result<ReferenceRenderer, TestError> {
    let tcu_format =
        map_vk_format(COLOR_FORMAT).ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
    let mut renderer = ReferenceRenderer::new(RENDER_SIZE, RENDER_SIZE, tcu_format, None)?;
    renderer.color_clear(CLEAR_COLOR);

    let vertex_shader = ColorVertexShader::new();
    let fragment_shader = ColorFragmentShader::new(tcu_format, None, false);
    let program = crate::rr::renderer::Program {
        vertex_shader: &vertex_shader,
        fragment_shader: &fragment_shader,
        geometry_shader: None,
    };
    let render_state = RenderState::new(
        ViewportState::from_target_size(RENDER_SIZE as i32, RENDER_SIZE as i32),
        sub_pixel_bits as i32,
    );
    let vertices: Vec<Vertex4Rgba> = VERTICES
        .iter()
        .map(|position| Vertex4Rgba {
            position: *position,
            color: MAGENTA,
        })
        .collect();

    renderer.draw(&program, &render_state, PrimitiveType::Triangles, &vertices);
    Ok(renderer)
}

impl TestInstance for SmokeTriangleInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let allocator = context.get_default_allocator();

        // The first case binds every resource at a non-zero offset into its allocation to exercise them
        let exercise_offsets = !self.unused_resolve_attachment;

        // Vertex buffer
        let vertex_buffer_size = std::mem::size_of_val(&VERTICES) as vk::DeviceSize;
        let vertex_buffer_info = vk::BufferCreateInfo::builder()
            .size(vertex_buffer_size)
            .usage(vk::BufferUsageFlags::VERTEX_BUFFER)
            .sharing_mode(vk::SharingMode::EXCLUSIVE);
        let vertex_buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&vertex_buffer_info, None) }.vk_check("vkCreateBuffer")?,
        );
        let mut memory_req = unsafe { device.get_buffer_memory_requirements(*vertex_buffer) };
        let vertex_buffer_memory_offset = if exercise_offsets { memory_req.alignment } else { 0 };
        memory_req.size += vertex_buffer_memory_offset; // alocate size + req.align to exercise non-zero offsets
        let vertex_buffer_memory = allocator.allocate(device, memory_req, MemoryRequirement::HOST_VISIBLE)?;
        unsafe {
            device.bind_buffer_memory(
                *vertex_buffer,
                vertex_buffer_memory.get_memory(),
                vertex_buffer_memory.get_offset() + vertex_buffer_memory_offset,
            )
        }
        .vk_check("vkBindBufferMemory")?;

        // Buffer the image is read back into
        let image_size_bytes = (std::mem::size_of::<u32>() as u32 * RENDER_SIZE * RENDER_SIZE) as vk::DeviceSize;
        let read_image_buffer_info = vk::BufferCreateInfo::builder()
            .size(image_size_bytes)
            .usage(vk::BufferUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE);
        let read_image_buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&read_image_buffer_info, None) }.vk_check("vkCreateBuffer")?,
        );
        let mut memory_req = unsafe { device.get_buffer_memory_requirements(*read_image_buffer) };
        let read_image_buffer_memory_offset = if exercise_offsets { memory_req.alignment } else { 0 };
        memory_req.size += read_image_buffer_memory_offset;
        let read_image_buffer_memory = allocator.allocate(device, memory_req, MemoryRequirement::HOST_VISIBLE)?;
        unsafe {
            device.bind_buffer_memory(
                *read_image_buffer,
                read_image_buffer_memory.get_memory(),
                read_image_buffer_memory.get_offset() + read_image_buffer_memory_offset,
            )
        }
        .vk_check("vkBindBufferMemory")?;

        // The image
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
            .initial_layout(vk::ImageLayout::UNDEFINED);
        let image = Unique::new(
            device,
            unsafe { device.create_image(&image_info, None) }.vk_check("vkCreateImage")?,
        );
        let mut memory_req = unsafe { device.get_image_memory_requirements(*image) };
        let image_memory_offset = if exercise_offsets { memory_req.alignment } else { 0 };
        memory_req.size += image_memory_offset;
        let image_memory = allocator.allocate(device, memory_req, MemoryRequirement::ANY)?;
        unsafe {
            device.bind_image_memory(
                *image,
                image_memory.get_memory(),
                image_memory.get_offset() + image_memory_offset,
            )
        }
        .vk_check("vkBindImageMemory")?;

        let render_pass = if self.unused_resolve_attachment {
            // One colour attachment, with a resolve reference to VK_ATTACHMENT_UNUSED
            let color_att_desc = [vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build()];
            let color_att_ref = [vk::AttachmentReference::builder()
                .attachment(0)
                .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build()];
            let resolve_att_ref = [vk::AttachmentReference::builder()
                .attachment(vk::ATTACHMENT_UNUSED)
                .layout(vk::ImageLayout::GENERAL)
                .build()];
            let subpass_desc = [vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_att_ref)
                .resolve_attachments(&resolve_att_ref)
                .build()];
            let render_pass_params = vk::RenderPassCreateInfo::builder()
                .attachments(&color_att_desc)
                .subpasses(&subpass_desc);
            Unique::new(
                device,
                unsafe { device.create_render_pass(&render_pass_params, None) }.vk_check("vkCreateRenderPass")?,
            )
        } else {
            make_render_pass(device, COLOR_FORMAT)?
        };

        let color_att_view = make_image_view(
            device,
            *image,
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // Shaders
        let binaries = context.get_binary_collection();
        let vert_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_shader_module = create_shader_module(device, binaries.get("frag")?)?;

        let pipeline = make_graphics_pipeline(
            device,
            *pipeline_layout,
            *vert_shader_module,
            *frag_shader_module,
            *render_pass,
            (RENDER_SIZE, RENDER_SIZE),
            vk::PrimitiveTopology::TRIANGLE_LIST,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_att_view], RENDER_SIZE, RENDER_SIZE, 1)?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buf = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buf;

        // Record commands
        begin_command_buffer(device, cmd)?;
        {
            let vert_flush_barrier =
                make_memory_barrier(vk::AccessFlags::HOST_WRITE, vk::AccessFlags::VERTEX_ATTRIBUTE_READ);
            let color_att_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                *image,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::ALL_COMMANDS,
                    vk::DependencyFlags::empty(),
                    &[vert_flush_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[color_att_barrier],
                );
            }
        }

        begin_render_pass(
            device,
            cmd,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, RENDER_SIZE, RENDER_SIZE),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: CLEAR_COLOR },
            },
        );

        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd, 0, &[*vertex_buffer], &[0]);
            device.cmd_draw(cmd, 3, 1, 0, 0);
        }
        end_render_pass(device, cmd);
        copy_image_to_buffer(device, cmd, *image, *read_image_buffer, RENDER_SIZE, RENDER_SIZE);
        end_command_buffer(device, cmd)?;

        // Upload vertex data
        unsafe {
            std::ptr::copy_nonoverlapping(
                VERTICES.as_ptr().cast::<u8>(),
                vertex_buffer_memory
                    .get_host_ptr()
                    .add(vertex_buffer_memory_offset as usize),
                vertex_buffer_size as usize,
            );
        }
        flush_alloc(device, &vertex_buffer_memory)?;

        // Submit & wait for completion
        submit_commands_and_wait(device, queue, cmd)?;

        // Read results, render reference, compare
        invalidate_alloc(device, &read_image_buffer_memory)?;
        let tcu_format = map_vk_format(COLOR_FORMAT)
            .ok_or_else(|| TestError::NotSupported("format has no tcu mapping".to_string()))?;
        let result_bytes = unsafe {
            std::slice::from_raw_parts(
                read_image_buffer_memory
                    .get_host_ptr()
                    .add(read_image_buffer_memory_offset as usize),
                image_size_bytes as usize,
            )
        };
        let result_access = ConstPixelBufferAccess::new(tcu_format, [RENDER_SIZE, RENDER_SIZE, 1], result_bytes);

        let reference = render_reference_triangle(context.get_device_properties().limits.sub_pixel_precision_bits)?;
        let threshold = UVec4::new(0, 0, 0, 0);
        let pos_deviation = [1, 1, 0];

        if int_threshold_position_deviation_compare(
            &reference.get_access(),
            &result_access,
            threshold,
            pos_deviation,
            false,
        ) {
            Ok(TestStatus::pass("Rendering succeeded"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

/// The four triangle cases of `createSmokeTests`, registered after `create_shader` upstream.
pub fn add_smoke_triangle_tests(smoke_tests: &mut TestCaseGroup) {
    add_case(
        smoke_tests,
        SmokeTriangleCase {
            name: "triangle",
            programs: &SMOKE_TRIANGLE,
            unused_resolve_attachment: false,
        },
    );
    add_case(
        smoke_tests,
        SmokeTriangleCase {
            name: "asm_triangle",
            programs: &SMOKE_TRIANGLE_ASM,
            unused_resolve_attachment: false,
        },
    );
    add_case(
        smoke_tests,
        SmokeTriangleCase {
            name: "asm_triangle_no_opname",
            programs: &SMOKE_TRIANGLE_ASM_NO_OPNAME,
            unused_resolve_attachment: false,
        },
    );
    add_case(
        smoke_tests,
        SmokeTriangleCase {
            name: "unused_resolve_attachment",
            programs: &SMOKE_TRIANGLE,
            unused_resolve_attachment: true,
        },
    );
}
