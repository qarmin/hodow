// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/subgroups/vktSubgroupsTestsUtils.cpp (`allStages`, `allStagesRequiredSubgroupSize`,
//   `getPossibleGraphicsSubgroupStages`, `makeGraphicsPipeline`, `makeRenderPass`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `graphics` groups of the subgroup families: every graphics stage the device
// supports runs the test source and stores one verdict per invocation, in a storage buffer for the vertex, tessellation and geometry
// stages and in a one pixel high R32_UINT image for the fragment stage. The shaders are in `shaders/manifest/subgroups_graphics.toml`;
// upstream builds the stages that depend on shaderTessellationAndGeometryPointSize from the feature `supportedCheck` read, so each
// of them is generated both ways and picked here (the `_ps` programs write gl_PointSize). The stages a case only needs to complete the
// pipeline come from `subgroups_common.toml`. The required subgroup size variants of upstream's graphics tests are not ported.

use vulkanalia::prelude::v1_0::*;

use super::compute_tests::{Params, check_support_common, parse};
use super::framebuffer_tests::check_size_control;
use super::utils::{SsboData, check, initialize_memory, subgroup_properties, subgroup_size_control_properties};
use crate::generated::shaders::subgroups_common::SG_NO_SUBGROUP_PROGRAMS;
use crate::generated::shaders::subgroups_graphics::ALL_SUBGROUP_GRAPHICS_CASE;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestInstance};

/// The `rust_type` of the manifest entries: one test case of the graphics group of a subgroup family.
#[derive(Clone, Copy)]
pub struct SubgroupGraphicsCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

/// The `rust_type` of the stages shared by all of those cases.
#[derive(Clone, Copy)]
pub struct SubgroupCommonPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `getMaxWidth`
pub(super) const MAX_WIDTH: u32 = 1024;

/// The binding of the first input a case declares: the result buffers of the four non-fragment stages come first.
const FIRST_INPUT_BINDING: u32 = 4;

/// `roundUpToPowerOf2`
fn round_up_to_power_of_2(value: u32) -> u32 {
    value.next_power_of_two()
}

/// `getNextWidth`: the next power-of-two, or +/- 1 to ensure we test values either side.
pub(super) fn get_next_width(width: u32) -> u32 {
    let next_pot = round_up_to_power_of_2(width);

    // If this is an exact power-of-two, return width plus 1
    if width == next_pot {
        return width + 1;
    }
    // If this is the next power-of-two minus 1, return next power-of-two
    if width + 1 == next_pot {
        return next_pot;
    }

    // This should be the previous power-of-two plus 1, return next power-of-two minus 1
    next_pot - 1
}

/// `getResultBinding`
fn get_result_binding(stage: vk::ShaderStageFlags) -> u32 {
    if stage == vk::ShaderStageFlags::VERTEX {
        0
    } else if stage == vk::ShaderStageFlags::TESSELLATION_CONTROL {
        1
    } else if stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
        2
    } else {
        debug_assert!(stage == vk::ShaderStageFlags::GEOMETRY);
        3
    }
}

struct SubgroupGraphicsTestCase {
    name: String,
    spec: &'static str,
    programs: BinaryCollection,
}

impl TestCase for SubgroupGraphicsTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = parse(self.spec);
        check_support_common(context, self.spec, &params, vk::ShaderStageFlags::empty())?;
        if let Some(size_control) = &params.size_control {
            // supportedCheckFeatures for ALL_GRAPHICS also needs the tessellation and geometry features
            let features = context.get_device_features();
            if features.tessellation_shader == vk::FALSE || features.geometry_shader == vk::FALSE {
                return Err(TestError::NotSupported(
                    "Device does not support tessellation or geometry shaders".to_string(),
                ));
            }
            size_control.check_support(context, all_graphics_stages())?;
        }

        // supportedCheckShader
        if !subgroup_properties(context)
            .supported_stages
            .intersects(all_graphics_stages())
        {
            return Err(TestError::NotSupported(
                "Subgroup support is not available for test shader stage(s)".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SubgroupGraphicsInstance {
            context,
            params: parse(self.spec),
        })
    }
}

/// `VK_SHADER_STAGE_ALL_GRAPHICS`
fn all_graphics_stages() -> vk::ShaderStageFlags {
    vk::ShaderStageFlags::VERTEX
        | vk::ShaderStageFlags::TESSELLATION_CONTROL
        | vk::ShaderStageFlags::TESSELLATION_EVALUATION
        | vk::ShaderStageFlags::GEOMETRY
        | vk::ShaderStageFlags::FRAGMENT
}

/// `getPossibleGraphicsSubgroupStages`
fn get_possible_graphics_subgroup_stages(
    context: &Context<'_>,
    tested_stages: vk::ShaderStageFlags,
) -> Result<vk::ShaderStageFlags, TestError> {
    let mut stages = tested_stages & subgroup_properties(context).supported_stages;

    if stages != vk::ShaderStageFlags::FRAGMENT
        && context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE
    {
        if !stages.contains(vk::ShaderStageFlags::FRAGMENT) {
            return Err(TestError::NotSupported(
                "Device does not support vertex stage SSBO writes".to_string(),
            ));
        }
        stages = vk::ShaderStageFlags::FRAGMENT;
    }

    if stages.is_empty() {
        return Err(TestError::NotSupported(
            "Subgroup operations are not supported for any graphic shader".to_string(),
        ));
    }

    Ok(stages)
}

struct SubgroupGraphicsInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

impl TestInstance for SubgroupGraphicsInstance<'_> {
    /// `test`, graphics branch
    fn iterate(&mut self) -> TestOutcome {
        let stages = get_possible_graphics_subgroup_stages(self.context, all_graphics_stages())?;
        all_stages(self.context, &self.params, stages)
    }
}

/// `makeRenderPass`: one colour attachment that is cleared, stored and left in the transfer source layout.
pub(super) fn make_render_pass(device: &Device, format: vk::Format) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let color_reference = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
    }];
    let subpass_description = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_reference)
        .build()];
    let subpass_dependencies = [
        vk::SubpassDependency {
            src_subpass: vk::SUBPASS_EXTERNAL,
            dst_subpass: 0,
            src_stage_mask: vk::PipelineStageFlags::BOTTOM_OF_PIPE,
            dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            src_access_mask: vk::AccessFlags::MEMORY_READ,
            dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        },
        vk::SubpassDependency {
            src_subpass: 0,
            dst_subpass: vk::SUBPASS_EXTERNAL,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::BOTTOM_OF_PIPE,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::MEMORY_READ,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        },
    ];
    let attachment_description = [vk::AttachmentDescription {
        flags: vk::AttachmentDescriptionFlags::empty(),
        format,
        samples: vk::SampleCountFlags::_1,
        load_op: vk::AttachmentLoadOp::CLEAR,
        store_op: vk::AttachmentStoreOp::STORE,
        stencil_load_op: vk::AttachmentLoadOp::DONT_CARE,
        stencil_store_op: vk::AttachmentStoreOp::DONT_CARE,
        initial_layout: vk::ImageLayout::UNDEFINED,
        final_layout: vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
    }];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachment_description)
        .subpasses(&subpass_description)
        .dependencies(&subpass_dependencies);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `makeGraphicsPipeline` (the `Context` overload with `frameBufferTests == false`): the given stages over points or patches of one
/// control point, a dynamic viewport and scissor, and one RGBA colour attachment.
fn make_graphics_pipeline<'a>(
    device: &'a Device,
    pipeline_layout: vk::PipelineLayout,
    stage_modules: &[(vk::ShaderStageFlags, vk::ShaderModule)],
    render_pass: vk::RenderPass,
    topology: vk::PrimitiveTopology,
    has_fragment_shader: bool,
    stage_options: Option<(vk::PipelineShaderStageCreateFlags, u32)>,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let entry = c"main";
    // Every stage gets the flags and, when there is one, the required subgroup size of a size control case
    let subgroup_size_info = vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo {
        s_type: vk::StructureType::PIPELINE_SHADER_STAGE_REQUIRED_SUBGROUP_SIZE_CREATE_INFO,
        next: std::ptr::null(),
        required_subgroup_size: stage_options.map_or(0, |(_, size)| size),
    };
    let stages: Vec<vk::PipelineShaderStageCreateInfo> = stage_modules
        .iter()
        .map(|&(stage, module)| {
            let mut info = vk::PipelineShaderStageCreateInfo::builder()
                .stage(stage)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build();
            if let Some((flags, size)) = stage_options {
                info.flags = flags;
                if size != 0 {
                    info.next =
                        (&subgroup_size_info as *const vk::PipelineShaderStageRequiredSubgroupSizeCreateInfo).cast();
                }
            }
            info
        })
        .collect();
    let has_tessellation = stage_modules.iter().any(|&(stage, _)| {
        stage == vk::ShaderStageFlags::TESSELLATION_CONTROL || stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION
    });

    let vertex_input = vk::PipelineVertexInputStateCreateInfo::default();
    let input_assembly = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(topology)
        .primitive_restart_enable(false);
    let tessellation = vk::PipelineTessellationStateCreateInfo::builder().patch_control_points(1);
    let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
        .viewport_count(1)
        .scissor_count(1);
    let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(!has_fragment_shader)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .min_sample_shading(1.0);
    let stencil_op_state = vk::StencilOpState {
        fail_op: vk::StencilOp::KEEP,
        pass_op: vk::StencilOp::KEEP,
        depth_fail_op: vk::StencilOp::KEEP,
        compare_op: vk::CompareOp::NEVER,
        compare_mask: 0,
        write_mask: 0,
        reference: 0,
    };
    let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
        .front(stencil_op_state)
        .back(stencil_op_state)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);
    let color_blend_attachment = [vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::FALSE,
        src_color_blend_factor: vk::BlendFactor::ZERO,
        dst_color_blend_factor: vk::BlendFactor::ZERO,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ZERO,
        dst_alpha_blend_factor: vk::BlendFactor::ZERO,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask: vk::ColorComponentFlags::R
            | vk::ColorComponentFlags::G
            | vk::ColorComponentFlags::B
            | vk::ColorComponentFlags::A,
    }];
    let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op(vk::LogicOp::CLEAR)
        .attachments(&color_blend_attachment);
    let dynamic_states = [vk::DynamicState::VIEWPORT, vk::DynamicState::SCISSOR];
    let dynamic_state = vk::PipelineDynamicStateCreateInfo::builder().dynamic_states(&dynamic_states);

    let mut info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input)
        .input_assembly_state(&input_assembly)
        .viewport_state(&viewport_state)
        .rasterization_state(&rasterization)
        .multisample_state(&multisample)
        .depth_stencil_state(&depth_stencil)
        .color_blend_state(&color_blend)
        .dynamic_state(&dynamic_state)
        .layout(pipeline_layout)
        .render_pass(render_pass)
        .subpass(0);
    if has_tessellation {
        info = info.tessellation_state(&tessellation);
    }

    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

/// `allStagesRequiredSubgroupSize` without a required subgroup size, which is `allStages`.
fn all_stages(context: &Context<'_>, params: &Params, shader_stage_tested: vk::ShaderStageFlags) -> TestOutcome {
    let vk = context.get_device();
    let allocator = context.get_default_allocator();
    let format = vk::Format::R32_UINT;
    let element_size = 4u64;

    let mut stages_vector: Vec<vk::ShaderStageFlags> = Vec::new();
    let mut shader_stage_required = vk::ShaderStageFlags::empty();

    if shader_stage_tested.contains(vk::ShaderStageFlags::VERTEX) {
        stages_vector.push(vk::ShaderStageFlags::VERTEX);
    }
    if shader_stage_tested.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL) {
        stages_vector.push(vk::ShaderStageFlags::TESSELLATION_CONTROL);
        if !shader_stage_tested.contains(vk::ShaderStageFlags::TESSELLATION_EVALUATION) {
            shader_stage_required |= vk::ShaderStageFlags::TESSELLATION_EVALUATION;
        }
        if !shader_stage_tested.contains(vk::ShaderStageFlags::VERTEX) {
            shader_stage_required |= vk::ShaderStageFlags::VERTEX;
        }
    }
    if shader_stage_tested.contains(vk::ShaderStageFlags::TESSELLATION_EVALUATION) {
        stages_vector.push(vk::ShaderStageFlags::TESSELLATION_EVALUATION);
        if !shader_stage_tested.contains(vk::ShaderStageFlags::VERTEX) {
            shader_stage_required |= vk::ShaderStageFlags::VERTEX;
        }
        if !shader_stage_tested.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL) {
            shader_stage_required |= vk::ShaderStageFlags::TESSELLATION_CONTROL;
        }
    }
    if shader_stage_tested.contains(vk::ShaderStageFlags::GEOMETRY) {
        stages_vector.push(vk::ShaderStageFlags::GEOMETRY);
        if !shader_stage_tested.contains(vk::ShaderStageFlags::VERTEX) {
            shader_stage_required |= vk::ShaderStageFlags::VERTEX;
        }
    }
    if shader_stage_tested.contains(vk::ShaderStageFlags::FRAGMENT)
        && !shader_stage_tested.contains(vk::ShaderStageFlags::VERTEX)
    {
        shader_stage_required |= vk::ShaderStageFlags::VERTEX;
    }

    let stages_count = stages_vector.len();
    let geometry_point_size = if context
        .get_device_features()
        .shader_tessellation_and_geometry_point_size
        != vk::FALSE
    {
        "_ps"
    } else {
        ""
    };
    let vert = if shader_stage_required.contains(vk::ShaderStageFlags::VERTEX) {
        "vert_noSubgroup".to_string()
    } else {
        "vert".to_string()
    };
    let tesc = if shader_stage_required.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL) {
        "tesc_noSubgroup".to_string()
    } else {
        format!("tesc{geometry_point_size}")
    };
    let tese = if shader_stage_required.contains(vk::ShaderStageFlags::TESSELLATION_EVALUATION) {
        "tese_noSubgroup".to_string()
    } else {
        format!("tese{geometry_point_size}")
    };

    shader_stage_required |= shader_stage_tested;

    let binaries = context.get_binary_collection();
    let common = SG_NO_SUBGROUP_PROGRAMS.programs;
    let binary = |name: &str| {
        if common.contains(name) {
            common.get(name)
        } else {
            binaries.get(name)
        }
    };

    let mut modules: Vec<(vk::ShaderStageFlags, Unique<'_, vk::ShaderModule>)> = Vec::new();
    modules.push((vk::ShaderStageFlags::VERTEX, create_shader_module(vk, binary(&vert)?)?));
    if shader_stage_required.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL) {
        modules.push((
            vk::ShaderStageFlags::TESSELLATION_CONTROL,
            create_shader_module(vk, binary(&tesc)?)?,
        ));
        modules.push((
            vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            create_shader_module(vk, binary(&tese)?)?,
        ));
    }
    if shader_stage_required.contains(vk::ShaderStageFlags::GEOMETRY) {
        // tessellation shaders output line primitives, otherwise points are processed by the geometry shader
        let topology = if shader_stage_required.contains(vk::ShaderStageFlags::TESSELLATION_EVALUATION) {
            "lines"
        } else {
            "points"
        };
        modules.push((
            vk::ShaderStageFlags::GEOMETRY,
            create_shader_module(vk, binary(&format!("geometry_{topology}{geometry_point_size}"))?)?,
        ));
    }
    let has_fragment_shader = shader_stage_required.contains(vk::ShaderStageFlags::FRAGMENT);
    if has_fragment_shader {
        modules.push((
            vk::ShaderStageFlags::FRAGMENT,
            create_shader_module(vk, binary("fragment")?)?,
        ));
    }

    // The implicit result SSBO we use to store our outputs from the shader
    let mut result_buffers = Vec::with_capacity(stages_count);
    let mut layout_builder = DescriptorSetLayoutBuilder::new();
    for &stage in &stages_vector {
        let shader_size = if stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
            u64::from(MAX_WIDTH) * 2
        } else {
            u64::from(MAX_WIDTH)
        };
        let size = element_size * shader_size;
        result_buffers.push(BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?);
        layout_builder =
            layout_builder.add_indexed_binding(vk::DescriptorType::STORAGE_BUFFER, stage, get_result_binding(stage), 1);
    }

    let descriptor_type = |input: &SsboData| {
        if input.is_ubo() {
            vk::DescriptorType::UNIFORM_BUFFER
        } else {
            vk::DescriptorType::STORAGE_BUFFER
        }
    };
    let mut input_buffers = Vec::with_capacity(params.inputs.len());
    for (i, input) in params.inputs.iter().enumerate() {
        let usage = if input.is_ubo() {
            vk::BufferUsageFlags::UNIFORM_BUFFER
        } else {
            vk::BufferUsageFlags::STORAGE_BUFFER
        };
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(input.size_in_bytes(), usage),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        initialize_memory(context, buffer.get_allocation(), input)?;
        layout_builder = layout_builder.add_indexed_binding(
            descriptor_type(input),
            shader_stage_tested,
            FIRST_INPUT_BINDING + i as u32,
            1,
        );
        input_buffers.push(buffer);
    }

    let descriptor_set_layout = layout_builder.build(vk)?;
    let pipeline_layout = make_pipeline_layout(vk, &[*descriptor_set_layout])?;
    let render_pass = make_render_pass(vk, format)?;

    let stage_modules: Vec<(vk::ShaderStageFlags, vk::ShaderModule)> =
        modules.iter().map(|(stage, module)| (*stage, **module)).collect();
    let topology = if shader_stage_required.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL) {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::POINT_LIST
    };
    let pipeline = make_graphics_pipeline(
        vk,
        *pipeline_layout,
        &stage_modules,
        *render_pass,
        topology,
        has_fragment_shader,
        params.size_control.as_ref().map(|size_control| {
            (
                size_control.flags,
                size_control.required_subgroup_size(context).unwrap_or(0),
            )
        }),
    )?;

    let mut pool_builder = DescriptorPoolBuilder::new();
    for _ in &stages_vector {
        pool_builder = pool_builder.add_type(vk::DescriptorType::STORAGE_BUFFER, 1);
    }
    for input in &params.inputs {
        pool_builder = pool_builder.add_type(descriptor_type(input), 1);
    }
    // A pool without sizes is invalid: a fragment-only case with no inputs has nothing to bind (`inputBuffers.size() > 0`).
    let has_descriptors = stages_count + params.inputs.len() > 0;
    let descriptor_pool = if has_descriptors {
        Some(pool_builder.build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?)
    } else {
        None
    };
    let descriptor_set = match &descriptor_pool {
        Some(pool) => Some(make_descriptor_set(vk, **pool, *descriptor_set_layout)?),
        None => None,
    };

    let result_infos: Vec<vk::DescriptorBufferInfo> = result_buffers
        .iter()
        .zip(&stages_vector)
        .map(|(buffer, &stage)| {
            make_descriptor_buffer_info(
                buffer.get(),
                0,
                if stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
                    element_size * u64::from(MAX_WIDTH) * 2
                } else {
                    element_size * u64::from(MAX_WIDTH)
                },
            )
        })
        .collect();
    let input_infos: Vec<vk::DescriptorBufferInfo> = input_buffers
        .iter()
        .zip(&params.inputs)
        .map(|(buffer, input)| make_descriptor_buffer_info(buffer.get(), 0, input.size_in_bytes()))
        .collect();
    if let Some(descriptor_set) = &descriptor_set {
        let mut update_builder = DescriptorSetUpdateBuilder::new();
        for (i, &stage) in stages_vector.iter().enumerate() {
            update_builder = update_builder.write_single(
                **descriptor_set,
                Location::binding(get_result_binding(stage)),
                vk::DescriptorType::STORAGE_BUFFER,
                &result_infos[i],
            );
        }
        for (i, input) in params.inputs.iter().enumerate() {
            update_builder = update_builder.write_single(
                **descriptor_set,
                Location::binding(FIRST_INPUT_BINDING + i as u32),
                descriptor_type(input),
                &input_infos[i],
            );
        }
        update_builder.update(vk);
    }

    let queue = context.get_universal_queue();
    let queue_family_index = context.get_universal_queue_family_index();
    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = cmd_buffer.get();
    let mut total_iterations = 0u32;
    let mut failed_iterations = 0u32;

    let result_image = ImageWithMemory::new(
        vk,
        allocator,
        make_image_create_info(
            IVec2::new(MAX_WIDTH as i32, 1),
            format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        ),
        MemoryRequirement::ANY,
    )?;
    let subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let result_image_view = make_image_view(
        vk,
        result_image.get(),
        vk::ImageViewType::_2D,
        format,
        subresource_range,
    )?;
    let framebuffer = make_framebuffer(vk, *render_pass, &[*result_image_view], MAX_WIDTH, 1, 1)?;
    let viewport = vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: MAX_WIDTH as f32,
        height: 1.0,
        min_depth: 0.0,
        max_depth: 1.0,
    };
    let scissor = make_rect_2d(0, 0, MAX_WIDTH, 1);
    let image_result_size = element_size * u64::from(MAX_WIDTH);
    let image_buffer_result = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(image_result_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let color_attachment_barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        result_image.get(),
        subresource_range,
    );

    let mut width = 1u32;
    while width < MAX_WIDTH {
        for (buffer, input) in input_buffers.iter().zip(&params.inputs) {
            // re-init the data
            initialize_memory(context, buffer.get_allocation(), input)?;
        }

        total_iterations += 1;

        begin_command_buffer(vk, cmd_buffer)?;
        unsafe {
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[color_attachment_barrier],
            );

            vk.cmd_set_viewport(cmd_buffer, 0, &[viewport]);
            vk.cmd_set_scissor(cmd_buffer, 0, &[scissor]);
        }

        begin_render_pass(
            vk,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, MAX_WIDTH, 1),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: [0.0; 4] },
            },
        );
        unsafe {
            vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            if let Some(descriptor_set) = &descriptor_set {
                vk.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[**descriptor_set],
                    &[],
                );
            }
            vk.cmd_draw(cmd_buffer, width, 1, 0, 0);
        }
        end_render_pass(vk, cmd_buffer);

        // copyImageToBuffer
        unsafe {
            let to_transfer_read = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                result_image.get(),
                subresource_range,
            );
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer_read],
            );
            let copy = make_buffer_image_copy(
                vk::Extent3D {
                    width,
                    height: 1,
                    depth: 1,
                },
                make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            );
            vk.cmd_copy_image_to_buffer(
                cmd_buffer,
                result_image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image_buffer_result.get(),
                &[copy],
            );
            let to_host_read = make_buffer_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::HOST_READ,
                image_buffer_result.get(),
                0,
                vk::WHOLE_SIZE,
            );
            vk.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[to_host_read],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        for (index, (buffer, &stage)) in result_buffers.iter().zip(&stages_vector).enumerate() {
            invalidate_alloc(vk, buffer.get_allocation())?;
            let used_width = if stage == vk::ShaderStageFlags::TESSELLATION_EVALUATION {
                width * 2
            } else {
                width
            };
            // SAFETY: the buffer holds at least `MAX_WIDTH` verdicts and is mapped in full.
            let results = unsafe {
                std::slice::from_raw_parts(
                    buffer.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                    used_width as usize,
                )
            };
            let passed = match &params.size_control {
                // checkVertexPipelineStages reads only the results of the first stage
                Some(size_control) if index == 0 => {
                    let properties = subgroup_size_control_properties(context);
                    check_size_control(
                        results,
                        used_width as usize,
                        properties.min_subgroup_size,
                        properties.max_subgroup_size,
                        size_control.required_subgroup_size(context),
                    )
                }
                Some(_) => true,
                None => check(results, used_width as usize, params.check),
            };
            if !passed {
                failed_iterations += 1;
            }
        }

        if params.size_control.is_none() && shader_stage_tested.contains(vk::ShaderStageFlags::FRAGMENT) {
            invalidate_alloc(vk, image_buffer_result.get_allocation())?;
            // SAFETY: as above, for the buffer the image was copied into.
            let results = unsafe {
                std::slice::from_raw_parts(
                    image_buffer_result
                        .get_allocation()
                        .get_host_ptr()
                        .cast_const()
                        .cast::<u32>(),
                    width as usize,
                )
            };
            if !check(results, width as usize, params.check) {
                failed_iterations += 1;
            }
        }

        width = get_next_width(width);
    }

    if failed_iterations > 0 {
        return Ok(TestStatus::fail(format!(
            "Failed! ({} / {} values passed)",
            total_iterations.saturating_sub(failed_iterations),
            total_iterations
        )));
    }

    Ok(TestStatus::pass("OK"))
}

/// The cases of the graphics groups of the ported families, as the groups of their path below `subgroups` and the case.
pub fn create_graphics_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_SUBGROUP_GRAPHICS_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            segments.remove(0);
            (
                segments,
                Box::new(SubgroupGraphicsTestCase {
                    name: leaf.to_string(),
                    spec: case.spec,
                    programs: case.programs,
                }) as Box<dyn TestCase>,
            )
        })
        .collect()
}
