// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmMaint9VectorizationTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the 3152 cases is in `shaders/manifest/spirv_assembly_maint9_vectorization.toml` (written by
// `scripts/gen_spirv_assembly_maint9_vectorization_manifest.py`, which replays `M9V_Case::initPrograms` and the loops of `createMaint9VectorizationTests`); the operation and
// the (vector, signed, bits) of each operand ride along as `spec`. The operands of the 64 invocations are drawn from `de::Random` seeded the way `getRandomSeed` does,
// the expected result is calculated here and every component is compared exactly. A value of an operand is kept as a u64 holding its low `bits` bits.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::generated::shaders::spirv_assembly_maint9_vectorization::ALL_MAINT9_VECTORIZATION_CASE;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::compute_pipeline::{ComputePipelineConstructionType, ComputePipelineWrapper};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_memory_barrier,
};
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestInstance};

const WORK_GROUP_SIZE: usize = 64;

/// The `rust_type` of the manifest entries: one `M9V_Case`.
#[derive(Clone, Copy)]
pub struct Maint9VectorizationCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BitOp {
    Count = 0,
    Reverse,
    Insert,
    SExtract,
    UExtract,
}

#[derive(Clone, Copy)]
struct Operand {
    is_vector: bool,
    bits: u32,
}

impl Operand {
    fn component_count(&self) -> usize {
        if self.is_vector { 4 } else { 1 }
    }

    fn data_size_bytes(&self) -> usize {
        (self.bits / 8) as usize * self.component_count()
    }
}

#[derive(Clone)]
struct Params {
    bit_op: BitOp,
    operands: Vec<Operand>,
}

fn parse(spec: &str) -> Params {
    let mut op = None;
    let mut operands = Vec::new();
    for entry in spec.split(';') {
        if let Some(value) = entry.strip_prefix("op=") {
            op = Some(match value.parse::<u32>().expect("an operation") {
                0 => BitOp::Count,
                1 => BitOp::Reverse,
                2 => BitOp::Insert,
                3 => BitOp::SExtract,
                _ => BitOp::UExtract,
            });
        } else if let Some(list) = entry.strip_prefix("operands=") {
            for operand in list.split(',') {
                let mut parts = operand.split('.');
                let is_vector = parts.next() == Some("1");
                let _signed = parts.next();
                let bits = parts.next().and_then(|bits| bits.parse().ok()).expect("a bit size");
                operands.push(Operand { is_vector, bits });
            }
        }
    }
    Params {
        bit_op: op.expect("an operation"),
        operands,
    }
}

impl Params {
    fn uses_bits(&self, bits: u32) -> bool {
        self.operands.iter().any(|operand| operand.bits == bits)
    }

    /// `getRandomSeed`
    fn random_seed(&self) -> u32 {
        let mut seed = (self.bit_op as u32) << 24;
        for (i, operand) in self.operands.iter().enumerate() {
            seed = seed.wrapping_add(((u32::from(operand.is_vector) << 8) | operand.bits) << i);
        }
        seed
    }
}

/// `OperandValue`
#[derive(Clone, PartialEq, Eq)]
struct OperandValue {
    bits: u32,
    is_vector: bool,
    components: [u64; 4],
}

impl OperandValue {
    fn component_count(&self) -> usize {
        if self.is_vector { 4 } else { 1 }
    }

    fn from_bytes(bits: u32, is_vector: bool, bytes: &[u8]) -> Self {
        let mut value = Self {
            bits,
            is_vector,
            components: [0; 4],
        };
        let component_bytes = (bits / 8) as usize;
        for i in 0..value.component_count() {
            let mut component = [0u8; 8];
            component[..component_bytes].copy_from_slice(&bytes[i * component_bytes..(i + 1) * component_bytes]);
            value.components[i] = u64::from_le_bytes(component);
        }
        value
    }

    fn to_bytes(&self) -> Vec<u8> {
        let component_bytes = (self.bits / 8) as usize;
        (0..self.component_count())
            .flat_map(|i| self.components[i].to_le_bytes()[..component_bytes].to_vec())
            .collect()
    }

    fn to_text(&self) -> String {
        let parts: Vec<String> = self.components[..self.component_count()]
            .iter()
            .map(u64::to_string)
            .collect();
        if self.is_vector {
            format!("({})", parts.join(", "))
        } else {
            parts.concat()
        }
    }
}

fn mask_to_bit_width(value: u64, bits: u32) -> u64 {
    if bits >= 64 {
        value
    } else {
        value & ((1u64 << bits) - 1)
    }
}

/// `genSingleOperand`
fn gen_single_operand(rnd: &mut Random, bits: u32, is_vector: bool, min_max: Option<(i32, i32)>) -> OperandValue {
    let mut value = OperandValue {
        bits,
        is_vector,
        components: [0; 4],
    };
    for i in 0..value.component_count() {
        value.components[i] = match min_max {
            Some((min, max)) => mask_to_bit_width(rnd.get_int(min, max) as u32 as u64, bits),
            None => match bits {
                8 => u64::from(rnd.get_uint8()),
                16 => u64::from(rnd.get_uint16()),
                32 => u64::from(rnd.get_uint32()),
                _ => rnd.get_uint64(),
            },
        };
    }
    value
}

/// `genValuesForOp`
fn gen_values_for_op(rnd: &mut Random, params: &Params) -> Vec<OperandValue> {
    let mut values = Vec::with_capacity(params.operands.len());

    if matches!(params.bit_op, BitOp::Count | BitOp::Reverse) {
        for operand in &params.operands {
            values.push(gen_single_operand(rnd, operand.bits, operand.is_vector, None));
        }
        return values;
    }

    let count = params.operands.len();
    for operand in &params.operands[..count - 2] {
        values.push(gen_single_operand(rnd, operand.bits, operand.is_vector, None));
    }

    let component_bits = params.operands[0].bits as i32;
    let offset_operand = params.operands[count - 2];
    values.push(gen_single_operand(
        rnd,
        offset_operand.bits,
        false,
        Some((0, component_bits)),
    ));

    let count_operand = params.operands[count - 1];
    let offset = values[count - 2].components[0] as i32;
    values.push(gen_single_operand(
        rnd,
        count_operand.bits,
        false,
        Some((0, component_bits - offset)),
    ));
    values
}

fn single_bit_reverse(value: u64, bit_count: u32) -> u64 {
    (0..bit_count).fold(0u64, |result, i| result | (((value >> i) & 1) << (bit_count - 1 - i)))
}

fn field_mask(count: u64) -> u64 {
    if count >= 64 { u64::MAX } else { (1u64 << count) - 1 }
}

fn shl(value: u64, amount: u64) -> u64 {
    value.checked_shl(amount as u32).filter(|_| amount < 64).unwrap_or(0)
}

fn shr(value: u64, amount: u64) -> u64 {
    value.checked_shr(amount as u32).filter(|_| amount < 64).unwrap_or(0)
}

fn single_bit_field_insert(base: u64, insert: u64, offset: u64, count: u64) -> u64 {
    let insert_mask = field_mask(count);
    let actual_insert = insert & insert_mask;
    let base_mask = !shl(insert_mask, offset);
    (base & base_mask) | shl(actual_insert, offset)
}

fn single_bit_field_extract(signed_extraction: bool, base: u64, offset: u64, count: u64) -> u64 {
    let base_mask = field_mask(count);
    let field = shl(base_mask, offset);
    let mut extracted = shr(base & field, offset);
    if signed_extraction && count > 0 && (extracted >> (count - 1)) & 1 != 0 {
        extracted |= !base_mask;
    }
    extracted
}

/// `calcOp`
fn calc_op(bit_op: BitOp, values: &[OperandValue]) -> OperandValue {
    let mut result = values[0].clone();
    let base = &values[1];
    for i in 0..base.component_count() {
        let component = match bit_op {
            BitOp::Count => u64::from(base.components[i].count_ones()),
            BitOp::Reverse => single_bit_reverse(base.components[i], base.bits),
            BitOp::Insert => single_bit_field_insert(
                base.components[i],
                values[2].components[i],
                values[3].components[0],
                values[4].components[0],
            ),
            BitOp::SExtract => mask_to_bit_width(
                single_bit_field_extract(
                    true,
                    base.components[i],
                    values[2].components[0],
                    values[3].components[0],
                ),
                base.bits,
            ),
            BitOp::UExtract => single_bit_field_extract(
                false,
                base.components[i],
                values[2].components[0],
                values[3].components[0],
            ),
        };
        result.components[i] = component;
    }
    result
}

fn op_name(bit_op: BitOp) -> &'static str {
    match bit_op {
        BitOp::Count => "OpBitCount",
        BitOp::Reverse => "OpBitReverse",
        BitOp::Insert => "OpBitFieldInsert",
        BitOp::SExtract => "OpBitFieldSExtract",
        BitOp::UExtract => "OpBitFieldUExtract",
    }
}

struct M9vCase {
    name: String,
    params: Params,
    programs: BinaryCollection,
}

impl TestCase for M9vCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `M9V_Case::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        if context.api_version() < (1, 3, 0) {
            return Err(TestError::NotSupported("Vulkan 1.3 required".to_string()));
        }

        if params.operands[1].bits != 32 {
            context.require_device_functionality("VK_KHR_maintenance9")?;
        }

        let mut vulkan11 = vk::PhysicalDeviceVulkan11Features::default();
        let mut vulkan12 = vk::PhysicalDeviceVulkan12Features::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder()
            .push_next(&mut vulkan11)
            .push_next(&mut vulkan12);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };

        if vulkan12.buffer_device_address == vk::FALSE {
            return Err(TestError::NotSupported("bufferDeviceAddress not supported".to_string()));
        }
        if vulkan12.scalar_block_layout == vk::FALSE {
            return Err(TestError::NotSupported("scalarBlockLayout not supported".to_string()));
        }

        let core = context.get_device_features();
        if params.uses_bits(64) && core.shader_int64 == vk::FALSE {
            return Err(TestError::NotSupported("shaderInt64 not supported".to_string()));
        }
        if params.uses_bits(16) && core.shader_int16 == vk::FALSE {
            return Err(TestError::NotSupported("shaderInt16 not supported".to_string()));
        }
        if params.uses_bits(8) && vulkan12.shader_int8 == vk::FALSE {
            return Err(TestError::NotSupported("shaderInt8 not supported".to_string()));
        }
        if params.uses_bits(16) && vulkan11.storage_buffer_16bit_access == vk::FALSE {
            return Err(TestError::NotSupported(
                "storageBuffer16BitAccess not supported".to_string(),
            ));
        }
        if params.uses_bits(8) && vulkan12.storage_buffer_8bit_access == vk::FALSE {
            return Err(TestError::NotSupported(
                "storageBuffer8BitAccess not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(M9vInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct M9vInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for M9vInstance<'_> {
    /// `M9V_Instance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let operand_buffer_usage = vk::BufferUsageFlags::STORAGE_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
        let operand_buffer_memory = MemoryRequirement::DEVICE_ADDRESS | MemoryRequirement::HOST_VISIBLE;

        // One buffer per operand, the first one the result; the shader reaches them through the addresses in the references buffer.
        let mut buffers = Vec::with_capacity(params.operands.len());
        for operand in &params.operands {
            let size = (operand.data_size_bytes() * WORK_GROUP_SIZE) as vk::DeviceSize;
            buffers.push(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(size, operand_buffer_usage),
                operand_buffer_memory,
            )?);
        }

        let mut rnd = Random::new(params.random_seed());
        let mut operations = Vec::with_capacity(WORK_GROUP_SIZE);
        for i in 0..WORK_GROUP_SIZE {
            let values = gen_values_for_op(&mut rnd, params);
            for (buffer, value) in buffers.iter().zip(&values) {
                let bytes = value.to_bytes();
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        bytes.as_ptr(),
                        buffer.get_allocation().get_host_ptr().add(bytes.len() * i),
                        bytes.len(),
                    )
                };
            }
            operations.push(values);
        }
        for buffer in &buffers {
            flush_alloc(device, buffer.get_allocation())?;
        }

        let references_size = (buffers.len() * std::mem::size_of::<vk::DeviceAddress>()) as vk::DeviceSize;
        let references_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(references_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let addresses: Vec<u8> = buffers
            .iter()
            .flat_map(|buffer| {
                unsafe {
                    device.get_buffer_device_address(&vk::BufferDeviceAddressInfo::builder().buffer(buffer.get()))
                }
                .to_ne_bytes()
            })
            .collect();
        unsafe {
            std::ptr::copy_nonoverlapping(
                addresses.as_ptr(),
                references_buffer.get_allocation().get_host_ptr(),
                addresses.len(),
            )
        };
        flush_alloc(device, references_buffer.get_allocation())?;

        let descriptor_type = vk::DescriptorType::STORAGE_BUFFER;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(descriptor_type, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(descriptor_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let references_info = make_descriptor_buffer_info(references_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                descriptor_type,
                &references_info,
            )
            .update(device);

        let mut pipeline = ComputePipelineWrapper::new(
            device,
            ComputePipelineConstructionType::Pipeline,
            context.get_binary_collection().get("comp")?,
        );
        pipeline.set_descriptor_set_layout(*set_layout);
        pipeline.build_pipeline()?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;
        begin_command_buffer(device, cmd)?;
        pipeline.bind(cmd);
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                pipeline.get_pipeline_layout(),
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, 1, 1, 1);
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let results_allocation = buffers[0].get_allocation();
        invalidate_alloc(device, results_allocation)?;
        let result_operand = params.operands[0];
        let result_size = result_operand.data_size_bytes();
        let results = unsafe {
            std::slice::from_raw_parts(
                results_allocation.get_host_ptr().cast_const(),
                result_size * WORK_GROUP_SIZE,
            )
        };

        let mut failures = Vec::new();
        for (i, operation) in operations.iter().enumerate() {
            let expected = calc_op(params.bit_op, operation);
            let result = OperandValue::from_bytes(
                result_operand.bits,
                result_operand.is_vector,
                &results[i * result_size..(i + 1) * result_size],
            );
            if expected != result {
                let arguments: Vec<String> = operation[1..].iter().map(OperandValue::to_text).collect();
                failures.push(format!(
                    "index {i}: {}({}) expected {} but found {}",
                    op_name(params.bit_op),
                    arguments.join(", "),
                    expected.to_text(),
                    result.to_text()
                ));
            }
        }

        if !failures.is_empty() {
            return Ok(TestStatus::fail(format!(
                "Some results differ from the expected values: {}",
                failures[0]
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMaint9VectorizationTests`, as the groups of each case path below `instruction` and the case.
pub fn create_maint9_vectorization_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_MAINT9_VECTORIZATION_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            segments.insert(0, "maint9_vectorization");
            let case: Box<dyn TestCase> = Box::new(M9vCase {
                name: leaf.to_string(),
                params: parse(case.spec),
                programs: case.programs,
            });
            (segments, case)
        })
        .collect()
}
