// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorCreateRequirements.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The (format, tiling) parameters are baked into one fn per case by a macro, the case itself is
// a FunctionCase instead of a TestCase subclass (same checkSupport/iterate split).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ArmTensorsExtensionDeviceCommands;

use super::required_formats_tests::get_tensor_format_properties;
use super::required_tests::{get_tensor_physical_device_features, get_tensor_physical_device_properties};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::tests::api::case_util::add_function_case;
use crate::vkt::{Context, TestCaseGroup};

struct TensorParameters {
    dimensions: Vec<i64>,
    strides: Vec<i64>,
}

fn format_support_tensor_flags(
    context: &Context<'_>,
    format: vk::Format,
    tiling: vk::TensorTilingARM,
    flags: vk::FormatFeatureFlags2,
) -> bool {
    let props = get_tensor_format_properties(context, format);
    if tiling == vk::TensorTilingARM::OPTIMAL {
        props.optimal_tiling_tensor_features & flags == flags
    } else {
        props.linear_tiling_tensor_features & flags == flags
    }
}

fn get_max_tensor_parameters(
    context: &Context<'_>,
    element_size: u64,
    tiling: vk::TensorTilingARM,
) -> Vec<TensorParameters> {
    let props = get_tensor_physical_device_properties(context);

    let max_elements = props.max_tensor_elements.min(props.max_tensor_size / element_size);

    let mut max_parameters_list = Vec::new();

    for dimension_count in 1..=u64::from(props.max_tensor_dimension_count) {
        let mut parameters = TensorParameters {
            dimensions: Vec::new(),
            strides: Vec::new(),
        };

        let mut remaining_elements = max_elements;
        for _ in 0..dimension_count {
            if remaining_elements > props.max_per_dimension_tensor_elements {
                parameters
                    .dimensions
                    .push(props.max_per_dimension_tensor_elements as i64);
                remaining_elements /= props.max_per_dimension_tensor_elements;
            } else {
                parameters.dimensions.push(remaining_elements as u32 as i64);
                remaining_elements = 1;
            }
        }
        max_parameters_list.push(parameters);
    }

    let non_packed = get_tensor_physical_device_features(context).tensor_non_packed != vk::FALSE;
    if tiling == vk::TensorTilingARM::LINEAR && non_packed {
        const MAX_TENSOR_STRIDE_MINIMUM_LIMIT: i64 = 65536;
        let max_tensor_stride = props.max_tensor_stride.max(MAX_TENSOR_STRIDE_MINIMUM_LIMIT);

        let element_size_i = element_size as i64;
        let max_stride_aligned = max_tensor_stride - (max_tensor_stride % element_size_i);
        let max_size_aligned = props.max_tensor_size - (props.max_tensor_size % element_size);

        let max_size_aligned_fits_in_stride = max_size_aligned <= i64::MAX as u64;
        let max_stride = if max_size_aligned_fits_in_stride && (max_size_aligned as i64) < max_stride_aligned {
            max_size_aligned as i64
        } else {
            max_stride_aligned
        };

        for dimension_count in 1..=u64::from(props.max_tensor_dimension_count) {
            let mut parameters = TensorParameters {
                dimensions: Vec::new(),
                strides: Vec::new(),
            };
            for dim_idx in 0..dimension_count {
                parameters.dimensions.push(1);
                if dim_idx == dimension_count - 1 {
                    parameters.strides.push(element_size_i);
                } else {
                    parameters.strides.push(max_stride);
                }
            }
            max_parameters_list.push(parameters);
        }
    }

    max_parameters_list
}

fn check_support(context: &Context<'_>, format: vk::Format, tiling: vk::TensorTilingARM) -> Result<(), TestError> {
    context.require_device_functionality("VK_ARM_tensors")?;

    if format == vk::Format::R16_SFLOAT_FPENCODING_BFLOAT16_ARM {
        context.require_device_functionality("VK_KHR_shader_bfloat16")?;
    }

    if format == vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM
        || format == vk::Format::R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM
    {
        context.require_device_functionality("VK_EXT_shader_float8")?;
    }

    if !format_support_tensor_flags(context, format, tiling, vk::FormatFeatureFlags2::TENSOR_SHADER_ARM) {
        return Err(TestError::NotSupported("Format not supported".to_string()));
    }
    Ok(())
}

fn iterate(context: &Context<'_>, format: vk::Format, element_size: u64, tiling: vk::TensorTilingARM) -> TestOutcome {
    let parameter_list = get_max_tensor_parameters(context, element_size, tiling);
    let device = context.get_device();

    for parameters in &parameter_list {
        if !format_support_tensor_flags(context, format, tiling, vk::FormatFeatureFlags2::TENSOR_SHADER_ARM) {
            continue;
        }

        let tensor_desc = vk::TensorDescriptionARM {
            tiling,
            format,
            dimension_count: parameters.dimensions.len() as u32,
            dimensions: parameters.dimensions.as_ptr(),
            strides: if parameters.strides.is_empty() {
                std::ptr::null()
            } else {
                parameters.strides.as_ptr()
            },
            usage: vk::TensorUsageFlagsARM::SHADER,
            ..Default::default()
        };
        let tensor_create_info = vk::TensorCreateInfoARM {
            description: &tensor_desc,
            ..Default::default()
        };
        let tensor = unsafe { device.create_tensor_arm(&tensor_create_info, None) }
            .map_err(|e| TestError::Fail(format!("vkCreateTensorARM failed: {e:?}")))?;

        let tensor_req_info = vk::TensorMemoryRequirementsInfoARM {
            tensor,
            ..Default::default()
        };
        let mut mem_req_info = vk::MemoryRequirements2::default();
        unsafe { device.get_tensor_memory_requirements_arm(&tensor_req_info, &mut mem_req_info) };
        unsafe { device.destroy_tensor_arm(tensor, None) };

        if mem_req_info.memory_requirements.memory_type_bits == 0 {
            return Ok(TestStatus::fail("No memory type bits set"));
        }

        if tiling == vk::TensorTilingARM::LINEAR {
            let expected_size: u64 = if parameters.strides.is_empty() {
                parameters.dimensions.iter().map(|&d| d as u64).product::<u64>() * element_size
            } else {
                assert!(parameters.strides[0] > 0);
                parameters.strides[0] as u64 * parameters.dimensions[0] as u64
            };

            if expected_size > mem_req_info.memory_requirements.size {
                return Ok(TestStatus::fail(format!(
                    "Unexpected memory requirement size. Expected {} got {}",
                    expected_size, mem_req_info.memory_requirements.size
                )));
            }
        }
    }

    Ok(TestStatus::pass("Tensor test succeeded"))
}

macro_rules! requirements_cases {
    ($group:ident; $($short:literal => ($format:ident, $size:literal)),+ $(,)?) => {
        $(
            {
                fn linear_check(context: &Context<'_>) -> Result<(), TestError> {
                    check_support(context, vk::Format::$format, vk::TensorTilingARM::LINEAR)
                }
                fn linear_test(context: &Context<'_>) -> TestOutcome {
                    iterate(context, vk::Format::$format, $size, vk::TensorTilingARM::LINEAR)
                }
                fn optimal_check(context: &Context<'_>) -> Result<(), TestError> {
                    check_support(context, vk::Format::$format, vk::TensorTilingARM::OPTIMAL)
                }
                fn optimal_test(context: &Context<'_>) -> TestOutcome {
                    iterate(context, vk::Format::$format, $size, vk::TensorTilingARM::OPTIMAL)
                }
                add_function_case(&mut $group, concat!("linear_", $short), linear_check, linear_test);
                add_function_case(&mut $group, concat!("optimal_", $short), optimal_check, optimal_test);
            }
        )+
    };
}

/// `createTensorCreateRequirementsTests`
pub fn create_tensor_create_requirements_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("creation_and_requirements");
    requirements_cases!(group;
        "R64_UINT" => (R64_UINT, 8),
        "R64_SINT" => (R64_SINT, 8),
        "R32_UINT" => (R32_UINT, 4),
        "R32_SINT" => (R32_SINT, 4),
        "R32_SFLOAT" => (R32_SFLOAT, 4),
        "R16_UINT" => (R16_UINT, 2),
        "R16_SINT" => (R16_SINT, 2),
        "R16_SFLOAT" => (R16_SFLOAT, 2),
        "R8_UINT" => (R8_UINT, 1),
        "R8_SINT" => (R8_SINT, 1),
        "R8_BOOL" => (R8_BOOL_ARM, 1),
        "R8_SFLOAT_FPENCODING_FLOAT8E5M2" => (R8_SFLOAT_FPENCODING_FLOAT8E5M2_ARM, 1),
        "R8_SFLOAT_FPENCODING_FLOAT8E4M3" => (R8_SFLOAT_FPENCODING_FLOAT8E4M3_ARM, 1),
        "R16_SFLOAT_FPENCODING_BFLOAT16" => (R16_SFLOAT_FPENCODING_BFLOAT16_ARM, 2),
    );
    group
}
