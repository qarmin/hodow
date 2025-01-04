// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustBufferAccessWithVariablePointersTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The SPIR-V assembly `MakeShader` composes is written out by
// scripts/gen_robustness_variable_pointers_manifest.py (shaders/manifest/robustness_variable_pointers.toml), and `variable_pointers_programs.rs` maps a case to its
// programs. Upstream creates a device with robustBufferAccess and the variable pointer features on; the Context's device has both.
//
// Reads or writes storage buffers through variable pointers (OpSelect between two access chains) at an offset past the buffer's descriptor range, in the vertex,
// fragment and compute stages, and checks the out of bounds accesses return values from the buffer's memory or zero and land inside the memory or not at all.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::submit_commands_and_wait;
use crate::vk::mem_util::invalidate_alloc;
use crate::vk::obj_util::{make_descriptor_buffer_info, make_descriptor_set};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::robustness::robustness_util::{
    ComputeEnvironment, DrawConfig, GraphicsEnvironment, HostBuffer, is_float_format, is_int_format, is_uint_format,
    is_value_within_buffer_or_zero, log_value, populate_buffer_with_test_values, verify_out_of_bounds_vec4,
};
use crate::vkt::tests::robustness::variable_pointers_programs::PROGRAM_TABLE;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const TEST_ARRAY_SIZE: u32 = 1024;
const NUMBER_OF_BYTES_ACCESSED: u64 = 16 * 4;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Stage {
    Vertex,
    Fragment,
    Compute,
}

impl Stage {
    fn key(self) -> &'static str {
        match self {
            Stage::Vertex => "vertex",
            Stage::Fragment => "fragment",
            Stage::Compute => "compute",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderType {
    VectorCopy,
    ScalarCopy,
}

impl ShaderType {
    fn key(self) -> &'static str {
        match self {
            ShaderType::VectorCopy => "vec4",
            ShaderType::ScalarCopy => "scalar",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BufferAccessType {
    ReadFromStorage,
    WriteToStorage,
}

fn format_is_r64(format: vk::Format) -> bool {
    matches!(format, vk::Format::R64_UINT | vk::Format::R64_SINT)
}

fn format_key(format: vk::Format) -> &'static str {
    match format {
        vk::Format::R32_SINT => "s32",
        vk::Format::R32_UINT => "u32",
        vk::Format::R32_SFLOAT => "f32",
        vk::Format::R64_SINT => "s64",
        _ => "u64",
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    shader_stage: Stage,
    shader_type: ShaderType,
    buffer_format: vk::Format,
    buffer_access_type: BufferAccessType,
    in_buffer_access_range: vk::DeviceSize,
    out_buffer_access_range: vk::DeviceSize,
    access_out_of_backing_memory: bool,
    programs: BinaryCollection,
}

/// `RobustReadTest` and `RobustWriteTest`
struct RobustAccessWithPointersTest {
    name: String,
    params: TestParams,
}

impl TestCase for RobustAccessWithPointersTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `RobustAccessWithPointersTest::checkSupport`, with what `AccessInstance`'s constructor checks
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        let mut pointer_features = vk::PhysicalDeviceVariablePointersFeatures::default();
        {
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut pointer_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };
        }
        if pointer_features.variable_pointers_storage_buffer == vk::FALSE {
            return Err(TestError::NotSupported(
                "VariablePointersStorageBuffer SPIR-V capability not supported".to_string(),
            ));
        }

        let features = context.get_device_features();
        if context.is_device_functionality_supported("VK_KHR_portability_subset")
            && features.robust_buffer_access == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "VK_KHR_portability_subset: robustBufferAccess not supported by this implementation".to_string(),
            ));
        }
        if features.robust_buffer_access == vk::FALSE {
            return Err(TestError::NotSupported(
                "robustBufferAccess not supported by this implementation".to_string(),
            ));
        }

        if format_is_r64(params.buffer_format) && features.shader_int64 == vk::FALSE {
            return Err(TestError::NotSupported("64-bit integers not supported".to_string()));
        }

        // Check storage support
        match params.shader_stage {
            Stage::Vertex if features.vertex_pipeline_stores_and_atomics == vk::FALSE => {
                return Err(TestError::NotSupported(
                    "Stores not supported in vertex stage".to_string(),
                ));
            }
            Stage::Fragment if features.fragment_stores_and_atomics == vk::FALSE => {
                return Err(TestError::NotSupported(
                    "Stores not supported in fragment stage".to_string(),
                ));
            }
            _ => {}
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.params.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(AccessInstance {
            context,
            params: self.params,
        })
    }
}

struct AccessInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl AccessInstance<'_> {
    fn is_read_access(&self) -> bool {
        self.params.buffer_access_type == BufferAccessType::ReadFromStorage
    }

    /// `isExpectedValueFromInBuffer`
    fn is_expected_value_from_in_buffer(&self, offset_in_bytes: u64, value: &[u8]) -> bool {
        debug_assert!(offset_in_bytes.is_multiple_of(4));
        debug_assert!(value.len() == 4 || value.len() == 8);

        let format = self.params.buffer_format;
        let value_index = (offset_in_bytes / 4) as u32 + 2;

        if is_uint_format(format) {
            let expected = [value_index, value_index + 1];
            let bytes: Vec<u8> = expected.iter().flat_map(|v| v.to_ne_bytes()).collect();
            value == &bytes[..value.len()]
        } else if is_int_format(format) {
            let first = -(value_index as i32);
            let expected = [first, first - 1];
            let bytes: Vec<u8> = expected.iter().flat_map(|v| v.to_ne_bytes()).collect();
            value == &bytes[..value.len()]
        } else if is_float_format(format) {
            debug_assert!(value.len() == 4);
            value == (value_index as f32).to_ne_bytes()
        } else {
            debug_assert!(false, "unexpected format");
            false
        }
    }

    /// `verifyResult`
    fn verify_result(
        &self,
        in_bytes: &[u8],
        out_bytes: &[u8],
        in_access_range: u64,
        in_alloc_size: u64,
        out_alloc_size: u64,
        max_access_range: u64,
        split_access: bool,
    ) -> bool {
        use std::fmt::Write;

        let params = &self.params;
        let format = params.buffer_format;
        let mut log_msg = String::new();
        let is_read_access = self.is_read_access();
        let mut all_ok = true;
        let mut value_ndx = 0u32;
        let is_r64 = format_is_r64(format);
        let unsplit_element_size: u64 = if is_r64 { 8 } else { 4 };
        let element_size: u64 = if is_r64 && !split_access { 8 } else { 4 };

        // `isOutBufferValueUnchanged`
        let is_out_buffer_value_unchanged = |offset_in_bytes: u64, value_size: u64| -> bool {
            let default_value = [0xBAu8; 8];
            out_bytes[offset_in_bytes as usize..(offset_in_bytes + value_size) as usize]
                == default_value[..value_size as usize]
        };

        let mut offset_in_bytes = 0u64;
        while offset_in_bytes < out_alloc_size {
            let out_value_size = element_size.min(out_alloc_size - offset_in_bytes);
            let out_value = &out_bytes[offset_in_bytes as usize..(offset_in_bytes + out_value_size) as usize];

            if offset_in_bytes >= NUMBER_OF_BYTES_ACCESSED {
                // The shader will only write 16 values into the result buffer. The rest of the values should remain unchanged or may be modified if we are
                // writing out of bounds.
                if !is_out_buffer_value_unchanged(offset_in_bytes, out_value_size)
                    && (is_read_access
                        || !is_value_within_buffer_or_zero(in_bytes, &out_value[..out_value.len().min(4)]))
                {
                    let _ = write!(
                        log_msg,
                        "\nValue {value_ndx} has been modified with an unknown value: {}",
                        u32::from_ne_bytes(out_value[..4].try_into().unwrap_or([0; 4]))
                    );
                    value_ndx += 1;
                    all_ok = false;
                }
            } else {
                let distance_to_out_of_bounds = max_access_range as i32 - offset_in_bytes as i32;
                let mut is_out_of_bounds_access = false;

                let _ = write!(log_msg, "\n{value_ndx}: ");
                value_ndx += 1;

                log_value(&mut log_msg, out_value, format, out_value_size as usize);

                if params.access_out_of_backing_memory {
                    is_out_of_bounds_access = true;
                }

                // Check if the shader operation accessed an operand located less than 16 bytes away from the out of bounds address. Less than 32 bytes away for
                // 64 bit accesses.
                if !is_out_of_bounds_access && distance_to_out_of_bounds < if is_r64 { 32 } else { 16 } {
                    let operand_size = match params.shader_type {
                        ShaderType::ScalarCopy => unsplit_element_size,
                        ShaderType::VectorCopy => unsplit_element_size * 4,
                    };

                    is_out_of_bounds_access = ((offset_in_bytes / operand_size) + 1) * operand_size > max_access_range;
                }

                if is_out_of_bounds_access {
                    let _ = write!(
                        log_msg,
                        " (out of bounds {})",
                        if is_read_access { "read" } else { "write" }
                    );

                    let is_value_partially_out_of_bounds =
                        distance_to_out_of_bounds > 0 && (distance_to_out_of_bounds as u64) < element_size;
                    #[expect(
                        unused_assignments,
                        reason = "upstream initialises it before the branches that set it"
                    )]
                    let mut is_valid_value = false;

                    if is_value_partially_out_of_bounds && !params.access_out_of_backing_memory {
                        // The value is partially out of bounds
                        let mut in_bound_part_size = distance_to_out_of_bounds as u64;

                        // For cases that partial element is out of bound, the part within the buffer allocated memory can be buffer content per spec. We need to
                        // check it as a whole part.
                        if offset_in_bytes + element_size > in_alloc_size {
                            in_bound_part_size = in_alloc_size.saturating_sub(offset_in_bytes);
                        }
                        let split_at = in_bound_part_size as usize;

                        let (is_within_bounds_part_ok, is_out_of_bounds_part_ok) = if is_read_access {
                            (
                                is_value_within_buffer_or_zero(in_bytes, &out_value[..split_at.min(out_value.len())]),
                                is_value_within_buffer_or_zero(in_bytes, &out_value[split_at.min(out_value.len())..]),
                            )
                        } else {
                            (
                                is_value_within_buffer_or_zero(in_bytes, &out_value[..split_at.min(out_value.len())])
                                    || is_out_buffer_value_unchanged(offset_in_bytes, in_bound_part_size),
                                is_value_within_buffer_or_zero(in_bytes, &out_value[split_at.min(out_value.len())..])
                                    || is_out_buffer_value_unchanged(
                                        offset_in_bytes + in_bound_part_size,
                                        out_value_size - in_bound_part_size,
                                    ),
                            )
                        };

                        let _ = write!(
                            log_msg,
                            ", first {distance_to_out_of_bounds} byte(s) {}",
                            if is_within_bounds_part_ok { "OK" } else { "wrong" }
                        );
                        let _ = write!(
                            log_msg,
                            ", last {} byte(s) {}",
                            out_value_size as i64 - i64::from(distance_to_out_of_bounds),
                            if is_out_of_bounds_part_ok { "OK" } else { "wrong" }
                        );

                        is_valid_value = is_within_bounds_part_ok && is_out_of_bounds_part_ok;
                    } else if is_read_access {
                        is_valid_value = is_value_within_buffer_or_zero(in_bytes, out_value);
                    } else {
                        is_valid_value = is_out_buffer_value_unchanged(offset_in_bytes, out_value_size);

                        if !is_valid_value {
                            // Out of bounds writes may modify values within the memory ranges bound to the buffer
                            is_valid_value = is_value_within_buffer_or_zero(in_bytes, out_value);

                            if is_valid_value {
                                log_msg.push_str(", OK, written within the memory range bound to the buffer");
                            }
                        }
                    }

                    if !is_valid_value && !split_access {
                        // Check if we are satisfying the [0, 0, 0, x] pattern, where x may be either 0 or 1, or the maximum representable positive integer value
                        // (if the format is integer-based).
                        let can_match_vec4_pattern = is_read_access
                            && !is_value_partially_out_of_bounds
                            && params.shader_type == ShaderType::VectorCopy
                            && (offset_in_bytes / element_size + 1).is_multiple_of(4);
                        let mut matches_vec4_pattern = false;

                        if can_match_vec4_pattern {
                            let start = (offset_in_bytes - 3 * element_size) as usize;
                            matches_vec4_pattern = verify_out_of_bounds_vec4(&out_bytes[start..], format);
                        }

                        if !can_match_vec4_pattern || !matches_vec4_pattern {
                            log_msg.push_str(". Failed: ");

                            if is_read_access {
                                log_msg.push_str("expected value within the buffer range or 0");

                                if can_match_vec4_pattern {
                                    log_msg.push_str(", or the [0, 0, 0, x] pattern");
                                }
                            } else {
                                log_msg.push_str("written out of the range");
                            }

                            all_ok = false;
                        }
                    }
                } else if is_read_access {
                    // We are within bounds
                    if !self.is_expected_value_from_in_buffer(offset_in_bytes, &out_value[..element_size as usize]) {
                        log_msg.push_str(", Failed: unexpected value");
                        all_ok = false;
                    }
                } else {
                    // Out of bounds writes may change values within the bounds.
                    let in_range = &in_bytes[..in_access_range.min(in_bytes.len() as u64) as usize];
                    if !is_value_within_buffer_or_zero(in_range, &out_value[..element_size as usize]) {
                        log_msg.push_str(", Failed: unexpected value");
                        all_ok = false;
                    }
                }
            }

            offset_in_bytes += element_size;
        }

        log::info!("{log_msg}");

        if !all_ok && unsplit_element_size > 4 && !split_access {
            // "Non-atomic accesses to storage buffers that are a multiple of 32 bits may be decomposed into 32-bit accesses that are individually bounds-checked."
            return self.verify_result(
                in_bytes,
                out_bytes,
                in_access_range,
                in_alloc_size,
                out_alloc_size,
                max_access_range,
                true,
            );
        }

        all_ok
    }
}

impl TestInstance for AccessInstance<'_> {
    /// `AccessInstance`'s constructor and `iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();

        debug_assert!(NUMBER_OF_BYTES_ACCESSED.is_multiple_of(4));
        debug_assert!(params.in_buffer_access_range <= NUMBER_OF_BYTES_ACCESSED);
        debug_assert!(params.out_buffer_access_range <= NUMBER_OF_BYTES_ACCESSED);

        // Create the buffers: the input one filled with test values, the output one with the 0xBA filler, and the indices
        let in_buffer = HostBuffer::new(
            context,
            params.in_buffer_access_range,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        )?;
        in_buffer.with_bytes_mut(|bytes| populate_buffer_with_test_values(bytes, params.buffer_format));
        in_buffer.flush(device)?;
        let in_max_access_range = in_buffer
            .alloc_size
            .min(in_buffer.size.min(params.in_buffer_access_range));

        let out_buffer = HostBuffer::new(
            context,
            params.out_buffer_access_range,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        )?;
        out_buffer.with_bytes_mut(|bytes| bytes.fill(0xBA));
        out_buffer.flush(device)?;
        let out_max_access_range = out_buffer
            .alloc_size
            .min(out_buffer.size.min(params.out_buffer_access_range));

        let read_index =
            if params.access_out_of_backing_memory && params.buffer_access_type == BufferAccessType::ReadFromStorage {
                TEST_ARRAY_SIZE as i32 - 1
            } else {
                0
            };
        let write_index =
            if params.access_out_of_backing_memory && params.buffer_access_type == BufferAccessType::WriteToStorage {
                TEST_ARRAY_SIZE as i32 - 1
            } else {
                0
            };
        let indices = [read_index, write_index, 0i32];
        let indices_buffer = HostBuffer::new(context, 3 * 4, vk::BufferUsageFlags::UNIFORM_BUFFER)?;
        indices_buffer.with_bytes_mut(|bytes| {
            for (ndx, index) in indices.iter().enumerate() {
                bytes[ndx * 4..ndx * 4 + 4].copy_from_slice(&index.to_ne_bytes());
            }
        });
        indices_buffer.flush(device)?;

        log::info!("input  buffer - alloc size: {}", in_buffer.alloc_size);
        log::info!("input  buffer - max access range: {in_max_access_range}");
        log::info!("output buffer - alloc size: {}", out_buffer.alloc_size);
        log::info!("output buffer - max access range: {out_max_access_range}");
        log::info!("indices - input offset: {}", indices[0]);
        log::info!("indices - output offset: {}", indices[1]);
        log::info!("indices - additional: {}", indices[2]);

        // Create descriptor data
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL)
            .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::ALL)
            .build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        {
            let in_info = [make_descriptor_buffer_info(
                in_buffer.get(),
                0,
                params.in_buffer_access_range,
            )];
            let out_info = [make_descriptor_buffer_info(
                out_buffer.get(),
                0,
                params.out_buffer_access_range,
            )];
            let indices_info = [make_descriptor_buffer_info(indices_buffer.get(), 0, 12)];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&in_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                    .buffer_info(&out_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(2)
                    .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                    .buffer_info(&indices_info)
                    .build(),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        let compute_environment;
        let graphics_environment;
        let vertex_buffer;
        let cmd_buffer = if params.shader_stage == Stage::Compute {
            compute_environment = ComputeEnvironment::new(context, *descriptor_set_layout, *descriptor_set, false)?;
            compute_environment.get_command_buffer()
        } else {
            let vertex_input_binding_description = vk::VertexInputBindingDescription {
                binding: 0,
                stride: 16,
                input_rate: vk::VertexInputRate::VERTEX,
            };
            let vertex_input_attribute_description = vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            };

            let vertices: [[f32; 4]; 3] = [[-1.0, -1.0, 0.0, 1.0], [-1.0, 1.0, 0.0, 1.0], [1.0, -1.0, 0.0, 1.0]];
            vertex_buffer = HostBuffer::new(
                context,
                std::mem::size_of_val(&vertices) as u64,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    vertex_buffer.buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of_val(&vertices),
                )
            };
            vertex_buffer.flush(device)?;

            let draw_with_one_vertex_buffer = DrawConfig {
                vertex_buffers: vec![vertex_buffer.get()],
                vertex_count: vertices.len() as u32,
                instance_count: 1,
                index_buffer: vk::Buffer::null(),
                index_count: 0,
            };

            graphics_environment = GraphicsEnvironment::new(
                context,
                *descriptor_set_layout,
                *descriptor_set,
                &[vertex_input_binding_description],
                &[vertex_input_attribute_description],
                &draw_with_one_vertex_buffer,
                false,
            )?;
            graphics_environment.get_command_buffer()
        };

        // Submit command buffer
        submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;

        // Prepare result buffer for read
        invalidate_alloc(device, out_buffer.buffer.get_allocation())?;

        let max_access_range = if self.is_read_access() {
            in_max_access_range
        } else {
            out_max_access_range
        };
        if self.verify_result(
            in_buffer.bytes(),
            out_buffer.bytes(),
            params.in_buffer_access_range,
            in_buffer.alloc_size,
            out_buffer.alloc_size,
            max_access_range,
            false,
        ) {
            Ok(TestStatus::pass("All values OK"))
        } else {
            Ok(TestStatus::fail("Invalid value(s) found"))
        }
    }
}

fn programs_for(stage: Stage, shader_type: ShaderType, format: vk::Format, reads: bool) -> BinaryCollection {
    let key = format!(
        "{}.{}.{}.{}",
        stage.key(),
        shader_type.key(),
        format_key(format),
        if reads { 'r' } else { 'w' }
    );
    let index = PROGRAM_TABLE
        .binary_search_by(|(k, _)| (*k).cmp(key.as_str()))
        .expect("every case has programs");
    PROGRAM_TABLE[index].1.programs
}

/// `createBufferAccessWithVariablePointersTests` (`through_pointers`)
pub fn create_buffer_access_with_variable_pointers_tests() -> TestCaseGroup {
    let mut buffer_access_with_variable_pointers_tests = TestCaseGroup::new("through_pointers");

    let buffer_formats = [
        (vk::Format::R32_SINT, "s32"),
        (vk::Format::R32_UINT, "u32"),
        (vk::Format::R32_SFLOAT, "f32"),
        (vk::Format::R64_SINT, "s64"),
        (vk::Format::R64_UINT, "u64"),
    ];
    // Amounts of data to copy
    let range_sizes: [vk::DeviceSize; 5] = [1, 3, 4, 16, 32];
    let types = [(ShaderType::VectorCopy, "vec4"), (ShaderType::ScalarCopy, "scalar")];
    // Eventually specify if memory used should be in the "inaccesible" portion of buffer or entirely outside of buffer
    let backing_memory = ["in_memory", "out_of_memory"];

    let mut compute_with_variable_pointers_tests = TestCaseGroup::new("compute");
    let mut graphics_with_variable_pointers_tests = TestCaseGroup::new("graphics");

    let make_cases = |stage: Stage, is_read: bool| -> Vec<Box<dyn TestCase>> {
        let mut cases: Vec<Box<dyn TestCase>> = Vec::new();
        for &(shader_type, type_name) in &types {
            for &(format, format_name) in &buffer_formats {
                for &range in &range_sizes {
                    for (s, memory_name) in backing_memory.iter().enumerate() {
                        let name = format!("{range}B_{memory_name}_with_{type_name}_{format_name}");
                        let (access_type, in_range, out_range) = if is_read {
                            (BufferAccessType::ReadFromStorage, range, NUMBER_OF_BYTES_ACCESSED)
                        } else {
                            (BufferAccessType::WriteToStorage, NUMBER_OF_BYTES_ACCESSED, range)
                        };
                        let params = TestParams {
                            shader_stage: stage,
                            shader_type,
                            buffer_format: format,
                            buffer_access_type: access_type,
                            in_buffer_access_range: in_range,
                            out_buffer_access_range: out_range,
                            access_out_of_backing_memory: s != 0,
                            programs: programs_for(stage, shader_type, format, is_read),
                        };
                        cases.push(Box::new(RobustAccessWithPointersTest { name, params }));
                    }
                }
            }
        }
        cases
    };

    for is_read in [true, false] {
        let access_name = if is_read { "reads" } else { "writes" };
        let mut compute_group = TestCaseGroup::new(access_name);
        let mut graphics_group = TestCaseGroup::new(access_name);

        for (stage, stage_name) in [(Stage::Vertex, "vertex"), (Stage::Fragment, "fragment")] {
            let mut stage_group = TestCaseGroup::new(stage_name);
            for case in make_cases(stage, is_read) {
                stage_group.add_child(case);
            }
            graphics_group.add_child(stage_group);
        }
        for case in make_cases(Stage::Compute, is_read) {
            compute_group.add_child(case);
        }
        graphics_with_variable_pointers_tests.add_child(graphics_group);
        compute_with_variable_pointers_tests.add_child(compute_group);
    }

    buffer_access_with_variable_pointers_tests.add_child(graphics_with_variable_pointers_tests);
    buffer_access_with_variable_pointers_tests.add_child(compute_with_variable_pointers_tests);
    buffer_access_with_variable_pointers_tests
}
