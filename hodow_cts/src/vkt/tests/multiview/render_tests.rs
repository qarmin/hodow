// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/multiview/vktMultiViewRenderTests.cpp
//   external/vulkancts/modules/vulkan/multiview/vktMultiViewRenderUtil.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2016 Samsung Electronics Co., Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The per test type subclasses of `MultiViewRenderTestInstance` become
// `DrawKind` branches of one draw routine, in the same order of Vulkan calls. The types with their own instance logic live in
// the child modules.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, InstanceV1_1};

use crate::generated::shaders::multiview_render::{
    MV_CLEAR_ATTACHMENTS, MV_DEPTH, MV_DEPTH_DIFFERENT_RANGES, MV_DEPTH_WITHOUT_FRAGMENT_SHADER, MV_DRAW_INDEXED,
    MV_DRAW_INDIRECT, MV_DRAW_INDIRECT_INDEXED, MV_INPUT_ATTACHMENTS, MV_INPUT_ATTACHMENTS_GEOMETRY,
    MV_INPUT_RATE_INSTANCE, MV_INSTANCED_RENDERING, MV_MASKS, MV_MULTISAMPLE, MV_MULTISAMPLE_RESOLVE,
    MV_NESTED_CMD_BUFFER, MV_NON_PRECISE_QUERIES, MV_NON_PRECISE_QUERIES_AND_TIMESTAMPS,
    MV_NON_PRECISE_QUERIES_WITH_AVAILABILITY, MV_NON_PRECISE_QUERIES_WITH_AVAILABILITY_AND_TIMESTAMPS, MV_POINT_SIZE,
    MV_QUERIES, MV_QUERIES_AND_TIMESTAMPS, MV_READBACK_EXPLICIT_CLEAR, MV_READBACK_IMPLICIT_CLEAR,
    MV_SECONDARY_CMD_BUFFER, MV_SECONDARY_CMD_BUFFER_GEOMETRY, MV_STENCIL, MV_VIEW_INDEX_IN_FRAGMENT,
    MV_VIEW_INDEX_IN_GEOMETRY, MV_VIEW_INDEX_IN_TESSELLATION, MV_VIEW_INDEX_IN_VERTEX, MV_VIEW_MASK_ITERATION,
};
use crate::tcu::{Random, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{begin_rendering, clear_value_color, end_rendering, rect_2d};
use crate::vkt::tests::renderpass::group_params::RenderingType;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

mod depth_stencil;
mod mask_iteration;
mod multisample;
mod queries;
mod readback;

const POINT_SIZE_SMALL: i32 = 2;
const POINT_SIZE_WIDE: i32 = 4;
const SQUARE_COUNT: u32 = 4;
const MIN_SUPPORTED_MULTIVIEW_VIEW_COUNT: u32 = 6;

/// `TestType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    ViewMask,
    ViewIndexInVertex,
    ViewIndexInFragment,
    ViewIndexInGeometry,
    ViewIndexInTessellation,
    InputAttachments,
    InputAttachmentsGeometry,
    InstancedRendering,
    InputRateInstance,
    DrawIndirect,
    DrawIndirectIndexed,
    DrawIndexed,
    ClearAttachments,
    SecondaryCmdBuffer,
    SecondaryCmdBufferGeometry,
    PointSize,
    Multisample,
    MultisampleResolve,
    Queries,
    QueriesAndTimestamps,
    NonPreciseQueries,
    NonPreciseQueriesAndTimestamps,
    NonPreciseQueriesWithAvailability,
    NonPreciseQueriesWithAvailabilityAndTimestamps,
    ReadbackImplicitClear,
    ReadbackExplicitClear,
    Depth,
    DepthWithoutFragmentShader,
    DepthDifferentRanges,
    Stencil,
    ViewMaskIteration,
    NestedCmdBuffer,
}

impl TestType {
    fn name(self) -> &'static str {
        match self {
            Self::ViewMask => "masks",
            Self::ViewIndexInVertex => "vertex_shader",
            Self::ViewIndexInFragment => "fragment_shader",
            Self::ViewIndexInGeometry => "geometry_shader",
            Self::ViewIndexInTessellation => "tessellation_shader",
            Self::InputAttachments => "input_attachments",
            Self::InputAttachmentsGeometry => "input_attachments_geometry",
            Self::InstancedRendering => "instanced",
            Self::InputRateInstance => "input_instance",
            Self::DrawIndirect => "draw_indirect",
            Self::DrawIndirectIndexed => "draw_indirect_indexed",
            Self::DrawIndexed => "draw_indexed",
            Self::ClearAttachments => "clear_attachments",
            Self::SecondaryCmdBuffer => "secondary_cmd_buffer",
            Self::SecondaryCmdBufferGeometry => "secondary_cmd_buffer_geometry",
            Self::PointSize => "point_size",
            Self::Multisample => "multisample",
            Self::MultisampleResolve => "multisample_resolve",
            Self::Queries => "queries",
            Self::QueriesAndTimestamps => "queries_and_timestamps",
            Self::NonPreciseQueries => "non_precise_queries",
            Self::NonPreciseQueriesAndTimestamps => "non_precise_queries_and_timestamps",
            Self::NonPreciseQueriesWithAvailability => "non_precise_queries_with_availability",
            Self::NonPreciseQueriesWithAvailabilityAndTimestamps => {
                "non_precise_queries_with_availability_and_timestamps"
            }
            Self::ReadbackImplicitClear => "readback_implicit_clear",
            Self::ReadbackExplicitClear => "readback_explicit_clear",
            Self::Depth => "depth",
            Self::DepthWithoutFragmentShader => "depth_without_fragment_shader",
            Self::DepthDifferentRanges => "depth_different_ranges",
            Self::Stencil => "stencil",
            Self::ViewMaskIteration => "view_mask_iteration",
            Self::NestedCmdBuffer => "nested_cmd_buffer",
        }
    }

    /// `isQueryTestType`
    fn is_query(self) -> bool {
        matches!(
            self,
            Self::Queries
                | Self::QueriesAndTimestamps
                | Self::NonPreciseQueries
                | Self::NonPreciseQueriesAndTimestamps
                | Self::NonPreciseQueriesWithAvailability
                | Self::NonPreciseQueriesWithAvailabilityAndTimestamps
        )
    }

    /// `usePreciseQueries`
    fn precise_queries(self) -> bool {
        matches!(self, Self::Queries | Self::QueriesAndTimestamps)
    }

    /// `useTimestampQueries`
    fn timestamp_queries(self) -> bool {
        matches!(
            self,
            Self::QueriesAndTimestamps
                | Self::NonPreciseQueriesAndTimestamps
                | Self::NonPreciseQueriesWithAvailabilityAndTimestamps
        )
    }

    fn is_multisample(self) -> bool {
        matches!(self, Self::Multisample | Self::MultisampleResolve)
    }

    fn is_readback(self) -> bool {
        matches!(self, Self::ReadbackImplicitClear | Self::ReadbackExplicitClear)
    }

    fn is_depth_stencil(self) -> bool {
        matches!(
            self,
            Self::Depth | Self::DepthWithoutFragmentShader | Self::DepthDifferentRanges | Self::Stencil
        )
    }

    /// The types registered under `index` rather than directly under the rendering type's group.
    fn is_view_index(self) -> bool {
        matches!(
            self,
            Self::ViewIndexInVertex
                | Self::ViewIndexInFragment
                | Self::ViewIndexInGeometry
                | Self::ViewIndexInTessellation
        )
    }

    fn geometry_shader_needed(self) -> bool {
        matches!(
            self,
            Self::ViewIndexInGeometry | Self::InputAttachmentsGeometry | Self::SecondaryCmdBufferGeometry
        )
    }

    fn uses_attachments_instance(self) -> bool {
        matches!(self, Self::InputAttachments | Self::InputAttachmentsGeometry)
    }

    #[allow(dead_code)]
    fn uses_secondary_instance(self) -> bool {
        matches!(
            self,
            Self::SecondaryCmdBuffer | Self::SecondaryCmdBufferGeometry | Self::NestedCmdBuffer
        )
    }

    fn indexed(self) -> bool {
        matches!(self, Self::DrawIndexed | Self::DrawIndirectIndexed)
    }
}

/// `QueryType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum QueryType {
    None,
    GetQueryPoolResults,
    CmdCopyQueryPoolResults,
}

/// `TestParameters`
#[derive(Clone)]
struct TestParameters {
    extent: vk::Extent3D,
    view_masks: Vec<u32>,
    view_index: TestType,
    samples: vk::SampleCountFlags,
    color_format: vk::Format,
    query_type: QueryType,
    rendering_type: RenderingType,
    use_general_layout: bool,
}

struct MultiViewRenderTestsCase {
    name: String,
    params: TestParameters,
}

impl TestCase for MultiViewRenderTestsCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MultiViewRenderTestsCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let p = &self.params;
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut multiview_features = vk::PhysicalDeviceMultiviewFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut multiview_features);
        unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };

        if p.view_index.geometry_shader_needed() {
            if context.get_device_features().geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported("geometryShader not supported".to_string()));
            }
            if multiview_features.multiview_geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "multiviewGeometryShader not supported".to_string(),
                ));
            }
        }

        if p.rendering_type == RenderingType::RenderPass2 {
            context.require_device_functionality("VK_KHR_create_renderpass2")?;
        }
        if p.rendering_type == RenderingType::DynamicRendering {
            context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        }
        context.require_device_functionality("VK_KHR_multiview")?;

        if p.view_index == TestType::NestedCmdBuffer {
            context.require_device_functionality("VK_EXT_nested_command_buffer")?;
        }
        if p.view_index == TestType::DepthDifferentRanges {
            context.require_device_functionality("VK_EXT_depth_range_unrestricted")?;
        }
        if p.view_index == TestType::ViewIndexInTessellation
            && multiview_features.multiview_tessellation_shader == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "multiviewTessellationShader not supported".to_string(),
            ));
        }

        let mut multiview_properties = vk::PhysicalDeviceMultiviewProperties::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut multiview_properties);
        unsafe { instance.get_physical_device_properties2(physical_device, &mut properties2) };
        if multiview_properties.max_multiview_view_count < MIN_SUPPORTED_MULTIVIEW_VIEW_COUNT {
            return Err(TestError::NotSupported(
                "maxMultiviewViewCount below min value".to_string(),
            ));
        }

        if p.view_index.precise_queries() && context.get_device_features().occlusion_query_precise == vk::FALSE {
            return Err(TestError::NotSupported(
                "occlusionQueryPrecise not supported".to_string(),
            ));
        }

        if p.view_index == TestType::PointSize {
            if context.get_device_features().large_points == vk::FALSE {
                return Err(TestError::NotSupported("largePoints not supported".to_string()));
            }

            // The small (still large) point size is always used. The large point size is only used for views other than the first one.
            let mut used_point_sizes = vec![POINT_SIZE_SMALL as u32];
            if p.extent.depth > 1 {
                used_point_sizes.push(POINT_SIZE_WIDE as u32);
            }

            let limits = &context.get_device_properties().limits;
            for point_size in used_point_sizes {
                let test_point_size_float = point_size as f32;
                if test_point_size_float < limits.point_size_range[0]
                    || test_point_size_float > limits.point_size_range[1]
                {
                    return Err(TestError::NotSupported(
                        "Required point size is outside of the the limits range".to_string(),
                    ));
                }

                let granule_count =
                    ((test_point_size_float - limits.point_size_range[0]) / limits.point_size_granularity).ceil();
                if limits.point_size_range[0] + granule_count * limits.point_size_granularity != test_point_size_float {
                    return Err(TestError::NotSupported(
                        "Granuliraty does not allow to get required point size".to_string(),
                    ));
                }
            }
        }

        if p.view_index != TestType::PointSize && p.view_index.timestamp_queries() {
            let queue_properties = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };
            if queue_properties[context.get_universal_queue_family_index() as usize].timestamp_valid_bits == 0 {
                return Err(TestError::NotSupported("Timestamps not supported".to_string()));
            }
        }

        if p.view_index == TestType::NestedCmdBuffer {
            let mut nested_features = vk::PhysicalDeviceNestedCommandBufferFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut nested_features);
            unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
            if nested_features.nested_command_buffer == vk::FALSE {
                return Err(TestError::NotSupported(
                    "nestedCommandBuffer is not supported".to_string(),
                ));
            }
            if nested_features.nested_command_buffer_rendering == vk::FALSE {
                return Err(TestError::NotSupported(
                    "nestedCommandBufferRendering is not supported".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        match self.params.view_index {
            TestType::ViewMask => MV_MASKS.programs,
            TestType::ViewIndexInVertex => MV_VIEW_INDEX_IN_VERTEX.programs,
            TestType::ViewIndexInFragment => MV_VIEW_INDEX_IN_FRAGMENT.programs,
            TestType::ViewIndexInGeometry => MV_VIEW_INDEX_IN_GEOMETRY.programs,
            TestType::ViewIndexInTessellation => MV_VIEW_INDEX_IN_TESSELLATION.programs,
            TestType::InputAttachments => MV_INPUT_ATTACHMENTS.programs,
            TestType::InputAttachmentsGeometry => MV_INPUT_ATTACHMENTS_GEOMETRY.programs,
            TestType::InstancedRendering => MV_INSTANCED_RENDERING.programs,
            TestType::InputRateInstance => MV_INPUT_RATE_INSTANCE.programs,
            TestType::DrawIndirect => MV_DRAW_INDIRECT.programs,
            TestType::DrawIndirectIndexed => MV_DRAW_INDIRECT_INDEXED.programs,
            TestType::DrawIndexed => MV_DRAW_INDEXED.programs,
            TestType::ClearAttachments => MV_CLEAR_ATTACHMENTS.programs,
            TestType::SecondaryCmdBuffer => MV_SECONDARY_CMD_BUFFER.programs,
            TestType::SecondaryCmdBufferGeometry => MV_SECONDARY_CMD_BUFFER_GEOMETRY.programs,
            TestType::PointSize => MV_POINT_SIZE.programs,
            TestType::Multisample => MV_MULTISAMPLE.programs,
            TestType::MultisampleResolve => MV_MULTISAMPLE_RESOLVE.programs,
            TestType::Queries => MV_QUERIES.programs,
            TestType::QueriesAndTimestamps => MV_QUERIES_AND_TIMESTAMPS.programs,
            TestType::NonPreciseQueries => MV_NON_PRECISE_QUERIES.programs,
            TestType::NonPreciseQueriesAndTimestamps => MV_NON_PRECISE_QUERIES_AND_TIMESTAMPS.programs,
            TestType::NonPreciseQueriesWithAvailability => MV_NON_PRECISE_QUERIES_WITH_AVAILABILITY.programs,
            TestType::NonPreciseQueriesWithAvailabilityAndTimestamps => {
                MV_NON_PRECISE_QUERIES_WITH_AVAILABILITY_AND_TIMESTAMPS.programs
            }
            TestType::ReadbackImplicitClear => MV_READBACK_IMPLICIT_CLEAR.programs,
            TestType::ReadbackExplicitClear => MV_READBACK_EXPLICIT_CLEAR.programs,
            TestType::Depth => MV_DEPTH.programs,
            TestType::DepthWithoutFragmentShader => MV_DEPTH_WITHOUT_FRAGMENT_SHADER.programs,
            TestType::DepthDifferentRanges => MV_DEPTH_DIFFERENT_RANGES.programs,
            TestType::Stencil => MV_STENCIL.programs,
            TestType::ViewMaskIteration => MV_VIEW_MASK_ITERATION.programs,
            TestType::NestedCmdBuffer => MV_NESTED_CMD_BUFFER.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultiViewRenderTestInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct MultiViewRenderTestInstance<'a> {
    context: &'a Context<'a>,
    params: TestParameters,
}

/// `ImageAttachment`
struct ImageAttachment<'a> {
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
}

/// `isDepthStencilFormat`
fn is_depth_stencil_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::D24_UNORM_S8_UINT
            | vk::Format::D32_SFLOAT_S8_UINT
            | vk::Format::D16_UNORM_S8_UINT
            | vk::Format::D16_UNORM
            | vk::Format::D32_SFLOAT
            | vk::Format::X8_D24_UNORM_PACK32
    )
}

impl<'a> ImageAttachment<'a> {
    fn new(
        context: &'a Context<'a>,
        extent: vk::Extent3D,
        format: vk::Format,
        samples: vk::SampleCountFlags,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let depth_stencil_format = is_depth_stencil_format(format);
        let aspect_flags = if depth_stencil_format {
            vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::COLOR
        };
        let subresource_range = make_image_subresource_range(aspect_flags, 0, 1, 0, extent.depth);
        let usage_dependent = if depth_stencil_format {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
        } else {
            vk::ImageUsageFlags::COLOR_ATTACHMENT
        };
        let usage = usage_dependent
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::INPUT_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_DST;
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width: extent.width,
                height: extent.height,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(extent.depth)
            .samples(samples)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, context.get_default_allocator(), info, MemoryRequirement::ANY)?;
        let view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D_ARRAY,
            format,
            subresource_range,
        )?;
        Ok(Self { image, view })
    }
}

/// The vertex data `createVertexData` builds: one coordinate and one colour per vertex, and the shuffled index list of the indexed
/// types.
struct VertexData {
    coord: Vec<[f32; 4]>,
    color: Vec<[f32; 4]>,
    indices: Vec<u32>,
}

impl VertexData {
    fn append(&mut self, coord: [f32; 4], color: [f32; 4]) {
        self.coord.push(coord);
        self.color.push(color);
    }
}

/// `createVertexData` of the base class and its overrides.
fn create_vertex_data(kind: TestType, extent: vk::Extent3D, seed: u32) -> VertexData {
    let mut data = VertexData {
        coord: Vec::new(),
        color: Vec::new(),
        indices: Vec::new(),
    };

    match kind {
        TestType::InstancedRendering => {
            let color = [0.2, 0.0, 0.1, 1.0];
            data.append([-1.0, -1.0, 1.0, 1.0], color);
            data.append([-1.0, 0.0, 1.0, 1.0], color);
            data.append([0.0, -1.0, 1.0, 1.0], color);
            data.append([0.0, 0.0, 1.0, 1.0], color);
        }
        TestType::InputRateInstance => {
            data.append([-1.0, -1.0, 1.0, 1.0], [0.2, 0.0, 0.1, 1.0]);
            data.append([-1.0, 0.0, 1.0, 1.0], [0.3, 0.0, 0.2, 1.0]);
            data.append([0.0, -1.0, 1.0, 1.0], [0.4, 0.2, 0.3, 1.0]);
            data.append([0.0, 0.0, 1.0, 1.0], [0.5, 0.0, 0.4, 1.0]);
        }
        TestType::Multisample | TestType::MultisampleResolve => {
            let mut color = [1.0, 0.0, 0.0, 1.0];
            data.append([-1.0, 0.0, 1.0, 1.0], color);
            data.append([-1.0, -1.0, 1.0, 1.0], color);
            data.append([0.0, -1.0, 1.0, 1.0], color);

            color = [0.0, 1.0, 0.0, 1.0];
            data.append([-1.0, 1.0, 1.0, 1.0], color);
            data.append([-1.0, 0.0, 1.0, 1.0], color);
            data.append([0.0, 0.0, 1.0, 1.0], color);

            color = [0.0, 0.0, 1.0, 1.0];
            data.append([0.0, 0.0, 1.0, 1.0], color);
            data.append([0.0, -1.0, 1.0, 1.0], color);
            data.append([1.0, -1.0, 1.0, 1.0], color);

            color = [1.0, 1.0, 1.0, 1.0];
            data.append([0.0, 1.0, 1.0, 1.0], color);
            data.append([0.0, 0.0, 1.0, 1.0], color);
            data.append([1.0, 0.0, 1.0, 1.0], color);
        }
        TestType::PointSize => {
            let pixel_step_x = 2.0 / extent.width as f32;
            let pixel_step_y = 2.0 / extent.height as f32;
            let point_margin = (1 + POINT_SIZE_WIDE / 2) as f32;

            data.append(
                [
                    -1.0 + point_margin * pixel_step_x,
                    -1.0 + point_margin * pixel_step_y,
                    1.0,
                    1.0,
                ],
                [1.0, 0.0, 0.0, 1.0],
            );
            data.append(
                [
                    -1.0 + point_margin * pixel_step_x,
                    0.0 + point_margin * pixel_step_y,
                    1.0,
                    1.0,
                ],
                [0.0, 1.0, 0.0, 1.0],
            );
            data.append(
                [
                    0.0 + point_margin * pixel_step_x,
                    -1.0 + point_margin * pixel_step_y,
                    1.0,
                    1.0,
                ],
                [0.0, 0.0, 1.0, 1.0],
            );
            data.append(
                [
                    0.0 + point_margin * pixel_step_x,
                    0.0 + point_margin * pixel_step_y,
                    1.0,
                    1.0,
                ],
                [1.0, 0.5, 0.3, 1.0],
            );
        }
        _ => {
            let mut color = [0.2, 0.0, 0.1, 1.0];
            data.append([-1.0, -1.0, 1.0, 1.0], color);
            data.append([-1.0, 0.0, 1.0, 1.0], color);
            data.append([0.0, -1.0, 1.0, 1.0], color);
            data.append([0.0, 0.0, 1.0, 1.0], color);

            color = [0.3, 0.0, 0.2, 1.0];
            data.append([-1.0, 0.0, 1.0, 1.0], color);
            data.append([-1.0, 1.0, 1.0, 1.0], color);
            data.append([0.0, 0.0, 1.0, 1.0], color);
            data.append([0.0, 1.0, 1.0, 1.0], color);

            color = [0.4, 0.2, 0.3, 1.0];
            data.append([0.0, -1.0, 1.0, 1.0], color);
            data.append([0.0, 0.0, 1.0, 1.0], color);
            data.append([1.0, -1.0, 1.0, 1.0], color);
            data.append([1.0, 0.0, 1.0, 1.0], color);

            color = [0.5, 0.0, 0.4, 1.0];
            data.append([0.0, 0.0, 1.0, 1.0], color);
            data.append([0.0, 1.0, 1.0, 1.0], color);
            data.append([1.0, 0.0, 1.0, 1.0], color);
            data.append([1.0, 1.0, 1.0, 1.0], color);

            if kind.indexed() {
                let vertices_count = data.coord.len();
                data.indices = (0..vertices_count as u32).collect();
                Random::new(seed).shuffle(&mut data.indices);

                let mut vertex_color = vec![[0.0f32; 4]; vertices_count];
                let mut vertex_coord = vec![[0.0f32; 4]; vertices_count];
                for vertex_idx in 0..vertices_count {
                    vertex_color[data.indices[vertex_idx] as usize] = data.color[vertex_idx];
                }
                for vertex_idx in 0..vertices_count {
                    vertex_coord[data.indices[vertex_idx] as usize] = data.coord[vertex_idx];
                }
                data.color = vertex_color;
                data.coord = vertex_coord;
            }
        }
    }
    data
}

/// A `tcu::Texture2DArray`. An RGBA8 one keeps what the format can hold, so `set_pixel` quantizes.
struct Reference {
    width: u32,
    height: u32,
    quantize: bool,
    pixels: Vec<[f32; 4]>,
}

fn to_unorm8(value: f32) -> u8 {
    (value.clamp(0.0, 1.0) * 255.0 + 0.5) as u8
}

impl Reference {
    fn new(extent: vk::Extent3D, format: vk::Format) -> Self {
        Self {
            width: extent.width,
            height: extent.height,
            quantize: format == vk::Format::R8G8B8A8_UNORM,
            pixels: vec![[0.0; 4]; (extent.width * extent.height * extent.depth) as usize],
        }
    }

    fn index(&self, x: i32, y: i32, layer: i32) -> usize {
        (layer as u32 * self.height * self.width + y as u32 * self.width + x as u32) as usize
    }

    fn get_pixel(&self, x: i32, y: i32, layer: i32) -> [f32; 4] {
        self.pixels[self.index(x, y, layer)]
    }

    fn set_pixel(&mut self, color: [f32; 4], x: i32, y: i32, layer: i32) {
        let index = self.index(x, y, layer);
        self.pixels[index] = if self.quantize {
            color.map(|c| to_unorm8(c) as f32 / 255.0)
        } else {
            color
        };
    }

    /// The pixels as the bytes of the format, for uploading them.
    fn to_bytes(&self) -> Vec<u8> {
        if self.quantize {
            self.pixels.iter().flatten().map(|&c| to_unorm8(c)).collect()
        } else {
            self.pixels.iter().flatten().flat_map(|c| c.to_le_bytes()).collect()
        }
    }

    /// `fillLayer`
    fn fill_layer(&mut self, color: [f32; 4], layer: i32) {
        for y in 0..self.height {
            for x in 0..self.width {
                self.set_pixel(color, x as i32, y as i32, layer);
            }
        }
    }

    /// `fillQuarter` for the types that are not depth or stencil tests.
    fn fill_quarter(&mut self, color: [f32; 4], layer: i32, quarter: u32) {
        let h = self.height as i32;
        let h2 = h / 2;
        let w = self.width as i32;
        let w2 = w / 2;

        let (x_start, x_end, y_start, y_end) = match quarter {
            0 => (0, w2, 0, h2),
            1 => (0, w2, h2, h),
            2 => (w2, w, 0, h2),
            _ => (w2, w, h2, h),
        };

        for y in y_start..y_end {
            for x in x_start..x_end {
                self.set_pixel(color, x, y, layer);
            }
        }
    }

    /// `fillTriangle`: a lower left triangle of one quarter, the pixels on its margin being half covered.
    fn fill_triangle(&mut self, color: [f32; 4], layer: i32, quarter: u32) {
        let offset_x = if quarter == 0 || quarter == 1 {
            0
        } else {
            (self.width / 2) as i32
        };
        let offset_y = if quarter == 0 || quarter == 2 {
            0
        } else {
            (self.height / 2) as i32
        };
        let max_y = (self.height / 2) as i32;
        let multisampled_color = color.map(|c| c * 0.5);

        for y in 0..max_y {
            for x in 0..y {
                self.set_pixel(color, offset_x + x, offset_y + (max_y - 1) - y, layer);
            }

            // Multisampled pixel is on the triangle margin
            self.set_pixel(multisampled_color, offset_x + y, offset_y + (max_y - 1) - y, layer);
        }
    }

    /// `setPoint`
    fn set_point(&mut self, point_color: [f32; 4], point_size: i32, layer: i32, quarter: u32) {
        let point_offset = 1 + POINT_SIZE_WIDE / 2 - (point_size + 1) / 2;
        let offset_x = point_offset
            + if quarter == 0 || quarter == 1 {
                0
            } else {
                (self.width / 2) as i32
            };
        let offset_y = point_offset
            + if quarter == 0 || quarter == 2 {
                0
            } else {
                (self.height / 2) as i32
            };

        for y in 0..point_size {
            for x in 0..point_size {
                self.set_pixel(point_color, offset_x + x, offset_y + y, layer);
            }
        }
    }
}

fn add4(a: [f32; 4], b: [f32; 4]) -> [f32; 4] {
    [a[0] + b[0], a[1] + b[1], a[2] + b[2], a[3] + b[3]]
}

/// `m_colorTable`
fn color_table() -> [[f32; 4]; 8] {
    let v = 0.75;
    let o = 0.25;
    [
        [v, o, o, 1.0],
        [o, v, o, 1.0],
        [o, o, v, 1.0],
        [o, v, v, 1.0],
        [v, o, v, 1.0],
        [v, v, o, 1.0],
        [o, o, o, 1.0],
        [v, v, v, 1.0],
    ]
}

/// What `draw` records between the begin and the end of each subpass's rendering.
#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawKind {
    Base,
    Instanced,
    InputRate,
    Indirect,
    ClearAttachments,
    PointSize,
    Secondary,
}

fn draw_kind_of(kind: TestType) -> DrawKind {
    match kind {
        TestType::InstancedRendering => DrawKind::Instanced,
        TestType::InputRateInstance => DrawKind::InputRate,
        TestType::DrawIndirect | TestType::DrawIndirectIndexed => DrawKind::Indirect,
        TestType::ClearAttachments => DrawKind::ClearAttachments,
        TestType::PointSize => DrawKind::PointSize,
        TestType::SecondaryCmdBuffer | TestType::SecondaryCmdBufferGeometry | TestType::NestedCmdBuffer => {
            DrawKind::Secondary
        }
        _ => DrawKind::Base,
    }
}

/// An attachment reference of a subpass, with the aspect only renderpass2 carries.
struct RpRef {
    attachment: u32,
    layout: vk::ImageLayout,
    aspect: vk::ImageAspectFlags,
}

/// What every subpass of the render passes of this group references.
struct RpSubpass {
    input: Vec<RpRef>,
    color: Vec<RpRef>,
    resolve: Vec<RpRef>,
    depth_stencil: Option<RpRef>,
}

struct RpDependency {
    src: u32,
    dst: u32,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
    flags: vk::DependencyFlags,
}

/// The arguments of `makeRenderPass`.
struct RenderPassOptions {
    view_masks: Vec<u32>,
    samples: vk::SampleCountFlags,
    color_load_op: vk::AttachmentLoadOp,
    ds_format: vk::Format,
    use_general_layout: bool,
    use_resolve: bool,
}

impl RenderPassOptions {
    fn new(view_masks: Vec<u32>) -> Self {
        Self {
            view_masks,
            samples: vk::SampleCountFlags::_1,
            color_load_op: vk::AttachmentLoadOp::CLEAR,
            ds_format: vk::Format::UNDEFINED,
            use_general_layout: false,
            use_resolve: false,
        }
    }
}

/// The depth/stencil arguments of `makeGraphicsPipeline`.
struct PipelineOptions {
    use_depth_test: bool,
    use_stencil_test: bool,
    min_depth: f32,
    max_depth: f32,
    ds_format: vk::Format,
}

impl Default for PipelineOptions {
    fn default() -> Self {
        Self {
            use_depth_test: false,
            use_stencil_test: false,
            min_depth: 0.0,
            max_depth: 1.0,
            ds_format: vk::Format::UNDEFINED,
        }
    }
}

/// What `draw` needs of the objects `iterate` created.
struct Frame {
    cmd: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    /// Null when the test has no colour attachment.
    color_image: vk::Image,
    color_view: vk::ImageView,
    /// Null unless the test resolves.
    resolve_image: vk::Image,
    resolve_view: vk::ImageView,
    /// Null unless the test has a depth/stencil attachment.
    ds_image: vk::Image,
    ds_view: vk::ImageView,
    pipelines: Vec<vk::Pipeline>,
    pipeline_layout: vk::PipelineLayout,
    vertex_buffers: [vk::Buffer; 2],
    index_buffer: Option<vk::Buffer>,
    descriptor_set: Option<vk::DescriptorSet>,
}

impl MultiViewRenderTestInstance<'_> {
    /// `fillMissingParameters`: the `max_multi_view_view_count` case takes its views from the device.
    fn fill_missing_parameters(&self) -> TestParameters {
        if !self.params.view_masks.is_empty() {
            return self.params.clone();
        }

        let context = self.context;
        let mut multiview_properties = vk::PhysicalDeviceMultiviewProperties::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut multiview_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };

        let mut new_parameters = self.params.clone();
        new_parameters.extent.depth = multiview_properties.max_multiview_view_count;
        new_parameters.view_masks = (0..multiview_properties.max_multiview_view_count)
            .map(|i| 1 << i)
            .collect();
        new_parameters
    }
}

/// The rest of the instance, over the filled parameters.
struct Run<'a> {
    context: &'a Context<'a>,
    p: TestParameters,
    kind: TestType,
}

impl TestInstance for MultiViewRenderTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let run = Run {
            context: self.context,
            p: self.fill_missing_parameters(),
            kind: self.params.view_index,
        };
        run.iterate()
    }
}

impl<'a> Run<'a> {
    fn dynamic(&self) -> bool {
        self.p.rendering_type == RenderingType::DynamicRendering
    }

    fn render_area(&self) -> vk::Rect2D {
        rect_2d(self.p.extent.width, self.p.extent.height)
    }

    fn layers_range(&self) -> vk::ImageSubresourceRange {
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, self.p.extent.depth)
    }

    #[allow(clippy::too_many_arguments)]
    fn image_barrier(
        &self,
        cmd: vk::CommandBuffer,
        image: vk::Image,
        old_layout: vk::ImageLayout,
        new_layout: vk::ImageLayout,
        src_access: vk::AccessFlags,
        dst_access: vk::AccessFlags,
        src_stage: vk::PipelineStageFlags,
        dst_stage: vk::PipelineStageFlags,
    ) {
        let barrier = make_image_memory_barrier(
            src_access,
            dst_access,
            old_layout,
            new_layout,
            image,
            self.layers_range(),
        );
        unsafe {
            self.context.get_device().cmd_pipeline_barrier(
                cmd,
                src_stage,
                dst_stage,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }
    }

    /// `makeRenderPass` and `makeRenderPassWithDepth` of vktMultiViewRenderUtil.cpp, for the legacy and the renderpass2 flavours:
    /// an optional colour attachment (multisampled and resolved on request) and an optional depth/stencil one.
    fn make_render_pass(&self, opts: &RenderPassOptions) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        let color_attachment_available = self.p.color_format != vk::Format::UNDEFINED;
        let ds_attachment_available = opts.ds_format != vk::Format::UNDEFINED;
        let color_attachment_count = if color_attachment_available { 1u32 } else { 0 };
        let ds_attachment_index = color_attachment_count;
        let color_layout = if opts.use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };
        let ds_layout = if opts.use_general_layout {
            vk::ImageLayout::GENERAL
        } else {
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
        };
        let main_color_store_op = if opts.use_resolve {
            vk::AttachmentStoreOp::DONT_CARE
        } else {
            vk::AttachmentStoreOp::STORE
        };

        let color_description = vk::AttachmentDescription::builder()
            .format(self.p.color_format)
            .samples(opts.samples)
            .load_op(opts.color_load_op)
            .store_op(main_color_store_op)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(color_layout)
            .final_layout(color_layout)
            .build();
        let mut resolve_description = color_description;
        resolve_description.load_op = vk::AttachmentLoadOp::DONT_CARE;
        resolve_description.store_op = vk::AttachmentStoreOp::STORE;
        resolve_description.samples = vk::SampleCountFlags::_1;
        let ds_description = vk::AttachmentDescription::builder()
            .format(opts.ds_format)
            .samples(opts.samples)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::LOAD)
            .stencil_store_op(vk::AttachmentStoreOp::STORE)
            .initial_layout(ds_layout)
            .final_layout(ds_layout)
            .build();

        let mut attachments = Vec::new();
        if color_attachment_available {
            attachments.push(color_description);
        }
        if ds_attachment_available {
            attachments.push(ds_description);
        }
        if color_attachment_available && opts.use_resolve {
            attachments.push(resolve_description);
        }

        let resolve_attachment_index = 1 + if ds_attachment_available { 1 } else { 0 };
        let subpass = RpSubpass {
            input: Vec::new(),
            color: if color_attachment_available {
                vec![RpRef {
                    attachment: 0,
                    layout: color_layout,
                    aspect: vk::ImageAspectFlags::empty(),
                }]
            } else {
                Vec::new()
            },
            resolve: if color_attachment_available && opts.use_resolve {
                vec![RpRef {
                    attachment: resolve_attachment_index,
                    layout: color_layout,
                    aspect: vk::ImageAspectFlags::empty(),
                }]
            } else {
                Vec::new()
            },
            depth_stencil: if ds_attachment_available {
                Some(RpRef {
                    attachment: ds_attachment_index,
                    layout: ds_layout,
                    aspect: vk::ImageAspectFlags::empty(),
                })
            } else {
                None
            },
        };

        let src_stage = if ds_attachment_available {
            vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
        } else {
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
        };
        let dst_stage = if ds_attachment_available {
            vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
        } else {
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
        };
        let src_access = if ds_attachment_available {
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
        } else {
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE
        };
        let dst_access = if ds_attachment_available {
            vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
        } else {
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE
        };

        let view_masks = &opts.view_masks;
        let subpass_count = view_masks.len() as u32;
        let mut dependencies = Vec::new();
        for subpass_ndx in 0..subpass_count {
            let mut view_mask = view_masks[subpass_ndx as usize];

            // For every view written in this subpass, there should be a dependency to the next subpass that writes to the same view.
            for dst_subpass_ndx in (subpass_ndx + 1)..subpass_count {
                if view_mask & view_masks[dst_subpass_ndx as usize] != 0 {
                    view_mask &= !view_masks[dst_subpass_ndx as usize];
                    dependencies.push(RpDependency {
                        src: subpass_ndx,
                        dst: dst_subpass_ndx,
                        src_stage,
                        dst_stage,
                        src_access,
                        dst_access,
                        flags: vk::DependencyFlags::VIEW_LOCAL,
                    });
                }
            }

            // If there are views left that are not written by any future subpasses, there should be a external dependency.
            if view_mask != 0 && subpass_ndx < subpass_count - 1 {
                dependencies.push(RpDependency {
                    src: subpass_ndx,
                    dst: subpass_ndx + 1,
                    src_stage,
                    dst_stage,
                    src_access,
                    dst_access,
                    flags: vk::DependencyFlags::BY_REGION,
                });
            }
        }

        self.create_render_pass_from(view_masks, &attachments, &subpass, &dependencies)
    }

    /// `makeRenderPassWithAttachments`: the colour attachment and an input attachment in the general layout.
    fn make_render_pass_with_attachments(&self) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        let view_masks = &self.p.view_masks;
        let subpass_count = view_masks.len() as u32;
        let renderpass2 = self.p.rendering_type == RenderingType::RenderPass2;
        let color_format = self.p.color_format;

        let color_description = vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build();
        let input_description = vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::LOAD)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::GENERAL)
            .final_layout(vk::ImageLayout::GENERAL)
            .build();
        let attachments = [color_description, input_description];

        let subpass = RpSubpass {
            input: vec![RpRef {
                attachment: 1,
                layout: vk::ImageLayout::GENERAL,
                aspect: if renderpass2 {
                    vk::ImageAspectFlags::COLOR
                } else {
                    vk::ImageAspectFlags::empty()
                },
            }],
            color: vec![RpRef {
                attachment: 0,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                aspect: vk::ImageAspectFlags::empty(),
            }],
            resolve: Vec::new(),
            depth_stencil: Some(RpRef {
                attachment: vk::ATTACHMENT_UNUSED,
                layout: vk::ImageLayout::UNDEFINED,
                aspect: vk::ImageAspectFlags::empty(),
            }),
        };

        let src_stage = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;
        let src_access = vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        let dst_access = vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        let mut dependencies = Vec::new();
        for subpass_ndx in 0..subpass_count {
            let mut view_mask = view_masks[subpass_ndx as usize];

            for dst_subpass_ndx in (subpass_ndx + 1)..subpass_count {
                if view_mask & view_masks[dst_subpass_ndx as usize] != 0 {
                    view_mask &= !view_masks[dst_subpass_ndx as usize];
                    dependencies.push(RpDependency {
                        src: subpass_ndx,
                        dst: dst_subpass_ndx,
                        src_stage,
                        dst_stage: src_stage,
                        src_access,
                        dst_access,
                        flags: vk::DependencyFlags::VIEW_LOCAL,
                    });
                }
            }

            // If there are views left that are not written by any future subpasses, there should be a external dependency.
            if view_mask != 0 {
                dependencies.push(RpDependency {
                    src: subpass_ndx,
                    dst: vk::SUBPASS_EXTERNAL,
                    src_stage,
                    dst_stage: src_stage,
                    src_access,
                    dst_access,
                    flags: vk::DependencyFlags::BY_REGION,
                });
            }
        }

        self.create_render_pass_from(view_masks, &attachments, &subpass, &dependencies)
    }

    /// The `RenderPassCreateInfo1` / `RenderPassCreateInfo2` half of both builders: every subpass looks the same, only its view
    /// mask differs.
    fn create_render_pass_from(
        &self,
        view_masks: &[u32],
        attachments: &[vk::AttachmentDescription],
        subpass: &RpSubpass,
        dependencies: &[RpDependency],
    ) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let subpass_count = view_masks.len();

        if self.p.rendering_type != RenderingType::RenderPass2 {
            let legacy_ref = |r: &RpRef| vk::AttachmentReference {
                attachment: r.attachment,
                layout: r.layout,
            };
            let input: Vec<vk::AttachmentReference> = subpass.input.iter().map(legacy_ref).collect();
            let color: Vec<vk::AttachmentReference> = subpass.color.iter().map(legacy_ref).collect();
            let resolve: Vec<vk::AttachmentReference> = subpass.resolve.iter().map(legacy_ref).collect();
            let depth_stencil = subpass.depth_stencil.as_ref().map(legacy_ref);
            let subpasses: Vec<vk::SubpassDescription> = (0..subpass_count)
                .map(|_| {
                    let mut builder = vk::SubpassDescription::builder()
                        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                        .input_attachments(&input)
                        .color_attachments(&color);
                    if !resolve.is_empty() {
                        builder = builder.resolve_attachments(&resolve);
                    }
                    if let Some(depth_stencil) = &depth_stencil {
                        builder = builder.depth_stencil_attachment(depth_stencil);
                    }
                    builder.build()
                })
                .collect();
            let subpass_dependencies: Vec<vk::SubpassDependency> = dependencies
                .iter()
                .map(|d| vk::SubpassDependency {
                    src_subpass: d.src,
                    dst_subpass: d.dst,
                    src_stage_mask: d.src_stage,
                    dst_stage_mask: d.dst_stage,
                    src_access_mask: d.src_access,
                    dst_access_mask: d.dst_access,
                    dependency_flags: d.flags,
                })
                .collect();
            let mut multiview_info = vk::RenderPassMultiviewCreateInfo::builder().view_masks(view_masks);
            let info = vk::RenderPassCreateInfo::builder()
                .attachments(attachments)
                .subpasses(&subpasses)
                .dependencies(&subpass_dependencies)
                .push_next(&mut multiview_info);
            let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
            return Ok(Unique::new(device, render_pass));
        }

        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let attachments2: Vec<vk::AttachmentDescription2> = attachments
            .iter()
            .map(|a| {
                vk::AttachmentDescription2::builder()
                    .flags(a.flags)
                    .format(a.format)
                    .samples(a.samples)
                    .load_op(a.load_op)
                    .store_op(a.store_op)
                    .stencil_load_op(a.stencil_load_op)
                    .stencil_store_op(a.stencil_store_op)
                    .initial_layout(a.initial_layout)
                    .final_layout(a.final_layout)
                    .build()
            })
            .collect();
        let ref2 = |r: &RpRef| {
            vk::AttachmentReference2::builder()
                .attachment(r.attachment)
                .layout(r.layout)
                .aspect_mask(r.aspect)
                .build()
        };
        let input: Vec<vk::AttachmentReference2> = subpass.input.iter().map(ref2).collect();
        let color: Vec<vk::AttachmentReference2> = subpass.color.iter().map(ref2).collect();
        let resolve: Vec<vk::AttachmentReference2> = subpass.resolve.iter().map(ref2).collect();
        let depth_stencil = subpass.depth_stencil.as_ref().map(ref2);
        let subpasses2: Vec<vk::SubpassDescription2> = (0..subpass_count)
            .map(|i| {
                let mut builder = vk::SubpassDescription2::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .view_mask(view_masks[i])
                    .input_attachments(&input)
                    .color_attachments(&color);
                if !resolve.is_empty() {
                    builder = builder.resolve_attachments(&resolve);
                }
                if let Some(depth_stencil) = &depth_stencil {
                    builder = builder.depth_stencil_attachment(depth_stencil);
                }
                builder.build()
            })
            .collect();
        let dependencies2: Vec<vk::SubpassDependency2> = dependencies
            .iter()
            .map(|d| {
                vk::SubpassDependency2::builder()
                    .src_subpass(d.src)
                    .dst_subpass(d.dst)
                    .src_stage_mask(d.src_stage)
                    .dst_stage_mask(d.dst_stage)
                    .src_access_mask(d.src_access)
                    .dst_access_mask(d.dst_access)
                    .dependency_flags(d.flags)
                    .view_offset(0)
                    .build()
            })
            .collect();
        let info = vk::RenderPassCreateInfo2::builder()
            .attachments(&attachments2)
            .subpasses(&subpasses2)
            .dependencies(&dependencies2);
        let render_pass = unsafe { device.create_render_pass2_khr(&info, None) }.vk_check("vkCreateRenderPass2KHR")?;
        Ok(Unique::new(device, render_pass))
    }

    /// `makeGraphicsPipeline`
    fn make_graphics_pipeline(
        &self,
        render_pass: vk::RenderPass,
        layout: vk::PipelineLayout,
        stages: &[vk::PipelineShaderStageCreateInfo],
        subpass: u32,
        opts: &PipelineOptions,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let input_rate = if self.kind == TestType::InputRateInstance {
            vk::VertexInputRate::INSTANCE
        } else {
            vk::VertexInputRate::VERTEX
        };

        let bindings = [
            vk::VertexInputBindingDescription {
                binding: 0,
                stride: 16,
                input_rate,
            },
            vk::VertexInputBindingDescription {
                binding: 1,
                stride: 16,
                input_rate,
            },
        ];
        let attributes = [
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 1,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
        ];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);

        let topology = match self.kind {
            TestType::ViewIndexInTessellation => vk::PrimitiveTopology::PATCH_LIST,
            TestType::PointSize => vk::PrimitiveTopology::POINT_LIST,
            _ => vk::PrimitiveTopology::TRIANGLE_STRIP,
        };
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(topology)
            .primitive_restart_enable(false);

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: self.p.extent.width as f32,
            height: self.p.extent.height as f32,
            min_depth: opts.min_depth,
            max_depth: opts.max_depth,
        }];
        let scissors = [self.render_area()];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let raster_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let sample_count = if self.kind.is_multisample() {
            vk::SampleCountFlags::_4
        } else {
            vk::SampleCountFlags::_1
        };
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(sample_count)
            .sample_shading_enable(false)
            .min_sample_shading(0.0);

        let stencil_op = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::INCREMENT_AND_CLAMP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::ALWAYS)
            .compare_mask(!0)
            .write_mask(!0)
            .reference(0)
            .build();
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(opts.use_depth_test)
            .depth_write_enable(opts.use_depth_test)
            .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(opts.use_stencil_test)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .src_color_blend_factor(vk::BlendFactor::SRC_ALPHA)
            .dst_color_blend_factor(vk::BlendFactor::ONE_MINUS_SRC_ALPHA)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ONE)
            .dst_alpha_blend_factor(vk::BlendFactor::ONE)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::COPY)
            .attachments(&color_blend_attachments);

        let tessellation_state = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(4);

        let color_formats: Vec<vk::Format> = if self.p.color_format != vk::Format::UNDEFINED {
            vec![self.p.color_format]
        } else {
            Vec::new()
        };
        let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
            .view_mask(self.p.view_masks[subpass as usize])
            .color_attachment_formats(&color_formats)
            .depth_attachment_format(opts.ds_format)
            .stencil_attachment_format(opts.ds_format);

        let mut info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&raster_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(layout)
            .render_pass(render_pass)
            .subpass(subpass)
            .base_pipeline_index(0);
        if self.kind == TestType::ViewIndexInTessellation {
            info = info.tessellation_state(&tessellation_state);
        }
        if render_pass == vk::RenderPass::null() {
            info = info.push_next(&mut rendering_create_info);
        }

        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `getQuarterRefColor`
    fn quarter_ref_color(
        &self,
        vd: &VertexData,
        quarter_ndx: u32,
        color_ndx: usize,
        layer_ndx: i32,
        background: bool,
        subpass_ndx: u32,
    ) -> [f32; 4] {
        let layer = layer_ndx as f32 * 0.10;
        match self.kind {
            TestType::ViewMask
            | TestType::ViewMaskIteration
            | TestType::Queries
            | TestType::QueriesAndTimestamps
            | TestType::NonPreciseQueries
            | TestType::NonPreciseQueriesAndTimestamps
            | TestType::NonPreciseQueriesWithAvailability
            | TestType::NonPreciseQueriesWithAvailabilityAndTimestamps => vd.color[color_ndx],
            TestType::DrawIndexed => vd.color[vd.indices[color_ndx] as usize],
            TestType::InstancedRendering => add4(vd.color[0], [0.0, layer, (quarter_ndx + 1) as f32 * 0.10, 0.0]),
            TestType::InputRateInstance => add4(
                vd.color[color_ndx / 4],
                [0.0, layer, (quarter_ndx + 1) as f32 * 0.10, 0.0],
            ),
            TestType::DrawIndirectIndexed => add4(vd.color[vd.indices[color_ndx] as usize], [0.0, layer, 0.0, 0.0]),
            TestType::ViewIndexInVertex
            | TestType::ViewIndexInFragment
            | TestType::ViewIndexInGeometry
            | TestType::ViewIndexInTessellation
            | TestType::InputAttachments
            | TestType::InputAttachmentsGeometry
            | TestType::DrawIndirect
            | TestType::ClearAttachments
            | TestType::SecondaryCmdBuffer
            | TestType::SecondaryCmdBufferGeometry
            | TestType::NestedCmdBuffer => add4(vd.color[color_ndx], [0.0, layer, 0.0, 0.0]),
            TestType::ReadbackExplicitClear => {
                if background {
                    color_table()[4 + quarter_ndx as usize % 4]
                } else {
                    color_table()[layer_ndx as usize % 4]
                }
            }
            TestType::ReadbackImplicitClear => {
                if background {
                    color_table()[4 + quarter_ndx as usize % 4]
                } else {
                    color_table()[0]
                }
            }
            TestType::PointSize | TestType::Multisample | TestType::MultisampleResolve => {
                if background {
                    [0.0, 0.0, 0.0, 0.0]
                } else {
                    vd.color[color_ndx]
                }
            }
            TestType::Depth | TestType::DepthWithoutFragmentShader => {
                if background {
                    if subpass_ndx < 4 {
                        [0.66, 0.0, 0.0, 1.0]
                    } else {
                        [0.33, 0.0, 0.0, 1.0]
                    }
                } else {
                    [0.99, 0.0, 0.0, 1.0]
                }
            }
            TestType::DepthDifferentRanges => {
                // for quads from partA generate  1.20, 0.90, 0.60,  0.30
                // for quads from partB generate  0.55, 0.35, 0.15, -0.05
                // depth ranges in views are <0;0.5>, <0;1> or <0.5;1> so at least one quad from partA/partB will always be drawn
                if subpass_ndx < 4 {
                    [1.2 - 0.3 * subpass_ndx as f32, 0.0, 0.0, 1.0]
                } else {
                    [0.55 - 0.2 * (subpass_ndx % 4) as f32, 0.0, 0.0, 1.0]
                }
            }
            TestType::Stencil => {
                if background {
                    [0.33, 0.0, 0.0, 0.0] // Increment value
                } else {
                    [0.0, 0.0, 0.0, 1.0]
                }
            }
        }
    }

    /// `imageData`
    fn image_data(&self, vd: &VertexData) -> Reference {
        let mut reference = Reference::new(self.p.extent, self.p.color_format);
        let subpass_count = self.p.view_masks.len() as u32;

        if self.kind.is_readback() {
            let mut cleared_view_mask = 0u32;

            // Start from last clear command color, which actually takes effect
            for subpass_ndx in (0..subpass_count as usize).rev() {
                let subpass_to_clear_view_mask = self.p.view_masks[subpass_ndx] & !cleared_view_mask;
                if subpass_to_clear_view_mask == 0 {
                    continue;
                }

                for layer_ndx in 0..self.p.extent.depth {
                    if subpass_to_clear_view_mask & (1 << layer_ndx) != 0 && cleared_view_mask & (1 << layer_ndx) == 0 {
                        reference.fill_layer(
                            self.quarter_ref_color(vd, 0, 0, subpass_ndx as i32, false, 0),
                            layer_ndx as i32,
                        );
                    }
                }

                // These has been cleared. Exclude these layers from upcoming attempts to clear
                cleared_view_mask |= subpass_to_clear_view_mask;
            }
        }

        for subpass_ndx in 0..subpass_count {
            let mut layer_ndx = 0i32;
            let mut mask = self.p.view_masks[subpass_ndx as usize];

            // iterate over image layers
            while mask > 0 {
                let mut color_ndx = 0usize;

                if mask & 1 != 0 {
                    if self.kind == TestType::ClearAttachments {
                        reference.fill_layer([1.0, 0.0, 0.0, 1.0], layer_ndx);
                    }

                    let subpass_quarter_ndx = subpass_ndx % SQUARE_COUNT;
                    let input_rate = self.kind == TestType::InputRateInstance;
                    if subpass_quarter_ndx == 0 || input_rate {
                        let color = self.quarter_ref_color(vd, 0, color_ndx, layer_ndx, true, subpass_ndx);
                        reference.fill_quarter(color, layer_ndx, 0);
                    }

                    color_ndx += 4;
                    if subpass_quarter_ndx == 1 || subpass_count == 1 || input_rate {
                        let color = self.quarter_ref_color(vd, 1, color_ndx, layer_ndx, true, subpass_ndx);
                        reference.fill_quarter(color, layer_ndx, 1);
                    }

                    color_ndx += 4;
                    if subpass_quarter_ndx == 2 || subpass_count == 1 || input_rate {
                        let color = self.quarter_ref_color(vd, 2, color_ndx, layer_ndx, true, subpass_ndx);
                        reference.fill_quarter(color, layer_ndx, 2);
                    }

                    color_ndx += 4;
                    if subpass_quarter_ndx == 3 || subpass_count == 1 || input_rate {
                        let color = self.quarter_ref_color(vd, 3, color_ndx, layer_ndx, true, subpass_ndx);
                        reference.fill_quarter(color, layer_ndx, 3);
                    }

                    if self.kind == TestType::ClearAttachments {
                        let color = [0.0, 0.0, 1.0, 1.0];
                        let max_y = (self.p.extent.height as f32 * 0.75) as i32;
                        let max_x = (self.p.extent.width as f32 * 0.75) as i32;
                        for y in (self.p.extent.height / 4) as i32..max_y {
                            for x in (self.p.extent.width / 4) as i32..max_x {
                                reference.set_pixel(color, x, y, layer_ndx);
                            }
                        }
                    }

                    if self.kind == TestType::PointSize {
                        let vertex_per_primitive = 1usize;
                        let unused_quarter_ndx = 0u32;
                        let point_size = if layer_ndx == 0 {
                            POINT_SIZE_WIDE
                        } else {
                            POINT_SIZE_SMALL
                        };

                        if subpass_count == 1 {
                            for draw_ndx in 0..SQUARE_COUNT {
                                let color = self.quarter_ref_color(
                                    vd,
                                    unused_quarter_ndx,
                                    vertex_per_primitive * draw_ndx as usize,
                                    layer_ndx,
                                    false,
                                    0,
                                );
                                reference.set_point(color, point_size, layer_ndx, draw_ndx);
                            }
                        } else {
                            let color = self.quarter_ref_color(
                                vd,
                                unused_quarter_ndx,
                                vertex_per_primitive * subpass_quarter_ndx as usize,
                                layer_ndx,
                                false,
                                0,
                            );
                            reference.set_point(color, point_size, layer_ndx, subpass_quarter_ndx);
                        }
                    }

                    if self.kind.is_multisample() {
                        let vertex_per_primitive = 3usize;
                        let unused_quarter_ndx = 0u32;

                        if subpass_count == 1 {
                            for draw_ndx in 0..SQUARE_COUNT {
                                let color = self.quarter_ref_color(
                                    vd,
                                    unused_quarter_ndx,
                                    vertex_per_primitive * draw_ndx as usize,
                                    layer_ndx,
                                    false,
                                    0,
                                );
                                reference.fill_triangle(color, layer_ndx, draw_ndx);
                            }
                        } else {
                            let color = self.quarter_ref_color(
                                vd,
                                unused_quarter_ndx,
                                vertex_per_primitive * subpass_quarter_ndx as usize,
                                layer_ndx,
                                false,
                                0,
                            );
                            reference.fill_triangle(color, layer_ndx, subpass_quarter_ndx);
                        }
                    }
                }

                mask >>= 1;
                layer_ndx += 1;
            }
        }
        reference
    }

    /// `beforeRenderPass`
    fn before_render_pass(&self, f: &Frame, resolve_image: vk::Image) {
        if f.color_image == vk::Image::null() {
            return;
        }

        self.image_barrier(
            f.cmd,
            f.color_image,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
        );

        let clear_color = vk::ClearColorValue { float32: [0.0; 4] };
        unsafe {
            self.context.get_device().cmd_clear_color_image(
                f.cmd,
                f.color_image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color,
                &[self.layers_range()],
            )
        };

        self.image_barrier(
            f.cmd,
            f.color_image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        );

        if resolve_image != vk::Image::null() {
            self.image_barrier(
                f.cmd,
                resolve_image,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            );
        }
    }

    /// `afterRenderPass`
    fn after_render_pass(&self, f: &Frame) {
        if f.color_image == vk::Image::null() {
            return;
        }

        self.image_barrier(
            f.cmd,
            f.color_image,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        );
    }

    /// `addRenderingSubpassDependencyIfRequired`
    fn add_rendering_subpass_dependency_if_required(
        &self,
        f: &Frame,
        current_subpass_ndx: u32,
        resolve_image: vk::Image,
    ) {
        if f.color_image == vk::Image::null() {
            return;
        }

        // Get the combined view mask since the last pipeline barrier.
        let mut view_mask = 0u32;
        for subpass_ndx in 0..current_subpass_ndx {
            if view_mask & self.p.view_masks[subpass_ndx as usize] != 0 {
                view_mask = 0; // This subpass should have a pipeline barrier so reset the view mask.
            }
            view_mask |= self.p.view_masks[subpass_ndx as usize];
        }

        // Add a pipeline barrier if the view mask for this subpass contains bits used in previous subpasses since the last pipeline
        // barrier.
        if view_mask & self.p.view_masks[current_subpass_ndx as usize] != 0 {
            self.image_barrier(
                f.cmd,
                f.color_image,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            );

            if resolve_image != vk::Image::null() {
                self.image_barrier(
                    f.cmd,
                    resolve_image,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                );
            }
        }
    }

    /// The `beginRendering` call every dynamic rendering variant of `draw` makes at the start of a subpass, with a colour
    /// attachment, optionally resolved, and optionally a clear value other than zero.
    fn begin_subpass_rendering_with(
        &self,
        f: &Frame,
        subpass_ndx: u32,
        flags: vk::RenderingFlags,
        load_op: vk::AttachmentLoadOp,
        clear_value: vk::ClearValue,
        resolve_view: vk::ImageView,
    ) {
        let device = self.context.get_device();
        let resolve_mode = if resolve_view != vk::ImageView::null() {
            vk::ResolveModeFlags::AVERAGE
        } else {
            vk::ResolveModeFlags::NONE
        }; // TO-DO upstream: choose resolve mode better?
        let color_attachment = vk::RenderingAttachmentInfo::builder()
            .image_view(f.color_view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .resolve_mode(resolve_mode)
            .resolve_image_view(resolve_view)
            .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .load_op(load_op)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(clear_value)
            .build();
        let color_attachments = [color_attachment];
        let rendering_info = vk::RenderingInfo::builder()
            .flags(flags)
            .render_area(self.render_area())
            .layer_count(self.p.extent.depth)
            .view_mask(self.p.view_masks[subpass_ndx as usize])
            .color_attachments(&color_attachments);
        unsafe { device.cmd_begin_rendering(f.cmd, &rendering_info) };
    }

    /// The `beginRendering` call every dynamic rendering variant of `draw` makes at the start of a subpass.
    fn begin_subpass_rendering(&self, f: &Frame, subpass_ndx: u32, flags: vk::RenderingFlags) {
        self.add_rendering_subpass_dependency_if_required(f, subpass_ndx, vk::Image::null());
        begin_rendering(
            self.context.get_device(),
            f.cmd,
            f.color_view,
            self.render_area(),
            clear_value_color([0.0; 4]),
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            if subpass_ndx != 0 {
                vk::AttachmentLoadOp::LOAD
            } else {
                vk::AttachmentLoadOp::CLEAR
            },
            flags,
            self.p.extent.depth,
            self.p.view_masks[subpass_ndx as usize],
        );
    }

    /// `cmdBeginRenderPass` (the renderpass2 or the legacy one)
    fn cmd_begin_render_pass(&self, f: &Frame, contents: vk::SubpassContents) {
        let clear_values = [clear_value_color([0.0; 4])];
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(f.render_pass)
            .framebuffer(f.framebuffer)
            .render_area(self.render_area())
            .clear_values(&clear_values);
        self.cmd_begin_render_pass_with(f.cmd, &begin_info, contents);
    }

    /// `cmdBeginRenderPass` over a `VkRenderPassBeginInfo`
    fn cmd_begin_render_pass_with(
        &self,
        cmd: vk::CommandBuffer,
        begin_info: &vk::RenderPassBeginInfo,
        contents: vk::SubpassContents,
    ) {
        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let device = self.context.get_device();
        if self.p.rendering_type == RenderingType::RenderPass2 {
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(contents);
            unsafe { device.cmd_begin_render_pass2_khr(cmd, begin_info, &subpass_begin_info) };
        } else {
            unsafe { device.cmd_begin_render_pass(cmd, begin_info, contents) };
        }
    }

    /// `cmdNextSubpass`
    fn cmd_next_subpass(&self, cmd: vk::CommandBuffer, contents: vk::SubpassContents) {
        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let device = self.context.get_device();
        if self.p.rendering_type == RenderingType::RenderPass2 {
            let subpass_begin_info = vk::SubpassBeginInfo::builder().contents(contents);
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_next_subpass2_khr(cmd, &subpass_begin_info, &subpass_end_info) };
        } else {
            unsafe { device.cmd_next_subpass(cmd, contents) };
        }
    }

    /// `cmdEndRenderPass`
    fn cmd_end_render_pass(&self, cmd: vk::CommandBuffer) {
        use vulkanalia::vk::KhrCreateRenderpass2ExtensionDeviceCommands;
        let device = self.context.get_device();
        if self.p.rendering_type == RenderingType::RenderPass2 {
            let subpass_end_info = vk::SubpassEndInfo::builder();
            unsafe { device.cmd_end_render_pass2_khr(cmd, &subpass_end_info) };
        } else {
            unsafe { device.cmd_end_render_pass(cmd) };
        }
    }

    /// The end of a subpass: `endRendering` or the next subpass.
    fn end_subpass(&self, f: &Frame, subpass_ndx: u32, subpass_count: u32, next_contents: vk::SubpassContents) {
        if self.dynamic() {
            end_rendering(self.context.get_device(), f.cmd);
        } else if subpass_ndx < subpass_count - 1 {
            self.cmd_next_subpass(f.cmd, next_contents);
        }
    }

    /// The `draw` of the base class and of every subclass that records inline.
    fn draw(&self, f: &Frame, kind: DrawKind) -> Result<(), TestError> {
        let device = self.context.get_device();
        let subpass_count = self.p.view_masks.len() as u32;
        let draw_count_per_subpass = if subpass_count == 1 { SQUARE_COUNT } else { 1 };
        let vertex_buffer_offsets = [0u64, 0u64];

        // The indirect buffers of every subpass.
        let mut indirect_buffers: Vec<BufferWithMemory<'_>> = Vec::new();
        let stride_in_buffer;
        if kind == DrawKind::Indirect {
            let indexed = self.kind == TestType::DrawIndirectIndexed;
            stride_in_buffer = if indexed {
                std::mem::size_of::<vk::DrawIndexedIndirectCommand>()
            } else {
                std::mem::size_of::<vk::DrawIndirectCommand>()
            } as u32;
            for subpass_ndx in 0..subpass_count {
                if indexed {
                    let commands: Vec<vk::DrawIndexedIndirectCommand> = (0..draw_count_per_subpass)
                        .map(|draw_ndx| vk::DrawIndexedIndirectCommand {
                            index_count: 4,
                            instance_count: 1,
                            first_index: (draw_ndx + subpass_ndx % SQUARE_COUNT) * 4,
                            vertex_offset: 0,
                            first_instance: 0,
                        })
                        .collect();
                    indirect_buffers.push(create_host_buffer(
                        self.context,
                        &commands,
                        vk::BufferUsageFlags::INDIRECT_BUFFER,
                    )?);
                } else {
                    let commands: Vec<vk::DrawIndirectCommand> = (0..draw_count_per_subpass)
                        .map(|draw_ndx| vk::DrawIndirectCommand {
                            vertex_count: 4,
                            instance_count: 1,
                            first_vertex: (draw_ndx + subpass_ndx % SQUARE_COUNT) * 4,
                            first_instance: 0,
                        })
                        .collect();
                    indirect_buffers.push(create_host_buffer(
                        self.context,
                        &commands,
                        vk::BufferUsageFlags::INDIRECT_BUFFER,
                    )?);
                }
            }
        } else {
            stride_in_buffer = 0;
        }
        let has_multi_draw_indirect = self.context.get_device_features().multi_draw_indirect != vk::FALSE;

        begin_command_buffer(device, f.cmd)?;
        self.before_render_pass(f, vk::Image::null());

        if !self.dynamic() {
            self.cmd_begin_render_pass(f, vk::SubpassContents::INLINE);
        }

        for subpass_ndx in 0..subpass_count {
            let bind_vertex_buffers = |cmd: vk::CommandBuffer| unsafe {
                device.cmd_bind_vertex_buffers(cmd, 0, &f.vertex_buffers, &vertex_buffer_offsets)
            };
            let bind_pipeline = |cmd: vk::CommandBuffer| unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, f.pipelines[subpass_ndx as usize])
            };

            match kind {
                DrawKind::ClearAttachments => {
                    let mut clear_attachment = vk::ClearAttachment {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        color_attachment: 0,
                        clear_value: clear_value_color([1.0, 0.0, 0.0, 1.0]),
                    };
                    let offset = [
                        vk::Offset2D { x: 0, y: 0 },
                        vk::Offset2D {
                            x: (self.p.extent.width as f32 * 0.25) as i32,
                            y: (self.p.extent.height as f32 * 0.25) as i32,
                        },
                    ];
                    let extent = [
                        vk::Extent2D {
                            width: self.p.extent.width,
                            height: self.p.extent.height,
                        },
                        vk::Extent2D {
                            width: (self.p.extent.width as f32 * 0.5) as u32,
                            height: (self.p.extent.height as f32 * 0.5) as u32,
                        },
                    ];
                    let rect2d = [
                        vk::Rect2D {
                            offset: offset[0],
                            extent: extent[0],
                        },
                        vk::Rect2D {
                            offset: offset[1],
                            extent: extent[1],
                        },
                    ];
                    let mut clear_rect = vk::ClearRect {
                        rect: rect2d[0],
                        base_array_layer: 0,
                        layer_count: 1,
                    };

                    if self.dynamic() {
                        self.begin_subpass_rendering(f, subpass_ndx, vk::RenderingFlags::empty());
                    }

                    unsafe { device.cmd_clear_attachments(f.cmd, &[clear_attachment], &[clear_rect]) };
                    bind_vertex_buffers(f.cmd);
                    bind_pipeline(f.cmd);

                    for draw_ndx in 0..draw_count_per_subpass {
                        unsafe { device.cmd_draw(f.cmd, 4, 1, (draw_ndx + subpass_ndx % SQUARE_COUNT) * 4, 0) };
                    }

                    clear_rect.rect = rect2d[1];
                    clear_attachment.clear_value = clear_value_color([0.0, 0.0, 1.0, 1.0]);
                    unsafe { device.cmd_clear_attachments(f.cmd, &[clear_attachment], &[clear_rect]) };
                }
                DrawKind::PointSize => {
                    bind_vertex_buffers(f.cmd);
                    bind_pipeline(f.cmd);

                    if self.dynamic() {
                        self.begin_subpass_rendering(f, subpass_ndx, vk::RenderingFlags::empty());
                    }

                    for draw_ndx in 0..draw_count_per_subpass {
                        unsafe { device.cmd_draw(f.cmd, 1, 1, draw_ndx + subpass_ndx % SQUARE_COUNT, 0) };
                    }
                }
                _ => {
                    bind_vertex_buffers(f.cmd);

                    if self.kind.indexed()
                        && let Some(index_buffer) = f.index_buffer
                    {
                        unsafe { device.cmd_bind_index_buffer(f.cmd, index_buffer, 0, vk::IndexType::UINT32) };
                    }

                    // `bindResources`
                    if let Some(descriptor_set) = f.descriptor_set {
                        unsafe {
                            device.cmd_bind_descriptor_sets(
                                f.cmd,
                                vk::PipelineBindPoint::GRAPHICS,
                                f.pipeline_layout,
                                0,
                                &[descriptor_set],
                                &[] as &[u32],
                            )
                        };
                    }

                    if self.dynamic() {
                        self.begin_subpass_rendering(f, subpass_ndx, vk::RenderingFlags::empty());
                    }

                    bind_pipeline(f.cmd);

                    match kind {
                        DrawKind::Instanced => unsafe {
                            device.cmd_draw(f.cmd, 4, draw_count_per_subpass, 0, subpass_ndx % SQUARE_COUNT)
                        },
                        DrawKind::InputRate => {
                            for _ in 0..draw_count_per_subpass {
                                unsafe { device.cmd_draw(f.cmd, 4, 4, 0, 0) };
                            }
                        }
                        DrawKind::Indirect => {
                            let indexed = self.kind == TestType::DrawIndirectIndexed;
                            let buffer = indirect_buffers[subpass_ndx as usize].get();
                            if has_multi_draw_indirect {
                                if indexed {
                                    unsafe {
                                        device.cmd_draw_indexed_indirect(
                                            f.cmd,
                                            buffer,
                                            0,
                                            draw_count_per_subpass,
                                            stride_in_buffer,
                                        )
                                    };
                                } else {
                                    unsafe {
                                        device.cmd_draw_indirect(
                                            f.cmd,
                                            buffer,
                                            0,
                                            draw_count_per_subpass,
                                            stride_in_buffer,
                                        )
                                    };
                                }
                            } else {
                                for draw_ndx in 0..draw_count_per_subpass {
                                    let offset = (draw_ndx * stride_in_buffer) as u64;
                                    if indexed {
                                        unsafe {
                                            device.cmd_draw_indexed_indirect(f.cmd, buffer, offset, 1, stride_in_buffer)
                                        };
                                    } else {
                                        unsafe { device.cmd_draw_indirect(f.cmd, buffer, offset, 1, stride_in_buffer) };
                                    }
                                }
                            }
                        }
                        _ => {
                            for draw_ndx in 0..draw_count_per_subpass {
                                let first = (draw_ndx + subpass_ndx % SQUARE_COUNT) * 4;
                                if self.kind == TestType::DrawIndexed {
                                    unsafe { device.cmd_draw_indexed(f.cmd, 4, 1, first, 0, 0) };
                                } else {
                                    unsafe { device.cmd_draw(f.cmd, 4, 1, first, 0) };
                                }
                            }
                        }
                    }
                }
            }

            self.end_subpass(f, subpass_ndx, subpass_count, vk::SubpassContents::INLINE);
        }

        if !self.dynamic() {
            self.cmd_end_render_pass(f.cmd);
        }

        self.after_render_pass(f);
        end_command_buffer(device, f.cmd)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), f.cmd)
    }

    /// `MultiViewSecondaryCommandBufferTestInstance::draw`
    fn draw_secondary(&self, f: &Frame) -> Result<(), TestError> {
        let device = self.context.get_device();
        let subpass_count = self.p.view_masks.len() as u32;
        let draw_count_per_subpass = if subpass_count == 1 { SQUARE_COUNT } else { 1 };
        let vertex_buffer_offsets = [0u64, 0u64];

        // `createSecondaryCommandPool`
        let cmd_pool_secondary = make_command_pool(device, self.context.get_universal_queue_family_index())?;

        begin_command_buffer(device, f.cmd)?;
        self.before_render_pass(f, vk::Image::null());

        if !self.dynamic() {
            self.cmd_begin_render_pass(f, vk::SubpassContents::SECONDARY_COMMAND_BUFFERS);
        }

        let mut secondary_buffers = Vec::new();
        let mut nested_buffers = Vec::new();
        for subpass_ndx in 0..subpass_count {
            if self.kind == TestType::NestedCmdBuffer {
                nested_buffers.push(allocate_command_buffer(
                    device,
                    *cmd_pool_secondary,
                    vk::CommandBufferLevel::SECONDARY,
                )?);
            }
            secondary_buffers.push(allocate_command_buffer(
                device,
                *cmd_pool_secondary,
                vk::CommandBufferLevel::SECONDARY,
            )?);
            let secondary = **secondary_buffers.last().unwrap();

            let color_formats = [self.p.color_format];
            let mut rendering_inheritance_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                .flags(vk::RenderingFlags::empty())
                .view_mask(self.p.view_masks[subpass_ndx as usize])
                .color_attachment_formats(&color_formats)
                .depth_attachment_format(vk::Format::UNDEFINED)
                .stencil_attachment_format(vk::Format::UNDEFINED)
                .rasterization_samples(vk::SampleCountFlags::_1);
            let mut inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                .render_pass(f.render_pass)
                .subpass(subpass_ndx)
                .framebuffer(f.framebuffer);
            if self.dynamic() {
                inheritance_info = inheritance_info.push_next(&mut rendering_inheritance_info);
            }
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance_info);

            if self.kind == TestType::NestedCmdBuffer {
                unsafe { device.begin_command_buffer(**nested_buffers.last().unwrap(), &begin_info) }
                    .vk_check("vkBeginCommandBuffer")?;
            }
            unsafe {
                device
                    .begin_command_buffer(secondary, &begin_info)
                    .vk_check("vkBeginCommandBuffer")?;
                device.cmd_bind_vertex_buffers(secondary, 0, &f.vertex_buffers, &vertex_buffer_offsets);
                device.cmd_bind_pipeline(
                    secondary,
                    vk::PipelineBindPoint::GRAPHICS,
                    f.pipelines[subpass_ndx as usize],
                );
            }

            if self.dynamic() {
                self.begin_subpass_rendering(f, subpass_ndx, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
            }

            for draw_ndx in 0..draw_count_per_subpass {
                unsafe { device.cmd_draw(secondary, 4, 1, (draw_ndx + subpass_ndx % SQUARE_COUNT) * 4, 0) };
            }

            end_command_buffer(device, secondary)?;

            if self.kind == TestType::NestedCmdBuffer {
                let nested = **nested_buffers.last().unwrap();
                unsafe { device.cmd_execute_commands(nested, &[secondary]) };
                end_command_buffer(device, nested)?;
                unsafe { device.cmd_execute_commands(f.cmd, &[nested]) };
            } else {
                unsafe { device.cmd_execute_commands(f.cmd, &[secondary]) };
            }

            self.end_subpass(
                f,
                subpass_ndx,
                subpass_count,
                vk::SubpassContents::SECONDARY_COMMAND_BUFFERS,
            );
        }

        if !self.dynamic() {
            self.cmd_end_render_pass(f.cmd);
        }

        self.after_render_pass(f);
        end_command_buffer(device, f.cmd)?;
        submit_commands_and_wait(device, self.context.get_universal_queue(), f.cmd)
    }

    /// `readImage`: the whole image, layer after layer, as RGBA8 bytes.
    fn read_image(&self, f: &Frame, image: vk::Image) -> Result<Vec<u8>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let extent = self.p.extent;
        let pixel_size = crate::tcu::texture::map_vk_format(self.p.color_format)
            .and_then(|format| format.pixel_size())
            .ok_or_else(|| TestError::InternalError("unsupported read-back format".to_string()))?;
        let pixel_data_size = (extent.width * extent.height * extent.depth * pixel_size) as usize;

        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(pixel_data_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::write_bytes(buffer.get_allocation().get_host_ptr(), 0, pixel_data_size) };
        flush_alloc(device, buffer.get_allocation())?;

        let buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(buffer.get())
            .offset(0)
            .size(pixel_data_size as vk::DeviceSize)
            .build();
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: extent.width,
            buffer_image_height: extent.height,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: extent.depth,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: extent.width,
                height: extent.height,
                depth: 1,
            },
        };

        begin_command_buffer(device, f.cmd)?;
        self.image_barrier(
            f.cmd,
            image,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
        );
        unsafe {
            device.cmd_copy_image_to_buffer(
                f.cmd,
                image,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                f.cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, f.cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), f.cmd)?;

        invalidate_alloc(device, buffer.get_allocation())?;
        let mut out = vec![0u8; pixel_data_size];
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer.get_allocation().get_host_ptr(),
                out.as_mut_ptr(),
                pixel_data_size,
            )
        };
        Ok(out)
    }

    /// `MultiViewAttachmentsTestInstance::setImageData`: uploads the reference image to the input attachment.
    fn set_image_data(&self, f: &Frame, image: vk::Image, data: &Reference) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();
        let extent = self.p.extent;
        let bytes = data.to_bytes();
        let buffer_size = bytes.len();

        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_SRC),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), buffer.get_allocation().get_host_ptr(), buffer_size) };
        flush_alloc(device, buffer.get_allocation())?;

        let pre_buffer_barrier = vk::BufferMemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::HOST_WRITE)
            .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
            .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
            .buffer(buffer.get())
            .offset(0)
            .size(buffer_size as vk::DeviceSize)
            .build();
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: extent.width,
            buffer_image_height: extent.height,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: extent.depth,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: extent.width,
                height: extent.height,
                depth: 1,
            },
        };

        begin_command_buffer(device, f.cmd)?;
        unsafe {
            device.cmd_pipeline_barrier(
                f.cmd,
                vk::PipelineStageFlags::HOST,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[pre_buffer_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        self.image_barrier(
            f.cmd,
            image,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::PipelineStageFlags::HOST,
            vk::PipelineStageFlags::TRANSFER,
        );
        unsafe {
            device.cmd_copy_buffer_to_image(
                f.cmd,
                buffer.get(),
                image,
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &[copy_region],
            )
        };
        self.image_barrier(
            f.cmd,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::GENERAL,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::TRANSFER_WRITE,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::TRANSFER,
        );
        end_command_buffer(device, f.cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), f.cmd)
    }

    /// `madeShaderModule`: the modules of every stage the test type's program set has.
    fn load_stage_modules(&self) -> Result<Vec<(vk::ShaderStageFlags, Unique<'a, vk::ShaderModule>)>, TestError> {
        let device = self.context.get_device();
        let binaries = self.context.get_binary_collection();
        let stage_table = [
            (vk::ShaderStageFlags::VERTEX, "vertex"),
            (vk::ShaderStageFlags::TESSELLATION_CONTROL, "tessellation_control"),
            (vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tessellation_evaluation"),
            (vk::ShaderStageFlags::GEOMETRY, "geometry"),
            (vk::ShaderStageFlags::FRAGMENT, "fragment"),
        ];
        let mut modules = Vec::new();
        for (stage, name) in stage_table {
            if let Ok(binary) = binaries.get(name) {
                modules.push((stage, create_shader_module(device, binary)?));
            }
        }
        Ok(modules)
    }

    /// The pixels `read_image` returned, as the floats the comparison works on.
    fn result_pixels(&self, bytes: &[u8], format: vk::Format) -> Vec<[f32; 4]> {
        if format == vk::Format::R32G32B32A32_SFLOAT {
            bytes
                .chunks_exact(16)
                .map(|pixel| {
                    let channel = |c: usize| {
                        f32::from_le_bytes([pixel[4 * c], pixel[4 * c + 1], pixel[4 * c + 2], pixel[4 * c + 3]])
                    };
                    [channel(0), channel(1), channel(2), channel(3)]
                })
                .collect()
        } else {
            bytes
                .chunks_exact(4)
                .map(|pixel| {
                    [
                        pixel[0] as f32 / 255.0,
                        pixel[1] as f32 / 255.0,
                        pixel[2] as f32 / 255.0,
                        pixel[3] as f32 / 255.0,
                    ]
                })
                .collect()
        }
    }

    /// `checkImage`: `tcu::floatThresholdCompare` with a threshold of 0.01; the layers no subpass resolved are skipped when the
    /// test resolves.
    fn check_image(&self, result: &[[f32; 4]], reference: &Reference) -> bool {
        let layer_size = (self.p.extent.width * self.p.extent.height) as usize;
        let mut all_views = 0u32;
        for view_mask in &self.p.view_masks {
            all_views |= view_mask;
        }

        let mut success = true;
        for layer_ndx in 0..self.p.extent.depth {
            if self.kind == TestType::MultisampleResolve && all_views & (1 << layer_ndx) == 0 {
                continue;
            }
            let range = layer_ndx as usize * layer_size..(layer_ndx as usize + 1) * layer_size;
            let layer_ok = result[range.clone()]
                .iter()
                .zip(reference.pixels[range].iter())
                .all(|(got, expected)| (0..4).all(|c| (got[c] - expected[c]).abs() <= 0.01));
            if !layer_ok {
                success = false;
            }
        }
        success
    }

    /// `MultiViewRenderTestInstance::iterate` and `MultiViewAttachmentsTestInstance::iterate`
    fn iterate_base(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let p = &self.p;
        let subpass_count = p.view_masks.len() as u32;
        let attachments_instance = self.kind.uses_attachments_instance();
        let draw_kind = draw_kind_of(self.kind);

        let color_attachment = ImageAttachment::new(context, p.extent, p.color_format, vk::SampleCountFlags::_1)?;
        let input_attachment = if attachments_instance {
            Some(ImageAttachment::new(
                context,
                p.extent,
                p.color_format,
                vk::SampleCountFlags::_1,
            )?)
        } else {
            None
        };

        // FrameBuffer & renderPass
        let mut render_pass = None;
        let mut framebuffer = None;
        if !self.dynamic() {
            let created = if attachments_instance {
                self.make_render_pass_with_attachments()?
            } else {
                self.make_render_pass(&RenderPassOptions::new(self.p.view_masks.clone()))?
            };
            let mut views = vec![*color_attachment.view];
            if let Some(input) = &input_attachment {
                views.push(*input.view);
            }
            framebuffer = Some(make_framebuffer(
                device,
                *created,
                &views,
                p.extent.width,
                p.extent.height,
                1,
            )?);
            render_pass = Some(created);
        }
        let render_pass_handle = render_pass.as_ref().map_or_else(vk::RenderPass::null, |rp| **rp);
        let framebuffer_handle = framebuffer.as_ref().map_or_else(vk::Framebuffer::null, |fb| **fb);

        // pipelineLayout
        let set_layout = if attachments_instance {
            Some(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
                    .build(device)?,
            )
        } else {
            None
        };
        let set_layouts: Vec<vk::DescriptorSetLayout> = set_layout.iter().map(|layout| **layout).collect();
        let pipeline_layout = make_pipeline_layout(device, &set_layouts)?;

        // pipelines
        let modules = self.load_stage_modules()?;
        let stage_infos = stage_infos(&modules);
        let mut pipelines = Vec::new();
        for subpass_ndx in 0..subpass_count {
            pipelines.push(self.make_graphics_pipeline(
                render_pass_handle,
                *pipeline_layout,
                &stage_infos,
                subpass_ndx,
                &PipelineOptions::default(),
            )?);
        }

        // createCommandBuffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        // createVertexData and createVertexBuffer
        let data = create_vertex_data(self.kind, p.extent, 0);
        let vertex_coord_buffer = create_host_buffer(context, &data.coord, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let vertex_color_buffer = create_host_buffer(context, &data.color, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        let index_buffer = if self.kind.indexed() {
            Some(create_host_buffer(
                context,
                &data.indices,
                vk::BufferUsageFlags::INDEX_BUFFER,
            )?)
        } else {
            None
        };

        // The input attachment's descriptor set.
        let descriptor_pool = if attachments_instance {
            Some(
                DescriptorPoolBuilder::new()
                    .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
                    .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?,
            )
        } else {
            None
        };
        let descriptor_set = match (&descriptor_pool, &set_layout, &input_attachment) {
            (Some(pool), Some(layout), Some(input)) => {
                let set = make_descriptor_set(device, **pool, **layout)?;
                let image_info = [vk::DescriptorImageInfo::builder()
                    .sampler(vk::Sampler::null())
                    .image_view(*input.view)
                    .image_layout(vk::ImageLayout::GENERAL)
                    .build()];
                let write = vk::WriteDescriptorSet::builder()
                    .dst_set(set.get())
                    .dst_binding(0)
                    .dst_array_element(0)
                    .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                    .image_info(&image_info);
                unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
                Some(set)
            }
            _ => None,
        };

        let frame = Frame {
            cmd: *cmd_buffer,
            render_pass: render_pass_handle,
            framebuffer: framebuffer_handle,
            color_image: color_attachment.image.get(),
            color_view: *color_attachment.view,
            resolve_image: vk::Image::null(),
            resolve_view: vk::ImageView::null(),
            ds_image: vk::Image::null(),
            ds_view: vk::ImageView::null(),
            pipelines: pipelines.iter().map(|pipeline| pipeline.get()).collect(),
            pipeline_layout: *pipeline_layout,
            vertex_buffers: [vertex_coord_buffer.get(), vertex_color_buffer.get()],
            index_buffer: index_buffer.as_ref().map(|buffer| buffer.get()),
            descriptor_set: descriptor_set.as_ref().map(|set| set.get()),
        };

        let reference = self.image_data(&data);
        if let Some(input) = &input_attachment {
            self.set_image_data(&frame, input.image.get(), &reference)?;
        }

        if draw_kind == DrawKind::Secondary {
            self.draw_secondary(&frame)?;
        } else {
            self.draw(&frame, draw_kind)?;
        }

        let result = self.read_image(&frame, frame.color_image)?;
        if !self.check_image(&self.result_pixels(&result, p.color_format), &reference) {
            return Ok(TestStatus::fail("Fail"));
        }
        Ok(TestStatus::pass("Pass"))
    }

    /// `iterate` of the instance class of the test type.
    fn iterate(&self) -> TestOutcome {
        match self.kind {
            TestType::ViewMaskIteration => self.iterate_mask_iteration(),
            TestType::ReadbackImplicitClear | TestType::ReadbackExplicitClear => self.iterate_readback(),
            TestType::Multisample | TestType::MultisampleResolve => self.iterate_multisample(),
            kind if kind.is_query() => self.iterate_queries(),
            TestType::Depth
            | TestType::DepthWithoutFragmentShader
            | TestType::DepthDifferentRanges
            | TestType::Stencil => self.iterate_depth_stencil(),
            _ => self.iterate_base(),
        }
    }
}

/// The `VkPipelineShaderStageCreateInfo`s of `load_stage_modules`.
fn stage_infos(
    modules: &[(vk::ShaderStageFlags, Unique<'_, vk::ShaderModule>)],
) -> Vec<vk::PipelineShaderStageCreateInfo> {
    modules
        .iter()
        .map(|(stage, module)| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(*stage)
                .module(**module)
                .name(b"main\0")
                .build()
        })
        .collect()
}

/// `createViewMasksName`
fn create_view_masks_name(view_masks: &[u32]) -> String {
    view_masks
        .iter()
        .map(|mask| mask.to_string())
        .collect::<Vec<_>>()
        .join("_")
}

/// `tripleDepthStencilMasks`
fn triple_depth_stencil_masks(base_masks: &[u32]) -> Vec<u32> {
    let mut tripled_masks = base_masks.to_vec();

    // a,b,c,d  =>  b,c,d,a
    let mut part_b_masks: Vec<u32> = base_masks[1..].to_vec();
    part_b_masks.push(base_masks[0]);

    tripled_masks.extend_from_slice(&part_b_masks);
    tripled_masks.extend_from_slice(&part_b_masks);
    tripled_masks
}

/// `multiViewRenderCreateTests`: the groups of every rendering type, directly under the returned group for the legacy render pass
/// and under `renderpass2` and `dynamic_rendering` for the others.
pub fn multi_view_render_create_tests(group: &mut TestCaseGroup) {
    let test_types = [
        TestType::ViewMask,
        TestType::ViewIndexInVertex,
        TestType::ViewIndexInFragment,
        TestType::ViewIndexInGeometry,
        TestType::ViewIndexInTessellation,
        TestType::InputAttachments,
        TestType::InputAttachmentsGeometry,
        TestType::InstancedRendering,
        TestType::InputRateInstance,
        TestType::DrawIndirect,
        TestType::DrawIndirectIndexed,
        TestType::DrawIndexed,
        TestType::ClearAttachments,
        TestType::SecondaryCmdBuffer,
        TestType::SecondaryCmdBufferGeometry,
        TestType::PointSize,
        TestType::Multisample,
        TestType::MultisampleResolve,
        TestType::Queries,
        TestType::QueriesAndTimestamps,
        TestType::NonPreciseQueries,
        TestType::NonPreciseQueriesAndTimestamps,
        TestType::NonPreciseQueriesWithAvailability,
        TestType::NonPreciseQueriesWithAvailabilityAndTimestamps,
        TestType::ReadbackImplicitClear,
        TestType::ReadbackExplicitClear,
        TestType::Depth,
        TestType::DepthWithoutFragmentShader,
        TestType::DepthDifferentRanges,
        TestType::Stencil,
        TestType::ViewMaskIteration,
        TestType::NestedCmdBuffer,
    ];

    const TEST_CASE_COUNT: usize = 7;
    let extent3d = [
        (16, 16, 4),
        (64, 64, 8),
        (128, 128, 4),
        (32, 32, 5),
        (64, 64, 6),
        (32, 32, 4),
        (16, 16, 10),
    ];
    let mut view_masks: Vec<Vec<u32>> = vec![Vec::new(); TEST_CASE_COUNT];

    view_masks[0].push(15); //1111

    view_masks[1].push(8); //1000

    view_masks[2].extend_from_slice(&[1, 2, 4, 8]);

    view_masks[3].extend_from_slice(&[15, 15, 15, 15]);

    view_masks[4].extend_from_slice(&[8, 1, 1, 8]);

    view_masks[5].extend_from_slice(&[5, 10, 5, 10]);

    let max_view_mask = (1u32 << MIN_SUPPORTED_MULTIVIEW_VIEW_COUNT) - 1;
    let mut mask = 1u32;
    while mask <= max_view_mask {
        view_masks[TEST_CASE_COUNT - 1].push(mask);
        mask <<= 1;
    }

    let depth_stencil_masks = [3u32, 6, 12, 9]; // 0011, 0110, 1100, 1001

    for (render_pass_type_ndx, rendering_type) in [
        RenderingType::Legacy,
        RenderingType::RenderPass2,
        RenderingType::DynamicRendering,
    ]
    .into_iter()
    .enumerate()
    {
        let mut target_group = TestCaseGroup::new(match render_pass_type_ndx {
            0 => "",
            1 => "renderpass2",
            _ => "dynamic_rendering",
        });
        let mut group_view_index = TestCaseGroup::new("index");

        for test_type in test_types {
            let sample_count_flags = if test_type.is_multisample() {
                vk::SampleCountFlags::_4
            } else {
                vk::SampleCountFlags::_1
            };
            let color_format = if test_type.is_multisample() {
                vk::Format::R32G32B32A32_SFLOAT
            } else if test_type == TestType::ViewMaskIteration {
                vk::Format::R8G8B8A8_UINT
            } else if test_type == TestType::DepthWithoutFragmentShader {
                vk::Format::UNDEFINED
            } else {
                vk::Format::R8G8B8A8_UNORM
            };

            // subpassLoad can't be used with dynamic rendering
            if test_type == TestType::InputAttachments && rendering_type == RenderingType::DynamicRendering {
                continue;
            }

            let mut group_shader = TestCaseGroup::new(test_type.name());

            if test_type == TestType::ViewMaskIteration {
                for test_case_ndx in 0..TEST_CASE_COUNT {
                    for use_general_layout in [false, true] {
                        let (width, height, depth) = extent3d[test_case_ndx];
                        let parameters = TestParameters {
                            extent: vk::Extent3D { width, height, depth },
                            view_masks: view_masks[test_case_ndx].clone(),
                            view_index: test_type,
                            samples: sample_count_flags,
                            color_format,
                            query_type: QueryType::GetQueryPoolResults,
                            rendering_type,
                            use_general_layout,
                        };
                        let mut test_name = create_view_masks_name(&parameters.view_masks);
                        if use_general_layout {
                            test_name += "_general_layout";
                        }
                        group_shader.add_child(Box::new(MultiViewRenderTestsCase {
                            name: test_name,
                            params: parameters,
                        }) as Box<dyn TestCase>);
                    }
                }
            } else {
                let query_type_cases = [
                    (QueryType::None, "no_queries"),
                    (QueryType::GetQueryPoolResults, "get_query_pool_results"),
                    (QueryType::CmdCopyQueryPoolResults, "cmd_copy_query_pool_results"),
                ];

                for (query_type, group_name) in query_type_cases {
                    let is_query = test_type.is_query();

                    // Query test types have to be added only to the get and copy groups. Other test types have to be added only to the
                    // no queries group.
                    if (is_query && query_type == QueryType::None) || (!is_query && query_type != QueryType::None) {
                        continue;
                    }

                    let mut query_type_group = TestCaseGroup::new(group_name);

                    if test_type.is_depth_stencil() {
                        let parameters = TestParameters {
                            extent: vk::Extent3D {
                                width: 64,
                                height: 64,
                                depth: 4,
                            },
                            view_masks: triple_depth_stencil_masks(&depth_stencil_masks),
                            view_index: test_type,
                            samples: sample_count_flags,
                            color_format,
                            query_type,
                            rendering_type,
                            use_general_layout: false,
                        };
                        let test_name = create_view_masks_name(&parameters.view_masks);
                        query_type_group.add_child(Box::new(MultiViewRenderTestsCase {
                            name: test_name,
                            params: parameters,
                        }) as Box<dyn TestCase>);
                    } else {
                        for test_case_ndx in 0..TEST_CASE_COUNT {
                            let (width, height, depth) = extent3d[test_case_ndx];
                            let parameters = TestParameters {
                                extent: vk::Extent3D { width, height, depth },
                                view_masks: view_masks[test_case_ndx].clone(),
                                view_index: test_type,
                                samples: sample_count_flags,
                                color_format,
                                query_type,
                                rendering_type,
                                use_general_layout: false,
                            };
                            let test_name = create_view_masks_name(&parameters.view_masks);
                            query_type_group.add_child(Box::new(MultiViewRenderTestsCase {
                                name: test_name,
                                params: parameters,
                            }) as Box<dyn TestCase>);
                        }

                        // maxMultiviewViewCount case
                        let parameters = TestParameters {
                            extent: vk::Extent3D {
                                width: 16,
                                height: 16,
                                depth: 0,
                            },
                            view_masks: Vec::new(),
                            view_index: test_type,
                            samples: sample_count_flags,
                            color_format,
                            query_type,
                            rendering_type,
                            use_general_layout: false,
                        };
                        query_type_group.add_child(Box::new(MultiViewRenderTestsCase {
                            name: "max_multi_view_view_count".to_string(),
                            params: parameters,
                        }) as Box<dyn TestCase>);
                    }
                    group_shader.add_child(query_type_group);
                }
            }

            if test_type.is_view_index() {
                group_view_index.add_child(group_shader);
            } else if render_pass_type_ndx == 0 {
                group.add_child(group_shader);
            } else {
                target_group.add_child(group_shader);
            }
        }

        if render_pass_type_ndx == 0 {
            group.add_child(group_view_index);
        } else {
            target_group.add_child(group_view_index);
            group.add_child(target_group);
        }
    }
}
