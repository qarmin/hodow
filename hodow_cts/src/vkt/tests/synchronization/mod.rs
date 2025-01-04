// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

pub mod basic_extra_tests;
pub mod basic_tests;
pub mod cross_instance_sharing_tests;
pub mod global_priority_tests;
pub mod image_layout_transition_tests;
pub mod implicit_tests;
pub mod internally_synchronized_objects_tests;
pub mod internally_synchronized_queues_tests;
pub mod multi_queue_tests;
pub mod none_stage_tests;
pub mod operation;
pub mod signal_order_shared_tests;
pub mod signal_order_tests;
pub mod single_queue_tests;
pub mod smoke_tests;
pub mod timeline_queue_tests;
pub mod timeline_semaphore_tests;
pub mod timeline_sparse_bind_tests;
pub mod win32_keyed_mutex_tests;
