// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderBFloat16DotTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shader is in `shaders/manifest/shader_bfloat16.toml`; the data is drawn here from `de::Random(seed)` the way
// `BFloat16OpDotInstance::iterate` draws it and the case runs through the compute case of the assembly groups, which compares with `verify_dot` below. `tcu::BrainFloat16`
// is its 16 bit pattern: the values drawn are halves of integers, which it holds exactly.

use crate::generated::shaders::shader_bfloat16::BFLOAT16_DOT;
use crate::tcu::random::Random;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::spirv_assembly::compute_shader_case::{
    ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase,
};
use crate::vkt::{TestCase, TestCaseGroup};

const ALWAYS_EXISTENT: u32 = 5;
const BFLOAT16_NAN: u16 = 0x7fc0;
const BFLOAT16_INF: u16 = 0x7f80;
const BFLOAT16_NEGATIVE_INF: u16 = 0xff80;

fn is_nan(bits: u16) -> bool {
    bits & 0x7f80 == 0x7f80 && bits & 0x007f != 0
}

fn as_float(bits: u16) -> f32 {
    f32::from_bits(u32::from(bits) << 16)
}

fn from_float(value: f32) -> u16 {
    (value.to_bits() >> 16) as u16
}

/// `generateInputData`: four bfloat16 per element, a NaN and an infinity placed in the third component of two elements.
fn input_data(count: u32, rnd: &mut Random) -> Vec<u8> {
    let nan = rnd.get_uint32() % count;
    let inf = rnd.get_uint32() % count;
    let mut bytes = Vec::with_capacity(count as usize * 8);
    for element in 0..count {
        for k in 0..4 {
            let value = if k == 2 && nan == element {
                BFLOAT16_NAN
            } else if k == 2 && inf == element {
                if inf % 2 == 1 {
                    BFLOAT16_INF
                } else {
                    BFLOAT16_NEGATIVE_INF
                }
            } else {
                let draw = rnd.get_uint32() % 15;
                from_float((draw as i32 - 7) as f32 / 2.0)
            };
            bytes.extend(value.to_le_bytes());
        }
    }
    bytes
}

/// `verifyResults`: a result is NaN where any used input is, and otherwise the float32 inner product of the used components.
fn verify_dot<const USED: usize>(inputs: &[Vec<u8>], outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    let component = |buffer: &[u8], element: usize, k: usize| {
        u16::from_le_bytes([buffer[element * 8 + k * 2], buffer[element * 8 + k * 2 + 1]])
    };
    let count = outputs[0].len() / 2;
    let mismatches = (0..count)
        .filter(|&element| {
            let result = u16::from_le_bytes([outputs[0][element * 2], outputs[0][element * 2 + 1]]);
            if (0..USED).any(|k| is_nan(component(&inputs[0], element, k)) || is_nan(component(&inputs[1], element, k)))
            {
                return !is_nan(result);
            }
            let product = (0..USED).fold(0.0f32, |sum, k| {
                sum + as_float(component(&inputs[0], element, k)) * as_float(component(&inputs[1], element, k))
            });
            product != as_float(result)
        })
        .count();
    mismatches == 0
}

fn make_case(name: &str, seed: u32, mode: u32) -> Box<dyn TestCase> {
    let mut rnd = Random::new(seed);
    let io_count = rnd.get_uint32().wrapping_add(ALWAYS_EXISTENT) % 64;

    let mut spec = ComputeShaderSpec {
        num_work_groups: [io_count, 1, 1],
        push_constants: mode.to_le_bytes().to_vec(),
        ..Default::default()
    };
    spec.inputs.push(input_data(io_count, &mut rnd));
    spec.inputs.push(input_data(io_count, &mut rnd));
    spec.outputs.push(vec![0u8; io_count as usize * 2]);
    spec.verify_io = Some(match mode {
        1 => verify_dot::<2>,
        2 => verify_dot::<3>,
        _ => verify_dot::<4>,
    });
    spec.extensions.push("VK_KHR_16bit_storage".to_string());
    spec.extensions.push("VK_KHR_shader_bfloat16".to_string());
    spec.features.extend([
        RequiredFeature::StorageBuffer16BitAccess,
        RequiredFeature::BFloat16DotProduct,
    ]);
    Box::new(SpvAsmComputeShaderCase {
        name: name.to_string(),
        spec,
        programs: BFLOAT16_DOT.programs,
    })
}

/// `createBFloat16DotTests`
pub fn create_bfloat16_dot_tests() -> TestCaseGroup {
    let mut dot = TestCaseGroup::new("dot");
    for (seed, (name, mode)) in (19u32..).zip([("vec2", 1u32), ("vec3", 2), ("vec4", 3)]) {
        dot.add_child(make_case(name, seed, mode));
    }
    dot
}
