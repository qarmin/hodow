// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/conditional_rendering/vktConditionalDispatchTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream runs `queuePass` once per queue of a `MultiQueueRunnerTestInstance`. Here it runs
// once, on the universal queue, or on the dedicated compute queue for the `compute_queue`
// group when the device has one.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, ExtConditionalRenderingExtensionDeviceCommands};

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
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
use crate::vkt::tests::conditional_rendering::test_util::{
    ConditionalBufferMemory, ConditionalData, TESTS_DATA, begin_conditional_rendering,
    check_conditional_rendering_capabilities, create_conditional_rendering_buffer,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `DispatchCommandType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DispatchCommandType {
    Dispatch,
    DispatchIndirect,
    DispatchBase,
}

const ALL_COMMAND_TYPES: [DispatchCommandType; 3] = [
    DispatchCommandType::Dispatch,
    DispatchCommandType::DispatchIndirect,
    DispatchCommandType::DispatchBase,
];

/// `getDispatchCommandTypeName`
fn get_dispatch_command_type_name(command: DispatchCommandType) -> &'static str {
    match command {
        DispatchCommandType::Dispatch => "dispatch",
        DispatchCommandType::DispatchIndirect => "dispatch_indirect",
        DispatchCommandType::DispatchBase => "dispatch_base",
    }
}

/// `ConditionalTestSpec`
#[derive(Clone, Copy)]
struct ConditionalTestSpec {
    command: DispatchCommandType,
    num_calls: u32,
    conditional_data: ConditionalData,
    compute_queue: bool,
}

/// `ConditionalDispatchTest`
struct ConditionalDispatchTest {
    name: String,
    test_spec: ConditionalTestSpec,
}

impl TestCase for ConditionalDispatchTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_conditional_rendering_capabilities(context, &self.test_spec.conditional_data)?;

        if self.test_spec.command == DispatchCommandType::DispatchBase {
            context.require_device_functionality("VK_KHR_device_group")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::conditional_rendering_dispatch::CONDITIONAL_DISPATCH.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConditionalDispatchTestInstance {
            context,
            test_spec: self.test_spec,
        })
    }
}

/// `ConditionalDispatchTestInstance`
struct ConditionalDispatchTestInstance<'a> {
    context: &'a Context<'a>,
    test_spec: ConditionalTestSpec,
}

impl<'a> ConditionalDispatchTestInstance<'a> {
    /// `recordDispatch`
    fn record_dispatch(&self, cmd_buffer: vk::CommandBuffer, indirect_buffer: &BufferWithMemory<'_>) {
        let device = self.context.get_device();
        for _ in 0..self.test_spec.num_calls {
            unsafe {
                match self.test_spec.command {
                    DispatchCommandType::Dispatch => device.cmd_dispatch(cmd_buffer, 1, 1, 1),
                    DispatchCommandType::DispatchIndirect => {
                        device.cmd_dispatch_indirect(cmd_buffer, indirect_buffer.get(), 0)
                    }
                    DispatchCommandType::DispatchBase => device.cmd_dispatch_base(cmd_buffer, 0, 0, 0, 1, 1, 1),
                }
            }
        }
    }

    /// `queuePass`
    fn queue_pass(&self, queue: vk::Queue, queue_family_index: u32) -> TestOutcome {
        let device = self.context.get_device();
        let allocator = self.context.get_default_allocator();
        let conditional_data = self.test_spec.conditional_data;

        // Create a buffer and host-visible memory for it
        let buffer_size_bytes = std::mem::size_of::<u32>() as u64;
        let output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = output_buffer.get_allocation();
            unsafe { *alloc.get_host_ptr().cast::<u32>() = 0 };
            flush_alloc(device, alloc)?;
        }

        // Create descriptor set
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let descriptor_info = make_descriptor_buffer_info(output_buffer.get(), 0, buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_info,
            )
            .update(device);

        // Setup pipeline
        let mut pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            self.context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*descriptor_set_layout);
        pipeline.build_pipeline()?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let secondary_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let nested_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

        // Create indirect buffer
        let dispatch_command: [u32; 3] = [1, 1, 1];
        let indirect_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                std::mem::size_of_val(&dispatch_command) as u64,
                vk::BufferUsageFlags::INDIRECT_BUFFER | vk::BufferUsageFlags::STORAGE_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                dispatch_command.as_ptr(),
                indirect_buffer.get_allocation().get_host_ptr().cast::<u32>(),
                dispatch_command.len(),
            );
        }
        flush_alloc(device, indirect_buffer.get_allocation())?;

        // Start recording commands
        begin_command_buffer(device, *cmd_buffer)?;

        let mut target_cmd_buffer = *cmd_buffer;
        let use_secondary_cmd_buffer =
            conditional_data.condition_inherited || conditional_data.condition_in_secondary_command_buffer;

        if use_secondary_cmd_buffer {
            let mut conditional_rendering_inheritance_info =
                vk::CommandBufferInheritanceConditionalRenderingInfoEXT::builder()
                    .conditional_rendering_enable(conditional_data.condition_inherited);
            let inheritance_info =
                vk::CommandBufferInheritanceInfo::builder().push_next(&mut conditional_rendering_inheritance_info);
            let command_buffer_begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
                .inheritance_info(&inheritance_info);

            if conditional_data.secondary_command_buffer_nested {
                unsafe { device.begin_command_buffer(*nested_cmd_buffer, &command_buffer_begin_info) }
                    .vk_check("vkBeginCommandBuffer")?;
            }
            unsafe { device.begin_command_buffer(*secondary_cmd_buffer, &command_buffer_begin_info) }
                .vk_check("vkBeginCommandBuffer")?;

            target_cmd_buffer = *secondary_cmd_buffer;
        }

        pipeline.bind(target_cmd_buffer);
        unsafe {
            device.cmd_bind_descriptor_sets(
                target_cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                pipeline.get_pipeline_layout(),
                0,
                &[*descriptor_set],
                &[],
            );
        }

        let conditional_buffer =
            create_conditional_rendering_buffer(self.context, &conditional_data, queue, queue_family_index)?;

        if conditional_data.condition_in_secondary_command_buffer {
            begin_conditional_rendering(device, *secondary_cmd_buffer, &conditional_buffer, &conditional_data);
            self.record_dispatch(*secondary_cmd_buffer, &indirect_buffer);
            unsafe { device.cmd_end_conditional_rendering_ext(*secondary_cmd_buffer) };
            end_command_buffer(device, *secondary_cmd_buffer)?;
            if conditional_data.secondary_command_buffer_nested {
                unsafe { device.cmd_execute_commands(*nested_cmd_buffer, &[*secondary_cmd_buffer]) };
                end_command_buffer(device, *nested_cmd_buffer)?;
            }
        } else if conditional_data.condition_inherited {
            self.record_dispatch(*secondary_cmd_buffer, &indirect_buffer);
            end_command_buffer(device, *secondary_cmd_buffer)?;
            if conditional_data.secondary_command_buffer_nested {
                unsafe { device.cmd_execute_commands(*nested_cmd_buffer, &[*secondary_cmd_buffer]) };
                end_command_buffer(device, *nested_cmd_buffer)?;
            }
        }

        let executed_secondary = if conditional_data.secondary_command_buffer_nested {
            *nested_cmd_buffer
        } else {
            *secondary_cmd_buffer
        };

        if conditional_data.condition_in_primary_command_buffer {
            begin_conditional_rendering(device, *cmd_buffer, &conditional_buffer, &conditional_data);

            if conditional_data.condition_inherited {
                unsafe { device.cmd_execute_commands(*cmd_buffer, &[executed_secondary]) };
            } else {
                self.record_dispatch(*cmd_buffer, &indirect_buffer);
            }

            unsafe { device.cmd_end_conditional_rendering_ext(*cmd_buffer) };
        } else if use_secondary_cmd_buffer {
            unsafe { device.cmd_execute_commands(*cmd_buffer, &[executed_secondary]) };
        }

        let output_buffer_memory_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                *cmd_buffer,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[output_buffer_memory_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        // Check result
        let output_buffer_allocation = output_buffer.get_allocation();
        invalidate_alloc(device, output_buffer_allocation)?;
        let result = unsafe { *output_buffer_allocation.get_host_ptr().cast::<u32>() };

        let expected_result = if conditional_data.expect_command_execution {
            self.test_spec.num_calls
        } else {
            0
        };
        if result != expected_result {
            log::error!("Counter is {result}, expected {expected_result}");
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for ConditionalDispatchTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // A dedicated compute family is used when asked for and present; the universal
        // queue also supports compute, so a device without one still runs the case.
        if self.test_spec.compute_queue
            && let Some((queue, family_index)) = self.context.get_compute_queue()
        {
            return self.queue_pass(queue, family_index);
        }
        self.queue_pass(
            self.context.get_universal_queue(),
            self.context.get_universal_queue_family_index(),
        )
    }
}

#[derive(Clone, Copy)]
enum ConditionLocation {
    PrimaryFlat,
    PrimaryWithSecondary,
    SecondaryNormal,
    SecondaryInherited,
}

const CONDITION_LOCATIONS: [(ConditionLocation, &str); 4] = [
    (ConditionLocation::PrimaryFlat, "primary"),
    (ConditionLocation::PrimaryWithSecondary, "inherited"),
    (ConditionLocation::SecondaryNormal, "secondary"),
    (ConditionLocation::SecondaryInherited, "secondary_inherited"),
];

fn apply_location(data: &mut ConditionalData, location: ConditionLocation) {
    let (primary, secondary, inherited) = match location {
        ConditionLocation::PrimaryFlat => (true, false, false),
        ConditionLocation::PrimaryWithSecondary => (true, false, true),
        ConditionLocation::SecondaryNormal => (false, true, false),
        ConditionLocation::SecondaryInherited => (false, true, true),
    };
    data.condition_in_primary_command_buffer = primary;
    data.condition_in_secondary_command_buffer = secondary;
    data.condition_inherited = inherited;
}

fn dispatch_case(
    name: &str,
    command: DispatchCommandType,
    num_calls: u32,
    conditional_data: ConditionalData,
    compute_queue: bool,
) -> Box<dyn TestCase> {
    Box::new(ConditionalDispatchTest {
        name: name.to_string(),
        test_spec: ConditionalTestSpec {
            command,
            num_calls,
            conditional_data,
            compute_queue,
        },
    })
}

/// `ConditionalDispatchTests::init`
pub fn create_conditional_dispatch_tests() -> TestCaseGroup {
    let mut tests = TestCaseGroup::new("dispatch");

    for condition_data in TESTS_DATA.iter().filter(|d| !d.clear_in_render_pass) {
        let mut root_group = TestCaseGroup::new(condition_data.to_name());
        for command in ALL_COMMAND_TYPES {
            root_group.add_child(dispatch_case(
                get_dispatch_command_type_name(command),
                command,
                3,
                *condition_data,
                false,
            ));
        }
        tests.add_child(root_group);
    }

    // Tests verifying the condition is interpreted as a 32-bit value.
    {
        let mut condition_size_group = TestCaseGroup::new("condition_size");

        // (value, padding, execution, name)
        let condition_value_results: [(u32, bool, bool, &str); 5] = [
            (0x0000_0001, false, true, "first_byte"),
            (0x0000_0100, false, true, "second_byte"),
            (0x0001_0000, false, true, "third_byte"),
            (0x0100_0000, false, true, "fourth_byte"),
            (0, true, false, "padded_zero"),
        ];

        for (location, subcase_name) in CONDITION_LOCATIONS {
            let mut subcase_group = TestCaseGroup::new(subcase_name);

            let mut conditional_data = ConditionalData::none();
            apply_location(&mut conditional_data, location);

            for (value, padding, execution, name) in condition_value_results {
                conditional_data.condition_value = value;
                conditional_data.pad_condition_value = padding;
                conditional_data.expect_command_execution = execution;
                subcase_group.add_child(dispatch_case(
                    name,
                    DispatchCommandType::Dispatch,
                    1,
                    conditional_data,
                    false,
                ));
            }

            condition_size_group.add_child(subcase_group);
        }

        tests.add_child(condition_size_group);
    }

    // Tests checking the buffer allocation offset is applied correctly when reading the condition.
    {
        let mut alloc_offset_group = TestCaseGroup::new("alloc_offset");

        let active_cases = [(false, "zero"), (true, "nonzero")];
        let memory_type_cases = [
            (ConditionalBufferMemory::Local, "device_local"),
            (ConditionalBufferMemory::Host, "host_visible"),
        ];

        for (location, location_name) in CONDITION_LOCATIONS {
            let mut location_sub_group = TestCaseGroup::new(location_name);

            for (active, active_name) in active_cases {
                let mut active_sub_group = TestCaseGroup::new(active_name);

                for (memory_type, memory_name) in memory_type_cases {
                    let mut conditional_data = ConditionalData::none();
                    conditional_data.allocation_offset = true;
                    conditional_data.memory_type = memory_type;
                    apply_location(&mut conditional_data, location);
                    conditional_data.condition_value = u32::from(active);
                    conditional_data.expect_command_execution = active;

                    active_sub_group.add_child(dispatch_case(
                        memory_name,
                        DispatchCommandType::Dispatch,
                        1,
                        conditional_data,
                        false,
                    ));
                }

                location_sub_group.add_child(active_sub_group);
            }

            alloc_offset_group.add_child(location_sub_group);
        }

        tests.add_child(alloc_offset_group);
    }

    // Compute queue tests.
    {
        let mut compute_queue_group = TestCaseGroup::new("compute_queue");

        // (value, inverted, execution expected, name)
        let condition_value_results: [(u32, bool, bool, &str); 4] = [
            (0, false, false, "condition_zero"),
            (0, true, true, "condition_one"),
            (1, false, true, "condition_inv_zero"),
            (1, true, false, "condition_inv_one"),
        ];

        for (location, subcase_name) in CONDITION_LOCATIONS {
            let mut subcase_group = TestCaseGroup::new(subcase_name);

            let mut conditional_data = ConditionalData::none();
            apply_location(&mut conditional_data, location);

            for device_local in [false, true] {
                for indirect in [false, true] {
                    for (value, inverted, execution_expected, name) in condition_value_results {
                        conditional_data.condition_value = value;
                        conditional_data.condition_inverted = inverted;
                        conditional_data.expect_command_execution = execution_expected;
                        conditional_data.memory_type = if device_local {
                            ConditionalBufferMemory::Local
                        } else {
                            ConditionalBufferMemory::Host
                        };

                        let command = if indirect {
                            DispatchCommandType::DispatchIndirect
                        } else {
                            DispatchCommandType::Dispatch
                        };
                        let test_name = format!(
                            "{name}{}{}",
                            if indirect { "_indirect_dispatch" } else { "" },
                            if device_local { "_device_local" } else { "" }
                        );
                        subcase_group.add_child(dispatch_case(&test_name, command, 1, conditional_data, true));
                    }
                }
            }

            compute_queue_group.add_child(subcase_group);
        }

        tests.add_child(compute_queue_group);
    }

    tests
}
