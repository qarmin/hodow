// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fVertexArrayTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `multiple_attributes` half is shared with
// the ES 2.0 file and lives in `gls::vertex_array_tests::test_groups`.

use crate::gls::vertex_array_tests::array::{InputType, OutputType, Storage, Usage};
use crate::gls::vertex_array_tests::test_groups::{array_spec, multiple_attributes_group, single_array_spec};
use crate::gls::vertex_array_tests::vertex_array_test::MultiVertexArrayTest;
use crate::glu::TestCaseGroup;

fn is_packed(type_: InputType) -> bool {
    matches!(type_, InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10)
}

/// `alignment` as every ES 3.0 group computes it.
fn alignment(type_: InputType, component_count: i32) -> i32 {
    if is_packed(type_) {
        type_.size() * component_count
    } else {
        type_.size()
    }
}

/// `SingleVertexArrayUsageGroup`
fn usage_group(usage: Usage) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(usage.to_str());

    let counts = [1, 256];
    // Treat negative value as sizeof input. Same as 0, but done outside of GL.
    let strides = [0, -1, 17, 32];
    let input_types = [InputType::Float, InputType::Fixed, InputType::Short, InputType::Byte];

    for input_type in input_types {
        for count in counts {
            for stride_value in strides {
                let stride = if stride_value < 0 {
                    input_type.size() * 2
                } else {
                    stride_value
                };
                let aligned = stride % input_type.size() == 0;
                let name = format!("stride{}_{}_quads{}", stride, input_type.to_str(), count);

                let array = array_spec(
                    input_type,
                    OutputType::Vec2,
                    Storage::Buffer,
                    usage,
                    2,
                    0,
                    stride,
                    false,
                );
                let spec = single_array_spec(count, 0, array);
                if aligned {
                    group.add_child(MultiVertexArrayTest::new(spec, &name));
                }
            }
        }
    }

    group
}

/// `SingleVertexArrayUsageTests`
fn usage_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("usages");

    // Test usage
    let usages = [
        Usage::StaticDraw,
        Usage::StreamDraw,
        Usage::DynamicDraw,
        Usage::StaticCopy,
        Usage::StreamCopy,
        Usage::DynamicCopy,
        Usage::StaticRead,
        Usage::StreamRead,
        Usage::DynamicRead,
    ];
    for usage in usages {
        group.add_child(usage_group(usage));
    }

    group
}

/// `SingleVertexArrayStrideGroup`
fn stride_group(type_: InputType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(type_.to_str());

    let storages = [Storage::User, Storage::Buffer];
    let counts = [1, 256];
    // Treat negative value as sizeof input. Same as 0, but done outside of GL.
    let strides = [-1, 17, 32];

    for storage in storages {
        for component_count in 2..5 {
            for count in counts {
                for stride_value in strides {
                    let packed = is_packed(type_);
                    let stride = if stride_value < 0 {
                        if packed { 16 } else { type_.size() * component_count }
                    } else {
                        stride_value
                    };
                    let alignment = alignment(type_, component_count);
                    let buffer_unaligned = storage == Storage::Buffer && (stride % alignment) != 0;

                    let name = format!(
                        "{}_stride{}_components{}_quads{}",
                        storage.to_str(),
                        stride,
                        component_count,
                        count
                    );

                    if packed && component_count != 4 {
                        continue;
                    }

                    let array = array_spec(
                        type_,
                        OutputType::Vec4,
                        storage,
                        Usage::DynamicDraw,
                        component_count,
                        0,
                        stride,
                        false,
                    );
                    let spec = single_array_spec(count, 0, array);
                    if !buffer_unaligned {
                        group.add_child(MultiVertexArrayTest::new(spec, &name));
                    }
                }
            }
        }
    }

    group
}

/// `SingleVertexArrayStrideTests`
fn stride_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("strides");

    let input_types = [
        InputType::Float,
        InputType::Short,
        InputType::Byte,
        /*InputType::UnsignedShort, InputType::UnsignedByte,*/ InputType::Fixed,
        InputType::Int2_10_10_10,
    ];
    for input_type in input_types {
        group.add_child(stride_group(input_type));
    }

    group
}

/// `SingleVertexArrayFirstGroup`
fn first_group(type_: InputType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(type_.to_str());

    let counts = [5, 256];
    let firsts = [6, 24];
    let offsets = [1, 16, 17];
    // Treat negative value as sizeof input. Same as 0, but done outside of GL.
    let strides = [-1, 17, 32];

    for offset in offsets {
        for count in counts {
            for stride_value in strides {
                for first in firsts {
                    let packed = is_packed(type_);
                    let component_count = if packed { 4 } else { 2 };
                    let stride = if stride_value < 0 {
                        if packed { 8 } else { type_.size() * component_count }
                    } else {
                        stride_value
                    };
                    let alignment = alignment(type_, component_count);
                    let aligned = (stride % alignment) == 0 && (offset % alignment) == 0;
                    let name = format!("first{first}_offset{offset}_stride{stride}_quads{count}");

                    let array = array_spec(
                        type_,
                        OutputType::Vec2,
                        Storage::Buffer,
                        Usage::DynamicDraw,
                        component_count,
                        offset,
                        stride,
                        false,
                    );
                    let spec = single_array_spec(count, first, array);
                    if aligned {
                        group.add_child(MultiVertexArrayTest::new(spec, &name));
                    }
                }
            }
        }
    }

    group
}

/// `SingleVertexArrayFirstTests`
fn first_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("first");

    let input_types = [InputType::Float, InputType::Byte, InputType::Int2_10_10_10];
    for input_type in input_types {
        group.add_child(first_group(input_type));
    }

    group
}

/// `SingleVertexArrayOffsetGroup`
fn offset_group(type_: InputType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(type_.to_str());

    let counts = [1, 256];
    let offsets = [1, 4, 17, 32];
    // Treat negative value as sizeof input. Same as 0, but done outside of GL.
    let strides = [-1, 17, 32];

    for offset in offsets {
        for count in counts {
            for stride_value in strides {
                let packed = is_packed(type_);
                let component_count = if packed { 4 } else { 2 };
                let stride = if stride_value < 0 {
                    type_.size() * component_count
                } else {
                    stride_value
                };
                let alignment = alignment(type_, component_count);
                let aligned = (stride % alignment) == 0 && (offset % alignment) == 0;
                let name = format!("offset{offset}_stride{stride}_quads{count}");

                let array = array_spec(
                    type_,
                    OutputType::Vec2,
                    Storage::Buffer,
                    Usage::DynamicDraw,
                    component_count,
                    offset,
                    stride,
                    false,
                );
                let spec = single_array_spec(count, 0, array);
                if aligned {
                    group.add_child(MultiVertexArrayTest::new(spec, &name));
                }
            }
        }
    }

    group
}

/// `SingleVertexArrayOffsetTests`
fn offset_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("offset");

    let input_types = [InputType::Float, InputType::Byte, InputType::Int2_10_10_10];
    for input_type in input_types {
        group.add_child(offset_group(input_type));
    }

    group
}

/// `SingleVertexArrayNormalizeGroup`
fn normalize_group(type_: InputType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(type_.to_str());

    let counts = [1, 256];

    for component_count in 2..5 {
        for count in counts {
            if is_packed(type_) && component_count != 4 {
                continue;
            }

            let name = format!("components{component_count}_quads{count}");
            let array = array_spec(
                type_,
                OutputType::Vec4,
                Storage::User,
                Usage::DynamicDraw,
                component_count,
                0,
                0,
                true,
            );
            group.add_child(MultiVertexArrayTest::new(single_array_spec(count, 0, array), &name));
        }
    }

    group
}

const ALL_INPUT_TYPES: [InputType; 11] = [
    InputType::Float,
    InputType::Short,
    InputType::Byte,
    InputType::UnsignedShort,
    InputType::UnsignedByte,
    InputType::Fixed,
    InputType::UnsignedInt,
    InputType::Int,
    InputType::Half,
    InputType::UnsignedInt2_10_10_10,
    InputType::Int2_10_10_10,
];

/// `SingleVertexArrayNormalizeTests`
fn normalize_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("normalize");

    // Test normalization with different input types, component counts and storage
    for input_type in ALL_INPUT_TYPES {
        group.add_child(normalize_group(input_type));
    }

    group
}

/// `SingleVertexArrayOutputTypeGroup`
fn output_type_group(type_: InputType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(type_.to_str());

    let output_types = [
        OutputType::Vec2,
        OutputType::Vec3,
        OutputType::Vec4,
        OutputType::IVec2,
        OutputType::IVec3,
        OutputType::IVec4,
        OutputType::UVec2,
        OutputType::UVec3,
        OutputType::UVec4,
    ];
    let storages = [Storage::User];
    let counts = [1, 256];

    let input_is_signed_integer = matches!(type_, InputType::Int | InputType::Short | InputType::Byte);
    let input_is_unsigned_integer = matches!(
        type_,
        InputType::UnsignedInt | InputType::UnsignedShort | InputType::UnsignedByte
    );

    for output_type in output_types {
        for storage in storages {
            for component_count in 2..5 {
                for count in counts {
                    let name = format!("components{}_{}_quads{}", component_count, output_type.to_str(), count);

                    let output_is_signed_integer =
                        matches!(output_type, OutputType::IVec2 | OutputType::IVec3 | OutputType::IVec4);
                    let output_is_unsigned_integer =
                        matches!(output_type, OutputType::UVec2 | OutputType::UVec3 | OutputType::UVec4);
                    let output_is_integer_class = output_type as i32 >= OutputType::Int as i32;

                    // If input type is float type and output type is int type skip
                    if matches!(type_, InputType::Float | InputType::Half | InputType::Fixed) && output_is_integer_class
                    {
                        continue;
                    }

                    if is_packed(type_) && output_is_integer_class {
                        continue;
                    }

                    if is_packed(type_) && component_count != 4 {
                        continue;
                    }

                    // Loading signed data as unsigned causes undefined values and vice versa
                    if input_is_signed_integer && output_is_unsigned_integer {
                        continue;
                    }
                    if input_is_unsigned_integer && output_is_signed_integer {
                        continue;
                    }

                    let array = array_spec(
                        type_,
                        output_type,
                        storage,
                        Usage::DynamicDraw,
                        component_count,
                        0,
                        0,
                        false,
                    );
                    group.add_child(MultiVertexArrayTest::new(single_array_spec(count, 0, array), &name));
                }
            }
        }
    }

    group
}

/// `SingleVertexArrayOutputTypeTests`
fn output_type_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("output_types");

    // Test output types with different input types, component counts and storage, Usage?, Precision?, float?
    for input_type in ALL_INPUT_TYPES {
        group.add_child(output_type_group(input_type));
    }

    group
}

/// `SingleVertexArrayTestGroup`
fn single_attribute_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("single_attribute");
    group.add_child(stride_tests());
    group.add_child(normalize_tests());
    group.add_child(output_type_tests());
    group.add_child(usage_tests());
    group.add_child(offset_tests());
    group.add_child(first_tests());
    group
}

/// `VertexArrayTestGroup::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("vertex_arrays");
    group.add_child(single_attribute_group());
    group.add_child(multiple_attributes_group());
    group
}
