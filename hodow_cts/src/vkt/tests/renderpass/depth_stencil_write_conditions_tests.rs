// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktRenderPassDepthStencilWriteConditionsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A full-screen quad is drawn with a fragment shader that discards every even column and writes
// the depth (or stencil) built-in output for the rest; discarded fragments must leave the buffer
// as cleared. Upstream assembles the fragment shader as SPIR-V text, where INITIALIZE gives the
// output variable an initialiser. The generator here has no assembler, so the shader is GLSL (see
// `shaders/manifest/renderpass_depth_stencil_write_conditions.toml`) and INITIALIZE stores the
// value once before the discard instead; the buffer contents expected afterwards are the same.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_graphics_pipeline_full, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: the shader pair plus the three axes it was built from.
pub struct DepthStencilWriteProgram {
    pub name: &'static str,
    pub discard_kind: u32,
    pub stencil: bool,
    pub init_only: bool,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::renderpass_depth_stencil_write_conditions::ALL_DEPTH_STENCIL_WRITE_PROGRAM;

const WIDTH: u32 = 64;
const HEIGHT: u32 = 64;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `DiscardType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DiscardType {
    Kill,
    Terminate,
    Demote,
}

/// `BufferType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum BufferType {
    Depth,
    Stencil,
}

/// `MutationMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum MutationMode {
    Write,
    Initialize,
    InitializeWrite,
}

fn has_stencil(format: vk::Format) -> bool {
    format == vk::Format::D32_SFLOAT_S8_UINT || format == vk::Format::D24_UNORM_S8_UINT
}

/// `genFullQuadVertices`
fn gen_full_quad_vertices() -> [[f32; 4]; 6] {
    [
        [-1.0, -1.0, 0.0, 1.0],
        [1.0, -1.0, 0.0, 1.0],
        [-1.0, 1.0, 0.0, 1.0],
        [1.0, -1.0, 1.0, 1.0],
        [1.0, 1.0, 1.0, 1.0],
        [-1.0, 1.0, 1.0, 1.0],
    ]
}

struct DepthStencilWriteConditionsTest {
    name: String,
    buffer_type: BufferType,
    discard_type: DiscardType,
    mutation_mode: MutationMode,
    buffer_format: vk::Format,
}

impl DepthStencilWriteConditionsTest {
    fn program(&self) -> &'static DepthStencilWriteProgram {
        let discard_kind = match self.discard_type {
            DiscardType::Kill => 0,
            DiscardType::Terminate => 1,
            DiscardType::Demote => 2,
        };
        let stencil = self.buffer_type == BufferType::Stencil;
        let init_only = self.mutation_mode == MutationMode::Initialize;
        ALL_DEPTH_STENCIL_WRITE_PROGRAM
            .iter()
            .copied()
            .find(|p| p.discard_kind == discard_kind && p.stencil == stencil && p.init_only == init_only)
            .expect("the manifest covers every discard/buffer/mutation combination")
    }
}

impl TestCase for DepthStencilWriteConditionsTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        if self.discard_type == DiscardType::Demote {
            context.require_device_functionality("VK_EXT_shader_demote_to_helper_invocation")?;
        }
        if self.discard_type == DiscardType::Terminate {
            context.require_device_functionality("VK_KHR_shader_terminate_invocation")?;
        }
        if self.buffer_type == BufferType::Stencil {
            context.require_device_functionality("VK_EXT_shader_stencil_export")?;
        }

        let depth_stencil_usage = vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.buffer_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                depth_stencil_usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if let Err(vk::ErrorCode::FORMAT_NOT_SUPPORTED) = result {
            return Err(TestError::NotSupported(format!(
                "{:?} not supported.",
                self.buffer_format
            )));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthStencilWriteConditionsInstance {
            context,
            buffer_type: self.buffer_type,
            buffer_format: self.buffer_format,
        })
    }
}

/// `DepthStencilWriteConditionsInstance`
struct DepthStencilWriteConditionsInstance<'a> {
    context: &'a Context<'a>,
    buffer_type: BufferType,
    buffer_format: vk::Format,
}

impl TestInstance for DepthStencilWriteConditionsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let buffer_format = self.buffer_format;

        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        };
        let extent = vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        };

        let vertices = gen_full_quad_vertices();
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(1024, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vertex_buffer_offset: vk::DeviceSize = 0;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&vertices),
            );
        }
        flush_alloc(device, vertex_buffer.get_allocation())?;

        let color_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_FORMAT)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image = ImageWithMemory::new(device, alloc, color_image_info, MemoryRequirement::ANY)?;
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;

        // Depending on the type of the buffer, create a depth buffer or a stencil buffer.
        let depth_stencil_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(buffer_format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let depth_stencil_image = ImageWithMemory::new(device, alloc, depth_stencil_info, MemoryRequirement::ANY)?;
        let image_aspect = if self.buffer_type == BufferType::Depth {
            vk::ImageAspectFlags::DEPTH
        } else {
            vk::ImageAspectFlags::STENCIL
        };
        let subresource_range = make_image_subresource_range(image_aspect, 0, 1, 0, 1);
        let depth_stencil_image_view = make_image_view(
            device,
            depth_stencil_image.get(),
            vk::ImageViewType::_2D,
            buffer_format,
            subresource_range,
        )?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // makeRenderPass(color, depth/stencil, CLEAR, both final layouts TRANSFER_SRC_OPTIMAL)
        let attachments = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(buffer_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
                .stencil_store_op(vk::AttachmentStoreOp::STORE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::TRANSFER_SRC_OPTIMAL)
                .build(),
        ];
        let color_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let depth_stencil_reference = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references)
            .depth_stencil_attachment(&depth_stencil_reference)
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
            &[*color_image_view, *depth_stencil_image_view],
            WIDTH,
            HEIGHT,
            1,
        )?;

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // The value in the stencil buffer is replaced if the new value is greater than the previous value.
        let stencil_op = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::REPLACE)
            .depth_fail_op(vk::StencilOp::REPLACE)
            .compare_op(vk::CompareOp::GREATER)
            .compare_mask(0xff)
            .write_mask(0xff)
            .reference(0)
            .build();
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(self.buffer_type == BufferType::Depth)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::GREATER)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(self.buffer_type == BufferType::Stencil)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let graphics_pipeline = make_graphics_pipeline_full(
            device,
            *pipeline_layout,
            *vertex_module,
            *fragment_module,
            *render_pass,
            (WIDTH, HEIGHT),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            vk::SampleCountFlags::_1,
            Some(&depth_stencil_state),
            1,
            None,
        )?;

        let is_depth = self.buffer_type == BufferType::Depth;
        let read_size = (WIDTH * HEIGHT) as usize * if is_depth { 4 } else { 1 };
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(read_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let clear_colors = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 0.0],
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 0.1, stencil: 0 },
            },
        ];

        // Both aspects of a combined format belong in the barrier even when only one is read.
        let barrier_aspect = if has_stencil(buffer_format) {
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::DEPTH
        };
        let read_barrier = make_image_memory_barrier(
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            depth_stencil_image.get(),
            make_image_subresource_range(barrier_aspect, 0, 1, 0, 1),
        );
        let copy_region = make_buffer_image_copy(extent, make_image_subresource_layers(image_aspect, 0, 0, 1));

        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);

            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(render_area)
                .clear_values(&clear_colors);
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_draw(cmd, vertices.len() as u32, 1, 0, 0);
            device.cmd_end_render_pass(cmd);

            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[read_barrier],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                depth_stencil_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                result_buffer.get(),
                &[copy_region],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let data = unsafe { std::slice::from_raw_parts(result_buffer.get_allocation().get_host_ptr(), read_size) };

        let mut result = true;
        for y in 0..HEIGHT as usize {
            for x in 0..WIDTH as usize {
                let texel = y * WIDTH as usize + x;
                if !is_depth {
                    if u32::from(data[texel]) != (x % 2) as u32 {
                        result = false;
                    }
                } else {
                    let word =
                        u32::from_le_bytes(data[texel * 4..texel * 4 + 4].try_into().expect("four bytes per texel"));
                    // The depth aspect of a 24-bit format is copied as X8_D24 (depth in the low 24 bits).
                    let depth_pixel =
                        if buffer_format == vk::Format::D32_SFLOAT || buffer_format == vk::Format::D32_SFLOAT_S8_UINT {
                            f32::from_bits(word)
                        } else {
                            (word & 0x00ff_ffff) as f32 / 16_777_215.0
                        };
                    if (depth_pixel < 0.09 || depth_pixel > 0.11) && x % 2 == 0 {
                        result = false;
                    }
                    if (depth_pixel < 0.19 || depth_pixel > 0.21) && x % 2 == 1 {
                        result = false;
                    }
                }
            }
        }

        Ok(if result {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `createDepthStencilWriteConditionsTests`
pub fn create_depth_stencil_write_conditions_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("depth_stencil_write_conditions");

    let depth_formats = [
        vk::Format::D32_SFLOAT_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::X8_D24_UNORM_PACK32,
        vk::Format::D32_SFLOAT,
    ];
    let stencil_formats = [vk::Format::D32_SFLOAT_S8_UINT, vk::Format::D24_UNORM_S8_UINT];

    let discards = [
        (DiscardType::Kill, "kill"),
        (DiscardType::Terminate, "terminate"),
        (DiscardType::Demote, "demote"),
    ];
    let mutations = [
        (MutationMode::Write, "write"),
        (MutationMode::Initialize, "initialize"),
        (MutationMode::InitializeWrite, "write_initialize"),
    ];

    for format in depth_formats {
        let postfix = match format {
            vk::Format::D24_UNORM_S8_UINT => "_d24unorm_s8ui",
            vk::Format::X8_D24_UNORM_PACK32 => "_d24_unorm",
            vk::Format::D32_SFLOAT => "_d32sf",
            _ => "_d32sf_s8ui",
        };
        for (discard_type, discard_name) in discards {
            for (mutation_mode, mutation_name) in mutations {
                test_group.add_child(Box::new(DepthStencilWriteConditionsTest {
                    name: format!("depth_{discard_name}_{mutation_name}{postfix}"),
                    buffer_type: BufferType::Depth,
                    discard_type,
                    mutation_mode,
                    buffer_format: format,
                }) as Box<dyn TestCase>);
            }
        }
    }

    for format in stencil_formats {
        let postfix = if format == vk::Format::D24_UNORM_S8_UINT {
            "_d24unorm_s8ui"
        } else {
            "_d32sf_s8ui"
        };
        for (discard_type, discard_name) in discards {
            for (mutation_mode, mutation_name) in mutations {
                test_group.add_child(Box::new(DepthStencilWriteConditionsTest {
                    name: format!("stencil_{discard_name}_{mutation_name}{postfix}"),
                    buffer_type: BufferType::Stencil,
                    discard_type,
                    mutation_mode,
                    buffer_format: format,
                }) as Box<dyn TestCase>);
            }
        }
    }

    test_group
}
