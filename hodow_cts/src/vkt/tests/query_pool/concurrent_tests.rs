// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/query_pool/vktQueryPoolConcurrentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Occlusion, pipeline-statistics and timestamp queries are recorded around one draw, each pool holding an
// empty capture (slot 0) and a capture of the draw (slot 1). The secondary variant records the draw, and
// some of the queries, in a secondary command buffer. The shaders are in
// `shaders/manifest/query_pool_concurrent.toml`. Upstream's `StateObjects` is built in the instance
// constructor and its Draw-framework helpers (`Image`, `Buffer`, `*CreateInfo`) are written out here.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::query_pool_concurrent::QUERY_POOL_CONCURRENT;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::{
    initial_transition_color_2d_image, initial_transition_depth_2d_image, transition_2d_image,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const QUERY_TYPE_OCCLUSION: usize = 0;
const QUERY_TYPE_PIPELINE_STATISTICS: usize = 1;
const QUERY_TYPE_TIMESTAMP: usize = 2;
const NUM_QUERY_POOLS: usize = 3;

const NUM_QUERIES_IN_POOL: u32 = 2;
const QUERY_INDEX_CAPTURE_EMPTY: u32 = 0;
const QUERY_INDEX_CAPTURE_DRAWCALL: u32 = 1;
const NUM_VERTICES_IN_DRAWCALL: u32 = 3;

const WIDTH: u32 = 128;
const HEIGHT: u32 = 128;
const COLOR_ATTACHMENT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const DEPTH_FORMAT: vk::Format = vk::Format::D16_UNORM;

/// `StateObjects`
struct StateObjects<'a> {
    // Declared so that fields drop in dependency order: users of an object before the object.
    pipeline: Unique<'a, vk::Pipeline>,
    _pipeline_layout: Unique<'a, vk::PipelineLayout>,
    framebuffer: Unique<'a, vk::Framebuffer>,
    render_pass: Unique<'a, vk::RenderPass>,
    _attachment_view: Unique<'a, vk::ImageView>,
    _depth_view: Unique<'a, vk::ImageView>,
    color_attachment_image: ImageWithMemory<'a>,
    depth_image: ImageWithMemory<'a>,
    vertex_buffer: BufferWithMemory<'a>,
}

impl<'a> StateObjects<'a> {
    fn new(context: &'a Context<'a>, num_vertices: u32, primitive: vk::PrimitiveTopology) -> Result<Self, TestError> {
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let image_extent = vk::Extent3D {
            width: WIDTH,
            height: HEIGHT,
            depth: 1,
        };

        // attachment images and views
        let color_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(COLOR_ATTACHMENT_FORMAT)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_attachment_image = ImageWithMemory::new(device, allocator, color_image_info, MemoryRequirement::ANY)?;
        let attachment_view = make_image_view(
            device,
            color_attachment_image.get(),
            vk::ImageViewType::_2D,
            COLOR_ATTACHMENT_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let depth_image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(DEPTH_FORMAT)
            .extent(image_extent)
            .mip_levels(1)
            .array_layers(1)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let depth_image = ImageWithMemory::new(device, allocator, depth_image_info, MemoryRequirement::ANY)?;
        // Construct a depth view from depth image
        let depth_view = make_image_view(
            device,
            depth_image.get(),
            vk::ImageViewType::_2D,
            DEPTH_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::DEPTH, 0, 1, 0, 1),
        )?;

        // Renderpass and Framebuffer
        let attachments = [
            vk::AttachmentDescription::builder()
                .format(COLOR_ATTACHMENT_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::GENERAL)
                .final_layout(vk::ImageLayout::GENERAL)
                .build(),
            vk::AttachmentDescription::builder()
                .format(DEPTH_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::DONT_CARE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        let color_attachment_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::GENERAL)
            .build()];
        let depth_attachment_reference = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_attachment_references)
            .depth_stencil_attachment(&depth_attachment_reference)
            .build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &[*attachment_view, *depth_view], WIDTH, HEIGHT, 1)?;

        // Pipeline
        let binaries = context.get_binary_collection();
        let vs = create_shader_module(device, binaries.get("vert")?)?;
        let fs = create_shader_module(device, binaries.get("frag")?)?;

        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let vf_binding_descs = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: 4 * std::mem::size_of::<f32>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let vf_attribute_descs = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&vf_binding_descs)
            .vertex_attribute_descriptions(&vf_attribute_descs);

        let stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vs)
                .name(b"main\0")
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fs)
                .name(b"main\0")
                .build(),
        ];
        let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
            .topology(primitive)
            .primitive_restart_enable(false);
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: WIDTH as f32,
            height: HEIGHT as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(true)
            .depth_write_enable(true)
            .depth_compare_op(vk::CompareOp::GREATER_OR_EQUAL)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(false)
            .min_depth_bounds(0.0)
            .max_depth_bounds(1.0);
        let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
            .depth_clamp_enable(false)
            .rasterizer_discard_enable(false)
            .polygon_mode(vk::PolygonMode::FILL)
            .cull_mode(vk::CullModeFlags::NONE)
            .front_face(vk::FrontFace::CLOCKWISE)
            .depth_bias_enable(true)
            .depth_bias_constant_factor(0.0)
            .depth_bias_clamp(0.0)
            .depth_bias_slope_factor(0.0)
            .line_width(1.0);
        let multisample_state =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&stages)
            .vertex_input_state(&vertex_input_state)
            .input_assembly_state(&input_assembly_state)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterization_state)
            .multisample_state(&multisample_state)
            .depth_stencil_state(&depth_stencil_state)
            .color_blend_state(&color_blend_state)
            .layout(*pipeline_layout)
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        // Vertex buffer
        let vertex_buffer_size = num_vertices as vk::DeviceSize * std::mem::size_of::<[f32; 4]>() as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        Ok(Self {
            pipeline,
            _pipeline_layout: pipeline_layout,
            color_attachment_image,
            depth_image,
            _attachment_view: attachment_view,
            _depth_view: depth_view,
            render_pass,
            framebuffer,
            vertex_buffer,
        })
    }

    /// `StateObjects::setVertices`
    fn set_vertices(&self, device: &Device, vertices: &[[f32; 4]]) -> Result<(), TestError> {
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                self.vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(vertices),
            )
        };
        flush_alloc(device, self.vertex_buffer.get_allocation())
    }
}

/// Which query types this device can run: occlusion always, the other two when it has the feature / valid bits.
fn supported_query_types(context: &Context<'_>) -> [bool; NUM_QUERY_POOLS] {
    let mut supported = [false; NUM_QUERY_POOLS];
    supported[QUERY_TYPE_OCCLUSION] = true;
    supported[QUERY_TYPE_PIPELINE_STATISTICS] = context.get_device_features().pipeline_statistics_query != vk::FALSE;

    let queue_properties = unsafe {
        context
            .get_instance()
            .get_physical_device_queue_family_properties(context.get_physical_device())
    };
    supported[QUERY_TYPE_TIMESTAMP] =
        queue_properties[context.get_universal_queue_family_index() as usize].timestamp_valid_bits > 0;
    supported
}

/// `QueryPoolConcurrentTest<Instance>`
struct QueryPoolConcurrentTest {
    name: &'static str,
    secondary: bool,
}

impl TestCase for QueryPoolConcurrentTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        // Check support for multiple query types
        let supported = supported_query_types(context);
        if supported.iter().filter(|&&type_supported| type_supported).count() < 2 {
            return Err(TestError::NotSupported(
                "Device does not support multiple query types".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        QUERY_POOL_CONCURRENT.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(ConcurrentInstance {
            context,
            secondary: self.secondary,
        })
    }
}

/// `PrimaryCommandBufferConcurrentTestInstance` / `SecondaryCommandBufferConcurrentTestInstance`
struct ConcurrentInstance<'a> {
    context: &'a Context<'a>,
    secondary: bool,
}

/// The results of one occlusion or pipeline-statistics pool against the expectation: slot 0 (nothing drawn)
/// is zero, slot 1 (the draw) is not.
fn verify_counting_pool(device: &Device, pool: vk::QueryPool) -> Result<bool, TestError> {
    let mut result_bytes = [0u8; 16];
    let query_result = unsafe {
        device.get_query_pool_results(
            pool,
            0,
            NUM_QUERIES_IN_POOL,
            &mut result_bytes,
            8,
            vk::QueryResultFlags::_64,
        )
    }
    .vk_check("vkGetQueryPoolResults")?;
    if query_result == vk::SuccessCode::NOT_READY {
        return Err(TestError::Fail(
            "Query result not available, but vkWaitIdle() was called.".to_string(),
        ));
    }

    let query_results: [u64; 2] = std::array::from_fn(|index| {
        u64::from_ne_bytes(
            result_bytes[index * 8..index * 8 + 8]
                .try_into()
                .expect("eight bytes per result"),
        )
    });
    let mut passed = true;
    for (query_index, result) in query_results.iter().enumerate() {
        if query_index as u32 == QUERY_INDEX_CAPTURE_EMPTY && *result != 0 {
            passed = false;
        }
        if query_index as u32 != QUERY_INDEX_CAPTURE_EMPTY && *result == 0 {
            passed = false;
        }
    }
    Ok(passed)
}

/// Timestamp slot 0 was never written, so it is neither available nor non-zero, and the call reports NOT_READY.
fn verify_timestamp_pool(device: &Device, pool: vk::QueryPool) -> Result<bool, TestError> {
    let mut result_bytes = [0u8; 32];
    let query_result = unsafe {
        device.get_query_pool_results(
            pool,
            0,
            NUM_QUERIES_IN_POOL,
            &mut result_bytes,
            16,
            vk::QueryResultFlags::_64 | vk::QueryResultFlags::WITH_AVAILABILITY,
        )
    }
    .vk_check("vkGetQueryPoolResults")?;
    if query_result != vk::SuccessCode::NOT_READY {
        return Err(TestError::Fail(
            "We don't have available one query, it should return VK_NOT_READY".to_string(),
        ));
    }

    let word = |index: usize| {
        u64::from_ne_bytes(
            result_bytes[index * 8..index * 8 + 8]
                .try_into()
                .expect("eight bytes per word"),
        )
    };
    let mut passed = true;
    for query_index in 0..NUM_QUERIES_IN_POOL as usize {
        let (value, availability) = (word(query_index * 2), word(query_index * 2 + 1));
        if query_index as u32 == QUERY_INDEX_CAPTURE_EMPTY && (value != 0 || availability != 0) {
            passed = false;
        }
        if query_index as u32 != QUERY_INDEX_CAPTURE_EMPTY && (value == 0 || availability == 0) {
            passed = false;
        }
    }
    Ok(passed)
}

impl TestInstance for ConcurrentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();

        let supported = supported_query_types(context);
        let state_objects = StateObjects::new(context, NUM_VERTICES_IN_DRAWCALL, vk::PrimitiveTopology::TRIANGLE_LIST)?;

        let mut query_pools: Vec<Option<Unique<'_, vk::QueryPool>>> = Vec::with_capacity(NUM_QUERY_POOLS);
        for (pool_index, &pool_supported) in supported.iter().enumerate() {
            if !pool_supported {
                query_pools.push(None);
                continue;
            }

            let query_type = match pool_index {
                QUERY_TYPE_OCCLUSION => vk::QueryType::OCCLUSION,
                QUERY_TYPE_PIPELINE_STATISTICS => vk::QueryType::PIPELINE_STATISTICS,
                _ => vk::QueryType::TIMESTAMP,
            };
            let mut query_pool_create_info = vk::QueryPoolCreateInfo::builder()
                .query_type(query_type)
                .query_count(NUM_QUERIES_IN_POOL);
            if pool_index == QUERY_TYPE_PIPELINE_STATISTICS {
                query_pool_create_info = query_pool_create_info
                    .pipeline_statistics(vk::QueryPipelineStatisticFlags::FRAGMENT_SHADER_INVOCATIONS);
            }
            query_pools.push(Some(Unique::new(
                device,
                unsafe { device.create_query_pool(&query_pool_create_info, None) }.vk_check("vkCreateQueryPool")?,
            )));
        }
        let pool = |index: usize| -> vk::QueryPool {
            **query_pools[index]
                .as_ref()
                .expect("only used for supported query types")
        };

        let vertices: [[f32; 4]; 3] = [[0.5, 0.5, 0.0, 1.0], [0.5, 0.0, 0.0, 1.0], [0.0, 0.5, 0.0, 1.0]];
        state_objects.set_vertices(device, &vertices)?;

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer_primary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let primary = *cmd_buffer_primary;
        let render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: WIDTH,
                height: HEIGHT,
            },
        };
        let render_pass_clear_values = [vk::ClearValue {
            color: vk::ClearColorValue { float32: [0.0; 4] },
        }; 2];
        let vertex_buffer = state_objects.vertex_buffer.get();
        let bind_point = vk::PipelineBindPoint::GRAPHICS;

        let record_initial_transitions = |cmd: vk::CommandBuffer| {
            initial_transition_color_2d_image(
                device,
                cmd,
                state_objects.color_attachment_image.get(),
                vk::ImageLayout::GENERAL,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                1,
            );
            initial_transition_depth_2d_image(
                device,
                cmd,
                state_objects.depth_image.get(),
                vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS,
            );
        };
        let record_final_transition = |cmd: vk::CommandBuffer| {
            transition_2d_image(
                device,
                cmd,
                state_objects.color_attachment_image.get(),
                vk::ImageAspectFlags::COLOR,
                vk::ImageLayout::GENERAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                vk::PipelineStageFlags::TRANSFER,
                1,
            );
        };
        let begin_render_pass = |cmd: vk::CommandBuffer, contents: vk::SubpassContents| {
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*state_objects.render_pass)
                .framebuffer(*state_objects.framebuffer)
                .render_area(render_area)
                .clear_values(&render_pass_clear_values);
            unsafe { device.cmd_begin_render_pass(cmd, &begin_info, contents) };
        };

        // secondary command buffer holder, kept alive until the submission has completed
        let mut cmd_buffer_secondary = None;

        if !self.secondary {
            begin_command_buffer(device, primary)?;
            record_initial_transitions(primary);

            for pool_index in 0..NUM_QUERY_POOLS {
                if supported[pool_index] {
                    unsafe { device.cmd_reset_query_pool(primary, pool(pool_index), 0, NUM_QUERIES_IN_POOL) };
                }
            }

            begin_render_pass(primary, vk::SubpassContents::INLINE);
            unsafe {
                device.cmd_bind_pipeline(primary, bind_point, *state_objects.pipeline);
                device.cmd_bind_vertex_buffers(primary, 0, &[vertex_buffer], &[0]);

                // Begin all queries
                for pool_index in 0..QUERY_TYPE_TIMESTAMP {
                    if supported[pool_index] {
                        device.cmd_begin_query(
                            primary,
                            pool(pool_index),
                            QUERY_INDEX_CAPTURE_EMPTY,
                            vk::QueryControlFlags::empty(),
                        );
                    }
                }

                // End first capture (should not have any result). Start the second one.
                for pool_index in 0..QUERY_TYPE_TIMESTAMP {
                    if supported[pool_index] {
                        device.cmd_end_query(primary, pool(pool_index), QUERY_INDEX_CAPTURE_EMPTY);
                        device.cmd_begin_query(
                            primary,
                            pool(pool_index),
                            QUERY_INDEX_CAPTURE_DRAWCALL,
                            vk::QueryControlFlags::empty(),
                        );
                    }
                }

                device.cmd_draw(primary, NUM_VERTICES_IN_DRAWCALL, 1, 0, 0);

                if supported[QUERY_TYPE_TIMESTAMP] {
                    device.cmd_write_timestamp(
                        primary,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        pool(QUERY_TYPE_TIMESTAMP),
                        QUERY_INDEX_CAPTURE_DRAWCALL,
                    );
                }

                for pool_index in 0..QUERY_TYPE_TIMESTAMP {
                    if supported[pool_index] {
                        device.cmd_end_query(primary, pool(pool_index), QUERY_INDEX_CAPTURE_DRAWCALL);
                    }
                }

                device.cmd_end_render_pass(primary);
            }

            record_final_transition(primary);
            end_command_buffer(device, primary)?;
        } else {
            let inherited_queries = context.get_device_features().inherited_queries != vk::FALSE;
            let secondary = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::SECONDARY)?;
            let sec = *secondary;

            // Secondary command buffer recording.
            {
                let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                    .render_pass(*state_objects.render_pass)
                    .subpass(0)
                    .framebuffer(*state_objects.framebuffer)
                    .occlusion_query_enable(inherited_queries)
                    .query_flags(vk::QueryControlFlags::empty())
                    .pipeline_statistics(vk::QueryPipelineStatisticFlags::empty());
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE)
                    .inheritance_info(&inheritance_info);
                unsafe { device.begin_command_buffer(sec, &begin_info) }.vk_check("vkBeginCommandBuffer")?;

                unsafe {
                    device.cmd_bind_pipeline(sec, bind_point, *state_objects.pipeline);
                    device.cmd_bind_vertex_buffers(sec, 0, &[vertex_buffer], &[0]);

                    if !inherited_queries && supported[QUERY_TYPE_OCCLUSION] {
                        device.cmd_begin_query(
                            sec,
                            pool(QUERY_TYPE_OCCLUSION),
                            QUERY_INDEX_CAPTURE_DRAWCALL,
                            vk::QueryControlFlags::empty(),
                        );
                    }

                    // Run pipeline statistics queries capture in the second command buffer
                    if supported[QUERY_TYPE_PIPELINE_STATISTICS] {
                        device.cmd_begin_query(
                            sec,
                            pool(QUERY_TYPE_PIPELINE_STATISTICS),
                            QUERY_INDEX_CAPTURE_DRAWCALL,
                            vk::QueryControlFlags::empty(),
                        );
                    }

                    // Timestamp query happening in the secondary command buffer
                    if supported[QUERY_TYPE_TIMESTAMP] {
                        device.cmd_write_timestamp(
                            sec,
                            vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                            pool(QUERY_TYPE_TIMESTAMP),
                            QUERY_INDEX_CAPTURE_DRAWCALL,
                        );
                    }

                    device.cmd_draw(sec, NUM_VERTICES_IN_DRAWCALL, 1, 0, 0);

                    if supported[QUERY_TYPE_PIPELINE_STATISTICS] {
                        device.cmd_end_query(sec, pool(QUERY_TYPE_PIPELINE_STATISTICS), QUERY_INDEX_CAPTURE_DRAWCALL);
                    }

                    if !inherited_queries && supported[QUERY_TYPE_OCCLUSION] {
                        device.cmd_end_query(sec, pool(QUERY_TYPE_OCCLUSION), QUERY_INDEX_CAPTURE_DRAWCALL);
                    }
                }
                end_command_buffer(device, sec)?;
            }

            // Primary command buffer recording
            {
                begin_command_buffer(device, primary)?;
                record_initial_transitions(primary);

                for pool_index in 0..NUM_QUERY_POOLS {
                    if supported[pool_index] {
                        unsafe { device.cmd_reset_query_pool(primary, pool(pool_index), 0, NUM_QUERIES_IN_POOL) };
                    }
                }

                for pool_index in 0..QUERY_TYPE_TIMESTAMP {
                    if supported[pool_index] {
                        unsafe {
                            device.cmd_begin_query(
                                primary,
                                pool(pool_index),
                                QUERY_INDEX_CAPTURE_EMPTY,
                                vk::QueryControlFlags::empty(),
                            )
                        };
                    }
                }

                for pool_index in 0..QUERY_TYPE_TIMESTAMP {
                    if supported[pool_index] {
                        unsafe { device.cmd_end_query(primary, pool(pool_index), QUERY_INDEX_CAPTURE_EMPTY) };
                    }
                }

                // Run occlusion queries capture in the primary command buffer, inherit the counters for the secondary command buffer
                if inherited_queries && supported[QUERY_TYPE_OCCLUSION] {
                    unsafe {
                        device.cmd_begin_query(
                            primary,
                            pool(QUERY_TYPE_OCCLUSION),
                            QUERY_INDEX_CAPTURE_DRAWCALL,
                            vk::QueryControlFlags::empty(),
                        )
                    };
                }

                begin_render_pass(primary, vk::SubpassContents::SECONDARY_COMMAND_BUFFERS);
                unsafe {
                    device.cmd_execute_commands(primary, &[sec]);
                    device.cmd_end_render_pass(primary);
                }

                if inherited_queries && supported[QUERY_TYPE_OCCLUSION] {
                    unsafe { device.cmd_end_query(primary, pool(QUERY_TYPE_OCCLUSION), QUERY_INDEX_CAPTURE_DRAWCALL) };
                }

                record_final_transition(primary);
                end_command_buffer(device, primary)?;
            }
            cmd_buffer_secondary = Some(secondary);
        }

        submit_commands_and_wait(device, queue, primary)?;
        drop(cmd_buffer_secondary);

        let mut passed = true;

        // Occlusion and pipeline statistics queries verification
        for pool_index in 0..QUERY_TYPE_TIMESTAMP {
            if !supported[pool_index] {
                continue;
            }
            passed &= verify_counting_pool(device, pool(pool_index))?;
        }

        // Timestamp query verification
        if supported[QUERY_TYPE_TIMESTAMP] {
            passed &= verify_timestamp_pool(device, pool(QUERY_TYPE_TIMESTAMP))?;
        }

        Ok(if passed {
            TestStatus::pass("Query result verification passed")
        } else {
            TestStatus::fail("Query result verification failed")
        })
    }
}

/// `QueryPoolConcurrentTests::init`
pub fn create_concurrent_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("concurrent_queries");
    group.add_child(Box::new(QueryPoolConcurrentTest {
        name: "primary_command_buffer",
        secondary: false,
    }) as Box<dyn TestCase>);
    group.add_child(Box::new(QueryPoolConcurrentTest {
        name: "secondary_command_buffer",
        secondary: true,
    }) as Box<dyn TestCase>);
    group
}
