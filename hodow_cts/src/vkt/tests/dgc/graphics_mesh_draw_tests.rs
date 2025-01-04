// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMeshTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_mesh_draw.toml`
// (`scripts/gen_dgc_mesh_draw_manifest.py`), one shared set per (indirect, task shader, execution set) combination. `ext.graphics.mesh.token_draw`
// and `token_draw_count`: a 32x32 framebuffer with a triangle around the centre of each pixel, drawn by 8 (direct) or 4 (indirect count) generated
// draw mesh tasks sequences, optionally with task shaders, execution sets (pipelines or shader objects), explicit preprocessing and unordered
// sequences.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtDeviceGeneratedCommandsExtensionDeviceCommands;

use crate::generated::shaders::dgc_mesh_draw::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
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
use crate::vk::programs::{BinaryCollection, ProgramBinary, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::{
    bind_shaders_with_nulls, copy_image_to_buffer, float_threshold_compare, push_back_element, write_host_buffer,
};
use crate::vkt::tests::dgc::graphics_mesh_util::{MeshPipeline, MeshPipelineOptions, MeshStages, build_mesh_pipeline};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, device_generated_commands_properties, preprocess_to_execute_barrier_ext,
};
use crate::vkt::tests::draw::util::{ImageWithBuffer, begin_rendering, clear_value_color, end_rendering};
use crate::vkt::tests::shader_object::util::{
    ShaderObject, create_shader, set_default_shader_object_dynamic_states, shader_create_info,
};
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const SEQUENCE_COUNT_DIRECT: u32 = 8;
const SEQUENCE_COUNT_INDIRECT: u32 = SEQUENCE_COUNT_DIRECT / 2;
const PER_TRIANGLE_VERTICES: u32 = 3;
const WIDTH: u32 = 32;
const HEIGHT: u32 = 32;

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawType {
    Direct,
    Indirect,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PipelineType {
    Monolithic,
    ShaderObjects,
    GplFast,
    GplOptimized,
    GplMixBaseFast,
    GplMixBaseOpt,
}

impl PipelineType {
    fn is_shader_objects(self) -> bool {
        self == PipelineType::ShaderObjects
    }

    fn is_gpl_mix(self) -> bool {
        matches!(self, PipelineType::GplMixBaseFast | PipelineType::GplMixBaseOpt)
    }

    fn numeric(self) -> u32 {
        match self {
            PipelineType::Monolithic => 0,
            PipelineType::ShaderObjects => 1,
            PipelineType::GplFast => 2,
            PipelineType::GplOptimized => 3,
            PipelineType::GplMixBaseFast => 4,
            PipelineType::GplMixBaseOpt => 5,
        }
    }

    fn name(self) -> &'static str {
        match self {
            PipelineType::Monolithic => "monolithic",
            PipelineType::ShaderObjects => "shader_objects",
            PipelineType::GplFast => "gpl_fast",
            PipelineType::GplOptimized => "gpl_optimized",
            PipelineType::GplMixBaseFast => "gpl_mix_base_fast",
            PipelineType::GplMixBaseOpt => "gpl_mix_base_opt",
        }
    }

    /// `getGeneralConstructionType` for the library types.
    fn base_is_fast(self) -> bool {
        matches!(self, PipelineType::GplFast | PipelineType::GplMixBaseFast)
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PreprocessType {
    None,
    SameStateCmdBuffer,
    OtherStateCmdBuffer,
}

#[derive(Clone, Copy)]
struct TestParams {
    draw_type: DrawType,
    pipeline_type: PipelineType,
    preprocess_type: PreprocessType,
    task_shader: bool,
    use_execution_set: bool,
    unordered_sequences: bool,
    draw_count_is_zero: bool,
}

impl TestParams {
    fn indirect(&self) -> bool {
        self.draw_type == DrawType::Indirect
    }

    fn random_seed(&self) -> u32 {
        ((self.pipeline_type.numeric() + 1) << 24)
            | (u32::from(self.task_shader) << 23)
            | (u32::from(self.use_execution_set) << 22)
    }

    fn blue_colors(&self) -> Vec<f32> {
        let mut colors = vec![1.0];
        if self.use_execution_set {
            colors.push(0.5);
        }
        colors
    }

    fn green_colors(&self) -> Vec<f32> {
        let mut colors = vec![0.0];
        if self.use_execution_set {
            colors.push(1.0);
        }
        colors
    }

    fn red_colors(&self) -> Vec<f32> {
        let mut colors = vec![0.25];
        if self.use_execution_set {
            colors.push(0.75);
        }
        colors
    }

    fn pre_raster_stages(&self) -> vk::ShaderStageFlags {
        let mut stages = vk::ShaderStageFlags::MESH_EXT;
        if self.task_shader {
            stages |= vk::ShaderStageFlags::TASK_EXT;
        }
        stages
    }

    fn all_stages(&self) -> vk::ShaderStageFlags {
        self.pre_raster_stages() | vk::ShaderStageFlags::FRAGMENT
    }

    fn frag_shader_count(&self) -> u32 {
        self.blue_colors().len() as u32
    }

    fn mesh_shader_count(&self) -> u32 {
        self.red_colors().len() as u32
    }

    fn task_shader_count(&self) -> u32 {
        if !self.task_shader {
            0
        } else if self.use_execution_set {
            2
        } else {
            1
        }
    }

    fn do_preprocess(&self) -> bool {
        self.preprocess_type != PreprocessType::None
    }

    fn program_name(&self) -> &'static str {
        match (self.indirect(), self.task_shader, self.use_execution_set) {
            (false, false, false) => "mesh_draw",
            (false, false, true) => "mesh_draw_ies",
            (false, true, false) => "mesh_draw_task",
            (false, true, true) => "mesh_draw_task_ies",
            (true, false, false) => "mesh_draw_ind",
            (true, false, true) => "mesh_draw_ind_ies",
            (true, true, false) => "mesh_draw_ind_task",
            (true, true, true) => "mesh_draw_ind_task_ies",
        }
    }
}

struct MeshDrawCase {
    name: String,
    params: TestParams,
}

impl TestCase for MeshDrawCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `DGCMeshDrawCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        let stages = params.all_stages();
        let bind_stages = if params.use_execution_set {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        let use_eso = params.pipeline_type.is_shader_objects();
        let (bind_stages_pipeline, bind_stages_shader_object) = if use_eso {
            (vk::ShaderStageFlags::empty(), bind_stages)
        } else {
            (bind_stages, vk::ShaderStageFlags::empty())
        };
        let dgc_properties = device_generated_commands_properties(context);

        check_dgc_ext_support(
            context,
            stages,
            bind_stages_pipeline,
            bind_stages_shader_object,
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )?;
        context.require_device_functionality("VK_EXT_mesh_shader")?;

        if use_eso {
            context.require_device_functionality("VK_EXT_shader_object")?;
            if params.use_execution_set && dgc_properties.max_indirect_shader_object_count == 0 {
                return Err(TestError::NotSupported(
                    "maxIndirectShaderObjectCount is zero".to_string(),
                ));
            }
        } else if params.use_execution_set && params.pipeline_type != PipelineType::Monolithic {
            check_pipeline_construction_requirements(context, PipelineConstructionType::FastLinkedLibrary)?;
            check_pipeline_construction_requirements(context, PipelineConstructionType::LinkTimeOptimizedLibrary)?;
        }

        if params.indirect() && dgc_properties.device_generated_commands_multi_draw_indirect_count == vk::FALSE {
            return Err(TestError::NotSupported(
                "deviceGeneratedCommandsMultiDrawIndirectCount not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = self.params.program_name();
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshDrawInstance {
            context,
            params: self.params,
        })
    }
}

struct MeshDrawInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

#[repr(C)]
#[derive(Clone, Copy)]
struct VertexData {
    position: Vec4,
    /// .x=clip .y=cull
    extra_data: Vec4,
}

/// `makeShaderExt` / `DGCShaderExt` with the flags the case needs; the descriptor set layout and the push constant range are the same for every
/// shader of the test.
fn make_eso_shader<'a>(
    device: &'a Device,
    stage: vk::ShaderStageFlags,
    flags: vk::ShaderCreateFlagsEXT,
    binary: &ProgramBinary,
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

fn write_dgc_buffer<T: Copy>(device: &Device, buffer: &DgcBuffer<'_>, data: &[T]) -> Result<(), TestError> {
    let alloc = buffer.get_allocation();
    // SAFETY: the buffer was created with the size of `data`.
    unsafe {
        std::ptr::copy_nonoverlapping(
            data.as_ptr().cast::<u8>(),
            alloc.get_host_ptr(),
            std::mem::size_of_val(data),
        )
    };
    flush_alloc(device, alloc)
}

fn host_storage_buffer<'a, T: Copy>(context: &'a Context<'a>, data: &[T]) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(
            std::mem::size_of_val(data) as vk::DeviceSize,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    write_host_buffer(device, &buffer, data)?;
    Ok(buffer)
}

struct IndirectBufferInfo<'a> {
    buffer: DgcBuffer<'a>,
    extra_structs: u32,
}

fn stride_bytes(extra_structs: u32) -> u32 {
    (extra_structs + 1) * std::mem::size_of::<vk::DrawMeshTasksIndirectCommandEXT>() as u32
}

impl TestInstance for MeshDrawInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.params;
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let use_eso = params.pipeline_type.is_shader_objects();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::TRANSFER_DST;
        let desc_buffer_type = vk::DescriptorType::STORAGE_BUFFER;
        let pixel_count = WIDTH * HEIGHT;
        let vtx_count = pixel_count * PER_TRIANGLE_VERTICES;
        let all_stages = params.all_stages();
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let sequence_count = if params.indirect() {
            SEQUENCE_COUNT_INDIRECT
        } else {
            SEQUENCE_COUNT_DIRECT
        };

        // Color buffer.
        let color_buffer = ImageWithBuffer::new(context, WIDTH, HEIGHT, color_format, color_usage, 4)?;

        // Descriptor set layout.
        let mut layout_builder = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_buffer_type, vk::ShaderStageFlags::MESH_EXT)
            .add_single_binding(desc_buffer_type, params.pre_raster_stages());
        if params.task_shader {
            layout_builder = layout_builder.add_single_binding(desc_buffer_type, vk::ShaderStageFlags::TASK_EXT);
        }
        let set_layout = layout_builder.build(device)?;

        // Push constants (must match shaders): width, height, baseDrawIndex.
        let pc_range = vk::PushConstantRange {
            stage_flags: params.pre_raster_stages(),
            offset: 0,
            size: 12,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        // Vertex data (must match shader).
        let normalized_coords = |c: u32, size: f32| (c as f32 + 0.5) / size * 2.0 - 1.0;
        let pixel_width = 2.0 / WIDTH as f32;
        let pixel_height = 2.0 / HEIGHT as f32;
        let hor_margin = pixel_width / 4.0;
        let vert_margin = pixel_height / 4.0;

        // For each of the vertices of the triangle surrounding the pixel center, as offsets from that center.
        let vertex_offsets = [
            [-hor_margin, vert_margin],
            [hor_margin, vert_margin],
            [0.0, -vert_margin],
        ];

        // Chosen pseudorandomly for each triangle.
        let clip_distances = [0.75f32, 0.0, -0.5, 1.25, 20.0, 2.0, 0.25, 1.0];
        let cull_distances = [0.75f32, 0.0, 0.5, 1.25, 20.0, 2.0, -0.25, 1.0];

        let mut rnd = Random::new(params.random_seed());

        let mut vertices: Vec<VertexData> = Vec::with_capacity(vtx_count as usize);
        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                let x_center = normalized_coords(x, WIDTH as f32);
                let y_center = normalized_coords(y, HEIGHT as f32);

                let clip_distance_idx = rnd.get_int(0, clip_distances.len() as i32 - 1) as usize;
                let cull_distance_idx = rnd.get_int(0, cull_distances.len() as i32 - 1) as usize;
                let clip_distance = clip_distances[clip_distance_idx];
                let cull_distance = cull_distances[cull_distance_idx];

                for offset in &vertex_offsets {
                    vertices.push(VertexData {
                        position: [x_center + offset[0], y_center + offset[1], 0.0, 1.0],
                        extra_data: [clip_distance, cull_distance, 0.0, 0.0],
                    });
                }
            }
        }

        // Coverage block data for the task shader.
        let mut coverage: Vec<u32> = vec![WIDTH; HEIGHT as usize];
        if params.task_shader {
            for cols_per_row in coverage.iter_mut() {
                *cols_per_row = rnd.get_int(0, WIDTH as i32 - 1) as u32;
            }
        }

        // Pseudorandomly distribute rows in sequences of direct draws.
        let mut draw_rows: Vec<u32> = vec![0; SEQUENCE_COUNT_DIRECT as usize];
        let max_pseudo_random_rows = (HEIGHT / SEQUENCE_COUNT_DIRECT) as i32;
        {
            let mut remaining_rows = HEIGHT;
            for i in 0..(SEQUENCE_COUNT_DIRECT - 1) as usize {
                let row_count = rnd.get_int(1, max_pseudo_random_rows) as u32;
                draw_rows[i] = row_count;
                remaining_rows -= row_count;
            }
            *draw_rows.last_mut().expect("draw rows") = remaining_rows;
        }

        // Base rows for each direct draw, to be used in a descriptor (see directDrawData.baseRow).
        let mut base_rows: Vec<u32> = vec![0; SEQUENCE_COUNT_DIRECT as usize];
        {
            let mut prev_rows = 0u32;
            for i in 0..SEQUENCE_COUNT_DIRECT as usize {
                base_rows[i] = prev_rows;
                prev_rows += draw_rows[i];
            }
        }

        // Descriptor buffers.
        let vtx_data_buffer = host_storage_buffer(context, &vertices)?;
        let vtx_data_size = std::mem::size_of_val(vertices.as_slice()) as vk::DeviceSize;
        let base_rows_buffer = host_storage_buffer(context, &base_rows)?;
        let base_rows_size = std::mem::size_of_val(base_rows.as_slice()) as vk::DeviceSize;
        let cov_data_buffer = host_storage_buffer(context, &coverage)?;
        let cov_data_size = std::mem::size_of_val(coverage.as_slice()) as vk::DeviceSize;

        // Descriptor pool and set.
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(desc_buffer_type, if params.task_shader { 3 } else { 2 })
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        {
            let vtx_buffer_desc_info = make_descriptor_buffer_info(vtx_data_buffer.get(), 0, vtx_data_size);
            let base_rows_desc_info = make_descriptor_buffer_info(base_rows_buffer.get(), 0, base_rows_size);
            let cov_data_desc_info = make_descriptor_buffer_info(cov_data_buffer.get(), 0, cov_data_size);
            let mut update_builder = DescriptorSetUpdateBuilder::new()
                .write_single(
                    descriptor_set.get(),
                    Location::binding(0),
                    desc_buffer_type,
                    &vtx_buffer_desc_info,
                )
                .write_single(
                    descriptor_set.get(),
                    Location::binding(1),
                    desc_buffer_type,
                    &base_rows_desc_info,
                );
            if params.task_shader {
                update_builder = update_builder.write_single(
                    descriptor_set.get(),
                    Location::binding(2),
                    desc_buffer_type,
                    &cov_data_desc_info,
                );
            }
            update_builder.update(device);
        }

        // Distribute groups of direct draws in single indirect draws when needed (how many direct draws per indirect one?)
        let mut direct_draw_group_sizes: Vec<u32> = Vec::new();
        if params.indirect() {
            direct_draw_group_sizes.resize(SEQUENCE_COUNT_INDIRECT as usize, 0);
            let max_pseudo_random_group_size = (SEQUENCE_COUNT_DIRECT / SEQUENCE_COUNT_INDIRECT) as i32;
            let mut remaining_draws = SEQUENCE_COUNT_DIRECT;
            for i in 0..(SEQUENCE_COUNT_INDIRECT - 1) as usize {
                let direct_draws = rnd.get_int(1, max_pseudo_random_group_size) as u32;
                direct_draw_group_sizes[i] = direct_draws;
                remaining_draws -= direct_draws;
            }
            *direct_draw_group_sizes.last_mut().expect("group sizes") = remaining_draws;
        }

        // Accumulated base direct draw indices (how many previous direct draws in indirect draw X?). These values go to the push constant
        // token in the indirect case.
        let mut prev_direct_draws: Vec<u32> = Vec::new();
        if params.indirect() {
            prev_direct_draws.resize(SEQUENCE_COUNT_INDIRECT as usize, 0);
            let mut prev_direct_draw_count = 0u32;
            for i in 0..SEQUENCE_COUNT_INDIRECT as usize {
                prev_direct_draws[i] = prev_direct_draw_count;
                prev_direct_draw_count += direct_draw_group_sizes[i];
            }
        }

        // Renderpass and framebuffer.
        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], WIDTH, HEIGHT, 1)?;
        let scissor = make_rect_2d(0, 0, WIDTH, HEIGHT);

        // Pipelines.
        let binaries = context.get_binary_collection();

        // For pipelines, with or without execution sets.
        let mut mesh_modules: Vec<Unique<'_, vk::ShaderModule>> = Vec::new();
        let mut frag_modules: Vec<Unique<'_, vk::ShaderModule>> = Vec::new();
        let mut task_modules: Vec<Unique<'_, vk::ShaderModule>> = Vec::new();

        // For shader objects (the flags differ with an execution set).
        let mut mesh_shaders: Vec<ShaderObject<'_>> = Vec::new();
        let mut frag_shaders: Vec<ShaderObject<'_>> = Vec::new();
        let mut task_shaders: Vec<ShaderObject<'_>> = Vec::new();

        if use_eso {
            let mut mesh_flags = if params.task_shader {
                vk::ShaderCreateFlagsEXT::empty()
            } else {
                vk::ShaderCreateFlagsEXT::NO_TASK_SHADER
            };
            let mut other_flags = vk::ShaderCreateFlagsEXT::empty();
            if params.use_execution_set {
                mesh_flags |= vk::ShaderCreateFlagsEXT::INDIRECT_BINDABLE;
                other_flags |= vk::ShaderCreateFlagsEXT::INDIRECT_BINDABLE;
            }
            for i in 0..params.mesh_shader_count() {
                let binary = binaries.get(&format!("mesh{i}"))?;
                mesh_shaders.push(make_eso_shader(
                    device,
                    vk::ShaderStageFlags::MESH_EXT,
                    mesh_flags,
                    &binary,
                    *set_layout,
                    pc_range,
                )?);
            }
            for i in 0..params.frag_shader_count() {
                let binary = binaries.get(&format!("frag{i}"))?;
                frag_shaders.push(make_eso_shader(
                    device,
                    vk::ShaderStageFlags::FRAGMENT,
                    other_flags,
                    &binary,
                    *set_layout,
                    pc_range,
                )?);
            }
            for i in 0..params.task_shader_count() {
                let binary = binaries.get(&format!("task{i}"))?;
                task_shaders.push(make_eso_shader(
                    device,
                    vk::ShaderStageFlags::TASK_EXT,
                    other_flags,
                    &binary,
                    *set_layout,
                    pc_range,
                )?);
            }
        } else {
            for i in 0..params.mesh_shader_count() {
                mesh_modules.push(create_shader_module(device, binaries.get(&format!("mesh{i}"))?)?);
            }
            for i in 0..params.frag_shader_count() {
                frag_modules.push(create_shader_module(device, binaries.get(&format!("frag{i}"))?)?);
            }
            for i in 0..params.task_shader_count() {
                task_modules.push(create_shader_module(device, binaries.get(&format!("task{i}"))?)?);
            }
        }

        // Shaders that will be used in the different sequences when using indirect execution sets.
        let mesh_shader_indices = [0usize, 0, 1, 1, 0, 1, 1, 0];
        let frag_shader_indices = [1usize, 0, 1, 0, 0, 0, 1, 1];
        let task_shader_indices = [0usize, 1, 0, 1, 0, 0, 1, 1];

        let mut normal_pipeline: Option<MeshPipeline<'_>> = None;
        let mut dgc_pipelines: Vec<MeshPipeline<'_>> = Vec::new();

        if params.use_execution_set {
            if !use_eso {
                for i in 0..sequence_count as usize {
                    // GPL mix alternates the construction type of the odd pipelines.
                    let base_fast = params.pipeline_type.base_is_fast();
                    let fast = if params.pipeline_type.is_gpl_mix() && i % 2 == 1 {
                        !base_fast
                    } else {
                        base_fast
                    };
                    let is_library = params.pipeline_type != PipelineType::Monolithic;
                    let task_module = if params.task_shader {
                        Some(*task_modules[task_shader_indices[i]])
                    } else {
                        None
                    };
                    dgc_pipelines.push(build_mesh_pipeline(
                        device,
                        *pipeline_layout,
                        *render_pass,
                        &MeshStages {
                            task: task_module,
                            mesh: *mesh_modules[mesh_shader_indices[i]],
                            frag: Some(*frag_modules[frag_shader_indices[i]]),
                        },
                        (WIDTH, HEIGHT),
                        &MeshPipelineOptions {
                            indirect_bindable: true,
                            rasterizer_discard: false,
                            fast_linked: is_library && fast,
                            link_time_optimized: is_library && !fast,
                        },
                    )?);
                }
            }
        } else if !use_eso {
            // GPL mix can only be tested with execution sets. Otherwise there's a single pipeline so mixing is not possible.
            debug_assert!(!params.pipeline_type.is_gpl_mix());
            let task_module = task_modules.first().map(|module| **module);
            normal_pipeline = Some(build_mesh_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &MeshStages {
                    task: task_module,
                    mesh: *mesh_modules[0],
                    frag: Some(*frag_modules[0]),
                },
                (WIDTH, HEIGHT),
                &MeshPipelineOptions::default(),
            )?);
        }
        let normal_pipeline_handle = normal_pipeline
            .as_ref()
            .map_or(vk::Pipeline::null(), |pipeline| **pipeline);

        // Execution set manager. Slots for shader objects: mesh0, mesh1, frag0, frag1, [task0, task1]
        let base_mesh_shader_idx = 0u32;
        let base_frag_shader_idx = 2u32;
        let base_task_shader_idx = 4u32;

        let mut execution_set_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if params.use_execution_set {
            let mut manager = if use_eso {
                let mut stage_infos: Vec<(vk::ShaderEXT, Vec<vk::DescriptorSetLayout>)> = Vec::new();
                stage_infos.push((mesh_shaders[0].get(), vec![*set_layout]));
                stage_infos.push((frag_shaders[0].get(), vec![*set_layout]));
                if params.task_shader {
                    stage_infos.push((task_shaders[0].get(), vec![*set_layout]));
                }
                let max_shader_count =
                    params.mesh_shader_count() + params.frag_shader_count() + params.task_shader_count();
                let mut manager =
                    ExecutionSetManagerExt::new_shader(device, &stage_infos, &[pc_range], max_shader_count)?;
                for i in 0..sequence_count as usize {
                    let mesh_index = mesh_shader_indices[i];
                    manager.add_shader(base_mesh_shader_idx + mesh_index as u32, mesh_shaders[mesh_index].get());
                    let frag_index = frag_shader_indices[i];
                    manager.add_shader(base_frag_shader_idx + frag_index as u32, frag_shaders[frag_index].get());
                    if params.task_shader {
                        let task_index = task_shader_indices[i];
                        manager.add_shader(base_task_shader_idx + task_index as u32, task_shaders[task_index].get());
                    }
                }
                manager
            } else {
                let mut manager = ExecutionSetManagerExt::new_pipeline(device, *dgc_pipelines[0], sequence_count)?;
                for i in 0..sequence_count as usize {
                    manager.add_pipeline(i as u32, *dgc_pipelines[i]);
                }
                manager
            };
            manager.update();
            execution_set_manager = Some(manager);
        }

        // Indirect commands layout and DGC data.

        // Push constants will be divided into general push constants and a DGC token.
        let base_draw_index_offset = 8u32;
        let base_draw_index_size = 4u32;

        let mut cmds_layout_flags = vk::IndirectCommandsLayoutUsageFlagsEXT::empty();
        if params.do_preprocess() {
            cmds_layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS;
        }
        if params.unordered_sequences {
            cmds_layout_flags |= vk::IndirectCommandsLayoutUsageFlagsEXT::UNORDERED_SEQUENCES;
        }

        let execution_set_type = if use_eso {
            vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
        } else {
            vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_flags, all_stages, *pipeline_layout);
        if params.use_execution_set {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_execution_set_token(offset, execution_set_type, all_stages);
        }
        {
            let base_draw_index_range = vk::PushConstantRange {
                stage_flags: pc_range.stage_flags,
                offset: pc_range.offset + base_draw_index_offset,
                size: base_draw_index_size,
            };
            let token_offset = cmds_layout_builder.get_stream_range();
            if params.indirect() {
                cmds_layout_builder.add_push_constant_token(token_offset, base_draw_index_range);
            } else {
                cmds_layout_builder.add_sequence_index_token(token_offset, base_draw_index_range);
            }
        }
        let offset = cmds_layout_builder.get_stream_range();
        if params.indirect() {
            cmds_layout_builder.add_draw_mesh_tasks_count_token(offset);
        } else {
            cmds_layout_builder.add_draw_mesh_tasks_token(offset);
        }
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Direct draw commands used in the main DGC buffer, or to fill the DGC indirect buffers.
        let mut draw_cmds: Vec<vk::DrawMeshTasksIndirectCommandEXT> = Vec::with_capacity(sequence_count as usize);
        for seq_rows in &draw_rows {
            // We'll pseudorandomly choose the major dimension.
            let chosen_dim = rnd.get_int(0, 2) as usize;
            let mut dispatch_size = [1u32, 1, 1];
            dispatch_size[chosen_dim] = *seq_rows;
            draw_cmds.push(vk::DrawMeshTasksIndirectCommandEXT {
                group_count_x: dispatch_size[0],
                group_count_y: dispatch_size[1],
                group_count_z: dispatch_size[2],
            });
        }

        // Prepare contents for the buffers used with DGC indirect draws (one buffer per DGC indirect draw, so that the address changes).
        let mut indirect_draw_buffers: Vec<IndirectBufferInfo<'_>> = Vec::new();
        if params.indirect() {
            let max_extra_structs = 3;
            for i in 0..SEQUENCE_COUNT_INDIRECT as usize {
                // Vary the number of padding structures used so that the stride also varies per DGC indirect draw.
                let extra_structs = rnd.get_int(0, max_extra_structs) as u32;
                let buffer_size = vk::DeviceSize::from(stride_bytes(extra_structs) * direct_draw_group_sizes[i]);
                let buffer = DgcBuffer::new(
                    context,
                    buffer_size,
                    vk::BufferUsageFlags::empty(),
                    MemoryRequirement::HOST_VISIBLE,
                )?;
                indirect_draw_buffers.push(IndirectBufferInfo { buffer, extra_structs });
            }

            // Fill data for indirect buffers, grouping direct draws and storing them with a certain stride.
            let empty_indirect_cmd = vk::DrawMeshTasksIndirectCommandEXT {
                group_count_x: 0,
                group_count_y: 0,
                group_count_z: 0,
            };
            for i in 0..SEQUENCE_COUNT_INDIRECT as usize {
                let prev_direct_draw_count = prev_direct_draws[i] as usize;
                let cur_direct_draw_count = direct_draw_group_sizes[i] as usize;

                let stride_items = indirect_draw_buffers[i].extra_structs as usize + 1;
                let item_count = stride_items * cur_direct_draw_count;

                let mut buffer_contents = vec![empty_indirect_cmd; item_count];
                let mut next_index = 0usize;
                for j in 0..cur_direct_draw_count {
                    buffer_contents[next_index] = draw_cmds[prev_direct_draw_count + j];
                    next_index += stride_items;
                }
                write_dgc_buffer(device, &indirect_draw_buffers[i].buffer, &buffer_contents)?;
            }
        }

        // DGC indirect draw commands. These go into the main DGC buffer in the indirect case.
        let mut indirect_draw_cmds: Vec<vk::DrawIndirectCountIndirectCommandEXT> = Vec::new();
        let mut max_draw_count = 0u32;
        if params.indirect() {
            for i in 0..SEQUENCE_COUNT_INDIRECT as usize {
                let buffer_info = &indirect_draw_buffers[i];
                indirect_draw_cmds.push(vk::DrawIndirectCountIndirectCommandEXT {
                    buffer_address: buffer_info.buffer.get_device_address(),
                    stride: stride_bytes(buffer_info.extra_structs),
                    command_count: if params.draw_count_is_zero {
                        0
                    } else {
                        direct_draw_group_sizes[i]
                    },
                });
                max_draw_count = max_draw_count.max(direct_draw_group_sizes[i]);
            }
        }
        if rnd.get_bool() {
            max_draw_count *= 2;
        }

        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..sequence_count as usize {
            if params.use_execution_set {
                if use_eso {
                    // Bit order: fragment, [task], mesh.
                    dgc_data.push(base_frag_shader_idx + frag_shader_indices[i] as u32);
                    if params.task_shader {
                        dgc_data.push(base_task_shader_idx + task_shader_indices[i] as u32);
                    }
                    dgc_data.push(base_mesh_shader_idx + mesh_shader_indices[i] as u32);
                } else {
                    dgc_data.push(i as u32);
                }
            }
            if params.indirect() {
                push_back_element(&mut dgc_data, &prev_direct_draws[i]); // Previous number of direct draws.
            } else {
                push_back_element(&mut dgc_data, &u32::MAX); // Placeholder for sequence index token.
            }

            // Push the element corresponding to the type of draw.
            if params.indirect() {
                push_back_element(&mut dgc_data, &indirect_draw_cmds[i]);
            } else {
                push_back_element(&mut dgc_data, &draw_cmds[i]);
            }
        }

        let dgc_buffer_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        write_dgc_buffer(device, &dgc_buffer, &dgc_data)?;

        // Preprocess buffer.
        let indirect_execution_set = execution_set_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);
        let mut shaders_vec: Vec<vk::ShaderEXT> = Vec::new();
        if use_eso && !params.use_execution_set {
            if !task_shaders.is_empty() {
                shaders_vec.push(task_shaders[0].get());
            }
            shaders_vec.push(mesh_shaders[0].get());
            shaders_vec.push(frag_shaders[0].get());
        }
        let preprocess_buffer = PreprocessBufferExt::new_with_shaders(
            context,
            indirect_execution_set,
            cmds_layout.get(),
            sequence_count,
            max_draw_count,
            normal_pipeline_handle,
            &shaders_vec,
            0,
        )?;

        // Command buffer.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        let clear_color = [0.0f32; 4];
        let clear_value_color = clear_value_color(clear_color);
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let cmds_info = if indirect_execution_set == vk::IndirectExecutionSetEXT::null() && !shaders_vec.is_empty() {
            DgcGenCmdsInfo::new_with_shaders(
                all_stages,
                indirect_execution_set,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                sequence_count,
                0,
                pixel_count,
                &shaders_vec,
            )
        } else {
            DgcGenCmdsInfo::new(
                all_stages,
                indirect_execution_set,
                cmds_layout.get(),
                dgc_buffer.get_device_address(),
                dgc_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                sequence_count,
                0,
                pixel_count,
                normal_pipeline_handle,
            )
        };

        // When preprocessing, we need to use a separate command buffer to record state. The preprocessing step needs to happen outside the
        // render pass.
        let mut separate_state_cmd_buffer = None;

        // A command buffer we want to record state into: .0 is the command buffer itself and .1, if not null, means we'll record a preprocess
        // command with it as the state command buffer.
        let null_cmd_buffer = vk::CommandBuffer::null();
        let mut state_cmd_buffers: Vec<(vk::CommandBuffer, vk::CommandBuffer)> = Vec::new();
        match params.preprocess_type {
            PreprocessType::None => state_cmd_buffers.push((cmd_buffer, null_cmd_buffer)),
            PreprocessType::SameStateCmdBuffer => {
                state_cmd_buffers.push((cmd_buffer, null_cmd_buffer));
                state_cmd_buffers.push((cmd_buffer, cmd_buffer));
            }
            PreprocessType::OtherStateCmdBuffer => {
                let owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
                let handle = owner.get();
                separate_state_cmd_buffer = Some(owner);
                state_cmd_buffers.push((handle, null_cmd_buffer));
                state_cmd_buffers.push((cmd_buffer, handle));
            }
        }

        // Record pre-execution state to all needed command buffers.
        let mut prev_cmd_buffer = vk::CommandBuffer::null();
        for (rec_cmd_buffer, preprocess_state_cmd_buffer) in &state_cmd_buffers {
            let rec_cmd_buffer = *rec_cmd_buffer;

            // Only begin each command buffer once.
            if rec_cmd_buffer != prev_cmd_buffer {
                begin_command_buffer(device, rec_cmd_buffer)?;
                prev_cmd_buffer = rec_cmd_buffer;
            }

            // Preprocessing either does not happen or happens in the second iteration.
            if *preprocess_state_cmd_buffer != vk::CommandBuffer::null() {
                unsafe {
                    device.cmd_preprocess_generated_commands_ext(
                        rec_cmd_buffer,
                        cmds_info.get(),
                        *preprocess_state_cmd_buffer,
                    )
                };
                // Delete the state cmd buffer immediately as allowed by the spec.
                separate_state_cmd_buffer = None;

                preprocess_to_execute_barrier_ext(device, rec_cmd_buffer);

                // Break for iteration 1 of the same state command buffer case.
                if rec_cmd_buffer == *preprocess_state_cmd_buffer {
                    break;
                }
            }

            unsafe {
                device.cmd_bind_descriptor_sets(
                    rec_cmd_buffer,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[],
                );
                // Static part of the push constants: width and height. Does not vary per sequence. It will be complemented by DGC tokens.
                let mut pc_bytes = [0u8; 8];
                pc_bytes[..4].copy_from_slice(&WIDTH.to_ne_bytes());
                pc_bytes[4..].copy_from_slice(&HEIGHT.to_ne_bytes());
                device.cmd_push_constants(
                    rec_cmd_buffer,
                    *pipeline_layout,
                    pc_range.stage_flags,
                    pc_range.offset,
                    &pc_bytes,
                );
            }

            if use_eso {
                // With an execution set the initial shaders are the first of each kind.
                let mut given: Vec<(vk::ShaderStageFlags, vk::ShaderEXT)> = Vec::new();
                if params.task_shader {
                    given.push((vk::ShaderStageFlags::TASK_EXT, task_shaders[0].get()));
                }
                given.push((vk::ShaderStageFlags::MESH_EXT, mesh_shaders[0].get()));
                given.push((vk::ShaderStageFlags::FRAGMENT, frag_shaders[0].get()));
                bind_shaders_with_nulls(context, rec_cmd_buffer, &given);
                set_default_shader_object_dynamic_states(
                    device,
                    rec_cmd_buffer,
                    context.get_device_extensions(),
                    vk::PrimitiveTopology::TRIANGLE_LIST,
                    true,
                    true,
                    WIDTH,
                    HEIGHT,
                );
            } else if params.use_execution_set {
                unsafe { device.cmd_bind_pipeline(rec_cmd_buffer, bind_point, *dgc_pipelines[0]) };
            } else {
                unsafe { device.cmd_bind_pipeline(rec_cmd_buffer, bind_point, normal_pipeline_handle) };
            }
        }

        if use_eso {
            let clear_layout = vk::ImageLayout::TRANSFER_DST_OPTIMAL;
            let rendering_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
            let image = color_buffer.image.get();

            let pre_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::empty(),
                vk::AccessFlags::TRANSFER_WRITE,
                vk::ImageLayout::UNDEFINED,
                clear_layout,
                image,
                color_srr,
            );
            let post_clear_barrier = make_image_memory_barrier(
                vk::AccessFlags::TRANSFER_WRITE,
                vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                clear_layout,
                rendering_layout,
                image,
                color_srr,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TOP_OF_PIPE,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_clear_barrier],
                );
                device.cmd_clear_color_image(
                    cmd_buffer,
                    image,
                    clear_layout,
                    &vk::ClearColorValue { float32: clear_color },
                    &[color_srr],
                );
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[post_clear_barrier],
                );
            }
            begin_rendering(
                device,
                cmd_buffer,
                *color_buffer.view,
                scissor,
                clear_value_color,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::AttachmentLoadOp::LOAD,
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
                scissor,
                clear_value_color,
            );
        }

        unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.do_preprocess(), cmds_info.get()) };

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
            WIDTH,
            HEIGHT,
            1,
        );
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;
        drop(separate_state_cmd_buffer);

        // Verify results.
        let result = color_buffer.read_bytes(device)?;

        let get_direct_draw_index = |row_index: u32| -> usize {
            let mut prev_rows = 0u32;
            for (i, seq_rows) in draw_rows.iter().enumerate() {
                if row_index >= prev_rows && row_index < prev_rows + seq_rows {
                    return i;
                }
                prev_rows += seq_rows;
            }
            usize::MAX
        };
        let get_indirect_draw_index = |direct_draw_index: usize| -> usize {
            let mut prev_draws = 0usize;
            for (i, group_draws) in direct_draw_group_sizes.iter().enumerate() {
                let group_draws = *group_draws as usize;
                if direct_draw_index >= prev_draws && direct_draw_index < prev_draws + group_draws {
                    return i;
                }
                prev_draws += group_draws;
            }
            usize::MAX
        };

        let red_colors = params.red_colors();
        let green_colors = params.green_colors();
        let blue_colors = params.blue_colors();

        let mut reference: Vec<Vec4> = vec![clear_color; pixel_count as usize];
        for y in 0..HEIGHT {
            for x in 0..WIDTH {
                let ies_index = if params.indirect() {
                    get_indirect_draw_index(get_direct_draw_index(y))
                } else {
                    get_direct_draw_index(y)
                };
                let reversed = params.task_shader && params.use_execution_set && task_shader_indices[ies_index] > 0;

                // A pixel is not drawn into if the column doesn't have coverage in that row, or if the clip and cull distances are below zero
                // for that triangle.
                let mut blank = params.draw_count_is_zero
                    || (!reversed && x >= coverage[y as usize])
                    || (reversed && (WIDTH - x - 1) >= coverage[y as usize]);

                let first_vertex_idx = ((y * WIDTH + x) * PER_TRIANGLE_VERTICES) as usize;
                let extra_data = vertices[first_vertex_idx].extra_data;
                blank = blank || extra_data[0] < 0.0 || extra_data[1] < 0.0;

                if !blank {
                    let mesh_shader_idx = if params.use_execution_set {
                        mesh_shader_indices[ies_index]
                    } else {
                        0
                    };
                    let frag_shader_idx = if params.use_execution_set {
                        frag_shader_indices[ies_index]
                    } else {
                        0
                    };
                    // Must match shaders, of course.
                    reference[(y * WIDTH + x) as usize] = [
                        red_colors[mesh_shader_idx],
                        green_colors[mesh_shader_idx],
                        blue_colors[frag_shader_idx],
                        1.0,
                    ];
                }
            }
        }

        let threshold_value = 0.005f32; // 1/255 < 0.005 < 2/255
        if !float_threshold_compare(
            result,
            &reference,
            [threshold_value, threshold_value, threshold_value, 0.0],
        ) {
            return Ok(TestStatus::fail(
                "Unexpected results in color buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCGraphicsMeshTestsExt` for the `token_draw` and `token_draw_count` groups: the cases by their full dotted path in `dgc`.
pub fn create_dgc_graphics_mesh_draw_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();

    let pipeline_types = [
        PipelineType::Monolithic,
        PipelineType::ShaderObjects,
        PipelineType::GplFast,
        PipelineType::GplOptimized,
        PipelineType::GplMixBaseFast,
        PipelineType::GplMixBaseOpt,
    ];
    let preprocess_cases = [
        (PreprocessType::None, ""),
        (PreprocessType::SameStateCmdBuffer, "_preprocess_same_state_cmd_buffer"),
        (
            PreprocessType::OtherStateCmdBuffer,
            "_preprocess_separate_state_cmd_buffer",
        ),
    ];

    for draw_type in [DrawType::Direct, DrawType::Indirect] {
        let group = if draw_type == DrawType::Direct {
            "token_draw"
        } else {
            "token_draw_count"
        };
        for pipeline_type in pipeline_types {
            for task_shader in [false, true] {
                for use_execution_set in [false, true] {
                    if pipeline_type.is_gpl_mix() && !use_execution_set {
                        continue;
                    }
                    for (preprocess_type, suffix) in preprocess_cases {
                        for unordered_sequences in [false, true] {
                            let mut params = TestParams {
                                draw_type,
                                pipeline_type,
                                preprocess_type,
                                task_shader,
                                use_execution_set,
                                unordered_sequences,
                                draw_count_is_zero: false,
                            };
                            let name = format!(
                                "{}{}{}{}{}",
                                pipeline_type.name(),
                                if task_shader { "_with_task_shader" } else { "" },
                                if use_execution_set { "_with_execution_set" } else { "" },
                                suffix,
                                if unordered_sequences { "_unordered" } else { "" },
                            );
                            cases.push((
                                format!("ext.graphics.mesh.{group}.{name}"),
                                Box::new(MeshDrawCase { name, params }) as Box<dyn TestCase>,
                            ));

                            // Test drawCount = 0
                            if draw_type == DrawType::Indirect
                                && pipeline_type == PipelineType::Monolithic
                                && preprocess_type == PreprocessType::None
                                && !use_execution_set
                                && !unordered_sequences
                            {
                                let case_name =
                                    format!("draw_count_0{}", if task_shader { "_with_task_shader" } else { "" });
                                params.draw_count_is_zero = true;
                                cases.push((
                                    format!("ext.graphics.mesh.{group}.{case_name}"),
                                    Box::new(MeshDrawCase {
                                        name: case_name,
                                        params,
                                    }) as Box<dyn TestCase>,
                                ));
                            }
                        }
                    }
                }
            }
        }
    }
    cases
}
