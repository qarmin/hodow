// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/robustness/vktRobustness1VertexAccessTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Copyright (c) 2022 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The device is the Context's own (robustBufferAccess is on there), the colour
// attachment is read back in the same submission instead of through `pipeline::readColorAttachment`, and each case is a
// function that returns its `InputInfo` (the `Robustness1TestInfo::testFn` lambdas only ever forwarded one to
// `robustness1TestFn`).
//
// Draws a grid of triangles whose vertex buffers are cut short so that the last vertices read their attributes out of bounds,
// with the vertex shader outputting green when every attribute read is either what was stored or an allowed out of bounds value.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::robustness_robustness1_vertex_access::ROBUSTNESS1_VERTEX_TEST;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{make_image_memory_barrier, make_image_subresource_layers, make_image_subresource_range};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_descriptor_set, make_framebuffer};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline};
use crate::vkt::tests::robustness::robustness_util::HostBuffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

type Vec4 = [f32; 4];

/// Colour input read as expected.
const EXPECTED_COLOR: Vec4 = [0.25, 0.0, 0.75, 1.0];
/// Unused colour attributes.
const UNUSED_COLOR: Vec4 = [0.75, 0.0, 0.25, 1.0];
/// Padding, out of range accesses - never accepted as output.
const OUT_OF_RANGE_COLOR: Vec4 = [0.2, 0.2, 0.2, 1.0];

const RENDER_TARGET_SIZE: u32 = 12;

struct InputInfo {
    vertex_bindings: Vec<vk::VertexInputBindingDescription>,
    vertex_attributes: Vec<vk::VertexInputAttributeDescription>,
    data: Vec<Vec<u8>>,
    vertex_count: u32,
    indices: Vec<u32>,
}

/// `PaddedAlloc` - `count` elements with `padding` copies of one value on each side.
struct PaddedAlloc<T> {
    count: u32,
    padding: u32,
    data: Vec<T>,
}

impl<T: Copy> PaddedAlloc<T> {
    fn new(count: u32, padding: u32, padding_value: T) -> Self {
        let data = vec![padding_value; (count + 2 * padding) as usize];
        Self { count, padding, data }
    }

    fn padded_size(&self) -> u32 {
        self.data.len() as u32
    }

    fn padded_start(&self) -> u32 {
        self.padding
    }

    fn size(&self) -> u32 {
        self.count
    }

    fn set(&mut self, index: u32, value: T) {
        self.data[(self.padding + index) as usize] = value;
    }

    fn bytes_from(&self, first_element: usize, byte_count: u32) -> Vec<u8> {
        let all = unsafe {
            std::slice::from_raw_parts(
                self.data.as_ptr().cast::<u8>(),
                std::mem::size_of_val(self.data.as_slice()),
            )
        };
        let start = first_element * std::mem::size_of::<T>();
        all[start..start + byte_count as usize].to_vec()
    }

    /// `data()` with a byte size.
    fn data(&self, byte_count: u32) -> Vec<u8> {
        self.bytes_from(self.padding as usize, byte_count)
    }

    /// `paddedData()` with a byte size.
    fn padded_data(&self, byte_count: u32) -> Vec<u8> {
        self.bytes_from(0, byte_count)
    }
}

/// `GetVerticesCountForTriangles`
fn get_vertices_count_for_triangles(tiles_x: u32, tiles_y: u32) -> u32 {
    (tiles_x + 1) * (tiles_y + 1)
}

/// `GenerateTriangles` - triangles with the invalid vertices placed at the end of the buffer. Assumes `invalid_indices` to be in
/// ascending order.
fn generate_triangles(
    tiles_x: u32,
    tiles_y: u32,
    colors: &[Vec4],
    invalid_indices: &[u32],
    allocate_vertex: &mut dyn FnMut(Vec4, Vec4) -> u32,
    write_index: &mut dyn FnMut(u32),
) {
    let tiles_stride = tiles_x + 1;
    let total = tiles_stride * (tiles_y + 1);
    let last_valid_index = total - 1 - invalid_indices.len() as u32;
    let step = [1.0 / tiles_x as f32, 1.0 / tiles_y as f32];

    let mut index_mappings = vec![0u32; total as usize];
    let mut next_invalid = 0usize;
    let mut write_offset = 0usize;
    let mut next_invalid_value = invalid_indices.get(next_invalid).copied().unwrap_or(total);
    for i in 0..total {
        if i < next_invalid_value {
            index_mappings[write_offset] = i;
            write_offset += 1;
        } else {
            next_invalid += 1;
            next_invalid_value = invalid_indices.get(next_invalid).copied().unwrap_or(total);
        }
    }
    for &invalid in invalid_indices {
        index_mappings[write_offset] = invalid;
        write_offset += 1;
    }

    let mut count = 0u32;
    let mut indices = vec![0u32; total as usize];
    #[allow(clippy::explicit_counter_loop)]
    for index in 0..total {
        let mapped = index_mappings[index as usize];
        let x = mapped % tiles_stride;
        let y = mapped / tiles_stride;
        let color = colors[((x + y) as usize) % colors.len()];

        let position = [
            2.0 * x as f32 * step[0] - 1.0,
            2.0 * y as f32 * step[1] - 1.0,
            if count <= last_valid_index { 1.0 } else { 0.0 },
            1.0,
        ];
        indices[(y * tiles_stride + x) as usize] = allocate_vertex(position, color);
        count += 1;
    }
    for y in 0..tiles_y {
        for x in 0..tiles_x {
            write_index(indices[(y * tiles_stride + x) as usize]);
            write_index(indices[((y + 1) * tiles_stride + x) as usize]);
            write_index(indices[(y * tiles_stride + x + 1) as usize]);
            write_index(indices[(y * tiles_stride + x + 1) as usize]);
            write_index(indices[((y + 1) * tiles_stride + x + 1) as usize]);
            write_index(indices[((y + 1) * tiles_stride + x) as usize]);
        }
    }
}

fn binding(binding: u32, stride: u32) -> vk::VertexInputBindingDescription {
    vk::VertexInputBindingDescription {
        binding,
        stride,
        input_rate: vk::VertexInputRate::VERTEX,
    }
}

fn attribute(location: u32, binding: u32, offset: u32) -> vk::VertexInputAttributeDescription {
    vk::VertexInputAttributeDescription {
        location,
        binding,
        format: vk::Format::R32G32B32A32_SFLOAT,
        offset,
    }
}

/// `out_of_bounds_stride_0`
fn out_of_bounds_stride_0() -> InputInfo {
    #[derive(Clone, Copy)]
    #[repr(C)]
    struct Color {
        unused: Vec4,
        color: Vec4,
    }

    let total_count = get_vertices_count_for_triangles(3, 3);
    let mut positions = PaddedAlloc::<Vec4>::new(total_count, 8, OUT_OF_RANGE_COLOR);
    let mut colors = PaddedAlloc::<Color>::new(
        total_count,
        8,
        Color {
            unused: OUT_OF_RANGE_COLOR,
            color: OUT_OF_RANGE_COLOR,
        },
    );
    let mut color0 = PaddedAlloc::<Vec4>::new(1, 4, OUT_OF_RANGE_COLOR);
    color0.set(0, EXPECTED_COLOR);
    let mut indices = Vec::new();
    let mut write_index = 0u32;
    generate_triangles(
        3,
        3,
        &[UNUSED_COLOR],
        &[5, 6, 9, 10],
        &mut |position, color| {
            positions.set(write_index, position);
            colors.set(write_index, Color { unused: color, color });
            write_index += 1;
            write_index - 1
        },
        &mut |index| indices.push(index),
    );

    InputInfo {
        vertex_bindings: vec![
            binding(0, 16),
            binding(1, 0),
            binding(2, std::mem::size_of::<Color>() as u32),
        ],
        vertex_attributes: vec![
            attribute(0, 0, 0),
            attribute(1, 1, 0),
            attribute(2, 2, std::mem::offset_of!(Color, color) as u32),
        ],
        data: vec![
            positions.data(positions.size() * 16),
            color0.data(color0.size() * 16),
            colors.data(
                (colors.size() - 3) * std::mem::size_of::<Color>() as u32 - std::mem::size_of::<Vec4>() as u32 / 2,
            ),
        ],
        vertex_count: positions.size(),
        indices,
    }
}

/// `out_of_bounds_stride_16_single_buffer`
fn out_of_bounds_stride_16_single_buffer() -> InputInfo {
    #[derive(Clone, Copy)]
    #[repr(C)]
    struct Vertex {
        position: Vec4,
        unused1: Vec4,
        color1: Vec4,
        color2: Vec4,
    }

    let total_count = get_vertices_count_for_triangles(3, 3);
    let mut vertices = PaddedAlloc::<Vertex>::new(
        total_count,
        8,
        Vertex {
            position: OUT_OF_RANGE_COLOR,
            unused1: OUT_OF_RANGE_COLOR,
            color1: OUT_OF_RANGE_COLOR,
            color2: OUT_OF_RANGE_COLOR,
        },
    );
    let mut write_index = 0u32;
    let mut indices = Vec::new();
    generate_triangles(
        3,
        3,
        &[EXPECTED_COLOR],
        &[5, 6, 9, 10],
        &mut |position, color| {
            vertices.set(
                write_index,
                Vertex {
                    position,
                    unused1: UNUSED_COLOR,
                    color1: color,
                    color2: color,
                },
            );
            write_index += 1;
            write_index - 1
        },
        &mut |index| indices.push(index),
    );

    let vertex_size = std::mem::size_of::<Vertex>() as u32;
    InputInfo {
        vertex_bindings: vec![binding(0, vertex_size), binding(1, vertex_size)],
        vertex_attributes: vec![
            attribute(0, 0, std::mem::offset_of!(Vertex, position) as u32),
            attribute(1, 1, std::mem::offset_of!(Vertex, color1) as u32),
            attribute(2, 1, std::mem::offset_of!(Vertex, color2) as u32),
        ],
        data: vec![
            vertices.data(vertices.size() * vertex_size),
            vertices.data((vertices.size() - 3) * vertex_size - std::mem::size_of::<Vec4>() as u32),
        ],
        vertex_count: vertices.size(),
        indices,
    }
}

/// `out_of_bounds_stride_30_middle_of_buffer`
fn out_of_bounds_stride_30_middle_of_buffer() -> InputInfo {
    #[derive(Clone, Copy)]
    #[repr(C)]
    struct Vertex {
        position: Vec4,
        color1: Vec4,
        unused1: Vec4,
        color2: Vec4,
        unused2: Vec4,
    }

    let invalid_indices = [5u32, 6, 9, 10];
    let invalid_count = invalid_indices.len() as u32;
    let total_count = get_vertices_count_for_triangles(3, 3);
    let mut vertices = PaddedAlloc::<Vertex>::new(
        total_count,
        8,
        Vertex {
            position: OUT_OF_RANGE_COLOR,
            color1: OUT_OF_RANGE_COLOR,
            unused1: OUT_OF_RANGE_COLOR,
            color2: OUT_OF_RANGE_COLOR,
            unused2: OUT_OF_RANGE_COLOR,
        },
    );
    let mut write_index = 0u32;
    let mut indices = Vec::new();
    generate_triangles(
        3,
        3,
        &[EXPECTED_COLOR],
        &invalid_indices,
        &mut |position, color| {
            vertices.set(
                write_index,
                Vertex {
                    position,
                    color1: color,
                    unused1: UNUSED_COLOR,
                    color2: UNUSED_COLOR,
                    unused2: UNUSED_COLOR,
                },
            );
            write_index += 1;
            write_index - 1
        },
        &mut |index| indices.push(index),
    );

    let element_size = std::mem::size_of::<Vertex>() as u32;
    let padded_start_bytes = vertices.padded_start() * element_size;
    InputInfo {
        vertex_bindings: vec![binding(0, element_size), binding(1, element_size)],
        vertex_attributes: vec![
            attribute(0, 0, padded_start_bytes + std::mem::offset_of!(Vertex, position) as u32),
            attribute(1, 1, padded_start_bytes + std::mem::offset_of!(Vertex, color1) as u32),
            attribute(2, 1, padded_start_bytes + std::mem::offset_of!(Vertex, color2) as u32),
        ],
        data: vec![
            vertices.padded_data(vertices.padded_size() * element_size),
            vertices.padded_data((vertices.padded_size() - invalid_count) * element_size),
        ],
        vertex_count: vertices.size(),
        indices,
    }
}

/// `out_of_bounds_stride_8_middle_of_buffer_separate`
fn out_of_bounds_stride_8_middle_of_buffer_separate() -> InputInfo {
    // Out of range entries ('padding') need to be initialized with unusedColor as the spec allows out of range to return any
    // value from within the bound memory range.
    let invalid_indices = [5u32, 6, 9, 10];
    let invalid_count = invalid_indices.len() as u32;
    let total_count = get_vertices_count_for_triangles(3, 3);
    let mut vertices = PaddedAlloc::<Vec4>::new(total_count, 8, UNUSED_COLOR);
    let mut colors = PaddedAlloc::<Vec4>::new(2 * total_count - invalid_count, 8, UNUSED_COLOR);
    let mut write_index = 0u32;
    let mut indices = Vec::new();
    generate_triangles(
        3,
        3,
        &[EXPECTED_COLOR],
        &invalid_indices,
        &mut |position, color| {
            vertices.set(write_index, position);
            colors.set(write_index, color);
            if total_count + write_index < colors.size() {
                colors.set(total_count + write_index, color);
            }
            write_index += 1;
            write_index - 1
        },
        &mut |index| indices.push(index),
    );

    let element_size = std::mem::size_of::<Vec4>() as u32;
    InputInfo {
        vertex_bindings: vec![binding(0, element_size), binding(1, element_size)],
        vertex_attributes: vec![
            attribute(0, 0, vertices.padded_start() * element_size),
            attribute(1, 1, colors.padded_start() * element_size),
            attribute(2, 1, (colors.padded_start() + total_count) * element_size),
        ],
        data: vec![
            vertices.padded_data(vertices.padded_size() * element_size),
            colors.padded_data(colors.padded_size() * element_size),
        ],
        vertex_count: vertices.size(),
        indices,
    }
}

/// `Robustness1AccessTest` over one `Robustness1TestInfo`
struct Robustness1AccessTest {
    name: &'static str,
    input: fn() -> InputInfo,
}

impl TestCase for Robustness1AccessTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.get_device_features().robust_buffer_access == vk::FALSE {
            return Err(TestError::NotSupported(
                "robustBufferAccess not supported by this implementation".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        ROBUSTNESS1_VERTEX_TEST.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(Robustness1AccessInstance {
            context,
            input: self.input,
        })
    }
}

struct Robustness1AccessInstance<'a> {
    context: &'a Context<'a>,
    input: fn() -> InputInfo,
}

impl TestInstance for Robustness1AccessInstance<'_> {
    /// `robustness1TestFn`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let input = (self.input)();
        let size = RENDER_TARGET_SIZE;

        let color = ImageWithBuffer::new(
            context,
            size,
            size,
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            4,
        )?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);

        let attachments = [vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let color_refs = [vk::AttachmentReference {
            attachment: 0,
            layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        }];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_refs)
            .build()];
        let dependencies = [
            vk::SubpassDependency {
                src_subpass: vk::SUBPASS_EXTERNAL,
                dst_subpass: 0,
                src_stage_mask: vk::PipelineStageFlags::TOP_OF_PIPE,
                dst_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                src_access_mask: vk::AccessFlags::empty(),
                dst_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                dependency_flags: vk::DependencyFlags::BY_REGION,
            },
            vk::SubpassDependency {
                src_subpass: 0,
                dst_subpass: vk::SUBPASS_EXTERNAL,
                src_stage_mask: vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                dst_stage_mask: vk::PipelineStageFlags::TRANSFER,
                src_access_mask: vk::AccessFlags::COLOR_ATTACHMENT_READ,
                dst_access_mask: vk::AccessFlags::TRANSFER_READ,
                dependency_flags: vk::DependencyFlags::BY_REGION,
            },
        ];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .dependencies(&dependencies);
        let pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );

        // Vertex buffers and the index buffer
        let vertex_buffers = input
            .data
            .iter()
            .map(|data| {
                let buffer = HostBuffer::new(
                    context,
                    data.len() as vk::DeviceSize,
                    vk::BufferUsageFlags::VERTEX_BUFFER,
                )?;
                buffer.with_bytes_mut(|bytes| bytes[..data.len()].copy_from_slice(data));
                buffer.flush(device)?;
                Ok(buffer)
            })
            .collect::<Result<Vec<_>, TestError>>()?;

        let index_buffer = if input.indices.is_empty() {
            None
        } else {
            let index_bytes: Vec<u8> = input.indices.iter().flat_map(|index| index.to_ne_bytes()).collect();
            let buffer = HostBuffer::new(
                context,
                index_bytes.len() as vk::DeviceSize,
                vk::BufferUsageFlags::INDEX_BUFFER,
            )?;
            buffer.with_bytes_mut(|bytes| bytes[..index_bytes.len()].copy_from_slice(&index_bytes));
            buffer.flush(device)?;
            Some(buffer)
        };

        // Descriptors the pipeline layout asks for; the shaders do not use them.
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::UNIFORM_BUFFER, 4)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let mut layout_builder = DescriptorSetLayoutBuilder::new();
        for _ in &input.vertex_bindings {
            layout_builder =
                layout_builder.add_single_binding(vk::DescriptorType::UNIFORM_BUFFER, vk::ShaderStageFlags::ALL);
        }
        let descriptor_set_layout = layout_builder.build(device)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let set_layouts = [*descriptor_set_layout];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vertex-test")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("fragment-test")?)?;

        let mut pipeline_state =
            DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(size, size);
        pipeline_state.bindings = input.vertex_bindings.clone();
        pipeline_state.attributes = input.vertex_attributes.clone();
        pipeline_state.rasterization.depth_bias_enable = vk::FALSE;
        pipeline_state.rasterization.front_face = vk::FrontFace::COUNTER_CLOCKWISE;
        let stages = [
            (vk::ShaderStageFlags::VERTEX, *vertex_shader_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_shader_module),
        ];
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *pass, &stages, &pipeline_state)?;

        let framebuffer = make_framebuffer(device, *pass, &[*color.view], size, size, 1)?;

        let command_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let command_buffer = allocate_command_buffer(device, *command_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *command_buffer;

        begin_command_buffer(device, cmd)?;
        begin_render_pass(
            device,
            cmd,
            *pass,
            *framebuffer,
            make_rect_2d(0, 0, size, size),
            clear_value_color([0.0; 4]),
        );
        {
            let raw_vertex_buffers: Vec<vk::Buffer> = vertex_buffers.iter().map(|buffer| buffer.get()).collect();
            let offsets = vec![0u64; raw_vertex_buffers.len()];
            unsafe {
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[] as &[u32],
                );
                device.cmd_bind_vertex_buffers(cmd, 0, &raw_vertex_buffers, &offsets);
                if let Some(index_buffer) = &index_buffer {
                    device.cmd_bind_index_buffer(cmd, index_buffer.get(), 0, vk::IndexType::UINT32);
                    device.cmd_draw_indexed(cmd, input.indices.len() as u32, 1, 0, 0, 0);
                } else {
                    device.cmd_draw(cmd, input.vertex_count, 1, 0, 0);
                }
            }
        }
        end_render_pass(device, cmd);

        // Read the colour attachment back.
        let to_transfer = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color.image.get(),
            color_srr,
        );
        let copy_region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: size,
                height: size,
                depth: 1,
            },
        };
        let to_host = vk::MemoryBarrier::builder()
            .src_access_mask(vk::AccessFlags::TRANSFER_WRITE)
            .dst_access_mask(vk::AccessFlags::HOST_READ)
            .build();
        unsafe {
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[to_transfer],
            );
            device.cmd_copy_image_to_buffer(
                cmd,
                color.image.get(),
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color.buffer.get(),
                &[copy_region],
            );
            device.cmd_pipeline_barrier(
                cmd,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[to_host],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        let pixels = color.read_bytes(device)?;
        for (index, pixel) in pixels.chunks_exact(4).enumerate() {
            if pixel != [0, 255, 0, 255] {
                log::info!("pixel ({}, {}) is {pixel:?}", index as u32 % size, index as u32 / size);
                return Ok(TestStatus::fail("Image comparison failed."));
            }
        }
        Ok(TestStatus::pass("OK"))
    }
}

/// `createRobustness1VertexAccessTests`
pub fn create_robustness1_vertex_access_tests() -> TestCaseGroup {
    let infos: [(&'static str, fn() -> InputInfo); 4] = [
        ("out_of_bounds_stride_0", out_of_bounds_stride_0),
        (
            "out_of_bounds_stride_16_single_buffer",
            out_of_bounds_stride_16_single_buffer,
        ),
        (
            "out_of_bounds_stride_30_middle_of_buffer",
            out_of_bounds_stride_30_middle_of_buffer,
        ),
        (
            "out_of_bounds_stride_8_middle_of_buffer_separate",
            out_of_bounds_stride_8_middle_of_buffer_separate,
        ),
    ];

    let mut robustness1_access_tests = TestCaseGroup::new("robustness1_vertex_access");
    for (name, input) in infos {
        robustness1_access_tests.add_child(Box::new(Robustness1AccessTest { name, input }) as Box<dyn TestCase>);
    }
    robustness1_access_tests
}
