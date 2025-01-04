// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmMultipleShadersTests.cpp (`createMultipleShaderExtendedGroup`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the two modules is in `shaders/manifest/spirv_assembly_multiple_shaders_extended.toml` (written by
// `scripts/gen_spirv_assembly_multiple_shaders_extended_manifest.py`). Each is run through the compute case of the assembly groups as two dispatches in one command
// buffer, `mainB` and then `mainA`, over 24 ints in storage buffers that the shaders read and write: they are outputs with initial contents, and only the words
// `iterate` checks are compared.

use super::compute_shader_case::{ComputeShaderSpec, SpvAsmComputeShaderCase};
use crate::generated::shaders::spirv_assembly_multiple_shaders_extended::{
    MSE_TWO_ENTRY_POINTS_DIFFERENT_INTERFACES, MSE_TWO_ENTRY_POINTS_EXECUTION_MODE_ID,
};
pub use crate::vk::programs::SharedProgram;
use crate::vkt::TestCase;

const BUFFER_ITEMS: usize = 24;

fn ints(values: &[i32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_le_bytes()).collect()
}

fn spec(buffers: usize) -> ComputeShaderSpec {
    let data_a: Vec<i32> = (0..BUFFER_ITEMS as i32)
        .map(|i| (9 * ((i / 6) - 1).abs() - (i % 6)).abs() + i32::from(i == 6))
        .collect();
    let data_b: Vec<i32> = (0..BUFFER_ITEMS as i32).map(|i| 1 + i * 2).collect();

    let mut expected_a = vec![0i32; BUFFER_ITEMS];
    let mut mask_a = vec![0u8; BUFFER_ITEMS * 4];
    let mut expected_b = vec![0i32; BUFFER_ITEMS];
    let mut mask_b = vec![0u8; BUFFER_ITEMS * 4];
    let check = |expected: &mut Vec<i32>, mask: &mut Vec<u8>, index: usize, value: i32| {
        expected[index] = value;
        mask[index * 4..index * 4 + 4].fill(0xff);
    };
    for i in 0..6usize {
        if buffers == 1 {
            check(&mut expected_a, &mut mask_a, 12 + i, data_a[i] - data_a[6 + i]);
            check(&mut expected_a, &mut mask_a, 18 + i, data_a[i] * data_a[6 + i]);
        } else {
            check(&mut expected_a, &mut mask_a, 12 + i, data_a[i] + data_a[6 + i]);
            check(&mut expected_b, &mut mask_b, 12 + i, data_b[5 - i] * data_b[11 - i]);
        }
    }

    let mut spec = ComputeShaderSpec {
        num_work_groups: [1, 1, 1],
        entry_point_sequence: vec!["mainB".to_string(), "mainA".to_string()],
        ..Default::default()
    };
    spec.output_initial.push(ints(&data_a));
    spec.outputs.push(ints(&expected_a));
    spec.output_masks.push(mask_a);
    if buffers == 2 {
        spec.output_initial.push(ints(&data_b));
        spec.outputs.push(ints(&expected_b));
        spec.output_masks.push(mask_b);
    }
    spec
}

/// `createMultipleShaderExtendedGroup` as the groups of its path below `compute` and the test case.
pub fn create_multiple_shaders_extended_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    let mut by_mode_id = spec(1);
    by_mode_id.extensions.push("VK_KHR_maintenance4".to_string());
    by_mode_id.spirv_version_minor = Some(5);
    let by_mode_id = Box::new(SpvAsmComputeShaderCase {
        name: "two_entry_points_execution_mode_id".to_string(),
        spec: by_mode_id,
        programs: MSE_TWO_ENTRY_POINTS_EXECUTION_MODE_ID.programs,
    }) as Box<dyn TestCase>;
    let different_interfaces = Box::new(SpvAsmComputeShaderCase {
        name: "two_entry_points_different_interfaces".to_string(),
        spec: spec(2),
        programs: MSE_TWO_ENTRY_POINTS_DIFFERENT_INTERFACES.programs,
    }) as Box<dyn TestCase>;
    vec![
        (vec!["multiple_shaders_extended"], by_mode_id),
        (vec!["multiple_shaders_extended"], different_interfaces),
    ]
}
