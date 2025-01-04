// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorArrayAccess.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. One case type covers `TensorArrayReadWriteTestCase<T>` and `OptimalTensorArrayReadWriteTestCase<T>` (the optimal
// one stages through a linear tensor). `genShaderArrayAccess` is `scripts/gen_tensor_manifests.py`; upstream builds the shader of the `max` cases at run time for
// the array size the device allows, which a precompiled shader cannot, so every (format, variant) carries one shader per size of `ARRAY_MAX_SIZES` plus 2/3/4
// (`comp<size>`) and a `max` case runs the largest of those the device allows (at most 64).

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ArmTensorsExtensionDeviceCommands;

use super::required_tests::get_tensor_physical_device_properties;
use super::tensor_util::{
    ElementKind, StridedMemory, TensorDescription, TensorParameters, TensorView, TensorWithMemory, clear_tensor,
    cmd_tensor_memory_barrier, compare_strided_memory, create_descriptor_pool, device_supports_non_packed_tensors,
    device_supports_shader_stages_tensor_access, device_supports_shader_tensor_access, download_from_tensor,
    format_support_tensor_flags, get_format_size, make_compute_pipeline, make_tensor_memory_barrier, params_to_string,
    pool_size, require_tensor_shape_supported, tensor_descriptor_write, upload_to_tensor,
};
use crate::generated::shaders::tensor_array_access::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome};
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

const DISPATCH_WORKGROUP_COUNT_LIMIT: u64 = 65535;

/// The array sizes `scripts/gen_tensor_manifests.py` compiles shaders for
const COMPILED_ARRAY_SIZES: [u32; 14] = [1, 2, 3, 4, 5, 6, 7, 8, 12, 16, 24, 32, 48, 64];

#[derive(Clone, Copy, PartialEq, Eq)]
enum AccessVariant {
    ArrayRead,
    ArrayWrite,
}

impl AccessVariant {
    fn name(self) -> &'static str {
        match self {
            Self::ArrayRead => "array_read",
            Self::ArrayWrite => "array_write",
        }
    }

    fn shader_suffix(self) -> &'static str {
        match self {
            Self::ArrayRead => "read",
            Self::ArrayWrite => "write",
        }
    }
}

/// `calculateMaxArraySizeSupported`
fn calculate_max_array_size_supported(context: &Context<'_>, params: &TensorParameters) -> u32 {
    let element_size = get_format_size(params.format) as u32;
    let tensor_properties = get_tensor_physical_device_properties(context);

    let max_array_access_size_in_elements = tensor_properties.max_tensor_shader_access_size / element_size;

    max_array_access_size_in_elements.min(tensor_properties.max_tensor_shader_access_array_length)
}

struct TensorArrayReadWriteTestCase {
    name: String,
    parameters: TensorParameters,
    variant: AccessVariant,
    /// 0 is the `max` case
    array_size: u32,
}

impl TestCase for TensorArrayReadWriteTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ARM_tensors")?;

        let tensor_properties = get_tensor_physical_device_properties(context);

        require_tensor_shape_supported(context, &self.parameters)?;

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
        if !format_support_tensor_flags(
            context,
            self.parameters.format,
            self.parameters.tiling,
            vk::FormatFeatureFlags2::TENSOR_SHADER_ARM,
        ) {
            return Err(TestError::NotSupported(
                "Device does not support the tensor flags for this tiling and format".to_string(),
            ));
        }

        if self.parameters.tiling == vk::TensorTilingARM::OPTIMAL
            && !self.parameters.packed()
            && !device_supports_non_packed_tensors(context)
        {
            return Err(TestError::NotSupported("Non-packed tensors not supported".to_string()));
        }

        if self.array_size > tensor_properties.max_tensor_shader_access_array_length {
            return Err(TestError::NotSupported(
                "Device does not support this access array length".to_string(),
            ));
        }

        if u64::from(self.array_size) * get_format_size(self.parameters.format)
            > u64::from(tensor_properties.max_tensor_shader_access_size)
        {
            return Err(TestError::NotSupported(
                "Device does not support this access size".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = format!(
            "ar_{}_{}",
            super::tensor_util::tensor_format_short_name(self.parameters.format),
            self.variant.shader_suffix()
        );
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let mut array_size = self.array_size;

        // If provided arraySize is 0, test the maximum array size supported by implementation
        if array_size == 0 {
            let max = calculate_max_array_size_supported(context, &self.parameters);
            array_size = COMPILED_ARRAY_SIZES
                .iter()
                .copied()
                .filter(|&size| size <= max)
                .max()
                .unwrap_or(1);
        }

        Box::new(TensorArrayReadWriteTestInstance {
            context,
            parameters: &self.parameters,
            variant: self.variant,
            array_size,
        })
    }
}

struct TensorArrayReadWriteTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: &'a TensorParameters,
    variant: AccessVariant,
    array_size: u32,
}

impl TensorArrayReadWriteTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let parameters = self.parameters;
        let kind = ElementKind::for_format(parameters.format);
        let optimal = parameters.tiling == vk::TensorTilingARM::OPTIMAL;

        let elements = parameters.elements() as u32;

        let usage = if optimal {
            vk::TensorUsageFlagsARM::SHADER
                | vk::TensorUsageFlagsARM::TRANSFER_SRC
                | vk::TensorUsageFlagsARM::TRANSFER_DST
        } else {
            vk::TensorUsageFlagsARM::SHADER
        };
        let tensor_desc = TensorDescription::new(
            parameters.tiling,
            parameters.format,
            &parameters.dimensions,
            &parameters.strides,
            usage,
        );
        let tensor = TensorWithMemory::new(context, &tensor_desc, MemoryRequirement::ANY)?;

        // Staging linear tensor to copy to or from the optimal tensor
        let linear_tensor = if optimal {
            let linear_tensor_desc = TensorDescription::new(
                vk::TensorTilingARM::LINEAR,
                parameters.format,
                &parameters.dimensions,
                &[],
                vk::TensorUsageFlagsARM::TRANSFER_SRC | vk::TensorUsageFlagsARM::TRANSFER_DST,
            );
            Some(TensorWithMemory::new(
                context,
                &linear_tensor_desc,
                MemoryRequirement::ANY,
            )?)
        } else {
            None
        };
        let host_tensor = linear_tensor.as_ref().unwrap_or(&tensor);

        let tensor_view = TensorView::new(device, tensor.get(), parameters.format)?;

        let buffer_size = u64::from(elements) * kind.size() as u64;
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Memory used to transfer data to/from tensor and to compare with the buffer during verification
        let mut tensor_data = StridedMemory::new(&parameters.dimensions, &parameters.strides, kind);
        let mut buffer_memory = StridedMemory::new(&[i64::from(elements)], &[], kind);

        if self.variant == AccessVariant::ArrayRead {
            tensor_data.fill();
            upload_to_tensor(context, host_tensor, tensor_data.data())?;
            buffer_memory.clear();
        } else {
            tensor_data.clear();
            if optimal {
                clear_tensor(context, host_tensor)?;
                buffer_memory.fill();
            } else {
                buffer_memory.fill();
                clear_tensor(context, host_tensor)?;
            }
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
                .get(&format!("comp{}", self.array_size))?;
            let shader_module = create_shader_module(device, binary)?;

            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let pipeline = make_compute_pipeline(device, *pipeline_layout, *shader_module)?;

            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

            let innermost_elements = *parameters.dimensions.last().expect("a tensor has dimensions") as u64;
            let innermost_arrays = innermost_elements.div_ceil(u64::from(self.array_size));

            let outer_count = u64::from(elements) / innermost_elements;
            let inner_count = innermost_arrays;

            begin_command_buffer(device, cmd_buffer.get())?;

            let tensor_regions = vk::TensorCopyARM {
                dimension_count: parameters.dimensions.len() as u32,
                ..Default::default()
            };

            if let Some(linear_tensor) = &linear_tensor {
                let copy_info = vk::CopyTensorInfoARM {
                    src_tensor: linear_tensor.get(),
                    dst_tensor: tensor.get(),
                    regions: &tensor_regions,
                    region_count: 1,
                    ..Default::default()
                };
                unsafe { device.cmd_copy_tensor_arm(cmd_buffer.get(), &copy_info) };

                let tensor_init_barrier = make_tensor_memory_barrier(
                    vk::PipelineStageFlags2::ALL_TRANSFER,
                    vk::AccessFlags2::TRANSFER_WRITE,
                    vk::PipelineStageFlags2::COMPUTE_SHADER,
                    vk::AccessFlags2::SHADER_READ,
                    0,
                    0,
                    tensor.get(),
                );
                cmd_tensor_memory_barrier(device, cmd_buffer.get(), &tensor_init_barrier);
            }

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

            assert!(inner_count <= DISPATCH_WORKGROUP_COUNT_LIMIT);
            assert!(outer_count <= DISPATCH_WORKGROUP_COUNT_LIMIT);
            unsafe { device.cmd_dispatch(cmd_buffer.get(), inner_count as u32, outer_count as u32, 1) };

            if self.variant == AccessVariant::ArrayRead {
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
            } else if let Some(linear_tensor) = &linear_tensor {
                let tensor_readback_barrier = make_tensor_memory_barrier(
                    vk::PipelineStageFlags2::COMPUTE_SHADER,
                    vk::AccessFlags2::SHADER_WRITE,
                    vk::PipelineStageFlags2::ALL_TRANSFER,
                    vk::AccessFlags2::TRANSFER_READ,
                    0,
                    0,
                    tensor.get(),
                );
                cmd_tensor_memory_barrier(device, cmd_buffer.get(), &tensor_readback_barrier);

                let copy_info = vk::CopyTensorInfoARM {
                    src_tensor: tensor.get(),
                    dst_tensor: linear_tensor.get(),
                    regions: &tensor_regions,
                    region_count: 1,
                    ..Default::default()
                };
                unsafe { device.cmd_copy_tensor_arm(cmd_buffer.get(), &copy_info) };
            }

            end_command_buffer(device, cmd_buffer.get())?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;
        }

        invalidate_alloc(device, buffer.get_allocation())?;

        if self.variant == AccessVariant::ArrayWrite {
            let downloaded = download_from_tensor(context, host_tensor, tensor_data.memory_size())?;
            tensor_data.data_mut().copy_from_slice(&downloaded);
        }

        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer.get_allocation().get_host_ptr(),
                buffer_memory.data_mut().as_mut_ptr(),
                buffer_size as usize,
            );
        }

        Ok(compare_strided_memory(&tensor_data, &buffer_memory))
    }
}

impl TestInstance for TensorArrayReadWriteTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `addTensorArrayTests`: the cases keyed by their dotted path (`array_access.<name>`)
pub fn create_array_access_cases() -> HashMap<String, Box<dyn TestCase>> {
    const FORMATS: [vk::Format; 10] = [
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
    ];
    let shape = [13i64, 17, 19, 23];

    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();
    for format in FORMATS {
        for array_size in [2u32, 3, 4, 0] {
            for tiling in [vk::TensorTilingARM::LINEAR, vk::TensorTilingARM::OPTIMAL] {
                for variant in [AccessVariant::ArrayRead, AccessVariant::ArrayWrite] {
                    let parameters = TensorParameters::new(format, tiling, &shape, &[]);
                    let size_name = if array_size == 0 {
                        "max".to_string()
                    } else {
                        array_size.to_string()
                    };
                    let name = format!(
                        "{}_{}_array_size_{size_name}",
                        params_to_string(&parameters),
                        variant.name()
                    );
                    cases.insert(
                        format!("array_access.{name}"),
                        Box::new(TensorArrayReadWriteTestCase {
                            name,
                            parameters,
                            variant,
                            array_size,
                        }),
                    );
                }
            }
        }
    }
    cases
}
