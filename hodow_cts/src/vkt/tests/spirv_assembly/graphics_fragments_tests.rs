// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmInstructionTests.cpp (the graphics groups named in the modifications note)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The graphics cases that are only fragments (`createTestsForAllStages` with no resources: opname_abuse, opmembername_abuse, opsource, opsourcecontinued, opnoline, opmoduleprocessed, opline, opconstantnull, opconstantcomposite, opmemoryaccess) are
// in `shaders/manifest/spirv_assembly_graphics_fragments.toml`, written by `scripts/gen_spirv_assembly_graphics_fragments_manifest.py`, one case per stage; they
// run through `graphics_shader_case.rs`, which checks the four corner colours (`inc`/`outc` of the spec, `OpModuleProcessed`'s binary check is not done). The names with bytes that are not UTF-8 upstream are the characters of the same
// byte values here.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase, VerifyIo};
use super::graphics_shader_case::SpvAsmGraphicsShaderCase;
use super::graphics_storage_data::{
    float16_logical_verifier, float16_vector_shuffle_verifier, storage_colors, storage_io, storage_push_constants,
    struct8_verifier, verify_float16_composite, verify_float16_function, verify_float16_vector_extract,
    verify_float16_vector_insert, verify_mixed_struct, verify_mixed_struct8,
};
use super::instruction_tests::indexing_struct_io;
use super::storage16_tests::{verify_float16_results, verify_float16_results64, verify_float32, verify_float64};
use super::struct16_tests::make_spec as make_struct_spec;
use crate::generated::shaders::spirv_assembly_compute_fragments::ALL_COMPUTE_FRAGMENTS_CASE;
use crate::generated::shaders::spirv_assembly_graphics_fragments::ALL_GRAPHICS_FRAGMENTS_CASE;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

/// The `rust_type` of the manifest entries: one stage of one fragments-only case.
#[derive(Clone, Copy)]
pub struct GraphicsFragmentsCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

/// The `rust_type` of the compute entries: the same fragments as the graphics cases, in the compute shader boilerplate.
#[derive(Clone, Copy)]
pub struct ComputeFragmentsCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

fn field<'a>(spec: &'a str, name: &str) -> &'a str {
    spec.split(';')
        .find_map(|part| part.strip_prefix(name).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("the spec `{spec}` has no field `{name}`"))
}

const DEFAULT_COLORS: [[u8; 4]; 4] = [
    [255, 255, 255, 255],
    [255, 0, 0, 255],
    [0, 255, 0, 255],
    [0, 0, 255, 255],
];

fn optional_field<'a>(spec: &'a str, name: &str) -> Option<&'a str> {
    spec.split(';')
        .find_map(|part| part.strip_prefix(name).and_then(|rest| rest.strip_prefix('=')))
}

fn hex_buffers(spec: &str, name: &str) -> Vec<Vec<u8>> {
    spec.split(';')
        .find_map(|part| part.strip_prefix(name).and_then(|rest| rest.strip_prefix('=')))
        .filter(|list| !list.is_empty())
        .map(|list| list.split(',').map(hex_bytes).collect())
        .unwrap_or_default()
}

fn hex_bytes(hex: &str) -> Vec<u8> {
    (0..hex.len())
        .step_by(2)
        .map(|index| u8::from_str_radix(&hex[index..index + 2], 16).expect("the buffers of a spec are hex"))
        .collect()
}

fn colors(hex: &str) -> [[u8; 4]; 4] {
    let bytes: Vec<u8> = (0..hex.len())
        .step_by(2)
        .map(|index| u8::from_str_radix(&hex[index..index + 2], 16).expect("the colours of a spec are hex"))
        .collect();
    std::array::from_fn(|corner| {
        [
            bytes[corner * 4],
            bytes[corner * 4 + 1],
            bytes[corner * 4 + 2],
            bytes[corner * 4 + 3],
        ]
    })
}

fn make_spec(spec: &str) -> ComputeShaderSpec {
    if optional_field(spec, "gen") == Some("s16st") {
        // The compute struct cases carry the same data, layouts and checks as the graphics ones; only the requirements of the 32 to 16 direction and the colours differ.
        let narrow_first = optional_field(spec, "group") == Some("16to32");
        let capability = optional_field(spec, "cap").unwrap_or("0");
        let mut base = make_struct_spec(&format!(
            "group={};cap={capability}",
            if narrow_first { "16to32" } else { "32to16" }
        ));
        base.num_work_groups = [1, 1, 1];
        base.graphics_colors = Some((DEFAULT_COLORS, DEFAULT_COLORS));
        if !narrow_first {
            base.features = vec![RequiredFeature::StorageBuffer16BitAccess];
        }
        return base;
    }
    let minor = spec
        .split(';')
        .find_map(|part| part.strip_prefix("minor="))
        .and_then(|minor| minor.parse::<u32>().ok());
    let (inputs, outputs, masks) = match optional_field(spec, "gen") {
        Some("indexing") => {
            let element = optional_field(spec, "elem")
                .and_then(|element| element.parse().ok())
                .unwrap_or(0);
            let (inputs, outputs) = indexing_struct_io("input", 128, element);
            (inputs, outputs, Vec::new())
        }
        Some(_) => storage_io(spec).expect("a known storage family"),
        None => (Vec::new(), hex_buffers(spec, "out"), hex_buffers(spec, "mask")),
    };
    let flag = |name: &str| optional_field(spec, name) == Some("1");
    ComputeShaderSpec {
        inputs,
        shader_int64: flag("int64"),
        features: [
            ("int16", RequiredFeature::ShaderInt16),
            ("sb16", RequiredFeature::StorageBuffer16BitAccess),
            ("ub16", RequiredFeature::UniformAndStorageBuffer16BitAccess),
            ("ub8", RequiredFeature::UniformAndStorageBuffer8BitAccess),
            ("sb8", RequiredFeature::StorageBuffer8BitAccess),
            ("pc16", RequiredFeature::StoragePushConstant16),
            ("pc8", RequiredFeature::StoragePushConstant8),
            ("f64", RequiredFeature::ShaderFloat64),
            ("f16", RequiredFeature::ShaderFloat16),
        ]
        .into_iter()
        .filter(|(name, _)| flag(name))
        .map(|(_, feature)| feature)
        .collect(),
        uniform_inputs: flag("uin"),
        float_controls_property: flag("fc16").then_some((16, "SignedZeroInfNanPreserve")),
        split_render_area: flag("split"),
        push_constants: if optional_field(spec, "gen").is_some() && optional_field(spec, "gen") != Some("indexing") {
            storage_push_constants(spec)
        } else {
            Vec::new()
        },
        verify_io: match optional_field(spec, "gen") {
            Some("f16fn") => Some(verify_float16_function as VerifyIo),
            Some("f16lg") => float16_logical_verifier(
                optional_field(spec, "op").and_then(|op| op.parse().ok()).unwrap_or(0),
                optional_field(spec, "nan") == Some("1"),
            ),
            Some("f16cc" | "f16ci") => Some(verify_float16_composite as VerifyIo),
            Some("f16vx") => Some(verify_float16_vector_extract as VerifyIo),
            Some("s8st") => struct8_verifier(
                optional_field(spec, "from")
                    .and_then(|kind| kind.parse().ok())
                    .unwrap_or(0),
                optional_field(spec, "to")
                    .and_then(|kind| kind.parse().ok())
                    .unwrap_or(0),
            ),
            Some("s8mix") if flag("ub8") => Some(verify_mixed_struct8::<true> as VerifyIo),
            Some("s8mix") => Some(verify_mixed_struct8::<false> as VerifyIo),
            Some("s16mix") if flag("ub16") => Some(verify_mixed_struct::<true> as VerifyIo),
            Some("s16mix") => Some(verify_mixed_struct::<false> as VerifyIo),
            Some("f16vs") => float16_vector_shuffle_verifier(
                optional_field(spec, "shuf")
                    .and_then(|code| code.parse().ok())
                    .unwrap_or(0),
            ),
            Some("f16vi") => match optional_field(spec, "comps") {
                Some("2") => Some(verify_float16_vector_insert::<2> as VerifyIo),
                Some("3") => Some(verify_float16_vector_insert::<3> as VerifyIo),
                _ => Some(verify_float16_vector_insert::<4> as VerifyIo),
            },
            _ => None,
        }
        .or(match optional_field(spec, "vf16d") {
            Some("1") => Some(verify_float16_results64::<1> as VerifyIo),
            Some("2") => Some(verify_float16_results64::<2> as VerifyIo),
            Some("3") => Some(verify_float16_results64::<3> as VerifyIo),
            _ => None,
        }
        .or(match optional_field(spec, "vf16") {
            Some("1") => Some(verify_float16_results::<1> as VerifyIo),
            Some("2") => Some(verify_float16_results::<2> as VerifyIo),
            Some("3") => Some(verify_float16_results::<3> as VerifyIo),
            _ if flag("vf32") => Some(verify_float32 as VerifyIo),
            _ if flag("vf64") => Some(verify_float64 as VerifyIo),
            _ => None,
        })),
        variable_pointers_storage_buffer: flag("varptr"),
        variable_pointers: flag("varptrfull"),
        uses_64bit_indexing: flag("i64idx"),
        extensions: spec
            .split(';')
            .find_map(|part| part.strip_prefix("ext="))
            .filter(|list| !list.is_empty())
            .map(|list| list.split(',').map(str::to_string).collect())
            .unwrap_or_default(),
        spirv_version_minor: minor,
        check_graphics_versions: minor.is_some(),
        spirv_1_3: field(spec, "spv13") == "1",
        outputs,
        output_masks: masks,
        graphics_colors: {
            let input_colors = colors(field(spec, "inc"));
            let expected_colors = match optional_field(spec, "gen") {
                Some(_) if optional_field(spec, "gen") != Some("indexing") => {
                    storage_colors(spec, input_colors).unwrap_or_else(|| colors(field(spec, "outc")))
                }
                _ => colors(field(spec, "outc")),
            };
            Some((input_colors, expected_colors))
        },
        ..Default::default()
    }
}

/// The fragments-only groups as the groups of each case path below `graphics` and the test case.
pub fn create_graphics_fragments_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_GRAPHICS_FRAGMENTS_CASE
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

/// The fragments-only compute groups as the groups of each case path below `compute` and the test case.
pub fn create_compute_fragments_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_COMPUTE_FRAGMENTS_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            let test: Box<dyn TestCase> = Box::new(SpvAsmComputeShaderCase {
                name: leaf.to_string(),
                spec: make_spec(case.spec),
                programs: case.programs,
            });
            (segments, test)
        })
        .collect()
}
