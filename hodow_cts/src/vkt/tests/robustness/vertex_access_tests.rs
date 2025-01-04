// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustnessVertexAccessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 Imagination Technologies Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The vertex shader depends on the format, the vertex and the instance count,
// so shaders/manifest/robustness_vertex_access.toml holds one program per format and draw shape. The device is the Context's
// own (see robustness_util.rs), so the checks upstream makes in the instance constructor (vertex stores, 64-bit formats) run
// in `checkSupport`, and the environment is built when the instance runs because `createInstance` cannot fail here.
//
// Draws with vertex buffers smaller than the draw reads (vertex rate, instance rate and index out of bounds) while the
// vertex shader copies every attribute into a storage buffer, and checks each copied value is either the right one or, out
// of bounds, a value from the buffer's memory or zero.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::robustness_vertex_access::*;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::submit_commands_and_wait;
use crate::vk::mem_util::invalidate_alloc;
use crate::vk::obj_util::{make_descriptor_buffer_info, make_descriptor_set};
use crate::vk::programs::BinaryCollection;
pub use crate::vk::programs::SharedProgram;
use crate::vkt::tests::robustness::robustness_util::{
    DrawConfig, GraphicsEnvironment, HostBuffer, are_equal, is_float_format, is_int_format, is_uint_format,
    is_value_within_buffer_or_zero, log_value, num_used_channels, pixel_size, populate_buffer_with_test_values,
    verify_out_of_bounds_vec4,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const INDEX_CONFIGS: [&[u32]; 3] = [
    // Indices of 100 and above are out of bounds
    &[0, 1, 2, 3, 4, 100],
    &[0, 100, 2, 101, 3, 102],
    &[100, 101, 102, 3, 4, 5],
];

#[allow(non_camel_case_types)]
#[derive(Clone, Copy)]
enum Shader {
    VERTEX_OUT_OF_BOUNDS,
    VERTEX_INCOMPLETE,
    INSTANCE_OUT_OF_BOUNDS,
    INDEXED,
}

fn programs_for(format: vk::Format, shader: Shader) -> BinaryCollection {
    match (format, shader) {
        (vk::Format::R32_UINT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R32_UINT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R32_UINT, Shader::VERTEX_INCOMPLETE) => VA_R32_UINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32_UINT, Shader::INSTANCE_OUT_OF_BOUNDS) => VA_R32_UINT_INSTANCE_OUT_OF_BOUNDS.programs,
        (vk::Format::R32_UINT, Shader::INDEXED) => VA_R32_UINT_INDEXED.programs,
        (vk::Format::R32_SINT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R32_SINT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R32_SINT, Shader::VERTEX_INCOMPLETE) => VA_R32_SINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32_SINT, Shader::INSTANCE_OUT_OF_BOUNDS) => VA_R32_SINT_INSTANCE_OUT_OF_BOUNDS.programs,
        (vk::Format::R32_SINT, Shader::INDEXED) => VA_R32_SINT_INDEXED.programs,
        (vk::Format::R32_SFLOAT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R32_SFLOAT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R32_SFLOAT, Shader::VERTEX_INCOMPLETE) => VA_R32_SFLOAT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32_SFLOAT, Shader::INSTANCE_OUT_OF_BOUNDS) => VA_R32_SFLOAT_INSTANCE_OUT_OF_BOUNDS.programs,
        (vk::Format::R32_SFLOAT, Shader::INDEXED) => VA_R32_SFLOAT_INDEXED.programs,
        (vk::Format::R32G32_UINT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R32G32_UINT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R32G32_UINT, Shader::VERTEX_INCOMPLETE) => VA_R32G32_UINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32G32_UINT, Shader::INSTANCE_OUT_OF_BOUNDS) => VA_R32G32_UINT_INSTANCE_OUT_OF_BOUNDS.programs,
        (vk::Format::R32G32_UINT, Shader::INDEXED) => VA_R32G32_UINT_INDEXED.programs,
        (vk::Format::R32G32_SINT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R32G32_SINT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R32G32_SINT, Shader::VERTEX_INCOMPLETE) => VA_R32G32_SINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32G32_SINT, Shader::INSTANCE_OUT_OF_BOUNDS) => VA_R32G32_SINT_INSTANCE_OUT_OF_BOUNDS.programs,
        (vk::Format::R32G32_SINT, Shader::INDEXED) => VA_R32G32_SINT_INDEXED.programs,
        (vk::Format::R32G32_SFLOAT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R32G32_SFLOAT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R32G32_SFLOAT, Shader::VERTEX_INCOMPLETE) => VA_R32G32_SFLOAT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32G32_SFLOAT, Shader::INSTANCE_OUT_OF_BOUNDS) => VA_R32G32_SFLOAT_INSTANCE_OUT_OF_BOUNDS.programs,
        (vk::Format::R32G32_SFLOAT, Shader::INDEXED) => VA_R32G32_SFLOAT_INDEXED.programs,
        (vk::Format::R32G32B32_UINT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R32G32B32_UINT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R32G32B32_UINT, Shader::VERTEX_INCOMPLETE) => VA_R32G32B32_UINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32G32B32_UINT, Shader::INSTANCE_OUT_OF_BOUNDS) => {
            VA_R32G32B32_UINT_INSTANCE_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32_UINT, Shader::INDEXED) => VA_R32G32B32_UINT_INDEXED.programs,
        (vk::Format::R32G32B32_SINT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R32G32B32_SINT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R32G32B32_SINT, Shader::VERTEX_INCOMPLETE) => VA_R32G32B32_SINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32G32B32_SINT, Shader::INSTANCE_OUT_OF_BOUNDS) => {
            VA_R32G32B32_SINT_INSTANCE_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32_SINT, Shader::INDEXED) => VA_R32G32B32_SINT_INDEXED.programs,
        (vk::Format::R32G32B32_SFLOAT, Shader::VERTEX_OUT_OF_BOUNDS) => {
            VA_R32G32B32_SFLOAT_VERTEX_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32_SFLOAT, Shader::VERTEX_INCOMPLETE) => VA_R32G32B32_SFLOAT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32G32B32_SFLOAT, Shader::INSTANCE_OUT_OF_BOUNDS) => {
            VA_R32G32B32_SFLOAT_INSTANCE_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32_SFLOAT, Shader::INDEXED) => VA_R32G32B32_SFLOAT_INDEXED.programs,
        (vk::Format::R32G32B32A32_UINT, Shader::VERTEX_OUT_OF_BOUNDS) => {
            VA_R32G32B32A32_UINT_VERTEX_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32A32_UINT, Shader::VERTEX_INCOMPLETE) => VA_R32G32B32A32_UINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32G32B32A32_UINT, Shader::INSTANCE_OUT_OF_BOUNDS) => {
            VA_R32G32B32A32_UINT_INSTANCE_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32A32_UINT, Shader::INDEXED) => VA_R32G32B32A32_UINT_INDEXED.programs,
        (vk::Format::R32G32B32A32_SINT, Shader::VERTEX_OUT_OF_BOUNDS) => {
            VA_R32G32B32A32_SINT_VERTEX_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32A32_SINT, Shader::VERTEX_INCOMPLETE) => VA_R32G32B32A32_SINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R32G32B32A32_SINT, Shader::INSTANCE_OUT_OF_BOUNDS) => {
            VA_R32G32B32A32_SINT_INSTANCE_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32A32_SINT, Shader::INDEXED) => VA_R32G32B32A32_SINT_INDEXED.programs,
        (vk::Format::R32G32B32A32_SFLOAT, Shader::VERTEX_OUT_OF_BOUNDS) => {
            VA_R32G32B32A32_SFLOAT_VERTEX_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32A32_SFLOAT, Shader::VERTEX_INCOMPLETE) => {
            VA_R32G32B32A32_SFLOAT_VERTEX_INCOMPLETE.programs
        }
        (vk::Format::R32G32B32A32_SFLOAT, Shader::INSTANCE_OUT_OF_BOUNDS) => {
            VA_R32G32B32A32_SFLOAT_INSTANCE_OUT_OF_BOUNDS.programs
        }
        (vk::Format::R32G32B32A32_SFLOAT, Shader::INDEXED) => VA_R32G32B32A32_SFLOAT_INDEXED.programs,
        (vk::Format::R64_UINT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R64_UINT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R64_UINT, Shader::VERTEX_INCOMPLETE) => VA_R64_UINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R64_UINT, Shader::INSTANCE_OUT_OF_BOUNDS) => VA_R64_UINT_INSTANCE_OUT_OF_BOUNDS.programs,
        (vk::Format::R64_UINT, Shader::INDEXED) => VA_R64_UINT_INDEXED.programs,
        (vk::Format::R64_SINT, Shader::VERTEX_OUT_OF_BOUNDS) => VA_R64_SINT_VERTEX_OUT_OF_BOUNDS.programs,
        (vk::Format::R64_SINT, Shader::VERTEX_INCOMPLETE) => VA_R64_SINT_VERTEX_INCOMPLETE.programs,
        (vk::Format::R64_SINT, Shader::INSTANCE_OUT_OF_BOUNDS) => VA_R64_SINT_INSTANCE_OUT_OF_BOUNDS.programs,
        (vk::Format::R64_SINT, Shader::INDEXED) => VA_R64_SINT_INDEXED.programs,
        (vk::Format::A2B10G10R10_UNORM_PACK32, Shader::VERTEX_OUT_OF_BOUNDS) => {
            VA_A2B10G10R10_UNORM_PACK32_VERTEX_OUT_OF_BOUNDS.programs
        }
        (vk::Format::A2B10G10R10_UNORM_PACK32, Shader::VERTEX_INCOMPLETE) => {
            VA_A2B10G10R10_UNORM_PACK32_VERTEX_INCOMPLETE.programs
        }
        (vk::Format::A2B10G10R10_UNORM_PACK32, Shader::INSTANCE_OUT_OF_BOUNDS) => {
            VA_A2B10G10R10_UNORM_PACK32_INSTANCE_OUT_OF_BOUNDS.programs
        }
        (vk::Format::A2B10G10R10_UNORM_PACK32, Shader::INDEXED) => VA_A2B10G10R10_UNORM_PACK32_INDEXED.programs,
        _ => unreachable!("no vertex access program for this format"),
    }
}

fn is_r64(format: vk::Format) -> bool {
    format == vk::Format::R64_UINT || format == vk::Format::R64_SINT
}

/// `VertexAccessInstance::getBufferSizeInBytes`
fn get_buffer_size_in_bytes(num_scalars: u32, format: vk::Format) -> vk::DeviceSize {
    if is_uint_format(format) || is_int_format(format) || is_float_format(format) {
        vk::DeviceSize::from(num_scalars) * if is_r64(format) { 8 } else { 4 }
    } else {
        debug_assert!(format == vk::Format::A2B10G10R10_UNORM_PACK32 && num_scalars.is_multiple_of(4));
        vk::DeviceSize::from(num_scalars)
    }
}

fn read_u32(bytes: &[u8], index: usize) -> Option<u32> {
    bytes
        .get(index * 4..index * 4 + 4)
        .map(|b| u32::from_ne_bytes(b.try_into().expect("four bytes")))
}

fn read_u64(bytes: &[u8], index: usize) -> Option<u64> {
    bytes
        .get(index * 8..index * 8 + 8)
        .map(|b| u64::from_ne_bytes(b.try_into().expect("eight bytes")))
}

/// `VertexAccessInstance::isExpectedValueFromVertexBuffer`
fn is_expected_value_from_vertex_buffer(
    vertex_buffer: &[u8],
    vertex_index: u32,
    vertex_format: vk::Format,
    value: &[u8],
) -> bool {
    let index = vertex_index as usize;

    if is_uint_format(vertex_format) || is_int_format(vertex_format) {
        if is_r64(vertex_format) {
            return read_u64(vertex_buffer, index).is_some_and(|expected| Some(expected) == read_u64(value, 0));
        }
        return read_u32(vertex_buffer, index).is_some_and(|expected| Some(expected) == read_u32(value, 0));
    } else if is_float_format(vertex_format) {
        let expected = read_u32(vertex_buffer, index).map(f32::from_bits);
        let actual = read_u32(value, 0).map(f32::from_bits);
        return matches!((expected, actual), (Some(expected), Some(actual)) if are_equal(expected, actual));
    } else if vertex_format == vk::Format::A2B10G10R10_UNORM_PACK32 {
        let Some(packed_value) = read_u32(vertex_buffer, index / 4) else {
            return false;
        };
        let scalar_index = index % 4;
        let norm_value = if scalar_index < 3 {
            ((packed_value >> (10 * scalar_index)) & 0x3FF) as f32 / 0x3FF as f32
        } else {
            (packed_value >> 30) as f32 / 0x3 as f32
        };
        return read_u32(value, 0)
            .map(f32::from_bits)
            .is_some_and(|actual| are_equal(norm_value, actual));
    }

    debug_assert!(false, "unexpected format");
    false
}

#[derive(Clone, Copy)]
struct TestParams {
    input_format: vk::Format,
    num_vertex_values: u32,
    num_instance_values: u32,
    num_vertices: u32,
    num_instances: u32,
    /// Empty for a plain draw.
    indices: &'static [u32],
    programs: BinaryCollection,
}

/// `DrawAccessTest` and `DrawIndexedAccessTest`
struct VertexAccessTest {
    name: String,
    params: TestParams,
}

impl TestCase for VertexAccessTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkSupport`, with what upstream's `VertexAccessInstance` constructor checks.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let format = self.params.input_format;

        if context.get_device_features().robust_buffer_access == vk::FALSE {
            return Err(TestError::NotSupported(
                "robustBufferAccess not supported by this implementation".to_string(),
            ));
        }

        // Check storage support
        if context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Stores not supported in vertex stage".to_string(),
            ));
        }

        if is_r64(format) {
            let format_properties = unsafe {
                context
                    .get_instance()
                    .get_physical_device_format_properties(context.get_physical_device(), format)
            };
            context.require_device_functionality("VK_EXT_shader_image_atomic_int64")?;

            if !format_properties
                .optimal_tiling_features
                .contains(vk::FormatFeatureFlags::VERTEX_BUFFER)
            {
                return Err(TestError::NotSupported(
                    "VK_FORMAT_FEATURE_VERTEX_BUFFER_BIT not supported".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.params.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(VertexAccessInstance {
            context,
            params: self.params,
        })
    }
}

struct VertexAccessInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl VertexAccessInstance<'_> {
    fn get_index(&self, vertex_num: u32) -> u32 {
        if self.params.indices.is_empty() {
            vertex_num
        } else {
            debug_assert!((vertex_num as usize) < self.params.indices.len());
            self.params.indices[vertex_num as usize]
        }
    }

    fn init_vertex_ids(&self, indices: &mut [u32]) {
        if self.params.indices.is_empty() {
            for (i, index) in indices.iter_mut().enumerate() {
                *index = i as u32;
            }
        } else {
            for (i, &index) in self.params.indices.iter().enumerate() {
                debug_assert!((index as usize) < indices.len());
                indices[index as usize] = i as u32;
            }
        }
    }

    /// `VertexAccessInstance::isValueWithinVertexBufferOrZero`
    fn is_value_within_vertex_buffer_or_zero(&self, vertex_buffer: &[u8], value: &[u8], value_index: u32) -> bool {
        if self.params.input_format == vk::Format::A2B10G10R10_UNORM_PACK32 {
            let norm_value = f32::from_bits(read_u32(value, 0).unwrap_or(0));
            let scalar_index = value_index % 4;
            let is_alpha = scalar_index == 3;

            let encoded_value = if is_alpha {
                ((norm_value * 3.0 + 0.5).floor() as u32).min(0x3)
            } else {
                ((norm_value * 1023.0 + 0.5).floor() as u32).min(0x3FF)
            };

            if encoded_value == 0 {
                return true;
            }

            for i in 0..vertex_buffer.len() / 4 {
                let packed_value = read_u32(vertex_buffer, i).unwrap_or(0);
                let unpacked_value = if scalar_index < 3 {
                    (packed_value >> (10 * scalar_index)) & 0x3FF
                } else {
                    (packed_value >> 30) & 0x3
                };

                if unpacked_value == encoded_value {
                    return true;
                }
            }

            false
        } else {
            is_value_within_buffer_or_zero(vertex_buffer, &value[..4])
        }
    }
}

impl TestInstance for VertexAccessInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let format = params.input_format;
        let format_size_in_bytes = pixel_size(format);

        let attributes = [
            // input rate: vertex
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format,
                offset: format_size_in_bytes,
            },
            // input rate: instance
            vk::VertexInputAttributeDescription {
                location: 2,
                binding: 1,
                format,
                offset: 0,
            },
            // Attribute for vertex number
            vk::VertexInputAttributeDescription {
                location: 3,
                binding: 2,
                format: vk::Format::R32_SINT,
                offset: 0,
            },
        ];

        let bindings = [
            vk::VertexInputBindingDescription {
                binding: 0,
                stride: format_size_in_bytes * 2,
                input_rate: vk::VertexInputRate::VERTEX,
            },
            vk::VertexInputBindingDescription {
                binding: 1,
                stride: format_size_in_bytes,
                input_rate: vk::VertexInputRate::INSTANCE,
            },
            vk::VertexInputBindingDescription {
                binding: 2,
                stride: std::mem::size_of::<i32>() as u32,
                input_rate: vk::VertexInputRate::VERTEX,
            },
        ];

        // Create vertex buffer for vertex input rate. All formats used in this test suite are 32-bit based.
        let vertex_rate_buffer = HostBuffer::new(
            context,
            get_buffer_size_in_bytes(params.num_vertex_values, format),
            vk::BufferUsageFlags::VERTEX_BUFFER,
        )?;
        vertex_rate_buffer.with_bytes_mut(|bytes| populate_buffer_with_test_values(bytes, format));
        vertex_rate_buffer.flush(device)?;

        // Create vertex buffer for instance input rate
        let instance_rate_buffer = HostBuffer::new(
            context,
            get_buffer_size_in_bytes(params.num_instance_values, format),
            vk::BufferUsageFlags::VERTEX_BUFFER,
        )?;
        instance_rate_buffer.with_bytes_mut(|bytes| populate_buffer_with_test_values(bytes, format));
        instance_rate_buffer.flush(device)?;

        // Create vertex buffer that stores the vertex number (from 0 to m_numVertices - 1). Enough device memory for all
        // indices (0 to 127).
        let vertex_num_buffer = HostBuffer::new(
            context,
            128 * std::mem::size_of::<i32>() as vk::DeviceSize,
            vk::BufferUsageFlags::VERTEX_BUFFER,
        )?;

        // Create index buffer if required
        let index_buffer = if params.indices.is_empty() {
            None
        } else {
            let buffer = HostBuffer::new(
                context,
                std::mem::size_of_val(params.indices) as vk::DeviceSize,
                vk::BufferUsageFlags::INDEX_BUFFER,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    params.indices.as_ptr().cast::<u8>(),
                    buffer.buffer.get_allocation().get_host_ptr(),
                    buffer.size as usize,
                )
            };
            buffer.flush(device)?;
            Some(buffer)
        };

        // Create result ssbo
        let num_channels = num_used_channels(format);
        let out_buffer = HostBuffer::new(
            context,
            get_buffer_size_in_bytes(
                params.num_vertices * params.num_instances * num_channels * 3,
                vk::Format::R32_UINT,
            ),
            vk::BufferUsageFlags::STORAGE_BUFFER,
        )?;
        out_buffer.with_bytes_mut(|bytes| bytes[..out_buffer.size as usize].fill(0xFF));
        out_buffer.flush(device)?;

        // Create descriptor set data
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::VERTEX)
            .build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let out_buffer_descriptor_info = [make_descriptor_buffer_info(out_buffer.buffer.get(), 0, vk::WHOLE_SIZE)];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&out_buffer_descriptor_info)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // Setup graphics test environment
        let draw_config = DrawConfig {
            vertex_buffers: vec![
                vertex_rate_buffer.buffer.get(),
                instance_rate_buffer.buffer.get(),
                vertex_num_buffer.buffer.get(),
            ],
            vertex_count: params.num_vertices,
            instance_count: params.num_instances,
            index_buffer: index_buffer
                .as_ref()
                .map_or(vk::Buffer::null(), |buffer| buffer.buffer.get()),
            index_count: params.indices.len() as u32,
        };
        let graphics_test_environment = GraphicsEnvironment::new(
            context,
            *descriptor_set_layout,
            *descriptor_set,
            &bindings,
            &attributes,
            &draw_config,
            false,
        )?;

        // Initialize vertex ids
        {
            let mut ids: Vec<u32> = vec![0; vertex_num_buffer.size as usize / 4];
            self.init_vertex_ids(&mut ids);
            vertex_num_buffer.with_bytes_mut(|bytes| {
                bytes[..ids.len() * 4].fill(0);
                for (i, id) in ids.iter().enumerate() {
                    bytes[i * 4..i * 4 + 4].copy_from_slice(&id.to_ne_bytes());
                }
            });
            vertex_num_buffer.flush(device)?;
        }

        // Submit command buffer
        submit_commands_and_wait(
            device,
            context.get_universal_queue(),
            graphics_test_environment.get_command_buffer(),
        )?;

        // Prepare result buffer for read
        invalidate_alloc(device, out_buffer.buffer.get_allocation())?;

        if self.verify_result(&vertex_rate_buffer, &instance_rate_buffer, &out_buffer) {
            Ok(TestStatus::pass("All values OK"))
        } else {
            Ok(TestStatus::fail("Invalid value(s) found"))
        }
    }
}

impl VertexAccessInstance<'_> {
    /// `VertexAccessInstance::verifyResult`
    fn verify_result(
        &self,
        vertex_rate_buffer: &HostBuffer<'_>,
        instance_rate_buffer: &HostBuffer<'_>,
        out_buffer: &HostBuffer<'_>,
    ) -> bool {
        let params = &self.params;
        let format = params.input_format;
        let mut log_msg = String::new();
        let num_channels = num_used_channels(format);
        let num_scalars_per_vertex = num_channels * 3; // Use 3 identical attributes
        let out_data = out_buffer.bytes();
        let out_value_size: u32 = if is_r64(format) { 8 } else { 4 };
        let mut all_ok = true;

        for value_ndx in 0..(out_buffer.size as u32 / out_value_size) {
            let num_in_buffer_values;
            let in_buffer_bytes;
            let in_buffer_value_index;
            let attribute_index = (value_ndx / num_channels) % 3;
            let out_value_offset = (value_ndx * out_value_size) as usize;
            let out_value = &out_data[out_value_offset..out_value_offset + out_value_size as usize];

            if attribute_index == 2 {
                // Instance rate
                let element_index = value_ndx / (num_scalars_per_vertex * params.num_vertices); // instance id

                num_in_buffer_values = params.num_instance_values;
                in_buffer_bytes = instance_rate_buffer.bytes();
                in_buffer_value_index = (element_index * num_channels)
                    .wrapping_add(value_ndx % num_scalars_per_vertex)
                    .wrapping_sub(2 * num_channels);
            } else {
                // Vertex rate
                let vertex_ndx = value_ndx / num_scalars_per_vertex;
                let instance_ndx = vertex_ndx / params.num_vertices;
                let element_index = value_ndx / num_scalars_per_vertex; // vertex id

                let mut values = params.num_vertex_values;
                in_buffer_bytes = vertex_rate_buffer.bytes();
                in_buffer_value_index = (self.get_index(element_index) * (num_channels * 2))
                    .wrapping_add(value_ndx % num_scalars_per_vertex)
                    .wrapping_sub(instance_ndx * (params.num_vertices * num_channels * 2));

                // Binding 0 contains two attributes, so bounds checking for attribute 0 must also consider attribute 1 to
                // determine if the binding is out of bounds.
                if attribute_index == 0 && values >= num_channels {
                    values -= num_channels;
                }
                num_in_buffer_values = values;
            }

            let mut is_out_of_bounds_access = in_buffer_value_index >= num_in_buffer_values;

            let distance_to_out_of_bounds = (out_value_size as i32)
                .wrapping_mul((num_in_buffer_values as i32).wrapping_sub(in_buffer_value_index as i32));

            if !is_out_of_bounds_access && distance_to_out_of_bounds < 16 {
                is_out_of_bounds_access =
                    ((in_buffer_value_index / num_channels) + 1) * num_channels > num_in_buffer_values;
            }

            // Log value information
            {
                use std::fmt::Write;

                // Vertex separator
                if value_ndx != 0 && value_ndx % num_scalars_per_vertex == 0 {
                    log_msg.push('\n');
                }

                let _ = write!(log_msg, "\n{value_ndx}: Value ");

                // Result index and value
                if format == vk::Format::A2B10G10R10_UNORM_PACK32 {
                    log_value(&mut log_msg, out_value, vk::Format::R32_SFLOAT, 4);
                } else {
                    log_value(&mut log_msg, out_value, format, 4);
                }

                // Attribute name
                let _ = write!(log_msg, "\tfrom attr{attribute_index}");
                if num_channels > 1 {
                    let _ = write!(log_msg, "[{}]", value_ndx % num_channels);
                }

                // Input rate
                log_msg.push_str(if attribute_index == 2 {
                    "\tinstance rate"
                } else {
                    "\tvertex rate"
                });
            }

            if is_out_of_bounds_access {
                let is_valid_value =
                    self.is_value_within_vertex_buffer_or_zero(in_buffer_bytes, out_value, in_buffer_value_index);

                log_msg.push_str("\t(out of bounds)");

                if !is_valid_value {
                    // Check if we are satisfying the [0, 0, 0, x] pattern, where x may be either 0 or 1, or the maximum
                    // representable positive integer value (if the format is integer-based).
                    let can_match_vec4_pattern =
                        value_ndx % num_channels == 3 || format == vk::Format::A2B10G10R10_UNORM_PACK32;
                    let mut matches_vec4_pattern = false;

                    if can_match_vec4_pattern {
                        if format == vk::Format::A2B10G10R10_UNORM_PACK32 {
                            matches_vec4_pattern = verify_out_of_bounds_vec4(out_value, format);
                        } else {
                            let start = (value_ndx as usize - 3) * 4;
                            matches_vec4_pattern = verify_out_of_bounds_vec4(&out_data[start..start + 16], format);
                        }
                    }

                    if !can_match_vec4_pattern || !matches_vec4_pattern {
                        log_msg.push_str(", Failed: expected a value within the buffer range or 0");

                        if can_match_vec4_pattern {
                            log_msg.push_str(", or the [0, 0, 0, x] pattern");
                        }

                        all_ok = false;
                    }
                }
            } else if !is_expected_value_from_vertex_buffer(in_buffer_bytes, in_buffer_value_index, format, out_value) {
                log_msg.push_str(", Failed: unexpected value");
                all_ok = false;
            }
        }
        log::info!("{log_msg}");

        all_ok
    }
}

fn create_draw_tests(format: vk::Format) -> TestCaseGroup {
    let num_channels = num_used_channels(format);

    // name, numVertexValues, numInstanceValues, numVertices, numInstances, shader
    let test_configs = [
        // Create data for 6 vertices, draw 9 vertices
        (
            "vertex_out_of_bounds",
            num_channels * 2 * 6,
            num_channels,
            9,
            1,
            Shader::VERTEX_OUT_OF_BOUNDS,
        ),
        // Create data for half a vertex, draw 3 vertices
        (
            "vertex_incomplete",
            num_channels,
            num_channels,
            3,
            1,
            Shader::VERTEX_INCOMPLETE,
        ),
        // Create data for 1 instance, draw 3 instances
        (
            "instance_out_of_bounds",
            num_channels * 2 * 9,
            num_channels,
            3,
            3,
            Shader::INSTANCE_OUT_OF_BOUNDS,
        ),
    ];

    let mut draw_tests = TestCaseGroup::new("draw");

    for (name, num_vertex_values, num_instance_values, num_vertices, num_instances, shader) in test_configs {
        let params = TestParams {
            input_format: format,
            num_vertex_values,
            num_instance_values,
            num_vertices,
            num_instances,
            indices: &[],
            programs: programs_for(format, shader),
        };
        draw_tests.add_child(Box::new(VertexAccessTest {
            name: name.to_string(),
            params,
        }) as Box<dyn TestCase>);
    }

    draw_tests
}

fn create_draw_indexed_tests(format: vk::Format) -> TestCaseGroup {
    let test_configs = [
        // Only last index is out of bounds
        ("last_index_out_of_bounds", INDEX_CONFIGS[0]),
        // Random indices out of bounds
        ("indices_out_of_bounds", INDEX_CONFIGS[1]),
        // First triangle is out of bounds
        ("triangle_out_of_bounds", INDEX_CONFIGS[2]),
    ];

    let mut draw_tests = TestCaseGroup::new("draw_indexed");

    for (name, indices) in test_configs {
        let num_channels = num_used_channels(format);
        let params = TestParams {
            input_format: format,
            num_vertex_values: num_channels * indices.len() as u32 * 2,
            num_instance_values: num_channels,
            num_vertices: indices.len() as u32,
            num_instances: 1,
            indices,
            programs: programs_for(format, Shader::INDEXED),
        };
        draw_tests.add_child(Box::new(VertexAccessTest {
            name: name.to_string(),
            params,
        }) as Box<dyn TestCase>);
    }

    draw_tests
}

/// `createVertexAccessTests`
pub fn create_vertex_access_tests() -> TestCaseGroup {
    let vertex_formats = [
        (vk::Format::R32_UINT, "r32_uint"),
        (vk::Format::R32_SINT, "r32_sint"),
        (vk::Format::R32_SFLOAT, "r32_sfloat"),
        (vk::Format::R32G32_UINT, "r32g32_uint"),
        (vk::Format::R32G32_SINT, "r32g32_sint"),
        (vk::Format::R32G32_SFLOAT, "r32g32_sfloat"),
        (vk::Format::R32G32B32_UINT, "r32g32b32_uint"),
        (vk::Format::R32G32B32_SINT, "r32g32b32_sint"),
        (vk::Format::R32G32B32_SFLOAT, "r32g32b32_sfloat"),
        (vk::Format::R32G32B32A32_UINT, "r32g32b32a32_uint"),
        (vk::Format::R32G32B32A32_SINT, "r32g32b32a32_sint"),
        (vk::Format::R32G32B32A32_SFLOAT, "r32g32b32a32_sfloat"),
        (vk::Format::R64_UINT, "r64_uint"),
        (vk::Format::R64_SINT, "r64_sint"),
        (vk::Format::A2B10G10R10_UNORM_PACK32, "a2b10g10r10_unorm_pack32"),
    ];

    let mut vertex_access_tests = TestCaseGroup::new("vertex_access");

    for (format, name) in vertex_formats {
        let mut format_group = TestCaseGroup::new(name);

        format_group.add_child(create_draw_tests(format));
        format_group.add_child(create_draw_indexed_tests(format));

        vertex_access_tests.add_child(format_group);
    }

    vertex_access_tests
}
