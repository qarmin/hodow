// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineDynamicOffsetTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Intel Corporation
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `graphics` and `compute` groups are here, `combined_descriptors`
// (`DynamicOffsetMixedTest`) is in `dynamic_offset_mixed_tests.rs`. The reference image of the graphics test is computed analytically instead of by
// `ReferenceRenderer`: the quads are axis aligned with edges on pixel boundaries of the 32x32 target, so every pixel is
// either entirely inside a quad or entirely outside all of them.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::KhrMaintenance6ExtensionDeviceCommands;

use crate::generated::shaders::pipeline_dynamic_offset::ALL_SHARED_PROGRAM;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::{Unique, UniqueDescriptorSet};
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{
    RenderingAttachment, begin_draw, begin_dynamic_rendering_with_load_op, end_draw, make_shader_objects,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `GroupingStrategy`
#[derive(Clone, Copy, PartialEq, Eq)]
enum GroupingStrategy {
    SingleSet,
    Multiset,
    Arrays,
}

/// `TestParams`, with the construction type left out: only monolithic pipelines are built.
#[derive(Clone, Copy)]
struct TestParams {
    descriptor_type: vk::DescriptorType,
    num_cmd_buffers: u32,
    reverse_order: bool,
    num_descriptor_set_bindings: u32,
    num_dynamic_bindings: u32,
    num_non_dynamic_bindings: u32,
    grouping_strategy: GroupingStrategy,
    bind2: bool,
}

impl TestParams {
    fn is_uniform(&self) -> bool {
        self.descriptor_type == vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC
    }

    fn num_bindings(&self) -> u32 {
        self.num_dynamic_bindings + self.num_non_dynamic_bindings
    }

    fn non_dynamic_descriptor_type(&self) -> vk::DescriptorType {
        if self.is_uniform() {
            vk::DescriptorType::UNIFORM_BUFFER
        } else {
            vk::DescriptorType::STORAGE_BUFFER
        }
    }

    /// The name of the case of the shader manifest that holds this parameter set's programs.
    fn program_name(&self, compute: bool) -> String {
        let grouping = match self.grouping_strategy {
            GroupingStrategy::SingleSet => "single_set",
            GroupingStrategy::Multiset => "multiset",
            GroupingStrategy::Arrays => "arrays",
        };
        let descriptor = if self.is_uniform() {
            "uniform_buffer"
        } else {
            "storage_buffer"
        };
        format!(
            "{}_{grouping}_{descriptor}_d{}_n{}",
            if compute { "comp" } else { "gfx" },
            self.num_dynamic_bindings,
            self.num_non_dynamic_bindings
        )
    }
}

const TEST_COLORS: [[f32; 4]; 6] = [
    [0.3, 0.0, 0.0, 1.0],
    [0.0, 0.3, 0.0, 1.0],
    [0.0, 0.0, 0.3, 1.0],
    [0.3, 0.3, 0.0, 1.0],
    [0.0, 0.3, 0.3, 1.0],
    [0.3, 0.0, 0.3, 1.0],
];
const COLOR_SIZE: vk::DeviceSize = 16;
const NUM_TEST_COLORS: u32 = 6;

/// `kColorSize` rounded up to a multiple of `alignment`, the way both tests do it.
fn color_block_size(alignment: vk::DeviceSize) -> vk::DeviceSize {
    let extra_bytes = COLOR_SIZE % alignment;
    if extra_bytes == 0 {
        COLOR_SIZE
    } else {
        COLOR_SIZE + alignment - extra_bytes
    }
}

/// The descriptor layout bindings of one test, as (binding number, descriptor type, descriptor count) in the order the
/// two instances' loops produce them, one entry per binding (or per array in the arrays grouping).
fn layout_entries(params: &TestParams) -> Vec<(u32, vk::DescriptorType, u32)> {
    let num_bindings = params.num_bindings();
    let mut entries = Vec::new();
    let mut binding = 0;
    while binding < num_bindings {
        let dynamic_desc = binding < params.num_dynamic_bindings;
        let descriptor_type = if dynamic_desc {
            params.descriptor_type
        } else {
            params.non_dynamic_descriptor_type()
        };
        let binding_number = if params.grouping_strategy == GroupingStrategy::SingleSet {
            binding
        } else {
            0
        };
        let descriptor_count = if params.grouping_strategy == GroupingStrategy::Arrays {
            if dynamic_desc {
                params.num_dynamic_bindings
            } else {
                params.num_non_dynamic_bindings
            }
        } else {
            1
        };
        entries.push((binding_number, descriptor_type, descriptor_count));

        // Skip used descriptors in array mode.
        if params.grouping_strategy == GroupingStrategy::Arrays {
            binding = if dynamic_desc {
                params.num_dynamic_bindings - 1
            } else {
                num_bindings
            };
        }
        binding += 1;
    }
    entries
}

/// The descriptor set layouts the entries make: one layout with all of them for a single set, one layout per entry
/// otherwise.
fn create_set_layouts<'a>(
    device: &'a Device,
    params: &TestParams,
    entries: &[(u32, vk::DescriptorType, u32)],
    stages: vk::ShaderStageFlags,
) -> Result<Vec<Unique<'a, vk::DescriptorSetLayout>>, TestError> {
    let mut layouts = Vec::new();
    if params.grouping_strategy == GroupingStrategy::SingleSet {
        let mut builder = DescriptorSetLayoutBuilder::new();
        for &(binding, descriptor_type, count) in entries {
            builder = builder.add_indexed_binding(descriptor_type, stages, binding, count);
        }
        layouts.push(builder.build(device)?);
    } else {
        for &(binding, descriptor_type, count) in entries {
            layouts.push(
                DescriptorSetLayoutBuilder::new()
                    .add_indexed_binding(descriptor_type, stages, binding, count)
                    .build(device)?,
            );
        }
    }
    Ok(layouts)
}

/// Where the descriptor of binding `binding` of the test lives: (set index, binding number, array element).
fn descriptor_location(params: &TestParams, binding: u32) -> (usize, u32, u32) {
    let dynamic_desc = binding < params.num_dynamic_bindings;
    match params.grouping_strategy {
        GroupingStrategy::SingleSet => (0, binding, 0),
        GroupingStrategy::Multiset => (binding as usize, 0, 0),
        GroupingStrategy::Arrays => (
            if dynamic_desc { 0 } else { 1 },
            0,
            if dynamic_desc {
                binding
            } else {
                binding - params.num_dynamic_bindings
            },
        ),
    }
}

/// `vkCmdBindDescriptorSets` or `vkCmdBindDescriptorSets2KHR`
fn bind_descriptor_sets(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    bind_point: vk::PipelineBindPoint,
    stage_flags: vk::ShaderStageFlags,
    layout: vk::PipelineLayout,
    sets: &[vk::DescriptorSet],
    offsets: &[u32],
    bind2: bool,
) {
    if bind2 {
        let info = vk::BindDescriptorSetsInfo {
            s_type: vk::StructureType::BIND_DESCRIPTOR_SETS_INFO,
            next: std::ptr::null(),
            stage_flags,
            layout,
            first_set: 0,
            descriptor_set_count: sets.len() as u32,
            descriptor_sets: sets.as_ptr(),
            dynamic_offset_count: offsets.len() as u32,
            dynamic_offsets: offsets.as_ptr(),
        };
        unsafe { device.cmd_bind_descriptor_sets2_khr(cmd_buffer, &info) };
    } else {
        unsafe { device.cmd_bind_descriptor_sets(cmd_buffer, bind_point, layout, 0, sets, offsets) };
    }
}

/// The buffer holding the test colours, each `color_block_input_size` bytes apart.
fn create_color_buffer<'a>(
    context: &'a Context<'a>,
    params: &TestParams,
    buffer_size: vk::DeviceSize,
    color_block_input_size: vk::DeviceSize,
) -> Result<BufferWithMemory<'a>, TestError> {
    let device = context.get_device();
    let mut host_buffer = vec![0u8; buffer_size as usize];
    for (color_idx, color) in TEST_COLORS.iter().enumerate() {
        let bytes: Vec<u8> = color.iter().flat_map(|c| c.to_ne_bytes()).collect();
        let start = color_block_input_size as usize * color_idx;
        host_buffer[start..start + bytes.len()].copy_from_slice(&bytes);
    }
    let usage = if params.is_uniform() {
        vk::BufferUsageFlags::UNIFORM_BUFFER
    } else {
        vk::BufferUsageFlags::STORAGE_BUFFER
    };
    let buffer = BufferWithMemory::new(
        device,
        context.get_default_allocator(),
        make_buffer_create_info(buffer_size, usage),
        MemoryRequirement::HOST_VISIBLE,
    )?;
    unsafe {
        std::ptr::copy_nonoverlapping(
            host_buffer.as_ptr(),
            buffer.get_allocation().get_host_ptr(),
            host_buffer.len(),
        )
    };
    flush_alloc(device, buffer.get_allocation())?;
    Ok(buffer)
}

/// Writes the descriptors of the colour buffer into the sets, one per binding.
fn update_color_descriptors(
    device: &Device,
    params: &TestParams,
    sets: &[UniqueDescriptorSet<'_>],
    buffer: vk::Buffer,
    binding_offset: vk::DeviceSize,
) {
    let non_dynamic_descriptor_type = params.non_dynamic_descriptor_type();
    for binding in 0..params.num_bindings() {
        let dynamic_desc = binding < params.num_dynamic_bindings;
        let descriptor_type = if dynamic_desc {
            params.descriptor_type
        } else {
            non_dynamic_descriptor_type
        };
        let descriptor_buffer_info = vk::DescriptorBufferInfo {
            buffer,
            offset: binding_offset * binding as u64,
            range: COLOR_SIZE,
        };
        let (set_index, binding_number, dst_array_element) = descriptor_location(params, binding);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                sets[set_index].get(),
                Location::binding_array_element(binding_number, dst_array_element),
                descriptor_type,
                &descriptor_buffer_info,
            )
            .update(device);
    }
}

fn add_colors(colors: &[[f32; 4]]) -> [f32; 4] {
    let mut sum = [0.0f32; 4];
    for color in colors {
        for c in 0..4 {
            sum[c] += color[c];
        }
    }
    sum
}

/// The colour a quad (or output slot) `index` should end up with.
fn reference_color(params: &TestParams, index: u32) -> [f32; 4] {
    let binding_offset = NUM_TEST_COLORS / params.num_bindings();
    let mut ref_color = [0.0f32; 4];
    for binding in 0..params.num_dynamic_bindings {
        ref_color = add_colors(&[
            ref_color,
            TEST_COLORS[(index + binding * binding_offset + binding) as usize],
        ]);
    }
    for binding in 0..params.num_non_dynamic_bindings {
        ref_color = add_colors(&[
            ref_color,
            TEST_COLORS[((params.num_dynamic_bindings + binding) * binding_offset) as usize],
        ]);
    }
    ref_color[3] = 1.0;
    ref_color
}

// ---------------------------------------------------------------------------------------------------------------------
// graphics
// ---------------------------------------------------------------------------------------------------------------------

const RENDER_SIZE: u32 = 32;

struct DynamicOffsetCase {
    name: &'static str,
    params: TestParams,
    compute: bool,
}

impl TestCase for DynamicOffsetCase {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.bind2 {
            context.require_device_functionality("VK_KHR_maintenance6")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let name = self.params.program_name(self.compute);
        ALL_SHARED_PROGRAM
            .iter()
            .find(|program| program.name == name)
            .unwrap_or_else(|| panic!("the shader manifest has no case named {name}"))
            .programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicOffsetInstance {
            context,
            params: self.params,
            compute: self.compute,
        })
    }
}

struct DynamicOffsetInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
    compute: bool,
}

impl TestInstance for DynamicOffsetInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        if self.compute {
            self.iterate_compute()
        } else {
            self.iterate_graphics()
        }
    }
}

/// `createQuads`: two triangles per quad, `size` wide, quads half an NDC unit apart plus one NDC unit per index.
fn create_quads(num_quads: u32, size: f32) -> Vec<[[f32; 4]; 2]> {
    let mut vertices = Vec::new();
    for quad_ndx in 0..num_quads {
        let x_offset = -0.5 + quad_ndx as f32;
        let color = [0.0f32; 4];
        let lower_left = [[-size + x_offset, -size, 0.0, 1.0], color];
        let lower_right = [[size + x_offset, -size, 0.0, 1.0], color];
        let upper_left = [[-size + x_offset, size, 0.0, 1.0], color];
        let upper_right = [[size + x_offset, size, 0.0, 1.0], color];

        vertices.push(lower_left);
        vertices.push(lower_right);
        vertices.push(upper_left);
        vertices.push(upper_left);
        vertices.push(lower_right);
        vertices.push(upper_right);
    }
    vertices
}

impl DynamicOffsetInstance<'_> {
    /// `DynamicOffsetGraphicsTestInstance::init` and `iterate`
    fn iterate_graphics(&self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let num_bindings = params.num_bindings();
        let vertices = create_quads(params.num_descriptor_set_bindings * params.num_cmd_buffers, 0.25);

        let limits = &context.get_device_properties().limits;
        let alignment = if params.is_uniform() {
            limits.min_uniform_buffer_offset_alignment
        } else {
            limits.min_storage_buffer_offset_alignment
        };
        let color_block_input_size = color_block_size(alignment);
        let buffer_size = color_block_input_size * NUM_TEST_COLORS as u64;
        let binding_offset = buffer_size / num_bindings as u64;

        // Create color image
        let color_image = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;

        // Create render passes, the first pass clears the output image, and the second one draws on top of the first pass.
        let mut render_passes = Vec::new();
        let mut framebuffers = Vec::new();
        for render_pass_idx in 0..params.num_cmd_buffers as usize {
            let load_op = [vk::AttachmentLoadOp::CLEAR, vk::AttachmentLoadOp::LOAD][render_pass_idx];
            let initial_layout =
                [vk::ImageLayout::UNDEFINED, vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL][render_pass_idx];
            let render_pass = make_color_render_pass(
                device,
                color_format,
                load_op,
                vk::AttachmentStoreOp::STORE,
                initial_layout,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            )?;
            framebuffers.push(make_framebuffer(
                device,
                *render_pass,
                &[*color_image.view],
                RENDER_SIZE,
                RENDER_SIZE,
                1,
            )?);
            render_passes.push(render_pass);
        }

        // Create pipeline layout
        let entries = layout_entries(&params);
        let descriptor_set_layouts = create_set_layouts(device, &params, &entries, vk::ShaderStageFlags::VERTEX)?;
        let set_layout_handles: Vec<vk::DescriptorSetLayout> =
            descriptor_set_layouts.iter().map(|layout| layout.get()).collect();
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layout_handles);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Create buffer
        let buffer = create_color_buffer(context, &params, buffer_size, color_block_input_size)?;

        // Create descriptor pool and sets
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(params.descriptor_type, params.num_dynamic_bindings)
            .add_type(params.non_dynamic_descriptor_type(), params.num_non_dynamic_bindings)
            .build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                descriptor_set_layouts.len() as u32,
            )?;
        let mut descriptor_sets = Vec::new();
        for layout in &descriptor_set_layouts {
            descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, layout.get())?);
        }
        let descriptor_sets_plain: Vec<vk::DescriptorSet> = descriptor_sets.iter().map(|set| set.get()).collect();

        // Update descriptor sets
        update_color_descriptors(device, &params, &descriptor_sets, buffer.get(), binding_offset);

        // Create shaders
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("frag")?)?;

        // Create pipelines
        let mut state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: 32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        state.attributes = vec![
            vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            },
            vk::VertexInputAttributeDescription {
                location: 1,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 16,
            },
        ];
        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &set_layout_handles, &[])?;
        let mut graphics_pipelines = Vec::new();
        if shader_objects.is_none() {
            for render_pass in &render_passes {
                graphics_pipelines.push(create_draw_pipeline(
                    device,
                    *pipeline_layout,
                    **render_pass,
                    &[
                        (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
                        (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
                    ],
                    &state,
                )?);
            }
        }

        // Create vertex buffer
        let vertex_bytes: Vec<u8> = vertices
            .iter()
            .flat_map(|vertex| vertex.iter().flatten().flat_map(|f| f.to_ne_bytes()))
            .collect();
        let vertex_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                vertex_bytes.len() as vk::DeviceSize,
                vk::BufferUsageFlags::VERTEX_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex_bytes.as_ptr(),
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_bytes.len(),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Create command pool and command buffers
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let mut cmd_buffers = Vec::new();
        for _ in 0..params.num_cmd_buffers {
            cmd_buffers.push(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::PRIMARY,
            )?);
        }

        let mut offset = 0u32;
        let mut quad_ndx = 0u32;
        for cmd_buffer_idx in 0..params.num_cmd_buffers {
            let idx = if params.reverse_order {
                params.num_cmd_buffers - cmd_buffer_idx - 1
            } else {
                cmd_buffer_idx
            } as usize;
            let cmd = *cmd_buffers[idx];
            begin_command_buffer(device, cmd)?;

            let clear_values = [clear_value_color([0.39, 0.58, 0.93, 1.0])];
            if let Some(objects) = shader_objects.as_ref() {
                // The second pass loads what the first one drew, which left the image in the attachment layout.
                if idx == 0 {
                    begin_draw(
                        device,
                        cmd,
                        Some(objects),
                        &state,
                        None,
                        *render_passes[idx],
                        *framebuffers[idx],
                        rect_2d(RENDER_SIZE, RENDER_SIZE),
                        &clear_values,
                        &[(color_image.image.get(), *color_image.view)],
                    );
                } else {
                    begin_dynamic_rendering_with_load_op(
                        device,
                        cmd,
                        rect_2d(RENDER_SIZE, RENDER_SIZE),
                        &[RenderingAttachment {
                            view: *color_image.view,
                            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                            clear_value: clear_values[0],
                        }],
                        None,
                        None,
                        vk::AttachmentLoadOp::LOAD,
                    );
                    objects.bind(cmd, &state);
                }
                unsafe { device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]) };
            } else {
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_passes[idx])
                    .framebuffer(*framebuffers[idx])
                    .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
                    .clear_values(&clear_values);
                unsafe {
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, graphics_pipelines[idx].get());
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                }
            }

            for _ in 0..params.num_descriptor_set_bindings {
                let offsets: Vec<u32> = (0..params.num_dynamic_bindings)
                    .map(|dynamic_binding_idx| offset + color_block_input_size as u32 * dynamic_binding_idx)
                    .collect();
                bind_descriptor_sets(
                    device,
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    vk::ShaderStageFlags::ALL_GRAPHICS,
                    *pipeline_layout,
                    &descriptor_sets_plain,
                    &offsets,
                    params.bind2,
                );
                offset += color_block_input_size as u32;

                // Draw quad
                unsafe { device.cmd_draw(cmd, 6, 1, 6 * quad_ndx, 0) };
                quad_ndx += 1;
            }

            end_draw(device, cmd, shader_objects.is_some());
            end_command_buffer(device, cmd)?;
        }

        for cmd_buffer in &cmd_buffers {
            submit_commands_and_wait(device, queue, **cmd_buffer)?;
        }

        // Copy the result to the buffer in a submission of its own.
        let readback_cmd = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        begin_command_buffer(device, *readback_cmd)?;
        copy_image_to_buffer(
            device,
            *readback_cmd,
            color_image.image.get(),
            color_image.buffer.get(),
            RENDER_SIZE,
            RENDER_SIZE,
        );
        end_command_buffer(device, *readback_cmd)?;
        submit_commands_and_wait(device, queue, *readback_cmd)?;
        let result = color_image.read_bytes(device)?;

        // Reference image: the clear color with every quad painted over it.
        let clear_texel = [0.39f32, 0.58, 0.93, 1.0].map(|c| (c * 255.0).round() as u8);
        let mut reference = vec![clear_texel; (RENDER_SIZE * RENDER_SIZE) as usize];
        let num_quads = vertices.len() as u32 / 6;
        for quad_idx in 0..num_quads {
            let texel = reference_color(&params, quad_idx).map(|c| (c * 255.0).round() as u8);
            let x_offset = -0.5 + quad_idx as f32;
            let to_pixels = |ndc: f32| ((ndc + 1.0) / 2.0 * RENDER_SIZE as f32).round() as i32;
            let (x_begin, x_end) = (
                to_pixels(-0.25 + x_offset).max(0),
                to_pixels(0.25 + x_offset).min(RENDER_SIZE as i32),
            );
            let (y_begin, y_end) = (to_pixels(-0.25).max(0), to_pixels(0.25).min(RENDER_SIZE as i32));
            for y in y_begin..y_end {
                for x in x_begin..x_end {
                    reference[(y as u32 * RENDER_SIZE + x as u32) as usize] = texel;
                }
            }
        }

        // Compare result with reference image
        let compare_ok = reference
            .iter()
            .zip(result.chunks_exact(4))
            .all(|(expected, pixel)| (0..4).all(|c| (expected[c] as i32 - pixel[c] as i32).abs() <= 2));
        Ok(if compare_ok {
            TestStatus::pass("Result image matches reference")
        } else {
            TestStatus::fail("Image mismatch")
        })
    }

    /// `DynamicOffsetComputeTestInstance::init`, `iterate` and `verifyOutput`
    fn iterate_compute(&self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let limits = &context.get_device_properties().limits;

        let num_bindings = params.num_bindings();
        let num_output_colors = params.num_cmd_buffers * params.num_descriptor_set_bindings;
        let color_block_input_size = color_block_size(if params.is_uniform() {
            limits.min_uniform_buffer_offset_alignment
        } else {
            limits.min_storage_buffer_offset_alignment
        });
        let color_block_input_size_u32 = color_block_input_size as u32;
        let color_block_output_size = color_block_size(limits.min_storage_buffer_offset_alignment);
        let color_block_output_size_u32 = color_block_output_size as u32;
        let buffer_size = color_block_input_size * NUM_TEST_COLORS as u64;
        let binding_offset = buffer_size / num_bindings as u64;
        let output_buffer_size = color_block_output_size * num_output_colors as u64;

        // Descriptor set layouts: the inputs, then the dynamic storage buffer the output goes to.
        let mut entries = layout_entries(&params);
        let binding_number_output = if params.grouping_strategy == GroupingStrategy::SingleSet {
            num_bindings
        } else {
            0
        };
        entries.push((binding_number_output, vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, 1));
        let descriptor_set_layouts = create_set_layouts(device, &params, &entries, vk::ShaderStageFlags::COMPUTE)?;
        let set_layout_handles: Vec<vk::DescriptorSetLayout> =
            descriptor_set_layouts.iter().map(|layout| layout.get()).collect();
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layout_handles);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let buffer = create_color_buffer(context, &params, buffer_size, color_block_input_size)?;
        let output_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(output_buffer_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(params.descriptor_type, params.num_dynamic_bindings)
            .add_type(params.non_dynamic_descriptor_type(), params.num_non_dynamic_bindings)
            .add_type(vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, 1)
            .build(
                device,
                vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
                descriptor_set_layouts.len() as u32,
            )?;
        let mut descriptor_sets = Vec::new();
        for layout in &descriptor_set_layouts {
            descriptor_sets.push(make_descriptor_set(device, *descriptor_pool, layout.get())?);
        }
        let descriptor_sets_plain: Vec<vk::DescriptorSet> = descriptor_sets.iter().map(|set| set.get()).collect();

        update_color_descriptors(device, &params, &descriptor_sets, buffer.get(), binding_offset);

        // The output descriptor.
        {
            let descriptor_buffer_info = vk::DescriptorBufferInfo {
                buffer: output_buffer.get(),
                offset: 0,
                range: COLOR_SIZE,
            };
            let (binding_set, binding_number) = if params.grouping_strategy == GroupingStrategy::SingleSet {
                (&descriptor_sets[0], num_bindings)
            } else {
                (&descriptor_sets[descriptor_sets.len() - 1], 0)
            };
            DescriptorSetUpdateBuilder::new()
                .write_single(
                    binding_set.get(),
                    Location::binding(binding_number),
                    vk::DescriptorType::STORAGE_BUFFER_DYNAMIC,
                    &descriptor_buffer_info,
                )
                .update(device);
        }

        // Compute pipeline
        let comp_module = create_shader_module(device, context.get_binary_collection().get("compute")?)?;
        let stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*comp_module)
            .name(b"main\0")
            .build();
        let pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(-1)
            .build();
        let pipelines = unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, pipelines.0[0]);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let mut cmd_buffers = Vec::new();
        for _ in 0..params.num_cmd_buffers {
            cmd_buffers.push(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::PRIMARY,
            )?);
        }

        let mut input_offset = 0u32;
        let mut output_offset = 0u32;
        for cmd_buffer_idx in 0..params.num_cmd_buffers {
            let idx = if params.reverse_order {
                params.num_cmd_buffers - cmd_buffer_idx - 1
            } else {
                cmd_buffer_idx
            } as usize;
            let cmd = *cmd_buffers[idx];
            begin_command_buffer(device, cmd)?;
            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };

            for _ in 0..params.num_descriptor_set_bindings {
                let buffer_barrier = vk::BufferMemoryBarrier::builder()
                    .src_access_mask(vk::AccessFlags::SHADER_WRITE)
                    .dst_access_mask(vk::AccessFlags::SHADER_WRITE | vk::AccessFlags::HOST_READ)
                    .src_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .dst_queue_family_index(vk::QUEUE_FAMILY_IGNORED)
                    .buffer(output_buffer.get())
                    .offset(output_offset as u64)
                    .size(vk::WHOLE_SIZE)
                    .build();

                let mut offsets: Vec<u32> = (0..params.num_dynamic_bindings)
                    .map(|dynamic_binding_idx| input_offset + color_block_input_size_u32 * dynamic_binding_idx)
                    .collect();
                input_offset += color_block_input_size_u32;
                offsets.push(output_offset);
                output_offset += color_block_output_size_u32;

                bind_descriptor_sets(
                    device,
                    cmd,
                    vk::PipelineBindPoint::COMPUTE,
                    vk::ShaderStageFlags::COMPUTE,
                    *pipeline_layout,
                    &descriptor_sets_plain,
                    &offsets,
                    params.bind2,
                );
                unsafe {
                    device.cmd_dispatch(cmd, 1, 1, 1);
                    device.cmd_pipeline_barrier(
                        cmd,
                        vk::PipelineStageFlags::COMPUTE_SHADER,
                        vk::PipelineStageFlags::COMPUTE_SHADER | vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[buffer_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }

            end_command_buffer(device, cmd)?;
        }

        for cmd_buffer in &cmd_buffers {
            submit_commands_and_wait(device, queue, **cmd_buffer)?;
        }

        // `verifyOutput`
        let block_stride = COLOR_SIZE.max(limits.min_storage_buffer_offset_alignment) as usize;
        invalidate_alloc(device, output_buffer.get_allocation())?;
        for i in 0..num_output_colors {
            let reference = reference_color(&params, i);
            let base = unsafe {
                output_buffer
                    .get_allocation()
                    .get_host_ptr()
                    .add(block_stride * i as usize)
            };
            let out_color: [f32; 4] = unsafe { base.cast::<[f32; 4]>().read_unaligned() };
            if out_color != reference {
                return Ok(TestStatus::fail("Output mismatch"));
            }
        }
        Ok(TestStatus::pass("Output matches expected values"))
    }
}

/// `createDynamicOffsetTests`
pub fn create_dynamic_offset_tests() -> TestCaseGroup {
    create_dynamic_offset_tests_for(false)
}

/// The shader object types have the graphics group only (no compute, no `combined_descriptors`).
pub fn create_dynamic_offset_tests_for(shader_object: bool) -> TestCaseGroup {
    let pipeline_types = ["graphics", "compute"];
    let grouping_types = [
        ("single_set", GroupingStrategy::SingleSet),
        ("multiset", GroupingStrategy::Multiset),
        ("arrays", GroupingStrategy::Arrays),
    ];
    let descriptor_types = [
        ("uniform_buffer", vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC),
        ("storage_buffer", vk::DescriptorType::STORAGE_BUFFER_DYNAMIC),
    ];
    let num_cmd_buffers = [("numcmdbuffers_1", 1u32), ("numcmdbuffers_2", 2)];
    let reverse_orders = [("reverseorder", true), ("sameorder", false)];
    let num_descriptor_set_bindings = [("numdescriptorsetbindings_1", 1u32), ("numdescriptorsetbindings_2", 2)];
    let num_dynamic_bindings = [("numdynamicbindings_1", 1u32), ("numdynamicbindings_2", 2)];
    let num_non_dynamic_bindings = [("numnondynamicbindings_0", 0u32), ("numnondynamicbindings_1", 1)];
    let descriptor_bind_commands = [("bind", false), ("bind2", true)];

    let mut dynamic_offset_tests = TestCaseGroup::new("dynamic_offset");

    for (pipeline_type_idx, pipeline_type) in pipeline_types.iter().enumerate() {
        if shader_object && pipeline_type_idx == 1 {
            continue;
        }
        let mut pipeline_type_group = TestCaseGroup::new(*pipeline_type);

        for (grouping_name, strategy) in grouping_types {
            let mut grouping_type_group = TestCaseGroup::new(grouping_name);

            for (descriptor_name, descriptor_type) in descriptor_types {
                let mut descriptor_type_group = TestCaseGroup::new(descriptor_name);

                for (cmd_buffers_name, cmd_buffers) in num_cmd_buffers {
                    let mut num_cmd_buffers_group = TestCaseGroup::new(cmd_buffers_name);

                    for (reverse_name, reverse) in reverse_orders {
                        if cmd_buffers < 2 && reverse {
                            continue;
                        }

                        let mut reverse_order_group = TestCaseGroup::new(reverse_name);

                        for (set_bindings_name, set_bindings) in num_descriptor_set_bindings {
                            if cmd_buffers > 1 && set_bindings > 1 {
                                continue;
                            }

                            let mut num_descriptor_set_bindings_group = TestCaseGroup::new(set_bindings_name);
                            for (dynamic_name, dynamic_bindings) in num_dynamic_bindings {
                                let mut num_dynamic_bindings_group = TestCaseGroup::new(dynamic_name);

                                for (non_dynamic_name, non_dynamic_bindings) in num_non_dynamic_bindings {
                                    let mut num_non_dynamic_bindings_group = TestCaseGroup::new(non_dynamic_name);
                                    for (bind_name, bind2) in descriptor_bind_commands {
                                        let params = TestParams {
                                            descriptor_type,
                                            num_cmd_buffers: cmd_buffers,
                                            reverse_order: reverse,
                                            num_descriptor_set_bindings: set_bindings,
                                            num_dynamic_bindings: dynamic_bindings,
                                            num_non_dynamic_bindings: non_dynamic_bindings,
                                            grouping_strategy: strategy,
                                            bind2,
                                        };
                                        num_non_dynamic_bindings_group.add_child(Box::new(DynamicOffsetCase {
                                            name: bind_name,
                                            params,
                                            compute: pipeline_type_idx == 1,
                                        })
                                            as Box<dyn TestCase>);
                                    }

                                    num_dynamic_bindings_group.add_child(num_non_dynamic_bindings_group);
                                }

                                num_descriptor_set_bindings_group.add_child(num_dynamic_bindings_group);
                            }

                            reverse_order_group.add_child(num_descriptor_set_bindings_group);
                        }

                        num_cmd_buffers_group.add_child(reverse_order_group);
                    }

                    descriptor_type_group.add_child(num_cmd_buffers_group);
                }

                grouping_type_group.add_child(descriptor_type_group);
            }

            pipeline_type_group.add_child(grouping_type_group);
        }

        dynamic_offset_tests.add_child(pipeline_type_group);
    }

    // Dynamic descriptor offset test for combined descriptor sets.
    if !shader_object {
        dynamic_offset_tests.add_child(super::dynamic_offset_mixed_tests::create_combined_descriptors_tests());
    }

    dynamic_offset_tests
}
