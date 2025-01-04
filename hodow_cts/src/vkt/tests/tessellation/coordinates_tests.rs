// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationCoordinatesTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `_execution_mode_in_tesc` cases are built from SPIR-V assembly, in
// `shaders/manifest/tessellation_tesscoord_execmode.toml` (`scripts/gen_tesscoord_execmode_manifest.py`). The visualisation
// images and log lines of a failing comparison are not produced; the verdict is the same.
//
// Based on dEQP-GLES31.functional.tessellation.tesscoord.*
// \note Transform feedback is replaced with SSBO. Because of that, this version allows duplicate coordinates from shader invocations.
// The test still fails if not enough coordinates are generated, or if coordinates don't match the reference data.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_tesscoord::{
    TESSCOORD_ISOLINES_EQUAL_SPACING, TESSCOORD_ISOLINES_FRACTIONAL_EVEN_SPACING,
    TESSCOORD_ISOLINES_FRACTIONAL_ODD_SPACING, TESSCOORD_QUADS_EQUAL_SPACING, TESSCOORD_QUADS_FRACTIONAL_EVEN_SPACING,
    TESSCOORD_QUADS_FRACTIONAL_ODD_SPACING, TESSCOORD_TRIANGLES_EQUAL_SPACING,
    TESSCOORD_TRIANGLES_FRACTIONAL_EVEN_SPACING, TESSCOORD_TRIANGLES_FRACTIONAL_ODD_SPACING,
};
use crate::generated::shaders::tessellation_tesscoord_execmode::{
    TESSCOORD_ISOLINES_EQUAL_SPACING_EXECUTION_MODE_IN_TESC,
    TESSCOORD_ISOLINES_FRACTIONAL_EVEN_SPACING_EXECUTION_MODE_IN_TESC,
    TESSCOORD_ISOLINES_FRACTIONAL_ODD_SPACING_EXECUTION_MODE_IN_TESC,
    TESSCOORD_QUADS_EQUAL_SPACING_EXECUTION_MODE_IN_TESC,
    TESSCOORD_QUADS_FRACTIONAL_EVEN_SPACING_EXECUTION_MODE_IN_TESC,
    TESSCOORD_QUADS_FRACTIONAL_ODD_SPACING_EXECUTION_MODE_IN_TESC,
    TESSCOORD_TRIANGLES_EQUAL_SPACING_EXECUTION_MODE_IN_TESC,
    TESSCOORD_TRIANGLES_FRACTIONAL_EVEN_SPACING_EXECUTION_MODE_IN_TESC,
    TESSCOORD_TRIANGLES_FRACTIONAL_ODD_SPACING_EXECUTION_MODE_IN_TESC,
};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::builder_util::{
    DescriptorPoolBuilder, DescriptorSetLayoutBuilder, DescriptorSetUpdateBuilder, Location,
};
use crate::vk::cmd_util::{begin_command_buffer, end_command_buffer, submit_commands_and_wait};
use crate::vk::mem_util::{MemoryRequirement, flush_alloc, invalidate_alloc};
use crate::vk::obj_util::{
    BufferWithMemory, allocate_command_buffer, make_buffer_create_info, make_buffer_memory_barrier, make_command_pool,
    make_descriptor_set, make_framebuffer, make_pipeline_layout,
};
pub use crate::vk::programs::SharedProgram;
use crate::vk::programs::{BinaryCollection, create_shader_module};
use crate::vkt::tests::draw::util::{DrawPipelineState, create_draw_pipeline, rect_2d};
use crate::vkt::tests::tessellation::util::{
    SpacingMode, TessLevels, TessPrimitiveType, clamped_rounded_isoline_tess_levels, clamped_rounded_quad_tess_levels,
    clamped_rounded_tess_level, clamped_rounded_triangle_tess_levels, generate_reference_isoline_tess_coords,
    generate_reference_quad_tess_coords, generate_reference_triangle_tess_coords, is_patch_discarded,
    make_render_pass_without_attachments,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `getCaseName`
fn get_case_name(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    execution_mode_in_evaluation_shader: bool,
) -> String {
    format!(
        "{}_{}{}",
        primitive_type.shader_name(),
        spacing_mode.shader_name(),
        if execution_mode_in_evaluation_shader {
            ""
        } else {
            "_execution_mode_in_tesc"
        }
    )
}

/// `genTessLevelCases`
fn gen_tess_level_cases(primitive_type: TessPrimitiveType, spacing_mode: SpacingMode) -> Vec<TessLevels> {
    let raw_tess_level_cases = [
        TessLevels {
            inner: [1.0, 1.0],
            outer: [1.0, 1.0, 1.0, 1.0],
        },
        TessLevels {
            inner: [63.0, 24.0],
            outer: [15.0, 42.0, 10.0, 12.0],
        },
        TessLevels {
            inner: [3.0, 2.0],
            outer: [6.0, 8.0, 7.0, 9.0],
        },
        TessLevels {
            inner: [4.0, 6.0],
            outer: [2.0, 3.0, 1.0, 4.0],
        },
        TessLevels {
            inner: [2.0, 2.0],
            outer: [6.0, 8.0, 7.0, 9.0],
        },
        TessLevels {
            inner: [5.0, 6.0],
            outer: [1.0, 1.0, 1.0, 1.0],
        },
        TessLevels {
            inner: [1.0, 6.0],
            outer: [2.0, 3.0, 1.0, 4.0],
        },
        TessLevels {
            inner: [5.0, 1.0],
            outer: [2.0, 3.0, 1.0, 4.0],
        },
        TessLevels {
            inner: [5.2, 1.6],
            outer: [2.9, 3.4, 1.5, 4.1],
        },
    ];

    if spacing_mode == SpacingMode::Equal {
        return raw_tess_level_cases.to_vec();
    }

    let mut result = Vec::with_capacity(raw_tess_level_cases.len());

    for raw_case in raw_tess_level_cases {
        let mut cur_tess_level_case = raw_case;

        for inner in cur_tess_level_case.inner.iter_mut() {
            *inner = clamped_rounded_tess_level(spacing_mode, *inner) as f32;
        }
        for outer in cur_tess_level_case.outer.iter_mut() {
            *outer = clamped_rounded_tess_level(spacing_mode, *outer) as f32;
        }
        let outer = cur_tess_level_case.outer;

        if primitive_type == TessPrimitiveType::Triangles {
            if (outer[0] > 1.0 || outer[1] > 1.0 || outer[2] > 1.0) && cur_tess_level_case.inner[0] == 1.0 {
                cur_tess_level_case.inner[0] =
                    clamped_rounded_tess_level(spacing_mode, cur_tess_level_case.inner[0] + 0.1) as f32;
            }
        } else if primitive_type == TessPrimitiveType::Quads
            && (outer[0] > 1.0 || outer[1] > 1.0 || outer[2] > 1.0 || outer[3] > 1.0)
        {
            if cur_tess_level_case.inner[0] == 1.0 {
                cur_tess_level_case.inner[0] =
                    clamped_rounded_tess_level(spacing_mode, cur_tess_level_case.inner[0] + 0.1) as f32;
            }
            if cur_tess_level_case.inner[1] == 1.0 {
                cur_tess_level_case.inner[1] =
                    clamped_rounded_tess_level(spacing_mode, cur_tess_level_case.inner[1] + 0.1) as f32;
            }
        }

        result.push(cur_tess_level_case);
    }

    debug_assert!(result.len() == raw_tess_level_cases.len());
    result
}

/// `generateReferenceTessCoords`
fn generate_reference_tess_coords(
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    inner_levels: &[f32],
    outer_levels: &[f32],
) -> Vec<[f32; 3]> {
    if is_patch_discarded(primitive_type, outer_levels) {
        return Vec::new();
    }

    match primitive_type {
        TessPrimitiveType::Triangles => {
            let (inner, outer) = clamped_rounded_triangle_tess_levels(spacing_mode, inner_levels, outer_levels);

            if spacing_mode != SpacingMode::Equal {
                // \note For fractional spacing modes, exact results are implementation-defined except in special cases.
                debug_assert!((inner_levels[0] - inner as f32).abs() < 0.001);
                debug_assert!((0..3).all(|i| (outer_levels[i] - outer[i] as f32).abs() < 0.001));
                debug_assert!(inner > 1 || (outer[0] == 1 && outer[1] == 1 && outer[2] == 1));
            }

            generate_reference_triangle_tess_coords(spacing_mode, inner, outer[0], outer[1], outer[2])
        }
        TessPrimitiveType::Quads => {
            let (inner, outer) = clamped_rounded_quad_tess_levels(spacing_mode, inner_levels, outer_levels);

            if spacing_mode != SpacingMode::Equal {
                // \note For fractional spacing modes, exact results are implementation-defined except in special cases.
                debug_assert!((0..2).all(|i| (inner_levels[i] - inner[i] as f32).abs() < 0.001));
                debug_assert!((0..4).all(|i| (outer_levels[i] - outer[i] as f32).abs() < 0.001));
                debug_assert!(
                    (inner[0] > 1 && inner[1] > 1)
                        || (inner[0] == 1
                            && inner[1] == 1
                            && outer[0] == 1
                            && outer[1] == 1
                            && outer[2] == 1
                            && outer[3] == 1)
                );
            }

            generate_reference_quad_tess_coords(
                spacing_mode,
                inner[0],
                inner[1],
                outer[0],
                outer[1],
                outer[2],
                outer[3],
            )
        }
        TessPrimitiveType::Isolines => {
            let outer = clamped_rounded_isoline_tess_levels(spacing_mode, outer_levels);

            if spacing_mode != SpacingMode::Equal {
                // \note For fractional spacing modes, exact results are implementation-defined except in special cases.
                debug_assert!((outer_levels[1] - outer[1] as f32).abs() < 0.001);
            }

            generate_reference_isoline_tess_coords(outer[0], outer[1])
        }
    }
}

/// `binarySearchFirstVec3WithXAtLeast`
fn binary_search_first_vec3_with_x_at_least(sorted: &[[f32; 3]], x: f32) -> Option<usize> {
    let first = sorted.partition_point(|vec| vec[0] < x);
    if first == sorted.len() { None } else { Some(first) }
}

/// `oneWayComparePointSets` - check that all points in subset are (approximately) present also in superset.
fn one_way_compare_point_sets(subset: &[[f32; 3]], superset: &[[f32; 3]]) -> bool {
    let mut superset_sorted = superset.to_vec();
    superset_sorted.sort_by(|a, b| a[0].partial_cmp(&b[0]).unwrap_or(std::cmp::Ordering::Equal));
    let epsilon = 0.01f32;
    let mut num_failures_detected = 0;

    for sub_pt in subset {
        let mut match_found = false;

        {
            // Binary search the index of the first point in supersetSorted with x in the [subPt.x() - epsilon, subPt.x() + epsilon] range.
            let match_min = sub_pt.map(|component| component - epsilon);
            let match_max = sub_pt.map(|component| component + epsilon);

            if let Some(first_candidate_ndx) = binary_search_first_vec3_with_x_at_least(&superset_sorted, match_min[0])
            {
                // Compare subPt to all points in supersetSorted with x in the [subPt.x() - epsilon, subPt.x() + epsilon] range.
                for super_pt in superset_sorted[first_candidate_ndx..]
                    .iter()
                    .take_while(|point| point[0] <= match_max[0])
                {
                    if (0..3).all(|i| super_pt[i] >= match_min[i]) && (0..3).all(|i| super_pt[i] <= match_max[i]) {
                        match_found = true;
                        break;
                    }
                }
            }
        }

        if !match_found {
            num_failures_detected += 1;
        }
    }

    num_failures_detected == 0
}

/// `compareTessCoords` - returns true on matching coordinate sets.
fn compare_tess_coords(ref_coords: &[[f32; 3]], res_coords: &[[f32; 3]]) -> bool {
    // Check that all points in reference also exist in result.
    let reference_in_result = one_way_compare_point_sets(ref_coords, res_coords);
    // Check that all points in result also exist in reference.
    let result_in_reference = one_way_compare_point_sets(res_coords, ref_coords);

    reference_in_result && result_in_reference
}

/// `getTeseName`
fn get_tese_name(write_point_size: bool) -> &'static str {
    if write_point_size { "tese_point_size" } else { "tese" }
}

struct TessCoordTest {
    name: String,
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
    execution_mode_in_evaluation_shader: bool,
}

impl TestCase for TessCoordTest {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TessCoordTest::createInstance`'s `requireFeatures`
    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        let features = context.get_device_features();
        if features.tessellation_shader == vk::FALSE {
            return Err(TestError::NotSupported("Tessellation shader not supported".to_string()));
        }
        if features.vertex_pipeline_stores_and_atomics == vk::FALSE {
            return Err(TestError::NotSupported(
                "Vertex pipeline stores and atomics not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        if !self.execution_mode_in_evaluation_shader {
            return match (self.primitive_type, self.spacing_mode) {
                (TessPrimitiveType::Triangles, SpacingMode::Equal) => {
                    TESSCOORD_TRIANGLES_EQUAL_SPACING_EXECUTION_MODE_IN_TESC.programs
                }
                (TessPrimitiveType::Triangles, SpacingMode::FractionalOdd) => {
                    TESSCOORD_TRIANGLES_FRACTIONAL_ODD_SPACING_EXECUTION_MODE_IN_TESC.programs
                }
                (TessPrimitiveType::Triangles, SpacingMode::FractionalEven) => {
                    TESSCOORD_TRIANGLES_FRACTIONAL_EVEN_SPACING_EXECUTION_MODE_IN_TESC.programs
                }
                (TessPrimitiveType::Quads, SpacingMode::Equal) => {
                    TESSCOORD_QUADS_EQUAL_SPACING_EXECUTION_MODE_IN_TESC.programs
                }
                (TessPrimitiveType::Quads, SpacingMode::FractionalOdd) => {
                    TESSCOORD_QUADS_FRACTIONAL_ODD_SPACING_EXECUTION_MODE_IN_TESC.programs
                }
                (TessPrimitiveType::Quads, SpacingMode::FractionalEven) => {
                    TESSCOORD_QUADS_FRACTIONAL_EVEN_SPACING_EXECUTION_MODE_IN_TESC.programs
                }
                (TessPrimitiveType::Isolines, SpacingMode::Equal) => {
                    TESSCOORD_ISOLINES_EQUAL_SPACING_EXECUTION_MODE_IN_TESC.programs
                }
                (TessPrimitiveType::Isolines, SpacingMode::FractionalOdd) => {
                    TESSCOORD_ISOLINES_FRACTIONAL_ODD_SPACING_EXECUTION_MODE_IN_TESC.programs
                }
                (TessPrimitiveType::Isolines, SpacingMode::FractionalEven) => {
                    TESSCOORD_ISOLINES_FRACTIONAL_EVEN_SPACING_EXECUTION_MODE_IN_TESC.programs
                }
            };
        }
        match (self.primitive_type, self.spacing_mode) {
            (TessPrimitiveType::Triangles, SpacingMode::Equal) => TESSCOORD_TRIANGLES_EQUAL_SPACING.programs,
            (TessPrimitiveType::Triangles, SpacingMode::FractionalOdd) => {
                TESSCOORD_TRIANGLES_FRACTIONAL_ODD_SPACING.programs
            }
            (TessPrimitiveType::Triangles, SpacingMode::FractionalEven) => {
                TESSCOORD_TRIANGLES_FRACTIONAL_EVEN_SPACING.programs
            }
            (TessPrimitiveType::Quads, SpacingMode::Equal) => TESSCOORD_QUADS_EQUAL_SPACING.programs,
            (TessPrimitiveType::Quads, SpacingMode::FractionalOdd) => TESSCOORD_QUADS_FRACTIONAL_ODD_SPACING.programs,
            (TessPrimitiveType::Quads, SpacingMode::FractionalEven) => TESSCOORD_QUADS_FRACTIONAL_EVEN_SPACING.programs,
            (TessPrimitiveType::Isolines, SpacingMode::Equal) => TESSCOORD_ISOLINES_EQUAL_SPACING.programs,
            (TessPrimitiveType::Isolines, SpacingMode::FractionalOdd) => {
                TESSCOORD_ISOLINES_FRACTIONAL_ODD_SPACING.programs
            }
            (TessPrimitiveType::Isolines, SpacingMode::FractionalEven) => {
                TESSCOORD_ISOLINES_FRACTIONAL_EVEN_SPACING.programs
            }
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TessCoordTestInstance {
            context,
            primitive_type: self.primitive_type,
            spacing_mode: self.spacing_mode,
        })
    }
}

struct TessCoordTestInstance<'a> {
    context: &'a Context<'a>,
    primitive_type: TessPrimitiveType,
    spacing_mode: SpacingMode,
}

impl TestInstance for TessCoordTestInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let alloc = context.get_default_allocator();

        // Test data
        let tess_level_cases = gen_tess_level_cases(self.primitive_type, self.spacing_mode);
        let all_reference_tess_coords: Vec<Vec<[f32; 3]>> = tess_level_cases
            .iter()
            .map(|tess_levels| {
                generate_reference_tess_coords(
                    self.primitive_type,
                    self.spacing_mode,
                    &tess_levels.inner,
                    &tess_levels.outer,
                )
            })
            .collect();

        let max_num_vertices = all_reference_tess_coords.iter().map(Vec::len).max().unwrap_or(0);

        // Input buffer: tessellation levels. Data is filled in later.
        let tess_levels_size = std::mem::size_of::<TessLevels>() as vk::DeviceSize;
        let tess_levels_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(tess_levels_size, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Output buffer: number of invocations + padding + tessellation coordinates. Initialized later.
        const RESULT_BUFFER_TESS_COORDS_OFFSET: usize = 4 * std::mem::size_of::<i32>();
        const EXTRANEOUS_VERTICES: usize = 16; // allow some room for extraneous vertices from duplicate shader invocations (number is arbitrary)
        let result_buffer_capacity = max_num_vertices + EXTRANEOUS_VERTICES;
        let result_buffer_size_bytes =
            (RESULT_BUFFER_TESS_COORDS_OFFSET + result_buffer_capacity * 16) as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Descriptors
        let descriptor_set_layout = DescriptorSetLayoutBuilder::new()
            .add_single_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::TESSELLATION_CONTROL,
            )
            .add_single_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            )
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let tess_levels_buffer_info = vk::DescriptorBufferInfo {
            buffer: tess_levels_buffer.get(),
            offset: 0,
            range: tess_levels_size,
        };
        let result_buffer_info = vk::DescriptorBufferInfo {
            buffer: result_buffer.get(),
            offset: 0,
            range: result_buffer_size_bytes,
        };

        DescriptorSetUpdateBuilder::new()
            .write_single(
                descriptor_set.get(),
                Location::binding(0),
                vk::DescriptorType::STORAGE_BUFFER,
                &tess_levels_buffer_info,
            )
            .write_single(
                descriptor_set.get(),
                Location::binding(1),
                vk::DescriptorType::STORAGE_BUFFER,
                &result_buffer_info,
            )
            .update(device);

        // Pipeline: set up vertex processing without rasterization
        let render_pass = make_render_pass_without_attachments(device)?;
        let framebuffer = make_framebuffer(device, *render_pass, &[], 1, 1, 1)?;
        let pipeline_layout = make_pipeline_layout(device, &[*descriptor_set_layout])?;
        let cmd_pool = make_command_pool(device, queue_family_index)?;
        let cmd_buffer = allocate_command_buffer(device, *cmd_pool, vk::CommandBufferLevel::PRIMARY)?;

        let binaries = context.get_binary_collection();
        let vert_module = create_shader_module(device, binaries.get("vert")?)?;
        let tesc_module = create_shader_module(device, binaries.get("tesc")?)?;
        let tese_module = create_shader_module(
            device,
            binaries.get(get_tese_name(
                context
                    .get_device_features()
                    .shader_tessellation_and_geometry_point_size
                    != vk::FALSE,
            ))?,
        )?;

        let mut state = DrawPipelineState::new(vk::PrimitiveTopology::PATCH_LIST).with_full_viewport(1, 1);
        state.patch_control_points = Some(1);
        state.rasterization.rasterizer_discard_enable = vk::TRUE;
        state.color_attachment_count = 0;
        let pipeline = create_draw_pipeline(
            device,
            *pipeline_layout,
            *render_pass,
            &[
                (vk::ShaderStageFlags::VERTEX, *vert_module),
                (vk::ShaderStageFlags::TESSELLATION_CONTROL, *tesc_module),
                (vk::ShaderStageFlags::TESSELLATION_EVALUATION, *tese_module),
            ],
            &state,
        )?;

        let mut num_passed_cases = 0;

        // Repeat the test for all tessellation coords cases
        for (tess_level_case_ndx, tess_levels) in tess_level_cases.iter().enumerate() {
            // Upload tessellation levels data to the input buffer
            {
                let buffer_alloc = tess_levels_buffer.get_allocation();
                unsafe { std::ptr::write_unaligned(buffer_alloc.get_host_ptr().cast::<TessLevels>(), *tess_levels) };
                flush_alloc(device, buffer_alloc)?;
            }

            // Clear the results buffer
            {
                let buffer_alloc = result_buffer.get_allocation();
                unsafe { std::ptr::write_bytes(buffer_alloc.get_host_ptr(), 0, result_buffer_size_bytes as usize) };
                flush_alloc(device, buffer_alloc)?;
            }

            // Reset the command buffer and begin recording.
            begin_command_buffer(device, *cmd_buffer)?;
            let begin_info = vk::RenderPassBeginInfo::builder()
                .render_pass(*render_pass)
                .framebuffer(*framebuffer)
                .render_area(rect_2d(1, 1));
            unsafe {
                device.cmd_begin_render_pass(*cmd_buffer, &begin_info, vk::SubpassContents::INLINE);

                device.cmd_bind_pipeline(*cmd_buffer, vk::PipelineBindPoint::GRAPHICS, *pipeline);
                device.cmd_bind_descriptor_sets(
                    *cmd_buffer,
                    vk::PipelineBindPoint::GRAPHICS,
                    *pipeline_layout,
                    0,
                    &[descriptor_set.get()],
                    &[] as &[u32],
                );

                // Process a single abstract vertex.
                device.cmd_draw(*cmd_buffer, 1, 1, 0, 0);
                device.cmd_end_render_pass(*cmd_buffer);

                let shader_write_barrier = make_buffer_memory_barrier(
                    vk::AccessFlags::SHADER_WRITE,
                    vk::AccessFlags::HOST_READ,
                    result_buffer.get(),
                    0,
                    result_buffer_size_bytes,
                );
                device.cmd_pipeline_barrier(
                    *cmd_buffer,
                    vk::PipelineStageFlags::ALL_GRAPHICS,
                    vk::PipelineStageFlags::HOST,
                    vk::DependencyFlags::empty(),
                    &[] as &[vk::MemoryBarrier],
                    &[shader_write_barrier],
                    &[] as &[vk::ImageMemoryBarrier],
                );
            }
            end_command_buffer(device, *cmd_buffer)?;
            submit_commands_and_wait(device, queue, *cmd_buffer)?;

            // Verify results
            {
                let result_alloc = result_buffer.get_allocation();
                invalidate_alloc(device, result_alloc)?;

                let host_ptr = result_alloc.get_host_ptr();
                let num_results = unsafe { std::ptr::read_unaligned(host_ptr.cast::<i32>()) };
                // A count beyond the buffer would mean the shader wrote past its end; only what fits can be read back.
                let readable_results = (num_results.max(0) as usize).min(result_buffer_capacity);
                let result_tess_coords: Vec<[f32; 3]> = (0..readable_results)
                    .map(|i| {
                        let base = unsafe { host_ptr.add(RESULT_BUFFER_TESS_COORDS_OFFSET + i * 16) }.cast::<f32>();
                        unsafe {
                            [
                                std::ptr::read_unaligned(base),
                                std::ptr::read_unaligned(base.add(1)),
                                std::ptr::read_unaligned(base.add(2)),
                            ]
                        }
                    })
                    .collect();
                let reference_tess_coords = &all_reference_tess_coords[tess_level_case_ndx];
                let num_expected_results = reference_tess_coords.len() as i32;

                if compare_tess_coords(reference_tess_coords, &result_tess_coords)
                    && num_results >= num_expected_results
                {
                    num_passed_cases += 1;
                }
            }
        }

        Ok(if num_passed_cases == tess_level_cases.len() {
            TestStatus::pass("OK")
        } else {
            TestStatus::fail("Some cases have failed")
        })
    }
}

/// `createCoordinatesTests`
pub fn create_coordinates_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("tesscoord");

    for primitive_type in TessPrimitiveType::ALL {
        for spacing_mode in SpacingMode::ALL {
            group.add_child(Box::new(TessCoordTest {
                name: get_case_name(primitive_type, spacing_mode, true),
                primitive_type,
                spacing_mode,
                execution_mode_in_evaluation_shader: true,
            }) as Box<dyn TestCase>);

            // test if TessCoord builtin has correct value in Evaluation shader when execution mode is set only in Control shader
            group.add_child(Box::new(TessCoordTest {
                name: get_case_name(primitive_type, spacing_mode, false),
                primitive_type,
                spacing_mode,
                execution_mode_in_evaluation_shader: false,
            }) as Box<dyn TestCase>);
        }
    }

    group
}
