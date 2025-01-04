// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/conditional_rendering/vktConditionalTransformFeedbackTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. As upstream, the two occlusion query results are only logged
// there, not part of the verdict - the transform feedback buffer is what decides it. The counter buffer of the
// `draw_indirect_byte_count_ext` case is created with INDIRECT_BUFFER usage, as upstream does.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{
    ExtConditionalRenderingExtensionDeviceCommands, ExtMultiDrawExtensionDeviceCommands,
    ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1, KhrDrawIndirectCountExtensionDeviceCommands,
};

use crate::generated::shaders::conditional_rendering_transform_feedback::CONDITIONAL_TRANSFORM_FEEDBACK;
use crate::tcu::{RGBA, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{BufferWithMemory, make_buffer_create_info, make_buffer_memory_barrier, make_memory_barrier};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::{DrawTestsBase, GroupParams, VertexElementData, create_host_buffer};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawCommandType {
    Draw,
    DrawIndexed,
    DrawIndirect,
    DrawIndexedIndirect,
    DrawMultiExt,
    DrawMultiIndexedExt,
    IndirectByteCountExt,
    DrawIndirectCount,
    DrawIndexedIndirectCount,
}

const ALL_COMMANDS: [DrawCommandType; 9] = [
    DrawCommandType::Draw,
    DrawCommandType::DrawIndexed,
    DrawCommandType::DrawIndirect,
    DrawCommandType::DrawIndexedIndirect,
    DrawCommandType::DrawMultiExt,
    DrawCommandType::DrawMultiIndexedExt,
    DrawCommandType::IndirectByteCountExt,
    DrawCommandType::DrawIndirectCount,
    DrawCommandType::DrawIndexedIndirectCount,
];

/// `getDrawCommandTypeName`
fn get_draw_command_type_name(command: DrawCommandType) -> &'static str {
    match command {
        DrawCommandType::Draw => "draw",
        DrawCommandType::DrawIndexed => "draw_indexed",
        DrawCommandType::DrawIndirect => "draw_indirect",
        DrawCommandType::DrawIndexedIndirect => "draw_indexed_indirect",
        DrawCommandType::DrawMultiExt => "draw_multi_ext",
        DrawCommandType::DrawMultiIndexedExt => "draw_multi_indexed_ext",
        DrawCommandType::IndirectByteCountExt => "draw_indirect_byte_count_ext",
        DrawCommandType::DrawIndirectCount => "draw_indirect_count",
        DrawCommandType::DrawIndexedIndirectCount => "draw_indexed_indirect_count",
    }
}

struct ConditionalTransformFeedbackCase {
    name: &'static str,
    command: DrawCommandType,
}

impl TestCase for ConditionalTransformFeedbackCase {
    fn name(&self) -> &str {
        self.name
    }

    /// `checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_conditional_rendering")?;
        context.require_device_functionality("VK_EXT_transform_feedback")?;

        let mut conditional_features = vk::PhysicalDeviceConditionalRenderingFeaturesEXT::default();
        let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder()
            .push_next(&mut conditional_features)
            .push_next(&mut xfb_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };

        if conditional_features.conditional_rendering == vk::FALSE {
            return Err(TestError::NotSupported(
                "conditionalRendering feature not supported".to_string(),
            ));
        }

        if self.command == DrawCommandType::DrawIndirectCount
            || self.command == DrawCommandType::DrawIndexedIndirectCount
        {
            context.require_device_functionality("VK_KHR_draw_indirect_count")?;
        }

        if self.command == DrawCommandType::DrawMultiExt || self.command == DrawCommandType::DrawMultiIndexedExt {
            context.require_device_functionality("VK_EXT_multi_draw")?;
        }

        if xfb_features.geometry_streams == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryStreams feature not supported".to_string(),
            ));
        }

        let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };

        if self.command == DrawCommandType::IndirectByteCountExt && xfb_properties.transform_feedback_draw == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "transformFeedbackDraw feature not supported".to_string(),
            ));
        }

        if xfb_properties.max_transform_feedback_buffers < 4 {
            return Err(TestError::NotSupported(
                "maxTransformFeedbackBuffers is less than required".to_string(),
            ));
        }
        if xfb_properties.max_transform_feedback_streams < 4 {
            return Err(TestError::NotSupported(
                "maxTransformFeedbackStreams is less than required".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        CONDITIONAL_TRANSFORM_FEEDBACK.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConditionalTransformFeedbackDraw {
            context,
            command: self.command,
        })
    }
}

/// The vertex data `ConditionalTransformFeedbackDraw`'s constructor pushes into `m_data`.
fn build_vertex_data() -> Vec<VertexElementData> {
    let blue = RGBA::blue().to_vec().m_data;
    let black = RGBA::black().to_vec().m_data;
    let red = RGBA::red().to_vec().m_data;
    let quad = |x0: f32, x1: f32, y0: f32, y1: f32, color: [f32; 4]| {
        [
            VertexElementData::new([x0, y1, 0.5, 1.0], color, 0),
            VertexElementData::new([x0, y0, 0.5, 1.0], color, 0),
            VertexElementData::new([x1, y1, 0.5, 1.0], color, 0),
            VertexElementData::new([x0, y0, 0.5, 1.0], color, 0),
            VertexElementData::new([x1, y1, 0.5, 1.0], color, 0),
            VertexElementData::new([x1, y0, 0.5, 1.0], color, 0),
        ]
    };

    let mut data = Vec::new();
    data.extend(quad(-0.3, 0.3, -0.3, 0.3, blue));
    data.extend(quad(-0.3, 0.3, -0.3, 0.3, black));
    data.extend(quad(5.3, 6.3, 5.3, 6.3, red));
    data
}

/// `createAndBindIndexBuffer`: binds an already created and filled index buffer and hands it back to be kept alive.
fn bind_index_buffer<'b>(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    index_buffer: BufferWithMemory<'b>,
) -> BufferWithMemory<'b> {
    unsafe { device.cmd_bind_index_buffer(cmd_buffer, index_buffer.get(), 0, vk::IndexType::UINT32) };
    index_buffer
}

/// `ConditionalTransformFeedbackDraw`. The base class is built in `iterate` instead of the constructor.
struct ConditionalTransformFeedbackDraw<'a> {
    context: &'a Context<'a>,
    command: DrawCommandType,
}

/// The buffers `recordDraw` reads, created by `iterate` according to the command.
struct DrawBuffers<'a> {
    indirect: Option<BufferWithMemory<'a>>,
    indirect_count: Option<BufferWithMemory<'a>>,
    count: Option<BufferWithMemory<'a>>,
}

impl ConditionalTransformFeedbackDraw<'_> {
    /// `recordDraw`
    fn record_draw(&self, cmd_buffer: vk::CommandBuffer, index: u32, buffers: &DrawBuffers<'_>) {
        let device = self.context.get_device();
        let first_vertex = 6 * index;
        let first_index = 6 * index;
        let multi_draw_info = vk::MultiDrawInfoEXT {
            first_vertex,
            vertex_count: 6,
        };
        let multi_draw_indexed_info = vk::MultiDrawIndexedInfoEXT {
            first_index: first_vertex,
            index_count: 6,
            vertex_offset: 0,
        };
        let vertex_offset = 0i32;
        let indirect_offset =
            (std::mem::size_of::<vk::DrawIndirectCommand>() as vk::DeviceSize) * index as vk::DeviceSize;
        let indexed_indirect_offset =
            (std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as vk::DeviceSize) * index as vk::DeviceSize;
        let indirect = || buffers.indirect.as_ref().expect("indirect buffer").get();
        let indirect_count = || buffers.indirect_count.as_ref().expect("indirect count buffer").get();

        unsafe {
            match self.command {
                DrawCommandType::Draw => device.cmd_draw(cmd_buffer, 6, 1, first_vertex, 0),
                DrawCommandType::DrawIndexed => device.cmd_draw_indexed(cmd_buffer, 6, 1, first_index, 0, 0),
                DrawCommandType::DrawIndirect => device.cmd_draw_indirect(
                    cmd_buffer,
                    indirect(),
                    indirect_offset,
                    1,
                    std::mem::size_of::<vk::DrawIndirectCommand>() as u32,
                ),
                DrawCommandType::DrawMultiExt => device.cmd_draw_multi_ext(
                    cmd_buffer,
                    &[multi_draw_info],
                    1,
                    0,
                    std::mem::size_of::<vk::MultiDrawInfoEXT>() as u32,
                ),
                DrawCommandType::DrawMultiIndexedExt => device.cmd_draw_multi_indexed_ext(
                    cmd_buffer,
                    &[multi_draw_indexed_info],
                    1,
                    0,
                    std::mem::size_of::<vk::MultiDrawIndexedInfoEXT>() as u32,
                    Some(&vertex_offset),
                ),
                DrawCommandType::IndirectByteCountExt => device.cmd_draw_indirect_byte_count_ext(
                    cmd_buffer,
                    1,
                    0,
                    buffers.count.as_ref().expect("count buffer").get(),
                    (index as vk::DeviceSize - 1) * 4,
                    0,
                    4,
                ),
                DrawCommandType::DrawIndexedIndirect => device.cmd_draw_indexed_indirect(
                    cmd_buffer,
                    indirect(),
                    indexed_indirect_offset,
                    1,
                    std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32,
                ),
                DrawCommandType::DrawIndirectCount => device.cmd_draw_indirect_count_khr(
                    cmd_buffer,
                    indirect(),
                    indirect_offset,
                    indirect_count(),
                    0,
                    1,
                    std::mem::size_of::<vk::DrawIndirectCommand>() as u32,
                ),
                DrawCommandType::DrawIndexedIndirectCount => device.cmd_draw_indexed_indirect_count_khr(
                    cmd_buffer,
                    indirect(),
                    indexed_indirect_offset,
                    indirect_count(),
                    0,
                    1,
                    std::mem::size_of::<vk::DrawIndexedIndirectCommand>() as u32,
                ),
            }
        }
    }
}

impl TestInstance for ConditionalTransformFeedbackDraw<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let command = self.command;

        let data = build_vertex_data();
        let indexes: Vec<u32> = (0..data.len() as u32).collect();
        let base = DrawTestsBase::new_default(
            context,
            "VertexFetch.vert",
            "VertexFetch.frag",
            GroupParams::default(),
            vk::PrimitiveTopology::TRIANGLE_LIST,
            data,
        )?;

        // createStreamPipeline
        let push_const_range = vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::GEOMETRY,
            offset: 0,
            size: std::mem::size_of::<i32>() as u32,
        };
        let push_constant_ranges = [push_const_range];
        let stream_pipeline_layout_info =
            vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let stream_pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&stream_pipeline_layout_info, None) }
                .vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("VertexFetch.vert")?)?;
        let geom_name = if context
            .get_device_features()
            .shader_tessellation_and_geometry_point_size
            != vk::FALSE
        {
            "VertexFetchWritePoint.geom"
        } else {
            "VertexFetch.geom"
        };
        let gs = create_shader_module(device, binaries.get(geom_name)?)?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::POINT_LIST)
            .with_full_viewport(base.render_width, base.render_height);
        state.bindings = vec![vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<VertexElementData>() as u32,
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
            vk::VertexInputAttributeDescription {
                location: 2,
                binding: 0,
                format: vk::Format::R32_SINT,
                offset: 32,
            },
        ];
        let stream_pipeline = create_draw_pipeline(
            device,
            *stream_pipeline_layout,
            base.render_pass_handle(),
            &[
                (vk::ShaderStageFlags::VERTEX, *vs),
                (vk::ShaderStageFlags::GEOMETRY, *gs),
            ],
            &state,
        )?;

        let query_pool_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::OCCLUSION)
            .query_count(2);
        let query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_info, None) }.vk_check("vkCreateQueryPool")?,
        );

        let query_buffer = BufferWithMemory::new(
            device,
            context.get_default_allocator(),
            make_buffer_create_info(
                std::mem::size_of::<u32>() as u64 * 2,
                vk::BufferUsageFlags::TRANSFER_DST | vk::BufferUsageFlags::CONDITIONAL_RENDERING_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // createXfbBuffer
        let output_count = 4 * 6; // 4 stream, 6 points
        let xfb_buffer = create_host_buffer(
            context,
            &[0.0f32; 24],
            vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
        )?;
        debug_assert!(output_count == 24);

        let cmd_buffer = *base.cmd_buffer;
        begin_command_buffer(device, cmd_buffer)?;
        base.pre_render_barriers();

        unsafe { device.cmd_reset_query_pool(cmd_buffer, *query_pool, 0, 2) };
        base.begin_legacy_render(cmd_buffer, vk::SubpassContents::INLINE);

        unsafe {
            device.cmd_bind_vertex_buffers(
                cmd_buffer,
                0,
                &[base.vertex_buffer.as_ref().expect("vertex buffer").get()],
                &[0],
            );
            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *base.pipeline);
        }

        let mut buffers = DrawBuffers {
            indirect: None,
            indirect_count: None,
            count: None,
        };
        let mut _index_buffer = None;
        let indirect_commands = [
            vk::DrawIndirectCommand {
                vertex_count: 6,
                instance_count: 1,
                first_vertex: 0,
                first_instance: 0,
            },
            vk::DrawIndirectCommand {
                vertex_count: 6,
                instance_count: 1,
                first_vertex: 6,
                first_instance: 0,
            },
            vk::DrawIndirectCommand {
                vertex_count: 6,
                instance_count: 1,
                first_vertex: 12,
                first_instance: 0,
            },
        ];
        let indexed_indirect_commands = [
            vk::DrawIndexedIndirectCommand {
                index_count: 6,
                instance_count: 1,
                first_index: 0,
                vertex_offset: 0,
                first_instance: 0,
            },
            vk::DrawIndexedIndirectCommand {
                index_count: 6,
                instance_count: 1,
                first_index: 6,
                vertex_offset: 0,
                first_instance: 0,
            },
            vk::DrawIndexedIndirectCommand {
                index_count: 6,
                instance_count: 1,
                first_index: 12,
                vertex_offset: 0,
                first_instance: 0,
            },
        ];

        match command {
            DrawCommandType::Draw | DrawCommandType::DrawMultiExt => {}
            DrawCommandType::DrawIndexed | DrawCommandType::DrawMultiIndexedExt => {
                _index_buffer = Some(bind_index_buffer(
                    device,
                    cmd_buffer,
                    create_host_buffer(context, &indexes, vk::BufferUsageFlags::INDEX_BUFFER)?,
                ));
            }
            DrawCommandType::DrawIndirect => {
                buffers.indirect = Some(create_host_buffer(
                    context,
                    &indirect_commands,
                    vk::BufferUsageFlags::INDIRECT_BUFFER,
                )?);
            }
            DrawCommandType::DrawIndexedIndirect => {
                _index_buffer = Some(bind_index_buffer(
                    device,
                    cmd_buffer,
                    create_host_buffer(context, &indexes, vk::BufferUsageFlags::INDEX_BUFFER)?,
                ));
                buffers.indirect = Some(create_host_buffer(
                    context,
                    &indexed_indirect_commands,
                    vk::BufferUsageFlags::INDIRECT_BUFFER,
                )?);
            }
            DrawCommandType::IndirectByteCountExt => {
                // createCountBuffer
                buffers.count = Some(create_host_buffer(
                    context,
                    &[6u32 * 4, 0u32],
                    vk::BufferUsageFlags::INDIRECT_BUFFER,
                )?);
            }
            DrawCommandType::DrawIndirectCount => {
                buffers.indirect = Some(create_host_buffer(
                    context,
                    &indirect_commands,
                    vk::BufferUsageFlags::INDIRECT_BUFFER,
                )?);
                buffers.indirect_count = Some(create_host_buffer(
                    context,
                    &[1u32],
                    vk::BufferUsageFlags::INDIRECT_BUFFER,
                )?);
            }
            DrawCommandType::DrawIndexedIndirectCount => {
                _index_buffer = Some(bind_index_buffer(
                    device,
                    cmd_buffer,
                    create_host_buffer(context, &indexes, vk::BufferUsageFlags::INDEX_BUFFER)?,
                ));
                buffers.indirect = Some(create_host_buffer(
                    context,
                    &indexed_indirect_commands,
                    vk::BufferUsageFlags::INDIRECT_BUFFER,
                )?);
                buffers.indirect_count = Some(create_host_buffer(
                    context,
                    &[1u32],
                    vk::BufferUsageFlags::INDIRECT_BUFFER,
                )?);
            }
        }

        unsafe { device.cmd_begin_query(cmd_buffer, *query_pool, 0, vk::QueryControlFlags::empty()) };
        self.record_draw(cmd_buffer, 2, &buffers);
        unsafe {
            device.cmd_end_query(cmd_buffer, *query_pool, 0);
            device.cmd_begin_query(cmd_buffer, *query_pool, 1, vk::QueryControlFlags::empty());
        }
        self.record_draw(cmd_buffer, 1, &buffers);
        unsafe { device.cmd_end_query(cmd_buffer, *query_pool, 1) };

        base.end_legacy_render(cmd_buffer);
        unsafe {
            device.cmd_copy_query_pool_results(
                cmd_buffer,
                *query_pool,
                0,
                2,
                query_buffer.get(),
                0,
                std::mem::size_of::<u32>() as vk::DeviceSize,
                vk::QueryResultFlags::WAIT,
            );
        }

        let buffer_memory_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::CONDITIONAL_RENDERING_READ_EXT,
            query_buffer.get(),
            0,
            (std::mem::size_of::<u32>() * 2) as vk::DeviceSize,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::CONDITIONAL_RENDERING_EXT,
                vk::DependencyFlags::empty(),
                &[] as &[vk::MemoryBarrier],
                &[buffer_memory_barrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        base.begin_legacy_render(cmd_buffer, vk::SubpassContents::INLINE);

        unsafe { device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *stream_pipeline) };
        let xfb_size = (std::mem::size_of::<f32>() * 6) as vk::DeviceSize;
        for stream in 0..4u32 {
            let xfb_offset = stream as vk::DeviceSize * std::mem::size_of::<f32>() as vk::DeviceSize * 6;
            let conditional_rendering_begin_info = vk::ConditionalRenderingBeginInfoEXT::builder()
                .buffer(query_buffer.get())
                .offset(std::mem::size_of::<u32>() as vk::DeviceSize * (stream % 2) as vk::DeviceSize)
                .flags(vk::ConditionalRenderingFlagsEXT::empty());
            unsafe {
                device.cmd_bind_transform_feedback_buffers_ext(
                    cmd_buffer,
                    stream,
                    &[xfb_buffer.get()],
                    &[xfb_offset],
                    &[xfb_size],
                );
                device.cmd_push_constants(
                    cmd_buffer,
                    *stream_pipeline_layout,
                    vk::ShaderStageFlags::GEOMETRY,
                    0,
                    &(stream as i32).to_ne_bytes(),
                );

                device.cmd_begin_conditional_rendering_ext(cmd_buffer, &conditional_rendering_begin_info);
                device.cmd_begin_transform_feedback_ext(cmd_buffer, 0, &[], &[]);
            }
            self.record_draw(cmd_buffer, 1, &buffers);
            unsafe {
                device.cmd_end_transform_feedback_ext(cmd_buffer, 0, &[], &[]);
                device.cmd_end_conditional_rendering_ext(cmd_buffer);
            }
        }
        base.end_legacy_render(cmd_buffer);
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[tf_memory_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }
        end_command_buffer(device, cmd_buffer)?;
        submit_commands_and_wait(device, queue, cmd_buffer)?;

        invalidate_alloc(device, xfb_buffer.get_allocation())?;
        let xfb_values =
            unsafe { std::slice::from_raw_parts(xfb_buffer.get_allocation().get_host_ptr().cast::<f32>(), 24) };

        for (i, &value) in xfb_values.iter().enumerate() {
            let expected = if (6..12).contains(&i) {
                2.0f32
            } else if i >= 18 {
                4.0
            } else {
                0.0
            };
            if value != expected {
                return Ok(TestStatus::fail("Fail"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `ConditionalTransformFeedbackTests::init` - the `transform_feedback` group.
pub fn create_conditional_transform_feedback_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("transform_feedback");
    for command in ALL_COMMANDS {
        group.add_child(Box::new(ConditionalTransformFeedbackCase {
            name: get_draw_command_type_name(command),
            command,
        }) as Box<dyn TestCase>);
    }
    group
}
