// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCStatQueryTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Copyright (c) 2026 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The vertex, tessellation, geometry and fragment stat cases (`input_vert`, `input_prim`, `vert_inv`,
// `geom_inv`, `geom_prim`, `frag_inv`, `tesc_patch`, `tese_inv`) built as monolithic pipelines or fast linked libraries (64 names). Task and mesh
// stats and the shader object construction stay gated. The programs are in `shaders/manifest/dgc_stat_query.toml` (`scripts/gen_dgc_stat_query_manifest.py`).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtDeviceGeneratedCommandsExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::dgc_stat_query::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_range};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    allocate_command_buffer, make_command_pool, make_framebuffer, make_pipeline_layout_with_push_constants,
    make_render_pass,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{
    Construction, PipelineOptions, StageModules, bind_shader_object_state, bind_shaders_with_nulls,
    build_draw_pipeline, copy_image_to_buffer, float_threshold_compare, push_back_element,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::tests::draw::util::{ImageWithBuffer, begin_rendering, clear_value_color, end_rendering};
use crate::vkt::tests::shader_object::util::{ShaderObject, create_shader, shader_create_info};
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const EXTENT: u32 = 8;

#[derive(Clone, Copy, PartialEq, Eq)]
enum Stat {
    InputVert,
    InputPrim,
    VertInv,
    FragInv,
    TescPatch,
    TeseInv,
    GeomInv,
    GeomPrim,
}

impl Stat {
    fn flags(self) -> vk::QueryPipelineStatisticFlags {
        match self {
            Stat::InputVert => vk::QueryPipelineStatisticFlags::INPUT_ASSEMBLY_VERTICES,
            Stat::InputPrim => vk::QueryPipelineStatisticFlags::INPUT_ASSEMBLY_PRIMITIVES,
            Stat::VertInv => vk::QueryPipelineStatisticFlags::VERTEX_SHADER_INVOCATIONS,
            Stat::FragInv => vk::QueryPipelineStatisticFlags::FRAGMENT_SHADER_INVOCATIONS,
            Stat::TescPatch => vk::QueryPipelineStatisticFlags::TESSELLATION_CONTROL_SHADER_PATCHES,
            Stat::TeseInv => vk::QueryPipelineStatisticFlags::TESSELLATION_EVALUATION_SHADER_INVOCATIONS,
            Stat::GeomInv => vk::QueryPipelineStatisticFlags::GEOMETRY_SHADER_INVOCATIONS,
            Stat::GeomPrim => vk::QueryPipelineStatisticFlags::GEOMETRY_SHADER_PRIMITIVES,
        }
    }

    fn name(self) -> &'static str {
        match self {
            Stat::InputVert => "input_vert",
            Stat::InputPrim => "input_prim",
            Stat::VertInv => "vert_inv",
            Stat::FragInv => "frag_inv",
            Stat::TescPatch => "tesc_patch",
            Stat::TeseInv => "tese_inv",
            Stat::GeomInv => "geom_inv",
            Stat::GeomPrim => "geom_prim",
        }
    }
}

#[derive(Clone, Copy)]
struct TestParams {
    stat: Stat,
    construction: Construction,
    /// Unlinked SPIR-V shader objects instead of pipelines (`construction` is then monolithic and unused).
    shader_objects: bool,
    use_execution_set: bool,
    preprocess: bool,
}

impl TestParams {
    fn construction_type(&self) -> PipelineConstructionType {
        match self.construction {
            Construction::Monolithic => PipelineConstructionType::Monolithic,
            Construction::FastLinked => PipelineConstructionType::FastLinkedLibrary,
            Construction::LinkTimeOptimized => PipelineConstructionType::LinkTimeOptimizedLibrary,
        }
    }

    fn needs_tessellation(&self) -> bool {
        matches!(self.stat, Stat::TescPatch | Stat::TeseInv)
    }

    fn needs_geometry(&self) -> bool {
        matches!(self.stat, Stat::GeomInv | Stat::GeomPrim)
    }

    fn shader_stage_flags(&self) -> vk::ShaderStageFlags {
        let mut flags = vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT;
        if self.needs_tessellation() {
            flags |= vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION;
        }
        if self.needs_geometry() {
            flags |= vk::ShaderStageFlags::GEOMETRY;
        }
        flags
    }

    /// `getShaderVariantCount(VK_SHADER_STAGE_VERTEX_BIT)`: the vertex shader stats are the ones that vary it.
    fn vert_shader_count(&self) -> u32 {
        let varies = matches!(
            self.stat,
            Stat::InputVert | Stat::InputPrim | Stat::VertInv | Stat::GeomPrim | Stat::TeseInv
        );
        if self.use_execution_set && varies { 2 } else { 1 }
    }

    /// 0 when the stage is not used.
    fn tesc_shader_count(&self) -> u32 {
        if !self.needs_tessellation() {
            0
        } else if self.use_execution_set && self.stat == Stat::TescPatch {
            2
        } else {
            1
        }
    }

    fn tese_shader_count(&self) -> u32 {
        u32::from(self.needs_tessellation())
    }

    fn geom_shader_count(&self) -> u32 {
        if !self.needs_geometry() {
            0
        } else if self.use_execution_set && self.stat == Stat::GeomInv {
            2
        } else {
            1
        }
    }

    /// `getShaderVariantCount(VK_SHADER_STAGE_FRAGMENT_BIT)`
    fn frag_shader_count(&self) -> u32 {
        if self.use_execution_set && self.stat == Stat::FragInv {
            2
        } else {
            1
        }
    }

    /// Triangle strips for the frag shader stat case.
    fn use_triangle_strip(&self) -> bool {
        self.stat == Stat::FragInv
    }
}

struct StatQueryCase {
    name: String,
    params: TestParams,
}

impl TestCase for StatQueryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = self.params;
        let stages = params.shader_stage_flags();
        let bind_stages = if params.use_execution_set {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        let (bind_stages_pipeline, bind_stages_shader_object) = if params.shader_objects {
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
        if params.shader_objects {
            context.require_device_functionality("VK_EXT_shader_object")?;
        }

        check_pipeline_construction_requirements(context, params.construction_type())?;

        if params.needs_tessellation() && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("tessellationShader not supported".to_string()));
        }
        if params.needs_geometry() && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("geometryShader not supported".to_string()));
        }
        if context.get_device_features().pipeline_statistics_query == vk::FALSE {
            return Err(TestError::NotSupported(
                "pipelineStatisticsQuery not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == "stat_query_vert_frag")
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(StatQueryInstance {
            context,
            params: self.params,
        })
    }
}

struct StatQueryInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

impl TestInstance for StatQueryInstance<'_> {
    /// `iterate`, vertex and fragment stats
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let stage_flags = params.shader_stage_flags();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
        let pixel_count = EXTENT * EXTENT;
        let use_triangle_strip = params.use_triangle_strip();
        let vert_count = params.vert_shader_count();
        let frag_count = params.frag_shader_count();
        let tesc_count = params.tesc_shader_count();
        let tese_count = params.tese_shader_count();
        let geom_count = params.geom_shader_count();
        let max_graphics_pipelines = vert_count
            .max(tesc_count)
            .max(tese_count)
            .max(geom_count)
            .max(frag_count);
        let max_sequence_count = 2u32.max(max_graphics_pipelines);

        let color_buffer = ImageWithBuffer::new(context, EXTENT, EXTENT, color_format, color_usage, 4)?;

        let vertices: Vec<Vec4> = if use_triangle_strip {
            // Two half-screen quads (horizontal division).
            vec![
                [-1.0, -1.0, 0.0, 1.0],
                [-1.0, 0.0, 0.0, 1.0],
                [1.0, -1.0, 0.0, 1.0],
                [1.0, 0.0, 0.0, 1.0],
                [-1.0, 0.0, 0.0, 1.0],
                [-1.0, 1.0, 0.0, 1.0],
                [1.0, 0.0, 0.0, 1.0],
                [1.0, 1.0, 0.0, 1.0],
            ]
        } else {
            // One triangle per pixel for the other cases.
            let half_pixel = (2.0 / EXTENT as f32) * 0.5;
            let normalize = |x: u32| (x as f32 + 0.5) / EXTENT as f32 * 2.0 - 1.0;
            let mut vertices = Vec::with_capacity((pixel_count * 3) as usize);
            for y in 0..EXTENT {
                for x in 0..EXTENT {
                    let x_center = normalize(x);
                    let y_center = normalize(y);
                    vertices.push([x_center - half_pixel, y_center + half_pixel, 0.0, 1.0]);
                    vertices.push([x_center + half_pixel, y_center + half_pixel, 0.0, 1.0]);
                    vertices.push([x_center, y_center - half_pixel, 0.0, 1.0]);
                }
            }
            vertices
        };
        let vert_buffer_size = std::mem::size_of_val(vertices.as_slice()) as vk::DeviceSize;
        let vert_buffer = crate::vk::obj_util::BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            crate::vk::obj_util::make_buffer_create_info(vert_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = vert_buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    vert_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[], &[])?;
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], EXTENT, EXTENT, 1)?;

        let binaries = context.get_binary_collection();
        let mut vert_modules = Vec::new();
        for i in 0..vert_count {
            vert_modules.push(create_shader_module(device, binaries.get(&format!("vert{i}"))?)?);
        }
        let mut frag_modules = Vec::new();
        for i in 0..frag_count {
            frag_modules.push(create_shader_module(device, binaries.get(&format!("frag{i}"))?)?);
        }

        let mut tesc_modules = Vec::new();
        for i in 0..tesc_count {
            tesc_modules.push(create_shader_module(device, binaries.get(&format!("tesc{i}"))?)?);
        }
        let mut tese_modules = Vec::new();
        for i in 0..tese_count {
            tese_modules.push(create_shader_module(device, binaries.get(&format!("tese{i}"))?)?);
        }
        let mut geom_modules = Vec::new();
        for i in 0..geom_count {
            geom_modules.push(create_shader_module(device, binaries.get(&format!("geom{i}"))?)?);
        }

        // Sequential stage ids of the stages in use (vertex, tessellation control, evaluation, geometry, fragment). They are added to the
        // sequence index to mix the shaders of each pipeline.
        let stage_ids = {
            let mut next_id = 0u32;
            let mut take = |count: u32| {
                if count == 0 {
                    None
                } else {
                    next_id += 1;
                    Some(next_id - 1)
                }
            };
            let vert = take(vert_count);
            let tesc = take(tesc_count);
            let tese = take(tese_count);
            let geom = take(geom_count);
            let frag = take(frag_count);
            (vert.unwrap_or(0), tesc, tese, geom, frag.unwrap_or(0))
        };
        let idx_for_seq = |stage_id: u32, count: u32, seq: u32| ((stage_id + seq) % count) as usize;
        let vert_idx_for_seq = |seq: u32| idx_for_seq(stage_ids.0, vert_count, seq);
        let frag_idx_for_seq = |seq: u32| idx_for_seq(stage_ids.4, frag_count, seq);
        let optional_idx_for_seq =
            |stage_id: Option<u32>, count: u32, seq: u32| stage_id.map(|id| idx_for_seq(id, count, seq));

        // Shader objects of each pipeline in the order vertex, tessellation control, evaluation, geometry, fragment (only the used ones).
        let mut eso_shaders: Vec<Vec<(vk::ShaderStageFlags, ShaderObject<'_>)>> = Vec::new();
        if params.shader_objects {
            let eso_flags = if params.use_execution_set {
                vk::ShaderCreateFlagsEXT::INDIRECT_BINDABLE
            } else {
                vk::ShaderCreateFlagsEXT::empty()
            };
            let make_eso = |stage: vk::ShaderStageFlags, next_stage: vk::ShaderStageFlags, name: String| {
                let binary = binaries.get(&name)?;
                let create_info = shader_create_info(
                    eso_flags,
                    stage,
                    next_stage,
                    vk::ShaderCodeTypeEXT::SPIRV,
                    std::mem::size_of_val(binary.spirv),
                    binary.spirv.as_ptr().cast(),
                    &[],
                    &[],
                );
                Ok::<_, TestError>((stage, create_shader(device, &create_info)?))
            };
            for i in 0..max_graphics_pipelines {
                let has_tess = optional_idx_for_seq(stage_ids.1, tesc_count, i).is_some();
                let has_geom = optional_idx_for_seq(stage_ids.3, geom_count, i).is_some();
                let after_tess = if has_geom {
                    vk::ShaderStageFlags::GEOMETRY
                } else {
                    vk::ShaderStageFlags::FRAGMENT
                };
                let vert_next = if has_tess {
                    vk::ShaderStageFlags::TESSELLATION_CONTROL
                } else {
                    after_tess
                };
                let mut set = vec![make_eso(
                    vk::ShaderStageFlags::VERTEX,
                    vert_next,
                    format!("vert{}", vert_idx_for_seq(i)),
                )?];
                if let Some(idx) = optional_idx_for_seq(stage_ids.1, tesc_count, i) {
                    set.push(make_eso(
                        vk::ShaderStageFlags::TESSELLATION_CONTROL,
                        vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                        format!("tesc{idx}"),
                    )?);
                }
                if let Some(idx) = optional_idx_for_seq(stage_ids.2, tese_count, i) {
                    set.push(make_eso(
                        vk::ShaderStageFlags::TESSELLATION_EVALUATION,
                        after_tess,
                        format!("tese{idx}"),
                    )?);
                }
                if let Some(idx) = optional_idx_for_seq(stage_ids.3, geom_count, i) {
                    set.push(make_eso(
                        vk::ShaderStageFlags::GEOMETRY,
                        vk::ShaderStageFlags::FRAGMENT,
                        format!("geom{idx}"),
                    )?);
                }
                set.push(make_eso(
                    vk::ShaderStageFlags::FRAGMENT,
                    vk::ShaderStageFlags::empty(),
                    format!("frag{}", frag_idx_for_seq(i)),
                )?);
                eso_shaders.push(set);
            }
        }

        let mut pipelines = Vec::new();
        for i in 0..if params.shader_objects {
            0
        } else {
            max_graphics_pipelines
        } {
            pipelines.push(build_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &StageModules {
                    vert: *vert_modules[vert_idx_for_seq(i)],
                    tesc: optional_idx_for_seq(stage_ids.1, tesc_count, i).map(|idx| *tesc_modules[idx]),
                    tese: optional_idx_for_seq(stage_ids.2, tese_count, i).map(|idx| *tese_modules[idx]),
                    geom: optional_idx_for_seq(stage_ids.3, geom_count, i).map(|idx| *geom_modules[idx]),
                    frag: *frag_modules[frag_idx_for_seq(i)],
                },
                &PipelineOptions {
                    extent: (EXTENT, EXTENT),
                    topology: if use_triangle_strip {
                        vk::PrimitiveTopology::TRIANGLE_STRIP
                    } else if params.needs_tessellation() {
                        vk::PrimitiveTopology::PATCH_LIST
                    } else {
                        vk::PrimitiveTopology::TRIANGLE_LIST
                    },
                    patch_control_points: if params.needs_tessellation() { 3 } else { 0 },
                    dynamic_stride: false,
                    dynamic_patch_control_points: false,
                    no_vertex_input: false,
                    extra_attribute: false,
                    indirect_bindable: params.use_execution_set,
                    construction: params.construction,
                    depth_test: false,
                    rendering: None,
                },
            )?);
        }

        let mut ies_manager: Option<ExecutionSetManagerExt<'_>> = None;
        let mut ies_shader_indices: Vec<Vec<u32>> = Vec::new();
        if params.use_execution_set {
            let mut manager = if params.shader_objects {
                let stage_infos: Vec<(vk::ShaderEXT, Vec<vk::DescriptorSetLayout>)> = eso_shaders[0]
                    .iter()
                    .map(|(_, shader)| (shader.get(), Vec::new()))
                    .collect();
                let max_shader_count = max_graphics_pipelines * 5; // At most 5 stages per pipeline.
                let mut manager = ExecutionSetManagerExt::new_shader(device, &stage_infos, &[], max_shader_count)?;
                let mut next_slot = 0u32;
                for set in &eso_shaders {
                    let mut seq_indices = Vec::new();
                    for (_, shader) in set {
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
            ies_manager = Some(manager);
        }

        let mut cmds_layout_flags = vk::IndirectCommandsLayoutUsageFlagsEXT::empty();
        if params.preprocess {
            cmds_layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS;
        }
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_flags, stage_flags, *pipeline_layout);
        if params.use_execution_set {
            let ies_type = if params.shader_objects {
                vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
            } else {
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
            };
            cmds_layout_builder.add_execution_set_token(0, ies_type, stage_flags);
        }
        let stream_range = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_token(stream_range);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let vertex_count_per_seq = vertices.len() as u32 / max_sequence_count;
        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..max_sequence_count {
            if params.use_execution_set {
                if params.shader_objects {
                    dgc_data.extend_from_slice(&ies_shader_indices[i as usize]);
                } else {
                    dgc_data.push(i);
                }
            }
            let draw_cmd = vk::DrawIndirectCommand {
                vertex_count: vertex_count_per_seq,
                instance_count: 1,
                first_vertex: i * vertex_count_per_seq,
                first_instance: 0,
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
            unsafe {
                std::ptr::copy_nonoverlapping(
                    dgc_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    dgc_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let ies_handle = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);
        let preprocess_pipeline = if ies_handle != vk::IndirectExecutionSetEXT::null() || params.shader_objects {
            vk::Pipeline::null()
        } else {
            *pipelines[0]
        };
        let mut preprocess_shaders: Vec<vk::ShaderEXT> = Vec::new();
        if params.shader_objects && ies_handle == vk::IndirectExecutionSetEXT::null() {
            preprocess_shaders.extend(eso_shaders[0].iter().map(|(_, shader)| shader.get()));
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
                stage_flags,
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
                stage_flags,
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
        let preprocess_cmd_owner = if params.preprocess {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::PRIMARY,
            )?)
        } else {
            None
        };
        let preprocess_cmd = preprocess_cmd_owner
            .as_ref()
            .map_or(vk::CommandBuffer::null(), |owner| owner.get());

        let query_pool_create_info = vk::QueryPoolCreateInfo {
            query_type: vk::QueryType::PIPELINE_STATISTICS,
            query_count: 1,
            pipeline_statistics: params.stat.flags(),
            ..Default::default()
        };
        let query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_create_info, None) }.vk_check("vkCreateQueryPool")?,
        );
        let reset_cmd_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, reset_cmd_owner.get())?;
        unsafe { device.cmd_reset_query_pool(reset_cmd_owner.get(), *query_pool, 0, 1) };
        end_command_buffer(device, reset_cmd_owner.get())?;
        submit_commands_and_wait(device, queue, reset_cmd_owner.get())?;

        begin_command_buffer(device, cmd_buffer)?;
        if params.shader_objects {
            let barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::ImageLayout::UNDEFINED,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                color_buffer.image.get(),
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
                make_rect_2d(0, 0, EXTENT, EXTENT),
                clear_value_color([0.0; 4]),
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
                make_rect_2d(0, 0, EXTENT, EXTENT),
                vk::ClearValue {
                    color: vk::ClearColorValue { float32: [0.0; 4] },
                },
            );
        }
        unsafe { device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vert_buffer.get()], &[0]) };
        if params.shader_objects {
            let given: Vec<(vk::ShaderStageFlags, vk::ShaderEXT)> = eso_shaders[0]
                .iter()
                .map(|(stage, shader)| (*stage, shader.get()))
                .collect();
            bind_shaders_with_nulls(context, cmd_buffer, &given);
            let vertex_bindings = [vk::VertexInputBindingDescription2EXT {
                binding: 0,
                stride: std::mem::size_of::<Vec4>() as u32,
                input_rate: vk::VertexInputRate::VERTEX,
                divisor: 1,
                ..Default::default()
            }];
            let vertex_attributes = [vk::VertexInputAttributeDescription2EXT {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
                ..Default::default()
            }];
            let topology = if use_triangle_strip {
                vk::PrimitiveTopology::TRIANGLE_STRIP
            } else if params.needs_tessellation() {
                vk::PrimitiveTopology::PATCH_LIST
            } else {
                vk::PrimitiveTopology::TRIANGLE_LIST
            };
            bind_shader_object_state(
                context,
                cmd_buffer,
                topology,
                if params.needs_tessellation() { 3 } else { 0 },
                (EXTENT, EXTENT),
                Some((&vertex_bindings[..], &vertex_attributes[..])),
            );
        } else {
            unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipelines[0]) };
        }
        unsafe { device.cmd_begin_query(cmd_buffer, *query_pool, 0, vk::QueryControlFlags::empty()) };
        if params.preprocess {
            begin_command_buffer(device, preprocess_cmd)?;
            unsafe { device.cmd_preprocess_generated_commands_ext(preprocess_cmd, gen_cmds_info.get(), cmd_buffer) };
            preprocess_to_execute_barrier_ext(device, preprocess_cmd);
            end_command_buffer(device, preprocess_cmd)?;
        }
        unsafe {
            device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, gen_cmds_info.get());
            device.cmd_end_query(cmd_buffer, *query_pool, 0);
        }
        if params.shader_objects {
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
        submit_and_wait_with_preprocess(device, queue, cmd_buffer, preprocess_cmd)?;

        let mut fail = false;

        // Verify the color buffer.
        {
            let pixels_per_seq = pixel_count / max_sequence_count;
            let swizzle = |color: Vec4| [color[1], color[2], color[0], color[3]];
            let mut reference: Vec<Vec4> = Vec::with_capacity(pixel_count as usize);
            for pixel_index in 0..pixel_count {
                let seq_index = pixel_index / pixels_per_seq;
                // Base value for R changes in the vertex shader.
                let vert_id = vert_idx_for_seq(seq_index);
                let mut expected_color: Vec4 = [vert_id as f32, 0.0, 1.0, 1.0];
                // Maybe force green.
                if let Some(tesc_id) = optional_idx_for_seq(stage_ids.1, tesc_count, seq_index)
                    && tesc_id > 0
                {
                    expected_color[1] = 1.0;
                }
                // Maybe invert RGB.
                if let Some(tese_id) = optional_idx_for_seq(stage_ids.2, tese_count, seq_index)
                    && tese_id > 0
                {
                    expected_color = [
                        1.0 - expected_color[0],
                        1.0 - expected_color[1],
                        1.0 - expected_color[2],
                        2.0 - expected_color[3],
                    ];
                }
                // Maybe swizzle.
                if let Some(geom_id) = optional_idx_for_seq(stage_ids.3, geom_count, seq_index)
                    && geom_id > 0
                {
                    expected_color = swizzle(expected_color);
                }
                // Maybe swizzle again.
                let frag_id = frag_idx_for_seq(seq_index);
                if frag_id > 0 {
                    expected_color = swizzle(expected_color);
                }
                reference.push(expected_color);
            }
            let result = color_buffer.read_bytes(device)?;
            if !float_threshold_compare(result, &reference, [0.0; 4]) {
                fail = true;
            }
        }

        // Verify the query.
        {
            let mut query_result_bytes = [0u8; 4];
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
            let result = u32::from_ne_bytes(query_result_bytes);
            let vertex_count = vertices.len() as u32;
            match params.stat {
                Stat::InputVert => {
                    if result != vertex_count {
                        fail = true;
                        log::error!("Expected {vertex_count} input assembly vertices but found {result}");
                    }
                }
                Stat::InputPrim => {
                    let expected = if use_triangle_strip { 2 } else { pixel_count };
                    if result != expected {
                        fail = true;
                        log::error!("Expected {expected} input assembly primitives but found {result}");
                    }
                }
                Stat::VertInv => {
                    if result < vertex_count {
                        fail = true;
                        log::error!("Expected at least {vertex_count} vertex shader invocations but found {result}");
                    }
                }
                Stat::TescPatch => {
                    if result != pixel_count {
                        fail = true;
                        log::error!("Expected {pixel_count} tessellation control shader patches but found {result}");
                    }
                }
                Stat::TeseInv => {
                    if result < vertex_count {
                        fail = true;
                        log::error!(
                            "Expected at least {vertex_count} tessellation evaluation shader invocations but found {result}"
                        );
                    }
                }
                Stat::GeomInv | Stat::GeomPrim => {
                    let primitives = if use_triangle_strip { 2 } else { pixel_count };
                    let needs_exact = params.stat == Stat::GeomPrim;
                    let bad = if needs_exact {
                        result != primitives
                    } else {
                        result < primitives
                    };
                    if bad {
                        fail = true;
                        log::error!(
                            "Expected {} {primitives} geometry shader {} but found {result}",
                            if needs_exact { "" } else { "at least" },
                            if needs_exact { "primitives" } else { "invocations" },
                        );
                    }
                }
                Stat::FragInv => {
                    // Implementations may reuse fragment shader invocations when fragment shading rate is supported.
                    let (max_fragment_width, max_fragment_height) = if context
                        .is_device_functionality_supported("VK_KHR_fragment_shading_rate")
                    {
                        let mut fsr_properties = vk::PhysicalDeviceFragmentShadingRatePropertiesKHR::default();
                        {
                            let mut properties2 =
                                vk::PhysicalDeviceProperties2::builder().push_next(&mut fsr_properties);
                            unsafe {
                                context
                                    .get_instance()
                                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
                            };
                        }
                        (
                            fsr_properties.max_fragment_size.width.max(1),
                            fsr_properties.max_fragment_size.height.max(1),
                        )
                    } else {
                        (1, 1)
                    };
                    let min_cols = EXTENT / max_fragment_width;
                    let min_rows = EXTENT / max_fragment_height;
                    let minimum = (min_cols * min_rows).max(1);
                    if result < minimum {
                        fail = true;
                        log::error!("Expected at least {minimum} fragment shader invocations but found {result}");
                    }
                }
            }
        }

        drop(preprocess_buffer);
        drop(ies_manager);

        if fail {
            return Ok(TestStatus::fail("Unexpected results; check log for details -- "));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// The vertex and fragment cases of `populateStatQueryTestGroup`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_stat_query_gfx_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();
    for stat in [
        Stat::InputVert,
        Stat::InputPrim,
        Stat::VertInv,
        Stat::GeomInv,
        Stat::GeomPrim,
        Stat::FragInv,
        Stat::TescPatch,
        Stat::TeseInv,
    ] {
        for (construction, construction_name, shader_objects) in [
            (Construction::Monolithic, "monolithic", false),
            (Construction::FastLinked, "fast_lib", false),
            (Construction::Monolithic, "shader_obj", true),
        ] {
            for use_execution_set in [false, true] {
                for preprocess in [false, true] {
                    let name = format!(
                        "{}_{construction_name}{}{}",
                        stat.name(),
                        if use_execution_set { "_ies" } else { "" },
                        if preprocess { "_preprocess" } else { "" },
                    );
                    cases.push((
                        format!("ext.stat_query.{name}"),
                        Box::new(StatQueryCase {
                            name,
                            params: TestParams {
                                stat,
                                construction,
                                shader_objects,
                                use_execution_set,
                                preprocess,
                            },
                        }) as Box<dyn TestCase>,
                    ));
                }
            }
        }
    }
    cases
}
