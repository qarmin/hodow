// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorRequired.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::tests::api::case_util::add_function_case;
use crate::vkt::{Context, TestCaseGroup};

pub(super) fn get_tensor_physical_device_properties(context: &Context<'_>) -> vk::PhysicalDeviceTensorPropertiesARM {
    let mut properties = vk::PhysicalDeviceTensorPropertiesARM::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };
    }
    properties
}

pub(super) fn get_tensor_physical_device_features(context: &Context<'_>) -> vk::PhysicalDeviceTensorFeaturesARM {
    let mut features = vk::PhysicalDeviceTensorFeaturesARM::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}

fn check_required(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_ARM_tensors")
}

fn fail(message: &str) -> TestOutcome {
    Ok(TestStatus::fail(message))
}

fn test_required_limits(context: &Context<'_>) -> TestOutcome {
    let props = get_tensor_physical_device_properties(context);
    let features = get_tensor_physical_device_features(context);

    if props.max_tensor_dimension_count < 4 {
        return fail("VkPhysicalDeviceTensorPropertiesARM::maxTensorDimensionCount < 4");
    }
    if props.max_tensor_elements < 65536 {
        return fail("VkPhysicalDeviceTensorPropertiesARM::maxTensorElements < 65536");
    }
    if props.max_per_dimension_tensor_elements < 65536 {
        return fail("VkPhysicalDeviceTensorPropertiesARM::maxPerDimensionTensorElements < 65536");
    }
    if props.max_tensor_stride < 65536 {
        return fail("VkPhysicalDeviceTensorPropertiesARM::maxTensorStride < 65536");
    }
    if props.max_tensor_size < 65536 {
        return fail("VkPhysicalDeviceTensorPropertiesARM::maxTensorSize < 65536");
    }
    if props.max_descriptor_set_storage_tensors < 16 {
        return fail("VkPhysicalDeviceTensorPropertiesARM::maxDescriptorSetStorageTensors < 16");
    }

    let update_after_bind = features.descriptor_binding_storage_tensor_update_after_bind != vk::FALSE;
    let shader_access = features.shader_tensor_access != vk::FALSE;

    if update_after_bind && props.max_descriptor_set_update_after_bind_storage_tensors < 500000 {
        return fail("VkPhysicalDeviceTensorPropertiesARM::maxDescriptorSetUpdateAfterBindStorageTensors < 500000");
    }
    if update_after_bind && shader_access && props.max_per_stage_descriptor_update_after_bind_storage_tensors < 500000 {
        return fail(
            "VkPhysicalDeviceTensorPropertiesARM::maxPerStageDescriptorUpdateAfterBindStorageTensors < 500000",
        );
    }
    if shader_access {
        if !props
            .shader_tensor_supported_stages
            .contains(vk::ShaderStageFlags::COMPUTE)
        {
            return fail(
                "VkPhysicalDeviceTensorPropertiesARM::shaderTensorSupportedStages does not have VK_SHADER_STAGE_COMPUTE_BIT set",
            );
        }
        if props.max_tensor_shader_access_array_length < 4 {
            return fail("VkPhysicalDeviceTensorPropertiesARM::maxTensorShaderAccessArrayLength < 4");
        }
        if props.max_tensor_shader_access_size < 4 {
            return fail("VkPhysicalDeviceTensorPropertiesARM::maxTensorShaderAccessSize < 4");
        }
        if props.max_per_stage_descriptor_set_storage_tensors < 16 {
            return fail("VkPhysicalDeviceTensorPropertiesARM::maxPerStageDescriptorSetStorageTensors < 16");
        }
    }

    Ok(TestStatus::pass("Success"))
}

fn test_required_features(context: &Context<'_>) -> TestOutcome {
    let features = get_tensor_physical_device_features(context);
    if features.tensors == vk::FALSE {
        return fail("Required feature VkPhysicalDeviceTensorFeaturesARM::tensors is not supported");
    }
    Ok(TestStatus::pass("Success"))
}

/// `createTensorRequired`
pub fn create_tensor_required() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("required");
    add_function_case(&mut group, "limits", check_required, test_required_limits);
    add_function_case(&mut group, "features", check_required, test_required_features);
    group
}
