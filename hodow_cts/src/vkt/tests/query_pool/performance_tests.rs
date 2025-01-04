// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolPerformanceTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2019 The Khronos Group Inc.
// Copyright (c) 2019 Valve Corporation.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The draw-library objects `Draw::Image`/`Draw::Buffer` and `PipelineCreateInfo` become the
// port's own `ImageWithMemory`, `create_host_buffer` and `DrawPipelineState`. `TCU_THROW(QualityWarning, ...)` from `checkSupport` has no
// `TestError` form, so that check is made at the start of the instance and reports the same status.
//
// `performance_query`: VK_KHR_performance_query counters enumerate, and queries around a draw and a dispatch.

use std::collections::BTreeMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    InstanceV1_1, KhrPerformanceQueryExtensionDeviceCommands, KhrPerformanceQueryExtensionInstanceCommands,
};

use crate::generated::shaders::query_pool_performance::{PERFORMANCE_COMPUTE, PERFORMANCE_GRAPHIC};
use crate::tcu::{Random, TestError, TestOutcome, TestResult, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `uuidToHex`
fn uuid_to_hex(uuid: &[u8]) -> String {
    const BYTES_PER_PART: [usize; 5] = [4, 2, 2, 2, 6];
    let mut result = String::new();
    let mut ptr = 0;

    for (part_ndx, &bytes_in_part) in BYTES_PER_PART.iter().enumerate() {
        let mut part: u64 = 0;
        for _ in 0..bytes_in_part {
            part = (part << 8) | uuid[ptr] as u64;
            ptr += 1;
        }

        result += &format!("{:0width$x}", part, width = 2 * bytes_in_part);

        if part_ndx + 1 != BYTES_PER_PART.len() {
            result.push('-');
        }
    }

    result
}

/// `ProfilingLockGuard`: the profiling lock is released even if the test returns early.
struct ProfilingLockGuard<'a> {
    device: &'a Device,
}

impl<'a> ProfilingLockGuard<'a> {
    fn new(device: &'a Device) -> Result<Self, TestError> {
        // Must always succeed.
        let lock_info = vk::AcquireProfilingLockInfoKHR::builder()
            .flags(vk::AcquireProfilingLockFlagsKHR::empty())
            .timeout(u64::MAX);
        unsafe { device.acquire_profiling_lock_khr(&lock_info) }.vk_check("vkAcquireProfilingLockKHR")?;
        Ok(Self { device })
    }
}

impl Drop for ProfilingLockGuard<'_> {
    fn drop(&mut self) {
        unsafe { self.device.release_profiling_lock_khr() };
    }
}

fn check_call(result: vk::Result, what: &str) -> Result<(), TestError> {
    if result == vk::Result::SUCCESS {
        Ok(())
    } else {
        Err(TestError::Fail(format!("{what} returned {result:?}")))
    }
}

/// The raw call: a null pointer stands for "not requested", which the safe wrapper cannot express.
fn enumerate_counters_raw(
    context: &Context<'_>,
    queue_family_index: u32,
    count: &mut u32,
    counters: *mut vk::PerformanceCounterKHR,
    descriptions: *mut vk::PerformanceCounterDescriptionKHR,
) -> vk::Result {
    let command = context
        .get_instance()
        .commands()
        .enumerate_physical_device_queue_family_performance_query_counters_khr;
    unsafe {
        command(
            context.get_physical_device(),
            queue_family_index,
            count,
            counters,
            descriptions,
        )
    }
}

/// `EnumerateAndValidateTest::iterate`
fn enumerate_and_validate(context: &Context<'_>, queue_flag_bits: vk::QueueFlags) -> TestOutcome {
    let queue_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };

    for (queue_ndx, properties) in queue_properties.iter().enumerate() {
        let queue_ndx = queue_ndx as u32;
        if !properties.queue_flags.intersects(queue_flag_bits) {
            continue;
        }

        let mut counter_count = 0u32;
        check_call(
            enumerate_counters_raw(
                context,
                queue_ndx,
                &mut counter_count,
                std::ptr::null_mut(),
                std::ptr::null_mut(),
            ),
            "vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR",
        )?;

        if counter_count == 0 {
            continue;
        }

        {
            let mut counters = vec![vk::PerformanceCounterKHR::default(); counter_count as usize];
            let mut counter_count_read = counter_count;
            let mut uuid_validator: BTreeMap<String, usize> = BTreeMap::new();

            if counter_count > 1 {
                let mut incomplete_counter_count = counter_count - 1;
                let result = enumerate_counters_raw(
                    context,
                    queue_ndx,
                    &mut incomplete_counter_count,
                    counters.as_mut_ptr(),
                    std::ptr::null_mut(),
                );
                if result != vk::Result::INCOMPLETE {
                    return Err(TestError::Fail("VK_INCOMPLETE not returned".to_string()));
                }
            }

            check_call(
                enumerate_counters_raw(
                    context,
                    queue_ndx,
                    &mut counter_count_read,
                    counters.as_mut_ptr(),
                    std::ptr::null_mut(),
                ),
                "vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR",
            )?;

            if counter_count_read != counter_count {
                return Err(TestError::Fail(format!(
                    "Number of counters read ({counter_count_read}) is not equal to number of counters reported ({counter_count})"
                )));
            }

            for (counter_ndx, counter) in counters.iter().enumerate() {
                let uuid_str = uuid_to_hex(&counter.uuid[..]);

                if uuid_validator.contains_key(&uuid_str) {
                    return Err(TestError::Fail(format!("Duplicate counter UUID detected {uuid_str}")));
                }
                uuid_validator.insert(uuid_str, counter_ndx);

                // VK_PERFORMANCE_COUNTER_SCOPE_KHR_LAST, _STORAGE_KHR_LAST and _UNIT_KHR_LAST
                if counter.scope.as_raw() >= 3 {
                    return Err(TestError::Fail(format!(
                        "Counter scope is invalid {}",
                        counter.scope.as_raw()
                    )));
                }

                if counter.storage.as_raw() >= 6 {
                    return Err(TestError::Fail(format!(
                        "Counter storage is invalid {}",
                        counter.storage.as_raw()
                    )));
                }

                if counter.unit.as_raw() >= 11 {
                    return Err(TestError::Fail(format!(
                        "Counter unit is invalid {}",
                        counter.unit.as_raw()
                    )));
                }
            }
        }
        {
            let mut counter_descriptors = vec![vk::PerformanceCounterDescriptionKHR::default(); counter_count as usize];
            let mut counter_count_read = counter_count;

            check_call(
                enumerate_counters_raw(
                    context,
                    queue_ndx,
                    &mut counter_count_read,
                    std::ptr::null_mut(),
                    counter_descriptors.as_mut_ptr(),
                ),
                "vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR",
            )?;

            if counter_count_read != counter_count {
                return Err(TestError::Fail(format!(
                    "Number of counters read ({counter_count_read}) is not equal to number of counters reported ({counter_count})"
                )));
            }

            let allowed_flags = (vk::PerformanceCounterDescriptionFlagsKHR::PERFORMANCE_IMPACTING
                | vk::PerformanceCounterDescriptionFlagsKHR::CONCURRENTLY_IMPACTED)
                .bits();
            for counter_descriptor in &counter_descriptors {
                if (counter_descriptor.flags.bits() & !allowed_flags) != 0 {
                    return Err(TestError::Fail(
                        "Invalid flags present in VkPerformanceCounterDescriptionFlagsKHR".to_string(),
                    ));
                }
            }
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `QueryTestBase`
struct QueryTestBase<'a> {
    context: &'a Context<'a>,
    copy_results: bool,
    seed: u32,
    required_number_of_passes: u32,
    /// Counters provided by the device.
    counters: Vec<vk::PerformanceCounterKHR>,
}

/// A performance query pool and the number of counters that were enabled for it.
struct PerformancePool<'a> {
    pool: Unique<'a, vk::QueryPool>,
    enabled_counters_count: u32,
}

impl<'a> QueryTestBase<'a> {
    fn new(context: &'a Context<'a>, copy_results: bool, seed: u32) -> Self {
        Self {
            context,
            copy_results,
            seed,
            required_number_of_passes: 0,
            counters: Vec::new(),
        }
    }

    /// `QueryTestBase::setupCounters`
    fn setup_counters(&mut self) -> Result<(), TestError> {
        let context = self.context;
        let (counters, _descriptions) = unsafe {
            context
                .get_instance()
                .enumerate_physical_device_queue_family_performance_query_counters_khr(
                    context.get_physical_device(),
                    context.get_universal_queue_family_index(),
                )
        }
        .vk_check("vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR")?;

        // Filter out all counters with scope VK_PERFORMANCE_COUNTER_SCOPE_COMMAND_BUFFER_KHR. For these counters, the begin and end
        // command must be at the beginning/end of the command buffer, which does not match what these tests do.
        self.counters = counters
            .into_iter()
            .filter(|counter| counter.scope != vk::PerformanceCounterScopeKHR::COMMAND_BUFFER)
            .collect();
        Ok(())
    }

    /// `QueryTestBase::createQueryPool`
    fn create_query_pool(
        &mut self,
        enabled_counter_offset: u32,
        enabled_counter_stride: u32,
    ) -> Result<PerformancePool<'a>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let counter_count = self.counters.len() as u32;
        let mut enabled_counter_offset = enabled_counter_offset;
        let mut enabled_index = if enabled_counter_offset != 0 {
            0
        } else {
            enabled_counter_stride
        };
        let mut enabled_counters: Vec<u32> = Vec::new();

        // enable every <enabledCounterStride> counter that has command or render pass scope
        for i in 0..counter_count {
            // handle offset
            if enabled_counter_offset != 0 {
                if enabled_counter_offset == enabled_index {
                    // disable handling offset
                    enabled_counter_offset = 0;

                    // eneble next index in stride condition
                    enabled_index = enabled_counter_stride;
                } else {
                    enabled_index += 1;
                    continue;
                }
            }

            // handle stride
            if enabled_index == enabled_counter_stride {
                enabled_counters.push(i);
                enabled_index = 0;
            } else {
                enabled_index += 1;
            }
        }

        // Get number of counters that were enabled for this query pool.
        if enabled_counters.is_empty() {
            return Err(TestError::NotSupported(
                "No suitable performance counters found for this test".to_string(),
            ));
        }

        let enabled_counters_count = enabled_counters.len() as u32;

        // define performance query
        let mut performance_query_create_info = vk::QueryPoolPerformanceCreateInfoKHR::builder()
            .queue_family_index(queue_family_index)
            .counter_indices(&enabled_counters);

        // get the number of passes counters will require
        self.required_number_of_passes = unsafe {
            context
                .get_instance()
                .get_physical_device_queue_family_performance_query_passes_khr(
                    context.get_physical_device(),
                    &performance_query_create_info,
                )
        };

        // create query pool
        let query_pool_create_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::PERFORMANCE_QUERY_KHR)
            .query_count(1)
            .push_next(&mut performance_query_create_info);
        let pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_create_info, None) }.vk_check("vkCreateQueryPool")?,
        );

        Ok(PerformancePool {
            pool,
            enabled_counters_count,
        })
    }

    /// `QueryTestBase::createResultsVector`: random non-zero bytes, one `VkPerformanceCounterResultKHR` per enabled counter.
    fn create_results_vector(&self, pool: &PerformancePool<'_>) -> Vec<u8> {
        let mut results =
            vec![0u8; pool.enabled_counters_count as usize * std::mem::size_of::<vk::PerformanceCounterResultKHR>()];
        let mut rnd = Random::new(self.seed);

        // Fill vector with random bytes.
        for byte in results.iter_mut() {
            *byte = rnd.get_int(1, 255) as u8; // Do not use zeros.
        }

        results
    }

    /// `QueryTestBase::createResultsBuffer`
    fn create_results_buffer(&self, results_vector: &[u8]) -> Result<BufferWithMemory<'a>, TestError> {
        let context = self.context;
        let device = context.get_device();
        let buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                results_vector.len() as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                results_vector.as_ptr(),
                buffer.get_allocation().get_host_ptr(),
                results_vector.len(),
            )
        };
        flush_alloc(device, buffer.get_allocation())?;
        Ok(buffer)
    }

    /// `QueryTestBase::verifyQueryResults`
    fn verify_query_results(
        &self,
        qf_index: u32,
        queue: vk::Queue,
        pool: &PerformancePool<'_>,
    ) -> Result<(), TestError> {
        let context = self.context;
        let device = context.get_device();

        let initial_vector = self.create_results_vector(pool);
        let results_buffer = self.create_results_buffer(&initial_vector)?;
        let results_buffer_data = results_buffer.get_allocation().get_host_ptr();

        let results_stride = initial_vector.len() as vk::DeviceSize;
        let host_buffer_size = initial_vector.len();
        let result_flags = vk::QueryResultFlags::WAIT;

        // Get or copy query pool results.
        if self.copy_results {
            let cmd_pool = make_command_pool(device, qf_index)?;
            let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
            let cmd = *cmd_buffer;
            let barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);

            begin_command_buffer(device, cmd)?;
            unsafe {
                device.cmd_copy_query_pool_results(
                    cmd,
                    pool.pool.get(),
                    0,
                    1,
                    results_buffer.get(),
                    0,
                    results_stride,
                    result_flags,
                );
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(device, cmd)?;
            crate::vk::cmd_util::submit_commands_and_wait(device, queue, cmd)?;
            invalidate_alloc(device, results_buffer.get_allocation())?;
        } else {
            let mut bytes = vec![0u8; host_buffer_size];
            unsafe { device.get_query_pool_results(pool.pool.get(), 0, 1, &mut bytes, results_stride, result_flags) }
                .vk_check("vkGetQueryPoolResults")?;
            unsafe { std::ptr::copy_nonoverlapping(bytes.as_ptr(), results_buffer_data, host_buffer_size) };
        }

        // Check that the buffer was modified without analyzing result semantics.
        let results_vector = unsafe { std::slice::from_raw_parts(results_buffer_data, host_buffer_size) }.to_vec();
        let item_size = std::mem::size_of::<vk::PerformanceCounterResultKHR>();

        for (i, (initial, result)) in initial_vector
            .chunks(item_size)
            .zip(results_vector.chunks(item_size))
            .enumerate()
        {
            if initial == result {
                return Err(TestError::Fail(format!(
                    "Result {i} was not modified by the implementation"
                )));
            }
        }

        Ok(())
    }
}

/// Submits `submit_info` and waits for its fence, as the queries' passes and resets do.
fn submit_and_wait(
    device: &Device,
    queue: vk::Queue,
    cmd: vk::CommandBuffer,
    pass_index: Option<u32>,
) -> Result<(), TestError> {
    let fence = Unique::new(
        device,
        unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?,
    );
    let command_buffers = [cmd];
    let mut performance_query_submit_info =
        vk::PerformanceQuerySubmitInfoKHR::builder().counter_pass_index(pass_index.unwrap_or(0));
    let mut submit_info = vk::SubmitInfo::builder().command_buffers(&command_buffers);
    if pass_index.is_some() {
        submit_info = submit_info.push_next(&mut performance_query_submit_info);
    }

    unsafe { device.queue_submit(queue, &[submit_info], fence.get()) }.vk_check("vkQueueSubmit")?;
    unsafe { device.wait_for_fences(&[fence.get()], true, u64::MAX) }.vk_check("vkWaitForFences")?;
    Ok(())
}

fn transition_image(
    device: &Device,
    cmd: vk::CommandBuffer,
    image: vk::Image,
    old_layout: vk::ImageLayout,
    new_layout: vk::ImageLayout,
    src_access: vk::AccessFlags,
    dst_access: vk::AccessFlags,
    src_stage: vk::PipelineStageFlags,
    dst_stage: vk::PipelineStageFlags,
) {
    let barrier = make_image_memory_barrier(
        src_access,
        dst_access,
        old_layout,
        new_layout,
        image,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd,
            src_stage,
            dst_stage,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

/// `GraphicQueryTestBase::initStateObjects`
struct GraphicState<'a> {
    color_attachment_image: ImageWithMemory<'a>,
    _attachment_view: Unique<'a, vk::ImageView>,
    render_pass: Unique<'a, vk::RenderPass>,
    framebuffer: Unique<'a, vk::Framebuffer>,
    pipeline: Unique<'a, vk::Pipeline>,
    _pipeline_layout: Unique<'a, vk::PipelineLayout>,
    vertex_buffer: BufferWithMemory<'a>,
}

const GRAPHIC_SIZE: u32 = 32;
const COLOR_ATTACHMENT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

fn init_graphic_state<'a>(context: &'a Context<'a>) -> Result<GraphicState<'a>, TestError> {
    let device = context.get_device();

    //attachment images and views
    let color_image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(COLOR_ATTACHMENT_FORMAT)
        .extent(vk::Extent3D {
            width: GRAPHIC_SIZE,
            height: GRAPHIC_SIZE,
            depth: 1,
        })
        .mip_levels(1)
        .array_layers(1)
        .samples(vk::SampleCountFlags::_1)
        .tiling(vk::ImageTiling::OPTIMAL)
        .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
        .sharing_mode(vk::SharingMode::EXCLUSIVE)
        .initial_layout(vk::ImageLayout::UNDEFINED)
        .build();
    let color_attachment_image = ImageWithMemory::new(
        device,
        context.get_default_allocator(),
        color_image_info,
        MemoryRequirement::ANY,
    )?;
    let attachment_view = make_image_view(
        device,
        color_attachment_image.get(),
        vk::ImageViewType::_2D,
        COLOR_ATTACHMENT_FORMAT,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;

    // renderpass and framebuffer
    let attachments = [vk::AttachmentDescription::builder()
        .format(COLOR_ATTACHMENT_FORMAT)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::DONT_CARE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(vk::ImageLayout::GENERAL)
        .final_layout(vk::ImageLayout::GENERAL)
        .build()];
    let color_attachment_reference = [vk::AttachmentReference {
        attachment: 0,
        layout: vk::ImageLayout::GENERAL,
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_attachment_reference)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    let render_pass = Unique::new(
        device,
        unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );
    let framebuffer = make_framebuffer(device, *render_pass, &[*attachment_view], GRAPHIC_SIZE, GRAPHIC_SIZE, 1)?;

    // pipeline
    let binaries = context.get_binary_collection();
    let vs = create_shader_module(device, binaries.get("vert")?)?;
    let fs = create_shader_module(device, binaries.get("frag")?)?;
    let pipeline_layout = make_pipeline_layout(device, &[])?;
    let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
        .with_position_input()
        .with_full_viewport(GRAPHIC_SIZE, GRAPHIC_SIZE);
    state.depth_stencil.depth_compare_op = vk::CompareOp::GREATER_OR_EQUAL;
    let pipeline = create_draw_pipeline(
        device,
        *pipeline_layout,
        *render_pass,
        &[
            (vk::ShaderStageFlags::VERTEX, *vs),
            (vk::ShaderStageFlags::FRAGMENT, *fs),
        ],
        &state,
    )?;

    // vertex buffer
    let vertices: [[f32; 4]; 3] = [[0.5, 0.5, 0.0, 1.0], [0.5, 0.0, 0.0, 1.0], [0.0, 0.5, 0.0, 1.0]];
    let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

    Ok(GraphicState {
        color_attachment_image,
        _attachment_view: attachment_view,
        render_pass,
        framebuffer,
        pipeline,
        _pipeline_layout: pipeline_layout,
        vertex_buffer,
    })
}

/// Resets the pools in a command buffer of their own and waits for it, as both graphics tests do.
fn reset_pools(
    device: &Device,
    queue: vk::Queue,
    cmd_pool: vk::CommandPool,
    pools: &[vk::QueryPool],
) -> Result<(), TestError> {
    let reset_cmd_buffer = allocate_command_buffer(device, cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *reset_cmd_buffer)?;
    for &pool in pools {
        unsafe { device.cmd_reset_query_pool(*reset_cmd_buffer, pool, 0, 1) };
    }
    end_command_buffer(device, *reset_cmd_buffer)?;
    submit_and_wait(device, queue, *reset_cmd_buffer, None)
}

/// Records the draw of `GraphicQueryTest`/`GraphicMultiplePoolsTest`, one query around the render pass per pool.
fn record_graphic_commands(
    device: &Device,
    cmd: vk::CommandBuffer,
    state: &GraphicState<'_>,
    pools: &[vk::QueryPool],
) -> Result<(), TestError> {
    begin_command_buffer(device, cmd)?;

    transition_image(
        device,
        cmd,
        state.color_attachment_image.get(),
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::GENERAL,
        vk::AccessFlags::empty(),
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::PipelineStageFlags::TOP_OF_PIPE,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
    );

    // begin render pass
    let render_pass_clear_value = [vk::ClearValue {
        color: vk::ClearColorValue { float32: [0.0; 4] },
    }];
    let vertex_buffer_offset = 0;
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*state.render_pass)
        .framebuffer(*state.framebuffer)
        .render_area(rect_2d(GRAPHIC_SIZE, GRAPHIC_SIZE))
        .clear_values(&render_pass_clear_value);

    for &pool in pools {
        // perform query during triangle draw
        unsafe {
            device.cmd_begin_query(cmd, pool, 0, vk::QueryControlFlags::empty());
            device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);

            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, state.pipeline.get());
            device.cmd_bind_vertex_buffers(cmd, 0, &[state.vertex_buffer.get()], &[vertex_buffer_offset]);
            device.cmd_draw(cmd, 3, 1, 0, 0);

            device.cmd_end_render_pass(cmd);
            device.cmd_end_query(cmd, pool, 0);
        }
    }

    transition_image(
        device,
        cmd,
        state.color_attachment_image.get(),
        vk::ImageLayout::GENERAL,
        vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
        vk::PipelineStageFlags::TRANSFER,
    );

    end_command_buffer(device, cmd)
}

/// `GraphicQueryTest::iterate` and `GraphicMultiplePoolsTest::iterate`: `pool_count` is 1 or 2.
fn run_graphic(context: &Context<'_>, copy_results: bool, seed: u32, pool_count: usize) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let qf_index = context.get_universal_queue_family_index();
    let cmd_pool = make_command_pool(device, qf_index)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let state = init_graphic_state(context)?;
    let mut base = QueryTestBase::new(context, copy_results, seed);
    base.setup_counters()?;

    let mut pools = Vec::new();
    if pool_count == 1 {
        pools.push(base.create_query_pool(0, 1)?);
    } else {
        pools.push(base.create_query_pool(0, 2)?);
        pools.push(base.create_query_pool(1, 2)?);
    }
    let pool_handles: Vec<vk::QueryPool> = pools.iter().map(|pool| pool.pool.get()).collect();

    {
        let _guard = ProfilingLockGuard::new(device)?;

        // reset query pools
        reset_pools(device, queue, *cmd_pool, &pool_handles)?;

        // begin command buffer and record the draws
        record_graphic_commands(device, cmd, &state, &pool_handles)?;

        // submit command buffer for each pass and wait for its completion
        for pass_index in 0..base.required_number_of_passes {
            submit_and_wait(device, queue, cmd, Some(pass_index))?;
        }
    }

    unsafe { device.reset_command_buffer(cmd, vk::CommandBufferResetFlags::empty()) }
        .vk_check("vkResetCommandBuffer")?;

    for pool in &pools {
        base.verify_query_results(qf_index, queue, pool)?;
    }
    Ok(TestStatus::pass("Pass"))
}

/// `ComputeQueryTestBase::initStateObjects`
struct ComputeState<'a> {
    pipeline: Unique<'a, vk::Pipeline>,
    pipeline_layout: Unique<'a, vk::PipelineLayout>,
    buffer: BufferWithMemory<'a>,
    _descriptor_set_layout: Unique<'a, vk::DescriptorSetLayout>,
    descriptor_set: crate::vk::ref_util::UniqueDescriptorSet<'a>,
    _descriptor_pool: Unique<'a, vk::DescriptorPool>,
    compute_finish_barrier: vk::BufferMemoryBarrier,
}

fn init_compute_state<'a>(context: &'a Context<'a>) -> Result<ComputeState<'a>, TestError> {
    let device = context.get_device();
    let buffer_size = (32 * std::mem::size_of::<u32>()) as vk::DeviceSize;

    let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(device)?;

    // create pipeline layout
    let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

    // create compute pipeline
    let cs = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*cs)
        .name(b"main\0")
        .build();
    let pipeline_create_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(*pipeline_layout)
        .base_pipeline_index(0)
        .build();
    let pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_create_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );

    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

    let descriptor_info = [vk::DescriptorBufferInfo {
        buffer: buffer.get(),
        offset: 0,
        range: buffer_size,
    }];
    let write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set.get())
        .dst_binding(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&descriptor_info)
        .build();
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    // clear buffer
    let data = vec![0u8; buffer_size as usize];
    invalidate_alloc(device, buffer.get_allocation())?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            data.as_ptr(),
            buffer.get_allocation().get_host_ptr(),
            buffer_size as usize,
        )
    };

    let compute_finish_barrier = make_buffer_memory_barrier(
        vk::AccessFlags::SHADER_READ | vk::AccessFlags::SHADER_WRITE,
        vk::AccessFlags::HOST_READ,
        buffer.get(),
        0,
        buffer_size,
    );

    Ok(ComputeState {
        pipeline,
        pipeline_layout,
        buffer,
        _descriptor_set_layout: descriptor_set_layout,
        _descriptor_pool: descriptor_pool,
        descriptor_set,
        compute_finish_barrier,
    })
}

/// `ComputeQueryTest::iterate` and `ComputeMultiplePoolsTest::iterate`: `pool_count` is 1 or 2.
fn run_compute(context: &Context<'_>, copy_results: bool, seed: u32, pool_count: usize) -> TestOutcome {
    let device = context.get_device();
    let queue = context.get_universal_queue();
    let qf_index = context.get_universal_queue_family_index();
    let cmd_pool = make_command_pool(device, qf_index)?;
    let reset_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let cmd = *cmd_buffer;

    let state = init_compute_state(context)?;
    let mut base = QueryTestBase::new(context, copy_results, seed);
    base.setup_counters()?;

    let mut pools = Vec::new();
    if pool_count == 1 {
        pools.push(base.create_query_pool(0, 1)?);
    } else {
        pools.push(base.create_query_pool(0, 2)?);
        pools.push(base.create_query_pool(1, 2)?);
    }
    let pool_handles: Vec<vk::QueryPool> = pools.iter().map(|pool| pool.pool.get()).collect();

    {
        let _guard = ProfilingLockGuard::new(device)?;

        begin_command_buffer(device, *reset_cmd_buffer)?;
        for &pool in &pool_handles {
            unsafe { device.cmd_reset_query_pool(*reset_cmd_buffer, pool, 0, 1) };
        }
        end_command_buffer(device, *reset_cmd_buffer)?;

        begin_command_buffer(device, cmd)?;
        unsafe {
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, state.pipeline.get());
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::COMPUTE,
                *state.pipeline_layout,
                0,
                &[state.descriptor_set.get()],
                &[] as &[u32],
            );

            // perform the queries
            for &pool in &pool_handles {
                device.cmd_begin_query(cmd, pool, 0, vk::QueryControlFlags::empty());
                device.cmd_dispatch(cmd, 2, 2, 2);
                device.cmd_end_query(cmd, pool, 0);
            }

            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[state.compute_finish_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;

        // submit reset of queries only once
        {
            let command_buffers = [*reset_cmd_buffer];
            let submit_info = vk::SubmitInfo::builder().command_buffers(&command_buffers);
            unsafe { device.queue_submit(queue, &[submit_info], vk::Fence::null()) }.vk_check("vkQueueSubmit")?;
        }

        // submit command buffer for each pass and wait for its completion
        for pass_index in 0..base.required_number_of_passes {
            submit_and_wait(device, queue, cmd, Some(pass_index))?;
        }
    }

    unsafe { device.reset_command_buffer(cmd, vk::CommandBufferResetFlags::empty()) }
        .vk_check("vkResetCommandBuffer")?;

    let _ = &state.buffer;
    for pool in &pools {
        base.verify_query_results(qf_index, queue, pool)?;
    }
    Ok(TestStatus::pass("Pass"))
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum TestType {
    EnumerateAndValidate,
    Query,
    MultiplePools,
}

struct QueryPoolPerformanceTest {
    name: String,
    test_type: TestType,
    queue_flag_bits: vk::QueueFlags,
    copy_results: bool,
    seed: u32,
}

impl TestCase for QueryPoolPerformanceTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_performance_query")?;

        let mut perf_query_features = vk::PhysicalDevicePerformanceQueryFeaturesKHR::default();
        let mut perf_query_properties = vk::PhysicalDevicePerformanceQueryPropertiesKHR::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut perf_query_features);
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut perf_query_properties);
        let instance = context.get_instance();
        unsafe {
            instance.get_physical_device_features2(context.get_physical_device(), &mut features2);
            instance.get_physical_device_properties2(context.get_physical_device(), &mut properties2);
        }

        if perf_query_features.performance_counter_query_pools == vk::FALSE {
            return Err(TestError::NotSupported(
                "performanceCounterQueryPools not supported".to_string(),
            ));
        }

        if self.test_type == TestType::MultiplePools
            && perf_query_features.performance_counter_multiple_query_pools == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "performanceCounterMultipleQueryPools not supported".to_string(),
            ));
        }

        if self.copy_results && perf_query_properties.allow_command_buffer_query_copies == vk::FALSE {
            return Err(TestError::NotSupported(
                "VkPhysicalDevicePerformanceQueryPropertiesKHR::allowCommandBufferQueryCopies not supported"
                    .to_string(),
            ));
        }

        if self.test_type != TestType::EnumerateAndValidate {
            // Get supported counters
            let (counters, _descriptions) = unsafe {
                instance.enumerate_physical_device_queue_family_performance_query_counters_khr(
                    context.get_physical_device(),
                    context.get_universal_queue_family_index(),
                )
            }
            .vk_check("vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR")?;

            let counters_without_cb_scope = counters
                .iter()
                .filter(|counter| counter.scope != vk::PerformanceCounterScopeKHR::COMMAND_BUFFER)
                .count();
            if counters_without_cb_scope == 0 {
                return Err(TestError::NotSupported(
                    "No counters without command buffer scope found".to_string(),
                ));
            }
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        // validation test do not need programs
        if self.test_type == TestType::EnumerateAndValidate {
            return BinaryCollection::new(&[]);
        }

        if self.queue_flag_bits == vk::QueueFlags::COMPUTE {
            PERFORMANCE_COMPUTE.programs
        } else {
            PERFORMANCE_GRAPHIC.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(QueryPoolPerformanceInstance { context, case: self })
    }
}

struct QueryPoolPerformanceInstance<'a> {
    context: &'a Context<'a>,
    case: &'a QueryPoolPerformanceTest,
}

impl TestInstance for QueryPoolPerformanceInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let case = self.case;
        let context = self.context;

        // `TCU_THROW(QualityWarning, "There are no performance counters")` of `checkSupport`
        let (counters, _descriptions) = unsafe {
            context
                .get_instance()
                .enumerate_physical_device_queue_family_performance_query_counters_khr(
                    context.get_physical_device(),
                    context.get_universal_queue_family_index(),
                )
        }
        .vk_check("vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR")?;
        if counters.is_empty() {
            return Ok(TestStatus::new(
                TestResult::QualityWarning,
                "There are no performance counters",
            ));
        }

        if case.test_type == TestType::EnumerateAndValidate {
            return enumerate_and_validate(context, case.queue_flag_bits);
        }

        let pool_count = if case.test_type == TestType::Query { 1 } else { 2 };
        if case.queue_flag_bits == vk::QueueFlags::GRAPHICS {
            run_graphic(context, case.copy_results, case.seed, pool_count)
        } else {
            run_compute(context, case.copy_results, case.seed, pool_count)
        }
    }
}

/// `QueryPoolPerformanceTests::init`
pub fn create_performance_query_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("performance_query");

    let mut seed = 1692187611u32;
    for (copy_results, suffix) in [(false, ""), (true, "_copy")] {
        for (test_type, queue_flag_bits, prefix) in [
            (
                TestType::EnumerateAndValidate,
                vk::QueueFlags::GRAPHICS,
                "enumerate_and_validate_graphic",
            ),
            (
                TestType::EnumerateAndValidate,
                vk::QueueFlags::COMPUTE,
                "enumerate_and_validate_compute",
            ),
            (TestType::Query, vk::QueueFlags::GRAPHICS, "query_graphic"),
            (TestType::Query, vk::QueueFlags::COMPUTE, "query_compute"),
            (
                TestType::MultiplePools,
                vk::QueueFlags::GRAPHICS,
                "multiple_pools_graphic",
            ),
            (
                TestType::MultiplePools,
                vk::QueueFlags::COMPUTE,
                "multiple_pools_compute",
            ),
        ] {
            group.add_child(Box::new(QueryPoolPerformanceTest {
                name: format!("{prefix}{suffix}"),
                test_type,
                queue_flag_bits,
                copy_results,
                seed,
            }) as Box<dyn TestCase>);
            seed += 1;
        }
    }

    group
}
