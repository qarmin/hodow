// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `builtin` half (`BuiltinFunctionTest`, 650 cases) and all nine `GPUShaderFP64Test1`-`Test9` (`fp64.errors`, `max_uniform_components`, `named_uniform_blocks`, `state_query`, `conversions`, `illegal_conversions`, `varyings`, `valid_constructors`, `operators`) are ported.

mod builtin;
mod conversions;
mod errors;
mod errors_shaders;
mod illegal_conversions;
mod max_uniform_components;
mod named_uniform_blocks;
mod operators;
mod shader_stages;
mod state_query;
mod state_query_shaders;
mod types;
mod valid_constructors;
mod varyings;

use crate::glu::{TestCase, TestCaseGroup};

/// `GPUShaderFP64Tests::init`, with the `fp64` cases that are ported
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("gpu_shader_fp64");

    let mut fp64 = TestCaseGroup::new("fp64");
    fp64.add_child(Box::new(errors::Errors) as Box<dyn TestCase>);
    fp64.add_child(Box::new(max_uniform_components::MaxUniformComponents) as Box<dyn TestCase>);
    fp64.add_child(Box::new(named_uniform_blocks::NamedUniformBlocks) as Box<dyn TestCase>);
    fp64.add_child(Box::new(state_query::StateQuery) as Box<dyn TestCase>);
    fp64.add_child(Box::new(conversions::Conversions) as Box<dyn TestCase>);
    fp64.add_child(Box::new(illegal_conversions::IllegalConversions) as Box<dyn TestCase>);
    fp64.add_child(Box::new(varyings::Varyings) as Box<dyn TestCase>);
    fp64.add_child(Box::new(valid_constructors::ValidConstructors) as Box<dyn TestCase>);
    fp64.add_child(Box::new(operators::Operators) as Box<dyn TestCase>);
    group.add_child(fp64);

    group.add_child(builtin::create_tests());
    group
}
