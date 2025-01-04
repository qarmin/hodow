// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsm8bitStorageTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the compute groups that are one template over four composite types are here, plus the `uniform_8_to_8` stress test: the assembly of
// the 25 cases is in `shaders/manifest/spirv_assembly_8bit_storage.toml` (written by `scripts/gen_spirv_assembly_8bit_storage_manifest.py`) and the data is drawn here from
// `de::Random(deStringHash(<group name>))` the way each group function draws it. The four cases of `uniform_8_to_32` and of `uniform_8_to_16` share one stream, so a case
// draws the data of the cases before it first (`idx`).

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase};
use super::utils::{get_int8s, get_int16s, get_int32s};
use crate::generated::shaders::spirv_assembly_8bit_storage::ALL_STORAGE8_CASE;
use crate::tcu::de_string_hash;
use crate::tcu::random::Random;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

const NUM_ELEMENTS: usize = 128;
const ARRAY_STRIDE_UNIFORM: usize = 16;

/// The `rust_type` of the manifest entries: one test case of the 8 bit storage groups.
#[derive(Clone, Copy)]
pub struct Storage8Case {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

fn field<'a>(spec: &'a str, key: &str) -> &'a str {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("8 bit storage spec without {key}"))
}

fn number(spec: &str, key: &str) -> usize {
    field(spec, key)
        .parse()
        .unwrap_or_else(|_| panic!("8 bit storage spec with a bad {key}"))
}

fn int8s(rnd: &mut Random, count: usize) -> Vec<i8> {
    get_int8s(rnd, count)
        .concat()
        .into_iter()
        .map(|byte| byte as i8)
        .collect()
}

fn le_bytes_i8(values: &[i8]) -> Vec<u8> {
    values.iter().map(|&value| value as u8).collect()
}

fn le_bytes_i16(values: &[i16]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_le_bytes()).collect()
}

fn le_bytes_i32(values: &[i32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_le_bytes()).collect()
}

/// `checkUniformsArray`: the first byte of every result is compared with the byte at the start of each 16 byte array element, which is all the
/// upstream check looks at, over as many elements as it counts out of the size of the input.
fn verify_uniforms_array<const COMPONENTS: usize, const RESULT_BYTES: usize>(
    inputs: &[Vec<u8>],
    outputs: &[Vec<u8>],
    _expected: &[Vec<u8>],
) -> bool {
    outputs.iter().zip(inputs).all(|(output, input)| {
        let elements = (input.len() / ARRAY_STRIDE_UNIFORM) / COMPONENTS;
        (0..elements).all(|element| {
            (0..COMPONENTS).all(|component| {
                let original = input[element * ARRAY_STRIDE_UNIFORM + component];
                let returned = output[(element * COMPONENTS + component) * RESULT_BYTES];
                original == returned
            })
        })
    })
}

/// `computeCheckBuffers`
fn verify_buffers(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    inputs[0][..] == outputs[0][..inputs[0].len()]
}

fn features(spec: &mut ComputeShaderSpec, with_16bit: bool, feature: RequiredFeature) {
    spec.extensions.push("VK_KHR_8bit_storage".to_string());
    if with_16bit {
        spec.extensions.push("VK_KHR_16bit_storage".to_string());
    }
    spec.extensions.push("VK_KHR_storage_buffer_storage_class".to_string());
    spec.features.push(feature);
    if with_16bit {
        spec.features.push(RequiredFeature::UniformAndStorageBuffer16BitAccess);
    }
}

/// `addCompute8bitStorage32To8Group`
fn storage_32_to_8_spec(spec_text: &str) -> ComputeShaderSpec {
    let mut rnd = Random::new(de_string_hash("storagebuffer_32_to_8"));
    let inputs: Vec<i32> = get_int32s(&mut rnd, NUM_ELEMENTS)
        .concat()
        .chunks_exact(4)
        .map(|chunk| i32::from_ne_bytes(chunk.try_into().expect("four bytes")))
        .collect();
    let outputs: Vec<i8> = inputs.iter().map(|&value| (0xff & value) as i8).collect();
    let mut spec = ComputeShaderSpec {
        num_work_groups: [number(spec_text, "count") as u32, 1, 1],
        ..Default::default()
    };
    spec.inputs.push(le_bytes_i32(&inputs));
    spec.outputs.push(le_bytes_i8(&outputs));
    features(&mut spec, false, RequiredFeature::StorageBuffer8BitAccess);
    spec
}

/// `addCompute8bitStorage16To8Group`
fn storage_16_to_8_spec(spec_text: &str) -> ComputeShaderSpec {
    let mut rnd = Random::new(de_string_hash("storagebuffer_16_to_8"));
    let inputs: Vec<i16> = get_int16s(&mut rnd, NUM_ELEMENTS)
        .concat()
        .chunks_exact(2)
        .map(|chunk| i16::from_ne_bytes(chunk.try_into().expect("two bytes")))
        .collect();
    let outputs: Vec<i8> = inputs.iter().map(|&value| (0xff & value) as i8).collect();
    let mut spec = ComputeShaderSpec {
        num_work_groups: [number(spec_text, "count") as u32, 1, 1],
        ..Default::default()
    };
    spec.inputs.push(le_bytes_i16(&inputs));
    spec.outputs.push(le_bytes_i8(&outputs));
    features(&mut spec, true, RequiredFeature::StorageBuffer8BitAccess);
    spec
}

/// `addCompute8bitUniform8To32Group` and `addCompute8bitUniform8To16Group`: the bytes of the uniform buffer are drawn per case from one stream.
fn uniform_8_to_wide_spec(spec_text: &str, group: &str, result_bytes: usize) -> ComputeShaderSpec {
    let idx = number(spec_text, "idx");
    let components = number(spec_text, "comp");
    let mut rnd = Random::new(de_string_hash(group));
    let mut inputs = Vec::new();
    for earlier in 0..=idx {
        let earlier_components = if earlier < 2 { 1 } else { 4 };
        inputs = int8s(
            &mut rnd,
            (ARRAY_STRIDE_UNIFORM / std::mem::size_of::<i8>()) * (NUM_ELEMENTS / earlier_components),
        );
    }

    let mut spec = ComputeShaderSpec {
        num_work_groups: [(NUM_ELEMENTS / components) as u32, 1, 1],
        uniform_inputs: true,
        ..Default::default()
    };
    spec.inputs.push(le_bytes_i8(&inputs));
    spec.outputs.push(vec![0u8; NUM_ELEMENTS * result_bytes]);
    let with_16bit = result_bytes == 2;
    features(
        &mut spec,
        with_16bit,
        RequiredFeature::UniformAndStorageBuffer8BitAccess,
    );
    spec.verify_io = Some(match (components, result_bytes) {
        (4, 4) => verify_uniforms_array::<4, 4>,
        (1, 4) => verify_uniforms_array::<1, 4>,
        (4, _) => verify_uniforms_array::<4, 2>,
        _ => verify_uniforms_array::<1, 2>,
    });
    spec
}

/// `addCompute8bitStoragePushConstant8To32Group` and `addCompute8bitStoragePushConstant8To16Group`
fn push_constant_spec(spec_text: &str, group: &str, result_bytes: usize) -> ComputeShaderSpec {
    const PUSH_ELEMENTS: usize = 64;
    let mut rnd = Random::new(de_string_hash(group));
    let inputs = int8s(&mut rnd, PUSH_ELEMENTS);
    let is_signed = number(spec_text, "signed") != 0;

    let mut spec = ComputeShaderSpec {
        num_work_groups: [number(spec_text, "count") as u32, 1, 1],
        ..Default::default()
    };
    spec.push_constants = le_bytes_i8(&inputs);
    if result_bytes == 4 {
        let outputs: Vec<i32> = inputs
            .iter()
            .map(|&value| {
                if is_signed {
                    i32::from(value)
                } else {
                    i32::from(value as u8)
                }
            })
            .collect();
        spec.outputs.push(le_bytes_i32(&outputs));
    } else {
        let outputs: Vec<i16> = inputs
            .iter()
            .map(|&value| {
                if is_signed {
                    i16::from(value)
                } else {
                    i16::from(value as u8)
                }
            })
            .collect();
        spec.outputs.push(le_bytes_i16(&outputs));
    }
    features(&mut spec, result_bytes == 2, RequiredFeature::StoragePushConstant8);
    spec
}

/// `addCompute8bitStorageBuffer8To8Group`
fn stress_spec() -> ComputeShaderSpec {
    let mut rnd = Random::new(de_string_hash("uniform_8_to_8"));
    let data = int8s(&mut rnd, NUM_ELEMENTS);
    let mut spec = ComputeShaderSpec {
        num_work_groups: [NUM_ELEMENTS as u32, NUM_ELEMENTS as u32, 1],
        verify_io: Some(verify_buffers),
        ..Default::default()
    };
    spec.inputs.push(le_bytes_i8(&data));
    spec.outputs.push(vec![0u8; NUM_ELEMENTS]);
    spec.extensions.push("VK_KHR_storage_buffer_storage_class".to_string());
    spec.extensions.push("VK_KHR_8bit_storage".to_string());
    spec.features.push(RequiredFeature::StorageBuffer8BitAccess);
    spec
}

fn make_case(case: &Storage8Case, leaf: &str) -> Box<dyn TestCase> {
    let text = case.spec;
    let spec = match field(text, "group") {
        "s32to8" => storage_32_to_8_spec(text),
        "s16to8" => storage_16_to_8_spec(text),
        "u8to32" => uniform_8_to_wide_spec(text, "uniform_8_to_32", 4),
        "u8to16" => uniform_8_to_wide_spec(text, "uniform_8_to_16", 2),
        "p8to32" => push_constant_spec(text, "push_constant_8_to_32", 4),
        "p8to16" => push_constant_spec(text, "push_constant_8_to_16", 2),
        "stress8" => stress_spec(),
        group => panic!("unknown 8 bit storage group {group}"),
    };
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

/// The 8 bit storage groups of `spirv_assembly.instruction.compute` as the groups of their path below `compute` and the test case.
pub fn create_storage8_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_STORAGE8_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (segments, make_case(case, leaf))
        })
        .collect()
}
