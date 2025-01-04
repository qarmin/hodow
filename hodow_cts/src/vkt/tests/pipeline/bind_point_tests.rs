// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineBindPointTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2021 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the (graphics, compute) pair is ported: the two pairs that
// involve ray tracing need `VK_KHR_ray_tracing_pipeline`, a shader binding table and the ray generation shader.

use std::ffi::c_void;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_1, KhrDescriptorUpdateTemplateExtensionDeviceCommands, KhrPushDescriptorExtensionDeviceCommands,
};

use crate::generated::shaders::pipeline_bind_point::BIND_POINT_GRAPHICS_COMPUTE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `SetupOp`, without the ray tracing entries. The order is the one `std::next_permutation` walks.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum SetupOp {
    BindGraphicsPipeline,
    BindComputePipeline,
    BindGraphicsSet,
    BindComputeSet,
}

/// `SetUpdateType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SetUpdateType {
    Write,
    Push,
    PushWithTemplate,
}

const ALL_UPDATE_TYPES: [SetUpdateType; 3] = [
    SetUpdateType::Write,
    SetUpdateType::Push,
    SetUpdateType::PushWithTemplate,
];

/// `DispatchOp`, without `TRACE_RAYS`.
#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum DispatchOp {
    Draw,
    Compute,
}

#[derive(Clone, Copy)]
struct TestParams {
    graphics_set_update_type: SetUpdateType,
    compute_set_update_type: SetUpdateType,
    setup_sequence: [SetupOp; 4],
    dispatch_sequence: [DispatchOp; 2],
}

const EXPECTED_BUFFER_VALUE_GRAPHICS: u32 = 1;
const EXPECTED_BUFFER_VALUE_COMPUTE: u32 = 2;

struct BindPointTest {
    name: String,
    params: TestParams,
}

impl TestCase for BindPointTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `BindPointTest::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        if params.graphics_set_update_type != SetUpdateType::Write
            || params.compute_set_update_type != SetUpdateType::Write
        {
            context.require_device_functionality("VK_KHR_push_descriptor")?;

            if params.graphics_set_update_type == SetUpdateType::PushWithTemplate
                || params.compute_set_update_type == SetUpdateType::PushWithTemplate
            {
                context.require_device_functionality("VK_KHR_descriptor_update_template")?;
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BIND_POINT_GRAPHICS_COMPUTE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BindPointInstance {
            context,
            params: self.params,
        })
    }
}

struct BindPointInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// `makeSetLayout`
fn make_set_layout(
    device: &Device,
    stages: vk::ShaderStageFlags,
    push: bool,
) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
    let create_flags = if push {
        vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR
    } else {
        vk::DescriptorSetLayoutCreateFlags::empty()
    };
    DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, stages)
        .build_with_flags(device, create_flags)
}

/// `zeroOutAndFlush`
fn zero_out_and_flush(
    device: &Device,
    buffer: &BufferWithMemory<'_>,
    buffer_size: vk::DeviceSize,
) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, buffer_size as usize) };
    flush_alloc(device, alloc)
}

/// `makePoolAndSet` and `writeSetUpdate`: the set is declared before the pool so that it is freed first.
fn make_written_set<'a>(
    device: &'a Device,
    layout: vk::DescriptorSetLayout,
    buffer: vk::Buffer,
    size: vk::DeviceSize,
) -> Result<(UniqueDescriptorSet<'a>, Unique<'a, vk::DescriptorPool>), TestError> {
    let pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let set = make_descriptor_set(device, *pool, layout)?;
    let buffer_info = vk::DescriptorBufferInfo {
        buffer,
        offset: 0,
        range: size,
    };
    DescriptorSetUpdateBuilder::new()
        .write_single(
            set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &buffer_info,
        )
        .update(device);
    Ok((set, pool))
}

/// A push descriptor update template, destroyed when it goes out of scope.
struct UpdateTemplate<'a> {
    device: &'a Device,
    handle: vk::DescriptorUpdateTemplate,
    use_khr: bool,
}

impl Drop for UpdateTemplate<'_> {
    fn drop(&mut self) {
        unsafe {
            if self.use_khr {
                self.device.destroy_descriptor_update_template_khr(self.handle, None);
            } else {
                self.device.destroy_descriptor_update_template(self.handle, None);
            }
        }
    }
}

/// `makeUpdateTemplate`
fn make_update_template<'a>(
    context: &'a Context<'a>,
    set_layout: vk::DescriptorSetLayout,
    bind_point: vk::PipelineBindPoint,
    pipeline_layout: vk::PipelineLayout,
) -> Result<UpdateTemplate<'a>, TestError> {
    let device = context.get_device();
    let entries = [vk::DescriptorUpdateTemplateEntry::builder()
        .dst_binding(0)
        .dst_array_element(0)
        .descriptor_count(1)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .offset(0)
        .stride(std::mem::size_of::<vk::DescriptorBufferInfo>())
        .build()];
    let info = vk::DescriptorUpdateTemplateCreateInfo::builder()
        .descriptor_update_entries(&entries)
        .template_type(vk::DescriptorUpdateTemplateType::PUSH_DESCRIPTORS)
        .descriptor_set_layout(set_layout)
        .pipeline_bind_point(bind_point)
        .pipeline_layout(pipeline_layout)
        .set(0);

    let use_khr = context
        .get_device_extensions()
        .iter()
        .any(|e| e == "VK_KHR_descriptor_update_template");
    let handle = unsafe {
        if use_khr {
            device.create_descriptor_update_template_khr(&info, None)
        } else {
            device.create_descriptor_update_template(&info, None)
        }
    }
    .vk_check("vkCreateDescriptorUpdateTemplate")?;
    Ok(UpdateTemplate {
        device,
        handle,
        use_khr,
    })
}

/// `pushBufferDescriptor`
fn push_buffer_descriptor(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    bind_point: vk::PipelineBindPoint,
    layout: vk::PipelineLayout,
    buffer: vk::Buffer,
    size: vk::DeviceSize,
) {
    let buffer_info = [vk::DescriptorBufferInfo {
        buffer,
        offset: 0,
        range: size,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_binding(0)
        .dst_array_element(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&buffer_info)
        .build();
    unsafe { device.cmd_push_descriptor_set_khr(cmd_buffer, bind_point, layout, 0, &[write]) };
}

/// `verifyBufferContents`
fn verify_buffer_contents(
    device: &Device,
    buffer: &BufferWithMemory<'_>,
    buffer_name: &str,
    expected: u32,
) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    invalidate_alloc(device, alloc)?;
    let data = unsafe { alloc.get_host_ptr().cast::<u32>().read_unaligned() };

    if data != expected {
        return Err(TestError::Fail(format!(
            "Invalid value found in {buffer_name} buffer: expected {expected} and found {data}"
        )));
    }
    Ok(())
}

/// `recordBufferBarrier` over `makeBufferBarrier`
fn record_buffer_barrier(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    stage: vk::PipelineStageFlags,
    buffer: vk::Buffer,
    size: vk::DeviceSize,
) {
    let barrier = make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        buffer,
        0,
        size,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            stage,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

impl TestInstance for BindPointInstance<'_> {
    /// `BindPointInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let q_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();

        let image_format = vk::Format::R8G8B8A8_UNORM;
        let image_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;

        // Storage buffers.
        let buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let buffer_create_info = make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER);
        let graphics_buffer =
            BufferWithMemory::new(device, alloc, buffer_create_info, MemoryRequirement::HOST_VISIBLE)?;
        let compute_buffer = BufferWithMemory::new(device, alloc, buffer_create_info, MemoryRequirement::HOST_VISIBLE)?;
        zero_out_and_flush(device, &graphics_buffer, buffer_size)?;
        zero_out_and_flush(device, &compute_buffer, buffer_size)?;

        // Color attachment (1x1).
        let color_attachment = ImageWithBuffer::new(context, 1, 1, image_format, image_usage, 4)?;

        // Command buffer and pool.
        let cmd_pool = make_command_pool(device, q_index)?;
        let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;

        // Set and pipeline layouts.
        let graphics_set_layout = make_set_layout(
            device,
            vk::ShaderStageFlags::FRAGMENT,
            params.graphics_set_update_type != SetUpdateType::Write,
        )?;
        let compute_set_layout = make_set_layout(
            device,
            vk::ShaderStageFlags::COMPUTE,
            params.compute_set_update_type != SetUpdateType::Write,
        )?;
        let graphics_pipeline_layout = make_pipeline_layout(device, &[*graphics_set_layout])?;
        let compute_pipeline_layout = make_pipeline_layout(device, &[*compute_set_layout])?;

        // Shader modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;

        // Render pass and framebuffer.
        let render_pass = make_color_render_pass(
            device,
            image_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_attachment.view], 1, 1, 1)?;

        // Graphics pipeline: no vertex input, a full-screen clockwise triangle strip.
        let state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(1, 1);
        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[*graphics_set_layout], &[])?;
        let graphics_pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *graphics_pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?)
        };

        // Compute pipeline.
        let compute_stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*comp_module)
            .name(b"main\0")
            .build();
        let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(compute_stage)
            .layout(*compute_pipeline_layout)
            .base_pipeline_index(0)
            .build();
        let compute_pipelines =
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, compute_pipelines.0[0]);

        // Descriptor pools and sets if needed.
        let graphics_set = if params.graphics_set_update_type == SetUpdateType::Write {
            Some(make_written_set(
                device,
                *graphics_set_layout,
                graphics_buffer.get(),
                buffer_size,
            )?)
        } else {
            None
        };
        let compute_set = if params.compute_set_update_type == SetUpdateType::Write {
            Some(make_written_set(
                device,
                *compute_set_layout,
                compute_buffer.get(),
                buffer_size,
            )?)
        } else {
            None
        };

        // Templates if needed.
        let graphics_template = if params.graphics_set_update_type == SetUpdateType::PushWithTemplate {
            Some(make_update_template(
                context,
                *graphics_set_layout,
                vk::PipelineBindPoint::GRAPHICS,
                *graphics_pipeline_layout,
            )?)
        } else {
            None
        };
        let compute_template = if params.compute_set_update_type == SetUpdateType::PushWithTemplate {
            Some(make_update_template(
                context,
                *compute_set_layout,
                vk::PipelineBindPoint::COMPUTE,
                *compute_pipeline_layout,
            )?)
        } else {
            None
        };

        begin_command_buffer(device, cmd_buffer)?;

        // Setup operations in desired order.
        for setup_op in params.setup_sequence {
            match setup_op {
                SetupOp::BindGraphicsPipeline => match (&shader_objects, &graphics_pipeline) {
                    (Some(shader_objects), _) => shader_objects.bind(cmd_buffer, &state),
                    (None, Some(pipeline)) => unsafe {
                        device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, **pipeline);
                    },
                    (None, None) => {
                        return Err(TestError::InternalError("no graphics pipeline".to_string()));
                    }
                },
                SetupOp::BindComputePipeline => unsafe {
                    device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
                },
                SetupOp::BindGraphicsSet => match params.graphics_set_update_type {
                    SetUpdateType::Write => {
                        let (set, _) = graphics_set
                            .as_ref()
                            .ok_or_else(|| TestError::InternalError("graphics set missing".to_string()))?;
                        unsafe {
                            device.cmd_bind_descriptor_sets(
                                cmd_buffer,
                                vk::PipelineBindPoint::GRAPHICS,
                                *graphics_pipeline_layout,
                                0,
                                &[set.get()],
                                &[] as &[u32],
                            );
                        }
                    }
                    SetUpdateType::Push => push_buffer_descriptor(
                        device,
                        cmd_buffer,
                        vk::PipelineBindPoint::GRAPHICS,
                        *graphics_pipeline_layout,
                        graphics_buffer.get(),
                        buffer_size,
                    ),
                    SetUpdateType::PushWithTemplate => {
                        let template = graphics_template
                            .as_ref()
                            .ok_or_else(|| TestError::InternalError("graphics template missing".to_string()))?;
                        let buffer_info = vk::DescriptorBufferInfo {
                            buffer: graphics_buffer.get(),
                            offset: 0,
                            range: buffer_size,
                        };
                        unsafe {
                            KhrPushDescriptorExtensionDeviceCommands::cmd_push_descriptor_set_with_template_khr(
                                device,
                                cmd_buffer,
                                template.handle,
                                *graphics_pipeline_layout,
                                0,
                                std::ptr::from_ref(&buffer_info).cast::<c_void>(),
                            );
                        }
                    }
                },
                SetupOp::BindComputeSet => match params.compute_set_update_type {
                    SetUpdateType::Write => {
                        let (set, _) = compute_set
                            .as_ref()
                            .ok_or_else(|| TestError::InternalError("compute set missing".to_string()))?;
                        unsafe {
                            device.cmd_bind_descriptor_sets(
                                cmd_buffer,
                                vk::PipelineBindPoint::COMPUTE,
                                *compute_pipeline_layout,
                                0,
                                &[set.get()],
                                &[] as &[u32],
                            );
                        }
                    }
                    SetUpdateType::Push => push_buffer_descriptor(
                        device,
                        cmd_buffer,
                        vk::PipelineBindPoint::COMPUTE,
                        *compute_pipeline_layout,
                        compute_buffer.get(),
                        buffer_size,
                    ),
                    SetUpdateType::PushWithTemplate => {
                        let template = compute_template
                            .as_ref()
                            .ok_or_else(|| TestError::InternalError("compute template missing".to_string()))?;
                        let buffer_info = vk::DescriptorBufferInfo {
                            buffer: compute_buffer.get(),
                            offset: 0,
                            range: buffer_size,
                        };
                        unsafe {
                            KhrPushDescriptorExtensionDeviceCommands::cmd_push_descriptor_set_with_template_khr(
                                device,
                                cmd_buffer,
                                template.handle,
                                *compute_pipeline_layout,
                                0,
                                std::ptr::from_ref(&buffer_info).cast::<c_void>(),
                            );
                        }
                    }
                },
            }
        }

        // Dispatch operations in desired order.
        for dispatch_op in params.dispatch_sequence {
            match dispatch_op {
                DispatchOp::Draw => {
                    let clear_values = [clear_value_color([1.0, 0.0, 0.0, 1.0])];
                    begin_draw(
                        device,
                        cmd_buffer,
                        shader_objects.as_ref(),
                        &state,
                        None,
                        *render_pass,
                        *framebuffer,
                        rect_2d(1, 1),
                        &clear_values,
                        &[(color_attachment.image.get(), *color_attachment.view)],
                    );
                    unsafe { device.cmd_draw(cmd_buffer, 4, 1, 0, 0) };
                    end_draw(device, cmd_buffer, shader_objects.is_some());
                }
                DispatchOp::Compute => unsafe { device.cmd_dispatch(cmd_buffer, 1, 1, 1) },
            }
        }

        record_buffer_barrier(
            device,
            cmd_buffer,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            graphics_buffer.get(),
            buffer_size,
        );
        record_buffer_barrier(
            device,
            cmd_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            compute_buffer.get(),
            buffer_size,
        );

        // `readColorAttachment`, recorded in the same submission: the render pass leaves the image in TRANSFER_SRC_OPTIMAL.
        let color_to_transfer =
            make_memory_barrier(vk::AccessFlags::COLOR_ATTACHMENT_WRITE, vk::AccessFlags::TRANSFER_READ);
        // Dynamic rendering has no final layout: the image is still attachment optimal.
        let color_layout_barriers: Vec<vk::ImageMemoryBarrier> = if shader_objects.is_some() {
            vec![make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_attachment.image.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            )]
        } else {
            Vec::new()
        };
        let color_to_transfer_memory: Vec<vk::MemoryBarrier> = if shader_objects.is_some() {
            Vec::new()
        } else {
            vec![color_to_transfer]
        };
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: 1,
                height: 1,
                depth: 1,
            },
        };
        let transfer_to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &color_to_transfer_memory,
                &[] as &[vk::BufferMemoryBarrier],
                &color_layout_barriers,
            );
            device.cmd_copy_image_to_buffer(
                cmd_buffer,
                color_attachment.image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_attachment.buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[transfer_to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify storage buffers.
        verify_buffer_contents(device, &graphics_buffer, "graphics", EXPECTED_BUFFER_VALUE_GRAPHICS)?;
        verify_buffer_contents(device, &compute_buffer, "compute", EXPECTED_BUFFER_VALUE_COMPUTE)?;

        // Verify color attachment.
        let pixel = color_attachment.read_bytes(device)?;
        let expected_color = [0u8, 255, 0, 255];
        if pixel[..4] != expected_color {
            return Ok(TestStatus::fail(format!(
                "Unexpected color found in attachment: expected {:?} but found {:?}",
                expected_color,
                &pixel[..4]
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

fn update_type_name(update_type: SetUpdateType) -> &'static str {
    match update_type {
        SetUpdateType::Write => "write",
        SetUpdateType::Push => "push",
        SetUpdateType::PushWithTemplate => "template_push",
    }
}

fn setup_sequence_name(setup_sequence: &[SetupOp; 4]) -> String {
    let mut name = "setup".to_string();
    for op in setup_sequence {
        name.push('_');
        name.push_str(match op {
            SetupOp::BindGraphicsPipeline => "gp",
            SetupOp::BindComputePipeline => "cp",
            SetupOp::BindGraphicsSet => "gs",
            SetupOp::BindComputeSet => "cs",
        });
    }
    name
}

fn dispatch_sequence_name(dispatch_sequence: &[DispatchOp; 2]) -> String {
    let mut name = "cmd".to_string();
    for op in dispatch_sequence {
        name.push('_');
        name.push_str(match op {
            DispatchOp::Draw => "draw",
            DispatchOp::Compute => "dispatch",
        });
    }
    name
}

/// `std::next_permutation`
fn next_permutation<T: Ord>(items: &mut [T]) -> bool {
    if items.len() < 2 {
        return false;
    }
    let mut i = items.len() - 1;
    while i > 0 && items[i - 1] >= items[i] {
        i -= 1;
    }
    if i == 0 {
        items.reverse();
        return false;
    }
    let mut j = items.len() - 1;
    while items[j] <= items[i - 1] {
        j -= 1;
    }
    items.swap(i - 1, j);
    items[i..].reverse();
    true
}

/// `createBindPointTests`
pub fn create_bind_point_tests() -> TestCaseGroup {
    let mut bind_point_group = TestCaseGroup::new("bind_point");
    let mut pair_group = TestCaseGroup::new("graphics_compute");

    // Combine two update types.
    for first_update_type in ALL_UPDATE_TYPES {
        for second_update_type in ALL_UPDATE_TYPES {
            let update_group_name = format!(
                "{}_{}",
                update_type_name(first_update_type),
                update_type_name(second_update_type)
            );
            let mut update_group = TestCaseGroup::new(&update_group_name);

            let mut setup_sequence = [
                SetupOp::BindGraphicsPipeline,
                SetupOp::BindComputePipeline,
                SetupOp::BindGraphicsSet,
                SetupOp::BindComputeSet,
            ];

            // Permutate setup sequence and dispatch sequence.
            loop {
                let mut setup_group = TestCaseGroup::new(setup_sequence_name(&setup_sequence));

                let mut dispatch_sequence = [DispatchOp::Draw, DispatchOp::Compute];
                loop {
                    let params = TestParams {
                        graphics_set_update_type: first_update_type,
                        compute_set_update_type: second_update_type,
                        setup_sequence,
                        dispatch_sequence,
                    };
                    setup_group.add_child(Box::new(BindPointTest {
                        name: dispatch_sequence_name(&dispatch_sequence),
                        params,
                    }) as Box<dyn TestCase>);
                    if !next_permutation(&mut dispatch_sequence) {
                        break;
                    }
                }

                update_group.add_child(setup_group);

                if !next_permutation(&mut setup_sequence) {
                    break;
                }
            }

            pair_group.add_child(update_group);
        }
    }

    bind_point_group.add_child(pair_group);
    bind_point_group
}
