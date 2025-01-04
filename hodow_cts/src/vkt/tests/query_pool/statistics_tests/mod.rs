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
// Modifications: rewritten in Rust for hodow_cts. `dEQP-VK.query_pool.statistics_query`: every pipeline statistic counted by a
// query pool, read back with `vkGetQueryPoolResults` or `vkCmdCopyQueryPoolResults`, 32 or 64 bit, with a destination offset,
// reset normally, from the host, before the copy and after it, recorded into a primary command buffer, a secondary one or a
// secondary one whose query the primary holds. `common` is what the instances share, `compute` and `graphic` the instances
// and `register` the case tree; the shaders are in `shaders/manifest/query_pool_statistics.toml`, written by
// `scripts/gen_query_pool_statistics_shaders.py`.
//
// Not ported: the cases that copy through `VK_KHR_device_address_commands` (`..._device_address`) are registered and report
// NotPorted where the extension exists, since vulkanalia has no binding for `vkCmdCopyQueryPoolResultsToMemoryKHR`.

use crate::generated::shaders::query_pool_statistics::ALL_STATISTICS_PROGRAM;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCaseGroup;

mod common;
mod compute;
mod graphic;
mod multiple;
mod register;

/// The manifest declares its cases with this: the program set and the key it is found by (`graphic::program_key`).
pub struct StatisticsProgram {
    pub name: &'static str,
    pub key: &'static str,
    pub programs: BinaryCollection,
}

/// `QueryPoolStatisticsTests`
pub fn create_statistics_tests() -> TestCaseGroup {
    register::create_tests()
}
