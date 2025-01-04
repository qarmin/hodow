// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsm16bitStorageTests.cpp (`addCompute16bitStorageUniform16StructTo32StructGroup` and
//   `addCompute16bitStorageUniform32StructTo16StructGroup`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the four cases is in `shaders/manifest/spirv_assembly_16bit_struct.toml` (written by
// `scripts/gen_spirv_assembly_16bit_struct_manifest.py`). Upstream marks which slots of a struct hold data in the `info16bitStd140`-style vectors and compares the data slots
// of the two sides in order; the same slots are enumerated here from the offsets and strides the assembly decorates the members with (`Layout`), which also state where the padding is.
// The struct is `{ f, v2, v3, v4, f[3], { f, v2[3] }[11], v2[11], f, v3[11], v4[3] }` of one element type, seven of them in an array.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase, VerifyIo};
use super::graphics_storage_data::{
    mixed_struct_io, mixed_struct8_io, struct8_verifier, verify_mixed_struct, verify_mixed_struct8,
};
use super::storage16_tests::compare_16bit_float;
use super::utils::{float16_to_float32, get_float16s, get_float32s, get_int8s, get_int32s};
use crate::generated::shaders::spirv_assembly_16bit_struct::ALL_STRUCT16_CASE;
use crate::tcu::de_string_hash;
use crate::tcu::random::Random;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

const STRUCT_ARRAY_SIZE: usize = 7;
const NESTED_ARRAY_SIZE: usize = 11;

/// The `rust_type` of the manifest entries: one test case of the two groups.
#[derive(Clone, Copy)]
pub struct Struct16Case {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

/// The offsets (bytes) and strides the `getStructShaderComponet` strings decorate, for one element size.
struct Layout {
    element: usize,
    stride: usize,
    v2: usize,
    v3: usize,
    v4: usize,
    scalars: (usize, usize),
    nested: (usize, usize),
    nested_v2s: (usize, usize),
    v2_array: (usize, usize),
    scalar: usize,
    v3_array: (usize, usize),
    v4_array: (usize, usize),
}

const F16_STD430: Layout = Layout {
    element: 2,
    stride: 368,
    v2: 4,
    v3: 8,
    v4: 16,
    scalars: (24, 2),
    nested: (32, 16),
    nested_v2s: (4, 4),
    v2_array: (208, 4),
    scalar: 252,
    v3_array: (256, 8),
    v4_array: (344, 8),
};
const F16_STD140: Layout = Layout {
    element: 2,
    stride: 1200,
    v2: 4,
    v3: 8,
    v4: 16,
    scalars: (32, 16),
    nested: (80, 64),
    nested_v2s: (16, 16),
    v2_array: (784, 16),
    scalar: 960,
    v3_array: (976, 16),
    v4_array: (1152, 16),
};
const F32_STD430: Layout = Layout {
    element: 4,
    stride: 736,
    v2: 8,
    v3: 16,
    v4: 32,
    scalars: (48, 4),
    nested: (64, 32),
    nested_v2s: (8, 8),
    v2_array: (416, 8),
    scalar: 504,
    v3_array: (512, 16),
    v4_array: (688, 16),
};
const F32_STD140: Layout = Layout {
    element: 4,
    stride: 1216,
    v2: 8,
    v3: 16,
    v4: 32,
    scalars: (48, 16),
    nested: (96, 64),
    nested_v2s: (16, 16),
    v2_array: (800, 16),
    scalar: 976,
    v3_array: (992, 16),
    v4_array: (1168, 16),
};

const I8_STD430: Layout = Layout {
    element: 1,
    stride: 224,
    v2: 2,
    v3: 4,
    v4: 8,
    scalars: (16, 1),
    nested: (32, 8),
    nested_v2s: (2, 2),
    v2_array: (128, 2),
    scalar: 150,
    v3_array: (160, 4),
    v4_array: (208, 4),
};
const I8_STD140: Layout = Layout {
    element: 1,
    stride: 1184,
    v2: 2,
    v3: 4,
    v4: 8,
    scalars: (16, 16),
    nested: (64, 64),
    nested_v2s: (16, 16),
    v2_array: (768, 16),
    scalar: 944,
    v3_array: (960, 16),
    v4_array: (1136, 16),
};

/// The byte offsets of the data slots of the 8 bit (`kind` 0 std430, 1 std140) and 32 bit (2 std430, 3 std140) struct layouts, as `info8bitStd430` and friends mark them.
pub(super) fn struct_data_offsets(kind: u8) -> Vec<usize> {
    match kind {
        0 => I8_STD430.data_offsets(),
        1 => I8_STD140.data_offsets(),
        2 => F32_STD430.data_offsets(),
        _ => F32_STD140.data_offsets(),
    }
}

impl Layout {
    /// The byte offset of every slot that holds data, in the order the members are declared.
    fn data_offsets(&self) -> Vec<usize> {
        let mut offsets = Vec::new();
        for structure in 0..STRUCT_ARRAY_SIZE {
            let base = structure * self.stride;
            let mut push = |start: usize, count: usize| {
                offsets.extend((0..count).map(|component| base + start + component * self.element))
            };
            push(0, 1);
            push(self.v2, 2);
            push(self.v3, 3);
            push(self.v4, 4);
            for index in 0..3 {
                push(self.scalars.0 + index * self.scalars.1, 1);
            }
            for index in 0..NESTED_ARRAY_SIZE {
                let nested = self.nested.0 + index * self.nested.1;
                push(nested, 1);
                for inner in 0..3 {
                    push(nested + self.nested_v2s.0 + inner * self.nested_v2s.1, 2);
                }
            }
            for index in 0..NESTED_ARRAY_SIZE {
                push(self.v2_array.0 + index * self.v2_array.1, 2);
            }
            push(self.scalar, 1);
            for index in 0..NESTED_ARRAY_SIZE {
                push(self.v3_array.0 + index * self.v3_array.1, 3);
            }
            for index in 0..3 {
                push(self.v4_array.0 + index * self.v4_array.1, 4);
            }
        }
        offsets
    }
}

fn field<'a>(spec: &'a str, key: &str) -> &'a str {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("struct 16 spec without {key}"))
}

fn read_u16(bytes: &[u8], offset: usize) -> u16 {
    u16::from_le_bytes([bytes[offset], bytes[offset + 1]])
}

fn read_f32(bytes: &[u8], offset: usize) -> f32 {
    f32::from_le_bytes(bytes[offset..offset + 4].try_into().expect("four bytes"))
}

/// `compare16BitFloat(uint16_t original, float returned)`: a conversion that is exact except where a denormal may be flushed.
fn compare_16_to_32(original: u16, returned: f32) -> bool {
    let original_is_zero = original & 0x7fff == 0;
    let original_is_denorm = original & 0x7c00 == 0 && original & 0x03ff != 0;
    let original_is_inf = original & 0x7fff == 0x7c00;
    let original_is_nan = original & 0x7c00 == 0x7c00 && original & 0x03ff != 0;
    let returned_is_zero = returned.to_bits() & 0x7fff_ffff == 0;

    if original_is_zero {
        return returned_is_zero;
    }
    if original_is_denorm && returned_is_zero {
        return true;
    }
    if original_is_inf {
        return returned.is_infinite() && (original >> 15) == (returned.to_bits() >> 31) as u16;
    }
    if original_is_nan {
        return returned.is_nan();
    }
    float16_to_float32(original).to_bits() == returned.to_bits()
}

/// `computeCheckStruct<deFloat16, float, ...>`
fn verify_16_to_32<const STD140: bool>(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    let (input_offsets, output_offsets) = (
        (if STD140 { &F16_STD140 } else { &F16_STD430 }).data_offsets(),
        F32_STD430.data_offsets(),
    );
    input_offsets
        .iter()
        .zip(&output_offsets)
        .all(|(&input, &output)| compare_16_to_32(read_u16(&inputs[0], input), read_f32(&outputs[0], output)))
}

/// `computeCheckStruct<float, deFloat16, ...>`
fn verify_32_to_16<const STD140: bool>(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    let (input_offsets, output_offsets) = (
        (if STD140 { &F32_STD140 } else { &F32_STD430 }).data_offsets(),
        F16_STD430.data_offsets(),
    );
    input_offsets
        .iter()
        .zip(&output_offsets)
        .all(|(&input, &output)| compare_16bit_float(read_f32(&inputs[0], input), read_u16(&outputs[0], output), 3))
}

/// `addCompute16bitStructMixedTypesGroup`: the data of the group's stream and the check are those of the graphics group.
fn make_mixed_spec(text: &str) -> ComputeShaderSpec {
    let std140 = field(text, "cap") == "1";
    let (inputs, outputs) = mixed_struct_io(&format!("seed=struct_mixed_types;cap={}", field(text, "cap")));
    let mut spec = ComputeShaderSpec {
        num_work_groups: [STRUCT_ARRAY_SIZE as u32, NESTED_ARRAY_SIZE as u32, 1],
        inputs,
        outputs,
        ..Default::default()
    };
    spec.extensions.push("VK_KHR_16bit_storage".to_string());
    if std140 {
        spec.uniform_inputs = true;
        spec.features.push(RequiredFeature::UniformAndStorageBuffer16BitAccess);
    } else {
        spec.features.push(RequiredFeature::StorageBuffer16BitAccess);
    }
    spec.verify_io = Some(if std140 {
        verify_mixed_struct::<true> as VerifyIo
    } else {
        verify_mixed_struct::<false> as VerifyIo
    });
    spec
}

/// The struct cases of `compute.8bit_storage`: `uniform_8struct_to_32struct` (`8to32c`), `storagebuffer_32struct_to_8struct` (`32to8c`, the input is the std140 uniform buffer) and
/// `struct_mixed_types` (`mix8`). The data is drawn from the stream seeded with the group name; the outputs start zeroed.
fn make_struct8_spec(text: &str) -> ComputeShaderSpec {
    const STRUCTS: usize = STRUCT_ARRAY_SIZE;
    let group = field(text, "group");
    let std140 = field(text, "cap") == "1";
    let mut spec = ComputeShaderSpec {
        num_work_groups: [STRUCT_ARRAY_SIZE as u32, NESTED_ARRAY_SIZE as u32, 1],
        ..Default::default()
    };
    spec.extensions.push("VK_KHR_8bit_storage".to_string());
    match group {
        "8to32c" => {
            let mut rnd = Random::new(de_string_hash("uniform_8struct_to_32struct"));
            spec.inputs.push(get_int8s(&mut rnd, 1184 * STRUCTS).concat());
            spec.outputs.push(vec![0u8; 184 * STRUCTS * 4]);
            spec.uniform_inputs = true;
            spec.features.push(RequiredFeature::UniformAndStorageBuffer8BitAccess);
            spec.verify_io = struct8_verifier(1, 2);
        }
        "32to8c" => {
            let mut rnd = Random::new(de_string_hash("storagebuffer_32struct_to_8struct"));
            spec.inputs.push(get_int32s(&mut rnd, 304 * STRUCTS).concat());
            spec.outputs.push(vec![0u8; 224 * STRUCTS]);
            spec.uniform_inputs = true;
            spec.extensions.push("VK_KHR_storage_buffer_storage_class".to_string());
            spec.features.push(RequiredFeature::StorageBuffer8BitAccess);
            spec.verify_io = struct8_verifier(3, 0);
        }
        _ => {
            let (inputs, outputs) = mixed_struct8_io(&format!("seed=struct_mixed_types;cap={}", field(text, "cap")));
            spec.inputs = inputs;
            spec.outputs = outputs;
            spec.extensions.push("VK_KHR_storage_buffer_storage_class".to_string());
            spec.features.push(RequiredFeature::StorageBuffer8BitAccess);
            if std140 {
                spec.uniform_inputs = true;
                spec.features.push(RequiredFeature::UniformAndStorageBuffer8BitAccess);
            }
            spec.verify_io = Some(if std140 {
                verify_mixed_struct8::<true> as VerifyIo
            } else {
                verify_mixed_struct8::<false> as VerifyIo
            });
        }
    }
    spec
}

pub(super) fn make_spec(text: &str) -> ComputeShaderSpec {
    match field(text, "group") {
        "mix" => return make_mixed_spec(text),
        "8to32c" | "32to8c" | "mix8" => return make_struct8_spec(text),
        _ => {}
    }
    let std140 = field(text, "cap") == "1";
    let narrow_first = field(text, "group") == "16to32";
    let mut spec = ComputeShaderSpec {
        num_work_groups: [STRUCT_ARRAY_SIZE as u32, NESTED_ARRAY_SIZE as u32, 1],
        ..Default::default()
    };
    spec.extensions.push("VK_KHR_16bit_storage".to_string());
    if std140 {
        spec.uniform_inputs = true;
        spec.features.push(RequiredFeature::UniformAndStorageBuffer16BitAccess);
    } else {
        spec.features.push(RequiredFeature::StorageBuffer16BitAccess);
    }

    if narrow_first {
        let mut rnd = Random::new(de_string_hash("uniform_16struct_to_32struct"));
        // The second capability's data follows the first one's in the group's random stream.
        let data = if std140 {
            get_float16s(&mut rnd, 184 * STRUCT_ARRAY_SIZE);
            get_float16s(&mut rnd, 600 * STRUCT_ARRAY_SIZE)
        } else {
            get_float16s(&mut rnd, 184 * STRUCT_ARRAY_SIZE)
        };
        spec.inputs.push(data.concat());
        spec.outputs.push(vec![0u8; 184 * STRUCT_ARRAY_SIZE * 4]);
        spec.verify_io = Some(if std140 {
            verify_16_to_32::<true>
        } else {
            verify_16_to_32::<false>
        });
    } else {
        let mut rnd = Random::new(de_string_hash("uniform_32struct_to_16struct"));
        let data = if std140 {
            get_float32s(&mut rnd, 184 * STRUCT_ARRAY_SIZE);
            get_float32s(&mut rnd, 304 * STRUCT_ARRAY_SIZE)
        } else {
            get_float32s(&mut rnd, 184 * STRUCT_ARRAY_SIZE)
        };
        spec.inputs.push(data.concat());
        spec.outputs.push(vec![0u8; 184 * STRUCT_ARRAY_SIZE * 2]);
        spec.verify_io = Some(if std140 {
            verify_32_to_16::<true>
        } else {
            verify_32_to_16::<false>
        });
    }
    spec
}

/// The struct groups of `spirv_assembly.instruction.compute.16bit_storage` as the groups of their path below `compute` and the test case.
pub fn create_struct16_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_STRUCT16_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (
                segments,
                Box::new(SpvAsmComputeShaderCase {
                    name: leaf.to_string(),
                    spec: make_spec(case.spec),
                    programs: case.programs,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
