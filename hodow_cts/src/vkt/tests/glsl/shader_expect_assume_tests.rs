// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderExpectAssumeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the compute stage is here: the 47 shaders are in `shaders/manifest/shader_expect_assume.toml` (written by
// `scripts/gen_shader_expect_assume_manifest.py`) and run through the compute case of the assembly groups, with the output buffer at binding 0 and the storage buffer
// that holds the checked values at binding 1. The vertex and fragment cases render into a colour attachment through dynamic rendering (`shader_expect_assume_gfx_tests`).

use crate::generated::shaders::shader_expect_assume::ALL_EXPECT_ASSUME_CASE;
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::spirv_assembly::compute_shader_case::{
    ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase,
};
use crate::vkt::{TestCase, TestCaseGroup};

pub(super) const NUM_ELEMENTS: u32 = 32;

/// The `rust_type` of the manifest entries: one compute shader of the group.
#[derive(Clone, Copy)]
pub struct ExpectAssumeCase {
    pub name: &'static str,
    /// `class=constant|specialization|push|storage;type=bool|int8|int16|int32|int64;chan=N;wrong=0|1`
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

pub(super) fn field<'a>(spec: &'a str, key: &str) -> &'a str {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("expect assume spec without {key}"))
}

/// `generateStorageBuffers`: the value of element `i` channel `c` is `i + c`, one more where the expectation is wrong, in the width of the type.
pub(super) fn input_data(data_type: &str, channels: u32, wrong: bool) -> Vec<u8> {
    let mut data = vec![0u8; NUM_ELEMENTS as usize * 8 * 4];
    let element_stride = if channels != 3 { channels } else { 4 };
    for i in 0..NUM_ELEMENTS {
        for channel in 0..channels {
            let index = (i * element_stride + channel) as usize;
            let value = i + channel + u32::from(wrong);
            match data_type {
                "bool" => data[index * 4..index * 4 + 4].copy_from_slice(&u32::from(!wrong).to_le_bytes()),
                "int8" => data[index] = value as u8,
                "int16" => data[index * 2..index * 2 + 2].copy_from_slice(&(value as u16).to_le_bytes()),
                "int32" => data[index * 4..index * 4 + 4].copy_from_slice(&value.to_le_bytes()),
                "int64" => data[index * 8..index * 8 + 8].copy_from_slice(&u64::from(value).to_le_bytes()),
                other => panic!("unknown data type {other}"),
            }
        }
    }
    data
}

fn make_spec(text: &str) -> ComputeShaderSpec {
    let data_type = field(text, "type");
    let channels: u32 = field(text, "chan").parse().expect("a channel count");
    let wrong = field(text, "wrong") == "1";

    let mut spec = ComputeShaderSpec {
        num_work_groups: [1, 1, 1],
        output_first: true,
        ..Default::default()
    };
    spec.extensions.push("VK_KHR_shader_expect_assume".to_string());
    match field(text, "class") {
        "specialization" => spec.spec_constants.push(1u32.to_le_bytes().to_vec()),
        "push" => spec.push_constants = 1u32.to_le_bytes().to_vec(),
        "storage" => spec.inputs.push(input_data(data_type, channels, wrong)),
        _ => {}
    }

    match data_type {
        "int64" => spec.features.push(RequiredFeature::ShaderInt64),
        "int16" => {
            spec.extensions.push("VK_KHR_16bit_storage".to_string());
            spec.features.extend([
                RequiredFeature::ShaderInt16,
                RequiredFeature::StorageBuffer16BitAccess,
                RequiredFeature::UniformAndStorageBuffer16BitAccess,
            ]);
        }
        "int8" => {
            spec.extensions.push("VK_KHR_shader_float16_int8".to_string());
            spec.extensions.push("VK_KHR_8bit_storage".to_string());
            spec.features.extend([
                RequiredFeature::ShaderInt8,
                RequiredFeature::StorageBuffer8BitAccess,
                RequiredFeature::UniformAndStorageBuffer8BitAccess,
            ]);
        }
        _ => {}
    }

    // (gl_GlobalInvocationID.x, verification result)
    spec.outputs.push(
        (0..NUM_ELEMENTS)
            .flat_map(|i| [i, 1])
            .flat_map(u32::to_le_bytes)
            .collect(),
    );
    spec
}

/// `createShaderExpectAssumeTests`, the compute stage of it.
pub fn create_shader_expect_assume_tests() -> TestCaseGroup {
    let mut expect = TestCaseGroup::new("expect");
    let mut assume = TestCaseGroup::new("assume");
    for case in ALL_EXPECT_ASSUME_CASE.iter() {
        let mut segments = case.name.split('/');
        let (_stage, op, leaf) = (
            segments.next(),
            segments.next().expect("an operation"),
            segments.next().expect("a leaf"),
        );
        let test = Box::new(SpvAsmComputeShaderCase {
            name: leaf.to_string(),
            spec: make_spec(case.spec),
            programs: case.programs,
        }) as Box<dyn TestCase>;
        if op == "expect" {
            expect.add_child(test);
        } else {
            assume.add_child(test);
        }
    }
    let mut compute = TestCaseGroup::new("compute");
    compute.add_child(expect);
    compute.add_child(assume);
    let mut group = TestCaseGroup::new("shader_expect_assume");
    for stage_group in super::shader_expect_assume_gfx_tests::create_vertex_and_fragment_groups() {
        group.add_child(stage_group);
    }
    group.add_child(compute);
    group
}
