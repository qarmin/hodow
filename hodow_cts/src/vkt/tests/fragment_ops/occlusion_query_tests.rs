// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_ops/vktFragmentOperationsOcclusionQueryTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A fullscreen quad is drawn inside an occlusion query, after depth and/or stencil attachments have been
// cleared in part or written by small occluders, with and without a scissor. A precise query must
// report exactly the expected sample count; a conservative one any non-zero count. The shaders are in
// `shaders/manifest/fragment_ops_occlusion_query.toml`.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::fragment_ops_occlusion_query::FRAGMENT_OPS_OCCLUSION_QUERY;
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
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

const TEST_NO_FLAGS: u32 = 0;
const TEST_SCISSOR: u32 = 1 << 0;
const TEST_DEPTH_WRITE: u32 = 1 << 1;
const TEST_DEPTH_CLEAR: u32 = 1 << 2;
const TEST_STENCIL_WRITE: u32 = 1 << 3;
const TEST_STENCIL_CLEAR: u32 = 1 << 4;
const TEST_ALL: u32 = 1 << 5;
const TEST_PRECISE_BIT: u32 = 1 << 6;

/// `pickSupportedDepthStencilFormat`
fn pick_supported_depth_stencil_format(context: &Context<'_>) -> vk::Format {
    [
        vk::Format::D16_UNORM_S8_UINT,
        vk::Format::D24_UNORM_S8_UINT,
        vk::Format::D32_SFLOAT_S8_UINT,
    ]
    .into_iter()
    .find(|&format| {
        let properties = unsafe {
            context
                .get_instance()
                .get_physical_device_format_properties(context.get_physical_device(), format)
        };
        properties
            .optimal_tiling_features
            .contains(vk::FormatFeatureFlags::DEPTH_STENCIL_ATTACHMENT)
    })
    .unwrap_or(vk::Format::UNDEFINED)
}

/// `getImageAspectFlags`
fn get_image_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    match format {
        vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
        vk::Format::D16_UNORM => vk::ImageAspectFlags::DEPTH,
        _ => vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
    }
}

#[derive(Clone, Copy)]
struct Config {
    precise_bit_enabled: bool,
    scissor_test_enabled: bool,
    depth_clear_test_enabled: bool,
    stencil_clear_test_enabled: bool,
    depth_write_test_enabled: bool,
    stencil_write_test_enabled: bool,
}

impl Config {
    fn from_flags(flags: u32) -> Self {
        Self {
            precise_bit_enabled: flags & TEST_PRECISE_BIT != 0,
            scissor_test_enabled: flags & TEST_SCISSOR != 0,
            depth_clear_test_enabled: flags & TEST_DEPTH_CLEAR != 0 || flags & TEST_ALL != 0,
            stencil_clear_test_enabled: flags & TEST_STENCIL_CLEAR != 0 || flags & TEST_ALL != 0,
            depth_write_test_enabled: flags & TEST_DEPTH_WRITE != 0 || flags & TEST_ALL != 0,
            stencil_write_test_enabled: flags & TEST_STENCIL_WRITE != 0 || flags & TEST_ALL != 0,
        }
    }

    fn depth_tests_enabled(&self) -> bool {
        self.depth_clear_test_enabled || self.depth_write_test_enabled
    }

    fn stencil_tests_enabled(&self) -> bool {
        self.stencil_clear_test_enabled || self.stencil_write_test_enabled
    }

    /// The format of the depth/stencil attachment the flags call for.
    fn test_format(&self, context: &Context<'_>) -> vk::Format {
        if self.depth_tests_enabled() && self.stencil_tests_enabled() {
            pick_supported_depth_stencil_format(context)
        } else if self.stencil_tests_enabled() {
            vk::Format::S8_UINT
        } else {
            vk::Format::D16_UNORM
        }
    }
}

struct OcclusionQueryTest {
    name: String,
    config: Config,
}

impl TestCase for OcclusionQueryTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let test_format = self.config.test_format(context);

        if self.config.precise_bit_enabled && context.get_device_features().occlusion_query_precise == vk::FALSE {
            return Err(TestError::NotSupported(
                "Precise occlusion queries are not supported".to_string(),
            ));
        }

        let format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                test_format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
                vk::ImageCreateFlags::empty(),
            )
        };
        match format_properties {
            Ok(properties) if !properties.sample_counts.is_empty() && test_format != vk::Format::UNDEFINED => Ok(()),
            _ => Err(TestError::NotSupported(format!("{test_format:?} not supported"))),
        }
    }

    fn programs(&self) -> BinaryCollection {
        FRAGMENT_OPS_OCCLUSION_QUERY.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(OcclusionQueryInstance {
            context,
            config: self.config,
        })
    }
}

struct OcclusionQueryInstance<'a> {
    context: &'a Context<'a>,
    config: Config,
}

/// `commandClearDepthAttachment` / `commandClearStencilAttachment`
fn command_clear_attachment(
    device: &Device,
    cmd: vk::CommandBuffer,
    aspect: vk::ImageAspectFlags,
    offset: vk::Offset2D,
    extent: vk::Extent2D,
    clear_value: u32,
) {
    let attachment = vk::ClearAttachment {
        aspect_mask: aspect,
        color_attachment: 0,
        clear_value: vk::ClearValue {
            depth_stencil: vk::ClearDepthStencilValue {
                depth: 0.0,
                stencil: clear_value,
            },
        },
    };
    let rect = vk::ClearRect {
        rect: vk::Rect2D { offset, extent },
        base_array_layer: 0,
        layer_count: 1,
    };
    unsafe { device.cmd_clear_attachments(cmd, &[attachment], &[rect]) };
}

impl TestInstance for OcclusionQueryInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let config = self.config;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let (render_width, render_height) = (32u32, 32u32);
        let query_count = 1u32;

        // Create a query pool for storing the occlusion query result
        let query_pool_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::OCCLUSION)
            .query_count(query_count);
        let query_pool = Unique::new(
            device,
            unsafe { device.create_query_pool(&query_pool_info, None) }.vk_check("vkCreateQueryPool")?,
        );

        let image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: render_width,
                    height: render_height,
                    depth: 1,
                })
                .mip_levels(1)
                .array_layers(1)
                .samples(vk::SampleCountFlags::_1)
                .tiling(vk::ImageTiling::OPTIMAL)
                .usage(usage)
                .sharing_mode(vk::SharingMode::EXCLUSIVE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .build()
        };

        // Color attachment
        let color_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(
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
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let depth_tests_enabled = config.depth_tests_enabled();
        let stencil_tests_enabled = config.stencil_tests_enabled();
        let use_depth_stencil = depth_tests_enabled || stencil_tests_enabled;
        let test_format = config.test_format(context);

        log::info!("Using depth/stencil format {test_format:?}");

        let test_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(test_format, vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT),
            MemoryRequirement::ANY,
        )?;
        let test_image_view = make_image_view(
            device,
            test_image.get(),
            vk::ImageViewType::_2D,
            test_format,
            make_image_subresource_range(get_image_aspect_flags(test_format), 0, 1, 0, 1),
        )?;

        let mut attachment_images = vec![*color_image_view];
        if use_depth_stencil {
            attachment_images.push(*test_image_view);
        }

        // Vertex buffers: the depth occluder, the stencil occluder and the main quad.
        let make_vertex_buffer = |vertices: &[[f32; 4]]| -> Result<BufferWithMemory, TestError> {
            let buffer = BufferWithMemory::new(
                device,
                allocator,
                make_buffer_create_info(256, vk::BufferUsageFlags::VERTEX_BUFFER),
                MemoryRequirement::HOST_VISIBLE,
            )?;
            unsafe {
                std::ptr::copy_nonoverlapping(
                    vertices.as_ptr() as *const u8,
                    buffer.get_allocation().get_host_ptr(),
                    std::mem::size_of_val(vertices),
                )
            };
            flush_alloc(device, buffer.get_allocation())?;
            Ok(buffer)
        };

        let num_depth_occ_vertices = 6u32;
        let d_occluder_vertex_buffer = make_vertex_buffer(&[
            [-0.25, -0.50, 0.0, 1.0],
            [-0.50, -0.50, 0.0, 1.0],
            [-0.25, -0.25, 0.0, 1.0],
            [-0.50, -0.25, 0.0, 1.0],
            [-0.25, -0.25, 0.0, 1.0],
            [-0.50, -0.50, 0.0, 1.0],
        ])?;

        let num_stencil_occ_vertices = 6u32;
        let s_occluder_vertex_buffer = make_vertex_buffer(&[
            [-0.25, -0.25, 0.0, 1.0],
            [-0.50, -0.25, 0.0, 1.0],
            [-0.25, 0.00, 0.0, 1.0],
            [-0.50, 0.00, 0.0, 1.0],
            [-0.25, 0.00, 0.0, 1.0],
            [-0.50, -0.25, 0.0, 1.0],
        ])?;

        let num_vertices = 6u32;
        let vertex_buffer = make_vertex_buffer(&[
            [1.0, -1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, 1.0, 1.0, 1.0],
            [1.0, 1.0, 1.0, 1.0],
            [1.0, -1.0, 1.0, 1.0],
        ])?;

        // Render result buffer (to retrieve color attachment contents)
        let color_buffer_size_bytes = (render_width * render_height * 4) as vk::DeviceSize;
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Pipeline
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

        let mut attachments = vec![
            vk::AttachmentDescription::builder()
                .format(COLOR_FORMAT)
                .samples(vk::SampleCountFlags::_1)
                .load_op(vk::AttachmentLoadOp::CLEAR)
                .store_op(vk::AttachmentStoreOp::STORE)
                .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
                .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
                .initial_layout(vk::ImageLayout::UNDEFINED)
                .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
                .build(),
        ];
        if use_depth_stencil {
            attachments.push(
                vk::AttachmentDescription::builder()
                    .format(test_format)
                    .samples(vk::SampleCountFlags::_1)
                    .load_op(vk::AttachmentLoadOp::CLEAR)
                    .store_op(vk::AttachmentStoreOp::STORE)
                    .stencil_load_op(vk::AttachmentLoadOp::CLEAR)
                    .stencil_store_op(vk::AttachmentStoreOp::STORE)
                    .initial_layout(vk::ImageLayout::UNDEFINED)
                    .final_layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
                    .build(),
            );
        }
        let color_references = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .build()];
        let depth_stencil_reference = vk::AttachmentReference::builder()
            .attachment(1)
            .layout(vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL)
            .build();
        let mut subpass = vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_references);
        if use_depth_stencil {
            subpass = subpass.depth_stencil_attachment(&depth_stencil_reference);
        }
        let subpasses = [subpass.build()];
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(device, *render_pass, &attachment_images, render_width, render_height, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[])?;

        let make_pipeline = |enable_depth_test: bool,
                             enable_stencil_test: bool,
                             enable_stencil_write: bool|
         -> Result<Unique<vk::Pipeline>, TestError> {
            let viewports = [vk::Viewport {
                x: 0.0,
                y: 0.0,
                width: render_width as f32,
                height: render_height as f32,
                min_depth: 0.0,
                max_depth: 1.0,
            }];
            let scissors = [if config.scissor_test_enabled {
                vk::Rect2D {
                    offset: vk::Offset2D {
                        x: (render_width / 4) as i32,
                        y: (render_height / 4) as i32,
                    },
                    extent: vk::Extent2D {
                        width: render_width / 4 * 2,
                        height: render_height / 4 * 2,
                    },
                }
            } else {
                vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: render_width,
                        height: render_height,
                    },
                }
            }];
            let stencil_op_state = vk::StencilOpState::builder()
                .fail_op(vk::StencilOp::KEEP)
                .pass_op(if enable_stencil_write {
                    vk::StencilOp::REPLACE
                } else {
                    vk::StencilOp::KEEP
                })
                .depth_fail_op(vk::StencilOp::KEEP)
                .compare_op(if enable_stencil_write {
                    vk::CompareOp::ALWAYS
                } else {
                    vk::CompareOp::EQUAL
                })
                .compare_mask(0xff)
                .write_mask(0xff)
                .reference(if enable_stencil_write { 0 } else { 1 })
                .build();
            let stencil_state = if enable_stencil_test {
                stencil_op_state
            } else {
                vk::StencilOpState::default()
            };
            let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
                .depth_test_enable(enable_depth_test)
                .depth_write_enable(enable_depth_test)
                .depth_compare_op(vk::CompareOp::LESS)
                .depth_bounds_test_enable(false)
                .stencil_test_enable(enable_stencil_test)
                .front(stencil_state)
                .back(stencil_state)
                .min_depth_bounds(0.0)
                .max_depth_bounds(1.0);

            let vertex_bindings = [vk::VertexInputBindingDescription {
                binding: 0,
                stride: std::mem::size_of::<[f32; 4]>() as u32,
                input_rate: vk::VertexInputRate::VERTEX,
            }];
            let vertex_attributes = [vk::VertexInputAttributeDescription {
                location: 0,
                binding: 0,
                format: vk::Format::R32G32B32A32_SFLOAT,
                offset: 0,
            }];
            let vertex_input_state = vk::PipelineVertexInputStateCreateInfo::builder()
                .vertex_binding_descriptions(&vertex_bindings)
                .vertex_attribute_descriptions(&vertex_attributes);
            let stages = [
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::VERTEX)
                    .module(*vertex_module)
                    .name(b"main\0")
                    .build(),
                vk::PipelineShaderStageCreateInfo::builder()
                    .stage(vk::ShaderStageFlags::FRAGMENT)
                    .module(*fragment_module)
                    .name(b"main\0")
                    .build(),
            ];
            let input_assembly_state = vk::PipelineInputAssemblyStateCreateInfo::builder()
                .topology(vk::PrimitiveTopology::TRIANGLE_LIST)
                .primitive_restart_enable(false);
            let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
                .viewports(&viewports)
                .scissors(&scissors);
            let rasterization_state = vk::PipelineRasterizationStateCreateInfo::builder()
                .depth_clamp_enable(false)
                .rasterizer_discard_enable(false)
                .polygon_mode(vk::PolygonMode::FILL)
                .cull_mode(vk::CullModeFlags::NONE)
                .front_face(vk::FrontFace::COUNTER_CLOCKWISE)
                .depth_bias_enable(false)
                .line_width(1.0);
            let multisample_state =
                vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
            let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
                .blend_enable(false)
                .color_write_mask(vk::ColorComponentFlags::all())
                .build()];
            let color_blend_state =
                vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
            let info = vk::GraphicsPipelineCreateInfo::builder()
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
            let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[info], None) }
                .vk_check("vkCreateGraphicsPipelines")?;
            Ok(Unique::new(device, pipelines.0[0]))
        };
        let pipeline = make_pipeline(depth_tests_enabled, stencil_tests_enabled, false)?;
        let pipeline_stencil_write = make_pipeline(false, stencil_tests_enabled, true)?;

        // Command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        {
            let clear_values = [
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 1.0],
                    },
                },
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 0.5, stencil: 1 },
                },
            ];
            let bind_point = vk::PipelineBindPoint::GRAPHICS;

            begin_command_buffer(device, cmd)?;
            unsafe { device.cmd_reset_query_pool(cmd, *query_pool, 0, query_count) };

            // Will clear the attachments with specified depth and stencil values.
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(vk::Rect2D {
                    offset: vk::Offset2D { x: 0, y: 0 },
                    extent: vk::Extent2D {
                        width: render_width,
                        height: render_height,
                    },
                })
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
            }

            // Mask half of the attachment image with value that will pass the stencil test.
            if config.depth_clear_test_enabled {
                command_clear_attachment(
                    device,
                    cmd,
                    vk::ImageAspectFlags::DEPTH,
                    vk::Offset2D {
                        x: 0,
                        y: (render_height / 2) as i32,
                    },
                    vk::Extent2D {
                        width: render_width,
                        height: render_height / 2,
                    },
                    1,
                );
            }

            // Mask half of the attachment image with value that will pass the stencil test.
            if config.stencil_clear_test_enabled {
                command_clear_attachment(
                    device,
                    cmd,
                    vk::ImageAspectFlags::STENCIL,
                    vk::Offset2D {
                        x: (render_width / 2) as i32,
                        y: 0,
                    },
                    vk::Extent2D {
                        width: render_width / 2,
                        height: render_height,
                    },
                    0,
                );
            }

            if config.depth_write_test_enabled {
                unsafe {
                    device.cmd_bind_vertex_buffers(cmd, 0, &[d_occluder_vertex_buffer.get()], &[0]);
                    device.cmd_draw(cmd, num_depth_occ_vertices, 1, 0, 0);
                }
            }

            if config.stencil_write_test_enabled {
                unsafe {
                    device.cmd_bind_pipeline(cmd, bind_point, *pipeline_stencil_write);
                    device.cmd_bind_vertex_buffers(cmd, 0, &[s_occluder_vertex_buffer.get()], &[0]);
                    device.cmd_draw(cmd, num_stencil_occ_vertices, 1, 0, 0);
                    device.cmd_bind_pipeline(cmd, bind_point, *pipeline);
                }
            }

            unsafe {
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_begin_query(
                    cmd,
                    *query_pool,
                    0,
                    if config.precise_bit_enabled {
                        vk::QueryControlFlags::PRECISE
                    } else {
                        vk::QueryControlFlags::empty()
                    },
                );
                device.cmd_draw(cmd, num_vertices, 1, 0, 0);
                device.cmd_end_query(cmd, *query_pool, 0);
                device.cmd_end_render_pass(cmd);
            }

            copy_image_to_buffer(
                device,
                cmd,
                color_image.get(),
                color_buffer.get(),
                render_width,
                render_height,
            );

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Check results
        let mut exp_result = 0u64;

        if config.precise_bit_enabled {
            let (width, height) = (u64::from(render_width), u64::from(render_height));
            let image_size = if config.scissor_test_enabled {
                width * height / 4
            } else {
                width * height
            };
            let render_height_covered = if config.scissor_test_enabled {
                height / 2
            } else {
                height
            };
            let occluder_write_size = width * height / 64;

            if config.depth_clear_test_enabled || config.stencil_clear_test_enabled {
                if config.depth_clear_test_enabled && config.stencil_clear_test_enabled {
                    exp_result = image_size / 4;
                }

                if !config.depth_clear_test_enabled && config.stencil_clear_test_enabled {
                    exp_result = image_size / 2;
                }

                if config.depth_clear_test_enabled && !config.stencil_clear_test_enabled {
                    exp_result = (image_size / 2)
                        .wrapping_sub(image_size / 8)
                        .wrapping_sub(render_height_covered / 4);
                }
            } else if config.depth_write_test_enabled {
                exp_result = (image_size / 2).wrapping_sub(render_height_covered / 2);
            } else {
                exp_result = image_size;
            }

            if config.depth_write_test_enabled {
                exp_result = exp_result.wrapping_sub(occluder_write_size);

                if config.stencil_clear_test_enabled && !config.depth_clear_test_enabled {
                    exp_result = exp_result.wrapping_sub(image_size / 8 + render_height_covered / 4);
                }
            }

            if config.stencil_write_test_enabled {
                exp_result = exp_result.wrapping_sub(occluder_write_size);
            }
        }

        let mut sample_count_bytes = [0u8; 8];
        unsafe {
            device.get_query_pool_results(
                *query_pool,
                0,
                query_count,
                &mut sample_count_bytes,
                8,
                vk::QueryResultFlags::_64 | vk::QueryResultFlags::WAIT,
            )
        }
        .vk_check("vkGetQueryPoolResults")?;
        let sample_count = u64::from_ne_bytes(sample_count_bytes);

        // Log test results
        log::info!("Passed Samples : {sample_count} / {exp_result}");

        if (config.precise_bit_enabled && sample_count == exp_result)
            || (!config.precise_bit_enabled && sample_count > 0)
        {
            Ok(TestStatus::pass("Success"))
        } else {
            Ok(TestStatus::fail("Failure"))
        }
    }
}

/// `createOcclusionQueryTests`
pub fn create_occlusion_query_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("occlusion_query");

    let s = TEST_SCISSOR;
    let (dc, dw, sc, sw) = (
        TEST_DEPTH_CLEAR,
        TEST_DEPTH_WRITE,
        TEST_STENCIL_CLEAR,
        TEST_STENCIL_WRITE,
    );
    let cases: [(&str, u32); 32] = [
        ("_test_scissors_clear_color", s),
        ("_test_scissors_depth_clear", s | dc),
        ("_test_scissors_depth_write", s | dw),
        ("_test_scissors_depth_clear_depth_write", s | dc | dw),
        ("_test_scissors_stencil_clear", s | sc),
        ("_test_scissors_stencil_write", s | sw),
        ("_test_scissors_stencil_clear_stencil_write", s | sc | sw),
        ("_test_scissors_depth_clear_stencil_clear", s | dc | sc),
        ("_test_scissors_depth_write_stencil_clear", s | dw | sc),
        ("_test_scissors_depth_clear_stencil_write", s | dc | sw),
        ("_test_scissors_depth_write_stencil_write", s | dw | sw),
        ("_test_scissors_depth_clear_stencil_clear_depth_write", s | dc | dw | sc),
        (
            "_test_scissors_depth_clear_stencil_clear_stencil_write",
            s | dc | sc | sw,
        ),
        ("_test_scissors_depth_clear_depth_write_stencil_write", s | dc | dw | sw),
        (
            "_test_scissors_depth_write_stencil_clear_stencil_write",
            s | dw | sc | sw,
        ),
        ("_test_scissors_test_all", s | TEST_ALL),
        ("_test_clear_color", TEST_NO_FLAGS),
        ("_test_depth_clear", dc),
        ("_test_depth_write", dw),
        ("_test_depth_clear_depth_write", dc | dw),
        ("_test_stencil_clear", sc),
        ("_test_stencil_write", sw),
        ("_test_stencil_clear_stencil_write", sc | sw),
        ("_test_depth_clear_stencil_clear", dc | sc),
        ("_test_depth_write_stencil_clear", dw | sc),
        ("_test_depth_clear_stencil_write", dc | sw),
        ("_test_depth_write_stencil_write", dw | sw),
        ("_test_depth_clear_stencil_clear_depth_write", dc | dw | sc),
        ("_test_depth_clear_stencil_clear_stencil_write", dc | sc | sw),
        ("_test_depth_clear_depth_write_stencil_write", dc | dw | sw),
        ("_test_depth_write_stencil_clear_stencil_write", dw | sc | sw),
        ("_test_test_all", TEST_ALL),
    ];

    // Conservative tests
    for (case_name, flags) in cases {
        test_group.add_child(Box::new(OcclusionQueryTest {
            name: format!("conservative{case_name}"),
            config: Config::from_flags(flags),
        }) as Box<dyn TestCase>);
    }

    // Precise tests
    for (case_name, flags) in cases {
        test_group.add_child(Box::new(OcclusionQueryTest {
            name: format!("precise{case_name}"),
            config: Config::from_flags(flags | TEST_PRECISE_BIT),
        }) as Box<dyn TestCase>);
    }

    test_group
}
