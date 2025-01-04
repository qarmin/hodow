// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktNonRobustBufferAccessTests.cpp
//   external/vulkancts/data/vulkan/amber/non_robust_buffer_access/unexecuted_oob_{underflow,overflow}.amber
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two Amber scripts are one dispatch of four work groups over four storage buffers: the compute shader is the script's GLSL
// (`shaders/src/robustness/non_robust_buffer_access/`), the buffers and the expectation are written out below, and `EXPECT data_out EQ_BUFFER expected` is the exact comparison of
// the compute case of the assembly groups.

use crate::generated::shaders::robustness_non_robust_buffer_access::ALL_NON_ROBUST_BUFFER_ACCESS_PROGRAM;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::spirv_assembly::compute_shader_case::{ComputeShaderSpec, SpvAsmComputeShaderCase};
use crate::vkt::{TestCase, TestCaseGroup};

/// The `rust_type` of the manifest entries: the compute shader of one script.
#[derive(Clone, Copy)]
pub struct NonRobustBufferAccessProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

fn ints_to_bytes(values: &[i32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

fn make_case(program: &NonRobustBufferAccessProgram) -> Box<dyn TestCase> {
    // `SERIES_FROM 0 INC_BY 2`, `SERIES_FROM 1 INC_BY 2`, the condition data and `SERIES_FROM 0 INC_BY 1`.
    let data_in0: Vec<i32> = (0..512).map(|ndx| 2 * ndx).collect();
    let data_in1: Vec<i32> = (0..512).map(|ndx| 2 * ndx + 1).collect();
    let data_in2 = [0, 2, 1, 2, 0, 2, 1, -6];
    let expected: Vec<i32> = (0..1024).collect();

    let spec = ComputeShaderSpec {
        inputs: vec![
            ints_to_bytes(&data_in0),
            ints_to_bytes(&data_in1),
            ints_to_bytes(&data_in2),
        ],
        outputs: vec![ints_to_bytes(&expected)],
        num_work_groups: [4, 1, 1],
        ..Default::default()
    };
    Box::new(SpvAsmComputeShaderCase {
        name: program.name.to_string(),
        spec,
        programs: program.programs,
    })
}

/// `createNonRobustBufferAccessTests`
pub fn create_non_robust_buffer_access_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("non_robust_buffer_access");
    for program in ALL_NON_ROBUST_BUFFER_ACCESS_PROGRAM.iter() {
        group.add_child(make_case(program));
    }
    group
}
