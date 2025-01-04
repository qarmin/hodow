// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderSmokeTestsEXT.cpp (`SharedFragLibraryInstance`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `shared_frag_library*` cases of the `optimized_lib` and `fast_lib` groups: one fragment shader library, one fragment output
// library and one vertex input library are shared by a classic and a mesh pipeline, each linked from its own pre-rasterization library, and both are drawn in the same render
// pass (gl_Layer) or in two (gl_PrimitiveID). The `shader_objects` variants (`shared_frag_shader*`) are `iterate_shader_objects`: one vertex, mesh and fragment shader object, bound per draw inside dynamic rendering. The shaders are written by `scripts/gen_mesh_smoke_shared_frag.py` into
// `shaders/manifest/mesh_shader_smoke_shared_frag.toml`; the failure messages of single pixels are not logged.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtMeshShaderExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands, Handle, InstanceV1_1,
};

use super::smoke_tests::color_bytes;
use super::util::check_task_mesh_shader_support_ext;
use crate::generated::shaders::mesh_shader_smoke_shared_frag::ALL_SHARED_PROGRAM;
use crate::tcu::vector::IVec2;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
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
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout, make_render_pass,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::shader_object::util::{
    bind_graphics_shaders, bind_null_task_mesh_shaders, create_shader, get_mesh_shader_features,
    set_default_shader_object_dynamic_states, shader_create_info,
};
use crate::vkt::{Context, TestInstance};

const FB_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `SharedFragLibraryCase::getLayerColors`
const LAYER_COLORS: [[f32; 4]; 3] = [[0.0, 0.0, 0.0, 1.0], [1.0, 0.0, 1.0, 1.0], [1.0, 1.0, 0.0, 1.0]];

/// `SharedFragLibraryParams`
#[derive(Clone, Copy)]
pub struct SharedFragLibraryParams {
    pub construction: PipelineConstructionType,
    /// false: test gl_Layer; true: test gl_PrimitiveID.
    pub primitive_id: bool,
    /// false: classic + mesh, true: mesh + classic.
    pub mesh_first: bool,
    /// true: add custom extra input in the frag shader.
    pub extra_input: bool,
}

/// `SharedFragLibraryCase::checkSupport`
pub fn check_support(context: &Context<'_>, params: &SharedFragLibraryParams) -> Result<(), TestError> {
    check_task_mesh_shader_support_ext(context, false, true)?;

    if params.primitive_id {
        // When using gl_PrimitiveID in the frag shader, glslang will add "OpCapability Geometry" to it.
        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("geometryShader not supported".to_string()));
        }
    } else if context.api_version() < (1, 2, 0) {
        context.require_device_functionality("VK_EXT_shader_viewport_index_layer")?;
    } else {
        // More fine-grained: we do not need shaderViewportIndex.
        let mut vulkan12 = vk::PhysicalDeviceVulkan12Features::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut vulkan12);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if vulkan12.shader_output_layer == vk::FALSE {
            return Err(TestError::NotSupported("shaderOutputLayer not supported".to_string()));
        }
    }

    check_pipeline_construction_requirements(context, params.construction)
}

/// The shaders of a variant, as the case's program collection
pub fn programs(params: &SharedFragLibraryParams) -> BinaryCollection {
    let key = format!(
        "shared_frag_{}{}",
        if params.primitive_id { "primid" } else { "layer" },
        if params.extra_input { "_extra" } else { "" }
    );
    ALL_SHARED_PROGRAM
        .iter()
        .find(|program| program.name == key)
        .map_or(BinaryCollection::new(&[]), |program| program.programs)
}

/// `SharedFragLibraryInstance`
pub struct SharedFragLibraryInstance<'a> {
    pub context: &'a Context<'a>,
    pub params: SharedFragLibraryParams,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawType {
    Classic,
    Mesh,
}

fn create_library<'d>(
    device: &'d Device,
    info: vk::GraphicsPipelineCreateInfoBuilder<'_>,
) -> Result<Unique<'d, vk::Pipeline>, TestError> {
    let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

fn make_library_info(flags: vk::GraphicsPipelineLibraryFlagsEXT) -> vk::GraphicsPipelineLibraryCreateInfoEXT {
    vk::GraphicsPipelineLibraryCreateInfoEXT::builder().flags(flags).build()
}

/// A colour image of `layers` layers, its array view and a host buffer for a copy of all of them
struct LayeredColorBuffer<'a> {
    image: ImageWithMemory<'a>,
    view: Unique<'a, vk::ImageView>,
    buffer: BufferWithMemory<'a>,
}

impl<'a> LayeredColorBuffer<'a> {
    fn new(context: &'a Context<'a>, width: u32, height: u32, layers: u32) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let mut info = make_image_create_info(
            IVec2::new(width as i32, height as i32),
            FB_FORMAT,
            vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::COLOR_ATTACHMENT,
        );
        info.array_layers = layers;
        let image = ImageWithMemory::new(device, allocator, info, MemoryRequirement::ANY)?;
        let view = make_image_view(
            device,
            image.get(),
            if layers > 1 {
                vk::ImageViewType::_2D_ARRAY
            } else {
                vk::ImageViewType::_2D
            },
            FB_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layers),
        )?;
        let buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                (width * height * layers * 4) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        Ok(Self { image, view, buffer })
    }
}

impl TestInstance for SharedFragLibraryInstance<'_> {
    /// `SharedFragLibraryInstance::iterate` for the library construction types
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();

        let clear_color = LAYER_COLORS[0];
        let layer_count: u32 = if params.primitive_id {
            1
        } else {
            LAYER_COLORS.len() as u32
        };
        let fb_width = 1u32;
        let fb_height: u32 = if params.primitive_id { 2 } else { 1 };
        let optimized = params.construction == PipelineConstructionType::LinkTimeOptimizedLibrary;
        let lib_extra_flags = if optimized {
            vk::PipelineCreateFlags::RETAIN_LINK_TIME_OPTIMIZATION_INFO_EXT
        } else {
            vk::PipelineCreateFlags::empty()
        };
        let lib_compile_flags = vk::PipelineCreateFlags::LIBRARY_KHR | lib_extra_flags;
        let pipeline_link_flags = if optimized {
            vk::PipelineCreateFlags::LINK_TIME_OPTIMIZATION_EXT
        } else {
            vk::PipelineCreateFlags::empty()
        };

        // When using layer, use a single framebuffer and draw twice in the same render pass. When using primitive ID, use two framebuffers: draw to the
        // first one with a normal pipeline and to the second one with a mesh pipeline. The framebuffer is then 2 pixels tall so each triangle draws a pixel.
        let mut used_draws = [DrawType::Classic, DrawType::Mesh];
        if params.mesh_first {
            used_draws.swap(0, 1);
        }
        let rp_setups: Vec<Vec<DrawType>> = if params.primitive_id {
            vec![vec![used_draws[0]], vec![used_draws[1]]]
        } else {
            vec![vec![used_draws[0], used_draws[1]]]
        };
        let fb_count = rp_setups.len();

        let color_buffers = (0..fb_count)
            .map(|_| LayeredColorBuffer::new(context, fb_width, fb_height, layer_count))
            .collect::<Result<Vec<_>, _>>()?;
        let render_pass = make_render_pass(device, FB_FORMAT)?;
        let framebuffers = color_buffers
            .iter()
            .map(|color_buffer| {
                make_framebuffer(
                    device,
                    *render_pass,
                    &[*color_buffer.view],
                    fb_width,
                    fb_height,
                    layer_count,
                )
            })
            .collect::<Result<Vec<_>, _>>()?;

        if params.construction.is_shader_object() {
            return self.iterate_shader_objects(
                &color_buffers,
                &rp_setups,
                layer_count,
                fb_width,
                fb_height,
                clear_color,
            );
        }

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let binaries = context.get_binary_collection();
        let vert_binary = if context.api_version() >= (1, 2, 0) {
            binaries.get("vert_1_2")?
        } else {
            binaries.get("vert")?
        };
        let vert_module = create_shader_module(device, vert_binary)?;
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: fb_width as f32,
            height: fb_height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, fb_width, fb_height)];
        let color_blend_attachment = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(
                vk::ColorComponentFlags::R
                    | vk::ColorComponentFlags::G
                    | vk::ColorComponentFlags::B
                    | vk::ColorComponentFlags::A,
            )
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::CLEAR)
            .attachments(&color_blend_attachment);
        let multisample_state = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .sample_shading_enable(false)
            .min_sample_shading(1.0);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .primitive_restart_enable(false);
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

        let entry = c"main";
        let make_stage = |stage: vk::ShaderStageFlags, module: vk::ShaderModule| {
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(stage)
                .module(module)
                .name(entry.to_bytes_with_nul())
                .build()
        };
        // Fragment output state library (common).
        let mut frag_output_lib_info =
            make_library_info(vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_OUTPUT_INTERFACE);
        let frag_output_lib = create_library(
            device,
            vk::GraphicsPipelineCreateInfo::builder()
                .flags(lib_compile_flags)
                .layout(*pipeline_layout)
                .render_pass(*render_pass)
                .color_blend_state(&color_blend_state)
                .multisample_state(&multisample_state)
                .push_next(&mut frag_output_lib_info),
        )?;

        // Fragment shader lib (shared among the classic and mesh pipelines).
        let frag_stages = [make_stage(vk::ShaderStageFlags::FRAGMENT, *frag_module)];
        let mut frag_shader_lib_info = make_library_info(vk::GraphicsPipelineLibraryFlagsEXT::FRAGMENT_SHADER);
        let frag_shader_lib = create_library(
            device,
            vk::GraphicsPipelineCreateInfo::builder()
                .flags(lib_compile_flags)
                .layout(*pipeline_layout)
                .render_pass(*render_pass)
                .multisample_state(&multisample_state)
                .depth_stencil_state(&depth_stencil_state)
                .stages(&frag_stages)
                .push_next(&mut frag_shader_lib_info),
        )?;

        // Vertex input state (common, but should be unused by the mesh shading pipeline).
        let mut vertex_input_lib_info = make_library_info(vk::GraphicsPipelineLibraryFlagsEXT::VERTEX_INPUT_INTERFACE);
        let vertex_input_lib = create_library(
            device,
            vk::GraphicsPipelineCreateInfo::builder()
                .flags(lib_compile_flags)
                .layout(*pipeline_layout)
                .vertex_input_state(&vertex_input_state)
                .input_assembly_state(&input_assembly_state)
                .push_next(&mut vertex_input_lib_info),
        )?;

        // Pre-rasterization shader libs.
        let vert_stages = [make_stage(vk::ShaderStageFlags::VERTEX, *vert_module)];
        let mut pre_rast_classic_lib_info =
            make_library_info(vk::GraphicsPipelineLibraryFlagsEXT::PRE_RASTERIZATION_SHADERS);
        let pre_rast_classic_lib = create_library(
            device,
            vk::GraphicsPipelineCreateInfo::builder()
                .flags(lib_compile_flags)
                .layout(*pipeline_layout)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization_state)
                .render_pass(*render_pass)
                .stages(&vert_stages)
                .push_next(&mut pre_rast_classic_lib_info),
        )?;
        let mesh_stages = [make_stage(vk::ShaderStageFlags::MESH_EXT, *mesh_module)];
        let mut pre_rast_mesh_lib_info =
            make_library_info(vk::GraphicsPipelineLibraryFlagsEXT::PRE_RASTERIZATION_SHADERS);
        let pre_rast_mesh_lib = create_library(
            device,
            vk::GraphicsPipelineCreateInfo::builder()
                .flags(lib_compile_flags)
                .layout(*pipeline_layout)
                .viewport_state(&viewport_state)
                .rasterization_state(&rasterization_state)
                .render_pass(*render_pass)
                .stages(&mesh_stages)
                .push_next(&mut pre_rast_mesh_lib_info),
        )?;

        // Pipelines.
        let classic_libs = [
            *vertex_input_lib,
            *pre_rast_classic_lib,
            *frag_shader_lib,
            *frag_output_lib,
        ];
        let mesh_libs = [
            *vertex_input_lib,
            *pre_rast_mesh_lib,
            *frag_shader_lib,
            *frag_output_lib,
        ];
        let mut classic_link_info = vk::PipelineLibraryCreateInfoKHR::builder().libraries(&classic_libs);
        let mut mesh_link_info = vk::PipelineLibraryCreateInfoKHR::builder().libraries(&mesh_libs);
        let classic_pipeline = create_library(
            device,
            vk::GraphicsPipelineCreateInfo::builder()
                .flags(pipeline_link_flags)
                .layout(*pipeline_layout)
                .push_next(&mut classic_link_info),
        )?;
        let mesh_pipeline = create_library(
            device,
            vk::GraphicsPipelineCreateInfo::builder()
                .flags(pipeline_link_flags)
                .layout(*pipeline_layout)
                .push_next(&mut mesh_link_info),
        )?;

        // Record commands with both pipelines.
        let cmd_pool = make_command_pool(device, queue_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();
        begin_command_buffer(device, cmd)?;

        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue { float32: clear_color },
        };
        for (i, rp_setup) in rp_setups.iter().enumerate() {
            begin_render_pass(device, cmd, *render_pass, *framebuffers[i], scissors[0], clear_value);
            for draw_type in rp_setup {
                unsafe {
                    match draw_type {
                        DrawType::Classic => {
                            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *classic_pipeline);
                            device.cmd_draw(cmd, 4, 1, 0, 0);
                        }
                        DrawType::Mesh => {
                            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *mesh_pipeline);
                            device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1);
                        }
                    }
                }
            }
            end_render_pass(device, cmd);
        }

        record_copy_to_buffers(device, cmd, &color_buffers, layer_count, fb_width, fb_height);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        validate_color_buffers(device, params, &color_buffers, fb_width, fb_height, layer_count)
    }
}

impl SharedFragLibraryInstance<'_> {
    /// `SharedFragLibraryInstance::iterate` for the shader object construction types: the vertex, mesh and fragment shaders are separate objects and the
    /// first draw binds its state in full (the upstream pipeline wrapper), the second one only swaps the vertex and mesh shaders.
    fn iterate_shader_objects(
        &self,
        color_buffers: &[LayeredColorBuffer<'_>],
        rp_setups: &[Vec<DrawType>],
        layer_count: u32,
        fb_width: u32,
        fb_height: u32,
        clear_color: [f32; 4],
    ) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();

        let binaries = context.get_binary_collection();
        let vert_binary = if context.api_version() >= (1, 2, 0) {
            binaries.get("vert_1_2")?
        } else {
            binaries.get("vert")?
        };
        let mesh_binary = binaries.get("mesh")?;
        let frag_binary = binaries.get("frag")?;

        let vert_info = shader_create_info(
            vk::ShaderCreateFlagsEXT::empty(),
            vk::ShaderStageFlags::VERTEX,
            vk::ShaderStageFlags::FRAGMENT,
            vk::ShaderCodeTypeEXT::SPIRV,
            std::mem::size_of_val(vert_binary.spirv),
            vert_binary.spirv.as_ptr().cast(),
            &[],
            &[],
        );
        let mesh_info = shader_create_info(
            vk::ShaderCreateFlagsEXT::NO_TASK_SHADER,
            vk::ShaderStageFlags::MESH_EXT,
            vk::ShaderStageFlags::FRAGMENT,
            vk::ShaderCodeTypeEXT::SPIRV,
            std::mem::size_of_val(mesh_binary.spirv),
            mesh_binary.spirv.as_ptr().cast(),
            &[],
            &[],
        );
        let frag_info = shader_create_info(
            vk::ShaderCreateFlagsEXT::empty(),
            vk::ShaderStageFlags::FRAGMENT,
            vk::ShaderStageFlags::empty(),
            vk::ShaderCodeTypeEXT::SPIRV,
            std::mem::size_of_val(frag_binary.spirv),
            frag_binary.spirv.as_ptr().cast(),
            &[],
            &[],
        );
        let vert_shader = create_shader(device, &vert_info)?;
        let mesh_shader = create_shader(device, &mesh_info)?;
        let frag_shader = create_shader(device, &frag_info)?;

        let mesh_features = get_mesh_shader_features(context);
        let scissor = make_rect_2d(0, 0, fb_width, fb_height);
        let color_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layer_count);

        let cmd_pool = make_command_pool(device, queue_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();
        begin_command_buffer(device, cmd)?;

        // Transition color attachment layouts manually.
        let barriers: Vec<vk::ImageMemoryBarrier> = color_buffers
            .iter()
            .map(|color_buffer| {
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_buffer.image.get(),
                    color_range,
                )
            })
            .collect();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &barriers,
            );
        }

        let clear_value = vk::ClearValue {
            color: vk::ClearColorValue { float32: clear_color },
        };
        let mut eso_state_bound = false;
        for (i, rp_setup) in rp_setups.iter().enumerate() {
            let color_attachment = [vk::RenderingAttachmentInfo::builder()
                .image_view(*color_buffers[i].view)
                .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .resolve_mode(vk::ResolveModeFlags::NONE)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .clear_value(clear_value)
                .build()];
            let rendering_info = vk::RenderingInfo::builder()
                .render_area(scissor)
                .layer_count(layer_count)
                .view_mask(0)
                .color_attachments(&color_attachment);
            unsafe { device.cmd_begin_rendering(cmd, &rendering_info) };

            for draw_type in rp_setup {
                match draw_type {
                    DrawType::Classic => {
                        if !eso_state_bound {
                            bind_graphics_shaders(
                                device,
                                cmd,
                                vert_shader.get(),
                                vk::ShaderEXT::null(),
                                vk::ShaderEXT::null(),
                                vk::ShaderEXT::null(),
                                frag_shader.get(),
                                mesh_features.task_shader != vk::FALSE,
                                mesh_features.mesh_shader != vk::FALSE,
                            );
                            set_default_shader_object_dynamic_states(
                                device,
                                cmd,
                                context.get_device_extensions(),
                                vk::PrimitiveTopology::TRIANGLE_STRIP,
                                false,
                                false,
                                fb_width,
                                fb_height,
                            );
                            bind_null_task_mesh_shaders(device, cmd, &mesh_features);
                            eso_state_bound = true;
                        } else {
                            unsafe {
                                device.cmd_bind_shaders_ext(
                                    cmd,
                                    &[vk::ShaderStageFlags::MESH_EXT, vk::ShaderStageFlags::VERTEX],
                                    &[vk::ShaderEXT::null(), vert_shader.get()],
                                );
                                device.cmd_set_primitive_topology_ext(cmd, vk::PrimitiveTopology::TRIANGLE_STRIP);
                                device.cmd_set_primitive_restart_enable_ext(cmd, false);
                                device.cmd_set_vertex_input_ext(
                                    cmd,
                                    &[] as &[vk::VertexInputBindingDescription2EXT],
                                    &[] as &[vk::VertexInputAttributeDescription2EXT],
                                );
                            }
                        }
                        unsafe { device.cmd_draw(cmd, 4, 1, 0, 0) };
                    }
                    DrawType::Mesh => {
                        if !eso_state_bound {
                            unsafe {
                                device.cmd_bind_shaders_ext(
                                    cmd,
                                    &[
                                        vk::ShaderStageFlags::VERTEX,
                                        vk::ShaderStageFlags::TESSELLATION_CONTROL,
                                        vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                                        vk::ShaderStageFlags::GEOMETRY,
                                        vk::ShaderStageFlags::FRAGMENT,
                                        vk::ShaderStageFlags::TASK_EXT,
                                        vk::ShaderStageFlags::MESH_EXT,
                                    ],
                                    &[
                                        vk::ShaderEXT::null(),
                                        vk::ShaderEXT::null(),
                                        vk::ShaderEXT::null(),
                                        vk::ShaderEXT::null(),
                                        frag_shader.get(),
                                        vk::ShaderEXT::null(),
                                        mesh_shader.get(),
                                    ],
                                );
                            }
                            set_default_shader_object_dynamic_states(
                                device,
                                cmd,
                                context.get_device_extensions(),
                                vk::PrimitiveTopology::TRIANGLE_STRIP,
                                true,
                                false,
                                fb_width,
                                fb_height,
                            );
                            eso_state_bound = true;
                        } else {
                            unsafe {
                                device.cmd_bind_shaders_ext(
                                    cmd,
                                    &[vk::ShaderStageFlags::VERTEX, vk::ShaderStageFlags::MESH_EXT],
                                    &[vk::ShaderEXT::null(), mesh_shader.get()],
                                );
                            }
                        }
                        unsafe { device.cmd_draw_mesh_tasks_ext(cmd, 1, 1, 1) };
                    }
                }
            }

            unsafe { device.cmd_end_rendering(cmd) };
        }

        record_copy_to_buffers(device, cmd, color_buffers, layer_count, fb_width, fb_height);
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, queue, cmd)?;

        validate_color_buffers(device, params, color_buffers, fb_width, fb_height, layer_count)
    }
}

/// The copy of every colour buffer to its host buffer
fn record_copy_to_buffers(
    device: &Device,
    cmd: vk::CommandBuffer,
    color_buffers: &[LayeredColorBuffer<'_>],
    layer_count: u32,
    fb_width: u32,
    fb_height: u32,
) {
    // Copy color buffers to verification buffers.
    for color_buffer in color_buffers {
        let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layer_count);
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_buffer.image.get(),
            range,
        );
        let copy_region = make_buffer_image_copy(
            vk::Extent3D {
                width: fb_width,
                height: fb_height,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, layer_count),
        );
        let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color_buffer.image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
    }
}

/// The colour check at the end of `SharedFragLibraryInstance::iterate`
fn validate_color_buffers(
    device: &Device,
    params: SharedFragLibraryParams,
    color_buffers: &[LayeredColorBuffer<'_>],
    fb_width: u32,
    fb_height: u32,
    layer_count: u32,
) -> TestOutcome {
    // Validate color buffer.
    let mut fail = false;
    for (i, color_buffer) in color_buffers.iter().enumerate() {
        invalidate_alloc(device, color_buffer.buffer.get_allocation())?;
        let byte_count = (fb_width * fb_height * layer_count * 4) as usize;
        // SAFETY: the buffer is host visible, `byte_count` long and was just invalidated.
        let result =
            unsafe { std::slice::from_raw_parts(color_buffer.buffer.get_allocation().get_host_ptr(), byte_count) };
        for z in 0..layer_count {
            for y in 0..fb_height {
                for x in 0..fb_width {
                    let expected_color = if params.primitive_id {
                        [LAYER_COLORS[2][0], LAYER_COLORS[2][1], y as f32, 1.0]
                    } else {
                        LAYER_COLORS[z as usize]
                    };
                    let offset = (((z * fb_height + y) * fb_width + x) * 4) as usize;
                    if result[offset..offset + 4] != color_bytes(expected_color) {
                        log::info!(
                            "Unexpected color at framebuffer {i} coordinates (x={x}, y={y}, layer={z}): expected {expected_color:?} but found {:?}",
                            &result[offset..offset + 4]
                        );
                        fail = true;
                    }
                }
            }
        }
    }

    if fail {
        return Ok(TestStatus::fail(
            "Unexpected color found in framebuffer; check log for details --",
        ));
    }
    Ok(TestStatus::pass("Pass"))
}
