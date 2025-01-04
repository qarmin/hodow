// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/rasterization/vktRasterizationDepthBiasControlTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// VK_EXT_depth_bias_control: a 1x1 framebuffer is covered by a triangle strip whose depth is either a slope (so the
// slope factor applies with M = 1) or a constant, and the depth bias that lands in the depth attachment is compared
// with the bias the test aimed for, within the minimum resolvable difference the spec derives for the format and the
// representation. The shaders are in `shaders/manifest/rasterization_depth_bias_control.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDepthBiasControlExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::rasterization_depth_bias_control::DEPTH_BIAS_CONTROL;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_secondary_command_buffer, end_command_buffer, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its one case with this: just the shader pair.
pub struct DepthBiasControlProgram {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

const OUT_COLOR: [u8; 4] = [0, 0, 255, 255];
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const FLOAT32_MANTISSA_BITS: i32 = 23;

fn depth_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC
}

fn color_usage() -> vk::ImageUsageFlags {
    vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC
}

fn image_create_info(format: vk::Format, usage: vk::ImageUsageFlags) -> vk::ImageCreateInfo {
    vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(usage)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build()
}

/// The channel class of the depth aspect, which is all the spec's formulas look at.
#[derive(Clone, Copy)]
enum DepthKind {
    UnsignedFixedPoint { bits: i32 },
    FloatingPoint,
}

fn depth_kind(format: vk::Format) -> DepthKind {
    match format {
        vk::Format::D16_UNORM | vk::Format::D16_UNORM_S8_UINT => DepthKind::UnsignedFixedPoint { bits: 16 },
        vk::Format::X8_D24_UNORM_PACK32 | vk::Format::D24_UNORM_S8_UINT => DepthKind::UnsignedFixedPoint { bits: 24 },
        _ => DepthKind::FloatingPoint,
    }
}

fn format_simple_name(format: vk::Format) -> &'static str {
    match format {
        vk::Format::D16_UNORM => "d16_unorm",
        vk::Format::X8_D24_UNORM_PACK32 => "x8_d24_unorm_pack32",
        vk::Format::D32_SFLOAT => "d32_sfloat",
        vk::Format::D16_UNORM_S8_UINT => "d16_unorm_s8_uint",
        vk::Format::D24_UNORM_S8_UINT => "d24_unorm_s8_uint",
        _ => "d32_sfloat_s8_uint",
    }
}

/// `calcPowerOf2`
fn calc_power_of_2(exponent: i32) -> f64 {
    2.0f64.powi(exponent)
}

/// `tcu::Float32::exponent`
fn float32_exponent(value: f32) -> i32 {
    let bits = value.to_bits();
    let exponent_bits = ((bits >> FLOAT32_MANTISSA_BITS) & 0xff) as i32;
    if exponent_bits == 0 {
        1 - 127
    } else {
        exponent_bits - 127
    }
}

/// `calcMinResolvableDiff` - the minimum and maximum values R can have according to the spec.
fn calc_min_resolvable_diff(
    kind: DepthKind,
    repr: vk::DepthBiasRepresentationEXT,
    exact: bool,
    sample_depth: f32,
) -> (f64, f64) {
    if repr == vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORMAT {
        match kind {
            DepthKind::UnsignedFixedPoint { bits } => {
                // Up to r = 2x2^(-n) where n is bit width.
                let min_r = calc_power_of_2(-bits);
                (min_r, if exact { 1.0 } else { 2.0 } * min_r)
            }
            DepthKind::FloatingPoint => {
                // r = 2^(e-n): e is max exponent in z values, n is mantissa bits.
                let min_r = calc_power_of_2(float32_exponent(sample_depth) - FLOAT32_MANTISSA_BITS);
                (min_r, min_r)
            }
        }
    } else if repr == vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORCE_UNORM {
        // Up to r = 2x2^(-n), where n is the bit width for fixed-point formats or the number of mantissa bits plus
        // one for floating-point formats.
        let n = match kind {
            DepthKind::UnsignedFixedPoint { bits } => bits,
            DepthKind::FloatingPoint => FLOAT32_MANTISSA_BITS + 1,
        };
        let min_r = calc_power_of_2(-n);
        (min_r, if exact { 1.0 } else { 2.0 } * min_r)
    } else {
        // vk::DepthBiasRepresentationEXT::FLOAT: r is always 1.
        (1.0, 1.0)
    }
}

/// `getDepthErrorThreshold` - the minimum resolvable difference of the format, with exact precision.
fn get_depth_error_threshold(kind: DepthKind, sample_depth: f32) -> f64 {
    calc_min_resolvable_diff(
        kind,
        vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORMAT,
        true,
        sample_depth,
    )
    .0
}

/// Which depth bias factor will be used in the tests: focus on depthBiasSlopeFactor or depthBiasConstantFactor.
#[derive(Clone, Copy, PartialEq, Eq)]
enum UsedFactor {
    Slope,
    Constant,
}

/// How are we going to set the depth bias parameters: statically or dynamically.
#[derive(Clone, Copy, PartialEq, Eq)]
enum SetMechanism {
    Static,
    /// vkCmdSetDepthBias
    Dynamic1,
    /// vkCmdSetDepthBias2
    Dynamic2,
}

#[derive(Clone, Copy, PartialEq, Eq)]
struct ReprInfo {
    representation: vk::DepthBiasRepresentationEXT,
    exact: bool,
}

impl ReprInfo {
    fn to_vk(self) -> vk::DepthBiasRepresentationInfoEXT {
        vk::DepthBiasRepresentationInfoEXT {
            depth_bias_representation: self.representation,
            depth_bias_exact: if self.exact { vk::TRUE } else { vk::FALSE },
            ..Default::default()
        }
    }
}

/// `isForceUnormInexact`
fn is_force_unorm_inexact(repr_info: Option<ReprInfo>) -> bool {
    matches!(repr_info, Some(info) if info.representation == vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORCE_UNORM && !info.exact)
}

#[derive(Clone, Copy)]
struct TestParams {
    attachment_format: vk::Format,
    repr_info: Option<ReprInfo>,
    set_mechanism: SetMechanism,
    // The bias we aim to get, before clamping. Based on this and R, we can calculate factors.
    target_bias: f32,
    used_factor: UsedFactor,
    constant_depth: f32,
    depth_bias_clamp: f32,
    secondary_cmd_buffer: bool,
    // Renderpass started before the secondary command buffer.
    render_pass_inherit: bool,
    // Inheritance info contains the framebuffer.
    fb_specify: bool,
}

struct DepthBiasControlCase {
    name: String,
    params: TestParams,
}

impl TestCase for DepthBiasControlCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DepthBiasControlCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_depth_bias_control")?;

        if let Some(repr_info) = self.params.repr_info {
            let mut dbc_features = vk::PhysicalDeviceDepthBiasControlFeaturesEXT::default();
            let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut dbc_features);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_features2(context.get_physical_device(), &mut features2)
            };

            if repr_info.exact && dbc_features.depth_bias_exact == vk::FALSE {
                return Err(TestError::NotSupported("depthBiasExact not supported".to_string()));
            }
            if repr_info.representation == vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORCE_UNORM
                && dbc_features.least_representable_value_force_unorm_representation == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "leastRepresentableValueForceUnormRepresentation not supported".to_string(),
                ));
            }
            if repr_info.representation == vk::DepthBiasRepresentationEXT::FLOAT
                && dbc_features.float_representation == vk::FALSE
            {
                return Err(TestError::NotSupported("floatRepresentation not supported".to_string()));
            }
        }

        // Check format support.
        let create_info = image_create_info(self.params.attachment_format, depth_usage());
        let format_support = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                self.params.attachment_format,
                create_info.image_type,
                create_info.tiling,
                create_info.usage,
                create_info.flags,
            )
        };
        if let Err(error) = format_support
            && error == vk::ErrorCode::FORMAT_NOT_SUPPORTED
        {
            return Err(TestError::NotSupported(format!(
                "{} not supported",
                format_simple_name(self.params.attachment_format)
            )));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        DEPTH_BIAS_CONTROL.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DepthBiasControlInstance {
            context,
            params: self.params,
        })
    }
}

struct DepthBiasControlInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for DepthBiasControlInstance<'_> {
    /// `DepthBiasControlInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let extent = vk::Extent3D {
            width: 1,
            height: 1,
            depth: 1,
        };
        let depth_format = params.attachment_format;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let depth_srr = make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1);
        let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1);
        let depth_srl = make_image_subresource_layers(vk::ImageAspectFlags::DEPTH, 0, 0, 1);
        let kind = depth_kind(depth_format);
        let set_statically = params.set_mechanism == SetMechanism::Static;
        let constant_used = params.used_factor == UsedFactor::Constant;

        // Color buffer and depth buffer, each an image with a buffer to read it back.
        let color_image = ImageWithMemory::new(
            device,
            alloc,
            image_create_info(COLOR_FORMAT, color_usage()),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_srr,
        )?;
        let color_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(4, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let depth_image = ImageWithMemory::new(
            device,
            alloc,
            image_create_info(depth_format, depth_usage()),
            MemoryRequirement::ANY,
        )?;
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            depth_format,
            depth_srr,
        )?;
        let depth_texel_size: usize = match kind {
            DepthKind::UnsignedFixedPoint { bits: 16 } => 2,
            _ => 4,
        };
        let depth_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(depth_texel_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Generate two triangles as a triangle strip covering the whole framebuffer (4 vertices).
        //
        // WHEN USING THE DEPTH SLOPE FACTOR:
        // If the framebuffer is 1x1, the delta-X and delta-Y accross the whole framebuffer is 1.
        // If we make the left-side vertices have a depth of 1.0 and the other 2 have 0.0, delta-Z is 1.
        // Using both alternative formulas for calculating M, M is 1. This means depthSlopeFactor applies directly.
        // The depth at the sampling point would be 0.5.
        //
        // WHEN USING THE CONSTANT FACTOR:
        // Generate geometry with a chosen constant depth, so M is zero and depthSlopeFactor never applies.
        // We will make depthSlopeFactor 0 in any case.
        // The constant depth value allows us to control the depth value exponent, which affects some calculations.
        let left_depth = if constant_used { params.constant_depth } else { 0.0 };
        let right_depth = if constant_used { params.constant_depth } else { 1.0 };
        let vertices: [[f32; 4]; 4] = [
            [-1.0, -1.0, left_depth, 1.0],
            [-1.0, 1.0, left_depth, 1.0],
            [1.0, -1.0, right_depth, 1.0],
            [1.0, 1.0, right_depth, 1.0],
        ];
        let sample_depth = if constant_used { params.constant_depth } else { 0.5 };

        let vertex_buffer_size = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vertex_alloc = vertex_buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                vertex_alloc.get_host_ptr(),
                vertex_buffer_size as usize,
            )
        };
        flush_alloc(device, vertex_alloc)?;

        // Render pass with depth attachment.
        let attachments = [
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(depth_format)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let depth_reference = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references)
            .depth_stencil_attachment(&depth_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view, *depth_view], 1, 1, 1)?;

        // Pipeline.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        // Calculate depth bias parameters.
        let representation = params.repr_info.map_or(
            vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORMAT,
            |info| info.representation,
        );
        let exact_repr = params.repr_info.is_some_and(|info| info.exact);
        let r_value = calc_min_resolvable_diff(kind, representation, exact_repr, sample_depth);

        // Calculate factors based on the target bias and the minimum resolvable difference.
        let depth_bias_constant_factor = if constant_used {
            (f64::from(params.target_bias) / r_value.0) as f32
        } else {
            0.0
        };
        let depth_bias_slope_factor = if params.used_factor == UsedFactor::Slope {
            params.target_bias
        } else {
            0.0
        }; // Note M is 1.
        let depth_bias_clamp = params.depth_bias_clamp;
        log::info!(
            "Depth format {:?}, target bias {}, Rmin {}, Rmax {}, depthBiasConstantFactor {}, depthBiasSlopeFactor {}, depthBiasClamp {}",
            depth_format,
            params.target_bias,
            r_value.0,
            r_value.1,
            depth_bias_constant_factor,
            depth_bias_slope_factor,
            depth_bias_clamp
        );

        let mut repr_info_vk = params.repr_info.map(ReprInfo::to_vk);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::BACK)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(true)
            .depth_bias_constant_factor(if set_statically {
                depth_bias_constant_factor
            } else {
                0.0
            })
            .depth_bias_clamp(if set_statically { depth_bias_clamp } else { 0.0 })
            .depth_bias_slope_factor(if set_statically { depth_bias_slope_factor } else { 0.0 })
            .line_width(1.0);
        let rasterization_state = match (&mut repr_info_vk, set_statically) {
            (Some(info), true) => rasterization_state.push_next(info),
            _ => rasterization_state,
        };

        let stencil_op = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::ALWAYS)
            .compare_mask(0xFF)
            .write_mask(0xFF)
            .reference(0xFF)
            .build();
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .front(stencil_op)
            .back(stencil_op)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);

        let dynamic_states: &[vk::DynamicState] = if set_statically {
            &[]
        } else {
            &[vk::DynamicState::DEPTH_BIAS]
        };
        let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(dynamic_states);

        let vertex_bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vertex_attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vertex_bindings)
            .vertex_attribute_descriptions(&vertex_attributes);
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: 1.0,
            height: 1.0,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: 1, height: 1 },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vert_module)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
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
            .dynamic_state(&dynamic_state)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        // Command buffers, with an optional secondary one.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let primary_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let primary = *primary_cmd_buffer;
        let secondary_cmd_buffer = if params.secondary_cmd_buffer {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };
        let secondary = secondary_cmd_buffer
            .as_ref()
            .map_or_else(vk::CommandBuffer::null, |cmd| **cmd);
        let subpass_contents = if params.secondary_cmd_buffer {
            vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
        } else {
            vk::SubpassContents::INLINE
        };

        // For render pass contents.
        let rp_cmd_buffer = if params.secondary_cmd_buffer {
            secondary
        } else {
            primary
        };

        let clear_values = [
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 0.0],
                },
            },
            vk::ClearValue {
                depth_stencil: vk::ClearDepthStencilValue { depth: 1.0, stencil: 0 },
            },
        ];
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: 1, height: 1 },
        };

        begin_command_buffer(device, primary)?;
        if params.secondary_cmd_buffer && !params.render_pass_inherit {
            begin_secondary_command_buffer(device, secondary, *render_pass, 0, *framebuffer)?;
        }
        let begin_info = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(render_area)
            .clear_values(&clear_values);
        unsafe { device.cmd_begin_render_pass(primary, &begin_info, subpass_contents) };
        if params.secondary_cmd_buffer && params.render_pass_inherit {
            let inherited_framebuffer = if params.fb_specify {
                *framebuffer
            } else {
                vk::Framebuffer::null()
            };
            begin_secondary_command_buffer(device, secondary, *render_pass, 0, inherited_framebuffer)?;
        }

        // Render pass contents.
        unsafe {
            device.cmd_bind_vertex_buffers(rp_cmd_buffer, 0, &[vertex_buffer.get()], &[0]);
            device.cmd_bind_pipeline(rp_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            match params.set_mechanism {
                SetMechanism::Static => {}
                SetMechanism::Dynamic1 => {
                    debug_assert!(params.repr_info.is_none());
                    device.cmd_set_depth_bias(
                        rp_cmd_buffer,
                        depth_bias_constant_factor,
                        depth_bias_clamp,
                        depth_bias_slope_factor,
                    );
                }
                SetMechanism::Dynamic2 => {
                    let next = repr_info_vk.as_ref().map_or(std::ptr::null(), |info| {
                        info as *const vk::DepthBiasRepresentationInfoEXT as *const std::ffi::c_void
                    });
                    let depth_bias_info = vk::DepthBiasInfoEXT {
                        next,
                        depth_bias_constant_factor,
                        depth_bias_clamp,
                        depth_bias_slope_factor,
                        ..Default::default()
                    };
                    device.cmd_set_depth_bias2_ext(rp_cmd_buffer, &depth_bias_info);
                }
            }
            device.cmd_draw(rp_cmd_buffer, vertices.len() as u32, 1, 0, 0);
        }

        if params.secondary_cmd_buffer {
            end_command_buffer(device, secondary)?;
            unsafe { device.cmd_execute_commands(primary, &[secondary]) };
        }
        unsafe { device.cmd_end_render_pass(primary) };

        // Copy color and depth buffers to their verification buffers.
        {
            let pre_transfer_barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    depth_image.get(),
                    depth_srr,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::TRANSFER_READ,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_image.get(),
                    color_srr,
                ),
            ];
            let pre_transfer_stages = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                | vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS
                | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS;
            let depth_region = make_buffer_image_copy(extent, depth_srl);
            let color_region = make_buffer_image_copy(extent, color_srl);
            let transfer_to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    primary,
                    pre_transfer_stages,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &pre_transfer_barriers,
                );
                device.cmd_copy_image_to_buffer(
                    primary,
                    depth_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    depth_buffer.get(),
                    &[depth_region],
                );
                device.cmd_copy_image_to_buffer(
                    primary,
                    color_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.get(),
                    &[color_region],
                );
                device.cmd_pipeline_barrier(
                    primary,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[transfer_to_host],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }

        end_command_buffer(device, primary)?;
        submit_commands_and_wait(device, queue, primary)?;

        // Invalidate allocations and verify contents.
        invalidate_alloc(device, depth_buffer.get_allocation())?;
        invalidate_alloc(device, color_buffer.get_allocation())?;

        // Depth reference.
        let no_clamp = params.depth_bias_clamp == 0.0;
        let clamped_bias = params.target_bias.min(if no_clamp {
            params.target_bias
        } else {
            params.depth_bias_clamp
        });
        let expected_depth = sample_depth + clamped_bias; // Must match vertex depth + actual bias.

        // We calculated depth bias constant factors based on the most precise minimum resolvable diff, but the actual
        // resolvable diff may be bigger in some cases. We take that into account when calculating the error threshold
        // for depth values, and we add the format precision on top.
        let constant_factor_d = f64::from(depth_bias_constant_factor);
        let constant_bias_min = constant_factor_d * r_value.0;
        let constant_bias_max = constant_factor_d * r_value.1;
        let constant_bias_error_threshold = constant_bias_max - constant_bias_min;
        let depth_threshold = (constant_bias_error_threshold + get_depth_error_threshold(kind, expected_depth)) as f32;
        log::info!(
            "Constant Bias Min {constant_bias_min}, Max {constant_bias_max}, Error Threshold {constant_bias_error_threshold}"
        );

        // The reference goes through the format as tcu::clearDepth does, and the result is read back the way
        // getPixDepth does, from the depth aspect copy.
        let depth_bytes =
            unsafe { std::slice::from_raw_parts(depth_buffer.get_allocation().get_host_ptr(), depth_texel_size) };
        let (expected_stored, found_depth) = match kind {
            DepthKind::UnsignedFixedPoint { bits } => {
                let max = ((1u64 << bits) - 1) as f32;
                let raw = if depth_texel_size == 2 {
                    u32::from(u16::from_ne_bytes([depth_bytes[0], depth_bytes[1]]))
                } else {
                    u32::from_ne_bytes([depth_bytes[0], depth_bytes[1], depth_bytes[2], depth_bytes[3]]) & 0x00FF_FFFF
                };
                (
                    (expected_depth.clamp(0.0, 1.0) * max + 0.5).floor() / max,
                    raw as f32 / max,
                )
            }
            DepthKind::FloatingPoint => (
                expected_depth,
                f32::from_ne_bytes([depth_bytes[0], depth_bytes[1], depth_bytes[2], depth_bytes[3]]),
            ),
        };

        let color_bytes = unsafe { std::slice::from_raw_parts(color_buffer.get_allocation().get_host_ptr(), 4) };

        let mut fail = false;

        if (expected_stored - found_depth).abs() > depth_threshold {
            log::info!(
                "Depth buffer failed: expected {expected_depth} (threshold {depth_threshold}) and found {found_depth}"
            );
            fail = true;
        }

        // Expect exact result in color.
        if color_bytes != OUT_COLOR {
            log::info!("Color buffer failed: expected {OUT_COLOR:?} and found {color_bytes:?}");
            fail = true;
        }

        if fail {
            return Ok(TestStatus::fail("Failed -- check log for details"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDepthBiasControlTests`
pub fn create_depth_bias_control_tests() -> TestCaseGroup {
    let attachment_formats = [
        vk::Format::D16_UNORM,
        vk::Format::X8_D24_UNORM_PACK32,
        vk::Format::D32_SFLOAT,
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ];

    let used_factor_cases = [(UsedFactor::Slope, "slope"), (UsedFactor::Constant, "constant")];

    let repr = |representation: vk::DepthBiasRepresentationEXT, exact: bool| Some(ReprInfo { representation, exact });
    let format_repr = vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORMAT;
    let force_unorm_repr = vk::DepthBiasRepresentationEXT::LEAST_REPRESENTABLE_VALUE_FORCE_UNORM;
    let float_repr = vk::DepthBiasRepresentationEXT::FLOAT;
    let repr_info_cases: [(Option<ReprInfo>, &str); 7] = [
        (None, "no_repr_info"),
        (repr(format_repr, false), "format_inexact"),
        (repr(format_repr, true), "format_exact"),
        (repr(force_unorm_repr, false), "force_unorm_inexact"),
        (repr(force_unorm_repr, true), "force_unorm_exact"),
        (repr(float_repr, false), "float_inexact"),
        (repr(float_repr, true), "float_exact"),
    ];

    // For the slope subcases the constant depth is not used.
    let constant_depth_slope_cases: [(f32, &str); 1] = [(0.0, "slope_depth_1_0")];
    let constant_depth_constant_cases: [(f32, &str); 5] = [
        (0.25, "constant_depth_0_25"),
        (0.3125, "constant_depth_0_3125"),
        (0.489_742_28, "constant_depth_close_to_0_5"),
        (0.625, "constant_depth_0_625"),
        (0.125, "constant_depth_0_125"),
    ];

    let target_bias_cases = [
        (0.0625f32, "target_bias_0_0625"),
        (0.125, "target_bias_0_125"),
        (0.25, "target_bias_0_25"),
    ];

    let set_mechanism_cases = [
        (SetMechanism::Static, "static"),
        (SetMechanism::Dynamic1, "dynamic_set_1"),
        (SetMechanism::Dynamic2, "dynamic_set_2"),
    ];

    #[derive(Clone, Copy, PartialEq, Eq)]
    enum ClampCase {
        Zero,
        Large,
        Small,
    }
    let clamp_value_cases = [
        (ClampCase::Zero, "_no_clamp"),
        (ClampCase::Large, "_no_effective_clamp"),
        (ClampCase::Small, "_clamp_to_half"),
    ];

    // (secondary_cmd_buffer, render_pass_inherit, fb_specify, suffix)
    let secondary_cmd_buffer_cases = [
        (false, false, false, ""),
        (true, false, false, "_secondary_cmd_buffer"),
        (true, true, true, "_secondary_cmd_buffer_inherit_renderpass"),
        (true, true, false, "_secondary_cmd_buffer_unspecified_fb"),
    ];

    let mut dbc_group = TestCaseGroup::new("depth_bias_control");

    for format in attachment_formats {
        let mut format_group = TestCaseGroup::new(format_simple_name(format));

        for (repr_info, repr_info_name) in repr_info_cases {
            let mut repr_info_group = TestCaseGroup::new(repr_info_name);

            for (used_factor, used_factor_name) in used_factor_cases {
                let mut used_factor_group = TestCaseGroup::new(used_factor_name);

                let constant_factor = used_factor == UsedFactor::Constant;
                let constant_depth_cases: &[(f32, &str)] = if constant_factor {
                    &constant_depth_constant_cases
                } else {
                    &constant_depth_slope_cases
                };

                for &(constant_depth, constant_depth_name) in constant_depth_cases {
                    let mut constant_depth_group = TestCaseGroup::new(constant_depth_name);

                    for (target_bias, target_bias_name) in target_bias_cases {
                        let mut target_bias_group = TestCaseGroup::new(target_bias_name);

                        for (set_mechanism, set_mechanism_name) in set_mechanism_cases {
                            // We cannot use the representation info with vkCmdSetDepthBias.
                            if set_mechanism == SetMechanism::Dynamic1 && repr_info.is_some() {
                                continue;
                            }

                            for (clamp_case, clamp_suffix) in clamp_value_cases {
                                let depth_bias_clamp = match clamp_case {
                                    ClampCase::Zero => 0.0,
                                    ClampCase::Large => target_bias * 2.0,
                                    ClampCase::Small => target_bias * 0.5,
                                };

                                // For FORCE_UNORM + inexact with constant bias, omit this selected parameter subset: it
                                // is the subset where zf_max can go above zmax=1.0 with depth clamping disabled.
                                if used_factor == UsedFactor::Constant
                                    && is_force_unorm_inexact(repr_info)
                                    && constant_depth == 0.625
                                    && target_bias == 0.25
                                    && (clamp_case == ClampCase::Zero || clamp_case == ClampCase::Large)
                                {
                                    continue;
                                }

                                for (secondary_cmd_buffer, render_pass_inherit, fb_specify, secondary_suffix) in
                                    secondary_cmd_buffer_cases
                                {
                                    // Some selected combinations will use secondary command buffers. Avoid applying this
                                    // to all combinations to keep the number of cases low.
                                    if secondary_cmd_buffer
                                        && (used_factor != UsedFactor::Constant
                                            || set_mechanism == SetMechanism::Dynamic1
                                            || clamp_case != ClampCase::Zero
                                            || repr_info.is_none())
                                    {
                                        continue;
                                    }

                                    let params = TestParams {
                                        attachment_format: format,
                                        repr_info,
                                        set_mechanism,
                                        target_bias,
                                        used_factor,
                                        constant_depth,
                                        depth_bias_clamp,
                                        secondary_cmd_buffer,
                                        render_pass_inherit,
                                        fb_specify,
                                    };
                                    let name = format!("{set_mechanism_name}{clamp_suffix}{secondary_suffix}");
                                    target_bias_group.add_child(Box::new(DepthBiasControlCase { name, params }) as Box<dyn TestCase>);
                                }
                            }
                        }

                        constant_depth_group.add_child(target_bias_group);
                    }

                    used_factor_group.add_child(constant_depth_group);
                }

                repr_info_group.add_child(used_factor_group);
            }

            format_group.add_child(repr_info_group);
        }

        dbc_group.add_child(format_group);
    }

    dbc_group
}
