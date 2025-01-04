// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleShaderBuiltInTests.cpp
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineMultisampleBaseResolveAndPerSampleFetch.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Copyright (c) 2023 LunarG, Inc.
// Copyright (c) 2023 Nintendo
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `MSCase<Class>` / `MSInstance<Class>` template specialisations are
// one `Kind` enum here and `MSInstanceBaseResolveAndPerSampleFetch::iterate` is `MultisampleBuiltinInstance::iterate`. Ported:
// `sample_id`, `sample_position`, `sample_mask`, `image_write_sample` and `write_sample_mask`. The images and log sections of upstream are not produced.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_multisample_shader_builtin::ALL_SHARED_PROGRAM;
use crate::tcu::pixel::ConstPixelBufferAccess;
use crate::tcu::{TestError, TestOutcome, TestStatus, map_vk_format};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const FIRST_SUBPASS_ATTACHMENTS_COUNT: u32 = 2;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    SampleId,
    SamplePosDistribution,
    SamplePosCorrectness,
    SampleMaskPattern,
    SampleMaskBitCount,
    SampleMaskCorrectBit,
    SampleMaskWrite,
}

impl Kind {
    /// Whether `MSCase<...>::checkSupport` asks for sample rate shading.
    fn requires_sample_rate_shading(self) -> bool {
        !matches!(self, Kind::SampleMaskPattern | Kind::SampleMaskWrite)
    }

    /// `getMSStateCreateInfo`'s `sampleShadingEnable`.
    fn sample_shading_enable(self) -> bool {
        !matches!(self, Kind::SampleMaskPattern | Kind::SampleMaskWrite)
    }

    /// Whether the vertex data is `VertexDataNdcScreen` rather than `VertexDataNdc`.
    fn has_screen_position(self) -> bool {
        self == Kind::SamplePosCorrectness
    }
}

fn samples_value(samples: vk::SampleCountFlags) -> u32 {
    samples.bits()
}

struct MultisampleBuiltinCase {
    name: String,
    /// The name of the case in the shader manifest.
    program_set: String,
    kind: Kind,
    image_size: [u32; 2],
    samples: vk::SampleCountFlags,
    shading_rate: f32,
}

impl MultisampleBuiltinCase {
    #[allow(clippy::new_ret_no_self)]
    fn new(
        name: &str,
        program_set: &str,
        kind: Kind,
        image_size: [u32; 2],
        samples: vk::SampleCountFlags,
        shading_rate: f32,
    ) -> Box<dyn TestCase> {
        Box::new(Self {
            name: name.to_string(),
            program_set: program_set.to_string(),
            kind,
            image_size,
            samples,
            shading_rate,
        })
    }

    /// `validateImageInfo`
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
                samples_value(samples)
            )));
        }
        Ok(())
    }

    /// `MSCase<...>::checkImagesSupport`
    fn check_images_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // check if image size does not exceed device limits
        let limits = &context.get_device_properties().limits;
        if self.image_size[0] > limits.max_image_dimension_2d || self.image_size[1] > limits.max_image_dimension_2d {
            return Err(TestError::NotSupported(format!(
                "Image type (2D) with size ({}, {}, 1) not supported by device",
                self.image_size[0], self.image_size[1]
            )));
        }

        // check if device supports image format as color attachment
        let format_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), IMAGE_FORMAT)
        };
        if !format_properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
        {
            return Err(TestError::NotSupported(format!(
                "Device does not support image format {IMAGE_FORMAT:?} for feature flags COLOR_ATTACHMENT"
            )));
        }

        // validate multisampled image
        self.validate_image_info(
            context,
            self.samples,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT,
        )?;
        // validate resolve image
        self.validate_image_info(
            context,
            vk::SampleCountFlags::_1,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        )
    }
}

impl TestCase for MultisampleBuiltinCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.check_images_support(context)?;

        if self.kind.requires_sample_rate_shading() && context.get_device_features().sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported("sampleRateShading not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == self.program_set)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {}", self.program_set))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultisampleBuiltinInstance { context, case: self })
    }
}

struct MultisampleBuiltinInstance<'a> {
    context: &'a Context<'a>,
    case: &'a MultisampleBuiltinCase,
}

fn make_image_info(
    width: u32,
    height: u32,
    samples: vk::SampleCountFlags,
    usage: vk::ImageUsageFlags,
) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(IMAGE_FORMAT)
        .extent(vk::Extent3D {
            width,
            height,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(samples)
        .tiling(vk::ImageTiling::OPTIMAL)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .build()
}

/// `checkForErrorMS` - whether `error_comp` of any pixel of any sample's image is set.
fn check_for_error_ms(
    width: u32,
    height: u32,
    data_per_sample: &[ConstPixelBufferAccess<'_>],
    error_comp: usize,
) -> bool {
    for y in 0..height {
        for x in 0..width {
            for sample in data_per_sample {
                if sample.get_pixel_uint(x, y, 0)[error_comp] > 0 {
                    return true;
                }
            }
        }
    }
    false
}

/// `checkForErrorRS`
fn check_for_error_rs(width: u32, height: u32, data_rs: &ConstPixelBufferAccess<'_>, error_comp: usize) -> bool {
    for y in 0..height {
        for x in 0..width {
            if data_rs.get_pixel_uint(x, y, 0)[error_comp] > 0 {
                return true;
            }
        }
    }
    false
}

impl MultisampleBuiltinInstance<'_> {
    /// `MSInstance<...>::verifyImageData`
    fn verify_image_data(
        &self,
        data_per_sample: &[ConstPixelBufferAccess<'_>],
        data_rs: &ConstPixelBufferAccess<'_>,
    ) -> TestStatus {
        let [width, height] = self.case.image_size;
        let num_samples = samples_value(self.case.samples);

        match self.case.kind {
            Kind::SampleId => {
                for (sample_ndx, sample) in data_per_sample.iter().enumerate() {
                    for y in 0..height {
                        for x in 0..width {
                            let sample_id = sample.get_pixel_uint(x, y, 0)[0];

                            if sample_id != sample_ndx as u32 {
                                return TestStatus::fail("gl_SampleID does not have correct value");
                            }
                        }
                    }
                }
                TestStatus::pass("Passed")
            }
            Kind::SamplePosDistribution => {
                // approximate Bates distribution as normal
                let variance = 1.0f32 / (12.0 * num_samples as f32);
                let standard_deviation = variance.sqrt();

                // 95% of means of sample positions are within 2 standard deviations if they were randomly assigned. Sample
                // patterns are expected to be more uniform than a random pattern.
                let distance_threshold = 2.0 * standard_deviation;

                for y in 0..height {
                    for x in 0..width {
                        let pixel = data_rs.get_pixel_uint(x, y, 0);

                        if pixel[2] > 0 {
                            return TestStatus::fail("gl_SamplePosition is not within interval [0,1]");
                        }

                        if num_samples >= 4 {
                            let average_sample_pos = [pixel[0] as f32 / 255.0, pixel[1] as f32 / 255.0];
                            let distance_from_center =
                                [(average_sample_pos[0] - 0.5).abs(), (average_sample_pos[1] - 0.5).abs()];

                            if distance_from_center[0] > distance_threshold
                                || distance_from_center[1] > distance_threshold
                            {
                                return TestStatus::fail(
                                    "Sample positions are not uniformly distributed within the pixel",
                                );
                            }
                        }
                    }
                }

                for y in 0..height {
                    for x in 0..width {
                        let mut sample_positions = Vec::with_capacity(num_samples as usize);

                        for sample in data_per_sample {
                            let pixel = sample.get_pixel_uint(x, y, 0);

                            if pixel[2] > 0 {
                                return TestStatus::fail("gl_SamplePosition is not within interval [0,1]");
                            }

                            sample_positions.push([pixel[0] as f32 / 255.0, pixel[1] as f32 / 255.0]);
                        }

                        for sample_ndx_a in 0..sample_positions.len() {
                            for sample_ndx_b in sample_ndx_a + 1..sample_positions.len() {
                                if sample_positions[sample_ndx_a] == sample_positions[sample_ndx_b] {
                                    return TestStatus::fail("Two samples have the same position");
                                }
                            }
                        }

                        if num_samples >= 4 {
                            let mut average_sample_pos = [0.0f32, 0.0];

                            for position in &sample_positions {
                                average_sample_pos[0] += position[0];
                                average_sample_pos[1] += position[1];
                            }

                            average_sample_pos[0] /= num_samples as f32;
                            average_sample_pos[1] /= num_samples as f32;

                            let distance_from_center =
                                [(average_sample_pos[0] - 0.5).abs(), (average_sample_pos[1] - 0.5).abs()];

                            if distance_from_center[0] > distance_threshold
                                || distance_from_center[1] > distance_threshold
                            {
                                return TestStatus::fail(
                                    "Sample positions are not uniformly distributed within the pixel",
                                );
                            }
                        }
                    }
                }

                TestStatus::pass("Passed")
            }
            Kind::SamplePosCorrectness => {
                if check_for_error_ms(width, height, data_per_sample, 0)
                    || check_for_error_rs(width, height, data_rs, 0)
                {
                    return TestStatus::fail("Varying values are not sampled at gl_SamplePosition");
                }
                TestStatus::pass("Passed")
            }
            Kind::SampleMaskPattern => {
                if check_for_error_ms(width, height, data_per_sample, 0) {
                    return TestStatus::fail("gl_SampleMaskIn bits have not been killed by pSampleMask state");
                }
                TestStatus::pass("Passed")
            }
            Kind::SampleMaskBitCount => {
                if check_for_error_ms(width, height, data_per_sample, 0) {
                    return TestStatus::fail(
                        "gl_SampleMaskIn has an illegal number of bits for some shader invocations",
                    );
                }
                TestStatus::pass("Passed")
            }
            Kind::SampleMaskCorrectBit => {
                if check_for_error_ms(width, height, data_per_sample, 0) {
                    return TestStatus::fail(
                        "The bit corresponsing to current gl_SampleID is not set in gl_SampleMaskIn",
                    );
                }
                TestStatus::pass("Passed")
            }
            Kind::SampleMaskWrite => {
                for y in 0..height {
                    for x in 0..width {
                        for sample in data_per_sample {
                            let first_component = sample.get_pixel_uint(x, y, 0)[0];

                            if first_component != 0 && first_component != 255 {
                                return TestStatus::fail("Expected color to be zero or saturated on the first channel");
                            }
                        }
                    }
                }

                for y in 0..height {
                    for x in 0..width {
                        let first_component = data_rs.get_pixel(x, y, 0)[0];

                        if (first_component - 0.5).abs() > 0.02 {
                            return TestStatus::fail(
                                "Expected resolve color to be half intensity on the first channel",
                            );
                        }
                    }
                }

                TestStatus::pass("Passed")
            }
        }
    }
}

impl TestInstance for MultisampleBuiltinInstance<'_> {
    /// `MSInstanceBaseResolveAndPerSampleFetch::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let kind = self.case.kind;
        let [width, height] = self.case.image_size;
        let samples = self.case.samples;
        let num_samples = samples_value(samples);

        let image_ms_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT;
        let image_rs_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let image_ms = ImageWithMemory::new(
            device,
            allocator,
            make_image_info(width, height, samples, image_ms_usage),
            MemoryRequirement::ANY,
        )?;
        let image_rs = ImageWithMemory::new(
            device,
            allocator,
            make_image_info(width, height, vk::SampleCountFlags::_1, image_rs_usage),
            MemoryRequirement::ANY,
        )?;

        let mut images_per_sample = Vec::new();
        for _ in 0..num_samples {
            images_per_sample.push(ImageWithMemory::new(
                device,
                allocator,
                make_image_info(width, height, vk::SampleCountFlags::_1, image_rs_usage),
                MemoryRequirement::ANY,
            )?);
        }

        // Create render pass
        let attachment_ms_desc = vk::AttachmentDescription::builder()
            .format(IMAGE_FORMAT)
            .samples(samples)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
            .build();
        let attachment_rs_desc = vk::AttachmentDescription::builder()
            .format(IMAGE_FORMAT)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build();

        let mut attachments = vec![attachment_ms_desc, attachment_rs_desc];
        for _ in 0..num_samples {
            attachments.push(attachment_rs_desc);
        }

        let attachment_ms_color_ref = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let attachment_ms_input_ref = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let attachment_rs_color_ref = [vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];

        let per_sample_attachment_ref: Vec<[vk::AttachmentReference; 1]> = (0..num_samples)
            .map(|sample_ndx| {
                [vk::AttachmentReference {
                    attachment: FIRST_SUBPASS_ATTACHMENTS_COUNT + sample_ndx,
                    layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                }]
            })
            .collect();

        let preserve_attachments: Vec<u32> = (0..1 + num_samples).map(|attach_ndx| 1 + attach_ndx).collect();

        let mut subpasses = vec![
            vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&attachment_ms_color_ref)
                .resolve_attachments(&attachment_rs_color_ref)
                .build(),
        ];
        let mut subpass_dependencies = Vec::new();

        for sample_ndx in 0..num_samples {
            subpasses.push(
                vk::SubpassDescription::builder()
                    .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                    .input_attachments(&attachment_ms_input_ref)
                    .color_attachments(&per_sample_attachment_ref[sample_ndx as usize])
                    .preserve_attachments(&preserve_attachments[..1 + sample_ndx as usize])
                    .build(),
            );

            if sample_ndx == 0 {
                // The second subpass will be in charge of transitioning the multisample attachment from
                // COLOR_ATTACHMENT_OPTIMAL to SHADER_READ_ONLY_OPTIMAL.
                subpass_dependencies.push(
                    vk::SubpassDependency::builder()
                        .src_subpass(0)
                        .dst_subpass(1 + sample_ndx)
                        .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
                        .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                        .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                        .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                        .dependency_flags(vk::DependencyFlags::empty())
                        .build(),
                );
            } else {
                // Make sure subpass reads are in order. This serializes subpasses to make sure there are no layout transition hazards
                // in the multisample image, from COLOR_ATTACHMENT_OPTIMAL to SHADER_READ_ONLY_OPTIMAL, caused by parallel execution
                // of several subpasses.
                subpass_dependencies.push(
                    vk::SubpassDependency::builder()
                        .src_subpass(sample_ndx)
                        .dst_subpass(1 + sample_ndx)
                        .src_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                        .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                        .src_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                        .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                        .dependency_flags(vk::DependencyFlags::empty())
                        .build(),
                );
            }
        }

        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .dependencies(&subpass_dependencies);
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        let render_pass = Unique::new(device, render_pass);

        let full_image_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        // Create color attachments image views
        let image_view_ms = make_image_view(
            device,
            image_ms.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            full_image_range,
        )?;
        let image_view_rs = make_image_view(
            device,
            image_rs.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            full_image_range,
        )?;
        let mut per_sample_views = Vec::new();
        for image in &images_per_sample {
            per_sample_views.push(make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                IMAGE_FORMAT,
                full_image_range,
            )?);
        }

        let mut image_views = vec![*image_view_ms, *image_view_rs];
        image_views.extend(per_sample_views.iter().map(|view| **view));

        // Create framebuffer
        let framebuffer = make_framebuffer(device, *render_pass, &image_views, width, height, 1)?;

        // The descriptor set of the multisample pass: only the sample mask pattern case has one.
        let ms_pass_descriptor_layout = if kind == Kind::SampleMaskPattern {
            Some(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::FRAGMENT)
                    .build(device)?,
            )
        } else {
            None
        };

        // Create pipeline layout
        let ms_pass_set_layouts: Vec<vk::DescriptorSetLayout> =
            ms_pass_descriptor_layout.iter().map(|layout| **layout).collect();
        let pipeline_layout_ms_pass = make_pipeline_layout(device, &ms_pass_set_layouts)?;

        // The sample mask of the pattern case, and of `MSInstanceSampleMaskPattern::MSInstanceSampleMaskPattern`:
        // `1u << 32` is undefined upstream; the x86 shift it compiles to leaves the shift count at zero.
        let sample_mask: u32 = 0xAAAA_AAAA & 1u32.wrapping_shl(num_samples).wrapping_sub(1);

        // Create vertex attributes data
        let (vertex_data, vertex_stride, vertex_attributes): (Vec<f32>, u32, Vec<vk::VertexInputAttributeDescription>) =
            if kind.has_screen_position() {
                let (screen_x, screen_y) = (width as f32, height as f32);
                (
                    vec![
                        -1.0, -1.0, 0.0, 1.0, 0.0, 0.0, //
                        1.0, -1.0, 0.0, 1.0, screen_x, 0.0, //
                        -1.0, 1.0, 0.0, 1.0, 0.0, screen_y, //
                        1.0, 1.0, 0.0, 1.0, screen_x, screen_y,
                    ],
                    24,
                    vec![
                        vk::VertexInputAttributeDescription {
                            location: 0,
                            binding: 0,
                            format: vk::Format::R32G32B32A32_SFLOAT,
                            offset: 0,
                        },
                        vk::VertexInputAttributeDescription {
                            location: 1,
                            binding: 0,
                            format: vk::Format::R32G32_SFLOAT,
                            offset: 16,
                        },
                    ],
                )
            } else {
                (
                    vec![
                        -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
                    ],
                    16,
                    vec![vk::VertexInputAttributeDescription {
                        location: 0,
                        binding: 0,
                        format: vk::Format::R32G32B32A32_SFLOAT,
                        offset: 0,
                    }],
                )
            };
        let vertex_buffer = create_host_buffer(context, &vertex_data, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let binaries = context.get_binary_collection();

        // Create graphics pipeline for multisample pass
        let vs_ms_pass_module = create_shader_module(device, binaries.get("vertex_shader")?)?;
        let fs_ms_pass_module = create_shader_module(device, binaries.get("fragment_shader")?)?;

        let mut ms_pass_state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP).with_full_viewport(width, height);
        ms_pass_state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: vertex_stride,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        ms_pass_state.attributes = vertex_attributes;
        ms_pass_state.rasterization.depth_bias_enable = vk::FALSE;
        ms_pass_state.samples = samples;
        ms_pass_state.sample_shading = kind.sample_shading_enable();
        ms_pass_state.min_sample_shading = self.case.shading_rate;
        if kind == Kind::SampleMaskPattern {
            ms_pass_state.sample_mask = Some(sample_mask);
        }
        let graphics_pipeline_ms_pass = create_draw_pipeline(
            device,
            *pipeline_layout_ms_pass,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vs_ms_pass_module),
                (vk::ShaderStageFlags::FRAGMENT, *fs_ms_pass_module),
            ],
            &ms_pass_state,
        )?;

        // Create descriptor set layout of the per sample fetch passes
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .add_single_binding(
                vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC,
                vk::ShaderStageFlags::FRAGMENT,
            )
            .build(device)?;
        let pipeline_layout_per_sample_fetch_pass = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        const BUFFER_PER_SAMPLE_FETCH_PASS_SIZE: usize = 4 * 16;
        let vertices_per_sample_fetch_pass: [f32; 16] = [
            -1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
        ];
        debug_assert!(std::mem::size_of_val(&vertices_per_sample_fetch_pass) == BUFFER_PER_SAMPLE_FETCH_PASS_SIZE);
        let vertex_buffer_per_sample_fetch_pass = create_host_buffer(
            context,
            &vertices_per_sample_fetch_pass,
            vk::BufferUsageFlags::VERTEX_BUFFER,
        )?;

        // Create graphics pipelines for per sample texel fetch passes
        let vs_per_sample_fetch_pass_module = create_shader_module(device, binaries.get("per_sample_fetch_vs")?)?;
        let fs_per_sample_fetch_pass_module = create_shader_module(device, binaries.get("per_sample_fetch_fs")?)?;
        let mut graphics_pipelines_per_sample_fetch = Vec::new();
        for sample_ndx in 0..num_samples {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
                .with_full_viewport(width, height)
                .with_position_input();
            state.rasterization.depth_bias_enable = vk::FALSE;
            state.subpass = 1 + sample_ndx;
            graphics_pipelines_per_sample_fetch.push(create_draw_pipeline(
                device,
                *pipeline_layout_per_sample_fetch_pass,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vs_per_sample_fetch_pass_module),
                    (vk::ShaderStageFlags::FRAGMENT, *fs_per_sample_fetch_pass_module),
                ],
                &state,
            )?);
        }

        // Create descriptor pool
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .add_type(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        // Create descriptor set
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let device_limits = &context.get_device_properties().limits;
        let min_alignment = device_limits.min_uniform_buffer_offset_alignment;
        let mut ubo_offset_alignment = if (std::mem::size_of::<i32>() as u64) < min_alignment {
            min_alignment
        } else {
            std::mem::size_of::<i32>() as u64
        };
        ubo_offset_alignment += (min_alignment - ubo_offset_alignment % min_alignment) % min_alignment;

        let buffer_sample_id_size = ubo_offset_alignment * u64::from(num_samples);
        let buffer_sample_id = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_sample_id_size, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let mut sample_ids_offsets = vec![0u32; num_samples as usize];
        {
            let mut sample_ids = vec![0u8; buffer_sample_id_size as usize];

            for sample_ndx in 0..num_samples {
                let offset = (u64::from(sample_ndx) * ubo_offset_alignment) as usize;
                sample_ids_offsets[sample_ndx as usize] = offset as u32;
                sample_ids[offset..offset + 4].copy_from_slice(&(sample_ndx as i32).to_ne_bytes());
            }

            let allocation = buffer_sample_id.get_allocation();
            unsafe { std::ptr::copy_nonoverlapping(sample_ids.as_ptr(), allocation.get_host_ptr(), sample_ids.len()) };
            flush_alloc(device, allocation)?;
        }

        {
            let desc_image_info = [vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: *image_view_ms,
                image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
            }];
            let desc_buffer_info = [vk::DescriptorBufferInfo {
                buffer: buffer_sample_id.get(),
                offset: 0,
                range: std::mem::size_of::<i32>() as vk::DeviceSize,
            }];
            let writes = [
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(0)
                    .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                    .image_info(&desc_image_info)
                    .build(),
                vk::WriteDescriptorSet::builder()
                    .dst_set(descriptor_set.get())
                    .dst_binding(1)
                    .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC)
                    .buffer_info(&desc_buffer_info)
                    .build(),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        // The descriptor set of the multisample pass (`createMSPassDescSet`).
        let _ms_pass_pool;
        let ms_pass_set;
        let _ms_pass_buffer;
        if let Some(layout) = &ms_pass_descriptor_layout {
            _ms_pass_pool = Some(
                DescriptorPoolBuilder::new()
                    .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
                    .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?,
            );
            let set = make_descriptor_set(device, **_ms_pass_pool.as_ref().expect("just created"), **layout)?;

            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(
                    std::mem::size_of::<u32>() as vk::DeviceSize,
                    vk::BufferUsageFlags::UNIFORM_BUFFER,
                ),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    sample_mask.to_ne_bytes().as_ptr(),
                    buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of::<u32>(),
                )
            };
            flush_alloc(device, buffer.get_allocation())?;

            let desc_buffer_info = [vk::DescriptorBufferInfo {
                buffer: buffer.get(),
                offset: 0,
                range: std::mem::size_of::<u32>() as vk::DeviceSize,
            }];
            let write = vk::WriteDescriptorSet::builder()
                .dst_set(set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
                .buffer_info(&desc_buffer_info)
                .build();
            unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

            ms_pass_set = Some(set);
            _ms_pass_buffer = Some(buffer);
        } else {
            _ms_pass_pool = None;
            ms_pass_set = None;
            _ms_pass_buffer = None;
        }

        // Create command buffer for compute and transfer oparations
        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        let image_rs_size_in_bytes = u64::from(width) * u64::from(height) * 4;
        let buffer_rs = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(image_rs_size_in_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let mut buffers_per_sample = Vec::new();
        for _ in 0..num_samples {
            buffers_per_sample.push(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(image_rs_size_in_bytes, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?);
        }

        // Start recording commands
        begin_command_buffer(device, cmd)?;

        {
            let mut image_output_attachment_barriers = vec![
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
            for image in &images_per_sample {
                image_output_attachment_barriers.push(make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    image.get(),
                    full_image_range,
                ));
            }

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
            let clear_values = vec![
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 1.0]
                    }
                };
                (FIRST_SUBPASS_ATTACHMENTS_COUNT + num_samples) as usize
            ];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(width, height))
                .clear_values(&clear_values);

            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

                // Bind graphics pipeline
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline_ms_pass);

                if let Some(set) = &ms_pass_set {
                    // Bind descriptor set
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layout_ms_pass,
                        0,
                        &[set.get()],
                        &[] as &[u32],
                    );
                }

                // Bind vertex buffer and perform a draw
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_draw(cmd, 4, 1, 0, 0);

                for sample_ndx in 0..num_samples as usize {
                    device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);

                    // Bind graphics pipeline
                    device.cmd_bind_pipeline(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *graphics_pipelines_per_sample_fetch[sample_ndx],
                    );

                    // Bind descriptor set
                    device.cmd_bind_descriptor_sets(
                        cmd,
                        vk::PipelineBindPoint::GRAPHICS,
                        *pipeline_layout_per_sample_fetch_pass,
                        0,
                        &[descriptor_set.get()],
                        &[sample_ids_offsets[sample_ndx]],
                    );

                    // Bind vertex buffer and perform a draw
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer_per_sample_fetch_pass.get()], &[0]);
                    device.cmd_draw(cmd, 4, 1, 0, 0);
                }

                // End render pass
                device.cmd_end_render_pass(cmd);
            }
        }

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width,
                height,
                depth: 1,
            },
        };

        unsafe {
            let image_rs_transfer_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image_rs.get(),
                full_image_range,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[image_rs_transfer_barrier],
            );

            // Copy data from imageRS to buffer
            device.cmd_copy_image_to_buffer(
                cmd,
                image_rs.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                buffer_rs.get(),
                &[copy_region],
            );

            let buffer_rs_host_read_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                buffer_rs.get(),
                0,
                image_rs_size_in_bytes,
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_rs_host_read_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );

            // Copy data from per sample images to buffers
            let images_per_sample_transfer_barriers: Vec<vk::ImageMemoryBarrier> = images_per_sample
                .iter()
                .map(|image| {
                    make_image_memory_barrier(
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::AccessFlags::TRANSFER_READ,
                        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                        image.get(),
                        full_image_range,
                    )
                })
                .collect();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &images_per_sample_transfer_barriers,
            );

            for (image, buffer) in images_per_sample.iter().zip(&buffers_per_sample) {
                device.cmd_copy_image_to_buffer(
                    cmd,
                    image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    buffer.get(),
                    &[copy_region],
                );
            }

            let buffers_per_sample_host_read_barriers: Vec<vk::BufferMemoryBarrier> = buffers_per_sample
                .iter()
                .map(|buffer| {
                    make_buffer_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::HOST_READ,
                        buffer.get(),
                        0,
                        image_rs_size_in_bytes,
                    )
                })
                .collect();
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &buffers_per_sample_host_read_barriers,
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        // End recording commands, submit them for execution and wait for completion
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // Retrieve data from the buffers to host memory
        let tcu_format = map_vk_format(IMAGE_FORMAT).expect("RGBA8 has a texture format");
        let size = [width, height, 1];

        invalidate_alloc(device, buffer_rs.get_allocation())?;
        let buffer_rs_bytes = unsafe {
            std::slice::from_raw_parts(
                buffer_rs.get_allocation().get_host_ptr(),
                image_rs_size_in_bytes as usize,
            )
        };
        let buffer_rs_data = ConstPixelBufferAccess::new(tcu_format, size, buffer_rs_bytes);

        let mut buffers_per_sample_data = Vec::new();
        for buffer in &buffers_per_sample {
            invalidate_alloc(device, buffer.get_allocation())?;
            let bytes = unsafe {
                std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr(), image_rs_size_in_bytes as usize)
            };
            buffers_per_sample_data.push(ConstPixelBufferAccess::new(tcu_format, size, bytes));
        }

        Ok(self.verify_image_data(&buffers_per_sample_data, &buffer_rs_data))
    }
}

/// `kValidSquareSampleCounts` without the single sample count (`image_write_sample` skips it).
const VALID_SQUARE_SAMPLE_COUNTS: [u32; 4] = [2, 4, 8, 16];

/// `bitsPerCoord`
fn bits_per_coord(num_samples: u32) -> u32 {
    num_samples / 2
}

/// `imageSize` - square images with 2^(samples/2) pixels on each side.
fn write_sample_image_size(sample_count: u32) -> u32 {
    1 << (sample_count >> 1)
}

/// `WriteSampleTest`
struct WriteSampleCase {
    name: String,
    sample_count: u32,
}

fn write_sample_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::STORAGE | vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::TRANSFER_DST
}

impl WriteSampleCase {
    fn samples(&self) -> vk::SampleCountFlags {
        vk::SampleCountFlags::from_bits_truncate(self.sample_count)
    }
}

impl TestCase for WriteSampleCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // Check multisample storage images support.
        if context.get_device_features().shader_storage_image_multisample == vk::FALSE {
            return Err(TestError::NotSupported(
                "Using multisample images as storage is not supported".to_string(),
            ));
        }

        // Check the specific image format.
        let feature_flags = vk::FormatFeatureFlags::STORAGE_IMAGE
            | vk::FormatFeatureFlags::TRANSFER_SRC
            | vk::FormatFeatureFlags::TRANSFER_DST;
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), IMAGE_FORMAT)
        };
        if !properties.optimal_tiling_features.contains(feature_flags) {
            return Err(TestError::NotSupported(
                "Format does not support the required features".to_string(),
            ));
        }

        // Check the supported sample count.
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                IMAGE_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                write_sample_usage(),
                vk::ImageCreateFlags::empty(),
            )
        };
        let image_properties = result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        if !image_properties.sample_counts.contains(self.samples()) {
            return Err(TestError::NotSupported(
                "Format does not support the required sample count".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let program_set = format!("write_sample_{}", self.sample_count);
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == program_set)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {program_set}"))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(WriteSampleInstance {
            context,
            sample_count: self.sample_count,
        })
    }
}

struct WriteSampleInstance<'a> {
    context: &'a Context<'a>,
    sample_count: u32,
}

impl TestInstance for WriteSampleInstance<'_> {
    /// `WriteSampleTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let samples = vk::SampleCountFlags::from_bits_truncate(self.sample_count);
        let dim = write_sample_image_size(self.sample_count);
        let extent = vk::Extent3D {
            width: dim,
            height: dim,
            depth: 1,
        };
        debug_assert!(
            bits_per_coord(self.sample_count) * 2 == self.sample_count
                && VALID_SQUARE_SAMPLE_COUNTS.contains(&self.sample_count)
        );

        // Create storage image and verification image.
        let storage_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_info(dim, dim, samples, write_sample_usage()),
            MemoryRequirement::ANY,
        )?;
        let verification_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_info(dim, dim, vk::SampleCountFlags::_1, write_sample_usage()),
            MemoryRequirement::ANY,
        )?;

        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let storage_img_view = make_image_view(
            device,
            storage_image.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            subresource_range,
        )?;
        let verification_img_view = make_image_view(
            device,
            verification_image.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            subresource_range,
        )?;

        // Prepare a staging buffer to check verification image.
        let buffer_size = u64::from(dim) * u64::from(dim) * 4;
        let staging_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Descriptor set layout, pool and set.
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .add_single_binding(vk::DescriptorType::STORAGE_IMAGE, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_IMAGE, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        // Update descriptor set using the images.
        let storage_img_descriptor_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *storage_img_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let verification_img_descriptor_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *verification_img_view,
            image_layout: vk::ImageLayout::GENERAL,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&storage_img_descriptor_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_IMAGE)
                .image_info(&verification_img_descriptor_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Create write and verification compute pipelines.
        let binaries = context.get_binary_collection();
        let shader_write_module = create_shader_module(device, binaries.get("write")?)?;
        let shader_verify_module = create_shader_module(device, binaries.get("verify")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let make_compute_pipeline = |module: vk::ShaderModule| -> Result<Unique<'_, vk::Pipeline>, TestError> {
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(module)
                .name(b"main\0")
                .build();
            let info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_handle(vk::Pipeline::null())
                .base_pipeline_index(0);
            let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateComputePipelines")?;
            Ok(Unique::new(device, pipelines.0[0]))
        };
        let write_pipeline = make_compute_pipeline(*shader_write_module)?;
        let verification_pipeline = make_compute_pipeline(*shader_verify_module)?;

        // Transition images to the correct layout and buffers at different stages.
        let storage_img_pre_clear_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::TRANSFER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            storage_image.get(),
            subresource_range,
        );
        let storage_img_pre_shader_barrier = make_image_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            vk::ImageLayout::GENERAL,
            storage_image.get(),
            subresource_range,
        );
        let verification_img_pre_shader_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::SHADER_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::GENERAL,
            verification_image.get(),
            subresource_range,
        );
        let storage_img_pre_verification_barrier = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::SHADER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::GENERAL,
            storage_image.get(),
            subresource_range,
        );
        let verification_img_post_barrier = make_image_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::GENERAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            verification_image.get(),
            subresource_range,
        );
        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            staging_buffer.get(),
            0,
            buffer_size,
        );

        // Command buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Clear color for the storage image.
        let clear_color = vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        };

        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: extent.width,
            buffer_image_height: extent.height,
            image_subresource: vk::ImageSubresourceLayers {
                aspect_mask: vk::ImageAspectFlags::COLOR,
                mip_level: 0,
                base_array_layer: 0,
                layer_count: 1,
            },
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: extent,
        };

        // Record and submit commands.
        begin_command_buffer(device, cmd)?;
        unsafe {
            let no_memory_barriers = &[] as &[vk::MemoryBarrier];
            let no_buffer_barriers = &[] as &[vk::BufferMemoryBarrier];
            let no_image_barriers = &[] as &[vk::ImageMemoryBarrier];

            // Clear storage image.
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                no_memory_barriers,
                no_buffer_barriers,
                &[storage_img_pre_clear_barrier],
            );
            device.cmd_clear_color_image(
                cmd,
                storage_image.get(),
                vk::ImageLayout::TRANSFER_DST_OPTIMAL,
                &clear_color,
                &[subresource_range],
            );

            // Bind write pipeline and descriptor set.
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *write_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );

            // Transition images to the appropriate layout before running the shader.
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                no_memory_barriers,
                no_buffer_barriers,
                &[storage_img_pre_shader_barrier],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                no_memory_barriers,
                no_buffer_barriers,
                &[verification_img_pre_shader_barrier],
            );

            // Run shader.
            device.cmd_dispatch(cmd, extent.width, extent.height, extent.depth);

            // Bind verification pipeline.
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *verification_pipeline);

            // Make sure writes happen before reads in the second dispatch for the storage image.
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::DependencyFlags::empty(),
                no_memory_barriers,
                no_buffer_barriers,
                &[storage_img_pre_verification_barrier],
            );

            // Run verification shader.
            device.cmd_dispatch(cmd, extent.width, extent.height, extent.depth);

            // Change verification image layout to prepare the transfer.
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                no_memory_barriers,
                no_buffer_barriers,
                &[verification_img_post_barrier],
            );

            // Copy verification image to staging buffer.
            device.cmd_copy_image_to_buffer(
                cmd,
                verification_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                staging_buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                no_memory_barriers,
                &[buffer_barrier],
                no_image_barriers,
            );
        }
        end_command_buffer(device, cmd)?;

        // Run shaders.
        submit_commands_and_wait(device, queue, cmd)?;

        // Read buffer pixels.
        let buffer_alloc = staging_buffer.get_allocation();
        invalidate_alloc(device, buffer_alloc)?;
        let bytes = unsafe { std::slice::from_raw_parts(buffer_alloc.get_host_ptr(), buffer_size as usize) };
        let tcu_format = map_vk_format(IMAGE_FORMAT).expect("RGBA8 has a texture format");
        let access = ConstPixelBufferAccess::new(tcu_format, [extent.width, extent.height, extent.depth], bytes);

        // Verify all pixels have the proper color.
        let good_color = [0.0f32, 1.0, 0.0, 1.0];
        for i in 0..extent.width {
            for j in 0..extent.height {
                for k in 0..extent.depth {
                    if access.get_pixel(i, j, k) != good_color {
                        return Ok(TestStatus::fail(format!(
                            "Invalid result at pixel ({i}, {j}, {k}); check error mask for more details"
                        )));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `WriteSampleMaskTestCase`
struct WriteSampleMaskCase {
    name: String,
    sample_count: u32,
}

impl WriteSampleMaskCase {
    fn samples(&self) -> vk::SampleCountFlags {
        vk::SampleCountFlags::from_bits_truncate(self.sample_count)
    }

    /// `WriteSampleMaskTestCase::kUsageFlags`
    fn usage() -> vk::ImageUsageFlags {
        vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::INPUT_ATTACHMENT
    }
}

/// `imageSize` of the `write_sample_mask` tests: special case 2x1 image (not actually square) for one sample.
fn write_sample_mask_image_extent(sample_count: u32) -> vk::Extent3D {
    if sample_count == 1 {
        return vk::Extent3D {
            width: 2,
            height: 1,
            depth: 1,
        };
    }
    let dim = write_sample_image_size(sample_count);
    vk::Extent3D {
        width: dim,
        height: dim,
        depth: 1,
    }
}

impl TestCase for WriteSampleMaskCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // Check if sampleRateShading is supported.
        if context.get_device_features().sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported(
                "Sample rate shading is not supported".to_string(),
            ));
        }

        // Check the specific image format.
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), IMAGE_FORMAT)
        };
        if !properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::COLOR_ATTACHMENT)
        {
            return Err(TestError::NotSupported(
                "Format does not support the required features".to_string(),
            ));
        }

        // Check the supported sample count.
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                IMAGE_FORMAT,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                Self::usage(),
                vk::ImageCreateFlags::empty(),
            )
        };
        let image_properties = result.vk_check("vkGetPhysicalDeviceImageFormatProperties")?;
        if !image_properties.sample_counts.contains(self.samples()) {
            return Err(TestError::NotSupported(
                "Format does not support the required sample count".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let program_set = format!("write_sample_mask_{}", self.sample_count);
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == program_set)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {program_set}"))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(WriteSampleMaskInstance {
            context,
            sample_count: self.sample_count,
        })
    }
}

struct WriteSampleMaskInstance<'a> {
    context: &'a Context<'a>,
    sample_count: u32,
}

impl TestInstance for WriteSampleMaskInstance<'_> {
    /// `WriteSampleMaskTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let sample_count = self.sample_count;
        let samples = vk::SampleCountFlags::from_bits_truncate(sample_count);
        let image_extent = write_sample_mask_image_extent(sample_count);
        let buffer_elems = (image_extent.width * image_extent.height * sample_count) as usize;
        let buffer_size = (buffer_elems * std::mem::size_of::<i32>()) as vk::DeviceSize;

        // Create image.
        let image_create_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(IMAGE_FORMAT)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(samples)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(WriteSampleMaskCase::usage())
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_image = ImageWithMemory::new(device, allocator, image_create_info, MemoryRequirement::ANY)?;
        let auxiliar_image = ImageWithMemory::new(device, allocator, image_create_info, MemoryRequirement::ANY)?; // For the second subpass.

        // Image views.
        let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            subresource_range,
        )?;
        let auxiliar_image_view = make_image_view(
            device,
            auxiliar_image.get(),
            vk::ImageViewType::_2D,
            IMAGE_FORMAT,
            subresource_range,
        )?;

        // Create storage buffer used to verify results.
        let storage_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Full-screen quad.
        let quad_vertices: [f32; 12] = [
            -1.0, 1.0, // Lower left
            1.0, 1.0, // Lower right
            1.0, -1.0, // Top right.
            -1.0, 1.0, // Lower left
            1.0, -1.0, // Top right.
            -1.0, -1.0, // Top left.
        ];
        let vertex_buffer = create_host_buffer(context, &quad_vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        // Descriptor set layout, pool and set.
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        // Render pass.
        let attachments = [
            // Main color attachment.
            vk::AttachmentDescription::builder()
                .format(IMAGE_FORMAT)
                .samples(samples)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL)
                .build(),
            // Auxiliar color attachment for the check pass.
            vk::AttachmentDescription::builder()
                .format(IMAGE_FORMAT)
                .samples(samples)
                .load_op(vk::AttachmentLoadOp::DONT_CARE)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        ];

        let color_attachment_reference = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let color_as_input_attachment = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let auxiliar_attachment_reference = [vk::AttachmentReference {
            attachment: 1,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];

        let subpasses = [
            // First subpass writing to the main attachment.
            vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_attachment_reference)
                .build(),
            // Second subpass writing to the auxiliar attachment.
            vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .input_attachments(&color_as_input_attachment)
                .color_attachments(&auxiliar_attachment_reference)
                .build(),
        ];

        // First subpass writes to the color attachment and second subpass reads it as an input attachment.
        let subpass_dependencies = [vk::SubpassDependency::builder()
            .src_subpass(0)
            .dst_subpass(1)
            .src_stage_mask(vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT)
            .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
            .src_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
            .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
            .dependency_flags(vk::DependencyFlags::empty())
            .build()];

        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .dependencies(&subpass_dependencies);
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        let render_pass = Unique::new(device, render_pass);

        // Framebuffer.
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_image_view, *auxiliar_image_view],
            image_extent.width,
            image_extent.height,
            1,
        )?;

        // Empty pipeline layout for the first subpass, and the pipeline layout for the second subpass.
        let empty_pipeline_layout = make_pipeline_layout(device, &[])?;
        let check_pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        // Shader modules.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let write_module = create_shader_module(device, binaries.get("frag_write")?)?;
        let check_module = create_shader_module(device, binaries.get("frag_check")?)?;

        let make_pipeline = |layout: vk::PipelineLayout,
                             fragment_module: vk::ShaderModule,
                             subpass: u32|
         -> Result<Unique<'_, vk::Pipeline>, TestError> {
            let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
                .with_full_viewport(image_extent.width, image_extent.height);
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: 8,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            state.attributes = vec![vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32_SFLOAT,
                offset: 0,
            }];
            state.rasterization.depth_bias_enable = vk::FALSE;
            state.samples = samples;
            state.subpass = subpass;
            create_draw_pipeline(
                device,
                layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, fragment_module),
                ],
                &state,
            )
        };

        // Pipeline for the first subpass and pipeline for the second subpass.
        let first_subpass_pipeline = make_pipeline(*empty_pipeline_layout, *write_module, 0)?;
        let second_subpass_pipeline = make_pipeline(*check_pipeline_layout, *check_module, 1)?;

        // Command pool and command buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Update descriptor set.
        let image_info = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *color_image_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let buffer_info = [vk::DescriptorBufferInfo {
            buffer: storage_buffer.get(),
            offset: 0,
            range: vk::WHOLE_SIZE,
        }];
        let writes = [
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(0)
                .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                .image_info(&image_info)
                .build(),
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set.get())
                .dst_binding(1)
                .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
                .buffer_info(&buffer_info)
                .build(),
        ];
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        // Output buffer pipeline barrier.
        let buffer_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            storage_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );

        // Run pipelines.
        begin_command_buffer(device, cmd)?;
        {
            let clear_values = [vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            }];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(image_extent.width, image_extent.height))
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *first_subpass_pipeline);
                device.cmd_draw(cmd, 6, 1, 0, 0);

                device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *second_subpass_pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *check_pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );
                device.cmd_draw(cmd, 6, 1, 0, 0);

                device.cmd_end_render_pass(cmd);
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::FRAGMENT_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[buffer_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd)?;

        submit_commands_and_wait(device, queue, cmd)?;

        // Check buffer contents.
        let buffer_alloc = storage_buffer.get_allocation();
        invalidate_alloc(device, buffer_alloc)?;
        let buffer_contents: Vec<i32> = (0..buffer_elems)
            .map(|i| unsafe { std::ptr::read_unaligned(buffer_alloc.get_host_ptr().cast::<i32>().add(i)) })
            .collect();

        let bpc = bits_per_coord(sample_count);

        for x in 0..image_extent.width {
            for y in 0..image_extent.height {
                // Samples on which we expect writes.
                let sample_mask = (x << bpc) | y;

                // Starting location for the pixel sample values in the buffer.
                let pixel_offset = (y * image_extent.width + x) * sample_count;

                for s in 0..sample_count {
                    let sample_index = pixel_offset + s;
                    let value = buffer_contents[sample_index as usize];

                    if value != 0 && value != 1 {
                        // Garbage!
                        return Ok(TestStatus::fail(format!(
                            "Found garbage value {value} in buffer position {sample_index} (x={x}, y={y}, sample={s})"
                        )));
                    }

                    let expected = if (sample_mask & (1u32 << s)) != 0 { 1 } else { 0 };
                    if value != expected {
                        return Ok(TestStatus::fail(format!(
                            "Read {value} while expecting {expected} in buffer position {sample_index} (x={x}, y={y}, sample={s})"
                        )));
                    }
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMultisampleShaderBuiltInTests`
pub fn create_multisample_shader_builtin_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("multisample_shader_builtin");

    let image_sizes: [[u32; 2]; 2] = [[128, 128], [137, 191]];
    let samples_set_full = [
        vk::SampleCountFlags::_2,
        vk::SampleCountFlags::_4,
        vk::SampleCountFlags::_8,
        vk::SampleCountFlags::_16,
        vk::SampleCountFlags::_32,
        vk::SampleCountFlags::_64,
    ];
    let samples_set_reduced = [
        vk::SampleCountFlags::_2,
        vk::SampleCountFlags::_4,
        vk::SampleCountFlags::_8,
        vk::SampleCountFlags::_16,
        vk::SampleCountFlags::_32,
    ];

    /// `makeMSGroup`; the program set is a function of the sample count for the bit count groups.
    fn make_ms_group(
        group_name: &str,
        kind: Kind,
        image_sizes: &[[u32; 2]],
        image_samples: &[vk::SampleCountFlags],
        shading_rate: f32,
        program_set: &dyn Fn(u32) -> String,
    ) -> TestCaseGroup {
        let mut case_group = TestCaseGroup::new(group_name);

        for image_size in image_sizes {
            let mut size_group = TestCaseGroup::new(format!("{}_{}_1", image_size[0], image_size[1]));

            for &samples in image_samples {
                let samples_count = samples_value(samples);
                size_group.add_child(MultisampleBuiltinCase::new(
                    &format!("samples_{samples_count}"),
                    &program_set(samples_count),
                    kind,
                    *image_size,
                    samples,
                    shading_rate,
                ));
            }

            case_group.add_child(size_group);
        }
        case_group
    }

    test_group.add_child(make_ms_group(
        "sample_id",
        Kind::SampleId,
        &image_sizes,
        &samples_set_full,
        1.0,
        &|_| "sample_id".to_string(),
    ));

    let mut sample_position_group = TestCaseGroup::new("sample_position");
    sample_position_group.add_child(make_ms_group(
        "distribution",
        Kind::SamplePosDistribution,
        &image_sizes,
        &samples_set_full,
        1.0,
        &|_| "sample_pos_distribution".to_string(),
    ));
    sample_position_group.add_child(make_ms_group(
        "correctness",
        Kind::SamplePosCorrectness,
        &image_sizes,
        &samples_set_full,
        1.0,
        &|_| "sample_pos_correctness".to_string(),
    ));
    test_group.add_child(sample_position_group);

    let mut sample_mask_group = TestCaseGroup::new("sample_mask");
    sample_mask_group.add_child(make_ms_group(
        "pattern",
        Kind::SampleMaskPattern,
        &image_sizes,
        &samples_set_reduced,
        1.0,
        &|_| "mask_pattern".to_string(),
    ));
    sample_mask_group.add_child(make_ms_group(
        "bit_count",
        Kind::SampleMaskBitCount,
        &image_sizes,
        &samples_set_reduced,
        1.0,
        &|samples| format!("bit_count_{samples}_r1"),
    ));
    sample_mask_group.add_child(make_ms_group(
        "bit_count_0_5",
        Kind::SampleMaskBitCount,
        &image_sizes,
        &samples_set_reduced,
        0.5,
        &|samples| format!("bit_count_{samples}_r05"),
    ));
    sample_mask_group.add_child(make_ms_group(
        "correct_bit",
        Kind::SampleMaskCorrectBit,
        &image_sizes,
        &samples_set_reduced,
        1.0,
        &|_| "mask_correct_bit".to_string(),
    ));
    sample_mask_group.add_child(make_ms_group(
        "write",
        Kind::SampleMaskWrite,
        &image_sizes,
        &samples_set_reduced,
        1.0,
        &|_| "mask_write".to_string(),
    ));
    test_group.add_child(sample_mask_group);

    // Write image sample tests using a storage images (tests construct only compute pipeline).
    {
        // Test OpImageWrite with a sample ID
        let mut image_write_sample_group = TestCaseGroup::new("image_write_sample");

        for count in VALID_SQUARE_SAMPLE_COUNTS {
            image_write_sample_group.add_child(Box::new(WriteSampleCase {
                name: format!("{count}_samples"),
                sample_count: count,
            }) as Box<dyn TestCase>);
        }

        test_group.add_child(image_write_sample_group);
    }

    // Write to gl_SampleMask from the fragment shader.
    {
        let mut write_sample_mask_group = TestCaseGroup::new("write_sample_mask");

        for count in [1u32, 2, 4, 8, 16] {
            write_sample_mask_group.add_child(Box::new(WriteSampleMaskCase {
                name: format!("{count}_samples"),
                sample_count: count,
            }) as Box<dyn TestCase>);
        }

        test_group.add_child(write_sample_mask_group);
    }

    test_group
}
