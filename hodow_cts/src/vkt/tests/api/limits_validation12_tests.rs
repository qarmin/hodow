// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiFeatureInfo.cpp
//   (validateLimits12 and the validateLimits{Khr,Ext,Nv}* family of the vulkan1p2_limits_validation group)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-VK.api.info.vulkan1p2_limits_validation.*`. Shares the table machinery with limits_validation_tests.rs.
// Entries upstream marks `LIM_NONE_*` (reported, never compared) are only logged.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use super::case_util::add_function_case;
use super::limits_validation_tests::{
    Bound, LimitItem, get_vulkan11_properties, get_vulkan12_features, get_vulkan12_properties, item,
    require_api_version, validate_all,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vkt::{Context, TestCaseGroup};

macro_rules! query_properties {
    ($context:expr, $ty:ty) => {{
        let mut properties = <$ty>::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
        unsafe {
            $context
                .get_instance()
                .get_physical_device_properties2($context.get_physical_device(), &mut properties2)
        };
        properties
    }};
}

fn always(name: &'static str, bound: Bound) -> LimitItem {
    item(true, "checkAlways", name, bound)
}

fn min_u32(name: &'static str, reported: u32, limit: u32) -> LimitItem {
    always(name, Bound::MinU32 { reported, limit })
}

fn min_f32(name: &'static str, reported: f32, limit: f32) -> LimitItem {
    always(name, Bound::MinFloat { reported, limit })
}

fn max_f32(name: &'static str, reported: f32, limit: f32) -> LimitItem {
    always(name, Bound::MaxFloat { reported, limit })
}

fn min_size(name: &'static str, reported: u64, limit: u64) -> LimitItem {
    always(name, Bound::MinDeviceSize { reported, limit })
}

fn max_size(name: &'static str, reported: u64, limit: u64) -> LimitItem {
    always(name, Bound::MaxDeviceSize { reported, limit })
}

fn min_bits(name: &'static str, reported: u32, limit: u32) -> LimitItem {
    always(name, Bound::MinBits { reported, limit })
}

fn cond_u32(cond: bool, cond_name: &'static str, name: &'static str, reported: u32, limit: u32) -> LimitItem {
    item(cond, cond_name, name, Bound::MinU32 { reported, limit })
}

fn cond_min_f32(cond: bool, cond_name: &'static str, name: &'static str, reported: f32, limit: f32) -> LimitItem {
    item(cond, cond_name, name, Bound::MinFloat { reported, limit })
}

fn cond_max_f32(cond: bool, cond_name: &'static str, name: &'static str, reported: f32, limit: f32) -> LimitItem {
    item(cond, cond_name, name, Bound::MaxFloat { reported, limit })
}

fn check_support_extension(context: &Context<'_>, extension: &str) -> Result<(), TestError> {
    context.require_device_functionality(extension)
}

/// `validateLimits12`
fn validate_limits12(context: &Context<'_>) -> TestOutcome {
    let mut properties2 = vk::PhysicalDeviceProperties2::default();
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    let limits = properties2.properties.limits;
    let features = *context.get_device_features();
    let features12 = get_vulkan12_features(context);
    let vulkan11 = get_vulkan11_properties(context);
    let vulkan12 = get_vulkan12_properties(context);

    let mut shader_stages = 3u32;
    if features.tessellation_shader != vk::FALSE {
        shader_stages += 2;
    }
    if features.geometry_shader != vk::FALSE {
        shader_stages += 1;
    }
    let max_per_stage_resources_min = 128u32.min(
        limits.max_per_stage_descriptor_uniform_buffers
            + limits.max_per_stage_descriptor_storage_buffers
            + limits.max_per_stage_descriptor_sampled_images
            + limits.max_per_stage_descriptor_storage_images
            + limits.max_per_stage_descriptor_input_attachments
            + limits.max_color_attachments,
    );
    let max_framebuffer_layers = 256u32;

    let tess = features.tessellation_shader != vk::FALSE;
    let geom = features.geometry_shader != vk::FALSE;
    let large_points = features.large_points != vk::FALSE;
    let wide_lines = features.wide_lines != vk::FALSE;
    let sample_rate_shading = features.sample_rate_shading != vk::FALSE;
    let descriptor_indexing = features12.descriptor_indexing != vk::FALSE;
    let samples_1_4 = (vk::SampleCountFlags::_1 | vk::SampleCountFlags::_4).bits();
    let samples_1 = vk::SampleCountFlags::_1.bits();

    let mut table = vec![
        min_u32("limits.maxImageDimension1D", limits.max_image_dimension_1d, 4096),
        min_u32("limits.maxImageDimension2D", limits.max_image_dimension_2d, 4096),
        min_u32("limits.maxImageDimension3D", limits.max_image_dimension_3d, 256),
        min_u32("limits.maxImageDimensionCube", limits.max_image_dimension_cube, 4096),
        min_u32("limits.maxImageArrayLayers", limits.max_image_array_layers, 256),
        min_u32("limits.maxTexelBufferElements", limits.max_texel_buffer_elements, 65536),
        min_u32("limits.maxUniformBufferRange", limits.max_uniform_buffer_range, 16384),
        min_u32("limits.maxStorageBufferRange", limits.max_storage_buffer_range, 1 << 27),
        min_u32("limits.maxPushConstantsSize", limits.max_push_constants_size, 128),
        min_u32(
            "limits.maxMemoryAllocationCount",
            limits.max_memory_allocation_count,
            4096,
        ),
        min_u32(
            "limits.maxSamplerAllocationCount",
            limits.max_sampler_allocation_count,
            4000,
        ),
        min_size("limits.bufferImageGranularity", limits.buffer_image_granularity, 1),
        max_size("limits.bufferImageGranularity", limits.buffer_image_granularity, 131072),
        item(
            features.sparse_binding != vk::FALSE,
            "features.sparseBinding",
            "limits.sparseAddressSpaceSize",
            Bound::MinDeviceSize {
                reported: limits.sparse_address_space_size,
                limit: 1u64 << 31,
            },
        ),
        min_u32("limits.maxBoundDescriptorSets", limits.max_bound_descriptor_sets, 4),
        min_u32(
            "limits.maxPerStageDescriptorSamplers",
            limits.max_per_stage_descriptor_samplers,
            16,
        ),
        min_u32(
            "limits.maxPerStageDescriptorUniformBuffers",
            limits.max_per_stage_descriptor_uniform_buffers,
            12,
        ),
        min_u32(
            "limits.maxPerStageDescriptorStorageBuffers",
            limits.max_per_stage_descriptor_storage_buffers,
            4,
        ),
        min_u32(
            "limits.maxPerStageDescriptorSampledImages",
            limits.max_per_stage_descriptor_sampled_images,
            16,
        ),
        min_u32(
            "limits.maxPerStageDescriptorStorageImages",
            limits.max_per_stage_descriptor_storage_images,
            4,
        ),
        min_u32(
            "limits.maxPerStageDescriptorInputAttachments",
            limits.max_per_stage_descriptor_input_attachments,
            4,
        ),
        min_u32(
            "limits.maxPerStageResources",
            limits.max_per_stage_resources,
            max_per_stage_resources_min,
        ),
        min_u32(
            "limits.maxDescriptorSetSamplers",
            limits.max_descriptor_set_samplers,
            shader_stages * 16,
        ),
        min_u32(
            "limits.maxDescriptorSetUniformBuffers",
            limits.max_descriptor_set_uniform_buffers,
            shader_stages * 12,
        ),
        min_u32(
            "limits.maxDescriptorSetUniformBuffersDynamic",
            limits.max_descriptor_set_uniform_buffers_dynamic,
            8,
        ),
        min_u32(
            "limits.maxDescriptorSetStorageBuffers",
            limits.max_descriptor_set_storage_buffers,
            shader_stages * 4,
        ),
        min_u32(
            "limits.maxDescriptorSetStorageBuffersDynamic",
            limits.max_descriptor_set_storage_buffers_dynamic,
            4,
        ),
        min_u32(
            "limits.maxDescriptorSetSampledImages",
            limits.max_descriptor_set_sampled_images,
            shader_stages * 16,
        ),
        min_u32(
            "limits.maxDescriptorSetStorageImages",
            limits.max_descriptor_set_storage_images,
            shader_stages * 4,
        ),
        min_u32(
            "limits.maxDescriptorSetInputAttachments",
            limits.max_descriptor_set_input_attachments,
            4,
        ),
        min_u32(
            "limits.maxVertexInputAttributes",
            limits.max_vertex_input_attributes,
            16,
        ),
        min_u32("limits.maxVertexInputBindings", limits.max_vertex_input_bindings, 16),
        min_u32(
            "limits.maxVertexInputAttributeOffset",
            limits.max_vertex_input_attribute_offset,
            2047,
        ),
        min_u32(
            "limits.maxVertexInputBindingStride",
            limits.max_vertex_input_binding_stride,
            2048,
        ),
        min_u32(
            "limits.maxVertexOutputComponents",
            limits.max_vertex_output_components,
            64,
        ),
        cond_u32(
            tess,
            "features.tessellationShader",
            "limits.maxTessellationGenerationLevel",
            limits.max_tessellation_generation_level,
            64,
        ),
        cond_u32(
            tess,
            "features.tessellationShader",
            "limits.maxTessellationPatchSize",
            limits.max_tessellation_patch_size,
            32,
        ),
        cond_u32(
            tess,
            "features.tessellationShader",
            "limits.maxTessellationControlPerVertexInputComponents",
            limits.max_tessellation_control_per_vertex_input_components,
            64,
        ),
        cond_u32(
            tess,
            "features.tessellationShader",
            "limits.maxTessellationControlPerVertexOutputComponents",
            limits.max_tessellation_control_per_vertex_output_components,
            64,
        ),
        cond_u32(
            tess,
            "features.tessellationShader",
            "limits.maxTessellationControlPerPatchOutputComponents",
            limits.max_tessellation_control_per_patch_output_components,
            120,
        ),
        cond_u32(
            tess,
            "features.tessellationShader",
            "limits.maxTessellationControlTotalOutputComponents",
            limits.max_tessellation_control_total_output_components,
            2048,
        ),
        cond_u32(
            tess,
            "features.tessellationShader",
            "limits.maxTessellationEvaluationInputComponents",
            limits.max_tessellation_evaluation_input_components,
            64,
        ),
        cond_u32(
            tess,
            "features.tessellationShader",
            "limits.maxTessellationEvaluationOutputComponents",
            limits.max_tessellation_evaluation_output_components,
            64,
        ),
        cond_u32(
            geom,
            "features.geometryShader",
            "limits.maxGeometryShaderInvocations",
            limits.max_geometry_shader_invocations,
            32,
        ),
        cond_u32(
            geom,
            "features.geometryShader",
            "limits.maxGeometryInputComponents",
            limits.max_geometry_input_components,
            64,
        ),
        cond_u32(
            geom,
            "features.geometryShader",
            "limits.maxGeometryOutputComponents",
            limits.max_geometry_output_components,
            64,
        ),
        cond_u32(
            geom,
            "features.geometryShader",
            "limits.maxGeometryOutputVertices",
            limits.max_geometry_output_vertices,
            256,
        ),
        cond_u32(
            geom,
            "features.geometryShader",
            "limits.maxGeometryTotalOutputComponents",
            limits.max_geometry_total_output_components,
            1024,
        ),
        min_u32(
            "limits.maxFragmentInputComponents",
            limits.max_fragment_input_components,
            64,
        ),
        min_u32(
            "limits.maxFragmentOutputAttachments",
            limits.max_fragment_output_attachments,
            4,
        ),
        cond_u32(
            features.dual_src_blend != vk::FALSE,
            "features.dualSrcBlend",
            "limits.maxFragmentDualSrcAttachments",
            limits.max_fragment_dual_src_attachments,
            1,
        ),
        min_u32(
            "limits.maxFragmentCombinedOutputResources",
            limits.max_fragment_combined_output_resources,
            4,
        ),
        min_u32(
            "limits.maxComputeSharedMemorySize",
            limits.max_compute_shared_memory_size,
            16384,
        ),
        min_u32(
            "limits.maxComputeWorkGroupCount[0]",
            limits.max_compute_work_group_count[0],
            65535,
        ),
        min_u32(
            "limits.maxComputeWorkGroupCount[1]",
            limits.max_compute_work_group_count[1],
            65535,
        ),
        min_u32(
            "limits.maxComputeWorkGroupCount[2]",
            limits.max_compute_work_group_count[2],
            65535,
        ),
        min_u32(
            "limits.maxComputeWorkGroupInvocations",
            limits.max_compute_work_group_invocations,
            128,
        ),
        min_u32(
            "limits.maxComputeWorkGroupSize[0]",
            limits.max_compute_work_group_size[0],
            128,
        ),
        min_u32(
            "limits.maxComputeWorkGroupSize[1]",
            limits.max_compute_work_group_size[1],
            128,
        ),
        min_u32(
            "limits.maxComputeWorkGroupSize[2]",
            limits.max_compute_work_group_size[2],
            64,
        ),
        min_u32("limits.subPixelPrecisionBits", limits.sub_pixel_precision_bits, 4),
        min_u32("limits.subTexelPrecisionBits", limits.sub_texel_precision_bits, 4),
        min_u32("limits.mipmapPrecisionBits", limits.mipmap_precision_bits, 4),
        cond_u32(
            features.full_draw_index_uint32 != vk::FALSE,
            "features.fullDrawIndexUint32",
            "limits.maxDrawIndexedIndexValue",
            limits.max_draw_indexed_index_value,
            u32::MAX,
        ),
        cond_u32(
            features.multi_draw_indirect != vk::FALSE,
            "features.multiDrawIndirect",
            "limits.maxDrawIndirectCount",
            limits.max_draw_indirect_count,
            65535,
        ),
        min_f32("limits.maxSamplerLodBias", limits.max_sampler_lod_bias, 2.0),
        cond_min_f32(
            features.sampler_anisotropy != vk::FALSE,
            "features.samplerAnisotropy",
            "limits.maxSamplerAnisotropy",
            limits.max_sampler_anisotropy,
            16.0,
        ),
        cond_u32(
            features.multi_viewport != vk::FALSE,
            "features.multiViewport",
            "limits.maxViewports",
            limits.max_viewports,
            16,
        ),
        min_u32(
            "limits.maxViewportDimensions[0]",
            limits.max_viewport_dimensions[0],
            4096,
        ),
        min_u32(
            "limits.maxViewportDimensions[1]",
            limits.max_viewport_dimensions[1],
            4096,
        ),
        max_f32(
            "limits.viewportBoundsRange[0]",
            limits.viewport_bounds_range[0],
            -8192.0,
        ),
        min_f32("limits.viewportBoundsRange[1]", limits.viewport_bounds_range[1], 8191.0),
        min_u32("limits.viewportSubPixelBits", limits.viewport_sub_pixel_bits, 0),
        min_u32(
            "limits.minMemoryMapAlignment",
            limits.min_memory_map_alignment as u32,
            64,
        ),
        min_size(
            "limits.minTexelBufferOffsetAlignment",
            limits.min_texel_buffer_offset_alignment,
            1,
        ),
        max_size(
            "limits.minTexelBufferOffsetAlignment",
            limits.min_texel_buffer_offset_alignment,
            256,
        ),
        min_size(
            "limits.minUniformBufferOffsetAlignment",
            limits.min_uniform_buffer_offset_alignment,
            1,
        ),
        max_size(
            "limits.minUniformBufferOffsetAlignment",
            limits.min_uniform_buffer_offset_alignment,
            256,
        ),
        min_size(
            "limits.minStorageBufferOffsetAlignment",
            limits.min_storage_buffer_offset_alignment,
            1,
        ),
        max_size(
            "limits.minStorageBufferOffsetAlignment",
            limits.min_storage_buffer_offset_alignment,
            256,
        ),
        always(
            "limits.minTexelOffset",
            Bound::MaxI32 {
                reported: limits.min_texel_offset,
                limit: -8,
            },
        ),
        always(
            "limits.maxTexelOffset",
            Bound::MinI32 {
                reported: limits.max_texel_offset as i32,
                limit: 7,
            },
        ),
        item(
            features.shader_image_gather_extended != vk::FALSE,
            "features.shaderImageGatherExtended",
            "limits.minTexelGatherOffset",
            Bound::MaxI32 {
                reported: limits.min_texel_gather_offset,
                limit: -8,
            },
        ),
        item(
            features.shader_image_gather_extended != vk::FALSE,
            "features.shaderImageGatherExtended",
            "limits.maxTexelGatherOffset",
            Bound::MinI32 {
                reported: limits.max_texel_gather_offset as i32,
                limit: 7,
            },
        ),
        cond_max_f32(
            sample_rate_shading,
            "features.sampleRateShading",
            "limits.minInterpolationOffset",
            limits.min_interpolation_offset,
            -0.5,
        ),
        cond_min_f32(
            sample_rate_shading,
            "features.sampleRateShading",
            "limits.maxInterpolationOffset",
            limits.max_interpolation_offset,
            0.5 - (1.0 / 2.0f32.powf(limits.sub_pixel_interpolation_offset_bits as f32)),
        ),
        cond_u32(
            sample_rate_shading,
            "features.sampleRateShading",
            "limits.subPixelInterpolationOffsetBits",
            limits.sub_pixel_interpolation_offset_bits,
            4,
        ),
        min_u32("limits.maxFramebufferWidth", limits.max_framebuffer_width, 4096),
        min_u32("limits.maxFramebufferHeight", limits.max_framebuffer_height, 4096),
        min_u32(
            "limits.maxFramebufferLayers",
            limits.max_framebuffer_layers,
            max_framebuffer_layers,
        ),
        min_bits(
            "limits.framebufferColorSampleCounts",
            limits.framebuffer_color_sample_counts.bits(),
            samples_1_4,
        ),
        min_bits(
            "vulkan12Properties.framebufferIntegerColorSampleCounts",
            vulkan12.framebuffer_integer_color_sample_counts.bits(),
            samples_1,
        ),
        min_bits(
            "limits.framebufferDepthSampleCounts",
            limits.framebuffer_depth_sample_counts.bits(),
            samples_1_4,
        ),
        min_bits(
            "limits.framebufferStencilSampleCounts",
            limits.framebuffer_stencil_sample_counts.bits(),
            samples_1_4,
        ),
        min_bits(
            "limits.framebufferNoAttachmentsSampleCounts",
            limits.framebuffer_no_attachments_sample_counts.bits(),
            samples_1_4,
        ),
        min_u32("limits.maxColorAttachments", limits.max_color_attachments, 4),
        min_bits(
            "limits.sampledImageColorSampleCounts",
            limits.sampled_image_color_sample_counts.bits(),
            samples_1_4,
        ),
        min_bits(
            "limits.sampledImageIntegerSampleCounts",
            limits.sampled_image_integer_sample_counts.bits(),
            samples_1,
        ),
        min_bits(
            "limits.sampledImageDepthSampleCounts",
            limits.sampled_image_depth_sample_counts.bits(),
            samples_1_4,
        ),
        min_bits(
            "limits.sampledImageStencilSampleCounts",
            limits.sampled_image_stencil_sample_counts.bits(),
            samples_1_4,
        ),
        item(
            features.shader_storage_image_multisample != vk::FALSE,
            "features.shaderStorageImageMultisample",
            "limits.storageImageSampleCounts",
            Bound::MinBits {
                reported: limits.storage_image_sample_counts.bits(),
                limit: samples_1_4,
            },
        ),
        min_u32("limits.maxSampleMaskWords", limits.max_sample_mask_words, 1),
        cond_u32(
            features.shader_clip_distance != vk::FALSE,
            "features.shaderClipDistance",
            "limits.maxClipDistances",
            limits.max_clip_distances,
            8,
        ),
        cond_u32(
            features.shader_cull_distance != vk::FALSE,
            "features.shaderCullDistance",
            "limits.maxCullDistances",
            limits.max_cull_distances,
            8,
        ),
        cond_u32(
            features.shader_clip_distance != vk::FALSE,
            "features.shaderClipDistance",
            "limits.maxCombinedClipAndCullDistances",
            limits.max_combined_clip_and_cull_distances,
            8,
        ),
        min_u32("limits.discreteQueuePriorities", limits.discrete_queue_priorities, 2),
        cond_min_f32(
            large_points,
            "features.largePoints",
            "limits.pointSizeRange[0]",
            limits.point_size_range[0],
            0.0,
        ),
        cond_max_f32(
            large_points,
            "features.largePoints",
            "limits.pointSizeRange[0]",
            limits.point_size_range[0],
            1.0,
        ),
        cond_min_f32(
            large_points,
            "features.largePoints",
            "limits.pointSizeRange[1]",
            limits.point_size_range[1],
            64.0 - limits.point_size_granularity,
        ),
        cond_min_f32(
            wide_lines,
            "features.wideLines",
            "limits.lineWidthRange[0]",
            limits.line_width_range[0],
            0.0,
        ),
        cond_max_f32(
            wide_lines,
            "features.wideLines",
            "limits.lineWidthRange[0]",
            limits.line_width_range[0],
            1.0,
        ),
        cond_min_f32(
            wide_lines,
            "features.wideLines",
            "limits.lineWidthRange[1]",
            limits.line_width_range[1],
            8.0 - limits.line_width_granularity,
        ),
        cond_min_f32(
            large_points,
            "features.largePoints",
            "limits.pointSizeGranularity",
            limits.point_size_granularity,
            0.0,
        ),
        cond_max_f32(
            large_points,
            "features.largePoints",
            "limits.pointSizeGranularity",
            limits.point_size_granularity,
            1.0,
        ),
        cond_min_f32(
            wide_lines,
            "features.wideLines",
            "limits.lineWidthGranularity",
            limits.line_width_granularity,
            0.0,
        ),
        cond_max_f32(
            wide_lines,
            "features.wideLines",
            "limits.lineWidthGranularity",
            limits.line_width_granularity,
            1.0,
        ),
        min_size("limits.nonCoherentAtomSize", limits.non_coherent_atom_size, 1),
        max_size("limits.nonCoherentAtomSize", limits.non_coherent_atom_size, 256),
        cond_u32(
            true,
            "checkVulkan12Limit",
            "vulkan11Properties.maxMultiviewViewCount",
            vulkan11.max_multiview_view_count,
            6,
        ),
        cond_u32(
            true,
            "checkVulkan12Limit",
            "vulkan11Properties.maxMultiviewInstanceIndex",
            vulkan11.max_multiview_instance_index,
            (1 << 27) - 1,
        ),
        cond_u32(
            true,
            "checkVulkan12Limit",
            "vulkan11Properties.maxPerSetDescriptors",
            vulkan11.max_per_set_descriptors,
            1024,
        ),
        item(
            true,
            "checkVulkan12Limit",
            "vulkan11Properties.maxMemoryAllocationSize",
            Bound::MinDeviceSize {
                reported: vulkan11.max_memory_allocation_size,
                limit: 1 << 30,
            },
        ),
    ];

    // VK_EXT_descriptor_indexing, gated on features12.descriptorIndexing
    let di = |name: &'static str, reported: u32, limit: u32| {
        cond_u32(
            descriptor_indexing,
            "features12.descriptorIndexing",
            name,
            reported,
            limit,
        )
    };
    table.extend([
        di(
            "vulkan12Properties.maxUpdateAfterBindDescriptorsInAllPools",
            vulkan12.max_update_after_bind_descriptors_in_all_pools,
            500000,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindSamplers",
            vulkan12.max_per_stage_descriptor_update_after_bind_samplers,
            500000,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindUniformBuffers",
            vulkan12.max_per_stage_descriptor_update_after_bind_uniform_buffers,
            12,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindStorageBuffers",
            vulkan12.max_per_stage_descriptor_update_after_bind_storage_buffers,
            500000,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindSampledImages",
            vulkan12.max_per_stage_descriptor_update_after_bind_sampled_images,
            500000,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindStorageImages",
            vulkan12.max_per_stage_descriptor_update_after_bind_storage_images,
            500000,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindInputAttachments",
            vulkan12.max_per_stage_descriptor_update_after_bind_input_attachments,
            4,
        ),
        di(
            "vulkan12Properties.maxPerStageUpdateAfterBindResources",
            vulkan12.max_per_stage_update_after_bind_resources,
            500000,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindSamplers",
            vulkan12.max_descriptor_set_update_after_bind_samplers,
            500000,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindUniformBuffers",
            vulkan12.max_descriptor_set_update_after_bind_uniform_buffers,
            shader_stages * 12,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindUniformBuffersDynamic",
            vulkan12.max_descriptor_set_update_after_bind_uniform_buffers_dynamic,
            8,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindStorageBuffers",
            vulkan12.max_descriptor_set_update_after_bind_storage_buffers,
            500000,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindStorageBuffersDynamic",
            vulkan12.max_descriptor_set_update_after_bind_storage_buffers_dynamic,
            4,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindSampledImages",
            vulkan12.max_descriptor_set_update_after_bind_sampled_images,
            500000,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindStorageImages",
            vulkan12.max_descriptor_set_update_after_bind_storage_images,
            500000,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindInputAttachments",
            vulkan12.max_descriptor_set_update_after_bind_input_attachments,
            4,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindSamplers",
            vulkan12.max_per_stage_descriptor_update_after_bind_samplers,
            limits.max_per_stage_descriptor_samplers,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindUniformBuffers",
            vulkan12.max_per_stage_descriptor_update_after_bind_uniform_buffers,
            limits.max_per_stage_descriptor_uniform_buffers,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindStorageBuffers",
            vulkan12.max_per_stage_descriptor_update_after_bind_storage_buffers,
            limits.max_per_stage_descriptor_storage_buffers,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindSampledImages",
            vulkan12.max_per_stage_descriptor_update_after_bind_sampled_images,
            limits.max_per_stage_descriptor_sampled_images,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindStorageImages",
            vulkan12.max_per_stage_descriptor_update_after_bind_storage_images,
            limits.max_per_stage_descriptor_storage_images,
        ),
        di(
            "vulkan12Properties.maxPerStageDescriptorUpdateAfterBindInputAttachments",
            vulkan12.max_per_stage_descriptor_update_after_bind_input_attachments,
            limits.max_per_stage_descriptor_input_attachments,
        ),
        di(
            "vulkan12Properties.maxPerStageUpdateAfterBindResources",
            vulkan12.max_per_stage_update_after_bind_resources,
            limits.max_per_stage_resources,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindSamplers",
            vulkan12.max_descriptor_set_update_after_bind_samplers,
            limits.max_descriptor_set_samplers,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindUniformBuffers",
            vulkan12.max_descriptor_set_update_after_bind_uniform_buffers,
            limits.max_descriptor_set_uniform_buffers,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindUniformBuffersDynamic",
            vulkan12.max_descriptor_set_update_after_bind_uniform_buffers_dynamic,
            limits.max_descriptor_set_uniform_buffers_dynamic,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindStorageBuffers",
            vulkan12.max_descriptor_set_update_after_bind_storage_buffers,
            limits.max_descriptor_set_storage_buffers,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindStorageBuffersDynamic",
            vulkan12.max_descriptor_set_update_after_bind_storage_buffers_dynamic,
            limits.max_descriptor_set_storage_buffers_dynamic,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindSampledImages",
            vulkan12.max_descriptor_set_update_after_bind_sampled_images,
            limits.max_descriptor_set_sampled_images,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindStorageImages",
            vulkan12.max_descriptor_set_update_after_bind_storage_images,
            limits.max_descriptor_set_storage_images,
        ),
        di(
            "vulkan12Properties.maxDescriptorSetUpdateAfterBindInputAttachments",
            vulkan12.max_descriptor_set_update_after_bind_input_attachments,
            limits.max_descriptor_set_input_attachments,
        ),
        item(
            true,
            "checkVulkan12Limit",
            "vulkan12Properties.maxTimelineSemaphoreValueDifference",
            Bound::MinDeviceSize {
                reported: vulkan12.max_timeline_semaphore_value_difference,
                limit: (1u64 << 31) - 1,
            },
        ),
    ]);

    log::info!("{limits:?}");

    validate_all(&table)
}

fn check_support_api_1_2(context: &Context<'_>) -> Result<(), TestError> {
    require_api_version(context, 1, 2)
}

fn check_support_push_descriptor(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_KHR_push_descriptor")
}

fn validate_limits_khr_push_descriptor(context: &Context<'_>) -> TestOutcome {
    let properties = query_properties!(context, vk::PhysicalDevicePushDescriptorProperties);
    log::info!("{properties:?}");
    validate_all(&[min_u32(
        "pushDescriptorPropertiesKHR.maxPushDescriptors",
        properties.max_push_descriptors,
        32,
    )])
}

fn check_support_khr_multiview(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_KHR_multiview")
}

fn validate_limits_khr_multiview(context: &Context<'_>) -> TestOutcome {
    let properties = query_properties!(context, vk::PhysicalDeviceMultiviewProperties);
    log::info!("{properties:?}");
    validate_all(&[
        min_u32(
            "multiviewProperties.maxMultiviewViewCount",
            properties.max_multiview_view_count,
            6,
        ),
        min_u32(
            "multiviewProperties.maxMultiviewInstanceIndex",
            properties.max_multiview_instance_index,
            (1 << 27) - 1,
        ),
    ])
}

fn check_support_ext_discard_rectangles(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_discard_rectangles")
}

fn validate_limits_ext_discard_rectangles(context: &Context<'_>) -> TestOutcome {
    let properties = query_properties!(context, vk::PhysicalDeviceDiscardRectanglePropertiesEXT);
    log::info!("{properties:?}");
    validate_all(&[min_u32(
        "discardRectanglePropertiesEXT.maxDiscardRectangles",
        properties.max_discard_rectangles,
        4,
    )])
}

fn check_support_ext_sample_locations(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_sample_locations")
}

fn validate_limits_ext_sample_locations(context: &Context<'_>) -> TestOutcome {
    let properties = query_properties!(context, vk::PhysicalDeviceSampleLocationsPropertiesEXT);
    log::info!("{properties:?}");
    validate_all(&[
        min_bits(
            "sampleLocationsPropertiesEXT.sampleLocationSampleCounts",
            properties.sample_location_sample_counts.bits(),
            vk::SampleCountFlags::_4.bits(),
        ),
        min_f32(
            "sampleLocationsPropertiesEXT.maxSampleLocationGridSize.width",
            properties.max_sample_location_grid_size.width as f32,
            0.0,
        ),
        min_f32(
            "sampleLocationsPropertiesEXT.maxSampleLocationGridSize.height",
            properties.max_sample_location_grid_size.height as f32,
            0.0,
        ),
        max_f32(
            "sampleLocationsPropertiesEXT.sampleLocationCoordinateRange[0]",
            properties.sample_location_coordinate_range[0],
            0.0,
        ),
        min_f32(
            "sampleLocationsPropertiesEXT.sampleLocationCoordinateRange[1]",
            properties.sample_location_coordinate_range[1],
            0.9375,
        ),
        min_u32(
            "sampleLocationsPropertiesEXT.sampleLocationSubPixelBits",
            properties.sample_location_sub_pixel_bits,
            4,
        ),
    ])
}

fn check_support_ext_external_memory_host(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_external_memory_host")
}

fn validate_limits_ext_external_memory_host(context: &Context<'_>) -> TestOutcome {
    let properties = query_properties!(context, vk::PhysicalDeviceExternalMemoryHostPropertiesEXT);
    log::info!("{properties:?}");
    validate_all(&[max_size(
        "externalMemoryHostPropertiesEXT.minImportedHostPointerAlignment",
        properties.min_imported_host_pointer_alignment,
        65536,
    )])
}

fn check_support_ext_blend_operation_advanced(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_blend_operation_advanced")
}

fn validate_limits_ext_blend_operation_advanced(context: &Context<'_>) -> TestOutcome {
    let properties = query_properties!(context, vk::PhysicalDeviceBlendOperationAdvancedPropertiesEXT);
    log::info!("{properties:?}");
    validate_all(&[min_u32(
        "blendOperationAdvancedPropertiesEXT.advancedBlendMaxColorAttachments",
        properties.advanced_blend_max_color_attachments,
        1,
    )])
}

fn check_support_khr_maintenance3(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_KHR_maintenance3")
}

fn validate_limits_khr_maintenance3(context: &Context<'_>) -> TestOutcome {
    let properties = query_properties!(context, vk::PhysicalDeviceMaintenance3Properties);
    log::info!("{properties:?}");
    validate_all(&[
        min_u32(
            "maintenance3Properties.maxPerSetDescriptors",
            properties.max_per_set_descriptors,
            1024,
        ),
        min_size(
            "maintenance3Properties.maxMemoryAllocationSize",
            properties.max_memory_allocation_size,
            1 << 30,
        ),
    ])
}

fn check_support_ext_conservative_rasterization(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_conservative_rasterization")
}

fn validate_limits_ext_conservative_rasterization(context: &Context<'_>) -> TestOutcome {
    let properties = query_properties!(context, vk::PhysicalDeviceConservativeRasterizationPropertiesEXT);
    log::info!("{properties:?}");
    validate_all(&[
        min_f32(
            "conservativeRasterizationPropertiesEXT.primitiveOverestimationSize",
            properties.primitive_overestimation_size,
            0.0,
        ),
        min_f32(
            "conservativeRasterizationPropertiesEXT.maxExtraPrimitiveOverestimationSize",
            properties.max_extra_primitive_overestimation_size,
            0.0,
        ),
        min_f32(
            "conservativeRasterizationPropertiesEXT.extraPrimitiveOverestimationSizeGranularity",
            properties.extra_primitive_overestimation_size_granularity,
            0.0,
        ),
    ])
}

fn check_support_ext_descriptor_indexing(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_descriptor_indexing")
}

fn validate_limits_ext_descriptor_indexing(context: &Context<'_>) -> TestOutcome {
    let mut properties2 = vk::PhysicalDeviceProperties2::default();
    unsafe {
        context
            .get_instance()
            .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
    };
    let limits = properties2.properties.limits;
    let di = query_properties!(context, vk::PhysicalDeviceDescriptorIndexingProperties);
    let features = *context.get_device_features();
    let tessellation_shader_count = if features.tessellation_shader != vk::FALSE {
        2
    } else {
        0
    };
    let geometry_shader_count = if features.geometry_shader != vk::FALSE { 1 } else { 0 };
    let shader_stages = 3 + tessellation_shader_count + geometry_shader_count;
    log::info!("{di:?}");

    validate_all(&[
        min_u32(
            "descriptorIndexingProperties.maxUpdateAfterBindDescriptorsInAllPools",
            di.max_update_after_bind_descriptors_in_all_pools,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindSamplers",
            di.max_per_stage_descriptor_update_after_bind_samplers,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindUniformBuffers",
            di.max_per_stage_descriptor_update_after_bind_uniform_buffers,
            12,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindStorageBuffers",
            di.max_per_stage_descriptor_update_after_bind_storage_buffers,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindSampledImages",
            di.max_per_stage_descriptor_update_after_bind_sampled_images,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindStorageImages",
            di.max_per_stage_descriptor_update_after_bind_storage_images,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindInputAttachments",
            di.max_per_stage_descriptor_update_after_bind_input_attachments,
            4,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageUpdateAfterBindResources",
            di.max_per_stage_update_after_bind_resources,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindSamplers",
            di.max_descriptor_set_update_after_bind_samplers,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindUniformBuffers",
            di.max_descriptor_set_update_after_bind_uniform_buffers,
            shader_stages * 12,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindUniformBuffersDynamic",
            di.max_descriptor_set_update_after_bind_uniform_buffers_dynamic,
            8,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindStorageBuffers",
            di.max_descriptor_set_update_after_bind_storage_buffers,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindStorageBuffersDynamic",
            di.max_descriptor_set_update_after_bind_storage_buffers_dynamic,
            4,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindSampledImages",
            di.max_descriptor_set_update_after_bind_sampled_images,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindStorageImages",
            di.max_descriptor_set_update_after_bind_storage_images,
            500000,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindInputAttachments",
            di.max_descriptor_set_update_after_bind_input_attachments,
            4,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindSamplers",
            di.max_per_stage_descriptor_update_after_bind_samplers,
            limits.max_per_stage_descriptor_samplers,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindUniformBuffers",
            di.max_per_stage_descriptor_update_after_bind_uniform_buffers,
            limits.max_per_stage_descriptor_uniform_buffers,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindStorageBuffers",
            di.max_per_stage_descriptor_update_after_bind_storage_buffers,
            limits.max_per_stage_descriptor_storage_buffers,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindSampledImages",
            di.max_per_stage_descriptor_update_after_bind_sampled_images,
            limits.max_per_stage_descriptor_sampled_images,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindStorageImages",
            di.max_per_stage_descriptor_update_after_bind_storage_images,
            limits.max_per_stage_descriptor_storage_images,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageDescriptorUpdateAfterBindInputAttachments",
            di.max_per_stage_descriptor_update_after_bind_input_attachments,
            limits.max_per_stage_descriptor_input_attachments,
        ),
        min_u32(
            "descriptorIndexingProperties.maxPerStageUpdateAfterBindResources",
            di.max_per_stage_update_after_bind_resources,
            limits.max_per_stage_resources,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindSamplers",
            di.max_descriptor_set_update_after_bind_samplers,
            limits.max_descriptor_set_samplers,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindUniformBuffers",
            di.max_descriptor_set_update_after_bind_uniform_buffers,
            limits.max_descriptor_set_uniform_buffers,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindUniformBuffersDynamic",
            di.max_descriptor_set_update_after_bind_uniform_buffers_dynamic,
            limits.max_descriptor_set_uniform_buffers_dynamic,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindStorageBuffers",
            di.max_descriptor_set_update_after_bind_storage_buffers,
            limits.max_descriptor_set_storage_buffers,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindStorageBuffersDynamic",
            di.max_descriptor_set_update_after_bind_storage_buffers_dynamic,
            limits.max_descriptor_set_storage_buffers_dynamic,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindSampledImages",
            di.max_descriptor_set_update_after_bind_sampled_images,
            limits.max_descriptor_set_sampled_images,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindStorageImages",
            di.max_descriptor_set_update_after_bind_storage_images,
            limits.max_descriptor_set_storage_images,
        ),
        min_u32(
            "descriptorIndexingProperties.maxDescriptorSetUpdateAfterBindInputAttachments",
            di.max_descriptor_set_update_after_bind_input_attachments,
            limits.max_descriptor_set_input_attachments,
        ),
    ])
}

fn check_support_ext_inline_uniform_block(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_inline_uniform_block")
}

fn validate_limits_ext_inline_uniform_block(context: &Context<'_>) -> TestOutcome {
    let p = query_properties!(context, vk::PhysicalDeviceInlineUniformBlockProperties);
    log::info!("{p:?}");
    validate_all(&[
        min_u32(
            "inlineUniformBlockPropertiesEXT.maxInlineUniformBlockSize",
            p.max_inline_uniform_block_size,
            256,
        ),
        min_u32(
            "inlineUniformBlockPropertiesEXT.maxPerStageDescriptorInlineUniformBlocks",
            p.max_per_stage_descriptor_inline_uniform_blocks,
            4,
        ),
        min_u32(
            "inlineUniformBlockPropertiesEXT.maxPerStageDescriptorUpdateAfterBindInlineUniformBlocks",
            p.max_per_stage_descriptor_update_after_bind_inline_uniform_blocks,
            4,
        ),
        min_u32(
            "inlineUniformBlockPropertiesEXT.maxDescriptorSetInlineUniformBlocks",
            p.max_descriptor_set_inline_uniform_blocks,
            4,
        ),
        min_u32(
            "inlineUniformBlockPropertiesEXT.maxDescriptorSetUpdateAfterBindInlineUniformBlocks",
            p.max_descriptor_set_update_after_bind_inline_uniform_blocks,
            4,
        ),
    ])
}

fn check_support_ext_vertex_attribute_divisor(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_vertex_attribute_divisor")
}

fn validate_limits_ext_vertex_attribute_divisor(context: &Context<'_>) -> TestOutcome {
    let p = query_properties!(context, vk::PhysicalDeviceVertexAttributeDivisorPropertiesEXT);
    log::info!("{p:?}");
    validate_all(&[min_u32(
        "vertexAttributeDivisorPropertiesEXT.maxVertexAttribDivisor",
        p.max_vertex_attrib_divisor,
        (1 << 16) - 1,
    )])
}

fn check_support_khr_vertex_attribute_divisor(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_KHR_vertex_attribute_divisor")
}

fn validate_limits_khr_vertex_attribute_divisor(context: &Context<'_>) -> TestOutcome {
    let p = query_properties!(context, vk::PhysicalDeviceVertexAttributeDivisorProperties);
    log::info!("{p:?}");
    validate_all(&[min_u32(
        "vertexAttributeDivisorProperties.maxVertexAttribDivisor",
        p.max_vertex_attrib_divisor,
        (1 << 16) - 1,
    )])
}

fn check_support_nv_mesh_shader(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_NV_mesh_shader")
}

fn validate_limits_nv_mesh_shader(context: &Context<'_>) -> TestOutcome {
    let p = query_properties!(context, vk::PhysicalDeviceMeshShaderPropertiesNV);
    log::info!("{p:?}");
    validate_all(&[
        min_u32(
            "meshShaderPropertiesNV.maxDrawMeshTasksCount",
            p.max_draw_mesh_tasks_count,
            (1u64 << 16) as u32 - 1,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxTaskWorkGroupInvocations",
            p.max_task_work_group_invocations,
            32,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxTaskWorkGroupSize[0]",
            p.max_task_work_group_size[0],
            32,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxTaskWorkGroupSize[1]",
            p.max_task_work_group_size[1],
            1,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxTaskWorkGroupSize[2]",
            p.max_task_work_group_size[2],
            1,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxTaskTotalMemorySize",
            p.max_task_total_memory_size,
            16384,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxTaskOutputCount",
            p.max_task_output_count,
            (1 << 16) - 1,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxMeshWorkGroupInvocations",
            p.max_mesh_work_group_invocations,
            32,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxMeshWorkGroupSize[0]",
            p.max_mesh_work_group_size[0],
            32,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxMeshWorkGroupSize[1]",
            p.max_mesh_work_group_size[1],
            1,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxMeshWorkGroupSize[2]",
            p.max_mesh_work_group_size[2],
            1,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxMeshTotalMemorySize",
            p.max_mesh_total_memory_size,
            16384,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxMeshOutputVertices",
            p.max_mesh_output_vertices,
            256,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxMeshOutputPrimitives",
            p.max_mesh_output_primitives,
            256,
        ),
        min_u32(
            "meshShaderPropertiesNV.maxMeshMultiviewViewCount",
            p.max_mesh_multiview_view_count,
            1,
        ),
    ])
}

fn check_support_ext_transform_feedback(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_transform_feedback")
}

fn validate_limits_ext_transform_feedback(context: &Context<'_>) -> TestOutcome {
    let p = query_properties!(context, vk::PhysicalDeviceTransformFeedbackPropertiesEXT);
    log::info!("{p:?}");
    validate_all(&[
        min_u32(
            "transformFeedbackPropertiesEXT.maxTransformFeedbackStreams",
            p.max_transform_feedback_streams,
            1,
        ),
        min_u32(
            "transformFeedbackPropertiesEXT.maxTransformFeedbackBuffers",
            p.max_transform_feedback_buffers,
            1,
        ),
        min_size(
            "transformFeedbackPropertiesEXT.maxTransformFeedbackBufferSize",
            p.max_transform_feedback_buffer_size,
            1u64 << 27,
        ),
        min_u32(
            "transformFeedbackPropertiesEXT.maxTransformFeedbackStreamDataSize",
            p.max_transform_feedback_stream_data_size,
            512,
        ),
        min_u32(
            "transformFeedbackPropertiesEXT.maxTransformFeedbackBufferDataSize",
            p.max_transform_feedback_buffer_data_size,
            512,
        ),
        min_u32(
            "transformFeedbackPropertiesEXT.maxTransformFeedbackBufferDataStride",
            p.max_transform_feedback_buffer_data_stride,
            512,
        ),
    ])
}

fn check_support_ext_fragment_density_map(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_fragment_density_map")
}

fn validate_limits_ext_fragment_density_map(context: &Context<'_>) -> TestOutcome {
    let p = query_properties!(context, vk::PhysicalDeviceFragmentDensityMapPropertiesEXT);
    log::info!("{p:?}");
    validate_all(&[
        min_u32(
            "fragmentDensityMapPropertiesEXT.minFragmentDensityTexelSize.width",
            p.min_fragment_density_texel_size.width,
            1,
        ),
        min_u32(
            "fragmentDensityMapPropertiesEXT.minFragmentDensityTexelSize.height",
            p.min_fragment_density_texel_size.height,
            1,
        ),
        min_u32(
            "fragmentDensityMapPropertiesEXT.maxFragmentDensityTexelSize.width",
            p.max_fragment_density_texel_size.width,
            1,
        ),
        min_u32(
            "fragmentDensityMapPropertiesEXT.maxFragmentDensityTexelSize.height",
            p.max_fragment_density_texel_size.height,
            1,
        ),
    ])
}

fn check_support_nv_ray_tracing(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_NV_ray_tracing")
}

fn validate_limits_nv_ray_tracing(context: &Context<'_>) -> TestOutcome {
    let p = query_properties!(context, vk::PhysicalDeviceRayTracingPropertiesNV);
    log::info!("{p:?}");
    validate_all(&[
        min_u32(
            "rayTracingPropertiesNV.shaderGroupHandleSize",
            p.shader_group_handle_size,
            16,
        ),
        min_u32("rayTracingPropertiesNV.maxRecursionDepth", p.max_recursion_depth, 31),
        min_u32(
            "rayTracingPropertiesNV.shaderGroupBaseAlignment",
            p.shader_group_base_alignment,
            64,
        ),
        min_u32(
            "rayTracingPropertiesNV.maxGeometryCount",
            p.max_geometry_count as u32,
            (1 << 24) - 1,
        ),
        min_u32(
            "rayTracingPropertiesNV.maxInstanceCount",
            p.max_instance_count as u32,
            (1 << 24) - 1,
        ),
        min_u32(
            "rayTracingPropertiesNV.maxTriangleCount",
            p.max_triangle_count as u32,
            (1 << 29) - 1,
        ),
        min_u32(
            "rayTracingPropertiesNV.maxDescriptorSetAccelerationStructures",
            p.max_descriptor_set_acceleration_structures,
            16,
        ),
    ])
}

fn check_support_khr_timeline_semaphore(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_KHR_timeline_semaphore")
}

fn validate_limits_khr_timeline_semaphore(context: &Context<'_>) -> TestOutcome {
    let p = query_properties!(context, vk::PhysicalDeviceTimelineSemaphoreProperties);
    log::info!("{p:?}");
    validate_all(&[min_size(
        "timelineSemaphoreProperties.maxTimelineSemaphoreValueDifference",
        p.max_timeline_semaphore_value_difference,
        (1u64 << 31) - 1,
    )])
}

fn check_support_ext_line_rasterization(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_EXT_line_rasterization")
}

fn check_support_khr_line_rasterization(context: &Context<'_>) -> Result<(), TestError> {
    check_support_extension(context, "VK_KHR_line_rasterization")
}

fn validate_limits_line_rasterization(context: &Context<'_>) -> TestOutcome {
    let p = query_properties!(context, vk::PhysicalDeviceLineRasterizationProperties);
    log::info!("{p:?}");
    validate_all(&[min_u32(
        "lineRasterizationProperties.lineSubPixelPrecisionBits",
        p.line_sub_pixel_precision_bits,
        4,
    )])
}

fn check_support_robustness2(context: &Context<'_>) -> Result<(), TestError> {
    if !context.is_device_functionality_supported("VK_EXT_robustness2")
        && !context.is_device_functionality_supported("VK_KHR_robustness2")
    {
        return Err(TestError::NotSupported(
            "VK_EXT_robustness2 and VK_KHR_robustness2 are not supported".to_string(),
        ));
    }
    Ok(())
}

fn validate_limits_robustness2(context: &Context<'_>) -> TestOutcome {
    let properties = query_properties!(context, vk::PhysicalDeviceRobustness2PropertiesEXT);

    let mut robustness2_features = vk::PhysicalDeviceRobustness2FeaturesEXT::default();
    let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut robustness2_features);
    unsafe {
        context
            .get_instance()
            .get_physical_device_features2(context.get_physical_device(), &mut features2)
    };
    let robust_buffer_access = features2.features.robust_buffer_access;

    if robustness2_features.robust_buffer_access2 != vk::FALSE && robust_buffer_access == vk::FALSE {
        return Ok(TestStatus::fail(
            "If robustBufferAccess2 is enabled then robustBufferAccess must also be enabled",
        ));
    }

    let storage_alignment = properties.robust_storage_buffer_access_size_alignment;
    if storage_alignment != 1 && storage_alignment != 4 {
        return Ok(TestStatus::fail(
            "robustness2Properties.robustStorageBufferAccessSizeAlignment value must be either 1 or 4.",
        ));
    }

    let uniform_alignment = properties.robust_uniform_buffer_access_size_alignment;
    if !(1..=256).contains(&uniform_alignment) || !uniform_alignment.is_power_of_two() {
        return Ok(TestStatus::fail(
            "robustness2Properties.robustUniformBufferAccessSizeAlignment must be a power of two in the range [1, 256]",
        ));
    }

    Ok(TestStatus::pass("pass"))
}

pub fn add_limits_validation12_groups(info_tests: &mut TestCaseGroup) {
    let mut group = TestCaseGroup::new("vulkan1p2_limits_validation");

    add_function_case(&mut group, "general", check_support_api_1_2, validate_limits12);
    add_function_case(
        &mut group,
        "khr_push_descriptor",
        check_support_push_descriptor,
        validate_limits_khr_push_descriptor,
    );
    add_function_case(
        &mut group,
        "khr_multiview",
        check_support_khr_multiview,
        validate_limits_khr_multiview,
    );
    add_function_case(
        &mut group,
        "ext_discard_rectangles",
        check_support_ext_discard_rectangles,
        validate_limits_ext_discard_rectangles,
    );
    add_function_case(
        &mut group,
        "ext_sample_locations",
        check_support_ext_sample_locations,
        validate_limits_ext_sample_locations,
    );
    add_function_case(
        &mut group,
        "ext_external_memory_host",
        check_support_ext_external_memory_host,
        validate_limits_ext_external_memory_host,
    );
    add_function_case(
        &mut group,
        "ext_blend_operation_advanced",
        check_support_ext_blend_operation_advanced,
        validate_limits_ext_blend_operation_advanced,
    );
    add_function_case(
        &mut group,
        "khr_maintenance_3",
        check_support_khr_maintenance3,
        validate_limits_khr_maintenance3,
    );
    add_function_case(
        &mut group,
        "ext_conservative_rasterization",
        check_support_ext_conservative_rasterization,
        validate_limits_ext_conservative_rasterization,
    );
    add_function_case(
        &mut group,
        "ext_descriptor_indexing",
        check_support_ext_descriptor_indexing,
        validate_limits_ext_descriptor_indexing,
    );
    add_function_case(
        &mut group,
        "ext_inline_uniform_block",
        check_support_ext_inline_uniform_block,
        validate_limits_ext_inline_uniform_block,
    );
    add_function_case(
        &mut group,
        "ext_vertex_attribute_divisor",
        check_support_ext_vertex_attribute_divisor,
        validate_limits_ext_vertex_attribute_divisor,
    );
    add_function_case(
        &mut group,
        "khr_vertex_attribute_divisor",
        check_support_khr_vertex_attribute_divisor,
        validate_limits_khr_vertex_attribute_divisor,
    );
    add_function_case(
        &mut group,
        "nv_mesh_shader",
        check_support_nv_mesh_shader,
        validate_limits_nv_mesh_shader,
    );
    add_function_case(
        &mut group,
        "ext_transform_feedback",
        check_support_ext_transform_feedback,
        validate_limits_ext_transform_feedback,
    );
    add_function_case(
        &mut group,
        "fragment_density_map",
        check_support_ext_fragment_density_map,
        validate_limits_ext_fragment_density_map,
    );
    add_function_case(
        &mut group,
        "nv_ray_tracing",
        check_support_nv_ray_tracing,
        validate_limits_nv_ray_tracing,
    );
    add_function_case(
        &mut group,
        "timeline_semaphore",
        check_support_khr_timeline_semaphore,
        validate_limits_khr_timeline_semaphore,
    );
    add_function_case(
        &mut group,
        "ext_line_rasterization",
        check_support_ext_line_rasterization,
        validate_limits_line_rasterization,
    );
    add_function_case(
        &mut group,
        "khr_line_rasterization",
        check_support_khr_line_rasterization,
        validate_limits_line_rasterization,
    );
    add_function_case(
        &mut group,
        "robustness2",
        check_support_robustness2,
        validate_limits_robustness2,
    );

    info_tests.add_child(group);
}
