// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCommandBuffersTests.cpp (`simultaneousUse*` and `badInheritanceInfoTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Every case runs the `compute_increment` shader (an atomic add on a counter) from a command
// buffer and reads the counter back: `record_simul_use_*` execute simultaneous use secondary (and nested secondary) command buffers more than once,
// `bad_inheritance_info_*` begin a primary command buffer with a garbage `pInheritanceInfo`, which must be ignored. Upstream's helper layout also
// binds an unused data buffer next to the counter; only the counter is bound here, the shader reads nothing else.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::api_command_buffers::COMPUTE_INCREMENT;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer, UniqueDescriptorSet};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `BadInheritanceInfoCase`
#[derive(Clone, Copy, PartialEq, Eq)]
enum BadInheritanceInfoCase {
    RandomPtr,
    RandomPtrContinuation,
    RandomDataPtr,
    InvalidStructureType,
    ValidNonsenseType,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    SimultaneousOnePrimary,
    SimultaneousTwoPrimary,
    SimultaneousNested,
    SimultaneousNestedTwice,
    BadInheritance(BadInheritanceInfoCase),
}

struct IncrementSetup<'a> {
    result: BufferWithMemory<'a>,
    _set_layout: Unique<'a, vk::DescriptorSetLayout>,
    _pool: Unique<'a, vk::DescriptorPool>,
    set: UniqueDescriptorSet<'a>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    pipeline: Unique<'a, vk::Pipeline>,
}

impl<'a> IncrementSetup<'a> {
    fn new(context: &'a Context<'a>) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();

        // `ComputeInstanceResultBuffer`: a zeroed counter.
        let result = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(4, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(result.get_allocation().get_host_ptr(), 0, 4) };
        flush_alloc(device, result.get_allocation())?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set = make_descriptor_set(device, *pool, *set_layout)?;
        let buffer_info = make_descriptor_buffer_info(result.get(), 0, vk::WHOLE_SIZE);
        let write = vk::WriteDescriptorSet {
            dst_set: *set,
            dst_binding: 0,
            descriptor_count: 1,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            buffer_info: &buffer_info,
            ..Default::default()
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let set_layouts = [*set_layout];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let module = create_shader_module(device, context.get_binary_collection().get("compute_increment")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        Ok(Self {
            result,
            _set_layout: set_layout,
            _pool: pool,
            set,
            pipeline_layout,
            pipeline,
        })
    }

    /// The commands every case records: bind, dispatch, and make the counter visible to the host.
    fn record_increment(&self, device: &Device, cmd: vk::CommandBuffer, with_barrier: bool) {
        let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *self.pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *self.pipeline_layout,
                0,
                &[*self.set],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, 1, 1, 1);
            if with_barrier {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
    }

    fn read_result(&self, device: &Device) -> Result<u32, TestError> {
        invalidate_alloc(device, self.result.get_allocation())?;
        Ok(unsafe { std::ptr::read_unaligned(self.result.get_allocation().get_host_ptr() as *const u32) })
    }
}

fn begin_secondary_simultaneous(device: &Device, cmd: vk::CommandBuffer) -> Result<(), TestError> {
    let inheritance_info = vk::CommandBufferInheritanceInfo::default();
    let begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::SIMULTANEOUS_USE)
        .inheritance_info(&inheritance_info);
    unsafe { device.begin_command_buffer(cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")
}

fn run(context: &Context<'_>, kind: Kind) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let setup = IncrementSetup::new(context)?;
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

    let primary_level = vk::CommandBufferLevel::PRIMARY;
    let secondary_level = vk::CommandBufferLevel::SECONDARY;

    match kind {
        Kind::SimultaneousOnePrimary | Kind::SimultaneousNested | Kind::SimultaneousNestedTwice => {
            let primary = allocate_command_buffer(device, *cmd_pool, primary_level)?;
            let secondary = allocate_command_buffer(device, *cmd_pool, secondary_level)?;

            // record secondary command buffer
            begin_secondary_simultaneous(device, *secondary)?;
            setup.record_increment(device, *secondary, true);
            end_command_buffer(device, *secondary)?;

            // record another secondary command buffer to nest the other into
            let nested: Option<UniqueCommandBuffer<'_>> = if kind == Kind::SimultaneousOnePrimary {
                None
            } else {
                Some(allocate_command_buffer(device, *cmd_pool, secondary_level)?)
            };
            if let Some(nested) = &nested {
                begin_secondary_simultaneous(device, **nested)?;
                unsafe {
                    device.cmd_execute_commands(**nested, &[*secondary]);
                    if kind == Kind::SimultaneousNested {
                        device.cmd_execute_commands(**nested, &[*secondary]);
                    }
                }
                end_command_buffer(device, **nested)?;
            }

            // record primary command buffer
            begin_command_buffer(device, *primary)?;
            unsafe {
                match &nested {
                    // execute the secondary buffer twice in the same primary
                    None => {
                        device.cmd_execute_commands(*primary, &[*secondary]);
                        device.cmd_execute_commands(*primary, &[*secondary]);
                    }
                    Some(nested) if kind == Kind::SimultaneousNestedTwice => {
                        // execute the nested secondary buffers twice in the same primary buffer
                        device.cmd_execute_commands(*primary, &[**nested]);
                        device.cmd_execute_commands(*primary, &[**nested]);
                    }
                    Some(nested) => device.cmd_execute_commands(*primary, &[**nested]),
                }
            }
            end_command_buffer(device, *primary)?;
            submit_commands_and_wait(device, queue, *primary)?;

            if setup.read_result(device)? == 2 {
                Ok(TestStatus::pass(
                    "Simultaneous Secondary Command Buffer Execution succeeded",
                ))
            } else {
                Ok(TestStatus::fail(
                    "Simultaneous Secondary Command Buffer Execution FAILED",
                ))
            }
        }
        Kind::SimultaneousTwoPrimary => {
            let primary_one = allocate_command_buffer(device, *cmd_pool, primary_level)?;
            let primary_two = allocate_command_buffer(device, *cmd_pool, primary_level)?;
            let secondary = allocate_command_buffer(device, *cmd_pool, secondary_level)?;

            // record secondary command buffer, without the host barrier
            begin_secondary_simultaneous(device, *secondary)?;
            setup.record_increment(device, *secondary, false);
            end_command_buffer(device, *secondary)?;

            // Insert one instance of the same secondary command buffer into two separate primary command buffers
            for primary in [&primary_one, &primary_two] {
                begin_command_buffer(device, **primary)?;
                unsafe { device.cmd_execute_commands(**primary, &[*secondary]) };
                end_command_buffer(device, **primary)?;
            }

            // submit the primary buffers together, the secondary should be executed twice
            let fence = Unique::new(
                device,
                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
            );
            let command_buffers = [*primary_one, *primary_two];
            let submit_info = vk::SubmitInfo::builder().command_buffers(&command_buffers);
            unsafe { device.queue_submit(queue, &[submit_info], *fence) }.vk_check("vkQueueSubmit")?;
            unsafe { device.wait_for_fences(&[*fence], false, u64::MAX) }.vk_check("vkWaitForFences")?;

            if setup.read_result(device)? == 2 {
                Ok(TestStatus::pass(
                    "Simultaneous Secondary Command Buffer Execution succeeded",
                ))
            } else {
                Ok(TestStatus::fail(
                    "Simultaneous Secondary Command Buffer Execution FAILED",
                ))
            }
        }
        Kind::BadInheritance(test_case) => {
            let primary = allocate_command_buffer(device, *cmd_pool, primary_level)?;

            // Structures used in different test types.
            let mut inheritance_info = std::mem::MaybeUninit::<vk::CommandBufferInheritanceInfo>::zeroed();
            let valid_nonsense_structure = vk::BufferCreateInfo::builder()
                .size(1024)
                .usage(vk::BufferUsageFlags::TRANSFER_DST)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .build();
            // sType followed by a pNext pointer, as every structure starts
            let mut invalid_structure = [0u8; 16];

            let mut begin_info = vk::CommandBufferBeginInfo::default();
            match test_case {
                BadInheritanceInfoCase::RandomPtr | BadInheritanceInfoCase::RandomPtrContinuation => {
                    let mut rnd = Random::new(1_602_600_778);
                    // Fill the pointer value with pseudorandom garbage.
                    let mut pointer_bytes = [0u8; std::mem::size_of::<usize>()];
                    for byte in &mut pointer_bytes {
                        *byte = rnd.get_uint8();
                    }
                    begin_info.inheritance_info =
                        usize::from_ne_bytes(pointer_bytes) as *const vk::CommandBufferInheritanceInfo;

                    // Try to trick the implementation into reading pInheritanceInfo one more way.
                    if test_case == BadInheritanceInfoCase::RandomPtrContinuation {
                        begin_info.flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
                    }
                }
                BadInheritanceInfoCase::RandomDataPtr => {
                    let mut rnd = Random::new(1_602_601_141);
                    // Fill the inheritance info with random data.
                    let bytes = unsafe {
                        std::slice::from_raw_parts_mut(
                            inheritance_info.as_mut_ptr().cast::<u8>(),
                            std::mem::size_of::<vk::CommandBufferInheritanceInfo>(),
                        )
                    };
                    for byte in bytes {
                        *byte = rnd.get_uint8();
                    }
                    begin_info.inheritance_info = inheritance_info.as_ptr();
                }
                BadInheritanceInfoCase::InvalidStructureType => {
                    let mut rnd = Random::new(1_602_658_515);
                    invalid_structure[0..4].copy_from_slice(&i32::MAX.to_ne_bytes());
                    // Fill the pNext pointer with random data.
                    for byte in &mut invalid_structure[8..16] {
                        *byte = rnd.get_uint8();
                    }
                    begin_info.inheritance_info = invalid_structure.as_ptr().cast::<vk::CommandBufferInheritanceInfo>();
                }
                BadInheritanceInfoCase::ValidNonsenseType => {
                    begin_info.inheritance_info =
                        (&raw const valid_nonsense_structure).cast::<vk::CommandBufferInheritanceInfo>();
                }
            }

            unsafe { device.begin_command_buffer(*primary, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
            setup.record_increment(device, *primary, true);
            end_command_buffer(device, *primary)?;
            submit_commands_and_wait(device, queue, *primary)?;

            // Make sure the command buffer was run.
            let result_count = setup.read_result(device)?;
            if result_count != 1 {
                return Ok(TestStatus::fail(format!(
                    "Invalid value found in results buffer (expected value 1u but found {result_count})"
                )));
            }
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn check_simultaneous_use(_context: &Context<'_>) -> Result<(), TestError> {
    Ok(())
}

fn check_nested(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_nested_command_buffer")?;
    let mut features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    if features.nested_command_buffer == vk::FALSE {
        return Err(TestError::NotSupported(
            "nestedCommandBuffer is not supported".to_string(),
        ));
    }
    if features.nested_command_buffer_simultaneous_use == vk::FALSE {
        return Err(TestError::NotSupported(
            "nestedCommandBufferSimultaneousUse is not supported".to_string(),
        ));
    }
    Ok(())
}

struct SimultaneousCase {
    name: &'static str,
    kind: Kind,
}

impl TestCase for SimultaneousCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.kind {
            Kind::SimultaneousNested | Kind::SimultaneousNestedTwice => check_nested(context),
            _ => check_simultaneous_use(context),
        }
    }

    fn programs(&self) -> BinaryCollection {
        COMPUTE_INCREMENT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SimultaneousInstance {
            context,
            kind: self.kind,
        })
    }
}

struct SimultaneousInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

impl TestInstance for SimultaneousInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run(self.context, self.kind)
    }
}

/// The `record_simul_use_*` and `bad_inheritance_info_*` cases of `createCommandBuffersTests`.
pub fn add_simultaneous_use_tests(group: &mut TestCaseGroup) {
    for (name, kind) in [
        ("record_simul_use_secondary_one_primary", Kind::SimultaneousOnePrimary),
        ("record_simul_use_secondary_two_primary", Kind::SimultaneousTwoPrimary),
        ("record_simul_use_nested", Kind::SimultaneousNested),
        ("record_simul_use_twice_nested", Kind::SimultaneousNestedTwice),
        (
            "bad_inheritance_info_random",
            Kind::BadInheritance(BadInheritanceInfoCase::RandomPtr),
        ),
        (
            "bad_inheritance_info_random_cont",
            Kind::BadInheritance(BadInheritanceInfoCase::RandomPtrContinuation),
        ),
        (
            "bad_inheritance_info_random_data",
            Kind::BadInheritance(BadInheritanceInfoCase::RandomDataPtr),
        ),
        (
            "bad_inheritance_info_invalid_type",
            Kind::BadInheritance(BadInheritanceInfoCase::InvalidStructureType),
        ),
        (
            "bad_inheritance_info_valid_nonsense_type",
            Kind::BadInheritance(BadInheritanceInfoCase::ValidNonsenseType),
        ),
    ] {
        group.add_child(Box::new(SimultaneousCase { name, kind }) as Box<dyn TestCase>);
    }
}
