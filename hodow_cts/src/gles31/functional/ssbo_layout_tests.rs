// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fSSBOLayoutTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Each `SSBOLayoutCase` subclass exists
// only to fill `m_interface` in `init`; a `TestCase` here is immutable, so each becomes
// a function that builds the same `ShaderInterface` at registration time and the case
// itself is always `SsboLayoutCase`. `RandomSSBOLayoutCase` is the same transformation.

use crate::gles31::functional::ssbo_layout_case::{
    ACCESS_READ, ACCESS_WRITE, BufferBlock, BufferMode, BufferVar, LAYOUT_COLUMN_MAJOR, LAYOUT_PACKED,
    LAYOUT_ROW_MAJOR, LAYOUT_SHARED, LAYOUT_STD140, LAYOUT_STD430, ShaderInterface, SsboLayoutCase,
};
use crate::glu::shader_util::{DataType, Precision};
use crate::glu::var_type::UNSIZED_ARRAY;
use crate::glu::{GlslVersion, StructType, TestCase, TestCaseGroup, VarType};
use crate::tcu::Random;

const GLSL: GlslVersion = GlslVersion::Es310;
const HIGHP: Option<Precision> = Some(Precision::HighP);
const MEDIUMP: Option<Precision> = Some(Precision::MediumP);
const LOWP: Option<Precision> = Some(Precision::LowP);

// `FeatureBits`
const FEATURE_VECTORS: u32 = 1 << 0;
const FEATURE_MATRICES: u32 = 1 << 1;
const FEATURE_ARRAYS: u32 = 1 << 2;
const FEATURE_STRUCTS: u32 = 1 << 3;
const FEATURE_INSTANCE_ARRAYS: u32 = 1 << 5;
const FEATURE_UNUSED_VARS: u32 = 1 << 6;
const FEATURE_UNUSED_MEMBERS: u32 = 1 << 7;
const FEATURE_PACKED_LAYOUT: u32 = 1 << 8;
const FEATURE_SHARED_LAYOUT: u32 = 1 << 9;
const FEATURE_STD140_LAYOUT: u32 = 1 << 10;
/// Matrix layout flags.
const FEATURE_MATRIX_LAYOUT: u32 = 1 << 12;
const FEATURE_UNSIZED_ARRAYS: u32 = 1 << 13;
const FEATURE_ARRAYS_OF_ARRAYS: u32 = 1 << 14;

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

const PRECISIONS: [(&str, Option<Precision>); 3] = [("lowp", LOWP), ("mediump", MEDIUMP), ("highp", HIGHP)];
const LAYOUT_FLAGS: [(&str, u32); 4] = [
    ("shared", LAYOUT_SHARED),
    ("packed", LAYOUT_PACKED),
    ("std140", LAYOUT_STD140),
    ("std430", LAYOUT_STD430),
];
const MATRIX_FLAGS: [(&str, u32); 2] = [("row_major", LAYOUT_ROW_MAJOR), ("column_major", LAYOUT_COLUMN_MAJOR)];
const BUFFER_MODES: [(&str, BufferMode); 2] = [
    ("per_block_buffer", BufferMode::PerBlock),
    ("single_buffer", BufferMode::Single),
];

fn add_case(group: &mut TestCaseGroup, name: String, interface: ShaderInterface, buffer_mode: BufferMode) {
    group.add_child(Box::new(SsboLayoutCase {
        name,
        glsl_version: GLSL,
        buffer_mode,
        interface,
    }) as Box<dyn TestCase>);
}

/// `BlockBasicTypeCase::BlockBasicTypeCase`
fn basic_type_interface(ty: VarType, layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();
    let mut block = BufferBlock::new("Block");
    block.add_member(BufferVar::new("var", ty, ACCESS_READ | ACCESS_WRITE));
    block.flags = layout_flags;

    if num_instances > 0 {
        block.set_array_size(num_instances);
        block.instance_name = Some("block".to_string());
    }

    interface.add_block(block);
    interface
}

/// `BlockBasicUnsizedArrayCase::BlockBasicUnsizedArrayCase`
fn basic_unsized_array_interface(element_type: VarType, array_size: i32, layout_flags: u32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();
    let mut block = BufferBlock::new("Block");
    block.add_member(BufferVar::new(
        "var",
        VarType::array(element_type, UNSIZED_ARRAY),
        ACCESS_READ | ACCESS_WRITE,
    ));
    block.flags = layout_flags;
    block.set_last_unsized_array_size(0, array_size);

    interface.add_block(block);
    interface
}

/// The `S` struct several of the cases declare, parameterised by the members that differ.
fn struct_s(
    interface: &mut ShaderInterface,
    a: (&str, VarType),
    b: (&str, VarType),
    c: Option<(&str, VarType)>,
) -> VarType {
    let mut type_s = StructType::new("S");
    type_s.add_member(a.0, a.1);
    type_s.add_member(b.0, b.1);
    if let Some((name, ty)) = c {
        type_s.add_member(name, ty);
    }
    VarType::structure(&interface.add_struct(type_s))
}

/// Applies the trailing `if (m_numInstances > 0)` block every case shares.
fn finish_block(interface: &mut ShaderInterface, mut block: BufferBlock, layout_flags: u32, num_instances: i32) {
    block.flags = layout_flags;
    if num_instances > 0 {
        block.instance_name = Some("block".to_string());
        block.set_array_size(num_instances);
    }
    interface.add_block(block);
}

/// The randomized last-unsized-array lengths upstream picks with its own seed per case.
fn set_random_unsized_sizes(block: &mut BufferBlock, seed: u32, num_instances: i32) {
    let mut rnd = Random::new(seed);
    for ndx in 0..if num_instances > 0 { num_instances } else { 1 } {
        let last_array_len = rnd.get_int(1, 5);
        block.set_last_unsized_array_size(ndx as usize, last_array_len);
    }
}

/// `BlockSingleStructCase::init`
fn single_struct_interface(layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();
    // \todo [pyry] First member is unused.
    let type_s = struct_s(
        &mut interface,
        ("a", VarType::basic(DataType::IntVec3, HIGHP)),
        ("b", VarType::array(VarType::basic(DataType::FloatMat3, MEDIUMP), 4)),
        Some(("c", VarType::basic(DataType::FloatVec4, HIGHP))),
    );

    let mut block = BufferBlock::new("Block");
    block.add_member(BufferVar::new("s", type_s, ACCESS_READ | ACCESS_WRITE));
    finish_block(&mut interface, block, layout_flags, num_instances);
    interface
}

/// `BlockSingleStructArrayCase::init`
fn single_struct_array_interface(layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();
    let type_s = struct_s(
        &mut interface,
        ("a", VarType::basic(DataType::IntVec3, HIGHP)),
        ("b", VarType::array(VarType::basic(DataType::FloatMat3, MEDIUMP), 4)),
        Some(("c", VarType::basic(DataType::FloatVec4, HIGHP))),
    );

    let mut block = BufferBlock::new("Block");
    block.add_member(BufferVar::new(
        "u",
        VarType::basic(DataType::Uint, LOWP),
        0, /* no access */
    ));
    block.add_member(BufferVar::new(
        "s",
        VarType::array(type_s, 3),
        ACCESS_READ | ACCESS_WRITE,
    ));
    block.add_member(BufferVar::new(
        "v",
        VarType::basic(DataType::FloatVec4, MEDIUMP),
        ACCESS_WRITE,
    ));
    finish_block(&mut interface, block, layout_flags, num_instances);
    interface
}

/// `BlockSingleNestedStructCase::init`
fn single_nested_struct_interface(layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();
    let type_s = struct_s(
        &mut interface,
        ("a", VarType::basic(DataType::IntVec3, HIGHP)),
        ("b", VarType::array(VarType::basic(DataType::FloatMat3, MEDIUMP), 4)),
        Some(("c", VarType::basic(DataType::FloatVec4, HIGHP))),
    );

    let mut type_t = StructType::new("T");
    type_t.add_member("a", VarType::basic(DataType::FloatMat3, MEDIUMP));
    type_t.add_member("b", type_s.clone());
    let type_t = VarType::structure(&interface.add_struct(type_t));

    let mut block = BufferBlock::new("Block");
    block.add_member(BufferVar::new("s", type_s, ACCESS_READ));
    block.add_member(BufferVar::new(
        "v",
        VarType::basic(DataType::FloatVec2, LOWP),
        0, /* no access */
    ));
    block.add_member(BufferVar::new("t", type_t, ACCESS_READ | ACCESS_WRITE));
    block.add_member(BufferVar::new("u", VarType::basic(DataType::Uint, HIGHP), ACCESS_WRITE));
    finish_block(&mut interface, block, layout_flags, num_instances);
    interface
}

/// `BlockSingleNestedStructArrayCase::init`
fn single_nested_struct_array_interface(layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();
    let type_s = struct_s(
        &mut interface,
        ("a", VarType::basic(DataType::IntVec3, HIGHP)),
        ("b", VarType::array(VarType::basic(DataType::IntVec2, MEDIUMP), 4)),
        Some(("c", VarType::basic(DataType::FloatVec4, HIGHP))),
    );

    let mut type_t = StructType::new("T");
    type_t.add_member("a", VarType::basic(DataType::FloatMat3, MEDIUMP));
    type_t.add_member("b", VarType::array(type_s.clone(), 3));
    let type_t = VarType::structure(&interface.add_struct(type_t));

    let mut block = BufferBlock::new("Block");
    block.add_member(BufferVar::new("s", type_s, ACCESS_WRITE));
    block.add_member(BufferVar::new(
        "v",
        VarType::basic(DataType::FloatVec2, LOWP),
        0, /* no access */
    ));
    block.add_member(BufferVar::new("t", VarType::array(type_t, 2), ACCESS_READ));
    block.add_member(BufferVar::new(
        "u",
        VarType::basic(DataType::Uint, HIGHP),
        ACCESS_READ | ACCESS_WRITE,
    ));
    finish_block(&mut interface, block, layout_flags, num_instances);
    interface
}

/// `BlockUnsizedStructArrayCase::init`
fn unsized_struct_array_interface(layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();
    let type_s = struct_s(
        &mut interface,
        ("a", VarType::basic(DataType::UintVec2, HIGHP)),
        ("b", VarType::array(VarType::basic(DataType::FloatMat2x4, MEDIUMP), 4)),
        Some(("c", VarType::basic(DataType::FloatVec3, HIGHP))),
    );

    let mut block = BufferBlock::new("Block");
    block.add_member(BufferVar::new(
        "u",
        VarType::basic(DataType::FloatVec2, LOWP),
        0, /* no access */
    ));
    block.add_member(BufferVar::new(
        "v",
        VarType::basic(DataType::Uint, MEDIUMP),
        ACCESS_WRITE,
    ));
    block.add_member(BufferVar::new(
        "s",
        VarType::array(type_s, UNSIZED_ARRAY),
        ACCESS_READ | ACCESS_WRITE,
    ));
    block.flags = layout_flags;
    if num_instances > 0 {
        block.instance_name = Some("block".to_string());
        block.set_array_size(num_instances);
    }
    set_random_unsized_sizes(&mut block, 246, num_instances);
    interface.add_block(block);
    interface
}

/// `Block2LevelUnsizedStructArrayCase::init`
fn two_level_unsized_struct_array_interface(layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();

    let mut type_s = StructType::new("S");
    type_s.add_member("a", VarType::basic(DataType::IntVec3, HIGHP));
    type_s.add_member("c", VarType::basic(DataType::FloatVec4, HIGHP));
    let type_s = VarType::structure(&interface.add_struct(type_s));

    let mut block = BufferBlock::new("Block");
    block.add_member(BufferVar::new(
        "u",
        VarType::basic(DataType::Uint, LOWP),
        0, /* no access */
    ));
    block.add_member(BufferVar::new(
        "v",
        VarType::basic(DataType::FloatVec4, MEDIUMP),
        ACCESS_WRITE,
    ));
    block.add_member(BufferVar::new(
        "s",
        VarType::array(VarType::array(type_s, 2), UNSIZED_ARRAY),
        ACCESS_READ | ACCESS_WRITE,
    ));
    block.flags = layout_flags;
    if num_instances > 0 {
        block.instance_name = Some("block".to_string());
        block.set_array_size(num_instances);
    }
    set_random_unsized_sizes(&mut block, 2344, num_instances);
    interface.add_block(block);
    interface
}

/// `BlockUnsizedNestedStructArrayCase::init`
fn unsized_nested_struct_array_interface(layout_flags: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();
    let type_s = struct_s(
        &mut interface,
        ("a", VarType::basic(DataType::UintVec3, HIGHP)),
        ("b", VarType::array(VarType::basic(DataType::FloatVec2, MEDIUMP), 4)),
        Some(("c", VarType::basic(DataType::FloatVec4, HIGHP))),
    );

    let mut type_t = StructType::new("T");
    type_t.add_member("a", VarType::basic(DataType::FloatMat4x3, MEDIUMP));
    type_t.add_member("b", VarType::array(type_s.clone(), 3));
    type_t.add_member("c", VarType::basic(DataType::Int, HIGHP));
    let type_t = VarType::structure(&interface.add_struct(type_t));

    let mut block = BufferBlock::new("Block");
    block.add_member(BufferVar::new("s", type_s, ACCESS_WRITE));
    block.add_member(BufferVar::new(
        "v",
        VarType::basic(DataType::FloatVec2, LOWP),
        0, /* no access */
    ));
    block.add_member(BufferVar::new(
        "u",
        VarType::basic(DataType::Uint, HIGHP),
        ACCESS_READ | ACCESS_WRITE,
    ));
    block.add_member(BufferVar::new("t", VarType::array(type_t, UNSIZED_ARRAY), ACCESS_READ));
    block.flags = layout_flags;
    if num_instances > 0 {
        block.instance_name = Some("block".to_string());
        block.set_array_size(num_instances);
    }
    set_random_unsized_sizes(&mut block, 7921, num_instances);
    interface.add_block(block);
    interface
}

/// `BlockMultiBasicTypesCase::init`
fn multi_basic_types_interface(flags_a: u32, flags_b: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();

    let mut block_a = BufferBlock::new("BlockA");
    block_a.add_member(BufferVar::new(
        "a",
        VarType::basic(DataType::Float, HIGHP),
        ACCESS_READ | ACCESS_WRITE,
    ));
    block_a.add_member(BufferVar::new(
        "b",
        VarType::basic(DataType::UintVec3, LOWP),
        0, /* no access */
    ));
    block_a.add_member(BufferVar::new(
        "c",
        VarType::basic(DataType::FloatMat2, MEDIUMP),
        ACCESS_READ,
    ));
    block_a.instance_name = Some("blockA".to_string());
    block_a.flags = flags_a;

    let mut block_b = BufferBlock::new("BlockB");
    block_b.add_member(BufferVar::new(
        "a",
        VarType::basic(DataType::FloatMat3, MEDIUMP),
        ACCESS_WRITE,
    ));
    block_b.add_member(BufferVar::new(
        "b",
        VarType::basic(DataType::IntVec2, LOWP),
        ACCESS_READ,
    ));
    block_b.add_member(BufferVar::new(
        "c",
        VarType::basic(DataType::FloatVec4, HIGHP),
        0, /* no access */
    ));
    block_b.add_member(BufferVar::new(
        "d",
        VarType::basic(DataType::Bool, None),
        ACCESS_READ | ACCESS_WRITE,
    ));
    block_b.instance_name = Some("blockB".to_string());
    block_b.flags = flags_b;

    if num_instances > 0 {
        block_a.set_array_size(num_instances);
        block_b.set_array_size(num_instances);
    }

    interface.add_block(block_a);
    interface.add_block(block_b);
    interface
}

/// `BlockMultiNestedStructCase::init`
fn multi_nested_struct_interface(flags_a: u32, flags_b: u32, num_instances: i32) -> ShaderInterface {
    let mut interface = ShaderInterface::default();

    let mut type_s = StructType::new("S");
    type_s.add_member("a", VarType::basic(DataType::FloatMat3, LOWP));
    type_s.add_member("b", VarType::array(VarType::basic(DataType::IntVec2, MEDIUMP), 4));
    type_s.add_member("c", VarType::basic(DataType::FloatVec4, HIGHP));
    let type_s = VarType::structure(&interface.add_struct(type_s));

    let mut type_t = StructType::new("T");
    // \todo [pyry] UNUSED
    type_t.add_member("a", VarType::basic(DataType::Uint, MEDIUMP));
    type_t.add_member("b", type_s.clone());
    type_t.add_member("c", VarType::basic(DataType::BoolVec4, None));
    let type_t = VarType::structure(&interface.add_struct(type_t));

    let mut block_a = BufferBlock::new("BlockA");
    block_a.add_member(BufferVar::new(
        "a",
        VarType::basic(DataType::Float, HIGHP),
        ACCESS_READ | ACCESS_WRITE,
    ));
    block_a.add_member(BufferVar::new("b", type_s, ACCESS_WRITE));
    block_a.add_member(BufferVar::new(
        "c",
        VarType::basic(DataType::UintVec3, LOWP),
        0, /* no access */
    ));
    block_a.instance_name = Some("blockA".to_string());
    block_a.flags = flags_a;

    let mut block_b = BufferBlock::new("BlockB");
    block_b.add_member(BufferVar::new(
        "a",
        VarType::basic(DataType::FloatMat2, MEDIUMP),
        ACCESS_WRITE,
    ));
    block_b.add_member(BufferVar::new("b", type_t, ACCESS_READ | ACCESS_WRITE));
    block_b.add_member(BufferVar::new(
        "c",
        VarType::basic(DataType::BoolVec4, None),
        0, /* no access */
    ));
    block_b.add_member(BufferVar::new(
        "d",
        VarType::basic(DataType::Bool, None),
        ACCESS_READ | ACCESS_WRITE,
    ));
    block_b.instance_name = Some("blockB".to_string());
    block_b.flags = flags_b;

    if num_instances > 0 {
        block_a.set_array_size(num_instances);
        block_b.set_array_size(num_instances);
    }

    interface.add_block(block_a);
    interface.add_block(block_b);
    interface
}

// --- RandomSSBOLayoutCase ----------------------------------------------------------

/// `genName`
fn gen_name(first: u8, last: u8, ndx: i32) -> String {
    let mut str = Vec::new();
    let alphabet_len = i32::from(last - first) + 1;
    let mut ndx = ndx;

    while ndx > alphabet_len {
        str.insert(0, first + ((ndx - 1) % alphabet_len) as u8);
        ndx = (ndx - 1) / alphabet_len;
    }
    str.insert(0, first + (ndx % (alphabet_len + 1)) as u8 - 1);

    String::from_utf8(str).expect("generated names are ASCII")
}

/// The state `RandomSSBOLayoutCase` keeps between its `generate*` calls.
struct Generator {
    features: u32,
    max_blocks: i32,
    max_instances: i32,
    max_array_length: i32,
    max_array_depth: i32,
    max_struct_depth: i32,
    max_block_members: i32,
    max_struct_members: i32,
    block_ndx: i32,
    buffer_var_ndx: i32,
    struct_ndx: i32,
}

impl Generator {
    fn has(&self, feature: u32) -> bool {
        self.features & feature != 0
    }

    /// `RandomSSBOLayoutCase::generateType`
    fn generate_type(
        &mut self,
        interface: &mut ShaderInterface,
        rnd: &mut Random,
        struct_depth: i32,
        array_depth: i32,
        array_ok: bool,
        unsized_array_ok: bool,
    ) -> VarType {
        const STRUCT_WEIGHT: f32 = 0.1;
        const ARRAY_WEIGHT: f32 = 0.1;
        const UNSIZED_ARRAY_WEIGHT: f32 = 0.8;

        if unsized_array_ok && rnd.get_float() < UNSIZED_ARRAY_WEIGHT {
            let child_array_ok = self.has(FEATURE_ARRAYS_OF_ARRAYS) && array_depth < self.max_array_depth;
            let element_type = self.generate_type(interface, rnd, struct_depth, array_depth + 1, child_array_ok, false);
            VarType::array(element_type, UNSIZED_ARRAY)
        } else if struct_depth < self.max_struct_depth && rnd.get_float() < STRUCT_WEIGHT {
            // \todo [2013-10-14 pyry] Implement unused flags for members!
            let num_members = rnd.get_int(1, self.max_struct_members);

            // Generate members first so nested struct declarations are in correct order.
            let member_types: Vec<VarType> = (0..num_members)
                .map(|_| {
                    self.generate_type(
                        interface,
                        rnd,
                        struct_depth + 1,
                        array_depth,
                        array_depth < self.max_array_depth,
                        false,
                    )
                })
                .collect();

            let mut struct_type = StructType::new(&format!("s{}", gen_name(b'A', b'Z', self.struct_ndx)));
            self.struct_ndx += 1;

            for (ndx, member_type) in member_types.into_iter().enumerate() {
                struct_type.add_member(&format!("m{}", (b'A' + ndx as u8) as char), member_type);
            }

            VarType::structure(&interface.add_struct(struct_type))
        } else if self.max_array_length > 0 && array_ok && rnd.get_float() < ARRAY_WEIGHT {
            let array_length = rnd.get_int(1, self.max_array_length);
            let child_array_ok = self.has(FEATURE_ARRAYS_OF_ARRAYS) && array_depth < self.max_array_depth;
            let element_type = self.generate_type(interface, rnd, struct_depth, array_depth + 1, child_array_ok, false);
            VarType::array(element_type, array_length)
        } else {
            let mut type_candidates = vec![DataType::Float, DataType::Int, DataType::Uint, DataType::Bool];

            if self.has(FEATURE_VECTORS) {
                type_candidates.extend([
                    DataType::FloatVec2,
                    DataType::FloatVec3,
                    DataType::FloatVec4,
                    DataType::IntVec2,
                    DataType::IntVec3,
                    DataType::IntVec4,
                    DataType::UintVec2,
                    DataType::UintVec3,
                    DataType::UintVec4,
                    DataType::BoolVec2,
                    DataType::BoolVec3,
                    DataType::BoolVec4,
                ]);
            }

            if self.has(FEATURE_MATRICES) {
                type_candidates.extend([
                    DataType::FloatMat2,
                    DataType::FloatMat2x3,
                    DataType::FloatMat3x2,
                    DataType::FloatMat3,
                    DataType::FloatMat3x4,
                    DataType::FloatMat4x2,
                    DataType::FloatMat4x3,
                    DataType::FloatMat4,
                ]);
            }

            let ty = *rnd.choose(&type_candidates);
            let precision = if ty.is_bool_or_bvec() {
                None
            } else {
                const PRECISION_CANDIDATES: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];
                Some(*rnd.choose(&PRECISION_CANDIDATES))
            };

            VarType::basic(ty, precision)
        }
    }

    /// `RandomSSBOLayoutCase::generateBufferVar`
    fn generate_buffer_var(
        &mut self,
        interface: &mut ShaderInterface,
        rnd: &mut Random,
        block: &mut BufferBlock,
        is_last_member: bool,
    ) {
        const READ_WEIGHT: f32 = 0.7;
        const WRITE_WEIGHT: f32 = 0.7;
        const ACCESS_WEIGHT: f32 = 0.85;
        let unused_ok = self.has(FEATURE_UNUSED_VARS);
        let name = gen_name(b'a', b'z', self.buffer_var_ndx);
        let ty = self.generate_type(
            interface,
            rnd,
            0,
            0,
            true,
            is_last_member && self.has(FEATURE_UNSIZED_ARRAYS),
        );
        let access = !unused_ok || rnd.get_float() < ACCESS_WEIGHT;
        let read = access && rnd.get_float() < READ_WEIGHT;
        let write = access && (!read || rnd.get_float() < WRITE_WEIGHT);
        let flags = if read { ACCESS_READ } else { 0 } | if write { ACCESS_WRITE } else { 0 };

        block.add_member(BufferVar::new(&name, ty, flags));
        self.buffer_var_ndx += 1;
    }

    /// `RandomSSBOLayoutCase::generateBlock`
    fn generate_block(&mut self, interface: &mut ShaderInterface, rnd: &mut Random, layout_flags: u32) {
        const INSTANCE_ARRAY_WEIGHT: f32 = 0.3;

        let mut block = BufferBlock::new(&format!("Block{}", (b'A' + self.block_ndx as u8) as char));
        let num_instances = if self.max_instances > 0 && rnd.get_float() < INSTANCE_ARRAY_WEIGHT {
            rnd.get_int(0, self.max_instances)
        } else {
            0
        };
        let num_vars = rnd.get_int(1, self.max_block_members);

        if num_instances > 0 {
            block.set_array_size(num_instances);
        }
        if num_instances > 0 || rnd.get_bool() {
            block.instance_name = Some(format!("block{}", (b'A' + self.block_ndx as u8) as char));
        }

        // Layout flag candidates.
        let mut layout_flag_candidates = vec![0];
        if self.has(FEATURE_PACKED_LAYOUT) {
            layout_flag_candidates.push(LAYOUT_PACKED);
        }
        if self.has(FEATURE_SHARED_LAYOUT) {
            layout_flag_candidates.push(LAYOUT_SHARED);
        }
        if self.has(FEATURE_STD140_LAYOUT) {
            layout_flag_candidates.push(LAYOUT_STD140);
        }

        let mut layout_flags = layout_flags | *rnd.choose(&layout_flag_candidates);

        if self.has(FEATURE_MATRIX_LAYOUT) {
            const MATRIX_CANDIDATES: [u32; 3] = [0, LAYOUT_ROW_MAJOR, LAYOUT_COLUMN_MAJOR];
            layout_flags |= *rnd.choose(&MATRIX_CANDIDATES);
        }

        block.flags = layout_flags;

        for ndx in 0..num_vars {
            self.generate_buffer_var(interface, rnd, &mut block, ndx + 1 == num_vars);
        }

        if num_vars > 0 {
            let last_type = &block.variables[block.variables.len() - 1].ty;
            let is_unsized_arr = last_type.is_array_type() && last_type.array_size() == UNSIZED_ARRAY;

            if is_unsized_arr {
                for instance_ndx in 0..if num_instances > 0 { num_instances } else { 1 } {
                    let arr_size = rnd.get_int(0, self.max_array_length);
                    block.set_last_unsized_array_size(instance_ndx as usize, arr_size);
                }
            }
        }

        interface.add_block(block);
        self.block_ndx += 1;
    }
}

/// `RandomSSBOLayoutCase::init`
fn generate_random_interface(features: u32, seed: u32) -> ShaderInterface {
    let mut generator = Generator {
        features,
        max_blocks: 3,
        max_instances: if features & FEATURE_INSTANCE_ARRAYS != 0 { 3 } else { 0 },
        max_array_length: if features & FEATURE_ARRAYS != 0 { 8 } else { 0 },
        max_array_depth: if features & FEATURE_ARRAYS_OF_ARRAYS != 0 { 2 } else { 0 },
        max_struct_depth: if features & FEATURE_STRUCTS != 0 { 2 } else { 0 },
        max_block_members: 4,
        max_struct_members: 4,
        block_ndx: 1,
        buffer_var_ndx: 1,
        struct_ndx: 1,
    };

    let mut interface = ShaderInterface::default();
    let mut rnd = Random::new(seed);
    let num_blocks = rnd.get_int(1, generator.max_blocks);

    for _ in 0..num_blocks {
        generator.generate_block(&mut interface, &mut rnd, 0);
    }

    interface
}

// --- Registration ------------------------------------------------------------------

/// The `single_basic_array`/`basic_unsized_array`/`2_level_array`/`3_level_array`/
/// `3_level_unsized_array`/`instance_array_basic_type` groups: one case per basic type
/// with an optional row-major/column-major variant for matrices.
fn add_per_basic_type_group(
    parent: &mut TestCaseGroup,
    name: &str,
    make_interface: &dyn Fn(DataType, u32) -> ShaderInterface,
) {
    let mut group = TestCaseGroup::new(name);

    for (layout_name, layout_flag) in LAYOUT_FLAGS {
        let mut layout_group = TestCaseGroup::new(layout_name);

        for ty in BASIC_TYPES {
            let type_name = ty.name();
            add_case(
                &mut layout_group,
                type_name.to_string(),
                make_interface(ty, layout_flag),
                BufferMode::PerBlock,
            );

            if ty.is_matrix() {
                for (mat_name, mat_flag) in MATRIX_FLAGS {
                    add_case(
                        &mut layout_group,
                        format!("{mat_name}_{type_name}"),
                        make_interface(ty, layout_flag | mat_flag),
                        BufferMode::PerBlock,
                    );
                }
            }
        }

        group.add_child(layout_group);
    }

    parent.add_child(group);
}

/// The struct groups, which differ only in which interface builder they call.
fn add_struct_group(
    parent: &mut TestCaseGroup,
    name: &str,
    make_interface: fn(u32, i32) -> ShaderInterface,
    skip_single_non_array: bool,
) {
    let mut group = TestCaseGroup::new(name);

    for (mode_name, buffer_mode) in BUFFER_MODES {
        let mut mode_group = TestCaseGroup::new(mode_name);

        for (layout_name, base_flags) in LAYOUT_FLAGS {
            for is_array in 0..2 {
                if skip_single_non_array && buffer_mode == BufferMode::Single && is_array == 0 {
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
                    base_name,
                    make_interface(base_flags, num_instances),
                    buffer_mode,
                );
            }
        }

        group.add_child(mode_group);
    }

    parent.add_child(group);
}

fn precision_of(ty: DataType) -> Option<Precision> {
    if ty.is_bool_or_bvec() { None } else { HIGHP }
}

/// `SSBOLayoutTests::init`
#[allow(clippy::too_many_lines)]
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("layout");

    // layout.single_basic_type
    {
        let mut single_basic_type_group = TestCaseGroup::new("single_basic_type");

        for (layout_name, layout_flag) in LAYOUT_FLAGS {
            let mut layout_group = TestCaseGroup::new(layout_name);

            for ty in BASIC_TYPES {
                let type_name = ty.name();

                if ty.is_bool_or_bvec() {
                    add_case(
                        &mut layout_group,
                        type_name.to_string(),
                        basic_type_interface(VarType::basic(ty, None), layout_flag, 0),
                        BufferMode::PerBlock,
                    );
                } else {
                    for (prec_name, precision) in PRECISIONS {
                        add_case(
                            &mut layout_group,
                            format!("{prec_name}_{type_name}"),
                            basic_type_interface(VarType::basic(ty, precision), layout_flag, 0),
                            BufferMode::PerBlock,
                        );
                    }
                }

                if ty.is_matrix() {
                    for (mat_name, mat_flag) in MATRIX_FLAGS {
                        for (prec_name, precision) in PRECISIONS {
                            add_case(
                                &mut layout_group,
                                format!("{mat_name}_{prec_name}_{type_name}"),
                                basic_type_interface(VarType::basic(ty, precision), layout_flag | mat_flag, 0),
                                BufferMode::PerBlock,
                            );
                        }
                    }
                }
            }

            single_basic_type_group.add_child(layout_group);
        }

        group.add_child(single_basic_type_group);
    }

    // layout.single_basic_array - array size 3.
    add_per_basic_type_group(&mut group, "single_basic_array", &|ty, flags| {
        basic_type_interface(VarType::array(VarType::basic(ty, precision_of(ty)), 3), flags, 0)
    });

    // layout.basic_unsized_array - array size 19.
    add_per_basic_type_group(&mut group, "basic_unsized_array", &|ty, flags| {
        basic_unsized_array_interface(VarType::basic(ty, precision_of(ty)), 19, flags)
    });

    // layout.2_level_array - child size 3, parent size 4.
    add_per_basic_type_group(&mut group, "2_level_array", &|ty, flags| {
        let child = VarType::array(VarType::basic(ty, precision_of(ty)), 3);
        basic_type_interface(VarType::array(child, 4), flags, 0)
    });

    // layout.3_level_array - child sizes 3 and 2, parent size 4.
    add_per_basic_type_group(&mut group, "3_level_array", &|ty, flags| {
        let child0 = VarType::array(VarType::basic(ty, precision_of(ty)), 3);
        let child1 = VarType::array(child0, 2);
        basic_type_interface(VarType::array(child1, 4), flags, 0)
    });

    // layout.3_level_unsized_array - child sizes 2 and 4, unsized parent of size 3.
    add_per_basic_type_group(&mut group, "3_level_unsized_array", &|ty, flags| {
        let child0 = VarType::array(VarType::basic(ty, precision_of(ty)), 2);
        let child1 = VarType::array(child0, 4);
        basic_unsized_array_interface(child1, 3, flags)
    });

    add_struct_group(&mut group, "single_struct", single_struct_interface, true);
    add_struct_group(&mut group, "single_struct_array", single_struct_array_interface, true);
    add_struct_group(&mut group, "single_nested_struct", single_nested_struct_interface, true);
    add_struct_group(
        &mut group,
        "single_nested_struct_array",
        single_nested_struct_array_interface,
        true,
    );
    add_struct_group(&mut group, "unsized_struct_array", unsized_struct_array_interface, true);
    add_struct_group(
        &mut group,
        "2_level_unsized_struct_array",
        two_level_unsized_struct_array_interface,
        true,
    );
    add_struct_group(
        &mut group,
        "unsized_nested_struct_array",
        unsized_nested_struct_array_interface,
        true,
    );

    // layout.instance_array_basic_type - three instances.
    add_per_basic_type_group(&mut group, "instance_array_basic_type", &|ty, flags| {
        basic_type_interface(VarType::basic(ty, precision_of(ty)), flags, 3)
    });

    add_struct_group(
        &mut group,
        "multi_basic_types",
        |flags, num_instances| multi_basic_types_interface(flags, flags, num_instances),
        false,
    );
    add_struct_group(
        &mut group,
        "multi_nested_struct",
        |flags, num_instances| multi_nested_struct_interface(flags, flags, num_instances),
        false,
    );

    // layout.random
    {
        const ALL_LAYOUTS: u32 = FEATURE_PACKED_LAYOUT | FEATURE_SHARED_LAYOUT | FEATURE_STD140_LAYOUT;
        const ALL_BASIC_TYPES: u32 = FEATURE_VECTORS | FEATURE_MATRICES;
        const UNUSED: u32 = FEATURE_UNUSED_MEMBERS | FEATURE_UNUSED_VARS;
        const UNSIZED: u32 = FEATURE_UNSIZED_ARRAYS;
        const MAT_FLAGS: u32 = FEATURE_MATRIX_LAYOUT;

        let mut random_group = TestCaseGroup::new("random");
        let mut add = |name: &str, buffer_mode: BufferMode, features: u32, num_cases: u32, base_seed: u32| {
            let mut case_group = TestCaseGroup::new(name);
            for ndx in 0..num_cases {
                add_case(
                    &mut case_group,
                    ndx.to_string(),
                    generate_random_interface(features, ndx + base_seed),
                    buffer_mode,
                );
            }
            random_group.add_child(case_group);
        };

        // Basic types.
        add("scalar_types", BufferMode::PerBlock, ALL_LAYOUTS | UNUSED, 25, 0);
        add(
            "vector_types",
            BufferMode::PerBlock,
            ALL_LAYOUTS | UNUSED | FEATURE_VECTORS,
            25,
            25,
        );
        add(
            "basic_types",
            BufferMode::PerBlock,
            ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS,
            25,
            50,
        );
        add(
            "basic_arrays",
            BufferMode::PerBlock,
            ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | FEATURE_ARRAYS,
            25,
            50,
        );
        add(
            "unsized_arrays",
            BufferMode::PerBlock,
            ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | UNSIZED | FEATURE_ARRAYS,
            25,
            50,
        );
        add(
            "arrays_of_arrays",
            BufferMode::PerBlock,
            ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | UNSIZED | FEATURE_ARRAYS | FEATURE_ARRAYS_OF_ARRAYS,
            25,
            950,
        );
        add(
            "basic_instance_arrays",
            BufferMode::PerBlock,
            ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | UNSIZED | FEATURE_INSTANCE_ARRAYS,
            25,
            75,
        );
        add(
            "nested_structs",
            BufferMode::PerBlock,
            ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | UNSIZED | FEATURE_STRUCTS,
            25,
            100,
        );
        add(
            "nested_structs_arrays",
            BufferMode::PerBlock,
            ALL_LAYOUTS
                | UNUSED
                | ALL_BASIC_TYPES
                | MAT_FLAGS
                | UNSIZED
                | FEATURE_STRUCTS
                | FEATURE_ARRAYS
                | FEATURE_ARRAYS_OF_ARRAYS,
            25,
            150,
        );
        add(
            "nested_structs_instance_arrays",
            BufferMode::PerBlock,
            ALL_LAYOUTS | UNUSED | ALL_BASIC_TYPES | MAT_FLAGS | UNSIZED | FEATURE_STRUCTS | FEATURE_INSTANCE_ARRAYS,
            25,
            125,
        );
        add(
            "nested_structs_arrays_instance_arrays",
            BufferMode::PerBlock,
            ALL_LAYOUTS
                | UNUSED
                | ALL_BASIC_TYPES
                | MAT_FLAGS
                | UNSIZED
                | FEATURE_STRUCTS
                | FEATURE_ARRAYS
                | FEATURE_ARRAYS_OF_ARRAYS
                | FEATURE_INSTANCE_ARRAYS,
            25,
            175,
        );
        add("all_per_block_buffers", BufferMode::PerBlock, u32::MAX, 50, 200);
        add("all_shared_buffer", BufferMode::Single, u32::MAX, 50, 250);

        group.add_child(random_group);
    }

    group
}
