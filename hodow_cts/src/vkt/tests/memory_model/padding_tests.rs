// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory_model/vktMemoryModelPadding.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Copyright (c) 2019 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::memory_model_padding::PADDING;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

// The structures below match the shader declarations but have explicit padding members at the end so we can check their contents
// easily after running the shader. Using the std140 layout means structures are aligned to 16 bytes.

/// Structure with a 12-byte padding at the end.
#[repr(C)]
#[derive(Clone, Copy)]
struct Pad12 {
    a: i32,
    padding: [u8; 12],
}

/// Structure with an 8-byte padding at the end.
#[repr(C)]
#[derive(Clone, Copy)]
struct Pad8 {
    a: i32,
    b: i32,
    padding: [u8; 8],
}

/// Structure with a 4-byte padding at the end.
#[repr(C)]
#[derive(Clone, Copy)]
struct Pad4 {
    a: i32,
    b: i32,
    c: i32,
    padding: [u8; 4],
}

const ARRAY_LENGTH: usize = 3;

/// Buffer structure for the input and output buffers.
#[repr(C)]
#[derive(Clone, Copy)]
struct BufferStructure {
    sub_a: [Pad12; ARRAY_LENGTH],
    sub_b: [Pad8; ARRAY_LENGTH],
    sub_c: [Pad4; ARRAY_LENGTH],
}

impl BufferStructure {
    /// Pre-fill substructures with the given data.
    fn new(a: i32, b: i32, c: i32, padding_byte: u8) -> Self {
        Self {
            sub_a: [Pad12 {
                a,
                padding: [padding_byte; 12],
            }; ARRAY_LENGTH],
            sub_b: [Pad8 {
                a,
                b,
                padding: [padding_byte; 8],
            }; ARRAY_LENGTH],
            sub_c: [Pad4 {
                a,
                b,
                c,
                padding: [padding_byte; 4],
            }; ARRAY_LENGTH],
        }
    }

    /// Pre-fill substructures with zeros.
    fn zeroed(padding_byte: u8) -> Self {
        Self::new(0, 0, 0, padding_byte)
    }

    /// Verify members and padding bytes.
    fn check_values(&self, a: i32, b: i32, c: i32, padding_byte: u8) -> bool {
        for i in 0..ARRAY_LENGTH {
            if self.sub_a[i].a != a
                || self.sub_b[i].a != a
                || self.sub_c[i].a != a
                || self.sub_b[i].b != b
                || self.sub_c[i].b != b
                || self.sub_c[i].c != c
            {
                return false;
            }
        }
        self.check_padding_bytes(padding_byte)
    }

    /// Verify padding bytes have a known value.
    fn check_padding_bytes(&self, value: u8) -> bool {
        for j in 0..ARRAY_LENGTH {
            if self.sub_a[j].padding.iter().any(|&p| p != value)
                || self.sub_b[j].padding.iter().any(|&p| p != value)
                || self.sub_c[j].padding.iter().any(|&p| p != value)
            {
                return false;
            }
        }
        true
    }
}

struct PaddingTest {
    name: &'static str,
}

impl TestCase for PaddingTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_vulkan_memory_model")?;

        let mut features12 = vk::PhysicalDeviceVulkan12Features::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features12);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if features12.vulkan_memory_model == vk::FALSE {
            return Err(TestError::NotSupported("Vulkan memory model not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        PADDING.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PaddingTestInstance { context })
    }
}

struct PaddingTestInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for PaddingTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let vkd = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let queue_index = context.get_universal_queue_family_index();

        let buffer_size = std::mem::size_of::<BufferStructure>() as vk::DeviceSize;
        const A: i32 = 1;
        const B: i32 = 2;
        const C: i32 = 3;
        const INPUT_PADDING_BYTE: u8 = 0xFE;
        const OUTPUT_PADDING_BYTE: u8 = 0x7F;

        // Create input and output buffers.
        let input_buffer = BufferWithMemory::new(
            vkd,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let output_buffer = BufferWithMemory::new(
            vkd,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Fill buffers with initial contents.
        let input_values = BufferStructure::new(A, B, C, INPUT_PADDING_BYTE);
        let output_init = BufferStructure::zeroed(OUTPUT_PADDING_BYTE);

        let input_alloc = input_buffer.get_allocation();
        let output_alloc = output_buffer.get_allocation();

        unsafe {
            input_alloc
                .get_host_ptr()
                .cast::<BufferStructure>()
                .write_unaligned(input_values);
            output_alloc
                .get_host_ptr()
                .cast::<BufferStructure>()
                .write_unaligned(output_init);
        }

        flush_alloc(vkd, input_alloc)?;
        flush_alloc(vkd, output_alloc)?;

        // Descriptor set layout.
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vkd)?;

        // Descriptor pool.
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(vkd, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        // Descriptor set.
        let descriptor_set = make_descriptor_set(vkd, *descriptor_pool, *descriptor_set_layout)?;

        // Update descriptor set using the buffers.
        let input_buffer_descriptor_info = make_descriptor_buffer_info(input_buffer.get(), 0, vk::WHOLE_SIZE);
        let output_buffer_descriptor_info = make_descriptor_buffer_info(output_buffer.get(), 0, vk::WHOLE_SIZE);

        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::UNIFORM_BUFFER,
                &input_buffer_descriptor_info,
            )
            .write_single(
                *descriptor_set,
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &output_buffer_descriptor_info,
            )
            .update(vkd);

        // Create compute pipeline.
        let mut pipeline = ComputePipelineWrapper::new(
            vkd,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        // Synchronization barriers.
        let input_buffer_host_to_dev_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::SHADER_READ,
            input_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        let output_buffer_host_to_dev_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::HOST_WRITE,
            vk::AccessFlags::SHADER_WRITE,
            output_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        let output_buffer_dev_to_host_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );

        // Command buffer.
        let cmd_pool = make_command_pool(vkd, queue_index)?;
        let cmd_buffer_ptr = allocate_command_buffer(vkd, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;

        // Record and submit commands.
        begin_command_buffer(vkd, cmd_buffer)?;
        pipeline.bind(cmd_buffer);
        unsafe {
            vkd.cmd_bind_descriptor_sets(
                cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                pipeline.get_pipeline_layout(),
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            vkd.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[input_buffer_host_to_dev_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vkd.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[output_buffer_host_to_dev_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
            vkd.cmd_dispatch(cmd_buffer, ARRAY_LENGTH as u32, 1, 1);
            vkd.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[output_buffer_dev_to_host_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vkd, cmd_buffer)?;
        submit_commands_and_wait(vkd, queue, cmd_buffer)?;

        // Verify output buffer contents.
        invalidate_alloc(vkd, output_alloc)?;
        let output_data = unsafe { output_alloc.get_host_ptr().cast::<BufferStructure>().read_unaligned() };
        if output_data.check_values(A, B, C, OUTPUT_PADDING_BYTE) {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Unexpected values in output data"))
        }
    }
}

/// `createPaddingTests`
pub fn create_padding_tests() -> TestCaseGroup {
    let mut padding_group = TestCaseGroup::new("padding");
    // Check padding bytes at the end of structures are not touched on copy
    padding_group.add_child(Box::new(PaddingTest { name: "test" }) as Box<dyn TestCase>);
    padding_group
}
