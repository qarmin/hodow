// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tensor/vktTensorGraphicsPipeline.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2025 The Khronos Group Inc.
// Copyright (c) 2025 Arm Ltd.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders of `initPrograms` are in `scripts/gen_tensor_manifests.py` (manifest `tensor_graphics_pipeline`). The
// cases are returned keyed by their dotted path so `tensor::create_tests` can swap them in for the gated names.

use std::collections::HashMap;

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::DeviceV1_3;

use super::required_tests::get_tensor_physical_device_properties;
use super::tensor_util::{
    ElementKind, StridedMemory, TensorDescription, TensorParameters, TensorView, TensorWithMemory,
    create_descriptor_pool, device_supports_shader_stages_tensor_access, device_supports_shader_tensor_access,
    format_support_tensor_flags, pool_size, require_tensor_shape_supported, tensor_descriptor_write, upload_to_tensor,
};
use crate::generated::shaders::tensor_graphics_pipeline::GRAPHICS_PIPELINE;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::image_util::make_image_subresource_range;
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{allocate_command_buffer, make_command_pool, make_descriptor_set};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::ImageWithBuffer;
use crate::vkt::tests::fragment_ops::copy_image_to_buffer;
use crate::vkt::{Context, TestCase, TestInstance};

const IMAGE_FORMAT: vk::Format = vk::Format::R8G8B8A8_UINT;
const VERTEX_COUNT_IN_RECTANGLE: usize = 6;
const DIMENSIONS_IN_VERTEX: usize = 2;

/// `{{50, 40}, {200, 200}}` and `{{350, 340}, {200, 200}}`: (x, y, width, height)
const RECTANGLES: [(i32, i32, u32, u32); 2] = [(50, 40, 200, 200), (350, 340, 200, 200)];

struct TensorGraphicsPipelineAccessTestCase {
    name: String,
    image_shape: vk::Extent2D,
}

impl TestCase for TensorGraphicsPipelineAccessTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_ARM_tensors")?;

        if get_tensor_physical_device_properties(context).max_tensor_dimension_count < 3 {
            return Err(TestError::NotSupported(
                "Tensor dimension count is higher than what the implementation supports".to_string(),
            ));
        }

        for format in [vk::Format::R8_UINT, vk::Format::R32_SINT] {
            if !format_support_tensor_flags(
                context,
                format,
                vk::TensorTilingARM::LINEAR,
                vk::FormatFeatureFlags2::TENSOR_SHADER_ARM,
            ) {
                return Err(TestError::NotSupported("Format not supported".to_string()));
            }
        }

        if !device_supports_shader_tensor_access(context) {
            return Err(TestError::NotSupported(
                "Device does not support shader tensor access".to_string(),
            ));
        }

        if !device_supports_shader_stages_tensor_access(
            context,
            vk::ShaderStageFlags::FRAGMENT | vk::ShaderStageFlags::VERTEX,
        ) {
            return Err(TestError::NotSupported(
                "Device does not support shader tensor access in both fragment and vertex shader stages".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        GRAPHICS_PIPELINE.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TensorGraphicsPipelineAccessTestInstance {
            context,
            image_shape: self.image_shape,
        })
    }
}

struct TensorGraphicsPipelineAccessTestInstance<'a> {
    context: &'a Context<'a>,
    image_shape: vk::Extent2D,
}

impl TensorGraphicsPipelineAccessTestInstance<'_> {
    fn run(&self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let image_shape = self.image_shape;

        // Tensor with same shape as image that fragment shader fetches data from
        let format_fragment_tensor = vk::Format::R8_UINT;
        let shape_fragment_tensor = [i64::from(image_shape.height), i64::from(image_shape.width), 1];
        require_tensor_shape_supported(
            context,
            &TensorParameters::new(
                format_fragment_tensor,
                vk::TensorTilingARM::LINEAR,
                &shape_fragment_tensor,
                &[],
            ),
        )?;

        let fragment_tensor_desc = TensorDescription::new(
            vk::TensorTilingARM::LINEAR,
            format_fragment_tensor,
            &shape_fragment_tensor,
            &[],
            vk::TensorUsageFlagsARM::SHADER | vk::TensorUsageFlagsARM::TRANSFER_DST,
        );
        let fragment_tensor = TensorWithMemory::new(context, &fragment_tensor_desc, MemoryRequirement::ANY)?;
        let fragment_tensor_view = TensorView::new(device, fragment_tensor.get(), format_fragment_tensor)?;

        let mut fragment_tensor_data = StridedMemory::new(&shape_fragment_tensor, &[], ElementKind::UInt(1));
        fragment_tensor_data.fill();
        upload_to_tensor(context, &fragment_tensor, fragment_tensor_data.data())?;

        // Tensor with triangles forming rectangles that vertex shader fetches data from
        let shape_vertex_tensor = [
            (VERTEX_COUNT_IN_RECTANGLE * RECTANGLES.len()) as i64,
            DIMENSIONS_IN_VERTEX as i64,
        ];
        require_tensor_shape_supported(
            context,
            &TensorParameters::new(
                vk::Format::R32_SINT,
                vk::TensorTilingARM::LINEAR,
                &shape_vertex_tensor,
                &[],
            ),
        )?;

        let vertex_tensor_desc = TensorDescription::new(
            vk::TensorTilingARM::LINEAR,
            vk::Format::R32_SINT,
            &shape_vertex_tensor,
            &[],
            vk::TensorUsageFlagsARM::SHADER | vk::TensorUsageFlagsARM::TRANSFER_DST,
        );
        let vertex_tensor = TensorWithMemory::new(context, &vertex_tensor_desc, MemoryRequirement::ANY)?;
        let vertex_tensor_view = TensorView::new(device, vertex_tensor.get(), vk::Format::R32_SINT)?;
        {
            let mut vertex_tensor_data: Vec<i32> = Vec::new();
            for &(x, y, width, height) in &RECTANGLES {
                let (right, bottom) = (x + width as i32, y + height as i32);
                let upper_left = (x, y);
                let upper_right = (right, y);
                let lower_left = (x, bottom);
                let lower_right = (right, bottom);
                for (vx, vy) in [
                    upper_left,
                    upper_right,
                    lower_right,
                    upper_left,
                    lower_right,
                    lower_left,
                ] {
                    vertex_tensor_data.push(vx);
                    vertex_tensor_data.push(vy);
                }
            }
            let bytes: Vec<u8> = vertex_tensor_data.iter().flat_map(|v| v.to_le_bytes()).collect();
            upload_to_tensor(context, &vertex_tensor, &bytes)?;
        }

        // Image to render into
        let image = ImageWithBuffer::new(
            context,
            image_shape.width,
            image_shape.height,
            IMAGE_FORMAT,
            vk::ImageUsageFlags::TRANSFER_SRC | vk::ImageUsageFlags::COLOR_ATTACHMENT,
            4,
        )?;

        let bindings = [
            vk::DescriptorSetLayoutBinding {
                binding: 0,
                descriptor_type: vk::DescriptorType::TENSOR_ARM,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::FRAGMENT,
                immutable_samplers: std::ptr::null(),
            },
            vk::DescriptorSetLayoutBinding {
                binding: 1,
                descriptor_type: vk::DescriptorType::TENSOR_ARM,
                descriptor_count: 1,
                stage_flags: vk::ShaderStageFlags::VERTEX,
                immutable_samplers: std::ptr::null(),
            },
        ];
        let layout_info = vk::DescriptorSetLayoutCreateInfo::builder().bindings(&bindings);
        let descriptor_set_layout = Unique::new(
            device,
            unsafe { device.create_descriptor_set_layout(&layout_info, None) }
                .vk_check("vkCreateDescriptorSetLayout")?,
        );
        let descriptor_pool = create_descriptor_pool(
            device,
            &[pool_size(vk::DescriptorType::TENSOR_ARM, 2)],
            vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET,
            1,
        )?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        {
            let fragment_views = [fragment_tensor_view.get()];
            let fragment_tensor_write = vk::WriteDescriptorSetTensorARM {
                tensor_view_count: 1,
                tensor_views: fragment_views.as_ptr(),
                ..Default::default()
            };
            let vertex_views = [vertex_tensor_view.get()];
            let vertex_tensor_write = vk::WriteDescriptorSetTensorARM {
                tensor_view_count: 1,
                tensor_views: vertex_views.as_ptr(),
                ..Default::default()
            };
            let writes = [
                tensor_descriptor_write(descriptor_set.get(), 0, 0, &fragment_tensor_write),
                tensor_descriptor_write(descriptor_set.get(), 1, 0, &vertex_tensor_write),
            ];
            unsafe { device.update_descriptor_sets(&writes, &[] as &[vk::CopyDescriptorSet]) };
        }

        let binaries = context.get_binary_collection();
        let vertex_shader_module = create_shader_module(device, binaries.get("vertex")?)?;
        let fragment_shader_module = create_shader_module(device, binaries.get("fragment")?)?;

        let set_layouts = [*descriptor_set_layout];
        let pipeline_layout_info = vk::PipelineLayoutCreateInfo::builder().set_layouts(&set_layouts);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&pipeline_layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        let specialization_data = [image_shape.width, image_shape.height];
        let specialization_bytes: Vec<u8> = specialization_data.iter().flat_map(|v| v.to_le_bytes()).collect();
        let specialization_entries = [
            vk::SpecializationMapEntry {
                constant_id: 0,
                offset: 0,
                size: 4,
            },
            vk::SpecializationMapEntry {
                constant_id: 1,
                offset: 4,
                size: 4,
            },
        ];
        let specialization_info = vk::SpecializationInfo::builder()
            .map_entries(&specialization_entries)
            .data(&specialization_bytes);

        let shader_stages = [
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::VERTEX)
                .module(*vertex_shader_module)
                .name(b"main\0")
                .specialization_info(&specialization_info)
                .build(),
            vk::PipelineShaderStageCreateInfo::builder()
                .stage(vk::ShaderStageFlags::FRAGMENT)
                .module(*fragment_shader_module)
                .name(b"main\0")
                .build(),
        ];

        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder();
        let input_assembly =
            vk::PipelineInputAssemblyStateCreateInfo::builder().topology(vk::PrimitiveTopology::TRIANGLE_LIST);
        let viewports = [vk::Viewport {
            x: 0.0,
            y: 0.0,
            width: image_shape.width as f32,
            height: image_shape.height as f32,
            min_depth: 0.0,
            max_depth: 1.0,
        }];
        let scissors = [vk::Rect2D {
            offset: vk::Offset2D { x: 0, y: 0 },
            extent: image_shape,
        }];
        let viewport_state = vk::PipelineViewportStateCreateInfo::builder()
            .viewports(&viewports)
            .scissors(&scissors);
        let rasterizer = vk::PipelineRasterizationStateCreateInfo::builder()
            .polygon_mode(vk::PolygonMode::FILL)
            .line_width(1.0)
            .cull_mode(vk::CullModeFlags::BACK)
            .front_face(vk::FrontFace::CLOCKWISE);
        let multisampling =
            vk::PipelineMultisampleStateCreateInfo::builder().rasterization_samples(vk::SampleCountFlags::_1);
        let color_blend_attachments = [vk::PipelineColorBlendAttachmentState::builder()
            .color_write_mask(vk::ColorComponentFlags::all())
            .build()];
        let color_blending = vk::PipelineColorBlendStateCreateInfo::builder().attachments(&color_blend_attachments);

        let color_attachment_formats = [IMAGE_FORMAT];
        let mut pipeline_rendering_info =
            vk::PipelineRenderingCreateInfo::builder().color_attachment_formats(&color_attachment_formats);

        let pipeline_info = vk::GraphicsPipelineCreateInfo::builder()
            .stages(&shader_stages)
            .vertex_input_state(&vertex_input)
            .input_assembly_state(&input_assembly)
            .viewport_state(&viewport_state)
            .rasterization_state(&rasterizer)
            .multisample_state(&multisampling)
            .color_blend_state(&color_blending)
            .layout(*pipeline_layout)
            .render_pass(vk::RenderPass::null())
            .subpass(0)
            .push_next(&mut pipeline_rendering_info);
        let pipelines =
            unsafe { device.create_graphics_pipelines(vk::PipelineCache::null(), &[pipeline_info.build()], None) }
                .vk_check("vkCreateGraphicsPipelines")?;
        let pipeline = Unique::new(device, pipelines.0[0]);

        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, cmd_pool.get(), vk::CommandBufferLevel::PRIMARY)?;
        let cmd = cmd_buffer.get();

        begin_command_buffer(device, cmd)?;

        // Transition color attachment into the expected layout
        {
            let initial_layout_barrier = vk::ImageMemoryBarrier2 {
                src_stage_mask: vk::PipelineStageFlags2::TOP_OF_PIPE,
                src_access_mask: vk::AccessFlags2::empty(),
                dst_stage_mask: vk::PipelineStageFlags2::COLOR_ATTACHMENT_OUTPUT,
                dst_access_mask: vk::AccessFlags2::COLOR_ATTACHMENT_WRITE,
                old_layout: vk::ImageLayout::UNDEFINED,
                new_layout: vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                src_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                dst_queue_family_index: vk::QUEUE_FAMILY_IGNORED,
                image: image.image.get(),
                subresource_range: make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1),
                ..Default::default()
            };
            let dependency_info = vk::DependencyInfo {
                image_memory_barrier_count: 1,
                image_memory_barriers: &initial_layout_barrier,
                ..Default::default()
            };
            unsafe { device.cmd_pipeline_barrier2(cmd, &dependency_info) };
        }

        let attachment_info = vk::RenderingAttachmentInfo::builder()
            .image_view(*image.view)
            .image_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)
            .resolve_mode(vk::ResolveModeFlags::NONE)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .clear_value(vk::ClearValue {
                color: vk::ClearColorValue {
                    float32: [1.0, 0.0, 0.0, 1.0],
                },
            })
            .build();
        let color_attachments = [attachment_info];
        let rendering_info = vk::RenderingInfo::builder()
            .render_area(vk::Rect2D {
                offset: vk::Offset2D { x: 0, y: 0 },
                extent: image_shape,
            })
            .layer_count(1)
            .color_attachments(&color_attachments);

        unsafe {
            device.cmd_begin_rendering(cmd, &rendering_info);
            device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, *pipeline);
            device.cmd_bind_descriptor_sets(
                cmd,
                vk::PipelineBindPoint::GRAPHICS,
                *pipeline_layout,
                0,
                &[descriptor_set.get()],
                &[],
            );
            device.cmd_draw(cmd, (RECTANGLES.len() * VERTEX_COUNT_IN_RECTANGLE) as u32, 1, 0, 0);
            device.cmd_end_rendering(cmd);
        }

        // Copy from color attachment to output buffer
        copy_image_to_buffer(
            device,
            cmd,
            image.image.get(),
            image.buffer.get(),
            image_shape.width,
            image_shape.height,
        );

        end_command_buffer(device, cmd)?;
        submit_commands_and_wait(device, context.get_universal_queue(), cmd)?;

        invalidate_alloc(device, image.buffer.get_allocation())?;
        let ptr = image.buffer.get_allocation().get_host_ptr();
        let pixels =
            unsafe { std::slice::from_raw_parts(ptr, image_shape.width as usize * image_shape.height as usize * 4) };

        for y in 0..image_shape.height as usize {
            for x in 0..image_shape.width as usize {
                // upstream compares y against the rectangle's width, which equals its height
                let pixel_should_be_in_rectangle = RECTANGLES.iter().any(|&(rx, ry, width, height)| {
                    x >= rx as usize
                        && x < rx as usize + width as usize
                        && y >= ry as usize
                        && y < ry as usize + height as usize
                });

                let offset = 4 * (y * image_shape.width as usize + x);
                let pixel = &pixels[offset..offset + 4];
                if pixel_should_be_in_rectangle {
                    let expected_value = fragment_tensor_data.get_u8((y * image_shape.width as usize + x) as u64);
                    if !(pixel[0] == 0 && pixel[1] == expected_value && pixel[2] == 0 && pixel[3] == 255) {
                        return Ok(TestStatus::fail(format!(
                            "Comparison failed inside rectangle at image coordinate ( {x}, {y}): image = ({}, {}, {}, {}), expected = (0, {expected_value}, 0, 255)",
                            pixel[0], pixel[1], pixel[2], pixel[3]
                        )));
                    }
                } else if !(pixel[0] == 255 && pixel[1] == 0 && pixel[2] == 0 && pixel[3] == 255) {
                    return Ok(TestStatus::fail(format!(
                        "Comparison failed outside rectangle at image coordinate ( {x}, {y}): image = ({}, {}, {}, {}), expected = (255, 0, 0, 255)",
                        pixel[0], pixel[1], pixel[2], pixel[3]
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Tensor test succeeded"))
    }
}

impl TestInstance for TensorGraphicsPipelineAccessTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.run()
    }
}

/// `addGraphicsPipelineAccessTest`: the cases keyed by their dotted path (`graphics_pipeline.<w>x<h>`)
pub fn create_graphics_pipeline_cases() -> HashMap<String, Box<dyn TestCase>> {
    let mut cases: HashMap<String, Box<dyn TestCase>> = HashMap::new();
    for (width, height) in [(600u32, 600u32), (1280, 720), (567, 891), (891, 567)] {
        let name = format!("{width}x{height}");
        cases.insert(
            format!("graphics_pipeline.{name}"),
            Box::new(TensorGraphicsPipelineAccessTestCase {
                name,
                image_shape: vk::Extent2D { width, height },
            }),
        );
    }
    cases
}
