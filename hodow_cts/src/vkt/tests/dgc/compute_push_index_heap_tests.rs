// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCComputePushIndexHeapTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The program is in `shaders/manifest/dgc_push_index_heap.toml`
// (`scripts/gen_dgc_push_index_heap_manifest.py`).
//
// Here: `push_index_heap.stage_compute` of `dgc.ext.compute`: DGC push data selects the descriptor heap slot (a storage buffer per
// sequence) through VK_DESCRIPTOR_MAPPING_SOURCE_HEAP_WITH_PUSH_INDEX_EXT.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtDescriptorHeapExtensionDeviceCommands, ExtDeviceGeneratedCommandsExtensionDeviceCommands, InstanceV1_1,
};

use crate::generated::shaders::dgc_push_index_heap::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::device_address_commands::buffer_device_address;
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcComputeSupportType, DgcGenCmdsInfo, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_compute_support,
};
use crate::vkt::tests::robustness::robustness_util::HostBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

/// One heap slot (and one backing storage buffer) per sequence.
const NUM_SLOTS: u32 = 16;

/// Value the shader adds to the pre-filled slot content; large enough that the marked value (slot index + marker) is unambiguous for
/// every slot.
const MARKER: u32 = 1 << 20;

fn align_up(value: u64, alignment: u64) -> u64 {
    value.div_ceil(alignment.max(1)) * alignment.max(1)
}

struct PushIndexHeapCase {
    name: String,
    push_stage: vk::ShaderStageFlags,
}

impl TestCase for PushIndexHeapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_dgc_ext_compute_support(context, DgcComputeSupportType::Basic)?;
        context.require_device_functionality("VK_EXT_descriptor_heap")
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "push_index_heap")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PushIndexHeapInstance {
            context,
            push_stage: self.push_stage,
        })
    }
}

struct PushIndexHeapInstance<'a> {
    context: &'a Context<'a>,
    push_stage: vk::ShaderStageFlags,
}

impl TestInstance for PushIndexHeapInstance<'_> {
    /// `PushIndexHeapInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let shader_stage = vk::ShaderStageFlags::COMPUTE;

        // One backing storage buffer per heap slot, slot i pre-filled with value i.
        let buffer_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        let mut output_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
        for i in 0..NUM_SLOTS {
            let buffer = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(
                    buffer_size,
                    vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS,
                ),
                MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
            )?;
            {
                let alloc = buffer.get_allocation();
                // SAFETY: the buffer holds one u32.
                unsafe { alloc.get_host_ptr().cast::<u32>().write_unaligned(i) };
                flush_alloc(device, alloc)?;
            }
            output_buffers.push(buffer);
        }

        // Resource heap holding one storage-buffer descriptor per slot.
        let mut heap_props = vk::PhysicalDeviceDescriptorHeapPropertiesEXT::default();
        {
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut heap_props);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };
        }
        let descriptor_stride = align_up(
            heap_props.buffer_descriptor_size,
            heap_props.buffer_descriptor_alignment,
        );
        let user_heap_size = align_up(
            descriptor_stride * u64::from(NUM_SLOTS),
            heap_props.resource_heap_alignment,
        );
        let resource_heap_size = user_heap_size + heap_props.min_resource_heap_reserved_range;

        let resource_heap = HostBuffer::new_resource_heap(device, context, resource_heap_size)?;
        let bind_heap_info = vk::BindHeapInfoEXT {
            heap_range: vk::DeviceAddressRangeEXT {
                address: resource_heap.device_address(device),
                size: resource_heap_size,
            },
            reserved_range_offset: user_heap_size,
            reserved_range_size: heap_props.min_resource_heap_reserved_range,
            ..Default::default()
        };

        // Write one storage-buffer descriptor per slot, slot i pointing at buffer i.
        let heap_host_ptr = resource_heap.buffer.get_allocation().get_host_ptr();
        for (i, buffer) in output_buffers.iter().enumerate() {
            let address_range = vk::DeviceAddressRangeEXT {
                address: buffer_device_address(device, buffer.get()),
                size: buffer_size,
            };
            let descriptor_host_range = vk::HostAddressRangeEXT {
                // SAFETY: slot i lies inside the user part of the heap.
                address: unsafe { heap_host_ptr.add(i * descriptor_stride as usize) }.cast(),
                size: heap_props.buffer_descriptor_size as usize,
            };
            let resource_descriptor_info = vk::ResourceDescriptorInfoEXT {
                type_: vk::DescriptorType::STORAGE_BUFFER,
                data: vk::ResourceDescriptorDataEXT {
                    address_range: &address_range,
                },
                ..Default::default()
            };
            unsafe { device.write_resource_descriptors_ext(&[resource_descriptor_info], &[descriptor_host_range]) }
                .vk_check("vkWriteResourceDescriptorsEXT")?;
        }
        resource_heap.flush(device)?;

        // Map set 0, binding 0 to a heap slot selected by the pushed index.
        let mapping = vk::DescriptorSetAndBindingMappingEXT {
            binding_count: 1,
            resource_mask: vk::SpirvResourceTypeFlagsEXT::ALL,
            source: vk::DescriptorMappingSourceEXT::HEAP_WITH_PUSH_INDEX,
            source_data: vk::DescriptorMappingSourceDataEXT {
                push_index: vk::DescriptorMappingSourcePushIndexEXT {
                    heap_index_stride: descriptor_stride as u32,
                    heap_array_stride: descriptor_stride as u32,
                    ..Default::default()
                },
            },
            ..Default::default()
        };
        let mapping_info = vk::ShaderDescriptorSetAndBindingMappingInfoEXT {
            mapping_count: 1,
            mappings: &mapping,
            ..Default::default()
        };

        // Compute pipeline created directly for the descriptor heap (no pipeline layout).
        let binaries = context.get_binary_collection();
        let comp_module = create_shader_module(device, binaries.get("comp")?)?;
        let flags2 = vk::PipelineCreateFlags2CreateInfo {
            flags: vk::PipelineCreateFlags2::DESCRIPTOR_HEAP_EXT,
            ..Default::default()
        };
        let mut stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*comp_module)
            .name(b"main\0")
            .build();
        stage.next = (&mapping_info as *const vk::ShaderDescriptorSetAndBindingMappingInfoEXT).cast();
        let mut pipeline_create_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(vk::PipelineLayout::null())
            .base_pipeline_index(-1)
            .build();
        pipeline_create_info.next = (&flags2 as *const vk::PipelineCreateFlags2CreateInfo).cast();
        let pipeline = {
            let pipelines =
                unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_create_info], None) }
                    .vk_check("vkCreateComputePipelines")?;
            Unique::new(device, pipelines.0[0])
        };

        // Indirect commands layout: PUSH_DATA token (the index) followed by DISPATCH. The push range offset must match the mapping's
        // pushOffset.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            shader_stage,
            vk::PipelineLayout::null(),
        );
        cmds_layout_builder.add_push_data_token(
            0,
            vk::PushConstantRange {
                stage_flags: self.push_stage,
                offset: 0,
                size: std::mem::size_of::<u32>() as u32,
            },
        );
        let dispatch_token_offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_dispatch_token(dispatch_token_offset);
        let cmds_layout = cmds_layout_builder.build(device)?;
        let stride = cmds_layout_builder.get_stream_stride() as usize;

        // Command stream: sequence i pushes index i and dispatches a single work group.
        let mut cmd_data = vec![0u8; NUM_SLOTS as usize * stride];
        for i in 0..NUM_SLOTS {
            let base = i as usize * stride;
            let dispatch = [1u32, 1, 1];
            cmd_data[base..base + 4].copy_from_slice(&i.to_ne_bytes());
            for (word, value) in dispatch.iter().enumerate() {
                let offset = base + dispatch_token_offset as usize + word * 4;
                cmd_data[offset..offset + 4].copy_from_slice(&value.to_ne_bytes());
            }
        }
        let cmd_data_size = cmd_data.len() as vk::DeviceSize;
        let indirect_buffer = DgcBuffer::new(
            context,
            cmd_data_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = indirect_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe { std::ptr::copy_nonoverlapping(cmd_data.as_ptr(), alloc.get_host_ptr(), cmd_data.len()) };
            flush_alloc(device, alloc)?;
        }

        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            NUM_SLOTS,
            0,
            *pipeline,
            0,
        )?;
        let generated_commands_info = DgcGenCmdsInfo::new(
            shader_stage,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            indirect_buffer.get_device_address(),
            cmd_data_size,
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            NUM_SLOTS,
            0,
            0,
            *pipeline,
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_resource_heap_ext(cmd_buffer, &bind_heap_info);
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_execute_generated_commands_ext(cmd_buffer, false, generated_commands_info.get());
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Slot i must have been selected by the sequence that pushed index i, so its backing buffer holds (i + MARKER). Any missed or
        // misdirected selection leaves some buffer at its pre-filled value.
        for (i, buffer) in output_buffers.iter().enumerate() {
            let alloc = buffer.get_allocation();
            invalidate_alloc(device, alloc)?;
            // SAFETY: the buffer holds one u32.
            let result = unsafe { alloc.get_host_ptr().cast::<u32>().read_unaligned() };
            let expected = i as u32 + MARKER;
            if result != expected {
                return Ok(TestStatus::fail(format!(
                    "Slot {i}: expected {expected} but got {result}"
                )));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `push_index_heap` cases, by their full dotted path in `dgc`.
pub fn create_dgc_compute_push_index_heap_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    vec![(
        "ext.compute.push_index_heap.stage_compute".to_string(),
        Box::new(PushIndexHeapCase {
            name: "stage_compute".to_string(),
            push_stage: vk::ShaderStageFlags::COMPUTE,
        }) as Box<dyn TestCase>,
    )]
}
