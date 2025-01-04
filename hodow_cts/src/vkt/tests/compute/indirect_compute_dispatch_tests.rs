// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/compute/vktComputeIndirectComputeDispatchTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported: the `upload_buffer` group, where the host fills the indirect buffer, the `gen_in_compute` group (a compute shader writes the
// dispatch commands first) and the `_device_address` variants (VK_KHR_device_address_commands, `vkCmdDispatchIndirect2KHR`).

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{IVec3, TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{
    ComputePipelineConstructionType, ComputePipelineWrapper, check_shader_object_requirements,
};
use crate::vk::device_address_commands::{
    self, ADDRESS_COMMAND_FULLY_BOUND, ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE,
    ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE, DeviceAddressRange, DispatchIndirect2Info,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `RESULT_BLOCK_BASE_SIZE` - uvec3 expectedGroupCount + uint numPassed.
const RESULT_BLOCK_BASE_SIZE: u64 = 4 * std::mem::size_of::<u32>() as u64;
/// `RESULT_BLOCK_NUM_PASSED_OFFSET`
const RESULT_BLOCK_NUM_PASSED_OFFSET: usize = 3 * std::mem::size_of::<u32>();

/// `DispatchCommand`
#[derive(Clone, Copy)]
pub struct DispatchCommand {
    pub offset: u64,
    pub num_work_groups: [u32; 3],
}

impl DispatchCommand {
    pub const fn new(offset: u64, num_work_groups: [u32; 3]) -> Self {
        Self {
            offset,
            num_work_groups,
        }
    }
}

/// `getResultBlockAlignedSize`
fn get_result_block_aligned_size(properties: &vk::PhysicalDeviceProperties, base_size: u64) -> u64 {
    let alignment = properties.limits.min_storage_buffer_offset_alignment;
    if alignment == 0 || base_size.is_multiple_of(alignment) {
        base_size
    } else {
        (base_size / alignment + 1) * alignment
    }
}

/// The manifest-declared half of a case: shader plus the parameters baked into it.
/// The dispatch command list stays in the Rust, because it is a variable-length table
/// that upstream also writes inline.
#[derive(Clone, Copy)]
pub struct IndirectDispatchCase {
    pub name: &'static str,
    pub buffer_size: u32,
    pub local_size: IVec3,
    pub null_dispatch: bool,
    pub dispatch_commands: &'static [DispatchCommand],
    pub programs: BinaryCollection,
}

/// How the indirect buffer gets its contents.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum FillMode {
    /// `IndirectDispatchInstanceBufferUpload` - the host writes the commands.
    Upload,
    /// `IndirectDispatchInstanceBufferGenerate` - a compute shader writes them, so the
    /// driver has to order the write against the indirect read that follows.
    GenerateInCompute,
}

pub struct IndirectDispatchUploadCase {
    name: String,
    params: IndirectDispatchCase,
    fill_mode: FillMode,
    /// `useDeviceAddressCommands`: the dispatch reads its command through `vkCmdDispatchIndirect2KHR`.
    use_device_address_commands: bool,
}

impl TestCase for IndirectDispatchUploadCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.use_device_address_commands {
            device_address_commands::check_support(context)?;
        }
        check_shader_object_requirements(ComputePipelineConstructionType::Pipeline)
    }

    fn programs(&self) -> BinaryCollection {
        self.params.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IndirectDispatchInstanceBufferUpload {
            context,
            params: self.params,
            fill_mode: self.fill_mode,
            use_device_address_commands: self.use_device_address_commands,
        })
    }
}

/// Resources the generate variant needs alive for the whole submission.
///
/// Field order is load-bearing: Rust drops struct fields in declaration order, and a
/// descriptor set must be freed back to its pool before that pool is destroyed. Held
/// as a tuple this was a use-after-free that segfaulted on teardown.
struct GenerateResources<'a> {
    pipeline: ComputePipelineWrapper<'a>,
    set: UniqueDescriptorSet<'a>,
    // Never read: held only so their Drop runs at the right time, after `set`.
    #[allow(dead_code)]
    pool: Unique<'a, vk::DescriptorPool>,
    #[allow(dead_code)]
    layout: Unique<'a, vk::DescriptorSetLayout>,
}

struct IndirectDispatchInstanceBufferUpload<'a> {
    context: &'a Context<'a>,
    params: IndirectDispatchCase,
    fill_mode: FillMode,
    use_device_address_commands: bool,
}

impl TestInstance for IndirectDispatchInstanceBufferUpload<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let vkdi = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let queue = self.context.get_universal_queue();
        let queue_family_index = self.context.get_universal_queue_family_index();

        log::debug!("GL_DISPATCH_INDIRECT_BUFFER size = {}", self.params.buffer_size);

        // Create result buffer - one aligned block per dispatch command, so each
        // command reports into its own slice and they cannot mask each other.
        let result_block_size =
            get_result_block_aligned_size(self.context.get_device_properties(), RESULT_BLOCK_BASE_SIZE);
        let result_buffer_size = result_block_size * self.params.dispatch_commands.len() as u64;
        let result_buffer = BufferWithMemory::new(
            vkdi,
            allocator,
            make_buffer_create_info(result_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = result_buffer.get_allocation();
            let result_data_ptr = alloc.get_host_ptr();
            for (cmd_ndx, cmd) in self.params.dispatch_commands.iter().enumerate() {
                let dst_ptr = unsafe { result_data_ptr.add(result_block_size as usize * cmd_ndx) };
                unsafe {
                    let words = dst_ptr.cast::<u32>();
                    *words.add(0) = cmd.num_work_groups[0];
                    *words.add(1) = cmd.num_work_groups[1];
                    *words.add(2) = cmd.num_work_groups[2];
                    *dst_ptr.add(RESULT_BLOCK_NUM_PASSED_OFFSET).cast::<u32>() = 0;
                }
            }
            flush_alloc(vkdi, alloc)?;
        }

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(vkdi)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(
                vk::DescriptorType::STORAGE_BUFFER,
                self.params.dispatch_commands.len() as u32,
            )
            .build(
                vkdi,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                self.params.dispatch_commands.len() as u32,
            )?;

        let mut compute_pipeline = ComputePipelineWrapper::new(
            vkdi,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        compute_pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        compute_pipeline.build_pipeline()?;

        let cmd_pool = make_command_pool(vkdi, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vkdi, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // Create indirect buffer
        let mut indirect_usage = vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::STORAGE_BUFFER;
        if self.use_device_address_commands {
            indirect_usage |= vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
        }
        let indirect_memory = if self.use_device_address_commands {
            MemoryRequirement::DEVICE_ADDRESS | MemoryRequirement::HOST_VISIBLE
        } else {
            MemoryRequirement::HOST_VISIBLE
        };
        let indirect_buffer = BufferWithMemory::new(
            vkdi,
            allocator,
            make_buffer_create_info(self.params.buffer_size as u64, indirect_usage),
            indirect_memory,
        )?;
        let indirect_buffer_address = if self.use_device_address_commands {
            device_address_commands::buffer_device_address(vkdi, indirect_buffer.get())
        } else {
            0
        };
        let address_commands = if self.use_device_address_commands {
            Some(device_address_commands::load_commands(self.context)?)
        } else {
            None
        };

        // `fillIndirectBufferData` for the upload variant: the host writes the commands
        // before anything is recorded.
        if self.fill_mode == FillMode::Upload {
            let alloc = indirect_buffer.get_allocation();
            let indirect_data_ptr = alloc.get_host_ptr();
            for cmd in self.params.dispatch_commands {
                debug_assert!(cmd.offset.is_multiple_of(std::mem::size_of::<u32>() as u64));
                let dst_ptr = unsafe { indirect_data_ptr.add(cmd.offset as usize).cast::<u32>() };
                unsafe {
                    *dst_ptr.add(0) = cmd.num_work_groups[0];
                    *dst_ptr.add(1) = cmd.num_work_groups[1];
                    *dst_ptr.add(2) = cmd.num_work_groups[2];
                }
            }
            flush_alloc(vkdi, alloc)?;
        }

        // The generate variant needs its own pipeline and descriptor set, built before
        // the command buffer is recorded so they outlive the submission.
        let gen_resources = if self.fill_mode == FillMode::GenerateInCompute {
            let gen_layout = DescriptorSetLayoutBuilder::new()
                .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
                .build(vkdi)?;
            let gen_pool = DescriptorPoolBuilder::new()
                .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
                .build(vkdi, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
            let gen_set = make_descriptor_set(vkdi, *gen_pool, *gen_layout)?;

            let indirect_descriptor_info =
                make_descriptor_buffer_info(indirect_buffer.get(), 0, self.params.buffer_size as u64);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    *gen_set,
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &indirect_descriptor_info,
                )
                .update(vkdi);

            let mut gen_pipeline = ComputePipelineWrapper::new(
                vkdi,
                ComputePipelineConstructionType::Pipeline,
                self.context.get_binary_collection().get("generate")?,
            );
            gen_pipeline.set_descriptor_set_layout(*gen_layout);
            gen_pipeline.build_pipeline()?;

            Some(GenerateResources {
                pipeline: gen_pipeline,
                set: gen_set,
                pool: gen_pool,
                layout: gen_layout,
            })
        } else {
            None
        };

        // Begin recording commands
        begin_command_buffer(vkdi, *cmd_buffer)?;

        // `fillIndirectBufferData` for the generate variant: a compute shader writes
        // the commands, and the barrier is what the driver must honour before reading
        // them as an indirect command.
        if let Some(generate) = &gen_resources {
            generate.pipeline.bind(*cmd_buffer);
            unsafe {
                vkdi.cmd_bind_descriptor_sets(
                    *cmd_buffer,
                    vk::PipelineBindPoint::COMPUTE,
                    generate.pipeline.get_pipeline_layout(),
                    0,
                    &[*generate.set],
                    &[],
                );
                vkdi.cmd_dispatch(*cmd_buffer, 1, 1, 1);

                let buffer_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::INDIRECT_COMMAND_READ,
                    indirect_buffer.get(),
                    0,
                    self.params.buffer_size as u64,
                );
                vkdi.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::DRAW_INDIRECT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        compute_pipeline.bind(*cmd_buffer);

        // One descriptor set per command, each pointing at that command's result block.
        let mut descriptor_sets = Vec::with_capacity(self.params.dispatch_commands.len());
        let mut cur_offset = 0u64;
        for cmd in self.params.dispatch_commands {
            let descriptor_set = make_descriptor_set(vkdi, *descriptor_pool, *descriptor_set_layout)?;
            let result_descriptor_info =
                make_descriptor_buffer_info(result_buffer.get(), cur_offset, result_block_size);
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    *descriptor_set,
                    Location::binding(0),
                    vk::DescriptorType::STORAGE_BUFFER,
                    &result_descriptor_info,
                )
                .update(vkdi);

            unsafe {
                vkdi.cmd_bind_descriptor_sets(
                    *cmd_buffer,
                    vk::PipelineBindPoint::COMPUTE,
                    compute_pipeline.get_pipeline_layout(),
                    0,
                    &[*descriptor_set],
                    &[],
                );
                match &address_commands {
                    None => vkdi.cmd_dispatch_indirect(*cmd_buffer, indirect_buffer.get(), cmd.offset),
                    Some(commands) => {
                        let mut address_flags = ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE;
                        // Different valid address flags in some cases to test them.
                        if self.params.local_size.x() > 1 {
                            address_flags |= ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE;
                        }
                        if self.params.local_size.y() > 1 {
                            address_flags |= ADDRESS_COMMAND_FULLY_BOUND;
                        }
                        let mut dispatch_info = DispatchIndirect2Info::new(DeviceAddressRange {
                            address: indirect_buffer_address + cmd.offset,
                            size: self.params.buffer_size as u64 - cmd.offset,
                        });
                        dispatch_info.address_flags = address_flags;
                        (commands.dispatch_indirect2)(*cmd_buffer, &dispatch_info);
                    }
                }
            }

            descriptor_sets.push(descriptor_set);
            cur_offset += result_block_size;
        }

        // Insert memory barrier
        unsafe {
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            vkdi.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vkdi, *cmd_buffer)?;
        submit_commands_and_wait(vkdi, queue, *cmd_buffer)?;

        // `verifyResultBuffer`
        let alloc = result_buffer.get_allocation();
        invalidate_alloc(vkdi, alloc)?;
        let result_data_ptr = alloc.get_host_ptr();

        let mut all_ok = true;
        for (cmd_ndx, cmd) in self.params.dispatch_commands.iter().enumerate() {
            let src_ptr = unsafe { result_data_ptr.add(cmd_ndx * result_block_size as usize) };
            let num_passed = unsafe { *src_ptr.add(RESULT_BLOCK_NUM_PASSED_OFFSET).cast::<u32>() };

            let ls = self.params.local_size;
            let num_invocations_per_group = (ls.x() * ls.y() * ls.z()) as u32;
            let num_groups = cmd.num_work_groups[0] * cmd.num_work_groups[1] * cmd.num_work_groups[2];
            let expected_count = num_invocations_per_group * num_groups;

            if num_passed != expected_count {
                log::error!(
                    "ERROR: got invalid result for invocation {cmd_ndx}: got numPassed = {num_passed}, expected {expected_count}"
                );
                all_ok = false;
            }
        }

        drop(descriptor_sets);

        if all_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Invalid values in result buffer"))
        }
    }
}

/// `createIndirectComputeDispatchTests`
pub fn create_indirect_compute_dispatch_tests(construction_type: ComputePipelineConstructionType) -> TestCaseGroup {
    use crate::generated::shaders::compute_indirect_dispatch as g;

    let cases: [IndirectDispatchCase; 12] = [
        g::SINGLE_INVOCATION,
        g::MULTIPLE_GROUPS,
        g::MULTIPLE_GROUPS_MULTIPLE_INVOCATIONS,
        g::SMALL_OFFSET,
        g::LARGE_OFFSET,
        g::LARGE_OFFSET_MULTIPLE_INVOCATIONS,
        g::EMPTY_COMMAND,
        g::EMPTY_COMMAND_X,
        g::EMPTY_COMMAND_Y,
        g::EMPTY_COMMAND_Z,
        g::MULTI_DISPATCH,
        g::MULTI_DISPATCH_REUSE_COMMAND,
    ];

    let mut tests = TestCaseGroup::new("indirect_dispatch");

    let case = |params: IndirectDispatchCase, fill_mode: FillMode, use_device_address_commands: bool| {
        let name = if use_device_address_commands {
            format!("{}_device_address", params.name)
        } else {
            params.name.to_string()
        };
        Box::new(IndirectDispatchUploadCase {
            name,
            params,
            fill_mode,
            use_device_address_commands,
        }) as Box<dyn TestCase>
    };

    let mut group_buffer_upload = TestCaseGroup::new("upload_buffer");
    let mut group_buffer_generate = TestCaseGroup::new("gen_in_compute");
    // `computePipelineConstructionType % 2`
    let construction_parity = match construction_type {
        ComputePipelineConstructionType::Pipeline => 0,
        ComputePipelineConstructionType::ShaderObjectSpirv => 1,
        ComputePipelineConstructionType::ShaderObjectBinary => 0,
    };
    for (ndx, params) in cases.into_iter().enumerate() {
        group_buffer_upload.add_child(case(params, FillMode::Upload, false));
        group_buffer_generate.add_child(case(params, FillMode::GenerateInCompute, false));

        // Limit the number of tests repeated for device address commands: every other case in the upload group, and the cases
        // skipped there in the generate group.
        if ndx % 2 == construction_parity {
            group_buffer_upload.add_child(case(params, FillMode::Upload, true));
        } else {
            group_buffer_generate.add_child(case(params, FillMode::GenerateInCompute, true));
        }
    }
    tests.add_child(group_buffer_upload);
    tests.add_child(group_buffer_generate);

    tests
}
