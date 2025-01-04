// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsUniformBlockCase.hpp / .cpp  (gls::UniformBlockCase, gls::ub::)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2012 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `iterate`'s `map<int, void*>` into one
// flat byte vector becomes one `Vec<u8>` per block, which is the same regions by another
// name; the single-buffer mode still packs them into one allocation, because that mode
// exists to exercise `glBindBufferRange` at the driver's own offset alignment. Upstream's
// own `ub::VarType`/`ub::StructType` are kept separate from `glu::VarType` exactly as
// upstream keeps them (its own `\todo` says they should be merged, and they are not): the
// layout and unused-in-shader flags live on the type here and nowhere else.

use std::collections::BTreeSet;
use std::fmt::Write as _;
use std::sync::Arc;

use crate::glu::shader_util::{DataType, get_data_type_float_vec, get_data_type_from_gl_type};
use crate::glu::{self, Context, GlslVersion, ProgramSources, ShaderProgram, TestCase};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::random::de_string_hash;
use crate::tcu::rgba::RGBA;
use crate::tcu::{Random, Surface, TestError, TestOutcome, TestStatus};

/// One `uint32_t`, the unit every std140 offset and stride here is counted in.
const COMP_SIZE: i32 = 4;
const VEC4_ALIGNMENT: i32 = COMP_SIZE * 4;

// `ub::UniformFlags`
pub const PRECISION_LOW: u32 = 1 << 0;
pub const PRECISION_MEDIUM: u32 = 1 << 1;
pub const PRECISION_HIGH: u32 = 1 << 2;
pub const PRECISION_MASK: u32 = PRECISION_LOW | PRECISION_MEDIUM | PRECISION_HIGH;

pub const LAYOUT_SHARED: u32 = 1 << 3;
pub const LAYOUT_PACKED: u32 = 1 << 4;
pub const LAYOUT_STD140: u32 = 1 << 5;
pub const LAYOUT_ROW_MAJOR: u32 = 1 << 6;
/// \note Lack of both flags means column-major matrix.
pub const LAYOUT_COLUMN_MAJOR: u32 = 1 << 7;
pub const LAYOUT_MASK: u32 = LAYOUT_SHARED | LAYOUT_PACKED | LAYOUT_STD140 | LAYOUT_ROW_MAJOR | LAYOUT_COLUMN_MAJOR;

pub const DECLARE_VERTEX: u32 = 1 << 8;
pub const DECLARE_FRAGMENT: u32 = 1 << 9;
pub const DECLARE_BOTH: u32 = DECLARE_VERTEX | DECLARE_FRAGMENT;

/// Uniform or struct member is not read in vertex shader.
pub const UNUSED_VERTEX: u32 = 1 << 10;
/// Uniform or struct member is not read in fragment shader.
pub const UNUSED_FRAGMENT: u32 = 1 << 11;
pub const UNUSED_BOTH: u32 = UNUSED_VERTEX | UNUSED_FRAGMENT;

/// `ub::VarType`
#[derive(Clone, Debug)]
pub enum VarType {
    Basic(DataType, u32),
    Array(Box<VarType>, i32),
    Struct(Arc<StructType>, u32),
}

impl VarType {
    pub fn basic(basic_type: DataType, flags: u32) -> Self {
        Self::Basic(basic_type, flags)
    }

    pub fn array(element_type: VarType, array_size: i32) -> Self {
        Self::Array(Box::new(element_type), array_size)
    }

    pub fn structure(struct_ptr: &Arc<StructType>, flags: u32) -> Self {
        Self::Struct(Arc::clone(struct_ptr), flags)
    }

    pub fn is_basic_type(&self) -> bool {
        matches!(self, Self::Basic(..))
    }

    pub fn is_array_type(&self) -> bool {
        matches!(self, Self::Array(..))
    }

    pub fn is_struct_type(&self) -> bool {
        matches!(self, Self::Struct(..))
    }

    /// `VarType::getFlags`. An array type carries none of its own upstream either.
    pub fn flags(&self) -> u32 {
        match self {
            Self::Basic(_, flags) | Self::Struct(_, flags) => *flags,
            Self::Array(..) => 0,
        }
    }

    pub fn basic_type(&self) -> DataType {
        match self {
            Self::Basic(ty, _) => *ty,
            _ => panic!("not a basic type"),
        }
    }

    pub fn element_type(&self) -> &VarType {
        match self {
            Self::Array(elem, _) => elem,
            _ => panic!("not an array type"),
        }
    }

    pub fn array_size(&self) -> i32 {
        match self {
            Self::Array(_, size) => *size,
            _ => panic!("not an array type"),
        }
    }

    pub fn struct_type(&self) -> &Arc<StructType> {
        match self {
            Self::Struct(s, _) => s,
            _ => panic!("not a struct type"),
        }
    }
}

/// `ub::StructMember`
#[derive(Clone, Debug)]
pub struct StructMember {
    pub name: String,
    pub ty: VarType,
    pub flags: u32,
}

/// `ub::StructType`
#[derive(Clone, Debug)]
pub struct StructType {
    pub type_name: String,
    pub members: Vec<StructMember>,
}

impl StructType {
    pub fn new(type_name: &str) -> Self {
        Self {
            type_name: type_name.to_string(),
            members: Vec::new(),
        }
    }

    /// `StructType::getTypeName` - upstream answers null for an anonymous struct.
    pub fn type_name(&self) -> Option<&str> {
        (!self.type_name.is_empty()).then_some(self.type_name.as_str())
    }

    pub fn add_member(&mut self, name: &str, ty: VarType, flags: u32) {
        self.members.push(StructMember {
            name: name.to_string(),
            ty,
            flags,
        });
    }
}

/// `ub::Uniform`
#[derive(Clone, Debug)]
pub struct Uniform {
    pub name: String,
    pub ty: VarType,
    pub flags: u32,
}

impl Uniform {
    pub fn new(name: &str, ty: VarType, flags: u32) -> Self {
        Self {
            name: name.to_string(),
            ty,
            flags,
        }
    }
}

/// `ub::UniformBlock`
#[derive(Clone, Debug)]
pub struct UniformBlock {
    pub block_name: String,
    pub instance_name: Option<String>,
    pub uniforms: Vec<Uniform>,
    /// Array size, or 0 if not an interface block array.
    pub array_size: i32,
    pub flags: u32,
}

impl UniformBlock {
    pub fn new(block_name: &str) -> Self {
        Self {
            block_name: block_name.to_string(),
            instance_name: None,
            uniforms: Vec::new(),
            array_size: 0,
            flags: 0,
        }
    }

    pub fn is_array(&self) -> bool {
        self.array_size > 0
    }

    pub fn add_uniform(&mut self, uniform: Uniform) {
        self.uniforms.push(uniform);
    }
}

/// `ub::ShaderInterface`
#[derive(Default, Debug)]
pub struct ShaderInterface {
    structs: Vec<Arc<StructType>>,
    blocks: Vec<UniformBlock>,
}

impl ShaderInterface {
    /// `ShaderInterface::allocStruct`, less the interior mutability - the struct is
    /// filled in before it is handed over rather than after.
    pub fn add_struct(&mut self, struct_type: StructType) -> Arc<StructType> {
        let struct_type = Arc::new(struct_type);
        self.structs.push(Arc::clone(&struct_type));
        struct_type
    }

    /// `ShaderInterface::findStruct`
    pub fn find_struct(&self, name: &str) -> Option<&Arc<StructType>> {
        self.structs.iter().find(|s| s.type_name() == Some(name))
    }

    /// `ShaderInterface::allocBlock`
    pub fn add_block(&mut self, block: UniformBlock) {
        self.blocks.push(block);
    }

    pub fn blocks(&self) -> &[UniformBlock] {
        &self.blocks
    }

    /// `ShaderInterface::getNamedStructs`
    pub fn named_structs(&self) -> impl Iterator<Item = &Arc<StructType>> {
        self.structs.iter().filter(|s| s.type_name().is_some())
    }
}

/// `BlockLayoutEntry`
#[derive(Clone, Debug, Default)]
struct BlockLayoutEntry {
    name: String,
    size: i32,
    active_uniform_indices: Vec<i32>,
}

/// `UniformLayoutEntry`
#[derive(Clone, Debug)]
struct UniformLayoutEntry {
    name: String,
    ty: DataType,
    size: i32,
    block_ndx: i32,
    offset: i32,
    array_stride: i32,
    matrix_stride: i32,
    is_row_major: bool,
}

impl Default for UniformLayoutEntry {
    fn default() -> Self {
        Self {
            name: String::new(),
            ty: DataType::Invalid,
            size: 0,
            block_ndx: -1,
            offset: -1,
            array_stride: -1,
            matrix_stride: -1,
            is_row_major: false,
        }
    }
}

/// `UniformLayout`
#[derive(Default, Debug)]
struct UniformLayout {
    blocks: Vec<BlockLayoutEntry>,
    uniforms: Vec<UniformLayoutEntry>,
}

impl UniformLayout {
    fn uniform_index(&self, name: &str) -> Option<usize> {
        self.uniforms.iter().position(|entry| entry.name == name)
    }

    fn block_index(&self, name: &str) -> Option<usize> {
        self.blocks.iter().position(|entry| entry.name == name)
    }
}

/// `PrecisionFlagsFmt`
fn precision_flags_str(flags: u32) -> &'static str {
    if flags & PRECISION_LOW != 0 {
        "lowp"
    } else if flags & PRECISION_MEDIUM != 0 {
        "mediump"
    } else if flags & PRECISION_HIGH != 0 {
        "highp"
    } else {
        ""
    }
}

/// `LayoutFlagsFmt`
fn layout_flags_str(flags: u32) -> String {
    const BIT_DESC: [(u32, &str); 5] = [
        (LAYOUT_SHARED, "shared"),
        (LAYOUT_PACKED, "packed"),
        (LAYOUT_STD140, "std140"),
        (LAYOUT_ROW_MAJOR, "row_major"),
        (LAYOUT_COLUMN_MAJOR, "column_major"),
    ];

    let tokens: Vec<&str> = BIT_DESC
        .iter()
        .filter(|(bit, _)| flags & bit != 0)
        .map(|(_, token)| *token)
        .collect();
    tokens.join(", ")
}

/// `getDataTypeByteSize`
fn data_type_byte_size(ty: DataType) -> i32 {
    ty.scalar_size() * COMP_SIZE
}

/// `getDataTypeByteAlignment`
fn data_type_byte_alignment(ty: DataType) -> i32 {
    match ty {
        DataType::Float | DataType::Int | DataType::Uint | DataType::Bool => COMP_SIZE,
        DataType::FloatVec2 | DataType::IntVec2 | DataType::UintVec2 | DataType::BoolVec2 => 2 * COMP_SIZE,
        // vec3 falls through to vec4.
        _ => 4 * COMP_SIZE,
    }
}

/// `getDataTypeArrayStride`
fn data_type_array_stride(ty: DataType) -> i32 {
    debug_assert!(!ty.is_matrix());
    data_type_byte_size(ty).max(VEC4_ALIGNMENT) // Really? See rule 4.
}

/// `deRoundUp32` / `deAlign32` - both round `value` up to a multiple of `alignment`.
fn round_up(value: i32, alignment: i32) -> i32 {
    if alignment == 0 {
        value
    } else {
        (value + alignment - 1) / alignment * alignment
    }
}

/// `computeStd140BaseAlignment`
fn compute_std140_base_alignment(ty: &VarType) -> i32 {
    match ty {
        VarType::Basic(basic_type, flags) => {
            if basic_type.is_matrix() {
                let is_row_major = flags & LAYOUT_ROW_MAJOR != 0;
                let vec_size = if is_row_major {
                    basic_type.matrix_num_columns()
                } else {
                    basic_type.matrix_num_rows()
                };
                data_type_array_stride(get_data_type_float_vec(vec_size))
            } else {
                data_type_byte_alignment(*basic_type)
            }
        }
        VarType::Array(elem, _) => {
            // Round up to alignment of vec4.
            round_up(compute_std140_base_alignment(elem), VEC4_ALIGNMENT)
        }
        VarType::Struct(struct_type, _) => {
            let max_base_alignment = struct_type
                .members
                .iter()
                .map(|member| compute_std140_base_alignment(&member.ty))
                .max()
                .unwrap_or(0);
            round_up(max_base_alignment, VEC4_ALIGNMENT)
        }
    }
}

/// `mergeLayoutFlags`
fn merge_layout_flags(prev_flags: u32, new_flags: u32) -> u32 {
    const PACKING_MASK: u32 = LAYOUT_PACKED | LAYOUT_SHARED | LAYOUT_STD140;
    const MATRIX_MASK: u32 = LAYOUT_ROW_MAJOR | LAYOUT_COLUMN_MAJOR;

    let packing = if new_flags & PACKING_MASK != 0 {
        new_flags
    } else {
        prev_flags
    } & PACKING_MASK;
    let matrix = if new_flags & MATRIX_MASK != 0 {
        new_flags
    } else {
        prev_flags
    } & MATRIX_MASK;
    packing | matrix
}

/// `computeStd140Layout(UniformLayout&, int&, int, const string&, const VarType&, uint32_t)`
fn compute_std140_layout_type(
    layout: &mut UniformLayout,
    cur_offset: &mut i32,
    cur_block_ndx: i32,
    cur_prefix: &str,
    ty: &VarType,
    layout_flags: u32,
) {
    let base_alignment = compute_std140_base_alignment(ty);
    *cur_offset = round_up(*cur_offset, base_alignment);

    match ty {
        VarType::Basic(basic_type, flags) => {
            let mut entry = UniformLayoutEntry {
                name: cur_prefix.to_string(),
                ty: *basic_type,
                size: 1,
                array_stride: 0,
                matrix_stride: 0,
                block_ndx: cur_block_ndx,
                ..Default::default()
            };

            if basic_type.is_matrix() {
                // Array of vectors as specified in rules 5 & 7.
                let effective = if flags & (LAYOUT_ROW_MAJOR | LAYOUT_COLUMN_MAJOR) != 0 {
                    *flags
                } else {
                    layout_flags
                };
                let is_row_major = effective & LAYOUT_ROW_MAJOR != 0;
                let vec_size = if is_row_major {
                    basic_type.matrix_num_columns()
                } else {
                    basic_type.matrix_num_rows()
                };
                let num_vecs = if is_row_major {
                    basic_type.matrix_num_rows()
                } else {
                    basic_type.matrix_num_columns()
                };
                let stride = data_type_array_stride(get_data_type_float_vec(vec_size));

                entry.offset = *cur_offset;
                entry.matrix_stride = stride;
                entry.is_row_major = is_row_major;

                *cur_offset += num_vecs * stride;
            } else {
                // Scalar or vector.
                entry.offset = *cur_offset;
                *cur_offset += data_type_byte_size(*basic_type);
            }

            layout.uniforms.push(entry);
        }
        VarType::Array(elem_type, array_size) => match &**elem_type {
            VarType::Basic(elem_basic_type, elem_flags) if !elem_basic_type.is_matrix() => {
                // Array of scalars or vectors.
                let stride = data_type_array_stride(*elem_basic_type);
                let _ = elem_flags;

                layout.uniforms.push(UniformLayoutEntry {
                    // Array uniforms are always postfixed with [0].
                    name: format!("{cur_prefix}[0]"),
                    ty: *elem_basic_type,
                    block_ndx: cur_block_ndx,
                    offset: *cur_offset,
                    size: *array_size,
                    array_stride: stride,
                    matrix_stride: 0,
                    is_row_major: false,
                });

                *cur_offset += stride * array_size;
            }
            VarType::Basic(elem_basic_type, elem_flags) => {
                // Array of matrices.
                let effective = if elem_flags & (LAYOUT_ROW_MAJOR | LAYOUT_COLUMN_MAJOR) != 0 {
                    *elem_flags
                } else {
                    layout_flags
                };
                let is_row_major = effective & LAYOUT_ROW_MAJOR != 0;
                let vec_size = if is_row_major {
                    elem_basic_type.matrix_num_columns()
                } else {
                    elem_basic_type.matrix_num_rows()
                };
                let num_vecs = if is_row_major {
                    elem_basic_type.matrix_num_rows()
                } else {
                    elem_basic_type.matrix_num_columns()
                };
                let stride = data_type_array_stride(get_data_type_float_vec(vec_size));

                layout.uniforms.push(UniformLayoutEntry {
                    name: format!("{cur_prefix}[0]"),
                    ty: *elem_basic_type,
                    block_ndx: cur_block_ndx,
                    offset: *cur_offset,
                    size: *array_size,
                    array_stride: stride * num_vecs,
                    matrix_stride: stride,
                    is_row_major,
                });

                *cur_offset += num_vecs * array_size * stride;
            }
            _ => {
                for elem_ndx in 0..*array_size {
                    compute_std140_layout_type(
                        layout,
                        cur_offset,
                        cur_block_ndx,
                        &format!("{cur_prefix}[{elem_ndx}]"),
                        elem_type,
                        layout_flags,
                    );
                }
            }
        },
        VarType::Struct(struct_type, flags) => {
            // Override matrix packing layout flags in case the structure has them defined.
            const MATRIX_LAYOUT_MASK: u32 = LAYOUT_ROW_MAJOR | LAYOUT_COLUMN_MAJOR;
            let layout_flags = if flags & MATRIX_LAYOUT_MASK != 0 {
                (layout_flags & !MATRIX_LAYOUT_MASK) | (flags & MATRIX_LAYOUT_MASK)
            } else {
                layout_flags
            };

            for member in &struct_type.members {
                compute_std140_layout_type(
                    layout,
                    cur_offset,
                    cur_block_ndx,
                    &format!("{cur_prefix}.{}", member.name),
                    &member.ty,
                    layout_flags,
                );
            }

            *cur_offset = round_up(*cur_offset, base_alignment);
        }
    }
}

/// `computeStd140Layout(UniformLayout&, const ShaderInterface&)`
fn compute_std140_layout(interface: &ShaderInterface) -> UniformLayout {
    let mut layout = UniformLayout::default();

    for block in interface.blocks() {
        let has_instance_name = block.instance_name.is_some();
        let block_prefix = if has_instance_name {
            format!("{}.", block.block_name)
        } else {
            String::new()
        };
        let mut cur_offset = 0;
        let active_block_ndx = layout.blocks.len() as i32;
        let first_uniform_ndx = layout.uniforms.len() as i32;

        for uniform in &block.uniforms {
            compute_std140_layout_type(
                &mut layout,
                &mut cur_offset,
                active_block_ndx,
                &format!("{block_prefix}{}", uniform.name),
                &uniform.ty,
                merge_layout_flags(block.flags, uniform.flags),
            );
        }

        let uniform_indices_end = layout.uniforms.len() as i32;
        let block_size = cur_offset;
        let num_instances = if block.is_array() { block.array_size } else { 1 };

        // Create block layout entries for each instance.
        for instance_ndx in 0..num_instances {
            let name = if block.is_array() {
                format!("{}[{instance_ndx}]", block.block_name)
            } else {
                block.block_name.clone()
            };
            layout.blocks.push(BlockLayoutEntry {
                name,
                size: block_size,
                active_uniform_indices: (first_uniform_ndx..uniform_indices_end).collect(),
            });
        }
    }

    layout
}

/// `generateValue`
fn generate_value(entry: &UniformLayoutEntry, block: &mut [u8], rnd: &mut Random) {
    let scalar_type = entry.ty.scalar_type();
    let scalar_size = entry.ty.scalar_size();
    let is_matrix = entry.ty.is_matrix();
    let num_vecs = if is_matrix {
        if entry.is_row_major {
            entry.ty.matrix_num_rows()
        } else {
            entry.ty.matrix_num_columns()
        }
    } else {
        1
    };
    let vec_size = scalar_size / num_vecs;
    let is_array = entry.size > 1;

    for elem_ndx in 0..entry.size {
        let elem_at = entry.offset + if is_array { elem_ndx * entry.array_stride } else { 0 };

        for vec_ndx in 0..num_vecs {
            let vec_at = elem_at + if is_matrix { vec_ndx * entry.matrix_stride } else { 0 };

            for comp_ndx in 0..vec_size {
                let at = (vec_at + COMP_SIZE * comp_ndx) as usize;
                let word = match scalar_type {
                    DataType::Float => (rnd.get_int(-9, 9) as f32).to_bits(),
                    DataType::Int => rnd.get_int(-9, 9) as u32,
                    DataType::Uint => rnd.get_int(0, 9) as u32,
                    // \note Random bit pattern is used for true values. Spec states that
                    // all non-zero values are interpreted as true but some
                    // implementations fail this.
                    _ => {
                        if rnd.get_bool() {
                            rnd.get_uint32() | 1
                        } else {
                            0
                        }
                    }
                };
                block[at..at + 4].copy_from_slice(&word.to_ne_bytes());
            }
        }
    }
}

/// `generateValues`
fn generate_values(layout: &UniformLayout, block_data: &mut [Vec<u8>], seed: u32) {
    let mut rnd = Random::new(seed);

    for (block_ndx, block) in layout.blocks.iter().enumerate() {
        for entry_ndx in &block.active_uniform_indices {
            generate_value(
                &layout.uniforms[*entry_ndx as usize],
                &mut block_data[block_ndx],
                &mut rnd,
            );
        }
    }
}

/// `getCompareFuncForType`. \note The parameters are `highp` here, unlike the otherwise
/// identical table in `gls::uniform_api_case`.
fn compare_func_for_type(ty: DataType) -> &'static str {
    match ty {
        DataType::Float => {
            "mediump float compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05 ? 1.0 : 0.0; }\n"
        }
        DataType::FloatVec2 => {
            "mediump float compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y); }\n"
        }
        DataType::FloatVec3 => {
            "mediump float compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z); }\n"
        }
        DataType::FloatVec4 => {
            "mediump float compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)*compare_float(a.y, b.y)*compare_float(a.z, b.z)*compare_float(a.w, b.w); }\n"
        }
        DataType::FloatMat2 => {
            "mediump float compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1]); }\n"
        }
        DataType::FloatMat2x3 => {
            "mediump float compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1]); }\n"
        }
        DataType::FloatMat2x4 => {
            "mediump float compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1]); }\n"
        }
        DataType::FloatMat3x2 => {
            "mediump float compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2]); }\n"
        }
        DataType::FloatMat3 => {
            "mediump float compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2]); }\n"
        }
        DataType::FloatMat3x4 => {
            "mediump float compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2]); }\n"
        }
        DataType::FloatMat4x2 => {
            "mediump float compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])*compare_vec2(a[1], b[1])*compare_vec2(a[2], b[2])*compare_vec2(a[3], b[3]); }\n"
        }
        DataType::FloatMat4x3 => {
            "mediump float compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])*compare_vec3(a[1], b[1])*compare_vec3(a[2], b[2])*compare_vec3(a[3], b[3]); }\n"
        }
        DataType::FloatMat4 => {
            "mediump float compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])*compare_vec4(a[1], b[1])*compare_vec4(a[2], b[2])*compare_vec4(a[3], b[3]); }\n"
        }
        DataType::Int => {
            "mediump float compare_int      (highp int a, highp int b)      { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::IntVec2 => {
            "mediump float compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::IntVec3 => {
            "mediump float compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::IntVec4 => {
            "mediump float compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::Uint => {
            "mediump float compare_uint     (highp uint a, highp uint b)    { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::UintVec2 => {
            "mediump float compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::UintVec3 => {
            "mediump float compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::UintVec4 => {
            "mediump float compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::Bool => {
            "mediump float compare_bool     (bool a, bool b)                { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::BoolVec2 => {
            "mediump float compare_bvec2    (bvec2 a, bvec2 b)              { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::BoolVec3 => {
            "mediump float compare_bvec3    (bvec3 a, bvec3 b)              { return a == b ? 1.0 : 0.0; }\n"
        }
        DataType::BoolVec4 => {
            "mediump float compare_bvec4    (bvec4 a, bvec4 b)              { return a == b ? 1.0 : 0.0; }\n"
        }
        _ => "",
    }
}

/// `getCompareDependencies`
fn compare_dependencies(compare_funcs: &mut BTreeSet<usize>, basic_type: DataType) {
    let index_of = |ty: DataType| {
        crate::glu::shader_util::ALL_DATA_TYPES
            .iter()
            .position(|t| *t == ty)
            .unwrap_or(usize::MAX)
    };

    match basic_type {
        DataType::FloatVec2 | DataType::FloatVec3 | DataType::FloatVec4 => {
            compare_funcs.insert(index_of(DataType::Float));
            compare_funcs.insert(index_of(basic_type));
        }
        _ if basic_type.is_matrix() => {
            compare_funcs.insert(index_of(DataType::Float));
            compare_funcs.insert(index_of(get_data_type_float_vec(basic_type.matrix_num_rows())));
            compare_funcs.insert(index_of(basic_type));
        }
        _ => {
            compare_funcs.insert(index_of(basic_type));
        }
    }
}

/// `collectUniqueBasicTypes`
fn collect_unique_basic_types(basic_types: &mut Vec<DataType>, ty: &VarType) {
    match ty {
        VarType::Basic(basic_type, _) => {
            if !basic_types.contains(basic_type) {
                basic_types.push(*basic_type);
            }
        }
        VarType::Array(elem, _) => collect_unique_basic_types(basic_types, elem),
        VarType::Struct(struct_type, _) => {
            for member in &struct_type.members {
                collect_unique_basic_types(basic_types, &member.ty);
            }
        }
    }
}

/// `generateCompareFuncs`
fn generate_compare_funcs(src: &mut String, interface: &ShaderInterface) {
    let mut types = Vec::new();
    for block in interface.blocks() {
        for uniform in &block.uniforms {
            collect_unique_basic_types(&mut types, &uniform.ty);
        }
    }

    // `std::set<glu::DataType>` iterates in enum order, and each function has to be
    // emitted after the ones it calls, so the order here is load-bearing.
    let mut compare_funcs = BTreeSet::new();
    for ty in types {
        compare_dependencies(&mut compare_funcs, ty);
    }

    for ndx in compare_funcs {
        if let Some(ty) = crate::glu::shader_util::ALL_DATA_TYPES.get(ndx) {
            src.push_str(compare_func_for_type(*ty));
        }
    }
}

fn indent(level: i32) -> String {
    "\t".repeat(level.max(0) as usize)
}

/// `generateFullDeclaration`
fn generate_full_declaration(src: &mut String, struct_type: &StructType, indent_level: i32) {
    src.push_str("struct");
    if let Some(type_name) = struct_type.type_name() {
        let _ = write!(src, " {type_name}");
    }
    let _ = write!(src, "\n{}{{\n", indent(indent_level));

    for member in &struct_type.members {
        src.push_str(&indent(indent_level + 1));
        generate_var_declaration(
            src,
            &member.ty,
            &member.name,
            indent_level + 1,
            member.flags & UNUSED_BOTH,
        );
    }

    let _ = write!(src, "{}}}", indent(indent_level));
}

/// `generateLocalDeclaration`
fn generate_local_declaration(src: &mut String, struct_type: &StructType, indent_level: i32) {
    match struct_type.type_name() {
        None => generate_full_declaration(src, struct_type, indent_level),
        Some(type_name) => src.push_str(type_name),
    }
}

/// `generateDeclaration(ostream&, const StructType&, int)`
fn generate_struct_declaration(src: &mut String, struct_type: &StructType, indent_level: i32) {
    generate_full_declaration(src, struct_type, indent_level);
    src.push_str(";\n");
}

/// `generateDeclaration(ostream&, const VarType&, const char*, int, uint32_t)`
fn generate_var_declaration(src: &mut String, ty: &VarType, name: &str, indent_level: i32, unused_hints: u32) {
    let flags = ty.flags();

    if flags & LAYOUT_MASK != 0 {
        let _ = write!(src, "layout({}) ", layout_flags_str(flags & LAYOUT_MASK));
    }
    if flags & PRECISION_MASK != 0 {
        let _ = write!(src, "{} ", precision_flags_str(flags & PRECISION_MASK));
    }

    match ty {
        VarType::Basic(basic_type, _) => {
            let _ = write!(src, "{} {name}", basic_type.name());
        }
        VarType::Array(..) => {
            let mut array_sizes = Vec::new();
            let mut cur_type = ty;
            while cur_type.is_array_type() {
                array_sizes.push(cur_type.array_size());
                cur_type = cur_type.element_type();
            }

            match cur_type {
                VarType::Basic(basic_type, cur_flags) => {
                    if cur_flags & LAYOUT_MASK != 0 {
                        let _ = write!(src, "layout({}) ", layout_flags_str(cur_flags & LAYOUT_MASK));
                    }
                    if cur_flags & PRECISION_MASK != 0 {
                        let _ = write!(src, "{} ", precision_flags_str(cur_flags & PRECISION_MASK));
                    }
                    src.push_str(basic_type.name());
                }
                _ => generate_local_declaration(src, cur_type.struct_type(), indent_level + 1),
            }

            let _ = write!(src, " {name}");
            for size in array_sizes {
                let _ = write!(src, "[{size}]");
            }
        }
        VarType::Struct(struct_type, _) => {
            generate_local_declaration(src, struct_type, indent_level + 1);
            let _ = write!(src, " {name}");
        }
    }

    src.push(';');

    // Print out unused hints.
    if unused_hints != 0 {
        let where_ = if unused_hints == UNUSED_BOTH {
            "both shaders"
        } else if unused_hints == UNUSED_VERTEX {
            "vertex shader"
        } else if unused_hints == UNUSED_FRAGMENT {
            "fragment shader"
        } else {
            "???"
        };
        let _ = write!(src, " // unused in {where_}");
    }

    src.push('\n');
}

/// `generateDeclaration(ostream&, const Uniform&, int)`
fn generate_uniform_declaration(src: &mut String, uniform: &Uniform, indent_level: i32) {
    if uniform.flags & LAYOUT_MASK != 0 {
        let _ = write!(src, "layout({}) ", layout_flags_str(uniform.flags & LAYOUT_MASK));
    }
    generate_var_declaration(
        src,
        &uniform.ty,
        &uniform.name,
        indent_level,
        uniform.flags & UNUSED_BOTH,
    );
}

/// `generateDeclaration(ostream&, const UniformBlock&)`
fn generate_block_declaration(src: &mut String, block: &UniformBlock) {
    if block.flags & LAYOUT_MASK != 0 {
        let _ = write!(src, "layout({}) ", layout_flags_str(block.flags & LAYOUT_MASK));
    }

    let _ = write!(src, "uniform {}\n{{\n", block.block_name);

    for uniform in &block.uniforms {
        src.push_str(&indent(1));
        generate_uniform_declaration(src, uniform, 1);
    }

    src.push('}');

    if let Some(instance_name) = &block.instance_name {
        let _ = write!(src, " {instance_name}");
        if block.is_array() {
            let _ = write!(src, "[{}]", block.array_size);
        }
    }

    src.push_str(";\n");
}

fn read_u32(bytes: &[u8], at: usize) -> u32 {
    u32::from_ne_bytes(bytes[at..at + 4].try_into().expect("four bytes"))
}

/// `generateValueSrc`
fn generate_value_src(src: &mut String, entry: &UniformLayoutEntry, block: &[u8], element_ndx: i32) {
    let scalar_type = entry.ty.scalar_type();
    let scalar_size = entry.ty.scalar_size();
    let is_array = entry.size > 1;
    let elem_at = entry.offset + if is_array { element_ndx * entry.array_stride } else { 0 };

    if scalar_size > 1 {
        let _ = write!(src, "{}(", entry.ty.name());
    }

    if entry.ty.is_matrix() {
        let num_rows = entry.ty.matrix_num_rows();
        let num_cols = entry.ty.matrix_num_columns();

        // Constructed in column-wise order.
        for col_ndx in 0..num_cols {
            for row_ndx in 0..num_rows {
                let at = elem_at
                    + if entry.is_row_major {
                        row_ndx * entry.matrix_stride + col_ndx * COMP_SIZE
                    } else {
                        col_ndx * entry.matrix_stride + row_ndx * COMP_SIZE
                    };

                if col_ndx > 0 || row_ndx > 0 {
                    src.push_str(", ");
                }
                let _ = write!(src, "{:.1}", f32::from_bits(read_u32(block, at as usize)));
            }
        }
    } else {
        for scalar_ndx in 0..scalar_size {
            let at = (elem_at + scalar_ndx * COMP_SIZE) as usize;

            if scalar_ndx > 0 {
                src.push_str(", ");
            }

            let word = read_u32(block, at);
            match scalar_type {
                DataType::Float => {
                    let _ = write!(src, "{:.1}", f32::from_bits(word));
                }
                DataType::Int => {
                    let _ = write!(src, "{}", word as i32);
                }
                DataType::Uint => {
                    let _ = write!(src, "{word}u");
                }
                _ => src.push_str(if word != 0 { "true" } else { "false" }),
            }
        }
    }

    if scalar_size > 1 {
        src.push(')');
    }
}

/// `generateCompareSrc(ostream&, const char*, const VarType&, ...)`
fn generate_compare_src_type(
    src: &mut String,
    ty: &VarType,
    src_name: &str,
    api_name: &str,
    layout: &UniformLayout,
    block: &[u8],
    unused_mask: u32,
) {
    let is_basic_array = ty.is_array_type() && ty.element_type().is_basic_type();

    if ty.is_basic_type() || is_basic_array {
        // Basic type or array of basic types.
        let element_type = if is_basic_array {
            ty.element_type().basic_type()
        } else {
            ty.basic_type()
        };
        let type_name = element_type.name();
        // Arrays are always postfixed with [0].
        let full_api_name = if is_basic_array {
            format!("{api_name}[0]")
        } else {
            api_name.to_string()
        };
        let Some(uniform_ndx) = layout.uniform_index(&full_api_name) else {
            return;
        };
        let entry = &layout.uniforms[uniform_ndx];

        if is_basic_array {
            for elem_ndx in 0..ty.array_size() {
                let _ = write!(src, "\tresult *= compare_{type_name}({src_name}[{elem_ndx}], ");
                generate_value_src(src, entry, block, elem_ndx);
                src.push_str(");\n");
            }
        } else {
            let _ = write!(src, "\tresult *= compare_{type_name}({src_name}, ");
            generate_value_src(src, entry, block, 0);
            src.push_str(");\n");
        }
    } else if ty.is_array_type() {
        for element_ndx in 0..ty.array_size() {
            let op = format!("[{element_ndx}]");
            generate_compare_src_type(
                src,
                ty.element_type(),
                &format!("{src_name}{op}"),
                &format!("{api_name}{op}"),
                layout,
                block,
                unused_mask,
            );
        }
    } else {
        for member in &ty.struct_type().members {
            if member.flags & unused_mask != 0 {
                continue; // Skip member.
            }
            let op = format!(".{}", member.name);
            generate_compare_src_type(
                src,
                &member.ty,
                &format!("{src_name}{op}"),
                &format!("{api_name}{op}"),
                layout,
                block,
                unused_mask,
            );
        }
    }
}

/// `generateCompareSrc(ostream&, const char*, const ShaderInterface&, ...)`
fn generate_compare_src(
    src: &mut String,
    interface: &ShaderInterface,
    layout: &UniformLayout,
    block_data: &[Vec<u8>],
    is_vertex: bool,
) {
    let unused_mask = if is_vertex { UNUSED_VERTEX } else { UNUSED_FRAGMENT };
    let declare_mask = if is_vertex { DECLARE_VERTEX } else { DECLARE_FRAGMENT };

    for block in interface.blocks() {
        if block.flags & declare_mask == 0 {
            continue; // Skip.
        }

        let has_instance_name = block.instance_name.is_some();
        let is_array = block.is_array();
        let num_instances = if is_array { block.array_size } else { 1 };
        let api_prefix = if has_instance_name {
            format!("{}.", block.block_name)
        } else {
            String::new()
        };

        for instance_ndx in 0..num_instances {
            let instance_postfix = if is_array {
                format!("[{instance_ndx}]")
            } else {
                String::new()
            };
            let block_instance_name = format!("{}{instance_postfix}", block.block_name);
            let src_prefix = match &block.instance_name {
                Some(instance_name) => format!("{instance_name}{instance_postfix}."),
                None => String::new(),
            };
            let Some(active_block_ndx) = layout.block_index(&block_instance_name) else {
                continue;
            };

            for uniform in &block.uniforms {
                if uniform.flags & unused_mask != 0 {
                    continue; // Don't read from that uniform.
                }
                generate_compare_src_type(
                    src,
                    &uniform.ty,
                    &format!("{src_prefix}{}", uniform.name),
                    &format!("{api_prefix}{}", uniform.name),
                    layout,
                    &block_data[active_block_ndx],
                    unused_mask,
                );
            }
        }
    }
}

/// `generateVertexShader`
fn generate_vertex_shader(
    glsl_version: GlslVersion,
    interface: &ShaderInterface,
    layout: &UniformLayout,
    block_data: &[Vec<u8>],
) -> String {
    let mut src = format!(
        "{}\nin highp vec4 a_position;\nout mediump float v_vtxResult;\n\n",
        glsl_version.declaration()
    );

    for struct_type in interface.named_structs() {
        generate_struct_declaration(&mut src, struct_type, 0);
    }

    for block in interface.blocks() {
        if block.flags & DECLARE_VERTEX != 0 {
            generate_block_declaration(&mut src, block);
        }
    }

    // Comparison utilities.
    src.push('\n');
    generate_compare_funcs(&mut src, interface);

    src.push_str("\nvoid main (void)\n{\n    gl_Position = a_position;\n    mediump float result = 1.0;\n");
    generate_compare_src(&mut src, interface, layout, block_data, true);
    src.push_str("    v_vtxResult = result;\n}\n");

    src
}

/// `generateFragmentShader`
fn generate_fragment_shader(
    glsl_version: GlslVersion,
    interface: &ShaderInterface,
    layout: &UniformLayout,
    block_data: &[Vec<u8>],
) -> String {
    let mut src = format!(
        "{}\nin mediump float v_vtxResult;\nlayout(location = 0) out mediump vec4 dEQP_FragColor;\n\n",
        glsl_version.declaration()
    );

    for struct_type in interface.named_structs() {
        generate_struct_declaration(&mut src, struct_type, 0);
    }

    for block in interface.blocks() {
        if block.flags & DECLARE_FRAGMENT != 0 {
            generate_block_declaration(&mut src, block);
        }
    }

    // Comparison utilities.
    src.push('\n');
    generate_compare_funcs(&mut src, interface);

    src.push_str("\nvoid main (void)\n{\n    mediump float result = 1.0;\n");
    generate_compare_src(&mut src, interface, layout, block_data, false);
    src.push_str("    dEQP_FragColor = vec4(1.0, v_vtxResult, result, 1.0);\n}\n");

    src
}

/// `getGLUniformLayout`
fn get_gl_uniform_layout(gl: &glw::Functions, program: GLuint) -> Result<UniformLayout, TestError> {
    let mut layout = UniformLayout::default();
    let mut num_active_uniforms = 0;
    let mut num_active_blocks = 0;

    // SAFETY: each query writes one integer, and every buffer below is sized from the
    // driver's own answer to the corresponding length query.
    unsafe {
        gl.get_programiv(program, glw::GL_ACTIVE_UNIFORMS, &mut num_active_uniforms);
        gl.get_programiv(program, glw::GL_ACTIVE_UNIFORM_BLOCKS, &mut num_active_blocks);
    }
    glu::expect_no_error(gl, "Failed to get number of uniforms and uniform blocks")?;

    // Block entries.
    for block_ndx in 0..num_active_blocks {
        let mut size = 0;
        let mut name_len = 0;
        let mut num_block_uniforms = 0;

        // SAFETY: as above.
        unsafe {
            gl.get_active_uniform_blockiv(program, block_ndx as GLuint, glw::GL_UNIFORM_BLOCK_DATA_SIZE, &mut size);
            gl.get_active_uniform_blockiv(
                program,
                block_ndx as GLuint,
                glw::GL_UNIFORM_BLOCK_NAME_LENGTH,
                &mut name_len,
            );
            gl.get_active_uniform_blockiv(
                program,
                block_ndx as GLuint,
                glw::GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS,
                &mut num_block_uniforms,
            );
        }
        glu::expect_no_error(gl, "Uniform block query failed")?;

        // \note Some implementations incorrectly return 0 as name length even though the
        // length should include null terminator.
        let mut name_buf = vec![0u8; name_len.max(1) as usize];
        let mut active_uniform_indices = vec![0i32; num_block_uniforms.max(0) as usize];

        // SAFETY: as above.
        unsafe {
            gl.get_active_uniform_block_name(
                program,
                block_ndx as GLuint,
                name_buf.len() as i32,
                std::ptr::null_mut(),
                name_buf.as_mut_ptr().cast(),
            );
            if num_block_uniforms > 0 {
                gl.get_active_uniform_blockiv(
                    program,
                    block_ndx as GLuint,
                    glw::GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES,
                    active_uniform_indices.as_mut_ptr(),
                );
            }
        }
        glu::expect_no_error(gl, "Uniform block query failed")?;

        let nul = name_buf.iter().position(|b| *b == 0).unwrap_or(name_buf.len());
        layout.blocks.push(BlockLayoutEntry {
            name: String::from_utf8_lossy(&name_buf[..nul]).into_owned(),
            size,
            active_uniform_indices,
        });
    }

    if num_active_uniforms > 0 {
        let count = num_active_uniforms as usize;
        let uniform_indices: Vec<GLuint> = (0..count as GLuint).collect();
        let query = |pname: GLenum| -> Result<Vec<i32>, TestError> {
            let mut out = vec![0i32; count];
            // SAFETY: the output holds one integer per index handed in.
            unsafe {
                gl.get_active_uniformsiv(program, count as i32, uniform_indices.as_ptr(), pname, out.as_mut_ptr())
            };
            Ok(out)
        };

        let types = query(glw::GL_UNIFORM_TYPE)?;
        let sizes = query(glw::GL_UNIFORM_SIZE)?;
        let name_lengths = query(glw::GL_UNIFORM_NAME_LENGTH)?;
        let block_indices = query(glw::GL_UNIFORM_BLOCK_INDEX)?;
        let offsets = query(glw::GL_UNIFORM_OFFSET)?;
        let array_strides = query(glw::GL_UNIFORM_ARRAY_STRIDE)?;
        let matrix_strides = query(glw::GL_UNIFORM_MATRIX_STRIDE)?;
        let row_major_flags = query(glw::GL_UNIFORM_IS_ROW_MAJOR)?;
        glu::expect_no_error(gl, "Active uniform query failed")?;

        for uniform_ndx in 0..count {
            let mut name_buf = vec![0u8; name_lengths[uniform_ndx].max(1) as usize];
            let mut name_len = 0;
            let mut size = 0;
            let mut ty = glw::GL_NONE;

            // SAFETY: as above.
            unsafe {
                gl.get_active_uniform(
                    program,
                    uniform_ndx as GLuint,
                    name_buf.len() as i32,
                    &mut name_len,
                    &mut size,
                    &mut ty,
                    name_buf.as_mut_ptr().cast(),
                );
            }
            glu::expect_no_error(gl, "Uniform name query failed")?;

            // \note glGetActiveUniform() returns length without \0 and
            // glGetActiveUniformsiv() with \0.
            if name_len + 1 != name_lengths[uniform_ndx]
                || size != sizes[uniform_ndx]
                || ty as i32 != types[uniform_ndx]
            {
                return Err(TestError::Fail(
                    "Values returned by glGetActiveUniform() don't match with values queried with glGetActiveUniformsiv().".to_string(),
                ));
            }

            let nul = name_buf.iter().position(|b| *b == 0).unwrap_or(name_buf.len());
            layout.uniforms.push(UniformLayoutEntry {
                name: String::from_utf8_lossy(&name_buf[..nul]).into_owned(),
                ty: get_data_type_from_gl_type(types[uniform_ndx] as GLenum),
                size: sizes[uniform_ndx],
                block_ndx: block_indices[uniform_ndx],
                offset: offsets[uniform_ndx],
                array_stride: array_strides[uniform_ndx],
                matrix_stride: matrix_strides[uniform_ndx],
                is_row_major: row_major_flags[uniform_ndx] != glw::GL_FALSE as i32,
            });
        }
    }

    Ok(layout)
}

/// `copyUniformData(const UniformLayoutEntry&, void*, const UniformLayoutEntry&, const void*)`
fn copy_uniform_entry(
    dst_entry: &UniformLayoutEntry,
    dst_block: &mut [u8],
    src_entry: &UniformLayoutEntry,
    src_block: &[u8],
) {
    let scalar_size = dst_entry.ty.scalar_size();
    let is_matrix = dst_entry.ty.is_matrix();

    for element_ndx in 0..dst_entry.size {
        let dst_elem = dst_entry.offset + element_ndx * dst_entry.array_stride;
        let src_elem = src_entry.offset + element_ndx * src_entry.array_stride;

        if is_matrix {
            let num_rows = dst_entry.ty.matrix_num_rows();
            let num_cols = dst_entry.ty.matrix_num_columns();

            for col_ndx in 0..num_cols {
                for row_ndx in 0..num_rows {
                    let dst_at = (dst_elem
                        + if dst_entry.is_row_major {
                            row_ndx * dst_entry.matrix_stride + col_ndx * COMP_SIZE
                        } else {
                            col_ndx * dst_entry.matrix_stride + row_ndx * COMP_SIZE
                        }) as usize;
                    let src_at = (src_elem
                        + if src_entry.is_row_major {
                            row_ndx * src_entry.matrix_stride + col_ndx * COMP_SIZE
                        } else {
                            col_ndx * src_entry.matrix_stride + row_ndx * COMP_SIZE
                        }) as usize;
                    dst_block[dst_at..dst_at + 4].copy_from_slice(&src_block[src_at..src_at + 4]);
                }
            }
        } else {
            let len = (scalar_size * COMP_SIZE) as usize;
            let (dst_at, src_at) = (dst_elem as usize, src_elem as usize);
            dst_block[dst_at..dst_at + len].copy_from_slice(&src_block[src_at..src_at + len]);
        }
    }
}

/// `copyUniformData(const UniformLayout&, ..., const UniformLayout&, ...)`
///
/// \note Src layout is used as reference in case of activeUniforms happens to be
/// incorrect in dstLayout blocks.
fn copy_uniform_data(
    dst_layout: &UniformLayout,
    dst_block_data: &mut [Vec<u8>],
    src_layout: &UniformLayout,
    src_block_data: &[Vec<u8>],
) {
    for (src_block_ndx, src_block) in src_layout.blocks.iter().enumerate() {
        let Some(dst_block_ndx) = dst_layout.block_index(&src_block.name) else {
            continue;
        };

        for src_uniform_ndx in &src_block.active_uniform_indices {
            let src_entry = &src_layout.uniforms[*src_uniform_ndx as usize];
            let Some(dst_uniform_ndx) = dst_layout.uniform_index(&src_entry.name) else {
                continue;
            };
            copy_uniform_entry(
                &dst_layout.uniforms[dst_uniform_ndx],
                &mut dst_block_data[dst_block_ndx],
                src_entry,
                &src_block_data[src_block_ndx],
            );
        }
    }
}

/// `UniformBlockCase::BufferMode`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum BufferMode {
    /// Single buffer shared between uniform blocks.
    Single,
    /// Per-block buffers.
    PerBlock,
}

/// `gls::UniformBlockCase`
pub struct UniformBlockCase {
    pub name: String,
    pub glsl_version: GlslVersion,
    pub buffer_mode: BufferMode,
    pub interface: ShaderInterface,
}

impl UniformBlockCase {
    /// `UniformBlockCase::compareStd140Blocks`
    fn compare_std140_blocks(&self, ref_layout: &UniformLayout, cmp_layout: &UniformLayout) -> bool {
        self.compare_blocks(ref_layout, cmp_layout, LAYOUT_STD140, true)
    }

    /// `UniformBlockCase::compareSharedBlocks`
    fn compare_shared_blocks(&self, ref_layout: &UniformLayout, cmp_layout: &UniformLayout) -> bool {
        self.compare_blocks(ref_layout, cmp_layout, LAYOUT_SHARED, false)
    }

    /// The body upstream repeats in `compareStd140Blocks`/`compareSharedBlocks`; the two
    /// differ only in which layout flag selects a block and in whether the offsets and
    /// strides are part of the comparison (a shared block's are the driver's choice).
    fn compare_blocks(
        &self,
        ref_layout: &UniformLayout,
        cmp_layout: &UniformLayout,
        layout_flag: u32,
        check_offsets: bool,
    ) -> bool {
        let mut is_ok = true;

        for block in self.interface.blocks() {
            let instance_name = format!("{}{}", block.block_name, if block.is_array() { "[0]" } else { "" });
            let is_used = block.flags & DECLARE_BOTH != 0;

            if block.flags & layout_flag == 0 {
                continue; // Not this layout.
            }

            let Some(ref_block_ndx) = ref_layout.block_index(&instance_name) else {
                continue;
            };
            let Some(cmp_block_ndx) = cmp_layout.block_index(&instance_name) else {
                // Not found, should it?
                if is_used {
                    log::warn!("Error: Uniform block '{instance_name}' not found");
                    is_ok = false;
                }
                continue; // Skip block.
            };

            let ref_block_layout = &ref_layout.blocks[ref_block_ndx];
            let cmp_block_layout = &cmp_layout.blocks[cmp_block_ndx];

            if ref_block_layout.active_uniform_indices.len() != cmp_block_layout.active_uniform_indices.len() {
                log::warn!(
                    "Error: Number of active uniforms differ in block '{instance_name}' (expected {}, got {})",
                    ref_block_layout.active_uniform_indices.len(),
                    cmp_block_layout.active_uniform_indices.len()
                );
                is_ok = false;
            }

            for ndx in &ref_block_layout.active_uniform_indices {
                let ref_entry = &ref_layout.uniforms[*ndx as usize];
                let Some(cmp_entry_ndx) = cmp_layout.uniform_index(&ref_entry.name) else {
                    log::warn!("Error: Uniform '{}' not found", ref_entry.name);
                    is_ok = false;
                    continue;
                };
                let cmp_entry = &cmp_layout.uniforms[cmp_entry_ndx];

                let mismatch = ref_entry.ty != cmp_entry.ty
                    || ref_entry.size != cmp_entry.size
                    || ref_entry.is_row_major != cmp_entry.is_row_major
                    || (check_offsets
                        && (ref_entry.offset != cmp_entry.offset
                            || ref_entry.array_stride != cmp_entry.array_stride
                            || ref_entry.matrix_stride != cmp_entry.matrix_stride));

                if mismatch {
                    log::warn!(
                        "Error: Layout mismatch in '{}': expected type = {}, size = {}, offset = {}, array stride = {}, matrix stride = {}, row major = {}; got type = {}, size = {}, offset = {}, array stride = {}, matrix stride = {}, row major = {}",
                        ref_entry.name,
                        ref_entry.ty.name(),
                        ref_entry.size,
                        ref_entry.offset,
                        ref_entry.array_stride,
                        ref_entry.matrix_stride,
                        ref_entry.is_row_major,
                        cmp_entry.ty.name(),
                        cmp_entry.size,
                        cmp_entry.offset,
                        cmp_entry.array_stride,
                        cmp_entry.matrix_stride,
                        cmp_entry.is_row_major
                    );
                    is_ok = false;
                }
            }
        }

        is_ok
    }

    /// `UniformBlockCase::compareTypes`
    fn compare_types(&self, ref_layout: &UniformLayout, cmp_layout: &UniformLayout) -> bool {
        let mut is_ok = true;

        for block in self.interface.blocks() {
            let num_instances = if block.is_array() { block.array_size } else { 1 };

            for instance_ndx in 0..num_instances {
                let instance_name = if block.is_array() {
                    format!("{}[{instance_ndx}]", block.block_name)
                } else {
                    block.block_name.clone()
                };
                let Some(cmp_block_ndx) = cmp_layout.block_index(&instance_name) else {
                    continue;
                };

                for ndx in &cmp_layout.blocks[cmp_block_ndx].active_uniform_indices {
                    let cmp_entry = &cmp_layout.uniforms[*ndx as usize];
                    let Some(ref_entry_ndx) = ref_layout.uniform_index(&cmp_entry.name) else {
                        log::warn!("Error: Uniform '{}' not found in reference layout", cmp_entry.name);
                        is_ok = false;
                        continue;
                    };
                    let ref_entry = &ref_layout.uniforms[ref_entry_ndx];

                    if ref_entry.ty != cmp_entry.ty {
                        log::warn!(
                            "Error: Uniform type mismatch in '{}': expected {}, got {}",
                            ref_entry.name,
                            ref_entry.ty.name(),
                            cmp_entry.ty.name()
                        );
                        is_ok = false;
                    }
                }
            }
        }

        is_ok
    }

    /// `UniformBlockCase::checkLayoutIndices`
    fn check_layout_indices(layout: &UniformLayout) -> bool {
        let num_uniforms = layout.uniforms.len() as i32;
        let num_blocks = layout.blocks.len() as i32;
        let mut is_ok = true;

        // Check uniform block indices.
        for uniform in &layout.uniforms {
            if uniform.block_ndx < 0 || uniform.block_ndx >= num_blocks {
                log::warn!("Error: Invalid block index in uniform '{}'", uniform.name);
                is_ok = false;
            }
        }

        // Check active uniforms.
        for block in &layout.blocks {
            for uniform_ndx in &block.active_uniform_indices {
                if *uniform_ndx < 0 || *uniform_ndx >= num_uniforms {
                    log::warn!(
                        "Error: Invalid active uniform index {uniform_ndx} in block '{}'",
                        block.name
                    );
                    is_ok = false;
                }
            }
        }

        is_ok
    }

    /// `UniformBlockCase::checkLayoutBounds`
    fn check_layout_bounds(layout: &UniformLayout) -> bool {
        let mut is_ok = true;

        for uniform in &layout.uniforms {
            if uniform.block_ndx < 0 {
                continue;
            }

            let block = &layout.blocks[uniform.block_ndx as usize];
            let is_matrix = uniform.ty.is_matrix();
            let num_vecs = if is_matrix {
                if uniform.is_row_major {
                    uniform.ty.matrix_num_rows()
                } else {
                    uniform.ty.matrix_num_columns()
                }
            } else {
                1
            };
            let num_comps = if is_matrix {
                if uniform.is_row_major {
                    uniform.ty.matrix_num_columns()
                } else {
                    uniform.ty.matrix_num_rows()
                }
            } else {
                uniform.ty.scalar_size()
            };
            let num_elements = uniform.size;
            let vec_size = num_comps * COMP_SIZE;

            // For negative strides.
            let min_offset = 0
                .min((num_vecs - 1) * uniform.matrix_stride)
                .min((num_elements - 1) * uniform.array_stride)
                .min((num_elements - 1) * uniform.array_stride + (num_vecs - 1) * uniform.matrix_stride);
            let max_offset = vec_size
                .max((num_vecs - 1) * uniform.matrix_stride + vec_size)
                .max((num_elements - 1) * uniform.array_stride + vec_size)
                .max((num_elements - 1) * uniform.array_stride + (num_vecs - 1) * uniform.matrix_stride + vec_size);

            if uniform.offset + min_offset < 0 || uniform.offset + max_offset > block.size {
                log::warn!("Error: Uniform '{}' out of block bounds", uniform.name);
                is_ok = false;
            }
        }

        is_ok
    }

    /// `UniformBlockCase::checkIndexQueries`
    ///
    /// \note Spec mandates that uniform blocks are assigned consecutive locations from 0
    /// to ACTIVE_UNIFORM_BLOCKS. `BlockLayoutEntry`s are stored in that order here.
    fn check_index_queries(gl: &glw::Functions, program: GLuint, layout: &UniformLayout) -> Result<bool, TestError> {
        let mut all_ok = true;

        for (block_ndx, block) in layout.blocks.iter().enumerate() {
            let name = std::ffi::CString::new(block.name.as_str()).expect("block name holds a nul byte");
            // SAFETY: the name is nul-terminated and the program is this case's own.
            let queried_ndx = unsafe { gl.get_uniform_block_index(program, name.as_ptr()) };

            if queried_ndx as usize != block_ndx {
                log::warn!(
                    "ERROR: glGetUniformBlockIndex({}) returned {queried_ndx}, expected {block_ndx}!",
                    block.name
                );
                all_ok = false;
            }

            glu::expect_no_error(gl, "glGetUniformBlockIndex()")?;
        }

        Ok(all_ok)
    }

    /// `UniformBlockCase::render`
    fn render(&self, context: &Context, program: GLuint) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut rnd = Random::new(de_string_hash(&self.name));
        let render_target = context.render_target();
        let viewport_w = render_target.width.min(128);
        let viewport_h = render_target.height.min(128);
        let viewport_x = rnd.get_int(0, render_target.width - viewport_w);
        let viewport_y = rnd.get_int(0, render_target.height - viewport_h);

        #[rustfmt::skip]
        const POSITION: [f32; 16] = [
            -1.0, -1.0, 0.0, 1.0,
            -1.0,  1.0, 0.0, 1.0,
             1.0, -1.0, 0.0, 1.0,
             1.0,  1.0, 0.0, 1.0,
        ];
        const INDICES: [u16; 6] = [0, 1, 2, 2, 1, 3];

        // SAFETY: both client arrays outlive the draw, and `a_position` is declared by
        // every generated vertex shader.
        unsafe {
            gl.clear_color(0.125, 0.25, 0.5, 1.0);
            gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
            gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h);

            let pos_loc = gl.get_attrib_location(program, c"a_position".as_ptr());
            gl.enable_vertex_attrib_array(pos_loc as GLuint);
            gl.vertex_attrib_pointer(
                pos_loc as GLuint,
                4,
                glw::GL_FLOAT,
                glw::FALSE,
                0,
                POSITION.as_ptr().cast(),
            );
            gl.draw_elements(
                glw::GL_TRIANGLES,
                INDICES.len() as i32,
                glw::GL_UNSIGNED_SHORT,
                INDICES.as_ptr().cast(),
            );
            glu::expect_no_error(gl, "Draw failed")?;
            gl.disable_vertex_attrib_array(pos_loc as GLuint);
        }

        // Verify that all pixels are white.
        let mut pixels = Surface::new(viewport_w, viewport_h);
        glu::read_pixels(
            &context.render_context,
            viewport_x,
            viewport_y,
            &mut pixels.get_access(),
        )?;

        let mut num_failed_pixels = 0;
        for y in 0..viewport_h {
            for x in 0..viewport_w {
                if pixels.get_pixel(x, y) != RGBA::white() {
                    num_failed_pixels += 1;
                }
            }
        }

        if num_failed_pixels > 0 {
            log::warn!("Image comparison failed, got {num_failed_pixels} non-white pixels");
        }

        Ok(num_failed_pixels == 0)
    }
}

impl TestCase for UniformBlockCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `UniformBlockCase::iterate`
    #[allow(clippy::too_many_lines)]
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        // Compute reference layout.
        let ref_layout = compute_std140_layout(&self.interface);

        // Assign storage for reference values.
        let mut block_data: Vec<Vec<u8>> = ref_layout
            .blocks
            .iter()
            .map(|block| vec![0u8; block.size.max(0) as usize])
            .collect();

        // Generate values.
        generate_values(&ref_layout, &mut block_data, 1 /* seed */);

        // Generate shaders and build program.
        let vtx_src = generate_vertex_shader(self.glsl_version, &self.interface, &ref_layout, &block_data);
        let frag_src = generate_fragment_shader(self.glsl_version, &self.interface, &ref_layout, &block_data);
        let program = ShaderProgram::new(gl, &ProgramSources::vtx_frag(vtx_src, frag_src));

        if !program.is_ok() {
            return Ok(TestStatus::fail("Compile failed"));
        }
        let program_gl = program.program();

        // Query layout from GL.
        let gl_layout = get_gl_uniform_layout(gl, program_gl)?;

        // Check that we can even try rendering with given layout.
        if !Self::check_layout_indices(&gl_layout)
            || !Self::check_layout_bounds(&gl_layout)
            || !self.compare_types(&ref_layout, &gl_layout)
        {
            // It is not safe to use the given layout.
            return Ok(TestStatus::fail("Invalid layout"));
        }

        let mut failure: Option<&'static str> = None;

        // Verify all std140 blocks.
        if !self.compare_std140_blocks(&ref_layout, &gl_layout) {
            failure = Some("Invalid std140 layout");
        }

        // Verify all shared blocks - all uniforms should be active, and certain properties match.
        if !self.compare_shared_blocks(&ref_layout, &gl_layout) {
            failure = failure.or(Some("Invalid shared layout"));
        }

        // Check consistency with index queries.
        if !Self::check_index_queries(gl, program_gl, &gl_layout)? {
            failure = failure.or(Some("Inconsintent block index query results"));
        }

        let num_blocks = gl_layout.blocks.len();
        let mut gl_block_data: Vec<Vec<u8>> = gl_layout
            .blocks
            .iter()
            .map(|block| vec![0u8; block.size.max(0) as usize])
            .collect();
        copy_uniform_data(&gl_layout, &mut gl_block_data, &ref_layout, &block_data);

        // The buffers stay alive until the draw is done.
        let buffers: Vec<glu::Buffer<'_>> = (0..if self.buffer_mode == BufferMode::PerBlock {
            num_blocks
        } else {
            1
        })
            .map(|_| glu::Buffer::new(gl))
            .collect();

        // SAFETY: every name below is this case's own, and each upload reads exactly the
        // block's own byte vector.
        unsafe {
            gl.use_program(program_gl);

            // Assign binding points to all active uniform blocks.
            // \todo [2012-01-25 pyry] Randomize order?
            for block_ndx in 0..num_blocks {
                gl.uniform_block_binding(program_gl, block_ndx as GLuint, block_ndx as GLuint);
            }
            glu::expect_no_error(gl, "Failed to set uniform block bindings")?;

            if self.buffer_mode == BufferMode::PerBlock {
                for (block_ndx, data) in gl_block_data.iter().enumerate() {
                    gl.bind_buffer(glw::GL_UNIFORM_BUFFER, buffers[block_ndx].get());
                    gl.buffer_data(
                        glw::GL_UNIFORM_BUFFER,
                        data.len() as isize,
                        data.as_ptr().cast(),
                        glw::GL_STATIC_DRAW,
                    );
                    glu::expect_no_error(gl, "Failed to upload uniform buffer data")?;

                    gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, block_ndx as GLuint, buffers[block_ndx].get());
                    glu::expect_no_error(gl, "glBindBufferBase(GL_UNIFORM_BUFFER) failed")?;
                }
            } else {
                let mut binding_alignment = 0;
                gl.get_integerv(glw::GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT, &mut binding_alignment);

                // Compute total size and offsets.
                let mut offsets = Vec::with_capacity(num_blocks);
                let mut cur_offset = 0;
                for block in &gl_layout.blocks {
                    if binding_alignment > 0 {
                        cur_offset = round_up(cur_offset, binding_alignment);
                    }
                    offsets.push(cur_offset);
                    cur_offset += block.size;
                }

                // Copy to gl format.
                let mut flat = vec![0u8; cur_offset.max(0) as usize];
                for (block_ndx, data) in gl_block_data.iter().enumerate() {
                    let at = offsets[block_ndx] as usize;
                    flat[at..at + data.len()].copy_from_slice(data);
                }

                // Allocate buffer and upload data.
                gl.bind_buffer(glw::GL_UNIFORM_BUFFER, buffers[0].get());
                if !flat.is_empty() {
                    gl.buffer_data(
                        glw::GL_UNIFORM_BUFFER,
                        flat.len() as isize,
                        flat.as_ptr().cast(),
                        glw::GL_STATIC_DRAW,
                    );
                }
                glu::expect_no_error(gl, "Failed to upload uniform buffer data")?;

                // Bind ranges to binding points.
                for (block_ndx, block) in gl_layout.blocks.iter().enumerate() {
                    gl.bind_buffer_range(
                        glw::GL_UNIFORM_BUFFER,
                        block_ndx as GLuint,
                        buffers[0].get(),
                        offsets[block_ndx] as isize,
                        block.size as isize,
                    );
                    glu::expect_no_error(gl, "glBindBufferRange(GL_UNIFORM_BUFFER) failed")?;
                }
            }
        }

        if !self.render(context, program_gl)? {
            failure = failure.or(Some("Image compare failed"));
        }

        // SAFETY: unbinding needs only a current context; a buffer still bound to a
        // binding point when it is deleted would outlive this case's own state.
        unsafe {
            gl.bind_buffer(glw::GL_UNIFORM_BUFFER, 0);
            for block_ndx in 0..num_blocks {
                gl.bind_buffer_base(glw::GL_UNIFORM_BUFFER, block_ndx as GLuint, 0);
            }
        }

        Ok(match failure {
            Some(message) => TestStatus::fail(message),
            None => TestStatus::pass("Pass"),
        })
    }
}
