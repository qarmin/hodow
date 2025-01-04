// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/api/vktApiDeviceAddressCommandsTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Ported: `misc.memory_range_barrier` (`MemoryRangeBarrierBetweenOperationsTestInstance`) and the three
// `VertexIndexBindingTestInstance` cases `use_all_vertex_index_binds`, `basic_set_stride` and `complex_set_stride`; their shaders are in
// shaders/manifest/api_device_address_misc.toml. The two sparse copies with unbound ranges (`BufferAddressCommandFlagsTestInstance`) are registered with upstream's support checks and report NotPorted. The
// command buffer of `memory_range_barrier` is submitted with vkQueueSubmit instead of vkQueueSubmit2, and the colour attachment is read back by a second
// submission.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    DeviceV1_3, ExtExtendedDynamicStateExtensionDeviceCommands, ExtVertexInputDynamicStateExtensionDeviceCommands,
    KhrMaintenance5ExtensionDeviceCommands, KhrSynchronization2ExtensionDeviceCommands,
};

use crate::generated::shaders::api_device_address_misc::{MEMORY_RANGE_BARRIER, VERTEX_INDEX_BINDING};
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::device_address_commands::{
    self, ADDRESS_COMMAND_STORAGE_BUFFER_USAGE, BindIndexBuffer3Info, BindVertexBuffer3Info, DeviceAddressRange,
    MemoryRangeBarrier, MemoryRangeBarriersInfo, StridedDeviceAddressRange,
};
use crate::vk::image_util::{ImageWithMemory, make_image_create_info, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_pipeline_layout, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::tests::pipeline::pipeline_util::read_color_attachment;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const GROUP_COUNT: u32 = 16;
const OUTPUT_OFFSET: vk::DeviceSize = 16;

fn create_compute_pipeline<'a>(
    device: &'a Device,
    layout: vk::PipelineLayout,
    module: vk::ShaderModule,
) -> Result<Unique<'a, vk::Pipeline>, TestError> {
    let stage = vk::PipelineShaderStageCreateInfo::builder()
        .stage(vk::ShaderStageFlags::COMPUTE)
        .module(module)
        .name(b"main\0")
        .build();
    let info = vk::ComputePipelineCreateInfo::builder()
        .stage(stage)
        .layout(layout)
        .base_pipeline_index(-1)
        .build();
    let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[info], None) }
        .vk_check("vkCreateComputePipelines")?;
    Ok(Unique::new(device, pipelines.0[0]))
}

struct MemoryRangeBarrierCase;

impl TestCase for MemoryRangeBarrierCase {
    fn name(&self) -> &str {
        "memory_range_barrier"
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        device_address_commands::check_support(context)?;
        context.require_device_functionality("VK_KHR_synchronization2")
    }

    fn programs(&self) -> BinaryCollection {
        MEMORY_RANGE_BARRIER.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MemoryRangeBarrierInstance { context })
    }
}

struct MemoryRangeBarrierInstance<'a> {
    context: &'a Context<'a>,
}

impl TestInstance for MemoryRangeBarrierInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let output_size = vk::DeviceSize::from(GROUP_COUNT) * std::mem::size_of::<u32>() as vk::DeviceSize;
        let buffer_size = output_size + OUTPUT_OFFSET;

        let usage = vk::BufferUsageFlags::STORAGE_BUFFER
            | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS
            | vk::BufferUsageFlags::TRANSFER_SRC;
        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(buffer_size, usage),
            MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS,
        )?;
        let output_buffer_address = device_address_commands::buffer_device_address(device, *output_buffer);

        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::COMPUTE)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *set_layout)?;
        let output_buffer_info = vk::DescriptorBufferInfo {
            buffer: *output_buffer,
            offset: OUTPUT_OFFSET,
            range: output_size,
        };
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &output_buffer_info,
            )
            .update(device);

        let binaries = context.get_binary_collection();
        let comp_module0 = create_shader_module(device, binaries.get("comp0")?)?;
        let comp_module1 = create_shader_module(device, binaries.get("comp1")?)?;
        let pipeline_layout = make_pipeline_layout(device, &[*set_layout])?;
        let pipeline0 = create_compute_pipeline(device, *pipeline_layout, *comp_module0)?;
        let pipeline1 = create_compute_pipeline(device, *pipeline_layout, *comp_module1)?;

        let mut memory_range_barrier = MemoryRangeBarrier::new(
            vk::PipelineStageFlags2::COMPUTE_SHADER,
            vk::AccessFlags2::SHADER_STORAGE_WRITE,
            vk::PipelineStageFlags2::COMPUTE_SHADER,
            vk::AccessFlags2::SHADER_STORAGE_READ,
            DeviceAddressRange {
                address: output_buffer_address + OUTPUT_OFFSET,
                size: output_size,
            },
        );
        memory_range_barrier.address_flags = ADDRESS_COMMAND_STORAGE_BUFFER_USAGE;
        let mut memory_range_barriers = [memory_range_barrier];
        let memory_range_barriers_info = MemoryRangeBarriersInfo::new(&memory_range_barriers);
        let mut dep_info = vk::DependencyInfo::default();
        dep_info.next = std::ptr::addr_of!(memory_range_barriers_info).cast();

        let has_khr_sync2 = context
            .get_device_extensions()
            .iter()
            .any(|extension| extension == "VK_KHR_synchronization2");
        let pipeline_barrier2 = |cmd_buffer: vk::CommandBuffer, dep_info: &vk::DependencyInfo| unsafe {
            if has_khr_sync2 {
                device.cmd_pipeline_barrier2_khr(cmd_buffer, dep_info);
            } else {
                device.cmd_pipeline_barrier2(cmd_buffer, dep_info);
            }
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;
        unsafe {
            device.cmd_bind_descriptor_sets(
                *cmd_buffer,
                vk::PipelineBindPoint::COMPUTE,
                *pipeline_layout,
                0,
                &[*descriptor_set],
                &[] as &[u32],
            );
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline0);
            device.cmd_dispatch(*cmd_buffer, GROUP_COUNT, 1, 1);
        }
        pipeline_barrier2(*cmd_buffer, &dep_info);
        unsafe {
            device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::COMPUTE, *pipeline1);
            device.cmd_dispatch(*cmd_buffer, 1, GROUP_COUNT, 1);
        }
        // The second barrier reuses the same structure, now making the writes visible to the host.
        memory_range_barriers[0].src_access_mask = vk::AccessFlags2::SHADER_STORAGE_WRITE;
        memory_range_barriers[0].dst_stage_mask = vk::PipelineStageFlags2::HOST;
        memory_range_barriers[0].dst_access_mask = vk::AccessFlags2::HOST_READ;
        pipeline_barrier2(*cmd_buffer, &dep_info);
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

        let output_allocation = output_buffer.get_allocation();
        invalidate_alloc(device, output_allocation)?;
        let results = unsafe {
            std::slice::from_raw_parts(
                output_allocation
                    .get_host_ptr()
                    .add(OUTPUT_OFFSET as usize)
                    .cast::<u32>(),
                GROUP_COUNT as usize,
            )
        };
        for (index, &value) in results.iter().enumerate() {
            let expected = index as u32 + 3;
            if value != expected {
                log::error!("bufferPtr[{index}] = {value}, expected {expected}");
                return Ok(TestStatus::fail("Fail"));
            }
        }
        Ok(TestStatus::pass("Pass"))
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum VertexIndexMode {
    UseAllVertexIndexBinds,
    BasicSetStride,
    ComplexSetStride,
}

struct VertexIndexBindingCase {
    name: &'static str,
    mode: VertexIndexMode,
}

impl TestCase for VertexIndexBindingCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        device_address_commands::check_support(context)?;
        context.require_device_functionality("VK_EXT_extended_dynamic_state")?;
        if self.mode == VertexIndexMode::ComplexSetStride {
            context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
        }
        if self.mode == VertexIndexMode::UseAllVertexIndexBinds {
            context.require_device_functionality("VK_KHR_maintenance5")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        VERTEX_INDEX_BINDING.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(VertexIndexBindingInstance {
            context,
            mode: self.mode,
        })
    }
}

struct VertexIndexBindingInstance<'a> {
    context: &'a Context<'a>,
    mode: VertexIndexMode,
}

/// The vertex and index buffers and what the draws bind of them
struct VertexIndexBuffers<'a> {
    vertex_buffers: Vec<BufferWithMemory<'a>>,
    vertex_buffer_sizes: Vec<vk::DeviceSize>,
    index_buffers: Vec<BufferWithMemory<'a>>,
    unused_vertex_floats: Vec<u32>,
}

impl VertexIndexBindingInstance<'_> {
    fn set_vertex_input(&self, cmd_buffer: vk::CommandBuffer, stride: vk::DeviceSize) {
        let binding = vk::VertexInputBindingDescription2EXT::builder()
            .binding(0)
            .stride(stride as u32)
            .input_rate(vk::VertexInputRate::VERTEX)
            .divisor(1)
            .build();
        let attribute = vk::VertexInputAttributeDescription2EXT::builder()
            .location(0)
            .binding(0)
            .format(vk::Format::R32G32_SFLOAT)
            .offset(0)
            .build();
        unsafe {
            self.context
                .get_device()
                .cmd_set_vertex_input_ext(cmd_buffer, &[binding], &[attribute])
        };
    }

    /// `vkCmdBindVertexBuffers2`, through the core command or the EXT one
    fn bind_vertex_buffers2(
        &self,
        cmd_buffer: vk::CommandBuffer,
        buffer: vk::Buffer,
        size: vk::DeviceSize,
        stride: vk::DeviceSize,
    ) {
        let device = self.context.get_device();
        let (major, minor, _) = self.context.api_version();
        unsafe {
            if (major, minor) >= (1, 3) {
                device.cmd_bind_vertex_buffers2(cmd_buffer, 0, &[buffer], &[0], &[size], &[stride]);
            } else {
                device.cmd_bind_vertex_buffers2_ext(cmd_buffer, 0, &[buffer], &[0], &[size], &[stride]);
            }
        }
    }

    fn draw_using_basic_set_stride(
        &self,
        commands: &device_address_commands::Commands,
        cmd_buffer: vk::CommandBuffer,
        pipeline_ds: vk::Pipeline,
        buffers: &VertexIndexBuffers<'_>,
    ) {
        let device = self.context.get_device();
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_ds);
            let address = device_address_commands::buffer_device_address(device, *buffers.vertex_buffers[0]);
            let mut vertex_buffer3_info = BindVertexBuffer3Info::new(
                true,
                StridedDeviceAddressRange {
                    address,
                    size: buffers.vertex_buffer_sizes[0],
                    stride: 24,
                },
            );
            (commands.bind_vertex_buffers3)(cmd_buffer, 0, 1, &vertex_buffer3_info);
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);

            let address = device_address_commands::buffer_device_address(device, *buffers.vertex_buffers[1]);
            vertex_buffer3_info = BindVertexBuffer3Info::new(
                false,
                StridedDeviceAddressRange {
                    address,
                    size: buffers.vertex_buffer_sizes[1],
                    stride: 0,
                },
            );
            (commands.bind_vertex_buffers3)(cmd_buffer, 0, 1, &vertex_buffer3_info);
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);
        }
    }

    fn draw_using_complex_set_stride(
        &self,
        commands: &device_address_commands::Commands,
        cmd_buffer: vk::CommandBuffer,
        pipeline_ds: vk::Pipeline,
        buffers: &VertexIndexBuffers<'_>,
    ) {
        let device = self.context.get_device();
        let float_size = std::mem::size_of::<f32>() as vk::DeviceSize;
        let stride_of = |index: usize| vk::DeviceSize::from(2 + buffers.unused_vertex_floats[index]) * float_size;
        let (stride_a, stride_b, stride_c) = (stride_of(0), stride_of(1), stride_of(2));
        let vertex_buffer = |index: usize| *buffers.vertex_buffers[index];
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_ds);

            self.set_vertex_input(cmd_buffer, stride_a);
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer(0)], &[0]);
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);

            self.bind_vertex_buffers2(cmd_buffer, vertex_buffer(1), buffers.vertex_buffer_sizes[1], stride_b);
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);

            let address = device_address_commands::buffer_device_address(device, vertex_buffer(2));
            let mut vertex_buffer3_info = BindVertexBuffer3Info::new(
                true,
                StridedDeviceAddressRange {
                    address,
                    size: buffers.vertex_buffer_sizes[2],
                    stride: stride_c,
                },
            );
            (commands.bind_vertex_buffers3)(cmd_buffer, 0, 1, &vertex_buffer3_info);
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);

            self.bind_vertex_buffers2(cmd_buffer, vertex_buffer(3), buffers.vertex_buffer_sizes[3], stride_b);
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);

            self.set_vertex_input(cmd_buffer, stride_a);
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer(4)], &[0]);
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);

            let address = device_address_commands::buffer_device_address(device, vertex_buffer(5));
            vertex_buffer3_info = BindVertexBuffer3Info::new(
                false,
                StridedDeviceAddressRange {
                    address,
                    size: buffers.vertex_buffer_sizes[5],
                    stride: 0,
                },
            );
            (commands.bind_vertex_buffers3)(cmd_buffer, 0, 1, &vertex_buffer3_info);
            device.cmd_draw(cmd_buffer, 4, 1, 0, 0);
        }
    }

    fn draw_using_all_vertex_index_binds(
        &self,
        commands: &device_address_commands::Commands,
        cmd_buffer: vk::CommandBuffer,
        pipeline: vk::Pipeline,
        pipeline_ds: vk::Pipeline,
        buffers: &VertexIndexBuffers<'_>,
    ) {
        let device = self.context.get_device();
        let u32_size = std::mem::size_of::<u32>() as vk::DeviceSize;
        unsafe {
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline);
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[*buffers.vertex_buffers[0]], &[0]);
            device.cmd_bind_index_buffer(cmd_buffer, *buffers.index_buffers[0], 0, vk::IndexType::UINT32);
            device.cmd_draw_indexed(cmd_buffer, 4, 1, 0, 0, 0);

            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_ds);
            let index_data_size = 4 * u32_size;
            self.bind_vertex_buffers2(
                cmd_buffer,
                *buffers.vertex_buffers[1],
                buffers.vertex_buffer_sizes[1],
                2 * std::mem::size_of::<f32>() as vk::DeviceSize,
            );
            device.cmd_bind_index_buffer2_khr(
                cmd_buffer,
                *buffers.index_buffers[1],
                u32_size,
                index_data_size,
                vk::IndexType::UINT32,
            );
            device.cmd_draw_indexed(cmd_buffer, 4, 1, 0, 0, 0);

            let vertex_buffer_address =
                device_address_commands::buffer_device_address(device, *buffers.vertex_buffers[2]);
            let index_buffer_address =
                device_address_commands::buffer_device_address(device, *buffers.index_buffers[2]);
            let vertex_buffer3_info = BindVertexBuffer3Info::new(
                false,
                StridedDeviceAddressRange {
                    address: vertex_buffer_address,
                    size: buffers.vertex_buffer_sizes[2],
                    stride: 0,
                },
            );
            let bind_index_buffer3_info = BindIndexBuffer3Info::new(
                DeviceAddressRange {
                    address: index_buffer_address + 2 * u32_size,
                    size: index_data_size,
                },
                vk::IndexType::UINT32,
            );
            (commands.bind_vertex_buffers3)(cmd_buffer, 0, 1, &vertex_buffer3_info);
            (commands.bind_index_buffer3)(cmd_buffer, &bind_index_buffer3_info);
            device.cmd_draw_indexed(cmd_buffer, 4, 1, 0, 0, 0);
        }
    }
}

impl TestInstance for VertexIndexBindingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let commands = device_address_commands::load_commands(context)?;

        let (unused_vertex_floats, use_index_buffers, use_regular_pipeline, use_vertex_input_dynamic_state) =
            match self.mode {
                VertexIndexMode::UseAllVertexIndexBinds => (vec![0u32, 0, 0], true, true, false),
                VertexIndexMode::BasicSetStride => (vec![4u32, 4], false, false, false),
                VertexIndexMode::ComplexSetStride => (vec![3u32, 2, 4, 2, 3, 3], false, false, true),
            };
        let buffer_count = unused_vertex_floats.len();

        let format = vk::Format::R8G8B8A8_UNORM;
        let image_extent = (64u32, 8u32);
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(image_extent.0 as i32, image_extent.1 as i32),
                format,
                vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::COLOR_ATTACHMENT,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            format,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let vertex_buffer_usage = vk::BufferUsageFlags::VERTEX_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
        let requirement = MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS;
        let float_size = std::mem::size_of::<f32>() as vk::DeviceSize;
        let mut vertex_buffers = Vec::new();
        let mut vertex_buffer_sizes = Vec::new();
        for &unused in &unused_vertex_floats {
            let size = 4 * vk::DeviceSize::from(2 + unused) * float_size;
            vertex_buffer_sizes.push(size);
            vertex_buffers.push(BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(size, vertex_buffer_usage),
                requirement,
            )?);
        }

        // Vertical rectangles, each buffer moved right by a quarter of the width
        let q_x_size = 0.125f32;
        let mut vertex_data = [-1.0f32, 1.0, -1.0, -1.0, -1.0 + q_x_size, 1.0, -1.0 + q_x_size, -1.0];
        for (vertex_buffer_index, vertex_buffer) in vertex_buffers.iter().enumerate() {
            let allocation = vertex_buffer.get_allocation();
            let floats = unsafe {
                std::slice::from_raw_parts_mut(
                    allocation.get_host_ptr().cast::<f32>(),
                    (vertex_buffer_sizes[vertex_buffer_index] / float_size) as usize,
                )
            };
            let vertex_stride = 2 + unused_vertex_floats[vertex_buffer_index] as usize;
            for vertex_index in 0..4 {
                floats[vertex_index * vertex_stride] = vertex_data[vertex_index * 2];
                floats[vertex_index * vertex_stride + 1] = vertex_data[vertex_index * 2 + 1];
            }
            flush_alloc(device, allocation)?;
            for (index, value) in vertex_data.iter_mut().enumerate() {
                *value += if index % 2 == 1 { 0.0 } else { 0.25 };
            }
        }

        let mut index_buffers = Vec::new();
        if use_index_buffers {
            // Space for extra indices so that all index buffers are different
            let items_count = 4 + buffer_count - 1;
            let index_buffer_usage = vk::BufferUsageFlags::INDEX_BUFFER | vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
            for start_index in 0..buffer_count {
                let index_buffer = BufferWithMemory::new(
                    device,
                    allocator,
                    make_buffer_create_info(
                        (items_count * std::mem::size_of::<u32>()) as vk::DeviceSize,
                        index_buffer_usage,
                    ),
                    requirement,
                )?;
                let allocation = index_buffer.get_allocation();
                let indices =
                    unsafe { std::slice::from_raw_parts_mut(allocation.get_host_ptr().cast::<u32>(), items_count) };
                for index in start_index..items_count {
                    indices[index] = (index - start_index) as u32;
                }
                flush_alloc(device, allocation)?;
                index_buffers.push(index_buffer);
            }
        }

        let render_pass = make_render_pass(device, format)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_view], image_extent.0, image_extent.1, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ];

        // The draw calls using this pipeline have a stride of 8
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_STRIP)
            .with_full_viewport(image_extent.0, image_extent.1);
        state.color_attachment_count = 1;
        state.bindings.push(vk::VertexInputBindingDescription {
            binding: 0,
            stride: 8,
            input_rate: vk::VertexInputRate::VERTEX,
        });
        state.attributes.push(vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        });
        let graphics_pipeline = if use_regular_pipeline {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &stages,
                &state,
            )?)
        } else {
            None
        };
        state.dynamic_states.push(vk::DynamicState::VERTEX_INPUT_BINDING_STRIDE);
        if use_vertex_input_dynamic_state {
            state.dynamic_states.push(vk::DynamicState::VERTEX_INPUT_EXT);
        }
        let graphics_pipeline_ds = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        let buffers = VertexIndexBuffers {
            vertex_buffers,
            vertex_buffer_sizes,
            index_buffers,
            unused_vertex_floats,
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *cmd_buffer)?;
        // The red channel has to be cleared with 0 for the test to work
        begin_render_pass(
            device,
            *cmd_buffer,
            *render_pass,
            *framebuffer,
            make_rect_2d(0, 0, image_extent.0, image_extent.1),
            vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [0.0, 0.0, 0.0, 1.0],
                },
            },
        );
        match self.mode {
            VertexIndexMode::BasicSetStride => {
                self.draw_using_basic_set_stride(&commands, *cmd_buffer, *graphics_pipeline_ds, &buffers)
            }
            VertexIndexMode::ComplexSetStride => {
                self.draw_using_complex_set_stride(&commands, *cmd_buffer, *graphics_pipeline_ds, &buffers)
            }
            VertexIndexMode::UseAllVertexIndexBinds => {
                let pipeline = graphics_pipeline
                    .as_ref()
                    .map_or_else(vk::Pipeline::null, |pipeline| **pipeline);
                self.draw_using_all_vertex_index_binds(
                    &commands,
                    *cmd_buffer,
                    pipeline,
                    *graphics_pipeline_ds,
                    &buffers,
                )
            }
        }
        end_render_pass(device, *cmd_buffer);
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, context.get_universal_queue(), *cmd_buffer)?;

        let result = read_color_attachment(
            context,
            color_image.get(),
            format,
            image_extent,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let pixels = result.data();

        // Every second pair of fragments in the middle row: four red fragments and four black ones, interleaved
        let mut test_passed = true;
        for index in 0..buffer_count * 2 {
            let x = index * 4 + 1;
            let y = (image_extent.1 / 2) as usize;
            let red_result = pixels[(y * image_extent.0 as usize + x) * 4];
            if index % 2 == 1 {
                test_passed &= red_result < 2;
            } else {
                test_passed &= red_result > 253;
            }
        }
        Ok(if test_passed {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

/// `BufferAddressCommandFlagsTestInstance` with `COPY_TO_MEMORY_WITH_UNBOUND_RANGES` and `COPY_FROM_MEMORY_WITH_UNBOUND_RANGES`: copies to and from a sparse
/// buffer with unbound ranges. Registered with upstream's `checkSupport` and then NotPorted.
struct SparseUnboundRangesCase {
    name: &'static str,
    copy_to_memory: bool,
}

impl TestCase for SparseUnboundRangesCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        device_address_commands::check_support(context)?;
        if self.copy_to_memory {
            context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
        }

        let features = context.get_device_features();
        if features.sparse_binding == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature sparseBinding not supported".to_string(),
            ));
        }
        if features.sparse_residency_buffer == vk::FALSE {
            return Err(TestError::NotSupported(
                "Core feature sparseResidencyBuffer not supported".to_string(),
            ));
        }
        Err(TestError::NotPorted(
            "device address copies with unbound sparse ranges".to_string(),
        ))
    }

    fn programs(&self) -> BinaryCollection {
        BinaryCollection::new(&[])
    }

    fn is_stub(&self) -> bool {
        true
    }

    fn create_instance<'a>(&'a self, _context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(SparseUnboundRangesInstance)
    }
}

struct SparseUnboundRangesInstance;

impl TestInstance for SparseUnboundRangesInstance {
    fn iterate(&mut self) -> TestOutcome {
        Err(TestError::NotPorted(
            "device address copies with unbound sparse ranges".to_string(),
        ))
    }
}

/// `createDeviceAddressCommandsTests`
pub fn create_device_address_commands_tests() -> TestCaseGroup {
    let mut misc_tests = TestCaseGroup::new("misc");
    for (name, mode) in [
        ("use_all_vertex_index_binds", VertexIndexMode::UseAllVertexIndexBinds),
        ("basic_set_stride", VertexIndexMode::BasicSetStride),
        ("complex_set_stride", VertexIndexMode::ComplexSetStride),
    ] {
        misc_tests.add_child(Box::new(VertexIndexBindingCase { name, mode }) as Box<dyn TestCase>);
    }
    misc_tests.add_child(Box::new(MemoryRangeBarrierCase) as Box<dyn TestCase>);
    for (name, copy_to_memory) in [
        ("copy_to_memory_with_unbound_ranges", true),
        ("copy_from_memory_with_unbound_ranges", false),
    ] {
        misc_tests.add_child(Box::new(SparseUnboundRangesCase { name, copy_to_memory }) as Box<dyn TestCase>);
    }
    let mut main_group = TestCaseGroup::new("device_address");
    main_group.add_child(misc_tests);
    main_group
}
