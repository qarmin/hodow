// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `instruction.compute` is registered, and of it only the groups in
// `instruction_tests.rs`, and `constant_data`; the `type` child and the graphics half are not ported.

pub mod amber_tests;
pub mod compare64_graphics_tests;
pub mod compute_shader_case;
pub mod compute_shader_derivatives_tests;
pub mod convert_graphics_tests;
pub mod graphics_fragments_tests;
// Disabled until an spirv-as that knows the ConstantDataKHR capability is available to regenerate its manifest (see
// shaders/manifest/spirv_assembly_constant_data.toml.disabled).
// pub mod constant_data_tests;
pub mod dot_product_tests;
pub mod early_fragment_cases;
pub mod early_fragment_tests;
pub mod float_controls2_tests;
pub mod fma_tests;
pub mod function_params_tests;
pub mod graphics_shader_case;
pub mod graphics_storage_data;
pub mod hlsl_tests;
pub mod image_input_tests;
pub mod image_query_tests;
pub mod instruction_tests;
pub mod maint9_vectorization_tests;
pub mod multiple_shaders_extended_tests;
pub mod opselect_different_strides_tests;
pub mod opundef_buffer_tests;
pub mod physical_storage_buffer_tests;
pub mod pointers_tests;
pub mod raw_access_chain_tests;
pub mod storage16_tests;
pub mod storage8_tests;
pub mod struct16_tests;
pub mod trinary_minmax_tests;
pub mod type_tests;
pub mod untyped_pointers_tests;
pub mod utils;

use crate::vkt::TestCaseGroup;

/// `createTests` - the `spirv_assembly` group.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("spirv_assembly");
    group.add_child(instruction_tests::create_instruction_tests());
    group.add_child(type_tests::create_type_tests());

    group
}
