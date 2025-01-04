// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fVertexArrayTest.cpp
//   modules/gles3/functional/es3fVertexArrayTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The two upstream files differ in their `single_attribute` groups (ES 3.0 has more input
// types, usages and a per-input-type split) but their `multiple_attributes` half is
// identical, line for line, so it is built once here. The `single_attribute` halves live in
// `gles2::functional::vertex_array_test` and `gles3::functional::vertex_array_test`.

use super::array::{InputType, OutputType, Primitive, Storage, Usage};
use super::gl_value::{GLValue, Int};
use super::vertex_array_test::{ArraySpec, MultiVertexArrayTest, Spec};
use crate::glu::TestCaseGroup;

/// `GLValue::getMinValue`, with the two packed types - which upstream leaves as a default
/// constructed value nothing reads - mapped to a placeholder instead of a panic.
pub fn min_value(type_: InputType) -> GLValue {
    match type_ {
        InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10 => GLValue::Int(Int::create(0)),
        _ => GLValue::min_value(type_),
    }
}

/// `GLValue::getMaxValue`, see `min_value`.
pub fn max_value(type_: InputType) -> GLValue {
    match type_ {
        InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10 => GLValue::Int(Int::create(0)),
        _ => GLValue::max_value(type_),
    }
}

/// An `ArraySpec` whose min/max are the input type's own range, which is what every group
/// in both files passes.
#[allow(clippy::too_many_arguments)]
pub fn array_spec(
    input_type: InputType,
    output_type: OutputType,
    storage: Storage,
    usage: Usage,
    component_count: i32,
    offset: i32,
    stride: i32,
    normalize: bool,
) -> ArraySpec {
    ArraySpec::new(
        input_type,
        output_type,
        storage,
        usage,
        component_count,
        offset,
        stride,
        normalize,
        min_value(input_type),
        max_value(input_type),
    )
}

/// A one-array triangles `Spec`.
pub fn single_array_spec(draw_count: i32, first: i32, array: ArraySpec) -> Spec {
    let mut spec = Spec::new(Primitive::Triangles, draw_count, first);
    spec.arrays.push(array);
    spec
}

/// `MultiVertexArrayCountTests`
fn count_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("attribute_count");

    // Test attribute counts
    for array_count in [2, 3, 4, 5, 6, 7, 8] {
        let mut spec = Spec::new(Primitive::Triangles, 256, 0);

        for _ in 0..array_count {
            spec.arrays.push(array_spec(
                InputType::Float,
                OutputType::Vec2,
                Storage::User,
                Usage::DynamicDraw,
                2,
                0,
                0,
                false,
            ));
        }

        let name = spec.arrays.len().to_string();
        group.add_child(MultiVertexArrayTest::new(spec, &name));
    }

    group
}

/// `MultiVertexArrayStorageTests::addStorageCases`
fn add_storage_cases(group: &mut TestCaseGroup, spec: Spec, depth: i32) {
    if depth == 0 {
        // Skip trivial case, used elsewhere
        if !spec.arrays.iter().any(|array| array.storage != Storage::User) {
            return;
        }

        let mut name = spec.arrays.len().to_string();
        for array in &spec.arrays {
            name.push('_');
            name.push_str(array.storage.to_str());
        }
        group.add_child(MultiVertexArrayTest::new(spec, &name));
        return;
    }

    for storage in [Storage::User, Storage::Buffer] {
        let array = array_spec(
            InputType::Float,
            OutputType::Vec2,
            storage,
            Usage::DynamicDraw,
            2,
            0,
            0,
            false,
        );
        let mut next = spec.clone();
        next.arrays.push(array);
        add_storage_cases(group, next, depth - 1);
    }
}

/// `MultiVertexArrayStorageTests`
fn storage_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("storage");

    // Test different storages
    let spec = Spec::new(Primitive::Triangles, 256, 0);
    add_storage_cases(&mut group, spec, 3);

    group
}

/// `MultiVertexArrayStrideTests::addStrideCases`
fn add_stride_cases(group: &mut TestCaseGroup, spec: Spec, depth: i32) {
    if depth == 0 {
        let mut name = spec.arrays.len().to_string();
        for array in &spec.arrays {
            name.push_str(&format!(
                "_{}{}_{}",
                array.input_type.to_str(),
                array.component_count,
                array.stride
            ));
        }
        group.add_child(MultiVertexArrayTest::new(spec, &name));
        return;
    }

    for stride in [0, -1, 17, 32] {
        let component_count = 2;
        let stride = if stride >= 0 {
            stride
        } else {
            component_count * InputType::Float.size()
        };
        let array = array_spec(
            InputType::Float,
            OutputType::Vec2,
            Storage::User,
            Usage::DynamicDraw,
            component_count,
            0,
            stride,
            false,
        );
        let mut next = spec.clone();
        next.arrays.push(array);
        add_stride_cases(group, next, depth - 1);
    }
}

/// `MultiVertexArrayStrideTests`
fn stride_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("stride");

    // Test different strides, with multiple arrays, input types??
    let spec = Spec::new(Primitive::Triangles, 256, 0);
    add_stride_cases(&mut group, spec, 3);

    group
}

/// `MultiVertexArrayOutputTests::addInputTypeCases`
fn add_input_type_cases(group: &mut TestCaseGroup, spec: Spec, depth: i32) {
    if depth == 0 {
        let mut name = spec.arrays.len().to_string();
        for array in &spec.arrays {
            name.push_str(&format!(
                "_{}{}_{}",
                array.input_type.to_str(),
                array.component_count,
                array.output_type.to_str()
            ));
        }
        group.add_child(MultiVertexArrayTest::new(spec, &name));
        return;
    }

    let input_types = [
        InputType::Fixed,
        InputType::Byte,
        InputType::Short,
        InputType::UnsignedByte,
        InputType::UnsignedShort,
    ];
    for input_type in input_types {
        let array = array_spec(
            input_type,
            OutputType::Vec2,
            Storage::User,
            Usage::DynamicDraw,
            2,
            0,
            0,
            false,
        );
        let mut next = spec.clone();
        next.arrays.push(array);
        add_input_type_cases(group, next, depth - 1);
    }
}

/// `MultiVertexArrayOutputTests`
fn output_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("input_types");

    // Test different input types, with multiple arrays
    let spec = Spec::new(Primitive::Triangles, 256, 0);
    add_input_type_cases(&mut group, spec, 3);

    group
}

/// `MultiVertexArrayTestGroup`
pub fn multiple_attributes_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("multiple_attributes");
    group.add_child(count_tests());
    group.add_child(storage_tests());
    group.add_child(stride_tests());
    group.add_child(output_tests());
    group
}
