// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktAtomicOperationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders of `AtomicOperationCase::createShaderSpec` are written by
// `scripts/gen_shader_executor_programs.py` (`atomic_operation_specs`) for every executor, the task and mesh ones (buffer, shared, reference and task
// payload) included. `TestBuffer` and
// `TestBufferFloatingPoint` (and their `BufferData` structs) are one `TestBuffer` over a byte layout: the elements are carried as the bit pattern in
// a `u64` and the operations are done on the bits, so one code path serves 16, 32 and 64 bit data.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use super::{ScalarKind, ShaderSpec, ShaderType, Symbol, check_support_shader, execute, executor_programs};
use crate::tcu::pixel::{f16_bits_to_f32, f32_to_f16_bits};
use crate::tcu::random::Random;
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const NUM_ELEMENTS: usize = 32;

/// `AtomicMemoryType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum AtomicMemoryType {
    Buffer,
    Shared,
    Reference,
    Payload,
}

/// `AtomicShaderType`
#[derive(Clone, Copy, Debug)]
struct AtomicShaderType {
    shader_type: ShaderType,
    memory_type: AtomicMemoryType,
}

impl AtomicShaderType {
    fn new(shader_type: ShaderType, memory_type: AtomicMemoryType) -> Self {
        debug_assert!(
            memory_type != AtomicMemoryType::Shared
                || matches!(shader_type, ShaderType::Compute | ShaderType::Task | ShaderType::Mesh)
        );
        debug_assert!(memory_type != AtomicMemoryType::Payload || shader_type == ShaderType::Task);
        Self {
            shader_type,
            memory_type,
        }
    }

    fn is_shared_like(&self) -> bool {
        matches!(self.memory_type, AtomicMemoryType::Shared | AtomicMemoryType::Payload)
    }
}

/// `AtomicOperation`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum AtomicOperation {
    Exchange,
    CompSwap,
    Add,
    Min,
    Max,
    And,
    Or,
    Xor,
}

/// `DataType`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum DataType {
    Float16,
    Float16x2,
    Float16x4,
    Int32,
    Uint32,
    Float32,
    Int64,
    Uint64,
    Float64,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum FloatKind {
    F16,
    F32,
    F64,
}

impl FloatKind {
    fn frac_bits(self) -> u32 {
        match self {
            Self::F16 => 10,
            Self::F32 => 23,
            Self::F64 => 52,
        }
    }

    fn exp_bits(self) -> u32 {
        match self {
            Self::F16 => 5,
            Self::F32 => 8,
            Self::F64 => 11,
        }
    }

    fn exp_mask(self) -> u64 {
        ((1u64 << self.exp_bits()) - 1) << self.frac_bits()
    }

    fn sign_bit(self) -> u64 {
        1u64 << (self.frac_bits() + self.exp_bits())
    }

    fn to_f64(self, bits: u64) -> f64 {
        match self {
            Self::F16 => f64::from(f16_bits_to_f32(bits as u16)),
            Self::F32 => f64::from(f32::from_bits(bits as u32)),
            Self::F64 => f64::from_bits(bits),
        }
    }

    /// `deToFloatType<T>(double)`
    #[expect(
        clippy::wrong_self_convention,
        reason = "upstream's name for the conversion of a value to the type's bits"
    )]
    fn from_f64(self, value: f64) -> u64 {
        match self {
            Self::F16 => u64::from(f32_to_f16_bits(value as f32)),
            Self::F32 => u64::from((value as f32).to_bits()),
            Self::F64 => value.to_bits(),
        }
    }

    /// `deIsIEEENaN`
    fn is_nan(self, bits: u64) -> bool {
        bits & self.exp_mask() == self.exp_mask() && bits & ((1u64 << self.frac_bits()) - 1) != 0
    }

    /// `deIsSignalingNaN`
    fn is_signaling_nan(self, bits: u64) -> bool {
        self.is_nan(bits) && bits & (1u64 << (self.frac_bits() - 1)) == 0
    }

    /// `deQuietNaN<T>`
    fn quiet_nan(self) -> u64 {
        self.exp_mask() | (1u64 << (self.frac_bits() - 1))
    }

    /// `deSignalingNaN<T>`
    fn signaling_nan(self) -> u64 {
        self.exp_mask() | (1u64 << (self.frac_bits() - 2))
    }

    fn is_positive_zero(self, bits: u64) -> bool {
        bits == 0
    }

    fn is_negative_zero(self, bits: u64) -> bool {
        bits == self.sign_bit()
    }

    /// `sloppyFPCompare`
    fn sloppy_compare(self, x: u64, y: u64) -> bool {
        let tolerance = if self == Self::F16 { 0.01 } else { 0.00001 };
        (self.to_f64(x) - self.to_f64(y)).abs() < tolerance
    }

    /// `nanSafeSloppyEquals`
    fn nan_safe_sloppy_equals(self, x: u64, y: u64) -> bool {
        match (self.is_nan(x), self.is_nan(y)) {
            (true, true) => true,
            (false, false) => self.sloppy_compare(x, y),
            _ => false,
        }
    }

    /// `floatAdd`
    fn float_add(self, x: u64, y: u64) -> u64 {
        if self.is_nan(x) || self.is_nan(y) {
            return self.quiet_nan();
        }
        self.from_f64(self.to_f64(x) + self.to_f64(y))
    }

    /// `handleExceptionalFloatMinMaxValues`
    fn handle_exceptional_min_max_values(self, values: &mut Vec<u64>, x: u64, y: u64) {
        if self.is_signaling_nan(x) && self.is_signaling_nan(y) {
            values.push(self.quiet_nan());
            values.push(self.signaling_nan());
        } else if self.is_signaling_nan(x) {
            values.push(self.quiet_nan());
            values.push(self.signaling_nan());
            if !self.is_nan(y) {
                values.push(y);
            }
        } else if self.is_signaling_nan(y) {
            values.push(self.quiet_nan());
            values.push(self.signaling_nan());
            if !self.is_nan(x) {
                values.push(x);
            }
        } else if self.is_nan(x) && self.is_nan(y) {
            values.push(self.quiet_nan());
        } else if self.is_nan(x) {
            values.push(y);
        } else if self.is_nan(y) {
            values.push(x);
        } else if (self.is_positive_zero(x) && self.is_negative_zero(y))
            || (self.is_negative_zero(x) && self.is_positive_zero(y))
        {
            values.push(self.from_f64(0.0));
            values.push(self.from_f64(-0.0));
        }
    }

    /// `floatMinValues`
    fn float_min_values(self, x: u64, y: u64) -> Vec<u64> {
        let mut values = Vec::new();
        self.handle_exceptional_min_max_values(&mut values, x, y);
        if values.is_empty() {
            values.push(if self.to_f64(x) < self.to_f64(y) { x } else { y });
        }
        values
    }

    /// `floatMaxValues`
    fn float_max_values(self, x: u64, y: u64) -> Vec<u64> {
        let mut values = Vec::new();
        self.handle_exceptional_min_max_values(&mut values, x, y);
        if values.is_empty() {
            values.push(if self.to_f64(x) > self.to_f64(y) { x } else { y });
        }
        values
    }
}

impl DataType {
    #[expect(dead_code, reason = "ported with upstream's helpers, no caller yet")]
    fn glsl_name(self) -> &'static str {
        match self {
            Self::Float16 => "float16_t",
            Self::Float16x2 => "f16vec2",
            Self::Float16x4 => "f16vec4",
            Self::Int32 => "int",
            Self::Uint32 => "uint",
            Self::Float32 => "float",
            Self::Int64 => "int64_t",
            Self::Uint64 => "uint64_t",
            Self::Float64 => "double",
        }
    }

    fn float_kind(self) -> Option<FloatKind> {
        match self {
            Self::Float16 | Self::Float16x2 | Self::Float16x4 => Some(FloatKind::F16),
            Self::Float32 => Some(FloatKind::F32),
            Self::Float64 => Some(FloatKind::F64),
            _ => None,
        }
    }

    /// The number of components of one element
    fn vec_size(self) -> usize {
        match self {
            Self::Float16x2 => 2,
            Self::Float16x4 => 4,
            _ => 1,
        }
    }

    /// The size of one component in bytes
    fn component_size(self) -> usize {
        match self {
            Self::Float16 | Self::Float16x2 | Self::Float16x4 => 2,
            Self::Int32 | Self::Uint32 | Self::Float32 => 4,
            Self::Int64 | Self::Uint64 | Self::Float64 => 8,
        }
    }

    fn is_signed_int(self) -> bool {
        matches!(self, Self::Int32 | Self::Int64)
    }
}

/// The offsets of `BufferData` / `BufferDataFloatingPoint`, in bytes. `invocationHitCount` has the type of the data in the integer variant (and
/// `int` in the floating point one), which only makes the C++ struct larger than the shader's: the shader's `index` lies inside the zeroed part.
struct BufferLayout {
    element_size: usize,
    inout: usize,
    input: usize,
    compare: usize,
    output: usize,
    hit_count: usize,
    #[expect(dead_code, reason = "mirrors upstream's member, which this port never reads")]
    index: usize,
    size: usize,
}

impl BufferLayout {
    fn new(data_type: DataType) -> Self {
        let component = data_type.component_size();
        let element_size = component * data_type.vec_size();
        let inout = 0;
        let input = inout + NUM_ELEMENTS / 2 * element_size;
        let compare = input + NUM_ELEMENTS * element_size;
        let output = compare + NUM_ELEMENTS * element_size;
        let hit_count = output + NUM_ELEMENTS * element_size;
        let hit_count_element = if data_type.float_kind().is_some() { 4 } else { component };
        let index = hit_count + NUM_ELEMENTS * hit_count_element;
        let size = (index + 4).next_multiple_of(element_size.max(4)).next_multiple_of(16);
        Self {
            element_size: component,
            inout,
            input,
            compare,
            output,
            hit_count,
            index,
            size,
        }
    }
}

fn read_element(bytes: &[u8], offset: usize, size: usize) -> u64 {
    let mut value = [0u8; 8];
    value[..size].copy_from_slice(&bytes[offset..offset + size]);
    u64::from_le_bytes(value)
}

fn write_element(bytes: &mut [u8], offset: usize, size: usize, value: u64) {
    bytes[offset..offset + size].copy_from_slice(&value.to_le_bytes()[..size]);
}

/// The results of one atomic operation on one `inout` element, in the two possible orders: (inout, output0, output1).
type Expected = (u64, u64, u64);

/// `TestBuffer` and `TestBufferFloatingPoint`
struct TestBuffer {
    data_type: DataType,
    atomic_op: AtomicOperation,
    layout: BufferLayout,
    original: Vec<u8>,
}

impl TestBuffer {
    fn new(data_type: DataType, atomic_op: AtomicOperation) -> Self {
        let layout = BufferLayout::new(data_type);
        Self {
            data_type,
            atomic_op,
            original: vec![0; layout.size],
            layout,
        }
    }

    /// `bufferSize`
    fn buffer_size(&self) -> usize {
        self.layout.size
    }

    fn mask(&self) -> u64 {
        if self.layout.element_size == 8 {
            u64::MAX
        } else {
            (1u64 << (self.layout.element_size * 8)) - 1
        }
    }

    /// `fillWithTestData`
    fn fill_with_test_data(&mut self, rnd: &mut Random) {
        let size = self.layout.element_size;
        let vec = self.data_type.vec_size();
        let mask = self.mask();
        let pattern = 0xcdcd_cdcd_cdcd_cdcdu64 & mask;
        let layout = &self.layout;
        let data = &mut self.original;

        if let Some(kind) = self.data_type.float_kind() {
            for i in 0..NUM_ELEMENTS / 2 * vec {
                write_element(
                    data,
                    layout.inout + i * size,
                    size,
                    kind.from_f64(f64::from(rnd.get_float())),
                );
            }
            for i in 0..NUM_ELEMENTS * vec {
                write_element(
                    data,
                    layout.input + i * size,
                    size,
                    kind.from_f64(f64::from(rnd.get_float())),
                );
                write_element(data, layout.output + i * size, size, pattern);
                write_element(data, layout.compare + i * size, size, kind.from_f64(0.0));
            }

            // Special cases for NaN and +/-0 (the indices are those of upstream, whatever the vector size)
            let set = |data: &mut Vec<u8>, base: usize, index: usize, value: u64| {
                write_element(data, base + index * size, size, value)
            };
            // 0: min(sNaN, x)
            set(data, layout.inout, 0, kind.signaling_nan());
            // 1: min(x, sNaN)
            set(data, layout.input, 2, kind.signaling_nan());
            // 2: min(qNaN, x)
            set(data, layout.inout, 2, kind.quiet_nan());
            // 3: min(x, qNaN)
            set(data, layout.input, 6, kind.quiet_nan());
            // 4: min(NaN, NaN)
            set(data, layout.inout, 4, kind.signaling_nan());
            set(data, layout.input, 8, kind.quiet_nan());
            set(data, layout.input, 9, kind.quiet_nan());
            // 5: min(+0, -0)
            set(data, layout.inout, 5, kind.from_f64(-0.0));
            set(data, layout.input, 10, kind.from_f64(0.0));
            set(data, layout.input, 11, kind.from_f64(0.0));
        } else {
            for i in 0..NUM_ELEMENTS / 2 {
                let inout = rnd.get_uint64() & mask;
                write_element(data, layout.inout + i * size, size, inout);
                // The first half of compare elements match with every even index. The second half matches with odd indices. This causes the
                // overlapping operations to only select one.
                let odd = (i % 2) as u64;
                write_element(data, layout.compare + i * size, size, inout.wrapping_add(odd) & mask);
                write_element(
                    data,
                    layout.compare + (i + NUM_ELEMENTS / 2) * size,
                    size,
                    inout.wrapping_add(1).wrapping_sub(odd) & mask,
                );
            }
            for i in 0..NUM_ELEMENTS {
                write_element(data, layout.input + i * size, size, rnd.get_uint64() & mask);
                write_element(data, layout.output + i * size, size, pattern);
                write_element(data, layout.hit_count + i * size, size, 0);
            }
        }
    }

    fn signed_value(&self, value: u64) -> i64 {
        let shift = 64 - self.layout.element_size * 8;
        ((value << shift) as i64) >> shift
    }

    /// `checkOperation` for the integer data types
    fn expected_int(&self, element_ndx: usize, original_inout: u64, input0: u64, input1: u64) -> [Expected; 2] {
        let mask = self.mask();
        let signed = self.data_type.is_signed_int();
        let min = |a: u64, b: u64| -> u64 {
            let less = if signed {
                self.signed_value(a) < self.signed_value(b)
            } else {
                a < b
            };
            if less { a } else { b }
        };
        let max = |a: u64, b: u64| -> u64 {
            let greater = if signed {
                self.signed_value(a) > self.signed_value(b)
            } else {
                a > b
            };
            if greater { a } else { b }
        };
        let add = |a: u64, b: u64| a.wrapping_add(b) & mask;
        let (o, i0, i1) = (original_inout, input0, input1);

        match self.atomic_op {
            AtomicOperation::Add => [
                (add(add(o, i0), i1), o, add(o, i0)),
                (add(add(o, i0), i1), add(o, i1), o),
            ],
            AtomicOperation::And => [(o & i0 & i1, o, o & i0), (o & i0 & i1, o & i1, o)],
            AtomicOperation::Or => [(o | i0 | i1, o, o | i0), (o | i0 | i1, o | i1, o)],
            AtomicOperation::Xor => [(o ^ i0 ^ i1, o, o ^ i0), (o ^ i0 ^ i1, o ^ i1, o)],
            AtomicOperation::Min => [
                (min(min(o, i0), i1), o, min(o, i0)),
                (min(min(o, i0), i1), min(o, i1), o),
            ],
            AtomicOperation::Max => [
                (max(max(o, i0), i1), o, max(o, i0)),
                (max(max(o, i0), i1), max(o, i1), o),
            ],
            AtomicOperation::Exchange => [(i1, o, i0), (i0, i1, o)],
            AtomicOperation::CompSwap => {
                if element_ndx % 2 == 0 {
                    [(i0, o, i0), (i0, o, o)]
                } else {
                    [(i1, i1, o), (i1, o, o)]
                }
            }
        }
    }

    /// `checkOperationFloatingPoint`: every outcome that is acceptable
    fn expected_float(&self, kind: FloatKind, original_inout: u64, input0: u64, input1: u64) -> Vec<Expected> {
        let (o, i0, i1) = (original_inout, input0, input1);
        let mut exp = Vec::new();
        match self.atomic_op {
            AtomicOperation::Add => {
                exp.push((kind.float_add(kind.float_add(o, i0), i1), o, kind.float_add(o, i0)));
                exp.push((kind.float_add(kind.float_add(o, i1), i0), kind.float_add(o, i1), o));
            }
            AtomicOperation::Min | AtomicOperation::Max => {
                let combine = |x: u64, y: u64| {
                    if self.atomic_op == AtomicOperation::Min {
                        kind.float_min_values(x, y)
                    } else {
                        kind.float_max_values(x, y)
                    }
                };
                // The case where input0 is combined first
                for x in combine(o, i0) {
                    for y in combine(x, i1) {
                        exp.push((y, o, x));
                    }
                }
                // The case where input1 is combined first
                for x in combine(o, i1) {
                    for y in combine(x, i0) {
                        exp.push((y, x, o));
                    }
                }
            }
            AtomicOperation::Exchange => {
                exp.push((i1, o, i0));
                exp.push((i0, i1, o));
            }
            _ => unreachable!("Unexpected atomic operation."),
        }
        exp
    }

    /// `checkResults`
    fn check_results(&self, result: &[u8], result_collector: &mut ResultCollector) {
        let layout = &self.layout;
        let size = layout.element_size;
        let vec = self.data_type.vec_size();
        let hex = |value: u64| format!("{value:#0width$x}", width = size * 2 + 2);

        // Two operations are executed for each inout value (using the inputs i and i + NUM_ELEMENTS / 2) and each of them returns the memory
        // contents before it, so the result has two candidates depending on the execution order.
        for element_ndx in 0..NUM_ELEMENTS / 2 {
            for vec_idx in 0..vec {
                let at = |base: usize, index: usize| base + (index * vec + vec_idx) * size;
                let original_inout = read_element(&self.original, at(layout.inout, element_ndx), size);
                let input0 = read_element(&self.original, at(layout.input, element_ndx), size);
                let input1 = read_element(&self.original, at(layout.input, element_ndx + NUM_ELEMENTS / 2), size);

                let res_io = read_element(result, at(layout.inout, element_ndx), size);
                let res_output0 = read_element(result, at(layout.output, element_ndx), size);
                let res_output1 = read_element(result, at(layout.output, element_ndx + NUM_ELEMENTS / 2), size);

                let (exp, has_match) = if let Some(kind) = self.data_type.float_kind() {
                    let exp = self.expected_float(kind, original_inout, input0, input1);
                    let has_match = exp.iter().any(|&(io, out0, out1)| {
                        kind.nan_safe_sloppy_equals(io, res_io)
                            && kind.nan_safe_sloppy_equals(out0, res_output0)
                            && kind.nan_safe_sloppy_equals(out1, res_output1)
                    });
                    (exp, has_match)
                } else {
                    let exp = self.expected_int(element_ndx, original_inout, input0, input1).to_vec();
                    let has_match = exp.contains(&(res_io, res_output0, res_output1));
                    (exp, has_match)
                };

                if !has_match {
                    let outcomes: Vec<String> = exp
                        .iter()
                        .map(|&(io, out0, out1)| {
                            format!("InOut = {}, Output0 = {}, Output1 = {}", hex(io), hex(out0), hex(out1))
                        })
                        .collect();
                    result_collector.fail(format!(
                        "ERROR: Result value check failed at index ({element_ndx}, {vec_idx}). Expected one of the outcomes: {}. Got: InOut = {}, Output0 = {}, Output1 = {}. Using Input0 = {} and Input1 = {}.",
                        outcomes.join(", or "),
                        hex(res_io),
                        hex(res_output0),
                        hex(res_output1),
                        hex(input0),
                        hex(input1)
                    ));
                }
            }
        }
    }
}

const OUTPUT_SYMBOLS: [Symbol; 1] = [Symbol::new("outData", ScalarKind::Uint, 1)];
static ATOMIC_SPEC: ShaderSpec = ShaderSpec {
    inputs: &[],
    outputs: &OUTPUT_SYMBOLS,
};

/// `Buffer`
struct Buffer<'a> {
    buffer: BufferWithMemory<'a>,
}

impl<'a> Buffer<'a> {
    fn new(
        context: &'a Context<'_>,
        usage: vk::BufferUsageFlags,
        size: usize,
        use_ref: bool,
    ) -> Result<Self, TestError> {
        let requirement = MemoryRequirement::HOST_VISIBLE
            | if use_ref {
                MemoryRequirement::DEVICE_ADDRESS
            } else {
                MemoryRequirement::ANY
            };
        let buffer = BufferWithMemory::new(
            context.get_device(),
            context.get_default_allocator(),
            make_buffer_create_info(size as vk::DeviceSize, usage),
            requirement,
        )?;
        Ok(Self { buffer })
    }

    fn get_buffer(&self) -> vk::Buffer {
        self.buffer.get()
    }

    fn host_ptr(&self) -> *mut u8 {
        self.buffer.get_allocation().get_host_ptr().cast()
    }

    fn flush(&self, context: &Context<'_>) -> Result<(), TestError> {
        flush_alloc(context.get_device(), self.buffer.get_allocation())
    }

    fn invalidate(&self, context: &Context<'_>) -> Result<(), TestError> {
        let device = context.get_device();
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::MEMORY_WRITE,
            vk::AccessFlags::HOST_READ,
            self.buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, self.buffer.get_allocation())
    }
}

struct AtomicOperationCaseInstance<'a> {
    context: &'a Context<'a>,
    case: &'a AtomicOperationCase,
}

impl TestInstance for AtomicOperationCaseInstance<'_> {
    /// `AtomicOperationCaseInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let case = self.case;
        let context = self.context;
        let device = context.get_device();
        let mut test_buffer = TestBuffer::new(case.data_type, case.atomic_op);
        let mut rnd = Random::new(0x62a15e34);
        let use_ref = case.shader_type.memory_type == AtomicMemoryType::Reference;
        let desc_type = if use_ref {
            vk::DescriptorType::UNIFORM_BUFFER
        } else {
            vk::DescriptorType::STORAGE_BUFFER
        };
        let usage_flags = vk::BufferUsageFlags::STORAGE_BUFFER
            | if use_ref {
                vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
            } else {
                vk::BufferUsageFlags::empty()
            };

        // The main buffer will hold test data. When using buffer references, the buffer's address will be indirectly passed as part of a uniform
        // buffer. If not, it will be passed directly as a descriptor.
        let buffer = Buffer::new(context, usage_flags, test_buffer.buffer_size(), use_ref)?;
        let aux_buffer = if use_ref {
            let address_info = vk::BufferDeviceAddressInfo::builder().buffer(buffer.get_buffer());
            let address = unsafe { device.get_buffer_device_address(&address_info) };

            let aux_buffer = Buffer::new(
                context,
                vk::BufferUsageFlags::UNIFORM_BUFFER,
                std::mem::size_of::<u64>(),
                false,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    address.to_ne_bytes().as_ptr(),
                    aux_buffer.host_ptr(),
                    std::mem::size_of::<u64>(),
                )
            };
            aux_buffer.flush(context)?;
            Some(aux_buffer)
        } else {
            None
        };

        test_buffer.fill_with_test_data(&mut rnd);
        unsafe {
            std::ptr::copy_nonoverlapping(
                test_buffer.original.as_ptr(),
                buffer.host_ptr(),
                test_buffer.original.len(),
            )
        };
        buffer.flush(context)?;

        let extra_resources_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, vk::ShaderStageFlags::ALL)
            .build(device)?;
        let extra_resources_set_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let extra_resources_set = make_descriptor_set(device, *extra_resources_set_pool, *extra_resources_layout)?;

        let buffer_info = vk::DescriptorBufferInfo {
            buffer: aux_buffer
                .as_ref()
                .map_or_else(|| buffer.get_buffer(), Buffer::get_buffer),
            offset: 0,
            range: vk::WHOLE_SIZE,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(extra_resources_set.get(), Location::binding(0), desc_type, &buffer_info)
            .update(device);

        let num_work_groups = if case.shader_type.is_shared_like() {
            1
        } else {
            NUM_ELEMENTS
        };
        let mut output = [0xcdu8; NUM_ELEMENTS * 4];
        {
            let mut outputs: [&mut [u8]; 1] = [&mut output[..num_work_groups * 4]];
            execute(
                context,
                case.shader_type.shader_type,
                &ATOMIC_SPEC,
                Some(*extra_resources_layout),
                num_work_groups,
                &[],
                &mut outputs,
                Some(extra_resources_set.get()),
            )?;
        }
        buffer.invalidate(context)?;

        let mut result_collector = ResultCollector::new("");
        let result = unsafe { std::slice::from_raw_parts(buffer.host_ptr().cast_const(), test_buffer.buffer_size()) };
        test_buffer.check_results(result, &mut result_collector);

        Ok(result_collector.to_status())
    }
}

struct AtomicOperationCase {
    name: String,
    shader_type: AtomicShaderType,
    data_type: DataType,
    atomic_op: AtomicOperation,
    key: String,
}

impl AtomicOperationCase {
    fn new(
        name: String,
        shader_type: AtomicShaderType,
        data_type: DataType,
        atomic_op: AtomicOperation,
        key: String,
    ) -> Self {
        Self {
            name,
            shader_type,
            data_type,
            atomic_op,
            key,
        }
    }
}

fn require(feature: bool, message: &str) -> Result<(), TestError> {
    if feature {
        Ok(())
    } else {
        Err(TestError::NotSupported(message.to_string()))
    }
}

impl TestCase for AtomicOperationCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `AtomicOperationCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let shared_like = self.shader_type.is_shared_like();
        let op = self.atomic_op;
        let data_type = self.data_type;

        if matches!(data_type, DataType::Int64 | DataType::Uint64) {
            context.require_device_functionality("VK_KHR_shader_atomic_int64")?;

            let mut atomic_int64_features = vk::PhysicalDeviceShaderAtomicInt64Features::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut atomic_int64_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if !shared_like {
                require(
                    atomic_int64_features.shader_buffer_int64_atomics != vk::FALSE,
                    "VkShaderAtomicInt64: 64-bit integer atomic operations not supported for buffers",
                )?;
            } else {
                require(
                    atomic_int64_features.shader_shared_int64_atomics != vk::FALSE,
                    "VkShaderAtomicInt64: 64-bit integer atomic operations not supported for shared memory",
                )?;
            }
        }

        let mut float_features = vk::PhysicalDeviceShaderAtomicFloatFeaturesEXT::default();
        let mut float2_features = vk::PhysicalDeviceShaderAtomicFloat2FeaturesEXT::default();
        let mut float16_vector_features = vk::PhysicalDeviceShaderAtomicFloat16VectorFeaturesNV::default();
        if data_type.float_kind().is_some() {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut float_features)
                .push_next(&mut float2_features)
                .push_next(&mut float16_vector_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
        }
        let is_set = |value: vk::Bool32| value != vk::FALSE;

        if data_type == DataType::Float16 {
            context.require_device_functionality("VK_EXT_shader_atomic_float2")?;
            if op == AtomicOperation::Add {
                if shared_like {
                    require(
                        is_set(float2_features.shader_shared_float16_atomic_add),
                        "VkShaderAtomicFloat16: 16-bit floating point shared add atomic operation not supported",
                    )?;
                } else {
                    require(
                        is_set(float2_features.shader_buffer_float16_atomic_add),
                        "VkShaderAtomicFloat16: 16-bit floating point buffer add atomic operation not supported",
                    )?;
                }
            }
            if matches!(op, AtomicOperation::Min | AtomicOperation::Max) {
                if shared_like {
                    require(
                        is_set(float2_features.shader_shared_float16_atomic_min_max),
                        "VkShaderAtomicFloat16: 16-bit floating point shared min/max atomic operation not supported",
                    )?;
                } else {
                    require(
                        is_set(float2_features.shader_buffer_float16_atomic_min_max),
                        "VkShaderAtomicFloat16: 16-bit floating point buffer min/max atomic operation not supported",
                    )?;
                }
            }
            if op == AtomicOperation::Exchange {
                if shared_like {
                    require(
                        is_set(float2_features.shader_shared_float16_atomics),
                        "VkShaderAtomicFloat16: 16-bit floating point shared atomic operations not supported",
                    )?;
                } else {
                    require(
                        is_set(float2_features.shader_buffer_float16_atomics),
                        "VkShaderAtomicFloat16: 16-bit floating point buffer atomic operations not supported",
                    )?;
                }
            }
        }

        if matches!(data_type, DataType::Float16x2 | DataType::Float16x4) {
            context.require_device_functionality("VK_NV_shader_atomic_float16_vector")?;
            require(
                is_set(float16_vector_features.shader_float16_vector_atomics),
                "16-bit floating point vector atomic operations not supported",
            )?;
        }

        if data_type == DataType::Float32 {
            context.require_device_functionality("VK_EXT_shader_atomic_float")?;
            if op == AtomicOperation::Add {
                if shared_like {
                    require(
                        is_set(float_features.shader_shared_float32_atomic_add),
                        "VkShaderAtomicFloat32: 32-bit floating point shared add atomic operation not supported",
                    )?;
                } else {
                    require(
                        is_set(float_features.shader_buffer_float32_atomic_add),
                        "VkShaderAtomicFloat32: 32-bit floating point buffer add atomic operation not supported",
                    )?;
                }
            }
            if matches!(op, AtomicOperation::Min | AtomicOperation::Max) {
                context.require_device_functionality("VK_EXT_shader_atomic_float2")?;
                if shared_like {
                    require(
                        is_set(float2_features.shader_shared_float32_atomic_min_max),
                        "VkShaderAtomicFloat32: 32-bit floating point shared min/max atomic operation not supported",
                    )?;
                } else {
                    require(
                        is_set(float2_features.shader_buffer_float32_atomic_min_max),
                        "VkShaderAtomicFloat32: 32-bit floating point buffer min/max atomic operation not supported",
                    )?;
                }
            }
            if op == AtomicOperation::Exchange {
                if shared_like {
                    require(
                        is_set(float_features.shader_shared_float32_atomics),
                        "VkShaderAtomicFloat32: 32-bit floating point shared atomic operations not supported",
                    )?;
                } else {
                    require(
                        is_set(float_features.shader_buffer_float32_atomics),
                        "VkShaderAtomicFloat32: 32-bit floating point buffer atomic operations not supported",
                    )?;
                }
            }
        }

        if data_type == DataType::Float64 {
            context.require_device_functionality("VK_EXT_shader_atomic_float")?;
            if op == AtomicOperation::Add {
                if shared_like {
                    require(
                        is_set(float_features.shader_shared_float64_atomic_add),
                        "VkShaderAtomicFloat64: 64-bit floating point shared add atomic operation not supported",
                    )?;
                } else {
                    require(
                        is_set(float_features.shader_buffer_float64_atomic_add),
                        "VkShaderAtomicFloat64: 64-bit floating point buffer add atomic operation not supported",
                    )?;
                }
            }
            if matches!(op, AtomicOperation::Min | AtomicOperation::Max) {
                context.require_device_functionality("VK_EXT_shader_atomic_float2")?;
                if shared_like {
                    require(
                        is_set(float2_features.shader_shared_float64_atomic_min_max),
                        "VkShaderAtomicFloat64: 64-bit floating point shared min/max atomic operation not supported",
                    )?;
                } else {
                    require(
                        is_set(float2_features.shader_buffer_float64_atomic_min_max),
                        "VkShaderAtomicFloat64: 64-bit floating point buffer min/max atomic operation not supported",
                    )?;
                }
            }
            if op == AtomicOperation::Exchange {
                if shared_like {
                    require(
                        is_set(float_features.shader_shared_float64_atomics),
                        "VkShaderAtomicFloat64: 64-bit floating point shared atomic operations not supported",
                    )?;
                } else {
                    require(
                        is_set(float_features.shader_buffer_float64_atomics),
                        "VkShaderAtomicFloat64: 64-bit floating point buffer atomic operations not supported",
                    )?;
                }
            }
        }

        if self.shader_type.memory_type == AtomicMemoryType::Reference {
            context.require_device_functionality("VK_KHR_buffer_device_address")?;
        }

        check_support_shader(context, self.shader_type.shader_type)
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(&self.key, self.shader_type.shader_type)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AtomicOperationCaseInstance { context, case: self })
    }
}

/// `addAtomicOperationTests`
pub fn create_atomic_operation_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("atomic_operations");

    let shader_types = [
        (ShaderType::Vertex, "vertex"),
        (ShaderType::Fragment, "fragment"),
        (ShaderType::Geometry, "geometry"),
        (ShaderType::TessellationControl, "tess_ctrl"),
        (ShaderType::TessellationEvaluation, "tess_eval"),
        (ShaderType::Compute, "compute"),
        (ShaderType::Task, "task"),
        (ShaderType::Mesh, "mesh"),
    ];
    let memory_types = [
        (AtomicMemoryType::Buffer, ""),
        (AtomicMemoryType::Shared, "_shared"),
        (AtomicMemoryType::Reference, "_reference"),
        (AtomicMemoryType::Payload, "_payload"),
    ];
    let data_signs = [
        (DataType::Float16, "float16"),
        (DataType::Float16x2, "f16vec2"),
        (DataType::Float16x4, "f16vec4"),
        (DataType::Int32, "signed"),
        (DataType::Uint32, "unsigned"),
        (DataType::Float32, "float32"),
        (DataType::Int64, "signed64bit"),
        (DataType::Uint64, "unsigned64bit"),
        (DataType::Float64, "float64"),
    ];
    let atomic_ops = [
        (AtomicOperation::Exchange, "exchange"),
        (AtomicOperation::CompSwap, "comp_swap"),
        (AtomicOperation::Add, "add"),
        (AtomicOperation::Min, "min"),
        (AtomicOperation::Max, "max"),
        (AtomicOperation::And, "and"),
        (AtomicOperation::Or, "or"),
        (AtomicOperation::Xor, "xor"),
    ];

    for (atomic_op, op_name) in atomic_ops {
        for (data_type, sign_name) in data_signs {
            for (shader_type, shader_name) in shader_types {
                // Only ADD, MIN, MAX and EXCHANGE are supported on floating-point
                if data_type.float_kind().is_some()
                    && !matches!(
                        atomic_op,
                        AtomicOperation::Add | AtomicOperation::Min | AtomicOperation::Max | AtomicOperation::Exchange
                    )
                {
                    continue;
                }

                for (memory_type, suffix) in memory_types {
                    // Shared memory only available in compute, task and mesh shaders.
                    if memory_type == AtomicMemoryType::Shared
                        && !matches!(shader_type, ShaderType::Compute | ShaderType::Task | ShaderType::Mesh)
                    {
                        continue;
                    }
                    // Payload memory is only available for atomics in task shaders (in mesh shaders it's read-only)
                    if memory_type == AtomicMemoryType::Payload && shader_type != ShaderType::Task {
                        continue;
                    }

                    let key = format!("atomic_{op_name}_{sign_name}_{shader_name}{suffix}");
                    let name = format!("{op_name}_{sign_name}_{shader_name}{suffix}");
                    group.add_child(Box::new(AtomicOperationCase::new(
                        name,
                        AtomicShaderType::new(shader_type, memory_type),
                        data_type,
                        atomic_op,
                        key,
                    )) as Box<dyn TestCase>);
                }
            }
        }
    }
    group
}
