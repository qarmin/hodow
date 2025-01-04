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
// Modifications: rewritten in Rust for hodow_cts. The `TEST_TYPE_QUERY_GET`, `_COPY`, `_COPY_STRIDE_ZERO` and `_RESET` types of the
// `simple` group (`query_*`, `query_omit_write_*`, `query_copy_*`, `query_copy_stride_zero_*`, `host_query_reset_*`), over every
// primitive topology but the patch list. Their shaders are in `shaders/manifest/transform_feedback_simple_query.toml`, written by
// `scripts/gen_xfb_simple_query_shaders.py`. Upstream runs the point list cases that write no point size on a custom device that has
// `shaderTessellationAndGeometryPointSize` switched off; these cases discard rasterization, so the point size is never read and they run
// on the default device here.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtTransformFeedbackExtensionDeviceCommands, InstanceV1_1};

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
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_framebuffer,
};
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// The one program set, holding every distinct shader of the query cases; a case picks its own by name.
pub struct XfbQueryPrograms {
    pub name: &'static str,
    pub programs: BinaryCollection,
}

/// `StreamId0Mode`
#[derive(Clone, Copy, PartialEq, Eq)]
enum StreamId0Mode {
    Normal,
    BeginQueryIndexed,
    EndQueryIndexed,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum QueryType {
    Get,
    Copy,
    CopyStrideZero,
    Reset,
}

/// One entry of `topologyData`: the patch list is left out, as the query cases skip it.
struct TopologyInfo {
    name: &'static str,
    shader_name: &'static str,
    topology: vk::PrimitiveTopology,
    prim_size: u32,
    get_num_primitives: fn(u64) -> u64,
    get_num_vertices: fn(u64) -> u64,
}

static TOPOLOGY_DATA: [TopologyInfo; 10] = [
    TopologyInfo {
        name: "",
        shader_name: "point_list",
        topology: vk::PrimitiveTopology::POINT_LIST,
        prim_size: 1,
        get_num_primitives: |v| v,
        get_num_vertices: |p| p,
    },
    TopologyInfo {
        name: "line_list_",
        shader_name: "line_list",
        topology: vk::PrimitiveTopology::LINE_LIST,
        prim_size: 2,
        get_num_primitives: |v| v / 2,
        get_num_vertices: |p| p * 2,
    },
    TopologyInfo {
        name: "line_strip_",
        shader_name: "line_strip",
        topology: vk::PrimitiveTopology::LINE_STRIP,
        prim_size: 2,
        get_num_primitives: |v| v - 1,
        get_num_vertices: |p| p + 1,
    },
    TopologyInfo {
        name: "triangle_list_",
        shader_name: "triangle_list",
        topology: vk::PrimitiveTopology::TRIANGLE_LIST,
        prim_size: 3,
        get_num_primitives: |v| v / 3,
        get_num_vertices: |p| p * 3,
    },
    TopologyInfo {
        name: "triangle_strip_",
        shader_name: "triangle_strip",
        topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
        prim_size: 3,
        get_num_primitives: |v| v - 2,
        get_num_vertices: |p| p + 2,
    },
    TopologyInfo {
        name: "triangle_fan_",
        shader_name: "triangle_fan",
        topology: vk::PrimitiveTopology::TRIANGLE_FAN,
        prim_size: 3,
        get_num_primitives: |v| v - 2,
        get_num_vertices: |p| p + 2,
    },
    TopologyInfo {
        name: "line_list_with_adjacency_",
        shader_name: "line_list_with_adjacency",
        topology: vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
        prim_size: 2,
        get_num_primitives: |v| v / 4,
        get_num_vertices: |p| p * 4,
    },
    TopologyInfo {
        name: "line_strip_with_adjacency_",
        shader_name: "line_strip_with_adjacency",
        topology: vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
        prim_size: 2,
        get_num_primitives: |v| v - 3,
        get_num_vertices: |p| p + 3,
    },
    TopologyInfo {
        name: "triangle_list_with_adjacency_",
        shader_name: "triangle_list_with_adjacency",
        topology: vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
        prim_size: 3,
        get_num_primitives: |v| v / 6,
        get_num_vertices: |p| p * 6,
    },
    TopologyInfo {
        name: "triangle_strip_with_adjacency_",
        shader_name: "triangle_strip_with_adjacency",
        topology: vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
        prim_size: 3,
        get_num_primitives: |v| (v - 4) / 2,
        get_num_vertices: |p| p * 2 + 4,
    },
];

/// The fields of `TestParameters` these test types read. The point size is the one `addTransformFeedbackTestCaseVariants` picked.
#[derive(Clone, Copy)]
struct QueryParameters {
    query_type: QueryType,
    buffer_size: u32,
    stream_id: u32,
    point_size: u32,
    stream_id0_mode: StreamId0Mode,
    query64_bits: bool,
    omit_shader_write: bool,
    query_result_with_availability: bool,
    topology: &'static TopologyInfo,
}

impl QueryParameters {
    fn point_size_wanted(&self) -> bool {
        self.point_size > 0
    }

    fn vertex_shader_name(&self) -> String {
        format!("vert_ps{}", self.point_size_wanted() as u32)
    }

    /// The geometry shader `initPrograms` makes: GLSL for stream 0, SPIR-V assembly for `query` on any other stream, GLSL otherwise.
    fn geometry_shader_name(&self) -> String {
        let ps = self.point_size_wanted() as u32;
        let topology = self.topology.shader_name;
        if self.stream_id == 0 {
            format!(
                "geom_s0_{topology}_ps{ps}{}",
                if self.omit_shader_write { "_omit" } else { "" }
            )
        } else if self.query_type == QueryType::Get {
            format!("geom_asm_s{}_{topology}_ps{ps}", self.stream_id)
        } else {
            format!("geom_s{}_{topology}_ps{ps}", self.stream_id)
        }
    }
}

struct QueryTestCase {
    name: String,
    parameters: QueryParameters,
}

impl TestCase for QueryTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TransformFeedbackTestCase::checkSupport`, for the query test types (which use a geometry shader and request the rasterization
    /// stream select property).
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

        if xfb_properties.transform_feedback_rasterization_stream_select == vk::FALSE && self.parameters.stream_id > 0 {
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

        if self.parameters.query_type == QueryType::Reset {
            context.require_device_functionality("VK_EXT_host_query_reset")?;
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        crate::generated::shaders::transform_feedback_simple_query::XFB_QUERY_PROGRAMS.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(QueryTestInstance {
            context,
            parameters: self.parameters,
        })
    }
}

/// `TransformFeedbackQueryTestInstance`
struct QueryTestInstance<'a> {
    context: &'a Context<'a>,
    parameters: QueryParameters,
}

fn read_element(bytes: &[u8], wide: bool, index: usize) -> u64 {
    if wide {
        u64::from_ne_bytes(bytes[index * 8..index * 8 + 8].try_into().expect("sized by the caller"))
    } else {
        u32::from_ne_bytes(bytes[index * 4..index * 4 + 4].try_into().expect("sized by the caller")) as u64
    }
}

fn write_element(bytes: &mut [u8], wide: bool, index: usize, value: u64) {
    if wide {
        bytes[index * 8..index * 8 + 8].copy_from_slice(&value.to_ne_bytes());
    } else {
        bytes[index * 4..index * 4 + 4].copy_from_slice(&(value as u32).to_ne_bytes());
    }
}

impl TestInstance for QueryTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let params = self.parameters;
        let context = self.context;
        let xfb_properties = validate_limits(context)?;

        let streams_supported = xfb_properties.max_transform_feedback_streams;
        let streams_required = params.stream_id + 1;

        if context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported("Missing feature: geometryShader".to_string()));
        }

        let mut xfb_features = vk::PhysicalDeviceTransformFeedbackFeaturesEXT::default();
        let mut features2 = vk::PhysicalDeviceFeatures2::builder().push_next(&mut xfb_features);
        unsafe {
            context
                .get_instance()
                .get_physical_device_features2(context.get_physical_device(), &mut features2)
        };
        if streams_required > 1 && xfb_features.geometry_streams == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryStreams feature is not supported".to_string(),
            ));
        }

        if streams_supported < streams_required {
            return Err(TestError::NotSupported(format!(
                "maxTransformFeedbackStreams={streams_supported}, while test requires {streams_required}"
            )));
        }

        if xfb_properties.transform_feedback_queries == vk::FALSE {
            return Err(TestError::NotSupported(
                "transformFeedbackQueries feature is not supported".to_string(),
            ));
        }

        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let topology = params.topology;
        let is_copy = matches!(params.query_type, QueryType::Copy | QueryType::CopyStrideZero);

        let overflow_vertices = 3u64;
        let bytes_per_vertex = (4 * std::mem::size_of::<f32>()) as u32;
        let num_vertices_in_buffer = (params.buffer_size / bytes_per_vertex) as u64;
        let num_vertices_to_write = num_vertices_in_buffer + overflow_vertices;
        let render_pass = make_attachmentless_render_pass(vk)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(vk, binaries.get(&params.vertex_shader_name())?)?;
        let geom_module = create_shader_module(vk, binaries.get(&params.geometry_shader_name())?)?;

        let framebuffer = make_framebuffer(vk, *render_pass, &[], IMAGE_SIZE, IMAGE_SIZE, 1)?;
        let pipeline_layout = make_pipeline_layout(vk)?;
        let stages = XfbStages {
            vert: *vert_module,
            geom: Some(*geom_module),
            ..XfbStages::default()
        };
        let options = XfbPipelineOptions {
            rasterization_stream: Some(params.stream_id),
            topology: topology.topology,
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

        let tf_buffer_size =
            ((topology.get_num_primitives)(num_vertices_in_buffer) as u32) * topology.prim_size * bytes_per_vertex;
        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                tf_buffer_size as u64,
                vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let tf_buf_binding_size = tf_buffer_size as vk::DeviceSize;
        let tf_buf_binding_offset = 0 as vk::DeviceSize;

        let query_result_width = if params.query64_bits {
            std::mem::size_of::<u64>()
        } else {
            std::mem::size_of::<u32>()
        };
        let query_extra_flags = if params.query64_bits {
            vk::QueryResultFlags::_64
        } else {
            vk::QueryResultFlags::empty()
        };
        let query_counters_number = 1u32;
        let query_index = 0u32;
        const QUERY_RESULT_ELEMENTS: usize = 2;
        let query_data_size = QUERY_RESULT_ELEMENTS * query_result_width
            + if params.query_result_with_availability {
                query_result_width
            } else {
                0
            };
        let query_pool_info = vk::QueryPoolCreateInfo::builder()
            .query_type(vk::QueryType::TRANSFORM_FEEDBACK_STREAM_EXT)
            .query_count(query_counters_number);
        let query_pool = Unique::new(
            vk,
            unsafe { vk.create_query_pool(&query_pool_info, None) }.vk_check("vkCreateQueryPool")?,
        );

        let query_wait = if params.query_result_with_availability {
            vk::QueryResultFlags::WITH_AVAILABILITY
        } else {
            vk::QueryResultFlags::WAIT
        };

        debug_assert!(num_vertices_in_buffer * bytes_per_vertex as u64 == params.buffer_size as u64);

        let query_pool_results_buffer = if is_copy {
            Some(BufferWithMemory::new(
                vk,
                allocator,
                make_buffer_create_info(query_data_size as u64, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?)
        } else {
            None
        };

        begin_command_buffer(vk, cmd_buffer)?;
        {
            if params.query_type != QueryType::Reset {
                unsafe { vk.cmd_reset_query_pool(cmd_buffer, *query_pool, query_index, query_counters_number) };
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
                    &[tf_buf.get()],
                    &[tf_buf_binding_offset],
                    &[tf_buf_binding_size],
                );

                if params.stream_id == 0 && params.stream_id0_mode != StreamId0Mode::BeginQueryIndexed {
                    vk.cmd_begin_query(cmd_buffer, *query_pool, query_index, vk::QueryControlFlags::empty());
                } else {
                    vk.cmd_begin_query_indexed_ext(
                        cmd_buffer,
                        *query_pool,
                        query_index,
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
                        vk.cmd_draw(cmd_buffer, num_vertices_to_write as u32, 1, 0, 0);
                    }
                    (vk.commands().cmd_end_transform_feedback_ext)(
                        cmd_buffer,
                        0,
                        0,
                        std::ptr::null(),
                        std::ptr::null(),
                    );
                }
                if params.stream_id == 0 && params.stream_id0_mode != StreamId0Mode::EndQueryIndexed {
                    vk.cmd_end_query(cmd_buffer, *query_pool, query_index);
                } else {
                    vk.cmd_end_query_indexed_ext(cmd_buffer, *query_pool, query_index, params.stream_id);
                }
            }
            end_render_pass(vk, cmd_buffer);

            if let Some(results_buffer) = &query_pool_results_buffer {
                let mut copy_stride = query_data_size as vk::DeviceSize;
                if query_counters_number == 1 && params.query_type == QueryType::CopyStrideZero {
                    copy_stride = 0;
                }

                unsafe {
                    vk.cmd_copy_query_pool_results(
                        cmd_buffer,
                        *query_pool,
                        query_index,
                        query_counters_number,
                        results_buffer.get(),
                        0,
                        copy_stride,
                        query_wait | query_extra_flags,
                    );

                    let buffer_barrier = make_buffer_memory_barrier(
                        vk::AccessFlags::TRANSFER_WRITE,
                        vk::AccessFlags::HOST_READ,
                        results_buffer.get(),
                        0,
                        vk::WHOLE_SIZE,
                    );
                    vk.cmd_pipeline_barrier(
                        cmd_buffer,
                        vk::PipelineStageFlags::TRANSFER,
                        vk::PipelineStageFlags::HOST,
                        vk::DependencyFlags::empty(),
                        &[] as &[vk::MemoryBarrier],
                        &[buffer_barrier],
                        &[] as &[vk::ImageMemoryBarrier],
                    );
                }
            }
        }
        end_command_buffer(vk, cmd_buffer)?;

        if params.query_type == QueryType::Reset {
            unsafe { vk.reset_query_pool(*query_pool, query_index, query_counters_number) };
        }
        submit_commands_and_wait(vk, queue, cmd_buffer)?;

        {
            let mut query_data = vec![0u8; query_data_size];

            if let Some(results_buffer) = &query_pool_results_buffer {
                invalidate_alloc(vk, results_buffer.get_allocation())?;
                unsafe {
                    std::ptr::copy_nonoverlapping(
                        results_buffer.get_allocation().get_host_ptr().cast_const(),
                        query_data.as_mut_ptr(),
                        query_data.len(),
                    )
                };
            } else {
                unsafe {
                    vk.get_query_pool_results(
                        *query_pool,
                        query_index,
                        query_counters_number,
                        &mut query_data,
                        query_data_size as vk::DeviceSize,
                        query_wait | query_extra_flags,
                    )
                }
                .vk_check("vkGetQueryPoolResults")?;
            }

            // Query results not available
            let available_at = query_data_size - query_result_width;
            if u32::from_ne_bytes(
                query_data[available_at..available_at + 4]
                    .try_into()
                    .expect("four bytes"),
            ) == 0
            {
                return Ok(TestStatus::pass("Pass"));
            }

            // The number of primitives successfully written to the corresponding transform feedback buffer.
            let num_primitives_written = read_element(&query_data, params.query64_bits, 0);

            // The number of primitives output to the vertex stream.
            let num_primitives_needed = read_element(&query_data, params.query64_bits, 1);

            // Count how many primitives we should get by using selected topology.
            let primitives_in_buffer = (topology.get_num_primitives)(num_vertices_in_buffer);
            let primitives_to_write = (topology.get_num_primitives)(num_vertices_to_write);

            if num_primitives_written != primitives_in_buffer {
                return Ok(TestStatus::fail(format!(
                    "numPrimitivesWritten={num_primitives_written} while expected {primitives_in_buffer}"
                )));
            }

            if num_primitives_needed != primitives_to_write {
                return Ok(TestStatus::fail(format!(
                    "numPrimitivesNeeded={num_primitives_needed} while expected {primitives_to_write}"
                )));
            }
        }

        if params.query_type == QueryType::Reset {
            const QUERY_RESET_ELEMENTS: usize = QUERY_RESULT_ELEMENTS + 1; // For the availability bit.

            let query_data_avail_size = QUERY_RESET_ELEMENTS * query_result_width;
            let mut query_data = vec![0u8; query_data_avail_size];

            // Initialize values
            write_element(&mut query_data, params.query64_bits, 0, 1); // numPrimitivesWritten
            write_element(&mut query_data, params.query64_bits, 1, 1); // numPrimitivesNeeded
            write_element(&mut query_data, params.query64_bits, 2, 1); // Availability bit

            unsafe { vk.reset_query_pool(*query_pool, query_index, query_counters_number) };

            let res = unsafe {
                vk.get_query_pool_results(
                    *query_pool,
                    query_index,
                    query_counters_number,
                    &mut query_data,
                    query_data_avail_size as vk::DeviceSize,
                    vk::QueryResultFlags::WITH_AVAILABILITY | query_extra_flags,
                )
            };
            let not_ready = matches!(res, Ok(vk::SuccessCode::NOT_READY));
            let num_primitives_written = read_element(&query_data, params.query64_bits, 0);
            let num_primitives_needed = read_element(&query_data, params.query64_bits, 1);
            let availability_state = read_element(&query_data, params.query64_bits, 2);

            // From the Vulkan spec: with neither WAIT nor PARTIAL, no result values are written for a query in the unavailable state and
            // vkGetQueryPoolResults returns VK_NOT_READY; the availability state is still written when WITH_AVAILABILITY is set.
            if !not_ready || availability_state != 0 {
                return Ok(TestStatus::fail("QueryPoolResults incorrect reset"));
            }
            if num_primitives_written != 1 || num_primitives_needed != 1 {
                return Ok(TestStatus::fail("QueryPoolResults data was modified"));
            }
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// `addTransformFeedbackTestCaseVariants`, for the query types: point sizes 0 and 1, the second with the `_ptsz` suffix. None of these
/// variants is illegal, since a geometry shader is always used.
fn add_variants(group: &mut TestCaseGroup, name: &str, parameters: QueryParameters) {
    for (case_count, point_size) in [parameters.point_size, 1].into_iter().enumerate() {
        let test_name = format!("{name}{}", if case_count > 0 { "_ptsz" } else { "" });
        group.add_child(Box::new(QueryTestCase {
            name: test_name,
            parameters: QueryParameters {
                point_size,
                ..parameters
            },
        }) as Box<dyn TestCase>);
    }
}

/// The `query`, `query_copy`, `query_copy_stride_zero` and `host_query_reset` cases of `createTransformFeedbackSimpleTests`.
pub(super) fn add_query_tests(group: &mut TestCaseGroup) {
    const USED_STREAM_IDS: [u32; 5] = [0, 1, 3, 6, 14];
    // Lowest value has to be at least 6. Otherwise the triangles with adjacency can't be generated.
    const VERTEX_COUNTS: [u32; 5] = [6, 61, 127, 251, 509];
    let copy_types = [
        (QueryType::Copy, "query_copy"),
        (QueryType::CopyStrideZero, "query_copy_stride_zero"),
    ];

    for topology in &TOPOLOGY_DATA {
        for stream_id in USED_STREAM_IDS {
            for num_vertices in VERTEX_COUNTS {
                for query64_bits in [false, true] {
                    let width_str = if query64_bits { "_64bits" } else { "_32bits" };

                    let mut vert_count = num_vertices;

                    // The number of vertices in original test was 4.
                    if topology.topology == vk::PrimitiveTopology::POINT_LIST && vert_count == 6 {
                        vert_count -= 2;
                    }

                    // Round the number of vertices to match the used primitive topology - if necessary.
                    let primitive_count = (topology.get_num_primitives)(vert_count as u64);
                    let vertex_count = (topology.get_num_vertices)(primitive_count) as u32;

                    debug_assert!(vertex_count > 0);

                    let bytes_per_vertex = (4 * std::mem::size_of::<f32>()) as u32;
                    let buffer_size = bytes_per_vertex * vertex_count;
                    let mut parameters = QueryParameters {
                        query_type: QueryType::Get,
                        buffer_size,
                        stream_id,
                        point_size: 0,
                        stream_id0_mode: StreamId0Mode::Normal,
                        query64_bits,
                        omit_shader_write: false,
                        query_result_with_availability: false,
                        topology,
                    };
                    let suffix = format!("{}{}_{}{}", topology.name, stream_id, vertex_count, width_str);
                    let full_test_name = format!("query_{suffix}");
                    // Written primitives query test
                    add_variants(group, &full_test_name, parameters);

                    let omit_parameters = QueryParameters {
                        omit_shader_write: true,
                        ..parameters
                    };
                    add_variants(group, &format!("query_omit_write_{suffix}"), omit_parameters);

                    for (copy_type, copy_name) in copy_types {
                        let mut parameters_copy = QueryParameters {
                            query_type: copy_type,
                            ..parameters
                        };
                        add_variants(group, &format!("{copy_name}_{suffix}"), parameters_copy);

                        parameters_copy.query_result_with_availability = true;
                        add_variants(
                            group,
                            &format!("{copy_name}_{suffix}_query_with_availability"),
                            parameters_copy,
                        );
                    }

                    let parameters_host_query_reset = QueryParameters {
                        query_type: QueryType::Reset,
                        ..parameters
                    };
                    add_variants(
                        group,
                        &format!("host_query_reset_{suffix}"),
                        parameters_host_query_reset,
                    );

                    if stream_id == 0 {
                        parameters.stream_id0_mode = StreamId0Mode::BeginQueryIndexed;
                        add_variants(
                            group,
                            &format!("{full_test_name}_beginqueryindexed_streamid_0"),
                            parameters,
                        );

                        parameters.stream_id0_mode = StreamId0Mode::EndQueryIndexed;
                        add_variants(
                            group,
                            &format!("{full_test_name}_endqueryindexed_streamid_0"),
                            parameters,
                        );
                    }
                }
            }
        }
    }
}
