// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorRequiredFormats.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. TestParams is a macro argument list because the case bodies are plain fn pointers.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::tests::api::case_util::add_function_case;
use crate::vkt::{Context, TestCaseGroup};

fn check_required_format_features(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_ARM_tensors")
}

pub(super) fn get_tensor_format_properties(context: &Context<'_>, format: vk::Format) -> vk::TensorFormatPropertiesARM {
    let mut tensor_props = vk::TensorFormatPropertiesARM::default();
    {
        let mut props2 = vk::FormatProperties2::builder().push_next(&mut tensor_props);
        unsafe {
            context.get_instance().get_physical_device_format_properties2(
                context.get_physical_device(),
                format,
                &mut props2,
            )
        };
    }
    tensor_props
}

fn test_required_format_features(
    context: &Context<'_>,
    format: vk::Format,
    linear_tiling_features: vk::FormatFeatureFlags2,
    optimal_tiling_features: vk::FormatFeatureFlags2,
) -> TestOutcome {
    let format_properties = get_tensor_format_properties(context, format);

    let has_required_linear_tiling_features =
        format_properties.linear_tiling_tensor_features & linear_tiling_features == linear_tiling_features;
    let has_required_optimal_tiling_features =
        format_properties.optimal_tiling_tensor_features & optimal_tiling_features == optimal_tiling_features;

    if !has_required_linear_tiling_features || !has_required_optimal_tiling_features {
        return Ok(TestStatus::fail(
            "Supported features do not contain all required features",
        ));
    }

    Ok(TestStatus::pass("Success"))
}

macro_rules! required_formats {
    ($group:ident; $($name:literal => $format:ident),+ $(,)?) => {
        $(
            {
                fn test(context: &Context<'_>) -> TestOutcome {
                    test_required_format_features(
                        context,
                        vk::Format::$format,
                        vk::FormatFeatureFlags2::empty(),
                        vk::FormatFeatureFlags2::empty(),
                    )
                }
                add_function_case(&mut $group, $name, check_required_format_features, test);
            }
        )+
    };
}

/// `createTensorRequiredFormatsTests`
pub fn create_tensor_required_formats_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("required_formats");
    required_formats!(group;
        "VK_FORMAT_UNDEFINED" => UNDEFINED,
        "VK_FORMAT_R8_BOOL_ARM" => R8_BOOL_ARM,
        "VK_FORMAT_R8_UNORM" => R8_UNORM,
        "VK_FORMAT_R8_SNORM" => R8_SNORM,
        "VK_FORMAT_R8_USCALED" => R8_USCALED,
        "VK_FORMAT_R8_SSCALED" => R8_SSCALED,
        "VK_FORMAT_R8_UINT" => R8_UINT,
        "VK_FORMAT_R8_SINT" => R8_SINT,
        "VK_FORMAT_R16_UNORM" => R16_UNORM,
        "VK_FORMAT_R16_SNORM" => R16_SNORM,
        "VK_FORMAT_R16_USCALED" => R16_USCALED,
        "VK_FORMAT_R16_SSCALED" => R16_SSCALED,
        "VK_FORMAT_R16_UINT" => R16_UINT,
        "VK_FORMAT_R16_SINT" => R16_SINT,
        "VK_FORMAT_R16_SFLOAT" => R16_SFLOAT,
        "VK_FORMAT_R32_UINT" => R32_UINT,
        "VK_FORMAT_R32_SINT" => R32_SINT,
        "VK_FORMAT_R32_SFLOAT" => R32_SFLOAT,
        "VK_FORMAT_R64_UINT" => R64_UINT,
        "VK_FORMAT_R64_SINT" => R64_SINT,
        "VK_FORMAT_R64_SFLOAT" => R64_SFLOAT,
    );
    group
}
