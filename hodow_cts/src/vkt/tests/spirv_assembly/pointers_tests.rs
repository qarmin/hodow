// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmVariablePointersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Copyright (c) 2017 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the 630 cases of `variable_pointers` and `physical_pointers` (each with its `64b_indexing`
// twin) is in `shaders/manifest/spirv_assembly_pointers.toml` (written by `scripts/gen_spirv_assembly_pointers_manifest.py`); the data of each case is built
// here the way `addPhysicalOrVariablePointersComputeGroup`, `addComplexTypesPhysicalOrVariablePointersComputeGroup` and `addNullptrVariablePointersComputeGroup`
// build it, from the `spec` of the case. `addOpSelectDifferentStridesTest` is in `opselect_different_strides_tests.rs`.

use super::compute_shader_case::{ComputeShaderSpec, SpvAsmComputeShaderCase};
use crate::generated::shaders::spirv_assembly_pointers::ALL_POINTERS_CASE;
use crate::tcu::de_string_hash;
use crate::tcu::random::Random;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

const NUM_MUXES: usize = 100;
const NUM_FLOATS: usize = 64;
/// `--deqp-base-seed`, whose default `de::Random(seed).shuffle` of the selector inputs is drawn from.
const BASE_SEED: u32 = 0;

/// The `rust_type` of the manifest entries: one case of the variable or physical pointers compute groups.
#[derive(Clone, Copy)]
pub struct PointersCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

fn field<'a>(spec: &'a str, key: &str) -> &'a str {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("pointers spec without {key}"))
}

fn flag(spec: &str, key: &str) -> bool {
    field(spec, key) == "1"
}

fn floats_to_bytes(values: &[f32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

/// `fillRandomScalars<float>`
fn fill_random_scalars(rnd: &mut Random, min: f32, max: f32, dst: &mut [f32]) {
    for value in dst {
        *value = rnd.get_float_range(min, max);
    }
}

/// The inputs and the expected output of the `compute` group: `output[i] = (s[i] < 0) ? A[..] : B[..]`.
fn build_mux_io(single: bool, write: bool) -> (Vec<Vec<u8>>, Vec<u8>) {
    mux_io("compute", single, write)
}

/// The same for the group named `group`, whose name seeds the stream (`graphics` for the graphics twin).
pub(super) fn mux_io(group: &str, single: bool, write: bool) -> (Vec<Vec<u8>>, Vec<u8>) {
    let mut rnd = Random::new(de_string_hash(group));
    let mut input_a = vec![0.0f32; 2 * NUM_MUXES];
    let mut input_b = vec![0.0f32; 2 * NUM_MUXES];
    let mut input_s = vec![0.0f32; NUM_MUXES];

    fill_random_scalars(&mut rnd, -100.0, 100.0, &mut input_a);
    fill_random_scalars(&mut rnd, -100.0, 100.0, &mut input_b);

    // The S input has to have some positive and some negative values: random negatives for the first half, positives for the second, then shuffled.
    fill_random_scalars(&mut rnd, -100.0, -1.0, &mut input_s[..NUM_MUXES / 2]);
    fill_random_scalars(&mut rnd, 1.0, 100.0, &mut input_s[NUM_MUXES / 2..]);
    Random::new(BASE_SEED).shuffle(&mut input_s);

    let expected: Vec<f32> = (0..NUM_MUXES)
        .map(|i| {
            let negative = input_s[i] < 0.0;
            let selected = match (single, negative) {
                (true, true) => input_a[2 * i],
                (true, false) => input_a[2 * i + 1],
                (false, true) => input_a[i],
                (false, false) => input_b[i],
            };
            if write { 1.0 + selected } else { selected }
        })
        .collect();

    (
        vec![
            floats_to_bytes(&input_a),
            floats_to_bytes(&input_b),
            floats_to_bytes(&input_s),
        ],
        floats_to_bytes(&expected),
    )
}

/// The inputs and the expected output of the `complex_types_compute` group: the float at `offset` of the selected input.
fn build_complex_io(single: bool, select_a: bool, offset: usize) -> (Vec<Vec<u8>>, Vec<u8>) {
    let mut input_a = vec![0.0f32; NUM_FLOATS];
    let mut input_b = vec![0.0f32; NUM_FLOATS];
    let mut input_c = vec![0.0f32; 2 * NUM_FLOATS];

    // inputA is {0, 4, ..., 252} / 255, inputB is {3, 7, ..., 255} / 255 and inputC is inputA followed by inputB.
    for i in 0..NUM_FLOATS {
        input_a[i] = 4.0 * i as f32 / 255.0;
        input_b[i] = (4.0 * i as f32 + 3.0) / 255.0;
        input_c[i] = input_a[i];
        input_c[i + NUM_FLOATS] = input_b[i];
    }

    let selected: &[f32] = if single {
        &input_c
    } else if select_a {
        &input_a
    } else {
        &input_b
    };
    let expected = [selected[offset]];

    (
        vec![
            floats_to_bytes(&input_a),
            floats_to_bytes(&input_b),
            floats_to_bytes(&input_c),
        ],
        floats_to_bytes(&expected),
    )
}

fn make_case(case: &PointersCase, leaf: &str) -> Box<dyn TestCase> {
    let spec_text = case.spec;
    let phys = flag(spec_text, "phys");
    let (inputs, expected) = match field(spec_text, "group") {
        "mux" => build_mux_io(flag(spec_text, "single"), flag(spec_text, "write")),
        "complex" => build_complex_io(
            flag(spec_text, "single"),
            flag(spec_text, "sel"),
            field(spec_text, "offset").parse().expect("an offset"),
        ),
        _ => {
            let some_float = [78.0f32];
            (vec![floats_to_bytes(&some_float)], floats_to_bytes(&some_float))
        }
    };

    let num_work_groups = if field(spec_text, "group") == "mux" {
        [NUM_MUXES as u32, 1, 1]
    } else {
        [1, 1, 1]
    };
    let spec = ComputeShaderSpec {
        inputs,
        outputs: vec![expected],
        num_work_groups,
        extensions: if phys {
            Vec::new()
        } else {
            vec!["VK_KHR_variable_pointers".to_string()]
        },
        variable_pointers: flag(spec_text, "vp"),
        variable_pointers_storage_buffer: flag(spec_text, "vpsb"),
        uses_phys_storage_buffer: phys,
        uses_64bit_indexing: flag(spec_text, "b64"),
        ..Default::default()
    };
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

/// The pointer groups of `spirv_assembly.instruction.compute` as the groups of their path below `compute` and the test case.
pub fn create_pointers_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_POINTERS_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (segments, make_case(case, leaf))
        })
        .collect()
}
