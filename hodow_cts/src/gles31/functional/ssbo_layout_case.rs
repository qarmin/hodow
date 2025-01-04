// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fSSBOLayoutCase.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream carries the reference and
// the mapped GL data as `void*` into one flat allocation plus a `BlockDataPtr` triple;
// here each block owns its bytes (`BlockBytes`) and the single-buffer placement is a
// separate `BlockLocation` step, which is the same regions without the aliasing. The
// GL-side data is copied out of the mapping rather than compared through it, so no raw
// pointer outlives its `glUnmapBuffer`.
//
// What this case actually proves is worth stating: it computes std140/std430 offsets
// itself and requires the driver to report the same ones, then round-trips values
// through a compute shader written against *its own* numbers. A wrong layout
// computation here fails loudly rather than passing quietly.

use std::collections::BTreeSet;
use std::fmt::Write as _;
use std::sync::Arc;

use crate::glu::shader_util::{DataType, get_data_type_float_vec, get_data_type_from_gl_type};
use crate::glu::var_type::UNSIZED_ARRAY;
use crate::glu::{
    self, Context, GlslVersion, ProgramSources, ShaderProgram, StructType, TestCase, VarType, VarTypeComponent,
};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::random::de_string_hash;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};

/// One `uint32_t`, the unit every offset and stride here is counted in.
const COMP_SIZE: i32 = 4;
const VEC4_ALIGNMENT: i32 = COMP_SIZE * 4;

// `bb::BufferVarFlags`
pub const LAYOUT_SHARED: u32 = 1 << 0;
pub const LAYOUT_PACKED: u32 = 1 << 1;
pub const LAYOUT_STD140: u32 = 1 << 2;
pub const LAYOUT_STD430: u32 = 1 << 3;
pub const LAYOUT_ROW_MAJOR: u32 = 1 << 4;
/// \note Lack of both flags means column-major matrix.
pub const LAYOUT_COLUMN_MAJOR: u32 = 1 << 5;
pub const LAYOUT_MASK: u32 =
    LAYOUT_SHARED | LAYOUT_PACKED | LAYOUT_STD140 | LAYOUT_STD430 | LAYOUT_ROW_MAJOR | LAYOUT_COLUMN_MAJOR;

/// Buffer variable is read in the shader.
pub const ACCESS_READ: u32 = 1 << 11;
/// Buffer variable is written in the shader.
pub const ACCESS_WRITE: u32 = 1 << 12;

/// `bb::BufferVar`
#[derive(Clone, Debug)]
pub struct BufferVar {
    pub name: String,
    pub ty: VarType,
    pub flags: u32,
}

impl BufferVar {
    pub fn new(name: &str, ty: VarType, flags: u32) -> Self {
        Self {
            name: name.to_string(),
            ty,
            flags,
        }
    }
}

/// `bb::BufferBlock`
#[derive(Clone, Debug)]
pub struct BufferBlock {
    pub block_name: String,
    pub instance_name: Option<String>,
    pub variables: Vec<BufferVar>,
    /// Array size or 0 if not an interface block array.
    pub array_size: i32,
    /// Sizes of last unsized array element, can be different per instance.
    pub last_unsized_array_sizes: Vec<i32>,
    pub flags: u32,
}

impl BufferBlock {
    pub fn new(block_name: &str) -> Self {
        Self {
            block_name: block_name.to_string(),
            instance_name: None,
            variables: Vec::new(),
            array_size: 0,
            last_unsized_array_sizes: vec![0],
            flags: 0,
        }
    }

    pub fn is_array(&self) -> bool {
        self.array_size > 0
    }

    pub fn add_member(&mut self, var: BufferVar) {
        self.variables.push(var);
    }

    /// `BufferBlock::setArraySize`
    pub fn set_array_size(&mut self, array_size: i32) {
        self.last_unsized_array_sizes = vec![0; if array_size == 0 { 1 } else { array_size as usize }];
        self.array_size = array_size;
    }

    pub fn set_last_unsized_array_size(&mut self, instance_ndx: usize, size: i32) {
        self.last_unsized_array_sizes[instance_ndx] = size;
    }

    fn last_unsized_array_size(&self, instance_ndx: usize) -> i32 {
        self.last_unsized_array_sizes[instance_ndx]
    }
}

/// `bb::ShaderInterface`
#[derive(Default, Debug)]
pub struct ShaderInterface {
    structs: Vec<Arc<StructType>>,
    blocks: Vec<BufferBlock>,
}

impl ShaderInterface {
    pub fn add_struct(&mut self, struct_type: StructType) -> Arc<StructType> {
        let struct_type = Arc::new(struct_type);
        self.structs.push(Arc::clone(&struct_type));
        struct_type
    }

    pub fn add_block(&mut self, block: BufferBlock) {
        self.blocks.push(block);
    }

    pub fn blocks(&self) -> &[BufferBlock] {
        &self.blocks
    }

    /// `ShaderInterface::getNamedStructs`
    fn named_structs(&self) -> impl Iterator<Item = &Arc<StructType>> {
        self.structs.iter().filter(|s| s.has_type_name())
    }
}

/// `bb::BlockLayoutEntry`
#[derive(Clone, Debug, Default)]
struct BlockLayoutEntry {
    name: String,
    size: i32,
    active_var_indices: Vec<i32>,
}

/// `bb::BufferVarLayoutEntry`
#[derive(Clone, Debug)]
struct BufferVarLayoutEntry {
    name: String,
    ty: DataType,
    block_ndx: i32,
    offset: i32,
    array_size: i32,
    array_stride: i32,
    matrix_stride: i32,
    top_level_array_size: i32,
    top_level_array_stride: i32,
    is_row_major: bool,
}

impl Default for BufferVarLayoutEntry {
    fn default() -> Self {
        Self {
            name: String::new(),
            ty: DataType::Invalid,
            block_ndx: -1,
            offset: -1,
            array_size: -1,
            array_stride: -1,
            matrix_stride: -1,
            top_level_array_size: -1,
            top_level_array_stride: -1,
            is_row_major: false,
        }
    }
}

impl BufferVarLayoutEntry {
    /// `isUnsizedArray`
    fn is_unsized_array(&self) -> bool {
        self.array_size == 0 || self.top_level_array_size == 0
    }

    fn describe(&self) -> String {
        format!(
            "{{ type = {}, blockNdx = {}, offset = {}, arraySize = {}, arrayStride = {}, matrixStride = {}, topLevelArraySize = {}, topLevelArrayStride = {}, isRowMajor = {} }}",
            self.ty.name(),
            self.block_ndx,
            self.offset,
            self.array_size,
            self.array_stride,
            self.matrix_stride,
            self.top_level_array_size,
            self.top_level_array_stride,
            self.is_row_major
        )
    }
}

/// `bb::BufferLayout`
#[derive(Default, Debug)]
struct BufferLayout {
    blocks: Vec<BlockLayoutEntry>,
    buffer_vars: Vec<BufferVarLayoutEntry>,
}

impl BufferLayout {
    fn variable_index(&self, name: &str) -> Option<usize> {
        self.buffer_vars.iter().position(|entry| entry.name == name)
    }

    fn block_index(&self, name: &str) -> Option<usize> {
        self.blocks.iter().position(|entry| entry.name == name)
    }

    /// `hasUnsizedArray`
    fn has_unsized_array(&self, entry: &BlockLayoutEntry) -> bool {
        entry
            .active_var_indices
            .iter()
            .any(|ndx| self.buffer_vars[*ndx as usize].is_unsized_array())
    }

    /// `getUnsizedArrayStride`
    fn unsized_array_stride(&self, entry: &BlockLayoutEntry) -> i32 {
        for ndx in &entry.active_var_indices {
            let var = &self.buffer_vars[*ndx as usize];
            if var.array_size == 0 {
                return var.array_stride;
            } else if var.top_level_array_size == 0 {
                return var.top_level_array_stride;
            }
        }
        0
    }
}

/// One block's bytes plus the runtime length its unsized array ended up with - upstream's
/// `BlockDataPtr` without the pointer.
#[derive(Clone, Debug, Default)]
struct BlockBytes {
    data: Vec<u8>,
    last_unsized_array_size: i32,
}

/// `LayoutFlagsFmt`
fn layout_flags_str(flags: u32) -> String {
    const BIT_DESC: [(u32, &str); 6] = [
        (LAYOUT_SHARED, "shared"),
        (LAYOUT_PACKED, "packed"),
        (LAYOUT_STD140, "std140"),
        (LAYOUT_STD430, "std430"),
        (LAYOUT_ROW_MAJOR, "row_major"),
        (LAYOUT_COLUMN_MAJOR, "column_major"),
    ];

    BIT_DESC
        .iter()
        .filter(|(bit, _)| flags & bit != 0)
        .map(|(_, token)| *token)
        .collect::<Vec<_>>()
        .join(", ")
}

fn align_up(value: i32, alignment: i32) -> i32 {
    if alignment == 0 {
        value
    } else {
        (value + alignment - 1) / alignment * alignment
    }
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

/// `computeStd140BaseAlignment`
fn compute_std140_base_alignment(ty: &VarType, layout_flags: u32) -> i32 {
    match ty {
        VarType::Basic(basic_type, _) => {
            if basic_type.is_matrix() {
                let is_row_major = layout_flags & LAYOUT_ROW_MAJOR != 0;
                let vec_size = if is_row_major {
                    basic_type.matrix_num_columns()
                } else {
                    basic_type.matrix_num_rows()
                };
                align_up(
                    data_type_byte_alignment(get_data_type_float_vec(vec_size)),
                    VEC4_ALIGNMENT,
                )
            } else {
                data_type_byte_alignment(*basic_type)
            }
        }
        // Round up to alignment of vec4.
        VarType::Array(elem, _) => align_up(compute_std140_base_alignment(elem, layout_flags), VEC4_ALIGNMENT),
        VarType::Struct(struct_type) => {
            let max_base_alignment = struct_type
                .members
                .iter()
                .map(|member| compute_std140_base_alignment(&member.ty, layout_flags))
                .max()
                .unwrap_or(0);
            align_up(max_base_alignment, VEC4_ALIGNMENT)
        }
    }
}

/// `computeStd430BaseAlignment` - otherwise identical to std140 except that alignment of
/// structures and arrays are not rounded up to alignment of vec4.
fn compute_std430_base_alignment(ty: &VarType, layout_flags: u32) -> i32 {
    match ty {
        VarType::Basic(basic_type, _) => {
            if basic_type.is_matrix() {
                let is_row_major = layout_flags & LAYOUT_ROW_MAJOR != 0;
                let vec_size = if is_row_major {
                    basic_type.matrix_num_columns()
                } else {
                    basic_type.matrix_num_rows()
                };
                data_type_byte_alignment(get_data_type_float_vec(vec_size))
            } else {
                data_type_byte_alignment(*basic_type)
            }
        }
        VarType::Array(elem, _) => compute_std430_base_alignment(elem, layout_flags),
        VarType::Struct(struct_type) => struct_type
            .members
            .iter()
            .map(|member| compute_std430_base_alignment(&member.ty, layout_flags))
            .max()
            .unwrap_or(0),
    }
}

/// `mergeLayoutFlags`
fn merge_layout_flags(prev_flags: u32, new_flags: u32) -> u32 {
    const PACKING_MASK: u32 = LAYOUT_PACKED | LAYOUT_SHARED | LAYOUT_STD140 | LAYOUT_STD430;
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

/// `computeReferenceLayout(BufferLayout&, int, int, const string&, const VarType&, uint32_t)`
///
/// Appends all child elements to layout, returns value that should be appended to offset.
fn compute_reference_layout_type(
    layout: &mut BufferLayout,
    cur_block_ndx: i32,
    base_offset: i32,
    cur_prefix: &str,
    ty: &VarType,
    layout_flags: u32,
) -> i32 {
    // Reference layout uses std430 rules by default. std140 rules are chosen only for
    // blocks that have std140 layout.
    let is_std140 = layout_flags & LAYOUT_STD140 != 0;
    let base_alignment = if is_std140 {
        compute_std140_base_alignment(ty, layout_flags)
    } else {
        compute_std430_base_alignment(ty, layout_flags)
    };
    let mut cur_offset = align_up(base_offset, base_alignment);
    // Default values.
    let top_level_array_size = 1;
    let top_level_array_stride = 0;

    match ty {
        VarType::Basic(basic_type, _) => {
            let mut entry = BufferVarLayoutEntry {
                name: cur_prefix.to_string(),
                ty: *basic_type,
                array_size: 1,
                array_stride: 0,
                matrix_stride: 0,
                top_level_array_size,
                top_level_array_stride,
                block_ndx: cur_block_ndx,
                ..Default::default()
            };

            if basic_type.is_matrix() {
                // Array of vectors as specified in rules 5 & 7.
                let is_row_major = layout_flags & LAYOUT_ROW_MAJOR != 0;
                let num_vecs = if is_row_major {
                    basic_type.matrix_num_rows()
                } else {
                    basic_type.matrix_num_columns()
                };

                entry.offset = cur_offset;
                entry.matrix_stride = base_alignment;
                entry.is_row_major = is_row_major;

                cur_offset += num_vecs * base_alignment;
            } else {
                // Scalar or vector.
                entry.offset = cur_offset;
                cur_offset += data_type_byte_size(*basic_type);
            }

            layout.buffer_vars.push(entry);
        }
        VarType::Array(elem_type, array_size) => match &**elem_type {
            VarType::Basic(elem_basic_type, _) if !elem_basic_type.is_matrix() => {
                // Array of scalars or vectors.
                layout.buffer_vars.push(BufferVarLayoutEntry {
                    // Array variables are always postfixed with [0].
                    name: format!("{cur_prefix}[0]"),
                    ty: *elem_basic_type,
                    block_ndx: cur_block_ndx,
                    offset: cur_offset,
                    array_size: *array_size,
                    array_stride: base_alignment,
                    matrix_stride: 0,
                    top_level_array_size,
                    top_level_array_stride,
                    is_row_major: false,
                });
                cur_offset += base_alignment * array_size;
            }
            VarType::Basic(elem_basic_type, _) => {
                // Array of matrices.
                let is_row_major = layout_flags & LAYOUT_ROW_MAJOR != 0;
                let num_vecs = if is_row_major {
                    elem_basic_type.matrix_num_rows()
                } else {
                    elem_basic_type.matrix_num_columns()
                };
                let vec_stride = base_alignment;

                layout.buffer_vars.push(BufferVarLayoutEntry {
                    name: format!("{cur_prefix}[0]"),
                    ty: *elem_basic_type,
                    block_ndx: cur_block_ndx,
                    offset: cur_offset,
                    array_size: *array_size,
                    array_stride: vec_stride * num_vecs,
                    matrix_stride: vec_stride,
                    is_row_major,
                    top_level_array_size,
                    top_level_array_stride,
                });
                cur_offset += num_vecs * vec_stride * array_size;
            }
            _ => {
                for elem_ndx in 0..*array_size {
                    cur_offset += compute_reference_layout_type(
                        layout,
                        cur_block_ndx,
                        cur_offset,
                        &format!("{cur_prefix}[{elem_ndx}]"),
                        elem_type,
                        layout_flags,
                    );
                }
            }
        },
        VarType::Struct(struct_type) => {
            for member in &struct_type.members {
                cur_offset += compute_reference_layout_type(
                    layout,
                    cur_block_ndx,
                    cur_offset,
                    &format!("{cur_prefix}.{}", member.name),
                    &member.ty,
                    layout_flags,
                );
            }
            cur_offset = align_up(cur_offset, base_alignment);
        }
    }

    cur_offset - base_offset
}

/// `computeReferenceLayout(BufferLayout&, int, const string&, int, const BufferVar&, uint32_t)`
fn compute_reference_layout_var(
    layout: &mut BufferLayout,
    cur_block_ndx: i32,
    block_prefix: &str,
    base_offset: i32,
    buf_var: &BufferVar,
    block_layout_flags: u32,
) -> i32 {
    let var_type = &buf_var.ty;
    let combined_flags = merge_layout_flags(block_layout_flags, buf_var.flags);

    if !var_type.is_array_type() {
        return compute_reference_layout_type(
            layout,
            cur_block_ndx,
            base_offset,
            &format!("{block_prefix}{}", buf_var.name),
            var_type,
            combined_flags,
        );
    }

    // Top-level arrays need special care.
    let top_level_array_size = if var_type.array_size() == UNSIZED_ARRAY {
        0
    } else {
        var_type.array_size()
    };
    let prefix = format!("{block_prefix}{}[0]", buf_var.name);
    let is_std140 = block_layout_flags & LAYOUT_STD140 != 0;
    let base_alignment = if is_std140 {
        compute_std140_base_alignment(var_type, combined_flags)
    } else {
        compute_std430_base_alignment(var_type, combined_flags)
    };
    let mut cur_offset = align_up(base_offset, base_alignment);
    let elem_type = var_type.element_type();

    match elem_type {
        VarType::Basic(elem_basic_type, _) if !elem_basic_type.is_matrix() => {
            // Array of scalars or vectors.
            let elem_base_align = data_type_byte_alignment(*elem_basic_type);
            let stride = if is_std140 {
                align_up(elem_base_align, VEC4_ALIGNMENT)
            } else {
                elem_base_align
            };

            layout.buffer_vars.push(BufferVarLayoutEntry {
                name: prefix,
                top_level_array_size: 1,
                top_level_array_stride: 0,
                ty: *elem_basic_type,
                block_ndx: cur_block_ndx,
                offset: cur_offset,
                array_size: top_level_array_size,
                array_stride: stride,
                matrix_stride: 0,
                is_row_major: false,
            });
            cur_offset += stride * top_level_array_size;
        }
        VarType::Basic(elem_basic_type, _) => {
            // Array of matrices.
            let is_row_major = combined_flags & LAYOUT_ROW_MAJOR != 0;
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
            let vec_base_align = data_type_byte_alignment(get_data_type_float_vec(vec_size));
            let stride = if is_std140 {
                align_up(vec_base_align, VEC4_ALIGNMENT)
            } else {
                vec_base_align
            };

            layout.buffer_vars.push(BufferVarLayoutEntry {
                name: prefix,
                top_level_array_size: 1,
                top_level_array_stride: 0,
                ty: *elem_basic_type,
                block_ndx: cur_block_ndx,
                offset: cur_offset,
                array_size: top_level_array_size,
                array_stride: stride * num_vecs,
                matrix_stride: stride,
                is_row_major,
            });
            cur_offset += stride * num_vecs * top_level_array_size;
        }
        _ => {
            // Struct base alignment is not added multiple times as cur_offset supplied to
            // compute_reference_layout_type was already aligned correctly, so no extra
            // padding is added before the struct. Padding after it is added as it should.
            //
            // Stride could be computed prior to creating child elements, but it would
            // essentially require running the layout computation twice. Instead the
            // stride is fixed up on the child elements afterwards.
            let first_child_ndx = layout.buffer_vars.len();
            let stride =
                compute_reference_layout_type(layout, cur_block_ndx, cur_offset, &prefix, elem_type, combined_flags);

            for child in &mut layout.buffer_vars[first_child_ndx..] {
                child.top_level_array_size = top_level_array_size;
                child.top_level_array_stride = stride;
            }

            cur_offset += stride * top_level_array_size;
        }
    }

    cur_offset - base_offset
}

/// `computeReferenceLayout(BufferLayout&, const ShaderInterface&)`
fn compute_reference_layout(interface: &ShaderInterface) -> BufferLayout {
    let mut layout = BufferLayout::default();

    for block in interface.blocks() {
        let block_prefix = if block.instance_name.is_some() {
            format!("{}.", block.block_name)
        } else {
            String::new()
        };
        let mut cur_offset = 0;
        let active_block_ndx = layout.blocks.len() as i32;
        let first_var_ndx = layout.buffer_vars.len() as i32;

        for buf_var in &block.variables {
            cur_offset += compute_reference_layout_var(
                &mut layout,
                active_block_ndx,
                &block_prefix,
                cur_offset,
                buf_var,
                block.flags,
            );
        }

        let var_indices_end = layout.buffer_vars.len() as i32;
        let block_size = cur_offset;
        let num_instances = if block.is_array() { block.array_size } else { 1 };

        for instance_ndx in 0..num_instances {
            let name = if block.is_array() {
                format!("{}[{instance_ndx}]", block.block_name)
            } else {
                block.block_name.clone()
            };
            layout.blocks.push(BlockLayoutEntry {
                name,
                size: block_size,
                active_var_indices: (first_var_ndx..var_indices_end).collect(),
            });
        }
    }

    layout
}

/// `generateValue`
fn generate_value(entry: &BufferVarLayoutEntry, unsized_array_size: i32, block: &mut [u8], rnd: &mut Random) {
    let scalar_type = entry.ty.scalar_type();
    let scalar_size = entry.ty.scalar_size();
    let array_size = if entry.array_size == 0 {
        unsized_array_size
    } else {
        entry.array_size
    };
    let top_level_size = if entry.top_level_array_size == 0 {
        unsized_array_size
    } else {
        entry.top_level_array_size
    };
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

    for top_elem_ndx in 0..top_level_size {
        let top_at = entry.offset + top_elem_ndx * entry.top_level_array_stride;

        for elem_ndx in 0..array_size {
            let elem_at = top_at + elem_ndx * entry.array_stride;

            for vec_ndx in 0..num_vecs {
                let vec_at = elem_at + if is_matrix { vec_ndx * entry.matrix_stride } else { 0 };

                for comp_ndx in 0..vec_size {
                    let at = (vec_at + COMP_SIZE * comp_ndx) as usize;
                    let word = match scalar_type {
                        DataType::Float => (rnd.get_int(-9, 9) as f32).to_bits(),
                        DataType::Int => rnd.get_int(-9, 9) as u32,
                        DataType::Uint => rnd.get_int(0, 9) as u32,
                        // \note Random bit pattern is used for true values. Spec states
                        // that all non-zero values are interpreted as true but some
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
}

/// `generateValues`
fn generate_values(layout: &BufferLayout, blocks: &mut [BlockBytes], seed: u32) {
    let mut rnd = Random::new(seed);

    for (block_ndx, block_layout) in layout.blocks.iter().enumerate() {
        for var_ndx in &block_layout.active_var_indices {
            let last_unsized = blocks[block_ndx].last_unsized_array_size;
            generate_value(
                &layout.buffer_vars[*var_ndx as usize],
                last_unsized,
                &mut blocks[block_ndx].data,
                &mut rnd,
            );
        }
    }
}

/// `getCompareFuncForType`
fn compare_func_for_type(ty: DataType) -> &'static str {
    match ty {
        DataType::Float => "bool compare_float    (highp float a, highp float b)  { return abs(a - b) < 0.05; }\n",
        DataType::FloatVec2 => {
            "bool compare_vec2     (highp vec2 a, highp vec2 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y); }\n"
        }
        DataType::FloatVec3 => {
            "bool compare_vec3     (highp vec3 a, highp vec3 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z); }\n"
        }
        DataType::FloatVec4 => {
            "bool compare_vec4     (highp vec4 a, highp vec4 b)    { return compare_float(a.x, b.x)&&compare_float(a.y, b.y)&&compare_float(a.z, b.z)&&compare_float(a.w, b.w); }\n"
        }
        DataType::FloatMat2 => {
            "bool compare_mat2     (highp mat2 a, highp mat2 b)    { return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1]); }\n"
        }
        DataType::FloatMat2x3 => {
            "bool compare_mat2x3   (highp mat2x3 a, highp mat2x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1]); }\n"
        }
        DataType::FloatMat2x4 => {
            "bool compare_mat2x4   (highp mat2x4 a, highp mat2x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1]); }\n"
        }
        DataType::FloatMat3x2 => {
            "bool compare_mat3x2   (highp mat3x2 a, highp mat3x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2]); }\n"
        }
        DataType::FloatMat3 => {
            "bool compare_mat3     (highp mat3 a, highp mat3 b)    { return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2]); }\n"
        }
        DataType::FloatMat3x4 => {
            "bool compare_mat3x4   (highp mat3x4 a, highp mat3x4 b){ return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2]); }\n"
        }
        DataType::FloatMat4x2 => {
            "bool compare_mat4x2   (highp mat4x2 a, highp mat4x2 b){ return compare_vec2(a[0], b[0])&&compare_vec2(a[1], b[1])&&compare_vec2(a[2], b[2])&&compare_vec2(a[3], b[3]); }\n"
        }
        DataType::FloatMat4x3 => {
            "bool compare_mat4x3   (highp mat4x3 a, highp mat4x3 b){ return compare_vec3(a[0], b[0])&&compare_vec3(a[1], b[1])&&compare_vec3(a[2], b[2])&&compare_vec3(a[3], b[3]); }\n"
        }
        DataType::FloatMat4 => {
            "bool compare_mat4     (highp mat4 a, highp mat4 b)    { return compare_vec4(a[0], b[0])&&compare_vec4(a[1], b[1])&&compare_vec4(a[2], b[2])&&compare_vec4(a[3], b[3]); }\n"
        }
        DataType::Int => "bool compare_int      (highp int a, highp int b)      { return a == b; }\n",
        DataType::IntVec2 => "bool compare_ivec2    (highp ivec2 a, highp ivec2 b)  { return a == b; }\n",
        DataType::IntVec3 => "bool compare_ivec3    (highp ivec3 a, highp ivec3 b)  { return a == b; }\n",
        DataType::IntVec4 => "bool compare_ivec4    (highp ivec4 a, highp ivec4 b)  { return a == b; }\n",
        DataType::Uint => "bool compare_uint     (highp uint a, highp uint b)    { return a == b; }\n",
        DataType::UintVec2 => "bool compare_uvec2    (highp uvec2 a, highp uvec2 b)  { return a == b; }\n",
        DataType::UintVec3 => "bool compare_uvec3    (highp uvec3 a, highp uvec3 b)  { return a == b; }\n",
        DataType::UintVec4 => "bool compare_uvec4    (highp uvec4 a, highp uvec4 b)  { return a == b; }\n",
        DataType::Bool => "bool compare_bool     (bool a, bool b)                { return a == b; }\n",
        DataType::BoolVec2 => "bool compare_bvec2    (bvec2 a, bvec2 b)              { return a == b; }\n",
        DataType::BoolVec3 => "bool compare_bvec3    (bvec3 a, bvec3 b)              { return a == b; }\n",
        DataType::BoolVec4 => "bool compare_bvec4    (bvec4 a, bvec4 b)              { return a == b; }\n",
        _ => "",
    }
}

fn data_type_index(ty: DataType) -> usize {
    crate::glu::shader_util::ALL_DATA_TYPES
        .iter()
        .position(|t| *t == ty)
        .unwrap_or(usize::MAX)
}

/// `getCompareDependencies`
fn compare_dependencies(compare_funcs: &mut BTreeSet<usize>, basic_type: DataType) {
    match basic_type {
        DataType::FloatVec2 | DataType::FloatVec3 | DataType::FloatVec4 => {
            compare_funcs.insert(data_type_index(DataType::Float));
            compare_funcs.insert(data_type_index(basic_type));
        }
        _ if basic_type.is_matrix() => {
            compare_funcs.insert(data_type_index(DataType::Float));
            compare_funcs.insert(data_type_index(get_data_type_float_vec(basic_type.matrix_num_rows())));
            compare_funcs.insert(data_type_index(basic_type));
        }
        _ => {
            compare_funcs.insert(data_type_index(basic_type));
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
        VarType::Struct(struct_type) => {
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
        for var in &block.variables {
            collect_unique_basic_types(&mut types, &var.ty);
        }
    }

    // A `std::set<glu::DataType>` iterates in enum order, and each function has to be
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

/// `generateDeclaration(ostream&, const BufferVar&, int)`
fn generate_var_declaration(src: &mut String, buffer_var: &BufferVar, indent_level: i32) {
    // \todo [pyry] Qualifiers
    if buffer_var.flags & LAYOUT_MASK != 0 {
        let _ = write!(src, "layout({}) ", layout_flags_str(buffer_var.flags & LAYOUT_MASK));
    }
    src.push_str(&glu::declare_var(&buffer_var.ty, &buffer_var.name, indent_level));
}

/// `generateDeclaration(ostream&, const BufferBlock&, int)`
fn generate_block_declaration(src: &mut String, block: &BufferBlock, binding_point: i32) {
    src.push_str("layout(");
    if block.flags & LAYOUT_MASK != 0 {
        let _ = write!(src, "{}, ", layout_flags_str(block.flags & LAYOUT_MASK));
    }
    let _ = write!(src, "binding = {binding_point}) buffer {}\n{{\n", block.block_name);

    for var in &block.variables {
        src.push('\t');
        generate_var_declaration(src, var, 1);
        src.push_str(";\n");
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

/// `generateImmMatrixSrc`
fn generate_imm_matrix_src(
    src: &mut String,
    basic_type: DataType,
    matrix_stride: i32,
    is_row_major: bool,
    block: &[u8],
    value_at: i32,
) {
    let num_rows = basic_type.matrix_num_rows();
    let num_cols = basic_type.matrix_num_columns();

    let _ = write!(src, "{}(", basic_type.name());

    // Constructed in column-wise order.
    for col_ndx in 0..num_cols {
        for row_ndx in 0..num_rows {
            let at = value_at
                + if is_row_major {
                    row_ndx * matrix_stride + col_ndx * COMP_SIZE
                } else {
                    col_ndx * matrix_stride + row_ndx * COMP_SIZE
                };

            if col_ndx > 0 || row_ndx > 0 {
                src.push_str(", ");
            }
            let _ = write!(src, "{:.1}", f32::from_bits(read_u32(block, at as usize)));
        }
    }

    src.push(')');
}

/// `generateImmScalarVectorSrc`
fn generate_imm_scalar_vector_src(src: &mut String, basic_type: DataType, block: &[u8], value_at: i32) {
    let scalar_type = basic_type.scalar_type();
    let scalar_size = basic_type.scalar_size();

    if scalar_size > 1 {
        let _ = write!(src, "{}(", basic_type.name());
    }

    for scalar_ndx in 0..scalar_size {
        let at = (value_at + scalar_ndx * COMP_SIZE) as usize;

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

    if scalar_size > 1 {
        src.push(')');
    }
}

/// `getAPIName`
fn get_api_name(block: &BufferBlock, var: &BufferVar, access_path: &[VarTypeComponent]) -> String {
    let mut name = String::new();
    if block.instance_name.is_some() {
        let _ = write!(name, "{}.", block.block_name);
    }
    name.push_str(&var.name);

    for (ndx, component) in access_path.iter().enumerate() {
        match component {
            VarTypeComponent::StructMember(index) => {
                let cur_type = glu::var_type::get_var_type(&var.ty, &access_path[..ndx]);
                let _ = write!(name, ".{}", cur_type.struct_ptr().members[*index].name);
            }
            VarTypeComponent::ArrayElement(index) => {
                // Top- / bottom-level array.
                if ndx == 0 || ndx + 1 == access_path.len() {
                    name.push_str("[0]");
                } else {
                    let _ = write!(name, "[{index}]");
                }
            }
            _ => unreachable!("a buffer variable's path has only struct members and array elements"),
        }
    }

    name
}

/// `getShaderName`
fn get_shader_name(
    block: &BufferBlock,
    instance_ndx: i32,
    var: &BufferVar,
    access_path: &[VarTypeComponent],
) -> String {
    let mut name = String::new();

    if let Some(instance_name) = &block.instance_name {
        name.push_str(instance_name);
        if block.is_array() {
            let _ = write!(name, "[{instance_ndx}]");
        }
        name.push('.');
    }
    name.push_str(&var.name);

    for (ndx, component) in access_path.iter().enumerate() {
        match component {
            VarTypeComponent::StructMember(index) => {
                let cur_type = glu::var_type::get_var_type(&var.ty, &access_path[..ndx]);
                let _ = write!(name, ".{}", cur_type.struct_ptr().members[*index].name);
            }
            VarTypeComponent::ArrayElement(index) => {
                let _ = write!(name, "[{index}]");
            }
            _ => unreachable!("a buffer variable's path has only struct members and array elements"),
        }
    }

    name
}

/// `computeOffset`
fn compute_offset(var_layout: &BufferVarLayoutEntry, access_path: &[VarTypeComponent]) -> i32 {
    let top_level_ndx = match access_path.first() {
        Some(VarTypeComponent::ArrayElement(index)) if access_path.len() > 1 => *index as i32,
        _ => 0,
    };
    let bottom_level_ndx = match access_path.last() {
        Some(VarTypeComponent::ArrayElement(index)) => *index as i32,
        _ => 0,
    };

    var_layout.offset + var_layout.top_level_array_stride * top_level_ndx + var_layout.array_stride * bottom_level_ndx
}

/// What `generateCompareSrc`/`generateWriteSrc`/`copyNonWrittenData` do at each leaf -
/// upstream repeats the same `SubTypeAccess` walk three times.
enum LeafOp<'a> {
    Compare { src: &'a mut String, result_var: &'a str },
    Write { src: &'a mut String },
    CopyNonWritten { dst: &'a mut Vec<u8> },
}

/// The shared `glu::SubTypeAccess` walk of upstream's three near-identical recursions.
#[allow(clippy::too_many_arguments)]
fn walk_sub_type(
    op: &mut LeafOp<'_>,
    layout: &BufferLayout,
    block: &BufferBlock,
    instance_ndx: i32,
    block_bytes: &BlockBytes,
    buf_var: &BufferVar,
    cur_type: &VarType,
    path: &mut Vec<VarTypeComponent>,
) {
    match cur_type {
        VarType::Array(elem_type, array_size) => {
            let array_size = if *array_size == UNSIZED_ARRAY {
                block.last_unsized_array_size(instance_ndx as usize)
            } else {
                *array_size
            };

            for elem_ndx in 0..array_size {
                path.push(VarTypeComponent::ArrayElement(elem_ndx as usize));
                walk_sub_type(op, layout, block, instance_ndx, block_bytes, buf_var, elem_type, path);
                path.pop();
            }
        }
        VarType::Struct(struct_type) => {
            for member_ndx in 0..struct_type.members.len() {
                path.push(VarTypeComponent::StructMember(member_ndx));
                walk_sub_type(
                    op,
                    layout,
                    block,
                    instance_ndx,
                    block_bytes,
                    buf_var,
                    &struct_type.members[member_ndx].ty,
                    path,
                );
                path.pop();
            }
        }
        VarType::Basic(basic_type, _) => {
            let api_name = get_api_name(block, buf_var, path);
            let Some(var_ndx) = layout.variable_index(&api_name) else {
                return;
            };
            let var_layout = &layout.buffer_vars[var_ndx];
            let value_at = compute_offset(var_layout, path);
            let is_matrix = basic_type.is_matrix();

            match op {
                LeafOp::Compare { src, result_var } => {
                    let shader_name = get_shader_name(block, instance_ndx, buf_var, path);
                    let _ = write!(
                        src,
                        "\t{result_var} = {result_var} && compare_{}({shader_name}, ",
                        basic_type.name()
                    );
                    if is_matrix {
                        generate_imm_matrix_src(
                            src,
                            *basic_type,
                            var_layout.matrix_stride,
                            var_layout.is_row_major,
                            &block_bytes.data,
                            value_at,
                        );
                    } else {
                        generate_imm_scalar_vector_src(src, *basic_type, &block_bytes.data, value_at);
                    }
                    src.push_str(");\n");
                }
                LeafOp::Write { src } => {
                    let shader_name = get_shader_name(block, instance_ndx, buf_var, path);
                    let _ = write!(src, "\t{shader_name} = ");
                    if is_matrix {
                        generate_imm_matrix_src(
                            src,
                            *basic_type,
                            var_layout.matrix_stride,
                            var_layout.is_row_major,
                            &block_bytes.data,
                            value_at,
                        );
                    } else {
                        generate_imm_scalar_vector_src(src, *basic_type, &block_bytes.data, value_at);
                    }
                    src.push_str(";\n");
                }
                LeafOp::CopyNonWritten { dst } => {
                    copy_buffer_var_data(
                        var_layout,
                        dst,
                        block_bytes.last_unsized_array_size,
                        var_layout,
                        &block_bytes.data,
                        block_bytes.last_unsized_array_size,
                    );
                }
            }
        }
    }
}

/// `generateCompareSrc`/`generateWriteSrc` over the whole interface.
fn generate_access_src(
    src: &mut String,
    result_var: Option<&str>,
    interface: &ShaderInterface,
    layout: &BufferLayout,
    block_bytes: &[BlockBytes],
) {
    let access_flag = if result_var.is_some() {
        ACCESS_READ
    } else {
        ACCESS_WRITE
    };

    for block in interface.blocks() {
        let is_array = block.is_array();
        let num_instances = if is_array { block.array_size } else { 1 };

        for instance_ndx in 0..num_instances {
            let instance_name = format!(
                "{}{}",
                block.block_name,
                if is_array {
                    format!("[{instance_ndx}]")
                } else {
                    String::new()
                }
            );
            let Some(block_ndx) = layout.block_index(&instance_name) else {
                continue;
            };

            for buf_var in &block.variables {
                if buf_var.flags & access_flag == 0 {
                    continue; // Don't touch that variable.
                }

                let mut op = match result_var {
                    Some(result_var) => LeafOp::Compare { src, result_var },
                    None => LeafOp::Write { src },
                };
                walk_sub_type(
                    &mut op,
                    layout,
                    block,
                    instance_ndx,
                    &block_bytes[block_ndx],
                    buf_var,
                    &buf_var.ty,
                    &mut Vec::new(),
                );
            }
        }
    }
}

/// `copyNonWrittenData`
fn copy_non_written_data(
    interface: &ShaderInterface,
    layout: &BufferLayout,
    src_bytes: &[BlockBytes],
    dst_bytes: &mut [BlockBytes],
) {
    for block in interface.blocks() {
        let is_array = block.is_array();
        let num_instances = if is_array { block.array_size } else { 1 };

        for instance_ndx in 0..num_instances {
            let instance_name = format!(
                "{}{}",
                block.block_name,
                if is_array {
                    format!("[{instance_ndx}]")
                } else {
                    String::new()
                }
            );
            let Some(block_ndx) = layout.block_index(&instance_name) else {
                continue;
            };

            for buf_var in &block.variables {
                if buf_var.flags & ACCESS_WRITE != 0 {
                    continue;
                }

                let src_block = src_bytes[block_ndx].clone();
                let mut op = LeafOp::CopyNonWritten {
                    dst: &mut dst_bytes[block_ndx].data,
                };
                walk_sub_type(
                    &mut op,
                    layout,
                    block,
                    instance_ndx,
                    &src_block,
                    buf_var,
                    &buf_var.ty,
                    &mut Vec::new(),
                );
            }
        }
    }
}

/// `generateComputeShader`
fn generate_compute_shader(
    gl: &glw::Functions,
    glsl_version: GlslVersion,
    interface: &ShaderInterface,
    layout: &BufferLayout,
    compare_bytes: &[BlockBytes],
    write_bytes: &[BlockBytes],
) -> Result<String, TestError> {
    let get = |name: GLenum| {
        let mut value = 0;
        // SAFETY: each name below returns a single integer.
        unsafe { gl.get_integerv(name, &mut value) };
        value
    };
    let max_shader_storage_buffer_bindings = get(glw::GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS);
    let max_compute_shader_storage_blocks = get(glw::GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS);

    let mut src = format!("{}\nlayout(local_size_x = 1) in;\n\n", glsl_version.declaration());

    for struct_type in interface.named_structs() {
        let _ = writeln!(src, "{};", glu::declare_struct(struct_type, 0));
    }

    {
        let mut binding_point = 0;

        for block in interface.blocks() {
            generate_block_declaration(&mut src, block, binding_point);
            binding_point += if block.is_array() { block.array_size } else { 1 };
        }

        if binding_point > max_shader_storage_buffer_bindings {
            return Err(TestError::NotSupported(
                "Test requires support for more SSBO bindings than implementation exposes".to_string(),
            ));
        }
        if binding_point > max_compute_shader_storage_blocks {
            return Err(TestError::NotSupported(
                "Test requires support for more compute shader storage blocks than implementation exposes".to_string(),
            ));
        }
    }

    // Atomic counter for counting passed invocations.
    src.push_str("\nlayout(binding = 0) uniform atomic_uint ac_numPassed;\n");

    // Comparison utilities.
    src.push('\n');
    generate_compare_funcs(&mut src, interface);

    src.push_str("\nvoid main (void)\n{\n    bool allOk = true;\n");

    // Value compare.
    generate_access_src(&mut src, Some("allOk"), interface, layout, compare_bytes);

    src.push_str("    if (allOk)\n        atomicCounterIncrement(ac_numPassed);\n\n");

    // Value write.
    generate_access_src(&mut src, None, interface, layout, write_bytes);

    src.push_str("}\n");

    Ok(src)
}

/// `getGLBufferLayout`
fn get_gl_buffer_layout(gl: &glw::Functions, program: GLuint) -> Result<BufferLayout, TestError> {
    let mut layout = BufferLayout::default();
    let mut num_active_buffer_vars = 0;
    let mut num_active_blocks = 0;

    // SAFETY: each query writes one integer.
    unsafe {
        gl.get_program_interfaceiv(
            program,
            glw::GL_BUFFER_VARIABLE,
            glw::GL_ACTIVE_RESOURCES,
            &mut num_active_buffer_vars,
        );
        gl.get_program_interfaceiv(
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            glw::GL_ACTIVE_RESOURCES,
            &mut num_active_blocks,
        );
    }
    glu::expect_no_error(gl, "Failed to get number of buffer variables and buffer blocks")?;

    for block_ndx in 0..num_active_blocks as GLuint {
        let size = glu::get_program_resource_int(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            block_ndx,
            glw::GL_BUFFER_DATA_SIZE,
        )?;
        let num_block_vars = glu::get_program_resource_int(
            gl,
            program,
            glw::GL_SHADER_STORAGE_BLOCK,
            block_ndx,
            glw::GL_NUM_ACTIVE_VARIABLES,
        )?;

        let mut active_var_indices = vec![0i32; num_block_vars.max(0) as usize];
        if num_block_vars > 0 {
            let query = glw::GL_ACTIVE_VARIABLES;
            // SAFETY: the output holds exactly the count the driver reported above.
            unsafe {
                gl.get_program_resourceiv(
                    program,
                    glw::GL_SHADER_STORAGE_BLOCK,
                    block_ndx,
                    1,
                    &query,
                    num_block_vars,
                    std::ptr::null_mut(),
                    active_var_indices.as_mut_ptr(),
                );
            }
            glu::expect_no_error(
                gl,
                "glGetProgramResourceiv(GL_SHADER_STORAGE_BLOCK, GL_ACTIVE_VARIABLES) failed",
            )?;
        }

        layout.blocks.push(BlockLayoutEntry {
            name: glu::program_interface_query::get_program_resource_name(
                gl,
                program,
                glw::GL_SHADER_STORAGE_BLOCK,
                block_ndx,
            )?,
            size,
            active_var_indices,
        });
    }

    for buf_var_ndx in 0..num_active_buffer_vars as GLuint {
        const QUERY_PARAMS: [GLenum; 9] = [
            glw::GL_BLOCK_INDEX,
            glw::GL_TYPE,
            glw::GL_OFFSET,
            glw::GL_ARRAY_SIZE,
            glw::GL_ARRAY_STRIDE,
            glw::GL_MATRIX_STRIDE,
            glw::GL_TOP_LEVEL_ARRAY_SIZE,
            glw::GL_TOP_LEVEL_ARRAY_STRIDE,
            glw::GL_IS_ROW_MAJOR,
        ];
        let mut values = [0i32; QUERY_PARAMS.len()];
        let mut return_length = 0;

        // SAFETY: the output holds one integer per property asked for.
        unsafe {
            gl.get_program_resourceiv(
                program,
                glw::GL_BUFFER_VARIABLE,
                buf_var_ndx,
                QUERY_PARAMS.len() as i32,
                QUERY_PARAMS.as_ptr(),
                values.len() as i32,
                &mut return_length,
                values.as_mut_ptr(),
            );
        }
        glu::expect_no_error(gl, "glGetProgramResourceiv(GL_BUFFER_VARIABLE) failed")?;

        if return_length != values.len() as i32 {
            return Err(TestError::Fail(
                "glGetProgramResourceiv(GL_BUFFER_VARIABLE) returned wrong number of values".to_string(),
            ));
        }

        layout.buffer_vars.push(BufferVarLayoutEntry {
            name: glu::program_interface_query::get_program_resource_name(
                gl,
                program,
                glw::GL_BUFFER_VARIABLE,
                buf_var_ndx,
            )?,
            block_ndx: values[0],
            ty: get_data_type_from_gl_type(values[1] as GLenum),
            offset: values[2],
            array_size: values[3],
            array_stride: values[4],
            matrix_stride: values[5],
            top_level_array_size: values[6],
            top_level_array_stride: values[7],
            is_row_major: values[8] != 0,
        });
    }

    Ok(layout)
}

/// `copyBufferVarData`
fn copy_buffer_var_data(
    dst_entry: &BufferVarLayoutEntry,
    dst_block: &mut [u8],
    dst_last_unsized: i32,
    src_entry: &BufferVarLayoutEntry,
    src_block: &[u8],
    src_last_unsized: i32,
) {
    let scalar_size = dst_entry.ty.scalar_size();
    let is_matrix = dst_entry.ty.is_matrix();
    let dst_array_size = if dst_entry.array_size == 0 {
        dst_last_unsized
    } else {
        dst_entry.array_size
    };
    let dst_top_level_size = if dst_entry.top_level_array_size == 0 {
        dst_last_unsized
    } else {
        dst_entry.top_level_array_size
    };
    let _ = src_last_unsized;

    for top_elem_ndx in 0..dst_top_level_size {
        let dst_top = dst_entry.offset + top_elem_ndx * dst_entry.top_level_array_stride;
        let src_top = src_entry.offset + top_elem_ndx * src_entry.top_level_array_stride;

        for element_ndx in 0..dst_array_size {
            let dst_elem = dst_top + element_ndx * dst_entry.array_stride;
            let src_elem = src_top + element_ndx * src_entry.array_stride;

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
                dst_block[dst_elem as usize..dst_elem as usize + len]
                    .copy_from_slice(&src_block[src_elem as usize..src_elem as usize + len]);
            }
        }
    }
}

/// `copyData`
///
/// \note Src layout is used as reference in case of activeVarIndices happens to be
/// incorrect in dstLayout blocks.
fn copy_data(
    dst_layout: &BufferLayout,
    dst_bytes: &mut [BlockBytes],
    src_layout: &BufferLayout,
    src_bytes: &[BlockBytes],
) {
    for (src_block_ndx, src_block) in src_layout.blocks.iter().enumerate() {
        let Some(dst_block_ndx) = dst_layout.block_index(&src_block.name) else {
            continue;
        };

        for src_var_ndx in &src_block.active_var_indices {
            let src_entry = &src_layout.buffer_vars[*src_var_ndx as usize];
            let Some(dst_var_ndx) = dst_layout.variable_index(&src_entry.name) else {
                continue;
            };

            let dst_last_unsized = dst_bytes[dst_block_ndx].last_unsized_array_size;
            copy_buffer_var_data(
                &dst_layout.buffer_vars[dst_var_ndx],
                &mut dst_bytes[dst_block_ndx].data,
                dst_last_unsized,
                src_entry,
                &src_bytes[src_block_ndx].data,
                src_bytes[src_block_ndx].last_unsized_array_size,
            );
        }
    }
}

/// `compareComponents`
fn compare_components(
    scalar_type: DataType,
    ref_bytes: &[u8],
    ref_at: usize,
    res_bytes: &[u8],
    res_at: usize,
    num_comps: i32,
) -> bool {
    (0..num_comps as usize).all(|ndx| {
        let ref_val = read_u32(ref_bytes, ref_at + ndx * 4);
        let res_val = read_u32(res_bytes, res_at + ndx * 4);

        match scalar_type {
            // Same threshold as used in shaders - should be fine for values being used.
            DataType::Float => (f32::from_bits(res_val) - f32::from_bits(ref_val)).abs() <= 0.05,
            DataType::Bool => (ref_val != 0) == (res_val != 0),
            _ => ref_val == res_val,
        }
    })
}

/// `compareBufferVarData`
fn compare_buffer_var_data(
    ref_entry: &BufferVarLayoutEntry,
    ref_block: &BlockBytes,
    res_entry: &BufferVarLayoutEntry,
    res_block: &BlockBytes,
) -> i32 {
    let scalar_type = ref_entry.ty.scalar_type();
    let scalar_size = res_entry.ty.scalar_size();
    let is_matrix = res_entry.ty.is_matrix();
    const MAX_PRINTS: i32 = 3;
    let mut num_failed = 0;

    let res_array_size = if res_entry.array_size == 0 {
        res_block.last_unsized_array_size
    } else {
        res_entry.array_size
    };
    let res_top_level_size = if res_entry.top_level_array_size == 0 {
        res_block.last_unsized_array_size
    } else {
        res_entry.top_level_array_size
    };

    for top_elem_ndx in 0..res_top_level_size {
        let res_top = res_entry.offset + top_elem_ndx * res_entry.top_level_array_stride;
        let ref_top = ref_entry.offset + top_elem_ndx * ref_entry.top_level_array_stride;

        for element_ndx in 0..res_array_size {
            let res_elem = res_top + element_ndx * res_entry.array_stride;
            let ref_elem = ref_top + element_ndx * ref_entry.array_stride;

            let is_ok = if is_matrix {
                let num_rows = res_entry.ty.matrix_num_rows();
                let num_cols = res_entry.ty.matrix_num_columns();
                let mut is_ok = true;

                for col_ndx in 0..num_cols {
                    for row_ndx in 0..num_rows {
                        let res_at = (res_elem
                            + if res_entry.is_row_major {
                                row_ndx * res_entry.matrix_stride + col_ndx * COMP_SIZE
                            } else {
                                col_ndx * res_entry.matrix_stride + row_ndx * COMP_SIZE
                            }) as usize;
                        let ref_at = (ref_elem
                            + if ref_entry.is_row_major {
                                row_ndx * ref_entry.matrix_stride + col_ndx * COMP_SIZE
                            } else {
                                col_ndx * ref_entry.matrix_stride + row_ndx * COMP_SIZE
                            }) as usize;

                        is_ok = is_ok
                            && compare_components(scalar_type, &ref_block.data, ref_at, &res_block.data, res_at, 1);
                    }
                }
                is_ok
            } else {
                compare_components(
                    scalar_type,
                    &ref_block.data,
                    ref_elem as usize,
                    &res_block.data,
                    res_elem as usize,
                    scalar_size,
                )
            };

            if !is_ok {
                num_failed += 1;
                if num_failed < MAX_PRINTS {
                    let (mut expected, mut got) = (String::new(), String::new());
                    if is_matrix {
                        generate_imm_matrix_src(
                            &mut expected,
                            ref_entry.ty,
                            ref_entry.matrix_stride,
                            ref_entry.is_row_major,
                            &ref_block.data,
                            ref_elem,
                        );
                        generate_imm_matrix_src(
                            &mut got,
                            res_entry.ty,
                            res_entry.matrix_stride,
                            res_entry.is_row_major,
                            &res_block.data,
                            res_elem,
                        );
                    } else {
                        generate_imm_scalar_vector_src(&mut expected, ref_entry.ty, &ref_block.data, ref_elem);
                        generate_imm_scalar_vector_src(&mut got, res_entry.ty, &res_block.data, res_elem);
                    }
                    log::warn!(
                        "ERROR: mismatch in {}, top-level ndx {top_elem_ndx}, bottom-level ndx {element_ndx}: expected {expected}, got {got}",
                        ref_entry.name
                    );
                }
            }
        }
    }

    if num_failed >= MAX_PRINTS {
        log::warn!("... ({num_failed} failures for {} in total)", ref_entry.name);
    }

    num_failed
}

/// `compareData`
fn compare_data(
    ref_layout: &BufferLayout,
    ref_bytes: &[BlockBytes],
    res_layout: &BufferLayout,
    res_bytes: &[BlockBytes],
) -> bool {
    let mut all_ok = true;

    for (ref_block_ndx, ref_block) in ref_layout.blocks.iter().enumerate() {
        let Some(res_block_ndx) = res_layout.block_index(&ref_block.name) else {
            continue;
        };

        for ref_var_ndx in &ref_block.active_var_indices {
            let ref_entry = &ref_layout.buffer_vars[*ref_var_ndx as usize];
            let Some(res_var_ndx) = res_layout.variable_index(&ref_entry.name) else {
                continue;
            };
            let res_entry = &res_layout.buffer_vars[res_var_ndx];
            all_ok = compare_buffer_var_data(
                ref_entry,
                &ref_bytes[ref_block_ndx],
                res_entry,
                &res_bytes[res_block_ndx],
            ) == 0
                && all_ok;
        }
    }

    all_ok
}

/// `getBlockAPIName`
fn get_block_api_name(block: &BufferBlock, instance_ndx: i32) -> String {
    format!(
        "{}{}",
        block.block_name,
        if block.is_array() {
            format!("[{instance_ndx}]")
        } else {
            String::new()
        }
    )
}

/// `computeBufferSizes`
fn compute_buffer_sizes(interface: &ShaderInterface, layout: &BufferLayout) -> Vec<i32> {
    let mut sizes = vec![0; layout.blocks.len()];

    for block in interface.blocks() {
        let num_instances = if block.is_array() { block.array_size } else { 1 };

        for instance_ndx in 0..num_instances {
            let Some(block_ndx) = layout.block_index(&get_block_api_name(block, instance_ndx)) else {
                continue;
            };
            let block_layout = &layout.blocks[block_ndx];
            let is_last_unsized = layout.has_unsized_array(block_layout);
            let last_array_size = if is_last_unsized {
                block.last_unsized_array_size(instance_ndx as usize)
            } else {
                0
            };
            let stride = if is_last_unsized {
                layout.unsized_array_stride(block_layout)
            } else {
                0
            };

            sizes[block_ndx] = block_layout.size + last_array_size * stride;
        }
    }

    sizes
}

/// `getBlockDataPtr`, minus the pointer: how long a block's unsized array came out.
fn block_last_unsized_array_size(layout: &BufferLayout, block_layout: &BlockLayoutEntry, buffer_size: i32) -> i32 {
    if layout.has_unsized_array(block_layout) {
        let last_array_stride = layout.unsized_array_stride(block_layout);
        (buffer_size - block_layout.size) / if last_array_stride != 0 { last_array_stride } else { 1 }
    } else {
        0
    }
}

/// `initRefDataStorage`
fn init_block_bytes(interface: &ShaderInterface, layout: &BufferLayout) -> Vec<BlockBytes> {
    let buffer_sizes = compute_buffer_sizes(interface, layout);

    layout
        .blocks
        .iter()
        .zip(&buffer_sizes)
        .map(|(block_layout, size)| BlockBytes {
            data: vec![0u8; (*size).max(0) as usize],
            last_unsized_array_size: block_last_unsized_array_size(layout, block_layout, *size),
        })
        .collect()
}

/// `SSBOLayoutCase::BufferMode`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum BufferMode {
    /// Single buffer shared between buffer blocks.
    Single,
    /// Per-block buffers.
    PerBlock,
}

/// Where a block's bytes live once they are packed into GL buffers.
struct BlockLocation {
    index: usize,
    offset: i32,
    size: i32,
}

/// `SSBOLayoutCase`
pub struct SsboLayoutCase {
    pub name: String,
    pub glsl_version: GlslVersion,
    pub buffer_mode: BufferMode,
    pub interface: ShaderInterface,
}

impl SsboLayoutCase {
    /// `SSBOLayoutCase::compareStdBlocks`
    fn compare_std_blocks(&self, ref_layout: &BufferLayout, cmp_layout: &BufferLayout) -> bool {
        self.compare_blocks(ref_layout, cmp_layout, LAYOUT_STD140 | LAYOUT_STD430, true)
    }

    /// `SSBOLayoutCase::compareSharedBlocks`
    fn compare_shared_blocks(&self, ref_layout: &BufferLayout, cmp_layout: &BufferLayout) -> bool {
        self.compare_blocks(ref_layout, cmp_layout, LAYOUT_SHARED, false)
    }

    /// The body upstream repeats in `compareStdBlocks`/`compareSharedBlocks`; a shared
    /// block's offsets and strides are the driver's choice, so only the std* variant
    /// compares them.
    fn compare_blocks(
        &self,
        ref_layout: &BufferLayout,
        cmp_layout: &BufferLayout,
        layout_mask: u32,
        check_offsets: bool,
    ) -> bool {
        let mut is_ok = true;

        for block in self.interface.blocks() {
            let instance_name = format!("{}{}", block.block_name, if block.is_array() { "[0]" } else { "" });

            if block.flags & layout_mask == 0 {
                continue; // Not this layout.
            }

            let Some(ref_block_ndx) = ref_layout.block_index(&instance_name) else {
                continue;
            };
            let Some(cmp_block_ndx) = cmp_layout.block_index(&instance_name) else {
                log::warn!("Error: Buffer block '{instance_name}' not found");
                is_ok = false;
                continue;
            };

            let ref_block_layout = &ref_layout.blocks[ref_block_ndx];
            let cmp_block_layout = &cmp_layout.blocks[cmp_block_ndx];

            if ref_block_layout.active_var_indices.len() != cmp_block_layout.active_var_indices.len() {
                log::warn!(
                    "Error: Number of active variables differ in block '{instance_name}' (expected {}, got {})",
                    ref_block_layout.active_var_indices.len(),
                    cmp_block_layout.active_var_indices.len()
                );
                is_ok = false;
            }

            for ndx in &ref_block_layout.active_var_indices {
                let ref_entry = &ref_layout.buffer_vars[*ndx as usize];
                let Some(cmp_entry_ndx) = cmp_layout.variable_index(&ref_entry.name) else {
                    log::warn!("Error: Buffer variable '{}' not found", ref_entry.name);
                    is_ok = false;
                    continue;
                };
                let cmp_entry = &cmp_layout.buffer_vars[cmp_entry_ndx];

                let mismatch = ref_entry.ty != cmp_entry.ty
                    || ref_entry.array_size != cmp_entry.array_size
                    || ref_entry.top_level_array_size != cmp_entry.top_level_array_size
                    || ref_entry.is_row_major != cmp_entry.is_row_major
                    || (check_offsets
                        && (ref_entry.offset != cmp_entry.offset
                            || ref_entry.array_stride != cmp_entry.array_stride
                            || ref_entry.matrix_stride != cmp_entry.matrix_stride
                            || ref_entry.top_level_array_stride != cmp_entry.top_level_array_stride));

                if mismatch {
                    log::warn!(
                        "Error: Layout mismatch in '{}': expected {}, got {}",
                        ref_entry.name,
                        ref_entry.describe(),
                        cmp_entry.describe()
                    );
                    is_ok = false;
                }
            }
        }

        is_ok
    }

    /// `SSBOLayoutCase::compareTypes`
    fn compare_types(&self, ref_layout: &BufferLayout, cmp_layout: &BufferLayout) -> bool {
        let mut is_ok = true;

        for block in self.interface.blocks() {
            let num_instances = if block.is_array() { block.array_size } else { 1 };

            for instance_ndx in 0..num_instances {
                let Some(cmp_block_ndx) = cmp_layout.block_index(&get_block_api_name(block, instance_ndx)) else {
                    continue;
                };

                for ndx in &cmp_layout.blocks[cmp_block_ndx].active_var_indices {
                    let cmp_entry = &cmp_layout.buffer_vars[*ndx as usize];
                    let Some(ref_entry_ndx) = ref_layout.variable_index(&cmp_entry.name) else {
                        log::warn!(
                            "Error: Buffer variable '{}' not found in reference layout",
                            cmp_entry.name
                        );
                        is_ok = false;
                        continue;
                    };
                    let ref_entry = &ref_layout.buffer_vars[ref_entry_ndx];

                    if ref_entry.ty != cmp_entry.ty {
                        log::warn!(
                            "Error: Buffer variable type mismatch in '{}': expected {}, got {}",
                            ref_entry.name,
                            ref_entry.ty.name(),
                            cmp_entry.ty.name()
                        );
                        is_ok = false;
                    }
                    if ref_entry.array_size < cmp_entry.array_size {
                        log::warn!(
                            "Error: Invalid array size in '{}': expected <= {}",
                            ref_entry.name,
                            ref_entry.array_size
                        );
                        is_ok = false;
                    }
                    if ref_entry.top_level_array_size < cmp_entry.top_level_array_size {
                        log::warn!(
                            "Error: Invalid top-level array size in '{}': expected <= {}",
                            ref_entry.name,
                            ref_entry.top_level_array_size
                        );
                        is_ok = false;
                    }
                }
            }
        }

        is_ok
    }

    /// `SSBOLayoutCase::checkLayoutIndices`
    fn check_layout_indices(layout: &BufferLayout) -> bool {
        let num_vars = layout.buffer_vars.len() as i32;
        let num_blocks = layout.blocks.len() as i32;
        let mut is_ok = true;

        for buf_var in &layout.buffer_vars {
            if buf_var.block_ndx < 0 || buf_var.block_ndx >= num_blocks {
                log::warn!("Error: Invalid block index in buffer variable '{}'", buf_var.name);
                is_ok = false;
            }
        }

        for block in &layout.blocks {
            for var_ndx in &block.active_var_indices {
                if *var_ndx < 0 || *var_ndx >= num_vars {
                    log::warn!(
                        "Error: Invalid active variable index {var_ndx} in block '{}'",
                        block.name
                    );
                    is_ok = false;
                }
            }
        }

        is_ok
    }

    /// `SSBOLayoutCase::checkLayoutBounds`
    fn check_layout_bounds(layout: &BufferLayout) -> bool {
        let mut is_ok = true;

        for var in &layout.buffer_vars {
            if var.block_ndx < 0 || var.is_unsized_array() {
                continue;
            }

            let block = &layout.blocks[var.block_ndx as usize];
            let is_matrix = var.ty.is_matrix();
            let num_vecs = if is_matrix {
                if var.is_row_major {
                    var.ty.matrix_num_rows()
                } else {
                    var.ty.matrix_num_columns()
                }
            } else {
                1
            };
            let num_comps = if is_matrix {
                if var.is_row_major {
                    var.ty.matrix_num_columns()
                } else {
                    var.ty.matrix_num_rows()
                }
            } else {
                var.ty.scalar_size()
            };
            let num_elements = var.array_size;
            let top_level_size = var.top_level_array_size;
            let vec_size = num_comps * COMP_SIZE;

            // For negative strides.
            let min_offset = 0
                .min((num_vecs - 1) * var.matrix_stride)
                .min((num_elements - 1) * var.array_stride)
                .min(
                    (top_level_size - 1) * var.top_level_array_stride
                        + (num_elements - 1) * var.array_stride
                        + (num_vecs - 1) * var.matrix_stride,
                );
            let max_offset = vec_size
                .max((num_vecs - 1) * var.matrix_stride + vec_size)
                .max((num_elements - 1) * var.array_stride + vec_size)
                .max(
                    (top_level_size - 1) * var.top_level_array_stride
                        + (num_elements - 1) * var.array_stride
                        + vec_size,
                )
                .max(
                    (top_level_size - 1) * var.top_level_array_stride
                        + (num_elements - 1) * var.array_stride
                        + (num_vecs - 1) * var.matrix_stride
                        + vec_size,
                );

            if var.offset + min_offset < 0 || var.offset + max_offset > block.size {
                log::warn!("Error: Variable '{}' out of block bounds", var.name);
                is_ok = false;
            }
        }

        is_ok
    }

    /// `SSBOLayoutCase::checkIndexQueries`
    ///
    /// \note Spec mandates that buffer blocks are assigned consecutive locations from 0.
    fn check_index_queries(gl: &glw::Functions, program: GLuint, layout: &BufferLayout) -> Result<bool, TestError> {
        let mut all_ok = true;

        for (block_ndx, block) in layout.blocks.iter().enumerate() {
            let name = std::ffi::CString::new(block.name.as_str()).expect("block name holds a nul byte");
            // SAFETY: the name is nul-terminated and the program is this case's own.
            let queried_ndx =
                unsafe { gl.get_program_resource_index(program, glw::GL_SHADER_STORAGE_BLOCK, name.as_ptr()) };

            if queried_ndx as usize != block_ndx {
                log::warn!(
                    "ERROR: glGetProgramResourceIndex({}) returned {queried_ndx}, expected {block_ndx}!",
                    block.name
                );
                all_ok = false;
            }

            glu::expect_no_error(gl, "glGetProgramResourceIndex()")?;
        }

        Ok(all_ok)
    }

    /// `SSBOLayoutCase::execute`
    fn execute(gl: &glw::Functions, program: GLuint) -> Result<bool, TestError> {
        let name = c"ac_numPassed";
        // SAFETY: the name is nul-terminated and the program is this case's own.
        let num_passed_loc = unsafe { gl.get_program_resource_index(program, glw::GL_UNIFORM, name.as_ptr()) };

        if num_passed_loc == glw::GL_INVALID_INDEX {
            return Err(TestError::Fail("No location for ac_numPassed found".to_string()));
        }

        let ac_var_info = glu::get_program_interface_variable_info(gl, program, glw::GL_UNIFORM, num_passed_loc)?;
        if ac_var_info.atomic_counter_buffer_index == glw::GL_INVALID_INDEX {
            return Err(TestError::Fail(
                "ac_numPassed buffer index is GL_INVALID_INDEX".to_string(),
            ));
        }

        let ac_buffer_info = glu::get_program_interface_block_info(
            gl,
            program,
            glw::GL_ATOMIC_COUNTER_BUFFER,
            ac_var_info.atomic_counter_buffer_index,
        )?;
        if ac_buffer_info.data_size == 0 {
            return Err(TestError::Fail("ac_numPassed buffer size = 0".to_string()));
        }

        let ac_buffer = glu::Buffer::new(gl);
        let empty_data = vec![0u8; ac_buffer_info.data_size as usize];

        // SAFETY: the buffer is this case's own and the upload reads exactly `empty_data`.
        let res_count = unsafe {
            gl.bind_buffer(glw::GL_ATOMIC_COUNTER_BUFFER, ac_buffer.get());
            gl.buffer_data(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                empty_data.len() as isize,
                empty_data.as_ptr().cast(),
                glw::GL_STATIC_READ,
            );
            gl.bind_buffer_base(glw::GL_ATOMIC_COUNTER_BUFFER, ac_buffer_info.index, ac_buffer.get());
            glu::expect_no_error(gl, "Setting up buffer for ac_numPassed failed")?;

            gl.use_program(program);
            gl.dispatch_compute(1, 1, 1);
            glu::expect_no_error(gl, "glDispatchCompute() failed")?;

            let map_ptr = gl.map_buffer_range(
                glw::GL_ATOMIC_COUNTER_BUFFER,
                0,
                ac_buffer_info.data_size as isize,
                glw::GL_MAP_READ_BIT,
            );
            glu::expect_no_error(gl, "glMapBufferRange(GL_ATOMIC_COUNTER_BUFFER) failed")?;
            if map_ptr.is_null() {
                return Err(TestError::Fail(
                    "glMapBufferRange(GL_ATOMIC_COUNTER_BUFFER) returned NULL".to_string(),
                ));
            }

            let mapped = std::slice::from_raw_parts(map_ptr.cast::<u8>(), ac_buffer_info.data_size as usize);
            let res_count = read_u32(mapped, ac_var_info.offset as usize) as i32;

            gl.unmap_buffer(glw::GL_ATOMIC_COUNTER_BUFFER);
            glu::expect_no_error(gl, "glUnmapBuffer(GL_ATOMIC_COUNTER_BUFFER) failed")?;

            res_count
        };

        if res_count != 1 {
            log::warn!("ERROR: ac_numPassed = {res_count}, expected 1");
            return Ok(false);
        }

        Ok(true)
    }
}

impl TestCase for SsboLayoutCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `SSBOLayoutCase::iterate`
    #[allow(clippy::too_many_lines)]
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();

        let ref_layout = compute_reference_layout(&self.interface);
        let mut initial_data = init_block_bytes(&self.interface, &ref_layout);
        let mut write_data = init_block_bytes(&self.interface, &ref_layout);

        generate_values(&ref_layout, &mut initial_data, de_string_hash(&self.name) ^ 0xad2f_7214);
        generate_values(&ref_layout, &mut write_data, de_string_hash(&self.name) ^ 0x025c_a4e7);
        copy_non_written_data(&self.interface, &ref_layout, &initial_data, &mut write_data);

        let compute_src = generate_compute_shader(
            gl,
            self.glsl_version,
            &self.interface,
            &ref_layout,
            &initial_data,
            &write_data,
        )?;
        let program = ShaderProgram::new(gl, &ProgramSources::compute(compute_src));

        if !program.is_ok() {
            return Ok(TestStatus::fail("Compile failed"));
        }
        let program_gl = program.program();

        // Query layout from GL.
        let gl_layout = get_gl_buffer_layout(gl, program_gl)?;

        // Verify layouts.
        if !Self::check_layout_indices(&gl_layout)
            || !Self::check_layout_bounds(&gl_layout)
            || !self.compare_types(&ref_layout, &gl_layout)
        {
            // It is not safe to use the given layout.
            return Ok(TestStatus::fail("Invalid layout"));
        }

        let mut failure: Option<&'static str> = None;

        if !self.compare_std_blocks(&ref_layout, &gl_layout) {
            failure = Some("Invalid std140 or std430 layout");
        }
        if !self.compare_shared_blocks(&ref_layout, &gl_layout) {
            failure = failure.or(Some("Invalid shared layout"));
        }
        if !Self::check_index_queries(gl, program_gl, &gl_layout)? {
            failure = failure.or(Some("Inconsintent block index query results"));
        }

        // Allocate GL buffers & compute placement.
        let buffer_sizes = compute_buffer_sizes(&self.interface, &gl_layout);
        let num_blocks = gl_layout.blocks.len();
        let mut block_locations = Vec::with_capacity(num_blocks);
        let mut buffer_bytes: Vec<Vec<u8>>;

        if self.buffer_mode == BufferMode::PerBlock {
            buffer_bytes = buffer_sizes
                .iter()
                .map(|size| vec![0u8; (*size).max(0) as usize])
                .collect();
            for (block_ndx, size) in buffer_sizes.iter().enumerate() {
                block_locations.push(BlockLocation {
                    index: block_ndx,
                    offset: 0,
                    size: *size,
                });
            }
        } else {
            let mut binding_alignment = 0;
            // SAFETY: the query writes one integer.
            unsafe { gl.get_integerv(glw::GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT, &mut binding_alignment) };

            let mut cur_offset = 0;
            for size in &buffer_sizes {
                if binding_alignment > 0 {
                    cur_offset = align_up(cur_offset, binding_alignment);
                }
                block_locations.push(BlockLocation {
                    index: 0,
                    offset: cur_offset,
                    size: *size,
                });
                cur_offset += size;
            }
            buffer_bytes = vec![vec![0u8; cur_offset.max(0) as usize]];
        }

        // The mapped-block view of that storage, which is what `copy_data` writes into.
        let mut gl_block_bytes: Vec<BlockBytes> = gl_layout
            .blocks
            .iter()
            .zip(&block_locations)
            .map(|(block_layout, location)| BlockBytes {
                data: vec![0u8; location.size.max(0) as usize],
                last_unsized_array_size: block_last_unsized_array_size(&gl_layout, block_layout, location.size),
            })
            .collect();

        copy_data(&gl_layout, &mut gl_block_bytes, &ref_layout, &initial_data);

        for (block_ndx, location) in block_locations.iter().enumerate() {
            let at = location.offset as usize;
            let bytes = &gl_block_bytes[block_ndx].data;
            buffer_bytes[location.index][at..at + bytes.len()].copy_from_slice(bytes);
        }

        let buffers: Vec<glu::Buffer<'_>> = buffer_bytes.iter().map(|_| glu::Buffer::new(gl)).collect();

        // SAFETY: every buffer name is this case's own and each upload reads exactly its
        // own byte vector.
        unsafe {
            for (buffer, data) in buffers.iter().zip(&buffer_bytes) {
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer.get());
                gl.buffer_data(
                    glw::GL_SHADER_STORAGE_BUFFER,
                    data.len() as isize,
                    if data.is_empty() {
                        std::ptr::null()
                    } else {
                        data.as_ptr().cast()
                    },
                    glw::GL_STATIC_DRAW,
                );
                glu::expect_no_error(gl, "Failed to allocate buffer")?;
            }

            let mut binding_point = 0;
            for block in self.interface.blocks() {
                let num_inst = if block.is_array() { block.array_size } else { 1 };

                for inst_ndx in 0..num_inst {
                    if let Some(layout_ndx) = gl_layout.block_index(&get_block_api_name(block, inst_ndx)) {
                        let block_loc = &block_locations[layout_ndx];
                        if block_loc.size > 0 {
                            gl.bind_buffer_range(
                                glw::GL_SHADER_STORAGE_BUFFER,
                                binding_point,
                                buffers[block_loc.index].get(),
                                block_loc.offset as isize,
                                block_loc.size as isize,
                            );
                        }
                    }
                    binding_point += 1;
                }
            }
        }
        glu::expect_no_error(gl, "Failed to bind buffers")?;

        if !Self::execute(gl, program_gl)? {
            return Ok(TestStatus::fail("Shader execution failed"));
        }

        // Read the buffers back and compare against what the shader was told to write.
        // SAFETY: each range is the one just uploaded, and the mapping is dropped before
        // the buffer is.
        unsafe {
            for (buffer, data) in buffers.iter().zip(&mut buffer_bytes) {
                if data.is_empty() {
                    continue;
                }
                gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, buffer.get());
                let len = data.len();
                let map_ptr = gl.map_buffer_range(glw::GL_SHADER_STORAGE_BUFFER, 0, len as isize, glw::GL_MAP_READ_BIT);
                glu::expect_no_error(gl, "Failed to map buffer")?;
                if map_ptr.is_null() {
                    return Err(TestError::Fail(
                        "glMapBufferRange(GL_SHADER_STORAGE_BUFFER) returned NULL".to_string(),
                    ));
                }
                data.copy_from_slice(std::slice::from_raw_parts(map_ptr.cast::<u8>(), len));
                gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER);
            }
            glu::expect_no_error(gl, "Failed to unmap buffer")?;
        }

        for (block_ndx, location) in block_locations.iter().enumerate() {
            let at = location.offset as usize;
            let len = gl_block_bytes[block_ndx].data.len();
            gl_block_bytes[block_ndx]
                .data
                .copy_from_slice(&buffer_bytes[location.index][at..at + len]);
        }

        if !compare_data(&ref_layout, &write_data, &gl_layout, &gl_block_bytes) {
            failure = failure.or(Some("Result comparison failed"));
        }

        // SAFETY: unbinding needs only a current context.
        unsafe {
            gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, 0);
            for block_ndx in 0..num_blocks {
                gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, block_ndx as GLuint, 0);
            }
        }

        Ok(match failure {
            Some(message) => TestStatus::fail(message),
            None => TestStatus::pass("Pass"),
        })
    }
}
