// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiGPAInterfaceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2026 The Khronos Group Inc.
// Copyright (c) 2026 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The extension itself is declared in vk/gpa_interface.rs. The shaders of the
// `regular_session_*` cases are in shaders/manifest/api_gpa_interface.toml. The colour attachment of the graphics cases is read
// back with `read_color_attachment` in a second submission instead of a copy recorded inside the GPA sample.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_3, KhrSynchronization2ExtensionDeviceCommands};

use super::case_util::{add_case, add_function_case};
use crate::generated::shaders::api_gpa_interface::{
    COMP, VERT_FRAG, VERT_GEOM_FRAG, VERT_TESS_FRAG, VERT_TESS_GEOM_FRAG,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, submit_commands_and_wait,
};
use crate::vk::gpa_interface::{
    self, Commands, FEATURE_PERF_COUNTERS, GPA_PERF_BLOCK_ATC, GPA_PERF_BLOCK_ATC_L2, GPA_PERF_BLOCK_CHCG,
    GPA_PERF_BLOCK_GL1CG, GPA_PERF_BLOCK_GRBM_SE, GPA_PERF_BLOCK_GUS, GPA_PERF_BLOCK_PC, GPA_PERF_BLOCK_RPB,
    GPA_PERF_BLOCK_UMCCH, GPA_SAMPLE_TYPE_CUMULATIVE, GPA_SAMPLE_TYPE_TIMING, GpaPerfCounter, GpaSampleBeginInfo,
    GpaSession,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info, make_command_pool,
    make_descriptor_set, make_framebuffer, make_graphics_pipeline_staged, make_memory_barrier, make_pipeline_layout,
    make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

fn check_basic_support(context: &Context<'_>) -> Result<(), TestError> {
    gpa_interface::check_feature_support(context, 0)
}

fn check_gpa_and_sync2(context: &Context<'_>) -> Result<(), TestError> {
    check_basic_support(context)?;
    context.require_device_functionality("VK_KHR_synchronization2")
}

fn failure(message: String) -> TestOutcome {
    log::error!("{message}");
    Ok(TestStatus::fail(&message))
}

fn make_session<'a>(
    commands: &'a Commands,
    device: &'a Device,
    copy_source: gpa_interface::GpaSessionHandle,
) -> Result<GpaSession<'a>, TestError> {
    GpaSession::new(commands, device, copy_source)
}

fn record_empty_session(
    commands: &Commands,
    cmd_buffer: vk::CommandBuffer,
    session: gpa_interface::GpaSessionHandle,
) -> Result<(), TestError> {
    commands.begin_session(cmd_buffer, session)?;
    commands.end_session(cmd_buffer, session)
}

/// `checkSessionStatus`: every session must be either complete or not ready
fn check_session_status(commands: &Commands, device: &Device, sessions: &[gpa_interface::GpaSessionHandle]) -> bool {
    let mut ok = true;
    for (i, &session) in sessions.iter().enumerate() {
        let status = commands.session_status(device, session);
        if status != vk::Result::SUCCESS && status != vk::Result::NOT_READY {
            ok = false;
            log::error!("Session {i}: status {status:?}");
        }
    }
    ok
}

fn test_device_clock_info(context: &Context<'_>) -> TestOutcome {
    let commands = gpa_interface::load_commands(context)?;
    let info = commands.device_clock_info(context.get_device())?;

    const MIN_FREQUENCY: u32 = 50;
    const MAX_FREQUENCY: u32 = 10000;
    const MIN_RATIO: f32 = 0.0;
    const MAX_RATIO: f32 = 1.0;

    let mut fail = false;
    let mut check_freq = |value: u32, name: &str| {
        if !(MIN_FREQUENCY..=MAX_FREQUENCY).contains(&value) {
            fail = true;
            log::error!("{name} ({value}) out of expected range [{MIN_FREQUENCY}, {MAX_FREQUENCY}]");
        }
    };
    check_freq(info.engine_clock_frequency, "engineClockFrequency");
    check_freq(info.memory_clock_frequency, "memoryClockFrequency");
    let mut check_ratio = |value: f32, name: &str| {
        if value <= MIN_RATIO || value > MAX_RATIO {
            fail = true;
            log::error!("{name} ({value}) out of expected range ({MIN_RATIO}, {MAX_RATIO}]");
        }
    };
    check_ratio(info.engine_clock_ratio_to_peak, "engineClockRatioToPeak");
    check_ratio(info.memory_clock_ratio_to_peak, "memoryClockRatioToPeak");

    if fail {
        return Ok(TestStatus::fail("Unexpected clock info values; check log for details"));
    }
    Ok(TestStatus::pass("Pass"))
}

fn test_create_destroy_session(context: &Context<'_>) -> TestOutcome {
    let commands = gpa_interface::load_commands(context)?;
    let _session = make_session(&commands, context.get_device(), 0)?;
    Ok(TestStatus::pass("Pass"))
}

fn test_create_destroy_session_with_copy(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let commands = gpa_interface::load_commands(context)?;
    let src_session = make_session(&commands, device, 0)?;

    // vkCreateGpaSessionAMD with secondaryCopySource only works after the source GPA session has a begin and end.
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *cmd_buffer)?;
    record_empty_session(&commands, *cmd_buffer, src_session.get())?;
    end_command_buffer(device, *cmd_buffer)?;

    let _dst_session = make_session(&commands, device, src_session.get())?;
    Ok(TestStatus::pass("Pass"))
}

fn test_empty_sessions(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let commands = gpa_interface::load_commands(context)?;
    let session_count = 2;

    let sessions = (0..session_count)
        .map(|_| make_session(&commands, device, 0))
        .collect::<Result<Vec<_>, _>>()?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *cmd_buffer)?;
    for session in &sessions {
        record_empty_session(&commands, *cmd_buffer, session.get())?;
    }
    end_command_buffer(device, *cmd_buffer)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

    let handles: Vec<_> = sessions.iter().map(GpaSession::get).collect();
    if !check_session_status(&commands, device, &handles) {
        return Ok(TestStatus::fail(
            "Unexpected vkGetGpaSessionStatusAMD results for some sessions; check log for details --",
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

fn test_created_status(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let commands = gpa_interface::load_commands(context)?;
    let session = make_session(&commands, device, 0)?;

    let result = commands.session_status(device, session.get());
    if result != vk::Result::NOT_READY {
        return failure(format!("Unexpected session status after creation: {result:?}"));
    }
    Ok(TestStatus::pass("Pass"))
}

fn test_unfinished_status(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let commands = gpa_interface::load_commands(context)?;
    let session = make_session(&commands, device, 0)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let check_not_ready = |error_prefix: &str| -> Option<String> {
        let result = commands.session_status(device, session.get());
        (result != vk::Result::NOT_READY).then(|| format!("{error_prefix}: {result:?}"))
    };

    begin_command_buffer(device, *cmd_buffer)?;
    commands.begin_session(*cmd_buffer, session.get())?;
    if let Some(message) = check_not_ready("Unexpected session status after creation") {
        return failure(message);
    }
    end_command_buffer(device, *cmd_buffer)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;
    if let Some(message) = check_not_ready("Unexpected session status after recording") {
        return failure(message);
    }
    Ok(TestStatus::pass("Pass"))
}

fn test_empty_sessions_multi_cmd(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let commands = gpa_interface::load_commands(context)?;
    let session_count = 3;

    let sessions = (0..session_count)
        .map(|_| make_session(&commands, device, 0))
        .collect::<Result<Vec<_>, _>>()?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let cmd_buffer1_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer2_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer1 = *cmd_buffer1_ptr;
    let cmd_buffer2 = *cmd_buffer2_ptr;

    begin_command_buffer(device, cmd_buffer1)?;
    record_empty_session(&commands, cmd_buffer1, sessions[0].get())?;
    commands.begin_session(cmd_buffer1, sessions[1].get())?;
    end_command_buffer(device, cmd_buffer1)?;

    begin_command_buffer(device, cmd_buffer2)?;
    commands.end_session(cmd_buffer2, sessions[1].get())?;
    record_empty_session(&commands, cmd_buffer2, sessions[session_count - 1].get())?;
    end_command_buffer(device, cmd_buffer2)?;

    let semaphore = Unique::new(
        device,
        unsafe { device.create_semaphore(&vk::SemaphoreCreateInfo::builder(), None) }.vk_check("vkCreateSemaphore")?,
    );
    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );

    let cmd_buffers1 = [cmd_buffer1];
    let cmd_buffers2 = [cmd_buffer2];
    let semaphores = [*semaphore];
    let wait_stages = [vk::PipelineStageFlags::ALL_COMMANDS];
    let submit_infos = [
        vk::SubmitInfo::builder()
            .command_buffers(&cmd_buffers1)
            .signal_semaphores(&semaphores),
        vk::SubmitInfo::builder()
            .wait_semaphores(&semaphores)
            .wait_dst_stage_mask(&wait_stages)
            .command_buffers(&cmd_buffers2),
    ];
    unsafe { device.queue_submit(context.get_universal_queue(), &submit_infos, *fence) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[*fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;

    let handles: Vec<_> = sessions.iter().map(GpaSession::get).collect();
    if !check_session_status(&commands, device, &handles) {
        return Ok(TestStatus::fail(
            "Unexpected vkGetGpaSessionStatusAMD results for some sessions; check log for details --",
        ));
    }
    Ok(TestStatus::pass("Pass"))
}

fn full_barrier(context: &Context<'_>, cmd_buffer: vk::CommandBuffer) {
    let device = context.get_device();
    let stage_mask = vk::PipelineStageFlags2::ALL_COMMANDS;
    let access_mask = vk::AccessFlags2::MEMORY_READ | vk::AccessFlags2::MEMORY_WRITE;
    let barriers = [vk::MemoryBarrier2::builder()
        .src_stage_mask(stage_mask)
        .src_access_mask(access_mask)
        .dst_stage_mask(stage_mask)
        .dst_access_mask(access_mask)];
    let dependency_info = vk::DependencyInfo::builder().memory_barriers(&barriers);
    let has_khr_sync2 = context
        .get_device_extensions()
        .iter()
        .any(|extension| extension == "VK_KHR_synchronization2");
    unsafe {
        if has_khr_sync2 {
            device.cmd_pipeline_barrier2_khr(cmd_buffer, &dependency_info);
        } else {
            device.cmd_pipeline_barrier2(cmd_buffer, &dependency_info);
        }
    }
}

fn test_empty_secondary_with_copy(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let commands = gpa_interface::load_commands(context)?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let primary_cmd_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let secondary_cmd_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
    let primary_cmd = *primary_cmd_ptr;
    let secondary_cmd = *secondary_cmd_ptr;

    let secondary_session = make_session(&commands, device, 0)?;

    let inheritance = vk::CommandBufferInheritanceInfo::builder();
    let begin_info = vk::CommandBufferBeginInfo::builder()
        .flags(vk::CommandBufferUsageFlags::SIMULTANEOUS_USE)
        .inheritance_info(&inheritance);
    unsafe { device.begin_command_buffer(secondary_cmd, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
    record_empty_session(&commands, secondary_cmd, secondary_session.get())?;
    end_command_buffer(device, secondary_cmd)?;

    let primary_session0 = make_session(&commands, device, secondary_session.get())?;
    let primary_session1 = make_session(&commands, device, secondary_session.get())?;

    begin_command_buffer(device, primary_cmd)?;
    unsafe { device.cmd_execute_commands(primary_cmd, &[secondary_cmd]) };
    full_barrier(context, primary_cmd);
    commands.copy_session_results(primary_cmd, primary_session0.get());
    unsafe { device.cmd_execute_commands(primary_cmd, &[secondary_cmd]) };
    full_barrier(context, primary_cmd);
    commands.copy_session_results(primary_cmd, primary_session1.get());
    end_command_buffer(device, primary_cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), primary_cmd)?;

    Ok(TestStatus::pass("Pass"))
}

fn test_reset_empty_session(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let commands = gpa_interface::load_commands(context)?;
    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let first_cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let second_cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let session = make_session(&commands, device, 0)?;

    begin_command_buffer(device, *first_cmd)?;
    record_empty_session(&commands, *first_cmd, session.get())?;
    end_command_buffer(device, *first_cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *first_cmd)?;

    let first_res = commands.session_status(device, session.get());
    if first_res != vk::Result::SUCCESS {
        return failure(format!("Unexpected session status before reset: {first_res:?}"));
    }

    commands.reset_session(device, session.get());

    let second_res = commands.session_status(device, session.get());
    if second_res != vk::Result::NOT_READY && second_res != vk::Result::SUCCESS {
        // Upstream prints firstRes here, as it does in the next message.
        return failure(format!("Unexpected session status after reset: {first_res:?}"));
    }

    begin_command_buffer(device, *second_cmd)?;
    commands.begin_session(*second_cmd, session.get())?;
    end_command_buffer(device, *second_cmd)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *second_cmd)?;

    let third_res = commands.session_status(device, session.get());
    if third_res != vk::Result::NOT_READY {
        return failure(format!("Unexpected session status after begin: {first_res:?}"));
    }
    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy)]
struct RegularSessionParams {
    stage_flags: vk::ShaderStageFlags,
    timing: bool,
}

impl RegularSessionParams {
    fn is_compute(&self) -> bool {
        self.stage_flags.contains(vk::ShaderStageFlags::COMPUTE)
    }

    fn compute_wg_size(&self) -> u32 {
        64
    }

    fn compute_wg_count(&self) -> u32 {
        64
    }

    fn extent(&self) -> (u32, u32) {
        (64, 64)
    }

    fn has_shader_stage(&self, stage: vk::ShaderStageFlags) -> bool {
        self.stage_flags.contains(stage)
    }

    fn clear_color(&self) -> [f32; 4] {
        [0.0, 0.0, 0.0, 1.0]
    }

    /// The expected pixel, as the RGBA8 bytes of `getFinalColor`
    fn final_color(&self) -> [u8; 4] {
        let mut color = [0, 0, 255, 255];
        if self.has_shader_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL) {
            color = [0, 255, 255, 255];
        }
        if self.has_shader_stage(vk::ShaderStageFlags::GEOMETRY) {
            color = [255, 255, 255, 255];
        }
        color
    }
}

struct RegularSessionCase {
    name: String,
    params: RegularSessionParams,
}

impl TestCase for RegularSessionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        gpa_interface::check_feature_support(context, FEATURE_PERF_COUNTERS)?;
        let features = context.get_device_features();
        if self
            .params
            .stage_flags
            .contains(vk::ShaderStageFlags::TESSELLATION_CONTROL)
            && features.tessellation_shader == vk::FALSE
        {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if self.params.stage_flags.contains(vk::ShaderStageFlags::GEOMETRY) && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let flags = self.params.stage_flags;
        if self.params.is_compute() {
            COMP.programs
        } else if flags.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL)
            && flags.contains(vk::ShaderStageFlags::GEOMETRY)
        {
            VERT_TESS_GEOM_FRAG.programs
        } else if flags.contains(vk::ShaderStageFlags::TESSELLATION_CONTROL) {
            VERT_TESS_FRAG.programs
        } else if flags.contains(vk::ShaderStageFlags::GEOMETRY) {
            VERT_GEOM_FRAG.programs
        } else {
            VERT_FRAG.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(RegularSessionInstance {
            context,
            params: self.params,
        })
    }
}

struct RegularSessionInstance<'a> {
    context: &'a Context<'a>,
    params: RegularSessionParams,
}

impl TestInstance for RegularSessionInstance<'_> {
    #[expect(
        unused_assignments,
        reason = "drops the previous object here, as upstream's reset does"
    )]
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let commands = gpa_interface::load_commands(context)?;

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;
        let session = make_session(&commands, device, 0)?;

        let perf_blocks = gpa_interface::get_device_perf_blocks(context);
        let mut perf_counters: Vec<GpaPerfCounter> = Vec::new();

        // According to the GPA library, these are problematic because they are exposed and do not always exist.
        let skipped_blocks = [
            GPA_PERF_BLOCK_GL1CG,
            GPA_PERF_BLOCK_ATC,
            GPA_PERF_BLOCK_ATC_L2,
            GPA_PERF_BLOCK_CHCG,
            GPA_PERF_BLOCK_GUS,
            GPA_PERF_BLOCK_UMCCH,
            GPA_PERF_BLOCK_RPB,
            GPA_PERF_BLOCK_PC,
            GPA_PERF_BLOCK_GRBM_SE,
        ];

        for perf_block in &perf_blocks {
            if perf_block.instance_count == 0 || perf_block.max_event_id == 0 {
                continue;
            }
            // Apparently this is the relevant field for VK_GPA_SAMPLE_TYPE_CUMULATIVE_AMD.
            if !params.timing && perf_block.max_global_only_counters == 0 {
                continue;
            }
            if skipped_blocks.contains(&perf_block.block_type) {
                continue;
            }
            perf_counters.push(GpaPerfCounter {
                block_type: perf_block.block_type,
                block_instance: 0,
                event_id: 0,
            });
        }

        let sample_type = if params.timing {
            GPA_SAMPLE_TYPE_TIMING
        } else {
            GPA_SAMPLE_TYPE_CUMULATIVE
        };
        let timing_pre_sample = if params.timing {
            vk::PipelineStageFlags::TOP_OF_PIPE
        } else {
            vk::PipelineStageFlags::empty()
        };
        let timing_post_sample = if params.timing {
            vk::PipelineStageFlags::BOTTOM_OF_PIPE
        } else {
            vk::PipelineStageFlags::empty()
        };
        let sample_begin_info =
            GpaSampleBeginInfo::new(sample_type, &perf_counters, timing_pre_sample, timing_post_sample);

        let comp_wg_count = params.compute_wg_count();
        let comp_item_count = (params.compute_wg_size() * comp_wg_count) as usize;
        let color_extent = params.extent();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let vert_count = color_extent.0 * color_extent.1 * 3;
        let binaries = context.get_binary_collection();

        let mut comp_buffer: Option<BufferWithMemory<'_>> = None;
        let mut vert_buffer: Option<BufferWithMemory<'_>> = None;
        let mut color_buffer: Option<ImageWithBuffer<'_>> = None;

        let set_layout;
        let descriptor_pool;
        let descriptor_set;
        let pipeline_layout;
        let render_pass;
        let framebuffer;
        let pipeline;

        let comp_module;
        let vert_module;
        let tesc_module;
        let tese_module;
        let geom_module;
        let frag_module;

        if params.is_compute() {
            let desc_type = vk::DescriptorType::STORAGE_BUFFER;
            descriptor_pool = Some(DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                1,
            )?);
            set_layout = Some(
                DescriptorSetLayoutBuilder::new()
                    .add_single_binding(desc_type, params.stage_flags)
                    .build(device)?,
            );
            pipeline_layout = make_pipeline_layout(device, &[**set_layout.as_ref().unwrap()])?;
            descriptor_set = Some(make_descriptor_set(
                device,
                **descriptor_pool.as_ref().unwrap(),
                **set_layout.as_ref().unwrap(),
            )?);

            let comp_buffer_size = (comp_item_count * std::mem::size_of::<u32>()) as vk::DeviceSize;
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(comp_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let alloc = buffer.get_allocation();
            unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, comp_buffer_size as usize) };
            flush_alloc(device, alloc)?;

            let desc_info = vk::DescriptorBufferInfo {
                buffer: *buffer,
                offset: 0,
                range: vk::WHOLE_SIZE,
            };
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    **descriptor_set.as_ref().unwrap(),
                    Location::binding(0),
                    desc_type,
                    &desc_info,
                )
                .update(device);
            comp_buffer = Some(buffer);

            comp_module = Some(create_shader_module(device, binaries.get("comp")?)?);
            let stage = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(**comp_module.as_ref().unwrap())
                .name(b"main\0")
                .build();
            let info = vk::ComputePipelineCreateInfo::builder()
                .stage(stage)
                .layout(*pipeline_layout)
                .base_pipeline_index(-1)
                .build();
            let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateComputePipelines")?;
            pipeline = Unique::new(device, pipelines.0[0]);
            render_pass = None;
            framebuffer = None;
            vert_module = None;
            tesc_module = None;
            tese_module = None;
            geom_module = None;
            frag_module = None;
        } else {
            let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;
            let color = ImageWithBuffer::new(context, color_extent.0, color_extent.1, color_format, color_usage, 4)?;

            let pass = make_render_pass(device, color_format)?;
            framebuffer = Some(make_framebuffer(
                device,
                *pass,
                &[*color.view],
                color_extent.0,
                color_extent.1,
                1,
            )?);
            render_pass = Some(pass);

            // One triangle per pixel.
            let mut vertices: Vec<[f32; 4]> = Vec::with_capacity(vert_count as usize);
            let float_extent = (color_extent.0 as f32, color_extent.1 as f32);
            let pixel_width = 2.0 / float_extent.0;
            let pixel_height = 2.0 / float_extent.1;
            let width_margin = pixel_width / 4.0;
            let height_margin = pixel_height / 4.0;

            for y in 0..color_extent.1 {
                for x in 0..color_extent.0 {
                    // Normalized pixel center.
                    let x_center = ((x as f32 + 0.5) / float_extent.0) * 2.0 - 1.0;
                    let y_center = ((y as f32 + 0.5) / float_extent.1) * 2.0 - 1.0;

                    vertices.push([x_center, y_center - height_margin, 0.0, 1.0]); // Top
                    vertices.push([x_center - width_margin, y_center + height_margin, 0.0, 1.0]); // Bottom left.
                    vertices.push([x_center + width_margin, y_center + height_margin, 0.0, 1.0]); // Bottom right.
                }
            }

            let vert_buffer_size = std::mem::size_of_val(vertices.as_slice()) as vk::DeviceSize;
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(vert_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let alloc = buffer.get_allocation();
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    alloc.get_host_ptr(),
                    vert_buffer_size as usize,
                )
            };
            flush_alloc(device, alloc)?;
            vert_buffer = Some(buffer);

            let has_tess = params.has_shader_stage(vk::ShaderStageFlags::TESSELLATION_CONTROL);
            let has_geom = params.has_shader_stage(vk::ShaderStageFlags::GEOMETRY);

            vert_module = Some(create_shader_module(device, binaries.get("vert")?)?);
            tesc_module = if has_tess {
                Some(create_shader_module(device, binaries.get("tesc")?)?)
            } else {
                None
            };
            tese_module = if has_tess {
                Some(create_shader_module(device, binaries.get("tese")?)?)
            } else {
                None
            };
            geom_module = if has_geom {
                Some(create_shader_module(device, binaries.get("geom")?)?)
            } else {
                None
            };
            frag_module = Some(create_shader_module(device, binaries.get("frag")?)?);

            let topology = if has_tess {
                vk::PrimitiveTopology::PATCH_LIST
            } else {
                vk::PrimitiveTopology::TRIANGLE_LIST
            };
            pipeline_layout = make_pipeline_layout(device, &[])?;
            pipeline = make_graphics_pipeline_staged(
                device,
                *pipeline_layout,
                GraphicsPipelineStages {
                    vertex: **vert_module.as_ref().unwrap(),
                    fragment: **frag_module.as_ref().unwrap(),
                    tessellation_control: tesc_module.as_ref().map(|module| **module),
                    tessellation_evaluation: tese_module.as_ref().map(|module| **module),
                    geometry: geom_module.as_ref().map(|module| **module),
                },
                **render_pass.as_ref().unwrap(),
                color_extent,
                topology,
                vk::SampleCountFlags::_1,
                None,
                1,
                None,
                None,
            )?;
            color_buffer = Some(color);
            set_layout = None;
            descriptor_pool = None;
            descriptor_set = None;
        }

        begin_command_buffer(device, cmd_buffer)?;
        commands.begin_session(cmd_buffer, session.get())?;
        let sample_id = commands.begin_sample(cmd_buffer, session.get(), &sample_begin_info)?;
        if params.is_compute() {
            let bind_point = vk::PipelineBindPoint::COMPUTE;
            unsafe {
                device.cmd_bind_pipeline(cmd_buffer, bind_point, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd_buffer,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[**descriptor_set.as_ref().unwrap()],
                    &[] as &[u32],
                );
                device.cmd_dispatch(cmd_buffer, comp_wg_count, 1, 1);
            }
            let host_barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COMPUTE_SHADER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[host_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        } else {
            let render_area = vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: color_extent.0,
                    height: color_extent.1,
                },
            };
            let clear_value = vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: params.clear_color(),
                },
            };
            begin_render_pass(
                device,
                cmd_buffer,
                **render_pass.as_ref().unwrap(),
                **framebuffer.as_ref().unwrap(),
                render_area,
                clear_value,
            );
            unsafe {
                device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[**vert_buffer.as_ref().unwrap()], &[0]);
                device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_draw(cmd_buffer, vert_count, 1, 0, 0);
            }
            end_render_pass(device, cmd_buffer);
        }
        commands.end_sample(cmd_buffer, session.get(), sample_id);
        commands.end_session(cmd_buffer, session.get())?;
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd_buffer)?;

        let session_status = commands.session_status(device, session.get());
        if session_status != vk::Result::SUCCESS {
            return failure(format!("Unexpected session status: {session_status:?}"));
        }

        let result_bytes = commands.session_results(device, session.get(), sample_id, None)?;
        if result_bytes > 0 {
            let mut result_buffer = vec![0u8; result_bytes];
            let written = commands.session_results(device, session.get(), sample_id, Some(&mut result_buffer))?;
            if written != result_buffer.len() {
                return failure(format!(
                    "Amount of result bytes changed between vkGetGpaSessionResultsAMD calls: {} to {written}",
                    result_buffer.len()
                ));
            }
        }

        let mut fail = false;
        if params.is_compute() {
            let buffer = comp_buffer.as_ref().unwrap();
            invalidate_alloc(device, buffer.get_allocation())?;
            let results = unsafe {
                std::slice::from_raw_parts(buffer.get_allocation().get_host_ptr().cast::<u32>(), comp_item_count)
            };
            for (i, &value) in results.iter().enumerate() {
                if value != 1 {
                    log::error!("Unexpected value at position {i}: expected 1 but got {value}");
                    fail = true;
                }
            }
        } else {
            let color = color_buffer.as_ref().unwrap();
            let result = read_color_attachment(
                context,
                color.image.get(),
                color_format,
                color_extent,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?;
            let reference = params.final_color();
            let mismatches = result
                .data()
                .chunks_exact(4)
                .filter(|pixel| **pixel != reference)
                .count();
            if mismatches != 0 {
                log::error!("Color: {mismatches} pixels differ from the reference {reference:?}");
                fail = true;
            }
        }

        if fail {
            return Ok(TestStatus::fail("Unexpected results; check log for details --"));
        }
        Ok(TestStatus::pass("Pass"))
    }
}

/// `createGpaInterfaceTests`
pub fn create_gpa_interface_tests() -> TestCaseGroup {
    let mut root = TestCaseGroup::new("gpa_interface");
    add_function_case(
        &mut root,
        "device_clock_info",
        check_basic_support,
        test_device_clock_info,
    );
    add_function_case(
        &mut root,
        "create_destroy_basic",
        check_basic_support,
        test_create_destroy_session,
    );
    add_function_case(
        &mut root,
        "create_destroy_copy",
        check_basic_support,
        test_create_destroy_session_with_copy,
    );
    add_function_case(&mut root, "empty_sessions", check_basic_support, test_empty_sessions);
    add_function_case(&mut root, "created_status", check_basic_support, test_created_status);
    add_function_case(
        &mut root,
        "unfinished_status",
        check_basic_support,
        test_unfinished_status,
    );
    add_function_case(
        &mut root,
        "empty_sessions_multi_cmd",
        check_basic_support,
        test_empty_sessions_multi_cmd,
    );
    add_function_case(
        &mut root,
        "empty_secondary_with_copy",
        check_gpa_and_sync2,
        test_empty_secondary_with_copy,
    );
    add_function_case(
        &mut root,
        "reset_empty_session",
        check_basic_support,
        test_reset_empty_session,
    );

    let tess = vk::ShaderStageFlags::TESSELLATION_CONTROL | vk::ShaderStageFlags::TESSELLATION_EVALUATION;
    let regular_session_stages = [
        (vk::ShaderStageFlags::COMPUTE, "comp"),
        (
            vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::FRAGMENT,
            "vert_frag",
        ),
        (
            vk::ShaderStageFlags::VERTEX | tess | vk::ShaderStageFlags::FRAGMENT,
            "vert_tess_frag",
        ),
        (
            vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::GEOMETRY | vk::ShaderStageFlags::FRAGMENT,
            "vert_geom_frag",
        ),
        (
            vk::ShaderStageFlags::VERTEX | tess | vk::ShaderStageFlags::GEOMETRY | vk::ShaderStageFlags::FRAGMENT,
            "vert_tess_geom_frag",
        ),
    ];
    for (stage_flags, name) in regular_session_stages {
        for timing in [false, true] {
            let test_name = format!("regular_session_{name}{}", if timing { "_timing" } else { "" });
            add_case(
                &mut root,
                RegularSessionCase {
                    name: test_name,
                    params: RegularSessionParams { stage_flags, timing },
                },
            );
        }
    }
    root
}
