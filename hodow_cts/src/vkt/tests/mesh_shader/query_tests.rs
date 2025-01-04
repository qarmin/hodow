// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/mesh_shader/vktMeshShaderQueryTestsEXT.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2022 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are manifest GLSL, one set per combination of geometry, task shader,
// image height, shuffled task count and multiview; `MeshQueryCase::programs` recomputes the shuffle from the case's seed to pick it.
// Upstream's seeds come from a static counter that advances once per `TestParams` built and a second time per case that is kept
// (`std::move` builds another one); `create_mesh_shader_query_tests_ext` keeps the same bookkeeping so the seeds line up.
//
// Draws one row of primitives per mesh work group under mesh primitives generated and task/mesh invocation pipeline statistics
// queries, fetched with a copy or a get, with every reset, availability and wait combination, and checks the counts.

use vulkanalia::prelude::v1_0::*;
use vulkanalia::vk::{DeviceV1_2, ExtMeshShaderExtensionDeviceCommands};

use crate::generated::shaders::mesh_shader_query::{
    QUERY_LINES_NOTASK_H0_MV0, QUERY_LINES_NOTASK_H0_MV1, QUERY_LINES_NOTASK_H40_MV0, QUERY_LINES_NOTASK_H40_MV1,
    QUERY_LINES_NOTASK_H240_MV0, QUERY_LINES_NOTASK_H240_MV1, QUERY_LINES_TASK_T0_H0_MV0, QUERY_LINES_TASK_T0_H0_MV1,
    QUERY_LINES_TASK_T0_H40_MV0, QUERY_LINES_TASK_T0_H40_MV1, QUERY_LINES_TASK_T0_H240_MV0,
    QUERY_LINES_TASK_T0_H240_MV1, QUERY_LINES_TASK_T1_H0_MV0, QUERY_LINES_TASK_T1_H0_MV1, QUERY_LINES_TASK_T1_H40_MV0,
    QUERY_LINES_TASK_T1_H40_MV1, QUERY_LINES_TASK_T1_H240_MV0, QUERY_LINES_TASK_T1_H240_MV1,
    QUERY_LINES_TASK_T2_H0_MV0, QUERY_LINES_TASK_T2_H0_MV1, QUERY_LINES_TASK_T2_H40_MV0, QUERY_LINES_TASK_T2_H40_MV1,
    QUERY_LINES_TASK_T2_H240_MV0, QUERY_LINES_TASK_T2_H240_MV1, QUERY_POINTS_NOTASK_H0_MV0, QUERY_POINTS_NOTASK_H0_MV1,
    QUERY_POINTS_NOTASK_H40_MV0, QUERY_POINTS_NOTASK_H40_MV1, QUERY_POINTS_NOTASK_H240_MV0,
    QUERY_POINTS_NOTASK_H240_MV1, QUERY_POINTS_TASK_T0_H0_MV0, QUERY_POINTS_TASK_T0_H0_MV1,
    QUERY_POINTS_TASK_T0_H40_MV0, QUERY_POINTS_TASK_T0_H40_MV1, QUERY_POINTS_TASK_T0_H240_MV0,
    QUERY_POINTS_TASK_T0_H240_MV1, QUERY_POINTS_TASK_T1_H0_MV0, QUERY_POINTS_TASK_T1_H0_MV1,
    QUERY_POINTS_TASK_T1_H40_MV0, QUERY_POINTS_TASK_T1_H40_MV1, QUERY_POINTS_TASK_T1_H240_MV0,
    QUERY_POINTS_TASK_T1_H240_MV1, QUERY_POINTS_TASK_T2_H0_MV0, QUERY_POINTS_TASK_T2_H0_MV1,
    QUERY_POINTS_TASK_T2_H40_MV0, QUERY_POINTS_TASK_T2_H40_MV1, QUERY_POINTS_TASK_T2_H240_MV0,
    QUERY_POINTS_TASK_T2_H240_MV1, QUERY_TRIANGLES_NOTASK_H0_MV0, QUERY_TRIANGLES_NOTASK_H0_MV1,
    QUERY_TRIANGLES_NOTASK_H40_MV0, QUERY_TRIANGLES_NOTASK_H40_MV1, QUERY_TRIANGLES_NOTASK_H240_MV0,
    QUERY_TRIANGLES_NOTASK_H240_MV1, QUERY_TRIANGLES_TASK_T0_H0_MV0, QUERY_TRIANGLES_TASK_T0_H0_MV1,
    QUERY_TRIANGLES_TASK_T0_H40_MV0, QUERY_TRIANGLES_TASK_T0_H40_MV1, QUERY_TRIANGLES_TASK_T0_H240_MV0,
    QUERY_TRIANGLES_TASK_T0_H240_MV1, QUERY_TRIANGLES_TASK_T1_H0_MV0, QUERY_TRIANGLES_TASK_T1_H0_MV1,
    QUERY_TRIANGLES_TASK_T1_H40_MV0, QUERY_TRIANGLES_TASK_T1_H40_MV1, QUERY_TRIANGLES_TASK_T1_H240_MV0,
    QUERY_TRIANGLES_TASK_T1_H240_MV1, QUERY_TRIANGLES_TASK_T2_H0_MV0, QUERY_TRIANGLES_TASK_T2_H0_MV1,
    QUERY_TRIANGLES_TASK_T2_H40_MV0, QUERY_TRIANGLES_TASK_T2_H40_MV1, QUERY_TRIANGLES_TASK_T2_H240_MV0,
    QUERY_TRIANGLES_TASK_T2_H240_MV1,
};
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::VkResultExt;
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, make_rect_2d, submit_commands_and_wait};
use crate::vk::image_util::{
    ImageWithMemory, make_buffer_image_copy, make_image_memory_barrier, make_image_subresource_layers,
    make_image_subresource_range, make_image_view,
};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_command_pool, make_framebuffer,
    make_memory_barrier,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vk::ref_util::Unique;
use crate::vkt::tests::draw::util::{DrawPipelineState, clear_value_color, create_draw_pipeline};
use crate::vkt::tests::mesh_shader::util::{
    check_task_mesh_shader_support_ext, mesh_shader_features, mesh_shader_properties,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const IMAGE_WIDTH: u32 = 32;
const MESH_WORK_GROUPS_PER_CALL: u32 = 4;
const TASK_WORK_GROUPS_PER_CALL: u32 = 2;

const MESH_WORK_GROUPS_PER_TASK: u32 = MESH_WORK_GROUPS_PER_CALL / TASK_WORK_GROUPS_PER_CALL;

const MESH_LOCAL_INVOCATIONS: u32 = 10 * 4;
const TASK_LOCAL_INVOCATIONS: u32 = 4 * 6;

const K64_SZ: vk::DeviceSize = 8;
const K32_SZ: vk::DeviceSize = 4;

#[derive(Clone, Copy, PartialEq, Eq)]
enum QueryType {
    Primitives,
    TaskInvocations,
    MeshInvocations,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum DrawCallType {
    Direct,
    Indirect,
    IndirectWithCount,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum GeometryType {
    Points,
    Lines,
    Triangles,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum ResetCase {
    None,
    /// After checking results normally, reset query from the host and verify availability.
    NoneWithHost,
    BeforeAccess,
    AfterAccess,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum AccessMethod {
    Copy,
    Get,
}

#[derive(Clone)]
struct TestParams {
    random_seed: u32,
    query_types: Vec<QueryType>,
    draw_blocks: Vec<u32>,
    draw_call: DrawCallType,
    geometry: GeometryType,
    reset_type: ResetCase,
    access: AccessMethod,
    use_64_bits: bool,
    availability_bit: bool,
    wait_bit: bool,
    use_task_shader: bool,
    inside_render_pass: bool,
    use_secondary: bool,
    multi_view: bool,
}

struct QuerySizesAndOffsets {
    query_item_size: vk::DeviceSize,
    primitives_query_size: vk::DeviceSize,
    stats_query_size: vk::DeviceSize,
    stats_query_offset: vk::DeviceSize,
}

impl TestParams {
    fn new(random_seed: u32) -> Self {
        Self {
            random_seed,
            query_types: Vec::new(),
            draw_blocks: Vec::new(),
            draw_call: DrawCallType::Direct,
            geometry: GeometryType::Points,
            reset_type: ResetCase::None,
            access: AccessMethod::Copy,
            use_64_bits: false,
            availability_bit: false,
            wait_bit: false,
            use_task_shader: false,
            inside_render_pass: false,
            use_secondary: false,
            multi_view: false,
        }
    }

    fn get_total_draw_count(&self) -> u32 {
        self.draw_blocks.iter().sum()
    }

    fn get_image_height(&self) -> u32 {
        self.get_total_draw_count() * MESH_WORK_GROUPS_PER_CALL
    }

    /// The goal is dispatching 4 mesh work groups per draw call in total. When not using task shaders, we dispatch that number
    /// directly. When using task shaders, we dispatch 2 task work groups that will dispatch 2 mesh work groups each. The axis will
    /// be pseudorandomly chosen in each case.
    fn get_draw_group_count(&self) -> u32 {
        if self.use_task_shader {
            TASK_WORK_GROUPS_PER_CALL
        } else {
            MESH_WORK_GROUPS_PER_CALL
        }
    }

    /// Gets the right query result flags for the current parameters.
    fn get_query_result_flags(&self) -> vk::QueryResultFlags {
        let mut flags = vk::QueryResultFlags::empty();
        if self.use_64_bits {
            flags |= vk::QueryResultFlags::_64;
        }
        if self.availability_bit {
            flags |= vk::QueryResultFlags::WITH_AVAILABILITY;
        }
        flags |= if self.wait_bit {
            vk::QueryResultFlags::WAIT
        } else {
            vk::QueryResultFlags::PARTIAL
        };
        flags
    }

    /// Queries will be inherited if they are started outside of a render pass and using secondary command buffers.
    /// - If secondary command buffers are not used, nothing will be inherited.
    /// - If secondary command buffers are used but queries start inside of a render pass, queries will run entirely inside the secondary command buffer.
    fn are_queries_inherited(&self) -> bool {
        self.use_secondary && !self.inside_render_pass
    }

    fn has_query_type(&self, query_type: QueryType) -> bool {
        self.query_types.contains(&query_type)
    }

    fn has_primitives_query(&self) -> bool {
        self.has_query_type(QueryType::Primitives)
    }

    fn has_mesh_inv_stat(&self) -> bool {
        self.has_query_type(QueryType::MeshInvocations)
    }

    fn has_task_inv_stat(&self) -> bool {
        self.has_query_type(QueryType::TaskInvocations)
    }

    fn get_view_count(&self) -> u32 {
        if self.multi_view { 2 } else { 1 }
    }

    fn get_query_sizes_and_offsets(&self) -> QuerySizesAndOffsets {
        let extra_query_items: vk::DeviceSize = if self.availability_bit { 1 } else { 0 };
        let view_multiplier = vk::DeviceSize::from(self.get_view_count());

        let query_item_size = if self.use_64_bits { K64_SZ } else { K32_SZ };
        let primitives_query_size = (extra_query_items + 1) * query_item_size;
        let stats_query_size = (extra_query_items
            + vk::DeviceSize::from(self.has_task_inv_stat())
            + vk::DeviceSize::from(self.has_mesh_inv_stat()))
            * query_item_size;
        let stats_query_offset = if self.has_primitives_query() {
            primitives_query_size * view_multiplier
        } else {
            0
        };

        QuerySizesAndOffsets {
            query_item_size,
            primitives_query_size,
            stats_query_size,
            stats_query_offset,
        }
    }

    /// The position of the 2 in the mesh task counts the task shader emits: `rnd.shuffle({2, 1, 1})` on the case seed.
    fn task_shuffle_position(&self) -> u32 {
        let mut mesh_task_count = [MESH_WORK_GROUPS_PER_TASK, 1, 1];
        let mut rnd = Random::new(self.random_seed);
        rnd.shuffle(&mut mesh_task_count);
        mesh_task_count
            .iter()
            .position(|&count| count == 2)
            .expect("the 2 stays in the array") as u32
    }
}

struct MeshQueryCase {
    name: String,
    params: TestParams,
}

impl TestCase for MeshQueryCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `MeshQueryCase::checkSupport`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let params = &self.params;
        check_task_mesh_shader_support_ext(context, params.use_task_shader, true)?;

        let mesh_features = mesh_shader_features(context);

        if !params.query_types.is_empty() && mesh_features.mesh_shader_queries == vk::FALSE {
            return Err(TestError::NotSupported("meshShaderQueries not supported".to_string()));
        }

        if params.are_queries_inherited() && context.get_device_features().inherited_queries == vk::FALSE {
            return Err(TestError::NotSupported(
                "Requested core feature is not supported: inheritedQueries".to_string(),
            ));
        }

        if params.reset_type == ResetCase::NoneWithHost {
            context.require_device_functionality("VK_EXT_host_query_reset")?;
        }

        if params.multi_view {
            if mesh_features.multiview_mesh_shader == vk::FALSE {
                return Err(TestError::NotSupported("multiviewMeshShader not supported".to_string()));
            }

            if mesh_shader_properties(context).max_mesh_multiview_view_count < params.get_view_count() {
                return Err(TestError::NotSupported("maxMeshMultiviewViewCount too low".to_string()));
            }
        }

        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        let params = &self.params;
        let shuffle = if params.use_task_shader {
            params.task_shuffle_position()
        } else {
            0
        };
        match (
            params.geometry,
            params.use_task_shader,
            params.get_image_height(),
            shuffle,
            params.multi_view,
        ) {
            (GeometryType::Points, false, 0, 0, false) => QUERY_POINTS_NOTASK_H0_MV0.programs,
            (GeometryType::Points, false, 0, 0, true) => QUERY_POINTS_NOTASK_H0_MV1.programs,
            (GeometryType::Points, true, 0, 0, false) => QUERY_POINTS_TASK_T0_H0_MV0.programs,
            (GeometryType::Points, true, 0, 1, false) => QUERY_POINTS_TASK_T1_H0_MV0.programs,
            (GeometryType::Points, true, 0, 2, false) => QUERY_POINTS_TASK_T2_H0_MV0.programs,
            (GeometryType::Points, true, 0, 0, true) => QUERY_POINTS_TASK_T0_H0_MV1.programs,
            (GeometryType::Points, true, 0, 1, true) => QUERY_POINTS_TASK_T1_H0_MV1.programs,
            (GeometryType::Points, true, 0, 2, true) => QUERY_POINTS_TASK_T2_H0_MV1.programs,
            (GeometryType::Points, false, 40, 0, false) => QUERY_POINTS_NOTASK_H40_MV0.programs,
            (GeometryType::Points, false, 40, 0, true) => QUERY_POINTS_NOTASK_H40_MV1.programs,
            (GeometryType::Points, true, 40, 0, false) => QUERY_POINTS_TASK_T0_H40_MV0.programs,
            (GeometryType::Points, true, 40, 1, false) => QUERY_POINTS_TASK_T1_H40_MV0.programs,
            (GeometryType::Points, true, 40, 2, false) => QUERY_POINTS_TASK_T2_H40_MV0.programs,
            (GeometryType::Points, true, 40, 0, true) => QUERY_POINTS_TASK_T0_H40_MV1.programs,
            (GeometryType::Points, true, 40, 1, true) => QUERY_POINTS_TASK_T1_H40_MV1.programs,
            (GeometryType::Points, true, 40, 2, true) => QUERY_POINTS_TASK_T2_H40_MV1.programs,
            (GeometryType::Points, false, 240, 0, false) => QUERY_POINTS_NOTASK_H240_MV0.programs,
            (GeometryType::Points, false, 240, 0, true) => QUERY_POINTS_NOTASK_H240_MV1.programs,
            (GeometryType::Points, true, 240, 0, false) => QUERY_POINTS_TASK_T0_H240_MV0.programs,
            (GeometryType::Points, true, 240, 1, false) => QUERY_POINTS_TASK_T1_H240_MV0.programs,
            (GeometryType::Points, true, 240, 2, false) => QUERY_POINTS_TASK_T2_H240_MV0.programs,
            (GeometryType::Points, true, 240, 0, true) => QUERY_POINTS_TASK_T0_H240_MV1.programs,
            (GeometryType::Points, true, 240, 1, true) => QUERY_POINTS_TASK_T1_H240_MV1.programs,
            (GeometryType::Points, true, 240, 2, true) => QUERY_POINTS_TASK_T2_H240_MV1.programs,
            (GeometryType::Lines, false, 0, 0, false) => QUERY_LINES_NOTASK_H0_MV0.programs,
            (GeometryType::Lines, false, 0, 0, true) => QUERY_LINES_NOTASK_H0_MV1.programs,
            (GeometryType::Lines, true, 0, 0, false) => QUERY_LINES_TASK_T0_H0_MV0.programs,
            (GeometryType::Lines, true, 0, 1, false) => QUERY_LINES_TASK_T1_H0_MV0.programs,
            (GeometryType::Lines, true, 0, 2, false) => QUERY_LINES_TASK_T2_H0_MV0.programs,
            (GeometryType::Lines, true, 0, 0, true) => QUERY_LINES_TASK_T0_H0_MV1.programs,
            (GeometryType::Lines, true, 0, 1, true) => QUERY_LINES_TASK_T1_H0_MV1.programs,
            (GeometryType::Lines, true, 0, 2, true) => QUERY_LINES_TASK_T2_H0_MV1.programs,
            (GeometryType::Lines, false, 40, 0, false) => QUERY_LINES_NOTASK_H40_MV0.programs,
            (GeometryType::Lines, false, 40, 0, true) => QUERY_LINES_NOTASK_H40_MV1.programs,
            (GeometryType::Lines, true, 40, 0, false) => QUERY_LINES_TASK_T0_H40_MV0.programs,
            (GeometryType::Lines, true, 40, 1, false) => QUERY_LINES_TASK_T1_H40_MV0.programs,
            (GeometryType::Lines, true, 40, 2, false) => QUERY_LINES_TASK_T2_H40_MV0.programs,
            (GeometryType::Lines, true, 40, 0, true) => QUERY_LINES_TASK_T0_H40_MV1.programs,
            (GeometryType::Lines, true, 40, 1, true) => QUERY_LINES_TASK_T1_H40_MV1.programs,
            (GeometryType::Lines, true, 40, 2, true) => QUERY_LINES_TASK_T2_H40_MV1.programs,
            (GeometryType::Lines, false, 240, 0, false) => QUERY_LINES_NOTASK_H240_MV0.programs,
            (GeometryType::Lines, false, 240, 0, true) => QUERY_LINES_NOTASK_H240_MV1.programs,
            (GeometryType::Lines, true, 240, 0, false) => QUERY_LINES_TASK_T0_H240_MV0.programs,
            (GeometryType::Lines, true, 240, 1, false) => QUERY_LINES_TASK_T1_H240_MV0.programs,
            (GeometryType::Lines, true, 240, 2, false) => QUERY_LINES_TASK_T2_H240_MV0.programs,
            (GeometryType::Lines, true, 240, 0, true) => QUERY_LINES_TASK_T0_H240_MV1.programs,
            (GeometryType::Lines, true, 240, 1, true) => QUERY_LINES_TASK_T1_H240_MV1.programs,
            (GeometryType::Lines, true, 240, 2, true) => QUERY_LINES_TASK_T2_H240_MV1.programs,
            (GeometryType::Triangles, false, 0, 0, false) => QUERY_TRIANGLES_NOTASK_H0_MV0.programs,
            (GeometryType::Triangles, false, 0, 0, true) => QUERY_TRIANGLES_NOTASK_H0_MV1.programs,
            (GeometryType::Triangles, true, 0, 0, false) => QUERY_TRIANGLES_TASK_T0_H0_MV0.programs,
            (GeometryType::Triangles, true, 0, 1, false) => QUERY_TRIANGLES_TASK_T1_H0_MV0.programs,
            (GeometryType::Triangles, true, 0, 2, false) => QUERY_TRIANGLES_TASK_T2_H0_MV0.programs,
            (GeometryType::Triangles, true, 0, 0, true) => QUERY_TRIANGLES_TASK_T0_H0_MV1.programs,
            (GeometryType::Triangles, true, 0, 1, true) => QUERY_TRIANGLES_TASK_T1_H0_MV1.programs,
            (GeometryType::Triangles, true, 0, 2, true) => QUERY_TRIANGLES_TASK_T2_H0_MV1.programs,
            (GeometryType::Triangles, false, 40, 0, false) => QUERY_TRIANGLES_NOTASK_H40_MV0.programs,
            (GeometryType::Triangles, false, 40, 0, true) => QUERY_TRIANGLES_NOTASK_H40_MV1.programs,
            (GeometryType::Triangles, true, 40, 0, false) => QUERY_TRIANGLES_TASK_T0_H40_MV0.programs,
            (GeometryType::Triangles, true, 40, 1, false) => QUERY_TRIANGLES_TASK_T1_H40_MV0.programs,
            (GeometryType::Triangles, true, 40, 2, false) => QUERY_TRIANGLES_TASK_T2_H40_MV0.programs,
            (GeometryType::Triangles, true, 40, 0, true) => QUERY_TRIANGLES_TASK_T0_H40_MV1.programs,
            (GeometryType::Triangles, true, 40, 1, true) => QUERY_TRIANGLES_TASK_T1_H40_MV1.programs,
            (GeometryType::Triangles, true, 40, 2, true) => QUERY_TRIANGLES_TASK_T2_H40_MV1.programs,
            (GeometryType::Triangles, false, 240, 0, false) => QUERY_TRIANGLES_NOTASK_H240_MV0.programs,
            (GeometryType::Triangles, false, 240, 0, true) => QUERY_TRIANGLES_NOTASK_H240_MV1.programs,
            (GeometryType::Triangles, true, 240, 0, false) => QUERY_TRIANGLES_TASK_T0_H240_MV0.programs,
            (GeometryType::Triangles, true, 240, 1, false) => QUERY_TRIANGLES_TASK_T1_H240_MV0.programs,
            (GeometryType::Triangles, true, 240, 2, false) => QUERY_TRIANGLES_TASK_T2_H240_MV0.programs,
            (GeometryType::Triangles, true, 240, 0, true) => QUERY_TRIANGLES_TASK_T0_H240_MV1.programs,
            (GeometryType::Triangles, true, 240, 1, true) => QUERY_TRIANGLES_TASK_T1_H240_MV1.programs,
            (GeometryType::Triangles, true, 240, 2, true) => QUERY_TRIANGLES_TASK_T2_H240_MV1.programs,
            _ => unreachable!("every geometry, task, height, shuffle and multiview combination has a program set"),
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(MeshQueryInstance {
            context,
            params: self.params.clone(),
        })
    }
}

struct MeshQueryInstance<'a> {
    context: &'a Context<'a>,
    params: TestParams,
}

/// `MeshQueryInstance::getRandomShuffle`
fn get_random_shuffle(rnd: &mut Random, group_count: u32) -> vk::DrawMeshTasksIndirectCommandEXT {
    let mut counts = [group_count, 1, 1];
    rnd.shuffle(&mut counts);
    vk::DrawMeshTasksIndirectCommandEXT {
        group_count_x: counts[0],
        group_count_y: counts[1],
        group_count_z: counts[2],
    }
}

/// `checkGetQueryRes`
fn check_get_query_res(result: vk::SuccessCode, allow_not_ready: bool) -> Result<(), TestError> {
    if result == vk::SuccessCode::SUCCESS || (result == vk::SuccessCode::NOT_READY && allow_not_ready) {
        return Ok(());
    }
    Err(TestError::Fail(format!("{result:?}")))
}

/// `readFromPtrAndAdvance`: reads a query item as a u64 whatever its size and advances the position.
fn read_from_ptr_and_advance(bytes: &[u8], pos: &mut usize, item_size: vk::DeviceSize) -> u64 {
    let size = item_size as usize;
    let item = &bytes[*pos..*pos + size];
    let result = if item_size == K64_SZ {
        u64::from_ne_bytes(item.try_into().expect("eight bytes"))
    } else {
        debug_assert!(item_size == K32_SZ);
        u64::from(u32::from_ne_bytes(item.try_into().expect("four bytes")))
    };
    *pos += size;
    result
}

/// `readAndVerifyAvailabilityBit`: general procedure to verify correctness of the availability bit, which does not depend on the exact query.
fn read_and_verify_availability_bit(
    bytes: &[u8],
    pos: &mut usize,
    item_size: vk::DeviceSize,
    params: &TestParams,
    query_name: &str,
) -> Result<(), TestError> {
    let availability_bit_val = read_from_ptr_and_advance(bytes, pos, item_size);

    if params.reset_type == ResetCase::BeforeAccess {
        if availability_bit_val != 0 {
            return Err(TestError::Fail(format!(
                "{query_name} availability bit expected to be zero due to reset before access, but found {availability_bit_val}"
            )));
        }
    } else if params.wait_bit && availability_bit_val == 0 {
        return Err(TestError::Fail(format!(
            "{query_name} availability expected to be true due to wait bit and not previous reset, but found {availability_bit_val}"
        )));
    }
    Ok(())
}

/// `verifyQueryCounter`: verifies a query counter has the right value given the test parameters. The actual range of valid values is
/// adjusted depending on the test parameters (wait bit, reset, etc).
fn verify_query_counter(
    read_val: u64,
    expected_min_val: u64,
    expected_max_val: u64,
    params: &TestParams,
    query_name: &str,
) -> Result<(), TestError> {
    let mut min_val = expected_min_val;

    // Resetting a query via vkCmdResetQueryPool or vkResetQueryPool sets the status to unavailable and makes the numerical results undefined.
    let was_reset = params.reset_type == ResetCase::BeforeAccess;

    if !was_reset {
        if !params.wait_bit {
            min_val = 0;
        }

        if read_val < min_val || read_val > expected_max_val {
            return Err(TestError::Fail(format!(
                "{query_name} not in expected range: {read_val} out of [{min_val}, {expected_max_val}]"
            )));
        }
    }
    Ok(())
}

impl TestInstance for MeshQueryInstance<'_> {
    /// `MeshQueryInstance::iterate`
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let params = &self.params;
        let device = context.get_device();
        let alloc = context.get_default_allocator();
        let queue = context.get_universal_queue();
        let mut rnd = Random::new(params.random_seed + 1);

        let color_format = vk::Format::R8G8B8A8_UNORM;
        let image_height = params.get_image_height();
        let color_extent = vk::Extent3D {
            width: IMAGE_WIDTH,
            height: image_height.max(1),
            depth: 1,
        };
        let view_count = params.get_view_count();
        let expected_prims = u64::from(image_height * IMAGE_WIDTH);
        let expected_task_inv = u64::from(if params.use_task_shader {
            image_height * TASK_LOCAL_INVOCATIONS / 2
        } else {
            0
        });
        let expected_mesh_inv = u64::from(image_height * MESH_LOCAL_INVOCATIONS);
        let image_view_type = if view_count > 1 {
            vk::ImageViewType::_2D_ARRAY
        } else {
            vk::ImageViewType::_2D
        };

        // Color buffer.
        let color_buffer_create_info = vk::ImageCreateInfo::builder()
            .image_type(vk::ImageType::_2D)
            .format(color_format)
            .extent(color_extent)
            .mip_levels(1)
            .array_layers(view_count)
            .samples(vk::SampleCountFlags::_1)
            .tiling(vk::ImageTiling::OPTIMAL)
            .usage(vk::ImageUsageFlags::COLOR_ATTACHMENT | vk::ImageUsageFlags::TRANSFER_SRC)
            .sharing_mode(vk::SharingMode::EXCLUSIVE)
            .initial_layout(vk::ImageLayout::UNDEFINED)
            .build();
        let color_buffer = ImageWithMemory::new(device, alloc, color_buffer_create_info, MemoryRequirement::ANY)?;
        let color_srr = make_image_subresource_range(vk::ImageAspectFlags::COLOR, 0, 1, 0, view_count);
        let color_srl = make_image_subresource_layers(vk::ImageAspectFlags::COLOR, 0, 0, view_count);
        let color_view = make_image_view(device, color_buffer.get(), image_view_type, color_format, color_srr)?;

        // Verification buffer.
        let verif_buffer_size = vk::DeviceSize::from(color_extent.width * color_extent.height * view_count) * 4;
        let verif_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(verif_buffer_size, vk::BufferUsageFlags::TRANSFER_DST),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Shader modules.
        let binaries = context.get_binary_collection();
        let task_module = if binaries.contains("task") {
            Some(create_shader_module(device, binaries.get("task")?)?)
        } else {
            None
        };
        let mesh_module = create_shader_module(device, binaries.get("mesh")?)?;
        let frag_module = create_shader_module(device, binaries.get("frag")?)?;

        // Pipeline layout.
        let pc_size = std::mem::size_of::<u32>() as u32;
        let pc_ranges = [vk::PushConstantRange {
            stage_flags: vk::ShaderStageFlags::MESH_EXT,
            offset: 0,
            size: pc_size,
        }];
        let layout_info = vk::PipelineLayoutCreateInfo::builder().push_constant_ranges(&pc_ranges);
        let pipeline_layout = Unique::new(
            device,
            unsafe { device.create_pipeline_layout(&layout_info, None) }.vk_check("vkCreatePipelineLayout")?,
        );

        // Render pass (`makeCustomRenderPass`), framebuffer, viewports, scissors.
        let view_mask = if params.multi_view { (1u32 << view_count) - 1 } else { 0 };
        let view_masks = [view_mask];
        let correlation_masks: &[u32] = if params.multi_view { &view_masks } else { &[] };
        let mut multiview_create_info = vk::RenderPassMultiviewCreateInfo::builder()
            .view_masks(&view_masks)
            .correlation_masks(correlation_masks);
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
        let render_pass_info = vk::RenderPassCreateInfo::builder()
            .attachments(&attachments)
            .subpasses(&subpasses)
            .push_next(&mut multiview_create_info);
        let render_pass = Unique::new(
            device,
            unsafe { device.create_render_pass(&render_pass_info, None) }.vk_check("vkCreateRenderPass")?,
        );
        let framebuffer = make_framebuffer(
            device,
            *render_pass,
            &[*color_view],
            color_extent.width,
            color_extent.height,
            1,
        )?;

        let mut stages = Vec::new();
        if let Some(task) = &task_module {
            stages.push((vk::ShaderStageFlags::TASK_EXT, **task));
        }
        stages.push((vk::ShaderStageFlags::MESH_EXT, *mesh_module));
        stages.push((vk::ShaderStageFlags::FRAGMENT, *frag_module));
        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::TRIANGLE_LIST)
            .with_full_viewport(color_extent.width, color_extent.height);
        state.rasterization.depth_bias_enable = vk::FALSE;
        let pipeline = create_draw_pipeline(device, *pipeline_layout, *render_pass, &stages, &state)?;

        // Command pool and buffers.
        let cmd_pool = make_command_pool(device, context.get_universal_queue_family_index())?;
        let cmd_buffer_ptr = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let reset_cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;
        let cmd_buffer = *cmd_buffer_ptr;
        let raw_pipeline = pipeline.get();
        let raw_pipe_layout = pipeline_layout.get();

        let sec_cmd_buffer_ptr = if params.use_secondary {
            Some(allocate_command_buffer(
                device,
                *cmd_pool,
                vk::CommandBufferLevel::SECONDARY,
            )?)
        } else {
            None
        };
        let sec_cmd_buffer = sec_cmd_buffer_ptr
            .as_ref()
            .map_or(vk::CommandBuffer::null(), |buffer| **buffer);

        // Create the query pools that we need.
        let has_primitives_query = params.has_primitives_query();
        let has_mesh_inv_stat = params.has_mesh_inv_stat();
        let has_task_inv_stat = params.has_task_inv_stat();
        let has_stats_query = has_mesh_inv_stat || has_task_inv_stat;

        let mut all_query_pools: Vec<vk::QueryPool> = Vec::new();

        let primitives_query_pool = if has_primitives_query {
            let info = vk::QueryPoolCreateInfo::builder()
                .query_type(vk::QueryType::MESH_PRIMITIVES_GENERATED_EXT)
                .query_count(view_count);
            let pool = Unique::new(
                device,
                unsafe { device.create_query_pool(&info, None) }.vk_check("vkCreateQueryPool")?,
            );
            all_query_pools.push(pool.get());
            Some(pool)
        } else {
            None
        };

        let mut stat_query_flags = vk::QueryPipelineStatisticFlags::empty();
        if has_mesh_inv_stat {
            stat_query_flags |= vk::QueryPipelineStatisticFlags::MESH_SHADER_INVOCATIONS_EXT;
        }
        if has_task_inv_stat {
            stat_query_flags |= vk::QueryPipelineStatisticFlags::TASK_SHADER_INVOCATIONS_EXT;
        }

        let stats_query_pool = if has_stats_query {
            let info = vk::QueryPoolCreateInfo::builder()
                .query_type(vk::QueryType::PIPELINE_STATISTICS)
                .query_count(view_count)
                .pipeline_statistics(stat_query_flags);
            let pool = Unique::new(
                device,
                unsafe { device.create_query_pool(&info, None) }.vk_check("vkCreateQueryPool")?,
            );
            all_query_pools.push(pool.get());
            Some(pool)
        } else {
            None
        };

        // Some query result parameters. 10 items at most: (prim+avail+task+mesh+avail)*2.
        let query_sizes_and_offsets = params.get_query_sizes_and_offsets();
        let max_result_size = (K64_SZ * 10) as usize;
        let stats_query_offset = query_sizes_and_offsets.stats_query_offset as usize;

        // Create output buffer for the queries.
        let query_results_buffer = if params.access == AccessMethod::Copy {
            Some(BufferWithMemory::new(
                device,
                alloc,
                make_buffer_create_info(max_result_size as vk::DeviceSize, vk::BufferUsageFlags::TRANSFER_DST),
                MemoryRequirement::HOST_VISIBLE,
            )?)
        } else {
            None
        };
        let mut query_results_host_vec = vec![0u8; max_result_size];

        // Result flags when obtaining query results.
        let query_result_flags = params.get_query_result_flags();

        // Reset queries before use, in a separate command buffer to make sure they are always properly reset before use.
        let reset_first_queries = |cmd: vk::CommandBuffer, query_count: u32| {
            for pool in &all_query_pools {
                unsafe { device.cmd_reset_query_pool(cmd, *pool, 0, query_count) };
            }
        };
        {
            begin_command_buffer(device, *reset_cmd_buffer)?;
            reset_first_queries(*reset_cmd_buffer, view_count);
            end_command_buffer(device, *reset_cmd_buffer)?;
            submit_commands_and_wait(device, queue, *reset_cmd_buffer)?;
        }

        // Indirect and indirect count buffers, which have to outlive the submission.
        let mut indirect_buffer: Option<BufferWithMemory<'_>> = None;
        let mut indirect_count_buffer: Option<BufferWithMemory<'_>> = None;

        // `recordDraws`
        let mut record_draws = |cmd: vk::CommandBuffer| -> Result<(), TestError> {
            let draw_group_count = params.get_draw_group_count();
            let pc_bytes = |value: u32| value.to_ne_bytes();

            unsafe { device.cmd_bind_pipeline(cmd, vk::PipelineBindPoint::GRAPHICS, raw_pipeline) };

            match params.draw_call {
                DrawCallType::Direct => {
                    let mut total_draw_calls = 0u32;
                    for &block_size in &params.draw_blocks {
                        for _ in 0..block_size {
                            let counts = get_random_shuffle(&mut rnd, draw_group_count);
                            unsafe {
                                device.cmd_push_constants(
                                    cmd,
                                    raw_pipe_layout,
                                    vk::ShaderStageFlags::MESH_EXT,
                                    0,
                                    &pc_bytes(total_draw_calls),
                                );
                                device.cmd_draw_mesh_tasks_ext(
                                    cmd,
                                    counts.group_count_x,
                                    counts.group_count_y,
                                    counts.group_count_z,
                                );
                            }
                            total_draw_calls += 1;
                        }
                    }
                }
                DrawCallType::Indirect | DrawCallType::IndirectWithCount => {
                    if params.draw_blocks.is_empty() {
                        return Ok(());
                    }

                    let total_draw_count = params.get_total_draw_count();
                    let cmd_size = std::mem::size_of::<vk::DrawMeshTasksIndirectCommandEXT>() as u32;

                    let indirect_commands: Vec<vk::DrawMeshTasksIndirectCommandEXT> = (0..total_draw_count)
                        .map(|_| get_random_shuffle(&mut rnd, draw_group_count))
                        .collect();

                    // Copy the array to a host-visible buffer. All indirect buffers are allocated with a non-zero size by adding cmdSize to the
                    // expected size, and the size of the buffer must be greater than stride * (maxDrawCount - 1) + offset +
                    // sizeof(VkDrawMeshTasksIndirectCommandEXT), so it is multiplied by 2.
                    let indirect_buffer_size = std::mem::size_of_val(indirect_commands.as_slice());
                    let buffer = BufferWithMemory::new(
                        device,
                        alloc,
                        make_buffer_create_info(
                            ((indirect_buffer_size + cmd_size as usize) * 2) as vk::DeviceSize,
                            vk::BufferUsageFlags::INDIRECT_BUFFER,
                        ),
                        MemoryRequirement::HOST_VISIBLE,
                    )?;
                    unsafe {
                        std::ptr::copy_nonoverlapping(
                            indirect_commands.as_ptr().cast::<u8>(),
                            buffer.get_allocation().get_host_ptr(),
                            indirect_buffer_size,
                        )
                    };
                    flush_alloc(device, buffer.get_allocation())?;
                    let indirect_handle = buffer.get();
                    indirect_buffer = Some(buffer);

                    if params.draw_call == DrawCallType::Indirect {
                        let mut accumulated_count = 0u32;

                        for &block_size in &params.draw_blocks {
                            let offset = vk::DeviceSize::from(cmd_size * accumulated_count);
                            unsafe {
                                device.cmd_push_constants(
                                    cmd,
                                    raw_pipe_layout,
                                    vk::ShaderStageFlags::MESH_EXT,
                                    0,
                                    &pc_bytes(accumulated_count),
                                );
                                device.cmd_draw_mesh_tasks_indirect_ext(
                                    cmd,
                                    indirect_handle,
                                    offset,
                                    block_size,
                                    cmd_size,
                                );
                            }
                            accumulated_count += block_size;
                        }
                    } else {
                        // Copy the "block sizes" to a host-visible buffer.
                        let indirect_count_buffer_size = std::mem::size_of_val(params.draw_blocks.as_slice());
                        let count_buffer = BufferWithMemory::new(
                            device,
                            alloc,
                            make_buffer_create_info(
                                (indirect_count_buffer_size + cmd_size as usize) as vk::DeviceSize,
                                vk::BufferUsageFlags::INDIRECT_BUFFER,
                            ),
                            MemoryRequirement::HOST_VISIBLE,
                        )?;
                        unsafe {
                            std::ptr::copy_nonoverlapping(
                                params.draw_blocks.as_ptr().cast::<u8>(),
                                count_buffer.get_allocation().get_host_ptr(),
                                indirect_count_buffer_size,
                            )
                        };
                        flush_alloc(device, count_buffer.get_allocation())?;
                        let count_handle = count_buffer.get();
                        indirect_count_buffer = Some(count_buffer);

                        // Record indirect draws with count.
                        let mut accumulated_count = 0u32;

                        for (count_idx, &block_size) in params.draw_blocks.iter().enumerate() {
                            let offset = vk::DeviceSize::from(cmd_size * accumulated_count);
                            let count_offset = (std::mem::size_of::<u32>() * count_idx) as vk::DeviceSize;

                            unsafe {
                                device.cmd_push_constants(
                                    cmd,
                                    raw_pipe_layout,
                                    vk::ShaderStageFlags::MESH_EXT,
                                    0,
                                    &pc_bytes(accumulated_count),
                                );
                                device.cmd_draw_mesh_tasks_indirect_count_ext(
                                    cmd,
                                    indirect_handle,
                                    offset,
                                    count_handle,
                                    count_offset,
                                    block_size * 2,
                                    cmd_size,
                                );
                            }
                            accumulated_count += block_size;
                        }
                    }
                }
            }
            Ok(())
        };

        let begin_first_queries = |cmd: vk::CommandBuffer| {
            for pool in &all_query_pools {
                unsafe { device.cmd_begin_query(cmd, *pool, 0, vk::QueryControlFlags::empty()) };
            }
        };
        let end_first_queries = |cmd: vk::CommandBuffer| {
            for pool in &all_query_pools {
                unsafe { device.cmd_end_query(cmd, *pool, 0) };
            }
        };

        let scissor = make_rect_2d(0, 0, color_extent.width, color_extent.height);
        let clear_color = [0.0f32, 0.0, 0.0, 1.0];
        let clear_values = [clear_value_color(clear_color)];
        let subpass_contents = if params.use_secondary {
            vk::SubpassContents::SECONDARY_COMMAND_BUFFERS
        } else {
            vk::SubpassContents::INLINE
        };
        let begin_render_pass = || {
            let info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(scissor)
                .clear_values(&clear_values);
            unsafe { device.cmd_begin_render_pass(cmd_buffer, &info, subpass_contents) };
        };

        // Command recording.
        begin_command_buffer(device, cmd_buffer)?;

        if params.use_secondary {
            let inheritance_info = vk::CommandBufferInheritanceInfo::builder()
                .render_pass(*render_pass)
                .subpass(0)
                .framebuffer(*framebuffer)
                .occlusion_query_enable(false)
                .pipeline_statistics(if params.are_queries_inherited() {
                    stat_query_flags
                } else {
                    vk::QueryPipelineStatisticFlags::empty()
                });
            let begin_info = vk::CommandBufferBeginInfo::builder()
                .flags(vk::CommandBufferUsageFlags::RENDER_PASS_CONTINUE | vk::CommandBufferUsageFlags::ONE_TIME_SUBMIT)
                .inheritance_info(&inheritance_info);
            unsafe { device.begin_command_buffer(sec_cmd_buffer, &begin_info) }.vk_check("vkBeginCommandBuffer")?;
        }

        // 4 cases:
        //
        // * Only primary, inside render pass
        // * Only primary, outside render pass
        // * Primary and secondary, inside render pass (query in secondary)
        // * Primary and secondary, outside render pass (query inheritance)
        if !params.use_secondary {
            if params.inside_render_pass {
                begin_render_pass();
                begin_first_queries(cmd_buffer);
                record_draws(cmd_buffer)?;
                end_first_queries(cmd_buffer);
                unsafe { device.cmd_end_render_pass(cmd_buffer) };
            } else {
                debug_assert!(!params.multi_view);
                begin_first_queries(cmd_buffer);
                begin_render_pass();
                record_draws(cmd_buffer)?;
                unsafe { device.cmd_end_render_pass(cmd_buffer) };
                end_first_queries(cmd_buffer);
            }
        } else if params.inside_render_pass {
            // Queries in secondary command buffer.
            begin_render_pass();
            begin_first_queries(sec_cmd_buffer);
            record_draws(sec_cmd_buffer)?;
            end_first_queries(sec_cmd_buffer);
            end_command_buffer(device, sec_cmd_buffer)?;
            unsafe {
                device.cmd_execute_commands(cmd_buffer, &[sec_cmd_buffer]);
                device.cmd_end_render_pass(cmd_buffer);
            }
        } else {
            // Inherited queries case.
            debug_assert!(!params.multi_view);
            begin_first_queries(cmd_buffer);
            begin_render_pass();
            record_draws(sec_cmd_buffer)?;
            end_command_buffer(device, sec_cmd_buffer)?;
            unsafe {
                device.cmd_execute_commands(cmd_buffer, &[sec_cmd_buffer]);
                device.cmd_end_render_pass(cmd_buffer);
            }
            end_first_queries(cmd_buffer);
        }

        // Render to copy barrier.
        {
            let pre_copy_img_barrier = make_image_memory_barrier(
                vk::AccessFlags::COLOR_ATTACHMENT_WRITE,
                vk::AccessFlags::TRANSFER_READ,
                vk::ImageLayout::COLOR_ATTACHMENT_OPTIMAL,
                vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                color_buffer.get(),
                color_srr,
            );
            unsafe {
                device.cmd_pipeline_barrier(
                    cmd_buffer,
                    vk::PipelineStageFlags::COLOR_ATTACHMENT_OUTPUT,
                    vk::PipelineStageFlags::TRANSFER,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[] as &[vk::BufferMemoryBarrier],
                    &[pre_copy_img_barrier],
                );
            }
        }

        if params.reset_type == ResetCase::BeforeAccess {
            reset_first_queries(cmd_buffer, view_count);
        }

        if params.access == AccessMethod::Copy {
            let results_buffer = query_results_buffer
                .as_ref()
                .expect("the copy access has a results buffer")
                .get();

            if let Some(pool) = &primitives_query_pool {
                unsafe {
                    device.cmd_copy_query_pool_results(
                        cmd_buffer,
                        pool.get(),
                        0,
                        view_count,
                        results_buffer,
                        0,
                        query_sizes_and_offsets.primitives_query_size,
                        query_result_flags,
                    )
                };
            }

            if let Some(pool) = &stats_query_pool {
                unsafe {
                    device.cmd_copy_query_pool_results(
                        cmd_buffer,
                        pool.get(),
                        0,
                        view_count,
                        results_buffer,
                        query_sizes_and_offsets.stats_query_offset,
                        query_sizes_and_offsets.stats_query_size,
                        query_result_flags,
                    )
                };
            }
        }

        if params.reset_type == ResetCase::AfterAccess {
            reset_first_queries(cmd_buffer, view_count);
        }

        // Copy color attachment to verification buffer.
        {
            let copy_region = make_buffer_image_copy(color_extent, color_srl);
            unsafe {
                device.cmd_copy_image_to_buffer(
                    cmd_buffer,
                    color_buffer.get(),
                    vk::ImageLayout::TRANSFER_SRC_OPTIMAL,
                    verif_buffer.get(),
                    &[copy_region],
                )
            };
        }

        // This barrier applies to both the color verification buffer and the queries if they were copied.
        let post_copy_barrier = make_memory_barrier(vk::AccessFlags::TRANSFER_WRITE, vk::AccessFlags::HOST_READ);
        unsafe {
            device.cmd_pipeline_barrier(
                cmd_buffer,
                vk::PipelineStageFlags::TRANSFER,
                vk::PipelineStageFlags::HOST,
                vk::DependencyFlags::empty(),
                &[post_copy_barrier],
                &[] as &[vk::BufferMemoryBarrier],
                &[] as &[vk::ImageMemoryBarrier],
            );
        }

        end_command_buffer(device, cmd_buffer)?;

        // `submitCommands`
        let fence = Unique::new(
            device,
            unsafe { device.create_fence(&vk::FenceCreateInfo::default(), None) }.vk_check("vkCreateFence")?,
        );
        let command_buffers = [cmd_buffer];
        let submit_info = vk::SubmitInfo::builder().command_buffers(&command_buffers);
        unsafe { device.queue_submit(queue, &[submit_info], fence.get()) }.vk_check("vkQueueSubmit")?;
        let wait_for_fence = || {
            unsafe { device.wait_for_fences(&[fence.get()], true, u64::MAX) }
                .vk_check("vkWaitForFences")
                .map(|_| ())
        };

        // When using GET, obtain results before actually waiting for the fence if possible. This way it's more interesting for cases
        // that do not use the wait bit.
        if params.access == AccessMethod::Get {
            // When resetting queries before access, we need to make sure the reset operation has really taken place.
            if params.reset_type == ResetCase::BeforeAccess {
                wait_for_fence()?;
            }

            let allow_not_ready = !params.wait_bit;

            if let Some(pool) = &primitives_query_pool {
                let res = unsafe {
                    device.get_query_pool_results(
                        pool.get(),
                        0,
                        view_count,
                        &mut query_results_host_vec[..],
                        query_sizes_and_offsets.primitives_query_size,
                        query_result_flags,
                    )
                }
                .vk_check("vkGetQueryPoolResults")?;
                check_get_query_res(res, allow_not_ready)?;
            }

            if let Some(pool) = &stats_query_pool {
                let res = unsafe {
                    device.get_query_pool_results(
                        pool.get(),
                        0,
                        view_count,
                        &mut query_results_host_vec[stats_query_offset..],
                        query_sizes_and_offsets.stats_query_size,
                        query_result_flags,
                    )
                }
                .vk_check("vkGetQueryPoolResults")?;
                check_get_query_res(res, allow_not_ready)?;
            }
        }

        wait_for_fence()?;

        // Verify color buffer. The results should be exact.
        {
            let verif_alloc = verif_buffer.get_allocation();
            invalidate_alloc(device, verif_alloc)?;
            let verif_data = unsafe {
                std::slice::from_raw_parts(verif_alloc.get_host_ptr().cast_const(), verif_buffer_size as usize)
            };
            let layer_size = (color_extent.width * color_extent.height * 4) as usize;

            for layer in 0..view_count as usize {
                // This should match the fragment shader.
                let green = if layer > 0 { 255u8 } else { 0u8 };
                let reference_color = if params.get_total_draw_count() > 0 {
                    [0u8, green, 255, 255]
                } else {
                    [0u8, 0, 0, 255]
                };

                if !verif_data[layer * layer_size..(layer + 1) * layer_size]
                    .chunks_exact(4)
                    .all(|pixel| pixel == reference_color)
                {
                    return Ok(TestStatus::fail(format!(
                        "Color target mismatch at layer {layer}; check log for details"
                    )));
                }
            }
        }

        // Verify query results.
        {
            let item_size = query_sizes_and_offsets.query_item_size;

            let results: Vec<u8> = if params.access == AccessMethod::Copy {
                let results_alloc = query_results_buffer
                    .as_ref()
                    .expect("the copy access has a results buffer")
                    .get_allocation();
                invalidate_alloc(device, results_alloc)?;
                unsafe { std::slice::from_raw_parts(results_alloc.get_host_ptr().cast_const(), max_result_size) }
                    .to_vec()
            } else {
                query_results_host_vec.clone()
            };
            let mut pos = 0usize;

            if has_primitives_query {
                let query_group_name = "Primitive count";
                let mut total_primitive_count = 0u64;

                for view_index in 0..view_count {
                    let query_name = format!("{query_group_name} for view {view_index}");
                    let primitive_count = read_from_ptr_and_advance(&results, &mut pos, item_size);

                    total_primitive_count += primitive_count;

                    if params.availability_bit {
                        read_and_verify_availability_bit(&results, &mut pos, item_size, params, &query_name)?;
                    }
                }

                verify_query_counter(
                    total_primitive_count,
                    expected_prims,
                    expected_prims * u64::from(view_count),
                    params,
                    query_group_name,
                )?;
            }

            if has_stats_query {
                let query_group_name = "Stats query";
                let mut total_task_invs = 0u64;
                let mut total_mesh_invs = 0u64;

                for _ in 0..view_count {
                    if has_task_inv_stat {
                        total_task_invs += read_from_ptr_and_advance(&results, &mut pos, item_size);
                    }

                    if has_mesh_inv_stat {
                        total_mesh_invs += read_from_ptr_and_advance(&results, &mut pos, item_size);
                    }

                    if params.availability_bit {
                        read_and_verify_availability_bit(&results, &mut pos, item_size, params, query_group_name)?;
                    }
                }

                if has_task_inv_stat {
                    verify_query_counter(
                        total_task_invs,
                        expected_task_inv,
                        expected_task_inv * u64::from(view_count),
                        params,
                        "Task invocations",
                    )?;
                }

                if has_mesh_inv_stat {
                    verify_query_counter(
                        total_mesh_invs,
                        expected_mesh_inv,
                        expected_mesh_inv * u64::from(view_count),
                        params,
                        "Mesh invocations",
                    )?;
                }
            }
        }

        if params.reset_type == ResetCase::NoneWithHost {
            // Reset the different queries that were used and retrieve results again with GET, forcing availability bit and no wait bit.
            // The availability bits must be zero.
            let mut pos = 0usize;

            // New parameters, based on the existing ones, that match the behavior we expect below.
            let mut post_reset_params = params.clone();
            post_reset_params.availability_bit = true;
            post_reset_params.wait_bit = false;
            post_reset_params.reset_type = ResetCase::BeforeAccess;

            let post_reset_flags = post_reset_params.get_query_result_flags();
            let new_sizes_and_offsets = post_reset_params.get_query_sizes_and_offsets();
            let new_stats_query_offset = new_sizes_and_offsets.stats_query_offset as usize;
            let item_size = new_sizes_and_offsets.query_item_size;

            if let Some(pool) = &primitives_query_pool {
                unsafe { device.reset_query_pool(pool.get(), 0, view_count) };
                let res = unsafe {
                    device.get_query_pool_results(
                        pool.get(),
                        0,
                        view_count,
                        &mut query_results_host_vec[..],
                        new_sizes_and_offsets.primitives_query_size,
                        post_reset_flags,
                    )
                }
                .vk_check("vkGetQueryPoolResults")?;
                check_get_query_res(res, true)?;
            }

            if let Some(pool) = &stats_query_pool {
                unsafe { device.reset_query_pool(pool.get(), 0, view_count) };
                let res = unsafe {
                    device.get_query_pool_results(
                        pool.get(),
                        0,
                        view_count,
                        &mut query_results_host_vec[new_stats_query_offset..],
                        new_sizes_and_offsets.stats_query_size,
                        post_reset_flags,
                    )
                }
                .vk_check("vkGetQueryPoolResults")?;
                check_get_query_res(res, true)?;
            }

            if has_primitives_query {
                for view_index in 0..view_count {
                    let query_name = format!("Post-reset primitive count for view {view_index}");
                    // Resetting a query without beginning it again makes numerical results undefined.
                    let _primitive_count = read_from_ptr_and_advance(&query_results_host_vec, &mut pos, item_size);
                    read_and_verify_availability_bit(
                        &query_results_host_vec,
                        &mut pos,
                        item_size,
                        &post_reset_params,
                        &query_name,
                    )?;
                }
            }

            if has_stats_query {
                for view_index in 0..view_count {
                    if has_task_inv_stat {
                        let _task_invs = read_from_ptr_and_advance(&query_results_host_vec, &mut pos, item_size);
                    }

                    if has_mesh_inv_stat {
                        let _mesh_invs = read_from_ptr_and_advance(&query_results_host_vec, &mut pos, item_size);
                    }

                    let query_name = format!("Post-reset stats query for view {view_index}");
                    read_and_verify_availability_bit(
                        &query_results_host_vec,
                        &mut pos,
                        item_size,
                        &post_reset_params,
                        &query_name,
                    )?;
                }
            }
        }

        // The indirect buffers were kept alive until the submission finished.
        drop((indirect_buffer, indirect_count_buffer));

        Ok(TestStatus::pass("Pass"))
    }
}

/// `createMeshShaderQueryTestsEXT`
pub fn create_mesh_shader_query_tests_ext() -> TestCaseGroup {
    let mut query_group = TestCaseGroup::new("query");

    let query_combinations: [(Vec<QueryType>, &str); 6] = [
        (vec![], "no_queries"),
        (vec![QueryType::Primitives], "prim_query"),
        (vec![QueryType::TaskInvocations], "task_invs_query"),
        (vec![QueryType::MeshInvocations], "mesh_invs_query"),
        (
            vec![QueryType::TaskInvocations, QueryType::MeshInvocations],
            "all_stats_query",
        ),
        (
            vec![
                QueryType::Primitives,
                QueryType::TaskInvocations,
                QueryType::MeshInvocations,
            ],
            "all_queries",
        ),
    ];

    let draw_calls = [
        (DrawCallType::Direct, "draw"),
        (DrawCallType::Indirect, "indirect_draw"),
        (DrawCallType::IndirectWithCount, "indirect_with_count_draw"),
    ];

    let block_cases: [(Vec<u32>, &str); 3] = [
        (vec![], "no_blocks"),
        (vec![10], "single_block"),
        (vec![10, 20, 30], "multiple_blocks"),
    ];

    let reset_types = [
        (ResetCase::None, "no_reset"),
        (ResetCase::NoneWithHost, "host_reset"),
        (ResetCase::BeforeAccess, "reset_before"),
        (ResetCase::AfterAccess, "reset_after"),
    ];

    let access_methods = [(AccessMethod::Copy, "copy"), (AccessMethod::Get, "get")];

    let geometry_cases = [
        (GeometryType::Points, "points"),
        (GeometryType::Lines, "lines"),
        (GeometryType::Triangles, "triangles"),
    ];

    let result_sizes = [(false, "32bit"), (true, "64bit")];
    let availability_cases = [(false, "no_availability"), (true, "with_availability")];
    let wait_cases = [(false, "no_wait"), (true, "wait")];
    let task_shader_cases = [(false, "mesh_only"), (true, "task_mesh")];
    let ordering_cases = [(false, "include_rp"), (true, "inside_rp")];
    let multi_view_cases = [(false, "single_view"), (true, "multi_view")];
    let cmd_buffer_types = [(false, "only_primary"), (true, "with_secondary")];

    // `getNewSeed`: the generator is used by the test case and the instance, so there are two seeds per params, and a second
    // `TestParams` is built (by the move constructor) for every case that is kept.
    let mut next_seed = 1_656_078_156u32;

    for (query_types, query_combination_name) in &query_combinations {
        let no_queries = query_types.is_empty();
        let has_primitives_query = query_types.contains(&QueryType::Primitives);

        let mut query_combination_group = TestCaseGroup::new(*query_combination_name);

        for (geometry, geometry_name) in geometry_cases {
            if no_queries && geometry != GeometryType::Lines {
                continue;
            }

            let non_triangles = geometry != GeometryType::Triangles;

            // For cases without primitive queries, skip non-triangle geometries.
            if !has_primitives_query && !no_queries && non_triangles {
                continue;
            }

            let mut geometry_case_group = TestCaseGroup::new(geometry_name);

            for (reset_type, reset_name) in reset_types {
                if no_queries && reset_type != ResetCase::None {
                    continue;
                }

                let mut reset_type_group = TestCaseGroup::new(reset_name);

                for (access_method, access_name) in access_methods {
                    if no_queries && access_method != AccessMethod::Copy {
                        continue;
                    }

                    // Get + reset after access is not a valid combination (queries will be accessed after submission).
                    if access_method == AccessMethod::Get && reset_type == ResetCase::AfterAccess {
                        continue;
                    }

                    let mut access_method_group = TestCaseGroup::new(access_name);

                    for (wait_flag, wait_name) in wait_cases {
                        if no_queries && wait_flag {
                            continue;
                        }

                        // Wait and reset before access is not valid (the query would never finish).
                        if reset_type == ResetCase::BeforeAccess && wait_flag {
                            continue;
                        }

                        let mut wait_case_group = TestCaseGroup::new(wait_name);

                        for (draw_call_type, draw_call_name) in draw_calls {
                            // Explicitly remove some combinations with non-triangles, just to reduce the number of tests.
                            if draw_call_type != DrawCallType::Direct && non_triangles {
                                continue;
                            }

                            let mut draw_call_group = TestCaseGroup::new(draw_call_name);

                            for (use_64_bits, result_size_name) in result_sizes {
                                if no_queries && use_64_bits {
                                    continue;
                                }

                                // Explicitly remove some combinations with non-triangles, just to reduce the number of tests.
                                if use_64_bits && non_triangles {
                                    continue;
                                }

                                let mut result_size_group = TestCaseGroup::new(result_size_name);

                                for (availability_flag, availability_name) in availability_cases {
                                    if no_queries && availability_flag {
                                        continue;
                                    }

                                    // Explicitly remove some combinations with non-triangles, just to reduce the number of tests.
                                    if availability_flag && non_triangles {
                                        continue;
                                    }

                                    let mut availability_case_group = TestCaseGroup::new(availability_name);

                                    for (draw_blocks, block_name) in &block_cases {
                                        // Explicitly remove some combinations with non-triangles, just to reduce the number of tests.
                                        if draw_blocks.len() <= 1 && non_triangles {
                                            continue;
                                        }

                                        let mut block_case_group = TestCaseGroup::new(*block_name);

                                        for (task_shader, task_shader_name) in task_shader_cases {
                                            let mut task_shader_case_group = TestCaseGroup::new(task_shader_name);

                                            for (inside_render_pass, ordering_name) in ordering_cases {
                                                if no_queries && !inside_render_pass {
                                                    continue;
                                                }

                                                let mut ordering_case_group = TestCaseGroup::new(ordering_name);

                                                for (multi_view, multi_view_name) in multi_view_cases {
                                                    if multi_view && !inside_render_pass {
                                                        continue;
                                                    }

                                                    let mut multi_view_group = TestCaseGroup::new(multi_view_name);

                                                    for (use_secondary, cmd_buffer_type_name) in cmd_buffer_types {
                                                        let mut params = TestParams::new(next_seed);
                                                        next_seed += 2;
                                                        params.query_types = query_types.clone();
                                                        params.draw_blocks = draw_blocks.clone();
                                                        params.draw_call = draw_call_type;
                                                        params.geometry = geometry;
                                                        params.reset_type = reset_type;
                                                        params.access = access_method;
                                                        params.use_64_bits = use_64_bits;
                                                        params.availability_bit = availability_flag;
                                                        params.wait_bit = wait_flag;
                                                        params.use_task_shader = task_shader;
                                                        params.inside_render_pass = inside_render_pass;
                                                        params.use_secondary = use_secondary;
                                                        params.multi_view = multi_view;

                                                        // VUID-vkCmdExecuteCommands-commandBuffer-07594
                                                        if params.are_queries_inherited()
                                                            && params.has_primitives_query()
                                                        {
                                                            continue;
                                                        }

                                                        next_seed += 2;
                                                        multi_view_group.add_child(Box::new(MeshQueryCase {
                                                            name: cmd_buffer_type_name.to_string(),
                                                            params,
                                                        })
                                                            as Box<dyn TestCase>);
                                                    }

                                                    ordering_case_group.add_child(multi_view_group);
                                                }

                                                task_shader_case_group.add_child(ordering_case_group);
                                            }

                                            block_case_group.add_child(task_shader_case_group);
                                        }

                                        availability_case_group.add_child(block_case_group);
                                    }

                                    result_size_group.add_child(availability_case_group);
                                }

                                draw_call_group.add_child(result_size_group);
                            }

                            wait_case_group.add_child(draw_call_group);
                        }

                        access_method_group.add_child(wait_case_group);
                    }

                    reset_type_group.add_child(access_method_group);
                }

                geometry_case_group.add_child(reset_type_group);
            }

            query_combination_group.add_child(geometry_case_group);
        }

        query_group.add_child(query_combination_group);
    }

    query_group
}
