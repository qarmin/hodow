// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderAtomicOpTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's eight `ShaderAtomicOpCase`
// subclasses differ only in `getInputs` and `verify`, so they are one `AtomicOp` enum
// matched on twice rather than eight structs. `atomicCompSwap` keeps its own case type,
// as upstream does - its buffer block has four arrays instead of three and it verifies
// inline.
//
// Only `ATOMIC_OPERAND_BUFFER_VARIABLE` is registered: the shared-variable half belongs
// to `compute.shared_var`, which is not ported. The generator keeps both branches
// anyway, since dropping one would make re-syncing the shader source harder to check.

use std::collections::BTreeSet;

use crate::glu::{self, Buffer, Context, DataType, Precision, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::random::de_string_hash;
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};

/// `AtomicOperandType`
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum AtomicOperandType {
    BufferVariable,
    SharedVariable,
}

/// The work group size every case in this file uses, and the number of groups dispatched.
const WORK_GROUP_SIZE: [u32; 3] = [3, 2, 1];
const NUM_WORK_GROUPS: [u32; 3] = [4, 4, 4];

fn product(v: [u32; 3]) -> u32 {
    v[0] * v[1] * v[2]
}

/// Which `ShaderAtomicOpCase` subclass this is.
#[derive(Clone, Copy, PartialEq, Eq)]
enum AtomicOp {
    Add,
    Min,
    Max,
    And,
    Or,
    Xor,
    Exchange,
}

impl AtomicOp {
    fn func_name(self) -> &'static str {
        match self {
            Self::Add => "atomicAdd",
            Self::Min => "atomicMin",
            Self::Max => "atomicMax",
            Self::And => "atomicAnd",
            Self::Or => "atomicOr",
            Self::Xor => "atomicXor",
            Self::Exchange => "atomicExchange",
        }
    }

    /// Each subclass's constructor body, which is where `m_initialValue` is set.
    fn initial_value(self, ty: DataType, precision: Precision) -> u32 {
        let is_signed = ty == DataType::Int;
        match self {
            Self::Add => 1,
            Self::Min => {
                if precision == Precision::LowP {
                    100
                } else {
                    1000
                }
            }
            Self::Max => {
                if is_signed {
                    if precision == Precision::LowP {
                        -100i32 as u32
                    } else {
                        -1000i32 as u32
                    }
                } else {
                    0
                }
            }
            Self::And => {
                let num_bits = num_bits(precision);
                let value_mask = if num_bits == 32 { !0u32 } else { (1u32 << num_bits) - 1 };
                // All bits except lowest and highest set.
                !((1u32 << (num_bits - 1)) | 1) & value_mask
            }
            // Lowest bit set.
            Self::Or => 1,
            Self::Xor | Self::Exchange => 0,
        }
    }
}

/// The bit width the bitwise cases treat as significant for a precision.
fn num_bits(precision: Precision) -> u32 {
    match precision {
        Precision::HighP => 32,
        Precision::MediumP => 16,
        Precision::LowP => 8,
    }
}

/// `getPrecisionNumIntegerBits` - note this is *not* `num_bits`: the min/max cases allow
/// a wider lowp than the bitwise ones do.
fn precision_num_integer_bits(precision: Precision) -> u32 {
    match precision {
        Precision::HighP => 32,
        Precision::MediumP => 16,
        Precision::LowP => 9,
    }
}

/// `getPrecisionMask`
fn precision_mask(num_precise_bits: u32) -> u32 {
    ((1u64 << num_precise_bits) - 1) as u32
}

/// `intEqualsAfterUintCast`
///
/// The bit format of `casted` is `[uint -> highp uint promotion bits (0)][sign extend
/// bits][value bits]`, so anything above the precision's own width may legally be either
/// the sign extension or zero.
fn int_equals_after_uint_cast(value: i32, casted: u32, precision: Precision) -> bool {
    let reference = value as u32;
    let sign_bit_on = value < 0;
    let num_precise_bits = precision_num_integer_bits(precision);
    let precise_mask = precision_mask(num_precise_bits);

    // Lowest N bits must match, N = minimum precision.
    if (reference & precise_mask) != (casted & precise_mask) {
        return false;
    }

    // The remaining bits must match the sign, and anything above that must be 0.
    (num_precise_bits..=32).any(|signed_integer_length| {
        let sign_bits = if sign_bit_on {
            precision_mask(signed_integer_length)
        } else {
            0
        };
        (sign_bits & !precise_mask) == (casted & !precise_mask)
    })
}

/// `ShaderAtomicOpCase`, `ShaderAtomicCompSwapCase`: the buffer block's layout, read from
/// the program rather than assumed.
struct BlockLayout {
    data_size: usize,
    /// `(offset, arrayStride)` per array, in the block's declaration order.
    arrays: Vec<(usize, usize)>,
}

fn query_block_layout(
    context: &Context,
    program: GLuint,
    array_names: &[&str],
    expected_sizes: &[u32],
) -> Result<BlockLayout, TestError> {
    let gl = context.gl();
    // SAFETY: the program linked, and `InOut` is declared in it.
    let block_ndx = unsafe { gl.get_program_resource_index(program, glw::GL_SHADER_STORAGE_BLOCK, c"InOut".as_ptr()) };
    let block_info = glu::get_program_interface_block_info(gl, program, glw::GL_SHADER_STORAGE_BLOCK, block_ndx)?;

    let mut arrays = Vec::with_capacity(array_names.len());
    for (name, expected_size) in array_names.iter().zip(expected_sizes) {
        let c_name = std::ffi::CString::new(*name).expect("static name has no interior nul");
        // SAFETY: as above.
        let ndx = unsafe { gl.get_program_resource_index(program, glw::GL_BUFFER_VARIABLE, c_name.as_ptr()) };
        let info = glu::get_program_interface_variable_info(gl, program, glw::GL_BUFFER_VARIABLE, ndx)?;

        if info.array_size != *expected_size {
            return Err(TestError::Fail(format!(
                "{name} has array size {}, expected {expected_size}",
                info.array_size
            )));
        }

        arrays.push((info.offset as usize, info.array_stride as usize));
    }

    Ok(BlockLayout {
        data_size: block_info.data_size as usize,
        arrays,
    })
}

/// Reads one 32-bit element out of a block-sized byte buffer.
fn get_u32(data: &[u8], (offset, stride): (usize, usize), ndx: usize) -> u32 {
    let at = offset + stride * ndx;
    u32::from_ne_bytes(data[at..at + 4].try_into().expect("four bytes inside the block"))
}

fn set_u32(data: &mut [u8], (offset, stride): (usize, usize), ndx: usize, value: u32) {
    let at = offset + stride * ndx;
    data[at..at + 4].copy_from_slice(&value.to_ne_bytes());
}

/// `glDispatchCompute` over the block buffer, then the mapped read-back.
fn run_compute(context: &Context, program: GLuint, buf_data: &[u8]) -> Result<Vec<u8>, TestError> {
    let gl = context.gl();
    let inout_buffer = Buffer::new(gl);

    // SAFETY: the upload covers exactly the block's size, and the read-back maps the
    // same range and is copied out before the unmap.
    unsafe {
        gl.use_program(program);
        gl.bind_buffer(glw::GL_SHADER_STORAGE_BUFFER, inout_buffer.get());
        gl.buffer_data(
            glw::GL_SHADER_STORAGE_BUFFER,
            buf_data.len() as isize,
            buf_data.as_ptr().cast(),
            glw::GL_STATIC_READ,
        );
        gl.bind_buffer_base(glw::GL_SHADER_STORAGE_BUFFER, 0, inout_buffer.get());
        glu::expect_no_error(gl, "Output buffer setup failed")?;

        gl.dispatch_compute(NUM_WORK_GROUPS[0], NUM_WORK_GROUPS[1], NUM_WORK_GROUPS[2]);

        let res_ptr = gl.map_buffer_range(
            glw::GL_SHADER_STORAGE_BUFFER,
            0,
            buf_data.len() as isize,
            glw::GL_MAP_READ_BIT,
        );
        glu::expect_no_error(gl, "glMapBufferRange()")?;
        if res_ptr.is_null() {
            return Err(TestError::Fail("glMapBufferRange returned null".to_string()));
        }

        let result = std::slice::from_raw_parts(res_ptr.cast::<u8>(), buf_data.len()).to_vec();

        gl.unmap_buffer(glw::GL_SHADER_STORAGE_BUFFER);
        glu::expect_no_error(gl, "glUnmapBuffer()")?;

        Ok(result)
    }
}

/// `ShaderAtomicOpCase`
struct ShaderAtomicOpCase {
    name: String,
    op: AtomicOp,
    operand_type: AtomicOperandType,
    ty: DataType,
    precision: Precision,
}

impl ShaderAtomicOpCase {
    /// `ShaderAtomicOpCase::init`'s shader source.
    fn gen_compute_source(&self) -> String {
        let is_ssbo = self.operand_type == AtomicOperandType::BufferVariable;
        let prec_name = self.precision.name();
        let type_name = self.ty.name();
        let out_type = if is_ssbo { self.ty } else { DataType::Uint };
        let out_type_name = out_type.name();
        let num_values = product(WORK_GROUP_SIZE) * product(NUM_WORK_GROUPS);
        let initial_value = self.op.initial_value(self.ty, self.precision);

        let mut src = String::new();
        src.push_str(&format!(
            "#version 310 es\n\
             layout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\n\
             layout(binding = 0) buffer InOut\n\
             {{\n    \
             {prec_name} {type_name} inputValues[{num_values}];\n    \
             {prec_name} {out_type_name} outputValues[{num_values}];\n    \
             {}{prec_name} {out_type_name} groupValues[{}];\n\
             }} sb_inout;\n",
            WORK_GROUP_SIZE[0],
            WORK_GROUP_SIZE[1],
            WORK_GROUP_SIZE[2],
            if is_ssbo { "coherent " } else { "" },
            product(NUM_WORK_GROUPS),
        ));

        if !is_ssbo {
            src.push_str(&format!("shared {prec_name} {type_name} s_var;\n"));
        }

        src.push_str(
            "\nvoid main (void)\n\
             {\n    \
             uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;\n    \
             uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n    \
             uint globalOffs = localSize*globalNdx;\n    \
             uint offset     = globalOffs + gl_LocalInvocationIndex;\n\n",
        );

        let func_name = self.op.func_name();
        if is_ssbo {
            src.push_str(&format!(
                "    sb_inout.outputValues[offset] = {func_name}(sb_inout.groupValues[globalNdx], sb_inout.inputValues[offset]);\n"
            ));
        } else {
            let (cast_beg, cast_end) = if out_type != self.ty {
                (format!("{out_type_name}("), ")")
            } else {
                (String::new(), "")
            };
            src.push_str(&format!(
                "    if (gl_LocalInvocationIndex == 0u)\n        \
                 s_var = {type_name}({initial_value:#x}u);\n    \
                 barrier();\n    \
                 {prec_name} {type_name} res = {func_name}(s_var, sb_inout.inputValues[offset]);\n    \
                 sb_inout.outputValues[offset] = {cast_beg}res{cast_end};\n    \
                 barrier();\n    \
                 if (gl_LocalInvocationIndex == 0u)\n        \
                 sb_inout.groupValues[globalNdx] = {cast_beg}s_var{cast_end};\n"
            ));
        }

        src.push_str("}\n");
        src
    }

    /// The subclasses' `getInputs`.
    fn get_inputs(&self, num_values: usize, out: &mut Vec<u32>) {
        let mut rnd = Random::new(de_string_hash(&self.name));
        let is_signed = self.ty == DataType::Int;
        let work_group_size = product(WORK_GROUP_SIZE) as usize;
        let num_work_groups = num_values / work_group_size;
        let bits = num_bits(self.precision);

        out.clear();
        out.resize(num_values, 0);

        match self.op {
            AtomicOp::Add => {
                // \todo [2013-09-04 pyry] Negative values!
                let max_val = if self.precision == Precision::LowP { 2 } else { 32 };
                for value in out.iter_mut() {
                    *value = rnd.get_int(1, max_val) as u32;
                }
            }
            AtomicOp::Min | AtomicOp::Max => {
                let max_val = if self.precision == Precision::LowP { 100 } else { 1000 };
                let min_val = if is_signed { -max_val } else { 0 };
                for value in out.iter_mut() {
                    *value = rnd.get_int(min_val, max_val) as u32;
                }
            }
            AtomicOp::And => {
                let value_mask = if bits == 32 { !0u32 } else { (1u32 << bits) - 1 };
                for group_ndx in 0..num_work_groups {
                    // One bit is always set.
                    let group_mask = 1u32 << rnd.get_int(0, bits as i32 - 2);
                    for local_ndx in 0..work_group_size {
                        out[group_ndx * work_group_size + local_ndx] = (rnd.get_uint32() & value_mask) | group_mask;
                    }
                }
            }
            AtomicOp::Or => {
                for group_ndx in 0..num_work_groups {
                    for local_ndx in 0..work_group_size {
                        out[group_ndx * work_group_size + local_ndx] = 1u32 << rnd.get_int(0, bits as i32 - 1);
                    }
                }
            }
            AtomicOp::Xor => {
                for group_ndx in 0..num_work_groups {
                    let group_offset = group_ndx * work_group_size;
                    // The first uses a random bit pattern.
                    out[group_offset] = rnd.get_uint32();
                    // The rest have either all or no bits set.
                    for local_ndx in 1..work_group_size {
                        out[group_offset + local_ndx] = if rnd.get_bool() { !0u32 } else { 0 };
                    }
                }
            }
            AtomicOp::Exchange => {
                for group_ndx in 0..num_work_groups {
                    for local_ndx in 0..work_group_size {
                        out[group_ndx * work_group_size + local_ndx] = local_ndx as u32 + 1;
                    }
                }
            }
        }
    }

    /// The subclasses' `verify`.
    fn verify(&self, num_values: usize, inputs: &[u32], outputs: &[u32], group_outputs: &[u32]) -> bool {
        let work_group_size = product(WORK_GROUP_SIZE) as usize;
        let num_work_groups = num_values / work_group_size;
        let initial_value = self.op.initial_value(self.ty, self.precision);
        let bits = num_bits(self.precision);

        match self.op {
            AtomicOp::Add => self.verify_add(
                num_work_groups,
                work_group_size,
                inputs,
                outputs,
                group_outputs,
                initial_value,
            ),
            AtomicOp::Min | AtomicOp::Max => self.verify_min_max(
                num_work_groups,
                work_group_size,
                inputs,
                outputs,
                group_outputs,
                initial_value,
            ),
            AtomicOp::And | AtomicOp::Or => {
                self.verify_and_or(num_work_groups, work_group_size, inputs, outputs, group_outputs)
            }
            AtomicOp::Xor => {
                let compare_mask = if bits == 32 { !0u32 } else { (1u32 << bits) - 1 };
                verify_xor(
                    num_work_groups,
                    work_group_size,
                    inputs,
                    outputs,
                    group_outputs,
                    initial_value,
                    compare_mask,
                )
            }
            AtomicOp::Exchange => verify_exchange(num_work_groups, work_group_size, outputs, group_outputs),
        }
    }

    /// `ShaderAtomicAddCase::verify`
    fn verify_add(
        &self,
        num_work_groups: usize,
        work_group_size: usize,
        inputs: &[u32],
        outputs: &[u32],
        group_outputs: &[u32],
        initial_value: u32,
    ) -> bool {
        for (group_ndx, group_output) in group_outputs.iter().take(num_work_groups).enumerate() {
            let group_offset = group_ndx * work_group_size;
            let group_output = *group_output as i32;
            let mut out_values = BTreeSet::new();
            let mut max_found = false;
            let value_sum: i32 = initial_value as i32
                + (0..work_group_size)
                    .map(|i| inputs[group_offset + i] as i32)
                    .sum::<i32>();

            if group_output != value_sum {
                log::warn!("ERROR: at group {group_ndx}: expected sum {value_sum}, got {group_output}");
                return false;
            }

            for local_ndx in 0..work_group_size {
                let input_value = inputs[group_offset + local_ndx] as i32;
                let output_value = outputs[group_offset + local_ndx] as i32;

                if !(initial_value as i32..=value_sum - input_value).contains(&output_value) {
                    log::warn!(
                        "ERROR: at group {group_ndx}, invocation {local_ndx}: expected value in range [{initial_value}, {}], got {output_value}",
                        value_sum - input_value
                    );
                    return false;
                }

                if !out_values.insert(output_value) {
                    log::warn!(
                        "ERROR: at group {group_ndx}, invocation {local_ndx}: found duplicate value {output_value}"
                    );
                    return false;
                }

                if output_value == value_sum - input_value {
                    max_found = true;
                }
            }

            if !max_found {
                log::warn!("ERROR: could not find maximum expected value from group {group_ndx}");
                return false;
            }

            if !out_values.contains(&(initial_value as i32)) {
                log::warn!("ERROR: could not find initial value from group {group_ndx}");
                return false;
            }
        }

        true
    }

    /// `ShaderAtomicMinCase::verify` / `ShaderAtomicMaxCase::verify`, which differ only
    /// in which way they fold the inputs.
    fn verify_min_max(
        &self,
        num_work_groups: usize,
        work_group_size: usize,
        inputs: &[u32],
        outputs: &[u32],
        group_outputs: &[u32],
        initial_value: u32,
    ) -> bool {
        let mut any_error = false;

        for (group_ndx, group_output) in group_outputs.iter().take(num_work_groups).enumerate() {
            let group_offset = group_ndx * work_group_size;
            let group_output = *group_output;
            let mut in_values = BTreeSet::new();
            let mut out_values = BTreeSet::new();
            let mut folded = initial_value as i32;

            for local_ndx in 0..work_group_size {
                let input_value = inputs[group_offset + local_ndx] as i32;
                in_values.insert(input_value);
                folded = if self.op == AtomicOp::Min {
                    input_value.min(folded)
                } else {
                    folded.max(input_value)
                };
            }

            if !int_equals_after_uint_cast(folded, group_output, self.precision) {
                log::warn!(
                    "ERROR: at group {group_ndx}: expected {folded} ({folded:#010x}), got {group_output} ({group_output:#010x})"
                );
                any_error = true;
            }

            for local_ndx in 0..work_group_size {
                let output_value = outputs[group_offset + local_ndx];

                let matches_input = in_values
                    .iter()
                    .any(|v| int_equals_after_uint_cast(*v, output_value, self.precision));
                if !matches_input && !int_equals_after_uint_cast(initial_value as i32, output_value, self.precision) {
                    log::warn!(
                        "ERROR: at group {group_ndx}, invocation {local_ndx}: found unexpected value {output_value} ({output_value:#010x})"
                    );
                    any_error = true;
                }

                out_values.insert(output_value);
            }

            if !out_values
                .iter()
                .any(|v| int_equals_after_uint_cast(initial_value as i32, *v, self.precision))
            {
                log::warn!("ERROR: could not find initial value from group {group_ndx}");
                any_error = true;
            }
        }

        !any_error
    }

    /// `ShaderAtomicAndCase::verify` / `ShaderAtomicOrCase::verify`
    fn verify_and_or(
        &self,
        num_work_groups: usize,
        work_group_size: usize,
        inputs: &[u32],
        outputs: &[u32],
        group_outputs: &[u32],
    ) -> bool {
        let is_and = self.op == AtomicOp::And;
        let initial_value = self.op.initial_value(self.ty, self.precision);
        let bits = num_bits(self.precision);
        let compare_mask = if self.ty == DataType::Uint || bits == 32 {
            !0u32
        } else {
            (1u32 << bits) - 1
        };

        for (group_ndx, group_output) in group_outputs.iter().take(num_work_groups).enumerate() {
            let group_offset = group_ndx * work_group_size;
            let group_output = *group_output;
            let mut expected_value = initial_value;

            for local_ndx in 0..work_group_size {
                let input_value = inputs[group_offset + local_ndx];
                if is_and {
                    expected_value &= input_value;
                } else {
                    expected_value |= input_value;
                }
            }

            if (group_output & compare_mask) != (expected_value & compare_mask) {
                log::warn!("ERROR: at group {group_ndx}: expected {expected_value:#x}, got {group_output:#x}");
                return false;
            }

            for local_ndx in 0..work_group_size {
                let output_value = outputs[group_offset + local_ndx];

                // `and` can only clear bits that started set; `or` can only set them.
                let bad = if is_and {
                    compare_mask & (output_value & !initial_value) != 0
                } else {
                    compare_mask & (output_value & initial_value) == 0
                };

                if bad {
                    log::warn!(
                        "ERROR: at group {group_ndx}, invocation {local_ndx}: found unexpected value {output_value:#x}"
                    );
                    return false;
                }
            }
        }

        true
    }
}

/// `ShaderAtomicXorCase::verify`
fn verify_xor(
    num_work_groups: usize,
    work_group_size: usize,
    inputs: &[u32],
    outputs: &[u32],
    group_outputs: &[u32],
    initial_value: u32,
    compare_mask: u32,
) -> bool {
    for (group_ndx, group_output) in group_outputs.iter().take(num_work_groups).enumerate() {
        let group_offset = group_ndx * work_group_size;
        let group_output = *group_output;
        let random_value = inputs[group_offset];
        let expected0 = random_value;
        let expected1 = random_value ^ !0u32;
        let mut num_xor_zeros = i32::from(initial_value == 0);

        for local_ndx in 1..work_group_size {
            if inputs[group_offset + local_ndx] == 0 {
                num_xor_zeros += 1;
            }
        }

        let expected = if num_xor_zeros % 2 == 0 { expected0 } else { expected1 };

        if (group_output & compare_mask) != (expected & compare_mask) {
            log::warn!(
                "ERROR: at group {group_ndx}: expected {expected0:#x} or {expected1:#x} (compare mask {compare_mask:#x}), got {group_output:#x}"
            );
            return false;
        }

        for local_ndx in 0..work_group_size {
            let output_value = outputs[group_offset + local_ndx] & compare_mask;

            if output_value != 0
                && output_value != compare_mask
                && output_value != (expected0 & compare_mask)
                && output_value != (expected1 & compare_mask)
            {
                log::warn!(
                    "ERROR: at group {group_ndx}, invocation {local_ndx}: found unexpected value {:#x}",
                    outputs[group_offset + local_ndx]
                );
                return false;
            }
        }
    }

    true
}

/// `ShaderAtomicExchangeCase::verify` - every invocation must read back a distinct value
/// out of `0..=workGroupSize`, and so must the final group value.
fn verify_exchange(num_work_groups: usize, work_group_size: usize, outputs: &[u32], group_outputs: &[u32]) -> bool {
    for (group_ndx, group_output) in group_outputs.iter().take(num_work_groups).enumerate() {
        let group_offset = group_ndx * work_group_size;
        let group_output = *group_output as i32;
        let mut used_values = BTreeSet::new();

        for local_ndx in 0..work_group_size {
            let output_value = outputs[group_offset + local_ndx] as i32;

            if !(0..=work_group_size as i32).contains(&output_value) || !used_values.insert(output_value) {
                log::warn!(
                    "ERROR: at group {group_ndx}, invocation {local_ndx}: found unexpected value {output_value}"
                );
                return false;
            }
        }

        if !(0..=work_group_size as i32).contains(&group_output) || used_values.contains(&group_output) {
            log::warn!("ERROR: at group {group_ndx}: unexpected final value {group_output}");
            return false;
        }
    }

    true
}

impl TestCase for ShaderAtomicOpCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ShaderAtomicOpCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let program = ShaderProgram::new(gl, &ProgramSources::compute(self.gen_compute_source()));
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        let num_values = (product(WORK_GROUP_SIZE) * product(NUM_WORK_GROUPS)) as usize;
        let num_groups = product(NUM_WORK_GROUPS) as usize;
        let layout = query_block_layout(
            context,
            program.program(),
            &["InOut.inputValues[0]", "InOut.outputValues[0]", "InOut.groupValues[0]"],
            &[num_values as u32, num_values as u32, num_groups as u32],
        )?;
        let (in_array, out_array, group_array) = (layout.arrays[0], layout.arrays[1], layout.arrays[2]);

        // Setup buffer.
        let mut buf_data = vec![0u8; layout.data_size];
        let mut inputs = Vec::new();
        self.get_inputs(num_values, &mut inputs);
        for (ndx, value) in inputs.iter().enumerate() {
            set_u32(&mut buf_data, in_array, ndx, *value);
        }

        if self.operand_type == AtomicOperandType::BufferVariable {
            let initial_value = self.op.initial_value(self.ty, self.precision);
            for ndx in 0..num_groups {
                set_u32(&mut buf_data, group_array, ndx, initial_value);
            }
        }

        let result = run_compute(context, program.program(), &buf_data)?;

        // Read back and compare.
        let read_inputs: Vec<u32> = (0..num_values).map(|ndx| get_u32(&result, in_array, ndx)).collect();
        let outputs: Vec<u32> = (0..num_values).map(|ndx| get_u32(&result, out_array, ndx)).collect();
        let group_outputs: Vec<u32> = (0..num_groups).map(|ndx| get_u32(&result, group_array, ndx)).collect();

        Ok(if self.verify(num_values, &read_inputs, &outputs, &group_outputs) {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Comparison failed")
        })
    }
}

/// `ShaderAtomicCompSwapCase`
struct ShaderAtomicCompSwapCase {
    name: String,
    operand_type: AtomicOperandType,
    ty: DataType,
    precision: Precision,
}

impl ShaderAtomicCompSwapCase {
    /// `ShaderAtomicCompSwapCase::init`'s shader source.
    fn gen_compute_source(&self) -> String {
        let is_ssbo = self.operand_type == AtomicOperandType::BufferVariable;
        let prec_name = self.precision.name();
        let type_name = self.ty.name();
        let num_values = product(WORK_GROUP_SIZE) * product(NUM_WORK_GROUPS);

        let mut src = format!(
            "#version 310 es\n\
             layout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;\n\
             layout(binding = 0) buffer InOut\n\
             {{\n    \
             {prec_name} {type_name} compareValues[{num_values}];\n    \
             {prec_name} {type_name} exchangeValues[{num_values}];\n    \
             {prec_name} {type_name} outputValues[{num_values}];\n    \
             {}{prec_name} {type_name} groupValues[{}];\n\
             }} sb_inout;\n",
            WORK_GROUP_SIZE[0],
            WORK_GROUP_SIZE[1],
            WORK_GROUP_SIZE[2],
            if is_ssbo { "coherent " } else { "" },
            product(NUM_WORK_GROUPS),
        );

        if !is_ssbo {
            src.push_str(&format!("shared {prec_name} {type_name} s_var;\n"));
        }

        src.push_str(
            "\nvoid main (void)\n\
             {\n    \
             uint localSize  = gl_WorkGroupSize.x*gl_WorkGroupSize.y*gl_WorkGroupSize.z;\n    \
             uint globalNdx  = gl_NumWorkGroups.x*gl_NumWorkGroups.y*gl_WorkGroupID.z + gl_NumWorkGroups.x*gl_WorkGroupID.y + gl_WorkGroupID.x;\n    \
             uint globalOffs = localSize*globalNdx;\n    \
             uint offset     = globalOffs + gl_LocalInvocationIndex;\n\n",
        );

        if !is_ssbo {
            src.push_str(&format!(
                "    if (gl_LocalInvocationIndex == 0u)\n        s_var = {type_name}(0);\n\n"
            ));
        }

        let target = if is_ssbo {
            "sb_inout.groupValues[globalNdx]"
        } else {
            "s_var"
        };
        src.push_str(&format!(
            "    {prec_name} {type_name} compare = sb_inout.compareValues[offset];\n    \
             {prec_name} {type_name} exchange = sb_inout.exchangeValues[offset];\n    \
             {prec_name} {type_name} result;\n    \
             bool swapDone = false;\n\n    \
             for (uint ndx = 0u; ndx < localSize; ndx++)\n    \
             {{\n        \
             barrier();\n        \
             if (!swapDone)\n        \
             {{\n            \
             result = atomicCompSwap({target}, compare, exchange);\n            \
             if (result == compare)\n                \
             swapDone = true;\n        \
             }}\n    \
             }}\n\n    \
             sb_inout.outputValues[offset] = result;\n"
        ));

        if !is_ssbo {
            src.push_str(
                "    barrier();\n    \
                 if (gl_LocalInvocationIndex == 0u)\n        \
                 sb_inout.groupValues[globalNdx] = s_var;\n",
            );
        }

        src.push_str("}\n");
        src
    }
}

impl TestCase for ShaderAtomicCompSwapCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `ShaderAtomicCompSwapCase::iterate`
    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let program = ShaderProgram::new(gl, &ProgramSources::compute(self.gen_compute_source()));
        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        let work_group_size = product(WORK_GROUP_SIZE) as usize;
        let num_values = work_group_size * product(NUM_WORK_GROUPS) as usize;
        let num_groups = product(NUM_WORK_GROUPS) as usize;
        let layout = query_block_layout(
            context,
            program.program(),
            &[
                "InOut.compareValues[0]",
                "InOut.exchangeValues[0]",
                "InOut.outputValues[0]",
                "InOut.groupValues[0]",
            ],
            &[
                num_values as u32,
                num_values as u32,
                num_values as u32,
                num_groups as u32,
            ],
        )?;
        let (cmp_array, exh_array, out_array, group_array) =
            (layout.arrays[0], layout.arrays[1], layout.arrays[2], layout.arrays[3]);

        // Setup buffer. \todo [2013-09-05 pyry] Use randomized input values!
        let mut buf_data = vec![0u8; layout.data_size];
        for ndx in 0..num_values {
            set_u32(&mut buf_data, cmp_array, ndx, (ndx % work_group_size) as u32);
            set_u32(&mut buf_data, exh_array, ndx, (ndx % work_group_size) as u32 + 1);
        }

        let result = run_compute(context, program.program(), &buf_data)?;

        // Read back and compare.
        let mut is_ok = true;
        'groups: for group_ndx in 0..num_groups {
            let group_offset = group_ndx * work_group_size;
            let group_output = get_u32(&result, group_array, group_ndx) as i32;

            for local_ndx in 0..work_group_size {
                let ref_value = local_ndx as i32;
                let output_value = get_u32(&result, out_array, group_offset + local_ndx) as i32;

                if output_value != ref_value {
                    log::warn!(
                        "ERROR: at group {group_ndx}, invocation {local_ndx}: expected {ref_value}, got {output_value}"
                    );
                    is_ok = false;
                    break 'groups;
                }
            }

            if group_output != work_group_size as i32 {
                log::warn!("ERROR: at group {group_ndx}: expected {work_group_size}, got {group_output}");
                is_ok = false;
                break;
            }
        }

        Ok(if is_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Comparison failed")
        })
    }
}

/// `createAtomicOpGroup`
fn create_atomic_op_group(operand_type: AtomicOperandType, group_name: &str, op: Option<AtomicOp>) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(group_name);

    for precision in [Precision::LowP, Precision::MediumP, Precision::HighP] {
        for type_ndx in 0..2 {
            let ty = if type_ndx > 0 { DataType::Int } else { DataType::Uint };
            let case_name = format!("{}_{}", precision.name(), ty.name());

            let case: Box<dyn TestCase> = match op {
                Some(op) => Box::new(ShaderAtomicOpCase {
                    name: case_name,
                    op,
                    operand_type,
                    ty,
                    precision,
                }),
                None => Box::new(ShaderAtomicCompSwapCase {
                    name: case_name,
                    operand_type,
                    ty,
                    precision,
                }),
            };
            group.add_child(case);
        }
    }

    group
}

/// `ShaderAtomicOpTests::init`
pub fn create_tests(name: &str, operand_type: AtomicOperandType) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    group.add_child(create_atomic_op_group(operand_type, "add", Some(AtomicOp::Add)));
    group.add_child(create_atomic_op_group(operand_type, "min", Some(AtomicOp::Min)));
    group.add_child(create_atomic_op_group(operand_type, "max", Some(AtomicOp::Max)));
    group.add_child(create_atomic_op_group(operand_type, "and", Some(AtomicOp::And)));
    group.add_child(create_atomic_op_group(operand_type, "or", Some(AtomicOp::Or)));
    group.add_child(create_atomic_op_group(operand_type, "xor", Some(AtomicOp::Xor)));
    group.add_child(create_atomic_op_group(
        operand_type,
        "exchange",
        Some(AtomicOp::Exchange),
    ));
    group.add_child(create_atomic_op_group(operand_type, "compswap", None));
    group
}
