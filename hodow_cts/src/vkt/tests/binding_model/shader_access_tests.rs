// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/binding_model/vktBindingShaderAccessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The test asks a shader which descriptor it actually reached. Four workgroups, one
// per "quadrant", each read one of the two colours in their descriptor and write it to
// a result buffer; the host knows which colour every descriptor was filled with, so a
// binding that resolved to the wrong resource shows up as the wrong colour rather than
// as a crash. The result buffer starts as -1 in every component, which distinguishes
// "wrote the wrong thing" from "never ran".
//
// Ported so far: the compute half of the buffer descriptor types.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{self, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set, make_pipeline_layout};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// The manifest declares its cases with this: the compute shader plus the three things
/// the generator built it for, so the host can assert it picked the right one.
pub struct BufferAccessProgram {
    pub name: &'static str,
    pub storage_type: &'static str,
    pub set_count: &'static str,
    pub shader_interface: &'static str,
    pub programs: BinaryCollection,
}

/// Every entry the shader generator emitted, so the lookup searches what exists
/// rather than a second list that has to be kept in step with it.
static ALL_BUFFER_ACCESS_PROGRAMS: &[&BufferAccessProgram] = &[
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_SINGLE_SINGLE_DESCRIPTOR,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_SINGLE_MULTIPLE_CONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_SINGLE_MULTIPLE_DISCONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_SINGLE_MULTIPLE_ARBITRARY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_SINGLE_DESCRIPTOR_ARRAY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_SINGLE_DESCRIPTOR,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_MULTIPLE_CONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_MULTIPLE_DISCONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_MULTIPLE_ARBITRARY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_DESCRIPTOR_ARRAY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_DISCONTIGUOUS_SINGLE_DESCRIPTOR,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_DISCONTIGUOUS_MULTIPLE_CONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_DISCONTIGUOUS_MULTIPLE_DISCONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_DISCONTIGUOUS_MULTIPLE_ARBITRARY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_UNIFORM_MULTIPLE_DISCONTIGUOUS_DESCRIPTOR_ARRAY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_SINGLE_SINGLE_DESCRIPTOR,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_SINGLE_MULTIPLE_CONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_SINGLE_MULTIPLE_DISCONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_SINGLE_MULTIPLE_ARBITRARY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_SINGLE_DESCRIPTOR_ARRAY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_SINGLE_DESCRIPTOR,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_MULTIPLE_CONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_MULTIPLE_DISCONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_MULTIPLE_ARBITRARY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_DESCRIPTOR_ARRAY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_DISCONTIGUOUS_SINGLE_DESCRIPTOR,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_DISCONTIGUOUS_MULTIPLE_CONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_DISCONTIGUOUS_MULTIPLE_DISCONTIGUOUS,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_DISCONTIGUOUS_MULTIPLE_ARBITRARY,
    &crate::generated::shaders::binding_model_shader_access::BUFFER_BUFFER_MULTIPLE_DISCONTIGUOUS_DESCRIPTOR_ARRAY,
];

/// `DescriptorSetCount`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum DescriptorSetCount {
    Single,
    Multiple,
    MultipleDiscontiguous,
}

impl DescriptorSetCount {
    /// `getDescriptorSetCount`
    fn count(self) -> u32 {
        match self {
            Self::Single => 1,
            Self::Multiple | Self::MultipleDiscontiguous => 2,
        }
    }

    /// `getDescriptorSetNdx` - which set index each of them binds to. The
    /// discontiguous variant leaves a gap that an unused layout fills.
    fn set_ndx(self, ndx: u32) -> u32 {
        match self {
            Self::Single => 0,
            Self::Multiple => ndx,
            Self::MultipleDiscontiguous => [0, 2][ndx as usize],
        }
    }

    fn manifest_name(self) -> &'static str {
        match self {
            Self::Single => "single",
            Self::Multiple => "multiple",
            Self::MultipleDiscontiguous => "multiple_discontiguous",
        }
    }
}

/// `ShaderInputInterface`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ShaderInputInterface {
    SingleDescriptor,
    MultipleContiguousDescriptors,
    MultipleDiscontiguousDescriptors,
    MultipleArbitraryDescriptors,
    DescriptorArray,
}

impl ShaderInputInterface {
    /// `getInterfaceNumResources`
    fn num_resources(self) -> u32 {
        if self == Self::SingleDescriptor { 1 } else { 2 }
    }

    fn manifest_name(self) -> &'static str {
        match self {
            Self::SingleDescriptor => "single_descriptor",
            Self::MultipleContiguousDescriptors => "multiple_contiguous",
            Self::MultipleDiscontiguousDescriptors => "multiple_discontiguous",
            Self::MultipleArbitraryDescriptors => "multiple_arbitrary",
            Self::DescriptorArray => "descriptor_array",
        }
    }

    fn case_name(self) -> &'static str {
        match self {
            Self::SingleDescriptor => "single_descriptor",
            Self::MultipleContiguousDescriptors => "multiple_contiguous_descriptors",
            Self::MultipleDiscontiguousDescriptors => "multiple_discontiguous_descriptors",
            Self::MultipleArbitraryDescriptors => "multiple_arbitrary_descriptors",
            Self::DescriptorArray => "descriptor_array",
        }
    }
}

/// `getArbitraryBindingIndex` - the largest binding values glslang accepts.
fn arbitrary_binding_index(ndx: u32) -> u32 {
    [0x7FFE, 0xFFFE][ndx as usize]
}

fn is_uniform_descriptor_type(t: vk::DescriptorType) -> bool {
    matches!(t, vk::DescriptorType::UNIFORM_BUFFER | vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC)
}

fn is_dynamic_descriptor_type(t: vk::DescriptorType) -> bool {
    matches!(t, vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC | vk::DescriptorType::STORAGE_BUFFER_DYNAMIC)
}

/// `BufferComputeInstance`'s offsets.
const STATIC_OFFSET_VALUE_A: u32 = 256;
const DYNAMIC_OFFSET_VALUE_A: u32 = 512;
const STATIC_OFFSET_VALUE_B: u32 = 1024;
const DYNAMIC_OFFSET_VALUE_B: u32 = 768;
/// `ADDRESSABLE_SIZE` - deliberately far more than the two vec4s that are read.
const ADDRESSABLE_SIZE: u32 = 256;
/// `ComputeInstanceResultBuffer::DATA_SIZE`
const RESULT_DATA_SIZE: u64 = 4 * 4 * 4;

/// The four colours the buffers are filled with, in upstream's order.
const COLORS: [[f32; 4]; 4] = [
    [0.0, 1.0, 0.0, 1.0], // green
    [1.0, 1.0, 0.0, 1.0], // yellow
    [0.0, 0.0, 1.0, 1.0], // blue
    [1.0, 0.0, 0.0, 1.0], // red
];

pub struct BufferAccessCase {
    name: String,
    descriptor_type: vk::DescriptorType,
    descriptor_set_count: DescriptorSetCount,
    shader_interface: ShaderInputInterface,
    /// `viewOffset` - offset the descriptor's view into the buffer.
    set_view_offset: bool,
    /// `dynamicOffset` - a dynamic descriptor type takes an offset at bind time.
    set_dynamic_offset: bool,
    /// `dynamicOffsetNonZero` - and that offset is not zero.
    dynamic_offset_non_zero: bool,
}

impl BufferAccessCase {
    fn program(&self) -> &'static BufferAccessProgram {
        let storage_type = if is_uniform_descriptor_type(self.descriptor_type) { "uniform" } else { "buffer" };
        ALL_BUFFER_ACCESS_PROGRAMS
            .iter()
            .copied()
            .find(|p| p.storage_type == storage_type && p.set_count == self.descriptor_set_count.manifest_name() && p.shader_interface == self.shader_interface.manifest_name())
            .expect("the generator covers every combination")
    }
}

impl TestCase for BufferAccessCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        // Two sets plus the gap the discontiguous variant leaves.
        let required_sets = match self.descriptor_set_count {
            DescriptorSetCount::Single => 1,
            DescriptorSetCount::Multiple => 2,
            DescriptorSetCount::MultipleDiscontiguous => 3,
        };
        let limits = context.get_device_properties().limits;
        if limits.max_bound_descriptor_sets < required_sets {
            return Err(TestError::NotSupported(format!("maxBoundDescriptorSets is {}", limits.max_bound_descriptor_sets)));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(BufferAccessInstance { context, params: self })
    }
}

struct BufferAccessInstance<'a> {
    context: &'a Context<'a>,
    params: &'a BufferAccessCase,
}

impl TestInstance for BufferAccessInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        let is_dynamic = is_dynamic_descriptor_type(p.descriptor_type);
        let num_sets = p.descriptor_set_count.count();
        let num_resources = p.shader_interface.num_resources();
        let num_src_buffers = num_sets * num_resources;

        // One source buffer per descriptor, each holding two colours at `data_offset`.
        let mut bind_time_offsets = Vec::new();
        let mut view_offsets = Vec::new();
        let mut buffers = Vec::new();

        for buffer_ndx in 0..num_src_buffers {
            let parity = (buffer_ndx % 2) as usize;
            let bind_time_offset = if p.dynamic_offset_non_zero {
                [DYNAMIC_OFFSET_VALUE_A, DYNAMIC_OFFSET_VALUE_B][parity]
            } else {
                0
            };
            let static_offset = if p.set_view_offset { [STATIC_OFFSET_VALUE_A, STATIC_OFFSET_VALUE_B][parity] } else { 0 };
            let data_offset = if is_dynamic { bind_time_offset } else { 0 } + static_offset;
            let buffer_size = data_offset + ADDRESSABLE_SIZE;

            let buffer = self.create_color_data_buffer(
                data_offset,
                buffer_size,
                COLORS[((buffer_ndx * 2) % 4) as usize],
                COLORS[((buffer_ndx * 2 + 1) % 4) as usize],
            )?;

            bind_time_offsets.push(bind_time_offset);
            view_offsets.push(static_offset);
            buffers.push(buffer);
        }

        // `ComputeInstanceResultBuffer` - cleared to -1 so "never written" is
        // distinguishable from "written with the wrong value".
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(RESULT_DATA_SIZE, vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            let ptr = result_buffer.get_allocation().get_host_ptr().cast::<f32>();
            for i in 0..(RESULT_DATA_SIZE as usize / 4) {
                ptr.add(i).write(-1.0);
            }
        }
        flush_alloc(device, result_buffer.get_allocation())?;

        let pool = self.create_descriptor_pool()?;
        let mut set_layouts = Vec::new();
        let mut layout_handles = Vec::new();
        let mut sets = Vec::new();

        for set_ndx in 0..num_sets {
            let layout = self.create_descriptor_set_layout(set_ndx)?;
            let set = make_descriptor_set(device, *pool, *layout)?;

            let ndx0 = (set_ndx * num_resources) % num_src_buffers;
            let ndx1 = (set_ndx * num_resources + 1) % num_src_buffers;
            self.write_descriptor_set(
                *set,
                set_ndx,
                buffers[ndx0 as usize].get(),
                view_offsets[ndx0 as usize],
                buffers[ndx1 as usize].get(),
                view_offsets[ndx1 as usize],
                result_buffer.get(),
            );

            layout_handles.push(*layout);
            set_layouts.push(layout);
            sets.push(set);

            // A filler layout occupies the gap between sets 0 and 2. Upstream picks
            // its contents from a hash of the descriptor type, so it is sometimes
            // empty and sometimes holds one unrelated binding; nothing reads it, and
            // what matters is only that set 1 exists so set 2 can be bound.
            if set_ndx == 0 && p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                let unused = create_unused_layout(device, crate::tcu::random::de_int32_hash(p.descriptor_type.as_raw()) ^ crate::tcu::random::de_int32_hash(0))?;
                layout_handles.push(*unused);
                set_layouts.push(unused);
            }
        }

        let pipeline_layout = make_pipeline_layout(device, &layout_handles)?;
        let module = create_shader_module(device, p.program().programs.get("compute")?)?;
        let pipeline = self.create_compute_pipeline(*pipeline_layout, *module)?;

        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;

        let set_handles: Vec<vk::DescriptorSet> = sets.iter().map(|s| **s).collect();
        let dynamic_offsets: Vec<u32> = if p.set_dynamic_offset { bind_time_offsets.clone() } else { Vec::new() };

        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            let barriers: Vec<vk::BufferMemoryBarrier> = buffers
                .iter()
                .map(|b| {
                    vk::BufferMemoryBarrier::builder()
                        .src_access_mask(vk::AccessFlags::HOST_WRITE)
                        .dst_access_mask(if is_uniform_descriptor_type(p.descriptor_type) {
                            vk::AccessFlags::UNIFORM_READ
                        } else {
                            vk::AccessFlags::SHADER_READ
                        })
                        .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                        .buffer(b.get())
                        .offset(0)
                        .size(vk::WHOLE_SIZE)
                        .build()
                })
                .collect();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &barriers,
                &[] as &[vk::ImageMemoryBarrier],
            );

            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);

            // The contiguous arrangements bind every set in one call from index 0. The
            // discontiguous one cannot: its sets are 0 and 2, so each binds at its own
            // index, and the dynamic offsets have to be sliced to match rather than
            // handed over whole.
            if p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                let mut dynamic_offset_ndx = 0usize;
                for set_ndx in 0..num_sets {
                    let offsets: &[u32] = if p.set_dynamic_offset {
                        &dynamic_offsets[dynamic_offset_ndx..dynamic_offset_ndx + num_resources as usize]
                    } else {
                        &[]
                    };
                    device.cmd_bind_descriptor_sets(
                        *command_buffer,
                        vk::PipelineBindPoint::COMPUTE,
                        *pipeline_layout,
                        p.descriptor_set_count.set_ndx(set_ndx),
                        &set_handles[set_ndx as usize..set_ndx as usize + 1],
                        offsets,
                    );
                    dynamic_offset_ndx += num_resources as usize;
                }
            } else {
                device.cmd_bind_descriptor_sets(*command_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline_layout, 0, &set_handles, &dynamic_offsets);
            }

            device.cmd_dispatch(*command_buffer, 4, 1, 1);

            let post = vk::BufferMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                .dst_access_mask(vk::AccessFlags::HOST_READ)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .buffer(result_buffer.get())
                .offset(0)
                .size(vk::WHOLE_SIZE)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[post],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)?;

        invalidate_alloc(device, result_buffer.get_allocation())?;
        let mut results = [[0.0f32; 4]; 4];
        unsafe {
            let ptr = result_buffer.get_allocation().get_host_ptr().cast::<f32>();
            for (i, quadrant) in results.iter_mut().enumerate() {
                for (c, value) in quadrant.iter_mut().enumerate() {
                    *value = ptr.add(i * 4 + c).read();
                }
            }
        }

        // Quadrants 1 and 2 read colorA, 0 and 3 read colorB; with two sets the shader
        // averages what it found in each.
        let mut ref_14 = [0.0f32; 4];
        let mut ref_23 = [0.0f32; 4];
        for set_ndx in 0..num_sets {
            let offset = if p.shader_interface == ShaderInputInterface::SingleDescriptor { 1 } else { 3 };
            let a = COLORS[((2 * set_ndx * num_resources + offset) % 4) as usize];
            let b = COLORS[((2 * set_ndx * num_resources) % 4) as usize];
            for c in 0..4 {
                ref_14[c] += a[c];
                ref_23[c] += b[c];
            }
        }
        for c in 0..4 {
            ref_14[c] /= num_sets as f32;
            ref_23[c] /= num_sets as f32;
        }
        let references = [ref_14, ref_23, ref_23, ref_14];

        if results == references {
            return Ok(TestStatus::pass("Pass"));
        }
        if results.iter().all(|q| q.iter().all(|&v| v == -1.0)) {
            return Ok(TestStatus::fail("Result buffer was not written to"));
        }
        Ok(TestStatus::fail("Invalid result values"))
    }
}

impl BufferAccessInstance<'_> {
    /// `createColorDataBuffer` - two colours at `offset`, in a deliberately larger
    /// allocation so a wrong offset reads defined-but-wrong data rather than faulting.
    fn create_color_data_buffer(&self, offset: u32, buffer_size: u32, value1: [f32; 4], value2: [f32; 4]) -> Result<BufferWithMemory<'_>, TestError> {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let usage = if is_uniform_descriptor_type(self.params.descriptor_type) {
            vk::BufferUsageFlags::UNIFORM_BUFFER
        } else {
            vk::BufferUsageFlags::STORAGE_BUFFER
        };

        let buffer = BufferWithMemory::new(device, allocator, make_buffer_create_info(u64::from(buffer_size), usage), MemoryRequirement::HOST_VISIBLE)?;
        unsafe {
            let base = buffer.get_allocation().get_host_ptr();
            std::ptr::write_bytes(base, 0x5A, buffer_size as usize);
            let at = base.add(offset as usize).cast::<f32>();
            for (i, v) in value1.iter().chain(value2.iter()).enumerate() {
                at.add(i).write(*v);
            }
        }
        flush_alloc(device, buffer.get_allocation())?;
        Ok(buffer)
    }

    /// `createDescriptorSetLayout`
    fn create_descriptor_set_layout(&self, set_ndx: u32) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        let p = self.params;
        let mut builder = DescriptorSetLayoutBuilder::new();
        let mut binding = 0;

        // The result buffer lives in set 0 only.
        if set_ndx == 0 {
            builder = builder.add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE, binding, 1);
            binding += 1;
        }

        builder = match p.shader_interface {
            ShaderInputInterface::SingleDescriptor => builder.add_indexed_binding(p.descriptor_type, vk::ShaderStageFlags::COMPUTE, binding, 1),
            ShaderInputInterface::MultipleContiguousDescriptors => builder
                .add_indexed_binding(p.descriptor_type, vk::ShaderStageFlags::COMPUTE, binding, 1)
                .add_indexed_binding(p.descriptor_type, vk::ShaderStageFlags::COMPUTE, binding + 1, 1),
            ShaderInputInterface::MultipleDiscontiguousDescriptors => builder
                .add_indexed_binding(p.descriptor_type, vk::ShaderStageFlags::COMPUTE, binding, 1)
                .add_indexed_binding(p.descriptor_type, vk::ShaderStageFlags::COMPUTE, binding + 2, 1),
            ShaderInputInterface::MultipleArbitraryDescriptors => builder
                .add_indexed_binding(p.descriptor_type, vk::ShaderStageFlags::COMPUTE, arbitrary_binding_index(0), 1)
                .add_indexed_binding(p.descriptor_type, vk::ShaderStageFlags::COMPUTE, arbitrary_binding_index(1), 1),
            ShaderInputInterface::DescriptorArray => builder.add_indexed_binding(p.descriptor_type, vk::ShaderStageFlags::COMPUTE, binding, 2),
        };

        builder.build(self.context.get_device())
    }

    /// `createDescriptorPool`
    fn create_descriptor_pool(&self) -> Result<Unique<'_, vk::DescriptorPool>, TestError> {
        let p = self.params;
        let num = p.descriptor_set_count.count() * p.shader_interface.num_resources();
        DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(p.descriptor_type, num)
            .build(
                self.context.get_device(),
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                p.descriptor_set_count.count(),
            )
    }

    /// `writeDescriptorSet`
    #[allow(clippy::too_many_arguments)]
    fn write_descriptor_set(&self, set: vk::DescriptorSet, set_ndx: u32, view_a: vk::Buffer, offset_a: u32, view_b: vk::Buffer, offset_b: u32, result: vk::Buffer) {
        let p = self.params;
        let device = self.context.get_device();
        let range = std::mem::size_of::<[f32; 8]>() as u64;

        let result_info = [vk::DescriptorBufferInfo {
            buffer: result,
            offset: 0,
            range: RESULT_DATA_SIZE,
        }];
        let buffer_infos = [
            vk::DescriptorBufferInfo {
                buffer: view_a,
                offset: u64::from(offset_a),
                range,
            },
            vk::DescriptorBufferInfo {
                buffer: view_b,
                offset: u64::from(offset_b),
                range,
            },
        ];

        let mut writes = Vec::new();
        let mut binding = 0;

        if set_ndx == 0 {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(set)
                    .dst_binding(binding)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&result_info)
                    .build(),
            );
            binding += 1;
        }

        let single = |dst_binding: u32, info: &[vk::DescriptorBufferInfo]| {
            vk::WriteDescriptorSet::builder()
                .dst_set(set)
                .dst_binding(dst_binding)
                .descriptor_type(p.descriptor_type)
                .buffer_info(info)
                .build()
        };

        match p.shader_interface {
            ShaderInputInterface::SingleDescriptor => writes.push(single(binding, &buffer_infos[0..1])),
            ShaderInputInterface::MultipleContiguousDescriptors => {
                writes.push(single(binding, &buffer_infos[0..1]));
                writes.push(single(binding + 1, &buffer_infos[1..2]));
            }
            ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                writes.push(single(binding, &buffer_infos[0..1]));
                writes.push(single(binding + 2, &buffer_infos[1..2]));
            }
            ShaderInputInterface::MultipleArbitraryDescriptors => {
                writes.push(single(arbitrary_binding_index(0), &buffer_infos[0..1]));
                writes.push(single(arbitrary_binding_index(1), &buffer_infos[1..2]));
            }
            ShaderInputInterface::DescriptorArray => writes.push(single(binding, &buffer_infos)),
        }

        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
    }

    fn create_compute_pipeline(&self, layout: vk::PipelineLayout, module: vk::ShaderModule) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let entry = c"main";
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(module)
            .name(entry.to_bytes_with_nul())
            .build();
        let info = vk::ComputePipelineCreateInfo::builder().stage(stage).layout(layout);
        let pipeline = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0];
        Ok(Unique::new(device, pipeline))
    }
}

/// `createShaderAccessTests`, restricted to the compute half of the buffer types.
///
/// The group tree upstream builds is
/// `<cmd buffer>.<update method>.<descriptor type>.<stage>.<descriptor arrangement>`;
/// only `primary_cmd_buf.bind.*.compute.*` is registered here, and the rest of the
/// tree is absent rather than present-and-skipped.
pub fn create_shader_access_tests() -> tcu::TestCaseGroup {
    let mut group = tcu::TestCaseGroup::new("shader_access");
    let mut primary = tcu::TestCaseGroup::new("primary_cmd_buf");
    let mut bind = tcu::TestCaseGroup::new("bind");

    let descriptor_types = [
        ("uniform_buffer", vk::DescriptorType::UNIFORM_BUFFER),
        ("storage_buffer", vk::DescriptorType::STORAGE_BUFFER),
        ("uniform_buffer_dynamic", vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC),
        ("storage_buffer_dynamic", vk::DescriptorType::STORAGE_BUFFER_DYNAMIC),
    ];
    let set_counts = [
        ("", DescriptorSetCount::Single),
        ("multiple_descriptor_sets", DescriptorSetCount::Multiple),
        ("multiple_discontiguous_descriptor_sets", DescriptorSetCount::MultipleDiscontiguous),
    ];
    let interfaces = [
        ShaderInputInterface::SingleDescriptor,
        ShaderInputInterface::MultipleContiguousDescriptors,
        ShaderInputInterface::MultipleDiscontiguousDescriptors,
        ShaderInputInterface::MultipleArbitraryDescriptors,
        ShaderInputInterface::DescriptorArray,
    ];

    for (type_name, descriptor_type) in descriptor_types {
        let is_dynamic = is_dynamic_descriptor_type(descriptor_type);
        let mut type_group = tcu::TestCaseGroup::new(type_name);
        let mut stage_group = tcu::TestCaseGroup::new("compute");

        for (set_group_name, descriptor_set_count) in set_counts {
            // The single-set arrangement has no group of its own; its interfaces sit
            // directly under the stage.
            let mut set_group = (!set_group_name.is_empty()).then(|| tcu::TestCaseGroup::new(set_group_name));

            for shader_interface in interfaces {
                let mut interface_group = tcu::TestCaseGroup::new(shader_interface.case_name());

                for set_view_offset in [false, true] {
                    let offset_name = if set_view_offset { "offset_view_nonzero" } else { "offset_view_zero" };

                    if is_dynamic {
                        for dynamic_offset_non_zero in [false, true] {
                            let dynamic_name = if dynamic_offset_non_zero { "dynamic_nonzero" } else { "dynamic_zero" };
                            interface_group.add_child(Box::new(BufferAccessCase {
                                name: format!("{offset_name}_{dynamic_name}"),
                                descriptor_type,
                                descriptor_set_count,
                                shader_interface,
                                set_view_offset,
                                set_dynamic_offset: true,
                                dynamic_offset_non_zero,
                            }) as Box<dyn TestCase>);
                        }
                    } else {
                        interface_group.add_child(Box::new(BufferAccessCase {
                            name: offset_name.to_string(),
                            descriptor_type,
                            descriptor_set_count,
                            shader_interface,
                            set_view_offset,
                            set_dynamic_offset: false,
                            dynamic_offset_non_zero: false,
                        }) as Box<dyn TestCase>);
                    }
                }

                if let Some(g) = set_group.as_mut() {
                    g.add_child(interface_group);
                } else {
                    stage_group.add_child(interface_group);
                }
            }

            if let Some(g) = set_group {
                stage_group.add_child(g);
            }
        }

        type_group.add_child(stage_group);
        bind.add_child(type_group);
    }

    primary.add_child(bind);
    group.add_child(primary);
    group
}

/// `createUnusedLayout` - the filler that keeps the set indices apart. Its contents
/// come from a seeded draw, so it is empty most of the time and otherwise holds a
/// single binding of a type nothing in the shader refers to.
fn create_unused_layout(device: &Device, hash: u32) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
    let mut random = crate::tcu::random::Random::new(hash);
    let r = random.get_uint32() % 10;
    let mut builder = DescriptorSetLayoutBuilder::new();

    if r == 0 {
        builder = builder.add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, vk::ShaderStageFlags::COMPUTE, 0, 1);
    } else if r == 1 {
        builder = builder.add_indexed_binding(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC, vk::ShaderStageFlags::COMPUTE, 0, 1);
    } else if r == 2 {
        builder = builder.add_indexed_binding(vk::DescriptorType::COMBINED_IMAGE_SAMPLER, vk::ShaderStageFlags::COMPUTE, 0, 1);
    }

    builder.build(device)
}
