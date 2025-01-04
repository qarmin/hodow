// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeZeroInitializeWorkgroupMemoryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported so far: specialize_workgroup (512 cases) and max_workgroups (3). The
// remaining subgroups - types, composites, max_workgroup_memory, repeat_pipeline,
// shared_memory_blocks - each carry a table of per-case GLSL that has to be
// transcribed, so they are separate work.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{
    ComputePipelineConstructionType, ComputePipelineWrapper, check_shader_object_requirements,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The extension every case in this group needs.
const EXTENSION: &str = "VK_KHR_zero_initialize_workgroup_memory";

/// A case whose only manifest-declared content is its shader; everything else varies
/// per case at run time. The generator emits one of these per shared shader.
#[derive(Clone, Copy)]
pub struct SharedProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// Same, for the two shaders that differ only in which parity writes shared memory.
#[derive(Clone, Copy)]
pub struct SharedProgramOdd {
    pub name: &'static str,
    pub odd: u32,
    pub programs: BinaryCollection,
}

/// `runCompute` - the helper every test in this file dispatches through.
#[allow(clippy::too_many_arguments)]
fn run_compute(
    context: &Context<'_>,
    buffer_size: u32,
    num_wgx: u32,
    num_wgy: u32,
    num_wgz: u32,
    spec_values: &[u32],
    increment: u32,
) -> TestOutcome {
    let vk = context.get_device();
    let device_queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let allocator = context.get_default_allocator();

    let size = buffer_size as u64;
    let buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(
            size,
            vk::BufferUsageFlags::STORAGE_BUFFER
                | vk::BufferUsageFlags::TRANSFER_DST
                | vk::BufferUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let buffer_descriptor = make_descriptor_buffer_info(buffer.get(), 0, size);

    // Prefill with 0xff when checking for zeroes, so a shader that writes nothing
    // cannot pass by accident; with 0 when the shader accumulates instead.
    let ptr = buffer.get_allocation().get_host_ptr();
    unsafe { std::ptr::write_bytes(ptr, if increment != 0 { 0 } else { 0xff }, size as usize) };

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(vk)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

    let entries: Vec<vk::SpecializationMapEntry> = spec_values
        .iter()
        .enumerate()
        .map(|(i, _)| vk::SpecializationMapEntry {
            constant_id: i as u32,
            offset: (std::mem::size_of::<u32>() * i) as u32,
            size: std::mem::size_of::<u32>(),
        })
        .collect();
    let spec_bytes: Vec<u8> = spec_values.iter().flat_map(|v| v.to_ne_bytes()).collect();

    flush_alloc(vk, buffer.get_allocation())?;

    let mut pipeline = ComputePipelineWrapper::new(
        vk,
        ComputePipelineConstructionType::Pipeline,
        context.get_binary_collection().get("comp")?,
    );
    pipeline.set_descriptor_set_layout(*descriptor_set_layout);
    pipeline.set_specialization_info(entries, spec_bytes);
    pipeline.build_pipeline()?;

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    DescriptorSetUpdateBuilder::new()
        .write_single(
            *descriptor_set,
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &buffer_descriptor,
        )
        .update(vk);

    begin_command_buffer(vk, *cmd_buffer)?;
    unsafe {
        vk.cmd_bind_descriptor_sets(
            *cmd_buffer,
            vk::PipelineBindPoint::COMPUTE,
            pipeline.get_pipeline_layout(),
            0,
            &[*descriptor_set],
            &[],
        );
    }
    pipeline.bind(*cmd_buffer);
    unsafe {
        vk.cmd_dispatch(*cmd_buffer, num_wgx, num_wgy, num_wgz);

        let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
        vk.cmd_pipeline_barrier(
            *cmd_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(vk, *cmd_buffer)?;
    submit_commands_and_wait(vk, device_queue, *cmd_buffer)?;

    invalidate_alloc(vk, buffer.get_allocation())?;

    let values = buffer.get_allocation().get_host_ptr().cast::<u32>();
    let count = size as usize / std::mem::size_of::<u32>();
    for i in 0..count {
        let expected = if increment != 0 { num_wgx * num_wgy * num_wgz } else { 0 };
        let got = unsafe { *values.add(i) };
        if got != expected {
            log::error!("failure at index {i}: expected {expected}, got: {got}");
            return Ok(TestStatus::fail("compute failed"));
        }
    }

    Ok(TestStatus::pass("compute succeeded"))
}

// ---------------------------------------------------------------------------------
// SpecializeWorkgroupTest
// ---------------------------------------------------------------------------------

/// One of the 512 `specialize_workgroup.<x>_<y>_<z>` cases.
///
/// The name is owned rather than `&'static str` because upstream builds it in a loop
/// and so does this; there is no static to point at.
pub struct SpecializeWorkgroupCase {
    name: String,
    x: u32,
    y: u32,
    z: u32,
    programs: BinaryCollection,
}

impl TestCase for SpecializeWorkgroupCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality(EXTENSION)?;
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)?;

        let properties = context.get_device_properties();
        if self.x * self.y * self.z > properties.limits.max_compute_work_group_invocations {
            return Err(TestError::NotSupported("Workgroup size exceeds limits".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SpecializeWorkgroupInstance {
            context,
            x: self.x,
            y: self.y,
            z: self.z,
        })
    }
}

struct SpecializeWorkgroupInstance<'a> {
    context: &'a Context<'a>,
    x: u32,
    y: u32,
    z: u32,
}

impl TestInstance for SpecializeWorkgroupInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let size = std::mem::size_of::<u32>() as u32 * self.x * self.y * self.z;
        run_compute(self.context, size, 1, 1, 1, &[self.x, self.y, self.z], 0)
    }
}

/// `AddSpecializeWorkgroupTests`
fn add_specialize_workgroup_tests(group: &mut TestCaseGroup, programs: BinaryCollection) {
    for z in 1..=8u32 {
        for y in 1..=8u32 {
            for x in 1..=8u32 {
                group.add_child(Box::new(SpecializeWorkgroupCase {
                    name: format!("{x}_{y}_{z}"),
                    x,
                    y,
                    z,
                    programs,
                }) as Box<dyn TestCase>);
            }
        }
    }
}

// ---------------------------------------------------------------------------------
// MaxWorkgroupsTest
// ---------------------------------------------------------------------------------

/// `Dim`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Dim {
    X,
    Y,
    Z,
}

pub struct MaxWorkgroupsCase {
    name: &'static str,
    dim: Dim,
    programs: BinaryCollection,
}

impl TestCase for MaxWorkgroupsCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality(EXTENSION)?;
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MaxWorkgroupsInstance { context, dim: self.dim })
    }
}

struct MaxWorkgroupsInstance<'a> {
    context: &'a Context<'a>,
    dim: Dim,
}

impl TestInstance for MaxWorkgroupsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let properties = self.context.get_device_properties();

        // Fill the workgroup up to 2048 invocations, spilling into y and then z only
        // as far as each axis limit allows.
        let max_wg = 2048u32.min(properties.limits.max_compute_work_group_invocations);
        let wgx = properties.limits.max_compute_work_group_size[0];
        let mut wgy = 1u32;
        let mut wgz = 1u32;
        if wgx < max_wg {
            wgy = (max_wg / wgx).min(properties.limits.max_compute_work_group_size[1]);
        }
        if (wgx * wgy) < max_wg {
            wgz = (max_wg / wgx / wgy).min(properties.limits.max_compute_work_group_size[2]);
        }

        let size = std::mem::size_of::<u32>() as u32 * wgx * wgy * wgz;

        let num_wgx = if self.dim == Dim::X { 65535 } else { 1 };
        let num_wgy = if self.dim == Dim::Y { 65535 } else { 1 };
        let num_wgz = if self.dim == Dim::Z { 65535 } else { 1 };

        run_compute(self.context, size, num_wgx, num_wgy, num_wgz, &[wgx, wgy, wgz], 1)
    }
}

/// `AddMaxWorkgroupsTests`
fn add_max_workgroups_tests(group: &mut TestCaseGroup, programs: BinaryCollection) {
    group.add_child(Box::new(MaxWorkgroupsCase {
        name: "x",
        dim: Dim::X,
        programs,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(MaxWorkgroupsCase {
        name: "y",
        dim: Dim::Y,
        programs,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(MaxWorkgroupsCase {
        name: "z",
        dim: Dim::Z,
        programs,
    }) as Box<dyn TestCase>);
}

// ---------------------------------------------------------------------------------
// MaxWorkgroupMemoryTest
// ---------------------------------------------------------------------------------

pub struct MaxWorkgroupMemoryCase {
    name: String,
    num_workgroups: u32,
    programs: BinaryCollection,
}

impl TestCase for MaxWorkgroupMemoryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality(EXTENSION)?;
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MaxWorkgroupMemoryInstance {
            context,
            num_workgroups: self.num_workgroups,
        })
    }
}

struct MaxWorkgroupMemoryInstance<'a> {
    context: &'a Context<'a>,
    num_workgroups: u32,
}

impl TestInstance for MaxWorkgroupMemoryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let properties = self.context.get_device_properties();
        let max_mem_size = properties.limits.max_compute_shared_memory_size;

        // Everything is rounded down to a multiple of 13 so the workgroup size is not
        // a power of two; that is deliberate upstream, to keep indices from lining up
        // with the shared-memory layout.
        let max_wg = 247u32.min((properties.limits.max_compute_work_group_invocations / 13) * 13);
        let wgx = (properties.limits.max_compute_work_group_size[0] / 13) * 13;
        let mut wgy = 1u32;
        let mut wgz = 1u32;
        if wgx < max_wg {
            wgy = (max_wg / wgx).min((properties.limits.max_compute_work_group_size[1] / 13) * 13);
        }
        if (wgx * wgy) < max_wg {
            wgz = (max_wg / wgx / wgy).min((properties.limits.max_compute_work_group_size[2] / 13) * 13);
        }

        let size = max_mem_size;
        let num_elems = max_mem_size / 16;

        run_compute(
            self.context,
            size,
            self.num_workgroups,
            1,
            1,
            &[wgx, wgy, wgz, num_elems],
            1,
        )
    }
}

/// `AddMaxWorkgroupMemoryTests`
fn add_max_workgroup_memory_tests(group: &mut TestCaseGroup, programs: BinaryCollection) {
    for num_wg in [1u32, 2, 4, 16, 64, 128] {
        group.add_child(Box::new(MaxWorkgroupMemoryCase {
            name: num_wg.to_string(),
            num_workgroups: num_wg,
            programs,
        }) as Box<dyn TestCase>);
    }
}

// ---------------------------------------------------------------------------------
// RepeatedPipelineTest
// ---------------------------------------------------------------------------------

pub struct RepeatedPipelineCase {
    name: String,
    x_size: u32,
    odd: u32,
    repeat: u32,
    programs: BinaryCollection,
}

impl TestCase for RepeatedPipelineCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality(EXTENSION)?;
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RepeatedPipelineInstance {
            context,
            x_size: self.x_size,
            odd: self.odd,
            repeat: self.repeat,
        })
    }
}

struct RepeatedPipelineInstance<'a> {
    context: &'a Context<'a>,
    x_size: u32,
    odd: u32,
    repeat: u32,
}

impl TestInstance for RepeatedPipelineInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vk = self.context.get_device();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let allocator = self.context.get_default_allocator();

        let buffer_size = self.x_size * 2 * std::mem::size_of::<u32>() as u32;
        let size = buffer_size as u64;

        let usage = vk::BufferUsageFlags::STORAGE_BUFFER
            | vk::BufferUsageFlags::TRANSFER_DST
            | vk::BufferUsageFlags::TRANSFER_SRC;
        let buffer0 = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(size, usage),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED,
        )?;
        let buffer1 = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(size, usage),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::CACHED,
        )?;

        let ptr0 = buffer0.get_allocation().get_host_ptr().cast::<u32>();
        let ptr1 = buffer1.get_allocation().get_host_ptr().cast::<u32>();
        let count = size as usize / std::mem::size_of::<u32>();
        for i in 0..count {
            unsafe { *ptr1.add(i) = i as u32 };
        }
        unsafe { std::ptr::write_bytes(ptr0.cast::<u8>(), 0xff, size as usize) };

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vk)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

        let spec_values = [self.x_size];
        let entries = vec![vk::SpecializationMapEntry {
            constant_id: 0,
            offset: 0,
            size: std::mem::size_of::<u32>(),
        }];
        let spec_bytes: Vec<u8> = spec_values.iter().flat_map(|v| v.to_ne_bytes()).collect();

        flush_alloc(vk, buffer0.get_allocation())?;
        flush_alloc(vk, buffer1.get_allocation())?;

        let mut pipeline = ComputePipelineWrapper::new(
            vk,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.set_specialization_info(entries, spec_bytes);
        pipeline.build_pipeline()?;

        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let desc0 = make_descriptor_buffer_info(buffer0.get(), 0, size);
        let desc1 = make_descriptor_buffer_info(buffer1.get(), 0, size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &desc0,
            )
            .write_single(
                *descriptor_set,
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &desc1,
            )
            .update(vk);

        begin_command_buffer(vk, *cmd_buffer)?;
        unsafe {
            vk.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                pipeline.get_pipeline_layout(),
                0,
                &[*descriptor_set],
                &[],
            );
        }
        pipeline.bind(*cmd_buffer);
        unsafe {
            vk.cmd_dispatch(*cmd_buffer, 1, 1, 1);
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            vk.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(vk, *cmd_buffer)?;

        // The point of the test: the same command buffer is submitted repeatedly, and
        // the shared memory must come out zero-initialised every single time.
        for _ in 0..self.repeat {
            submit_commands_and_wait(vk, queue, *cmd_buffer)?;
            invalidate_alloc(vk, buffer0.get_allocation())?;

            for i in 0..count {
                let expected = if self.odd == (i as u32 / self.x_size) {
                    i as u32
                } else {
                    0
                };
                let got = unsafe { *ptr0.add(i) };
                if got != expected {
                    log::error!("failure at index {i}: expected {expected}, got: {got}");
                    return Ok(TestStatus::fail("compute failed"));
                }
            }

            unsafe { std::ptr::write_bytes(ptr0.cast::<u8>(), 0xff, size as usize) };
            flush_alloc(vk, buffer0.get_allocation())?;
        }

        Ok(TestStatus::pass("compute succeeded"))
    }
}

/// `AddRepeatedPipelineTests`
fn add_repeated_pipeline_tests(group: &mut TestCaseGroup, even: BinaryCollection, odd_programs: BinaryCollection) {
    for x in [4u32, 16, 32, 64] {
        for odd in [0u32, 1] {
            for repeat in [2u32, 4, 8, 16] {
                let name = format!("x_{x}_{}_repeat_{repeat}", if odd == 1 { "odd" } else { "even" });
                let programs = if odd == 1 { odd_programs } else { even };
                group.add_child(Box::new(RepeatedPipelineCase {
                    name,
                    x_size: x,
                    odd,
                    repeat,
                    programs,
                }) as Box<dyn TestCase>);
            }
        }
    }
}

// ---------------------------------------------------------------------------------
// createZeroInitializeWorkgroupMemoryTests
// ---------------------------------------------------------------------------------

/// `createZeroInitializeWorkgroupMemoryTests`
pub fn create_zero_initialize_workgroup_memory_tests(
    construction_type: ComputePipelineConstructionType,
) -> TestCaseGroup {
    debug_assert_eq!(construction_type, ComputePipelineConstructionType::Pipeline);

    use crate::generated::shaders::compute_zero_initialize;

    let mut tests = TestCaseGroup::new("zero_initialize_workgroup_memory");

    let mut max_workgroup_memory_group = TestCaseGroup::new("max_workgroup_memory");
    add_max_workgroup_memory_tests(
        &mut max_workgroup_memory_group,
        compute_zero_initialize::MAX_WORKGROUP_MEMORY.programs,
    );
    tests.add_child(max_workgroup_memory_group);

    // types and composites need a per-case GLSL table; not ported.

    let mut max_workgroups_group = TestCaseGroup::new("max_workgroups");
    add_max_workgroups_tests(
        &mut max_workgroups_group,
        compute_zero_initialize::MAX_WORKGROUPS.programs,
    );
    tests.add_child(max_workgroups_group);

    let mut specialize_workgroup_group = TestCaseGroup::new("specialize_workgroup");
    add_specialize_workgroup_tests(
        &mut specialize_workgroup_group,
        compute_zero_initialize::SPECIALIZE_WORKGROUP.programs,
    );
    tests.add_child(specialize_workgroup_group);

    let mut repeat_pipeline_group = TestCaseGroup::new("repeat_pipeline");
    add_repeated_pipeline_tests(
        &mut repeat_pipeline_group,
        compute_zero_initialize::REPEAT_PIPELINE_EVEN.programs,
        compute_zero_initialize::REPEAT_PIPELINE_ODD.programs,
    );
    tests.add_child(repeat_pipeline_group);

    // shared_memory_blocks are Amber scripts: spirv_assembly/amber_tests.rs, added by compute/mod.rs for the monolithic pipeline type.

    tests
}
