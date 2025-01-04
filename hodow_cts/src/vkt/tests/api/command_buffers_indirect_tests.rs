// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiCommandBuffersTests.cpp (`IndirectDispatchAlignmentCase`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `indirect_compute_dispatch_offsets_<memory offset>_<dispatch offset>`: an indirect dispatch recorded in a secondary command buffer, its
// command read from a buffer bound at an offset inside a larger allocation and placed at a dispatch offset, on the compute queue.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_1, KhrMaintenance6ExtensionDeviceCommands, KhrPushDescriptorExtensionDeviceCommands};

use crate::generated::shaders::api_command_buffers::{
    INDIRECT_DISPATCH_ALIGNMENT, MANY_INDIRECT_DISPATCHES, MANY_INDIRECT_DRAWS, SECONDARY_EXTRA_BUFFER,
    SECONDARY_EXTRA_PC,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_secondary_command_buffer, end_command_buffer, submit_commands_and_wait,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, GraphicsPipelineStages, allocate_command_buffer, make_buffer_create_info, make_command_pool,
    make_descriptor_buffer_info, make_descriptor_set, make_framebuffer, make_graphics_pipeline_staged,
    make_memory_barrier, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// Must match the compute shader.
const VALUE_COUNT: usize = 64;
const INDIRECT_DISPATCH_VALUE_OFFSET: u32 = 1_000_000;

/// `IndirectDispatchAlignmentCase`
struct IndirectDispatchAlignmentCase {
    name: String,
    mem_offset: u32,
    dispatch_offset: u32,
}

impl TestCase for IndirectDispatchAlignmentCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context
            .get_compute_queue()
            .map(|_| ())
            .ok_or_else(|| TestError::NotSupported("no compute queue".to_string()))
    }

    fn programs(&self) -> BinaryCollection {
        INDIRECT_DISPATCH_ALIGNMENT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IndirectDispatchAlignmentInstance {
            context,
            mem_offset: self.mem_offset,
            dispatch_offset: self.dispatch_offset,
        })
    }
}

struct IndirectDispatchAlignmentInstance<'a> {
    context: &'a Context<'a>,
    mem_offset: u32,
    dispatch_offset: u32,
}

impl TestInstance for IndirectDispatchAlignmentInstance<'_> {
    /// `IndirectDispatchAlignmentInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let (queue, qf_index) = context
            .get_compute_queue()
            .ok_or_else(|| TestError::NotSupported("no compute queue".to_string()))?;
        let desc_type = vk::DescriptorType::STORAGE_BUFFER;
        let bind_point = vk::PipelineBindPoint::COMPUTE;
        let data_stages = vk::ShaderStageFlags::COMPUTE;

        // Host-side buffer values and the storage buffer.
        let buffer_values = [0u32; VALUE_COUNT];
        let sb_size = std::mem::size_of_val(&buffer_values) as vk::DeviceSize;
        let storage_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(sb_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let sb_alloc = storage_buffer.get_allocation();
        unsafe {
            std::ptr::copy_nonoverlapping(
                buffer_values.as_ptr().cast::<u8>(),
                sb_alloc.get_host_ptr(),
                sb_size as usize,
            )
        };
        flush_alloc(device, sb_alloc)?;

        // Indirect dispatch buffer contents. The size takes the dispatch offset into account.
        let indirect_command = [1u32, 1, 1];
        let command_size = std::mem::size_of_val(&indirect_command) as vk::DeviceSize;
        let ib_info = make_buffer_create_info(
            self.dispatch_offset as vk::DeviceSize + command_size,
            vk::BufferUsageFlags::INDIRECT_BUFFER,
        );
        let indirect_buffer = Unique::new(
            device,
            unsafe { device.create_buffer(&ib_info, None) }.vk_check("vkCreateBuffer")?,
        );

        // Allocate more memory if needed and bind with an offset.
        let mem_reqs = unsafe { device.get_buffer_memory_requirements(*indirect_buffer) };
        let mem_offset = (self.mem_offset as vk::DeviceSize).div_ceil(mem_reqs.alignment) * mem_reqs.alignment;
        let allocation_requirements = vk::MemoryRequirements {
            size: mem_offset + mem_reqs.size,
            alignment: mem_reqs.alignment,
            memory_type_bits: mem_reqs.memory_type_bits,
        };
        let ib_memory = allocator.allocate(device, allocation_requirements, MemoryRequirement::HOST_VISIBLE)?;
        unsafe {
            device.bind_buffer_memory(
                *indirect_buffer,
                ib_memory.get_memory(),
                ib_memory.get_offset() + mem_offset,
            )
        }
        .vk_check("vkBindBufferMemory")?;

        // Copy data to the buffer taking into account the dispatch offset.
        unsafe {
            let ib_data = ib_memory.get_host_ptr().add(mem_offset as usize);
            std::ptr::copy_nonoverlapping(
                indirect_command.as_ptr().cast::<u8>(),
                ib_data.add(self.dispatch_offset as usize),
                command_size as usize,
            );
        }
        flush_alloc(device, &ib_memory)?;

        // Descriptor pool, set, layout, etc.
        let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(desc_type, data_stages)
            .build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;

        let db_desc_info = make_descriptor_buffer_info(storage_buffer.get(), 0, sb_size);
        let write = vk::WriteDescriptorSet {
            dst_set: *descriptor_set,
            dst_binding: 0,
            descriptor_count: 1,
            descriptor_type: desc_type,
            buffer_info: &db_desc_info,
            ..Default::default()
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        // Layout and pipeline.
        let set_layouts = [*set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );
        let comp_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*comp_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(0);
        let pipeline = Unique::new(
            device,
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?
                .0[0],
        );

        // To make it more interesting, we'll also use secondary command buffers.
        let cmd_pool = make_command_pool(device, qf_index)?;
        let primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

        let inheritance_info = vk::CommandBufferInheritanceInfo::default();
        let secondary_begin_info = vk::CommandBufferBeginInfo::builder().inheritance_info(&inheritance_info);
        unsafe {
            device
                .begin_command_buffer(*secondary, &secondary_begin_info)
                .vk_check("vkBeginCommandBuffer")?;
            device.cmd_bind_pipeline(*secondary, bind_point, *pipeline);
            device.cmd_bind_descriptor_sets(
                *secondary,
                bind_point,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_dispatch_indirect(*secondary, *indirect_buffer, self.dispatch_offset as vk::DeviceSize);
        }
        end_command_buffer(device, *secondary)?;

        begin_command_buffer(device, *primary)?;
        let compute_to_host = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_execute_commands(*primary, &[*secondary]);
            device.cmd_pipeline_barrier(
                *primary,
                vk::PipelineStageFlags::COMPUTE_SHADER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[compute_to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, *primary)?;
        submit_commands_and_wait(device, queue, *primary)?;

        // Verify values.
        invalidate_alloc(device, sb_alloc)?;
        let output_values = unsafe { std::slice::from_raw_parts(sb_alloc.get_host_ptr() as *const u32, VALUE_COUNT) };
        for (i, &value) in output_values.iter().enumerate() {
            let ref_value = buffer_values[i] + i as u32 + INDIRECT_DISPATCH_VALUE_OFFSET;
            if value != ref_value {
                return Ok(TestStatus::fail(format!(
                    "Unexpected value found at position {i}: expected {ref_value} but found {value}"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// Indirect dispatches with different offsets.
pub fn add_indirect_dispatch_alignment_tests(group: &mut TestCaseGroup) {
    let offsets_to_test = [0u32, 4, 8, 12, 16, 20, 24, 28];
    for mem_offset in offsets_to_test {
        for dispatch_offset in offsets_to_test {
            group.add_child(Box::new(IndirectDispatchAlignmentCase {
                name: format!("indirect_compute_dispatch_offsets_{mem_offset}_{dispatch_offset}"),
                mem_offset,
                dispatch_offset,
            }) as Box<dyn TestCase>);
        }
    }
}

/// A case that is a plain function over the context, with the programs it registers.
struct ProgramFunctionCase {
    name: &'static str,
    programs: BinaryCollection,
    check_support: fn(&Context<'_>) -> Result<(), TestError>,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestCase for ProgramFunctionCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        (self.check_support)(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ProgramFunctionInstance {
            context,
            test: self.test,
        })
    }
}

struct ProgramFunctionInstance<'a> {
    context: &'a Context<'a>,
    test: fn(&Context<'_>) -> TestOutcome,
}

impl TestInstance for ProgramFunctionInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        (self.test)(self.context)
    }
}

fn check_nothing(_context: &Context<'_>) -> Result<(), TestError> {
    Ok(())
}

/// `checkManyIndirectDispatchesSupport`: getComputeQueue() throws NotSupportedError if the device has no compute queue.
fn check_compute_queue(context: &Context<'_>) -> Result<(), TestError> {
    context
        .get_compute_queue()
        .map(|_| ())
        .ok_or_else(|| TestError::NotSupported("no compute queue".to_string()))
}

/// `manyIndirectDrawsTest`: one indirect point draw per pixel, recorded in a secondary command buffer inside a render pass.
fn many_indirect_draws_test(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let fb_size = 64u32;
    let pixel_count = fb_size * fb_size;
    let fb_format = vk::Format::R8G8B8A8_UNORM;
    let bind_point = vk::PipelineBindPoint::GRAPHICS;

    // Color buffer with verification buffer.
    let color_image_info = vk::ImageCreateInfo::builder()
        .image_type(vk::ImageType::_2D)
        .format(fb_format)
        .extent(vk::Extent3D {
            width: fb_size,
            height: fb_size,
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
    let color_image = ImageWithMemory::new(device, allocator, color_image_info, MemoryRequirement::ANY)?;
    let color_view = make_image_view(
        device,
        color_image.get(),
        vk::ImageViewType::_2D,
        fb_format,
        make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
    )?;
    let color_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info((pixel_count * 4) as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
        MemoryRequirement::HOST_VISIBLE,
    )?;

    // Vertices for each point.
    let mut vertices: Vec<[f32; 4]> = Vec::with_capacity(pixel_count as usize);
    for y in 0..fb_size {
        for x in 0..fb_size {
            let x_coord = ((x as f32 + 0.5) / fb_size as f32) * 2.0 - 1.0;
            let y_coord = ((y as f32 + 0.5) / fb_size as f32) * 2.0 - 1.0;
            vertices.push([x_coord, y_coord, 0.0, 1.0]);
        }
    }

    let vertex_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            std::mem::size_of_val(vertices.as_slice()) as vk::DeviceSize,
            vk::BufferUsageFlags::VERTEX_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            vertices.as_ptr().cast::<u8>(),
            vertex_buffer.get_allocation().get_host_ptr(),
            std::mem::size_of_val(vertices.as_slice()),
        )
    };
    flush_alloc(device, vertex_buffer.get_allocation())?;

    // VkDrawIndirectCommand: vertexCount, instanceCount, firstVertex, firstInstance
    let indirect_commands: Vec<[u32; 4]> = (0..pixel_count).map(|i| [1, 1, i, 0]).collect();
    let indirect_cmd_size = std::mem::size_of::<[u32; 4]>() as u32;
    let indirect_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            std::mem::size_of_val(indirect_commands.as_slice()) as vk::DeviceSize,
            vk::BufferUsageFlags::INDIRECT_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            indirect_commands.as_ptr().cast::<u8>(),
            indirect_buffer.get_allocation().get_host_ptr(),
            std::mem::size_of_val(indirect_commands.as_slice()),
        )
    };
    flush_alloc(device, indirect_buffer.get_allocation())?;

    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&vk::PipelineLayoutCreateInfo::builder(), None) }
            .vk_check("vkCreatePipelineLayout")?,
    );
    let render_pass = make_render_pass(device, fb_format)?;
    let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], fb_size, fb_size, 1)?;

    // Modules.
    let binaries = context.get_binary_collection();
    let vert_module = create_shader_module(device, binaries.get("vert")?)?;
    let frag_module = create_shader_module(device, binaries.get("frag")?)?;
    let stages = GraphicsPipelineStages {
        vertex: *vert_module,
        fragment: *frag_module,
        tessellation_control: None,
        tessellation_evaluation: None,
        geometry: None,
    };
    let pipeline = make_graphics_pipeline_staged(
        device,
        *pipeline_layout,
        stages,
        *render_pass,
        (fb_size, fb_size),
        vk::PrimitiveTopology::POINT_LIST,
        vk::SampleCountFlags::_1,
        None,
        1,
        None,
        None,
    )?;

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    begin_secondary_command_buffer(device, *secondary, *render_pass, 0, *framebuffer)?;
    unsafe {
        device.cmd_bind_vertex_buffers(*secondary, 0, &[vertex_buffer.get()], &[0]);
        device.cmd_bind_pipeline(*secondary, bind_point, *pipeline);
        for i in 0..pixel_count {
            device.cmd_draw_indirect(
                *secondary,
                indirect_buffer.get(),
                (i * indirect_cmd_size) as vk::DeviceSize,
                1,
                indirect_cmd_size,
            );
        }
    }
    end_command_buffer(device, *secondary)?;

    begin_command_buffer(device, *primary)?;
    let clear_values = [vk::ClearValue {
        color: vk::ClearColorValue {
            float32: [0.0, 0.0, 0.0, 1.0],
        },
    }];
    let begin_info = vk::RenderPassBeginInfo::builder()
        .render_pass(*render_pass)
        .framebuffer(*framebuffer)
        .render_area(vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: fb_size,
                height: fb_size,
            },
        })
        .clear_values(&clear_values);
    unsafe {
        device.cmd_begin_render_pass(*primary, &begin_info, vk::SubpassContents::SECONDARY_COMMAND_BUFFERS);
        device.cmd_execute_commands(*primary, &[*secondary]);
        device.cmd_end_render_pass(*primary);
    }
    copy_image_to_buffer(
        device,
        *primary,
        color_image.get(),
        color_buffer.get(),
        fb_size,
        fb_size,
    );
    end_command_buffer(device, *primary)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *primary)?;

    // Verify color output: when using 0 and 1 only, we expect exact results.
    invalidate_alloc(device, color_buffer.get_allocation())?;
    let bytes = unsafe {
        std::slice::from_raw_parts(
            color_buffer.get_allocation().get_host_ptr() as *const u8,
            (pixel_count * 4) as usize,
        )
    };
    if bytes.chunks_exact(4).any(|pixel| pixel != [0, 0, 255, 255]) {
        return Ok(TestStatus::fail("Unexpected color in result buffer"));
    }

    Ok(TestStatus::pass("Pass"))
}

/// `manyIndirectDispatchesTest`: 4096 indirect dispatches, each with its own push constant, recorded in one secondary command buffer.
fn many_indirect_dispatches_test(context: &Context<'_>) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let (queue, qf_index) = context
        .get_compute_queue()
        .ok_or_else(|| TestError::NotSupported("no compute queue".to_string()))?;
    let desc_type = vk::DescriptorType::STORAGE_BUFFER;
    let bind_point = vk::PipelineBindPoint::COMPUTE;
    let data_stages = vk::ShaderStageFlags::COMPUTE;
    let value_count = 4096u32;

    // Host-side buffer values and the storage buffer.
    let buffer_values = vec![0u32; value_count as usize];
    let sb_size = std::mem::size_of_val(buffer_values.as_slice()) as vk::DeviceSize;
    let storage_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(sb_size, vk::BufferUsageFlags::STORAGE_BUFFER),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    let sb_alloc = storage_buffer.get_allocation();
    unsafe {
        std::ptr::copy_nonoverlapping(
            buffer_values.as_ptr().cast::<u8>(),
            sb_alloc.get_host_ptr(),
            sb_size as usize,
        )
    };
    flush_alloc(device, sb_alloc)?;

    // Indirect dispatch buffer. We pretend to have 4096 indirect commands but all of them launch 1 group with 1 invocation.
    let indirect_commands: Vec<[u32; 3]> = vec![[1, 1, 1]; value_count as usize];
    let command_size = std::mem::size_of::<[u32; 3]>() as vk::DeviceSize;
    let indirect_buffer = BufferWithMemory::new(
        device,
        allocator,
        make_buffer_create_info(
            std::mem::size_of_val(indirect_commands.as_slice()) as vk::DeviceSize,
            vk::BufferUsageFlags::INDIRECT_BUFFER,
        ),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            indirect_commands.as_ptr().cast::<u8>(),
            indirect_buffer.get_allocation().get_host_ptr(),
            std::mem::size_of_val(indirect_commands.as_slice()),
        )
    };
    flush_alloc(device, indirect_buffer.get_allocation())?;

    // Descriptor pool, set, layout, etc.
    let descriptor_pool = DescriptorPoolBuilder::new().add_type(desc_type, 1).build(
        device,
        vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
        1,
    )?;
    let set_layout = DescriptorSetLayoutBuilder::new()
        .add_single_binding(desc_type, data_stages)
        .build(device)?;
    let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
    let db_desc_info = make_descriptor_buffer_info(storage_buffer.get(), 0, sb_size);
    let write = vk::WriteDescriptorSet {
        dst_set: *descriptor_set,
        dst_binding: 0,
        descriptor_count: 1,
        descriptor_type: desc_type,
        buffer_info: &db_desc_info,
        ..Default::default()
    };
    unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

    // Push constants, layout and pipeline.
    let pc_size = std::mem::size_of::<u32>() as u32;
    let pc_ranges = [vk::PushConstantRange {
        stage_flags: data_stages,
        offset: 0,
        size: pc_size,
    }];
    let set_layouts = [*set_layout];
    let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder()
        .set_layouts(&set_layouts)
        .push_constant_ranges(&pc_ranges);
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );
    let comp_module = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*comp_module)
        .name(b"main\0")
        .build();
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(*pipeline_layout)
        .base_pipeline_index(0);
    let pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );

    let cmd_pool = make_command_pool(device, qf_index)?;
    let primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;

    let inheritance_info = vk::CommandBufferInheritanceInfo::default();
    let secondary_begin_info = vk::CommandBufferBeginInfo::builder().inheritance_info(&inheritance_info);
    unsafe {
        device
            .begin_command_buffer(*secondary, &secondary_begin_info)
            .vk_check("vkBeginCommandBuffer")?;
        device.cmd_bind_pipeline(*secondary, bind_point, *pipeline);
        device.cmd_bind_descriptor_sets(
            *secondary,
            bind_point,
            *pipeline_layout,
            0,
            &[*descriptor_set],
            &[] as &[u32],
        );
        for i in 0..value_count {
            device.cmd_push_constants(*secondary, *pipeline_layout, data_stages, 0, &i.to_ne_bytes());
            device.cmd_dispatch_indirect(*secondary, indirect_buffer.get(), i as vk::DeviceSize * command_size);
        }
    }
    end_command_buffer(device, *secondary)?;

    begin_command_buffer(device, *primary)?;
    let compute_to_host = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_execute_commands(*primary, &[*secondary]);
        device.cmd_pipeline_barrier(
            *primary,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[compute_to_host],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, *primary)?;
    submit_commands_and_wait(device, queue, *primary)?;

    // Verify values.
    invalidate_alloc(device, sb_alloc)?;
    let output_values =
        unsafe { std::slice::from_raw_parts(sb_alloc.get_host_ptr() as *const u32, value_count as usize) };
    for (i, &value) in output_values.iter().enumerate() {
        let ref_value = buffer_values[i] + i as u32 + INDIRECT_DISPATCH_VALUE_OFFSET;
        if value != ref_value {
            return Ok(TestStatus::fail(format!(
                "Unexpected value found at position {i}: expected {ref_value} but found {value}"
            )));
        }
    }

    Ok(TestStatus::pass("Pass"))
}

/// `many_indirect_draws_on_secondary` and `many_indirect_disps_on_secondary`
pub fn add_many_indirect_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(ProgramFunctionCase {
        name: "many_indirect_draws_on_secondary",
        programs: MANY_INDIRECT_DRAWS.programs,
        check_support: check_nothing,
        test: many_indirect_draws_test,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(ProgramFunctionCase {
        name: "many_indirect_disps_on_secondary",
        programs: MANY_INDIRECT_DISPATCHES.programs,
        check_support: check_compute_queue,
        test: many_indirect_dispatches_test,
    }) as Box<dyn TestCase>);
}

/// `SecCmdExtraCase`: Mesa drivers implement secondary command buffers by capture and replay, which needs care for commands that carry pointers.
#[derive(Clone, Copy, PartialEq, Eq)]
enum SecCmdExtraCase {
    PushConstants2,
    PushDescriptorSet2,
    PushDescriptorSetWithTemplate,
}

/// `secCmdExtraCaseSupportCheck`
fn sec_cmd_extra_case_support_check(context: &Context<'_>, extra_case: SecCmdExtraCase) -> Result<(), TestError> {
    if matches!(
        extra_case,
        SecCmdExtraCase::PushConstants2 | SecCmdExtraCase::PushDescriptorSet2
    ) {
        context.require_device_functionality("VK_KHR_maintenance6")?;
    }
    if matches!(
        extra_case,
        SecCmdExtraCase::PushDescriptorSet2 | SecCmdExtraCase::PushDescriptorSetWithTemplate
    ) {
        context.require_device_functionality("VK_KHR_push_descriptor")?;
    }
    if extra_case == SecCmdExtraCase::PushDescriptorSetWithTemplate {
        context.require_device_functionality("VK_KHR_descriptor_update_template")?;
    }
    Ok(())
}

/// `secCmdExtraCaseTest`
fn sec_cmd_extra_case_test(context: &Context<'_>, extra_case: SecCmdExtraCase) -> TestOutcome {
    let device = context.get_device();
    let allocator = context.get_default_allocator();
    let desc_type = vk::DescriptorType::STORAGE_BUFFER;
    let shader_stages = vk::ShaderStageFlags::COMPUTE;
    let bind_point = vk::PipelineBindPoint::COMPUTE;
    let is_pc = extra_case == SecCmdExtraCase::PushConstants2;
    let is_pd = extra_case == SecCmdExtraCase::PushDescriptorSet2;
    let is_tpl = extra_case == SecCmdExtraCase::PushDescriptorSetWithTemplate;
    let ref_data = [777.0f32, 888.0, 999.0, 1111.0];
    let desc_count = if is_pc { 1u32 } else { 2 };
    let pc_size = std::mem::size_of_val(&ref_data) as u32;

    let mut set_layout_builder = DescriptorSetLayoutBuilder::new().add_single_binding(desc_type, shader_stages);
    if !is_pc {
        set_layout_builder = set_layout_builder.add_single_binding(desc_type, shader_stages);
    }
    let set_layout_flags = if is_pd || is_tpl {
        vk::DescriptorSetLayoutCreateFlags::PUSH_DESCRIPTOR
    } else {
        vk::DescriptorSetLayoutCreateFlags::empty()
    };
    let set_layout = set_layout_builder.build_with_flags(device, set_layout_flags)?;

    let pc_ranges = [vk::PushConstantRange {
        stage_flags: shader_stages,
        offset: 0,
        size: pc_size,
    }];
    let set_layouts = [*set_layout];
    let mut pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
    if is_pc {
        pipeline_layout_info = pipeline_layout_info.push_constant_ranges(&pc_ranges);
    }
    let pipeline_layout = Unique::new(
        device,
        unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
    );

    // Buffers, descriptor pool, set and writes.
    let ssbo_info = make_buffer_create_info(pc_size as vk::DeviceSize, vk::BufferUsageFlags::STORAGE_BUFFER);
    let out_buffer = BufferWithMemory::new(device, allocator, ssbo_info, MemoryRequirement::HOST_VISIBLE)?;
    let in_buffer = if is_pc {
        None
    } else {
        let buffer = BufferWithMemory::new(device, allocator, ssbo_info, MemoryRequirement::HOST_VISIBLE)?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                ref_data.as_ptr().cast::<u8>(),
                buffer.get_allocation().get_host_ptr(),
                pc_size as usize,
            )
        };
        flush_alloc(device, buffer.get_allocation())?;
        Some(buffer)
    };

    let mut desc_pool = None;
    let mut desc_set = None;
    if !(is_pd || is_tpl) {
        let pool = DescriptorPoolBuilder::new().add_type(desc_type, desc_count).build(
            device,
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        desc_set = Some(make_descriptor_set(device, *pool, *set_layout)?);
        desc_pool = Some(pool);
    }
    let _ = &desc_pool;

    let mut desc_update_tpl = None;
    if is_tpl {
        // The update will work on both descriptors at the same time.
        let template_entries = [vk::DescriptorUpdateTemplateEntry {
            dst_binding: 0,
            dst_array_element: 0,
            descriptor_count: desc_count,
            descriptor_type: desc_type,
            offset: 0,
            stride: std::mem::size_of::<vk::DescriptorBufferInfo>(),
        }];
        let tpl_create_info = vk::DescriptorUpdateTemplateCreateInfo {
            descriptor_update_entry_count: 1,
            descriptor_update_entries: template_entries.as_ptr(),
            template_type: vk::DescriptorUpdateTemplateType::PUSH_DESCRIPTORS,
            descriptor_set_layout: *set_layout,
            pipeline_bind_point: bind_point,
            pipeline_layout: *pipeline_layout,
            set: 0,
            ..Default::default()
        };
        desc_update_tpl = Some(
            unsafe { device.create_descriptor_update_template(&tpl_create_info, None) }
                .vk_check("vkCreateDescriptorUpdateTemplate")?,
        );
    }

    let out_desc_info = make_descriptor_buffer_info(out_buffer.get(), 0, vk::WHOLE_SIZE);
    let in_desc_info = make_descriptor_buffer_info(
        in_buffer.as_ref().map_or(vk::Buffer::null(), |b| b.get()),
        0,
        vk::WHOLE_SIZE,
    );

    if is_pc {
        let write = vk::WriteDescriptorSet {
            dst_set: **desc_set.as_ref().expect("the push constant case has a set"),
            dst_binding: 0,
            descriptor_count: 1,
            descriptor_type: desc_type,
            buffer_info: &out_desc_info,
            ..Default::default()
        };
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };
    }

    let program = if is_pc {
        SECONDARY_EXTRA_PC.programs
    } else {
        SECONDARY_EXTRA_BUFFER.programs
    };
    let _ = program;
    let comp_shader = create_shader_module(device, context.get_binary_collection().get("comp")?)?;
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(*comp_shader)
        .name(b"main\0")
        .build();
    let pipeline_info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(*pipeline_layout)
        .base_pipeline_index(0);
    let pipeline = Unique::new(
        device,
        unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?
            .0[0],
    );

    let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
    let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
    let inheritance_info = vk::CommandBufferInheritanceInfo::default();
    let secondary_begin_info = vk::CommandBufferBeginInfo::builder().inheritance_info(&inheritance_info);
    unsafe { device.begin_command_buffer(*secondary, &secondary_begin_info) }.vk_check("vkBeginCommandBuffer")?;
    {
        // The structures are recorded in a sub-scope to make sure each is destroyed before the command buffer is used.
        if is_pd {
            let desc_buffer_infos = [out_desc_info, in_desc_info];
            let descriptor_write = vk::WriteDescriptorSet {
                dst_set: vk::DescriptorSet::null(),
                dst_binding: 0,
                dst_array_element: 0,
                descriptor_count: desc_buffer_infos.len() as u32,
                descriptor_type: desc_type,
                buffer_info: desc_buffer_infos.as_ptr(),
                ..Default::default()
            };
            let pds_info = vk::PushDescriptorSetInfo {
                stage_flags: shader_stages,
                layout: *pipeline_layout,
                set: 0,
                descriptor_write_count: 1,
                descriptor_writes: &descriptor_write,
                ..Default::default()
            };
            unsafe { device.cmd_push_descriptor_set2_khr(*secondary, &pds_info) };
        } else if is_tpl {
            let desc_buffer_infos = [out_desc_info, in_desc_info];
            unsafe {
                device.cmd_push_descriptor_set_with_template_khr(
                    *secondary,
                    desc_update_tpl.expect("the template case has a template"),
                    *pipeline_layout,
                    0,
                    desc_buffer_infos.as_ptr().cast(),
                )
            };
        } else {
            unsafe {
                device.cmd_bind_descriptor_sets(
                    *secondary,
                    bind_point,
                    *pipeline_layout,
                    0,
                    &[**desc_set.as_ref().expect("the push constant case has a set")],
                    &[] as &[u32],
                )
            };
        }

        unsafe { device.cmd_bind_pipeline(*secondary, bind_point, *pipeline) };

        if is_pc {
            let pc_data_copy = ref_data;
            let push_constants_info = vk::PushConstantsInfo {
                layout: *pipeline_layout,
                stage_flags: shader_stages,
                offset: 0,
                size: pc_size,
                values: pc_data_copy.as_ptr().cast(),
                ..Default::default()
            };
            unsafe { device.cmd_push_constants2_khr(*secondary, &push_constants_info) };
        }

        unsafe { device.cmd_dispatch(*secondary, 1, 1, 1) };
    }
    end_command_buffer(device, *secondary)?;

    // When using the push with template code path, the template must be destroyed before recording the primary command buffer.
    if let Some(template) = desc_update_tpl.take() {
        unsafe { device.destroy_descriptor_update_template(template, None) };
    }

    let primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
    begin_command_buffer(device, *primary)?;
    let barrier = make_memory_barrier(vk::AccessFlags::SHADER_WRITE, vk::AccessFlags::HOST_READ);
    unsafe {
        device.cmd_execute_commands(*primary, &[*secondary]);
        device.cmd_pipeline_barrier(
            *primary,
            vk::PipelineStageFlags::COMPUTE_SHADER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
    end_command_buffer(device, *primary)?;
    submit_commands_and_wait(device, context.get_universal_queue(), *primary)?;

    // Verify output buffer.
    invalidate_alloc(device, out_buffer.get_allocation())?;
    let result = unsafe { std::slice::from_raw_parts(out_buffer.get_allocation().get_host_ptr() as *const f32, 4) };
    if result != ref_data {
        return Ok(TestStatus::fail(format!(
            "Unexpected result in output buffer: expected {ref_data:?} but found {result:?}"
        )));
    }

    Ok(TestStatus::pass("Pass"))
}

/// The `secondary_push_*` cases of `createCommandBuffersTests`.
pub fn add_secondary_extra_tests(group: &mut TestCaseGroup) {
    struct ExtraCase {
        name: &'static str,
        extra_case: SecCmdExtraCase,
    }

    impl TestCase for ExtraCase {
        fn name(&self) -> &str {
            self.name
        }

        fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
            sec_cmd_extra_case_support_check(context, self.extra_case)
        }

        fn programs(&self) -> BinaryCollection {
            if self.extra_case == SecCmdExtraCase::PushConstants2 {
                SECONDARY_EXTRA_PC.programs
            } else {
                SECONDARY_EXTRA_BUFFER.programs
            }
        }

        fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
            Box::new(ExtraInstance {
                context,
                extra_case: self.extra_case,
            })
        }
    }

    struct ExtraInstance<'a> {
        context: &'a Context<'a>,
        extra_case: SecCmdExtraCase,
    }

    impl TestInstance for ExtraInstance<'_> {
        fn iterate(&mut self) -> TestOutcome {
            sec_cmd_extra_case_test(self.context, self.extra_case)
        }
    }

    for (name, extra_case) in [
        ("secondary_push_constants_2", SecCmdExtraCase::PushConstants2),
        ("secondary_push_descriptor_set_2", SecCmdExtraCase::PushDescriptorSet2),
        (
            "secondary_push_descriptor_set_with_template",
            SecCmdExtraCase::PushDescriptorSetWithTemplate,
        ),
    ] {
        group.add_child(Box::new(ExtraCase { name, extra_case }) as Box<dyn TestCase>);
    }
}
