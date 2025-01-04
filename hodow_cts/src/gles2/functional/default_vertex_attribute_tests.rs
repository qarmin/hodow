// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fDefaultVertexAttributeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case itself is in
// `gls::default_vertex_attribute_case`; this file is upstream's
// `DefaultVertexAttributeTests::init` and nothing else. ES 2.0 has no integer attribute,
// so only the float targets are registered.

use crate::gls::default_vertex_attribute_case::{EsVersion, Target, add_float_target_group};
use crate::glu::{DataType, TestCaseGroup};

/// `floatTargets`
const FLOAT_TARGETS: [Target; 7] = [
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
        name: "mat3",
        data_type: DataType::FloatMat3,
        reduced_test_sets: true,
    },
    Target {
        name: "mat4",
        data_type: DataType::FloatMat4,
        reduced_test_sets: false,
    },
];

/// `DefaultVertexAttributeTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut root = TestCaseGroup::new("default_vertex_attrib");

    for target in &FLOAT_TARGETS {
        add_float_target_group(&mut root, EsVersion::Es2, target);
    }

    root
}
