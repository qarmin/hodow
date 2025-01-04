// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryMaintenance7Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The default device enables every feature the physical device offers, so the
// "notrequired" case runs with maintenance7 enabled whenever it is available; its
// acceptance condition (equal to the low 32 bits, or saturated) covers both.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const MIN_TIMESTAMP_VALID_BITS: u32 = 36;
const MAX_TIMESTAMP_VALID_BITS: u32 = 64;

fn timestamp_valid_bits(context: &Context<'_>) -> u32 {
    let queue_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };
    queue_properties[context.get_universal_queue_family_index() as usize].timestamp_valid_bits
}

/// `Maintenance7QueryFeatureTestCase`
struct Maintenance7QueryFeatureTestCase {
    name: &'static str,
    maint7_enabled: bool,
}

impl TestCase for Maintenance7QueryFeatureTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_maintenance7")?;

        if self.maint7_enabled {
            let mut maint7_features = vk::PhysicalDeviceMaintenance7FeaturesKHR::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut maint7_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if maint7_features.maintenance7 == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Requires maintenance 7 feature which is not supported".to_string(),
                ));
            }
        }

        if timestamp_valid_bits(context) == 0 {
            return Err(TestError::NotSupported("Queue does not support timestamps".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(Maintenance7QueryInstance {
            context,
            maint7_enabled: self.maint7_enabled,
        })
    }
}

/// `Maintenance7QueryInstance`
struct Maintenance7QueryInstance<'a> {
    context: &'a Context<'a>,
    maint7_enabled: bool,
}

/// `checkValidBits`
fn check_valid_bits(valid_bits: u32, queue_family_index: u32) -> Result<(), TestError> {
    if !(MIN_TIMESTAMP_VALID_BITS..=MAX_TIMESTAMP_VALID_BITS).contains(&valid_bits) {
        return Err(TestError::Fail(format!(
            "Invalid value for timestampValidBits ({valid_bits}) in queue index {queue_family_index}"
        )));
    }
    Ok(())
}

impl TestInstance for Maintenance7QueryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let device = self.context.get_device();
        let queue_family_index = self.context.get_universal_queue_family_index();
        let queue = self.context.get_universal_queue();

        // recordComands()
        check_valid_bits(timestamp_valid_bits(self.context), queue_family_index)?;

        let query_pool_params = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::TIMESTAMP)
            .query_count(1);
        let query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_params, None) }.vk_check("vkCreateQueryPool")?,
        );
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            device.cmd_reset_query_pool(*cmd_buffer, *query_pool, 0, 1);
            device.cmd_write_timestamp(*cmd_buffer, vk::PipelineStageFlags::TOP_OF_PIPE, *query_pool, 0);
        }
        end_command_buffer(device, *cmd_buffer)?;

        // iterate()
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        let mut ts_get_32_bits = [0u8; 4];
        let mut ts_get_64_bits = [0u8; 8];
        unsafe {
            device
                .get_query_pool_results(*query_pool, 0, 1, &mut ts_get_32_bits, 4, vk::QueryResultFlags::WAIT)
                .vk_check("vkGetQueryPoolResults")?;
            device
                .get_query_pool_results(
                    *query_pool,
                    0,
                    1,
                    &mut ts_get_64_bits,
                    8,
                    vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
                )
                .vk_check("vkGetQueryPoolResults")?;
        }
        let ts_get_32_bits = u32::from_ne_bytes(ts_get_32_bits);
        let ts_get_64_bits = u64::from_ne_bytes(ts_get_64_bits);

        let max_u32_value = u32::MAX as u64;
        if self.maint7_enabled {
            // If maintenance7 is supported, 32 bit queries _must_ be equivalent to the lower 32 bits of the 64 bit query
            if (ts_get_64_bits & max_u32_value) == ts_get_32_bits as u64 {
                return Ok(TestStatus::pass("Pass"));
            }
            log::info!(
                "Maintenance 7 is enabled, but the 32 bit query value does equal the lower 32 bits of the 64 bit query."
            );
        } else {
            if (ts_get_64_bits & max_u32_value) == ts_get_32_bits as u64
                || (ts_get_64_bits > max_u32_value && max_u32_value == ts_get_32_bits as u64)
            {
                return Ok(TestStatus::pass("Pass"));
            }
            log::info!(
                "Maintenance 7 is disabled, but the 32 bit query value does equal the lower 32 bits of the 64 bit query nor is it saturated."
            );
        }

        Ok(TestStatus::fail("Fail"))
    }
}

/// `createQueryMaintenance7Tests`
pub fn create_query_maintenance7_tests() -> TestCaseGroup {
    let mut maint7_tests = TestCaseGroup::new("maintenance7");
    maint7_tests.add_child(Box::new(Maintenance7QueryFeatureTestCase {
        name: "query_32b_wrap_required",
        maint7_enabled: true,
    }) as Box<dyn TestCase>);
    maint7_tests.add_child(Box::new(Maintenance7QueryFeatureTestCase {
        name: "query_32b_wrap_notrequired",
        maint7_enabled: false,
    }) as Box<dyn TestCase>);
    maint7_tests
}
