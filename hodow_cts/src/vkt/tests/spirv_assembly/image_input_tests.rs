// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmNonSemanticInfoTests.cpp
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmImageSamplerTests.cpp (`addComputeImageSamplerTest`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Copyright (c) 2018 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the 824 cases is in `shaders/manifest/spirv_assembly_image_input.toml` (written by
// `scripts/gen_spirv_assembly_image_input_manifest.py`); the inputs are built here the way the two group functions build them. The image sampler group draws its
// 64 vec4 once from `de::Random(deStringHash("image_sampler"))` and every case with two combined image samplers inverts them (`1 - x`, which is not
// an involution in floats), so a case's `flips` says how many inversions upstream had made when it was created.

use vulkanalia::prelude::v1_0::*;

use super::compute_shader_case::{ComputeShaderSpec, InputKind, SpvAsmComputeShaderCase};
use crate::generated::shaders::spirv_assembly_image_input::ALL_IMAGE_INPUT_CASE;
use crate::tcu::de_string_hash;
use crate::tcu::random::Random;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

const NUM_DATA_POINTS: usize = 64;
const NUM_ELEMENTS: usize = 10;

/// The `rust_type` of the manifest entries: one case with an image or a sampler as its input.
#[derive(Clone, Copy)]
pub struct ImageInputCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

fn number(spec: &str, key: &str) -> i64 {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("image input spec without {key}"))
        .parse()
        .unwrap_or_else(|_| panic!("image input spec with a bad {key}"))
}

fn floats_to_bytes(values: &[f32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

fn nop_verify(_inputs: &[Vec<u8>], _outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    true
}

/// `optypeimageFormatMismatchSpirvData`'s `m_format`, in its order.
const MISMATCH_FORMATS: [vk::Format; 12] = [
    vk::Format::R8G8B8A8_UNORM,
    vk::Format::R8G8B8A8_SNORM,
    vk::Format::R8G8B8A8_UINT,
    vk::Format::R8G8B8A8_SINT,
    vk::Format::R16G16B16A16_UINT,
    vk::Format::R16G16B16A16_SINT,
    vk::Format::R16G16B16A16_SFLOAT,
    vk::Format::R32_UINT,
    vk::Format::R32_SINT,
    vk::Format::R32G32B32A32_UINT,
    vk::Format::R32G32B32A32_SINT,
    vk::Format::R32G32B32A32_SFLOAT,
];

/// `getComputeShaderSpec` of the non semantic info group.
fn non_semantic_spec() -> ComputeShaderSpec {
    let in_out: Vec<f32> = (0..NUM_ELEMENTS).map(|ndx| ndx as f32).collect();
    ComputeShaderSpec {
        extensions: vec!["VK_KHR_shader_non_semantic_info".to_string()],
        inputs: vec![floats_to_bytes(&in_out), vec![0u8; 256 * std::mem::size_of::<i32>()]],
        input_kinds: vec![InputKind::Buffer, InputKind::StorageImage],
        outputs: vec![floats_to_bytes(&in_out)],
        num_work_groups: [NUM_ELEMENTS as u32, 1, 1],
        ..Default::default()
    }
}

/// `addComputeImageSamplerTest`'s spec of one case.
fn image_sampler_spec(spec_text: &str) -> ComputeShaderSpec {
    let desc = number(spec_text, "desc");
    let flips = number(spec_text, "flips");
    let mismatch = number(spec_text, "mismatch");

    let mut rnd = Random::new(de_string_hash("image_sampler"));
    let mut input_data: Vec<[f32; 4]> = (0..NUM_DATA_POINTS)
        .map(|_| {
            [
                rnd.get_float_range(0.0, 1.0),
                rnd.get_float_range(0.0, 1.0),
                rnd.get_float_range(0.0, 1.0),
                rnd.get_float_range(0.0, 1.0),
            ]
        })
        .collect();
    let invert = |data: &mut Vec<[f32; 4]>| {
        data.iter_mut()
            .for_each(|vec4| vec4.iter_mut().for_each(|value| *value = 1.0 - *value))
    };
    for _ in 0..flips {
        invert(&mut input_data);
    }
    let bytes = |data: &[[f32; 4]]| floats_to_bytes(&data.concat());

    // DESCRIPTOR_TYPE_STORAGE_IMAGE, SAMPLED_IMAGE, COMBINED_IMAGE_SAMPLER and its two separate forms.
    let first_kind = match desc {
        0 => InputKind::StorageImage,
        1 => InputKind::SampledImage,
        _ => InputKind::CombinedImageSampler,
    };
    let mut spec = ComputeShaderSpec {
        num_work_groups: [NUM_DATA_POINTS as u32, 1, 1],
        ..Default::default()
    };
    spec.inputs.push(bytes(&input_data));
    spec.input_kinds.push(first_kind);

    if desc == 1 {
        spec.inputs.push(Vec::new());
        spec.input_kinds.push(InputKind::Sampler);
    }

    if desc == 4 {
        invert(&mut input_data);
        spec.inputs.push(bytes(&input_data));
        spec.input_kinds.push(InputKind::CombinedImageSampler);
    }

    spec.outputs.push(bytes(&input_data));

    if number(spec_text, "v16") != 0 {
        spec.spirv_version_minor = Some(6);
    }

    if mismatch >= 0 {
        spec.verify_io = Some(nop_verify);
        spec.input_format = MISMATCH_FORMATS[mismatch as usize];
    }
    spec
}

fn make_case(case: &ImageInputCase, leaf: &str) -> Box<dyn TestCase> {
    let spec = if case.spec.contains("group=nonsemantic") {
        non_semantic_spec()
    } else {
        image_sampler_spec(case.spec)
    };
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

/// The image input groups of `spirv_assembly.instruction.compute` as the groups of their path below `compute` and the test case.
pub fn create_image_input_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_IMAGE_INPUT_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (segments, make_case(case, leaf))
        })
        .collect()
}
