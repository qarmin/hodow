// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/pipeline/vktPipelineInputAttributeOffsetTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// StrideCase determines the way we're going to store vertex data in the vertex buffer.
//
// With packed vertices the attributes follow each other: [vertex binding offset][attribute offset][attr][attr]...
// With padded vertices every attribute is followed by as many padding bytes as it has.
// With overlapping vertices the case is like packed, but the data type in the _shader_ is a vec4 stored in the buffer
// as vec2s: only the XY coordinates are properly used (ZW would belong to the next vertex).

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtVertexInputDynamicStateExtensionDeviceCommands, InstanceV1_1};

use crate::generated::shaders::pipeline_input_attribute_offset::{
    INPUT_ATTRIBUTE_OFFSET_OVERLAPPING, INPUT_ATTRIBUTE_OFFSET_TWO_BINDS, INPUT_ATTRIBUTE_OFFSET_VEC2,
    INPUT_ATTRIBUTE_OFFSET_VEC4,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{
    DrawPipelineState, ImageWithBuffer, clear_value_color, create_draw_pipeline, make_color_render_pass, rect_2d,
};
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::tests::pipeline::shader_object_draw::{begin_draw, end_draw, make_shader_objects};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum StrideCase {
    Packed,
    Padded,
    Overlapping,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DataType {
    Vec2,
    Vec4,
}

impl DataType {
    fn type_size(self) -> u32 {
        match self {
            DataType::Vec2 => 8,
            DataType::Vec4 => 16,
        }
    }
}

/// `TestParams`
#[derive(Clone, Copy)]
struct TestParams {
    /// vec2 or vec4.
    data_type: DataType,
    /// When binding vertex buffer.
    binding_offset: u32,
    /// Pack all data or include some padding.
    stride_case: StrideCase,
    /// Apply an offset when binding memory to the buffer.
    use_memory_offset: bool,
    /// Use dynamic state or not.
    dynamic: bool,
    /// None = use formula for alignment.
    optional_attribute_offset: Option<u32>,
    optional_attribute_format: vk::Format,
}

impl TestParams {
    fn attribute_size(&self) -> u32 {
        if self.optional_attribute_format == vk::Format::R8G8B8A8_SNORM {
            return 4;
        }
        self.data_type.type_size()
    }

    fn is_overlapping(&self) -> bool {
        self.stride_case == StrideCase::Overlapping
    }

    fn attribute_format(&self) -> vk::Format {
        if self.optional_attribute_format != vk::Format::UNDEFINED {
            return self.optional_attribute_format;
        }
        match self.data_type {
            DataType::Vec2 => {
                if self.is_overlapping() {
                    vk::Format::R32G32B32A32_SFLOAT
                } else {
                    vk::Format::R32G32_SFLOAT
                }
            }
            DataType::Vec4 => vk::Format::R32G32B32A32_SFLOAT,
        }
    }

    /// Given the vertex buffer binding offset, calculate the appropriate attribute offset to make them aligned.
    fn attribute_offset(&self) -> u32 {
        if let Some(offset) = self.optional_attribute_offset {
            return offset;
        }
        let attrib_size = self.attribute_size();
        debug_assert!(self.binding_offset < attrib_size);
        (attrib_size - self.binding_offset) % attrib_size
    }

    /// Calculates proper padding size between elements according to stride_case.
    fn vertex_data_padding(&self) -> u32 {
        if self.stride_case == StrideCase::Padded {
            self.attribute_size()
        } else {
            0
        }
    }

    /// Calculates proper binding stride according to stride_case.
    fn binding_stride(&self) -> u32 {
        self.attribute_size() + self.vertex_data_padding()
    }
}

fn float_to_snorm8(value: f32) -> i8 {
    let clamped = value.clamp(-1.0, 1.0);
    let scaled = clamped * 127.0;
    let rounded = (scaled + if scaled >= 0.0 { 0.5 } else { -0.5 }) as i32;
    rounded.clamp(-127, 127) as i8
}

/// `buildVertexBufferData`
fn build_vertex_buffer_data(orig_vertices: &[[f32; 2]], params: &TestParams) -> Vec<u8> {
    debug_assert!(!orig_vertices.is_empty());
    let mut vertices = orig_vertices.to_vec();

    if params.is_overlapping() {
        // Each vertex will be read as a vec4, so we need one extra element at the end to make the last vec4 read valid and avoid going beyond the end of the buffer.
        debug_assert!(params.data_type == DataType::Vec2);
        vertices.push([0.0, 0.0]);
    }

    let vertex_count = vertices.len() as u32;
    let data_size = params.binding_offset + params.attribute_offset() + vertex_count * params.binding_stride();

    let zw = [0.0f32, 1.0];
    let src_vertex_size = 8u32;
    let needs_zw = params.attribute_size() > src_vertex_size; // vec4 needs each vec2 with zw appended.
    let padding_size = params.vertex_data_padding();

    let mut data = vec![0u8; data_size as usize];
    let mut next_vertex = (params.binding_offset + params.attribute_offset()) as usize;

    for vertex in &vertices {
        if params.attribute_format() == vk::Format::R8G8B8A8_SNORM {
            let packed_vertex = [
                float_to_snorm8(vertex[0]) as u8,
                float_to_snorm8(vertex[1]) as u8,
                0,
                127,
            ];
            data[next_vertex..next_vertex + 4].copy_from_slice(&packed_vertex);
            next_vertex += 4;
        } else {
            // Copy vertex.
            data[next_vertex..next_vertex + 4].copy_from_slice(&vertex[0].to_ne_bytes());
            data[next_vertex + 4..next_vertex + 8].copy_from_slice(&vertex[1].to_ne_bytes());
            next_vertex += src_vertex_size as usize;

            // Copy extra ZW values if needed.
            if needs_zw {
                data[next_vertex..next_vertex + 4].copy_from_slice(&zw[0].to_ne_bytes());
                data[next_vertex + 4..next_vertex + 8].copy_from_slice(&zw[1].to_ne_bytes());
                next_vertex += 8;
            }
        }

        // Skip the padding bytes.
        next_vertex += padding_size as usize;
    }

    data
}

/// `generateVertices`: one triangle per pixel.
fn generate_vertices(width: u32, height: u32) -> Vec<[f32; 2]> {
    let mut vertices = Vec::with_capacity((width * height * 3) as usize); // 3 points (1 triangle) per pixel.

    // Normalized pixel width and height.
    let pixel_width = 2.0 / width as f32;
    let pixel_height = 2.0 / height as f32;
    let width_margin = pixel_width / 4.0;
    let height_margin = pixel_height / 4.0;

    for y in 0..height {
        for x in 0..width {
            // Normalized pixel center.
            let pixel_center_x = ((x as f32 + 0.5) / width as f32) * 2.0 - 1.0;
            let pixel_center_y = ((y as f32 + 0.5) / height as f32) * 2.0 - 1.0;

            vertices.push([pixel_center_x, pixel_center_y - height_margin]); // Top
            vertices.push([pixel_center_x - width_margin, pixel_center_y + height_margin]); // Bottom left.
            vertices.push([pixel_center_x + width_margin, pixel_center_y + height_margin]); // Bottom right.
        }
    }
    vertices
}

struct InputAttributeOffsetCase {
    name: &'static str,
    params: TestParams,
}

impl TestCase for InputAttributeOffsetCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `InputAttributeOffsetCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if context.is_device_functionality_supported("VK_KHR_portability_subset") {
            let mut properties = vk::PhysicalDevicePortabilitySubsetPropertiesKHR::default();
            let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut properties);
            unsafe {
                context
                    .get_instance()
                    .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
            };

            let min_stride_align = properties.min_vertex_input_binding_stride_alignment;
            let binding_stride = self.params.binding_stride();
            if binding_stride < min_stride_align || !binding_stride.is_multiple_of(min_stride_align) {
                return Err(TestError::NotSupported(format!(
                    "Binding stride {binding_stride} not a multiple of {min_stride_align}"
                )));
            }
        }

        if self.params.dynamic {
            context.require_device_functionality("VK_EXT_vertex_input_dynamic_state")?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if self.params.optional_attribute_offset.is_some() {
            INPUT_ATTRIBUTE_OFFSET_TWO_BINDS.programs
        } else if self.params.is_overlapping() {
            INPUT_ATTRIBUTE_OFFSET_OVERLAPPING.programs
        } else if self.params.data_type == DataType::Vec4 {
            INPUT_ATTRIBUTE_OFFSET_VEC4.programs
        } else {
            INPUT_ATTRIBUTE_OFFSET_VEC2.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(InputAttributeOffsetInstance {
            context,
            params: self.params,
        })
    }
}

struct InputAttributeOffsetInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

fn greatest_common_divisor(a: u64, b: u64) -> u64 {
    if b == 0 { a } else { greatest_common_divisor(b, a % b) }
}

impl TestInstance for InputAttributeOffsetInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue = context.get_universal_queue();

        const WIDTH: u32 = 4; // Multiple pixels and vertices, not too big.
        const HEIGHT: u32 = 4;
        let vertices = generate_vertices(WIDTH, HEIGHT);
        let vertex_buffer_data = build_vertex_buffer_data(&vertices, &params);
        let color_format = vk::Format::R8G8B8A8_UNORM;
        let color_usage = vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC;

        let vertex_count = vertices.len() as u32;
        let half_vertex_count = vertex_count / 2; // 24
        let stride = params.binding_stride();
        let leading_size = params.binding_offset + params.attribute_offset();
        let first_half_size = (leading_size + half_vertex_count * stride) as usize; // 24*stride
        let second_half_size = (half_vertex_count * stride) as usize; // 24*stride

        let two_binds = params.optional_attribute_offset.is_some();

        // Two buffers when the vertices are split over two bindings; otherwise one buffer bound at a chosen memory offset.
        // Field order is drop order below: the allocation has to outlive the buffer it backs.
        let mut vertex_buffer_1 = None;
        let mut vertex_buffer_2 = None;
        let mut _vertex_buffer_allocation = None;
        let mut vertex_buffer = None;
        let vertex_buffer_offset = params.binding_offset as vk::DeviceSize;
        let mut pipeline_bindings = Vec::new();
        let mut pipeline_attributes = Vec::new();

        if two_binds {
            // Buffer1: [bindingOffset][attrOffset][v0..v23]
            // Buffer2: [24*stride padding][v24..v47]
            let buffer_1_size = first_half_size as vk::DeviceSize;
            let buffer_2_size = (half_vertex_count * stride * 2) as vk::DeviceSize;
            let buffer_1 = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_1_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            let buffer_2 = BufferWithMemory::new(
                device,
                context.get_default_allocator(),
                make_buffer_create_info(buffer_2_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                let ptr1 = buffer_1.get_allocation().get_host_ptr();
                std::ptr::copy_nonoverlapping(vertex_buffer_data.as_ptr(), ptr1, first_half_size);
            }
            flush_alloc(device, buffer_1.get_allocation())?;
            unsafe {
                let ptr2 = buffer_2.get_allocation().get_host_ptr();
                std::ptr::write_bytes(ptr2, 0, second_half_size);
                std::ptr::copy_nonoverlapping(
                    vertex_buffer_data.as_ptr().add(first_half_size),
                    ptr2.add(second_half_size),
                    second_half_size,
                );
            }
            flush_alloc(device, buffer_2.get_allocation())?;
            vertex_buffer_1 = Some(buffer_1);
            vertex_buffer_2 = Some(buffer_2);
        } else {
            let vertex_buffer_size = vertex_buffer_data.len() as vk::DeviceSize;
            let buffer = Unique::new(
                device,
                unsafe {
                    device.create_buffer(
                        &make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
                        None,
                    )
                }
                .vk_check("vkCreateBuffer")?,
            );

            // Allocate and bind buffer memory.
            // If use_memory_offset is true, we'll allocate extra memory that satisfies alignment requirements for the buffer and the attributes.
            let mut vertex_buffer_reqs = unsafe { device.get_buffer_memory_requirements(*buffer) };
            let memory_offset = if params.use_memory_offset {
                let attribute_size = params.attribute_size() as u64;
                vertex_buffer_reqs.alignment / greatest_common_divisor(vertex_buffer_reqs.alignment, attribute_size)
                    * attribute_size
            } else {
                0
            };
            vertex_buffer_reqs.size += memory_offset;
            let allocation = context.get_default_allocator().allocate(
                device,
                vertex_buffer_reqs,
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe { device.bind_buffer_memory(*buffer, allocation.get_memory(), memory_offset) }
                .vk_check("vkBindBufferMemory")?;

            // Copy vertices to vertex buffer. Need to add the offset manually here.
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertex_buffer_data.as_ptr(),
                    allocation.get_host_ptr().add(memory_offset as usize),
                    vertex_buffer_data.len(),
                )
            };
            flush_alloc(device, &allocation)?;

            // Vertex input values according to test parameters.
            pipeline_bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: params.binding_stride(),
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            pipeline_attributes = vec![vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: params.attribute_format(),
                offset: params.attribute_offset(),
            }];
            vertex_buffer = Some(buffer);
            _vertex_buffer_allocation = Some(allocation);
        }

        // Color buffer.
        let color_buffer = ImageWithBuffer::new(context, WIDTH, HEIGHT, color_format, color_usage, 4)?;

        // Render pass and framebuffer.
        let render_pass = make_color_render_pass(
            device,
            color_format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        )?;
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_buffer.view], WIDTH, HEIGHT, 1)?;

        // Shaders.
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Pipeline.
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST).with_full_viewport(WIDTH, HEIGHT);
        if params.dynamic {
            state.dynamic_states = vec![vk::DynamicState::VERTEX_INPUT_EXT];
        } else {
            state.bindings = pipeline_bindings.clone();
            state.attributes = pipeline_attributes.clone();
        }
        let shader_objects = make_shader_objects(context, "vert", Some("frag"), &[], &[])?;
        let pipeline = if shader_objects.is_some() {
            None
        } else {
            Some(create_draw_pipeline(
                device,
                *pipeline_layout,
                *render_pass,
                &[
                    (vk::ShaderStageFlags::VERTEX, *vert_module),
                    (vk::ShaderStageFlags::FRAGMENT, *frag_module),
                ],
                &state,
            )?)
        };

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let clear_values = [clear_value_color([0.0, 0.0, 0.0, 0.0])];
        begin_command_buffer(device, *cmd_buffer)?;
        begin_draw(
            device,
            *cmd_buffer,
            shader_objects.as_ref(),
            &state,
            pipeline.as_ref().map(|pipeline| **pipeline),
            *render_pass,
            *framebuffer,
            rect_2d(WIDTH, HEIGHT),
            &clear_values,
            &[(color_buffer.image.get(), *color_buffer.view)],
        );
        unsafe {
            if two_binds {
                let dynamic_bindings = [
                    vk::VertexInputBindingDescription2EXT {
                        binding: 0,
                        input_rate: vk::VertexInputRate::VERTEX,
                        stride: params.binding_stride(),
                        divisor: 1,
                        ..Default::default()
                    },
                    vk::VertexInputBindingDescription2EXT {
                        binding: 1,
                        input_rate: vk::VertexInputRate::VERTEX,
                        stride: params.binding_stride(),
                        divisor: 1,
                        ..Default::default()
                    },
                ];
                let dynamic_attributes = [
                    vk::VertexInputAttributeDescription2EXT {
                        location: 0,
                        binding: 0,
                        format: params.attribute_format(),
                        offset: params.attribute_offset(),
                        ..Default::default()
                    },
                    vk::VertexInputAttributeDescription2EXT {
                        location: 1,
                        binding: 1,
                        format: params.attribute_format(),
                        offset: params.attribute_offset(),
                        ..Default::default()
                    },
                ];
                device.cmd_set_vertex_input_ext(*cmd_buffer, &dynamic_bindings, &dynamic_attributes);

                let buffer_1 = vertex_buffer_1.as_ref().expect("first vertex buffer").get();
                let buffer_2 = vertex_buffer_2.as_ref().expect("second vertex buffer").get();
                device.cmd_bind_vertex_buffers(*cmd_buffer, 0, &[buffer_1], &[params.binding_offset as vk::DeviceSize]);
                device.cmd_bind_vertex_buffers(*cmd_buffer, 1, &[buffer_2], &[0]);
                device.cmd_draw(*cmd_buffer, vertex_count, 1, 0, 0);
            } else {
                device.cmd_bind_vertex_buffers(
                    *cmd_buffer,
                    0,
                    &[**vertex_buffer.as_ref().expect("vertex buffer")],
                    &[vertex_buffer_offset],
                );
                if params.dynamic {
                    let dynamic_binding = vk::VertexInputBindingDescription2EXT {
                        binding: pipeline_bindings[0].binding,
                        input_rate: pipeline_bindings[0].input_rate,
                        stride: pipeline_bindings[0].stride,
                        divisor: 1,
                        ..Default::default()
                    };
                    let dynamic_attribute = vk::VertexInputAttributeDescription2EXT {
                        location: pipeline_attributes[0].location,
                        binding: pipeline_attributes[0].binding,
                        format: pipeline_attributes[0].format,
                        offset: pipeline_attributes[0].offset,
                        ..Default::default()
                    };
                    device.cmd_set_vertex_input_ext(*cmd_buffer, &[dynamic_binding], &[dynamic_attribute]);
                }
                device.cmd_draw(*cmd_buffer, vertices.len() as u32, 1, 0, 0);
            }
        }
        end_draw(device, *cmd_buffer, shader_objects.is_some());
        copy_image_to_buffer(
            device,
            *cmd_buffer,
            color_buffer.image.get(),
            color_buffer.buffer.get(),
            WIDTH,
            HEIGHT,
        );
        end_command_buffer(device, *cmd_buffer)?;
        submit_commands_and_wait(device, queue, *cmd_buffer)?;

        let color_bytes = color_buffer.read_bytes(device)?;
        let default_color = [0u8, 0, 255, 255];
        if color_bytes.chunks_exact(4).any(|pixel| pixel != default_color) {
            return Ok(TestStatus::fail(
                "Unexpected color buffer contents -- check log for details",
            ));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createInputAttributeOffsetTests`
pub fn create_input_attribute_offset_tests() -> TestCaseGroup {
    let mut main_group = TestCaseGroup::new("input_attribute_offset");

    for (data_type, data_type_name) in [(DataType::Vec2, "vec2"), (DataType::Vec4, "vec4")] {
        let type_size = data_type.type_size();
        let mut data_type_grp = TestCaseGroup::new(data_type_name);

        for offset in 0..type_size {
            let mut offset_grp = TestCaseGroup::new(format!("offset_{offset}"));

            for (stride_case, stride_name) in [
                (StrideCase::Packed, "packed"),
                (StrideCase::Padded, "padded"),
                (StrideCase::Overlapping, "overlapping"),
            ] {
                if stride_case == StrideCase::Overlapping && data_type != DataType::Vec2 {
                    continue;
                }

                let mut stride_grp = TestCaseGroup::new(stride_name);

                for (use_memory_offset, memory_offset_grp_name) in
                    [(false, "no_memory_offset"), (true, "with_memory_offset")]
                {
                    let mut memory_offset_grp = TestCaseGroup::new(memory_offset_grp_name);

                    for dynamic in [false, true] {
                        let params = TestParams {
                            data_type,
                            binding_offset: offset,
                            stride_case,
                            use_memory_offset,
                            dynamic,
                            optional_attribute_offset: None,
                            optional_attribute_format: vk::Format::UNDEFINED,
                        };
                        let test_name = if dynamic { "dynamic" } else { "static" };
                        memory_offset_grp.add_child(Box::new(InputAttributeOffsetCase {
                            name: test_name,
                            params,
                        }) as Box<dyn TestCase>);
                    }

                    stride_grp.add_child(memory_offset_grp);
                }

                offset_grp.add_child(stride_grp);
            }

            data_type_grp.add_child(offset_grp);
        }

        main_group.add_child(data_type_grp);
    }

    {
        let mut two_binds_vec4_group = TestCaseGroup::new("two_binds_vec4");
        let rgba8_size = 4;
        for offset in 0..rgba8_size {
            let mut offset_grp = TestCaseGroup::new(format!("offset_{offset}"));
            // dynamic=true, optionalAttributeOffset=0
            let params = TestParams {
                data_type: DataType::Vec4,
                binding_offset: offset,
                stride_case: StrideCase::Packed,
                use_memory_offset: false,
                dynamic: true,
                optional_attribute_offset: Some(0),
                optional_attribute_format: vk::Format::R8G8B8A8_SNORM,
            };
            offset_grp.add_child(Box::new(InputAttributeOffsetCase {
                name: "dynamic",
                params,
            }) as Box<dyn TestCase>);
            two_binds_vec4_group.add_child(offset_grp);
        }
        main_group.add_child(two_binds_vec4_group);
    }

    main_group
}
