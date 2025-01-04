// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderBuiltinTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are in shaders/manifest/mesh_shader_nv_builtin.toml, written by
// scripts/gen_mesh_shader_nv_builtin.py with what upstream formats into them. The verifiers are those of builtin_tests.rs.
//
// The VK_NV_mesh_shader form of builtin_tests.rs: one shared runner draws the case's mesh shading pipeline into an image (a layered
// framebuffer here, there is no multiview) and compares it, per layer, against flat colours, quadrants or a handful of pixels.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::NvMeshShaderExtensionDeviceCommands;

use crate::generated::shaders::mesh_shader_nv_builtin::{
    NV_BUILTIN_CLIP_DISTANCE, NV_BUILTIN_CULL_DISTANCE, NV_BUILTIN_DRAW_INDEX_MESH, NV_BUILTIN_DRAW_INDEX_TASK,
    NV_BUILTIN_GLOBAL_INVOCATION_ID_MESH, NV_BUILTIN_GLOBAL_INVOCATION_ID_TASK, NV_BUILTIN_LAYER,
    NV_BUILTIN_LAYER_SHARED, NV_BUILTIN_LOCAL_INVOCATION_ID_MESH, NV_BUILTIN_LOCAL_INVOCATION_ID_TASK,
    NV_BUILTIN_LOCAL_INVOCATION_INDEX_MESH, NV_BUILTIN_LOCAL_INVOCATION_INDEX_TASK, NV_BUILTIN_POINT_SIZE,
    NV_BUILTIN_POSITION, NV_BUILTIN_PRIMITIVE_ID_GLSL, NV_BUILTIN_PRIMITIVE_ID_SPIRV,
    NV_BUILTIN_PRIMITIVE_SHADING_RATE_1X1_1X1, NV_BUILTIN_PRIMITIVE_SHADING_RATE_1X1_2X1,
    NV_BUILTIN_PRIMITIVE_SHADING_RATE_1X1_2X2, NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X1_1X1,
    NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X1_2X1, NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X1_2X2,
    NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X2_1X1, NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X2_2X1,
    NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X2_2X2, NV_BUILTIN_VIEWPORT_INDEX, NV_BUILTIN_VIEWPORT_INDEX_SHARED,
    NV_BUILTIN_WORK_GROUP_ID_MESH, NV_BUILTIN_WORK_GROUP_ID_TASK,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::DescriptorSetLayoutBuilder;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d, viewport};
use crate::vkt::tests::mesh_shader::builtin_tests::{
    BLUE, CLEAR_COLOR, CYAN, MAGENTA, Verifier, WHITE, YELLOW, vulkan_12_features,
};
use crate::vkt::tests::mesh_shader::util::{
    FragmentSize, check_task_mesh_shader_support_nv, get_bad_shading_rate_size, get_shading_rate_size,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const DEFAULT_EXTENT: (u32, u32) = (8, 8);
const LINEAR_EXTENT: (u32, u32) = (8, 1);
const LAYER_COUNT: u32 = 4;
const QUADRANTS: u32 = 4;
const POINT_SIZE: f32 = 4.0;
/// `getLargeJobSize`: the number of tasks and the local size
const LARGE_JOB_SIZE: (u32, u32) = (8, 8);

/// `getDefaultDrawCommands`
fn default_draw_commands(task_count: u32) -> Vec<vk::DrawMeshTasksIndirectCommandNV> {
    vec![vk::DrawMeshTasksIndirectCommandNV {
        task_count,
        first_task: 0,
    }]
}

/// `IterationParams`
#[derive(Clone)]
struct IterationParams {
    color_extent: (u32, u32),
    num_layers: u32,
    indirect: bool,
    fragment_size: Option<FragmentSize>,
    draw_args: Vec<vk::DrawMeshTasksIndirectCommandNV>,
    /// If empty, a single default viewport is used.
    viewports: Vec<vk::Viewport>,
}

impl IterationParams {
    fn new(color_extent: (u32, u32), draw_args: Vec<vk::DrawMeshTasksIndirectCommandNV>) -> Self {
        Self {
            color_extent,
            num_layers: 1,
            indirect: false,
            fragment_size: None,
            draw_args,
            viewports: Vec::new(),
        }
    }
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
    let render_pass = make_render_pass(device, format)?;
    let framebuffer = make_framebuffer(
        device,
        *render_pass,
        &[*color_buffer_view],
        extent.width,
        extent.height,
        params.num_layers,
    )?;

    // Pipeline.
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

    let mut stages = Vec::new();
    if let Some(task) = &task_module {
        stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
    }
    stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_module));
    if let Some(frag) = &frag_module {
        stages.push((vk::ShaderStageFlags::FRAGMENT, **frag));
    }
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST);
    state.viewport_count = viewports.len() as u32;
    state.viewports = viewports.clone();
    state.scissors = scissors.clone();
    state.rasterization.depth_bias_enable = vk::FALSE;
    state.fragment_shading_rate_state = fragment_shading_rate_state;
    let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

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
        .render_area(scissors[0])
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
        device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
    }

    match &indirect_buffer {
        None => {
            for command in &params.draw_args {
                unsafe { device.cmd_draw_mesh_tasks_nv(cmd, command.task_count, command.first_task) };
            }
        }
        Some(buffer) => {
            let num_draws = params.draw_args.len() as u32;
            let stride = std::mem::size_of::<vk::DrawMeshTasksIndirectCommandNV>() as u32;
            unsafe { device.cmd_draw_mesh_tasks_indirect_nv(cmd, buffer.get(), 0, num_draws, stride) };
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

/// The case each upstream class covers, with what its `createInstance` chooses.
#[derive(Clone, Copy)]
enum Kind {
    Position,
    PointSize,
    ClipDistance,
    CullDistance,
    PrimitiveId {
        glsl_frag: bool,
    },
    Layer {
        share_vertices: bool,
    },
    ViewportIndex {
        share_vertices: bool,
    },
    WorkGroupId {
        task_needed: bool,
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
    PrimitiveShadingRate {
        top_size: FragmentSize,
        bottom_size: FragmentSize,
    },
}

impl Kind {
    fn task_needed(self) -> bool {
        match self {
            Kind::WorkGroupId { task_needed }
            | Kind::LocalInvocation { task_needed, .. }
            | Kind::GlobalInvocationId { task_needed }
            | Kind::DrawIndex { task_needed } => task_needed,
            _ => false,
        }
    }

    fn check_support(self, context: &Context<'_>) -> Result<(), TestError> {
        // `MeshShaderBuiltinCase::checkSupport`
        check_task_mesh_shader_support_nv(context, self.task_needed(), true)?;

        let features = context.get_device_features();
        let not_supported = |what: &str| {
            Err(TestError::NotSupported(format!(
                "Requested core feature is not supported: {what}"
            )))
        };

        match self {
            Kind::PrimitiveId { glsl_frag: true } => {
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
            Kind::ClipDistance => {
                if features.shader_clip_distance == vk::FALSE {
                    return not_supported("shaderClipDistance");
                }
            }
            Kind::CullDistance => {
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
            Kind::PrimitiveShadingRate { .. } => {
                context.require_device_functionality("VK_KHR_fragment_shading_rate")?
            }
            _ => {}
        }

        Ok(())
    }

    fn programs(self) -> BinaryCollection {
        match self {
            Kind::Position => NV_BUILTIN_POSITION.programs,
            Kind::PointSize => NV_BUILTIN_POINT_SIZE.programs,
            Kind::ClipDistance => NV_BUILTIN_CLIP_DISTANCE.programs,
            Kind::CullDistance => NV_BUILTIN_CULL_DISTANCE.programs,
            Kind::PrimitiveId { glsl_frag: true } => NV_BUILTIN_PRIMITIVE_ID_GLSL.programs,
            Kind::PrimitiveId { glsl_frag: false } => NV_BUILTIN_PRIMITIVE_ID_SPIRV.programs,
            Kind::Layer { share_vertices: false } => NV_BUILTIN_LAYER.programs,
            Kind::Layer { share_vertices: true } => NV_BUILTIN_LAYER_SHARED.programs,
            Kind::ViewportIndex { share_vertices: false } => NV_BUILTIN_VIEWPORT_INDEX.programs,
            Kind::ViewportIndex { share_vertices: true } => NV_BUILTIN_VIEWPORT_INDEX_SHARED.programs,
            Kind::WorkGroupId { task_needed: false } => NV_BUILTIN_WORK_GROUP_ID_MESH.programs,
            Kind::WorkGroupId { task_needed: true } => NV_BUILTIN_WORK_GROUP_ID_TASK.programs,
            Kind::LocalInvocation {
                task_needed: false,
                variable: LocalInvocation::Id,
            } => NV_BUILTIN_LOCAL_INVOCATION_ID_MESH.programs,
            Kind::LocalInvocation {
                task_needed: false,
                variable: LocalInvocation::Index,
            } => NV_BUILTIN_LOCAL_INVOCATION_INDEX_MESH.programs,
            Kind::LocalInvocation {
                task_needed: true,
                variable: LocalInvocation::Id,
            } => NV_BUILTIN_LOCAL_INVOCATION_ID_TASK.programs,
            Kind::LocalInvocation {
                task_needed: true,
                variable: LocalInvocation::Index,
            } => NV_BUILTIN_LOCAL_INVOCATION_INDEX_TASK.programs,
            Kind::GlobalInvocationId { task_needed: false } => NV_BUILTIN_GLOBAL_INVOCATION_ID_MESH.programs,
            Kind::GlobalInvocationId { task_needed: true } => NV_BUILTIN_GLOBAL_INVOCATION_ID_TASK.programs,
            Kind::DrawIndex { task_needed: false } => NV_BUILTIN_DRAW_INDEX_MESH.programs,
            Kind::DrawIndex { task_needed: true } => NV_BUILTIN_DRAW_INDEX_TASK.programs,
            Kind::PrimitiveShadingRate { top_size, bottom_size } => match (top_size, bottom_size) {
                (FragmentSize::Size2x2, FragmentSize::Size2x2) => NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X2_2X2.programs,
                (FragmentSize::Size2x2, FragmentSize::Size2x1) => NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X2_2X1.programs,
                (FragmentSize::Size2x2, FragmentSize::Size1x1) => NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X2_1X1.programs,
                (FragmentSize::Size2x1, FragmentSize::Size2x2) => NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X1_2X2.programs,
                (FragmentSize::Size2x1, FragmentSize::Size2x1) => NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X1_2X1.programs,
                (FragmentSize::Size2x1, FragmentSize::Size1x1) => NV_BUILTIN_PRIMITIVE_SHADING_RATE_2X1_1X1.programs,
                (FragmentSize::Size1x1, FragmentSize::Size2x2) => NV_BUILTIN_PRIMITIVE_SHADING_RATE_1X1_2X2.programs,
                (FragmentSize::Size1x1, FragmentSize::Size2x1) => NV_BUILTIN_PRIMITIVE_SHADING_RATE_1X1_2X1.programs,
                (FragmentSize::Size1x1, FragmentSize::Size1x1) => NV_BUILTIN_PRIMITIVE_SHADING_RATE_1X1_1X1.programs,
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
            Kind::PointSize | Kind::ClipDistance => (
                default_params(),
                Verifier::Quadrants {
                    top_left: BLUE,
                    top_right: black,
                    bottom_left: black,
                    bottom_right: black,
                },
            ),
            Kind::CullDistance => (
                default_params(),
                Verifier::Quadrants {
                    top_left: BLUE,
                    top_right: WHITE,
                    bottom_left: black,
                    bottom_right: black,
                },
            ),
            Kind::PrimitiveId { .. } => (default_params(), Verifier::FullScreenColor(vec![BLUE])),
            Kind::Layer { share_vertices } => {
                let num_work_groups = if share_vertices { 1 } else { LAYER_COUNT };

                let mut params = IterationParams::new(DEFAULT_EXTENT, default_draw_commands(num_work_groups));
                params.num_layers = LAYER_COUNT;
                (params, Verifier::FullScreenColor(vec![BLUE, MAGENTA, CYAN, YELLOW]))
            }
            Kind::ViewportIndex { share_vertices } => {
                let half_width = DEFAULT_EXTENT.0 as f32 / 2.0;
                let half_height = DEFAULT_EXTENT.1 as f32 / 2.0;

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
                        top_right: MAGENTA,
                        bottom_left: CYAN,
                        bottom_right: YELLOW,
                    },
                )
            }
            Kind::WorkGroupId { .. } => (
                IterationParams::new(LINEAR_EXTENT, default_draw_commands(LINEAR_EXTENT.0)),
                Verifier::FullScreenColor(vec![BLUE]),
            ),
            Kind::LocalInvocation { .. } => (
                IterationParams::new(LINEAR_EXTENT, default_draw_commands(1)),
                Verifier::FullScreenColor(vec![BLUE]),
            ),
            Kind::GlobalInvocationId { .. } => (
                IterationParams::new(
                    (LARGE_JOB_SIZE.0 * LARGE_JOB_SIZE.1, 1),
                    default_draw_commands(LARGE_JOB_SIZE.0),
                ),
                Verifier::FullScreenColor(vec![BLUE]),
            ),
            Kind::DrawIndex { .. } => {
                let commands = vec![
                    vk::DrawMeshTasksIndirectCommandNV {
                        task_count: 1,
                        first_task: 0
                    };
                    LINEAR_EXTENT.0 as usize
                ];
                let mut params = IterationParams::new(LINEAR_EXTENT, commands);
                params.indirect = true;
                (params, Verifier::FullScreenColor(vec![BLUE]))
            }
            Kind::PrimitiveShadingRate { top_size, bottom_size } => {
                let mut params = default_params();
                params.fragment_size = Some(get_bad_shading_rate_size(&[top_size, bottom_size]));
                (params, Verifier::FullScreenColor(vec![BLUE]))
            }
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

/// `createMeshShaderBuiltinTests`
pub fn create_mesh_shader_builtin_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("builtin");

    let mut add = |name: &str, kind: Kind| {
        main_group.add_child(Box::new(MeshShaderBuiltinCase {
            name: name.to_string(),
            kind,
        }) as Box<dyn TestCase>);
    };

    add("position", Kind::Position);
    add("point_size", Kind::PointSize);
    add("clip_distance", Kind::ClipDistance);
    add("cull_distance", Kind::CullDistance);
    add("primitive_id_glsl", Kind::PrimitiveId { glsl_frag: true });
    add("primitive_id_spirv", Kind::PrimitiveId { glsl_frag: false });
    add("layer", Kind::Layer { share_vertices: false });
    add("layer_shared", Kind::Layer { share_vertices: true });
    add("viewport_index", Kind::ViewportIndex { share_vertices: false });
    add("viewport_index_shared", Kind::ViewportIndex { share_vertices: true });
    add("work_group_id_in_mesh", Kind::WorkGroupId { task_needed: false });
    add("work_group_id_in_task", Kind::WorkGroupId { task_needed: true });
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
