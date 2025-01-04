// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderConstExprTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The `builtin_functions` half is a table of expressions, each of which the compiler must
// fold at compile time; `gls::shader_const_expr_tests` turns one row into the shader and
// the expected value. The expected values keep upstream's own `deMath` spelling rather
// than a baked literal, so a reader can see which function produced which number -
// `deFloatMod` in particular is `fmod`, not GLSL's `mod`.

use crate::generated::shader_library as lib;
use crate::gls::shader_const_expr_tests::{SHADER_BOTH, TestParams, create_tests as create_const_expr_tests};
use crate::gls::shader_library::{add_group_children, create_group};
use crate::glu::shader_util::DataType;
use crate::glu::{GlslVersion, TestCaseGroup};

/// `deFloatRsq`
fn de_float_rsq(a: f32) -> f32 {
    let s = a.sqrt();
    if s == 0.0 { 0.0 } else { 1.0 / s }
}

/// `deFloatFrac`
fn de_float_frac(a: f32) -> f32 {
    a - a.floor()
}

/// `deFloatMod` - `fmod`, which is not what GLSL's `mod` computes for a negative operand.
fn de_float_mod(a: f32, b: f32) -> f32 {
    a % b
}

/// `trigonometry`
fn trigonometry_cases() -> Vec<TestParams> {
    vec![
        TestParams {
            name: "radians",
            expression: "radians(${T} (90.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (90.0f32).to_radians(),
        },
        TestParams {
            name: "degrees",
            expression: "degrees(${T} (2.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (2.0f32).to_degrees(),
        },
        TestParams {
            name: "sin",
            expression: "sin(${T} (3.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (3.0f32).sin(),
        },
        TestParams {
            name: "cos",
            expression: "cos(${T} (3.2))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (3.2f32).cos(),
        },
        TestParams {
            name: "tan",
            expression: "tan(${T} (1.5))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (1.5f32).tan(),
        },
        TestParams {
            name: "asin",
            expression: "asin(${T} (0.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (0.0f32).asin(),
        },
        TestParams {
            name: "acos",
            expression: "acos(${T} (1.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (1.0f32).acos(),
        },
        TestParams {
            name: "atan_separate",
            expression: "atan(${T} (-1.0), ${T} (-1.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (-1.0f32).atan2(-1.0),
        },
        TestParams {
            name: "atan_combined",
            expression: "atan(${T} (2.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (2.0f32).atan(),
        },
    ]
}

/// `exponential`
fn exponential_cases() -> Vec<TestParams> {
    vec![
        TestParams {
            name: "pow",
            expression: "pow(${T} (1.7), ${T} (3.5))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (1.7f32).powf(3.5),
        },
        TestParams {
            name: "exp",
            expression: "exp(${T} (4.2))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (4.2f32).exp(),
        },
        TestParams {
            name: "log",
            expression: "log(${T} (42.12))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (42.12f32).ln(),
        },
        TestParams {
            name: "exp2",
            expression: "exp2(${T} (6.7))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (6.7f32).exp2(),
        },
        TestParams {
            name: "log2",
            expression: "log2(${T} (100.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (100.0f32).log2(),
        },
        TestParams {
            name: "sqrt",
            expression: "sqrt(${T} (10.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (10.0f32).sqrt(),
        },
        TestParams {
            name: "inversesqrt",
            expression: "inversesqrt(${T} (10.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: de_float_rsq(10.0),
        },
    ]
}

/// `common`
fn common_cases() -> Vec<TestParams> {
    vec![
        TestParams {
            name: "abs",
            expression: "abs(${T} (-42.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: 42.0,
        },
        TestParams {
            name: "sign",
            expression: "sign(${T} (-18.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: -1.0,
        },
        TestParams {
            name: "floor",
            expression: "floor(${T} (37.3))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (37.3f32).floor(),
        },
        TestParams {
            name: "ceil",
            expression: "ceil(${T} (82.2))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: (82.2f32).ceil(),
        },
        TestParams {
            name: "fract",
            expression: "fract(${T} (17.75))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: de_float_frac(17.75),
        },
        TestParams {
            name: "mod",
            expression: "mod(${T} (87.65), ${MT} (3.7))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: de_float_mod(87.65, 3.7),
        },
        TestParams {
            name: "min",
            expression: "min(${T} (12.3), ${MT} (32.1))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: 12.3,
        },
        TestParams {
            name: "max",
            expression: "max(${T} (12.3), ${MT} (32.1))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: 32.1,
        },
        TestParams {
            name: "clamp",
            expression: "clamp(${T} (42.1), ${MT} (10.0), ${MT} (15.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: 15.0,
        },
        TestParams {
            name: "mix",
            expression: "mix(${T} (10.0), ${T} (20.0), ${MT}(0.75))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: 17.5,
        },
        TestParams {
            name: "step",
            expression: "step(${MT} (3.2), ${T} (4.2))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: 1.0,
        },
        TestParams {
            name: "smoothstep",
            expression: "smoothstep(${MT} (3.0), ${MT} (5.0), ${T} (4.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: 0.5,
        },
    ]
}

/// `geometric`
fn geometric_cases() -> Vec<TestParams> {
    vec![
        TestParams {
            name: "length_float",
            expression: "length(1.0)",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 1.0,
        },
        TestParams {
            name: "length_vec2",
            expression: "length(vec2(1.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: (2.0f32).sqrt(),
        },
        TestParams {
            name: "length_vec3",
            expression: "length(vec3(1.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: (3.0f32).sqrt(),
        },
        TestParams {
            name: "length_vec4",
            expression: "length(vec4(1.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: (4.0f32).sqrt(),
        },
        TestParams {
            name: "distance_float",
            expression: "distance(1.0, 2.0)",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 1.0,
        },
        TestParams {
            name: "distance_vec2",
            expression: "distance(vec2(1.0), vec2(2.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: (2.0f32).sqrt(),
        },
        TestParams {
            name: "distance_vec3",
            expression: "distance(vec3(1.0), vec3(2.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: (3.0f32).sqrt(),
        },
        TestParams {
            name: "distance_vec4",
            expression: "distance(vec4(1.0), vec4(2.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: (4.0f32).sqrt(),
        },
        TestParams {
            name: "dot_float",
            expression: "dot(1.0, 1.0)",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 1.0,
        },
        TestParams {
            name: "dot_vec2",
            expression: "dot(vec2(1.0), vec2(1.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 2.0,
        },
        TestParams {
            name: "dot_vec3",
            expression: "dot(vec3(1.0), vec3(1.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 3.0,
        },
        TestParams {
            name: "dot_vec4",
            expression: "dot(vec4(1.0), vec4(1.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 4.0,
        },
        TestParams {
            name: "normalize_float",
            expression: "normalize(1.0)",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 1.0,
        },
        TestParams {
            name: "normalize_vec2",
            expression: "normalize(vec2(1.0)).x",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: de_float_rsq(2.0),
        },
        TestParams {
            name: "normalize_vec3",
            expression: "normalize(vec3(1.0)).x",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: de_float_rsq(3.0),
        },
        TestParams {
            name: "normalize_vec4",
            expression: "normalize(vec4(1.0)).x",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: de_float_rsq(4.0),
        },
        TestParams {
            name: "faceforward",
            expression: "faceforward(${T} (1.0), ${T} (1.0), ${T} (1.0))",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 4,
            out_type: DataType::Float,
            output: -1.0,
        },
        TestParams {
            name: "reflect_float",
            expression: "reflect(1.0, 1.0)",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: -1.0,
        },
        TestParams {
            name: "reflect_vec2",
            expression: "reflect(vec2(1.0), vec2(1.0, 0.0)).x",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: -1.0,
        },
        TestParams {
            name: "reflect_vec3",
            expression: "reflect(vec3(1.0), vec3(1.0, 0.0, 0.0)).x",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: -1.0,
        },
        TestParams {
            name: "reflect_vec4",
            expression: "reflect(vec4(1.0), vec4(1.0, 0.0, 0.0, 0.0)).x",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: -1.0,
        },
        TestParams {
            name: "refract_float",
            expression: "refract(1.0, 1.0, 0.5)",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: -1.0,
        },
        TestParams {
            name: "refract_vec2",
            expression: "refract(vec2(1.0), vec2(1.0, 0.0), 0.5).x",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: -1.0,
        },
        TestParams {
            name: "refract_vec3",
            expression: "refract(vec3(1.0), vec3(1.0, 0.0, 0.0), 0.5).x",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: -1.0,
        },
        TestParams {
            name: "refract_vec4",
            expression: "refract(vec4(1.0), vec4(1.0, 0.0, 0.0, 0.0), 0.5).x",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: -1.0,
        },
    ]
}

/// `matrix`
fn matrix_cases() -> Vec<TestParams> {
    vec![
        TestParams {
            name: "compMult_mat2",
            expression: "matrixCompMult(mat2(1.0), mat2(1.0))[0][0]",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 1.0,
        },
        TestParams {
            name: "compMult_mat3",
            expression: "matrixCompMult(mat3(1.0), mat3(1.0))[0][0]",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 1.0,
        },
        TestParams {
            name: "compMult_mat4",
            expression: "matrixCompMult(mat4(1.0), mat4(1.0))[0][0]",
            in_type: DataType::Float,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Float,
            output: 1.0,
        },
    ]
}

/// `vector_relational`
fn vector_relational_cases() -> Vec<TestParams> {
    vec![
        TestParams {
            name: "lessThan",
            expression: "lessThan(${T} (1.0), ${T} (2.0))",
            in_type: DataType::Float,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "lessThan",
            expression: "lessThan(${T} (1), ${T} (2))",
            in_type: DataType::Int,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "lessThanEqual",
            expression: "lessThanEqual(${T} (1.0), ${T} (1.0))",
            in_type: DataType::Float,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "lessThanEqual",
            expression: "lessThanEqual(${T} (1), ${T} (1))",
            in_type: DataType::Int,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "greaterThan",
            expression: "greaterThan(${T} (1.0), ${T} (2.0))",
            in_type: DataType::Float,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "greaterThan",
            expression: "greaterThan(${T} (1), ${T} (2))",
            in_type: DataType::Int,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "greaterThanEqual",
            expression: "greaterThanEqual(${T} (1.0), ${T} (2.0))",
            in_type: DataType::Float,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "greaterThanEqual",
            expression: "greaterThanEqual(${T} (1), ${T} (2))",
            in_type: DataType::Int,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "equal",
            expression: "equal(${T} (1.0), ${T} (1.2))",
            in_type: DataType::Float,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "equal",
            expression: "equal(${T} (1), ${T} (2))",
            in_type: DataType::Int,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "equal",
            expression: "equal(${T} (true), ${T} (false))",
            in_type: DataType::Bool,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "notEqual",
            expression: "notEqual(${T} (1.0), ${T} (1.2))",
            in_type: DataType::Float,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "notEqual",
            expression: "notEqual(${T} (1), ${T} (2))",
            in_type: DataType::Int,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "notEqual",
            expression: "notEqual(${T} (true), ${T} (false))",
            in_type: DataType::Bool,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "any_bvec2",
            expression: "any(bvec2(true, false))",
            in_type: DataType::Bool,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "any_bvec3",
            expression: "any(bvec3(true, false, false))",
            in_type: DataType::Bool,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "any_bvec4",
            expression: "any(bvec4(true, false, false, false))",
            in_type: DataType::Bool,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Bool,
            output: 1.0,
        },
        TestParams {
            name: "all_bvec2",
            expression: "all(bvec2(true, false))",
            in_type: DataType::Bool,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "all_bvec3",
            expression: "all(bvec3(true, false, false))",
            in_type: DataType::Bool,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "all_bvec4",
            expression: "all(bvec4(true, false, false, false))",
            in_type: DataType::Bool,
            min_components: 1,
            max_components: 1,
            out_type: DataType::Bool,
            output: 0.0,
        },
        TestParams {
            name: "not",
            expression: "not(${T} (false))",
            in_type: DataType::Bool,
            min_components: 2,
            max_components: 4,
            out_type: DataType::Bool,
            output: 1.0,
        },
    ]
}

/// `ShaderConstExprBuiltinTests::addChildGroup`
fn add_child_group(parent: &mut TestCaseGroup, name: &str, cases: &[TestParams], test_stage: u32) {
    let mut group = TestCaseGroup::new(name);
    for case in create_const_expr_tests(cases, GlslVersion::Es100, test_stage) {
        group.add_child(case);
    }
    parent.add_child(group);
}

/// `ShaderConstExprBuiltinTests::init`
fn create_builtin_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("builtin_functions");

    add_child_group(&mut group, "trigonometry", &trigonometry_cases(), SHADER_BOTH);
    add_child_group(&mut group, "exponential", &exponential_cases(), SHADER_BOTH);
    add_child_group(&mut group, "common", &common_cases(), SHADER_BOTH);
    add_child_group(&mut group, "geometric", &geometric_cases(), SHADER_BOTH);
    add_child_group(&mut group, "matrix", &matrix_cases(), SHADER_BOTH);
    add_child_group(&mut group, "vector_relational", &vector_relational_cases(), SHADER_BOTH);

    group
}

/// `ShaderConstExprTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("constant_expressions");
    add_group_children(&mut group, &lib::gles2_constant_expressions::ROOT);
    group.add_child(create_group("invalid", &lib::gles2_invalid_constant_expressions::ROOT));
    group.add_child(create_builtin_tests());

    group
}
