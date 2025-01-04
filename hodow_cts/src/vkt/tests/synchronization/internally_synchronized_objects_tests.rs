// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/synchronization/vktSynchronizationInternallySynchronizedObjectsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The thread group is `std::thread::scope`, whose join is what the C++ barrier-free
// `ThreadGroup::run` does; the spin barrier only exists for Vulkan SC. The device is created from the Context's instance rather
// than a custom instance.

use std::sync::Mutex;

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::synchronization_internally_synchronized_objects::{
    PIPELINE_CACHE_COMPUTE, PIPELINE_CACHE_GRAPHICS,
};
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::{IVec2, TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, make_rect_2d, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, SimpleAllocator, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueCommandBuffer};
use crate::vkt::tests::draw::util::clear_value_color;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const EXECUTION_PER_THREAD: usize = 100;
const BUFFER_ELEMENT_COUNT: usize = 16;
const BUFFER_SIZE: vk::DeviceSize = (BUFFER_ELEMENT_COUNT * 4) as vk::DeviceSize;

/// Wraps something that holds raw pointers into data which outlives the threads that read it.
struct SharedReadOnly<T>(T);

// SAFETY: only read after construction, and only while the owner is alive: the threads are scoped.
unsafe impl<T> Sync for SharedReadOnly<T> {}

/// `checkQueueFlags`
fn check_queue_flags(available_flag: vk::QueueFlags, needed_flag: vk::QueueFlags) -> bool {
    if needed_flag == vk::QueueFlags::TRANSFER {
        available_flag.intersects(vk::QueueFlags::GRAPHICS | vk::QueueFlags::COMPUTE | vk::QueueFlags::TRANSFER)
    } else {
        available_flag.contains(needed_flag)
    }
}

/// `MultiQueues` together with the logical device it owns.
struct MultiQueues {
    device: Device,
    allocator: SimpleAllocator,
    family_indices: Vec<u32>,
    queues: Vec<Vec<vk::Queue>>,
    command_pools: Vec<Vec<vk::CommandPool>>,
    available: Mutex<Vec<Vec<bool>>>,
}

/// A queue taken out of the pool, with a command buffer from its own command pool.
struct FreeQueue<'a> {
    family_ndx: usize,
    queue_ndx: usize,
    #[allow(dead_code)]
    family_index: u32,
    queue: vk::Queue,
    cmd_buffer: UniqueCommandBuffer<'a>,
}

impl MultiQueues {
    /// `createQueues`
    fn new(context: &Context<'_>, queue_flag: vk::QueueFlags) -> Result<Self, TestError> {
        let instance = context.get_instance();
        let physical_device = context.get_physical_device();
        let queue_family_properties = unsafe { instance.get_physical_device_queue_family_properties(physical_device) };

        let mut family_indices = Vec::new();
        let mut queue_counts = Vec::new();
        for (ndx, properties) in queue_family_properties.iter().enumerate() {
            if check_queue_flags(properties.queue_flags, queue_flag) {
                family_indices.push(ndx as u32);
                queue_counts.push(properties.queue_count);
            }
        }
        if family_indices.is_empty() {
            return Err(TestError::NotSupported("Queue not found".to_string()));
        }

        let max_queue_count = queue_counts.iter().copied().max().unwrap_or(0) as usize;
        let queue_priorities = vec![1.0f32; max_queue_count];

        let queue_infos: Vec<vk::DeviceQueueCreateInfo> = family_indices
            .iter()
            .zip(queue_counts.iter())
            .map(|(&family_index, &count)| {
                vk::DeviceQueueCreateInfo::builder()
                    .queue_family_index(family_index)
                    .queue_priorities(&queue_priorities[..count as usize])
                    .build()
            })
            .collect();

        let device_features = unsafe { instance.get_physical_device_features(physical_device) };
        let device_info = vk::DeviceCreateInfo::builder()
            .queue_create_infos(&queue_infos)
            .enabled_features(&device_features);
        let device =
            unsafe { instance.create_device(physical_device, &device_info, None) }.vk_check("vkCreateDevice")?;

        let memory_properties = unsafe { instance.get_physical_device_memory_properties(physical_device) };

        let mut queues = Vec::new();
        let mut command_pools = Vec::new();
        let mut available = Vec::new();
        for (&family_index, &count) in family_indices.iter().zip(queue_counts.iter()) {
            let mut family_queues = Vec::new();
            let mut family_pools = Vec::new();
            for queue_req_ndx in 0..count {
                family_queues.push(unsafe { device.get_device_queue(family_index, queue_req_ndx) });
                let pool_info = vk::CommandPoolCreateInfo::builder()
                    .flags(vk::CommandPoolCreateFlags::RESET_COMMAND_BUFFER)
                    .queue_family_index(family_index);
                family_pools
                    .push(unsafe { device.create_command_pool(&pool_info, None) }.vk_check("vkCreateCommandPool")?);
            }
            available.push(vec![true; count as usize]);
            queues.push(family_queues);
            command_pools.push(family_pools);
        }

        Ok(Self {
            device,
            allocator: SimpleAllocator::new(memory_properties),
            family_indices,
            queues,
            command_pools,
            available: Mutex::new(available),
        })
    }

    /// `MultiQueues::getFreeQueue`
    fn get_free_queue(&self) -> Result<Option<FreeQueue<'_>>, TestError> {
        for family_ndx in 0..self.family_indices.len() {
            for queue_ndx in 0..self.queues[family_ndx].len() {
                let mut available = self
                    .available
                    .lock()
                    .map_err(|_| TestError::InternalError("queue availability lock poisoned".to_string()))?;
                if available[family_ndx][queue_ndx] {
                    available[family_ndx][queue_ndx] = false;
                    let cmd_buffer = allocate_command_buffer(
                        &self.device,
                        self.command_pools[family_ndx][queue_ndx],
                        vk::CommandBufferLevel::PRIMARY,
                    );
                    return match cmd_buffer {
                        Ok(cmd_buffer) => Ok(Some(FreeQueue {
                            family_ndx,
                            queue_ndx,
                            family_index: self.family_indices[family_ndx],
                            queue: self.queues[family_ndx][queue_ndx],
                            cmd_buffer,
                        })),
                        Err(e) => {
                            available[family_ndx][queue_ndx] = true;
                            Err(e)
                        }
                    };
                }
            }
        }
        Ok(None)
    }

    /// `MultiQueues::releaseQueue`: the command buffer goes back to its pool first.
    fn release_queue(&self, free_queue: FreeQueue<'_>) {
        let FreeQueue {
            family_ndx,
            queue_ndx,
            cmd_buffer,
            ..
        } = free_queue;
        drop(cmd_buffer);
        if let Ok(mut available) = self.available.lock() {
            available[family_ndx][queue_ndx] = true;
        }
    }

    fn acquire_queue(&self) -> Result<FreeQueue<'_>, TestError> {
        loop {
            if let Some(free_queue) = self.get_free_queue()? {
                return Ok(free_queue);
            }
            std::hint::spin_loop();
        }
    }
}

impl Drop for MultiQueues {
    fn drop(&mut self) {
        unsafe {
            let _ = self.device.device_wait_idle();
            for pool in self.command_pools.iter().flatten() {
                self.device.destroy_command_pool(*pool, None);
            }
            self.device.destroy_device(None);
        }
    }
}

fn check_result_buffer(device: &Device, result_buffer: &BufferWithMemory<'_>) -> TestOutcome {
    let result_alloc = result_buffer.get_allocation();
    invalidate_alloc(device, result_alloc)?;

    let ptr = result_alloc.get_host_ptr().cast::<i32>();
    for ndx in 0..BUFFER_ELEMENT_COUNT {
        if unsafe { ptr.add(ndx).read_unaligned() } != ndx as i32 {
            return Ok(TestStatus::fail("The data don't match"));
        }
    }
    Ok(TestStatus::pass("Passed"))
}

/// `executeComputePipeline`
fn execute_compute_pipeline(
    pipeline: vk::Pipeline,
    pipeline_layout: vk::PipelineLayout,
    descriptor_set_layout: vk::DescriptorSetLayout,
    queues: &MultiQueues,
    shaders_executions: u32,
) -> TestOutcome {
    let free_queue = queues.acquire_queue()?;
    // The queue goes back before the result is looked at, and also when recording or submitting failed.
    let submitted = submit_compute_pipeline(
        pipeline,
        pipeline_layout,
        descriptor_set_layout,
        queues,
        &free_queue,
        shaders_executions,
    );
    queues.release_queue(free_queue);

    check_result_buffer(&queues.device, &submitted?)
}

fn submit_compute_pipeline<'a>(
    pipeline: vk::Pipeline,
    pipeline_layout: vk::PipelineLayout,
    descriptor_set_layout: vk::DescriptorSetLayout,
    queues: &'a MultiQueues,
    free_queue: &FreeQueue<'_>,
    shaders_executions: u32,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = &queues.device;
    let cmd_buffer = free_queue.cmd_buffer.get();

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let result_buffer = BufferWithMemory::new(
        device,
        &queues.allocator,
        make_buffer_create_info(BUFFER_SIZE, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        result_buffer.get(),
        0,
        BUFFER_SIZE,
    );

    {
        let alloc = result_buffer.get_allocation();
        unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, BUFFER_SIZE as usize) };
        flush_alloc(device, alloc)?;
    }

    // Start recording commands
    begin_command_buffer(device, cmd_buffer)?;

    unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::COMPUTE, pipeline) };

    // Create descriptor set
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, descriptor_set_layout)?;

    let result_descriptor_info = make_descriptor_buffer_info(result_buffer.get(), 0, BUFFER_SIZE);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &result_descriptor_info,
        )
        .update(device);

    unsafe {
        device.cmd_bind_descriptor_sets(
            cmd_buffer,
            vk::PipelineBindPoint::COMPUTE,
            pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );

        // Dispatch indirect compute command
        device.cmd_dispatch(cmd_buffer, shaders_executions, 1, 1);

        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    // End recording commands
    end_command_buffer(device, cmd_buffer)?;

    // Wait for command buffer execution finish
    submit_commands_and_wait(device, free_queue.queue, cmd_buffer)?;

    Ok(result_buffer)
}

/// `executeGraphicPipeline`
fn execute_graphic_pipeline(
    pipeline: vk::Pipeline,
    pipeline_layout: vk::PipelineLayout,
    descriptor_set_layout: vk::DescriptorSetLayout,
    queues: &MultiQueues,
    render_pass: vk::RenderPass,
    shaders_executions: u32,
) -> TestOutcome {
    let free_queue = queues.acquire_queue()?;
    let submitted = submit_graphic_pipeline(
        pipeline,
        pipeline_layout,
        descriptor_set_layout,
        queues,
        &free_queue,
        render_pass,
        shaders_executions,
    );
    queues.release_queue(free_queue);

    check_result_buffer(&queues.device, &submitted?)
}

#[allow(clippy::too_many_arguments)]
fn submit_graphic_pipeline<'a>(
    pipeline: vk::Pipeline,
    pipeline_layout: vk::PipelineLayout,
    descriptor_set_layout: vk::DescriptorSetLayout,
    queues: &'a MultiQueues,
    free_queue: &FreeQueue<'_>,
    render_pass: vk::RenderPass,
    shaders_executions: u32,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = &queues.device;
    let cmd_buffer = free_queue.cmd_buffer.get();

    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, descriptor_set_layout)?;
    let result_buffer = BufferWithMemory::new(
        device,
        &queues.allocator,
        make_buffer_create_info(BUFFER_SIZE, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let buffer_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        result_buffer.get(),
        0,
        BUFFER_SIZE,
    );
    let color_format = vk::Format::R8G8B8A8_UNORM;
    let color_image_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let color_attachment_image = ImageWithMemory::new(
        device,
        &queues.allocator,
        make_image_create_info(IVec2::new(1, 1), color_format, vk::ImageUsageFlags::COLOR_ATTACHMENT),
        MemoryRequirement::ANY,
    )?;
    let color_attachment_view = make_image_view(
        device,
        color_attachment_image.get(),
        vk::ImageViewType::_2D,
        color_format,
        color_image_subresource_range,
    )?;
    let framebuffer = make_framebuffer(device, render_pass, &[*color_attachment_view], 1, 1, 1)?;
    let output_buffer_descriptor_info = make_descriptor_buffer_info(result_buffer.get(), 0, BUFFER_SIZE);

    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &output_buffer_descriptor_info,
        )
        .update(device);

    {
        let alloc = result_buffer.get_allocation();
        unsafe { std::ptr::write_bytes(alloc.get_host_ptr(), 0, BUFFER_SIZE as usize) };
        flush_alloc(device, alloc)?;
    }

    // Start recording commands
    begin_command_buffer(device, cmd_buffer)?;
    // Change color attachment image layout
    {
        let color_attachment_layout_barrier = make_image_memory_barrier(
            vk::AccessFlags::empty(),
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            color_attachment_image.get(),
            color_image_subresource_range,
        );

        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TOP_OF_PIPE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[color_attachment_layout_barrier],
            );
        }
    }

    begin_render_pass(
        device,
        cmd_buffer,
        render_pass,
        *framebuffer,
        make_rect_2d(0, 0, 1, 1),
        clear_value_color([0.0, 0.0, 0.0, 1.0]),
    );

    unsafe {
        device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
        device.cmd_bind_descriptor_sets(
            cmd_buffer,
            vk::PipelineBindPoint::GRAPHICS,
            pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[] as &[u32],
        );

        device.cmd_draw(cmd_buffer, shaders_executions, 1, 0, 0);
        device.cmd_end_render_pass(cmd_buffer);

        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::VERTEX_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[buffer_barrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }

    // End recording commands
    end_command_buffer(device, cmd_buffer)?;

    // Wait for command buffer execution finish
    submit_commands_and_wait(device, free_queue.queue, cmd_buffer)?;

    Ok(result_buffer)
}

/// One `ThreadGroupThread::run`: the status of `runThread`, or of the error that ended it.
fn run_thread(thread_body: impl FnOnce() -> TestOutcome) -> TestStatus {
    match thread_body() {
        Ok(status) => status,
        Err(e) => e.to_status(),
    }
}

/// `ThreadGroup::run`: every thread's result folded into one.
fn run_thread_group<F>(num_threads: usize, make_thread: F) -> TestStatus
where
    F: Fn() -> TestStatus + Sync,
{
    let mut result_collector = ResultCollector::new("");

    let statuses: Vec<TestStatus> = std::thread::scope(|scope| {
        let handles: Vec<_> = (0..num_threads).map(|_| scope.spawn(&make_thread)).collect();
        handles
            .into_iter()
            .map(|handle| {
                handle
                    .join()
                    .unwrap_or_else(|_| TestStatus::new(TestResult::Fail, "Exception"))
            })
            .collect()
    });

    for status in statuses {
        result_collector.add_result(status.code(), status.description().to_string());
    }

    result_collector.to_status()
}

fn num_threads() -> usize {
    std::thread::available_parallelism().map_or(4, |n| n.get()).clamp(4, 32)
}

/// `PipelineCacheComputeTestInstance::iterate`
fn pipeline_cache_compute_iterate(context: &Context<'_>, shaders_executions: &[u32]) -> TestOutcome {
    let queues = MultiQueues::new(context, vk::QueueFlags::COMPUTE)?;
    let device = &queues.device;

    // addShaderModules
    let binaries = context.get_binary_collection();
    let mut shader_comp_modules = Vec::new();
    for shader_ndx in 0..shaders_executions.len() {
        shader_comp_modules.push(create_shader_module(
            device,
            binaries.get(&format!("compute_{shader_ndx}"))?,
        )?);
    }

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;
    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

    // addShaderStageInfo and addPipelineInfo
    let pipeline_info: Vec<vk::ComputePipelineCreateInfo> = shader_comp_modules
        .iter()
        .map(|module| {
            let stage_info = vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::COMPUTE)
                .module(**module)
                .name(b"main\0")
                .build();
            vk::ComputePipelineCreateInfo::builder()
                .stage(stage_info)
                .layout(*pipeline_layout)
                .base_pipeline_index(0)
                .build()
        })
        .collect();
    let pipeline_info = SharedReadOnly(pipeline_info);

    let pipeline_cache = Unique::new(
        device,
        unsafe { device.create_pipeline_cache(&vk::PipelineCacheCreateInfo::builder(), None) }
            .vk_check("vkCreatePipelineCache")?,
    );
    let pipeline = {
        let pipelines = unsafe { device.create_compute_pipelines(*pipeline_cache, &[pipeline_info.0[0]], None) }
            .vk_check("vkCreateComputePipelines")?;
        Unique::new(device, pipelines.0[0])
    };

    execute_compute_pipeline(
        *pipeline,
        *pipeline_layout,
        *descriptor_set_layout,
        &queues,
        shaders_executions[0],
    )?;

    let cache_handle = *pipeline_cache;
    let layout_handle = *pipeline_layout;
    let set_layout_handle = *descriptor_set_layout;
    let queues_ref = &queues;
    let pipeline_info_ref = &pipeline_info;

    // `CreateComputeThread::runThread`
    let thread_result = run_thread_group(num_threads(), || {
        run_thread(|| {
            let mut result_collector = ResultCollector::new("");
            for execution_ndx in 0..EXECUTION_PER_THREAD {
                let shader_ndx = execution_ndx % pipeline_info_ref.0.len();
                let device = &queues_ref.device;
                let created =
                    unsafe { device.create_compute_pipelines(cache_handle, &[pipeline_info_ref.0[shader_ndx]], None) }
                        .vk_check("vkCreateComputePipelines")?;
                let pipeline = Unique::new(device, created.0[0]);

                let result = execute_compute_pipeline(
                    *pipeline,
                    layout_handle,
                    set_layout_handle,
                    queues_ref,
                    shaders_executions[shader_ndx],
                )?;
                result_collector.add_result(result.code(), result.description().to_string());
            }
            Ok(result_collector.to_status())
        })
    });

    if thread_result.code() != TestResult::Pass {
        return Ok(thread_result);
    }
    Ok(TestStatus::pass("Passed"))
}

/// `PipelineCacheGraphicTestInstance::iterate`
fn pipeline_cache_graphic_iterate(context: &Context<'_>, shaders_executions: &[u32]) -> TestOutcome {
    let queues = MultiQueues::new(context, vk::QueueFlags::GRAPHICS)?;
    let device = &queues.device;

    let color_format = vk::Format::R8G8B8A8_UNORM;
    let render_pass = make_render_pass(device, color_format)?;
    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::VERTEX)
        .build(device)?;

    // addShaderModules
    let binaries = context.get_binary_collection();
    let mut vert_modules = Vec::new();
    for shader_ndx in 0..shaders_executions.len() {
        vert_modules.push(create_shader_module(
            device,
            binaries.get(&format!("vert_{shader_ndx}"))?,
        )?);
    }
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;

    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

    // addShaderStageInfo: a vertex and a fragment stage per shader
    let mut shader_stage_infos = Vec::new();
    for module in &vert_modules {
        shader_stage_infos.push(
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(**module)
                .name(b"main\0")
                .build(),
        );
        shader_stage_infos.push(
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(b"main\0")
                .build(),
        );
    }

    // addPipelineInfo
    let color_image_extent = vk::Extent3D {
        width: 1,
        height: 1,
        depth: 1,
    };
    let vertex_input_state_params = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly_state_params = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::POINT_LIST)
        .primitive_restart_enable(false);
    let viewports = [vk::Viewport {
        x: 0.0,
        y: 0.0,
        width: color_image_extent.width as f32,
        height: color_image_extent.height as f32,
        min_depth: 0.0,
        max_depth: 1.0,
    }];
    let scissors = [make_rect_2d(0, 0, color_image_extent.width, color_image_extent.height)];
    let viewport_state_params = vk::PipelineViewportStateCreateInfo::builder()
        .viewports(&viewports)
        .scissors(&scissors);
    let raster_state_params = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(false)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);
    let color_blend_attachment_states = [vk::PipelineColorBlendAttachmentState {
        blend_enable: vk::FALSE,
        src_color_blend_factor: vk::BlendFactor::ONE,
        dst_color_blend_factor: vk::BlendFactor::ZERO,
        color_blend_op: vk::BlendOp::ADD,
        src_alpha_blend_factor: vk::BlendFactor::ONE,
        dst_alpha_blend_factor: vk::BlendFactor::ZERO,
        alpha_blend_op: vk::BlendOp::ADD,
        color_write_mask: vk::ColorComponentFlags::R
            | vk::ColorComponentFlags::G
            | vk::ColorComponentFlags::B
            | vk::ColorComponentFlags::A,
    }];
    let color_blend_state_params = vk::PipelineColorBlendStateCreateInfo::builder()
        .logic_op_enable(false)
        .logic_op(vk::LogicOp::COPY)
        .attachments(&color_blend_attachment_states)
        .blend_constants([0.0; 4]);
    let multisample_state_params = vk::PipelineMultisampleStateCreateInfo::builder()
        .rasterization_samples(vk::SampleCountFlags::_1)
        .sample_shading_enable(false)
        .min_sample_shading(0.0);
    let keep_never = vk::StencilOpState {
        fail_op: vk::StencilOp::KEEP,
        pass_op: vk::StencilOp::KEEP,
        depth_fail_op: vk::StencilOp::KEEP,
        compare_op: vk::CompareOp::NEVER,
        compare_mask: 0,
        write_mask: 0,
        reference: 0,
    };
    let depth_stencil_state_params = vk::PipelineDepthStencilStateCreateInfo::builder()
        .depth_test_enable(true)
        .depth_write_enable(true)
        .depth_compare_op(vk::CompareOp::LESS_OR_EQUAL)
        .depth_bounds_test_enable(false)
        .stencil_test_enable(false)
        .front(keep_never)
        .back(keep_never)
        .min_depth_bounds(0.0)
        .max_depth_bounds(1.0);

    let pipeline_info: Vec<vk::GraphicsPipelineCreateInfo> = (0..shaders_executions.len())
        .map(|shader_ndx| {
            let mut info = vk::GraphicsPipelineCreateInfo::default();
            info.stage_count = 2;
            info.stages = shader_stage_infos[shader_ndx * 2..].as_ptr();
            info.vertex_input_state = &*vertex_input_state_params;
            info.input_assembly_state = &*input_assembly_state_params;
            info.viewport_state = &*viewport_state_params;
            info.rasterization_state = &*raster_state_params;
            info.multisample_state = &*multisample_state_params;
            info.depth_stencil_state = &*depth_stencil_state_params;
            info.color_blend_state = &*color_blend_state_params;
            info.layout = *pipeline_layout;
            info.render_pass = *render_pass;
            info.subpass = 0;
            info.base_pipeline_handle = vk::Pipeline::null();
            info.base_pipeline_index = 0;
            info
        })
        .collect();
    let pipeline_info = SharedReadOnly(pipeline_info);

    let pipeline_cache = Unique::new(
        device,
        unsafe { device.create_pipeline_cache(&vk::PipelineCacheCreateInfo::builder(), None) }
            .vk_check("vkCreatePipelineCache")?,
    );
    let pipeline = {
        let pipelines = unsafe { device.create_graphics_pipelines(*pipeline_cache, &[pipeline_info.0[0]], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Unique::new(device, pipelines.0[0])
    };

    execute_graphic_pipeline(
        *pipeline,
        *pipeline_layout,
        *descriptor_set_layout,
        &queues,
        *render_pass,
        shaders_executions[0],
    )?;

    let cache_handle = *pipeline_cache;
    let layout_handle = *pipeline_layout;
    let set_layout_handle = *descriptor_set_layout;
    let render_pass_handle = *render_pass;
    let queues_ref = &queues;
    let pipeline_info_ref = &pipeline_info;

    // `CreateGraphicThread::runThread`
    let thread_result = run_thread_group(num_threads(), || {
        run_thread(|| {
            let mut result_collector = ResultCollector::new("");
            for execution_ndx in 0..EXECUTION_PER_THREAD {
                let shader_ndx = execution_ndx % pipeline_info_ref.0.len();
                let device = &queues_ref.device;
                let created =
                    unsafe { device.create_graphics_pipelines(cache_handle, &[pipeline_info_ref.0[shader_ndx]], None) }
                        .vk_check("vkCreateGraphicsPipelines")?;
                let pipeline = Unique::new(device, created.0[0]);

                let result = execute_graphic_pipeline(
                    *pipeline,
                    layout_handle,
                    set_layout_handle,
                    queues_ref,
                    render_pass_handle,
                    shaders_executions[shader_ndx],
                )?;
                result_collector.add_result(result.code(), result.description().to_string());
            }
            Ok(result_collector.to_status())
        })
    });

    if thread_result.code() != TestResult::Pass {
        return Ok(thread_result);
    }
    Ok(TestStatus::pass("Passed"))
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Kind {
    Compute,
    Graphics,
}

struct PipelineCacheTest {
    name: &'static str,
    kind: Kind,
}

impl TestCase for PipelineCacheTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let queue_flag = match self.kind {
            Kind::Compute => vk::QueueFlags::COMPUTE,
            Kind::Graphics => {
                if context.get_device_features().vertex_pipeline_stores_and_atomics == vk::FALSE {
                    return Err(TestError::NotSupported(
                        "Requested feature is not supported: vertexPipelineStoresAndAtomics".to_string(),
                    ));
                }
                vk::QueueFlags::GRAPHICS
            }
        };

        // make sure there is a queue family that supports the requested queue flags
        let queue_family_properties = unsafe {
            context
                .get_instance()
                .get_physical_device_queue_family_properties(context.get_physical_device())
        };
        if queue_family_properties
            .iter()
            .any(|queue| check_queue_flags(queue.queue_flags, queue_flag))
        {
            Ok(())
        } else {
            Err(TestError::NotSupported("Queue not found".to_string()))
        }
    }

    fn programs(&self) -> BinaryCollection {
        match self.kind {
            Kind::Compute => PIPELINE_CACHE_COMPUTE.programs,
            Kind::Graphics => PIPELINE_CACHE_GRAPHICS.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PipelineCacheInstance {
            context,
            kind: self.kind,
        })
    }
}

struct PipelineCacheInstance<'a> {
    context: &'a Context<'a>,
    kind: Kind,
}

impl TestInstance for PipelineCacheInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        // shadersExecutions: compute_0 / vert_0, compute_1 / vert_1, compute_2 / vert_2
        let shaders_executions = [16u32, 1, 1];
        match self.kind {
            Kind::Compute => pipeline_cache_compute_iterate(self.context, &shaders_executions),
            Kind::Graphics => pipeline_cache_graphic_iterate(self.context, &shaders_executions),
        }
    }
}

/// `createInternallySynchronizedObjects`
pub fn create_internally_synchronized_objects_tests() -> TestCaseGroup {
    // Internally synchronized objects
    let mut tests = TestCaseGroup::new("internally_synchronized_objects");
    // Internally synchronized object VkPipelineCache for compute pipeline is tested
    tests.add_child(Box::new(PipelineCacheTest {
        name: "pipeline_cache_compute",
        kind: Kind::Compute,
    }) as Box<dyn TestCase>);
    // Internally synchronized object VkPipelineCache for graphics pipeline is tested
    tests.add_child(Box::new(PipelineCacheTest {
        name: "pipeline_cache_graphics",
        kind: Kind::Graphics,
    }) as Box<dyn TestCase>);
    tests
}
