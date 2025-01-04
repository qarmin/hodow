// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktPrimitivesGeneratedQueryTests.cpp (`ConcurrentPrimitivesGeneratedQueryTestInstance`,
//   `ConcurrentPrimitivesGeneratedQueryTestCase`, and the `concurrent` part of `testGenerator`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders, which depend only on the topology and on whether transform feedback is on, are
// in `shaders/manifest/transform_feedback_pgq_concurrent.toml` (`scripts/gen_pgq_concurrent_shaders.py`), one set per pair, looked up by name.
// The `VertexStream` arithmetic is upstream's, so a case without transform feedback has an XFB stream index of `VERTEX_STREAM_NONE` (2), which
// is what `check_support` asks `maxTransformFeedbackStreams` about.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::ExtTransformFeedbackExtensionDeviceCommands;

use super::primitives_generated_query_tests::{query_pgq_features, topology_data};
use crate::generated::shaders::transform_feedback_pgq_concurrent::ALL_PGQ_CONCURRENT_PROGRAMS;
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, end_command_buffer, end_render_pass, make_rect_2d, submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_create_info, make_image_memory_barrier,
    make_image_subresource_layers, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The `rust_type` of the manifest entries: the shaders of one topology, with or without transform feedback.
pub struct PgqConcurrentPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `VERTEX_STREAM_NONE`: what `xfbStreamIndex()` gives a case that has no transform feedback.
const VERTEX_STREAM_NONE: u32 = 2;
/// The query's stream, `VERTEX_STREAM_DEFAULT` (index 0) in every case.
const PGQ_STREAM_INDEX: u32 = 0;

const IMAGE_WIDTH: u32 = 16;
const IMAGE_HEIGHT: u32 = 17;
const INSTANCE_COUNT: u32 = 1;
const FIRST_VERTEX: u32 = 0;
const FIRST_INSTANCE: u32 = 0;
const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const PRIMITIVES_GENERATED: u64 = 32;

/// `ConcurrentTestType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ConcurrentTestType {
    TwoXfbInsidePgq,
    PgqSecondaryCmdBuffer,
    PipelineStatistics1,
    PipelineStatistics2,
    PipelineStatistics3,
}

/// `QueryResultType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum QueryResultType {
    Bits32,
    Bits64,
    Pgq32Xfb64,
    Pgq64Xfb32,
}

/// `ConcurrentTestParameters`, whose shader stage is the geometry shader and whose query stream is the default one in every case.
#[derive(Clone, Copy)]
struct Params {
    concurrent_test_type: ConcurrentTestType,
    query_result_type: QueryResultType,
    primitive_topology: vk::PrimitiveTopology,
    indirect: bool,
}

impl Params {
    fn transform_feedback(&self) -> bool {
        self.concurrent_test_type == ConcurrentTestType::TwoXfbInsidePgq
    }

    fn xfb_stream_index(&self) -> u32 {
        if self.transform_feedback() {
            1
        } else {
            VERTEX_STREAM_NONE
        }
    }

    fn non_zero_streams(&self) -> bool {
        PGQ_STREAM_INDEX != 0 || self.xfb_stream_index() != 0
    }

    fn pgq64(&self) -> bool {
        matches!(
            self.query_result_type,
            QueryResultType::Bits64 | QueryResultType::Pgq64Xfb32
        )
    }

    fn xfb64(&self) -> bool {
        matches!(
            self.query_result_type,
            QueryResultType::Bits64 | QueryResultType::Pgq32Xfb64
        )
    }

    fn pipeline_statistics(&self) -> bool {
        matches!(
            self.concurrent_test_type,
            ConcurrentTestType::PipelineStatistics1
                | ConcurrentTestType::PipelineStatistics2
                | ConcurrentTestType::PipelineStatistics3
        )
    }
}

fn topology_name(topology: vk::PrimitiveTopology) -> &'static str {
    match topology {
        vk::PrimitiveTopology::POINT_LIST => "point_list",
        vk::PrimitiveTopology::LINE_LIST => "line_list",
        vk::PrimitiveTopology::LINE_STRIP => "line_strip",
        vk::PrimitiveTopology::TRIANGLE_LIST => "triangle_list",
        vk::PrimitiveTopology::TRIANGLE_STRIP => "triangle_strip",
        vk::PrimitiveTopology::TRIANGLE_FAN => "triangle_fan",
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => "line_list_with_adjacency",
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => "line_strip_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => "triangle_list_with_adjacency",
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => "triangle_strip_with_adjacency",
        other => panic!("unhandled topology {other:?}"),
    }
}

struct ConcurrentCase {
    name: &'static str,
    params: Params,
    programs: BinaryCollection,
}

impl TestCase for ConcurrentCase {
    fn name(&self) -> &str {
        self.name
    }

    #[expect(
        clippy::absurd_extreme_comparisons,
        reason = "the stream index is a constant that upstream varies by hand"
    )]
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_primitives_generated_query")?;
        context.require_device_functionality("VK_EXT_transform_feedback")?;

        let features = query_pgq_features(context);
        if !features.primitives_generated_query {
            return Err(TestError::NotSupported(
                "VK_QUERY_TYPE_PRIMITIVES_GENERATED_EXT not supported".to_string(),
            ));
        }

        // The geometry shader stage is used by every case.
        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature is not supported".to_string(),
            ));
        }

        if self.params.non_zero_streams() {
            let required_streams = self.params.xfb_stream_index();

            if PGQ_STREAM_INDEX > 0 && !features.with_non_zero_streams {
                return Err(TestError::NotSupported(
                    "primitivesGeneratedQueryWithNonZeroStreams not supported".to_string(),
                ));
            }

            if features.max_transform_feedback_streams <= required_streams {
                return Err(TestError::NotSupported(
                    "Required amount of XFB streams not supported".to_string(),
                ));
            }
        }

        if !features.transform_feedback {
            return Err(TestError::NotSupported("transformFeedback not supported".to_string()));
        }

        if !features.transform_feedback_queries {
            return Err(TestError::NotSupported(
                "transformFeedbackQueries not supported".to_string(),
            ));
        }

        if self.params.pipeline_statistics() && context.get_device_features().pipeline_statistics_query == vk::FALSE {
            return Err(TestError::NotSupported(
                "pipelineStatisticsQuery not supported".to_string(),
            ));
        }

        // VUID-vkCmdExecuteCommands-commandBuffer-00101
        if self.params.concurrent_test_type == ConcurrentTestType::PipelineStatistics3
            && context.get_device_features().inherited_queries == vk::FALSE
        {
            return Err(TestError::NotSupported("inheritedQueries not supported".to_string()));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        self.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConcurrentInstance {
            context,
            params: self.params,
        })
    }
}

struct ConcurrentInstance<'a> {
    context: &'a Context<'a>,
    params: Params,
}

/// `makeConstantLayoutRenderPass`: initial and final layout COLOR_ATTACHMENT_OPTIMAL, so a render pass can begin and end many times without
/// layout transition hazards.
fn make_constant_layout_render_pass(
    device: &Device,
    color_format: vk::Format,
) -> Result<Unique<'_, vk::RenderPass>, TestError> {
    let constant_layout = vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL;
    let attachments = [vk::AttachmentDescription::builder()
        .format(color_format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(vk::AttachmentLoadOp::CLEAR)
        .store_op(vk::AttachmentStoreOp::STORE)
        .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
        .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
        .initial_layout(constant_layout)
        .final_layout(constant_layout)
        .build()];
    let color_reference = [vk::AttachmentReference {
        attachment: 0,
        layout: constant_layout,
    }];
    let subpasses = [vk::SubpassDescription::builder()
        .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
        .color_attachments(&color_reference)
        .build()];
    let info = vk::RenderPassCreateInfo::builder()
        .attachments(&attachments)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

/// `beginRenderPass` with the contents of the subpass given: the secondary command buffer cases record their draws elsewhere.
fn begin_render_pass_with_contents(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    render_pass: vk::RenderPass,
    framebuffer: vk::Framebuffer,
    render_area: vk::Rect2D,
    clear_value: vk::ClearValue,
    contents: vk::SubpassContents,
) {
    let clear_values = [clear_value];
    let info = vk::RenderPassBeginInfo::builder()
        .render_pass(render_pass)
        .framebuffer(framebuffer)
        .render_area(render_area)
        .clear_values(&clear_values);
    unsafe { device.cmd_begin_render_pass(cmd_buffer, &info, contents) };
}

/// `prepareColorAttachment`: the image to color attachment optimal.
fn prepare_color_attachment(
    device: &Device,
    cmd_buffer: vk::CommandBuffer,
    image: vk::Image,
    range: vk::ImageSubresourceRange,
) {
    let dst_access = vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
    let barrier = make_image_memory_barrier(
        vk::AccessFlags::empty(),
        dst_access,
        vk::ImageLayout::UNDEFINED,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        image,
        range,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TOP_OF_PIPE,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[barrier],
        );
    }
}

/// `syncColorRenderPasses`
fn sync_color_render_passes(device: &Device, cmd_buffer: vk::CommandBuffer) {
    let color_access = vk::AccessFlags::COLOR_ATTACHMENT_READ | vk::AccessFlags::COLOR_ATTACHMENT_WRITE;
    let color_stages = vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT;
    let barrier = make_memory_barrier(color_access, color_access);
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            color_stages,
            color_stages,
            vk::DependencyFlags::empty(),
            &[barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

/// `copyColorImageToBuffer`
fn copy_color_image_to_buffer(device: &Device, cmd_buffer: vk::CommandBuffer, image: vk::Image, buffer: vk::Buffer) {
    let range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
    let post_image_barrier = make_image_memory_barrier(
        vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
        vk::AccessFlags::TRANSFER_READ,
        vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        vk::ImageLayout::GENERAL,
        image,
        range,
    );
    unsafe {
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
            vk::PipelineStageFlags::TRANSFER,
            vk::DependencyFlags::empty(),
            &[] as &[vk::MemoryBarrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[post_image_barrier],
        );
        let copy = make_buffer_image_copy(
            vk::Extent3D {
                width: IMAGE_WIDTH,
                height: IMAGE_HEIGHT,
                depth: 1,
            },
            make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
        );
        device.cmd_copy_image_to_buffer(cmd_buffer, image, vk::ImageLayout::GENERAL, buffer, &[copy]);
        let host_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        device.cmd_pipeline_barrier(
            cmd_buffer,
            vk::PipelineStageFlags::TRANSFER,
            vk::PipelineStageFlags::HOST,
            vk::DependencyFlags::empty(),
            &[host_barrier],
            &[] as &[vk::BufferMemoryBarrier],
            &[] as &[vk::ImageMemoryBarrier],
        );
    }
}

impl ConcurrentInstance<'_> {
    /// `fillVertexBuffer`. `prim - 1` is an unsigned subtraction upstream, which wraps for the first primitive of the adjacency list: that
    /// vertex is never rasterized, only handed to the geometry shader.
    fn fill_vertex_buffer(&self, vertices: &mut [[f32; 2]], primitives_generated: u64) {
        let quarter_row = 2.0 / (IMAGE_HEIGHT as f32 * 4.0); // In height.
        let step = 1.0 / (primitives_generated - 1) as f32;
        let n = primitives_generated as u32;
        let x = |index: f32| -1.0 + 2.0 * index * step;

        match self.params.primitive_topology {
            vk::PrimitiveTopology::POINT_LIST => {
                for prim in 0..n {
                    vertices[prim as usize] = [x(prim as f32), 0.0];
                }
            }
            vk::PrimitiveTopology::LINE_LIST => {
                for prim in 0..n {
                    vertices[2 * prim as usize] = [x(prim as f32), 0.0];
                    vertices[2 * prim as usize + 1] = [x((prim + 1) as f32), 0.0];
                }
            }
            vk::PrimitiveTopology::LINE_STRIP => {
                vertices[0] = [-1.0, 0.0];
                vertices[1] = [-1.0, 0.0];
                for prim in 1..n {
                    vertices[1 + prim as usize] = [x(prim as f32), 0.0];
                }
            }
            vk::PrimitiveTopology::TRIANGLE_STRIP => {
                vertices[0] = [-1.0, quarter_row];
                vertices[1] = [-1.0, -quarter_row];
                vertices[2] = [-1.0 + 2.0 * step, -quarter_row];
                for prim in 1..n {
                    vertices[2 + prim as usize] = [
                        x((prim + 1) as f32),
                        if prim % 2 == 0 { -quarter_row } else { quarter_row },
                    ];
                }
            }
            vk::PrimitiveTopology::TRIANGLE_FAN => {
                vertices[0] = [0.0, -quarter_row];
                for prim in 0..n + 1 {
                    vertices[1 + prim as usize] = [x(prim as f32), quarter_row];
                }
            }
            vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY => {
                for prim in 0..n {
                    vertices[4 * prim as usize] = [x(prim.wrapping_sub(1) as f32), 0.0];
                    vertices[4 * prim as usize + 1] = [x(prim as f32), 0.0];
                    vertices[4 * prim as usize + 2] = [x((prim + 1) as f32), 0.0];
                    vertices[4 * prim as usize + 3] = [x((prim + 2) as f32), 0.0];
                }
            }
            vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY => {
                vertices[0] = [-1.0, 0.0];
                vertices[1] = [-1.0, 0.0];
                for prim in 0..n {
                    vertices[2 + prim as usize] = [x((prim + 1) as f32), 0.0];
                }
                vertices[2 + n as usize] = [1.0, 0.0];
            }
            vk::PrimitiveTopology::TRIANGLE_LIST => {
                for prim in 0..n {
                    vertices[3 * prim as usize] = [x(prim as f32), -quarter_row];
                    vertices[3 * prim as usize + 1] = [x(prim as f32), quarter_row];
                    vertices[3 * prim as usize + 2] = [x((prim + 1) as f32), 0.0];
                }
            }
            vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY => {
                for prim in 0..n {
                    vertices[6 * prim as usize] = [x(prim as f32), quarter_row];
                    vertices[6 * prim as usize + 1] = [x(prim as f32), quarter_row];
                    vertices[6 * prim as usize + 2] = [x(prim as f32), -quarter_row];
                    vertices[6 * prim as usize + 3] = [x(prim as f32), -quarter_row];
                    vertices[6 * prim as usize + 4] = [x((prim + 1) as f32), -quarter_row];
                    vertices[6 * prim as usize + 5] = [x((prim + 1) as f32), -quarter_row];
                }
            }
            vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY => {
                // A strip of triangles, each pair of them forming a quad, crossing the image from left to right.
                let quad_step = 2.0 / (primitives_generated as f32 / 2.0); // In width.
                let y_coords = [-quarter_row, quarter_row];

                // The first two points on the left edge of the image.
                vertices[0] = [-1.0, y_coords[0]];
                vertices[1] = [-1.0, y_coords[0]];
                vertices[2] = [-1.0, y_coords[1]];
                vertices[3] = [-1.0, y_coords[1]];

                for prim_idx in 0..n {
                    let edge_idx = prim_idx / 2;
                    let y_idx = prim_idx % 2;
                    let x_coord = -1.0 + (edge_idx as f32 + 1.0) * quad_step;
                    let y_coord = y_coords[y_idx as usize];
                    let vert_idx = (prim_idx + 2) as usize;
                    vertices[vert_idx * 2] = [x_coord, y_coord]; // Vertex.
                    vertices[vert_idx * 2 + 1] = [x_coord, y_coord]; // Adjacency point.
                }
            }
            other => panic!("Unrecognized primitive topology {other:?}"),
        }
    }

    /// `makeGraphicsPipeline`: additive blending over the colour attachment, rasterization on, the geometry shader of the case.
    fn make_graphics_pipeline(
        &self,
        pipeline_layout: vk::PipelineLayout,
        render_pass: vk::RenderPass,
    ) -> Result<Unique<'_, vk::Pipeline>, TestError> {
        let device = self.context.get_device();
        let binaries = self.context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let geom_module = create_shader_module(device, binaries.get("geom")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        let entry = c"main";
        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vert_module)
                .name(entry.to_bytes_with_nul())
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::GEOMETRY)
                .module(*geom_module)
                .name(entry.to_bytes_with_nul())
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*frag_module)
                .name(entry.to_bytes_with_nul())
                .build(),
        ];

        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 2]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32_SFLOAT,
            offset: 0,
        }];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes);
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(self.params.primitive_topology);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: IMAGE_WIDTH as f32,
            height: IMAGE_HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [make_rect_2d(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT)];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterization = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
            .depth_bias_enable(false)
            .line_width(1.0);
        let multisample = vk::PipelineMultisampleStateCreateInfo::builder()
            .rasterization_samples(vk::SampleCountFlags::_1)
            .min_sample_shading(1.0);
        let blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(true)
            .src_color_blend_factor(vk::BlendFactor::ONE)
            .dst_color_blend_factor(vk::BlendFactor::ONE)
            .color_blend_op(vk::BlendOp::ADD)
            .src_alpha_blend_factor(vk::BlendFactor::ONE)
            .dst_alpha_blend_factor(vk::BlendFactor::ONE)
            .alpha_blend_op(vk::BlendOp::ADD)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend = vk::PipelineColorBlendStateCreateInfo::builder()
            .logic_op_enable(false)
            .logic_op(vk::LogicOp::NO_OP)
            .attachments(&blend_attachments);
        let depth_stencil = vk::PipelineDepthStencilStateCreateInfo::builder();

        let info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization)
            .multisample_state(&multisample)
            .depth_stencil_state(&depth_stencil)
            .color_blend_state(&color_blend)
            .layout(pipeline_layout)
            .render_pass(render_pass)
            .subpass(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        Ok(Unique::new(device, pipelines.0[0]))
    }

    /// `draw`
    fn draw(&self, cmd_buffer: vk::CommandBuffer, vertex_count: u32, indirect_buffer: vk::Buffer) {
        let device = self.context.get_device();
        unsafe {
            if self.params.indirect {
                device.cmd_draw_indirect(
                    cmd_buffer,
                    indirect_buffer,
                    0,
                    1,
                    std::mem::size_of::<vk::DrawIndirectCommand>() as u32,
                );
            } else {
                device.cmd_draw(cmd_buffer, vertex_count, INSTANCE_COUNT, FIRST_VERTEX, FIRST_INSTANCE);
            }
        }
    }
}

fn read_counter(bytes: &[u8], wide: bool, index: usize) -> u64 {
    if wide {
        u64::from_ne_bytes(bytes[index * 8..index * 8 + 8].try_into().expect("sized by the caller"))
    } else {
        u32::from_ne_bytes(bytes[index * 4..index * 4 + 4].try_into().expect("sized by the caller")) as u64
    }
}

impl TestInstance for ConcurrentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = self.params;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let info = topology_data(params.primitive_topology);

        let primitives_generated = PRIMITIVES_GENERATED;

        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            make_image_create_info(
                IVec2::new(IMAGE_WIDTH as i32, IMAGE_HEIGHT as i32),
                COLOR_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_image_view = make_image_view(
            device,
            color_image.get(),
            vk::ImageViewType::_2D,
            COLOR_FORMAT,
            color_subresource_range,
        )?;

        // By using a constant-layout render pass, we can begin and end the render pass multiple times without layout transition hazards.
        let render_pass = make_constant_layout_render_pass(device, COLOR_FORMAT)?;
        let clear_color = vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        };
        let framebuffer = make_framebuffer(device, *render_pass, &[*color_image_view], IMAGE_WIDTH, IMAGE_HEIGHT, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;
        let pipeline = self.make_graphics_pipeline(*pipeline_layout, *render_pass)?;

        let vertex_count = (info.num_vertices)(primitives_generated) as u32;
        let vtx_buffer_size = u64::from(vertex_count) * std::mem::size_of::<[f32; 2]>() as u64;
        let vtx_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vtx_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let primary_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let secondary_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
        let primary = primary_cmd_buffer.get();
        let secondary = secondary_cmd_buffer.get();

        let pgq64 = params.pgq64();
        let xfb64 = params.xfb64();
        let pgq_result_size = if pgq64 { 8 * 2 } else { 4 * 2 };
        let xfb_result_size = if xfb64 { 8 * 2 } else { 4 * 2 };
        let ps_results_size = 8;
        let pgq_result_flags = vk::QueryResultFlags::WAIT
            | if pgq64 {
                vk::QueryResultFlags::_64
            } else {
                vk::QueryResultFlags::empty()
            };
        let xfb_result_flags = vk::QueryResultFlags::WAIT
            | if xfb64 {
                vk::QueryResultFlags::_64
            } else {
                vk::QueryResultFlags::empty()
            };
        let ps_result_flags = vk::QueryResultFlags::WAIT;

        let pgq_query_count = 1u32;
        let xfb_query_count = if params.concurrent_test_type == ConcurrentTestType::TwoXfbInsidePgq {
            2u32
        } else {
            0
        };
        let ps_query_count = u32::from(params.pipeline_statistics());

        let mut pgq_results = vec![255u8; pgq_result_size];
        let mut xfb_results: Vec<Vec<u8>> = (0..xfb_query_count).map(|_| vec![255u8; xfb_result_size]).collect();
        let mut psq_results: Vec<Vec<u8>> = (0..ps_query_count).map(|_| vec![255u8; ps_results_size]).collect();

        let make_pool = |query_type: vk::QueryType,
                         query_count: u32,
                         pipeline_statistics: vk::QueryPipelineStatisticFlags|
         -> Result<Unique<'_, vk::QueryPool>, TestError> {
            let info = vk::QueryPoolCreateInfo::builder()
                .query_type(query_type)
                .query_count(query_count)
                .pipeline_statistics(pipeline_statistics);
            Ok(Unique::new(
                device,
                unsafe { device.create_query_pool(&info, None) }.vk_check("vkCreateQueryPool")?,
            ))
        };
        let pgq_pool = make_pool(
            vk::QueryType::PRIMITIVES_GENERATED_EXT,
            pgq_query_count,
            vk::QueryPipelineStatisticFlags::empty(),
        )?;
        let xfb_pool = if xfb_query_count > 0 {
            Some(make_pool(
                vk::QueryType::TRANSFORM_FEEDBACK_STREAM_EXT,
                xfb_query_count,
                vk::QueryPipelineStatisticFlags::empty(),
            )?)
        } else {
            None
        };
        let psq_pool = if ps_query_count > 0 {
            Some(make_pool(
                vk::QueryType::PIPELINE_STATISTICS,
                ps_query_count,
                vk::QueryPipelineStatisticFlags::INPUT_ASSEMBLY_PRIMITIVES,
            )?)
        } else {
            None
        };

        let primitives_written = primitives_generated - 3;
        let vertices_written = (info.num_vertices)(primitives_written);
        let primitive_size = if params.non_zero_streams() {
            1
        } else {
            u64::from(info.primitive_size)
        };
        let bytes_per_vertex = (4 * std::mem::size_of::<f32>()) as u64;
        let xfb_buffer_size = primitives_written * primitive_size * bytes_per_vertex;
        let xfb_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(xfb_buffer_size, vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        {
            let mut vertices = vec![[0.0f32; 2]; vertex_count as usize];
            self.fill_vertex_buffer(&mut vertices, primitives_generated);
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr().cast::<u8>(),
                    vtx_buffer.get_allocation().get_host_ptr(),
                    vtx_buffer_size as usize,
                )
            };
            flush_alloc(device, vtx_buffer.get_allocation())?;
        }

        let color_output_buffer_size = u64::from(IMAGE_WIDTH * IMAGE_HEIGHT) * 4;
        let color_output_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_output_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let indirect_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(
                std::mem::size_of::<vk::DrawIndirectCommand>() as u64,
                vk::BufferUsageFlags::INDIRECT_BUFFER,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        if params.indirect {
            let command = [vertex_count, INSTANCE_COUNT, FIRST_VERTEX, FIRST_INSTANCE];
            unsafe {
                std::ptr::copy_nonoverlapping(
                    command.as_ptr().cast::<u8>(),
                    indirect_buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of_val(&command),
                )
            };
            flush_alloc(device, indirect_buffer.get_allocation())?;
        }

        let secondary_cmd_buffer_used = params.concurrent_test_type == ConcurrentTestType::PgqSecondaryCmdBuffer;
        let query_control_flags = vk::QueryControlFlags::empty();
        let vertex_buffer_offset = 0u64;
        let full_render_area = make_rect_2d(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
        let xfb_stream_index = params.xfb_stream_index();

        let cmd_buffer = if secondary_cmd_buffer_used { secondary } else { primary };
        if secondary_cmd_buffer_used {
            crate::vk::cmd_util::begin_secondary_command_buffer(device, cmd_buffer, *render_pass, 0, *framebuffer)?;
        } else {
            begin_command_buffer(device, cmd_buffer)?;
            prepare_color_attachment(device, cmd_buffer, color_image.get(), color_subresource_range);
        }

        if params.concurrent_test_type == ConcurrentTestType::PipelineStatistics3 {
            let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                .render_pass(*render_pass)
                .subpass(0)
                .framebuffer(*framebuffer)
                .occlusion_query_enable(false)
                .query_flags(query_control_flags)
                .pipeline_statistics(vk::QueryPipelineStatisticFlags::INPUT_ASSEMBLY_PRIMITIVES);
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                .inheritance_info(&inheritance_info);
            unsafe {
                device
                    .begin_command_buffer(secondary, &begin_info)
                    .vk_check("vkBeginCommandBuffer")?;
                device.cmd_begin_query_indexed_ext(secondary, *pgq_pool, 0, query_control_flags, PGQ_STREAM_INDEX);
                device.cmd_bind_pipeline(secondary, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_vertex_buffers(secondary, 0, &[vtx_buffer.get()], &[vertex_buffer_offset]);
            }
            self.draw(secondary, vertex_count, indirect_buffer.get());
            unsafe { device.cmd_end_query_indexed_ext(secondary, *pgq_pool, 0, PGQ_STREAM_INDEX) };
            end_command_buffer(device, secondary)?;
        }

        // After query pool creation, each query must be reset before it is used.
        unsafe {
            if !secondary_cmd_buffer_used {
                device.cmd_reset_query_pool(cmd_buffer, *pgq_pool, 0, pgq_query_count);
                if let Some(pool) = &xfb_pool {
                    device.cmd_reset_query_pool(cmd_buffer, **pool, 0, xfb_query_count);
                }
                if let Some(pool) = &psq_pool {
                    device.cmd_reset_query_pool(cmd_buffer, **pool, 0, ps_query_count);
                }
            }

            device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vtx_buffer.get()], &[vertex_buffer_offset]);
        }

        let begin_color_render_pass = |cmd: vk::CommandBuffer| {
            begin_render_pass_with_contents(
                device,
                cmd,
                *render_pass,
                *framebuffer,
                full_render_area,
                clear_color,
                vk::SubpassContents::INLINE,
            )
        };
        let psq = || **psq_pool.as_ref().expect("a pipeline statistics case has a pool");

        match params.concurrent_test_type {
            ConcurrentTestType::TwoXfbInsidePgq => {
                let xfb_pool = **xfb_pool.as_ref().expect("two xfb queries need their pool");
                begin_color_render_pass(cmd_buffer);
                // Begin PGQ
                unsafe {
                    device.cmd_begin_query_indexed_ext(cmd_buffer, *pgq_pool, 0, query_control_flags, PGQ_STREAM_INDEX)
                };
                self.draw(cmd_buffer, vertex_count, indirect_buffer.get());

                for query in 0..2u32 {
                    // Begin XFBQ
                    unsafe {
                        device.cmd_bind_transform_feedback_buffers_ext(
                            cmd_buffer,
                            xfb_stream_index,
                            &[xfb_buffer.get()],
                            &[0],
                            &[xfb_buffer_size],
                        );
                        device.cmd_begin_query_indexed_ext(
                            cmd_buffer,
                            xfb_pool,
                            query,
                            query_control_flags,
                            xfb_stream_index,
                        );
                        (device.commands().cmd_begin_transform_feedback_ext)(
                            cmd_buffer,
                            0,
                            0,
                            std::ptr::null(),
                            std::ptr::null(),
                        );
                    }
                    self.draw(cmd_buffer, vertex_count, indirect_buffer.get());
                    // End XFBQ
                    unsafe {
                        device.cmd_end_query_indexed_ext(cmd_buffer, xfb_pool, query, xfb_stream_index);
                        (device.commands().cmd_end_transform_feedback_ext)(
                            cmd_buffer,
                            0,
                            0,
                            std::ptr::null(),
                            std::ptr::null(),
                        );
                    }
                    self.draw(cmd_buffer, vertex_count, indirect_buffer.get());
                }

                // End PGQ
                unsafe { device.cmd_end_query_indexed_ext(cmd_buffer, *pgq_pool, 0, PGQ_STREAM_INDEX) };
                end_render_pass(device, cmd_buffer);
            }
            ConcurrentTestType::PgqSecondaryCmdBuffer => {
                unsafe {
                    device.cmd_begin_query_indexed_ext(cmd_buffer, *pgq_pool, 0, query_control_flags, PGQ_STREAM_INDEX)
                };
                self.draw(cmd_buffer, vertex_count, indirect_buffer.get());
                unsafe { device.cmd_end_query_indexed_ext(cmd_buffer, *pgq_pool, 0, PGQ_STREAM_INDEX) };
            }
            ConcurrentTestType::PipelineStatistics1 => {
                unsafe {
                    device.cmd_begin_query_indexed_ext(cmd_buffer, *pgq_pool, 0, query_control_flags, PGQ_STREAM_INDEX);
                    device.cmd_begin_query(cmd_buffer, psq(), 0, query_control_flags);
                }
                begin_color_render_pass(cmd_buffer);
                self.draw(cmd_buffer, vertex_count, indirect_buffer.get());
                end_render_pass(device, cmd_buffer);
                unsafe { device.cmd_end_query_indexed_ext(cmd_buffer, *pgq_pool, 0, PGQ_STREAM_INDEX) };
                sync_color_render_passes(device, cmd_buffer);
                begin_color_render_pass(cmd_buffer);
                self.draw(cmd_buffer, vertex_count, indirect_buffer.get());
                end_render_pass(device, cmd_buffer);
                unsafe { device.cmd_end_query(cmd_buffer, psq(), 0) };
            }
            ConcurrentTestType::PipelineStatistics2 => {
                unsafe {
                    device.cmd_begin_query_indexed_ext(cmd_buffer, *pgq_pool, 0, query_control_flags, PGQ_STREAM_INDEX)
                };
                begin_color_render_pass(cmd_buffer);
                unsafe { device.cmd_begin_query(cmd_buffer, psq(), 0, query_control_flags) };
                self.draw(cmd_buffer, vertex_count, indirect_buffer.get());
                unsafe { device.cmd_end_query(cmd_buffer, psq(), 0) };
                end_render_pass(device, cmd_buffer);
                sync_color_render_passes(device, cmd_buffer);
                begin_color_render_pass(cmd_buffer);
                self.draw(cmd_buffer, vertex_count, indirect_buffer.get());
                end_render_pass(device, cmd_buffer);
                unsafe { device.cmd_end_query_indexed_ext(cmd_buffer, *pgq_pool, 0, PGQ_STREAM_INDEX) };
            }
            ConcurrentTestType::PipelineStatistics3 => {
                unsafe { device.cmd_begin_query(cmd_buffer, psq(), 0, query_control_flags) };
                begin_render_pass_with_contents(
                    device,
                    cmd_buffer,
                    *render_pass,
                    *framebuffer,
                    full_render_area,
                    clear_color,
                    vk::SubpassContents::SECONDARY_COMMAND_BUFFERS,
                );
                unsafe { device.cmd_execute_commands(cmd_buffer, &[secondary]) };
                end_render_pass(device, cmd_buffer);
                sync_color_render_passes(device, cmd_buffer);
                begin_color_render_pass(cmd_buffer);
                unsafe {
                    device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                    device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vtx_buffer.get()], &[vertex_buffer_offset]);
                }
                self.draw(cmd_buffer, vertex_count, indirect_buffer.get());
                end_render_pass(device, cmd_buffer);
                unsafe { device.cmd_end_query(cmd_buffer, psq(), 0) };
            }
        }

        if !secondary_cmd_buffer_used {
            copy_color_image_to_buffer(device, cmd_buffer, color_image.get(), color_output_buffer.get());
        }
        end_command_buffer(device, cmd_buffer)?;

        if secondary_cmd_buffer_used {
            begin_command_buffer(device, primary)?;
            prepare_color_attachment(device, primary, color_image.get(), color_subresource_range);
            unsafe {
                device.cmd_reset_query_pool(primary, *pgq_pool, 0, pgq_query_count);
                if let Some(pool) = &xfb_pool {
                    device.cmd_reset_query_pool(primary, **pool, 0, xfb_query_count);
                }
                if let Some(pool) = &psq_pool {
                    device.cmd_reset_query_pool(primary, **pool, 0, ps_query_count);
                }
            }
            begin_render_pass_with_contents(
                device,
                primary,
                *render_pass,
                *framebuffer,
                full_render_area,
                clear_color,
                vk::SubpassContents::SECONDARY_COMMAND_BUFFERS,
            );
            unsafe { device.cmd_execute_commands(primary, &[secondary]) };
            end_render_pass(device, primary);
            copy_color_image_to_buffer(device, primary, color_image.get(), color_output_buffer.get());
            end_command_buffer(device, primary)?;
        }

        submit_commands_and_wait(device, queue, primary)?;

        unsafe {
            let pgq_stride = pgq_results.len() as vk::DeviceSize;
            device
                .get_query_pool_results(
                    *pgq_pool,
                    0,
                    pgq_query_count,
                    &mut pgq_results,
                    pgq_stride,
                    pgq_result_flags,
                )
                .vk_check("vkGetQueryPoolResults")?;
            for (i, results) in xfb_results.iter_mut().enumerate() {
                let stride = results.len() as vk::DeviceSize;
                device
                    .get_query_pool_results(
                        **xfb_pool.as_ref().expect("xfb results have a pool"),
                        i as u32,
                        1,
                        results,
                        stride,
                        xfb_result_flags,
                    )
                    .vk_check("vkGetQueryPoolResults")?;
            }
            for (i, results) in psq_results.iter_mut().enumerate() {
                let stride = results.len() as vk::DeviceSize;
                device
                    .get_query_pool_results(
                        **psq_pool.as_ref().expect("ps results have a pool"),
                        i as u32,
                        1,
                        results,
                        stride,
                        ps_result_flags,
                    )
                    .vk_check("vkGetQueryPoolResults")?;
            }
        }

        // Validate counters.
        let mut pgq_draw_count = 1u32;
        if params.concurrent_test_type == ConcurrentTestType::TwoXfbInsidePgq {
            pgq_draw_count = 5;
        } else if params.concurrent_test_type == ConcurrentTestType::PipelineStatistics2 {
            pgq_draw_count = 2;
        }
        let total_primitives_generated = (primitives_generated * u64::from(pgq_draw_count)) as u32 as u64;

        let pgq_generated = read_counter(&pgq_results, pgq64, 0);
        let _ = (vertices_written, xfb_buffer_size);

        if pgq_generated != total_primitives_generated {
            return Ok(TestStatus::fail(format!(
                "Total pgqGenerated == {pgq_generated}, expected {total_primitives_generated}"
            )));
        }

        for results in &xfb_results {
            let xfb_written = read_counter(results, xfb64, 0);
            let xfb_generated = read_counter(results, xfb64, 1);

            if xfb_generated != primitives_generated {
                return Ok(TestStatus::fail(format!(
                    "xfbGenerated == {xfb_generated}, expected {primitives_generated}"
                )));
            }
            if xfb_written != primitives_written {
                return Ok(TestStatus::fail(format!(
                    "xfbWritten == {xfb_written}, expected {primitives_written}"
                )));
            }
            if xfb_written != primitives_generated - 3 {
                return Ok(TestStatus::fail(format!(
                    "xfbWritten == {xfb_written}, expected {}",
                    primitives_generated - 3
                )));
            }
        }

        if ps_query_count > 0 {
            // The pipeline statistics result is read as 32 bit elements, as upstream's `QueryResults` union does.
            let input_assembly_primitives = read_counter(&psq_results[0], false, 0);
            let draw_count = if matches!(
                params.concurrent_test_type,
                ConcurrentTestType::PipelineStatistics1 | ConcurrentTestType::PipelineStatistics3
            ) {
                2
            } else {
                1
            };
            if input_assembly_primitives < primitives_generated * draw_count {
                return Ok(TestStatus::fail(format!(
                    "input assembly primitives == {input_assembly_primitives}, expected {}",
                    primitives_generated * draw_count
                )));
            }
        }

        // The colour: the middle row is green and everything else is the background.
        invalidate_alloc(device, color_output_buffer.get_allocation())?;
        let result = unsafe {
            std::slice::from_raw_parts(
                color_output_buffer.get_allocation().get_host_ptr().cast_const(),
                color_output_buffer_size as usize,
            )
        };
        let color_row = 8u32; // The middle row.
        for y in 0..IMAGE_HEIGHT {
            for x in 0..IMAGE_WIDTH {
                let offset = ((y * IMAGE_WIDTH + x) * 4) as usize;
                let expected: [u8; 4] = if y == color_row { [0, 255, 0, 255] } else { [0, 0, 0, 0] };
                if result[offset..offset + 4] != expected {
                    return Ok(TestStatus::fail(format!(
                        "Color buffer contains unexpected results: {:?} at ({x}, {y}), expected {expected:?}",
                        &result[offset..offset + 4]
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `concurrent` part of `testGenerator`.
pub fn create_concurrent_tests() -> TestCaseGroup {
    const CONCURRENT_TEST_TYPES: [(ConcurrentTestType, &str); 5] = [
        (ConcurrentTestType::TwoXfbInsidePgq, "two_xfbq_inside_pgq"),
        (ConcurrentTestType::PgqSecondaryCmdBuffer, "pgq_secondary_cmd_buffers"),
        (ConcurrentTestType::PipelineStatistics1, "pipeline_statistics_1"),
        (ConcurrentTestType::PipelineStatistics2, "pipeline_statistics_2"),
        (ConcurrentTestType::PipelineStatistics3, "pipeline_statistics_3"),
    ];
    const RESULT_TYPES: [(QueryResultType, &str); 4] = [
        (QueryResultType::Bits32, "32bit"),
        (QueryResultType::Bits64, "64bit"),
        (QueryResultType::Pgq32Xfb64, "pgq_32bit_xfb_64bit"),
        (QueryResultType::Pgq64Xfb32, "pgq_64bit_xfb_32bit"),
    ];
    // Testing only with geometry shaders, so no patch list.
    const TOPOLOGIES: [vk::PrimitiveTopology; 10] = [
        vk::PrimitiveTopology::POINT_LIST,
        vk::PrimitiveTopology::LINE_LIST,
        vk::PrimitiveTopology::LINE_STRIP,
        vk::PrimitiveTopology::TRIANGLE_LIST,
        vk::PrimitiveTopology::TRIANGLE_STRIP,
        vk::PrimitiveTopology::TRIANGLE_FAN,
        vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
        vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
        vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
        vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
    ];
    const DRAW_TYPES: [(bool, &str); 2] = [(false, "draw"), (true, "indirect")];

    let mut concurrent_group = TestCaseGroup::new("concurrent");
    for (concurrent_test_type, type_name) in CONCURRENT_TEST_TYPES {
        let mut type_group = TestCaseGroup::new(type_name);
        for (query_result_type, result_name) in RESULT_TYPES {
            let mut result_group = TestCaseGroup::new(result_name);
            for topology in TOPOLOGIES {
                let mut topology_group = TestCaseGroup::new(topology_name(topology));
                for (indirect, draw_name) in DRAW_TYPES {
                    let params = Params {
                        concurrent_test_type,
                        query_result_type,
                        primitive_topology: topology,
                        indirect,
                    };
                    let programs_name = format!(
                        "{}_{}",
                        if params.transform_feedback() { "xfb" } else { "plain" },
                        topology_name(topology)
                    );
                    let programs = ALL_PGQ_CONCURRENT_PROGRAMS
                        .iter()
                        .find(|programs| programs.name == programs_name)
                        .unwrap_or_else(|| panic!("no concurrent shaders named {programs_name}"))
                        .programs;
                    topology_group.add_child(Box::new(ConcurrentCase {
                        name: draw_name,
                        params,
                        programs,
                    }) as Box<dyn TestCase>);
                }
                result_group.add_child(topology_group);
            }
            type_group.add_child(result_group);
        }
        concurrent_group.add_child(type_group);
    }
    concurrent_group
}
