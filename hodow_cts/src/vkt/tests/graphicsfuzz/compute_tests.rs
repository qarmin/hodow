// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/amber/vktAmberGraphicsFuzzTests.cpp (the compute scripts under data/vulkan/amber/graphicsfuzz)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 Google LLC
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The five compute scripts the Amber compute conversion does not take - a read-write storage buffer at binding 0 next to
// uniform buffers of a vec2 at bindings 1 and 2 - are written into `shaders/manifest/graphicsfuzz_compute.toml` by `scripts/gen_graphicsfuzz_compute_manifest.py`
// and run through the compute case of the assembly groups with the output (the storage buffer, filled with its initial contents) bound before the inputs (the uniform buffers).

use crate::generated::shaders::graphicsfuzz_compute::ALL_GRAPHICS_FUZZ_COMPUTE_CASE;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;
use crate::vkt::tests::spirv_assembly::compute_shader_case::{ComputeShaderSpec, SpvAsmComputeShaderCase};

/// The `rust_type` of the manifest entries: one compute Amber script.
#[derive(Clone, Copy)]
pub struct GraphicsFuzzComputeCase {
    pub name: &'static str,
    /// `groups=x,y,z;ssbo=<hex>;ubo=<binding>:<hex>,...;expect=<offset>:<hex>,...`: the work group counts, the storage buffer at binding 0, the uniform buffers and the words of the storage buffer that are compared.
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

fn field<'a>(spec: &'a str, key: &str) -> &'a str {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("graphicsfuzz compute spec without {key}"))
}

fn decode_hex(hex: &str) -> Vec<u8> {
    (0..hex.len() / 2)
        .map(|ndx| u8::from_str_radix(&hex[ndx * 2..ndx * 2 + 2], 16).expect("hex digits"))
        .collect()
}

fn make_spec(text: &str) -> ComputeShaderSpec {
    let groups: Vec<u32> = field(text, "groups")
        .split(',')
        .map(|count| count.parse().expect("a group count"))
        .collect();
    let ssbo = decode_hex(field(text, "ssbo"));

    let mut expected = vec![0u8; ssbo.len()];
    let mut mask = vec![0u8; ssbo.len()];
    for probe in field(text, "expect").split(',').filter(|probe| !probe.is_empty()) {
        let (offset, hex) = probe.split_once(':').expect("an offset and a value");
        let offset: usize = offset.parse().expect("an offset");
        let value = decode_hex(hex);
        expected[offset..offset + value.len()].copy_from_slice(&value);
        mask[offset..offset + value.len()].fill(0xff);
    }

    let mut spec = ComputeShaderSpec {
        num_work_groups: [groups[0], groups[1], groups[2]],
        output_first: true,
        uniform_inputs: true,
        ..Default::default()
    };
    for ubo in field(text, "ubo").split(',').filter(|ubo| !ubo.is_empty()) {
        spec.inputs
            .push(decode_hex(ubo.split_once(':').expect("a binding and data").1));
    }
    spec.output_initial.push(ssbo);
    spec.outputs.push(expected);
    spec.output_masks.push(mask);
    spec
}

/// The compute scripts of `graphicsfuzz` as the test cases of the group.
pub fn create_graphicsfuzz_compute_cases() -> Vec<Box<dyn TestCase>> {
    ALL_GRAPHICS_FUZZ_COMPUTE_CASE
        .iter()
        .map(|case| {
            Box::new(SpvAsmComputeShaderCase {
                name: case.name.to_string(),
                spec: make_spec(case.spec),
                programs: case.programs,
            }) as Box<dyn TestCase>
        })
        .collect()
}
