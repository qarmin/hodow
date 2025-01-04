// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/sparse_resources/vktSparseResourcesQueueBindSparseTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A submission owns the semaphore handles it names instead of pointing into the
// vectors they were sliced from.
//
// Sparse queue binding edge cases and synchronization with semaphores and fences. Actual binding and usage is tested by other groups.

use vulkanalia::prelude::v1_0::*;

use super::base::{Queue, QueueRequirements, SparseDevice};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct TestParams {
    /// use 2 or more to sync between different queues
    num_queues: u32,
    num_wait_semaphores: u32,
    num_signal_semaphores: u32,
    /// will make an empty bind sparse submission
    empty_submission: bool,
    bind_sparse_use_fence: bool,
}

/// `QueueSubmission`
enum QueueSubmission {
    Regular {
        queue: Queue,
        wait_semaphores: Vec<vk::Semaphore>,
        wait_dst_stage_mask: Vec<vk::PipelineStageFlags>,
        signal_semaphores: Vec<vk::Semaphore>,
    },
    Sparse {
        queue: Queue,
        wait_semaphores: Vec<vk::Semaphore>,
        signal_semaphores: Vec<vk::Semaphore>,
    },
}

/// `waitForFences`
fn wait_for_fences(device: &Device, fences: &[Unique<'_, vk::Fence>]) -> bool {
    fences.iter().all(|fence| {
        matches!(
            unsafe { device.wait_for_fences(&[**fence], true, u64::MAX) },
            Ok(vk::SuccessCode::SUCCESS)
        )
    })
}

struct SparseQueueBindTest {
    name: String,
    params: TestParams,
}

impl TestCase for SparseQueueBindTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported("sparseBinding not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SparseQueueBindTestInstance {
            context,
            params: self.params,
        })
    }
}

struct SparseQueueBindTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for SparseQueueBindTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;

        // Determine required queues and create a device that supports them
        let sparse_device = SparseDevice::new(
            self.context,
            &[
                QueueRequirements::new(vk::QueueFlags::SPARSE_BINDING, 1),
                QueueRequirements::new(vk::QueueFlags::empty(), params.num_queues),
            ],
            false,
        )?;
        let device = sparse_device.device();

        let sparse_queue = sparse_device.get_queue(vk::QueueFlags::SPARSE_BINDING, 0);

        // We probably have picked the sparse queue again, so filter it out
        let other_queues: Vec<Queue> = (0..params.num_queues as usize)
            .map(|queue_ndx| sparse_device.get_queue(vk::QueueFlags::empty(), queue_ndx))
            .filter(|queue| queue.handle != sparse_queue.handle)
            .collect();

        let mut all_semaphores: Vec<Unique<'_, vk::Semaphore>> = Vec::new();
        let mut wait_semaphores: Vec<vk::Semaphore> = Vec::new();
        let mut signal_semaphores: Vec<vk::Semaphore> = Vec::new();
        let mut signal_semaphores_wait_dst_stage_mask: Vec<vk::PipelineStageFlags> = Vec::new();
        let mut queue_submissions: Vec<QueueSubmission> = Vec::new();

        for _ in 0..params.num_wait_semaphores {
            let semaphore = Unique::new(
                device,
                unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                    .vk_check("vkCreateSemaphore")?,
            );
            wait_semaphores.push(*semaphore);
            all_semaphores.push(semaphore);
        }

        for _ in 0..params.num_signal_semaphores {
            let semaphore = Unique::new(
                device,
                unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }
                    .vk_check("vkCreateSemaphore")?,
            );
            signal_semaphores.push(*semaphore);
            all_semaphores.push(semaphore);
            signal_semaphores_wait_dst_stage_mask.push(vk::PipelineStageFlags::ALL_COMMANDS);
        }

        // Prepare submissions: signal semaphores for the sparse bind operation
        {
            let mut num_queues = 1 + other_queues.len();
            let mut num_semaphores = params.num_wait_semaphores as usize;

            while num_semaphores > 0 && num_queues > 0 {
                if num_queues == 1 {
                    // sparse queue is assigned last, and can handle regular submissions as well
                    queue_submissions.push(QueueSubmission::Regular {
                        queue: sparse_queue,
                        wait_semaphores: Vec::new(),
                        wait_dst_stage_mask: Vec::new(),
                        signal_semaphores: wait_semaphores[..num_semaphores].to_vec(),
                    });
                    num_semaphores = 0;
                    num_queues = 0;
                } else {
                    queue_submissions.push(QueueSubmission::Regular {
                        queue: other_queues[num_queues - 2],
                        wait_semaphores: Vec::new(),
                        wait_dst_stage_mask: Vec::new(),
                        signal_semaphores: vec![wait_semaphores[num_semaphores - 1]],
                    });
                    num_queues -= 1;
                    num_semaphores -= 1;
                }
            }
        }

        // Prepare submission: bind sparse
        if !params.empty_submission {
            queue_submissions.push(QueueSubmission::Sparse {
                queue: sparse_queue,
                wait_semaphores: wait_semaphores.clone(),
                signal_semaphores: signal_semaphores.clone(),
            });
        } else {
            // an unused submission, won't be used in a call to vkQueueBindSparse
            queue_submissions.push(QueueSubmission::Sparse {
                queue: sparse_queue,
                wait_semaphores: Vec::new(),
                signal_semaphores: Vec::new(),
            });
        }

        // Prepare submissions: wait on semaphores signaled by the sparse bind operation
        if !params.empty_submission {
            let mut num_queues = 1 + other_queues.len();
            let mut num_semaphores = params.num_signal_semaphores as usize;

            while num_semaphores > 0 && num_queues > 0 {
                if num_queues == 1 {
                    queue_submissions.push(QueueSubmission::Regular {
                        queue: sparse_queue,
                        wait_semaphores: signal_semaphores[..num_semaphores].to_vec(),
                        wait_dst_stage_mask: signal_semaphores_wait_dst_stage_mask[..num_semaphores].to_vec(),
                        signal_semaphores: Vec::new(),
                    });
                    num_semaphores = 0;
                    num_queues = 0;
                } else {
                    queue_submissions.push(QueueSubmission::Regular {
                        queue: other_queues[num_queues - 2],
                        wait_semaphores: vec![signal_semaphores[num_semaphores - 1]],
                        wait_dst_stage_mask: vec![signal_semaphores_wait_dst_stage_mask[num_semaphores - 1]],
                        signal_semaphores: Vec::new(),
                    });
                    num_queues -= 1;
                    num_semaphores -= 1;
                }
            }
        }

        // Submit to queues
        {
            let mut regular_fences: Vec<Unique<'_, vk::Fence>> = Vec::new();
            let mut bind_sparse_fences: Vec<Unique<'_, vk::Fence>> = Vec::new();

            for submission in &queue_submissions {
                match submission {
                    QueueSubmission::Sparse {
                        queue,
                        wait_semaphores,
                        signal_semaphores,
                    } => {
                        let mut fence = vk::Fence::null();

                        if params.bind_sparse_use_fence {
                            bind_sparse_fences.push(Unique::new(
                                device,
                                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }
                                    .vk_check("vkCreateFence")?,
                            ));
                            fence = **bind_sparse_fences.last().expect("a fence was just pushed");
                        }

                        if params.empty_submission {
                            unsafe { device.queue_bind_sparse(queue.handle, &[] as &[vk::BindSparseInfo], fence) }
                                .vk_check("vkQueueBindSparse")?;
                        } else {
                            let bind_info = vk::BindSparseInfo::builder()
                                .wait_semaphores(wait_semaphores)
                                .signal_semaphores(signal_semaphores);
                            unsafe { device.queue_bind_sparse(queue.handle, &[bind_info], fence) }
                                .vk_check("vkQueueBindSparse")?;
                        }
                    }
                    QueueSubmission::Regular {
                        queue,
                        wait_semaphores,
                        wait_dst_stage_mask,
                        signal_semaphores,
                    } => {
                        regular_fences.push(Unique::new(
                            device,
                            unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }
                                .vk_check("vkCreateFence")?,
                        ));
                        let submit_info = vk::SubmitInfo::builder()
                            .wait_semaphores(wait_semaphores)
                            .wait_dst_stage_mask(wait_dst_stage_mask)
                            .signal_semaphores(signal_semaphores);
                        unsafe {
                            device.queue_submit(
                                queue.handle,
                                &[submit_info],
                                **regular_fences.last().expect("a fence was just pushed"),
                            )
                        }
                        .vk_check("vkQueueSubmit")?;
                    }
                }
            }

            if !wait_for_fences(device, &bind_sparse_fences) {
                return Ok(TestStatus::fail("vkQueueBindSparse didn't signal the fence"));
            }

            if !wait_for_fences(device, &regular_fences) {
                return Ok(TestStatus::fail(
                    "Some fences weren't signaled (vkQueueBindSparse didn't signal semaphores?)",
                ));
            }
        }

        // May return an error if some waitSemaphores didn't get signaled
        unsafe { device.device_wait_idle() }.vk_check("vkDeviceWaitIdle")?;

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createQueueBindSparseTests`
pub fn create_queue_bind_sparse_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("queue_bind");

    // case name, numQueues, numWaitSems, numSignalSems, emptySubmission, checkFence
    let cases: [(&str, u32, u32, u32, bool, bool); 18] = [
        ("no_dependency", 1, 0, 0, false, false),
        ("no_dependency_fence", 1, 0, 0, false, true),
        ("single_queue_wait_one", 1, 1, 0, false, true),
        ("single_queue_wait_many", 1, 3, 0, false, true),
        ("single_queue_signal_one", 1, 0, 1, false, true),
        ("single_queue_signal_many", 1, 0, 3, false, true),
        ("single_queue_wait_one_signal_one", 1, 1, 1, false, true),
        ("single_queue_wait_many_signal_many", 1, 2, 3, false, true),
        ("multi_queue_wait_one", 2, 1, 0, false, true),
        ("multi_queue_wait_many", 2, 2, 0, false, true),
        ("multi_queue_signal_one", 2, 0, 1, false, true),
        ("multi_queue_signal_many", 2, 0, 2, false, true),
        ("multi_queue_wait_one_signal_one", 2, 1, 1, false, true),
        ("multi_queue_wait_many_signal_many", 2, 2, 2, false, true),
        ("multi_queue_wait_one_signal_one_other", 2, 1, 1, false, true),
        ("multi_queue_wait_many_signal_many_other", 3, 2, 2, false, true),
        ("empty", 1, 0, 0, true, false),
        ("empty_fence", 1, 0, 0, true, true),
    ];

    for (name, num_queues, num_wait_semaphores, num_signal_semaphores, empty_submission, bind_sparse_use_fence) in cases
    {
        group.add_child(Box::new(SparseQueueBindTest {
            name: name.to_string(),
            params: TestParams {
                num_queues,
                num_wait_semaphores,
                num_signal_semaphores,
                empty_submission,
                bind_sparse_use_fence,
            },
        }) as Box<dyn TestCase>);
    }

    group
}
