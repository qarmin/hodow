// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/transform_feedback/vktTransformFeedbackSimpleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2018 The Khronos Group Inc.
// Copyright (c) 2018 Mobica Limited.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The six `TEST_TYPE_DRAW_INDIRECT*` types of the `simple` group (`draw_indirect`,
// `draw_indirect_multiview`, `draw_indirect_counter_offset`, `draw_indirect_counter_buffer_offset` and their multiview forms). The shaders are
// the `indirect_*` ones of `shaders/manifest/transform_feedback_simple_streams.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1};

use super::simple_pipeline::{XfbPipelineOptions, XfbStages, make_xfb_pipeline};
use super::simple_tests::{IMAGE_SIZE, make_pipeline_layout, validate_limits};
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy)]
struct IndirectParameters {
    multiview: bool,
    counter_offset: bool,
    counter_buffer_offset: bool,
    vertex_stride: u32,
    point_size: u32,
}

struct IndirectTestCase {
    name: String,
    parameters: IndirectParameters,
}

impl TestCase for IndirectTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TransformFeedbackTestCase::checkSupport`, for the indirect draw types.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_transform_feedback")?;

        let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
        let mut multiview_features = vk::PhysicalDeviceMultiviewFeatures::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder()
            .push_next(&mut xfb_features)
            .push_next(&mut multiview_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if xfb_features.transform_feedback == vk::FALSE {
            return Err(TestError::NotSupported(
                "transformFeedback feature is not supported".to_string(),
            ));
        }

        let mut xfb_properties = vk::PhysicalDeviceTransformFeedbackPropertiesEXT::default();
        let mut properties2 = vk::PhysicalDeviceProperties2::builder().push_next(&mut xfb_properties);
        unsafe {
            context
                .get_instance()
                .get_physical_device_properties2(context.get_physical_device(), &mut properties2)
        };

        if self.parameters.multiview && multiview_features.multiview == vk::FALSE {
            return Err(TestError::NotSupported("multiview not supported".to_string()));
        }

        let stride = self.parameters.vertex_stride;
        if xfb_properties.transform_feedback_draw == vk::FALSE {
            return Err(TestError::NotSupported(
                "transformFeedbackDraw feature is not supported".to_string(),
            ));
        }

        let max_binding_stride = context.get_device_properties().limits.max_vertex_input_binding_stride;
        if max_binding_stride < stride {
            return Err(TestError::NotSupported(format!(
                "maxVertexInputBindingStride={max_binding_stride}, while test requires {stride}"
            )));
        }

        if xfb_properties.max_transform_feedback_buffer_data_size < stride {
            return Err(TestError::NotSupported(format!(
                "maxTransformFeedbackBufferDataSize={}, while test requires {stride}",
                xfb_properties.max_transform_feedback_buffer_data_size
            )));
        }

        if xfb_properties.max_transform_feedback_buffer_data_stride < stride {
            return Err(TestError::NotSupported(format!(
                "maxTransformFeedbackBufferDataStride={}, while test requires {stride}",
                xfb_properties.max_transform_feedback_buffer_data_stride
            )));
        }

        if self.parameters.point_size > 1 {
            return Err(TestError::NotSupported(
                "largePoints feature is not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::transform_feedback_simple_streams::XFB_STREAM_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IndirectTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

/// `TransformFeedbackIndirectDrawTestInstance`
struct IndirectTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: IndirectParameters,
}

impl IndirectTestInstance<'_> {
    /// `verifyImage`: the top half is white, and so is the bottom one unless `counterOffset` skips it.
    fn verify_image(&self, result: &[u8]) -> bool {
        const WHITE: [u8; 4] = [0xFF; 4];
        const BLACK: [u8; 4] = [0x00, 0x00, 0x00, 0xFF];
        let (width, height) = (IMAGE_SIZE as usize, IMAGE_SIZE as usize);
        let mut expected = Vec::with_capacity(width * height * 4);

        for y in 0..height {
            let color = if self.parameters.counter_offset && y >= height / 2 {
                BLACK
            } else {
                WHITE
            };
            for _x in 0..width {
                expected.extend_from_slice(&color);
            }
        }

        if result == expected.as_slice() {
            return true;
        }

        let mismatches = result
            .iter()
            .zip(&expected)
            .filter(|(a, b)| a.abs_diff(**b) > 1)
            .count();
        if mismatches > 0 {
            log::info!("Image comparison failed: {mismatches} channel values differ by more than one");
        }
        mismatches == 0
    }

    fn create_render_pass(
        &self,
        color_format: vk::Format,
        layer_count: u32,
    ) -> Result<Unique<'_, vk::RenderPass>, TestError> {
        let device = self.context.get_device();
        let attachments = [vk::AttachmentDescription::builder()
            .format(color_format)
            .samples(vk::SampleCountFlags::_1)
            .load_op(vk::AttachmentLoadOp::CLEAR)
            .store_op(vk::AttachmentStoreOp::STORE)
            .stencil_load_op(vk::AttachmentLoadOp::DONT_CARE)
            .stencil_store_op(vk::AttachmentStoreOp::DONT_CARE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .final_layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];
        let color_refs = [vk::AttachmentReference::builder()
            .attachment(0)
            .layout(vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL)];
        let subpasses = [vk::SubpassDescription::builder()
            .pipeline_bind_point(vk::PipelineBindPoint::GRAPHICS)
            .color_attachments(&color_refs)];

        let subpass_view_masks = [(1u32 << layer_count) - 1];
        let mut multiview_create_info = vk::RenderPassMultiviewCreateInfo::builder()
            .view_masks(&subpass_view_masks)
            .correlation_masks(&subpass_view_masks);
        let mut info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses);
        if self.parameters.multiview {
            info = info.push_next(&mut multiview_create_info);
        }
        Ok(Unique::new(
            device,
            unsafe { device.create_render_pass(&info, None) }.vk_check("vkCreateRenderPass")?,
        ))
    }
}

impl TestInstance for IndirectTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.parameters;
        let context = self.context;
        validate_limits(context)?;

        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let layer_count = if params.multiview { 2u32 } else { 1 };
        let color_view_type = if layer_count > 1 {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        };

        let color_format = vk::Format::R8G8B8A8_UNORM;
        let render_pass = self.create_render_pass(color_format, layer_count)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(
            vk,
            binaries.get(&format!("indirect_vert_ps{}", (params.point_size > 0) as u32))?,
        )?;
        let frag_module = create_shader_module(vk, binaries.get("indirect_frag")?)?;

        let color_subres_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, layer_count);
        let layer_size = (IMAGE_SIZE * IMAGE_SIZE * 4) as vk::DeviceSize;
        let color_buffer_size = layer_size * layer_count as u64;
        let mut image_info = make_image_create_info(
            IVec2::new(IMAGE_SIZE as i32, IMAGE_SIZE as i32),
            color_format,
            vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
        );
        image_info.array_layers = layer_count;
        let color_image = ImageWithMemory::new(vk, allocator, image_info, MemoryRequirement::ANY)?;
        let color_attachment =
            make_image_view(vk, color_image.get(), color_view_type, color_format, color_subres_range)?;
        let color_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // 4 triangles cover the top half and the bottom half of the image.
        #[rustfmt::skip]
        let vertex_buffer_vals: [f32; 48] = [
            -1.0, -1.0, 0.0, 1.0,
            -1.0, 0.0, 0.0, 1.0,
            1.0, -1.0, 0.0, 1.0,

            -1.0, 0.0, 0.0, 1.0,
            1.0, -1.0, 0.0, 1.0,
            1.0, 0.0, 0.0, 1.0,

            -1.0, -0.0, 0.0, 1.0,
            -1.0, 1.0, 0.0, 1.0,
            1.0, -0.0, 0.0, 1.0,

            -1.0, 1.0, 0.0, 1.0,
            1.0, -0.0, 0.0, 1.0,
            1.0, 1.0, 0.0, 1.0,
        ];

        let vertex_count = (vertex_buffer_vals.len() / 4) as u32; // 4 values per vertex.
        let vertex_buffer_size = (vertex_count * params.vertex_stride) as vk::DeviceSize;
        let vertex_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                vertex_buffer_size,
                vk::BufferUsageFlags::VERTEX_BUFFER
                    | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT
                    | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let vertex_buffer_offset: vk::DeviceSize = 0;
        // With counterOffset == true, we intend to only draw the upper half of the image.
        let counter_offset = if params.counter_offset {
            vertex_buffer_size as u32 / 2
        } else {
            0
        };
        let counter_buffer_value_size = std::mem::size_of::<u32>() as u32; // The counter buffer value is 4 bytes big.
        let counter_buffer_values = [0u32, params.vertex_stride * vertex_count]; // We may copy both or .y only.
        let counter_buffer_offset = if params.counter_buffer_offset {
            counter_buffer_value_size
        } else {
            0
        }; // For the draw.
        let counter_buffer_size =
            (counter_buffer_value_size * if params.counter_buffer_offset { 2 } else { 1 }) as vk::DeviceSize;
        let counter_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                counter_buffer_size,
                vk::BufferUsageFlags::INDIRECT_BUFFER
                    | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_COUNTER_BUFFER_EXT
                    | vk::BufferUsageFlags::TRANSFER_DST,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Note: for multiview the framebuffer layer count is also 1.
        let framebuffer = make_framebuffer(vk, *render_pass, &[*color_attachment], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let bindings = [vk::VertexInputBindingDescription {
            binding: 0,
            stride: std::mem::size_of::<[f32; 4]>() as u32,
            input_rate: vk::VertexInputRate::VERTEX,
        }];
        let attributes = [vk::VertexInputAttributeDescription {
            location: 0,
            binding: 0,
            format: vk::Format::R32G32B32A32_SFLOAT,
            offset: 0,
        }];
        let vertex_input = vk::PipelineVertexInputStateCreateInfo::builder()
            .vertex_binding_descriptions(&bindings)
            .vertex_attribute_descriptions(&attributes)
            .build();
        let stages = XfbStages {
            vert: *vert_module,
            frag: Some(*frag_module),
            ..XfbStages::default()
        };
        let options = XfbPipelineOptions {
            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
            vertex_input: Some(&vertex_input),
            attachment_count: 1,
            ..XfbPipelineOptions::default()
        };
        let pipeline = make_xfb_pipeline(
            vk,
            *pipeline_layout,
            *render_pass,
            &stages,
            (IMAGE_SIZE, IMAGE_SIZE),
            0,
            &options,
        )?;
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let pre_copy_barrier = make_image_memory_barrier(
            vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
            vk::AccessFlags::TRANSFER_READ,
            vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
            vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
            color_image.get(),
            color_subres_range,
        );
        let region = vk::BufferImageCopy {
            buffer_offset: 0,
            buffer_row_length: 0,
            buffer_image_height: 0,
            image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, layer_count),
            image_offset: vk::Offset3D { x: 0, y: 0, z: 0 },
            image_extent: vk::Extent3D {
                width: IMAGE_SIZE,
                height: IMAGE_SIZE,
                depth: 1,
            },
        };
        let post_copy_barrier = make_buffer_memory_barrier(
            vk::AccessFlags::TRANSFER_WRITE,
            vk::AccessFlags::HOST_READ,
            color_buffer.get(),
            0,
            vk::WHOLE_SIZE,
        );

        // fillBuffer
        let counter_bytes: Vec<u8> = counter_buffer_values[if params.counter_buffer_offset { 0 } else { 1 }..]
            .iter()
            .flat_map(|v| v.to_ne_bytes())
            .collect();
        unsafe {
            std::ptr::copy_nonoverlapping(
                counter_bytes.as_ptr(),
                counter_buffer.get_allocation().get_host_ptr(),
                counter_buffer_size as usize,
            )
        };
        flush_alloc(vk, counter_buffer.get_allocation())?;
        unsafe {
            std::ptr::copy_nonoverlapping(
                vertex_buffer_vals.as_ptr().cast::<u8>(),
                vertex_buffer.get_allocation().get_host_ptr(),
                std::mem::size_of_val(&vertex_buffer_vals),
            )
        };
        flush_alloc(vk, vertex_buffer.get_allocation())?;

        begin_command_buffer(vk, cmd_buffer)?;
        {
            begin_render_pass(
                vk,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, IMAGE_SIZE, IMAGE_SIZE),
                vk::ClearValue {
                    color: vk::ClearColorValue {
                        float32: [0.0, 0.0, 0.0, 1.0],
                    },
                },
            );
            unsafe {
                vk.cmd_bind_vertex_buffers(cmd_buffer, 0, &[vertex_buffer.get()], &[vertex_buffer_offset]);

                vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

                vk.cmd_draw_indirect_byte_count_ext(
                    cmd_buffer,
                    1,
                    0,
                    counter_buffer.get(),
                    counter_buffer_offset as vk::DeviceSize,
                    counter_offset,
                    params.vertex_stride,
                );
            }
            end_render_pass(vk, cmd_buffer);

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_copy_barrier],
                );
                vk.cmd_copy_image_to_buffer(
                    cmd_buffer,
                    color_image.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    color_buffer.get(),
                    &[region],
                );
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[post_copy_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        invalidate_alloc(vk, color_buffer.get_allocation())?;
        let result = unsafe {
            std::slice::from_raw_parts(
                color_buffer.get_allocation().get_host_ptr().cast_const(),
                color_buffer_size as usize,
            )
        };

        let mut fail = false;
        for layer_idx in 0..layer_count as usize {
            let layer = &result[layer_idx * layer_size as usize..(layer_idx + 1) * layer_size as usize];
            if !self.verify_image(layer) {
                fail = true;
            }
        }

        if fail {
            return Ok(TestStatus::fail("Fail; check log for details"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `addTransformFeedbackTestCaseVariants`: point sizes 0 and 1, the second with the `_ptsz` suffix; the topology is a triangle list, so
/// neither is illegal.
fn add_variants(group: &mut TestCaseGroup, name: &str, parameters: IndirectParameters) {
    for (case_count, point_size) in [parameters.point_size, 1].into_iter().enumerate() {
        let test_name = format!("{name}{}", if case_count > 0 { "_ptsz" } else { "" });
        group.add_child(Box::new(IndirectTestCase {
            name: test_name,
            parameters: IndirectParameters {
                point_size,
                ..parameters
            },
        }) as Box<dyn TestCase>);
    }
}

/// The `draw_indirect*` block of `createTransformFeedbackSimpleTests`.
pub(super) fn add_indirect_tests(group: &mut TestCaseGroup) {
    const VERTEX_STRIDES: [u32; 5] = [4, 61, 127, 251, 509];

    for multiview in [false, true] {
        for counter_offset in [false, true] {
            for counter_buffer_offset in [false, true] {
                // We are not mixing these two to save some combinations.
                if counter_offset && counter_buffer_offset {
                    continue;
                }

                let test_name = format!(
                    "draw_indirect{}{}{}",
                    if multiview { "_multiview" } else { "" },
                    if counter_offset { "_counter_offset" } else { "" },
                    if counter_buffer_offset {
                        "_counter_buffer_offset"
                    } else {
                        ""
                    }
                );

                for stride in VERTEX_STRIDES {
                    let vertex_stride_bytes = (std::mem::size_of::<u32>() as u32) * stride;
                    let parameters = IndirectParameters {
                        multiview,
                        counter_offset,
                        counter_buffer_offset,
                        vertex_stride: vertex_stride_bytes,
                        point_size: 0,
                    };

                    // Rendering tests with various strides
                    add_variants(group, &format!("{test_name}_{vertex_stride_bytes}"), parameters);

                    if !counter_offset && !counter_buffer_offset {
                        add_variants(
                            group,
                            &format!("{test_name}_beginqueryindexed_streamid_0_{vertex_stride_bytes}"),
                            parameters,
                        );
                        add_variants(
                            group,
                            &format!("{test_name}_endqueryindexed_streamid_0_{vertex_stride_bytes}"),
                            parameters,
                        );
                    }
                }
            }
        }
    }
}
