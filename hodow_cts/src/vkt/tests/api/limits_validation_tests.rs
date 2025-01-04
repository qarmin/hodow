// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiFeatureInfo.cpp
//   (validateLimit, validateLimits14, validateLimitsKhrMaintenance4,
//    validateLimitsMaxInlineUniformTotalSize, validateSubgroupFeatures)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported out of `dEQP-VK.api.info.*`:
//   vulkan1p3_limits_validation.{khr_maintenance4, max_inline_uniform_total_size}
//   vulkan1p4_limits_validation.general
//   subgroup_features.flags
//
// Upstream's `FeatureLimitTableItem` is a pointer into a property struct plus a tagged value; here each item
// carries the reported value already read, which is the same comparison without the raw `*(T *)ptr`.
// `maxInlineUniformTotalSize` is a uint32 that upstream reads through a `uint64_t *` as a DEVICE_SIZE limit, so
// its comparison also sees the following struct member in the high half. The 256 minimum is compared on the
// 32-bit field alone here.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::add_function_case;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::{Context, TestCaseGroup};

fn api_version_at_least(context: &Context<'_>, major: u32, minor: u32) -> bool {
    let version = context.get_device_properties().api_version;
    (vk::version_major(version), vk::version_minor(version)) >= (major, minor)
}

/// `checkApiVersionSupport<MAJOR, MINOR>`
pub(super) fn require_api_version(context: &Context<'_>, major: u32, minor: u32) -> Result<(), TestError> {
    if !api_version_at_least(context, major, minor) {
        return Err(TestError::NotSupported(format!(
            "At least Vulkan {major}.{minor} required to run test"
        )));
    }
    Ok(())
}

fn check_support_api_1_4(context: &Context<'_>) -> Result<(), TestError> {
    require_api_version(context, 1, 4)
}

fn check_support_api_1_3(context: &Context<'_>) -> Result<(), TestError> {
    require_api_version(context, 1, 3)
}

fn check_support_khr_maintenance4(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_maintenance4")
}

/// One line of `featureLimitTable`: the reported value, the bound it is held to, and the condition that arms it.
pub(super) enum Bound {
    MinI32 {
        reported: i32,
        limit: i32,
    },
    MaxI32 {
        reported: i32,
        limit: i32,
    },
    MinU32 {
        reported: u32,
        limit: u32,
    },
    #[allow(dead_code)]
    MaxU32 {
        reported: u32,
        limit: u32,
    },
    MinDeviceSize {
        reported: u64,
        limit: u64,
    },
    MaxDeviceSize {
        reported: u64,
        limit: u64,
    },
    MinFloat {
        reported: f32,
        limit: f32,
    },
    MaxFloat {
        reported: f32,
        limit: f32,
    },
    MinBits {
        reported: u32,
        limit: u32,
    },
}

pub(super) struct LimitItem {
    cond: bool,
    cond_name: &'static str,
    name: &'static str,
    bound: Bound,
}

pub(super) fn item(cond: bool, cond_name: &'static str, name: &'static str, bound: Bound) -> LimitItem {
    LimitItem {
        cond,
        cond_name,
        name,
        bound,
    }
}

fn validate_numeric_limit<T: PartialOrd + std::fmt::Display>(limit: T, reported: T, is_min: bool, name: &str) -> bool {
    if is_min {
        if reported < limit {
            log::info!("Limit validation failed {name} reported value is {reported} expected MIN {limit}");
            return false;
        }
        log::info!("{name}={reported} (>={limit})");
    } else {
        if reported > limit {
            log::info!("Limit validation failed {name} reported value is {reported} expected MAX {limit}");
            return false;
        }
        log::info!("{name}={reported} (<={limit})");
    }
    true
}

/// `validateLimit`
fn validate_limit(limit: &LimitItem) -> bool {
    if !limit.cond {
        log::info!(
            "Limit validation skipped '{}' due to {} == VK_FALSE'",
            limit.name,
            limit.cond_name
        );
        return true;
    }

    match limit.bound {
        Bound::MinI32 { reported, limit: bound } => validate_numeric_limit(bound, reported, true, limit.name),
        Bound::MaxI32 { reported, limit: bound } => validate_numeric_limit(bound, reported, false, limit.name),
        Bound::MinU32 { reported, limit: bound } => validate_numeric_limit(bound, reported, true, limit.name),
        Bound::MaxU32 { reported, limit: bound } => validate_numeric_limit(bound, reported, false, limit.name),
        Bound::MinDeviceSize { reported, limit: bound } => validate_numeric_limit(bound, reported, true, limit.name),
        Bound::MaxDeviceSize { reported, limit: bound } => validate_numeric_limit(bound, reported, false, limit.name),
        Bound::MinFloat { reported, limit: bound } => validate_numeric_limit(bound, reported, true, limit.name),
        Bound::MaxFloat { reported, limit: bound } => validate_numeric_limit(bound, reported, false, limit.name),
        Bound::MinBits { reported, limit: bound } => {
            if reported & bound != bound {
                log::info!(
                    "Limit validation failed {} reported value is {reported} expected MIN {bound}",
                    limit.name
                );
                return false;
            }
            log::info!("{}={reported:#x} (contains {bound:#x})", limit.name);
            true
        }
    }
}

pub(super) fn validate_all(items: &[LimitItem]) -> TestOutcome {
    let mut limits_ok = true;
    for entry in items {
        limits_ok = validate_limit(entry) && limits_ok;
    }

    if limits_ok {
        Ok(TestStatus::pass("pass"))
    } else {
        Ok(TestStatus::fail("fail"))
    }
}

pub(super) fn get_vulkan11_properties(context: &Context<'_>) -> vk::PhysicalDeviceVulkan11Properties {
    let mut properties = vk::PhysicalDeviceVulkan11Properties::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    properties
}

pub(super) fn get_vulkan12_properties(context: &Context<'_>) -> vk::PhysicalDeviceVulkan12Properties {
    let mut properties = vk::PhysicalDeviceVulkan12Properties::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    properties
}

pub(super) fn get_vulkan12_features(context: &Context<'_>) -> vk::PhysicalDeviceVulkan12Features {
    let mut features = vk::PhysicalDeviceVulkan12Features::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    features
}

/// `validateLimitsKhrMaintenance4`
fn validate_limits_khr_maintenance4(context: &Context<'_>) -> TestOutcome {
    let mut maintenance4 = vk::PhysicalDeviceMaintenance4Properties::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut maintenance4);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };

    validate_all(&[item(
        true,
        "checkAlways",
        "maintenance4Properties.maxBufferSize",
        Bound::MinDeviceSize {
            reported: maintenance4.max_buffer_size,
            limit: 1 << 30,
        },
    )])
}

/// `validateLimitsMaxInlineUniformTotalSize`
fn validate_limits_max_inline_uniform_total_size(context: &Context<'_>) -> TestOutcome {
    let mut vulkan13 = vk::PhysicalDeviceVulkan13Properties::default();
    let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut vulkan13);
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };

    validate_all(&[item(
        true,
        "checkAlways",
        "vulkan13Properties.maxInlineUniformTotalSize",
        Bound::MinU32 {
            reported: vulkan13.max_inline_uniform_total_size,
            limit: 256,
        },
    )])
}

/// `validateLimits14`
fn validate_limits14(context: &Context<'_>) -> TestOutcome {
    let features = *context.get_device_features();
    let vk11_properties = get_vulkan11_properties(context);
    let vk12_properties = get_vulkan12_properties(context);
    let vk12_features = get_vulkan12_features(context);

    let mut properties2 = vk::PhysicalDeviceProperties2::default();
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    let limits = properties2.properties.limits;

    let check_shader_szin_preserve = vk11_properties.subgroup_size > 1;
    let check_shader_szin_preserve_f16 = check_shader_szin_preserve && vk12_features.shader_float16 != vk::FALSE;
    let large_points = features.large_points != vk::FALSE;
    let wide_lines = features.wide_lines != vk::FALSE;

    let subgroup_supported_stages = vk::ShaderStageFlags::COMPUTE | vk::ShaderStageFlags::FRAGMENT;
    let mut subgroup_feature_flags = vk::SubgroupFeatureFlags::BASIC
        | vk::SubgroupFeatureFlags::VOTE
        | vk::SubgroupFeatureFlags::ARITHMETIC
        | vk::SubgroupFeatureFlags::BALLOT
        | vk::SubgroupFeatureFlags::SHUFFLE
        | vk::SubgroupFeatureFlags::SHUFFLE_RELATIVE;
    if vk11_properties.subgroup_size > 3 {
        subgroup_feature_flags |= vk::SubgroupFeatureFlags::QUAD;
    }

    let always = |name: &'static str, bound: Bound| item(true, "checkAlways", name, bound);
    let min_u32 = |reported: u32, limit: u32| Bound::MinU32 { reported, limit };
    let min_f32 = |reported: f32, limit: f32| Bound::MinFloat { reported, limit };
    let max_f32 = |reported: f32, limit: f32| Bound::MaxFloat { reported, limit };

    let table = vec![
        always(
            "limits.maxImageDimension1D",
            min_u32(limits.max_image_dimension_1d, 8192),
        ),
        always(
            "limits.maxImageDimension2D",
            min_u32(limits.max_image_dimension_2d, 8192),
        ),
        always(
            "limits.maxImageDimension3D",
            min_u32(limits.max_image_dimension_3d, 512),
        ),
        always(
            "limits.maxImageDimensionCube",
            min_u32(limits.max_image_dimension_cube, 8192),
        ),
        always(
            "limits.maxImageArrayLayers",
            min_u32(limits.max_image_array_layers, 2048),
        ),
        always(
            "limits.maxUniformBufferRange",
            min_u32(limits.max_uniform_buffer_range, 65536),
        ),
        always(
            "limits.maxPushConstantsSize",
            min_u32(limits.max_push_constants_size, 256),
        ),
        always(
            "limits.bufferImageGranularity",
            Bound::MinDeviceSize {
                reported: limits.buffer_image_granularity,
                limit: 1,
            },
        ),
        always(
            "limits.bufferImageGranularity",
            Bound::MaxDeviceSize {
                reported: limits.buffer_image_granularity,
                limit: 4096,
            },
        ),
        always(
            "limits.maxBoundDescriptorSets",
            min_u32(limits.max_bound_descriptor_sets, 7),
        ),
        always(
            "limits.maxPerStageDescriptorUniformBuffers",
            min_u32(limits.max_per_stage_descriptor_uniform_buffers, 15),
        ),
        always(
            "limits.maxPerStageResources",
            min_u32(limits.max_per_stage_resources, 200),
        ),
        always(
            "limits.maxDescriptorSetUniformBuffers",
            min_u32(limits.max_descriptor_set_uniform_buffers, 90),
        ),
        always(
            "limits.maxDescriptorSetStorageBuffers",
            min_u32(limits.max_descriptor_set_storage_buffers, 96),
        ),
        always(
            "limits.maxDescriptorSetStorageImages",
            min_u32(limits.max_descriptor_set_storage_images, 144),
        ),
        always(
            "limits.maxFragmentCombinedOutputResources",
            min_u32(limits.max_fragment_combined_output_resources, 16),
        ),
        always(
            "limits.maxComputeWorkGroupInvocations",
            min_u32(limits.max_compute_work_group_invocations, 256),
        ),
        always(
            "limits.maxComputeWorkGroupSize[0]",
            min_u32(limits.max_compute_work_group_size[0], 256),
        ),
        always(
            "limits.maxComputeWorkGroupSize[1]",
            min_u32(limits.max_compute_work_group_size[1], 256),
        ),
        always(
            "limits.maxComputeWorkGroupSize[2]",
            min_u32(limits.max_compute_work_group_size[2], 64),
        ),
        always(
            "limits.subTexelPrecisionBits",
            min_u32(limits.sub_texel_precision_bits, 8),
        ),
        always("limits.mipmapPrecisionBits", min_u32(limits.mipmap_precision_bits, 6)),
        always("limits.maxSamplerLodBias", min_f32(limits.max_sampler_lod_bias, 14.0)),
        always(
            "limits.maxViewportDimensions[0]",
            min_u32(limits.max_viewport_dimensions[0], 7680),
        ),
        always(
            "limits.maxViewportDimensions[1]",
            min_u32(limits.max_viewport_dimensions[1], 7680),
        ),
        always(
            "limits.viewportBoundsRange[0]",
            max_f32(limits.viewport_bounds_range[0], -15360.0),
        ),
        always(
            "limits.viewportBoundsRange[1]",
            min_f32(limits.viewport_bounds_range[1], 15359.0),
        ),
        always(
            "limits.maxFramebufferWidth",
            min_u32(limits.max_framebuffer_width, 7680),
        ),
        always(
            "limits.maxFramebufferHeight",
            min_u32(limits.max_framebuffer_height, 7680),
        ),
        always("limits.maxColorAttachments", min_u32(limits.max_color_attachments, 8)),
        always(
            "limits.timestampComputeAndGraphics",
            min_u32(limits.timestamp_compute_and_graphics, 1),
        ),
        always(
            "limits.standardSampleLocations",
            min_u32(limits.standard_sample_locations, 1),
        ),
        item(
            large_points,
            "features.largePoints",
            "limits.pointSizeRange[0]",
            min_f32(limits.point_size_range[0], 0.0),
        ),
        item(
            large_points,
            "features.largePoints",
            "limits.pointSizeRange[0]",
            max_f32(limits.point_size_range[0], 1.0),
        ),
        item(
            large_points,
            "features.largePoints",
            "limits.pointSizeRange[1]",
            min_f32(limits.point_size_range[1], 256.0 - limits.point_size_granularity),
        ),
        item(
            large_points,
            "features.largePoints",
            "limits.pointSizeGranularity",
            min_f32(limits.point_size_granularity, 0.0),
        ),
        item(
            large_points,
            "features.largePoints",
            "limits.pointSizeGranularity",
            max_f32(limits.point_size_granularity, 0.125),
        ),
        item(
            wide_lines,
            "features.wideLines",
            "limits.lineWidthGranularity",
            min_f32(limits.line_width_granularity, 0.0),
        ),
        item(
            wide_lines,
            "features.wideLines",
            "limits.lineWidthGranularity",
            max_f32(limits.line_width_granularity, 0.5),
        ),
        always(
            "vk11Properties.subgroupSupportedStages",
            min_u32(
                vk11_properties.subgroup_supported_stages.bits(),
                subgroup_supported_stages.bits(),
            ),
        ),
        always(
            "vk11Properties.subgroupSupportedOperations",
            min_u32(
                vk11_properties.subgroup_supported_operations.bits(),
                subgroup_feature_flags.bits(),
            ),
        ),
        item(
            check_shader_szin_preserve_f16,
            "checkShaderSZINPreserveF16",
            "vk12Properties.shaderSignedZeroInfNanPreserveFloat16",
            min_u32(vk12_properties.shader_signed_zero_inf_nan_preserve_float16, 1),
        ),
        item(
            check_shader_szin_preserve,
            "checkShaderSZINPreserve",
            "vk12Properties.shaderSignedZeroInfNanPreserveFloat32",
            min_u32(vk12_properties.shader_signed_zero_inf_nan_preserve_float32, 1),
        ),
    ];

    log::info!("{limits:?}");

    validate_all(&table)
}

/// `validateSubgroupFeatures`
fn validate_subgroup_features(context: &Context<'_>) -> TestOutcome {
    let vk11_properties = get_vulkan11_properties(context);

    let mut partitioned = vk::PhysicalDeviceShaderSubgroupPartitionedFeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut partitioned);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };

    if partitioned.shader_subgroup_partitioned != vk::FALSE
        && !vk11_properties
            .subgroup_supported_operations
            .contains(vk::SubgroupFeatureFlags::PARTITIONED_EXT)
    {
        return Err(TestError::Fail(
            "VK_SUBGROUP_FEATURE_PARTITIONED_BIT_EXT not supported".to_string(),
        ));
    }

    Ok(TestStatus::pass("pass"))
}

/// The three `info` children this file contributes; `createFeatureInfoTests` registers them between
/// `get_physical_device_properties2` and `image_format_properties2` (limits) and after `profiles` (subgroups).
pub fn add_limits_validation_groups(info_tests: &mut TestCaseGroup) {
    let mut limits13 = TestCaseGroup::new("vulkan1p3_limits_validation");
    add_function_case(
        &mut limits13,
        "khr_maintenance4",
        check_support_khr_maintenance4,
        validate_limits_khr_maintenance4,
    );
    add_function_case(
        &mut limits13,
        "max_inline_uniform_total_size",
        check_support_api_1_3,
        validate_limits_max_inline_uniform_total_size,
    );
    info_tests.add_child(limits13);

    let mut limits14 = TestCaseGroup::new("vulkan1p4_limits_validation");
    add_function_case(&mut limits14, "general", check_support_api_1_4, validate_limits14);
    info_tests.add_child(limits14);

    let mut subgroups = TestCaseGroup::new("subgroup_features");
    add_function_case(
        &mut subgroups,
        "flags",
        check_support_api_1_4,
        validate_subgroup_features,
    );
    info_tests.add_child(subgroups);
}
