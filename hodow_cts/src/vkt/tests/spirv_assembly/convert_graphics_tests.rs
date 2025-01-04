// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmInstructionTests.cpp (createConvertGraphicsTests)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The fragments of `getConvertCaseFragments` for every `ConvertCase` and each of the five stages are in
// `shaders/manifest/spirv_assembly_convert_graphics.toml`, written by `scripts/gen_spirv_assembly_convert_graphics_manifest.py`; the `spec` of a case carries the
// input and output buffers (hex) and the feature and extension tokens `getVulkanFeaturesAndExtensions` derives. The cases run through `graphics_shader_case.rs`
// and the output buffer is compared byte for byte.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature};
use super::graphics_shader_case::SpvAsmGraphicsShaderCase;
use crate::generated::shaders::spirv_assembly_convert_graphics::ALL_CONVERT_GRAPHICS_CASE;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

/// The `rust_type` of the manifest entries: one stage of one `ConvertCase`.
#[derive(Clone, Copy)]
pub struct ConvertGraphicsCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

fn field<'a>(spec: &'a str, name: &str) -> &'a str {
    spec.split(';')
        .find_map(|part| part.strip_prefix(name).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("the spec `{spec}` has no field `{name}`"))
}

fn from_hex(text: &str) -> Vec<u8> {
    (0..text.len())
        .step_by(2)
        .map(|index| u8::from_str_radix(&text[index..index + 2], 16).expect("the buffers of a spec are hex"))
        .collect()
}

fn make_spec(spec: &str) -> ComputeShaderSpec {
    let mut features = Vec::new();
    let mut extensions = vec!["VK_KHR_storage_buffer_storage_class".to_string()];
    for token in field(spec, "feat").split(',').filter(|token| !token.is_empty()) {
        match token {
            "Features.shaderInt16" => features.push(RequiredFeature::ShaderInt16),
            "Features.shaderInt64" => features.push(RequiredFeature::ShaderInt64),
            "shaderFloat64" => features.push(RequiredFeature::ShaderFloat64),
            "Storage16BitFeatures.storageBuffer16BitAccess" => features.push(RequiredFeature::StorageBuffer16BitAccess),
            "Float16Int8Features.shaderFloat16" => features.push(RequiredFeature::ShaderFloat16),
            "Float16Int8Features.shaderInt8" => features.push(RequiredFeature::ShaderInt8),
            "Storage8BitFeatures.storageBuffer8BitAccess" => features.push(RequiredFeature::StorageBuffer8BitAccess),
            extension if extension.starts_with("VK_") => extensions.push(extension.to_string()),
            other => panic!("unknown feature token `{other}`"),
        }
    }
    ComputeShaderSpec {
        inputs: vec![from_hex(field(spec, "in"))],
        outputs: vec![from_hex(field(spec, "out"))],
        extensions,
        features,
        ..Default::default()
    }
}

/// `createConvertGraphicsTests` as the groups of each case path below `graphics` and the test case.
pub fn create_convert_graphics_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_CONVERT_GRAPHICS_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            let test: Box<dyn TestCase> = Box::new(SpvAsmGraphicsShaderCase {
                name: leaf.to_string(),
                spec: make_spec(case.spec),
                programs: case.programs,
            });
            (segments, test)
        })
        .collect()
}
