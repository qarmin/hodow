// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/tessellation/vktTessellationFractionalSpacingTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `hlsl_*` programs come from glslang's HLSL front end; the
// failure messages upstream logs are not produced; the verdicts are the same.
//
// These tests correspond to dEQP-GLES31.functional.tessellation.fractional_spacing.*
// Check validity of fractional spacing modes. Draws a single isoline, reads tess coords with SSBO.

use vulkanalia::prelude::v1_0::*;

use crate::generated::shaders::tessellation_fractional_spacing::{
    FRACTIONAL_SPACING_EVEN, FRACTIONAL_SPACING_HLSL_EVEN, FRACTIONAL_SPACING_HLSL_ODD, FRACTIONAL_SPACING_ODD,
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
    SpacingMode, get_clamped_tess_level, get_rounded_tess_level, make_render_pass_without_attachments,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, Default)]
struct Segment {
    /// Index of left coordinate in sortedXCoords.
    index: i32,
    length: f32,
}

#[derive(Clone, Copy)]
struct LineData {
    tess_level: f32,
    additional_segment_length: f32,
    additional_segment_location: i32,
}

/// Verify fractional spacing conditions for a single line
///
/// Verify that the splitting of an edge (resulting from e.g. an isoline
/// with outer levels { 1.0, tessLevel }) with a given fractional spacing
/// mode fulfills certain conditions given in the spec.
///
/// Note that some conditions can't be checked from just one line
/// (specifically, that the additional segment decreases monotonically
/// length and the requirement that the additional segments be placed
/// identically for identical values of clamped level).
///
/// Therefore, the function returns some values that can later be given to
/// `verify_fractional_spacing_multiple`: the additional segment length and
/// location. A negative value in length means that
/// no additional segments are present, i.e. there's just one segment.
/// A negative value in location means that the value wasn't determinable,
/// i.e. all segments had same length. `None` is a failed verification.
fn verify_fractional_spacing_single(spacing_mode: SpacingMode, tess_level: f32, coords: &[f32]) -> Option<(f32, i32)> {
    debug_assert!(spacing_mode == SpacingMode::FractionalOdd || spacing_mode == SpacingMode::FractionalEven);

    let clamped_level = get_clamped_tess_level(spacing_mode, tess_level);
    let final_level = get_rounded_tess_level(spacing_mode, clamped_level);
    let mut sorted_coords = coords.to_vec();
    sorted_coords.sort_by(|a, b| a.partial_cmp(b).unwrap_or(std::cmp::Ordering::Equal));

    if coords.len() as i32 != final_level + 1 {
        return None;
    }

    if sorted_coords[0] != 0.0 || *sorted_coords.last().expect("non-empty coordinates") != 1.0 {
        return None;
    }

    let segments: Vec<Segment> = (0..final_level)
        .map(|i| Segment {
            index: i,
            length: sorted_coords[i as usize + 1] - sorted_coords[i as usize],
        })
        .collect();

    // Divide segments to two different groups based on length.
    let mut segments_a: Vec<Segment> = vec![segments[0]];
    let mut segments_b: Vec<Segment> = Vec::new();

    for seg in &segments[1..] {
        let epsilon = 0.001f32;

        if (seg.length - segments_a[0].length).abs() < epsilon {
            segments_a.push(*seg);
        } else if segments_b.is_empty() || (seg.length - segments_b[0].length).abs() < epsilon {
            segments_b.push(*seg);
        } else {
            // Couldn't divide segments to 2 groups by length.
            return None;
        }
    }

    // All segments should be of equal length when the clamped and final level are equal.
    if clamped_level == final_level as f32 && !segments_a.is_empty() && !segments_b.is_empty() {
        return None;
    }

    if segments_a.is_empty() || segments_b.is_empty() {
        // All segments have same length. This is ok.
        return Some((if segments.len() == 1 { -1.0 } else { segments[0].length }, -1));
    }

    if segments_a.len() != 2 && segments_b.len() != 2 {
        // When dividing the segments to 2 groups by length, neither of the two groups has exactly 2 or 0 segments in it.
        return None;
    }

    // For convenience, arrange so that the 2-segment group is segmentsB.
    if segments_b.len() != 2 {
        std::mem::swap(&mut segments_a, &mut segments_b);
    }

    // \note For 4-segment lines both segmentsA and segmentsB have 2 segments each.
    //         Thus, we can't be sure which ones were meant as the additional segments.
    //         We give the benefit of the doubt by assuming that they're the shorter
    //         ones (as they should).

    if segments_a.len() != 2 {
        if segments_b[0].length > segments_a[0].length + 0.001 {
            // The two additional segments are longer than the other segments.
            return None;
        }
    } else if segments_b[0].length > segments_a[0].length {
        // We have 2 segmentsA and 2 segmentsB, ensure segmentsB has the shorter lengths
        std::mem::swap(&mut segments_a, &mut segments_b);
    }

    // Check that the additional segments are placed symmetrically.
    if segments_b[0].index + segments_b[1].index + 1 != segments.len() as i32 {
        return None;
    }

    let additional_segment_length = segments_b[0].length;
    let additional_segment_location = if segments_a.len() != 2 || segments_b[0].length < segments_a[0].length - 0.001 {
        segments_b[0].index.min(segments_b[1].index)
    } else {
        -1 // \note -1 when can't reliably decide which ones are the additional segments, a or b.
    };

    Some((additional_segment_length, additional_segment_location))
}

/// Verify fractional spacing conditions between multiple lines
///
/// Verify the fractional spacing conditions that are not checked in
/// `verify_fractional_spacing_single`. Uses values given by said function
/// as parameters, in addition to the spacing mode and tessellation level.
fn verify_fractional_spacing_multiple(
    spacing_mode: SpacingMode,
    tess_levels: &[f32],
    additional_segment_lengths: &[f32],
    additional_segment_locations: &[i32],
) -> bool {
    debug_assert!(spacing_mode == SpacingMode::FractionalOdd || spacing_mode == SpacingMode::FractionalEven);
    debug_assert!(
        tess_levels.len() == additional_segment_lengths.len()
            && tess_levels.len() == additional_segment_locations.len()
    );

    let mut line_datas: Vec<LineData> = (0..tess_levels.len())
        .map(|i| LineData {
            tess_level: tess_levels[i],
            additional_segment_length: additional_segment_lengths[i],
            additional_segment_location: additional_segment_locations[i],
        })
        .collect();

    line_datas.sort_by(|a, b| {
        a.tess_level
            .partial_cmp(&b.tess_level)
            .unwrap_or(std::cmp::Ordering::Equal)
    });
    let line_datas_sorted_by_level = line_datas;

    // Check that lines with identical clamped tessellation levels have identical additionalSegmentLocation.

    for line_ndx in 1..line_datas_sorted_by_level.len() {
        let cur_data = line_datas_sorted_by_level[line_ndx];
        let prev_data = line_datas_sorted_by_level[line_ndx - 1];

        if cur_data.additional_segment_location < 0 || prev_data.additional_segment_location < 0 {
            continue; // Unknown locations, skip.
        }

        if get_clamped_tess_level(spacing_mode, cur_data.tess_level)
            == get_clamped_tess_level(spacing_mode, prev_data.tess_level)
            && cur_data.additional_segment_location != prev_data.additional_segment_location
        {
            return false;
        }
    }

    // Check that, among lines with same clamped rounded tessellation level, additionalSegmentLength is monotonically decreasing with "clampedRoundedTessLevel - clampedTessLevel" (the "fraction").

    for line_ndx in 1..line_datas_sorted_by_level.len() {
        let cur_data = line_datas_sorted_by_level[line_ndx];
        let prev_data = line_datas_sorted_by_level[line_ndx - 1];

        if cur_data.additional_segment_length < 0.0 || prev_data.additional_segment_length < 0.0 {
            continue; // Unknown segment lengths, skip.
        }

        let cur_clamped_level = get_clamped_tess_level(spacing_mode, cur_data.tess_level);
        let prev_clamped_level = get_clamped_tess_level(spacing_mode, prev_data.tess_level);
        let cur_final_level = get_rounded_tess_level(spacing_mode, cur_clamped_level);
        let prev_final_level = get_rounded_tess_level(spacing_mode, prev_clamped_level);

        if cur_final_level != prev_final_level {
            continue;
        }

        if cur_data.additional_segment_length < prev_data.additional_segment_length
            || (cur_clamped_level == prev_clamped_level
                && cur_data.additional_segment_length != prev_data.additional_segment_length)
        {
            return false;
        }
    }

    true
}

/// `genTessLevelCases`
fn gen_tess_level_cases() -> Vec<f32> {
    let mut result = Vec::new();

    // Ranges [7.0 .. 8.0), [8.0 .. 9.0) and [9.0 .. 10.0)
    {
        let range_starts = [7.0f32, 8.0, 9.0];
        let num_samples_per_range = 10;

        for range_start in range_starts {
            for i in 0..num_samples_per_range {
                result.push(range_start + i as f32 / num_samples_per_range as f32);
            }
        }
    }

    // 0.3, 1.3, 2.3,  ... , 62.3
    for i in 0..=62 {
        result.push(i as f32 + 0.3);
    }

    result
}

struct FractionalSpacingTest {
    name: &'static str,
    spacing_mode: SpacingMode,
    hlsl: bool,
}

impl TestCase for FractionalSpacingTest {
    fn name(&self) -> &str {
        self.name
    }

    /// The `requireFeatures` of upstream's `test`.
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
        match (self.hlsl, self.spacing_mode == SpacingMode::FractionalOdd) {
            (false, true) => FRACTIONAL_SPACING_ODD.programs,
            (false, false) => FRACTIONAL_SPACING_EVEN.programs,
            (true, true) => FRACTIONAL_SPACING_HLSL_ODD.programs,
            (true, false) => FRACTIONAL_SPACING_HLSL_EVEN.programs,
        }
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(FractionalSpacingInstance {
            context,
            spacing_mode: self.spacing_mode,
        })
    }
}

struct FractionalSpacingInstance<'a> {
    context: &'a Context<'a>,
    spacing_mode: SpacingMode,
}

impl TestInstance for FractionalSpacingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        let context = self.context;
        let spacing_mode = self.spacing_mode;
        let device = context.get_device();
        let queue = context.get_universal_queue();
        let queue_family_index = context.get_universal_queue_family_index();
        let alloc = context.get_default_allocator();
        let tess_geom_point_size = context
            .get_device_features()
            .shader_tessellation_and_geometry_point_size
            != vk::FALSE;

        let tess_level_cases = gen_tess_level_cases();
        let max_tess_level = tess_level_cases.iter().copied().fold(f32::MIN, f32::max);
        let max_num_vertices =
            1 + get_rounded_tess_level(spacing_mode, get_clamped_tess_level(spacing_mode, max_tess_level)) as usize;

        // Counter buffer: used to calculate offset into result buffer.
        let counter_buffer_size_bytes = std::mem::size_of::<i32>() as vk::DeviceSize;
        let counter_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(counter_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Result buffer: generated tess coords go here.
        let result_buffer_size_bytes = (std::mem::size_of::<f32>() * max_num_vertices) as vk::DeviceSize;
        let result_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(result_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
            MemoryRequirement::HOST_VISIBLE,
        )?;

        // Outer1 tessellation level constant buffer.
        let tess_levels_buffer_size_bytes = std::mem::size_of::<f32>() as vk::DeviceSize; // we pass only outer1
        let tess_levels_buffer = BufferWithMemory::new(
            device,
            alloc,
            make_buffer_create_info(tess_levels_buffer_size_bytes, vk::BufferUsageFlags::STORAGE_BUFFER),
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
            .add_single_binding(
                vk::DescriptorType::STORAGE_BUFFER,
                vk::ShaderStageFlags::TESSELLATION_EVALUATION,
            )
            .build(device)?;
        let descriptor_pool = DescriptorPoolBuilder::new()
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .add_type(vk::DescriptorType::STORAGE_BUFFER, 1)
            .build(device, vk::DescriptorPoolCreateFlags::FREE_DESCRIPTOR_SET, 1)?;
        let descriptor_set = make_descriptor_set(device, *descriptor_pool, *descriptor_set_layout)?;

        let tess_levels_buffer_info = vk::DescriptorBufferInfo {
            buffer: tess_levels_buffer.get(),
            offset: 0,
            range: tess_levels_buffer_size_bytes,
        };
        let result_buffer_info = vk::DescriptorBufferInfo {
            buffer: result_buffer.get(),
            offset: 0,
            range: result_buffer_size_bytes,
        };
        let counter_buffer_info = vk::DescriptorBufferInfo {
            buffer: counter_buffer.get(),
            offset: 0,
            range: counter_buffer_size_bytes,
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
            .write_single(
                descriptor_set.get(),
                Location::binding(2),
                vk::DescriptorType::STORAGE_BUFFER,
                &counter_buffer_info,
            )
            .update(device);

        // Pipeline
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
            binaries.get(if tess_geom_point_size {
                "tese_point_size"
            } else {
                "tese"
            })?,
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

        // Data that will be verified across all cases
        let mut additional_segment_lengths: Vec<f32> = Vec::new();
        let mut additional_segment_locations: Vec<i32> = Vec::new();

        let mut success = false;

        // Repeat the test for all tessellation coords cases
        for &tess_level in &tess_level_cases {
            // Upload tessellation levels data to the input buffer
            {
                let buffer_alloc = tess_levels_buffer.get_allocation();
                unsafe { std::ptr::write_unaligned(buffer_alloc.get_host_ptr().cast::<f32>(), tess_level) };
                flush_alloc(device, buffer_alloc)?;
            }

            // Clear the results buffer
            {
                let buffer_alloc = result_buffer.get_allocation();
                unsafe { std::ptr::write_bytes(buffer_alloc.get_host_ptr(), 0, result_buffer_size_bytes as usize) };
                flush_alloc(device, buffer_alloc)?;
            }

            // Clear the counter buffer
            {
                let buffer_alloc = counter_buffer.get_allocation();
                unsafe { std::ptr::write_bytes(buffer_alloc.get_host_ptr(), 0, counter_buffer_size_bytes as usize) };
                flush_alloc(device, buffer_alloc)?;
            }

            begin_command_buffer(device, *cmd_buffer)?;

            // Begin render pass
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

            // Verify the result.
            {
                let result_alloc = result_buffer.get_allocation();
                let counter_alloc = counter_buffer.get_allocation();

                invalidate_alloc(device, result_alloc)?;
                invalidate_alloc(device, counter_alloc)?;

                let num_results = unsafe { std::ptr::read_unaligned(counter_alloc.get_host_ptr().cast::<i32>()) };
                // A count beyond the buffer would mean the shader wrote past its end; only what fits can be read back.
                let readable_results = (num_results.max(0) as usize).min(max_num_vertices);
                let result_tess_coords: Vec<f32> = (0..readable_results)
                    .map(|i| unsafe { std::ptr::read_unaligned(result_alloc.get_host_ptr().cast::<f32>().add(i)) })
                    .collect();

                success = false;
                if readable_results as i32 == num_results
                    && let Some((additional_segment_length, additional_segment_location)) =
                        verify_fractional_spacing_single(spacing_mode, tess_level, &result_tess_coords)
                {
                    additional_segment_lengths.push(additional_segment_length);
                    additional_segment_locations.push(additional_segment_location);
                    success = true;
                }

                if !success {
                    break;
                }
            }
        }

        if success {
            success = verify_fractional_spacing_multiple(
                spacing_mode,
                &tess_level_cases,
                &additional_segment_lengths,
                &additional_segment_locations,
            );
        }

        Ok(if success {
            TestStatus::pass("OK")
        } else {
            TestStatus::fail("Failure")
        })
    }
}

/// `createFractionalSpacingTests`
pub fn create_fractional_spacing_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fractional_spacing");

    for (name, spacing_mode, hlsl) in [
        ("glsl_odd", SpacingMode::FractionalOdd, false),
        ("glsl_even", SpacingMode::FractionalEven, false),
        ("hlsl_odd", SpacingMode::FractionalOdd, true),
        ("hlsl_even", SpacingMode::FractionalEven, true),
    ] {
        group.add_child(Box::new(FractionalSpacingTest {
            name,
            spacing_mode,
            hlsl,
        }) as Box<dyn TestCase>);
    }

    group
}
