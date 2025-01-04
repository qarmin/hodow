// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderApiTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `_device_address` variants (VK_KHR_device_address_commands) go through the hand-written
// `vk::device_address_commands`; they do not take a seed, so the seeds of the remaining cases match upstream's.
//
// Draws a 32x64 image one framebuffer row per mesh shader workgroup with direct, indirect and indirect count mesh task draws, with
// pseudorandom block sizes, offsets and strides, and checks every pixel against the per-primitive colour the mesh shader writes.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtMeshShaderExtensionDeviceCommands;

use crate::generated::shaders::mesh_shader_api::{API_NO_TASK, API_WITH_TASK};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::device_address_commands::{
    self, ADDRESS_COMMAND_FULLY_BOUND, ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE,
    ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE, DeviceAddressRange, DrawIndirect2Info,
    DrawIndirectCount2Info, StridedDeviceAddressRange,
};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_render_pass,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline, rect_2d};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::mesh_shader::util::check_task_mesh_shader_support_ext;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawType {
    Draw,
    DrawIndirect,
    DrawIndirectCount,
}

impl DrawType {
    fn name(self) -> &'static str {
        match self {
            DrawType::Draw => "draw",
            DrawType::DrawIndirect => "draw_indirect",
            DrawType::DrawIndirectCount => "draw_indirect_count",
        }
    }
}

/// `IndirectCountLimitType`: helps test the maxDrawCount rule for the indirect count draw.
#[derive(Clone, Copy, PartialEq, Eq)]
enum IndirectCountLimitType {
    /// The actual count will be given by the count buffer.
    BufferValue,
    /// The actual count will be given by the maxDrawCount argument passed to the draw command.
    MaxCount,
}

#[derive(Clone, Copy)]
struct IndirectArgs {
    offset: u32,
    stride: u32,
}

#[derive(Clone, Copy)]
struct TestParams {
    draw_type: DrawType,
    seed: u32,
    /// Equivalent to taskCount or drawCount.
    draw_count: u32,
    /// When drawCount is set to 0, also set group count X, Y, Z to 0.
    is_group_count_zero: bool,
    /// Only used for the indirect draws.
    indirect_args: Option<IndirectArgs>,
    /// Only used for the indirect count draw.
    indirect_count_limit: Option<IndirectCountLimitType>,
    /// Only used for the indirect count draw.
    indirect_count_offset: Option<u32>,
    use_task: bool,
    use_secondary_cmd_buffer: bool,
    /// Used to test `vkCmdDrawMeshTasksIndirect2EXT` and `vkCmdDrawMeshTasksIndirectCount2EXT` of VK_KHR_device_address_commands.
    use_device_address_commands: bool,
}

/// `PushConstantData`
#[repr(C)]
#[derive(Clone, Copy, Default)]
struct PushConstantData {
    width: u32,
    height: u32,
    /// Set work group size in the X, Y or Z dimension depending on value (0, 1, 2).
    dim_mesh: u32,
    one: u32,
    /// Same as `dim_mesh`.
    dim_task: u32,
}

const OFFSET_TASK: u32 = std::mem::offset_of!(PushConstantData, one) as u32;

impl PushConstantData {
    fn get_ranges(include_task: bool) -> Vec<vk::PushConstantRange> {
        let offset_mesh = 0u32;
        let size_mesh = OFFSET_TASK;
        let size_task = std::mem::size_of::<PushConstantData>() as u32 - OFFSET_TASK;

        let mut ranges = vec![vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::MESH_EXT,
            offset: offset_mesh,
            size: size_mesh,
        }];
        if include_task {
            ranges.push(vk::PushConstantRange {
                stage_flags: vk::ShaderStageFlags::TASK_EXT,
                offset: OFFSET_TASK,
                size: size_task,
            });
        }
        ranges
    }

    fn bytes(&self) -> Vec<u8> {
        [self.width, self.height, self.dim_mesh, self.one, self.dim_task]
            .iter()
            .flat_map(|v| v.to_ne_bytes())
            .collect()
    }
}

struct MeshApiCase {
    name: String,
    params: TestParams,
}

impl TestCase for MeshApiCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MeshApiCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        check_task_mesh_shader_support_ext(context, params.use_task, true)?;

        // VUID-vkCmdDrawMeshTasksIndirectEXT-drawCount-02718
        if params.draw_type == DrawType::DrawIndirect
            && params.draw_count > 1
            && context.get_device_features().multi_draw_indirect == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: multiDrawIndirect".to_string(),
            ));
        }

        // VUID-vkCmdDrawMeshTasksIndirectCountEXT-None-04445
        if params.draw_type == DrawType::DrawIndirectCount {
            context.require_device_functionality("VK_KHR_draw_indirect_count")?;
        }

        if params.use_device_address_commands {
            device_address_commands::check_support(context)?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.use_task {
            API_WITH_TASK.programs
        } else {
            API_NO_TASK.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshApiInstance {
            context,
            params: self.params,
        })
    }
}

struct MeshApiInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// `makeStridedBuffer`
pub(super) fn make_strided_buffer<'a, T: Copy>(
    context: &'a Context<'a>,
    elements: &[T],
    offset: u32,
    stride: u32,
    usage: vk::BufferUsageFlags,
    end_padding: u32,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let element_size = std::mem::size_of::<T>() as u32;
    let actual_stride = element_size.max(stride);
    let buffer_size = offset as usize + actual_stride as usize * elements.len() + end_padding as usize;
    let memory_requirement = if usage.contains(vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS) {
        MemoryRequirement::HOST_VISIBLE | MemoryRequirement::DEVICE_ADDRESS
    } else {
        MemoryRequirement::HOST_VISIBLE
    };
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size as vk::DeviceSize, usage),
        memory_requirement,
    )?;

    let buffer_alloc = buffer.get_allocation();
    unsafe {
        let mut itr = buffer_alloc.get_host_ptr().add(offset as usize);
        for elem in elements {
            std::ptr::copy_nonoverlapping((elem as *const T).cast::<u8>(), itr, element_size as usize);
            itr = itr.add(actual_stride as usize);
        }
        if end_padding > 0 {
            std::ptr::write_bytes(itr, 0xFF, end_padding as usize);
        }
    }
    flush_alloc(device, buffer_alloc)?;

    Ok(buffer)
}

pub(super) const EXTENT: vk::Extent3D = vk::Extent3D {
    width: 32,
    height: 64,
    depth: 1,
};

/// `getIndirectCommand`
fn get_indirect_command(
    block_size: u32,
    dim_coord: u32,
    set_group_count_zero: bool,
) -> vk::DrawMeshTasksIndirectCommandEXT {
    let mut indirect_cmd = vk::DrawMeshTasksIndirectCommandEXT {
        group_count_x: 1,
        group_count_y: 1,
        group_count_z: 1,
    };

    if set_group_count_zero {
        indirect_cmd.group_count_x = 0;
        indirect_cmd.group_count_y = 0;
        indirect_cmd.group_count_z = 0;
    } else {
        match dim_coord {
            0 => indirect_cmd.group_count_x = block_size,
            1 => indirect_cmd.group_count_y = block_size,
            2 => indirect_cmd.group_count_z = block_size,
            _ => debug_assert!(false),
        }
    }

    indirect_cmd
}

impl TestInstance for MeshApiInstance<'_> {
    /// `MeshApiInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();

        let extent = EXTENT;
        let format = vk::Format::R8G8B8A8_UNORM;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];

        let color_buffer_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(format)
            .extent(extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_buffer = ImageWithMemory::new(device, alloc, color_buffer_info, MemoryRequirement::ANY)?;
        let color_buffer_view = make_image_view(device, color_buffer.get(), vk::ImageViewType::_2D, format, color_srr)?;

        // Prepare buffer containing the array of block sizes.
        let mut rnd = Random::new(params.seed);
        let vector_size = params.draw_count.max(1);
        // The indirect buffer needs to have some padding at the end. See below.
        let large_draw_count = vector_size + 1;
        let even_block_size = extent.height / vector_size;
        let mut remaining_rows = extent.height;

        let mut block_sizes: Vec<u32> = Vec::with_capacity(vector_size as usize);
        for _ in 0..vector_size - 1 {
            let block_size = rnd.get_int(1, even_block_size as i32) as u32;
            remaining_rows -= block_size;
            block_sizes.push(block_size);
        }
        block_sizes.push(remaining_rows);

        let block_sizes_buffer_size = (block_sizes.len() * std::mem::size_of::<u32>()) as vk::DeviceSize;
        let block_sizes_buffer =
            make_strided_buffer(context, &block_sizes, 0, 0, vk::BufferUsageFlags::STORAGE_BUFFER, 0)?;

        // Descriptor set layout, pool and set.
        let set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::MESH_EXT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, set_layout.get())?;

        // Update descriptor set.
        let descriptor_buffer_info = make_descriptor_buffer_info(block_sizes_buffer.get(), 0, block_sizes_buffer_size);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &descriptor_buffer_info,
            )
            .update(device);

        // Pipeline layout.
        let pc_ranges = PushConstantData::get_ranges(params.use_task);
        let set_layouts = [set_layout.get()];
        let layout_info = vk::PipelineLayoutCreateInfo::builder()
            .set_layouts(&set_layouts)
            .push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Push constants: choose used dimension coordinate pseudorandomly.
        let dim_coord = rnd.get_uint32() % 3;

        let pc_data = PushConstantData {
            width: extent.width,
            height: extent.height,
            dim_mesh: dim_coord,
            one: 1,
            dim_task: dim_coord,
        };
        let pc_bytes = pc_data.bytes();

        // Render pass and framebuffer.
        let render_pass = make_render_pass(device, format)?;
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_buffer_view],
            extent.width,
            extent.height,
            1,
        )?;

        // Pipeline.
        let binaries = context.get_binary_collection();
        let task_module = if params.use_task {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut stages = Vec::new();
        if let Some(task) = &task_module {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_module));
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        let state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(extent.width, extent.height);
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        // Command pool and buffer.
        let subpass_contents = if params.use_secondary_cmd_buffer {
            vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
        } else {
            vk::SubpassContents::INLINE
        };
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let primary_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let primary = *primary_cmd_buffer;
        let secondary_cmd_buffer = if params.use_secondary_cmd_buffer {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };
        let secondary = secondary_cmd_buffer.as_ref().map(|buffer| **buffer);
        // Holds the contents of the render pass commands.
        let rp_cmd_buffer = secondary.unwrap_or(primary);

        // Indirect and count buffers if needed.
        let mut indirect_buffer: Option<BufferWithMemory<'_>> = None;
        let mut count_buffer: Option<BufferWithMemory<'_>> = None;
        let mut indirect_buffer_address: vk::DeviceAddress = 0;
        let mut count_buffer_address: vk::DeviceAddress = 0;
        let mut indirect_buffer_size: vk::DeviceSize = 0;
        let mut count_buffer_size: vk::DeviceSize = 0;

        if params.draw_type != DrawType::Draw {
            // Indirect draws.
            let indirect_args = params.indirect_args.expect("indirect draws have indirect args");

            // Check stride and offset validity.
            debug_assert!(indirect_args.offset.is_multiple_of(4));
            debug_assert!(
                indirect_args.stride.is_multiple_of(4)
                    && (indirect_args.stride == 0
                        || indirect_args.stride >= std::mem::size_of::<vk::DrawMeshTasksIndirectCommandEXT>() as u32)
            );

            // Prepare struct vector, which will be converted to a buffer with the proper stride and offset later.
            let set_group_count_zero = params.draw_count == 0 && params.is_group_count_zero;
            let commands: Vec<vk::DrawMeshTasksIndirectCommandEXT> = block_sizes
                .iter()
                .map(|&block_size| get_indirect_command(block_size, dim_coord, set_group_count_zero))
                .collect();

            let mut usage = vk::BufferUsageFlags::INDIRECT_BUFFER;
            if params.use_device_address_commands {
                usage |= vk::BufferUsageFlags::SHADER_DEVICE_ADDRESS;
            }
            let padding = std::mem::size_of::<vk::DrawMeshTasksIndirectCommandEXT>() as u32;
            let command_size = std::mem::size_of::<vk::DrawMeshTasksIndirectCommandEXT>() as u32;
            indirect_buffer_size = indirect_args.offset as vk::DeviceSize
                + command_size.max(indirect_args.stride) as vk::DeviceSize * commands.len() as vk::DeviceSize
                + padding as vk::DeviceSize;
            let buffer = make_strided_buffer(
                context,
                &commands,
                indirect_args.offset,
                indirect_args.stride,
                usage,
                padding,
            )?;
            if params.use_device_address_commands {
                indirect_buffer_address = device_address_commands::buffer_device_address(device, buffer.get());
            }
            indirect_buffer = Some(buffer);

            // Prepare count buffer if needed.
            if params.draw_type == DrawType::DrawIndirectCount {
                let limit = params
                    .indirect_count_limit
                    .expect("indirect count draws have a count limit");
                let count_offset = params
                    .indirect_count_offset
                    .expect("indirect count draws have a count offset");

                let count_buffer_value = if limit == IndirectCountLimitType::BufferValue {
                    params.draw_count
                } else {
                    large_draw_count
                };

                let single_count = [count_buffer_value];
                count_buffer_size = count_offset as vk::DeviceSize + std::mem::size_of::<u32>() as vk::DeviceSize;
                let buffer = make_strided_buffer(
                    context,
                    &single_count,
                    count_offset,
                    std::mem::size_of::<u32>() as u32,
                    usage,
                    0,
                )?;
                if params.use_device_address_commands {
                    count_buffer_address = device_address_commands::buffer_device_address(device, buffer.get());
                }
                count_buffer = Some(buffer);
            }
        }

        // Submit commands.
        begin_command_buffer(device, primary)?;
        let clear_values = [clear_value_color(clear_color)];
        let render_pass_begin = vk::RenderPassBeginInfo::builder()
            .render_pass(*render_pass)
            .framebuffer(*framebuffer)
            .render_area(rect_2d(extent.width, extent.height))
            .clear_values(&clear_values);
        unsafe { device.cmd_begin_render_pass(primary, &render_pass_begin, subpass_contents) };

        if let Some(secondary) = secondary {
            let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                .render_pass(*render_pass)
                .subpass(0)
                .framebuffer(*framebuffer)
                .occlusion_query_enable(false);
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance_info);
            unsafe { device.begin_command_buffer(secondary, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
        }

        unsafe {
            device.cmd_bind_descriptor_sets(
                rp_cmd_buffer,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[] as &[u32],
            );
            for range in &pc_ranges {
                device.cmd_push_constants(
                    rp_cmd_buffer,
                    *pipeline_layout,
                    range.stage_flags,
                    range.offset,
                    &pc_bytes[range.offset as usize..(range.offset + range.size) as usize],
                );
            }
            device.cmd_bind_pipeline(rp_cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline.get());
        }

        let address_commands = if params.use_device_address_commands {
            Some(device_address_commands::load_commands(context)?)
        } else {
            None
        };

        match params.draw_type {
            DrawType::Draw => {
                let draw_args = get_indirect_command(params.draw_count, dim_coord, false);
                unsafe {
                    device.cmd_draw_mesh_tasks_ext(
                        rp_cmd_buffer,
                        draw_args.group_count_x,
                        draw_args.group_count_y,
                        draw_args.group_count_z,
                    )
                };
            }
            DrawType::DrawIndirect => {
                let indirect_args = params.indirect_args.expect("indirect draws have indirect args");
                let buffer = indirect_buffer.as_ref().expect("indirect buffer");
                if let Some(commands) = &address_commands {
                    let draw_indirect2 = commands.draw_mesh_tasks_indirect2.ok_or_else(|| {
                        TestError::NotSupported("vkCmdDrawMeshTasksIndirect2EXT is not exposed".to_string())
                    })?;
                    let mut draw_info = DrawIndirect2Info::new(
                        StridedDeviceAddressRange {
                            address: indirect_buffer_address + indirect_args.offset as vk::DeviceAddress,
                            size: indirect_buffer_size - indirect_args.offset as vk::DeviceSize,
                            stride: indirect_args.stride as vk::DeviceSize,
                        },
                        params.draw_count,
                    );
                    // Different valid address flags in some cases to test them.
                    draw_info.address_flags = if params.draw_count > 1 {
                        ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE
                    } else {
                        ADDRESS_COMMAND_FULLY_BOUND
                    };
                    unsafe { draw_indirect2(rp_cmd_buffer, &draw_info) };
                } else {
                    unsafe {
                        device.cmd_draw_mesh_tasks_indirect_ext(
                            rp_cmd_buffer,
                            buffer.get(),
                            indirect_args.offset as vk::DeviceSize,
                            params.draw_count,
                            indirect_args.stride,
                        )
                    };
                }
            }
            DrawType::DrawIndirectCount => {
                let indirect_args = params.indirect_args.expect("indirect draws have indirect args");
                let indirect_count_offset = params.indirect_count_offset.expect("count offset");
                let indirect_count_limit = params.indirect_count_limit.expect("count limit");

                let max_count = if indirect_count_limit == IndirectCountLimitType::MaxCount {
                    params.draw_count
                } else {
                    large_draw_count
                };
                let buffer = indirect_buffer.as_ref().expect("indirect buffer");
                let count = count_buffer.as_ref().expect("count buffer");
                if let Some(commands) = &address_commands {
                    let draw_indirect_count2 = commands.draw_mesh_tasks_indirect_count2.ok_or_else(|| {
                        TestError::NotSupported("vkCmdDrawMeshTasksIndirectCount2EXT is not exposed".to_string())
                    })?;
                    let mut draw_info = DrawIndirectCount2Info::new(
                        StridedDeviceAddressRange {
                            address: indirect_buffer_address + indirect_args.offset as vk::DeviceAddress,
                            size: indirect_buffer_size,
                            stride: indirect_args.stride as vk::DeviceSize,
                        },
                        DeviceAddressRange {
                            address: count_buffer_address + indirect_count_offset as vk::DeviceAddress,
                            size: count_buffer_size,
                        },
                        max_count,
                    );
                    // Different valid address flags in some cases to test them.
                    let address_flags = ADDRESS_COMMAND_UNKNOWN_STORAGE_BUFFER_USAGE
                        | ADDRESS_COMMAND_UNKNOWN_TRANSFORM_FEEDBACK_BUFFER_USAGE
                        | ADDRESS_COMMAND_FULLY_BOUND;
                    draw_info.address_flags = if params.use_task { 0 } else { address_flags };
                    draw_info.count_address_flags = if params.draw_count > 1 { address_flags } else { 0 };
                    unsafe { draw_indirect_count2(rp_cmd_buffer, &draw_info) };
                } else {
                    unsafe {
                        device.cmd_draw_mesh_tasks_indirect_count_ext(
                            rp_cmd_buffer,
                            buffer.get(),
                            indirect_args.offset as vk::DeviceSize,
                            count.get(),
                            indirect_count_offset as vk::DeviceSize,
                            max_count,
                            indirect_args.stride,
                        );
                    }
                }
            }
        }

        if let Some(secondary) = secondary {
            end_command_buffer(device, secondary)?;
            unsafe { device.cmd_execute_commands(primary, &[secondary]) };
        }

        unsafe { device.cmd_end_render_pass(primary) };

        // Output buffer to extract the color buffer.
        let out_buffer_size = (4 * extent.width * extent.height) as vk::DeviceSize;
        let out_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(out_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        copy_image_to_buffer(
            device,
            primary,
            color_buffer.get(),
            out_buffer.get(),
            extent.width,
            extent.height,
        );
        end_command_buffer(device, primary)?;

        submit_commands_and_wait(device, context.get_universal_queue(), primary)?;

        // Generate reference image and compare. The red and green channels get the threshold of 0.005 (1/255 < 0.005 < 2/255).
        let out_alloc = out_buffer.get_allocation();
        invalidate_alloc(device, out_alloc)?;
        let result =
            unsafe { std::slice::from_raw_parts(out_alloc.get_host_ptr().cast_const(), out_buffer_size as usize) };

        let f_height = extent.height as f32;
        let f_width = extent.width as f32;
        let to_unorm = |value: f32| (value * 255.0 + 0.5).floor() as i32;

        for y in 0..extent.height {
            for x in 0..extent.width {
                let ref_color: [i32; 4] =
                    if params.draw_count == 0 || (params.draw_type == DrawType::Draw && y >= params.draw_count) {
                        [0, 0, 0, 255]
                    } else {
                        // These match the per-primitive color set by the mesh shader.
                        [
                            to_unorm((y as f32 + 0.5) / f_height),
                            to_unorm((x as f32 + 0.5) / f_width),
                            0,
                            255,
                        ]
                    };

                let offset = ((y * extent.width + x) * 4) as usize;
                let pixel = &result[offset..offset + 4];
                let matches = (pixel[0] as i32 - ref_color[0]).abs() <= 1
                    && (pixel[1] as i32 - ref_color[1]).abs() <= 1
                    && pixel[2] as i32 == ref_color[2]
                    && pixel[3] as i32 == ref_color[3];
                if !matches {
                    log::info!(
                        "{}_draw_count_{}{}: pixel ({x}, {y}) is {pixel:?}, expected {ref_color:?}",
                        params.draw_type.name(),
                        params.draw_count,
                        if params.use_task { "_with_task" } else { "_no_task" }
                    );
                    return Ok(TestStatus::fail("Image comparison failed; check log for details"));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMeshShaderApiTestsEXT`
pub fn create_mesh_shader_api_tests_ext() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("api");

    let draw_cases = [DrawType::Draw, DrawType::DrawIndirect, DrawType::DrawIndirectCount];

    let extent = EXTENT;
    let draw_count_cases = [0u32, 1, 2, extent.height / 2, extent.height];

    let normal_stride = std::mem::size_of::<vk::DrawMeshTasksIndirectCommandEXT>() as u32;
    let large_stride = 2 * normal_stride + 4;
    let alt_offset = 20u32;

    let indirect_args_cases: [(Option<IndirectArgs>, &str); 7] = [
        (None, "no_indirect_args"),
        // Offset 0, varying strides.
        (Some(IndirectArgs { offset: 0, stride: 0 }), "offset_0_stride_0"),
        (
            Some(IndirectArgs {
                offset: 0,
                stride: normal_stride,
            }),
            "offset_0_stride_normal",
        ),
        (
            Some(IndirectArgs {
                offset: 0,
                stride: large_stride,
            }),
            "offset_0_stride_large",
        ),
        // Nonzero offset, varying strides.
        (
            Some(IndirectArgs {
                offset: alt_offset,
                stride: 0,
            }),
            "offset_alt_stride_0",
        ),
        (
            Some(IndirectArgs {
                offset: alt_offset,
                stride: normal_stride,
            }),
            "offset_alt_stride_normal",
        ),
        (
            Some(IndirectArgs {
                offset: alt_offset,
                stride: large_stride,
            }),
            "offset_alt_stride_large",
        ),
    ];

    let count_limit_cases: [(Option<IndirectCountLimitType>, &str); 3] = [
        (None, "no_count_limit"),
        (Some(IndirectCountLimitType::BufferValue), "count_limit_buffer"),
        (Some(IndirectCountLimitType::MaxCount), "count_limit_max_count"),
    ];

    let count_offset_cases: [(Option<u32>, &str); 3] = [
        (None, "no_count_offset"),
        (Some(0), "count_offset_0"),
        (Some(alt_offset), "count_offset_alt"),
    ];

    let task_cases = [(false, "no_task_shader"), (true, "with_task_shader")];

    let cmd_buffer_cases = [(false, ""), (true, "_secondary_cmd")];

    let mut seed = 1_628_678_795u32;

    for draw_case in draw_cases {
        let is_indirect = draw_case != DrawType::Draw;
        let is_indirect_no_count = draw_case == DrawType::DrawIndirect;
        let is_indirect_count = draw_case == DrawType::DrawIndirectCount;

        let mut draw_group = TestCaseGroup::new(draw_case.name());

        for draw_count_case in draw_count_cases {
            for is_group_count_zero in [true, false] {
                // Allow only valid cases with group count 0.
                if is_group_count_zero && (!is_indirect || draw_count_case != 0) {
                    continue;
                }

                let draw_count_name = format!(
                    "draw_count_{draw_count_case}{}",
                    if is_group_count_zero { "_group_count_0" } else { "" }
                );
                let mut draw_count_group = TestCaseGroup::new(&draw_count_name);

                for (indirect_args_index, (indirect_args, indirect_args_name)) in indirect_args_cases.iter().enumerate()
                {
                    let has_indirect_args = indirect_args.is_some();
                    let stride_zero = indirect_args.is_some_and(|args| args.stride == 0);

                    if is_indirect != has_indirect_args {
                        continue;
                    }

                    if ((is_indirect_no_count && draw_count_case > 1) || is_indirect_count) && stride_zero {
                        continue;
                    }

                    let mut indirect_args_group = TestCaseGroup::new(*indirect_args_name);

                    for (limit_type, count_limit_name) in count_limit_cases {
                        let has_count_limit = limit_type.is_some();

                        if is_indirect_count != has_count_limit {
                            continue;
                        }

                        let mut count_limit_group = TestCaseGroup::new(count_limit_name);

                        for (count_offset, count_offset_name) in count_offset_cases {
                            let has_count_offset_type = count_offset.is_some();

                            if is_indirect_count != has_count_offset_type {
                                continue;
                            }

                            let mut count_offset_group = TestCaseGroup::new(count_offset_name);

                            for (use_task, task_name) in task_cases {
                                for (secondary_cmd, suffix) in cmd_buffer_cases {
                                    // Reduce test combinations with group count 0.
                                    if is_group_count_zero && (indirect_args_index >= 3 || secondary_cmd) {
                                        continue;
                                    }

                                    let test_name = format!("{task_name}{suffix}");
                                    let params = TestParams {
                                        draw_type: draw_case,
                                        seed,
                                        draw_count: draw_count_case,
                                        is_group_count_zero,
                                        indirect_args: *indirect_args,
                                        indirect_count_limit: limit_type,
                                        indirect_count_offset: count_offset,
                                        use_task,
                                        use_secondary_cmd_buffer: secondary_cmd,
                                        use_device_address_commands: false,
                                    };
                                    seed += 1;

                                    count_offset_group.add_child(Box::new(MeshApiCase {
                                        name: test_name.clone(),
                                        params,
                                    })
                                        as Box<dyn TestCase>);

                                    // Limit the number of tests repeated for device address commands.
                                    if draw_case != DrawType::Draw
                                        && indirect_args_index % 2 == usize::from(secondary_cmd)
                                        && use_task == has_count_limit
                                    {
                                        count_offset_group.add_child(Box::new(MeshApiCase {
                                            name: format!("{test_name}_device_address"),
                                            params: TestParams {
                                                use_device_address_commands: true,
                                                ..params
                                            },
                                        })
                                            as Box<dyn TestCase>);
                                    }
                                }
                            }

                            count_limit_group.add_child(count_offset_group);
                        }

                        indirect_args_group.add_child(count_limit_group);
                    }

                    draw_count_group.add_child(indirect_args_group);
                }

                draw_group.add_child(draw_count_group);
            }
        }

        main_group.add_child(draw_group);
    }

    main_group
}
