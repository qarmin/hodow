// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderConditionalRenderingTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are manifest GLSL, four sets for the task and multiview options.
//
// Draws a full screen triangle from mesh (and optionally task) shaders under conditional rendering, with the condition in a
// buffer bound with and without an offset and read with and without one, from primary and secondary command buffers.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtConditionalRenderingExtensionDeviceCommands, ExtMeshShaderExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::mesh_shader_conditional_rendering::{
    COND_MESH_AND_TASK, COND_MESH_AND_TASK_MULTIVIEW, COND_MESH_ONLY, COND_MESH_ONLY_MULTIVIEW,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{Allocation, MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline};
use crate::vkt::tests::mesh_shader::util::{check_task_mesh_shader_support_ext, mesh_shader_features};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawType {
    Draw,
    DrawIndirect,
    DrawIndirectWithCount,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CmdBufferType {
    Primary,
    Secondary,
    SecondaryWithInheritance,
}

const BIND_OFFSET: vk::DeviceSize = 16;

fn get_cond_values() -> [u32; 5] {
    [0x0100_0000, 0x0001_0000, 0x0000_0100, 0x0000_0001, 0x0000_0000]
}

fn padded_hex(value: u32) -> String {
    format!("0x{value:08x}")
}

/// `getOutputColor` as unorm bytes
fn output_color(layer_index: u32) -> [u8; 4] {
    debug_assert!(layer_index <= 1);
    [(layer_index * 255) as u8, 0, 255, 255]
}

const CLEAR_COLOR: [f32; 4] = [0.0, 0.0, 0.0, 1.0];
const CLEAR_COLOR_BYTES: [u8; 4] = [0, 0, 0, 255];

#[derive(Clone, Copy)]
struct TestParams {
    draw_type: DrawType,
    cmd_buffer_type: CmdBufferType,
    bind_with_offset: bool,
    cond_with_offset: bool,
    cond_value: u32,
    inverted: bool,
    use_task: bool,
    multi_view: bool,
}

impl TestParams {
    fn needs_secondary_cmd_buffer(&self) -> bool {
        self.cmd_buffer_type != CmdBufferType::Primary
    }
}

struct ConditionalRenderingCase {
    name: String,
    params: TestParams,
}

/// `ConditionBuffer`
struct ConditionBuffer<'a> {
    buffer: Unique<'a, vk::Buffer>,
    _allocation: Allocation<'a>,
    cond_offset: vk::DeviceSize,
}

impl<'a> ConditionBuffer<'a> {
    fn new(
        context: &'a Context<'a>,
        cond_value: u32,
        bind_with_offset: bool,
        cond_with_offset: bool,
    ) -> Result<Self, TestError> {
        let device = context.get_device();

        // Create buffer with the desired size first.
        let cond_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let cond_offset = if cond_with_offset { cond_size } else { 0 };
        let buffer_size = cond_size + cond_offset;
        let create_info = make_buffer_create_info(buffer_size, vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT);
        let buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&create_info, None) }.vk_check("vkCreateBuffer")?,
        );

        // Allocate memory taking bind_with_offset into account.
        let buffer_mem_reqs = unsafe { device.get_buffer_memory_requirements(*buffer) };
        let bind_offset = if bind_with_offset {
            BIND_OFFSET.div_ceil(buffer_mem_reqs.alignment) * buffer_mem_reqs.alignment
        } else {
            0
        };
        let actual_mem_reqs = vk::MemoryRequirements {
            size: buffer_mem_reqs.size + bind_offset,
            alignment: buffer_mem_reqs.alignment,
            memory_type_bits: buffer_mem_reqs.memory_type_bits,
        };
        let allocation =
            context
                .get_default_allocator()
                .allocate(device, actual_mem_reqs, MemoryRequirement::HOST_VISIBLE)?;
        unsafe { device.bind_buffer_memory(*buffer, allocation.get_memory(), allocation.get_offset() + bind_offset) }
            .vk_check("vkBindBufferMemory")?;

        // Fill buffer data.
        let fill_value: u32 = if cond_value != 0 { 0 } else { 1 };
        unsafe {
            let host_ptr = allocation.get_host_ptr();
            std::ptr::write_bytes(host_ptr, 0, actual_mem_reqs.size as usize);
            std::ptr::copy_nonoverlapping(fill_value.to_ne_bytes().as_ptr(), host_ptr.add(bind_offset as usize), 4);
            std::ptr::copy_nonoverlapping(
                cond_value.to_ne_bytes().as_ptr(),
                host_ptr.add((bind_offset + cond_offset) as usize),
                4,
            );
        }
        flush_alloc(device, &allocation)?;

        Ok(Self {
            buffer,
            _allocation: allocation,
            cond_offset,
        })
    }

    fn get_buffer(&self) -> vk::Buffer {
        *self.buffer
    }
}

impl TestCase for ConditionalRenderingCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ConditionalRenderingCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        check_task_mesh_shader_support_ext(context, params.use_task, true)?;

        context.require_device_functionality("VK_EXT_conditional_rendering")?;

        if params.draw_type == DrawType::DrawIndirectWithCount {
            context.require_device_functionality("VK_KHR_draw_indirect_count")?;
        }

        if params.cmd_buffer_type == CmdBufferType::SecondaryWithInheritance {
            let mut cond_rendering_features = vk::PhysicalDeviceConditionalRenderingFeaturesEXT::default();
            {
                let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut cond_rendering_features);
                unsafe {
                    context
                        .get_instance()
                        .get_physical_device_features2(context.get_physical_device(), &mut features2)
                };
            }
            if cond_rendering_features.inherited_conditional_rendering == vk::FALSE {
                return Err(TestError::NotSupported(
                    "inheritedConditionalRendering not supported".to_string(),
                ));
            }
        }

        if params.multi_view {
            context.require_device_functionality("VK_KHR_multiview")?;

            if mesh_shader_features(context).multiview_mesh_shader == vk::FALSE {
                return Err(TestError::NotSupported("multiviewMeshShader not supported".to_string()));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match (self.params.use_task, self.params.multi_view) {
            (false, false) => COND_MESH_ONLY.programs,
            (true, false) => COND_MESH_AND_TASK.programs,
            (false, true) => COND_MESH_ONLY_MULTIVIEW.programs,
            (true, true) => COND_MESH_AND_TASK_MULTIVIEW.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConditionalRenderingInstance {
            context,
            params: self.params,
        })
    }
}

struct ConditionalRenderingInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for ConditionalRenderingInstance<'_> {
    /// `ConditionalRenderingInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();

        let color_format = vk::Format::R8G8B8A8_UNORM;
        let image_layers: u32 = if params.multi_view { 2 } else { 1 };
        let fb_extent = (4u32, 4u32);
        let color_extent = vk::Extent3D {
            width: fb_extent.0,
            height: fb_extent.1,
            depth: 1,
        };
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let needs_sec_cmd = params.needs_secondary_cmd_buffer();

        // Create color attachment.
        let color_att_create_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(color_extent)
            .mip_levels(1)
            .array_layers(image_layers)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_att = ImageWithMemory::new(device, alloc, color_att_create_info, MemoryRequirement::ANY)?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, image_layers);
        let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, image_layers);
        let view_type = if params.multi_view {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        };
        let color_att_view = make_image_view(device, color_att.get(), view_type, color_format, color_srr)?;

        // Render pass and framebuffer.
        let multiview_mask = [0x3u32];
        let mut multiview_create_info = vk::RenderPassMultiviewCreateInfo::builder().view_masks(&multiview_mask);
        let attachments = [vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];
        let color_refs = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(bind_point)
            .color_attachments(&color_refs)];
        let mut render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        if params.multi_view {
            render_pass_info = render_pass_info.push_next(&mut multiview_create_info);
        }
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_att_view],
            color_extent.width,
            color_extent.height,
            1,
        )?;

        // Verification buffer.
        let verif_buffer_size = (4 * fb_extent.0 * fb_extent.1 * image_layers) as vk::DeviceSize;
        let verif_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(verif_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Create the condition buffer.
        let condition_buffer = ConditionBuffer::new(
            context,
            params.cond_value,
            params.bind_with_offset,
            params.cond_with_offset,
        )?;

        // Create the indirect buffers if needed.
        let indirect_draw_args_buffer = if params.draw_type != DrawType::Draw {
            let draw_args = vk::DrawMeshTasksIndirectCommandEXT {
                group_count_x: 1,
                group_count_y: 1,
                group_count_z: 1,
            };
            Some(create_host_buffer(
                context,
                &[draw_args],
                vk::BufferUsageFlags::INDIRECT_BUFFER,
            )?)
        } else {
            None
        };
        let indirect_draw_count_buffer = if params.draw_type == DrawType::DrawIndirectWithCount {
            Some(create_host_buffer(
                context,
                &[1u32],
                vk::BufferUsageFlags::INDIRECT_BUFFER,
            )?)
        } else {
            None
        };

        // Pipeline.
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let binaries = context.get_binary_collection();
        let task_module = if binaries.contains("task") {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut stages = Vec::new();
        if let Some(task) = &task_module {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_module));
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        let state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(color_extent.width, color_extent.height);
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        // Command pool and command buffers.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let primary_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let secondary_cmd_buffer = if needs_sec_cmd {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };
        let primary = *primary_cmd_buffer;

        // Common conditional rendering begin info.
        let conditional_rendering_flags = if params.inverted {
            vk::ConditionalRenderingFlagsEXT::INVERTED
        } else {
            vk::ConditionalRenderingFlagsEXT::empty()
        };
        let conditional_rendering_begin = vk::ConditionalRenderingBeginInfoEXT::builder()
            .buffer(condition_buffer.get_buffer())
            .offset(condition_buffer.cond_offset)
            .flags(conditional_rendering_flags);

        // Inheritance info for the secondary command buffer.
        let conditional_rendering_enable = params.cmd_buffer_type == CmdBufferType::SecondaryWithInheritance;
        let mut conditional_rendering_inheritance_info =
            vk::CommandBufferInheritanceConditionalRenderingInfoEXT::builder()
                .conditional_rendering_enable(conditional_rendering_enable);
        let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
            .render_pass(*render_pass)
            .subpass(0)
            .framebuffer(*framebuffer)
            .occlusion_query_enable(false)
            .push_next(&mut conditional_rendering_inheritance_info);
        let secondary_begin_info = vk::CommandBufferBeginInfo::builder()
            .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
            .inheritance_info(&inheritance_info);

        let scissor = make_rect_2d(0, 0, color_extent.width, color_extent.height);
        let clear_values = [clear_value_color(CLEAR_COLOR)];
        let render_pass_begin = |contents: vk::SubpassContents, cmd: vk::CommandBuffer| {
            let info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(scissor)
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd, &info, contents) };
        };

        // `drawMeshTasks`
        let stride = std::mem::size_of::<vk::DrawMeshTasksIndirectCommandEXT>() as u32;
        let draw_mesh_tasks = |cmd: vk::CommandBuffer| unsafe {
            match params.draw_type {
                DrawType::Draw => device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1),
                DrawType::DrawIndirect => device.cmd_draw_mesh_tasks_indirect_ext(
                    cmd,
                    indirect_draw_args_buffer.as_ref().expect("indirect buffer").get(),
                    0,
                    1,
                    stride,
                ),
                DrawType::DrawIndirectWithCount => device.cmd_draw_mesh_tasks_indirect_count_ext(
                    cmd,
                    indirect_draw_args_buffer.as_ref().expect("indirect buffer").get(),
                    0,
                    indirect_draw_count_buffer.as_ref().expect("count buffer").get(),
                    0,
                    1,
                    stride,
                ),
            }
        };

        begin_command_buffer(device, primary)?;

        match params.cmd_buffer_type {
            CmdBufferType::Primary => {
                // Do everything in the primary command buffer.
                unsafe { device.cmd_begin_conditional_rendering_ext(primary, &conditional_rendering_begin) };
                render_pass_begin(vk::SubpassContents::INLINE, primary);
                unsafe { device.cmd_bind_pipeline(primary, bind_point, pipeline.get()) };
                draw_mesh_tasks(primary);
                unsafe {
                    device.cmd_end_render_pass(primary);
                    device.cmd_end_conditional_rendering_ext(primary);
                }
            }
            CmdBufferType::Secondary => {
                // Do everything in the secondary command buffer, with the conditional rendering inside the render pass.
                render_pass_begin(vk::SubpassContents::SECONDARY_COMMAND_BUFFERS, primary);

                let secondary = **secondary_cmd_buffer.as_ref().expect("secondary command buffer");
                unsafe {
                    device
                        .begin_command_buffer(secondary, &secondary_begin_info)
                        .vk_check("vkBeginCommandBuffer")?;
                    device.cmd_bind_pipeline(secondary, bind_point, pipeline.get());
                    device.cmd_begin_conditional_rendering_ext(secondary, &conditional_rendering_begin);
                }
                draw_mesh_tasks(secondary);
                unsafe { device.cmd_end_conditional_rendering_ext(secondary) };
                end_command_buffer(device, secondary)?;

                unsafe {
                    device.cmd_execute_commands(primary, &[secondary]);
                    device.cmd_end_render_pass(primary);
                }
            }
            CmdBufferType::SecondaryWithInheritance => {
                // Inherit everything in the secondary command buffer.
                let secondary = **secondary_cmd_buffer.as_ref().expect("secondary command buffer");
                unsafe {
                    device
                        .begin_command_buffer(secondary, &secondary_begin_info)
                        .vk_check("vkBeginCommandBuffer")?;
                    device.cmd_bind_pipeline(secondary, bind_point, pipeline.get());
                }
                draw_mesh_tasks(secondary);
                end_command_buffer(device, secondary)?;

                unsafe { device.cmd_begin_conditional_rendering_ext(primary, &conditional_rendering_begin) };
                render_pass_begin(vk::SubpassContents::SECONDARY_COMMAND_BUFFERS, primary);
                unsafe {
                    device.cmd_execute_commands(primary, &[secondary]);
                    device.cmd_end_render_pass(primary);
                    device.cmd_end_conditional_rendering_ext(primary);
                }
            }
        }

        // Transfer color attachment to the verification buffer.
        let post_transfer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        let copy_region = make_buffer_image_copy(color_extent, color_srl);
        let pre_transfer_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_att.get(),
            color_srr,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                primary,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre_transfer_barrier],
            );
            device.cmd_copy_image_to_buffer(
                primary,
                color_att.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                verif_buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                primary,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[post_transfer_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, primary)?;
        submit_commands_and_wait(device, context.get_universal_queue(), primary)?;

        let verif_alloc = verif_buffer.get_allocation();
        invalidate_alloc(device, verif_alloc)?;
        let result =
            unsafe { std::slice::from_raw_parts(verif_alloc.get_host_ptr().cast_const(), verif_buffer_size as usize) };

        let expect_draw = (params.cond_value != 0) != params.inverted;
        let layer_size = (4 * fb_extent.0 * fb_extent.1) as usize;

        for k in 0..image_layers {
            let layer = &result[k as usize * layer_size..(k as usize + 1) * layer_size];
            let expected_color = if expect_draw {
                output_color(k)
            } else {
                CLEAR_COLOR_BYTES
            };

            if !layer.chunks_exact(4).all(|pixel| pixel == expected_color) {
                log::info!("Result comparison failed for layer {k}: expected {expected_color:?}");
                return Ok(TestStatus::fail("Check log for details"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMeshShaderConditionalRenderingTestsEXT`
pub fn create_mesh_shader_conditional_rendering_tests_ext() -> TestCaseGroup {
    let draw_type_cases = [
        (DrawType::Draw, "draw"),
        (DrawType::DrawIndirect, "draw_indirect"),
        (DrawType::DrawIndirectWithCount, "draw_indirect_count"),
    ];
    let cmd_buffer_type_cases = [
        (CmdBufferType::Primary, "primary_cmd_buffer"),
        (CmdBufferType::Secondary, "secondary_cmd_buffer"),
        (
            CmdBufferType::SecondaryWithInheritance,
            "secondary_cmd_buffer_inheritance",
        ),
    ];
    let bind_with_offset_cases = [(false, "bind_without_offset"), (true, "bind_with_offset")];
    let cond_with_offset_cases = [(false, "cond_without_offset"), (true, "cond_with_offset")];
    let inversion_cases = [(false, "normal_cond"), (true, "inverted_cond")];
    let use_task_cases = [(false, "mesh_only"), (true, "mesh_and_task")];

    let mut main_group = TestCaseGroup::new("conditional_rendering");

    for (draw_type, draw_type_name) in draw_type_cases {
        let mut draw_type_group = TestCaseGroup::new(draw_type_name);

        for (cmd_buffer_type, cmd_buffer_type_name) in cmd_buffer_type_cases {
            let mut cmd_buffer_type_group = TestCaseGroup::new(cmd_buffer_type_name);

            for (bind_with_offset, bind_with_offset_name) in bind_with_offset_cases {
                let mut bind_with_offset_group = TestCaseGroup::new(bind_with_offset_name);

                for (cond_with_offset, cond_with_offset_name) in cond_with_offset_cases {
                    let mut cond_with_offset_group = TestCaseGroup::new(cond_with_offset_name);

                    for (inverted, inversion_name) in inversion_cases {
                        let mut inversion_group = TestCaseGroup::new(inversion_name);

                        for (use_task, use_task_name) in use_task_cases {
                            let mut use_task_group = TestCaseGroup::new(use_task_name);

                            for cond_value in get_cond_values() {
                                for multi_view in [false, true] {
                                    if multi_view {
                                        // Skip some multiview combinations which are not that interesting.
                                        if cond_value != 0 && cond_value != 1 {
                                            continue;
                                        }

                                        if bind_with_offset {
                                            continue;
                                        }

                                        if cond_with_offset {
                                            continue;
                                        }
                                    }

                                    let name = format!(
                                        "value_{}{}",
                                        padded_hex(cond_value),
                                        if multi_view { "_multiview" } else { "" }
                                    );
                                    let params = TestParams {
                                        draw_type,
                                        cmd_buffer_type,
                                        bind_with_offset,
                                        cond_with_offset,
                                        cond_value,
                                        inverted,
                                        use_task,
                                        multi_view,
                                    };
                                    use_task_group.add_child(
                                        Box::new(ConditionalRenderingCase { name, params }) as Box<dyn TestCase>
                                    );
                                }
                            }

                            inversion_group.add_child(use_task_group);
                        }

                        cond_with_offset_group.add_child(inversion_group);
                    }

                    bind_with_offset_group.add_child(cond_with_offset_group);
                }

                cmd_buffer_type_group.add_child(bind_with_offset_group);
            }

            draw_type_group.add_child(cmd_buffer_type_group);
        }

        main_group.add_child(draw_type_group);
    }

    main_group
}
