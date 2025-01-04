// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmUntypedPointersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported so far: variable_pointers.{op_ptr_diff,op_ptr_equal,op_ptr_not_equal,op_select,op_phi,op_function_call,op_ptr_access_chain,function_variable,private_variable,multiple_access_chains,workgroup_memory} and
// physical_storage.{op_bitcast,op_select,op_phi,op_function_call,op_ptr_access_chain} (`addPhysicalStorage*Tests`), block_array and type_punning.{reinterpret.{multiple_access_chains,memory_interpretation,struct_as_type},load.{uniform,storage,push_constant},store,copy.{from_untyped,to_untyped}.{op_copy_memory,op_copy_memory_sized}} (`addLoadMixedTypeTests`, `addStoreMixedTypeTests`, `addCopy*UntypedMixedTypeTests`), basic_usecase.{load,store,atomics.{load,store},copy,array_length,descriptor_array} (`addLoadTests`, `addStoreTests`, `addCopyTests`, `addOpArrayLengthTests`,
// `addDescriptorArrayTests`) and workgroup_memory_explicit_layout.{aliased,not_aliased} (`addWorkgroupMemoryExplicitLayoutInteractionTests`), each for both memory models: 2696 cases. The assembly
// is in `shaders/manifest/spirv_assembly_untyped_pointers.toml`, written by `scripts/gen_spirv_assembly_untyped_pointers_manifest.py`; the `spec` of a case is the memory model, the group, the
// container or kind and the type. The data are `createFilledBuffer`: random elements from `de::Random(deStringHash(group name))` (never fewer than 24 are drawn), or one value repeated.
// Where the container is a uniform buffer the elements sit 16 bytes apart (`padding`); the bytes between them are not compared.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase};
use super::utils::{
    float32_to_float16, get_float16s, get_float32s, get_float64s, get_int8s, get_int16s, get_int32s, get_int64s,
    get_uint8s, get_uint16s, get_uint32s, get_uint64s,
};
use crate::generated::shaders::spirv_assembly_untyped_pointers::ALL_UNTYPED_POINTERS_CASE;
use crate::tcu::random::{Random, de_string_hash};
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

const NUM_THREADS: u32 = 64;
const PUSH_CONSTANT_ELEMENTS: usize = 4;
/// A vec4 and a scalar.
const ELEMENT_COUNT: usize = 5;
const UNIFORM_ALIGNMENT: usize = 16;

/// The `rust_type` of the manifest entries: one `UntypedPointersCase`.
#[derive(Clone, Copy)]
pub struct UntypedPointersCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

fn field<'a>(spec: &'a str, key: &str) -> &'a str {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("untyped pointers spec without {key}"))
}

/// The `other` field of a punning case; `type` is the key of the other groups, so a punning spec has none.
fn type_name_other(spec: &str) -> &str {
    field(spec, "other")
}

fn size_of_type(type_name: &str) -> usize {
    match type_name {
        "uint8" | "int8" => 1,
        "uint16" | "int16" | "float16" => 2,
        "uint32" | "int32" | "float32" => 4,
        _ => 8,
    }
}

/// One element of the type holding `value`, as the bytes of the buffer (`createFilledBuffer` with `FillingTypes::VALUE`).
fn element(type_name: &str, value: u32) -> Vec<u8> {
    match type_name {
        "uint8" | "int8" => vec![value as u8],
        "uint16" | "int16" => (value as u16).to_le_bytes().to_vec(),
        "float16" => float32_to_float16(value as f32).to_le_bytes().to_vec(),
        "uint32" | "int32" => value.to_le_bytes().to_vec(),
        "float32" => (value as f32).to_le_bytes().to_vec(),
        "uint64" | "int64" => u64::from(value).to_le_bytes().to_vec(),
        _ => f64::from(value).to_le_bytes().to_vec(),
    }
}

fn filled_elements(type_name: &str, value: u32, count: usize) -> Vec<Vec<u8>> {
    vec![element(type_name, value); count]
}

/// `createFilledBuffer` with `FillingTypes::RANDOM`
fn random_elements(type_name: &str, count: usize, seed: u32) -> Vec<Vec<u8>> {
    let mut rnd = Random::new(seed);
    let drawn = count.max(24);
    let mut elements = match type_name {
        "uint8" => get_uint8s(&mut rnd, drawn),
        "int8" => get_int8s(&mut rnd, drawn),
        "uint16" => get_uint16s(&mut rnd, drawn),
        "int16" => get_int16s(&mut rnd, drawn),
        "float16" => get_float16s(&mut rnd, drawn),
        "uint32" => get_uint32s(&mut rnd, drawn),
        "int32" => get_int32s(&mut rnd, drawn),
        "float32" => get_float32s(&mut rnd, drawn),
        "uint64" => get_uint64s(&mut rnd, drawn),
        "int64" => get_int64s(&mut rnd, drawn),
        _ => get_float64s(&mut rnd, drawn),
    };
    elements.truncate(count);
    elements
}

/// The elements one after the other, each followed by `padding` bytes (`Buffer<T>` with a padding), and the mask that compares the elements only.
fn buffer_bytes(elements: &[Vec<u8>], padding: usize) -> (Vec<u8>, Vec<u8>) {
    let mut bytes = Vec::new();
    let mut mask = Vec::new();
    for element in elements {
        bytes.extend_from_slice(element);
        mask.extend(std::iter::repeat_n(0xffu8, element.len()));
        bytes.extend(std::iter::repeat_n(0xffu8, padding));
        mask.extend(std::iter::repeat_n(0u8, padding));
    }
    (bytes, mask)
}

fn flatten(elements: &[Vec<u8>]) -> Vec<u8> {
    elements.concat()
}

/// `adjustSpecForUntypedPointers`, `adjustSpecForMemoryModel` and `adjustSpecForDataTypes`
fn common_requirements(model: &str, type_name: &str) -> (Vec<String>, Vec<RequiredFeature>) {
    let mut extensions = vec!["VK_KHR_shader_untyped_pointers".to_string()];
    let mut features = vec![RequiredFeature::ShaderUntypedPointers];
    if model == "vulkan" {
        extensions.push("VK_KHR_vulkan_memory_model".to_string());
    }
    match type_name {
        "uint8" | "int8" => features.push(RequiredFeature::ShaderInt8),
        "uint16" | "int16" => features.push(RequiredFeature::ShaderInt16),
        "float16" => features.push(RequiredFeature::ShaderFloat16),
        "float64" => features.push(RequiredFeature::ShaderFloat64),
        "uint64" | "int64" => features.push(RequiredFeature::ShaderInt64),
        _ => {}
    }
    extensions.push("VK_KHR_storage_buffer_storage_class".to_string());
    (extensions, features)
}

/// The feature `adjustSpecForDataTypes` requests for the type.
fn type_feature(type_name: &str) -> Option<RequiredFeature> {
    match type_name {
        "uint8" | "int8" => Some(RequiredFeature::ShaderInt8),
        "uint16" | "int16" => Some(RequiredFeature::ShaderInt16),
        "float16" => Some(RequiredFeature::ShaderFloat16),
        "float64" => Some(RequiredFeature::ShaderFloat64),
        "uint64" | "int64" => Some(RequiredFeature::ShaderInt64),
        _ => None,
    }
}

/// `adjustSpecForSmallContainerType`
fn small_container_feature(container: &str, type_name: &str) -> Option<RequiredFeature> {
    match (type_name, container) {
        ("uint8" | "int8", "storage") => Some(RequiredFeature::StorageBuffer8BitAccess),
        ("uint8" | "int8", "uniform") => Some(RequiredFeature::UniformAndStorageBuffer8BitAccess),
        ("uint8" | "int8", "push_constant") => Some(RequiredFeature::StoragePushConstant8),
        ("uint16" | "int16" | "float16", "storage") => Some(RequiredFeature::StorageBuffer16BitAccess),
        ("uint16" | "int16" | "float16", "uniform") => Some(RequiredFeature::UniformAndStorageBuffer16BitAccess),
        ("uint16" | "int16" | "float16", "push_constant") => Some(RequiredFeature::StoragePushConstant16),
        _ => None,
    }
}

fn load_spec(model: &str, container: &str, type_name: &str) -> ComputeShaderSpec {
    let count = if container == "push_constant" {
        PUSH_CONSTANT_ELEMENTS
    } else {
        NUM_THREADS as usize
    };
    let elements = random_elements(type_name, count, de_string_hash("load"));
    let padding = if container == "uniform" {
        UNIFORM_ALIGNMENT - size_of_type(type_name)
    } else {
        0
    };
    let (bytes, mask) = buffer_bytes(&elements, padding);
    let (extensions, mut features) = common_requirements(model, type_name);
    features.extend(small_container_feature(container, type_name));

    let mut spec = ComputeShaderSpec {
        outputs: vec![bytes.clone()],
        output_masks: vec![mask],
        num_work_groups: [count as u32, 1, 1],
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    };
    match container {
        "push_constant" => spec.push_constants = bytes,
        "uniform" => {
            spec.inputs = vec![bytes];
            spec.uniform_inputs = true;
        }
        _ => spec.inputs = vec![bytes],
    }
    spec
}

/// `addStoreTests` (seeded by the name of its group, `store`) and `addCopyTests` (by `from_untyped` or `to_untyped`): the input is the output.
fn store_spec(model: &str, type_name: &str, group_name: &str) -> ComputeShaderSpec {
    let elements = random_elements(type_name, NUM_THREADS as usize, de_string_hash(group_name));
    let bytes = flatten(&elements);
    let (extensions, mut features) = common_requirements(model, type_name);
    features.extend(small_container_feature("storage", type_name));
    ComputeShaderSpec {
        inputs: vec![bytes.clone()],
        outputs: vec![bytes],
        num_work_groups: [NUM_THREADS, 1, 1],
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    }
}

fn array_length_spec(model: &str, type_name: &str) -> ComputeShaderSpec {
    const NUM_WORKGROUP: u32 = 16;
    let (extensions, features) = common_requirements(model, type_name);
    ComputeShaderSpec {
        inputs: vec![flatten(&filled_elements(type_name, 1, NUM_WORKGROUP as usize))],
        outputs: vec![NUM_WORKGROUP.to_le_bytes().to_vec()],
        num_work_groups: [NUM_WORKGROUP, 1, 1],
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    }
}

fn descriptor_array_spec(model: &str, type_name: &str) -> ComputeShaderSpec {
    let bytes = flatten(&filled_elements(type_name, 1, 4));
    let (mut extensions, features) = common_requirements(model, type_name);
    extensions.push("VK_KHR_variable_pointers".to_string());
    ComputeShaderSpec {
        inputs: vec![bytes.clone()],
        outputs: vec![bytes],
        num_work_groups: [1, 1, 1],
        extensions,
        features,
        variable_pointers: true,
        variable_pointers_storage_buffer: true,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    }
}

/// `addWorkgroupMemoryExplicitLayoutInteractionTests`: the inputs hold 1 and 4 (a vec4 and a scalar each), the shader copies them through workgroup memory, aliased (both outputs hold the second
/// input) or not (each output holds its input).
fn workgroup_spec(model: &str, aliased: bool, type_name: &str) -> ComputeShaderSpec {
    let input0 = flatten(&filled_elements(type_name, 1, ELEMENT_COUNT));
    let input1 = flatten(&filled_elements(type_name, 4, ELEMENT_COUNT));
    let outputs = if aliased {
        vec![input1.clone(), input1.clone()]
    } else {
        vec![input0.clone(), input1.clone()]
    };
    let (mut extensions, mut features) = common_requirements(model, type_name);
    match type_name {
        "uint8" | "int8" => features.push(RequiredFeature::WorkgroupMemoryExplicitLayout8BitAccess),
        "uint16" | "int16" | "float16" => features.push(RequiredFeature::WorkgroupMemoryExplicitLayout16BitAccess),
        _ => {}
    }
    features.push(RequiredFeature::WorkgroupMemoryExplicitLayout);
    extensions.push("VK_KHR_workgroup_memory_explicit_layout".to_string());
    ComputeShaderSpec {
        inputs: vec![input0, input1],
        outputs,
        num_work_groups: [NUM_THREADS, 1, 1],
        extensions,
        features,
        spirv_version_minor: Some(4),
        ..Default::default()
    }
}

/// The physical storage buffer group: `addPhysicalStorageOpBitcastTests` (the buffer holds 1 and is also the output), `addPhysicalStorageOpSelectTests` and `addPhysicalStorageOpPhiTests` (two inputs holding
/// 1 and 0, the output holds 1 in `first` and 0 in `second`, which is also the uint32 push constant that picks the input), `addPhysicalStorageOpFunctionCallTests` (1) and
/// `addPhysicalStorageOpPtrAccessChainTests` (one random element, seeded by the group name). Every buffer is reached through its device address.
fn physical_spec(model: &str, op: &str, sub: &str, type_name: &str) -> ComputeShaderSpec {
    let (mut extensions, features) = common_requirements(model, type_name);
    extensions.push("VK_KHR_buffer_device_address".to_string());
    let mut spec = ComputeShaderSpec {
        num_work_groups: [1, 1, 1],
        uses_phys_storage_buffer: true,
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    };
    match op {
        "op_select" | "op_phi" => {
            let selected = u32::from(sub == "first");
            spec.inputs = vec![element(type_name, 1), element(type_name, 0)];
            spec.outputs = vec![element(type_name, selected)];
            spec.push_constants = selected.to_le_bytes().to_vec();
            spec.spirv_1_3 = false;
            spec.spirv_version_minor = Some(4);
        }
        "op_ptr_access_chain" => {
            let bytes = flatten(&random_elements(type_name, 1, de_string_hash("op_ptr_access_chain")));
            spec.inputs = vec![bytes.clone()];
            spec.outputs = vec![bytes];
        }
        _ => {
            let bytes = element(type_name, 1);
            spec.inputs = vec![bytes.clone()];
            spec.outputs = vec![bytes];
        }
    }
    spec
}

/// The elements 0, 1, 2, ... converted to the type (`FillingTypes::INCREMENTED`).
fn incremented_elements(type_name: &str, count: u32) -> Vec<Vec<u8>> {
    (0..count).map(|ndx| element(type_name, ndx)).collect()
}

/// The size of the second type of `multiple_access_chains` (`getSecondTypeForVarPtrs`): int16 for the 8 bit and 32 bit base types, int32 for the 16 bit and 64 bit ones.
fn second_type_size(type_name: &str) -> usize {
    match type_name {
        "uint8" | "int8" | "uint32" | "int32" | "float32" => 2,
        _ => 4,
    }
}

/// The variable_pointers group of the tests with one case per type: op_select and op_phi (first/second, `addVariablePtrOpSelectTests`), op_function_call, op_ptr_access_chain, function_variable,
/// private_variable, multiple_access_chains and workgroup_memory.
fn variable_pointers_spec(model: &str, op: &str, sub: &str, type_name: &str) -> ComputeShaderSpec {
    let (mut extensions, mut features) = common_requirements(model, type_name);
    extensions.push("VK_KHR_variable_pointers".to_string());
    let mut spec = ComputeShaderSpec {
        num_work_groups: [1, 1, 1],
        variable_pointers: true,
        variable_pointers_storage_buffer: true,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    };
    match op {
        "op_select" | "op_phi" => {
            let selected = u32::from(sub == "first");
            spec.inputs = vec![element(type_name, 1), element(type_name, 0)];
            spec.outputs = vec![element(type_name, selected)];
            spec.push_constants = selected.to_le_bytes().to_vec();
            spec.spirv_1_3 = false;
            spec.spirv_version_minor = Some(4);
        }
        "op_function_call" => {
            spec.inputs = vec![flatten(&incremented_elements(type_name, 32))];
            spec.outputs = vec![element(type_name, 8)];
        }
        "op_ptr_access_chain" | "workgroup_memory" => {
            let bytes = flatten(&random_elements(type_name, NUM_THREADS as usize, de_string_hash(op)));
            spec.inputs = vec![bytes.clone()];
            spec.outputs = vec![bytes];
            spec.num_work_groups = [NUM_THREADS, 1, 1];
            if op == "workgroup_memory" {
                match type_name {
                    "uint8" | "int8" => features.push(RequiredFeature::WorkgroupMemoryExplicitLayout8BitAccess),
                    "uint16" | "int16" | "float16" => {
                        features.push(RequiredFeature::WorkgroupMemoryExplicitLayout16BitAccess)
                    }
                    _ => {}
                }
                features.push(RequiredFeature::WorkgroupMemoryExplicitLayout);
                extensions.push("VK_KHR_workgroup_memory_explicit_layout".to_string());
                spec.spirv_1_3 = false;
                spec.spirv_version_minor = Some(4);
            }
        }
        "multiple_access_chains" => {
            let input = flatten(&incremented_elements(type_name, 32));
            let second_size = second_type_size(type_name);
            let byte_offset = 4 * size_of_type(type_name) + 8 * second_size;
            spec.outputs = vec![input[byte_offset..byte_offset + second_size].to_vec()];
            spec.inputs = vec![input];
            features.push(RequiredFeature::ShaderInt16);
        }
        _ => {
            // function_variable and private_variable
            spec.inputs = vec![element(type_name, 1), element(type_name, 0)];
            spec.outputs = vec![element(type_name, 1)];
            spec.push_constants = 1u32.to_le_bytes().to_vec();
        }
    }
    spec.extensions = extensions;
    spec.features = features;
    spec
}

/// `addVariablePtrOpPtrEqualTests` and `addVariablePtrOpPtrNotEqualTests`: six blocks of cases (blocks 1 to 3 compare pointers that are equal, 4 to 6 pointers that are not), the output is the uint32
/// 1 where the instruction must say true and 0 where it must say false.
fn pointer_compare_spec(model: &str, op: &str, block: u32, type_name: &str) -> ComputeShaderSpec {
    let (mut extensions, mut features) = common_requirements(model, type_name);
    extensions.push("VK_KHR_variable_pointers".to_string());
    if block == 2 {
        features.push(RequiredFeature::ShaderInt16);
    }
    let pointers_equal = block <= 3;
    let expected = u32::from(pointers_equal == (op == "op_ptr_equal"));
    ComputeShaderSpec {
        inputs: vec![flatten(&incremented_elements(type_name, 32))],
        outputs: vec![expected.to_le_bytes().to_vec()],
        num_work_groups: [1, 1, 1],
        extensions,
        features,
        variable_pointers: true,
        variable_pointers_storage_buffer: true,
        spirv_version_minor: Some(4),
        ..Default::default()
    }
}

/// `addVariablePtrOpPtrDiffTests`: 32 random elements; the difference of the pointers in bytes is 12 elements of the type in block 1 and 0 in block 2 (the same byte offset in arrays of two types).
fn pointer_diff_spec(model: &str, block: u32, type_name: &str) -> ComputeShaderSpec {
    let (mut extensions, mut features) = common_requirements(model, type_name);
    extensions.push("VK_KHR_variable_pointers".to_string());
    if block == 2 {
        features.push(RequiredFeature::ShaderInt16);
    }
    let difference = if block == 1 {
        12 * size_of_type(type_name) as u32
    } else {
        0
    };
    ComputeShaderSpec {
        inputs: vec![flatten(&random_elements(type_name, 32, de_string_hash("op_ptr_diff")))],
        outputs: vec![difference.to_le_bytes().to_vec()],
        num_work_groups: [1, 1, 1],
        extensions,
        features,
        variable_pointers: true,
        variable_pointers_storage_buffer: true,
        spirv_version_minor: Some(4),
        ..Default::default()
    }
}

/// `addLoadAtomicTests` and `addStoreAtomicTests` (`adjustSpecForAtomicOperations`): the input is the output, random elements seeded by the group name (`load` or `store`).
fn atomic_spec(model: &str, kind: &str, type_name: &str) -> ComputeShaderSpec {
    let (mut extensions, mut features) = common_requirements(model, type_name);
    match type_name {
        "float16" => {
            extensions.push("VK_EXT_shader_atomic_float".to_string());
            extensions.push("VK_EXT_shader_atomic_float2".to_string());
            features.push(RequiredFeature::ShaderBufferFloat16Atomics);
        }
        "float32" => {
            extensions.push("VK_EXT_shader_atomic_float".to_string());
            features.push(RequiredFeature::ShaderBufferFloat32Atomics);
        }
        "float64" => {
            extensions.push("VK_EXT_shader_atomic_float".to_string());
            features.push(RequiredFeature::ShaderBufferFloat64Atomics);
        }
        "uint64" | "int64" => {
            extensions.push("VK_KHR_shader_atomic_int64".to_string());
            features.push(RequiredFeature::ShaderBufferInt64Atomics);
        }
        _ => {}
    }
    let bytes = flatten(&random_elements(type_name, NUM_THREADS as usize, de_string_hash(kind)));
    ComputeShaderSpec {
        inputs: vec![bytes.clone()],
        outputs: vec![bytes],
        num_work_groups: [NUM_THREADS, 1, 1],
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    }
}

/// One element of the type holding the integer `value` (wrapping), a float type holding it as a number.
fn atomic_value(type_name: &str, value: i64) -> Vec<u8> {
    match type_name {
        "uint8" | "int8" => vec![value as u8],
        "uint16" | "int16" => (value as u16).to_le_bytes().to_vec(),
        "float16" => float32_to_float16(value as f32).to_le_bytes().to_vec(),
        "uint32" | "int32" => (value as u32).to_le_bytes().to_vec(),
        "float32" => (value as f32).to_le_bytes().to_vec(),
        "uint64" | "int64" => (value as u64).to_le_bytes().to_vec(),
        _ => (value as f64).to_le_bytes().to_vec(),
    }
}

/// `getSignedUnsignedMinMaxTestValue`
fn min_max_test_value(type_name: &str) -> i64 {
    match type_name {
        "int8" | "int16" | "int32" | "float32" | "int64" => -1,
        _ => 1,
    }
}

/// `addAtomicAddTests` ... `addAtomicCompareExchangeTests`: one element, which the shader stores 0 into (1 for compare_exchange) before the one atomic operation; the output is what the
/// `AtomicBuffer` of upstream expects after applying the operation (`comp` is the compare value of compare_exchange).
fn atomic_op_spec(model: &str, op: &str, comp: &str, type_name: &str) -> ComputeShaderSpec {
    let mut spec = atomic_spec(model, "load", type_name);
    let is_float = matches!(type_name, "float16" | "float32" | "float64");
    let bits = size_of_type(type_name) * 8;
    let expected: i64 = match op {
        "add" => 16,
        "subtract" => -16,
        "increment" => 1,
        "decrement" => -1,
        "min" => {
            if min_max_test_value(type_name) < 0 {
                -1
            } else {
                0
            }
        }
        "max" => {
            if min_max_test_value(type_name) > 0 {
                1
            } else {
                0
            }
        }
        "and" => 0,
        "or" | "xor" | "exchange" => 1,
        _ => {
            if comp == "1" {
                16
            } else {
                1
            }
        }
    };
    if is_float && op == "add" {
        spec.features.push(match bits {
            16 => RequiredFeature::ShaderBufferFloat16AtomicAdd,
            32 => RequiredFeature::ShaderBufferFloat32AtomicAdd,
            _ => RequiredFeature::ShaderBufferFloat64AtomicAdd,
        });
    }
    if is_float && (op == "min" || op == "max") {
        spec.features.push(match bits {
            16 => RequiredFeature::ShaderBufferFloat16AtomicMinMax,
            32 => RequiredFeature::ShaderBufferFloat32AtomicMinMax,
            _ => RequiredFeature::ShaderBufferFloat64AtomicMinMax,
        });
        if !spec
            .extensions
            .iter()
            .any(|extension| extension == "VK_EXT_shader_atomic_float2")
        {
            spec.extensions.push("VK_EXT_shader_atomic_float2".to_string());
        }
    }
    spec.inputs = Vec::new();
    spec.outputs = vec![atomic_value(type_name, expected)];
    spec.num_work_groups = [1, 1, 1];
    spec.spirv_1_3 = false;
    spec.spirv_version_minor = Some(4);
    spec
}

/// `addLoadMixedTypeTests`: section 1 loads a scalar as another scalar of the size (the buffer holds random elements of the other type, as in `load`), 2 a scalar as a vector and 3 a vector as a scalar
/// (the buffer holds the value 1, twice the elements the result has; padding is not used there, even for the uniform buffer).
fn punning_load_spec(
    model: &str,
    section: u32,
    container: &str,
    base: &str,
    other: &str,
    comp: &str,
) -> ComputeShaderSpec {
    let (extensions, mut features) = common_requirements(model, base);
    let elements_of_vector = comp
        .strip_prefix("vec")
        .and_then(|rest| rest[..1].parse::<usize>().ok())
        .unwrap_or(1);
    let size_differs = size_of_type(base) != size_of_type(other);

    let (input, output, mask, work_groups) = if section == 1 {
        let count = if container == "push_constant" {
            PUSH_CONSTANT_ELEMENTS
        } else {
            NUM_THREADS as usize
        };
        let elements = random_elements(other, count, de_string_hash("load"));
        let padding = if container == "uniform" {
            UNIFORM_ALIGNMENT - size_of_type(base)
        } else {
            0
        };
        let (bytes, mask) = buffer_bytes(&elements, padding);
        features.extend(type_feature(other));
        features.extend(small_container_feature(container, base));
        if container != "storage" {
            features.extend(small_container_feature("storage", base));
        }
        (bytes.clone(), bytes, mask, count as u32)
    } else {
        let output_count = if section == 2 { 1 } else { elements_of_vector };
        let input = flatten(&filled_elements(base, 1, output_count * 2));
        let output = flatten(&filled_elements(base, 1, output_count));
        let mask = vec![0xffu8; output.len()];
        if section == 2 {
            if base != other {
                features.extend(type_feature(other));
                features.extend(small_container_feature(container, other));
            }
        } else {
            if base != other {
                features.extend(type_feature(other));
            }
            features.extend(small_container_feature(container, base));
        }
        if size_differs || container != "storage" {
            features.extend(small_container_feature("storage", other));
        }
        (input, output, mask, 1)
    };

    let mut spec = ComputeShaderSpec {
        outputs: vec![output],
        output_masks: vec![mask],
        num_work_groups: [work_groups, 1, 1],
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    };
    match container {
        "push_constant" => spec.push_constants = input,
        "uniform" => {
            spec.inputs = vec![input];
            spec.uniform_inputs = true;
        }
        _ => spec.inputs = vec![input],
    }
    spec
}

/// `addStoreMixedTypeTests`: the input is the output. Section 1 holds 64 random elements of the base type (seeded by `store`), sections 2 and 3 the value 1, once for a scalar base and as many times as the
/// vector has components for a vector base.
///
/// `addCopyFromUntypedMixedTypeTests` and `addCopyToUntypedMixedTypeTests` (`seed_name` is the name of the direction, `copy` true) have the same data; they request the small container feature of the base
/// type only.
fn punning_store_spec(
    model: &str,
    section: u32,
    base: &str,
    other: &str,
    comp: &str,
    seed_name: &str,
    copy: bool,
) -> ComputeShaderSpec {
    let (extensions, mut features) = common_requirements(model, base);
    let elements_of_vector = comp
        .strip_prefix("vec")
        .and_then(|rest| rest[..1].parse::<usize>().ok())
        .unwrap_or(1);
    let (bytes, work_groups) = match section {
        1 => (
            flatten(&random_elements(base, NUM_THREADS as usize, de_string_hash(seed_name))),
            NUM_THREADS,
        ),
        2 => (flatten(&filled_elements(base, 1, 1)), 1),
        _ => (flatten(&filled_elements(base, 1, elements_of_vector)), 1),
    };
    if base != other {
        features.extend(type_feature(other));
    }
    features.extend(small_container_feature("storage", base));
    if !copy && size_of_type(base) != size_of_type(other) {
        features.extend(small_container_feature("storage", other));
    }
    ComputeShaderSpec {
        inputs: vec![bytes.clone()],
        outputs: vec![bytes],
        num_work_groups: [work_groups, 1, 1],
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    }
}

/// `addMultipleAccessChainTests`: two elements of the type holding 2, copied by 64 invocations.
fn multiple_access_chains_spec(model: &str, type_name: &str) -> ComputeShaderSpec {
    let (extensions, mut features) = common_requirements(model, type_name);
    features.extend(small_container_feature("storage", type_name));
    let bytes = flatten(&filled_elements(type_name, 2, 2));
    ComputeShaderSpec {
        inputs: vec![bytes.clone()],
        outputs: vec![bytes],
        num_work_groups: [NUM_THREADS, 1, 1],
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    }
}

fn u32_bytes(values: &[u32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_le_bytes()).collect()
}

/// `addMemoryReinterpretationTests`: four invocations each read one uint32 at a byte offset of the buffer through an untyped pointer (or write it), the other words of the output stay 0xffffffff.
fn memory_interpretation_spec(model: &str, read: bool, case: &str) -> ComputeShaderSpec {
    const NUM_WORKGROUPS: usize = 4;
    const BUFFER_SIZE: usize = 128;
    let (offsets, indices): ([usize; 4], [u32; 4]) = match case {
        "large_array_stride" => ([16, 24, 32, 40], [2, 3, 4, 5]),
        "non_zero_offset" => ([5, 17, 29, 41], [0, 2, 4, 6]),
        "mixed_offsets" => ([16, 2, 12, 0], [0, 1, 2, 3]),
        "multiple_access_chains" => ([15, 27, 33, 39], [2, 4, 5, 6]),
        _ => ([1, 3, 5, 7], [1, 3, 5, 7]),
    };
    let input_size = if read { BUFFER_SIZE } else { NUM_WORKGROUPS };
    let output_size = if read { NUM_WORKGROUPS } else { BUFFER_SIZE };
    let mut input = vec![0u32; input_size];
    let mut output = vec![0xffff_ffffu32; output_size];
    let mut magic = 42u32;
    for (ndx, &offset) in offsets.iter().enumerate() {
        let output_value = if case == "char2_16bit_storage_cap" {
            0xffff_0000 | magic
        } else {
            magic
        };
        let (input_ndx, output_ndx) = if read { (offset, ndx) } else { (ndx, offset) };
        input[input_ndx] = magic;
        output[output_ndx] = output_value;
        magic += 1;
    }
    let (extensions, mut features) = common_requirements(model, "uint32");
    match case {
        "short2_no_storage_cap" => features.push(RequiredFeature::ShaderInt16),
        "char4_no_storage_cap" => features.push(RequiredFeature::ShaderInt8),
        "char2_16bit_storage_cap" => features.extend([
            RequiredFeature::StorageBuffer16BitAccess,
            RequiredFeature::ShaderInt8,
            RequiredFeature::ShaderInt16,
        ]),
        _ => {}
    }
    ComputeShaderSpec {
        inputs: vec![u32_bytes(&input), u32_bytes(&indices)],
        outputs: vec![u32_bytes(&output)],
        num_work_groups: [NUM_WORKGROUPS as u32, 1, 1],
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    }
}

/// `addStructAsTypeTests`: six custom struct reinterpretations. In every one the output is the input byte for byte (the C++ fills the two structs with the same values), so the data is built once.
fn struct_as_type_spec(model: &str, case: &str) -> ComputeShaderSpec {
    let f32_bytes = |value: f32| value.to_le_bytes().to_vec();
    let f16_bytes = |value: f32| float32_to_float16(value).to_le_bytes().to_vec();
    let (bytes, datatypes, small_types): (Vec<u8>, &[&str], &[&str]) = match case {
        "vec2_uint32_vec2_float32_to_vec4_int32" => (
            [
                0u32.to_le_bytes().to_vec(),
                1u32.to_le_bytes().to_vec(),
                f32_bytes(1.0),
                f32_bytes(1.0),
            ]
            .concat(),
            &[],
            &[],
        ),
        "uint32_to_uint8_uint8_uint8_uint8" => (0x0101_0101u32.to_le_bytes().to_vec(), &["uint8"], &["uint8"]),
        "vec4_float16_vec2_int32_to_float16_vec2_float16_float16_int32_int32" => (
            [
                f16_bytes(1.0),
                f16_bytes(-100.0),
                f16_bytes(17.312),
                f16_bytes(-1.11),
                1i32.to_le_bytes().to_vec(),
                (-1i32).to_le_bytes().to_vec(),
            ]
            .concat(),
            &["float16"],
            &["float16"],
        ),
        "nested_struct_int32_int32_int32_int32_to_vec2_int32_vec2_int32" => (
            [
                0i32.to_le_bytes().to_vec(),
                1i32.to_le_bytes().to_vec(),
                (-1i32).to_le_bytes().to_vec(),
                i32::MAX.to_le_bytes().to_vec(),
            ]
            .concat(),
            &[],
            &[],
        ),
        "int64_uint64_vec2_float64_to_nested_struct_vec4_int64" => (
            [
                i64::MAX.to_le_bytes().to_vec(),
                1u64.to_le_bytes().to_vec(),
                0.0f64.to_le_bytes().to_vec(),
                (-112.0f64).to_le_bytes().to_vec(),
            ]
            .concat(),
            &["int64", "float64"],
            &[],
        ),
        _ => (
            0x0001_0001_0001_0001u64.to_le_bytes().to_vec(),
            &["int64", "int16"],
            &["uint16"],
        ),
    };
    let (extensions, mut features) = common_requirements(model, "uint32");
    for type_name in datatypes {
        features.extend(type_feature(type_name));
    }
    for type_name in small_types {
        features.extend(small_container_feature("storage", type_name));
    }
    ComputeShaderSpec {
        inputs: vec![bytes.clone()],
        outputs: vec![bytes],
        num_work_groups: [NUM_THREADS, 1, 1],
        extensions,
        features,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    }
}

/// `addBlockArrayTests`: four invocations each read one uint32 from an array of four blocks (the last four inputs are the array) at the index the first input holds.
fn block_array_spec(model: &str, case: &str) -> ComputeShaderSpec {
    const BUFFER_SIZE: usize = 128;
    let (mut extensions, mut features) = common_requirements(model, "uint32");
    extensions.push("VK_EXT_descriptor_indexing".to_string());
    features.push(RequiredFeature::ShaderStorageBufferArrayDynamicIndexing);
    let variable_pointers = matches!(
        case,
        "reinterpret_block_normal_ptr_access_chain"
            | "reinterpret_block_untyped_ptr_access_chain"
            | "select_block_normal_access_chain"
            | "select_block_normal_ptr_access_chain"
            | "select_block_untyped_access_chain"
            | "select_block_untyped_ptr_access_chain"
    );
    if variable_pointers {
        extensions.push("VK_KHR_variable_pointers".to_string());
    }
    let positions: [usize; 4] = if case == "basic" {
        [0, 4, 8, 12]
    } else {
        [0, 16, 32, 48]
    };
    let mut inputs = vec![u32_bytes(&[0, 4, 8, 12])];
    for (buffer_ndx, &position) in positions.iter().enumerate() {
        let mut data = vec![0u32; BUFFER_SIZE];
        data[position] = 42 + buffer_ndx as u32;
        inputs.push(u32_bytes(&data));
    }
    ComputeShaderSpec {
        inputs,
        outputs: vec![u32_bytes(&[42, 43, 44, 45])],
        num_work_groups: [4, 1, 1],
        extensions,
        features,
        array_count: 4,
        variable_pointers_storage_buffer: variable_pointers,
        spirv_1_3: model == "vulkan",
        ..Default::default()
    }
}

fn make_case(case: &UntypedPointersCase, leaf: &str) -> Box<dyn TestCase> {
    let model = field(case.spec, "model");
    let group = field(case.spec, "group");
    let type_name = if matches!(
        group,
        "punload" | "punstore" | "puncopy" | "pumi" | "pustruct" | "blockarray"
    ) {
        ""
    } else {
        field(case.spec, "type")
    };
    let spec = match group {
        "load" => load_spec(model, field(case.spec, "container"), type_name),
        "store" => store_spec(model, type_name, "store"),
        "copy" => store_spec(model, type_name, field(case.spec, "kind")),
        "array_length" => array_length_spec(model, type_name),
        "descriptor_array" => descriptor_array_spec(model, type_name),
        "punload" => punning_load_spec(
            model,
            field(case.spec, "section").parse().expect("a section number"),
            field(case.spec, "container"),
            field(case.spec, "base"),
            type_name_other(case.spec),
            field(case.spec, "comp"),
        ),
        "punstore" => punning_store_spec(
            model,
            field(case.spec, "section").parse().expect("a section number"),
            field(case.spec, "base"),
            field(case.spec, "other"),
            field(case.spec, "comp"),
            "store",
            false,
        ),
        "puncopy" => punning_store_spec(
            model,
            field(case.spec, "section").parse().expect("a section number"),
            field(case.spec, "base"),
            field(case.spec, "other"),
            field(case.spec, "comp"),
            field(case.spec, "kind"),
            true,
        ),
        "blockarray" => block_array_spec(model, field(case.spec, "case")),
        "pustruct" => struct_as_type_spec(model, field(case.spec, "case")),
        "pumi" => memory_interpretation_spec(model, field(case.spec, "kind") == "read", field(case.spec, "case")),
        "pumac" => multiple_access_chains_spec(model, type_name),
        "atomic" => atomic_spec(model, field(case.spec, "kind"), type_name),
        "atomicop" => atomic_op_spec(model, field(case.spec, "kind"), field(case.spec, "comp"), type_name),
        "ptrcmp" => pointer_compare_spec(
            model,
            field(case.spec, "op"),
            field(case.spec, "block").parse().expect("a block number"),
            type_name,
        ),
        "ptrdiff" => pointer_diff_spec(
            model,
            field(case.spec, "block").parse().expect("a block number"),
            type_name,
        ),
        "varptr" => variable_pointers_spec(model, field(case.spec, "op"), field(case.spec, "sub"), type_name),
        "physical" => physical_spec(model, field(case.spec, "op"), field(case.spec, "sub"), type_name),
        _ => workgroup_spec(model, field(case.spec, "kind") == "aliased", type_name),
    };
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

/// `createUntypedPointersTestGroup`, as the groups of each case path below `compute` and the case.
pub fn create_untyped_pointers_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_UNTYPED_POINTERS_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (segments, make_case(case, leaf))
        })
        .collect()
}
