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
// Modifications: rewritten in Rust for hodow_cts. `TEST_TYPE_BASIC_TRIANGLES` (`basic_triangles`) and the three
// `TEST_TYPE_DEPTH_CLIP_CONTROL_*` types (`depth_clip_control_vertex`, `_geometry`, `_tese`) of the `simple` group. The shaders are the
// `basic_triangles_*` and `depth_clip_*` ones of `shaders/manifest/transform_feedback_simple_streams.toml`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1};

use super::simple_pipeline::{XfbPipelineOptions, XfbStages, make_xfb_pipeline};
use super::simple_tests::{
    IMAGE_SIZE, make_attachmentless_render_pass, make_pipeline_layout, validate_limits, zero_clear_value,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::cmd_util::{
    begin_command_buffer, begin_render_pass, end_command_buffer, end_render_pass, make_rect_2d,
    submit_commands_and_wait,
};
use crate::vk::mem_util::{MemoryRequirement, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq)]
enum DepthClipType {
    BasicTriangles,
    Vertex,
    Geometry,
    Tese,
}

#[derive(Clone, Copy)]
struct DepthClipParameters {
    test_type: DepthClipType,
    buffer_size: u32,
    part_count: u32,
    point_size: u32,
}

impl DepthClipParameters {
    fn point_size_wanted(&self) -> bool {
        self.point_size > 0
    }

    /// `getFloatsPerVertex`: 4 for position, 1 for pointsize in some cases. Needs to match shaders.
    fn floats_per_vertex(&self) -> u32 {
        if self.point_size_wanted() { 5 } else { 4 }
    }

    /// `getActualBufferSize`: for tessellation with a point size, the same number of points as without one.
    fn actual_buffer_size(&self) -> u32 {
        if self.test_type != DepthClipType::Tese || !self.point_size_wanted() {
            return self.buffer_size;
        }

        // These have to match shader code.
        let vertex_size_no_point_size = std::mem::size_of::<f32>() as u32 * 4;
        let vertex_size_point_size = std::mem::size_of::<f32>() as u32 * 5;

        let num_vertices = self.buffer_size / vertex_size_no_point_size;
        num_vertices * vertex_size_point_size
    }

    fn topology(&self) -> vk::PrimitiveTopology {
        match self.test_type {
            DepthClipType::BasicTriangles => vk::PrimitiveTopology::TRIANGLE_STRIP,
            DepthClipType::Tese => vk::PrimitiveTopology::PATCH_LIST,
            _ => vk::PrimitiveTopology::POINT_LIST,
        }
    }

    fn using_geom(&self) -> bool {
        self.test_type == DepthClipType::Geometry
    }

    fn using_tess(&self) -> bool {
        self.test_type == DepthClipType::Tese
    }
}

struct DepthClipTestCase {
    name: String,
    parameters: DepthClipParameters,
}

impl TestCase for DepthClipTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TransformFeedbackTestCase::checkSupport`, for these types.
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

        let features = context.get_device_features();
        if self.parameters.using_geom() && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature is not supported".to_string(),
            ));
        }

        if self.parameters.using_tess() && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "tessellationShader feature is not supported".to_string(),
            ));
        }

        if self.parameters.point_size_wanted()
            && (self.parameters.using_geom() || self.parameters.using_tess())
            && features.shader_tessellation_and_geometry_point_size == vk::FALSE
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
        Box::new(DepthClipTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

/// `TransformFeedbackBasicTrianglesTestInstance` and `TransformFeedbackDepthClipControlTestInstance`
struct DepthClipTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: DepthClipParameters,
}

impl DepthClipTestInstance<'_> {
    /// `TransformFeedbackBasicTrianglesTestInstance::iterate`: the transform feedback buffer is never read back.
    fn iterate_basic_triangles(&self) -> TestOutcome {
        let params = self.parameters;
        let context = self.context;
        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();

        let vertex_module = create_shader_module(vk, context.get_binary_collection().get("basic_triangles_vert")?)?;
        let render_pass = make_attachmentless_render_pass(vk)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let stages = XfbStages {
            vert: *vertex_module,
            ..XfbStages::default()
        };
        let options = XfbPipelineOptions {
            rasterization_stream: Some(0),
            topology: vk::PrimitiveTopology::TRIANGLE_LIST,
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

        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                params.buffer_size as u64,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;

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

            let offset: vk::DeviceSize = 0;
            unsafe {
                vk.cmd_bind_pipeline(cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);

                (vk.commands().cmd_bind_transform_feedback_buffers_ext)(
                    cmd_buffer,
                    0,
                    1,
                    &tf_buf.get(),
                    &offset,
                    std::ptr::null(),
                );

                (vk.commands().cmd_begin_transform_feedback_ext)(cmd_buffer, 0, 0, std::ptr::null(), std::ptr::null());
                vk.cmd_draw(cmd_buffer, 3, 1, 0, 0);
                (vk.commands().cmd_end_transform_feedback_ext)(cmd_buffer, 0, 0, std::ptr::null(), std::ptr::null());
            }

            end_render_pass(vk, cmd_buffer);
        }
        end_command_buffer(vk, cmd_buffer)?;
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        Ok(TestStatus::pass("Pass"))
    }

    /// `TransformFeedbackDepthClipControlTestInstance::iterate`
    fn iterate_depth_clip_control(&self) -> TestOutcome {
        let params = self.parameters;
        let context = self.context;
        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let has_geom_shader = params.test_type == DepthClipType::Geometry;
        let has_tessellation = params.test_type == DepthClipType::Tese;
        let ps = params.point_size_wanted() as u32;

        let binaries = context.get_binary_collection();
        let vertex_name = match params.test_type {
            DepthClipType::Vertex => "depth_clip_vertex_vert_ps1",
            _ => "depth_clip_plain_vert",
        };
        let vertex_module = create_shader_module(vk, binaries.get(vertex_name)?)?;
        let geom_module = if has_geom_shader {
            Some(create_shader_module(
                vk,
                binaries.get(&format!("depth_clip_geom_ps{ps}"))?,
            )?)
        } else {
            None
        };
        let tesc_module = if has_tessellation {
            Some(create_shader_module(vk, binaries.get("depth_clip_tesc")?)?)
        } else {
            None
        };
        let tese_module = if has_tessellation {
            Some(create_shader_module(
                vk,
                binaries.get(&format!("depth_clip_tese_ps{ps}"))?,
            )?)
        } else {
            None
        };

        let render_pass = make_attachmentless_render_pass(vk)?;
        let framebuffer = make_framebuffer(vk, *render_pass, &[], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let stages = XfbStages {
            vert: *vertex_module,
            tesc: tesc_module.as_ref().map(|m| **m),
            tese: tese_module.as_ref().map(|m| **m),
            geom: geom_module.as_ref().map(|m| **m),
            ..XfbStages::default()
        };
        let options = XfbPipelineOptions {
            rasterization_stream: Some(0),
            topology: params.topology(),
            depth_clip_control: true,
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

        let buffer_size_param = params.actual_buffer_size();
        let tf_buf_size = buffer_size_param as u64 * params.part_count as u64;
        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                tf_buf_size,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let tf_buf_array = vec![tf_buf.get(); params.part_count as usize];
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        let tf_buf_binding_sizes = vec![buffer_size_param as vk::DeviceSize; params.part_count as usize];
        let tf_buf_binding_offsets: Vec<vk::DeviceSize> = (0..params.part_count as u64)
            .map(|i| i * buffer_size_param as u64)
            .collect();
        let floats_per_vertex = params.floats_per_vertex();
        let per_vertex_data_size = floats_per_vertex * std::mem::size_of::<f32>() as u32;
        let num_vertices = buffer_size_param / per_vertex_data_size;

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
                    vk.cmd_draw(cmd_buffer, num_vertices, 1, 0, 0);
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

        // verifyTransformFeedbackBuffer, of the last binding
        invalidate_alloc(vk, tf_buf.get_allocation())?;
        let offset = tf_buf_binding_offsets[params.part_count as usize - 1] as usize;
        let verified_vertices = (buffer_size_param / (floats_per_vertex * std::mem::size_of::<f32>() as u32)) as usize;
        let bytes = unsafe {
            std::slice::from_raw_parts(
                tf_buf.get_allocation().get_host_ptr().cast_const().add(offset),
                buffer_size_param as usize,
            )
        };
        let float_at = |i: usize| f32::from_ne_bytes(bytes[i * 4..i * 4 + 4].try_into().expect("four bytes"));

        // We only care about the depth (z) value.
        let mut result: Vec<f32> = (0..verified_vertices)
            .map(|i| float_at(i * floats_per_vertex as usize + 2))
            .collect();

        // Tessellation generates triangles whose vertex data might be written into transform feedback buffer in a different order than
        // generated by the vertex shader. Sort the values here to allow comparison.
        if params.test_type == DepthClipType::Tese {
            result.sort_by(|a, b| a.total_cmp(b));
        }

        // Verify the vertex depth values match with the ones written by the shader.
        for (i, &received) in result.iter().enumerate() {
            let expected = i as f32 / 3.0 - 1.0;
            let epsilon = 0.0001f32;

            if (received - expected).abs() > epsilon {
                return Err(TestError::Fail(format!(
                    "Failed at vertex {i} depth. Received:{received} expected:{expected}"
                )));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

impl TestInstance for DepthClipTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.parameters;
        let context = self.context;
        let xfb_properties = validate_limits(context)?;

        if params.test_type == DepthClipType::BasicTriangles {
            return self.iterate_basic_triangles();
        }

        let features = context.get_device_features();

        if !context.is_device_functionality_supported("VK_EXT_depth_clip_control") {
            return Err(TestError::NotSupported(
                "VK_EXT_depth_clip_control is not supported".to_string(),
            ));
        }

        if params.test_type == DepthClipType::Geometry && features.geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Geometry shader not supported".to_string()));
        }

        if params.test_type == DepthClipType::Tese && features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }

        if xfb_properties.max_transform_feedback_buffers < params.part_count {
            return Err(TestError::NotSupported(format!(
                "maxTransformFeedbackBuffers={}, while test requires {}",
                xfb_properties.max_transform_feedback_buffers, params.part_count
            )));
        }

        self.iterate_depth_clip_control()
    }
}

/// The `basic_triangles` and `depth_clip_control_*` blocks of `createTransformFeedbackSimpleTests`.
pub(super) fn add_depth_clip_tests(group: &mut TestCaseGroup) {
    // Depth clip control tests. The point list of the vertex variant has to write its point size from the vertex shader, so the size-less
    // variant of that case is illegal and the size-1 one carries no `_ptsz` suffix.
    let vertex = DepthClipParameters {
        test_type: DepthClipType::Vertex,
        buffer_size: 96,
        part_count: 1,
        point_size: 1,
    };
    group.add_child(Box::new(DepthClipTestCase {
        name: "depth_clip_control_vertex".to_string(),
        parameters: vertex,
    }) as Box<dyn TestCase>);

    for (test_type, name) in [
        (DepthClipType::Geometry, "depth_clip_control_geometry"),
        (DepthClipType::Tese, "depth_clip_control_tese"),
    ] {
        for (case_count, point_size) in [0u32, 1].into_iter().enumerate() {
            let parameters = DepthClipParameters {
                test_type,
                buffer_size: 96,
                part_count: 1,
                point_size,
            };
            let test_name = format!("{name}{}", if case_count > 0 { "_ptsz" } else { "" });
            group.add_child(Box::new(DepthClipTestCase {
                name: test_name,
                parameters,
            }) as Box<dyn TestCase>);
        }
    }

    let basic_triangles = DepthClipParameters {
        test_type: DepthClipType::BasicTriangles,
        buffer_size: 96,
        part_count: 1,
        point_size: 0,
    };
    group.add_child(Box::new(DepthClipTestCase {
        name: "basic_triangles".to_string(),
        parameters: basic_triangles,
    }) as Box<dyn TestCase>);
}
