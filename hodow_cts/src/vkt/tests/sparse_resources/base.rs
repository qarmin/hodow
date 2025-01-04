// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesBase.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream creates a device with exactly the queues a test asks for; this takes
// them from `Context::multi_queue_device()`, which has every family with up to two queues and every feature on, so a requirement
// for more than two queues of one family is served from the following matching families only. The device-group variant is not ported.

use std::rc::Rc;

use vulkanalia::prelude::v1_0::*;

use crate::tcu::TestError;
use crate::vk::mem_util::SimpleAllocator;
use crate::vkt::Context;
use crate::vkt::context::MultiQueueDevice;

/// `Queue`
#[derive(Clone, Copy)]
pub struct Queue {
    pub handle: vk::Queue,
    pub family_index: u32,
    pub queue_index: u32,
}

/// `QueueRequirements`
#[derive(Clone, Copy)]
pub struct QueueRequirements {
    pub queue_flags: vk::QueueFlags,
    pub queue_count: u32,
}

impl QueueRequirements {
    pub fn new(queue_flags: vk::QueueFlags, queue_count: u32) -> Self {
        Self {
            queue_flags,
            queue_count,
        }
    }
}

/// The part of `SparseResourcesBaseInstance` a test uses: the logical device, its allocator and the queues it asked for.
pub struct SparseDevice {
    device: Rc<MultiQueueDevice>,
    queues: Vec<(vk::QueueFlags, Vec<Queue>)>,
}

/// `findMatchingQueueFamilyIndex`
fn find_matching_queue_family_index(
    families: &[crate::vkt::context::QueueFamilyQueues],
    queue_flags: vk::QueueFlags,
    start_index: usize,
) -> Option<usize> {
    (start_index..families.len()).find(|&index| families[index].flags.contains(queue_flags))
}

/// `findSpecificQueueFamilyIndex`
fn find_specific_queue_family_index(
    families: &[crate::vkt::context::QueueFamilyQueues],
    requested_flags: vk::QueueFlags,
    start_index: usize,
) -> Option<usize> {
    let core_flags = vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE | vk::QueueFlags::TRANSFER;
    (start_index..families.len()).find(|&index| {
        let queue_flags = families[index].flags;
        let core_queue_flags = queue_flags & core_flags;
        let core_requested_flags = requested_flags & core_flags;

        let is_universal = core_queue_flags.contains(vk::QueueFlags::GRAPHICS);
        let need_universal = core_requested_flags.contains(vk::QueueFlags::GRAPHICS);

        (is_universal && need_universal)
            || (core_queue_flags == core_requested_flags && queue_flags.contains(requested_flags))
    })
}

impl SparseDevice {
    /// `createDeviceSupportingQueues`
    pub fn new(
        context: &Context<'_>,
        queue_requirements: &[QueueRequirements],
        force_specific_queue: bool,
    ) -> Result<Self, TestError> {
        let device = context.multi_queue_device()?;
        let mut queues: Vec<(vk::QueueFlags, Vec<Queue>)> = Vec::new();

        for requirement in queue_requirements {
            let mut family_index = 0usize;
            let mut queues_found_count = 0u32;
            let mut found = Vec::new();
            loop {
                let matching = if force_specific_queue {
                    find_specific_queue_family_index(device.families(), requirement.queue_flags, family_index)
                } else {
                    find_matching_queue_family_index(device.families(), requirement.queue_flags, family_index)
                };
                let Some(matching) = matching else {
                    return Err(TestError::NotSupported(
                        "No match found for queue requirements".to_string(),
                    ));
                };

                let family = &device.families()[matching];
                let queues_per_family_count =
                    (family.queues.len() as u32).min(requirement.queue_count - queues_found_count);
                for queue_index in 0..queues_per_family_count {
                    found.push(Queue {
                        handle: family.queues[queue_index as usize],
                        family_index: family.family_index,
                        queue_index,
                    });
                }

                queues_found_count += queues_per_family_count;
                family_index = matching + 1;
                if queues_found_count >= requirement.queue_count {
                    break;
                }
            }

            match queues.iter_mut().find(|(flags, _)| *flags == requirement.queue_flags) {
                Some((_, existing)) => existing.extend(found),
                None => queues.push((requirement.queue_flags, found)),
            }
        }

        Ok(Self { device, queues })
    }

    /// `getQueue`
    pub fn get_queue(&self, queue_flags: vk::QueueFlags, queue_index: usize) -> Queue {
        let (_, queues) = self
            .queues
            .iter()
            .find(|(flags, _)| *flags == queue_flags)
            .expect("the queue flags were part of the requirements");
        queues[queue_index]
    }

    /// `getDevice` / `getDeviceInterface`
    pub fn device(&self) -> &Device {
        self.device.device()
    }

    /// `getAllocator`
    pub fn allocator(&self) -> &SimpleAllocator {
        self.device.allocator()
    }
}
