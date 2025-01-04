// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorRobustness.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `genShaderTensorOoBAccess` is `scripts/gen_tensor_manifests.py` (per format one case with a shader per rank and
// variant, `r<rank>_read|write`); the cases are returned keyed by their dotted path so `tensor::create_tests` can swap them in for the gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;

use super::tensor_util::{
    ElementKind, StridedMemory, TensorDescription, TensorParameters, TensorView, TensorWithMemory, coordinates_of,
    create_descriptor_pool, describe_mismatch, device_supports_non_packed_tensors,
    device_supports_shader_stages_tensor_access, device_supports_shader_tensor_access, download_from_tensor,
    format_support_tensor_flags, get_format_size, get_tensor_strides, make_compute_pipeline, params_to_string,
    pool_size, require_format_extensions, require_tensor_shape_supported, single_dimension_workgroup_count,
    tensor_descriptor_write, tensor_format_short_name, upload_to_tensor,
};
use crate::generated::shaders::tensor_robustness::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::{Context, TestCase, TestInstance};

const SHADER_TENSOR_OOB_ACCESS_WORKGROUP_SIZE: u32 = 128;

/// `shaderTensorOoBAccessLineAccesses`: (offsetFromEndOfLine, outOfBoundsValue)
const LINE_ACCESSES: [(i32, u64); 4] = [(-1, 24), (0, 42), (13, 0), (65537, 84)];
const ACCESSES_PER_LINE: u32 = LINE_ACCESSES.len() as u32;

#[derive(Clone, Copy, PartialEq, Eq)]
enum AccessVariant {
    WriteToBuffer,
    ReadFromBuffer,
}

impl AccessVariant {
    fn name(self) -> &'static str {
        match self {
            Self::WriteToBuffer => "shader_read",
            Self::ReadFromBuffer => "shader_write",
        }
    }

    fn shader_suffix(self) -> &'static str {
        match self {
            Self::WriteToBuffer => "read",
            Self::ReadFromBuffer => "write",
        }
    }
}

/// Coordinates of the first element of `line` in the accessed shape, and whether that line is outside the real shape
fn accessed_line(accessed_shape: &[i64], real_shape: &[i64], line: usize) -> (Vec<u64>, bool) {
    let line_size = *real_shape.last().expect("a tensor has dimensions") as u64;
    let base = coordinates_of(accessed_shape, line as u64 * line_size);
    let line_is_oob = (0..real_shape.len() - 1).any(|i| base[i] >= real_shape[i] as u64);
    (base, line_is_oob)
}

fn coord_at_line_index(coordinates: &[u64], index: u64) -> Vec<u64> {
    let mut result = coordinates.to_vec();
    *result.last_mut().expect("a tensor has dimensions") = index;
    result
}

fn line_count_of(accessed_shape: &[i64]) -> usize {
    accessed_shape[..accessed_shape.len() - 1].iter().product::<i64>() as usize
}

/// `validateOoBReads`
fn validate_oob_reads(
    tensor: &StridedMemory,
    real_shape: &[i64],
    accessed_shape: &[i64],
    buffer: &StridedMemory,
) -> TestStatus {
    let kind = tensor.kind();
    let line_size = *real_shape.last().expect("a tensor has dimensions") as u64;
    let line_count = line_count_of(accessed_shape);
    assert_eq!(line_count * ACCESSES_PER_LINE as usize, buffer.element_count());

    for line in 0..line_count {
        let (base, line_is_oob) = accessed_line(accessed_shape, real_shape, line);
        let buffer_index_base = line as u64 * u64::from(ACCESSES_PER_LINE);

        for (access_index, &(offset_from_end_of_line, out_of_bounds_value)) in LINE_ACCESSES.iter().enumerate() {
            let line_offset_is_oob = offset_from_end_of_line >= 0;
            let coordinates =
                coord_at_line_index(&base, (line_size as i64 + i64::from(offset_from_end_of_line)) as u64);
            let expected = if line_is_oob || line_offset_is_oob {
                kind.bits_of_integer_value(out_of_bounds_value)
            } else {
                tensor.read_bits_at(&coordinates)
            };
            let value = buffer.read_bits(buffer_index_base + access_index as u64);
            if let Some(why) = describe_mismatch(kind, expected, value) {
                return TestStatus::fail(format!("Comparison failed at read coordinate {coordinates:?}: {why}"));
            }
        }
    }
    TestStatus::pass("Pass")
}

/// `validateOoBWrites`
fn validate_oob_writes(
    updated_tensor: &StridedMemory,
    original_tensor: &StridedMemory,
    real_shape: &[i64],
    accessed_shape: &[i64],
    buffer: &StridedMemory,
) -> TestStatus {
    let kind = original_tensor.kind();
    let line_size = *real_shape.last().expect("a tensor has dimensions") as u64;
    let line_count = line_count_of(accessed_shape);
    assert_eq!(line_count * ACCESSES_PER_LINE as usize, buffer.element_count());

    // The shader has written only four elements per line of the innermost dimension: one in bounds at the end of the line, the rest out of bounds
    for line in 0..line_count {
        let (base, line_is_oob) = accessed_line(accessed_shape, real_shape, line);
        if line_is_oob {
            continue;
        }

        let expected_updated_value = buffer.read_bits(line as u64 * u64::from(ACCESSES_PER_LINE));

        for i in 0..line_size {
            let coordinate = coord_at_line_index(&base, i);
            let element_should_have_been_updated = i == line_size - 1;
            let expected = if element_should_have_been_updated {
                expected_updated_value
            } else {
                original_tensor.read_bits_at(&coordinate)
            };
            let value = updated_tensor.read_bits_at(&coordinate);
            if let Some(why) = describe_mismatch(kind, expected, value) {
                return TestStatus::fail(format!("Comparison failed at read coordinate {coordinate:?}: {why}"));
            }
        }
    }
    TestStatus::pass("Pass")
}

struct OoBAccessTestCase {
    name: String,
    parameters: TensorParameters,
    variant: AccessVariant,
}

impl TestCase for OoBAccessTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ARM_tensors")?;

        require_tensor_shape_supported(context, &self.parameters)?;
        require_format_extensions(context, &[self.parameters.format])?;

        if !format_support_tensor_flags(
            context,
            self.parameters.format,
            self.parameters.tiling,
            vk::FormatFeatureFlags2::TENSOR_SHADER_ARM,
        ) {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }

        if !device_supports_shader_tensor_access(context) {
            return Err(TestError::NotSupported(
                "Device does not support shader tensor access".to_string(),
            ));
        }

        if !device_supports_shader_stages_tensor_access(context, vk::ShaderStageFlags::COMPUTE) {
            return Err(TestError::NotSupported(
                "Device does not support shader tensor access in compute shader stage".to_string(),
            ));
        }

        if !self.parameters.packed() && !device_supports_non_packed_tensors(context) {
            return Err(TestError::NotSupported("Non-packed tensors not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = format!("rb_{}", tensor_format_short_name(self.parameters.format));
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OoBAccessTestInstance {
            context,
            parameters: &self.parameters,
            variant: self.variant,
        })
    }
}

struct OoBAccessTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: &'a TensorParameters,
    variant: AccessVariant,
}

impl OoBAccessTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let parameters = self.parameters;
        let kind = ElementKind::for_format(parameters.format);

        // Shader accesses a shape which goes 1 coordinate further than the real shape in all dimensions other than the innermost one
        let mut accessed_shape = parameters.dimensions.clone();
        let rank = accessed_shape.len();
        for dimension in &mut accessed_shape[..rank - 1] {
            *dimension += 1;
        }

        // Shader accesses one line (one row of the innermost dimension) for each invocation
        let line_count = line_count_of(&accessed_shape) as u32;
        let access_count = line_count * ACCESSES_PER_LINE;

        let tensor_desc = TensorDescription::new(
            parameters.tiling,
            parameters.format,
            &parameters.dimensions,
            &parameters.strides,
            vk::TensorUsageFlagsARM::SHADER,
        );
        let tensor = TensorWithMemory::new(context, &tensor_desc, MemoryRequirement::ANY)?;
        let tensor_view = TensorView::new(device, tensor.get(), parameters.format)?;

        let buffer_size = u64::from(access_count) * kind.size() as u64;
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut tensor_data = StridedMemory::new(&parameters.dimensions, &parameters.strides, kind);
        let mut buffer_memory = StridedMemory::new(&[i64::from(access_count)], &[], kind);

        tensor_data.fill();
        upload_to_tensor(context, &tensor, tensor_data.data())?;
        if self.variant == AccessVariant::WriteToBuffer {
            buffer_memory.clear();
        } else {
            buffer_memory.fill();
        }
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer_memory.data().as_ptr(),
                buffer.get_allocation().get_host_ptr(),
                buffer_size as usize,
            );
        }
        flush_alloc(device, buffer.get_allocation())?;

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::TENSOR_ARM, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = create_descriptor_pool(
            device,
            &[
                pool_size(vk::DescriptorType::TENSOR_ARM, 1),
                pool_size(vk::DescriptorType::STORAGE_BUFFER, 1),
            ],
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let buffer_descriptor_info = [make_descriptor_buffer_info(buffer.get(), 0, buffer_size)];
        let tensor_views = [tensor_view.get()];
        let tensor_descriptor_info = vk::WriteDescriptorSetTensorARM {
            tensor_view_count: 1,
            tensor_views: tensor_views.as_ptr(),
            ..Default::default()
        };
        let writes = [
            tensor_descriptor_write(descriptor_set.get(), 0, 0, &tensor_descriptor_info),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_descriptor_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        {
            let binary = context
                .get_binary_collection()
                .get(&format!("r{rank}_{}", self.variant.shader_suffix()))?;
            let shader_module = create_shader_module(device, binary)?;

            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let pipeline = make_compute_pipeline(device, *pipeline_layout, *shader_module)?;

            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, cmd_buffer.get())?;

            unsafe {
                device.cmd_bind_pipeline(cmd_buffer.get(), vk::PipelineBindPoint::COMPUTE, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd_buffer.get(),
                    vk::PipelineBindPoint::COMPUTE,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[],
                );
            }

            let dispatch_count = single_dimension_workgroup_count(line_count, SHADER_TENSOR_OOB_ACCESS_WORKGROUP_SIZE);
            assert!(dispatch_count <= 65535);
            unsafe { device.cmd_dispatch(cmd_buffer.get(), dispatch_count, 1, 1) };

            if self.variant == AccessVariant::WriteToBuffer {
                let buffer_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    buffer.get(),
                    0,
                    buffer_size,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd_buffer.get(),
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[buffer_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    )
                };
            }

            end_command_buffer(device, cmd_buffer.get())?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;
        }

        invalidate_alloc(device, buffer.get_allocation())?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer.get_allocation().get_host_ptr(),
                buffer_memory.data_mut().as_mut_ptr(),
                buffer_size as usize,
            );
        }

        if self.variant == AccessVariant::WriteToBuffer {
            Ok(validate_oob_reads(
                &tensor_data,
                &parameters.dimensions,
                &accessed_shape,
                &buffer_memory,
            ))
        } else {
            let mut updated_tensor_data = StridedMemory::new(&parameters.dimensions, &parameters.strides, kind);
            let downloaded = download_from_tensor(context, &tensor, updated_tensor_data.memory_size())?;
            updated_tensor_data.data_mut().copy_from_slice(&downloaded);
            Ok(validate_oob_writes(
                &updated_tensor_data,
                &tensor_data,
                &parameters.dimensions,
                &accessed_shape,
                &buffer_memory,
            ))
        }
    }
}

impl TestInstance for OoBAccessTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `addOoBAccessTests<Format>`
fn add_oob_access_tests(cases: &mut HashMap<String, Box<dyn TestCase>>, format: vk::Format) {
    const SHAPES: [&[i64]; 5] = [
        &[71693],
        &[263, 269],
        &[37, 43, 47],
        &[13, 17, 19, 23],
        &[7, 11, 13, 17, 19, 23],
    ];
    let element_size = get_format_size(format);

    let mut add = |parameters: TensorParameters| {
        for variant in [AccessVariant::ReadFromBuffer, AccessVariant::WriteToBuffer] {
            let name = format!("oob_coordinates_{}_{}", params_to_string(&parameters), variant.name());
            cases.insert(
                format!("robustness.{name}"),
                Box::new(OoBAccessTestCase {
                    name,
                    parameters: parameters.clone(),
                    variant,
                }),
            );
        }
    };

    for shape in SHAPES {
        let rank = shape.len();

        add(TensorParameters::new(format, vk::TensorTilingARM::LINEAR, shape, &[]));

        if rank > 1 {
            let mut padded_strides = vec![0i64; rank];
            padded_strides[rank - 1] = element_size as i64;
            for i in 2..=rank {
                padded_strides[rank - i] =
                    padded_strides[rank - i + 1] * shape[rank - i + 1] + 13 * element_size as i64;
            }
            add(TensorParameters::new(
                format,
                vk::TensorTilingARM::LINEAR,
                shape,
                &padded_strides,
            ));
        }

        let packed_strides = get_tensor_strides(shape, element_size, 1);
        add(TensorParameters::new(
            format,
            vk::TensorTilingARM::LINEAR,
            shape,
            &packed_strides,
        ));
    }
}

/// `createRobustnessTests`: the cases keyed by their dotted path (`robustness.<name>`)
pub fn create_robustness_cases() -> HashMap<String, Box<dyn TestCase>> {
    let mut cases = HashMap::new();
    for format in [
        vk::Format::R8_UINT,
        vk::Format::R8_SINT,
        vk::Format::R16_UINT,
        vk::Format::R16_SINT,
        vk::Format::R32_UINT,
        vk::Format::R32_SINT,
        vk::Format::R64_UINT,
        vk::Format::R64_SINT,
        vk::Format::R16_SFLOAT,
        vk::Format::R32_SFLOAT,
        vk::Format::R16_SFLOAT_FPENCODING_BFLOAT16_ARM,
        vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM,
        vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM,
    ] {
        add_oob_access_tests(&mut cases, format);
    }
    cases
}
