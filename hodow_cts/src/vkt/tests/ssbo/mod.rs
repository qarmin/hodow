// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/ssbo/vktSSBOLayoutCase.cpp (SSBOLayoutCase, SSBOLayoutCaseInstance, generateValues, copyNonWrittenData, compareData)
//   external/vulkancts/modules/vulkan/ssbo/vktSSBOLayoutTests.cpp (createTests, unsized_array_length)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Samsung Electronics Co., Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The reference layout, the case tree and the compute shaders (which embed the reference data as literals) are produced by
// scripts/ssbo_cases.py and listed in `ssbo_cases.rs`; this file draws the same reference data again from the same seeds (`generate_value`), uploads it, runs the shader
// and compares what the shader wrote, which is what the upstream instance does with the layout it was constructed from.

pub mod corner_case;
pub mod ssbo_cases;

use std::collections::BTreeMap;

use ssbo_cases::{
    REQ_8BIT_STORAGE, REQ_16BIT_STORAGE, REQ_DESCRIPTOR_INDEXING, REQ_PHYS, REQ_RELAXED, REQ_SCALAR, SSBO_CASES,
    UNSIZED_ARRAY_LENGTH_CASES,
};
use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, InstanceV1_1};

use crate::tcu::{Random, TestError, TestOutcome, TestStatus, de_string_hash};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorPoolBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const AC_BUFFER_SIZE: u64 = 1024;

/// One buffer variable of a block: a `BufferVarLayoutEntry` with the scalar kind spelled as a number (0 f32, 1 i32, 2 u32, 3 bool, 4 i8, 5 u8, 6 i16, 7 u16, 8 f16).
pub struct VarDef {
    pub kind: u8,
    pub comps: u8,
    pub vecs: u8,
    pub offset: u32,
    pub array_size: u32,
    pub array_stride: u32,
    pub top_size: u32,
    pub top_stride: u32,
    pub matrix_stride: u32,
    pub row_major: bool,
    pub written: bool,
}

#[allow(clippy::too_many_arguments)]
pub const fn v(
    kind: u8,
    comps: u8,
    vecs: u8,
    offset: u32,
    array_size: u32,
    array_stride: u32,
    top_size: u32,
    top_stride: u32,
    matrix_stride: u32,
    row_major: bool,
    written: bool,
) -> VarDef {
    VarDef {
        kind,
        comps,
        vecs,
        offset,
        array_size,
        array_stride,
        top_size,
        top_stride,
        matrix_stride,
        row_major,
        written,
    }
}

impl VarDef {
    fn is_matrix(&self) -> bool {
        self.vecs > 1
    }

    fn comp_size(&self) -> usize {
        [4, 4, 4, 4, 1, 1, 2, 2, 2][self.kind as usize]
    }

    /// (rows, columns) of a matrix
    fn matrix_dims(&self) -> (usize, usize) {
        let other = usize::from(self.comps) / usize::from(self.vecs);
        if self.row_major {
            (usize::from(self.vecs), other)
        } else {
            (other, usize::from(self.vecs))
        }
    }
}

/// One block instance (`BlockLayoutEntry`) in the order the reference layout lists them.
pub struct BlockDef {
    pub binding: u32,
    pub instance: u32,
    pub size: u64,
    pub last_unsized: u64,
    pub vars: &'static [VarDef],
}

/// One case of `ssbo_cases.rs`.
pub struct SsboCaseDef {
    /// the dotted path below `ssbo`
    pub name: &'static str,
    pub per_block_buffer: bool,
    /// allocates just over 4 GB
    pub big: bool,
    pub requirements: u32,
    pub num_blocks: u32,
    pub blocks: &'static [BlockDef],
    pub programs: Option<&'static SharedProgram>,
}

pub struct UnsizedArrayLengthDef {
    pub name: &'static str,
    pub element_size: u64,
    pub buffer_size: u64,
    pub use_min_buffer_offset: bool,
    pub buffer_bind_length: u64,
    pub variable_pointers: bool,
    pub length64: bool,
    pub programs: &'static SharedProgram,
}

fn first_elem_to_compare(array_size: u64) -> u64 {
    array_size.saturating_sub(20)
}

fn f16_bits(value: i32) -> u16 {
    let bits = (value as f32).to_bits();
    if value == 0 {
        return 0;
    }
    let sign = ((bits >> 31) << 15) as u16;
    let exponent = (((bits >> 23) & 0xFF) as i32 - 127 + 15) as u16;
    let mantissa = ((bits >> 13) & 0x3FF) as u16;
    sign | (exponent << 10) | mantissa
}

/// Calls `f(offset, comp_index)` for every scalar component upstream's loops visit: the entry's top-level elements, the last 20 array elements, every vector of a matrix.
fn for_each_component(var: &VarDef, unsized_size: u64, mut f: impl FnMut(usize)) {
    let comp_size = var.comp_size();
    let array_size = if var.array_size == 0 {
        unsized_size
    } else {
        u64::from(var.array_size)
    };
    let top_size = if var.top_size == 0 {
        unsized_size
    } else {
        u64::from(var.top_size)
    };
    let num_vecs = usize::from(var.vecs);
    let vec_size = usize::from(var.comps) / num_vecs;
    for top in 0..top_size {
        let top_off = var.offset as usize + (top as usize) * var.top_stride as usize;
        for elem in first_elem_to_compare(array_size)..array_size {
            let elem_off = top_off + (elem as usize) * var.array_stride as usize;
            for vec in 0..num_vecs {
                let vec_off = elem_off
                    + if var.is_matrix() {
                        vec * var.matrix_stride as usize
                    } else {
                        0
                    };
                for comp in 0..vec_size {
                    f(vec_off + comp_size * comp);
                }
            }
        }
    }
}

/// `generateValue`
fn generate_value(var: &VarDef, unsized_size: u64, data: &mut [u8], rnd: &mut Random) {
    let kind = var.kind;
    for_each_component(var, unsized_size, |off| match kind {
        0 => data[off..off + 4].copy_from_slice(&(rnd.get_int(-9, 9) as f32).to_le_bytes()),
        1 => data[off..off + 4].copy_from_slice(&rnd.get_int(-9, 9).to_le_bytes()),
        2 => data[off..off + 4].copy_from_slice(&(rnd.get_int(0, 9) as u32).to_le_bytes()),
        4 => data[off] = rnd.get_int(-9, 9) as i8 as u8,
        5 => data[off] = rnd.get_int(0, 9) as u8,
        6 => data[off..off + 2].copy_from_slice(&(rnd.get_int(-9, 9) as i16).to_le_bytes()),
        7 => data[off..off + 2].copy_from_slice(&(rnd.get_int(0, 9) as u16).to_le_bytes()),
        8 => data[off..off + 2].copy_from_slice(&f16_bits(rnd.get_int(-9, 9)).to_le_bytes()),
        _ => {
            let value = if rnd.get_bool() { rnd.get_uint32() | 1 } else { 0 };
            data[off..off + 4].copy_from_slice(&value.to_le_bytes());
        }
    });
}

/// `generateValues`, `copyNonWrittenData` included for the second draw.
fn draw_data(def: &SsboCaseDef, seed: u32) -> Vec<Vec<u8>> {
    let mut rnd = Random::new(seed);
    let mut blocks: Vec<Vec<u8>> = def.blocks.iter().map(|b| vec![0u8; b.size as usize]).collect();
    for (block, data) in def.blocks.iter().zip(blocks.iter_mut()) {
        for var in block.vars {
            generate_value(var, block.last_unsized, data, &mut rnd);
        }
    }
    blocks
}

/// `copyBufferVarData` over one variable
fn copy_var_data(var: &VarDef, unsized_size: u64, dst: &mut [u8], src: &[u8]) {
    let comp_size = var.comp_size();
    let array_size = if var.array_size == 0 {
        unsized_size
    } else {
        u64::from(var.array_size)
    };
    let top_size = if var.top_size == 0 {
        unsized_size
    } else {
        u64::from(var.top_size)
    };
    for top in 0..top_size {
        let top_off = var.offset as usize + (top as usize) * var.top_stride as usize;
        for elem in first_elem_to_compare(array_size)..array_size {
            let elem_off = top_off + (elem as usize) * var.array_stride as usize;
            if var.is_matrix() {
                let (rows, cols) = var.matrix_dims();
                for col in 0..cols {
                    for row in 0..rows {
                        let stride = var.matrix_stride as usize;
                        let off = elem_off
                            + if var.row_major {
                                row * stride + col * comp_size
                            } else {
                                col * stride + row * comp_size
                            };
                        dst[off..off + comp_size].copy_from_slice(&src[off..off + comp_size]);
                    }
                }
            } else {
                let len = usize::from(var.comps) * comp_size;
                dst[elem_off..elem_off + len].copy_from_slice(&src[elem_off..elem_off + len]);
            }
        }
    }
}

/// `compareComponents`
fn compare_components(kind: u8, expected: &[u8], got: &[u8]) -> bool {
    match kind {
        0 => {
            (f32::from_le_bytes(got[..4].try_into().unwrap()) - f32::from_le_bytes(expected[..4].try_into().unwrap()))
                .abs()
                < 0.05
        }
        3 => {
            (u32::from_le_bytes(expected[..4].try_into().unwrap()) != 0)
                == (u32::from_le_bytes(got[..4].try_into().unwrap()) != 0)
        }
        _ => expected == got,
    }
}

/// `compareBufferVarData` over one variable, returns the number of mismatching elements
fn compare_var_data(var: &VarDef, unsized_size: u64, expected: &[u8], got: &[u8], name: &str) -> usize {
    let comp_size = var.comp_size();
    let array_size = if var.array_size == 0 {
        unsized_size
    } else {
        u64::from(var.array_size)
    };
    let top_size = if var.top_size == 0 {
        unsized_size
    } else {
        u64::from(var.top_size)
    };
    let mut failed = 0usize;
    for top in 0..top_size {
        let top_off = var.offset as usize + (top as usize) * var.top_stride as usize;
        for elem in first_elem_to_compare(array_size)..array_size {
            let elem_off = top_off + (elem as usize) * var.array_stride as usize;
            let ok = if var.is_matrix() {
                let (rows, cols) = var.matrix_dims();
                let stride = var.matrix_stride as usize;
                let mut ok = true;
                for col in 0..cols {
                    for row in 0..rows {
                        let off = elem_off
                            + if var.row_major {
                                row * stride + col * comp_size
                            } else {
                                col * stride + row * comp_size
                            };
                        ok = ok
                            && compare_components(
                                var.kind,
                                &expected[off..off + comp_size],
                                &got[off..off + comp_size],
                            );
                    }
                }
                ok
            } else {
                let mut ok = true;
                for comp in 0..usize::from(var.comps) {
                    let off = elem_off + comp * comp_size;
                    ok =
                        ok && compare_components(var.kind, &expected[off..off + comp_size], &got[off..off + comp_size]);
                }
                ok
            };
            if !ok {
                failed += 1;
                if failed < 3 {
                    log::info!("ERROR: mismatch in {name}, top-level ndx {top}, bottom-level ndx {elem}");
                }
            }
        }
    }
    if failed >= 3 {
        log::info!("... ({failed} failures for {name} in total)");
    }
    failed
}

/// `shader64BitIndexing` of `VK_EXT_shader_64bit_indexing`, false when the extension is absent
fn shader_64bit_indexing_supported(context: &Context<'_>) -> bool {
    if !context.is_device_functionality_supported("VK_EXT_shader_64bit_indexing") {
        return false;
    }
    let mut indexing = vk::PhysicalDeviceShader64BitIndexingFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut indexing);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    indexing.shader_64bit_indexing != vk::FALSE
}

/// `deviceHasHeapForSsbo64bAllocation`: a device local heap for the ~4 GB the 64-bit indexing cases allocate, plus 256 MB headroom
fn device_has_heap_for_ssbo_64b_allocation(context: &Context<'_>) -> bool {
    let memory_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_memory_properties(context.get_physical_device())
    };
    let required_heap_size = (1u64 << 32) + (1u64 << 28);
    memory_properties.memory_heaps[..memory_properties.memory_heap_count as usize]
        .iter()
        .any(|heap| heap.flags.contains(vk::MemoryHeapFlags::DEVICE_LOCAL) && heap.size >= required_heap_size)
}

struct SsboCase {
    name: &'static str,
    def: &'static SsboCaseDef,
}

impl TestCase for SsboCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `SSBOLayoutCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let def = self.def;
        if def.big {
            if !shader_64bit_indexing_supported(context) {
                return Err(TestError::NotSupported(
                    "shader64BitIndexing not supported by this implementation".to_string(),
                ));
            }
            if !device_has_heap_for_ssbo_64b_allocation(context) {
                return Err(TestError::NotSupported(
                    "No device-local memory heap large enough for >4GB SSBO allocation".to_string(),
                ));
            }
        }
        let requirements = def.requirements;
        let not_supported = |message: &str| Err(TestError::NotSupported(message.to_string()));

        if requirements & REQ_RELAXED != 0 && !context.is_device_functionality_supported("VK_KHR_relaxed_block_layout")
        {
            return not_supported("VK_KHR_relaxed_block_layout not supported");
        }

        let mut storage16 = vk::PhysicalDevice16BitStorageFeatures::default();
        let mut storage8 = vk::PhysicalDevice8BitStorageFeatures::default();
        let mut scalar_layout = vk::PhysicalDeviceScalarBlockLayoutFeatures::default();
        let mut indexing = vk::PhysicalDeviceDescriptorIndexingFeatures::default();
        let mut bda = vk::PhysicalDeviceBufferDeviceAddressFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder()
                .push_next(&mut storage16)
                .push_next(&mut storage8)
                .push_next(&mut scalar_layout)
                .push_next(&mut indexing)
                .push_next(&mut bda);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }

        if requirements & REQ_16BIT_STORAGE != 0 && storage16.storage_buffer_16bit_access == vk::FALSE {
            return not_supported("storageBuffer16BitAccess not supported");
        }
        if requirements & REQ_16BIT_STORAGE != 0 && storage16.uniform_and_storage_buffer_16bit_access == vk::FALSE {
            return not_supported("uniformAndStorageBuffer16BitAccess not supported");
        }
        if requirements & REQ_8BIT_STORAGE != 0 && storage8.storage_buffer_8bit_access == vk::FALSE {
            return not_supported("storageBuffer8BitAccess not supported");
        }
        if requirements & REQ_SCALAR != 0 && scalar_layout.scalar_block_layout == vk::FALSE {
            return not_supported("scalarBlockLayout not supported");
        }
        if requirements & REQ_PHYS != 0 && bda.buffer_device_address == vk::FALSE {
            return not_supported("Physical storage buffer pointers not supported");
        }
        if requirements & REQ_DESCRIPTOR_INDEXING != 0
            && (indexing.shader_storage_buffer_array_non_uniform_indexing == vk::FALSE
                || indexing.runtime_descriptor_array == vk::FALSE)
        {
            return not_supported("Descriptor indexing over storage buffer not supported");
        }

        // Shader defines N+1 storage buffers: N to operate and one more to store the number of cases passed.
        if context
            .get_device_properties()
            .limits
            .max_per_stage_descriptor_storage_buffers
            < def.num_blocks + 1
        {
            return not_supported(
                "Descriptor set storage buffers count higher than the maximum supported by the driver",
            );
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.def.programs.map_or(BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SsboInstance {
            context,
            def: self.def,
            name: self.name,
        })
    }
}

struct SsboInstance<'a> {
    context: &'a Context<'a>,
    def: &'static SsboCaseDef,
    name: &'static str,
}

impl SsboInstance<'_> {
    fn host_buffer<'d>(
        &self,
        device: &'d Device,
        size: u64,
        usage: vk::BufferUsageFlags,
        device_address: bool,
    ) -> Result<BufferWithMemory<'d>, TestError> {
        let requirement = if device_address {
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS
        } else {
            MemoryRequirement::HOST_VISIBLE
        };
        BufferWithMemory::new(
            device,
            self.context.get_default_allocator(),
            make_buffer_create_info(size, usage),
            requirement,
        )
    }
}

impl TestInstance for SsboInstance<'_> {
    /// `SSBOLayoutCaseInstance::queuePass`: running out of memory with a 4 GB buffer is NotSupported
    fn iterate(&mut self) -> TestOutcome {
        match self.iterate_impl() {
            Err(TestError::ResourceError(_)) if self.def.big => {
                Err(TestError::NotSupported("Out of memory".to_string()))
            }
            other => other,
        }
    }
}

impl SsboInstance<'_> {
    /// `SSBOLayoutCaseInstance::queuePassImpl`
    fn iterate_impl(&self) -> TestOutcome {
        let context = self.context;
        let def = self.def;
        let device = context.get_device();
        let phys = def.requirements & REQ_PHYS != 0;
        let (queue, queue_family_index) = context.get_compute_queue().unwrap_or((
            context.get_universal_queue(),
            context.get_universal_queue_family_index(),
        ));

        let seed = de_string_hash(self.name);
        let initial = draw_data(def, seed ^ 0xad2f7214);
        let mut written = draw_data(def, seed ^ 0x25ca4e7);
        for ((block, dst), src) in def.blocks.iter().zip(written.iter_mut()).zip(&initial) {
            for var in block.vars.iter().filter(|var| !var.written) {
                copy_var_data(var, block.last_unsized, dst, src);
            }
        }

        let ac_buffer = self.host_buffer(device, AC_BUFFER_SIZE, vk::BufferUsageFlags::STORAGE_BUFFER, false)?;
        unsafe { std::ptr::write_bytes(ac_buffer.get_allocation().get_host_ptr(), 0, AC_BUFFER_SIZE as usize) };
        flush_alloc(device, ac_buffer.get_allocation())?;

        let mut binding_counts: BTreeMap<u32, u32> = BTreeMap::new();
        for block in def.blocks {
            *binding_counts.entry(block.binding).or_insert(0) += 1;
        }
        let mut bindings = vec![vk::DescriptorSetLayoutBinding {
            binding: 0,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            descriptor_count: 1,
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            immutable_samplers: std::ptr::null(),
        }];
        for (&binding, &count) in &binding_counts {
            bindings.push(vk::DescriptorSetLayoutBinding {
                binding,
                descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
                descriptor_count: count,
                stage_flags: vk::ShaderStageFlags::COMPUTE,
                immutable_samplers: std::ptr::null(),
            });
        }
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let descriptor_set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1 + def.blocks.len() as u32)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let mut usage = vk::BufferUsageFlags::STORAGE_BUFFER;
        if phys {
            usage |= vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
        }

        // Upload base buffers: every block is a zeroed buffer with the reference data of its variables copied in (`copyData`)
        let mut buffers: Vec<BufferWithMemory<'_>> = Vec::new();
        let mut buffer_sizes: Vec<u64> = Vec::new();
        let mut descriptors: Vec<vk::DescriptorBufferInfo> = Vec::with_capacity(def.blocks.len());
        let mut locations: Vec<(usize, u64)> = Vec::with_capacity(def.blocks.len());
        if def.per_block_buffer {
            for (ndx, block) in def.blocks.iter().enumerate() {
                let buffer = self.host_buffer(device, block.size, usage, phys)?;
                descriptors.push(make_descriptor_buffer_info(buffer.get(), 0, block.size));
                locations.push((ndx, 0));
                buffer_sizes.push(block.size);
                buffers.push(buffer);
            }
        } else {
            let alignment = context
                .get_device_properties()
                .limits
                .min_storage_buffer_offset_alignment;
            let mut current_offset = 0u64;
            let mut offsets = Vec::with_capacity(def.blocks.len());
            for block in def.blocks {
                if alignment > 0 {
                    current_offset = current_offset.next_multiple_of(alignment);
                }
                offsets.push(current_offset);
                current_offset += block.size;
            }
            let buffer = self.host_buffer(device, current_offset, usage, phys)?;
            for (block, &offset) in def.blocks.iter().zip(&offsets) {
                descriptors.push(make_descriptor_buffer_info(buffer.get(), offset, block.size));
                locations.push((0, offset));
            }
            buffer_sizes.push(current_offset);
            buffers.push(buffer);
        }
        for (buffer, &size) in buffers.iter().zip(&buffer_sizes) {
            unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, size as usize) };
        }
        for ((block, data), &(buffer_ndx, offset)) in def.blocks.iter().zip(&initial).zip(&locations) {
            let mut image = vec![0u8; block.size as usize];
            for var in block.vars {
                copy_var_data(var, block.last_unsized, &mut image, data);
            }
            unsafe {
                std::ptr::copy_nonoverlapping(
                    image.as_ptr(),
                    buffers[buffer_ndx].get_allocation().get_host_ptr().add(offset as usize),
                    image.len(),
                )
            };
        }
        for buffer in &buffers {
            flush_alloc(device, buffer.get_allocation())?;
        }

        let ac_info = make_descriptor_buffer_info(ac_buffer.get(), 0, AC_BUFFER_SIZE);
        let mut writes = vec![
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(std::slice::from_ref(&ac_info))
                .build(),
        ];
        for (block, info) in def.blocks.iter().zip(&descriptors) {
            writes.push(
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(block.binding)
                    .dst_array_element(block.instance)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(std::slice::from_ref(info))
                    .build(),
            );
        }
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Query the buffer device addresses and push them via push constants
        let mut gpu_addresses: Vec<u8> = Vec::new();
        if phys {
            for info in &descriptors {
                let address_info = vk::BufferDeviceAddressInfo::builder().buffer(info.buffer);
                let address = unsafe { device.get_buffer_device_address(&address_info) } + info.offset;
                gpu_addresses.extend_from_slice(&address.to_le_bytes());
            }
        }

        let set_layouts = [*descriptor_set_layout];
        let push_range = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            offset: 0,
            size: gpu_addresses.len() as u32,
        }];
        let mut layout_create_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        if phys {
            layout_create_info = layout_create_info.push_constant_ranges(&push_range);
        }
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_create_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let compute_module = create_shader_module(device, binaries.get("compute")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_module)
            .name(b"main\0");
        let mut pipeline_flags2 = vk::PipelineCreateFlags2CreateInfo {
            flags: vk::PipelineCreateFlags2::_64_BIT_INDEXING_EXT,
            ..Default::default()
        };
        let mut pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        if def.big {
            pipeline_info = pipeline_info.push_next(&mut pipeline_flags2);
        }
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        begin_command_buffer(device, cmd)?;
        let to_host = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::SHADER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            if phys {
                device.cmd_push_constants(cmd, *pipeline_layout, vk::ShaderStageFlags::COMPUTE, 0, &gpu_addresses);
            }
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, 1, 1, 1);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[*to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Read back ac_numPassed data
        invalidate_alloc(device, ac_buffer.get_allocation())?;
        let passed = unsafe { std::ptr::read_unaligned(ac_buffer.get_allocation().get_host_ptr().cast::<i32>()) };
        let counter_ok = passed == 1;
        if !counter_ok {
            log::info!("Error: ac_numPassed = {passed}, expected 1");
        }

        for buffer in &buffers {
            invalidate_alloc(device, buffer.get_allocation())?;
        }

        // Validate result
        let mut compare_ok = true;
        for ((block, expected), &(buffer_ndx, offset)) in def.blocks.iter().zip(&written).zip(&locations) {
            let got = unsafe {
                std::slice::from_raw_parts(
                    buffers[buffer_ndx].get_allocation().get_host_ptr().add(offset as usize),
                    block.size as usize,
                )
            };
            for (var_ndx, var) in block.vars.iter().enumerate() {
                let label = format!("binding {} instance {} var {var_ndx}", block.binding, block.instance);
                compare_ok = compare_var_data(var, block.last_unsized, expected, got, &label) == 0 && compare_ok;
            }
        }

        Ok(match (compare_ok, counter_ok) {
            (true, true) => TestStatus::pass("Result comparison and counter values are OK"),
            (false, true) => TestStatus::fail("Result comparison failed"),
            (true, false) => TestStatus::fail("Counter value incorrect"),
            (false, false) => TestStatus::fail("Result comparison and counter values are incorrect"),
        })
    }
}

struct UnsizedArrayLengthCase {
    def: &'static UnsizedArrayLengthDef,
}

impl TestCase for UnsizedArrayLengthCase {
    fn name(&self) -> &str {
        self.def.name
    }

    /// `checkSupportUnsizedArrays`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.def.variable_pointers {
            let mut pointers = vk::PhysicalDeviceVariablePointersFeatures::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut pointers);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
            if pointers.variable_pointers_storage_buffer == vk::FALSE {
                return Err(TestError::NotSupported(
                    "variablePointersStorageBuffer capability not supported".to_string(),
                ));
            }
        }
        if (self.def.length64 || self.def.buffer_size > (1u64 << 32)) && !shader_64bit_indexing_supported(context) {
            return Err(TestError::NotSupported(
                "shader64BitIndexing not supported by this implementation".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.def.programs.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(UnsizedArrayLengthInstance { context, def: self.def })
    }
}

struct UnsizedArrayLengthInstance<'a> {
    context: &'a Context<'a>,
    def: &'static UnsizedArrayLengthDef,
}

impl TestInstance for UnsizedArrayLengthInstance<'_> {
    /// `ssboUnsizedArrayLengthTest`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.def;
        let device = context.get_device();
        let (queue, queue_family_index) = (
            context.get_universal_queue(),
            context.get_universal_queue_family_index(),
        );
        let allocator = context.get_default_allocator();

        let bindings = [0u32, 1].map(|binding| vk::DescriptorSetLayoutBinding {
            binding,
            descriptor_type: vk::DescriptorType::STORAGE_BUFFER,
            descriptor_count: 1,
            stage_flags: vk::ShaderStageFlags::COMPUTE,
            immutable_samplers: std::ptr::null(),
        });
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let descriptor_set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let set_layouts = [*descriptor_set_layout];
        let layout_create_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_create_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let compute_module = create_shader_module(device, binaries.get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_module)
            .name(b"main\0");
        let mut pipeline_flags2 = vk::PipelineCreateFlags2CreateInfo {
            flags: vk::PipelineCreateFlags2::_64_BIT_INDEXING_EXT,
            ..Default::default()
        };
        let mut pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(*stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        if params.buffer_size > (1u64 << 32) {
            pipeline_info = pipeline_info.push_next(&mut pipeline_flags2);
        }
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        let whole_size = vk::WHOLE_SIZE;
        let min_offset = context
            .get_device_properties()
            .limits
            .min_storage_buffer_offset_alignment;
        let mut input_buffer_size = params.buffer_size;
        if params.use_min_buffer_offset && params.buffer_bind_length != whole_size {
            input_buffer_size = input_buffer_size.max(min_offset + params.buffer_bind_length);
        }
        let input_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(input_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(8, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let initial: i64 = if params.length64 { -1 } else { 0xFFFF_FFFF };
        unsafe { std::ptr::write_unaligned(output_buffer.get_allocation().get_host_ptr().cast::<i64>(), initial) };
        flush_alloc(device, output_buffer.get_allocation())?;

        let mut buffer_bind_offset = 0u64;
        let mut buffer_bind_length = params.buffer_bind_length;
        if params.use_min_buffer_offset {
            buffer_bind_offset = min_offset;
            if params.buffer_bind_length != whole_size {
                buffer_bind_length = buffer_bind_offset + params.buffer_bind_length;
            }
        }
        let input_range = if buffer_bind_length == whole_size {
            buffer_bind_length
        } else {
            buffer_bind_length - buffer_bind_offset
        };
        let input_desc = make_descriptor_buffer_info(input_buffer.get(), buffer_bind_offset, input_range);
        let output_desc = make_descriptor_buffer_info(output_buffer.get(), 0, whole_size);
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(std::slice::from_ref(&input_desc))
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(*descriptor_set)
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(std::slice::from_ref(&output_desc))
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let command_pool = make_command_pool(device, queue_family_index)?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;
        begin_command_buffer(device, cmd)?;
        let barrier = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::SHADER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_dispatch(cmd, 1, 1, 1);
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::ALL_COMMANDS,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[*barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        invalidate_alloc(device, output_buffer.get_allocation())?;
        let actual = unsafe { std::ptr::read_unaligned(output_buffer.get_allocation().get_host_ptr().cast::<i64>()) };
        let bound_length = (if params.buffer_bind_length == whole_size {
            params.buffer_size
        } else {
            buffer_bind_length
        }) - buffer_bind_offset;
        let expected = (bound_length / params.element_size) as i64;
        log::info!(
            "Buffer size {} offset {buffer_bind_offset} length {} element size {} expected array size: {expected} actual array size: {actual}",
            params.buffer_size,
            params.buffer_bind_length,
            params.element_size
        );
        if expected == actual {
            Ok(TestStatus::pass("Got expected array size"))
        } else {
            Ok(TestStatus::fail("Mismatch array size"))
        }
    }
}

/// A group under construction, as in `ubo`: cases only sit in the innermost group.
struct Node {
    name: String,
    groups: Vec<Node>,
    cases: Vec<Box<dyn TestCase>>,
}

impl Node {
    fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),
            groups: Vec::new(),
            cases: Vec::new(),
        }
    }

    fn insert(&mut self, path: &[&'static str], case: Box<dyn TestCase>) {
        let Some((first, rest)) = path.split_first() else {
            self.cases.push(case);
            return;
        };
        if self.groups.last().is_none_or(|g| g.name != *first) {
            self.groups.push(Node::new(first));
        }
        self.groups.last_mut().expect("just pushed").insert(rest, case);
    }

    fn into_group(self) -> TestCaseGroup {
        let mut group = TestCaseGroup::new(self.name);
        for child in self.groups {
            group.add_child(child.into_group());
        }
        for case in self.cases {
            group.add_child(case);
        }
        group
    }
}

/// `createTests` (`ssbo`): layout, unsized_array_length, readonly, phys; corner_case; the nested unsized array cases are not ported yet.
pub fn create_tests() -> TestCaseGroup {
    let mut root = Node::new("ssbo");
    let mut layout_group = Node::new("layout");
    let mut readonly_group = Node::new("readonly");
    let mut phys_group = Node::new("phys");
    for def in SSBO_CASES {
        let mut path: Vec<&'static str> = def.name.split('.').collect();
        let name = path.pop().expect("a case has a name");
        let case: Box<dyn TestCase> = Box::new(SsboCase { name, def });
        match path.first().copied() {
            Some("readonly") => readonly_group.insert(&path[2..], case),
            Some("phys") => phys_group.insert(&path[2..], case),
            _ => layout_group.insert(&path[1..], case),
        }
    }
    let mut length_group = Node::new("unsized_array_length");
    for def in UNSIZED_ARRAY_LENGTH_CASES {
        length_group.cases.push(Box::new(UnsizedArrayLengthCase { def }));
    }
    let mut corner_case_group = Node::new("corner_case");
    corner_case_group.cases.push(Box::new(corner_case::CornerCase));
    root.groups.push(layout_group);
    root.groups.push(length_group);
    root.groups.push(corner_case_group);
    root.groups.push(readonly_group.wrap("layout"));
    root.groups.push(phys_group.wrap("layout"));
    root.into_group()
}

impl Node {
    /// Puts this group's children below a new single group named `name`, which is how upstream nests `layout` under `readonly` and `phys`.
    fn wrap(mut self, name: &str) -> Node {
        let inner = Node {
            name: name.to_string(),
            groups: std::mem::take(&mut self.groups),
            cases: Vec::new(),
        };
        self.groups.push(inner);
        self
    }
}
