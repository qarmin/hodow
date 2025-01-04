// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fRandomShaderTests.cpp / .hpp
//   modules/gles3/functional/es3fRandomShaderTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The two upstream files are identical except that the
// ES 3.0 one sets `params.version = rsg::VERSION_300`, so they are one builder taking the version.
// Each upstream `TestCaseGroup` subclass is one `group_*` function below, in the same order.

use crate::gls::random_shader_case::RandomShaderCase;
use crate::glu::{TestCase, TestCaseGroup};
use crate::rsg::parameters::{ProgramParameters, Version};

/// `createRandomShaderCase`
fn create_random_shader_case(
    base_params: &ProgramParameters,
    seed: u32,
    vertex: bool,
    fragment: bool,
) -> Box<dyn TestCase> {
    let mut params = base_params.clone();

    params.seed = seed;
    params.vertex_parameters.randomize = vertex;
    params.fragment_parameters.randomize = fragment;

    Box::new(RandomShaderCase::new(seed.to_string(), params))
}

/// Which of the `vertex`/`fragment`/`combined` subgroups a group has, and how many seeds each gets.
struct Seeds {
    vertex: u32,
    fragment: u32,
    combined: u32,
}

/// The shared body of every `*Group::init`: one subgroup per stage combination.
fn build_group(name: &str, params: &ProgramParameters, seeds: Seeds) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);

    let mut vertex_group = TestCaseGroup::new("vertex");
    for seed in 0..seeds.vertex {
        vertex_group.add_child(create_random_shader_case(params, seed, true, false));
    }
    group.add_child(vertex_group);

    let mut fragment_group = TestCaseGroup::new("fragment");
    for seed in 0..seeds.fragment {
        fragment_group.add_child(create_random_shader_case(params, seed, false, true));
    }
    group.add_child(fragment_group);

    if seeds.combined > 0 {
        let mut combined_group = TestCaseGroup::new("combined");
        for seed in 0..seeds.combined {
            combined_group.add_child(create_random_shader_case(params, seed, true, true));
        }
        group.add_child(combined_group);
    }

    group
}

/// `BasicExpressionGroup`
fn group_basic_expression(base: &ProgramParameters) -> TestCaseGroup {
    build_group(
        "basic_expression",
        base,
        Seeds {
            vertex: 100,
            fragment: 100,
            combined: 100,
        },
    )
}

/// `ScalarConversionGroup`
fn group_scalar_conversion(base: &ProgramParameters) -> TestCaseGroup {
    let mut params = base.clone();
    params.use_scalar_conversions = true;

    build_group(
        "scalar_conversion",
        &params,
        Seeds {
            vertex: 100,
            fragment: 100,
            combined: 100,
        },
    )
}

/// `SwizzleGroup`
fn group_swizzle(base: &ProgramParameters) -> TestCaseGroup {
    let mut params = base.clone();
    params.use_scalar_conversions = true;
    params.use_swizzle = true;

    build_group(
        "swizzle",
        &params,
        Seeds {
            vertex: 50,
            fragment: 50,
            combined: 0,
        },
    )
}

/// `ComparisonOpsGroup`
fn group_comparison_ops(base: &ProgramParameters) -> TestCaseGroup {
    let mut params = base.clone();
    params.use_scalar_conversions = true;
    params.use_comparison_ops = true;

    build_group(
        "comparison_ops",
        &params,
        Seeds {
            vertex: 50,
            fragment: 50,
            combined: 0,
        },
    )
}

/// `ConditionalsGroup`
fn group_conditionals(base: &ProgramParameters) -> TestCaseGroup {
    let mut params = base.clone();
    params.use_scalar_conversions = true;
    params.use_swizzle = true;
    params.use_comparison_ops = true;
    params.use_conditionals = true;
    params.vertex_parameters.max_statement_depth = 4;
    params.vertex_parameters.max_statements_per_block = 5;
    params.fragment_parameters.max_statement_depth = 4;
    params.fragment_parameters.max_statements_per_block = 5;

    build_group(
        "conditionals",
        &params,
        Seeds {
            vertex: 100,
            fragment: 100,
            combined: 100,
        },
    )
}

/// `TrigonometricGroup`
fn group_trigonometric(base: &ProgramParameters) -> TestCaseGroup {
    let mut params = base.clone();
    params.use_scalar_conversions = true;
    params.use_swizzle = true;
    params.trigonometric_base_weight = 4.0;

    build_group(
        "trigonometric",
        &params,
        Seeds {
            vertex: 100,
            fragment: 100,
            combined: 0,
        },
    )
}

/// `ExponentialGroup`
fn group_exponential(base: &ProgramParameters) -> TestCaseGroup {
    let mut params = base.clone();
    params.use_scalar_conversions = true;
    params.use_swizzle = true;
    params.exponential_base_weight = 4.0;

    build_group(
        "exponential",
        &params,
        Seeds {
            vertex: 100,
            fragment: 100,
            combined: 0,
        },
    )
}

/// `TextureGroup` - only 50 vertex cases and 150 fragment cases.
fn group_texture(base: &ProgramParameters) -> TestCaseGroup {
    let mut params = base.clone();
    params.use_scalar_conversions = true;
    params.use_swizzle = true;
    params.vertex_parameters.tex_lookup_base_weight = 10.0;
    params.vertex_parameters.use_texture_2d = true;
    params.vertex_parameters.use_texture_cube = true;
    params.fragment_parameters.tex_lookup_base_weight = 10.0;
    params.fragment_parameters.use_texture_2d = true;
    params.fragment_parameters.use_texture_cube = true;

    build_group(
        "texture",
        &params,
        Seeds {
            vertex: 50,
            fragment: 150,
            combined: 0,
        },
    )
}

/// `AllFeaturesGroup`
fn group_all_features(base: &ProgramParameters) -> TestCaseGroup {
    let mut params = base.clone();
    params.use_scalar_conversions = true;
    params.use_swizzle = true;
    params.use_comparison_ops = true;
    params.use_conditionals = true;
    params.trigonometric_base_weight = 1.0;
    params.exponential_base_weight = 1.0;

    params.vertex_parameters.max_statement_depth = 4;
    params.vertex_parameters.max_statements_per_block = 7;
    params.vertex_parameters.max_expression_depth = 7;
    params.vertex_parameters.max_combined_variable_scalars = 64;
    params.fragment_parameters.max_statement_depth = 4;
    params.fragment_parameters.max_statements_per_block = 7;
    params.fragment_parameters.max_expression_depth = 7;
    params.fragment_parameters.max_combined_variable_scalars = 64;

    // Texture lookups are enabled for fragment shaders only.
    params.fragment_parameters.tex_lookup_base_weight = 4.0;
    params.fragment_parameters.use_texture_2d = true;
    params.fragment_parameters.use_texture_cube = true;

    build_group(
        "all_features",
        &params,
        Seeds {
            vertex: 100,
            fragment: 100,
            combined: 0,
        },
    )
}

/// `RandomShaderTests::init` (`version` is `VERSION_100` for ES 2.0 and `VERSION_300` for ES 3.0).
pub fn create_tests(version: Version) -> TestCaseGroup {
    let base = ProgramParameters {
        version,
        ..ProgramParameters::default()
    };

    let mut group = TestCaseGroup::new("random");
    group.add_child(group_basic_expression(&base));
    group.add_child(group_scalar_conversion(&base));
    group.add_child(group_swizzle(&base));
    group.add_child(group_comparison_ops(&base));
    group.add_child(group_conditionals(&base));
    group.add_child(group_trigonometric(&base));
    group.add_child(group_exponential(&base));
    group.add_child(group_texture(&base));
    group.add_child(group_all_features(&base));
    group
}
