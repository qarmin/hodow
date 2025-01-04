// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fUniformBlockTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. As in the ES 3.0 copy of this file,
// each `UniformBlockCase` subclass becomes a function building the same
// `ShaderInterface`; the case itself is `gls::UniformBlockCase`. What ES 3.1 adds over
// ES 3.0 is arrays of arrays, which is why every group here is a nesting depth.

use crate::gles3::functional::uniform_block_tests::create_random_case_group;
use crate::gls::random_uniform_block_case::{
    FEATURE_ARRAYS, FEATURE_ARRAYS_OF_ARRAYS, FEATURE_FRAGMENT_BLOCKS, FEATURE_MATRICES, FEATURE_MATRIX_LAYOUT,
    FEATURE_PACKED_LAYOUT, FEATURE_SHARED_BLOCKS, FEATURE_SHARED_LAYOUT, FEATURE_STD140_LAYOUT, FEATURE_UNUSED_MEMBERS,
    FEATURE_UNUSED_UNIFORMS, FEATURE_VECTORS, FEATURE_VERTEX_BLOCKS,
};
use crate::gls::uniform_block_case::{
    BufferMode, DECLARE_FRAGMENT, DECLARE_VERTEX, LAYOUT_COLUMN_MAJOR, LAYOUT_PACKED, LAYOUT_ROW_MAJOR, LAYOUT_SHARED,
    LAYOUT_STD140, PRECISION_HIGH, PRECISION_LOW, PRECISION_MEDIUM, ShaderInterface, StructType, UNUSED_BOTH, Uniform,
    UniformBlock, UniformBlockCase, VarType,
};
use crate::glu::shader_util::DataType;
use crate::glu::{GlslVersion, TestCase, TestCaseGroup};

const GLSL: GlslVersion = GlslVersion::Es310;

/// `basicTypes[]` - the same 25 as the ES 3.0 copy.
const BASIC_TYPES: [DataType; 25] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
    DataType::Int,
    DataType::IntVec2,
    DataType::IntVec3,
    DataType::IntVec4,
    DataType::Uint,
    DataType::UintVec2,
    DataType::UintVec3,
    DataType::UintVec4,
    DataType::Bool,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
    DataType::FloatMat2,
    DataType::FloatMat3,
    DataType::FloatMat4,
    DataType::FloatMat2x3,
    DataType::FloatMat2x4,
    DataType::FloatMat3x2,
    DataType::FloatMat3x4,
    DataType::FloatMat4x2,
    DataType::FloatMat4x3,
];

const LAYOUT_FLAGS: [(&str, u32); 3] = [
    ("shared", LAYOUT_SHARED),
    ("packed", LAYOUT_PACKED),
    ("std140", LAYOUT_STD140),
];
const MATRIX_FLAGS: [(&str, u32); 2] = [("row_major", LAYOUT_ROW_MAJOR), ("column_major", LAYOUT_COLUMN_MAJOR)];
const BUFFER_MODES: [(&str, BufferMode); 2] = [
    ("per_block_buffer", BufferMode::PerBlock),
    ("single_buffer", BufferMode::Single),
];

/// `BlockBasicTypeCase::BlockBasicTypeCase`
fn basic_type_interface(ty: VarType, layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();
    let mut block = UniformBlock::new("Block");
    block.add_uniform(Uniform::new("var", ty, 0));
    block.flags = layout_flags;

    if num_instances > 0 {
        block.array_size = num_instances;
        block.instance_name = Some("block".to_string());
    }

    interface.add_block(block);
    interface
}

/// `Block2LevelStructArrayCase::init`
fn two_level_struct_array_interface(layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();

    let mut type_s = StructType::new("S");
    type_s.add_member("a", VarType::basic(DataType::UintVec3, PRECISION_HIGH), UNUSED_BOTH);
    type_s.add_member(
        "b",
        VarType::array(VarType::basic(DataType::FloatMat2, PRECISION_MEDIUM), 4),
        0,
    );
    type_s.add_member("c", VarType::basic(DataType::Uint, PRECISION_LOW), 0);
    let type_s = interface.add_struct(type_s);

    let mut block = UniformBlock::new("Block");
    block.add_uniform(Uniform::new("u", VarType::basic(DataType::Int, PRECISION_MEDIUM), 0));
    block.add_uniform(Uniform::new(
        "s",
        VarType::array(VarType::array(VarType::structure(&type_s, 0), 3), 2),
        0,
    ));
    block.add_uniform(Uniform::new(
        "v",
        VarType::basic(DataType::FloatVec2, PRECISION_MEDIUM),
        0,
    ));
    block.flags = layout_flags;

    if num_instances > 0 {
        block.instance_name = Some("block".to_string());
        block.array_size = num_instances;
    }

    interface.add_block(block);
    interface
}

fn add_case(group: &mut TestCaseGroup, name: String, interface: ShaderInterface, buffer_mode: BufferMode) {
    group.add_child(Box::new(UniformBlockCase {
        name,
        glsl_version: GLSL,
        buffer_mode,
        interface,
    }) as Box<dyn TestCase>);
}

/// `createBlockBasicTypeCases`
fn create_block_basic_type_cases(group: &mut TestCaseGroup, name: &str, ty: &VarType, layout_flags: u32) {
    add_case(
        group,
        format!("{name}_vertex"),
        basic_type_interface(ty.clone(), layout_flags | DECLARE_VERTEX, 0),
        BufferMode::PerBlock,
    );
    add_case(
        group,
        format!("{name}_fragment"),
        basic_type_interface(ty.clone(), layout_flags | DECLARE_FRAGMENT, 0),
        BufferMode::PerBlock,
    );

    if layout_flags & LAYOUT_PACKED == 0 {
        add_case(
            group,
            format!("{name}_both"),
            basic_type_interface(ty.clone(), layout_flags | DECLARE_VERTEX | DECLARE_FRAGMENT, 0),
            BufferMode::PerBlock,
        );
    }
}

/// The `2_level_array`/`3_level_array` groups; `nesting` is how many array levels wrap
/// the basic type, and the sizes upstream picks per level.
fn add_nested_array_group(parent: &mut TestCaseGroup, name: &str, sizes: &[i32]) {
    let mut nested_array_group = TestCaseGroup::new(name);

    for (layout_name, layout_flag) in LAYOUT_FLAGS {
        let mut layout_group = TestCaseGroup::new(layout_name);

        for ty in BASIC_TYPES {
            let type_name = ty.name();
            let mut parent_type = VarType::basic(ty, if ty.is_bool_or_bvec() { 0 } else { PRECISION_HIGH });
            for size in sizes {
                parent_type = VarType::array(parent_type, *size);
            }

            create_block_basic_type_cases(&mut layout_group, type_name, &parent_type, layout_flag);

            if ty.is_matrix() {
                for (mat_name, mat_flag) in MATRIX_FLAGS {
                    create_block_basic_type_cases(
                        &mut layout_group,
                        &format!("{mat_name}_{type_name}"),
                        &parent_type,
                        layout_flag | mat_flag,
                    );
                }
            }
        }

        nested_array_group.add_child(layout_group);
    }

    parent.add_child(nested_array_group);
}

/// `UniformBlockTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ubo");

    // ubo.2_level_array - child size 4, parent size 3.
    add_nested_array_group(&mut group, "2_level_array", &[4, 3]);

    // ubo.3_level_array - child sizes 2 and 4, parent size 3.
    add_nested_array_group(&mut group, "3_level_array", &[2, 4, 3]);

    // ubo.2_level_struct_array
    {
        let mut struct_array_array_group = TestCaseGroup::new("2_level_struct_array");

        for (mode_name, buffer_mode) in BUFFER_MODES {
            let mut mode_group = TestCaseGroup::new(mode_name);

            for (layout_name, base_flags) in LAYOUT_FLAGS {
                for is_array in 0..2 {
                    if buffer_mode == BufferMode::Single && is_array == 0 {
                        continue; // Doesn't make sense to add this variant.
                    }

                    let base_name = if is_array == 1 {
                        format!("{layout_name}_instance_array")
                    } else {
                        layout_name.to_string()
                    };
                    let num_instances = if is_array == 1 { 3 } else { 0 };

                    add_case(
                        &mut mode_group,
                        format!("{base_name}_vertex"),
                        two_level_struct_array_interface(base_flags | DECLARE_VERTEX, num_instances),
                        buffer_mode,
                    );
                    add_case(
                        &mut mode_group,
                        format!("{base_name}_fragment"),
                        two_level_struct_array_interface(base_flags | DECLARE_FRAGMENT, num_instances),
                        buffer_mode,
                    );

                    if base_flags & LAYOUT_PACKED == 0 {
                        add_case(
                            &mut mode_group,
                            format!("{base_name}_both"),
                            two_level_struct_array_interface(
                                base_flags | DECLARE_VERTEX | DECLARE_FRAGMENT,
                                num_instances,
                            ),
                            buffer_mode,
                        );
                    }
                }
            }

            struct_array_array_group.add_child(mode_group);
        }

        group.add_child(struct_array_array_group);
    }

    // ubo.random
    {
        const ALL_SHADERS: u32 = FEATURE_VERTEX_BLOCKS | FEATURE_FRAGMENT_BLOCKS | FEATURE_SHARED_BLOCKS;
        const ALL_LAYOUTS: u32 = FEATURE_PACKED_LAYOUT | FEATURE_SHARED_LAYOUT | FEATURE_STD140_LAYOUT;
        const ALL_BASIC_TYPES: u32 = FEATURE_VECTORS | FEATURE_MATRICES;
        const UNUSED: u32 = FEATURE_UNUSED_MEMBERS | FEATURE_UNUSED_UNIFORMS;
        const MAT_FLAGS: u32 = FEATURE_MATRIX_LAYOUT;
        const BASIC_TYPE_ARRAYS: u32 = ALL_SHADERS
            | ALL_LAYOUTS
            | UNUSED
            | ALL_BASIC_TYPES
            | MAT_FLAGS
            | FEATURE_ARRAYS
            | FEATURE_ARRAYS_OF_ARRAYS;
        const ALL_FEATURES: u32 = u32::MAX;

        let mut random_group = TestCaseGroup::new("random");

        create_random_case_group(
            &mut random_group,
            "basic_type_arrays",
            GLSL,
            BufferMode::PerBlock,
            BASIC_TYPE_ARRAYS,
            25,
            1150,
        );
        create_random_case_group(
            &mut random_group,
            "all_per_block_buffers",
            GLSL,
            BufferMode::PerBlock,
            ALL_FEATURES,
            50,
            11200,
        );
        create_random_case_group(
            &mut random_group,
            "all_shared_buffer",
            GLSL,
            BufferMode::Single,
            ALL_FEATURES,
            50,
            11250,
        );

        group.add_child(random_group);
    }

    group
}
