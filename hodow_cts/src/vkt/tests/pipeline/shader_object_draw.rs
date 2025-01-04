// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/framework/vulkan/vkPipelineConstructionUtil.cpp (`GraphicsPipelineWrapper` for the shader object construction
//   types: `createShaders`, `makeShaderCreateInfo`, `bind` and `setShaderObjectDynamicStates`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The wrapper does not exist as such here: a case that supports the shader object
// construction types builds a `ShaderObjectDraw` where it would call `create_draw_pipeline`, and where it would bind the pipeline
// it calls `bind` with the same `DrawPipelineState`, which sets every state a pipeline would have held. Shader objects can only
// draw inside dynamic rendering, so such a case also begins rendering with `begin_dynamic_rendering` in place of its render pass.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtColorWriteEnableExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands,
    KhrFragmentShadingRateExtensionDeviceCommands,
};

use crate::tcu::TestError;
use crate::vk::VkResultExt;
use crate::vk::pipeline_construction::PipelineConstructionType;
use crate::vk::programs::ProgramBinary;
use crate::vkt::Context;
use crate::vkt::tests::draw::util::DrawPipelineState;
use crate::vkt::tests::shader_object::util::{
    ShaderObject, bind_graphics_shaders, get_mesh_shader_features, get_shader_binary_data,
    get_shader_object_next_stages, set_default_shader_object_dynamic_states, shader_create_info,
};

type Code = (vk::ShaderCodeTypeEXT, usize, *const std::ffi::c_void);

/// The shader objects of a draw: the vertex stage, then the optional tessellation, geometry and fragment ones.
pub struct ShaderObjectDraw<'a> {
    context: &'a Context<'a>,
    shaders: Vec<(vk::ShaderStageFlags, ShaderObject<'a>)>,
}

impl<'a> ShaderObjectDraw<'a> {
    /// `createShaders(linked, binary)` for a vertex shader and an optional fragment shader.
    pub fn new(
        context: &'a Context<'a>,
        construction: PipelineConstructionType,
        vert: ProgramBinary,
        frag: Option<ProgramBinary>,
        set_layouts: &[vk::DescriptorSetLayout],
        push_constant_ranges: &[vk::PushConstantRange],
    ) -> Result<Self, TestError> {
        let mut stages = vec![(vk::ShaderStageFlags::VERTEX, vert)];
        if let Some(frag) = frag {
            stages.push((vk::ShaderStageFlags::FRAGMENT, frag));
        }
        Self::new_stages(context, construction, stages, set_layouts, push_constant_ranges)
    }

    /// `createShaders(linked, binary)`: every stage in one call (with the link flag when linked), and for the binary types
    /// created again from the binaries of the first ones. `stages` is in pipeline order. Each takes the set layouts and push
    /// constant ranges of the draw, as `makeShaderCreateInfo` copies the other shader's layout into a shader created without one.
    pub fn new_stages(
        context: &'a Context<'a>,
        construction: PipelineConstructionType,
        stages: Vec<(vk::ShaderStageFlags, ProgramBinary)>,
        set_layouts: &[vk::DescriptorSetLayout],
        push_constant_ranges: &[vk::PushConstantRange],
    ) -> Result<Self, TestError> {
        Self::new_stages_specialized(context, construction, stages, set_layouts, push_constant_ranges, None)
    }

    /// `new_stages` with one specialization info for every stage (as the draw pipeline helper applies one), given to the SPIR-V
    /// creation only: a binary has the constants baked in.
    pub fn new_stages_specialized(
        context: &'a Context<'a>,
        construction: PipelineConstructionType,
        stages: Vec<(vk::ShaderStageFlags, ProgramBinary)>,
        set_layouts: &[vk::DescriptorSetLayout],
        push_constant_ranges: &[vk::PushConstantRange],
        specialization: Option<(&[vk::SpecializationMapEntry], &[u8])>,
    ) -> Result<Self, TestError> {
        let device = context.get_device();
        let specialization_info = specialization.map(|(entries, data)| {
            vk::SpecializationInfo::builder()
                .map_entries(entries)
                .data(data)
                .build()
        });
        let specialization_ptr: *const vk::SpecializationInfo = specialization_info
            .as_ref()
            .map_or(std::ptr::null(), |info| info as *const vk::SpecializationInfo);
        let features = context.get_device_features();
        let linked = construction.is_shader_object_linked();
        let flags = if linked {
            vk::ShaderCreateFlagsEXT::LINK_STAGE
        } else {
            vk::ShaderCreateFlagsEXT::empty()
        };
        let has_fragment = stages.iter().any(|(stage, _)| *stage == vk::ShaderStageFlags::FRAGMENT);
        let next_stage = |index: usize| -> vk::ShaderStageFlags {
            if index + 1 == stages.len() {
                vk::ShaderStageFlags::empty()
            } else if linked {
                stages[index + 1].0
            } else if has_fragment {
                get_shader_object_next_stages(
                    stages[index].0,
                    features.tessellation_shader == vk::TRUE,
                    features.geometry_shader == vk::TRUE,
                )
            } else {
                vk::ShaderStageFlags::empty()
            }
        };

        let create =
            |codes: &[(vk::ShaderStageFlags, Code)], specialize: bool| -> Result<Vec<ShaderObject<'a>>, TestError> {
                let infos: Vec<vk::ShaderCreateInfoEXT> = codes
                    .iter()
                    .enumerate()
                    .map(|(index, (stage, code))| {
                        let mut info = shader_create_info(
                            flags,
                            *stage,
                            next_stage(index),
                            code.0,
                            code.1,
                            code.2,
                            set_layouts,
                            push_constant_ranges,
                        );
                        if specialize {
                            info.specialization_info = specialization_ptr;
                        }
                        info
                    })
                    .collect();
                let (handles, _) = unsafe { device.create_shaders_ext(&infos, None) }.vk_check("vkCreateShadersEXT")?;
                Ok(handles
                    .into_iter()
                    .map(|handle| ShaderObject::new(device, handle))
                    .collect())
            };

        let spirv: Vec<(vk::ShaderStageFlags, Code)> = stages
            .iter()
            .map(|(stage, binary)| {
                (
                    *stage,
                    (
                        vk::ShaderCodeTypeEXT::SPIRV,
                        std::mem::size_of_val(binary.spirv),
                        binary.spirv.as_ptr().cast(),
                    ),
                )
            })
            .collect();
        let created = create(&spirv, true)?;
        if !construction.is_shader_object_binary() {
            return Ok(Self {
                context,
                shaders: stages.iter().map(|(stage, _)| *stage).zip(created).collect(),
            });
        }

        let binaries: Vec<Vec<u8>> = created
            .iter()
            .map(|shader| get_shader_binary_data(device, shader.get()))
            .collect::<Result<_, _>>()?;
        let binary_codes: Vec<(vk::ShaderStageFlags, Code)> = stages
            .iter()
            .zip(&binaries)
            .map(|((stage, _), data)| {
                (
                    *stage,
                    (vk::ShaderCodeTypeEXT::BINARY, data.len(), data.as_ptr().cast()),
                )
            })
            .collect();
        let recreated = create(&binary_codes, false)?;
        Ok(Self {
            context,
            shaders: stages.iter().map(|(stage, _)| *stage).zip(recreated).collect(),
        })
    }

    pub fn fragment_handle(&self) -> vk::ShaderEXT {
        self.handle(vk::ShaderStageFlags::FRAGMENT)
    }

    fn handle(&self, stage: vk::ShaderStageFlags) -> vk::ShaderEXT {
        self.shaders
            .iter()
            .find(|(candidate, _)| *candidate == stage)
            .map_or(vk::ShaderEXT::null(), |(_, shader)| shader.get())
    }

    /// `GraphicsPipelineWrapper::bind`: the shaders, then every dynamic state from `state`.
    pub fn bind(&self, cmd: vk::CommandBuffer, state: &DrawPipelineState) {
        let context = self.context;
        let device = context.get_device();

        let (width, height) = state
            .viewports
            .first()
            .map_or((1, 1), |viewport| (viewport.width as u32, viewport.height as u32));
        let mesh_features = get_mesh_shader_features(context);
        bind_graphics_shaders(
            device,
            cmd,
            self.handle(vk::ShaderStageFlags::VERTEX),
            self.handle(vk::ShaderStageFlags::TESSELLATION_CONTROL),
            self.handle(vk::ShaderStageFlags::TESSELLATION_EVALUATION),
            self.handle(vk::ShaderStageFlags::GEOMETRY),
            self.handle(vk::ShaderStageFlags::FRAGMENT),
            mesh_features.task_shader == vk::TRUE,
            mesh_features.mesh_shader == vk::TRUE,
        );
        let mesh = self.handle(vk::ShaderStageFlags::MESH_EXT);
        if mesh != vk::ShaderEXT::null() {
            unsafe { device.cmd_bind_shaders_ext(cmd, &[vk::ShaderStageFlags::MESH_EXT], &[mesh]) };
        }

        set_default_shader_object_dynamic_states(
            device,
            cmd,
            context.get_device_extensions(),
            state.topology,
            false,
            true,
            width,
            height,
        );
        set_dynamic_states_from_pipeline_state(device, cmd, state);
    }
}

/// `setShaderObjectDynamicStates` after the defaults: the states a `DrawPipelineState` names, as dynamic commands.
pub fn set_dynamic_states_from_pipeline_state(device: &Device, cmd: vk::CommandBuffer, state: &DrawPipelineState) {
    let rasterization = &state.rasterization;
    let depth_stencil = &state.depth_stencil;

    unsafe {
        if let Some(color_write_enables) = &state.color_write_enables {
            device.cmd_set_color_write_enable_ext(cmd, color_write_enables);
        }
        if !state.viewports.is_empty() {
            device.cmd_set_viewport_with_count_ext(cmd, &state.viewports);
            device.cmd_set_viewport(cmd, 0, &state.viewports);
        }
        if !state.scissors.is_empty() {
            device.cmd_set_scissor_with_count_ext(cmd, &state.scissors);
            device.cmd_set_scissor(cmd, 0, &state.scissors);
        }

        // Vertex input
        let bindings: Vec<vk::VertexInputBindingDescription2EXT> = state
            .bindings
            .iter()
            .map(|binding| vk::VertexInputBindingDescription2EXT {
                s_type: vk::StructureType::VERTEX_INPUT_BINDING_DESCRIPTION_2_EXT,
                next: std::ptr::null_mut(),
                binding: binding.binding,
                stride: binding.stride,
                input_rate: binding.input_rate,
                divisor: state
                    .vertex_divisors
                    .iter()
                    .find(|divisor| divisor.binding == binding.binding)
                    .map_or(1, |divisor| divisor.divisor),
            })
            .collect();
        let attributes: Vec<vk::VertexInputAttributeDescription2EXT> = state
            .attributes
            .iter()
            .map(|attribute| vk::VertexInputAttributeDescription2EXT {
                s_type: vk::StructureType::VERTEX_INPUT_ATTRIBUTE_DESCRIPTION_2_EXT,
                next: std::ptr::null_mut(),
                location: attribute.location,
                binding: attribute.binding,
                format: attribute.format,
                offset: attribute.offset,
            })
            .collect();
        device.cmd_set_vertex_input_ext(cmd, &bindings, &attributes);
        device.cmd_set_primitive_topology_ext(cmd, state.topology);
        device.cmd_set_primitive_restart_enable_ext(cmd, state.primitive_restart_enable);
        if let Some(control_points) = state.patch_control_points {
            device.cmd_set_patch_control_points_ext(cmd, control_points);
        }

        // Rasterization
        device.cmd_set_polygon_mode_ext(cmd, rasterization.polygon_mode);
        device.cmd_set_cull_mode_ext(cmd, rasterization.cull_mode);
        device.cmd_set_front_face_ext(cmd, rasterization.front_face);
        device.cmd_set_line_width(cmd, rasterization.line_width);
        device.cmd_set_depth_clamp_enable_ext(cmd, rasterization.depth_clamp_enable == vk::TRUE);
        device.cmd_set_rasterizer_discard_enable_ext(cmd, rasterization.rasterizer_discard_enable == vk::TRUE);
        device.cmd_set_depth_bias_enable_ext(cmd, rasterization.depth_bias_enable == vk::TRUE);
        device.cmd_set_depth_bias(
            cmd,
            rasterization.depth_bias_constant_factor,
            rasterization.depth_bias_clamp,
            rasterization.depth_bias_slope_factor,
        );

        if let Some(negative_one_to_one) = state.depth_clip_control {
            device.cmd_set_depth_clip_negative_one_to_one_ext(cmd, negative_one_to_one);
        }

        // Multisample
        device.cmd_set_rasterization_samples_ext(cmd, state.samples);
        let sample_mask: vk::SampleMask = state.sample_mask.unwrap_or(0xFFFF_FFFF);
        device.cmd_set_sample_mask_ext(cmd, state.samples, Some(&sample_mask));
        device.cmd_set_alpha_to_coverage_enable_ext(cmd, state.alpha_to_coverage_enable);
        device.cmd_set_alpha_to_one_enable_ext(cmd, state.alpha_to_one_enable);

        // Depth and stencil
        device.cmd_set_depth_test_enable_ext(cmd, depth_stencil.depth_test_enable == vk::TRUE);
        device.cmd_set_depth_write_enable_ext(cmd, depth_stencil.depth_write_enable == vk::TRUE);
        device.cmd_set_depth_compare_op_ext(cmd, depth_stencil.depth_compare_op);
        device.cmd_set_depth_bounds_test_enable_ext(cmd, depth_stencil.depth_bounds_test_enable == vk::TRUE);
        device.cmd_set_depth_bounds(cmd, depth_stencil.min_depth_bounds, depth_stencil.max_depth_bounds);
        device.cmd_set_stencil_test_enable_ext(cmd, depth_stencil.stencil_test_enable == vk::TRUE);
        for (face, stencil) in [
            (vk::StencilFaceFlags::FRONT, depth_stencil.front),
            (vk::StencilFaceFlags::BACK, depth_stencil.back),
        ] {
            device.cmd_set_stencil_op_ext(
                cmd,
                face,
                stencil.fail_op,
                stencil.pass_op,
                stencil.depth_fail_op,
                stencil.compare_op,
            );
            device.cmd_set_stencil_compare_mask(cmd, face, stencil.compare_mask);
            device.cmd_set_stencil_write_mask(cmd, face, stencil.write_mask);
            device.cmd_set_stencil_reference(cmd, face, stencil.reference);
        }

        // Color blend
        device.cmd_set_logic_op_enable_ext(cmd, state.logic_op.is_some());
        device.cmd_set_logic_op_ext(cmd, state.logic_op.unwrap_or(vk::LogicOp::COPY));
        device.cmd_set_blend_constants(cmd, state.blend_constants);

        let default_attachment = vk::PipelineColorBlendAttachmentState {
            blend_enable: vk::FALSE,
            src_color_blend_factor: vk::BlendFactor::SRC_COLOR,
            dst_color_blend_factor: vk::BlendFactor::DST_COLOR,
            color_blend_op: vk::BlendOp::ADD,
            src_alpha_blend_factor: vk::BlendFactor::SRC_COLOR,
            dst_alpha_blend_factor: vk::BlendFactor::DST_COLOR,
            alpha_blend_op: vk::BlendOp::ADD,
            color_write_mask: vk::ColorComponentFlags::all(),
        };
        let attachments: Vec<vk::PipelineColorBlendAttachmentState> = if state.color_blend_attachments.is_empty() {
            vec![state.color_blend_attachment.unwrap_or(default_attachment); state.color_attachment_count as usize]
        } else {
            state.color_blend_attachments.clone()
        };
        for (index, attachment) in attachments.iter().enumerate() {
            let index = index as u32;
            device.cmd_set_color_blend_enable_ext(cmd, index, &[attachment.blend_enable]);
            device.cmd_set_color_write_mask_ext(cmd, index, &[attachment.color_write_mask]);

            // The advanced operations (VK_BLEND_OP_ZERO_EXT and up) cannot go through the blend equation.
            if let (Some((src_premultiplied, dst_premultiplied, overlap)), true) = (
                state.color_blend_advanced,
                attachment.color_blend_op.as_raw() >= vk::BlendOp::ZERO_EXT.as_raw(),
            ) {
                let advanced = vk::ColorBlendAdvancedEXT {
                    advanced_blend_op: attachment.color_blend_op,
                    src_premultiplied: vk::Bool32::from(src_premultiplied),
                    dst_premultiplied: vk::Bool32::from(dst_premultiplied),
                    blend_overlap: overlap,
                    clamp_results: vk::FALSE,
                };
                device.cmd_set_color_blend_advanced_ext(cmd, index, &[advanced]);
            } else {
                let equation = vk::ColorBlendEquationEXT {
                    src_color_blend_factor: attachment.src_color_blend_factor,
                    dst_color_blend_factor: attachment.dst_color_blend_factor,
                    color_blend_op: attachment.color_blend_op,
                    src_alpha_blend_factor: attachment.src_alpha_blend_factor,
                    dst_alpha_blend_factor: attachment.dst_alpha_blend_factor,
                    alpha_blend_op: attachment.alpha_blend_op,
                };
                device.cmd_set_color_blend_equation_ext(cmd, index, &[equation]);
            }
        }

        let keep = [vk::FragmentShadingRateCombinerOpKHR::KEEP; 2];
        if state.fragment_shading_rate || crate::vkt::tests::pipeline::fsr_ambient::ambient_fragment_shading_rate() {
            device.cmd_set_fragment_shading_rate_khr(cmd, &vk::Extent2D { width: 2, height: 2 }, keep);
        } else if let Some(custom) = &state.fragment_shading_rate_state {
            device.cmd_set_fragment_shading_rate_khr(cmd, &custom.fragment_size, custom.combiner_ops);
        }
    }
}

/// One attachment of `begin_dynamic_rendering`.
#[derive(Clone, Copy)]
pub struct RenderingAttachment {
    pub view: vk::ImageView,
    pub layout: vk::ImageLayout,
    pub clear_value: vk::ClearValue,
}

/// `vkCmdBeginRendering` for what a case's render pass and framebuffer held: the colour attachments, and the depth and
/// stencil attachments when its format has them (the same view twice for a combined format), all cleared and stored.
pub fn begin_dynamic_rendering(
    device: &Device,
    cmd: vk::CommandBuffer,
    render_area: vk::Rect2D,
    colors: &[RenderingAttachment],
    depth: Option<RenderingAttachment>,
    stencil: Option<RenderingAttachment>,
) {
    begin_dynamic_rendering_with_load_op(
        device,
        cmd,
        render_area,
        colors,
        depth,
        stencil,
        vk::AttachmentLoadOp::CLEAR,
    );
}

/// `begin_dynamic_rendering` with the load operation of every attachment given (the clear values only matter for CLEAR).
pub fn begin_dynamic_rendering_with_load_op(
    device: &Device,
    cmd: vk::CommandBuffer,
    render_area: vk::Rect2D,
    colors: &[RenderingAttachment],
    depth: Option<RenderingAttachment>,
    stencil: Option<RenderingAttachment>,
    load_op: vk::AttachmentLoadOp,
) {
    begin_dynamic_rendering_with_load_ops(device, cmd, render_area, colors, depth, stencil, load_op, load_op);
}

/// `begin_dynamic_rendering` with one load operation for the colour attachments and one for the depth and stencil ones.
#[allow(clippy::too_many_arguments)]
pub fn begin_dynamic_rendering_with_load_ops(
    device: &Device,
    cmd: vk::CommandBuffer,
    render_area: vk::Rect2D,
    colors: &[RenderingAttachment],
    depth: Option<RenderingAttachment>,
    stencil: Option<RenderingAttachment>,
    color_load_op: vk::AttachmentLoadOp,
    depth_stencil_load_op: vk::AttachmentLoadOp,
) {
    let attachment_info = |attachment: &RenderingAttachment, load_op: vk::AttachmentLoadOp| {
        vk::RenderingAttachmentInfo::builder()
            .image_view(attachment.view)
            .image_layout(attachment.layout)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(load_op)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(attachment.clear_value)
            .build()
    };
    let color_attachments: Vec<vk::RenderingAttachmentInfo> = colors
        .iter()
        .map(|attachment| attachment_info(attachment, color_load_op))
        .collect();
    let depth_attachment = depth
        .as_ref()
        .map(|attachment| attachment_info(attachment, depth_stencil_load_op));
    let stencil_attachment = stencil
        .as_ref()
        .map(|attachment| attachment_info(attachment, depth_stencil_load_op));

    let mut rendering_info = vk::RenderingInfo::builder()
        .render_area(render_area)
        .layer_count(1)
        .view_mask(0)
        .color_attachments(&color_attachments);
    if let Some(depth_attachment) = &depth_attachment {
        rendering_info = rendering_info.depth_attachment(depth_attachment);
    }
    if let Some(stencil_attachment) = &stencil_attachment {
        rendering_info = rendering_info.stencil_attachment(stencil_attachment);
    }
    unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
}

/// `begin_dynamic_rendering` for one colour attachment that is a multisampled image, resolved (averaged) into `resolve_view`
/// when given, both views in the attachment layout.
pub fn begin_dynamic_rendering_resolve(
    device: &Device,
    cmd: vk::CommandBuffer,
    render_area: vk::Rect2D,
    view: vk::ImageView,
    resolve_view: Option<vk::ImageView>,
    clear_value: vk::ClearValue,
) {
    let mut attachment = vk::RenderingAttachmentInfo::builder()
        .image_view(view)
        .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
        .resolve_mode(vk::ResolveModeFlags::NONE)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .clear_value(clear_value);
    if let Some(resolve_view) = resolve_view {
        attachment = attachment
            .resolve_mode(vk::ResolveModeFlags::AVERAGE)
            .resolve_image_view(resolve_view)
            .resolve_image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL);
    }
    let color_attachments = [attachment.build()];
    let rendering_info = vk::RenderingInfo::builder()
        .render_area(render_area)
        .layer_count(1)
        .view_mask(0)
        .color_attachments(&color_attachments);
    unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };
}

/// `vkCmdEndRendering`
pub fn end_dynamic_rendering(device: &Device, cmd: vk::CommandBuffer) {
    unsafe { device.cmd_end_rendering(cmd) };
}

/// The shader objects of the running case when it runs with a shader object construction type, `None` otherwise (a pipeline is
/// made instead).
pub fn make_shader_objects<'a>(
    context: &'a Context<'a>,
    vert: &str,
    frag: Option<&str>,
    set_layouts: &[vk::DescriptorSetLayout],
    push_constant_ranges: &[vk::PushConstantRange],
) -> Result<Option<ShaderObjectDraw<'a>>, TestError> {
    let construction = crate::vk::pipeline_construction::ambient_construction_type();
    if !construction.is_shader_object() {
        return Ok(None);
    }
    let binaries = context.get_binary_collection();
    let fragment = match frag {
        Some(name) => Some(binaries.get(name)?),
        None => None,
    };
    Ok(Some(ShaderObjectDraw::new(
        context,
        construction,
        binaries.get(vert)?,
        fragment,
        set_layouts,
        push_constant_ranges,
    )?))
}

/// Begins the render pass and binds the pipeline, or for shader objects moves the colour images to the attachment layout,
/// begins dynamic rendering over `colors` (image and view; `clear_values[i]` is the clear value of the i-th) and binds the
/// shaders with every state of `state`.
#[allow(clippy::too_many_arguments)]
pub fn begin_draw(
    device: &Device,
    cmd: vk::CommandBuffer,
    shader_objects: Option<&ShaderObjectDraw<'_>>,
    state: &DrawPipelineState,
    pipeline: Option<vk::Pipeline>,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    render_area: vk::Rect2D,
    clear_values: &[vk::ClearValue],
    colors: &[(vk::Image, vk::ImageView)],
) {
    unsafe {
        let Some(shader_objects) = shader_objects else {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(render_pass)
                .framebuffer(framebuffer)
                .render_area(render_area)
                .clear_values(clear_values);
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
            if let Some(pipeline) = pipeline {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline);
            }
            return;
        };

        let barriers: Vec<vk::ImageMemoryBarrier> = colors
            .iter()
            .map(|(image, _)| {
                vk::ImageMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::empty())
                    .dst_access_mask(vk::AccessFlags::COLOR_ATTACHMENT_WRITE)
                    .old_layout(vk::ImageLayout::UNDEFINED)
                    .new_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .image(*image)
                    .subresource_range(vk::ImageSubresourceRange {
                        aspect_mask: vk::ImageAspectFlags::COLOR,
                        base_mip_level: 0,
                        level_count: 1,
                        base_array_layer: 0,
                        layer_count: 1,
                    })
                    .build()
            })
            .collect();
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &barriers,
        );
        let attachments: Vec<RenderingAttachment> = colors
            .iter()
            .enumerate()
            .map(|(index, (_, view))| RenderingAttachment {
                view: *view,
                layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                clear_value: clear_values[index],
            })
            .collect();
        begin_dynamic_rendering(device, cmd, render_area, &attachments, None, None);
        shader_objects.bind(cmd, state);
    }
}

/// `vkCmdEndRenderPass`, or `vkCmdEndRendering` for shader objects.
pub fn end_draw(device: &Device, cmd: vk::CommandBuffer, shader_objects: bool) {
    if shader_objects {
        end_dynamic_rendering(device, cmd);
    } else {
        unsafe { device.cmd_end_render_pass(cmd) };
    }
}

/// `make_shader_objects` for any stages of the draw, in pipeline order, each named by the program of the case's collection.
pub fn make_shader_objects_stages<'a>(
    context: &'a Context<'a>,
    stages: &[(vk::ShaderStageFlags, &str)],
    set_layouts: &[vk::DescriptorSetLayout],
    push_constant_ranges: &[vk::PushConstantRange],
) -> Result<Option<ShaderObjectDraw<'a>>, TestError> {
    let construction = crate::vk::pipeline_construction::ambient_construction_type();
    if !construction.is_shader_object() {
        return Ok(None);
    }
    let binaries = context.get_binary_collection();
    let mut codes = Vec::with_capacity(stages.len());
    for (stage, name) in stages {
        codes.push((*stage, binaries.get(name)?));
    }
    Ok(Some(ShaderObjectDraw::new_stages(
        context,
        construction,
        codes,
        set_layouts,
        push_constant_ranges,
    )?))
}

/// `make_shader_objects_stages` with the specialization of a case (one for every stage).
pub fn make_shader_objects_stages_specialized<'a>(
    context: &'a Context<'a>,
    stages: &[(vk::ShaderStageFlags, &str)],
    set_layouts: &[vk::DescriptorSetLayout],
    push_constant_ranges: &[vk::PushConstantRange],
    specialization: Option<(&[vk::SpecializationMapEntry], &[u8])>,
) -> Result<Option<ShaderObjectDraw<'a>>, TestError> {
    let construction = crate::vk::pipeline_construction::ambient_construction_type();
    if !construction.is_shader_object() {
        return Ok(None);
    }
    let binaries = context.get_binary_collection();
    let mut codes = Vec::with_capacity(stages.len());
    for (stage, name) in stages {
        codes.push((*stage, binaries.get(name)?));
    }
    Ok(Some(ShaderObjectDraw::new_stages_specialized(
        context,
        construction,
        codes,
        set_layouts,
        push_constant_ranges,
        specialization,
    )?))
}
