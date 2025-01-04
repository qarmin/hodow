// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shader_object/vktShaderObjectPipelineInteractionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are `PIPELINE_INTERACTION` and `PIPELINE_INTERACTION_STAGE_BINDING` of
// `shaders/manifest/shader_object_pipeline_interaction.toml`. Pipelines go through `DrawPipelineState`. Where the pipeline's viewports are
// dynamic and `extendedDynamicState` is missing, the viewport state says one viewport instead of upstream's zero (a pipeline with
// `VK_DYNAMIC_STATE_VIEWPORT` and a count of zero is invalid). The unused framebuffer of the render pass cases is not created.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtShaderObjectExtensionDeviceCommands, Handle, InstanceV1_1};

use super::link_tests::{RENDER_SIZE, create_color_target, read_pixels, record_pre_barrier, record_readback};
use super::util::{
    ShaderObject, bind_compute_shader, bind_graphics_shaders, bind_null_task_mesh_shaders, create_shader,
    get_mesh_shader_features, make_shader, make_shader_create_info, remove_unsupported_shader_object_extensions,
    set_default_shader_object_dynamic_states,
};
use crate::generated::shaders::shader_object_pipeline_interaction::{
    PIPELINE_INTERACTION, PIPELINE_INTERACTION_STAGE_BINDING,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_pipeline_layout, make_render_pass_full,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, begin_rendering, create_draw_pipeline, end_rendering, rect_2d, viewport,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    ShaderObject,
    MaxPipeline,
    MaxPipelineShaderObjectMaxPipeline,
    ShaderObjectMaxPipelineShaderObject,
    MinPipelineShaderObject,
    RenderPassPipelineShaderObject,
    RenderPassPipelineShaderObjectAfterBegin,
    ShaderObjectMinPipeline,
    ComputeShaderObjectMinPipeline,
    ShaderObjectComputePipeline,
}

#[derive(Clone, Copy)]
struct StageTestParams {
    vert_shader: bool,
    tess_shader: bool,
    geom_shader: bool,
    frag_shader: bool,
}

fn extension_enabled(extensions: &[String], name: &str) -> bool {
    extensions.iter().any(|extension| extension == name)
}

struct DynamicStateFeatures {
    eds: vk::PhysicalDeviceExtendedDynamicStateFeaturesEXT,
    eds2: vk::PhysicalDeviceExtendedDynamicState2FeaturesEXT,
    eds3: vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT,
    vertex_input: vk::PhysicalDeviceVertexInputDynamicStateFeaturesEXT,
}

fn query_dynamic_state_features(context: &Context<'_>) -> DynamicStateFeatures {
    let mut eds = vk::PhysicalDeviceExtendedDynamicStateFeaturesEXT::default();
    let mut eds2 = vk::PhysicalDeviceExtendedDynamicState2FeaturesEXT::default();
    let mut eds3 = vk::PhysicalDeviceExtendedDynamicState3FeaturesEXT::default();
    let mut vertex_input = vk::PhysicalDeviceVertexInputDynamicStateFeaturesEXT::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder()
            .push_next(&mut eds)
            .push_next(&mut eds2)
            .push_next(&mut eds3)
            .push_next(&mut vertex_input);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    DynamicStateFeatures {
        eds,
        eds2,
        eds3,
        vertex_input,
    }
}

/// The dynamic state list of `ShaderObjectPipelineInteractionInstance::iterate`.
fn build_dynamic_states(features: &DynamicStateFeatures, extensions: &[String]) -> Vec<vk::DynamicState> {
    use vk::DynamicState as D;

    let on = |value: vk::Bool32| value != vk::FALSE;
    let enabled = |name: &str| extension_enabled(extensions, name);
    let eds3 = &features.eds3;
    let line_rasterization = enabled("VK_KHR_line_rasterization") || enabled("VK_EXT_line_rasterization");

    let mut states = vec![
        D::LINE_WIDTH,
        D::DEPTH_BIAS,
        D::BLEND_CONSTANTS,
        D::DEPTH_BOUNDS,
        D::STENCIL_COMPARE_MASK,
        D::STENCIL_WRITE_MASK,
        D::STENCIL_REFERENCE,
    ];

    if on(features.eds.extended_dynamic_state) {
        states.extend([
            D::CULL_MODE,
            D::FRONT_FACE,
            D::PRIMITIVE_TOPOLOGY,
            D::VIEWPORT_WITH_COUNT,
            D::SCISSOR_WITH_COUNT,
            D::VERTEX_INPUT_BINDING_STRIDE,
            D::DEPTH_TEST_ENABLE,
            D::DEPTH_WRITE_ENABLE,
            D::DEPTH_COMPARE_OP,
            D::DEPTH_BOUNDS_TEST_ENABLE,
            D::STENCIL_TEST_ENABLE,
            D::STENCIL_OP,
        ]);
    } else {
        states.push(D::VIEWPORT);
        states.push(D::SCISSOR);
    }
    if on(features.eds2.extended_dynamic_state2) {
        states.extend([
            D::DEPTH_BIAS_ENABLE,
            D::PRIMITIVE_RESTART_ENABLE,
            D::RASTERIZER_DISCARD_ENABLE,
        ]);
    }
    if on(features.eds2.extended_dynamic_state2_logic_op) {
        states.push(D::LOGIC_OP_EXT);
    }
    if on(features.eds2.extended_dynamic_state2_patch_control_points) {
        states.push(D::PATCH_CONTROL_POINTS_EXT);
    }

    let simple = [
        (
            eds3.extended_dynamic_state3_tessellation_domain_origin,
            D::TESSELLATION_DOMAIN_ORIGIN_EXT,
        ),
        (
            eds3.extended_dynamic_state_3depth_clamp_enable,
            D::DEPTH_CLAMP_ENABLE_EXT,
        ),
        (eds3.extended_dynamic_state3_polygon_mode, D::POLYGON_MODE_EXT),
        (
            eds3.extended_dynamic_state3_rasterization_samples,
            D::RASTERIZATION_SAMPLES_EXT,
        ),
        (eds3.extended_dynamic_state3_sample_mask, D::SAMPLE_MASK_EXT),
        (
            eds3.extended_dynamic_state3_alpha_to_coverage_enable,
            D::ALPHA_TO_COVERAGE_ENABLE_EXT,
        ),
        (
            eds3.extended_dynamic_state3_alpha_to_one_enable,
            D::ALPHA_TO_ONE_ENABLE_EXT,
        ),
        (eds3.extended_dynamic_state3_logic_op_enable, D::LOGIC_OP_ENABLE_EXT),
        (
            eds3.extended_dynamic_state3_color_blend_enable,
            D::COLOR_BLEND_ENABLE_EXT,
        ),
        (
            eds3.extended_dynamic_state3_color_blend_equation,
            D::COLOR_BLEND_EQUATION_EXT,
        ),
        (eds3.extended_dynamic_state3_color_write_mask, D::COLOR_WRITE_MASK_EXT),
        (features.vertex_input.vertex_input_dynamic_state, D::VERTEX_INPUT_EXT),
    ];
    states.extend(
        simple
            .into_iter()
            .filter(|&(feature, _)| on(feature))
            .map(|(_, state)| state),
    );

    // (extension required, feature, state); the order is upstream's
    let gated = [
        (
            enabled("VK_EXT_transform_feedback"),
            eds3.extended_dynamic_state3_rasterization_stream,
            D::RASTERIZATION_STREAM_EXT,
        ),
        (
            enabled("VK_EXT_blend_operation_advanced"),
            eds3.extended_dynamic_state3_color_blend_advanced,
            D::COLOR_BLEND_ADVANCED_EXT,
        ),
        (
            enabled("VK_EXT_conservative_rasterization"),
            eds3.extended_dynamic_state3_conservative_rasterization_mode,
            D::CONSERVATIVE_RASTERIZATION_MODE_EXT,
        ),
        (
            enabled("VK_NV_framebuffer_mixed_samples"),
            eds3.extended_dynamic_state3_coverage_modulation_mode,
            D::COVERAGE_MODULATION_MODE_NV,
        ),
        (
            enabled("VK_NV_framebuffer_mixed_samples"),
            eds3.extended_dynamic_state3_coverage_modulation_table_enable,
            D::COVERAGE_MODULATION_TABLE_ENABLE_NV,
        ),
        (
            enabled("VK_NV_framebuffer_mixed_samples"),
            eds3.extended_dynamic_state3_coverage_modulation_table,
            D::COVERAGE_MODULATION_TABLE_NV,
        ),
        (
            enabled("VK_NV_coverage_reduction_mode"),
            eds3.extended_dynamic_state3_coverage_reduction_mode,
            D::COVERAGE_REDUCTION_MODE_NV,
        ),
        (
            enabled("VK_NV_fragment_coverage_to_color"),
            eds3.extended_dynamic_state3_coverage_to_color_enable,
            D::COVERAGE_TO_COLOR_ENABLE_NV,
        ),
        (
            enabled("VK_NV_fragment_coverage_to_color"),
            eds3.extended_dynamic_state3_coverage_to_color_location,
            D::COVERAGE_TO_COLOR_LOCATION_NV,
        ),
        (
            enabled("VK_EXT_depth_clip_enable"),
            eds3.extended_dynamic_state_3depth_clip_enable,
            D::DEPTH_CLIP_ENABLE_EXT,
        ),
        (
            enabled("VK_EXT_depth_clip_control"),
            eds3.extended_dynamic_state_3depth_clip_negative_one_to_one,
            D::DEPTH_CLIP_NEGATIVE_ONE_TO_ONE_EXT,
        ),
        (
            enabled("VK_EXT_color_write_enable"),
            vk::TRUE,
            D::COLOR_WRITE_ENABLE_EXT,
        ),
        (
            enabled("VK_EXT_conservative_rasterization"),
            eds3.extended_dynamic_state3_extra_primitive_overestimation_size,
            D::EXTRA_PRIMITIVE_OVERESTIMATION_SIZE_EXT,
        ),
        (
            line_rasterization,
            eds3.extended_dynamic_state3_line_rasterization_mode,
            D::LINE_RASTERIZATION_MODE_EXT,
        ),
        (
            line_rasterization,
            eds3.extended_dynamic_state3_line_stipple_enable,
            D::LINE_STIPPLE_ENABLE_EXT,
        ),
        (line_rasterization, vk::TRUE, D::LINE_STIPPLE),
        (
            enabled("VK_EXT_provoking_vertex"),
            eds3.extended_dynamic_state3_provoking_vertex_mode,
            D::PROVOKING_VERTEX_MODE_EXT,
        ),
        (
            enabled("VK_KHR_fragment_shading_rate"),
            vk::TRUE,
            D::FRAGMENT_SHADING_RATE_KHR,
        ),
        (
            enabled("VK_NV_representative_fragment_test"),
            eds3.extended_dynamic_state3_representative_fragment_test_enable,
            D::REPRESENTATIVE_FRAGMENT_TEST_ENABLE_NV,
        ),
        (
            enabled("VK_EXT_sample_locations"),
            eds3.extended_dynamic_state3_sample_locations_enable,
            D::SAMPLE_LOCATIONS_ENABLE_EXT,
        ),
        (enabled("VK_EXT_sample_locations"), vk::TRUE, D::SAMPLE_LOCATIONS_EXT),
        (
            enabled("VK_NV_shading_rate_image"),
            eds3.extended_dynamic_state3_shading_rate_image_enable,
            D::SHADING_RATE_IMAGE_ENABLE_NV,
        ),
        (
            enabled("VK_NV_shading_rate_image"),
            vk::TRUE,
            D::VIEWPORT_COARSE_SAMPLE_ORDER_NV,
        ),
        (
            enabled("VK_NV_shading_rate_image"),
            vk::TRUE,
            D::VIEWPORT_SHADING_RATE_PALETTE_NV,
        ),
        (
            enabled("VK_NV_viewport_swizzle"),
            eds3.extended_dynamic_state3_viewport_swizzle,
            D::VIEWPORT_SWIZZLE_NV,
        ),
        (
            enabled("VK_NV_clip_space_w_scaling"),
            eds3.extended_dynamic_state3_viewport_w_scaling_enable,
            D::VIEWPORT_W_SCALING_ENABLE_NV,
        ),
        (
            enabled("VK_NV_clip_space_w_scaling"),
            vk::TRUE,
            D::VIEWPORT_W_SCALING_NV,
        ),
        (enabled("VK_NV_scissor_exclusive"), vk::TRUE, D::EXCLUSIVE_SCISSOR_NV),
        (
            enabled("VK_NV_scissor_exclusive"),
            vk::TRUE,
            D::EXCLUSIVE_SCISSOR_ENABLE_NV,
        ),
        (
            enabled("VK_EXT_discard_rectangles"),
            vk::TRUE,
            D::DISCARD_RECTANGLE_ENABLE_EXT,
        ),
        (enabled("VK_EXT_discard_rectangles"), vk::TRUE, D::DISCARD_RECTANGLE_EXT),
        (
            enabled("VK_EXT_discard_rectangles"),
            vk::TRUE,
            D::DISCARD_RECTANGLE_MODE_EXT,
        ),
        (
            enabled("VK_EXT_attachment_feedback_loop_dynamic_state"),
            vk::TRUE,
            D::ATTACHMENT_FEEDBACK_LOOP_ENABLE_EXT,
        ),
    ];
    states.extend(
        gated
            .into_iter()
            .filter(|&(extension, feature, _)| extension && on(feature))
            .map(|(_, _, state)| state),
    );

    states
}

fn make_graphics_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    render_pass: vk::RenderPass,
    stages: &[(vk::ShaderStageFlags, vk::ShaderModule)],
    state: &DrawPipelineState,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    create_draw_pipeline(device, layout, render_pass, stages, state)
}

fn make_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0");
    let info = vk::ComputePipelineCreateInfo::builder().stage(*stage).layout(layout);
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[*info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn unfilled_rasterization_state() -> vk::PipelineRasterizationStateCreateInfo {
    vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .depth_bias_constant_factor(0.0)
        .depth_bias_clamp(0.0)
        .depth_bias_slope_factor(0.0)
        .line_width(1.0)
        .build()
}

fn draw_count(test_type: TestType) -> u32 {
    match test_type {
        TestType::ShaderObject
        | TestType::MaxPipeline
        | TestType::RenderPassPipelineShaderObject
        | TestType::RenderPassPipelineShaderObjectAfterBegin
        | TestType::ComputeShaderObjectMinPipeline => 1,
        TestType::ShaderObjectComputePipeline => 1,
        TestType::MaxPipelineShaderObjectMaxPipeline | TestType::ShaderObjectMaxPipelineShaderObject => 3,
        TestType::MinPipelineShaderObject | TestType::ShaderObjectMinPipeline => 2,
    }
}

fn verify_quadrants(pixels: &[u8], draw_count: u32) -> bool {
    let size = RENDER_SIZE as usize;
    let red = [255u8, 0, 0, 255];
    let green = [0u8, 255, 0, 255];
    let blue = [0u8, 0, 255, 255];

    for j in 0..size {
        for i in 0..size {
            let offset = (j * size + i) * 4;
            let color = &pixels[offset..offset + 4];
            if i < size / 2 && j < size / 2 && draw_count > 0 {
                if color != red {
                    return false;
                }
            } else if i >= size / 2 && j < size / 2 && draw_count > 1 {
                if color != green {
                    return false;
                }
            } else if i < size / 2 && j >= size / 2 && draw_count > 2 && color != blue {
                return false;
            }
        }
    }

    true
}

// ---------------------------------------------------------------------------------------------------------------------
// pipeline_interaction.<test type>
// ---------------------------------------------------------------------------------------------------------------------

fn run_interaction(context: &Context<'_>, test_type: TestType) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let extensions = remove_unsupported_shader_object_extensions(context)?;
    let tessellation_supported = context.get_device_features().tessellation_shader != vk::FALSE;
    let geometry_supported = context.get_device_features().geometry_shader != vk::FALSE;
    let mesh_features = get_mesh_shader_features(context);
    let task_supported = mesh_features.task_shader != vk::FALSE;
    let mesh_supported = mesh_features.mesh_shader != vk::FALSE;

    let target = create_color_target(context)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let copy_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let layout_handle = *descriptor_set_layout;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let compute_pipeline_layout = make_pipeline_layout(device, &[layout_handle])?;

    let binaries = context.get_binary_collection();
    let vert1 = binaries.get("vert1")?;
    let vert2 = binaries.get("vert2")?;
    let vert3 = binaries.get("vert3")?;
    let tesc = binaries.get("tesc")?;
    let tese = binaries.get("tese")?;
    let geom = binaries.get("geom")?;
    let frag1 = binaries.get("frag1")?;
    let frag2 = binaries.get("frag2")?;
    let frag3 = binaries.get("frag3")?;
    let comp = binaries.get("comp")?;

    let make_info = |stage: vk::ShaderStageFlags, binary, layout: Option<&vk::DescriptorSetLayout>| {
        make_shader_create_info(stage, binary, tessellation_supported, geometry_supported, layout, None)
    };
    let vert_shader1 = create_shader(device, &make_info(vk::ShaderStageFlags::VERTEX, &vert1, None))?;
    let vert_shader2 = create_shader(device, &make_info(vk::ShaderStageFlags::VERTEX, &vert2, None))?;
    let vert_shader3 = create_shader(device, &make_info(vk::ShaderStageFlags::VERTEX, &vert3, None))?;
    let tesc_shader = create_shader(
        device,
        &make_info(vk::ShaderStageFlags::TESSELLATION_CONTROL, &tesc, None),
    )?;
    let tese_shader = create_shader(
        device,
        &make_info(vk::ShaderStageFlags::TESSELLATION_EVALUATION, &tese, None),
    )?;
    let geom_shader = create_shader(device, &make_info(vk::ShaderStageFlags::GEOMETRY, &geom, None))?;
    let frag_shader1 = create_shader(device, &make_info(vk::ShaderStageFlags::FRAGMENT, &frag1, None))?;
    let frag_shader2 = create_shader(device, &make_info(vk::ShaderStageFlags::FRAGMENT, &frag2, None))?;
    let frag_shader3 = create_shader(device, &make_info(vk::ShaderStageFlags::FRAGMENT, &frag3, None))?;
    let comp_shader = create_shader(
        device,
        &make_info(vk::ShaderStageFlags::COMPUTE, &comp, Some(&layout_handle)),
    )?;

    let vert_module1 = create_shader_module(device, vert1)?;
    let vert_module2 = create_shader_module(device, vert2)?;
    let vert_module3 = create_shader_module(device, vert3)?;
    let tesc_module = create_shader_module(device, tesc)?;
    let tese_module = create_shader_module(device, tese)?;
    let geom_module = create_shader_module(device, geom)?;
    let frag_module1 = create_shader_module(device, frag1)?;
    let frag_module2 = create_shader_module(device, frag2)?;
    let frag_module3 = create_shader_module(device, frag3)?;
    let comp_module = create_shader_module(device, comp)?;

    let render_pass = make_render_pass_full(
        device,
        COLOR_FORMAT,
        vk::Format::UNDEFINED,
        vk::AttachmentLoadOp::CLEAR,
        vk::ImageLayout::GENERAL,
    )?;

    let create_dynamic_pipeline = !matches!(
        test_type,
        TestType::MinPipelineShaderObject
            | TestType::ShaderObjectMinPipeline
            | TestType::ComputeShaderObjectMinPipeline
            | TestType::RenderPassPipelineShaderObject
            | TestType::RenderPassPipelineShaderObjectAfterBegin
    );

    let features = query_dynamic_state_features(context);
    let extended_dynamic_state = features.eds.extended_dynamic_state != vk::FALSE;
    let dynamic_states = build_dynamic_states(&features, &extensions);

    let conservative_state = vk::PipelineRasterizationConservativeStateCreateInfoEXT {
        s_type: vk::StructureType::PIPELINE_RASTERIZATION_CONSERVATIVE_STATE_CREATE_INFO_EXT,
        next: std::ptr::null(),
        flags: vk::PipelineRasterizationConservativeStateCreateFlagsEXT::empty(),
        conservative_rasterization_mode: vk::ConservativeRasterizationModeEXT::DISABLED,
        extra_primitive_overestimation_size: 0.0,
    };
    let mut rasterization = unfilled_rasterization_state();
    if extension_enabled(&extensions, "VK_EXT_conservative_rasterization")
        && features.eds3.extended_dynamic_state3_conservative_rasterization_mode != vk::FALSE
    {
        rasterization.next =
            (&conservative_state as *const vk::PipelineRasterizationConservativeStateCreateInfoEXT).cast();
    }

    let local_size_x = 16u32;
    let dispatch_x_count = 4u32;
    let buffer_size_bytes = (std::mem::size_of::<u32>() as u64) * u64::from(dispatch_x_count) * u64::from(local_size_x);

    let descriptor_set = make_descriptor_set(device, *descriptor_pool, layout_handle)?;
    let output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let buffer_info = [vk::DescriptorBufferInfo {
        buffer: output_buffer.get(),
        offset: 0,
        range: buffer_size_bytes,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&buffer_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let render_pass_cases = matches!(
        test_type,
        TestType::RenderPassPipelineShaderObject | TestType::RenderPassPipelineShaderObjectAfterBegin
    );
    let render_pass_handle = if render_pass_cases {
        *render_pass
    } else {
        vk::RenderPass::null()
    };

    let static_viewport = viewport(0.0, 0.0, RENDER_SIZE as f32, RENDER_SIZE as f32, 0.0, 1.0);
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST);
    state.patch_control_points = Some(4);
    state.rasterization = rasterization;
    state.rendering_format = if render_pass_cases { None } else { Some(COLOR_FORMAT) };
    if create_dynamic_pipeline {
        state.viewport_count = if extended_dynamic_state { 0 } else { 1 };
        state.dynamic_states = dynamic_states;
    } else {
        state.viewports = vec![static_viewport];
        state.scissors = vec![rect_2d(RENDER_SIZE, RENDER_SIZE)];
        state.viewport_count = 1;
    }

    let make_pipeline = |vert: vk::ShaderModule, frag: vk::ShaderModule| {
        make_graphics_pipeline(
            device,
            *pipeline_layout,
            render_pass_handle,
            &[
                (vk::ShaderStageFlags::VERTEX, vert),
                (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
                (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
                (vk::ShaderStageFlags::GEOMETRY, *geom_module),
                (vk::ShaderStageFlags::FRAGMENT, frag),
            ],
            &state,
        )
    };
    let pipeline1 = make_pipeline(*vert_module1, *frag_module1)?;
    let pipeline2 = make_pipeline(*vert_module2, *frag_module2)?;
    let pipeline3 = make_pipeline(*vert_module3, *frag_module3)?;
    let compute_pipeline = make_compute_pipeline(device, *compute_pipeline_layout, *comp_module)?;

    let clear_value = vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        },
    };

    let vertex_buffer_size = 64u64;
    let vertex_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let compute_only = matches!(
        test_type,
        TestType::ComputeShaderObjectMinPipeline | TestType::ShaderObjectComputePipeline
    );
    let bind_pipeline = |pipeline: &Unique<'_, vk::Pipeline>| unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get())
    };
    let draw = || unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };
    let set_states = || {
        set_default_shader_object_dynamic_states(
            device,
            cmd,
            &extensions,
            vk::PrimitiveTopology::PATCH_LIST,
            false,
            !extended_dynamic_state,
            RENDER_SIZE,
            RENDER_SIZE,
        )
    };
    let bind_shaders = |vert: &ShaderObject<'_>, frag: &ShaderObject<'_>| {
        bind_graphics_shaders(
            device,
            cmd,
            vert.get(),
            tesc_shader.get(),
            tese_shader.get(),
            geom_shader.get(),
            frag.get(),
            task_supported,
            mesh_supported,
        );
    };
    let begin = || {
        begin_rendering(
            device,
            cmd,
            *target.view,
            rect_2d(RENDER_SIZE, RENDER_SIZE),
            clear_value,
            vk::ImageLayout::GENERAL,
            vk::AttachmentLoadOp::CLEAR,
            vk::RenderingFlags::empty(),
            1,
            0,
        );
    };
    let conservative_stream_fix = || {
        // VUID-vkCmdDraw-None-07630
        if extension_enabled(&extensions, "VK_EXT_conservative_rasterization")
            && features.eds3.extended_dynamic_state3_conservative_rasterization_mode != vk::FALSE
        {
            unsafe { device.cmd_set_rasterization_stream_ext(cmd, 0) };
        }
    };

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    if test_type == TestType::RenderPassPipelineShaderObject {
        bind_pipeline(&pipeline1);
    }

    if !compute_only {
        begin();
    }

    set_states();
    bind_null_task_mesh_shaders(device, cmd, &mesh_features);

    unsafe { device.cmd_bind_vertex_buffers2_ext(cmd, 0, &[vertex_buffer.get()], &[0], &[vertex_buffer_size], &[16]) };

    match test_type {
        TestType::ShaderObject => {
            bind_shaders(&vert_shader1, &frag_shader1);
            draw();
        }
        TestType::MaxPipeline => {
            bind_pipeline(&pipeline1);
            draw();
        }
        TestType::MaxPipelineShaderObjectMaxPipeline => {
            bind_pipeline(&pipeline1);
            draw();

            conservative_stream_fix();

            bind_shaders(&vert_shader2, &frag_shader2);
            set_states();
            draw();

            bind_pipeline(&pipeline3);
            draw();
        }
        TestType::ShaderObjectMaxPipelineShaderObject => {
            bind_shaders(&vert_shader1, &frag_shader1);
            draw();

            bind_pipeline(&pipeline2);
            draw();

            conservative_stream_fix();

            bind_shaders(&vert_shader3, &frag_shader3);
            set_states();
            draw();
        }
        TestType::MinPipelineShaderObject => {
            bind_pipeline(&pipeline1);
            draw();

            bind_shaders(&vert_shader2, &frag_shader2);
            set_states();
            draw();
        }
        TestType::RenderPassPipelineShaderObject => {
            bind_shaders(&vert_shader1, &frag_shader1);
            draw();
        }
        TestType::RenderPassPipelineShaderObjectAfterBegin => {
            bind_pipeline(&pipeline1);
            bind_shaders(&vert_shader1, &frag_shader1);
            set_states();
            draw();
        }
        TestType::ShaderObjectMinPipeline => {
            bind_shaders(&vert_shader1, &frag_shader1);
            draw();

            bind_pipeline(&pipeline2);
            draw();
        }
        TestType::ComputeShaderObjectMinPipeline => {
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    compute_pipeline_layout.get(),
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                )
            };

            bind_compute_shader(device, cmd, comp_shader.get());
            unsafe { device.cmd_dispatch(cmd, dispatch_x_count, 1, 1) };

            begin();
            bind_pipeline(&pipeline1);
            draw();
            end_rendering(device, cmd);
        }
        TestType::ShaderObjectComputePipeline => {
            unsafe {
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    compute_pipeline_layout.get(),
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                )
            };

            begin();
            bind_shaders(&vert_shader1, &frag_shader1);
            draw();
            end_rendering(device, cmd);

            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, compute_pipeline.get());
                device.cmd_dispatch(cmd, dispatch_x_count, 1, 1);
            }
        }
    }

    if !compute_only {
        end_rendering(device, cmd);
    }

    if compute_only {
        let barrier = make_buffer_memory_barrier(
            vk::AccessFlags::SHADER_WRITE,
            vk::AccessFlags::HOST_READ,
            output_buffer.get(),
            0,
            buffer_size_bytes,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[barrier],
                &[] as &[vk::ImageMemoryBarrier],
            )
        };
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    begin_command_buffer(device, *copy_cmd_buffer)?;
    record_readback(device, *copy_cmd_buffer, &target, None);
    end_command_buffer(device, *copy_cmd_buffer)?;
    submit_commands_and_wait(device, queue, *copy_cmd_buffer)?;

    invalidate_alloc(device, target.output_buffer.get_allocation())?;

    if !verify_quadrants(read_pixels(&target), draw_count(test_type)) {
        return Ok(TestStatus::fail("Fail"));
    }

    if compute_only {
        let allocation = output_buffer.get_allocation();
        invalidate_alloc(device, allocation)?;

        let values = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const().cast::<u32>(), 4) };
        if (0..4).any(|i| values[i] != i as u32) {
            return Ok(TestStatus::fail("Fail"));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectPipelineInteractionCase {
    name: &'static str,
    test_type: TestType,
}

impl TestCase for ShaderObjectPipelineInteractionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;

        if context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "tessellationShader feature not supported".to_string(),
            ));
        }
        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        PIPELINE_INTERACTION.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectPipelineInteractionInstance {
            context,
            test_type: self.test_type,
        })
    }
}

struct ShaderObjectPipelineInteractionInstance<'a> {
    context: &'a Context<'a>,
    test_type: TestType,
}

impl TestInstance for ShaderObjectPipelineInteractionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_interaction(self.context, self.test_type)
    }
}

// ---------------------------------------------------------------------------------------------------------------------
// pipeline_interaction.<stages>
// ---------------------------------------------------------------------------------------------------------------------

fn run_stage_binding(context: &Context<'_>, params: &StageTestParams) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();
    let extensions = remove_unsupported_shader_object_extensions(context)?;
    let mesh_features = get_mesh_shader_features(context);
    let task_supported = mesh_features.task_shader != vk::FALSE;
    let mesh_supported = mesh_features.mesh_shader != vk::FALSE;

    let target = create_color_target(context)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let copy_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::ALL_GRAPHICS)
        .build(device)?;
    let layout_handle = *descriptor_set_layout;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

    let topology = if params.tess_shader {
        vk::PrimitiveTopology::PATCH_LIST
    } else {
        vk::PrimitiveTopology::TRIANGLE_STRIP
    };

    let pipeline_layout = make_pipeline_layout(device, &[layout_handle])?;
    let empty_pipeline_layout = make_pipeline_layout(device, &[])?;

    let binaries = context.get_binary_collection();
    let features = *context.get_device_features();
    let make = |stage: vk::ShaderStageFlags, name: &str| {
        make_shader(device, binaries, stage, name, &features, Some(&layout_handle))
    };

    let vert_shader = make(vk::ShaderStageFlags::VERTEX, "vert")?;
    let frag_shader = make(vk::ShaderStageFlags::FRAGMENT, "frag")?;
    let mut tesc_shader = None;
    let mut tese_shader = None;
    let mut geom_shader = None;
    let vert_module = create_shader_module(device, binaries.get("pipeline_vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("pipeline_frag")?)?;
    let mut tesc_module = None;
    let mut tese_module = None;
    let mut geom_module = None;

    if params.tess_shader {
        tesc_shader = Some(make(vk::ShaderStageFlags::TESSELLATION_CONTROL, "tesc")?);
        tese_shader = Some(make(vk::ShaderStageFlags::TESSELLATION_EVALUATION, "tese")?);

        tesc_module = Some(create_shader_module(device, binaries.get("pipeline_tesc")?)?);
        tese_module = Some(create_shader_module(device, binaries.get("pipeline_tese")?)?);
    }
    if params.geom_shader {
        geom_shader = Some(make(vk::ShaderStageFlags::GEOMETRY, "geom")?);

        geom_module = Some(create_shader_module(device, binaries.get("pipeline_geom")?)?);
    }

    let mut stages = vec![(vk::ShaderStageFlags::VERTEX, *vert_module)];
    if let (Some(tesc), Some(tese)) = (&tesc_module, &tese_module) {
        stages.push((vk::ShaderStageFlags::TESSELLATION_CONTROL, **tesc));
        stages.push((vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tese));
    }
    if let Some(geom) = &geom_module {
        stages.push((vk::ShaderStageFlags::GEOMETRY, **geom));
    }
    stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));

    let mut state = DrawPipelineState::new(topology);
    state.patch_control_points = Some(4);
    state.rendering_format = Some(COLOR_FORMAT);
    state.rasterization = unfilled_rasterization_state();
    state.viewports = vec![viewport(
        RENDER_SIZE as f32,
        0.0,
        RENDER_SIZE as f32,
        RENDER_SIZE as f32,
        0.0,
        1.0,
    )];
    state.scissors = vec![rect_2d(RENDER_SIZE, RENDER_SIZE)];
    state.viewport_count = 1;
    let pipeline = make_graphics_pipeline(device, *empty_pipeline_layout, vk::RenderPass::null(), &stages, &state)?;

    let buffer_size_bytes = (std::mem::size_of::<u32>() * 4) as u64;

    let descriptor_set = make_descriptor_set(device, *descriptor_pool, layout_handle)?;
    let output_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let buffer_info = [vk::DescriptorBufferInfo {
        buffer: output_buffer.get(),
        offset: 0,
        range: buffer_size_bytes,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&buffer_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    let clear_value = vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        },
    };

    begin_command_buffer(device, cmd)?;
    record_pre_barrier(device, cmd, target.image.get());

    begin_rendering(
        device,
        cmd,
        *target.view,
        rect_2d(RENDER_SIZE, RENDER_SIZE),
        clear_value,
        vk::ImageLayout::GENERAL,
        vk::AttachmentLoadOp::CLEAR,
        vk::RenderingFlags::empty(),
        1,
        0,
    );

    let features = query_dynamic_state_features(context);
    let handle_of = |shader: &Option<ShaderObject<'_>>, wanted: bool| {
        if wanted {
            shader.as_ref().map_or_else(vk::ShaderEXT::null, ShaderObject::get)
        } else {
            vk::ShaderEXT::null()
        }
    };
    unsafe {
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        device.cmd_draw(cmd, 4, 1, 0, 0);

        device.cmd_bind_descriptor_sets(
            cmd,
            vk::PipelineBindPoint::GRAPHICS,
            pipeline_layout.get(),
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );
    }
    set_default_shader_object_dynamic_states(
        device,
        cmd,
        &extensions,
        topology,
        false,
        features.eds.extended_dynamic_state == vk::FALSE,
        RENDER_SIZE,
        RENDER_SIZE,
    );

    bind_graphics_shaders(
        device,
        cmd,
        if params.vert_shader {
            vert_shader.get()
        } else {
            vk::ShaderEXT::null()
        },
        handle_of(&tesc_shader, params.tess_shader),
        handle_of(&tese_shader, params.tess_shader),
        handle_of(&geom_shader, params.geom_shader),
        if params.frag_shader {
            frag_shader.get()
        } else {
            vk::ShaderEXT::null()
        },
        task_supported,
        mesh_supported,
    );

    unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };

    end_rendering(device, cmd);

    let output_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        output_buffer.get(),
        0,
        buffer_size_bytes,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::ALL_GRAPHICS,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[output_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        )
    };

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, queue, cmd)?;

    if params.frag_shader {
        begin_command_buffer(device, *copy_cmd_buffer)?;
        record_readback(device, *copy_cmd_buffer, &target, None);
        end_command_buffer(device, *copy_cmd_buffer)?;
        submit_commands_and_wait(device, queue, *copy_cmd_buffer)?;

        invalidate_alloc(device, target.output_buffer.get_allocation())?;

        let pixels = read_pixels(&target);
        let size = RENDER_SIZE as usize;
        let x_offset = if params.tess_shader { 4 } else { 8 };
        let y_offset = if params.geom_shader { 4 } else { 8 };
        for j in 0..size {
            for i in 0..size {
                let offset = (j * size + i) * 4;
                let color = &pixels[offset..offset + 4];
                let inside = i >= x_offset && i < size - x_offset && j >= y_offset && j < size - y_offset;
                let expected = if inside {
                    [255u8, 255, 255, 255]
                } else {
                    [0u8, 0, 0, 255]
                };
                if color != expected {
                    return Ok(TestStatus::fail("Fail"));
                }
            }
        }
    }

    let allocation = output_buffer.get_allocation();
    invalidate_alloc(device, allocation)?;
    let values = unsafe { std::slice::from_raw_parts(allocation.get_host_ptr().cast_const().cast::<u32>(), 4) };

    if params.vert_shader && values[0] != 1 {
        return Ok(TestStatus::fail("Fail"));
    }
    if params.tess_shader && values[1] != 2 {
        return Ok(TestStatus::fail("Fail"));
    }
    if params.geom_shader && values[2] != 3 {
        return Ok(TestStatus::fail("Fail"));
    }

    Ok(TestStatus::pass("Pass"))
}

struct ShaderObjectStageBindingCase {
    name: &'static str,
    params: StageTestParams,
}

impl TestCase for ShaderObjectStageBindingCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_shader_object")?;

        if self.params.tess_shader && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "tessellationShader feature not supported".to_string(),
            ));
        }
        if self.params.geom_shader && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        PIPELINE_INTERACTION_STAGE_BINDING.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ShaderObjectStageBindingInstance {
            context,
            params: self.params,
        })
    }
}

struct ShaderObjectStageBindingInstance<'a> {
    context: &'a Context<'a>,
    params: StageTestParams,
}

impl TestInstance for ShaderObjectStageBindingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_stage_binding(self.context, &self.params)
    }
}

/// `createShaderObjectPipelineInteractionTests`
pub fn create_shader_object_pipeline_interaction_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("pipeline_interaction");

    let tests = [
        (TestType::ShaderObject, "shader_object"),
        (TestType::MaxPipeline, "max_pipeline"),
        (
            TestType::MaxPipelineShaderObjectMaxPipeline,
            "max_pipeline_shader_object_max_pipeline",
        ),
        (
            TestType::ShaderObjectMaxPipelineShaderObject,
            "shader_object_max_pipeline_shader_object",
        ),
        (TestType::MinPipelineShaderObject, "min_pipeline_shader_object"),
        (TestType::ShaderObjectMinPipeline, "shader_object_min_pipeline"),
        (
            TestType::RenderPassPipelineShaderObject,
            "render_pass_pipeline_shader_object",
        ),
        (
            TestType::RenderPassPipelineShaderObjectAfterBegin,
            "render_pass_pipeline_shader_object_after_begin",
        ),
        (
            TestType::ComputeShaderObjectMinPipeline,
            "compute_shader_object_min_pipeline",
        ),
        (TestType::ShaderObjectComputePipeline, "shader_object_compute_pipeline"),
    ];
    for (test_type, name) in tests {
        group.add_child(Box::new(ShaderObjectPipelineInteractionCase { name, test_type }) as Box<dyn TestCase>);
    }

    let shader_bind_tests = [
        (
            StageTestParams {
                vert_shader: true,
                tess_shader: false,
                geom_shader: false,
                frag_shader: false,
            },
            "vert",
        ),
        (
            StageTestParams {
                vert_shader: true,
                tess_shader: true,
                geom_shader: false,
                frag_shader: false,
            },
            "vert_tess",
        ),
        (
            StageTestParams {
                vert_shader: true,
                tess_shader: false,
                geom_shader: true,
                frag_shader: false,
            },
            "vert_geom",
        ),
        (
            StageTestParams {
                vert_shader: true,
                tess_shader: false,
                geom_shader: false,
                frag_shader: true,
            },
            "vert_frag",
        ),
        (
            StageTestParams {
                vert_shader: true,
                tess_shader: true,
                geom_shader: true,
                frag_shader: false,
            },
            "vert_tess_geom",
        ),
        (
            StageTestParams {
                vert_shader: true,
                tess_shader: true,
                geom_shader: false,
                frag_shader: true,
            },
            "vert_tess_frag",
        ),
        (
            StageTestParams {
                vert_shader: true,
                tess_shader: false,
                geom_shader: true,
                frag_shader: true,
            },
            "vert_geom_frag",
        ),
        (
            StageTestParams {
                vert_shader: true,
                tess_shader: true,
                geom_shader: true,
                frag_shader: true,
            },
            "vert_tess_geom_frag",
        ),
    ];
    for (params, name) in shader_bind_tests {
        group.add_child(Box::new(ShaderObjectStageBindingCase { name, params }) as Box<dyn TestCase>);
    }

    group
}
