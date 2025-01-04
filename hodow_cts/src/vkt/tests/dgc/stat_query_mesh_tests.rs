// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCStatQueryTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ext.stat_query.task_mesh_inv_*`: the task and mesh shader invocation statistics of two generated
// draw mesh tasks sequences (rows 0..3 and 3..8 of an 8x8 target, one triangle per pixel read from a storage buffer), with a single pipeline or an
// execution set of two pipelines / shader object sets whose task and mesh shaders differ. The programs are in
// `shaders/manifest/dgc_stat_query_mesh.toml` (`scripts/gen_dgc_stat_query_mesh_manifest.py`).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDeviceGeneratedCommandsExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::dgc_stat_query_mesh::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout_with_push_constants, make_render_pass,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{
    bind_shaders_with_nulls, copy_image_to_buffer, float_threshold_compare, push_back_element,
};
use crate::vkt::tests::dgc::graphics_mesh_util::{MeshPipeline, MeshPipelineOptions, MeshStages, build_mesh_pipeline};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::tests::draw::util::{ImageWithBuffer, begin_rendering, clear_value_color, end_rendering};
use crate::vkt::tests::shader_object::util::{
    ShaderObject, create_shader, get_mesh_shader_features, set_default_shader_object_dynamic_states, shader_create_info,
};
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const EXTENT: u32 = 8;
const SEQUENCE_COUNT: u32 = 2;
const MESH_WORK_GROUP_COUNTS: [u32; 2] = [3, 5]; // We make them not even.

#[derive(Clone, Copy, PartialEq, Eq)]
enum Construction {
    Monolithic,
    FastLib,
    ShaderObjects,
}

impl Construction {
    fn pipeline_construction_type(self) -> PipelineConstructionType {
        match self {
            Construction::Monolithic => PipelineConstructionType::Monolithic,
            Construction::FastLib => PipelineConstructionType::FastLinkedLibrary,
            Construction::ShaderObjects => PipelineConstructionType::ShaderObjectUnlinkedSpirv,
        }
    }

    fn name(self) -> &'static str {
        match self {
            Construction::Monolithic => "monolithic",
            Construction::FastLib => "fast_lib",
            Construction::ShaderObjects => "shader_obj",
        }
    }
}

#[derive(Clone, Copy)]
struct Params {
    construction: Construction,
    use_execution_set: bool,
    preprocess: bool,
}

impl Params {
    fn shader_stages() -> vk::ShaderStageFlags {
        vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::TASK_EXT | vk::ShaderStageFlags::MESH_EXT
    }

    /// `getShaderVariantCount` for the fragment (always one), task and mesh stages.
    fn variant_count(&self, stage: vk::ShaderStageFlags) -> u32 {
        if stage == vk::ShaderStageFlags::FRAGMENT || !self.use_execution_set {
            1
        } else {
            2
        }
    }
}

/// `StageInfo::getShaderIdxForSeq`: stage ids are fragment 0, task 1, mesh 2.
fn shader_idx_for_seq(stage_id: u32, seq_index: u32, variant_count: u32) -> u32 {
    (stage_id + seq_index) % variant_count
}

struct StatQueryMeshCase {
    name: String,
    params: Params,
}

impl TestCase for StatQueryMeshCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = self.params;
        let stages = Params::shader_stages();
        let use_eso = params.construction == Construction::ShaderObjects;
        let bind_stages = if params.use_execution_set {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        let (bind_stages_pipeline, bind_stages_shader_object) = if use_eso {
            (vk::ShaderStageFlags::empty(), bind_stages)
        } else {
            (bind_stages, vk::ShaderStageFlags::empty())
        };
        check_dgc_ext_support(
            context,
            stages,
            bind_stages_pipeline,
            bind_stages_shader_object,
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;

        context.require_device_functionality("VK_EXT_mesh_shader")?;
        let mesh_features = get_mesh_shader_features(context);
        if mesh_features.task_shader == vk::FALSE
            || mesh_features.mesh_shader == vk::FALSE
            || mesh_features.mesh_shader_queries == vk::FALSE
        {
            return Err(TestError::NotSupported("Mesh shader queries not supported".to_string()));
        }

        check_pipeline_construction_requirements(context, params.construction.pipeline_construction_type())?;
        if context.get_device_features().pipeline_statistics_query == vk::FALSE {
            return Err(TestError::NotSupported(
                "pipelineStatisticsQuery not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = if self.params.use_execution_set {
            "sq_mesh_ies"
        } else {
            "sq_mesh"
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StatQueryMeshInstance {
            context,
            params: self.params,
        })
    }
}

struct StatQueryMeshInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

fn eso_shader<'a>(
    device: &'a Device,
    stage: vk::ShaderStageFlags,
    flags: vk::ShaderCreateFlagsEXT,
    binary: &crate::vk::programs::ProgramBinary,
    set_layout: vk::DescriptorSetLayout,
    pc_range: vk::PushConstantRange,
) -> Result<ShaderObject<'a>, TestError> {
    let next_stage = if stage == vk::ShaderStageFlags::TASK_EXT {
        vk::ShaderStageFlags::MESH_EXT
    } else if stage == vk::ShaderStageFlags::MESH_EXT {
        vk::ShaderStageFlags::FRAGMENT
    } else {
        vk::ShaderStageFlags::empty()
    };
    let set_layouts = [set_layout];
    let create_info = shader_create_info(
        flags,
        stage,
        next_stage,
        vk::ShaderCodeTypeEXT::SPIRV,
        std::mem::size_of_val(binary.spirv),
        binary.spirv.as_ptr().cast(),
        &set_layouts,
        &[pc_range],
    );
    create_shader(device, &create_info)
}

impl TestInstance for StatQueryMeshInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let use_eso = params.construction == Construction::ShaderObjects;
        let shader_stages = Params::shader_stages();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let pixel_count = EXTENT * EXTENT;
        let clear_color: Vec4 = [0.0; 4];
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;

        let color_buffer = ImageWithBuffer::new(context, EXTENT, EXTENT, color_format, color_usage, 4)?;

        // One triangle per pixel.
        let half_pixel = (2.0 / EXTENT as f32) * 0.5;
        let normalize = |x: u32| (x as f32 + 0.5) / EXTENT as f32 * 2.0 - 1.0;
        let mut vertices: Vec<Vec4> = Vec::with_capacity(pixel_count as usize * 3);
        for y in 0..EXTENT {
            for x in 0..EXTENT {
                let x_center = normalize(x);
                let y_center = normalize(y);
                vertices.push([x_center - half_pixel, y_center + half_pixel, 0.0, 1.0]);
                vertices.push([x_center + half_pixel, y_center + half_pixel, 0.0, 1.0]);
                vertices.push([x_center, y_center - half_pixel, 0.0, 1.0]);
            }
        }
        let vert_buffer_size = std::mem::size_of_val(vertices.as_slice()) as vk::DeviceSize;
        let vert_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(vert_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = vert_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    vert_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        // Descriptor set (storage buffer with the positions) and push constant (the task shader row offset).
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, shader_stages)
            .build(device)?;
        let desc_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let desc_set = make_descriptor_set(device, *desc_pool, *set_layout)?;
        let buffer_desc = make_descriptor_buffer_info(vert_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(desc_set.get(), Location::binding(0), desc_type, &buffer_desc)
            .update(device);
        let pc_range = vk::PushConstantRange {
            stage_flags: shader_stages,
            offset: 0,
            size: 4,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        // Shaders: variant counts depend on the execution set.
        let task_count = params.variant_count(vk::ShaderStageFlags::TASK_EXT);
        let mesh_count = params.variant_count(vk::ShaderStageFlags::MESH_EXT);
        let frag_count = params.variant_count(vk::ShaderStageFlags::FRAGMENT);
        let max_graphics_pipelines = task_count.max(mesh_count).max(frag_count);
        let max_sequence_count = SEQUENCE_COUNT.max(max_graphics_pipelines);
        let binaries = context.get_binary_collection();

        let mut task_modules: Vec<Unique<'_, vk::ShaderModule>> = Vec::new();
        let mut mesh_modules: Vec<Unique<'_, vk::ShaderModule>> = Vec::new();
        let mut frag_modules: Vec<Unique<'_, vk::ShaderModule>> = Vec::new();
        let mut pipelines: Vec<MeshPipeline<'_>> = Vec::new();
        // Shader objects per pipeline i: (frag, task, mesh).
        let mut eso_shaders: Vec<[ShaderObject<'_>; 3]> = Vec::new();

        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;

        let shader_flags = if params.use_execution_set {
            vk::ShaderCreateFlagsEXT::INDIRECT_BINDABLE
        } else {
            vk::ShaderCreateFlagsEXT::empty()
        };

        if use_eso {
            for i in 0..max_graphics_pipelines {
                let task_idx = shader_idx_for_seq(1, i, task_count);
                let mesh_idx = shader_idx_for_seq(2, i, mesh_count);
                let frag_idx = shader_idx_for_seq(0, i, frag_count);
                let task_binary = binaries.get(&format!("task{task_idx}"))?;
                let mesh_binary = binaries.get(&format!("mesh{mesh_idx}"))?;
                let frag_binary = binaries.get(&format!("frag{frag_idx}"))?;
                eso_shaders.push([
                    eso_shader(
                        device,
                        vk::ShaderStageFlags::FRAGMENT,
                        shader_flags,
                        &frag_binary,
                        *set_layout,
                        pc_range,
                    )?,
                    eso_shader(
                        device,
                        vk::ShaderStageFlags::TASK_EXT,
                        shader_flags,
                        &task_binary,
                        *set_layout,
                        pc_range,
                    )?,
                    eso_shader(
                        device,
                        vk::ShaderStageFlags::MESH_EXT,
                        shader_flags,
                        &mesh_binary,
                        *set_layout,
                        pc_range,
                    )?,
                ]);
            }
        } else {
            for i in 0..task_count {
                task_modules.push(create_shader_module(device, binaries.get(&format!("task{i}"))?)?);
            }
            for i in 0..mesh_count {
                mesh_modules.push(create_shader_module(device, binaries.get(&format!("mesh{i}"))?)?);
            }
            for i in 0..frag_count {
                frag_modules.push(create_shader_module(device, binaries.get(&format!("frag{i}"))?)?);
            }
            for i in 0..max_graphics_pipelines {
                let task_idx = shader_idx_for_seq(1, i, task_count) as usize;
                let mesh_idx = shader_idx_for_seq(2, i, mesh_count) as usize;
                let frag_idx = shader_idx_for_seq(0, i, frag_count) as usize;
                pipelines.push(build_mesh_pipeline(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    &MeshStages {
                        task: Some(*task_modules[task_idx]),
                        mesh: *mesh_modules[mesh_idx],
                        frag: Some(*frag_modules[frag_idx]),
                    },
                    (EXTENT, EXTENT),
                    &MeshPipelineOptions {
                        indirect_bindable: params.use_execution_set,
                        rasterizer_discard: false,
                        fast_linked: params.construction == Construction::FastLib,
                        link_time_optimized: false,
                    },
                )?);
            }
        }

        // Execution set. Shader object slots are assigned per pipeline in the order fragment, task, mesh.
        let mut ies_shader_indices: Vec<Vec<u32>> = Vec::new();
        let mut execution_set_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if params.use_execution_set {
            let mut manager = if use_eso {
                let stage_infos: Vec<(vk::ShaderEXT, Vec<vk::DescriptorSetLayout>)> = eso_shaders[0]
                    .iter()
                    .map(|shader| (shader.get(), vec![*set_layout]))
                    .collect();
                let max_shader_count = max_graphics_pipelines * 5; // At most 5 stages per pipeline.
                let mut manager =
                    ExecutionSetManagerExt::new_shader(device, &stage_infos, &[pc_range], max_shader_count)?;
                let mut next_slot = 0u32;
                for shaders in &eso_shaders {
                    let mut seq_indices = Vec::new();
                    for shader in shaders {
                        manager.add_shader(next_slot, shader.get());
                        seq_indices.push(next_slot);
                        next_slot += 1;
                    }
                    ies_shader_indices.push(seq_indices);
                }
                manager
            } else {
                let mut manager = ExecutionSetManagerExt::new_pipeline(device, *pipelines[0], max_graphics_pipelines)?;
                for (i, pipeline) in pipelines.iter().enumerate() {
                    manager.add_pipeline(i as u32, **pipeline);
                }
                manager
            };
            manager.update();
            execution_set_manager = Some(manager);
        }

        // Indirect commands layout.
        let mut cmds_layout_flags = vk::IndirectCommandsLayoutUsageFlagsEXT::empty();
        if params.preprocess {
            cmds_layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS;
        }
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_flags, shader_stages, *pipeline_layout);
        if params.use_execution_set {
            let ies_set_type = if use_eso {
                vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
            } else {
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
            };
            cmds_layout_builder.add_execution_set_token(0, ies_set_type, shader_stages);
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_push_constant_token(offset, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_mesh_tasks_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..max_sequence_count {
            if params.use_execution_set {
                if use_eso {
                    for idx in &ies_shader_indices[i as usize] {
                        dgc_data.push(*idx);
                    }
                } else {
                    dgc_data.push(i);
                }
            }
            let prev_wgs: u32 = MESH_WORK_GROUP_COUNTS[..i as usize].iter().sum();
            push_back_element(&mut dgc_data, &prev_wgs);
            let draw_cmd = vk::DrawMeshTasksIndirectCommandEXT {
                group_count_x: MESH_WORK_GROUP_COUNTS[i as usize],
                group_count_y: 1,
                group_count_z: 1,
            };
            push_back_element(&mut dgc_data, &draw_cmd);
        }
        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = dgc_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let ies_handle = execution_set_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);
        let preprocess_pipeline = if ies_handle != vk::IndirectExecutionSetEXT::null() || use_eso {
            vk::Pipeline::null()
        } else {
            *pipelines[0]
        };
        let mut preprocess_shaders: Vec<vk::ShaderEXT> = Vec::new();
        if use_eso && ies_handle == vk::IndirectExecutionSetEXT::null() {
            preprocess_shaders.extend(eso_shaders[0].iter().map(ShaderObject::get));
        }
        let preprocess_buffer = PreprocessBufferExt::new_with_shaders(
            context,
            ies_handle,
            cmds_layout.get(),
            max_sequence_count,
            0,
            preprocess_pipeline,
            &preprocess_shaders,
            0,
        )?;
        let gen_cmds_info = if ies_handle == vk::IndirectExecutionSetEXT::null() && !preprocess_shaders.is_empty() {
            DgcGenCmdsInfo::new_with_shaders(
                shader_stages,
                ies_handle,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                max_sequence_count,
                0,
                0,
                &preprocess_shaders,
            )
        } else {
            DgcGenCmdsInfo::new(
                shader_stages,
                ies_handle,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                max_sequence_count,
                0,
                0,
                preprocess_pipeline,
            )
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        let preprocess_owner = if params.preprocess {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::PRIMARY,
            )?)
        } else {
            None
        };

        // Query pool (task and mesh shader invocations), reset in its own submission.
        let stats = vk::QueryPipelineStatisticFlags::TASK_SHADER_INVOCATIONS_EXT
            | vk::QueryPipelineStatisticFlags::MESH_SHADER_INVOCATIONS_EXT;
        let qp_create_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::PIPELINE_STATISTICS)
            .query_count(1)
            .pipeline_statistics(stats);
        let query_pool = unsafe { device.create_query_pool(&qp_create_info, None) }.vk_check("vkCreateQueryPool")?;
        let query_pool = Unique::new(device, query_pool);
        {
            let reset_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let reset_cmd = reset_owner.get();
            begin_command_buffer(device, reset_cmd)?;
            unsafe { device.cmd_reset_query_pool(reset_cmd, *query_pool, 0, 1) };
            end_command_buffer(device, reset_cmd)?;
            submit_commands_and_wait(device, queue, reset_cmd)?;
        }

        begin_command_buffer(device, cmd_buffer)?;
        let render_area = make_rect_2d(0, 0, EXTENT, EXTENT);
        if use_eso {
            let image = color_buffer.image.get();
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                image,
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[barrier],
                );
            }
            begin_rendering(
                device,
                cmd_buffer,
                *color_buffer.view,
                render_area,
                clear_value_color(clear_color),
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::CLEAR,
                vk::RenderingFlags::empty(),
                1,
                0,
            );
        } else {
            begin_render_pass(
                device,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                render_area,
                clear_value_color(clear_color),
            );
        }

        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        unsafe {
            device.cmd_bind_descriptor_sets(cmd_buffer, bind_point, *pipeline_layout, 0, &[desc_set.get()], &[]);
        }
        if use_eso {
            let given = [
                (vk::ShaderStageFlags::FRAGMENT, eso_shaders[0][0].get()),
                (vk::ShaderStageFlags::TASK_EXT, eso_shaders[0][1].get()),
                (vk::ShaderStageFlags::MESH_EXT, eso_shaders[0][2].get()),
            ];
            bind_shaders_with_nulls(context, cmd_buffer, &given);
            set_default_shader_object_dynamic_states(
                device,
                cmd_buffer,
                context.get_device_extensions(),
                vk::PrimitiveTopology::TRIANGLE_LIST,
                true,
                true,
                EXTENT,
                EXTENT,
            );
        } else {
            unsafe { device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipelines[0]) };
        }

        unsafe { device.cmd_begin_query(cmd_buffer, *query_pool, 0, vk::QueryControlFlags::empty()) };
        if let Some(preprocess_cmd_owner) = &preprocess_owner {
            let preprocess_cmd = preprocess_cmd_owner.get();
            begin_command_buffer(device, preprocess_cmd)?;
            unsafe { device.cmd_preprocess_generated_commands_ext(preprocess_cmd, gen_cmds_info.get(), cmd_buffer) };
            preprocess_to_execute_barrier_ext(device, preprocess_cmd);
            end_command_buffer(device, preprocess_cmd)?;
        }
        unsafe {
            device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, gen_cmds_info.get());
            device.cmd_end_query(cmd_buffer, *query_pool, 0);
        }
        if use_eso {
            end_rendering(device, cmd_buffer);
        } else {
            end_render_pass(device, cmd_buffer);
        }
        copy_image_to_buffer(
            device,
            cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            EXTENT,
            EXTENT,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_owner
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |owner| owner.get()),
        )?;

        let mut fail = false;

        // Verify the colors: the task shader index is the red channel and a mesh shader index above zero forces green.
        {
            let result = color_buffer.read_bytes(device)?;
            let seq_index_for_row = |row: u32| -> u32 {
                let mut prev_rows = 0u32;
                for (seq_index, row_count) in MESH_WORK_GROUP_COUNTS.iter().enumerate() {
                    if prev_rows + row_count > row {
                        return seq_index as u32;
                    }
                    prev_rows += row_count;
                }
                u32::MAX
            };
            let mut reference: Vec<Vec4> = vec![clear_color; pixel_count as usize];
            for y in 0..EXTENT {
                let seq_index = seq_index_for_row(y);
                let task_id = shader_idx_for_seq(1, seq_index, task_count);
                let mesh_id = shader_idx_for_seq(2, seq_index, mesh_count);
                let expected: Vec4 = [task_id as f32, if mesh_id > 0 { 1.0 } else { 0.0 }, 1.0, 1.0];
                for x in 0..EXTENT {
                    reference[(y * EXTENT + x) as usize] = expected;
                }
            }
            if !float_threshold_compare(result, &reference, [0.0; 4]) {
                fail = true;
            }
        }

        // Verify the query: task invocations first, then mesh invocations (ascending stat bits).
        {
            let mut query_result_bytes = [0u8; 8];
            unsafe {
                device
                    .get_query_pool_results(
                        *query_pool,
                        0,
                        1,
                        &mut query_result_bytes,
                        4,
                        vk::QueryResultFlags::WAIT,
                    )
                    .vk_check("vkGetQueryPoolResults")?;
            }
            let task_result = u32::from_ne_bytes([
                query_result_bytes[0],
                query_result_bytes[1],
                query_result_bytes[2],
                query_result_bytes[3],
            ]);
            let mesh_result = u32::from_ne_bytes([
                query_result_bytes[4],
                query_result_bytes[5],
                query_result_bytes[6],
                query_result_bytes[7],
            ]);

            let task_work_group_size = 32u32;
            let expected_task = EXTENT * task_work_group_size;
            if task_result != expected_task {
                fail = true;
                log::error!("Expected {expected_task} task shader invocations but found {task_result}");
            }
            let mesh_work_group_size = 64u32;
            let expected_mesh = pixel_count * mesh_work_group_size;
            if mesh_result != expected_mesh {
                fail = true;
                log::error!("Expected {expected_mesh} mesh shader invocations but found {mesh_result}");
            }
        }

        drop(execution_set_manager);
        if fail {
            return Ok(TestStatus::fail("Unexpected results; check log for details"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `populateStatQueryTestGroup` for the `task_mesh_inv` statistic: the cases by their full dotted path in `dgc`.
pub fn create_dgc_stat_query_mesh_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for construction in [
        Construction::Monolithic,
        Construction::FastLib,
        Construction::ShaderObjects,
    ] {
        for use_execution_set in [false, true] {
            for preprocess in [false, true] {
                let name = format!(
                    "task_mesh_inv_{}{}{}",
                    construction.name(),
                    if use_execution_set { "_ies" } else { "" },
                    if preprocess { "_preprocess" } else { "" },
                );
                cases.push((
                    format!("ext.stat_query.{name}"),
                    Box::new(StatQueryMeshCase {
                        name,
                        params: Params {
                            construction,
                            use_execution_set,
                            preprocess,
                        },
                    }) as Box<dyn TestCase>,
                ));
            }
        }
    }
    cases
}
