// SPDX-License-Identifier: Apache-2.0
//
// Names from the VK-GL-CTS mustpass (pipeline/no-queues.txt); the bodies are not ported.
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the case tree is registered (always NotPorted).

use crate::vkt::TestCaseGroup;
use crate::vkt::gated::build_gated_groups;

/// The `no_queues` group of the pipeline tree, names only.
pub fn create_no_queues_tests() -> TestCaseGroup {
    build_gated_groups(
        include_str!("no_queues_cases/cases.txt"),
        &[],
        "the no-queues pipeline tests",
    )
    .into_iter()
    .next()
    .expect("the case list has one root group")
}
