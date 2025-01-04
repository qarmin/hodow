// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fVertexArrayTest.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `multiple_attributes` half is shared with
// the ES 3.0 file and lives in `gls::vertex_array_tests::test_groups`. Unlike the ES 3.0 file,
// the `single_attribute` groups here are flat and name their cases through `Spec::get_name`.

use crate::gls::vertex_array_tests::array::{InputType, OutputType, Storage, Usage};
use crate::gls::vertex_array_tests::test_groups::{array_spec, multiple_attributes_group, single_array_spec};
use crate::gls::vertex_array_tests::vertex_array_test::MultiVertexArrayTest;
use crate::glu::TestCaseGroup;

/// `SingleVertexArrayUsageTests`
fn usage_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("usages");

    // Test usage
    let usages = [Usage::StaticDraw, Usage::StreamDraw, Usage::DynamicDraw];
    let counts = [1, 256];
    // Treat negative value as sizeof input. Same as 0, but done outside of GL.
    let strides = [0, -1, 17, 32];
    let input_types = [InputType::Float, InputType::Fixed, InputType::Short, InputType::Byte];

    for input_type in input_types {
        for count in counts {
            for stride_value in strides {
                for usage in usages {
                    let component_count = 2;
                    let stride = if stride_value < 0 {
                        input_type.size() * component_count
                    } else {
                        stride_value
                    };
                    let aligned = stride % input_type.size() == 0;

                    let array = array_spec(
                        input_type,
                        OutputType::Vec2,
                        Storage::Buffer,
                        usage,
                        component_count,
                        0,
                        stride,
                        false,
                    );
                    let spec = single_array_spec(count, 0, array);
                    let name = spec.get_name();

                    if aligned {
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

    // Test strides with different input types, component counts and storage, Usage(?)
    let input_types = [
        InputType::Float,
        InputType::Short,
        InputType::Byte,
        /*InputType::UnsignedShort, InputType::UnsignedByte,*/ InputType::Fixed,
    ];
    let storages = [Storage::User, Storage::Buffer];
    let counts = [1, 256];
    // Treat negative value as sizeof input. Same as 0, but done outside of GL.
    let strides = [-1, 17, 32];

    for input_type in input_types {
        for storage in storages {
            for component_count in 2..5 {
                for count in counts {
                    for stride_value in strides {
                        let stride = if stride_value < 0 {
                            input_type.size() * component_count
                        } else {
                            stride_value
                        };
                        let buffer_aligned = storage == Storage::Buffer && (stride % input_type.size()) == 0;

                        let array = array_spec(
                            input_type,
                            OutputType::Vec4,
                            storage,
                            Usage::DynamicDraw,
                            component_count,
                            0,
                            stride,
                            false,
                        );
                        let spec = single_array_spec(count, 0, array);
                        let name = spec.get_name();
                        if buffer_aligned {
                            group.add_child(MultiVertexArrayTest::new(spec, &name));
                        }
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

    // Test strides with different input types, component counts and storage, Usage(?)
    let input_types = [InputType::Float, InputType::Byte, InputType::Fixed];
    let counts = [5, 256];
    let firsts = [6, 24];
    let offsets = [1, 16, 17];
    // Treat negative value as sizeof input. Same as 0, but done outside of GL.
    let strides = [-1, 17, 32];

    for input_type in input_types {
        for offset in offsets {
            for count in counts {
                for stride_value in strides {
                    for first in firsts {
                        let stride = if stride_value < 0 {
                            input_type.size() * 2
                        } else {
                            stride_value
                        };
                        let aligned = (stride % input_type.size()) == 0 && (offset % input_type.size() == 0);

                        let array = array_spec(
                            input_type,
                            OutputType::Vec2,
                            Storage::Buffer,
                            Usage::DynamicDraw,
                            2,
                            offset,
                            stride,
                            false,
                        );
                        let spec = single_array_spec(count, first, array);

                        let name = format!(
                            "{}_first{}_offset{}_stride{}_quads{}",
                            input_type.to_str(),
                            first,
                            offset,
                            stride,
                            count
                        );
                        if aligned {
                            group.add_child(MultiVertexArrayTest::new(spec, &name));
                        }
                    }
                }
            }
        }
    }

    group
}

/// `SingleVertexArrayOffsetTests`
fn offset_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("offset");

    // Test strides with different input types, component counts and storage, Usage(?)
    let input_types = [InputType::Float, InputType::Byte, InputType::Fixed];
    let counts = [1, 256];
    let offsets = [1, 4, 17, 32];
    // Treat negative value as sizeof input. Same as 0, but done outside of GL.
    let strides = [-1, 17, 32];

    for input_type in input_types {
        for offset in offsets {
            for count in counts {
                for stride_value in strides {
                    let stride = if stride_value < 0 {
                        input_type.size() * 2
                    } else {
                        stride_value
                    };
                    let aligned = (stride % input_type.size()) == 0 && (offset % input_type.size()) == 0;

                    let array = array_spec(
                        input_type,
                        OutputType::Vec2,
                        Storage::Buffer,
                        Usage::DynamicDraw,
                        2,
                        offset,
                        stride,
                        false,
                    );
                    let spec = single_array_spec(count, 0, array);
                    let name = spec.get_name();
                    if aligned {
                        group.add_child(MultiVertexArrayTest::new(spec, &name));
                    }
                }
            }
        }
    }

    group
}

const SIX_INPUT_TYPES: [InputType; 6] = [
    InputType::Float,
    InputType::Short,
    InputType::Byte,
    InputType::UnsignedShort,
    InputType::UnsignedByte,
    InputType::Fixed,
];

/// `SingleVertexArrayNormalizeTests`
fn normalize_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("normalize");

    // Test normalization with different input types, component counts and storage
    let storages = [Storage::User];
    let counts = [1, 256];

    for input_type in SIX_INPUT_TYPES {
        for storage in storages {
            for component_count in 2..5 {
                for count in counts {
                    let array = array_spec(
                        input_type,
                        OutputType::Vec4,
                        storage,
                        Usage::DynamicDraw,
                        component_count,
                        0,
                        0,
                        true,
                    );
                    let spec = single_array_spec(count, 0, array);
                    let name = spec.get_name();
                    group.add_child(MultiVertexArrayTest::new(spec, &name));
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
    let output_types = [OutputType::Vec2, OutputType::Vec3, OutputType::Vec4];
    let storages = [Storage::User];
    let counts = [1, 256];

    for input_type in SIX_INPUT_TYPES {
        for output_type in output_types {
            for storage in storages {
                for component_count in 2..5 {
                    for count in counts {
                        let array = array_spec(
                            input_type,
                            output_type,
                            storage,
                            Usage::DynamicDraw,
                            component_count,
                            0,
                            0,
                            false,
                        );
                        let spec = single_array_spec(count, 0, array);
                        let name = spec.get_name();
                        group.add_child(MultiVertexArrayTest::new(spec, &name));
                    }
                }
            }
        }
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
