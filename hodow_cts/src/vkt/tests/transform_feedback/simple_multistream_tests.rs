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
// Modifications: rewritten in Rust for hodow_cts. `TEST_TYPE_MULTISTREAMS`, `TEST_TYPE_MULTISTREAMS_SAME_LOCATION` and the four
// `TEST_TYPE_STREAMS*` types of the `simple` group (`multistreams_*`, `multistreams_same_location_*`, `streams_*`, `streams_pointsize_*`,
// `streams_clipdistance_*`, `streams_culldistance_*`). The shaders are the `multistreams_*`, `same_location_*` and `streams_*` ones of
// `shaders/manifest/transform_feedback_simple_streams.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1};

use super::simple_pipeline::{XfbPipelineOptions, XfbStages, make_xfb_pipeline};
use super::simple_tests::{
    IMAGE_SIZE, make_attachmentless_render_pass, make_pipeline_layout, validate_limits, zero_clear_value,
};
use crate::tcu::{IVec2, TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::image_util::{
    ImageWithMemory, make_image_create_info, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer, make_memory_barrier, make_render_pass,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum MultiType {
    MultiStreams,
    MultiStreamsSameLocation,
    Streams,
    StreamsPointSize,
    StreamsClipDistance,
    StreamsCullDistance,
}

#[derive(Clone, Copy)]
struct MultiParameters {
    test_type: MultiType,
    buffer_size: u32,
    part_count: u32,
    stream_id: u32,
    point_size: u32,
}

impl MultiParameters {
    fn is_streams(&self) -> bool {
        matches!(
            self.test_type,
            MultiType::Streams
                | MultiType::StreamsPointSize
                | MultiType::StreamsClipDistance
                | MultiType::StreamsCullDistance
        )
    }

    fn vertex_shader_name(&self) -> &'static str {
        match self.test_type {
            MultiType::MultiStreams => "multistreams_vert",
            MultiType::MultiStreamsSameLocation => "same_location_vert",
            _ => "streams_vert",
        }
    }

    fn geometry_shader_name(&self) -> String {
        let (stream, ps) = (self.stream_id, self.point_size);
        match self.test_type {
            MultiType::MultiStreams => format!("multistreams_geom_s{stream}_ps{ps}"),
            MultiType::MultiStreamsSameLocation => format!("same_location_geom_s{stream}_ps{ps}"),
            MultiType::Streams => format!("streams_geom_streams_s{stream}_ps{ps}"),
            MultiType::StreamsPointSize => format!("streams_geom_pointsize_s{stream}_ps{ps}"),
            MultiType::StreamsClipDistance => format!("streams_geom_clip_s{stream}_ps{ps}"),
            MultiType::StreamsCullDistance => format!("streams_geom_cull_s{stream}_ps{ps}"),
        }
    }
}

struct MultiStreamTestCase {
    name: String,
    parameters: MultiParameters,
}

impl TestCase for MultiStreamTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TransformFeedbackTestCase::checkSupport`; every one of these types uses a geometry shader, and the `streams*` ones need
    /// `requireRastStreamSelect`.
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        context.require_device_functionality("VK_EXT_transform_feedback")?;

        let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut xfb_features);
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

        if self.parameters.is_streams()
            && xfb_properties.transform_feedback_rasterization_stream_select == vk::FALSE
            && self.parameters.stream_id > 0
        {
            return Err(TestError::NotSupported(
                "transformFeedbackRasterizationStreamSelect property is not supported".to_string(),
            ));
        }

        if self.parameters.point_size > 1 && context.get_device_features().large_points == vk::FALSE {
            return Err(TestError::NotSupported(
                "largePoints feature is not supported".to_string(),
            ));
        }

        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature is not supported".to_string(),
            ));
        }

        if self.parameters.point_size > 0
            && context
                .get_device_features()
                .shader_tessellation_and_geometry_point_size
                == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "shaderTessellationAndGeometryPointSize not supported".to_string(),
            ));
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::transform_feedback_simple_streams::XFB_STREAM_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MultiStreamTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

/// `TransformFeedbackMultistreamTestInstance`, `TransformFeedbackMultistreamSameLocationTestInstance` and
/// `TransformFeedbackStreamsTestInstance`
struct MultiStreamTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: MultiParameters,
}

fn not_supported_if_less(name: &str, supported: u32, required: u32) -> Result<(), TestError> {
    if supported < required {
        return Err(TestError::NotSupported(format!(
            "{name}={supported}, while test requires {required}"
        )));
    }
    Ok(())
}

impl MultiStreamTestInstance<'_> {
    /// The constructor checks of the three instances.
    fn check_instance_support(&self) -> Result<(), TestError> {
        let params = self.parameters;
        let context = self.context;
        let xfb_properties = validate_limits(context)?;

        let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut xfb_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        let features = context.get_device_features();

        if features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Missing feature: geometryShader".to_string()));
        }

        if xfb_features.geometry_streams == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryStreams feature is not supported".to_string(),
            ));
        }

        not_supported_if_less(
            "maxTransformFeedbackStreams",
            xfb_properties.max_transform_feedback_streams,
            params.stream_id + 1,
        )?;

        if params.is_streams() {
            if params.test_type == MultiType::StreamsPointSize
                && features.shader_tessellation_and_geometry_point_size == vk::FALSE
            {
                return Err(TestError::NotSupported(
                    "shaderTessellationAndGeometryPointSize feature is not supported".to_string(),
                ));
            }
            if params.test_type == MultiType::StreamsClipDistance && features.shader_clip_distance == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderClipDistance feature is not supported".to_string(),
                ));
            }
            if params.test_type == MultiType::StreamsCullDistance && features.shader_cull_distance == vk::FALSE {
                return Err(TestError::NotSupported(
                    "shaderCullDistance feature is not supported".to_string(),
                ));
            }
            return Ok(());
        }

        let (tf_buffers_required, bytes_per_vertex) = if params.test_type == MultiType::MultiStreamsSameLocation {
            (1, 4)
        } else {
            (params.part_count, params.buffer_size / params.part_count)
        };

        debug_assert!(params.test_type == MultiType::MultiStreamsSameLocation || params.part_count == 2);

        not_supported_if_less(
            "maxTransformFeedbackBuffers",
            xfb_properties.max_transform_feedback_buffers,
            tf_buffers_required,
        )?;
        not_supported_if_less(
            "maxTransformFeedbackStreamDataSize",
            xfb_properties.max_transform_feedback_stream_data_size,
            bytes_per_vertex,
        )?;
        not_supported_if_less(
            "maxTransformFeedbackBufferDataSize",
            xfb_properties.max_transform_feedback_buffer_data_size,
            bytes_per_vertex,
        )?;
        not_supported_if_less(
            "maxTransformFeedbackBufferDataStride",
            xfb_properties.max_transform_feedback_buffer_data_stride,
            bytes_per_vertex,
        )?;

        Ok(())
    }

    /// The two transform feedback buffer tests: both streams write into halves of one buffer.
    fn iterate_buffers(&self) -> TestOutcome {
        let params = self.parameters;
        let context = self.context;
        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();

        let render_pass = make_attachmentless_render_pass(vk)?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(vk, binaries.get(params.vertex_shader_name())?)?;
        let geom_module = create_shader_module(vk, binaries.get(&params.geometry_shader_name())?)?;

        let framebuffer = make_framebuffer(vk, *render_pass, &[], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let stages = XfbStages {
            vert: *vert_module,
            geom: Some(*geom_module),
            ..XfbStages::default()
        };
        let pipeline = make_xfb_pipeline(
            vk,
            *pipeline_layout,
            *render_pass,
            &stages,
            (IMAGE_SIZE, IMAGE_SIZE),
            0,
            &XfbPipelineOptions::default(),
        )?;
        let cmd_pool = make_command_pool(vk, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(vk, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = cmd_buffer.get();

        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                params.buffer_size as u64,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let tf_buf_array = vec![tf_buf.get(); params.part_count as usize];
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );

        // generateSizesList: equal chunks (the same location test lists its halves explicitly)
        let chunk_size = (params.buffer_size / params.part_count) as vk::DeviceSize;
        let tf_buf_binding_sizes = vec![chunk_size; params.part_count as usize];
        let tf_buf_binding_offsets: Vec<vk::DeviceSize> =
            (0..params.part_count as u64).map(|i| i * chunk_size).collect();
        let draw_vertices = if params.test_type == MultiType::MultiStreamsSameLocation {
            16
        } else {
            1
        };

        begin_command_buffer(vk, cmd_buffer)?;
        {
            begin_render_pass(
                vk,
                cmd_buffer,
                *render_pass,
                *framebuffer,
                make_rect_2d(0, 0, IMAGE_SIZE, IMAGE_SIZE),
                zero_clear_value(),
            );
            unsafe {
                vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

                vk.cmd_bind_transform_feedback_buffers_ext(
                    cmd_buffer,
                    0,
                    &tf_buf_array,
                    &tf_buf_binding_offsets,
                    &tf_buf_binding_sizes,
                );

                (vk.commands().cmd_begin_transform_feedback_ext)(cmd_buffer, 0, 0, std::ptr::null(), std::ptr::null());
                {
                    vk.cmd_draw(cmd_buffer, draw_vertices, 1, 0, 0);
                }
                (vk.commands().cmd_end_transform_feedback_ext)(cmd_buffer, 0, 0, std::ptr::null(), std::ptr::null());
            }
            end_render_pass(vk, cmd_buffer);

            unsafe {
                vk.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::TRANSFORM_FEEDBACK_EXT,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[tf_memory_barrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        // verifyTransformFeedbackBuffer
        invalidate_alloc(vk, tf_buf.get_allocation())?;
        let bytes = unsafe {
            std::slice::from_raw_parts(
                tf_buf.get_allocation().get_host_ptr().cast_const(),
                params.buffer_size as usize,
            )
        };
        let word = |i: usize| -> [u8; 4] { bytes[i * 4..i * 4 + 4].try_into().expect("four bytes") };
        let num_points = params.buffer_size as usize / std::mem::size_of::<u32>();

        for i in 0..num_points {
            if params.test_type == MultiType::MultiStreams {
                let received = f32::from_ne_bytes(word(i));
                if received != i as f32 {
                    return Err(TestError::Fail(format!(
                        "Failed at item {} received:{received} expected:{i}",
                        i as f32
                    )));
                }
            } else {
                let received = u32::from_ne_bytes(word(i));
                let expected = (i as u32 * 2).wrapping_sub(if i / 16 == 0 { 0 } else { 31 });
                if received != expected {
                    return Err(TestError::Fail(format!(
                        "Failed at item {i} received:{received} expected:{i}"
                    )));
                }
            }
        }

        Ok(TestStatus::pass("Pass"))
    }

    /// `TransformFeedbackStreamsTestInstance::verifyImage`: the reference image, compared with a threshold of one per channel.
    fn verify_image(&self, size: u32, result: &[u8]) -> bool {
        const MAGENTA: [u8; 4] = [0xFF, 0x00, 0xFF, 0xFF];
        const BLACK: [u8; 4] = [0x00, 0x00, 0x00, 0xFF];
        let params = self.parameters;
        let (width, height) = (size as usize, size as usize);
        let mut reference = vec![BLACK; width * height];

        match params.test_type {
            MultiType::Streams => {
                for y in height / 2..height {
                    for x in 0..width {
                        reference[y * width + x] = MAGENTA;
                    }
                }
            }
            MultiType::StreamsClipDistance | MultiType::StreamsCullDistance => {
                for y in height / 2..height {
                    for x in width / 2..width {
                        reference[y * width + x] = MAGENTA;
                    }
                }
            }
            MultiType::StreamsPointSize => {
                let point_size = params.point_size as usize;
                reference[((height * 3) / 4 - 1) * width + (1 + width) / 4 - 1] = MAGENTA;

                for y in 0..point_size {
                    for x in 0..point_size {
                        reference[(y + (height * 3) / 4 - 1) * width + x + (width * 3) / 4 - 1] = MAGENTA;
                    }
                }
            }
            _ => unreachable!("not a streams test"),
        }

        let expected: Vec<u8> = reference.iter().flatten().copied().collect();
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

    /// `TransformFeedbackStreamsTestInstance::iterate`
    fn iterate_streams(&self) -> TestOutcome {
        let params = self.parameters;
        let context = self.context;
        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();

        let color_format = vk::Format::R8G8B8A8_UNORM;
        let render_pass = make_render_pass(vk, color_format)?;
        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(vk, binaries.get(params.vertex_shader_name())?)?;
        let geom_module = create_shader_module(vk, binaries.get(&params.geometry_shader_name())?)?;
        let frag_module = create_shader_module(vk, binaries.get("streams_frag")?)?;

        let color_subres_range = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, 1);
        let color_buffer_size = (IMAGE_SIZE * IMAGE_SIZE * 4) as vk::DeviceSize;
        let color_image = ImageWithMemory::new(
            vk,
            allocator,
            make_image_create_info(
                IVec2::new(IMAGE_SIZE as i32, IMAGE_SIZE as i32),
                color_format,
                vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC,
            ),
            MemoryRequirement::ANY,
        )?;
        let color_attachment = make_image_view(
            vk,
            color_image.get(),
            vk::ImageViewType::_2D,
            color_format,
            color_subres_range,
        )?;
        let color_buffer = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(color_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        let framebuffer = make_framebuffer(vk, *render_pass, &[*color_attachment], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let stages = XfbStages {
            vert: *vert_module,
            geom: Some(*geom_module),
            frag: Some(*frag_module),
            ..XfbStages::default()
        };
        let options = XfbPipelineOptions {
            rasterization_stream: Some(params.stream_id),
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
            image_subresource: make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, 1),
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
                vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

                vk.cmd_draw(cmd_buffer, 2, 1, 0, 0);
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

        if !self.verify_image(IMAGE_SIZE, result) {
            return Ok(TestStatus::fail("Fail"));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for MultiStreamTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.check_instance_support()?;

        if self.parameters.is_streams() {
            self.iterate_streams()
        } else {
            self.iterate_buffers()
        }
    }
}

/// `addTransformFeedbackTestCaseVariants`: point sizes `parameters.point_size` and, when that is 0, 1 as well (the `_ptsz` one).
fn add_variants(group: &mut TestCaseGroup, name: &str, parameters: MultiParameters) {
    let mut point_sizes = vec![parameters.point_size];
    if parameters.point_size == 0 {
        point_sizes.push(1);
    }

    for (case_count, point_size) in point_sizes.into_iter().enumerate() {
        let test_name = format!("{name}{}", if case_count > 0 { "_ptsz" } else { "" });
        group.add_child(Box::new(MultiStreamTestCase {
            name: test_name,
            parameters: MultiParameters {
                point_size,
                ..parameters
            },
        }) as Box<dyn TestCase>);
    }
}

/// `createTransformFeedbackStreamsSimpleTests` and the `multistreams` and `multistreams_same_location` blocks of
/// `createTransformFeedbackSimpleTests`.
pub(super) fn add_multistream_tests(group: &mut TestCaseGroup) {
    const USED_STREAM_IDS: [u32; 4] = [1, 3, 6, 14];

    let streams_types = [
        (MultiType::Streams, "streams"),
        (MultiType::StreamsPointSize, "streams_pointsize"),
        (MultiType::StreamsClipDistance, "streams_clipdistance"),
        (MultiType::StreamsCullDistance, "streams_culldistance"),
    ];
    for (test_type, test_name) in streams_types {
        let point_size = if test_type == MultiType::StreamsPointSize { 2 } else { 0 };

        for stream_id in USED_STREAM_IDS {
            let parameters = MultiParameters {
                test_type,
                buffer_size: 0,
                part_count: 0,
                stream_id,
                point_size,
            };
            add_variants(group, &format!("{test_name}_{stream_id}"), parameters);
        }
    }

    for stream_id in USED_STREAM_IDS {
        let streams_used = 2u32;
        let max_bytes_per_vertex = 256u32;
        let parameters = MultiParameters {
            test_type: MultiType::MultiStreams,
            buffer_size: max_bytes_per_vertex * streams_used,
            part_count: streams_used,
            stream_id,
            point_size: 0,
        };
        add_variants(group, &format!("multistreams_{stream_id}"), parameters);
    }

    for stream_id in USED_STREAM_IDS {
        let streams_used = 2u32;
        let parameters = MultiParameters {
            test_type: MultiType::MultiStreamsSameLocation,
            buffer_size: 32 * 4,
            part_count: streams_used,
            stream_id,
            point_size: 0,
        };
        add_variants(group, &format!("multistreams_same_location_{stream_id}"), parameters);
    }
}
