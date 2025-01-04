// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderBuiltinTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `pipeline` group (the clip and cull distance cases under the non-monolithic construction types) reports
// NotPorted for `shader_objects`, and `primitive_id_spirv` pairs the same mesh shader with a hand-assembled fragment shader. The shaders have
// everything upstream formats into them written out in the manifest.
//
// One shared runner draws the case's mesh shading pipeline (one subpass and pipeline per layer when multiview is on) into an image
// and compares it, per layer, against flat colours, quadrants or a handful of pixels.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtMeshShaderExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::mesh_shader_builtin::{
    BUILTIN_CLIP_DISTANCE, BUILTIN_CLIP_DISTANCE_MIX, BUILTIN_CULL_DISTANCE, BUILTIN_CULL_DISTANCE_MIX,
    BUILTIN_CULL_PRIMITIVES, BUILTIN_DRAW_INDEX_MESH, BUILTIN_DRAW_INDEX_TASK, BUILTIN_GLOBAL_INVOCATION_ID_MESH,
    BUILTIN_GLOBAL_INVOCATION_ID_TASK, BUILTIN_LAYER, BUILTIN_LAYER_NO_WRITE, BUILTIN_LAYER_SHARED,
    BUILTIN_LOCAL_INVOCATION_ID_MESH, BUILTIN_LOCAL_INVOCATION_ID_TASK, BUILTIN_LOCAL_INVOCATION_INDEX_MESH,
    BUILTIN_LOCAL_INVOCATION_INDEX_TASK, BUILTIN_NUM_WORK_GROUPS_MESH, BUILTIN_NUM_WORK_GROUPS_TASK_AND_MESH,
    BUILTIN_POINT_SIZE, BUILTIN_POSITION, BUILTIN_PRIMITIVE_ID_GLSL, BUILTIN_PRIMITIVE_ID_SPIRV,
    BUILTIN_PRIMITIVE_SHADING_RATE_1X1_1X1, BUILTIN_PRIMITIVE_SHADING_RATE_1X1_2X1,
    BUILTIN_PRIMITIVE_SHADING_RATE_1X1_2X2, BUILTIN_PRIMITIVE_SHADING_RATE_2X1_1X1,
    BUILTIN_PRIMITIVE_SHADING_RATE_2X1_2X1, BUILTIN_PRIMITIVE_SHADING_RATE_2X1_2X2,
    BUILTIN_PRIMITIVE_SHADING_RATE_2X2_1X1, BUILTIN_PRIMITIVE_SHADING_RATE_2X2_2X1,
    BUILTIN_PRIMITIVE_SHADING_RATE_2X2_2X2, BUILTIN_VIEW_INDEX, BUILTIN_VIEWPORT_INDEX,
    BUILTIN_VIEWPORT_INDEX_NO_WRITE, BUILTIN_VIEWPORT_INDEX_SHARED, BUILTIN_WORK_GROUP_ID_MESH,
    BUILTIN_WORK_GROUP_ID_TASK,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::tests::mesh_shader::util::{
    FragmentSize, check_task_mesh_shader_support_ext, get_bad_shading_rate_size, get_shading_rate_size,
    mesh_shader_features, mesh_shader_properties,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

pub(super) type Color = [f32; 4];

pub(super) const CLEAR_COLOR: Color = [0.0, 0.0, 0.0, 1.0];
pub(super) const BLUE: Color = [0.0, 0.0, 1.0, 1.0];
pub(super) const WHITE: Color = [1.0, 1.0, 1.0, 1.0];
pub(super) const MAGENTA: Color = [1.0, 0.0, 1.0, 1.0];
pub(super) const CYAN: Color = [0.0, 1.0, 1.0, 1.0];
pub(super) const YELLOW: Color = [1.0, 1.0, 0.0, 1.0];

pub(super) fn to_bytes(color: Color) -> [u8; 4] {
    color.map(|c| (c * 255.0).round() as u8)
}

const DEFAULT_EXTENT: (u32, u32) = (8, 8);
const LINEAR_EXTENT: (u32, u32) = (8, 1);

/// `getDefaultDrawCommands`
fn default_draw_commands(task_count: u32) -> Vec<vk::DrawMeshTasksIndirectCommandEXT> {
    vec![vk::DrawMeshTasksIndirectCommandEXT {
        group_count_x: task_count,
        group_count_y: 1,
        group_count_z: 1,
    }]
}

/// `IterationParams`
#[derive(Clone)]
struct IterationParams {
    color_extent: (u32, u32),
    num_layers: u32,
    multiview: bool,
    indirect: bool,
    fragment_size: Option<FragmentSize>,
    draw_args: Vec<vk::DrawMeshTasksIndirectCommandEXT>,
    /// If empty, a single default viewport is used.
    viewports: Vec<vk::Viewport>,
}

impl IterationParams {
    fn new(color_extent: (u32, u32), draw_args: Vec<vk::DrawMeshTasksIndirectCommandEXT>) -> Self {
        Self {
            color_extent,
            num_layers: 1,
            multiview: false,
            indirect: false,
            fragment_size: None,
            draw_args,
            viewports: Vec::new(),
        }
    }
}

/// `FullScreenColorInstance`, `QuadrantsInstance` and `PixelsInstance`.
pub(super) enum Verifier {
    /// One expected colour per layer.
    FullScreenColor(Vec<Color>),
    Quadrants {
        top_left: Color,
        top_right: Color,
        bottom_left: Color,
        bottom_right: Color,
    },
    /// A background and the pixels that differ from it.
    Pixels {
        background: Color,
        pixels: Vec<((u32, u32), Color)>,
    },
}

impl Verifier {
    pub(super) fn verify(&self, result: &[u8], width: u32, height: u32, depth: u32) -> Result<(), TestError> {
        let pixel = |x: u32, y: u32, z: u32| -> [u8; 4] {
            let offset = (((z * height + y) * width + x) * 4) as usize;
            [
                result[offset],
                result[offset + 1],
                result[offset + 2],
                result[offset + 3],
            ]
        };

        let mut fail = false;
        for z in 0..depth {
            for y in 0..height {
                for x in 0..width {
                    let expected = match self {
                        Verifier::FullScreenColor(colors) => colors[z as usize],
                        Verifier::Quadrants {
                            top_left,
                            top_right,
                            bottom_left,
                            bottom_right,
                        } => {
                            debug_assert!(depth == 1 && width.is_multiple_of(2) && height.is_multiple_of(2));
                            let (half_width, half_height) = (width / 2, height / 2);
                            // Choose the right quadrant.
                            if y < half_height {
                                if x < half_width { *top_left } else { *top_right }
                            } else if x < half_width {
                                *bottom_left
                            } else {
                                *bottom_right
                            }
                        }
                        Verifier::Pixels { background, pixels } => pixels
                            .iter()
                            .find(|(coords, _)| *coords == (x, y))
                            .map_or(*background, |(_, color)| *color),
                    };

                    let result_color = pixel(x, y, z);
                    if result_color != to_bytes(expected) {
                        log::info!(
                            "Pixel ({x}, {y}, {z}) failed: expected {:?} and found {result_color:?}",
                            to_bytes(expected)
                        );
                        fail = true;
                    }
                }
            }
        }

        if fail {
            return Err(TestError::Fail("Check log for details".to_string()));
        }
        Ok(())
    }
}

/// `createCustomRenderPass`
fn create_custom_render_pass(
    device: &Device,
    format: vk::Format,
    multiview: bool,
    num_layers: u32,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    debug_assert!(num_layers > 0);
    let num_subpasses = if multiview { num_layers } else { 1 } as usize;

    let attachments = [vk::AttachmentDescription::builder()
        .format(format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];
    let color_refs = [vk::AttachmentReference::builder()
        .attachment(0)
        .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];
    let subpass_descriptions: Vec<vk::SubpassDescriptionBuilder<'_>> = (0..num_subpasses)
        .map(|_| {
            vk::SubpassDescription::builder()
                .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
                .color_attachments(&color_refs)
        })
        .collect();

    let dependencies: Vec<vk::SubpassDependency> = (1..num_subpasses as u32)
        .map(|subpass_idx| vk::SubpassDependency {
            src_subpass: subpass_idx - 1,
            dst_subpass: subpass_idx,
            src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE | vk::AccessFlags::COLOR_ATTACHMENT_READ,
            dependency_flags: vk::DependencyFlags::BY_REGION,
        })
        .collect();

    let view_masks: Vec<u32> = (0..num_subpasses).map(|subpass_idx| 1u32 << subpass_idx).collect();
    let mut multiview_create_info = vk::RenderPassMultiviewCreateInfo::builder().view_masks(&view_masks);
    let mut info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpass_descriptions)
        .dependencies(&dependencies);
    if multiview {
        info = info.push_next(&mut multiview_create_info);
    }
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `MeshShaderBuiltinInstance::iterate`
fn run_builtin(context: &Context<'_>, params: &IterationParams, verifier: &Verifier) -> TestOutcome {
    let device = context.get_device();
    let alloc = context.get_default_allocator();

    let binaries = context.get_binary_collection();
    let use_task = binaries.contains("task");
    let use_frag = binaries.contains("frag");
    let extent = vk::Extent3D {
        width: params.color_extent.0,
        height: params.color_extent.1,
        depth: 1,
    };
    let format = vk::Format::R8G8B8A8_UNORM;
    let view_type = if params.num_layers > 1 {
        vk::ImageViewType::_2D_ARRAY
    } else {
        vk::ImageViewType::_2D
    };
    let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, params.num_layers);
    let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, params.num_layers);
    let num_passes = if params.multiview { params.num_layers } else { 1 };

    let color_buffer_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(format)
        .extent(extent)
        .mip_levels(1)
        .array_layers(params.num_layers)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_buffer = ImageWithMemory::new(device, alloc, color_buffer_info, MemoryRequirement::ANY)?;
    let color_buffer_view = make_image_view(device, color_buffer.get(), view_type, format, color_srr)?;

    // Empty descriptor set layout and the pipeline layout over it.
    let set_layout = DescriptorSetLayoutBuilder::new().build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[set_layout.get()])?;

    // Render pass and framebuffer.
    let render_pass = create_custom_render_pass(device, format, params.multiview, params.num_layers)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_buffer_view],
        extent.width,
        extent.height,
        if params.multiview { 1 } else { params.num_layers },
    )?;

    // Shader modules.
    let task_module = if use_task {
        Some(create_shader_module(device, binaries.get("task")?)?)
    } else {
        None
    };
    let frag_module = if use_frag {
        Some(create_shader_module(device, binaries.get("frag")?)?)
    } else {
        None
    };
    let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;

    let (viewports, scissors) = if params.viewports.is_empty() {
        // Default ones.
        (
            vec![viewport(0.0, 0.0, extent.width as f32, extent.height as f32, 0.0, 1.0)],
            vec![rect_2d(extent.width, extent.height)],
        )
    } else {
        // The desired viewports and the same number of default scissors.
        (
            params.viewports.clone(),
            vec![rect_2d(extent.width, extent.height); params.viewports.len()],
        )
    };

    let fragment_shading_rate_state = params.fragment_size.map(|fragment_size| {
        vk::PipelineFragmentShadingRateStateCreateInfoKHR::builder()
            .fragment_size(get_shading_rate_size(fragment_size))
            .combiner_ops([
                vk::FragmentShadingRateCombinerOpKHR::REPLACE,
                vk::FragmentShadingRateCombinerOpKHR::KEEP,
            ])
            .build()
    });

    // Pipelines, one per subpass.
    let mut stages = Vec::new();
    if let Some(task) = &task_module {
        stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
    }
    stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_module));
    if let Some(frag) = &frag_module {
        stages.push((vk::ShaderStageFlags::FRAGMENT, **frag));
    }
    let mut pipelines = Vec::with_capacity(num_passes as usize);
    for subpass_idx in 0..num_passes {
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
        state.viewport_count = viewports.len() as u32;
        state.viewports = viewports.clone();
        state.scissors = scissors.clone();
        state.rasterization.depth_bias_enable = vk::FALSE;
        state.subpass = subpass_idx;
        state.fragment_shading_rate_state = fragment_shading_rate_state;
        pipelines.push(create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &stages,
            &state,
        )?);
    }

    // Command pool and buffer.
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    // Indirect buffer if needed.
    debug_assert!(!params.draw_args.is_empty());
    let indirect_buffer = if params.indirect {
        Some(create_host_buffer(
            context,
            &params.draw_args,
            vk::BufferUsageFlags::INDIRECT_BUFFER,
        )?)
    } else {
        None
    };

    // Output buffer to extract the color buffer contents.
    let layer_size = (4 * extent.width * extent.height) as vk::DeviceSize;
    let out_buffer_size = layer_size * vk::DeviceSize::from(params.num_layers);
    let out_buffer = BufferWithMemory::new(
        device,
        alloc,
        make_buffer_create_info(out_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Submit commands.
    begin_command_buffer(device, cmd)?;
    let clear_values = [clear_value_color(CLEAR_COLOR)];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(rect_2d(extent.width, extent.height))
        .clear_values(&clear_values);
    unsafe { device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE) };

    for subpass_idx in 0..num_passes as usize {
        if subpass_idx > 0 {
            unsafe { device.cmd_next_subpass(cmd, vk::SubpassContents::INLINE) };
        }

        unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipelines[subpass_idx].get()) };

        match &indirect_buffer {
            None => {
                for command in &params.draw_args {
                    unsafe {
                        device.cmd_draw_mesh_tasks_ext(
                            cmd,
                            command.group_count_x,
                            command.group_count_y,
                            command.group_count_z,
                        )
                    };
                }
            }
            Some(buffer) => {
                let num_draws = params.draw_args.len() as u32;
                let stride = std::mem::size_of::<vk::DrawMeshTasksIndirectCommandEXT>() as u32;
                unsafe { device.cmd_draw_mesh_tasks_indirect_ext(cmd, buffer.get(), 0, num_draws, stride) };
            }
        }
    }

    unsafe { device.cmd_end_render_pass(cmd) };

    // Transition image layout and copy it to the output buffer.
    let pre_transfer_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        color_buffer.get(),
        color_srr,
    );
    let post_transfer_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
    let region = make_buffer_image_copy(extent, color_srl);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[pre_transfer_barrier],
        );
        device.cmd_copy_image_to_buffer(
            cmd,
            color_buffer.get(),
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            out_buffer.get(),
            &[region],
        );
        device.cmd_pipeline_barrier(
            cmd,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[post_transfer_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    end_command_buffer(device, cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

    // Invalidate alloc and verify result.
    let out_alloc = out_buffer.get_allocation();
    invalidate_alloc(device, out_alloc)?;
    let result = unsafe { std::slice::from_raw_parts(out_alloc.get_host_ptr().cast_const(), out_buffer_size as usize) };
    verifier.verify(result, extent.width, extent.height, params.num_layers)?;

    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum LocalInvocation {
    Id,
    Index,
}

/// The builtin each case covers, with what `createInstance` of its upstream class chooses.
#[derive(Clone, Copy)]
enum Kind {
    Position,
    PointSize,
    ClipDistance {
        mixed: bool,
    },
    CullDistance {
        mixed: bool,
    },
    PrimitiveIdGlsl,
    PrimitiveIdSpirv,
    Layer {
        write_val: bool,
        share_vertices: bool,
    },
    ViewportIndex {
        write_val: bool,
        share_vertices: bool,
    },
    WorkGroupId {
        task_needed: bool,
    },
    NumWorkgroups {
        task_groups: Option<[u32; 3]>,
        mesh_groups: [u32; 3],
    },
    LocalInvocation {
        task_needed: bool,
        variable: LocalInvocation,
    },
    GlobalInvocationId {
        task_needed: bool,
    },
    DrawIndex {
        task_needed: bool,
    },
    ViewIndex,
    PrimitiveShadingRate {
        top_size: FragmentSize,
        bottom_size: FragmentSize,
    },
    CullPrimitives,
}

const LAYER_COUNT: u32 = 4;
const QUADRANTS: u32 = 4;
const POINT_SIZE: f32 = 4.0;
const GLOBAL_JOB_SIZE: (u32, u32) = (8, 8);

pub(super) fn vulkan_12_features(context: &Context<'_>) -> vk::PhysicalDeviceVulkan12Features {
    let mut features = vk::PhysicalDeviceVulkan12Features::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features
}

fn multiview_supported(context: &Context<'_>) -> bool {
    let mut features = vk::PhysicalDeviceMultiviewFeatures::default();
    {
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
    }
    features.multiview != vk::FALSE
}

impl Kind {
    fn task_needed(self) -> bool {
        match self {
            Kind::WorkGroupId { task_needed }
            | Kind::LocalInvocation { task_needed, .. }
            | Kind::GlobalInvocationId { task_needed }
            | Kind::DrawIndex { task_needed } => task_needed,
            Kind::NumWorkgroups { task_groups, .. } => task_groups.is_some(),
            _ => false,
        }
    }

    /// `NumWorkgroupsCase::imageExtent`
    fn num_workgroups_width(task_groups: Option<[u32; 3]>, mesh_groups: [u32; 3]) -> u32 {
        let task_multiplier = task_groups.map_or(1, |tg| tg[0] * tg[1] * tg[2]);
        mesh_groups[0] * mesh_groups[1] * mesh_groups[2] * task_multiplier
    }

    fn check_support(self, context: &Context<'_>) -> Result<(), TestError> {
        // `MeshShaderBuiltinCase::checkSupport`
        check_task_mesh_shader_support_ext(context, self.task_needed(), true)?;

        let features = context.get_device_features();
        let not_supported = |what: &str| {
            Err(TestError::NotSupported(format!(
                "Requested core feature is not supported: {what}"
            )))
        };

        match self {
            Kind::PrimitiveIdGlsl => {
                // Fragment shader in GLSL means glslang will use the Geometry capability due to gl_PrimitiveID.
                if features.geometry_shader == vk::FALSE {
                    return not_supported("geometryShader");
                }
            }
            Kind::PointSize => {
                if features.large_points == vk::FALSE {
                    return not_supported("largePoints");
                }

                let point_size_range = context.get_device_properties().limits.point_size_range;
                if POINT_SIZE < point_size_range[0] || POINT_SIZE > point_size_range[1] {
                    return Err(TestError::NotSupported(
                        "Required point size outside point size range".to_string(),
                    ));
                }
            }
            Kind::ClipDistance { .. } => {
                if features.shader_clip_distance == vk::FALSE {
                    return not_supported("shaderClipDistance");
                }
            }
            Kind::CullDistance { .. } => {
                if features.shader_cull_distance == vk::FALSE {
                    return not_supported("shaderCullDistance");
                }
            }
            Kind::Layer { .. } => {
                if context.api_version() < (1, 2, 0) {
                    context.require_device_functionality("VK_EXT_shader_viewport_index_layer")?;
                } else if vulkan_12_features(context).shader_output_layer == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "shaderOutputLayer feature not supported".to_string(),
                    ));
                }
            }
            Kind::ViewportIndex { .. } => {
                if features.multi_viewport == vk::FALSE {
                    return not_supported("multiViewport");
                }

                if context.api_version() < (1, 2, 0) {
                    context.require_device_functionality("VK_EXT_shader_viewport_index_layer")?;
                } else if vulkan_12_features(context).shader_output_viewport_index == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "shaderOutputViewportIndex feature not supported".to_string(),
                    ));
                }
            }
            Kind::ViewIndex => {
                if !multiview_supported(context) {
                    return Err(TestError::NotSupported("Multiview not supported".to_string()));
                }

                if mesh_shader_features(context).multiview_mesh_shader == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Multiview not supported for mesh shaders".to_string(),
                    ));
                }

                let max_views = mesh_shader_properties(context).max_mesh_multiview_view_count;
                if LAYER_COUNT > max_views {
                    return Err(TestError::NotSupported(format!(
                        "maxMeshMultiviewViewCount too low: {max_views} and the test needs {LAYER_COUNT}"
                    )));
                }
            }
            Kind::PrimitiveShadingRate { .. } => {
                context.require_device_functionality("VK_KHR_fragment_shading_rate")?;

                if mesh_shader_features(context).primitive_fragment_shading_rate_mesh_shader == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Primitive fragment shading rate not supported in mesh shaders".to_string(),
                    ));
                }
            }
            _ => {}
        }

        Ok(())
    }

    fn programs(self) -> BinaryCollection {
        match self {
            Kind::Position => BUILTIN_POSITION.programs,
            Kind::PointSize => BUILTIN_POINT_SIZE.programs,
            Kind::ClipDistance { mixed: false } => BUILTIN_CLIP_DISTANCE.programs,
            Kind::ClipDistance { mixed: true } => BUILTIN_CLIP_DISTANCE_MIX.programs,
            Kind::CullDistance { mixed: false } => BUILTIN_CULL_DISTANCE.programs,
            Kind::CullDistance { mixed: true } => BUILTIN_CULL_DISTANCE_MIX.programs,
            Kind::PrimitiveIdGlsl => BUILTIN_PRIMITIVE_ID_GLSL.programs,
            Kind::PrimitiveIdSpirv => BUILTIN_PRIMITIVE_ID_SPIRV.programs,
            Kind::Layer {
                write_val: true,
                share_vertices: false,
            } => BUILTIN_LAYER.programs,
            Kind::Layer {
                write_val: true,
                share_vertices: true,
            } => BUILTIN_LAYER_SHARED.programs,
            Kind::Layer { write_val: false, .. } => BUILTIN_LAYER_NO_WRITE.programs,
            Kind::ViewportIndex {
                write_val: true,
                share_vertices: false,
            } => BUILTIN_VIEWPORT_INDEX.programs,
            Kind::ViewportIndex {
                write_val: true,
                share_vertices: true,
            } => BUILTIN_VIEWPORT_INDEX_SHARED.programs,
            Kind::ViewportIndex { write_val: false, .. } => BUILTIN_VIEWPORT_INDEX_NO_WRITE.programs,
            Kind::WorkGroupId { task_needed: false } => BUILTIN_WORK_GROUP_ID_MESH.programs,
            Kind::WorkGroupId { task_needed: true } => BUILTIN_WORK_GROUP_ID_TASK.programs,
            Kind::NumWorkgroups { task_groups: None, .. } => BUILTIN_NUM_WORK_GROUPS_MESH.programs,
            Kind::NumWorkgroups {
                task_groups: Some(_), ..
            } => BUILTIN_NUM_WORK_GROUPS_TASK_AND_MESH.programs,
            Kind::LocalInvocation {
                task_needed: false,
                variable: LocalInvocation::Id,
            } => BUILTIN_LOCAL_INVOCATION_ID_MESH.programs,
            Kind::LocalInvocation {
                task_needed: false,
                variable: LocalInvocation::Index,
            } => BUILTIN_LOCAL_INVOCATION_INDEX_MESH.programs,
            Kind::LocalInvocation {
                task_needed: true,
                variable: LocalInvocation::Id,
            } => BUILTIN_LOCAL_INVOCATION_ID_TASK.programs,
            Kind::LocalInvocation {
                task_needed: true,
                variable: LocalInvocation::Index,
            } => BUILTIN_LOCAL_INVOCATION_INDEX_TASK.programs,
            Kind::GlobalInvocationId { task_needed: false } => BUILTIN_GLOBAL_INVOCATION_ID_MESH.programs,
            Kind::GlobalInvocationId { task_needed: true } => BUILTIN_GLOBAL_INVOCATION_ID_TASK.programs,
            Kind::DrawIndex { task_needed: false } => BUILTIN_DRAW_INDEX_MESH.programs,
            Kind::DrawIndex { task_needed: true } => BUILTIN_DRAW_INDEX_TASK.programs,
            Kind::ViewIndex => BUILTIN_VIEW_INDEX.programs,
            Kind::CullPrimitives => BUILTIN_CULL_PRIMITIVES.programs,
            Kind::PrimitiveShadingRate { top_size, bottom_size } => match (top_size, bottom_size) {
                (FragmentSize::Size2x2, FragmentSize::Size2x2) => BUILTIN_PRIMITIVE_SHADING_RATE_2X2_2X2.programs,
                (FragmentSize::Size2x2, FragmentSize::Size2x1) => BUILTIN_PRIMITIVE_SHADING_RATE_2X2_2X1.programs,
                (FragmentSize::Size2x2, FragmentSize::Size1x1) => BUILTIN_PRIMITIVE_SHADING_RATE_2X2_1X1.programs,
                (FragmentSize::Size2x1, FragmentSize::Size2x2) => BUILTIN_PRIMITIVE_SHADING_RATE_2X1_2X2.programs,
                (FragmentSize::Size2x1, FragmentSize::Size2x1) => BUILTIN_PRIMITIVE_SHADING_RATE_2X1_2X1.programs,
                (FragmentSize::Size2x1, FragmentSize::Size1x1) => BUILTIN_PRIMITIVE_SHADING_RATE_2X1_1X1.programs,
                (FragmentSize::Size1x1, FragmentSize::Size2x2) => BUILTIN_PRIMITIVE_SHADING_RATE_1X1_2X2.programs,
                (FragmentSize::Size1x1, FragmentSize::Size2x1) => BUILTIN_PRIMITIVE_SHADING_RATE_1X1_2X1.programs,
                (FragmentSize::Size1x1, FragmentSize::Size1x1) => BUILTIN_PRIMITIVE_SHADING_RATE_1X1_1X1.programs,
            },
        }
    }

    /// What each upstream `createInstance` builds: the iteration parameters and the verifier.
    fn instance_setup(self) -> (IterationParams, Verifier) {
        let default_params = || IterationParams::new(DEFAULT_EXTENT, default_draw_commands(1));
        let black = CLEAR_COLOR;

        match self {
            Kind::Position => (
                default_params(),
                Verifier::Pixels {
                    background: black,
                    pixels: vec![((0, 0), BLUE)],
                },
            ),
            Kind::PointSize => (
                default_params(),
                Verifier::Quadrants {
                    top_left: BLUE,
                    top_right: black,
                    bottom_left: black,
                    bottom_right: black,
                },
            ),
            Kind::ClipDistance { .. } => (
                default_params(),
                Verifier::Quadrants {
                    top_left: BLUE,
                    top_right: black,
                    bottom_left: black,
                    bottom_right: black,
                },
            ),
            Kind::CullDistance { .. } => (
                default_params(),
                Verifier::Quadrants {
                    top_left: BLUE,
                    top_right: WHITE,
                    bottom_left: black,
                    bottom_right: black,
                },
            ),
            Kind::PrimitiveIdGlsl | Kind::PrimitiveIdSpirv => (default_params(), Verifier::FullScreenColor(vec![BLUE])),
            Kind::Layer {
                write_val,
                share_vertices,
            } => {
                let used_layers = if write_val { LAYER_COUNT } else { 1 };
                let num_work_groups = if share_vertices { 1 } else { LAYER_COUNT };

                let mut expected_colors = vec![BLUE];
                if write_val {
                    expected_colors.extend([MAGENTA, CYAN, YELLOW]);
                }

                let mut params = IterationParams::new(DEFAULT_EXTENT, default_draw_commands(num_work_groups));
                params.num_layers = used_layers;
                (params, Verifier::FullScreenColor(expected_colors))
            }
            Kind::ViewportIndex {
                write_val,
                share_vertices,
            } => {
                let half_width = DEFAULT_EXTENT.0 as f32 / 2.0;
                let half_height = DEFAULT_EXTENT.1 as f32 / 2.0;

                let top_right = if write_val { MAGENTA } else { black };
                let bottom_left = if write_val { CYAN } else { black };
                let bottom_right = if write_val { YELLOW } else { black };

                let mut params = IterationParams::new(
                    DEFAULT_EXTENT,
                    default_draw_commands(if share_vertices { 1 } else { QUADRANTS }),
                );
                params.viewports = vec![
                    viewport(0.0, 0.0, half_width, half_height, 0.0, 1.0),
                    viewport(half_width, 0.0, half_width, half_height, 0.0, 1.0),
                    viewport(0.0, half_height, half_width, half_height, 0.0, 1.0),
                    viewport(half_width, half_height, half_width, half_height, 0.0, 1.0),
                ];
                (
                    params,
                    Verifier::Quadrants {
                        top_left: BLUE,
                        top_right,
                        bottom_left,
                        bottom_right,
                    },
                )
            }
            Kind::WorkGroupId { .. } => (
                IterationParams::new(LINEAR_EXTENT, default_draw_commands(LINEAR_EXTENT.0)),
                Verifier::FullScreenColor(vec![BLUE]),
            ),
            Kind::NumWorkgroups {
                task_groups,
                mesh_groups,
            } => {
                let draw_cmd_args = task_groups.unwrap_or(mesh_groups);
                let extent = (Self::num_workgroups_width(task_groups, mesh_groups), 1);
                let draw_commands = vec![vk::DrawMeshTasksIndirectCommandEXT {
                    group_count_x: draw_cmd_args[0],
                    group_count_y: draw_cmd_args[1],
                    group_count_z: draw_cmd_args[2],
                }];
                (
                    IterationParams::new(extent, draw_commands),
                    Verifier::FullScreenColor(vec![BLUE]),
                )
            }
            Kind::LocalInvocation { .. } => (
                IterationParams::new(LINEAR_EXTENT, default_draw_commands(1)),
                Verifier::FullScreenColor(vec![BLUE]),
            ),
            Kind::GlobalInvocationId { .. } => (
                (IterationParams::new(
                    (GLOBAL_JOB_SIZE.0 * GLOBAL_JOB_SIZE.1, 1),
                    default_draw_commands(GLOBAL_JOB_SIZE.0),
                )),
                Verifier::FullScreenColor(vec![BLUE]),
            ),
            Kind::DrawIndex { .. } => {
                let commands = vec![
                    vk::DrawMeshTasksIndirectCommandEXT {
                        group_count_x: 1,
                        group_count_y: 1,
                        group_count_z: 1
                    };
                    LINEAR_EXTENT.0 as usize
                ];
                let mut params = IterationParams::new(LINEAR_EXTENT, commands);
                params.indirect = true;
                (params, Verifier::FullScreenColor(vec![BLUE]))
            }
            Kind::ViewIndex => {
                let mut params = default_params();
                params.num_layers = LAYER_COUNT;
                params.multiview = true;
                (params, Verifier::FullScreenColor(vec![BLUE, MAGENTA, CYAN, YELLOW]))
            }
            Kind::PrimitiveShadingRate { top_size, bottom_size } => {
                let mut params = default_params();
                params.fragment_size = Some(get_bad_shading_rate_size(&[top_size, bottom_size]));
                (params, Verifier::FullScreenColor(vec![BLUE]))
            }
            Kind::CullPrimitives => (
                default_params(),
                Verifier::Quadrants {
                    top_left: BLUE,
                    top_right: BLUE,
                    bottom_left: black,
                    bottom_right: black,
                },
            ),
        }
    }
}

struct MeshShaderBuiltinCase {
    name: String,
    kind: Kind,
}

impl TestCase for MeshShaderBuiltinCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.kind.check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.kind.programs()
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        let (params, verifier) = self.kind.instance_setup();
        Box::new(MeshShaderBuiltinInstance {
            context,
            params,
            verifier,
        })
    }
}

struct MeshShaderBuiltinInstance<'a> {
    context: &'a Context<'a>,
    params: IterationParams,
    verifier: Verifier,
}

impl TestInstance for MeshShaderBuiltinInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        run_builtin(self.context, &self.params, &self.verifier)
    }
}

/// `createMeshShaderBuiltinTestsEXT`
pub fn create_mesh_shader_builtin_tests_ext() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("builtin");

    let mut add = |name: &str, kind: Kind| {
        main_group.add_child(Box::new(MeshShaderBuiltinCase {
            name: name.to_string(),
            kind,
        }) as Box<dyn TestCase>);
    };

    add("position", Kind::Position);
    add("point_size", Kind::PointSize);
    add("clip_distance", Kind::ClipDistance { mixed: false });
    add("clip_distance_mix", Kind::ClipDistance { mixed: true });
    add("cull_distance", Kind::CullDistance { mixed: false });
    add("cull_distance_mix", Kind::CullDistance { mixed: true });
    add("primitive_id_glsl", Kind::PrimitiveIdGlsl);
    add("primitive_id_spirv", Kind::PrimitiveIdSpirv);
    add(
        "layer",
        Kind::Layer {
            write_val: true,
            share_vertices: false,
        },
    );
    add(
        "layer_shared",
        Kind::Layer {
            write_val: true,
            share_vertices: true,
        },
    );
    add(
        "layer_no_write",
        Kind::Layer {
            write_val: false,
            share_vertices: false,
        },
    );
    add(
        "viewport_index",
        Kind::ViewportIndex {
            write_val: true,
            share_vertices: false,
        },
    );
    add(
        "viewport_index_shared",
        Kind::ViewportIndex {
            write_val: true,
            share_vertices: true,
        },
    );
    add(
        "viewport_index_no_write",
        Kind::ViewportIndex {
            write_val: false,
            share_vertices: false,
        },
    );
    add("work_group_id_in_mesh", Kind::WorkGroupId { task_needed: false });
    add("work_group_id_in_task", Kind::WorkGroupId { task_needed: true });
    add(
        "num_work_groups_mesh",
        Kind::NumWorkgroups {
            task_groups: None,
            mesh_groups: [5, 6, 7],
        },
    );
    add(
        "num_work_groups_task_and_mesh",
        Kind::NumWorkgroups {
            task_groups: Some([2, 3, 4]),
            mesh_groups: [3, 4, 2],
        },
    );
    add(
        "local_invocation_id_in_mesh",
        Kind::LocalInvocation {
            task_needed: false,
            variable: LocalInvocation::Id,
        },
    );
    add(
        "local_invocation_id_in_task",
        Kind::LocalInvocation {
            task_needed: true,
            variable: LocalInvocation::Id,
        },
    );
    add(
        "local_invocation_index_in_task",
        Kind::LocalInvocation {
            task_needed: true,
            variable: LocalInvocation::Index,
        },
    );
    add(
        "local_invocation_index_in_mesh",
        Kind::LocalInvocation {
            task_needed: false,
            variable: LocalInvocation::Index,
        },
    );
    add(
        "global_invocation_id_in_mesh",
        Kind::GlobalInvocationId { task_needed: false },
    );
    add(
        "global_invocation_id_in_task",
        Kind::GlobalInvocationId { task_needed: true },
    );
    add("draw_index_in_mesh", Kind::DrawIndex { task_needed: false });
    add("draw_index_in_task", Kind::DrawIndex { task_needed: true });
    add("view_index", Kind::ViewIndex);
    add("cull_primitives", Kind::CullPrimitives);

    // Primitive shading rate tests.
    for top_size in FragmentSize::ALL {
        for bottom_size in FragmentSize::ALL {
            let top_extent = get_shading_rate_size(top_size);
            let bottom_extent = get_shading_rate_size(bottom_size);
            let test_name = format!(
                "primitive_shading_rate_{}x{}_{}x{}",
                top_extent.width, top_extent.height, bottom_extent.width, bottom_extent.height
            );
            add(&test_name, Kind::PrimitiveShadingRate { top_size, bottom_size });
        }
    }

    main_group
}

/// `createMeshShaderPipelineTestsEXT`: the clip and cull distance cases once more, with the pipelines of each non-monolithic construction type.
pub fn create_mesh_shader_pipeline_tests_ext() -> TestCaseGroup {
    use crate::vk::pipeline_construction::{PipelineConstructionType, with_construction_type};

    let mut main_group = TestCaseGroup::new("pipeline");
    let mut main_sub_group = TestCaseGroup::new("builtin");

    for (construction, name) in [
        (PipelineConstructionType::LinkTimeOptimizedLibrary, "optimized_lib"),
        (PipelineConstructionType::FastLinkedLibrary, "fast_lib"),
        (PipelineConstructionType::ShaderObjectUnlinkedSpirv, "shader_objects"),
    ] {
        let mut pipeline_group = TestCaseGroup::new(name);
        for (case_name, kind) in [
            ("clip_distance", Kind::ClipDistance { mixed: false }),
            ("cull_distance", Kind::CullDistance { mixed: false }),
            ("clip_distance_mix", Kind::ClipDistance { mixed: true }),
            ("cull_distance_mix", Kind::CullDistance { mixed: true }),
        ] {
            pipeline_group.add_child(Box::new(MeshShaderBuiltinCase {
                name: case_name.to_string(),
                kind,
            }) as Box<dyn TestCase>);
        }
        main_sub_group.add_child(with_construction_type(pipeline_group, construction));
    }

    main_group.add_child(main_sub_group);
    main_group
}
