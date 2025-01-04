// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsm16bitStorageTests.cpp (the addGraphics16BitStorage* groups)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The input and expected output buffers of the graphics storage cases that a spec string of
// `graphics_fragments_tests.rs` asks for with `gen=<family>`: the data is drawn from the stream seeded with the hash of the C++ group's name, as upstream does, and the
// outputs follow the conversion each group tests.

use super::pointers_tests::mux_io;
use super::storage16_tests::halves_to_doubles;
use super::struct16_tests::struct_data_offsets;
use super::utils::{float16_to_float32, get_float16s, get_float32s, get_float64s, get_int8s, get_int16s, get_int32s};
use crate::tcu::random::Random;
use crate::tcu::{RGBA, Vec4, de_string_hash};

const NUM_DATA_POINTS: usize = 256;

fn number(spec: &str, name: &str) -> i64 {
    spec.split(';')
        .find_map(|part| part.strip_prefix(name).and_then(|rest| rest.strip_prefix('=')))
        .and_then(|value| value.parse().ok())
        .unwrap_or_else(|| panic!("the spec `{spec}` has no number `{name}`"))
}

fn text<'a>(spec: &'a str, name: &str) -> &'a str {
    spec.split(';')
        .find_map(|part| part.strip_prefix(name).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("the spec `{spec}` has no field `{name}`"))
}

fn padded(elements: &[Vec<u8>], per_item: usize, stride_bytes: usize, element_bytes: usize) -> Vec<u8> {
    let mut bytes = Vec::new();
    for item in elements.chunks(per_item) {
        for element in item {
            bytes.extend_from_slice(element);
        }
        bytes.resize(bytes.len() + stride_bytes - per_item * element_bytes, 0);
    }
    bytes
}

/// `addGraphics16BitStorageUniformInt16To32Group`: 16 bit integers read through an array of strided scalars or vec2s and stored widened.
fn uniform_int_16_to_32(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let inputs = get_int16s(&mut rnd, NUM_DATA_POINTS);
    let values: Vec<i16> = inputs
        .iter()
        .map(|element| i16::from_ne_bytes([element[0], element[1]]))
        .collect();
    let signed_outputs: Vec<i32> = values.iter().map(|&value| i32::from(value)).collect();
    let unsigned_outputs: Vec<i32> = values.iter().map(|&value| i32::from(value as u16)).collect();

    let num_elements: usize = if number(spec, "vec") == 1 { 2 } else { 1 };
    let min_array_stride = [2usize, 16][number(spec, "cap") as usize];
    let array_stride = (num_elements * 2).max(min_array_stride);
    let input_bytes = padded(&inputs, num_elements, array_stride, 2);

    let source = if number(spec, "signed") == 1 {
        &signed_outputs
    } else {
        &unsigned_outputs
    };
    let constant_index = number(spec, "cidx");
    let outputs: Vec<i32> = if constant_index >= 0 {
        (0..NUM_DATA_POINTS)
            .map(|index| source[constant_index as usize * num_elements + index % num_elements])
            .collect()
    } else {
        source.clone()
    };
    (
        vec![input_bytes],
        vec![outputs.iter().flat_map(|value| value.to_ne_bytes()).collect()],
    )
}

/// `addGraphics16BitStorageUniformInt32To16Group`: 32 bit integers read through strided scalars or vec4s and stored narrowed.
fn uniform_int_32_to_16(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let inputs = get_int32s(&mut rnd, NUM_DATA_POINTS);
    let outputs: Vec<u8> = inputs
        .iter()
        .flat_map(|element| {
            let value = i32::from_ne_bytes([element[0], element[1], element[2], element[3]]);
            ((value & 0xffff) as u16).to_ne_bytes()
        })
        .collect();
    let input_bytes = if number(spec, "vec") == 1 {
        inputs.concat()
    } else {
        let array_stride = [4usize, 16][number(spec, "cap") as usize];
        padded(&inputs, 1, array_stride, 4)
    };
    (vec![input_bytes], vec![outputs])
}

/// `addGraphics16BitStorageUniformFloat16To32Group`: binary16 values read through strided scalars, vec2s or the columns of 4x2 matrices and stored as binary32.
fn uniform_float_16_to_32(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let elements = get_float16s(&mut rnd, NUM_DATA_POINTS);
    let data: Vec<u16> = elements
        .iter()
        .map(|element| u16::from_ne_bytes([element[0], element[1]]))
        .collect();
    let cap = number(spec, "cap") as usize;
    let constant_index = number(spec, "cidx");
    let widen = |index: usize| float16_to_float32(data[index]);

    let (input_bytes, outputs): (Vec<u8>, Vec<f32>) = match text(spec, "kind") {
        "scalar" => (
            padded(&elements, 1, [2usize, 16][cap], 2),
            (0..NUM_DATA_POINTS)
                .map(|index| {
                    widen(if constant_index >= 0 {
                        constant_index as usize
                    } else {
                        index
                    })
                })
                .collect(),
        ),
        "vector" => (
            padded(&elements, 2, [4usize, 16][cap], 2),
            (0..NUM_DATA_POINTS)
                .map(|index| {
                    widen(if constant_index >= 0 {
                        constant_index as usize * 2 + index % 2
                    } else {
                        index
                    })
                })
                .collect(),
        ),
        _ => {
            let mut matrices = vec![0u16; data.len() * 4];
            for index in 0..data.len() / 2 {
                matrices[index * 8] = data[index * 2];
                matrices[index * 8 + 1] = data[index * 2 + 1];
            }
            (
                matrices.iter().flat_map(|value| value.to_ne_bytes()).collect(),
                (0..NUM_DATA_POINTS).map(widen).collect(),
            )
        }
    };
    (
        vec![input_bytes],
        vec![outputs.iter().flat_map(|value| value.to_ne_bytes()).collect()],
    )
}

/// `addGraphics8BitStorageUniformInt32To8Group` and its three siblings: integers of one width read through 16 byte strided array elements and stored at another width.
/// The C++ `checkUniformsArray` compares only the low byte of each result element with the low byte of the input it came from, so the expected buffer carries those bytes and
/// the mask selects them.
fn uniform_8bit(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const ARRAY_STRIDE: usize = 16;
    let origin = number(spec, "orig") as usize;
    let result = number(spec, "res") as usize;
    let category = number(spec, "cat") as usize;
    let components: Vec<usize> = text(spec, "comps")
        .split(',')
        .map(|count| count.parse().expect("a component count"))
        .collect();
    let constant_index = number(spec, "cidx");

    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let mut input = Vec::new();
    for &count in &components[..=category] {
        let draw = match origin {
            1 => get_int8s,
            2 => get_int16s,
            _ => get_int32s,
        };
        input = draw(&mut rnd, (ARRAY_STRIDE / origin * NUM_DATA_POINTS) / count).concat();
    }
    let composite = components[category];

    let mut expected = vec![0u8; NUM_DATA_POINTS * result];
    let mut mask = vec![0u8; NUM_DATA_POINTS * result];
    if number(spec, "exact") == 1 {
        for index in 0..NUM_DATA_POINTS {
            expected[index] = input[index * origin];
            mask[index] = 0xff;
        }
    } else {
        let elements = (input.len() / ARRAY_STRIDE) / composite;
        for element in 0..elements {
            for component in 0..composite {
                let slot = (element * composite + component) * result;
                let source = if constant_index >= 0 {
                    ARRAY_STRIDE * constant_index as usize + component * origin
                } else {
                    element * ARRAY_STRIDE + component * origin
                };
                expected[slot] = input[source];
                mask[slot] = 0xff;
            }
        }
    }
    (vec![input], vec![expected], vec![mask])
}

/// `addGraphics16BitStoragePushConstantFloat16To32Group`: the 64 binary16 values are the push constants, read as scalars, vec4s or two-column matrices of vec4s and stored widened.
/// Returns the push constants and the expected output.
fn push_constant_float_16_to_32(spec: &str) -> (Vec<u8>, Vec<u8>) {
    const COUNT: usize = 64;
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let elements = get_float16s(&mut rnd, COUNT);
    let data: Vec<u16> = elements
        .iter()
        .map(|element| u16::from_ne_bytes([element[0], element[1]]))
        .collect();
    let constant_index = number(spec, "cidx");
    let per_item: usize = match text(spec, "kind") {
        "scalar" => 1,
        "vector" => 4,
        _ => 8,
    };
    let outputs: Vec<f32> = (0..COUNT)
        .map(|index| {
            let source = if constant_index >= 0 {
                constant_index as usize * per_item + index % per_item
            } else {
                index
            };
            float16_to_float32(data[source])
        })
        .collect();
    (
        elements.concat(),
        outputs.iter().flat_map(|value| value.to_ne_bytes()).collect(),
    )
}

/// `addGraphics16BitStoragePushConstantInt16To32Group`: the 64 int16 values are the push constants, read as scalars or vec2s and stored widened with the sign of the case.
/// Returns the push constants and the expected output.
fn push_constant_int_16_to_32(spec: &str) -> (Vec<u8>, Vec<u8>) {
    const COUNT: usize = 64;
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let elements = get_int16s(&mut rnd, COUNT);
    let values: Vec<i16> = elements
        .iter()
        .map(|element| i16::from_ne_bytes([element[0], element[1]]))
        .collect();
    let widened: Vec<i32> = if number(spec, "signed") == 1 {
        values.iter().map(|&value| i32::from(value)).collect()
    } else {
        values.iter().map(|&value| i32::from(value as u16)).collect()
    };
    let constant_index = number(spec, "cidx");
    let per_item: usize = if text(spec, "kind") == "vector" { 2 } else { 1 };
    let outputs: Vec<i32> = (0..COUNT)
        .map(|index| {
            if constant_index >= 0 {
                widened[constant_index as usize * per_item + index % per_item]
            } else {
                widened[index]
            }
        })
        .collect();
    (
        elements.concat(),
        outputs.iter().flat_map(|value| value.to_ne_bytes()).collect(),
    )
}

/// `addGraphics8BitStoragePushConstantInt8To32Group` and `...Int8To16Group`: the 64 int8 values are the push constants, read as scalars or vec2s and stored widened to `res` bytes.
/// Returns the push constants and the expected output.
fn push_constant_int_8(spec: &str) -> (Vec<u8>, Vec<u8>) {
    const COUNT: usize = 64;
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let elements = get_int8s(&mut rnd, COUNT);
    let values: Vec<i8> = elements.iter().map(|element| element[0] as i8).collect();
    let signed = number(spec, "signed") == 1;
    let widened: Vec<i32> = values
        .iter()
        .map(|&value| {
            if signed {
                i32::from(value)
            } else {
                i32::from(value as u8)
            }
        })
        .collect();
    let constant_index = number(spec, "cidx");
    let per_item: usize = if text(spec, "kind") == "vector" { 2 } else { 1 };
    let result_bytes = number(spec, "res") as usize;
    let mut outputs = Vec::new();
    for index in 0..COUNT {
        let value = if constant_index >= 0 {
            widened[constant_index as usize * per_item + index % per_item]
        } else {
            widened[index]
        };
        outputs.extend_from_slice(&value.to_ne_bytes()[..result_bytes]);
    }
    (elements.concat(), outputs)
}

/// `addGraphics16BitStorageUniformFloat32To16Group`: 256 binary32 values read as strided scalars, vec4s or 4x4 matrices and stored narrowed. The output is only a buffer of the
/// right size, the check computes the expectation from the inputs.
fn uniform_float_32_to_16(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let data = get_float32s(&mut rnd, NUM_DATA_POINTS);
    let input_bytes = if text(spec, "kind") == "scalar" && number(spec, "cap") == 1 {
        padded(&data, 1, 16, 4)
    } else {
        data.concat()
    };
    (vec![input_bytes], vec![vec![0u8; NUM_DATA_POINTS * 2]])
}

/// `addGraphics16BitStorageUniformFloat16To64Group`: binary16 values read through strided scalars, vec2s or the columns of 4x2 matrices and stored as binary64.
fn uniform_float_16_to_64(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let elements = get_float16s(&mut rnd, NUM_DATA_POINTS);
    let data: Vec<u16> = elements
        .iter()
        .map(|element| u16::from_ne_bytes([element[0], element[1]]))
        .collect();
    let doubles = halves_to_doubles(&data);
    let cap = number(spec, "cap") as usize;
    let constant_index = number(spec, "cidx");

    let (input_bytes, outputs): (Vec<u8>, Vec<f64>) = match text(spec, "kind") {
        "scalar" => (
            padded(&elements, 1, [2usize, 16][cap], 2),
            (0..NUM_DATA_POINTS)
                .map(|index| {
                    doubles[if constant_index >= 0 {
                        constant_index as usize
                    } else {
                        index
                    }]
                })
                .collect(),
        ),
        "vector" => (
            padded(&elements, 2, [4usize, 16][cap], 2),
            (0..NUM_DATA_POINTS)
                .map(|index| {
                    doubles[if constant_index >= 0 {
                        constant_index as usize * 2 + index % 2
                    } else {
                        index
                    }]
                })
                .collect(),
        ),
        _ => {
            let mut matrices = vec![0u16; data.len() * 4];
            for index in 0..data.len() / 2 {
                matrices[index * 8] = data[index * 2];
                matrices[index * 8 + 1] = data[index * 2 + 1];
            }
            (
                matrices.iter().flat_map(|value| value.to_ne_bytes()).collect(),
                doubles.clone(),
            )
        }
    };
    (
        vec![input_bytes],
        vec![outputs.iter().flat_map(|value| value.to_ne_bytes()).collect()],
    )
}

/// `addGraphics16BitStorageUniformFloat64To16Group`: 256 binary64 values read as strided scalars, vec2s or 2x4 matrices and stored narrowed. The output is only a buffer of the right
/// size, the check computes the expectation from the inputs.
fn uniform_float_64_to_16(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let data = get_float64s(&mut rnd, NUM_DATA_POINTS);
    let input_bytes = if text(spec, "kind") == "scalar" && number(spec, "cap") == 1 {
        padded(&data, 1, 16, 8)
    } else {
        data.concat()
    };
    (vec![input_bytes], vec![vec![0u8; NUM_DATA_POINTS * 2]])
}

/// `addGraphics16BitStoragePushConstantFloat16To64Group`: the 64 binary16 values are the push constants and the output their binary64 widenings, however the shader reads them.
/// Returns the push constants and the expected output.
fn push_constant_float_16_to_64(spec: &str) -> (Vec<u8>, Vec<u8>) {
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let elements = get_float16s(&mut rnd, 64);
    let data: Vec<u16> = elements
        .iter()
        .map(|element| u16::from_ne_bytes([element[0], element[1]]))
        .collect();
    (
        elements.concat(),
        halves_to_doubles(&data)
            .iter()
            .flat_map(|value| value.to_ne_bytes())
            .collect(),
    )
}

/// The inputs, outputs and compare masks of the family named by `gen`, `None` when the spec is not one of the storage families.
pub fn storage_io(spec: &str) -> Option<(Vec<Vec<u8>>, Vec<Vec<u8>>, Vec<Vec<u8>>)> {
    let unmasked = |(inputs, outputs): (Vec<Vec<u8>>, Vec<Vec<u8>>)| (inputs, outputs, Vec::new());
    match text(spec, "gen") {
        "s16i_16to32" => Some(unmasked(uniform_int_16_to_32(spec))),
        "s16i_32to16" => Some(unmasked(uniform_int_32_to_16(spec))),
        "s16f_16to32" => Some(unmasked(uniform_float_16_to_32(spec))),
        "s8u" => Some(uniform_8bit(spec)),
        "s16mix" => Some(unmasked(mixed_struct_io(spec))),
        "s8mix" => Some(unmasked(mixed_struct8_io(spec))),
        "s8st" => Some(unmasked(struct8_io(spec))),
        "f16vs" => Some(unmasked(float16_vector_shuffle(spec))),
        "f16cc" => Some(unmasked(float16_composite_construct())),
        "f16lg" => Some(unmasked(float16_logical(spec))),
        "f16ci" => Some(unmasked(float16_composite_insert_extract(spec))),
        "f16fn" | "f16vx" | "f16vi" => Some(unmasked(float16_function_or_extract(spec))),
        "s16f_64to16" => Some(unmasked(uniform_float_64_to_16(spec))),
        "s16f_16to64" => Some(unmasked(uniform_float_16_to_64(spec))),
        "vp1" => Some((vec![variable_pointer_single_input(spec).0], Vec::new(), Vec::new())),
        "vpg" => {
            let (inputs, expected) = mux_io("graphics", number(spec, "single") == 1, number(spec, "write") == 1);
            Some((inputs, vec![expected], Vec::new()))
        }
        "vpn" => Some((
            vec![VARIABLE_POINTER_NULLPTR_FLOAT.to_ne_bytes().to_vec()],
            Vec::new(),
            Vec::new(),
        )),
        "vp2" => {
            let (first, second, _) = variable_pointer_two_inputs(spec);
            Some((vec![first, second], Vec::new(), Vec::new()))
        }
        "s16f_32to16" => Some(unmasked(uniform_float_32_to_16(spec))),
        "s16pf" => Some((Vec::new(), vec![push_constant_float_16_to_32(spec).1], Vec::new())),
        "s16pi" => Some((Vec::new(), vec![push_constant_int_16_to_32(spec).1], Vec::new())),
        "s16pf64" => Some((Vec::new(), vec![push_constant_float_16_to_64(spec).1], Vec::new())),
        "s8pi" => Some((Vec::new(), vec![push_constant_int_8(spec).1], Vec::new())),
        _ => None,
    }
}

/// The push constants of the family named by `gen`, empty when it has none.
pub fn storage_push_constants(spec: &str) -> Vec<u8> {
    match text(spec, "gen") {
        "s16pf" => push_constant_float_16_to_32(spec).0,
        "s16pi" => push_constant_int_16_to_32(spec).0,
        "s16pf64" => push_constant_float_16_to_64(spec).0,
        "s8pi" => push_constant_int_8(spec).0,
        _ => Vec::new(),
    }
}

/// The one float of the nullptr variable pointer cases (`78 / 255.f`).
const VARIABLE_POINTER_NULLPTR_FLOAT: f32 = 78.0 / 255.0;

/// `getBaseOffsetForSingleInputBuffer`: the float index in the 128 floats of the input buffer for the indices into outer struct, matrix row and column, inner struct, vec4 array and vec4.
fn variable_pointer_base_offset(indices: [usize; 6]) -> usize {
    let [outer, row, column, inner, vec4_array, vec4] = indices;
    row * 32 + column * 16 + inner * 8 + vec4_array * 4 + vec4 + if outer == 1 { 64 } else { 0 }
}

/// The indices `addSingleInputBufferReadOnlyVariablePointersGraphicsGroup` picks at each of its seven levels; `outer` is 0 for the first input and 1 for the second.
fn variable_pointer_level_indices(level: usize, outer: usize) -> [usize; 6] {
    const TAIL: [[usize; 5]; 7] = [
        [0, 0, 0, 0, 1],
        [1, 0, 1, 0, 2],
        [0, 1, 0, 1, 3],
        [1, 1, 1, 0, 0],
        [0, 0, 1, 1, 1],
        [1, 0, 0, 0, 2],
        [1, 1, 1, 1, 3],
    ];
    let tail = TAIL[level];
    [outer, tail[0], tail[1], tail[2], tail[3], tail[4]]
}

/// `getExpectedOutputColor`: the default input colours with the red channel set to `value`.
fn variable_pointer_expected_colors(input_colors: [[u8; 4]; 4], value: f32) -> [[u8; 4]; 4] {
    input_colors.map(|color| {
        let mut vec = RGBA::new(
            i32::from(color[0]),
            i32::from(color[1]),
            i32::from(color[2]),
            i32::from(color[3]),
        )
        .to_vec();
        vec = Vec4::new(value, vec.y(), vec.z(), vec.w());
        let expected = RGBA::from_vec(vec);
        [
            expected.get_red() as u8,
            expected.get_green() as u8,
            expected.get_blue() as u8,
            expected.get_alpha() as u8,
        ]
    })
}

/// The 128 floats of the single input buffer of the read only variable pointer cases and the value the case's indices select.
fn variable_pointer_single_input(spec: &str) -> (Vec<u8>, f32) {
    let mut floats = vec![0.0f32; 128];
    for index in 0..64 {
        floats[index] = 4.0 * index as f32 / 255.0;
        floats[index + 64] = (4.0 * index as f32 + 3.0) / 255.0;
    }
    let outer = number(spec, "outer") as usize;
    let offset = variable_pointer_base_offset(variable_pointer_level_indices(number(spec, "level") as usize, outer));
    (
        floats.iter().flat_map(|value| value.to_ne_bytes()).collect(),
        floats[offset],
    )
}

/// The two 64 float inputs of the two buffer read only variable pointer cases and the value the case's indices select from the chosen one (`outer` 0 is the first input).
fn variable_pointer_two_inputs(spec: &str) -> (Vec<u8>, Vec<u8>, f32) {
    let first: Vec<f32> = (0..64).map(|index| 4.0 * index as f32 / 255.0).collect();
    let second: Vec<f32> = (0..64).map(|index| (4.0 * index as f32 + 3.0) / 255.0).collect();
    let offset = variable_pointer_base_offset(variable_pointer_level_indices(number(spec, "level") as usize, 0));
    let value = if number(spec, "outer") == 0 {
        first[offset]
    } else {
        second[offset]
    };
    let bytes = |values: &[f32]| -> Vec<u8> { values.iter().flat_map(|value| value.to_ne_bytes()).collect() };
    (bytes(&first), bytes(&second), value)
}

/// `compare16BitFloat(deFloat16 original, deFloat16 returned, std::string &)`: the bits must match, except that zeros match zeros, a denormal may be flushed to zero, infinities keep their sign and NaNs match NaNs.
fn compare_16bit_bits(original: u16, returned: u16) -> bool {
    let is_zero = |bits: u16| bits & 0x7fff == 0;
    let is_denorm = |bits: u16| bits & 0x7c00 == 0 && bits & 0x03ff != 0;
    let is_inf = |bits: u16| bits & 0x7fff == 0x7c00;
    let is_nan = |bits: u16| bits & 0x7c00 == 0x7c00 && bits & 0x03ff != 0;
    if is_zero(original) {
        return is_zero(returned);
    }
    if is_denorm(original) && is_zero(returned) {
        return true;
    }
    if is_inf(original) {
        return is_inf(returned) && original >> 15 == returned >> 15;
    }
    if is_nan(original) {
        return is_nan(returned);
    }
    original == returned
}

fn halves(bytes: &[u8]) -> Vec<u16> {
    bytes
        .chunks_exact(2)
        .map(|pair| u16::from_ne_bytes([pair[0], pair[1]]))
        .collect()
}

const HALF_NEGATIVE_ONE: u16 = 0xBC00;

/// The binary16 bits of a small non-negative integer, which `tcu::Float16(float(n))` represents exactly.
fn small_integer_half(value: u32) -> u16 {
    if value == 0 {
        return 0;
    }
    let exponent = 31 - value.leading_zeros();
    (((15 + exponent) << 10) | ((value - (1 << exponent)) << (10 - exponent))) as u16
}

/// `createFloat16CompositeConstructSet`: the expected halves of the eight struct instances (item index as value, -1.0 at the exception indices, the two items that depend on the
/// element index), used as the input and as the output buffer the shader fills.
fn float16_composite_construct() -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const ELEMENTS: u32 = 8;
    const ITEMS: u32 = 88;
    const FIELD_MODIFIER: u32 = 2;
    const MODIFIED_MUL_INDEX: usize = 60;
    const MODIFIED_ADD_INDEX: usize = 66;
    const EXCEPTION_INDICES: [usize; 16] = [1, 7, 15, 17, 25, 33, 51, 55, 59, 63, 67, 71, 84, 85, 86, 87];
    let mut expected: Vec<u16> = Vec::new();
    for element in 0..ELEMENTS {
        let mut iteration: Vec<u16> = (0..ITEMS).map(small_integer_half).collect();
        for index in EXCEPTION_INDICES {
            iteration[index] = HALF_NEGATIVE_ONE;
        }
        iteration[MODIFIED_MUL_INDEX] = small_integer_half(element * FIELD_MODIFIER);
        iteration[MODIFIED_ADD_INDEX] = small_integer_half(element + FIELD_MODIFIER);
        expected.extend(iteration);
    }
    let bytes: Vec<u8> = expected.iter().flat_map(|half| half.to_ne_bytes()).collect();
    (vec![bytes.clone()], vec![bytes])
}

/// `createFloat16CompositeInsertExtractSet`: the item index as a half for every item (-1.0 where the access path is null), and a zeroed buffer of the same size for the output.
fn float16_composite_insert_extract(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let count = number(spec, "n") as u32;
    let nulls: Vec<u32> = text(spec, "nulls")
        .split(',')
        .filter_map(|index| index.parse().ok())
        .collect();
    let input: Vec<u8> = (0..count)
        .flat_map(|index| {
            if nulls.contains(&index) {
                HALF_NEGATIVE_ONE
            } else {
                small_integer_half(index)
            }
            .to_ne_bytes()
        })
        .collect();
    (vec![input], vec![vec![0u8; count as usize * 2]])
}

const HALF_ONE: u16 = 0x3C00;

/// `squarizeVector`: every pair of the 2 component vectors made of every pair of values, the first or the second of the two of each pair of pairs.
fn squarize_vector(data: &[u16], second_argument: bool) -> Vec<u16> {
    let vectors: Vec<[u16; 2]> = data.iter().flat_map(|&x| data.iter().map(move |&y| [x, y])).collect();
    vectors
        .iter()
        .flat_map(|&first| {
            vectors
                .iter()
                .map(move |&second| if second_argument { first } else { second })
        })
        .flatten()
        .collect()
}

/// `createFloat16LogicalSet`: 16 binary16 values (and then 14 for the vector cases) from the stream seeded with the group name, paired as `squarize` and `squarizeVector` do (the whole
/// list repeated, and each value repeated), and a zeroed output of the same size.
fn float16_logical(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const SCALARS: usize = 16;
    const VECTOR_COMPONENTS: usize = 14;
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let scalars: Vec<u16> = halves(&get_float16s(&mut rnd, SCALARS).concat());
    let (first, second): (Vec<u16>, Vec<u16>) = if spec.contains("vec=1") {
        let vector_data: Vec<u16> = halves(&get_float16s(&mut rnd, VECTOR_COMPONENTS).concat());
        (
            squarize_vector(&vector_data, false),
            squarize_vector(&vector_data, true),
        )
    } else {
        (
            (0..SCALARS).flat_map(|_| scalars.iter().copied()).collect(),
            scalars
                .iter()
                .flat_map(|&value| std::iter::repeat_n(value, SCALARS))
                .collect(),
        )
    };
    let bytes = |halves: &[u16]| halves.iter().flat_map(|half| half.to_ne_bytes()).collect::<Vec<u8>>();
    let output = vec![0u8; first.len() * 2];
    (vec![bytes(&first), bytes(&second)], vec![output])
}

fn half_is_nan(bits: u16) -> bool {
    bits & 0x7c00 == 0x7c00 && bits & 0x03ff != 0
}

fn half_is_denorm(bits: u16) -> bool {
    bits & 0x7c00 == 0 && bits & 0x03ff != 0
}

/// `compareFP16Logical<function, onlyTestFunc, unationModeAnd, nanSupported>` with `OP` the index into the `testOps` table of the C++ (OpIsNan, OpIsInf, then the ordered and unordered
/// pairs of equal, not equal, less, greater, less or equal, greater or equal): the output must match for the inputs as they are or with the denormals flushed to zero.
pub fn verify_float16_logical<const OP: u32, const NAN: bool>(
    inputs: &[Vec<u8>],
    outputs: &[Vec<u8>],
    _expected: &[Vec<u8>],
) -> bool {
    if inputs.len() != 2 || outputs.len() != 1 {
        return false;
    }
    let (first, second, output) = (halves(&inputs[0]), halves(&inputs[1]), halves(&outputs[0]));
    let only_test_function = OP < 2;
    let ordered_mode = OP % 2 == 0;
    [false, true].into_iter().any(|flush_to_zero| {
        let flush = |bits: u16| {
            if flush_to_zero && half_is_denorm(bits) {
                0x8000
            } else {
                bits
            }
        };
        (0..first.len()).all(|index| {
            let (f1, f2) = (flush(first[index]), flush(second[index]));
            let (a, b) = (float16_to_float32(f1), float16_to_float32(f2));
            let tested = match OP {
                0 => half_is_nan(f1),
                1 => f1 & 0x7fff == 0x7c00,
                _ => match (OP - 2) / 2 {
                    0 => a == b,
                    1 => a != b,
                    2 => a < b,
                    3 => a > b,
                    4 => a <= b,
                    _ => a >= b,
                },
            };
            let expected = if only_test_function {
                tested
            } else {
                let (f1_nan, f2_nan) = (half_is_nan(f1), half_is_nan(f2));
                if !NAN && (f1_nan || f2_nan) {
                    return true;
                }
                if ordered_mode {
                    !f1_nan && !f2_nan && tested
                } else {
                    f1_nan || f2_nan || tested
                }
            };
            output[index] == if expected { HALF_ONE } else { 0 }
        })
    })
}

/// The check of the `OP`-th logical operation of `createFloat16LogicalSet`, with or without NaN support.
pub fn float16_logical_verifier(op: u32, nan: bool) -> Option<super::compute_shader_case::VerifyIo> {
    use super::compute_shader_case::VerifyIo;
    macro_rules! pick {
        ($($op:literal)*) => {
            match (op, nan) {
                $(($op, false) => Some(verify_float16_logical::<$op, false> as VerifyIo),
                ($op, true) => Some(verify_float16_logical::<$op, true> as VerifyIo),)*
                _ => None,
            }
        };
    }
    pick!(0 1 2 3 4 5 6 7 8 9 10 11 12 13)
}

/// `compareFP16CompositeFunc`: every half of the input that is not the -1.0 marker must come back unchanged.
pub fn verify_float16_composite(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    if inputs.len() != 1 || outputs.len() != 1 {
        return false;
    }
    let (input, output) = (halves(&inputs[0]), halves(&outputs[0]));
    input.len() <= output.len()
        && input
            .iter()
            .zip(&output)
            .all(|(&original, &returned)| original == HALF_NEGATIVE_ONE || compare_16bit_bits(original, returned))
}

/// `compareFP16FunctionSetFunc`: every half the shader copied through a function must equal its input.
pub fn verify_float16_function(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    if inputs.len() != 1 || outputs.len() != 1 {
        return false;
    }
    let (input, output) = (halves(&inputs[0]), halves(&outputs[0]));
    input
        .iter()
        .zip(&output)
        .all(|(&original, &returned)| compare_16bit_bits(original, returned))
}

/// `compareFP16VectorExtractFunc`: output[i] is component `indices[i]` of the i-th vector.
pub fn verify_float16_vector_extract(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    if inputs.len() != 2 || outputs.len() != 1 {
        return false;
    }
    let (vectors, output) = (halves(&inputs[0]), halves(&outputs[0]));
    let indices: Vec<u32> = inputs[1]
        .chunks_exact(4)
        .map(|word| u32::from_ne_bytes([word[0], word[1], word[2], word[3]]))
        .collect();
    let iterations = indices.len();
    let components = vectors.len() / iterations;
    indices
        .iter()
        .enumerate()
        .all(|(index, &component)| compare_16bit_bits(vectors[components * index + component as usize], output[index]))
}

/// `compareFP16VectorInsertFunc<COMPONENTS, 42>`: component `indices[i]` of the i-th vector is 42.0 and the others are the input's.
pub fn verify_float16_vector_insert<const COMPONENTS: usize>(
    inputs: &[Vec<u8>],
    outputs: &[Vec<u8>],
    _expected: &[Vec<u8>],
) -> bool {
    const MAGIC: u16 = 0x5140;
    if inputs.len() != 2 || outputs.len() != 1 {
        return false;
    }
    let (vectors, output) = (halves(&inputs[0]), halves(&outputs[0]));
    let indices: Vec<u32> = inputs[1]
        .chunks_exact(4)
        .map(|word| u32::from_ne_bytes([word[0], word[1], word[2], word[3]]))
        .collect();
    let stride = vectors.len() / indices.len();
    indices.iter().enumerate().all(|(index, &replaced)| {
        (0..COMPONENTS).all(|component| {
            let expected = if component == replaced as usize {
                MAGIC
            } else {
                vectors[stride * index + component]
            };
            compare_16bit_bits(expected, output[stride * index + component])
        })
    })
}

/// `getShuffledComponent`: the input component the shuffle of the `iteration`-th vector selects for destination component `component`, `None` where the shuffle index is 0xFFFFFFFF (not checked).
fn shuffled_component(
    iteration: usize,
    component: usize,
    first: &[u16],
    second: &[u16],
    first_len: usize,
    second_len: usize,
) -> Option<u16> {
    let count = first_len + second_len + 1;
    let limited = iteration % (count * count);
    let selected = match component {
        0 => limited / count,
        1 => limited % count,
        2 => 0,
        _ => 1,
    };
    if selected >= first_len + second_len {
        None
    } else if selected < first_len {
        Some(first[selected])
    } else {
        Some(second[selected - first_len])
    }
}

/// `compareFP16VectorShuffleFunc<DST, SRC0, SRC1>`
pub fn verify_float16_vector_shuffle<const DST: usize, const SRC0: usize, const SRC1: usize>(
    inputs: &[Vec<u8>],
    outputs: &[Vec<u8>],
    _expected: &[Vec<u8>],
) -> bool {
    if inputs.len() != 2 || outputs.len() != 1 {
        return false;
    }
    let stride = |components: usize| if components == 3 { 4 } else { components };
    let (first, second, output) = (halves(&inputs[0]), halves(&inputs[1]), halves(&outputs[0]));
    let iterations = first.len() / stride(SRC0);
    (0..iterations).all(|iteration| {
        let first_vector = &first[stride(SRC0) * iteration..];
        let second_vector = &second[stride(SRC1) * iteration..];
        (0..DST).all(|component| {
            match shuffled_component(iteration, component, first_vector, second_vector, SRC0, SRC1) {
                Some(expected) => compare_16bit_bits(expected, output[stride(DST) * iteration + component]),
                None => true,
            }
        })
    })
}

/// `getFloat16VectorShuffleVerifyIOFunc`: the check for the destination, first and second source component counts written as the digits `dst`, `src0`, `src1`.
pub fn float16_vector_shuffle_verifier(code: u32) -> Option<super::compute_shader_case::VerifyIo> {
    use super::compute_shader_case::VerifyIo;
    Some(match code {
        222 => verify_float16_vector_shuffle::<2, 2, 2> as VerifyIo,
        223 => verify_float16_vector_shuffle::<2, 2, 3> as VerifyIo,
        224 => verify_float16_vector_shuffle::<2, 2, 4> as VerifyIo,
        232 => verify_float16_vector_shuffle::<2, 3, 2> as VerifyIo,
        233 => verify_float16_vector_shuffle::<2, 3, 3> as VerifyIo,
        234 => verify_float16_vector_shuffle::<2, 3, 4> as VerifyIo,
        242 => verify_float16_vector_shuffle::<2, 4, 2> as VerifyIo,
        243 => verify_float16_vector_shuffle::<2, 4, 3> as VerifyIo,
        244 => verify_float16_vector_shuffle::<2, 4, 4> as VerifyIo,
        322 => verify_float16_vector_shuffle::<3, 2, 2> as VerifyIo,
        323 => verify_float16_vector_shuffle::<3, 2, 3> as VerifyIo,
        324 => verify_float16_vector_shuffle::<3, 2, 4> as VerifyIo,
        332 => verify_float16_vector_shuffle::<3, 3, 2> as VerifyIo,
        333 => verify_float16_vector_shuffle::<3, 3, 3> as VerifyIo,
        334 => verify_float16_vector_shuffle::<3, 3, 4> as VerifyIo,
        342 => verify_float16_vector_shuffle::<3, 4, 2> as VerifyIo,
        343 => verify_float16_vector_shuffle::<3, 4, 3> as VerifyIo,
        344 => verify_float16_vector_shuffle::<3, 4, 4> as VerifyIo,
        422 => verify_float16_vector_shuffle::<4, 2, 2> as VerifyIo,
        423 => verify_float16_vector_shuffle::<4, 2, 3> as VerifyIo,
        424 => verify_float16_vector_shuffle::<4, 2, 4> as VerifyIo,
        432 => verify_float16_vector_shuffle::<4, 3, 2> as VerifyIo,
        433 => verify_float16_vector_shuffle::<4, 3, 3> as VerifyIo,
        434 => verify_float16_vector_shuffle::<4, 3, 4> as VerifyIo,
        442 => verify_float16_vector_shuffle::<4, 4, 2> as VerifyIo,
        443 => verify_float16_vector_shuffle::<4, 4, 3> as VerifyIo,
        444 => verify_float16_vector_shuffle::<4, 4, 4> as VerifyIo,
        _ => return None,
    })
}

/// `createFloat16VectorShuffleSet`: the two inputs of the case `shuf` (digits dst, src0, src1) from the stream seeded with the hash of the group name, which every earlier case of the
/// loops over destination and source types has drawn from first. Returns the inputs and a buffer for the output.
fn float16_vector_shuffle(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const NUM_DATA_POINTS: usize = 128;
    let target = number(spec, "shuf") as usize;
    let stride = |components: usize| if components == 3 { 4 } else { components };
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    for dst in [2usize, 3, 4] {
        for first in [2usize, 3, 4] {
            for second in [2usize, 3, 4] {
                let input0 = get_float16s(&mut rnd, stride(first) * NUM_DATA_POINTS);
                let input1 = get_float16s(&mut rnd, stride(second) * NUM_DATA_POINTS);
                if dst * 100 + first * 10 + second == target {
                    return (
                        vec![input0.concat(), input1.concat()],
                        vec![vec![0u8; stride(dst) * NUM_DATA_POINTS * 2]],
                    );
                }
            }
        }
    }
    panic!("no vector shuffle case {target}");
}

/// `createFloat16FuncSet` and `createFloat16VectorExtractSet`: 256 binary16 values from the stream seeded with the group name, and for the extract group the component indices drawn after
/// them for each of the three types in turn. Returns the inputs and a buffer for the output.
fn float16_function_or_extract(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let data = get_float16s(&mut rnd, NUM_DATA_POINTS).concat();
    let mut inputs = vec![data];
    if matches!(text(spec, "gen"), "f16vx" | "f16vi") {
        let components: [(usize, u32); 3] = [(2, 2), (4, 3), (4, 4)];
        let mut indices = Vec::new();
        for &(items_per_type, component_count) in &components[..=number(spec, "typeidx") as usize] {
            indices = (0..NUM_DATA_POINTS / items_per_type)
                .map(|_| rnd.get_uint32() % component_count)
                .collect();
        }
        inputs.push(indices.iter().flat_map(|index| index.to_ne_bytes()).collect());
    }
    (inputs, vec![vec![0u8; NUM_DATA_POINTS * 2]])
}

const MIX_STRUCT_ARRAY_SIZE: usize = 7;
const MIX_NESTED_ARRAY_SIZE: usize = 11;

fn push_info(info: &mut Vec<bool>, count: usize, is_data: bool) {
    info.extend(std::iter::repeat_n(is_data, count));
}

/// `infoMixStd140` and `infoMixStd430`: for every 16 bit slot of the mixed 16 and 32 bit struct array, whether it holds data or padding.
fn mix_info(std140: bool) -> Vec<bool> {
    let mut info = Vec::new();
    for _ in 0..MIX_STRUCT_ARRAY_SIZE {
        push_info(&mut info, 1, true);
        push_info(&mut info, 1, false);
        push_info(&mut info, 2, true);
        push_info(&mut info, 2, true);
        push_info(&mut info, 2, false);
        push_info(&mut info, 4, true);
        push_info(&mut info, 3, true);
        push_info(&mut info, 1, false);
        push_info(&mut info, 6, true);
        push_info(&mut info, 2, false);
        push_info(&mut info, 4, true);
        push_info(&mut info, 4, false);
        push_info(&mut info, 8, true);
        for _ in 0..MIX_NESTED_ARRAY_SIZE {
            push_info(&mut info, 1, true);
            push_info(&mut info, 1, false);
            if std140 {
                push_info(&mut info, 2, true);
                push_info(&mut info, 4, false);
                for _ in 0..MIX_NESTED_ARRAY_SIZE {
                    push_info(&mut info, 2, true);
                    push_info(&mut info, 6, false);
                }
                for _ in 0..MIX_NESTED_ARRAY_SIZE {
                    push_info(&mut info, 2, true);
                    push_info(&mut info, 6, false);
                }
            } else {
                push_info(&mut info, 2, true);
                push_info(&mut info, 22, true);
                push_info(&mut info, 22, true);
            }
        }
        if std140 {
            for _ in 0..MIX_NESTED_ARRAY_SIZE {
                push_info(&mut info, 1, true);
                push_info(&mut info, 7, false);
            }
            for _ in 0..MIX_NESTED_ARRAY_SIZE {
                push_info(&mut info, 2, true);
                push_info(&mut info, 6, false);
            }
        } else {
            push_info(&mut info, 11, true);
            push_info(&mut info, 1, false);
            push_info(&mut info, 22, true);
            push_info(&mut info, 6, false);
        }
    }
    info
}

/// `infoMixStd140` and `infoMixStd430` of the 8 bit storage tests: for every byte of the mixed 8 and 32 bit struct array, whether it holds data or padding.
fn mix_info8(std140: bool) -> Vec<bool> {
    let mut info = Vec::new();
    for _ in 0..MIX_STRUCT_ARRAY_SIZE {
        push_info(&mut info, 1, true);
        push_info(&mut info, 3, false);
        push_info(&mut info, 4, true);
        push_info(&mut info, 2, true);
        push_info(&mut info, 6, false);
        push_info(&mut info, 8, true);
        push_info(&mut info, 3, true);
        push_info(&mut info, 5, false);
        push_info(&mut info, 12, true);
        push_info(&mut info, 4, false);
        push_info(&mut info, 4, true);
        push_info(&mut info, 12, false);
        push_info(&mut info, 16, true);
        for _ in 0..MIX_NESTED_ARRAY_SIZE {
            push_info(&mut info, 1, true);
            push_info(&mut info, 3, false);
            push_info(&mut info, 4, true);
            if std140 {
                push_info(&mut info, 8, false);
                for _ in 0..MIX_NESTED_ARRAY_SIZE {
                    push_info(&mut info, 2, true);
                    push_info(&mut info, 14, false);
                }
                for _ in 0..MIX_NESTED_ARRAY_SIZE {
                    push_info(&mut info, 4, true);
                    push_info(&mut info, 12, false);
                }
            } else {
                push_info(&mut info, 22, true);
                push_info(&mut info, 2, false);
                push_info(&mut info, 44, true);
            }
        }
        if std140 {
            for _ in 0..MIX_NESTED_ARRAY_SIZE {
                push_info(&mut info, 1, true);
                push_info(&mut info, 15, false);
            }
            for _ in 0..MIX_NESTED_ARRAY_SIZE {
                push_info(&mut info, 4, true);
                push_info(&mut info, 12, false);
            }
        } else {
            push_info(&mut info, 11, true);
            push_info(&mut info, 1, false);
            push_info(&mut info, 44, true);
            push_info(&mut info, 4, false);
        }
    }
    info
}

/// `checkStruct<int8_t, int8_t, STRIDEMIX_STD140 or STD430, STRIDEMIX_STD430>`: the data bytes of the input and of the output must be equal in order.
pub fn verify_mixed_struct8<const STD140: bool>(
    inputs: &[Vec<u8>],
    outputs: &[Vec<u8>],
    _expected: &[Vec<u8>],
) -> bool {
    let data = |info: Vec<bool>, values: &[u8]| -> Vec<u8> {
        info.iter()
            .zip(values)
            .filter(|(is_data, _)| **is_data)
            .map(|(_, &value)| value)
            .collect()
    };
    data(mix_info8(STD140), &inputs[0]) == data(mix_info8(false), &outputs[0])
}

/// `addGraphics8bitStorage8bitStructMixedTypesGroup`: int8 data for each capability in turn from the stream seeded with the group name (the second capability's draws follow the first one's).
pub(super) fn mixed_struct8_io(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const STD430_SLOTS: usize = 976 * MIX_STRUCT_ARRAY_SIZE;
    const STD140_SLOTS: usize = 4480 * MIX_STRUCT_ARRAY_SIZE;
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let data = if number(spec, "cap") == 1 {
        get_int8s(&mut rnd, STD430_SLOTS);
        get_int8s(&mut rnd, STD140_SLOTS)
    } else {
        get_int8s(&mut rnd, STD430_SLOTS)
    };
    (vec![data.concat()], vec![vec![0u8; STD430_SLOTS]])
}

/// `graphicsCheckStruct<int16_t, int16_t, STRIDEMIX_STD140 or STD430, STRIDEMIX_STD430>`: the data slots of the input and of the output must hold the same values in order.
pub fn verify_mixed_struct<const STD140: bool>(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    let (input, output) = (halves(&inputs[0]), halves(&outputs[0]));
    let data = |info: Vec<bool>, values: &[u16]| -> Vec<u16> {
        info.iter()
            .zip(values)
            .filter(|(is_data, _)| **is_data)
            .map(|(_, &value)| value)
            .collect()
    };
    let (origin, result) = (data(mix_info(STD140), &input), data(mix_info(false), &output));
    origin == result
}

/// `addGraphics16bitStructMixedTypesGroup`: int16 data for each capability in turn from the stream seeded with the group name (the second capability's draws follow the first one's).
pub(super) fn mixed_struct_io(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const STD430_SLOTS: usize = 1216 * MIX_STRUCT_ARRAY_SIZE / 2;
    const STD140_SLOTS: usize = 4480 * MIX_STRUCT_ARRAY_SIZE / 2;
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let data = if number(spec, "cap") == 1 {
        get_int16s(&mut rnd, STD430_SLOTS);
        get_int16s(&mut rnd, STD140_SLOTS)
    } else {
        get_int16s(&mut rnd, STD430_SLOTS)
    };
    (vec![data.concat()], vec![vec![0u8; STD430_SLOTS * 2]])
}

/// `checkStruct<origin, result, ORIGIN_LAYOUT, RESULT_LAYOUT>` of the 8 bit storage tests: the low byte of every data slot of the input must equal that of the output slot in the same position.
fn verify_struct8<const ORIGIN_KIND: u8, const RESULT_KIND: u8>(
    inputs: &[Vec<u8>],
    outputs: &[Vec<u8>],
    _expected: &[Vec<u8>],
) -> bool {
    let (origin, result) = (struct_data_offsets(ORIGIN_KIND), struct_data_offsets(RESULT_KIND));
    origin.len() == result.len()
        && origin
            .iter()
            .zip(&result)
            .all(|(&from, &to)| inputs[0][from] == outputs[0][to])
}

/// The check for `kind` (0 8 bit std430, 1 8 bit std140, 2 32 bit std430, 3 32 bit std140) of the origin and the result.
pub fn struct8_verifier(origin: u8, result: u8) -> Option<super::compute_shader_case::VerifyIo> {
    use super::compute_shader_case::VerifyIo;
    Some(match (origin, result) {
        (0, 2) => verify_struct8::<0, 2> as VerifyIo,
        (1, 2) => verify_struct8::<1, 2> as VerifyIo,
        (2, 0) => verify_struct8::<2, 0> as VerifyIo,
        (3, 0) => verify_struct8::<3, 0> as VerifyIo,
        _ => return None,
    })
}

/// `addGraphics8BitStorageUniformStruct8To32Group` and `...Struct32To8Group`: the struct arrays of the four cases (capability x sint or uint) draw their input from one stream in order, the
/// output is a zeroed buffer of the other layout.
fn struct8_io(spec: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const STRUCTS: usize = MIX_STRUCT_ARRAY_SIZE;
    let mut rnd = Random::new(de_string_hash(text(spec, "seed")));
    let to_wide = text(spec, "dir") == "8to32";
    let target = number(spec, "draw") as usize;
    let mut input = Vec::new();
    for draw in 0..=target {
        let std140 = draw >= 2;
        input = if to_wide {
            get_int8s(&mut rnd, if std140 { 1184 * STRUCTS } else { 224 * STRUCTS }).concat()
        } else {
            get_int32s(&mut rnd, if std140 { 304 * STRUCTS } else { 184 * STRUCTS }).concat()
        };
    }
    let output = if to_wide {
        vec![0u8; 184 * STRUCTS * 4]
    } else {
        vec![0u8; 224 * STRUCTS]
    };
    (vec![input], vec![output])
}

/// The expected corner colours of the families that compute them from the data, `None` for the others.
pub fn storage_colors(spec: &str, input_colors: [[u8; 4]; 4]) -> Option<[[u8; 4]; 4]> {
    match text(spec, "gen") {
        "vp1" => Some(variable_pointer_expected_colors(
            input_colors,
            variable_pointer_single_input(spec).1,
        )),
        "vpn" => Some(variable_pointer_expected_colors(
            input_colors,
            VARIABLE_POINTER_NULLPTR_FLOAT,
        )),
        "vp2" => Some(variable_pointer_expected_colors(
            input_colors,
            variable_pointer_two_inputs(spec).2,
        )),
        _ => None,
    }
}
