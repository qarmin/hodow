// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectApiTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. No shaders.

use std::ffi::{CStr, CString};

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::programs::BinaryCollection;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum ShaderObjectApiTest {
    ExtDiscardRectangles,
    NvScissorExclusive,
    KhrDynamicRendering,
    ShaderBinaryUuid,
}

struct DeviceGuard(Device);

impl Drop for DeviceGuard {
    fn drop(&mut self) {
        unsafe { self.0.destroy_device(None) };
    }
}

const FUNCTIONS: &[&str] = &[
    // VK_EXT_extended_dynamic_state
    "vkCmdBindVertexBuffers2EXT",
    "vkCmdSetCullModeEXT",
    "vkCmdSetDepthBoundsTestEnableEXT",
    "vkCmdSetDepthCompareOpEXT",
    "vkCmdSetDepthTestEnableEXT",
    "vkCmdSetDepthWriteEnableEXT",
    "vkCmdSetFrontFaceEXT",
    "vkCmdSetPrimitiveTopologyEXT",
    "vkCmdSetScissorWithCountEXT",
    "vkCmdSetStencilOpEXT",
    "vkCmdSetStencilTestEnableEXT",
    "vkCmdSetViewportWithCountEXT",
    // VK_EXT_extended_dynamic_state2
    "vkCmdSetDepthBiasEnableEXT",
    "vkCmdSetLogicOpEXT",
    "vkCmdSetPatchControlPointsEXT",
    "vkCmdSetPrimitiveRestartEnableEXT",
    "vkCmdSetRasterizerDiscardEnableEXT",
    // VK_EXT_extended_dynamic_state3
    "vkCmdSetAlphaToCoverageEnableEXT",
    "vkCmdSetAlphaToOneEnableEXT",
    "vkCmdSetColorBlendAdvancedEXT",
    "vkCmdSetColorBlendEnableEXT",
    "vkCmdSetColorBlendEquationEXT",
    "vkCmdSetColorWriteMaskEXT",
    "vkCmdSetConservativeRasterizationModeEXT",
    "vkCmdSetCoverageModulationModeNV",
    "vkCmdSetCoverageModulationTableEnableNV",
    "vkCmdSetCoverageModulationTableNV",
    "vkCmdSetCoverageReductionModeNV",
    "vkCmdSetCoverageToColorEnableNV",
    "vkCmdSetCoverageToColorLocationNV",
    "vkCmdSetDepthClampEnableEXT",
    "vkCmdSetDepthClipEnableEXT",
    "vkCmdSetDepthClipNegativeOneToOneEXT",
    "vkCmdSetExtraPrimitiveOverestimationSizeEXT",
    "vkCmdSetLineRasterizationModeEXT",
    "vkCmdSetLineStippleEnableEXT",
    "vkCmdSetLogicOpEnableEXT",
    "vkCmdSetPolygonModeEXT",
    "vkCmdSetProvokingVertexModeEXT",
    "vkCmdSetRasterizationSamplesEXT",
    "vkCmdSetRasterizationStreamEXT",
    "vkCmdSetRepresentativeFragmentTestEnableNV",
    "vkCmdSetSampleLocationsEnableEXT",
    "vkCmdSetSampleMaskEXT",
    "vkCmdSetShadingRateImageEnableNV",
    "vkCmdSetTessellationDomainOriginEXT",
    "vkCmdSetViewportSwizzleNV",
    "vkCmdSetViewportWScalingEnableNV",
    // VK_EXT_vertex_input_dynamic_state
    "vkCmdSetVertexInputEXT",
];

/// `ShaderObjectApiInstance::iterate`
fn run_get_device_proc_addr(context: &Context<'_>) -> TestOutcome {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let queue_priority = [1.0f32];
    let queue_infos = [vk::DeviceQueueCreateInfo::builder()
        .queue_family_index(context.get_universal_queue_family_index())
        .queue_priorities(&queue_priority)
        .build()];

    let extensions = [c"VK_EXT_shader_object".as_ptr()];

    let mut shader_object_features = vk::PhysicalDeviceShaderObjectFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut shader_object_features);
    unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };

    let device_info = vk::DeviceCreateInfo::builder()
        .queue_create_infos(&queue_infos)
        .enabled_extension_names(&extensions)
        .push_next(&mut features2);
    let device =
        DeviceGuard(unsafe { instance.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?);

    for function in FUNCTIONS {
        let name = CString::new(*function).expect("function names have no interior NUL");
        if unsafe { instance.get_device_proc_addr(device.0.handle(), &name) }.is_none() {
            return Ok(TestStatus::fail(format!("Failed: {function}")));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectApiCase;

impl TestCase for ShaderObjectApiCase {
    fn name(&self) -> &str {
        "get_device_proc_addr"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectApiInstance { context })
    }
}

struct ShaderObjectApiInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for ShaderObjectApiInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_get_device_proc_addr(self.context)
    }
}

/// `ShaderObjectExtensionVersionInstance::iterate`
fn run_extension_version(context: &Context<'_>, test: ShaderObjectApiTest) -> TestOutcome {
    let instance = context.get_instance();
    let physical_device = context.get_physical_device();

    let mut shader_object_properties = vk::PhysicalDeviceShaderObjectPropertiesEXT::default();
    {
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut shader_object_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
    }

    let device_extension_properties = unsafe { instance.enumerate_device_extension_properties(physical_device, None) }
        .vk_check("vkEnumerateDeviceExtensionProperties")?;
    let extension_name = |ext: &vk::ExtensionProperties| {
        unsafe { CStr::from_ptr(ext.extension_name.as_ptr()) }
            .to_string_lossy()
            .into_owned()
    };

    if test == ShaderObjectApiTest::ShaderBinaryUuid {
        let non_zero = shader_object_properties
            .shader_binary_uuid
            .0
            .iter()
            .any(|&byte| byte != 0);
        if !non_zero {
            log::info!("All shaderBinaryUUID bytes are 0");
            return Ok(TestStatus::fail("Fail"));
        }
    } else if test == ShaderObjectApiTest::KhrDynamicRendering {
        let (major, minor, _) = context.api_version();
        if major == 1 && minor < 3 {
            let found = device_extension_properties
                .iter()
                .any(|ext| extension_name(ext) == "VK_KHR_dynamic_rendering");
            if !found {
                log::info!(
                    "VK_EXT_shader_object is supported, but vulkan version is < 1.3 and VK_KHR_dynamic_rendering is not supported"
                );
                return Ok(TestStatus::fail("Fail"));
            }
        }
    } else {
        for ext in &device_extension_properties {
            let name = extension_name(ext);
            if test == ShaderObjectApiTest::ExtDiscardRectangles {
                if name == "VK_EXT_discard_rectangles" {
                    if ext.spec_version < 2 {
                        log::info!(
                            "VK_EXT_shader_object and VK_EXT_discard_rectangles are supported, but VK_EXT_discard_rectangles reports version {}",
                            ext.spec_version
                        );
                        return Ok(TestStatus::fail("Fail"));
                    }
                    break;
                }
            } else if test == ShaderObjectApiTest::NvScissorExclusive && name == "VK_NV_scissor_exclusive" {
                if ext.spec_version < 2 {
                    log::info!(
                        "VK_EXT_shader_object and VK_NV_scissor_exclusive are supported, but VK_NV_scissor_exclusive reports version {}",
                        ext.spec_version
                    );
                    return Ok(TestStatus::fail("Fail"));
                }
                break;
            }
        }
    }
    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectExtensionVersionCase {
    name: &'static str,
    test: ShaderObjectApiTest,
}

impl TestCase for ShaderObjectExtensionVersionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;
        if self.test == ShaderObjectApiTest::ExtDiscardRectangles {
            context.require_device_functionality("VK_EXT_discard_rectangles")?;
        } else if self.test == ShaderObjectApiTest::NvScissorExclusive {
            context.require_device_functionality("VK_NV_scissor_exclusive")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectExtensionVersionInstance {
            context,
            test: self.test,
        })
    }
}

struct ShaderObjectExtensionVersionInstance<'a> {
    context: &'a Context<'a>,
    test: ShaderObjectApiTest,
}

impl TestInstance for ShaderObjectExtensionVersionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_extension_version(self.context, self.test)
    }
}

/// `createShaderObjectApiTests`
pub fn create_shader_object_api_tests() -> TestCaseGroup {
    let mut api_group = TestCaseGroup::new("api");
    api_group.add_child(Box::new(ShaderObjectApiCase) as Box<dyn TestCase>);

    let api_tests = [
        (ShaderObjectApiTest::ExtDiscardRectangles, "discard_rectangles"),
        (ShaderObjectApiTest::NvScissorExclusive, "scissor_exclusive"),
        (ShaderObjectApiTest::KhrDynamicRendering, "dynamic_rendering"),
        (ShaderObjectApiTest::ShaderBinaryUuid, "shader_binary_uuid"),
    ];

    for (test, name) in api_tests {
        api_group.add_child(Box::new(ShaderObjectExtensionVersionCase { name, test }) as Box<dyn TestCase>);
    }
    api_group
}
