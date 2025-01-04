// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackSimpleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Mobica Limited.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `TEST_TYPE_BACKWARD_DEPENDENCY`, `TEST_TYPE_BACKWARD_DEPENDENCY_INDIRECT` and
// `TEST_TYPE_DRAW_INDIRECT_COUNTER_RESUBMIT` of the `simple` group. The `_device_address` variants need VK_KHR_device_address_commands and
// are not ported. The shaders are the `backward_*` ones of `shaders/manifest/transform_feedback_simple_streams.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::simple_pipeline::{XfbPipelineOptions, XfbStages, make_xfb_pipeline};
use super::simple_tests::{AddressCommands, validate_limits};
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer, make_memory_barrier,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vk::{VkResultExt, device_address_commands};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum BackwardType {
    BackwardDependency,
    BackwardDependencyIndirect,
    CounterResubmit,
}

#[derive(Clone, Copy)]
struct BackwardParameters {
    test_type: BackwardType,
    buffer_size: u32,
    part_count: u32,
    no_offset_array: bool,
    use_device_address_commands: bool,
}

/// `PushConstants`, which must match the vertex shader.
#[repr(C)]
#[derive(Clone, Copy)]
struct PushConstants {
    start_value: u32,
    width: f32,
    pos_y: f32,
}

impl PushConstants {
    fn to_bytes(self) -> Vec<u8> {
        let mut bytes = Vec::with_capacity(12);
        bytes.extend_from_slice(&self.start_value.to_ne_bytes());
        bytes.extend_from_slice(&self.width.to_ne_bytes());
        bytes.extend_from_slice(&self.pos_y.to_ne_bytes());
        bytes
    }
}

struct BackwardTestCase {
    name: String,
    parameters: BackwardParameters,
}

impl TestCase for BackwardTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TransformFeedbackTestCase::checkSupport`, for these types.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_transform_feedback")?;

        let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut xfb_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if xfb_features.transform_feedback == vk::FALSE {
            return Err(TestError::NotSupported(
                "transformFeedback feature is not supported".to_string(),
            ));
        }

        let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
        if xfb_properties.transform_feedback_draw == vk::FALSE {
            return Err(TestError::NotSupported(
                "transformFeedbackDraw not supported".to_string(),
            ));
        }

        if self.parameters.test_type == BackwardType::BackwardDependencyIndirect {
            context.require_device_functionality("VK_KHR_draw_indirect_count")?;
        }

        if self.parameters.use_device_address_commands {
            context.require_device_functionality(device_address_commands::EXTENSION_NAME)?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::transform_feedback_simple_streams::XFB_STREAM_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BackwardTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

/// `TransformFeedbackBackwardDependencyTestInstance`
struct BackwardTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: BackwardParameters,
}

/// `makeCustomRenderPass`: one colour attachment, and a subpass self-dependency from the transform feedback counter writes to the
/// indirect draw's counter reads.
fn make_custom_render_pass(device: &Device, format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let attachments = [vk::AttachmentDescription::builder()
        .format(format)
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
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_refs)];
    let dependencies = [vk::SubpassDependency {
        src_subpass: 0,
        dst_subpass: 0,
        src_stage_mask: vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
        dst_stage_mask: vk::PipelineStageFlags::DRAW_INDIRECT,
        src_access_mask: vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT,
        dst_access_mask: vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_READ_EXT,
        dependency_flags: vk::DependencyFlags::empty(),
    }];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses)
        .dependencies(&dependencies);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

impl TestInstance for BackwardTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.parameters;
        let context = self.context;
        validate_limits(context)?;

        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();

        // generateSizesList: equal chunks
        let chunk_size = (params.buffer_size / params.part_count) as vk::DeviceSize;
        debug_assert!(params.part_count == 2 && chunk_size * params.part_count as u64 == params.buffer_size as u64);
        let chunk_offsets = [0 as vk::DeviceSize, chunk_size];

        let num_points = (chunk_size / std::mem::size_of::<u32>() as u64) as u32;
        let indirect_draw = params.test_type == BackwardType::BackwardDependencyIndirect;
        const RESUBMIT_COUNT: u32 = 16; // Number of submissions of the same command buffer
        let resubmit_cmd_buffer = params.test_type == BackwardType::CounterResubmit;

        // Color buffer.
        let (fb_width, fb_height) = (num_points, 1u32);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_image = ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(
                IVec2::new(fb_width as i32, fb_height as i32),
                color_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_subres_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_view = make_image_view(
            vk,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subres_range,
        )?;
        let color_buffer_size = (fb_width * fb_height * 4) as vk::DeviceSize;
        let color_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let geom_color = [0u8, 0, 255, 255]; // Must match frag shader.

        let pc_size = std::mem::size_of::<PushConstants>() as u32;
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(vk, binaries.get("backward_vert")?)?;
        let frag_module = create_shader_module(vk, binaries.get("backward_frag")?)?;
        let render_pass = make_custom_render_pass(vk, color_format)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[*color_view], fb_width, fb_height, 1)?;
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::VERTEX,
            offset: 0,
            size: pc_size,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            vk,
            unsafe { vk.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let stages = XfbStages {
            vert: *vertex_module,
            frag: Some(*frag_module),
            ..XfbStages::default()
        };
        let options = XfbPipelineOptions {
            attachment_count: 1,
            ..XfbPipelineOptions::default()
        };
        let pipeline = make_xfb_pipeline(
            vk,
            *pipeline_layout,
            *render_pass,
            &stages,
            (fb_width, fb_height),
            0,
            &options,
        )?;
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let address_commands = AddressCommands::new(context, params.use_device_address_commands)?;
        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                params.buffer_size as u64,
                address_commands
                    .usage(vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
            ),
            address_commands.requirement(MemoryRequirement::HOST_VISIBLE),
        )?;
        let tf_buf_device_address = address_commands.address(vk, tf_buf.get());
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        let tf_buf_binding_size = params.buffer_size as vk::DeviceSize;
        let tf_buf_binding_offset = 0 as vk::DeviceSize;

        let tfc_buf_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let tfc_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                tfc_buf_size,
                address_commands.usage(
                    vk::BufferUsageFlags::TRANSFORM_FEEDBACK_COUNTER_BUFFER_EXT | vk::BufferUsageFlags::INDIRECT_BUFFER,
                ),
            ),
            address_commands.requirement(MemoryRequirement::ANY),
        )?;
        let tfc_buf_device_address = address_commands.address(vk, tfc_buf.get());
        let tfc_buf_binding_offset = 0 as vk::DeviceSize;
        let tfc_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_WRITE_EXT,
            vk::AccessFlags::TRANSFORM_FEEDBACK_COUNTER_READ_EXT,
        );

        let indirect_struct_size = std::mem::size_of::<vk::DrawIndirectCommand>() as u32;
        let indirect_stride = indirect_struct_size * 2; // See below.
        let mut indirect_buffer: Option<BufferWithMemory<'_>> = None;
        let mut indirect_buffer_size = 0 as vk::DeviceSize;
        let mut indirect_device_address: vk::DeviceAddress = 0;

        if indirect_draw {
            // Prepare indirect commands. The first entry will be used as the count.
            // Each subsequent indirect command will be padded with an unused structure.
            let mut indirect_commands: Vec<vk::DrawIndirectCommand> = Vec::with_capacity(num_points as usize + 1);
            indirect_commands.push(vk::DrawIndirectCommand {
                vertex_count: num_points,
                instance_count: 0,
                first_vertex: 0,
                first_instance: 0,
            });

            for draw_idx in 0..num_points {
                indirect_commands.push(vk::DrawIndirectCommand {
                    vertex_count: 1,
                    instance_count: 1,
                    first_vertex: draw_idx,
                    first_instance: 0,
                });
                indirect_commands.push(vk::DrawIndirectCommand {
                    vertex_count: 0,
                    instance_count: 0,
                    first_vertex: 0,
                    first_instance: 0,
                });
            }

            indirect_buffer_size =
                (indirect_commands.len() * std::mem::size_of::<vk::DrawIndirectCommand>()) as vk::DeviceSize;
            let buffer = BufferWithMemory::new(
                vk,
                allocator,
                make_buffer_create_info(
                    indirect_buffer_size,
                    address_commands.usage(vk::BufferUsageFlags::INDIRECT_BUFFER),
                ),
                address_commands.requirement(MemoryRequirement::HOST_VISIBLE),
            )?;
            indirect_device_address = address_commands.address(vk, buffer.get());
            unsafe {
                std::ptr::copy_nonoverlapping(
                    indirect_commands.as_ptr().cast::<u8>(),
                    buffer.get_allocation().get_host_ptr(),
                    indirect_buffer_size as usize,
                )
            };
            flush_alloc(vk, buffer.get_allocation())?;
            indirect_buffer = Some(buffer);
        }

        let cmd_begin_info = vk::CommandBufferBeginInfo::builder().flags(if resubmit_cmd_buffer {
            vk::CommandBufferUsageFlags::SIMULTANEOUS_USE
        } else {
            vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT
        });
        unsafe { vk.begin_command_buffer(cmd_buffer, &cmd_begin_info) }.vk_check("vkBeginCommandBuffer")?;
        {
            begin_render_pass(
                vk,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, fb_width, fb_height),
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: clear_color },
                },
            );
            {
                unsafe {
                    vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

                    address_commands.bind_buffers(
                        vk,
                        cmd_buffer,
                        0,
                        &[tf_buf.get()],
                        &[tf_buf_device_address],
                        &[tf_buf_binding_offset],
                        &[tf_buf_binding_size],
                    );
                }

                {
                    let start_value = (chunk_offsets[0] / std::mem::size_of::<u32>() as u64) as u32;
                    // Push the points offscreen.
                    let pc_data = PushConstants {
                        start_value,
                        width: fb_width as f32,
                        pos_y: 10.0,
                    };

                    unsafe {
                        vk.cmd_push_constants(
                            cmd_buffer,
                            *pipeline_layout,
                            vk::ShaderStageFlags::VERTEX,
                            0,
                            &pc_data.to_bytes(),
                        );

                        address_commands.begin(
                            vk,
                            cmd_buffer,
                            0,
                            0,
                            std::ptr::null(),
                            std::ptr::null(),
                            std::ptr::null(),
                            std::ptr::null(),
                        );
                        {
                            if let Some(indirect_buffer) = &indirect_buffer {
                                address_commands.draw_indirect_count(
                                    vk,
                                    cmd_buffer,
                                    indirect_buffer.get(),
                                    indirect_device_address,
                                    indirect_struct_size as vk::DeviceSize,
                                    indirect_buffer_size,
                                    indirect_buffer.get(),
                                    indirect_device_address,
                                    0,
                                    indirect_buffer_size,
                                    num_points,
                                    indirect_stride,
                                );
                            } else {
                                vk.cmd_draw(cmd_buffer, num_points, 1, 0, 0);
                            }
                        }

                        let end_offsets: *const vk::DeviceSize = if params.no_offset_array {
                            std::ptr::null()
                        } else {
                            &tfc_buf_binding_offset
                        };
                        let end_sizes: *const vk::DeviceSize = if params.no_offset_array {
                            std::ptr::null()
                        } else {
                            &tfc_buf_size
                        };
                        address_commands.end(
                            vk,
                            cmd_buffer,
                            0,
                            1,
                            &tfc_buf.get(),
                            &tfc_buf_device_address,
                            end_offsets,
                            end_sizes,
                        );
                    }
                }

                if let Some(indirect_buffer) = &indirect_buffer {
                    // This should be a no-op but allows us to reset the indirect draw counter in case it could influence the follow-up indirect draw.
                    unsafe {
                        address_commands.draw_indirect_count(
                            vk,
                            cmd_buffer,
                            indirect_buffer.get(),
                            indirect_device_address,
                            indirect_struct_size as vk::DeviceSize,
                            indirect_buffer_size,
                            indirect_buffer.get(),
                            indirect_device_address,
                            0,
                            indirect_buffer_size,
                            0, /*no draws*/
                            indirect_stride,
                        )
                    };
                    debug_assert!(indirect_buffer_size > 0);
                }

                unsafe {
                    vk.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                        vk::PipelineStageFlags::DRAW_INDIRECT,
                        vk::DependencyFlags::empty(),
                        &[tfc_memory_barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }

                {
                    let start_value = (chunk_offsets[1] / std::mem::size_of::<u32>() as u64) as u32;
                    // Points onscreen in this second draw.
                    let pc_data = PushConstants {
                        start_value,
                        width: fb_width as f32,
                        pos_y: 0.0,
                    };
                    let begin_offsets: *const vk::DeviceSize = if params.no_offset_array {
                        std::ptr::null()
                    } else {
                        &tfc_buf_binding_offset
                    };

                    unsafe {
                        vk.cmd_push_constants(
                            cmd_buffer,
                            *pipeline_layout,
                            vk::ShaderStageFlags::VERTEX,
                            0,
                            &pc_data.to_bytes(),
                        );

                        address_commands.begin(
                            vk,
                            cmd_buffer,
                            0,
                            1,
                            &tfc_buf.get(),
                            &tfc_buf_device_address,
                            begin_offsets,
                            &tfc_buf_size,
                        );
                        address_commands.draw_indirect_byte_count(
                            vk,
                            cmd_buffer,
                            1,
                            0,
                            tfc_buf.get(),
                            tfc_buf_device_address,
                            0,
                            tfc_buf_size,
                            0,
                            4,
                        );

                        address_commands.end(
                            vk,
                            cmd_buffer,
                            0,
                            0,
                            std::ptr::null(),
                            std::ptr::null(),
                            std::ptr::null(),
                            std::ptr::null(),
                        );
                    }
                }
            }
            end_render_pass(vk, cmd_buffer);

            let image_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_image.get(),
                color_subres_range,
            );
            let region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: fb_width,
                    height: fb_height,
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
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[tf_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[image_barrier],
                );
                vk.cmd_copy_image_to_buffer(
                    cmd_buffer,
                    color_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.get(),
                    &[region],
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
        end_command_buffer(vk, cmd_buffer)?;

        if !resubmit_cmd_buffer {
            submit_commands_and_wait(vk, queue, cmd_buffer)?;
        } else {
            // Resubmit the same command buffer
            for _exec_idx in 0..RESUBMIT_COUNT {
                submit_commands_and_wait(vk, queue, cmd_buffer)?;
            }
        }

        // verifyTransformFeedbackBuffer
        invalidate_alloc(vk, tf_buf.get_allocation())?;
        let tf_data = unsafe {
            std::slice::from_raw_parts(
                tf_buf.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                params.buffer_size as usize / std::mem::size_of::<u32>(),
            )
        };
        for (i, &received) in tf_data.iter().enumerate() {
            if received != i as u32 {
                return Err(TestError::Fail(format!(
                    "Failed at item {i} received:{received} expected:{i}"
                )));
            }
        }

        // Verify color buffer, to check vkCmdDrawIndirectByteCountEXT worked.
        invalidate_alloc(vk, color_buffer.get_allocation())?;
        let result = unsafe {
            std::slice::from_raw_parts(
                color_buffer.get_allocation().get_host_ptr().cast_const(),
                color_buffer_size as usize,
            )
        };
        if result.chunks_exact(4).any(|pixel| pixel != geom_color) {
            return Ok(TestStatus::fail(
                "Color buffer contains unexpected results; check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `addTransformFeedbackTestCaseVariants` for a point list with `pointSize == 0`: the size-less variant is illegal (the point size has to be
/// written by the vertex shader), so only the size-1 one exists and carries no `_ptsz` suffix.
fn add_variant(group: &mut TestCaseGroup, name: &str, parameters: BackwardParameters) {
    group.add_child(Box::new(BackwardTestCase {
        name: name.to_string(),
        parameters,
    }) as Box<dyn TestCase>);
}

/// The `backward_dependency*` and `draw_indirect_counter_resubmit` blocks of `createTransformFeedbackSimpleTests`.
pub(super) fn add_backward_tests(group: &mut TestCaseGroup) {
    for (test_type, test_name) in [
        (BackwardType::BackwardDependency, "backward_dependency"),
        (BackwardType::BackwardDependencyIndirect, "backward_dependency_indirect"),
    ] {
        let parameters = BackwardParameters {
            test_type,
            buffer_size: 512,
            part_count: 2,
            no_offset_array: false,
            use_device_address_commands: false,
        };

        // Rendering test checks backward pipeline dependency
        add_variant(group, test_name, parameters);

        // The stream id 0 begin/end query indexed modes only change what the query tests do.
        add_variant(group, &format!("{test_name}_beginqueryindexed_streamid_0"), parameters);
        add_variant(group, &format!("{test_name}_endqueryindexed_streamid_0"), parameters);

        // Rendering test checks backward pipeline dependency (using NULL for offset array)
        add_variant(
            group,
            &format!("{test_name}_no_offset_array"),
            BackwardParameters {
                no_offset_array: true,
                ..parameters
            },
        );

        add_variant(
            group,
            &format!("{test_name}_device_address"),
            BackwardParameters {
                use_device_address_commands: true,
                ..parameters
            },
        );
    }

    let parameters = BackwardParameters {
        test_type: BackwardType::CounterResubmit,
        buffer_size: 512,
        part_count: 2,
        no_offset_array: false,
        use_device_address_commands: false,
    };
    add_variant(group, "draw_indirect_counter_resubmit", parameters);
    add_variant(
        group,
        "draw_indirect_counter_resubmit_device_address",
        BackwardParameters {
            use_device_address_commands: true,
            ..parameters
        },
    );
}
