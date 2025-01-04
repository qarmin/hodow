// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory/vktMemoryExternalDmaHeapTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are `shaders/manifest/memory_dma_heap.toml`; the allocator is `SimpleAllocator::dma_heap` (Linux only,
// elsewhere every case ends in the NotSupported upstream raises on a target without /dev/dma_heap).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::memory_dma_heap::DMA_HEAP_PROGRAMS;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::{
    MemoryRequirement, OffsetParams, SimpleAllocator, dma_heap_available, flush_alloc, invalidate_alloc,
};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `checkDmaHeapMemory`
fn check_dma_heap_memory(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_external_memory_dma_buf")?;

    let vki = context.get_instance();
    let physical_device = context.get_physical_device();

    let info = vk::PhysicalDeviceExternalBufferInfo {
        s_type: vk::StructureType::PHYSICAL_DEVICE_EXTERNAL_BUFFER_INFO,
        next: std::ptr::null(),
        flags: vk::BufferCreateFlags::empty(),
        usage: vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
        handle_type: vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
    };
    let mut properties = vk::ExternalBufferProperties::default();
    unsafe { vki.get_physical_device_external_buffer_properties(physical_device, &info, &mut properties) };

    let features = properties.external_memory_properties.external_memory_features;
    if !features.contains(vk::ExternalMemoryFeatureFlags::IMPORTABLE) {
        return Err(TestError::NotSupported(
            "DMA_BUF imported buffer is not supported".to_string(),
        ));
    }
    if features.contains(vk::ExternalMemoryFeatureFlags::DEDICATED_ONLY) {
        return Err(TestError::NotSupported(
            "DMA_BUF imported buffer requires dedicated allocation".to_string(),
        ));
    }

    if !dma_heap_available() {
        return Err(TestError::NotSupported(
            "Target does not support DMA heap allocator".to_string(),
        ));
    }
    Ok(())
}

#[derive(Clone, Copy)]
enum Body {
    AllocateAndBind,
    ShaderAccess { offset: vk::DeviceSize },
}

struct DmaHeapCase {
    name: &'static str,
    body: Body,
}

impl TestCase for DmaHeapCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_dma_heap_memory(context)
    }

    fn programs(&self) -> BinaryCollection {
        match self.body {
            Body::AllocateAndBind => BinaryCollection::new(&[]),
            Body::ShaderAccess { .. } => DMA_HEAP_PROGRAMS.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DmaHeapInstance {
            context,
            body: self.body,
        })
    }
}

struct DmaHeapInstance<'a> {
    context: &'a Context<'a>,
    body: Body,
}

fn dma_buf_buffer_info(
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
    external: &vk::ExternalMemoryBufferCreateInfo,
) -> vk::BufferCreateInfo {
    let mut info = make_buffer_create_info(size, usage);
    info.next = (external as *const vk::ExternalMemoryBufferCreateInfo).cast();
    info
}

/// `testDmaHeapMemoryAllocateAndBind`
fn allocate_and_bind(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let memory_properties = *context.get_default_allocator().memory_properties();
    let dma_heap_allocator = SimpleAllocator::dma_heap(memory_properties, None);

    let external = vk::ExternalMemoryBufferCreateInfo {
        handle_types: vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
        ..Default::default()
    };
    let _dma_heap_memory_buffer = BufferWithMemory::new(
        device,
        &dma_heap_allocator,
        dma_buf_buffer_info(8192, vk::BufferUsageFlags::STORAGE_BUFFER, &external),
        MemoryRequirement::ANY,
    )?;

    Ok(TestStatus::pass("Pass"))
}

/// `testDmaHeapMemoryShaderAccess`
fn shader_access(context: &Context<'_>, offset: vk::DeviceSize) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let allocator = context.get_default_allocator();
    let memory_properties = *allocator.memory_properties();

    let offset_params = (offset != 0).then(|| OffsetParams {
        non_coherent_atom_size: context.get_device_properties().limits.non_coherent_atom_size,
        offset,
    });
    let dma_heap_allocator = SimpleAllocator::dma_heap(memory_properties, offset_params);

    const BUFFER_ELEMENT_COUNT: u32 = 1024;
    const BUFFER_SIZE: vk::DeviceSize = BUFFER_ELEMENT_COUNT as vk::DeviceSize * 4;

    let host_visible_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            BUFFER_SIZE,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let external = vk::ExternalMemoryBufferCreateInfo {
        handle_types: vk::ExternalMemoryHandleTypeFlags::DMA_BUF_EXT,
        ..Default::default()
    };
    let dma_heap_memory_buffer = BufferWithMemory::new(
        device,
        &dma_heap_allocator,
        dma_buf_buffer_info(
            BUFFER_SIZE,
            vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
            &external,
        ),
        MemoryRequirement::ANY,
    )?;

    let input_pattern = vec![42u32; BUFFER_ELEMENT_COUNT as usize];
    unsafe {
        std::ptr::copy_nonoverlapping(
            input_pattern.as_ptr().cast::<u8>(),
            host_visible_buffer.get_allocation().get_host_ptr(),
            BUFFER_SIZE as usize,
        );
    }
    flush_alloc(device, host_visible_buffer.get_allocation())?;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    let input_buffer_descriptor_info = make_descriptor_buffer_info(host_visible_buffer.get(), 0, BUFFER_SIZE);
    let output_buffer_descriptor_info = make_descriptor_buffer_info(dma_heap_memory_buffer.get(), 0, BUFFER_SIZE);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            *descriptor_set,
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &input_buffer_descriptor_info,
        )
        .write_single(
            *descriptor_set,
            Location::binding(1),
            vk::DescriptorType::STORAGE_BUFFER,
            &output_buffer_descriptor_info,
        )
        .update(device);

    let mut pipeline_write = ComputePipelineWrapper::new(
        device,
        ComputePipelineConstructionType::Pipeline,
        context.get_binary_collection().get("dma_heap_memory_write")?,
    );
    pipeline_write.set_descriptor_set_layout(*descriptor_set_layout);
    pipeline_write.build_pipeline()?;
    let mut pipeline_read = ComputePipelineWrapper::new(
        device,
        ComputePipelineConstructionType::Pipeline,
        context.get_binary_collection().get("dma_heap_memory_read")?,
    );
    pipeline_read.set_descriptor_set_layout(*descriptor_set_layout);
    pipeline_read.build_pipeline()?;

    let cmd_pool = make_command_pool(device, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let barrier = |cmd: vk::CommandBuffer,
                   src_access: vk::AccessFlags,
                   dst_access: vk::AccessFlags,
                   buffer: vk::Buffer,
                   src_stage: vk::PipelineStageFlags,
                   dst_stage: vk::PipelineStageFlags| {
        let barrier = make_buffer_memory_barrier(src_access, dst_access, buffer, 0, vk::WHOLE_SIZE);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };
    };

    let cmd = *cmd_buffer;
    begin_command_buffer(device, cmd)?;

    // Clear DMA heap memory buffer to known value before writing to it
    unsafe { device.cmd_fill_buffer(cmd, dma_heap_memory_buffer.get(), 0, vk::WHOLE_SIZE, 24) };
    barrier(
        cmd,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::SHADER_WRITE,
        dma_heap_memory_buffer.get(),
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::COMPUTE_SHADER,
    );

    // Copy host visible buffer -> DMA heap memory buffer with compute shader
    pipeline_write.bind(cmd);
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::COMPUTE,
            pipeline_write.get_pipeline_layout(),
            0,
            &[*descriptor_set],
            &[],
        );
        device.cmd_dispatch(cmd, BUFFER_ELEMENT_COUNT, 1, 1);
    }

    barrier(
        cmd,
        vk::AccessFlags::SHADER_READ,
        vk::AccessFlags::TRANSFER_WRITE,
        host_visible_buffer.get(),
        vk::PipelineStageFlags::COMPUTE_SHADER,
        vk::PipelineStageFlags::TRANSFER,
    );

    // Clear host visible buffer to known value before writing to it
    unsafe { device.cmd_fill_buffer(cmd, host_visible_buffer.get(), 0, vk::WHOLE_SIZE, 12) };
    barrier(
        cmd,
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::SHADER_WRITE,
        host_visible_buffer.get(),
        vk::PipelineStageFlags::TRANSFER,
        vk::PipelineStageFlags::COMPUTE_SHADER,
    );

    // Copy DMA heap memory buffer -> host visible buffer with compute shader
    pipeline_read.bind(cmd);
    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::COMPUTE,
            pipeline_read.get_pipeline_layout(),
            0,
            &[*descriptor_set],
            &[],
        );
        device.cmd_dispatch(cmd, BUFFER_ELEMENT_COUNT, 1, 1);
    }

    barrier(
        cmd,
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        host_visible_buffer.get(),
        vk::PipelineStageFlags::COMPUTE_SHADER,
        vk::PipelineStageFlags::HOST,
    );

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;
    invalidate_alloc(device, host_visible_buffer.get_allocation())?;

    let mut output_pattern = vec![0u32; BUFFER_ELEMENT_COUNT as usize];
    unsafe {
        std::ptr::copy_nonoverlapping(
            host_visible_buffer.get_allocation().get_host_ptr(),
            output_pattern.as_mut_ptr().cast::<u8>(),
            BUFFER_SIZE as usize,
        );
    }

    for (index, (input, output)) in input_pattern.iter().zip(&output_pattern).enumerate() {
        if input != output {
            return Ok(TestStatus::fail(format!(
                "Comparison failed at index {index}: input = {input}, output = {output}"
            )));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

impl TestInstance for DmaHeapInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.body {
            Body::AllocateAndBind => allocate_and_bind(self.context),
            Body::ShaderAccess { offset } => shader_access(self.context, offset),
        }
    }
}

/// `createDmaHeapTests`
pub fn create_dma_heap_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("dma_heap_memory");
    group.add_child(Box::new(DmaHeapCase {
        name: "allocate_and_bind",
        body: Body::AllocateAndBind,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(DmaHeapCase {
        name: "shader_access",
        body: Body::ShaderAccess { offset: 0 },
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(DmaHeapCase {
        name: "shader_access_offset",
        body: Body::ShaderAccess { offset: 20000 },
    }) as Box<dyn TestCase>);
    group
}
