// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fUniformBlockTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2012 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's seven `UniformBlockCase`
// subclasses each exist only to fill `m_interface` in `init`; a `TestCase` here is
// immutable, so each becomes a function that builds the same `ShaderInterface` at
// registration time and the case itself is always `gls::UniformBlockCase`.

use crate::gls::random_uniform_block_case::{
    FEATURE_ARRAYS, FEATURE_ARRAYS_OF_ARRAYS, FEATURE_FRAGMENT_BLOCKS, FEATURE_INSTANCE_ARRAYS, FEATURE_MATRICES,
    FEATURE_MATRIX_LAYOUT, FEATURE_PACKED_LAYOUT, FEATURE_SHARED_BLOCKS, FEATURE_SHARED_LAYOUT, FEATURE_STD140_LAYOUT,
    FEATURE_STRUCTS, FEATURE_UNUSED_MEMBERS, FEATURE_UNUSED_UNIFORMS, FEATURE_VECTORS, FEATURE_VERTEX_BLOCKS,
    generate_interface,
};
use crate::gls::uniform_block_case::{
    BufferMode, DECLARE_FRAGMENT, DECLARE_VERTEX, LAYOUT_COLUMN_MAJOR, LAYOUT_PACKED, LAYOUT_ROW_MAJOR, LAYOUT_SHARED,
    LAYOUT_STD140, PRECISION_HIGH, PRECISION_LOW, PRECISION_MEDIUM, ShaderInterface, StructType, UNUSED_BOTH, Uniform,
    UniformBlock, UniformBlockCase, VarType,
};
use crate::glu::shader_util::DataType;
use crate::glu::{GlslVersion, TestCase, TestCaseGroup};

const GLSL: GlslVersion = GlslVersion::Es300;

/// `basicTypes[]`
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

const PRECISION_FLAGS: [(&str, u32); 3] = [
    ("lowp", PRECISION_LOW),
    ("mediump", PRECISION_MEDIUM),
    ("highp", PRECISION_HIGH),
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

/// Which upstream `UniformBlockCase` subclass builds the interface.
#[derive(Clone, Copy)]
enum InterfaceKind {
    /// `BlockBasicTypeCase`
    BasicType(VarTypeSpec),
    /// `BlockSingleStructCase`
    SingleStruct,
    /// `BlockSingleStructArrayCase`
    SingleStructArray,
    /// `BlockSingleNestedStructCase`
    SingleNestedStruct,
    /// `BlockSingleNestedStructMixedMatrixPackingCase` (matrix flags, matrix-array flags)
    SingleNestedStructMixedMatrixPacking(u32, u32),
    /// `BlockSingleNestedStructArrayCase`
    SingleNestedStructArray,
    /// `BlockMultiBasicTypesCase` (flags A, flags B)
    MultiBasicTypes(u32, u32),
    /// `BlockMultiNestedStructCase` (flags A, flags B)
    MultiNestedStruct(u32, u32),
}

/// The `VarType` a `BlockBasicTypeCase` declares, as the two shapes the registration
/// actually uses (a basic type, optionally wrapped in one array level).
#[derive(Clone, Copy)]
struct VarTypeSpec {
    basic_type: DataType,
    flags: u32,
    /// 0 means "not an array".
    array_size: i32,
}

impl VarTypeSpec {
    fn build(self) -> VarType {
        let basic = VarType::basic(self.basic_type, self.flags);
        if self.array_size > 0 {
            VarType::array(basic, self.array_size)
        } else {
            basic
        }
    }
}

/// The `S` struct three of the cases declare identically.
fn struct_s(interface: &mut ShaderInterface, b_type: DataType, a_unused: bool, c_unused: bool) -> VarType {
    let mut type_s = StructType::new("S");
    type_s.add_member(
        "a",
        VarType::basic(DataType::IntVec3, PRECISION_HIGH),
        if a_unused { UNUSED_BOTH } else { 0 },
    );
    type_s.add_member("b", VarType::array(VarType::basic(b_type, PRECISION_MEDIUM), 4), 0);
    type_s.add_member(
        "c",
        VarType::basic(DataType::FloatVec4, PRECISION_HIGH),
        if c_unused { UNUSED_BOTH } else { 0 },
    );
    VarType::structure(&interface.add_struct(type_s), 0)
}

/// Each subclass's `init`.
fn build_interface(kind: InterfaceKind, layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();

    let finish = |interface: &mut ShaderInterface, mut block: UniformBlock, flags: u32| {
        block.flags = flags;
        if num_instances > 0 {
            block.array_size = num_instances;
            block.instance_name = Some("block".to_string());
        }
        interface.add_block(block);
    };

    match kind {
        InterfaceKind::BasicType(spec) => {
            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new("var", spec.build(), 0));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::SingleStruct => {
            let type_s = struct_s(&mut interface, DataType::FloatMat3, true, false);
            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new("s", type_s, 0));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::SingleStructArray => {
            let type_s = struct_s(&mut interface, DataType::FloatMat3, true, false);
            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new("u", VarType::basic(DataType::Uint, PRECISION_LOW), 0));
            block.add_uniform(Uniform::new("s", VarType::array(type_s, 3), 0));
            block.add_uniform(Uniform::new(
                "v",
                VarType::basic(DataType::FloatVec4, PRECISION_MEDIUM),
                0,
            ));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::SingleNestedStruct | InterfaceKind::SingleNestedStructMixedMatrixPacking(..) => {
            let (matrix_flags, matrix_array_flags) = match kind {
                InterfaceKind::SingleNestedStructMixedMatrixPacking(m, a) => (m, a),
                _ => (0, 0),
            };

            let type_s = struct_s(&mut interface, DataType::FloatMat3, false, true);

            let mut type_t = StructType::new("T");
            type_t.add_member("a", VarType::basic(DataType::FloatMat3, PRECISION_MEDIUM), 0);
            type_t.add_member("b", type_s.clone(), 0);
            let type_t = interface.add_struct(type_t);

            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new(
                "s",
                VarType::structure(type_s.struct_type(), matrix_array_flags),
                0,
            ));
            block.add_uniform(Uniform::new(
                "v",
                VarType::basic(DataType::FloatVec2, PRECISION_LOW),
                UNUSED_BOTH,
            ));
            block.add_uniform(Uniform::new("t", VarType::structure(&type_t, matrix_flags), 0));
            block.add_uniform(Uniform::new("u", VarType::basic(DataType::Uint, PRECISION_HIGH), 0));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::SingleNestedStructArray => {
            let type_s = struct_s(&mut interface, DataType::IntVec2, false, true);

            let mut type_t = StructType::new("T");
            type_t.add_member("a", VarType::basic(DataType::FloatMat3, PRECISION_MEDIUM), 0);
            type_t.add_member("b", VarType::array(type_s.clone(), 3), 0);
            let type_t = interface.add_struct(type_t);

            let mut block = UniformBlock::new("Block");
            block.add_uniform(Uniform::new("s", type_s, 0));
            block.add_uniform(Uniform::new(
                "v",
                VarType::basic(DataType::FloatVec2, PRECISION_LOW),
                UNUSED_BOTH,
            ));
            block.add_uniform(Uniform::new("t", VarType::array(VarType::structure(&type_t, 0), 2), 0));
            block.add_uniform(Uniform::new("u", VarType::basic(DataType::Uint, PRECISION_HIGH), 0));
            finish(&mut interface, block, layout_flags);
        }
        InterfaceKind::MultiBasicTypes(flags_a, flags_b) => {
            let mut block_a = UniformBlock::new("BlockA");
            block_a.add_uniform(Uniform::new("a", VarType::basic(DataType::Float, PRECISION_HIGH), 0));
            block_a.add_uniform(Uniform::new(
                "b",
                VarType::basic(DataType::UintVec3, PRECISION_LOW),
                UNUSED_BOTH,
            ));
            block_a.add_uniform(Uniform::new(
                "c",
                VarType::basic(DataType::FloatMat2, PRECISION_MEDIUM),
                0,
            ));
            block_a.instance_name = Some("blockA".to_string());
            block_a.flags = flags_a;

            let mut block_b = UniformBlock::new("BlockB");
            block_b.add_uniform(Uniform::new(
                "a",
                VarType::basic(DataType::FloatMat3, PRECISION_MEDIUM),
                0,
            ));
            block_b.add_uniform(Uniform::new("b", VarType::basic(DataType::IntVec2, PRECISION_LOW), 0));
            block_b.add_uniform(Uniform::new(
                "c",
                VarType::basic(DataType::FloatVec4, PRECISION_HIGH),
                UNUSED_BOTH,
            ));
            block_b.add_uniform(Uniform::new("d", VarType::basic(DataType::Bool, 0), 0));
            block_b.instance_name = Some("blockB".to_string());
            block_b.flags = flags_b;

            if num_instances > 0 {
                block_a.array_size = num_instances;
                block_b.array_size = num_instances;
            }

            interface.add_block(block_a);
            interface.add_block(block_b);
        }
        InterfaceKind::MultiNestedStruct(flags_a, flags_b) => {
            let mut type_s = StructType::new("S");
            type_s.add_member("a", VarType::basic(DataType::FloatMat3, PRECISION_LOW), 0);
            type_s.add_member(
                "b",
                VarType::array(VarType::basic(DataType::IntVec2, PRECISION_MEDIUM), 4),
                0,
            );
            type_s.add_member("c", VarType::basic(DataType::FloatVec4, PRECISION_HIGH), 0);
            let type_s = interface.add_struct(type_s);

            let mut type_t = StructType::new("T");
            type_t.add_member("a", VarType::basic(DataType::Uint, PRECISION_MEDIUM), UNUSED_BOTH);
            type_t.add_member("b", VarType::structure(&type_s, 0), 0);
            type_t.add_member("c", VarType::basic(DataType::BoolVec4, 0), 0);
            let type_t = interface.add_struct(type_t);

            let mut block_a = UniformBlock::new("BlockA");
            block_a.add_uniform(Uniform::new("a", VarType::basic(DataType::Float, PRECISION_HIGH), 0));
            block_a.add_uniform(Uniform::new("b", VarType::structure(&type_s, 0), 0));
            block_a.add_uniform(Uniform::new(
                "c",
                VarType::basic(DataType::UintVec3, PRECISION_LOW),
                UNUSED_BOTH,
            ));
            block_a.instance_name = Some("blockA".to_string());
            block_a.flags = flags_a;

            let mut block_b = UniformBlock::new("BlockB");
            block_b.add_uniform(Uniform::new(
                "a",
                VarType::basic(DataType::FloatMat2, PRECISION_MEDIUM),
                0,
            ));
            block_b.add_uniform(Uniform::new("b", VarType::structure(&type_t, 0), 0));
            block_b.add_uniform(Uniform::new("c", VarType::basic(DataType::BoolVec4, 0), UNUSED_BOTH));
            block_b.add_uniform(Uniform::new("d", VarType::basic(DataType::Bool, 0), 0));
            block_b.instance_name = Some("blockB".to_string());
            block_b.flags = flags_b;

            if num_instances > 0 {
                block_a.array_size = num_instances;
                block_b.array_size = num_instances;
            }

            interface.add_block(block_a);
            interface.add_block(block_b);
        }
    }

    interface
}

fn add_case(
    group: &mut TestCaseGroup,
    name: String,
    kind: InterfaceKind,
    layout_flags: u32,
    buffer_mode: BufferMode,
    num_instances: i32,
) {
    group.add_child(Box::new(UniformBlockCase {
        interface: build_interface(kind, layout_flags, num_instances),
        name,
        glsl_version: GLSL,
        buffer_mode,
    }) as Box<dyn TestCase>);
}

/// `createBlockBasicTypeCases`
fn create_block_basic_type_cases(
    group: &mut TestCaseGroup,
    name: &str,
    spec: VarTypeSpec,
    layout_flags: u32,
    num_instances: i32,
) {
    let kind = InterfaceKind::BasicType(spec);

    add_case(
        group,
        format!("{name}_vertex"),
        kind,
        layout_flags | DECLARE_VERTEX,
        BufferMode::PerBlock,
        num_instances,
    );
    add_case(
        group,
        format!("{name}_fragment"),
        kind,
        layout_flags | DECLARE_FRAGMENT,
        BufferMode::PerBlock,
        num_instances,
    );

    if layout_flags & LAYOUT_PACKED == 0 {
        add_case(
            group,
            format!("{name}_both"),
            kind,
            layout_flags | DECLARE_VERTEX | DECLARE_FRAGMENT,
            BufferMode::PerBlock,
            num_instances,
        );
    }
}

/// The `single_struct`/`single_struct_array`/`single_nested_struct`/
/// `single_nested_struct_array` groups, which differ only in which interface they build.
fn add_struct_group(parent: &mut TestCaseGroup, name: &str, kind: InterfaceKind) {
    let mut group = TestCaseGroup::new(name);

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
                    kind,
                    base_flags | DECLARE_VERTEX,
                    buffer_mode,
                    num_instances,
                );
                add_case(
                    &mut mode_group,
                    format!("{base_name}_fragment"),
                    kind,
                    base_flags | DECLARE_FRAGMENT,
                    buffer_mode,
                    num_instances,
                );

                if base_flags & LAYOUT_PACKED == 0 {
                    add_case(
                        &mut mode_group,
                        format!("{base_name}_both"),
                        kind,
                        base_flags | DECLARE_VERTEX | DECLARE_FRAGMENT,
                        buffer_mode,
                        num_instances,
                    );
                }
            }
        }

        group.add_child(mode_group);
    }

    parent.add_child(group);
}

/// The `multi_basic_types`/`multi_nested_struct` groups, which additionally have a
/// `_mixed` variant and no single-buffer restriction.
fn add_multi_group(parent: &mut TestCaseGroup, name: &str, make_kind: fn(u32, u32) -> InterfaceKind) {
    let mut group = TestCaseGroup::new(name);

    for (mode_name, buffer_mode) in BUFFER_MODES {
        let mut mode_group = TestCaseGroup::new(mode_name);

        for (layout_name, base_flags) in LAYOUT_FLAGS {
            for is_array in 0..2 {
                let base_name = if is_array == 1 {
                    format!("{layout_name}_instance_array")
                } else {
                    layout_name.to_string()
                };
                let num_instances = if is_array == 1 { 3 } else { 0 };

                add_case(
                    &mut mode_group,
                    format!("{base_name}_vertex"),
                    make_kind(base_flags | DECLARE_VERTEX, base_flags | DECLARE_VERTEX),
                    0,
                    buffer_mode,
                    num_instances,
                );
                add_case(
                    &mut mode_group,
                    format!("{base_name}_fragment"),
                    make_kind(base_flags | DECLARE_FRAGMENT, base_flags | DECLARE_FRAGMENT),
                    0,
                    buffer_mode,
                    num_instances,
                );

                if base_flags & LAYOUT_PACKED == 0 {
                    add_case(
                        &mut mode_group,
                        format!("{base_name}_both"),
                        make_kind(
                            base_flags | DECLARE_VERTEX | DECLARE_FRAGMENT,
                            base_flags | DECLARE_VERTEX | DECLARE_FRAGMENT,
                        ),
                        0,
                        buffer_mode,
                        num_instances,
                    );
                }

                add_case(
                    &mut mode_group,
                    format!("{base_name}_mixed"),
                    make_kind(base_flags | DECLARE_VERTEX, base_flags | DECLARE_FRAGMENT),
                    0,
                    buffer_mode,
                    num_instances,
                );
            }
        }

        group.add_child(mode_group);
    }

    parent.add_child(group);
}

/// `createRandomCaseGroup`
pub fn create_random_case_group(
    parent: &mut TestCaseGroup,
    group_name: &str,
    glsl_version: GlslVersion,
    buffer_mode: BufferMode,
    features: u32,
    num_cases: u32,
    base_seed: u32,
) {
    let mut group = TestCaseGroup::new(group_name);

    for ndx in 0..num_cases {
        group.add_child(Box::new(UniformBlockCase {
            name: ndx.to_string(),
            glsl_version,
            buffer_mode,
            interface: generate_interface(features, ndx + base_seed),
        }) as Box<dyn TestCase>);
    }

    parent.add_child(group);
}

/// `UniformBlockTests::init`
#[allow(clippy::too_many_lines)]
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ubo");

    // ubo.single_basic_type
    {
        let mut single_basic_type_group = TestCaseGroup::new("single_basic_type");

        for (layout_name, layout_flag) in LAYOUT_FLAGS {
            let mut layout_group = TestCaseGroup::new(layout_name);

            for ty in BASIC_TYPES {
                let type_name = ty.name();

                if ty.is_bool_or_bvec() {
                    create_block_basic_type_cases(
                        &mut layout_group,
                        type_name,
                        VarTypeSpec {
                            basic_type: ty,
                            flags: 0,
                            array_size: 0,
                        },
                        layout_flag,
                        0,
                    );
                } else {
                    for (prec_name, prec_flag) in PRECISION_FLAGS {
                        create_block_basic_type_cases(
                            &mut layout_group,
                            &format!("{prec_name}_{type_name}"),
                            VarTypeSpec {
                                basic_type: ty,
                                flags: prec_flag,
                                array_size: 0,
                            },
                            layout_flag,
                            0,
                        );
                    }
                }

                if ty.is_matrix() {
                    for (mat_name, mat_flag) in MATRIX_FLAGS {
                        for (prec_name, prec_flag) in PRECISION_FLAGS {
                            create_block_basic_type_cases(
                                &mut layout_group,
                                &format!("{mat_name}_{prec_name}_{type_name}"),
                                VarTypeSpec {
                                    basic_type: ty,
                                    flags: prec_flag,
                                    array_size: 0,
                                },
                                layout_flag | mat_flag,
                                0,
                            );
                        }
                    }
                }
            }

            single_basic_type_group.add_child(layout_group);
        }

        group.add_child(single_basic_type_group);
    }

    // ubo.single_basic_array
    {
        let mut single_basic_array_group = TestCaseGroup::new("single_basic_array");
        const ARRAY_SIZE: i32 = 3;

        for (layout_name, layout_flag) in LAYOUT_FLAGS {
            let mut layout_group = TestCaseGroup::new(layout_name);

            for ty in BASIC_TYPES {
                let type_name = ty.name();

                create_block_basic_type_cases(
                    &mut layout_group,
                    type_name,
                    VarTypeSpec {
                        basic_type: ty,
                        flags: if ty.is_bool_or_bvec() { 0 } else { PRECISION_HIGH },
                        array_size: ARRAY_SIZE,
                    },
                    layout_flag,
                    0,
                );

                if ty.is_matrix() {
                    for (mat_name, mat_flag) in MATRIX_FLAGS {
                        create_block_basic_type_cases(
                            &mut layout_group,
                            &format!("{mat_name}_{type_name}"),
                            VarTypeSpec {
                                basic_type: ty,
                                flags: PRECISION_HIGH,
                                array_size: ARRAY_SIZE,
                            },
                            layout_flag | mat_flag,
                            0,
                        );
                    }
                }
            }

            single_basic_array_group.add_child(layout_group);
        }

        group.add_child(single_basic_array_group);
    }

    add_struct_group(&mut group, "single_struct", InterfaceKind::SingleStruct);
    add_struct_group(&mut group, "single_struct_array", InterfaceKind::SingleStructArray);
    add_struct_group(&mut group, "single_nested_struct", InterfaceKind::SingleNestedStruct);

    // ubo.single_nested_struct_mixed_matrix_packing
    {
        let mut mixed_group = TestCaseGroup::new("single_nested_struct_mixed_matrix_packing");

        for (mode_name, buffer_mode) in BUFFER_MODES {
            let mut mode_group = TestCaseGroup::new(mode_name);

            for (layout_name, base_flags) in LAYOUT_FLAGS {
                for (block_mat_name, block_mat_flag) in MATRIX_FLAGS {
                    for (single_mat_name, single_mat_flag) in MATRIX_FLAGS {
                        for (array_mat_name, array_mat_flag) in MATRIX_FLAGS {
                            for is_array in 0..2 {
                                let block_flags = base_flags | block_mat_flag;
                                let mut base_name = format!(
                                    "{layout_name}_block_{block_mat_name}_matrix_{single_mat_name}_matrixarray_{array_mat_name}"
                                );

                                if buffer_mode == BufferMode::Single && is_array == 0 {
                                    continue; // Doesn't make sense to add this variant.
                                }

                                if is_array == 1 {
                                    base_name += "_instance_array";
                                }
                                let num_instances = if is_array == 1 { 3 } else { 0 };
                                let kind = InterfaceKind::SingleNestedStructMixedMatrixPacking(
                                    single_mat_flag,
                                    array_mat_flag,
                                );

                                add_case(
                                    &mut mode_group,
                                    format!("{base_name}_vertex"),
                                    kind,
                                    block_flags | DECLARE_VERTEX,
                                    buffer_mode,
                                    num_instances,
                                );
                                add_case(
                                    &mut mode_group,
                                    format!("{base_name}_fragment"),
                                    kind,
                                    block_flags | DECLARE_FRAGMENT,
                                    buffer_mode,
                                    num_instances,
                                );

                                if base_flags & LAYOUT_PACKED == 0 {
                                    add_case(
                                        &mut mode_group,
                                        format!("{base_name}_both"),
                                        kind,
                                        block_flags | DECLARE_VERTEX | DECLARE_FRAGMENT,
                                        buffer_mode,
                                        num_instances,
                                    );
                                }
                            }
                        }
                    }
                }
            }

            mixed_group.add_child(mode_group);
        }

        group.add_child(mixed_group);
    }

    add_struct_group(
        &mut group,
        "single_nested_struct_array",
        InterfaceKind::SingleNestedStructArray,
    );

    // ubo.instance_array_basic_type
    {
        let mut instance_array_basic_type_group = TestCaseGroup::new("instance_array_basic_type");
        const NUM_INSTANCES: i32 = 3;

        for (layout_name, layout_flag) in LAYOUT_FLAGS {
            let mut layout_group = TestCaseGroup::new(layout_name);

            for ty in BASIC_TYPES {
                let type_name = ty.name();

                create_block_basic_type_cases(
                    &mut layout_group,
                    type_name,
                    VarTypeSpec {
                        basic_type: ty,
                        flags: if ty.is_bool_or_bvec() { 0 } else { PRECISION_HIGH },
                        array_size: 0,
                    },
                    layout_flag,
                    NUM_INSTANCES,
                );

                if ty.is_matrix() {
                    for (mat_name, mat_flag) in MATRIX_FLAGS {
                        create_block_basic_type_cases(
                            &mut layout_group,
                            &format!("{mat_name}_{type_name}"),
                            VarTypeSpec {
                                basic_type: ty,
                                flags: PRECISION_HIGH,
                                array_size: 0,
                            },
                            layout_flag | mat_flag,
                            NUM_INSTANCES,
                        );
                    }
                }
            }

            instance_array_basic_type_group.add_child(layout_group);
        }

        group.add_child(instance_array_basic_type_group);
    }

    add_multi_group(&mut group, "multi_basic_types", InterfaceKind::MultiBasicTypes);
    add_multi_group(&mut group, "multi_nested_struct", InterfaceKind::MultiNestedStruct);

    // ubo.random
    {
        const ALL_SHADERS: u32 = FEATURE_VERTEX_BLOCKS | FEATURE_FRAGMENT_BLOCKS | FEATURE_SHARED_BLOCKS;
        const ALL_LAYOUTS: u32 = FEATURE_PACKED_LAYOUT | FEATURE_SHARED_LAYOUT | FEATURE_STD140_LAYOUT;
        const ALL_BASIC_TYPES: u32 = FEATURE_VECTORS | FEATURE_MATRICES;
        const UNUSED: u32 = FEATURE_UNUSED_MEMBERS | FEATURE_UNUSED_UNIFORMS;
        const MAT_FLAGS: u32 = FEATURE_MATRIX_LAYOUT;
        const ALL_FEATURES: u32 = !FEATURE_ARRAYS_OF_ARRAYS;

        let mut random_group = TestCaseGroup::new("random");
        let mut add = |name: &str, buffer_mode: BufferMode, features: u32, num_cases: u32, base_seed: u32| {
            create_random_case_group(
                &mut random_group,
                name,
                GLSL,
                buffer_mode,
                features,
                num_cases,
                base_seed,
            );
        };

        // Basic types.
        add(
            "scalar_types",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED,
            25,
            0,
        );
        add(
            "vector_types",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | FEATURE_VECTORS,
            25,
            25,
        );
        add(
            "basic_types",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS,
            25,
            50,
        );
        add(
            "basic_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | FEATURE_ARRAYS,
            25,
            50,
        );
        add(
            "basic_instance_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | FEATURE_INSTANCE_ARRAYS,
            25,
            75,
        );
        add(
            "nested_structs",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | FEATURE_STRUCTS,
            25,
            100,
        );
        add(
            "nested_structs_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS | ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | FEATURE_STRUCTS | FEATURE_ARRAYS,
            25,
            150,
        );
        add(
            "nested_structs_instance_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS
                | ALL_LAYOUTS
                | UNUSED
                | ALL_BASIC_TYPES
                | MAT_FLAGS
                | FEATURE_STRUCTS
                | FEATURE_INSTANCE_ARRAYS,
            25,
            125,
        );
        add(
            "nested_structs_arrays_instance_arrays",
            BufferMode::PerBlock,
            ALL_SHADERS
                | ALL_LAYOUTS
                | UNUSED
                | ALL_BASIC_TYPES
                | MAT_FLAGS
                | FEATURE_STRUCTS
                | FEATURE_ARRAYS
                | FEATURE_INSTANCE_ARRAYS,
            25,
            175,
        );
        add("all_per_block_buffers", BufferMode::PerBlock, ALL_FEATURES, 50, 200);
        add("all_shared_buffer", BufferMode::Single, ALL_FEATURES, 50, 250);

        group.add_child(random_group);
    }

    group
}
