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
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_mesh_misc.toml`
// (`scripts/gen_dgc_mesh_misc_manifest.py`). `ext.graphics.mesh.misc`: `many_sequences_*` and `no_frag_shader_*` for the monolithic, shader
// object and fast linked library constructions (the optimized library ones are not part of the upstream group).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtDeviceGeneratedCommandsExtensionDeviceCommands, ExtShaderObjectExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_mesh_misc::ALL_SHARED_PROGRAM;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout_with_push_constants,
};
use crate::vk::pipeline_construction::{PipelineConstructionType, check_pipeline_construction_requirements};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::dgc::graphics_draw_tests::bind_shaders_with_nulls;
use crate::vkt::tests::dgc::graphics_mesh_util::{
    MeshPipeline, MeshPipelineOptions, MeshStages, build_mesh_pipeline, make_empty_render_pass, make_mesh_pipeline,
};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, preprocess_to_execute_barrier_ext, submit_and_wait_with_preprocess,
};
use crate::vkt::tests::shader_object::util::{
    ShaderObject, create_shader, get_shader_object_next_stages, set_default_shader_object_dynamic_states,
    shader_create_info,
};
use crate::vkt::{Context, TestCase, TestInstance};

const MANY_SEQUENCES_WORK_GROUP_SIZE: u32 = 64;

#[derive(Clone, Copy, PartialEq, Eq)]
enum PipelineType {
    Monolithic,
    ShaderObjects,
    GplFast,
}

impl PipelineType {
    fn construction_type(self) -> PipelineConstructionType {
        match self {
            PipelineType::Monolithic => PipelineConstructionType::Monolithic,
            PipelineType::ShaderObjects => PipelineConstructionType::ShaderObjectUnlinkedSpirv,
            PipelineType::GplFast => PipelineConstructionType::FastLinkedLibrary,
        }
    }

    /// The numeric value of the C++ `PipelineConstructionType`.
    fn construction_value(self) -> u32 {
        match self {
            PipelineType::Monolithic => 0,
            PipelineType::GplFast => 2,
            PipelineType::ShaderObjects => 3,
        }
    }

    fn name(self) -> &'static str {
        match self {
            PipelineType::Monolithic => "monolithic",
            PipelineType::ShaderObjects => "shader_objects",
            PipelineType::GplFast => "gpl_fast",
        }
    }
}

#[derive(Clone, Copy)]
enum Variant {
    ManySequences { sequence_count: u32, use_task_shader: bool },
    NoFrag(NoFragParams),
}

#[derive(Clone, Copy)]
struct NoFragParams {
    pipeline_type: PipelineType,
    has_task: bool,
    use_ies: bool,
    preprocess: bool,
}

impl NoFragParams {
    fn shader_stages(&self) -> vk::ShaderStageFlags {
        let mut stages = vk::ShaderStageFlags::MESH_EXT;
        if self.has_task {
            stages |= vk::ShaderStageFlags::TASK_EXT;
        }
        stages
    }

    fn shaders_per_sequence(&self) -> u32 {
        1 + u32::from(self.has_task)
    }

    fn random_seed(&self) -> u32 {
        ((self.pipeline_type.construction_value() + 1) << 8) | u32::from(self.has_task)
    }

    fn task_values(&self) -> Vec<u32> {
        let mut values = vec![1_000_000u32];
        if self.use_ies {
            values.push(2_000_000);
        }
        values
    }

    fn mesh_values(&self) -> Vec<u32> {
        let mut values = vec![if self.has_task { 3_000_000u32 } else { 1_000_000 }];
        if self.use_ies {
            values.push(if self.has_task { 4_000_000 } else { 2_000_000 });
        }
        values
    }

    const WG_FACTOR: u32 = 1000;
    const WORK_GROUP_SIZE: u32 = 64;
    const OUTPUT_ARRAY_SIZE: u32 = 1024;
}

struct MeshMiscCase {
    name: String,
    variant: Variant,
}

impl TestCase for MeshMiscCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `manySequencesCheckSupport` / `NoFragCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        match self.variant {
            Variant::ManySequences { use_task_shader, .. } => {
                let mut stages = vk::ShaderStageFlags::MESH_EXT;
                if use_task_shader {
                    stages |= vk::ShaderStageFlags::TASK_EXT;
                }
                check_dgc_ext_support(
                    context,
                    stages,
                    vk::ShaderStageFlags::empty(),
                    vk::ShaderStageFlags::empty(),
                    vk::IndirectCommandsInputModeFlagsEXT::empty(),
                    false,
                )?;
                context.require_device_functionality("VK_EXT_mesh_shader")
            }
            Variant::NoFrag(params) => {
                check_pipeline_construction_requirements(context, params.pipeline_type.construction_type())?;
                let stages = params.shader_stages();
                let bind_stages = if params.use_ies {
                    stages
                } else {
                    vk::ShaderStageFlags::empty()
                };
                let use_shader_objects = params.pipeline_type == PipelineType::ShaderObjects;
                let (bind_stages_pipeline, bind_stages_shader_object) = if use_shader_objects {
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
                context.require_device_functionality("VK_EXT_mesh_shader")
            }
        }
    }

    fn programs(&self) -> BinaryCollection {
        let wanted = match self.variant {
            Variant::ManySequences { use_task_shader, .. } => {
                if use_task_shader {
                    "mesh_many_task"
                } else {
                    "mesh_many"
                }
            }
            Variant::NoFrag(params) => match (params.has_task, params.use_ies) {
                (false, false) => "mesh_nofrag",
                (false, true) => "mesh_nofrag_ies",
                (true, false) => "mesh_nofrag_task",
                (true, true) => "mesh_nofrag_task_ies",
            },
        };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshMiscInstance {
            context,
            variant: self.variant,
        })
    }
}

struct MeshMiscInstance<'a> {
    context: &'a Context<'a>,
    variant: Variant,
}

impl TestInstance for MeshMiscInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::ManySequences {
                sequence_count,
                use_task_shader,
            } => self.many_sequences_run(sequence_count, use_task_shader),
            Variant::NoFrag(params) => self.no_frag_run(params),
        }
    }
}

fn zeroed_host_buffer<'a>(
    context: &'a Context<'a>,
    size: vk::DeviceSize,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(size, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let alloc = buffer.get_allocation();
        // SAFETY: the buffer was created with this size.
        unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, size as usize) };
        flush_alloc(device, alloc)?;
    }
    Ok(buffer)
}

fn begin_rendering_no_attachments(device: &Device, cmd_buffer: vk::CommandBuffer, render_area: vk::Rect2D) {
    let rendering_info = vk::RenderingInfo::builder().render_area(render_area).layer_count(1);
    unsafe { device.cmd_begin_rendering(cmd_buffer, &rendering_info) };
}

fn zero_clear_value() -> vk::ClearValue {
    vk::ClearValue {
        color: vk::ClearColorValue { float32: [0.0; 4] },
    }
}

impl MeshMiscInstance<'_> {
    fn many_sequences_run(&self, sequence_count: u32, use_task_shader: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let mut stage_flags = vk::ShaderStageFlags::MESH_EXT;
        if use_task_shader {
            stage_flags |= vk::ShaderStageFlags::TASK_EXT;
        }
        let bind_point = vk::PipelineBindPoint::GRAPHICS;

        // Output buffer.
        let output_buffer_size = sequence_count as vk::DeviceSize * 4;
        let output_buffer = zeroed_host_buffer(context, output_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER)?;

        // Descriptor set layout, pool and set preparation.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, stage_flags)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let output_buffer_desc_info = make_descriptor_buffer_info(output_buffer.get(), 0, output_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                desc_type,
                &output_buffer_desc_info,
            )
            .update(device);

        // Push constants and pipeline layout.
        let pc_range = vk::PushConstantRange {
            stage_flags,
            offset: 0,
            size: 4,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        // Shaders.
        let binaries = context.get_binary_collection();
        let task_module = if use_task_shader {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;

        // Render pass and framebuffer.
        let render_pass = make_empty_render_pass(device)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[], 1, 1, 1)?;
        let scissor = make_rect_2d(0, 0, 1, 1);

        let pipeline = make_mesh_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &MeshStages {
                task: task_module.as_ref().map(|module| **module),
                mesh: *mesh_module,
                frag: None,
            },
            (1, 1),
            false,
        )?;

        // Generated commands layout: push constant (the sequence index) and draw mesh tasks.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            *pipeline_layout,
        );
        cmds_layout_builder.add_sequence_index_token(0, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_mesh_tasks_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        // Increase the value index (indicated by the push constant) in each sequence, then dispatch one workgroup.
        let mut gen_cmds_data: Vec<u32> = Vec::with_capacity(4 * sequence_count as usize);
        for _ in 0..sequence_count {
            gen_cmds_data.push(u32::MAX); // Placeholder value for the sequence index.
            gen_cmds_data.push(1); // groupCountX
            gen_cmds_data.push(1); // groupCountY
            gen_cmds_data.push(1); // groupCountZ
        }
        let gen_cmds_buffer_size = std::mem::size_of_val(gen_cmds_data.as_slice()) as vk::DeviceSize;
        let gen_cmds_buffer = DgcBuffer::new(
            context,
            gen_cmds_buffer_size,
            vk::BufferUsageFlags::empty(),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        {
            let alloc = gen_cmds_buffer.get_allocation();
            // SAFETY: the buffer was created with the size of the data.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    gen_cmds_data.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    gen_cmds_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            sequence_count,
            0,
            *pipeline,
            0,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            scissor,
            zero_clear_value(),
        );
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);
        }
        {
            let cmds_info = DgcGenCmdsInfo::new(
                stage_flags,
                vk::IndirectExecutionSetEXT::null(),
                cmds_layout.get(),
                gen_cmds_buffer.get_device_address(),
                gen_cmds_buffer.get_size(),
                preprocess_buffer.get_device_address(),
                preprocess_buffer.get_size(),
                sequence_count,
                0,
                0,
                *pipeline,
            );
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get()) };
        }
        end_render_pass(device, cmd_buffer);
        {
            // The source stage is the one upstream uses.
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        // Verify results.
        let alloc = output_buffer.get_allocation();
        invalidate_alloc(device, alloc)?;
        // SAFETY: the buffer holds `sequence_count` words and the device finished writing.
        let output_values = unsafe {
            std::slice::from_raw_parts(alloc.get_host_ptr().cast_const().cast::<u32>(), sequence_count as usize)
        };
        let mut fail = false;
        for (i, result) in output_values.iter().enumerate() {
            if *result != MANY_SEQUENCES_WORK_GROUP_SIZE {
                log::error!("Error at execution {i}: expected {MANY_SEQUENCES_WORK_GROUP_SIZE} but found {result}");
                fail = true;
            }
        }
        if fail {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }

    #[expect(clippy::vec_init_then_push, reason = "upstream pushes the sizes one by one")]
    fn no_frag_run(&self, params: NoFragParams) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let use_eso = params.pipeline_type == PipelineType::ShaderObjects;
        let array_size = NoFragParams::OUTPUT_ARRAY_SIZE;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let buffer_bytes = array_size as vk::DeviceSize * 4;

        // Main output buffer. This will be used by the mesh or the task shader, whichever is launched.
        let main_buffer = zeroed_host_buffer(context, buffer_bytes, vk::BufferUsageFlags::STORAGE_BUFFER)?;
        // Used by the mesh shader when the task shader is present.
        let secondary_buffer = if params.has_task {
            Some(zeroed_host_buffer(
                context,
                buffer_bytes,
                vk::BufferUsageFlags::STORAGE_BUFFER,
            )?)
        } else {
            None
        };

        // Descriptor pool, set and pipeline layout.
        let main_stage = if params.has_task {
            vk::ShaderStageFlags::TASK_EXT
        } else {
            vk::ShaderStageFlags::MESH_EXT
        };
        let mut layout_builder = DescriptorSetLayoutBuilder::new().add_single_binding(desc_type, main_stage);
        if params.has_task {
            layout_builder = layout_builder.add_single_binding(desc_type, vk::ShaderStageFlags::MESH_EXT);
        }
        let set_layout = layout_builder.build(device)?;

        let pc_range = vk::PushConstantRange {
            stage_flags: main_stage,
            offset: 0,
            size: 4,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(desc_type, if params.has_task { 2 } else { 1 })
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        {
            let main_info = make_descriptor_buffer_info(main_buffer.get(), 0, vk::WHOLE_SIZE);
            let mut update_builder = DescriptorSetUpdateBuilder::new().write_single(
                descriptor_set.get(),
                Location::binding(0),
                desc_type,
                &main_info,
            );
            let secondary_info = secondary_buffer
                .as_ref()
                .map(|buffer| make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE));
            if let Some(info) = &secondary_info {
                update_builder =
                    update_builder.write_single(descriptor_set.get(), Location::binding(1), desc_type, info);
            }
            update_builder.update(device);
        }

        // Pipelines (or shader objects).
        let pipeline_count = params.mesh_values().len();
        let binaries = context.get_binary_collection();
        let tessellation_feature = context.get_device_features().tessellation_shader != vk::FALSE;
        let geometry_feature = context.get_device_features().geometry_shader != vk::FALSE;
        let extent = (1u32, 1u32);
        let scissor = make_rect_2d(0, 0, extent.0, extent.1);

        let render_pass = make_empty_render_pass(device)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[], extent.0, extent.1, 1)?;

        let shader_flags = if params.use_ies {
            vk::ShaderCreateFlagsEXT::INDIRECT_BINDABLE
        } else {
            vk::ShaderCreateFlagsEXT::empty()
        };

        let mut modules: Vec<Unique<'_, vk::ShaderModule>> = Vec::new();
        let mut pipelines: Vec<MeshPipeline<'_>> = Vec::new();
        let mut task_shaders: Vec<ShaderObject<'_>> = Vec::new();
        let mut mesh_shaders: Vec<ShaderObject<'_>> = Vec::new();

        for i in 0..pipeline_count {
            let mesh_name = format!("mesh{i}");
            let task_name = format!("task{i}");
            if use_eso {
                let set_layouts = [*set_layout];
                if params.has_task {
                    let binary = binaries.get(&task_name)?;
                    let create_info = shader_create_info(
                        shader_flags,
                        vk::ShaderStageFlags::TASK_EXT,
                        get_shader_object_next_stages(
                            vk::ShaderStageFlags::TASK_EXT,
                            tessellation_feature,
                            geometry_feature,
                        ),
                        vk::ShaderCodeTypeEXT::SPIRV,
                        std::mem::size_of_val(binary.spirv),
                        binary.spirv.as_ptr().cast(),
                        &set_layouts,
                        &[pc_range],
                    );
                    task_shaders.push(create_shader(device, &create_info)?);
                }
                let binary = binaries.get(&mesh_name)?;
                let create_info = shader_create_info(
                    shader_flags,
                    vk::ShaderStageFlags::MESH_EXT,
                    get_shader_object_next_stages(
                        vk::ShaderStageFlags::MESH_EXT,
                        tessellation_feature,
                        geometry_feature,
                    ),
                    vk::ShaderCodeTypeEXT::SPIRV,
                    std::mem::size_of_val(binary.spirv),
                    binary.spirv.as_ptr().cast(),
                    &set_layouts,
                    &[pc_range],
                );
                mesh_shaders.push(create_shader(device, &create_info)?);
            } else {
                let task_module = if params.has_task {
                    let module = create_shader_module(device, binaries.get(&task_name)?)?;
                    let handle = *module;
                    modules.push(module);
                    Some(handle)
                } else {
                    None
                };
                let mesh_module = create_shader_module(device, binaries.get(&mesh_name)?)?;
                let mesh_handle = *mesh_module;
                modules.push(mesh_module);
                pipelines.push(build_mesh_pipeline(
                    device,
                    *pipeline_layout,
                    *render_pass,
                    &MeshStages {
                        task: task_module,
                        mesh: mesh_handle,
                        frag: None,
                    },
                    extent,
                    &MeshPipelineOptions {
                        indirect_bindable: params.use_ies,
                        rasterizer_discard: true,
                        fast_linked: params.pipeline_type == PipelineType::GplFast,
                        ..Default::default()
                    },
                )?);
            }
        }

        let group_size = NoFragParams::WORK_GROUP_SIZE;
        debug_assert!(array_size.is_multiple_of(group_size));
        let total_groups = array_size / group_size;

        let mut rnd = Random::new(params.random_seed());
        let mut dispatch_sizes: Vec<u32> = Vec::new();
        dispatch_sizes.push(rnd.get_int(1, total_groups as i32 - 1) as u32);
        dispatch_sizes.push(total_groups - dispatch_sizes[0]);

        // Push constant values in each iteration.
        let mut pc_values: Vec<u32> = Vec::with_capacity(dispatch_sizes.len());
        let mut prev_group_count = 0u32;
        for size in &dispatch_sizes {
            pc_values.push(prev_group_count);
            prev_group_count += size;
        }

        // DGC pieces.
        let sequence_count = dispatch_sizes.len() as u32;
        let shaders_per_sequence = params.shaders_per_sequence();
        let shader_stages = params.shader_stages();

        let cmds_layout_flags = if params.preprocess {
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS
        } else {
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty()
        };
        let mut cmds_layout_builder =
            IndirectCommandsLayoutBuilderExt::new(cmds_layout_flags, shader_stages, *pipeline_layout);
        if params.use_ies {
            let ies_type = if use_eso {
                vk::IndirectExecutionSetInfoTypeEXT::SHADER_OBJECTS
            } else {
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES
            };
            cmds_layout_builder.add_execution_set_token(0, ies_type, shader_stages);
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_push_constant_token(offset, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_mesh_tasks_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut dgc_data: Vec<u32> = Vec::new();
        for i in 0..dispatch_sizes.len() {
            if params.use_ies {
                if use_eso {
                    dgc_data.push(i as u32 * shaders_per_sequence);
                    if params.has_task {
                        dgc_data.push(i as u32 * shaders_per_sequence + 1);
                    }
                } else {
                    dgc_data.push(i as u32);
                }
            }
            dgc_data.push(pc_values[i]); // Push constant token value.
            dgc_data.push(dispatch_sizes[i]); // Dispatch X.
            dgc_data.push(1); // Dispatch Y.
            dgc_data.push(1); // Dispatch Z.
        }
        let dgc_data_size = std::mem::size_of_val(dgc_data.as_slice()) as vk::DeviceSize;
        let dgc_buffer = DgcBuffer::new(
            context,
            dgc_data_size,
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
                    dgc_data_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
        }

        let mut ies_manager: Option<ExecutionSetManagerExt<'_>> = None;
        let mut preprocess_pipeline = vk::Pipeline::null();
        let mut preprocess_shaders: Vec<vk::ShaderEXT> = Vec::new();

        if params.use_ies {
            let mut manager = if use_eso {
                let mut stage_infos: Vec<(vk::ShaderEXT, Vec<vk::DescriptorSetLayout>)> = Vec::new();
                if params.has_task {
                    stage_infos.push((task_shaders[0].get(), vec![*set_layout]));
                }
                stage_infos.push((mesh_shaders[0].get(), vec![*set_layout]));
                debug_assert_eq!(shaders_per_sequence as usize, stage_infos.len());

                let max_shader_count = sequence_count * shaders_per_sequence;
                let mut manager =
                    ExecutionSetManagerExt::new_shader(device, &stage_infos, &[pc_range], max_shader_count)?;
                // Task,Mesh,Task,Mesh or Mesh,Mesh
                for i in 0..sequence_count {
                    if params.has_task {
                        manager.add_shader(i * shaders_per_sequence, task_shaders[i as usize].get());
                    }
                    manager.add_shader(
                        i * shaders_per_sequence + u32::from(params.has_task),
                        mesh_shaders[i as usize].get(),
                    );
                }
                manager
            } else {
                let mut manager = ExecutionSetManagerExt::new_pipeline(device, *pipelines[0], sequence_count)?;
                for i in 0..sequence_count {
                    manager.add_pipeline(i, *pipelines[i as usize]);
                }
                manager
            };
            manager.update();
            ies_manager = Some(manager);
        } else if use_eso {
            if params.has_task {
                preprocess_shaders.push(task_shaders[0].get());
            }
            preprocess_shaders.push(mesh_shaders[0].get());
        } else {
            preprocess_pipeline = *pipelines[0];
        }
        let ies_handle = ies_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        let preprocess_buffer = PreprocessBufferExt::new_with_shaders(
            context,
            ies_handle,
            cmds_layout.get(),
            sequence_count,
            0,
            preprocess_pipeline,
            &preprocess_shaders,
            0,
        )?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();
        let preprocess_cmd_buffer_owner = if params.preprocess {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::PRIMARY,
            )?)
        } else {
            None
        };

        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
        }
        if use_eso {
            begin_rendering_no_attachments(device, cmd_buffer, scissor);
        } else {
            begin_render_pass(
                device,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                scissor,
                zero_clear_value(),
            );
        }
        {
            // Bind initial state.
            if use_eso {
                let mut given: Vec<(vk::ShaderStageFlags, vk::ShaderEXT)> = Vec::new();
                if params.has_task {
                    given.push((vk::ShaderStageFlags::TASK_EXT, task_shaders[0].get()));
                }
                given.push((vk::ShaderStageFlags::MESH_EXT, mesh_shaders[0].get()));
                bind_shaders_with_nulls(context, cmd_buffer, &given);
                set_default_shader_object_dynamic_states(
                    device,
                    cmd_buffer,
                    context.get_device_extensions(),
                    vk::PrimitiveTopology::POINT_LIST,
                    true,
                    true,
                    extent.0,
                    extent.1,
                );
                unsafe { device.cmd_set_rasterizer_discard_enable_ext(cmd_buffer, true) };
            } else {
                unsafe { device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipelines[0]) };
            }

            let cmds_info = if ies_handle == vk::IndirectExecutionSetEXT::null() && !preprocess_shaders.is_empty() {
                DgcGenCmdsInfo::new_with_shaders(
                    shader_stages,
                    ies_handle,
                    cmds_layout.get(),
                    dgc_buffer.get_device_address(),
                    dgc_buffer.get_size(),
                    preprocess_buffer.get_device_address(),
                    preprocess_buffer.get_size(),
                    sequence_count,
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
                    sequence_count,
                    0,
                    0,
                    preprocess_pipeline,
                )
            };

            if let Some(preprocess_cmd_buffer) = &preprocess_cmd_buffer_owner {
                let preprocess_cmd = preprocess_cmd_buffer.get();
                begin_command_buffer(device, preprocess_cmd)?;
                unsafe { device.cmd_preprocess_generated_commands_ext(preprocess_cmd, cmds_info.get(), cmd_buffer) };
                preprocess_to_execute_barrier_ext(device, preprocess_cmd);
                end_command_buffer(device, preprocess_cmd)?;
            }
            unsafe { device.cmd_execute_generated_commands_ext(cmd_buffer, params.preprocess, cmds_info.get()) };
        }
        if use_eso {
            unsafe { device.cmd_end_rendering(cmd_buffer) };
        } else {
            end_render_pass(device, cmd_buffer);
        }
        {
            let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            let mut stage_flags = vk::PipelineStageFlags::MESH_SHADER_EXT;
            if params.has_task {
                stage_flags |= vk::PipelineStageFlags::TASK_SHADER_EXT;
            }
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    stage_flags,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_and_wait_with_preprocess(
            device,
            queue,
            cmd_buffer,
            preprocess_cmd_buffer_owner
                .as_ref()
                .map_or(vk::CommandBuffer::null(), |owner| owner.get()),
        )?;

        let main_values = if params.has_task {
            params.task_values()
        } else {
            params.mesh_values()
        };
        let secondary_values = params.mesh_values();
        let wg_factor = NoFragParams::WG_FACTOR;

        let mut fail = false;
        let mut verifications: Vec<(&str, &BufferWithMemory<'_>, &Vec<u32>)> =
            vec![("binding=0", &main_buffer, &main_values)];
        if let Some(buffer) = &secondary_buffer {
            verifications.push(("binding=1", buffer, &secondary_values));
        }
        for (buffer_name, buffer, base_values) in verifications {
            let alloc = buffer.get_allocation();
            invalidate_alloc(device, alloc)?;
            // SAFETY: the buffer holds `array_size` words and the device finished writing.
            let buffer_values = unsafe {
                std::slice::from_raw_parts(alloc.get_host_ptr().cast_const().cast::<u32>(), array_size as usize)
            };

            let mut prev_group_count = 0u32;
            for (i, wg_count) in dispatch_sizes.iter().enumerate() {
                for j in 0..*wg_count {
                    let wg_index = prev_group_count + j;
                    for k in 0..group_size {
                        let expected_value = base_values[i % base_values.len()] + wg_index * wg_factor + k;
                        let array_index = (wg_index * group_size + k) as usize;
                        let result_value = buffer_values[array_index];
                        if expected_value != result_value {
                            log::error!(
                                "Unexpected value in {buffer_name} buffer index {array_index}: expected {expected_value} but found {result_value}"
                            );
                            fail = true;
                        }
                    }
                }
                prev_group_count += wg_count;
            }
        }

        if fail {
            return Ok(TestStatus::fail(
                "Unexpected values found in output buffer; check log for details",
            ));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDGCGraphicsMeshTestsExt` without the token draw groups: the `misc` cases by their full dotted path in `dgc`.
pub fn create_dgc_graphics_mesh_misc_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();

    for pipeline_type in [
        PipelineType::Monolithic,
        PipelineType::ShaderObjects,
        PipelineType::GplFast,
    ] {
        for has_task in [false, true] {
            for use_ies in [false, true] {
                for preprocess in [false, true] {
                    let params = NoFragParams {
                        pipeline_type,
                        has_task,
                        use_ies,
                        preprocess,
                    };
                    let name = format!(
                        "no_frag_shader_{}{}{}{}",
                        pipeline_type.name(),
                        if has_task { "_with_task" } else { "" },
                        if use_ies { "_with_ies" } else { "" },
                        if preprocess { "_preprocess" } else { "" },
                    );
                    cases.push((
                        format!("ext.graphics.mesh.misc.{name}"),
                        Box::new(MeshMiscCase {
                            name,
                            variant: Variant::NoFrag(params),
                        }) as Box<dyn TestCase>,
                    ));
                }
            }
        }
    }

    for has_task in [false, true] {
        for sequence_count in [64u32, 1024, 8192, 131072] {
            let name = format!("many_sequences_{sequence_count}{}", if has_task { "_task" } else { "" });
            cases.push((
                format!("ext.graphics.mesh.misc.{name}"),
                Box::new(MeshMiscCase {
                    name,
                    variant: Variant::ManySequences {
                        sequence_count,
                        use_task_shader: has_task,
                    },
                }) as Box<dyn TestCase>,
            ));
        }
    }
    cases
}
