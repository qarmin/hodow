// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/rasterization/vktRasterizationOrderAttachmentAccessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// VK_EXT_rasterization_order_attachment_access: overlapping draws, primitives and instances read the colour (or depth
// or stencil) value the previous one wrote through an input attachment of the same subpass, and bump a counter in it.
// Either the rasterization order guarantee does the ordering (the `multi_draw`, `multi_primitives`, `multi_instances`
// and `all` cases) or explicit barriers do (`multi_draw_barriers`). A second subpass checks that every pixel counted up
// to the number of overlapping primitives. The shaders are in `shaders/manifest/rasterization_order_attachment_access.toml`,
// found by the key `program_key` builds.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::generated::shaders::rasterization_order_attachment_access::ALL_ORDER_ACCESS_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_memory_barrier,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: the vertex shaders and fragment shaders of both subpasses.
pub struct OrderAccessProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

const ELEM_NUM: u32 = 6;
const WIDTH: u32 = 8;
const HEIGHT: u32 = 8;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    Color,
    Depth,
    Stencil,
}

#[derive(Clone, Copy)]
struct OrderParams {
    kind: Kind,
    explicit_sync: bool,
    overlap_draws: bool,
    overlap_primitives: bool,
    overlap_instances: bool,
    sample_count: u32,
    // The constructor's `inputAttachmentNum`, which counts colour attachments only.
    input_attachment_num: u32,
    integer_format: bool,
}

/// `getSampleNum`'s inverse
fn sample_count_flags(sample_count: u32) -> vk::SampleCountFlags {
    match sample_count {
        1 => vk::SampleCountFlags::_1,
        2 => vk::SampleCountFlags::_2,
        4 => vk::SampleCountFlags::_4,
        8 => vk::SampleCountFlags::_8,
        16 => vk::SampleCountFlags::_16,
        32 => vk::SampleCountFlags::_32,
        64 => vk::SampleCountFlags::_64,
        _ => unreachable!("not a sample count"),
    }
}

impl OrderParams {
    fn sample_flags(&self) -> vk::SampleCountFlags {
        sample_count_flags(self.sample_count)
    }

    /// `getInputAttachmentNum`
    fn total_input_attachment_num(&self) -> u32 {
        if self.kind == Kind::Color {
            self.input_attachment_num
        } else {
            self.input_attachment_num + 1
        }
    }

    /// `getColorAttachmentNum`
    fn color_attachment_num(&self) -> u32 {
        self.input_attachment_num
    }

    /// `hasDepthStencil`
    fn has_depth_stencil(&self) -> bool {
        self.kind != Kind::Color
    }

    /// `getDSAspect`
    fn ds_aspect(&self) -> vk::ImageAspectFlags {
        if self.kind == Kind::Stencil {
            vk::ImageAspectFlags::STENCIL
        } else {
            vk::ImageAspectFlags::DEPTH
        }
    }

    /// `getColorFormat`
    fn color_format(&self) -> vk::Format {
        if self.integer_format {
            vk::Format::R32G32_UINT
        } else {
            vk::Format::R32G32_SFLOAT
        }
    }

    /// `getBlendStateFlags`
    fn blend_state_flags(&self) -> vk::PipelineColorBlendStateCreateFlags {
        if self.explicit_sync {
            vk::PipelineColorBlendStateCreateFlags::empty()
        } else {
            vk::PipelineColorBlendStateCreateFlags::RASTERIZATION_ORDER_ATTACHMENT_ACCESS_EXT
        }
    }

    /// `getDSStateFlags`
    fn ds_state_flags(&self) -> vk::PipelineDepthStencilStateCreateFlags {
        match (self.explicit_sync, self.kind) {
            (false, Kind::Depth) => {
                vk::PipelineDepthStencilStateCreateFlags::RASTERIZATION_ORDER_ATTACHMENT_DEPTH_ACCESS_EXT
            }
            (false, Kind::Stencil) => {
                vk::PipelineDepthStencilStateCreateFlags::RASTERIZATION_ORDER_ATTACHMENT_STENCIL_ACCESS_EXT
            }
            _ => vk::PipelineDepthStencilStateCreateFlags::empty(),
        }
    }

    /// The manifest's case name for the shaders of these parameters.
    fn program_key(&self) -> String {
        let kind = match self.kind {
            Kind::Color => "color",
            Kind::Depth => "depth",
            Kind::Stencil => "stencil",
        };
        let format = if self.integer_format { "int" } else { "float" };
        let overlap = match (self.overlap_draws, self.overlap_primitives, self.overlap_instances) {
            (true, true, true) => "dpi",
            (_, true, _) => "p",
            (_, _, true) => "i",
            _ => "d",
        };
        format!(
            "{kind}_{format}_att{}_s{}_{overlap}",
            self.input_attachment_num, self.sample_count
        )
    }

    fn colour_image_usage() -> vk::ImageUsageFlags {
        vk::ImageUsageFlags::INPUT_ATTACHMENT
            | vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
    }

    fn ds_image_usage() -> vk::ImageUsageFlags {
        vk::ImageUsageFlags::INPUT_ATTACHMENT
            | vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST
    }
}

/// `checkAndGetDSFormat` - the first of the two formats that supports the sample count, or UNDEFINED.
fn check_and_get_ds_format(context: &Context<'_>, params: &OrderParams) -> Result<vk::Format, TestError> {
    for ds_format in [vk::Format::D32_SFLOAT_S8_UINT, vk::Format::D24_UNORM_S8_UINT] {
        let result = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                ds_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                OrderParams::ds_image_usage(),
                vk::ImageCreateFlags::empty(),
            )
        };

        match result {
            Ok(format_properties) => {
                if format_properties.sample_counts.contains(params.sample_flags()) {
                    return Ok(ds_format);
                }
            }
            Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {}
            Err(_) => {
                return Err(TestError::Fail(
                    "vkGetPhysicalDeviceImageFormatProperties returned unexpected error".to_string(),
                ));
            }
        }
    }
    Ok(vk::Format::UNDEFINED)
}

struct OrderAccessTestCase {
    name: &'static str,
    params: OrderParams,
}

impl TestCase for OrderAccessTestCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `AttachmentAccessOrderTestCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;

        // When explicit synchronization is used, there's no need for the extension.
        if !params.explicit_sync
            && !context.is_device_functionality_supported("VK_ARM_rasterization_order_attachment_access")
            && !context.is_device_functionality_supported("VK_EXT_rasterization_order_attachment_access")
        {
            return Err(TestError::NotSupported("Neither VK_ARM_rasterization_order_attachment_access nor VK_EXT_rasterization_order_attachment_access is supported".to_string()));
        }

        let instance = context.get_instance();
        let physical_device = context.get_physical_device();

        let mut rasterization_access = vk::PhysicalDeviceRasterizationOrderAttachmentAccessFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder();
        if !params.explicit_sync {
            features2 = features2.push_next(&mut rasterization_access);
        }
        unsafe { instance.get_physical_device_features2(physical_device, &mut features2) };
        let sample_rate_shading = features2.features.sample_rate_shading;

        let limits = &context.get_device_properties().limits;
        let sample_flags = params.sample_flags();

        if params.integer_format {
            let format = params.color_format();
            let result = unsafe {
                instance.get_physical_device_image_format_properties(
                    physical_device,
                    format,
                    vk::ImageType::_2D,
                    vk::ImageTiling::OPTIMAL,
                    OrderParams::colour_image_usage(),
                    vk::ImageCreateFlags::empty(),
                )
            };
            let format_properties = match result {
                Ok(format_properties) => format_properties,
                Err(error) if error == vk::ErrorCode::FORMAT_NOT_SUPPORTED => {
                    return Err(TestError::NotSupported(format!(
                        "format {format:?} does not support the required features"
                    )));
                }
                Err(_) => {
                    return Err(TestError::Fail(
                        "vkGetPhysicalDeviceImageFormatProperties returned unexpected error".to_string(),
                    ));
                }
            };

            if !format_properties.sample_counts.contains(sample_flags)
                || !limits.sampled_image_integer_sample_counts.contains(sample_flags)
            {
                return Err(TestError::NotSupported("Sample count not supported".to_string()));
            }
        } else if !limits.framebuffer_color_sample_counts.contains(sample_flags)
            || !limits.sampled_image_color_sample_counts.contains(sample_flags)
        {
            return Err(TestError::NotSupported("Sample count not supported".to_string()));
        }

        // Check depth/stencil format support if needed.
        if params.total_input_attachment_num() > params.color_attachment_num()
            && check_and_get_ds_format(context, params)? == vk::Format::UNDEFINED
        {
            return Err(TestError::NotSupported(
                "No support for any of the required depth/stencil formats".to_string(),
            ));
        }

        // sampleRateShading must be enabled to call fragment shader for all the samples in multisampling
        if sample_flags != vk::SampleCountFlags::_1 && sample_rate_shading == vk::FALSE {
            return Err(TestError::NotSupported(
                "sampleRateShading feature not supported".to_string(),
            ));
        }

        if limits.max_fragment_output_attachments < params.input_attachment_num
            || limits.max_per_stage_descriptor_input_attachments < params.input_attachment_num
        {
            return Err(TestError::NotSupported(
                "Feedback attachment number not supported".to_string(),
            ));
        }

        if !params.explicit_sync {
            if rasterization_access.rasterization_order_color_attachment_access == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Implicit attachment access rasterization order not guaranteed for color attachments".to_string(),
                ));
            }

            // `checkAdditionalRasterizationFlags`
            if params.kind == Kind::Depth
                && rasterization_access.rasterization_order_depth_attachment_access == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "Implicit attachment access rasterization order not guaranteed for depth attachments".to_string(),
                ));
            }
            if params.kind == Kind::Stencil
                && rasterization_access.rasterization_order_stencil_attachment_access == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "Implicit attachment access rasterization order not guaranteed for stencil attachments".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let key = self.params.program_key();
        ALL_ORDER_ACCESS_PROGRAM
            .iter()
            .find(|program| program.name == key)
            .unwrap_or_else(|| {
                panic!("shaders/manifest/rasterization_order_attachment_access.toml has no case named {key}")
            })
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OrderAccessInstance {
            context,
            params: self.params,
        })
    }
}

/// The images and views of one subpass's input attachments, and the attachment references to them.
struct SubpassAttachments<'a> {
    images: Vec<ImageWithMemory<'a>>,
    // Held for the lifetime of the images' use.
    _views: Vec<Unique<'a, vk::ImageView>>,
    references: Vec<vk::AttachmentReference>,
    color_attachment_num: u32,
}

impl SubpassAttachments<'_> {
    fn input_attachment_num(&self) -> u32 {
        self.images.len() as u32
    }
}

struct OrderAccessInstance<'a> {
    context: &'a Context<'a>,
    params: OrderParams,
}

impl<'a> OrderAccessInstance<'a> {
    /// `RenderSubpass::createAttachments` - the images and views; the pipeline layout and pipeline are made by the caller.
    fn create_attachments(
        &self,
        input_attachment_num: u32,
        color_attachment_num: u32,
        sample_count: vk::SampleCountFlags,
        ds_format: vk::Format,
        views: &mut Vec<vk::ImageView>,
    ) -> Result<SubpassAttachments<'a>, TestError> {
        let context: &'a Context<'a> = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let mut attachments = SubpassAttachments {
            images: Vec::new(),
            _views: Vec::new(),
            references: Vec::new(),
            color_attachment_num,
        };

        for i in 0..input_attachment_num {
            let (format, usage, aspect) = if i >= color_attachment_num {
                // Image for the DS attachment
                debug_assert!(ds_format != vk::Format::UNDEFINED);
                (ds_format, OrderParams::ds_image_usage(), self.params.ds_aspect())
            } else {
                (
                    self.params.color_format(),
                    OrderParams::colour_image_usage(),
                    vk::ImageAspectFlags::COLOR,
                )
            };

            let image_info = vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: WIDTH,
                    height: HEIGHT,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(sample_count)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build();
            let image = ImageWithMemory::new(device, allocator, image_info, MemoryRequirement::ANY)?;
            let view = make_image_view(
                device,
                image.get(),
                vk::ImageViewType::_2D,
                format,
                make_image_subresource_range(aspect, 0, 1, 0, 1),
            )?;

            attachments.references.push(vk::AttachmentReference {
                attachment: views.len() as u32,
                layout: vk::ImageLayout::GENERAL,
            });
            views.push(*view);
            attachments.images.push(image);
            attachments._views.push(view);
        }
        Ok(attachments)
    }

    /// `createRenderPass`
    fn create_render_pass(
        &self,
        color_format: vk::Format,
        ds_format: vk::Format,
        subpasses: &[SubpassAttachments<'_>; 2],
    ) -> Result<Unique<'a, vk::RenderPass>, TestError> {
        let context: &'a Context<'a> = self.context;
        let device = context.get_device();
        let params = &self.params;

        let sample_counts = [params.sample_flags(), vk::SampleCountFlags::_1];
        let mut attachment_descs = Vec::new();
        for (subpass, samples) in subpasses.iter().zip(sample_counts) {
            for i in 0..subpass.input_attachment_num() {
                let format = if i >= subpass.color_attachment_num {
                    ds_format
                } else {
                    color_format
                };
                attachment_descs.push(
                    vk::AttachmentDescription::builder()
                        .format(format)
                        .samples(samples)
                        .load_op(vk::AttachmentLoadOp::LOAD)
                        .store_op(vk::AttachmentStoreOp::STORE)
                        .stencil_load_op(vk::AttachmentLoadOp::LOAD)
                        .stencil_store_op(vk::AttachmentStoreOp::STORE)
                        .initial_layout(vk::ImageLayout::GENERAL)
                        .final_layout(vk::ImageLayout::GENERAL)
                        .build(),
                );
            }
        }

        let subpass0 = &subpasses[0];
        let subpass1 = &subpasses[1];
        let color0 = subpass0.color_attachment_num as usize;
        let depth_stencil_reference = subpass0.references.get(color0).copied();

        let mut subpass0_flags = vk::SubpassDescriptionFlags::empty();
        let mut subpass1_flags = vk::SubpassDescriptionFlags::empty();
        // self dependency for subpass 0 and dependency from subpass 0 to 1
        let add_dependency = |dependencies: &mut Vec<vk::SubpassDependency>,
                              source: u32,
                              destination: u32,
                              stage_flags: vk::PipelineStageFlags,
                              access_flags: vk::AccessFlags| {
            dependencies.push(
                vk::SubpassDependency::builder()
                    .src_subpass(source)
                    .dst_subpass(destination)
                    .src_stage_mask(stage_flags)
                    .dst_stage_mask(vk::PipelineStageFlags::FRAGMENT_SHADER)
                    .src_access_mask(access_flags)
                    .dst_access_mask(vk::AccessFlags::INPUT_ATTACHMENT_READ)
                    .dependency_flags(vk::DependencyFlags::BY_REGION)
                    .build(),
            );
        };
        let mut dependencies = Vec::new();
        add_dependency(
            &mut dependencies,
            0,
            1,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        );
        if params.explicit_sync {
            add_dependency(
                &mut dependencies,
                0,
                0,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            );
            if params.has_depth_stencil() {
                let frag_tests =
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
                add_dependency(
                    &mut dependencies,
                    0,
                    0,
                    frag_tests,
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                );
            }
        } else {
            subpass0_flags = vk::SubpassDescriptionFlags::RASTERIZATION_ORDER_ATTACHMENT_COLOR_ACCESS_EXT;
            subpass1_flags = vk::SubpassDescriptionFlags::RASTERIZATION_ORDER_ATTACHMENT_COLOR_ACCESS_EXT;
            match params.kind {
                Kind::Depth => {
                    subpass0_flags |= vk::SubpassDescriptionFlags::RASTERIZATION_ORDER_ATTACHMENT_DEPTH_ACCESS_EXT;
                    subpass1_flags |= vk::SubpassDescriptionFlags::RASTERIZATION_ORDER_ATTACHMENT_DEPTH_ACCESS_EXT;
                }
                Kind::Stencil => {
                    subpass0_flags |= vk::SubpassDescriptionFlags::RASTERIZATION_ORDER_ATTACHMENT_STENCIL_ACCESS_EXT;
                    subpass1_flags |= vk::SubpassDescriptionFlags::RASTERIZATION_ORDER_ATTACHMENT_STENCIL_ACCESS_EXT;
                }
                Kind::Color => {}
            }
        }

        let mut subpass0_description = vk::SubpassDescription::builder()
            .flags(subpass0_flags)
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .input_attachments(&subpass0.references)
            .color_attachments(&subpass0.references[..color0]);
        if let Some(reference) = &depth_stencil_reference {
            subpass0_description = subpass0_description.depth_stencil_attachment(reference);
        }
        // The second subpass reads the first one's colour attachments.
        let subpass_descriptions = [
            subpass0_description.build(),
            vk::SubpassDescription::builder()
                .flags(subpass1_flags)
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .input_attachments(&subpass0.references[..color0])
                .color_attachments(&subpass1.references)
                .build(),
        ];

        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachment_descs)
            .subpasses(&subpass_descriptions)
            .dependencies(&dependencies);
        let render_pass =
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?;
        Ok(Unique::new(device, render_pass))
    }

    /// `RenderSubpass::createPipeline`
    #[allow(clippy::too_many_arguments)]
    fn create_pipeline(
        &self,
        render_pass: vk::RenderPass,
        pipeline_layout: vk::PipelineLayout,
        subpass: u32,
        color_att_num: u32,
        sample_count: vk::SampleCountFlags,
        vert: vk::ShaderModule,
        frag: vk::ShaderModule,
    ) -> Result<Unique<'a, vk::Pipeline>, TestError> {
        let context: &'a Context<'a> = self.context;
        let device = context.get_device();

        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 2]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
            .primitive_restart_enable(false);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: WIDTH as f32,
            height: HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(sample_count)
            .sample_shading_enable(true)
            .min_sample_shading(1.0);
        let color_blend_attachments = vec![
            vk::PipelineColorBlendAttachmentState::builder()
                .blend_enable(false)
                .src_color_blend_factor(vk::BlendFactor::ONE)
                .dst_color_blend_factor(vk::BlendFactor::ONE)
                .color_blend_op(vk::BlendOp::ADD)
                .src_alpha_blend_factor(vk::BlendFactor::ONE)
                .dst_alpha_blend_factor(vk::BlendFactor::ONE)
                .alpha_blend_op(vk::BlendOp::ADD)
                .color_write_mask(vk::ColorComponentFlags::R | vk::ColorComponentFlags::G)
                .build();
            color_att_num as usize
        ];
        // always needed
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .flags(self.params.blend_state_flags())
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::COPY)
            .attachments(&color_blend_attachments);
        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::ZERO)
            .pass_op(vk::StencilOp::INCREMENT_AND_WRAP)
            .depth_fail_op(vk::StencilOp::INCREMENT_AND_WRAP)
            .compare_op(vk::CompareOp::ALWAYS)
            .compare_mask(0xff)
            .write_mask(0xff)
            .reference(0)
            .build();
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .flags(self.params.ds_state_flags())
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::ALWAYS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(true)
            .front(stencil_op_state)
            .back(stencil_op_state)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(vert)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(frag)
                .name(b"main\0")
                .build(),
        ];
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(subpass)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `createVertexBuffer`
    fn create_vertex_buffer(&self) -> Result<BufferWithMemory<'a>, TestError> {
        let context: &'a Context<'a> = self.context;
        let primitive_num = if self.params.overlap_primitives {
            ELEM_NUM * 2
        } else {
            2
        };
        let mut vbo = vec![[0.0f32; 2]; 3 * primitive_num as usize];
        for i in 0..(primitive_num / 2) as usize {
            vbo[i * 6] = [-1.0, -1.0];
            vbo[i * 6 + 1] = [1.0, -1.0];
            vbo[i * 6 + 2] = [-1.0, 1.0];
            vbo[i * 6 + 3] = [1.0, 1.0];
            vbo[i * 6 + 4] = [-1.0, 1.0];
            vbo[i * 6 + 5] = [1.0, -1.0];
        }

        let data_size = std::mem::size_of_val(vbo.as_slice()) as vk::DeviceSize;
        let buffer = BufferWithMemory::new(
            context.get_device(),
            context.get_default_allocator(),
            make_buffer_create_info(data_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Load vertices into vertex buffer
        unsafe {
            std::ptr::copy_nonoverlapping(
                vbo.as_ptr() as *const u8,
                buffer.get_allocation().get_host_ptr(),
                data_size as usize,
            )
        };
        flush_alloc(context.get_device(), buffer.get_allocation())?;
        Ok(buffer)
    }

    /// `addPipelineBarrier`
    #[allow(clippy::too_many_arguments)]
    fn add_pipeline_barrier(
        &self,
        cmd_buffer: vk::CommandBuffer,
        image: vk::Image,
        old_layout: vk::ImageLayout,
        new_layout: vk::ImageLayout,
        src_access_mask: vk::AccessFlags,
        dst_access_mask: vk::AccessFlags,
        src_stage_mask: vk::PipelineStageFlags,
        dst_stage_mask: vk::PipelineStageFlags,
        aspect: vk::ImageAspectFlags,
    ) {
        let barrier = make_image_memory_barrier(
            src_access_mask,
            dst_access_mask,
            old_layout,
            new_layout,
            image,
            make_image_subresource_range(aspect, 0, 1, 0, 1),
        );
        unsafe {
            self.context.get_device().cmd_pipeline_barrier(
                cmd_buffer,
                src_stage_mask,
                dst_stage_mask,
                vk::DependencyFlags::BY_REGION,
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[barrier],
            );
        }
    }
}

impl TestInstance for OrderAccessInstance<'_> {
    /// The constructor of `AttachmentAccessOrderTestInstance` followed by `iterate`.
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let color_format = params.color_format();
        let ds_format = if params.has_depth_stencil() {
            check_and_get_ds_format(context, &params)?
        } else {
            vk::Format::UNDEFINED
        };
        let total_input_attachment_num = params.total_input_attachment_num();

        // Descriptors: one input attachment binding per attachment of the first subpass.
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in 0..total_input_attachment_num {
            layout_builder =
                layout_builder.add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT);
        }
        let descriptor_set_layout = layout_builder.build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, total_input_attachment_num)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let mut attachment_handles = Vec::new();
        let subpass0 = self.create_attachments(
            total_input_attachment_num,
            params.color_attachment_num(),
            params.sample_flags(),
            ds_format,
            &mut attachment_handles,
        )?;
        let subpass1 = self.create_attachments(1, 1, vk::SampleCountFlags::_1, ds_format, &mut attachment_handles)?;

        // `writeDescriptorSets`
        let image_infos: Vec<vk::DescriptorImageInfo> = subpass0
            .references
            .iter()
            .map(|reference| vk::DescriptorImageInfo {
                sampler: vk::Sampler::null(),
                image_view: attachment_handles[reference.attachment as usize],
                image_layout: vk::ImageLayout::GENERAL,
            })
            .collect();
        let writes: Vec<vk::WriteDescriptorSet> = image_infos
            .iter()
            .enumerate()
            .map(|(binding, info)| {
                vk::WriteDescriptorSet::builder()
                    .dst_set(*descriptor_set)
                    .dst_binding(binding as u32)
                    .dst_array_element(0)
                    .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
                    .image_info(std::slice::from_ref(info))
                    .build()
            })
            .collect();
        unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

        let subpasses = [subpass0, subpass1];
        let render_pass = self.create_render_pass(color_format, ds_format, &subpasses)?;
        let framebuffer = make_framebuffer(device, *render_pass, &attachment_handles, WIDTH, HEIGHT, 1)?;

        // Pipeline layouts: only the first subpass takes the draw index as a push constant.
        let set_layouts = [*descriptor_set_layout];
        let mut push_constant_stages = vk::ShaderStageFlags::FRAGMENT;
        if params.has_depth_stencil() {
            push_constant_stages |= vk::ShaderStageFlags::VERTEX;
        }
        let push_constant_ranges = [vk::PushConstantRange {
            stage_flags: push_constant_stages,
            offset: 0,
            size: 4,
        }];
        let pipeline_layout0 = {
            let info = vk::PipelineLayoutCreateInfo::builder()
                .set_layouts(&set_layouts)
                .push_constant_ranges(&push_constant_ranges);
            Unique::new(
                device,
                unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?,
            )
        };
        let pipeline_layout1 = {
            let info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
            Unique::new(
                device,
                unsafe { device.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?,
            )
        };

        let binaries = context.get_binary_collection();
        let vert1 = create_shader_module(device, binaries.get("vert1")?)?;
        let frag = create_shader_module(device, binaries.get("frag")?)?;
        let vert2 = create_shader_module(device, binaries.get("vert2")?)?;
        let frag_resolve = create_shader_module(device, binaries.get("frag_resolve")?)?;
        let pipeline0 = self.create_pipeline(
            *render_pass,
            *pipeline_layout0,
            0,
            subpasses[0].color_attachment_num,
            params.sample_flags(),
            *vert1,
            *frag,
        )?;
        let pipeline1 = self.create_pipeline(
            *render_pass,
            *pipeline_layout1,
            1,
            subpasses[1].color_attachment_num,
            vk::SampleCountFlags::_1,
            *vert2,
            *frag_resolve,
        )?;

        let vertex_buffer = self.create_vertex_buffer()?;

        // The result buffer
        let result_buffer_size = (WIDTH * HEIGHT) as vk::DeviceSize * std::mem::size_of::<[u32; 2]>() as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(result_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        begin_command_buffer(device, cmd)?;

        for subpass in &subpasses {
            for j in 0..subpass.color_attachment_num as usize {
                self.add_pipeline_barrier(
                    cmd,
                    subpass.images[j].get(),
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::ImageAspectFlags::COLOR,
                );

                // `addClearColor`
                let clear_color = vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                };
                unsafe {
                    device.cmd_clear_color_image(
                        cmd,
                        subpass.images[j].get(),
                        vk::ImageLayout::GENERAL,
                        &clear_color,
                        &[make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1)],
                    )
                };
            }
            for j in subpass.color_attachment_num as usize..subpass.images.len() {
                let ds_aspects = vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL;
                self.add_pipeline_barrier(
                    cmd,
                    subpass.images[j].get(),
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::GENERAL,
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::TRANSFER_WRITE,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    ds_aspects,
                );

                // `addClearDepthStencil`
                let clear_value = vk::ClearDepthStencilValue { depth: 0.0, stencil: 0 };
                unsafe {
                    device.cmd_clear_depth_stencil_image(
                        cmd,
                        subpass.images[j].get(),
                        vk::ImageLayout::GENERAL,
                        &clear_value,
                        &[make_image_subresource_range(ds_aspects, 0, 1, 0, 1)],
                    )
                };
            }
        }

        let color_only_access_mask = vk::AccessFlags::INPUT_ATTACHMENT_READ
            | vk::AccessFlags::COLOR_ATTACHMENT_READ
            | vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
        let depth_stencil_color_access_mask = color_only_access_mask
            | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_READ
            | vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE;
        let dst_access_mask = if params.has_depth_stencil() {
            depth_stencil_color_access_mask
        } else {
            color_only_access_mask
        };
        let mem_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, dst_access_mask);

        let color_only_stage_flags =
            vk::PipelineStageFlags::FRAGMENT_SHADER | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;
        let depth_stencil_color_stage_flags = color_only_stage_flags
            | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
            | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
        let dst_stage_flags = if params.has_depth_stencil() {
            depth_stencil_color_stage_flags
        } else {
            color_only_stage_flags
        };
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                dst_stage_flags,
                vk::DependencyFlags::empty(),
                &[mem_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        };
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(render_area);
        unsafe {
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline0);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout0,
                0,
                &[*descriptor_set],
                &[],
            );
        }

        let num_draws = if params.overlap_draws { ELEM_NUM } else { 1 };
        let num_primitives = if params.overlap_primitives { 2 * ELEM_NUM } else { 2 };
        let num_instances = if params.overlap_instances { ELEM_NUM } else { 1 };

        for i in 0..num_draws {
            unsafe { device.cmd_push_constants(cmd, *pipeline_layout0, push_constant_stages, 0, &i.to_ne_bytes()) };
            if params.explicit_sync && i != 0 {
                for j in 0..subpasses[0].color_attachment_num as usize {
                    self.add_pipeline_barrier(
                        cmd,
                        subpasses[0].images[j].get(),
                        vk::ImageLayout::GENERAL,
                        vk::ImageLayout::GENERAL,
                        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                        vk::AccessFlags::INPUT_ATTACHMENT_READ,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::ImageAspectFlags::COLOR,
                    );
                }
                for j in subpasses[0].color_attachment_num as usize..subpasses[0].images.len() {
                    let frag_tests =
                        vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
                    self.add_pipeline_barrier(
                        cmd,
                        subpasses[0].images[j].get(),
                        vk::ImageLayout::GENERAL,
                        vk::ImageLayout::GENERAL,
                        vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                        vk::AccessFlags::INPUT_ATTACHMENT_READ,
                        frag_tests,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
                    );
                }
            }
            unsafe { device.cmd_draw(cmd, num_primitives * 3, num_instances, 0, 0) };
        }

        unsafe {
            device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline1);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout1,
                0,
                &[*descriptor_set],
                &[],
            );
            device.cmd_draw(cmd, 6, 1, 0, 0);
            device.cmd_end_render_pass(cmd);
        }

        // `copyImageToBuffer` of the second subpass's image, which the render pass leaves in GENERAL.
        {
            let result_image = subpasses[1].images[0].get();
            let pre_copy_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                result_image,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            let copy_region = make_buffer_image_copy(
                vk::Extent3D {
                    width: WIDTH,
                    height: HEIGHT,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            let post_copy_barrier = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                result_buffer.get(),
                0,
                vk::WHOLE_SIZE,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_copy_barrier],
                );
                device.cmd_copy_image_to_buffer(
                    cmd,
                    result_image,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    result_buffer.get(),
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[post_copy_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        // `validateResults`
        invalidate_alloc(device, result_buffer.get_allocation())?;
        let expected = num_draws * num_primitives / 2 * num_instances;
        let texels = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr() as *const [u32; 2],
                (WIDTH * HEIGHT) as usize,
            )
        };
        let all_ok = if params.integer_format {
            texels.iter().all(|pixel| pixel[0] == 0 && pixel[1] == expected)
        } else {
            texels
                .iter()
                .all(|pixel| f32::from_bits(pixel[0]) == 0.0 && f32::from_bits(pixel[1]) == expected as f32)
        };

        Ok(if all_ok {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `createRasterizationOrderAttachmentAccessTestVariations`
fn create_variations(group: &mut TestCaseGroup, prefix_name: &str, input_num: u32, integer_format: bool, kind: Kind) {
    // (name, explicit_sync, overlap_draws, overlap_primitives, overlap_instances)
    let leaf_test_create_params: [(&'static str, bool, bool, bool, bool); 5] = [
        // Basic test with overlapping draw commands with barriers
        ("multi_draw_barriers", true, true, false, false),
        // Test with overlapping draw commands without barriers
        ("multi_draw", false, true, false, false),
        // Test with a draw command with overlapping primitives
        ("multi_primitives", false, false, true, false),
        // Test with a draw command with overlapping instances
        ("multi_instances", false, false, false, true),
        // Test with overlapping draw commands, each with overlapping primitives and instances
        ("all", false, true, true, true),
    ];
    let sample_count_values = [1u32, 2, 4, 8, 16, 32, 64];

    for sample_count in sample_count_values {
        let mut subgroup = TestCaseGroup::new(format!("{prefix_name}samples_{sample_count}"));

        for (name, explicit_sync, overlap_draws, overlap_primitives, overlap_instances) in leaf_test_create_params {
            let params = OrderParams {
                kind,
                explicit_sync,
                overlap_draws,
                overlap_primitives,
                overlap_instances,
                sample_count,
                input_attachment_num: input_num,
                integer_format: match kind {
                    Kind::Color => integer_format,
                    Kind::Depth => false,
                    Kind::Stencil => true,
                },
            };
            subgroup.add_child(Box::new(OrderAccessTestCase { name, params }) as Box<dyn TestCase>);
        }
        group.add_child(subgroup);
    }
}

/// `createRasterizationOrderAttachmentAccessFormatTests`
fn create_format_tests(group: &mut TestCaseGroup, integer_format: bool) {
    let input_num = [1u32, 4, 8];
    let mut format_group = TestCaseGroup::new(if integer_format {
        "format_integer"
    } else {
        "format_float"
    });

    for num in input_num {
        create_variations(
            &mut format_group,
            &format!("attachments_{num}_"),
            num,
            integer_format,
            Kind::Color,
        );
    }
    group.add_child(format_group);
}

/// `createRasterizationOrderAttachmentAccessTests`
pub fn create_order_attachment_access_tests() -> TestCaseGroup {
    // Rasterization Order Attachment access tests
    let mut group = TestCaseGroup::new("rasterization_order_attachment_access");
    create_format_tests(&mut group, false);
    create_format_tests(&mut group, true);

    // Add the D/S tests
    let mut depth_group = TestCaseGroup::new("depth");
    let mut stencil_group = TestCaseGroup::new("stencil");
    create_variations(&mut depth_group, "", 1, false, Kind::Depth);
    create_variations(&mut stencil_group, "", 1, false, Kind::Stencil);
    group.add_child(depth_group);
    group.add_child(stencil_group);

    group
}
