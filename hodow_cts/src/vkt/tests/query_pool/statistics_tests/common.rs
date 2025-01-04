// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolStatisticsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. What upstream spreads over `StatisticQueryTestInstance` and the free helper
// functions at the top of the file: the parameter enums, the query result vectors (with and without availability, 32 or 64
// bit), `vkCmdCopyQueryPoolResults` recording, the reset buffer and `verifyUnavailable`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtHostQueryResetExtensionDeviceCommands, InstanceV1_1};

use crate::tcu::{TestError, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, make_buffer_create_info, make_buffer_memory_barrier};
use crate::vkt::Context;

/// `WIDTH` and `HEIGHT`
pub(super) const WIDTH: u32 = 64;
pub(super) const HEIGHT: u32 = 64;

/// `ValueAndAvailability`: the two 64 bit words the BEFORE_COPY reset type reads back.
pub(super) const VALUE_AND_AVAILABILITY_SIZE: vk::DeviceSize = 16;

/// `ResetType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum ResetType {
    Normal,
    Host,
    BeforeCopy,
    AfterCopy,
}

/// `CopyType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum CopyType {
    Get,
    Cmd,
}

/// `StrideType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum StrideType {
    Valid,
    Zero,
}

/// `CommandBufferType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) enum CommandBufferType {
    Primary,
    Secondary,
    SecondaryInherited,
}

/// `GenericParameters`
#[derive(Clone, Copy, Debug)]
pub(super) struct GenericParameters {
    pub reset_type: ResetType,
    pub copy_type: CopyType,
    pub query_64_bits: bool,
    pub dst_offset: bool,
    pub stride_type: StrideType,
    pub use_device_address_commands: bool,
}

impl GenericParameters {
    /// `GenericParameters::querySizeFlags`
    pub(super) fn query_size_flags(&self) -> vk::QueryResultFlags {
        if self.query_64_bits {
            vk::QueryResultFlags::_64
        } else {
            vk::QueryResultFlags::empty()
        }
    }
}

/// `commonCheckSupport`
pub(super) fn common_check_support(context: &Context<'_>, host_query_reset: bool) -> Result<(), TestError> {
    if context.get_device_features().pipeline_statistics_query == vk::FALSE {
        return Err(TestError::NotSupported(
            "Pipeline statistics queries are not supported".to_string(),
        ));
    }

    if host_query_reset {
        // Check VK_EXT_host_query_reset is supported
        context.require_device_functionality("VK_EXT_host_query_reset")?;
        let mut features12 = vk::PhysicalDeviceVulkan12Features::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features12);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if features12.host_query_reset == vk::FALSE {
            return Err(TestError::NotSupported(
                "Implementation doesn't support resetting queries from the host".to_string(),
            ));
        }
    }

    Ok(())
}

/// `vkResetQueryPool`, through the extension on a device older than 1.2.
pub(super) fn host_reset_query_pool(
    context: &Context<'_>,
    query_pool: vk::QueryPool,
    first_query: u32,
    query_count: u32,
) {
    let device = context.get_device();
    if context.api_version() >= (1, 2, 0) {
        unsafe { device.reset_query_pool(query_pool, first_query, query_count) };
    } else {
        unsafe { device.reset_query_pool_ext(query_pool, first_query, query_count) };
    }
}

/// `makeQueryPool`
pub(super) fn make_query_pool(
    device: &Device,
    query_count: u32,
    statistic_flags: vk::QueryPipelineStatisticFlags,
) -> Result<vk::QueryPool, TestError> {
    let info = vk::QueryPoolCreateInfo::builder()
        .query_type(vk::QueryType::PIPELINE_STATISTICS)
        .query_count(query_count)
        .pipeline_statistics(statistic_flags);
    unsafe { device.create_query_pool(&info, None) }.vk_check("vkCreateQueryPool")
}

/// `beginSecondaryCommandBuffer`: a secondary buffer that inherits the pipeline statistics the query counts.
pub(super) fn begin_secondary_command_buffer(
    device: &Device,
    command_buffer: vk::CommandBuffer,
    query_flags: vk::QueryPipelineStatisticFlags,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    buffer_usage_flags: vk::CommandBufferUsageFlags,
) -> Result<(), TestError> {
    let inheritance = vk::CommandBufferInheritanceInfo::builder()
        .render_pass(render_pass)
        .subpass(0)
        .framebuffer(framebuffer)
        .occlusion_query_enable(false)
        .query_flags(vk::QueryControlFlags::empty())
        .pipeline_statistics(query_flags);
    let info = vk::CommandBufferBeginInfo::builder()
        .flags(buffer_usage_flags)
        .inheritance_info(&inheritance);
    unsafe { device.begin_command_buffer(command_buffer, &info) }.vk_check("vkBeginCommandBuffer")
}

/// `GetQueryPoolResultsVector`: the results always widened to 64 bits, whichever width the call used. Entries the call did not
/// write keep what `output` held, which is how the reset check tells "unavailable and untouched" apart.
pub(super) fn get_query_pool_results_vector(
    device: &Device,
    output: &mut Vec<u64>,
    query_pool: vk::QueryPool,
    first_query: u32,
    query_count: u32,
    flags: vk::QueryResultFlags,
) -> Result<vk::SuccessCode, TestError> {
    if flags.contains(vk::QueryResultFlags::WITH_AVAILABILITY) {
        return Err(TestError::InternalError(
            "Availability flag passed when expecting results as ResultsVector".to_string(),
        ));
    }

    output.resize(query_count as usize, 0);

    let mut bytes: Vec<u8> = if flags.contains(vk::QueryResultFlags::_64) {
        output.iter().flat_map(|v| v.to_ne_bytes()).collect()
    } else {
        output.iter().flat_map(|v| (*v as u32).to_ne_bytes()).collect()
    };
    let stride: vk::DeviceSize = if flags.contains(vk::QueryResultFlags::_64) {
        8
    } else {
        4
    };

    let result =
        unsafe { device.get_query_pool_results(query_pool, first_query, query_count, &mut bytes, stride, flags) }
            .vk_check("vkGetQueryPoolResults")?;

    if flags.contains(vk::QueryResultFlags::_64) {
        for (value, chunk) in output.iter_mut().zip(bytes.chunks_exact(8)) {
            *value = u64::from_ne_bytes(chunk.try_into().expect("eight bytes"));
        }
    } else {
        for (value, chunk) in output.iter_mut().zip(bytes.chunks_exact(4)) {
            *value = u64::from(u32::from_ne_bytes(chunk.try_into().expect("four bytes")));
        }
    }

    Ok(result)
}

/// The same with the availability bit of every query next to its value.
pub(super) fn get_query_pool_results_vector_with_availability(
    device: &Device,
    output: &mut Vec<(u64, u64)>,
    query_pool: vk::QueryPool,
    first_query: u32,
    query_count: u32,
    flags: vk::QueryResultFlags,
) -> Result<vk::SuccessCode, TestError> {
    let flags = flags | vk::QueryResultFlags::WITH_AVAILABILITY;

    output.resize(query_count as usize, (0, 0));

    let wide = flags.contains(vk::QueryResultFlags::_64);
    let mut bytes: Vec<u8> = if wide {
        output
            .iter()
            .flat_map(|(value, availability)| value.to_ne_bytes().into_iter().chain(availability.to_ne_bytes()))
            .collect()
    } else {
        output
            .iter()
            .flat_map(|(value, availability)| {
                (*value as u32)
                    .to_ne_bytes()
                    .into_iter()
                    .chain((*availability as u32).to_ne_bytes())
            })
            .collect()
    };
    let stride: vk::DeviceSize = if wide { 16 } else { 8 };

    let result =
        unsafe { device.get_query_pool_results(query_pool, first_query, query_count, &mut bytes, stride, flags) }
            .vk_check("vkGetQueryPoolResults")?;

    if wide {
        for (pair, chunk) in output.iter_mut().zip(bytes.chunks_exact(16)) {
            *pair = (
                u64::from_ne_bytes(chunk[..8].try_into().expect("eight bytes")),
                u64::from_ne_bytes(chunk[8..].try_into().expect("eight bytes")),
            );
        }
    } else {
        for (pair, chunk) in output.iter_mut().zip(bytes.chunks_exact(8)) {
            *pair = (
                u64::from(u32::from_ne_bytes(chunk[..4].try_into().expect("four bytes"))),
                u64::from(u32::from_ne_bytes(chunk[4..].try_into().expect("four bytes"))),
            );
        }
    }

    Ok(result)
}

/// `cmdCopyQueryPoolResultsVector`: what a `vkCmdCopyQueryPoolResults` left in the reset buffer, widened to 64 bits.
pub(super) fn cmd_copy_query_pool_results_vector(
    device: &Device,
    reset_buffer: &BufferWithMemory<'_>,
    query_count: u32,
    flags: vk::QueryResultFlags,
    dst_offset: bool,
) -> Result<Vec<u64>, TestError> {
    if flags.contains(vk::QueryResultFlags::WITH_AVAILABILITY) {
        return Err(TestError::InternalError(
            "Availability flag passed when expecting results as ResultsVector".to_string(),
        ));
    }

    let allocation = reset_buffer.get_allocation();
    invalidate_alloc(device, allocation)?;

    let element_size = if flags.contains(vk::QueryResultFlags::_64) {
        8
    } else {
        4
    };
    let offset = if dst_offset { element_size } else { 0 };
    let bytes = unsafe {
        std::slice::from_raw_parts(
            allocation.get_host_ptr().add(offset),
            query_count as usize * element_size,
        )
    };

    Ok(if element_size == 8 {
        bytes
            .chunks_exact(8)
            .map(|chunk| u64::from_ne_bytes(chunk.try_into().expect("eight bytes")))
            .collect()
    } else {
        bytes
            .chunks_exact(4)
            .map(|chunk| u64::from(u32::from_ne_bytes(chunk.try_into().expect("four bytes"))))
            .collect()
    })
}

/// The same with the availability bit of every query next to its value.
pub(super) fn cmd_copy_query_pool_results_vector_with_availability(
    device: &Device,
    reset_buffer: &BufferWithMemory<'_>,
    query_count: u32,
    flags: vk::QueryResultFlags,
    dst_offset: bool,
) -> Result<Vec<(u64, u64)>, TestError> {
    let allocation = reset_buffer.get_allocation();
    invalidate_alloc(device, allocation)?;

    let word_size = if flags.contains(vk::QueryResultFlags::_64) {
        8
    } else {
        4
    };
    let element_size = word_size * 2;
    let offset = if dst_offset { element_size } else { 0 };
    let bytes = unsafe {
        std::slice::from_raw_parts(
            allocation.get_host_ptr().add(offset),
            query_count as usize * element_size,
        )
    };

    let word = |chunk: &[u8]| -> u64 {
        if word_size == 8 {
            u64::from_ne_bytes(chunk.try_into().expect("eight bytes"))
        } else {
            u64::from(u32::from_ne_bytes(chunk.try_into().expect("four bytes")))
        }
    };

    Ok(bytes
        .chunks_exact(element_size)
        .map(|pair| (word(&pair[..word_size]), word(&pair[word_size..])))
        .collect())
}

/// `calculatePearsonCorrelation`: two statistical variables are linear when the absolute value is 1 and independent when it is 0.
pub(super) fn calculate_pearson_correlation(x: &[u64], y: &[u64]) -> f64 {
    debug_assert_eq!(x.len(), y.len());
    debug_assert!(x.len() > 1);

    let count = x.len() as f64;
    let x_mean = x.iter().map(|v| *v as f64).sum::<f64>() / count;
    let y_mean = y.iter().map(|v| *v as f64).sum::<f64>() / count;

    let mut x_s = 0.0;
    let mut y_s = 0.0;
    for (xv, yv) in x.iter().zip(y) {
        let xv = *xv as f64 - x_mean;
        let yv = *yv as f64 - y_mean;
        x_s += xv * xv;
        y_s += yv * yv;
    }
    x_s = (x_s / (count - 1.0)).sqrt();
    y_s = (y_s / (count - 1.0)).sqrt();

    let mut pearson = 0.0;
    for (xv, yv) in x.iter().zip(y) {
        pearson += ((*xv as f64 - x_mean) / x_s) * ((*yv as f64 - y_mean) / y_s);
    }

    pearson / (count - 1.0)
}

/// The query count a stride-zero or offset copy has to leave room for: every query is two 64 bit words wide at most.
fn reset_buffer_size(query_count: u32, dst_offset: bool) -> vk::DeviceSize {
    (query_count as vk::DeviceSize + vk::DeviceSize::from(dst_offset)) * VALUE_AND_AVAILABILITY_SIZE
}

/// `StatisticQueryTestInstance`'s reset buffer: the destination of the copies, filled with 0xff so that what the copy did not
/// write is recognisable.
pub(super) fn create_reset_buffer<'a>(
    context: &'a Context<'a>,
    query_count: u32,
    dst_offset: bool,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let size = reset_buffer_size(query_count, dst_offset);
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let allocation = buffer.get_allocation();
    unsafe { std::ptr::write_bytes(allocation.get_host_ptr(), 0xff, size as usize) };
    flush_alloc(device, allocation)?;
    Ok(buffer)
}

/// `StatisticQueryTestInstance::verifyUnavailable`: after a reset before the copy the availability word has to read zero, and
/// what lies below the destination offset has to be untouched.
pub(super) fn verify_unavailable(
    device: &Device,
    reset_buffer: &BufferWithMemory<'_>,
    dst_offset: bool,
) -> Result<TestStatus, TestError> {
    let allocation = reset_buffer.get_allocation();
    invalidate_alloc(device, allocation)?;

    let count = if dst_offset { 2 } else { 1 };
    let bytes =
        unsafe { std::slice::from_raw_parts(allocation.get_host_ptr(), count * VALUE_AND_AVAILABILITY_SIZE as usize) };

    let mut failed = false;
    for (idx, entry) in bytes.chunks_exact(VALUE_AND_AVAILABILITY_SIZE as usize).enumerate() {
        let value = u64::from_ne_bytes(entry[..8].try_into().expect("eight bytes"));
        let availability = u64::from_ne_bytes(entry[8..].try_into().expect("eight bytes"));

        if dst_offset && idx == 0 {
            // Check that the contents between 0 and dstOffset were not overwritten.
            failed |= availability != u64::MAX || value != u64::MAX;
            continue;
        }

        failed |= availability != 0;
    }

    Ok(if failed {
        TestStatus::fail("Availability bit nonzero after resetting query or dstOffset wrong values")
    } else {
        TestStatus::pass("Pass")
    })
}

/// What every executor records after its queries when the case reads them back with `vkCmdCopyQueryPoolResults`, or resets
/// around the copy: the copy itself, the reset that follows it and the barrier that makes the result visible to the host.
pub(super) fn record_query_copy(
    device: &Device,
    command_buffer: vk::CommandBuffer,
    query_pool: vk::QueryPool,
    query_count: u32,
    params: &GenericParameters,
    reset_buffer: vk::Buffer,
) {
    if !(params.reset_type == ResetType::BeforeCopy
        || params.reset_type == ResetType::AfterCopy
        || params.copy_type == CopyType::Cmd)
    {
        return;
    }

    let mut stride: vk::DeviceSize = if params.query_64_bits { 8 } else { 4 };
    let mut flags = params.query_size_flags() | vk::QueryResultFlags::WAIT;

    if params.reset_type == ResetType::Host {
        flags |= vk::QueryResultFlags::WITH_AVAILABILITY;
        stride *= 2;
    }

    if params.reset_type == ResetType::BeforeCopy {
        unsafe { device.cmd_reset_query_pool(command_buffer, query_pool, 0, query_count) };
        flags = vk::QueryResultFlags::_64 | vk::QueryResultFlags::WITH_AVAILABILITY;
        stride = VALUE_AND_AVAILABILITY_SIZE;
    }

    let dst_offset_query = if params.dst_offset { stride } else { 0 };
    let copy_stride = if params.stride_type == StrideType::Zero {
        0
    } else {
        stride
    };

    unsafe {
        device.cmd_copy_query_pool_results(
            command_buffer,
            query_pool,
            0,
            query_count,
            reset_buffer,
            dst_offset_query,
            copy_stride,
            flags,
        );

        if params.reset_type == ResetType::AfterCopy {
            device.cmd_reset_query_pool(command_buffer, query_pool, 0, query_count);
        }

        let barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            reset_buffer,
            0,
            query_count as vk::DeviceSize * stride + dst_offset_query,
        );
        device.cmd_pipeline_barrier(
            command_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// The reads a finished case makes of a result set whose expectation is the minimum `expected_min` and whose queries drew
/// `draw_repeats` times each (empty when there is a single query): the results of a NORMAL or AFTER_COPY reset are checked as
/// plain values, a HOST reset ones with their availability, and a BEFORE_COPY reset only for the unavailability.
pub(super) struct ResultReader<'a> {
    pub context: &'a Context<'a>,
    pub query_pool: vk::QueryPool,
    pub query_count: u32,
    pub params: GenericParameters,
    pub reset_buffer: &'a BufferWithMemory<'a>,
}

impl ResultReader<'_> {
    fn device(&self) -> &Device {
        self.context.get_device()
    }

    /// The plain values: through `vkCmdCopyQueryPoolResults` when the case copies, through `vkGetQueryPoolResults` otherwise.
    pub(super) fn read_values(&self) -> Result<Vec<u64>, TestError> {
        let flags = vk::QueryResultFlags::WAIT | self.params.query_size_flags();
        if self.params.copy_type == CopyType::Cmd {
            cmd_copy_query_pool_results_vector(
                self.device(),
                self.reset_buffer,
                self.query_count,
                flags,
                self.params.dst_offset,
            )
        } else {
            let mut results = vec![0u64; self.query_count as usize];
            get_query_pool_results_vector(self.device(), &mut results, self.query_pool, 0, self.query_count, flags)?;
            Ok(results)
        }
    }

    /// The values with the availability of each.
    pub(super) fn read_values_with_availability(&self) -> Result<Vec<(u64, u64)>, TestError> {
        let flags =
            vk::QueryResultFlags::WAIT | self.params.query_size_flags() | vk::QueryResultFlags::WITH_AVAILABILITY;
        if self.params.copy_type == CopyType::Cmd {
            cmd_copy_query_pool_results_vector_with_availability(
                self.device(),
                self.reset_buffer,
                self.query_count,
                flags,
                self.params.dst_offset,
            )
        } else {
            let mut results = vec![(0u64, 0u64); self.query_count as usize];
            get_query_pool_results_vector_with_availability(
                self.device(),
                &mut results,
                self.query_pool,
                0,
                self.query_count,
                flags,
            )?;
            Ok(results)
        }
    }

    /// The tail of the HOST reset check: a query that was reset again must say it is not ready, keep the value that was in the
    /// output and report availability 0.
    ///
    /// From the Vulkan spec: if `VK_QUERY_RESULT_WAIT_BIT` and `VK_QUERY_RESULT_PARTIAL_BIT` are both not set then no result
    /// values are written to pData for queries that are in the unavailable state at the time of the call, and
    /// vkGetQueryPoolResults returns `VK_NOT_READY`. However, availability state is still written to pData for those queries
    /// if `VK_QUERY_RESULT_WITH_AVAILABILITY_BIT` is set.
    pub(super) fn check_reset_again(&self, results: &mut Vec<(u64, u64)>) -> Result<bool, TestError> {
        let temp = results[0].0;

        host_reset_query_pool(self.context, self.query_pool, 0, self.query_count);
        let result = get_query_pool_results_vector_with_availability(
            self.device(),
            results,
            self.query_pool,
            0,
            self.query_count,
            self.params.query_size_flags() | vk::QueryResultFlags::WITH_AVAILABILITY,
        )?;

        Ok(result == vk::SuccessCode::NOT_READY && results[0].0 == temp && results[0].1 == 0)
    }
}
