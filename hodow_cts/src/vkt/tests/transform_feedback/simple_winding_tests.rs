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
// Modifications: rewritten in Rust for hodow_cts. `TEST_TYPE_WINDING` of the `simple` group (`winding_<topology>_<vertices>`). The shaders are
// the `winding_*` ones of `shaders/manifest/transform_feedback_simple_streams.toml`.

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

/// `TopologyParameters`, with the name `topologyData` gives the topology.
struct WindingTopology {
    name: &'static str,
    topology: vk::PrimitiveTopology,
    /// number of vertex in primitive; 2 for line, 3 for triangle (9 for the patch list, whose tessellated vertices all carry the patch id)
    vertex_per_primitive: u32,
    get_num_generated_points: fn(u32) -> u32,
    get_expected_values_for_primitive: fn(u32) -> Vec<u32>,
}

static WINDING_TOPOLOGIES: [WindingTopology; 10] = [
    WindingTopology {
        name: "line_list_",
        topology: vk::PrimitiveTopology::LINE_LIST,
        vertex_per_primitive: 2,
        get_num_generated_points: |c| c,
        get_expected_values_for_primitive: |i| vec![2 * i, 2 * i + 1],
    },
    WindingTopology {
        name: "line_strip_",
        topology: vk::PrimitiveTopology::LINE_STRIP,
        vertex_per_primitive: 2,
        get_num_generated_points: |c| 2 * (c - 1),
        get_expected_values_for_primitive: |i| vec![i, i + 1],
    },
    WindingTopology {
        name: "triangle_list_",
        topology: vk::PrimitiveTopology::TRIANGLE_LIST,
        vertex_per_primitive: 3,
        get_num_generated_points: |c| c,
        get_expected_values_for_primitive: |i| vec![3 * i, 3 * i + 1, 3 * i + 2],
    },
    WindingTopology {
        name: "triangle_strip_",
        topology: vk::PrimitiveTopology::TRIANGLE_STRIP,
        vertex_per_primitive: 3,
        get_num_generated_points: |c| 3 * (c - 2),
        get_expected_values_for_primitive: |i| {
            let i_mod2 = i % 2;
            vec![i, i + 1 + i_mod2, i + 2 - i_mod2]
        },
    },
    WindingTopology {
        name: "triangle_fan_",
        topology: vk::PrimitiveTopology::TRIANGLE_FAN,
        vertex_per_primitive: 3,
        get_num_generated_points: |c| c,
        get_expected_values_for_primitive: |i| vec![i + 1, i + 2, 0],
    },
    WindingTopology {
        name: "line_list_with_adjacency_",
        topology: vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY,
        vertex_per_primitive: 2,
        // note: this cant be replaced with partCount / 2 as for partCount=6 we will get 3 instead of 2
        get_num_generated_points: |c| c / 4,
        get_expected_values_for_primitive: |i| vec![i + 1, i + 2],
    },
    WindingTopology {
        name: "line_strip_with_adjacency_",
        topology: vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY,
        vertex_per_primitive: 2,
        get_num_generated_points: |c| 2 * (c - 3),
        get_expected_values_for_primitive: |i| vec![i + 1, i + 2],
    },
    WindingTopology {
        name: "triangle_list_with_adjacency_",
        topology: vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY,
        vertex_per_primitive: 3,
        get_num_generated_points: |c| c / 2,
        get_expected_values_for_primitive: |i| vec![6 * i, 6 * i + 2, 6 * i + 4],
    },
    WindingTopology {
        name: "triangle_strip_with_adjacency_",
        topology: vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY,
        vertex_per_primitive: 3,
        get_num_generated_points: |c| 3 * (c / 2 - 2),
        get_expected_values_for_primitive: |i| {
            if i % 2 == 0 {
                vec![2 * i, 2 * i + 2, 2 * i + 4]
            } else {
                vec![2 * i, 2 * i + 4, 2 * i + 2]
            }
        },
    },
    WindingTopology {
        name: "patch_list_",
        topology: vk::PrimitiveTopology::PATCH_LIST,
        vertex_per_primitive: 9,
        get_num_generated_points: |c| c * 3,
        // we cant generate vertex numbers in tesselation evaluation shader; check if patch index is correct for every 9 generated vertex
        get_expected_values_for_primitive: |i| vec![i; 9],
    },
];

struct WindingTestCase {
    name: String,
    topology: &'static WindingTopology,
    part_count: u32,
    point_size: u32,
}

impl WindingTestCase {
    fn uses_geometry(&self) -> bool {
        matches!(
            self.topology.topology,
            vk::PrimitiveTopology::LINE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::LINE_STRIP_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_LIST_WITH_ADJACENCY
                | vk::PrimitiveTopology::TRIANGLE_STRIP_WITH_ADJACENCY
        )
    }

    fn uses_tessellation(&self) -> bool {
        self.topology.topology == vk::PrimitiveTopology::PATCH_LIST
    }
}

impl TestCase for WindingTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TransformFeedbackTestCase::checkSupport`, for `TEST_TYPE_WINDING`.
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

        if self.point_size > 1 {
            return Err(TestError::NotSupported(
                "largePoints feature is not supported".to_string(),
            ));
        }

        if self.uses_geometry() && context.get_device_features().geometry_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "geometryShader feature is not supported".to_string(),
            ));
        }

        if self.uses_tessellation() && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported(
                "tessellationShader feature is not supported".to_string(),
            ));
        }

        if self.point_size > 0
            && (self.uses_geometry() || self.uses_tessellation())
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
        Box::new(WindingTestInstance {
            context,
            topology: self.topology,
            part_count: self.part_count,
            point_size: self.point_size,
        })
    }
}

/// `TransformFeedbackWindingOrderTestInstance`
struct WindingTestInstance<'a> {
    context: &'a Context<'a>,
    topology: &'static WindingTopology,
    part_count: u32,
    point_size: u32,
}

/// `verifyVertexDataWithWinding` for `uint32_t` vertices with a zero threshold.
fn verify_vertex_data_with_winding(reference: &[u32], result: &[u32], vertices_per_primitive: usize) -> Vec<String> {
    let primitive_count = result.len() / vertices_per_primitive;
    let mut errors = Vec::new();

    for prim_idx in 0..primitive_count {
        let past_vertex_count = vertices_per_primitive * prim_idx;
        let result_prim = &result[past_vertex_count..past_vertex_count + vertices_per_primitive];
        let reference_prim = &reference[past_vertex_count..past_vertex_count + vertices_per_primitive];

        // Vertices must be in the same winding order, but the first vertex may vary. We test every rotation below.
        let primitive_ok = (0..vertices_per_primitive).any(|first_vertex| {
            (0..vertices_per_primitive).all(|vert_idx| {
                reference_prim[(first_vertex + vert_idx) % vertices_per_primitive] == result_prim[vert_idx]
            })
        });

        if !primitive_ok {
            errors.push(format!("Primitive {prim_idx} failed: expected rotation of {reference_prim:?} but found {result_prim:?}; threshold: 0"));
        }
    }

    errors
}

impl TestInstance for WindingTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let topology = self.topology;
        let requires_tessellation_stage = topology.topology == vk::PrimitiveTopology::PATCH_LIST;

        validate_limits(context)?;
        if requires_tessellation_stage && context.get_device_features().tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }

        debug_assert!(self.part_count >= 6);

        let vk = context.get_device();
        let queue_family_index = context.get_universal_queue_family_index();
        let queue = context.get_universal_queue();
        let allocator = context.get_default_allocator();
        let ps = (self.point_size > 0) as u32;

        let binaries = context.get_binary_collection();
        let vertex_name = if requires_tessellation_stage {
            "winding_patch_vert".to_string()
        } else {
            format!("winding_vert_ps{ps}")
        };
        let vertex_module = create_shader_module(vk, binaries.get(&vertex_name)?)?;
        let tesc_module = if requires_tessellation_stage {
            Some(create_shader_module(vk, binaries.get("winding_patch_tesc")?)?)
        } else {
            None
        };
        let tese_module = if requires_tessellation_stage {
            Some(create_shader_module(
                vk,
                binaries.get(&format!("winding_patch_tese_ps{ps}"))?,
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
            ..XfbStages::default()
        };
        let options = XfbPipelineOptions {
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

        let num_points = (topology.get_num_generated_points)(self.part_count);
        let buffer_size = num_points as vk::DeviceSize * std::mem::size_of::<u32>() as vk::DeviceSize;
        let tf_buf = BufferWithMemory::new(
            vk,
            allocator,
            make_buffer_create_info(
                buffer_size,
                vk::BufferUsageFlags::TRANSFER_SRC | vk::BufferUsageFlags::TRANSFORM_FEEDBACK_BUFFER_EXT,
            ),
            MemoryRequirement::HOST_VISIBLE,
        )?;
        let tf_memory_barrier = make_memory_barrier(
            vk::AccessFlags::TRANSFORM_FEEDBACK_WRITE_EXT,
            vk::AccessFlags::HOST_READ,
        );
        let start_value = 0u32;

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

                vk.cmd_bind_transform_feedback_buffers_ext(cmd_buffer, 0, &[tf_buf.get()], &[0], &[buffer_size]);

                vk.cmd_push_constants(
                    cmd_buffer,
                    *pipeline_layout,
                    vk::ShaderStageFlags::VERTEX,
                    0,
                    &start_value.to_ne_bytes(),
                );

                (vk.commands().cmd_begin_transform_feedback_ext)(cmd_buffer, 0, 0, std::ptr::null(), std::ptr::null());
                {
                    vk.cmd_draw(cmd_buffer, self.part_count, 1, 0, 0);
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
        let tf_data: Vec<u32> = unsafe {
            std::slice::from_raw_parts(
                tf_buf.get_allocation().get_host_ptr().cast_const().cast::<u32>(),
                num_points as usize,
            )
        }
        .to_vec();
        let vertex_per_primitive = topology.vertex_per_primitive as usize;
        let num_primitives = num_points as usize / vertex_per_primitive;

        let mut reference_values: Vec<u32> = Vec::with_capacity(num_primitives * vertex_per_primitive);
        for prim_idx in 0..num_primitives as u32 {
            reference_values.extend((topology.get_expected_values_for_primitive)(prim_idx));
        }

        let errors = verify_vertex_data_with_winding(&reference_values, &tf_data, vertex_per_primitive);
        if !errors.is_empty() {
            let shown = errors.iter().take(8).cloned().collect::<Vec<_>>().join("; ");
            return Err(TestError::Fail(format!(
                "Vertex data verification failed ({} errors): {shown}",
                errors.len()
            )));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

/// The `winding` block of `createTransformFeedbackSimpleTests`, through `addTransformFeedbackTestCaseVariants` (point sizes 0 and 1).
pub(super) fn add_winding_tests(group: &mut TestCaseGroup) {
    const BUFFER_COUNTS: [u32; 4] = [6, 8, 10, 12];

    for topology in &WINDING_TOPOLOGIES {
        for vertex_count in BUFFER_COUNTS {
            for (case_count, point_size) in [0u32, 1].into_iter().enumerate() {
                let name = format!(
                    "winding_{}{vertex_count}{}",
                    topology.name,
                    if case_count > 0 { "_ptsz" } else { "" }
                );
                group.add_child(Box::new(WindingTestCase {
                    name,
                    topology,
                    part_count: vertex_count,
                    point_size,
                }) as Box<dyn TestCase>);
            }
        }
    }
}
