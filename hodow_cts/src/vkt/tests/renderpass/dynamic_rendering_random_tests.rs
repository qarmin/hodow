// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/renderpass/vktDynamicRenderingRandomTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Fifty random dynamic rendering passes into one layered image: a quad drawn through one of six
// pipeline kinds, optionally with a secondary command buffer, an occlusion query, a load or clear
// and a suspend that resumes in a new primary command buffer. The reference image is tracked on
// the host. The shaders are in `shaders/manifest/renderpass_dynamic_rendering_random.toml`.
//
// Setup happens at the start of `iterate` rather than in the constructor, since
// `create_instance` cannot report an error.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use crate::generated::shaders::renderpass_dynamic_rendering_random::{
    RANDOM_G0_T0_M0, RANDOM_G0_T0_M1, RANDOM_G0_T1_M0, RANDOM_G0_T1_M1, RANDOM_G1_T0_M0, RANDOM_G1_T0_M1,
    RANDOM_G1_T1_M0, RANDOM_G1_T1_M1,
};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::base_class::create_host_buffer;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_color_image, create_draw_pipeline};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;
const RENDER_SIZE: u32 = 256;
/// Multiview with three bits can be used.
const MAX_QUERIES: u32 = 50 * 3;
const NUM_LAYERS: u32 = 4;
const NUM_ITERATIONS: u32 = 50;
const MULTIVIEW_MASK: u32 = 0xb;
const PUSH_CONSTANT_SIZE: usize = 52;

#[derive(Clone, Copy)]
struct TestParameters {
    enable_geometry: bool,
    enable_tessellation: bool,
    enable_multiview: bool,
    random_seed: u32,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum PipelineType {
    VertexFragment = 0,
    VertexGeomFragment = 1,
    VertexTessFragment = 2,
    VertexGeomFragmentLayer = 3,
    VertexFragmentMultiview = 4,
    AttachmentClear = 5,
}

const PIPELINE_TYPE_MAX: u32 = 6;

impl PipelineType {
    fn from_index(index: u32) -> Self {
        match index {
            0 => Self::VertexFragment,
            1 => Self::VertexGeomFragment,
            2 => Self::VertexTessFragment,
            3 => Self::VertexGeomFragmentLayer,
            4 => Self::VertexFragmentMultiview,
            _ => Self::AttachmentClear,
        }
    }

    fn bit(self) -> u32 {
        1 << self as u32
    }
}

/// `PushConstantData`
fn push_constant_bytes(scale: [f32; 4], offset: [f32; 4], color: [f32; 4], layer: i32) -> [u8; PUSH_CONSTANT_SIZE] {
    let mut bytes = [0u8; PUSH_CONSTANT_SIZE];
    for (i, value) in scale.iter().chain(offset.iter()).chain(color.iter()).enumerate() {
        bytes[i * 4..i * 4 + 4].copy_from_slice(&value.to_ne_bytes());
    }
    bytes[48..52].copy_from_slice(&layer.to_ne_bytes());
    bytes
}

/// `RandomTestCase`
struct RandomTestCase {
    name: String,
    parameters: TestParameters,
}

impl TestCase for RandomTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        context.require_device_functionality("VK_KHR_dynamic_rendering")?;
        if self.parameters.enable_multiview {
            context.require_device_functionality("VK_KHR_multiview")?;
        }
        if self.parameters.enable_geometry && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }
        if self.parameters.enable_tessellation && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let parameters = &self.parameters;
        match (
            parameters.enable_geometry,
            parameters.enable_tessellation,
            parameters.enable_multiview,
        ) {
            (false, false, false) => RANDOM_G0_T0_M0.programs,
            (false, false, true) => RANDOM_G0_T0_M1.programs,
            (false, true, false) => RANDOM_G0_T1_M0.programs,
            (false, true, true) => RANDOM_G0_T1_M1.programs,
            (true, false, false) => RANDOM_G1_T0_M0.programs,
            (true, false, true) => RANDOM_G1_T0_M1.programs,
            (true, true, false) => RANDOM_G1_T1_M0.programs,
            (true, true, true) => RANDOM_G1_T1_M1.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(DynamicRenderingTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

/// `DynamicRenderingTestInstance`
struct DynamicRenderingTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: TestParameters,
}

impl TestInstance for DynamicRenderingTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let parameters = self.parameters;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let alloc = context.get_default_allocator();
        let mut random = Random::new(parameters.random_seed);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;

        let vertices: [[f32; 4]; 4] = [
            [-0.5, 0.5, 0.0, 1.0],
            [-0.5, -0.5, 0.0, 1.0],
            [0.5, 0.5, 0.0, 1.0],
            [0.5, -0.5, 0.0, 1.0],
        ];
        let vertex_buffer = create_host_buffer(context, &vertices, vk::BufferUsageFlags::VERTEX_BUFFER)?;

        let layer_size_bytes = (RENDER_SIZE * RENDER_SIZE * 4) as usize;
        let image_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(IMAGE_FORMAT)
            .extent(vk::Extent3D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
                depth: 1,
            })
            .mip_levels(1)
            .array_layers(NUM_LAYERS)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(
                vk::ImageUsageFlags::COLOR_ATTACHMENT
                    | vk::ImageUsageFlags::TRANSFER_SRC
                    | vk::ImageUsageFlags::TRANSFER_DST,
            )
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let image_color = ImageWithMemory::new(device, alloc, image_info, MemoryRequirement::ANY)?;
        let image_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                (layer_size_bytes * NUM_LAYERS as usize) as vk::DeviceSize,
                vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let color_attachment_view = make_image_view(
            device,
            image_color.get(),
            vk::ImageViewType::_2D_ARRAY,
            IMAGE_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, NUM_LAYERS),
        )?;
        unsafe {
            std::ptr::write_bytes(
                image_buffer.get_allocation().get_host_ptr(),
                0,
                layer_size_bytes * NUM_LAYERS as usize,
            )
        };
        flush_alloc(device, image_buffer.get_allocation())?;

        let push_constant_range = vk::PushConstantRange::builder()
            .stage_flags(vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::GEOMETRY)
            .offset(0)
            .size(PUSH_CONSTANT_SIZE as u32)
            .build();
        let push_constant_ranges = [push_constant_range];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&push_constant_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;
        let geometry_modules = if parameters.enable_geometry {
            Some((
                create_shader_module(device, binaries.get("vertPassthrough")?)?,
                create_shader_module(device, binaries.get("vertLayer")?)?,
                create_shader_module(device, binaries.get("geom")?)?,
                create_shader_module(device, binaries.get("geomLayer")?)?,
            ))
        } else {
            None
        };
        let tessellation_modules = if parameters.enable_tessellation {
            Some((
                create_shader_module(device, binaries.get("tsc")?)?,
                create_shader_module(device, binaries.get("tse")?)?,
            ))
        } else {
            None
        };

        let make_pipeline = |stages: &[(vk::ShaderStageFlags, vk::ShaderModule)],
                             topology: vk::PrimitiveTopology,
                             view_mask: u32,
                             patch_control_points: Option<u32>| {
            let mut state = DrawPipelineState::new(topology).with_full_viewport(RENDER_SIZE, RENDER_SIZE);
            state.bindings = vec![vk::VertexInputBindingDescription {
                binding: 0,
                stride: std::mem::size_of::<[f32; 4]>() as u32,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            state.attributes = vec![vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            }];
            state.rendering_format = Some(IMAGE_FORMAT);
            state.view_mask = view_mask;
            state.patch_control_points = patch_control_points;
            create_draw_pipeline(device, *pipeline_layout, vk::RenderPass::null(), stages, &state)
        };
        let vertex_fragment = [
            (vk::ShaderStageFlags::VERTEX, *vertex_module),
            (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
        ];

        let pipeline_basic = make_pipeline(&vertex_fragment, vk::PrimitiveTopology::TRIANGLE_STRIP, 0, None)?;
        let pipeline_geom = match &geometry_modules {
            Some((passthrough, _, geometry, _)) => Some(make_pipeline(
                &[
                    (vk::ShaderStageFlags::VERTEX, **passthrough),
                    (vk::ShaderStageFlags::GEOMETRY, **geometry),
                    (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
                ],
                vk::PrimitiveTopology::POINT_LIST,
                0,
                None,
            )?),
            None => None,
        };
        let pipeline_layer = match &geometry_modules {
            Some((_, layer, _, geometry_layer)) => Some(make_pipeline(
                &[
                    (vk::ShaderStageFlags::VERTEX, **layer),
                    (vk::ShaderStageFlags::GEOMETRY, **geometry_layer),
                    (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
                ],
                vk::PrimitiveTopology::TRIANGLE_STRIP,
                0,
                None,
            )?),
            None => None,
        };
        let pipeline_tess = match &tessellation_modules {
            Some((tsc, tse)) => Some(make_pipeline(
                &[
                    (vk::ShaderStageFlags::VERTEX, *vertex_module),
                    (vk::ShaderStageFlags::TESSELLATION_CONTROL, **tsc),
                    (vk::ShaderStageFlags::TESSELLATION_EVALUATION, **tse),
                    (vk::ShaderStageFlags::FRAGMENT, *fragment_module),
                ],
                vk::PrimitiveTopology::PATCH_LIST,
                0,
                Some(4),
            )?),
            None => None,
        };
        let pipeline_multiview = make_pipeline(
            &vertex_fragment,
            vk::PrimitiveTopology::TRIANGLE_STRIP,
            MULTIVIEW_MASK,
            None,
        )?;

        let query_results = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(
                1024,
                vk::BufferUsageFlags::UNIFORM_BUFFER | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let query_pool_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::OCCLUSION)
            .query_count(MAX_QUERIES);
        let query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_info, None) }.vk_check("vkCreateQueryPool")?,
        );

        let mut cmd_buffers = Vec::new();
        let mut secondary_cmd_buffers = Vec::new();
        let mut reference: Vec<Vec<[f32; 4]>> = (0..NUM_LAYERS)
            .map(|_| vec![[0.0; 4]; (RENDER_SIZE * RENDER_SIZE) as usize])
            .collect();

        cmd_buffers.push(allocate_command_buffer(
            device,
            *cmd_pool,
            vk::CommandBufferLevel::PRIMARY,
        )?);
        begin_command_buffer(device, cmd_buffers.last().expect("pushed above").get())?;
        unsafe {
            device.cmd_reset_query_pool(
                cmd_buffers.last().expect("pushed above").get(),
                *query_pool,
                0,
                MAX_QUERIES,
            )
        };

        clear_color_image(
            context,
            image_color.get(),
            [0.0; 4],
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::PipelineStageFlags::FRAGMENT_SHADER,
            1,
            NUM_LAYERS,
        )?;

        let mut prev_flags = vk::RenderingFlags::empty();
        let mut clear_color = [0.0f32; 4];
        let mut render_area = vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D { width: 0, height: 0 },
        };
        let mut load_op = vk::AttachmentLoadOp::CLEAR;
        let mut render_width = 0u32;
        let mut render_height = 0u32;
        let mut render_x = 0u32;
        let mut render_y = 0u32;
        let mut quad_shrink = 0u32;
        let mut query_index = 0u32;
        let mut query_multiview_count: Vec<u32> = Vec::new();
        let mut pipeline_type = PipelineType::VertexFragment;

        let pipeline_for = |pipeline_type: PipelineType| -> vk::Pipeline {
            match pipeline_type {
                PipelineType::VertexFragment | PipelineType::AttachmentClear => *pipeline_basic,
                PipelineType::VertexGeomFragment => {
                    pipeline_geom.as_ref().map(|pipeline| **pipeline).unwrap_or_default()
                }
                PipelineType::VertexTessFragment => {
                    pipeline_tess.as_ref().map(|pipeline| **pipeline).unwrap_or_default()
                }
                PipelineType::VertexGeomFragmentLayer => {
                    pipeline_layer.as_ref().map(|pipeline| **pipeline).unwrap_or_default()
                }
                PipelineType::VertexFragmentMultiview => *pipeline_multiview,
            }
        };

        let mut valid_pipelines = PipelineType::VertexFragment.bit() | PipelineType::AttachmentClear.bit();
        if parameters.enable_multiview {
            valid_pipelines |= PipelineType::VertexFragmentMultiview.bit();
        }
        if parameters.enable_geometry {
            valid_pipelines |= PipelineType::VertexGeomFragment.bit() | PipelineType::VertexGeomFragmentLayer.bit();
        }
        if parameters.enable_tessellation {
            valid_pipelines |= PipelineType::VertexTessFragment.bit();
        }

        for i in 0..NUM_ITERATIONS {
            let mut flags = vk::RenderingFlags::empty();
            let use_secondary_cmd_buffer = random.get_uint32() % 5 == 0;
            let mut bind_pipeline_before_begin_rendering = random.get_bool();

            if use_secondary_cmd_buffer {
                flags |= vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS;
                bind_pipeline_before_begin_rendering = false;
            }

            if prev_flags.contains(vk::RenderingFlags::SUSPENDING) {
                flags |= vk::RenderingFlags::RESUMING;

                end_command_buffer(device, cmd_buffers.last().expect("never empty").get())?;
                cmd_buffers.push(allocate_command_buffer(
                    device,
                    *cmd_pool,
                    vk::CommandBufferLevel::PRIMARY,
                )?);
                begin_command_buffer(device, cmd_buffers.last().expect("pushed above").get())?;

                quad_shrink += 1;
                bind_pipeline_before_begin_rendering = false;
            } else {
                clear_color = [random.get_float(), random.get_float(), random.get_float(), 1.0];

                let min_area_size = 32u32;
                render_width = (random.get_uint32() % (RENDER_SIZE / 2 - min_area_size) + min_area_size) & !1u32;
                render_height = (random.get_uint32() % (RENDER_SIZE / 2 - min_area_size) + min_area_size) & !1u32;
                render_x = random.get_uint32() % (RENDER_SIZE - render_width);
                render_y = random.get_uint32() % (RENDER_SIZE - render_height);
                render_area = vk::Rect2D {
                    offset: vk::Offset2D {
                        x: render_x as i32,
                        y: render_y as i32,
                    },
                    extent: vk::Extent2D {
                        width: render_width,
                        height: render_height,
                    },
                };
                load_op = if random.get_bool() {
                    vk::AttachmentLoadOp::CLEAR
                } else {
                    vk::AttachmentLoadOp::LOAD
                };
                quad_shrink = 0;
            }

            if !prev_flags.contains(vk::RenderingFlags::SUSPENDING)
                || pipeline_type != PipelineType::VertexFragmentMultiview
            {
                let mut pipeline_mask = valid_pipelines;

                if prev_flags.contains(vk::RenderingFlags::SUSPENDING) {
                    if pipeline_type != PipelineType::VertexFragmentMultiview {
                        pipeline_mask &= !PipelineType::VertexFragmentMultiview.bit();
                    }

                    let layered_pipelines =
                        PipelineType::VertexGeomFragmentLayer.bit() | PipelineType::AttachmentClear.bit();
                    if pipeline_type.bit() & layered_pipelines != 0 {
                        pipeline_mask &= layered_pipelines;
                    } else {
                        pipeline_mask &= !layered_pipelines;
                    }
                }

                loop {
                    pipeline_type = PipelineType::from_index(random.get_uint32() % PIPELINE_TYPE_MAX);
                    if pipeline_type.bit() & pipeline_mask != 0 {
                        break;
                    }
                }
            }

            let occlusion_query = random.get_bool() && pipeline_type != PipelineType::AttachmentClear;
            let view_mask = if pipeline_type == PipelineType::VertexFragmentMultiview {
                MULTIVIEW_MASK
            } else {
                0
            };
            let use_layers = pipeline_type == PipelineType::VertexGeomFragmentLayer
                || pipeline_type == PipelineType::AttachmentClear;
            let suspend = random.get_uint32() % 5 == 0 && i != NUM_ITERATIONS - 1;

            if suspend {
                flags |= vk::RenderingFlags::SUSPENDING;
            }

            let clear_value = vk::ClearValue {
                color: vk::ClearColorValue { float32: clear_color },
            };
            let primary = cmd_buffers.last().expect("never empty").get();

            if bind_pipeline_before_begin_rendering {
                unsafe {
                    device.cmd_bind_pipeline(primary, vk::PipelineBindPoint::GRAPHICS, pipeline_for(pipeline_type))
                };
            }

            {
                let color_attachments = [vk::RenderingAttachmentInfo::builder()
                    .image_view(*color_attachment_view)
                    .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                    .resolve_mode(vk::ResolveModeFlags::NONE)
                    .resolve_image_layout(vk::ImageLayout::UNDEFINED)
                    .load_op(load_op)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .clear_value(clear_value)
                    .build()];
                let rendering_info = vk::RenderingInfo::builder()
                    .flags(flags)
                    .render_area(render_area)
                    .layer_count(if use_layers { NUM_LAYERS } else { 1 })
                    .view_mask(view_mask)
                    .color_attachments(&color_attachments);
                unsafe { device.cmd_begin_rendering(primary, &rendering_info) };
            }

            if use_secondary_cmd_buffer {
                secondary_cmd_buffers.push(allocate_command_buffer(
                    device,
                    *cmd_pool,
                    vk::CommandBufferLevel::SECONDARY,
                )?);

                let color_formats = [IMAGE_FORMAT];
                let mut inheritance_rendering_info = vk::CommandBufferInheritanceRenderingInfo::builder()
                    .flags(flags & !vk::RenderingFlags::CONTENTS_SECONDARY_COMMAND_BUFFERS)
                    .view_mask(view_mask)
                    .color_attachment_formats(&color_formats)
                    .depth_attachment_format(vk::Format::UNDEFINED)
                    .stencil_attachment_format(vk::Format::UNDEFINED)
                    .rasterization_samples(vk::SampleCountFlags::_1);
                let buffer_inheritance_info =
                    vk::CommandBufferInheritanceInfo::builder().push_next(&mut inheritance_rendering_info);
                let begin_info = vk::CommandBufferBeginInfo::builder()
                    .flags(
                        vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT
                            | vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE,
                    )
                    .inheritance_info(&buffer_inheritance_info);
                unsafe {
                    device.begin_command_buffer(secondary_cmd_buffers.last().expect("pushed above").get(), &begin_info)
                }
                .vk_check("vkBeginCommandBuffer")?;
            }

            let cmd_buffer = if use_secondary_cmd_buffer {
                secondary_cmd_buffers.last().expect("pushed above").get()
            } else {
                primary
            };

            if !bind_pipeline_before_begin_rendering {
                unsafe {
                    device.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, pipeline_for(pipeline_type))
                };
            }

            let render_size_f = RENDER_SIZE as f32;
            let scale_x = (render_area.extent.width - quad_shrink * 4) as f32 / render_size_f;
            let scale_y = (render_area.extent.height - quad_shrink * 4) as f32 / render_size_f;

            let pixel_size_x = 2.0 / render_size_f;
            let pixel_size_y = 2.0 / render_size_f;
            let scale = [scale_x + pixel_size_x * 0.5, scale_y + pixel_size_y * 0.5, 1.0, 1.0];
            let offset_x =
                (render_area.offset.x - ((RENDER_SIZE - render_area.extent.width) as i32) / 2) as f32 * pixel_size_x;
            let offset_y =
                (render_area.offset.y - ((RENDER_SIZE - render_area.extent.height) as i32) / 2) as f32 * pixel_size_y;
            let offset = [offset_x, offset_y, 0.0, 0.0];
            let quad_margin_x = render_width / 4 + quad_shrink;
            let quad_margin_y = render_height / 4 + quad_shrink;
            let quad_top = render_y + quad_margin_y;
            let quad_bottom = render_y + render_height - quad_margin_y;
            let quad_left = render_x + quad_margin_x;
            let quad_right = render_x + render_width - quad_margin_x;

            let color = [random.get_float(), random.get_float(), random.get_float(), 1.0];
            let layer = if use_layers {
                (random.get_uint32() % NUM_LAYERS) as i32
            } else {
                0
            };

            let pcd = push_constant_bytes(scale, offset, color, layer);

            unsafe {
                device.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[0]);

                if occlusion_query {
                    device.cmd_begin_query(cmd_buffer, *query_pool, query_index, vk::QueryControlFlags::empty());
                }

                device.cmd_push_constants(
                    cmd_buffer,
                    *pipeline_layout,
                    vk::ShaderStageFlags::VERTEX | vk::ShaderStageFlags::GEOMETRY,
                    0,
                    &pcd,
                );

                match pipeline_type {
                    PipelineType::VertexFragment
                    | PipelineType::VertexTessFragment
                    | PipelineType::VertexGeomFragmentLayer
                    | PipelineType::VertexFragmentMultiview => device.cmd_draw(cmd_buffer, 4, 1, 0, 0),
                    PipelineType::VertexGeomFragment => device.cmd_draw(cmd_buffer, 1, 1, 0, 0),
                    PipelineType::AttachmentClear => {
                        let clear_attachment = vk::ClearAttachment {
                            aspect_mask: vk::ImageAspectFlags::COLOR,
                            color_attachment: 0,
                            clear_value: vk::ClearValue {
                                color: vk::ClearColorValue { float32: color },
                            },
                        };
                        let rect = vk::ClearRect {
                            rect: vk::Rect2D {
                                offset: vk::Offset2D {
                                    x: quad_left as i32,
                                    y: quad_top as i32,
                                },
                                extent: vk::Extent2D {
                                    width: quad_right - quad_left,
                                    height: quad_bottom - quad_top,
                                },
                            },
                            base_array_layer: layer as u32,
                            layer_count: 1,
                        };
                        device.cmd_clear_attachments(cmd_buffer, &[clear_attachment], &[rect]);
                    }
                }

                if occlusion_query {
                    device.cmd_end_query(cmd_buffer, *query_pool, query_index);
                }
            }
            if occlusion_query {
                if pipeline_type == PipelineType::VertexFragmentMultiview {
                    query_index += 3;
                    query_multiview_count.extend_from_slice(&[3, 0, 0]);
                } else {
                    query_index += 1;
                    query_multiview_count.push(1);
                }
            }

            let mut active_layers_clear = 0x1u32;
            let mut active_layers_quad = 0x1u32;
            if use_layers {
                active_layers_clear = (1 << NUM_LAYERS) - 1;
                active_layers_quad = 1 << layer;
            } else if pipeline_type == PipelineType::VertexFragmentMultiview {
                active_layers_clear = view_mask;
                active_layers_quad = view_mask;
            }

            for (l, layer_pixels) in reference.iter_mut().enumerate() {
                for y in render_y..render_y + render_height {
                    for x in render_x..render_x + render_width {
                        let pixel = &mut layer_pixels[(y * RENDER_SIZE + x) as usize];
                        if load_op == vk::AttachmentLoadOp::CLEAR
                            && !flags.contains(vk::RenderingFlags::RESUMING)
                            && active_layers_clear & (1 << l) != 0
                        {
                            *pixel = clear_color;
                        }

                        if x >= quad_left
                            && x < quad_right
                            && y >= quad_top
                            && y < quad_bottom
                            && active_layers_quad & (1 << l) != 0
                        {
                            let mut ref_color = color;
                            if pipeline_type == PipelineType::VertexFragmentMultiview {
                                ref_color[2] = 0.15 * l as f32;
                            } else if pipeline_type != PipelineType::AttachmentClear {
                                ref_color[2] = 0.0;
                            }
                            *pixel = ref_color;
                        }
                    }
                }
            }

            if use_secondary_cmd_buffer {
                end_command_buffer(device, cmd_buffer)?;
                unsafe { device.cmd_execute_commands(primary, &[cmd_buffer]) };
            }

            unsafe { device.cmd_end_rendering(primary) };

            if !suspend {
                let barrier = make_memory_barrier(
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                );
                unsafe {
                    device.cmd_pipeline_barrier(
                        primary,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                        vk::DependencyFlags::empty(),
                        &[barrier],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }

            prev_flags = flags;
        }

        let last = cmd_buffers.last().expect("never empty").get();
        unsafe {
            device.cmd_copy_query_pool_results(
                last,
                *query_pool,
                0,
                query_index,
                query_results.get(),
                0,
                4,
                vk::QueryResultFlags::WAIT,
            );
        }
        // copyImageToBuffer, all layers
        {
            let to_transfer = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                image_color.get(),
                make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, NUM_LAYERS),
            );
            let copy_region = vk::BufferImageCopy {
                buffer_offset: 0,
                buffer_row_length: 0,
                buffer_image_height: 0,
                image_subresource: vk::ImageSubresourceLayers {
                    aspect_mask: vk::ImageAspectFlags::COLOR,
                    mip_level: 0,
                    base_array_layer: 0,
                    layer_count: NUM_LAYERS,
                },
                image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
                image_extent: vk::Extent3D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                    depth: 1,
                },
            };
            let to_host = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
            unsafe {
                device.cmd_pipeline_barrier(
                    last,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[to_transfer],
                );
                device.cmd_copy_image_to_buffer(
                    last,
                    image_color.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    image_buffer.get(),
                    &[copy_region],
                );
                device.cmd_pipeline_barrier(
                    last,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[to_host],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(device, last)?;

        {
            let fence =
                unsafe { device.create_fence(&vk::FenceCreateInfo::builder(), None) }.vk_check("vkCreateFence")?;
            let handles: Vec<vk::CommandBuffer> = cmd_buffers.iter().map(|cmd_buffer| cmd_buffer.get()).collect();
            let submit_info = vk::SubmitInfo::builder().command_buffers(&handles);
            let result = (|| -> Result<(), TestError> {
                unsafe { device.queue_submit(queue, &[submit_info], fence) }.vk_check("vkQueueSubmit")?;
                unsafe { device.wait_for_fences(&[fence], true, u64::MAX) }.vk_check("vkWaitForFences")?;
                Ok(())
            })();
            unsafe { device.destroy_fence(fence, None) };
            result?;
        }

        invalidate_alloc(device, image_buffer.get_allocation())?;
        let image_bytes = unsafe {
            std::slice::from_raw_parts(
                image_buffer.get_allocation().get_host_ptr(),
                layer_size_bytes * NUM_LAYERS as usize,
            )
        };
        let threshold = 0.02f32;
        for (layer_index, layer_reference) in reference.iter().enumerate() {
            let layer_bytes = &image_bytes[layer_size_bytes * layer_index..layer_size_bytes * (layer_index + 1)];
            for (pixel_index, expected) in layer_reference.iter().enumerate() {
                for channel in 0..4 {
                    let actual = layer_bytes[pixel_index * 4 + channel] as f32 / 255.0;
                    if (actual - expected[channel]).abs() > threshold {
                        return Ok(TestStatus::fail("Rendered color image is not correct"));
                    }
                }
            }
        }

        {
            invalidate_alloc(device, query_results.get_allocation())?;
            let query_ptr = query_results.get_allocation().get_host_ptr().cast::<u32>();
            let mut i = 0usize;
            while i < query_index as usize {
                let mut query_sum = 0u32;
                for _ in 0..query_multiview_count[i] {
                    // Upstream adds queryPtr[i] on every step instead of queryPtr[i + j].
                    query_sum += unsafe { query_ptr.add(i).read() };
                }
                if query_sum == 0 {
                    return Ok(TestStatus::fail("Expected nonzero occlusion query results."));
                }
                i += query_multiview_count[i] as usize;
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createDynamicRenderingRandomTests`
pub fn create_dynamic_rendering_random_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("random");

    for geometry in [true, false] {
        for tessellation in [true, false] {
            for multiview in [true, false] {
                for seed in 0..100u32 {
                    let parameters = TestParameters {
                        enable_geometry: geometry,
                        enable_tessellation: tessellation,
                        enable_multiview: multiview,
                        random_seed: seed,
                    };
                    let name = format!(
                        "seed{seed}{}{}{}",
                        if geometry { "_geometry" } else { "" },
                        if tessellation { "_tessellation" } else { "" },
                        if multiview { "_multiview" } else { "" }
                    );
                    group.add_child(Box::new(RandomTestCase { name, parameters }) as Box<dyn TestCase>);
                }
            }
        }
    }

    group
}
