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
// Modifications: rewritten in Rust for hodow_cts. `DynamicOffsetMixedTest`, the `combined_descriptors` group of
// `dynamic_offset`: one descriptor set with five dynamic bindings used by a graphics and a compute pipeline.
//
// A `tcu::Mat4` built from an array takes the array row major and stores it column major, which is how the shaders
// read it, so the matrices are transposed when written.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::pipeline_dynamic_offset::{
    DYNAMIC_OFFSET_MIXED_REVERSE_ORDER, DYNAMIC_OFFSET_MIXED_SAME_ORDER,
};
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
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const RENDER_SIZE: u32 = 32;
const CLEAR_COLOR: [f32; 4] = [0.39, 0.58, 0.93, 1.0];

#[derive(Clone, Copy)]
struct MixedParams {
    num_instances: u32,
    test_all_offsets: bool,
    reverse_order: bool,
    run_compute_first: bool,
    vertex_offset: u32,
    shared_ubo_offset: u32,
    frag_ubo_offset: u32,
    ssbo_read_offset: u32,
    ssbo_write_offset: u32,
}

struct DynamicOffsetMixedTest {
    name: String,
    params: MixedParams,
}

impl TestCase for DynamicOffsetMixedTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, _context: &Context<'_>) -> Result<(), TestError> {
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.reverse_order {
            DYNAMIC_OFFSET_MIXED_REVERSE_ORDER.programs
        } else {
            DYNAMIC_OFFSET_MIXED_SAME_ORDER.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicOffsetMixedInstance {
            context,
            params: self.params,
        })
    }
}

struct DynamicOffsetMixedInstance<'a> {
    context: &'a Context<'a>,
    params: MixedParams,
}

fn align_up(value: u32, alignment: u32) -> u32 {
    if alignment > 0 {
        (value + alignment - 1) & !(alignment - 1)
    } else {
        value
    }
}

fn vec4_bytes(v: [f32; 4]) -> Vec<u8> {
    v.iter().flat_map(|f| f.to_ne_bytes()).collect()
}

/// A `tcu::Mat4(const float[16])`: the array is row major, the bytes written are the column major storage.
fn mat4_bytes(row_major: [f32; 16]) -> Vec<u8> {
    let mut bytes = Vec::with_capacity(64);
    for col in 0..4 {
        for row in 0..4 {
            bytes.extend_from_slice(&row_major[row * 4 + col].to_ne_bytes());
        }
    }
    bytes
}

fn create_host_buffer_of_size<'a>(
    context: &'a Context<'a>,
    size: u32,
    usage: vk::BufferUsageFlags,
) -> Result<BufferWithMemory<'a>, TestError> {
    BufferWithMemory::new(
        context.get_device(),
        context.get_default_allocator(),
        make_buffer_create_info(size as vk::DeviceSize, usage),
        MemoryRequirement::HOST_VISIBLE,
    )
}

fn write_at(buffer: &BufferWithMemory<'_>, offset: u32, bytes: &[u8]) {
    unsafe {
        std::ptr::copy_nonoverlapping(
            bytes.as_ptr(),
            buffer.get_allocation().get_host_ptr().add(offset as usize),
            bytes.len(),
        )
    };
}

fn compare_vectors(first: [f32; 4], second: [f32; 4], tolerance: f32) -> bool {
    (0..4).all(|i| (first[i] - second[i]).abs() <= tolerance)
}

impl TestInstance for DynamicOffsetMixedInstance<'_> {
    /// `DynamicOffsetMixedTestInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let p = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let output_color_format = vk::Format::R8G8B8A8_UNORM;

        // Create shaders
        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("frag")?)?;
        let compute_shader_module = create_shader_module(device, binaries.get("comp")?)?;

        // Descriptor pool and descriptor set
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC, 3)
            .add_type(vk::DescriptorType::STORAGE_BUFFER_DYNAMIC, 2)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;

        let ubo = vk::DescriptorType::UNIFORM_BUFFER_DYNAMIC;
        let ssbo = vk::DescriptorType::STORAGE_BUFFER_DYNAMIC;
        let layout_builder = if !p.reverse_order {
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(ubo, vk::ShaderStageFlags::VERTEX)
                .add_single_binding(ubo, vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(ssbo, vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(ubo, vk::ShaderStageFlags::FRAGMENT)
                .add_single_binding(ssbo, vk::ShaderStageFlags::COMPUTE)
        } else {
            DescriptorSetLayoutBuilder::new()
                .add_single_binding(ssbo, vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(ubo, vk::ShaderStageFlags::FRAGMENT)
                .add_single_binding(ssbo, vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(ubo, vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::COMPUTE)
                .add_single_binding(ubo, vk::ShaderStageFlags::VERTEX)
        };
        let descriptor_set_layout = layout_builder.build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        // Color image and render pass
        let color_image = ImageWithBuffer::new(
            context,
            RENDER_SIZE,
            RENDER_SIZE,
            output_color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let render_pass = make_color_render_pass(
            device,
            output_color_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_image.view], RENDER_SIZE, RENDER_SIZE, 1)?;

        // Create pipeline layout
        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Create graphics pipeline
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
        state.rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .line_width(1.0)
            .build();
        let graphics_pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
                (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
            ],
            &state,
        )?;

        // Create compute pipeline
        let compute_stage = vk::PipelineShaderStageCreateInfo::builder()
            .stage(vk::ShaderStageFlags::COMPUTE)
            .module(*compute_shader_module)
            .name(b"main\0")
            .build();
        let compute_pipeline_info = vk::ComputePipelineCreateInfo::builder()
            .stage(compute_stage)
            .layout(*pipeline_layout)
            .base_pipeline_index(-1)
            .build();
        let compute_pipelines =
            unsafe { device.create_compute_pipelines(vk::PipelineCache::null(), &[compute_pipeline_info], None) }
                .vk_check("vkCreateComputePipelines")?;
        let compute_pipeline = Unique::new(device, compute_pipelines.0[0]);

        let limits = &context.get_device_properties().limits;

        // Create vertex buffer
        let num_vertices = 6u32;
        let instance_size = (p.num_instances as f32).sqrt() as u32;
        let pos_increment = 1.0 / p.num_instances as f32 * instance_size as f32;
        // Result image has to be a square and multiple of 16.
        debug_assert!(instance_size * instance_size == p.num_instances && p.num_instances.is_multiple_of(16));
        let vertex_buffer = create_host_buffer_of_size(context, 256, vk::BufferUsageFlags::VERTEX_BUFFER)?;
        {
            let vertex_color = [0.0f32, 0.5, 0.0, 1.0];
            let positions = [
                [pos_increment, -pos_increment, 0.0, 1.0],
                [-pos_increment, -pos_increment, 0.0, 1.0],
                [-pos_increment, pos_increment, 0.0, 1.0],
                [-pos_increment, pos_increment, 1.0, 1.0],
                [pos_increment, pos_increment, 1.0, 1.0],
                [pos_increment, -pos_increment, 1.0, 1.0],
            ];
            let bytes: Vec<u8> = positions
                .iter()
                .flat_map(|position| vec4_bytes(*position).into_iter().chain(vec4_bytes(vertex_color)))
                .collect();
            write_at(&vertex_buffer, 0, &bytes);
            flush_alloc(device, vertex_buffer.get_allocation())?;
        }

        // Prepare buffers
        let buffer_element_size_vec4 = 16u32;
        let buffer_element_size_mat4 = 64u32;
        let min_ubo_alignment = limits.min_uniform_buffer_offset_alignment as u32;
        let min_ssbo_alignment = limits.min_storage_buffer_offset_alignment as u32;
        let ubo_dynamic_alignment_vec4 = align_up(buffer_element_size_vec4, min_ubo_alignment);
        let ubo_dynamic_alignment_mat4 = align_up(buffer_element_size_mat4, min_ubo_alignment);
        let ssbo_dynamic_alignment_vec4 = align_up(buffer_element_size_vec4, min_ssbo_alignment);
        let ssbo_dynamic_alignment_mat4 = align_up(buffer_element_size_mat4, min_ssbo_alignment);

        let ubo_buffer_vertex = create_host_buffer_of_size(
            context,
            p.num_instances * ubo_dynamic_alignment_vec4,
            vk::BufferUsageFlags::UNIFORM_BUFFER,
        )?;
        let ubo_buffer_shared = create_host_buffer_of_size(
            context,
            p.num_instances * ubo_dynamic_alignment_vec4,
            vk::BufferUsageFlags::UNIFORM_BUFFER,
        )?;
        let ssbo_buffer_write = create_host_buffer_of_size(
            context,
            p.num_instances * ssbo_dynamic_alignment_vec4,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        )?;
        let ubo_buffer_frag = create_host_buffer_of_size(
            context,
            p.num_instances * ubo_dynamic_alignment_mat4,
            vk::BufferUsageFlags::UNIFORM_BUFFER,
        )?;
        let ssbo_buffer_read = create_host_buffer_of_size(
            context,
            p.num_instances * ssbo_dynamic_alignment_mat4,
            vk::BufferUsageFlags::STORAGE_BUFFER,
        )?;

        let color_increment = 1.0 / p.num_instances as f32;
        let mut const_vertex_offsets = Vec::new();
        let mut column_count = 0u32;
        let mut column_offset = pos_increment;
        let mut row_offset = -1.0 + pos_increment;
        for _ in 0..p.num_instances {
            const_vertex_offsets.push([-1.0 + column_offset, row_offset, 0.0, 0.0]);
            column_offset += 2.0 * pos_increment;
            column_count += 1;
            if column_count >= instance_size {
                column_count = 0;
                column_offset = pos_increment;
                row_offset += 2.0 * pos_increment;
            }
        }

        // Fill buffers
        for pos_id in 0..p.num_instances {
            let id_f = (pos_id + 1) as f32;
            let (frag_mat, read_mat, shared_color): ([f32; 16], [f32; 16], [f32; 4]);
            if p.test_all_offsets {
                let ci = color_increment;
                frag_mat = [ci, ci, ci, ci, ci, ci, ci, ci, ci, ci, ci, ci, ci, ci, ci, ci * id_f];
                read_mat = [
                    1.0,
                    0.0,
                    1.0,
                    0.0,
                    0.0,
                    1.0,
                    0.0,
                    1.0 - ci * id_f,
                    1.0,
                    0.0,
                    1.0,
                    0.17,
                    0.0,
                    1.0,
                    0.0,
                    1.0,
                ];
                shared_color = [ci * id_f, 0.0, 0.0, 1.0];
            } else {
                frag_mat = [
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    if p.frag_ubo_offset == pos_id { 1.0 } else { 0.0 },
                ];
                read_mat = [
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    if p.ssbo_read_offset == pos_id { 0.25 } else { 0.0 },
                    0.0,
                    0.0,
                    0.0,
                    if p.ssbo_read_offset == pos_id { 0.17 } else { 0.0 },
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                ];
                shared_color = if p.shared_ubo_offset == pos_id {
                    [1.0, 0.0, 0.0, 1.0]
                } else {
                    [0.0; 4]
                };
            }
            write_at(
                &ubo_buffer_vertex,
                ubo_dynamic_alignment_vec4 * pos_id,
                &vec4_bytes(const_vertex_offsets[pos_id as usize]),
            );
            write_at(
                &ubo_buffer_shared,
                ubo_dynamic_alignment_vec4 * pos_id,
                &vec4_bytes(shared_color),
            );
            write_at(
                &ssbo_buffer_write,
                ssbo_dynamic_alignment_vec4 * pos_id,
                &vec4_bytes([0.0, 0.0, 0.0, 1.0]),
            );
            write_at(
                &ubo_buffer_frag,
                ubo_dynamic_alignment_mat4 * pos_id,
                &mat4_bytes(frag_mat),
            );
            write_at(
                &ssbo_buffer_read,
                ssbo_dynamic_alignment_mat4 * pos_id,
                &mat4_bytes(read_mat),
            );
        }
        for buffer in [
            &ubo_buffer_vertex,
            &ubo_buffer_shared,
            &ssbo_buffer_write,
            &ubo_buffer_frag,
            &ssbo_buffer_read,
        ] {
            flush_alloc(device, buffer.get_allocation())?;
        }

        // Update descriptors
        let rev = p.reverse_order;
        let descriptor_writes = [
            (
                if rev { 4 } else { 0 },
                ubo,
                ubo_buffer_vertex.get(),
                buffer_element_size_vec4,
            ),
            (
                if rev { 3 } else { 1 },
                ubo,
                ubo_buffer_shared.get(),
                buffer_element_size_vec4,
            ),
            (2, ssbo, ssbo_buffer_write.get(), buffer_element_size_vec4),
            (
                if rev { 1 } else { 3 },
                ubo,
                ubo_buffer_frag.get(),
                buffer_element_size_mat4,
            ),
            (
                if rev { 0 } else { 4 },
                ssbo,
                ssbo_buffer_read.get(),
                buffer_element_size_mat4,
            ),
        ];
        let mut update_builder = DescriptorSetUpdateBuilder::new();
        for (binding, descriptor_type, buffer, size) in descriptor_writes {
            let info = vk::DescriptorBufferInfo {
                buffer,
                offset: 0,
                range: size as vk::DeviceSize,
            };
            update_builder =
                update_builder.write_single(descriptor_set.get(), Location::binding(binding), descriptor_type, &info);
        }
        update_builder.update(device);

        // Command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        let mut run_graphics = !p.run_compute_first;
        for _ in 0..2 {
            begin_command_buffer(device, cmd)?;

            if run_graphics {
                let clear_values = [clear_value_color(CLEAR_COLOR)];
                let begin_info = vk::RenderPassBeginInfo::builder()
                    .render_pass(*render_pass)
                    .framebuffer(*framebuffer)
                    .render_area(rect_2d(RENDER_SIZE, RENDER_SIZE))
                    .clear_values(&clear_values);
                unsafe {
                    device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                    device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *graphics_pipeline);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                }
            } else {
                unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::COMPUTE, *compute_pipeline) };
            }

            let bind_point = if run_graphics {
                vk::PipelineBindPoint::GRAPHICS
            } else {
                vk::PipelineBindPoint::COMPUTE
            };
            let record_with_offsets = |offsets: &[u32]| unsafe {
                device.cmd_bind_descriptor_sets(cmd, bind_point, *pipeline_layout, 0, &[descriptor_set.get()], offsets);
                if run_graphics {
                    device.cmd_draw(cmd, num_vertices, 1, 0, 0);
                } else {
                    device.cmd_dispatch(cmd, 1, 1, 1);
                }
            };

            if p.test_all_offsets {
                for instance in 0..p.num_instances {
                    let ubo_offset_vec4 = ubo_dynamic_alignment_vec4 * instance;
                    let ubo_offset_mat4 = ubo_dynamic_alignment_mat4 * instance;
                    let ssbo_offset_vec4 = ssbo_dynamic_alignment_vec4 * instance;
                    let ssbo_offset_mat4 = ssbo_dynamic_alignment_mat4 * instance;
                    let offsets = [
                        if rev { ssbo_offset_mat4 } else { ubo_offset_vec4 },
                        if rev { ubo_offset_mat4 } else { ubo_offset_vec4 },
                        ssbo_offset_vec4,
                        if rev { ubo_offset_vec4 } else { ubo_offset_mat4 },
                        if rev { ubo_offset_vec4 } else { ssbo_offset_mat4 },
                    ];
                    record_with_offsets(&offsets);
                }
            } else {
                let offsets = [
                    if rev {
                        ssbo_dynamic_alignment_mat4 * p.ssbo_read_offset
                    } else {
                        ubo_dynamic_alignment_vec4 * p.vertex_offset
                    },
                    if rev {
                        ubo_dynamic_alignment_mat4 * p.frag_ubo_offset
                    } else {
                        ubo_dynamic_alignment_vec4 * p.shared_ubo_offset
                    },
                    ssbo_dynamic_alignment_vec4 * p.ssbo_write_offset,
                    if rev {
                        ubo_dynamic_alignment_vec4 * p.shared_ubo_offset
                    } else {
                        ubo_dynamic_alignment_mat4 * p.frag_ubo_offset
                    },
                    if rev {
                        ubo_dynamic_alignment_vec4 * p.vertex_offset
                    } else {
                        ssbo_dynamic_alignment_mat4 * p.ssbo_read_offset
                    },
                ];
                record_with_offsets(&offsets);
            }

            if run_graphics {
                unsafe { device.cmd_end_render_pass(cmd) };
                copy_image_to_buffer(
                    device,
                    cmd,
                    color_image.image.get(),
                    color_image.buffer.get(),
                    RENDER_SIZE,
                    RENDER_SIZE,
                );
            }
            run_graphics = !run_graphics;

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Check result image
        let segment_size = RENDER_SIZE / instance_size;
        let result = color_image.read_bytes(device)?;
        let image_ok = (0..RENDER_SIZE).all(|y| {
            (0..RENDER_SIZE).all(|x| {
                let expected = if p.test_all_offsets {
                    // While running test for all offsets, we create a nice gradient-like color for the pixels.
                    let color_value =
                        ((y / segment_size * instance_size + x / segment_size + 1) as f32) * color_increment;
                    [color_value, 0.5, color_value, 1.0]
                } else {
                    // At first we have to find a correct location for the drawn square.
                    let segment_count_per_row = RENDER_SIZE / segment_size;
                    let offset_y = if p.vertex_offset > segment_count_per_row {
                        p.vertex_offset / segment_count_per_row
                    } else {
                        0
                    };
                    let offset_x = if offset_y > 0 {
                        p.vertex_offset - segment_count_per_row * offset_y
                    } else {
                        p.vertex_offset
                    };
                    let pixel_offset_y = segment_size * offset_y;
                    let pixel_offset_x = segment_size * offset_x;
                    // Next, we fill the correct number of pixels with test color.
                    if x >= pixel_offset_x
                        && x < pixel_offset_x + segment_size
                        && y >= pixel_offset_y
                        && y < pixel_offset_y + segment_size
                    {
                        // While running test only for one offset, the result color for pixel is constant.
                        [1.0, 0.5, 1.0, 1.0]
                    } else {
                        [CLEAR_COLOR[0], CLEAR_COLOR[1], CLEAR_COLOR[2], 1.0]
                    }
                };
                let pixel = &result[((y * RENDER_SIZE + x) * 4) as usize..][..4];
                (0..4).all(|c| (pixel[c] as f32 / 255.0 - expected[c]).abs() <= 0.01)
            })
        });
        if !image_ok {
            return Ok(TestStatus::fail("Rendered image is not correct"));
        }

        // Check result buffer values
        invalidate_alloc(device, ssbo_buffer_write.get_allocation())?;
        for i in 0..p.num_instances {
            let ref_color = if p.test_all_offsets {
                [
                    (i + 1) as f32 * color_increment,
                    1.0 - (i + 1) as f32 * color_increment,
                    0.17,
                    1.0,
                ]
            } else if p.ssbo_write_offset == i {
                [1.0, 0.25, 0.17, 1.0]
            } else {
                [0.0, 0.0, 0.0, 1.0]
            };
            let base = unsafe {
                ssbo_buffer_write
                    .get_allocation()
                    .get_host_ptr()
                    .add((ssbo_dynamic_alignment_vec4 * i) as usize)
            };
            let out_color: [f32; 4] = unsafe { base.cast::<[f32; 4]>().read_unaligned() };
            if !compare_vectors(out_color, ref_color, 0.01) {
                log::error!("Reference: {ref_color:?}");
                log::error!("Result   : {out_color:?}");
                return Ok(TestStatus::fail("Result value is not correct"));
            }
        }

        Ok(TestStatus::pass("Success"))
    }
}

/// The `combined_descriptors` part of `createDynamicOffsetTests`.
pub fn create_combined_descriptors_tests() -> TestCaseGroup {
    let mut combined_descriptors_tests = TestCaseGroup::new("combined_descriptors");

    let orders = [("same_order", false), ("reverse_order", true)];
    // name, offset count, offsets for the vertex ubo, the shared ubo (fragment and compute), the fragment ubo, the ssbo read only and the ssbo write only
    let num_offsets: [(&str, u32, [u32; 5]); 3] = [
        ("16", 16, [15, 7, 2, 3, 5]),
        ("64", 64, [27, 22, 45, 19, 59]),
        ("256", 256, [197, 244, 110, 238, 88]),
    ];
    let pipeline_orders = [("graphics_first", false), ("compute_first", true)];

    // Run tests for all offsets
    let mut all_offsets_group = TestCaseGroup::new("all_offsets");
    let mut single_offset_group = TestCaseGroup::new("single_offset");

    for (order_name, reverse_descriptors) in orders {
        for (offsets_name, offset_count, offsets) in num_offsets {
            for (pipeline_name, compute_first) in pipeline_orders {
                let name = format!("{order_name}_{offsets_name}_{pipeline_name}");
                let all = MixedParams {
                    num_instances: offset_count,
                    test_all_offsets: true,
                    reverse_order: reverse_descriptors,
                    run_compute_first: compute_first,
                    vertex_offset: 0,
                    shared_ubo_offset: 0,
                    frag_ubo_offset: 0,
                    ssbo_read_offset: 0,
                    ssbo_write_offset: 0,
                };
                all_offsets_group.add_child(Box::new(DynamicOffsetMixedTest {
                    name: name.clone(),
                    params: all,
                }) as Box<dyn TestCase>);
                let single = MixedParams {
                    test_all_offsets: false,
                    vertex_offset: offsets[0],
                    shared_ubo_offset: offsets[1],
                    frag_ubo_offset: offsets[2],
                    ssbo_read_offset: offsets[3],
                    ssbo_write_offset: offsets[4],
                    ..all
                };
                single_offset_group
                    .add_child(Box::new(DynamicOffsetMixedTest { name, params: single }) as Box<dyn TestCase>);
            }
        }
    }
    combined_descriptors_tests.add_child(all_offsets_group);
    combined_descriptors_tests.add_child(single_offset_group);

    combined_descriptors_tests
}
