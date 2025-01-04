// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsRandomUniformBlockCase.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2012 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream subclasses `UniformBlockCase`
// and fills `m_interface` in `init`; a `TestCase` here is immutable, so this is a
// function that builds the same `ShaderInterface` at registration time. Nothing else
// differs - the case that runs it is `gls::uniform_block_case::UniformBlockCase`.

use crate::gls::uniform_block_case::{
    DECLARE_BOTH, DECLARE_FRAGMENT, DECLARE_VERTEX, LAYOUT_COLUMN_MAJOR, LAYOUT_PACKED, LAYOUT_ROW_MAJOR,
    LAYOUT_SHARED, LAYOUT_STD140, PRECISION_HIGH, PRECISION_LOW, PRECISION_MEDIUM, ShaderInterface, StructType,
    UNUSED_FRAGMENT, UNUSED_VERTEX, Uniform, UniformBlock, VarType,
};
use crate::glu::shader_util::DataType;
use crate::tcu::Random;

// `ub::FeatureBits`
pub const FEATURE_VECTORS: u32 = 1 << 0;
pub const FEATURE_MATRICES: u32 = 1 << 1;
pub const FEATURE_ARRAYS: u32 = 1 << 2;
pub const FEATURE_STRUCTS: u32 = 1 << 3;
pub const FEATURE_NESTED_STRUCTS: u32 = 1 << 4;
pub const FEATURE_INSTANCE_ARRAYS: u32 = 1 << 5;
pub const FEATURE_VERTEX_BLOCKS: u32 = 1 << 6;
pub const FEATURE_FRAGMENT_BLOCKS: u32 = 1 << 7;
pub const FEATURE_SHARED_BLOCKS: u32 = 1 << 8;
pub const FEATURE_UNUSED_UNIFORMS: u32 = 1 << 9;
pub const FEATURE_UNUSED_MEMBERS: u32 = 1 << 10;
pub const FEATURE_PACKED_LAYOUT: u32 = 1 << 11;
pub const FEATURE_SHARED_LAYOUT: u32 = 1 << 12;
pub const FEATURE_STD140_LAYOUT: u32 = 1 << 13;
/// Matrix layout flags.
pub const FEATURE_MATRIX_LAYOUT: u32 = 1 << 14;
pub const FEATURE_ARRAYS_OF_ARRAYS: u32 = 1 << 15;

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

/// The state `RandomUniformBlockCase` keeps between its `generate*` calls.
struct Generator {
    features: u32,
    max_instances: i32,
    max_array_length: i32,
    max_struct_depth: i32,
    max_block_members: i32,
    max_struct_members: i32,
    block_ndx: i32,
    uniform_ndx: i32,
    struct_ndx: i32,
}

impl Generator {
    fn has(&self, feature: u32) -> bool {
        self.features & feature != 0
    }

    /// `RandomUniformBlockCase::generateType`
    fn generate_type(
        &mut self,
        interface: &mut ShaderInterface,
        rnd: &mut Random,
        type_depth: i32,
        array_ok: bool,
    ) -> VarType {
        const STRUCT_WEIGHT: f32 = 0.1;
        const ARRAY_WEIGHT: f32 = 0.1;

        if type_depth < self.max_struct_depth && rnd.get_float() < STRUCT_WEIGHT {
            const UNUSED_VTX_WEIGHT: f32 = 0.15;
            const UNUSED_FRAG_WEIGHT: f32 = 0.15;
            let unused_ok = self.has(FEATURE_UNUSED_MEMBERS);
            let num_members = rnd.get_int(1, self.max_struct_members);

            // Generate members first so nested struct declarations are in correct order.
            let member_types: Vec<VarType> = (0..num_members)
                .map(|_| self.generate_type(interface, rnd, type_depth + 1, true))
                .collect();

            let mut struct_type = StructType::new(&format!("s{}", gen_name(b'A', b'Z', self.struct_ndx)));
            self.struct_ndx += 1;

            for (ndx, member_type) in member_types.into_iter().enumerate() {
                let mut flags = 0;
                if unused_ok && rnd.get_float() < UNUSED_VTX_WEIGHT {
                    flags |= UNUSED_VERTEX;
                }
                if unused_ok && rnd.get_float() < UNUSED_FRAG_WEIGHT {
                    flags |= UNUSED_FRAGMENT;
                }
                struct_type.add_member(&format!("m{}", (b'A' + ndx as u8) as char), member_type, flags);
            }

            VarType::structure(&interface.add_struct(struct_type), 0)
        } else if self.max_array_length > 0 && array_ok && rnd.get_float() < ARRAY_WEIGHT {
            let arrays_of_arrays_ok = self.has(FEATURE_ARRAYS_OF_ARRAYS);
            let array_length = rnd.get_int(1, self.max_array_length);
            let element_type = self.generate_type(interface, rnd, type_depth, arrays_of_arrays_ok);
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
            let mut flags = 0;

            if !ty.is_bool_or_bvec() {
                // Precision.
                const PRECISION_CANDIDATES: [u32; 3] = [PRECISION_LOW, PRECISION_MEDIUM, PRECISION_HIGH];
                flags |= *rnd.choose(&PRECISION_CANDIDATES);
            }

            VarType::basic(ty, flags)
        }
    }

    /// `RandomUniformBlockCase::generateUniform`
    fn generate_uniform(&mut self, interface: &mut ShaderInterface, rnd: &mut Random, block: &mut UniformBlock) {
        const UNUSED_VTX_WEIGHT: f32 = 0.15;
        const UNUSED_FRAG_WEIGHT: f32 = 0.15;
        let unused_ok = self.has(FEATURE_UNUSED_UNIFORMS);
        let name = gen_name(b'a', b'z', self.uniform_ndx);
        let ty = self.generate_type(interface, rnd, 0, true);

        let mut flags = 0;
        if unused_ok && rnd.get_float() < UNUSED_VTX_WEIGHT {
            flags |= UNUSED_VERTEX;
        }
        if unused_ok && rnd.get_float() < UNUSED_FRAG_WEIGHT {
            flags |= UNUSED_FRAGMENT;
        }

        block.add_uniform(Uniform::new(&name, ty, flags));
        self.uniform_ndx += 1;
    }

    /// `RandomUniformBlockCase::generateBlock`
    fn generate_block(&mut self, interface: &mut ShaderInterface, rnd: &mut Random, layout_flags: u32) {
        const INSTANCE_ARRAY_WEIGHT: f32 = 0.3;

        let mut block = UniformBlock::new(&format!("Block{}", (b'A' + self.block_ndx as u8) as char));
        let num_instances = if self.max_instances > 0 && rnd.get_float() < INSTANCE_ARRAY_WEIGHT {
            rnd.get_int(0, self.max_instances)
        } else {
            0
        };
        let num_uniforms = rnd.get_int(1, self.max_block_members);

        if num_instances > 0 {
            block.array_size = num_instances;
        }

        if num_instances > 0 || rnd.get_bool() {
            block.instance_name = Some(format!("block{}", (b'A' + self.block_ndx as u8) as char));
        }

        // Layout flag candidates.
        let mut layout_flag_candidates = vec![0];
        if self.has(FEATURE_PACKED_LAYOUT) {
            layout_flag_candidates.push(LAYOUT_SHARED);
        }
        if self.has(FEATURE_SHARED_LAYOUT) && (layout_flags & DECLARE_BOTH) != DECLARE_BOTH {
            // \note packed layout can only be used in a single shader stage.
            layout_flag_candidates.push(LAYOUT_PACKED);
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

        for _ in 0..num_uniforms {
            self.generate_uniform(interface, rnd, &mut block);
        }

        interface.add_block(block);
        self.block_ndx += 1;
    }
}

/// `RandomUniformBlockCase::init`
pub fn generate_interface(features: u32, seed: u32) -> ShaderInterface {
    let max_vertex_blocks = if features & FEATURE_VERTEX_BLOCKS != 0 { 4 } else { 0 };
    let max_fragment_blocks = if features & FEATURE_FRAGMENT_BLOCKS != 0 { 4 } else { 0 };
    let max_shared_blocks = if features & FEATURE_SHARED_BLOCKS != 0 { 4 } else { 0 };

    let mut generator = Generator {
        features,
        max_instances: if features & FEATURE_INSTANCE_ARRAYS != 0 { 3 } else { 0 },
        max_array_length: if features & FEATURE_ARRAYS != 0 { 8 } else { 0 },
        max_struct_depth: if features & FEATURE_STRUCTS != 0 { 2 } else { 0 },
        max_block_members: 5,
        max_struct_members: 4,
        block_ndx: 1,
        uniform_ndx: 1,
        struct_ndx: 1,
    };

    let mut interface = ShaderInterface::default();
    let mut rnd = Random::new(seed);

    let num_shared = if max_shared_blocks > 0 {
        rnd.get_int(1, max_shared_blocks)
    } else {
        0
    };
    let num_vtx_blocks = if max_vertex_blocks - num_shared > 0 {
        rnd.get_int(1, max_vertex_blocks - num_shared)
    } else {
        0
    };
    let num_frag_blocks = if max_fragment_blocks - num_shared > 0 {
        rnd.get_int(1, max_fragment_blocks - num_shared)
    } else {
        0
    };

    for _ in 0..num_shared {
        generator.generate_block(&mut interface, &mut rnd, DECLARE_VERTEX | DECLARE_FRAGMENT);
    }
    for _ in 0..num_vtx_blocks {
        generator.generate_block(&mut interface, &mut rnd, DECLARE_VERTEX);
    }
    for _ in 0..num_frag_blocks {
        generator.generate_block(&mut interface, &mut rnd, DECLARE_FRAGMENT);
    }

    interface
}
