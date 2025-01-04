// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorBool.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `genShaderBooleanOp` is `scripts/gen_tensor_manifests.py` (one compute shader per rank, operator and
// test value, looked up by `b<rank>_<op>_<value>`); the cases are returned keyed by their dotted path so `tensor::create_tests` can swap them in for the gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ArmTensorsExtensionDeviceCommands;

use super::tensor_util::{
    ElementKind, StridedMemory, TensorDescription, TensorParameters, TensorView, TensorWithMemory, clear_tensor,
    cmd_tensor_memory_barrier, create_descriptor_pool, device_supports_non_packed_tensors,
    device_supports_shader_stages_tensor_access, device_supports_shader_tensor_access, download_from_tensor,
    format_support_tensor_flags, get_format_size, get_tensor_strides, make_compute_pipeline,
    make_tensor_memory_barrier, params_to_string, pool_size, require_tensor_shape_supported,
    single_dimension_workgroup_count, tensor_descriptor_write, upload_to_tensor,
};
use crate::generated::shaders::tensor_boolean::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_descriptor_set, make_pipeline_layout};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::{Context, TestCase, TestInstance};

const SHADER_BOOLEAN_OP_ACCESS_WORKGROUP_SIZE: u32 = 128;

#[derive(Clone, Copy, PartialEq, Eq)]
enum BooleanOperator {
    And,
    Or,
    Not,
    Xor,
}

impl BooleanOperator {
    fn name(self) -> &'static str {
        match self {
            Self::And => "and",
            Self::Or => "or",
            Self::Not => "not",
            Self::Xor => "xor",
        }
    }
}

struct TensorBooleanOpTestCase {
    name: String,
    parameters: TensorParameters,
    op: BooleanOperator,
    test_value: bool,
}

impl TestCase for TensorBooleanOpTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ARM_tensors")?;

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
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }

        if !self.parameters.packed() && !device_supports_non_packed_tensors(context) {
            return Err(TestError::NotSupported("Non-packed tensors not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = format!(
            "b{}_{}_{}",
            self.parameters.dimensions.len(),
            self.op.name(),
            u32::from(self.test_value)
        );
        ALL_SHARED_PROGRAM
            .iter()
            .find(|p| p.name == key)
            .map_or_else(|| BinaryCollection::new(&[]), |p| p.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TensorBooleanOpTestInstance {
            context,
            parameters: &self.parameters,
            op: self.op,
            test_value: self.test_value,
        })
    }
}

struct TensorBooleanOpTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: &'a TensorParameters,
    op: BooleanOperator,
    test_value: bool,
}

impl TensorBooleanOpTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let parameters = self.parameters;

        let elements = parameters.elements() as u32;

        let tensor_desc = TensorDescription::new(
            parameters.tiling,
            parameters.format,
            &parameters.dimensions,
            &parameters.strides,
            vk::TensorUsageFlagsARM::SHADER
                | vk::TensorUsageFlagsARM::TRANSFER_SRC
                | vk::TensorUsageFlagsARM::TRANSFER_DST,
        );
        let tensor = TensorWithMemory::new(context, &tensor_desc, MemoryRequirement::ANY)?;
        let tensor_out = TensorWithMemory::new(context, &tensor_desc, MemoryRequirement::ANY)?;

        let tensor_view = TensorView::new(device, tensor.get(), parameters.format)?;
        let tensor_view_out = TensorView::new(device, tensor_out.get(), parameters.format)?;

        let optimal_tiling_test = parameters.tiling == vk::TensorTilingARM::OPTIMAL;

        let linear_tensor = if optimal_tiling_test {
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

        let mut initial_tensor_data =
            StridedMemory::new(&parameters.dimensions, &parameters.strides, ElementKind::UInt(1));
        initial_tensor_data.fill();

        if let Some(linear_tensor) = &linear_tensor {
            upload_to_tensor(context, linear_tensor, initial_tensor_data.data())?;
        } else {
            upload_to_tensor(context, &tensor, initial_tensor_data.data())?;
            clear_tensor(context, &tensor_out)?;
        }

        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::TENSOR_ARM, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::TENSOR_ARM, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = create_descriptor_pool(
            device,
            &[pool_size(vk::DescriptorType::TENSOR_ARM, 2)],
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let views = [tensor_view.get()];
        let views_out = [tensor_view_out.get()];
        let tensor_descriptor_info = vk::WriteDescriptorSetTensorARM {
            tensor_view_count: 1,
            tensor_views: views.as_ptr(),
            ..Default::default()
        };
        let tensor_descriptor_info_out = vk::WriteDescriptorSetTensorARM {
            tensor_view_count: 1,
            tensor_views: views_out.as_ptr(),
            ..Default::default()
        };
        let writes = [
            tensor_descriptor_write(descriptor_set.get(), 0, 0, &tensor_descriptor_info),
            tensor_descriptor_write(descriptor_set.get(), 1, 0, &tensor_descriptor_info_out),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let binary = context.get_binary_collection().get("comp")?;
        let shader_module = create_shader_module(device, binary)?;

        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let pipeline = make_compute_pipeline(device, *pipeline_layout, *shader_module)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;

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
        let dispatch_count = single_dimension_workgroup_count(elements, SHADER_BOOLEAN_OP_ACCESS_WORKGROUP_SIZE);
        assert!(dispatch_count <= 65535);
        unsafe { device.cmd_dispatch(cmd_buffer.get(), dispatch_count, 1, 1) };

        if let Some(linear_tensor) = &linear_tensor {
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
                src_tensor: tensor_out.get(),
                dst_tensor: linear_tensor.get(),
                regions: &tensor_regions,
                region_count: 1,
                ..Default::default()
            };
            unsafe { device.cmd_copy_tensor_arm(cmd_buffer.get(), &copy_info) };
        }

        end_command_buffer(device, cmd_buffer.get())?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer.get())?;

        let mut result = StridedMemory::new(&parameters.dimensions, &parameters.strides, ElementKind::UInt(1));
        let result_tensor = linear_tensor.as_ref().unwrap_or(&tensor_out);
        let downloaded = download_from_tensor(context, result_tensor, result.memory_size())?;
        result.data_mut().copy_from_slice(&downloaded);

        for element_idx in 0..elements as usize {
            let initial = initial_tensor_data.get_u8(element_idx as u64) != 0;
            let expected = match self.op {
                BooleanOperator::And => initial && self.test_value,
                BooleanOperator::Xor => initial ^ self.test_value,
                BooleanOperator::Or => initial || self.test_value,
                BooleanOperator::Not => !initial,
            };
            let actual = result.get_u8(element_idx as u64);
            if (actual != 0) != expected {
                return Ok(TestStatus::fail(format!(
                    "Comparison failed at index {element_idx}: expected = {}, buffer = {actual}",
                    u32::from(expected)
                )));
            }
        }

        Ok(TestStatus::pass("Tensor test succeeded"))
    }
}

impl TestInstance for TensorBooleanOpTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `addTensorBoolTests`: the cases keyed by their dotted path (`boolean.<name>`)
pub fn create_boolean_cases() -> HashMap<String, Box<dyn TestCase>> {
    const SHAPES: [&[i64]; 5] = [
        &[71693],
        &[263, 269],
        &[37, 43, 47],
        &[13, 17, 19, 23],
        &[7, 11, 13, 17, 19, 23],
    ];

    let format = vk::Format::R8_BOOL_ARM;
    let element_size = get_format_size(format);
    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();

    for shape in SHAPES {
        let rank = shape.len();
        let packed_strides = get_tensor_strides(shape, element_size, 1);

        let mut padded_strides = vec![0i64; rank];
        padded_strides[rank - 1] = element_size as i64;
        for i in 2..=rank {
            padded_strides[rank - i] = padded_strides[rank - i + 1] * shape[rank - i + 1] + 13 * element_size as i64;
        }

        for op in [
            BooleanOperator::And,
            BooleanOperator::Or,
            BooleanOperator::Not,
            BooleanOperator::Xor,
        ] {
            for test_value in [true, false] {
                let mut variants = vec![TensorParameters::new(format, vk::TensorTilingARM::LINEAR, shape, &[])];
                if rank > 1 {
                    variants.push(TensorParameters::new(
                        format,
                        vk::TensorTilingARM::LINEAR,
                        shape,
                        &packed_strides,
                    ));
                    variants.push(TensorParameters::new(
                        format,
                        vk::TensorTilingARM::LINEAR,
                        shape,
                        &padded_strides,
                    ));
                }
                variants.push(TensorParameters::new(format, vk::TensorTilingARM::OPTIMAL, shape, &[]));

                for parameters in variants {
                    let name = format!(
                        "{}_operator_{}_apply_{}",
                        params_to_string(&parameters),
                        op.name(),
                        u32::from(test_value)
                    );
                    cases.insert(
                        format!("boolean.{name}"),
                        Box::new(TensorBooleanOpTestCase {
                            name,
                            parameters,
                            op,
                            test_value,
                        }),
                    );
                }
            }
        }
    }
    cases
}
