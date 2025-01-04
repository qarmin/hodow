// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiDescriptorSetTests.cpp
//   external/vulkancts/modules/vulkan/api/vktApiBufferComputeInstance.cpp
//   external/vulkancts/modules/vulkan/api/vktApiComputeInstanceResultBuffer.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The shaders are in `shaders/manifest/api_descriptor_set.toml`. The amber case
// `descriptor_set_layout_binding.layout_binding_order` is written out by hand (`layout_binding_order_test`).

use vulkanalia::prelude::v1_0::*;

use super::case_util::{add_case, add_function_case_no_support};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set,
};
// Re-exported so the generated shader module, which imports this module wholesale,
// can name the type its manifest entries are declared with.
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `ComputeInstanceResultBuffer::DATA_SIZE`, `sizeof(tcu::Vec4[4])`
const RESULT_BUFFER_DATA_SIZE: vk::DeviceSize = 64;

/// `sizeof(tcu::Vec4[2])`
const COLOR_DATA_SIZE: vk::DeviceSize = 32;

/// `createDescriptorSetLayout` of vktApiBufferComputeInstance.cpp
fn create_data_descriptor_set_layout<'a>(
    context: &'a Context<'_>,
) -> Result<Unique<'a, vk::DescriptorSetLayout>, TestError> {
    DescriptorSetLayoutBuilder::new()
        .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::COMPUTE)
        .build(context.get_device())
}

/// `createPipelineLayoutDestroyDescriptorSetLayout`: the set layout is gone before the pipeline layout is used.
fn create_pipeline_layout_destroy_descriptor_set_layout<'a>(
    context: &'a Context<'_>,
) -> Result<Unique<'a, vk::PipelineLayout>, TestError> {
    let vk = context.get_device();
    let descriptor_set_layout = create_data_descriptor_set_layout(context)?;

    let set_layouts = [*descriptor_set_layout];
    let info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
    let layout = unsafe { vk.create_pipeline_layout(&info, None) }.vk_check("vkCreatePipelineLayout")?;

    Ok(Unique::new(vk, layout))
}

fn make_entry_point_stage(stage: vk::ShaderStageFlags, module: vk::ShaderModule) -> vk::PipelineShaderStageCreateInfo {
    vk::PipelineShaderStageCreateInfo::builder()
        .stage(stage)
        .module(module)
        .name(b"main\0")
        .build()
}

/// `descriptorSetLayoutLifetimeGraphicsTest`
fn descriptor_set_layout_lifetime_graphics_test(context: &Context<'_>) -> TestOutcome {
    let vk = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();

    let pipeline_layout = create_pipeline_layout_destroy_descriptor_set_layout(context)?;

    let vertex_shader_module = create_shader_module(vk, context.get_binary_collection().get("vertex")?)?;
    let stages = [make_entry_point_stage(
        vk::ShaderStageFlags::VERTEX,
        *vertex_shader_module,
    )];

    let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder();
    let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
        .topology(vk::PrimitiveTopology::TRIANGLE_STRIP)
        .primitive_restart_enable(false);
    let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
        .depth_clamp_enable(false)
        .rasterizer_discard_enable(true)
        .polygon_mode(vk::PolygonMode::FILL)
        .cull_mode(vk::CullModeFlags::NONE)
        .front_face(vk::FrontFace::CLOCKWISE)
        .depth_bias_enable(false)
        .line_width(1.0);

    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .build()];
    let render_pass_info = vk::RenderPassCreateInfo::builder().subpasses(&subpasses);
    let render_pass = Unique::new(
        vk,
        unsafe { vk.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
    );

    let graphics_pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
        .stages(&stages)
        .vertex_input_state(&vertex_input_state)
        .input_assembly_state(&input_assembly_state)
        .rasterization_state(&rasterization_state)
        .layout(*pipeline_layout)
        .render_pass(*render_pass)
        .subpass(0)
        .base_pipeline_index(0);
    let pipelines = unsafe { vk.create_graphics_pipelines(vk::PipelineCache::null(), &[graphics_pipeline_info], None) }
        .vk_check("vkCreateGraphicsPipelines")?;
    let graphics_pipeline = Unique::new(vk, pipelines.0[0]);

    let framebuffer_info = vk::FramebufferCreateInfo::builder()
        .render_pass(*render_pass)
        .width(16)
        .height(16)
        .layers(1);
    let framebuffer = Unique::new(
        vk,
        unsafe { vk.create_framebuffer(&framebuffer_info, None) }.vk_check("vkCreateFramebuffer")?,
    );

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buf = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let render_pass_begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: 16, height: 16 },
        });

    begin_command_buffer(vk, cmd_buf.get())?;
    unsafe {
        vk.cmd_begin_render_pass(cmd_buf.get(), &render_pass_begin_info, vk::SubpassContents::INLINE);
        vk.cmd_bind_pipeline(cmd_buf.get(), vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
        vk.cmd_draw(cmd_buf.get(), 3, 1, 0, 0);
        vk.cmd_end_render_pass(cmd_buf.get());
    }
    end_command_buffer(vk, cmd_buf.get())?;

    submit_commands_and_wait(vk, queue, cmd_buf.get())?;

    Ok(TestStatus::pass("Pass"))
}

/// `descriptorSetLayoutLifetimeComputeTest`
fn descriptor_set_layout_lifetime_compute_test(context: &Context<'_>) -> TestOutcome {
    let vk = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    // ComputeInstanceResultBuffer(vk, device, allocator, 0.0f)
    let result = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(RESULT_BUFFER_DATA_SIZE, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::write_bytes(
            result.get_allocation().get_host_ptr(),
            0,
            RESULT_BUFFER_DATA_SIZE as usize,
        )
    };
    flush_alloc(vk, result.get_allocation())?;

    let pipeline_layout = create_pipeline_layout_destroy_descriptor_set_layout(context)?;

    let compute_shader_module = create_shader_module(vk, context.get_binary_collection().get("compute")?)?;
    let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(make_entry_point_stage(
            vk::ShaderStageFlags::COMPUTE,
            *compute_shader_module,
        ))
        .layout(*pipeline_layout)
        .base_pipeline_index(0);

    // createDataBuffer(context, offset = 0, addressableSize = 256, initData = 0x00, dataSize = 8, uninitData = 0x5A)
    const ADDRESSABLE_SIZE: usize = 256;
    const DATA_SIZE: usize = 8;
    let buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(ADDRESSABLE_SIZE as vk::DeviceSize, vk::BufferUsageFlags::UNIFORM_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        let ptr = buffer.get_allocation().get_host_ptr();
        std::ptr::write_bytes(ptr, 0x00, DATA_SIZE);
        std::ptr::write_bytes(ptr.add(DATA_SIZE), 0x5A, ADDRESSABLE_SIZE - DATA_SIZE);
    }
    flush_alloc(vk, buffer.get_allocation())?;

    let descriptor_set_layout = create_data_descriptor_set_layout(context)?;
    let descriptor_pool = DescriptorPoolBuilder::new()
        .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
        .add_type(vk::DescriptorType::UNIFORM_BUFFER, 1)
        .build(vk, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
    let descriptor_set = make_descriptor_set(vk, *descriptor_pool, *descriptor_set_layout)?;

    let result_info = make_descriptor_buffer_info(result.get(), 0, RESULT_BUFFER_DATA_SIZE);
    let buffer_info = make_descriptor_buffer_info(buffer.get(), 0, COLOR_DATA_SIZE);
    DescriptorSetUpdateBuilder::new()
        .write_single(
            descriptor_set.get(),
            Location::binding(0),
            vk::DescriptorType::STORAGE_BUFFER,
            &result_info,
        )
        .write_single(
            descriptor_set.get(),
            Location::binding(1),
            vk::DescriptorType::UNIFORM_BUFFER,
            &buffer_info,
        )
        .update(vk);

    let pipelines = unsafe { vk.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
        .vk_check("vkCreateComputePipelines")?;
    let compute_pipeline = Unique::new(vk, pipelines.0[0]);

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buf = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    begin_command_buffer(vk, cmd_buf.get())?;
    unsafe {
        vk.cmd_bind_pipeline(cmd_buf.get(), vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
        vk.cmd_bind_descriptor_sets(
            cmd_buf.get(),
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[descriptor_set.get()],
            &[],
        );
        vk.cmd_dispatch(cmd_buf.get(), 1, 1, 1);
    }
    end_command_buffer(vk, cmd_buf.get())?;

    submit_commands_and_wait(vk, queue, cmd_buf.get())?;

    Ok(TestStatus::pass("Pass"))
}

/// `emptyDescriptorSetLayoutTest`
fn empty_descriptor_set_layout_test(context: &Context<'_>, flags: vk::DescriptorSetLayoutCreateFlags) -> TestOutcome {
    let vk = context.get_device();

    if flags.contains(vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR) {
        context.require_device_functionality("VK_KHR_push_descriptor")?;
    }

    let info = vk::DescriptorSetLayoutCreateInfo::builder().flags(flags);
    let _descriptor_set_layout = Unique::new(
        vk,
        unsafe { vk.create_descriptor_set_layout(&info, None) }.vk_check("vkCreateDescriptorSetLayout")?,
    );

    Ok(TestStatus::pass("Pass"))
}

fn empty_descriptor_set_layout_normal(context: &Context<'_>) -> TestOutcome {
    empty_descriptor_set_layout_test(context, vk::DescriptorSetLayoutCreateFlags::empty())
}

fn empty_descriptor_set_layout_push_descriptor(context: &Context<'_>) -> TestOutcome {
    empty_descriptor_set_layout_test(context, vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR)
}

/// `descriptorSetLayoutBindingOrderingTest`
///
/// Updating more descriptors than binding 0 has left must spill over into the next binding.
fn descriptor_set_layout_binding_ordering_test(context: &Context<'_>) -> TestOutcome {
    let vk = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let compute_shader_module = create_shader_module(vk, context.get_binary_collection().get("compute")?)?;

    let buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(4, vk::BufferUsageFlags::UNIFORM_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { buffer.get_allocation().get_host_ptr().cast::<u32>().write(5) };

    let result_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(4 * 3, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    let descriptor_buffer_infos = [make_descriptor_buffer_info(buffer.get(), 0, vk::WHOLE_SIZE); 3];
    let descriptor_buffer_info_result = [make_descriptor_buffer_info(result_buffer.get(), 0, vk::WHOLE_SIZE)];

    let layout_bindings = [
        vk::DescriptorSetLayoutBinding::builder()
            .binding(0)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
            .descriptor_count(2)
            .stage_flags(vk::ShaderStageFlags::ALL)
            .build(),
        vk::DescriptorSetLayoutBinding::builder()
            .binding(1)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
            .descriptor_count(1)
            .stage_flags(vk::ShaderStageFlags::ALL)
            .build(),
        vk::DescriptorSetLayoutBinding::builder()
            .binding(2)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .descriptor_count(1)
            .stage_flags(vk::ShaderStageFlags::ALL)
            .build(),
    ];
    let descriptor_set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&layout_bindings);
    let descriptor_set_layout = Unique::new(
        vk,
        unsafe { vk.create_descriptor_set_layout(&descriptor_set_layout_info, None) }
            .vk_check("vkCreateDescriptorSetLayout")?,
    );

    let pool_sizes = [
        vk::DescriptorPoolSize::builder()
            .type_(vk::DescriptorType::UNIFORM_BUFFER)
            .descriptor_count(3)
            .build(),
        vk::DescriptorPoolSize::builder()
            .type_(vk::DescriptorType::STORAGE_BUFFER)
            .descriptor_count(1)
            .build(),
    ];
    let descriptor_pool_info = vk::DescriptorPoolCreateInfo::builder()
        .max_sets(1)
        .pool_sizes(&pool_sizes);
    let descriptor_pool = Unique::new(
        vk,
        unsafe { vk.create_descriptor_pool(&descriptor_pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
    );

    let set_layouts = [*descriptor_set_layout];
    let alloc_info = vk::DescriptorSetAllocateInfo::builder()
        .descriptor_pool(*descriptor_pool)
        .set_layouts(&set_layouts);
    let descriptor_set = unsafe { vk.allocate_descriptor_sets(&alloc_info) }.vk_check("vkAllocateDescriptorSets")?[0];

    let descriptor_write = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set)
        .dst_binding(0)
        .dst_array_element(0)
        .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER)
        .buffer_info(&descriptor_buffer_infos);
    let descriptor_write_result = vk::WriteDescriptorSet::builder()
        .dst_set(descriptor_set)
        .dst_binding(2)
        .dst_array_element(0)
        .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
        .buffer_info(&descriptor_buffer_info_result);

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buf = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
    let pipeline_layout = Unique::new(
        vk,
        unsafe { vk.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(make_entry_point_stage(
            vk::ShaderStageFlags::COMPUTE,
            *compute_shader_module,
        ))
        .layout(*pipeline_layout)
        .base_pipeline_index(0);
    let pipelines = unsafe { vk.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
        .vk_check("vkCreateComputePipelines")?;
    let compute_pipeline = Unique::new(vk, pipelines.0[0]);

    begin_command_buffer(vk, cmd_buf.get())?;
    unsafe {
        vk.cmd_bind_pipeline(cmd_buf.get(), vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
        vk.update_descriptor_sets(&[descriptor_write], &[] as &[vk::CopyDescriptorSet]);
        vk.update_descriptor_sets(&[descriptor_write_result], &[] as &[vk::CopyDescriptorSet]);
        vk.cmd_bind_descriptor_sets(
            cmd_buf.get(),
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[descriptor_set],
            &[],
        );
    }
    flush_alloc(vk, buffer.get_allocation())?;
    unsafe { vk.cmd_dispatch(cmd_buf.get(), 1, 1, 1) };
    end_command_buffer(vk, cmd_buf.get())?;

    submit_commands_and_wait(vk, queue, cmd_buf.get())?;

    invalidate_alloc(vk, result_buffer.get_allocation())?;
    let result = unsafe { std::slice::from_raw_parts(result_buffer.get_allocation().get_host_ptr().cast::<u32>(), 3) };

    if result[0] == 5 && result[1] == 5 && result[2] == 5 {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

/// `layout_binding_order.amber`: three dynamic uniform buffers bound out of binding order, each read at its own dynamic offset into a storage buffer.
fn layout_binding_order_test(context: &Context<'_>) -> TestOutcome {
    let vk = context.get_device();
    let queue_family_index = context.get_universal_queue_family_index();
    let queue = context.get_universal_queue();
    let allocator = context.get_default_allocator();

    let compute_shader_module = create_shader_module(vk, context.get_binary_collection().get("compute")?)?;

    // `BUFFER bufN DATA_TYPE int32 SIZE 1024 SERIES_FROM N INC_BY 1`
    let mut uniform_buffers = Vec::with_capacity(3);
    for series_from in 0..3i32 {
        let buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(4 * 1024, vk::BufferUsageFlags::UNIFORM_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let items =
            unsafe { std::slice::from_raw_parts_mut(buffer.get_allocation().get_host_ptr().cast::<i32>(), 1024) };
        for (index, item) in items.iter_mut().enumerate() {
            *item = series_from + index as i32;
        }
        flush_alloc(vk, buffer.get_allocation())?;
        uniform_buffers.push(buffer);
    }

    let result_buffer = BufferWithMemory::new(
        vk,
        allocator,
        make_buffer_create_info(4 * 3, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe { std::ptr::write_bytes(result_buffer.get_allocation().get_host_ptr(), 0, 12) };
    flush_alloc(vk, result_buffer.get_allocation())?;

    let layout_bindings = [
        vk::DescriptorSetLayoutBinding::builder()
            .binding(0)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC)
            .descriptor_count(1)
            .stage_flags(vk::ShaderStageFlags::COMPUTE)
            .build(),
        vk::DescriptorSetLayoutBinding::builder()
            .binding(1)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC)
            .descriptor_count(1)
            .stage_flags(vk::ShaderStageFlags::COMPUTE)
            .build(),
        vk::DescriptorSetLayoutBinding::builder()
            .binding(2)
            .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC)
            .descriptor_count(1)
            .stage_flags(vk::ShaderStageFlags::COMPUTE)
            .build(),
        vk::DescriptorSetLayoutBinding::builder()
            .binding(3)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .descriptor_count(1)
            .stage_flags(vk::ShaderStageFlags::COMPUTE)
            .build(),
    ];
    let descriptor_set_layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&layout_bindings);
    let descriptor_set_layout = Unique::new(
        vk,
        unsafe { vk.create_descriptor_set_layout(&descriptor_set_layout_info, None) }
            .vk_check("vkCreateDescriptorSetLayout")?,
    );

    let pool_sizes = [
        vk::DescriptorPoolSize::builder()
            .type_(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC)
            .descriptor_count(3)
            .build(),
        vk::DescriptorPoolSize::builder()
            .type_(vk::DescriptorType::STORAGE_BUFFER)
            .descriptor_count(1)
            .build(),
    ];
    let descriptor_pool_info = vk::DescriptorPoolCreateInfo::builder()
        .max_sets(1)
        .pool_sizes(&pool_sizes);
    let descriptor_pool = Unique::new(
        vk,
        unsafe { vk.create_descriptor_pool(&descriptor_pool_info, None) }.vk_check("vkCreateDescriptorPool")?,
    );

    let set_layouts = [*descriptor_set_layout];
    let alloc_info = vk::DescriptorSetAllocateInfo::builder()
        .descriptor_pool(*descriptor_pool)
        .set_layouts(&set_layouts);
    let descriptor_set = unsafe { vk.allocate_descriptor_sets(&alloc_info) }.vk_check("vkAllocateDescriptorSets")?[0];

    // The offsets of the script are dynamic offsets: `buf0` goes to binding 2, `buf1` to binding 0 and `buf2` to binding 1.
    let binding_of_buffer = [2usize, 0, 1];
    let dynamic_offset_of_buffer = [0u32, 1024, 2048];
    let mut uniform_infos = [[make_descriptor_buffer_info(vk::Buffer::null(), 0, 1024)]; 3];
    let mut dynamic_offsets = [0u32; 3];
    for (buffer_ndx, buffer) in uniform_buffers.iter().enumerate() {
        uniform_infos[binding_of_buffer[buffer_ndx]] = [make_descriptor_buffer_info(buffer.get(), 0, 1024)];
        dynamic_offsets[binding_of_buffer[buffer_ndx]] = dynamic_offset_of_buffer[buffer_ndx];
    }
    let result_info = [make_descriptor_buffer_info(result_buffer.get(), 0, vk::WHOLE_SIZE)];

    let mut writes: Vec<vk::WriteDescriptorSet> = uniform_infos
        .iter()
        .enumerate()
        .map(|(binding, info)| {
            vk::WriteDescriptorSet::builder()
                .dst_set(descriptor_set)
                .dst_binding(binding as u32)
                .dst_array_element(0)
                .descriptor_type(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC)
                .buffer_info(info)
                .build()
        })
        .collect();
    writes.push(
        vk::WriteDescriptorSet::builder()
            .dst_set(descriptor_set)
            .dst_binding(3)
            .dst_array_element(0)
            .descriptor_type(vk::DescriptorType::STORAGE_BUFFER)
            .buffer_info(&result_info)
            .build(),
    );
    unsafe { vk.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };

    let cmd_pool = make_command_pool(vk, queue_family_index)?;
    let cmd_buf = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
    let pipeline_layout = Unique::new(
        vk,
        unsafe { vk.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );
    let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(make_entry_point_stage(
            vk::ShaderStageFlags::COMPUTE,
            *compute_shader_module,
        ))
        .layout(*pipeline_layout)
        .base_pipeline_index(0);
    let pipelines = unsafe { vk.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
        .vk_check("vkCreateComputePipelines")?;
    let compute_pipeline = Unique::new(vk, pipelines.0[0]);

    begin_command_buffer(vk, cmd_buf.get())?;
    unsafe {
        vk.cmd_bind_pipeline(cmd_buf.get(), vk::PipelineBindPoint::COMPUTE, *compute_pipeline);
        vk.cmd_bind_descriptor_sets(
            cmd_buf.get(),
            vk::PipelineBindPoint::COMPUTE,
            *pipeline_layout,
            0,
            &[descriptor_set],
            &dynamic_offsets,
        );
        vk.cmd_dispatch(cmd_buf.get(), 1, 1, 1);
    }
    end_command_buffer(vk, cmd_buf.get())?;

    submit_commands_and_wait(vk, queue, cmd_buf.get())?;

    invalidate_alloc(vk, result_buffer.get_allocation())?;
    let result = unsafe { std::slice::from_raw_parts(result_buffer.get_allocation().get_host_ptr().cast::<i32>(), 3) };

    // Offset of 1024 / 4 = 256 items plus one, 2048 / 4 = 512 plus two, and the first item of the series from zero.
    if result[0] == 257 && result[1] == 514 && result[2] == 0 {
        Ok(TestStatus::pass("Pass"))
    } else {
        Ok(TestStatus::fail("Fail"))
    }
}

/// `addFunctionCaseWithPrograms` for a case whose programs are one manifest entry.
struct ProgramCase {
    name: &'static str,
    programs: BinaryCollection,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestCase for ProgramCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ProgramInstance {
            context,
            test: self.test,
        })
    }
}

struct ProgramInstance<'a> {
    context: &'a Context<'a>,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestInstance for ProgramInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test)(self.context)
    }
}

/// `createDescriptorSetTests`
pub fn create_descriptor_set_tests() -> TestCaseGroup {
    use crate::generated::shaders::api_descriptor_set::{
        DESCRIPTOR_SET_BINDING_ORDERING, DESCRIPTOR_SET_LAYOUT_BINDING_ORDER, DESCRIPTOR_SET_LIFETIME_COMPUTE,
        DESCRIPTOR_SET_LIFETIME_GRAPHICS,
    };

    let mut lifetime_tests = TestCaseGroup::new("descriptor_set_layout_lifetime");
    add_case(
        &mut lifetime_tests,
        ProgramCase {
            name: "graphics",
            programs: DESCRIPTOR_SET_LIFETIME_GRAPHICS.programs,
            test: descriptor_set_layout_lifetime_graphics_test,
        },
    );
    add_case(
        &mut lifetime_tests,
        ProgramCase {
            name: "compute",
            programs: DESCRIPTOR_SET_LIFETIME_COMPUTE.programs,
            test: descriptor_set_layout_lifetime_compute_test,
        },
    );

    let mut empty_tests = TestCaseGroup::new("empty_set");
    add_function_case_no_support(&mut empty_tests, "normal", empty_descriptor_set_layout_normal);
    add_function_case_no_support(
        &mut empty_tests,
        "push_descriptor",
        empty_descriptor_set_layout_push_descriptor,
    );
    let mut layout_tests = TestCaseGroup::new("descriptor_set_layout");
    layout_tests.add_child(empty_tests);

    let mut binding_tests = TestCaseGroup::new("descriptor_set_layout_binding");
    add_case(
        &mut binding_tests,
        ProgramCase {
            name: "update_subsequent_binding",
            programs: DESCRIPTOR_SET_BINDING_ORDERING.programs,
            test: descriptor_set_layout_binding_ordering_test,
        },
    );
    add_case(
        &mut binding_tests,
        ProgramCase {
            name: "layout_binding_order",
            programs: DESCRIPTOR_SET_LAYOUT_BINDING_ORDER.programs,
            test: layout_binding_order_test,
        },
    );

    let mut descriptor_set_tests = TestCaseGroup::new("descriptor_set");
    descriptor_set_tests.add_child(lifetime_tests);
    descriptor_set_tests.add_child(layout_tests);
    descriptor_set_tests.add_child(binding_tests);
    descriptor_set_tests
}
