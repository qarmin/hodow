// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineTimestampTests.cpp (the `calibrated` group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Linux host clocks only (CLOCK_MONOTONIC and CLOCK_MONOTONIC_RAW through
// `clock_gettime`, declared here because the crate links no libc binding); the Win32 query performance counter domain is not
// ported. The calibrated timestamp commands come from VK_KHR_calibrated_timestamps when the device has it, VK_EXT_ otherwise.

use std::collections::BTreeSet;
use std::time::{Duration, Instant};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtCalibratedTimestampsExtensionDeviceCommands, ExtCalibratedTimestampsExtensionInstanceCommands,
    KhrCalibratedTimestampsExtensionDeviceCommands, KhrCalibratedTimestampsExtensionInstanceCommands,
};

use crate::tcu::{self, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool};
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NO_PROGRAMS: BinaryCollection = BinaryCollection::new(&[]);

const BATCH_TIME_LIMIT_NANOS: u64 = 1_000_000_000; // 1 sec.
const DEVIATION_ERROR_LIMIT_NANOS: u64 = 100_000_000; // 100 ms.
const DEVIATION_WARNING_LIMIT_NANOS: u64 = 50_000_000; // 50 ms.
const DEFAULT_TOLERANCE_NANOS: u64 = 100_000_000; // 100 ms.
const NANOSECONDS_PER_MILLISECOND: u64 = 1_000_000;

const MIN_TIMESTAMP_VALID_BITS: u32 = 36;
const MAX_TIMESTAMP_VALID_BITS: u32 = 64;

#[repr(C)]
struct Timespec {
    tv_sec: std::ffi::c_long,
    tv_nsec: std::ffi::c_long,
}

unsafe extern "C" {
    fn clock_gettime(clock_id: std::ffi::c_int, tp: *mut Timespec) -> std::ffi::c_int;
}

const CLOCK_MONOTONIC: std::ffi::c_int = 1;
const CLOCK_MONOTONIC_RAW: std::ffi::c_int = 4;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    DevDomain,
    HostDomain,
    Calibration,
}

/// `getTimestampMask`: the number of valid bits of the universal queue is checked on the way.
fn get_timestamp_mask(context: &Context<'_>) -> Result<u64, TestError> {
    let queue_family_index = context.get_universal_queue_family_index();
    let queue_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };
    let valid_bits = queue_properties[queue_family_index as usize].timestamp_valid_bits;

    if !(MIN_TIMESTAMP_VALID_BITS..=MAX_TIMESTAMP_VALID_BITS).contains(&valid_bits) {
        return Err(TestError::Fail(format!(
            "Invalid value for timestampValidBits ({valid_bits}) in queue index {queue_family_index}"
        )));
    }
    Ok(if valid_bits == MAX_TIMESTAMP_VALID_BITS {
        u64::MAX
    } else {
        (1u64 << valid_bits) - 1
    })
}

/// `checkTimestampBits`
fn check_timestamp_bits(timestamp: u64, mask: u64) -> Result<(), TestError> {
    // timestampValidBits is the unsigned integer count of meaningful bits in the timestamps written via vkCmdWriteTimestamp. Bits
    // outside the valid range are guaranteed to be zeros.
    if timestamp > mask {
        return Err(TestError::Fail(format!(
            "Invalid device timestamp value 0x{timestamp:x} according to device timestamp mask 0x{mask:x}"
        )));
    }
    Ok(())
}

fn use_khr_extension(context: &Context<'_>) -> bool {
    context.is_device_functionality_supported("VK_KHR_calibrated_timestamps")
}

fn calibrateable_time_domains(context: &Context<'_>) -> Result<Vec<vk::TimeDomainKHR>, TestError> {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();
    if use_khr_extension(context) {
        unsafe { instance.get_physical_device_calibrateable_time_domains_khr(physical_device) }
            .vk_check("vkGetPhysicalDeviceCalibrateableTimeDomainsKHR")
    } else {
        unsafe { instance.get_physical_device_calibrateable_time_domains_ext(physical_device) }
            .vk_check("vkGetPhysicalDeviceCalibrateableTimeDomainsEXT")
    }
}

/// `getDomainSubset`: the domains in both lists, ordered by value.
fn get_domain_subset(available: &[vk::TimeDomainKHR], interesting: &[vk::TimeDomainKHR]) -> Vec<vk::TimeDomainKHR> {
    let available_set: BTreeSet<i32> = available.iter().map(|d| d.as_raw()).collect();
    let interesting_set: BTreeSet<i32> = interesting.iter().map(|d| d.as_raw()).collect();
    available_set
        .intersection(&interesting_set)
        .map(|&raw| vk::TimeDomainKHR::from_raw(raw))
        .collect()
}

/// `getDeviceHostDomains`
fn get_device_host_domains(
    context: &Context<'_>,
) -> Result<(Vec<vk::TimeDomainKHR>, Vec<vk::TimeDomainKHR>), TestError> {
    let domains = calibrateable_time_domains(context)?;

    // Find the dev domain.
    let dev_domains = get_domain_subset(&domains, &[vk::TimeDomainKHR::DEVICE]);

    // Find the host domain.
    let host_domains = get_domain_subset(
        &domains,
        &[
            vk::TimeDomainKHR::CLOCK_MONOTONIC_RAW,
            vk::TimeDomainKHR::CLOCK_MONOTONIC,
        ],
    );
    Ok((dev_domains, host_domains))
}

struct CalibratedTimestampTestCase {
    name: &'static str,
    kind: Kind,
}

impl TestCase for CalibratedTimestampTestCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if !context.is_device_functionality_supported("VK_KHR_calibrated_timestamps")
            && !context.is_device_functionality_supported("VK_EXT_calibrated_timestamps")
        {
            return Err(TestError::NotSupported(
                "VK_KHR_calibrated_timestamps and VK_EXT_calibrated_timestamps are not supported".to_string(),
            ));
        }

        if calibrateable_time_domains(context)?.is_empty() {
            return Err(TestError::NotSupported(
                "No calibrateable time domains found".to_string(),
            ));
        }

        let queue_family_index = context.get_universal_queue_family_index();
        let queue_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_queue_family_properties(context.get_physical_device())
        };
        if queue_properties[queue_family_index as usize].timestamp_valid_bits == 0 {
            return Err(TestError::NotSupported("Queue does not support timestamps".to_string()));
        }

        let (dev_domains, host_domains) = get_device_host_domains(context)?;

        if matches!(self.kind, Kind::DevDomain | Kind::Calibration) && dev_domains.is_empty() {
            return Err(TestError::NotSupported(
                "No suitable device time domains found".to_string(),
            ));
        }
        if matches!(self.kind, Kind::HostDomain | Kind::Calibration) && host_domains.is_empty() {
            return Err(TestError::NotSupported(
                "No suitable host time domains found".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        NO_PROGRAMS
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CalibratedTimestampTestInstance {
            context,
            kind: self.kind,
        })
    }
}

struct CalibratedTimestamp {
    timestamp: u64,
    deviation: u64,
}

/// `CalibratedTimestampTestInstance` with the state its constructor builds.
struct CalibratedTimestampTestInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

struct Fixture<'a> {
    context: &'a Context<'a>,
    timestamp_period: f32,
    dev_domains: Vec<vk::TimeDomainKHR>,
    host_domains: Vec<vk::TimeDomainKHR>,
    quality_message: String,
    dev_timestamp_mask: u64,
    query_pool: Unique<'a, vk::QueryPool>,
    cmd_buffer: UniqueCommandBuffer<'a>,
    _cmd_pool: Unique<'a, vk::CommandPool>,
}

/// `domainName`
fn domain_name(domain: vk::TimeDomainKHR) -> &'static str {
    if domain == vk::TimeDomainKHR::DEVICE {
        "Device Domain"
    } else if domain == vk::TimeDomainKHR::CLOCK_MONOTONIC {
        "Monotonic Clock"
    } else if domain == vk::TimeDomainKHR::CLOCK_MONOTONIC_RAW {
        "Raw Monotonic Clock"
    } else if domain == vk::TimeDomainKHR::QUERY_PERFORMANCE_COUNTER {
        "Query Performance Counter"
    } else {
        "Unknown Time Domain"
    }
}

/// `getHostNativeTimestamp`
fn get_host_native_timestamp(host_domain: vk::TimeDomainKHR) -> Result<u64, TestError> {
    let id = if host_domain == vk::TimeDomainKHR::CLOCK_MONOTONIC {
        CLOCK_MONOTONIC
    } else {
        CLOCK_MONOTONIC_RAW
    };
    let mut ts = Timespec { tv_sec: 0, tv_nsec: 0 };
    if unsafe { clock_gettime(id, &mut ts) } != 0 {
        return Err(TestError::ResourceError(
            "Unable to obtain host native timestamp for POSIX".to_string(),
        ));
    }
    Ok(ts.tv_sec as u64 * 1_000_000_000 + ts.tv_nsec as u64)
}

/// Absolute difference between two timestamps A and B taking overflow into account. Pick the smallest difference between the two
/// possibilities. We don't know beforehand if B > A or vice versa. Take the valid bit mask into account.
fn abs_diff_with_overflow(a: u64, b: u64, mask: u64) -> u64 {
    debug_assert!(a <= mask);
    debug_assert!(b <= mask);

    let c = a.abs_diff(b);

    if c == 0 {
        return c;
    }

    let d = (mask - c).wrapping_add(1);

    if c < d { c } else { d }
}

/// Positive difference between both marks, advancing from before to after, taking overflow and the valid bit mask into account.
fn positive_diff_with_overflow(before: u64, after: u64, mask: u64) -> u64 {
    debug_assert!(before <= mask);
    debug_assert!(after <= mask);

    if before <= after {
        after - before
    } else {
        (mask - (before - after)).wrapping_add(1)
    }
}

/// Return true if middle is not between begin and end, taking overflow into account.
fn out_of_range(begin: u64, middle: u64, end: u64) -> bool {
    ((begin <= end) && (middle < begin || middle > end)) || ((begin > end) && (middle > end && middle < begin))
}

impl<'a> Fixture<'a> {
    fn new(context: &'a Context<'a>) -> Result<Self, TestError> {
        // Get timestamp mask.
        let dev_timestamp_mask = get_timestamp_mask(context)?;

        // Get calibreatable time domains.
        let timestamp_period = context.get_device_properties().limits.timestamp_period;

        let (dev_domains, host_domains) = get_device_host_domains(context)?;

        // Initialize command buffers and queries.
        let device = context.get_device();
        let query_pool_params = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::TIMESTAMP)
            .query_count(1);
        let query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_params, None) }.vk_check("vkCreateQueryPool")?,
        );
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            device.cmd_reset_query_pool(*cmd_buffer, *query_pool, 0, 1);
            device.cmd_write_timestamp(*cmd_buffer, vk::PipelineStageFlags::TOP_OF_PIPE, *query_pool, 0);
        }
        end_command_buffer(device, *cmd_buffer)?;

        Ok(Self {
            context,
            timestamp_period,
            dev_domains,
            host_domains,
            quality_message: String::new(),
            dev_timestamp_mask,
            query_pool,
            cmd_buffer,
            _cmd_pool: cmd_pool,
        })
    }

    fn append_quality_message(&mut self, message: &str) {
        if !self.quality_message.is_empty() {
            self.quality_message += "; ";
        }
        self.quality_message += message;
    }

    /// `getHostNanoseconds`: the host timestamps are nanoseconds already.
    fn get_host_nanoseconds(&self, host_timestamp: u64) -> u64 {
        host_timestamp
    }

    /// This method will be used when devTicksDelta is (supposedly) a small amount of ticks between two events. We will check
    /// devTicksDelta is reasonably small for the calculation below to succeed without losing precision.
    fn get_device_nanoseconds(&self, dev_ticks_delta: u64) -> Result<u64, TestError> {
        if dev_ticks_delta > u64::from(u32::MAX) {
            return Err(TestError::InternalError(format!(
                "Number of device ticks too big for conversion to nanoseconds: {dev_ticks_delta}"
            )));
        }
        Ok((dev_ticks_delta as f64 * f64::from(self.timestamp_period)) as u64)
    }

    /// `getCalibratedTimestamps`
    fn get_calibrated_timestamps(
        &mut self,
        domains: &[vk::TimeDomainKHR],
    ) -> Result<Vec<CalibratedTimestamp>, TestError> {
        let infos: Vec<vk::CalibratedTimestampInfoKHR> = domains
            .iter()
            .map(|&domain| vk::CalibratedTimestampInfoKHR::builder().time_domain(domain).build())
            .collect();

        let device = self.context.get_device();
        let (timestamps, deviation) = if use_khr_extension(self.context) {
            unsafe { device.get_calibrated_timestamps_khr(&infos) }.vk_check("vkGetCalibratedTimestampsKHR")?
        } else {
            unsafe { device.get_calibrated_timestamps_ext(&infos) }.vk_check("vkGetCalibratedTimestampsEXT")?
        };

        if deviation > DEVIATION_ERROR_LIMIT_NANOS {
            return Err(TestError::InternalError(
                "Calibrated maximum deviation too big".to_string(),
            ));
        } else if deviation > DEVIATION_WARNING_LIMIT_NANOS {
            self.append_quality_message("Calibrated maximum deviation beyond desirable limits");
        } else if deviation == 0 && domains.len() > 1 {
            self.append_quality_message("Calibrated maximum deviation reported as zero");
        }

        // Pack results.
        let mut results = Vec::new();
        for (i, &domain) in domains.iter().enumerate() {
            if domain == vk::TimeDomainKHR::DEVICE {
                check_timestamp_bits(timestamps[i], self.dev_timestamp_mask)?;
            }
            results.push(CalibratedTimestamp {
                timestamp: timestamps[i],
                deviation,
            });
        }
        Ok(results)
    }

    /// `getCalibratedTimestamp`: single domain, single result.
    fn get_calibrated_timestamp(&mut self, domain: vk::TimeDomainKHR) -> Result<CalibratedTimestamp, TestError> {
        Ok(self.get_calibrated_timestamps(&[domain])?.remove(0))
    }

    /// `CalibratedTimestampDevDomainTestInstance::runTest`: test device domain makes sense and is consistent with vkCmdWriteTimestamp().
    fn run_dev_domain_test(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        for dev_domain in self.dev_domains.clone() {
            let before = self.get_calibrated_timestamp(dev_domain)?;
            submit_commands_and_wait(device, queue, *self.cmd_buffer)?;
            let after = self.get_calibrated_timestamp(dev_domain)?;
            let diff_nanos = self.get_device_nanoseconds(positive_diff_with_overflow(
                before.timestamp,
                after.timestamp,
                self.dev_timestamp_mask,
            ))?;

            let mut written_bytes = [0u8; 8];
            unsafe {
                device.get_query_pool_results(
                    *self.query_pool,
                    0,
                    1,
                    &mut written_bytes,
                    8,
                    vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
                )
            }
            .vk_check("vkGetQueryPoolResults")?;
            let written = u64::from_ne_bytes(written_bytes);
            check_timestamp_bits(written, self.dev_timestamp_mask)?;

            if diff_nanos > BATCH_TIME_LIMIT_NANOS {
                return Ok(TestStatus::fail(format!(
                    "{}: Batch of work took too long to execute",
                    domain_name(dev_domain)
                )));
            }

            if out_of_range(before.timestamp, written, after.timestamp) {
                return Ok(TestStatus::fail(format!(
                    "{}: vkCmdWriteTimestamp() inconsistent with vkGetCalibratedTimestampsKHR()",
                    domain_name(dev_domain)
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `CalibratedTimestampHostDomainTestInstance::runTest`: test host domain makes sense and is consistent with native host values.
    fn run_host_domain_test(&mut self) -> TestOutcome {
        for host_domain in self.host_domains.clone() {
            let before = get_host_native_timestamp(host_domain)?;
            let vk_ts = self.get_calibrated_timestamp(host_domain)?;
            let after = get_host_native_timestamp(host_domain)?;
            let diff_nanos = self.get_host_nanoseconds(positive_diff_with_overflow(before, after, u64::MAX));

            if diff_nanos > BATCH_TIME_LIMIT_NANOS {
                return Ok(TestStatus::fail(format!(
                    "{}: Querying host domain took too long to execute",
                    domain_name(host_domain)
                )));
            }

            if out_of_range(before, vk_ts.timestamp, after) {
                return Ok(TestStatus::fail(format!(
                    "{}: vkGetCalibratedTimestampsKHR() inconsistent with native host API",
                    domain_name(host_domain)
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `CalibratedTimestampCalibrationTestInstance::runTest`: verify predictable timestamps and calibration possible.
    fn run_calibration_test(&mut self) -> TestOutcome {
        // Minimum sleep time.
        const SLEEP_MILLISECONDS: u64 = 200;
        const SLEEP_NANOSECONDS: u64 = SLEEP_MILLISECONDS * NANOSECONDS_PER_MILLISECOND;

        for dev_domain in self.dev_domains.clone() {
            for host_domain in self.host_domains.clone() {
                // Device results at index 0, host results at index 1.
                let domains = [dev_domain, host_domain];

                // Measure time.
                let before = self.get_calibrated_timestamps(&domains)?;
                let sleep_start = Instant::now();
                std::thread::sleep(Duration::from_nanos(SLEEP_NANOSECONDS));
                let sleep_end = Instant::now();
                let after = self.get_calibrated_timestamps(&domains)?;
                let actual_sleep_nanoseconds = sleep_end.duration_since(sleep_start).as_nanos() as u64;

                // Check device timestamp is as expected.
                let dev_before_ticks = before[0].timestamp;
                let dev_after_ticks = after[0].timestamp;
                let dev_expected_ticks = dev_before_ticks
                    .wrapping_add((actual_sleep_nanoseconds as f64 / f64::from(self.timestamp_period)) as u64)
                    & self.dev_timestamp_mask;
                let dev_diff_nanos = self.get_device_nanoseconds(abs_diff_with_overflow(
                    dev_after_ticks,
                    dev_expected_ticks,
                    self.dev_timestamp_mask,
                ))?;
                let max_dev_diff_nanos = DEFAULT_TOLERANCE_NANOS.max(before[0].deviation + after[0].deviation);

                if dev_diff_nanos > max_dev_diff_nanos {
                    return Ok(TestStatus::fail(format!(
                        "[{}] Device expected timestamp differs {dev_diff_nanos} nanoseconds (expect value <= {max_dev_diff_nanos})",
                        domain_name(dev_domain)
                    )));
                }

                // Check host timestamp is as expected.
                let host_before = self.get_host_nanoseconds(before[1].timestamp);
                let host_after = self.get_host_nanoseconds(after[1].timestamp);
                let host_expected = host_before + actual_sleep_nanoseconds;
                let host_diff = abs_diff_with_overflow(host_after, host_expected, u64::MAX);
                let max_host_diff = DEFAULT_TOLERANCE_NANOS.max(before[1].deviation + after[1].deviation);

                if host_diff > max_host_diff {
                    return Ok(TestStatus::fail(format!(
                        "[{}] Host expected timestamp differs {host_diff} nanoseconds (expected value <= {max_host_diff})",
                        domain_name(host_domain)
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for CalibratedTimestampTestInstance<'_> {
    /// `CalibratedTimestampTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        // Notes:
        //    1) Clocks may overflow.
        //    2) Because timestampPeriod is a floating point value, there may be less than one nano per tick.
        let mut fixture = Fixture::new(self.context)?;

        let result = match self.kind {
            Kind::DevDomain => fixture.run_dev_domain_test()?,
            Kind::HostDomain => fixture.run_host_domain_test()?,
            Kind::Calibration => fixture.run_calibration_test()?,
        };
        if result.code() != tcu::TestResult::Pass {
            return Ok(result);
        }

        if !fixture.quality_message.is_empty() {
            let msg = format!("Warnings found: {}", fixture.quality_message);
            return Ok(TestStatus::new(tcu::TestResult::QualityWarning, msg));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The `calibrated` group of `createTimestampTests`.
pub fn create_calibrated_timestamp_tests() -> TestCaseGroup {
    let mut calibrated_timestamp_tests = TestCaseGroup::new("calibrated");

    calibrated_timestamp_tests.add_child(Box::new(CalibratedTimestampTestCase {
        name: "dev_domain_test",
        kind: Kind::DevDomain,
    }) as Box<dyn TestCase>);
    calibrated_timestamp_tests.add_child(Box::new(CalibratedTimestampTestCase {
        name: "host_domain_test",
        kind: Kind::HostDomain,
    }) as Box<dyn TestCase>);
    // Test calibration using device and host domains
    calibrated_timestamp_tests.add_child(Box::new(CalibratedTimestampTestCase {
        name: "calibration_test",
        kind: Kind::Calibration,
    }) as Box<dyn TestCase>);

    calibrated_timestamp_tests
}
