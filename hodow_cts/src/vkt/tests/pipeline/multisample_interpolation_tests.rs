// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleInterpolationTests.cpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleBase.cpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleBaseResolve.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2023 LunarG, Inc.
// Copyright (c) 2023 Nintendo
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `MSCase<Class>` / `MSInstance<Class>` template
// specialisations are one `Kind` enum here; `MSInstanceBaseResolve::iterate` is `MultisampleInterpolationInstance::iterate`.

use std::collections::HashSet;

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_multisample_interpolation::{
    AT_SAMPLE_IGNORES_CENTROID, AT_SAMPLE_SINGLE_SAMPLE, CENTROID_CONSISTENCY_CONST0, CENTROID_CONSISTENCY_CONST1,
    CENTROID_CONSISTENCY_NONE, CENTROID_CONSISTENCY_PUSH, CENTROID_INSIDE_PRIMITIVE, DISTINCT_INTERPOLATE_AT_SAMPLE,
    DISTINCT_SAMPLE_QUALIFIER, OFFSET_PIXEL_CENTER, OFFSET_SAMPLE_POSITION_CONST0, OFFSET_SAMPLE_POSITION_CONST1,
    OFFSET_SAMPLE_POSITION_NONE, OFFSET_SAMPLE_POSITION_PUSH, SAMPLE_CONSISTENCY_CONST0, SAMPLE_CONSISTENCY_CONST1,
    SAMPLE_CONSISTENCY_NONE, SAMPLE_CONSISTENCY_PUSH,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::MemoryRequirement;
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{
    begin_dynamic_rendering_resolve, end_dynamic_rendering, make_shader_objects_stages,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `multisample::ComponentSource` with its index folded in.
#[derive(Clone, Copy, PartialEq, Eq)]
enum ComponentData {
    None,
    Constant(u32),
    PushConstant(u32),
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    SampleQualifierDistinctValues,
    InterpolateAtSampleDistinctValues,
    InterpolateAtSampleSingleSample,
    InterpolateAtSampleIgnoresCentroid,
    InterpolateAtSampleConsistency,
    InterpolateAtCentroidConsistency,
    InterpolateAtOffsetPixelCenter,
    InterpolateAtOffsetSamplePosition,
    CentroidQualifierInsidePrimitive,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum VertexData {
    /// `VertexDataNdc`, one full screen triangle (`MSInstanceDistinctValues`).
    Ndc,
    /// `VertexDataNdcScreen`, a triangle strip quad (`MSInstanceInterpolateScreenPosition`).
    NdcScreen,
    /// `VertexDataNdcBarycentric` (`MSInstanceInterpolateBarycentricCoordinates`).
    NdcBarycentric,
}

impl Kind {
    fn vertex_data(self) -> VertexData {
        match self {
            Kind::SampleQualifierDistinctValues | Kind::InterpolateAtSampleDistinctValues => VertexData::Ndc,
            Kind::CentroidQualifierInsidePrimitive => VertexData::NdcBarycentric,
            _ => VertexData::NdcScreen,
        }
    }
}

struct MultisampleInterpolationCase {
    name: String,
    kind: Kind,
    num_samples: u32,
    image_size: [u32; 3],
    component_data: ComponentData,
}

impl MultisampleInterpolationCase {
    fn samples(&self) -> vk::SampleCountFlags {
        vk::SampleCountFlags::from_bits_truncate(self.num_samples)
    }

    /// `MultisampleCaseBase::validateImageSize` for `IMAGE_TYPE_2D`.
    fn validate_image_size(&self, context: &Context<'_>) -> Result<(), TestError> {
        let limits = &context.get_device_properties().limits;
        if self.image_size[0] > limits.max_image_dimension_2d || self.image_size[1] > limits.max_image_dimension_2d {
            return Err(TestError::NotSupported(format!(
                "Image type (2D) with size ({}, {}, {}) not supported by device",
                self.image_size[0], self.image_size[1], self.image_size[2]
            )));
        }
        Ok(())
    }

    /// `MultisampleCaseBase::validateImageFeatureFlags`
    fn validate_image_feature_flags(
        &self,
        context: &Context<'_>,
        format: vk::Format,
        feature_flags: vk::FormatFeatureFlags,
    ) -> Result<(), TestError> {
        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        if !format_properties.optimal_tiling_features.contains(feature_flags) {
            return Err(TestError::NotSupported(format!(
                "Device does not support image format {format:?} for feature flags {feature_flags:?}"
            )));
        }
        Ok(())
    }

    /// `MultisampleCaseBase::validateImageInfo`
    fn validate_image_info(
        &self,
        context: &Context<'_>,
        samples: vk::SampleCountFlags,
        usage: vk::ImageUsageFlags,
    ) -> Result<(), TestError> {
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                IMAGE_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        if matches!(result, Err(e) if e == vk::ErrorCode::FORMAT_NOT_SUPPORTED) {
            return Err(TestError::NotSupported(
                "Image format properties not supported".to_string(),
            ));
        }
        let props = result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?;

        if props.max_extent.width < self.image_size[0]
            || props.max_extent.height < self.image_size[1]
            || props.max_extent.depth < 1
        {
            return Err(TestError::NotSupported(format!(
                "Image extent ({}, {}, 1) exceeds allowed maximum ({}, {}, {})",
                self.image_size[0],
                self.image_size[1],
                props.max_extent.width,
                props.max_extent.height,
                props.max_extent.depth
            )));
        }
        if props.max_array_layers < 1 {
            return Err(TestError::NotSupported(
                "Image layers count of 1 exceeds allowed maximum".to_string(),
            ));
        }
        if props.sample_counts & samples != samples {
            return Err(TestError::NotSupported(format!(
                "Samples count of {} not supported for image",
                self.num_samples
            )));
        }
        Ok(())
    }

    /// `MSCase<...>::checkImagesSupport`
    fn check_images_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.validate_image_size(context)?;
        self.validate_image_feature_flags(context, IMAGE_FORMAT, vk::FormatFeatureFlags::COLOR_ATTACHMENT)?;

        let usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT;
        // validate multisampled image
        self.validate_image_info(context, self.samples(), usage)?;
        // validate resolve image
        self.validate_image_info(context, vk::SampleCountFlags::_1, usage)
    }
}

impl TestCase for MultisampleInterpolationCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MSCase<...>::checkSupport`; the centroid-inside-primitive case does not ask for sample rate shading.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.check_images_support(context)?;

        if self.kind != Kind::CentroidQualifierInsidePrimitive
            && context.get_device_features().sample_rate_shading == vk::FALSE
        {
            return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
        }
        Ok(())
    }

    /// `MSCase<...>::initPrograms`
    fn programs(&self) -> BinaryCollection {
        match (self.kind, self.component_data) {
            (Kind::SampleQualifierDistinctValues, _) => DISTINCT_SAMPLE_QUALIFIER.programs,
            (Kind::InterpolateAtSampleDistinctValues, _) => DISTINCT_INTERPOLATE_AT_SAMPLE.programs,
            (Kind::InterpolateAtSampleSingleSample, _) => AT_SAMPLE_SINGLE_SAMPLE.programs,
            (Kind::InterpolateAtSampleIgnoresCentroid, _) => AT_SAMPLE_IGNORES_CENTROID.programs,
            (Kind::InterpolateAtSampleConsistency, ComponentData::None) => SAMPLE_CONSISTENCY_NONE.programs,
            (Kind::InterpolateAtSampleConsistency, ComponentData::Constant(0)) => SAMPLE_CONSISTENCY_CONST0.programs,
            (Kind::InterpolateAtSampleConsistency, ComponentData::Constant(_)) => SAMPLE_CONSISTENCY_CONST1.programs,
            (Kind::InterpolateAtSampleConsistency, ComponentData::PushConstant(_)) => SAMPLE_CONSISTENCY_PUSH.programs,
            (Kind::InterpolateAtCentroidConsistency, ComponentData::None) => CENTROID_CONSISTENCY_NONE.programs,
            (Kind::InterpolateAtCentroidConsistency, ComponentData::Constant(0)) => {
                CENTROID_CONSISTENCY_CONST0.programs
            }
            (Kind::InterpolateAtCentroidConsistency, ComponentData::Constant(_)) => {
                CENTROID_CONSISTENCY_CONST1.programs
            }
            (Kind::InterpolateAtCentroidConsistency, ComponentData::PushConstant(_)) => {
                CENTROID_CONSISTENCY_PUSH.programs
            }
            (Kind::InterpolateAtOffsetPixelCenter, _) => OFFSET_PIXEL_CENTER.programs,
            (Kind::InterpolateAtOffsetSamplePosition, ComponentData::None) => OFFSET_SAMPLE_POSITION_NONE.programs,
            (Kind::InterpolateAtOffsetSamplePosition, ComponentData::Constant(0)) => {
                OFFSET_SAMPLE_POSITION_CONST0.programs
            }
            (Kind::InterpolateAtOffsetSamplePosition, ComponentData::Constant(_)) => {
                OFFSET_SAMPLE_POSITION_CONST1.programs
            }
            (Kind::InterpolateAtOffsetSamplePosition, ComponentData::PushConstant(_)) => {
                OFFSET_SAMPLE_POSITION_PUSH.programs
            }
            (Kind::CentroidQualifierInsidePrimitive, _) => CENTROID_INSIDE_PRIMITIVE.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampleInterpolationInstance { context, case: self })
    }
}

struct MultisampleInterpolationInstance<'a> {
    context: &'a Context<'a>,
    case: &'a MultisampleInterpolationCase,
}

/// What `MSInstance<...>::getVertexDataDescripton` and `uploadVertexData` produce.
struct VertexDataDesc {
    primitive_topology: vk::PrimitiveTopology,
    vertices_count: u32,
    data_stride: u32,
    data: Vec<f32>,
    vertex_attrib_desc_vec: Vec<vk::VertexInputAttributeDescription>,
}

impl MultisampleInterpolationInstance<'_> {
    fn vertex_data(&self) -> VertexDataDesc {
        let attribute = |location: u32, format: vk::Format, offset: u32| vk::VertexInputAttributeDescription {
            location,
            binding: 0,
            format,
            offset,
        };

        match self.case.kind.vertex_data() {
            VertexData::Ndc => VertexDataDesc {
                primitive_topology: vk::PrimitiveTopology::TRIANGLE_LIST,
                vertices_count: 3,
                data_stride: 16,
                data: vec![-1.0, -1.0, 0.0, 1.0, -1.0, 4.0, 0.0, 1.0, 4.0, -1.0, 0.0, 1.0],
                vertex_attrib_desc_vec: vec![attribute(0, vk::Format::R32G32B32A32_SFLOAT, 0)],
            },
            VertexData::NdcScreen => {
                let screen_size_x = self.case.image_size[0] as f32;
                let screen_size_y = self.case.image_size[1] as f32;
                VertexDataDesc {
                    primitive_topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
                    vertices_count: 4,
                    data_stride: 24,
                    data: vec![
                        -1.0,
                        -1.0,
                        0.0,
                        1.0,
                        0.0,
                        0.0, //
                        1.0,
                        -1.0,
                        0.0,
                        1.0,
                        screen_size_x,
                        0.0, //
                        -1.0,
                        1.0,
                        0.0,
                        1.0,
                        0.0,
                        screen_size_y, //
                        1.0,
                        1.0,
                        0.0,
                        1.0,
                        screen_size_x,
                        screen_size_y,
                    ],
                    vertex_attrib_desc_vec: vec![
                        attribute(0, vk::Format::R32G32B32A32_SFLOAT, 0),
                        attribute(1, vk::Format::R32G32_SFLOAT, 16),
                    ],
                }
            }
            VertexData::NdcBarycentric => VertexDataDesc {
                primitive_topology: vk::PrimitiveTopology::TRIANGLE_LIST,
                vertices_count: 3,
                data_stride: 28,
                data: vec![
                    -1.0, -1.0, 0.0, 1.0, 0.0, 0.0, 1.0, //
                    -1.0, 1.0, 0.0, 1.0, 1.0, 0.0, 0.0, //
                    1.0, -1.0, 0.0, 1.0, 0.0, 1.0, 0.0,
                ],
                vertex_attrib_desc_vec: vec![
                    attribute(0, vk::Format::R32G32B32A32_SFLOAT, 0),
                    attribute(1, vk::Format::R32G32B32_SFLOAT, 16),
                ],
            },
        }
    }

    /// `MSInstance<...>::verifyImageData`
    fn verify_image_data(&self, pixels: &[u8]) -> TestOutcome {
        let width = self.case.image_size[0] as usize;
        let height = self.case.image_size[1] as usize;
        let pixel = |x: usize, y: usize| -> [u8; 4] {
            let offset = (y * width + x) * 4;
            [
                pixels[offset],
                pixels[offset + 1],
                pixels[offset + 2],
                pixels[offset + 3],
            ]
        };

        match self.case.kind.vertex_data() {
            VertexData::Ndc => {
                let distinct_values_expected = self.case.num_samples as usize + 1;

                let mut distinct_values: HashSet<[u8; 4]> = HashSet::new();
                for y in 0..height {
                    for x in 0..width {
                        distinct_values.insert(pixel(x, y));
                    }
                }

                if distinct_values.len() >= distinct_values_expected {
                    Ok(TestStatus::pass("Passed"))
                } else {
                    Ok(TestStatus::fail(
                        "Expected numSamples+1 different colors in the output image",
                    ))
                }
            }
            VertexData::NdcScreen | VertexData::NdcBarycentric => {
                // `checkForError` over component 0.
                for y in 0..height {
                    for x in 0..width {
                        if pixel(x, y)[0] > 0 {
                            return Ok(TestStatus::fail("Failed"));
                        }
                    }
                }
                Ok(TestStatus::pass("Passed"))
            }
        }
    }
}

impl TestInstance for MultisampleInterpolationInstance<'_> {
    /// `MSInstanceBaseResolve::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let features = context.get_device_features();
        let (width, height) = (self.case.image_size[0], self.case.image_size[1]);
        let num_samples = self.case.samples();
        let use_push_constants = matches!(self.case.component_data, ComponentData::PushConstant(_));
        let push_constant_size = std::mem::size_of::<u32>() as u32;

        let image_ms_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(IMAGE_FORMAT)
            .extent(vk::Extent3D {
                width,
                height,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(num_samples)
            .tiling(vk::ImageTiling::OPTIMAL)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .build();
        let image_ms = ImageWithMemory::new(device, allocator, image_ms_info, MemoryRequirement::ANY)?;

        let mut image_rs_info = image_ms_info;
        image_rs_info.samples = vk::SampleCountFlags::_1;
        let image_rs = ImageWithMemory::new(device, allocator, image_rs_info, MemoryRequirement::ANY)?;

        // Create render pass
        let attachment_description = |samples: vk::SampleCountFlags| {
            vk::AttachmentDescription::builder()
                .format(IMAGE_FORMAT)
                .samples(samples)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build()
        };
        let attachments = [
            attachment_description(image_ms_info.samples),
            attachment_description(image_rs_info.samples),
        ];
        let attachment_ms_ref = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let attachment_rs_ref = [vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];

        let multisampled = self.case.num_samples != 1;
        let mut subpass_description = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&attachment_ms_ref);
        if multisampled {
            subpass_description = subpass_description.resolve_attachments(&attachment_rs_ref);
        }
        let subpasses = [subpass_description.build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        let full_image_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        // Create color attachments image views
        let image_ms_view = make_image_view(
            device,
            image_ms.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            full_image_range,
        )?;
        let image_rs_view = make_image_view(
            device,
            image_rs.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            full_image_range,
        )?;

        // Create framebuffer
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*image_ms_view, *image_rs_view],
            width,
            height,
            1,
        )?;

        // Create pipeline layout
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::ALL,
            offset: 0,
            size: push_constant_size,
        }];
        let mut pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder();
        if use_push_constants {
            pipeline_layout_info = pipeline_layout_info.push_constant_ranges(&push_constant_ranges);
        }
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Create vertex attributes data
        let vertex_data_desc = self.vertex_data();
        let vertex_buffer = create_host_buffer(context, &vertex_data_desc.data, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let mut state = DrawPipelineState::new(vertex_data_desc.primitive_topology).with_full_viewport(width, height);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: vertex_data_desc.data_stride,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vertex_data_desc.vertex_attrib_desc_vec.clone();
        state.samples = image_ms_info.samples;
        state.sample_shading = features.sample_rate_shading != vk::FALSE;
        state.min_sample_shading = 1.0;

        let binaries = context.get_binary_collection();
        let vs_module = create_shader_module(device, binaries.get("vertex_shader")?)?;
        let fs_module = create_shader_module(device, binaries.get("fragment_shader")?)?;

        // Create graphics pipeline, or the shader objects
        let shader_object_push_constants: &[vk::PushConstantRange] =
            if use_push_constants { &push_constant_ranges } else { &[] };
        let shader_objects = make_shader_objects_stages(
            context,
            &[
                (vk::ShaderStageFlags::VERTEX, "vertex_shader"),
                (vk::ShaderStageFlags::FRAGMENT, "fragment_shader"),
            ],
            &[],
            shader_object_push_constants,
        )?;
        let graphics_pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vs_module),
                    (vk::ShaderStageFlags::FRAGMENT, *fs_module),
                ],
                &state,
            )?)
        };

        // Create command buffer for compute and transfer oparations
        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        // Start recording commands
        begin_command_buffer(device, cmd)?;

        {
            let image_output_attachment_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    image_ms.get(),
                    full_image_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    image_rs.get(),
                    full_image_range,
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &image_output_attachment_barriers,
                );
            }
        }

        {
            let clear_values = [
                clear_value_color([0.0, 0.0, 0.0, 1.0]),
                clear_value_color([0.0, 0.0, 0.0, 1.0]),
            ];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(width, height))
                .clear_values(&clear_values);

            if let Some(shader_objects) = &shader_objects {
                begin_dynamic_rendering_resolve(
                    device,
                    cmd,
                    rect_2d(width, height),
                    *image_ms_view,
                    multisampled.then_some(*image_rs_view),
                    clear_values[0],
                );
                shader_objects.bind(cmd, &state);
            } else if let Some(graphics_pipeline) = &graphics_pipeline {
                unsafe {
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipeline.get());
                }
            }

            unsafe {
                // Bind vertex buffer
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

                // Push constants.
                if use_push_constants {
                    let index = match self.case.component_data {
                        ComponentData::PushConstant(index) => index,
                        _ => 0,
                    };
                    device.cmd_push_constants(
                        cmd,
                        *pipeline_layout,
                        vk::ShaderStageFlags::ALL,
                        0,
                        &index.to_ne_bytes(),
                    );
                }

                // Draw full screen quad
                device.cmd_draw(cmd, vertex_data_desc.vertices_count, 1, 0, 0);
            }
            if shader_objects.is_some() {
                end_dynamic_rendering(device, cmd);
            } else {
                unsafe { device.cmd_end_render_pass(cmd) };
            }
        }

        let source_image = if multisampled { image_rs.get() } else { image_ms.get() };

        // Copy data from resolve image to buffer
        let image_rs_size_in_bytes = (width * height * 4) as usize;
        let buffer_rs = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                image_rs_size_in_bytes as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        copy_image_to_buffer(device, cmd, source_image, buffer_rs.get(), width, height);

        // End recording commands
        end_command_buffer(device, cmd)?;

        // Submit commands for execution and wait for completion
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        // Retrieve data from buffer to host memory
        let alloc = buffer_rs.get_allocation();
        crate::vk::mem_util::invalidate_alloc(device, alloc)?;
        let pixels = unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), image_rs_size_in_bytes) };

        self.verify_image_data(pixels)
    }
}

/// `makeMSGroup`
fn make_ms_group(name: &str, kind: Kind, component_data: ComponentData) -> TestCaseGroup {
    let image_sizes: [[u32; 3]; 2] = [[128, 128, 1], [137, 191, 1]];
    let image_samples: [u32; 6] = [2, 4, 8, 16, 32, 64];

    let mut case_group = TestCaseGroup::new(name);

    for image_size in image_sizes {
        let mut size_group = TestCaseGroup::new(format!("{}_{}_{}", image_size[0], image_size[1], image_size[2]));

        for samples in image_samples {
            size_group.add_child(Box::new(MultisampleInterpolationCase {
                name: format!("samples_{samples}"),
                kind,
                num_samples: samples,
                image_size,
                component_data,
            }) as Box<dyn TestCase>);
        }

        case_group.add_child(size_group);
    }
    case_group
}

/// The five `all_components` / `component_0` / `component_1` / `pushc_component_0` / `pushc_component_1` groups
/// `createMultisampleInterpolationTests` builds for each consistency family.
fn make_component_groups(group_name: &str, kind: Kind) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(group_name);
    group.add_child(make_ms_group("all_components", kind, ComponentData::None));
    group.add_child(make_ms_group("component_0", kind, ComponentData::Constant(0)));
    group.add_child(make_ms_group("component_1", kind, ComponentData::Constant(1)));
    group.add_child(make_ms_group("pushc_component_0", kind, ComponentData::PushConstant(0)));
    group.add_child(make_ms_group("pushc_component_1", kind, ComponentData::PushConstant(1)));
    group
}

/// `createMultisampleInterpolationTests`
pub fn create_multisample_interpolation_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("multisample_interpolation");

    let image_sizes: [[u32; 3]; 2] = [[128, 128, 1], [137, 191, 1]];

    let mut case_group = TestCaseGroup::new("sample_interpolate_at_single_sample");
    for image_size in image_sizes {
        let mut size_group = TestCaseGroup::new(format!("{}_{}_{}", image_size[0], image_size[1], image_size[2]));
        size_group.add_child(Box::new(MultisampleInterpolationCase {
            name: "samples_1".to_string(),
            kind: Kind::InterpolateAtSampleSingleSample,
            num_samples: 1,
            image_size,
            component_data: ComponentData::None,
        }) as Box<dyn TestCase>);
        case_group.add_child(size_group);
    }
    test_group.add_child(case_group);

    test_group.add_child(make_ms_group(
        "sample_interpolate_at_distinct_values",
        Kind::InterpolateAtSampleDistinctValues,
        ComponentData::None,
    ));
    test_group.add_child(make_ms_group(
        "sample_interpolate_at_ignores_centroid",
        Kind::InterpolateAtSampleIgnoresCentroid,
        ComponentData::None,
    ));

    // Test consistency in sample interpolation function
    test_group.add_child(make_component_groups(
        "sample_interpolation_consistency",
        Kind::InterpolateAtSampleConsistency,
    ));

    test_group.add_child(make_ms_group(
        "sample_qualifier_distinct_values",
        Kind::SampleQualifierDistinctValues,
        ComponentData::None,
    ));

    // Test consistency in centroid interpolation function
    test_group.add_child(make_component_groups(
        "centroid_interpolation_consistency",
        Kind::InterpolateAtCentroidConsistency,
    ));

    // The amber `reinterpolation_consistency` and `nonuniform_interpolant_indexing` groups are not ported.
    test_group.add_child(make_ms_group(
        "centroid_qualifier_inside_primitive",
        Kind::CentroidQualifierInsidePrimitive,
        ComponentData::None,
    ));
    test_group.add_child(make_ms_group(
        "offset_interpolate_at_pixel_center",
        Kind::InterpolateAtOffsetPixelCenter,
        ComponentData::None,
    ));

    test_group.add_child(make_component_groups(
        "offset_interpolation_at_sample_position",
        Kind::InterpolateAtOffsetSamplePosition,
    ));

    test_group
}
