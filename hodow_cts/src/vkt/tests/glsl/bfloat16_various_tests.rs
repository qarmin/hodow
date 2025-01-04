// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderBFloat16ComboTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `various` group: `function_call` dispatches twice in one command buffer, the push constant of each being the variant. The shaders are in `shaders/manifest/shader_bfloat16.toml`. The std430 layout of the structs
// the C++ mirrors with aligned types is written out as offsets: `A` is a bfloat16 at 0, a bf16vec2 at 4, a bf16vec3 at 8 and a bf16vec4 at 16, 24 bytes in all, and `B` is an `A`
// at 0, three bf16vec2 at 24, three `A` at 40 and two bf16vec3 at 112, 128 bytes in all. The bytes that are not a member of a struct are not compared; for `access_chains` neither
// are the members the shader does not write.

use crate::generated::shaders::shader_bfloat16::{
    BFLOAT16_ACCESS_CHAINS, BFLOAT16_COMPOSITES, BFLOAT16_FUNCTION_CALL, BFLOAT16_SWIZZLING,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::spirv_assembly::compute_shader_case::{
    ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase,
};
use crate::vkt::{TestCase, TestCaseGroup};

const A_SIZE: usize = 24;
const B_SIZE: usize = 128;
/// The members of `A` as (offset, bfloat16 count): the bytes of a struct that carry data.
const A_MEMBERS: [(usize, usize); 4] = [(0, 1), (4, 2), (8, 3), (16, 4)];

fn bf16(value: f32) -> u16 {
    (value.to_bits() >> 16) as u16
}

/// A buffer being written at offsets, with the bytes compared tracked beside it.
struct Layout {
    bytes: Vec<u8>,
    mask: Vec<u8>,
}

impl Layout {
    fn new(size: usize) -> Self {
        Self {
            bytes: vec![0; size],
            mask: vec![0; size],
        }
    }

    fn put(&mut self, offset: usize, value: u16) {
        self.bytes[offset..offset + 2].copy_from_slice(&value.to_le_bytes());
        self.mask[offset..offset + 2].fill(0xff);
    }

    fn get(&self, offset: usize) -> u16 {
        u16::from_le_bytes([self.bytes[offset], self.bytes[offset + 1]])
    }

    /// The `A` at `base` filled with consecutive floats from `value`, which `fillVecOrScalar` does for each member in turn.
    fn fill_a(&mut self, base: usize, value: &mut f32) {
        for (offset, count) in A_MEMBERS {
            for component in 0..count {
                self.put(base + offset + component * 2, bf16(*value));
                *value += 1.0;
            }
        }
    }
}

fn spec_for(layout_in: Layout, layout_out: Layout, push: Option<u32>) -> ComputeShaderSpec {
    let mut spec = ComputeShaderSpec {
        num_work_groups: [1, 1, 1],
        ..Default::default()
    };
    spec.push_constants = push.unwrap_or(0).to_le_bytes().to_vec();
    spec.inputs.push(layout_in.bytes);
    spec.outputs.push(layout_out.bytes);
    spec.output_masks.push(layout_out.mask);
    spec.extensions.push("VK_KHR_16bit_storage".to_string());
    spec.extensions.push("VK_KHR_shader_bfloat16".to_string());
    spec.features
        .extend([RequiredFeature::StorageBuffer16BitAccess, RequiredFeature::BFloat16Type]);
    spec
}

/// `BFloat16ComboInstance<Composites>`: `outp.a0 = inp.a1` member by member and `outp.a1 = inp.a0`.
fn composites_spec() -> ComputeShaderSpec {
    let mut input = Layout::new(2 * A_SIZE);
    let mut value = 1.0f32;
    input.fill_a(0, &mut value);
    input.fill_a(A_SIZE, &mut value);

    let mut output = Layout::new(2 * A_SIZE);
    for (offset, count) in A_MEMBERS {
        for component in 0..count {
            let at = offset + component * 2;
            output.put(at, input.get(A_SIZE + at));
            output.put(A_SIZE + at, input.get(at));
        }
    }
    spec_for(input, output, None)
}

/// `BFloat16ComboInstance<AccessChains>`: the members `verifyResult` compares.
fn access_chains_spec() -> ComputeShaderSpec {
    const A_OFFSET: usize = 0;
    const B_OFFSET: usize = 24;
    const C_OFFSET: usize = 40;
    const D_OFFSET: usize = 112;
    let mut input = Layout::new(3 * B_SIZE);
    let mut value = 1.0f32;
    for element in 0..3 {
        let base = element * B_SIZE;
        for a in [A_OFFSET, C_OFFSET, C_OFFSET + A_SIZE, C_OFFSET + 2 * A_SIZE] {
            input.fill_a(base + a, &mut value);
        }
        for index in 0..3 {
            for component in 0..2 {
                input.put(base + B_OFFSET + index * 4 + component * 2, bf16(value));
                value += 1.0;
            }
        }
        for index in 0..2 {
            for component in 0..3 {
                input.put(base + D_OFFSET + index * 8 + component * 2, bf16(value));
                value += 1.0;
            }
        }
    }

    let mut output = Layout::new(3 * B_SIZE);
    for c in 0..3 {
        let c_prim = (c + 1) % 3;
        output.put(c * B_SIZE + A_OFFSET, input.get(c_prim * B_SIZE + A_OFFSET));
        output.put(
            c * B_SIZE + C_OFFSET + c * A_SIZE,
            input.get(c_prim * B_SIZE + C_OFFSET + c_prim * A_SIZE),
        );
        for b in 0..2 {
            let b_prim = (b + 1) % 2;
            output.put(
                c * B_SIZE + B_OFFSET + c_prim * 4 + b * 2,
                input.get(c_prim * B_SIZE + B_OFFSET + c * 4 + b_prim * 2),
            );
            output.put(
                c_prim * B_SIZE + D_OFFSET + b_prim * 8 + c * 2,
                input.get(c * B_SIZE + D_OFFSET + b * 8 + c_prim * 2),
            );
        }
    }
    spec_for(input, output, None)
}

/// `std::next_permutation`
fn next_permutation(values: &mut [usize]) {
    let Some(pivot) = (0..values.len().saturating_sub(1))
        .rev()
        .find(|&i| values[i] < values[i + 1])
    else {
        values.reverse();
        return;
    };
    let swap_with = (pivot + 1..values.len())
        .rev()
        .find(|&i| values[i] > values[pivot])
        .expect("a larger value after the pivot");
    values.swap(pivot, swap_with);
    values[pivot + 1..].reverse();
}

/// `BFloat16ComboInstance<Swizzling>`: 124 swizzles of one `A`, each member's permutation advancing in step as `verifyResult` does.
fn swizzling_spec() -> ComputeShaderSpec {
    const OUTPUTS: usize = 24 + 6 + 2 + 1 + 91;
    let mut input = Layout::new(A_SIZE);
    let mut value = 3.0f32;
    input.fill_a(0, &mut value);

    let mut maps: Vec<Vec<usize>> = A_MEMBERS.iter().map(|&(_, count)| (0..count).collect()).collect();
    let mut output = Layout::new(OUTPUTS * A_SIZE);
    for element in 0..OUTPUTS {
        for (member, &(offset, count)) in A_MEMBERS.iter().enumerate() {
            for component in 0..count {
                output.put(
                    element * A_SIZE + offset + component * 2,
                    input.get(offset + maps[member][component] * 2),
                );
            }
        }
        for map in &mut maps {
            next_permutation(map);
        }
    }
    spec_for(input, output, Some(OUTPUTS as u32))
}

/// `BFloat16ComboInstance<FunctionCall>`: ten bfloat16 `1..=10` in, the components of each width reversed out, once through `ret_in` and once through `ret_ref`.
fn function_call_spec() -> ComputeShaderSpec {
    let mut input = Layout::new(10 * 2);
    for index in 0..10 {
        input.put(index * 2, bf16((index + 1) as f32));
    }

    let mut output = Layout::new(256 * 2);
    for variant in 0..2 {
        let mut reference_index = 0;
        for width in 1..=4usize {
            for i in 0..width {
                output.put(
                    (variant * 8 * 4 + (width - 1) * 4 + i) * 2,
                    input.get((reference_index + (width - 1 - i)) * 2),
                );
            }
            reference_index += width;
        }
    }

    let mut spec = spec_for(input, output, None);
    spec.push_constants.clear();
    spec.push_constant_sequence = vec![0u32.to_le_bytes().to_vec(), 1u32.to_le_bytes().to_vec()];
    spec
}

fn make_case(name: &str, spec: ComputeShaderSpec, programs: BinaryCollection) -> Box<dyn TestCase> {
    Box::new(SpvAsmComputeShaderCase {
        name: name.to_string(),
        spec,
        programs,
    })
}

/// `createBFloat16ComboTests`
pub fn create_bfloat16_various_tests() -> TestCaseGroup {
    let mut various = TestCaseGroup::new("various");
    various.add_child(make_case("composites", composites_spec(), BFLOAT16_COMPOSITES.programs));
    various.add_child(make_case(
        "access_chains",
        access_chains_spec(),
        BFLOAT16_ACCESS_CHAINS.programs,
    ));
    various.add_child(make_case(
        "function_call",
        function_call_spec(),
        BFLOAT16_FUNCTION_CALL.programs,
    ));
    various.add_child(make_case("swizzling", swizzling_spec(), BFLOAT16_SWIZZLING.programs));
    various
}
