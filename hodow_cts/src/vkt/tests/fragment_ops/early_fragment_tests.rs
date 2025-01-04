// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/fragment_ops/vktFragmentOperationsEarlyFragmentTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported: the twelve plain cases (`{no_,}early_fragment_tests_*`, `early_and_late_fragment_tests_*`). A fullscreen
// pair of triangles is drawn with a fragment shader that counts its invocations in a storage buffer; with the
// early tests the depth or stencil test rejects half of them before the shader runs. The `discard_*` cases are in
// `early_fragment_discard_tests`, the `samplemask_*` ones in `early_fragment_samplemask_tests` and the `sample_count_*` ones in
// `early_fragment_samplecount_tests`. The early-and-late shader is GLSL here,
// upstream assembles it from SPIR-V text. The shaders are in `shaders/manifest/fragment_ops_early_fragment.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::InstanceV1_1;

use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_image_memory_barrier, make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_descriptor_buffer_info,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The manifest declares its cases with this: the shader pair plus the mode (0 early tests, 1 none, 2 early and late).
pub struct EarlyFragmentProgram {
    pub name: &'static str,
    pub mode: u32,
    pub programs: BinaryCollection,
}

use crate::generated::shaders::fragment_ops_early_fragment::{
    EARLY_FRAGMENT_EARLY, EARLY_FRAGMENT_EARLY_AND_LATE, EARLY_FRAGMENT_NONE,
};

pub(super) const FLAG_TEST_DEPTH: u32 = 1 << 0;
pub(super) const FLAG_TEST_STENCIL: u32 = 1 << 1;
pub(super) const FLAG_DONT_USE_TEST_ATTACHMENT: u32 = 1 << 2;
pub(super) const FLAG_DONT_USE_EARLY_FRAGMENT_TESTS: u32 = 1 << 3;
pub(super) const FLAG_EARLY_AND_LATE_FRAGMENT_TESTS: u32 = 1 << 4;

pub(super) const RENDER_SIZE: u32 = 32;
pub(super) const COLOR_FORMAT: vk::Format = vk::Format::R8G8B8A8_UNORM;

pub(super) fn get_image_aspect_flags(format: vk::Format) -> vk::ImageAspectFlags {
    match format {
        vk::Format::S8_UINT => vk::ImageAspectFlags::STENCIL,
        vk::Format::D16_UNORM => vk::ImageAspectFlags::DEPTH,
        _ => vk::ImageAspectFlags::DEPTH | vk::ImageAspectFlags::STENCIL,
    }
}

/// `pickSupportedDepthStencilFormat`
pub(super) fn pick_supported_depth_stencil_format(context: &Context<'_>, formats: &[vk::Format]) -> vk::Format {
    formats
        .iter()
        .copied()
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

/// `EarlyFragmentTest::checkSupport`
pub(super) fn check_early_fragment_support(context: &Context<'_>, flags: u32) -> Result<(), TestError> {
    if context.get_device_features().fragment_stores_and_atomics == vk::FALSE {
        return Err(TestError::NotSupported(
            "fragmentStoresAndAtomics not supported".to_string(),
        ));
    }

    if flags & FLAG_EARLY_AND_LATE_FRAGMENT_TESTS == FLAG_EARLY_AND_LATE_FRAGMENT_TESTS {
        context.require_device_functionality("VK_AMD_shader_early_and_late_fragment_tests")?;

        let mut features = vk::PhysicalDeviceShaderEarlyAndLateFragmentTestsFeaturesAMD::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if features.shader_early_and_late_fragment_tests == vk::FALSE {
            return Err(TestError::NotSupported(
                "shaderEarlyAndLateFragmentTests is not supported".to_string(),
            ));
        }
    }
    Ok(())
}

struct EarlyFragmentTest {
    name: &'static str,
    flags: u32,
}

impl TestCase for EarlyFragmentTest {
    fn name(&self) -> &str {
        self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_early_fragment_support(context, self.flags)
    }

    fn programs(&self) -> BinaryCollection {
        if self.flags & FLAG_EARLY_AND_LATE_FRAGMENT_TESTS != 0 {
            EARLY_FRAGMENT_EARLY_AND_LATE.programs
        } else if self.flags & FLAG_DONT_USE_EARLY_FRAGMENT_TESTS != 0 {
            EARLY_FRAGMENT_NONE.programs
        } else {
            EARLY_FRAGMENT_EARLY.programs
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(EarlyFragmentInstance {
            context,
            flags: self.flags,
        })
    }
}

struct EarlyFragmentInstance<'a> {
    context: &'a Context<'a>,
    flags: u32,
}

impl TestInstance for EarlyFragmentInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let allocator = context.get_default_allocator();
        let queue = context.get_universal_queue();

        let test_depth = self.flags & FLAG_TEST_DEPTH != 0;
        let test_stencil = !test_depth && self.flags & FLAG_TEST_STENCIL != 0;
        let use_test_attachment = self.flags & FLAG_DONT_USE_TEST_ATTACHMENT == 0;
        let use_early_tests = self.flags & FLAG_DONT_USE_EARLY_FRAGMENT_TESTS == 0;
        let use_early_late_tests =
            self.flags & FLAG_EARLY_AND_LATE_FRAGMENT_TESTS == FLAG_EARLY_AND_LATE_FRAGMENT_TESTS;

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

        // Color attachment
        let color_subresource_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
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
            color_subresource_range,
        )?;

        // Test attachment (depth or stencil)
        let stencil_formats = [
            vk::Format::S8_UINT,
            vk::Format::D16_UNORM_S8_UINT,
            vk::Format::D24_UNORM_S8_UINT,
            vk::Format::D32_SFLOAT_S8_UINT,
        ];
        let test_format = if test_stencil {
            pick_supported_depth_stencil_format(context, &stencil_formats)
        } else {
            vk::Format::D16_UNORM // spec requires this format to be supported
        };
        if test_format == vk::Format::UNDEFINED {
            return Ok(TestStatus::fail("Required depth/stencil format not supported"));
        }

        if use_test_attachment {
            log::info!("Using depth/stencil format {test_format:?}");
        }

        let test_subresource_range = make_image_subresource_range(get_image_aspect_flags(test_format), 0, 1, 0, 1);
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
            test_subresource_range,
        )?;
        let attachment_images = [*color_image_view, *test_image_view];
        let used_attachment_images = if use_test_attachment {
            &attachment_images[..2]
        } else {
            &attachment_images[..1]
        };

        // Vertex buffer
        let num_vertices = 6u32;
        // A small +0.00001f adjustment for the z-coordinate to get the expected rounded value for depth.
        let vertices: [[f32; 4]; 6] = [
            [1.0, -1.0, 0.50001, 1.0],
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.50001, 1.0],
            [-1.0, 1.0, 0.50001, 1.0],
            [1.0, 1.0, 1.0, 1.0],
            [1.0, -1.0, 0.50001, 1.0],
        ];
        let vertex_buffer_size_bytes = std::mem::size_of_val(&vertices) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(vertex_buffer_size_bytes, vk::BufferUsageFlags::VERTEX_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertices.as_ptr() as *const u8,
                vertex_buffer.get_allocation().get_host_ptr(),
                vertex_buffer_size_bytes as usize,
            )
        };
        flush_alloc(device, vertex_buffer.get_allocation())?;

        // Result buffer
        let result_buffer_size_bytes = std::mem::size_of::<u32>() as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        unsafe {
            std::ptr::write_bytes(
                result_buffer.get_allocation().get_host_ptr(),
                0,
                result_buffer_size_bytes as usize,
            )
        };
        flush_alloc(device, result_buffer.get_allocation())?;

        // Render result buffer (to retrieve color attachment contents)
        let color_buffer_size_bytes = (RENDER_SIZE * RENDER_SIZE * 4) as vk::DeviceSize;
        let color_buffer = BufferWithMemory::new(
            device,
            allocator,
            make_buffer_create_info(color_buffer_size_bytes, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Descriptors
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(vk::DescriptorType::STORAGE_BUFFER, vk::ShaderStageFlags::FRAGMENT)
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;
        let result_buffer_descriptor_info =
            make_descriptor_buffer_info(result_buffer.get(), 0, result_buffer_size_bytes);
        DescriptorSetUpdateBuilder::new()
            .write_single(
                *descriptor_set,
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &result_buffer_descriptor_info,
            )
            .update(device);

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
        if use_test_attachment {
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
        if use_test_attachment {
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
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            used_attachment_images,
            RENDER_SIZE,
            RENDER_SIZE,
            1,
        )?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;

        let stencil_op_state = vk::StencilOpState::builder()
            .fail_op(vk::StencilOp::KEEP)
            .pass_op(vk::StencilOp::KEEP)
            .depth_fail_op(vk::StencilOp::KEEP)
            .compare_op(vk::CompareOp::EQUAL)
            .compare_mask(0x3)
            .write_mask(0xf)
            .reference(1)
            .build();
        let depth_stencil_state = vk::PipelineDepthStencilStateCreateInfo::builder()
            .depth_test_enable(test_depth)
            .depth_write_enable(test_depth)
            .depth_compare_op(vk::CompareOp::LESS)
            .depth_bounds_test_enable(false)
            .stencil_test_enable(test_stencil)
            .front(stencil_op_state)
            .back(stencil_op_state)
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
            .render_pass(*render_pass)
            .subpass(0)
            .base_pipeline_index(0);
        let pipelines = unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info], None) }
            .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd = *cmd_buffer;

        // Draw commands
        {
            let render_area = vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: vk::Extent2D {
                    width: RENDER_SIZE,
                    height: RENDER_SIZE,
                },
            };

            begin_command_buffer(device, cmd)?;

            let barriers = [
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                    color_image.get(),
                    color_subresource_range,
                ),
                make_image_memory_barrier(
                    vk::AccessFlags::empty(),
                    vk::AccessFlags::DEPTH_STENCIL_ATTACHMENT_WRITE,
                    vk::ImageLayout::UNDEFINED,
                    vk::ImageLayout::DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
                    test_image.get(),
                    test_subresource_range,
                ),
            ];
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd,
                    vk::PipelineStageFlags::HOST,
                    vk::PipelineStageFlags::EARLY_FRAGMENT_TESTS | vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &barriers,
                );
            }

            // Will clear the attachments with specified depth and stencil values.
            let clear_values = [
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 1.0],
                    },
                },
                vk::ClearValue {
                    depth_stencil: vk::ClearDepthStencilValue { depth: 0.5, stencil: 0 },
                },
            ];
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(render_area)
                .clear_values(&clear_values);
            unsafe {
                device.cmd_begin_render_pass(cmd, &begin_info, vk::SubpassContents::INLINE);
                device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_descriptor_sets(
                    cmd,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[*descriptor_set],
                    &[],
                );
                device.cmd_bind_vertex_buffers(cmd, 0, &[vertex_buffer.get()], &[0]);

                // Mask half of the attachment image with value that will pass the stencil test.
                if use_test_attachment && test_stencil {
                    let attachment = vk::ClearAttachment {
                        aspect_mask: vk::ImageAspectFlags::STENCIL,
                        color_attachment: 0,
                        clear_value: vk::ClearValue {
                            depth_stencil: vk::ClearDepthStencilValue { depth: 0.0, stencil: 1 },
                        },
                    };
                    let rect = vk::ClearRect {
                        rect: vk::Rect2D {
                            offset: vk::Offset2D { x: 0, y: 0 },
                            extent: vk::Extent2D {
                                width: RENDER_SIZE / 2,
                                height: RENDER_SIZE,
                            },
                        },
                        base_array_layer: 0,
                        layer_count: 1,
                    };
                    device.cmd_clear_attachments(cmd, &[attachment], &[rect]);
                }

                device.cmd_draw(cmd, num_vertices, 1, 0, 0);
                device.cmd_end_render_pass(cmd);
            }

            copy_image_to_buffer(
                device,
                cmd,
                color_image.get(),
                color_buffer.get(),
                RENDER_SIZE,
                RENDER_SIZE,
            );

            end_command_buffer(device, cmd)?;
            submit_commands_and_wait(device, queue, cmd)?;
        }

        // Check the result image
        invalidate_alloc(device, color_buffer.get_allocation())?;
        let pixels = unsafe {
            std::slice::from_raw_parts(
                color_buffer.get_allocation().get_host_ptr(),
                color_buffer_size_bytes as usize,
            )
        };

        let fill_color = [255u8, 255, 0, 255];
        let black = [0u8, 0, 0, 255];
        let mut reference_image = vec![0u8; pixels.len()];
        let set_pixel = |image: &mut [u8], x: u32, y: u32, color: [u8; 4]| {
            let offset = ((y * RENDER_SIZE + x) * 4) as usize;
            image[offset..offset + 4].copy_from_slice(&color);
        };

        if use_test_attachment {
            for texel in reference_image.chunks_exact_mut(4) {
                texel.copy_from_slice(&black);
            }

            if test_depth {
                for (x_offset, y) in (0..RENDER_SIZE - 1).enumerate() {
                    for x in 0..RENDER_SIZE - 1 - x_offset as u32 {
                        set_pixel(&mut reference_image, x, y, fill_color);
                    }
                }
            }

            if test_stencil {
                for y in 0..RENDER_SIZE {
                    for x in 0..RENDER_SIZE / 2 {
                        set_pixel(&mut reference_image, x, y, fill_color);
                    }
                }
            }
        } else {
            for texel in reference_image.chunks_exact_mut(4) {
                texel.copy_from_slice(&fill_color);
            }
        }

        let threshold = 0.02f32 * 255.0;
        if !reference_image
            .iter()
            .zip(pixels)
            .all(|(&reference, &actual)| (f32::from(reference) - f32::from(actual)).abs() <= threshold)
        {
            return Ok(TestStatus::fail("Rendered color image is not correct"));
        }

        // Verify results
        invalidate_alloc(device, result_buffer.get_allocation())?;
        let actual_counter =
            unsafe { std::ptr::read_unaligned(result_buffer.get_allocation().get_host_ptr() as *const i32) };
        let expect_partial_result = use_early_tests && use_test_attachment;
        let render_pixels = (RENDER_SIZE * RENDER_SIZE) as i32;
        let expected_counter = if expect_partial_result {
            render_pixels / 2
        } else {
            render_pixels
        };
        let tolerance = if expect_partial_result {
            RENDER_SIZE as i32 * 3
        } else {
            0
        };
        let expected_min = (expected_counter - tolerance).max(0);
        let expected_max = if use_early_late_tests {
            render_pixels
        } else {
            expected_counter + tolerance
        };

        if expect_partial_result {
            log::info!("Expected value in range: [{expected_min}, {expected_max}]");
        } else {
            log::info!("Expected value: {expected_counter}");
        }
        log::info!("Result value: {actual_counter}");

        if expected_min <= actual_counter && actual_counter <= expected_max {
            Ok(TestStatus::pass("Success"))
        } else {
            Ok(TestStatus::fail("Value out of range"))
        }
    }
}

/// The plain cases of `createEarlyFragmentTests`.
pub fn create_early_fragment_tests() -> TestCaseGroup {
    let mut test_group = TestCaseGroup::new("early_fragment");

    let (d, s, na, ne, el) = (
        FLAG_TEST_DEPTH,
        FLAG_TEST_STENCIL,
        FLAG_DONT_USE_TEST_ATTACHMENT,
        FLAG_DONT_USE_EARLY_FRAGMENT_TESTS,
        FLAG_EARLY_AND_LATE_FRAGMENT_TESTS,
    );
    let cases: [(&'static str, u32); 12] = [
        ("no_early_fragment_tests_depth", d | ne),
        ("no_early_fragment_tests_stencil", s | ne),
        ("early_fragment_tests_depth", d),
        ("early_fragment_tests_stencil", s),
        ("no_early_fragment_tests_depth_no_attachment", d | ne | na),
        ("no_early_fragment_tests_stencil_no_attachment", s | ne | na),
        ("early_fragment_tests_depth_no_attachment", d | na),
        ("early_fragment_tests_stencil_no_attachment", s | na),
        ("early_and_late_fragment_tests_depth", d | el),
        ("early_and_late_fragment_tests_stencil", s | el),
        ("early_and_late_fragment_tests_depth_no_attachment", d | na | el),
        ("early_and_late_fragment_tests_stencil_no_attachment", s | na | el),
    ];
    for (name, flags) in cases {
        test_group.add_child(Box::new(EarlyFragmentTest { name, flags }) as Box<dyn TestCase>);
    }

    // Check that discard does not affect depth test writes.
    super::early_fragment_discard_tests::add_discard_cases(&mut test_group);

    // Check that writing to gl_SampleMask does not affect depth test writes.
    super::early_fragment_samplemask_tests::add_samplemask_cases(&mut test_group);

    // We kill half of the samples at different points in the pipeline depending on early frag test, and then we verify the sample counting works as expected.
    super::early_fragment_samplecount_tests::add_sample_count_cases(&mut test_group);

    test_group
}
