// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fDefaultVertexAttributeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case itself is in
// `gls::default_vertex_attribute_case`; this file is upstream's
// `DefaultVertexAttributeTests::init` and nothing else.

use crate::gls::default_vertex_attribute_case::{
    EsVersion, Loader, Target, add_float_target_group, add_integer_target_group,
};
use crate::glu::{DataType, TestCaseGroup};

/// `floatTargets`
const FLOAT_TARGETS: [Target; 13] = [
    Target {
        name: "float",
        data_type: DataType::Float,
        reduced_test_sets: false,
    },
    Target {
        name: "vec2",
        data_type: DataType::FloatVec2,
        reduced_test_sets: true,
    },
    Target {
        name: "vec3",
        data_type: DataType::FloatVec3,
        reduced_test_sets: true,
    },
    Target {
        name: "vec4",
        data_type: DataType::FloatVec4,
        reduced_test_sets: false,
    },
    Target {
        name: "mat2",
        data_type: DataType::FloatMat2,
        reduced_test_sets: true,
    },
    Target {
        name: "mat2x3",
        data_type: DataType::FloatMat2x3,
        reduced_test_sets: true,
    },
    Target {
        name: "mat2x4",
        data_type: DataType::FloatMat2x4,
        reduced_test_sets: true,
    },
    Target {
        name: "mat3",
        data_type: DataType::FloatMat3,
        reduced_test_sets: true,
    },
    Target {
        name: "mat3x2",
        data_type: DataType::FloatMat3x2,
        reduced_test_sets: true,
    },
    Target {
        name: "mat3x4",
        data_type: DataType::FloatMat3x4,
        reduced_test_sets: true,
    },
    Target {
        name: "mat4",
        data_type: DataType::FloatMat4,
        reduced_test_sets: false,
    },
    Target {
        name: "mat4x2",
        data_type: DataType::FloatMat4x2,
        reduced_test_sets: true,
    },
    Target {
        name: "mat4x3",
        data_type: DataType::FloatMat4x3,
        reduced_test_sets: true,
    },
];

/// `intTargets`
const INT_TARGETS: [Target; 4] = [
    Target {
        name: "int",
        data_type: DataType::Int,
        reduced_test_sets: false,
    },
    Target {
        name: "ivec2",
        data_type: DataType::IntVec2,
        reduced_test_sets: true,
    },
    Target {
        name: "ivec3",
        data_type: DataType::IntVec3,
        reduced_test_sets: true,
    },
    Target {
        name: "ivec4",
        data_type: DataType::IntVec4,
        reduced_test_sets: false,
    },
];

/// `uintTargets`
const UINT_TARGETS: [Target; 4] = [
    Target {
        name: "uint",
        data_type: DataType::Uint,
        reduced_test_sets: false,
    },
    Target {
        name: "uvec2",
        data_type: DataType::UintVec2,
        reduced_test_sets: true,
    },
    Target {
        name: "uvec3",
        data_type: DataType::UintVec3,
        reduced_test_sets: true,
    },
    Target {
        name: "uvec4",
        data_type: DataType::UintVec4,
        reduced_test_sets: false,
    },
];

/// `DefaultVertexAttributeTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut root = TestCaseGroup::new("default_vertex_attrib");

    for target in &FLOAT_TARGETS {
        add_float_target_group(&mut root, EsVersion::Es3, target);
    }

    for target in &INT_TARGETS {
        add_integer_target_group(&mut root, target, [Loader::IntDirect, Loader::IntIndirect]);
    }

    for target in &UINT_TARGETS {
        add_integer_target_group(&mut root, target, [Loader::UintDirect, Loader::UintIndirect]);
    }

    root
}
