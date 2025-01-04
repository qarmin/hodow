// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The VK_NV_mesh_shader check is ported beside the EXT one; the
// build options helpers (the manifest sets the SPIR-V version) have no counterpart here.

#![allow(dead_code)]

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::TestError;
use crate::vkt::Context;

/// `FragmentSize`: the primitive shading rate cases.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum FragmentSize {
    Size2x2 = 0,
    Size2x1 = 1,
    Size1x1 = 2,
}

/// `FragmentSize::SIZE_COUNT`
pub const FRAGMENT_SIZE_COUNT: usize = 3;

impl FragmentSize {
    pub const ALL: [FragmentSize; FRAGMENT_SIZE_COUNT] =
        [FragmentSize::Size2x2, FragmentSize::Size2x1, FragmentSize::Size1x1];
}

/// `getShadingRateSize`
pub fn get_shading_rate_size(fragment_size: FragmentSize) -> vk::Extent2D {
    match fragment_size {
        FragmentSize::Size2x2 => vk::Extent2D { width: 2, height: 2 },
        FragmentSize::Size2x1 => vk::Extent2D { width: 2, height: 1 },
        FragmentSize::Size1x1 => vk::Extent2D { width: 1, height: 1 },
    }
}

/// `getBadShadingRateSize`: a shading rate size that does not match any of the given fragment sizes.
pub fn get_bad_shading_rate_size(sizes: &[FragmentSize]) -> FragmentSize {
    FragmentSize::ALL
        .into_iter()
        .find(|fs| !sizes.contains(fs))
        .expect("a fragment size is left out")
}

/// `getGLSLShadingRateMask`
pub fn get_glsl_shading_rate_mask(fragment_size: FragmentSize) -> &'static str {
    match fragment_size {
        FragmentSize::Size2x2 => "(gl_ShadingRateFlag2HorizontalPixelsEXT|gl_ShadingRateFlag2VerticalPixelsEXT)",
        FragmentSize::Size2x1 => "gl_ShadingRateFlag2HorizontalPixelsEXT",
        FragmentSize::Size1x1 => "0",
    }
}

/// `getSPVShadingRateValue`
pub fn get_spv_shading_rate_value(fragment_size: FragmentSize) -> i32 {
    // gl_ShadingRateFlag2VerticalPixelsEXT = 1, gl_ShadingRateFlag4VerticalPixelsEXT = 2,
    // gl_ShadingRateFlag2HorizontalPixelsEXT = 4, gl_ShadingRateFlag4HorizontalPixelsEXT = 8
    match fragment_size {
        FragmentSize::Size2x2 => 5,
        FragmentSize::Size2x1 => 4,
        FragmentSize::Size1x1 => 0,
    }
}

/// `Context::getMeshShaderFeaturesEXT`
pub fn mesh_shader_features(context: &Context<'_>) -> vk::PhysicalDeviceMeshShaderFeaturesEXT {
    let mut features = vk::PhysicalDeviceMeshShaderFeaturesEXT::default();
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

/// `Context::getMeshShaderPropertiesEXT`
pub fn mesh_shader_properties(context: &Context<'_>) -> vk::PhysicalDeviceMeshShaderPropertiesEXT {
    let mut properties = vk::PhysicalDeviceMeshShaderPropertiesEXT::default();
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

/// `checkTaskMeshShaderSupportEXT`
pub fn check_task_mesh_shader_support_ext(
    context: &Context<'_>,
    require_task: bool,
    require_mesh: bool,
) -> Result<(), TestError> {
    context.require_device_functionality("VK_EXT_mesh_shader")?;

    debug_assert!(require_task || require_mesh);

    let mesh_features = mesh_shader_features(context);

    if require_task && mesh_features.task_shader == vk::FALSE {
        return Err(TestError::NotSupported("Task shader not supported".to_string()));
    }

    if require_mesh && mesh_features.mesh_shader == vk::FALSE {
        return Err(TestError::NotSupported("Mesh shader not supported".to_string()));
    }

    Ok(())
}

/// `Context::getMeshShaderFeatures`
pub fn mesh_shader_features_nv(context: &Context<'_>) -> vk::PhysicalDeviceMeshShaderFeaturesNV {
    let mut features = vk::PhysicalDeviceMeshShaderFeaturesNV::default();
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

/// `Context::getMeshShaderProperties`
pub fn mesh_shader_properties_nv(context: &Context<'_>) -> vk::PhysicalDeviceMeshShaderPropertiesNV {
    let mut properties = vk::PhysicalDeviceMeshShaderPropertiesNV::default();
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

/// `checkTaskMeshShaderSupportNV`
pub fn check_task_mesh_shader_support_nv(
    context: &Context<'_>,
    require_task: bool,
    require_mesh: bool,
) -> Result<(), TestError> {
    context.require_device_functionality("VK_NV_mesh_shader")?;

    debug_assert!(require_task || require_mesh);

    let mesh_features = mesh_shader_features_nv(context);

    if require_task && mesh_features.task_shader == vk::FALSE {
        return Err(TestError::NotSupported("Task shader not supported".to_string()));
    }

    if require_mesh && mesh_features.mesh_shader == vk::FALSE {
        return Err(TestError::NotSupported("Mesh shader not supported".to_string()));
    }

    Ok(())
}
