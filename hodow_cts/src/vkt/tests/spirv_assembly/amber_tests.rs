// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmSignedOpTests.cpp
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmLdexpTests.cpp
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmSpirvVersion1p4Tests.cpp
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmInstructionTests.cpp (the convert groups, from scripts/gen_spirv_assembly_convert_manifest.py)
//   external/vulkancts/data/vulkan/amber/spirv_assembly/instruction/compute/*, external/vulkancts/data/vulkan/amber/ldexp/*,
//   external/vulkancts/data/vulkan/amber/spirv_assembly/instruction/spirv1p4/*, external/vulkancts/data/vulkan/amber/compute/{workgroup_memory_explicit_layout,zero_initialize_workgroup_memory}/*
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. There is no Amber interpreter here: `scripts/gen_spirv_assembly_amber_manifest.py` reads the
// plain compute scripts (one SPIR-V assembly shader, storage buffers, one dispatch, buffers compared against an expected one) and writes
// them into `shaders/manifest/spirv_assembly_amber.toml`, with the initial buffers and the expectations as hex in `AmberCase`. They run on the
// compute case of the assembly groups, the buffers with an expectation being the outputs. The scripts that need more of Amber are skipped
// by the generator and listed on its stderr.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase};
use crate::generated::shaders::spirv_assembly_amber::ALL_AMBER_CASE;
use crate::generated::shaders::spirv_assembly_convert::ALL_AMBER_CASE as ALL_CONVERT_CASE;
use crate::generated::shaders::spirv_assembly_cpp_asm::ALL_AMBER_CASE as ALL_CPP_ASM_CASE;
use crate::vk::programs::BinaryCollection;
use crate::vkt::{TestCase, TestCaseGroup};

/// The `rust_type` of the manifest entries: one Amber script.
#[derive(Clone, Copy)]
pub struct AmberCase {
    pub name: &'static str,
    pub dispatch_x: u32,
    pub dispatch_y: u32,
    pub dispatch_z: u32,
    /// `binding:hex` entries separated by `;`, the initial contents of every bound buffer in binding order.
    pub buffers: &'static str,
    /// `binding:hex:mask` entries for the buffers that must hold something specific after the dispatch; only the bytes the mask marks are compared.
    pub checks: &'static str,
    /// The width in bytes of the float elements compared with an absolute tolerance of 0.0001, 0 for an exact comparison.
    pub tolerance_width: u32,
    /// Hex of the push constant block, empty for none.
    pub push_constants: &'static str,
    /// Hex of each specialization constant's data, separated by `;`, constant 0 first.
    pub spec_constants: &'static str,
    pub features: &'static str,
    pub programs: BinaryCollection,
}

fn decode_hex(hex: &str) -> Vec<u8> {
    (0..hex.len() / 2)
        .map(|ndx| u8::from_str_radix(&hex[ndx * 2..ndx * 2 + 2], 16).expect("hex digits"))
        .collect()
}

fn parse_entries(entries: &str) -> Vec<(u32, Vec<u8>, Vec<u8>)> {
    entries
        .split(';')
        .filter(|entry| !entry.is_empty())
        .map(|entry| {
            let mut parts = entry.split(':');
            let binding = parts.next().expect("a binding").parse().expect("a binding number");
            let data = decode_hex(parts.next().expect("hex data"));
            let mask = parts.next().map(decode_hex).unwrap_or_default();
            (binding, data, mask)
        })
        .collect()
}

/// A half precision float as a double.
fn half_to_f64(bits: u16) -> f64 {
    let sign = if bits & 0x8000 != 0 { -1.0 } else { 1.0 };
    let exponent = i32::from((bits >> 10) & 0x1f);
    let mantissa = f64::from(bits & 0x3ff);
    match exponent {
        0 => sign * mantissa * 2.0f64.powi(-24),
        31 if mantissa == 0.0 => sign * f64::INFINITY,
        31 => f64::NAN,
        _ => sign * (1.0 + mantissa / 1024.0) * 2.0f64.powi(exponent - 15),
    }
}

/// Amber's `TOLERANCE .0001` on every float of the compared buffer.
fn compare_within_tolerance<const WIDTH: usize>(
    _inputs: &[Vec<u8>],
    outputs: &[Vec<u8>],
    expected: &[Vec<u8>],
) -> bool {
    let value = |bytes: &[u8]| -> f64 {
        match WIDTH {
            2 => half_to_f64(u16::from_le_bytes(bytes.try_into().expect("two bytes"))),
            4 => f64::from(f32::from_le_bytes(bytes.try_into().expect("four bytes"))),
            _ => f64::from_le_bytes(bytes.try_into().expect("eight bytes")),
        }
    };
    outputs.iter().zip(expected).all(|(output, expected)| {
        expected
            .chunks_exact(WIDTH)
            .zip(output.chunks_exact(WIDTH))
            .all(|(expected, result)| {
                let (expected, result) = (value(expected), value(result));
                (expected - result).abs() <= 0.0001 || (expected.is_nan() && result.is_nan()) || expected == result
            })
    })
}

/// Amber's `EXPECT a EQ_BUFFER b` where the shader writes both: the two outputs must end up byte for byte equal.
fn outputs_equal(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    outputs.len() == 2 && outputs[0] == outputs[1]
}

fn required_feature(name: &str) -> Option<RequiredFeature> {
    match name {
        "shaderFloat64" => Some(RequiredFeature::ShaderFloat64),
        "Float16Int8Features.shaderFloat16" => Some(RequiredFeature::ShaderFloat16),
        "Storage16BitFeatures.uniformAndStorageBuffer16BitAccess" => {
            Some(RequiredFeature::UniformAndStorageBuffer16BitAccess)
        }
        "Storage8BitFeatures.uniformAndStorageBuffer8BitAccess" => {
            Some(RequiredFeature::UniformAndStorageBuffer8BitAccess)
        }
        "shaderInt16" | "Features.shaderInt16" => Some(RequiredFeature::ShaderInt16),
        "shaderInt64" | "Features.shaderInt64" => Some(RequiredFeature::ShaderInt64),
        "Storage16BitFeatures.storageBuffer16BitAccess" => Some(RequiredFeature::StorageBuffer16BitAccess),
        "Float16Int8Features.shaderInt8" => Some(RequiredFeature::ShaderInt8),
        "Storage8BitFeatures.storageBuffer8BitAccess" => Some(RequiredFeature::StorageBuffer8BitAccess),
        "ShaderLongVectorFeaturesEXT.longVector" => Some(RequiredFeature::LongVector),
        "robustBufferAccess" => Some(RequiredFeature::RobustBufferAccess),
        _ => None,
    }
}

fn make_case(case: &AmberCase, leaf: &str) -> Box<dyn TestCase> {
    let buffers = parse_entries(case.buffers);
    let first_binding = buffers.iter().map(|(binding, _, _)| *binding).min().unwrap_or(0);
    let checks = parse_entries(case.checks);
    let mut spec = ComputeShaderSpec {
        num_work_groups: [case.dispatch_x, case.dispatch_y, case.dispatch_z],
        ..Default::default()
    };

    for (binding, initial, _) in buffers {
        match checks.iter().find(|(check_binding, _, _)| *check_binding == binding) {
            Some((_, expected, mask)) => {
                spec.outputs.push(expected.clone());
                spec.output_initial.push(initial);
                spec.output_masks.push(mask.clone());
            }
            None => spec.inputs.push(initial),
        }
    }
    let tokens: Vec<&str> = case.features.split(',').filter(|token| !token.is_empty()).collect();
    spec.leading_unused_bindings = first_binding;
    spec.array_count = tokens
        .iter()
        .find_map(|token| token.strip_prefix("ARRAY:"))
        .map_or(0, |count| count.parse().expect("a descriptor array length"));
    spec.push_constants = decode_hex(case.push_constants);
    spec.spec_constants = case
        .spec_constants
        .split(';')
        .filter(|hex| !hex.is_empty())
        .map(decode_hex)
        .collect();
    spec.verify_io = match case.tolerance_width {
        2 => Some(compare_within_tolerance::<2>),
        4 => Some(compare_within_tolerance::<4>),
        8 => Some(compare_within_tolerance::<8>),
        _ => None,
    };
    if case.features.split(',').any(|token| token == "EQ_OUTPUTS") {
        spec.verify_io = Some(outputs_equal);
    }
    spec.min_x_limit = if case.name.starts_with("permuted_index/") {
        256
    } else {
        0
    };
    spec.features = tokens.iter().copied().filter_map(required_feature).collect();
    spec.uniform_inputs = tokens.contains(&"UBO_INPUTS");
    spec.variable_pointers = tokens.contains(&"VariablePointerFeatures.variablePointers");
    spec.variable_pointers_storage_buffer = tokens.contains(&"VariablePointerFeatures.variablePointersStorageBuffer");
    spec.extensions = tokens
        .iter()
        .filter(|token| token.starts_with("VK_"))
        .map(|token| token.to_string())
        .collect();
    spec.spirv_1_3 = tokens.contains(&"VK_KHR_spirv_1_4");

    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

fn all_cases() -> impl Iterator<Item = (Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_AMBER_CASE
        .iter()
        .chain(ALL_CONVERT_CASE.iter())
        .chain(ALL_CPP_ASM_CASE.iter())
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (segments, make_case(case, leaf))
        })
}

/// The Amber scripts of `spirv_assembly.instruction.compute` as the groups of their path below `compute` and the test case.
pub fn create_amber_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    all_cases()
        .filter(|(groups, _)| {
            !matches!(
                groups.first(),
                Some(
                    &"compute_basic"
                        | &"permuted_index"
                        | &"spirv1p4"
                        | &"graphics"
                        | &"workgroup_memory_explicit_layout"
                        | &"zero_initialize_workgroup_memory"
                        | &"robustness"
                        | &"graphicsfuzz"
                        | &"crash_test"
                )
            )
        })
        .collect()
}

/// The compute scripts among the graphicsfuzz ones, for `graphicsfuzz/amber_tests.rs`.
pub fn create_graphicsfuzz_compute_cases() -> Vec<Box<dyn TestCase>> {
    all_cases()
        .filter(|(groups, _)| groups.first() == Some(&"graphicsfuzz"))
        .map(|(_, case)| case)
        .collect()
}

/// The compute script of the `crash_test` group of `glsl` (`divbyzero_comp`; the other stages are graphics scripts).
pub fn create_glsl_crash_test_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("crash_test");
    for (_, case) in all_cases().filter(|(groups, _)| groups.first() == Some(&"crash_test")) {
        group.add_child(case);
    }
    group
}

/// The Amber `misc` group of `createOOBAccessTests` (vktRobustnessOOBAccessTests.cpp): `robustness.oob_access.misc.fma_test_hang`.
pub fn create_robustness_misc_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("misc");
    for (_, case) in all_cases().filter(|(groups, _)| groups.first() == Some(&"robustness")) {
        group.add_child(case);
    }
    group
}

/// `AddCopyMemoryTests` and `AddZeroInitializeExtensionTests` of vktComputeWorkgroupMemoryExplicitLayoutTests.cpp: the `copy_memory` and `zero_ext`
/// groups of `compute.<construction type>.workgroup_memory_explicit_layout`, which upstream registers for the monolithic pipeline type only.
pub fn create_workgroup_memory_explicit_layout_amber_groups() -> Vec<TestCaseGroup> {
    let mut copy_memory = TestCaseGroup::new("copy_memory");
    let mut zero_ext = TestCaseGroup::new("zero_ext");
    for (segments, case) in
        all_cases().filter(|(groups, _)| groups.first() == Some(&"workgroup_memory_explicit_layout"))
    {
        if segments[1] == "copy_memory" {
            copy_memory.add_child(case);
        } else {
            zero_ext.add_child(case);
        }
    }
    vec![copy_memory, zero_ext]
}

/// `AddSharedMemoryTests` of vktComputeZeroInitializeWorkgroupMemoryTests.cpp: the `shared_memory_blocks` group, for the monolithic pipeline type only.
pub fn create_shared_memory_blocks_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("shared_memory_blocks");
    for (_, case) in all_cases().filter(|(groups, _)| groups.first() == Some(&"zero_initialize_workgroup_memory")) {
        group.add_child(case);
    }
    group
}

/// The `graphics` group of `instruction` as far as it is a compute Amber script: `switch_block_order.switch-case-to-merge-block`.
pub fn create_graphics_amber_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("graphics");
    let mut switch_block_order = TestCaseGroup::new("switch_block_order");
    for (_, case) in all_cases().filter(|(groups, _)| groups.first() == Some(&"graphics")) {
        switch_block_order.add_child(case);
    }
    group.add_child(switch_block_order);
    for early_fragment_group in super::early_fragment_tests::create_early_fragment_groups() {
        group.add_child(early_fragment_group);
    }
    group
}

/// `createSpirvVersion1p4Group` - `spirv_assembly.instruction.spirv1p4`, the groups in the order of the manifest (upstream's).
pub fn create_spirv1p4_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("spirv1p4");
    let mut sub_groups: Vec<(&'static str, TestCaseGroup)> = Vec::new();
    for (segments, case) in all_cases().filter(|(groups, _)| groups.first() == Some(&"spirv1p4")) {
        let sub_group_name = segments[1];
        let index = match sub_groups.iter().position(|(name, _)| *name == sub_group_name) {
            Some(index) => index,
            None => {
                sub_groups.push((sub_group_name, TestCaseGroup::new(sub_group_name)));
                sub_groups.len() - 1
            }
        };
        sub_groups[index].1.add_child(case);
    }
    for (_, sub_group) in sub_groups {
        group.add_child(sub_group);
    }
    group
}

/// The Amber scripts that upstream's `compute.pipeline.basic` registers, for `basic_compute_shader_tests.rs`.
pub fn create_compute_basic_amber_cases() -> Vec<Box<dyn TestCase>> {
    all_cases()
        .filter(|(groups, _)| groups.first() == Some(&"compute_basic"))
        .map(|(_, case)| case)
        .collect()
}

/// `createPermutedIndexTests` - `memory_model.message_passing.permuted_index`.
pub fn create_permuted_index_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("permuted_index");
    for (_, case) in all_cases().filter(|(groups, _)| groups.first() == Some(&"permuted_index")) {
        group.add_child(case);
    }
    group
}
