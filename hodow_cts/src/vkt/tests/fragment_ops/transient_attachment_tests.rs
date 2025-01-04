// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_ops/vktFragmentOperationsTransientAttachmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// An attachment created with the transient bit (backed by lazily allocated or plain device-local memory) is
// cleared in one render pass and read back as an input attachment in a second one, whose colour output is
// compared against the clear value. The shaders are in `shaders/manifest/fragment_ops_transient_attachment.toml`.

use vulkanalia::prelude::v1_0::*;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{DescriptorPoolBuilder, DescriptorSetLayoutBuilder};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{ImageWithMemory, make_image_subresource_range, make_image_view};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_set,
    make_framebuffer, make_memory_barrier, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: the shader pair plus the mode (0 colour, 1 depth, 2 stencil).
pub struct TransientProgram {
    pub name: &'static str,
    pub mode: u32,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::fragment_ops_transient_attachment::{
    TRANSIENT_COLOR, TRANSIENT_DEPTH, TRANSIENT_STENCIL,
};

const RENDER_SIZE: u32 = 32;
const OUTPUT_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

/// `TestMode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMode {
    Color,
    Depth,
    Stencil,
}

/// `getSupportedStencilFormat`
fn get_supported_stencil_format(context: &Context<'_>) -> vk::Format {
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

fn test_format(context: &Context<'_>, mode: TestMode) -> vk::Format {
    match mode {
        TestMode::Depth => vk::Format::D16_UNORM,
        TestMode::Stencil => get_supported_stencil_format(context),
        TestMode::Color => vk::Format::R8G8B8A8_UNORM,
    }
}

fn is_depth_stencil_format(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::D16_UNORM
            | vk::Format::D16_UNORM_S8_UINT
            | vk::Format::D24_UNORM_S8_UINT
            | vk::Format::D32_SFLOAT_S8_UINT
    )
}

fn has_stencil(format: vk::Format) -> bool {
    matches!(
        format,
        vk::Format::D16_UNORM_S8_UINT
            | vk::Format::D24_UNORM_S8_UINT
            | vk::Format::D32_SFLOAT_S8_UINT
            | vk::Format::S8_UINT
    )
}

/// `makeAttachment`
fn make_attachment(
    format: vk::Format,
    load_op: vk::AttachmentLoadOp,
    store_op: vk::AttachmentStoreOp,
    initial_layout: vk::ImageLayout,
    final_layout: vk::ImageLayout,
) -> vk::AttachmentDescription {
    let stencil = has_stencil(format);
    vk::AttachmentDescription::builder()
        .format(format)
        .samples(vk::SampleCountFlags::_1)
        .load_op(load_op)
        .store_op(store_op)
        .stencil_load_op(if stencil {
            load_op
        } else {
            vk::AttachmentLoadOp::DONT_CARE
        })
        .stencil_store_op(if stencil {
            store_op
        } else {
            vk::AttachmentStoreOp::DONT_CARE
        })
        .initial_layout(initial_layout)
        .final_layout(final_layout)
        .build()
}

/// `makeRenderPass`
fn make_render_pass<'a>(
    device: &'a Device,
    attachment_descriptions: &[vk::AttachmentDescription],
    has_input_attachment: bool,
) -> Result<Unique<'a, vk::RenderPass>, TestError> {
    let has_depth_stencil = is_depth_stencil_format(attachment_descriptions[0].format)
        || attachment_descriptions[0].format == vk::Format::S8_UINT;

    let test_references: Vec<vk::AttachmentReference> = attachment_descriptions
        .iter()
        .enumerate()
        .map(|(attachment, description)| vk::AttachmentReference {
            attachment: attachment as u32,
            layout: description.final_layout,
        })
        .collect();
    let max_attachment_index = attachment_descriptions.len() - 1;

    let uses_color = !has_depth_stencil || has_input_attachment;
    let mut subpass = vk::SubpassDescription::builder().pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS);
    if has_input_attachment {
        subpass = subpass.input_attachments(&test_references[..1]);
    }
    if uses_color {
        subpass = subpass.color_attachments(&test_references[max_attachment_index..=max_attachment_index]);
    }
    if has_depth_stencil && !has_input_attachment {
        subpass = subpass.depth_stencil_attachment(&test_references[0]);
    }
    let subpasses = [subpass.build()];

    let info = vk::RenderPassCreateInfo::builder()
        .attachments(attachment_descriptions)
        .subpasses(&subpasses);
    Ok(Unique::new(
        device,
        unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
    ))
}

struct TransientAttachmentTest {
    name: &'static str,
    mode: TestMode,
    flags: vk::MemoryPropertyFlags,
}

impl TestCase for TransientAttachmentTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let memory_properties = context.get_default_allocator().memory_properties();
        let has_memory_type = memory_properties.memory_types[..memory_properties.memory_type_count as usize]
            .iter()
            .any(|memory_type| memory_type.property_flags.contains(self.flags));
        if !has_memory_type {
            return Err(TestError::NotSupported(format!(
                "{:?} is not supported by any memory type",
                self.flags
            )));
        }

        let format = test_format(context, self.mode);
        let usage = if matches!(self.mode, TestMode::Depth | TestMode::Stencil) {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
        } else {
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
        };
        let format_properties = unsafe {
            context.get_instance().get_physical_device_image_format_properties(
                context.get_physical_device(),
                format,
                vk::ImageType::_2D,
                vk::ImageTiling::OPTIMAL,
                usage,
                vk::ImageCreateFlags::empty(),
            )
        };
        match format_properties {
            Ok(properties) if !properties.sample_counts.is_empty() && format != vk::Format::UNDEFINED => Ok(()),
            _ => Err(TestError::NotSupported(format!("{format:?} not supported"))),
        }
    }

    fn programs(&self) -> BinaryCollection {
        match self.mode {
            TestMode::Color => TRANSIENT_COLOR.programs,
            TestMode::Depth => TRANSIENT_DEPTH.programs,
            TestMode::Stencil => TRANSIENT_STENCIL.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TransientAttachmentInstance {
            context,
            mode: self.mode,
            flags: self.flags,
        })
    }
}

struct TransientAttachmentInstance<'a> {
    context: &'a Context<'a>,
    mode: TestMode,
    flags: vk::MemoryPropertyFlags,
}

impl TestInstance for TransientAttachmentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let mode = self.mode;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();

        let aspect_flags = match mode {
            TestMode::Depth => vk::ImageAspectFlags::DEPTH,
            TestMode::Stencil => vk::ImageAspectFlags::STENCIL,
            TestMode::Color => vk::ImageAspectFlags::COLOR,
        };
        let usage_flags = if mode == TestMode::Color {
            vk::ImageUsageFlags::COLOR_ATTACHMENT
                | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
                | vk::ImageUsageFlags::INPUT_ATTACHMENT
        } else {
            vk::ImageUsageFlags::DEPTH_STENCIL_ATTACHMENT
                | vk::ImageUsageFlags::TRANSIENT_ATTACHMENT
                | vk::ImageUsageFlags::INPUT_ATTACHMENT
        };
        let format = test_format(context, mode);
        let mem_req = if self.flags.contains(vk::MemoryPropertyFlags::LAZILY_ALLOCATED) {
            MemoryRequirement::LAZILY_ALLOCATED
        } else {
            MemoryRequirement::LOCAL
        };

        let image_info = |format: vk::Format, usage: vk::ImageUsageFlags| {
            vk::ImageCreateInfo::builder()
                .image_type(vk::ImageType::_2D)
                .format(format)
                .extent(vk::Extent3D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
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

        // Test attachment
        let input_image = ImageWithMemory::new(device, allocator, image_info(format, usage_flags), mem_req)?;
        let input_image_view = make_image_view(
            device,
            input_image.get(),
            vk::ImageViewType::_2D,
            format,
            make_image_subresource_range(aspect_flags, 0, 1, 0, 1),
        )?;

        let output_image = ImageWithMemory::new(
            device,
            allocator,
            image_info(
                OUTPUT_FORMAT,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::LOCAL,
        )?;
        let output_image_view = make_image_view(
            device,
            output_image.get(),
            vk::ImageViewType::_2D,
            OUTPUT_FORMAT,
            make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
        )?;

        let result_buffer_size_bytes = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Main vertex buffer
        let num_vertices = 6u32;
        let vertices: [[f32; 4]; 6] = [
            [1.0, -1.0, 0.0, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [-1.0, 1.0, 1.0, 1.0],
            [1.0, 1.0, 1.0, 1.0],
            [1.0, -1.0, 1.0, 1.0],
        ];
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(256, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&vertices),
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Shader modules
        let binaries = context.get_binary_collection();
        let vertex_module = create_shader_module(device, binaries.get("vert")?)?;
        let fragment_module = create_shader_module(device, binaries.get("frag")?)?;

        // Descriptor pool and descriptor set
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::INPUT_ATTACHMENT, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let input_attachments_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::INPUT_ATTACHMENT, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_set_attachments = make_descriptor_set(device, *descriptor_pool, *input_attachments_set_layout)?;

        let image_descriptor_infos = [vk::DescriptorImageInfo {
            sampler: vk::Sampler::null(),
            image_view: *input_image_view,
            image_layout: vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        }];
        let write = vk::WriteDescriptorSet::builder()
            .dst_set(*descriptor_set_attachments)
            .dst_binding(0)
            .descriptor_type(vk::DescriptorType::INPUT_ATTACHMENT)
            .image_info(&image_descriptor_infos)
            .build();
        unsafe { device.update_descriptor_sets(&[write], &[] as &[vk::CopyDescriptorSet]) };

        let is_depth_stencil = is_depth_stencil_format(format);
        let input_layout = if is_depth_stencil {
            vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL
        } else {
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL
        };

        // Renderpasses
        let clear_pass_attachment = make_attachment(
            format,
            vk::AttachmentLoadOp::CLEAR,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            input_layout,
        );
        let input_pass_attachment = make_attachment(
            format,
            vk::AttachmentLoadOp::LOAD,
            vk::AttachmentStoreOp::STORE,
            input_layout,
            vk::ImageLayout::SHADER_READ_ONLY_OPTIMAL,
        );
        let output_pass_attachment = make_attachment(
            OUTPUT_FORMAT,
            vk::AttachmentLoadOp::DONT_CARE,
            vk::AttachmentStoreOp::STORE,
            vk::ImageLayout::UNDEFINED,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
        );

        let render_pass_one = make_render_pass(device, &[clear_pass_attachment], false)?;
        let render_pass_two = make_render_pass(device, &[input_pass_attachment, output_pass_attachment], true)?;

        let framebuffer_one = make_framebuffer(
            device,
            *render_pass_one,
            &[*input_image_view],
            RENDER_SIZE,
            RENDER_SIZE,
            1,
        )?;
        let framebuffer_two = make_framebuffer(
            device,
            *render_pass_two,
            &[*input_image_view, *output_image_view],
            RENDER_SIZE,
            RENDER_SIZE,
            1,
        )?;

        // Pipeline
        let pipeline_layout = make_pipeline_layout(device, &[*input_attachments_set_layout])?;
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
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: RENDER_SIZE as f32,
            height: RENDER_SIZE as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: vk::Extent2D {
                width: RENDER_SIZE,
                height: RENDER_SIZE,
            },
        }];
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
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder();
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .blend_enable(false)
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blend_state = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);
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
            .render_pass(*render_pass_two)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        // Command buffer
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        {
            let clear_value = match mode {
                TestMode::Color => vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [1.0, 1.0, 0.0, 1.0],
                    },
                },
                TestMode::Depth => vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 0.5, stencil: 0 },
                },
                TestMode::Stencil => vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue {
                        depth: 0.0,
                        stencil: 128,
                    },
                },
            };
            let render_area = vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                },
            };

            begin_command_buffer(device, cmd)?;

            // Clear attachment
            let clear_values = [clear_value];
            let begin_info_one = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass_one)
                .framebuffer(*framebuffer_one)
                .render_area(render_area)
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info_one, vk::SubpassContents::INLINE);
                device.cmd_end_render_pass(cmd);
            }

            // Synchronize clear and read operations.
            {
                let src_access = if is_depth_stencil {
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE
                } else {
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE
                };
                let src_stage = if is_depth_stencil {
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::LATE_FRAGMENT_TESTS
                } else {
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT
                };
                let clear_to_load = make_memory_barrier(src_access, vk::AccessFlags::INPUT_ATTACHMENT_READ);
                unsafe {
                    device.cmd_pipeline_barrier(
                        cmd,
                        src_stage,
                        vk::PipelineStageFlags::FRAGMENT_SHADER,
                        vk::DependencyFlags::empty(),
                        &[clear_to_load],
                        &[] as &[vk::BufferMemoryBarrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }

            // Draw with input attachment
            let begin_info_two = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass_two)
                .framebuffer(*framebuffer_two)
                .render_area(render_area);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info_two, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set_attachments],
                    &[],
                );
                device.cmd_draw(cmd, num_vertices, 1, 0, 0);
                device.cmd_end_render_pass(cmd);
            }

            copy_image_to_buffer(
                device,
                cmd,
                output_image.get(),
                result_buffer.get(),
                RENDER_SIZE,
                RENDER_SIZE,
            );

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Verify results
        invalidate_alloc(device, result_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                result_buffer.get_allocation().get_host_ptr(),
                result_buffer_size_bytes as usize,
            )
        };
        let clear_color: [f32; 4] = match mode {
            TestMode::Color => [1.0, 1.0, 0.0, 1.0],
            TestMode::Depth => [0.5, 0.0, 0.0, 1.0],
            TestMode::Stencil => [0.0, 0.0, 0.5, 1.0],
        };
        let reference: [u8; 4] = clear_color.map(|channel| (channel * 255.0 + 0.5) as u8);

        let threshold = 0.02f32 * 255.0;
        let matches = pixels.chunks_exact(4).all(|texel| {
            texel
                .iter()
                .zip(reference)
                .all(|(&actual, expected)| (f32::from(actual) - f32::from(expected)).abs() <= threshold)
        });
        if !matches {
            return Ok(TestStatus::fail("Rendered color image is not correct"));
        }

        Ok(TestStatus::pass("Success"))
    }
}

/// `createTransientAttachmentTests`
pub fn create_transient_attachment_tests() -> TestCaseGroup {
    // image usage transient attachment bit load and store op test
    let mut test_group = TestCaseGroup::new("transient_attachment_bit");

    let cases = [
        (
            "color_load_store_op_test_lazy_bit",
            TestMode::Color,
            vk::MemoryPropertyFlags::LAZILY_ALLOCATED,
        ),
        (
            "depth_load_store_op_test_lazy_bit",
            TestMode::Depth,
            vk::MemoryPropertyFlags::LAZILY_ALLOCATED,
        ),
        (
            "stencil_load_store_op_test_lazy_bit",
            TestMode::Stencil,
            vk::MemoryPropertyFlags::LAZILY_ALLOCATED,
        ),
        (
            "color_load_store_op_test_local_bit",
            TestMode::Color,
            vk::MemoryPropertyFlags::DEVICE_LOCAL,
        ),
        (
            "depth_load_store_op_test_local_bit",
            TestMode::Depth,
            vk::MemoryPropertyFlags::DEVICE_LOCAL,
        ),
        (
            "stencil_load_store_op_test_local_bit",
            TestMode::Stencil,
            vk::MemoryPropertyFlags::DEVICE_LOCAL,
        ),
    ];
    for (name, mode, flags) in cases {
        test_group.add_child(Box::new(TransientAttachmentTest { name, mode, flags }) as Box<dyn TestCase>);
    }

    test_group
}
