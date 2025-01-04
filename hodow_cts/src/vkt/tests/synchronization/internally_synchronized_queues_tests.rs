// SPDX-License-Identifier: Apache-2.0
//
// Names from the VK-GL-CTS mustpass (synchronization2.txt); the upstream source is not in the pinned checkout.
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the case tree is registered, gated on VK_KHR_internally_synchronized_queues
// (NotSupported without, NotPorted with); the names are the mustpass list.

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

/// The `internally_synchronized_queues` group of the synchronization2 tree, names only.
pub fn create_internally_synchronized_queues_tests() -> TestCaseGroup {
    build_gated_groups(
        include_str!("internally_synchronized_queues_cases/cases.txt"),
        &["VK_KHR_internally_synchronized_queues"],
        "the internally synchronized queues tests",
    )
    .into_iter()
    .next()
    .expect("the case list has one root group")
}
