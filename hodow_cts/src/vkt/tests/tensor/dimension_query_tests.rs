// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorDimensionQuery.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `genShaderQueryDimensions` is `scripts/gen_tensor_manifests.py` (one compute shader per rank and
// format, looked up by `q<rank>_<format>`); the cases are returned keyed by their dotted path so `tensor::create_tests` can swap them in for the gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;

use super::tensor_util::{
    TensorDescription, TensorParameters, TensorView, TensorWithMemory, create_descriptor_pool,
    device_supports_shader_stages_tensor_access, device_supports_shader_tensor_access, format_support_tensor_flags,
    get_format_size, get_tensor_strides, make_compute_pipeline, params_to_string, pool_size, require_format_extensions,
    require_tensor_shape_supported, tensor_descriptor_write, tensor_format_short_name,
};
use crate::generated::shaders::tensor_dimension_query::ALL_SHARED_PROGRAM;
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

struct TensorDimensionQueryTestCase {
    name: String,
    format: vk::Format,
    dimensions: Vec<i64>,
    tiling: vk::TensorTilingARM,
}

impl TensorDimensionQueryTestCase {
    fn shader_name(&self) -> String {
        format!("q{}_{}", self.dimensions.len(), tensor_format_short_name(self.format))
    }
}

impl TestCase for TensorDimensionQueryTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ARM_tensors")?;
        require_format_extensions(context, &[self.format])?;

        require_tensor_shape_supported(
            context,
            &TensorParameters::new(self.format, self.tiling, &self.dimensions, &[]),
        )?;

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
            self.format,
            self.tiling,
            vk::FormatFeatureFlags2::TENSOR_SHADER_ARM,
        ) {
            return Err(TestError::NotSupported(
                "Device does not support the tensor flags for this tiling and format".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.shader_name();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TensorDimensionsQueriesTestInstance {
            context,
            format: self.format,
            dimensions: &self.dimensions,
            tiling: self.tiling,
        })
    }
}

struct TensorDimensionsQueriesTestInstance<'a> {
    context: &'a Context<'a>,
    format: vk::Format,
    dimensions: &'a [i64],
    tiling: vk::TensorTilingARM,
}

impl TensorDimensionsQueriesTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();

        let strides = if self.tiling == vk::TensorTilingARM::LINEAR {
            get_tensor_strides(self.dimensions, get_format_size(self.format), 1)
        } else {
            Vec::new()
        };

        let tensor_desc = TensorDescription::new(
            self.tiling,
            self.format,
            self.dimensions,
            &strides,
            vk::TensorUsageFlagsARM::SHADER,
        );
        let tensor = TensorWithMemory::new(context, &tensor_desc, MemoryRequirement::ANY)?;
        let tensor_view = TensorView::new(device, tensor.get(), self.format)?;

        let buffer_elements = self.dimensions.len();
        let buffer_size = (buffer_elements * std::mem::size_of::<u32>()) as u64;
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, buffer_size as usize) };
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
            let binary = context.get_binary_collection().get("comp")?;
            let shader_module = create_shader_module(device, binary)?;

            let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
            let pipeline = make_compute_pipeline(device, *pipeline_layout, *shader_module)?;

            let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
            let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

            begin_command_buffer(device, cmd_buffer.get())?;

            let buffer_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::SHADER_WRITE,
                vk::AccessFlags::HOST_READ,
                buffer.get(),
                0,
                buffer_size,
            );

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
                device.cmd_dispatch(cmd_buffer.get(), 1, 1, 1);
                device.cmd_pipeline_barrier(
                    cmd_buffer.get(),
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }

            end_command_buffer(device, cmd_buffer.get())?;
            submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;
        }

        invalidate_alloc(device, buffer.get_allocation())?;
        let buffer_memory = buffer.get_allocation().get_host_ptr().cast::<u32>();
        for (element_idx, &dimension) in self.dimensions.iter().enumerate() {
            let value = unsafe { buffer_memory.add(element_idx).read() };
            if i64::from(value) != dimension {
                return Ok(TestStatus::fail(format!(
                    "Comparison failed at index {element_idx}: expected = {dimension}, buffer = {value}"
                )));
            }
        }

        Ok(TestStatus::pass("Tensor test succeeded"))
    }
}

impl TestInstance for TensorDimensionsQueriesTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `createDimensionQueryTests`: the cases keyed by their dotted path (`dimension_query.<name>`)
pub fn create_dimension_query_cases() -> HashMap<String, Box<dyn TestCase>> {
    const TEST_DIMENSIONS: [&[i64]; 6] = [
        &[1],
        &[2, 1],
        &[4, 2, 1],
        &[8, 4, 2, 1],
        &[4, 8, 16, 2, 1],
        &[7, 11, 13, 17, 19, 23],
    ];
    const FORMATS: [vk::Format; 14] = [
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
        vk::Format::R8_BOOL_ARM,
        vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM,
        vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM,
        vk::Format::R16_SFLOAT_FPENCODING_BFLOAT16_ARM,
    ];

    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();
    for format in FORMATS {
        for dimensions in TEST_DIMENSIONS {
            for tiling in [vk::TensorTilingARM::LINEAR, vk::TensorTilingARM::OPTIMAL] {
                let name = params_to_string(&TensorParameters::new(format, tiling, dimensions, &[]));
                cases.insert(
                    format!("dimension_query.{name}"),
                    Box::new(TensorDimensionQueryTestCase {
                        name,
                        format,
                        dimensions: dimensions.to_vec(),
                        tiling,
                    }),
                );
            }
        }
    }
    cases
}
