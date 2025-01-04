// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/device_generated_commands/vktDGCGraphicsMeshConditionalTestsExt.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2024 The Khronos Group Inc.
// Copyright (c) 2024 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The programs are in `shaders/manifest/dgc_mesh_conditional.toml`
// (`scripts/gen_dgc_mesh_conditional_manifest.py`). The pipelines are made by `make_mesh_pipeline`.
//
// One point per pixel drawn by a generated push constant + mesh tasks sequence inside conditional rendering; every pixel is either the clear
// color or the pushed one.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtConditionalRenderingExtensionDeviceCommands, ExtDeviceGeneratedCommandsExtensionDeviceCommands,
};

use crate::generated::shaders::dgc_mesh_conditional::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout_with_push_constants, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::dgc::graphics_draw_tests::{copy_image_to_buffer, float_threshold_compare, push_back_element};
use crate::vkt::tests::dgc::graphics_mesh_util::{MeshStages, make_mesh_pipeline};
use crate::vkt::tests::dgc::util_ext::{
    DgcBuffer, DgcGenCmdsInfo, ExecutionSetManagerExt, IndirectCommandsLayoutBuilderExt, PreprocessBufferExt,
    check_dgc_ext_support, preprocess_to_execute_barrier_ext,
};
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::{Context, TestCase, TestInstance};

type Vec4 = [f32; 4];

const WIDTH: u32 = 2;
const HEIGHT: u32 = 4;
const PC_VALUE: Vec4 = [0.0, 0.0, 1.0, 1.0]; // Blue.
const CLEAR_VALUE: Vec4 = [0.0, 0.0, 0.0, 1.0];

#[derive(Clone, Copy)]
struct TestParams {
    has_task: bool,
    pipeline_token: bool,
    indirect_count_buffer: bool,
    condition_value: bool,
    inverted: bool,
}

#[derive(Clone, Copy)]
enum Variant {
    Dispatch(TestParams),
    /// condition value, inverted
    Preprocess(bool, bool),
}

fn shader_stages(task_shader: bool) -> vk::ShaderStageFlags {
    let mut stages = vk::ShaderStageFlags::MESH_EXT | vk::ShaderStageFlags::FRAGMENT;
    if task_shader {
        stages |= vk::ShaderStageFlags::TASK_EXT;
    }
    stages
}

struct MeshConditionalCase {
    name: String,
    variant: Variant,
}

impl TestCase for MeshConditionalCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `checkConditionalDGCGraphicsMeshSupport` / `checkConditionalPreprocessMeshSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_mesh_shader")?;
        context.require_device_functionality("VK_EXT_conditional_rendering")?;
        let (pipeline_token, task_shader) = match self.variant {
            Variant::Dispatch(params) => (params.pipeline_token, params.has_task),
            Variant::Preprocess(..) => (false, false),
        };
        let stages = shader_stages(task_shader);
        let bind_stages = if pipeline_token {
            stages
        } else {
            vk::ShaderStageFlags::empty()
        };
        check_dgc_ext_support(
            context,
            stages,
            bind_stages,
            vk::ShaderStageFlags::empty(),
            vk::IndirectCommandsInputModeFlagsEXT::empty(),
            false,
        )
    }

    fn programs(&self) -> BinaryCollection {
        let task_shader = match self.variant {
            Variant::Dispatch(params) => params.has_task,
            Variant::Preprocess(..) => false,
        };
        let wanted = if task_shader { "mesh_cond_task" } else { "mesh_cond" };
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == wanted)
            .map_or(BinaryCollection::new(&[]), |program| program.programs)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshConditionalInstance {
            context,
            variant: self.variant,
        })
    }
}

fn begin_conditional_rendering(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    condition_buffer: vk::Buffer,
    inverted: bool,
) {
    let flags = if inverted {
        vk::ConditionalRenderingFlagsEXT::INVERTED
    } else {
        vk::ConditionalRenderingFlagsEXT::empty()
    };
    let begin_info = vk::ConditionalRenderingBeginInfoEXT {
        buffer: condition_buffer,
        offset: 0,
        flags,
        ..Default::default()
    };
    unsafe { device.cmd_begin_conditional_rendering_ext(cmd_buffer, &begin_info) };
}

fn write_buffer<'a>(
    context: &'a Context<'a>,
    bytes: &[u8],
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(bytes.len() as vk::DeviceSize, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    {
        let alloc = buffer.get_allocation();
        // SAFETY: the buffer was created with the size of the data.
        unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), alloc.get_host_ptr(), bytes.len()) };
        flush_alloc(device, alloc)?;
    }
    Ok(buffer)
}

/// `makeVertexBuffer`: one point at the centre of every pixel.
fn make_vertex_buffer<'a>(context: &'a Context<'a>) -> Result<BufferWithMemory<'a>, TestError> {
    let normalize_coords = |c: u32, size: u32| (c as f32 + 0.5) / size as f32 * 2.0 - 1.0;
    let mut vertices: Vec<Vec4> = Vec::with_capacity((WIDTH * HEIGHT) as usize);
    for y in 0..HEIGHT {
        for x in 0..WIDTH {
            vertices.push([normalize_coords(x, WIDTH), normalize_coords(y, HEIGHT), 0.0, 1.0]);
        }
    }
    // SAFETY: plain f32 data.
    let bytes = unsafe {
        std::slice::from_raw_parts(
            vertices.as_ptr().cast::<u8>(),
            std::mem::size_of_val(vertices.as_slice()),
        )
    };
    write_buffer(context, bytes, vk::BufferUsageFlags::STORAGE_BUFFER)
}

struct MeshConditionalInstance<'a> {
    context: &'a Context<'a>,
    variant: Variant,
}

impl TestInstance for MeshConditionalInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        match self.variant {
            Variant::Dispatch(params) => self.conditional_dispatch_run(params),
            Variant::Preprocess(condition_value, inverted) => {
                self.conditional_preprocess_run(condition_value, inverted)
            }
        }
    }
}

impl MeshConditionalInstance<'_> {
    fn conditional_dispatch_run(&self, params: TestParams) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let stage_flags = shader_stages(params.has_task);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::COLOR_ATTACHMENT;
        let u32_size = 4usize;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;

        let color_buffer = ImageWithBuffer::new(context, WIDTH, HEIGHT, color_format, color_usage, 4)?;
        let vertex_buffer = make_vertex_buffer(context)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, vk::ShaderStageFlags::MESH_EXT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let vertex_buffer_desc_info = make_descriptor_buffer_info(vertex_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                desc_type,
                &vertex_buffer_desc_info,
            )
            .update(device);

        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: std::mem::size_of::<Vec4>() as u32,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        let binaries = context.get_binary_collection();
        let task_module = if params.has_task {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], WIDTH, HEIGHT, 1)?;

        // The pipeline is either the DGC one (indirect bindable) or the normal one, never both.
        let pipeline = make_mesh_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &MeshStages {
                task: task_module.as_ref().map(|module| **module),
                mesh: *mesh_module,
                frag: Some(*frag_module),
            },
            (WIDTH, HEIGHT),
            params.pipeline_token,
        )?;
        let (dgc_pipeline, normal_pipeline) = if params.pipeline_token {
            (*pipeline, vk::Pipeline::null())
        } else {
            (vk::Pipeline::null(), *pipeline)
        };

        // Indirect commands layout. Push constant followed by draw mesh tasks, optionally preceded by a pipeline bind.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::empty(),
            stage_flags,
            *pipeline_layout,
        );
        if params.pipeline_token {
            let offset = cmds_layout_builder.get_stream_range();
            cmds_layout_builder.add_execution_set_token(
                offset,
                vk::IndirectExecutionSetInfoTypeEXT::PIPELINES,
                stage_flags,
            );
        }
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_push_constant_token(offset, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_mesh_tasks_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut gen_cmds_data: Vec<u32> = Vec::new();
        if params.pipeline_token {
            gen_cmds_data.push(0);
        }
        push_back_element(&mut gen_cmds_data, &PC_VALUE);
        {
            let draw_cmd = vk::DrawMeshTasksIndirectCommandEXT {
                group_count_x: 1,
                group_count_y: HEIGHT,
                group_count_z: 1,
            };
            push_back_element(&mut gen_cmds_data, &draw_cmd);
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

        // Avoid using value 1, just to make it interesting.
        let condition_value: u32 = if params.condition_value { 1024 } else { 0 };
        let condition_buffer = write_buffer(
            context,
            &condition_value.to_ne_bytes(),
            vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT,
        )?;

        let mut execution_set_manager: Option<ExecutionSetManagerExt<'_>> = None;
        if params.pipeline_token {
            let mut manager = ExecutionSetManagerExt::new_pipeline(device, dgc_pipeline, 1)?;
            // Lets rely on the initial value.
            manager.update();
            execution_set_manager = Some(manager);
        }
        let execution_set_handle = execution_set_manager
            .as_ref()
            .map_or(vk::IndirectExecutionSetEXT::null(), ExecutionSetManagerExt::get);

        // Preprocess buffer for 256 sequences (actually only using one, but we'll pretend we may use more).
        let potential_sequence_count = 256u32;
        let actual_sequence_count = 1u32;
        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            execution_set_handle,
            cmds_layout.get(),
            potential_sequence_count,
            0,
            normal_pipeline,
            0,
        )?;

        let sequence_count_buffer = if params.indirect_count_buffer {
            let buffer = DgcBuffer::new(
                context,
                u32_size as vk::DeviceSize,
                vk::BufferUsageFlags::empty(),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            {
                let alloc = buffer.get_allocation();
                // SAFETY: the buffer holds 4 bytes.
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        actual_sequence_count.to_ne_bytes().as_ptr(),
                        alloc.get_host_ptr(),
                        u32_size,
                    )
                };
                flush_alloc(device, alloc)?;
            }
            Some(buffer)
        } else {
            None
        };

        let sequence_count_buffer_address = sequence_count_buffer.as_ref().map_or(0, DgcBuffer::get_device_address);
        let info_sequences_count = if params.indirect_count_buffer {
            potential_sequence_count
        } else {
            actual_sequence_count
        };
        let cmds_info = DgcGenCmdsInfo::new(
            stage_flags,
            execution_set_handle,
            cmds_layout.get(),
            gen_cmds_buffer.get_device_address(),
            gen_cmds_buffer_size,
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            info_sequences_count,
            sequence_count_buffer_address,
            0,
            normal_pipeline,
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_owner = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer_owner.get();

        begin_command_buffer(device, cmd_buffer)?;
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, WIDTH, HEIGHT),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: CLEAR_VALUE },
            },
        );
        begin_conditional_rendering(device, cmd_buffer, condition_buffer.get(), params.inverted);
        // Binds the normal (non-DGC) pipeline or the DGC one, whichever is present.
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            device.cmd_execute_generated_commands_ext(cmd_buffer, false, cmds_info.get());
            device.cmd_end_conditional_rendering_ext(cmd_buffer);
        }
        end_render_pass(device, cmd_buffer);
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

        verify(&color_buffer, device, params.condition_value != params.inverted)
    }

    /// These tests try to check conditional rendering does not affect preprocessing.
    fn conditional_preprocess_run(&self, condition_value: bool, inverted: bool) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let dgc_stages = vk::ShaderStageFlags::MESH_EXT | vk::ShaderStageFlags::FRAGMENT;
        let bind_point = vk::PipelineBindPoint::GRAPHICS;
        let seq_count = 1u32;
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::TRANSFER_DST
            | vk::ImageUsageFlags::TRANSFER_SRC
            | vk::ImageUsageFlags::COLOR_ATTACHMENT;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;

        let color_buffer = ImageWithBuffer::new(context, WIDTH, HEIGHT, color_format, color_usage, 4)?;
        let vertex_buffer = make_vertex_buffer(context)?;

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, vk::ShaderStageFlags::MESH_EXT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let vertex_buffer_desc_info = make_descriptor_buffer_info(vertex_buffer.get(), 0, vk::WHOLE_SIZE);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                desc_type,
                &vertex_buffer_desc_info,
            )
            .update(device);

        let pc_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::FRAGMENT,
            offset: 0,
            size: std::mem::size_of::<Vec4>() as u32,
        };
        let pipeline_layout = make_pipeline_layout_with_push_constants(device, &[*set_layout], &[pc_range])?;

        let binaries = context.get_binary_collection();
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let render_pass = make_render_pass(device, color_format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], WIDTH, HEIGHT, 1)?;

        let normal_pipeline = make_mesh_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &MeshStages {
                task: None,
                mesh: *mesh_module,
                frag: Some(*frag_module),
            },
            (WIDTH, HEIGHT),
            false,
        )?;

        // Indirect commands layout. Push constant followed by draw mesh tasks.
        let mut cmds_layout_builder = IndirectCommandsLayoutBuilderExt::new(
            vk::IndirectCommandsLayoutUsageFlagsEXT::EXPLICIT_PREPROCESS,
            dgc_stages,
            *pipeline_layout,
        );
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_push_constant_token(offset, pc_range);
        let offset = cmds_layout_builder.get_stream_range();
        cmds_layout_builder.add_draw_mesh_tasks_token(offset);
        let cmds_layout = cmds_layout_builder.build(device)?;

        let mut gen_cmds_data: Vec<u32> = Vec::new();
        push_back_element(&mut gen_cmds_data, &PC_VALUE);
        {
            let draw_cmd = vk::DrawMeshTasksIndirectCommandEXT {
                group_count_x: 1,
                group_count_y: 1,
                group_count_z: HEIGHT,
            };
            push_back_element(&mut gen_cmds_data, &draw_cmd);
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

        let condition_word: u32 = if condition_value { 1024 } else { 0 };
        let condition_buffer = write_buffer(
            context,
            &condition_word.to_ne_bytes(),
            vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT,
        )?;

        let preprocess_buffer = PreprocessBufferExt::new(
            context,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            seq_count,
            0,
            *normal_pipeline,
            0,
        )?;
        let cmds_info = DgcGenCmdsInfo::new(
            dgc_stages,
            vk::IndirectExecutionSetEXT::null(),
            cmds_layout.get(),
            gen_cmds_buffer.get_device_address(),
            gen_cmds_buffer_size,
            preprocess_buffer.get_device_address(),
            preprocess_buffer.get_size(),
            seq_count,
            0,
            0,
            *normal_pipeline,
        );

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let preprocess_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let execute_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let cmd_buffer = preprocess_cmd_buffer.get();
        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, bind_point, *normal_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
        }
        begin_conditional_rendering(device, cmd_buffer, condition_buffer.get(), inverted);
        unsafe {
            device.cmd_preprocess_generated_commands_ext(cmd_buffer, cmds_info.get(), cmd_buffer);
            device.cmd_end_conditional_rendering_ext(cmd_buffer);
        }
        preprocess_to_execute_barrier_ext(device, cmd_buffer);
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        let cmd_buffer = execute_cmd_buffer.get();
        begin_command_buffer(device, cmd_buffer)?;
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, bind_point, *normal_pipeline);
            device.cmd_bind_descriptor_sets(
                cmd_buffer,
                bind_point,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
        }
        begin_render_pass(
            device,
            cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, WIDTH, HEIGHT),
            vk::ClearValue {
                color: vk::ClearColorValue { float32: CLEAR_VALUE },
            },
        );
        begin_conditional_rendering(device, cmd_buffer, condition_buffer.get(), inverted);
        unsafe {
            device.cmd_execute_generated_commands_ext(cmd_buffer, true, cmds_info.get());
            device.cmd_end_conditional_rendering_ext(cmd_buffer);
        }
        end_render_pass(device, cmd_buffer);
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

        verify(&color_buffer, device, inverted != condition_value)
    }
}

fn verify(color_buffer: &ImageWithBuffer<'_>, device: &Device, expect_pushed_color: bool) -> TestOutcome {
    let expected_value = if expect_pushed_color { PC_VALUE } else { CLEAR_VALUE };
    let reference = vec![expected_value; (WIDTH * HEIGHT) as usize];
    let result = color_buffer.read_bytes(device)?;
    if !float_threshold_compare(result, &reference, [0.0; 4]) {
        return Ok(TestStatus::fail(
            "Unexpected output found in color buffer; check log for details",
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

/// `createDGCGraphicsMeshConditionalTestsExt`: the cases by their full dotted path in `dgc`.
pub fn create_dgc_graphics_mesh_conditional_tests_ext() -> Vec<(String, Box<dyn TestCase>)> {
    let mut cases: Vec<(String, Box<dyn TestCase>)> = Vec::new();

    for pipeline_token in [false, true] {
        for indirect_count_buffer in [false, true] {
            for condition_value in [false, true] {
                for inverted in [false, true] {
                    for has_task in [false, true] {
                        let params = TestParams {
                            has_task,
                            pipeline_token,
                            indirect_count_buffer,
                            condition_value,
                            inverted,
                        };
                        let name = format!(
                            "{}{}{}{}{}",
                            if pipeline_token {
                                "pipeline_token"
                            } else {
                                "classic_bind"
                            },
                            if indirect_count_buffer {
                                "_with_count_buffer"
                            } else {
                                "_without_count_buffer"
                            },
                            if condition_value {
                                "_condition_true"
                            } else {
                                "_condition_false"
                            },
                            if inverted { "_inverted_flag" } else { "" },
                            if has_task { "_with_task_shader" } else { "" },
                        );
                        cases.push((
                            format!("ext.graphics.mesh.conditional_rendering.general.{name}"),
                            Box::new(MeshConditionalCase {
                                name,
                                variant: Variant::Dispatch(params),
                            }) as Box<dyn TestCase>,
                        ));
                    }
                }
            }
        }
    }

    for condition_value in [false, true] {
        for inverted in [false, true] {
            let name = format!(
                "{}{}",
                if condition_value {
                    "condition_true"
                } else {
                    "condition_false"
                },
                if inverted { "_inverted_flag" } else { "" },
            );
            cases.push((
                format!("ext.graphics.mesh.conditional_rendering.preprocess.{name}"),
                Box::new(MeshConditionalCase {
                    name,
                    variant: Variant::Preprocess(condition_value, inverted),
                }) as Box<dyn TestCase>,
            ));
        }
    }
    cases
}
