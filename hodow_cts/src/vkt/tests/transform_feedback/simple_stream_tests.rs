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
// Modifications: rewritten in Rust for hodow_cts. The `TEST_TYPE_MULTIQUERY` and `TEST_TYPE_LINES_TRIANGLES` types of the `simple` group
// (`multiquery_*`, `multiquery_omit_write_*`, `lines_or_triangles_*`). Their shaders are in
// `shaders/manifest/transform_feedback_simple_streams.toml`, written by `scripts/gen_xfb_simple_streams_shaders.py`.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1};

use super::simple_pipeline::{XfbPipelineOptions, XfbStages, make_xfb_pipeline};
use super::simple_tests::{
    IMAGE_SIZE, make_attachmentless_render_pass, make_pipeline_layout, validate_limits, zero_clear_value,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
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
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The one program set of these cases; a case picks its shaders by name.
pub struct XfbStreamPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `INVOCATION_COUNT`
const INVOCATION_COUNT: u32 = 8;
/// `LINES_LIST`
const LINES_LIST: [u32; 3] = [2, 6, 3];
/// `TRIANGLES_LIST`
const TRIANGLES_LIST: [u32; 5] = [3, 8, 6, 5, 4];

#[derive(Clone, Copy, PartialEq, Eq)]
enum StreamTestType {
    MultiQuery,
    LinesTriangles,
}

#[derive(Clone, Copy)]
struct StreamParameters {
    test_type: StreamTestType,
    buffer_size: u32,
    part_count: u32,
    stream_id: u32,
    point_size: u32,
    omit_shader_write: bool,
    /// `primTopology` of the lines_or_triangles cases: the strip the geometry shader outputs.
    line: bool,
}

impl StreamParameters {
    fn point_size_wanted(&self) -> bool {
        self.point_size > 0
    }

    fn vertex_shader_name(&self) -> &'static str {
        match self.test_type {
            StreamTestType::MultiQuery => "multiquery_vert",
            StreamTestType::LinesTriangles => "lines_triangles_vert",
        }
    }

    fn geometry_shader_name(&self) -> String {
        let (stream, ps) = (self.stream_id, self.point_size_wanted() as u32);
        match self.test_type {
            StreamTestType::MultiQuery => format!(
                "multiquery_geom_s{stream}_ps{ps}{}",
                if self.omit_shader_write { "_omit" } else { "" }
            ),
            StreamTestType::LinesTriangles => format!(
                "lines_triangles_geom_{}_s{stream}_ps{ps}",
                if self.line { "line" } else { "tri" }
            ),
        }
    }
}

struct StreamTestCase {
    name: String,
    parameters: StreamParameters,
}

impl TestCase for StreamTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TransformFeedbackTestCase::checkSupport`, for the two test types (both use a geometry shader).
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

        let require_rast_stream_select = self.parameters.test_type == StreamTestType::LinesTriangles;
        if require_rast_stream_select
            && xfb_properties.transform_feedback_rasterization_stream_select == vk::FALSE
            && self.parameters.stream_id > 0
        {
            return Err(TestError::NotSupported(
                "transformFeedbackRasterizationStreamSelect property is not supported".to_string(),
            ));
        }

        if self.parameters.point_size > 1 {
            return Err(TestError::NotSupported(
                "largePoints feature is not supported".to_string(),
            ));
        }

        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature is not supported".to_string(),
            ));
        }

        if self.parameters.point_size_wanted()
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
        Box::new(StreamTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

/// `TransformFeedbackMultiQueryTestInstance` and `TransformFeedbackLinesOrTrianglesTestInstance`
struct StreamTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: StreamParameters,
}

fn not_supported_if_less(name: &str, supported: u32, required: u32) -> Result<(), TestError> {
    if supported < required {
        return Err(TestError::NotSupported(format!(
            "{name}={supported}, while test requires {required}"
        )));
    }
    Ok(())
}

/// `destripedLineCount`
fn destriped_line_count(stripe_sizes: &[u32]) -> u32 {
    stripe_sizes.iter().map(|&x| if x > 1 { x - 1 } else { 0 }).sum()
}

/// `destripedTriangleCount`
pub(super) fn destriped_triangle_count(stripe_sizes: &[u32]) -> u32 {
    stripe_sizes.iter().map(|&x| if x > 2 { x - 2 } else { 0 }).sum()
}

type Vec4 = [f32; 4];

/// `verifyVertexDataWithWinding`: every primitive must hold the reference vertices in the same winding order, with any first vertex.
fn verify_vertex_data_with_winding(
    reference: &[Vec4],
    result: &[Vec4],
    vertices_per_primitive: usize,
    threshold: f32,
) -> Vec<String> {
    let primitive_count = result.len() / vertices_per_primitive;
    let mut errors = Vec::new();

    for prim_idx in 0..primitive_count {
        let past_vertex_count = vertices_per_primitive * prim_idx;
        let result_prim = &result[past_vertex_count..past_vertex_count + vertices_per_primitive];
        let reference_prim = &reference[past_vertex_count..past_vertex_count + vertices_per_primitive];

        let primitive_ok = (0..vertices_per_primitive).any(|first_vertex| {
            (0..vertices_per_primitive).all(|vert_idx| {
                let ref_vertex = &reference_prim[(first_vertex + vert_idx) % vertices_per_primitive];
                let res_vertex = &result_prim[vert_idx];
                ref_vertex
                    .iter()
                    .zip(res_vertex)
                    .all(|(a, b)| (a - b).abs() <= threshold)
            })
        });

        if !primitive_ok {
            errors.push(format!("Primitive {prim_idx} failed: expected rotation of {reference_prim:?} but found {result_prim:?}; threshold: {threshold}"));
        }
    }

    errors
}

/// `checkErrorVec`
fn check_error_vec(errors: &[String]) -> Result<(), TestError> {
    if errors.is_empty() {
        return Ok(());
    }
    let shown = errors.iter().take(8).cloned().collect::<Vec<_>>().join("; ");
    Err(TestError::Fail(format!(
        "Vertex data verification failed ({} errors): {shown}",
        errors.len()
    )))
}

fn read_vec4s(bytes: &[u8]) -> Vec<Vec4> {
    bytes
        .chunks_exact(16)
        .map(|chunk| {
            let mut v = [0f32; 4];
            for (i, c) in chunk.chunks_exact(4).enumerate() {
                v[i] = f32::from_ne_bytes(c.try_into().expect("four bytes"));
            }
            v
        })
        .collect()
}

impl StreamTestInstance<'_> {
    /// The constructor checks of `TransformFeedbackMultiQueryTestInstance` / `TransformFeedbackLinesOrTrianglesTestInstance`.
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

        let streams_required = params.stream_id + 1;
        let bytes_per_vertex = params.buffer_size / params.part_count;

        debug_assert!(params.part_count == 2);

        if params.test_type == StreamTestType::LinesTriangles
            && xfb_properties.transform_feedback_streams_lines_triangles == vk::FALSE
        {
            return Err(TestError::NotSupported(
                "transformFeedbackStreamsLinesTriangles required".to_string(),
            ));
        }

        if context.get_device_features().geometry_shader == vk::FALSE {
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
            streams_required,
        )?;
        not_supported_if_less(
            "maxTransformFeedbackBuffers",
            xfb_properties.max_transform_feedback_buffers,
            params.part_count,
        )?;

        if params.test_type == StreamTestType::MultiQuery {
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

            if xfb_properties.transform_feedback_queries == vk::FALSE {
                return Err(TestError::NotSupported(
                    "transformFeedbackQueries feature is not supported".to_string(),
                ));
            }
        }

        Ok(())
    }

    fn verify_lines(
        &self,
        tf_data: &[Vec4],
        primitives: &[u32],
        invocation_count: u32,
        part_count: u32,
    ) -> Result<(), TestError> {
        let mut n = 0u32;
        let mut reference: Vec<Vec4> =
            Vec::with_capacity((2 * destriped_line_count(primitives) * invocation_count * part_count) as usize);

        for _part_ndx in 0..part_count {
            for invocation_ndx in 0..invocation_count {
                for (stripe_ndx, &stripe_vertex_count) in primitives.iter().enumerate() {
                    for vertex_ndx in 0..stripe_vertex_count {
                        let first_or_last = vertex_ndx == 0 || vertex_ndx == stripe_vertex_count - 1;
                        let v = [n as f32, invocation_ndx as f32, stripe_ndx as f32, vertex_ndx as f32];
                        n += 1;

                        reference.push(v);

                        if !first_or_last {
                            reference.push(v);
                        }
                    }
                }
            }
        }

        debug_assert!(reference.len() == tf_data.len());

        check_error_vec(&verify_vertex_data_with_winding(&reference, tf_data, 2, 0.0001))
    }

    fn verify_triangles(
        &self,
        tf_data: &[Vec4],
        primitives: &[u32],
        invocation_count: u32,
        part_count: u32,
    ) -> Result<(), TestError> {
        let mut n = 0u32;
        let mut reference: Vec<Vec4> =
            Vec::with_capacity((3 * destriped_line_count(primitives) * invocation_count * part_count) as usize);

        for _part_ndx in 0..part_count {
            for invocation_ndx in 0..invocation_count {
                for (stripe_ndx, &stripe_vertex_count) in primitives.iter().enumerate() {
                    let triangles_count = stripe_vertex_count - 2;
                    let mut stripe: Vec<Vec4> = Vec::with_capacity(stripe_vertex_count as usize);

                    for vertex_ndx in 0..stripe_vertex_count {
                        stripe.push([n as f32, invocation_ndx as f32, stripe_ndx as f32, vertex_ndx as f32]);
                        n += 1;
                    }

                    for triangle_ndx in 0..triangles_count as usize {
                        if triangle_ndx % 2 == 0 {
                            reference.push(stripe[triangle_ndx]);
                            reference.push(stripe[triangle_ndx + 1]);
                            reference.push(stripe[triangle_ndx + 2]);
                        } else {
                            reference.push(stripe[triangle_ndx]);
                            reference.push(stripe[triangle_ndx + 2]);
                            reference.push(stripe[triangle_ndx + 1]);
                        }
                    }
                }
            }
        }

        debug_assert!(reference.len() == tf_data.len());

        check_error_vec(&verify_vertex_data_with_winding(&reference, tf_data, 3, 0.0001))
    }
}

impl TestInstance for StreamTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.check_instance_support()?;

        let params = self.parameters;
        let context = self.context;
        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let multi_query = params.test_type == StreamTestType::MultiQuery;

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
        let options = XfbPipelineOptions {
            rasterization_stream: (!multi_query).then_some(params.stream_id),
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

        let tf_buffer_size = params.buffer_size;
        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                tf_buffer_size as u64,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let tf_buf_array = vec![tf_buf.get(); params.part_count as usize];
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );

        // generateSizesList: equal chunks
        let chunk_size = (tf_buffer_size / params.part_count) as vk::DeviceSize;
        debug_assert!(chunk_size * params.part_count as u64 == tf_buffer_size as u64);
        let tf_buf_binding_sizes = vec![chunk_size; params.part_count as usize];
        let tf_buf_binding_offsets: Vec<vk::DeviceSize> =
            (0..params.part_count as u64).map(|i| i * chunk_size).collect();

        const BYTES_PER_VERTEX: u32 = 4 * std::mem::size_of::<f32>() as u32;
        const QUERY_COUNTERS_NUMBER: u32 = 2;
        const QUERY_STRIDE: usize = 2 * std::mem::size_of::<u32>();
        const QUERY_INVALID_COUNTER_VALUE: u32 = 999999;
        let query_index = 0u32;
        let query_data_size = QUERY_COUNTERS_NUMBER as usize * QUERY_STRIDE;
        let num_vertices_in_buffer = chunk_size as u32 / BYTES_PER_VERTEX;
        let num_draw_vertices = num_vertices_in_buffer / 2;

        let query_pool = if multi_query {
            let query_pool_info = vk::QueryPoolCreateInfo::builder()
                .query_type(vk::QueryType::TRANSFORM_FEEDBACK_STREAM_EXT)
                .query_count(QUERY_COUNTERS_NUMBER);
            Some(Unique::new(
                vk,
                unsafe { vk.create_query_pool(&query_pool_info, None) }.vk_check("vkCreateQueryPool")?,
            ))
        } else {
            None
        };

        begin_command_buffer(vk, cmd_buffer)?;
        {
            if let Some(query_pool) = &query_pool {
                unsafe { vk.cmd_reset_query_pool(cmd_buffer, **query_pool, query_index, QUERY_COUNTERS_NUMBER) };
            }

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

                if let Some(query_pool) = &query_pool {
                    vk.cmd_begin_query_indexed_ext(
                        cmd_buffer,
                        **query_pool,
                        query_index,
                        vk::QueryControlFlags::empty(),
                        0,
                    );
                    vk.cmd_begin_query_indexed_ext(
                        cmd_buffer,
                        **query_pool,
                        query_index + 1,
                        vk::QueryControlFlags::empty(),
                        params.stream_id,
                    );
                }
                {
                    (vk.commands().cmd_begin_transform_feedback_ext)(
                        cmd_buffer,
                        0,
                        0,
                        std::ptr::null(),
                        std::ptr::null(),
                    );
                    {
                        let draw_vertices = if multi_query {
                            num_draw_vertices
                        } else {
                            INVOCATION_COUNT
                        };
                        vk.cmd_draw(cmd_buffer, draw_vertices, 1, 0, 0);
                    }
                    (vk.commands().cmd_end_transform_feedback_ext)(
                        cmd_buffer,
                        0,
                        0,
                        std::ptr::null(),
                        std::ptr::null(),
                    );
                }
                if let Some(query_pool) = &query_pool {
                    vk.cmd_end_query_indexed_ext(cmd_buffer, **query_pool, query_index + 1, params.stream_id);
                    vk.cmd_end_query_indexed_ext(cmd_buffer, **query_pool, query_index, 0);
                }
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

        invalidate_alloc(vk, tf_buf.get_allocation())?;
        let tf_bytes = unsafe {
            std::slice::from_raw_parts(
                tf_buf.get_allocation().get_host_ptr().cast_const(),
                tf_buffer_size as usize,
            )
        };

        if let Some(query_pool) = &query_pool {
            let mut query_data = vec![0u8; query_data_size];
            for chunk in query_data.chunks_exact_mut(4) {
                chunk.copy_from_slice(&QUERY_INVALID_COUNTER_VALUE.to_ne_bytes());
            }
            unsafe {
                vk.get_query_pool_results(
                    **query_pool,
                    query_index,
                    QUERY_COUNTERS_NUMBER,
                    &mut query_data,
                    QUERY_STRIDE as vk::DeviceSize,
                    vk::QueryResultFlags::WAIT,
                )
            }
            .vk_check("vkGetQueryPoolResults")?;

            let query_expected_data: [(u32, u32); 2] = [
                (num_vertices_in_buffer, 3 * num_draw_vertices),
                (num_draw_vertices, num_draw_vertices),
            ];
            let tf_buf_expected_values = [0.5f32, 0.5 + params.stream_id as f32];

            for (counter_ndx, expected) in query_expected_data.iter().enumerate() {
                let word = |i: usize| {
                    u32::from_ne_bytes(
                        query_data[counter_ndx * QUERY_STRIDE + i * 4..counter_ndx * QUERY_STRIDE + i * 4 + 4]
                            .try_into()
                            .expect("four bytes"),
                    )
                };
                let (written, attempts) = (word(0), word(1));

                if written == QUERY_INVALID_COUNTER_VALUE || attempts == QUERY_INVALID_COUNTER_VALUE {
                    return Ok(TestStatus::fail("Query counters read failed"));
                }

                if written != expected.0 {
                    return Ok(TestStatus::fail(format!(
                        "At counter {counter_ndx} vertices written {written}, while expected {}",
                        expected.0
                    )));
                }

                if attempts != expected.1 {
                    return Ok(TestStatus::fail(format!(
                        "At counter {counter_ndx} attempts committed {attempts}, while expected {}",
                        expected.1
                    )));
                }

                if counter_ndx == 0 && !params.omit_shader_write {
                    // verifyTransformFeedbackBuffer
                    let buf_bytes = (BYTES_PER_VERTEX * expected.0) as usize;
                    let buf_offset = tf_buf_binding_offsets[counter_ndx] as usize;
                    let expected_value = tf_buf_expected_values[counter_ndx];
                    for i in 0..buf_bytes / std::mem::size_of::<f32>() {
                        let at = buf_offset + i * 4;
                        let received = f32::from_ne_bytes(tf_bytes[at..at + 4].try_into().expect("four bytes"));
                        if received != expected_value {
                            return Err(TestError::Fail(format!(
                                "Failed at item {i} received:{received} expected:{expected_value}"
                            )));
                        }
                    }
                }
            }

            return Ok(TestStatus::pass("Pass"));
        }

        let tf_data = read_vec4s(tf_bytes);
        if params.line {
            self.verify_lines(&tf_data, &LINES_LIST, INVOCATION_COUNT, params.part_count)?;
        } else {
            self.verify_triangles(&tf_data, &TRIANGLES_LIST, INVOCATION_COUNT, params.part_count)?;
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `addTransformFeedbackTestCaseVariants`: point sizes 0 and 1, the second with the `_ptsz` suffix; none of these variants is illegal,
/// since a geometry shader is always used.
fn add_variants(group: &mut TestCaseGroup, name: &str, parameters: StreamParameters) {
    for (case_count, point_size) in [parameters.point_size, 1].into_iter().enumerate() {
        let test_name = format!("{name}{}", if case_count > 0 { "_ptsz" } else { "" });
        group.add_child(Box::new(StreamTestCase {
            name: test_name,
            parameters: StreamParameters {
                point_size,
                ..parameters
            },
        }) as Box<dyn TestCase>);
    }
}

/// The `lines_or_triangles` and `multiquery` blocks of `createTransformFeedbackSimpleTests`.
pub(super) fn add_stream_tests(group: &mut TestCaseGroup) {
    const USED_STREAM_IDS: [u32; 4] = [1, 3, 6, 14];

    for (line, topology_name, output_vertex_count) in [
        (true, "line_strip_", 2 * destriped_line_count(&LINES_LIST)),
        (false, "triangle_strip_", 3 * destriped_triangle_count(&TRIANGLES_LIST)),
    ] {
        for stream_id in USED_STREAM_IDS {
            let part_count = 2u32;
            let bytes_per_vertex = 16u32;
            let buffer_size = part_count * INVOCATION_COUNT * output_vertex_count * bytes_per_vertex;
            let parameters = StreamParameters {
                test_type: StreamTestType::LinesTriangles,
                buffer_size,
                part_count,
                stream_id,
                point_size: 0,
                omit_shader_write: false,
                line,
            };
            add_variants(
                group,
                &format!("lines_or_triangles_{topology_name}{stream_id}"),
                parameters,
            );
        }
    }

    for stream_id in USED_STREAM_IDS {
        let streams_used = 2u32;
        let max_bytes_per_vertex = 256u32;
        let parameters = StreamParameters {
            test_type: StreamTestType::MultiQuery,
            buffer_size: max_bytes_per_vertex * streams_used,
            part_count: streams_used,
            stream_id,
            point_size: 0,
            omit_shader_write: false,
            line: false,
        };
        add_variants(group, &format!("multiquery_{stream_id}"), parameters);
        add_variants(
            group,
            &format!("multiquery_omit_write_{stream_id}"),
            StreamParameters {
                omit_shader_write: true,
                ..parameters
            },
        );
    }
}
