// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/memory_model/vktMemoryModelSharedLayout.cpp
//   external/vulkancts/modules/vulkan/memory_model/vktMemoryModelSharedLayoutCase.cpp
//   external/vulkancts/modules/vulkan/util/vktTypeComparisonUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Copyright (c) 2019 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream draws a random layout of shared memory structures per case at run time and
// builds the compute shader from it; `scripts/gen_memory_model_shared_layout.py` replays those draws (same seeds, same order) and writes the
// 210 shaders into `shaders/manifest/memory_model_shared_layout.toml`. The shader writes every member, waits on a barrier and compares what
// it reads back, counting the pass in a storage buffer that this case checks.

use crate::generated::shaders::memory_model_shared_layout::ALL_SHARED_LAYOUT_CASE;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::spirv_assembly::compute_shader_case::{
    ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase,
};
use crate::vkt::{TestCase, TestCaseGroup};

/// The `rust_type` of the manifest entries: one `RandomSharedLayoutCase`.
#[derive(Clone, Copy)]
pub struct SharedLayoutCase {
    pub name: &'static str,
    /// 16 or 8 for the cases built from 16-bit or 8-bit types, 0 for the others.
    pub bits: u32,
    pub programs: BinaryCollection,
}

/// `SharedLayoutCase::checkSupport` and `SharedLayoutCaseInstance::iterate`: one invocation, a counter of one expected in the buffer.
fn make_case(case: &SharedLayoutCase, leaf: &str) -> Box<dyn TestCase> {
    let spec = ComputeShaderSpec {
        outputs: vec![1u32.to_ne_bytes().to_vec()],
        output_initial: vec![0u32.to_ne_bytes().to_vec()],
        extensions: if case.bits != 0 {
            vec!["VK_KHR_shader_float16_int8".to_string()]
        } else {
            Vec::new()
        },
        features: match case.bits {
            16 => vec![RequiredFeature::ShaderFloat16],
            8 => vec![RequiredFeature::ShaderInt8],
            _ => Vec::new(),
        },
        fail_message: "Counter value incorrect",
        ..Default::default()
    };
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

fn add_to_group(groups: &mut Vec<(&'static str, TestCaseGroup)>, group_name: &'static str, case: Box<dyn TestCase>) {
    let index = match groups.iter().position(|(name, _)| *name == group_name) {
        Some(index) => index,
        None => {
            groups.push((group_name, TestCaseGroup::new(group_name)));
            groups.len() - 1
        }
    };
    groups[index].1.add_child(case);
}

/// `createSharedMemoryLayoutTests` - `memory_model.shared`.
pub fn create_shared_layout_tests() -> TestCaseGroup {
    let mut plain: Vec<(&'static str, TestCaseGroup)> = Vec::new();
    let mut by_width: Vec<(&'static str, Vec<(&'static str, TestCaseGroup)>)> = Vec::new();

    for case in ALL_SHARED_LAYOUT_CASE.iter() {
        let segments: Vec<&'static str> = case.name.split('/').collect();
        let leaf = *segments.last().expect("a case name has a leaf");
        match segments.as_slice() {
            [group, _] => add_to_group(&mut plain, group, make_case(case, leaf)),
            [width, group, _] => {
                let index = match by_width.iter().position(|(name, _)| name == width) {
                    Some(index) => index,
                    None => {
                        by_width.push((*width, Vec::new()));
                        by_width.len() - 1
                    }
                };
                add_to_group(&mut by_width[index].1, group, make_case(case, leaf));
            }
            _ => unreachable!("a shared layout case name has two or three segments"),
        }
    }

    let mut shared = TestCaseGroup::new("shared");
    for (_, group) in plain {
        shared.add_child(group);
    }
    for (width, groups) in by_width {
        let mut width_group = TestCaseGroup::new(width);
        for (_, group) in groups {
            width_group.add_child(group);
        }
        shared.add_child(width_group);
    }
    shared
}
