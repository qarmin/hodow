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
// Ported so far: the compute half of the buffer and storage image descriptor types.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::binding_model_shader_access::{ALL_BUFFER_ACCESS_PROGRAM, ALL_IMAGE_ACCESS_PROGRAM};
use crate::tcu::pixel::TextureLevel;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{self, TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_view};
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

/// The manifest declares the storage image cases with this. Unlike the buffer types,
/// which share a shader across every view, an image case bakes its fetch coordinates
/// into the GLSL, so there is one program per case and `view_name` identifies it.
pub struct ImageAccessProgram {
    pub name: &'static str,
    pub view_name: &'static str,
    pub set_count: &'static str,
    pub shader_interface: &'static str,
    pub programs: BinaryCollection,
}

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
    matches!(
        t,
        vk::DescriptorType::UNIFORM_BUFFER | vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC | vk::DescriptorType::UNIFORM_TEXEL_BUFFER
    )
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

/// Which resource the descriptors point at. Both go through the same instance: the
/// descriptor arrangement, the dispatch and the verification are identical, and only
/// what a descriptor refers to and how the reference value is computed differ.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ResourceKind {
    /// A buffer holding two colours.
    Buffer,
    /// A buffer view over a generated texel pattern.
    TexelBuffer,
}

pub struct BufferAccessCase {
    name: String,
    resource_kind: ResourceKind,
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
        let prefix = match self.resource_kind {
            ResourceKind::Buffer => "buffer_",
            ResourceKind::TexelBuffer => "texel_",
        };
        ALL_BUFFER_ACCESS_PROGRAM
            .iter()
            .copied()
            .filter(|p| p.name.starts_with(prefix))
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

        // One source buffer per descriptor. A texel buffer's is a generated pattern
        // read through a `VkBufferView`; a plain buffer's is two colours at an offset.
        let mut bind_time_offsets = Vec::new();
        let mut view_offsets = Vec::new();
        let mut buffers = Vec::new();
        let mut buffer_views = Vec::new();
        let mut texel_sources = Vec::new();
        let mut texel_view_offset_texels = 0u32;

        if p.resource_kind == ResourceKind::TexelBuffer {
            let view_offset = self.texel_view_offset()?;
            texel_view_offset_texels = view_offset / 4;

            for buffer_ndx in 0..num_src_buffers {
                let source = populate_texel_source(buffer_ndx);
                let usage = if is_uniform_descriptor_type(p.descriptor_type) {
                    vk::BufferUsageFlags::UNIFORM_TEXEL_BUFFER
                } else {
                    vk::BufferUsageFlags::STORAGE_TEXEL_BUFFER
                };
                let buffer = BufferWithMemory::new(device, allocator, make_buffer_create_info(TEXEL_BUFFER_SIZE as u64, usage), MemoryRequirement::HOST_VISIBLE)?;
                unsafe { std::ptr::copy_nonoverlapping(source.as_ptr(), buffer.get_allocation().get_host_ptr(), source.len()) };
                flush_alloc(device, buffer.get_allocation())?;

                let info = vk::BufferViewCreateInfo::builder()
                    .buffer(buffer.get())
                    .format(vk::Format::R8G8B8A8_UNORM)
                    .offset(u64::from(view_offset))
                    .range(u64::from(TEXEL_VIEW_DATA_SIZE));
                let view = unsafe { device.create_buffer_view(&info, None) }.vk_check("vkCreateBufferView")?;

                buffer_views.push(Unique::new(device, view));
                buffers.push(buffer);
                texel_sources.push(source);
            }
        }

        for buffer_ndx in 0..(if p.resource_kind == ResourceKind::Buffer { num_src_buffers } else { 0 }) {
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
            match p.resource_kind {
                ResourceKind::Buffer => self.write_descriptor_set(
                    *set,
                    set_ndx,
                    buffers[ndx0 as usize].get(),
                    view_offsets[ndx0 as usize],
                    buffers[ndx1 as usize].get(),
                    view_offsets[ndx1 as usize],
                    result_buffer.get(),
                ),
                ResourceKind::TexelBuffer => self.write_texel_descriptor_set(*set, set_ndx, *buffer_views[ndx0 as usize], *buffer_views[ndx1 as usize], result_buffer.get()),
            }

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

        if p.resource_kind == ResourceKind::TexelBuffer {
            // Each quadrant fetches its own sample point, alternating between the two
            // descriptors, so all four references differ.
            let mut references = [[0.0f32; 4]; 4];
            for (quadrant, reference) in references.iter_mut().enumerate() {
                for set_ndx in 0..num_sets {
                    let value = fetch_texel_value(&texel_sources, num_resources, texel_view_offset_texels, quadrant, set_ndx);
                    for (r, v) in reference.iter_mut().zip(value) {
                        *r += v;
                    }
                }
                for r in reference.iter_mut() {
                    *r /= num_sets as f32;
                }
            }

            // Unlike the plain buffer case, the comparison is not exact: the value
            // went through a UNORM8 conversion in the driver, and a driver that
            // multiplies by 1/255 rather than dividing by 255 lands one ulp away.
            // Upstream allows a whole quantisation step.
            const CONVERSION_THRESHOLD: f32 = 1.0 / 255.0;
            let any_result_set = results.iter().any(|q| *q != [-1.0f32; 4]);
            let all_ok = results
                .iter()
                .zip(&references)
                .all(|(result, reference)| result.iter().zip(reference).all(|(r, e)| (r - e).abs() <= CONVERSION_THRESHOLD));

            if !any_result_set {
                return Ok(TestStatus::fail("Result buffer was not written to"));
            }
            if all_ok {
                return Ok(TestStatus::pass("Pass"));
            }
            return Ok(TestStatus::fail("Invalid result values"));
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

/// The descriptor set arrangements, and the group each gets. The single-set one has
/// no group of its own; its interfaces sit directly under the stage.
const SET_COUNTS: [(&str, DescriptorSetCount); 3] = [
    ("", DescriptorSetCount::Single),
    ("multiple_descriptor_sets", DescriptorSetCount::Multiple),
    ("multiple_discontiguous_descriptor_sets", DescriptorSetCount::MultipleDiscontiguous),
];

const INTERFACES: [ShaderInputInterface; 5] = [
    ShaderInputInterface::SingleDescriptor,
    ShaderInputInterface::MultipleContiguousDescriptors,
    ShaderInputInterface::MultipleDiscontiguousDescriptors,
    ShaderInputInterface::MultipleArbitraryDescriptors,
    ShaderInputInterface::DescriptorArray,
];

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

    bind.add_child(create_storage_image_group());

    let descriptor_types = [
        ("uniform_buffer", vk::DescriptorType::UNIFORM_BUFFER, ResourceKind::Buffer),
        ("storage_buffer", vk::DescriptorType::STORAGE_BUFFER, ResourceKind::Buffer),
        ("uniform_texel_buffer", vk::DescriptorType::UNIFORM_TEXEL_BUFFER, ResourceKind::TexelBuffer),
        ("storage_texel_buffer", vk::DescriptorType::STORAGE_TEXEL_BUFFER, ResourceKind::TexelBuffer),
        ("uniform_buffer_dynamic", vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC, ResourceKind::Buffer),
        ("storage_buffer_dynamic", vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, ResourceKind::Buffer),
    ];

    for (type_name, descriptor_type, resource_kind) in descriptor_types {
        let is_dynamic = is_dynamic_descriptor_type(descriptor_type);
        let mut type_group = tcu::TestCaseGroup::new(type_name);
        let mut stage_group = tcu::TestCaseGroup::new("compute");

        for (set_group_name, descriptor_set_count) in SET_COUNTS {
            // The single-set arrangement has no group of its own; its interfaces sit
            // directly under the stage.
            let mut set_group = (!set_group_name.is_empty()).then(|| tcu::TestCaseGroup::new(set_group_name));

            for shader_interface in INTERFACES {
                let mut interface_group = tcu::TestCaseGroup::new(shader_interface.case_name());

                for set_view_offset in [false, true] {
                    // The texel buffer cases drop the "view" from the name: their
                    // offset is on the buffer view rather than on the descriptor.
                    let offset_name = match (resource_kind, set_view_offset) {
                        (ResourceKind::TexelBuffer, false) => "offset_zero",
                        (ResourceKind::TexelBuffer, true) => "offset_nonzero",
                        (ResourceKind::Buffer, false) => "offset_view_zero",
                        (ResourceKind::Buffer, true) => "offset_view_nonzero",
                    };

                    if is_dynamic {
                        for dynamic_offset_non_zero in [false, true] {
                            let dynamic_name = if dynamic_offset_non_zero { "dynamic_nonzero" } else { "dynamic_zero" };
                            interface_group.add_child(Box::new(BufferAccessCase {
                                name: format!("{offset_name}_{dynamic_name}"),
                                resource_kind,
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
                            resource_kind,
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

/// `createShaderAccessImageTests` for `VK_DESCRIPTOR_TYPE_STORAGE_IMAGE`, compute
/// stage. The view type is the innermost level of the tree here, where the buffer
/// types put their offset variants.
fn create_storage_image_group() -> tcu::TestCaseGroup {
    let mut type_group = tcu::TestCaseGroup::new("storage_image");
    let mut stage_group = tcu::TestCaseGroup::new("compute");

    for (set_group_name, descriptor_set_count) in SET_COUNTS {
        let mut set_group = (!set_group_name.is_empty()).then(|| tcu::TestCaseGroup::new(set_group_name));

        for shader_interface in INTERFACES {
            let mut interface_group = tcu::TestCaseGroup::new(shader_interface.case_name());

            for (name, view_type, base_mip_level, base_array_slice) in IMAGE_TYPES {
                if !image_case_exists(view_type, descriptor_set_count, shader_interface) {
                    continue;
                }
                interface_group.add_child(Box::new(ImageAccessCase {
                    name,
                    descriptor_type: vk::DescriptorType::STORAGE_IMAGE,
                    descriptor_set_count,
                    shader_interface,
                    view_type,
                    base_mip_level,
                    base_array_slice,
                }) as Box<dyn TestCase>);
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
    type_group
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

// ---------------------------------------------------------------------------------
// Texel buffers
// ---------------------------------------------------------------------------------

/// `TexelBufferInstanceBuffers` constants.
const TEXEL_BUFFER_SIZE: usize = 512;
/// `SAMPLE_POINT_0..3` - arbitrary fetch positions, one per quadrant.
const SAMPLE_POINTS: [u32; 4] = [6, 51, 42, 25];

/// `populateSourceBuffer` - a gradient, a three-level pattern and a triangle wave, so
/// a fetch that lands at the wrong offset reads a visibly different texel whether the
/// error is large or small. Each buffer inverts a different channel.
fn populate_texel_source(buffer_ndx: u32) -> Vec<u8> {
    let format_size = 4;
    let width = TEXEL_BUFFER_SIZE / format_size;
    let mut data = vec![0u8; TEXEL_BUFFER_SIZE];

    for x in 0..width {
        let mut red = 255 * x / width;
        let mut green = if x % 2 == 0 { 127 } else { 0 } + if x % 4 < 3 { 128 } else { 0 };
        let mut blue = 16 * (x % 16);

        if buffer_ndx.is_multiple_of(2) {
            red = 255 - red;
        }
        if buffer_ndx.is_multiple_of(3) {
            green = 255 - green;
        }
        if buffer_ndx.is_multiple_of(4) {
            blue = 255 - blue;
        }

        data[x * 4] = red as u8;
        data[x * 4 + 1] = green as u8;
        data[x * 4 + 2] = blue as u8;
        data[x * 4 + 3] = 255;
    }

    data
}

/// The value the shader should read at `fetch_pos_ndx` for set `set_ndx`, taken from
/// the same source bytes the buffer was filled with. `view_offset` is in texels.
fn fetch_texel_value(sources: &[Vec<u8>], num_resources: u32, view_offset_texels: u32, fetch_pos_ndx: usize, set_ndx: u32) -> [f32; 4] {
    // The two descriptors alternate ABAB across the quadrants.
    let ndx = (set_ndx * num_resources + u32::from(!fetch_pos_ndx.is_multiple_of(2))) as usize % sources.len();
    let at = ((view_offset_texels + SAMPLE_POINTS[fetch_pos_ndx]) * 4) as usize;
    std::array::from_fn(|c| f32::from(sources[ndx][at + c]) / 255.0)
}

/// `VIEW_DATA_SIZE`
const TEXEL_VIEW_DATA_SIZE: u32 = 256;

impl BufferAccessInstance<'_> {
    /// `TexelBufferInstanceBuffers::getViewOffset`. Without
    /// `VK_EXT_texel_buffer_alignment` the offset is just the device's
    /// `minTexelBufferOffsetAlignment`.
    fn texel_view_offset(&self) -> Result<u32, TestError> {
        if !self.params.set_view_offset {
            return Ok(0);
        }
        Ok(self.context.get_device_properties().limits.min_texel_buffer_offset_alignment as u32)
    }

    /// `writeDescriptorSet` for the texel buffer types, which bind a `VkBufferView`
    /// rather than a buffer range.
    fn write_texel_descriptor_set(&self, set: vk::DescriptorSet, set_ndx: u32, view_a: vk::BufferView, view_b: vk::BufferView, result: vk::Buffer) {
        let p = self.params;
        let device = self.context.get_device();

        let result_info = [vk::DescriptorBufferInfo {
            buffer: result,
            offset: 0,
            range: RESULT_DATA_SIZE,
        }];
        let views = [view_a, view_b];

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

        let single = |dst_binding: u32, v: &[vk::BufferView]| {
            vk::WriteDescriptorSet::builder()
                .dst_set(set)
                .dst_binding(dst_binding)
                .descriptor_type(p.descriptor_type)
                .texel_buffer_view(v)
                .build()
        };

        match p.shader_interface {
            ShaderInputInterface::SingleDescriptor => writes.push(single(binding, &views[0..1])),
            ShaderInputInterface::MultipleContiguousDescriptors => {
                writes.push(single(binding, &views[0..1]));
                writes.push(single(binding + 1, &views[1..2]));
            }
            ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                writes.push(single(binding, &views[0..1]));
                writes.push(single(binding + 2, &views[1..2]));
            }
            ShaderInputInterface::MultipleArbitraryDescriptors => {
                writes.push(single(arbitrary_binding_index(0), &views[0..1]));
                writes.push(single(arbitrary_binding_index(1), &views[1..2]));
            }
            ShaderInputInterface::DescriptorArray => writes.push(single(binding, &views)),
        }

        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
    }
}

// ---------------------------------------------------------------------------------
// Images
// ---------------------------------------------------------------------------------

/// `ImageInstanceImages::IMAGE_SIZE` / `ARRAY_SIZE`
const IMAGE_SIZE: u32 = 64;
const ARRAY_SIZE: u32 = 2;

/// `ImageFetchInstanceImages::SAMPLE_POINT_*` - arbitrary points, one per quadrant.
const FETCH_POSITIONS: [[u32; 3]; 4] = [[6, 13, 49], [51, 40, 44], [42, 26, 19], [25, 25, 18]];

/// `isImageViewTypeArray`
fn is_image_view_type_array(t: vk::ImageViewType) -> bool {
    matches!(t, vk::ImageViewType::_1D_ARRAY | vk::ImageViewType::_2D_ARRAY | vk::ImageViewType::CUBE_ARRAY)
}

fn is_image_view_type_1d(t: vk::ImageViewType) -> bool {
    matches!(t, vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY)
}

fn is_image_view_type_2d(t: vk::ImageViewType) -> bool {
    matches!(t, vk::ImageViewType::_2D | vk::ImageViewType::_2D_ARRAY)
}

fn is_image_view_type_cube(t: vk::ImageViewType) -> bool {
    matches!(t, vk::ImageViewType::CUBE | vk::ImageViewType::CUBE_ARRAY)
}

/// `viewTypeToImageType`
fn view_type_to_image_type(t: vk::ImageViewType) -> vk::ImageType {
    match t {
        vk::ImageViewType::_1D | vk::ImageViewType::_1D_ARRAY => vk::ImageType::_1D,
        vk::ImageViewType::_3D => vk::ImageType::_3D,
        _ => vk::ImageType::_2D,
    }
}

/// `getImageLayoutForDescriptorType`
fn image_layout_for_descriptor_type(t: vk::DescriptorType) -> vk::ImageLayout {
    if t == vk::DescriptorType::STORAGE_IMAGE {
        vk::ImageLayout::GENERAL
    } else {
        vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL
    }
}

/// `ImageFetchInstanceImages::getFetchPos` - the sample points wrapped into whatever
/// the view actually exposes, so a view that starts at mip 1 or slice 1 still reads
/// in range.
fn get_fetch_pos(view_type: vk::ImageViewType, base_mip_level: u32, base_array_slice: u32, fetch_pos_ndx: usize) -> [u32; 3] {
    let coord = FETCH_POSITIONS[fetch_pos_ndx];
    let image_size = IMAGE_SIZE >> base_mip_level;
    let array_size = if is_image_view_type_array(view_type) { ARRAY_SIZE - base_array_slice } else { 1 };

    if is_image_view_type_1d(view_type) {
        [coord[0] % image_size, coord[1] % array_size, 0]
    } else if is_image_view_type_2d(view_type) {
        [coord[0] % image_size, coord[1] % image_size, coord[2] % array_size]
    } else if is_image_view_type_cube(view_type) {
        [coord[0] % image_size, coord[1] % image_size, coord[2] % (array_size * 6)]
    } else {
        [coord[0] % image_size, coord[1] % image_size, coord[2] % image_size]
    }
}

/// `ImageInstanceImages::populateSourceImage` - a gradient, a three-level pattern and
/// a per-level/per-image constant, so a fetch that lands at the wrong texel, the wrong
/// mip level or the wrong image all read visibly different values. Each image inverts
/// a different subset of the channels.
fn populate_source_image(view_type: vk::ImageViewType, image_ndx: u32, num_levels: u32) -> Result<Vec<TextureLevel>, TestError> {
    let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
    let mut levels = Vec::with_capacity(num_levels as usize);

    for level in 0..num_levels {
        let width = IMAGE_SIZE >> level;
        let height = if is_image_view_type_1d(view_type) { ARRAY_SIZE } else { IMAGE_SIZE >> level };
        let depth = if is_image_view_type_1d(view_type) {
            1
        } else if is_image_view_type_2d(view_type) {
            ARRAY_SIZE
        } else if is_image_view_type_cube(view_type) {
            6 * ARRAY_SIZE
        } else {
            IMAGE_SIZE >> level
        };

        let mut texture = TextureLevel::new(format, width, height, depth)?;
        {
            let mut access = texture.get_access();
            for z in 0..depth {
                for y in 0..height {
                    for x in 0..width {
                        let grad_pos = x + y + z;
                        let grad_max = width + height + depth - 3;

                        let mut red = (255 * grad_pos / grad_max) as i32;
                        let mut green = if grad_pos.is_multiple_of(2) { 127 } else { 0 } + if grad_pos % 4 < 3 { 128 } else { 0 };
                        let mut blue = (128 * level / num_levels) as i32 + if image_ndx.is_multiple_of(2) { 127 } else { 0 };

                        if image_ndx.is_multiple_of(3) {
                            red = 255 - red;
                        }
                        if image_ndx.is_multiple_of(4) {
                            green = 255 - green;
                        }
                        if image_ndx.is_multiple_of(5) {
                            blue = 255 - blue;
                        }

                        if !access.set_pixel_int([red, green, blue, 255], x, y, z) {
                            return Err(TestError::NotPorted(format!("integer write path for {:?}", access.format())));
                        }
                    }
                }
            }
        }
        levels.push(texture);
    }

    Ok(levels)
}

/// `ImageFetchInstanceImages::fetchImageValue` - what the shader should have read for
/// `fetch_pos_ndx` in set `set_ndx`, taken from the very texels the image was filled
/// with rather than from a second formula.
fn fetch_image_value(
    source_images: &[Vec<TextureLevel>],
    shader_interface: ShaderInputInterface,
    view_type: vk::ImageViewType,
    base_mip_level: u32,
    base_array_slice: u32,
    fetch_pos_ndx: usize,
    set_ndx: u32,
) -> [f32; 4] {
    let num_resources = shader_interface.num_resources();
    let src_a = (set_ndx * num_resources) as usize;
    let src_b = if shader_interface == ShaderInputInterface::SingleDescriptor { src_a } else { src_a + 1 };
    // Sampling order is ABAB.
    let src = if fetch_pos_ndx.is_multiple_of(2) { src_a } else { src_b };

    let mut pos = get_fetch_pos(view_type, base_mip_level, base_array_slice, fetch_pos_ndx);

    // The base array layer goes into whichever coordinate the view type puts it in.
    if is_image_view_type_cube(view_type) {
        pos[2] += 6 * base_array_slice;
    } else if is_image_view_type_1d(view_type) {
        pos[1] += base_array_slice;
    } else {
        pos[2] += base_array_slice;
    }

    source_images[src][base_mip_level as usize].get_const_access().get_pixel(pos[0], pos[1], pos[2])
}

pub struct ImageAccessCase {
    name: &'static str,
    descriptor_type: vk::DescriptorType,
    descriptor_set_count: DescriptorSetCount,
    shader_interface: ShaderInputInterface,
    view_type: vk::ImageViewType,
    /// `FLAG_BASE_MIP` - the view starts one mip level in.
    base_mip_level: u32,
    /// `FLAG_BASE_SLICE` - and/or one array slice in.
    base_array_slice: u32,
}

impl ImageAccessCase {
    fn program(&self) -> &'static ImageAccessProgram {
        ALL_IMAGE_ACCESS_PROGRAM
            .iter()
            .copied()
            .find(|p| p.view_name == self.name && p.set_count == self.descriptor_set_count.manifest_name() && p.shader_interface == self.shader_interface.manifest_name())
            .expect("the generator covers every combination")
    }
}

impl TestCase for ImageAccessCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        // `verifyDriverSupport`, restricted to what the compute stage can reach.
        if self.view_type == vk::ImageViewType::CUBE_ARRAY && context.get_device_features().image_cube_array == vk::FALSE {
            return Err(TestError::NotSupported("imageCubeArray feature not supported".into()));
        }

        let required_sets = match self.descriptor_set_count {
            DescriptorSetCount::Single => 1,
            DescriptorSetCount::Multiple => 2,
            DescriptorSetCount::MultipleDiscontiguous => 3,
        };
        let limits = context.get_device_properties().limits;
        if limits.max_bound_descriptor_sets < required_sets {
            return Err(TestError::NotSupported(format!("maxBoundDescriptorSets is {}", limits.max_bound_descriptor_sets)));
        }

        if self.base_mip_level == 1 {
            let properties = unsafe {
                context.get_instance().get_physical_device_image_format_properties(
                    context.get_physical_device(),
                    vk::Format::R8G8B8A8_UNORM,
                    view_type_to_image_type(self.view_type),
                    vk::ImageTiling::OPTIMAL,
                    vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST,
                    vk::ImageCreateFlags::empty(),
                )
            };
            match properties {
                Err(_) => return Err(TestError::NotSupported("Required format not supported".into())),
                Ok(p) if p.max_mip_levels < 2 => return Err(TestError::NotSupported("Required mipmap count not supported".into())),
                Ok(_) => {}
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.program().programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ImageAccessInstance { context, params: self })
    }
}

struct ImageAccessInstance<'a> {
    context: &'a Context<'a>,
    params: &'a ImageAccessCase,
}

impl TestInstance for ImageAccessInstance<'_> {
    fn iterate(&mut self) -> Result<TestStatus, TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_index = self.context.get_universal_queue_family_index();

        // `ImageFetchComputeInstance` builds a pyramid just deep enough to reach the
        // level the view starts at.
        let num_levels = p.base_mip_level + 1;
        let num_sets = p.descriptor_set_count.count();
        let num_resources = p.shader_interface.num_resources();
        let num_images = num_sets * num_resources;

        let mut source_images = Vec::with_capacity(num_images as usize);
        let mut images = Vec::with_capacity(num_images as usize);
        let mut image_views = Vec::with_capacity(num_images as usize);

        for image_ndx in 0..num_images {
            let source = populate_source_image(p.view_type, image_ndx, num_levels)?;
            let image = self.create_image(&source)?;
            self.upload_image(&source, image.get(), queue, queue_index)?;
            let view = self.create_image_view(&source, image.get())?;

            source_images.push(source);
            images.push(image);
            image_views.push(view);
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

            let ndx0 = (set_ndx * num_resources) as usize % image_views.len();
            let ndx1 = (set_ndx * num_resources + 1) as usize % image_views.len();
            self.write_descriptor_set(*set, set_ndx, *image_views[ndx0], *image_views[ndx1], result_buffer.get());

            layout_handles.push(*layout);
            set_layouts.push(layout);
            sets.push(set);

            if set_ndx == 0 && p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                let unused = create_unused_layout(
                    device,
                    crate::tcu::random::de_int32_hash(p.descriptor_type.as_raw()) ^ crate::tcu::random::de_int32_hash(num_levels as i32),
                )?;
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

        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            device.cmd_bind_pipeline(*command_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline);

            // The discontiguous arrangement's sets are 0 and 2, so each binds at its
            // own index rather than all of them in one call from index 0.
            if p.descriptor_set_count == DescriptorSetCount::MultipleDiscontiguous {
                for set_ndx in 0..num_sets {
                    device.cmd_bind_descriptor_sets(
                        *command_buffer,
                        vk::PipelineBindPoint::COMPUTE,
                        *pipeline_layout,
                        p.descriptor_set_count.set_ndx(set_ndx),
                        &set_handles[set_ndx as usize..set_ndx as usize + 1],
                        &[] as &[u32],
                    );
                }
            } else {
                device.cmd_bind_descriptor_sets(*command_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline_layout, 0, &set_handles, &[] as &[u32]);
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

        let mut references = [[0.0f32; 4]; 4];
        for (quadrant, reference) in references.iter_mut().enumerate() {
            for set_ndx in 0..num_sets {
                let value = fetch_image_value(&source_images, p.shader_interface, p.view_type, p.base_mip_level, p.base_array_slice, quadrant, set_ndx);
                for (r, v) in reference.iter_mut().zip(value) {
                    *r += v;
                }
            }
            if num_sets > 1 {
                for r in reference.iter_mut() {
                    *r /= num_sets as f32;
                }
            }
        }

        // The value went through a UNORM8 conversion in the driver, so upstream allows
        // a whole quantisation step rather than comparing exactly.
        const CONVERSION_THRESHOLD: f32 = 1.0 / 255.0;
        let any_result_set = results.iter().any(|q| *q != [-1.0f32; 4]);
        let all_ok = results
            .iter()
            .zip(&references)
            .all(|(result, reference)| result.iter().zip(reference).all(|(r, e)| (r - e).abs() <= CONVERSION_THRESHOLD));

        if all_ok {
            Ok(TestStatus::pass("Pass"))
        } else if any_result_set {
            Ok(TestStatus::fail("Invalid result values"))
        } else {
            Ok(TestStatus::fail("Result buffer was not written to"))
        }
    }
}

impl ImageAccessInstance<'_> {
    /// `ImageInstanceImages::createImage`
    fn create_image(&self, source: &[TextureLevel]) -> Result<ImageWithMemory<'_>, TestError> {
        let p = self.params;
        let base_level = source[0].size();
        let is_cube = is_image_view_type_cube(p.view_type);

        let array_size = if is_image_view_type_1d(p.view_type) {
            base_level[1]
        } else if p.view_type == vk::ImageViewType::_3D {
            1
        } else {
            // 2D and cube alike; for a cube this is numFaces * numLayers.
            base_level[2]
        };
        let extent = vk::Extent3D {
            width: base_level[0],
            height: if is_image_view_type_1d(p.view_type) { 1 } else { base_level[1] },
            depth: if p.view_type == vk::ImageViewType::_3D { base_level[2] } else { 1 },
        };

        let info = vk::ImageCreateInfo::builder()
            .flags(if is_cube { vk::ImageCreateFlags::CUBE_COMPATIBLE } else { vk::ImageCreateFlags::empty() })
            .image_type(view_type_to_image_type(p.view_type))
            .format(vk::Format::R8G8B8A8_UNORM)
            .extent(extent)
            .mip_levels(source.len() as u32)
            .array_layers(array_size)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_DST)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();

        ImageWithMemory::new(self.context.get_device(), self.context.get_default_allocator(), info, MemoryRequirement::ANY)
    }

    /// `ImageInstanceImages::createImageView`
    fn create_image_view(&self, source: &[TextureLevel], image: vk::Image) -> Result<Unique<'_, vk::ImageView>, TestError> {
        let p = self.params;
        let base_level = source[0].size();
        // A cube view counts slices in faces, so the base slice is six layers in.
        let view_type_base_slice = if is_image_view_type_cube(p.view_type) { 6 * p.base_array_slice } else { p.base_array_slice };
        let view_array_size = match p.view_type {
            vk::ImageViewType::_1D | vk::ImageViewType::_2D | vk::ImageViewType::_3D => 1,
            vk::ImageViewType::_1D_ARRAY => base_level[1] - view_type_base_slice,
            vk::ImageViewType::CUBE => 6,
            _ => base_level[2] - view_type_base_slice,
        };

        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: p.base_mip_level,
            level_count: source.len() as u32 - p.base_mip_level,
            base_array_layer: view_type_base_slice,
            layer_count: view_array_size,
        };
        make_image_view(self.context.get_device(), image, p.view_type, vk::Format::R8G8B8A8_UNORM, range)
    }

    /// `ImageInstanceImages::uploadImage` plus the `writeTextureLevelPyramidData` that
    /// lays the levels out for it. Every level is tightly packed and every array slice
    /// gets its own copy region, which is also how a cube's six faces are fed in.
    fn upload_image(&self, source: &[TextureLevel], image: vk::Image, queue: vk::Queue, queue_index: u32) -> Result<(), TestError> {
        let p = self.params;
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();

        let base_level = source[0].size();
        let slice_count = if is_image_view_type_1d(p.view_type) {
            base_level[1]
        } else if p.view_type == vk::ImageViewType::_3D {
            1
        } else {
            base_level[2]
        };

        let data_size: usize = source.iter().map(|l| l.data().len()).sum();
        let staging = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(data_size as u64, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut copies = Vec::new();
        let mut level_offset = 0usize;
        for (level, texture) in source.iter().enumerate() {
            let size = texture.size();
            let level_data_size = texture.data().len();
            let slice_data_size = level_data_size / slice_count as usize;
            let slice_height = if is_image_view_type_1d(p.view_type) { 1 } else { size[1] };
            let slice_depth = if p.view_type == vk::ImageViewType::_3D { size[2] } else { 1 };

            for slice_ndx in 0..slice_count {
                copies.push(vk::BufferImageCopy {
                    buffer_offset: (level_offset + slice_ndx as usize * slice_data_size) as u64,
                    buffer_row_length: size[0],
                    buffer_image_height: slice_height,
                    image_subresource: vk::ImageSubresourceLayers {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        mip_level: level as u32,
                        base_array_layer: slice_ndx,
                        layer_count: 1,
                    },
                    image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                    image_extent: vk::Extent3D {
                        width: size[0],
                        height: slice_height,
                        depth: slice_depth,
                    },
                });
            }

            unsafe {
                std::ptr::copy_nonoverlapping(texture.data().as_ptr(), staging.get_allocation().get_host_ptr().add(level_offset), level_data_size);
            }
            level_offset += level_data_size;
        }
        flush_alloc(device, staging.get_allocation())?;

        let layout = image_layout_for_descriptor_type(p.descriptor_type);
        let array_layers = if p.view_type == vk::ImageViewType::_3D {
            1
        } else if is_image_view_type_cube(p.view_type) {
            6 * ARRAY_SIZE
        } else {
            ARRAY_SIZE
        };
        let range = vk::ImageSubresourceRange {
            aspect_mask: vk::ImageAspectFlags::COLOR,
            base_mip_level: 0,
            level_count: source.len() as u32,
            base_array_layer: 0,
            layer_count: array_layers,
        };

        let command_pool = make_command_pool(device, queue_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *command_buffer)?;
        unsafe {
            let pre = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::empty())
                .dst_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .old_layout(vk::ImageLayout::UNDEFINED)
                .new_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[pre],
            );

            device.cmd_copy_buffer_to_image(*command_buffer, staging.get(), image, vk::ImageLayout::TRANSFER_DST_OPTIMAL, &copies);

            let post = vk::ImageMemoryBarrier::builder()
                .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
                .dst_access_mask(vk::AccessFlags::SHADER_READ)
                .old_layout(vk::ImageLayout::TRANSFER_DST_OPTIMAL)
                .new_layout(layout)
                .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                .image(image)
                .subresource_range(range)
                .build();
            device.cmd_pipeline_barrier(
                *command_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[post],
            );
        }
        end_command_buffer(device, *command_buffer)?;
        submit_commands_and_wait(device, queue, *command_buffer)
    }

    /// `ImageFetchComputeInstance::createDescriptorSetLayout`
    fn create_descriptor_set_layout(&self, set_ndx: u32) -> Result<Unique<'_, vk::DescriptorSetLayout>, TestError> {
        let p = self.params;
        let mut builder = DescriptorSetLayoutBuilder::new();
        let mut binding = 0;

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

    /// `ImageFetchComputeInstance::createDescriptorPool`
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

    /// `ImageFetchComputeInstance::writeDescriptorSet`
    fn write_descriptor_set(&self, set: vk::DescriptorSet, set_ndx: u32, view_a: vk::ImageView, view_b: vk::ImageView, result: vk::Buffer) {
        let p = self.params;
        let device = self.context.get_device();
        let layout = image_layout_for_descriptor_type(p.descriptor_type);

        let result_info = [vk::DescriptorBufferInfo {
            buffer: result,
            offset: 0,
            range: RESULT_DATA_SIZE,
        }];
        let image_infos = [
            vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: view_a,
                image_layout: layout,
            },
            vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: view_b,
                image_layout: layout,
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

        let single = |dst_binding: u32, info: &[vk::DescriptorImageInfo]| {
            vk::WriteDescriptorSet::builder()
                .dst_set(set)
                .dst_binding(dst_binding)
                .descriptor_type(p.descriptor_type)
                .image_info(info)
                .build()
        };

        match p.shader_interface {
            ShaderInputInterface::SingleDescriptor => writes.push(single(binding, &image_infos[0..1])),
            ShaderInputInterface::MultipleContiguousDescriptors => {
                writes.push(single(binding, &image_infos[0..1]));
                writes.push(single(binding + 1, &image_infos[1..2]));
            }
            ShaderInputInterface::MultipleDiscontiguousDescriptors => {
                writes.push(single(binding, &image_infos[0..1]));
                writes.push(single(binding + 2, &image_infos[1..2]));
            }
            ShaderInputInterface::MultipleArbitraryDescriptors => {
                writes.push(single(arbitrary_binding_index(0), &image_infos[0..1]));
                writes.push(single(arbitrary_binding_index(1), &image_infos[1..2]));
            }
            ShaderInputInterface::DescriptorArray => writes.push(single(binding, &image_infos)),
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

/// `s_imageTypes` - the view type each case name stands for.
const IMAGE_TYPES: [(&str, vk::ImageViewType, u32, u32); 20] = [
    ("1d", vk::ImageViewType::_1D, 0, 0),
    ("1d_base_mip", vk::ImageViewType::_1D, 1, 0),
    ("1d_base_slice", vk::ImageViewType::_1D, 0, 1),
    ("1d_array", vk::ImageViewType::_1D_ARRAY, 0, 0),
    ("1d_array_base_mip", vk::ImageViewType::_1D_ARRAY, 1, 0),
    ("1d_array_base_slice", vk::ImageViewType::_1D_ARRAY, 0, 1),
    ("2d", vk::ImageViewType::_2D, 0, 0),
    ("2d_base_mip", vk::ImageViewType::_2D, 1, 0),
    ("2d_base_slice", vk::ImageViewType::_2D, 0, 1),
    ("2d_array", vk::ImageViewType::_2D_ARRAY, 0, 0),
    ("2d_array_base_mip", vk::ImageViewType::_2D_ARRAY, 1, 0),
    ("2d_array_base_slice", vk::ImageViewType::_2D_ARRAY, 0, 1),
    ("3d", vk::ImageViewType::_3D, 0, 0),
    ("3d_base_mip", vk::ImageViewType::_3D, 1, 0),
    // no 3d array textures
    ("cube", vk::ImageViewType::CUBE, 0, 0),
    ("cube_base_mip", vk::ImageViewType::CUBE, 1, 0),
    ("cube_base_slice", vk::ImageViewType::CUBE, 0, 1),
    ("cube_array", vk::ImageViewType::CUBE_ARRAY, 0, 0),
    ("cube_array_base_mip", vk::ImageViewType::CUBE_ARRAY, 1, 0),
    ("cube_array_base_slice", vk::ImageViewType::CUBE_ARRAY, 0, 1),
];

/// `createShaderAccessImageTests`' "skip some image view variations to avoid
/// unnecessary bloating": only the plain 2D view gets the arrangements that already
/// multiply out, so the group does not become the product of every axis.
fn image_case_exists(view_type: vk::ImageViewType, descriptor_set_count: DescriptorSetCount, shader_interface: ShaderInputInterface) -> bool {
    view_type == vk::ImageViewType::_2D
        || (!matches!(
            shader_interface,
            ShaderInputInterface::MultipleDiscontiguousDescriptors | ShaderInputInterface::MultipleArbitraryDescriptors
        ) && descriptor_set_count != DescriptorSetCount::MultipleDiscontiguous)
}
