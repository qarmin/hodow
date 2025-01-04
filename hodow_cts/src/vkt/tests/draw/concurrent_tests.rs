// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawConcurrentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream builds a private instance and a device with one
// compute queue for the payload; here that is the context's `MultiQueueDevice`, which is a second device on
// the same physical device and so is just as independent of the draw device.
//
// A compute dispatch (invert 1024 words) on a compute queue and a draw on the universal queue are submitted
// back to back and both are waited for before either result is checked.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::draw_concurrent::CONCURRENT;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{DrawTestsBase, GroupParams, ReferenceImageCoordinates, VertexElementData};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

struct ConcurrentDrawCase {
    group_params: GroupParams,
}

impl TestCase for ConcurrentDrawCase {
    fn name(&self) -> &str {
        "compute_and_triangle_list"
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.group_params.use_dynamic_rendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        CONCURRENT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConcurrentDraw {
            context,
            group_params: self.group_params,
        })
    }
}

/// `ConcurrentDraw`
struct ConcurrentDraw<'a> {
    context: &'a Context<'a>,
    group_params: GroupParams,
}

/// `ConcurrentDraw::ConcurrentDraw`'s vertex data.
fn build_vertex_data() -> Vec<VertexElementData> {
    let blue = [0.0f32, 0.0, 1.0, 1.0];
    let mut data = vec![
        VertexElementData::new([1.0, -1.0, 1.0, 1.0], blue, -1i32 as u32),
        VertexElementData::new([-1.0, 1.0, 1.0, 1.0], blue, -1i32 as u32),
    ];

    let mut ref_vertex_index = 2u32;

    for _ in 0..1000 {
        for (x, y) in [
            (-0.3, -0.3),
            (-0.3, 0.3),
            (0.3, -0.3),
            (0.3, -0.3),
            (0.3, 0.3),
            (-0.3, 0.3),
        ] {
            data.push(VertexElementData::new([x, y, 1.0, 1.0], blue, ref_vertex_index));
            ref_vertex_index += 1;
        }
    }
    data.push(VertexElementData::new([-1.0, 1.0, 1.0, 1.0], blue, -1i32 as u32));
    data
}

impl TestInstance for ConcurrentDraw<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let num_values = 1024u32;

        let base = DrawTestsBase::new_default(
            context,
            "vert",
            "frag",
            self.group_params,
            vk::PrimitiveTopology::TRIANGLE_LIST,
            build_vertex_data(),
        )?;

        // Set up compute
        let multi_queue = context.multi_queue_device()?;
        let compute_device = multi_queue.device();
        let compute_family = multi_queue
            .families()
            .iter()
            .find(|family| family.flags.contains(vk::QueueFlags::COMPUTE))
            .ok_or_else(|| TestError::NotSupported("Compute queue couldn't be created".to_string()))?;
        let compute_queue = compute_family.queues[0];

        // Create an input/output buffer
        let buffer_size_bytes = (std::mem::size_of::<u32>() as u32 * num_values) as vk::DeviceSize;
        let buffer = BufferWithMemory::new(
            compute_device,
            multi_queue.allocator(),
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill the buffer with data
        let mut input_data = vec![0u32; num_values as usize];
        {
            let mut rnd = Random::new(0x82ce7f);
            let buffer_ptr = buffer.get_allocation().get_host_ptr().cast::<u32>();

            for (i, input) in input_data.iter_mut().enumerate() {
                let val = rnd.get_uint32();
                *input = val;
                unsafe { buffer_ptr.add(i).write_unaligned(val) };
            }

            flush_alloc(compute_device, buffer.get_allocation())?;
        }

        // Create descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(compute_device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(compute_device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(compute_device, *descriptor_pool, *descriptor_set_layout)?;

        let buffer_descriptor_info = vk::DescriptorBufferInfo {
            buffer: buffer.get(),
            offset: 0,
            range: buffer_size_bytes,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &buffer_descriptor_info,
            )
            .update(compute_device);

        // Perform the computation
        let binaries = context.get_binary_collection();
        let shader_module = create_shader_module(compute_device, binaries.get("comp")?)?;

        let pipeline_layout = make_pipeline_layout(compute_device, &[*descriptor_set_layout])?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*shader_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(-1)
            .build();
        let pipelines =
            unsafe { compute_device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let pipeline = Unique::new(compute_device, pipelines.0[0]);

        let host_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::SHADER_READ,
            buffer.get(),
            0,
            buffer_size_bytes,
        );
        let shader_write_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            buffer.get(),
            0,
            buffer_size_bytes,
        );
        let cmd_pool = make_command_pool(compute_device, compute_family.family_index)?;
        let compute_command_buffer =
            allocate_command_buffer(compute_device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Compute command buffer
        begin_command_buffer(compute_device, *compute_command_buffer)?;
        unsafe {
            compute_device.cmd_bind_pipeline(*compute_command_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
            compute_device.cmd_bind_descriptor_sets(
                *compute_command_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            compute_device.cmd_pipeline_barrier(
                *compute_command_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[host_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            compute_device.cmd_dispatch(*compute_command_buffer, 1, 1, 1);
            compute_device.cmd_pipeline_barrier(
                *compute_command_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[shader_write_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(compute_device, *compute_command_buffer)?;

        let compute_command_buffers = [*compute_command_buffer];
        let submit_info = vk::SubmitInfo::builder()
            .command_buffers(&compute_command_buffers)
            .build();

        // Set up draw
        let draw_queue = context.get_universal_queue();
        let draw_device = context.get_device();
        let size = 6;
        base.record_commands(
            |cmd_buffer| {
                unsafe { draw_device.cmd_draw(cmd_buffer, size, 1, 2, 0) };
                Ok(())
            },
            |_| {},
        )?;

        let draw_command_buffers = [*base.cmd_buffer];
        let draw_submit_info = vk::SubmitInfo::builder().command_buffers(&draw_command_buffers).build();

        let draw_fence = Unique::new(
            draw_device,
            unsafe { draw_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
        );
        let compute_fence = Unique::new(
            compute_device,
            unsafe { compute_device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
        );

        // Submit both compute and draw queues
        unsafe { compute_device.queue_submit(compute_queue, &[submit_info], *compute_fence) }
            .vk_check("vkQueueSubmit")?;
        unsafe { draw_device.queue_submit(draw_queue, &[draw_submit_info], *draw_fence) }.vk_check("vkQueueSubmit")?;

        // Have to wait for all fences before calling fail, or some fence may be left hanging.
        let compute_wait = unsafe { compute_device.wait_for_fences(&[*compute_fence], true, u64::MAX) };
        let draw_wait = unsafe { draw_device.wait_for_fences(&[*draw_fence], true, u64::MAX) };

        if !matches!(compute_wait, Ok(vk::SuccessCode::SUCCESS)) {
            return Ok(TestStatus::fail("Failed waiting for compute queue fence."));
        }

        if !matches!(draw_wait, Ok(vk::SuccessCode::SUCCESS)) {
            return Ok(TestStatus::fail("Failed waiting for draw queue fence."));
        }

        // Validation - compute
        invalidate_alloc(compute_device, buffer.get_allocation())?;
        let buffer_ptr = buffer.get_allocation().get_host_ptr().cast::<u32>();

        for (ndx, &inp) in input_data.iter().enumerate() {
            let res = unsafe { buffer_ptr.add(ndx).read_unaligned() };
            let reference = !inp;

            if res != reference {
                return Ok(TestStatus::fail(format!(
                    "Comparison failed (compute) for InOut.values[{ndx}] ref:{reference} res:{res} inp:{inp}"
                )));
            }
        }

        // Validation - draw
        let coords = ReferenceImageCoordinates::default();
        let reference_frame = base.make_rect_reference(
            [0.0, 0.0, 0.0, 1.0],
            [0.0, 0.0, 1.0, 1.0],
            coords.left,
            coords.right,
            coords.top,
            coords.bottom,
        )?;
        base.compare_with_target(draw_queue, &reference_frame)
    }
}

/// `ConcurrentDrawTests::init`
pub fn create_concurrent_draw_tests(group_params: GroupParams) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("concurrent");
    group.add_child(Box::new(ConcurrentDrawCase { group_params }) as Box<dyn TestCase>);
    group
}
