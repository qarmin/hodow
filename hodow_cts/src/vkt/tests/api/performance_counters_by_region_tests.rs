// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiPerformanceCountersByRegionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::add_function_case;
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome};
use crate::vkt::{Context, TestCaseGroup};

type Counters = Vec<vk::PerformanceCounterARM>;
type CounterDescs = Vec<vk::PerformanceCounterDescriptionARM>;

fn desc_flags(desc: &vk::PerformanceCounterDescriptionARM) -> u32 {
    desc.flags.bits()
}

fn set_desc_flags(desc: &mut vk::PerformanceCounterDescriptionARM, value: u32) {
    // The flag type has no bits defined, so no constructor accepts an arbitrary pattern
    desc.flags = unsafe { std::mem::transmute::<u32, vk::PerformanceCounterDescriptionFlagsARM>(value) };
}

/// The raw call: a null pointer stands for "not requested", which the safe wrapper cannot express.
fn enumerate(
    context: &Context<'_>,
    count: &mut u32,
    counters: *mut vk::PerformanceCounterARM,
    descs: *mut vk::PerformanceCounterDescriptionARM,
) -> vk::Result {
    let command = context
        .get_instance()
        .commands()
        .enumerate_physical_device_queue_family_performance_counters_by_region_arm;
    unsafe { command(context.get_physical_device(), 0, count, counters, descs) }
}

/// `checkCounterEnumeration`
fn check_counter_enumeration(rc: &mut ResultCollector, perf_counters: &Counters, count: u32, dummy_value: u32) {
    for counter in &perf_counters[..count as usize] {
        if counter.counter_id == dummy_value {
            rc.fail("Too few counters were written.");
        }
    }

    if perf_counters[count as usize].counter_id != dummy_value {
        rc.fail("Counters beyond the requested limit were overwritten.");
    }
}

/// `checkCounterDescEnumeration`
fn check_counter_desc_enumeration(
    rc: &mut ResultCollector,
    perf_counter_descs: &CounterDescs,
    count: u32,
    dummy_value: u32,
) {
    for desc in &perf_counter_descs[..count as usize] {
        if desc_flags(desc) == dummy_value {
            rc.fail("Too few counter descriptions were written.");
            break;
        }
    }

    if desc_flags(&perf_counter_descs[count as usize]) != dummy_value {
        rc.fail("Counter descriptions beyond the requested limit were overwritten.");
    }
}

/// `resetCounters`
fn reset_counters(perf_counters: &mut Counters, perf_counter_descs: &mut CounterDescs, dummy_value: u32) {
    for counter in perf_counters.iter_mut() {
        counter.s_type = vk::StructureType::PERFORMANCE_COUNTER_ARM;
        counter.counter_id = dummy_value;
    }

    for desc in perf_counter_descs.iter_mut() {
        desc.s_type = vk::StructureType::PERFORMANCE_COUNTER_DESCRIPTION_ARM;
        set_desc_flags(desc, dummy_value);
        desc.name = Default::default();
    }
}

/// `findDummyValue`
fn find_dummy_value(
    context: &Context<'_>,
    perf_counters: &mut Counters,
    perf_counter_descs: &mut CounterDescs,
    mut count: u32,
) -> Result<u32, TestError> {
    let result = enumerate(
        context,
        &mut count,
        perf_counters.as_mut_ptr(),
        perf_counter_descs.as_mut_ptr(),
    );
    check_call(
        result,
        "vkEnumeratePhysicalDeviceQueueFamilyPerformanceCountersByRegionARM",
    )?;

    let mut dummy_value = u32::MAX;
    while dummy_value > 0 {
        let found = perf_counters.iter().any(|c| c.counter_id == dummy_value)
            || perf_counter_descs.iter().any(|d| desc_flags(d) == dummy_value);
        if !found {
            break;
        }
        dummy_value -= 1;
    }

    debug_assert!(dummy_value != 0);
    Ok(dummy_value)
}

fn check_call(result: vk::Result, what: &str) -> Result<(), TestError> {
    if result == vk::Result::SUCCESS {
        Ok(())
    } else {
        Err(TestError::Fail(format!("{what} returned {result:?}")))
    }
}

/// `APIPerformanceCountersByRegionRenderPassBasicTestCase::checkSupport`
fn enumerate_counters_check_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_ARM_performance_counters_by_region")?;

    let mut by_region = vk::PhysicalDevicePerformanceCountersByRegionFeaturesARM::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut by_region);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };

    if by_region.performance_counters_by_region == vk::FALSE {
        return Err(TestError::NotSupported(
            "VkPhysicalDevicePerformanceCountersByRegionFeaturesARM is not supported".to_string(),
        ));
    }
    Ok(())
}

/// `PerformanceCountersByRegionRenderPassBasicTestInstance::iterate`
fn enumerate_counters(context: &Context<'_>) -> TestOutcome {
    let mut rc = ResultCollector::new("");

    // Get the count of counters supported.
    let mut perf_counter_count = 0u32;
    enumerate(
        context,
        &mut perf_counter_count,
        std::ptr::null_mut(),
        std::ptr::null_mut(),
    );

    if perf_counter_count == 0 {
        rc.fail("No counters found.");
        return Ok(rc.to_status());
    }

    let mut perf_counters: Counters = vec![vk::PerformanceCounterARM::default(); perf_counter_count as usize + 1];
    let mut perf_counter_descs: CounterDescs =
        vec![vk::PerformanceCounterDescriptionARM::default(); perf_counter_count as usize + 1];

    // A value not used for counterId or flags, to use when detecting which counter structs were written.
    let dummy_value = find_dummy_value(context, &mut perf_counters, &mut perf_counter_descs, perf_counter_count)?;

    if perf_counter_count > 1 {
        // Tests with space for fewer than the total number of counters.
        for (want_counters, want_descs) in [(true, false), (false, true), (true, true)] {
            let mut count = 1u32;
            reset_counters(&mut perf_counters, &mut perf_counter_descs, dummy_value);
            let counters_ptr = if want_counters {
                perf_counters.as_mut_ptr()
            } else {
                std::ptr::null_mut()
            };
            let descs_ptr = if want_descs {
                perf_counter_descs.as_mut_ptr()
            } else {
                std::ptr::null_mut()
            };
            let result = enumerate(context, &mut count, counters_ptr, descs_ptr);
            if count > 1 {
                rc.fail("Unexpected count when requesting few counters.");
            } else {
                if want_counters {
                    check_counter_enumeration(&mut rc, &perf_counters, count, dummy_value);
                }
                if want_descs {
                    check_counter_desc_enumeration(&mut rc, &perf_counter_descs, count, dummy_value);
                }
            }

            if result != vk::Result::INCOMPLETE {
                rc.fail("Expected VK_INCOMPLETE.");
            }
        }
    }

    // Tests with space for the total number of counters, then for one more than needed.
    let name = "vkEnumeratePhysicalDeviceQueueFamilyPerformanceCountersByRegionARM";
    for (want_counters, want_descs, extra) in [(true, false, 0u32), (false, true, 0), (true, true, 0), (true, true, 1)]
    {
        let mut count = perf_counter_count + extra;
        reset_counters(&mut perf_counters, &mut perf_counter_descs, dummy_value);
        let counters_ptr = if want_counters {
            perf_counters.as_mut_ptr()
        } else {
            std::ptr::null_mut()
        };
        let descs_ptr = if want_descs {
            perf_counter_descs.as_mut_ptr()
        } else {
            std::ptr::null_mut()
        };
        check_call(enumerate(context, &mut count, counters_ptr, descs_ptr), name)?;

        if count != perf_counter_count {
            rc.fail("Unexpected number of performance counters returned.");
        } else {
            if want_counters {
                check_counter_enumeration(&mut rc, &perf_counters, perf_counter_count, dummy_value);
            }
            if want_descs {
                check_counter_desc_enumeration(&mut rc, &perf_counter_descs, perf_counter_count, dummy_value);
            }
        }
    }

    Ok(rc.to_status())
}

/// `createRenderPassPerformanceCountersByRegionApiTests`
pub fn create_performance_counters_by_region_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("performance_counters_by_region");
    add_function_case(
        &mut group,
        "enumerate_counters",
        enumerate_counters_check_support,
        enumerate_counters,
    );
    group
}
