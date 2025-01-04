// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_shading_rate/vktFragmentShadingRateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2020 The Khronos Group Inc.
// Copyright (c) 2020 Google LLC.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. All three construction types are registered (`vk::pipeline_construction`). The
// `limits` and `shading_rates` cases are in this file as upstream has them; every other group of the package has a module of its own.

pub mod attachment_rate_tests;
pub mod basic_tests;
pub mod misc_tests;
pub mod pixel_consistency_tests;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::pipeline_construction::PipelineConstructionType;
use crate::vkt::tests::api::case_util::add_function_case;
use crate::vkt::{Context, TestCaseGroup};

/// `FragmentShadingRate::GroupParams`
#[derive(Clone, Copy)]
pub struct GroupParams {
    /// When set, tests use dynamic rendering, otherwise a render pass object is used.
    pub use_dynamic_rendering: bool,
    /// When true a secondary command buffer is created in the test.
    pub use_secondary_cmd_buffer: bool,
    /// When true begin/endRendering is in the secondary command buffer, when false those commands are recorded to the primary
    /// command buffer. Only checked when `use_secondary_cmd_buffer` is true.
    pub secondary_cmd_buffer_completely_contains_dynamic_renderpass: bool,
    pub construction: PipelineConstructionType,
}

/// `deIntIsPow2`
fn de_int_is_pow2(value: u32) -> bool {
    value & value.wrapping_sub(1) == 0
}

fn fragment_shading_rate_features(context: &Context<'_>) -> vk::PhysicalDeviceFragmentShadingRateFeaturesKHR {
    let mut features = vk::PhysicalDeviceFragmentShadingRateFeaturesKHR::default();
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

fn fragment_shading_rate_properties(context: &Context<'_>) -> vk::PhysicalDeviceFragmentShadingRatePropertiesKHR {
    let mut properties = vk::PhysicalDeviceFragmentShadingRatePropertiesKHR::default();
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

/// `testLimits`
fn test_limits(context: &Context<'_>) -> TestOutcome {
    let mut all_checks_passed = true;
    let features = context.get_device_features();
    let properties = context.get_device_properties();
    let fragment_shading_rate_features = fragment_shading_rate_features(context);
    let fragment_shading_rate_properties = fragment_shading_rate_properties(context);

    let mut vulkan12_features = vk::PhysicalDeviceVulkan12Features::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut vulkan12_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    let mut multiview_features = vk::PhysicalDeviceMultiviewFeatures::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut multiview_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }

    if fragment_shading_rate_features.pipeline_fragment_shading_rate == vk::FALSE {
        log::info!("pipelineFragmentShadingRate is not supported");
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.primitive_fragment_shading_rate_with_multiple_viewports != vk::FALSE
        && fragment_shading_rate_features.primitive_fragment_shading_rate == vk::FALSE
    {
        log::info!(
            "primitiveFragmentShadingRateWithMultipleViewports limit should only be supported if primitiveFragmentShadingRate is supported"
        );
        all_checks_passed = false;
    }

    let mut required_features = features.geometry_shader != vk::FALSE
        || vulkan12_features.shader_output_viewport_index != vk::FALSE
        || context.is_device_functionality_supported("VK_EXT_shader_viewport_index_layer");
    if fragment_shading_rate_properties.primitive_fragment_shading_rate_with_multiple_viewports != vk::FALSE
        && !required_features
    {
        log::info!(
            "primitiveFragmentShadingRateWithMultipleViewports limit should only be supported if at least one of the geometryShader feature, shaderOutputViewportIndex feature, or VK_EXT_shader_viewport_index_layer extension is supported"
        );
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.layered_shading_rate_attachments != vk::FALSE
        && fragment_shading_rate_features.attachment_fragment_shading_rate == vk::FALSE
    {
        log::info!(
            "layeredShadingRateAttachments should only be supported if attachmentFragmentShadingRate is supported"
        );
        all_checks_passed = false;
    }

    required_features = features.geometry_shader != vk::FALSE
        || multiview_features.multiview != vk::FALSE
        || vulkan12_features.shader_output_viewport_index != vk::FALSE
        || context.is_device_functionality_supported("VK_EXT_shader_viewport_index_layer");
    if fragment_shading_rate_properties.layered_shading_rate_attachments != vk::FALSE && !required_features {
        log::info!(
            "layeredShadingRateAttachments should only be supported if at least one of the geometryShader feature, multiview feature, shaderOutputViewportIndex feature, or VK_EXT_shader_viewport_index_layer extension is supported"
        );
        all_checks_passed = false;
    }

    required_features = fragment_shading_rate_features.primitive_fragment_shading_rate != vk::FALSE
        || fragment_shading_rate_features.attachment_fragment_shading_rate != vk::FALSE;
    if fragment_shading_rate_properties.fragment_shading_rate_non_trivial_combiner_ops != vk::FALSE
        && !required_features
    {
        log::info!(
            "fragmentShadingRateNonTrivialCombinerOps should only be supported if at least one of primitiveFragmentShadingRate or attachmentFragmentShadingRate is supported"
        );
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.max_fragment_size_aspect_ratio
        > fragment_shading_rate_properties
            .max_fragment_size
            .width
            .max(fragment_shading_rate_properties.max_fragment_size.height)
    {
        log::info!(
            "maxFragmentSizeAspectRatio should be less than or equal to the maximum width / height of maxFragmentSize"
        );
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.max_fragment_size_aspect_ratio < 2 {
        log::info!("maxFragmentSizeAspectRatio should be at least 2");
        all_checks_passed = false;
    }

    if !de_int_is_pow2(fragment_shading_rate_properties.max_fragment_size_aspect_ratio) {
        log::info!("maxFragmentSizeAspectRatio should be power of 2");
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.fragment_shading_rate_with_shader_sample_mask != vk::FALSE
        && fragment_shading_rate_properties.max_fragment_shading_rate_coverage_samples
            > properties.limits.max_sample_mask_words * 32
    {
        log::info!(
            "maxFragmentShadingRateCoverageSamples should be less than or equal maxSampleMaskWords * 32 if fragmentShadingRateWithShaderSampleMask is supported"
        );
        all_checks_passed = false;
    }

    let required_value = fragment_shading_rate_properties.max_fragment_size.width
        * fragment_shading_rate_properties.max_fragment_size.height
        * fragment_shading_rate_properties
            .max_fragment_shading_rate_rasterization_samples
            .bits();
    if fragment_shading_rate_properties.max_fragment_shading_rate_coverage_samples > required_value {
        log::info!(
            "maxFragmentShadingRateCoverageSamples should be less than or equal to the product of the width and height of maxFragmentSize and the samples reported by maxFragmentShadingRateRasterizationSamples"
        );
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.max_fragment_shading_rate_coverage_samples < 16 {
        log::info!("maxFragmentShadingRateCoverageSamples should at least be 16");
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties
        .max_fragment_shading_rate_rasterization_samples
        .bits()
        < vk::SampleCountFlags::_4.bits()
    {
        log::info!("maxFragmentShadingRateRasterizationSamples should supports at least VK_SAMPLE_COUNT_4_BIT");
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.fragment_shading_rate_with_conservative_rasterization != vk::FALSE
        && !context.is_device_functionality_supported("VK_EXT_conservative_rasterization")
    {
        log::info!(
            "fragmentShadingRateWithConservativeRasterization should only be supported if VK_EXT_conservative_rasterization is supported"
        );
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.fragment_shading_rate_with_fragment_shader_interlock != vk::FALSE
        && !context.is_device_functionality_supported("VK_EXT_fragment_shader_interlock")
    {
        log::info!(
            "fragmentShadingRateWithFragmentShaderInterlock should only be supported if VK_EXT_fragment_shader_interlock is supported"
        );
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.fragment_shading_rate_with_custom_sample_locations != vk::FALSE
        && !context.is_device_functionality_supported("VK_EXT_sample_locations")
    {
        log::info!(
            "fragmentShadingRateWithCustomSampleLocations should only be supported if VK_EXT_sample_locations is supported"
        );
        all_checks_passed = false;
    }

    let max_attachment_texel_size = fragment_shading_rate_properties.max_fragment_shading_rate_attachment_texel_size;
    let min_attachment_texel_size = fragment_shading_rate_properties.min_fragment_shading_rate_attachment_texel_size;
    if fragment_shading_rate_features.attachment_fragment_shading_rate != vk::FALSE {
        if max_attachment_texel_size.width < 8 || max_attachment_texel_size.height < 8 {
            log::info!("maxFragmentShadingRateAttachmentTexelSize should at least be {{ 8,8 }}");
            all_checks_passed = false;
        }

        if min_attachment_texel_size.width > 32 || min_attachment_texel_size.height > 32 {
            log::info!("minFragmentShadingRateAttachmentTexelSize should't be greater than {{ 32,32 }}");
            all_checks_passed = false;
        }

        if max_attachment_texel_size.width < min_attachment_texel_size.width
            || max_attachment_texel_size.height < min_attachment_texel_size.height
        {
            log::info!(
                "maxFragmentShadingRateAttachmentTexelSize should be greater than or equal to minFragmentShadingRateAttachmentTexelSize in each dimension"
            );
            all_checks_passed = false;
        }

        if !de_int_is_pow2(max_attachment_texel_size.width) || !de_int_is_pow2(max_attachment_texel_size.height) {
            log::info!("maxFragmentShadingRateAttachmentTexelSize should be power of 2");
            all_checks_passed = false;
        }

        if !de_int_is_pow2(min_attachment_texel_size.width) || !de_int_is_pow2(min_attachment_texel_size.height) {
            log::info!("minFragmentShadingRateAttachmentTexelSize should be power of 2");
            all_checks_passed = false;
        }
    } else {
        if max_attachment_texel_size.width != 0 || max_attachment_texel_size.height != 0 {
            log::info!(
                "maxFragmentShadingRateAttachmentTexelSize should be {{ 0,0 }} when attachmentFragmentShadingRate is not supported"
            );
            all_checks_passed = false;
        }

        if min_attachment_texel_size.width != 0 || min_attachment_texel_size.height != 0 {
            log::info!(
                "minFragmentShadingRateAttachmentTexelSize should be {{ 0,0 }} when attachmentFragmentShadingRate is not supported"
            );
            all_checks_passed = false;
        }
    }

    if fragment_shading_rate_properties.max_fragment_size.width < 2
        || fragment_shading_rate_properties.max_fragment_size.height < 2
    {
        log::info!("maxFragmentSize should at least be {{ 2,2 }}");
        all_checks_passed = false;
    }

    if fragment_shading_rate_properties.max_fragment_size.width > 4
        || fragment_shading_rate_properties.max_fragment_size.height > 4
    {
        log::info!("maxFragmentSize should't be greater than{{ 4,4 }}");
        all_checks_passed = false;
    }

    if all_checks_passed {
        Ok(TestStatus::pass("pass"))
    } else {
        Ok(TestStatus::fail("fail"))
    }
}

/// One raw `vkGetPhysicalDeviceFragmentShadingRatesKHR` call, for the checks that look at the result code.
fn get_shading_rates_raw(
    context: &Context<'_>,
    count: &mut u32,
    rates: *mut vk::PhysicalDeviceFragmentShadingRateKHR,
) -> vk::Result {
    let get_rates = context
        .get_instance()
        .commands()
        .get_physical_device_fragment_shading_rates_khr;
    unsafe { get_rates(context.get_physical_device(), count, rates) }
}

/// The shading rates the physical device supports: the count query followed by the query of that many.
fn supported_fragment_shading_rates(context: &Context<'_>) -> Vec<vk::PhysicalDeviceFragmentShadingRateKHR> {
    let mut count = 0u32;
    get_shading_rates_raw(context, &mut count, std::ptr::null_mut());

    let mut rates = vec![vk::PhysicalDeviceFragmentShadingRateKHR::default(); count as usize];
    get_shading_rates_raw(context, &mut count, rates.as_mut_ptr());
    rates
}

/// `testShadingRates`
fn test_shading_rates(context: &Context<'_>) -> TestOutcome {
    let mut some_checks_failed = false;
    let fragment_shading_rate_properties = fragment_shading_rate_properties(context);
    let mut supported_fragment_shading_rate_count = 0u32;

    let mut result = get_shading_rates_raw(
        context,
        &mut supported_fragment_shading_rate_count,
        std::ptr::null_mut(),
    );
    if result != vk::Result::SUCCESS && result != vk::Result::ERROR_OUT_OF_HOST_MEMORY {
        some_checks_failed = true;
        log::info!("vkGetPhysicalDeviceFragmentShadingRatesKHR returned invalid result");
    }

    let default_physical_device_fsr = vk::PhysicalDeviceFragmentShadingRateKHR::default();
    let mut fragment_shading_rate_vect =
        vec![default_physical_device_fsr; supported_fragment_shading_rate_count as usize];

    // Pass a value of 1 into pFragmentShadingRateCount, and an array of at least length one into pFragmentShadingRates. Check
    // that the returned value is either VK_INCOMPLETE or VK_ERROR_OUT_OF_HOST_MEMORY (and issue a quality warning in the
    // latter case).
    supported_fragment_shading_rate_count = 1;
    result = get_shading_rates_raw(
        context,
        &mut supported_fragment_shading_rate_count,
        fragment_shading_rate_vect.as_mut_ptr(),
    );
    if result != vk::Result::INCOMPLETE && result != vk::Result::ERROR_OUT_OF_HOST_MEMORY {
        some_checks_failed = true;
        log::info!("vkGetPhysicalDeviceFragmentShadingRatesKHR returned invalid result");
    }

    // Get all available fragment shading rates
    supported_fragment_shading_rate_count = fragment_shading_rate_vect.len() as u32;
    fragment_shading_rate_vect
        .iter_mut()
        .for_each(|item| *item = default_physical_device_fsr);
    result = get_shading_rates_raw(
        context,
        &mut supported_fragment_shading_rate_count,
        fragment_shading_rate_vect.as_mut_ptr(),
    );
    if result != vk::Result::SUCCESS && result != vk::Result::ERROR_OUT_OF_HOST_MEMORY {
        some_checks_failed = true;
        log::info!("vkGetPhysicalDeviceFragmentShadingRatesKHR returned invalid result");
    }

    let mut width_check_passed = true;
    let mut height_check_passed = true;
    let mut previous_width = u32::MAX;
    let mut previous_height = u32::MAX;

    for fsr in &fragment_shading_rate_vect {
        let fragment_size = fsr.fragment_size;

        // Check that rate width and height are power-of-two
        if !de_int_is_pow2(fragment_size.width) || !de_int_is_pow2(fragment_size.height) {
            log::info!("fragmentSize should be power of 2");
            some_checks_failed = true;
        }

        // Check that the width and height are less than the values in the maxFragmentSize limit
        if fragment_size.width > fragment_shading_rate_properties.max_fragment_size.width
            || fragment_size.height > fragment_shading_rate_properties.max_fragment_size.height
        {
            log::info!("fragmentSize width and height are not less than the values in the maxFragmentSize");
            some_checks_failed = true;
        }

        if fragment_size.width * fragment_size.height == 1 {
            // special case for fragmentSize {1, 1}
            if fsr.sample_counts.bits() != !0u32 {
                log::info!("implementations must support sampleCounts equal to ~0 for fragmentSize {{1, 1}}");
                some_checks_failed = true;
            }
        } else {
            // get highest sample count value
            let mut highest_sample_count = 0x8000_0000u32;
            while highest_sample_count != 0 {
                if fsr.sample_counts.bits() & highest_sample_count != 0 {
                    break;
                }
                highest_sample_count >>= 1;
            }

            // Check that the highest sample count in sampleCounts is less than or equal to maxFragmentShadingRateRasterizationSamples limit
            if highest_sample_count
                > fragment_shading_rate_properties
                    .max_fragment_shading_rate_rasterization_samples
                    .bits()
            {
                log::info!(
                    "highest sample count value is not less than or equal to the maxFragmentShadingRateRasterizationSamples limit"
                );
                some_checks_failed = true;
            }

            // Check that the product of the width, height, and highest sample count value is less than the maxFragmentShadingRateCoverageSamples limit
            if fragment_size.width * fragment_size.height * highest_sample_count
                > fragment_shading_rate_properties.max_fragment_shading_rate_coverage_samples
            {
                log::info!(
                    "product of the width, height, and highest sample count value is not less than the maxFragmentShadingRateCoverageSamples limit"
                );
                some_checks_failed = true;
            }
        }

        // Check that the entries in the array are ordered first by largest to smallest width, then largest to smallest height
        {
            let current_width = fragment_size.width;
            if width_check_passed && current_width > previous_width {
                log::info!(
                    "vkGetPhysicalDeviceFragmentShadingRatesKHR returned entries that are not ordered by largest to smallest width"
                );
                width_check_passed = false;
            }

            let mut current_height = fragment_size.height;
            if height_check_passed {
                // The order of height can only be checked for entries that have the same width.
                if current_width == previous_width {
                    if current_height > previous_height {
                        log::info!(
                            "vkGetPhysicalDeviceFragmentShadingRatesKHR returned entries with same width but height is not ordered by largest to smallest"
                        );
                        height_check_passed = false;
                    }
                } else {
                    current_height = u32::MAX;
                }
            }

            previous_width = current_width;
            previous_height = current_height;
        }

        // Check that no two entries in the array have the same fragmentSize.width and fragmentSize.height value
        {
            let mut count = 0;
            for fsr_b in &fragment_shading_rate_vect {
                if fragment_size.width == fsr_b.fragment_size.width
                    && fragment_size.height == fsr_b.fragment_size.height
                {
                    count += 1;
                    if count > 1 {
                        log::info!(
                            "vkGetPhysicalDeviceFragmentShadingRatesKHR returned entries with same fragmentSize"
                        );
                        some_checks_failed = true;
                        break;
                    }
                }
            }
        }

        // Check that 1x1, 1x2, 2x1, and 2x2 rates are supported with sample counts of 1 and 4
        if fragment_size.width < 3
            && fragment_size.height < 3
            && (!fsr.sample_counts.contains(vk::SampleCountFlags::_1)
                || !fsr.sample_counts.contains(vk::SampleCountFlags::_4))
        {
            log::info!(
                "vkGetPhysicalDeviceFragmentShadingRatesKHR returned 1x1, 1x2, 2x1, and 2x2 rates with sample counts not supporting 1 and 4"
            );
            some_checks_failed = true;
        }

        // If the framebufferColorSampleCounts limit includes a sample count of 2, ensure that a sample count of 2 is also reported for the 1x1, 1x2, 2x1, and 2x2 rates.
        if context
            .get_device_properties()
            .limits
            .framebuffer_color_sample_counts
            .contains(vk::SampleCountFlags::_2)
            && fragment_size.width < 3
            && fragment_size.height < 3
            && !fsr.sample_counts.contains(vk::SampleCountFlags::_2)
        {
            log::info!(
                "vkGetPhysicalDeviceFragmentShadingRatesKHR returned 1x1, 1x2, 2x1, and 2x2 rates with sample counts not supporting 2 while framebufferColorSampleCounts does"
            );
            some_checks_failed = true;
        }
    }

    if some_checks_failed || !width_check_passed || !height_check_passed {
        return Ok(TestStatus::fail("fail"));
    }

    Ok(TestStatus::pass("pass"))
}

fn check_support(context: &Context<'_>) -> Result<(), TestError> {
    context.require_device_functionality("VK_KHR_fragment_shading_rate")
}

/// `createMiscTests`
fn create_misc_tests(parent_group: &mut TestCaseGroup, group_params: GroupParams) {
    let mut group = TestCaseGroup::new("misc");

    if !group_params.use_dynamic_rendering
        && !group_params.use_secondary_cmd_buffer
        && group_params.construction == PipelineConstructionType::Monolithic
    {
        add_function_case(&mut group, "limits", check_support, test_limits);
        add_function_case(&mut group, "shading_rates", check_support, test_shading_rates);
    }

    if !group_params.use_secondary_cmd_buffer && group_params.construction == PipelineConstructionType::Monolithic {
        misc_tests::create_fragment_shading_rate_misc_tests(&mut group, group_params);
    }

    parent_group.add_child(group);
}

/// `createTests(tcu::TestCaseGroup *group, SharedGroupParams groupParams)`
fn create_group_tests(group: &mut TestCaseGroup, group_params: GroupParams) {
    basic_tests::create_basic_tests(group, group_params);

    if !group_params.use_secondary_cmd_buffer && group_params.construction == PipelineConstructionType::Monolithic {
        attachment_rate_tests::create_attachment_rate_tests(group, group_params);
    }

    // Some of these tests use dynamic rendering and others do not.
    create_misc_tests(group, group_params);

    // Pixel consistency tests run only with renderpass2 and a monolithic pipeline; subpasses can't be translated to dynamic
    // rendering.
    if !group_params.use_dynamic_rendering
        && !group_params.use_secondary_cmd_buffer
        && group_params.construction == PipelineConstructionType::Monolithic
    {
        group.add_child(pixel_consistency_tests::create_pixel_consistency_tests());
    }
}

/// `createPipelineConstructionTypePermutations`
fn create_pipeline_construction_type_permutations(parent_group: &mut TestCaseGroup, base_group_params: GroupParams) {
    for construction in [
        PipelineConstructionType::Monolithic,
        PipelineConstructionType::LinkTimeOptimizedLibrary,
        PipelineConstructionType::FastLinkedLibrary,
    ] {
        let mut group = TestCaseGroup::new(construction.group_name());
        create_group_tests(
            &mut group,
            GroupParams {
                construction,
                ..base_group_params
            },
        );
        parent_group.add_child(group);
    }
}

/// `createDynamicRenderingPermutations`
fn create_dynamic_rendering_permutations(parent_group: &mut TestCaseGroup) {
    let construct_group_params =
        |use_secondary_cmd_buffer: bool, secondary_cmd_buffer_completely_contains_dynamic_renderpass: bool| {
            GroupParams {
                use_dynamic_rendering: true,
                use_secondary_cmd_buffer,
                secondary_cmd_buffer_completely_contains_dynamic_renderpass,
                construction: PipelineConstructionType::Monolithic,
            }
        };

    // Draw using Draw commands are recorded in primary command buffer
    let mut dr_primary_cmd_buff_group = TestCaseGroup::new("primary_cmd_buff");
    create_pipeline_construction_type_permutations(
        &mut dr_primary_cmd_buff_group,
        construct_group_params(false, false),
    );

    // Secondary command buffer doesn't include begin/endRendering
    let mut dr_partial_secondary_cmd_buff_group = TestCaseGroup::new("partial_secondary_cmd_buff");
    create_group_tests(
        &mut dr_partial_secondary_cmd_buff_group,
        construct_group_params(true, false),
    );

    // Secondary command buffer contains completely dynamic renderpass
    let mut dr_complete_secondary_cmd_buff_group = TestCaseGroup::new("complete_secondary_cmd_buff");
    create_group_tests(
        &mut dr_complete_secondary_cmd_buff_group,
        construct_group_params(true, true),
    );

    parent_group.add_child(dr_primary_cmd_buff_group);
    parent_group.add_child(dr_partial_secondary_cmd_buff_group);
    parent_group.add_child(dr_complete_secondary_cmd_buff_group);
}

/// `createTests` - the `dEQP-VK.fragment_shading_rate` group.
pub fn create_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("fragment_shading_rate");

    // Draw using render pass object
    let mut renderpass2_group = TestCaseGroup::new("renderpass2");
    create_pipeline_construction_type_permutations(
        &mut renderpass2_group,
        GroupParams {
            use_dynamic_rendering: false,
            use_secondary_cmd_buffer: false,
            secondary_cmd_buffer_completely_contains_dynamic_renderpass: false,
            construction: PipelineConstructionType::Monolithic,
        },
    );
    main_group.add_child(renderpass2_group);

    let mut dynamic_rendering_group = TestCaseGroup::new("dynamic_rendering");
    create_dynamic_rendering_permutations(&mut dynamic_rendering_group);
    main_group.add_child(dynamic_rendering_group);

    main_group
}
