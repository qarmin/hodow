// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationTimelineSemaphoreTests.cpp (SparseBindCase, SparseBindInstance, SparseBindGroup)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The sparse queue is a queue of the family with sparse binding of `Context::multi_queue_device()`,
// which is where the sparse resources tests get theirs (this group lives in the base crate and cannot use the sparse resources module).
//
// `vkQueueBindSparse` with no binds at all, waiting for and signaling timeline semaphores: the signal semaphores must keep their value until the
// wait semaphores are signaled from the host, and must then reach the next value.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_2;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Make a nonzero initial value for a semaphore. `sem_id` is assigned to each semaphore by the caller.
fn get_initial_value(sem_id: u32) -> u64 {
    (u64::from(sem_id) + 1) * 1000
}

fn create_timeline_semaphore(device: &Device, sem_id: u32) -> Result<(Unique<'_, vk::Semaphore>, u64), TestError> {
    let initial_value = get_initial_value(sem_id);
    let mut type_info = vk::SemaphoreTypeCreateInfo::builder()
        .semaphore_type(vk::SemaphoreType::TIMELINE)
        .initial_value(initial_value);
    let info = vk::SemaphoreCreateInfo::builder().push_next(&mut type_info);
    let semaphore = unsafe { device.create_semaphore(&info, None) }.vk_check("vkCreateSemaphore")?;
    Ok((Unique::new(device, semaphore), initial_value))
}

struct SparseBindCase {
    name: &'static str,
    num_wait_sems: u32,
    num_signal_sems: u32,
}

impl TestCase for SparseBindCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `SparseBindCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature sparseBinding not supported".to_string(),
            ));
        }
        context.require_device_functionality("VK_KHR_timeline_semaphore")
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SparseBindInstance {
            context,
            num_wait_sems: self.num_wait_sems,
            num_signal_sems: self.num_signal_sems,
        })
    }
}

struct SparseBindInstance<'a> {
    context: &'a Context<'a>,
    num_wait_sems: u32,
    num_signal_sems: u32,
}

impl TestInstance for SparseBindInstance<'_> {
    /// `SparseBindInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let multi_queue_device = self.context.multi_queue_device()?;
        let device = multi_queue_device.device();
        let queue = multi_queue_device
            .families()
            .iter()
            .find(|family| family.flags.contains(vk::QueueFlags::SPARSE_BINDING))
            .and_then(|family| family.queues.first().copied())
            .ok_or_else(|| TestError::NotSupported("No queue with sparse binding".to_string()))?;

        // Create as many semaphores as needed to wait and signal.
        let mut wait_semaphores = Vec::new();
        let mut signal_semaphores = Vec::new();
        for i in 0..self.num_wait_sems {
            wait_semaphores.push(create_timeline_semaphore(device, i)?);
        }
        for i in 0..self.num_signal_sems {
            signal_semaphores.push(create_timeline_semaphore(device, i + self.num_wait_sems)?);
        }

        // Get handles for all semaphores.
        let wait_sem_handles: Vec<vk::Semaphore> = wait_semaphores.iter().map(|(semaphore, _)| **semaphore).collect();
        let signal_sem_handles: Vec<vk::Semaphore> =
            signal_semaphores.iter().map(|(semaphore, _)| **semaphore).collect();

        // Get initial values for all semaphores.
        let signal_sem_values: Vec<u64> = signal_semaphores.iter().map(|&(_, value)| value).collect();

        // Get next expected values for all semaphores.
        let wait_next_values: Vec<u64> = wait_semaphores.iter().map(|&(_, value)| value + 1).collect();
        let signal_next_values: Vec<u64> = signal_sem_values.iter().map(|value| value + 1).collect();

        let time_line_submit_info = vk::TimelineSemaphoreSubmitInfo {
            s_type: vk::StructureType::TIMELINE_SEMAPHORE_SUBMIT_INFO,
            next: std::ptr::null(),
            wait_semaphore_value_count: wait_next_values.len() as u32,
            wait_semaphore_values: if wait_next_values.is_empty() {
                std::ptr::null()
            } else {
                wait_next_values.as_ptr()
            },
            signal_semaphore_value_count: signal_next_values.len() as u32,
            signal_semaphore_values: if signal_next_values.is_empty() {
                std::ptr::null()
            } else {
                signal_next_values.as_ptr()
            },
        };

        let bind_info = vk::BindSparseInfo {
            s_type: vk::StructureType::BIND_SPARSE_INFO,
            next: (&raw const time_line_submit_info).cast(),
            wait_semaphore_count: wait_sem_handles.len() as u32,
            wait_semaphores: if wait_sem_handles.is_empty() {
                std::ptr::null()
            } else {
                wait_sem_handles.as_ptr()
            },
            buffer_bind_count: 0,
            buffer_binds: std::ptr::null(),
            image_opaque_bind_count: 0,
            image_opaque_binds: std::ptr::null(),
            image_bind_count: 0,
            image_binds: std::ptr::null(),
            signal_semaphore_count: signal_sem_handles.len() as u32,
            signal_semaphores: if signal_sem_handles.is_empty() {
                std::ptr::null()
            } else {
                signal_sem_handles.as_ptr()
            },
        };
        unsafe { device.queue_bind_sparse(queue, &[bind_info], vk::Fence::null()) }.vk_check("vkQueueBindSparse")?;

        // If the device needs to wait and signal, check the signal semaphores have not been signaled yet.
        if !wait_semaphores.is_empty() && !signal_semaphores.is_empty() {
            for (i, &handle) in signal_sem_handles.iter().enumerate() {
                let value =
                    unsafe { device.get_semaphore_counter_value(handle) }.vk_check("vkGetSemaphoreCounterValue")?;

                if value == 0 {
                    return Err(TestError::Fail(
                        "Invalid value obtained from vkGetSemaphoreCounterValue()".to_string(),
                    ));
                }

                if value != signal_sem_values[i] {
                    return Err(TestError::Fail(format!(
                        "vkQueueBindSparse() may not have waited before signaling semaphore {i} (expected value {} but obtained {value})",
                        signal_sem_values[i]
                    )));
                }
            }
        }

        // Signal the semaphores the sparse bind command is waiting on.
        for (&handle, &value) in wait_sem_handles.iter().zip(&wait_next_values) {
            let info = vk::SemaphoreSignalInfo::builder().semaphore(handle).value(value);
            unsafe { device.signal_semaphore(&info) }.vk_check("vkSignalSemaphore")?;
        }

        // Wait for the semaphores the sparse bind command is supposed to signal.
        if !signal_semaphores.is_empty() {
            const TIMEOUT: u64 = 10_000_000_000; // 10 seconds in nanoseconds.
            let wait_info = vk::SemaphoreWaitInfo::builder()
                .semaphores(&signal_sem_handles)
                .values(&signal_next_values);
            unsafe { device.wait_semaphores(&wait_info, TIMEOUT) }.vk_check("vkWaitSemaphores")?;
        }

        unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;
        Ok(TestStatus::pass("Pass"))
    }
}

/// `SparseBindGroup`: vkQueueBindSparse combined with timeline semaphores
pub fn create_sparse_bind_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("sparse_bind");

    for (num_wait_sems, num_signal_sems, name) in [
        // No semaphores to wait for or signal
        (0u32, 0u32, "no_sems"),
        // Signal a semaphore without waiting for any other
        (0, 1, "no_wait_sig"),
        // Wait for a semaphore but do not signal any other
        (1, 0, "wait_no_sig"),
        // Wait for a semaphore and signal a second one
        (1, 1, "wait_and_sig"),
        // Wait for two semaphores and signal two other ones
        (2, 2, "wait_and_sig_2"),
    ] {
        group.add_child(Box::new(SparseBindCase {
            name,
            num_wait_sems,
            num_signal_sems,
        }) as Box<dyn TestCase>);
    }

    group
}
