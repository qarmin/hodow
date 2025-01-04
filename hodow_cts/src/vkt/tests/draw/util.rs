// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/draw/vktDrawCreateInfoUtil.cpp / .hpp (the `PipelineCreateInfo` defaults)
//   external/vulkancts/modules/vulkan/vktTestCaseUtil.hpp / vkImageWithMemory (`ImageWithBuffer`)
//   external/vulkancts/framework/vulkan/vkCmdUtil.cpp (`beginRendering`, `endRendering`, `clearColorImage`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// What the `draw` tests that build their own pipeline and target (every one that is not a
// `DrawTestsBaseClass`) share: a colour image with a read-back buffer, a graphics pipeline built from
// `PipelineCreateInfo`'s defaults with a few states overridden, and the three ways a draw is recorded
// (secondary command buffer, dynamic rendering, render pass) around a caller's own commands.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool};
use crate::vk::pipeline_construction::{PipelineConstructionType, PipelineParts, create_linked_pipeline};
use crate::vk::ref_util::Unique;
use crate::vkt::Context;
use crate::vkt::tests::draw::base_class::GroupParams;

/// `vk::ImageWithBuffer`, 2D with one mip level: a colour image, its view and a host-visible buffer sized for one copy of it.
pub struct ImageWithBuffer<'a> {
    pub image: ImageWithMemory<'a>,
    pub view: Unique<'a, vk::ImageView>,
    pub buffer: BufferWithMemory<'a>,
    pub width: u32,
    pub height: u32,
    pub format: vk::Format,
}

impl<'a> ImageWithBuffer<'a> {
    pub fn new(
        context: &'a Context<'a>,
        width: u32,
        height: u32,
        format: vk::Format,
        usage: vk::ImageUsageFlags,
        texel_size: u32,
    ) -> Result<Self, TestError> {
        Self::new_on(
            context.get_device(),
            context.get_default_allocator(),
            width,
            height,
            format,
            usage,
            texel_size,
        )
    }

    /// The same on a device and allocator that are not the context's.
    pub fn new_on(
        device: &'a Device,
        alloc: &SimpleAllocator,
        width: u32,
        height: u32,
        format: vk::Format,
        usage: vk::ImageUsageFlags,
        texel_size: u32,
    ) -> Result<Self, TestError> {
        let info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(vk::Extent3D {
                width,
                height,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(usage)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image = ImageWithMemory::new(device, alloc, info, MemoryRequirement::ANY)?;
        let view = make_image_view(
            device,
            image.get(),
            vk::ImageViewType::_2D,
            format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;
        let buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                (width * height * texel_size) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        Ok(Self {
            image,
            view,
            buffer,
            width,
            height,
            format,
        })
    }

    /// The buffer's bytes after the device wrote them (`invalidateAlloc` + `getHostPtr`).
    pub fn read_bytes(&self, device: &Device) -> Result<&[u8], TestError> {
        let alloc = self.buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        let size = (self.width * self.height) as usize * texel_size_of(self.format);
        Ok(unsafe { std::slice::from_raw_parts(alloc.get_host_ptr(), size) })
    }
}

/// Bytes per texel of the formats the draw tests render to.
fn texel_size_of(format: vk::Format) -> usize {
    match format {
        vk::Format::R8G8B8A8_UNORM
        | vk::Format::R8G8B8A8_SRGB
        | vk::Format::B8G8R8A8_UNORM
        | vk::Format::R32_SFLOAT
        | vk::Format::R32_UINT
        | vk::Format::R32_SINT => 4,
        vk::Format::R16G16B16A16_SFLOAT => 8,
        vk::Format::R32G32B32A32_SFLOAT => 16,
        _ => 4,
    }
}

/// `vk::clearColorImage`: clears `image` and leaves it in `new_layout`, in a submission of its own.
#[allow(clippy::too_many_arguments)]
pub fn clear_color_image(
    context: &Context<'_>,
    image: vk::Image,
    color: [f32; 4],
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    dst_stage: vk::PipelineStageFlags,
    mip_levels: u32,
    array_layers: u32,
) -> Result<(), TestError> {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd = allocate_command_buffer(device, *pool, vk::CommandBufferLevel::PRIMARY)?;
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, mip_levels, 0, array_layers);

    let pre_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        old_layout,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image,
        range,
    );
    let post_barrier = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::SHADER_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        new_layout,
        image,
        range,
    );
    let clear_value = vk::ClearColorValue { float32: color };

    begin_command_buffer(device, *cmd)?;
    unsafe {
        device.cmd_pipeline_barrier(
            *cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_barrier],
        );
        device.cmd_clear_color_image(
            *cmd,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &clear_value,
            &[range],
        );
        device.cmd_pipeline_barrier(
            *cmd,
            vk::PipelineStageFlags::TRANSFER,
            dst_stage | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_barrier],
        );
    }
    end_command_buffer(device, *cmd)?;
    submit_commands_and_wait(device, queue, *cmd)
}

/// `vk::beginRendering` for one colour attachment.
#[allow(clippy::too_many_arguments)]
pub fn begin_rendering(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image_view: vk::ImageView,
    render_area: vk::Rect2D,
    clear_value: vk::ClearValue,
    image_layout: vk::ImageLayout,
    load_op: vk::AttachmentLoadOp,
    flags: vk::RenderingFlags,
    layer_count: u32,
    view_mask: u32,
) {
    let color_attachments = [vk::RenderingAttachmentInfo::builder()
        .image_view(image_view)
        .image_layout(image_layout)
        .resolve_mode(vk::ResolveModeFlags::NONE)
        .load_op(load_op)
        .store_op(vk::AttachmentStoreOp::STORE)
        .clear_value(clear_value)
        .build()];
    let rendering_info = vk::RenderingInfo::builder()
        .flags(flags)
        .render_area(render_area)
        .layer_count(layer_count)
        .view_mask(view_mask)
        .color_attachments(&color_attachments);
    unsafe { device.cmd_begin_rendering(cmd_buffer, &rendering_info) };
}

/// `vk::endRendering`
pub fn end_rendering(device: &Device, cmd_buffer: vk::CommandBuffer) {
    unsafe { device.cmd_end_rendering(cmd_buffer) };
}

/// `vk::makeRect2D`
pub fn rect_2d(width: u32, height: u32) -> vk::Rect2D {
    vk::Rect2D {
        offset: vk::Offset2D { x: 0, y: 0 },
        extent: vk::Extent2D { width, height },
    }
}

/// `vk::makeViewport`
pub fn viewport(x: f32, y: f32, width: f32, height: f32, min_depth: f32, max_depth: f32) -> vk::Viewport {
    vk::Viewport {
        x,
        y,
        width,
        height,
        min_depth,
        max_depth,
    }
}

/// `vk::makeClearValueColor`
pub fn clear_value_color(color: [f32; 4]) -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue { float32: color },
    }
}

/// A single-subpass render pass over one colour attachment, as the `AttachmentDescription` /
/// `SubpassDescription` pair the draw tests write out by hand.
#[allow(clippy::too_many_arguments)]
pub fn make_color_render_pass<'a>(
    device: &'a Device,
    format: vk::Format,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    initial_layout: vk::ImageLayout,
    final_layout: vk::ImageLayout,
    attachment_layout: vk::ImageLayout,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let attachments = [vk::AttachmentDescription::builder()
        .format(format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(load_op)
        .store_op(store_op)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::STORE)
        .initial_layout(initial_layout)
        .final_layout(final_layout)
        .build()];
    let color_references = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(attachment_layout)
        .build()];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_references)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?;
    Ok(Unique::new(device, render_pass))
}

/// What a pipeline chains as `VkPipelineDiscardRectangleStateCreateInfoEXT`.
pub struct DiscardRectangleState {
    pub mode: vk::DiscardRectangleModeEXT,
    pub count: u32,
    pub rectangles: Vec<vk::Rect2D>,
    /// The rectangles are set with a command, so the create info carries only the count.
    pub dynamic: bool,
}

/// The states of a graphics pipeline a draw test may override; the defaults are `PipelineCreateInfo`'s.
pub struct DrawPipelineState {
    pub topology: vk::PrimitiveTopology,
    pub primitive_restart_enable: bool,
    pub bindings: Vec<vk::VertexInputBindingDescription>,
    pub attributes: Vec<vk::VertexInputAttributeDescription>,
    /// Empty with a nonzero `viewport_count` is a pipeline whose viewports are dynamic state.
    pub viewports: Vec<vk::Viewport>,
    pub scissors: Vec<vk::Rect2D>,
    pub viewport_count: u32,
    pub dynamic_states: Vec<vk::DynamicState>,
    pub rasterization: vk::PipelineRasterizationStateCreateInfo,
    pub depth_stencil: vk::PipelineDepthStencilStateCreateInfo,
    pub samples: vk::SampleCountFlags,
    /// `Some` selects dynamic rendering: the pipeline renders to a colour attachment of this format.
    pub rendering_format: Option<vk::Format>,
    /// The depth attachment format a dynamic rendering pipeline is created with.
    pub depth_rendering_format: vk::Format,
    /// Passes a null `pInputAssemblyState` (monolithic pipelines only; legal with dynamic topology and rasterizer discard).
    pub null_input_assembly_state: bool,
    /// The colour attachment formats of a dynamic rendering pipeline with several of them; used when not empty, in place of `rendering_format`.
    pub rendering_formats: Vec<vk::Format>,
    /// Chains a `VkRenderingAttachmentLocationInfo` with these colour attachment locations into the pipeline create info.
    pub rendering_attachment_locations: Option<Vec<u32>>,
    /// The stencil attachment format a dynamic rendering pipeline is created with.
    pub stencil_rendering_format: vk::Format,
    /// The subpass of the render pass the pipeline is used in.
    pub subpass: u32,
    pub view_mask: u32,
    pub patch_control_points: Option<u32>,
    /// Zero builds the pipeline without a colour blend state, for a render pass with no attachments.
    pub color_attachment_count: u32,
    pub sample_shading: bool,
    pub min_sample_shading: f32,
    /// Chains a 2x2 `VkPipelineFragmentShadingRateStateCreateInfoKHR` with both combiner ops KEEP.
    pub fragment_shading_rate: bool,
    /// Chains this state instead of the fixed 2x2 one `fragment_shading_rate` asks for.
    pub fragment_shading_rate_state: Option<vk::PipelineFragmentShadingRateStateCreateInfoKHR>,
    /// Chains a `VkPipelineRasterizationLineStateCreateInfoKHR` with this mode, stippling off.
    pub line_rasterization_mode: Option<vk::LineRasterizationMode>,
    /// Chains a `VkPipelineVertexInputDivisorStateCreateInfo` over these bindings when not empty.
    pub vertex_divisors: Vec<vk::VertexInputBindingDivisorDescription>,
    /// Sets `pSampleMask` to this single word.
    pub sample_mask: Option<vk::SampleMask>,
    pub pipeline_cache: vk::PipelineCache,
    pub create_flags: vk::PipelineCreateFlags,
    /// Chains a `VkPipelineCreateFlags2CreateInfo` with these flags (`create_flags` is then expected to be empty).
    pub create_flags2: Option<vk::PipelineCreateFlags2>,
    pub discard_rectangles: Option<DiscardRectangleState>,
    /// Enables the logic operation of the colour blend state.
    pub logic_op: Option<vk::LogicOp>,
    /// Replaces the colour blend attachment state (blending off, every channel written, by default).
    pub color_blend_attachment: Option<vk::PipelineColorBlendAttachmentState>,
    /// One blend state per colour attachment when not empty; takes the place of `color_blend_attachment`.
    pub color_blend_attachments: Vec<vk::PipelineColorBlendAttachmentState>,
    pub blend_constants: [f32; 4],
    /// Chains a `VkPipelineColorWriteCreateInfoEXT` with these enables into the colour blend state.
    pub color_write_enables: Option<Vec<vk::Bool32>>,
    /// Chains a `VkPipelineViewportDepthClampControlCreateInfoEXT` into the viewport state.
    pub depth_clamp_control: Option<(vk::DepthClampModeEXT, Option<vk::DepthClampRangeEXT>)>,
    /// Chains a `VkPipelineViewportDepthClipControlCreateInfoEXT` with this `negativeOneToOne` into the viewport state.
    pub depth_clip_control: Option<bool>,
    /// Chains a `VkPipelineTessellationDomainOriginStateCreateInfo` into the tessellation state.
    pub tessellation_domain_origin: Option<vk::TessellationDomainOrigin>,
    /// The base pipeline handle and index of a derivative pipeline.
    pub base_pipeline: Option<(vk::Pipeline, i32)>,
    /// Chains this `VkPipelineRobustnessCreateInfo` into the pipeline create info.
    pub pipeline_robustness: Option<vk::PipelineRobustnessCreateInfo>,
    /// Chains this `VkPipelineCreationFeedbackCreateInfo`; the feedback structures it points to must outlive the call.
    pub creation_feedback: Option<vk::PipelineCreationFeedbackCreateInfo>,
    /// The value of specialization constant 0 (a `uint`) of the vertex stage.
    pub vertex_specialization_u32: Option<u32>,
    /// Specialization constant 0 for every stage of the pipeline; takes the place of `vertex_specialization_u32`.
    pub all_stages_specialization_u32: Option<u32>,
    /// Specialization constants 0..n (each a `uint`) for every stage of the pipeline; used when not empty, ahead of the two above.
    pub all_stages_specialization_values: Vec<u32>,
    /// Chains a `VkPipelineRasterizationProvokingVertexStateCreateInfoEXT` with this mode into the rasterization state.
    pub provoking_vertex_mode: Option<vk::ProvokingVertexModeEXT>,
    /// Chains a `VkPipelineColorBlendAdvancedStateCreateInfoEXT` (srcPremultiplied, dstPremultiplied, blendOverlap) into the colour blend state.
    pub color_blend_advanced: Option<(bool, bool, vk::BlendOverlapEXT)>,
    pub alpha_to_coverage_enable: bool,
    pub alpha_to_one_enable: bool,
    /// Map entries and data of the `VkSpecializationInfo` every stage of the pipeline gets; takes the place of the `u32` forms above.
    pub specialization: Option<(Vec<vk::SpecializationMapEntry>, Vec<u8>)>,
    /// Chains a `VkPipelineSampleLocationsStateCreateInfoEXT` (sampleLocationsEnable, info) into the multisample state; the locations it points to must outlive the call.
    pub sample_locations: Option<(bool, vk::SampleLocationsInfoEXT)>,
    /// Chains a `VkPipelineBinaryInfoKHR` over these binaries (an empty list is a zero count).
    pub binary_info: Option<Vec<vk::PipelineBinaryKHR>>,
    /// Creates every stage with a null module, as a pipeline made from binaries is.
    pub null_shader_modules: bool,
    /// Asks vkGetPipelineKeyKHR for the key of the create info first and fails when it comes back empty.
    pub check_pipeline_key: bool,
    /// How the pipeline is built: in one call, or as the four graphics pipeline library parts and a link.
    pub construction: PipelineConstructionType,
    /// Chains a `VkShaderDescriptorSetAndBindingMappingInfoEXT` with these mappings into every stage (monolithic pipelines only).
    pub descriptor_heap_mappings: Option<Vec<vk::DescriptorSetAndBindingMappingEXT>>,
}

impl DrawPipelineState {
    pub fn new(topology: vk::PrimitiveTopology) -> Self {
        Self {
            topology,
            primitive_restart_enable: false,
            bindings: Vec::new(),
            attributes: Vec::new(),
            viewports: Vec::new(),
            scissors: Vec::new(),
            viewport_count: 1,
            dynamic_states: Vec::new(),
            rasterization: default_rasterization_state(),
            depth_stencil: default_depth_stencil_state(),
            samples: vk::SampleCountFlags::_1,
            rendering_format: None,
            depth_rendering_format: vk::Format::UNDEFINED,
            null_input_assembly_state: false,
            rendering_formats: Vec::new(),
            rendering_attachment_locations: None,
            stencil_rendering_format: vk::Format::UNDEFINED,
            subpass: 0,
            view_mask: 0,
            patch_control_points: None,
            color_attachment_count: 1,
            sample_shading: false,
            min_sample_shading: 1.0,
            fragment_shading_rate: false,
            fragment_shading_rate_state: None,
            line_rasterization_mode: None,
            vertex_divisors: Vec::new(),
            sample_mask: None,
            pipeline_cache: vk::PipelineCache::null(),
            create_flags: vk::PipelineCreateFlags::empty(),
            create_flags2: None,
            discard_rectangles: None,
            logic_op: None,
            color_blend_attachment: None,
            color_blend_attachments: Vec::new(),
            blend_constants: [0.0; 4],
            color_write_enables: None,
            depth_clamp_control: None,
            depth_clip_control: None,
            tessellation_domain_origin: None,
            base_pipeline: None,
            pipeline_robustness: None,
            creation_feedback: None,
            vertex_specialization_u32: None,
            all_stages_specialization_u32: None,
            all_stages_specialization_values: Vec::new(),
            provoking_vertex_mode: None,
            color_blend_advanced: None,
            alpha_to_coverage_enable: false,
            alpha_to_one_enable: false,
            specialization: None,
            sample_locations: None,
            binary_info: None,
            null_shader_modules: false,
            check_pipeline_key: false,
            construction: PipelineConstructionType::Monolithic,
            descriptor_heap_mappings: None,
        }
    }

    /// One binding and one attribute at location 0: a `tcu::Vec4` per vertex.
    pub fn with_position_input(mut self) -> Self {
        self.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 16,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        self.attributes = vec![vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        self
    }

    /// A fixed viewport and scissor covering a `width` x `height` target.
    pub fn with_full_viewport(mut self, width: u32, height: u32) -> Self {
        self.viewports = vec![viewport(0.0, 0.0, width as f32, height as f32, 0.0, 1.0)];
        self.scissors = vec![rect_2d(width, height)];
        self.viewport_count = 1;
        self
    }
}

/// `PipelineCreateInfo::RasterizerState()`'s defaults - note the depth bias is enabled, with zero factors.
pub fn default_rasterization_state() -> vk::PipelineRasterizationStateCreateInfo {
    vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::CLOCKWISE)
        .depth_bias_enable(true)
        .depth_bias_constant_factor(0.0)
        .depth_bias_clamp(0.0)
        .depth_bias_slope_factor(0.0)
        .line_width(1.0)
        .build()
}

/// `PipelineCreateInfo::DepthStencilState()`'s defaults.
pub fn default_depth_stencil_state() -> vk::PipelineDepthStencilStateCreateInfo {
    let stencil_op = vk::StencilOpState::builder()
        .fail_op(vk::StencilOp::REPLACE)
        .pass_op(vk::StencilOp::REPLACE)
        .depth_fail_op(vk::StencilOp::REPLACE)
        .compare_op(vk::CompareOp::ALWAYS)
        .compare_mask(0xffff_ffff)
        .write_mask(0xffff_ffff)
        .reference(0)
        .build();
    vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(false)
        .depth_write_enable(false)
        .depth_compare_op(vk::CompareOp::ALWAYS)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(stencil_op)
        .back(stencil_op)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0)
        .build()
}

/// `vk::createGraphicsPipeline` over a `PipelineCreateInfo` assembled from `state`: one colour attachment
/// with blending off and every channel written, default multisample state.
pub fn create_draw_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: &[(vk::ShaderStageFlags, vk::ShaderModule)],
    state: &DrawPipelineState,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    if !crate::vkt::tests::pipeline::fsr_ambient::ambient_rates_support(state.samples) {
        return Err(TestError::NotSupported(
            "Required FragmentShadingRate not supported".to_string(),
        ));
    }
    let specialization_values: Vec<u32> = if state.all_stages_specialization_values.is_empty() {
        vec![
            state
                .all_stages_specialization_u32
                .or(state.vertex_specialization_u32)
                .unwrap_or(0),
        ]
    } else {
        state.all_stages_specialization_values.clone()
    };
    let specialization_entries: Vec<vk::SpecializationMapEntry> = (0..specialization_values.len() as u32)
        .map(|id| vk::SpecializationMapEntry {
            constant_id: id,
            offset: 4 * id,
            size: 4,
        })
        .collect();
    let specialization_data: Vec<u8> = specialization_values
        .iter()
        .flat_map(|value| value.to_ne_bytes())
        .collect();
    let (specialization_entries, specialization_data) = match &state.specialization {
        Some((entries, data)) => (entries.clone(), data.clone()),
        None => (specialization_entries, specialization_data),
    };
    let specialization_info = vk::SpecializationInfo::builder()
        .map_entries(&specialization_entries)
        .data(&specialization_data);
    let custom_specialization = state
        .specialization
        .as_ref()
        .is_some_and(|(entries, _)| !entries.is_empty());
    let heap_mapping_info =
        state
            .descriptor_heap_mappings
            .as_ref()
            .map(|mappings| vk::ShaderDescriptorSetAndBindingMappingInfoEXT {
                mapping_count: mappings.len() as u32,
                mappings: mappings.as_ptr(),
                ..Default::default()
            });
    let stage_infos: Vec<vk::PipelineShaderStageCreateInfo> = stages
        .iter()
        .map(|&(stage, module)| {
            let module = if state.null_shader_modules {
                vk::ShaderModule::null()
            } else {
                module
            };
            let mut info = vk::PipelineShaderStageCreateInfo::builder()
                .stage(stage)
                .module(module)
                .name(b"main\0");
            if (stage == vk::ShaderStageFlags::VERTEX && state.vertex_specialization_u32.is_some())
                || state.all_stages_specialization_u32.is_some()
                || !state.all_stages_specialization_values.is_empty()
                || custom_specialization
            {
                info = info.specialization_info(&specialization_info);
            }
            let mut info = info.build();
            if let Some(mapping_info) = &heap_mapping_info {
                info.next = (mapping_info as *const vk::ShaderDescriptorSetAndBindingMappingInfoEXT).cast();
            }
            info
        })
        .collect();

    let mut divisor_info =
        vk::PipelineVertexInputDivisorStateCreateInfo::builder().vertex_binding_divisors(&state.vertex_divisors);
    let mut vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
        .vertex_binding_descriptions(&state.bindings)
        .vertex_attribute_descriptions(&state.attributes);
    if !state.vertex_divisors.is_empty() {
        vertex_input_state = vertex_input_state.push_next(&mut divisor_info);
    }
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(state.topology)
        .primitive_restart_enable(state.primitive_restart_enable);
    let default_blend_attachment = vk::PipelineColorBlendAttachmentState::builder()
        .blend_enable(false)
        .src_color_blend_factor(vk::BlendFactor::SRC_COLOR)
        .dst_color_blend_factor(vk::BlendFactor::DST_COLOR)
        .color_blend_op(vk::BlendOp::ADD)
        .src_alpha_blend_factor(vk::BlendFactor::SRC_COLOR)
        .dst_alpha_blend_factor(vk::BlendFactor::DST_COLOR)
        .alpha_blend_op(vk::BlendOp::ADD)
        .color_write_mask(vk::ColorComponentFlags::all())
        .build();
    let color_blend_attachments: Vec<vk::PipelineColorBlendAttachmentState> = if state
        .color_blend_attachments
        .is_empty()
    {
        vec![state.color_blend_attachment.unwrap_or(default_blend_attachment); state.color_attachment_count as usize]
    } else {
        state.color_blend_attachments.clone()
    };
    let color_write_enables: &[vk::Bool32] = state.color_write_enables.as_deref().unwrap_or(&[]);
    let mut color_write_info = vk::PipelineColorWriteCreateInfoEXT::builder().color_write_enables(color_write_enables);
    let mut color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(state.logic_op.is_some())
        .logic_op(state.logic_op.unwrap_or(vk::LogicOp::COPY))
        .attachments(&color_blend_attachments)
        .blend_constants(state.blend_constants);
    if state.color_write_enables.is_some() {
        color_blend_state = color_blend_state.push_next(&mut color_write_info);
    }
    let (src_premultiplied, dst_premultiplied, blend_overlap) =
        state
            .color_blend_advanced
            .unwrap_or((false, false, vk::BlendOverlapEXT::UNCORRELATED));
    let mut color_blend_advanced_info = vk::PipelineColorBlendAdvancedStateCreateInfoEXT::builder()
        .src_premultiplied(src_premultiplied)
        .dst_premultiplied(dst_premultiplied)
        .blend_overlap(blend_overlap);
    if state.color_blend_advanced.is_some() {
        color_blend_state = color_blend_state.push_next(&mut color_blend_advanced_info);
    }

    let mut viewport_state = vk::PipelineViewportStateCreateInfo::builder().scissors(&state.scissors);
    if state.viewports.is_empty() {
        viewport_state.viewport_count = state.viewport_count;
    } else {
        viewport_state = viewport_state.viewports(&state.viewports);
    }
    if state.scissors.is_empty() {
        viewport_state.scissor_count = state.viewport_count;
    }
    let (depth_clamp_mode, depth_clamp_range) = state
        .depth_clamp_control
        .unwrap_or((vk::DepthClampModeEXT::VIEWPORT_RANGE, None));
    let depth_clamp_range_storage = depth_clamp_range.unwrap_or(vk::DepthClampRangeEXT {
        min_depth_clamp: 0.0,
        max_depth_clamp: 0.0,
    });
    let mut depth_clamp_control_info = vk::PipelineViewportDepthClampControlCreateInfoEXT {
        s_type: vk::StructureType::PIPELINE_VIEWPORT_DEPTH_CLAMP_CONTROL_CREATE_INFO_EXT,
        next: std::ptr::null(),
        depth_clamp_mode,
        depth_clamp_range: if depth_clamp_range.is_some() {
            &depth_clamp_range_storage
        } else {
            std::ptr::null()
        },
    };
    if state.depth_clamp_control.is_some() {
        viewport_state = viewport_state.push_next(&mut depth_clamp_control_info);
    }
    let mut depth_clip_control_info = vk::PipelineViewportDepthClipControlCreateInfoEXT::builder()
        .negative_one_to_one(state.depth_clip_control.unwrap_or(false));
    if state.depth_clip_control.is_some() {
        viewport_state = viewport_state.push_next(&mut depth_clip_control_info);
    }

    let mut sample_locations_state = vk::PipelineSampleLocationsStateCreateInfoEXT::default();
    if let Some((enable, info)) = state.sample_locations {
        sample_locations_state.sample_locations_enable = vk::Bool32::from(enable);
        sample_locations_state.sample_locations_info = info;
    }
    // Two words, so that a 64 sample pipeline reads both from the pointer
    let sample_masks = [state.sample_mask.unwrap_or(0xFFFF_FFFF); 2];
    let mut multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(state.samples)
        .sample_shading_enable(state.sample_shading)
        .min_sample_shading(state.min_sample_shading)
        .alpha_to_coverage_enable(state.alpha_to_coverage_enable)
        .alpha_to_one_enable(state.alpha_to_one_enable);
    if state.sample_mask.is_some() {
        multisample_state = multisample_state.sample_mask(&sample_masks);
    }
    if state.sample_locations.is_some() {
        multisample_state = multisample_state.push_next(&mut sample_locations_state);
    }
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&state.dynamic_states);
    let mut domain_origin_info = vk::PipelineTessellationDomainOriginStateCreateInfo::builder().domain_origin(
        state
            .tessellation_domain_origin
            .unwrap_or(vk::TessellationDomainOrigin::UPPER_LEFT),
    );
    let mut tessellation_state = vk::PipelineTessellationStateCreateInfo::builder()
        .patch_control_points(state.patch_control_points.unwrap_or(0));
    if state.tessellation_domain_origin.is_some() {
        tessellation_state = tessellation_state.push_next(&mut domain_origin_info);
    }

    let color_formats_owned: Vec<vk::Format> = if !state.rendering_formats.is_empty() {
        state.rendering_formats.clone()
    } else if state.color_attachment_count == 0 {
        Vec::new()
    } else {
        vec![state.rendering_format.unwrap_or(vk::Format::UNDEFINED)]
    };
    let color_formats: &[vk::Format] = &color_formats_owned;
    let mut rendering_create_info = vk::PipelineRenderingCreateInfo::builder()
        .view_mask(state.view_mask)
        .color_attachment_formats(color_formats)
        .depth_attachment_format(state.depth_rendering_format)
        .stencil_attachment_format(state.stencil_rendering_format);

    let line_state = vk::PipelineRasterizationLineStateCreateInfoKHR::builder()
        .line_rasterization_mode(
            state
                .line_rasterization_mode
                .unwrap_or(vk::LineRasterizationMode::DEFAULT),
        )
        .stippled_line_enable(false)
        .line_stipple_factor(0)
        .line_stipple_pattern(0);
    let mut rasterization = state.rasterization;
    if state.line_rasterization_mode.is_some() {
        rasterization.next = (&*line_state as *const vk::PipelineRasterizationLineStateCreateInfoKHR).cast();
    }
    let mut provoking_vertex_info = vk::PipelineRasterizationProvokingVertexStateCreateInfoEXT::default();
    if let Some(mode) = state.provoking_vertex_mode {
        provoking_vertex_info.provoking_vertex_mode = mode;
        provoking_vertex_info.next = rasterization.next;
        rasterization.next =
            (&provoking_vertex_info as *const vk::PipelineRasterizationProvokingVertexStateCreateInfoEXT).cast();
    }

    let mut flags2_info = vk::PipelineCreateFlags2CreateInfo::builder()
        .flags(state.create_flags2.unwrap_or_else(vk::PipelineCreateFlags2::empty));
    let mut binary_chain =
        vk::PipelineBinaryInfoKHR::builder().pipeline_binaries(state.binary_info.as_deref().unwrap_or(&[]));
    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .flags(state.create_flags)
        .stages(&stage_infos)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample_state)
        .depth_stencil_state(&state.depth_stencil)
        .layout(layout)
        .render_pass(render_pass)
        .subpass(state.subpass)
        .base_pipeline_handle(state.base_pipeline.map_or(vk::Pipeline::null(), |(handle, _)| handle))
        .base_pipeline_index(state.base_pipeline.map_or(0, |(_, index)| index));
    if state.color_attachment_count > 0 {
        info = info.color_blend_state(&color_blend_state);
    }
    if !state.dynamic_states.is_empty() {
        info = info.dynamic_state(&dynamic_state);
    }
    if state.patch_control_points.is_some() {
        info = info.tessellation_state(&tessellation_state);
    }
    if state.rendering_format.is_some() {
        info = info.push_next(&mut rendering_create_info);
    }
    let mut attachment_location_info = vk::RenderingAttachmentLocationInfo::builder()
        .color_attachment_locations(state.rendering_attachment_locations.as_deref().unwrap_or(&[]));
    if state.rendering_attachment_locations.is_some() {
        info = info.push_next(&mut attachment_location_info);
    }
    let mut shading_rate_info = vk::PipelineFragmentShadingRateStateCreateInfoKHR::builder()
        .fragment_size(vk::Extent2D { width: 2, height: 2 })
        .combiner_ops([
            vk::FragmentShadingRateCombinerOpKHR::KEEP,
            vk::FragmentShadingRateCombinerOpKHR::KEEP,
        ]);
    if state.fragment_shading_rate || crate::vkt::tests::pipeline::fsr_ambient::ambient_fragment_shading_rate() {
        info = info.push_next(&mut shading_rate_info);
    }
    let mut custom_shading_rate_info = state.fragment_shading_rate_state.unwrap_or_default();
    if state.fragment_shading_rate_state.is_some() {
        info = info.push_next(&mut custom_shading_rate_info);
    }
    if state.create_flags2.is_some() {
        info = info.push_next(&mut flags2_info);
    }
    let discard_rectangle_info =
        state
            .discard_rectangles
            .as_ref()
            .map(|discard| vk::PipelineDiscardRectangleStateCreateInfoEXT {
                s_type: vk::StructureType::PIPELINE_DISCARD_RECTANGLE_STATE_CREATE_INFO_EXT,
                next: std::ptr::null(),
                flags: vk::PipelineDiscardRectangleStateCreateFlagsEXT::empty(),
                discard_rectangle_mode: discard.mode,
                discard_rectangle_count: discard.count,
                discard_rectangles: if discard.dynamic {
                    std::ptr::null()
                } else {
                    discard.rectangles.as_ptr()
                },
            });
    let mut discard_rectangle_info = discard_rectangle_info.unwrap_or_default();
    if state.discard_rectangles.is_some() {
        info = info.push_next(&mut discard_rectangle_info);
    }

    let mut pipeline_robustness_info = state.pipeline_robustness.unwrap_or_default();
    if state.pipeline_robustness.is_some() {
        info = info.push_next(&mut pipeline_robustness_info);
    }
    let mut creation_feedback_info = state.creation_feedback.unwrap_or_default();
    if state.creation_feedback.is_some() {
        info = info.push_next(&mut creation_feedback_info);
    }

    if state.binary_info.is_some() {
        info = info.push_next(&mut binary_chain);
    }

    // A case run with the pipelines of a library construction type has it ambient; a state that names one itself wins.
    let construction = if state.construction != PipelineConstructionType::Monolithic {
        state.construction
    } else {
        crate::vk::pipeline_construction::ambient_construction_type()
    };
    if construction.is_shader_object() {
        return Err(TestError::NotPorted(
            "a case that builds a graphics pipeline cannot run with shader objects".to_string(),
        ));
    }
    if construction != PipelineConstructionType::Monolithic {
        let shading_rate = if state.fragment_shading_rate_state.is_some() {
            Some(&custom_shading_rate_info)
        } else if state.fragment_shading_rate {
            Some(&*shading_rate_info)
        } else {
            None
        };
        let parts = PipelineParts {
            flags: state.create_flags,
            layout,
            render_pass,
            subpass: state.subpass,
            stages: &stage_infos,
            vertex_input: &vertex_input_state,
            input_assembly: &input_assembly_state,
            tessellation: if state.patch_control_points.is_some() {
                Some(&tessellation_state)
            } else {
                None
            },
            viewport: &viewport_state,
            rasterization: &rasterization,
            multisample: &multisample_state,
            depth_stencil: &state.depth_stencil,
            color_blend: if state.color_attachment_count > 0 {
                Some(&color_blend_state)
            } else {
                None
            },
            dynamic: if state.dynamic_states.is_empty() {
                None
            } else {
                Some(&dynamic_state)
            },
            rendering: if state.rendering_format.is_some() {
                Some(&rendering_create_info)
            } else {
                None
            },
            fragment_shading_rate: shading_rate,
        };
        return create_linked_pipeline(device, construction, &parts);
    }

    if state.check_pipeline_key {
        let create_info_khr = vk::PipelineCreateInfoKHR {
            next: (&*info as *const vk::GraphicsPipelineCreateInfo).cast_mut().cast(),
            ..Default::default()
        };
        let mut pipeline_key = vk::PipelineBinaryKeyKHR::default();
        let result =
            unsafe { (device.commands().get_pipeline_key_khr)(device.handle(), &create_info_khr, &mut pipeline_key) };
        if result != vk::Result::SUCCESS {
            return Err(TestError::Fail(format!("vkGetPipelineKeyKHR returned {result:?}")));
        }
        if pipeline_key.key_size == 0 {
            return Err(TestError::Fail("vkGetPipelineKeyKHR returned keySize == 0".to_string()));
        }
    }

    let mut create_info = info.build();
    if state.null_input_assembly_state {
        create_info.input_assembly_state = std::ptr::null();
    }
    let pipelines = unsafe { device.create_graphics_pipelines(state.pipeline_cache, &[create_info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// Everything `DrawRecorder` needs to know about the target of a draw.
pub struct DrawRecorder<'a> {
    pub device: &'a Device,
    pub group_params: GroupParams,
    pub format: vk::Format,
    pub image_view: vk::ImageView,
    pub render_area: vk::Rect2D,
    pub clear_value: vk::ClearValue,
    pub image_layout: vk::ImageLayout,
    pub load_op: vk::AttachmentLoadOp,
    /// Null with dynamic rendering.
    pub render_pass: vk::RenderPass,
    pub framebuffer: vk::Framebuffer,
    pub layer_count: u32,
    pub view_mask: u32,
}

impl DrawRecorder<'_> {
    fn begin_secondary(
        &self,
        sec_cmd_buffer: vk::CommandBuffer,
        rendering_flags: vk::RenderingFlags,
    ) -> Result<(), TestError> {
        let color_formats = [self.format];
        let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
            .flags(rendering_flags)
            .view_mask(self.view_mask)
            .color_attachment_formats(&color_formats)
            .depth_attachment_format(vk::Format::UNDEFINED)
            .stencil_attachment_format(vk::Format::UNDEFINED)
            .rasterization_samples(vk::SampleCountFlags::_1);
        let inheritance_info = vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);

        let mut usage_flags = vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT;
        if !self
            .group_params
            .secondary_cmd_buffer_completely_contains_dynamic_renderpass
        {
            usage_flags |= vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE;
        }
        let begin_info = vk::CommandBufferBeginInfo::builder()
            .flags(usage_flags)
            .inheritance_info(&inheritance_info);
        unsafe { self.device.begin_command_buffer(sec_cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")
    }

    fn begin_dynamic(&self, cmd_buffer: vk::CommandBuffer, flags: vk::RenderingFlags) {
        begin_rendering(
            self.device,
            cmd_buffer,
            self.image_view,
            self.render_area,
            self.clear_value,
            self.image_layout,
            self.load_op,
            flags,
            self.layer_count,
            self.view_mask,
        );
    }

    /// Records `cmd_buffer` for whichever of the three rendering modes the group parameters name. `pre` runs in the
    /// primary command buffer before rendering begins, `draw` inside the rendering (in the secondary command
    /// buffer when there is one), and `post` after it ends.
    pub fn record(
        &self,
        cmd_buffer: vk::CommandBuffer,
        sec_cmd_buffer: Option<vk::CommandBuffer>,
        pre: impl FnOnce(vk::CommandBuffer),
        mut draw: impl FnMut(vk::CommandBuffer) -> Result<(), TestError>,
        post: impl FnOnce(vk::CommandBuffer),
    ) -> Result<(), TestError> {
        let device = self.device;
        let params = self.group_params;

        if params.use_secondary_cmd_buffer {
            let sec = sec_cmd_buffer.expect("secondary command buffer");
            let contains = params.secondary_cmd_buffer_completely_contains_dynamic_renderpass;

            // record secondary command buffer
            if contains {
                self.begin_secondary(sec, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)?;
                self.begin_dynamic(sec, vk::RenderingFlags::empty());
            } else {
                self.begin_secondary(sec, vk::RenderingFlags::empty())?;
            }

            draw(sec)?;

            if contains {
                end_rendering(device, sec);
            }
            end_command_buffer(device, sec)?;

            // record primary command buffer
            begin_command_buffer(device, cmd_buffer)?;
            pre(cmd_buffer);

            if !contains {
                self.begin_dynamic(cmd_buffer, vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS);
            }

            unsafe { device.cmd_execute_commands(cmd_buffer, &[sec]) };

            if !contains {
                end_rendering(device, cmd_buffer);
            }

            post(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
        } else if params.use_dynamic_rendering {
            begin_command_buffer(device, cmd_buffer)?;
            pre(cmd_buffer);
            self.begin_dynamic(cmd_buffer, vk::RenderingFlags::empty());
            draw(cmd_buffer)?;
            end_rendering(device, cmd_buffer);
            post(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
        } else {
            begin_command_buffer(device, cmd_buffer)?;
            pre(cmd_buffer);

            let clear_values = [self.clear_value];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(self.render_pass)
                .framebuffer(self.framebuffer)
                .render_area(self.render_area)
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd_buffer, &begin_info, vk::SubpassContents::INLINE) };
            draw(cmd_buffer)?;
            unsafe { device.cmd_end_render_pass(cmd_buffer) };

            post(cmd_buffer);
            end_command_buffer(device, cmd_buffer)?;
        }
        Ok(())
    }
}

/// `Draw::initialTransitionColor2DImage` + `vkCmdClearColorImage` + the barrier into attachment use, as
/// `preRenderCommands` / `DrawTestsBaseClass::preRenderBarriers` write it: the image ends in GENERAL.
pub fn pre_render_clear_general(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    clear_color: [f32; 4],
) {
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let to_general = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        image,
        range,
    );
    let clear_value = vk::ClearColorValue { float32: clear_color };
    let mem_barrier = vk::MemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[to_general],
        );
        device.cmd_clear_color_image(cmd_buffer, image, vk::ImageLayout::GENERAL, &clear_value, &[range]);
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[mem_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// The same clear for an image that goes UNDEFINED -> TRANSFER_DST -> COLOR_ATTACHMENT_OPTIMAL (the offscreen
/// viewport test clears "outside the render pass" this way).
pub fn pre_render_clear_attachment_optimal(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    clear_color: [f32; 4],
) {
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let pre_clear = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::TRANSFER_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        image,
        range,
    );
    let post_clear = make_image_memory_barrier(
        vk::AccessFlags::TRANSFER_WRITE,
        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::TRANSFER_DST_OPTIMAL,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        image,
        range,
    );
    let clear_value = vk::ClearColorValue { float32: clear_color };
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_clear],
        );
        device.cmd_clear_color_image(
            cmd_buffer,
            image,
            vk::ImageLayout::TRANSFER_DST_OPTIMAL,
            &clear_value,
            &[range],
        );
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_clear],
        );
    }
}

/// Copies a colour image that is still in GENERAL to `buffer`, with the barrier that makes the write visible to the host.
pub fn copy_general_image_to_buffer(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    buffer: vk::Buffer,
    width: u32,
    height: u32,
) {
    let copy_region = crate::vk::image_util::make_buffer_image_copy(
        vk::Extent3D {
            width,
            height,
            depth: 1,
        },
        crate::vk::image_util::make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
    );
    let to_transfer = vk::MemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::MEMORY_WRITE)
        .dst_access_mask(vk::AccessFlags::TRANSFER_READ)
        .build();
    let to_host = vk::MemoryBarrier::builder()
        .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
        .dst_access_mask(vk::AccessFlags::HOST_READ)
        .build();
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::ALL_COMMANDS,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[to_transfer],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
        device.cmd_copy_image_to_buffer(cmd_buffer, image, vk::ImageLayout::GENERAL, buffer, &[copy_region]);
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}
